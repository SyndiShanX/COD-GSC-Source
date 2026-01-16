/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_airfield.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\panama_utility;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\_anim;
#include maps\_stealth_logic;
#include maps\_music;
#include maps\_turret;
#include maps\createart\panama_art;
#include maps\_audio;

skipto_zodiac() {
  level.mason = init_hero("mason");
  a_hero[0] = level.mason;
  skipto_teleport("skipto_beach_player", a_hero);
  flag_set("movie_done");
  airfield_spawnfuncs();
  maps\createart\panama_art::airfield();
}

skipto_beach() {
  level.mason = init_hero("mason");
  a_hero[0] = level.mason;
  skipto_teleport("skipto_beach_player", a_hero);
  level.mason set_ignoreall(1);
  level.mason set_ignoreme(1);
  nd_mason_beach = getnode("nd_mason_beach", "targetname");
  level.mason setgoalnode(nd_mason_beach);
  level.player setlowready(1);
  level.player.ignoreme = 1;
  flag_set("movie_done");
  airfield_spawnfuncs();
  maps\createart\panama_art::airfield();
}

skipto_runway() {
  level.mason = init_hero("mason");
  a_hero[0] = level.mason;
  skipto_teleport("skipto_runway_player", a_hero);
  airfield_spawnfuncs();
  maps\createart\panama_art::airfield();
}

skipto_learjet() {
  level.mason = init_hero("mason");
  a_hero[0] = level.mason;
  skipto_teleport("skipto_learjet_player", a_hero);
  airfield_spawnfuncs();
  maps\createart\panama_art::airfield();
}

init_airfield_flags() {
  flag_init("zodiac_approach_start");
  flag_init("zodiac_approach_end");
  flag_init("player_at_first_blood");
  flag_init("mason_at_first_blood");
  flag_init("first_blood_guys_cleared");
  flag_init("contacted_skinner");
  flag_init("rooftop_goes_hot");
  flag_init("rooftop_spawned");
  flag_init("runway_standoff_goes_hot");
  flag_init("airfield_end");
  flag_init("hangar_doors_closing");
  flag_init("spawn_pdf_assaulters");
  flag_init("parking_lot_guys_cleared");
  flag_init("hangar_gone_hot");
  flag_init("stop_intro_planes");
  flag_init("stop_runway_planes");
  flag_init("remove_hangar_god_mode");
  flag_init("player_in_hangar");
  flag_init("stop_parking_lot_jets");
  flag_init("motel_jet_done");
  flag_init("hangar_pdf_cleared");
  flag_init("rooftop_guy_killed");
  flag_init("seal_1_in_pos");
  flag_init("seal_2_in_pos");
  flag_init("start_pdf_ladder_reaction");
  flag_init("player_contextual_start");
  flag_init("player_contextual_end");
  flag_init("player_destroyed_learjet");
  flag_init("learjet_destroyed");
  flag_init("player_opened_grate");
  flag_init("player_second_melee");
  flag_init("contextual_melee_success");
  flag_init("skinner_motel_dialogue");
  flag_init("button_wait_done");
  flag_init("contextual_melee_done");
  flag_init("setup_runway_standoff");
  flag_init("player_on_roof");
  flag_init("turret_guy_died");
  flag_init("spawn_learjet_wave_2");
  flag_init("mason_at_drain");
  flag_init("spawn_parking_lot_backup");
  flag_init("parking_lot_laststand");
}

airfield_spawnfuncs() {
  createthreatbiasgroup("hangar_pdf");
  createthreatbiasgroup("hangar_seals");
  createthreatbiasgroup("hangar_player");
  createthreatbiasgroup("hangar_mason");
  createthreatbiasgroup("pdf_assaulters");
  createthreatbiasgroup("rooftop_pdf");
  createthreatbiasgroup("runway_seals");
  createthreatbiasgroup("learjet_pdf");
  createthreatbiasgroup("learjet_seals");
  a_force_goal_guy = getentarray("force_goal_guy", "script_noteworthy");
  array_thread(a_force_goal_guy, ::add_spawn_function, ::init_force_goal_guy);
  a_pdf_stealth = getentarray("pdf_stealth", "script_noteworthy");
  array_thread(a_pdf_stealth, ::add_spawn_function, maps\_stealth_logic::stealth_ai);
  a_pdf_hangar_assaulters = getentarray("pdf_hangar_assaulters", "targetname");
  array_thread(a_pdf_hangar_assaulters, ::add_spawn_function, ::init_hangar_assaulters);
  a_rooftop_pdf = getentarray("rooftop_pdf", "targetname");
  array_thread(a_rooftop_pdf, ::add_spawn_function, ::init_rooftop_pdf);
  hangar_frontline = getentarray("hangar_frontline", "targetname");
  array_thread(hangar_frontline, ::add_spawn_function, ::init_hangar_pdf);
  hangar_seals = getentarray("hangar_seals", "targetname");
  array_thread(hangar_seals, ::add_spawn_function, ::init_hangar_seals);
  pdf_hangar_assaulters = getentarray("pdf_hangar_assaulters", "targetname");
  array_thread(pdf_hangar_assaulters, ::add_spawn_function, ::init_pdf_hangar_assaulters);
  a_pdf_runner = getentarray("pdf_runner", "script_noteworthy");
  array_thread(a_pdf_runner, ::add_spawn_function, ::init_pdf_runner);
  a_learjet_intro_pdf = getentarray("learjet_intro_pdf", "targetname");
  array_thread(a_learjet_intro_pdf, ::add_spawn_function, ::learjet_turret_challenge_count);
  a_learjet_truck_pdf = getentarray("learjet_truck_pdf", "targetname");
  array_thread(a_learjet_truck_pdf, ::add_spawn_function, ::learjet_turret_challenge_count);
  a_learjet_wave_1 = getentarray("learjet_wave_1", "targetname");
  array_thread(a_learjet_wave_1, ::add_spawn_function, ::learjet_turret_challenge_count);
  a_learjet_wave_1_rpg = getentarray("learjet_wave_1_rpg", "targetname");
  array_thread(a_learjet_wave_1_rpg, ::add_spawn_function, ::learjet_turret_challenge_count);
  a_learjet_wave_2 = getentarray("learjet_wave_2", "targetname");
  array_thread(a_learjet_wave_2, ::add_spawn_function, ::learjet_turret_challenge_count);
  a_learjet_wave_3 = getentarray("learjet_wave_3", "targetname");
  array_thread(a_learjet_wave_3, ::add_spawn_function, ::learjet_turret_challenge_count);
  a_learjet_back_left = getentarray("learjet_back_left", "targetname");
  array_thread(a_learjet_back_left, ::add_spawn_function, ::learjet_turret_challenge_count);
  a_learjet_back_door_kick_pdf = getentarray("learjet_back_door_kick_pdf", "targetname");
  array_thread(a_learjet_back_door_kick_pdf, ::add_spawn_function, ::learjet_turret_challenge_count);
  a_learjet_back_right = getentarray("learjet_back_right", "targetname");
  array_thread(a_learjet_back_right, ::add_spawn_function, ::learjet_turret_challenge_count);
  a_tarp_pdf = getentarray("tarp_pdf", "targetname");
  array_thread(a_tarp_pdf, ::add_spawn_function, ::learjet_turret_challenge_count);
  a_rolling_door_guys = getentarray("rolling_door_guys", "script_noteworthy");
  array_thread(a_rolling_door_guys, ::add_spawn_function, ::learjet_turret_challenge_count);
}

learjet_turret_challenge_count() {
  self waittill("death", e_attacker, str_mod, str_weapon);

  if(isDefined(e_attacker) && isDefined(str_weapon)) {
    if(str_weapon == "civ_pickup_turret" && e_attacker == level.player)
      level notify("killed_by_turret");
  }
}

init_pdf_runner() {
  self endon("death");
  nd_goal = getnode(self.target, "targetname");
  self force_goal(nd_goal, 16);
}

init_force_goal_guy() {
  self endon("death");
  nd_goal = getnode(self.target, "targetname");
  self force_goal(nd_goal, 16);
}

init_hangar_assaulters() {
  self endon("death");
  self.aggressivemode = 1;
  nd_goal = getnode(self.target, "targetname");
  self force_goal(nd_goal, 64);
}

init_pdf_hangar_assaulters() {
  self endon("death");
  self setthreatbiasgroup("pdf_assaulters");
}

init_hangar_pdf() {
  self endon("death");
  self setthreatbiasgroup("hangar_pdf");

  if(!flag("spawn_pdf_assaulters")) {
    volume_hangar_front = getent("hangar_front", "targetname");
    self setgoalvolumeauto(volume_hangar_front);
  } else {
    volume_hangar_back = getent("hangar_back", "targetname");
    self setgoalvolumeauto(volume_hangar_back);
  }

  if(!flag("remove_hangar_god_mode")) {
    self magic_bullet_shield();
    flag_wait("remove_hangar_god_mode");
    self stop_magic_bullet_shield();
  }
}

init_hangar_seals() {
  self endon("death");
  self setthreatbiasgroup("hangar_seals");

  if(!flag("remove_hangar_god_mode")) {
    self magic_bullet_shield();
    flag_wait("remove_hangar_god_mode");
    self stop_magic_bullet_shield();
  }
}

init_rooftop_pdf() {
  self endon("death");
  self.goalradius = 32;
  self magic_bullet_shield();
  flag_wait("rooftop_goes_hot");
  self stop_magic_bullet_shield();
  setignoremegroup("runway_seals", "rooftop_pdf");
}

zodiac_approach_main() {
  clean_up_christmas_lights();
  wait 2;
  exploder(1024);
  a_intro_zodiacs = getentarray("intro_zodiacs", "script_noteworthy");

  foreach(zodiac in a_intro_zodiacs) {
    playfxontag(getfx("zodiac_churn"), zodiac, "TAG_PROPELLER_FX");
    playfxontag(level._effect["glowstick_light"], zodiac, "TAG_BODY_ORIGIN");
  }

  level.mason = init_hero("mason");
  level.mason set_ignoreall(1);
  level.mason set_ignoreme(1);
  level thread maps\createart\panama_art::beach();
  maps\createart\panama_art::airfield();
  airfield_spawnfuncs();
  level clientnotify("sscng");
  setmusicstate("PANAMA_ZODIAK");
  level thread maps\_audio::switch_music_wait("PANAMA_BEACH", 22);
  level thread run_scene("zodiac_approach_boat");
  level thread run_scene("zodiac_approach_seals");
  level thread run_scene("zodiac_approach_seals2");
  level thread zodiac_seal_squad();
  level thread zodiac_mason();
  level thread invasion_read();
  level thread delete_models_on_zodiac();
  delay_thread(2, ::zodiac_jet_flyover);
  level.player playloopsound("evt_boat_loop", 1);
  level.player delay_thread(20, ::end_boat_sounds);
  level.player thread set_zodiac_overlay();
  level thread spawn_zodiac_littlebird();
  level thread zodiac_shake_and_rumble();
  flag_set("zodiac_approach_start");
  level thread screen_fade_in(8);
  level thread turn_off_hotel_lights();
  level thread can_see_buildings_on_zodiac();
  level thread phantom_truck_killer();
  level thread vo_zodiac_approach();
  level thread vo_zodiac_get_ready();
  run_scene("zodiac_approach_player");
  level thread run_scene("zodiac_dismount_player");
  level.player playrumbleonentity("artillery_rumble");
  earthquake(0.5, randomfloatrange(1.0, 2.0), level.player.origin, 100);
  player_body = get_model_or_models_from_scene("zodiac_dismount_player", "player_body");
  playfxontag(getfx("player_bubbles"), player_body, "tag_camera");
  level.player setwatersheeting(1, 7);
  level.player setwaterdrops(50);
  wait 3;
  level.player enableweapons();
  level.player showviewmodel();
  level.player disableweaponfire();
  level.player setwaterdrops(0);
  scene_wait("zodiac_dismount_player");
  level thread delete_zodiac_scenes();
  flag_set("can_turn_off_lights");
  level.player.ignoreme = 1;
  flag_set("zodiac_approach_end");
  autosave_by_name("beach");
  level clientnotify("aS_on");
}

delete_models_on_zodiac() {
  scene_wait("zodiac_leaves_beach");
  end_scene("zodiac_approach_seals");
  end_scene("zodiac_approach_seals2");
  ai = getent("ai_zodiac_seal_1", "targetname");
  ai delete();
  ai = getent("ai_zodiac_seal_2", "targetname");
  ai delete();
  ai = getent("ai_zodiac_seal_3", "targetname");
  ai delete();
}

#using_animtree("player");

vo_zodiac_get_ready() {
  anim_length = getanimlength( % p_pan_02_01_beach_approach_player);
  wait(anim_length - 12.5);
  level.mason thread say_dialog("reds_10_seconds_out_0", 0);
  wait 5;
  level.mason thread say_dialog("reds_5_seconds_0", 0);
  wait 5;
  level.mason say_dialog("reds_go_go_0", 0);
}

vo_zodiac_approach() {
  level.mason say_dialog("maso_hudson_it_s_mason_0", 0);
  level.mason say_dialog("hudson__do_you_co_003", 1);
}

zodiac_shake_and_rumble() {
  level endon("zodiac_dismount_player_started");

  while(true) {
    level.player playrumbleonentity("grenade_rumble");
    earthquake(0.5, randomfloatrange(1.0, 2.0), level.player.origin, 100);
    wait(randomfloatrange(1.0, 1.5));
  }
}

spawn_zodiac_littlebird() {
  s_spawnpt = getstruct("littlebird_zodiac_spawnpt", "targetname");
  vh_littlebird1 = spawn_vehicle_from_targetname("us_littlebird");
  vh_littlebird1.origin = s_spawnpt.origin;
  vh_littlebird1.angles = s_spawnpt.angles;
  vh_littlebird1 thread zodiac_littlebird_logic((0, 0, 0));
  vh_littlebird1 thread littlebird_fire(5.5, 5.0);
  wait 0.5;
  vh_littlebird2 = spawn_vehicle_from_targetname("us_littlebird");
  vh_littlebird2.origin = s_spawnpt.origin;
  vh_littlebird2.angles = s_spawnpt.angles;
  vh_littlebird2 thread zodiac_littlebird_logic((-700, 0, 100));
  vh_littlebird2 thread littlebird_fire(7, 4.5);
  wait 0.3;
  vh_littlebird3 = spawn_vehicle_from_targetname("us_littlebird");
  vh_littlebird3.origin = s_spawnpt.origin;
  vh_littlebird3.angles = s_spawnpt.angles;
  vh_littlebird3 thread zodiac_littlebird_logic((-200, 0, 150));
  vh_littlebird3 thread littlebird_fire(6.8, 4.0);
}

littlebird_fire(n_delay, n_firetime) {
  self endon("death");
  wait(n_delay);
  self thread fire_turret_for_time(n_firetime, 1);
  self thread fire_turret_for_time(n_firetime, 2);
}

zodiac_littlebird_logic(v_offset) {
  self endon("death");
  s_goal1 = getstruct("littlebird_zodiac_goal1", "targetname");
  s_goal2 = getstruct("littlebird_zodiac_goal2", "targetname");
  s_goal3 = getstruct("littlebird_zodiac_goal3", "targetname");
  self setneargoalnotifydist(300);
  self setspeed(40, 30, 25);
  self setvehgoalpos(s_goal1.origin + v_offset, 0);
  self waittill_any("goal", "near_goal");
  self setvehgoalpos(s_goal2.origin + v_offset, 0);
  self waittill_any("goal", "near_goal");
  self setspeed(80, 30, 25);
  self setvehgoalpos(s_goal3.origin + v_offset, 0);
  self waittill_any("goal", "near_goal");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

phantom_truck_killer() {
  wait 2;
  level thread spawn_gaz_trucks();
  wait 4;
  vh_phantom1 = spawn_vehicle_from_targetname("us_phantom");
  vh_phantom1 thread go_path(getvehiclenode("start_truck_killer1", "targetname"));
  vh_phantom1 thread phantom_building_rockets();
  wait 0.5;
  vh_phantom2 = spawn_vehicle_from_targetname("us_phantom");
  vh_phantom2 thread go_path(getvehiclenode("start_truck_killer2", "targetname"));
  vh_phantom2 thread phantom_fire_rocket();
  wait 0.7;
  vh_phantom3 = spawn_vehicle_from_targetname("us_phantom");
  vh_phantom3 thread go_path(getvehiclenode("start_truck_killer3", "targetname"));
  vh_phantom3 thread phantom_fire_rocket();
  wait 1;
  flag_set("destroy_gaz_trucks");
}

spawn_gaz_trucks() {
  vh_truck1 = spawn_vehicle_from_targetname("pan_gaz_truck");
  vh_truck1 thread go_path(getvehiclenode("start_gaz_truck", "targetname"));
  vh_truck1 thread gaz_truck_destroy();
  wait 1.5;
  vh_truck2 = spawn_vehicle_from_targetname("pan_gaz_truck");
  vh_truck2 thread go_path(getvehiclenode("start_gaz_truck", "targetname"));
  vh_truck2 thread gaz_truck_destroy();
  wait 1.8;
  vh_truck3 = spawn_vehicle_from_targetname("pan_gaz_truck");
  vh_truck3 thread go_path(getvehiclenode("start_gaz_truck", "targetname"));
  vh_truck3 thread gaz_truck_destroy();
  flag_wait("destroy_gaz_trucks");
}

gaz_truck_destroy() {
  self endon("death");
  play_fx("fx_vlight_headlight_default", self.origin, self.angles, undefined, 1, "tag_headlight_left", 1);
  play_fx("fx_vlight_headlight_default", self.origin, self.angles, undefined, 1, "tag_headlight_right", 1);
  play_fx("fx_vlight_brakelight_default", self.origin, self.angles, undefined, 1, "tag_tail_light_left", 1);
  play_fx("fx_vlight_brakelight_default", self.origin, self.angles, undefined, 1, "tag_tail_light_right", 1);
  flag_wait("destroy_gaz_trucks");
  wait(randomfloatrange(0.5, 1.0));
  self vehicle_detachfrompath();
  wait 0.1;
  self launchvehicle((100, 200, 300), anglestoright(self.angles) * 180, 1, 1);
  wait 0.5;
  play_fx("cessna_fire", self.origin, self.angles, undefined, 1, "tag_origin", 1);
  self thread gaz_truck_delete();
  radiusdamage(self.origin, 100, 4000, 3500);
}

gaz_truck_delete() {
  self waittill("death");
  wait 2;
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

phantom_fire_rocket() {
  self endon("death");
  self veh_magic_bullet_shield(1);
  wait 1.5;
  magicbullet("apache_rockets", self.origin + anglestoforward(self.angles) * 200, self.origin + anglestoforward(self.angles) * 1000);
  wait 0.1;
  magicbullet("apache_rockets", self.origin + anglestoforward(self.angles) * 200, self.origin + anglestoforward(self.angles) * 1000);
}

phantom_building_rockets() {
  self endon("death");
  self veh_magic_bullet_shield(1);
  wait 1.5;
  building_missile_1 = getstruct("building_missile_1", "targetname");
  building_missile_2 = getstruct("building_missile_2", "targetname");
  magicbullet("apache_rockets", self.origin + anglestoforward(self.angles) * 200, building_missile_1.origin);
  wait 0.1;
  magicbullet("apache_rockets", self.origin + anglestoforward(self.angles) * 200, building_missile_2.origin);
  level notify("blow_up_building");
}

set_zodiac_exit_ads() {
  scene_wait("zodiac_approach_player");
  self setforceads(1);
  self showviewmodel();
  self enableweapons();
  scene_wait("zodiac_dismount_player");
  self setforceads(0);
}

set_zodiac_overlay() {
  wait 0.25;
  self setclientflag(7);
  scene_wait("zodiac_approach_player");
  self clearclientflag(7);
}

can_see_buildings_on_zodiac() {
  wait 7;
  flag_set("can_turn_off_lights");
  wait 3;
  flag_clear("can_turn_off_lights");
}

turn_off_hotel_lights() {
  s_hotel = getstruct("hotel_group_1", "targetname");

  while(!level.player is_player_looking_at(s_hotel.origin, 0.95) || !flag("can_turn_off_lights"))
    wait 0.05;

  exploder(251);
  wait 0.5;
  a_floor_numbers = array(1, 2, 3, 4, 5, 6);
  a_floor_numbers = array_randomize(a_floor_numbers);

  for(i = 0; i < 3; i++) {
    a_hotel_lights = getentarray("hotel_floor_" + a_floor_numbers[i], "targetname");

    foreach(m_hotel_light in a_hotel_lights)
    m_hotel_light delete();
  }

  wait 0.4;

  for(i = 3; i < 6; i++) {
    a_hotel_lights = getentarray("hotel_floor_" + a_floor_numbers[i], "targetname");

    foreach(m_hotel_light in a_hotel_lights)
    m_hotel_light delete();
  }
}

beach_dialog() {
  level.mason say_dialog("maso_mcknight_it_s_maso_0");
  level.player say_dialog("mckn_seal_teams_will_secu_0");
  level.player say_dialog("mckn_i_ll_provide_over_wa_0");
  level.mason say_dialog("maso_didn_t_hudson_nix_th_0");
  level.player say_dialog("mckn_if_he_did_he_didn_t_0");
  level.player say_dialog("mckn_good_luck_mason_m_0");
  flag_set("beach_intro_vo_done");
  flag_wait("contextual_melee_done");
  level.mason say_dialog("maso_you_know_what_they_s_0");
  level thread general_enemy_vo();
  trigger_wait("trig_first_color_street");
  level notify("stop_general_enemy_vo");
}

challenge_thinkfast(str_notify) {
  level endon("flare_guy_alive");
  flag_wait("contextual_melee_success");
  self notify(str_notify);
}

challenge_kill_ai_with_flak_jacket(str_notify) {
  level waittill("kill_ai_with_flak_jacket");
  self notify(str_notify);
}

challenge_destroy_learjet(str_notify) {
  flag_wait("player_destroyed_learjet");
  self notify(str_notify);
}

challenge_turret_kill(str_notify) {
  trigger_wait("trig_color_leer_jet");

  while(true) {
    level waittill("killed_by_turret");
    self notify(str_notify);
  }
}

challenge_find_weapon_cache(str_notify) {
  level waittill("slums_found_weapon_cache");
  self notify(str_notify);
}

end_boat_sounds() {
  level.player stoploopsound(1);
  level.player playsound("evt_boat_stop");
}

clean_up_christmas_lights() {
  if(level.skipto_point == "house") {
    lights = getentarray("fxanim_christmas_lights", "targetname");
    array_delete(lights);
  } else {
    wait 10;
    lights = getentarray("fxanim_christmas_lights", "targetname");
    array_delete(lights);
  }
}

zodiac_jet_flyover() {
}

invasion_read() {
  a_zodiac_littlebird_armada = spawn_vehicles_from_targetname_and_drive("zodiac_littlebird_armada");

  foreach(heli in a_zodiac_littlebird_armada)
  heli thread delete_vehicle_after_opening();

  a_intro_building_jets = spawn_vehicles_from_targetname_and_drive("intro_building_jet");

  foreach(jet in a_intro_building_jets)
  jet thread delete_vehicle_after_opening();

  level.player playsound("evt_zodiac_flyby_f");
  level thread temp_building_fx_explosion();
  intro_convoy_jet = spawn_vehicle_from_targetname_and_drive("intro_convoy_jet");
  intro_convoy_jet thread delete_vehicle_after_opening();
  wait 4.5;
  level thread sky_fire_light_ambience("airfield", "motel_scene_end");
  exploder(101);
}

delete_vehicle_after_opening() {
  self endon("delete");
  self endon("death");
  scene_wait("zodiac_dismount_player");
  self delete();
}

ac130_fire() {
  level endon("stop_ac130");
  wait 2;
  s_spawnpt = getstruct("ac130_fake_spawnpt", "targetname");
  vh_ac130 = spawn_vehicle_from_targetname("us_littlebird");
  vh_ac130.origin = s_spawnpt.origin;
  vh_ac130.angles = s_spawnpt.angles;
  vh_ac130 hide();
  vh_ac130 thread ac130_fake_move(s_spawnpt);
  e_ac130 = spawn("script_model", vh_ac130.origin);
  e_ac130 setmodel("tag_origin");
  e_ac130.angles = (45, 270, 0);
  e_ac130 linkto(vh_ac130);

  while(true) {
    playfxontag(level._effect["ac130_intense_fake_no_impact"], e_ac130, "tag_origin");
    wait(randomfloatrange(1.0, 1.5));
  }
}

ac130_fake_move(s_org) {
  self endon("death");
  self veh_magic_bullet_shield(1);
  self setneargoalnotifydist(300);
  self setspeed(15, 10, 5);
  self setvehgoalpos(s_org.origin, 0);
  self waittill_any("goal", "near_goal");

  for(s_goal = getstruct(s_org.target, "targetname"); 1; s_goal = getstruct(s_goal.target, "targetname")) {
    self setvehgoalpos(s_goal.origin, 0);
    self waittill_any("goal", "near_goal");

    if(flag("stop_ac130")) {
      self.delete_on_death = 1;
      self notify("death");

      if(!isalive(self))
        self delete();
    }
  }
}

temp_building_fx_explosion() {
  level waittill("blow_up_building");
  wait 0.9;
  hotel = getent("pristine_hotel", "targetname");
  hotel hide();
  exploder(250);
}

temp_convoy_fx_explosion() {
  nd_intro_convoy_boom = getvehiclenode("intro_convoy_boom", "script_noteworthy");
  nd_intro_convoy_boom waittill("trigger");
  iprintlnbold("convoy boom");
}

delete_zodiac_scenes() {
  run_scene("zodiac_leaves_beach");
  delete_ais_from_scene("zodiac_approach_seal_group_1");
  delete_ais_from_scene("zodiac_approach_seal_group_2");
  delete_ais_from_scene("zodiac_approach_seal_group_3");
  delete_models_from_scene("zodiac_approach_seal_boat_1");
  delete_models_from_scene("zodiac_approach_seal_boat_2");
  delete_models_from_scene("zodiac_approach_seal_boat_3");
}

zodiac_seal_squad() {
  level thread run_scene("zodiac_approach_seal_boat_1");
  level thread run_scene("zodiac_approach_seal_group_1");
  level thread run_scene("zodiac_approach_seal_boat_2");
  level thread run_scene("zodiac_approach_seal_group_2");
  level thread run_scene("zodiac_approach_seal_boat_3");
  level thread run_scene("zodiac_approach_seal_group_3");
}

zodiac_mason() {
  run_scene("zodiac_approach_mason");
  level.mason unlink();
  run_scene("zodiac_dismount_mason");
  nd_mason_beach = getnode("nd_mason_beach", "targetname");
  level.mason setgoalnode(nd_mason_beach);
  level.mason waittill("goal");
}

beach_main() {
  level.mason change_movemode("cqb_sprint");
  level.mason set_ignoreall(1);
  level.mason set_ignoreme(1);
  scene_wait("zodiac_dismount_player");
  wait 0.05;
  level.player setlowready(1);
  level.player enableweaponfire();
  level thread trigger_beach_obj();
  level.player thread player_walk_speed_adjustment(level.mason, "player_contextual_start", 128, 256, 0.25, 0.8);
  level thread beach_dialog();
  level.mason mason_movement_on_beach();
  flag_wait("player_at_first_blood");
  level.mason.goalradius = 32;
  playsoundatposition("evt_bridge_trucks_by", (-23474, -8785, 322));
  a_beach_intro_trucks = spawn_vehicles_from_targetname_and_drive("intro_civ_trucks");

  foreach(vh_truck in a_beach_intro_trucks)
  vh_truck thread intro_truck_behaviour();

  level thread mason_contextual_kill();
  level thread melee_guard_02();
  level thread play_fxanim_building_rubble();
  level thread parking_lot_scene();
  level thread player_contextual_kill();
  level thread parking_lot_exit();
  level thread kill_all_parkinglot();
  level thread kill_non_visable_parkinglot();
  level thread parking_lot_enemy_vo();
  ai_contextual_guard = simple_spawn_single("beach_contextual_guard");
  ai_contextual_guard thread beach_contextual_guard();
  flag_wait("setup_runway_standoff");
  autosave_by_name("after_parking_lot_battle");
}

trigger_beach_obj() {
  trigger_wait("trigger_obj_beach_1");
  flag_set("beach_obj_1");
  trigger_wait("trigger_obj_beach_2");
  flag_set("beach_obj_2");
  trigger_wait("trigger_obj_beach_3");
  flag_set("beach_obj_3");
}

mason_movement_on_beach() {
  t_move_up_to_drain = getent("trig_move_up_to_drain", "script_noteworthy");
  t_move_up_to_drain trigger_off();
  self.goalradius = 4;
  self waittill("goal");
  t_move_up_to_drain trigger_on();
}

beach_contextual_guard() {
  self.goalradius = 8;
  trigger_wait("trig_contextual_melee");
  self delete();
}

beach_walk_speed_adjustment() {
  level endon("player_contextual_start");
  self.n_speed_scale_min = 0.45;
  self.n_speed_scale_max = 0.75;

  while(true) {
    n_dist = distance2d(level.player.origin, level.mason.origin);

    if(n_dist < 128)
      self setmovespeedscale(self.n_speed_scale_min);
    else if(n_dist > 256)
      self setmovespeedscale(self.n_speed_scale_max);
    else {
      n_speed_scale = linear_map(n_dist, 128, 256, self.n_speed_scale_min, self.n_speed_scale_max);
      self setmovespeedscale(n_speed_scale);
    }

    wait 0.05;
  }
}

runway_dialog() {
  trigger_wait("trig_first_color_street");
  level.player say_dialog("mckn_mason_it_s_mcknight_0");
  level.player say_dialog("mckn_we_have_pdf_units_po_0");
  level.player say_dialog("mckn_i_ve_tried_to_warn_t_0");
  level.mason say_dialog("maso_we_re_on_our_way_m_0");
  level.player say_dialog("wood_what_about_false_pro_0");
  level.mason say_dialog("maso_awaiting_hudson_s_go_0");
  scene_wait("mason_skylight_approach");
  level thread skylight_nag();
  trigger_wait("player_jumped_rafters");

  if(flag("hangar_gone_hot")) {
    return;
  }
  if(level.player hasperk("specialty_trespasser")) {
    level.mason say_dialog("maso_woods_get_to_the_c_0");
    level.mason say_dialog("maso_seal_the_door_give_0");
  }
}

going_up_to_roof_nag() {
  level endon("player_on_roof");
  level thread start_vo_nag_group_flag("going_up_to_roof_nag", "player_on_roof", 16, 3, 0, 3);
}

skylight_nag() {
  level endon("player_near_skylight");
  add_vo_to_nag_group("skylight_nag", level.mason, "maso_come_on_woods_pic_0");
  add_vo_to_nag_group("skylight_nag", level.mason, "maso_through_the_skylight_0");
  add_vo_to_nag_group("skylight_nag", level.mason, "maso_pick_it_up_woods_0");
  level thread start_vo_nag_group_flag("skylight_nag", "player_near_skylight", 16, 3, 0, 3);
}

melee_guard_02() {
  ai_mason_kill_guard = simple_spawn_single("mason_kill_guard");
  ai_mason_kill_guard.animname = "guard_3";
  run_scene_first_frame("guard_03_in");
  trigger_wait("trig_contextual_melee");
  run_scene("guard_03_in");
  flag_wait("player_contextual_start");
  run_scene("guard_03_kill");
}

melee_guard_03() {
  flag_wait("player_contextual_start");
  ai_flare_guy = simple_spawn_single("flare_guy");
  ai_flare_guy.animname = "flare_guy";
  delay_thread(3, ::open_flareguy_door);
  level thread run_scene("flare_guy_walkout");
  level thread flare_guard_lives();
  flag_wait("knife_event_finished");
  level thread screen_message_delete();

  if(flag("contextual_melee_success"))
    run_scene("flare_guy_killed");
  else {
    run_scene("flare_guy_lives");
    nd_flareguy = getnode("nd_flareguy", "targetname");
    ai_flare_guy setgoalnode(nd_flareguy);
  }

  level thread ladder_obj_breadcrumb();
}

flare_guard_lives() {
  level endon("knife_event_finished");
  scene_wait("flare_guy_walkout");
  level notify("flare_guy_alive");
}

open_flareguy_door() {
  m_flareguy_door = getent("m_flareguy_door", "targetname");
  m_flareguy_door rotateyaw(-130, 0.6, 0.2, 0.05);
  m_flareguy_door playsound("evt_guards_door_open");
}

player_contextual_kill() {
  level.mason thread beach_kill_vo();
  trigger_wait("player_near_sewer");
  level.player setlowready(0);
  level.player.weap_before_knife = level.player getweaponslistprimaries()[0];
  level.player giveweapon("knife_held_80s_sp");
  level.player switchtoweapon("knife_held_80s_sp");
  level.player disableweaponcycling();
  level.player disableoffhandweapons();
  trigger_wait("trig_contextual_melee");
  level thread melee_guard_03();
  flag_set("player_climbs_up_ladder");
  autosave_by_name("pre_knife_kill");
  level.player startcameratween(1);
  run_scene("player_climbs_up");
  flag_set("player_contextual_start");
  level thread maps\_audio::switch_music_wait("PANAMA_CONTEXT_GO", 2);
  level thread run_scene("player_melee_whistle");
  flag_wait("knife_event_finished");
  flag_set("button_wait_done");

  if(flag("contextual_melee_success"))
    run_scene("player_knife_kill");
  else
    run_scene("player_knife_no_kill");

  level thread maps\_audio::switch_music_wait("PANAMA_PRE_HANGAR_FIGHT", 3);
  level thread give_player_godmode_for_timer_after_knife_throw();
  delay_thread(0.5, ::autosave_now, "after_knife_kill");
  flag_set("contextual_melee_done");
  level.player enableweaponcycling();
  level.player switchtoweapon(level.player.weap_before_knife);
  level.player takeweapon("knife_held_80s_sp");
  level.player enableoffhandweapons();
  level.player.ignoreme = 0;
  level.player setmovespeedscale(1);
}

knife_throw_prompt(guy) {
  screen_message_create(&"PANAMA_CONTEXTUAL_KILL");
  player_contextual_button_press();
  flag_set("knife_event_finished");
}

give_player_godmode_for_timer_after_knife_throw() {
  level.player.overrideplayerdamage = ::player_immunity_override;
  wait 4;
  level.player.overrideplayerdamage = undefined;
}

player_immunity_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name) {
  return false;
}

beach_kill_vo() {
  level endon("player_climbs_up_started");
  trigger_wait("trig_shh_vo");
  flag_wait("beach_intro_vo_done");

  if(!flag("mason_drain_approach_started"))
    self say_dialog("maso_shhh_hold_up_0");

  flag_wait("mason_getting_in_drain");
  self say_dialog("maso_take_em_woods_0");
}

parking_lot_enemy_vo() {
  flag_wait("contextual_melee_done");
  vo_struct = getent("parking_lot_VO_struct", "targetname");
  vo_struct say_dialog("pdf1_behind_us_by_the_g_0", 1, 1);
  vo_struct say_dialog("pdf2_take_defensive_posit_0", 3, 1);
  vo_struct say_dialog("pdf1_return_fire_0", 3, 1);
  vo_struct say_dialog("pdf1_get_more_men_up_here_0", 5, 1);
}

do_little_bird_beach_flyby() {
  trigger_wait("trig_shh_vo");
  lb1 = spawn_vehicle_from_targetname("little_bird_fly_by_1");
  lb2 = spawn_vehicle_from_targetname("little_bird_fly_by_2");
  lb1 setspeedimmediate(80);
  lb2 setspeedimmediate(80);
  lb1 setdefaultpitch(25);
  lb2 setdefaultpitch(25);
  lb1_dest = getstruct("little_bird_fly_by_1_dest");
  lb2_dest = getstruct("little_bird_fly_by_2_dest");
  lb1 setvehgoalpos(lb1_dest.origin);
  lb2 setvehgoalpos(lb2_dest.origin);
  lb1 thread delete_on_goal();
  lb2 thread delete_on_goal();
}

delete_on_goal() {
  self waittill("goal");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

play_fxanim_building_rubble() {
  trigger_wait("trig_fxanim_building_rubble");
  level notify("fxanim_bldg_rubble_start");
}

box_truck_path() {
  self endon("death");
  nd_box_truck_stop = getvehiclenode("box_truck_stop", "script_noteworthy");
  nd_box_truck_stop waittill("trigger");
  self setspeedimmediate(0);
  wait 1.5;
  iprintlnbold("Guard: Leave the box, get moving!");
  wait 7;
  self resumespeed(10);
}

player_contextual_button_press(guy) {
  level endon("flare_guy_alive");
  level.player waittill_attack_button_pressed();
  flag_set("contextual_melee_success");
  screen_message_delete();
}

flare_sky_effect(guy) {
  s_flare_sky_effect = getstruct("flare_sky_effect", "targetname");
  e_flare_weapon_effect = getent("flare_weapon_effect", "targetname");
  e_flare_effect_mover = spawn("script_origin", e_flare_weapon_effect.origin);
  e_flare_effect_mover setmodel("tag_origin");
  e_flare_weapon_effect linkto(e_flare_effect_mover);
  playfx(getfx("fx_pan_signal_flare"), e_flare_weapon_effect.origin);
}

flare_guy_lives_flare(guy) {
  m_flare_gun = get_model_or_models_from_scene("flare_guy_lives", "flare_gun");
  playfxontag(level._effect["fx_pan_signal_flare"], m_flare_gun, "tag_fx");
  exploder(298);
}

flare_guy_killed_flare(guy) {
  m_flare_gun = get_model_or_models_from_scene("flare_guy_killed", "flare_gun");
  playfxontag(level._effect["fx_pan_signal_flare"], m_flare_gun, "tag_fx");
  exploder(298);
}

mason_contextual_kill() {
  level.mason disable_ai_color();
  level thread mason_drain();
  flag_wait("player_contextual_start");
  run_scene("mason_melee_kill");
  level.mason change_movemode();
  level.mason enable_ai_color();
  level.mason set_ignoreall(0);
  level.mason set_ignoreme(0);
  trigger = getent("after_knife_color_trigger", "targetname");
  trigger activate_trigger();
  waittill_ai_group_amount_killed("parking_lot_guys", 2);
  trigger_use("front_parking_lot_color");
  waittill_ai_group_spawner_count("parking_lot_guys", 4);
  trigger_use("spawn_parking_lot_truck");
  waittill_ai_group_ai_count("parking_lot_guys", 1);
  flag_set("parking_lot_laststand");
  level thread runway_dialog();
  trigger_use("trig_color_parking_end");
  waittill_ai_group_cleared("parking_lot_guys");
  trigger_use("trig_first_color_street");
  level.mason change_movemode("sprint");
}

mason_drain() {
  level endon("player_contextual_start");
  level thread run_scene("mason_drain_approach");
  flag_wait("mason_drain_approach_started");
  flag_set("mason_getting_in_drain");
  scene_wait("mason_drain_approach");
  flag_set("mason_at_drain");
  run_scene("mason_drain_walks2back");
  level thread run_scene("mason_drain_loop");
}

open_grate_check() {
  return flag("player_opened_grate");
}

parking_lot_backup() {
  flag_wait("parking_lot_laststand");
  a_parking_lot_guys = get_ai_group_ai("parking_lot_guys");

  foreach(guy in a_parking_lot_guys)
  guy set_spawner_targets("parking_lot_laststand");

  v_parking_lot_backup_truck = spawn_vehicle_from_targetname_and_drive("parking_lot_backup_truck");
}

spin_rooftop_fans() {
  level endon("turn_off_rooftop_fans");
  fan_array = getentarray("rooftop_fan", "targetname");

  while(true) {
    foreach(fan in fan_array)
    fan rotatevelocity((0, randomintrange(400, 450), 0), 0.5);

    wait 0.5;
  }
}

spin_radio_tower() {
  level endon("fxanim_radar_tower_start");
  tower = getent("radar_tower_collapse", "targetname");
  tower hide();
  tower_disk = getent("radar_disk_top", "targetname");

  while(true) {
    tower_disk rotatevelocity(vectorscale((0, 1, 0), 45.0), 1);
    wait 1;
  }
}

parking_lot_scene() {
  hidden = [];
  hidden["prone"] = 0;
  hidden["crouch"] = 0;
  hidden["stand"] = 0;
  alert = [];
  alert["prone"] = 0;
  alert["crouch"] = 0;
  alert["stand"] = 0;
  spotted = [];
  spotted["prone"] = 0;
  spotted["crouch"] = 0;
  spotted["stand"] = 0;
  stealth_detect_ranges_set(hidden, alert, spotted);
  level.player stealth_friendly_movespeed_scale_set(hidden, alert, spotted);
  a_parkling_lot_smoker = simple_spawn("parkling_lot_smoker");

  foreach(smoker_guy in a_parkling_lot_smoker) {
    n_surprise_anim = "exchange_surprise_" + randomint(level.surprise_anims);
    smoker_guy thread stealth_ai_idle_and_react(smoker_guy, "smoke_idle", n_surprise_anim);
  }

  a_parkling_lot_bored = simple_spawn("parkling_lot_bored");

  foreach(bored_guy in a_parkling_lot_bored) {
    n_surprise_anim = "exchange_surprise_" + randomint(level.surprise_anims);
    bored_guy thread stealth_ai_idle_and_react(bored_guy, "bored_idle", n_surprise_anim);
  }

  flag_wait("player_contextual_start");
  simple_spawn("parking_lot_patroller");
  flag_wait("contextual_melee_done");
  simple_spawn("parking_lot_frontline");
  level thread table_flip();
  level thread window_entries();
  level thread car_slide();
  level thread climb_over_wall();
  trigger_wait("spawn_parking_lot_truck");
  vh_parking_lot_truck = spawn_vehicle_from_targetname_and_drive("parking_lot_truck");
  vh_parking_lot_truck playsound("evt_pickup_drive_in");
}

car_slide() {
  run_scene_first_frame("car_slide");
  s_lookat_car_slide = getstruct("lookat_car_slide", "targetname");

  while(!level.player is_player_looking_at(s_lookat_car_slide.origin, 0.95))
    wait 0.05;

  run_scene("car_slide");
}

climb_over_wall() {
  a_spawner_numbers = array(0, 1, 2);
  a_spawner_numbers = array_randomize(a_spawner_numbers);
  a_wall_climbers = [];

  for(i = 0; i < 2; i++) {
    wait 3;
    simple_spawn_single("wall_climber_" + a_spawner_numbers[i]);
  }
}

table_flip() {
  level endon("table_flip_open");
  level endon("table_flip_guy_died");
  run_scene_first_frame("table_flip_hall_table");
  run_scene_first_frame("table_flip_open_table");
  trigger_wait("trig_table_flip_hall");
  s_window_table_flip = getstruct("lookat_window_table_flip", "targetname");

  while(!level.player is_player_looking_at(s_window_table_flip.origin, 0.95))
    wait 0.05;

  level notify("window_table_flip");
  m_window = getent("window_3", "targetname");
  m_window rotateyaw(-145, 1);
  level thread close_window_3();
  level thread run_scene("dive_over");
  wait 0.05;
  ai_window_dive = getent("window_table_flip_ai", "targetname");
  ai_window_dive thread waittill_death_to_send_notify("table_flip_guy_died");
  ai_window_dive endon("death");
  nd_after_table_flip_open = getnode("table_flip_open_node", "targetname");
  nd_after_table_flip_open thread table_flip_open(ai_window_dive);
  scene_wait("dive_over");
  level notify("table_hall");
  level thread run_scene("table_flip_hall_ai");
  flag_wait("table_flip_hall_ai_started");
  level thread run_scene("table_flip_hall_table");
  scene_wait("table_flip_hall_ai");
}

close_window_3() {
  wait 1;
  m_window = getent("window_3", "targetname");
  m_window rotateyaw(145, 1);
}

waittill_death_to_send_notify(str_notify) {
  self waittill("death");
  level notify(str_notify);
}

table_flip_setup(str_side) {
  run_scene_first_frame(str_side + "_table");
  m_clip_before = getent(str_side + "_clip_before", "targetname");
  m_clip_before disconnectpaths();
}

table_flip_open(ai_window_dive) {
  level endon("window_table_flip");
  level endon("table_flip_guy_died");
  level endon("table_hall");
  ai_window_dive endon("death");
  trigger_wait("trig_table_flip_open");
  level notify("table_flip_open");
  scene_wait("dive_over");
  level thread run_scene("table_flip_open_ai");
  flag_wait("table_flip_open_ai_started");
  level thread run_scene("table_flip_open_table");
  scene_wait("table_flip_open_ai");
}

window_entries() {
  level endon("setup_runway_standoff");
  trigger_wait("trig_window_entries");
  s_window_entries = getstruct("lookat_window_entries", "targetname");

  while(!level.player is_player_looking_at(s_window_entries.origin, 0.95))
    wait 0.05;

  level thread run_scene("window_mantle");
  level thread run_scene("window_dive");
  m_window = getent("window_1", "targetname");
  m_window rotateyaw(-111, 1);
  m_window = getent("window_2", "targetname");
  m_window rotateyaw(145, 1);
  wait 1;
  m_window = getent("window_1", "targetname");
  m_window rotateyaw(111, 1);
  m_window = getent("window_2", "targetname");
  m_window rotateyaw(-145, 1);
}

truck_pdf_1() {
  self endon("death");
  level thread run_scene("truck_guy_1_loop");
  flag_wait("contextual_melee_done");
  self delete();
}

truck_pdf_2() {
  self endon("death");
  level thread run_scene("truck_guy_2_loop");
  flag_wait("contextual_melee_done");
  self delete();
}

setup_gunner_behaviour() {
  self endon("death");
  self.ignoreme = 1;
  flag_wait("spawn_learjet_wave_2");
  self.ignoreme = 0;
}

gunner_death_logic() {
  self thread kill_gunner_once_at_motel();
  self waittill("death");
  vh_truck = getent("vh_learjet_truck", "targetname");
  vh_truck makevehicleusable();
  flag_set("learjet_truck_enabled");
  a_enemies = getaiarray("axis");

  if(isDefined(a_enemies) && a_enemies.size > 0) {
    ai_random = a_enemies[randomint(a_enemies.size)];

    if(isalive(ai_random)) {
      level.b_enemy_is_talking = 1;
      ai_random say_dialog("pdf_damn_we_lost_our_gu_0");
      level.b_enemy_is_talking = undefined;
    }
  }

  level.mason say_dialog("maso_woods_get_on_it_0");
}

kill_gunner_once_at_motel() {
  self endon("death");
  trigger_wait("trig_motel_fail");
  self bloody_death();
}

gunner_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(e_attacker != level.player && e_attacker != level.mason)
    n_damage = 0;

  return n_damage;
}

learjet_turret_truck() {
  e_turret_target = getent("learjet_turret_target", "targetname");
  s_target_start = getstruct("turret_target_start", "targetname");
  s_target_end = getstruct("turret_target_end", "targetname");
  vo = getent("vo_for_lear_jet", "targetname");
  vo say_dialog("pdf2_bring_up_the_mg_truc_0");
  wait 0.5;
  e_turret_target playsound("evt_lear_jet_truck");
  vh_learjet_truck = spawn_vehicle_from_targetname_and_drive("vh_learjet_truck");
  vh_learjet_truck set_turret_target(e_turret_target, undefined, 1);
  ai_gunner = getent("learjet_turret_guy_ai", "targetname");
  ai_gunner thread gunner_death_logic();
  ai_gunner.overrideactordamage = ::gunner_damage_override;
  vh_learjet_truck waittill("reached_end_node");
  wait 0.25;

  if(getdifficulty() == "easy")
    vh_learjet_truck maps\_turret::set_turret_burst_parameters(1, 2, 3, 4, 1);
  else
    vh_learjet_truck maps\_turret::set_turret_burst_parameters(3.0, 5.0, 1.0, 2.0, 1);

  vh_learjet_truck enable_turret(1);
  vh_learjet_truck thread vo_on_turret_dead();
  vh_learjet_truck endon("death");
  flag_wait("learjet_intro_vo_done");
  level.mason waittill_done_talking();

  if(!flag("learjet_truck_enabled"))
    level.mason say_dialog("maso_watch_that_truck_0");
}

vo_on_turret_dead() {
  self waittill("death");
  vo = getent("vo_for_lear_jet", "targetname");
  vo say_dialog("pdf1_we_lost_the_mg_0", 0, 1);
}

learjet_frontline_color() {
  waittill_ai_group_count("learjet_pdf_frontline", 2);
  flag_set("spawn_learjet_wave_2");
}

init_learjet_pdf_frontline_rpg() {
  self endon("death");
  e_pdf_rpg_target = getent("pdf_rpg_target", "targetname");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.goalradius = 32;
  nd_rpg_spot = getnode(self.target, "targetname");
  self force_goal(nd_rpg_spot, 32);
  self waittill("goal");
  self thread learjet_pdf_with_rpg_vo();
  wait 1;
  magicbullet("rpg_magic_bullet_sp", self gettagorigin("tag_flash"), e_pdf_rpg_target.origin);
  wait 1.5;
  nd_post_rpg = getnode("nd_post_rpg", "targetname");
  self force_goal(nd_post_rpg, 32);
  self.ignoreme = 0;
  self.ignoreall = 0;
  flag_set("learjet_pdf_with_rpg_at_final");
}

learjet_pdf_with_rpg_vo() {
  self endon("death");
  level.mason waittill_done_talking();
  flag_wait("learjet_pdf_with_rpg_at_final");
  level.mason waittill_done_talking();
  level.mason say_dialog("maso_rpg_second_floor_0", 1);
}

bash_door_pdf() {
  run_scene_first_frame("pdf_shoulder_bash");
  trigger_wait("trig_shoulder_bash", "script_noteworthy");
  run_scene("pdf_shoulder_bash");
  level thread maps\_audio::switch_music_wait("PANAMA_HOTEL_RUN", 8);
}

clean_up_stuff_before_hangar() {
  end_scene("zodiac_approach_seals");
  end_scene("zodiac_approach_seals2");
  a_enemies = getaiarray("axis");

  foreach(ai_enemy in a_enemies) {
    if(ai_enemy.origin[1] < -6144)
      ai_enemy delete();
  }
}

general_enemy_vo() {
  level endon("stop_general_enemy_vo");
  n_array_counter = 0;
  a_enemy_vo = array("pdf_keep_shooting_comra_0", "pdf_reloading_0", "pdf_we_can_t_let_them_ad_0", "pdf_don_t_let_them_move_0", "pdf_for_panama_0", "pdf_running_low_on_ammo_0", "pdf_we_cannot_fail_0", "pdf_fuck_you_americans_0", "pdf_we_have_to_win_this_0", "pdf_we_need_to_make_a_st_0");
  a_enemy_vo = random_shuffle(a_enemy_vo);

  while(true) {
    while(isDefined(level.b_enemy_is_talking))
      wait 0.05;

    level.mason waittill_done_talking();
    a_enemies = getaiarray("axis");

    if(a_enemies.size > 0) {
      ai_random = a_enemies[randomint(a_enemies.size)];

      if(isalive(ai_random))
        ai_random say_dialog(a_enemy_vo[n_array_counter]);

      n_array_counter++;

      if(n_array_counter == a_enemy_vo.size) {
        a_enemy_vo = random_shuffle(a_enemy_vo);
        n_array_counter = 0;
      }

      wait(randomfloatrange(8.1, 9.9));
    }

    wait 0.05;
  }
}

random_shuffle(a_items) {
  b_done_shuffling = undefined;
  item = a_items[a_items.size - 1];

  while(!(isDefined(b_done_shuffling) && b_done_shuffling)) {
    a_items = array_randomize(a_items);

    if(a_items[0] != item)
      b_done_shuffling = 1;

    wait 0.05;
  }

  return a_items;
}

learjet_main() {
  clean_up_stuff_before_hangar();
  level notify("turn_off_rooftop_fans");
  m_fxanim_learjet = getent("fxanim_private_jet", "targetname");
  trigger_wait("trig_color_leer_jet");
  level thread maps\createart\panama_art::learjet();
  exploder(299);
  level thread learjet_side_battle();
  level thread learjet_battle_seal_vs_pdf();
  level thread learjet_dialog();
  trigger_wait("trig_learjet_truck");
  level thread learjet_turret_truck();
  autosave_by_name("learjet_battle_begin");
  level thread general_enemy_vo();
  trigger_wait("trig_learjet_wave_1");
  simple_spawn("learjet_wave_1");
  simple_spawn_single("learjet_wave_1_rpg", ::init_learjet_pdf_frontline_rpg);
  trigger_wait("trig_learjet_wave_2");
  wait 0.05;
  level thread learjet_rolling_door();
  level thread learjet_retreat();
  level thread learjet_back_left();
  level thread learjet_back_right();
  level thread learjet_multiple_enemy_vo();
  level thread learjet_middle_move_up_mason();
  trigger_wait("trig_learjet_wave_3");
  level thread seal_breaches();
  level thread player_door_kick();
  level thread pool_guy1_death();
  level thread make_dead_civs_at_motel();
  trigger_wait("trig_pool_anims");
  autosave_now("learjet_battle_done");
  level thread maps\_audio::switch_music_wait("PANAMA_HOTEL_RUN", 1);
  level thread pool_guy2_death();
  trigger_use("trig_color_post_bash");
  level.mason change_movemode("sprint");
  flag_set("learjet_battle_done");
}

make_dead_civs_at_motel() {
  run_scene_first_frame("dead_civ_1");
  run_scene_first_frame("dead_civ_2");
  run_scene_first_frame("dead_civ_3");
  run_scene_first_frame("dead_civ_4");
  dead_civ_model = get_model_or_models_from_scene("dead_civ_1", "dead_civ_1");
  dead_civ_model attach("c_pan_civ_male_head1");
  dead_civ_model = get_model_or_models_from_scene("dead_civ_2", "dead_civ_2");
  dead_civ_model attach("c_pan_civ_male_head2");
  dead_civ_model = get_model_or_models_from_scene("dead_civ_3", "dead_civ_3");
  dead_civ_model attach("c_pan_civ_female_head2");
  dead_civ_model = get_model_or_models_from_scene("dead_civ_4", "dead_civ_4");
  dead_civ_model attach("c_pan_civ_female_head1");
}

learjet_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name) {
  if(str_means_of_death == "MOD_EXPLOSIVE" && e_attacker == level.player) {
    if(!isDefined(level.player.destroyed_noriegas_jet)) {
      radiusdamage(self.origin, 256, 1000, 1000, level.player);
      stop_exploder(299);
      level.player.destroyed_noriegas_jet = 1;
      vo = getent("vo_for_lear_jet", "targetname");
      vo thread say_dialog("pdf1_we_ve_lost_the_plane_0", 2, 1);
    }
  }

  return n_damage;
}

learjet_middle_move_up_mason() {
  waittill_ai_group_amount_killed("learjet_frontline", 9);
  trigger_use("trig_learjet_color_3");
  trigger_use("trig_learjet_wave_3");
}

seal_breaches() {
  trigger_wait("trig_seal_breach_1");
  level thread general_seals();
  run_scene("seal_breach_1");
  ai_seal_a = getent("door_breach_a_1_ai", "targetname");

  if(isDefined(ai_seal_a) && isalive(ai_seal_a))
    ai_seal_a thread waittill_goal_and_die();

  ai_seal_a = getent("door_breach_a_2_ai", "targetname");

  if(isDefined(ai_seal_a) && isalive(ai_seal_a))
    ai_seal_a thread waittill_goal_and_die();
}

general_seals() {
  flag_wait("seal_breach_1_started");
  ai_seal = simple_spawn_single("general_seal_1");
  ai_seal change_movemode("cqb_sprint");
  ai_seal thread waittill_goal_and_die();
  wait 0.05;
  ai_seal = simple_spawn_single("general_seal_2");
  ai_seal change_movemode("cqb_sprint");
  ai_seal thread waittill_goal_and_die();
}

waittill_goal_and_die() {
  nd_goal = getnode(self.target, "targetname");
  self force_goal(nd_goal, 16);
  self delete();
}

learjet_multiple_enemy_vo() {
  level.mason waittill_done_talking();
  level.player say_dialog("wood_dammit_multiple_ene_0");
}

waittill_at_bash() {
  trigger_wait("trig_approach_door_bash");
  autosave_now("learjet_battle_done");
  flag_set("learjet_battle_done");
  self waittill("goal");
  flag_set("in_bash_position");
}

learjet_side_battle() {
  vh_learjet_gaz = spawn_vehicle_from_targetname_and_drive("vh_learjet_gaz");
  vh_learjet_gaz_2 = spawn_vehicle_from_targetname("vh_learjet_gaz_2");
  level thread seals_destroy_learjet();
}

learjet_rolling_door() {
  m_garage_door_segment_1 = getent("garage_door_segment1", "targetname");
  m_garage_door_segment_2 = getent("garage_door_segment2", "targetname");
  m_garage_door_segment_3 = getent("garage_door_segment3", "targetname");
  m_garage_door_segment_4 = getent("garage_door_segment4", "targetname");
  m_garage_door_segment_5 = getent("garage_door_segment5", "targetname");
  m_garage_door_segment_1 moveto(m_garage_door_segment_1.origin + vectorscale((0, 0, 1), 24.0), 1);
  m_garage_door_segment_2 moveto(m_garage_door_segment_2.origin + vectorscale((0, 0, 1), 48.0), 2);
  m_garage_door_segment_3 moveto(m_garage_door_segment_3.origin + vectorscale((0, 0, 1), 72.0), 3);
  m_garage_door_segment_4 moveto(m_garage_door_segment_4.origin + vectorscale((0, 0, 1), 96.0), 4);
  m_garage_door_segment_5 moveto(m_garage_door_segment_5.origin + vectorscale((0, 0, 1), 120.0), 5);
  level thread run_scene("rolling_door_guy");
  level thread run_scene("rolling_door_guy_2");
  level thread learjet_garage_guys_vo();
  m_garage_door_segment_1 waittill("movedone");
  m_garage_door_segment_1 delete();
  m_garage_door_segment_2 waittill("movedone");
  m_garage_door_segment_2 delete();
  m_garage_door_segment_3 waittill("movedone");
  m_garage_door_segment_3 delete();
  m_garage_door_segment_4 waittill("movedone");
  m_garage_door_segment_4 delete();
  m_garage_door_segment_5 waittill("movedone");
  m_garage_door_segment_5 delete();
  m_garage_clip = getent("garage_clip", "targetname");
  m_garage_clip connectpaths();
  m_garage_clip delete();
}

learjet_garage_guys_vo() {
  level.mason waittill_done_talking();
  level.mason say_dialog("maso_coming_through_the_g_0");
}

learjet_retreat() {
  trigger_wait("trig_learjet_retreat");
  a_learjet_enemies = getentarray("learjet_intro_pdf_ai", "targetname");
  nd_side_reinforcement_node = getnode("side_reinforcement_node", "targetname");

  foreach(ai_enemy in a_learjet_enemies) {
    ai_enemy setgoalnode(nd_side_reinforcement_node);
    ai_enemy.goalradius = 256;
    ai_enemy disable_tactical_walk();
  }
}

learjet_back_left() {
  trigger_wait("trig_learjet_back_left");
  ai_back_left = simple_spawn_single("learjet_back_left");
  ai_back_left change_movemode("sprint");
  ai_back_left waittill("goal");
  ai_back_left change_movemode();
  ai_back_left set_ignoreall(0);
}

learjet_back_right() {
  trigger_wait("trig_learjet_kick_down_back_door");
  m_back_door_clip = getent("garage_back_door_clip", "targetname");
  m_back_door_clip connectpaths();
  m_back_door_clip delete();
  level thread run_scene("learjet_back_door_kick");
}

learjet_back_door_open(ai_door_kick_pdf) {
  m_back_door_clip = getent("seal_breach_door_1_clip", "targetname");
  m_back_door_clip rotateyaw(145, 1);
  m_back_door = getent("garage_back_door", "targetname");
  m_back_door rotateyaw(145, 1);
}

seal_breach_door_open(ai_door_kick_pdf) {
  m_back_door = getent("seal_breach_door_1", "targetname");
  m_back_door rotateyaw(145, 1);
}

learjet_battle_seal_vs_pdf() {
  trigger_wait("trig_learjet_battle");
  cleanup_seals();
  trigger_wait("trig_learjet_color_1");
  level thread run_scene("learjet_battle_seal");
  run_scene("learjet_battle_pdf");
}

cleanup_seals() {
  a_ai_seal1 = getentarray("seal_group_1_ai", "targetname");

  if(isDefined(a_ai_seal1)) {
    foreach(ai_seal1 in a_ai_seal1)
    ai_seal1 die();
  }

  a_ai_seal2 = getentarray("seal_group_2_ai", "targetname");

  if(isDefined(a_ai_seal2)) {
    foreach(ai_seal2 in a_ai_seal2)
    ai_seal2 die();
  }

  spawn_manager_kill("trig_sm_runway_seals");
  wait 0.1;
  a_ai_hangar_seals = getentarray("hangar_seals_ai", "targetname");

  if(isDefined(a_ai_hangar_seals)) {
    foreach(ai_hangar_seal in a_ai_hangar_seals)
    ai_hangar_seal delete();
  }

  a_ai_foreshadow = get_ai_group_ai("foreshadow_seals");

  if(isDefined(a_ai_foreshadow)) {
    foreach(ai_foreshadow in a_ai_foreshadow)
    ai_foreshadow die();
  }

  a_ai_rescue_seals = get_ai_group_ai("rescue_seals");

  if(isDefined(a_ai_rescue_seals)) {
    foreach(ai_rescue_seals in a_ai_rescue_seals)
    ai_rescue_seals die();
  }

  a_ai_standoff_seals = get_ai_group_ai("standoff_seals");

  if(isDefined(a_ai_standoff_seals)) {
    foreach(ai_standoff_seals in a_ai_standoff_seals)
    ai_standoff_seals die();
  }
}

player_door_kick() {
  level endon("mason_bashes_door");
  flag_wait("start_shoulder_bash");
  level thread delete_door_bash_clip("start_shoulder_bash");
  simple_spawn("motel_path_runners", ::init_motel_path_runners);
  dead_body_pool = simple_spawn_single("dead_body_in_pool");

  if(isDefined(dead_body_pool))
    dead_body_pool thread ragdoll_death();

  flag_set("friendly_door_bash_done");
}

mason_door_bash() {
  level endon("player_kicks_door");
  flag_wait("in_bash_position");
  wait 0.05;
  level notify("mason_bashes_door");
  level thread delete_door_bash_clip("mason_shoulder_bash_started");
  simple_spawn("motel_path_runners", ::init_motel_path_runners);
  level thread run_scene("mason_shoulder_bash");
  flag_wait("mason_shoulder_bash_started");
  level thread run_scene("mason_shoulder_bash_door");
  level.mason say_dialog("maso_i_got_it_0");
  scene_wait("mason_shoulder_bash");
  flag_set("friendly_door_bash_done");
}

delete_door_bash_clip(str_flag) {
  flag_wait(str_flag);
  wait 1;
  m_door_bash_clip = getent("door_bash_clip", "targetname");

  if(isDefined(m_door_bash_clip))
    m_door_bash_clip delete();
}

intruder_box() {
  t_use = getent("trig_intruder", "targetname");
  t_use sethintstring(&"PANAMA_BREAK_LOCK");
  t_use setcursorhint("HINT_NOICON");
  t_use trigger_off();
  level.player waittill_player_has_intruder_perk();
  s_intruder_obj = getstruct("intruder_obj", "targetname");
  set_objective_perk(level.obj_intruder, s_intruder_obj.origin);
  t_use trigger_on();
  t_use waittill("trigger");
  t_use delete();
  remove_objective_perk(level.obj_intruder);
  run_scene("intruder");
  level.player giveweapon("nightingale_dpad_sp");
  level.player setactionslot(1, "weapon", "nightingale_dpad_sp");
  level.player givemaxammo("nightingale_dpad_sp");
  level.player thread nightingale_watch();
}

give_grenade(str_grenade_type) {
  players_grenades = [];
  a_player_weapons = self getweaponslist();

  foreach(weapon in a_player_weapons) {
    if(weapontype(weapon) == "grenade")
      arrayinsert(players_grenades, weapon, players_grenades.size);
  }

  if(players_grenades.size >= 2)
    self takeweapon(players_grenades[1]);

  self giveweapon(str_grenade_type);
  self givemaxammo(str_grenade_type);
}

learjet_audio() {
  level endon("jet_exp_audio");
  sound_ent = spawn("script_origin", self.origin);
  sound_ent thread learjet_audio_explode(self);
  self playsound("evt_learjet_poweron");
  wait 36;
  sound_ent playloopsound("evt_learjet_loop", 2);
}

learjet_audio_explode(jet) {
  level waittill("jet_exp_audio");
  jet stopsound("evt_learjet_poweron");
  self stoploopsound(0.1);
}

pool_guy1_death() {
  run_scene_first_frame("pool_guy_1");
  trigger_wait("trig_pool_anims");
  run_scene("pool_guy_1");
}

pool_guy2_death() {
  trigger_wait("trig_pool_anims");
  run_scene("pool_guy_2");
  exploder(260);
}

setup_mcknight_sniper() {
  self endon("death");
  self magic_bullet_shield();
  self.ignoreme = 1;
  self.ignoreall = 1;
  nd_sniper_node = getnode(self.target, "targetname");
  self force_goal(nd_sniper_node, 16);
}

learjet_far_color() {
  waittill_ai_group_count("learjet_pdf_backup", 7);
  trigger_use("trig_color_far_lear");
}

shop_door_opens() {
  e_garage_mid_piece = getent("garage_mid_piece", "targetname");
  e_garage_bottom_piece = getent("garage_bottom_piece", "targetname");
  e_garage_clip = getent("garage_clip", "targetname");
  door_snd = spawn("script_origin", e_garage_bottom_piece.origin);
  door_snd playsound("evt_door_start");
  door_snd playloopsound("evt_door_move", 1);
  e_garage_mid_piece movez(38, 5);
  e_garage_mid_piece connectpaths();
  e_garage_bottom_piece movez(74, 5);
  e_garage_bottom_piece connectpaths();
  e_garage_bottom_piece waittill("movedone");
  door_snd playsound("evt_door_stop");
  door_snd stoploopsound(0.3);
  e_garage_mid_piece delete();
  e_garage_bottom_piece delete();
  e_garage_clip connectpaths();
  e_garage_clip delete();
  wait 3;
  door_snd delete();
}

rpg_has_ammo() {
  if(level.player getweaponammoclip("rpg_sp") || level.player getweaponammostock("rpg_sp"))
    return true;

  return false;
}

learjet_dialog() {
  trigger_wait("trig_learjet_color_1");
  vh_learjet = getent("fxanim_private_jet", "targetname");
  vh_learjet thread learjet_audio();

  if(!flag("learjet_destroyed")) {
    level.player say_dialog("wood_noriega_s_plane_is_r_0");
    level.mason say_dialog("maso_woods_hit_it_with_0", 1);
  }

  a_weapons_list = level.player getweaponslist();

  foreach(str_weapon in a_weapons_list) {
    if(str_weapon == "rpg_sp" && rpg_has_ammo()) {
      level.mason say_dialog("maso_woods_hit_it_with_0");
      level.mason say_dialog("maso_don_t_let_it_take_of_0");
    }
  }

  flag_set("learjet_intro_vo_done");
  trigger_wait("trig_learjet_wave_3");
  level notify("stop_general_enemy_vo");
  level thread general_enemy_vo();
  trigger_wait("trig_learjet_color_4");
  level notify("stop_general_enemy_vo");
  level.player say_dialog("huds_mason_it_s_hudson_0");
  level.mason say_dialog("maso_where_the_hell_have_0");
  level.player say_dialog("huds_we_have_confirmation_0");
  level.player say_dialog("huds_adelina_hotel_room_0");
  flag_wait("friendly_door_bash_done");
  level.player say_dialog("mckn_i_have_visual_mult_0");
  level.player say_dialog("mckn_leave_them_to_me_0");
  level thread mcknight_clear_pool();
  level thread mcknight_sniping_clear_vo();
  flag_wait("player_near_motel");
  level.mason say_dialog("maso_225_s_upstairs_2nd_0");
  flag_wait("motel_approach_started");
  level.mason say_dialog("maso_on_me_0");
}

mcknight_clear_pool() {
  a_enemies_near_pool = getentarray("motel_path_runners_ai", "targetname");

  foreach(ai_near_pool in a_enemies_near_pool) {
    while(flag("mcknight_sniping"))
      wait 0.05;

    if(isalive(ai_near_pool))
      sniper_shoot(ai_near_pool);

    wait(randomfloatrange(2.1, 3.9));
  }
}

mcknight_sniping_clear_vo() {
  waittill_ai_group_cleared("before_motel_enemies");
  level.player say_dialog("mckn_you_re_clear_0");
}

open_bash_door(guy) {
  m_door_bash_clip = getent("door_bash_clip", "targetname");
  m_door_bash_clip delete();
  iprintln("door notetrack is getting hit");
  simple_spawn("motel_path_runners", ::init_motel_path_runners);
  level thread monitor_mason_motel_sprint();
}

monitor_mason_motel_sprint() {
  waittill_ai_group_cleared("motel_path_runners");
  level.mason change_movemode("sprint");
}

init_motel_path_runners() {
  self endon("death");
  self.ignoreall = 1;
  nd_die = getnode(self.target, "targetname");
  self setgoalnode(nd_die);
  self waittill("goal");
  self.ignoreall = 0;
}

temp_cleanup_func() {
  trigger_wait("trig_motel_obj");
  autosave_by_name("motel_breach");
  level.mcknight_sniper delete();
  ai = getaiarray();

  foreach(guy in ai)
  guy die();
}

monitor_player_distance() {
  level endon("start_intro_anims");

  while(true) {
    if(distancesquared(level.player.origin, level.mason.origin) <= 750) {
      setdvar("ui_deadquote", & "PANAMA_HANGAR_FAIL");
      level notify("mission failed");
      maps\_utility::missionfailedwrapper();
    }

    wait 0.2;
  }
}

hotel_path_fail() {
  trigger_wait("trig_hotel_warn");
  level.player thread display_hint("hangar_warning");
  trigger_wait("trig_hotel_fail");
  setdvar("ui_deadquote", & "PANAMA_HANGAR_FAIL");
  level notify("mission failed");
  maps\_utility::missionfailedwrapper();
}

learjet_challenge_think(m_fxanim_learjet) {
  level endon("motel_scene_end");
  jet_col = getent("jet_clip_destroyed", "targetname");
  jet_col notsolid();
  self.do_scripted_crash = 0;
  self thread seal_shoot_learjet();
  level thread learjet_explode_snd(m_fxanim_learjet);
  self waittill("death", e_attacker);
  jet_col solid();
  flag_set("learjet_destroyed");
  level notify("jet_exp_audio");

  if(level.player == e_attacker)
    flag_set("player_destroyed_learjet");

  self hide();
  m_fxanim_learjet show();
  level notify("fxanim_private_jet_start");
}

learjet_explode_snd(jet) {
  exp_ent = spawn("script_origin", jet.origin);
  level waittill("jet_exp_audio");
  exp_ent playsound("evt_learjet_explode");
  wait 12;
  exp_ent delete();
}

seal_shoot_learjet() {
  level endon("learjet_destroyed");
  trigger_wait("seal_shoot_learjet");
  wait 30;
  level thread run_scene("seal_rocket");
}

seals_destroy_learjet() {
  a_learjet_runway_pdf = simple_spawn("learjet_runway_pdf");
  a_learjet_rpg_seals = simple_spawn("learjet_rpg_seals", ::init_learjet_rpg_seals);
  a_learjet_intro_pdfs = simple_spawn("learjet_intro_pdf");
  createthreatbiasgroup("learjet_runway_seals");
  createthreatbiasgroup("learjet_intro_pdfs");

  foreach(ai_seal in a_learjet_rpg_seals)
  ai_seal setthreatbiasgroup("learjet_runway_seals");

  foreach(ai_intro_pdf in a_learjet_intro_pdfs) {
    ai_intro_pdf setthreatbiasgroup("learjet_intro_pdfs");
    ai_intro_pdf magic_bullet_shield();

    if(isDefined(ai_intro_pdf.script_noteworthy) && ai_intro_pdf.script_noteworthy == "learjet_intro_retreat")
      ai_intro_pdf_retreat = ai_intro_pdf;
  }

  setthreatbias("learjet_runway_seals", "learjet_intro_pdfs", 100);
  ai_intro_pdf_retreat thread learjet_intro_ai_retreat();
  trigger_wait("trig_learjet_truck");

  foreach(ai_intro_pdf in a_learjet_intro_pdfs)
  ai_intro_pdf stop_magic_bullet_shield();

  trigger_wait("seal_shoot_learjet");
  setthreatbias("learjet_runway_seals", "learjet_intro_pdfs", 0);
  createthreatbiasgroup("learjet_enemies");

  foreach(ai_intro_pdf in a_learjet_intro_pdfs) {
    if(isalive(ai_intro_pdf)) {
      if(!isDefined(ai_intro_pdf.script_noteworthy))
        ai_intro_pdf.goalradius = 2048;

      ai_intro_pdf setthreatbiasgroup("learjet_enemies");
    }
  }

  setthreatbias("learjet_enemies", "learjet_runway_seals", -10000);
  waittill_ai_group_count("learjet_runway_pdf", 3);
  nd_delete_learjet_seals = getnode("nd_delete_learjet_seals", "targetname");

  foreach(seal in a_learjet_rpg_seals) {
    seal.script_accuracy = 0.8;
    seal thread stack_up_and_delete(nd_delete_learjet_seals);
  }

  wait 3;

  foreach(seal in a_learjet_rpg_seals)
  seal.ignoreme = 1;
}

learjet_intro_ai_retreat() {
  self endon("death");
  trigger_wait("learjet_intro_retreat");
  nd_retreat = getnode("learjet_intro_retreat_node", "targetname");
  self setgoalnode(nd_retreat);
  self disable_tactical_walk();
  self waittill("goal");
  self.goalradius = 2048;
}

init_learjet_rpg_seals() {
  self endon("death");
  self.script_accuracy = 0.7;
  self.goalradius = 64;
  self magic_bullet_shield();
}

learjet_pdf_death_count() {
  level endon("learjet_destroyed");
  waittill_ai_group_ai_count("learjet_pdf", 2);
  flag_set("seals_destroy_learjet");
}

monitor_player_hangar_threat() {
  level endon("hangar_gone_hot");

  while(true) {
    level.player waittill_any("weapon_fired", "grenade_fire");
    level.mason set_ignoreall(0);
    setthreatbias("hangar_player", "hangar_pdf", 5000);
    setthreatbias("hangar_mason", "hangar_pdf", 5000);
    flag_set("remove_hangar_god_mode");
    flag_set("hangar_gone_hot");
    wait 0.05;
  }
}

monitor_skylight_damage() {
  level endon("hangar_gone_hot");
  trigger_wait("trig_damage_skylight");
  flag_set("remove_hangar_god_mode");
}

pdf_death_count_timeout() {
  wait 15;

  if(level.player hasperk("specialty_trespasser")) {
    if(flag("lock_breaker_started"))
      flag_wait_or_timeout("hangar_doors_closing", 20);
  }

  flag_set("remove_hangar_god_mode");
  flag_set("spawn_pdf_assaulters");
}

hangar_rpg_guy() {
  self endon("death");
  self allowedstances("stand");
  trigger_wait("trigger_hangar_rpg2");
  nd_rpg = getnode("node_rpg", "targetname");
  self thread force_goal(nd_rpg, 64, 0);
}

intro_truck_behaviour() {
  self endon("death");
  self waittill("reached_end_node");

  switch (self.script_noteworthy) {
    case "intro_civ_truck_transport":
      a_intro_civ_truck_guys = getentarray("intro_civ_truck_guys", "script_noteworthy");
      break;
    case "intro_civ_truck_turret":
      a_intro_civ_truck_guys = getentarray("intro_civ_truck_turret_guys", "script_noteworthy");
      break;
  }

  foreach(civ in a_intro_civ_truck_guys) {
    if(isDefined(civ))
      civ delete();
  }

  self delete();
}

parking_lot_exit() {
  trigger_wait("trig_color_parking_end");
  flag_set("parking_lot_laststand");
  wait 1.5;
}

kill_all_parkinglot() {
  trigger_wait("kill_parking_lot_ai_trigger");
  wait 2;
  a_ai_guys = getaiarray("axis");

  foreach(ai_guy in a_ai_guys) {
    if(isDefined(ai_guy))
      ai_guy die();
  }
}

kill_non_visable_parkinglot() {
  trigger_wait("delete_non_viasble_enemies_trigger");
  a_ai_guys = getaiarray("axis");

  foreach(ai_guy in a_ai_guys) {
    if(isDefined(ai_guy)) {
      if(!level.player is_player_looking_at(ai_guy.origin))
        ai_guy die();
    }
  }

  level.mason change_movemode("sprint");
}

littlebird_parking_lot() {
  s_spawnpt = getstruct("littlebird_parkinglot_spawnpt", "targetname");
  wait 2;
  s_spawnpt2 = getstruct("littlebird2_parkinglot_spawnpt", "targetname");
  vh_littlebird2 = spawn_vehicle_from_targetname("us_littlebird");
  vh_littlebird2.origin = s_spawnpt2.origin;
  vh_littlebird2.angles = s_spawnpt2.angles;
  vh_littlebird2 thread littlebird_strafe_parkinglot();
}

littlebird_fireat_truck() {
  self endon("death");
  s_goal1 = getstruct("littlebird_parkinglot_goal1", "targetname");
  s_goal2 = getstruct("littlebird_parkinglot_goal2", "targetname");
  s_goal3 = getstruct("littlebird_parkinglot_goal3", "targetname");
  s_goal4 = getstruct("littlebird_parkinglot_goal4", "targetname");
  s_goal5 = getstruct("littlebird_parkinglot_goal5", "targetname");
  s_goal6 = getstruct("littlebird_parkinglot_goal6", "targetname");
  self veh_magic_bullet_shield(1);
  self setneargoalnotifydist(300);
  self setspeed(30, 20, 10);
  self setvehgoalpos(s_goal1.origin, 0);
  self waittill_any("goal", "near_goal");
  self setvehgoalpos(s_goal2.origin, 0);
  self waittill_any("goal", "near_goal");
  vh_truck = getent("parking_lot_backup_truck", "targetname");

  if(isDefined(vh_truck)) {
    self thread shoot_turret_at_target(vh_truck, -1, undefined, 1);
    self thread shoot_turret_at_target(vh_truck, -1, undefined, 2);
  } else {
    self thread fire_turret_for_time(6.0, 1);
    self thread fire_turret_for_time(6.0, 2);
  }

  self setvehgoalpos(s_goal3.origin, 0);
  self waittill_any("goal", "near_goal");
  self setspeed(60, 30, 20);
  self stop_turret(1);
  self stop_turret(2);
  self thread fire_turret_for_time(6.0, 1);
  self thread fire_turret_for_time(6.0, 2);
  self setvehgoalpos(s_goal4.origin, 0);
  self waittill_any("goal", "near_goal");
  self stop_turret(1);
  self stop_turret(2);
  self setspeed(105, 30, 20);
  self setvehgoalpos(s_goal5.origin, 0);
  self waittill_any("goal", "near_goal");
  self setvehgoalpos(s_goal6.origin, 0);
  self waittill_any("goal", "near_goal");
}

littlebird_strafe_parkinglot() {
  self endon("death");
  s_goal1 = getstruct("littlebird2_parkinglot_goal1", "targetname");
  s_goal2 = getstruct("littlebird2_parkinglot_goal2", "targetname");
  s_goal3 = getstruct("littlebird2_parkinglot_goal3", "targetname");
  s_goal4 = getstruct("littlebird2_parkinglot_goal4", "targetname");
  self veh_magic_bullet_shield(1);
  self setneargoalnotifydist(300);
  self setspeed(30, 20, 10);
  self setvehgoalpos(s_goal1.origin, 0);
  self waittill_any("goal", "near_goal");
  self thread fire_turret_for_time(6.0, 1);
  self thread fire_turret_for_time(6.0, 2);
  self thread littlebird_kill_troops();
  self setvehgoalpos(s_goal2.origin, 0);
  self waittill_any("goal", "near_goal");
  self setspeed(60, 30, 20);
  self setvehgoalpos(s_goal3.origin, 0);
  self waittill_any("goal", "near_goal");
  self setvehgoalpos(s_goal4.origin, 0);
  self waittill_any("goal", "near_goal");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

littlebird_kill_troops() {
  self endon("death");

  while(true) {
    a_ai_guys = getaiarray("axis");

    foreach(ai_guy in a_ai_guys) {
      if(isDefined(ai_guy)) {
        if(distance2dsquared(self.origin, ai_guy.origin) < 2250000)
          ai_guy die();
      }
    }

    wait 0.1;
  }
}

hangar_cessna_flyby() {
  trigger_wait("trig_spawn_hangar_cessna");
  cessna_hangar_flyby = spawn_vehicles_from_targetname_and_drive("cessna_hangar_flyby");
  s_spawnpt = getstruct("littlebird_cessna_spawnpt", "targetname");
}

littlebird_fireat_cessna(v_goal) {
  self endon("death");
  self setneargoalnotifydist(300);
  self setspeed(65, 30, 20);
  self thread fire_turret_for_time(5.0, 1);
  self thread fire_turret_for_time(5.0, 2);
  self setvehgoalpos(v_goal, 0);
  self waittill_any("goal", "near_goal");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

radio_antenna_explosion() {
  trigger_wait("radio_tower_lookat");
  level notify("fxanim_radar_tower_start");
  tower = getent("radar_tower_collapse", "targetname");
  tower show();
  tower_disk = getent("radar_disk_top", "targetname");
  tower_disk delete();
  tower_base = getent("radar_disk_base", "targetname");
  tower_base delete();
  a_antenna_jets = spawn_vehicles_from_targetname_and_drive("antenna_jets");
  a_antenna_jets[0] playsound("fxa_radar_tower_jets_by");
}

runway_standoff_main() {
  m_fxanim_learjet = getent("fxanim_private_jet", "targetname");
  m_fxanim_learjet hide();
  vh_learjet = spawn_vehicle_from_targetname("vh_lear_jet");

  if(isDefined(vh_learjet)) {
    vh_learjet veh_toggle_tread_fx(0);
    vh_learjet thread learjet_challenge_think(m_fxanim_learjet);
    vh_learjet.overridevehicledamage = ::learjet_damage_override;
  }

  level thread spin_rooftop_fans();
  level thread spin_radio_tower();
  level thread run_scene_first_frame("seal_encounter_gate");
  level thread maps\createart\panama_art::airfield();
  level thread intruder_box();
  level thread hangar_cessna_flyby();
  level thread runway_seals();
  level thread runway_hangar_mason();
  flag_wait("player_at_standoff");
  setmusicstate("PANAMA_AT_HANGAR");
  autosave_by_name("standoff_save");
  level.player thread monitor_player_runway_fire();
  level thread runway_standoff_timeout();
  level.mason.ignoreall = 1;
  level.mason.ignoreme = 1;
  level.player.ignoreme = 1;
  flag_wait("player_on_roof");
  level thread hangar_roof_vo();
  flag_set("rooftop_guy_killed");
  flag_set("rooftop_goes_hot");
  level.mason.ignoreall = 0;
  level.mason.ignoreme = 0;
  level.mason change_movemode("run");
  level.player.ignoreme = 0;
  autosave_by_name("hangar_rooftop");
  s_m203_start_1 = getstruct("m203_start_1", "targetname");
  s_m203_end_1 = getstruct(s_m203_start_1.target, "targetname");
  s_m203_start_2 = getstruct("m203_start_2", "targetname");
  s_m203_end_2 = getstruct(s_m203_start_2.target, "targetname");
  magicbullet("gl_ak47_sp", s_m203_start_1.origin, s_m203_end_1.origin);
  wait 2;
  magicbullet("gl_ak47_sp", s_m203_start_2.origin, s_m203_end_2.origin);
  level thread monitor_skylight_damage();
  flag_wait("player_in_hangar");
  flag_set("remove_hangar_god_mode");
  level.mason say_dialog("maso_pdf_right_below_u_0");
  delay_thread(2, ::autosave_by_name, "hangar");
  level thread hangar_intruder_specialty();
  level thread monitor_player_hangar_threat();
  simple_spawn("hangar_pdf_shotgun", ::shotgun_guy_logic);
}

hangar_roof_vo() {
  hangar_roof_vo_struct = getent("hangar_roof_VO_struct", "targetname");
  hangar_roof_vo_struct say_dialog("pdf0_sniper_0", 1, 1);
  hangar_roof_vo_struct say_dialog("pdf1_behind_us_0", 6, 1);
  hangar_roof_vo_struct say_dialog("pdf2_they_re_coming_up_th_0", 2, 1);
}

shotgun_guy_logic() {
  self endon("death");
  level.player set_ignoreme(0);
  self set_ignoreall(0);
  self.targetname = "shotgun_ai";
  flag_wait("mason_jumped_down");
  self setgoalentity(level.mason);
  self thread force_goal(undefined, 100, 0);
}

hangar_rpg() {
  trigger_wait("trigger_hangar_rpg");
  flag_set("remove_hangar_god_mode");
  s_fire1 = getstruct("hangar_rpg_fire", "targetname");
  s_target1 = getstruct("hangar_rpg_target", "targetname");
  magicbullet("rpg_magic_bullet_sp", s_fire1.origin, s_target1.origin);
}

setup_runway_cessnas() {
  self endon("death");
  self.do_scripted_crash = 0;
  self veh_toggle_tread_fx(0);
  wait(randomfloatrange(1, 5));
  self setmodel("veh_t6_air_small_plane_dead");
  self notify("death");
}

runway_seals() {
  flag_wait("setup_runway_standoff");
  a_runway_cessnas = spawn_vehicles_from_targetname("runway_cessnas");

  foreach(cessna in a_runway_cessnas)
  cessna thread setup_runway_cessnas();

  a_runway_hangar_cessna = spawn_vehicles_from_targetname("runway_hangar_cessna");

  foreach(cessna in a_runway_hangar_cessna) {
    cessna veh_toggle_tread_fx(0);
    cessna thread red_airplane_hide_and_show();
  }

  ai_seal_standoff_1 = simple_spawn_single("seal_standoff_1", ::init_standoff_seal);
  ai_seal_standoff_1.animname = "seal_1";
  ai_seal_standoff_2 = simple_spawn_single("seal_standoff_2", ::init_standoff_seal);
  ai_seal_standoff_2.animname = "seal_2";
  ai_seal_standoff_3 = simple_spawn_single("seal_standoff_3", ::init_standoff_seal);
  ai_seal_standoff_3.animname = "seal_3";
  ai_seal_standoff_4 = simple_spawn_single("seal_standoff_4", ::init_standoff_seal);
  ai_seal_standoff_4.animname = "seal_4";
  ai_seal_standoff_5 = simple_spawn_single("seal_standoff_5", ::init_standoff_seal);
  ai_seal_standoff_5.animname = "seal_5";
  ai_seal_standoff_6 = simple_spawn_single("seal_standoff_6", ::init_standoff_seal);
  ai_seal_standoff_6.animname = "seal_6";
  ai_seal_standoff_7 = simple_spawn_single("seal_standoff_7", ::init_standoff_seal);
  ai_seal_standoff_7.animname = "seal_7";
  ai_seal_standoff_8 = simple_spawn_single("seal_standoff_8", ::init_standoff_seal);
  ai_seal_standoff_8.animname = "seal_8";
  level thread run_scene("seal_standoff_loop");
  flag_wait("runway_standoff_goes_hot");
  simple_spawn("rooftop_pdf");
  wait 0.1;
  simple_spawn("rooftop_pdf_sniper_victim", ::sniper_victim);
  wait 0.1;
  simple_spawn("rooftop_pdf_engager");
  wait 0.1;
  simple_spawn("rooftop_pdf_slider1");
  wait 0.1;
  simple_spawn("rooftop_pdf_slider2");
  standoff_seals = get_ai_group_ai("standoff_seals");

  foreach(seal in standoff_seals)
  seal thread kill_off_standoff_seals();
}

red_airplane_hide_and_show() {
  red_plane_destroyed = getent(self.script_noteworthy, "targetname");
  red_plane_destroyed hide();
  self waittill("death");
  red_plane_destroyed show();
}

spawn_airfield_littlebirds() {
  s_spawnpt = getstruct("littlebird_airfield_spawnpt", "targetname");
  vh_littlebird1 = spawn_vehicle_from_targetname("us_littlebird");
  vh_littlebird1.v_offset = (0, 0, 0);
  vh_littlebird1.origin = s_spawnpt.origin + vh_littlebird1.v_offset;
  vh_littlebird1.angles = s_spawnpt.angles;
  vh_littlebird1.targetname = "littlebird_airfield_1";
  vh_littlebird1 thread airfield_littlebird_logic(vh_littlebird1.v_offset);
  vh_littlebird2 = spawn_vehicle_from_targetname("us_littlebird");
  vh_littlebird2.v_offset = (500, -200, 0);
  vh_littlebird2.origin = s_spawnpt.origin + vh_littlebird2.v_offset;
  vh_littlebird2.angles = s_spawnpt.angles;
  vh_littlebird2.targetname = "littlebird_airfield_2";
  vh_littlebird2 thread airfield_littlebird_logic(vh_littlebird2.v_offset);
  vh_littlebird3 = spawn_vehicle_from_targetname("us_littlebird");
  vh_littlebird3.v_offset = (100, 500, 0);
  vh_littlebird3.origin = s_spawnpt.origin + vh_littlebird3.v_offset;
  vh_littlebird3.angles = s_spawnpt.angles;
  vh_littlebird3.targetname = "littlebird_airfield_3";
  vh_littlebird3 thread airfield_littlebird_logic(vh_littlebird3.v_offset);
  vh_littlebird4 = spawn_vehicle_from_targetname("us_littlebird");
  vh_littlebird4.v_offset = (750, 500, 0);
  vh_littlebird4.origin = s_spawnpt.origin + vh_littlebird4.v_offset;
  vh_littlebird4.angles = s_spawnpt.angles;
  vh_littlebird4.targetname = "littlebird_airfield_4";
  vh_littlebird4 thread airfield_littlebird_logic(vh_littlebird4.v_offset);
}

airfield_littlebird_logic(v_offset) {
  self endon("death");
  s_goal1 = getstruct("littlebird_airfield_goal1", "targetname");
  s_goal2 = getstruct("littlebird_airfield_goal2", "targetname");
  s_goal3 = getstruct("littlebird_airfield_goal3", "targetname");
  s_goal4 = getstruct("littlebird_airfield_goal4", "targetname");
  self setneargoalnotifydist(300);
  self setspeed(25, 20, 15);
  flag_wait("seal_encounter_mason_started");

  if(self.targetname == "littlebird_airfield_1")
    wait 1;
  else if(self.targetname == "littlebird_airfield_2")
    wait 2;
  else if(self.targetname == "littlebird_airfield_3")
    wait 2.6;
  else
    wait 3.7;

  self setvehgoalpos(s_goal1.origin + v_offset, 0);
  self waittill_any("goal", "near_goal");
  self setvehgoalpos(s_goal2.origin + v_offset, 0);
  self waittill_any("goal", "near_goal");
  self setspeed(65, 30, 25);
  self setvehgoalpos(s_goal3.origin + v_offset, 0);
  self waittill_any("goal", "near_goal");
  self setvehgoalpos(s_goal4.origin + v_offset, 0);
  self waittill_any("goal", "near_goal");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

jets_flyby_hangar_stairs() {
  flag_wait("ladder_breadcrumb_1");
  s_spawnpt = getstruct("phantom_hangar_stair_spawnpt", "targetname");

  for(i = 0; i < 5; i++) {
    vh_phantom1 = spawn_vehicle_from_targetname("us_phantom");
    vh_phantom1.origin = s_spawnpt.origin;
    vh_phantom1.angles = s_spawnpt.angles;
    vh_phantom1 thread phantom_hangar_stair_logic();
    wait(randomfloatrange(0.5, 1.0));
  }
}

phantom_hangar_stair_logic() {
  self endon("death");
  s_goal1 = getstruct("phantom_hangar_stair_goal1", "targetname");
  self setneargoalnotifydist(300);
  self setspeed(450, 400, 385);
  self setvehgoalpos(s_goal1.origin, 0);
  self waittill_any("goal", "near_goal");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

phantom_rooftop_entrance() {
  flag_wait("rooftop_approach");
  s_spawnpt = getstruct("phantom_rooftop_entrance_spawnpt", "targetname");
  v_offset = (0, 0, 0);

  for(i = 0; i < 2; i++) {
    vh_phantom = spawn_vehicle_from_targetname("us_phantom");
    vh_phantom.origin = s_spawnpt.origin + v_offset;
    vh_phantom.angles = s_spawnpt.angles;
    vh_phantom setspeed(400, 250, 200);
    vh_phantom thread ambient_aircraft_flightpath(s_spawnpt);
    v_offset = (-200, 0, 150);
    wait 0.5;
  }
}

ambient_aircraft_flightpath(s_start) {
  self endon("death");
  self setneargoalnotifydist(1000);
  self setforcenocull();
  s_goal = s_start;

  while(true) {
    self setvehgoalpos(s_goal.origin);
    self waittill_any("goal", "near_goal");

    if(isDefined(s_goal.target))
      s_goal = getstruct(s_goal.target, "targetname");
    else
      break;
  }

  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

ambient_phantoms() {
  level endon("player_in_hangar");
  wait 5;

  while(true) {
    a_s_spawnpts = getstructarray("phantom_rooftop_spawnpt", "targetname");
    s_spawnpt = a_s_spawnpts[randomint(a_s_spawnpts.size)];

    for(i = 0; i < randomintrange(1, 5); i++) {
      vh_phantom1 = spawn_vehicle_from_targetname("us_phantom");
      v_offset = (randomintrange(-300, 300), randomintrange(-300, 300), randomintrange(-200, 200));
      vh_phantom1.origin = s_spawnpt.origin + v_offset;
      vh_phantom1.angles = s_spawnpt.angles;
      vh_phantom1 thread phantom_rooftop_logic(s_spawnpt);
      wait(randomfloatrange(0.5, 1.5));
    }

    wait(randomfloatrange(3.5, 5.0));
  }
}

phantom_rooftop_logic(s_spawnpt) {
  self endon("death");
  s_goal = getstruct(s_spawnpt.target, "targetname");
  self setneargoalnotifydist(300);
  self setforcenocull();
  self notsolid();
  self setspeed(randomintrange(300, 500), 250, 185);
  self setvehgoalpos(s_goal.origin, 0);
  self waittill_any("goal", "near_goal");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

ambient_littlebirds() {
  level endon("player_in_hangar");
  wait 3;

  while(true) {
    a_s_spawnpts = getstructarray("littlebird_rooftop_spawnpt", "targetname");
    s_spawnpt = a_s_spawnpts[randomint(a_s_spawnpts.size)];
    vh_littlebird = spawn_vehicle_from_targetname("us_littlebird");
    v_offset = (randomintrange(-300, 300), randomintrange(-300, 300), randomintrange(-200, 200));
    vh_littlebird.origin = s_spawnpt.origin + v_offset;
    vh_littlebird.angles = s_spawnpt.angles;
    vh_littlebird thread littlebird_circle(s_spawnpt);
    wait(randomfloatrange(8.5, 10));
  }
}

littlebird_circle(s_start) {
  self endon("death");
  self setneargoalnotifydist(300);
  self setforcenocull();
  self setspeed(100, 25, 20);
  self thread littlebird_fire_indiscriminately();
  s_goal = s_start;

  while(true) {
    self setvehgoalpos(s_goal.origin);
    self waittill_any("goal", "near_goal");

    if(flag("player_in_hangar")) {
      self.delete_on_death = 1;
      self notify("death");

      if(!isalive(self))
        self delete();
    }

    if(isDefined(s_goal.target))
      s_goal = getstruct(s_goal.target, "targetname");
    else
      break;
  }

  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

littlebird_fire_indiscriminately() {
  self endon("death");

  while(true) {
    self thread littlebird_fire(0, 5.0);
    wait(randomfloatrange(5.5, 7.0));
  }
}

sniper_victim() {
  self endon("death");
  self allowedstances("stand");
}

runway_standoff_fail_timeout() {
  level endon("player_at_hatch");
  wait 35;
  setdvar("ui_deadquote", & "PANAMA_ROOFTOP_FAIL");
  level notify("mission failed");
  maps\_utility::missionfailedwrapper();
}

kill_off_standoff_seals() {
  self endon("death");
  self set_spawner_targets("seal_runway_nodes");
  wait(randomfloatrange(4.0, 8.0));
  self die();
}

init_standoff_seal() {
  self endon("death");
  flag_wait("runway_standoff_goes_hot");
  self stopanimscripted();
  self magic_bullet_shield();

  if(cointoss())
    self.ignoreme = 1;

  wait 5;
  self.ignoreme = 0;
  self stop_magic_bullet_shield();
}

rescue_1() {
  run_scene("seal_rescue_1");
  run_scene("seal_rescue_1_dies");
}

rescue_2() {
  run_scene("seal_rescue_2");
  run_scene("seal_rescue_2_dies");
}

rescue_3(ai_seal_standoff_5) {
  ai_seal_rescue_guy_3 = simple_spawn_single("seal_rescue_guy_3");
  ai_seal_rescue_guy_3.animname = "seal_rescue_guy_3";
  run_scene("seal_rescue_3");
  ai_seal_standoff_5 thread kill_off_standoff_seals();
  ai_seal_rescue_guy_3 thread kill_off_standoff_seals();
}

mason_vo_stairs() {
  level.mason say_dialog("maso_we_need_the_high_gro_0");
  level.mason say_dialog("maso_golf_team_this_is_0", 4);
  level.mason say_dialog("maso_damn_still_problem_0", 3);
  level.mason say_dialog("maso_come_on_woods_we_0", 1);
}

runway_hangar_mason() {
  flag_wait("player_at_standoff");
  level thread vo_seals_runway();
  level thread vo_seals_under_fire();
  run_scene_first_frame("hangar_door");
  door = getent("m_hangar_door", "targetname");
  door notsolid();
  level thread jets_flyby_hangar_stairs();
  level thread mason_vo_stairs();
  level thread run_scene("seal_encounter_mason");
  flag_wait("seal_encounter_mason_started");
  level thread mason_gate_break_open();
  level thread vo_rooftop_approach();
  scene_wait("seal_encounter_mason");
  open_ladder_door();
  setmusicstate("PANAMA_ROOFTOPS");
  level.mason change_movemode("run");
  nd_mason_stairs = getnode("nd_mason_stairs", "targetname");
  level.mason setgoalnode(nd_mason_stairs);
  level.mason thread mason_waiting_for_player_vo();
  flag_wait("player_on_roof");
  level thread vo_rooftop_battle();
  level thread vo_skylight();
  level thread phantom_rooftop_entrance();
  level thread ambient_phantoms();
  level thread spawn_rooftop();
  level thread sniper_logic();
  nd_mason_roof = getnode("nd_mason_roof", "targetname");
  level.mason setgoalnode(nd_mason_roof);
  waittill_ai_group_ai_count("rooftop_pdf", 1);
  level thread radio_antenna_explosion();
  level thread hangar_pdf_seals();
  level.mason anim_set_blend_in_time(1);
  run_scene("mason_skylight_approach");
  level thread run_scene("mason_skylight_loop");
  flag_wait("player_near_skylight");
  level thread hangar_doors_open();
  delay_thread(2.75, ::open_skylight);
  run_scene("mason_skylight_jump_in");
  nd_mason_catwalk = getnode("nd_mason_catwalk", "targetname");
  level.mason thread force_goal(nd_mason_catwalk, 64, 1, undefined, 1);
  flag_wait("player_in_hangar");
  level thread vo_hangar_battle();
  level thread player_rumbles();
  wait 8;
  ai_shotgun = getent("shotgun_ai", "targetname");
  nd_mason_hangar = getnode("nd_mason_hangar", "targetname");

  if(isDefined(ai_shotgun)) {
    level.mason setgoalentity(ai_shotgun);
    level.mason thread force_goal(undefined, 100, 0, undefined, 1);

    while(isalive(ai_shotgun))
      wait 0.5;

    level.mason thread force_goal(nd_mason_hangar, 64, 1, undefined, 1);
  } else
    level.mason thread force_goal(nd_mason_hangar, 64, 1, undefined, 1);

  flag_wait("mason_jumped_down");
  level thread pdf_death_count_timeout();
  level.mason set_ignoreall(1);
  level.mason set_ignoreme(1);
  level.mason.ignoresuppression = 1;
  level thread mason_door_kick();
  run_scene("mason_hangar_door_kick");
  simple_spawn("pdf_hangar_assaulters2");
  autosave_by_name("hangar_door_kick");
  level.mason set_ignoreall(0);
  level.mason set_ignoreme(0);
  level.mason.ignoresuppression = 0;
  nd_mason_post_hangar_door = getnode("nd_mason_post_hangar_door", "targetname");
  level.mason thread force_goal(nd_mason_post_hangar_door, 64, 1, undefined, 1);
  waittill_ai_group_cleared("pdf_hangar_assaulters");
  trig_color_leer_jet = getent("trig_color_leer_jet", "targetname");
  trig_color_leer_jet notify("trigger");
  trigger = getent("trigger_hangar_rpg", "targetname");

  if(isDefined(trigger))
    trigger delete();
}

mason_waiting_for_player_vo() {
  level endon("player_on_roof");
  self waittill("goal");
  self say_dialog("maso_they_don_t_see_us_ye_0");
}

mason_gate_break_open() {
  level thread run_scene("seal_encounter_gate");
  wait 2;
  hangar_lock_gate_clip = getent("hangar_lock_gate_clip", "targetname");
  hangar_lock_gate_clip rotateyaw(85, 1);
}

player_rumbles() {
  wait 0.2;
  level.player playrumbleonentity("damage_light");
  earthquake(0.3, 1, level.player.origin, 100);
  trigger_wait("player_jumped_rafters");
  level.player playrumbleonentity("damage_light");
  earthquake(0.3, 1, level.player.origin, 100);
}

vo_seals_runway() {
  level endon("runway_standoff_goes_hot");
  wait 5;
  level.ai_pdf = simple_spawn_single("pdf_talker", ::talker_spawn_func);
  level.ai_seal = simple_spawn_single("seal_talker", ::talker_spawn_func);
  level.ai_seal say_dialog("reds_you_are_surrounded_b_0", 0);
  level.ai_pdf say_dialog("pdf_you_have_no_authorit_0", 1);
  level.ai_seal say_dialog("reds_this_is_your_last_ch_0", 1);
  level.ai_pdf say_dialog("pdf_no_it_s_your_last_0", 1);
}

vo_seals_under_fire() {
  flag_wait("runway_standoff_goes_hot");

  if(isDefined(level.ai_seal)) {
    level.ai_seal say_dialog("reds_return_fire_0", 1.5);
    level.ai_seal say_dialog("reds_find_cover_0", 1);
  }

  if(isDefined(level.ai_pdf))
    level.ai_pdf say_dialog("pdf_don_t_let_them_get_o_0", 1);

  flag_set("runway_vo_done");
}

talker_spawn_func() {
  self endon("death");
  self setcandamage(0);
  self set_ignoreall(1);
  self set_ignoreme(1);
  flag_wait("runway_vo_done");
  self delete();
}

vo_rooftop_approach() {
  level endon("player_on_roof");
  wait 18;
  level.mason say_dialog("maso_we_need_the_high_gro_0", 0);
  scene_wait("seal_encounter_mason");
  level.mason say_dialog("maso_golf_team_this_is_0", 1);
  level.mason say_dialog("maso_damn_still_problem_0", 1);
  level.mason say_dialog("maso_come_on_woods_we_0", 0.5);
}

vo_sniper_kill() {
  level.mason say_dialog("mckn_i_got_you_covered_0", 1);
}

vo_rooftop_battle() {
  level endon("player_in_hangar");
  level.mason say_dialog("maso_incoming_left_side_0", 1);
  level.mason say_dialog("mckn_i_got_you_covered_0", 1);
  level.mason say_dialog("mckn_focus_on_supporting_0", 2);
}

vo_nag_rooftop_approach() {
}

vo_skylight() {
  waittill_ai_group_cleared("rooftop_pdf");
  level.mason say_dialog("maso_golf_team_this_is_m_0", 1);
}

vo_hangar_battle() {
  level.ai_pdf_hangar = simple_spawn_single("pdf_talker", ::talker_hangar_spawn_func);
  level.ai_pdf_hangar say_dialog("pdf_americans_are_behind_0", 1);
  level.ai_pdf_hangar say_dialog("pdf_they_re_above_us_0", 0.5);
  level.ai_pdf_hangar say_dialog("pdf_they_re_inside_the_h_0", 0.2);
  level.ai_pdf_hangar say_dialog("pdf_they_re_trying_to_ca_0", 2);
  level.ai_pdf_hangar say_dialog("pdf_stand_your_ground_0", 1);
}

vo_upper_hangar_battle() {
  level endon("friendly_door_bash_done");
  level.ai_seal_hangar = simple_spawn_single("seal_talker", ::talker_hangar_spawn_func);
  level.mason say_dialog("maso_more_enemy_across_th_0", 1);
  waittill_ai_group_cleared("pdf_hangar_assaulters");
  level.mason say_dialog("maso_golf_finish_up_in_t_0", 1);
  level.ai_seal_hangar say_dialog("reds_roger_that_0", 1);
  flag_set("hangar_vo_done");
}

talker_hangar_spawn_func() {
  self endon("death");
  self setcandamage(0);
  self set_ignoreall(1);
  self set_ignoreme(1);
  flag_wait("hangar_vo_done");
  self delete();
}

rooftop_tracers() {
  a_ai_seals = getentarray("hangar_seals_ai", "targetname");

  foreach(ai_seal in a_ai_seals)
  ai_seal thread fire_at_rooftop();
}

fire_at_rooftop() {
  self endon("death");
  level endon("rooftop_clear");
  s_m203_start_1 = getstruct("m203_start_1", "targetname");
  s_m203_end_1 = getstruct(s_m203_start_1.target, "targetname");
  s_m203_start_2 = getstruct("m203_start_2", "targetname");
  s_m203_end_2 = getstruct(s_m203_start_2.target, "targetname");

  while(true) {
    e_target = spawn("script_model", s_m203_end_1.origin + (0, randomintrange(-300, 300), 0));

    if(cointoss())
      e_target = spawn("script_model", s_m203_end_2.origin + (0, randomintrange(-300, 300), 0));

    e_target setmodel("tag_origin");
    self shoot_at_target(e_target, "tag_origin", 0, randomintrange(4, 7));
    wait(randomintrange(2, 4));
    e_target delete();
  }
}

spawn_rooftop() {
  ai_traversal1 = simple_spawn_single("rooftop_pdf_traversal", ::rooftop_traversal_logic);
  wait 0.5;
  simple_spawn("rooftop_pdf_reinforce", ::rooftop_traversal_logic);
  wait 0.25;
  flag_set("rooftop_spawned");
  level thread go_sliders();
  flag_wait("player_near_skylight");
  ai_last = simple_spawn_single("rooftop_pdf_last", ::rooftop_last_logic);
  wait 3;

  if(isDefined(ai_last))
    level thread sniper_shoot(ai_last);
}

go_sliders() {
  ai_engager = getent("rooftop_pdf_engager_ai", "targetname");
  nd_rooftop_pdf_engager = getnode("nd_rooftop_pdf_engager", "targetname");

  if(isDefined(ai_engager))
    ai_engager thread force_goal(nd_rooftop_pdf_engager, 16);

  ai_slide_guy_1 = getent("rooftop_pdf_slider1_ai", "targetname");

  if(isDefined(ai_slide_guy_1)) {
    ai_slide_guy_1.animname = "slide_guy_1";
    level thread run_scene("rooftop_slide_1");
    ai_slide_guy_1 thread ragdoll_if_damaged();
    scene_wait("rooftop_slide_1");
  }

  ai_slide_guy2 = getent("rooftop_pdf_slider2_ai", "targetname");

  if(isDefined(ai_slide_guy2)) {
    ai_slide_guy2.animname = "slide_guy_2";
    level thread run_scene("rooftop_slide_2");
    ai_slide_guy2 thread ragdoll_if_damaged();
    scene_wait("rooftop_slide_2");
  }
}

ragdoll_if_damaged() {
  self endon("death");
  self endon("delete");
  self waittill("damage");
  self ragdoll_death();
}

rooftop_last_logic() {
  self endon("death");
  self.aggressivemode = 1;
  self change_movemode("sprint");
  self thread force_goal(undefined, 64, 0);
}

rooftop_traversal_logic() {
  self endon("death");
  self thread force_goal(undefined, 64);
  self.aggressivemode = 1;
}

sniper_logic() {
  level endon("player_in_hangar");
  s_sniper = getstruct("sniper_pos", "targetname");
  wait 0.5;
  ai_victim = getent("rooftop_pdf_sniper_victim_ai", "targetname");

  if(isDefined(ai_victim))
    level thread sniper_shoot(ai_victim);

  flag_wait("rooftop_spawned");
  wait 3;

  while(true) {
    a_ai_targets = get_ai_group_ai("rooftop_pdf");
    playfx(level._effect["sniper_glint"], s_sniper.origin);

    if(a_ai_targets.size) {
      ai_target = a_ai_targets[randomint(a_ai_targets.size)];

      if(isDefined(ai_target))
        level thread sniper_shoot(ai_target);
    }

    wait(randomfloatrange(3.5, 4.5));
  }
}

sniper_shoot(ai_target) {
  a_tags = [];
  a_tags[0] = "J_Head";
  a_tags[1] = "J_SpineUpper";
  a_tags[2] = "J_Neck";
  s_sniper = getstruct("sniper_pos", "targetname");
  v_target = ai_target gettagorigin(a_tags[randomint(a_tags.size)]);
  e_trail = spawn("script_model", s_sniper.origin);
  e_trail setmodel("tag_origin");
  playfxontag(level._effect["sniper_trail"], e_trail, "tag_origin");
  e_trail moveto(v_target, 0.1);
  magicbullet("dragunov_sp", s_sniper.origin, v_target);
  playfx(level._effect["sniper_impact"], v_target);
  playsoundatposition("evt_sniper_shot_front", s_sniper.origin);
  playsoundatposition("evt_sniper_impacts", v_target);

  if(isalive(ai_target))
    ai_target die();

  wait 0.2;
  e_trail delete();
}

sniper_shot_without_death(ai_target) {
  s_sniper = getstruct("sniper_pos", "targetname");
  v_target = ai_target gettagorigin("J_Head");
  e_trail = spawn("script_model", s_sniper.origin);
  e_trail setmodel("tag_origin");
  playfxontag(level._effect["sniper_trail"], e_trail, "tag_origin");
  e_trail moveto(v_target, 0.1);
  playfx(level._effect["sniper_impact"], v_target);
  playsoundatposition("evt_sniper_shot_front", s_sniper.origin);
  playsoundatposition("evt_sniper_impacts", v_target);
  wait 0.2;
  e_trail delete();
}

shoot_pool_guy_1(ai_pool_1) {
  flag_set("mcknight_sniping");
  sniper_shot_without_death(ai_pool_1);
  flag_clear("mcknight_sniping");
}

shoot_pool_guy_2(ai_pool_2) {
  flag_set("mcknight_sniping");
  sniper_shot_without_death(ai_pool_2);
  flag_clear("mcknight_sniping");
}

mason_door_kick() {
  flag_wait("mason_hangar_door_kick_started");
  simple_spawn("hangar_door_victim", ::door_guy_logic);
  level thread run_scene("hangar_door");
  level waittill("open_hangar_door");
  hangar_door_clip = getent("hangar_door_mason_clip", "targetname");
  hangar_door_clip rotateyaw(108, 1);
  hangar_door_clip playsound("evt_door_breach_mas");
  hangar_door_clip connectpaths();
  wait 2;
  s_fire2 = getstruct("hangar_rpg_fire2", "targetname");
  s_target2 = getstruct("hangar_rpg_target2", "targetname");
  magicbullet("rpg_magic_bullet_sp", s_fire2.origin, s_target2.origin);
  simple_spawn("pdf_hangar_rpg", ::hangar_rpg_guy);
}

#using_animtree("generic_human");

door_guy_logic() {
  self endon("death");
  self.deathanim = % ai_death_flyback_far;
  self set_fixednode(1);
  self set_ignoreall(1);
  self set_ignoreme(1);
  wait 1.85;
  self dodamage(200, self.origin);
}

init_foreshadow_seals() {
  self endon("death");
  self magic_bullet_shield();
  self set_ignoreall(1);
  nd_delete = getnode(self.target, "targetname");
  self force_goal(nd_delete, 32);
  self waittill("goal");
  self delete();
}

rooftop_fail_timeout() {
  level endon("player_near_skylight");
  level endon("player_in_hangar");
  wait 25;
  setdvar("ui_deadquote", & "PANAMA_ROOFTOP_FAIL");
  level notify("mission failed");
  maps\_utility::missionfailedwrapper();
}

open_skylight() {
  m_door_clip = getent("skylight_door_clip", "targetname");
  m_door_clip rotatepitch(32, 1);
}

open_ladder_door() {
  m_roofstairs_clip = getent("m_roofstairs_clip", "targetname");
  m_roofstairs_clip delete();
}

extra_muzzle_flash(guy) {
  playfxontag(getfx("maginified_muzzle_flash"), guy, "tag_flash");
}

ladder_obj_breadcrumb() {
  set_objective(level.obj_capture_noriega, getstruct("breadcrumb_hanger_1"), "breadcrumb");
  flag_wait("setup_runway_standoff");
  set_objective(level.obj_capture_noriega, undefined, "remove");
  set_objective(level.obj_capture_noriega, getstruct("breadcrumb_hanger_2"), "breadcrumb");
  flag_wait("breadcrumb_hanger_2");
  set_objective(level.obj_capture_noriega, undefined, "remove");
  wait 0.1;
  set_objective(level.obj_assist_seals, getstruct("ladder_breadcrumb_1"), "breadcrumb");
  flag_wait("ladder_breadcrumb_1");
  set_objective(level.obj_assist_seals, undefined, "remove");
  set_objective(level.obj_assist_seals, getstruct("ladder_breadcrumb_2"), "breadcrumb");
  flag_wait("ladder_breadcrumb_2");
  set_objective(level.obj_assist_seals, undefined, "remove");
  set_objective(level.obj_assist_seals, getstruct("ladder_breadcrumb_3"), "breadcrumb");
  flag_wait("player_at_hatch");
  set_objective(level.obj_assist_seals, undefined, "remove");
  waittill_ai_group_cleared("rooftop_pdf");
  flag_set("rooftop_clear");
  set_objective(level.obj_assist_seals, level.mason, "follow");
}

monitor_player_runway_fire() {
  level endon("runway_standoff_goes_hot");
  self endon("death");
  flag_wait("player_at_standoff");
  self waittill_any("weapon_fired", "grenade_fire");
  flag_set("runway_standoff_goes_hot");
}

runway_standoff_timeout() {
  level endon("runway_standoff_goes_hot");
  flag_wait("seal_encounter_mason_started");
  wait 16;
  flag_set("runway_standoff_goes_hot");
}

set_flag_when_cleared(ai_group, str_flag) {
  waittill_ai_group_cleared(ai_group);
  flag_set(str_flag);
}

hangar_pdf_seals() {
  level thread handle_pdf_hangar_movement();
  spawn_manager_enable("trig_sm_hangar_pdf");
  spawn_manager_enable("trig_sm_runway_seals");
  level.player setthreatbiasgroup("hangar_player");
  level.mason setthreatbiasgroup("hangar_mason");
  setthreatbias("hangar_seals", "hangar_pdf", 5000);
  setthreatbias("hangar_player", "hangar_pdf", 100);
  setthreatbias("hangar_mason", "hangar_pdf", 100);
  flag_wait("spawn_pdf_assaulters");
  spawn_manager_kill("trig_sm_hangar_pdf");
  spawn_manager_disable("trig_sm_runway_seals");
  simple_spawn("pdf_hangar_assaulters");
  setignoremegroup("hangar_seals", "pdf_assaulters");
  setignoremegroup("hangar_mason", "hangar_pdf");
  setthreatbias("hangar_player", "pdf_assaulters", 5000);
  setthreatbias("hangar_mason", "pdf_assaulters", 5000);
  level thread monitor_pdf_assaulters();
  nd_delete_seals = getnode("nd_delete_seals", "targetname");
  a_hangar_seals = get_ai_group_ai("hangar_seals");

  for(i = 0; i < a_hangar_seals.size; i++) {
    if(i < 2)
      a_hangar_seals[i].script_noteworthy = "cessna_seal_" + i;

    a_hangar_seals[i] thread seals_storm_hangar(nd_delete_seals);
  }

  a_hangar_pdf = get_ai_group_ai("hangar_pdf");

  foreach(pdf in a_hangar_pdf)
  pdf thread pdf_hangar_fallback();

  while(true) {
    a_hangar_pdf = get_ai_group_ai("hangar_pdf");

    if(a_hangar_pdf.size == 0) {
      break;
    }

    wait 0.1;
  }

  flag_set("hangar_pdf_cleared");
  a_seal_group_1 = get_ai_group_ai("seal_group_1");
  a_seal_group_2 = get_ai_group_ai("seal_group_2");
  nd_delete_seal_group_1 = getnode("nd_delete_seal_group_1", "targetname");
  nd_delete_seal_group_2 = getnode("nd_delete_seal_group_2", "targetname");

  foreach(seal in a_seal_group_1)
  seal thread stack_up_and_delete(nd_delete_seal_group_1);

  foreach(seal in a_seal_group_2)
  seal thread stack_up_and_delete(nd_delete_seal_group_2);
}

handle_pdf_hangar_movement() {
  trigger_use("triggercolor_pdf_hangar_advance");
  flag_wait("player_in_hangar");
  flag_wait_or_timeout("mason_jumped_down", 10);
  level thread seal_hangar_entry();
  trigger_use("triggercolor_pdf_hangar_retreat");
  a_ai_guys = get_ai_group_ai("hangar_pdf");

  foreach(ai_guy in a_ai_guys)
  ai_guy thread force_goal(undefined, 64, 1, undefined, 1);
}

seal_hangar_entry() {
  trigger_use("triggercolor_seal_hangar_advance");
  seal_group_1 = simple_spawn("seal_group_1");
  level thread run_scene("seal_group_1_hangar_entry");
  wait 0.1;
  seal_group_2 = simple_spawn("seal_group_2");
  run_scene("seal_group_2_hangar_entry");
}

monitor_pdf_assaulters() {
  waittill_ai_group_count("pdf_hangar_assaulters", 2);
  a_ai_guys = get_ai_group_ai("pdf_hangar_assaulters");

  foreach(ai_guy in a_ai_guys) {
    ai_guy.goalradius = 1024;
    ai_guy.aggressivemode = 1;
  }
}

seals_storm_hangar(nd_delete_seals) {
  self endon("death");
  self magic_bullet_shield();
  self.perfectaim = 1;
  self change_movemode("cqb");
  self cleargoalvolume();
  volume_hangar_front = getent("hangar_front", "targetname");
  self setgoalvolumeauto(volume_hangar_front);
  flag_wait("hangar_pdf_cleared");
  self set_ignoreall(1);
  self.ignoreme = 1;
  self cleargoalvolume();
  e_cessna_target = getent("cessna_target", "targetname");

  if(isDefined(self.script_noteworthy)) {
    self.fixednode = 0;
    self.goalradius = 32;

    if(self.script_noteworthy == "cessna_seal_0") {
      nd_first_node = getnode("nd_1_cessna_seal_1", "targetname");
      nd_second_node = getnode("nd_2_cessna_seal_1", "targetname");
      self setgoalnode(nd_first_node);
      self waittill("goal");
      flag_set("seal_1_in_pos");
    } else if(self.script_noteworthy == "cessna_seal_1") {
      nd_first_node = getnode("nd_1_cessna_seal_2", "targetname");
      nd_second_node = getnode("nd_2_cessna_seal_2", "targetname");
      self setgoalnode(nd_first_node);
      self waittill("goal");
      flag_set("seal_2_in_pos");
    }

    flag_wait_all("seal_1_in_pos", "seal_2_in_pos");
    self thread shoot_at_target(e_cessna_target, undefined, undefined, -1);
    wait 3;
    self setgoalnode(nd_second_node);
    self waittill("goal");
    wait 5;
    self stop_shoot_at_target();
    self clearentitytarget();
    self thread stack_up_and_delete(nd_delete_seals);
  } else
    self thread stack_up_and_delete(nd_delete_seals);
}

pdf_hangar_fallback() {
  self endon("death");
  wait(randomfloatrange(0.25, 1.0));
  self cleargoalvolume();
  volume_hangar_back = getent("hangar_back", "targetname");
  self setgoalvolumeauto(volume_hangar_back);
}

stack_up_and_delete(nd_delete) {
  self endon("death");
  self.goalradius = 32;
  self setgoalpos(nd_delete.origin);
  self waittill("goal");
  self delete();
}

hangar_intruder_specialty() {
  t_use = getent("trig_control_room_specialty", "targetname");
  t_use sethintstring(&"PANAMA_PICK_LOCK");
  t_use setcursorhint("HINT_NOICON");
  t_use trigger_off();
  level.player waittill_player_has_lock_breaker_perk();
  t_use trigger_on();
  run_scene_first_frame("lock_breaker_door");
  s_intruder_obj = getstruct("s_intruder_obj", "targetname");
  set_objective_perk(level.obj_interact, s_intruder_obj.origin);
  t_use waittill("trigger");
  t_use delete();
  remove_objective_perk(level.obj_interact);
  m_lock_breaker_door_clip = getent("lock_breaker_door_clip", "targetname");
  m_lock_breaker_door_clip delete();
  run_scene("lock_breaker");
  thread screen_message_create(&"PANAMA_PERK_FLAK_JACKET", undefined, undefined, undefined, 3);
  level.player.overrideplayerdamage = ::player_flak_jacket_override;
}

hangar_doors_open() {
  m_hangar_door_left = getent("hangar_door_left", "targetname");
  m_hangar_door_right = getent("hangar_door_right", "targetname");
  m_hangar_door_left movey(-135, 0.1);
  m_hangar_door_right movey(135, 0.1);
  m_hangar_door_left connectpaths();
  m_hangar_door_right connectpaths();
}

hangar_intruder_door_open(m_player) {
  run_scene("lock_breaker_door");
}

close_left_door() {
  self movey(135, 25, 1, 0.5);
  self disconnectpaths();
}

close_right_door() {
  self movey(-135, 25, 1, 0.5);
  self disconnectpaths();
}

pdf_door_reaction() {
  if(flag("hangar_gone_hot")) {
    return;
  }
  flag_wait("hangar_doors_closing");
  ai_hangar_pdf = get_ai_group_ai("hangar_pdf");
  ai_hangar_pdf = array_randomize(ai_hangar_pdf);
  n_pdf_reactions = 0;

  for(i = 0; i < ai_hangar_pdf.size; i++) {
    if(!isalive(ai_hangar_pdf[i])) {
      continue;
    }
    ai_hangar_pdf[i].animname = "pdf_" + n_pdf_reactions;
    level thread run_scene("pdf_door_reaction_" + n_pdf_reactions);
    n_pdf_reactions++;

    if(n_pdf_reactions == 2) {
      break;
    }
  }
}