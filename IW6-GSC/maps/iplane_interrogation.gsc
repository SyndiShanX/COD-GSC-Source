/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\iplane_interrogation.gsc
*****************************************/

interroation_scene() {
  common_scripts\utility::flag_init("vargas_at_edge");
  common_scripts\utility::flag_init("iplane_start_intro_anim");
  common_scripts\utility::flag_init("iplane_player_holding_vargas");
  common_scripts\utility::flag_init("player_can_push_chair");
  common_scripts\utility::flag_init("iplane_drag_talk_done");
  common_scripts\utility::flag_init("iplane_start_drag_anim");
  common_scripts\utility::flag_init("finish_dialogue");
  thread ropes();
  thread clouds();
  maps\_hud_util::fade_out(0);
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  level.earthquake_min = 0.05;
  level.earthquake_max = 0.075;
  thread plane_quakes();
  thread open_the_ramp();
  thread connect_and_start_tarps();
  level.player shellshock("plane_sway", 9999);
  var_0 = getaiarray();
  common_scripts\utility::array_call(var_0, ::unlink);
  set_start_positions("start_plane_interrogation");
  var_1 = common_scripts\utility::get_target_ent("interrogation_main_node");
  var_2 = [level.elias, level.vargas, level.hesh, level.merrick, level.keegan];
  var_1 thread maps\_anim::anim_first_frame(var_2, "int_intro");
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = var_1.origin;
  var_3.angles = var_1.angles;
  level.elias set_unarmed_walk();
  level.hesh set_unarmed_walk();
  level.merrick set_unarmed_walk();
  level.elias thread get_pistol_plane_attack();
  level.elias thread do_elias_head_look();
  thread blackscreen_intro(var_3);
  level.player_rig = maps\_utility::spawn_anim_model("player_rig");
  common_scripts\utility::flag_wait("iplane_start_intro_anim");
  thread intro_logic(var_2, var_1, var_3);
  wait 27.5;
  thread drag_nag(0);
  level thread wait_for_player_use_rourke();
  level.vargas waittill("trigger");
  level.vargas makeunusable();
  level notify("stop_nag");
  thread player_hold_vargas(var_3);
  common_scripts\utility::flag_wait("player_can_push_chair");
  wait 1;
  level.elias maps\_utility::smart_dialogue("iplane_els_bringthatbastardover");
  thread drag_vargas_to_edge(var_3);
  common_scripts\utility::flag_wait("iplane_player_holding_vargas");
  common_scripts\utility::flag_set("iplane_start_drag_anim");
  wait 1.5;
  common_scripts\utility::flag_set("player_activated_ramps_open");
  wait 21;
  common_scripts\utility::flag_set("iplane_drag_talk_done");
  thread drag_nag(1);
  common_scripts\utility::flag_wait("vargas_at_edge");
  level notify("stop_nag");
  level notify("drop_vargas");
  level notify("stop_plane_quakes");
  thread stop_drag_sounds(var_3);
  stopallrumbles();
  wait 2;
  level.earthquake_min = 0.175;
  level.earthquake_max = 0.2;
  thread plane_quakes();
  wait 1;
  wait 0.5;
  level waittill("start_plane_attack");
  common_scripts\utility::flag_set("raise_enemy_plane");
  wait 1;
  level.chair_vargas_2 unlink();
}

wait_for_player_use_rourke() {
  level.vargas endon("trigger");
  var_0 = getent("player_use_vargas", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_2 = getent("v_use_trigger", "targetname");
  var_3 = getent("player_push_lookat", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      if(level.player maps\_utility::player_looking_at(var_3.origin)) {
        if(distance2d(level.player.origin, var_0.origin) <= 15) {
          level.vargas makeusable();
          level.vargas sethintstring(&"JUNGLE_GHOSTS_RORKE_PUSH");
          wait 0.05;
          continue;
        }
      }
    }

    wait 0.05;
    level.vargas makeunusable();
  }
}

get_pistol_plane_attack() {
  level waittill("equip_pistol");
  maps\_utility::forceuseweapon("p226", "primary");
  wait 2;
  level.player enableweapons();
  level.player giveweapon("p226");
  level.player switchtoweapon("p226");
  level.player setweaponammoclip("p226", 0);
  common_scripts\utility::flag_wait("start_explosion_breach");
  level.player takeweapon("p226");
  level.player disableweapons();
}

do_elias_head_look() {
  level endon("inter_done");

  for(;;) {
    level waittill("headlook_start");
    level.elias setlookatentity(level.vargas);
    level waittill("end_headlook");
    level.elias setlookatentity();
  }
}

intro_logic(var_0, var_1, var_2) {
  var_0 = [level.elias, level.hesh, level.merrick, level.keegan, level.chair_vargas_2];
  var_1 thread maps\_anim::anim_single(var_0, "int_intro");
  level.player_rig thread handle_player_punch_animation(var_1);
  var_2 maps\_anim::anim_single_solo(level.vargas, "int_intro");
  level.vargas linkto(var_2);

  foreach(var_4 in var_0) {
  var_4 thread create_node_and_idle(var_1, "int_intro_idle");
  }

  level.chair_vargas_2 linkto(var_2);
  var_2 thread maps\_anim::anim_loop_solo(level.vargas, "int_intro_idle");
  common_scripts\utility::flag_set("player_can_push_chair");
  common_scripts\utility::flag_wait("iplane_start_drag_anim");
  common_scripts\utility::flag_set("elias_activated_button");
  level.elias maps\_utility::delaythread(1.1, common_scripts\utility::play_sound_in_space, "scn_iplane_elias_press_button", (14993, -29610, -36942));
  level thread drag_animation(var_0, var_2, var_1);
  level waittill("drop_vargas");
  level.hesh unlink();
  level.player enableslowaim(0.3, 0.3);
  level.player playerlinktodelta(level.player_rig, "tag_origin", 1, 90, 10, 40, 10);
  var_6 = common_scripts\utility::get_target_ent("interrogation_slam_node");
  var_7 = common_scripts\utility::get_target_ent("vargas_drag_1");
  var_8 = common_scripts\utility::get_target_ent("int_player_drop_vargas");
  level.elias notify("stop_loop");
  var_2 notify("stop_loop");
  level.elias unlink();
  level.vargas unlink();
  var_1 thread maps\_anim::anim_single([level.vargas, level.elias, level.hesh, level.chair_vargas_2], "int_slam");
  wait 1.1;
  level.player lerpfov(55, 2);
  var_9 = 0.5;
  var_10 = 0.75;
  level.player_rig moveto(var_8.origin, var_10, 0.25, 0);
  level.player_rig rotateto(var_8.angles, var_10, 0.25, 0);
  earthquake(0.4, 1.75, level.player.origin, 500);
  level notify("inter_done");
}

handle_player_punch_animation(var_0) {
  level.player playerlinktoabsolute(self, "tag_player");
  wait 0.1;
  maps\_art::dof_enable_script(1, 2, 6, 20, 30, 5, 1.0);
  thread dot();
  var_0 maps\_anim::anim_single_solo(self, "intro_punch");
  level.player unlink();
  self hide();
}

dot() {
  wait 11;
  maps\_art::dof_enable_script(1, 2, 6, 60, 600, 5, 7.0);
  wait 20;
  maps\_art::dof_disable_script(0.1);
}

drag_animation(var_0, var_1, var_2) {
  level endon("drop_vargas");

  foreach(var_4 in var_0) {
  var_4.animnode notify("stop_loop");
  }

  var_1 notify("stop_loop");
  var_2 thread do_elias_int_anim();
  var_2 thread maps\_anim::anim_single_solo(level.hesh, "int_drag");
  var_1 maps\_anim::anim_single_solo(level.vargas, "int_drag");
  common_scripts\utility::flag_set("finish_dialogue");
  var_1 thread maps\_anim::anim_loop([level.vargas, level.hesh], "int_intro_idle");
}

do_elias_int_anim() {
  maps\_anim::anim_single_solo(level.elias, "int_drag");
  level.elias thread maps\_anim::anim_loop_solo(level.elias, "int_drag_idle");
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = level.elias.origin;
  var_0.angles = (0, 0, 0);
  level.elias linkto(var_0);
  var_0 rotateyaw(-110, 4);
}

create_node_and_idle(var_0, var_1) {
  if(self == level.merrick) {
    wait 1.5;
  }

  self.animnode = spawnStruct();
  self.animnode.origin = var_0.origin;
  self.animnode.angles = var_0.angles;
  self.animnode thread maps\_anim::anim_loop_solo(self, var_1);
}

drag_nag(var_0) {
  level endon("stop_nag");
  var_1 = "iplane_els_loganbringrorketo";
  level.chair_nags = ["iplane_els_loganbringrorketo", "iplane_els_gethimonthe", "iplane_els_pushhimoverhere", "iplane_els_bringhimbackhere"];
  level.nag_index = 0;
  wait 4;

  for(;;) {
    say_nag_after_delay(level.chair_nags[level.nag_index], 5, var_0);
    common_scripts\utility::waitframe();
  }
}

say_nag_after_delay(var_0, var_1, var_2) {
  level endon("stop_nag");
  wait(var_1);
  level.nag_index = (level.nag_index + 1) % level.chair_nags.size;
  level.elias maps\_utility::smart_dialogue(var_0);
}

merrick_move_to_edge() {
  var_0 = common_scripts\utility::get_target_ent("int_merrick_door_node");
  var_0 maps\_anim::anim_reach_solo(level.merrick, "merrick_wait_at_door");
  var_0 thread maps\_anim::anim_loop_solo(level.merrick, "merrick_wait_at_door");
}

drag_vargas_to_edge(var_0) {
  var_1 = common_scripts\utility::get_target_ent("vargas_drag_temp");
  level.vargas linkto(var_0);
  level.hesh linkto(var_0);
  level.player_rig linkto(var_0);
  var_2 = distance(var_0.origin, var_1.origin);
  var_3 = 15.0;
  var_4 = var_2 / var_3;
  common_scripts\utility::flag_init("vargas_drag");
  thread drag_hints(var_0, var_1, var_4);
  thread drag_on_ls(var_0, var_1, var_4);
  thread drag_sounds(var_0, var_1, var_4);
  maps\_utility::trigger_wait_targetname("plane_shake_inc1");
  level.earthquake_min = 0.1;
  level.earthquake_max = 0.175;
  maps\_utility::trigger_wait_targetname("plane_shake_inc2");
  level.earthquake_min = 0.15;
  level.earthquake_max = 0.2;
}

drag_sounds(var_0, var_1, var_2) {
  level endon("drop_vargas");

  for(;;) {
    common_scripts\utility::flag_wait("vargas_drag");
    var_0 playSound("chair_mvmt_start", "chair_mvmt_start_done");
    wait 0.2;
    var_0 playLoopSound("chair_mvmt_loop");
    level.player lerpfov(55, 2);
    common_scripts\utility::flag_waitopen("vargas_drag");
    thread stop_drag_sounds(var_0);
    var_0 playSound("chair_mvmt_end");
    level.player lerpfov(65, 2);
  }
}

stop_drag_sounds(var_0) {
  wait 0.4;
  var_0 stoploopsound("chair_mvmt_loop");
}

drag_hints(var_0, var_1, var_2) {
  level endon("drop_vargas");
  level.old_dist = distance(var_0.origin, var_1.origin);
  wait 4;

  for(;;) {
    if(level.old_dist - distance(var_0.origin, var_1.origin) < 6) {
      maps\_utility::display_hint("hint_drag");
    }

    wait 1;
  }
}

drag_on_ls(var_0, var_1, var_2) {
  level endon("drop_vargas");

  for(;;) {
    var_3 = level.player getnormalizedmovement();

    if(var_3[0] > 0.1) {
      level notify("player_pushing");
      var_4 = vectornormalize(var_1.origin - var_0.origin);
      var_5 = var_2 * 0.07 * (var_3[0] + 0.01);

      if(common_scripts\utility::flag("iplane_drag_talk_done")) {
        var_5 = var_5 * 2;
      }

      var_6 = length(var_1.origin - var_0.origin);

      if(var_5 > var_6) {
        var_5 = var_6;
      }

      var_0 moveto(var_0.origin + var_5 * var_4, 0.1);
      level.old_dist = distance(var_0.origin, var_1.origin) - var_5;
      level.player playrumbleonentity("tank_rumble");
      common_scripts\utility::flag_set("vargas_drag");
    } else {
      common_scripts\utility::flag_clear("vargas_drag");
      stopallrumbles();
      wait 0.5;
    }

    wait 0.05;

    if(distance(var_1.origin, var_0.origin) < 1) {
      common_scripts\utility::flag_clear("vargas_drag");
      common_scripts\utility::flag_wait("finish_dialogue");
      common_scripts\utility::flag_set("vargas_at_edge");
    }
  }
}

player_hold_vargas(var_0) {
  var_1 = common_scripts\utility::get_target_ent("int_player_hold_vargas");
  level.player_rig = maps\_utility::spawn_anim_model("player_rig", var_1.origin);
  level.player_rig.origin = var_1.origin;
  level.player_rig.angles = var_1.angles + (-60, 0, 0);
  level.player_rig hide();
  var_2 = common_scripts\utility::get_target_ent("interrogation_main_node");
  var_0 thread maps\_anim::anim_first_frame_solo(level.player_rig, "int_intro");
  level.player allowcrouch(0);
  level.player allowprone(0);
  maps\_art::dof_enable_script(0, 0, 10, 50, 7000, 6, 2);
  thread blend_player_position();
  common_scripts\utility::flag_set("iplane_player_holding_vargas");
  level.player thread maps\_utility::play_sound_on_entity("scn_iplane_plr_grab_chair");
  wait 0.8;
  var_0 maps\_anim::anim_single_solo(level.player_rig, "int_intro");
  wait 0.5;
  var_0 thread maps\_anim::anim_loop_solo(level.player_rig, "int_drag_idle");
  level waittill("drop_vargas");
  thread common_scripts\utility::play_sound_in_space("scn_iplane_elias_push_rorke_over", level.player.origin);
  var_2 thread maps\_anim::anim_single_solo(level.player_rig, "int_slam");
  wait 2.2;
  level.player playrumbleonentity("artillery_rumble");
}

blend_player_position() {
  level.player playerlinktoblend(level.player_rig, "tag_player", 1, 0.1, 0.4);
  level.player_rig maps\_utility::delaythread(0, ::show_rig);
  wait 1;
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 8, 0, 20, 5, 8);
}

show_rig() {
  wait 0.7;
  self show();
}

hesh_hold_vargas(var_0) {
  var_0 notify("stop_loop");
  level.hesh stopanimscripted();
  var_1 = common_scripts\utility::get_target_ent("int_hesh_push_node");
  var_1 maps\_anim::anim_reach_solo(level.hesh, "hesh_hold_vargas");
  var_1 thread maps\_anim::anim_first_frame_solo(level.hesh, "hesh_hold_vargas");
}

elias_move_to_button() {
  var_0 = common_scripts\utility::get_target_ent("int_elias_button_node");
  level.elias stopanimscripted();
  level.elias notify("stop_first_frame");
  level.elias.anim_node = var_0;
  var_0 maps\_anim::anim_reach_solo(level.elias, "elias_door_open");
  var_0 thread maps\_anim::anim_loop_solo(level.elias, "elias_door_open");
}

keegan_start_at_button() {
  var_0 = common_scripts\utility::get_target_ent("int_keegan_button_node");
  var_0 thread maps\_anim::anim_loop_solo(level.keegan, "elias_door_open");
}

set_unarmed_walk() {
  maps\_utility::set_generic_run_anim("int_unarmed_walk");
  maps\_utility::disable_arrivals();
  maps\_utility::disable_exits();
}

punching_sounds() {
  level.player thread maps\_utility::play_sound_on_entity("scn_iplane_intro_punches");
  level.player thread maps\_utility::play_sound_on_entity("iplane_rke_gettingbeatupinterrogated");
}

blackscreen_intro(var_0) {
  level.player freezecontrols(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  thread punching_sounds();
  thread punching_rumbles();
  level.player setclienttriggeraudiozone("jungle_ghosts_plane_int_closed_no_elm", 1.2);
  wait 0.75;
  wait 0.5;
  level.player lerpfov(10, 0.1);
  common_scripts\utility::flag_set("iplane_start_intro_anim");
  level waittill("punch_notetrack_fade_in");
  level.player lerpfov(65, 0.3);
  level.player freezecontrols(0);
  earthquake(0.7, 0.6, level.player.origin, 500);
  thread maps\_hud_util::fade_in(0.15, "black");
  wait 1;
  level.player setclienttriggeraudiozone("jungle_ghosts_plane_int_closed", 1.0);
  thread maps\iplane::rotate_camera_pre_crash_one();
}

punching_rumbles() {
  level.player playrumbleonentity("damage_heavy");
  wait 0.2;
  level.player playrumbleonentity("damage_heavy");
  wait 0.75;
  level.player playrumbleonentity("damage_heavy");
  wait 0.6;
  level.player playrumbleonentity("damage_heavy");
  wait 0.9;
  level.player playrumbleonentity("grenade_rumble");
  wait 0.6;
  level.player playrumbleonentity("damage_heavy");
  wait 0.9;
  level.player playrumbleonentity("damage_heavy");
  wait 0.8;
  level.player playrumbleonentity("grenade_rumble");
  wait 5.5;
  level.player playrumbleonentity("damage_heavy");
  wait 0.3;
  level.player playrumbleonentity("damage_heavy");
}

plane_quakes() {
  level endon("stop_plane_quakes");

  for(;;) {
    earthquake(randomfloatrange(level.earthquake_min, level.earthquake_max), 0.6, level.player.origin, 500);
    wait(randomfloatrange(0.05, 0.15));
  }
}

open_the_ramp() {
  common_scripts\utility::flag_wait("player_activated_ramps_open");
  var_0 = getent("ramp_collision", "script_noteworthy");
  var_0 linkto(level.bay_door_lower_model);
  var_1 = 3;
  var_2 = getEntArray("destroy_plane_debris02", "targetname");

  foreach(var_4 in var_2) {
  var_4 linkto(level.bay_door_lower);
  }

  thread maps\iplane::setup_plane_debris(var_2, var_1);
  var_1 = 6.1;
  var_2 = getEntArray("destroy_plane_debris", "targetname");
  thread maps\iplane::setup_plane_debris(var_2, var_1);
  level.bay_door_lower thread maps\_utility::play_sound_on_entity("scn_iplane_ramp_open_start");
  level.bay_door_lower thread lower_bottom_bay_door();
  level.bay_door_upper thread raise_top_bay_door();
  maps\_utility::delaythread(2.5, maps\_utility::set_vision_set, "iplane_sunblind", 4);
  maps\_utility::delaythread(4.9, maps\_utility::set_vision_set, "iplane", 4);
  level notify("stop_plane_quakes");
  earthquake(0.3, 3, level.player.origin, 500);
  var_6 = common_scripts\utility::spawn_tag_origin();
  var_6.origin = level.plane_core.origin - (0, 0, 80);
  var_6.angles = level.plane_core.angles + (0, 90, 0);
  var_7 = common_scripts\utility::spawn_tag_origin();
  var_7.origin = level.plane_core.origin - (0, 0, 40);
  var_7.angles = level.plane_core.angles + (90, 0, 0);
  playFXOnTag(common_scripts\utility::getfx("escape_dust_hijack1"), var_6, "tag_origin");
  common_scripts\utility::exploder("az_int_debr_back");
  wait 2;
  level.player maps\_utility::delaythread(1.6, maps\iplane::player_flap_sleeves_setup);
  var_8 = getEntArray("animated_ramp_tarp", "targetname");
  var_9 = getEntArray("fake_tarp_ramp", "targetname");

  for(var_10 = 0; var_10 < var_8.size; var_10++) {
    var_9[var_10] delete();
    var_8[var_10] show();
  }

  maps\_utility::stop_exploder("door_closed");
  level.earthquake_min = 0.075;
  level.earthquake_max = 0.15;
  thread plane_quakes();
  common_scripts\utility::flag_wait("start_explosion_breach");
  var_6 delete();
  var_7 delete();
}

connect_and_start_tarps() {
  var_0 = getEntArray("crates", "targetname");
  var_1 = getEntArray("crates02", "targetname");

  foreach(var_3 in var_0) {
  var_3 linkto(level.bay_door_lower);
  }

  foreach(var_6 in var_1) {
  var_6 linkto(level.plane_tail);
  }

  foreach(var_3 in var_0) {
    var_3.animname = "crates_tarp";
    var_3 maps\_anim::setanimtree();
    wait(randomfloatrange(1.3, 4));
    var_3 thread maps\_anim::anim_loop_solo(var_3, "tarps_anim");
    var_3 hide();
  }

  common_scripts\utility::flag_wait("player_activated_ramps_open");
  wait 2;

  foreach(var_3 in var_0) {
  var_3 show();
  }

  foreach(var_6 in var_1) {
    var_6.animname = "crates_tarp";
    var_6 maps\_anim::setanimtree();
    wait(randomfloatrange(0.3, 1));
    var_6 thread maps\_anim::anim_loop_solo(var_6, "tarps_light_anim");
  }
}

lower_bottom_bay_door(var_0) {
  self linkto(level.bay_door_lower_model);
  level.bay_door_lower_model.animname = "bottom_ramp";
  level.bay_door_lower_model maps\_anim::setanimtree();
  level.bay_door_lower_model unlink();

  if(isDefined(var_0)) {
    level.bay_door_lower_model rotatepitch(-30, 0.05);
  }
  else {
    level.bay_door_lower_model rotatepitch(-30, 10, 5, 1);
  }

  level.bay_door_lower_model waittill("rotatedone");
  level.bay_door_lower_model linkto(level.plane_core);
}

raise_top_bay_door(var_0) {
  self linkto(level.bay_door_upper_model);
  level.bay_door_upper_model.animname = "top_ramp";
  level.bay_door_upper_model maps\_anim::setanimtree();
  level.bay_door_upper_model unlink();

  if(isDefined(var_0)) {
    level.bay_door_upper_model rotatepitch(-25, 0.05);
  }
  else {
    level.bay_door_upper_model rotatepitch(-25, 10, 5, 1);
  }

  level.bay_door_upper_model waittill("rotatedone");
  level.bay_door_upper_model thread maps\_utility::play_sound_on_entity("scn_iplane_ramp_open_end");
  level.bay_door_upper_model linkto(level.plane_core);
}

set_start_positions(var_0) {
  var_1 = common_scripts\utility::getstructarray(var_0, "targetname");

  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "player":
        level.player setorigin(var_3.origin);
        level.player setplayerangles(var_3.angles);
        break;
      case "hesh":
        level.hesh forceteleport(var_3.origin, var_3.angles);
        level.hesh setgoalpos(var_3.origin);

        if(isDefined(var_3.animation)) {
          var_3 thread maps\_anim::anim_generic(level.hesh, var_3.animation);
        }

        if(isDefined(var_3.target)) {
          var_3 = var_3 common_scripts\utility::get_target_ent();
          level.hesh thread maps\_utility::follow_path_and_animate(var_3);
        }

        break;
      case "merrick":
        level.merrick forceteleport(var_3.origin, var_3.angles);
        level.merrick setgoalpos(var_3.origin);

        if(isDefined(var_3.animation)) {
          var_3 thread maps\_anim::anim_generic(level.merrick, var_3.animation);
        }

        if(isDefined(var_3.target)) {
          var_3 = var_3 common_scripts\utility::get_target_ent();
          level.merrick thread maps\_utility::follow_path_and_animate(var_3);
        }

        break;
      case "elias":
        level.elias forceteleport(var_3.origin, var_3.angles);
        level.elias setgoalpos(var_3.origin);

        if(isDefined(var_3.animation)) {
          var_3 thread maps\_anim::anim_generic(level.elias, var_3.animation);
        }

        if(isDefined(var_3.target)) {
          var_3 = var_3 common_scripts\utility::get_target_ent();
          level.elias thread maps\_utility::follow_path_and_animate(var_3);
        }

        break;
      case "vargas":
        level.vargas forceteleport(var_3.origin, var_3.angles);
        level.vargas setgoalpos(var_3.origin);

        if(isDefined(var_3.animation)) {
          var_3 thread maps\_anim::anim_generic(level.vargas, var_3.animation);
        }

        if(isDefined(var_3.target)) {
          var_3 = var_3 common_scripts\utility::get_target_ent();
          level.vargas thread maps\_utility::follow_path_and_animate(var_3);
        }

        break;
    }
  }
}

throw_player_to_window() {
  var_0 = common_scripts\utility::get_target_ent("int_player_window");
  common_scripts\utility::flag_set("ground_rotate_ref_off");
  level.player playerlinktoblend(level.player_rig, "tag_player");
  level.player_rig unlink();
  level.player_rig moveto(var_0.origin, 0.15);
  level.player_rig rotateto(var_0.angles, 0.15);
  level.player_rig waittill("movedone");
}

ropes() {
  common_scripts\utility::flag_init("fire_ropes");
  var_0 = getEntArray("ropes", "targetname");
  common_scripts\utility::array_thread(var_0, ::rope_think);
  var_0 = getEntArray("ropes_hidden", "targetname");
  common_scripts\utility::array_thread(var_0, ::hidden_rope_think);
}

hidden_rope_think() {
  self hide();
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  self.animname = "rope";
  maps\_anim::setanimtree();
  var_0 thread maps\_anim::anim_first_frame_solo(self, "rope_fire");
  common_scripts\utility::flag_wait("fire_ropes");
  self linkto(level.rope_main_org);
  var_0 thread maps\_anim::anim_single_solo(self, "rope_fire");
  common_scripts\utility::flag_wait("start_explosion_breach");
  wait 2.5;
  self show();
  self vibrate((1, 0, 0), 1, 1, 30);
}

rope_think() {
  self hide();
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  self.animname = "rope";
  maps\_anim::setanimtree();
  var_0 thread maps\_anim::anim_first_frame_solo(self, "rope_fire");
  common_scripts\utility::flag_wait("fire_ropes");
  self linkto(level.rope_main_org);
  maps\_utility::script_delay();
  self show();
  var_0 thread maps\_anim::anim_single_solo(self, "rope_fire");
  wait 4;
  common_scripts\utility::flag_wait("start_explosion_breach");
  wait 2.5;
  self delete();
}

clouds() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = level.plane_core.origin + (0, 0, 0);
  playFXOnTag(common_scripts\utility::getfx("clouds"), var_0, "tag_origin");
}