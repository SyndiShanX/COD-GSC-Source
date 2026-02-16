/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\skyway_endbeach.gsc
*****************************************************/

section_flag_inits() {
  common_scripts\utility::flag_init("flag_endbeach_start");
  common_scripts\utility::flag_init("hint_drag");
  common_scripts\utility::flag_init("flag_logos");
}

section_precache() {
  maps\_utility::add_hint_string("hint_drag_left", &"SKYWAY_HINT_DRAG_LEFT", ::hint_drag);
  maps\_utility::add_hint_string("hint_drag_left_pc", &"SKYWAY_HINT_DRAG_LEFT_PC", ::hint_drag);
  maps\_utility::add_hint_string("hint_drag_right", &"SKYWAY_HINT_DRAG_RIGHT", ::hint_drag);
  maps\_utility::add_hint_string("hint_drag_right_pc", &"SKYWAY_HINT_DRAG_RIGHT_PC", ::hint_drag);
  maps\_utility::add_hint_string("hint_drag_leftright", &"SKYWAY_HINT_DRAG_LEFTRIGHT", ::hint_drag);
  maps\_utility::add_hint_string("hint_drag_leftright_pc", &"SKYWAY_HINT_DRAG_LEFTRIGHT_PC", ::hint_drag);
  precacheshellshock("skyway_beach_pain");
  precacheshader("logo_ghosts");
}

hint_drag() {
  return !common_scripts\utility::flag("hint_drag");
}

section_post_inits() {
  level._endbeach = spawnStruct();
  level._endbeach.ally_start = common_scripts\utility::getstruct("ally1_start_end_beach", "targetname");
  level._endbeach.player_start = common_scripts\utility::getstruct("player_start_end_beach", "targetname");

  if(isDefined(level._endbeach.player_start)) {
    var_0 = ["surface", "rock"];
    var_1 = ["drag1_L", "drag1_R", "drag2_L", "drag2_R"];
    var_2 = ["idle1_1", "idle1_2", "idle2_1", "idle2_2", "idle5_1"];
    var_3 = [];
    var_3 = common_scripts\utility::array_combine(var_3, var_0);
    var_3 = common_scripts\utility::array_combine(var_3, var_1);
    var_3 = common_scripts\utility::array_combine(var_3, var_2);
    level._endbeach.blend_time = 0.2;
    level._endbeach.early_prompt = 1;
    init_anims_player(var_3);
    init_anims_human(var_3);
    level._endbeach.idle_anims = var_2;
    level._endbeach.drag_anims = var_1;
    level._endbeach.all_scenes = var_3;
    level._endbeach.boats = [];
    var_4 = ["end_dest1", "end_dest2", "end_dest3", "end_dest4", "end_dest5", "end_dest6", "end_dest7", "end_dest8", "end_dest9", "end_dest10", "end_dest11", "end_dest12", "end_cruiser1", "end_cruiser2", "end_cruiser3", "end_dvora1", "end_dvora2", "end_dvora3", "end_dvora4"];

    foreach(var_6 in var_4) {
      var_7 = getent(var_6, "targetname");
      var_7.animname = var_6;
      var_7 maps\_anim::setanimtree();
      level._endbeach.boats = common_scripts\utility::array_add(level._endbeach.boats, var_7);
    }

    common_scripts\utility::array_call(level._endbeach.boats, ::hide);
  }
}

start() {
  maps\skyway_util::skyway_hide_hud();
  iprintln(level.start_point);
  maps\_utility::vision_set_fog_changes("skyway_beach", 0.1);
  maps\_art::sunflare_changes("beach", 0);
  common_scripts\utility::exploder("beach_amb");
  var_0 = getEntArray("bridge_end_1", "script_noteworthy");
  var_1 = getEntArray("bridge_end_2", "script_noteworthy");

  foreach(var_3 in var_0)
  var_3 hide();

  foreach(var_3 in var_1)
  var_3 hide();

  if(level.start_point == "end_beach_final") {
    maps\_utility::vision_set_fog_changes("skyway_beach", 0.1);
    maps\_art::sunflare_changes("beach", 0.1);
  }

  maps\_utility::delaythread(0.05, maps\_utility::remove_extra_autosave_check, "fallen_cant_get_up");
}

main() {
  common_scripts\utility::array_call(level._endbeach.boats, ::show);
  var_0 = 0.2;
  var_1 = 0.15;
  var_2 = 2.5;

  if(level.start_point != "end_beach_final") {
    if(!issubstr(level.start_point, "end_beach")) {
      maps\_hud_util::fade_out(var_0, "white");
      wait(var_0);
    } else
      maps\_hud_util::fade_out(0, "white");
  }

  common_scripts\utility::exploder("beach_amb");
  common_scripts\utility::exploder("sw_end_aa");
  thread maps\skyway_fx::fx_perif_fleet_mainguns();
  thread maps\skyway_audio::perif_fleet_sfx();
  thread beach_dof_changes();
  var_3 = [];

  for(var_4 = 0; var_4 < 3; var_4++)
    var_3 = common_scripts\utility::array_add(var_3, getent("model_rog_hit_ref_end" + (var_4 + 1), "targetname"));

  var_5 = [];

  for(var_4 = 0; var_4 < 10; var_4++)
    var_5 = common_scripts\utility::array_add(var_5, getent("model_rog_hit_ref_end_far" + (var_4 + 1), "targetname"));

  thread dialogue_intro();
  thread music_second_swell();
  thread hero_rogs();
  thread fade_logo_run_credits(var_5);
  thread missile_launch();
  thread end_birds();
  thread view_fx_init();
  level.player allowswim(0);
  level.player disableslowaim();
  level.player hideviewmodel();
  level notify("notify_swap_bridge_geo");
  level.player enabledeathshield(1);
  maps\skyway_util::setup_player_for_animated_sequence(1, 0, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("actionSlotsHide", 1);
  setsaveddvar("hud_showStance", 0);
  setsaveddvar("compass", 0);
  setsaveddvar("g_friendlyNameDist", 0);
  var_6 = level._boss;
  var_7 = level._allies[0];
  var_8 = level.player_rig;
  var_9 = maps\skyway_hangar_intro::build_human_model("player_body", "head_hesh_end_head_x");
  var_10 = [var_7, var_8, var_9];
  var_11 = [var_7, var_8, var_9, var_6];
  var_7 show();
  var_12 = common_scripts\utility::getstruct("beach_drag", "script_noteworthy");
  thread maps\skyway_audio::sfx_beach_transition();

  if(level.start_point != "end_beach_final") {
    thread maps\skyway_audio::sfx_player_surface();
    thread maps\skyway_audio::skyway_beach_music();
    maps\_utility::vision_set_fog_changes("skyway_beach", 0.1);
    maps\_art::sunflare_changes("beach", 0.1);
    maps\_art::dof_enable_script(0, 2.75, 3, 3.41, 103.67, 1.4, 0.1);
    wait(var_1);
    var_12 maps\_anim::anim_first_frame(var_10, "surface");
    wait 0.05;
    level.player playSound("scn_sw_beach_foley_01");
    thread maps\skyway_audio::sw_beach_breathing_vo();
    thread maps\skyway_audio::sfx_beach_drags();
    var_12 thread maps\_anim::anim_single(var_10, "surface");
    level.player setwatersheeting(1, 3);
    thread maps\_hud_util::fade_in(var_2, "white");
    common_scripts\utility::flag_set("flag_endbeach_start");
    level.dopickyautosavechecks = 0;
    var_12 player_drags_ally(var_10);
  }

  level.player playersetgroundreferenceent(undefined);
  maps\_art::dof_disable_script(0.1);

  if(maps\_utility::is_gen4())
    setsaveddvar("sm_sunSampleSizeNear", 0.1328);

  if(level.start_point != "end_beach_final")
    thread maps\skyway_audio::skyway_beach_music_transition();

  var_12 thread rock_idle([var_8, var_9]);
  var_12 thread rock_radio(var_7);
  var_12 thread event_sinking_boats();
  var_12 thread maps\_anim::anim_first_frame_solo(var_6, "beach_pt2");
  var_6 hide();

  if(level.start_point != "end_beach_final") {
    level waittill("notify_start_rogs");
    thread maps\skyway_fx::fx_endbeach_sunflare();
    thread maps\skyway_fx::fx_endbeach_birds();
    thread maps\skyway_fx::fx_sea_spray();
    rog_hits(var_3);
    maps\_utility::delaythread(2, ::rog_hits_far, var_5, 7);
    level waittill("notify_fade_in_stinger");
  } else
    wait 0.05;

  is_player_on_controller(var_12);
  var_12 maps\_anim::anim_first_frame_solo(var_6, "beach_pt2");
  var_6 show();
  var_13 = var_8 gettagorigin("tag_view");
  thread maps\skyway_audio::sfx_beach_rorke_approach(var_6);
  maps\skyway_util::waittill_look_yaw(var_13, var_12.origin, -115);
  level notify("notify_rorke_attack");
  level notify("notify_stop_far_rogs");
  level.player setclienttriggeraudiozone("skyway_beach_rorke_again", 2.0);
  maps\_utility::delaythread(0.0, maps\_utility::music_play, "mus_skyway_rorke_again");
  level.player playSound("elm_skyway_gulls_mean");
  level.player lerpviewangleclamp(0.7, 0, 0, 0, 0, 0, 0);
  thread dialogue_final();
  thread fx_rorke_bleedout(var_6);
  thread event_boss_rog_hit(var_3[0], var_6 maps\_utility::getanim("beach_pt3"));
  thread event_rogs_finale(var_5, var_6 maps\_utility::getanim("beach_pt3"));
  thread event_player_grabs_knife(var_11);
  thread event_player_arm_break();
  thread event_player_gets_kicked();
  thread event_player_gets_punched();
  var_12 notify("stop_loop");
  level.player playSound("scn_sw_end_fight");
  thread maps\skyway_audio::rorke_end_grunt_sfx();
  var_12 maps\_anim::anim_single(var_11, "beach_pt2");
  level.player lerpviewangleclamp(2.0, 0, 0, 45, 20, 45, 15);
  level notify("delete_knife");
  var_12 thread maps\_anim::anim_single(var_11, "beach_pt3");
  var_14 = 0.05;
  var_0 = 0.05;
  wait(getanimlength(var_8 maps\_utility::getanim("beach_pt3")) - (var_14 + var_0));
  wait(var_14);
  maps\_hud_util::fade_out(var_0, "black");
  thread maps\skyway_audio::skyway_beach_fade_to_final_credits();
  wait 4.5;
  maps\_utility::nextmission();
  end_credits();
  pit_of_despair(var_8);
  missionsuccess(level.script);
}

view_fx_init() {
  wait 10;
  level.player_fx_org = maps\_utility::spawn_anim_model("sw_swim_view_fx");
  level.player_fx_org linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 0);
  level.player_fx_org setanim(level.scr_anim["sw_swim_view_fx"]["swim_fx_base"]);
  level.player_fx_org setanim(level.scr_anim["sw_swim_view_fx"]["swim_fx_add"]);
  level.player_fx_org setanimlimited(level.scr_anim["sw_swim_view_fx"]["swim_drown_overlay"], 1.0, 0.0);
}

is_player_on_controller(var_0) {
  wait 0.2;
  var_1 = maps\_utility::get_dot(level.player.origin, level.player.angles, var_0.origin);
  var_2 = 0.05;

  for(;;) {
    var_3 = maps\_utility::get_dot(level.player.origin, level.player.angles, var_0.origin);

    if(abs(var_1 - var_3) > var_2) {
      return;
    }
    wait(level.timestep);
  }
}

rorke_look_ticker(var_0) {
  level endon("notify_stop_ticker");
  maps\skyway_util::waittill_looking(var_0, "J_SpineLower", 0.45, 1);
  maps\skyway_util::waittill_looking(var_0, "J_SpineLower", 0.45, 0);
  level notify("notify_stop_footstep_wait");
}

rorke_footstep_wait(var_0) {
  level endon("notify_stop_footstep_wait");
  wait(var_0);
  level notify("notify_stop_ticker");
}

rorke_approach_footsteps(var_0) {
  level endon("notify_rorke_attack");
  wait 2;
  maps\skyway_util::waittill_looking(var_0, "J_SpineLower", 0.45, 0);
  wait 3;
  var_1 = 1;
  var_2 = 1.2;
  common_scripts\utility::exploder("rorke_foot_1");
  wait(randomfloatrange(var_1, var_2));
  common_scripts\utility::exploder("rorke_foot_1");
  wait(randomfloatrange(var_1, var_2));
  common_scripts\utility::exploder("rorke_foot_2");
  wait(randomfloatrange(var_1, var_2));
  common_scripts\utility::exploder("rorke_foot_3");
  wait(randomfloatrange(var_1, var_2));
  common_scripts\utility::exploder("rorke_foot_4");
  wait(randomfloatrange(var_1, var_2));
  common_scripts\utility::exploder("rorke_foot_5");
  wait(randomfloatrange(var_1, var_2));
  common_scripts\utility::exploder("rorke_bird_scare");
  common_scripts\utility::exploder("rorke_foot_6");
  wait(randomfloatrange(var_1, var_2));
  common_scripts\utility::exploder("rorke_foot_7");
  wait(randomfloatrange(var_1, var_2));
  common_scripts\utility::exploder("rorke_foot_8");
  wait(randomfloatrange(var_1, var_2));
  common_scripts\utility::exploder("rorke_foot_9");
  wait(randomfloatrange(var_1, var_2));
  common_scripts\utility::exploder("rorke_foot_10");
  wait(randomfloatrange(var_1, var_2));
  common_scripts\utility::exploder("rorke_foot_11");
  wait(randomfloatrange(var_1, var_2));
  common_scripts\utility::exploder("rorke_foot_12");
  wait(randomfloatrange(var_1, var_2));
  common_scripts\utility::exploder("rorke_foot_13");
  wait(randomfloatrange(var_1, var_2));
  common_scripts\utility::exploder("rorke_foot_14");
  wait(randomfloatrange(var_1, var_2));
}

end_credits() {
  level notify("start_end_credits");
  thread end_credits_music();
  setDvar("credits_active", 1);
  wait 7;
  maps\_credits::playcredits();
  level notify("stop_end_credits_music");
  wait 21;
  maps\_utility::music_stop(30);
}

pit_of_despair(var_0) {
  level.player setclienttriggeraudiozone("skyway_end", 4);
  level.player playSound("scn_sw_pit");
  lerpsunangles(getmapsunangles(), (-25.325, -52.2257, 0), 0.05);
  setsunlight(1, 1, 1);
  var_1 = getDvar("r_diffusecolorscale");
  var_2 = getDvar("r_specularcolorscale");
  var_3 = maps\_utility::spawn_anim_model("sun_pit");
  var_4 = maps\_utility::spawn_anim_model("moon_pit");
  var_5 = maps\_utility::spawn_anim_model("moonlight_pit");
  var_6 = common_scripts\utility::getstruct("pit_of_despair", "script_noteworthy");
  level.player lerpviewangleclamp(0.05, 0, 0, 0, 0, 0, 0);
  level.player lerpfov(90, 0.05);
  wait 0.2;
  level.player lerpviewangleclamp(0.05, 0, 0, 30, 30, 30, 15);
  thread maps\skyway_fx::fx_playerview_pit_raindrops();
  var_7 = 15;
  var_8 = 0.1;
  setblur(var_7, 0.2);
  var_6 thread maps\_anim::anim_single_solo(var_0, "pit_of_despair");
  var_6 thread maps\_anim::anim_single_solo(var_5, "pit_of_despair");
  var_6 thread maps\_anim::anim_single_solo(var_4, "pit_of_despair");
  var_6 thread maps\_anim::anim_single_solo(var_3, "pit_of_despair");
  maps\_utility::vision_set_fog_changes("skyway_pit_day", 1);
  maps\_art::sunflare_changes("pit", 1);
  level thread maps\_hud_util::fade_in(5);
  common_scripts\utility::exploder("pit_flies");
  level.player lerpfov(65, 8.0);
  lerpsunangles((-25.325, -52.2257, 0), (-100, -24.606, 0), 7.0);
  thread blur_over_time(var_7, var_8, 6);
  thread maps\skyway_util::player_const_quake_blendto(0.07, 7);
  playFXOnTag(common_scripts\utility::getfx("pit_sun"), var_3, "tag_helo");
  wait 3.33;
  playFXOnTag(common_scripts\utility::getfx("pit_moonlight"), var_5, "tag_helo");
  playFXOnTag(common_scripts\utility::getfx("pit_moon"), var_4, "tag_helo");
  thread maps\_utility::sun_light_fade((1, 1, 1), (0.1, 0.3, 0.5), 4.0);
  maps\_utility::vision_set_fog_changes("skyway_pit_sunset", 2.0);
  wait 2;
  maps\_utility::vision_set_fog_changes("skyway_pit", 4.0);
  wait 6;
  thread blur_over_time(var_8, var_7, 4);
  level maps\_hud_util::fade_out(4);
  wait 5;
  level notify("notify_clean_pit");
  setsaveddvar("r_diffusecolorscale", var_1);
  setsaveddvar("r_specularcolorscale", var_2);
  var_3 delete();
  var_4 delete();
  var_5 delete();
}

blur_over_time(var_0, var_1, var_2) {
  level notify("notify_stop_time_blur");
  level endon("notify_stop_time_blur");

  for(var_3 = 0; var_3 < var_2; var_3 = var_3 + 0.05) {
    var_4 = var_3 / var_2;
    var_5 = maps\skyway_util::factor_value_min_max(var_0, var_1, var_4);
    setblur(var_5, 0.05);
    wait 0.05;
  }

  setblur(var_1, 0.05);
  wait 0.05;
}

end_credits_music() {
  level endon("stop_end_credits_music");
  wait 1;
  maps\_utility::music_play("music_credits_entire_scroll");
}

throw_stones_idle() {
  self endon("stop_stones");
  self enableweapons();
  self enableoffhandweapons();
  self showviewmodel();
  self takeallweapons();
  self giveweapon("test_stone_throw_skyway");
  self setoffhandsecondaryclass("other");

  for(;;) {
    self setweaponammostock("test_stone_throw_skyway", 1);
    wait 0.05;
  }
}

player_drags_ally(var_0) {
  var_1 = 3;
  var_2 = level._endbeach.idle_anims;
  var_3 = level._endbeach.drag_anims;
  var_4 = "L";
  self.current_drag_anim = undefined;
  var_5 = 0;
  var_6 = 0;
  var_7 = 1;

  if(level.console || level.player usinggamepad())
    var_7 = 0;

  for(var_8 = 0; var_8 < var_2.size; var_8++) {
    thread beach_idle(var_0, var_2[var_8]);

    if(var_8 == 0)
      level waittill("notify_beach_drag_control_start");

    common_scripts\utility::flag_set("hint_drag");

    if(var_4 == "LR") {
      if(var_7)
        maps\_utility::display_hint_timeout("hint_drag_leftright_pc");
      else
        maps\_utility::display_hint_timeout("hint_drag_leftright");
    } else if(var_4 == "L") {
      if(var_7)
        maps\_utility::display_hint_timeout("hint_drag_left_pc");
      else
        maps\_utility::display_hint_timeout("hint_drag_left");
    } else if(var_7)
      maps\_utility::display_hint_timeout("hint_drag_right_pc");
    else
      maps\_utility::display_hint_timeout("hint_drag_right");

    var_9 = 0;
    var_10 = 1;
    var_11 = 0;

    for(var_12 = 0; !var_9; var_10 = 0) {
      if(get_ltrig_press(var_7)) {
        var_5++;

        if(var_10 && var_5 != 0)
          var_11 = 1;
      } else {
        var_11 = 0;
        var_5 = 0;
      }

      if(get_rtrig_press(var_7)) {
        var_6++;

        if(var_10 && var_6 != 0)
          var_12 = 1;
      } else {
        var_12 = 0;
        var_6 = 0;
      }

      switch (var_4) {
        case "L":
          if(var_5 > var_1 && !var_11)
            var_9 = 1;

          break;
        case "R":
          if(var_6 > var_1 && !var_12)
            var_9 = 1;

          break;
        case "LR":
          if(var_6 > var_1 && var_5 > var_1 && !var_12 && !var_11)
            var_9 = 1;

          break;
        default:
      }

      wait 0.05;

      if(var_9) {
        common_scripts\utility::flag_clear("hint_drag");
        self notify("stop_loop");
        level.player lerpviewangleclamp(1, 1, 0, 0, 0, 0, 0);

        if(var_3.size > var_8) {
          if(var_8 == 0 && level._ally._animactive < 2)
            level.scr_goaltime["ally1"]["drag1_L"] = 0;

          level notify("sfx_drag");
          self.current_drag_anim = var_3[var_8];
          thread maps\_anim::anim_single(var_0, self.current_drag_anim);

          if(var_8 == var_3.size - 1)
            var_4 = "LR";
          else if(var_4 == "L")
            var_4 = "R";
          else
            var_4 = "L";

          var_13 = getanimlength(level.player_rig maps\_utility::getanim(var_3[var_8]));
          wait(var_13 - level._endbeach.early_prompt);
        }
      }
    }
  }
}

get_ltrig_press(var_0) {
  if(var_0)
    return level.player buttonPressed("mouse1");
  else
    return level.player adsButtonPressed();
}

get_rtrig_press(var_0) {
  if(var_0)
    return level.player buttonPressed("mouse2");
  else
    return level.player attackButtonPressed();
}

beach_idle(var_0, var_1) {
  self endon("stop_loop");

  if(!issubstr(var_1, "1_1"))
    wait(level._endbeach.early_prompt);

  if(issubstr(var_1, "1_1"))
    level.player common_scripts\utility::delaycall(2, ::lerpviewangleclamp, 3.4, 1, 0, 25, 60, 45, 15);
  else if(issubstr(var_1, "1_2"))
    level.player lerpviewangleclamp(0.05, 0, 0, 5, 120, 45, 0);
  else if(issubstr(var_1, "2_1"))
    level.player lerpviewangleclamp(0.05, 0, 0, 25, 60, 45, 15);
  else if(issubstr(var_1, "2_2"))
    level.player lerpviewangleclamp(0.05, 0, 0, 5, 120, 45, 0);
  else if(issubstr(var_1, "5_1"))
    level.player lerpviewangleclamp(0.05, 0, 0, 45, 30, 50, 15);

  if(issubstr(var_1, "1_1"))
    wait(getanimlength(level.player_rig maps\_utility::getanim("surface")));

  thread maps\_anim::anim_loop(var_0, var_1);
}

rock_idle(var_0) {
  if(level.start_point != "end_beach_final") {
    self notify("stop_loop");
    maps\_anim::anim_single(var_0, "rock");
  }

  thread maps\_anim::anim_loop(var_0, "beach_pt1_idle");
  level.player lerpviewangleclamp(0.05, 0, 0, 60, 30, 45, 15);
}

rock_radio(var_0) {
  if(level.start_point != "end_beach_final") {
    self notify("stop_loop");
    level notify("sfx_drag");
    maps\_anim::anim_single_solo(var_0, "rock");
    maps\_anim::anim_single_solo(var_0, "radio");
  }

  thread maps\_anim::anim_loop_solo(var_0, "beach_pt1_idle");
}

#using_animtree("player");

init_anims_player(var_0) {
  var_1 = [%sw_beach_player_surface, %sw_beach_player_rock, %sw_beach_player_drag1_l, %sw_beach_player_drag1_r, %sw_beach_player_drag2_l, %sw_beach_player_drag2_r, %sw_beach_player_idle1_1, %sw_beach_player_idle1_2, %sw_beach_player_idle2_1, %sw_beach_player_idle2_2, %sw_beach_player_idle5_1];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(issubstr(var_0[var_2], "idle")) {
      level.scr_anim["player_rig"][var_0[var_2]][0] = var_1[var_2];
      continue;
    }

    level.scr_anim["player_rig"][var_0[var_2]] = var_1[var_2];
    level.scr_goaltime["player_rig"][var_0[var_2]] = level._endbeach.blend_time;
  }
}

#using_animtree("generic_human");

init_anims_human(var_0) {
  var_1 = [%sw_beach_hesh_surface, %sw_beach_hesh_rock, %sw_beach_hesh_drag1_l, %sw_beach_hesh_drag1_r, %sw_beach_hesh_drag2_l, %sw_beach_hesh_drag2_r, %sw_beach_hesh_idle1_1, %sw_beach_hesh_idle1_2, %sw_beach_hesh_idle2_1, %sw_beach_hesh_idle2_2, %sw_beach_hesh_idle5_1];
  var_2 = [%sw_beach_playerbody_surface, %sw_beach_playerbody_rock, %sw_beach_playerbody_drag1_l, %sw_beach_playerbody_drag1_r, %sw_beach_playerbody_drag2_l, %sw_beach_playerbody_drag2_r, %sw_beach_playerbody_idle1_1, %sw_beach_playerbody_idle1_2, %sw_beach_playerbody_idle2_1, %sw_beach_playerbody_idle2_2, %sw_beach_playerbody_idle5_1];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(issubstr(var_0[var_3], "idle")) {
      level.scr_anim["ally1"][var_0[var_3]][0] = var_1[var_3];
      level.scr_anim["player_body"][var_0[var_3]][0] = var_2[var_3];
      continue;
    }

    level.scr_anim["ally1"][var_0[var_3]] = var_1[var_3];
    level.scr_anim["player_body"][var_0[var_3]] = var_2[var_3];
    level.scr_goaltime["ally1"][var_0[var_3]] = level._endbeach.blend_time;
    level.scr_goaltime["player_body"][var_0[var_3]] = level._endbeach.blend_time;
  }

  level.scr_anim["ally1"]["radio"] = % sw_beach_hesh_radio;
}

dialogue_intro() {
  maps\_anim::addnotetrack_dialogue("ally1", "line1", "rock", "skyway_hsh_youyougothimlogan");
  maps\_anim::addnotetrack_dialogue("ally1", "line2", "rock", "skyway_hsh_youdidit");
  maps\_anim::addnotetrack_dialogue("ally1", "line3", "radio", "skyway_hsh_merrickcomein");
  maps\_anim::addnotetrack_dialogue("ally1", "line4", "radio", "skyway_hsh_merrickdoyoucopy_2");
  maps\_anim::addnotetrack_notify("ally1", "line5", "notify_line5", "radio");
  maps\_anim::addnotetrack_dialogue("ally1", "line6", "radio", "skyway_hsh_yeahimwithloganwereok");
  maps\_anim::addnotetrack_notify("ally1", "line7", "notify_line7", "radio");
  maps\_anim::addnotetrack_dialogue("ally1", "line8", "radio", "skyway_hsh_deadhesdead");
  maps\_anim::addnotetrack_notify("ally1", "line9", "notify_line9", "radio");
  maps\_anim::addnotetrack_notify("ally1", "line10", "notify_line10", "radio");
  maps\_anim::addnotetrack_dialogue("ally1", "line11", "radio", "skyway_hsh_improudofyou");
  maps\_anim::addnotetrack_notify("ally1", "line12", "notify_line12", "radio");
  maps\_anim::addnotetrack_notify("ally1", "line13", "notify_line13", "radio");
  maps\_anim::addnotetrack_notify("ally1", "line14", "notify_line14", "radio");
  maps\_anim::addnotetrack_notify("ally1", "line15", "notify_line15", "radio");
  maps\_anim::addnotetrack_notify("ally1", "line16", "notify_line16", "radio");
  maps\_anim::addnotetrack_notify("ally1", "line17", "notify_line17", "radio");
  level waittill("notify_line5");
  maps\_utility::smart_radio_dialogue("skyway_mrk_heshheshisthatyou");
  level waittill("notify_line7");
  maps\_utility::smart_radio_dialogue("skyway_mrk_androrke");
  level waittill("notify_line9");
  maps\_utility::smart_radio_dialogue("skyway_mrk_copythattheferationsin");
  level waittill("notify_line10");
  maps\_utility::smart_radio_dialogue("skyway_mrk_sittightreconscoming");
}

dialogue_final() {}

dialogue_outro() {
  maps\_utility::smart_radio_dialogue("skyway_hqr_federationnavyfleetis");
  maps\_utility::smart_radio_dialogue("skyway_hqr_wediditarclight");
}

fx_rorke_bleedout(var_0) {
  maps\_anim::addnotetrack_notify("boss", "start_blood", "notify_start_blood", "beach_pt3");
  maps\_anim::addnotetrack_notify("boss", "stop_blood", "notify_stop_blood", "beach_pt3");
  level waittill("notify_start_blood");
  playFXOnTag(common_scripts\utility::getfx("rorke_bleed_out"), var_0, "J_Wrist_LE");
  level waittill("notify_stop_blood");
  stopFXOnTag(common_scripts\utility::getfx("rorke_bleed_out"), var_0, "J_Wrist_LE");
}

event_sinking_boats() {
  foreach(var_1 in level._endbeach.boats)
  thread maps\_anim::anim_single_solo(var_1, "sink");

  level waittill("notify_start_rogs");
  maps\_utility::stop_exploder("sw_end_aa");
  level notify("notify_end_war");
}

event_boss_rog_hit(var_0, var_1) {
  maps\skyway_util::waittill_nt(var_1, "rod_hit", -1);
  rog_hits([var_0]);
  wait 3;
}

event_rogs_finale(var_0, var_1) {
  maps\skyway_util::waittill_nt(var_1, "rod_hit", -1);
  wait 6;
  var_0[6] thread rog_hits_solo_far();
  wait 5;
  var_0[5] thread rog_hits_solo_far();
  wait 5;
  var_0[0] thread rog_hits_solo_far();
  wait 5;
  var_0[8] thread rog_hits_solo_far();
  wait 7.5;
  var_0[3] thread rog_hits_solo_far();
  wait 4;
  var_0[5] thread rog_hits_solo_far();
  wait 4;
  var_0[0] thread rog_hits_solo_far();
  wait 4.5;
  var_0[3] thread rog_hits_solo_far();
  wait 5;
  var_0[5] thread rog_hits_solo_far();
}

event_player_grabs_knife(var_0) {
  level waittill("notify_beach_knife_grab");
  var_1 = maps\_utility::spawn_anim_model("beach_knife", level.player_rig gettagorigin("tag_knife_attach2"));
  var_1.angles = level.player_rig gettagangles("tag_knife_attach2");
  var_1 linkto(level.player_rig, "tag_knife_attach2");
  level waittill("delete_knife");
  var_1 unlink();
  var_1 delete();
}

event_player_gets_kicked() {
  level waittill("notify_beach_face_kick");
  earthquake(1.0, 0.6, level.player.origin, 128);
  impact_overlay("black", 0.5);
  screenshake(level.player.origin, 1.5, 1.5, 1.5, 0.5, 0, 0, 256, 100, 100, 100);
  level.player shellshock("skyway_beach_pain", 5);
  thread maps\skyway_util::player_rumble_bump(level.player_rumble_ent, 1, 0, 0.05, 0.0, 0.6);
  level.player enableslowaim(0.4, 0.4);
}

event_player_arm_break() {
  level waittill("notify_beach_arm_break");
  thread tunnel_vision_logic();
  level.player thread pain_heartbeat();
  thread impact_overlay("white", 0.5);
  screenshake(level.player.origin, 1, 1, 1, 1, 0, 0, 256, 100, 100, 100);
  maps\_utility::vision_set_changes("skyway_beach_pain", 0);
  maps\_utility::vision_set_changes("skyway_beach_sick", 8);
  earthquake(1.0, 0.6, level.player.origin, 128);
  level.player playrumbleonentity("damage_heavy");
  level.player shellshock("skyway_beach_pain", 10);
  thread maps\skyway_util::player_rumble_bump(level.player_rumble_ent, 1, 0, 0.05, 0.0, 3);
}

event_player_gets_punched() {
  level waittill("notify_beach_face_hit");
  earthquake(1.0, 0.6, level.player.origin, 128);
  impact_overlay("black", 0.5);
  level.player shellshock("skyway_beach_pain", 8);
  thread maps\skyway_util::player_rumble_bump(level.player_rumble_ent, 1, 0, 0.05, 0.0, 0.6);
}

tunnel_vision_logic() {
  playFXOnTag(common_scripts\utility::getfx("end_tunnel_vision"), level.player_fx_org, "tag_helo");
  level waittill("start_end_credits");
  killfxontag(common_scripts\utility::getfx("end_tunnel_vision"), level.player_fx_org, "tag_helo");
  level.player_fx_org delete();
}

pain_heartbeat(var_0) {
  if(!isDefined(var_0))
    var_0 = 8;

  var_1 = 0.05;

  for(var_2 = 0.25; var_0 > 0; var_0 = var_0 - var_2) {
    var_2 = var_2 + var_1;
    wait(var_2);
  }
}

impact_overlay(var_0, var_1) {
  var_2 = maps\_hud_util::create_client_overlay(var_0, 0, level.player);
  var_2.alpha = 1;
  var_2 fadeovertime(var_1);
  var_2.alpha = 0;
  var_2 common_scripts\utility::delaycall(var_1, ::destroy);
}

beach_dof_changes() {
  level waittill("notify_beach_face_hit");
  thread maps\_art::dof_enable_script(0, 25, 4.0, 563, 2205, 0.83, 0.5);
  level waittill("delete_knife");
  wait 30.5;
  thread maps\_art::dof_enable_script(0, 13, 4.0, 0, 1600, 3, 0.3);
  wait 3.5;
  thread maps\_art::dof_enable_script(0, 25, 4.0, 563, 2205, 0.83, 0.5);
  wait 8;
  thread maps\_art::dof_enable_script(0, 39, 7, 2734, 36000, 1.8, 9);
}

rog_hits(var_0) {
  var_1 = 3.5;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2] thread rog_hits_solo();
    wait(var_1);
    var_1 = 7.1;
  }
}

rog_hits_far(var_0, var_1) {
  level endon("notify_stop_far_rogs");
  var_2 = 0.0;

  if(isDefined(var_1))
    var_3 = var_1;
  else
    var_3 = 0;

  for(;;) {
    var_0[var_3] thread rog_hits_solo_far();
    var_2 = randomfloatrange(5, 8);
    wait(var_2);
    var_3 = var_3 + 1;

    if(var_3 == var_0.size)
      var_3 = 0;
  }
}

rog_hits_solo() {
  thread maps\skyway_audio::sfx_rog_sat_impact_beach("tag_explode");
  playFXOnTag(common_scripts\utility::getfx("rog_maintrail_01"), self, "tag_explode_base");
  wait 4.0;
  playFXOnTag(common_scripts\utility::getfx("rog_impact_end_01"), self, "tag_shockwave");
  thread maps\skyway_fx::fx_playerview_fieryflash_01();
  earthquake(0.3, 1.5, level.player.origin, 100000);
  level.player playrumbleonentity("damage_heavy");
  thread maps\skyway_util::player_rumble_bump(level.player_rumble_rog_ent, 0.8, 0.0, 0.2, 0.0, 2.0);
}

rog_hits_solo_far() {
  thread maps\skyway_audio::sfx_rog_sat_impact_beach("tag_explode");
  playFXOnTag(common_scripts\utility::getfx("rog_maintrail_01"), self, "tag_explode_base");
  wait 4.0;

  if(!common_scripts\utility::flag("flag_logos")) {
    playFXOnTag(common_scripts\utility::getfx("rog_impact_end_01"), self, "tag_shockwave");
    thread maps\skyway_fx::fx_playerview_fieryflash_01();
    earthquake(0.2, 1.3, level.player.origin, 100000);
    level.player playrumbleonentity("damage_light");
    thread maps\skyway_util::player_rumble_bump(level.player_rumble_rog_ent, 0.4, 0.0, 0.2, 0.0, 2.0);
  }
}

play_fullscreen_shader(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1;
  var_6 = newclienthudelem(self);
  var_6.x = 0;
  var_6.y = 0;
  var_6 setshader(var_0, 640, 480);
  var_6.splatter = 1;
  var_6.alignx = "left";
  var_6.aligny = "top";
  var_6.sort = 1;
  var_6.foreground = 0;
  var_6.horzalign = "fullscreen";
  var_6.vertalign = "fullscreen";
  var_6.alpha = 0;

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_4))
    var_4 = 0;

  if(var_2 > 0)
    var_6 shader_fade_in(var_2, var_5);

  var_6.alpha = var_5;

  if(var_4) {
    for(var_7 = 0; var_7 < var_1; var_7 = var_7 + (var_2 + var_3)) {
      var_6 shader_fade_out(var_3, var_5);
      var_6 shader_fade_in(var_2, var_5);
    }
  } else
    wait(var_1);

  if(var_3 > 0)
    var_6 shader_fade_out(var_3, var_5);

  var_6.alpha = 0;
  var_6 destroy();
}

shader_fade_in(var_0, var_1) {
  var_2 = 0;
  var_3 = var_1 / (var_0 / 0.05);

  while(var_2 < var_1) {
    self.alpha = var_2;
    var_2 = var_2 + var_3;
    wait 0.05;
  }
}

shader_fade_out(var_0, var_1) {
  var_2 = var_1;
  var_3 = var_1 / (var_0 / 0.05);

  while(var_2 > 0) {
    self.alpha = var_2;
    var_2 = var_2 - var_3;
    wait 0.05;
  }
}

music_second_swell() {
  maps\_anim::addnotetrack_notify("ally1", "start_music", "notify_music_second_swell", "radio");
}

fade_logo_run_credits(var_0) {
  maps\_anim::addnotetrack_notify("ally1", "cred_music", "notify_cred_music", "radio");
  maps\_anim::addnotetrack_notify("ally1", "fade_logo", "notify_fade_logo", "radio");
  level waittill("notify_cred_music");
  level.player playSound("mus_skyway_credits_dev_logos");
  level waittill("notify_fade_logo");
  common_scripts\utility::flag_set("flag_logos");
  thread logo_dev_logos();
  level notify("notify_stop_far_rogs");
  maps\_utility::music_stop(10);
  wait 25;
  level.player setclienttriggeraudiozone(" skyway_beach_pre_rorke", 8);
  wait 6;
  common_scripts\utility::flag_clear("flag_logos");
  thread rog_hits_far(var_0);
  level.player lerpviewangleclamp(0.05, 0, 0, 0, 0, 0, 0);
  wait 2.5;
  level.player lerpviewangleclamp(4, 0, 0, 60, 30, 45, 5);
  level notify("notify_fade_in_stinger");
  level maps\_hud_util::fade_in(7, "black");
}

logo_dev_logos() {
  level.player setclienttriggeraudiozone("skyway_credits_dev_logos", 1);
  var_0 = [512, 256];
  var_1 = logo_create(var_0);
  level maps\_utility::delaythread(0.1, maps\_hud_util::fade_out, 0.1);
  var_1 maps\_utility::delaythread(0.1, ::logo_fade, 0.1, 1);
  var_1 maps\_utility::delaythread(3, ::logo_fade, 2, 0);
  maps\_utility::delaythread(5, maps\_utility::stylized_center_text, "Developed By", 4, undefined, 0);
  maps\_utility::delaythread(10.67, maps\_utility::stylized_center_text, "INFINITY WARD", 4);
  maps\_utility::delaythread(16.17, maps\_utility::stylized_center_text, "NEVERSOFT", 4);
  maps\_utility::delaythread(21.82, maps\_utility::stylized_center_text, "RAVEN", 4);
}

logo_ghost_fx() {
  playFXOnTag(common_scripts\utility::getfx("logo_ghost_end"), level.player_fx_org, "tag_helo");
}

logo_ghost_vision() {
  thread maps\_art::dof_enable_script(0, 0, 0, 1000, 1000, 0, 0.1);
  maps\_utility::vision_set_fog_changes("skyway_logo_1", 0.1);
  maps\_utility::delaythread(0.1, maps\_utility::vision_set_fog_changes, "skyway_logo_2", 4);
  maps\_utility::delaythread(5, maps\_utility::vision_set_fog_changes, "skyway_beach_clear", 0.1);
}

logo_create(var_0) {
  var_1 = maps\_hud_util::createicon("logo_ghosts", var_0[0], var_0[1]);
  var_1.x = 0;
  var_1.y = 0;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.hidewhendead = 1;
  var_1.hidewheninmenu = 1;
  var_1.sort = 205;
  var_1.foreground = 1;
  var_1.alpha = 0;
  return var_1;
}

logo_fade(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
}

logo_grow(var_0, var_1, var_2) {
  var_3 = int(var_1 * var_2[0]);
  var_4 = int(var_1 * var_2[1]);
  self scaleovertime(var_0, var_3, var_4);
}

missile_launch() {
  level waittill("notify_line5");
  wait 6;
  common_scripts\utility::exploder("fleet_battle_fx");
}

hero_rogs() {
  maps\_anim::addnotetrack_notify("ally1", "hero_rogs", "notify_start_rogs", "radio");
}

end_birds() {
  maps\_anim::addnotetrack_notify("ally1", "end_birds", "notify_start_birds", "radio");
}

play_fullscreen_blood_bottom(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4 setshader("fullscreen_bloodsplat_bottom", 640, 480);
  var_4.splatter = 1;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.sort = 1;
  var_4.foreground = 0;
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.alpha = 0;
  var_5 = 0;

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  var_6 = 0.05;

  if(var_1 > 0) {
    var_7 = 0;
    var_8 = var_3 / (var_1 / var_6);

    while(var_7 < var_3) {
      var_4.alpha = var_7;
      var_7 = var_7 + var_8;
      wait(var_6);
    }
  }

  var_4.alpha = var_3;
  wait(var_0);

  if(var_2 > 0) {
    var_7 = var_3;
    var_9 = var_3 / (var_2 / var_6);

    while(var_7 > 0) {
      var_4.alpha = var_7;
      var_7 = var_7 - var_9;
      wait(var_6);
    }
  }

  var_4.alpha = 0;
  var_4 destroy();
}

play_fullscreen_blood(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4 setshader("fullscreen_bloodsplat_left", 640, 480);
  var_4.splatter = 1;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.sort = 1;
  var_4.foreground = 0;
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.alpha = 0;
  var_5 = newclienthudelem(self);
  var_5.x = 0;
  var_5.y = 0;
  var_5 setshader("fullscreen_bloodsplat_right", 640, 480);
  var_5.splatter = 1;
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.sort = 1;
  var_5.foreground = 0;
  var_5.horzalign = "fullscreen";
  var_5.vertalign = "fullscreen";
  var_5.alpha = 0;

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  var_6 = 0.05;

  if(var_1 > 0) {
    var_7 = 0;
    var_8 = var_3 / (var_1 / var_6);

    while(var_7 < var_3) {
      var_4.alpha = var_7;
      var_5.alpha = var_7;
      var_7 = var_7 + var_8;
      wait(var_6);
    }
  }

  var_4.alpha = var_3;
  var_5.alpha = var_3;
  wait(var_0);

  if(var_2 > 0) {
    var_7 = var_3;
    var_9 = var_3 / (var_2 / var_6);

    while(var_7 > 0) {
      var_4.alpha = var_7;
      var_5.alpha = var_7;
      var_7 = var_7 - var_9;
      wait(var_6);
    }
  }

  var_4.alpha = 0;
  var_5.alpha = 0;
  var_4 destroy();
  var_5 destroy();
}

play_fullscreen_blood_splatter_alt(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4 setshader("splatter_alt_sp", 640, 480);
  var_4.splatter = 1;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.sort = 1;
  var_4.foreground = 0;
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.alpha = 0;
  var_5 = 0;

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  var_6 = 0.05;

  if(var_1 > 0) {
    var_7 = 0;
    var_8 = var_3 / (var_1 / var_6);

    while(var_7 < var_3) {
      var_4.alpha = var_7;
      var_7 = var_7 + var_8;
      wait(var_6);
    }
  }

  var_4.alpha = var_3;
  wait(var_0);

  if(var_2 > 0) {
    var_7 = var_3;
    var_9 = var_3 / (var_2 / var_6);

    while(var_7 > 0) {
      var_4.alpha = var_7;
      var_7 = var_7 - var_9;
      wait(var_6);
    }
  }

  var_4.alpha = 0;
  var_4 destroy();
}

sickly_vision() {
  level waittill("notify_beach_face_hit");
  wait 31;
  maps\_utility::vision_set_changes("skyway_beach_sick", 5);
}

god_rays_from_world_location(var_0, var_1, var_2, var_3, var_4) {
  if(maps\_utility::is_gen4()) {
    if(isDefined(var_1))
      common_scripts\utility::flag_wait(var_1);

    var_5 = 0;
    var_6 = 0;

    if(isDefined(var_3))
      maps\_utility::vision_set_fog_changes(var_3, 5);

    var_7 = maps\_utility::create_sunflare_setting("default");

    for(;;) {
      var_5 = atan((level.player.origin[2] - var_0[2]) / sqrt(squared(level.player.origin[0] - var_0[0]) + squared(level.player.origin[1] - var_0[1])));

      if(level.player.origin[0] < var_0[0])
        var_6 = atan((level.player.origin[1] - var_0[1]) / (level.player.origin[0] - var_0[0]));
      else
        var_6 = 180 + atan((level.player.origin[1] - var_0[1]) / (level.player.origin[0] - var_0[0]));

      var_7.position = (var_5, var_6, 0);
      maps\_art::sunflare_changes("default", 0);
      wait 0.05;

      if(isDefined(var_2)) {
        if(common_scripts\utility::flag(var_2)) {
          break;
        }
      }
    }

    if(isDefined(var_4)) {
      maps\_utility::vision_set_fog_changes(var_4, 5);
      wait 5;
      maps\_utility::vision_set_fog_changes("", 1);
    }
  }
}