/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\tunnels\zd30tunnels_basement.gsc
****************************************************/

precache_basement() {
  precachemodel("viewhands_alex_fullbody");
  precachemodel("viewhands_alex_gloves_a");
  precachemodel("ee_lighting_string_light_caged_01");
  precachemodel("weapon_zd30_glowstick_wm_lit");
  precachemodel("weapon_zd30_glowstick_wm_lit_stow");
}

basement_setup() {
  level.molotov_fake_light = getEnt("molotov_fake_lgt", "targetname");
  level.molotov_fake_light.original_intensity = 50;
  waitframe();
  level.molotov_fake_light setlightintensity(0);
}

basement_start() {
  level.player clearclienttriggeraudiozone(1.0);
  level.basement_jump_start = 1;
  thread scripts\sp\hud_util::fade_out(0.1, "black");
  level.player setcinematicmotionoverride("disabled");
  hidecinematicletterboxing(0, 0);
  scripts\engine\sp\objectives::objective_add("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_SEARCH");
}

basement_catchup() {
  scripts\engine\sp\objectives::objective_add("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_SEARCH");
  scripts\sp\maps\tunnels\tunnels.gsc::level_tunnel_setup();
  thread basement_env_fx();
  scripts\sp\player::player_movement_state("cqb");
}

basement() {
  scripts\sp\maps\tunnels\tunnels.gsc::level_tunnel_setup();
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::farah_teleport("basement_farah");

  if(!istrue(level.basement_jump_start))
    scripts\sp\maps\tunnels\tunnels.gsc::alex_loadout();

  scripts\engine\sp\utility::set_start_location("basement_new", [level.player]);
  scripts\sp\player::player_movement_state("cqb");
  level endon("basement_intro_skip");
  level.farah.script_pushable = 0;
  level.farah pushplayer(1);
  thread scripts\engine\sp\utility::autosave_now();
  level.player scripts\engine\sp\utility::allow_nvg(0, "zd30Tunnels", 1);
  thread vfx_intro_collapse();
  thread left_flank_trip_defuse_spawns_surprise_door_guy();
  thread basement_intro_skip_think();
  thread basement_triggered_vo();
  thread basement_special_magic_molotov();
  thread basement_first_blast_cancel();
  thread basement_intro_player_speed_management();
  basement_intro_scene();
  scripts\engine\utility::delaythread(1, ::basement_collapse_lights_on);
  visionsetnaked("", 0.5);
}

basement_env_fx() {
  level endon("storage_reached");

  if(scripts\engine\utility::flag("storage_reached")) {
    return;
  }
  wait 5;
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::debug_print("falling rock thingy - started");
  childthread basement_falling_rocks_thingy(0, "basement_entering_tripweb", undefined);
  childthread basement_falling_rocks_thingy(0, "basement_intro_player_wire", undefined);
  var_0 = 8;
  var_1 = 16;
  var_2 = 8;
  level childthread basement_live_grenade_monitor();
  var_3 = 0;

  for(;;) {
    if(var_3)
      var_4 = var_0;
    else
      var_4 = randomintrange(var_0, var_1);

    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::debug_print("falling rock thingy - interval:" + var_4 + " secs");
    wait(var_4);
    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::debug_print("falling rock thingy - waiting...");
    var_5 = level.player scripts\engine\utility::waittill_any_timeout(var_2, "weapon_fired", "live_grenade");

    if(isDefined(var_5) && var_5 == "live_grenade") {
      var_6 = 4;
      scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::debug_print("falling rock thingy - live_grenade");
    } else if(isDefined(var_5) && var_5 == "weapon_fired") {
      var_6 = 2.5;
      scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::debug_print("falling rock thingy - weapon_fired");
    } else {
      var_6 = 0.05;
      scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::debug_print("falling rock thingy - timed_out");
    }

    var_3 = basement_falling_rocks_thingy(var_6, undefined, undefined, 1);
  }
}

basement_live_grenade_monitor() {
  for(;;) {
    var_0 = getEntArray("grenade", "classname");

    if(isDefined(var_0) &var_0.size > 0) {
      for(;;) {
        var_1 = getEntArray("grenade", "classname");

        if(var_1.size != var_0.size) {
          level.player notify("live_grenade");
          wait 5;
          break;
        }

        wait 0.1;
      }
    }

    wait 0.1;
  }
}

basement_falling_rocks_thingy(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1))
    scripts\engine\utility::flag_wait(var_1);
  else if(isDefined(var_2))
    var_2 waittill("trigger");
  else
    waitframe();

  if(isDefined(var_0) && var_0 >= 0.05)
    wait(var_0);

  var_4 = 3;

  if(isDefined(level.falling_rocks_thingy_time)) {
    if(gettime() - level.falling_rocks_thingy_time < var_4 * 1000)
      return 1;
  }

  level.falling_rocks_thingy_time = gettime();
  var_5 = randomfloatrange(0.2, 0.3);
  var_6 = randomfloatrange(1.25, 2.5);
  earthquake(var_5, var_6, level.player.origin, 64);
  var_7 = 1.875;

  if(var_6 < var_7)
    level.player playRumbleOnEntity("light_2s");
  else
    level.player playRumbleOnEntity("light_3s");

  level.player playSound("zd30_tunnels_quake_lr");

  if(istrue(var_3) && randomfloatrange(0.1, 0.9) > 0.5)
    return 1;

  wait(randomfloatrange(1, 2));
  level.player playSound("zd30_tunnels_quake_rocks_lr");
  scripts\engine\utility::exploder("unstable");
  return 0;
}

basement_intro_skip_think() {
  scripts\engine\utility::flag_wait("first_cell_guy_passed");
  level notify("basement_intro_skip");
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  level.farah.ignoreall = 0;
  level.farah scripts\engine\sp\utility::enable_ai_color();
  level.farah scripts\engine\sp\utility::name_show();
  thread farah_pushable_reset();
}

basement_triggered_vo() {
  var_0 = getEntArray("basement_vo_whisper", "targetname");

  if(isDefined(var_0) && var_0.size > 0)
    scripts\engine\utility::array_thread(var_0, ::basement_vo_whisper);

  var_1 = getEntArray("basement_vo_alex_left", "targetname");
  scripts\engine\utility::array_thread(var_1, ::basement_vo_player, "dx_vom_alx_tunnels_hunt_90", undefined, 1);
  var_2 = getEnt("basement_vo_alex_left_clear", "targetname");
  var_2 thread basement_vo_player("dx_vom_alx_tunnels_hunt_100", undefined, 1);
  var_1 = getEntArray("basement_vo_alex_right", "targetname");
  scripts\engine\utility::array_thread(var_1, ::basement_vo_player, "dx_vom_alx_tunnels_search_40", undefined, 1);
  var_2 = getEnt("basement_vo_alex_right_clear", "targetname");
  var_2 thread basement_vo_player("dx_vom_alx_tunnels_search_30");
  thread farah_calls_out_ceiling_guys();
  thread farah_right_flank_hint();
}

farah_right_flank_hint() {
  level.player endon("death");
  var_0 = getEnt("right_flank_hint_vo", "targetname");
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0 waittill("trigger");
  level.farah thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_tunnels_hunt_80", 1, 0.5);
  var_1 = level.basement_right_flank_runner;
  wait 0.1;

  if(!isalive(var_1)) {
    return;
  }
  var_1 endon("death");
  var_1 endon("goal");

  for(;;) {
    var_2 = level.player scripts\engine\trace::can_see_origin(level.farah getEye(), 0) || level.player scripts\engine\trace::can_see_origin(level.farah.origin, 0);
    var_3 = level.player scripts\engine\trace::can_see_origin(var_1 getEye(), 0) || level.player scripts\engine\trace::can_see_origin(var_1.origin, 0);

    if(var_2 && var_3) {
      wait 0.2;
      level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_alx_basement_tunnel_combat2_20", 1);
      break;
    }

    waitframe();
  }
}

basement_intro_scene() {
  level endon("basement_intro_skip");
  thread sfx_intro_collapse();
  thread mus_tunnels_intro();
  thread cine_letterboxing_basement();
  setomnvar("ui_hide_dpad_hud", 1);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  setomnvar("ui_hide_weapon_info", 1);
  setomnvar("ui_hide_hud", 1);
  level.player scripts\engine\utility::delaycall(0.75, ::playrumbleonentity, "light_3s");
  var_0 = getspawner("alex_wm", "targetname");
  var_1 = scripts\engine\sp\utility::dronespawn_bodyonly(var_0);
  var_1.animname = "alex_wm";
  var_1.anim_getrootfunc = scripts\asm\gesture\script_funcs::set_root;
  var_1 alex_face_swap("head_hero_alex");
  var_2 = var_1 give_alex_weapon();
  level.alex_wm = var_1;

  if(scripts\engine\utility::flag("tunnels_transiton_skipped"))
    wait 0.5;
  else
    wait 4;

  scripts\engine\utility::delaythread(0.3, scripts\sp\hud_util::fade_in, 4, "black");
  var_3 = 0;
  var_4 = 0.25;
  level.player setclientomnvar("ui_hide_hud", 1);
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, var_3, var_3, var_3, var_3, 1);
  level.player_rig show();
  var_5 = "basement_intro";
  var_6 = scripts\engine\utility::getStruct("basement_trapdoor", "targetname");
  thread basement_intro_farah();
  thread basement_intro_vo();
  var_6 thread scripts\common\anim::anim_single([level.player_rig, level.alex_wm], var_5);
  level thread basement_tunnel_dof();
  level.player_rig waittillmatch("single anim", "end");
  level.player_rig hide();
  level.player freezecontrols(0);
  level.player enableweapons();

  if(!istrue(level.basement_jump_start))
    scripts\sp\player_rig::unlink_player_from_rig(1);
  else
    level.player unlink();

  level.player setstance("stand");
  level.player scripts\sp\utility::allow_cg_drawcrosshair(1);
  setomnvar("ui_hide_weapon_info", 0);
  setomnvar("ui_hide_hud", 0);
  setomnvar("ui_hide_dpad_hud", 0);
  var_2 unlink();
  var_2 delete();
  level.alex_wm delete();
  waitframe();
  scripts\engine\utility::flag_set("tunnels_gun_ready");
  level.player showlegs();
}

basement_tunnel_dof() {
  wait 2;
  setsaveddvar("OMNONNMOTP", "0.1 400 2 1000");
  level.alex_wm thread scripts\engine\sp\utility::dof_enable_autofocus(5.6, 1, undefined, undefined, "tag_eye");
  level.farah waittill("glowstick_swap");
  level.farah thread scripts\engine\sp\utility::dof_enable_autofocus(5.6);
  wait 6;
  level.farah thread scripts\engine\sp\utility::dof_disable_autofocus();
  setsaveddvar("OMNONNMOTP", "0.1 500 4 1000");
}

basement_intro_player_speed_management() {
  level.player thread scripts\engine\sp\utility::player_speed_percent(70, 0.05);
  level.player allowsprint(0);
  scripts\engine\utility::flag_wait("basement_intro_player_wire");
  thread basement_env_fx();
  level.player thread scripts\engine\sp\utility::player_speed_percent(100, 6);
  scripts\engine\utility::flag_wait("basement_first_trap_passed");
  level.player allowsprint(1);
}

basement_intro_farah() {
  level endon("basement_intro_skip");
  var_0 = 1;
  var_1 = scripts\engine\utility::getStruct("basement_trapdoor", "targetname");
  level.farah scripts\engine\sp\utility::name_hide();
  level.farah thread show_name_on_basement_intro_skip();
  farah_basement_intro_enter_anim_with_glowstick(var_1);

  if(scripts\engine\utility::flag("basement_intro_player_moving"))
    farah_intro_anim(var_1, "basement_intro_wire", 1);
  else {
    farah_intro_anim(var_1, "basement_intro_branch_enter", 1);
    var_2 = ["dx_vom_far_tunnels_tripwire_11", "dx_vom_far_tunnels_tripwire_12", "dx_vom_far_tunnels_tripwire_30"];
    var_3 = scripts\engine\sp\utility::create_deck(var_2, 0);
    var_3.autoshuffle = 1;

    if(var_0) {
      var_4 = undefined;
      var_5 = 0;

      while(!scripts\engine\utility::flag("basement_intro_player_wire")) {
        var_1 thread scripts\common\anim::anim_loop_solo(level.farah, "basement_intro_branch_idle", "basement_intro_idle_stop");

        if(!isDefined(var_4))
          var_4 = randomfloatrange(6, 8);
        else
          var_4 = randomfloatrange(8, 12);

        var_5++;

        if(var_5 > 3)
          var_4 = 45;

        scripts\engine\utility::flag_wait_or_timeout("basement_intro_player_wire", var_4);

        if(!scripts\engine\utility::flag("basement_intro_player_wire")) {
          var_1 notify("basement_intro_idle_stop");
          level.farah thread scripts\engine\sp\utility::smart_dialogue(var_3 scripts\engine\sp\utility::deck_draw());
          var_1 scripts\common\anim::anim_single_solo(level.farah, "basement_intro_branch_nag");
        } else
          break;

        wait 0.05;
      }
    } else {
      var_1 thread scripts\common\anim::anim_loop_solo(level.farah, "basement_intro_branch_idle", "basement_intro_idle_stop");
      scripts\engine\utility::flag_wait("basement_intro_player_wire");
    }

    var_1 notify("basement_intro_idle_stop");
    farah_intro_anim(var_1, "basement_intro_branch_exit", 1);
  }

  level.farah scripts\engine\sp\utility::name_show();
  farah_intro_anim(var_1, "basement_intro_exit", 1);
  level.tripwire_trap_count = level.tripwires.traps.size;
  thread monitor_tripwire_defuse();
  thread farah_calls_out_ceiling_hole();
  var_1 thread scripts\common\anim::anim_loop_solo(level.farah, "basement_trapdoor_idle");
  thread basement_whisper_lights_scene();
  scripts\engine\utility::flag_wait("basement_trapdoor_entered");
  var_1 notify("stop_loop");
  var_1 thread scripts\common\anim::anim_single_solo(level.farah, "basement_trapdoor_exit");
  wait 1.3;
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  thread farah_pushable_reset();
  thread farah_trap_scene_enable_ai_color();
}

show_name_on_basement_intro_skip() {
  level waittill("basement_intro_skip");
  level.farah scripts\engine\sp\utility::name_hide();
  level.farah scripts\engine\sp\utility::name_show();
}

farah_basement_intro_enter_anim_with_glowstick(var_0) {
  var_1 = 1.2;
  thread glowstick_anim(var_0);
  var_0 thread scripts\common\anim::anim_single_solo(level.farah, "basement_intro_enter");
  level.farah waittillmatch("single anim", "glowstick_stow");
  level.farah.glowstick scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::setanimrate_lerp(level.farah.glowstick scripts\engine\utility::getanim("use"), 1, var_1, 1.25);
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::setanimrate_lerp(level.farah scripts\engine\utility::getanim("basement_intro_enter"), 1, var_1, 1.25);
  wait 2.25;
  level.farah.glowstick scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::setanimrate_lerp(level.farah.glowstick scripts\engine\utility::getanim("use"), var_1, 1, 1.25);
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::setanimrate_lerp(level.farah scripts\engine\utility::getanim("basement_intro_enter"), var_1, 1, 1.25);
  level.farah waittillmatch("single anim", "end");
}

glowstick_anim(var_0) {
  level.farah endon("death");
  level.farah endon("entitydeleted");
  level.farah.glowstick = scripts\engine\sp\utility::spawn_anim_model("farah_glowstick");
  var_0 thread scripts\common\anim::anim_single_solo(level.farah.glowstick, "use");
  level.farah.glowstick waittillmatch("single anim", "glowstick_swap");
  level.farah notify("glowstick_swap");
  level.farah.glowstick setModel("weapon_zd30_glowstick_wm_lit");
  playFXOnTag(level._effect[level.farah.glowstick_vfx], level.farah.glowstick, "tag_fx");
  level.farah.glowstick waittillmatch("single anim", "end");
  level.farah.glowstick linkTo(level.farah, level.farah.glowstick_tag, (0, 0, 0), (0, 0, 0));
  thread swap_glowstick_when_player_isnt_looking();
}

swap_glowstick_when_player_isnt_looking() {
  while(scripts\engine\sp\utility::player_looking_at(level.farah.glowstick.origin, 0.6, 1, level.farah))
    wait 0.1;

  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::spawn_stowed_glowstick_on_farah();
}

farah_intro_anim(var_0, var_1, var_2) {
  var_0 thread scripts\common\anim::anim_single_solo(level.farah, var_1);
  waitframe();
  level.farah setanimrate(level.farah scripts\engine\utility::getanim(var_1), var_2);
  level.farah waittillmatch("single anim", "end");
}

cine_letterboxing_basement() {
  level waittill("cine_letterboxing");
  getrandomnodedestination(1.5, 0);
  level.player clearcinematicmotionoverride();
}

alex_face_swap(var_0) {
  self detach(self.headmodel);
  self.headmodel = var_0;
  self attach(self.headmodel);
}

basement_intro_vo() {
  wait 1.1;
  level.alex_wm thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_alx_tunnels_intro_10");
  level thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_pri_tunnels_intro_11");
  wait 12.2;
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_intro_50");
  scripts\engine\utility::flag_wait("basement_farah_goes_under_tripwire");
  wait 1.5;
  first_trip_defused_vo();
}

first_trip_defused_vo() {
  if(scripts\engine\utility::flag("basement_roof_hint")) {
    return;
  }
  level endon("basement_roof_hint");
  wait_any_trip_defused();
  wait 0.65;
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_tripwire_100");
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_tunnels_tripwire_110");
}

give_alex_weapon() {
  foreach(var_1 in self.fake_weapon_models)
  self detach(var_1);

  var_3 = spawn("script_model", self gettagorigin("j_gun"));
  var_3 scripts\common\utility::make_weapon_model("iw8_sh_romeo870", ["reflex_west01"]);
  var_3.angles = self gettagangles("j_gun");
  var_3 hidepart("j_shell");
  var_3 hidepart("j_loose_round");
  var_3 hidepart("j_shell_fired");
  var_3 linkTo(self, "j_gun");
  return var_3;
}

farah_calls_out_ceiling_hole() {
  level endon("basement_second_trap_passed");
  scripts\engine\utility::flag_wait("basement_roof_hint");
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_tunnels_hunt_78");
}

farah_trap_scene_enable_ai_color() {
  level.farah endon("death");
  scripts\engine\utility::flag_wait("basement_second_trap_passed");
  level.farah scripts\engine\sp\utility::enable_ai_color();
}

basement_whisper_lights_scene(var_0) {
  level endon("basement_intro_skip");
  var_1 = getEnt("basement_vo_whisper_first", "targetname");
  var_2 = getEnt(var_1.target, "targetname");
  var_2.origin = (-6930, 6095, -388);
  var_1 waittill("trigger");
  scripts\engine\utility::flag_set("triggered_basement_whisper");
  var_2 scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_aq1_tunnels_hunt_02");
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_tunnels_search_10", 1, 0.4);
  var_2 thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_aq2_tunnels_hunt_04");
  wait 0.25;
  thread basement_lights_out(1);
  thread basement_farah_lights_out_and_tripwire_hint_vo();

  while(!is_trip_defused("trip_wall_monitor") && !istrue(var_0))
    wait 0.05;

  level.player thread scripts\engine\sp\utility::blend_movespeedscale(1, 3);
  var_3 = 0;

  if(!scripts\engine\utility::flag("basement_entering_tripweb") && !is_trip_defused("trip_web_monitor")) {
    scripts\engine\utility::flag_wait("basement_entering_tripweb");
    var_4 = scripts\engine\utility::getStructArray("basement_vo_response", "targetname");
    var_4 = sortbydistance(var_4, level.player.origin);
    var_5 = ["dx_vom_aq1_tunnels_hunt_66", var_4[0].origin];
    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::do_as_chatter(scripts\engine\utility::play_sound_in_space, var_5, 1, 0.85);
    var_3 = 1.25;
  } else
    var_3 = 1;

  thread basement_paul_revere_scene(var_3);
}

basement_farah_lights_out_and_tripwire_hint_vo() {
  level.player endon("death");
  wait 1.2;

  if(isDefined(level.lasttripwiredefusedtime)) {
    var_0 = lookupsoundlength("tripwire_pop_full") / 1000;
    var_1 = (gettime() - level.lasttripwiredefusedtime) / 1000;

    if(var_1 < var_0)
      wait(var_0 - var_1 + 0.25);
  }

  if(!scripts\engine\utility::flag("basement_entering_tripweb"))
    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::do_as_chatter(::lights_out_vo_seq);

  wait 1;

  if(level.start_point != "basement_tunnel") {
    trip_wall_defuse_vo_nags();
    scripts\engine\utility::flag_wait("basement_second_trap_passed");
  }

  thread trip_web_go_under_vo_nags();
  scripts\engine\utility::flag_wait("basement_entering_tripweb");
  level.farah waittill("goal");
  level.farah waittill("goal_changed");

  if(!is_trip_defused("trip_web_monitor")) {
    level notify("stop_trip_web_nags");
    level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_basement_tunnel_trips_40", 0, 2);
  }
}

lights_out_vo_seq() {
  level.farah stopsounds();

  if(scripts\engine\utility::flag("basement_entering_tripweb")) {
    return;
  }
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_alx_basement_tunnel_poweroff_10", 1);
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_basement_tunnel_poweroff_20", 1);

  if(scripts\engine\utility::flag("basement_entering_tripweb")) {
    return;
  }
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_basement_tunnel_poweroff_30", 1);
}

trip_wall_defuse_vo_nags() {
  var_0 = ["dx_vom_far_basement_tunnel_poweroff_40", "dx_vom_far_basement_tunnel_poweroff_50", "dx_vom_far_basement_tunnel_poweroff_60"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 1);
  var_1.autoshuffle = 0;
  var_2 = 12;
  var_3 = 1;
  var_4 = spawnStruct();
  var_4 childthread monitor_defuse("trip_wall_monitor");

  while(!is_trip_defused("trip_wall_monitor")) {
    level.farah scripts\engine\sp\utility::smart_dialogue(var_1 scripts\engine\sp\utility::deck_draw());
    var_5 = wait_trip_defused_or_timeout("trip_wall_monitor", randomfloatrange(var_2 - var_3, var_2 + var_3));
    var_2 = min(var_2 * 1.2, 35);
    var_3 = min(var_3 * 1.2, 6);
    var_4 notify("stop_wait_tripped");

    if(!istrue(var_5) && istrue(var_4.trap_defused))
      level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_alx_basement_tunnel_poweroff_70");
  }
}

trip_web_go_under_vo_nags() {
  if(scripts\engine\utility::flag("basement_trapwall_passed")) {
    return;
  }
  level endon("stop_trip_web_nags");
  level endon("basement_trapwall_passed");

  if(!is_trip_defused("trip_web_monitor"))
    level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_tunnels_hunt_32");

  wait 3;
  var_0 = ["dx_vom_far_basement_tunnel_poweroff_120", "dx_vom_far_basement_tunnel_poweroff_110", "dx_vom_far_basement_tunnel_poweroff_100", "dx_vom_far_basement_tunnel_poweroff_90"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;
  var_2 = 12;
  var_3 = 1;
  var_4 = spawnStruct();
  var_4 childthread monitor_defuse("trip_web_monitor");

  while(!is_trip_defused("trip_web_monitor")) {
    if(scripts\engine\utility::flag("basement_entering_tripweb") && level.player getstance() == "prone") {
      waitframe();
      continue;
    }

    wait(randomfloatrange(0.5, 1));

    if(scripts\engine\utility::flag("basement_entering_tripweb") && level.player getstance() == "prone") {
      continue;
    }
    level.farah scripts\engine\sp\utility::smart_dialogue(var_1 scripts\engine\sp\utility::deck_draw());
    wait_trip_defused_or_timeout("trip_web_monitor", randomfloatrange(var_2 - var_3, var_2 + var_3));
    var_2 = min(var_2 * 1.25, 35);
    var_3 = min(var_3 * 1.2, 6);
  }

  var_4 notify("stop_wait_tripped");

  if(!istrue(var_4.trap_defused)) {
    return;
  }
  wait 0.4;
  var_5 = "dx_vom_alx_basement_tunnel_trips_20";
  var_6 = lookupsoundlength(var_5) / 1000;
  level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter(var_5, 0, 0.6);
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_basement_tunnel_trips_30", 0, var_6 + 0.3);
}

monitor_defuse(var_0) {
  self endon("stop_wait_tripped");
  self.trap_defused = 0;
  var_1 = get_trap(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_1.defusehintstruct waittill("trigger");
  self.trap_defused = 1;
}

basement_paul_revere_scene(var_0) {
  var_1 = spawn_paul_revere_scene_ai("paul_revere");
  var_1 thread basement_paul_revere_behavior();
  wait 0.2;

  if(scripts\engine\utility::flag("basement_first_blast_cancel") || scripts\engine\utility::flag("basement_trapwall_passed"))
    return;
  else {
    level.first_blast_enemy = spawn_paul_revere_scene_ai("first_blast");
    level.first_blast_enemy thread basement_first_blast_behavior();
    level notify("basement_first_blast_spawned");
  }
}

spawn_paul_revere_scene_ai(var_0) {
  var_1 = scripts\engine\sp\utility::spawn_targetname(var_0 + "_spawner", 1);
  var_1.animname = var_0;
  var_1.allowdeath = 1;
  var_1 thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::battlechatter_off_spawn_func();
  var_1 thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::shutup_when_hit();
  var_1 thread scripts\engine\sp\utility::name_hide();
  return var_1;
}

basement_first_blast_cancel() {
  level endon("basement_first_blast_spawned");
  var_0 = getEnt("first_blast_cancel_trig", "targetname");

  for(;;) {
    var_0 waittill("damage", var_1, var_2);

    if(!isDefined(var_2) || !isPlayer(var_2))
      continue;
    else
      break;
  }

  scripts\engine\utility::flag_set("basement_first_blast_cancel");
  var_3 = scripts\engine\sp\utility::spawn_targetname("first_blast_spawner", 1);
  wait 0.25;

  if(isDefined(var_3))
    var_3 kill();
  else {
    var_4 = 2;

    while(var_4 > 0) {
      if(isDefined(var_3)) {
        var_3 kill();
        return;
      }

      var_4 = var_4 - 0.1;
      wait 0.1;
    }
  }
}

basement_first_blast_behavior() {
  self endon("death");
  self.ignoreme = 1;
  self.disablearrivals = 1;
  self.health = 60;
  var_0 = "basement_first_blast";
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_1 scripts\common\anim::anim_single_solo(self, var_0);
  scripts\engine\sp\utility::set_goal_node_targetname("first_blast_goto");
  scripts\engine\sp\utility::set_goal_radius(32);
  self.disablereload = 1;
  wait 3;
  self.disablereload = 0;
  self.ignoreme = 0;
}

basement_paul_revere_behavior() {
  self endon("death");
  scripts\engine\utility::delaythread(0.05, scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter, "dx_vom_aq1_tunnels_hunt_12", 1);
  thread farah_call_out_runner();
  thread alex_call_out_runner();
  var_0 = "basement_paul_revere";
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_1 thread scripts\common\anim::anim_single_solo(self, var_0);
  var_2 = 1.95;
  wait(var_2);
  self stopanimScripted();
  self.ignoreall = 1;
  self.dontshootwhilemoving = 1;
  scripts\engine\sp\utility::set_maxfaceenemydist(8);
  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\engine\sp\utility::set_goal_node_targetname("paul_revere_goto");
  scripts\engine\sp\utility::set_goal_radius(32);
  scripts\common\utility::demeanor_override("sprint");
  scripts\engine\utility::disable_pain();
  thread wakeup_if_chased();
  var_3 = scripts\engine\utility::waittill_any_return("goal", "wake_from_chase");
  self.ignoreall = 0;

  if(!isDefined(var_3) || var_3 != "wake_from_chase") {
    var_4 = 512;
    thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::delete_when_dist_away(level.player, var_4);
  }
}

alex_call_out_runner() {
  level.player endon("death");
  childthread call_out_missed_shots(self);
  var_0 = call_out_runner_died();
  scripts\engine\utility::flag_set("basement_runner_gone");

  if(istrue(var_0)) {
    return;
  }
  level.runner_got_away = 1;
}

call_out_missed_shots(var_0) {
  var_1 = 1;
  level.player thread scripts\engine\sp\utility::notify_delay("runner_timeout", 3.5);
  wait 0.2;

  foreach(var_3 in getaiarray("axis")) {
    var_3 thread send_notify_on_damaged_by_player();
    var_3 thread send_notify_on_killed_by_player();
  }

  while(var_1 < 3) {
    var_5 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "damaged_enemy", "reload_start", "runner_timeout");

    if(var_5 == "weapon_fired") {
      var_1++;
      continue;
    }

    if(var_5 == "damaged_enemy") {
      var_1--;
      continue;
    }

    break;
  }

  if(!isalive(var_0)) {
    return;
  }
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_alx_basement_tunnel_leftpath_30", 1, 0.3);
}

send_notify_on_damaged_by_player() {
  self endon("death");
  level.player endon("runner_timeout");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && var_1 == level.player)
      level.player notify("damaged_enemy");
  }
}

send_notify_on_killed_by_player() {
  level.player endon("runner_timeout");
  self waittill("death", var_0);

  if(isDefined(var_0) && var_0 == level.player)
    level.player notify("damaged_enemy");
}

drop_flare_when_dead(var_0) {
  var_1 = scripts\engine\utility::waittill_any_return("death", "entitydeleted", "goal");

  if(!isDefined(var_0)) {
    return;
  }
  stopFXOnTag(scripts\engine\utility::getfx("flare_spark"), var_0, "tag_origin");
  var_2 = var_0.origin;
  var_3 = var_0.angles;
  var_0 delete();

  if(isDefined(var_1) && (var_1 == "entitydeleted" || var_1 == "goal")) {
    return;
  }
  thread scripts\sp\player\flare::level_spawnstaticflare(var_2, var_3);
}

wakeup_if_chased() {
  self endon("death");
  wait 5;
  var_0 = 32;

  while(distancesquared(level.player.origin, self.origin) > var_0 * var_0)
    wait 0.25;

  self notify("wake_from_chase");
}

farah_call_out_runner() {
  self endon("death");
  wait 1.5;
  level notify("stop_lights_vo");
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_tunnels_hunt_11", 1, 0.4);
}

call_out_runner_died() {
  self endon("cleaned_up");
  self endon("delete_when_dist_away");
  var_0 = gettime();
  self waittill("death");
  wait 0.3;
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::wait_combat_cooldown(0.6, 1);
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_alx_tunnels_hunt_14", 0, 1);
  return 1;
}

basement_enemy_flare_throw(var_0) {
  var_1 = getEnt("basement_flare_trig", "targetname");
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_2.angles = (355, 80.4, 0);
  var_2.origin = (-6788, 6070, -408);
  var_2.script_noteworthy = 1200;
  var_3 = var_2.origin;
  playworldsound("flare_ignite_plr", var_3);

  if(isDefined(var_0))
    wait(var_0);

  var_1 thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::magic_grenade_launch_think();
  waitframe();
  var_1 notify("trigger");
}

left_flank_trip_defuse_spawns_surprise_door_guy() {
  var_0 = getEnt("left_flank_trip_monitor", "targetname");
  var_1 = undefined;

  foreach(var_3 in level.tripwires.tripwires) {
    if(isDefined(var_3) && var_3 istouching(var_0))
      var_1 = var_3;
  }

  var_5 = randomfloatrange(0.35, 0.65);

  if(isDefined(var_1) && !istrue(var_1.triggered)) {
    var_1 waittill("trigger", var_6);

    if(!isDefined(var_6) || !isPlayer(var_6))
      var_5 = randomfloatrange(0.35, 0.75);
  }

  var_7 = getEnt("surprise_door_spawner", "targetname");

  if(isDefined(var_7)) {
    var_8 = getspawner(var_7.target, "targetname");
    var_8.script_delay_spawn = var_5;
    var_7.origin = var_7.origin + (0, 0, 128);
  }
}

basement_lights_out(var_0) {
  var_1 = "basement_light";
  var_2 = "basement_light_model";
  var_3 = "ee_lighting_string_light_caged_01";
  level.basement_lights = getEntArray(var_1, "script_noteworthy");
  level.basement_light_models = getEntArray(var_2, "script_noteworthy");
  var_4 = sortbydistance(level.basement_light_models, level.player.origin)[0].origin;
  thread scripts\engine\utility::play_sound_in_space("zd30_lights_off", var_4);
  wait 0.5;
  var_5 = 0;

  if(var_5) {
    level.basement_lights = sortbydistance(level.basement_lights, level.player.origin);
    level.basement_light_models = sortbydistance(level.basement_light_models, level.player.origin);

    foreach(var_7 in level.basement_lights) {
      foreach(var_9 in level.basement_light_models) {
        if(distancesquared(var_7.origin, var_9.origin) < 400)
          var_7.fixture = var_9;
      }
    }

    var_12 = 0.35;
    var_13 = 4;
    var_14 = 0;

    for(var_15 = 0; var_15 < level.basement_lights.size; var_15++) {
      var_7 = level.basement_lights[var_15];
      var_7 thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::lights_lerp_off(0);

      if(isDefined(var_7.fixture))
        var_7.fixture thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::lights_model_swap(var_3);

      if(var_14 > var_13) {
        var_14 = 0;
        wait(var_12);
        continue;
      }

      var_14++;
    }
  } else {
    wait 0.25;
    var_16 = 0;

    if(isDefined(level.basement_lights) && isarray(level.basement_lights))
      scripts\engine\utility::array_thread(level.basement_lights, scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::lights_lerp_off, var_16);

    if(isDefined(level.basement_light_models) && isarray(level.basement_light_models))
      scripts\engine\utility::array_thread(level.basement_light_models, scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::lights_model_swap, var_3);

    wait(var_16);
  }

  if(!istrue(var_0)) {
    return;
  }
  level.player_overlay = scripts\sp\hud_util::create_client_overlay("black", 1, level.player);
  level.player_overlay fadeovertime(2);
  level.player_overlay.alpha = 0.5;
  wait 1.95;
  level.player_overlay fadeovertime(4);
  level.player_overlay.alpha = 0;
}

farah_calls_out_ceiling_guys() {}

basement_vo_another_tripwire() {}

basement_vo_player(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("flare_in_fire");
  self endon("death");
  self endon("entitydeleted");
  var_7 = self;
  var_8 = self;

  if(isDefined(self.target))
    var_7 = getEnt(self.target, "targetname");

  if(istrue(var_2))
    level endon(self.targetname + "_notify");

  for(;;) {
    var_7 waittill("trigger", var_9);

    if(isDefined(var_9) && isPlayer(var_9)) {
      var_10 = 1;
      var_11 = scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::get_alive_enemies();

      if(isDefined(var_11)) {
        foreach(var_13 in var_11) {
          if(var_13 istouching(var_8))
            var_10 = 0;
        }
      }

      if(var_10) {
        while((gettime() - level.player.last_weapon_fire_time) / 1000 < 0.5)
          wait 0.05;

        if(!level.player istouching(self)) {
          continue;
        }
        thread basement_vo_player_play(var_0, var_1, var_2, var_3, var_4, var_5, var_6);

        if(istrue(var_2))
          level notify(self.targetname + "_notify");

        return;
      }
    }

    wait 0.1;
  }
}

basement_vo_player_play(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("entitydeleted");
  wait 0.2;
  var_7 = 0.3;
  var_8 = 0.3;
  var_9 = level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::is_combat_cooled_down(var_7, var_8);

  if(isDefined(var_1) && !var_9)
    level.player scripts\engine\sp\utility::smart_player_dialogue(var_1);
  else
    level.player scripts\engine\sp\utility::smart_player_dialogue(var_0);

  if(isDefined(var_3) && isDefined(var_3))
    thread[[var_3]](var_4, var_5, var_6);
}

basement_vo_farah_followup(var_0, var_1, var_2) {
  level endon("flare_in_fire");

  if(isDefined(var_2))
    wait(var_2);

  if(isDefined(level.farah) && isalive(level.farah)) {
    level.farah endon("death");
    var_3 = 3;
    var_4 = 1.5;
    var_5 = level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::is_combat_cooled_down(var_3, var_4);

    if(isDefined(var_1) && !var_5)
      level.farah thread scripts\engine\sp\utility::smart_dialogue(var_1);
    else
      level.farah thread scripts\engine\sp\utility::smart_dialogue(var_0);
  }
}

basement_vo_whisper() {
  level endon("flare_in_fire");
  var_0 = getEnt(self.target, "targetname");

  if(var_0.classname != "script_origin") {
    var_1 = "dx_vom_aq1_tunnels_hunt_62";

    if(isDefined(self.script_noteworthy))
      var_1 = self.script_noteworthy;

    var_2 = lookupsoundlength(var_1) / 1000;
    var_0 thread disable_enemy_battlechatter_while_inside();
    self waittill("trigger");

    if(isDefined(var_0.target)) {
      var_3 = scripts\engine\utility::getStruct(var_0.target, "targetname").origin;
      thread scripts\engine\utility::play_sound_in_space(var_1, var_3);
    } else {
      var_4 = getaiarray("axis");

      foreach(var_6 in var_4) {
        if(isDefined(var_6) && isalive(var_6) && var_6 istouching(var_0)) {
          var_6 thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::ai_playSound(var_1);
          level.enemy_last_scripted_vo = gettime();
          return;
        }
      }
    }
  }
}

disable_enemy_battlechatter_while_inside() {
  self waittill("trigger");

  for(;;) {
    var_0 = scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::get_alive_enemies();

    if(!isDefined(var_0)) {
      self waittill("trigger");
      continue;
    }

    foreach(var_2 in var_0) {
      if(isDefined(var_2) && isalive(var_2)) {
        if(var_2 istouching(self)) {
          var_2 scripts\engine\sp\utility::set_battlechatter(0);
          continue;
        }

        var_2 scripts\engine\sp\utility::set_battlechatter(1);
      }
    }

    wait 0.25;
  }
}

get_trap(var_0) {
  var_1 = getEnt(var_0, "targetname");

  if(isDefined(level.tripwires.traps) && level.tripwires.traps.size > 0) {
    foreach(var_3 in level.tripwires.traps) {
      if(isDefined(var_3) && var_3 istouching(var_1))
        return var_3;
    }
  }
}

is_trip_defused(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_2 = 1;

  if(isDefined(level.tripwires.traps) && level.tripwires.traps.size > 0) {
    foreach(var_4 in level.tripwires.traps) {
      if(isDefined(var_4) && var_4 istouching(var_1))
        var_2 = 0;
    }
  }

  return var_2;
}

wait_any_trip_defused() {
  foreach(var_1 in level.tripwires.traps) {
    if(isDefined(var_1) && isDefined(var_1.defusehintstruct))
      var_1.defusehintstruct endon("trigger");
  }

  level waittill("forever");
}

wait_trip_defused(var_0) {
  while(!is_trip_defused(var_0)) {
    wait_any_trip_defused();
    waitframe();
  }
}

wait_trip_defused_or_timeout(var_0, var_1) {
  level endon(var_0 + "_defused");
  level thread notify_on_trip_defused(var_0);
  wait(var_1);
  return 1;
}

notify_on_trip_defused(var_0) {
  wait_trip_defused(var_0);
  level notify(var_0 + "_defused");
}

mus_tunnels_intro() {
  wait 3;
  setmusicstate("mx_zd30_tunnel_tension");
  wait 150;
  setmusicstate("");
}

sfx_intro_collapse() {
  wait 0.1;
  level.player playSound("scn_zd30_collapse_lr_01");
}

trip_defused_already() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.tripwires.traps.size; var_1++) {
    if(isDefined(level.tripwires.traps[var_1]))
      var_0++;
  }

  return var_0 != level.tripwires.traps.size;
}

monitor_tripwire_defuse() {
  level.player endon("death");

  while(!trip_defused_already())
    wait 0.2;

  level.player notify("tripmine_defused");
}

slow_aim_ramp(var_0, var_1) {
  var_2 = var_0;

  while(var_2 <= var_1) {
    level.player enableslowaim(var_2, var_2);
    var_2 = var_2 + 0.02;
    wait 0.05;
  }

  level.player enableslowaim(var_1, var_1);

  if(var_1 == 1) {
    wait 0.05;
    level.player disableslowaim();
  }
}

basement_special_magic_flash() {
  var_0 = getEnt("directional_magic_flash_deleter", "targetname");
  var_1 = getEnt(var_0.script_linkto, "script_linkname");
  var_2 = getEnt("only_when_someone_around", "targetname");
  var_3 = getEnt(var_2.target, "targetname");
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_0 thread delete_magic_flash_if_triggered(var_1);
  var_2 waittill("trigger");
  var_4 = 0;
  var_5 = scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::get_alive_enemies();

  foreach(var_7 in var_5) {
    if(var_7 istouching(var_3))
      var_4 = 1;
  }

  if(!var_4)
    var_1 delete();
}

delete_magic_flash_if_triggered(var_0) {
  self waittill("trigger");

  if(isDefined(var_0))
    var_0 delete();
}

basement_special_magic_molotov() {
  var_0 = getEnt("molotov_spark_lit", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname").origin;
  var_2 = level._effect["vfx_speaker_sparks"];
  var_3 = "emt_lighter_sparks";
  level.molotov_spark_trig = var_0;
  level.fake_molotov_trig = getEnt("molotov_fake", "script_noteworthy");
  var_0 endon("death");
  var_0 endon("entitydeleted");
  level.fake_molotov_trig endon("death");
  level.fake_molotov_trig endon("entitydeleted");
  var_0 waittill("trigger");
  playFX(var_2, var_1);
  playworldsound(var_3, var_1);
}

basement_special_magic_molotov_exploder_cleanup() {
  level waittill("molotov_impact");
  wait 0.1;
  scripts\engine\utility::flag_wait("player_passed_right_flank");
  scripts\engine\utility::stop_exploder("fake_molly");
}

basement_tunnel_start() {
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\sp\utility::set_start_location("basement_tunnel", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::farah_teleport_and_reset("basement_tunnel_farah");
  thread left_flank_trip_defuse_spawns_surprise_door_guy();
  thread basement_triggered_vo();
  thread basement_whisper_lights_scene(1);
  thread basement_special_magic_molotov();
  thread basement_first_blast_cancel();
}

basement_tunnel_catchup() {}

basement_tunnel() {
  thread farah_ceiling_takedown_scene();
  thread farah_hallway_takedown_scene();
  thread farah_disable_ai_color_before_hallway_takedown();
}

farah_disable_ai_color_before_hallway_takedown() {
  var_0 = getEnt("post_ceiling_takedown_color_trig", "targetname");
  var_0 scripts\engine\utility::trigger_off();
  scripts\engine\utility::flag_wait("farah_hallway_takedown_skipped");
  var_0 scripts\engine\utility::trigger_on();
}

farah_ceiling_takedown_scene() {
  var_0 = getEnt("basement_ceiling_takedown_trig", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_0 thread farah_ceiling_takedown_early_watch(var_1);
  var_2 = var_0 scripts\engine\utility::waittill_any_return("trigger", "death", "entitydeleted");

  if(!isDefined(var_2) || var_2 != "trigger") {
    return;
  }
  if(isDefined(level.molotov_spark_trig))
    level.molotov_spark_trig delete();

  if(isDefined(level.fake_molotov_trig))
    level.fake_molotov_trig delete();

  level.farah_ceiling_takedown_scene_on = 1;
  level.cancel_fake_molotov = 1;
  var_3 = 1.5;

  while(!scripts\engine\sp\utility::player_looking_at(var_1.origin, 0.9) && var_3 > 0) {
    var_3 = var_3 - 0.05;
    wait 0.05;
  }

  level.farah scripts\engine\sp\utility::disable_ai_color();
  thread farah_ceiling_takedown();
  thread farah_ceiling_takedown_aq();
}

farah_ceiling_takedown_early_watch(var_0) {
  self endon("trigger");
  self endon("death");
  self endon("entitydeleted");
  var_1 = getEnt("basement_ceiling_takedown_trig_early", "targetname");
  var_1 waittill("trigger");

  for(;;) {
    if(level.player istouching(var_1) && scripts\engine\utility::flag("basement_door_guy_dealt") && scripts\engine\sp\utility::player_looking_at(var_0.origin, 0.9)) {
      break;
    }

    wait 0.05;
  }

  self notify("trigger");
}

farah_ceiling_takedown_aq() {
  var_0 = "basement_ceiling_takedown_aq";
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = "takedown1_victim";
  var_3 = scripts\engine\sp\utility::spawn_targetname(var_2 + "_spawner", 1);
  var_3.animname = var_2;
  var_3.health = 99999;
  var_3.allowdeath = 0;
  var_3.ignoreme = 1;
  var_3.ignoreall = 1;
  var_3 actoraimassistoff();
  var_3.noragdoll = 1;
  var_3 thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::battlechatter_off_spawn_func();
  var_3 thread scripts\engine\sp\utility::name_hide();
  level.takedown_victim = var_3;
  var_1 scripts\common\anim::anim_single_solo(var_3, var_0);
  var_1 scripts\common\anim::anim_last_frame_solo(var_3, var_0);
  var_3 visiblenotsolid();
}

farah_ceiling_takedown() {
  var_0 = "basement_ceiling_takedown";
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = 0.85;
  thread send_right_flank_goto(var_2);
  level.farah thread farah_takedown_burst_fire();
  var_1 scripts\common\anim::anim_single_solo(level.farah, var_0);
  var_1 thread scripts\common\anim::anim_loop_solo(level.farah, var_0 + "_idle");
  scripts\engine\utility::flag_wait_any_timeout(20, "basement_right_flank_surpise_dealt", "player_passed_right_flank");
  var_1 notify("stop_loop");
  var_1 thread scripts\common\anim::anim_single_solo(level.farah, var_0 + "_exit");
  wait 2;
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  level.farah scripts\engine\sp\utility::set_goal_radius(32);
  level.farah scripts\engine\sp\utility::set_goal_node_targetname("right_flank_exit_node");
}

send_right_flank_goto(var_0) {
  wait(var_0);

  if(isDefined(level.basement_right_flank_runner) && isalive(level.basement_right_flank_runner))
    level.basement_right_flank_runner notify("right_flank_goto");
}

farah_takedown_burst_fire() {
  self endon("death");
  wait(randomfloatrange(0.1, 0.35));
  self shoot();
  wait(randomfloatrange(0.1, 0.35));
  self shoot();

  if(scripts\engine\utility::cointoss()) {
    wait(randomfloatrange(0.1, 0.35));
    self shoot();
  }

  if(isDefined(level.takedown_victim)) {
    level.takedown_victim stopsounds();
    level.takedown_victim playSound("generic_death_enemy_" + (randomint(8) + 1));
  }
}

farah_hallway_takedown_scene() {
  var_0 = getEnt("basement_hallway_takedown_trig", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = var_0 scripts\engine\utility::waittill_any_return("trigger", "death", "entitydeleted");

  if(!isDefined(var_2) || var_2 != "trigger") {
    scripts\engine\utility::flag_set("farah_hallway_takedown_skipped");
    return;
  }

  var_3 = 1.5;

  while(!scripts\engine\sp\utility::player_looking_at(var_1.origin, 0.9) && var_3 > 0) {
    var_3 = var_3 - 0.05;
    wait 0.05;
  }

  var_4 = "basement_hallway_takedown";
  var_5 = scripts\engine\utility::getStruct(var_4, "targetname");
  level.farah scripts\engine\utility::delaythread(3, scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter, "dx_vom_far_basement_tunnel_combat2_80", 0);
  thread farah_hallway_takedown(var_4, var_5);
  thread farah_hallway_takedown_aq(var_4, var_5);
}

farah_hallway_takedown(var_0, var_1) {
  thread farah_hallway_takedown_clean_enemies();
  level.farah thread farah_takedown_burst_fire();
  var_1 scripts\common\anim::anim_single_solo(level.farah, var_0);
  level.farah scripts\engine\sp\utility::set_goal_node_targetname("hallway_takedown_goto");
  level.farah waittill("goal");
}

farah_hallway_takedown_clean_enemies() {
  var_0 = getnode("first_cell_prep_node", "targetname");
  var_1 = getEnt("takedown2_scene_enemy_cleanup", "targetname");
  var_2 = scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::get_alive_enemies();
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in var_2) {
    if(!var_6 istouching(var_1)) {
      var_4++;
      continue;
    }

    var_6 scripts\engine\sp\utility::set_goal_radius(32);
    var_6 scripts\engine\sp\utility::set_goal_node(var_0);
    var_6 scripts\engine\utility::delaythread(5, scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::delete_when_dist_away, level.player, 500);
    var_3++;
  }
}

farah_hallway_takedown_aq(var_0, var_1) {
  var_2 = "takedown2_victim";
  var_3 = scripts\engine\sp\utility::spawn_targetname(var_2 + "_spawner", 1);
  var_3.animname = var_2;
  var_3.health = 99999;
  var_3.allowdeath = 0;
  var_3.ignoreme = 1;
  var_3.ignoreall = 1;
  var_3 actoraimassistoff();
  var_3.noragdoll = 1;
  var_3 thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::battlechatter_off_spawn_func();
  var_3 thread scripts\engine\sp\utility::name_hide();
  level.takedown_victim = var_3;
  var_1 scripts\common\anim::anim_single_solo(var_3, var_0);
  var_1 scripts\common\anim::anim_last_frame_solo(var_3, var_0);
  var_3 visiblenotsolid();
}

remove_anim_corpse_col(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\sp\utility::spawn_anim_model(var_0, var_2.origin, var_2.angles);
  var_4 attach(var_1);
  var_2 thread scripts\common\anim::anim_last_frame_solo(var_4, var_3);
  waitframe();
  scripts\common\anim::anim_set_time_solo(var_4, var_3, 1.0);
  var_4 notsolid();
  self.skipdeathanim = 1;
  self.noragdoll = 1;
  self pushplayer(0);
  self.allowdeath = 1;
  self.diequietly = 1;

  if(isDefined(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  self kill();
  self delete();
}

collapse_setup() {
  level.collapse_geo_before = getEntArray("collapse_pre", "script_noteworthy");
  level.collapse_geo_after = getEntArray("collapse_post", "script_noteworthy");

  foreach(var_1 in level.collapse_geo_after) {
    if(isDefined(var_1.classname) && var_1.classname == "script_brushmodel")
      var_1 connectpaths();

    var_1 hide();
  }

  level.collapse_clip = getEnt("collapse_clip", "targetname");
  level.collapse_clip connectpaths();
  level.collapse_hurt_trigs = getEntArray("collapse_fire_hurt_trig", "targetname");

  foreach(var_4 in level.collapse_hurt_trigs)
  var_4.origin = var_4.origin + (0, 0, 10000);

  thread collapse_setup_tunnel_scriptables();
  thread basement_collapse_crawl_vo_structs();
}

#using_animtree("scriptables");

collapse_setup_tunnel_scriptables() {
  wait 0.25;
  level.collapse_sag_beam = getscriptablearray("sag_beam", "targetname")[0];
  level.collapse_geo_after = scripts\engine\utility::array_add(level.collapse_geo_after, level.collapse_sag_beam);
  level.collapse_sag_beam.animname = "basement_collapse_sag_beam";
  level.collapse_sag_beam useanimtree(#animtree);
  level.collapse_sag_beam hide();
}

collapse_start() {
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\sp\utility::set_start_location("collapse", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::farah_teleport_and_reset("collapse_farah");
  visionsetalternate(0, 0.05);
}

collapse_catchup() {
  thread farah_pushable_reset();

  foreach(var_1 in level.collapse_geo_before)
  var_1 hide();

  foreach(var_1 in level.collapse_geo_after)
  var_1 show();

  thread basement_collapse_objective_update();
  scripts\sp\player::player_movement_state("default");
  scripts\engine\utility::flag_set("flare_in_fire");
  scripts\engine\utility::flag_set("collapse_hadir_convo");
}

farah_pushable_reset() {
  var_0 = 2;

  while(!isDefined(level.farah) || !isalive(level.farah)) {
    var_0 = var_0 - 0.25;
    wait 0.25;

    if(var_0 <= 0)
      return;
  }

  level.farah.script_pushable = 1;
  level.farah pushplayer(0);
}

collapse() {
  level.farah.script_pushable = 0;
  thread collapse_farah_demeanor();
  scripts\engine\utility::array_thread(level.collapse_hurt_trigs, ::collapse_burn_player);
  thread collapse_fuel_hint_dialogue();
  thread collapse_player_slow_crawl();
  collapse_farah_scene();
}

collapse_player_slow_crawl() {
  var_0 = getEnt("slow_crawl_trig", "targetname");
  var_0 waittill("trigger");
  var_1 = 0.5;
  var_2 = 82;
  var_3 = 0;

  for(;;) {
    while(level.player istouching(var_0)) {
      if(!var_3) {
        level.player thread scripts\engine\sp\utility::player_speed_percent(var_2, var_1);
        var_3 = 1;
      }

      if(var_3 && level.player getstance() != "prone") {
        break;
      }

      wait(var_1);
    }

    if(var_3) {
      level.player thread scripts\engine\sp\utility::player_speed_percent(100, var_1);
      var_3 = 0;
    }

    wait(var_1);
    var_0 waittill("trigger");
  }
}

collapse_farah_demeanor() {
  scripts\engine\utility::flag_wait("farah_collapse_demeanor");
  level.farah scripts\common\utility::demeanor_override("combat");
}

collapse_fuel_hint_dialogue() {
  scripts\engine\utility::flag_wait("collapse_gas_hint");
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_tunnels_tripwall_32");
  var_0 = scripts\engine\utility::getStruct("fake_enemy_vo", "targetname").origin;
  scripts\engine\utility::play_sound_in_space("dx_vom_aq1_tunnels_chamber_10", var_0);
}

collapse_oil_trap_wait() {
  level endon("oil_fire_ignited");
  scripts\engine\utility::flag_wait("flare_in_fire");
  scripts\sp\player::player_movement_state("default");
  thread fx_flare_oil_fire();
  wait 1.5;
  thread farah_gestures_fallback();
}

collapse_farah_scene() {
  collapse_oil_trap_wait();
  var_0 = undefined;

  foreach(var_2 in level.oil_fires) {
    if(isDefined(var_2.script_parameters) && var_2.script_parameters == "basement_collapse")
      var_0 = var_2;
  }

  var_0 thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::oilfire_run(1.05);
  level waittill("oil_fire_ignited", var_4, var_5, var_6, var_7, var_8);

  foreach(var_10 in level.magic_grenades) {
    if(isDefined(var_10) && isDefined(var_10.script_parameters) && var_10.script_parameters == "basement_collapse") {
      var_10 delete();
      thread farah_gestures_fallback();
      break;
    }
  }

  wait(var_8);
  thread farah_collapse_react(1.1);
  var_4.oilfire_enabled = 0;
  wait 0.05;

  if(isDefined(var_7))
    stopFXOnTag(scripts\engine\utility::getfx(var_7), var_6, "tag_origin");

  if(isDefined(var_5))
    scripts\engine\utility::stop_exploder(var_5);

  basement_collapse_lights_out();
  thread collapse_explode(1.1);
  thread farah_asking_are_you_ok();
  wait 3;
  var_12 = getEnt("basement_collapse_cough_trig", "targetname");

  if(isalive(level.player) && level.player istouching(var_12)) {
    thread disable_crosshair_for_time(3);
    level.player forceplaygestureviewmodel("ges_ph_cough_a");
    level.player playSound("gas_player_cough_1");
  }

  wait 3;
  thread collapse_beam_bend();

  if(scripts\engine\utility::flag("collapse_hadir_convo"))
    scripts\engine\utility::flag_clear("collapse_hadir_convo");

  level.farah.script_pushable = 1;
  thread collapse_farah_crawl();
  scripts\engine\utility::flag_wait_or_timeout("farah_vo_trip_web", 3);
  thread basement_collapse_objective_update();
  crawl_nags();
  scripts\engine\utility::flag_wait("collapse_hadir_convo");
  thread scripts\engine\sp\utility::autosave_now();
  thread mus_tunnels_crawl();
  basement_collapse_crawl_vo();
  level notify("basement_collapse_crawl_vo_finished");
  level endon("stop_basement_env_fx");
}

crawl_nags() {
  level endon("collapse_hadir_convo");

  if(scripts\engine\utility::flag("collapse_hadir_convo")) {
    return;
  }
  var_0 = ["dx_vom_far_tunnels_tripwall_40", "dx_vom_far_tunnels_tripwall_55", "dx_vom_far_tunnels_tripwall_60"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;

  if(!scripts\engine\utility::flag("farah_vo_trip_web"))
    level.farah scripts\engine\sp\utility::smart_dialogue(var_1 scripts\engine\sp\utility::deck_draw_specific("dx_vom_far_tunnels_tripwall_40"));

  childthread farah_collapse_nag(var_1, "said_crawl_hint", 15);
  crawl_hint_vo();
  var_0 = ["dx_vom_far_tunnels_search_90", "dx_vom_far_tunnels_tripwall_72", "dx_vom_far_tunnels_tripwall_73"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;
  wait 2;

  if(!scripts\engine\utility::flag("collapse_hadir_convo") && level.player getstance() != "prone")
    level.farah scripts\engine\sp\utility::smart_dialogue(var_1 scripts\engine\sp\utility::deck_draw_specific("dx_vom_far_tunnels_search_90"));

  farah_collapse_nag(var_1, "collapse_hadir_convo", 6);
}

crawl_hint_vo() {
  level endon("collapse_hadir_convo");

  if(scripts\engine\utility::flag("collapse_hadir_convo")) {
    return;
  }
  scripts\engine\utility::flag_clear("crawl_hint_failsafe");
  var_0 = scripts\engine\utility::getStruct("hadir_vo_struct_start", "targetname");
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::debug_print("Collapse crawl hint - waiting");

  while(!scripts\engine\sp\utility::player_looking_at(var_0.origin, 0.75) && !scripts\engine\utility::flag("crawl_hint_failsafe"))
    wait 0.1;

  if(scripts\engine\utility::flag("crawl_hint_failsafe"))
    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::debug_print("Collapse crawl hint - active due to failsafe trigger");
  else
    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::debug_print("Collapse crawl hint - active due to looking");

  while(level.player getstance() == "stand")
    waitframe();

  level notify("said_crawl_hint");
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_tripwall_70");
}

disable_crosshair_for_time(var_0) {
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  wait(var_0);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(1);
}

basement_collapse_crawl_vo() {
  while(level.player getstance() != "prone")
    waitframe();

  wait 1;
  hadir_crawl_dialogue("dx_vom_had_caves_crawl_10");
  wait 0.2;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_caves_crawl_20");
  hadir_crawl_dialogue("dx_vom_had_caves_crawl_30");
  level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_alx_caves_crawl_35");
  hadir_crawl_dialogue("dx_vom_had_caves_crawl_37");
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_caves_crawl_40");
  wait 0.5;
  hadir_crawl_dialogue("dx_vom_had_caves_crawl_70");
  wait 0.2;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_caves_crawl_80");
  hadir_crawl_dialogue("dx_vom_had_caves_crawl_90");
  wait 0.5;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_caves_crawl_95");
}

basement_collapse_crawl_vo_structs() {
  var_0 = 256;
  var_1 = scripts\engine\utility::getStruct("hadir_vo_struct_start", "targetname");
  level.vo_struct_trig = spawn("trigger_radius", var_1.origin, 0, var_0, 64);
  level.vo_struct_trig.radius = var_0;

  for(;;) {
    level.vo_struct_trig.origin = var_1.origin;
    waitframe();
    level.vo_struct_trig waittill("trigger", var_2);

    if(!isDefined(var_2) || !isPlayer(var_2)) {
      wait 0.05;
      continue;
    }

    if(!isDefined(var_1.target)) {
      return;
    }
    var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  }

  level waittill("basement_collapse_crawl_vo_finished");
  level.vo_struct_trig delete();
}

hadir_crawl_dialogue(var_0) {
  level.hadir_craw_vo = var_0;
  scripts\engine\utility::play_sound_in_space(var_0, level.vo_struct_trig.origin);
}

basement_collapse_crawl_vo_structs_debug() {
  var_0 = 0.25;
  var_1 = int(var_0 / 0.05);

  for(;;) {
    if(isDefined(level.hadir_craw_vo)) {}

    thread scripts\engine\utility::draw_angles((0, 0, 0), level.vo_struct_trig.origin, (0, 0, 1), var_1, 2);
    thread scripts\engine\utility::draw_circle(level.vo_struct_trig.origin, level.vo_struct_trig.radius, (0.5, 0.5, 1), 1, 0, var_1);
    var_2 = distance2d(level.player.origin, level.vo_struct_trig.origin);
    var_3 = "DIST=" + var_2 + "/" + level.vo_struct_trig.radius;
    wait(var_0);
  }
}

basement_collapse_objective_update() {
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_CRAWL");
  var_0 = scripts\engine\utility::getStruct("hadir_vo_struct_start", "targetname").origin;
  scripts\engine\sp\objectives::objective_add_location_position("tunnels_search", "crawl", var_0);
  scripts\engine\utility::flag_wait("collapse_hadir_convo");

  if(!scripts\engine\utility::flag("storage_reached")) {
    var_0 = scripts\engine\utility::getStruct("storage", "targetname").origin;
    scripts\engine\sp\objectives::objective_remove_all_locations("tunnels_search");
    scripts\engine\sp\objectives::objective_add_location_position("tunnels_search", "crawl_end", var_0);
  }
}

basement_collapse_lights_out() {
  var_0 = getEntArray("tunnel_collapse_light", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 scripts\engine\utility::delaythread(0.25, scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::lights_lerp_off, 0);
  }
}

basement_collapse_lights_on() {
  var_0 = getEntArray("tunnel_collapse_light", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.targetname) && var_2.targetname == "script_light")
      var_2 scripts\sp\lights::light_turn_on();
  }
}

farah_gestures_fallback() {
  wait 0.25;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_tunnels_tripwall_22");
  wait 0.25;
}

farah_collapse_react(var_0) {
  level.farah endon("cancel_react_to_collapse");
  thread farah_collapse_react_timeout(var_0);
  var_1 = "collapse_react";
  var_2 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_2 thread scripts\sp\anim::anim_reach_solo(level.farah, var_1);

  if(isDefined(var_0))
    wait(var_0);

  var_2 scripts\sp\anim::anim_reach_solo(level.farah, var_1);
  level.farah notify("reacting_to_collapse");
  var_2 scripts\common\anim::anim_single_solo(level.farah, var_1);
  level.farah scripts\engine\sp\utility::enable_ai_color();
}

farah_collapse_react_timeout(var_0) {
  level.farah endon("reacting_to_collapse");
  wait(var_0 + 0.5);
  level.farah notify("cancel_react_to_collapse");
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  level.farah scripts\engine\sp\utility::enable_ai_color();
}

farah_collapse_nag(var_0, var_1, var_2) {
  level endon(var_1);

  if(scripts\engine\utility::flag_exist(var_1) && scripts\engine\utility::flag(var_1)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 6;

  var_3 = 300;
  var_4 = var_2 * 3;
  var_5 = 0;

  for(;;) {
    while(distance2dsquared(level.player.origin, level.farah.origin) > var_3 * var_3)
      wait 0.1;

    var_6 = min(var_4, var_2 + 3 * var_5);
    wait(var_6);
    level.farah scripts\engine\sp\utility::smart_dialogue(var_0 scripts\engine\sp\utility::deck_draw());
    var_5++;
  }
}

collapse_farah_crawl() {
  var_0 = getEnt("crawl_clip_a", "targetname");
  var_0.origin = var_0.origin - (0, 0, 1000);
  var_1 = getEnt("crawl_clip_b", "targetname");
  var_1.origin = var_1.origin - (0, 0, 1000);
  var_2 = getEnt("crawl_clip_c", "targetname");
  var_2.origin = var_2.origin - (0, 0, 1000);
  var_3 = getEnt("crawl_clip_d", "targetname");
  var_3.origin = var_3.origin - (0, 0, 1000);
  var_4 = getEnt("crawl_clip_e", "targetname");
  var_4.origin = var_4.origin - (0, 0, 1000);
  clear_all_crawl_flags();
  var_5 = scripts\engine\utility::getStruct("collapse_crawl_A", "targetname");
  var_6 = getnode("pre_collapse_node", "targetname");
  level.farah scripts\common\utility::clear_demeanor_override();
  level.farah scripts\engine\sp\utility::set_goal_node(var_6);
  level.farah scripts\engine\sp\utility::set_goal_radius(32);
  scripts\engine\utility::flag_wait("collapse_crawl_a");
  level.farah scripts\common\utility::clear_demeanor_override();
  var_7 = getnode("collapse_crawl_prep_node", "targetname");
  level.farah scripts\engine\sp\utility::set_goal_node(var_7);
  level.farah waittill("goal");
  var_0.origin = var_0.origin + (0, 0, 1000);
  var_5 collapse_crawl_segment_anim("collapse_crawl_A", "collapse_crawl_b");
  scripts\engine\utility::flag_wait("collapse_crawl_b");
  var_1.origin = var_1.origin + (0, 0, 1000);
  var_5 collapse_crawl_segment_anim("collapse_crawl_B", "collapse_crawl_c");
  scripts\engine\utility::flag_wait("collapse_crawl_c");
  var_2.origin = var_2.origin + (0, 0, 1000);
  var_5 collapse_crawl_segment_anim("collapse_crawl_C", "collapse_crawl_d");
  scripts\engine\utility::flag_wait("collapse_crawl_d");
  var_3.origin = var_3.origin + (0, 0, 1000);
  var_5 collapse_crawl_segment_anim("collapse_crawl_D", "collapse_crawl_e");
  scripts\engine\utility::flag_wait("collapse_crawl_e");
  var_4.origin = var_4.origin + (0, 0, 1000);
  var_5 collapse_crawl_segment_anim("collapse_crawl_E", "collapse_crawl_f");
  scripts\engine\utility::flag_wait("collapse_crawl_f");
  var_5 thread scripts\common\anim::anim_single_solo(level.farah, "collapse_crawl_F");
  level.farah setanimrate(level.farah scripts\engine\utility::getanim("collapse_crawl_F"), 1.5);
  level.farah waittillmatch("single anim", "end");
  level.farah scripts\engine\sp\utility::enable_ai_color();
  level.farah scripts\common\utility::demeanor_override("combat");
}

clear_all_crawl_flags() {
  scripts\engine\utility::flag_clear("collapse_crawl_a");
  scripts\engine\utility::flag_clear("collapse_crawl_b");
  scripts\engine\utility::flag_clear("collapse_crawl_c");
  scripts\engine\utility::flag_clear("collapse_crawl_d");
  scripts\engine\utility::flag_clear("collapse_crawl_e");
}

collapse_crawl_segment_anim(var_0, var_1, var_2, var_3) {
  thread scripts\common\anim::anim_single_solo(level.farah, var_0);

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 0;

  wait(var_3);
  level.farah setanimrate(level.farah scripts\engine\utility::getanim(var_0), var_2);

  if(scripts\engine\sp\utility::player_looking_at(level.farah getEye(), 0.7, 1))
    level.farah waittillmatch("single anim", "end");

  if(!scripts\engine\utility::flag(var_1)) {
    thread scripts\common\anim::anim_loop_solo(level.farah, var_0 + "_idle");
    scripts\engine\utility::flag_wait(var_1);
    self notify("stop_loop");
  }
}

collapse_explode(var_0) {
  scripts\engine\utility::exploder("tunnel_collapse");
  var_1 = scripts\engine\utility::getStruct("collapse_vfx", "targetname");
  thread sfx_tunnel_collapse_02(var_1.origin);
  var_2 = var_1.origin;
  var_3 = 500;
  var_4 = getcorpsearray();

  foreach(var_6 in var_4) {
    var_7 = var_6 scripts\engine\sp\utility::get_corpse_origin();

    if(distancesquared(var_2, var_7) < var_3 * var_3)
      var_6 delete();
  }

  wait(var_0);

  if(scripts\engine\utility::flag("farah_vo_trip_web"))
    scripts\engine\utility::flag_clear("farah_vo_trip_web");

  foreach(var_10 in level.collapse_geo_before)
  var_10 hide();

  foreach(var_10 in level.collapse_geo_after) {
    if(isDefined(var_10.classname) && var_10.classname == "script_brushmodel")
      var_10 connectpaths();

    var_10 show();
  }

  level.collapse_clip hide();
  visionsetalternate(1, 2);
  var_14 = 256;

  foreach(var_16 in level.oil_fire_fumes) {
    if(distance(var_1.origin, var_16.origin) <= var_14)
      stopFXOnTag(level._effect["vfx_oil_evaporate"], var_16, "tag_origin");
  }
}

collapse_beam_bend() {
  var_0 = getEnt("trigger_sag_beam", "targetname");
  var_0 waittill("trigger");
  level.collapse_sag_beam playSound("zd30_collapse_beam_shift");
  wait 0.6;
  level.collapse_sag_beam show();
  level.collapse_sag_beam setscriptablepartstate("base", "cracked");
  scripts\engine\utility::exploder("expl_sag_beam");
}

collapse_burn_player() {
  thread collapse_burn_player_death_hint();
  var_0 = 1.15;
  level waittill("oil_fire_ignited", var_1, var_2, var_3, var_4, var_5);

  if(self.script_noteworthy == "1") {
    wait(var_5 + 1.1 + 0.85);
    self.origin = self.origin - (0, 0, 10000);
    thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::supplementary_fire_damage();
    wait(var_0);
  } else if(self.script_noteworthy == "2") {
    wait(var_5 + 1.1 + 1.1);
    self.origin = self.origin - (0, 0, 10000);
    wait 0.05;
    earthquake(0.7, 2, self.origin, 400);
    level.player playRumbleOnEntity("heavy_1s");
    thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::supplementary_fire_damage();
    wait(var_0);
  } else {
    wait(var_5 + 1.1 + 1.25);
    self.origin = self.origin - (0, 0, 10000);
    wait 0.05;
    earthquake(0.4, 1.5, self.origin, 200);
    level.player playRumbleOnEntity("light_1s");

    if(self.script_noteworthy == "3")
      thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::supplementary_fire_damage();

    wait(var_0);
  }

  self delete();
}

collapse_burn_player_death_hint() {
  level.player waittill("death");

  if(isDefined(level.collapse_hurt_trigs)) {
    foreach(var_1 in level.collapse_hurt_trigs) {
      if(isDefined(var_1) && level.player istouching(var_1))
        scripts\sp\player_death::set_custom_death_quote(66);
    }
  }
}

farah_asking_are_you_ok(var_0) {
  level endon("said_crawl_hint");
  wait 3;
  var_0 = level.player.health / level.player.maxhealth;
  wait 2;
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_tunnels_tripwall_26", 1);

  if(var_0 > 0.99)
    level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_alx_tunnels_tripwall_28");
  else if(var_0 > 0.65)
    level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_alx_tunnels_tripwall_26");
  else
    level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_alx_tunnels_tripwall_27");
}

sfx_tunnel_collapse_02(var_0) {
  thread scripts\engine\utility::play_sound_in_space("scn_zd30_gas_expl_trans", var_0);
  wait 0.6;
  thread scripts\engine\utility::play_sound_in_space("scn_zd30_gas_expl_fireball_front", (-6735, 5265, -436));
  thread scripts\engine\utility::play_sound_in_space("scn_zd30_gas_expl_fireball_rear", (-6722, 5450, -417));
  wait 1;
  level.player playSound("scn_zd30_collapse_lr_02");
}

mus_tunnels_crawl() {
  setmusicstate("mx_zd30_hadir_mood");
}

fx_flare_oil_fire() {
  thread scripts\engine\utility::play_sound_in_space("scn_zd30_flare_oil_throw", (-6731, 4659, -425));
  wait 1;
  var_0 = scripts\engine\utility::getStruct("collapse_flare_fire_start", "targetname").origin;
  playFX(level._effect["vfx_collapse_ignite"], var_0);
  thread scripts\engine\utility::play_sound_in_space("scn_zd30_flare_oil_ignite", (-6727, 4826, -450));
  wait 2;
}

vfx_intro_collapse() {
  wait 2.1;
  scripts\engine\utility::exploder("tunnel_intro_dust");
}