/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\factory_chase.gsc
*****************************************************/

start() {
  maps\factory_util::actor_teleport(level.squad["ALLY_ALPHA"], "parking_lot_start_alpha");
  maps\factory_util::actor_teleport(level.squad["ALLY_BRAVO"], "parking_lot_start_bravo");
  maps\factory_util::actor_teleport(level.squad["ALLY_CHARLIE"], "parking_lot_start_charlie");
  level.player maps\factory_util::move_player_to_start_point("playerstart_parking_lot");
  level.blockade_vehicle_1 = maps\_vehicle::spawn_vehicle_from_targetname("blockade_vehicle_1");
  level.blockade_vehicle_1 maps\_vehicle::vehicle_lights_on("headlights");
  level.blockade_vehicle_1.animname = "first_opfor_car";
  level.blockade_vehicle_2 = maps\_vignette_util::vignette_vehicle_spawn("blockade_vehicle_2", "second_opfor_car");
  level.blockade_vehicle_3 = maps\_vignette_util::vignette_vehicle_spawn("blockade_vehicle_3", "heavy_weapon_opfor_car");
  level.blockade_vehicle_2 maps\_vehicle::vehicle_lights_on("headlights");
  level.blockade_vehicle_3 maps\_vehicle::vehicle_lights_on("headlights");
  level.blockade_vehicle_1 thread vehicle_catch_fire_when_shot();
  level.blockade_vehicle_2 thread vehicle_catch_fire_when_shot();
  level.blockade_vehicle_3 thread vehicle_catch_fire_when_shot();
  thread chase_scripted_flyovers();

  foreach(var_1 in level.squad) {
    var_1.grenadeammo = 0;
  }

  thread chase_ally_vehicle_setup();
  thread car_chase_intro_car_crash_setup();
  thread maps\factory_intro::train_cleanup();
}

#using_animtree("generic_human");

main() {
  common_scripts\utility::flag_wait("chase_start_done");
  maps\_utility::battlechatter_off("allies");
  thread chase_dialog();
  level notify("semi_trailer_entrance");
  thread car_chase_intro_car_crash();
  level waittill("player_switch");
  level.drone_anims["axis"]["stand"]["run"] = % run_lowready_f_relative;
  thread chase_spawn_drone_group("chase_enemy_trigger_1", "chase_first_turn_drone_spawner", "chase_enemy_trigger_2");
  thread chase_spawn_drone_group("chase_enemy_trigger_2", "chase_drone_spawner_2", "chase_delete_drone_group_2");
  thread maps\factory_audio::audio_sfx_car_chase_sequence();
  wait 40;
  common_scripts\utility::flag_set("car_chase_complete");
  level.player freezecontrols(1);
  wait 1;
  setsaveddvar("cg_drawCrosshair", 0);
  setsaveddvar("compass", 0);
  setsaveddvar("hud_showStance", 0);
  setsaveddvar("ammoCounterHide", 1);
  level.player mission_fade_out(1, "black");
  wait 5;
  maps\_utility::nextmission();
}

mission_fade_out(var_0, var_1) {
  var_2 = maps\_hud_util::get_optional_overlay(var_1);

  if(var_0 > 0) {
    var_2 fadeovertime(var_0);
  }

  var_2.alpha = 1;
  var_2.foreground = 0;
  var_2.sort = 205;
  wait(var_0);
}

section_flag_init() {
  common_scripts\utility::flag_init("player_mount_vehicle_start");
  common_scripts\utility::flag_init("player_mount_vehicle_done");
  common_scripts\utility::flag_init("car_chase_complete");
  common_scripts\utility::flag_init("chase_start_done");
}

section_precache() {
  precachemodel("ch_crate64x64");
  precachemodel("shipping_frame_boxes");
}

setup_trailer_platform() {
  thread chase_player_mount_moving_trailer();
  var_0 = getent("trailer_platform", "targetname");
  var_0.origin = level.ally_vehicle_trailer.origin + (395, 0, 112);
  var_0.angles = level.ally_vehicle_trailer.angles + (0, 180, 0);
  var_0 linkto(level.ally_vehicle_trailer);
  var_1 = getEntArray("trailer_platform_wheel_death_trigger", "targetname");

  foreach(var_3 in var_1) {
    var_3 enablelinkto();
    var_3 linkto(level.ally_vehicle_trailer);
  }

  var_5 = getEntArray("trailer_node", "script_noteworthy");

  foreach(var_7 in var_5) {
    var_7 linkto(level.ally_vehicle_trailer, "body_anim_jnt");
  }

  thread semi_trailer_death_trigger();
  var_9 = getEntArray("trailer_side_rail", "targetname");

  foreach(var_11 in var_9) {
    var_11 linkto(level.ally_vehicle_trailer, "body_anim_jnt");
  }

  common_scripts\utility::flag_wait("player_mount_vehicle_start");
  thread maps\factory_audio::audio_play_ending_scene();
  common_scripts\utility::flag_set("music_chase_ending");
  setsaveddvar("player_sprintUnlimited", "0");

  foreach(var_3 in var_1) {
    var_3 delete();
  }
}

chase_player_mount_moving_trailer() {
  var_0 = getent("get_in_vehicle_trigger", "targetname");
  var_0 enablelinkto();
  var_0 linkto(level.ally_vehicle_trailer);
  waittillframeend;
  level waittill("start_mount");
  common_scripts\utility::flag_set("factory_rooftop_wind_gust_moment");
  var_0 common_scripts\utility::trigger_on();
  thread chase_airstrike_kills_player();
  thread chase_player_falls_off_trailer();

  for(;;) {
    if(abs(abs(level.player.angles[1]) - level.ally_vehicle_trailer.angles[1]) < 45 && common_scripts\utility::flag("player_near_trailer_rear") && !level.player isthrowinggrenade() && !level.player ismeleeing()) {
      break;
    }

    wait 0.05;
  }

  level.player.active_anim = 1;
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player setstance("stand");
  var_1 = level.player getvelocity();
  var_2 = length(var_1);
  common_scripts\utility::flag_set("player_mount_vehicle_start");
  var_3 = maps\_utility::spawn_anim_model("player_rig");
  var_4 = maps\_utility::spawn_anim_model("factory_car_chase_intro_ally_pulls_up_player_b201");
  var_5 = maps\_utility::spawn_anim_model("factory_car_chase_intro_ally_pulls_up_player_b202");
  var_6 = maps\_utility::spawn_anim_model("factory_car_chase_intro_ally_pulls_up_player_b203");
  var_3 hide();
  var_7 = getent("car_chase_intro", "script_noteworthy");
  var_8 = [];
  var_8["factory_car_chase_intro_ally_pulls_up_player_b201"] = var_4;
  var_8["factory_car_chase_intro_ally_pulls_up_player_b202"] = var_5;
  var_8["factory_car_chase_intro_ally_pulls_up_player_b203"] = var_6;
  var_8["factory_car_chase_intro_ally_pulls_up_player_b201"] thread chase_looped_afterburner_faint();
  var_8["factory_car_chase_intro_ally_pulls_up_player_b202"] thread chase_looped_afterburner_faint();
  var_8["factory_car_chase_intro_ally_pulls_up_player_b203"] thread chase_looped_afterburner_faint();
  var_3 linkto(level.ally_vehicle_trailer, "body_anim_jnt");
  level.ally_vehicle_trailer notify("stop_loop");
  var_7 thread maps\_anim::anim_single(var_8, "factory_car_chase_intro_ally_pulls_up_player");
  var_9 = [];
  var_9["ally_alpha"] = level.squad["ALLY_ALPHA"];
  var_9["ally_bravo"] = level.squad["ALLY_BRAVO"];
  var_9["ally_charlie"] = level.squad["ALLY_CHARLIE"];

  foreach(var_11 in var_9) {
    var_11 linkto(level.ally_vehicle_trailer, "body_anim_jnt");
  }

  level.ally_vehicle_trailer thread maps\_anim::anim_single(var_9, "factory_car_chase_intro_ally_pulls_up_player", "body_anim_jnt");
  level.ally_vehicle_trailer thread maps\_anim::anim_single_solo(var_3, "factory_car_chase_intro_ally_pulls_up_player", "body_anim_jnt");
  var_13 = 0.75;
  var_14 = 0;
  level.player playerlinktoblend(var_3, "tag_player", var_13, 0.25, 0.25);
  wait(var_13);
  level.player playerlinktodelta(var_3, "tag_player", 0, var_14, var_14, var_14, var_14, 1);
  var_3 show();
  maps\_utility::autosave_by_name("chase");
  wait(getanimlength(var_3 maps\_utility::getanim("factory_car_chase_intro_ally_pulls_up_player")) - var_13);
  var_3 delete();
  common_scripts\utility::flag_set("player_mount_vehicle_done");
  level.player enableweapons();
  level.player setmovingplatformplayerturnrate(0.75);
  level.player setstance("crouch");
  var_1 = level.player getvelocity();
  level.player unlink();
  level.player setvelocity(var_1);
  wait 1;

  if(level.player.thermal) {
    level.player maps\factory_util::thermal_disable();
  }

  level.player.active_anim = 0;
  common_scripts\utility::flag_set("factory_rooftop_wind_gust_moment");
  level.player freezecontrols(0);
  level.player setmovespeedscale(0.5);
  level.player allowprone(1);
  level.player allowcrouch(1);
}

chase_scripted_flyovers() {
  wait 4;
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("rooftop_bomber");
  chase_airstrike_explosion("rooftop_airstrike_explosion");
  common_scripts\utility::flag_wait("player_mount_vehicle_start");
  chase_wait_for_semi_touch("chase_enemy_trigger_2");
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("smokestack_bomber");
}

chase_looped_afterburner() {
  playFXOnTag(level._effect["afterburner_contrail"], self, "tag_engine_right");
  common_scripts\utility::waitframe();
  playFXOnTag(level._effect["afterburner_contrail"], self, "tag_engine_left");
}

chase_looped_afterburner_faint() {
  playFXOnTag(level._effect["afterburner_contrail_faint"], self, "tag_engine_right");
  common_scripts\utility::waitframe();
  playFXOnTag(level._effect["afterburner_contrail_faint"], self, "tag_engine_left");
}

chase_airstrike_explosion(var_0) {
  var_1 = getent(var_0, "targetname");
  playFX(common_scripts\utility::getfx(var_1.script_fxid), var_1.origin, var_1.angles);
  level notify(var_0);
}

chase_airstrike_kills_player() {
  level.player endon("death");
  level endon("player_mount_vehicle_start");
  maps\_utility::wait_for_flag_or_timeout("player_left_parking_lot", 6);
  level notify("new_quote_string");
  setdvar("ui_deadquote", &"FACTORY_FAIL_ESCAPE");
  level.player playSound("scn_factory_end_exp11_lr");
  playFX(level._effect["101ton_bomb"], level.player.origin);
  level.player kill();
  maps\_utility::missionfailedwrapper();
}

chase_player_falls_off_trailer() {
  var_0 = getent("chase_kill_trigger", "targetname");
  var_0 common_scripts\utility::trigger_off();
  common_scripts\utility::flag_wait("player_mount_vehicle_done");
  var_0 common_scripts\utility::trigger_on();
  common_scripts\utility::flag_wait("player_fell_off_trailer");
  level notify("new_quote_string");
  setdvar("ui_deadquote", &"FACTORY_FAIL_FELL_OFF_TRAILER");
  playFX(level._effect["101ton_bomb"], level.player.origin);
  level.player kill();
  maps\_utility::missionfailedwrapper();
}

chase_dialog() {
  level waittill("hit_vehicle_01");
  level.player thread maps\factory_util::thermal_disable();
  level waittill("hit_vehicle_02");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_getonthetrailer");
  chase_wait_for_semi_touch("chase_enemy_trigger_1");
  chase_wait_for_semi_touch("chase_delete_warehouse_drones");
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_hsh_ohhhhshit");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_wegotproblemsback");
  maps\_utility::smart_radio_dialogue("factory_oby_pedalstothemetal");
  maps\_utility::smart_radio_dialogue("factory_oby_hangon");
  chase_wait_for_semi_touch("chase_clear");
  maps\_utility::smart_radio_dialogue("factory_kck_wereclear");
  level.squad["ALLY_BRAVO"] thread maps\_utility::smart_dialogue("factory_kgn_nicedrivingkick");
  wait 6;

  if(maps\_utility::is_gen4()) {
    wait 1.0;
  }

  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_wellthereaintgonna");
  wait 0.4;
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_jsocwillgiveus");
  wait 1.0;
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_timetoheadhome");
}

chase_ally_vehicle_setup() {
  level.ally_vehicle = maps\_vignette_util::vignette_vehicle_spawn("chase_ally_vehicle", "het_cab");
  level.ally_vehicle_trailer = maps\_vignette_util::vignette_vehicle_spawn("chase_ally_vehicle_trailer", "het_trailer");
  level.ally_vehicle maps\_vehicle::godon();
  level.ally_vehicle_trailer maps\_vehicle::godon();
  var_0 = getent("trailer_airstrike_kill_trigger", "targetname");
  var_0 enablelinkto();
  var_0 linkto(level.ally_vehicle);
  thread setup_trailer_platform();
  waittillframeend;
  var_1 = getent("car_chase_intro", "script_noteworthy");
  var_1 maps\_anim::anim_first_frame_solo(level.ally_vehicle, "car_chase_intro_car_crash");
  var_1 maps\_anim::anim_first_frame_solo(level.ally_vehicle_trailer, "car_chase_intro_car_crash");
  common_scripts\utility::flag_set("chase_start_done");
  level waittill("semi_trailer_entrance");
  level.ally_vehicle thread maps\_utility::play_sound_on_tag("scn_factory_horn_short", "tag_origin");
  level.ally_vehicle_front = spawn("script_origin", level.ally_vehicle gettagorigin("tag_engine_right"));
  level.ally_vehicle_front linkto(level.ally_vehicle);
  var_2 = vectornormalize(anglesToForward(level.ally_vehicle.angles));
  var_3 = var_2 * 192;
  var_4 = spawn("script_model", level.ally_vehicle.origin + (0, 0, 56) + var_3);
  var_4.angles = level.ally_vehicle.angles;
  var_4 setModel("tag_origin");
  var_4 linkto(level.ally_vehicle);
  playFXOnTag(level._effect["factory_het_cab_headlight_full"], var_4, "tag_origin");
  level.ally_vehicle_trailer thread maps\_vehicle::vehicle_lights_on("running");
  level.ally_vehicle maps\_vehicle::vehicle_lights_on("running");
  thread chase_headlight_fx_swap(var_4);
}

chase_headlight_fx_swap(var_0) {
  common_scripts\utility::flag_wait("player_mount_vehicle_start");
  stopFXOnTag(level._effect["factory_het_cab_headlight_full"], var_0, "tag_origin");
  waittillframeend;
  playFXOnTag(level._effect["cheap_spot"], var_0, "tag_origin");
}

chase_blockade_crash() {
  foreach(var_1 in level.squad) {
    var_1.ignoreme = 1;
  }

  level.player.ignoreme = 1;
  var_3 = maps\_utility::get_living_ai_array("blockade_enemy", "script_noteworthy");

  foreach(var_1 in var_3) {
    var_1 setentitytarget(level.ally_vehicle);
    var_1.maxsightdistsqrd = 67108864;
    var_5 = var_1 getturret();

    if(isDefined(var_5)) {
      var_5 settargetentity(level.ally_vehicle);
    }
  }

  wait 1;

  foreach(var_1 in level.squad) {
    var_1 maps\_utility::disable_pain();
    var_1.ignoresuppression = 1;
    setsaveddvar("ai_friendlyFireBlockDuration", 0);
  }

  maps\_utility::activate_trigger_with_targetname("p_b_r_ally_move_602");
  wait 2;

  foreach(var_1 in level.squad) {
    var_1.ignoreall = 1;
  }

  level.ally_vehicle thread maps\_utility::play_sound_on_tag("scn_factory_horn_long", "tag_origin");
  var_3 = maps\_utility::get_living_ai_array("blockade_enemy", "script_noteworthy");

  foreach(var_12 in var_3) {
    var_12.ignoreall = 1;
    wait 0.1;
    var_12 cleargoalvolume();
    var_12 setgoalpos(level.blockade_vehicle_3.origin);
  }

  level waittill("hit_vehicle_01");
  var_3 = maps\_utility::get_living_ai_array("blockade_enemy", "script_noteworthy");

  foreach(var_12 in var_3) {
    var_12 thread maps\_utility::disable_long_death();
    var_12 kill((-462, 55, 40));
  }

  level.player.ignoreme = 0;
}

ally_reach_curb_hop(var_0) {
  self.goalradius = 8;
  var_1 = getent("car_chase_intro_proxy", "targetname");
  var_1 maps\_anim::anim_reach_and_approach_solo(self, var_0);
  self setgoalpos(self.origin);
}

car_chase_intro_car_crash_setup() {
  var_0 = [];
  level.factory_car_chase_intro_broken_awning01 = maps\_utility::spawn_anim_model("factory_car_chase_intro_broken_awning01");
  level.factory_car_chase_intro_broken_awning02 = maps\_utility::spawn_anim_model("factory_car_chase_intro_broken_awning02");
  level.factory_car_chase_intro_broken_awning03 = maps\_utility::spawn_anim_model("factory_car_chase_intro_broken_awning03");
  level.factory_car_chase_intro_broken_awning04 = maps\_utility::spawn_anim_model("factory_car_chase_intro_broken_awning04");
  level.factory_car_chase_intro_broken_fence01 = maps\_utility::spawn_anim_model("factory_car_chase_intro_broken_fence01");
  level.factory_car_chase_intro_broken_fence02 = maps\_utility::spawn_anim_model("factory_car_chase_intro_broken_fence02");
  level.factory_car_chase_intro_broken_light_post = maps\_utility::spawn_anim_model("factory_car_chase_intro_broken_light_post");
  level.factory_car_chase_intro_side_car01 = maps\_utility::spawn_anim_model("factory_car_chase_intro_side_car01_crash");
  level.factory_car_chase_intro_side_car02 = maps\_utility::spawn_anim_model("factory_car_chase_intro_side_car02_crash");
  level.third_opfor_car = maps\_vignette_util::vignette_vehicle_spawn("parking_lot_stationary_vehicle", "third_opfor_car");
  level.third_opfor_car thread vehicle_catch_fire_when_shot();
  var_0["factory_car_chase_intro_broken_awning01"] = level.factory_car_chase_intro_broken_awning01;
  var_0["factory_car_chase_intro_broken_awning02"] = level.factory_car_chase_intro_broken_awning02;
  var_0["factory_car_chase_intro_broken_awning03"] = level.factory_car_chase_intro_broken_awning03;
  var_0["factory_car_chase_intro_broken_awning04"] = level.factory_car_chase_intro_broken_awning04;
  var_0["factory_car_chase_intro_broken_fence01"] = level.factory_car_chase_intro_broken_fence01;
  var_0["factory_car_chase_intro_broken_fence02"] = level.factory_car_chase_intro_broken_fence02;
  var_0["factory_car_chase_intro_broken_light_post"] = level.factory_car_chase_intro_broken_light_post;
  var_0["factory_car_chase_intro_side_car01_crash"] = level.factory_car_chase_intro_side_car01;
  var_0["factory_car_chase_intro_side_car02_crash"] = level.factory_car_chase_intro_side_car02;
  var_1 = getent("car_chase_intro", "script_noteworthy");
  var_1 maps\_anim::anim_first_frame(var_0, "car_chase_intro_car_crash");
  var_1 maps\_anim::anim_first_frame_solo(level.third_opfor_car, "factory_car_chase");
  var_2 = getent("parking_lot_trucks_at_rest_blocker", "targetname");
  var_2 connectpaths();
  var_2 notsolid();
  var_3 = getent("parking_lot_fence_blocker", "targetname");
  var_3 connectpaths();
  var_3 notsolid();
}

car_chase_intro_car_crash() {
  var_0 = [];
  var_0["factory_car_chase_intro_broken_awning01"] = level.factory_car_chase_intro_broken_awning01;
  var_0["factory_car_chase_intro_broken_awning02"] = level.factory_car_chase_intro_broken_awning02;
  var_0["factory_car_chase_intro_broken_awning03"] = level.factory_car_chase_intro_broken_awning03;
  var_0["factory_car_chase_intro_broken_awning04"] = level.factory_car_chase_intro_broken_awning04;
  var_0["factory_car_chase_intro_broken_fence01"] = level.factory_car_chase_intro_broken_fence01;
  var_0["factory_car_chase_intro_broken_fence02"] = level.factory_car_chase_intro_broken_fence02;
  var_0["factory_car_chase_intro_broken_light_post"] = level.factory_car_chase_intro_broken_light_post;
  var_0["first_opfor_car"] = level.blockade_vehicle_1;
  var_0["second_opfor_car"] = level.blockade_vehicle_2;
  var_0["factory_car_chase_intro_side_car01_crash"] = level.factory_car_chase_intro_side_car01;
  var_0["factory_car_chase_intro_side_car02_crash"] = level.factory_car_chase_intro_side_car02;
  var_1 = getent("car_chase_intro", "script_noteworthy");
  var_1 thread maps\_anim::anim_single(var_0, "car_chase_intro_car_crash");
  var_2 = [];
  var_2["heavy_weapon_opfor_car"] = level.blockade_vehicle_3;
  var_2["het_cab"] = level.ally_vehicle;
  var_2["het_trailer"] = level.ally_vehicle_trailer;
  thread chase_blockade_crash();
  thread car_crash_slowmo();
  level.ally_vehicle thread maps\factory_parking_lot::parking_lot_blockade_vehicle_death_radius();
  level.ally_vehicle notify("suspend_drive_anims");
  level.ally_vehicle_trailer notify("suspend_drive_anims");
  level.ally_vehicle thread maps\factory_audio::sfx_play_crash_scene();
  var_1 thread maps\_anim::anim_single(var_2, "car_chase_intro_car_crash");
  level waittill("player_switch");
  level.player playrumbleonentity("light_1s");
  common_scripts\utility::exploder("building_corner_01_exploder");
  thread maps\factory_anim::factory_car_chase_spawn();
  chase_wait_for_semi_touch("chase_entering_warehouse");
  var_0[var_0.size] = level.third_opfor_car;
  var_0[var_0.size] = level.blockade_vehicle_3;
  var_0[var_0.size] = level.factory_car_chase_intro_side_car03_blowup;

  foreach(var_4 in var_0) {
    var_4 delete();
  }
}

car_crash_slowmo() {
  wait 5.3333;
  earthquake(0.5, 1.5, level.player.origin, 2500);
  level.player playrumbleonentity("artillery_rumble");
}

semi_trailer_death_trigger() {
  level endon("semi_stopped");
  var_0 = getent("trailer_intro_kill_trigger", "targetname");
  var_0 enablelinkto();
  var_0 linkto(level.ally_vehicle_trailer);
  var_0 thread semi_trailer_death_trigger_delete();
  common_scripts\utility::flag_wait("flag_trailer_intro_kill");
  level notify("new_quote_string");
  setdvar("ui_deadquote", &"FACTORY_FAIL_HIT_BY_TRAILER");
  level.player kill();
  maps\_utility::missionfailedwrapper();
}

semi_trailer_death_trigger_delete() {
  level waittill("semi_stopped");
  self delete();
}

chase_wait_for_semi_touch(var_0) {
  var_1 = getent(var_0, "targetname");

  while(!level.ally_vehicle_front istouching(var_1)) {
    wait 0.05;
  }
}

chase_spawn_drone_group(var_0, var_1, var_2) {
  chase_wait_for_semi_touch(var_0);
  var_3 = maps\_utility::array_spawn_targetname(var_1);

  if(isDefined(var_2)) {
    chase_wait_for_semi_touch(var_2);

    foreach(var_5 in var_3) {
      var_5 delete();
    }
  }
}

enemy_vehicle_twitch() {
  self endon("death");
  self endon("non_physics_vehicle");

  if(!self vehicle_isphysveh()) {
    level notify("non_physics_vehicle");
  }

  for(;;) {
    self waittill("damage");
    physicsjolt(self.origin, 20, 20, (1, 1, 1));
  }
}

vehicle_catch_fire_when_shot() {
  self endon("death");
  self.vehicle_stays_alive = 1;
  var_0 = (self.maxhealth - self.healthbuffer) * 0.5;

  while(self.health - self.healthbuffer > var_0) {
    self waittill("damage");
    waittillframeend;
  }

  playFXOnTag(level._effect["factory_car_fire_runner"], self, "tag_origin");

  while(self.health > 0) {
    self waittill("damage");
    waittillframeend;

    if(self.health < self.healthbuffer) {
      break;
    }
  }

  maps\_vehicle::godon();

  if(self vehicle_isphysveh()) {
    var_1 = self.origin;
    wait 0.1;
    var_2 = self.origin - var_1;
    self stopanimscripted();
    self vehicle_teleport(self.origin + (0, 0, 10), self.angles);
    self vehphys_setspeed(60.0);
    var_3 = 4 * var_2 + (0, 0, randomintrange(200, 250));
    self vehphys_crash();
  }

  playFX(level._effect["lynxexplode"], self.origin, anglestoup(self.angles));
  self playSound("car_explode_factory");
  maps\_vehicle::vehicle_lights_off("headlights");
  self setModel("vehicle_iveco_lynx_destroyed_iw6");
  common_scripts\utility::array_thread(self.riders, ::vehicle_crash_guy, self);
}

vehicle_crash_guy(var_0) {
  if(!isDefined(self) || self.vehicle_position == 0) {
    return;
  } else {
    self.deathanim = undefined;
    self.noragdoll = undefined;
    var_0.riders = common_scripts\utility::array_remove(var_0.riders, self);
    self.ragdoll_immediate = 1;

    if(isDefined(self)) {
      if(!isDefined(self.magic_bullet_shield)) {
        self kill();
      }
    }
  }

  var_0 vehicle_crash_launch_guys();
}

vehicle_crash_launch_guys() {
  wait 0.1;

  if(isDefined(self)) {
    var_0 = self gettagorigin("tag_guy1");
    physicsexplosioncylinder(var_0, 300, 300, 0.25);
  }
}