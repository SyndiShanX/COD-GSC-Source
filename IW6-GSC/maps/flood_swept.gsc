/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_swept.gsc
*****************************************************/

section_main() {
  maps\_utility::add_hint_string("swept_hint", &"FLOOD_SWEPT_MOVE", ::no_swept_hint);
  maps\_utility::add_hint_string("swept_hint_no_glyph", &"FLOOD_SWEPT_MOVE_NO_GLYPH", ::no_swept_hint);
  maps\_utility::add_hint_string("control_slide", &"FLOOD_SLIDE_HINT", ::no_swept_hint);
  maps\_utility::add_hint_string("control_slide_l", &"FLOOD_SLIDE_HINT_L", ::no_swept_hint);
  maps\_utility::add_hint_string("control_slide_gamepad", &"FLOOD_SLIDE_HINT_GAMEPAD", ::no_swept_hint);
  maps\_utility::add_hint_string("control_slide_gamepad_no_glyph", &"FLOOD_SLIDE_HINT_GAMEPAD_NO_GLYPH", ::no_swept_hint);
  maps\_utility::add_hint_string("control_slide_gamepad_l", &"FLOOD_SLIDE_HINT_GAMEPAD_L", ::no_swept_hint);
  maps\_utility::add_hint_string("control_slide_gamepad_l_no_glyph", &"FLOOD_SLIDE_HINT_GAMEPAD_L_NO_GLYPH", ::no_swept_hint);
}

section_precache() {
  precacherumble("light_3s");
  precacherumble("heavy_2s");
}

section_flag_inits() {
  common_scripts\utility::flag_init("left_pressed");
  common_scripts\utility::flag_init("right_pressed");
  common_scripts\utility::flag_init("swept_blending_allowed");
  common_scripts\utility::flag_init("player_hit_vehicle");
}

swept_start() {
  thread maps\flood_audio::swept_away_scene("start");
  maps\flood_util::player_move_to_checkpoint_start("swept_start");
  maps\flood_util::spawn_allies();
  maps\flood_util::setup_default_weapons(1);
  level.flood_mall_weapon_model = level.player maps\flood_util::create_world_model_from_ent_weapon("r5rgp+reflex_sp");
  var_0 = level.player getweaponslistprimaries();

  foreach(var_2 in var_0) {
  level.player takeweapon(var_2);
  }

  level.player disableoffhandweapons();
  level.cw_waterwipe_above = "waterline_above";
  level.cw_waterwipe_under = "waterline_under";
}

swept() {
  level.player playrumbleonentity("heavy_2s");
  level.player maps\_utility::ent_flag_set("player_in_swept");

  if(!isalive(level.allies[0])) {
    maps\flood_util::jkuprint("ally 0 created");
    level.allies[0] = maps\flood_util::spawn_ally("ally_0");
  }

  if(!isalive(level.allies[1])) {
    maps\flood_util::jkuprint("ally 1 created");
    level.allies[1] = maps\flood_util::spawn_ally("ally_1");
  }

  if(!isalive(level.allies[2])) {
    maps\flood_util::jkuprint("ally 2 created");
    level.allies[2] = maps\flood_util::spawn_ally("ally_2");
  }

  level.allies[0].cw_in_rising_water = 0;
  level.allies[1].cw_in_rising_water = 0;
  level.allies[2].cw_in_rising_water = 0;
  maps\flood_util::allies_move_to_checkpoint_start("swept", 1);
  thread start_swept_control();
  thread swept_water_toggle("swim", "show");
  thread swept_water_toggle("debri_bridge", "hide");
  thread maps\flood_anim::skybridge_scene_firstframe();
  thread maps\flood_fx::fx_swept_amb_fx();
  thread maps\flood_anim::sweptaway_spawn();
  common_scripts\utility::exploder("swept_under_fx");
  thread maps\flood_fx::set_enter_swept_vf();
  var_0 = common_scripts\utility::getstruct("vignette_sweptaway_end_b", "script_noteworthy");
  level.sweptaway_antenna_01 = maps\_utility::spawn_anim_model("sweptaway_antenna_01");
  level.sweptaway_antenna_02 = maps\_utility::spawn_anim_model("sweptaway_antenna_02");
  var_1 = [];
  var_1["sweptaway_antenna_01"] = level.sweptaway_antenna_01;
  var_1["sweptaway_antenna_02"] = level.sweptaway_antenna_02;
  var_0 maps\_anim::anim_first_frame(var_1, "sweptaway_end_b");
  level.player disableoffhandweapons();
  level.player allowsprint(0);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowmelee(0);
  level.player disableweapons();
  level.player hideviewmodel();
  setsaveddvar("ammoCounterHide", 1);
  common_scripts\utility::noself_delaycall(0.05, ::setsaveddvar, "r_znear", 0.7);
  thread maps\flood_fx::fx_swept_dunk_bubbles();
  maps\_utility::stop_exploder("mr_sunflare");
  common_scripts\utility::exploder("swept_sunflare");
  maps\_utility::stop_exploder("huge_plume");
  level waittill("swept_success");
  level.flood_mall_weapon_model delete();
  level.player maps\_utility::ent_flag_clear("player_in_swept");
  setsaveddvar("r_znear", level.cw_znear_default);
}

swept_hint() {
  if(isDefined(level.ps3) && level.ps3 || isDefined(level.ps4) && level.ps4) {
    level.player maps\_utility::display_hint_timeout("swept_hint_no_glyph", 3);
  }
  else {
    level.player maps\_utility::display_hint_timeout("swept_hint", 3);
  }
}

start_swept_control() {
  var_0 = common_scripts\utility::getstruct("vignette_sweptaway", "script_noteworthy");
  var_1 = maps\_utility::spawn_anim_model("swept_path_rig", var_0.origin);
  var_0 maps\_anim::anim_first_frame_solo(var_1, "flood_sweptaway_player_path");
  var_2 = maps\_utility::spawn_anim_model("player_rig", var_0.origin);
  var_2.angles = var_1 gettagangles("tag_player");
  var_3 = maps\_utility::spawn_anim_model("swept_start_debris", var_0.origin);
  level.swept_path_rig = var_1;
  level.hands_rig = var_2;
  var_2 linkto(var_1, "tag_player", (0, 0, 0), (0, 0, 0));
  level.player playerlinktodelta(var_2, "tag_player", 1, 25, 25, 15, 15);
  level.player springcamenabled(1, 3.2, 1.6);
  var_0 thread maps\_anim::anim_single_solo(var_3, "flood_sweptaway_player_start_underwater");
  var_0 thread swept_path_anim(var_1, var_2);
  level.swept_hands_anim = level.hands_rig maps\_utility::getanim("flood_sweptaway");
  var_2 setanim(level.swept_hands_anim, 1, 0);
  var_1 hide();
  thread watch_input(var_1, var_2);
  thread player_play_anims(var_2);
}

swept_path_anim(var_0, var_1) {
  level endon("swept_success");
  var_2 = common_scripts\utility::getstruct("vignette_sweptaway_end_b", "script_noteworthy");
  maps\_anim::anim_single_solo(var_0, "flood_sweptaway_player_path");
  thread swept_end_player(var_2);
  thread swept_end(var_2);
}

swept_end(var_0) {
  level notify("swept_end_vign_start");
  var_1 = maps\_vignette_util::vignette_vehicle_spawn("sweptaway_man7t", "sweptaway_end_man7t");
  var_2 = maps\_vignette_util::vignette_actor_spawn("swept_end_opfor_floater", "sweptaway_end_opfor_floater");
  var_3 = maps\_vignette_util::vignette_actor_spawn("swept_end_opfor_pinned", "sweptaway_end_opfor_pinned");
  level.allies[1].alertlevel = "noncombat";
  level.allies[1] maps\_utility::gun_remove();
  var_4 = maps\_utility::spawn_anim_model("sweptaway_end_chair");
  var_5 = maps\_utility::spawn_anim_model("sweptaway_end_ibeam");
  var_6 = maps\_utility::spawn_anim_model("sweptaway_end_pinned");

  if(!isDefined(level.skybridge_model)) {
    level.skybridge_model = maps\_utility::spawn_anim_model("sweptaway_skybridge_01");
  }

  var_7 = [];
  var_7["sweptaway_antenna_01"] = level.sweptaway_antenna_01;
  var_7["sweptaway_antenna_02"] = level.sweptaway_antenna_02;
  var_7["sweptaway_end_man7t"] = var_1;
  var_7["vignette_sweptaway_end_b_ally1"] = level.allies[0];
  var_7["sweptaway_end_ibeam"] = var_5;
  var_7["sweptaway_end_pinned"] = var_6;
  var_7["sweptaway_end_opfor_floater"] = var_2;
  var_7["sweptaway_end_opfor_pinned"] = var_3;
  var_7["sweptaway_end_chair"] = var_4;
  thread maps\flood_audio::audio_flood_end_logic();
  level.allies[0] maps\_utility::delaythread(0.75, ::swept_end_ally_vo);
  var_0 maps\_anim::anim_single(var_7, "sweptaway_end_b");
  level.allies[0] thread maps\flood_roof_stealth::ally0_main();
  var_1 maps\_vignette_util::vignette_vehicle_delete();
  var_2 maps\_vignette_util::vignette_actor_delete();
  var_3 maps\_vignette_util::vignette_actor_delete();
}

swept_end_player(var_0) {
  level.player freezecontrols(1);
  level.cw_no_waterwipe = 1;
  var_1 = [];
  var_1["player_rig"] = level.hands_rig;
  var_0 maps\_anim::anim_single(var_1, "sweptaway_end_b");
  level notify("swept_success");
  level notify("swept_player_done");
  level.player unlink();
  level.hands_rig delete();
  level.player freezecontrols(0);
  level.player allowsprint(1);
  level.player allowcrouch(1);
  level.player allowmelee(1);
  level.player enableweapons();
  level.player showviewmodel();
  level.cw_no_waterwipe = 0;
  maps\flood_util::jkuprint(distance2d(level.allies[1].origin, level.player.origin));
  level.player allowsprint(0);
  level.player common_scripts\utility::delaycall(7.5, ::allowsprint, 1);
  level.player maps\_utility::blend_movespeedscale(0.05);
  level.player thread maps\_utility::blend_movespeedscale_default(7.5);
}

swept_end_ally_vo() {
  self endon("death");
  level endon("stealth_attack_player");
  wait 3.35;
  wait 6.3;
  thread maps\_utility::dialogue_queue("flood_vrg_grabmyhandwalker");
  wait 1.5;
  thread maps\_utility::dialogue_queue("flood_vrg_eliasigotcha");
}

swept_end_player_test(var_0) {
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  var_2 = [];
  var_2["player_rig"] = var_1;
  var_0 maps\_anim::anim_first_frame(var_2, "sweptaway_end_b");
}

watch_input(var_0, var_1) {
  level.player endon("death");
  level endon("swept_success");
  level endon("swept_end_vign_start");
  level endon("swept_take_control");
  level.swept_allow_movement = 0;
  level.swept_path_offset = 0;
  level.swept_allowed_slide = 60;
  level.swept_movement_step = 0;
  thread adjust_movement_step_up(6, 5);

  for(;;) {
    var_2 = level.player getnormalizedmovement();

    if(var_2[1] >= 0.15) {
      common_scripts\utility::flag_clear("left_pressed");
      common_scripts\utility::flag_set("right_pressed");

      if(level.swept_allow_movement) {
        var_3 = anglestoright(var_0.angles);
        var_4 = var_1.origin + level.swept_movement_step * var_3;

        if(distance2d(var_4, var_0.origin) <= level.swept_allowed_slide) {
          var_1.origin = var_4;
          var_1 linkto(var_0, "tag_player");
        }
      }
    } else if(var_2[1] <= -0.15) {
      common_scripts\utility::flag_clear("right_pressed");
      common_scripts\utility::flag_set("left_pressed");

      if(level.swept_allow_movement) {
        var_3 = anglestoright(var_0.angles);
        var_4 = var_1.origin + level.swept_movement_step * -1 * var_3;

        if(distance2d(var_4, var_0.origin) <= level.swept_allowed_slide) {
          var_1.origin = var_4;
          var_1 linkto(var_0, "tag_player");
        }
      }
    } else {
      common_scripts\utility::flag_clear("left_pressed");
      common_scripts\utility::flag_clear("right_pressed");
    }

    common_scripts\utility::waitframe();
  }
}

adjust_movement_step_up(var_0, var_1) {
  level.player endon("death");
  level endon("swept_success");
  var_2 = var_1 * 20;
  var_3 = 0;
  var_4 = var_0 / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    level.swept_movement_step = var_3;
    var_3 = var_3 + var_4;
    common_scripts\utility::waitframe();
  }

  maps\flood_util::jkuprint("full cs");
  common_scripts\utility::flag_set("swept_blending_allowed");
}

start_blend_to_endpos() {
  level.player endon("death");
  level endon("swept_success");
  var_0 = 1;
  wait(getanimlength(level.swept_path_rig maps\_utility::getanim("flood_sweptaway_player_path")) - var_0);
  maps\flood_util::jkuprint("no c");
  level notify("swept_take_control");
  level.swept_allow_movement = 1;
  var_1 = distance2d(level.swept_path_rig.origin, level.hands_rig.origin);
  var_2 = var_1 / (var_0 * 20 - 2);

  while(isDefined(level.swept_path_rig) && isDefined(level.hands_rig) && distance2d(level.swept_path_rig.origin, level.hands_rig.origin) > 4) {
    var_3 = anglestoright(level.swept_path_rig.angles);

    if(level.swept_path_rig.origin[0] - level.hands_rig.origin[0] > 0) {
      var_4 = level.hands_rig.origin + var_2 * -1 * var_3;
    }
    else {
      var_4 = level.hands_rig.origin + var_2 * var_3;
    }

    level.hands_rig.origin = var_4;
    level.hands_rig linkto(level.swept_path_rig, "tag_player");
    common_scripts\utility::waitframe();
  }
}

player_play_anims(var_0) {
  level.player endon("death");
  level endon("swept_success");
  level endon("swept_end_vign_start");
  level endon("swept_take_control");
  var_1 = 0.3;
  var_2 = 0.5;

  for(;;) {
    if(common_scripts\utility::flag("left_pressed") && common_scripts\utility::flag("swept_blending_allowed")) {
      var_0 setanim(level.hands_rig maps\_utility::getanim("flood_sweptaway_L"), 1, var_1);
      var_0 setanim(level.swept_hands_anim, 0.01, var_1);
      common_scripts\utility::flag_waitopen("left_pressed");
      var_0 setanim(level.swept_hands_anim, 1, var_2);
      var_0 setanim(level.hands_rig maps\_utility::getanim("flood_sweptaway_L"), 0, var_2);
    } else if(common_scripts\utility::flag("right_pressed") && common_scripts\utility::flag("swept_blending_allowed")) {
      var_0 setanim(level.hands_rig maps\_utility::getanim("flood_sweptaway_R"), 1, var_1);
      var_0 setanim(level.swept_hands_anim, 0.01, var_1);
      common_scripts\utility::flag_waitopen("right_pressed");
      var_0 setanim(level.swept_hands_anim, 1, var_2);
      var_0 setanim(level.hands_rig maps\_utility::getanim("flood_sweptaway_R"), 0, var_2);
    } else
      common_scripts\utility::flag_wait_any("left_pressed", "right_pressed");

    common_scripts\utility::waitframe();
  }
}

#using_animtree("player");

start_swept_control_old() {
  var_0 = getent("swept_vehicle", "targetname");
  var_0 = maps\_vehicle::vehicle_spawn(var_0);
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1 linkto(var_0, "", (0, 0, 0), (0, 0, 0));
  var_2 = common_scripts\utility::getstruct("vignette_sweptaway", "script_noteworthy");
  var_3 = maps\_utility::spawn_anim_model("player_rig", var_2.origin);
  var_3.angles = var_2.angles;
  var_3 setanim( % flood_sweptaway_player_path, 1, 0);
  var_4 = 35;
  var_5 = 15;
  level.player playerlinktodelta(var_3, "tag_player", 1, var_4, var_4, var_5, var_5);
  wait 0.7;
  level waittill("swept_success");
  level.player unlink();
  var_3 delete();
}

watch_input_old(var_0, var_1, var_2) {
  level.player endon("death");
  level endon("swept_success");
  var_3 = 121;

  for(;;) {
    var_4 = level.player getnormalizedmovement();

    if(var_4[1] >= 0.15) {
      common_scripts\utility::flag_clear("left_pressed");
      common_scripts\utility::flag_set("right_pressed");

      if(distance2d(level.player.origin, var_1.origin) <= var_3) {
        var_5 = anglestoright(var_1.angles);
        var_6 = var_0.origin + 5 * var_5;

        if(distance2d(var_6, var_1.origin) <= var_3) {
          var_0.origin = var_6;
          var_0 linkto(var_1);
        }
      }
    } else if(var_4[1] <= -0.15) {
      common_scripts\utility::flag_clear("right_pressed");
      common_scripts\utility::flag_set("left_pressed");

      if(distance2d(level.player.origin, var_1.origin) <= var_3) {
        var_5 = anglestoright(var_1.angles);
        var_6 = var_0.origin + -5 * var_5;

        if(distance2d(var_6, var_1.origin) <= var_3) {
          var_0.origin = var_6;
          var_0 linkto(var_1);
        }
      }
    } else {
      common_scripts\utility::flag_clear("left_pressed");
      common_scripts\utility::flag_clear("right_pressed");
    }

    wait 0.05;
  }
}

trigger_damage_car() {
  level endon("swept_success");
  level endon("swept_fail");
  self waittill("trigger");
  level.player dodamage(50, level.player.origin);
}

swept_water_toggle(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "swim":
      var_2 = getEntArray("swept_water_swim", "targetname");
      break;
    case "ending_water":
      var_2 = getEntArray("ending_water", "targetname");
      break;
    case "debri_bridge":
      var_2 = getEntArray("debri_bridge_water", "targetname");
      break;
  }

  switch (var_1) {
    case "hide":
      foreach(var_0 in var_2) {
        var_0 hide();
        var_0 notsolid();
      }

      break;
    case "show":
      foreach(var_0 in var_2) {
        var_0 show();
        var_0 solid();
      }

      break;
  }
}

watch_waterlevel() {
  level endon("swept_player_done");
  level endon("swept_fail");
  thread maps\flood_coverwater::setup_player_view_water_fx_source();
  level.player thread player_surface_blur_think("swept_success");
  level thread waterlevel_hack();
  var_0 = "none";

  for(;;) {
    var_1 = level.player getEye();
    var_2 = bulletTrace(var_1, var_1 + (0, 0, 240), 0);

    if(var_2["surfacetype"] == "water" && var_0 != "water") {
      swept_underwater();
    }
    else if(var_2["surfacetype"] == "none" && var_0 != "none") {
      swept_abovewater();
    }
    else if(var_2["surfacetype"] == "water" && var_0 == "water") {} else if(var_2["surfacetype"] == "none" && var_0 == "none") {}

    var_0 = var_2["surfacetype"];
    common_scripts\utility::waitframe();
  }
}

waterlevel_hack() {
  level endon("swept_player_done");
  level endon("swept_fail");
  wait 31.85;
  swept_abovewater();
}

swept_underwater() {
  level endon("swept_success");
  level endon("swept_fail");
  level.cw_fog_under = "flood_underwater_murky";
  common_scripts\utility::flag_clear("cw_player_abovewater");
  common_scripts\utility::flag_set("cw_player_underwater");
  thread maps\flood_fx::dof_swept_away();
  thread maps\flood_fx::fx_create_bokehdots_source();
  killfxontag(common_scripts\utility::getfx("bokehdots_64"), level.flood_source_bokehdots, "tag_origin");
  common_scripts\utility::waitframe();
  killfxontag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
  killfxontag(common_scripts\utility::getfx("scrnfx_water_splash_low"), level.cw_player_view_fx_source, "tag_origin");
  common_scripts\utility::waitframe();

  if(isDefined(level.hands_rig)) {
    playFXOnTag(common_scripts\utility::getfx("flood_hand_bubbles"), level.hands_rig, "j_wrist_ri");
    playFXOnTag(common_scripts\utility::getfx("flood_hand_bubbles"), level.hands_rig, "j_wrist_le");
  }
}

swept_abovewater() {
  level endon("swept_success");
  level endon("swept_fail");
  common_scripts\utility::flag_clear("cw_player_underwater");
  common_scripts\utility::flag_set("cw_player_abovewater");
  level.player maps\_utility::vision_set_changes(level.cw_vision_above, 0);
  level.player maps\_utility::fog_set_changes(level.cw_fog_above, 0);
  maps\_art::dof_disable_script(0.0);
  killfxontag(common_scripts\utility::getfx("flood_hand_bubbles"), level.hands_rig, "j_wrist_ri");
  killfxontag(common_scripts\utility::getfx("flood_hand_bubbles"), level.hands_rig, "j_wrist_le");
  level.player setwatersheeting(1, 1);
  thread maps\flood_fx::fx_bokehdots_close();
  common_scripts\utility::waitframe();
  thread maps\flood_fx::fx_turn_on_bokehdots_64_player();
  playFXOnTag(common_scripts\utility::getfx("scrnfx_water_splash_low"), level.cw_player_view_fx_source, "tag_origin");
}

player_surface_blur_think(var_0) {
  level.player endon("death");
  level endon(var_0);
  var_1 = 1;

  for(;;) {
    var_2 = level.player getEye();
    var_3 = 1.5;
    var_4 = 25;
    var_5 = bulletTrace(var_2 + (0, 0, var_3), var_2 + (0, 0, var_3 * -1), 0, self);

    if(var_5["surfacetype"] == "water") {
      var_6 = distance(var_5["position"], var_2) * (var_4 / var_3);
      setblur(var_4 - var_6, 0.05);
      var_1 = 0;
    } else if(!var_1) {
      setblur(0, 0.5);
      var_1 = 1;
    }

    common_scripts\utility::waitframe();
  }
}

no_swept_hint() {
  if(!isalive(level.player)) {
    return 1;
  }

  return 0;
}

building_slide_control_hint() {
  var_0 = getsticksconfig();
  iprintln(var_0);

  if(level.player common_scripts\utility::is_player_gamepad_enabled()) {
    if(isDefined(level.ps3) && level.ps3) {
      if(var_0 == "thumbstick_southpaw" || var_0 == "thumbstick_legacy") {
        maps\_utility::display_hint_timeout("control_slide_gamepad_l_no_glyph", 3);
      }
      else {
        maps\_utility::display_hint_timeout("control_slide_gamepad_no_glyph", 3);
      }
    } else if(var_0 == "thumbstick_southpaw" || var_0 == "thumbstick_legacy")
      maps\_utility::display_hint_timeout("control_slide_gamepad_l", 3);
    else {
      maps\_utility::display_hint_timeout("control_slide_gamepad", 3);
    }
  } else if(var_0 == "thumbstick_southpaw" || var_0 == "thumbstick_legacy")
    maps\_utility::display_hint_timeout("control_slide_l", 3);
  else {
    maps\_utility::display_hint_timeout("control_slide", 3);
  }
}

truck_rumble(var_0) {
  earthquake(0.5, 1, level.player.origin, 1600);
  level.player playrumbleonentity("heavy_2s");
}

antenna_rumble(var_0) {
  earthquake(0.15, 0.5, level.player.origin, 1600);
  level.player playrumbleonentity("light_3s");
}

play_rumble_pole_hit(var_0) {
  maps\flood_util::jkuprint("playing play_rumble_pole_hit");
  playrumbleonposition("light_1s", var_0.origin + (0, 0, 850));
}