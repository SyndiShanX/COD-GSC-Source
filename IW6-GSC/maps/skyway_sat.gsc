/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\skyway_sat.gsc
*****************************************************/

section_flag_inits() {
  common_scripts\utility::flag_init("flag_sat1_end");
  common_scripts\utility::flag_init("flag_sat2_end");
  common_scripts\utility::flag_init("flag_ally_at_sat1");
  common_scripts\utility::flag_init("flag_left_bridge_down");
}

section_precache() {
  maps\_utility::add_hint_string("hint_sat_bridge_1", &"SKYWAY_HINT_BRIDGE", ::hint_bridge_1);
  maps\_utility::add_hint_string("hint_sat_bridge_2", &"SKYWAY_HINT_BRIDGE", ::hint_bridge_2);
}

hint_bridge_1() {
  return !common_scripts\utility::flag("hint_sat_bridge_1") || !level._sat.bridges[0]._up;
}

hint_bridge_2() {
  return !common_scripts\utility::flag("hint_sat_bridge_2") || !level._sat.bridges[1]._up;
}

section_post_inits() {
  level._sat = spawnStruct();
  level._sat.ally_start_1 = getent("ally1_start_sat1", "targetname");
  level._sat.player_start_1 = getent("player_start_sat1", "targetname");
  level._sat.ally_start_2 = getent("ally1_start_sat2", "targetname");
  level._sat.player_start_2 = getent("player_start_sat2", "targetname");
  thread base_array_ambient_dogfight_1();
  thread base_array_ambient_dogfight_3();
  thread base_array_ambient_dogfight_1b();
  thread base_array_ambient_dogfight_2b();
  thread base_array_ambient_dogfight_3b();
  thread base_array_ambient_dogfight_4b();
  thread base_array_ambient_dogfight_5b();
  thread base_array_ambient_dogfight_6b();
  thread base_array_ambient_dogfight_6c();

  if(isDefined(level._sat.player_start_1)) {
    var_0 = ["model_sat1_crane", "model_sat2_crane", "model_sat_cargo_cage"];

    foreach(var_2 in var_0) {
      var_3 = getEntArray(var_2, "targetname");

      foreach(var_5 in var_3) {
        var_6 = [];

        if(issubstr(var_2, "crane")) {
          var_5.animname = "crane_" + var_5.script_noteworthy;

          if(issubstr(var_5.model, "crane_1"))
            common_scripts\utility::array_call(getEntArray(var_5.target, "targetname"), ::linkto, var_5, "j_spine4");
          else
            common_scripts\utility::array_call(getEntArray(var_5.target, "targetname"), ::linkto, var_5, "j_spine");

          var_6 = common_scripts\utility::array_add(var_6, var_5);
        } else if(issubstr(var_2, "cargo_cage")) {
          var_7 = strtok(var_5.target, "_");
          var_5.animname = "cage" + var_7[var_7.size - 1];
          var_8 = getEntArray(var_5.target, "targetname");
          var_6 = common_scripts\utility::array_add(var_6, var_5);

          foreach(var_10 in var_8) {
            if(issubstr(var_10.classname, "trigger")) {
              var_10 enablelinkto();
              var_10 setmovingplatformtrigger();
            }

            if(issubstr(var_10.classname, "script_origin") && !(isDefined(var_10.model) && issubstr(var_10.model, "weapon"))) {
              var_5.link_point = var_10;
              continue;
            }

            if(isDefined(var_10.script_parameters)) {
              if(issubstr(var_10.script_parameters, "upper")) {
                if(var_10.classname == "script_model") {
                  var_5._traverses["in"] = [];
                  var_5._traverses["out"] = [];

                  for(var_11 = 0; var_11 < 2; var_11++) {
                    var_5._traverses["in"] = common_scripts\utility::array_add(var_5._traverses["in"], getent(var_5.target + "_traverse_in_" + (var_11 + 1), "targetname"));
                    var_5._traverses["out"] = common_scripts\utility::array_add(var_5._traverses["out"], getent(var_5.target + "_traverse_out_" + (var_11 + 1), "targetname"));
                  }

                  foreach(var_13 in var_5._traverses) {
                    foreach(var_15 in var_13) {
                      if(isDefined(var_15.script_parameters) && var_15.script_parameters == "linkto_cargo")
                        var_15 linkto(var_10);
                    }
                  }

                  if(isDefined(var_10.target))
                    common_scripts\utility::array_call(getEntArray(var_10.target, "targetname"), ::linkto, var_10);

                  var_10 linkto(var_5, "tag_sat1", (0, 0, 0), (0, resolve_link_yaw(var_5, var_10), 0));
                } else
                  var_10 linkto(var_5, "j_spine4");
              } else if(issubstr(var_10.script_parameters, "lower")) {
                if(var_10.classname == "script_model")
                  var_10 linkto(var_5, "tag_sat2", (0, 0, 0), (0, resolve_link_yaw(var_5, var_10), 0));
                else
                  var_10 linkto(var_5, "j_elbow_le");
              } else if(issubstr(var_10.script_parameters, "weapon")) {
                var_18 = spawn(var_10.script_parameters, var_10.origin);
                var_18.angles = var_10.angles;
                var_18 linkto(var_5, "tag_sat1");
              }

              continue;
            }

            if(isDefined(var_10.model) && issubstr(var_10.model, "strap")) {
              var_10.animname = var_5.animname;
              var_6 = common_scripts\utility::array_add(var_6, var_10);
              var_5.straps = var_10;
              continue;
            }

            var_10 linkto(var_5, "j_spine4");
          }
        }

        common_scripts\utility::array_thread(var_6, maps\_anim::setanimtree);
        var_20 = randomfloatrange(0.1, 0.5);
        common_scripts\utility::array_thread(var_6, common_scripts\utility::delaycall, var_20, ::setanim, var_5 maps\_utility::getanim("sway"));

        if(isDefined(var_5.link_point)) {
          var_5.link_point setModel("tag_origin");
          maps\_utility::deep_array_call([var_5, var_5.straps], ::linkto, [var_5.link_point, "tag_origin", (0, 0, 0), (0, 0, 0)]);
        } else
          var_5.link_point = var_5;

        if(!isDefined(level._train.cars[var_5.link_point.script_noteworthy].accessory))
          level._train.cars[var_5.link_point.script_noteworthy].accessory = [];

        level._train.cars[var_5.link_point.script_noteworthy].accessory = common_scripts\utility::array_combine(level._train.cars[var_5.link_point.script_noteworthy].accessory, var_6);
      }
    }
  }

  if(isDefined(level._sat.player_start_1)) {
    for(var_11 = 0; var_11 < 2; var_11++) {
      var_23 = var_11 + 1;
      var_24 = maps\skyway_util::setup_door("model_sat1_bridge_" + var_23, "bridge", "jnt_bridge");
      var_24._anim_node = getent("origin_sat1_bridge_" + var_23, "targetname");
      var_24._anim_node maps\_anim::anim_last_frame_solo(var_24, "bridge_push");
      var_24 linkto(var_24._anim_node);
    }
  }

  if(isDefined(level._sat.player_start_2)) {
    level._sat.bridges = [];

    for(var_11 = 0; var_11 < 2; var_11++) {
      var_23 = var_11 + 1;
      var_24 = maps\skyway_util::setup_door("model_sat2_bridge_" + var_23, "bridge", "jnt_bridge");
      var_24._index = var_23;
      var_25 = getEntArray(var_24.col_brush.target, "targetname");

      foreach(var_27 in var_25) {
        if(var_27.script_parameters == "ai")
          var_24._ai_col = var_27;
        else if(var_27.script_parameters == "player")
          var_24._player_col = var_27;
        else if(var_27.script_parameters == "main_col")
          var_24._main_col = var_27;

        var_27 linkto(var_24);
      }

      var_24._walkway_brush = getent("brush_sat2_bridge_" + var_23, "targetname");
      var_24._walkway_brush_node = var_24._walkway_brush common_scripts\utility::spawn_tag_origin();
      var_24._hint = "hint_sat_bridge_" + var_23;
      var_24._up = 1;
      var_24._anim_node = getent("origin_sat2_bridge_" + var_23, "targetname");
      var_24._anim_node maps\_anim::anim_first_frame_solo(var_24, "bridge_push");
      var_24 linkto(var_24._anim_node);
      var_24._walkway_brush_node linkto(var_24._anim_node);
      level._sat.bridges = common_scripts\utility::array_add(level._sat.bridges, var_24);
    }
  }

  level.player thread maps\skyway_util::flag_watcher("flag_force_mantle", ::enableforcemantle);
  getent("flag_sat2_jump", "targetname") setmovingplatformtrigger();
}

enableforcemantle() {
  self forcemantle();
}

resolve_link_yaw(var_0, var_1) {
  if(var_0.angles[1] != var_1.angles[1])
    return 0;
  else
    return 180;
}

start() {
  iprintln(level.start_point);
  var_0 = undefined;
  var_1 = undefined;

  if(issubstr(level.start_point, "1")) {
    var_0 = level._sat.player_start_1;
    var_1 = level._sat.ally_start_1;
  } else {
    var_0 = level._sat.player_start_2;
    var_1 = level._sat.ally_start_2;
  }

  maps\skyway_util::player_start(var_0);
  level._allies[0] forceteleport(var_1.origin, var_1.angles);
  level._allies[0] maps\_utility::set_force_color("r");
  level._allies[0] maps\skyway_util::set_twitch(0);
  thread maps\skyway_fx::fx_create_sunflare_source();
  thread maps\skyway_fx::fx_turnon_tunnel_lights_01();
  thread maps\skyway_fx::fx_turnon_rooftop_lights();
  thread tunnel_lights();
  thread maps\skyway_util::ambient_airbursts_startpoint();
}

main_sat1() {
  thread allies_sat1();
  thread enemies_sat1();
  thread dialogue_sat1();
  maps\_utility::autosave_by_name("sat1");
  common_scripts\utility::array_call(level._train.cars["train_sat_1"].trigs, ::setmovingplatformtrigger);
  thread maps\skyway_util::flag_wait_func("flag_sat_rog", ::event_rog_impact, "1");
  common_scripts\utility::flag_wait("flag_sat1_end");
}

main_sat2() {
  thread allies_sat2();
  thread enemies_sat2();
  thread dialogue_sat2();
  level.player setclienttriggeraudiozone("skyway_train_ext_sat", 0.5);
  common_scripts\utility::array_thread(level._sat.bridges, ::event_player_bridge_push);
  thread autosave_sat("sat2");
  common_scripts\utility::array_call(level._train.cars["train_sat_2"].trigs, ::setmovingplatformtrigger);
  thread maps\skyway_util::flag_wait_func("flag_sat_rog2", ::event_rog_impact, "2");
  thread maps\skyway_fx::fx_turnon_tunnel_lights_01();
  thread tunnel_lights();
  thread maps\skyway_fx::fx_turnon_rooftop_lights();
  common_scripts\utility::flag_wait("flag_sat2_end");
  thread autosave_sat("sat2_end");
  common_scripts\utility::flag_clear("flag_pause_ambient_train_shakes");
}

dialogue_sat1() {
  var_0 = level._allies[0];

  if(!issubstr(level.start_point, "sat")) {
    common_scripts\utility::flag_wait("flag_hangar_intro_done");

    for(var_1 = var_0 maps\skyway_util::getcurrenttraincar(); !isDefined(var_1) || !issubstr(var_1, "sat"); var_1 = var_0 maps\skyway_util::getcurrenttraincar())
      wait 2;
  }

  var_0 maps\_utility::smart_dialogue("skyway_hsh_rorkemustbeat");
  common_scripts\utility::flag_wait("flag_sat1_enemy_spawn");
  wait 3;
  var_0 maps\_utility::smart_dialogue("skyway_hsh_contact");
  var_0 maps\_utility::smart_dialogue("skyway_hsh_theyremovingontothe");
  common_scripts\utility::flag_wait("flag_sat1_sniper_spawn");
  wait 2;
  var_0 maps\_utility::smart_dialogue("skyway_hsh_sniper12oclock");
}

dialogue_sat2() {
  var_0 = level._allies[0];
  level waittill("hero_train_impact_hit2");
  wait 1;
  var_0 maps\_utility::smart_dialogue("skyway_hsh_shitthatwasclose");
  wait 1;
  var_0 maps\_utility::smart_dialogue("skyway_hsh_takecoverinthe");
  common_scripts\utility::flag_wait("flag_sat2_retreat_2");
  var_0 maps\_utility::smart_dialogue("skyway_mrk_thisway");
  common_scripts\utility::flag_wait("flag_sat2_end");
  thread dialogue_mantle();
}

dialogue_mantle() {
  var_0 = level._allies[0];
  var_0 maps\_utility::smart_dialogue("skyway_hsh_wellgettorourke");
  var_1 = ["skyway_hsh_jumptotheroof", "skyway_hsh_dammitadamtakethe"];

  if(!common_scripts\utility::flag("flag_rooftops_start"))
    var_0 thread maps\skyway_util::dialogue_nag(var_1, "flag_rooftops_start");
}

allies_sat1() {
  var_0 = level._allies[0];
  thread maps\skyway_util::flag_wait_func("flag_sat1_enemy_spawn", common_scripts\utility::flag_set, "flag_killer_tracker");
  thread maps\skyway_util::flag_wait_func("flag_sat_retreat_1", common_scripts\utility::flag_clear, "flag_killer_tracker");
  thread maps\skyway_util::flag_wait_func("flag_sat1_end", common_scripts\utility::flag_set, "flag_killer_tracker");
  var_0 thread maps\skyway_util_ai::ally_advance_watcher("trig_sat_1_allies_1", "sat1", "flag_sat2_jump", common_scripts\utility::flag_set, "flag_sat1_end");

  if(!issubstr(level.start_point, "sat")) {
    var_0 thread maps\skyway_util::waittill_func("rt_traverse_done", common_scripts\utility::flag_set, "flag_ally_at_sat1");
    common_scripts\utility::flag_wait("flag_hangar_intro_done");
  } else
    common_scripts\utility::flag_set("flag_ally_at_sat1");

  var_0 maps\_utility::set_ignoresuppression(1);
  var_0 maps\_utility::disable_pain();
  var_0 pushplayer(1);

  if(!common_scripts\utility::flag("trig_sat_1_allies_1"))
    maps\_utility::activate_trigger_with_targetname("trig_sat1_ally_jump");

  var_0 thread event_noticket();
  common_scripts\utility::flag_wait("flag_sat1_enemy_spawn");
  maps\_utility::autosave_by_name("sat1_combat");
}

allies_sat2() {
  thread maps\skyway_util::flag_wait_func("flag_sat2_retreat_1", common_scripts\utility::flag_clear, "flag_killer_tracker");
  thread maps\skyway_util::flag_wait_func("flag_sat2_main_killer_tracker", common_scripts\utility::flag_set, "flag_killer_tracker");
  thread maps\skyway_util::flag_wait_func("flag_sat2_retreat_2", common_scripts\utility::flag_clear, "flag_killer_tracker");
  var_0 = level._allies[0];
  var_0 maps\_utility::set_ignoresuppression(1);
  var_0 maps\_utility::disable_pain();
  var_0 pushplayer(1);
  var_1 = level._sat.bridges[0];
  var_2 = level._sat.bridges[1];
  level._ally_dist = 512;
  var_0 thread maps\skyway_util_ai::ally_advance_watcher("trig_sat_2_allies_1", "sat2", "flag_rooftops_jump", common_scripts\utility::flag_set, "flag_sat2_end");

  if(issubstr(level.start_point, "sat2"))
    maps\_utility::activate_trigger_with_targetname("trig_sat_2_allies_1");

  common_scripts\utility::flag_wait_either("flag_sat2_retreat_2", "flag_sat2_end");
  level._ally_dist = undefined;

  if(!common_scripts\utility::flag("flag_sat2_end")) {
    thread autosave_sat("sat2_bridge");

    if(var_2._up) {
      var_0 maps\_utility::disable_ai_color();
      var_0.oldgoalradius = var_0.goalradius;
      var_0.goalradius = 16;
      var_0 setgoalnode(getnode("node_sat2_bridge", "targetname"));
      common_scripts\utility::waittill_any_ents(var_0, "rt_traverse_done", level, "flag_sat2_end");
      var_0.goalradius = var_0.oldgoalradius;
    }

    if(var_2._up && !common_scripts\utility::flag("flag_sat2_end"))
      var_0 event_ally_bridge_push(var_2);
  }

  if(common_scripts\utility::flag("flag_sat2_end"))
    var_0 forceteleport(getnode("node_sat2_hesh_warp", "targetname").origin, var_0.angles);

  var_0 maps\_utility::enable_ai_color();
}

autosave_sat(var_0) {
  level endon("flag_kill_plane");
  level endon("flag_death_crush");

  for(var_1 = level.player getmovingplatformparent(); !isDefined(var_1) || issubstr(var_1.targetname, "cargo"); var_1 = level.player getmovingplatformparent())
    wait 0.2;

  maps\_utility::autosave_by_name(var_0);
}

enemies_sat1() {
  maps\_utility::array_spawn_function_targetname("actor_sat1_1", ::spawnfunc_enemies_ignore, "sat1");
  maps\_utility::array_spawn_function_targetname("actor_sat1_2", ::spawnfunc_enemies_ignore, "sat1");
  maps\_utility::array_spawn_function_targetname("actor_sat1_enemy_rog_fall", ::spawnfunc_enemies_rog, "sat1_rog");
  maps\_utility::array_spawn_function_targetname("actor_sat1_noticket", ::spawnfunc_enemies_noticket);
  common_scripts\utility::flag_wait("flag_sat1_end");

  if(isDefined(level._enemies["sat1"])) {
    var_0 = maps\_utility::remove_dead_from_array(level._enemies["sat1"]);
    common_scripts\utility::array_thread(var_0, maps\_utility::follow_path, getnode("node_sat2_start", "targetname"));
    common_scripts\utility::array_thread(var_0, maps\skyway_util_ai::add_to_group, "sat2");
    common_scripts\utility::array_thread(var_0, maps\skyway_util::spawnfunc_death_override);
  }

  maps\_utility::array_spawn_targetname("actor_sat2_1");
}

enemies_sat2() {
  thread maps\skyway_util::flag_wait_func("flag_sat2_end", ::cleanup_sat_enemies);
  maps\_utility::array_spawn_function_targetname("actor_sat2_1", ::spawnfunc_enemies_ignore, "sat2");
  maps\_utility::array_spawn_function_targetname("actor_sat2_2", ::spawnfunc_enemies_ignore, "sat2");
  maps\_utility::array_spawn_function_targetname("actor_sat2_3", ::spawnfunc_enemies_runner);
  maps\_utility::array_spawn_function_targetname("actor_sat2_enemy_rog_run", ::spawnfunc_enemies_rog, "sat2");
  maps\_utility::array_spawn_function_targetname("actor_sat2_right", ::spawnfunc_enemies_sat2_top, "surprise");
  maps\_utility::array_spawn_function_targetname("actor_sat2_left", ::spawnfunc_enemies_sat2_top, "surprise");
  level waittill("hero_train_impact_hit2");
  maps\_utility::array_spawn_targetname("actor_sat2_enemy_rog_run");
}

cleanup_sat_enemies(var_0) {
  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(isDefined(level._enemies[var_2]))
        cleanup_sat_enemies_solo(level._enemies[var_2]);
    }
  } else {
    foreach(var_5 in level._enemies)
    cleanup_sat_enemies_solo(var_5);
  }
}

cleanup_sat_enemies_solo(var_0) {
  var_0 = maps\_utility::remove_dead_from_array(var_0);
  common_scripts\utility::array_thread(var_0, maps\_utility::player_seek_disable);
  thread ai_kill_when_out_of_sight(var_0, 512);
}

spawnfunc_enemies_sat2_top(var_0) {
  maps\skyway_util_ai::add_to_group(var_0);
  self.script_forcegoal = 1;
  self.maxfaceenemydist = 256;
  self.a.disablelongdeath = 1;
  self.health = 1;
  self.baseaccuracy = 0.1;
  thread maps\skyway_util::spawnfunc_death_override();
  thread proximity_player_seek();
}

spawnfunc_enemies_rog(var_0) {
  maps\skyway_util_ai::add_to_group(var_0);
  self.script_forcegoal = 1;
  self.maxfaceenemydist = 256;
  self.a.disablelongdeath = 1;
  var_1 = self.script_parameters;
  self.animname = "generic";

  if(issubstr(self.script_parameters, "fall")) {
    thread rail_fall_forcedeathfall();
    maps\skyway_util_ai::ignore_everything();
  }

  if(isDefined(self.script_index))
    thread murderzone();

  wait 0.05;

  if(issubstr(self.script_parameters, "stumble")) {
    var_2 = level._train.cars["train_sat_2"].body;
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3 linkto(var_2, "j_spineupper");
    self linkto(var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_3 maps\skyway_vignette::vignette_single_solo(self, var_1, undefined, undefined, undefined, 0.3);
    thread proximity_player_seek();
    self unlink();
    var_3 delete();
  } else {
    var_3 = getent("origin_" + var_1, "targetname");
    self linkto(var_3);

    if(issubstr(self.script_parameters, "fall")) {
      var_3 maps\_anim::anim_first_frame_solo(self, var_1);
      self endon("death");
      wait 1;
      var_3 maps\skyway_vignette::vignette_single_solo(self, var_1);
    } else {
      var_3 maps\skyway_vignette::vignette_single_solo(self, var_1, undefined, undefined, undefined, 0.3);
      self unlink();

      if(issubstr(self.script_parameters, "run"))
        maps\_utility::kill_deathflag("deathflag_sat2_rog_run");
    }
  }
}

rail_fall_forcedeathfall() {
  self endon("death");
  level waittill("notify_sat1_rog_run_fall");
  self.v.invincible = 1;
  level waittill("notify_sat1_rog_run_delete");

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    maps\_utility::stop_magic_bullet_shield();

  self delete();
}

spawnfunc_enemies_ignore(var_0) {
  maps\skyway_util_ai::add_to_group(var_0);
  self.script_forcegoal = 1;
  self.maxfaceenemydist = 256;
  self.a.disablelongdeath = 1;

  if(isDefined(self.script_parameters) && issubstr(self.script_parameters, "death_override"))
    thread maps\skyway_util::spawnfunc_death_override();

  maps\skyway_util_ai::ignore_until_goal(2);
  thread proximity_player_seek();

  if(isDefined(self.script_index))
    thread murderzone();
}

spawnfunc_enemies_noticket() {
  self.v.delete_on_end = 1;
  self.v.invincible = 1;
  self.animname = "noticket_enemy";
  self.a.disablelongdeath = 1;
}

spawnfunc_enemies_runner() {
  self.a.disablelongdeath = 1;
  wait 6;
  maps\_utility::kill_deathflag("deathflag_sat2_run");
}

event_noticket() {
  common_scripts\utility::flag_wait("flag_sat1_noticket");

  if(common_scripts\utility::flag("flag_ally_at_sat1")) {
    var_0 = getent("origin_sat1_noticket", "targetname");
    var_0 maps\_anim::anim_reach_solo(self, "noticket");

    if(!common_scripts\utility::flag("flag_sat1_noticket_stop")) {
      var_1 = getent("actor_sat1_noticket", "targetname") maps\_utility::spawn_ai();
      thread maps\skyway_audio::sfx_noticket(var_1);
      common_scripts\utility::array_call([self, var_1], ::linkto, var_0);
      var_0 thread maps\skyway_vignette::vignette_single([self, var_1], "noticket");
      self waittill("msg_vignette_end");
      self unlink();
    }
  }

  maps\_utility::enable_ai_color();
}

event_player_bridge_push() {
  self endon("notify_bridge_down");
  maps\skyway_util::waittill_trigger_activate_looking_at(self, self._hint, 128, undefined, "jnt_handle", 5);
  self._up = 0;
  level.player enableinvulnerability();
  level.player disableweapons();
  maps\skyway_util::setup_player_for_animated_sequence(0, 0);
  level.player_rig hide();
  self._anim_node maps\_anim::anim_first_frame_solo(level.player_rig, "bridge_push_player");
  level.player_rig linkto(self._anim_node);

  if(issubstr(level.player getcurrentweapon(), "svu"))
    wait 1;

  self._main_col connectpaths();
  self._main_col delete();
  self._player_col delete();
  thread maps\skyway_audio::sfx_bridge_down_plr();
  level.player playerlinktoblend(level.player_rig, "tag_player", 0.5);
  level.player_rig common_scripts\utility::delaycall(0.5, ::show);
  self._anim_node thread maps\_anim::anim_single([self, level.player_rig], "bridge_push_player");
  level waittill("notify_draw_weapon");
  level.player enableweapons();
  self._walkway_brush linkto(self._walkway_brush_node, "tag_origin", (0, 0, 0), (0, 0, 0));
  self._anim_node waittill("bridge_push_player");
  maps\skyway_util::player_animated_sequence_cleanup();

  if(self._index == 2) {
    self._ai_col connectpaths();
    self._ai_col delete();
    common_scripts\utility::flag_set("flag_left_bridge_down");
  } else
    thread remove_ai_collision();

  level.player disableinvulnerability();
}

remove_ai_collision() {
  common_scripts\utility::flag_wait_either("flag_left_bridge_down", "flag_sat2_end");
  self._ai_col connectpaths();
  self._ai_col delete();
}

event_ally_bridge_push(var_0) {
  level endon("flag_sat2_end");
  var_0._anim_node maps\_anim::anim_reach_solo(self, "bridge_push");

  if(var_0._up) {
    maps\skyway_util_ai::ignore_everything();
    self linkto(var_0._anim_node);
    var_0 notify("notify_bridge_down");
    var_0._up = 0;
    var_0._main_col connectpaths();
    var_0._main_col delete();
    var_0._ai_col connectpaths();
    var_0._ai_col delete();
    var_0._player_col common_scripts\utility::delaycall(4, ::delete);
    thread maps\skyway_audio::sfx_bridge_down_npc();
    var_0._anim_node maps\_anim::anim_single([self, var_0], "bridge_push");
    var_0._walkway_brush linkto(var_0._walkway_brush_node, "tag_origin", (0, 0, 0), (0, 0, 0));
    self unlink();
    maps\skyway_util_ai::unignore_everything();
    common_scripts\utility::flag_set("flag_left_bridge_down");
  }
}

event_rog_impact(var_0) {
  var_1 = level._allies[0];
  var_2 = 0.5;
  var_3 = 0;
  var_4 = level._train.cars["train_sat_2"].body;
  var_5 = anglestoright(var_4.angles);
  var_6 = level.player.origin - var_4.origin;
  var_7 = vectordot(var_5, var_6);

  if(var_7 > 0) {
    var_8 = "tag_explode_close_r";
    var_9 = "sathit_sat_explode_R";
    var_10 = ["scn_skyway_missile_explode", "scn_skyway_missile_impact", "skyway_missile_hit_01"];
  } else {
    var_8 = "tag_explode_close_l";
    var_9 = "sathit_sat_explode_L";
    var_10 = ["scn_skyway_missile_explode", "scn_skyway_missile_impact", "skyway_missile_hit_01"];
  }

  thread maps\skyway_util::hero_train_impact(level._train.cars["train_rt0"].body, var_8, var_9, var_10, var_2, var_3, undefined, var_0, 1);
  level waittill("hero_train_impact_hit");
  var_11 = var_1 maps\skyway_util::getcurrenttraincar();

  if(isDefined(var_11)) {
    var_12 = level._train.cars[var_11].body;
    var_13 = var_1 common_scripts\utility::spawn_tag_origin();
    var_13.angles = var_12 gettagangles("j_spineupper");
    var_13 linkto(var_12, "j_spineupper");
    var_1 linkto(var_13, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_13 maps\_anim::anim_single_solo(var_1, "sat_rog_hit", undefined, 0.1);
    var_1 unlink();
    var_1 maps\_utility::enable_ai_color();
    var_13 delete();
  } else {}
}

proximity_player_seek(var_0) {
  self endon("death");
  self endon("stop_player_seek");

  if(!isDefined(var_0))
    var_0 = 128;

  var_1 = var_0 * var_0;

  for(;;) {
    if(distancesquared(level.player.origin, self.origin) < var_1) {
      break;
    }

    wait 1;
  }

  maps\_utility::set_fixednode_false();
  maps\_utility::set_baseaccuracy(3);
  maps\_utility::player_seek_enable();
}

murderzone() {
  self endon("death");
  var_0 = self.baseaccuracy;

  while(!common_scripts\utility::flag("flag_sat2_retreat_2")) {
    if(common_scripts\utility::flag("flag_sat2_murderzone")) {
      maps\_utility::set_baseaccuracy(var_0);
      setthreatbias("axis", "player", 1000);
    } else {
      maps\_utility::set_baseaccuracy(0.7);
      maps\_utility::clearthreatbias("axis", "player");
    }

    wait 0.5;
  }

  maps\_utility::set_baseaccuracy(0.3);
  maps\_utility::clearthreatbias("axis", "player");
}

tunnel_lights() {
  var_0 = getEntArray("light_tunnel_warm", "targetname");
  var_1 = getEntArray("light_tunnel_cool", "targetname");

  foreach(var_3 in var_0) {
    var_3 setlightcolor((0.99, 0.95, 0.81));
    var_3 setlightintensity(0.75);
  }

  foreach(var_3 in var_1) {
    var_3 setlightcolor((0.66, 0.78, 0.85));
    var_3 setlightintensity(0.65);
  }
}

flag_tester_law() {
  common_scripts\utility::flag_wait("flag_sat1_end");
  common_scripts\utility::flag_wait("flag_sat2_end");
  common_scripts\utility::flag_wait("flag_vision_tunnel");
}

base_array_ambient_dogfight_1() {
  level endon("kill_vista_a10");
  wait(randomfloatrange(35.0, 36.0));
  level.base_array_ambient_a10_gun_dive_1 = undefined;
  level.base_array_ambient_a10_gun_dive_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_1");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_1");
  var_0 thread maps\skyway_ambient_a10::mig29_afterburners_node_wait();

  if(common_scripts\utility::cointoss())
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_1_buddy");

  wait(randomfloatrange(4.0, 5.0));
}

base_array_ambient_dogfight_2() {
  level endon("kill_vista_a10");

  for(;;) {
    wait(randomfloatrange(5.0, 25.0));
    level.base_array_ambient_a10_gun_dive_2 = undefined;
    level.base_array_ambient_a10_gun_dive_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_2");

    if(common_scripts\utility::cointoss())
      var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_2_buddy");

    wait 0.5;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_2");
    var_1 thread maps\skyway_ambient_a10::mig29_afterburners_node_wait();

    if(common_scripts\utility::cointoss())
      var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_2_buddy");

    wait(randomfloatrange(5.0, 10.0));
  }
}

base_array_ambient_dogfight_3() {
  level endon("kill_vista_a10");

  for(;;) {
    wait(randomfloatrange(35.0, 36.0));
    level.base_array_ambient_a10_gun_dive_3 = undefined;
    level.base_array_ambient_a10_gun_dive_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_3");
    wait 0.5;
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_3");
    var_0 thread maps\skyway_ambient_a10::mig29_afterburners_node_wait();

    if(common_scripts\utility::cointoss())
      var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_3_buddy");

    wait(randomfloatrange(5.0, 10.0));
  }
}

base_array_ambient_dogfight_1b() {
  level endon("kill_vista_a10");

  for(;;) {
    wait(randomfloatrange(2.0, 10.0));
    level.base_array_ambient_a10_gun_dive_1b = undefined;
    level.base_array_ambient_a10_gun_dive_1b = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_1b");

    if(common_scripts\utility::cointoss())
      var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_1b_buddy");

    wait 0.5;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_1b");
    var_1 thread maps\skyway_ambient_a10::mig29_afterburners_node_wait();

    if(common_scripts\utility::cointoss())
      var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_1b_buddy");

    wait(randomfloatrange(4.0, 8.0));
  }
}

base_array_ambient_dogfight_2b() {
  level endon("kill_vista_a10");

  for(;;) {
    wait(randomfloatrange(5.0, 7.0));
    level.base_array_ambient_a10_gun_dive_2b = undefined;
    level.base_array_ambient_a10_gun_dive_2b = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_2b");
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_2b_buddy");
    wait 0.5;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_2b");
    var_1 thread maps\skyway_ambient_a10::mig29_afterburners_node_wait();
    wait(randomfloatrange(1.0, 2.5));
  }
}

base_array_ambient_dogfight_3b() {
  level endon("kill_vista_a10");

  for(;;) {
    wait(randomfloatrange(15.0, 20.0));
    level.base_array_ambient_a10_gun_dive_3b = undefined;
    level.base_array_ambient_a10_gun_dive_3b = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_3b");

    if(common_scripts\utility::cointoss())
      var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_3b_buddy");

    wait 0.5;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_3b");
    var_1 thread maps\skyway_ambient_a10::mig29_afterburners_node_wait();

    if(common_scripts\utility::cointoss())
      var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_3b_buddy");

    wait(randomfloatrange(5.0, 10.0));
  }
}

base_array_ambient_dogfight_4b() {
  common_scripts\utility::flag_wait("flag_sat1_end");
  level endon("flag_vision_tunnel");

  for(;;) {
    wait(randomfloatrange(3.0, 7.0));
    var_0 = getEntArray("base_array_ambient_a10_gun_dive_4b", "targetname");
    var_1 = common_scripts\utility::getclosest(level.player.origin, var_0);
    var_2 = var_1 maps\_vehicle::spawn_vehicle_and_gopath();
    wait 0.5;
    var_3 = getEntArray("base_array_ambient_mig29_gun_dive_4b", "targetname");
    var_4 = common_scripts\utility::getclosest(level.player.origin, var_3);
    var_5 = var_4 maps\_vehicle::spawn_vehicle_and_gopath();
    var_5 thread maps\skyway_ambient_a10::mig29_afterburners_node_wait();
    wait(randomfloatrange(1.0, 2.0));
  }
}

base_array_ambient_dogfight_5b() {
  common_scripts\utility::flag_wait("flag_sat1_end");
  level endon("flag_vision_tunnel");

  for(;;) {
    wait(randomfloatrange(3.0, 4.0));
    var_0 = getEntArray("base_array_ambient_a10_gun_dive_5b", "targetname");
    var_1 = common_scripts\utility::getclosest(level.player.origin, var_0);
    var_2 = var_1 maps\_vehicle::spawn_vehicle_and_gopath();
    wait 0.5;
    var_3 = getEntArray("base_array_ambient_mig29_gun_dive_5b", "targetname");
    var_4 = common_scripts\utility::getclosest(level.player.origin, var_3);
    var_5 = var_4 maps\_vehicle::spawn_vehicle_and_gopath();
    var_5 thread maps\skyway_ambient_a10::mig29_afterburners_node_wait();
    wait(randomfloatrange(1.0, 2.0));
  }
}

base_array_ambient_dogfight_6b() {
  common_scripts\utility::flag_wait("flag_sat1_end");
  level endon("flag_vision_tunnel");

  for(;;) {
    wait(randomfloatrange(4.0, 6.0));
    var_0 = getEntArray("base_array_ambient_mig29_gun_dive_6b", "targetname");
    var_1 = common_scripts\utility::getclosest(level.player.origin, var_0);
    var_2 = var_1 maps\_vehicle::spawn_vehicle_and_gopath();
    wait(randomfloatrange(1.0, 2.0));
  }
}

base_array_ambient_dogfight_6c() {
  common_scripts\utility::flag_wait("flag_sat1_end");
  level endon("flag_vision_tunnel");

  for(;;) {
    wait(randomfloatrange(2.0, 4.0));
    var_0 = getEntArray("base_array_ambient_mig29_gun_dive_6c", "targetname");
    var_1 = common_scripts\utility::getclosest(level.player.origin, var_0);
    var_2 = var_1 maps\_vehicle::spawn_vehicle_and_gopath();
    wait(randomfloatrange(1.0, 2.0));
  }
}

ai_kill_when_out_of_sight(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = 0.75;

  if(issplitscreen())
    var_2 = 0.65;

  while(var_0.size > 0) {
    wait 1;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      if(!isDefined(var_0[var_3]) || !isalive(var_0[var_3])) {
        var_0 = common_scripts\utility::array_remove(var_0, var_0[var_3]);
        continue;
      }

      if(maps\_utility::players_within_distance(var_1, var_0[var_3].origin)) {
        continue;
      }
      if(maps\_utility::either_player_looking_at(var_0[var_3].origin + (0, 0, 48), var_2, 1)) {
        continue;
      }
      if(isDefined(var_0[var_3].magic_bullet_shield))
        var_0[var_3] maps\_utility::stop_magic_bullet_shield();

      var_0[var_3] maps\_utility_code::kill_deathflag_proc();
      var_0 = common_scripts\utility::array_remove(var_0, var_0[var_3]);
    }
  }
}