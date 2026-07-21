/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\captive\captive_cellblock_escape.gsc
********************************************************/

cellblock_escape_flags() {
  scripts\engine\utility::flag_init("exit_vent_look");
  scripts\engine\utility::flag_init("force_exit_vent_look");
  scripts\engine\utility::flag_init("looked_at_window");
  scripts\engine\utility::flag_init("checked_wb_gate");
  scripts\engine\utility::flag_init("found_chair");
  scripts\engine\utility::flag_init("placed_chair");
  scripts\engine\utility::flag_init("chair_door_blocked");
  scripts\engine\utility::flag_init("in_close_chair_placement");
  scripts\engine\utility::flag_init("in_far_chair_placement");
  scripts\engine\utility::flag_init("chair_in_position");
  scripts\engine\utility::flag_init("on_chair");
  scripts\engine\utility::flag_init("done_chair_hint");
  scripts\engine\utility::flag_init("used_vent");
  scripts\engine\utility::flag_init("disabled_jump");
  scripts\engine\utility::flag_init("post_explosion");
}

cellblock_escape_start() {
  scripts\engine\sp\utility::set_start_location("player_spawn_cellblock_escape", [level.player]);
  scripts\sp\player\teenagefarah::teenage_farah_stealth_setup();
  scripts\sp\maps\captive\captive_util.gsc::setup_noisemaker_pickups();
  scripts\sp\maps\captive\captive_util.gsc::disable_context_melee();
  setomnvar("ui_hide_hud", 1);
  thread scripts\sp\maps\captive\captive_vo.gsc::vo_walla_guards_alert();
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("hadir_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("main_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("break_final");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("waterboarding");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("post_explosion");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("fallen_grate");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("upstairs");
}

cellblock_escape_main() {
  level thread chair_place_hint_timer();
  var_0 = getEnt("chair_flag_volume", "targetname");
  var_0 enablelinkTo();
  var_0 linkTo(level.cellchair);
  level.chairplacedpos = scripts\engine\utility::getStruct("chair_in_position", "targetname");
  level.facingventpos = scripts\engine\utility::getStruct("player_facing_vent", "targetname");
  level.cellchair setup_chair_carry_fsm();
  var_1 = getEntArray("chair_door_block_check", "targetname");

  foreach(var_3 in var_1)
  var_3 thread check_chair_door_blocked();

  thread scripts\sp\maps\captive\captive_vo.gsc::mus_far_sewer_crawl();
  level thread check_exit_vent_look();
  level thread check_view_window_scene();
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_cb_look_at_drain();
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_cb_linger_no_chair();
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_cb_looking_at_stairs();
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_cb_check_see_chair();
  level thread check_interact_door();
  level thread check_player_use_vent();
  var_5 = getEntArray("window_check_trigger", "targetname");

  foreach(var_7 in var_5)
  var_7 thread scripts\sp\maps\captive\captive_vo.gsc::vo_cb_trying_to_climb_window();

  scripts\engine\sp\objectives::objective_update("objective", "current", undefined, &"CAPTIVE/OBJ_WAY_OUT_DESC", &"CAPTIVE/OBJ_WAY_OUT");
  scripts\engine\utility::flag_wait("used_vent");
  level notify("finished_drain_room");
  level.drainroomdoorinteract scripts\sp\player\cursor_hint::remove_cursor_hint();

  if(scripts\engine\utility::flag("done_chair_hint"))
    scripts\engine\sp\objectives::objective_update("objective", "current", undefined, &"CAPTIVE/OBJ_WAY_OUT_DESC", &"CAPTIVE/OBJ_WAY_OUT");

  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_way_out", "targetname").origin);
  thread scripts\sp\analytics::analytics_kleenex_update("Hit button to exit grate");
  thread scripts\engine\sp\utility::autosave_by_name("basement_stealth");
}

cellblock_escape_catchup() {
  if(level.start_point == "bink_speech") {
    return;
  }
  level.cellchair.origin = scripts\engine\utility::getStruct("chair_in_position", "targetname").origin;
  level.exitvent = getEnt("exit_vent", "targetname");
  level.exitvent.animname = "vent";
  level.exitvent scripts\common\anim::setanimtree();
  level.exitvent thread scripts\common\anim::anim_last_frame_solo(level.exitvent, "vent_swing_open");
  scripts\engine\sp\objectives::objective_update("objective", "current", undefined, &"CAPTIVE/OBJ_WAY_OUT_DESC", &"CAPTIVE/OBJ_WAY_OUT");
}

check_exit_vent_look() {
  var_0 = cos(20);
  var_1 = cos(30);
  var_2 = scripts\engine\utility::getStruct("exit_vent_obj", "targetname");
  var_3 = scripts\engine\utility::getStruct("exit_vent_swing_look", "targetname");
  var_4 = 1;

  while(var_4) {
    scripts\engine\utility::flag_wait_either("exit_vent_look", "force_exit_vent_look");

    if(scripts\engine\utility::flag("found_chair")) {
      if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_2.origin, var_1) || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_3.origin, var_1)) {
        wait 0.25;

        if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_2.origin, var_1) || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_3.origin, var_1))
          var_4 = 0;
      }
    } else if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_2.origin, var_0) || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_3.origin, var_0)) {
      wait 0.25;

      if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_2.origin, var_0) || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_3.origin, var_0))
        var_4 = 0;
    }

    if(scripts\engine\utility::flag("force_exit_vent_look"))
      var_4 = 0;

    waitframe();
  }

  level thread scripts\engine\utility::play_sound_in_space("captive_cell_distant_explosion_vent", (5973, 1057, -98));
  earthquake(0.3, 2, level.player.origin, 300);
  level.player playRumbleOnEntity("light_1s");
  scripts\engine\utility::exploder("corridor_light_snap");
  scripts\engine\utility::kill_exploder("corridor_light");
  getEnt("corridor_light", "targetname") setModel("ee_lighting_string_light_caged_01");
  scripts\engine\utility::exploder("explode_dust");
  thread scripts\engine\utility::play_sound_in_space("scn_captive_escape_expl_dirt", (6033, 1010, -90));
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("pre_explosion");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("post_explosion");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("fallen_grate");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("break_final");
  scripts\engine\utility::flag_set("post_explosion");
  wait 0.5;
  level.exitvent = getEnt("exit_vent", "targetname");
  level.exitvent.animname = "vent";
  level.exitvent scripts\common\anim::setanimtree();
  thread scripts\engine\utility::play_sound_in_space("scn_captive_loose_vent_swing", level.exitvent.origin);
  level.chairplacedpos scripts\common\anim::anim_single_solo(level.exitvent, "vent_swing_open");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("fallen_grate");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("break_final");
}

chair_place_hint_timer() {
  level endon("used_vent");
  scripts\engine\utility::flag_wait("found_chair");
  wait 120;
  scripts\engine\utility::flag_set("done_chair_hint");
  scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("exit_vent_obj", "targetname").origin, &"CAPTIVE/OBJ_EXIT_VENT_DESC", &"CAPTIVE/OBJ_EXIT_VENT");
}

check_interact_door() {
  level endon("finished_drain_room");
  level.drainroomdoorinteract = scripts\engine\utility::getStruct("drain_room_door", "targetname");
  level.drainroomdoorinteract thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_USE", 180, 120, 32);
  level.drainroomdoorinteract waittill("trigger");
  var_0 = scripts\engine\utility::getStruct("drain_room_door_ref", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_anim_model("key", level.player.origin, level.player.angles);
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_cb_door_locked();
  var_0 scripts\sp\player_rig::link_player_to_rig("try_key_fail", "stand");
  var_0 scripts\common\anim::anim_single([var_1, level.player_rig], "try_key_fail");
  var_1 delete();
  scripts\sp\player_rig::unlink_player_from_rig();
  scripts\engine\utility::flag_set("checked_wb_gate");
}

check_view_window_scene() {
  level endon("end_window_view");
  scripts\engine\utility::flag_wait("looked_at_window");
  level.windowguys = scripts\engine\sp\utility::array_spawn_targetname("window_view_guards", 1);
  var_0 = getEnt("window_view_guard1", "script_noteworthy");
  var_0.animname = "enemy1";
  var_1 = getEnt("window_view_guard2", "script_noteworthy");
  var_2 = getEnt("window_view_guard3", "script_noteworthy");
  var_1 thread scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("window_2_1", "targetname"));
  var_2 thread scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("window_3_1", "targetname"));
  var_0 scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("window_1_1", "targetname"));
  scripts\sp\maps\captive\captive_vo.gsc::vo_cb_window_view(var_0);
  var_0 thread move_to_and_delete("window_1_2");
  var_1 thread move_to_and_delete("window_2_2");
  var_2 thread move_to_and_delete("window_3_2");
}

move_to_and_delete(var_0) {
  level endon("end_window_view");
  self endon("death");
  scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct(var_0, "targetname"));
  self delete();
}

check_player_use_vent() {
  create_vent_mantle_hint();
  level.jumpheight = -100000;
  var_0 = 1;

  while(var_0) {
    scripts\engine\utility::flag_wait("chair_in_position");
    scripts\engine\utility::flag_set("force_exit_vent_look");
    level thread check_jump_at_chair();

    while(scripts\engine\utility::flag("chair_in_position")) {
      var_1 = level.cellchair.origin[2] + 20;
      scripts\engine\utility::flag_wait("on_chair");

      while(scripts\engine\utility::flag("on_chair")) {
        if(level.player.origin[2] >= var_1) {
          if(!scripts\engine\utility::flag("disabled_jump")) {
            level.player scripts\common\utility::allow_jump(0, "chair_climb");
            scripts\engine\utility::flag_set("disabled_jump");
          }

          if(level.player scripts\engine\math::is_point_in_front(level.facingventpos.origin) && level.player.origin[2] >= var_1) {
            level.enter_vent_hint.alpha = 1;

            if(level.jumpheight >= var_1) {
              level.enter_vent_hint.alpha = 0;
              var_0 = 0;
              level.cellchair notify("done");
              level.chairplacedpos scripts\sp\player_rig::link_player_to_rig("cellblock_vent_climb", "stand", 1, 0.2, undefined, undefined, undefined, undefined, undefined, 1);
              level.chairplacedpos thread scripts\common\anim::anim_single_solo(level.exitvent, "cellblock_vent_climb");
              level.chairplacedpos scripts\common\anim::anim_single_solo(level.player_rig, "cellblock_vent_climb");
              scripts\sp\player_rig::unlink_player_from_rig();
              scripts\engine\utility::flag_set("used_vent");
              level.player scripts\common\utility::allow_jump(1, "chair_climb");
              return;
            }
          } else
            level.enter_vent_hint.alpha = 0;
        } else if(scripts\engine\utility::flag("disabled_jump")) {
          level.player scripts\common\utility::allow_jump(1, "chair_climb");
          scripts\engine\utility::flag_clear("disabled_jump");
        }

        waitframe();
      }

      if(scripts\engine\utility::flag("disabled_jump")) {
        level.player scripts\common\utility::allow_jump(1, "chair_climb");
        scripts\engine\utility::flag_clear("disabled_jump");
      }

      level.enter_vent_hint.alpha = 0;
    }
  }
}

check_jump_at_chair() {
  level endon("used_vent");

  for(;;) {
    level.player waittill("jump_pressed");
    level.jumpheight = level.player.origin[2];
    scripts\sp\maps\captive\captive_lighting.gsc::lights_off("fallen_grate");
  }
}

create_vent_mantle_hint() {
  if(!isDefined(level.enter_vent_hint)) {
    level.enter_vent_hint = newhudelem();
    level.enter_vent_hint.x = 320;
    level.enter_vent_hint.y = 350;
    level.enter_vent_hint.alignx = "center";
    level.enter_vent_hint.aligny = "middle";
    level.enter_vent_hint.sort = 1;
    level.enter_vent_hint.foreground = 1;
    level.enter_vent_hint.hidewheninmenu = 1;
    level.enter_vent_hint.alpha = 0;
    level.enter_vent_hint.fontscale = 1;
    level.enter_vent_hint.font = "objective";
    level.enter_vent_hint settext(&"PLATFORM/MANTLE");
  }
}

check_chair_door_blocked() {
  level endon("used_vent");
  var_0 = anglesToForward(scripts\engine\utility::getStruct(self.target, "targetname").angles);

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      var_1 = vectordot(anglesToForward(level.player.angles), var_0);

      if(var_1 < 0.3 && var_1 > -0.3)
        scripts\engine\utility::flag_set("chair_door_blocked");
      else
        scripts\engine\utility::flag_clear("chair_door_blocked");

      waitframe();
    }

    scripts\engine\utility::flag_clear("chair_door_blocked");
  }
}

setup_chair_carry_fsm() {
  var_0 = [["idle", ::chair_idle_enter, ::chair_idle_update], ["carry", ::chair_carry_enter], ["done", ::chair_done_enter]];
  level.player.iscarrying = 0;
  level.player notifyonplayercommand("interact", "+usereload");
  level.player notifyonplayercommand("interact", "+gostand");
  level.player notifyonplayercommand("interact", "+attack");
  level.player notifyonplayercommand("interact", "+stance");
  self.collision = scripts\engine\utility::get_linked_ent();
  self.carrycount = 0;
  self.placeheight = self.origin[2];
  self.showingcursor = 0;
  self.cornerarray = getEntArray("chair_corner_volume", "targetname");
  self.chairneardoorvol = getEnt("chair_near_door", "targetname");
  self.placedclosevol = getEnt("chair_placed_close", "targetname");
  scripts\engine\utility::flag_set("placed_chair");
  scripts\sp\statemachine::begin_fsm(var_0, "idle");
}

chair_idle_enter() {
  scripts\sp\statemachine::set_notify_handlers([["done", ::chair_done_handler]]);
  var_0 = level.player getcurrentoffhand("secondaryoffhand");

  if(self.carrycount > 0)
    level.player scripts\common\utility::allow_cinematic_motion(1);

  if(var_0.basename != "noisemaker")
    scripts\sp\equipment\noisemaker::noisemakersenablecursors();

  scripts\engine\utility::flag_set("placed_chair");
  chair_check_show_cursor();
  self waittill("trigger");
  scripts\engine\utility::flag_clear("chair_in_position");
  scripts\engine\utility::flag_clear("placed_chair");
  disable_default_player_control_carry();
  level.player playRumbleOnEntity("slide_start");
  scripts\sp\statemachine::goto_state("carry");
}

chair_idle_update() {
  if(self.showingcursor) {
    if(level.player getstance() == "prone")
      disable_chair_carry();
    else if(abs(level.player.origin[2] - self.origin[2]) > 6)
      disable_chair_carry();
  } else if(abs(level.player.origin[2] - self.origin[2]) <= 6) {
    if(level.player getstance() != "prone")
      enable_chair_carry();
  }
}

chair_check_show_cursor() {
  enable_chair_carry();

  if(!scripts\engine\utility::flag("checked_wb_gate") && isDefined(level.drainroomdoorinteract) && !ispointinvolume(self.origin, self.chairneardoorvol))
    level.drainroomdoorinteract thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_USE");
}

chair_carry_enter() {
  self endon("changed_state");
  scripts\sp\statemachine::set_notify_handlers([["done", ::chair_done_handler]]);
  level.player.currentcarryobject = self;
  level.player.iscarrying = 1;
  level.player scripts\common\utility::allow_cinematic_motion(0);
  level.drainroomdoorinteract scripts\sp\player\cursor_hint::remove_cursor_hint();
  level.player scripts\sp\utility::give_weapon("iw8_farahchair_sp");
  level.player switchtoweapon("iw8_farahchair_sp");
  level.player scripts\common\utility::allow_weapon_switch(0, "chair");
  self.carrycount++;
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_cb_chair_carry(self.carrycount);
  scripts\sp\equipment\noisemaker::noisemakersdisablecursors();
  scripts\engine\utility::flag_set("found_chair");
  self.collision notsolid();
  self hide();
  var_0 = 1;

  while(var_0) {
    level.player scripts\engine\utility::waittill_any("interact", "use_pressed", "stance_pressed", "stance_down_pressed", "switch_weapon_pressed");

    if(scripts\engine\utility::flag("chair_door_blocked")) {
      scripts\engine\sp\utility::display_hint("cannot_place", 3);
      continue;
    }

    var_1 = physics_createcontents(["physicscontents_solid", "physicscontents_aiclip", "physicscontents_actor", "physicscontents_player", "physicscontents_playerclip", "physicscontents_item"]);
    var_2 = level.player.origin + (0, 0, 6) + anglesToForward(level.player.angles) * 42;
    var_3 = scripts\engine\trace::ray_trace(level.player.origin + (0, 0, 6), var_2, level.player, var_1);
    var_4 = vectorNormalize(level.player.origin - var_3["position"]);
    var_4 = scripts\engine\utility::flat_origin(var_4);
    var_5 = var_3["position"] + var_4 * 16;
    var_6 = var_3["position"] + var_4 * 44;
    var_6 = (var_6[0], var_6[1], level.player.origin[2]);

    if(scripts\engine\utility::flag("in_far_chair_placement") && !scripts\engine\utility::flag("in_close_chair_placement")) {
      var_7 = scripts\engine\utility::getStruct("chair_in_position", "targetname").origin;

      if(vectordot(vectorNormalize(var_7 - level.player.origin), anglesToForward(level.player.angles)) > 0.5) {
        var_5 = var_7;
        var_6 = var_7 + var_4 * 40;
        var_6 = (var_6[0], var_6[1], level.player.origin[2]);
      }
    }

    if(var_3["normal"] == (0, 0, 0)) {
      var_8 = anglestoleft(level.player.angles) * 12;
      var_9 = scripts\engine\trace::ray_trace(level.player.origin + (0, 0, 6), var_2 + var_8, level.player, var_1);

      if(var_9["hittype"] != "hittype_none")
        var_5 = var_5 - anglestoleft(level.player.angles) * 6;
      else {
        var_10 = anglestoright(level.player.angles) * 12;
        var_11 = scripts\engine\trace::ray_trace(level.player.origin + (0, 0, 6), var_2 + var_10, level.player, var_1);

        if(var_11["hittype"] != "hittype_none")
          var_5 = var_5 - anglestoright(level.player.angles) * 6;
      }

      foreach(var_13 in self.cornerarray) {
        if(ispointinvolume(var_5, var_13)) {
          var_14 = 1;
          var_5 = scripts\engine\utility::getStruct(var_13.target, "targetname").origin;
          break;
        }
      }
    } else {
      if(scripts\engine\math::anglebetweenvectors(var_3["normal"], var_4) > 30) {
        var_5 = var_3["position"] + var_3["normal"] * 12;

        if(distance(var_5, level.player.origin) < 19) {
          if(level.player scripts\engine\math::is_point_on_right(var_5))
            var_6 = var_5 + anglestoright(vectortoangles(var_3["normal"])) * 32;
          else
            var_6 = var_5 + anglestoleft(vectortoangles(var_3["normal"])) * 32;

          var_6 = (var_6[0], var_6[1], level.player.origin[2]);
        } else
          var_6 = level.player.origin;

        var_16 = vectorNormalize(var_5 - var_6);
      }

      foreach(var_13 in self.cornerarray) {
        if(ispointinvolume(var_5, var_13)) {
          var_14 = 1;
          var_5 = scripts\engine\utility::getStruct(var_13.target, "targetname").origin;
          break;
        }
      }
    }

    foreach(var_13 in self.cornerarray) {
      if(ispointinvolume(var_6, var_13))
        var_6 = level.player.origin;
    }

    var_21 = vectortoangles(scripts\engine\utility::flat_origin(var_5 - var_6));
    var_22 = level.player.origin + (0, 0, 6);
    var_16 = var_6 - level.player.origin;
    var_23 = length(var_16);
    var_16 = vectorNormalize(var_16);
    var_24 = scripts\engine\trace::ray_trace(var_22, var_22 + var_16 * (var_23 + 10) + (0, 0, 6), level.player, var_1);

    if(var_24["hittype"] == "hittype_none" && distance2d(var_5, var_6) >= 14) {
      self.origin = (var_5[0], var_5[1], self.placeheight);
      self.angles = vectortoangles(scripts\engine\utility::flat_origin(var_6 - self.origin));
      level.playermover.origin = level.player.origin;
      level.playermover.angles = level.player.angles;
      level.player playerlinktodelta(level.playermover, undefined, 1, 90, 90, 90, 90);
      level.player lerpviewangleclamp(0.4, 0.2, 0.1, 5, 5, 5, 5);
      level.playermover thread scripts\sp\maps\captive\captive_util.gsc::move_to_point_with_angles(0.5, var_6, var_21, 1, undefined, 0.2, 0.2);
      wait 0.25;
      level.player disableweapons();
      level.player playRumbleOnEntity("slide_start");
      wait 0.6;
      self show();
      wait 0.2;
      level.player unlink();
      level.player scripts\sp\utility::take_weapon("iw8_farahchair_sp");
      level.player enableweapons();
      level.player scripts\common\utility::allow_weapon_switch(1, "chair");
      level.player switchtoweapon("iw8_farahspoon_sp");
      restore_default_player_control_post_carry();
      self.collision solid();

      if(distance(level.chairplacedpos.origin, self.origin) < 10 || ispointinvolume(self.origin, self.placedclosevol)) {
        scripts\engine\utility::flag_set("chair_in_position");
        level notify("end_linger_vo");
      }

      var_0 = 0;
      scripts\sp\statemachine::goto_state("idle");
    } else
      scripts\engine\sp\utility::display_hint("cannot_place", 3);
  }
}

enable_chair_carry() {
  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 24), &"CAPTIVE/CURSOR_CARRY", 200, 180, 64, 1);
  self.showingcursor = 1;
}

disable_chair_carry() {
  scripts\sp\player\cursor_hint::remove_cursor_hint();
  self.showingcursor = 0;
}

disable_default_player_control_carry() {
  level.player setstance("stand");
  level.player setmovespeedscale(0.7);
  level.player scripts\common\utility::allow_crouch(0, "carrying");
  level.player scripts\common\utility::allow_prone(0, "carrying");
  level.player scripts\common\utility::allow_jump(0, "carrying");
  level.player scripts\common\utility::allow_mantle(0, "carrying");
  level.player scripts\common\utility::allow_sprint(0, "carrying");
  level.player scripts\common\utility::allow_melee(0, "chair");
}

restore_default_player_control_post_carry() {
  level.player scripts\common\utility::allow_crouch(1, "carrying");
  level.player scripts\common\utility::allow_prone(1, "carrying");
  level.player scripts\common\utility::allow_jump(1, "carrying");
  level.player scripts\common\utility::allow_mantle(1, "carrying");
  level.player scripts\common\utility::allow_sprint(1, "carrying");
  level.player scripts\common\utility::allow_melee(1, "chair");
  level.player.currentspeedscale = 1;
  level.player setmovespeedscale(level.player.currentspeedscale);
  level.player.iscarrying = 0;
}

chair_done_enter() {
  level.cellchair scripts\sp\player\cursor_hint::remove_cursor_hint();
}

chair_done_handler() {
  scripts\sp\statemachine::goto_state("done");
}

has_displayed_chair_fail() {
  if(scripts\engine\utility::flag("placed_chair"))
    return 1;

  return 0;
}