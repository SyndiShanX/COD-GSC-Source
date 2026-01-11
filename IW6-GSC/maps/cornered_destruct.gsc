/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_destruct.gsc
**************************************/

cornered_destruct_pre_load() {
  precacherumble("artillery_rumble");
  precacherumble("collapsing_building");
  precacherumble("light_1s");
  precacherumble("light_2s");
  precacherumble("light_3s");
  precacherumble("heavy_1s");
  precacherumble("heavy_2s");
  precacherumble("heavy_3s");
  precachemodel("com_computer_keyboard");
  precachemodel("com_computer_mouse");
  precachemodel("hjk_tablet_01");
  precachemodel("bowl_wood_modern_01");
  precachemodel("viewhands_player_gs_stealth");
  precachemodel("viewlegs_gs_stealth_tapered");
  precachemodel("cnd_briefcase_01_animated");
  precachemodel("cnd_briefcase_01_glow");
  precachemodel("generic_prop_x30_raven");
  precachemodel("cnd_parachute");
  precachemodel("ctl_parachute_ripcord_prop");
  precachemodel("ctl_parachute_player");
  precachemodel("cnd_player_rubble");
  precachestring(&"CORNERED_HVT_KILLED_FAIL");
  precachestring(&"CORNERED_FAIL_HVT_INTERROGATE");
  precachestring(&"CORNERED_FAIL_EXPLOSION");
  precachestring(&"CORNERED_DEPLOY_CHUTE");
  precachestring(&"CORNERED_DEPLOY_CHUTE_CONSOLE");
  precachestring(&"CORNERED_PARACHUTE_FAIL");
  maps\_utility::add_hint_string("chute_deploy", &"CORNERED_DEPLOY_CHUTE", ::parachute_break);
  precacheshellshock("cornered_stairwell");
  precacheshellshock("cornered_horizontal_start");
  level.hvt_door_blocker = undefined;
  common_scripts\utility::flag_init("baker_breach_ready");
  common_scripts\utility::flag_init("hvt_office_rorke_entry");
  common_scripts\utility::flag_init("hvt_rorke_ready_door");
  common_scripts\utility::flag_init("hvt_rorke_ready");
  common_scripts\utility::flag_init("hvt_baker_ready");
  common_scripts\utility::flag_init("hvt_office_explosion");
  common_scripts\utility::flag_init("hvt_player_done");
  common_scripts\utility::flag_init("hvt_office_statue");
  common_scripts\utility::flag_init("rorke_ready_shake3");
  common_scripts\utility::flag_init("open_stairwell_doors");
  common_scripts\utility::flag_init("stairwell_shake_1");
  common_scripts\utility::flag_init("stairwell_shake_2");
  common_scripts\utility::flag_init("stairwell_shake_3");
  common_scripts\utility::flag_init("office_ally_anims_starting");
  common_scripts\utility::flag_init("office_explosion");
  common_scripts\utility::flag_init("player_can_use_briefcase");
  common_scripts\utility::flag_init("player_used_briefcase");
  common_scripts\utility::flag_init("open_lobby_door");
  common_scripts\utility::flag_init("baker_ready_for_office_shake");
  common_scripts\utility::flag_init("rorke_ready_for_office_shake");
  common_scripts\utility::flag_init("lobby_stairwell_shake");
  common_scripts\utility::flag_init("lobby_rorke_ready");
  common_scripts\utility::flag_init("fall_stagger_anim_done");
  common_scripts\utility::flag_init("fall_down_shake");
  common_scripts\utility::flag_init("go_sm_debris_a");
  common_scripts\utility::flag_init("go_sm_debris_b");
  common_scripts\utility::flag_init("player_is_slipping");
  common_scripts\utility::flag_init("fall_rubble_shift");
  common_scripts\utility::flag_init("fall_enemy_a");
  common_scripts\utility::flag_init("fall_enemy_b");
  common_scripts\utility::flag_init("fall_enemy_c");
  common_scripts\utility::flag_init("fall_enemy_d");
  common_scripts\utility::flag_init("fall_enemy_e");
  common_scripts\utility::flag_init("fall_enemy_f");
  common_scripts\utility::flag_init("go_building_fall");
  common_scripts\utility::flag_init("atrium_pre_rail_hit");
  common_scripts\utility::flag_init("fall_rail_hit");
  common_scripts\utility::flag_init("atrium_pillar_break");
  common_scripts\utility::flag_init("atrium_floor_break");
  common_scripts\utility::flag_init("building_player_anim_begin");
  common_scripts\utility::flag_init("pre_glass_impact");
  common_scripts\utility::flag_init("parachute_exfil");
  common_scripts\utility::flag_init("go_exfil_bldg");
  common_scripts\utility::flag_init("show_ally_chute");
  common_scripts\utility::flag_init("show_player_chute");
  common_scripts\utility::flag_init("parachute_deployed");
  common_scripts\utility::flag_init("exfil_slow_down");
  common_scripts\utility::flag_init("exfil_speed_up");
  common_scripts\utility::flag_init("rescue_finished");
  common_scripts\utility::flag_init("stairwell_finished");
  common_scripts\utility::flag_init("atrium_finished");
  common_scripts\utility::flag_init("teleport");
}

setup_capture() {
  if(maps\cornered_code::is_e3()) {
    thread maps\cornered::e3_transition_start();
    return;
  }

  level.rescue_checkpoint = 1;
  maps\cornered_code::setup_player();
  maps\cornered_code::spawn_allies();
  thread maps\cornered_code::handle_intro_fx();
  thread maps\cornered_audio::aud_check("rescue");
  thread maps\cornered_code::cleanup_outside_ents_on_entry();
  level.player switchtoweapon("kriss+eotechsmg_sp+silencer_sp");
  maps\cornered_code::delete_building_glow();
}

setup_stairwell() {
  level.stairwell_checkpoint = 1;
  level.rescue_anim_struct = common_scripts\utility::getstruct("rescue_animnode", "targetname");
  level.fall_anim_struct = common_scripts\utility::getstruct("fall_animnode", "targetname");
  level.hvt_office_anim_struct = common_scripts\utility::getstruct("hvt_office_animnode", "targetname");
  thread maps\cornered::obj_escape();
  var_0 = getent("hvt_exit_door_rt", "targetname");
  var_1 = getent("hvt_exit_door_lf", "targetname");
  var_2 = getent("stairwell_exit_door_clip", "targetname");
  thread maps\cornered_code::generic_prop_raven_anim(level.hvt_office_anim_struct, "stairwell_door", "cnd_stair_escape_prop_doors", "stairwell_exit_door_left", "stairwell_exit_door_right", 1, "open_stairwell_doors");
  var_0 rotateyaw(100, 0.05);
  var_1 rotateyaw(-100, 0.05);
  var_2 notsolid();
  var_2 connectpaths();
  var_0 connectpaths();
  var_1 connectpaths();
  var_3 = getent("hvt_office_door_clip", "targetname");
  var_3 delete();
  maps\cornered_code::setup_player();
  maps\cornered_code::spawn_allies();
  thread stairwell_pipes();
  thread maps\cornered_code::handle_intro_fx();
  thread stairwell_cracks();
  thread maps\cornered_audio::aud_check("stairwell");
  thread maps\cornered_audio::aud_collapse("pipes");
  thread vista_tilt();
  level.player switchtoweapon("kriss+eotechsmg_sp+silencer_sp");
  maps\cornered_code::delete_building_glow();
  thread maps\cornered_code::cleanup_outside_ents_on_entry();
  wait 0.05;
  var_2 delete();
}

setup_atrium() {
  level.atrium_checkpoint = 1;
  maps\cornered_code::setup_player();
  maps\cornered_code::spawn_allies();
  level.fall_anim_struct = common_scripts\utility::getstruct("fall_animnode", "targetname");
  thread vista_tilt();
  thread fall_props();
  thread fall_physics_debris_lobby();
  thread maps\cornered_code::handle_intro_fx();
  thread maps\cornered_audio::aud_check("atrium");
  level.player switchtoweapon("kriss+eotechsmg_sp+silencer_sp");
  maps\cornered_code::delete_building_glow();
  thread maps\cornered_code::cleanup_outside_ents_on_entry();
}

begin_capture() {
  if(maps\cornered_code::is_e3()) {
    return;
  }
  level thread hvt_office_handler();
  common_scripts\utility::flag_wait("rescue_finished");
}

begin_stairwell() {
  level thread stairwell_handler();
  level thread office_handler();

  if(maps\cornered_code::is_e3()) {
    level.player maps\_utility::vision_set_changes("cornered_07", 0.5);
  }

  common_scripts\utility::flag_wait("stairwell_finished");
}

begin_atrium() {
  level thread fall_handler();
  common_scripts\utility::flag_wait("atrium_finished");
}

vista_tilt_setup() {
  level.vista = getEntArray("vista_buildings", "targetname");
  level.vista_pivot = getent("air_vista_pivot", "targetname");
  thread fall_fx_crowd_setup();
  thread fall_fx_billboard_setup();

  foreach(var_1 in level.vista) {
    var_1 notsolid();
    var_1 linkto(level.vista_pivot);
  }
}

vista_tilt() {
  level.player_ref_ent = getent("player_ref_ent_1", "targetname");
  level.player playersetgroundreferenceent(level.player_ref_ent);
  level.player.dof_ref_ent = level.player_ref_ent;

  if(!isDefined(level.stairwell_checkpoint) && !isDefined(level.atrium_checkpoint)) {
    common_scripts\utility::flag_wait("hvt_office_explosion");
    level.player_ref_ent rotateto((-4, 0, -7), 5, 1.5);
    level.vista_pivot rotateto((-4, 0, -7), 5, 1.5);
    var_0 = 0;
    var_1 = 0;

    for(var_2 = 0; var_2 < 20; var_2++) {
      setphysicsgravitydir((var_0, var_1, -0.03));
      wait 0.25;
      var_0 = var_0 + 0.001;
      var_1 = var_1 + -0.0005;
    }
  } else {
    level.player_ref_ent rotateto((-4, 0, -7), 0.05);
    level.vista_pivot rotateto((-4, 0, -7), 0.05);
    common_scripts\utility::waitframe();
  }

  if(!isDefined(level.atrium_checkpoint)) {
    common_scripts\utility::flag_wait("office_explosion");
    earthquake(0.5, 4, level.player.origin, 2500);
    thread common_scripts\utility::play_sound_in_space("scn_crnd_quake", level.player.origin);
    level.player_ref_ent rotateto((0, 0, -8), 5, 1.5);
    level.vista_pivot rotateto((0, 0, -8), 5, 1.5);
    wait 4.0;
    level thread random_building_shake_loop(0.1, 3.0, 7.0, 1.0);
  } else {
    level.player_ref_ent rotateto((0, 0, -8), 0.05);
    level.vista_pivot rotateto((0, 0, -8), 0.05);
    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_wait("lobby_stairwell_shake");
  level.player_ref_ent rotateto((0, 0, -18), 9, 1, 2);
  level.vista_pivot rotateto((0, 0, -18), 9, 1, 2);
  wait 9.0;
  common_scripts\utility::flag_wait_all("lobby_shake", "lobby_rorke_ready");
  level.player_ref_ent rotateto((0, 0, -20), 4, 3);
  level.vista_pivot rotateto((0, 0, -20), 4, 3);
  lerpsunangles((-12, -10, 0), (-16, -3, 0), 4, 3);
  wait 4.0;
  level.vista_tilt_animnode = common_scripts\utility::getstruct("bldg_tilt_struct", "targetname");
  level.vista_tilt_model = maps\_utility::spawn_anim_model("bldg_tilt_cam", level.vista_pivot.origin);
  level.vista_tilt_model.angles = (0, 0, 0);
  level.vista_tilt_animnode maps\_anim::anim_first_frame_solo(level.vista_tilt_model, "cornered_building_fall_building");
  level.player_ref_ent linkto(level.vista_tilt_model, "J_prop_1");
  level.vista_pivot linkto(level.vista_tilt_model, "J_prop_1");
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_wait("go_building_fall");
  level.vista_tilt_animnode thread maps\_anim::anim_single_solo(level.vista_tilt_model, "cornered_building_fall_building");
  lerpsunangles((-16, 3, 0), (-25, 21.9, 0), 10, 0, 3);
  level.vista_tilt_model waittillmatch("single anim", "rubble_start");
  common_scripts\utility::flag_wait("parachute_exfil");
  level.player playersetgroundreferenceent(undefined);
  level.player.dof_ref_ent = undefined;
  level.vista_pivot unlink();
  level.vista_pivot rotateto((0, 0, 0), 0.05);
  setphysicsgravitydir((0, 0, -1));
  resetsundirection();
  var_3 = getEntArray("end_broken_bldg", "targetname");
  common_scripts\utility::array_thread(var_3, maps\_utility::show_entity);
  var_4 = getEntArray("vista_building_tiran_dmg", "targetname");
  common_scripts\utility::array_thread(var_4, maps\_utility::show_entity);
  wait 0.1;

  foreach(var_6 in level.vista) {
    if(isDefined(var_6)) {
      var_6 unlink();
    }
  }
}

hvt_office_handler() {
  maps\_utility::music_stop(5);
  level.rescue_anim_struct = common_scripts\utility::getstruct("rescue_animnode", "targetname");
  level.fall_anim_struct = common_scripts\utility::getstruct("fall_animnode", "targetname");
  level.hvt_office_anim_struct = common_scripts\utility::getstruct("hvt_office_animnode", "targetname");

  if(isDefined(level.rescue_checkpoint)) {
    common_scripts\utility::flag_set("garden_finished");
    thread maps\cornered_garden::close_hvt_office_doors(0.05);
  }

  maps\_utility::battlechatter_off("axis");
  maps\_utility::battlechatter_off("allies");
  wait 0.25;
  level.allies[level.const_rorke] thread hvt_office_keegan();
  level.allies[level.const_baker] thread hvt_pre_office_hesh();
  common_scripts\utility::flag_wait("baker_breach_ready");
  thread hvt_office_props();
  thread hvt_office_briefcase();
  thread hvt_office_doors();
  common_scripts\utility::flag_wait("hvt_office_breach");

  if(isDefined(level.hvt_door_blocker) && level.hvt_door_blocker == 1) {
    thread hvt_office_door_block_down();
  }

  common_scripts\utility::flag_set("obj_capture_complete");
  thread hvt_office_fail();
  thread hvt_office_hvt();
  thread hvt_office_hesh();
  thread hvt_office_safe_block();
  thread vista_tilt();
  common_scripts\utility::flag_wait("hvt_office_explosion");
  thread maps\cornered_audio::aud_collapse("building");
  thread hvt_office_environment();
  thread maps\cornered_lighting::hvt_office_light();
  thread stairwell_pipes();
  wait 2.25;
  thread maps\cornered::obj_escape();
}

hvt_office_fail() {
  level endon("close_hvt_door");
  var_0 = getent("fail_hvt_volume", "targetname");
  var_1 = getent("fail_hvt_volume2", "targetname");
  common_scripts\utility::flag_wait("hvt_office_rorke_entry");

  while(!common_scripts\utility::flag("hvt_office_explosion")) {
    if(level.player istouching(var_0)) {
      setdvar("ui_deadquote", &"CORNERED_FAIL_HVT_INTERROGATE");
      maps\_utility::missionfailedwrapper();
    }

    wait 0.05;
  }

  for(;;) {
    if(level.player istouching(var_0) || level.player istouching(var_1)) {
      setdvar("ui_deadquote", &"CORNERED_FAIL_EXPLOSION");
      maps\_utility::missionfailedwrapper();
    }

    wait 0.05;
  }
}

hvt_office_player() {
  var_0 = maps\_utility::spawn_anim_model("player_office");
  var_0 hide();
  level.hvt_office_anim_struct maps\_anim::anim_first_frame_solo(var_0, "cornered_office_player");
  common_scripts\utility::flag_wait("player_used_briefcase");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  level.player playerlinktoblend(var_0, "tag_player", 0.6);
  level.hvt_office_anim_struct thread maps\_anim::anim_single_solo(var_0, "cornered_office_player");
  wait 0.55;
  var_0 show();
  level.player playerlinktodelta(var_0, "tag_player", 0, 10, 10, 10, 10);
  var_0 waittillmatch("single anim", "end");
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player enableweapons();
  level.player unlink();
  common_scripts\utility::flag_set("hvt_player_done");
  common_scripts\utility::waitframe();
  var_0 delete();
}

hvt_pre_office_hesh() {
  if(!isDefined(level.rescue_checkpoint)) {
    var_0 = common_scripts\utility::getstruct("rorke_pre_hvt", "targetname");
    thread hesh_pre_office_vo();

    if(!isDefined(var_0)) {
      return;
    }
    wait 2;
    var_0 maps\_anim::anim_reach_solo(self, "breach_stackL_approach");

    if(common_scripts\utility::flag("hvt_office_breach")) {
      return;
    }
    var_0 maps\_anim::anim_single_solo(self, "breach_stackL_approach");

    if(!common_scripts\utility::flag("hvt_office_breach")) {
      var_0 thread maps\_anim::anim_loop_solo(self, "explosivebreach_v1_stackL_idle", "stop_loop");
    }

    common_scripts\utility::flag_wait("hvt_office_breach");
    var_0 notify("stop_loop");
  }
}

hesh_pre_office_vo() {
  self endon("done_with_hvt_nag");
  level endon("hvt_office_breach");
  var_0 = getent("hvt_close_to_hesh", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      maps\_utility::smart_dialogue("cornered_hsh_gotakepointwith");
      self notify("done_with_hvt_nag");
    }

    wait 0.05;
  }
}

hvt_office_keegan() {
  maps\_utility::enable_cqbwalk();
  self.grenadeammo = 0;
  maps\_utility::disable_ai_color();
  self.ignoresuppression = 1;
  self.baseaccuracy = 1;
  maps\_utility::disable_bulletwhizbyreaction();

  if(!isDefined(level.rescue_checkpoint)) {
    var_0 = common_scripts\utility::getstruct("baker_hvt_door", "targetname");
    var_0 maps\_anim::anim_reach_solo(self, "breach_stackL_approach");
    var_0 maps\_anim::anim_single_solo(self, "breach_stackL_approach");
    common_scripts\utility::flag_set("baker_breach_ready");

    if(!common_scripts\utility::flag("hvt_office_breach")) {
      var_0 thread maps\_anim::anim_loop_solo(self, "explosivebreach_v1_stackL_idle", "stop_loop");
    }

    common_scripts\utility::flag_wait("hvt_office_breach");
    var_0 notify("stop_loop");
    waittillframeend;
  } else {
    common_scripts\utility::flag_set("baker_breach_ready");
    common_scripts\utility::flag_wait("hvt_office_breach");
  }

  thread maps\_utility::autosave_tactical();
  thread hvt_office_keegan_talking();
  level.hvt_office_anim_struct thread maps\_anim::anim_single_solo(self, "cornered_office_baker_enter");
  thread maps\cornered_audio::aud_hvt("door");
  self waittillmatch("single anim", "start_rorke_ramos_anims");
  common_scripts\utility::flag_set("hvt_office_rorke_entry");
  self waittillmatch("single anim", "vargas_anim_start");
  thread hvt_office_vargas();
  self waittillmatch("single anim", "bink_start");

  if(!level.console) {
    wait 0.225;
  }

  if(isDefined(level.ps3) && level.ps3) {
    wait 0.225;
  }

  if(isDefined(level.ps4) && level.ps4) {
    wait 0.225;
  }

  setsaveddvar("cg_cinematicFullScreen", "0");
  cinematicingame("cornered_rorke_tv");
  self waittillmatch("single anim", "explosion");
  thread stairwell_cracks();
  common_scripts\utility::flag_set("hvt_office_explosion");
  self waittillmatch("single anim", "end");
}

hvt_office_hvt_setup() {
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.diequietly = 1;
  self.team = "neutral";
  self.animname = "hvt";
  thread hvt_office_hvt_death();
  maps\_utility::gun_remove();
  self.health = 1000000;
}

hvt_office_hvt_death() {
  self endon("hvt_dead");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_1) && isplayer(var_1) && var_4 != "MOD_IMPACT") {
      self kill();
      setdvar("ui_deadquote", &"CORNERED_HVT_KILLED_FAIL");
      maps\_utility::missionfailedwrapper();
      self notify("hvt_dead");
    }
  }
}

hvt_office_hvt() {
  var_0 = getent("office_hvt", "targetname");
  var_0 maps\_utility::add_spawn_function(::hvt_office_hvt_setup);
  var_1 = maps\_utility::spawn_targetname("office_hvt", 1);
  level.office_hvt = var_1;
  var_1 endon("death");
  common_scripts\utility::waitframe();
  level.hvt_office_anim_struct maps\_anim::anim_first_frame_solo(var_1, "cornered_office_enter");
  common_scripts\utility::flag_wait("hvt_office_rorke_entry");
  thread maps\cornered_audio::aud_hvt("part1", var_1);
  level.hvt_office_anim_struct thread maps\_anim::anim_single_solo(var_1, "cornered_office_enter");
  var_1 thread maps\_utility::smart_dialogue("cornered_rms_paindoorshove");
  var_1 thread hvt_office_hvt_talking();
  var_2 = getent("hvt_office_door_clip", "targetname");
  var_2 delete();
  thread maps\cornered_audio::aud_hvt("part2", var_1);
  var_1 waittillmatch("single anim", "killable");
  self.team = "axis";
  var_1 notify("hvt_dead");
  var_1.health = 100;
  var_1.allowdeath = 1;
  var_1 waittillmatch("single anim", "end");

  if(isalive(var_1)) {
    level.hvt_office_anim_struct thread maps\_anim::anim_loop_solo(var_1, "cornered_office_loop", "stop_loop_hvt");
  }
}

hvt_office_hvt_talking() {
  self endon("death");
  self waittillmatch("single anim", "vo_cornered_rms_heavenlyfatherplease");
  thread maps\_anim::anim_facialfiller("stop_lip_flap");
  wait 5.8;
  self notify("stop_lip_flap");
}

hvt_office_vargas() {
  var_0 = getent("office_vargas", "targetname");
  var_1 = maps\_utility::spawn_targetname("office_vargas", 1);
  var_1.ignoreme = 1;
  var_1.ignoreall = 1;
  var_1 maps\_utility::gun_remove();
  var_1.health = 1000000;
  var_1.animname = "vargas";
  var_1 maps\_utility::magic_bullet_shield();
  var_1 thread maps\cornered_audio::aud_hvt_boomtimer01();
  level.hvt_office_anim_struct maps\_anim::anim_single_solo(var_1, "cornered_office_vargas_enter");
  var_1 maps\_utility::stop_magic_bullet_shield();
  var_1 delete();
}

hvt_office_hesh() {
  var_0 = level.allies[level.const_baker];
  var_0 maps\_utility::enable_cqbwalk();
  var_0.grenadeammo = 0;
  var_0 maps\_utility::disable_ai_color();
  var_0.ignoresuppression = 1;
  var_0.baseaccuracy = 1;
  var_0 maps\_utility::disable_bulletwhizbyreaction();
  level.hvt_office_anim_struct maps\_anim::anim_first_frame_solo(var_0, "cornered_office_enter");
  var_1 = var_0 gettagorigin("tag_weapon_left");
  var_2 = var_0 gettagangles("tag_weapon_left");
  var_3 = spawn("script_model", var_1);
  var_3.angles = var_2;
  var_3 setModel("weapon_p226");
  var_3 linkto(var_0, "tag_weapon_left");
  common_scripts\utility::flag_wait("hvt_office_rorke_entry");
  var_0 pushplayer(0);
  level.hvt_office_anim_struct thread maps\_anim::anim_single_solo(var_0, "cornered_office_enter");
  var_0 waittillmatch("single anim", "statue_anim_start");
  common_scripts\utility::flag_set("hvt_office_statue");
  var_0 waittillmatch("single anim", "end");
  var_3 delete();
  var_0 pushplayer(1);
  common_scripts\utility::flag_set("rescue_finished");
  common_scripts\utility::flag_wait("post_office_save");
  thread maps\_utility::autosave_by_name("post_explosion_intel");
}

hvt_office_keegan_talking() {
  self waittillmatch("single anim", "vo_cornered_mrk_inposition");
  thread maps\_anim::anim_facialfiller("stop_lip_flap");
  wait 0.8;
  self notify("stop_lip_flap");
  self waittillmatch("single anim", "vo_cornered_mrk_alrightletsmove");
  thread maps\_anim::anim_facialfiller("stop_lip_flap");
  wait 1.3;
  self notify("stop_lip_flap");
  self waittillmatch("single anim", "vo_cornered_mrk_dammithesnothere");
  thread maps\_anim::anim_facialfiller("stop_lip_flap");
  wait 1.35;
  self notify("stop_lip_flap");
  self waittillmatch("single anim", "vo_cornered_mrk_hesh_2");
  thread maps\_anim::anim_facialfiller("stop_lip_flap");
  wait 0.4;
  self notify("stop_lip_flap");
  self waittillmatch("single anim", "vo_cornered_mrk_wheresrorkewhereis");
  thread maps\_anim::anim_facialfiller("stop_lip_flap");
  wait 2.0;
  self notify("stop_lip_flap");
  self waittillmatch("single anim", "vo_cornered_mrk_hesh");
  thread maps\_anim::anim_facialfiller("stop_lip_flap");
  wait 0.4;
  self notify("stop_lip_flap");
  self waittillmatch("single anim", "vo_cornered_mrk_youhavefiveseconds");
  thread maps\_anim::anim_facialfiller("stop_lip_flap");
  wait 3.55;
  self notify("stop_lip_flap");
  self waittillmatch("single anim", "vo_cornered_mrk_threetwo");
  thread maps\_anim::anim_facialfiller("stop_lip_flap");
  wait 2.0;
  self notify("stop_lip_flap");
  self waittillmatch("single anim", "vo_cornered_mrk_rorke");
  thread maps\_anim::anim_facialfiller("stop_lip_flap");
  wait 0.7;
  self notify("stop_lip_flap");
  self waittillmatch("single anim", "vo_cornered_mrk_walker");
  thread maps\_anim::anim_facialfiller("stop_lip_flap");
  wait 0.5;
  self notify("stop_lip_flap");
  self waittillmatch("single anim", "vo_cornered_mrk_whereareyourorke");
  thread maps\_anim::anim_facialfiller("stop_lip_flap");
  wait 1.1;
  self notify("stop_lip_flap");
  self waittillmatch("single anim", "vo_cornered_mrk_itwasasetup");
  thread maps\_anim::anim_facialfiller("stop_lip_flap");
  wait 1.75;
  self notify("stop_lip_flap");
}

hvt_office_safe_block() {
  common_scripts\utility::flag_wait("close_hvt_door");
  thread maps\cornered_garden::close_hvt_office_doors(0.75);
  maps\_utility::stop_exploder(1200);
  maps\_utility::stop_exploder(20);
}

hvt_office_door_block_up() {
  var_0 = getent("hvt_office_player_block", "targetname");
  var_0 movez(128, 0.05);
  level.hvt_door_blocker = 1;
}

hvt_office_door_block_down() {
  var_0 = getent("hvt_office_player_block", "targetname");
  var_0 movez(-128, 0.05);
  level.hvt_door_blocker = undefined;
}

hvt_office_props() {
  thread maps\cornered_code::generic_prop_raven_anim(level.hvt_office_anim_struct, "office_props", "cornered_office_prop_monitors", "hvt_office_monitor1", "hvt_office_monitor2", 1, "hvt_office_rorke_entry");
  thread maps\cornered_code::generic_prop_raven_anim(level.hvt_office_anim_struct, "office_props", "cornered_office_prop_mouse_keyboard", "hvt_office_keyboard", "hvt_office_mouse", 1, "hvt_office_rorke_entry");
  thread maps\cornered_code::generic_prop_raven_anim(level.hvt_office_anim_struct, "office_props", "cornered_office_debris_chair", "hvt_office_debris_chair", "hvt_office_debris_chair2", 1, "hvt_office_explosion", undefined, 3.6);
  thread maps\cornered_code::generic_prop_raven_anim(level.hvt_office_anim_struct, "office_props", "cornered_office_debris_plant", "hvt_debris_plant1", "hvt_debris_plant2", 1, "hvt_office_explosion");
  thread maps\cornered_code::generic_prop_raven_anim(level.hvt_office_anim_struct, "office_props", "cornered_office_debris_couch", "hvt_office_debris_couch1", "hvt_office_debris_couch2", 1, "hvt_office_explosion");
  var_0 = getent("hvt_office_debris_chair", "targetname");
  var_1 = getent("hvt_office_debris_chair_clip", "targetname");
  var_1 linkto(var_0);
  var_2 = getent("hvt_office_debris_chair2", "targetname");
  var_3 = getent("hvt_office_debris_chair_clip2", "targetname");
  var_3 linkto(var_2);
  var_4 = getent("hvt_office_debris_couch1", "targetname");
  var_5 = getent("hvt_office_debris_couch1_clip", "targetname");
  var_5 linkto(var_4);
  var_6 = getEntArray("hvt_office_debris_couch1_cushions", "targetname");

  foreach(var_8 in var_6) {
  var_8 linkto(var_4);
  }

  var_10 = getent("hvt_office_debris_couch2", "targetname");
  var_11 = getent("hvt_office_debris_couch2_clip", "targetname");
  var_11 linkto(var_10);
  var_12 = getEntArray("hvt_office_debris_couch2_cushions", "targetname");

  foreach(var_8 in var_12) {
  var_8 linkto(var_10);
  }

  var_15 = getent("hvt_debris_plant1", "targetname");
  var_16 = getent("hvt_debris_plant2", "targetname");
  thread hvt_office_chair();
  var_17 = maps\_utility::spawn_anim_model("rescue_lights", level.hvt_office_anim_struct.origin);
  var_18 = maps\_utility::spawn_anim_model("rescue_lights", level.hvt_office_anim_struct.origin);
  var_19 = maps\_utility::spawn_anim_model("rescue_lights", level.hvt_office_anim_struct.origin);
  var_20 = maps\_utility::spawn_anim_model("rescue_lights", level.hvt_office_anim_struct.origin);
  var_21 = maps\_utility::spawn_anim_model("rescue_lights", level.hvt_office_anim_struct.origin);
  var_17 thread office_light("light1", "office", level.hvt_office_anim_struct, "hvt_office_explosion");
  var_18 thread office_light("light2", "office", level.hvt_office_anim_struct, "hvt_office_explosion");
  var_19 thread office_light("light3", "office", level.hvt_office_anim_struct, "hvt_office_explosion");
  var_20 thread office_light("light4", "office", level.hvt_office_anim_struct, "hvt_office_explosion");
  var_21 thread office_light("light5", "office", level.hvt_office_anim_struct, "hvt_office_explosion");
  var_22 = maps\_utility::spawn_anim_model("office_briefcase", level.hvt_office_anim_struct.origin);
  level.hvt_office_anim_struct maps\_anim::anim_first_frame_solo(var_22, "cornered_office_prop_briefcase_enter");
  common_scripts\utility::flag_wait("hvt_office_rorke_entry");
  level.hvt_office_anim_struct maps\_anim::anim_single_solo(var_22, "cornered_office_prop_briefcase_enter");
  var_22 delete();
  common_scripts\utility::flag_wait("hvt_office_explosion");
  var_23 = getent("hvt_debris_plant1_clip", "targetname");
  var_23 delete();
  var_24 = getent("hvt_debris_plant2_clip", "targetname");
  var_24 delete();
}

hvt_office_chair() {
  var_0 = getent("hvt_office_chair", "targetname");
  var_1 = getent("hvt_chair_clip", "targetname");
  var_2 = maps\_utility::spawn_anim_model("office_props");
  var_1 linkto(var_0);
  level.hvt_office_anim_struct maps\_anim::anim_first_frame_solo(var_2, "cornered_office_prop_chair_enter");
  var_3 = var_2 gettagorigin("J_prop_1");
  var_4 = var_2 gettagangles("J_prop_1");
  common_scripts\utility::waitframe();
  var_0.origin = var_3;
  var_0.angles = var_4;
  common_scripts\utility::waitframe();
  var_0 linkto(var_2, "J_prop_1");
  common_scripts\utility::flag_wait("hvt_office_rorke_entry");
  level.hvt_office_anim_struct maps\_anim::anim_single_solo(var_2, "cornered_office_prop_chair_enter");
  var_0 unlink();
  common_scripts\utility::waitframe();
  var_2 delete();
}

hvt_office_doors() {
  thread maps\cornered_code::generic_prop_raven_anim(level.hvt_office_anim_struct, "office_props", "cornered_office_prop_door_a", "hvt_office_entry_door_left", undefined, 1, "hvt_office_breach");
  thread maps\cornered_code::generic_prop_raven_anim(level.hvt_office_anim_struct, "office_props", "cornered_office_prop_door_b", "hvt_exit_door_lf", "hvt_exit_door_rt", 1, "hvt_office_rorke_entry");
  thread maps\cornered_code::generic_prop_raven_anim(level.hvt_office_anim_struct, "stairwell_door", "cnd_stair_escape_prop_doors", "stairwell_exit_door_left", "stairwell_exit_door_right", 1, "open_stairwell_doors");
  var_0 = getent("hvt_exit_door_rt", "targetname");
  var_1 = getent("hvt_exit_door_lf", "targetname");
  common_scripts\utility::flag_wait("hvt_office_rorke_entry");
  wait 1;
  var_0 connectpaths();
  var_1 connectpaths();
  common_scripts\utility::flag_wait("open_stairwell_doors");
  var_2 = getent("stairwell_exit_door_clip", "targetname");
  thread maps\cornered_audio::aud_hvt("exit");
  wait 0.3;
  var_2 notsolid();
  var_2 connectpaths();
  wait 0.3;
  var_2 delete();
}

hvt_office_environment() {
  common_scripts\utility::exploder(7751);
  setsaveddvar("phys_gravityChangeWakeupRadius", 4000);
  level.player playrumbleonentity("heavy_3s");
  earthquake(0.5, 4, level.player.origin, 2500);
  level thread lobby_and_stair_fx();
  var_0 = common_scripts\utility::getstructarray("hvt_office_phys", "targetname");

  foreach(var_2 in var_0) {
  physicsjitter(var_2.origin, 300, 200, 1.0, 1.0);
  }

  var_4 = getEntArray("hvt_office_junk", "targetname");

  foreach(var_2 in var_4) {
  var_2 physicslaunchclient(var_2.origin + (0, 0, -4), (0, -15, 60));
  }

  wait 2.0;
  earthquake(0.14, 8, level.player.origin, 2500);
  wait 8.0;
  level thread random_building_shake_loop(0.1, 3.0, 7.0, 1.0);
}

hvt_office_briefcase() {
  var_0 = getent("briefcase_trigger", "targetname");
  var_0 sethintstring(&"CORNERED_PICK_UP_BRIEFCASE_HINT");
  var_1 = common_scripts\utility::getstruct("briefcase_look", "targetname");
  var_0 common_scripts\utility::trigger_off();
  common_scripts\utility::flag_wait("player_can_use_briefcase");
  var_0 common_scripts\utility::trigger_on();
  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_0, var_1, cos(40), 0, 1);
  common_scripts\utility::flag_set("player_used_briefcase");
}

stairwell_handler() {
  level.allies[level.const_rorke] thread stairwell_rorke();
  level.allies[level.const_baker] thread stairwell_baker();
  thread stairwell_office_vo();
  thread office_enemy_setup();
  thread maps\cornered_fx::fx_screen_water_sheeting("stairwell_water_sheet", "lobby_shake");
  level.default_sprint = getdvar("player_sprintSpeedScale");
  setsaveddvar("player_sprintSpeedScale", 1.2);
  common_scripts\utility::flag_wait("stairwell_shake_1");
  level notify("done_random_shaking");
  level.player shellshock("cornered_stairwell", 1.5);
  level.player pushplayervector((0, -25, 0));
  level.player setmovespeedscale(0.4);
  level.player viewkick(64, level.player.origin);
  common_scripts\utility::exploder(7651);
  maps\cornered_audio::aud_hvt_destruct01();
  thread maps\cornered_lighting::stairwell_light(16);
  level.player playrumbleonentity("heavy_2s");
  earthquake(0.25, 2, level.player.origin, 2500);
  level thread lobby_and_stair_fx();
  wait 0.25;
  level.player pushplayervector((0, 0, 0));
  wait 1.75;
  level.player maps\_utility::blend_movespeedscale(1.0, 2.5);
  thread maps\cornered_lighting::stairwell_light(2);
  common_scripts\utility::flag_wait("stairwell_shake_2");
  level notify("done_random_shaking");
  maps\cornered_audio::aud_hvt_destruct02();
  maps\cornered_audio::aud_collapse("lobby");
  level.player shellshock("cornered_stairwell", 1.0);
  level.player pushplayervector((0, -25, 0));
  thread maps\cornered_lighting::stairwell_light(18);
  level.player playrumbleonentity("light_3s");
  earthquake(0.15, 2, level.player.origin, 2500);
  level thread lobby_and_stair_fx();
  wait 0.25;
  level.player pushplayervector((0, 0, 0));
  wait 1.75;
  level thread random_building_shake_loop(0.1, 3.0, 7.0, 1.0);
  thread maps\cornered_lighting::stairwell_light(2);
  common_scripts\utility::flag_wait("stairwell_shake_3");
  level notify("done_random_shaking");
  thread maps\cornered_lighting::stairwell_light(12);
  level.player playrumbleonentity("heavy_3s");
  earthquake(0.25, 3, level.player.origin, 2500);
  level thread lobby_and_stair_fx();
  wait 3.0;
  level thread random_building_shake_loop(0.1, 3.0, 7.0, 1.0);
  thread maps\cornered_lighting::stairwell_light(2);
}

stairwell_cracks() {
  thread stairwell_crack_flat("a");
  thread stairwell_crack_flat("c", 0.3);
}

stairwell_crack_flat(var_0, var_1) {
  var_2 = getent("stairwell_crack_decal_1" + var_0, "targetname");
  var_3 = getent("stairwell_crack_decal_2" + var_0, "targetname");
  var_4 = getent("stairwell_crack_decal_3" + var_0, "targetname");
  var_5 = getent("stairwell_crack_decal_4" + var_0, "targetname");
  var_2 hide();
  var_3 hide();
  var_4 hide();
  var_5 hide();
  common_scripts\utility::flag_wait("stairwell_shake_1");

  if(isDefined(var_1)) {
    wait(var_1);
  }

  var_2 show();
  wait 0.15;
  var_3 show();
  wait 0.15;
  var_4 show();
  wait 0.15;
  var_5 show();
  common_scripts\utility::flag_wait("found_hvt");
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
}

stairwell_pipes() {
  var_0 = getent("stair_pipe_left", "targetname");
  var_1 = getent("stair_pipe_right1", "targetname");
  var_2 = getent("stair_pipe_right2", "targetname");
  var_3 = getent("stair_pipe_right3", "targetname");
  var_2 linkto(var_1);
  var_3 linkto(var_1);
  common_scripts\utility::waitframe();
  var_4 = maps\_utility::spawn_anim_model("stairwell_pipe");
  level.hvt_office_anim_struct maps\_anim::anim_first_frame_solo(var_4, "cnd_stair_escape_prop_pipe");
  var_5 = var_4 gettagorigin("J_prop_1");
  var_6 = var_4 gettagangles("J_prop_1");
  var_7 = var_4 gettagorigin("J_prop_2");
  var_8 = var_4 gettagangles("J_prop_2");
  var_1.origin = var_5;
  var_1.angles = var_6;
  var_0.origin = var_7;
  var_0.angles = var_8;
  var_0 linkto(var_4, "J_prop_2");
  var_1 linkto(var_4, "J_prop_1");
  common_scripts\utility::flag_wait("stairwell_shake_1");
  level.hvt_office_anim_struct thread maps\_anim::anim_single_solo(var_4, "cnd_stair_escape_prop_pipe");
  common_scripts\utility::exploder(8471);
  common_scripts\utility::flag_wait("stairwell_pipe_2");
  wait(randomfloatrange(0.5, 1.6));
  common_scripts\utility::exploder(8472);
  common_scripts\utility::flag_wait("allies_move_to_rescue");
  var_9 = getscriptablearray("scriptable_electric_a", "targetname");
  var_10 = getscriptablearray("scriptable_electric_b", "targetname");

  foreach(var_12 in var_9) {
    magicbullet("kriss", var_12.origin + (8, 0, 15), var_12.origin, level.player);
    magicbullet("kriss", var_12.origin + (8, 0, 15), var_12.origin, level.player);
    common_scripts\utility::waitframe();
    magicbullet("kriss", var_12.origin + (8, 0, 15), var_12.origin, level.player);
    magicbullet("kriss", var_12.origin + (8, 0, 15), var_12.origin, level.player);
  }

  common_scripts\utility::flag_wait("trigger_stair_hall_vol_2");

  foreach(var_12 in var_10) {
    magicbullet("kriss", var_12.origin + (-8, 0, 15), var_12.origin, level.player);
    magicbullet("kriss", var_12.origin + (-8, 0, 15), var_12.origin, level.player);
    common_scripts\utility::waitframe();
    magicbullet("kriss", var_12.origin + (-8, 0, 15), var_12.origin, level.player);
    magicbullet("kriss", var_12.origin + (-8, 0, 15), var_12.origin, level.player);
  }
}

stairwell_rorke() {
  level endon("stop_stairwell_rorke");
  maps\_utility::disable_cqbwalk();
  maps\_utility::disable_surprise();
  self.ignoreall = 1;
  self.baseaccuracy = 500000;
  self.goalradius = 16;
  self.alertlevel = "alert";
  level.hvt_office_anim_struct thread maps\_anim::anim_single_solo(self, "cornered_stairs");
  self waittillmatch("single anim", "doors");
  common_scripts\utility::flag_set("open_stairwell_doors");
  self waittillmatch("single anim", "explosion");
  common_scripts\utility::flag_set("stairwell_shake_1");
  self waittillmatch("single anim", "end");
  maps\_utility::set_moveplaybackrate(1.15);
  var_0 = getnode("stairwell_teleport_rorke", "targetname");
  level.allies[level.const_rorke] setgoalnode(var_0);
  common_scripts\utility::flag_wait("allies_move_to_rescue");
  common_scripts\utility::flag_set("stairwell_shake_3");
  var_1 = getnode("hall_post_stumble_rorke", "targetname");
  level.allies[level.const_rorke] setgoalnode(var_1);
  level.allies[level.const_rorke] waittill("goal");
  maps\_utility::set_moveplaybackrate(1.0);
  common_scripts\utility::flag_set("rorke_ready_for_office_shake");
}

stairwell_baker() {
  level endon("stop_stairwell_baker");
  maps\_utility::disable_cqbwalk();
  maps\_utility::disable_surprise();
  self.disablearrivals = 1;
  self.baseaccuracy = 500000;
  self.goalradius = 16;
  self.ignoreall = 1;
  self.alertlevel = "alert";
  level.hvt_office_anim_struct thread maps\_anim::anim_single_solo(self, "cornered_stairs");
  wait 9.7;
  self waittillmatch("single anim", "end");
  var_0 = getent("stair_baker_dont_stop", "targetname");

  if(level.player istouching(var_0)) {
    level.hvt_office_anim_struct maps\_anim::anim_single_solo(self, "cornered_stairs_run");
  }
  else {
    level.hvt_office_anim_struct maps\_anim::anim_single_solo(self, "cornered_stairs_wait");

    if(!common_scripts\utility::flag("allies_move_to_rescue")) {
      level.hvt_office_anim_struct thread maps\_anim::anim_loop_solo(self, "cornered_stairs_wait_loop", "stop_loop");
    }

    common_scripts\utility::flag_wait("allies_move_to_rescue");
    level.hvt_office_anim_struct notify("stop_loop");
    self stopanimscripted();
  }

  if(!common_scripts\utility::flag("allies_move_to_rescue")) {
    var_1 = getnode("hall_post_stumble_baker", "targetname");
    level.allies[level.const_baker] setgoalnode(var_1);
  }

  level.rescue_anim_struct maps\_anim::anim_reach_solo(level.allies[level.const_baker], "cornered_office_shift");
  common_scripts\utility::flag_set("baker_ready_for_office_shake");
}

stairwell_office_vo() {
  wait 0.75;
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_oraclemissionis");
  maps\_utility::smart_radio_dialogue("cornered_orc_copyblackknightprepping");
  common_scripts\utility::flag_wait("trigger_stair_hall_vol_2");
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_weneedtofind");
}

office_enemy_setup() {
  common_scripts\utility::flag_wait("stairwell_shake_1");
  maps\_utility::array_spawn_function_targetname("fall_office_runners", ::office_enemy);
  level.office_enemies = maps\_utility::array_spawn_targetname("fall_office_runners", 1);
}

office_enemy() {
  self endon("death");
  maps\_utility::disable_surprise();
  self.ignoreall = 1;
  self.grenadeammo = 0;
  self.health = 10;
  self.movespeedscale = 0.8;
  self.ignoreme = 1;
  var_0 = common_scripts\utility::getstruct(self.script_noteworthy, "targetname");
  thread office_enemy_die();
  common_scripts\utility::flag_wait("found_hvt");
  self.ignoreme = 0;
  maps\_utility::follow_path(var_0);
  self.goalradius = 16;
  self.ignoreall = 0;
  self.movespeedscale = 1.0;
  var_1 = [level.allies[level.const_baker], level.allies[level.const_rorke], level.player];
  self.favoriteenemy = var_1[randomint(var_1.size)];
}

office_enemy_die() {
  self endon("death");
  common_scripts\utility::flag_wait("rorke_ready_for_office_shake");
  wait 0.5;

  if(isalive(self)) {
    var_0 = common_scripts\utility::getstruct("office_bullet_1", "targetname");
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    var_2 = common_scripts\utility::getstruct("office_bullet_2", "targetname");
    var_3 = var_2 common_scripts\utility::spawn_tag_origin();

    if(!level.player islookingat(var_1)) {
      magicbullet("kriss", var_1.origin, self gettagorigin("tag_eye"));
      self kill();
    } else {
      magicbullet("kriss", var_3.origin, self gettagorigin("tag_eye"));
      self kill();
    }

    var_1 delete();
    var_3 delete();
  }
}

office_handler() {
  thread office_props();
  thread fall_props();
  thread fall_physics_debris_lobby();
  common_scripts\utility::flag_wait("found_hvt");
  level.allies[level.const_baker] thread office_teleport_allies();
  level.allies[level.const_rorke] thread office_teleport_allies();
  thread maps\_utility::autosave_by_name("post_explosion_office");
  maps\_utility::battlechatter_off("axis");
  maps\_utility::battlechatter_off("allies");
  common_scripts\utility::flag_wait_all("rorke_ready_for_office_shake", "baker_ready_for_office_shake");
  common_scripts\utility::array_thread(level.allies, maps\_utility::set_baseaccuracy, 1);
  thread office_ally_anims();
  thread office_vo();
  common_scripts\utility::flag_set("office_ally_anims_starting");
  common_scripts\utility::flag_wait("office_explosion");
  common_scripts\utility::exploder(7651);
  thread maps\cornered_audio::aud_collapse("building");
  common_scripts\utility::exploder(88);
}

office_teleport_allies() {
  var_0 = getent("stairwell_teleport_check", "targetname");
  var_1 = getnode("stairwell_teleport_" + self.animname, "targetname");
  var_2 = getent("player_look_at_office", "targetname");
  var_3 = vectornormalize(level.player.origin - self.origin);
  var_4 = anglesToForward(self.angles);

  if(self istouching(var_0) && vectordot(var_3, var_4) <= -0.25) {
    if(self == level.allies[level.const_baker]) {
      var_5 = getnode("hall_post_stumble_baker", "targetname");
      level notify("stop_stairwell_baker");
      self stopanimscripted();
      self clearenemy();
      maps\_utility::teleport_ai(var_1);
      self.goalradius = 16;
      self setgoalnode(var_5);
      self waittill("goal");
      common_scripts\utility::flag_set("baker_ready_for_office_shake");
    }

    if(self == level.allies[level.const_rorke]) {
      var_5 = getnode("hall_post_stumble_rorke", "targetname");
      level notify("stop_stairwell_rorke");
      self stopanimscripted();
      self clearenemy();
      maps\_utility::teleport_ai(var_1);
      self.goalradius = 16;
      self setgoalnode(var_5);
      self waittill("goal");
      common_scripts\utility::flag_set("rorke_ready_for_office_shake");
    }
  }
}

office_ally_anims() {
  var_0 = [];
  var_0[0] = level.allies[level.const_baker];
  var_0[1] = level.allies[level.const_rorke];
  level.rescue_anim_struct thread maps\_anim::anim_single(var_0, "cornered_office_shift");
  wait 2.7;
  common_scripts\utility::flag_set("office_explosion");
  var_0[1] waittillmatch("single anim", "end");
  common_scripts\utility::flag_set("stairwell_finished");
}

office_vo() {
  wait 3.75;
  level.allies[level.const_baker] maps\_utility::smart_dialogue("cornered_hsh_windowsahead");
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_copywecanjump");
}

office_props() {
  var_0 = getent("office_shift_chair_clip", "targetname");
  var_1 = getent("office_shift_chair", "targetname");
  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;
  var_0 linkto(var_1);
  thread maps\cornered_code::generic_prop_raven_anim(level.rescue_anim_struct, "office_shift_chair", "cornered_office_shift_chair", "office_shift_chair", undefined, 1, "office_ally_anims_starting");
  var_2 = maps\_utility::spawn_anim_model("rescue_lights", level.rescue_anim_struct.origin);
  var_3 = maps\_utility::spawn_anim_model("rescue_lights", level.rescue_anim_struct.origin);
  var_4 = maps\_utility::spawn_anim_model("rescue_lights", level.rescue_anim_struct.origin);
  var_5 = maps\_utility::spawn_anim_model("rescue_lights", level.rescue_anim_struct.origin);
  var_6 = maps\_utility::spawn_anim_model("rescue_lights", level.rescue_anim_struct.origin);
  var_7 = maps\_utility::spawn_anim_model("rescue_lights", level.rescue_anim_struct.origin);
  var_8 = maps\_utility::spawn_anim_model("rescue_lights", level.rescue_anim_struct.origin);
  var_2 thread office_light("light1", "rescue", level.rescue_anim_struct, "office_explosion");
  var_3 thread office_light("light2", "rescue", level.rescue_anim_struct, "office_explosion");
  var_4 thread office_light("light3", "rescue", level.rescue_anim_struct, "office_explosion");
  var_5 thread office_light("light4", "rescue", level.rescue_anim_struct, "office_explosion");
  var_6 thread office_light("light5", "rescue", level.rescue_anim_struct, "office_explosion");
  var_7 thread office_light("light6", "rescue", level.rescue_anim_struct, "office_explosion");
  var_8 thread office_light("light7", "rescue", level.rescue_anim_struct, "office_explosion");
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_wait("office_explosion");
  setphysicsgravitydir((0, -0.02, -0.03));
  var_9 = getEntArray("office_debris", "targetname");
  var_10 = common_scripts\utility::getstructarray("office_phys", "targetname");

  foreach(var_12 in var_9) {
    var_12 physicslaunchclient(var_12.origin + (0, 0, -6), (0, -0.05, 0.02));
    var_12 thread maps\cornered_code::debris_remove_after_time(25.0);
  }

  foreach(var_12 in var_10) {
  var_12 thread office_jitter();
  }
}

office_jitter() {
  for(var_0 = 0; var_0 < 20; var_0++) {
    physicsjitter(self.origin, 400, 300, 2.0, 3.0);
    wait 0.2;
  }
}

office_light(var_0, var_1, var_2, var_3) {
  var_4 = getent(var_0 + "_bar_" + var_1, "targetname");
  var_5 = getent(var_0 + "_shade_" + var_1, "targetname");
  var_6 = getent(var_0 + "_bulb_" + var_1, "targetname");
  var_2 maps\_anim::anim_first_frame_solo(self, "cornered_rescue_" + var_0);
  var_4 linkto(self, "J_prop_1");
  var_5 linkto(self, "J_prop_2");
  var_6 linkto(var_5);
  common_scripts\utility::flag_wait(var_3);
  var_2 maps\_anim::anim_single_solo(self, "cornered_rescue_" + var_0);
  var_2 thread maps\_anim::anim_loop_solo(self, "cornered_rescue_" + var_0 + "_loop", "stop_light_loop");
  common_scripts\utility::flag_wait_all("lobby_shake", "lobby_rorke_ready");
  var_2 notify("stop_light_loop");
  common_scripts\utility::waitframe();
  self delete();
  var_4 delete();
  var_5 delete();
  var_6 delete();
}

office_door_to_lobby() {
  var_0 = getent("door_to_lobby", "targetname");
  var_1 = getent("lobby_door_player_clip", "targetname");
  var_2 = getEntArray("door_to_lobby_handles", "targetname");

  foreach(var_4 in var_2) {
  var_4 linkto(var_0);
  }

  var_6 = maps\_utility::spawn_anim_model("exfil_bldg");
  level.fall_anim_struct maps\_anim::anim_first_frame_solo(var_6, "cornered_building_fall_lobby_door");
  var_0 linkto(var_6, "j_prop_1");
  common_scripts\utility::flag_wait("open_lobby_door");
  level.fall_anim_struct thread maps\_anim::anim_single_solo(var_6, "cornered_building_fall_lobby_door");
  wait 1;
  var_1 delete();
  var_0 connectpaths();
  var_6 waittillmatch("single anim", "end");
  var_0 unlink();
  var_6 delete();
}

fall_handler() {
  level.fall_anim_struct = common_scripts\utility::getstruct("fall_animnode", "targetname");
  level.allies[level.const_rorke] thread fall_allies_rorke();
  level.allies[level.const_baker] thread fall_allies_baker();
  thread fall_physics_debris_entry_stairs();
  thread fall_prop_picture();
  thread fall_prop_merrick_window();
  thread office_door_to_lobby();
  thread fall_environment();
  thread fall_vo();
  common_scripts\utility::flag_wait_all("lobby_shake", "lobby_rorke_ready");
  thread fall_player();
  thread fall_enemies_start();
}

fall_environment() {
  common_scripts\utility::flag_wait("lobby_stairwell_shake");
  level notify("done_random_shaking");
  thread maps\cornered_audio::aud_collapse("stumble");
  common_scripts\utility::exploder(3023);
  maps\_utility::stop_exploder(22);
  maps\_utility::stop_exploder(8471);
  screenshake(level.player.origin, 0.5, 0.5, 0.25, 2.0, 0, 0.5, 500, 8, 8, 2);
  level.player playrumbleonentity("light_2s");
  level.player maps\_utility::blend_movespeedscale(0.5, 0.5);
  level.player shellshock("cornered_horizontal_start", 2);
  level thread lobby_and_stair_fx();
  wait 2.0;
  level thread random_building_shake_loop(0.1, 2.0, 7.0, 1.0);
  common_scripts\utility::flag_wait_all("lobby_shake", "lobby_rorke_ready");
  common_scripts\utility::exploder(3122);
  common_scripts\utility::exploder(3004);
  thread maps\cornered_audio::aud_collapse("crack");
  maps\_utility::music_stop(2);
  level notify("done_random_shaking");
  common_scripts\utility::waitframe();
  level.player shellshock("cornered_horizontal_start", 1.5);
  level thread lobby_and_stair_fx();
  common_scripts\utility::flag_wait("fall_stagger_anim_done");
  screenshake(level.player.origin, 0.75, 0.5, 0.25, 3.0, 0, 0.5, 500, 8, 5, 2);
  wait 3.5;
  common_scripts\utility::exploder(8799);
  common_scripts\utility::flag_wait("fall_down_shake");
  screenshake(level.player.origin, 0.5, 0.5, 0.25, 4.75, 0, 1.5, 500, 8, 8, 2);
  level thread lobby_and_stair_fx();
  wait 5.75;
  level thread random_building_shake_loop(0.2, 0.5, 1.5, 0.0);
  common_scripts\utility::flag_wait("fall_rubble_shift");
  level notify("done_random_shaking");
  common_scripts\utility::waitframe();
  screenshake(level.player.origin, 0.5, 0.5, 0.25, 1.0, 0, 0.25, 500, 8, 8, 2);
  common_scripts\utility::flag_wait("go_building_fall");
  thread fall_fx_tile();
  common_scripts\utility::exploder(3001);
  common_scripts\utility::exploder(3747);
  wait 0.2;
  screenshake(level.player.origin, 0.35, 0.35, 0.15, 15.0, 0, 5.0, 500, 10, 10, 4);
  setphysicsgravitydir((0, -0.075, -0.04));
  common_scripts\utility::flag_wait("atrium_pillar_break");
  common_scripts\utility::exploder(3005);
  thread maps\cornered_audio::aud_collapse("pillar");
  wait 2.65;
  screenshake(level.player.origin, 0.75, 0.75, 0.25, 1.0, 0, 0.25, 500, 12, 12, 6);
  wait 1.65;
  screenshake(level.player.origin, 0.75, 0.75, 0.25, 1.0, 0, 0.25, 500, 12, 12, 6);
  common_scripts\utility::flag_wait("parachute_exfil");
  screenshake(level.player.origin, 1.5, 1.5, 0.25, 3.0, 0, 2.0, 500, 12, 12, 6);
}

fall_fx_crowd_setup() {
  var_0 = maps\_utility::get_exploder_array(3456);

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.fxid = var_2.v["fxid"];
    var_3.origin = var_2.v["origin"];
    var_3.angles = var_2.v["angles"];
    var_3 linkto(level.vista_pivot);
    thread fall_fx_crowd_fx(var_3);
  }
}

fall_fx_crowd_fx(var_0) {
  common_scripts\utility::flag_wait("fall_down_shake");
  playFXOnTag(level._effect[var_0.fxid], var_0, "tag_origin");
}

fall_fx_billboard_setup() {
  var_0 = maps\_utility::get_exploder_array(2727);

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.fxid = var_2.v["fxid"];
    var_3.origin = var_2.v["origin"];
    var_3.angles = var_2.v["angles"];
    var_3 linkto(level.vista_pivot);
    thread fall_fx_billboard_fx(var_3);
  }

  common_scripts\utility::flag_wait("parachute_exfil");
  common_scripts\utility::exploder(2727);
}

fall_fx_billboard_fx(var_0) {
  common_scripts\utility::flag_wait("fall_down_shake");
  playFXOnTag(level._effect[var_0.fxid], var_0, "tag_origin");
  common_scripts\utility::flag_wait("parachute_exfil");
  var_0 unlink();
  var_0 movez(-1000000, 0.05);
  killfxontag(level._effect[var_0.fxid], var_0, "tag_origin");
}

fall_fx_tile() {
  var_0 = common_scripts\utility::getstruct("test_tile1", "targetname");
  var_1 = common_scripts\utility::getstruct("test_tile2", "targetname");
  var_2 = common_scripts\utility::getstruct("test_tile3", "targetname");
  var_3 = common_scripts\utility::getstruct("test_tile4", "targetname");
  wait 6.85;
  playFX(level._effect["vfx_atrium_tile"], var_0.origin + (0, 0, 2), (0, 1, 0));
  wait 0.55;
  playFX(level._effect["vfx_atrium_tile"], var_1.origin + (0, 0, 2), (0, 1, 0));
  wait 0.55;
  playFX(level._effect["vfx_atrium_tile"], var_2.origin + (0, 0, 2), (0, 1, 0));
  wait 0.55;
  playFX(level._effect["vfx_atrium_tile"], var_3.origin + (0, 0, 2), (0, 1, 0));
}

fall_player() {
  level.player endon("death");
  level.fall_arms_and_legs = [];
  var_0 = maps\_utility::spawn_anim_model("player_bldg_fall");
  var_1 = maps\_utility::spawn_anim_model("player_bldg_fall_legs");
  var_0 hide();
  var_1 hide();
  level.fall_arms_and_legs[0] = var_0;
  level.fall_arms_and_legs[1] = var_1;
  level.player enableinvulnerability();
  level.player playerlinktoblend(var_0, "tag_player", 0.6);
  level.player playrumbleonentity("heavy_1s");
  clearallcorpses();
  level.fall_anim_struct maps\_anim::anim_single_solo(level.fall_arms_and_legs[0], "lobby_tumble_player");
  common_scripts\utility::flag_set("fall_stagger_anim_done");
  level.player unlink();
  level.player setmovespeedscale(0.4);
  level.player playrumbleonentity("light_3s");
  wait 3.0;
  common_scripts\utility::flag_set("fall_down_shake");
  thread watch_for_player_death();
  level.player playerlinktoblend(var_0, "tag_player", 0.5, 0.25);
  level.fall_anim_struct thread maps\_anim::anim_single(level.fall_arms_and_legs, "lobby_react_player");
  level.player playrumbleonentity("heavy_2s");
  var_0 show();
  var_1 show();
  level.player setviewkickscale(2.0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player setmovespeedscale(1);
  level.fall_arms_and_legs[0] waittillmatch("single anim", "sm_debris_a");
  common_scripts\utility::flag_set("go_sm_debris_a");
  wait 0.65;
  level.player viewkick(127, level.player.origin);
  setsaveddvar("hud_showStance", 0);
  common_scripts\utility::waitframe();
  level.player setviewkickscale(1);
  wait 0.85;
  wait 0.95;
  level.player playerlinktodelta(var_0, "tag_player", 0.5, 70, 70, 65, 40);
  level.fall_arms_and_legs[0] waittillmatch("single anim", "kick_view");
  level.player setviewkickscale(2.5);
  level.player playrumbleonentity("heavy_1s");
  common_scripts\utility::waitframe();
  var_2 = level.player getgunangles();

  if(var_2[0] < 10) {
    level.player viewkick(127, level.player.origin);
  }

  common_scripts\utility::waitframe();
  level.player setviewkickscale(1);
  var_0 waittillmatch("single anim", "end");
  common_scripts\utility::flag_set("player_is_slipping");
  level thread maps\cornered_code_slide::building_fall_anim_rig();
  common_scripts\utility::flag_set("fall_rubble_shift");
  level.player playrumbleonentity("heavy_2s");
  level.fall_path_rig waittillmatch("single anim", "original_start");
  common_scripts\utility::flag_set("go_building_fall");
  level notify("begin_atrium_fall");
  thread fall_enemies_slide();
  level.player playrumbleonentity("collapsing_building");
  level.player lerpviewangleclamp(0.75, 0.5, 0, 55, 70, 50, 50);
  level.player disableinvulnerability();
  level.fall_path_rig waittillmatch("single anim", "sm_debris_b");
  thread corpse_clear();
  thread maps\_utility::autosave_now_silent();
  common_scripts\utility::flag_set("go_sm_debris_b");
  level.fall_path_rig waittillmatch("single anim", "pillar_break");
  common_scripts\utility::flag_set("atrium_pillar_break");
  level.fall_path_rig waittillmatch("single anim", "start_floor");
  common_scripts\utility::flag_set("atrium_floor_break");
  level.fall_path_rig waittillmatch("single anim", "camera_to_front");
  level notify("fall_slide_ending");
  common_scripts\utility::flag_set("atrium_pre_rail_hit");
  level.player lerpviewangleclamp(1.8, 0, 0.5, 10, 10, 10, 10);
  thread fall_enemies_rail_hit();
  level.player disableoffhandweapons();
  wait 1.0;
  level.player disableweapons();
  setsaveddvar("ammoCounterHide", "1");
  thread maps\cornered_audio::aud_collapse("slow");
  level.fall_path_rig waittillmatch("single anim", "slomo_on");
  common_scripts\utility::flag_set("fall_rail_hit");
  thread fall_player_dof();
  level.player lerpfov(82, 1.5);
  thread fall_props_parachute();
  thread fall_props_player_parachute();
  level.player playrumbleonentity("heavy_1s");
  level thread lobby_and_stair_fx();
  level.player lerpviewangleclamp(0.5, 0, 0, 80, 80, 120, 120);
  setphysicsgravitydir((0, -0.7, -0.1));
  level.fall_path_rig waittillmatch("single anim", "slomo_on");

  if(maps\cornered_code::is_e3()) {
    thread maps\cornered_code::end_level();
  }

  level.fall_path_rig waittillmatch("single anim", "slomo_off");
  common_scripts\utility::flag_set("pre_glass_impact");
  level.player lerpviewangleclamp(0.5, 0, 0, 0, 0, 0, 0);
  physicsexplosionsphere(level.player.origin, 100, 64, 1);
  level.fall_path_rig waittillmatch("single anim", "spiderweb_glass");
  thread fall_glass_final_impact();
  physicsexplosionsphere(level.player.origin, 100, 64, 1);
  level.player playrumbleonentity("light_1s");
  level.fall_path_rig waittillmatch("single anim", "teleport_player");

  if(maps\cornered_code::is_e3()) {
    return;
  }
  maps\_hud_util::fade_out(0.05, "white");
  common_scripts\utility::flag_set("parachute_exfil");
  level.player lerpfov(65, 0.05);
  level.player setblurforplayer(5.0, 0.0);
  level.player playerlinktodelta(level.fall_arms_and_legs[0], "tag_player", 0.5, 0, 0, 0, 0);
  level.fall_anim_struct thread maps\_anim::anim_single_solo(level.fall_arms_and_legs[0], "cornered_exfil_player");

  if(maps\cornered_code::is_e3()) {
    return;
  }
  common_scripts\utility::flag_set("obj_escape_complete");
  wait 0.1;
  level.player thread parachute_hint();
  level.player thread parachute_input();
  maps\_hud_util::fade_in(0.25, "white");
  wait 0.4;
  level.player setblurforplayer(0.0, 0.5);
  level.fall_arms_and_legs[0] waittillmatch("single anim", "slow_on");
  common_scripts\utility::flag_set("exfil_slow_down");
  maps\_anim::anim_set_rate_single(level.fall_arms_and_legs[0], "cornered_exfil_player", 0.75);
  level.fall_arms_and_legs[0] waittillmatch("single anim", "fail");

  if(common_scripts\utility::flag("parachute_deployed")) {
    level.fall_arms_and_legs[0] waittillmatch("single anim", "slow_off");
    common_scripts\utility::flag_set("exfil_speed_up");
    maps\_anim::anim_set_rate_single(level.fall_arms_and_legs[0], "cornered_exfil_player", 1.0);
    thread common_scripts\utility::play_sound_in_space("crnd_parachute", level.player.origin);
    wait 3.35;
    level.player lerpviewangleclamp(0.5, 0, 0, 25, 25, 40, 40);
    var_3 = getanimlength(level.fall_arms_and_legs[0] maps\_utility::getanim("cornered_exfil_player"));
    wait(var_3 - 8.5);
    maps\_hud_util::fade_out(3.0);
    wait 4.0;
    maps\_utility::nextmission();
  } else {
    level.fall_anim_struct thread maps\_anim::anim_single_solo(level.fall_arms_and_legs[0], "cornered_exfil_fail_player");
    level.player lerpviewangleclamp(0.5, 0, 0, 0, 0, 0, 0);
    var_3 = getanimlength(level.fall_arms_and_legs[0] maps\_utility::getanim("cornered_exfil_fail_player"));
    wait(var_3 - 2.0);
    setdvar("ui_deadquote", &"CORNERED_PARACHUTE_FAIL");
    maps\_utility::missionfailedwrapper();
  }
}

watch_for_player_death() {
  level endon("atrium_pre_rail_hit");
  level.player waittill("death");

  foreach(var_1 in level.fall_arms_and_legs) {
  var_1 hide();
  }
}

parachute_hint() {
  self endon("parachute_deployed");
  maps\_utility::display_hint_timeout("chute_deploy", 0.75);
}

parachute_input() {
  self notifyonplayercommand("deployed_chute", "+activate");
  self notifyonplayercommand("deployed_chute", "+usereload");
  self waittill("deployed_chute");
  common_scripts\utility::flag_set("parachute_deployed");
}

parachute_break() {
  return common_scripts\utility::flag("parachute_deployed");
}

fall_player_dof() {
  maps\_art::dof_enable_script(1, 75, 4, 1000, 7000, 1.75, 0.1);
  common_scripts\utility::flag_wait("pre_glass_impact");
  maps\_art::dof_enable_script(1, 200, 5.5, 750, 7000, 0.06, 1);
  common_scripts\utility::flag_wait("parachute_exfil");
  maps\_art::dof_disable_script(0.75);
}

fall_allies_rorke() {
  maps\_utility::set_ignoreall(1);
  maps\_utility::set_ignoreme(1);
  maps\_utility::disable_arrivals();
  maps\_utility::pathrandompercent_zero();
  self pushplayer(1);
  maps\_utility::disable_pain();
  maps\_utility::disable_surprise();
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  level.fall_anim_struct thread maps\_anim::anim_single_solo(self, "enter_lobby");
  wait 0.5;
  maps\_anim::anim_set_rate_single(self, "enter_lobby", 1.2);
  self waittillmatch("single anim", "end");
  common_scripts\utility::flag_set("lobby_rorke_ready");

  if(!common_scripts\utility::flag("lobby_shake")) {
    level.fall_anim_struct thread maps\_anim::anim_loop_solo(self, "idle_lobby", "stop_lobby_idle");
  }

  common_scripts\utility::flag_wait("lobby_shake");
  level.fall_anim_struct notify("stop_lobby_idle");
  waittillframeend;
  level.fall_anim_struct maps\_anim::anim_single_solo(self, "cornered_building_fall_lobby_tumble_enter");
  level.fall_anim_struct thread maps\_anim::anim_loop_solo(self, "cornered_building_fall_lobby_tumble_idle", "stop_lobby_idle");
  common_scripts\utility::flag_wait("fall_down_shake");
  level.fall_anim_struct notify("stop_lobby_idle");
  waittillframeend;
  level.fall_anim_struct thread maps\_anim::anim_single_solo(self, "cornered_building_fall_lobby_tumble_exit");
  common_scripts\utility::flag_wait("player_is_slipping");
  level.fall_anim_struct thread maps\_anim::anim_single_solo(self, "allies_building_fall_slide");
  common_scripts\utility::flag_wait("parachute_exfil");
  maps\_utility::gun_remove();
  common_scripts\utility::exploder(4999);
  level.fall_anim_struct thread maps\_anim::anim_single_solo(self, "cornered_exfil_ally1");
  common_scripts\utility::flag_wait("exfil_slow_down");
  maps\_anim::anim_set_rate_single(self, "cornered_exfil_ally1", 0.75);
  common_scripts\utility::flag_wait("exfil_speed_up");
  maps\_anim::anim_set_rate_single(self, "cornered_exfil_ally1", 1.0);
  self waittillmatch("single anim", "end");
  maps\_utility::gun_recall();
  self.ignoreall = 1;
  self.ignoreme = 1;
}

fall_allies_baker() {
  maps\_utility::set_ignoreall(1);
  maps\_utility::set_ignoreme(1);
  maps\_utility::disable_arrivals();
  maps\_utility::pathrandompercent_zero();
  self pushplayer(1);
  maps\_utility::disable_pain();
  maps\_utility::disable_surprise();
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  thread fall_allies_baker_fall_down();
  level.fall_anim_struct thread maps\_anim::anim_single_solo(self, "enter_lobby");
  level endon("lobby_shake");
  wait 0.5;
  maps\_anim::anim_set_rate_single(self, "enter_lobby", 1.2);
  self waittillmatch("single anim", "end");
  level.fall_anim_struct maps\_anim::anim_reach_solo(self, "lobby_window_enter");
  level.fall_anim_struct thread maps\_anim::anim_single_solo(self, "lobby_window_enter");
  self waittillmatch("single anim", "end");
  level.fall_anim_struct thread maps\_anim::anim_loop_solo(self, "lobby_window_idle", "stop_lobby_idle");
}

fall_allies_baker_fall_down() {
  common_scripts\utility::flag_wait("lobby_shake");
  level.fall_anim_struct notify("stop_lobby_idle");
  waittillframeend;
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0 maps\_anim::anim_single_solo(self, "cornered_building_fall_lobby_tumble_enter");
  var_0 thread maps\_anim::anim_loop_solo(self, "cornered_building_fall_lobby_tumble_idle", "stop_lobby_idle");
  common_scripts\utility::flag_wait("parachute_exfil");
  maps\_utility::gun_remove();
  var_0 notify("stop_lobby_idle");
  level.fall_anim_struct thread maps\_anim::anim_single_solo(self, "cornered_exfil_ally2");
  common_scripts\utility::flag_wait("exfil_slow_down");
  maps\_anim::anim_set_rate_single(self, "cornered_exfil_ally2", 0.75);
  common_scripts\utility::flag_wait("exfil_speed_up");
  maps\_anim::anim_set_rate_single(self, "cornered_exfil_ally2", 1.0);
  self waittillmatch("single anim", "end");
  maps\_utility::gun_recall();
  self.ignoreall = 1;
  self.ignoreme = 1;
}

fall_vo() {
  wait 0.5;
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_gettothewindow");
  wait 2.5;
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_prepyourchutes");
  common_scripts\utility::flag_wait_all("lobby_shake", "lobby_rorke_ready");
  wait 1.5;
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_itsgoingdown");
  wait 0.75;
  level.allies[level.const_baker] maps\_utility::smart_dialogue("cornered_hsh_grabontosomething");
  common_scripts\utility::flag_wait("fall_down_shake");
  level.allies[level.const_baker] maps\_utility::smart_dialogue("cornered_hsh_watchout");
  common_scripts\utility::flag_wait("atrium_pre_rail_hit");
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_readyyourchutes");
  common_scripts\utility::flag_wait("parachute_exfil");
  wait 7;
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_mrk_oracleblackknightis");
  wait 1.5;
  level.allies[level.const_rorke] maps\_utility::smart_radio_dialogue("cornered_kgn_goodworkyoutwo");
}

fall_enemies_start() {
  var_0 = maps\_utility::array_spawn_function_targetname("lobby_enemies_stumbler_start", ::fall_enemy_self_anim);
  var_0 = maps\_utility::array_spawn_targetname("lobby_enemies_stumbler_start", 1);
  common_scripts\utility::flag_wait("fall_down_shake");
  thread fall_enemy_anim("lobby_enemy_a", "fall_enemy_a");
  thread fall_enemy_anim("lobby_enemy_b", "fall_enemy_b");
  thread fall_enemy_anim("lobby_enemy_c", "fall_enemy_c");
  thread fall_enemy_anim("lobby_enemy_d", "fall_enemy_d");
  thread fall_enemy_anim("lobby_enemy_e", "fall_enemy_e");
  thread fall_enemy_anim("lobby_enemy_f", "fall_enemy_f");
  var_1 = maps\_utility::array_spawn_function_targetname("lobby_railing_enemy", ::fall_enemy_self_anim);
  var_1 = maps\_utility::array_spawn_targetname("lobby_railing_enemy", 1);
}

fall_enemy_anim(var_0, var_1) {
  common_scripts\utility::flag_wait(var_1);
  maps\_utility::array_spawn_function_targetname(var_0, ::fall_enemy_node_anim, "fall_animnode");
  maps\_utility::array_spawn_targetname(var_0, 1);
}

fall_enemies_slide() {
  var_0 = maps\_utility::array_spawn_function_targetname("atrium_enemies_sliding_group", ::fall_enemy_node_anim, "fall_animnode");
  wait 1.25;
  wait 2.55;
  var_1 = maps\_utility::spawn_script_noteworthy("slide_enemy_h", 1);
  wait 0.25;
  var_2 = maps\_utility::spawn_script_noteworthy("slide_enemy_g", 1);
}

fall_enemies_rail_hit() {
  wait 2;
  var_0 = maps\_utility::array_spawn_function_noteworthy("atrium_enemies_slomo", ::fall_enemy_self_anim);
  var_1 = maps\_utility::spawn_targetname("atrium_enemies_slomo_1", 1);
  wait 0.2;
  var_2 = maps\_utility::spawn_targetname("atrium_enemies_slomo_2", 1);
  wait 0.1;
  var_3 = maps\_utility::spawn_targetname("atrium_enemies_slomo_3", 1);
  wait 0.1;
  var_4 = maps\_utility::spawn_targetname("atrium_enemies_slomo_4", 1);
}

fall_props() {
  var_0 = getEntArray("fallbeams", "targetname");
  maps\_utility::array_delete(var_0);
  thread fall_props_lobby_furniture();
  thread fall_props_debris_a();
  thread fall_props_debris_b();
  var_1 = getent("bldg_tilt_tables", "targetname");
  var_1.animname = "bldg_tilt_tables";
  var_1 maps\_anim::setanimtree();
  var_2 = getent("lobby_rubble", "targetname");
  var_2.animname = "bldg_shake_rubble";
  var_2 maps\_anim::setanimtree();
  var_3 = getent("lobby_hanging_light_1", "targetname");
  var_3.animname = "lobby_lights";
  var_3 maps\_anim::setanimtree();
  var_4 = getent("lobby_hanging_light_2", "targetname");
  var_4.animname = "lobby_lights";
  var_4 maps\_anim::setanimtree();
  var_5 = getent("falling_pillar_1", "targetname");
  var_5.animname = "bldg_tilt_pillar";
  var_5 maps\_anim::setanimtree();
  var_6 = getent("fall_floor_collapse", "targetname");
  var_6.animname = "bldg_tilt_floor";
  var_6 maps\_anim::setanimtree();
  var_7 = getEntArray("falling_lights", "targetname");
  common_scripts\utility::array_thread(var_7, ::fall_props_atrium_lights);
  thread fall_prop_corner_collapse();
  thread fall_props_ext_bldg();
  thread fall_props_ext_sign();
  wait 0.2;
  level.fall_anim_struct thread maps\_anim::anim_first_frame_solo(var_2, "cornered_building_fall_lobby_celling_debris");
  level.fall_anim_struct thread maps\_anim::anim_first_frame_solo(var_5, "cornered_building_fall_pillar_break");
  level.fall_anim_struct thread maps\_anim::anim_first_frame_solo(var_6, "cornered_building_fall_floor_collapse");
  level.fall_anim_struct thread maps\_anim::anim_first_frame_solo(var_1, "cornered_building_fall_debris");
  level.fall_anim_struct thread maps\_anim::anim_loop_solo(var_3, "cornered_building_fall_lobby_hanging_light_a", "stop_light_loop");
  level.fall_anim_struct thread maps\_anim::anim_loop_solo(var_4, "cornered_building_fall_lobby_hanging_light_b", "stop_light_loop");
  common_scripts\utility::flag_wait("lobby_stairwell_shake");
  common_scripts\utility::flag_wait_all("lobby_shake", "lobby_rorke_ready");
  level.fall_anim_struct notify("stop_light_loop");
  level.fall_anim_struct thread maps\_anim::anim_single_solo(var_3, "cornered_building_fall_lobby_hanging_light_exp_a");
  level.fall_anim_struct thread maps\_anim::anim_single_solo(var_4, "cornered_building_fall_lobby_hanging_light_exp_b");
  level.fall_anim_struct thread maps\_anim::anim_single_solo(var_1, "cornered_building_fall_debris");
  thread fall_break_glass();
  common_scripts\utility::flag_wait("fall_stagger_anim_done");
  level.fall_anim_struct thread maps\_anim::anim_single_solo(var_2, "cornered_building_fall_lobby_celling_debris");
  common_scripts\utility::flag_wait("player_is_slipping");
  level.fall_anim_struct thread maps\_anim::anim_single_solo(var_2, "cornered_building_fall_release_rubble");
  common_scripts\utility::flag_wait("atrium_pillar_break");
  level.fall_anim_struct thread maps\_anim::anim_single_solo(var_5, "cornered_building_fall_pillar_break");
  thread fall_props_pillar_rumble();
  common_scripts\utility::flag_wait("atrium_floor_break");
  level.fall_anim_struct thread maps\_anim::anim_single_solo(var_6, "cornered_building_fall_floor_collapse");
}

fall_props_debris_a() {
  var_0 = getent("bldg_tilt_debris_a", "targetname");
  var_0.animname = "bldg_tilt_debris_a";
  var_0 maps\_anim::setanimtree();
  var_1 = maps\_utility::spawn_anim_model("lobby_objects");
  var_2 = getEntArray("slide_debris", "targetname");
  level.fall_anim_struct thread maps\_anim::anim_first_frame_solo(var_0, "cornered_building_fall_debris");
  level.fall_anim_struct maps\_anim::anim_first_frame_solo(var_1, "cornered_building_fall_debris_office_a");

  foreach(var_4 in var_2) {
    var_5 = var_1 gettagorigin("J_prop_" + var_4.script_noteworthy);
    var_6 = var_1 gettagangles("J_prop_" + var_4.script_noteworthy);
    var_4.origin = var_5;
    var_4.angles = var_6;
    var_4 linkto(var_1, "J_prop_" + var_4.script_noteworthy);
  }

  common_scripts\utility::flag_wait("go_sm_debris_a");
  level.fall_anim_struct thread maps\_anim::anim_single_solo(var_0, "cornered_building_fall_debris");
  level.fall_anim_struct maps\_anim::anim_single_solo(var_1, "cornered_building_fall_debris_office_a");
  common_scripts\utility::waitframe();
  var_1 delete();
  maps\_utility::array_delete(var_2);
}

fall_props_debris_b() {
  var_0 = getent("bldg_tilt_debris_b", "targetname");
  var_0.animname = "bldg_tilt_debris_b";
  var_0 maps\_anim::setanimtree();
  wait 0.2;
  level.fall_anim_struct maps\_anim::anim_first_frame_solo(var_0, "cornered_building_fall_debris");
  common_scripts\utility::flag_wait("go_sm_debris_b");
  var_0 show();
  level.fall_anim_struct maps\_anim::anim_single_solo(var_0, "cornered_building_fall_debris");
}

fall_props_pillar_rumble() {
  wait 2.65;
  level.player playrumbleonentity("heavy_1s");
  wait 1.65;
  level.player playrumbleonentity("heavy_1s");
  level.player setblurforplayer(3.0, 0.05);
  wait 0.35;
  level.player setblurforplayer(0.0, 0.5);
}

fall_prop_picture() {
  var_0 = getent("lobby_tilting_picture", "targetname");
  var_0 maps\_utility::add_target_pivot();
  var_1 = var_0.pivot;
  var_2 = 18;
  var_3 = 18;
  var_4 = 0.75;
  var_5 = 0.75;

  if(isDefined(level.atrium_checkpoint)) {
    var_1 rotateroll(7, 0.05);
  }

  common_scripts\utility::flag_wait("lobby_stairwell_shake");

  for(var_6 = 0; var_6 < 13; var_6++) {
    var_1 rotateroll(var_3, var_5, var_5 * 0.333333, var_5 * 0.666667);
    wait(var_5);
    var_3 = -1 * var_2 + -1 * var_2 * var_4;
    var_2 = -1 * var_2 * var_4;
    var_5 = var_5 * 0.95;
  }
}

fall_props_lobby_furniture() {
  var_0 = maps\_utility::spawn_anim_model("lobby_objects");
  var_1 = getEntArray("lobby_furniture", "targetname");
  var_2 = common_scripts\utility::getstruct("fall_animnode", "targetname");
  var_2 maps\_anim::anim_first_frame_solo(var_0, "cornered_building_fall_lobby_furniture_a");

  foreach(var_4 in var_1) {
    var_5 = var_0 gettagorigin("J_prop_" + var_4.script_noteworthy);
    var_6 = var_0 gettagangles("J_prop_" + var_4.script_noteworthy);
    var_4.origin = var_5;
    var_4.angles = var_6;
    var_4 linkto(var_0, "J_prop_" + var_4.script_noteworthy);

    if(var_4.script_noteworthy == "6" || var_4.script_noteworthy == "11") {
      var_7 = getEntArray("pillows_" + var_4.script_noteworthy, "targetname");

      foreach(var_9 in var_7) {
      var_9 linkto(var_4);
      }
    }
  }

  common_scripts\utility::flag_wait("lobby_stairwell_shake");
  thread fall_physics_debris_furniture();
  var_2 thread maps\_anim::anim_single_solo(var_0, "cornered_building_fall_lobby_furniture_a");
  var_0 waittillmatch("single anim", "pause_a");
  maps\_anim::anim_set_rate_single(var_0, "cornered_building_fall_lobby_furniture_a", 0.0);
  common_scripts\utility::flag_wait_all("lobby_shake", "lobby_rorke_ready");
  maps\_anim::anim_set_rate_single(var_0, "cornered_building_fall_lobby_furniture_a", 1.0);
  var_0 waittillmatch("single anim", "pause_b");
  maps\_anim::anim_set_rate_single(var_0, "cornered_building_fall_lobby_furniture_a", 0.0);
  common_scripts\utility::flag_wait("fall_down_shake");
  maps\_anim::anim_set_rate_single(var_0, "cornered_building_fall_lobby_furniture_a", 1.0);
}

fall_prop_corner_collapse() {
  var_0 = common_scripts\utility::getstruct("fall_animnode", "targetname");
  var_1 = getEntArray("bldg_fall_corner_collapse", "targetname");

  foreach(var_3 in var_1) {
    var_3.animname = "bldg_tilt_corner";
    var_3 maps\_anim::setanimtree();
  }

  var_5 = getEntArray("bldg_fall_corner_collapse_glass1", "targetname");
  var_6 = getEntArray("bldg_fall_corner_collapse_glass2", "targetname");
  var_0 thread maps\_anim::anim_first_frame(var_1, "cornered_building_fall_corner_collapse");
  common_scripts\utility::flag_wait("go_building_fall");
  wait 0.75;
  var_0 thread maps\_anim::anim_single(var_1, "cornered_building_fall_corner_collapse");
  var_1[0] waittillmatch("single anim", "shatter_1");

  foreach(var_3 in var_5) {
  var_3 delete();
  }

  var_9 = getglassarray("glass_level_1");

  foreach(var_3 in var_9) {
  destroyglass(var_3);
  }

  var_12 = getent("corner_beam", "targetname");
  var_12 delete();
  wait 0.7;

  foreach(var_3 in var_9) {
  deleteglass(var_3);
  }

  var_1[0] waittillmatch("single anim", "shatter_2");

  foreach(var_3 in var_6) {
  var_3 delete();
  }

  var_17 = getglassarray("glass_level_2");

  foreach(var_3 in var_17) {
  destroyglass(var_3);
  }

  wait 0.7;

  foreach(var_3 in var_17) {
  deleteglass(var_3);
  }
}

fall_props_atrium_lights() {
  var_0 = common_scripts\utility::getstruct("fall_animnode", "targetname");
  self.animname = "bldg_tilt_light";
  maps\_anim::setanimtree();
  var_0 thread maps\_anim::anim_loop_solo(self, "cornered_building_fall_idle_hanging_light_" + self.script_noteworthy, "stop_swaying_loop");
  common_scripts\utility::flag_wait("go_building_fall");
  var_0 notify("stop_swaying_loop");
  waittillframeend;
  var_0 thread maps\_anim::anim_single_solo(self, "cornered_building_fall_slide_hanging_light_" + self.script_noteworthy);
}

fall_prop_merrick_window() {
  var_0 = getent("merrick_glass_pane", "targetname");
  var_1 = getent("merrick_glass_pane_distress", "targetname");
  var_2 = getent("merrick_glass_pane_broken", "targetname");
  var_1 hide();
  var_2 hide();
  common_scripts\utility::flag_wait("player_is_slipping");
  wait 14.43;
  var_0 delete();
  var_1 show();
  wait 0.2;
  var_1 delete();
  var_2 show();
}

fall_props_parachute() {
  var_0 = common_scripts\utility::getstruct("fall_animnode", "targetname");
  var_1 = [];
  var_1[0] = maps\_utility::spawn_anim_model("exfil_chute_1");
  var_1[1] = maps\_utility::spawn_anim_model("exfil_chute_2");
  var_0 maps\_anim::anim_first_frame(var_1, "cornered_exfil");

  foreach(var_3 in var_1) {
  var_3 hide();
  }

  common_scripts\utility::flag_wait("parachute_exfil");
  var_0 thread maps\_anim::anim_single(var_1, "cornered_exfil");
  var_1[1] show();
  common_scripts\utility::flag_wait("exfil_slow_down");
  maps\_anim::anim_set_rate(var_1, "cornered_exfil", 0.75);
  common_scripts\utility::flag_wait("show_ally_chute");
  var_1[0] show();
  common_scripts\utility::flag_wait("exfil_speed_up");
  maps\_anim::anim_set_rate(var_1, "cornered_exfil", 1.0);
}

fall_props_player_parachute() {
  var_0 = common_scripts\utility::getstruct("fall_animnode", "targetname");
  var_1 = [];
  var_1[0] = maps\_utility::spawn_anim_model("exfil_ripcord_player");
  var_1[1] = maps\_utility::spawn_anim_model("exfil_chute_player");
  var_0 maps\_anim::anim_first_frame(var_1, "cornered_exfil");
  var_1[1] hide();
  common_scripts\utility::flag_wait("parachute_exfil");
  var_0 thread maps\_anim::anim_single(var_1, "cornered_exfil");
  common_scripts\utility::flag_wait("exfil_slow_down");
  maps\_anim::anim_set_rate(var_1, "cornered_exfil", 0.75);
  common_scripts\utility::flag_wait("exfil_speed_up");
  maps\_anim::anim_set_rate(var_1, "cornered_exfil", 1.0);
  common_scripts\utility::flag_wait("show_player_chute");
  var_1[1] show();
}

fall_props_ext_bldg() {
  var_0 = getEntArray("end_broken_bldg", "targetname");
  var_0[0] thread fall_fx_end_bldg();
  var_1 = maps\_utility::spawn_anim_model("exfil_bldg");
  var_2 = common_scripts\utility::getstruct("fall_animnode", "targetname");
  var_2 maps\_anim::anim_first_frame_solo(var_1, "cornered_exfil_building_and_sign");
  var_3 = var_1 gettagorigin("J_prop_1");
  var_4 = var_1 gettagangles("J_prop_1");
  common_scripts\utility::waitframe();

  foreach(var_6 in var_0) {
  var_6 linkto(var_1, "J_prop_1");
  }

  common_scripts\utility::flag_wait("go_exfil_bldg");
  var_2 maps\_anim::anim_single_solo(var_1, "cornered_exfil_building_and_sign");
}

fall_props_ext_sign() {
  var_0 = getent("fall_tiran_sign", "script_noteworthy");
  var_0.animname = "exfil_sign";
  var_0 maps\_anim::setanimtree();
  var_1 = common_scripts\utility::getstruct("fall_animnode", "targetname");
  common_scripts\utility::flag_wait("go_exfil_bldg");
  var_1 maps\_anim::anim_single_solo(var_0, "cornered_exfil_sign");
}

fall_fx_end_bldg() {
  var_0 = maps\_utility::get_exploder_array(3999);

  foreach(var_2 in var_0) {
    if(issubstr(var_2.v["fxid"], "falling_debris_card") || issubstr(var_2.v["fxid"], "vfx_debris_fall_exfil_2")) {
      var_3 = common_scripts\utility::spawn_tag_origin();
      var_3.fxid = var_2.v["fxid"];
      var_3.origin = var_2.v["origin"];
      var_3.angles = var_2.v["angles"];
      var_3 linkto(self);
      thread fall_fx_bldg_fx(var_3);
    }
  }
}

fall_fx_bldg_fx(var_0) {
  common_scripts\utility::flag_wait("atrium_pre_rail_hit");
  playFXOnTag(level._effect[var_0.fxid], var_0, "tag_origin");
}

fall_break_glass() {
  wait 1.25;
  var_0 = getglassarray("lobby_atrium_glass");

  foreach(var_2 in var_0) {
  thread fall_break_glass_with_delay(var_2, 0.05, 0.06, 0, 1, 0.1);
  }

  var_4 = getglassarray("lobby_atrium_glass_doors");
  var_5 = getEntArray("atrium_door_handles", "targetname");
  maps\_utility::array_delete(var_5);

  foreach(var_2 in var_4) {
  thread fall_break_glass_with_delay(var_2, 0.05, 0.06, 0, 1, 0);
  }

  common_scripts\utility::flag_wait("fall_down_shake");
  wait 1.6;

  foreach(var_2 in var_4) {
  deleteglass(var_2);
  }
}

fall_break_glass_with_delay(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait(randomfloatrange(var_1, var_2));
  destroyglass(var_0, (var_3, var_4, var_5));
}

fall_glass_final_impact() {
  var_0 = getglass("atrium_fall_glass");
  var_1 = getent("atrium_fall_glass_clip", "targetname");
  destroyglass(var_0);
  var_1 delete();
}

fall_physics_debris_entry_stairs() {
  var_0 = getEntArray("pre_lobby_shelf_debris1", "targetname");
  var_1 = getEntArray("pre_lobby_shelf_debris2", "targetname");
  var_2 = getEntArray("pre_lobby_shelf_debris3", "targetname");
  common_scripts\utility::flag_wait("lobby_stairwell_shake");
  thread maps\cornered_audio::aud_collapse("shelf");
  setphysicsgravitydir((-0.02, 0, -0.03));

  foreach(var_4 in var_0) {
    var_4 physicslaunchclient(var_4.origin + (-2, 2, 0), (0, -0.002, -1));
    var_4 thread maps\cornered_code::debris_remove_after_time(15.0);
  }

  wait 0.2;

  foreach(var_4 in var_1) {
    var_4 physicslaunchclient(var_4.origin + (-2, 2, 0), (0, -0.002, -1));
    var_4 thread maps\cornered_code::debris_remove_after_time(15.0);
  }

  wait 0.2;

  foreach(var_4 in var_2) {
    var_4 physicslaunchclient(var_4.origin + (-2, 2, 0), (0, -0.002, -1));
    var_4 thread maps\cornered_code::debris_remove_after_time(15.0);
  }

  setphysicsgravitydir((0, -0.02, -0.03));
}

fall_physics_debris_lobby() {
  if(!isDefined(level.atrium_checkpoint)) {
    common_scripts\utility::flag_wait("office_explosion");
  }

  var_0 = getEntArray("lobby_debris1", "targetname");

  foreach(var_2 in var_0) {
    var_2 physicslaunchclient(var_2.origin + (0, 0, -6), (0, -1, 0));
    var_2 thread maps\cornered_code::debris_remove_after_time(20.0);
  }

  wait 2.8;
  var_4 = getEntArray("lobby_debris2", "targetname");

  foreach(var_2 in var_4) {
    var_2 physicslaunchclient(var_2.origin + (0, 0, -6), (0, -1, 0));
    var_2 thread maps\cornered_code::debris_remove_after_time(20.0);
  }

  common_scripts\utility::flag_wait("player_is_slipping");
  var_7 = getEntArray("lobby_debris3", "targetname");

  foreach(var_2 in var_7) {
    var_2 physicslaunchclient(var_2.origin + (0, 0, -6), (0, -1, 0));
    var_2 thread maps\cornered_code::debris_remove_after_time(20.0);
  }
}

fall_physics_debris_furniture() {
  var_0 = getEntArray("lobby_furniture_junk", "targetname");

  foreach(var_2 in var_0) {
    var_2 physicslaunchclient(var_2.origin + (0, 0, -8), (0, -125, 500));
    var_2 thread maps\cornered_code::debris_remove_after_time(20.0);
  }
}

fall_physics_debris_slide() {
  var_0 = level.player common_scripts\utility::spawn_tag_origin();
  var_0.origin = level.player.origin + (0, 16, 32);
  var_0 thread maps\cornered_code::debris_spawner(0.1, 0.2, 600, (0, -1, -0.01), 1, 1);
  common_scripts\utility::flag_wait("atrium_pillar_break");
  var_1 = level.player common_scripts\utility::spawn_tag_origin();
  var_1.origin = level.player.origin + (24, 4, 12);
  var_1 linkto(level.fall_arms_and_legs[0]);
  var_1 thread maps\cornered_code::debris_spawner(0.1, 0.2, 1200, (0, -1, -0.01), 1, 1);
  var_2 = level.player common_scripts\utility::spawn_tag_origin();
  var_2.origin = level.player.origin + (-24, 4, 12);
  var_2 linkto(level.fall_arms_and_legs[0]);
  var_2 thread maps\cornered_code::debris_spawner(0.1, 0.2, 1200, (0, -1, -0.01), 1, 1);
  common_scripts\utility::flag_wait_any("atrium_finished", "parachute_exfil");
  var_1 delete();
  var_2 delete();
  var_0 delete();
}

lobby_and_stair_fx() {
  common_scripts\utility::exploder(7651);
  common_scripts\utility::exploder(3088);
}

random_building_shake_loop(var_0, var_1, var_2, var_3) {
  level endon("done_random_shaking");

  for(;;) {
    var_4 = randomfloatrange(var_1, var_2);

    if(var_4 < 2) {
      level.player playrumbleonentity("light_1s");
    }
    else if(var_4 >= 2 && var_4 < 3) {
      level.player playrumbleonentity("light_2s");
    }
    else {
      level.player playrumbleonentity("light_3s");
    }

    level thread lobby_and_stair_fx();
    earthquake(var_0, var_4, level.player.origin, 2500);
    maps\cornered_audio::aud_collapse("lobby");
    physicsjitter(level.player.origin, 3000, 2800, 1.0, 2.0);
    wait(var_4 + var_3);
  }
}

fall_enemy_self_anim() {
  self.animname = "generic";
  self.allowdeath = 1;
  self.deathanim = undefined;
  self.deathfunction = maps\cornered_code::death_only_ragdoll;
  common_scripts\utility::waitframe();
  maps\_anim::anim_generic(self, self.animation);

  if(isalive(self) && isDefined(self)) {
    self kill();
  }
}

fall_enemy_node_anim(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct(var_0, "targetname");
  self.animname = "generic";
  self.allowdeath = 1;
  self.deathanim = undefined;
  self.deathfunction = maps\cornered_code::death_only_ragdoll;
  var_2 maps\_anim::anim_generic(self, "cornered_building_fall_" + self.script_noteworthy);

  if(isalive(self) && isDefined(self)) {
    self kill();
  }
}

corpse_clear() {
  level endon("teleported");
  var_0 = getent("corpse_cleaner", "targetname");

  for(;;) {
    var_1 = getcorpsearray();

    foreach(var_3 in var_1) {
      if(var_3 istouching(var_0)) {
        var_3 delete();
      }
    }

    wait 0.05;
  }
}