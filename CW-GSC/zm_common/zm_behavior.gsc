/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_behavior.gsc
***********************************************/

#using script_1940fc077a028a81;
#using script_2c5daa95f8fec03c;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_35b8a6927c851193;
#using script_3a88f428c6d8ef90;
#using script_5f261a5d57de5f7c;
#using scripts\abilities\gadgets\gadget_cymbal_monkey;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\zm\recon_car;
#using scripts\weapons\nightingale;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_attackables;
#using scripts\zm_common\zm_behavior_utility;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_behavior;

function preinit() {
  initzmbehaviorsandasm();

  if(!isDefined(level.zigzag_activation_distance)) {
    level.zigzag_activation_distance = 175;
  }

  if(!isDefined(level.zigzag_distance_min)) {
    level.zigzag_distance_min = 256;
  }

  if(!isDefined(level.zigzag_distance_max)) {
    level.zigzag_distance_max = 400;
  }

  if(!isDefined(level.inner_zigzag_radius)) {
    level.inner_zigzag_radius = 16;
  }

  if(!isDefined(level.outer_zigzag_radius)) {
    level.outer_zigzag_radius = 128;
  }

  zm_utility::function_d0f02e71(#"zombie");
  spawner::add_archetype_spawn_function(#"zombie", &function_c15c6e44);
  spawner::add_archetype_spawn_function(#"zombie", &zombiespawninit);
  spawner::function_89a2cd87(#"zombie", &function_823a8ebd);
  level.do_randomized_zigzag_path = 1;
  level.zombie_targets = [];
  zm::register_actor_damage_callback(&function_7994fd99, 1);
  zm::register_zombie_damage_override_callback(&function_95578a3c);
  level.var_56f626bc = &function_ac6dcd03;
  level.var_1b01acb4 = &function_c5a2dbe5;
}

function private zombiespawninit() {
  self pushplayer(0);
  self collidewithactors(0);
  self thread zm_utility::function_13cc9756();
  self.closest_player_override = &zm_utility::function_3d70ba7a;
  self.var_1731eda3 = 1;
  self.am_i_valid = 1;
  self.cant_move_cb = &zombiebehavior::function_22762653;
  self ai::set_behavior_attribute("use_attackable", 1);
  self callback::function_d8abfc3d(#"hash_1eda827ff5e6895b", &function_ff987791);
  self callback::function_d8abfc3d(#"hash_210adcf09e99fba1", &function_618ab591);
  self callback::function_d8abfc3d(#"hash_1518febf00439d5", &function_8b5bbd69);
  self callback::function_d8abfc3d(#"hash_34b65342cbfdadac", &function_c35ce53f);
  self zm_spawner::zombie_spawn_init();
}

function private function_823a8ebd() {
  function_cea9ab47(self);
  self.var_318a0ac8 = &function_29c1ba76;
}

function function_ff987791(params) {
  if(isDefined(self.damageweapon) && self.damageweapon === getweapon(#"eq_slow_grenade")) {
    self clientfield::set("stunned_head_fx", 1);
  }
}

function function_618ab591(params) {
  self clientfield::set("stunned_head_fx", 0);
}

function function_8b5bbd69(params) {
  self endon(#"hash_7aba28bf3e3cf9cd", #"death");
  traversalstartpos = self.traversalstartpos;
  traversalendpos = self.traversalendpos;
  traversalstartnode = self.traversestartnode;
  aitype = self.aitype;
  wait 10;

  if(isDefined(traversalendpos)) {
    self forceteleport(traversalendpos);
  }

  if(getdvarint(#"hash_704243ad84566af7", 1) && isDefined(traversalendpos) && isDefined(traversalstartpos) && isDefined(aitype)) {
    var_96c5333a = !isDefined(traversalstartnode);

    if(!var_96c5333a) {
      eventparams = {
        #spawner_name: hash(aitype), #var_83e229fa: traversalstartpos[0], #var_753e8ca7: traversalstartpos[1], #var_83cf29c8: traversalstartpos[2], #var_f774409e: traversalendpos[0], #var_40385225: traversalendpos[1], #var_340139b7: traversalendpos[2], #var_b5b65b52: traversalstartnode.origin[0], #var_3524da39: traversalstartnode.origin[1], #var_23deb7ad: traversalstartnode.origin[2]
      };
      function_92d1707f(#"hash_6ec90ea3ba426491", eventparams);
    } else {
      eventparams = {
        #spawner_name: hash(aitype), #var_83e229fa: traversalstartpos[0], #var_753e8ca7: traversalstartpos[1], #var_83cf29c8: traversalstartpos[2], #var_f774409e: traversalendpos[0], #var_40385225: traversalendpos[1], #var_340139b7: traversalendpos[2]
      };
      function_92d1707f(#"hash_1bf75b08b5ca39a9", eventparams);
    }
  }

  self finishtraversal();
}

function function_c35ce53f(params) {
  function_d42e5f5b(params);

  if(self function_dd070839()) {
    self clearpath();
  }
}

function function_d42e5f5b(params) {
  self notify(#"hash_7aba28bf3e3cf9cd");
}

function private function_c15c6e44() {
  self endon(#"death");
  self waittill(#"completed_emerging_into_playable_area");
  self.var_641025d6 = gettime() + self ai::function_9139c839().var_9c0ebe1e;
}

function postinit() {
  array::thread_all(level.zombie_spawners, &spawner::add_spawn_function, &function_d63f6426);
}

function function_d63f6426() {
  if(!isDefined(self._starting_round_number)) {
    self zm_cleanup::function_aa5726f2();
  }

  self zm_utility::init_zombie_run_cycle();
  self thread zm_spawner::zombie_think();

  if(isDefined(level._zombie_custom_spawn_logic)) {
    if(isarray(level._zombie_custom_spawn_logic)) {
      for(i = 0; i < level._zombie_custom_spawn_logic.size; i++) {
        self thread[[level._zombie_custom_spawn_logic[i]]]();
      }
    } else {
      self thread[[level._zombie_custom_spawn_logic]]();
    }
  }

  if(isDefined(level.zombie_init_done)) {
    self[[level.zombie_init_done]]();
  }

  self.zombie_init_done = 1;
  self zm_score::function_82732ced();
  self notify(#"zombie_init_done");
}

function private initzmbehaviorsandasm() {
  assert(iscodefunctionptr(&function_3227edfe));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_14f90f9369756366", &function_3227edfe);
  assert(isscriptfunctionptr(&shouldmovecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmove", &shouldmovecondition);
  assert(isscriptfunctionptr(&zombieshouldtearcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldtear", &zombieshouldtearcondition);
  assert(isscriptfunctionptr(&zombieshouldattackthroughboardscondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldattackthroughboards", &zombieshouldattackthroughboardscondition);
  assert(isscriptfunctionptr(&zombieshouldattackthroughboardscondition));
  behaviorstatemachine::registerbsmscriptapiinternal(#"zombieshouldattackthroughboards", &zombieshouldattackthroughboardscondition);
  assert(isscriptfunctionptr(&zombieshouldtauntcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldtaunt", &zombieshouldtauntcondition);
  assert(isscriptfunctionptr(&zombieshouldtauntcondition));
  behaviorstatemachine::registerbsmscriptapiinternal(#"zombieshouldtaunt", &zombieshouldtauntcondition);
  assert(isscriptfunctionptr(&zombiegottoentrancecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegottoentrance", &zombiegottoentrancecondition);
  assert(isscriptfunctionptr(&zombiegottoattackspotcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegottoattackspot", &zombiegottoattackspotcondition);
  assert(isscriptfunctionptr(&zombiehasattackspotalreadycondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiehasattackspotalready", &zombiehasattackspotalreadycondition);
  assert(isscriptfunctionptr(&zombiehasattackspotalreadycondition));
  behaviorstatemachine::registerbsmscriptapiinternal(#"zombiehasattackspotalready", &zombiehasattackspotalreadycondition);
  assert(isscriptfunctionptr(&zombieshouldenterplayablecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldenterplayable", &zombieshouldenterplayablecondition);
  assert(isscriptfunctionptr(&ischunkvalidcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"ischunkvalid", &ischunkvalidcondition);
  assert(isscriptfunctionptr(&ischunkvalidcondition));
  behaviorstatemachine::registerbsmscriptapiinternal(#"ischunkvalid", &ischunkvalidcondition);
  assert(isscriptfunctionptr(&inplayablearea));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"inplayablearea", &inplayablearea);
  assert(isscriptfunctionptr(&shouldskipteardown));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldskipteardown", &shouldskipteardown);
  assert(isscriptfunctionptr(&zombieisthinkdone));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisthinkdone", &zombieisthinkdone);
  assert(isscriptfunctionptr(&zombieisatgoal));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisatgoal", &zombieisatgoal);
  assert(isscriptfunctionptr(&zombieisatgoal));
  behaviorstatemachine::registerbsmscriptapiinternal(#"zombieisatgoal", &zombieisatgoal);
  assert(isscriptfunctionptr(&zombieisatentrance));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisatentrance", &zombieisatentrance);
  assert(isscriptfunctionptr(&function_4c12882b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_626619641083db91", &function_4c12882b);
  assert(isscriptfunctionptr(&function_4c12882b));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_626619641083db91", &function_4c12882b);
  assert(isscriptfunctionptr(&function_b86a1b9d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_150eeb42b488a14e", &function_b86a1b9d);
  assert(isscriptfunctionptr(&function_b86a1b9d));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_150eeb42b488a14e", &function_b86a1b9d);
  assert(isscriptfunctionptr(&function_e7f2e349));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3f46416df5ad6e3e", &function_e7f2e349);
  assert(isscriptfunctionptr(&function_e7f2e349));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3f46416df5ad6e3e", &function_e7f2e349);
  assert(isscriptfunctionptr(&function_45009145));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2a86b9d29348a4df", &function_45009145);
  assert(isscriptfunctionptr(&function_a5a66d65));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_f8bf19d37668bca", &function_a5a66d65);
  assert(isscriptfunctionptr(&zombieshouldmoveawaycondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmoveaway", &zombieshouldmoveawaycondition);
  assert(isscriptfunctionptr(&waskilledbyteslacondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"waskilledbytesla", &waskilledbyteslacondition);
  assert(isscriptfunctionptr(&function_a00b473a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3cf91e708d0422b", &function_a00b473a);
  assert(isscriptfunctionptr(&function_8396494f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_176a3ec851460d73", &function_8396494f);
  assert(isscriptfunctionptr(&zombieshouldstun));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldstun", &zombieshouldstun);
  assert(isscriptfunctionptr(&zombieisbeinggrappled));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisbeinggrappled", &zombieisbeinggrappled);
  assert(isscriptfunctionptr(&zombieshouldknockdown));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldknockdown", &zombieshouldknockdown);
  assert(isscriptfunctionptr(&function_6a690c50));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6a8d81f5eda48d2", &function_6a690c50);
  assert(isscriptfunctionptr(&zombieispushed));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieispushed", &zombieispushed);
  assert(isscriptfunctionptr(&zombiekilledwhilegettingpulled));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiekilledwhilegettingpulled", &zombiekilledwhilegettingpulled);
  assert(isscriptfunctionptr(&zombiekilledbyblackholebombcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiekilledbyblackholebombcondition", &zombiekilledbyblackholebombcondition);
  assert(isscriptfunctionptr(&function_38fec26f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_18fea53546637859", &function_38fec26f);
  assert(isscriptfunctionptr(&function_e4d7303f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_32d8ffc79910d80b", &function_e4d7303f);
  assert(isscriptfunctionptr(&function_17cd1b17));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1da059a5800a95c5", &function_17cd1b17);
  assert(isscriptfunctionptr(&zmzombieshouldmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zmzombieshouldmelee", &zmzombieshouldmelee);
  assert(isscriptfunctionptr(&function_d8b225ae));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_651ab332997a387f", &function_d8b225ae);
  assert(isscriptfunctionptr(&function_cbb1e2bb));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_389ee9c3a9dad550", &function_cbb1e2bb);
  assert(isscriptfunctionptr(&function_22d21726));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_78381576f7e7e507", &function_22d21726);
  assert(isscriptfunctionptr(&disablepowerups));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"disablepowerups", &disablepowerups);
  assert(isscriptfunctionptr(&enablepowerups));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"enablepowerups", &enablepowerups);
  assert(isscriptfunctionptr(&function_77a0b45d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7acebd497b8032d5", &function_77a0b45d);
  assert(isscriptfunctionptr(&function_fa2814ae));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6f98de025a95b79a", &function_fa2814ae);
  assert(!isDefined(&zombiemovetoentranceaction) || isscriptfunctionptr(&zombiemovetoentranceaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombiemovetoentranceactionterminate) || isscriptfunctionptr(&zombiemovetoentranceactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemovetoentranceaction", &zombiemovetoentranceaction, undefined, &zombiemovetoentranceactionterminate);
  assert(!isDefined(&zombiemovetoattackspotaction) || isscriptfunctionptr(&zombiemovetoattackspotaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombiemovetoattackspotactionterminate) || isscriptfunctionptr(&zombiemovetoattackspotactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemovetoattackspotaction", &zombiemovetoattackspotaction, undefined, &zombiemovetoattackspotactionterminate);
  assert(isscriptfunctionptr(&function_6eb4f847));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5a7ebfd6f2aaad7b", &function_6eb4f847);
  assert(isscriptfunctionptr(&function_547701ae));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3006c33ad53fb0be", &function_547701ae);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombieidleaction", undefined, undefined, undefined);
  assert(!isDefined(&zombiemoveaway) || isscriptfunctionptr(&zombiemoveaway));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemoveaway", &zombiemoveaway, undefined, undefined);
  assert(!isDefined(&zombietraverseaction) || isscriptfunctionptr(&zombietraverseaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombietraverseactionterminate) || isscriptfunctionptr(&zombietraverseactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombietraverseaction", &zombietraverseaction, undefined, &zombietraverseactionterminate);
  assert(isscriptfunctionptr(&function_35228e0b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_650bbf762c6db9e5", &function_35228e0b);
  assert(isscriptfunctionptr(&function_ed33f941));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_461b5bd517dbe56", &function_ed33f941);
  assert(!isDefined(&zombieholdboardaction) || isscriptfunctionptr(&zombieholdboardaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombieholdboardactionterminate) || isscriptfunctionptr(&zombieholdboardactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"holdboardaction", &zombieholdboardaction, undefined, &zombieholdboardactionterminate);
  assert(!isDefined(&zombiegrabboardaction) || isscriptfunctionptr(&zombiegrabboardaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombiegrabboardactionterminate) || isscriptfunctionptr(&zombiegrabboardactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"grabboardaction", &zombiegrabboardaction, undefined, &zombiegrabboardactionterminate);
  assert(isscriptfunctionptr(&function_66a8aef2));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2c6c8e7fbe32827d", &function_66a8aef2);
  assert(isscriptfunctionptr(&function_16251b30));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7b8b6e4f20e7c65c", &function_16251b30);
  assert(!isDefined(&zombiepullboardaction) || isscriptfunctionptr(&zombiepullboardaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombiepullboardactionterminate) || isscriptfunctionptr(&zombiepullboardactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"pullboardaction", &zombiepullboardaction, undefined, &zombiepullboardactionterminate);
  assert(isscriptfunctionptr(&function_aa76355a));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6e6a6ae6dbfda8b6", &function_aa76355a);
  assert(isscriptfunctionptr(&function_76d619c8));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_61d9bc9bf2de7261", &function_76d619c8);
  assert(isscriptfunctionptr(&barricadebreakterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi("barricadeBreakTerminate", &barricadebreakterminate);
  assert(!isDefined(&zombieattackthroughboardsaction) || isscriptfunctionptr(&zombieattackthroughboardsaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombieattackthroughboardsactionterminate) || isscriptfunctionptr(&zombieattackthroughboardsactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombieattackthroughboardsaction", &zombieattackthroughboardsaction, undefined, &zombieattackthroughboardsactionterminate);
  assert(isscriptfunctionptr(&function_ebba4d65));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5cf57595a9a7f525", &function_ebba4d65);
  assert(isscriptfunctionptr(&function_28b47cc8));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1b4d2e123def1564", &function_28b47cc8);
  assert(!isDefined(&zombietauntaction) || isscriptfunctionptr(&zombietauntaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombietauntactionterminate) || isscriptfunctionptr(&zombietauntactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombietauntaction", &zombietauntaction, undefined, &zombietauntactionterminate);
  assert(isscriptfunctionptr(&function_eb270aac));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5d23aebf14e71bd5", &function_eb270aac);
  assert(isscriptfunctionptr(&function_ba06c8a0));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5e8abe4da3ebfbd4", &function_ba06c8a0);
  assert(!isDefined(&zombiemantleaction) || isscriptfunctionptr(&zombiemantleaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombiemantleactionterminate) || isscriptfunctionptr(&zombiemantleactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemantleaction", &zombiemantleaction, undefined, &zombiemantleactionterminate);
  assert(!isDefined(&zombiestunactionstart) || isscriptfunctionptr(&zombiestunactionstart));
  assert(!isDefined(&function_4e52c07) || isscriptfunctionptr(&function_4e52c07));
  assert(!isDefined(&zombiestunactionend) || isscriptfunctionptr(&zombiestunactionend));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombiestunaction", &zombiestunactionstart, &function_4e52c07, &zombiestunactionend);
  assert(isscriptfunctionptr(&zombiestunstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestunstart", &zombiestunstart);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_4e52c07) || isscriptfunctionptr(&function_4e52c07));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombiestunactionloop", undefined, &function_4e52c07, undefined);
  assert(isscriptfunctionptr(&function_c377438f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5cae731c54d7a310", &function_c377438f);
  assert(isscriptfunctionptr(&function_7531db00));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3ec08de422ecdfa7", &function_7531db00);
  assert(isscriptfunctionptr(&function_7531db00));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3ec08de422ecdfa7", &function_7531db00);
  assert(isscriptfunctionptr(&function_1329e086));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_cf69ce67c8c33fc", &function_1329e086);
  assert(isscriptfunctionptr(&function_1329e086));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_cf69ce67c8c33fc", &function_1329e086);
  assert(isscriptfunctionptr(&zombiegrappleactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegrappleactionstart", &zombiegrappleactionstart);
  assert(isscriptfunctionptr(&zombieknockdownactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieknockdownactionstart", &zombieknockdownactionstart);
  assert(isscriptfunctionptr(&function_c8939973));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_a6273a84b4237ce", &function_c8939973);
  assert(isscriptfunctionptr(&zombiepushedactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiepushedactionstart", &zombiepushedactionstart);
  assert(isscriptfunctionptr(&zombiepushedactionterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiepushedactionterminate", &zombiepushedactionterminate);
  assert(isscriptfunctionptr(&function_289cdbab));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_28b48f7b24f5245b", &function_289cdbab);
  assert(isscriptfunctionptr(&function_6560f92b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_75445a35d37e78e0", &function_6560f92b);
  assert(!isDefined(&zombieblackholebombpullstart) || isscriptfunctionptr(&zombieblackholebombpullstart));
  assert(!isDefined(&zombieblackholebombpullupdate) || isscriptfunctionptr(&zombieblackholebombpullupdate));
  assert(!isDefined(&zombieblackholebombpullend) || isscriptfunctionptr(&zombieblackholebombpullend));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombieblackholebombpullaction", &zombieblackholebombpullstart, &zombieblackholebombpullupdate, &zombieblackholebombpullend);
  assert(!isDefined(&zombiekilledbyblackholebombstart) || isscriptfunctionptr(&zombiekilledbyblackholebombstart));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombiekilledbyblackholebombend) || isscriptfunctionptr(&zombiekilledbyblackholebombend));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombieblackholebombdeathaction", &zombiekilledbyblackholebombstart, undefined, &zombiekilledbyblackholebombend);
  assert(isscriptfunctionptr(&function_b654f4f5));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2574c98f8c8e07ea", &function_b654f4f5);
  assert(isscriptfunctionptr(&function_36b3cb7d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_65c425729831f505", &function_36b3cb7d);
  assert(isscriptfunctionptr(&getchunkservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"getchunkservice", &getchunkservice);
  assert(isscriptfunctionptr(&function_38237e30));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4dde9e6bcca48bcb", &function_38237e30);
  assert(isscriptfunctionptr(&updatechunkservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"updatechunkservice", &updatechunkservice);
  assert(isscriptfunctionptr(&updateattackspotservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"updateattackspotservice", &updateattackspotservice);
  assert(isscriptfunctionptr(&function_b3311a1a));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_24d32558bbe4dd3b", &function_b3311a1a);
  assert(isscriptfunctionptr(&findnodesservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"findnodesservice", &findnodesservice);
  assert(isscriptfunctionptr(&function_92d348e2));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7f1ef64b934748c3", &function_92d348e2);
  assert(isscriptfunctionptr(&function_4180f67));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_74a2d8577b2cd1", &function_4180f67, 2);
  var_6f1f5692 = zm_utility::is_survival() ? 5 : 10;
  assert(isscriptfunctionptr(&function_754be649));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5b9e89679b8c51f9", &function_754be649, var_6f1f5692);
  assert(isscriptfunctionptr(&function_fae6123));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_52ef96cc6c0bfb77", &function_fae6123, 20);
  assert(isscriptfunctionptr(&zombieattackableobjectservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieattackableobjectservice", &zombieattackableobjectservice, 4);
  assert(isscriptfunctionptr(&function_fb814207));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiefindfleshservice", &function_fb814207, 3);
  assert(isscriptfunctionptr(&function_f637b05d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_712f0844b14c72fe", &function_f637b05d, 1);
  assert(isscriptfunctionptr(&function_483766be));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3a0b725ea5525c8d", &function_483766be, 1);
  assert(isscriptfunctionptr(&zombieenteredplayable));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieenteredplayableservice", &zombieenteredplayable);
  animationstatenetwork::registeranimationmocomp("mocomp_board_tear@zombie", &boardtearmocompstart, &boardtearmocompupdate, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_barricade_enter@zombie", &barricadeentermocompstart, &barricadeentermocompupdate, &barricadeentermocompterminate);
  animationstatenetwork::registeranimationmocomp("mocomp_barricade_enter_no_z@zombie", &barricadeentermocompnozstart, &barricadeentermocompnozupdate, &barricadeentermocompnozterminate);
  animationstatenetwork::registernotetrackhandlerfunction("destroy_piece", &notetrackboardtear);
  animationstatenetwork::registernotetrackhandlerfunction("zombie_window_melee", &notetrackboardmelee);
  animationstatenetwork::registernotetrackhandlerfunction("smash_board", &function_b37b8c0d);
  animationstatenetwork::registernotetrackhandlerfunction("bhb_burst", &zombiebhbburst);
  animationstatenetwork::registernotetrackhandlerfunction("freezegun_hide", &function_36b3cb7d);
}

function function_cbb1e2bb(entity) {
  if(!is_true(self.missinglegs) || !gibserverutils::isgibbed(entity, 128) && !gibserverutils::isgibbed(entity, 256) || !isDefined(self.var_177172b0) || gettime() - self.var_177172b0 < int(0.2 * 1000)) {
    return false;
  }

  return true;
}

function function_d8b225ae(entity) {
  if(!isDefined(entity.attackable)) {
    return false;
  }

  if(isDefined(entity.var_8a3828c6)) {
    return false;
  }

  radius = entity.goalradius;

  if(is_true(entity.allowoffnavmesh)) {
    radius = 16;
  }

  if(isDefined(entity.var_b238ef38) && distance2dsquared(entity.origin, entity.var_b238ef38.position) < sqr(radius) && abs(entity.origin[2] - entity.var_b238ef38.position[2]) < 50) {
    return true;
  }

  return false;
}

function function_4180f67(entity) {
  entity.var_2d78e306 = 0;
  entity.var_b719e78 = 1;

  if(is_true(entity.var_4c85ebad)) {
    entity.var_2d78e306 = 1;
    return true;
  }

  if(isDefined(entity.enemy_override)) {
    entity.var_b719e78 = 0;
    return true;
  }

  if(function_d8b225ae(entity)) {
    entity.var_2d78e306 = 1;
    return true;
  }

  if(is_true(entity.ignoremelee)) {
    entity.var_b719e78 = 0;
    return true;
  }

  return true;
}

function function_754be649(entity) {
  entity.var_85cea06c = 0;
  entity.var_d1bb0ad = 1;

  if(!isDefined(entity.enemy)) {
    entity.var_d1bb0ad = 0;
    return true;
  }

  if(!namespace_85745671::is_player_valid(entity.enemy) && !namespace_85745671::function_1b9ed9b0(entity.enemy) && !namespace_85745671::function_65e1fbbe(entity.enemy) && entity.team === level.zombie_team) {
    entity.var_d1bb0ad = 0;
    return true;
  }

  entity.meleedistsq = zombiebehavior::function_997f1224(entity);
  entity.var_5a81324d = undefined;
  entity.var_b3538985 = entity.enemy.origin;

  if(isPlayer(entity.enemy) || is_true(entity.enemy.is_companion)) {
    if(!is_true(zm_utility::is_classic())) {
      if(namespace_85745671::function_142c3c86(entity.enemy)) {
        entity.var_5a81324d = entity.enemy getvehicleoccupied();
        entity.var_b3538985 = namespace_85745671::function_401070dd(entity.var_5a81324d, entity.enemy);
      } else if(isvehicle(entity.enemy getgroundent())) {
        entity.var_5a81324d = entity.enemy getgroundent();
        entity.var_b3538985 = isDefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin;
      } else if(isvehicle(entity.enemy getmoverent())) {
        entity.var_5a81324d = entity.enemy getmoverent();
        entity.var_b3538985 = isDefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin;
      }
    }

    if(isDefined(entity.var_5a81324d) && isDefined(entity.var_cbc65493)) {
      entity.meleedistsq *= entity.var_cbc65493;
    }
  }

  if(is_true(self.isonnavmesh) && !tracepassedonnavmesh(entity.origin, isDefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin, entity.enemy getpathfindingradius())) {
    entity.var_d1bb0ad = 0;
    return true;
  }

  return true;
}

function function_fae6123(entity) {
  entity.var_2fe49a8a = 0;
  entity.var_e8e74caf = 1;

  if(isDefined(entity.zombie_poi)) {
    entity.var_e8e74caf = 0;
    return true;
  }

  if(isDefined(entity.enemy_override)) {
    entity.var_e8e74caf = 0;
    return true;
  }

  if(isDefined(entity.var_b3538985) && isDefined(entity.enemy)) {
    if(abs(entity.origin[2] - entity.var_b3538985[2]) > (isDefined(entity.var_737e8510) ? entity.var_737e8510 : 64)) {
      entity.var_e8e74caf = 0;
      return true;
    }

    if(distancesquared(entity.origin, entity.var_b3538985) > entity.meleedistsq) {
      entity.var_e8e74caf = 0;
      return true;
    }

    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);

    if(abs(yawtoenemy) > (isDefined(entity.var_1c0eb62a) ? entity.var_1c0eb62a : 60)) {
      entity.var_e8e74caf = 0;
      return true;
    }

    if(isDefined(entity.var_5a81324d)) {
      if(isPlayer(entity.enemy) && entity.enemy getvehicleoccupied() === entity.var_5a81324d && !entity namespace_85745671::function_98e73b11(entity.var_5a81324d)) {
        entity.var_e8e74caf = 0;
        return true;
      }
    }

    if(distancesquared(entity.origin, entity.var_b3538985) < sqr(40) && (!isPlayer(entity.enemy) || !entity.enemy.ignoreme && !entity.enemy isnotarget())) {
      entity.var_2fe49a8a = 1;
      return true;
    }

    if(!isPlayer(entity.enemy) || entity.enemy getstance() != # "prone") {
      if(!entity cansee(isDefined(entity.var_5a81324d) ? entity.var_5a81324d : entity.enemy)) {
        entity.var_e8e74caf = 0;
        return true;
      }
    }

    if(isDefined(entity.var_5a81324d)) {
      if(entity namespace_85745671::function_98e73b11(entity.var_5a81324d)) {
        entity.var_2fe49a8a = 1;
      }

      return true;
    }
  } else {
    entity.var_e8e74caf = 0;
    return true;
  }

  if(is_true(entity.var_1fa24724)) {
    entity.var_e8e74caf = 0;
    return true;
  }

  return true;
}

function zmzombieshouldmelee(entity) {
  if(entity function_dd070839()) {
    return false;
  }

  if(is_true(entity.var_b719e78) && is_true(entity.var_d1bb0ad) && is_true(entity.var_e8e74caf) || is_true(entity.var_2d78e306) || is_true(entity.var_85cea06c) || is_true(entity.var_2fe49a8a)) {
    entity.idletime = gettime();
    entity.idleorigin = entity.origin;
    return true;
  }

  return false;
}

function function_fb814207(behaviortreeentity) {
  if(is_true(behaviortreeentity.ai.var_870d0893)) {
    return;
  }

  if(isDefined(self.var_72411ccf)) {
    self[[self.var_72411ccf]](self);
    return;
  }

  self zombiefindflesh(self);
}

function zombiefindflesh(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enablepushtime)) {
    if(gettime() >= behaviortreeentity.enablepushtime) {
      behaviortreeentity collidewithactors(1);
      behaviortreeentity.enablepushtime = undefined;
    }
  }

  if(getdvarint(#"scr_zm_use_code_enemy_selection", 0)) {
    zombiefindfleshcode(behaviortreeentity);
    return;
  }

  if(level.intermission) {
    if(isDefined(level.var_b813f909)) {
      [[level.var_b813f909]](behaviortreeentity);
    }

    return;
  }

  if(is_true(behaviortreeentity.var_67faa700)) {
    return;
  }

  if(behaviortreeentity getpathmode() == "dont move") {
    return;
  }

  if(!isDefined(behaviortreeentity.ignore_player)) {
    behaviortreeentity.ignore_player = [];
  }

  behaviortreeentity.goalradius = 30;

  if(is_true(behaviortreeentity.ignore_find_flesh)) {
    return;
  }

  if(behaviortreeentity.team == # "allies") {
    behaviortreeentity findzombieenemy();
    return;
  }

  if(zombieshouldmoveawaycondition(behaviortreeentity)) {
    return;
  }

  if(!(self.zm_ai_category === # "special") && !(self.zm_ai_category === # "elite")) {
    decoy = nightingale::function_29fbe24f(behaviortreeentity);
    monkey = gadget_cymbal_monkey::function_4a5dff80(behaviortreeentity, 0);
    var_67372704 = [decoy, monkey];
    recon_car = recon_car::function_8030f1bd(behaviortreeentity);

    if(!isDefined(var_67372704)) {
      var_67372704 = [];
    } else if(!isarray(var_67372704)) {
      var_67372704 = array(var_67372704);
    }

    if(!isinarray(var_67372704, recon_car)) {
      var_67372704[var_67372704.size] = recon_car;
    }

    arrayremovevalue(var_67372704, undefined);
    enemy_override = arraygetclosest(behaviortreeentity.origin, var_67372704);

    if(isDefined(enemy_override)) {
      self.enemy_override = enemy_override;
    }
  }

  zombie_poi = behaviortreeentity zm_utility::get_zombie_point_of_interest(behaviortreeentity.origin);
  behaviortreeentity.zombie_poi = zombie_poi;
  players = getplayers();

  if(isDefined(level.zombie_targets) && level.zombie_targets.size > 0) {
    function_1eaaceab(level.zombie_targets);
    arrayremovevalue(level.zombie_targets, undefined);
    players = arraycombine(players, level.zombie_targets, 0, 0);
  }

  if(!isDefined(behaviortreeentity.ignore_player) || players.size == 1) {
    behaviortreeentity.ignore_player = [];
  } else if(!isDefined(level._should_skip_ignore_player_logic) || ![[level._should_skip_ignore_player_logic]]()) {
    for(i = 0; i < behaviortreeentity.ignore_player.size; i++) {
      if(isDefined(behaviortreeentity.ignore_player[i]) && isDefined(behaviortreeentity.ignore_player[i].ignore_counter) && behaviortreeentity.ignore_player[i].ignore_counter > 3) {
        behaviortreeentity.ignore_player[i].ignore_counter = 0;
        behaviortreeentity.ignore_player = arrayremovevalue(behaviortreeentity.ignore_player, behaviortreeentity.ignore_player[i]);

        if(!isDefined(behaviortreeentity.ignore_player)) {
          behaviortreeentity.ignore_player = [];
        }

        i = 0;
        continue;
      }
    }
  }

  behaviortreeentity zombie_utility::run_ignore_player_handler();
  designated_target = 0;

  if(isDefined(behaviortreeentity.var_93a62fe) && is_true(behaviortreeentity.var_93a62fe.b_is_designated_target)) {
    designated_target = 1;
  }

  if(!isDefined(behaviortreeentity.var_93a62fe) && (!isDefined(self.enemy_override) && !isDefined(behaviortreeentity.attackable) || isDefined(behaviortreeentity.var_8a3828c6))) {
    if(isDefined(behaviortreeentity.ignore_player)) {
      if(isDefined(level._should_skip_ignore_player_logic) && [[level._should_skip_ignore_player_logic]]()) {
        return;
      }

      behaviortreeentity.ignore_player = [];
    }

    if(is_true(behaviortreeentity.interdimensional_gun_kill) && isDefined(behaviortreeentity.v_zombie_custom_goal_pos)) {
      goalpos = behaviortreeentity.v_zombie_custom_goal_pos;
      behaviortreeentity setgoal(goalpos);
      function_9d92b55a(behaviortreeentity);
      return;
    }

    if(is_true(behaviortreeentity.ispuppet)) {
      return;
    }

    if(isDefined(level.no_target_override)) {
      [[level.no_target_override]](behaviortreeentity);
    } else {
      behaviortreeentity setgoal(behaviortreeentity.origin);
    }

    function_9d92b55a(behaviortreeentity);
    return;
  } else if(isDefined(level.var_d22435d9)) {
    [[level.var_d22435d9]](behaviortreeentity);
  }

  if(!isDefined(level.var_4bde8b8f) || ![[level.var_4bde8b8f]]()) {
    if(isDefined(zombie_poi)) {
      behaviortreeentity.enemy_override = zombie_poi.poi_ent;
      behaviortreeentity.enemy_override.var_dfa42180 = &zm_utility::function_49f80b6f;
    }

    behaviortreeentity.favoriteenemy = behaviortreeentity.var_93a62fe;
  }

  var_bd871069 = (!isDefined(behaviortreeentity.enemy_override) && !isDefined(behaviortreeentity.attackable) || isDefined(behaviortreeentity.var_8a3828c6)) && !isDefined(behaviortreeentity.v_zombie_custom_goal_pos);

  if(isDefined(behaviortreeentity.v_zombie_custom_goal_pos) && !var_bd871069) {
    goalpos = behaviortreeentity.v_zombie_custom_goal_pos;

    if(isDefined(behaviortreeentity.n_zombie_custom_goal_radius)) {
      behaviortreeentity.goalradius = behaviortreeentity.n_zombie_custom_goal_radius;
    }

    behaviortreeentity setgoal(goalpos);
    function_9d92b55a(behaviortreeentity);
  } else if(isDefined(behaviortreeentity.enemy_override) && !var_bd871069) {
    behaviortreeentity.has_exit_point = undefined;
    goalpos = behaviortreeentity.enemy_override.origin;

    if(isDefined(behaviortreeentity.enemy_override.var_dfa42180)) {
      goalpos = behaviortreeentity.enemy_override[[behaviortreeentity.enemy_override.var_dfa42180]](self);
    }

    if(isDefined(goalpos)) {
      goalpos = getclosestpointonnavmesh(goalpos, 200, 0);
    }

    if(isDefined(goalpos)) {
      if(!isDefined(zombie_poi)) {
        aiprofile_beginentry("zombiefindflesh-enemyoverride");
        queryresult = positionquery_source_navigation(goalpos, 0, 48, 36, 4);
        aiprofile_endentry();

        foreach(point in queryresult.data) {
          goalpos = point.origin;
          break;
        }
      }

      behaviortreeentity setgoal(goalpos);
    }

    if(self isatgoal() || !isDefined(goalpos)) {
      self clearpath();
      behaviortreeentity.keep_moving = 0;
    }

    function_9d92b55a(behaviortreeentity);
  } else if(isDefined(behaviortreeentity.attackable) && !designated_target && !var_bd871069) {
    if(isDefined(behaviortreeentity.attackable_slot)) {
      if(isDefined(behaviortreeentity.attackable_goal_radius)) {
        behaviortreeentity.goalradius = behaviortreeentity.attackable_goal_radius;
      }

      nav_mesh = getclosestpointonnavmesh(behaviortreeentity.attackable_slot.origin, 64);

      if(isDefined(nav_mesh)) {
        behaviortreeentity setgoal(nav_mesh);
      } else {
        behaviortreeentity setgoal(behaviortreeentity.attackable_slot.origin);
      }
    } else if(isDefined(behaviortreeentity.var_b238ef38) && isDefined(behaviortreeentity.var_b238ef38.position)) {
      behaviortreeentity setgoal(behaviortreeentity.var_b238ef38.position);
    }

    function_9d92b55a(behaviortreeentity);
  } else if(isDefined(behaviortreeentity.favoriteenemy)) {
    behaviortreeentity.has_exit_point = undefined;
    behaviortreeentity val::reset(#"attack_properties", "ignoreall");

    if(isarray(behaviortreeentity.enemy.var_f904e440) && isinarray(behaviortreeentity.enemy.var_f904e440, behaviortreeentity)) {
      return;
    }

    if(isDefined(level.enemy_location_override_func)) {
      goalpos = [[level.enemy_location_override_func]](behaviortreeentity, behaviortreeentity.favoriteenemy);

      if(isDefined(goalpos)) {
        behaviortreeentity setgoal(goalpos);
      } else {
        behaviortreeentity zombieupdategoal();
      }
    } else if(is_true(behaviortreeentity.is_rat_test)) {} else if(zombieshouldmoveawaycondition(behaviortreeentity)) {} else {
      behaviortreeentity zombieupdategoal();
    }
  }

  if(players.size > 1) {
    for(i = 0; i < behaviortreeentity.ignore_player.size; i++) {
      if(isDefined(behaviortreeentity.ignore_player[i])) {
        if(!isDefined(behaviortreeentity.ignore_player[i].ignore_counter)) {
          behaviortreeentity.ignore_player[i].ignore_counter = 0;
          continue;
        }

        behaviortreeentity.ignore_player[i].ignore_counter += 1;
      }
    }
  }
}

function function_483766be(entity) {
  if(is_true(entity.var_1fa24724) && !isDefined(entity.enemy_override) && !isDefined(entity.attackable) && isPlayer(entity.enemy) && isDefined(entity.enemy.var_dbb28b34) && gettime() - entity.enemy.var_dbb28b34 > 2000) {
    if(isDefined(entity.enemy) && !is_true(entity.var_205ab08b) && (!isDefined(entity.var_42ecd9f3) || entity.var_42ecd9f3 <= gettime())) {
      function_e5f60f55(entity);
    }

    if(isarray(entity.enemy.var_f904e440) && isinarray(entity.enemy.var_f904e440, entity)) {
      return;
    }

    return;
  }

  if(isarray(entity.enemy.var_f904e440)) {
    arrayremovevalue(entity.enemy.var_f904e440, entity);
  }
}

function private function_9d92b55a(behaviortreeentity) {
  behaviortreeentity.var_9e6e6645 = undefined;
}

function function_f637b05d(behaviortreeentity) {
  if(is_true(behaviortreeentity.ai.var_870d0893)) {
    return;
  }

  behaviortreeentity.var_93a62fe = zm_utility::get_closest_valid_player(behaviortreeentity.origin, behaviortreeentity.ignore_player);
}

function zombiefindfleshcode(behaviortreeentity) {
  aiprofile_beginentry("zombieFindFleshCode");

  if(level.intermission) {
    aiprofile_endentry();
    return;
  }

  behaviortreeentity.ignore_player = [];
  behaviortreeentity.goalradius = 30;

  if(behaviortreeentity.team == # "allies") {
    behaviortreeentity findzombieenemy();
    aiprofile_endentry();
    return;
  }

  if(level.wait_and_revive) {
    aiprofile_endentry();
    return;
  }

  monkey = gadget_cymbal_monkey::function_4a5dff80(behaviortreeentity, 0);

  if(isDefined(monkey)) {
    behaviortreeentity.enemy_override = monkey;
  }

  if(level.zombie_poi_array.size > 0) {
    zombie_poi = behaviortreeentity zm_utility::get_zombie_point_of_interest(behaviortreeentity.origin);
  }

  behaviortreeentity zombie_utility::run_ignore_player_handler();
  zm_utility::update_valid_players(behaviortreeentity.origin, behaviortreeentity.ignore_player);

  if(!isDefined(behaviortreeentity.enemy) && !isDefined(zombie_poi)) {
    if(is_true(behaviortreeentity.ispuppet)) {
      aiprofile_endentry();
      return;
    }

    if(isDefined(level.no_target_override)) {
      [[level.no_target_override]](behaviortreeentity);
    } else {
      behaviortreeentity setgoal(behaviortreeentity.origin);
    }

    aiprofile_endentry();
    return;
  }

  behaviortreeentity.zombie_poi = zombie_poi;

  if(isDefined(zombie_poi)) {
    behaviortreeentity.enemy_override = zombie_poi.poi_ent;
    behaviortreeentity.enemy_override.var_dfa42180 = &zm_utility::function_49f80b6f;
  }

  if(isDefined(behaviortreeentity.enemy_override)) {
    behaviortreeentity.has_exit_point = undefined;
    goalpos = behaviortreeentity.enemy_override.origin;

    if(isDefined(behaviortreeentity.enemy_override.var_dfa42180)) {
      goalpos = behaviortreeentity.enemy_override[[behaviortreeentity.enemy_override.var_dfa42180]](behaviortreeentity);
    }

    if(isDefined(goalpos)) {
      queryresult = positionquery_source_navigation(goalpos, 0, 48, 36, 4);

      foreach(point in queryresult.data) {
        goalpos = point.origin;
        break;
      }

      behaviortreeentity setgoal(goalpos);
    }
  } else if(isDefined(behaviortreeentity.enemy)) {
    behaviortreeentity.has_exit_point = undefined;

    if(is_true(behaviortreeentity.is_rat_test)) {
      aiprofile_endentry();
      return;
    }

    if(isDefined(level.enemy_location_override_func)) {
      goalpos = [[level.enemy_location_override_func]](behaviortreeentity, behaviortreeentity.enemy);

      if(isDefined(goalpos)) {
        behaviortreeentity setgoal(goalpos);
      } else {
        behaviortreeentity zombieupdategoalcode();
      }
    } else if(isDefined(behaviortreeentity.enemy.last_valid_position)) {
      behaviortreeentity zombieupdategoalcode();
    }
  }

  aiprofile_endentry();
}

function zombieupdategoal() {
  aiprofile_beginentry("zombieUpdateGoal");

  if(isPlayer(self.favoriteenemy)) {
    targetent = zm_ai_utility::function_a2e8fd7b(self, self.favoriteenemy);

    if(isDefined(targetent.last_valid_position)) {
      targetpos = getclosestpointonnavmesh(targetent.last_valid_position, 64, 0);

      if(!isDefined(targetpos)) {
        targetpos = targetent.origin;
      }
    } else {
      targetpos = targetent.origin;
    }
  } else {
    targetpos = getclosestpointonnavmesh(self.favoriteenemy.origin, 64, 0);

    if(!isDefined(targetpos) && self.favoriteenemy function_dd070839() && isDefined(self.favoriteenemy.traversestartnode)) {
      targetpos = self.favoriteenemy.traversestartnode.origin;
    }
  }

  if(isentity(targetent)) {
    if(!is_true(self.var_1fa24724)) {
      self.var_1f1f2fcd = undefined;
    } else if(self isposinclaimedlocation(isDefined(self.var_1f1f2fcd) ? self.var_1f1f2fcd : targetpos)) {
      queryresult = positionquery_source_navigation(targetpos, self getpathfindingradius(), self getpathfindingradius() * 5, 64, 16, self);

      if(queryresult.data.size > 0) {
        positionquery_filter_inclaimedlocation(queryresult, self);
        queryresult.data = function_7b8e26b3(queryresult.data, 0, "inClaimedLocation");

        if(queryresult.data.size > 0) {
          point = arraygetclosest(self.origin, queryresult.data);
          self.var_1f1f2fcd = point.origin;
          targetpos = point.origin;
        }
      }
    }

    targetpos = isDefined(self.var_1f1f2fcd) ? self.var_1f1f2fcd : targetpos;
  }

  if(!isDefined(targetpos)) {
    return;
  }

  var_75dd804d = length2dsquared(self.origin - targetpos);
  var_2b8b6d3f = sqr(175);
  shouldrepath = 0;

  if(isDefined(self.var_9e6e6645)) {
    if(isDefined(targetpos)) {
      if(is_true(self.var_4fe4e626)) {
        self.var_4fe4e626 = 0;
        shouldrepath = 1;
      } else if(distancesquared(self.var_9e6e6645, targetpos) > sqr(18)) {
        shouldrepath = 1;
      } else if(var_75dd804d < sqr(72) && (!isDefined(self.nextgoalupdate) || self.nextgoalupdate < gettime())) {
        shouldrepath = 1;
      } else if(is_true(self.var_d9a37fc4) && var_75dd804d <= var_2b8b6d3f) {
        shouldrepath = 1;
      }
    }
  } else {
    shouldrepath = 1;
  }

  if(self function_dd070839()) {
    shouldrepath = 0;
  }

  if(isactor(self) && self asmistransitionrunning() || self asmistransdecrunning()) {
    shouldrepath = 0;
  }

  if(shouldrepath) {
    goalpos = targetpos;
    self.var_d9a37fc4 = 0;

    if(var_75dd804d > var_2b8b6d3f && !is_false(self.should_zigzag)) {
      angle = randomfloatrange(-180, 180);
      distance = randomfloatrange(16, 128);

      if(isDefined(self.var_60d1126a)) {
        struct = [[self.var_60d1126a]](self, targetpos);

        if(isDefined(struct)) {
          assert(isDefined(struct.angle) && isDefined(struct.dist), "<dev string:x38>");
          angle = struct.angle;
          distance = struct.dist;
        }
      }

      goalpos = checknavmeshdirection(targetpos, function_ba142845(angle), distance, self getpathfindingradius() * 1.1);
      self.var_d9a37fc4 = 1;
    }

    self setgoal(goalpos, undefined, undefined, undefined, undefined, 1);
    self.var_9e6e6645 = targetpos;
    self.nextgoalupdate = gettime() + randomintrange(500, 1000);
  }

  aiprofile_endentry();
}

function zombieupdategoalcode() {
  aiprofile_beginentry("zombieUpdateGoalCode");
  shouldrepath = 0;

  if(isDefined(self.enemy)) {
    if(!isDefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
      shouldrepath = 1;
    } else if(distancesquared(self.origin, self.enemy.origin) <= sqr(200)) {
      shouldrepath = 1;
    } else if(isDefined(self.pathgoalpos)) {
      distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
      shouldrepath = distancetogoalsqr < sqr(72);
    }
  }

  if(is_true(self.keep_moving)) {
    if(gettime() > self.keep_moving_time) {
      self.keep_moving = 0;
    }
  }

  if(shouldrepath) {
    goalpos = self.enemy.origin;

    if(isDefined(self.enemy.last_valid_position)) {
      var_2a741504 = getclosestpointonnavmesh(self.enemy.last_valid_position, 64, 0);

      if(isDefined(var_2a741504)) {
        goalpos = var_2a741504;
      }
    }

    if(is_true(level.do_randomized_zigzag_path)) {
      if(distancesquared(self.origin, goalpos) > sqr(240)) {
        self.keep_moving = 1;
        self.keep_moving_time = gettime() + 250;
        path = self calcapproximatepathtoposition(goalpos, 0);

        if(getdvarint(#"ai_debugzigzag", 0)) {
          for(index = 1; index < path.size; index++) {
            recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x5a>", self);
          }
        }

        deviationdistance = randomintrange(240, 480);
        segmentlength = 0;

        for(index = 1; index < path.size; index++) {
          currentseglength = distance(path[index - 1], path[index]);

          if(segmentlength + currentseglength > deviationdistance) {
            remaininglength = deviationdistance - segmentlength;
            seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;

            recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x5a>", self);

            innerzigzagradius = level.inner_zigzag_radius;
            outerzigzagradius = level.outer_zigzag_radius;
            queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, self, 16);
            positionquery_filter_inclaimedlocation(queryresult, self);

            if(queryresult.data.size > 0) {
              point = queryresult.data[randomint(queryresult.data.size)];

              if(tracepassedonnavmesh(seedposition, point.origin, 16)) {
                goalpos = point.origin;
              }
            }

            break;
          }

          segmentlength += currentseglength;
        }
      }
    }

    self setgoal(goalpos);
    self.nextgoalupdate = gettime() + randomintrange(500, 1000);
  }

  aiprofile_endentry();
}

function zombieenteredplayable(behaviortreeentity) {
  if(is_true(behaviortreeentity.ai.var_870d0893)) {
    return;
  }

  if(is_true(behaviortreeentity.completed_emerging_into_playable_area)) {
    return;
  }

  if(zm_utility::function_c85ebbbc()) {
    if(!isDefined(level.playable_area)) {
      level.playable_area = getEntArray("player_volume", "script_noteworthy");
    }

    var_12ed21a1 = function_72d3bca6(level.playable_area, behaviortreeentity.origin, undefined, undefined, level.var_603981f1);

    foreach(area in var_12ed21a1) {
      if(behaviortreeentity istouching(area)) {
        if(isDefined(behaviortreeentity.var_ee833cd6)) {
          behaviortreeentity[[behaviortreeentity.var_ee833cd6]]();
        } else {
          behaviortreeentity zm_spawner::zombie_complete_emerging_into_playable_area();
        }

        return 1;
      }
    }
  }

  if(zm_utility::function_21f4ac36()) {
    if(!isDefined(level.var_a2a9b2de)) {
      level.var_a2a9b2de = getnodearray("player_region", "script_noteworthy");
    }

    node = function_52c1730(behaviortreeentity.origin, level.var_a2a9b2de, 500);

    if(isDefined(node)) {
      if(isDefined(behaviortreeentity.var_ee833cd6)) {
        behaviortreeentity[[behaviortreeentity.var_ee833cd6]]();
      } else {
        behaviortreeentity zm_spawner::zombie_complete_emerging_into_playable_area();
      }

      return 1;
    }
  }

  return 0;
}

function shouldmovecondition(behaviortreeentity) {
  if(behaviortreeentity haspath()) {
    return true;
  }

  if(is_true(behaviortreeentity.keep_moving)) {
    return true;
  }

  return false;
}

function zombieshouldmoveawaycondition(behaviortreeentity) {
  return level.wait_and_revive;
}

function waskilledbyteslacondition(behaviortreeentity) {
  if(is_true(behaviortreeentity.tesla_death)) {
    return true;
  }

  return false;
}

function function_a00b473a(behaviortreeentity) {
  if(is_true(behaviortreeentity.var_49fdad6a)) {
    return true;
  }

  return false;
}

function function_8396494f(behaviortreeentity) {
  if(is_true(behaviortreeentity.var_ebd66e27)) {
    return true;
  }

  return false;
}

function function_77a0b45d(behaviortreeentity) {
  behaviortreeentity.var_98f1f37c = 1;
}

function disablepowerups(behaviortreeentity) {
  behaviortreeentity.no_powerups = 1;
}

function function_fa2814ae(behaviortreeentity) {
  behaviortreeentity.var_98f1f37c = 0;
}

function enablepowerups(behaviortreeentity) {
  behaviortreeentity.no_powerups = 0;
}

function zombiemoveaway(behaviortreeentity, asmstatename) {
  player = util::gethostplayer();

  if(!isDefined(player)) {
    return 5;
  }

  queryresult = level.move_away_points;
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);

  if(!isDefined(queryresult)) {
    return 5;
  }

  self.keep_moving = 0;

  for(i = 0; i < queryresult.data.size; i++) {
    if(!zm_utility::check_point_in_playable_area(queryresult.data[i].origin)) {
      continue;
    }

    isbehind = vectordot(player.origin - behaviortreeentity.origin, queryresult.data[i].origin - behaviortreeentity.origin);

    if(isbehind < 0) {
      behaviortreeentity setgoal(queryresult.data[i].origin);
      arrayremoveindex(level.move_away_points.data, i, 0);
      i--;
      return 5;
    }
  }

  for(i = 0; i < queryresult.data.size; i++) {
    if(!zm_utility::check_point_in_playable_area(queryresult.data[i].origin)) {
      continue;
    }

    dist_zombie = distancesquared(queryresult.data[i].origin, behaviortreeentity.origin);
    dist_player = distancesquared(queryresult.data[i].origin, player.origin);

    if(dist_zombie < dist_player) {
      behaviortreeentity setgoal(queryresult.data[i].origin);
      arrayremoveindex(level.move_away_points.data, i, 0);
      i--;
      return 5;
    }
  }

  self zm::default_find_exit_point();
  return 5;
}

function zombieisbeinggrappled(behaviortreeentity) {
  if(is_true(behaviortreeentity.grapple_is_fatal)) {
    return true;
  }

  return false;
}

function zombieshouldknockdown(behaviortreeentity) {
  if(is_true(behaviortreeentity.knockdown)) {
    return true;
  }

  return false;
}

function function_6a690c50(behaviortreeentity) {
  return zombieshouldknockdown(behaviortreeentity) && zombiebehavior::zombiehaslegs(behaviortreeentity);
}

function zombieispushed(behaviortreeentity) {
  if(is_true(behaviortreeentity.pushed)) {
    return true;
  }

  return false;
}

function function_22d21726(behaviortreeentity) {
  if(is_true(behaviortreeentity.var_687de2a9)) {
    return true;
  }

  return false;
}

function function_7531db00(behaviortreeentity) {
  aiutility::traversesetup(behaviortreeentity);
  behaviortreeentity.old_powerups = behaviortreeentity.no_powerups;
  behaviortreeentity.var_9ed3cc11 = behaviortreeentity function_e827fc0e();
  behaviortreeentity pushplayer(1);
  behaviortreeentity callback::callback(#"hash_1518febf00439d5");
  behaviortreeentity setforcenocull();
  return true;
}

function function_1329e086(behaviortreeentity) {
  behaviortreeentity removeforcenocull();
  behaviortreeentity.no_powerups = behaviortreeentity.old_powerups;

  if(!is_true(behaviortreeentity.missinglegs)) {
    behaviortreeentity collidewithactors(0);
    behaviortreeentity.enablepushtime = gettime() + 1000;
  }

  if(isDefined(behaviortreeentity.var_9ed3cc11)) {
    behaviortreeentity pushplayer(behaviortreeentity.var_9ed3cc11);
    behaviortreeentity.var_9ed3cc11 = undefined;
  }

  behaviortreeentity callback::callback(#"hash_34b65342cbfdadac");
  return true;
}

function zombiegrappleactionstart(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_grapple_direction", self.grapple_direction);
}

function zombieknockdownactionstart(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_knockdown_direction", behaviortreeentity.knockdown_direction);
  behaviortreeentity setblackboardattribute("_knockdown_type", behaviortreeentity.knockdown_type);
  behaviortreeentity setblackboardattribute("_getup_direction", behaviortreeentity.getup_direction);
  behaviortreeentity collidewithactors(0);
  behaviortreeentity.blockingpain = 1;
}

function private function_c8939973(behaviortreeentity) {
  behaviortreeentity.knockdown = 0;
  behaviortreeentity collidewithactors(1);
  behaviortreeentity.blockingpain = 0;
}

function private zombiepushedactionstart(behaviortreeentity) {
  behaviortreeentity collidewithactors(0);
  behaviortreeentity setblackboardattribute("_push_direction", behaviortreeentity.push_direction);
}

function private zombiepushedactionterminate(behaviortreeentity) {
  behaviortreeentity collidewithactors(1);
  behaviortreeentity.pushed = 0;
}

function private function_289cdbab(behaviortreeentity) {
  behaviortreeentity ai::disable_pain();
}

function private function_6560f92b(behaviortreeentity) {
  behaviortreeentity ai::enable_pain();
}

function zombieshouldstun(behaviortreeentity) {
  if(behaviortreeentity ai::is_stunned() && !is_true(behaviortreeentity.tesla_death)) {
    return true;
  }

  return false;
}

function zombiestunstart(behaviortreeentity) {
  behaviortreeentity pathmode("dont move", 1);
  callback::callback(#"hash_1eda827ff5e6895b");
}

function function_c377438f(behaviortreeentity) {
  behaviortreeentity pathmode("move allowed");
  callback::callback(#"hash_210adcf09e99fba1");
}

function zombiestunactionstart(behaviortreeentity, asmstatename) {
  zombiestunstart(behaviortreeentity);
  behaviortreeentity.var_4034a31 = gibserverutils::isgibbed(behaviortreeentity, 256) || gibserverutils::isgibbed(behaviortreeentity, 128);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function function_4e52c07(behaviortreeentity, asmstatename) {
  if(isDefined(asmstatename.var_4034a31) && asmstatename.var_4034a31 != (gibserverutils::isgibbed(asmstatename, 256) || gibserverutils::isgibbed(asmstatename, 128))) {
    return 4;
  }

  if(asmstatename ai::is_stunned()) {
    return 5;
  }

  return 4;
}

function zombiestunactionend(behaviortreeentity, asmstatename) {
  function_c377438f(asmstatename);
  asmstatename.var_4034a31 = undefined;
  return 4;
}

function zombietraverseaction(behaviortreeentity, asmstatename) {
  aiutility::traverseactionstart(behaviortreeentity, asmstatename);
  behaviortreeentity.old_powerups = behaviortreeentity.no_powerups;
  disablepowerups(behaviortreeentity);
  function_77a0b45d(behaviortreeentity);
  behaviortreeentity.var_9ed3cc11 = behaviortreeentity function_e827fc0e();
  behaviortreeentity pushplayer(1);
  behaviortreeentity callback::callback(#"hash_1518febf00439d5");
  return 5;
}

function zombietraverseactionterminate(behaviortreeentity, asmstatename) {
  aiutility::wpn_debug_bot_joinleave(behaviortreeentity, asmstatename);

  if(behaviortreeentity asmgetstatus() == "asm_status_complete") {
    behaviortreeentity.no_powerups = behaviortreeentity.old_powerups;

    if(!is_true(behaviortreeentity.missinglegs)) {
      behaviortreeentity collidewithactors(0);
      behaviortreeentity.enablepushtime = gettime() + 1000;
    }

    if(isDefined(behaviortreeentity.var_9ed3cc11)) {
      behaviortreeentity pushplayer(behaviortreeentity.var_9ed3cc11);
      behaviortreeentity.var_9ed3cc11 = undefined;
    }
  }

  behaviortreeentity callback::callback(#"hash_34b65342cbfdadac");
  return 4;
}

function zombiegottoentrancecondition(behaviortreeentity) {
  if(is_true(behaviortreeentity.got_to_entrance)) {
    return true;
  }

  return false;
}

function zombiegottoattackspotcondition(behaviortreeentity) {
  if(is_true(behaviortreeentity.at_entrance_tear_spot)) {
    return true;
  }

  return false;
}

function zombiehasattackspotalreadycondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.attacking_spot_index) && behaviortreeentity.attacking_spot_index >= 0) {
    return true;
  }

  return false;
}

function zombieshouldtearcondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.first_node)) {
    if(isDefined(behaviortreeentity.first_node.zbarrier)) {
      if(isDefined(behaviortreeentity.first_node.barrier_chunks)) {
        if(!zm_utility::all_chunks_destroyed(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks)) {
          return true;
        }
      }
    }
  }

  return false;
}

function zombieshouldattackthroughboardscondition(behaviortreeentity) {
  if(is_true(behaviortreeentity.missinglegs)) {
    return false;
  }

  if(isDefined(behaviortreeentity.first_node.zbarrier)) {
    if(!behaviortreeentity.first_node.zbarrier zbarriersupportszombiereachthroughattacks()) {
      chunks = undefined;

      if(isDefined(behaviortreeentity.first_node)) {
        chunks = zm_utility::get_non_destroyed_chunks(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks);
      }

      if(isDefined(chunks) && chunks.size > 0) {
        return false;
      }
    }
  }

  if(getdvarstring(#"zombie_reachin_freq") == "") {
    setDvar(#"zombie_reachin_freq", 50);
  }

  freq = getdvarint(#"zombie_reachin_freq", 0);
  players = getplayers();
  attack = 0;
  behaviortreeentity.player_targets = [];

  for(i = 0; i < players.size; i++) {
    if(isalive(players[i]) && !isDefined(players[i].revivetrigger) && distance2d(behaviortreeentity.origin, players[i].origin) <= 109.8 && !is_true(players[i].ignoreme)) {
      behaviortreeentity.player_targets[behaviortreeentity.player_targets.size] = players[i];
      attack = 1;
    }
  }

  if(!attack || freq < randomint(100)) {
    return false;
  }

  return true;
}

function zombieshouldtauntcondition(behaviortreeentity) {
  if(is_true(behaviortreeentity.missinglegs)) {
    return false;
  }

  if(!isDefined(behaviortreeentity.first_node.zbarrier)) {
    return false;
  }

  if(!behaviortreeentity.first_node.zbarrier zbarriersupportszombietaunts()) {
    return false;
  }

  if(getdvarstring(#"zombie_taunt_freq") == "") {
    setDvar(#"zombie_taunt_freq", 5);
  }

  freq = getdvarint(#"zombie_taunt_freq", 0);

  if(freq >= randomint(100)) {
    return true;
  }

  return false;
}

function zombieshouldenterplayablecondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.first_node) && isDefined(behaviortreeentity.first_node.barrier_chunks)) {
    if(zm_utility::all_chunks_destroyed(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks)) {
      if((!isDefined(behaviortreeentity.attacking_spot) || is_true(behaviortreeentity.at_entrance_tear_spot)) && !is_true(behaviortreeentity.completed_emerging_into_playable_area)) {
        return true;
      }
    }
  }

  return false;
}

function ischunkvalidcondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.chunk)) {
    return true;
  }

  return false;
}

function inplayablearea(behaviortreeentity) {
  if(is_true(behaviortreeentity.completed_emerging_into_playable_area)) {
    return true;
  }

  return false;
}

function shouldskipteardown(behaviortreeentity) {
  if(behaviortreeentity zm_spawner::should_skip_teardown(behaviortreeentity.find_flesh_struct_string)) {
    return true;
  }

  return false;
}

function zombieisthinkdone(behaviortreeentity) {
  if(is_true(behaviortreeentity.is_rat_test)) {
    return false;
  }

  if(is_true(behaviortreeentity.zombie_think_done)) {
    return true;
  }

  return false;
}

function zombieisatgoal(behaviortreeentity) {
  goalinfo = behaviortreeentity function_4794d6a3();
  isatscriptgoal = is_true(goalinfo.var_9e404264);

  if(is_true(level.var_21326085)) {
    if(!isatscriptgoal && isDefined(goalinfo.overridegoalpos)) {
      if(abs(goalinfo.overridegoalpos[2] - behaviortreeentity.origin[2]) < 17) {
        dist = distance2dsquared(goalinfo.overridegoalpos, behaviortreeentity.origin);

        if(dist < 289) {
          return 1;
        }
      }
    }
  }

  return isatscriptgoal;
}

function zombieisatentrance(behaviortreeentity) {
  goalinfo = behaviortreeentity function_4794d6a3();
  isatscriptgoal = is_true(goalinfo.var_9e404264);
  isatentrance = isDefined(behaviortreeentity.first_node) && isatscriptgoal;
  return isatentrance;
}

function function_4c12882b(behaviortreeentity) {
  if(!is_true(behaviortreeentity.got_to_entrance)) {
    return false;
  }

  if(isDefined(behaviortreeentity.first_node)) {
    return true;
  }

  node = behaviortreeentity.var_a5add0c0;

  if(isDefined(node.var_597f08bf) && node.var_597f08bf.targetname === "barricade_window") {
    return true;
  }

  return false;
}

function function_b86a1b9d(behaviortreeentity) {
  barricades = [isDefined(behaviortreeentity.var_a5add0c0.var_597f08bf) ? behaviortreeentity.var_a5add0c0.var_597f08bf : undefined, behaviortreeentity.first_node];

  foreach(barricade in barricades) {
    if(namespace_85745671::function_f4087909(barricade)) {
      if(getdvarint(#"hash_2f078c2224f40586", 0) && isDefined(barricade.zbarrier)) {
        record3dtext("<dev string:x68>" + barricade.zbarrier getentnum(), behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x5a>", behaviortreeentity);
      }

      return true;
    }

    if(getdvarint(#"hash_2f078c2224f40586", 0) && isDefined(barricade.zbarrier)) {
      record3dtext("<dev string:x7f>" + barricade.zbarrier getentnum(), behaviortreeentity.origin, (1, 0, 0), "<dev string:x5a>", behaviortreeentity);
    }
  }

  return false;
}

function function_e7f2e349(behaviortreeentity) {
  return function_4c12882b(behaviortreeentity) && function_b86a1b9d(behaviortreeentity);
}

function function_45009145(behaviortreeentity) {
  ret = is_true(behaviortreeentity.var_348e5e19);
  behaviortreeentity.var_348e5e19 = undefined;
  return ret;
}

function getchunkservice(behaviortreeentity) {
  if(isDefined(behaviortreeentity.chunk) && isDefined(behaviortreeentity.first_node.zbarrier) && behaviortreeentity.first_node.zbarrier getzbarrierpiecestate(behaviortreeentity.chunk) === "targetted_by_zombie") {
    behaviortreeentity.first_node.zbarrier setzbarrierpiecestate(behaviortreeentity.chunk, "closed");
  }

  behaviortreeentity.chunk = zm_utility::get_closest_non_destroyed_chunk(behaviortreeentity.origin, behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks);

  if(isDefined(behaviortreeentity.chunk)) {
    behaviortreeentity.first_node.zbarrier setzbarrierpiecestate(behaviortreeentity.chunk, "targetted_by_zombie");
    behaviortreeentity.first_node thread zm_spawner::check_zbarrier_piece_for_zombie_death(behaviortreeentity.chunk, behaviortreeentity.first_node.zbarrier, behaviortreeentity);
  }
}

function function_38237e30(behaviortreeentity, anim) {
  getchunkservice(anim);
}

function updatechunkservice(behaviortreeentity) {
  while(0 < behaviortreeentity.first_node.zbarrier.chunk_health[behaviortreeentity.chunk]) {
    behaviortreeentity.first_node.zbarrier.chunk_health[behaviortreeentity.chunk]--;
  }

  behaviortreeentity.lastchunk_destroy_time = gettime();
}

function updateattackspotservice(behaviortreeentity) {
  if(is_true(behaviortreeentity.marked_for_death) || behaviortreeentity.health < 0) {
    return false;
  }

  if(!isDefined(behaviortreeentity.attacking_spot)) {
    if(!isDefined(behaviortreeentity.first_node) || !behaviortreeentity zm_spawner::get_attack_spot(behaviortreeentity.first_node)) {
      return false;
    }
  }

  if(isDefined(behaviortreeentity.attacking_spot)) {
    behaviortreeentity.goalradius = 17;
    behaviortreeentity function_a57c34b7(behaviortreeentity.attacking_spot);

    if(zombieisatgoal(behaviortreeentity)) {
      behaviortreeentity.at_entrance_tear_spot = 1;
    }

    return true;
  }

  return false;
}

function function_b3311a1a(behaviortreeentity, anim) {
  return updateattackspotservice(anim);
}

function findnodesservice(behaviortreeentity) {
  node = undefined;
  behaviortreeentity.entrance_nodes = [];

  if(isDefined(behaviortreeentity.find_flesh_struct_string)) {
    if(behaviortreeentity.find_flesh_struct_string == "find_flesh") {
      return 0;
    }

    for(i = 0; i < level.exterior_goals.size; i++) {
      if(isDefined(level.exterior_goals[i].script_string) && level.exterior_goals[i].script_string == behaviortreeentity.find_flesh_struct_string) {
        node = level.exterior_goals[i];
        break;
      }
    }

    for(i = 0; i < level.barrier_align.size; i++) {
      if(isDefined(level.barrier_align[i].script_string) && level.barrier_align[i].script_string == behaviortreeentity.find_flesh_struct_string) {
        behaviortreeentity.barrier_align = level.barrier_align[i];
      }
    }

    behaviortreeentity.entrance_nodes[behaviortreeentity.entrance_nodes.size] = node;
    assert(isDefined(node), "<dev string:x9a>" + behaviortreeentity.find_flesh_struct_string + "<dev string:xd0>");
    behaviortreeentity.first_node = node;
    goal_pos = getclosestpointonnavmesh(node.origin, 128, self getpathfindingradius());

    if(isDefined(goal_pos)) {
      behaviortreeentity function_a57c34b7(goal_pos);
    }

    if(zombieisatentrance(behaviortreeentity)) {
      behaviortreeentity.got_to_entrance = 1;
    }

    return 1;
  }
}

function function_92d348e2(behaviortreeentity) {
  node = behaviortreeentity.traversestartnode;

  if(isDefined(node.var_597f08bf)) {
    barricade = node.var_597f08bf;
    barricade notify(#"hash_5cfbbb6ee8378665");
    return true;
  }

  return false;
}

function zombieattackableobjectservice(behaviortreeentity) {
  if(is_true(behaviortreeentity.ai.var_870d0893)) {
    return;
  }

  if(!behaviortreeentity ai::has_behavior_attribute("use_attackable") || !behaviortreeentity ai::get_behavior_attribute("use_attackable")) {
    namespace_85745671::function_2b925fa5(behaviortreeentity);
    return 0;
  }

  if(is_true(behaviortreeentity.missinglegs)) {
    namespace_85745671::function_2b925fa5(behaviortreeentity);
    return 0;
  }

  if(is_true(behaviortreeentity.aat_turned)) {
    namespace_85745671::function_2b925fa5(behaviortreeentity);
    return 0;
  }

  if(isDefined(behaviortreeentity.var_b238ef38) && !isDefined(behaviortreeentity.attackable)) {
    namespace_85745671::function_2b925fa5(behaviortreeentity);
    return;
  }

  if(!isDefined(behaviortreeentity.attackable)) {
    behaviortreeentity.attackable = namespace_85745671::get_attackable(behaviortreeentity, 1);
    return;
  }

  if(!is_true(behaviortreeentity.attackable.is_active)) {
    behaviortreeentity.attackable = undefined;
  }
}

function zombiemovetoentranceaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.got_to_entrance = 0;
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function zombiemovetoentranceactionterminate(behaviortreeentity, asmstatename) {
  if(zombieisatentrance(asmstatename)) {
    asmstatename.got_to_entrance = 1;
  }

  return 4;
}

function zombiemovetoattackspotaction(behaviortreeentity, asmstatename) {
  function_6eb4f847(behaviortreeentity);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function function_6eb4f847(behaviortreeentity) {
  behaviortreeentity.at_entrance_tear_spot = 0;
  return true;
}

function zombiemovetoattackspotactionterminate(behaviortreeentity, asmstatename) {
  function_547701ae(asmstatename);
  return 4;
}

function function_547701ae(behaviortreeentity) {
  behaviortreeentity.at_entrance_tear_spot = 1;
  return true;
}

function zombieholdboardaction(behaviortreeentity, asmstatename) {
  function_f83905d5(behaviortreeentity);
  boardactionast = behaviortreeentity astsearch(asmstatename);
  boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function function_f83905d5(behaviortreeentity) {
  aiutility::keepclaimnode(behaviortreeentity);
  behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
  behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
  return true;
}

function zombieholdboardactionterminate(behaviortreeentity, asmstatename) {
  function_7d0a2e12(asmstatename);
  return 4;
}

function function_7d0a2e12(behaviortreeentity) {
  aiutility::keepclaimnode(behaviortreeentity);
  behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
  behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
  return true;
}

function zombiegrabboardaction(behaviortreeentity, asmstatename) {
  function_66a8aef2(behaviortreeentity);
  boardactionast = behaviortreeentity astsearch(asmstatename);
  boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function function_66a8aef2(behaviortreeentity) {
  aiutility::keepclaimnode(behaviortreeentity);
  behaviortreeentity pathmode("dont move");
  behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
  behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
  return true;
}

function zombiegrabboardactionterminate(behaviortreeentity, asmstatename) {
  function_16251b30(asmstatename);
  return 4;
}

function function_16251b30(behaviortreeentity) {
  aiutility::releaseclaimnode(behaviortreeentity);
  return true;
}

function zombiepullboardaction(behaviortreeentity, asmstatename) {
  function_aa76355a(behaviortreeentity);
  boardactionast = behaviortreeentity astsearch(asmstatename);
  boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function function_aa76355a(behaviortreeentity) {
  aiutility::keepclaimnode(behaviortreeentity);
  behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
  behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
  return true;
}

function zombiepullboardactionterminate(behaviortreeentity, asmstatename) {
  function_76d619c8(asmstatename);
  return 4;
}

function function_76d619c8(behaviortreeentity) {
  aiutility::releaseclaimnode(behaviortreeentity);
  self.lastchunk_destroy_time = gettime();
  return true;
}

function barricadebreakterminate(behaviortreeentity) {
  behaviortreeentity.pushable = 1;
  behaviortreeentity.blockingpain = 0;
  behaviortreeentity pathmode("move allowed");
  behaviortreeentity clearpath();
  behaviortreeentity animmode("normal", 0);
  behaviortreeentity orientmode("face motion");

  if(zm_utility::is_survival()) {
    if(isDefined(behaviortreeentity.var_67ab7d45)) {
      behaviortreeentity setgoal(behaviortreeentity.var_67ab7d45);
      behaviortreeentity.var_67ab7d45 = undefined;
    }
  }
}

function function_a26fcba() {
  self.var_ffc6fe22 = undefined;
  callback::function_52ac9652(#"hash_34b65342cbfdadac", &function_a26fcba);
  self clearpath();
  self.first_node = undefined;
  self.barrier_align = undefined;
  self zombie_utility::reset_attack_spot();
  self.at_entrance_tear_spot = 0;
  self.got_to_entrance = 0;
}

function function_a5a66d65(behaviortreeentity) {
  behaviortreeentity.var_348e5e19 = 1;
  return true;
}

function zombieattackthroughboardsaction(behaviortreeentity, asmstatename) {
  function_ebba4d65(behaviortreeentity);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function function_ebba4d65(behaviortreeentity) {
  aiutility::keepclaimnode(behaviortreeentity);
  behaviortreeentity.boardattack = 1;
  return true;
}

function zombieattackthroughboardsactionterminate(behaviortreeentity, asmstatename) {
  function_28b47cc8(asmstatename);
  return 4;
}

function function_28b47cc8(behaviortreeentity) {
  aiutility::releaseclaimnode(behaviortreeentity);
  behaviortreeentity.boardattack = 0;
  return true;
}

function zombietauntaction(behaviortreeentity, asmstatename) {
  function_eb270aac(behaviortreeentity);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function function_eb270aac(behaviortreeentity) {
  aiutility::keepclaimnode(behaviortreeentity);
  return true;
}

function zombietauntactionterminate(behaviortreeentity, asmstatename) {
  function_ba06c8a0(asmstatename);
  return 4;
}

function function_ba06c8a0(behaviortreeentity) {
  aiutility::releaseclaimnode(behaviortreeentity);
  return true;
}

function zombiemantleaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.clamptonavmesh = 0;

  if(isDefined(behaviortreeentity.attacking_spot_index)) {
    behaviortreeentity.saved_attacking_spot_index = behaviortreeentity.attacking_spot_index;
    behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
  }

  behaviortreeentity.var_9ed3cc11 = behaviortreeentity function_e827fc0e();
  behaviortreeentity pushplayer(1);
  behaviortreeentity.isinmantleaction = 1;
  behaviortreeentity zombie_utility::reset_attack_spot();
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function zombiemantleactionterminate(behaviortreeentity, asmstatename) {
  asmstatename.clamptonavmesh = 1;
  asmstatename.isinmantleaction = undefined;

  if(isDefined(asmstatename.var_9ed3cc11)) {
    asmstatename pushplayer(asmstatename.var_9ed3cc11);
    asmstatename.var_9ed3cc11 = undefined;
  }

  asmstatename zm_behavior_utility::enteredplayablearea();
  return 4;
}

function boardtearmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(mocompanimflag.barrier_align)) {
    origin = getstartorigin(mocompanimflag.barrier_align.origin, mocompanimflag.barrier_align.angles, mocompduration);
    angles = getstartangles(mocompanimflag.barrier_align.origin, mocompanimflag.barrier_align.angles, mocompduration);
  } else {
    origin = getstartorigin(mocompanimflag.first_node.zbarrier.origin, mocompanimflag.first_node.zbarrier.angles, mocompduration);
    angles = getstartangles(mocompanimflag.first_node.zbarrier.origin, mocompanimflag.first_node.zbarrier.angles, mocompduration);
  }

  mocompanimflag forceteleport(origin, angles, 1);
  mocompanimflag.pushable = 0;
  mocompanimflag.blockingpain = 1;
  mocompanimflag animmode("noclip", 1);
  mocompanimflag orientmode("face angle", angles[1]);
}

function boardtearmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration animmode("noclip", 0);
  mocompduration.pushable = 0;
  mocompduration.blockingpain = 1;
}

function barricadeentermocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(mocompanimflag.barrier_align)) {
    origin = getstartorigin(mocompanimflag.barrier_align.origin, mocompanimflag.barrier_align.angles, mocompduration);
    angles = getstartangles(mocompanimflag.barrier_align.origin, mocompanimflag.barrier_align.angles, mocompduration);
  } else {
    zbarrier_origin = isDefined(mocompanimflag.first_node.zbarrier) ? mocompanimflag.first_node.zbarrier.origin : mocompanimflag.first_node.zbarrier_origin;
    var_f4b27846 = isDefined(mocompanimflag.first_node.zbarrier) ? mocompanimflag.first_node.zbarrier.angles : mocompanimflag.first_node.var_f4b27846;
    origin = getstartorigin(zbarrier_origin, var_f4b27846, mocompduration);
    angles = getstartangles(zbarrier_origin, var_f4b27846, mocompduration);
  }

  if(isDefined(mocompanimflag.mocomp_barricade_offset)) {
    origin += anglesToForward(angles) * mocompanimflag.mocomp_barricade_offset;
  }

  mocompanimflag forceteleport(origin, angles, 1);
  mocompanimflag animmode("noclip", 0);
  mocompanimflag orientmode("face angle", angles[1]);
  mocompanimflag.pushable = 0;
  mocompanimflag.blockingpain = 1;
  mocompanimflag pathmode("dont move");
  mocompanimflag.usegoalanimweight = 1;
}

function barricadeentermocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration animmode("noclip", 0);
  mocompduration.pushable = 0;
}

function barricadeentermocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  barricadebreakterminate(mocompduration);
  mocompduration.usegoalanimweight = 0;
}

function barricadeentermocompnozstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(mocompanimflag.barrier_align)) {
    origin = getstartorigin(mocompanimflag.barrier_align.origin, mocompanimflag.barrier_align.angles, mocompduration);
    angles = getstartangles(mocompanimflag.barrier_align.origin, mocompanimflag.barrier_align.angles, mocompduration);
  } else {
    zbarrier_origin = isDefined(mocompanimflag.first_node.zbarrier) ? mocompanimflag.first_node.zbarrier.origin : mocompanimflag.first_node.zbarrier_origin;
    var_f4b27846 = isDefined(mocompanimflag.first_node.zbarrier) ? mocompanimflag.first_node.zbarrier.angles : mocompanimflag.first_node.var_f4b27846;
    origin = getstartorigin(zbarrier_origin, var_f4b27846, mocompduration);
    angles = getstartangles(zbarrier_origin, var_f4b27846, mocompduration);
  }

  if(isDefined(mocompanimflag.mocomp_barricade_offset)) {
    origin += anglesToForward(angles) * mocompanimflag.mocomp_barricade_offset;
  }

  mocompanimflag forceteleport(origin, angles, 1);
  mocompanimflag animmode("noclip", 0);
  mocompanimflag orientmode("face angle", angles[1]);
  mocompanimflag.pushable = 0;
  mocompanimflag.blockingpain = 1;
  mocompanimflag pathmode("dont move");
  mocompanimflag.usegoalanimweight = 1;
}

function barricadeentermocompnozupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration animmode("noclip", 0);
  mocompduration.pushable = 0;
}

function barricadeentermocompnozterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration.pushable = 1;
  mocompduration.blockingpain = 0;
  mocompduration pathmode("move allowed");
  mocompduration.usegoalanimweight = 0;
  mocompduration animmode("normal", 0);
  mocompduration orientmode("face motion");
}

function notetrackboardtear(animationentity) {
  if(isDefined(animationentity.chunk)) {
    animationentity.first_node.zbarrier setzbarrierpiecestate(animationentity.chunk, "opening");
    level notify(#"zombie_board_tear", {
      #ai_zombie: animationentity, #s_board: animationentity.first_node
    });
    animationentity.first_node notify(#"zombie_board_tear");
  }
}

function notetrackboardmelee(animationentity) {
  assert(animationentity.meleeweapon != level.weaponnone, "<dev string:xe3>");

  if(isDefined(animationentity.first_node)) {
    meleedistsq = 8100;

    if(isDefined(level.attack_player_thru_boards_range)) {
      meleedistsq = level.attack_player_thru_boards_range * level.attack_player_thru_boards_range;
    }

    triggerdistsq = 2601;

    for(i = 0; i < animationentity.player_targets.size; i++) {
      if(!isDefined(animationentity.player_targets[i])) {
        continue;
      }

      playerdistsq = distance2dsquared(animationentity.player_targets[i].origin, animationentity.origin);
      heightdiff = abs(animationentity.player_targets[i].origin[2] - animationentity.origin[2]);

      if(playerdistsq < meleedistsq && heightdiff * heightdiff < meleedistsq) {
        playertriggerdistsq = distance2dsquared(animationentity.player_targets[i].origin, animationentity.first_node.trigger_location.origin);
        heightdiff = abs(animationentity.player_targets[i].origin[2] - animationentity.first_node.trigger_location.origin[2]);

        if(playertriggerdistsq < triggerdistsq && heightdiff * heightdiff < triggerdistsq) {
          animationentity.player_targets[i] playsoundtoplayer(#"hash_75318bcffca7ff06", animationentity.player_targets[i]);
          animationentity.player_targets[i] dodamage(animationentity.meleeweapon.meleedamage, animationentity.origin, self, self, "none", "MOD_MELEE");
          break;
        }
      }
    }

    return;
  }

  animationentity melee();
}

function function_b37b8c0d(entity) {
  if(isDefined(entity.first_node)) {
    zm_blockers::open_zbarrier(entity.first_node, 1);
  }
}

function findzombieenemy() {
  if(isDefined(self.var_8b59c468)) {
    self[[self.var_8b59c468]]();
    return;
  }

  zombies = getaispeciesarray(level.zombie_team, "all");
  zombie_enemy = undefined;
  closest_dist = undefined;

  foreach(zombie in zombies) {
    if(isalive(zombie) && is_true(zombie.completed_emerging_into_playable_area) && !zm_utility::is_magic_bullet_shield_enabled(zombie) && is_true(zombie.canbetargetedbyturnedzombies)) {
      dist = distancesquared(self.origin, zombie.origin);

      if(!isDefined(closest_dist) || dist < closest_dist) {
        closest_dist = dist;
        zombie_enemy = zombie;
      }
    }
  }

  self.favoriteenemy = zombie_enemy;

  if(isDefined(self.favoriteenemy)) {
    self setgoal(self.favoriteenemy.origin);
    return;
  }

  self setgoal(self.origin);
}

function zombieblackholebombpullstart(entity, asmstatename) {
  entity.pulltime = gettime();
  entity.pullorigin = entity.origin;
  animationstatenetworkutility::requeststate(entity, asmstatename);
  zombieupdateblackholebombpullstate(entity);

  if(isDefined(entity.damageorigin)) {
    entity.n_zombie_custom_goal_radius = 8;
    entity.v_zombie_custom_goal_pos = entity.damageorigin;
  }

  return 5;
}

function zombieupdateblackholebombpullstate(entity) {
  dist_to_bomb = distancesquared(entity.origin, entity.damageorigin);
  entity setblackboardattribute("_blackholebomb_pull_state", isDefined(entity.var_db490292) ? entity.var_db490292 : "blackholebomb_pull_slow");

  if(dist_to_bomb < (isDefined(entity.var_92b78660) ? entity.var_92b78660 : 16384)) {
    entity._black_hole_bomb_collapse_death = 1;
    return;
  }

  if(dist_to_bomb < 1048576) {
    entity setblackboardattribute("_blackholebomb_pull_state", "blackholebomb_pull_fast");
  }
}

function zombieblackholebombpullupdate(entity, asmstatename) {
  if(!isDefined(asmstatename.interdimensional_gun_kill)) {
    return 4;
  }

  zombieupdateblackholebombpullstate(asmstatename);

  if(is_true(asmstatename._black_hole_bomb_collapse_death)) {
    return 4;
  }

  if(isDefined(asmstatename.damageorigin)) {
    asmstatename.v_zombie_custom_goal_pos = asmstatename.damageorigin;
  }

  if(!is_true(asmstatename.missinglegs) && gettime() - asmstatename.pulltime > 1000) {
    distsq = distance2dsquared(asmstatename.origin, asmstatename.pullorigin);

    if(distsq < 144) {
      asmstatename setavoidancemask("avoid all");
      asmstatename.cant_move = 1;

      if(isDefined(asmstatename.cant_move_cb)) {
        asmstatename thread[[asmstatename.cant_move_cb]]();
      }
    } else {
      asmstatename setavoidancemask("avoid none");
      asmstatename.cant_move = 0;
    }

    asmstatename.pulltime = gettime();
    asmstatename.pullorigin = asmstatename.origin;
  }

  return 5;
}

function zombieblackholebombpullend(entity, asmstatename) {
  asmstatename.v_zombie_custom_goal_pos = undefined;
  asmstatename.n_zombie_custom_goal_radius = undefined;
  asmstatename.pulltime = undefined;
  asmstatename.pullorigin = undefined;
  return 4;
}

function zombiekilledwhilegettingpulled(entity) {
  if(!is_true(self.missinglegs) && is_true(entity.interdimensional_gun_kill) && !is_true(entity._black_hole_bomb_collapse_death)) {
    return true;
  }

  return false;
}

function zombiekilledbyblackholebombcondition(entity) {
  if(is_true(entity._black_hole_bomb_collapse_death)) {
    return true;
  }

  return false;
}

function function_38fec26f(entity) {
  if(is_true(entity.freezegun_death)) {
    return true;
  }

  return false;
}

function function_e4d7303f(entity) {
  return is_true(entity.var_69a981e6);
}

function function_17cd1b17(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.enemy)) {
    return false;
  }

  meleedistsq = 4096;

  if(isDefined(behaviortreeentity.meleeweapon) && behaviortreeentity.meleeweapon !== level.weaponnone) {
    meleedistsq = behaviortreeentity.meleeweapon.aimeleerange * behaviortreeentity.meleeweapon.aimeleerange;
  }

  if(distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > meleedistsq) {
    return false;
  }

  return isDefined(behaviortreeentity.melee_cooldown) && gettime() < behaviortreeentity.melee_cooldown;
}

function zombiekilledbyblackholebombstart(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);

  if(isDefined(level.black_hole_bomb_death_start_func)) {
    entity thread[[level.black_hole_bomb_death_start_func]](entity.damageorigin, entity.interdimensional_gun_projectile);
  }

  return 5;
}

function zombiekilledbyblackholebombend(entity, asmstatename) {
  if(isDefined(level._effect) && isDefined(level._effect[#"black_hole_bomb_zombie_gib"])) {
    fxorigin = asmstatename gettagorigin("tag_origin");
    forward = anglesToForward(asmstatename.angles);
    playFX(level._effect[#"black_hole_bomb_zombie_gib"], fxorigin, forward, (0, 0, 1));
  }

  asmstatename hide();
  return 4;
}

function zombiebhbburst(entity) {
  if(isDefined(level._effect) && isDefined(level._effect[#"black_hole_bomb_zombie_destroy"])) {
    fxorigin = entity gettagorigin("tag_origin");
    playFX(level._effect[#"black_hole_bomb_zombie_destroy"], fxorigin);
  }

  if(isDefined(entity.interdimensional_gun_projectile)) {
    entity.interdimensional_gun_projectile notify(#"black_hole_bomb_kill");
  }
}

function function_b654f4f5(entity) {
  if(isDefined(level.var_58e6238)) {
    entity[[level.var_58e6238]]();
  }

  return 5;
}

function function_36b3cb7d(entity) {
  if(isDefined(level.var_f975b6ae)) {
    entity[[level.var_f975b6ae]]();
  }
}

function function_e403e74e(damage, weapon, target) {
  var_2a3ef77c = weapons::function_74bbb3fa(damage, weapon, target);

  if(var_2a3ef77c > damage) {
    return 1.5;
  }

  return 1;
}

function function_671249fb(weakpoint, eattacker, var_3cddb028, var_a8ea4441 = 1) {
  namespace_81245006::damageweakpoint(weakpoint, var_3cddb028);

  if(namespace_81245006::function_f29756fe(weakpoint) === 3 && isDefined(weakpoint.var_f371ebb0)) {
    destructserverutils::function_8475c53a(self, weakpoint.var_f371ebb0);

    if(isPlayer(eattacker)) {
      eattacker zm_stats::increment_challenge_stat(#"hash_2805701e53ce32a1");

      if(var_a8ea4441) {
        level scoreevents::doscoreeventcallback("scoreEventZM", {
          #attacker: eattacker, #scoreevent: "destroyed_armor_zm"});
      }
    }

    self.var_426947c4 = 1;

    if(weakpoint.var_f371ebb0 === "body_armor") {
      callback::callback(#"hash_7d67d0e9046494fb");
    }
  }
}

function function_29c1ba76(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  self.var_426947c4 = undefined;
  var_ebcff177 = 1;

  if(namespace_81245006::hasarmor(self) && (psoffsettime === "MOD_PROJECTILE_SPLASH" || psoffsettime === "MOD_GRENADE_SPLASH" || psoffsettime == "MOD_EXPLOSIVE")) {
    var_3cddb028 = 0.5 * shitloc;
    var_31e96b81 = int(var_3cddb028);

    foreach(weakpoint in self.var_5ace757d) {
      if(weakpoint.type === # "armor" && weakpoint.currstate === 1) {
        self function_671249fb(weakpoint, vdir, var_3cddb028);
      }
    }
  }

  if(namespace_81245006::hasarmor(self) && psoffsettime === "MOD_CRUSH") {
    var_3cddb028 = 0.5 * shitloc;
    var_31e96b81 = int(var_3cddb028);

    foreach(weakpoint in self.var_5ace757d) {
      if(weakpoint.type === # "armor" && weakpoint.currstate === 1) {
        self function_671249fb(weakpoint, vdir, var_3cddb028, 0);
      }
    }
  }

  w_base = zm_weapons::get_base_weapon(boneindex);
  weapclass = level.zombie_weapons[w_base].weapon_classname;

  if((weapclass === "special" || weapclass === "launcher") && surfacetype === "none") {
    var_3cddb028 = shitloc;
    var_93c42150 = namespace_81245006::function_fab3ee3e(self);

    foreach(weakpoint in var_93c42150) {
      if(weakpoint.type === # "armor") {
        if(isPlayer(vdir)) {
          n_tier = vdir namespace_b61a349a::function_998f8321(boneindex);

          switch (weapclass) {
            case # "launcher":
            case # "special":
              if(n_tier >= 2 && n_tier < 5) {
                var_3cddb028 += var_3cddb028 * 0.1;
              } else if(n_tier >= 5) {
                var_3cddb028 += var_3cddb028 * 0.25;
              }

              break;
          }

          self function_671249fb(weakpoint, vdir, var_3cddb028);
        }
      }
    }
  }

  weakpoint = namespace_81245006::function_3131f5dd(self, surfacetype, 1);

  if(isDefined(weakpoint) && weakpoint.type === # "armor") {
    var_3cddb028 = shitloc * function_ac6dcd03(self, boneindex, vdir);
    var_3cddb028 = int(var_3cddb028);
    self function_671249fb(weakpoint, vdir, var_3cddb028);
    var_36d55c9c = function_c5a2dbe5(self, boneindex, vdir);

    if(isPlayer(vdir)) {
      if(self.subarchetype === # "hash_7a778318514578f7") {
        shitloc = int(shitloc * 0.35 * var_36d55c9c);
        vdir namespace_b61a349a::function_8a6ccd14(boneindex, n_tier, undefined, shitloc);
      } else if(self.subarchetype === # "zombie_medium_armor") {
        shitloc = int(shitloc * 0.5 * var_36d55c9c);
        vdir namespace_b61a349a::function_8a6ccd14(boneindex, n_tier, undefined, shitloc);
      }
    }

    self.var_67f98db0 = 1;
    var_ebcff177 = 3;
    var_43f0e034 = function_f4e9bba4(self);
    self function_2d4173a8(var_43f0e034);
  }

  return {
    #damage: shitloc, #weakpoint: weakpoint, #var_ebcff177: var_ebcff177
  };
}

function function_ac6dcd03(entity, weapon, eattacker) {
  damage_mod = 1;

  if(isDefined(eattacker)) {
    damage_mod *= function_e403e74e(1, eattacker, weapon);
  }

  return damage_mod;
}

function function_c5a2dbe5(entity, weapon, eattacker) {
  damage_mod = 1;

  if(isDefined(weapon)) {
    w_base = zm_weapons::get_base_weapon(weapon);
    weapclass = level.zombie_weapons[w_base].weapon_classname;
  }

  if(isPlayer(eattacker)) {
    if(isDefined(weapclass)) {
      n_tier = eattacker namespace_b61a349a::function_998f8321(weapon);

      switch (weapclass) {
        case # "lmg":
        case # "sniper":
        case # "launcher":
        case # "special":
          if(n_tier >= 2) {
            damage_mod = n_tier >= 4 ? 1.25 : 1.1;
          }

          break;
        case # "pistol":
        case # "shotgun":
          if(n_tier >= 3) {
            damage_mod = 1.1;
          }

          break;
      }
    }

    if(eattacker namespace_e86ffa8::function_7bf30775(2)) {
      damage_mod *= 1.5;
    }

    if(eattacker namespace_e86ffa8::function_cb561923(4)) {
      damage_mod *= 1.25;
    }
  }

  return damage_mod;
}

function function_f4e9bba4(entity) {
  max_health = 0;
  curr_health = 0;
  weakpoints = namespace_81245006::function_fab3ee3e(entity);

  if(!isDefined(weakpoints)) {
    return 0;
  }

  foreach(weakpoint in weakpoints) {
    if(weakpoint.type === # "armor") {
      max_health += weakpoint.maxhealth;
      curr_health += max(weakpoint.health, 0);
    }
  }

  if(max_health == 0) {
    return 0;
  }

  return curr_health / max_health;
}

function function_7994fd99(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isDefined(damage) && isactor(damage) && self.team == damage.team) {
    return -1;
  }

  if(self.archetype == # "zombie" && !isDefined(self.subarchetype)) {
    self destructserverutils::handledamage(attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
  }

  return -1;
}

function function_95578a3c(willbekilled, inflictor, attacker, damage, flags, mod, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(!isDefined(self.var_448aebc7)) {
    self.var_448aebc7 = [];
  }

  if(isDefined(boneindex) && isDefined(surfacetype)) {
    if(!isDefined(self.var_448aebc7[boneindex getentitynumber()])) {
      self.var_448aebc7[boneindex getentitynumber()] = 0;
    }

    self.var_448aebc7[boneindex getentitynumber()] += surfacetype;
  }
}

function function_92dcde87(start_pos, end_pos, velocity, var_781a6f9a, enemy) {
  gravity = getdvarfloat(#"bg_lowgravity");

  if(velocity[2] > 0) {
    tapex = velocity[2] / gravity;
    tmidnear = tapex * 0.5;
    tdiscriminant = tapex * tapex + 2 * (start_pos[2] - end_pos[2]) / gravity;

    if(tdiscriminant <= 0) {
      return false;
    }

    var_3ebd279c = 0.5 * sqrt(tdiscriminant);
  } else {
    tapex = 0;
    tmidnear = 0;
    tdiscriminant = velocity[2] * velocity[2] + 2 * (start_pos[2] - end_pos[2]) * gravity;

    if(tdiscriminant <= 0) {
      return false;
    }

    var_3ebd279c = 0.5 * (velocity[2] + sqrt(tdiscriminant)) / gravity;
  }

  tmidfar = tapex + var_3ebd279c;

  if(!isDefined(var_781a6f9a)) {
    var_781a6f9a = tmidfar;
  }

  times = [tmidnear, tapex, tmidfar];
  points = [start_pos];

  for(i = 0; i < times.size; i++) {
    if(var_781a6f9a < times[i]) {
      break;
    }

    points[points.size] = (start_pos[0] + times[i] * velocity[0], start_pos[1] + times[i] * velocity[1], start_pos[2] + times[i] * (velocity[2] - 0.5 * gravity * times[i]));
  }

  if(var_781a6f9a != times[times.size - 1]) {
    var_7f856c1e = (start_pos[0] + var_781a6f9a * velocity[0], start_pos[1] + var_781a6f9a * velocity[1], start_pos[2] + var_781a6f9a * (velocity[2] - 0.5 * gravity * var_781a6f9a));

    if(points.size <= 1 && distancesquared(start_pos, end_pos) < distancesquared(start_pos, var_7f856c1e)) {
      points[points.size] = end_pos;
    } else {
      points[points.size] = var_7f856c1e;
    }
  }

  if(getdvarint(#"hash_2c509ee80b516880", 0)) {
    hit_something = 0;

    for(i = 0; i < points.size - 1; i++) {
      if(!hit_something) {
        traceresults = bulletTrace(points[i], points[i + 1], 0, self);

        if(traceresults[#"fraction"] < 1) {
          hit_point = vectorlerp(points[i], points[i + 1], traceresults[#"fraction"]);
          recordline(points[i], hit_point, (0, 1, 0), "<dev string:x109>");
          recordline(hit_point, points[i + 1], (1, 0, 0), "<dev string:x109>");
          hit_something = 1;
        } else {
          recordline(points[i], points[i + 1], (0, 1, 0), "<dev string:x109>");
        }

        continue;
      }

      recordline(points[i], points[i + 1], (1, 0, 0), "<dev string:x109>");
    }
  }

  player_vehicle = undefined;

  if(isPlayer(enemy) && enemy isinvehicle()) {
    player_vehicle = enemy getvehicleoccupied();
  }

  for(i = 0; i < points.size - 1; i++) {
    if(isDefined(self.var_f7c8ccf5) && ![[self.var_f7c8ccf5]](self, points[i], points[i + 1])) {
      return false;
    }

    if(!bullettracepassed(points[i], points[i + 1], 0, self, player_vehicle)) {
      return false;
    }
  }

  return true;
}

function function_4a99b560(entity, enemy) {
  if(getdvarint(#"hash_2c509ee80b516880", 0)) {
    if(isDefined(enemy)) {
      start_pos = entity.origin + (0, 0, entity function_6a9ae71());
      target_pos = enemy gettagorigin("<dev string:x113>");
      to_target = target_pos - start_pos;

      if(to_target === (0, 0, 0)) {
        record3dtext("<dev string:x11f>", entity.origin, false ? (0, 1, 0) : (1, 0, 0), "<dev string:x109>", entity);
        return false;
      }

      time = max(length((to_target[0], to_target[1], 0)) / 700, 0.1);
      launch_speed = (0.5 * getdvarfloat(#"bg_lowgravity", 400) * sqr(time) + to_target[2]) / time;
      to_target = vectornormalize((to_target[0], to_target[1], 0)) * 700;
    }

    var_8a34a513 = isDefined(enemy) && isarray(enemy.var_f904e440);
    var_79637724 = var_8a34a513 && isinarray(enemy.var_f904e440, entity);
    var_b295b952 = !isDefined(enemy) || !zm_utility::is_classic() && distance2dsquared(entity.origin, enemy.origin) <= sqr(100);
    var_6c2051ca = !isDefined(enemy) || !entity function_92dcde87(start_pos, target_pos, (to_target[0], to_target[1], launch_speed), time, enemy);
    record3dtext("<dev string:x137>", entity.origin, var_8a34a513 ? (0, 1, 0) : (1, 0, 0), "<dev string:x109>", entity);
    record3dtext("<dev string:x152>", entity.origin, var_79637724 ? (0, 1, 0) : (1, 0, 0), "<dev string:x109>", entity);
    record3dtext("<dev string:x16c>", entity.origin, var_b295b952 ? (1, 0, 0) : (0, 1, 0), "<dev string:x109>", entity);
    record3dtext("<dev string:x185>", entity.origin, var_6c2051ca ? (1, 0, 0) : (0, 1, 0), "<dev string:x109>", entity);
    return (var_8a34a513 && var_79637724 && !var_b295b952 && !var_6c2051ca);
  }

  if(!isDefined(enemy.var_f904e440)) {
    return false;
  }

  start_pos = entity.origin + (0, 0, entity function_6a9ae71());
  target_pos = enemy.origin + (0, 0, 46);
  to_target = target_pos - start_pos;

  if(to_target === (0, 0, 0)) {
    return false;
  }

  time = max(length((to_target[0], to_target[1], 0)) / 700, 0.1);
  var_64b12059 = enemy namespace_98decc78::function_be5f206(start_pos, target_pos, time);

  if(isDefined(var_64b12059) && var_64b12059 !== start_pos) {
    target_pos = var_64b12059;
    to_target = target_pos - start_pos;
  }

  launch_speed = (0.5 * getdvarfloat(#"bg_lowgravity", 400) * sqr(time) + to_target[2]) / time;
  to_target = vectornormalize((to_target[0], to_target[1], 0)) * 700;

  if(zm_utility::is_survival() && isDefined(entity.current_state) && entity.current_state.name !== # "chase" || zm_utility::is_survival() && distance2dsquared(entity.origin, enemy.origin) <= sqr(100) || !isinarray(enemy.var_f904e440, entity) || !entity function_92dcde87(start_pos, target_pos, (to_target[0], to_target[1], launch_speed), time, enemy)) {
    return false;
  }

  return true;
}

function function_e5f60f55(entity) {
  enemy = zm_ai_utility::function_825317c(entity);

  if(!isDefined(enemy.var_f904e440)) {
    enemy.var_f904e440 = [];
  }

  arrayremovevalue(enemy.var_f904e440, undefined);
  var_a702ff0 = [];

  foreach(zombie in enemy.var_f904e440) {
    if(zombie.enemy !== enemy || zm_utility::is_survival() && isDefined(zombie.current_state) && zombie.current_state.name !== # "chase") {
      var_a702ff0[var_a702ff0.size] = zombie;
    }
  }

  foreach(zombie in var_a702ff0) {
    arrayremovevalue(enemy.var_f904e440, zombie);
  }

  if(!isinarray(enemy.var_f904e440, entity) && enemy.var_f904e440.size < (zm_utility::is_survival() ? 24 : 24)) {
    enemy.var_f904e440[enemy.var_f904e440.size] = entity;
  }

  if(isinarray(enemy.var_f904e440, entity)) {
    if(!isDefined(entity.var_6ca50f69)) {
      entity.var_6ca50f69 = 0;
    }

    if(function_4a99b560(entity, enemy)) {
      entity.var_8c4d3e5d = 1;
      entity.var_6ca50f69 = 0;
      entity setgoal(entity.origin);
      entity.var_95d1c014 = undefined;
      entity.keep_moving = 0;
      return;
    }

    step_size = max(100 - distance2d(entity.origin, entity.enemy.origin), 64 + entity.var_6ca50f69 * 64);

    if(zm_utility::is_classic() || zm_utility::function_c200446c()) {
      if(isDefined(enemy.last_valid_position)) {
        entity.var_6ca50f69 = 0;
        entity setgoal(enemy.last_valid_position);
        entity.var_95d1c014 = undefined;
        return;
      }
    }

    if(isDefined(entity.var_6bc9818) && is_true(entity[[entity.var_6bc9818]]())) {
      return;
    }

    var_e737d2f1 = function_c41c61e8(step_size);

    if(isDefined(var_e737d2f1)) {
      entity.var_6ca50f69 = 0;
      entity setgoal(var_e737d2f1);
      entity.var_95d1c014 = undefined;
      return;
    }

    reacquirestep = entity reacquirestep(step_size, 1);

    if(isDefined(reacquirestep)) {
      entity.var_6ca50f69 = 0;
      entity setgoal(reacquirestep);
      entity.var_95d1c014 = undefined;
      return;
    }

    entity.var_6ca50f69++;

    if(entity.var_6ca50f69 > 4) {
      entity.var_6ca50f69 = undefined;

      if(isDefined(enemy) && isarray(enemy.var_f904e440)) {
        arrayremovevalue(enemy.var_f904e440, entity);
      }

      if(zm_utility::is_survival()) {
        awareness::set_state(entity, #"wander");
      }
    }
  }
}

function private function_c41c61e8(step_size) {
  dir = self.origin - self.enemy.origin;
  dir = vectornormalize((dir[0], dir[1], 0));
  start_point = getclosestpointonnavmesh(self.origin);

  if(isDefined(start_point)) {
    point = checknavmeshdirection(start_point, dir, step_size, self getpathfindingradius() * 1.2);

    if(isDefined(point) && point != start_point && !self isposinclaimedlocation(point) && distancesquared(point, self.origin) > sqr(self.goalradius)) {
      eye_offset = self geteyeapprox() - self.origin;

      recordline(point + eye_offset, self.enemy getEye(), (1, 0.5, 0), "<dev string:x109>", self);

      if(sighttracepassed(point + eye_offset, self.enemy getEye(), 0, self)) {
        return point;
      }
    }
  }
}

function function_8158e9a0() {
  if(namespace_81245006::hasarmor(self)) {
    destructserverutils::function_8475c53a(self, #"helmet");
  }
}

function function_cea9ab47(entity) {
  namespace_81245006::initweakpoints(self);
  self callback::function_d8abfc3d(#"head_gibbed", &function_8158e9a0);

  if(!isDefined(entity.subarchetype)) {
    return;
  }

  self.no_powerups = zm_utility::is_survival();

  switch (entity.subarchetype) {
    case # "zombie_medium_armor":
      entity attach("c_t9_zmb_zombie_medium_helmet");
      entity attach("c_t9_zmb_zombie_medium_armor");
      self function_2d4173a8(1);
      break;
    case # "hash_7a778318514578f7":
      if(isDefined(level.var_eea9f85a)) {
        entity attach(level.var_eea9f85a);
      } else {
        entity attach("c_t9_zmb_zombie_heavy_torso_armor");
      }

      if(isDefined(level.var_9e513533)) {
        entity attach(level.var_9e513533);
      } else {
        entity attach("c_t9_zmb_zombie_heavy_helmet");
      }

      entity attach("c_t9_zmb_zombie_heavy_arm_armor_lt");
      entity attach("c_t9_zmb_zombie_heavy_arm_armor_rt");
      entity attach("c_t9_zmb_zombie_heavy_leg_armor_lt");
      entity attach("c_t9_zmb_zombie_heavy_leg_armor_rt");
      self function_2d4173a8(1);
      break;
  }

  entity destructserverutils::togglespawngibs(entity, 1);
}

function function_35228e0b(entity) {
  entity.var_6c5c29fb = undefined;

  if(isPlayer(entity.enemy) && entity.enemy isinvehicle()) {
    entity.var_6c5c29fb = namespace_85745671::function_401070dd(entity.enemy getvehicleoccupied(), entity.enemy);
  }
}

function function_ed33f941(entity) {
  if(isDefined(entity.zombie_poi) || isDefined(entity.enemy_override)) {
    return false;
  }

  if(!isDefined(entity.var_b3538985) || !isDefined(entity.enemy)) {
    return false;
  }

  if(abs(entity.origin[2] - entity.var_b3538985[2]) > (isDefined(entity.var_737e8510) ? entity.var_737e8510 : 64)) {
    return false;
  }

  if(distancesquared(entity.origin, entity.var_b3538985) > entity.meleedistsq) {
    return false;
  }

  yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);

  if(abs(yawtoenemy) > (isDefined(entity.var_1c0eb62a) ? entity.var_1c0eb62a : 60)) {
    return true;
  }

  return false;
}