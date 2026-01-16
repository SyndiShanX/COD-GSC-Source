/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_sam.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\la_utility;
#include maps\_scene;
#include maps\_turret;
#include maps\_vehicle;
#include maps\_music;
#include maps\_dialog;
#include maps\la_1_amb;
#include maps\createart\la_1_art;
#include maps\_audio;
#include maps\_objectives;

skipto_after_attack() {
  skipto_teleport("skipto_sam");
  screen_fade_out(0);
}

skipto_sam_jump() {
  skipto_teleport("skipto_sam");
  run_scene_first_frame("cougar_crawl");
  skip_scene("cougar_crawl");
  skip_scene("cougar_crawl_player");

  if(!flag("harper_dead")) {
    run_scene_first_frame("cougar_crawl_harper");
    skip_scene("cougar_crawl_harper");
  }
}

skipto_sam() {
  skipto_teleport("skipto_sam");
  skip_scene("cougar_crawl");
  skip_scene("cougar_crawl_player");
  skip_scene("sam_cougar_mount");
  level thread run_scene("sam_cougar_align");
  level thread drone_sam_attack();
  level thread set_cougar_objective();
}

skipto_cougar_fall() {
  flag_set("sam_complete");
}

main() {
  load_gump("la_1_gump_1b");
  clientnotify("argus_zone:off");
  flag_clear("drone_approach");
  setdvar("aim_assist_script_disable", 1);
  flag_set("drone_approach");
  init_hero("harper");
  init_hero("hillary");
  init_hero("sam");
  init_hero("jones");
  stop_exploder(10);
  exploder(1001);
  exploder(1002);
  run_scene_first_frame("sam_cougar_fall_vehilces");
  level thread setup_sam_cougar();
  level thread run_scene_and_delete("cougar_crawl_dead_loop");
  setsaveddvar("sm_sunSampleSizeNear", 0.5);
  clientnotify("sdlbg");
  level delay_notify("fxanim_debris_01_start", 15);
  onsaverestored_callback(::save_restored_function);
  level thread after_the_attack();
  scene_wait("cougar_crawl_player");
  level.player maps\_utility::show_hud();
  level thread stop_flashlight_exploder();
  level thread get_to_sam_magic_bullets();
  clientnotify("argus_zone:default");
  level thread maps\la_1_amb::play_sam_ambience();
  sam_jump();
  onsaverestored_callbackremove(::save_restored_function);
}

stop_flashlight_exploder() {
  wait 2;
  stop_exploder(1002);
}

setup_sam_cougar() {
  run_scene_and_delete("sam_cougar_align");
  vh_sam_cougar = getent("sam_cougar", "targetname");
  level waittill("sam_jump_done");
}

save_restored_function() {
  playsoundatposition("vox_blend_post_cougar", (7850, -57200, 680));
}

sam_main() {
  init_hero("harper");
  init_hero("hillary");
  init_hero("sam");
  init_hero("jones");
  setmusicstate("LA_1_TURRET");
  get_on_sam();
  level.player thread sam_fired_listener();
  level thread sam_vo();
  level thread car_flip();
  flag_wait("sam_success");
  spawn_vehicle_from_targetname("after_sam_police_car");
  get_off_sam();
  flag_set("sam_complete");
}

car_flip() {
  level waittill("police_car_flip");
  wait 0.65;
  level notify("fxanim_police_car_flip_start");
  wait 1.35;
  vh_car = getent("after_sam_police_car", "targetname");
  radiusdamage(vh_car.origin, 100, 50000, 40000);
}

cougar_fall() {
  init_hero("harper");
  init_hero("hillary");
  init_hero("sam");
  init_hero("jones");
  a_av_allies_spawner_targetnames = array("f35_fast");
  a_av_axis_spawner_targetnames = array("avenger_fast");
  clientnotify("set_sam_ext_context");
  level thread f35_intro();
  vh_sam_cougar = getent("sam_cougar", "targetname");
  vh_sam_cougar detachall();
  vh_sam_cougar attach("veh_t6_mil_cougar_turret_sam", "tag_body_animate_jnt", 1);
  level thread run_scene("sam_cougar_fall_player", undefined, undefined, 0);
  level thread run_scene_and_delete("sam_cougar_fall_vehilces");
  level thread run_scene_and_delete("close_call_drone");
  level thread run_scene_and_delete("sam_cougar_fall");

  if(!flag("harper_dead"))
    level thread run_scene_and_delete("sam_cougar_fall_harper");

  level.player delay_thread(4, ::switch_player_scene_to_delta);
  level.player delay_thread(14.5, ::play_stylized_impact_audio);
  level.player delay_thread(33, ::lock_view_clamp_over_time, 2);
  level thread fa38_rumble();
  level thread cougar_fall_exploders();
  level thread hide_player_body_for_courgar_fall();
  scene_wait("sam_cougar_fall");
  level clientnotify("and_reveal");
  level thread f38_flyoff();
  level thread vehicle_bullet_collisions();
  level.player stop_magic_bullet_shield();
  aerial_vehicles_no_target();
}

hide_player_body_for_courgar_fall() {
  wait 34.5;
  m_player_body = get_model_or_models_from_scene("sam_cougar_fall_player", "player_body");
  m_player_body hide();
}

vehicle_bullet_collisions() {
  vh_police_car1 = getent("sam_jump_police_car", "targetname");
  vh_police_car2 = getent("police_car_flip", "targetname");
  vh_police_mc1 = getent("upper_freeway_cycle", "targetname");
  vh_police_mc2 = getent("lower_freeway_cycle1", "targetname");
  vh_police_mc3 = getent("lower_freeway_cycle2", "targetname");
  vh_police_mc4 = getent("lower_freeway_cycle3", "targetname");
  vh_police_mc5 = getent("lower_freeway_cycle4", "targetname");
  vh_cougar2 = getent("g20_group1_cougar2", "targetname");

  if(isDefined(vh_police_car1))
    vh_police_car1 ignorecheapentityflag(1);

  if(isDefined(vh_police_car2))
    vh_police_car2 ignorecheapentityflag(1);

  if(isDefined(vh_police_mc1))
    vh_police_mc1 ignorecheapentityflag(1);

  if(isDefined(vh_police_mc2))
    vh_police_mc2 ignorecheapentityflag(1);

  if(isDefined(vh_police_mc3))
    vh_police_mc3 ignorecheapentityflag(1);

  if(isDefined(vh_police_mc4))
    vh_police_mc4 ignorecheapentityflag(1);

  if(isDefined(vh_police_mc5))
    vh_police_mc5 ignorecheapentityflag(1);

  if(isDefined(vh_cougar2))
    vh_cougar2 ignorecheapentityflag(1);
}

hide_hatch(veh_cougar) {
  veh_cougar hidepart("tag_turret_hatch_r_jnt");
  veh_cougar hidepart("tag_turret_hatch_l_jnt");
}

f38_flyoff() {
  f38_struct = getstruct("anderson_f38_goto_struct", "targetname");
  veh_f38 = getent("f35_vtol", "targetname");
  veh_f38 setvehicletype("plane_f35_fast_nocockpit");
  veh_f38 setvehgoalpos(f38_struct.origin, 1, 0);
  veh_f38 setspeed(400, 600);
  stop_exploder(313);
  exploder(312);
  veh_f38 waittill("goal");
  veh_f38 delete();
}

lock_view_clamp_over_time(n_time) {
  level.player lerpviewangleclamp(n_time, n_time / 2, n_time / 2, 0, 0, 0, 0);
}

on_hillary_death(m_hillary) {
  if(!flag("sam_cougar_mount_started")) {
    level.jones stop_magic_bullet_shield();
    level.harper stop_magic_bullet_shield();
    level.hillary stop_magic_bullet_shield();
    level.sam stop_magic_bullet_shield();
    wait 1.0;
    playfx(level._effect["sam_drone_explode"], level.player.origin - vectorscale((0, 0, 1), 3.0), (0, 0, 1));
    playsoundatposition("exp_mortar", level.player.origin);
    wait 0.5;

    if(!isgodmode(level.player)) {
      level.player stop_magic_bullet_shield();
      level.player suicide();
    }
  } else {
    level.jones delete();
    level.harper delete();
    level.hillary delete();
    level.sam delete();
  }
}

player_hit_ground(m_player_body) {
  level.player playrumbleonentity("damage_heavy");
}

fa38_intro_car_roof_sparks(veh_car) {
  veh_car thread play_fx("fa38_car_scrape_side", undefined, undefined, -1, 1, "origin_animate_jnt");
  wait 0.25;
  veh_car thread play_fx("fa38_car_scrape_roof", undefined, undefined, -1, 1, "origin_animate_jnt");
}

after_burner_off(veh_fa38) {
  veh_fa38 notify("hover");
  exploder(313);
  stop_exploder(312);
  wait 3;
  level thread fxanim_f35_hover();
}

after_burner_on(veh_fa38) {
  veh_fa38 notify("fly");
  stop_exploder(313);
  exploder(312);
}

fxanim_f35_hover(vh_drone) {
  level notify("fxanim_f35_blast_chunks_start");
  wait 1;
}

cougar_fall_exploders() {
  wait 10;
  exploder(202);
  wait 0.5;
  exploder(203);
}

sam_jump() {
  trigger_wait("sam_jump_trig");
  level notify("player_on_turret");
  set_straffing_drones("off");
  clientnotify("scjs");
  level thread maps\createart\la_1_art::lerp_sun_direction((-95, 53, 0), 1);
  end_scene("cougar_crawl_dead_loop");
  cleanup_kvp("cougar_destroyed_fxanim", "targetname");
  level thread maps\_audio::switch_music_wait("LA_1_TURRET", 0.5);
  level.player dodamage(level.player.health - 10, level.player.origin);
  level delay_thread(4, ::trigger_use, "under_the_sam");
  level thread drone_sam_attack();
  level thread play_explosion_on_cougar_climb();
  level.player magic_bullet_shield();
  run_scene_and_delete("sam_cougar_mount", 0.2);
  reset_sun_direction(0);
  screen_fade_out(0);
  level.player hide_hud();
  level notify("sam_jump_done");
  level thread autosave_by_name("sam_jump_done");
  array_delete(get_vehicle_array("under_the_sam", "script_noteworthy"));
}

play_explosion_on_cougar_climb() {
  wait 9.5;
  sam_explosion_struct = getstruct("sam_explosion_struct", "targetname");
  magicbullet("avenger_missile_turret", sam_explosion_struct.origin + vectorscale((0, 0, 1), 10.0), sam_explosion_struct.origin);
  wait 0.1;
  playsoundatposition("wpn_rocket_explode", sam_explosion_struct.origin);
  playsoundatposition("evt_turret_shake", (0, 0, 0));
  earthquake(0.5, 2, sam_explosion_struct.origin, 1000);
}

play_stylized_impact_audio() {
}

drone_explode_impact(m_fxanim_drone) {
  earthquake(0.8, 0.8, level.player.origin, 200);
  playsoundatposition("evt_turret_shake", (0, 0, 0));
  level.player playrumbleonentity("damage_heavy");
}

fa38_rumble() {
  wait 21;
  veh_fa38 = getent("f35_vtol", "targetname");
  veh_fa38 playrumbleonentity("la_1_fa38_intro_rumble");
}

autoexec event_funcs() {
  add_flag_function("cougar_crawl_started", ::cougar_crawl_drone);
  add_spawn_function_veh("sam_cougar", ::sam_cougar);
  add_spawn_function_veh("after_attack_explosion_launch_drone_1", ::after_attack_explosion_launch_drone_1);
}

after_the_attack() {
  level thread get_to_sam_exploders();
  level thread cougar_crawl_squibs();

  if(is_scene_skipped("cougar_crawl")) {
    level thread set_cougar_objective();
    level thread get_to_sam_straffing_runs();
  } else {
    run_scene_first_frame("cougar_crawl");
    run_scene_first_frame("cougar_crawl_player");

    if(!flag("harper_dead"))
      run_scene_first_frame("cougar_crawl_harper");
    else
      run_scene_first_frame("cougar_crawl_noharper");

    screen_fade_out(0);
    fade_with_shellshock_and_visionset();
    level notify("cougar_blend_go");
    level delay_thread(0.5, ::autosave_by_name, "after_the_attack");
    level delay_thread(17, ::set_cougar_objective);
    level delay_thread(9, ::get_to_sam_straffing_runs);
    level delay_thread(13, ::exploder, 210);
    level delay_thread(18, ::exploder, 210);
    level thread run_scene_and_delete("cougar_crawl_fxanim");
    level thread run_scene_and_delete("cougar_crawl");
    level thread run_scene_and_delete("cougar_crawl_player");

    if(!flag("harper_dead"))
      level thread run_scene_and_delete("cougar_crawl_harper");
    else
      level thread run_scene_and_delete("cougar_crawl_noharper");

    debug_timer();

    scene_wait("cougar_crawl_player");

    if(isDefined(level.old_friendlynamedist))
      setsaveddvar("g_friendlyNameDist", level.old_friendlynamedist);

    if(flag("harper_dead"))
      level.player say_dialog("sect_i_ll_get_on_the_stin_0");
  }

  clientnotify("reset_snapshot");
  setmusicstate("LA_POST_CRASH");
  level.player maps\_dialog::say_dialog("ill_create_a_dist_002", 1);
  flag_wait("near_sam_cougar");
}

cougar_crawl_squibs() {
  level endon("cougar_crawl_player_done");
  level thread triggered_cougar_crawl_squib_structs();
  squib_orgs = get_struct_array("cougar_crawl_squib_structs");

  foreach(s_squib in squib_orgs) {
    v_fx_org = s_squib.origin + -1 * anglestoforward(s_squib.angles) * 800;
    s_squib.m_fx_tag = spawn_model("tag_origin", v_fx_org, s_squib.angles);
  }

  while(true) {
    s_squib = random(squib_orgs);
    fx = getfx("squibs_" + s_squib.script_string);
    playfxontag(fx, s_squib.m_fx_tag, "tag_origin");
    s_squib.m_fx_tag playsound("prj_squib_impact_" + s_squib.script_string);
    wait(randomfloatrange(0.2, 1));
  }
}

triggered_cougar_crawl_squib_structs() {
  squib_orgs = get_struct_array("triggered_cougar_crawl_squib_structs", "script_noteworthy");

  foreach(s_squib in squib_orgs) {
    v_fx_org = s_squib.origin + -1 * anglestoforward(s_squib.angles) * 800;
    s_squib.m_fx_tag = spawn_model("tag_origin", v_fx_org, s_squib.angles);
    s_squib thread do_triggered_cougar_crawl_squib_struct();
  }
}

do_triggered_cougar_crawl_squib_struct() {
  trigger_wait(self.targetname, "target");
  fx = getfx("squibs_" + self.script_string);
  playfxontag(fx, self.m_fx_tag, "tag_origin");
  self.m_fx_tag playsound("prj_squib_impact_" + self.script_string);
}

after_attack_explosion_launch_drone_1() {
  self endon("death");
  wait 0.7;
  e_target = getent("after_attack_explosion_launch_target_1", "targetname");
  self maps\_turret::shoot_turret_at_target_once(e_target, undefined, 1);
}

set_cougar_objective() {
  maps\_objectives::set_objective(level.obj_prom_night, undefined, "done");
  waittillframeend;
  v_sam_org = getent("sam_cougar", "targetname") gettagorigin("tag_gunner_barrel2");
  maps\_objectives::set_objective(level.obj_shoot_drones, v_sam_org, "use");
  v_sam_cougar = getent("sam_cougar", "targetname");
  v_sam_cougar attach("veh_t6_mil_cougar_hood_obj", "tag_grill");
  flag_wait("sam_cougar_mount_started");
  v_sam_cougar detach("veh_t6_mil_cougar_hood_obj", "tag_grill");
  maps\_objectives::set_objective(level.obj_shoot_drones);
  flag_wait("sam_cougar_fall_started");
  maps\_objectives::set_objective(level.obj_shoot_drones, undefined, "done");
  maps\_objectives::set_objective(level.obj_shoot_drones, undefined, "delete");
}

get_to_sam_exploders() {
  if(!is_scene_skipped("cougar_crawl")) {
    level waittill("cougar_blend_go");
    wait 13.3;
  } else
    scene_wait("cougar_crawl_player");

  exploder(211);
  level waittill("fxanim_debris_02_start");
  level notify("fxanim_billboard_pillar_top03_start");
  exploder(212);
  wait 1;
  exploder(212);
}

get_on_sam() {
  sam_cougar = getent("sam_cougar", "targetname");
  sam_cougar makevehicleusable();
  sam_cougar usevehicle(level.player, 2);
  sam_cougar makevehicleunusable();

  if(level.skipto_point == "sam")
    v_angles_to_use = level.sam_cougar.angles;
  else
    v_angles_to_use = level.sam_cougar gettagangles("tag_origin_animate_jnt");

  v_angles = v_angles_to_use - vectorscale((0, 1, 0), 71.0);
  v_angles = (-15 - v_angles[0], v_angles[1], v_angles[2]);
  wait 0.25;
  level.player setplayerangles(v_angles);
  level.player magic_bullet_shield();
  sam_cougar hide_sam_turret();
  level.player thread sam_cougar_player_damage_watcher();
  level.player thread sam_attack_exploders();
  setdvar("aim_assist_script_disable", 0);
  level.player.old_aim_assist_min_target_distance = getdvarint(#"_id_E87B44C5");
  level.player setclientdvar("aim_assist_min_target_distance", 100000);
  level.player.aim_turnrate_pitch_ads = getdvarfloat(#"_id_951514DE");
  level.player.aim_turnrate_yaw_ads = getdvarfloat(#"_id_25A65277");
  level.player setclientdvar("aim_turnrate_pitch_ads", 120);
  level.player setclientdvar("aim_turnrate_yaw_ads", 150);
  screen_fade_in(0.5);
  setsaveddvar("r_stereo3DEyeSeparationScaler", 0.0166667);
  level thread sam_turret_instructions();
}

sam_turret_instructions() {
  screen_message_create(&"LA_SHARED_SAM_TURRET_LOCK", & "LA_SHARED_SAM_TURRET_FIRE");
  level._screen_message_1.hidewheninmenu = 0;
  level._screen_message_2.hidewheninmenu = 0;
  wait 4;

  while(!level.player attackbuttonpressed())
    wait 0.05;

  level._screen_message_1.hidewheninmenu = 1;
  level._screen_message_2.hidewheninmenu = 1;
  screen_message_delete();
}

hide_sam_turret() {
  self hidepart("tag_gunner_turret2", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_canopy", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_stick_base", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_screen", "veh_t6_mil_cougar_turret_sam");
}

hide_all_turret_bones() {
  self hidepart("tag_body_animate_jnt", "veh_t6_mil_cougar_turret_sam");
  self hidepart("gunner_turret2_animate_jnt", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_enter_gunner2", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_gunner_turret2", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_canopy", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_gunner2", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_gunner_barrel2", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_gunner_brass2", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_stick_base", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_flash_gunner2", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_flash_gunner2a", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_screen", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_stick_grip", "veh_t6_mil_cougar_turret_sam");
}

show_sam_turret() {
  self showpart("tag_gunner_turret2", "veh_t6_mil_cougar_turret_sam");
  self showpart("tag_canopy", "veh_t6_mil_cougar_turret_sam");
  self showpart("tag_stick_base", "veh_t6_mil_cougar_turret_sam");
  self showpart("tag_screen", "veh_t6_mil_cougar_turret_sam");
}

get_off_sam() {
  sam_cougar = getent("sam_cougar", "targetname");
  screen_fade_out(0);
  sam_cougar cleartargetentity(1);
  sam_cougar useby(level.player);
  sam_cougar hide_all_turret_bones();
  level.player setclientdvar("aim_assist_min_target_distance", level.player.old_aim_assist_min_target_distance);
  level.player setclientdvar("aim_turnrate_pitch_ads", level.player.aim_turnrate_pitch_ads);
  level.player setclientdvar("aim_turnrate_yaw_ads", level.player.aim_turnrate_yaw_ads);
  level.player show_hud();
  level delay_thread(0.3, ::screen_fade_in, 0.3);
  setmusicstate("LA_1_OFF_TURRET");
  setsaveddvar("r_stereo3DEyeSeparationScaler", 1.0);
}

cougar_crawl_drone() {
  wait 5;
  veh_drone = getent("cougar_crawl_drone", "targetname");

  if(isDefined(veh_drone)) {
    veh_drone thread fire_turret_for_time(-1, 0);
    veh_drone thread fire_turret_for_time(-1, 1);
    veh_drone thread fire_turret_for_time(-1, 2);
  }
}

f35_intro() {
  flag_wait("sam_cougar_fall_started");
  level thread maps\la_1_amb::snapshot_drone();
  wait 14;
  veh_drone = getent("cougar_crawl_drone", "targetname");
  s_missile_org = get_struct("f35_intro_missile_org");
  magicbullet("fa38_missile_turret_hero", s_missile_org.origin, s_missile_org.angles, undefined, veh_drone);
}

sam_cougar() {
  level.sam_cougar = self;
  self godon();
  scene_wait("sam_cougar_mount");
  self godoff();
  self.overridevehicledamage = ::sam_cougar_damage;
}

sam_cougar_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, damagefromunderneath, modelindex, partname) {
  max_damage = 9000;

  if(!isDefined(level.sam_cougar_damage))
    level.sam_cougar_damage = 0;

  level.sam_cougar_damage = level.sam_cougar_damage + idamage;

  if(level.sam_cougar_damage > max_damage && !isgodmode(level.player)) {
    level.player stop_magic_bullet_shield();
    level.player suicide();
  }

  return false;
}

sam_attack_exploders() {
  exploder(220);
  exploder(221);
  exploder(225);
  exploder(226);
  level waittill("drone_wave_1");
  exploder(223);
  earthquake(0.25, 1.0, self.origin, 512, self);
  playsoundatposition("evt_turret_shake", (0, 0, 0));
  level waittill("drone_wave_2");
  exploder(223);
  earthquake(0.25, 1.0, self.origin, 512, self);
  playsoundatposition("evt_turret_shake", (0, 0, 0));
  wait 3;
  exploder(224);
  earthquake(0.25, 1.0, self.origin, 512, self);
  playsoundatposition("evt_turret_shake", (0, 0, 0));
  level waittill("drone_wave_3");
  exploder(224);
  earthquake(0.25, 1.0, self.origin, 512, self);
  playsoundatposition("evt_turret_shake", (0, 0, 0));
}

get_to_sam_magic_bullets() {
  level thread get_to_sam_magic_bullets_player();

  while(!flag("sam_cougar_mount_started")) {
    for(i = 0; i < 20; i++) {
      v_player_forward = level.player get_forward(1);
      v_target_offset = random_vector(500);
      v_start = level.player.origin + vectorscale((0, 0, 1), 1024.0);
      v_end = level.player.origin + vectornormalize(v_player_forward) * 1024 + v_target_offset;
      magicbullet("avenger_side_minigun", v_start, v_end);
      wait 0.05;
    }

    wait(randomfloatrange(5, 7));
  }
}

get_to_sam_magic_bullets_player() {
  while(!flag("sam_cougar_mount_started")) {
    wait(randomfloatrange(7, 9));
    v_start = level.player.origin + vectorscale((0, 0, 1), 1024.0);
    magicbullet("avenger_side_minigun", v_start, level.player.origin);
  }
}

death_by_drone() {
  level.player enablehealthshield(0);
  level thread death_by_drone_loop();
  flag_wait("sam_cougar_mount_started");
  a_drones = get_vehicle_array("ambient_drone", "targetname");
  array_func(a_drones, ::ent_flag_clear, "straffing");
}

death_by_drone_loop() {
  while(!flag("sam_cougar_mount_started")) {
    level.player waittill_not_god_mode();
    veh_drone = get_random_ambient_drone();
    veh_drone strafe_player(1);
  }
}

get_random_ambient_drone() {
  veh_drone = random(get_vehicle_array("ambient_drone", "targetname"));
  return veh_drone;
}

sam_vo() {
  if(flag("harper_dead")) {
    level.player say_dialog("samu_here_they_come_sect_0");
    level.player say_dialog("sect_tracking_multiple_gr_0");
  } else {
    level.player say_dialog("tracking_multiple_001");
    level.player say_dialog("here_they_come_002");
  }

  if(!isDefined(level.player.missileturrettargetlist) || level.player.missileturrettargetlist.size == 0)
    level.player waittill("lock_on_missile_turret_start");

  level thread sam_direction_vo_left();
  level thread sam_direction_vo_right();
  level thread good_shot_vo();
  level thread sam_nag_vo("start_sam_end_vo");

  if(!flag("harper_dead"))
    level.player say_dialog("dont_let_them_get_007");
  else
    level.player say_dialog("samu_you_have_to_take_dow_0");

  flag_wait("start_sam_end_vo");
  kill_all_pending_dialog();
  level.player waittill_dialog_finished();
  level notify("stop_other_sam_vo");
  wait 1;
  level thread sam_nag_vo("sam_success");

  if(flag("harper_dead"))
    level.player say_dialog("samu_they_re_all_over_us_0");
  else
    level.harper say_dialog("harp_section_beat_they_0");

  flag_wait("sam_success");
  kill_all_pending_dialog();

  if(!flag("harper_dead"))
    level.harper say_dialog("get_the_hell_out_o_002");
  else {
    level.player say_dialog("thats_your_window_001");
    level.player say_dialog("sect_go_now_0");
  }
}

sam_direction_vo_left() {
  level endon("stop_other_sam_vo");
  a_dialog = [];

  if(flag("harper_dead"))
    a_dialog[a_dialog.size] = "sect_radar_contact_left_0";
  else {
    a_dialog[a_dialog.size] = "harp_left_side_left_side_0";
    a_dialog[a_dialog.size] = "come_around_90_deg_009";
  }

  a_dialog = array_randomize(a_dialog);

  foreach(str_line in a_dialog) {
    level waittill("sam_drones_left");
    level.player say_dialog(str_line);
  }
}

sam_direction_vo_right() {
  level endon("stop_other_sam_vo");
  a_dialog = [];

  if(flag("harper_dead"))
    a_dialog[a_dialog.size] = "sect_radar_contact_right_0";
  else {
    a_dialog[a_dialog.size] = "harp_right_section_righ_0";
    a_dialog[a_dialog.size] = "watch_your_flank_008";
  }

  a_dialog = array_randomize(a_dialog);

  foreach(str_line in a_dialog) {
    level waittill("sam_drones_right");
    level.player say_dialog(str_line);
  }
}

good_shot_vo() {
  level endon("stop_other_sam_vo");
  a_dialog = [];

  if(flag("harper_dead")) {
    a_dialog[a_dialog.size] = "sect_that_s_a_hit_0";
    a_dialog[a_dialog.size] = "sect_get_down_0";
  } else {
    a_dialog[a_dialog.size] = "good_shot_006";
    a_dialog[a_dialog.size] = "harp_hell_yeah_0";
    a_dialog[a_dialog.size] = "harp_nice_fuckin_shootin_0";
  }

  foreach(str_line in a_dialog) {
    level waittill("good_shot");
    level.player waittill_dialog_finished();
    level.player say_dialog(str_line);
  }
}

sam_nag_vo(str_ender) {
  level endon(str_ender);

  if(!flag("harper_dead")) {
    a_nag_general = array("keep_them_off_us_012");
    a_nag_fire = array("fire_004", "harp_hit_em_now_0", "dead_ahead_h_engag_003");
    a_nag_offscreen = array("come_around_90_deg_009", "watch_your_flank_008");

    while(true) {
      a_drones = getentarray("sam_drone", "targetname");

      if(level.player.missileturrettargetlist.size) {
        a_nag_fire = array_randomize(a_nag_fire);
        level.player say_dialog(a_nag_fire[0]);
      } else if(a_drones[0] isvehicle() && level.player is_player_looking_at(a_drones[0].origin, 0.7, 0)) {
        a_nag_offscreen = array_randomize(a_nag_offscreen);
        level.player say_dialog(a_nag_offscreen[0]);
      } else {
        a_nag_general = array_randomize(a_nag_general);
        level.player say_dialog(a_nag_general[0]);
      }

      wait(randomfloatrange(5.0, 8.0));
    }
  }
}

drone_sam_attack() {
  level endon("sam_complete");
  level endon("sam_success");

  if(level.skipto_point != "sam")
    wait 8.5;

  angle_offsets = [];
  n_first_right_or_left = randomintrange(0, 2);
  angle_offset[0] = -90;
  angle_offset[1] = 180;
  angle_offset[2] = -120;
  angle_offset[3] = -90;
  angle_offset[4] = 180;
  angle_offset[5] = -120;
  angle_offset[6] = -90;

  for(i = 1; i <= 6; i++) {
    level.n_drone_wave = i;
    a_drones = spawn_sam_drone_group("sam_drone", 6, angle_offset[i - 1]);

    if(angle_offset[i - 1] <= 180)
      level notify("sam_drones_left");
    else
      level notify("sam_drones_right");

    level notify("drones_spawned");

    random(a_drones) thread debug_speed();

    if(i == 6) {
      a_drones = getentarray("sam_drone", "targetname");
      array_wait(a_drones, "death");
    } else
      array_wait(a_drones, "death", 8.5);

    if(level.n_drone_wave == 5)
      flag_set("start_sam_end_vo");

    playfx(level._effect["sam_drone_explode_shockwave"], level.player.origin, anglestoforward(flat_angle(level.sam_cougar gettagangles("tag_gunner_barrel2"))), (0, 0, 1));
    level notify("good_shot");
    level thread delete_sam_drone_corpses(a_drones);
  }
}

delete_sam_drone_corpses(a_drones) {
  flag_wait("sam_complete");

  foreach(vh_drone in a_drones) {
    if(isDefined(vh_drone.deathmodel_pieces))
      array_delete(vh_drone.deathmodel_pieces);

    if(isDefined(vh_drone))
      vh_drone delete();
  }
}

get_to_sam_straffing_runs() {
  set_straffing_drones("sam_drone", "sam_run_start_org", 750, "delete_before_sam_drones", 0.4, 1.8);
}

debug_speed() {
  self endon("death");

  while(true) {
    wait 0.05;
    debug_number(self getspeedmph());
  }

}

debug_number(n_speed) {
  if(!isDefined(level.speed_debug)) {
    level.speed_debug = newhudelem();
    level.speed_debug.alignx = "left";
    level.speed_debug.aligny = "bottom";
    level.speed_debug.horzalign = "left";
    level.speed_debug.vertalign = "bottom";
    level.speed_debug.x = 0;
    level.speed_debug.y = 0;
    level.speed_debug.fontscale = 1.0;
    level.speed_debug.color = (0.8, 1.0, 0.8);
    level.speed_debug.font = "objective";
    level.speed_debug.glowcolor = (0.3, 0.6, 0.3);
    level.speed_debug.glowalpha = 1;
    level.speed_debug.foreground = 1;
    level.speed_debug.hidewheninmenu = 1;
  }

  level.speed_debug setvalue(n_speed);
}

lerp_vehicle_speed(n_goal_speed, n_time) {
  self endon("death");
  n_current_speed = self getspeedmph();
  s_timer = new_timer();

  do {
    wait 0.05;
    n_current_time = s_timer get_time_in_seconds();
    n_speed = lerpfloat(n_current_speed, n_goal_speed, n_current_time / n_time);
    self setspeed(n_speed, 1000);
  }
  while(n_speed > n_goal_speed);
}

death_cheat() {
  self endon("death");

  while(true) {
    if(level.player sprintbuttonpressed() && level.player meleebuttonpressed()) {
      self dodamage(100000, self.origin, level.player, 0, "projectile");
      break;
    }

    wait 0.05;
  }

}

sam_wave_vo(v_player_angle, n_spawn_yaw) {
  if(abs(n_spawn_yaw - 80) < 30)
    level.player say_dialog("more_drones_moving_013");
  else {
    n_angle_diff = abs(n_spawn_yaw - v_player_angle);

    if(n_angle_diff > 70 && n_angle_diff < 110 || n_angle_diff > 250 && n_angle_diff < 290)
      level.player say_dialog("come_around_90_deg_009");
    else if(n_angle_diff >= 110 && n_angle_diff <= 290)
      level.player say_dialog("watch_your_flank_008");
  }
}

get_sam_forward() {
  v_angles = self gettagangles("tag_gunner_barrel2");
  v_forward = anglestoforward(flat_angle(v_angles));
  return v_forward;
}

get_sam_pos() {
  v_pos = self gettagorigin("tag_gunner_barrel2");
  return v_pos;
}

get_best_drone_for_straffing() {
  a_drones = get_vehicle_array("ambient_drone", "targetname");
  v_forward = level.sam_cougar get_sam_forward();
  n_dot_best = 0;

  foreach(veh_drone in a_drones) {
    v_to_drone = veh_drone.origin - level.sam_cougar get_sam_pos();
    n_dot = vectordot(v_forward, v_to_drone);

    if(n_dot > n_dot_best) {
      n_dot_best = n_dot;
      veh_drone_best = veh_drone;
    }
  }

  return veh_drone_best;
}

drone_fly() {
  self endon("death");
  a_goal_groups[0] = getstructarray("plane_goto1", "targetname");
  a_goal_groups[1] = getstructarray("plane_goto2", "targetname");
  a_goal_groups[2] = getstructarray("plane_goto3", "targetname");
  a_goal_groups[3] = getstructarray("plane_goto4", "targetname");

  if(cointoss())
    a_goal_groups = array_reverse(a_goal_groups);

  while(true) {
    foreach(a_goals in a_goal_groups) {
      self ent_flag_waitopen("straffing");
      self setspeed(randomintrange(200, 300), 300, 300);

      do
        new_goal = random(a_goals);
      while(!isDefined(self.current_goal) && !isDefined(new_goal) || isDefined(self.current_goal) && isDefined(new_goal) && self.current_goal == new_goal);

      self.current_goal = new_goal;
      self setvehgoalpos(self.current_goal.origin, 0);
      self waittill("near_goal");
    }
  }
}

drone_evade() {
  self endon("goal");
  self waittill("missileTurret_fired_at_me");
  angles = self.angles;
  pitch = angleclamp180(angles[0]);
  yaw = angleclamp180(angles[1]);
  pitch = pitch + randomintrange(-15, 15);
  yaw = yaw + randomintrange(-5, 5);
  dir = anglestoforward((pitch, yaw, 0));
  goal_pos = self.origin + dir * 5000;
  self setvehgoalpos(goal_pos, 0);
}

plane_fire_weapons() {
  self endon("death");
  facing_player = 0;

  while(!facing_player) {
    vec_to_target = level.player.origin - self.origin;
    vec_to_target = vectornormalize(vec_to_target);
    forward = anglestoforward(self.angles);

    if(vectordot(forward, vec_to_target) > 0.9)
      facing_player = 1;

    wait 0.05;
  }

  self maps\_turret::set_turret_target(level.player, (0, 0, 0), 1);
  self thread maps\_turret::fire_turret_for_time(8, 1);
  self maps\_turret::set_turret_target(level.player, (0, 0, 0), 2);
  self thread maps\_turret::fire_turret_for_time(8, 2);
  wait(randomfloatrange(2, 3));

  if(randomfloatrange(0, 1) < 0.25) {
    self maps\_turret::set_turret_target(level.player, (0, 0, 0), 0);
    self thread maps\_turret::fire_turret_for_time(1.1, 0);
  }
}

sam_fired_listener() {
  level.n_sam_missiles_fired = 0;

  while(!flag("sam_complete")) {
    self waittill("missileTurret_fired");
    level.n_sam_missiles_fired++;
    level.player playsound("wpn_sam_turret_reload");
  }
}