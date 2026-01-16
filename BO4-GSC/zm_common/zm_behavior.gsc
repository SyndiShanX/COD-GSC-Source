/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_behavior.gsc
***********************************************/

#include scripts\core_common\ai\archetype_locomotion_utility;
#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\animation_state_machine_mocomp;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\destructible_character;
#include scripts\core_common\ai\zombie;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\ai\zm_ai_utility;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_attackables;
#include scripts\zm_common\zm_behavior_utility;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_behavior;

autoexec __init__system__() {
  system::register(#"zm_behavior", &__init__, &__main__, undefined);
}

__init__() {
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
  level.do_randomized_zigzag_path = 1;
  level.zombie_targets = [];
  zm::register_actor_damage_callback(&function_7994fd99);
}

private zombiespawninit() {
  self pushplayer(0);
  self collidewithactors(0);
  self thread zm_utility::function_13cc9756();
  self.closest_player_override = &zm_utility::function_c52e1749;
  self.var_1731eda3 = 1;
  self.var_2c628c0f = 1;
  self.am_i_valid = 1;
  self.cant_move_cb = &zombiebehavior::function_22762653;
  self zm_spawner::zombie_spawn_init();
}

private function_c15c6e44() {
  self endon(#"death");
  self waittill(#"completed_emerging_into_playable_area");
  self.var_641025d6 = gettime() + self ai::function_9139c839().var_9c0ebe1e;
}

private __main__() {
  array::thread_all(level.zombie_spawners, &spawner::add_spawn_function, &function_57d3b5eb);
}

function_57d3b5eb() {
  if(isDefined(self._starting_round_number)) {
    self.maxhealth = int(zombie_utility::ai_calculate_health(zombie_utility::get_zombie_var(#"zombie_health_start"), self._starting_round_number) * (isDefined(level.var_46e03bb6) ? level.var_46e03bb6 : 1));
    self.health = self.maxhealth;
  } else {
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

  if(!isDefined(self.no_eye_glow) || !self.no_eye_glow) {
    if(!(isDefined(self.is_inert) && self.is_inert)) {
      self thread zombie_utility::delayed_zombie_eye_glow();
    }
  }

  if(isDefined(level.zombie_init_done)) {
    self[[level.zombie_init_done]]();
  }

  self.zombie_init_done = 1;
  self zm_score::function_82732ced();
  self notify(#"zombie_init_done");
}

private initzmbehaviorsandasm() {
  assert(isscriptfunctionptr(&shouldmovecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmove", &shouldmovecondition);
  assert(isscriptfunctionptr(&zombieshouldtearcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldtear", &zombieshouldtearcondition);
  assert(isscriptfunctionptr(&zombieshouldattackthroughboardscondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldattackthroughboards", &zombieshouldattackthroughboardscondition);
  assert(isscriptfunctionptr(&zombieshouldtauntcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldtaunt", &zombieshouldtauntcondition);
  assert(isscriptfunctionptr(&zombiegottoentrancecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegottoentrance", &zombiegottoentrancecondition);
  assert(isscriptfunctionptr(&zombiegottoattackspotcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegottoattackspot", &zombiegottoattackspotcondition);
  assert(isscriptfunctionptr(&zombiehasattackspotalreadycondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiehasattackspotalready", &zombiehasattackspotalreadycondition);
  assert(isscriptfunctionptr(&zombieshouldenterplayablecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldenterplayable", &zombieshouldenterplayablecondition);
  assert(isscriptfunctionptr(&ischunkvalidcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"ischunkvalid", &ischunkvalidcondition);
  assert(isscriptfunctionptr(&inplayablearea));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"inplayablearea", &inplayablearea);
  assert(isscriptfunctionptr(&shouldskipteardown));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldskipteardown", &shouldskipteardown);
  assert(isscriptfunctionptr(&zombieisthinkdone));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisthinkdone", &zombieisthinkdone);
  assert(isscriptfunctionptr(&zombieisatgoal));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisatgoal", &zombieisatgoal);
  assert(isscriptfunctionptr(&zombieisatentrance));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisatentrance", &zombieisatentrance);
  assert(isscriptfunctionptr(&zombieshouldmoveawaycondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmoveaway", &zombieshouldmoveawaycondition);
  assert(isscriptfunctionptr(&waskilledbyteslacondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"waskilledbytesla", &waskilledbyteslacondition);
  assert(isscriptfunctionptr(&zombieshouldstun));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldstun", &zombieshouldstun);
  assert(isscriptfunctionptr(&zombieisbeinggrappled));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisbeinggrappled", &zombieisbeinggrappled);
  assert(isscriptfunctionptr(&zombieshouldknockdown));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldknockdown", &zombieshouldknockdown);
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
  assert(isscriptfunctionptr(&disablepowerups));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"disablepowerups", &disablepowerups);
  assert(isscriptfunctionptr(&enablepowerups));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"enablepowerups", &enablepowerups);
  assert(!isDefined(&zombiemovetoentranceaction) || isscriptfunctionptr(&zombiemovetoentranceaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombiemovetoentranceactionterminate) || isscriptfunctionptr(&zombiemovetoentranceactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemovetoentranceaction", &zombiemovetoentranceaction, undefined, &zombiemovetoentranceactionterminate);
  assert(!isDefined(&zombiemovetoattackspotaction) || isscriptfunctionptr(&zombiemovetoattackspotaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombiemovetoattackspotactionterminate) || isscriptfunctionptr(&zombiemovetoattackspotactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemovetoattackspotaction", &zombiemovetoattackspotaction, undefined, &zombiemovetoattackspotactionterminate);
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
  assert(!isDefined(&zombieholdboardaction) || isscriptfunctionptr(&zombieholdboardaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombieholdboardactionterminate) || isscriptfunctionptr(&zombieholdboardactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"holdboardaction", &zombieholdboardaction, undefined, &zombieholdboardactionterminate);
  assert(!isDefined(&zombiegrabboardaction) || isscriptfunctionptr(&zombiegrabboardaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombiegrabboardactionterminate) || isscriptfunctionptr(&zombiegrabboardactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"grabboardaction", &zombiegrabboardaction, undefined, &zombiegrabboardactionterminate);
  assert(!isDefined(&zombiepullboardaction) || isscriptfunctionptr(&zombiepullboardaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombiepullboardactionterminate) || isscriptfunctionptr(&zombiepullboardactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"pullboardaction", &zombiepullboardaction, undefined, &zombiepullboardactionterminate);
  assert(!isDefined(&zombieattackthroughboardsaction) || isscriptfunctionptr(&zombieattackthroughboardsaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombieattackthroughboardsactionterminate) || isscriptfunctionptr(&zombieattackthroughboardsactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombieattackthroughboardsaction", &zombieattackthroughboardsaction, undefined, &zombieattackthroughboardsactionterminate);
  assert(!isDefined(&zombietauntaction) || isscriptfunctionptr(&zombietauntaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombietauntactionterminate) || isscriptfunctionptr(&zombietauntactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombietauntaction", &zombietauntaction, undefined, &zombietauntactionterminate);
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
  assert(isscriptfunctionptr(&zombiegrappleactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegrappleactionstart", &zombiegrappleactionstart);
  assert(isscriptfunctionptr(&zombieknockdownactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieknockdownactionstart", &zombieknockdownactionstart);
  assert(isscriptfunctionptr(&function_c8939973));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_a6273a84b4237ce", &function_c8939973);
  assert(isscriptfunctionptr(&zombiegetupactionterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegetupactionterminate", &zombiegetupactionterminate);
  assert(isscriptfunctionptr(&zombiepushedactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiepushedactionstart", &zombiepushedactionstart);
  assert(isscriptfunctionptr(&zombiepushedactionterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiepushedactionterminate", &zombiepushedactionterminate);
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
  assert(isscriptfunctionptr(&updatechunkservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"updatechunkservice", &updatechunkservice);
  assert(isscriptfunctionptr(&updateattackspotservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"updateattackspotservice", &updateattackspotservice);
  assert(isscriptfunctionptr(&findnodesservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"findnodesservice", &findnodesservice);
  assert(isscriptfunctionptr(&zombieattackableobjectservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieattackableobjectservice", &zombieattackableobjectservice);
  assert(isscriptfunctionptr(&function_fb814207));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiefindfleshservice", &function_fb814207, 2);
  assert(isscriptfunctionptr(&function_f637b05d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_712f0844b14c72fe", &function_f637b05d, 1);
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
  setdvar(#"scr_zm_use_code_enemy_selection", 0);
}

function_fb814207(behaviortreeentity) {
  if(isDefined(self.var_72411ccf)) {
    self[[self.var_72411ccf]](self);
    return;
  }

  self zombiefindflesh(self);
}

zombiefindflesh(behaviortreeentity) {
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
    return;
  }

  if(isDefined(behaviortreeentity.var_67faa700) && behaviortreeentity.var_67faa700) {
    return;
  }

  if(behaviortreeentity getpathmode() == "dont move") {
    return;
  }

  behaviortreeentity.ignore_player = [];
  behaviortreeentity.goalradius = 30;

  if(isDefined(behaviortreeentity.ignore_find_flesh) && behaviortreeentity.ignore_find_flesh) {
    return;
  }

  if(behaviortreeentity.team == #"allies") {
    behaviortreeentity findzombieenemy();
    return;
  }

  if(zombieshouldmoveawaycondition(behaviortreeentity)) {
    return;
  }

  zombie_poi = behaviortreeentity zm_utility::get_zombie_point_of_interest(behaviortreeentity.origin);
  behaviortreeentity.zombie_poi = zombie_poi;

  if(isDefined(zombie_poi) && isDefined(level.var_4e4950d1)) {
    if(![
        [level.var_4e4950d1]
      ](behaviortreeentity.zombie_poi)) {
      behaviortreeentity.zombie_poi = undefined;
    }
  }

  players = getplayers();

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

  if(isDefined(behaviortreeentity.var_93a62fe) && isDefined(behaviortreeentity.var_93a62fe.b_is_designated_target) && behaviortreeentity.var_93a62fe.b_is_designated_target) {
    designated_target = 1;
  }

  if(!isDefined(behaviortreeentity.var_93a62fe) && !isDefined(zombie_poi) && !isDefined(behaviortreeentity.attackable)) {
    if(isDefined(behaviortreeentity.ignore_player)) {
      if(isDefined(level._should_skip_ignore_player_logic) && [
          [level._should_skip_ignore_player_logic]
        ]()) {
        return;
      }

      behaviortreeentity.ignore_player = [];
    }

    if(isDefined(behaviortreeentity.ispuppet) && behaviortreeentity.ispuppet) {
      return;
    }

      if(isDefined(level.no_target_override)) {
        [
          [level.no_target_override]
        ](behaviortreeentity);
        return;
      }

    behaviortreeentity setgoal(behaviortreeentity.origin);
    return;
  } else if(isDefined(level.var_d22435d9)) {
    [[level.var_d22435d9]](behaviortreeentity);
  }

  if(!isDefined(level.var_4bde8b8f) || ![[level.var_4bde8b8f]]()) {
    behaviortreeentity.enemyoverride = behaviortreeentity.zombie_poi;
    behaviortreeentity.favoriteenemy = behaviortreeentity.var_93a62fe;
  }

  if(isDefined(behaviortreeentity.v_zombie_custom_goal_pos)) {
    goalpos = behaviortreeentity.v_zombie_custom_goal_pos;

    if(isDefined(behaviortreeentity.n_zombie_custom_goal_radius)) {
      behaviortreeentity.goalradius = behaviortreeentity.n_zombie_custom_goal_radius;
    }

    behaviortreeentity setgoal(goalpos);
  } else if(isDefined(behaviortreeentity.enemyoverride) && isDefined(behaviortreeentity.enemyoverride[1])) {
    behaviortreeentity.has_exit_point = undefined;
    goalpos = behaviortreeentity.enemyoverride[0];

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
  } else if(isDefined(behaviortreeentity.attackable) && !designated_target) {
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
    }
  } else if(isDefined(behaviortreeentity.favoriteenemy)) {
    behaviortreeentity.has_exit_point = undefined;
    behaviortreeentity val::reset(#"attack_properties", "ignoreall");

    if(isDefined(level.enemy_location_override_func)) {
      goalpos = [
        [level.enemy_location_override_func]
      ](behaviortreeentity, behaviortreeentity.favoriteenemy);

      if(isDefined(goalpos)) {
        behaviortreeentity setgoal(goalpos);
      } else {
        behaviortreeentity zombieupdategoal();
      }
    } else if(isDefined(behaviortreeentity.is_rat_test) && behaviortreeentity.is_rat_test) {} else if(zombieshouldmoveawaycondition(behaviortreeentity)) {} else {
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

function_f637b05d(behaviortreeentity) {
  behaviortreeentity.var_93a62fe = zm_utility::get_closest_valid_player(behaviortreeentity.origin, behaviortreeentity.ignore_player);
}

zombiefindfleshcode(behaviortreeentity) {
  aiprofile_beginentry("zombieFindFleshCode");

  if(level.intermission) {
    aiprofile_endentry();
    return;
  }

  behaviortreeentity.ignore_player = [];
  behaviortreeentity.goalradius = 30;

  if(behaviortreeentity.team == #"allies") {
    behaviortreeentity findzombieenemy();
    aiprofile_endentry();
    return;
  }

  if(level.wait_and_revive) {
    aiprofile_endentry();
    return;
  }

  if(level.zombie_poi_array.size > 0) {
    zombie_poi = behaviortreeentity zm_utility::get_zombie_point_of_interest(behaviortreeentity.origin);
  }

  behaviortreeentity zombie_utility::run_ignore_player_handler();
  zm_utility::update_valid_players(behaviortreeentity.origin, behaviortreeentity.ignore_player);

  if(!isDefined(behaviortreeentity.enemy) && !isDefined(zombie_poi)) {

    if(isDefined(behaviortreeentity.ispuppet) && behaviortreeentity.ispuppet) {
      aiprofile_endentry();
      return;
    }

      if(isDefined(level.no_target_override)) {
        [
          [level.no_target_override]
        ](behaviortreeentity);
      }
    else {
      behaviortreeentity setgoal(behaviortreeentity.origin);
    }

    aiprofile_endentry();
    return;
  }

  behaviortreeentity.enemyoverride = zombie_poi;

  if(isDefined(behaviortreeentity.enemyoverride) && isDefined(behaviortreeentity.enemyoverride[1])) {
    behaviortreeentity.has_exit_point = undefined;
    goalpos = behaviortreeentity.enemyoverride[0];
    queryresult = positionquery_source_navigation(goalpos, 0, 48, 36, 4);

    foreach(point in queryresult.data) {
      goalpos = point.origin;
      break;
    }

    behaviortreeentity setgoal(goalpos);
  } else if(isDefined(behaviortreeentity.enemy)) {
    behaviortreeentity.has_exit_point = undefined;

    if(isDefined(behaviortreeentity.is_rat_test) && behaviortreeentity.is_rat_test) {
      aiprofile_endentry();
      return;
    }

      if(isDefined(level.enemy_location_override_func)) {
        goalpos = [
          [level.enemy_location_override_func]
        ](behaviortreeentity, behaviortreeentity.enemy);

        if(isDefined(goalpos)) {
          behaviortreeentity setgoal(goalpos);
        } else {
          behaviortreeentity zombieupdategoalcode();
        }
      }
    else if(isDefined(behaviortreeentity.enemy.last_valid_position)) {
      behaviortreeentity zombieupdategoalcode();
    }
  }

  aiprofile_endentry();
}

zombieupdategoal() {
  aiprofile_beginentry("zombieUpdateGoal");
  shouldrepath = 0;
  zigzag_activation_distance = level.zigzag_activation_distance;

  if(isDefined(self.zigzag_activation_distance)) {
    zigzag_activation_distance = self.zigzag_activation_distance;
  }

  if(!shouldrepath && isDefined(self.favoriteenemy)) {
    pathgoalpos = self.pathgoalpos;

    if(!isDefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
      shouldrepath = 1;
    } else if(distancesquared(self.origin, self.favoriteenemy.origin) <= zigzag_activation_distance * zigzag_activation_distance) {
      shouldrepath = 1;
    } else if(isDefined(pathgoalpos)) {
      distancetogoalsqr = distancesquared(self.origin, pathgoalpos);
      shouldrepath = distancetogoalsqr < 72 * 72;
    }
  }

  if(isDefined(level.validate_on_navmesh) && level.validate_on_navmesh) {
    if(!ispointonnavmesh(self.origin, self)) {
      shouldrepath = 0;
    }
  }

  if(isDefined(self.keep_moving) && self.keep_moving) {
    if(gettime() > self.keep_moving_time) {
      self.keep_moving = 0;
    }
  }

  if(self function_dd070839()) {
    shouldrepath = 0;
  }

  if(isactor(self) && self asmistransitionrunning() || self asmistransdecrunning()) {
    shouldrepath = 0;
  }

  if(shouldrepath) {
    if(isplayer(self.favoriteenemy)) {
      goalent = zm_ai_utility::function_a2e8fd7b(self, self.favoriteenemy);

      if(isDefined(goalent.last_valid_position)) {
        goalpos = getclosestpointonnavmesh(goalent.last_valid_position, 64, self getpathfindingradius());

        if(!isDefined(goalpos)) {
          goalpos = goalent.origin;
        }
      } else {
        goalpos = goalent.origin;
      }
    } else {
      goalpos = getclosestpointonnavmesh(self.favoriteenemy.origin, 64, self getpathfindingradius());

      if(!isDefined(goalpos) && self.favoriteenemy function_dd070839() && isDefined(self.favoriteenemy.traversestartnode)) {
        goalpos = self.favoriteenemy.traversestartnode.origin;
      }

      if(!isDefined(goalpos)) {
        goalpos = self.origin;
      }
    }

    self setgoal(goalpos);
    should_zigzag = 1;

    if(isDefined(level.should_zigzag)) {
      should_zigzag = self[[level.should_zigzag]]();
    } else if(isDefined(self.should_zigzag)) {
      should_zigzag = self.should_zigzag;
    }

    if(isDefined(self.var_592a8227)) {
      should_zigzag = should_zigzag && self.var_592a8227;
    }

    var_eb1c6f1c = 0;

    if(isDefined(level.do_randomized_zigzag_path) && level.do_randomized_zigzag_path && should_zigzag) {
      if(distancesquared(self.origin, goalpos) > zigzag_activation_distance * zigzag_activation_distance) {
        self.keep_moving = 1;
        self.keep_moving_time = gettime() + 700;
        path = undefined;

        if(isDefined(self.var_ceed8829) && self.var_ceed8829) {
          pathdata = generatenavmeshpath(self.origin, goalpos, self);

          if(isDefined(pathdata) && pathdata.status === "succeeded" && isDefined(pathdata.pathpoints)) {
            path = pathdata.pathpoints;
          }
        } else {
          path = self calcapproximatepathtoposition(goalpos, 0);
        }

        if(isDefined(path)) {

          if(getdvarint(#"ai_debugzigzag", 0)) {
            for(index = 1; index < path.size; index++) {
              recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x38>", self);
              record3dtext(abs(path[index - 1][2] - path[index][2]), path[index - 1], (1, 0, 0));
            }
          }

            deviationdistance = randomintrange(level.zigzag_distance_min, level.zigzag_distance_max);

          if(isDefined(self.zigzag_distance_min) && isDefined(self.zigzag_distance_max)) {
            deviationdistance = randomintrange(self.zigzag_distance_min, self.zigzag_distance_max);
          }

          segmentlength = 0;

          for(index = 1; index < path.size; index++) {
            if(isDefined(level.var_562c8f67) && abs(path[index - 1][2] - path[index][2]) > level.var_562c8f67) {
              break;
            }

            currentseglength = distance(path[index - 1], path[index]);
            var_570a7c72 = segmentlength + currentseglength > deviationdistance;

            if(index == path.size - 1 && !var_570a7c72) {
              deviationdistance = segmentlength + currentseglength - 1;
              var_eb1c6f1c = 1;
            }

            if(var_570a7c72 || var_eb1c6f1c) {
              remaininglength = deviationdistance - segmentlength;
              seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;

    
              recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x38>", self);
    

                innerzigzagradius = level.inner_zigzag_radius;

              if(var_eb1c6f1c) {
                innerzigzagradius = 0;
              } else if(isDefined(self.inner_zigzag_radius)) {
                innerzigzagradius = self.inner_zigzag_radius;
              }

              outerzigzagradius = level.outer_zigzag_radius;

              if(var_eb1c6f1c) {
                outerzigzagradius = 48;
              } else if(isDefined(self.outer_zigzag_radius)) {
                outerzigzagradius = self.outer_zigzag_radius;
              }

              queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, self, 16);
              positionquery_filter_inclaimedlocation(queryresult, self);

              if(queryresult.data.size > 0) {
                a_data = array::randomize(queryresult.data);

                for(i = 0; i < a_data.size; i++) {
                  point = a_data[i];
                  n_z_diff = seedposition[2] - point.origin[2];

                  if(abs(n_z_diff) < 32) {
                    self setgoal(point.origin);
                    break;
                  }
                }
              }

              break;
            }

            segmentlength += currentseglength;
          }
        }
      }
    }

    self.nextgoalupdate = gettime() + randomintrange(500, 1000);
  }

  aiprofile_endentry();
}

zombieupdategoalcode() {
  aiprofile_beginentry("zombieUpdateGoalCode");
  shouldrepath = 0;

  if(!shouldrepath && isDefined(self.enemy)) {
    if(!isDefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
      shouldrepath = 1;
    } else if(distancesquared(self.origin, self.enemy.origin) <= 200 * 200) {
      shouldrepath = 1;
    } else if(isDefined(self.pathgoalpos)) {
      distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
      shouldrepath = distancetogoalsqr < 72 * 72;
    }
  }

  if(isDefined(self.keep_moving) && self.keep_moving) {
    if(gettime() > self.keep_moving_time) {
      self.keep_moving = 0;
    }
  }

  if(shouldrepath) {
    goalpos = self.enemy.origin;

    if(isDefined(self.enemy.last_valid_position)) {
      var_2a741504 = getclosestpointonnavmesh(self.enemy.last_valid_position, 64, 16);

      if(isDefined(var_2a741504)) {
        goalpos = var_2a741504;
      }
    }

    if(isDefined(level.do_randomized_zigzag_path) && level.do_randomized_zigzag_path) {
      if(distancesquared(self.origin, goalpos) > 240 * 240) {
        self.keep_moving = 1;
        self.keep_moving_time = gettime() + 250;
        path = self calcapproximatepathtoposition(goalpos, 0);

        if(getdvarint(#"ai_debugzigzag", 0)) {
          for(index = 1; index < path.size; index++) {
            recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x38>", self);
          }
        }

          deviationdistance = randomintrange(240, 480);
        segmentlength = 0;

        for(index = 1; index < path.size; index++) {
          currentseglength = distance(path[index - 1], path[index]);

          if(segmentlength + currentseglength > deviationdistance) {
            remaininglength = deviationdistance - segmentlength;
            seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;

  
            recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x38>", self);
  

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

zombieenteredplayable(behaviortreeentity) {
  if(!isDefined(level.playable_areas)) {
    level.playable_areas = getEntArray("player_volume", "script_noteworthy");
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

      return true;
    }
  }

  if(zm_utility::function_c85ebbbc()) {
    foreach(area in level.playable_areas) {
      if(behaviortreeentity istouching(area)) {
        if(isDefined(behaviortreeentity.var_ee833cd6)) {
          behaviortreeentity[[behaviortreeentity.var_ee833cd6]]();
        } else {
          behaviortreeentity zm_spawner::zombie_complete_emerging_into_playable_area();
        }

        return true;
      }
    }
  }

  return false;
}

shouldmovecondition(behaviortreeentity) {
  if(behaviortreeentity haspath()) {
    return true;
  }

  if(isDefined(behaviortreeentity.keep_moving) && behaviortreeentity.keep_moving) {
    return true;
  }

  return false;
}

zombieshouldmoveawaycondition(behaviortreeentity) {
  return level.wait_and_revive;
}

waskilledbyteslacondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.tesla_death) && behaviortreeentity.tesla_death) {
    return true;
  }

  return false;
}

disablepowerups(behaviortreeentity) {
  behaviortreeentity.no_powerups = 1;
}

enablepowerups(behaviortreeentity) {
  behaviortreeentity.no_powerups = 0;
}

zombiemoveaway(behaviortreeentity, asmstatename) {
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

zombieisbeinggrappled(behaviortreeentity) {
  if(isDefined(behaviortreeentity.grapple_is_fatal) && behaviortreeentity.grapple_is_fatal) {
    return true;
  }

  return false;
}

zombieshouldknockdown(behaviortreeentity) {
  if(isDefined(behaviortreeentity.knockdown) && behaviortreeentity.knockdown) {
    return true;
  }

  return false;
}

zombieispushed(behaviortreeentity) {
  if(isDefined(behaviortreeentity.pushed) && behaviortreeentity.pushed) {
    return true;
  }

  return false;
}

zombiegrappleactionstart(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_grapple_direction", self.grapple_direction);
}

zombieknockdownactionstart(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_knockdown_direction", behaviortreeentity.knockdown_direction);
  behaviortreeentity setblackboardattribute("_knockdown_type", behaviortreeentity.knockdown_type);
  behaviortreeentity setblackboardattribute("_getup_direction", behaviortreeentity.getup_direction);
  behaviortreeentity collidewithactors(0);
  behaviortreeentity.blockingpain = 1;
}

private function_c8939973(behaviortreeentity) {
  if(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
    behaviortreeentity.knockdown = 0;
    behaviortreeentity collidewithactors(1);
  }
}

private zombiegetupactionterminate(behaviortreeentity) {
  behaviortreeentity.knockdown = 0;
  behaviortreeentity collidewithactors(1);
}

private zombiepushedactionstart(behaviortreeentity) {
  behaviortreeentity collidewithactors(0);
  behaviortreeentity setblackboardattribute("_push_direction", behaviortreeentity.push_direction);
}

private zombiepushedactionterminate(behaviortreeentity) {
  behaviortreeentity collidewithactors(1);
  behaviortreeentity.pushed = 0;
}

zombieshouldstun(behaviortreeentity) {
  if(behaviortreeentity ai::is_stunned() && !(isDefined(behaviortreeentity.tesla_death) && behaviortreeentity.tesla_death)) {
    return true;
  }

  return false;
}

zombiestunstart(behaviortreeentity) {
  behaviortreeentity pathmode("dont move", 1);
  callback::callback(#"hash_1eda827ff5e6895b");
}

function_c377438f(behaviortreeentity) {
  behaviortreeentity pathmode("move allowed");
  callback::callback(#"hash_210adcf09e99fba1");
}

zombiestunactionstart(behaviortreeentity, asmstatename) {
  zombiestunstart(behaviortreeentity);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function_4e52c07(behaviortreeentity, asmstatename) {
  if(behaviortreeentity ai::is_stunned()) {
    return 5;
  }

  return 4;
}

zombiestunactionend(behaviortreeentity, asmstatename) {
  function_c377438f(behaviortreeentity);
  return 4;
}

zombietraverseaction(behaviortreeentity, asmstatename) {
  aiutility::traverseactionstart(behaviortreeentity, asmstatename);
  behaviortreeentity.old_powerups = behaviortreeentity.no_powerups;
  disablepowerups(behaviortreeentity);
  behaviortreeentity.var_9ed3cc11 = behaviortreeentity function_e827fc0e();
  behaviortreeentity pushplayer(1);
  behaviortreeentity callback::callback(#"hash_1518febf00439d5");
  return 5;
}

zombietraverseactionterminate(behaviortreeentity, asmstatename) {
  aiutility::wpn_debug_bot_joinleave(behaviortreeentity, asmstatename);

  if(behaviortreeentity asmgetstatus() == "asm_status_complete") {
    behaviortreeentity.no_powerups = behaviortreeentity.old_powerups;

    if(!(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs)) {
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

zombiegottoentrancecondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.got_to_entrance) && behaviortreeentity.got_to_entrance) {
    return true;
  }

  return false;
}

zombiegottoattackspotcondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.at_entrance_tear_spot) && behaviortreeentity.at_entrance_tear_spot) {
    return true;
  }

  return false;
}

zombiehasattackspotalreadycondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.attacking_spot_index) && behaviortreeentity.attacking_spot_index >= 0) {
    return true;
  }

  return false;
}

zombieshouldtearcondition(behaviortreeentity) {
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

zombieshouldattackthroughboardscondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
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
    setdvar(#"zombie_reachin_freq", 50);
  }

  freq = getdvarint(#"zombie_reachin_freq", 0);
  players = getplayers();
  attack = 0;
  behaviortreeentity.player_targets = [];

  for(i = 0; i < players.size; i++) {
    if(isalive(players[i]) && !isDefined(players[i].revivetrigger) && distance2d(behaviortreeentity.origin, players[i].origin) <= 109.8 && !(isDefined(players[i].ignoreme) && players[i].ignoreme)) {
      behaviortreeentity.player_targets[behaviortreeentity.player_targets.size] = players[i];
      attack = 1;
    }
  }

  if(!attack || freq < randomint(100)) {
    return false;
  }

  return true;
}

zombieshouldtauntcondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
    return false;
  }

  if(!isDefined(behaviortreeentity.first_node.zbarrier)) {
    return false;
  }

  if(!behaviortreeentity.first_node.zbarrier zbarriersupportszombietaunts()) {
    return false;
  }

  if(getdvarstring(#"zombie_taunt_freq") == "") {
    setdvar(#"zombie_taunt_freq", 5);
  }

  freq = getdvarint(#"zombie_taunt_freq", 0);

  if(freq >= randomint(100)) {
    return true;
  }

  return false;
}

zombieshouldenterplayablecondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.first_node) && isDefined(behaviortreeentity.first_node.barrier_chunks)) {
    if(zm_utility::all_chunks_destroyed(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks)) {
      if((!isDefined(behaviortreeentity.attacking_spot) || isDefined(behaviortreeentity.at_entrance_tear_spot) && behaviortreeentity.at_entrance_tear_spot) && !(isDefined(behaviortreeentity.completed_emerging_into_playable_area) && behaviortreeentity.completed_emerging_into_playable_area)) {
        return true;
      }
    }
  }

  return false;
}

ischunkvalidcondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.chunk)) {
    return true;
  }

  return false;
}

inplayablearea(behaviortreeentity) {
  if(isDefined(behaviortreeentity.completed_emerging_into_playable_area) && behaviortreeentity.completed_emerging_into_playable_area) {
    return true;
  }

  return false;
}

shouldskipteardown(behaviortreeentity) {
  if(behaviortreeentity zm_spawner::should_skip_teardown(behaviortreeentity.find_flesh_struct_string)) {
    return true;
  }

  return false;
}

zombieisthinkdone(behaviortreeentity) {

  if(isDefined(behaviortreeentity.is_rat_test) && behaviortreeentity.is_rat_test) {
    return false;
  }

    if(isDefined(behaviortreeentity.zombie_think_done) && behaviortreeentity.zombie_think_done) {
      return true;
    }

  return false;
}

zombieisatgoal(behaviortreeentity) {
  goalinfo = behaviortreeentity function_4794d6a3();
  isatscriptgoal = isDefined(goalinfo.var_9e404264) && goalinfo.var_9e404264;

  if(isDefined(level.var_21326085) && level.var_21326085) {
    if(!isatscriptgoal && isDefined(goalinfo.overridegoalpos)) {
      if(abs(goalinfo.overridegoalpos[2] - behaviortreeentity.origin[2]) < 12) {
        dist = distance2dsquared(goalinfo.overridegoalpos, behaviortreeentity.origin);

        if(dist < 144) {
          return 1;
        }
      }
    }
  }

  return isatscriptgoal;
}

zombieisatentrance(behaviortreeentity) {
  goalinfo = behaviortreeentity function_4794d6a3();
  isatscriptgoal = isDefined(goalinfo.var_9e404264) && goalinfo.var_9e404264;
  isatentrance = isDefined(behaviortreeentity.first_node) && isatscriptgoal;
  return isatentrance;
}

getchunkservice(behaviortreeentity) {
  behaviortreeentity.chunk = zm_utility::get_closest_non_destroyed_chunk(behaviortreeentity.origin, behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks);

  if(isDefined(behaviortreeentity.chunk)) {
    behaviortreeentity.first_node.zbarrier setzbarrierpiecestate(behaviortreeentity.chunk, "targetted_by_zombie");
    behaviortreeentity.first_node thread zm_spawner::check_zbarrier_piece_for_zombie_death(behaviortreeentity.chunk, behaviortreeentity.first_node.zbarrier, behaviortreeentity);
  }
}

updatechunkservice(behaviortreeentity) {
  while(0 < behaviortreeentity.first_node.zbarrier.chunk_health[behaviortreeentity.chunk]) {
    behaviortreeentity.first_node.zbarrier.chunk_health[behaviortreeentity.chunk]--;
  }

  behaviortreeentity.lastchunk_destroy_time = gettime();
}

updateattackspotservice(behaviortreeentity) {
  if(isDefined(behaviortreeentity.marked_for_death) && behaviortreeentity.marked_for_death || behaviortreeentity.health < 0) {
    return false;
  }

  if(!isDefined(behaviortreeentity.attacking_spot)) {
    if(!behaviortreeentity zm_spawner::get_attack_spot(behaviortreeentity.first_node)) {
      return false;
    }
  }

  if(isDefined(behaviortreeentity.attacking_spot)) {
    behaviortreeentity.goalradius = 12;
    behaviortreeentity function_a57c34b7(behaviortreeentity.attacking_spot);

    if(zombieisatgoal(behaviortreeentity)) {
      behaviortreeentity.at_entrance_tear_spot = 1;
    }

    return true;
  }

  return false;
}

findnodesservice(behaviortreeentity) {
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
    assert(isDefined(node), "<dev string:x45>" + behaviortreeentity.find_flesh_struct_string + "<dev string:x7a>");
    behaviortreeentity.first_node = node;
    goal_pos = getclosestpointonnavmesh(node.origin, 128, self getpathfindingradius());
    behaviortreeentity function_a57c34b7(goal_pos);

    if(zombieisatentrance(behaviortreeentity)) {
      behaviortreeentity.got_to_entrance = 1;
    }

    return 1;
  }
}

zombieattackableobjectservice(behaviortreeentity) {
  if(!behaviortreeentity ai::has_behavior_attribute("use_attackable") || !behaviortreeentity ai::get_behavior_attribute("use_attackable")) {
    behaviortreeentity.attackable = undefined;
    return 0;
  }

  if(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
    behaviortreeentity.attackable = undefined;
    return 0;
  }

  if(isDefined(behaviortreeentity.aat_turned) && behaviortreeentity.aat_turned) {
    behaviortreeentity.attackable = undefined;
    return 0;
  }

  if(!isDefined(behaviortreeentity.attackable)) {
    behaviortreeentity.attackable = zm_attackables::get_attackable();
    return;
  }

  if(!(isDefined(behaviortreeentity.attackable.is_active) && behaviortreeentity.attackable.is_active)) {
    behaviortreeentity.attackable = undefined;
  }
}

zombiemovetoentranceaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.got_to_entrance = 0;
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

zombiemovetoentranceactionterminate(behaviortreeentity, asmstatename) {
  if(zombieisatentrance(behaviortreeentity)) {
    behaviortreeentity.got_to_entrance = 1;
  }

  return 4;
}

zombiemovetoattackspotaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.at_entrance_tear_spot = 0;
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

zombiemovetoattackspotactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity.at_entrance_tear_spot = 1;
  return 4;
}

zombieholdboardaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 1;
  behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
  behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
  boardactionast = behaviortreeentity astsearch(asmstatename);
  boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

zombieholdboardactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 0;
  return 4;
}

zombiegrabboardaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 1;
  behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
  behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
  boardactionast = behaviortreeentity astsearch(asmstatename);
  boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

zombiegrabboardactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 0;
  return 4;
}

zombiepullboardaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 1;
  behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
  behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
  boardactionast = behaviortreeentity astsearch(asmstatename);
  boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

zombiepullboardactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 0;
  self.lastchunk_destroy_time = gettime();
  return 4;
}

zombieattackthroughboardsaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 1;
  behaviortreeentity.boardattack = 1;
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

zombieattackthroughboardsactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 0;
  behaviortreeentity.boardattack = 0;
  return 4;
}

zombietauntaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 1;
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

zombietauntactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 0;
  return 4;
}

zombiemantleaction(behaviortreeentity, asmstatename) {
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

zombiemantleactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity.clamptonavmesh = 1;
  behaviortreeentity.isinmantleaction = undefined;

  if(isDefined(behaviortreeentity.var_9ed3cc11)) {
    behaviortreeentity pushplayer(behaviortreeentity.var_9ed3cc11);
    behaviortreeentity.var_9ed3cc11 = undefined;
  }

  behaviortreeentity zm_behavior_utility::enteredplayablearea();
  return 4;
}

boardtearmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(entity.barrier_align)) {
    origin = getstartorigin(entity.barrier_align.origin, entity.barrier_align.angles, mocompanim);
    angles = getstartangles(entity.barrier_align.origin, entity.barrier_align.angles, mocompanim);
  } else {
    origin = getstartorigin(entity.first_node.zbarrier.origin, entity.first_node.zbarrier.angles, mocompanim);
    angles = getstartangles(entity.first_node.zbarrier.origin, entity.first_node.zbarrier.angles, mocompanim);
  }

  entity forceteleport(origin, angles, 1);
  entity.pushable = 0;
  entity.blockingpain = 1;
  entity animmode("noclip", 1);
  entity orientmode("face angle", angles[1]);
}

boardtearmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity animmode("noclip", 0);
  entity.pushable = 0;
  entity.blockingpain = 1;
}

barricadeentermocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(entity.barrier_align)) {
    origin = getstartorigin(entity.barrier_align.origin, entity.barrier_align.angles, mocompanim);
    angles = getstartangles(entity.barrier_align.origin, entity.barrier_align.angles, mocompanim);
  } else {
    zbarrier_origin = isDefined(entity.first_node.zbarrier) ? entity.first_node.zbarrier.origin : entity.first_node.zbarrier_origin;
    var_f4b27846 = isDefined(entity.first_node.zbarrier) ? entity.first_node.zbarrier.angles : entity.first_node.var_f4b27846;
    origin = getstartorigin(zbarrier_origin, var_f4b27846, mocompanim);
    angles = getstartangles(zbarrier_origin, var_f4b27846, mocompanim);
  }

  if(isDefined(entity.mocomp_barricade_offset)) {
    origin += anglesToForward(angles) * entity.mocomp_barricade_offset;
  }

  entity forceteleport(origin, angles, 1);
  entity animmode("noclip", 0);
  entity orientmode("face angle", angles[1]);
  entity.pushable = 0;
  entity.blockingpain = 1;
  entity pathmode("dont move");
  entity.usegoalanimweight = 1;
}

barricadeentermocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity animmode("noclip", 0);
  entity.pushable = 0;
}

barricadeentermocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.pushable = 1;
  entity.blockingpain = 0;
  entity pathmode("move allowed");
  entity.usegoalanimweight = 0;
  entity animmode("normal", 0);
  entity orientmode("face motion");
}

barricadeentermocompnozstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(entity.barrier_align)) {
    origin = getstartorigin(entity.barrier_align.origin, entity.barrier_align.angles, mocompanim);
    angles = getstartangles(entity.barrier_align.origin, entity.barrier_align.angles, mocompanim);
  } else {
    zbarrier_origin = isDefined(entity.first_node.zbarrier) ? entity.first_node.zbarrier.origin : entity.first_node.zbarrier_origin;
    var_f4b27846 = isDefined(entity.first_node.zbarrier) ? entity.first_node.zbarrier.angles : entity.first_node.var_f4b27846;
    origin = getstartorigin(zbarrier_origin, var_f4b27846, mocompanim);
    angles = getstartangles(zbarrier_origin, var_f4b27846, mocompanim);
  }

  if(isDefined(entity.mocomp_barricade_offset)) {
    origin += anglesToForward(angles) * entity.mocomp_barricade_offset;
  }

  entity forceteleport(origin, angles, 1);
  entity animmode("noclip", 0);
  entity orientmode("face angle", angles[1]);
  entity.pushable = 0;
  entity.blockingpain = 1;
  entity pathmode("dont move");
  entity.usegoalanimweight = 1;
}

barricadeentermocompnozupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity animmode("noclip", 0);
  entity.pushable = 0;
}

barricadeentermocompnozterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.pushable = 1;
  entity.blockingpain = 0;
  entity pathmode("move allowed");
  entity.usegoalanimweight = 0;
  entity animmode("normal", 0);
  entity orientmode("face motion");
}

notetrackboardtear(animationentity) {
  if(isDefined(animationentity.chunk)) {
    animationentity.first_node.zbarrier setzbarrierpiecestate(animationentity.chunk, "opening");
    level notify(#"zombie_board_tear", {
      #ai_zombie: animationentity, 
      #s_board: animationentity.first_node
    });
  }
}

notetrackboardmelee(animationentity) {
  assert(animationentity.meleeweapon != level.weaponnone, "<dev string:x8c>");

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

function_b37b8c0d(entity) {
  if(isDefined(entity.first_node)) {
    zm_blockers::open_zbarrier(entity.first_node, 1);
  }
}

findzombieenemy() {
  if(isDefined(self.var_8b59c468)) {
    self[[self.var_8b59c468]]();
    return;
  }

  zombies = getaispeciesarray(level.zombie_team, "all");
  zombie_enemy = undefined;
  closest_dist = undefined;

  foreach(zombie in zombies) {
    if(isalive(zombie) && isDefined(zombie.completed_emerging_into_playable_area) && zombie.completed_emerging_into_playable_area && !zm_utility::is_magic_bullet_shield_enabled(zombie) && isDefined(zombie.canbetargetedbyturnedzombies) && zombie.canbetargetedbyturnedzombies) {
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

zombieblackholebombpullstart(entity, asmstatename) {
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

zombieupdateblackholebombpullstate(entity) {
  dist_to_bomb = distancesquared(entity.origin, entity.damageorigin);

  if(dist_to_bomb < 16384) {
    entity._black_hole_bomb_collapse_death = 1;
    return;
  }

  if(dist_to_bomb < 1048576) {
    return;
  }

  if(dist_to_bomb > 4227136) {}
}

zombieblackholebombpullupdate(entity, asmstatename) {
  if(!isDefined(entity.interdimensional_gun_kill)) {
    return 4;
  }

  zombieupdateblackholebombpullstate(entity);

  if(isDefined(entity._black_hole_bomb_collapse_death) && entity._black_hole_bomb_collapse_death) {
    entity.skipautoragdoll = 1;
    entity dodamage(entity.health + 666, entity.origin + (0, 0, 50), entity.interdimensional_gun_attacker, undefined, undefined, "MOD_CRUSH");
    return 4;
  }

  if(isDefined(entity.damageorigin)) {
    entity.v_zombie_custom_goal_pos = entity.damageorigin;
  }

  if(!(isDefined(entity.missinglegs) && entity.missinglegs) && gettime() - entity.pulltime > 1000) {
    distsq = distance2dsquared(entity.origin, entity.pullorigin);

    if(distsq < 144) {
      entity setavoidancemask("avoid all");
      entity.cant_move = 1;

      if(isDefined(entity.cant_move_cb)) {
        entity thread[[entity.cant_move_cb]]();
      }
    } else {
      entity setavoidancemask("avoid none");
      entity.cant_move = 0;
    }

    entity.pulltime = gettime();
    entity.pullorigin = entity.origin;
  }

  return 5;
}

zombieblackholebombpullend(entity, asmstatename) {
  entity.v_zombie_custom_goal_pos = undefined;
  entity.n_zombie_custom_goal_radius = undefined;
  entity.pulltime = undefined;
  entity.pullorigin = undefined;
  return 4;
}

zombiekilledwhilegettingpulled(entity) {
  if(!(isDefined(self.missinglegs) && self.missinglegs) && isDefined(entity.interdimensional_gun_kill) && entity.interdimensional_gun_kill && !(isDefined(entity._black_hole_bomb_collapse_death) && entity._black_hole_bomb_collapse_death)) {
    return true;
  }

  return false;
}

zombiekilledbyblackholebombcondition(entity) {
  if(isDefined(entity._black_hole_bomb_collapse_death) && entity._black_hole_bomb_collapse_death) {
    return true;
  }

  return false;
}

function_38fec26f(entity) {
  if(isDefined(entity.freezegun_death) && entity.freezegun_death) {
    return true;
  }

  return false;
}

function_e4d7303f(entity) {
  return isDefined(entity.var_69a981e6) && entity.var_69a981e6;
}

function_17cd1b17(behaviortreeentity) {
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

zombiekilledbyblackholebombstart(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);

  if(isDefined(level.black_hole_bomb_death_start_func)) {
    entity thread[[level.black_hole_bomb_death_start_func]](entity.damageorigin, entity.interdimensional_gun_projectile);
  }

  return 5;
}

zombiekilledbyblackholebombend(entity, asmstatename) {
  if(isDefined(level._effect) && isDefined(level._effect[#"black_hole_bomb_zombie_gib"])) {
    fxorigin = entity gettagorigin("tag_origin");
    forward = anglesToForward(entity.angles);
    playFX(level._effect[#"black_hole_bomb_zombie_gib"], fxorigin, forward, (0, 0, 1));
  }

  entity hide();
  return 4;
}

zombiebhbburst(entity) {
  if(isDefined(level._effect) && isDefined(level._effect[#"black_hole_bomb_zombie_destroy"])) {
    fxorigin = entity gettagorigin("tag_origin");
    playFX(level._effect[#"black_hole_bomb_zombie_destroy"], fxorigin);
  }

  if(isDefined(entity.interdimensional_gun_projectile)) {
    entity.interdimensional_gun_projectile notify(#"black_hole_bomb_kill");
  }
}

function_b654f4f5(entity) {
  if(isDefined(level.var_58e6238)) {
    entity[[level.var_58e6238]]();
  }

  return 5;
}

function_36b3cb7d(entity) {
  if(isDefined(level.var_f975b6ae)) {
    entity[[level.var_f975b6ae]]();
  }
}

function_7994fd99(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isDefined(attacker) && isactor(attacker) && self.team == attacker.team) {
    return -1;
  }

  if(self.archetype == #"zombie") {
    self destructserverutils::handledamage(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
  }

  return -1;
}