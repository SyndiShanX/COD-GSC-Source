/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\homecoming_intro.gsc
*****************************************************/

intro_spawn_functions() {
  maps\_utility::array_spawn_function_targetname("intro_runners", ::intro_runners);
  maps\_utility::array_spawn_function_noteworthy("intro_runners", ::intro_runners);
  maps\_utility::array_spawn_function_targetname("intro_bunker_house_runners", ::intro_bunker_house_runners);
  maps\_utility::array_spawn_function_noteworthy("intro_hesco_runners", ::intro_hesco_runners);
  maps\_utility::array_spawn_function_targetname("intro_pullup_truck_guys", ::intro_pullup_truck_guys);
  maps\_utility::array_spawn_function_noteworthy("wounded_carry_guy", ::wounded_carry_guy);
  maps\_utility::array_spawn_function_noteworthy("intro_catwalk_shooters", ::intro_catwalk_shooters);
  getent("intro_street_abrams", "targetname") maps\_utility::add_spawn_function(::intro_street_abrams);
}

intro_sequence_street() {
  level.player setclienttriggeraudiozone("homecoming_black", 0.1);
  thread intro_scripted_sequence();
  common_scripts\utility::array_thread(common_scripts\utility::getstructarray("intro_bunker_turret", "targetname"), ::intro_bunker_turrets);
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("intro_flyovers");
  thread intro_flavorburst("intro_flavorburst_spots");
  thread intro_animated_scenes();
  thread intro_bunker_waver();
  thread intro_fake_mortars();
  maps\_utility::flagwaitthread("FLAG_player_out_of_nh90", maps\homecoming_beach_ambient::beach_nh90_flybys, "intro_nh90_flybys", 1, "stop_intro_flybys");
  level maps\_utility::flagwaitthread("FLAG_start_bunker", maps\_utility::send_notify, "stop_intro_flybys");
  thread intro_skybridge_order_guy();
  thread intro_skybridge_drones();
  thread intro_garage_drones();
  thread intro_house_artemis();
}

intro_scripted_sequence() {
  thread intro_scripted_audio_fade_in_mixing();
  thread intro_player_nh90();
  common_scripts\utility::flag_wait("FLAG_intro_start_scenes");
  thread intro_rangers_scene();
  thread intro_flyby_a10();
  thread intro_house_blocker_truck();
  var_0 = common_scripts\utility::getstructarray("intro_bunker_turret", "targetname");
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.script_noteworthy)) {
      continue;
    }
    if(var_4.script_noteworthy == "bunker_osprey_turret_1") {
      var_1 = getEntArray(var_4.target, "targetname");
      continue;
    }

    var_2 = getEntArray(var_4.target, "targetname");
  }

  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("intro_takeoff_ospreys");
  thread maps\homecoming_util::a10_vista_strafe_group("vista_pier_a10s");
  thread maps\homecoming_util::a10_vista_strafe_group("vista_ship_a10s");
  maps\_utility::array_spawn(getEntArray("intro_cliff_runners", "targetname"));
  var_6 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("intro_cliff_driving_tanks");
  common_scripts\utility::array_call(var_6, ::vehicle_turnengineoff);
  var_7 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("intro_cliff_tanks");
  thread intro_cliff_tanks(var_7);
  maps\_utility::array_spawn(getEntArray("intro_runners", "targetname"));
  wait 1.1;
  thread intro_bunker_turrets_fire(var_1);
  wait 1.5;
  thread intro_bunker_turrets_fire(var_2);
  maps\_utility::delaythread(2, common_scripts\utility::flag_set, "FLAG_start_bunker_turret_fire");
  var_8 = getEntArray("intro_pullup_truck", "targetname");
  common_scripts\utility::array_thread(var_8, ::intro_pullup_trucks);
  common_scripts\utility::flag_wait_any("TRIGFLAG_player_going_through_tent", "FLAG_intro_rangers_move");
  maps\_utility::delaythread(0.2, maps\_utility::music_crossfade, "mus_homecoming_intro_2", 2);
  common_scripts\utility::flag_wait("TRIGFLAG_player_going_through_tent");
  thread maps\_utility::autosave_by_name("intro_tent");
  thread maps\homecoming_util::ambient_smallarms_fire("intro_fake_gun_fire", "intro_gunfire_stop");
  thread maps\homecoming_beach_ambient::beach_ship_phalanx_start("ship_phalanx_structs");
  thread maps\homecoming_beach_ambient::beach_ambient_helicopters();
  thread intro_hesh_overlord_elias_dialog();
  common_scripts\utility::flag_wait("TRIGFLAG_player_heading_towards_bunker");
  common_scripts\utility::flag_wait("TRIGFLAG_player_up_bunker_stairs");
  maps\homecoming_util::a10_vista_strafe_group_delete("vista_pier_a10s");
  maps\homecoming_util::a10_vista_strafe_group_delete("vista_ship_a10s");
  level notify("intro_gunfire_stop");
  maps\_utility::array_delete(var_7);
}

intro_cliff_tanks(var_0) {
  level endon("TRIGFLAG_player_up_bunker_stairs");

  foreach(var_2 in var_0) {
    var_2 vehicle_turnengineoff();
    var_3 = var_2.currentnode;
    var_4 = var_3 maps\homecoming_util::get_linked_struct();
    var_2 setturrettargetvec(var_4.origin);
  }

  for(;;) {
    var_0 = common_scripts\utility::array_randomize(var_0);

    foreach(var_2 in var_0) {
      wait(randomfloatrange(3, 5));
      var_2 maps\homecoming_util::vehicle_fire();
    }
  }
}

intro_scripted_audio_fade_in_mixing() {
  maps\_utility::music_play("mus_homecoming_intro");
  wait 0.2;
  level.player setclienttriggeraudiozone("homecoming_intro", 1.5);
  level.player setclienttriggeraudiozonepartial("homecoming_heavy_mx_dx", "mix");
}

#using_animtree("vehicles");

intro_player_nh90() {
  var_0 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  maps\homecoming_util::hud_hide();
  level.player disableweapons();
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(0);
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname("intro_player_aas");
  var_1 maps\_vehicle::godon();
  var_1 vehicle_turnengineoff();
  var_1 thread maps\_utility::play_sound_on_entity("scn_homecoming_heli_landing");
  var_1 thread maps\homecoming_util::delete_on_flag("TRIGFLAG_player_up_bunker_stairs");
  var_1 notify("kill_treads_forever");
  var_1 setanim( % nh90_right_door_open, 1, 1, 10);
  var_1 setanimrestart( % nh90_landing_gear_down, 1, 1, 10);
  level.intro_player_nh90 = var_1;
  level.dog = maps\homecoming_util::dog_spawn();
  var_2 = common_scripts\utility::getstructarray("intro_nh90_hero_spots", "targetname");

  foreach(var_4 in var_2) {
    var_5 = common_scripts\utility::spawn_tag_origin();
    var_5.origin = var_4.origin;
    var_5.angles = var_4.angles;
    var_5 linkto(var_1);

    if(var_4 maps\homecoming_util::noteworthy_check("hesh")) {
      level.hesh.ospreyspot = var_5;
      level.hesh linkto(level.hesh.ospreyspot, "tag_origin", (0, 0, 0), (0, 0, 0));
      continue;
    }

    if(var_4 maps\homecoming_util::noteworthy_check("dog")) {
      level.dog.ospreyspot = var_5;
      level.dog linkto(level.dog.ospreyspot, "tag_origin", (0, 0, 0), (0, 0, 0));
      continue;
    }

    level.player.ospreyspot = var_5;
    level.player setplayerangles(var_5.angles);
  }

  var_7 = maps\_utility::spawn_anim_model("player_rig");
  var_7 linkto(level.dog.ospreyspot, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.player playerlinktodelta(var_7, "tag_player", 1, 25, 25, 25, 35, 1);
  var_8 = [var_7, level.dog];
  level.dog.ospreyspot thread maps\_anim::anim_loop(var_8, "intro_chopper_idle");
  common_scripts\utility::flag_wait("FLAG_bunker_turrets_setup");
  common_scripts\utility::flag_set("FLAG_intro_start_scenes");
  var_0 thread maps\_hud_util::fade_over_time(0, 1);
  var_1 playrumblelooponentity("chopper_ride_rumble");
  thread maps\_vehicle::gopath(var_1);
  var_1 player_nh90_land();
  common_scripts\utility::flag_set("FLAG_intro_passoff_start");
  wait 1.25;
  level.dog.ospreyspot notify("stop_loop");
  level.dog unlink();
  level.dog.anim_blend_time_override = 0.5;
  var_9 = 0.5;
  maps\_utility::delaythread(var_9, ::player_nh90_jumpout, var_7, var_1);
  wait 0.15;
  var_10 = level.dog.ospreyspot;
  var_10.origin = var_10.origin + (0, 0, 5);
  var_10 thread maps\_anim::anim_single_solo(level.dog, "intro_chopper_letgo");
  level.dog.ospreyspot maps\_anim::anim_single_solo(var_7, "intro_chopper_letgo");
}

player_nh90_land() {
  var_0 = self.currentnode;
  self setneargoalnotifydist(5);
  self sethoverparams(0, 0, 0);
  self setvehgoalpos(var_0.origin, 1);
  self cleargoalyaw();
  self settargetyaw(common_scripts\utility::flat_angle(self.angles)[1]);
  self waittill("near_goal");
}

player_nh90_jumpout(var_0, var_1) {
  level.player enableweapons();
  var_2 = spawn("script_origin", var_0 gettagorigin("tag_player"));
  var_2.angles = var_0 gettagangles("tag_player");
  var_0 delete();
  level.player playerlinkto(var_2);
  var_3 = anglesToForward(var_2.angles);
  var_4 = var_2.origin + var_3 * 75;
  var_2 unlink();
  var_2 moveto(var_4, 0.4, 0.1, 0);
  var_2 waittill("movedone");
  level.player unlink();
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(1);
  maps\homecoming_util::hud_show();
  var_1 stoprumble("chopper_ride_rumble");
  wait 1;
  level.player allowcrouch(1);
  level.player allowstand(1);
  level.player allowprone(1);
  common_scripts\utility::flag_set("FLAG_player_out_of_nh90");
}

intro_rangers_scene() {
  level.intro_rangers = [];
  var_0 = undefined;
  level.intro_dog_guy = undefined;
  var_1 = undefined;
  var_2 = getEntArray("intro_convo_rangers", "targetname");

  foreach(var_4 in var_2) {
    var_5 = var_4 maps\_utility::spawn_ai();

    if(isai(var_5)) {
      var_5 maps\homecoming_util::ignore_everything();
    }

    var_5 maps\_utility::magic_bullet_shield();
    var_5 maps\homecoming_util::set_ai_array("intro_convo_rangers");

    if(var_4 maps\homecoming_util::noteworthy_check("ranger_leader")) {
      var_5.animname = "ranger1";
      var_5.name = "Cpl. Davidson";
      var_0 = var_5;
      level.intro_rangers = common_scripts\utility::array_add(level.intro_rangers, var_5);
      continue;
    }

    if(var_4 maps\homecoming_util::noteworthy_check("ranger2")) {
      var_5.animname = "ranger2";
      var_5.name = "SSGT. Suarez";
      var_1 = var_5;
      level.intro_rangers = common_scripts\utility::array_add(level.intro_rangers, var_5);
      continue;
    }

    if(var_4 maps\homecoming_util::noteworthy_check("dog_guy")) {
      var_5.animname = "dog_guy";
      var_5.name = "PFC. Root";
      level.intro_dog_guy = var_5;
      continue;
    }
  }

  foreach(var_8 in level.intro_rangers) {
    var_8 thread intro_rangers_pathing();

    if(var_8.animname != "dog_guy") {
      var_8.dontevershoot = 1;
      var_8 thread intro_rangers_aimers();
    }
  }

  maps\_utility::delaythread(1.5, common_scripts\utility::flag_set, "FLAG_intro_rangers_start");
  var_0 maps\_utility::delaythread(4, maps\_utility::play_sound_on_entity, "homcom_gs1_holdyourfirehold");
  var_1 maps\_utility::delaythread(6.2, maps\_utility::play_sound_on_entity, "homcom_so2_weaponsdown");
  var_10 = common_scripts\utility::getstruct("dog_pass_off_spot", "targetname");
  var_11 = [level.hesh, level.intro_dog_guy, level.dog];

  foreach(var_8 in var_11) {
    var_8 thread intro_dog_pass_off(var_10);
  }

  common_scripts\utility::flag_wait("FLAG_intro_passoff_start");
  level endon("TRIGFLAG_player_going_through_tent");
  common_scripts\utility::flag_wait("FLAG_nh90_hesh_last_line");
  var_14 = lookupsoundlength("homcom_hsh_angrygrunthowcan");
  wait(var_14 / 1000);
  var_15 = 0;
  var_16 = 1;

  foreach(var_18 in level.intro_rangers) {
    var_19 = "homcom_sos_hooah_" + var_16;
    var_18 maps\_utility::delaythread(var_15, maps\_utility::play_sound_on_entity, var_19);
    var_20 = lookupsoundlength(var_19);
    var_18 maps\_utility::delaythread(var_15, maps\_anim::talk_for_time, var_20 / 1000);
    var_16++;
  }
}

intro_rangers_aimers() {
  common_scripts\utility::flag_wait("FLAG_intro_rangers_start");
  var_0 = spawn("script_origin", level.intro_player_nh90.origin);
  var_0 linkto(level.intro_player_nh90, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1 = gettime();

  while(gettime() - var_1 < 5000) {
    self setentitytarget(var_0, 1);
    wait 0.05;
  }

  self clearentitytarget();
  self.dontevershoot = undefined;
  var_0 delete();
  common_scripts\utility::flag_wait("FLAG_intro_passoff_start");
  var_2 = maps\homecoming_util::get_linked_struct();
  var_2 maps\_anim::anim_generic_reach(self, "run_trans_2_readystand_2");
  var_2 maps\_anim::anim_generic(self, "run_trans_2_readystand_2");
  var_3 = common_scripts\utility::getstruct(var_2.target, "targetname");
  var_3 thread maps\_anim::anim_generic_loop(self, "readystand_idle");
  common_scripts\utility::flag_wait("FLAG_intro_rangers_move");

  if(var_3 maps\homecoming_util::parameters_check("leave_delay")) {
    wait 0.4;
  }

  var_3 notify("stop_loop");
  self stopanimscripted();
  var_3 maps\_anim::anim_generic_run(self, "readystand_trans_2_run_1");
}

intro_rangers_pathing() {
  if(self != level.hesh) {
    common_scripts\utility::flag_wait("FLAG_intro_rangers_move");
  }

  var_0 = common_scripts\utility::getstruct("intro_" + self.animname + "_path", "targetname");
  thread maps\_utility::follow_path_and_animate(var_0, 0);
  common_scripts\utility::flag_wait("FLAG_intro_rangers_move4");
  self pushplayer(1);
  self waittill("path_end_reached");
  self pushplayer(0);
  var_1 = common_scripts\utility::getstruct("bunker_getto_balcony_" + self.animname, "targetname");
  var_2 = getnode(var_1.target, "targetname");
  var_3 = var_2.script_wait;
  var_1 maps\_anim::anim_generic_reach(self, "combat_jog");
  var_1 thread maps\_anim::anim_generic(self, "balcony_run");
  wait(var_3);
  maps\_utility::anim_stopanimscripted();
  self setgoalnode(var_2);
  self.current_follow_path = var_2;
}

intro_dog_pass_off(var_0) {
  if(self == level.hesh) {
    common_scripts\utility::flag_wait("FLAG_intro_passoff_start");
    level.hesh thread intro_rangers_pathing();
    var_0 thread maps\_anim::anim_single_solo_run(level.hesh, "dog_pass_off");
    var_1 = getanimlength(level.hesh maps\_utility::getanim("dog_pass_off"));
    wait(var_1 - 2);
    common_scripts\utility::flag_set("FLAG_intro_tent_runner");
    wait 1.2;
    common_scripts\utility::flag_set("FLAG_intro_rangers_move");
  } else if(self == level.intro_dog_guy) {
    var_0 thread maps\_anim::anim_first_frame_solo(level.intro_dog_guy, "dog_pass_off_start");
    common_scripts\utility::flag_wait("FLAG_intro_rangers_start");
    var_0 thread maps\_anim::anim_single_solo_run(level.intro_dog_guy, "dog_pass_off_start");
    common_scripts\utility::waitframe();
    var_0 maps\_anim::anim_set_rate_single(level.intro_dog_guy, "dog_pass_off_start", 1.5);
    var_0 waittill("dog_pass_off_start");

    if(!common_scripts\utility::flag("FLAG_intro_passoff_start")) {
      var_0 thread maps\_anim::anim_loop_solo(level.intro_dog_guy, "dog_pass_off_start_idle");
    }

    common_scripts\utility::flag_wait("FLAG_intro_handler_start");
    var_0 notify("stop_loop");
    level.intro_dog_guy maps\_utility::anim_stopanimscripted();
    var_0 maps\_anim::anim_single_solo(level.intro_dog_guy, "dog_pass_off");
    var_0 thread maps\_anim::anim_loop_solo(level.intro_dog_guy, "dog_pass_off_idle");
    common_scripts\utility::flag_wait("TRIGFLAG_player_up_bunker_stairs");
    level.intro_dog_guy maps\homecoming_util::delete_safe();
  } else if(self == level.dog) {
    common_scripts\utility::flag_wait("FLAG_intro_dog_start");
    var_0 maps\_anim::anim_single_solo(level.dog, "dog_pass_off");
    var_0 thread maps\_anim::anim_loop_solo(level.dog, "dog_pass_off_idle");
    common_scripts\utility::flag_wait("TRIGFLAG_player_up_bunker_stairs");
    var_0 notify("stop_loop");
    level.dog maps\homecoming_util::delete_safe();
  }
}

intro_hesh_overlord_elias_dialog() {
  level endon("stop_hesh_overlord_elias_dialog");

  if(!common_scripts\utility::flag("FLAG_nh90_hesh_last_line")) {
    return;
  }
  level.hesh maps\_utility::dialogue_queue("homcom_us1_wellbewaitin");
  maps\_utility::smart_radio_dialogue("homcom_us1_welldontjuststand");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_wellhelpoutwhere");
  maps\_utility::smart_radio_dialogue("homcom_hsh_rogerletssecurethat");
}

intro_flyby_a10() {
  common_scripts\utility::noself_delaycall(1.75, ::earthquake, 0.35, 2.5, level.player.origin, 99999);
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname("intro_strafe_a10");
  wait 0.4;
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    maps\_utility::delaythread(0.4, maps\_vehicle::gopath, var_4);
    var_4 maps\_vehicle::vehicle_kill_rumble_forever();

    if(var_4 maps\homecoming_util::parameters_check("close_strafe")) {
      var_1 = var_4;
      continue;
    }

    var_2 = var_4;
  }

  var_2 maps\_utility::delaythread(0, maps\_utility::play_sound_on_entity, "a10_flyby_opening1");
  var_2 maps\_utility::delaythread(0, maps\_utility::play_sound_on_tag, "a10_strafe_roar", "tag_gun");
  var_2 maps\_utility::delaythread(0, maps\homecoming_util::playloopingfx, "a10_tracer", 0.05, undefined, "tag_gun");
  var_1 maps\_utility::delaythread(1.2, maps\_utility::play_sound_on_entity, "a10_flyby_opening2");
  var_1 maps\_utility::delaythread(1.2, maps\_utility::play_sound_on_tag, "a10_strafe_roar", "tag_gun");
  var_1 maps\_utility::delaythread(1.2, maps\homecoming_util::playloopingfx, "a10_tracer", 0.05, undefined, "tag_gun");
  level.player common_scripts\utility::delaycall(1.2, ::playrumblelooponentity, "hind_flyover");
  level.player common_scripts\utility::delaycall(2.5, ::stoprumble, "hind_flyover");
}

intro_pullup_trucks() {
  var_0 = self;
  var_1 = var_0 maps\_utility::get_linked_structs();
  var_2 = var_0 maps\_utility::spawn_vehicle();

  foreach(var_4 in var_1) {
    if(var_4 maps\homecoming_util::parameters_check("truckjunk")) {
      var_5 = spawn("script_model", var_4.origin);
      var_5.angles = var_4.angles;
      var_5 setModel(var_4.script_noteworthy);
      var_5 linkto(var_2, "tag_body");
      var_5 thread maps\homecoming_util::delete_on_flag("TRIGFLAG_player_up_bunker_stairs");
    }
  }

  maps\_vehicle::gopath(var_2);
  var_2 thread maps\homecoming_util::delete_on_flag("TRIGFLAG_player_up_bunker_stairs");
}

intro_pullup_truck_guys() {
  if(!isDefined(level.truckguys_jumped)) {
    level.truckguys_jumped = 0;
    thread intro_pullup_truck_guys_lastguy(self.ridingvehicle);
  }

  var_0 = self.spawner;
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  maps\homecoming_util::ignore_everything();
  maps\_utility::magic_bullet_shield();
  self waittill("jumpedout");
  level.truckguys_jumped++;
  maps\_utility::follow_path_and_animate(var_1, 0);
  maps\homecoming_util::delete_safe();
}

intro_pullup_truck_guys_lastguy(var_0) {
  var_1 = getent("intro_truckguys_lastguy", "targetname");
  var_2 = common_scripts\utility::getstruct(var_1.target, "targetname");
  var_3 = var_1 maps\_utility::spawn_ai();
  var_3 maps\homecoming_util::ignore_everything();
  var_3 maps\_utility::magic_bullet_shield();
  var_4 = spawn("script_origin", var_0 gettagorigin("tag_detach"));
  var_4.angles = var_0 gettagangles("tag_detach");
  var_4.origin = var_4.origin + (-10, 0, 0);
  var_4 linkto(var_0);
  var_3 linkto(var_0);
  var_4 thread maps\_anim::anim_generic_loop(var_3, "bm21_guy3_idle");
  var_0 waittill("unloading");
  wait 0.1;
  var_4 maps\_anim::anim_generic(var_3, "bm21_guy3_climbout");
  var_4 maps\_anim::anim_generic(var_3, "bm21_guy_climbout_landing");
  var_4 delete();
  var_3 unlink();
  var_4 notify("stop_anim");
  maps\_utility::anim_stopanimscripted();
  var_3 maps\_utility::follow_path_and_animate(var_2, 0);
  var_3 maps\homecoming_util::delete_safe();
}

intro_house_blocker_truck() {
  common_scripts\utility::flag_wait("FLAG_start_bunker");
  var_0 = common_scripts\utility::array_add(level.intro_rangers, level.hesh);

  foreach(var_2 in var_0) {
    if(var_2 == level.hesh) {
      var_2 thread intro_house_blocker_truck_rangers("FLAG_intro_rangers_move3");
      continue;
    }

    var_2 thread intro_house_blocker_truck_rangers("FLAG_" + var_2.animname + "_in_backyard");
  }

  common_scripts\utility::flag_wait_all("FLAG_intro_rangers_move3", "FLAG_ranger1_in_backyard", "FLAG_ranger2_in_backyard");
  var_4 = getent("bunker_playercheck_trig", "targetname");

  while(!level.player istouching(var_4)) {
    wait 0.05;
  }

  getent("intro_bunker_truck_blocker", "targetname") maps\_utility::show_entity();
  var_5 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_house_blocker_truck");
  var_5 thread maps\homecoming_util::delete_on_flag("FLAG_bunker_balcony_blocker_set");
}

intro_house_blocker_truck_rangers(var_0) {
  level endon(var_0);
  common_scripts\utility::flag_wait("TRIGFLAG_player_up_bunker_stairs");

  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  self notify("stop_path");
  var_1 = common_scripts\utility::getstruct("intro_" + self.animname + "_path_3", "targetname");
  self forceteleport(var_1.origin, var_1.angles);
  thread maps\_utility::follow_path_and_animate(var_1, 0);
}

intro_catwalk_shooters() {
  maps\_utility::magic_bullet_shield();
  self.nodroneweaponsound = 1;
  self.muzzleflashoverride = "drone_tracer";
  common_scripts\utility::flag_wait("FLAG_start_bunker");
  maps\homecoming_util::delete_safe();
}

intro_animated_scenes() {
  var_0 = common_scripts\utility::getstructarray("intro_animated_scene", "targetname");
  var_1 = getent("intro_anim_drone", "targetname");
  var_2 = getent("intro_anim_ai", "targetname");

  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_soundalias)) {
      var_4 thread intro_animated_scenes_sound();
    }

    var_5 = var_1;

    if(var_4 maps\homecoming_util::parameters_check("ai")) {
      var_5 = var_2;
    }

    switch (var_4.script_noteworthy) {
      case "sitting_wounded":
        var_4 thread sitting_wounded_scene(var_5);
        break;
      case "cpr":
        var_4 thread cpr_scene(var_2, var_1);
        break;
      case "wire_pull":
        var_4 thread bared_wire_scene();
        break;
      case "welder":
        var_4 thread welder_scene(var_5);
        break;
      case "thrower":
        var_4 thread ammo_thrower_scene(var_5);
        break;
      case "generic_looper":
        var_4 thread generic_looper(var_5);
        break;
    }

    common_scripts\utility::waitframe();
  }
}

sitting_wounded_scene(var_0) {
  var_1 = getent(self.target, "targetname");
  var_2 = var_1 common_scripts\utility::get_linked_ent();
  var_3 = var_0 maps\_utility::spawn_ai();
  var_3 maps\_utility::magic_bullet_shield();
  var_3 maps\_utility::gun_remove();
  thread maps\_anim::anim_generic_loop(var_3, "hurt_sitting_wounded_loop");
  thread sitting_wounded_scene_sound();
  var_1 waittill("trigger");
  var_4 = var_2 maps\_utility::spawn_ai();
  var_4 maps\homecoming_util::ignore_everything();
  var_4 maps\_utility::magic_bullet_shield();
  var_4 maps\homecoming_util::disable_arrivals_and_exits();
  var_4 maps\_utility::set_generic_run_anim("combat_jog");
  maps\_anim::anim_generic_reach(var_4, "help_hurt_sitting_helper");
  self notify("stop_loop");
  thread maps\_anim::anim_generic(var_3, "help_hurt_sitting_wounded");
  maps\_anim::anim_generic(var_4, "help_hurt_sitting_helper");
  thread maps\_anim::anim_generic_loop(var_3, "help_hurt_sitting_wounded_loop");
  thread maps\_anim::anim_generic_loop(var_4, "help_hurt_sitting_helper_loop");
  common_scripts\utility::flag_wait("TRIGFLAG_player_up_bunker_stairs");
  var_4 maps\homecoming_util::delete_safe();
  var_3 maps\homecoming_util::delete_safe();
}

sitting_wounded_scene_sound() {
  self endon("death");
  var_0 = spawn("trigger_radius", self.origin, 0, 150, 150);
  var_0 waittill("trigger");
  common_scripts\utility::play_sound_in_space("homcom_us2_morphinedocineedmorphine");
  common_scripts\utility::play_sound_in_space("homcom_us3_lookslikethebullet");
}

cpr_scene(var_0, var_1) {
  var_2 = var_1 maps\_utility::spawn_ai();
  var_2 maps\_utility::gun_remove();
  var_2 maps\_utility::magic_bullet_shield();
  var_2.animname = "generic";
  var_2 freeentitysentient();
  var_2.no_friendly_fire_penalty = 1;
  var_3 = var_0 maps\_utility::spawn_ai();
  var_3 maps\homecoming_util::ignore_everything();
  var_3 maps\_utility::set_battlechatter(0);
  var_3 maps\_utility::gun_remove();
  var_3 maps\_utility::magic_bullet_shield();
  var_3.animname = "generic";
  var_4 = common_scripts\utility::getstruct("intro_cpr_run_struct", "targetname");
  var_4 thread maps\_anim::anim_generic(var_3, "cpr_run");
  thread maps\_anim::anim_generic(var_2, "DC_Burning_CPR_wounded");
  common_scripts\utility::waitframe();
  var_4 thread maps\_anim::anim_set_rate_single(var_3, "cpr_run", 0);
  thread maps\_anim::anim_set_rate_single(var_2, "DC_Burning_CPR_wounded", 0);
  common_scripts\utility::flag_wait_any("TRIGFLAG_start_medic_runner", "FLAG_intro_tent_runner");
  var_4 thread maps\_anim::anim_set_rate_single(var_3, "cpr_run", 1);
  var_4 waittill("cpr_run");
  var_5 = getanimlength(maps\_utility::getanim_generic("DC_Burning_CPR_medic"));
  var_6 = var_5 - 4;
  var_2 maps\_utility::delaythread(var_6, maps\homecoming_drones::drone_setname, "");
  var_5 = getanimlength(maps\_utility::getanim_generic("DC_Burning_CPR_medic"));
  thread maps\_anim::anim_set_rate_single(var_2, "DC_Burning_CPR_wounded", 1);
  thread maps\_anim::anim_generic(var_3, "DC_Burning_CPR_medic");
  common_scripts\utility::flag_wait_or_timeout("TRIGFLAG_player_up_bunker_stairs", var_5);

  if(!common_scripts\utility::flag("TRIGFLAG_player_up_bunker_stairs")) {
    thread maps\_anim::anim_generic_loop(var_3, "DC_Burning_CPR_medic_endidle");
    common_scripts\utility::flag_wait("TRIGFLAG_player_up_bunker_stairs");
  }

  var_2 maps\homecoming_util::delete_safe();
  var_3 notify("stop_loop");
  var_3 maps\homecoming_util::delete_safe();
}

bared_wire_scene() {
  level.barbedwirerunners = [];
  thread barbed_wire_waver();
  var_0 = getent("bared_wire_puller", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai();
  var_1 maps\_utility::magic_bullet_shield();
  var_1 hide();
  var_1.animname = "wire_puller";
  var_2 = maps\_utility::spawn_anim_model("barbed_wire", self.origin);
  var_3 = [var_1, var_2];
  thread maps\_anim::anim_first_frame(var_3, "wire_pull");
  common_scripts\utility::flag_wait("TRIGFLAG_player_going_through_tent");
  var_1 show();
  common_scripts\utility::flag_wait_all("TRIGFLAG_barbed_wire_close", "FLAG_waver_through_wire");

  while(level.barbedwirerunners.size > 0) {
    wait 0.1;
  }

  var_4 = getanimlength(var_1 maps\_utility::getanim("wire_pull"));
  thread maps\_anim::anim_single(var_3, "wire_pull");
  var_2 thread maps\_utility::play_sound_on_entity("scn_homecoming_wire_drag");
  wait(var_4 - 3);
  var_1 maps\_utility::anim_stopanimscripted();
  var_1 thread maps\homecoming_util::move_on_path(common_scripts\utility::getstruct("intro_barb_guy_run_path", "targetname"), 1);
  common_scripts\utility::flag_wait("TRIGFLAG_bunker_house_backyard");
  var_1 maps\homecoming_util::delete_safe();
  common_scripts\utility::flag_wait("FLAG_bunker_balcony_blocker_set");
  var_2 maps\homecoming_util::delete_safe();
}

barbed_wire_waver() {
  var_0 = getent("bared_wire_waver", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai();
  var_1 maps\_utility::walkdist_zero();
  var_1 thread maps\_utility::magic_bullet_shield();
  var_2 = common_scripts\utility::getstruct(var_0.script_linkto, "script_linkname");
  var_2 thread maps\_anim::anim_generic_loop(var_1, "clockwork_chaos_wave_guard");
  common_scripts\utility::flag_wait("TRIGFLAG_barbed_wire_close");
  var_2 notify("stop_loop");
  var_1 stopanimscripted();
  var_2.angles = (0, 270, 0);
  var_2 thread maps\_anim::anim_generic(var_1, "readystand_trans_2_run_2");
  var_3 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_1 maps\_utility::follow_path_and_animate(var_3, 0);
  var_1 maps\homecoming_util::delete_safe();
}

welder_scene(var_0) {
  var_1 = var_0 maps\_utility::spawn_ai();
  var_1 maps\_utility::magic_bullet_shield();
  var_1 maps\_utility::gun_remove();
  var_1.weldtool = spawn("script_model", var_1.origin);
  var_1.weldtool setModel("machinery_welder_handle");
  var_1.weldtool linkto(var_1, "tag_inhand", (0, 0, 0), (0, 0, 0));
  thread maps\_anim::anim_generic_loop(var_1, self.animation);
  common_scripts\utility::flag_wait("TRIGFLAG_player_up_bunker_stairs");
  var_1.weldtool common_scripts\utility::stop_loop_sound_on_entity("elec_spark_welding_bursts");
  var_1.weldtool delete();
  self notify("stop_loop");
  var_1 maps\homecoming_util::delete_safe();
}

ammo_thrower_scene(var_0) {
  var_1 = var_0 maps\_utility::spawn_ai();
  var_1 maps\_utility::magic_bullet_shield();
  var_1 maps\_utility::gun_remove();
  var_1 maps\_utility::hide_entity();
  var_1 maps\_utility::flagwaitthread("TRIGFLAG_barbed_wire_close", maps\_utility::show_entity);
  var_2 = self.animation;
  thread maps\_anim::anim_generic_loop(var_1, var_2);
  var_3 = getanimlength(maps\_utility::getanim_generic("dh_food_server")[0]);

  while(!common_scripts\utility::flag("TRIGFLAG_bunker_house_backyard")) {
    var_1 attach("mil_ammo_case_2", "tag_inhand");
    common_scripts\utility::flag_wait_or_timeout("TRIGFLAG_bunker_house_backyard", var_3);
    var_1 detach("mil_ammo_case_2", "tag_inhand");
  }

  var_1 maps\homecoming_util::delete_safe();
}

generic_looper(var_0) {
  var_1 = var_0 maps\_utility::spawn_ai();
  var_1 maps\_utility::magic_bullet_shield();

  if(maps\homecoming_util::parameters_check("notsolid")) {
    var_1 notsolid();
  }

  if(maps\homecoming_util::parameters_check("nogun")) {
    var_1 maps\_utility::gun_remove();
  }

  if(maps\homecoming_util::parameters_check("hide")) {
    var_1 maps\_utility::hide_entity();
    var_1 maps\_utility::flagwaitthread("TRIGFLAG_player_going_through_tent", maps\_utility::show_entity);
  }

  if(maps\homecoming_util::parameters_check("radio")) {
    var_1 attach("prop_uav_radio", "tag_inhand");
  }

  if(maps\homecoming_util::parameters_check("first_frame")) {
    thread maps\_anim::anim_generic_first_frame(var_1, self.animation);
  } else {
    thread maps\_anim::anim_generic_loop(var_1, self.animation);
  }

  common_scripts\utility::flag_wait("TRIGFLAG_player_up_bunker_stairs");
  var_1 maps\homecoming_util::delete_safe();
}

intro_animated_scenes_sound() {
  self endon("death");
  var_0 = self.script_soundalias;
  var_1 = 100;

  if(isDefined(self.radius)) {
    var_1 = self.radius;
  }

  var_2 = spawn("trigger_radius", self.origin, 0, var_1, var_1);

  while(!common_scripts\utility::flag("TRIGFLAG_player_up_bunker_stairs")) {
    var_2 waittill("trigger");
    wait(randomfloatrange(0, 0.5));

    while(level.player istouching(var_2)) {
      common_scripts\utility::play_sound_in_space(var_0);
      wait(randomintrange(4, 8));
    }
  }
}

#using_animtree("generic_human");

wounded_carry_guy() {
  var_0 = self.spawner;
  var_1 = getent("intro_anim_drone", "targetname");
  var_2 = var_1 maps\_utility::spawn_ai();
  var_2 useanimtree(#animtree);
  var_2.name = "Pvt. Gavin";
  var_2 setlookattext("Pvt. Gavin", &"");
  var_2 thread maps\_utility::magic_bullet_shield();
  var_2 maps\homecoming_drones::drone_gun_remove();
  thread maps\_utility::magic_bullet_shield();
  self.name = "Sgt. Ramsey";
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.nododgemove = 1;
  maps\_utility::pathrandompercent_set(0);
  self pushplayer(1);
  maps\homecoming_util::ignore_everything();
  maps\_utility::set_generic_run_anim("wounded_carry_carrier");
  thread maps\_anim::anim_generic_loop(var_2, "wounded_carry_wounded", "stop_anim", "tag_origin");
  var_2 linkto(self, "tag_origin");
  var_3 = common_scripts\utility::getstruct(var_0.target, "targetname");
  self forceteleport(var_3.origin, var_3.angles);

  for(;;) {
    self.goalradius = 5;
    self setgoalpos(var_3.origin);
    self waittill("goal");

    if(!isDefined(var_3.target)) {
      break;
    }

    var_3 = common_scripts\utility::getstruct(var_3.target, "targetname");
  }

  var_4 = common_scripts\utility::getstruct(var_3.script_linkto, "script_linkname");
  self.goalradius = 10;
  self setgoalpos(var_4.origin);

  while(distance(var_4.origin, self.origin) > 10) {
    self.goalradius = 10;
    wait 0.05;
  }

  var_2 thread wounded_carry_guy_sound();
  var_2 unlink();
  var_4 thread maps\_anim::anim_generic(self, "wounded_carry_putdown_carrier");
  self notify("stop_anim");
  var_2 stopanimscripted();
  var_4 maps\_anim::anim_generic(var_2, "wounded_carry_putdown_wounded");
  var_4 thread maps\_anim::anim_generic_loop(self, "wounded_carry_idle_carrier");
  var_4 thread maps\_anim::anim_generic_loop(var_2, "wounded_carry_idle_wounded");

  if(!isDefined(self.script_parameters)) {
    return;
  }
  common_scripts\utility::flag_wait(self.script_parameters);
  var_2 maps\homecoming_util::delete_safe();
  maps\homecoming_util::delete_safe();
}

wounded_carry_guy_sound() {
  self endon("death");
  var_0 = spawn("trigger_radius", self.origin, 0, 150, 150);
  var_0 waittill("trigger");
  common_scripts\utility::play_sound_in_space("homcom_us1_aghhthatshithurtsman");
  common_scripts\utility::play_sound_in_space("homcom_us2_hereletmecheck");
}

intro_bunker_waver() {
  common_scripts\utility::flag_wait("TRIGFLAG_barbed_wire_close");
  var_0 = getent("bunker_waver_spawner", "targetname");
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 = var_0 maps\_utility::spawn_ai();
  var_2 maps\_utility::magic_bullet_shield();
  var_2 thread intro_bunker_waver_sound();
  var_1 thread maps\_anim::anim_generic_loop(var_2, "clockwork_chaos_wave_guard");
  var_3 = getent("bunker_waver_runner_player_trig", "targetname");
  var_4 = getent("bunker_waver_runner_hesh_trig", "targetname");
  maps\_utility::add_wait(maps\homecoming_util::waittill_trigger, var_3);
  maps\_utility::add_wait(maps\homecoming_util::waittill_trigger, var_4, level.hesh);
  maps\_utility::do_wait_any();
  var_5 = getent("bunker_waver_runner_spawner", "targetname");
  var_6 = var_5 maps\_utility::spawn_ai();
  var_6 maps\_utility::magic_bullet_shield();
  common_scripts\utility::flag_wait("TRIGFLAG_player_at_balcony");
  var_2 maps\homecoming_util::delete_safe();
  var_6 maps\homecoming_util::delete_safe();
}

intro_bunker_waver_sound() {
  self endon("death");
  var_0 = spawn("trigger_radius", self.origin, 0, 250, 100);
  var_0 waittill("trigger");
  var_1 = lookupsoundlength("homcom_us4_cmonletsgomove");
  thread maps\_anim::talk_for_time(var_1 / 1000);
  maps\_utility::play_sound_on_entity("homcom_us4_cmonletsgomove");
}

intro_fake_mortars() {
  level endon("TRIGFLAG_player_up_bunker_stairs");
  common_scripts\utility::flag_wait("FLAG_player_out_of_nh90");
  var_0 = common_scripts\utility::getstructarray("intro_fake_mortars", "targetname");
  var_1 = getent("intro_fake_mortars_trigger", "targetname");
  var_2 = var_0;
  var_3 = 0;

  for(;;) {
    if(level.player istouching(var_1)) {
      wait(randomfloatrange(3, 5));
    } else {
      wait(randomfloatrange(5, 8));
    }

    var_4 = common_scripts\utility::random(var_2);
    var_2 = common_scripts\utility::array_remove(var_0, var_4);
    var_5 = 1;

    if(common_scripts\utility::cointoss() && var_3 == 0) {
      var_5++;
      var_3 = 1;
    } else
      var_3 = 0;

    for(var_6 = 0; var_6 < var_5; var_6++) {
      if(var_5 != 1) {
        wait(randomfloatrange(0.2, 0.4));
        var_4 = common_scripts\utility::random(var_2);
        var_2 = common_scripts\utility::array_remove(var_0, var_4);
      } else
        var_4 common_scripts\utility::play_sound_in_space("mortar_incoming");

      var_7 = randomfloatrange(0.1, 0.3);
      var_8 = randomfloatrange(1.4, 2);
      earthquake(var_7, var_8, var_4.origin, 10000);
      level.player playrumbleonentity("damage_light");
      physicsjolt(level.player.origin, 400, 200, anglesToForward(level.player.angles) * 0.05);

      if(level.player istouching(var_1)) {
        playFX(level._effect["mortar"]["sand"], var_4.origin);
      }

      var_4 thread common_scripts\utility::play_sound_in_space("mortar_explosion_big_dirt");
    }
  }
}

set_flavorburst_drones(var_0, var_1) {
  level.flavorbursts[var_0] = var_1;
  var_2 = level.drones[var_0].array;
  common_scripts\utility::array_thread(var_2, maps\_utility::set_flavorbursts, var_1);
}

intro_flavorburst(var_0) {
  level endon("stop_intro_flavorburst");
  maps\_utility::battlechatter_off("allies");
  maps\_utility::flavorbursts_off("allies");
  var_1 = common_scripts\utility::getstructarray(var_0, "targetname");

  for(;;) {
    var_2 = common_scripts\utility::getclosest(level.player.origin, var_1, 800);

    if(isDefined(var_2)) {
      var_2 thread custom_flavor_burst_on_me();
    }

    wait 6;
  }
}

custom_flavor_burst_on_me() {
  self endon("death");
  self notify("doing_custom_flavor_burst");
  self endon("doing_custom_flavor_burst");
  wait(randomfloatrange(0.5, 2));
  var_0 = "american";
  var_1 = animscripts\battlechatter::getflavorburstid(self, var_0);
  var_2 = animscripts\battlechatter::getflavorburstaliases(var_0, var_1);
  var_3 = spawn("script_origin", self.origin);
  thread custom_flavor_burst_ent_delete(var_3);

  if(isDefined(var_2.size)) {
    if(var_2.size > 0) {
      var_3 playSound(common_scripts\utility::random(var_2), "sounddone");
      self waittill("sounddone");
    }
  }
}

custom_flavor_burst_ent_delete(var_0) {
  var_0 waittill("sounddone");
  var_0 delete();
}

intro_bunker_turrets() {
  var_0 = getEntArray(self.target, "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1[var_1.size] = var_3.origin;
    var_4 = common_scripts\utility::getstruct(var_3.target, "targetname");
    var_3.firetag = spawn("script_model", var_4.origin);
    var_3.firetag setModel("tag_origin");
    var_3.firetag.angles = var_4.angles;
    var_3.firetag linkto(var_3);
  }

  common_scripts\utility::flag_set("FLAG_bunker_turrets_setup");
  common_scripts\utility::flag_wait("FLAG_start_bunker_turret_fire");
  var_6 = maps\homecoming_util::get_midpoint(var_1, 1);
  var_7 = spawn("script_model", var_6);
  var_7 setModel("tag_origin");
  var_8 = var_7.angles[1];
  var_9 = randomint(2);

  for(;;) {
    wait(randomfloatrange(2.5, 4.5));

    foreach(var_3 in var_0) {
      var_3 linkto(var_7);
    }

    var_12 = undefined;

    if(var_9) {
      var_9 = 0;
      var_12 = randomintrange(5, 25);
      var_12 = var_8 + var_12;
    } else {
      var_9 = 1;
      var_12 = randomintrange(-25, -5);
      var_12 = var_8 + var_12;
    }

    var_13 = (var_7.angles[0], var_12, var_7.angles[2]);
    var_7 rotateto(var_13, 2, 0.5, 0.5);
    var_7 waittill("rotatedone");
    wait 0.2;
    intro_bunker_turrets_fire(var_0);
  }
}

intro_bunker_turrets_fire(var_0) {
  foreach(var_2 in var_0) {
    var_2 unlink();
    playFXOnTag(common_scripts\utility::getfx("tank_flash"), var_2.firetag, "tag_origin");
    var_2.firetag thread maps\_utility::play_sound_on_tag("intro_bunker_fire", "tag_origin");
    var_3 = var_2.origin;
    var_4 = anglesToForward(var_2.angles);
    var_5 = var_4 * -1;
    var_6 = var_2.origin + var_5 * 25;
    var_2 moveto(var_6, 0.2);
    wait 0.2;
    var_2 moveto(var_3, 0.6);
    wait 0.2;
  }
}

#using_animtree("vehicles");

intro_medic_osprey() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname("intro_medic_osprey");
  var_0 notify("stop_kicking_up_dust");
  var_0 setanimrestart( % v22_osprey_wings_up, 1, 0.2, 10);
  var_0 setanimrestart( % v22_osprey_hatch_down, 1, 0.2, 10);
}

intro_runners() {
  maps\homecoming_util::disable_arrivals_and_exits();
  maps\homecoming_util::ignore_everything();
  maps\_utility::pathrandompercent_zero();
  maps\_utility::walkdist_zero();
  self.fixednode = 0;
  self.interval = 0;
  self.pushable = 0;
  self.badplaceawareness = 0;
  maps\_utility::magic_bullet_shield(1);

  if(maps\homecoming_util::parameters_check("jog")) {
    maps\_utility::set_generic_run_anim("combat_jog");
  }

  thread maps\homecoming_util::move_on_path(common_scripts\utility::getstruct(self.target, "targetname"), 1);

  if(maps\homecoming_util::noteworthy_check("delete_after_land")) {
    common_scripts\utility::flag_wait("FLAG_intro_passoff_start");
    maps\homecoming_util::delete_safe();
  }

  var_0 = common_scripts\utility::waittill_any_return("heading_to_wire", "death");

  if(var_0 == "death") {
    return;
  }
  var_1 = common_scripts\utility::getstructarray("intro_street_runners_hesco_goals", "script_noteworthy");

  if(common_scripts\utility::flag("TRIGFLAG_barbed_wire_close")) {
    self notify("stop_path");
    self setgoalpos(common_scripts\utility::random(var_1).origin);
    self waittill("goal");
    self delete();
    return;
  }

  level.barbedwirerunners = common_scripts\utility::array_add(level.barbedwirerunners, self);
  var_0 = common_scripts\utility::waittill_any_return("past_wire", "death");
  level.barbedwirerunners = common_scripts\utility::array_remove(level.barbedwirerunners, self);
}

intro_hesco_runners() {
  var_0 = self.spawner;
  maps\_utility::magic_bullet_shield();

  if(isai(self)) {
    maps\homecoming_util::disable_arrivals_and_exits();
    maps\_utility::pathrandompercent_zero();
    maps\_utility::walkdist_zero();
  }

  if(maps\homecoming_util::parameters_check("squad")) {
    var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
    var_1 thread maps\_anim::anim_generic_loop(self, "covercrouch_hide_idle");
    maps\homecoming_util::waittill_trigger("hesco_runners_run_trig");

    if(isDefined(var_0.script_duration)) {
      wait(var_0.script_duration);
    }

    var_1 notify("stop_loop");
    self stopanimscripted();
    var_1 maps\_anim::anim_generic_run(self, "crouch_2run_F");
    maps\_utility::stop_magic_bullet_shield();
  } else if(maps\homecoming_util::parameters_check("spinner")) {
    self.animname = "generic";
    var_2 = var_0 common_scripts\utility::getstruct(var_0.target, "targetname");
    var_2 thread maps\_anim::anim_generic(self, "combatwalk_f_spin");
    common_scripts\utility::waitframe();
    var_2 maps\_anim::anim_set_rate_single(self, "combatwalk_f_spin", 1.3);
  } else if(maps\homecoming_util::parameters_check("drone")) {
    wait 1;
    self notify("move");
    self waittill("goal");
    maps\homecoming_util::delete_safe();
    return;
  }

  var_2 = var_0 maps\homecoming_util::get_linked_struct();
  maps\_utility::follow_path_and_animate(var_2, 0);
  maps\homecoming_util::delete_safe();
}

intro_bunker_house_runners() {
  self endon("death");
  var_0 = self.spawner;
  maps\homecoming_util::disable_arrivals_and_exits();
  maps\_utility::set_generic_run_anim("combat_jog");
  maps\_utility::set_moveplaybackrate(1.2);
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  thread maps\_utility::follow_path_and_animate(var_1, 99999999);
  var_2 = var_0 maps\homecoming_util::get_linked_struct();
  var_2 waittill("trigger");
  var_3 = cos(65);

  while(!common_scripts\utility::flag("FLAG_bunker_hallway_explosion")) {
    wait 0.05;

    if(maps\_utility::within_fov_of_players(self.origin, var_3)) {
      continue;
    }
    if(!level.player maps\_utility::can_see_origin(self.origin)) {
      maps\homecoming_util::delete_safe();
    }
  }

  maps\homecoming_util::delete_safe();
}

intro_street_abrams() {
  self vehicle_turnengineoff();
  self.firetime[0] = 2.5;
  self.firetime[1] = 7;
  self.turretturntime = 0;
  self.firerumble = "artillery_rumble";
  self.black_distance = 400;
  common_scripts\utility::flag_wait("TRIGFLAG_player_at_balcony");
  self delete();
}

intro_house_artemis() {
  var_0 = getent("intro_house_artemis", "targetname");
  var_1 = var_0 maps\_utility::spawn_vehicle();
  var_1 thread maps\homecoming_util::artemis_think();
  var_1 vehicle_turnengineoff();

  if(!common_scripts\utility::flag("FLAG_bunker_balcony_blocker_set")) {
    common_scripts\utility::flag_wait("FLAG_bunker_balcony_blocker_set");
    var_1 delete();
  }

  common_scripts\utility::flag_wait("FLAG_start_trenches");
  var_1 = var_0 maps\_utility::spawn_vehicle();
  var_1 thread maps\homecoming_util::artemis_think();
  var_1 vehicle_turnengineoff();
  var_1.artemisnofiresound = undefined;
  common_scripts\utility::flag_wait("TRIGFLAG_player_leaving_tower_parking_area");
  var_1 delete();
}

intro_street_crossers() {
  var_0 = getent("intro_street_runners", "targetname");

  for(var_1 = 0; var_1 < 3; var_1++) {
    var_2 = var_0 maps\_utility::spawn_ai(1);
    wait(randomfloatrange(0.7, 1.2));
  }
}

intro_skybridge_order_guy() {
  var_0 = getent("intro_skybridge_orderer", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai();
  var_1 maps\_utility::set_generic_run_anim("combat_jog");
  var_1 maps\_utility::magic_bullet_shield();
  var_1 maps\homecoming_util::disable_arrivals_and_exits();
  var_1 maps\homecoming_util::ignore_everything();
  var_2 = common_scripts\utility::getstruct("intro_skybridge_orderspot", "targetname");
  var_1 maps\_utility::follow_path_and_animate(var_2, 999999);
  var_1 maps\homecoming_util::delete_safe();
}

intro_skybridge_drones() {
  var_0 = getEntArray("intro_skybridge_runners", "targetname");
  maps\_utility::array_spawn_function(var_0, maps\homecoming_util::set_ai_array, "intro_drone_runners");
  var_1 = ["run", "run2", "run3", "run4", "run5"];
  var_2 = ["drone_fad_fire_npc", "drone_r5rgp_fire_npc"];
  var_3 = [2, 7];
  var_0 thread maps\homecoming_drones::drone_infinite_runners("FLAG_stop_intro_drone_runners", var_3, var_1, var_2);
  var_0 = getEntArray("intro_skybridge2_runners", "targetname");
  var_3 = [3, 5.5];
  var_0 thread maps\homecoming_drones::drone_infinite_runners("FLAG_stop_intro_drone_runners", var_3, var_1, var_2);
  maps\_utility::array_spawn_function(var_0, maps\homecoming_util::set_ai_array, "intro_drone_runners");
}

intro_garage_drones() {
  maps\homecoming_util::waittill_trigger("hesco_runners_run_trig");
  var_0 = getEntArray("intro_garage_runners", "targetname");
  maps\_utility::array_spawn_function(var_0, maps\homecoming_util::set_ai_array, "intro_drone_runners");
  var_1 = ["run", "run2", "run3", "run4", "run5"];
  var_2 = [2.2, 4];
  var_0 thread maps\homecoming_drones::drone_infinite_runners("TRIGFLAG_bunker_house_backyard", var_2, var_1);
}

intro_street_drones() {
  var_0 = getEntArray("intro_street_runners", "targetname");
  maps\_utility::array_spawn_function(var_0, maps\homecoming_util::set_ai_array, "intro_drone_runners");
  var_1 = ["run"];
  var_2 = [2.8, 4];
  var_0 thread maps\homecoming_drones::drone_infinite_runners("FLAG_stop_intro_drone_runners", var_2, var_1);
}

beach_flyover_helis() {
  var_0 = getEntArray("beach_flyover_helis", "targetname");
  var_1 = undefined;

  for(;;) {
    var_2 = var_0;

    while(var_2.size > 0) {
      for(;;) {
        var_3 = var_2[randomint(var_2.size)];

        if(!isDefined(var_1)) {
          break;
        }

        if(var_1 == var_3) {
          wait 0.05;
          continue;
        }

        break;
      }

      var_1 = var_3;
      var_3 thread maps\_vehicle::spawn_vehicle_and_gopath();
      var_2 = common_scripts\utility::array_remove(var_2, var_3);
      wait(randomintrange(1, 5));
    }
  }
}