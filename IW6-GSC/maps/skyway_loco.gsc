/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\skyway_loco.gsc
*****************************************************/

section_flag_inits() {
  common_scripts\utility::flag_init("hint_breach_init");
  common_scripts\utility::flag_init("flag_loco_started");
  common_scripts\utility::flag_init("flag_loco_enter");
  common_scripts\utility::flag_init("flag_loco_breach_end");
  common_scripts\utility::flag_init("flag_loco_end");
  common_scripts\utility::flag_init("flag_player_failed_breach");
  common_scripts\utility::flag_init("flag_player_passed_breach");
  common_scripts\utility::flag_init("flag_stop_impulses");
  common_scripts\utility::flag_init("stack_line_1");
  common_scripts\utility::flag_init("stack_line_2");
  common_scripts\utility::flag_init("stack_line_3");
  common_scripts\utility::flag_init("stack_line_4");
  common_scripts\utility::flag_init("stack_line_5");
  common_scripts\utility::flag_init("stack_line_6");
}

section_precache() {
  maps\_utility::add_hint_string("hint_breach_init", &"SKYWAY_HINT_BREACH", ::hint_loco_breach_init_func);
  precacheitem("coltanaconda_rorkearm_skyway");
  precachemodel("weapon_p226");
}

section_post_inits() {
  getent("loco_breach_door_obj", "targetname") hide();
  getent("flag_loco_enter", "targetname") setmovingplatformtrigger();
}

start_loco() {
  iprintln("locomotive");
  level.player setclienttriggeraudiozone("skyway_tunnel2_int", 2);
  common_scripts\utility::flag_set("flag_loco_ready");
  var_0 = getent("ally1_start_loco1", "targetname");
  var_1 = getent("player_start_loco1", "targetname");
  maps\skyway_util::player_start(var_1);
  thread maps\skyway_fx::fx_turnon_tunnel_lights_01();
  thread maps\skyway_fx::fx_turnon_loco_exterior_lights();

  if(maps\_utility::is_gen4()) {
    setsaveddvar("r_mbEnable", "2");
    thread maps\skyway_util::set_motionblur_values(0.16, 1, 0.06, 1000, 0.5);
  }

  thread standoff_sunlight();
  level._ally forceteleport(var_0.origin, var_0.angles);
}

main_loco() {
  common_scripts\utility::array_call(level._train.cars["train_loco"].trigs, ::setmovingplatformtrigger);
  level.player setclienttriggeraudiozone("skyway_tunnel2_int", 2);
  level.loco_breach_org = getent("loco_breach_org", "targetname");
  level.loco_breach_anim_node = getent("vignette_vargasstandoff", "targetname");
  level.slowmo_breach_player_speed = 0.2;
  level.loco_player_impulse_move_speed = 0.5;
  thread transient_load_outro();
  thread loco_breach_autosave();
  thread loco_breach_attain_moving_platform(1);
  thread hide_end_bridge_geo();
  thread break_cockpit_glass();
  level.cos45 = cos(45);
  common_scripts\utility::flag_set("flag_loco_started");
  level._ally maps\_utility::disable_ai_color();
  level._ally maps\_utility::set_ignoreall(1);
  level._ally maps\_utility::set_force_cover(1);
  level._ally thread loco_jumpdown_checkmate_dialogue();
  level._ally maps\_utility::follow_path(getnode("loco_breach_ally_cover_node", "targetname"));
  common_scripts\utility::flag_clear("flag_killer_tracker");
  level._ally notify("stop_dist_flag");

  if(!common_scripts\utility::flag("flag_rt3_ally_at_end"))
    common_scripts\utility::flag_set("flag_rt3_ally_at_end");

  thread maps\_utility::battlechatter_off("allies");
  thread maps\_utility::battlechatter_off("axis");
  thread loco_breach_visions();
  thread tunnel_lights_engineroom();
  thread standoff_sunlight();
  thread loco_breach_logic();
  thread loco_breach_slowmo(0.5, 0.75);
  thread loco_bridge_rog_strike();
  common_scripts\utility::flag_wait("flag_loco_breach_end");
  maps\skyway_util::stop_wind_watcher();
}

transient_load_outro() {
  common_scripts\utility::flag_wait_all("flag_loco_enter", "flag_rt3_ally_at_end");

  if(!istransientqueued("skyway_outro_tr"))
    maps\_utility::transient_unloadall_and_load("skyway_outro_tr");

  common_scripts\utility::flag_wait("flag_loco_end");
  synctransients();
}

loco_breach_autosave() {
  if(level.start_point == "locomotive" || level.start_point == "locomotive_nomove") {
    return;
  }
  common_scripts\utility::flag_wait_all("flag_loco_enter", "flag_rt3_ally_at_end");

  while(!istransientloaded("skyway_outro_tr"))
    wait(level.timestep);

  for(var_0 = level.player maps\_utility::player_looking_at(level.loco_breach_org.origin, 0.5, 1); !var_0; var_0 = level.player maps\_utility::player_looking_at(level.loco_breach_org.origin, 0.5, 1))
    wait(level.timestep);

  level.dopickyautosavechecks = 0;
  maps\_utility::autosave_by_name("locomotive");
}

loco_breach_attain_moving_platform(var_0) {
  if(var_0)
    common_scripts\utility::flag_wait("hint_breach_init");

  level.loco_moving_platform = level.player getmovingplatformparent();

  while(!isDefined(level.loco_moving_platform)) {
    level.loco_moving_platform = level.player getmovingplatformparent();
    wait(level.timestep);
  }
}

start_loco_standoff() {
  iprintln("loco_standoff");
  level.player setclienttriggeraudiozone("skyway_train_int_end", 2);
  maps\skyway_util::skyway_hide_hud();
  thread hide_end_bridge_geo();
  thread hide_loco_exterior();

  if(maps\_utility::is_gen4()) {
    setsaveddvar("r_mbEnable", "2");
    thread maps\skyway_util::set_motionblur_values(0.16, 0.15, 0.06, 1000, 0.5);
  }

  thread standoff_sunlight();
  thread break_cockpit_glass();
  var_0 = getent("ally1_start_loco1", "targetname");
  var_1 = getent("player_start_loco1", "targetname");
  maps\skyway_util::player_start(var_1);
  level._ally forceteleport(var_0.origin, var_0.angles);
}

main_loco_standoff() {
  level.player setclienttriggeraudiozone("skyway_train_int_end", 2);
  loco_standoff_init_vars();

  if(level.start_point == "loco_standoff" || level.start_point == "loco_standoff_nomove") {
    enemy_setup();
    maps\skyway_util::setup_player_for_animated_sequence(1, 60, level.player.origin, level.player.angles, 1, undefined, "player_rig");
    level.player_rig linkto(level.loco_breach_anim_node);
    level.player_legs = maps\_utility::spawn_anim_model("player_legs");
    level.player_legs linkto(level.loco_breach_anim_node);
    level._ally linkto(level.loco_breach_anim_node);
    thread loco_bridge_rog_strike();
    loco_slide_logic(1);
  }

  thread loco_standoff();
  common_scripts\utility::flag_wait("flag_loco_end");
  level.player setmovespeedscale(1.0);
  level.player disableslowaim();
  level.player allowfire(1);
  maps\_art::dof_disable_script(1);
}

hide_end_bridge_geo() {
  var_0 = getEntArray("bridge_end_broken", "script_noteworthy");
  var_1 = getEntArray("bridge_end_1", "script_noteworthy");
  var_2 = getEntArray("bridge_end_2", "script_noteworthy");

  foreach(var_4 in var_0)
  var_4 hide();

  level waittill("notify_swap_bridge_geo");

  foreach(var_4 in var_0)
  var_4 show();

  foreach(var_4 in var_1)
  var_4 hide();

  foreach(var_4 in var_2)
  var_4 hide();
}

break_cockpit_glass() {
  var_0 = getent("loco_navi_glass", "targetname");
  var_1 = getent("loco_navi_glass_broken", "targetname");
  var_1.animname = "loco_control_room_glass";
  var_1 maps\_anim::setanimtree();
  var_1 hide();
  level waittill("notify_break_cockpit_glass");
  thread maps\skyway_audio::loco_standoff_slowmo_sfx();
  level.player playrumbleonentity("damage_heavy");
  var_1 show();
  var_0 hide();
  var_1 setanim(level.scr_anim["loco_control_room_glass"]["loco_slide"]);
  playFXOnTag(common_scripts\utility::getfx("loco_breach_glass"), var_1, "tag_origin");
}

loco_standoff_init_vars() {
  if(!isDefined(level.loco_breach_anim_node))
    level.loco_breach_anim_node = getent("vignette_vargasstandoff", "targetname");

  if(!isDefined(level.slowmo_breach_player_speed))
    level.slowmo_breach_player_speed = 0.2;

  if(!isDefined(level.loco_moving_platform))
    loco_breach_attain_moving_platform(0);
}

hint_loco_breach_init_func() {
  return !common_scripts\utility::flag("hint_breach_init");
}

loco_jumpdown_checkmate_dialogue() {
  level endon("flag_loco_breach_end");
  common_scripts\utility::flag_clear("stack_line_1");
  common_scripts\utility::flag_clear("stack_line_2");
  common_scripts\utility::flag_clear("stack_line_3");
  common_scripts\utility::flag_clear("stack_line_4");
  common_scripts\utility::flag_clear("stack_line_5");
  common_scripts\utility::flag_clear("stack_line_6");
  common_scripts\utility::flag_wait("stack_line_1");
  level._ally maps\_utility::smart_dialogue("skyway_hsh_merrickdoyoucopy");
  common_scripts\utility::flag_wait("stack_line_2");
  maps\_utility::smart_radio_dialogue("skyway_mrk_copyhesh");
  common_scripts\utility::flag_wait("stack_line_3");
  level._ally maps\_utility::smart_dialogue("skyway_hsh_keeganweremovingin");
  common_scripts\utility::flag_wait("stack_line_4");
  maps\_utility::smart_radio_dialogue("skyway_kgn_comeagainstalker2");
  common_scripts\utility::flag_wait("stack_line_5");
  level._ally maps\_utility::smart_dialogue("skyway_hsh_atthewordcheckmate");
  common_scripts\utility::flag_wait("stack_line_6");
  level._ally maps\_utility::smart_dialogue("skyway_hsh_alrightadamrorkeis");
}

loco_breach_logic() {
  level.player endon("death");
  thread maps\skyway_fx::fx_turnon_loco_interior_lights();
  ally_setup();
  enemy_setup();
  props_setup();
  getent("loco_breach_door_obj", "targetname") show();
  getent("loco_breach_door", "targetname") hide();
  maps\skyway_util::waittill_trigger_activate_looking_at(level.loco_breach_org, "hint_breach_init", 54, undefined, undefined, 5);
  common_scripts\utility::flag_set("flag_stop_ambient_airbursts");
  getent("loco_breach_door", "targetname") show();
  getent("loco_breach_door_obj", "targetname") delete();
  level.player enablebreaching();
  level.player enableinvulnerability();
  thread maps\skyway_audio::sfx_loco_breach();
  thread maps\skyway_audio::sfx_loco_breach_02();
  setsaveddvar("g_friendlyNameDist", 0);
  var_0 = level.player getcurrentprimaryweapon();
  var_1 = weaponclipsize(var_0);

  if(level.player getweaponammoclip(var_0) < var_1)
    level.player setweaponammoclip(var_0, var_1);

  level._ally linkto(level.loco_breach_anim_node);
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level._ally, "loco_breach");
  level.player_legs linkto(level.loco_breach_anim_node);
  level.player_legs show();
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level.player_legs, "loco_breach");
  var_2 = 0.5;
  maps\skyway_util::player_animated_sequence_restrictions();
  var_3 = maps\_utility::spawn_anim_model("player_rig");
  var_3.origin = level.player.origin;
  var_3.angles = level.player.angles;
  var_3 hide();
  var_3 linkto(level.loco_breach_anim_node);
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(var_3, "loco_breach");
  level.player playerlinktoblend(var_3, "tag_player", var_2);
  var_4 = getent("loco_breach_door", "targetname");
  var_4.animname = "loco_breach_door";
  var_4 maps\_anim::setanimtree();
  var_4 setanim(level.scr_anim["loco_breach_door"]["loco_breach"]);
  var_4 thread handle_breach_door();
  level waittill("notify_loco_breach_door_explode");
  thread maps\_utility::vision_set_fog_changes("skyway_breach", 0.5);
  level.player_legs hide();
  level.player unlink();
  level.player forcemovingplatformentity(level.loco_moving_platform);
  player_setup("player_rig", 1, 60, var_3.origin, var_3.angles);
  var_5 = var_3 getanimtime(level.scr_anim["player_rig"]["loco_breach"]);
  level.player_rig linkto(level.loco_breach_anim_node);
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level.player_rig, "loco_breach");
  level.player_rig setanimtime(level.scr_anim["player_rig"]["loco_breach"], var_5);
  var_3 delete();
  thread maps\_utility::open_up_fov(0.2, level.player_rig, "tag_player", 45, 45, 90, 45);
  level.player enableweapons();
  level.player switchtoweaponimmediate(var_0);
  level.player enableslowaim(0.5, 0.5);
  level.player disableinvulnerability();
  thread end_breach_player_death_logic("notify_player_can_die");
  wait_for_rpg_guy_to_appear(1.5);
  level.end_breach_rpg_guy linkto(level.loco_breach_anim_node);
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level.end_breach_rpg_guy, "loco_breach");
  level.loco_breach_rpg_model linkto(level.loco_breach_anim_node);
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level.loco_breach_rpg_model, "loco_breach");
  level.loco_breach_rpg_model show();
  level.end_breach_rpg_guy thread end_breach_success_rpg();
  thread hide_loco_exterior();
  setsaveddvar("sm_sunSampleSizeNear", 0.065);
  level waittill("notify_end_breach_slide");
  level.player disablebreaching();
  level.loco_breach_rpg_model delete();
  level.loco_breach_rpg_model = undefined;
  loco_slide_logic();
}

handle_breach_door() {
  level waittill("notify_loco_breach_door_explode");
  wait 1.0;
  self setanimrestart(level.scr_anim["loco_breach_door"]["loco_breach"], 1.0, 0.0, 0.0);
}

end_breach_player_death_logic(var_0) {
  level endon("notify_loco_standoff");
  level endon("notify_end_breach_slide");
  thread end_breach_player_death_rpg();

  if(isDefined(var_0))
    level waittill(var_0);

  thread end_breach_player_death_via_notetrack();

  for(;;) {
    level.player waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(var_5 != "MOD_PROJECTILE_SPLASH") {
      level.player disableweapons();
      level notify("failure");
      setDvar("ui_deadquote", "");
      maps\_utility::missionfailedwrapper();
      level notify("notify_breach_fail");
    }

    wait(level.timestep);
  }
}

end_breach_player_death_via_notetrack() {
  level endon("notify_loco_standoff");
  level endon("notify_end_breach_slide");
  level endon("notify_breach_fail");
  level waittill("notify_player_death_via_notetrack");
  wait(level.timestep * 3);
  level.player dodamage(level.player.health - 1, level.end_breach_enemies[0] getEye(), level.end_breach_enemies[0], level.end_breach_enemies[0]);
  level.player disableweapons();
  level notify("failure");
  setDvar("ui_deadquote", "");
  maps\_utility::missionfailedwrapper();
}

end_breach_player_death_rpg() {
  level endon("flag_player_passed_breach");
  level endon("notify_player_rambo_RPG");
  thread end_breach_rpg_guy_fire("flag_player_failed_breach", 0.8, "notify_impact_player", "loco_breach", "flag_player_passed_breach");
  level waittill("notify_impact_player");
  level.player dodamage(level.player.health - 1, level.end_breach_rpg_guy.origin);
  level.player disableweapons();
  level notify("failure");
  setDvar("ui_deadquote", "");
  maps\_utility::missionfailedwrapper();
  level notify("notify_breach_fail");
}

wait_for_rpg_guy_to_appear(var_0) {
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
    if(level.end_breach_enemies_killed == level.end_breach_enemies.size) {
      return;
    }
    wait(level.timestep);
  }
}

end_breach_success_rpg() {
  level endon("notify_breach_fail");
  level endon("notify_player_rambo_RPG");
  self waittill("damage", var_0, var_1, var_2, var_3, var_4);
  level notify("notify_loco_breach_slowmo_end");
  level notify("notify_breach_success");
  thread maps\skyway_audio::sfx_loco_breach_out();
  level.player unlink();
  level.player_rig delete();
  level.player_rig = undefined;
  thread end_breach_rpg_guy_death();
  level.playerspeed = level.loco_player_impulse_move_speed;
  level.player setmovespeedscale(level.loco_player_impulse_move_speed);
  level.player disableslowaim();
  level waittill("notify_rpg_impact_engine");
  level notify("notify_start_loco_control_lights");
  wait 0.15;
  player_setup("player_rig", 0, 60);
  level.player_rig linkto(level.loco_breach_anim_node);
  level.player playerlinktoblend(level.player_rig, "tag_player", 0.3, 0, 0);
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level.player_rig, "loco_breach_blast");
  thread end_breach_player_unlink();
  wait 0.2;
  level notify("notify_end_breach_slide");
  thread end_breach_impulse_player_logic();
}

end_breach_player_unlink() {
  var_0 = getanimlength(level.scr_anim["player_rig"]["loco_breach_blast"]);
  var_1 = getnotetracktimes(level.scr_anim["player_rig"]["loco_breach_blast"], "draw_weapon");
  var_2 = var_1[0] * var_0;
  wait(var_2);
  level.player enableweapons();
  wait(var_0 - var_2);
  level.player unlink();
  level.player_rig hide();
}

end_breach_success_rpg_rambo() {
  level notify("notify_loco_breach_slowmo_end");
  level notify("notify_breach_success");
  level.player unlink();
  thread maps\skyway_audio::sfx_loco_breach_out();
  thread maps\skyway_audio::sfx_loco_exp_rambo();
  thread end_breach_rpg_guy_death(1);
  level.playerspeed = level.loco_player_impulse_move_speed;
  level.player setmovespeedscale(level.loco_player_impulse_move_speed);
  level.player disableslowaim();
  level notify("notify_start_loco_control_lights");
  wait 0.05;
  player_setup("player_rig", 0, 60);
  level.player_rig linkto(level.loco_breach_anim_node);
  level.player playerlinktoblend(level.player_rig, "tag_player", 0.35, 0, 0);
  earthquake(1.0, 1.0, level.player.origin, 2048);
  level.player playrumbleonentity("grenade_rumble");
  thread maps\skyway_util::player_sway_bump(level.timestep, 1.0, level.timestep, 1.0);
  thread maps\skyway_util::player_wind_bump(level.timestep, 1.0, level.timestep, 1.0);
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level.player_rig, "loco_breach_blast");
  thread end_breach_player_unlink();
  wait 0.2;
  level notify("notify_end_breach_slide");
  thread end_breach_impulse_player_logic();
}

end_breach_rpg_guy_death(var_0) {
  level endon("notify_end_breach_slide");
  self clearanim(level.scr_anim[self.animname]["loco_breach"], 0.2);
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(self, "loco_breach_death");

  if(!isDefined(var_0) || !var_0) {
    level.loco_breach_rpg_model clearanim(level.scr_anim[level.loco_breach_rpg_model.animname]["loco_breach"], 0.2);
    level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level.loco_breach_rpg_model, "loco_breach_death");
    thread end_breach_rpg_guy_fire("notify_fire_rpg", 0.5, "notify_rpg_impact_engine", "loco_breach_death", "flag_player_failed_breach");
    level waittill("notify_fire_rpg");
  }

  while(!maps\skyway_util::check_anim_time(self.animname, "loco_breach_death", 1.0))
    wait(level.timestep);

  level.loco_breach_anim_node thread maps\_anim::anim_last_frame_solo(self, "loco_breach_death");
}

end_breach_rpg_guy_fire(var_0, var_1, var_2, var_3, var_4) {
  level endon("notify_player_rambo_RPG");

  if(common_scripts\utility::flag(var_4))
    return;
  else
    level endon(var_4);

  level.rpg_fx_model = maps\_utility::spawn_anim_model("loco_breach_RPG_fx");
  level.loco_breach_anim_node maps\_anim::anim_first_frame_solo(level.rpg_fx_model, var_3);
  level.rpg_fx_model linkto(level.loco_breach_anim_node);
  level.rpg_org = common_scripts\utility::spawn_tag_origin();
  level.rpg_org linkto(level.rpg_fx_model, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.rpg_fx_explosion = common_scripts\utility::spawn_tag_origin();
  level.rpg_fx_explosion linkto(level.rpg_org, "tag_origin", (0, 0, 0), (0, 0, 0));
  level waittill(var_0);
  thread player_rambo_rpg(distance2d(level.player.origin, level.rpg_org.origin));
  playFXOnTag(common_scripts\utility::getfx("loco_breach_smoke_geotrail_rpg"), level.rpg_org, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("loco_breach_rpg_muzzle"), level.rpg_fx_model, "tag_origin");
  level.rpg_fx_model thread maps\_utility::play_sound_on_entity("weap_rpg_fire_plr");
  level.rpg_org thread maps\skyway_util::blend_link_over_time(level.rpg_fx_model, level.rpg_fx_model, 2.4, 0, "tag_origin", "tag_helo");
  wait(var_1);
  level.rpg_fx_explosion playSound("scn_skyway_loco_breach_explosion");
  level notify(var_2);
  end_breach_rpg_explosion();
}

end_breach_rpg_explosion() {
  level.rpg_fx_explosion linkto(level.loco_breach_anim_node);
  playFXOnTag(common_scripts\utility::getfx("loco_breach_rpg_wall_impact"), level.rpg_fx_explosion, "tag_origin");
  wait 0.2;
  stopFXOnTag(common_scripts\utility::getfx("loco_breach_smoke_geotrail_rpg"), level.rpg_org, "tag_origin");
  level.rpg_fx_explosion thread maps\_utility::play_sound_on_entity("scn_skyway_missile_impact");
  level.rpg_fx_explosion thread maps\_utility::play_sound_on_entity("scn_skyway_missile_explode_boom");
  wait 5;
  level.rpg_org delete();
  level.rpg_ord = undefined;
  level.rpg_fx_model delete();
  level.rpg_fx_model = undefined;
  level.rpg_fx_explosion delete();
  level.rpg_fx_explosion = undefined;
}

player_rambo_rpg(var_0) {
  level endon("flag_loco_breach_end");
  var_1 = getent("rambo_RPG_collision", "targetname");
  var_1 setCanDamage(1);
  var_1 linkto(level.rpg_org, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1 waittill("damage");
  thread end_breach_rpg_explosion();
  killfxontag(common_scripts\utility::getfx("loco_breach_smoke_geotrail_rpg"), level.rpg_org, "tag_origin");
  var_2 = distance2d(level.player.origin, var_1.origin);
  var_3 = 0;

  if(var_2 > var_0 * 0.5) {
    var_3 = 1;

    if(var_2 < var_0 * 0.75) {
      thread maps\skyway_audio::sfx_rambo_rpg_kill();
      level.player dodamage(80, var_1.origin);
    }
  }

  if(var_3) {
    level notify("notify_player_rambo_RPG");
    level notify("notify_rpg_impact_engine");
    level.end_breach_rpg_guy notify("notify_player_rambo_RPG");
    level.end_breach_rpg_guy end_breach_success_rpg_rambo();
  }

  var_1 delete();
}

end_breach_impulse_player_logic() {
  var_0 = getent("end_breach_impulse_player_focus", "targetname");
  level._train.cars["train_loco"].body thread maps\_utility::play_sound_on_entity("scn_skyway_mtl_huge_stress_lr");
  level._train.cars["train_loco"].body thread maps\_utility::play_sound_on_entity("emt_skyway_mtl_groan");
  level.end_breach_impulse_player_dir = vectornormalize(var_0.origin - level.player.origin);
  var_1 = 0.8;
  level.end_breach_impulse_force = 50.0;
  thread end_breach_engines_sieze();
  level waittill("notify_start_impulse");
  thread end_breach_impulse_player_single(var_0, 2, 1, 0.4);
}

end_breach_engines_sieze() {
  var_0 = level._train.cars["train_loco"].body;
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 linkto(var_0, "j_spineupper", (0, 0, 0), (0, 0, 0));
  wait 0.5;
  level._allies[0] thread maps\_utility::smart_dialogue("skyway_hsh_engineshitholdon");
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("loco_breach_engine_explode"), var_0, "tag_engine_blow_2");
  var_0 thread maps\_utility::play_sound_on_tag("scn_skyway_engine_explode", "tag_engine_blow_1");
  wait 0.1;
  earthquake(0.42, 0.8, level.player.origin, 3000);
  level.player playrumbleonentity("damage_heavy");
  wait 0.1;
  level notify("notify_start_impulse");
  thread maps\skyway_util::player_sway_blendto(0.1, 1.0);
  thread maps\skyway_util::player_wind_blendto(0.1, 1.0);
  level.player_rumble_ent thread maps\_utility::rumble_ramp_to(1, 1);
  level.player thread maps\skyway_util::player_const_quake_blendto(0.2, 1);
  thread maps\skyway_util::player_rumble_bump(level.player_rumble_rog_ent, 1.0, 0.0, 0.2, 0.0, 1.0);
  var_1 thread maps\_utility::play_sound_on_entity("scn_skyway_train_brake");
  thread maps\skyway_util::player_view_roll_with_traincar("roll_engineroom_sieze", 1);
  wait 0.3;
  playFXOnTag(common_scripts\utility::getfx("loco_breach_engine_explode"), var_0, "tag_engine_blow_1");
  var_0 thread maps\_utility::play_sound_on_tag("scn_skyway_engine_explode", "tag_engine_blow_2");
  wait 0.1;
  earthquake(0.5, 1.0, level.player.origin, 3000);
  level.player playrumbleonentity("damage_heavy");
  thread end_slide_effects(var_1);
  level.player disableweapons();
}

end_slide_effects(var_0) {
  level waittill("notify_loco_breach_slowmo_start");
  var_1 = 0.2;
  var_0 unlink();
  thread maps\skyway_util::player_sway_blendto(var_1);
  thread maps\skyway_util::player_wind_blendto(var_1);
  level.player thread maps\skyway_util::player_const_quake_blendto(0, var_1);
  level.player_rumble_ent thread maps\_utility::rumble_ramp_to(0, var_1);
}

end_breach_impulse_player_single(var_0, var_1, var_2, var_3) {
  level endon("flag_stop_impulses");
  var_4 = gettime();
  thread push_player_impulse(var_1, var_2, var_3);

  for(;;) {
    level.end_breach_impulse_player_dir = vectornormalize(var_0.origin - level.player.origin);
    wait(level.timestep);
  }
}

push_player_impulse(var_0, var_1, var_2) {
  var_3 = var_0;

  for(var_4 = level.loco_player_impulse_move_speed; var_3 > 0.0; var_3 = var_3 - level.timestep) {
    var_5 = maps\skyway_util::normalize_value(0, var_0, var_3);
    var_6 = maps\skyway_util::normalize_value(0, var_0, var_3);

    if(var_1)
      var_5 = 1.0 - var_5;

    var_5 = maps\skyway_util::factor_value_min_max(var_2, 1, var_5);
    var_6 = maps\skyway_util::factor_value_min_max(var_2, 1, var_6);
    var_7 = level.end_breach_impulse_player_dir * level.end_breach_impulse_force * var_5;
    var_4 = level.loco_player_impulse_move_speed * var_6;
    level.player pushplayervector(var_7, 1);
    level.player setmovespeedscale(var_4);
    wait(level.timestep);
  }

  common_scripts\utility::flag_wait("flag_stop_impulses");
  var_7 = (0, 0, 0);
  level.player pushplayervector(var_7, 1);
}

loco_slide_logic(var_0) {
  level.player thread loco_slide_player_raise_weapon();
  thread end_breach_player_death_logic("notify_loco_breach_slowmo_start");

  if(!isDefined(var_0)) {
    level.end_enemies[0] delete();
    level.end_enemies[1] delete();
    level.end_enemies[0] = end_breach_enemy_spawn_single(0);
    level.end_enemies[1] = end_breach_enemy_spawn_single(1);
  } else
    level.player forcemovingplatformentity(level.loco_moving_platform);

  common_scripts\utility::array_call(level.end_control_enemies, ::linkto, level.loco_breach_anim_node);

  if(!isDefined(var_0)) {
    level.end_enemies[0] linkto(level.loco_breach_anim_node);
    level.end_enemies[1] linkto(level.loco_breach_anim_node);
  }

  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level.end_enemies[0], "loco_slide");
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level.end_enemies[1], "loco_slide");
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level.end_breach_rpg_guy, "loco_slide");
  var_1 = maps\_utility::spawn_anim_model("pt2_extinguisher");
  var_1 linkto(level.loco_breach_anim_node);
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(var_1, "loco_slide");

  if(!isDefined(var_0))
    level waittill("flag_player_slide");

  thread train_sync_end_stop_anim();
  thread maps\skyway_audio::skyway_checkmate_music();
  var_2 = getent("loco_control_room_door", "targetname");
  var_2.animname = "loco_control_room_door";
  var_2 maps\_anim::setanimtree();
  var_2 setanim(level.scr_anim["loco_control_room_door"]["loco_slide"]);
  level.loco_breach_anim_node thread maps\_anim::anim_single(level.end_control_enemies, "loco_slide");
  level._boss linkto(level.loco_breach_anim_node);
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level._boss, "loco_slide");
  var_3 = 0.2;
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level.player_rig, "loco_slide");
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level.player_legs, "loco_slide");
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level._ally, "loco_slide");
  level.player disableweapons();
  level.player playerlinktoblend(level.player_rig, "tag_player", var_3);
  wait(var_3);
  level.player_legs show();
  level.player_rig show();
  common_scripts\utility::flag_set("flag_stop_impulses");
  thread loco_breach_slowmo(1.6, 0.75);
  level.player unlink();
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 60, 60, 60, 60, 1);
  var_4 = getanimlength(level.scr_anim["player_rig"]["loco_slide"]) - 0.2;
  wait(var_4);
  var_1 delete();
  level.player_legs delete();
  level.player_legs = undefined;
  common_scripts\utility::flag_set("flag_loco_breach_end");
}

train_sync_end_stop_anim() {
  var_0 = getanimlength(level.scr_anim["train_loco_body"]["end_stop"]);
  var_1 = 2.4;

  for(;;) {
    var_2 = level._train.cars["train_loco"].body getanimtime(level.scr_anim["train_loco_body"]["end_stop"]) * var_0;

    if(abs(var_1 - var_2) < 0.08) {
      break;
    }

    if(var_2 > var_1)
      level._train.cars["train_loco"].body setanim(level.scr_anim["train_loco_body"]["end_stop"], 1, var_2 / var_0, 0.8);
    else if(var_2 < var_1)
      level._train.cars["train_loco"].body setanim(level.scr_anim["train_loco_body"]["end_stop"], 1, var_2 / var_0, 1.2);

    wait(level.timestep);
    var_1 = var_1 + level.timestep;
  }

  level._train.cars["train_loco"].body setanimtime(level.scr_anim["train_loco_body"]["end_stop"], var_1 / var_0);
  level._train.cars["train_loco"].body setanim(level.scr_anim["train_loco_body"]["end_stop"], 1, var_1 / var_0, 1);
}

loco_slide_player_raise_weapon() {
  level endon("notify_loco_standoff");
  maps\skyway_util::skyway_hide_hud();
  level waittill("notify_player_raise_weapon");
  var_0 = "coltanaconda_rorkearm_skyway";
  level.player takeallweapons();
  level.player giveweapon(var_0);
  level.player enableweapons();
  level.player switchtoweaponimmediate(var_0);
  level.player setweaponammoclip(var_0, 6);
  level.player setweaponammostock(var_0, 0);
  level.player enableslowaim(0.25, 0.25);
  level.player springcamenabled(0.5);

  while(level.player getweaponammoclip(var_0) > 2)
    wait(level.timestep);

  level notify("notify_loco_breach_slowmo_end");
  level.player allowfire(0);
}

handle_revolver_bullet_fiction() {
  var_0 = 2;
  var_1 = level.player getweaponammoclip("coltanaconda_rorkearm_skyway");
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2 linktoplayerview(level.player, "TAG_FLASH", (0, 0, 0), (0, 0, 0), 1);

  while(var_1 > var_0) {
    wait(randomfloatrange(0.28, 0.32));
    level.player playrumbleonentity("damage_heavy");
    playFXOnTag(common_scripts\utility::getfx("magnum_flash"), var_2, "tag_origin");
    level.player playSound("weap_mag44_fire_plr");
    var_1--;
  }
}

loco_bridge_rog_strike() {
  level waittill("notify_call_in_final_rog");
  var_0 = getEntArray("bridge_end_1", "script_noteworthy");
  var_1 = getEntArray("bridge_end_2", "script_noteworthy");

  foreach(var_3 in var_0) {
    var_3.animname = "end_bridge";
    var_3 maps\_anim::setanimtree();
  }

  foreach(var_3 in var_1) {
    var_3.animname = "end_bridge";
    var_3 maps\_anim::setanimtree();
  }

  var_1[0] thread maps\skyway_audio::sfx_rog_canyon_impact("tag_rog_impact");
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("rog_maintrail_01"), var_1[0], "tag_rog_trail");
  thread maps\skyway_audio::sfx_train_derail_logic(var_1[0]);
  wait 4;
  playFXOnTag(common_scripts\utility::getfx("vfx_rog_impact_temp_01"), var_1[0], "tag_rog_impact");
  thread maps\skyway_audio::sfx_train_derail_sound();
  thread maps\skyway_util::rog_flash(0.7, 0.3, 1.5);
  thread maps\skyway_util::player_rumble_bump(level.player_rumble_rog_ent, 0.5, 0.0, 0.2, 0.0, 0.5);
  thread maps\skyway_util::player_rumble_bump(level.player_rumble_ent, 1.0, 1.0, 5.0, 0.0, 0.05);
  wait 0.2;
  thread maps\skyway_util::train_quake(0.4, 0.8, level.player.origin, 2000);
  thread maps\skyway_util::player_wind_bump(0.2, 0.0, 3.0, 0.9);
  wait 1.0;
  common_scripts\utility::flag_set("flag_bridge_rog");

  foreach(var_3 in var_0)
  var_3 setanim(level.scr_anim["end_bridge"]["bridge_rog_1"]);

  foreach(var_3 in var_1)
  var_3 setanim(level.scr_anim["end_bridge"]["bridge_rog_2"]);

  level waittill("notify_shockwave_start");
  playFXOnTag(common_scripts\utility::getfx("bridge_shockwave"), var_1[0], "tag_shockwave");
  playFXOnTag(common_scripts\utility::getfx("bridge_shockwave_girders"), var_1[0], "tag_shockwave_girders");
  level waittill("notify_shockwave_stop_girders");
  stopFXOnTag(common_scripts\utility::getfx("bridge_shockwave_girders"), var_1[0], "tag_shockwave_girders");
  level waittill("notify_shockwave_hit");
  thread maps\skyway_util::train_quake(0.6, 0.8, level.player.origin, 2000);
  level.player shellshock("default_nosound", 0.3);
  level.player thread maps\skyway_fx::shockwave_dirt_hit(1, 0.1, 4);
  radiusdamage(var_1[0] gettagorigin("tag_shockwave"), 3000, 40, 10);
  playFXOnTag(common_scripts\utility::getfx("bridge_shockwave_oriented"), level._train.cars["train_loco"].body, "tag_shockwave_oriented");
  playFXOnTag(common_scripts\utility::getfx("bridge_shockwave_oriented"), level._train.cars["train_loco"].body, "tag_shockwave_oriented2");

  foreach(var_12 in var_0)
  var_12 hide();

  foreach(var_12 in var_1)
  var_12 hide();

  thread maps\skyway_util::player_rumble_bump(level.player_rumble_rog_ent, 0.0, 0.0, 0.1, 0.0, 0.5);
  thread maps\skyway_util::player_rumble_bump(level.player_rumble_ent, 0.0, 0.0, 0.1, 0.0, 0.05);
  wait 0.3;
  radiusdamage(level.player.origin, 3000, 40, 10);
  killfxontag(common_scripts\utility::getfx("bridge_shockwave"), var_1[0], "tag_shockwave");
}

loco_standoff() {
  level notify("notify_loco_standoff");
  var_0 = 0.3;
  level.player unlink();
  level.player_rig delete();
  player_setup("player_rig_struggle", 0, 60);
  level.player_rig linkto(level.loco_breach_anim_node);
  level.player_rig thread loco_standoff_struggle_logic();
  level.player playerlinktoblend(level.player_rig, "tag_player", var_0, 0, 0);
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level.player_rig, "loco_standoff");
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level._boss, "loco_standoff");
  level.loco_breach_anim_node thread maps\_anim::anim_single_solo(level._ally, "loco_standoff");
  level._ally thread breach_shot_blood_fx("notify_shockwave_hit");
  level._ally maps\_utility::gun_remove();
  level._ally attach("weapon_p226", "tag_weapon_right");

  foreach(var_2 in level.end_control_enemies) {
    if(isalive(var_2)) {
      if(var_2.animname == "opfor4")
        level.loco_breach_anim_node thread maps\_anim::anim_single_solo(var_2, "loco_standoff");
    }
  }

  wait(var_0);
  level.player unlink();
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 25, 25, 10, 10, 1);
  level.player springcamenabled(0.5);
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4 linkto(level._train.cars["train_loco"].body, "j_spineupper", (0, 0, 0), (0, 0, 0));
  var_5 = maps\_utility::spawn_anim_model("player_rig");
  var_5 hide();
  var_4 maps\_anim::anim_first_frame_solo(var_5, "loco_blasthit");
  var_5 linkto(var_4);
  level waittill("notify_shockwave_hit");
  level notify("loco_blasthit");
  thread loco_fall_dof();
  level notify("notify_loco_breach_stop_struggle");
  var_6 = maps\_utility::spawn_anim_model("bridgepiece6");
  var_7 = maps\_utility::spawn_anim_model("bridgepiece7");
  var_8 = maps\_utility::spawn_anim_model("bridgepieceL_1");
  var_9 = maps\_utility::spawn_anim_model("bridgepieceL_2");
  var_10 = maps\_utility::spawn_anim_model("bridgepieceM_1");
  var_11 = maps\_utility::spawn_anim_model("bridgepieceM_2");
  var_12 = maps\_utility::spawn_anim_model("bridgepieceM_3");
  var_13 = maps\_utility::spawn_anim_model("bridgepieceS_1");
  var_14 = maps\_utility::spawn_anim_model("bridgepieceS_2");
  var_15 = [var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14];
  var_16 = maps\_utility::spawn_anim_model("pt2_extinguisher");
  thread maps\skyway_fx::fx_bridgefall(var_6, var_7);
  level._train maps\skyway_util::train_queue_path_anim("loco_blasthit", "anim_track_ending", "anim_track_ending", "clear", 1, 0);

  foreach(var_2 in level.end_enemies) {
    if(isalive(var_2))
      var_2 hide();
  }

  var_19 = common_scripts\utility::getstruct("anim_track_ending", "targetname");
  var_19 thread maps\_anim::anim_single(var_15, "loco_blasthit");
  level._ally linkto(var_4);
  var_4 thread maps\_anim::anim_single_solo(level._ally, "loco_blasthit");
  level._ally detach("weapon_p226", "tag_weapon_right");
  level._boss linkto(var_4);
  var_4 thread maps\_anim::anim_single_solo(level._boss, "loco_blasthit");
  var_16 linkto(var_4);
  var_4 thread maps\_anim::anim_single_solo(var_16, "loco_blasthit");
  level.player_rig delete();
  var_5 show();
  level.player playerlinktodelta(var_5, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(0.3, 0.15, 0.15, 40, 40, 40, 40);
  level.player playersetgroundreferenceent(var_4);
  var_4 maps\_anim::anim_single_solo(var_5, "loco_blasthit");
  maps\skyway_util::show_train_geo([], []);
  level.player springcamdisabled(0.5);
  level.player unlink();
  var_5 delete();

  foreach(var_21 in var_15)
  var_21 delete();

  var_16 delete();
  common_scripts\utility::flag_set("flag_loco_end");
}

player_setup(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = 60;

  maps\skyway_util::setup_player_for_animated_sequence(var_1, var_2, var_3, var_4, 0, undefined, var_0);
}

ally_setup() {}

enemy_setup() {
  level.end_enemies = [];
  level.end_breach_enemies = [];
  level.end_breach_rpg_guy = undefined;
  level.end_control_enemies = [];
  level.end_breach_enemies_killed = 0;

  if(!isDefined(level._boss))
    maps\skyway_util::spawn_boss();

  level._boss prepare_enemy_for_breach();
  level.breach_spawners = getEntArray("loco_breach_enemy", "targetname");

  foreach(var_1 in level.breach_spawners) {
    var_1 thread maps\_utility::add_spawn_function(maps\_vignette_util::vignette_actor_spawn_func);
    var_1.count = 2;
  }

  for(var_3 = 0; var_3 < level.breach_spawners.size + 1; var_3++) {
    var_4 = end_breach_enemy_spawn_single(var_3);
    level.end_enemies = common_scripts\utility::array_add(level.end_enemies, var_4);
  }
}

end_breach_enemy_spawn_single(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 1:
    case 0:
      var_1 = level.breach_spawners[var_0] maps\_utility::spawn_ai(1);
      var_1.animname = "opfor" + (var_0 + 1);
      var_1.deathfunction = maps\skyway_anim::breach_enemy_death_anim_override;
      var_1.deathanim = var_1 maps\_utility::getanim("loco_breach_death");
      var_1 thread breach_enemy_death_dmg("loco_breach_death", 1);
      level.end_breach_enemies[var_0] = var_1;
      break;
    case 2:
      var_2 = getent("loco_breach_enemy_RPG", "targetname");
      var_2 thread maps\_utility::add_spawn_function(maps\_vignette_util::vignette_actor_spawn_func);
      var_1 = var_2 maps\_utility::spawn_ai(1);
      var_1 hidepart("tag_weapon");
      level.end_breach_rpg_guy = var_1;
      break;
    case 3:
      var_1 = level.breach_spawners[var_0 - 1] maps\_utility::spawn_ai(1);
      var_1.animname = "opfor" + (var_0 + 1);
      var_1.deathfunction = maps\skyway_anim::breach_enemy_death_anim_override;
      var_1.deathanim = var_1 maps\_utility::getanim("loco_breach_death");
      var_1 thread breach_enemy_death_dmg("loco_breach_death", 1);
      level.end_control_enemies[var_0 - 3] = var_1;
      break;
    case 5:
    case 4:
      var_1 = level.breach_spawners[var_0 - 1] maps\_utility::spawn_ai(1);
      var_1 thread breach_enemy_death_dmg("loco_gunhold_death", 0);
      level.end_control_enemies[var_0 - 3] = var_1;
      break;
  }

  var_1.animname = "opfor" + (var_0 + 1);
  var_1 linkto(level.loco_breach_anim_node);
  var_1 thread breach_shot_blood_fx("notify_loco_standoff");
  return var_1;
}

props_setup() {
  level.player_legs = maps\_utility::spawn_anim_model("player_legs");
  level.player_legs hide();
  level.loco_breach_rpg_model = maps\_utility::spawn_anim_model("loco_breach_RPG_model");
  level.loco_breach_rpg_model hide();
}

prepare_enemy_for_breach() {
  maps\_utility::set_battlechatter(0);
  self.combatmode = "no_cover";
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.newenemyreactiondistsq_old = self.newenemyreactiondistsq;
  self.newenemyreactiondistsq = 0;
  self.grenadeammo = 0;
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.fixednode = 0;
  self.disablebulletwhizbyreaction = 1;
  maps\_utility::disable_pain();
  self.dontavoidplayer = 1;
}

breach_shot_blood_fx(var_0) {
  level endon(var_0);

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    var_9 = common_scripts\utility::spawn_tag_origin();
    var_9.origin = var_4;
    var_9.angles = var_3;
    var_9 linkto(self, var_8, (0, 0, 0), (0, 0, 0));
    playFXOnTag(level._effect["blood_spatter"], var_9, "tag_origin");
    wait(level.timestep);
  }
}

breach_enemy_death_dmg(var_0, var_1) {
  self endon("death");
  self endon("stop anim");
  self waittill("damage", var_2, var_3, var_4, var_5, var_6);
  level.end_breach_enemies_killed++;

  if(var_1) {
    if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
      maps\_utility::stop_magic_bullet_shield();

    self.allowdeath = 1;
    self kill();
  } else {
    self.scripted_death = 1;
    level.loco_breach_anim_node maps\_anim::anim_single_solo(self, var_0);
    level.loco_breach_anim_node maps\_anim::anim_last_frame_solo(self, var_0);
  }
}

loco_breach_slowmo(var_0, var_1) {
  level waittill("notify_loco_breach_slowmo_start");
  var_2 = var_0;
  var_3 = var_1;
  level.player thread player_heartbeat();
  thread slowmo_difficulty_dvars();
  common_scripts\utility::flag_clear("can_save");
  maps\_utility::slowmo_setspeed_slow(0.25);
  maps\_utility::slowmo_setlerptime_in(var_2);
  maps\_utility::slowmo_lerp_in();
  level.player setmovespeedscale(level.slowmo_breach_player_speed);
  level waittill("notify_loco_breach_slowmo_end");
  level notify("slowmo_breach_ending", var_3);
  level notify("stop_player_heartbeat");
  level.player thread maps\_utility::play_sound_on_entity("slomo_whoosh");
  maps\_utility::slowmo_setlerptime_out(var_3);
  maps\_utility::slowmo_lerp_out();
  common_scripts\utility::flag_set("can_save");
  level.player slowmo_player_cleanup();
}

player_heartbeat() {
  level endon("stop_player_heartbeat");

  for(;;) {
    self playlocalsound("scn_skyway_heartbeat");
    wait(level.timestep);
  }
}

slowmo_difficulty_dvars() {
  var_0 = getDvar("bg_viewKickScale");
  var_1 = getDvar("bg_viewKickMax");
  setsaveddvar("bg_viewKickScale", 0.3);
  setsaveddvar("bg_viewKickMax", "15");
  setsaveddvar("bullet_penetration_damage", 0);
  level waittill("slowmo_breach_ending");
  setsaveddvar("bg_viewKickScale", var_0);
  setsaveddvar("bg_viewKickMax", var_1);
  wait 2;
  setsaveddvar("bullet_penetration_damage", 1);
}

slowmo_player_cleanup() {
  if(isDefined(level.playerspeed))
    self setmovespeedscale(level.playerspeed);
  else
    self setmovespeedscale(1);
}

blackscreen(var_0) {
  var_1 = maps\_hud_util::create_client_overlay("black", 0, level.player);
  var_1.alpha = 1;
  var_1.foreground = 0;
  maps\skyway_util::player_rumble_bump(level.player_rumble_ent, 1.0, 0.0, 0.1, 0.0, 0.9);
  level.black_overlay = var_1;
}

loco_standoff_struggle_logic() {
  level endon("notify_loco_breach_stop_struggle");
  level waittill("notify_loco_breach_struggle");
  var_0 = 0;
  var_1 = 0;
  level.debug_use_head_anims = 1;
  level.debug_use_body_anims = 1;
  level.simulation_speed = 2.5;
  level.damping_factor = -2.0;
  level.accel_factor = 5.0;
  self.jerk_check = 0;
  self.front_jerk = 0;
  self.back_jerk = 0;
  self.left_jerk = 0;
  self.right_jerk = 0;
  self.front_velocity = 0.0;
  self.back_velocity = 0.0;
  self.left_velocity = 0.0;
  self.right_velocity = 0.0;
  self.front_weight = 0.0;
  self.back_weight = 0.0;
  self.left_weight = 0.0;
  self.right_weight = 0.0;
  self.move_previous = (0, 0, 0);
  self setanim(level.scr_anim["player_rig_struggle"]["loco_bodyshield_accelerate_forward_parent"], 0, 0);
  self setanim(level.scr_anim["player_rig_struggle"]["loco_bodyshield_accelerate_back_parent"], 0, 0);
  self setanim(level.scr_anim["player_rig_struggle"]["loco_bodyshield_accelerate_right_parent"], 0, 0);
  self setanim(level.scr_anim["player_rig_struggle"]["loco_bodyshield_accelerate_left_parent"], 0, 0);
  self setanim(level.scr_anim["player_rig_struggle"]["loco_bodyshield_forward_parent"], 0, 0);
  self setanim(level.scr_anim["player_rig_struggle"]["loco_bodyshield_back_parent"], 0, 0);
  self setanim(level.scr_anim["player_rig_struggle"]["loco_bodyshield_right_parent"], 0, 0);
  self setanim(level.scr_anim["player_rig_struggle"]["loco_bodyshield_left_parent"], 0, 0);

  if(var_0)
    var_1 = level._boss getanimtime(level.scr_anim["boss"]["loco_standoff"]);

  for(;;) {
    loco_standoff_struggle_lerp_anims();

    if(var_0) {
      level._boss setanimtime(level.scr_anim["boss"]["loco_standoff"], var_1);
      level.player_rig setanimtime(level.scr_anim["player_rig_struggle"]["loco_standoff"], var_1);
      level._ally setanimtime(level.scr_anim["ally1"]["loco_standoff"], var_1);
    }

    wait(level.timestep);
  }
}

loco_standoff_struggle_lerp_anims() {
  level endon("notify_loco_breach_stop_struggle");
  level.player endon("death");
  self endon("death");
  var_0 = level.player getnormalizedmovement();
  var_1 = common_scripts\utility::ter_op(var_0[0] > 0.0, 1, 0);
  var_2 = common_scripts\utility::ter_op(var_0[0] < 0.0, 1, 0);
  var_3 = common_scripts\utility::ter_op(var_0[1] < 0.0, 1, 0);
  var_4 = common_scripts\utility::ter_op(var_0[1] > 0.0, 1, 0);
  var_5 = common_scripts\utility::ter_op(self.front_weight > 0.0, 1, 0);
  var_6 = common_scripts\utility::ter_op(self.back_weight > 0.0, 1, 0);
  var_7 = common_scripts\utility::ter_op(self.left_weight > 0.0, 1, 0);
  var_8 = common_scripts\utility::ter_op(self.right_weight > 0.0, 1, 0);
  var_9 = -1 * self.front_weight;
  var_10 = -1 * self.back_weight;
  var_11 = -1 * self.left_weight;
  var_12 = -1 * self.right_weight;
  var_13 = 1;

  if(self.jerk_check) {
    var_14 = length2d(var_0 - self.move_previous);
    var_15 = 0.4;

    if(var_14 < var_15)
      var_13 = 0;
    else
      self.jerk_check = 0;
  }

  if(var_1) {
    if(!var_6) {
      if(self.front_jerk) {
        var_9 = -1.0;

        if(self.front_weight <= 0.1) {
          var_9 = 0.0;
          self.front_jerk = 0;
        }
      } else if(self.front_weight > 1.0) {
        var_9 = -1.0;
        self.jerk_check = 1;
        self.front_jerk = 1;
        self.move_previous = var_0;
      } else if(var_13)
        var_9 = var_0[0];
    } else if(var_13)
      var_10 = -1.0 * var_0[0];
  } else if(var_2) {
    if(!var_5) {
      if(self.back_jerk) {
        var_10 = -1.0;

        if(self.back_weight <= 0.1) {
          var_10 = 0.0;
          self.back_jerk = 0;
        }
      } else if(self.back_weight > 1.0) {
        var_10 = -1.0;
        self.jerk_check = 1;
        self.back_jerk = 1;
        self.move_previous = var_0;
      } else if(var_13)
        var_10 = -1.0 * var_0[0];
    } else if(var_13)
      var_9 = var_0[0];
  }

  if(var_3) {
    if(!var_8) {
      if(self.left_jerk) {
        var_11 = -1.0;

        if(self.left_weight <= 0.1) {
          var_11 = 0.0;
          self.left_jerk = 0;
        }
      } else if(self.left_weight > 1.0) {
        var_11 = -1.0;
        self.jerk_check = 1;
        self.left_jerk = 1;
        self.move_previous = var_0;
      } else if(var_13)
        var_11 = -1.0 * var_0[1];
    } else if(var_13)
      var_12 = var_0[1];
  } else if(var_4) {
    if(!var_7) {
      if(self.right_jerk) {
        var_12 = -1.0;

        if(self.right_weight <= 0.1) {
          var_12 = 0.0;
          self.right_jerk = 0;
        }
      } else if(self.right_weight > 1.0) {
        var_12 = -1.0;
        self.jerk_check = 1;
        self.right_jerk = 1;
        self.move_previous = var_0;
      } else if(var_13)
        var_12 = var_0[1];
    } else if(var_13)
      var_11 = -1.0 * var_0[1];
  }

  self.front_velocity = self.front_velocity + var_9 * level.accel_factor * level.timestep * level.simulation_speed;
  self.back_velocity = self.back_velocity + var_10 * level.accel_factor * level.timestep * level.simulation_speed;
  self.left_velocity = self.left_velocity + var_11 * level.accel_factor * level.timestep * level.simulation_speed;
  self.right_velocity = self.right_velocity + var_12 * level.accel_factor * level.timestep * level.simulation_speed;
  self.front_velocity = self.front_velocity + level.damping_factor * self.front_velocity * level.timestep * level.simulation_speed;
  self.back_velocity = self.back_velocity + level.damping_factor * self.back_velocity * level.timestep * level.simulation_speed;
  self.left_velocity = self.left_velocity + level.damping_factor * self.left_velocity * level.timestep * level.simulation_speed;
  self.right_velocity = self.right_velocity + level.damping_factor * self.right_velocity * level.timestep * level.simulation_speed;
  self.front_weight = self.front_weight + self.front_velocity * level.timestep * level.simulation_speed;
  self.back_weight = self.back_weight + self.back_velocity * level.timestep * level.simulation_speed;
  self.left_weight = self.left_weight + self.left_velocity * level.timestep * level.simulation_speed;
  self.right_weight = self.right_weight + self.right_velocity * level.timestep * level.simulation_speed;

  if(self.front_weight < 0.0) {
    self.back_weight = -1.0 * self.front_weight;
    self.front_weight = 0.0;
    self.back_velocity = -1.0 * self.front_velocity;
    self.front_velocity = 0.0;
  } else if(self.back_weight < 0.0) {
    self.front_weight = -1.0 * self.back_weight;
    self.back_weight = 0.0;
    self.front_velocity = -1.0 * self.back_velocity;
    self.back_velocity = 0.0;
  }

  if(self.left_weight < 0.0) {
    self.right_weight = -1.0 * self.left_weight;
    self.left_weight = 0.0;
    self.right_velocity = -1.0 * self.left_velocity;
    self.left_velocity = 0.0;
  } else if(self.right_weight < 0.0) {
    self.left_weight = -1.0 * self.right_weight;
    self.right_weight = 0.0;
    self.left_velocity = -1.0 * self.right_velocity;
    self.right_velocity = 0.0;
  }

  if(level.debug_use_head_anims) {
    var_16 = self.left_weight * 0.9;
    var_17 = self.right_weight * 0.9;
    var_18 = self.front_weight * 0.9;
    var_19 = self.back_weight * 0.9;
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_accelerate_left"], 1, 0);
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_accelerate_right"], 1, 0);
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_accelerate_forward"], 1, 0);
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_accelerate_back"], 1, 0);
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_accelerate_left_parent"], var_16, level.timestep);
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_accelerate_right_parent"], var_17, level.timestep);
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_accelerate_forward_parent"], var_18, level.timestep);
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_accelerate_back_parent"], var_19, level.timestep);
  }

  if(level.debug_use_body_anims) {
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_left"], 1, 0);
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_right"], 1, 0);
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_forward"], 1, 0);
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_back"], 1, 0);
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_left_parent"], self.left_weight, level.timestep);
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_right_parent"], self.right_weight, level.timestep);
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_forward_parent"], self.front_weight, level.timestep);
    self setanimlimited(level.scr_anim["player_rig_struggle"]["loco_bodyshield_back_parent"], self.back_weight, level.timestep);
  }
}

tunnel_lights_engineroom() {
  common_scripts\utility::flag_wait("flag_loco_enter");
  var_0 = getEntArray("light_tunnel_warm", "targetname");
  var_1 = getEntArray("light_tunnel_cool", "targetname");

  foreach(var_3 in var_0) {
    var_3 setlightcolor((0.99, 0.95, 0.81));
    var_3 setlightintensity(0.2);
  }

  foreach(var_3 in var_1) {
    var_3 setlightcolor((0.66, 0.78, 0.85));
    var_3 setlightintensity(0.05);
  }
}

hide_loco_exterior() {
  var_0 = getEntArray("loco_exterior", "targetname");

  foreach(var_2 in var_0)
  var_2 hide();
}

standoff_sunlight() {
  lerpsunangles(getmapsunangles(), (-14.82, 104.73, 0), 0.1);
  common_scripts\utility::flag_wait("flag_end_wreck_start");
  resetsundirection();
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
}

loco_fall_dof() {
  thread maps\_art::dof_enable_script(0, 17.15, 6, 350, 617, 3, 0.5);
  wait 4.1;
  thread maps\_art::dof_enable_script(0, 429.3, 5.0, 40000, 50000, 0.1, 1);
}

loco_breach_visions() {
  common_scripts\utility::flag_wait("flag_breach_final_tracks");
  maps\_utility::vision_set_fog_changes("skyway_breach2", 0.01);
  wait 2;
  maps\_utility::vision_set_fog_changes("skyway_standoff", 2);
}