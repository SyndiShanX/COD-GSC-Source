/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\proxywar\proxywar_courtyard.gsc
***************************************************/

proxywar_courtyard_precache() {}

proxywar_courtyard_flags() {
  scripts\engine\utility::flag_init("reached_courtyard_overlook");
  scripts\engine\utility::flag_init("at_courtyard_door");
  scripts\engine\utility::flag_init("reached_courtyard_breach");
  scripts\engine\utility::flag_init("started_courtyard_breach");
  scripts\engine\utility::flag_init("courtyard_breach_complete");
  scripts\engine\utility::flag_init("reached_courtyard_start");
  scripts\engine\utility::flag_init("reached_courtyard_mid_1");
  scripts\engine\utility::flag_init("reached_courtyard_mid_2");
  scripts\engine\utility::flag_init("reached_courtyard_mid_3");
  scripts\engine\utility::flag_init("reached_courtyard_mid_4");
  scripts\engine\utility::flag_init("reached_courtyard_end");
  scripts\engine\utility::flag_init("reached_warehouse_approach");
}

proxywar_courtyard_hints() {
  scripts\engine\sp\utility::add_hint_string("tut_swap_weapon_hint", &"PROXYWAR/TUT_SWAP_WEAPON", ::check_swap_weapon);
}

check_swap_weapon() {
  return level.player_swapped_weapon;
}

proxywar_courtyard_spawn_func() {
  scripts\engine\sp\utility::array_spawn_function_targetname("courtyard_defend_group", ::courtyard_defender_spawnfunc);
}

courtyard_retreat_start() {
  scripts\sp\maps\proxywar\proxywar_util.gsc::spawn_ally_teams(0);
  scripts\engine\sp\utility::set_start_location("start_courtyard_retreat", scripts\engine\utility::array_combine([level.player], level.alpha_and_bravo_team));
  scripts\sp\maps\proxywar\proxywar_util.gsc::enable_allies_firing();

  foreach(var_1 in level.alpha_and_bravo_team)
  var_1.disableplayeradsloscheck = 0;
}

courtyard_retreat_main() {
  level scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::transient_load_array, ["pw_warehouse_interior_tr"]);
  scripts\engine\sp\utility::autosave_by_name("courtyard_retreat");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_reach_warehouse", "targetname").origin);
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_upper_move_courtyard_1");
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_lower_move_courtyard_1");
  level thread upper_team_move_courtyard();
  level thread lower_team_move_courtyard();
  scripts\engine\utility::flag_wait_any("at_courtyard_door", "reached_courtyard_overlook");
  level.courtyarddefendgroup = scripts\engine\sp\utility::array_spawn_targetname("courtyard_defend_group", 1);

  foreach(var_1 in level.courtyarddefendgroup) {
    var_1 scripts\engine\sp\utility::set_baseaccuracy(0.1);
    var_1.health = var_1.health * 2;
    var_1.ignoreme = 1;
    var_1.ignoreall = 1;
  }

  scripts\engine\utility::flag_wait_any("reached_courtyard_start", "reached_courtyard_overlook");

  if(scripts\engine\utility::flag("reached_courtyard_overlook")) {
    var_3 = gettime();

    while(!scripts\engine\utility::time_has_passed(var_3, 2.0) && !level.player isfiring())
      waitframe();

    foreach(var_1 in level.courtyarddefendgroup) {
      var_1.ignoreme = 0;
      var_1.ignoreall = 0;
    }

    var_3 = gettime();
    var_6 = 0;
    var_7 = scripts\engine\utility::array_combine([level.player], level.courtyarddefendgroup);

    while(!scripts\engine\utility::time_has_passed(var_3, 1.0) && !var_6 && !level.player isfiring()) {
      foreach(var_9 in level.courtyarddefendgroup) {
        if(scripts\sp\maps\proxywar\proxywar_util.gsc::within_player_fov(var_9 getEye()) && scripts\engine\trace::ray_trace_passed(level.player getEye(), var_9 getEye(), var_7, scripts\engine\trace::create_world_contents())) {
          var_6 = 1;
          break;
        }
      }

      waitframe();
    }
  } else {
    scripts\engine\utility::flag_wait("started_courtyard_breach");

    foreach(var_1 in level.courtyarddefendgroup) {
      var_1.ignoreme = 0;
      var_1.ignoreall = 0;
    }

    wait 3.0;
  }

  thread scripts\sp\maps\proxywar\proxywar_vo.gsc::mus_courtyard_endmusic();
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_cr_enemies_fall_back();
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_cr_kill_retreating();
  level.courtyarddefendgroup = scripts\engine\utility::array_removedead_or_dying(level.courtyarddefendgroup);
  var_13 = getEnt("courtyard_fallback", "targetname");

  foreach(var_1 in level.courtyarddefendgroup) {
    var_1 setgoalvolumeauto(var_13);
    var_1 thread courytard_retreat_enemy_kill_at_fallback(var_13);

    if(!isDefined(var_1.script_noteworthy)) {
      var_1.maxfaceenemydist = 0;
      var_1.ignoreall = 1;
      continue;
    }

    var_1.maxfaceenemydist = 300;
  }

  level.courtyarddefendgroup = scripts\engine\utility::array_removedead_or_dying(level.courtyarddefendgroup);

  if(level.courtyarddefendgroup.size > 0)
    scripts\engine\sp\utility::waittill_dead(level.courtyarddefendgroup);

  level.courtyarddefendgroup = scripts\engine\utility::array_removedead_or_dying(level.courtyarddefendgroup);

  foreach(var_17 in level.alpha_and_bravo_team) {
    var_17 scripts\sp\maps\proxywar\proxywar_util.gsc::set_ally_movement_courtyard();
    var_17 scripts\common\ai::set_gunpose("disable", 1);
    var_17 scripts\asm\shared\utility::toggle_poiauto(1);
    var_17.disableplayeradsloscheck = 1;
  }

  level thread scripts\sp\player::player_movement_state("cqb");
  thread scripts\sp\maps\proxywar\proxywar_util.gsc::hint_weapon_swap();
  scripts\engine\utility::flag_wait("reached_warehouse_approach");
  level thread scripts\engine\sp\utility::autosave_by_name("warehouse_enter");
}

courytard_retreat_enemy_kill_at_fallback(var_0) {
  self endon("death");

  while(!self istouching(var_0))
    waitframe();

  var_1 = undefined;

  while(!isDefined(var_1)) {
    var_2 = sortbydistance(level.alpha_and_bravo_team, self.origin);

    foreach(var_4 in var_2) {
      if(!var_4 scripts\sp\maps\proxywar\proxywar_util.gsc::ally_tracking_enemy()) {
        var_4 thread scripts\sp\maps\proxywar\proxywar_util.gsc::ally_track_and_kill(self, "kill_now_" + var_4.script_noteworthy);
        var_1 = var_4;
        break;
      }
    }

    waitframe();
  }

  wait(randomfloatrange(0.0, 3.0));
  level notify("kill_now_" + var_1.script_noteworthy);
}

courtyard_defender_spawnfunc() {
  scripts\engine\sp\utility::set_grenadeammo(0);
}

upper_team_move_courtyard() {
  scripts\engine\utility::flag_wait("reached_courtyard_start");
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_upper_move_courtyard_2");

  foreach(var_1 in level.alpha_and_bravo_team)
  var_1 scripts\sp\maps\proxywar\proxywar_util.gsc::set_ally_movement_courtyard();

  scripts\engine\utility::flag_wait("reached_courtyard_mid_1");
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_upper_move_courtyard_6");

  foreach(var_1 in level.alpha_and_bravo_team)
  var_1 scripts\sp\maps\proxywar\proxywar_util.gsc::set_ally_movement_courtyard();

  scripts\engine\utility::flag_wait("reached_courtyard_mid_4");
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_upper_move_courtyard_end");

  foreach(var_1 in level.alpha_and_bravo_team)
  var_1 scripts\sp\maps\proxywar\proxywar_util.gsc::set_ally_movement_courtyard();
}

lower_team_move_courtyard() {
  perform_courtyard_breach();
  scripts\engine\utility::flag_wait_or_timeout("reached_courtyard_mid_1", 6.0);
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_lower_move_courtyard_3");

  foreach(var_1 in level.alpha_and_bravo_team)
  var_1 scripts\sp\maps\proxywar\proxywar_util.gsc::set_ally_movement_courtyard();

  scripts\engine\utility::flag_wait("reached_courtyard_mid_1");
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_lower_move_courtyard_6");

  foreach(var_1 in level.alpha_and_bravo_team)
  var_1 scripts\sp\maps\proxywar\proxywar_util.gsc::set_ally_movement_courtyard();

  scripts\engine\utility::flag_wait("reached_courtyard_mid_4");
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_lower_move_courtyard_end");

  foreach(var_1 in level.alpha_and_bravo_team)
  var_1 scripts\sp\maps\proxywar\proxywar_util.gsc::set_ally_movement_courtyard();
}

perform_courtyard_breach() {
  level.courtyardbreachref = scripts\engine\utility::getStruct("courtyard_breach_ref", "targetname");
  level.courtyarddoorleft = scripts\sp\maps\proxywar\proxywar_util.gsc::setup_scripted_door("courtyard_door_left");
  level.courtyarddoorleft.animname = "courtyard_door_l";
  level.courtyarddoorleft scripts\common\anim::setanimtree();
  level.courtyarddoorright = scripts\sp\maps\proxywar\proxywar_util.gsc::setup_scripted_door("courtyard_door_right");
  level.courtyarddoorright.animname = "courtyard_door_r";
  level.courtyarddoorright scripts\common\anim::setanimtree();
  level thread move_to_breach();

  while(!scripts\engine\utility::flag("started_courtyard_breach")) {
    if(scripts\engine\utility::flag("reached_courtyard_breach") || scripts\engine\utility::flag("reached_courtyard_start")) {
      level notify("kill_breach_setup");
      level.courtyardbreachref notify("end_retreat_breach_idle");
      level.bravo3 notify("new_anim_reach");
      level thread breach_into_courtyard();
    }

    waitframe();
  }

  scripts\engine\utility::flag_wait("courtyard_breach_complete");
}

move_to_breach() {
  level endon("kill_breach_setup");
  level.bravo2 thread scripts\sp\maps\proxywar\proxywar_util.gsc::go_to_targetname("open_courtyard_door_left");
  level.bravo3.disableplayeradsloscheck = 1;
  level.courtyardbreachref scripts\sp\anim::anim_reach_solo(level.bravo3, "retreat_breach_setup");
  level.bombstrip = scripts\engine\sp\utility::spawn_anim_model("bomb_strip");
  level.clacker = scripts\engine\sp\utility::spawn_anim_model("clacker");
  level.courtyardbreachref scripts\common\anim::anim_single([level.clacker, level.bombstrip, level.bravo3], "retreat_breach_setup");

  if(!scripts\engine\utility::flag("at_courtyard_door") && !scripts\engine\utility::flag("reached_courtyard_overlook")) {
    level.courtyardbreachref thread scripts\common\anim::anim_loop([level.clacker, level.bravo3], "retreat_breach_idle", "end_retreat_breach_idle");
    scripts\engine\utility::flag_wait_any("at_courtyard_door", "reached_courtyard_overlook");
  }

  level notify("end_retreat_breach_idle");
  level thread breach_into_courtyard();
}

breach_into_courtyard() {
  scripts\engine\utility::flag_set("started_courtyard_breach");
  scripts\engine\utility::flag_set("reached_courtyard_start");

  if(!isDefined(level.clacker))
    level.clacker = scripts\engine\sp\utility::spawn_anim_model("clacker");

  level thread breach_doors();
  level.courtyardbreachref scripts\common\anim::anim_single([level.clacker, level.bravo3], "retreat_breach_detonate");
  level.bravo3 scripts\engine\sp\utility::enable_ai_color();
  level.bravo3.disableplayeradsloscheck = 0;
  scripts\engine\utility::flag_set("courtyard_breach_complete");
}

breach_doors() {
  level.courtyardbreachref thread scripts\common\anim::anim_single([level.courtyarddoorleft, level.courtyarddoorright], "retreat_breach_detonate");
  level.courtyarddoorleft.clip connectpaths();
  level.courtyarddoorright.clip connectpaths();
  thread sfx_courtyard_door_breach();
}

sfx_courtyard_door_breach() {
  wait 1.1;
  var_0 = spawn("script_origin", (202, 6, 316));
  var_0 playexplosionsound("scn_proxywar_breach_charge_expl", "exp");
  wait 5;
  var_0 delete();
}

courtyard_retreat_catchup() {
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_reach_warehouse", "targetname").origin);
}