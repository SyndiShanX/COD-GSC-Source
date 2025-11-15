/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\homecoming_beach.gsc
*****************************************************/

beach_spawn_functions() {
  maps\_utility::array_spawn_function_noteworthy("default_beach_enemy", ::beach_enemy_default);
  maps\_utility::array_spawn_function_targetname("hovercraft_drone_spawner", maps\homecoming_util::hovercraft_drone_default);
  maps\_utility::array_spawn_function_targetname("house_stumble_dude", ::beach_bunker_stumble_event);
  maps\_utility::array_spawn_function_targetname("beach_n90_spawners", ::beach_enemy_default);
  maps\_utility::array_spawn_function_targetname("initial_beach_spawners", maps\homecoming_util::set_ai_array, "inital_beach_guys");
  maps\_utility::array_spawn_function_noteworthy("bunker_minigun_guy", ::bunker_mg_guy);
  maps\_utility::array_spawn_function_targetname("beach_frontline_abrams", ::beach_frontline_abrams);
  maps\_utility::array_spawn_function_targetname("beach_lander", maps\homecoming_util::heli_beach_lander_init);
  getent("bunker_wave3_hovercraft_tank", "targetname") maps\_utility::add_spawn_function(::beach_wave3_tank_setup);
  maps\_utility::array_spawn_function_noteworthy("hovercraft_tanks", ::beach_hovercraft_tanks_default);
  maps\_utility::array_spawn_function_targetname("hovercraft_unloader", maps\homecoming_util::hovercraft_init);
  getent("bunker_player_attacker_hind", "targetname") maps\_utility::add_spawn_function(::playerhind_destory_balcony_mg);
  common_scripts\utility::array_thread(getEntArray("beach_mg_spawners", "targetname"), maps\_mgturret::mg42_think);
}

beach_sequence_bunker_new() {
  common_scripts\utility::flag_wait("FLAG_start_bunker");
  thread maps\_utility::autosave_by_name("bunker_wave1");
  thread beach_enemy_attack_player_manager();

  if(isDefined(level._audio.last_song)) {
    maps\_utility::flagwaitthread("TRIGFLAG_bunker_music_stinger", maps\_utility::music_crossfade, "mus_homecoming_beach_reveal", 2.0);
    thread beach_reveal_turn_off_mix_snapshot();
  }

  level.hesh maps\_utility::set_ignoresuppression(1);
  level.hesh setthreatbiasgroup("bunker_allies");
  level.player setthreatbiasgroup("bunker_allies");
  var_0 = common_scripts\utility::array_add(level.intro_rangers, level.hesh);

  foreach(var_2 in var_0) {
    var_2 maps\homecoming_util::clear_ignore_everything();
    var_2.grenadeawareness = 0;
    var_2 pushplayer(1);
  }

  var_4 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("beach_house_battlehinds");
  common_scripts\utility::array_thread(getEntArray("destructible_dragons_teeth", "targetname"), maps\homecoming_util::destructible_dragons_teeth);
  common_scripts\utility::array_thread(getEntArray("destructible_sandbags_beach", "targetname"), maps\homecoming_util::destructible_sandbags);
  thread maps\homecoming_beach_ambient::init_beach_ambient();
  var_5 = getEntArray("beach_ally_turrets", "targetname");

  foreach(var_7 in var_5) {
    var_8 = var_7 common_scripts\utility::get_linked_ents();
    var_7 thread maps\homecoming_util::turret_shoot_targets(var_8);
    var_7 setdefaultdroppitch(-10);
  }

  level.balcony = bunker_balcony_setup();
  thread beach_wave1_logic();
  common_scripts\utility::flag_wait("FLAG_beach_start_wave_2");
  maps\_utility::delaythread(0, ::artillery_smoke_grenade);
  maps\_utility::delaythread(7, ::wave1_hovercraft_missile_barrage);
  maps\_utility::array_delete(common_scripts\utility::array_removeundefined(level.hovercraftdrones));
  beach_wave2_logic();
  common_scripts\utility::flag_wait("FLAG_start_balcony_collapse");
  thread maps\homecoming_a10::a10_mechanic_off();
  common_scripts\utility::array_thread(level.beachfronelinedrones, maps\homecoming_util::delete_safe);
  thread player_fall_off_balcony();
  common_scripts\utility::flag_wait("FLAG_balcony_fall_done");
  var_10 = getEntArray("beach_front_runners", "targetname");
  maps\_utility::array_notify(var_10, "stop_drone_runners");
  level notify("beach_attacker_logic_off");
  var_11 = maps\homecoming_util::get_ai_array("beach_front_attackers");
  maps\_utility::array_delete(var_11);
  var_12 = maps\homecoming_util::get_ai_array("inital_beach_guys");
  common_scripts\utility::array_thread(var_12, maps\homecoming_util::delete_safe);
  level.hesh maps\_utility::set_ignoresuppression(0);
  level.hesh.grenadeawareness = 1;
  level.hesh pushplayer(0);
  level.hesh notify("stop_random_targets");
  maps\homecoming_util::delete_ai_array("intro_convo_rangers");
  level.secondarygunner maps\homecoming_util::delete_safe();
  level notify("stop_beach_hinds");
  level notify("hovercraft_loopers_stop");
  level.hovercraftloopers = common_scripts\utility::array_removeundefined(level.hovercraftloopers);
  common_scripts\utility::array_thread(level.hovercraftloopers, maps\homecoming_util::hovercraft_delete);
  level.beachtanks = common_scripts\utility::array_removeundefined(level.beachtanks);
  maps\_utility::array_delete(level.beachtanks);
  common_scripts\utility::flag_wait("FLAG_balcony_getup_done");
  common_scripts\utility::flag_set("FLAG_start_trenches");
}

beach_reveal_turn_off_mix_snapshot() {
  wait 7.0;
  level.player clearclienttriggeraudiozone(0.5);
}

player_fall_off_balcony() {
  level.player maps\_chaingun_player::chaingun_turret_disable(level.balcony["turret"]);
  var_0 = 0;

  if(isDefined(level.playerattackerhind) && isalive(level.playerattackerhind)) {
    var_0 = 1;
    level.playerattackerhind delete();
  }

  var_1 = maps\_hud_util::create_client_overlay("black", 0, level.player);
  var_2 = common_scripts\utility::getstruct("bunker_balcony_fall_spot", "targetname");
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("tag_origin");
  var_3.angles = (0, 180, 0);
  level.player playerlinktoabsolute(var_3, "tag_origin");
  level.player enableinvulnerability();
  level.player disableweaponswitch();
  level.player disableweapons();
  level.player allowcrouch(1);
  level.player allowprone(0);
  level.player allowstand(0);
  level.player allowsprint(0);
  var_4 = undefined;

  if(var_0) {
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname("destroy_balcony_hind_strafe");
    thread bunker_final_strafe(var_4);
  } else {
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("destroy_balcony_hind_flyover");
    var_4 vehicle_turnengineoff();
  }

  var_4 waittill("missile_fired", var_5);
  var_5 waittill("death");
  maps\homecoming_util::hud_hide();
  level.player shellshock("homecoming_attack", 60);
  thread maps\homecoming_util::earthquake_loop(0.3);
  var_6 = level.balcony;
  thread balcony_collapse_stumble(var_6);
  var_6["mid"] playrumblelooponentity("steady_rumble");
  var_6["mid"] thread maps\_utility::play_sound_on_entity("scn_homecoming_balcony_crash");
  wait 2;
  common_scripts\utility::exploder("balcony_collapse_smoke");
  level.hesh thread maps\_utility::dialogue_queue("homcom_hsh_holdon");
  wait 0.5;
  var_6["right"] unlink();
  var_6["right"] rotateto(var_6["right"].angles + (-30, 0, 0), 2);
  wait 0.5;
  var_6["mid"] rotateto(var_6["mid"].angles + (-30, 0, 0), 1, 0.5);
  var_3 rotateto(var_3.angles + (105, 0, 0), 1, 0.5);
  wait 0.5;
  var_7 = anglesToForward((0, 180, 0));
  var_3 moveslide((0, 0, 0), 15, var_7 * 100);
  wait 0.4;
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player notify("stop_earthquake_loop");
  var_6["mid"] stoprumble("steady_rumble");
  var_8 = spawnStruct();
  var_8.origin = level.player.origin;
  var_8.angles = level.player.angles;
  var_9 = maps\_utility::spawn_anim_model("player_rig");
  var_9 dontcastshadows();
  var_8 thread maps\_anim::anim_first_frame_solo(var_9, "bunker_balcony_collapse");
  level.player playerlinktoabsolute(var_9, "tag_player");
  var_8 thread maps\_anim::anim_single_solo(var_9, "bunker_balcony_collapse");
  wait 1.55;
  var_1 thread maps\_hud_util::fade_over_time(1, 0);
  level.player thread maps\_utility::play_sound_on_entity("post_balcony_collapse_fall");
  level.player playrumbleonentity("artillery_rumble");
  var_9 stopanimscripted();
  maps\_utility::transient_switch("homecoming_transient_intro_tr", "homecoming_transient_beach_tr");
  common_scripts\utility::flag_set("FLAG_balcony_fall_done");
  thread maps\homecoming_util::player_kill_quad((-2056, 3952, -20), (-1652, 4132, 88), "tower_garage_door_closed");
  thread bunker_balcony_cleanup();
  maps\_utility::stop_exploder("balcony_collapse_smoke");

  if(isDefined(level.beach_ambient_hinds)) {
    level.beach_ambient_hinds = common_scripts\utility::array_removeundefined(level.beach_ambient_hinds);
    maps\_utility::array_delete(level.beach_ambient_hinds);
  }

  level.player unlink();
  var_9 delete();
  var_10 = common_scripts\utility::getstruct(var_2.target, "targetname");
  var_11 = common_scripts\utility::spawn_tag_origin();
  var_11.origin = var_10.origin;
  var_11.angles = var_10.angles;
  level.player unlink();
  level.player setorigin(var_10.origin);
  level.player setplayerangles(var_10.angles);
  level.player allowprone(1);
  level.player allowcrouch(0);
  level.player allowstand(0);
  wait 1.5;
  var_12 = 0;
  level.player playerlinkto(var_11, "tag_origin", 1, var_12, var_12, var_12, var_12);
  level.player setplayerangles(var_10.angles);
  thread hesh_balcony_logic();
  thread bunker_balcony_enemies();
  common_scripts\utility::exploder("balcony_bust_dust");
  var_13 = undefined;
  var_14 = level.player getcurrentweapon();
  var_15 = level.player getweaponslistprimaries();

  foreach(var_17 in var_15) {
    if(var_17 == "cz805bren+acog_sp") {
      var_13 = var_17;
      break;
    } else if(var_14 != var_17)
      var_13 = var_17;
  }

  level.player takeweapon(var_13);
  level.player giveweapon("cz805bren+acog_sp+hc_state_grab");
  level.player switchtoweapon("cz805bren+acog_sp+hc_state_grab");
  level.player enableweapons();
  level.player thread maps\_utility::play_sound_on_entity("post_balcony_collapse_pickup");
  wait 0.1;
  maps\homecoming_util::hud_show();
  getent("post_balcony_collapse_models", "targetname") maps\_utility::show_entity();
  maps\_utility::array_delete(getEntArray("beach_balcony_intact", "targetname"));
  maps\_utility::array_delete(getEntArray("beach_balcony_intact_models", "targetname"));
  level.player shellshock("homecoming_balcony_fall", 4);
  var_1 thread maps\_hud_util::fade_over_time(0, 4);
  var_1 common_scripts\utility::delaycall(4, ::destroy);
  level.player thread maps\homecoming_util::player_heartbeat();
  level.player maps\_utility::notify_delay("stop_player_heartbeat", 0.5);
  var_19 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("balcony_fall_a10");
  var_19 waittill("strafe_start");
  common_scripts\utility::flag_set("FLAG_balcony_strafe");
  var_19 waittill("strafe_done");
  wait 0.2;
  level.player fadeoutshellshock();
  level.player allowsprint(1);
  level.player disableinvulnerability();
  level.player enableweaponswitch();
  level.player unlink();
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  var_11 delete();
  maps\_utility::delaythread(0.1, ::bren_switchout_logic);
  level.player common_scripts\utility::delaycall(0.1, ::allowcrouch, 1);
  level.player common_scripts\utility::delaycall(0.1, ::allowprone, 1);
  common_scripts\utility::flag_set("FLAG_balcony_getup_done");
}

hesh_balcony_logic() {
  level.hesh maps\homecoming_util::ignore_everything();
  level.hesh maps\_utility::walkdist_zero();
  level.hesh maps\_utility::delaythread(2, maps\_utility::dialogue_queue, "homcom_hsh_coughing");
  var_0 = common_scripts\utility::getstruct("hesh_balcony_getup", "targetname");
  var_0 thread maps\_anim::anim_generic(level.hesh, "teargas_recover_2");
  common_scripts\utility::waitframe();
  level.hesh setanimtime(maps\_utility::getanim_generic("teargas_recover_2"), 0.65);
  level.hesh.anim_blend_time_override = 0.5;
  wait 4;
  level.hesh maps\_utility::anim_stopanimscripted();
  var_1 = common_scripts\utility::getstruct("balcony_hesh_wave", "targetname");
  var_1 maps\_anim::anim_reach_solo(level.hesh, "balcony_hesh_wave");
  common_scripts\utility::flag_set("FLAG_hesh_balcony_wave");
  var_1 maps\_anim::anim_single_solo_run(level.hesh, "balcony_hesh_wave");
  level.hesh maps\_utility::set_force_color("r");
  level.hesh maps\_utility::walkdist_reset();
}

balcony_collapse_stumble(var_0) {
  if(!isDefined(level.intro_rangers)) {
    return;
  }
  var_1 = [level.hesh, level.secondarygunner];
  var_1 = common_scripts\utility::array_combine(var_1, level.intro_rangers);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_5 = var_4.balconyent;
    var_5 linkto(var_0[var_5.script_noteworthy]);
    var_4 linkto(var_5);
    var_5 thread maps\_anim::anim_single_solo(var_4, "balcony_stumble");
    var_2[var_2.size] = var_5;
  }

  common_scripts\utility::flag_wait("FLAG_balcony_fall_done");
  level.hesh unlink();
  level.hesh stopanimscripted();
  maps\_utility::array_delete(var_2);
}

bunker_final_strafe(var_0) {
  var_0.perferred_crash_location = maps\homecoming_util::get_helicopter_crash_location("beach_heli_crash_loc_right");
  var_0 maps\_vehicle::godon();
  var_0 vehicle_turnengineoff();
  var_0 thread bunker_final_strafe_hind_missiles();
  common_scripts\utility::waitframe();
  thread maps\_vehicle::gopath(var_0);
  var_1 = common_scripts\utility::getstructarray("bunker_ending_a10_strafe_spots", "targetname");
  var_1[0] thread bunker_final_strafe_think();
  wait 1.5;
  var_2 = ["tag_engine_left", "tag_origin", "tag_engine_right"];

  foreach(var_4 in var_2) {
    var_5 = common_scripts\utility::random(var_1);
    var_6 = vectornormalize(var_0 gettagorigin(var_4) - var_5.origin);
    playFX(common_scripts\utility::getfx("a10_tracer"), var_5.origin, var_6);
    playFXOnTag(common_scripts\utility::getfx("a10_impact"), var_0, var_4);
    wait(randomfloatrange(0.05, 0.1));
  }

  wait 0.5;
  var_0 maps\_vehicle::godoff();
  var_0 maps\_utility::die();
}

bunker_final_strafe_hind_missiles() {
  self setvehweapon("missile_attackheli");
  var_0 = getEntArray("balcony_fall_missile_spots", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::random(["tag_missile_left", "tag_missile_right"]);
    var_4 = self fireweapon(var_3, var_2);
    self notify("missile_fired", var_4);
    wait 0.2;
  }
}

bunker_final_strafe_think() {
  var_0 = self;
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 = var_1.radius;
  var_3 = 1000;
  var_4 = gettime();

  while(gettime() - var_4 < var_3) {
    var_5 = maps\homecoming_util::return_point_in_circle(var_1.origin, var_2);
    var_6 = vectornormalize(var_5 - var_0.origin);
    var_7 = var_5 + var_6 * 999999;
    var_8 = bulletTrace(var_5, var_7, 0);
    var_5 = var_8["position"];
    thread common_scripts\utility::play_sound_in_space("a10p_impact", var_5);
    playFX(common_scripts\utility::getfx("a10_tracer"), var_0.origin, var_6);
    thread bunker_final_strafe_impacts(var_5);
    wait(randomfloatrange(0.05, 0.1));
  }
}

bunker_final_strafe_impacts(var_0) {
  playFX(common_scripts\utility::getfx("a10_impact"), var_0, (0, 0, 1));
  radiusdamage(var_0, 56, 9999, 9999);
}

bren_switchout_logic() {
  for(;;) {
    level.player waittill("weapon_change", var_0);
    var_1 = level.player getweaponslistall();

    foreach(var_3 in var_1) {
      if(var_3 == "cz805bren+acog_sp+hc_state_grab") {
        level.player takeweapon("cz805bren+acog_sp+hc_state_grab");
        level.player giveweapon("cz805bren+acog_sp");

        if(!common_scripts\utility::flag("player_not_doing_strafe"))
          level.player.a10_lastweapon = "cz805bren+acog_sp";

        if(level.player getcurrentweapon() == "none" || isDefined(level.player.using_ammo_cache) || isDefined(var_0) && var_0 == "none") {
          if(isDefined(level.player.using_ammo_cache)) {
            while(isDefined(level.player.using_ammo_cache))
              wait 0.05;

            level.player givemaxammo("cz805bren+acog_sp");
          }

          level.player switchtoweapon("cz805bren+acog_sp");
        }

        return;
      }
    }
  }
}

beach_balcony_collapse_watcher() {
  for(;;) {
    if(level.a10_uses == 1)
      level.a10_mechanic_skip_end_vo = 1;

    if(level.a10_uses == 2) {
      break;
    }

    wait 0.05;
  }

  common_scripts\utility::flag_wait("a10_strafe_complete");
  common_scripts\utility::flag_set("FLAG_start_balcony_collapse");
}

bunker_balcony_setup() {
  var_0 = [];
  var_1 = [];
  var_1["models"] = [];
  var_1["supports"] = [];
  var_2 = undefined;
  var_3 = ["left", "mid", "right"];

  foreach(var_5 in var_3) {
    var_6 = getent("balcony_broken_piece_" + var_5, "targetname");
    var_6.alreadyrotating = 0;
    var_7 = getent("support_" + var_5, "targetname");

    if(isDefined(var_7)) {
      var_7 linkto(var_6);
      var_1["supports"] = common_scripts\utility::array_add(var_1["supports"], var_7);
    }

    if(isDefined(var_6.target)) {
      var_8 = getEntArray(var_6.target, "targetname");

      foreach(var_10 in var_8) {
        var_10 linkto(var_6);
        var_1["models"] = common_scripts\utility::array_add(var_1["models"], var_10);
      }
    }

    if(var_5 == "mid")
      var_2 = var_6;

    var_1[var_5] = var_6;
    var_0[var_0.size] = var_6;
  }

  foreach(var_6 in var_0) {
    if(var_6 != var_2)
      var_6 linkto(var_2);
  }

  var_15 = getent("balcony_player_clip", "targetname");
  var_15 linkto(var_2);
  level.balcony_turret linkto(var_2);
  var_1["turret"] = level.balcony_turret;
  level.balcony = var_1;
  return var_1;
}

bunker_balcony_damage_state(var_0) {
  maps\_utility::array_delete(getEntArray("balcony_intact", "targetname"));
  getent("balcony_broken_back", "targetname") maps\_utility::show_entity();
  var_1 = ["left", "mid", "right"];

  foreach(var_3 in var_1)
  var_0[var_3] maps\_utility::show_entity();

  common_scripts\utility::array_thread(var_0["supports"], maps\_utility::show_entity);
  common_scripts\utility::array_thread(getEntArray("bhouse_roof_damage", "targetname"), maps\_utility::show_entity);
  maps\_utility::array_delete(getEntArray("bhouse_roof_intact", "targetname"));
  common_scripts\utility::array_thread(getEntArray("bhouse_pillar_r_destroyed", "targetname"), maps\_utility::show_entity);
  maps\_utility::array_delete(getEntArray("bhouse_pillar_r_intact", "targetname"));
  common_scripts\utility::array_thread(getEntArray("bhouse_pillar_l_destroyed", "targetname"), maps\_utility::show_entity);
  maps\_utility::array_delete(getEntArray("bhouse_pillar_l_intact", "targetname"));
}

bunker_balcony_enemies() {
  var_0 = common_scripts\utility::getstruct("balcony_fall_enemy_target", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_2 = getEntArray("fall_off_balcony_enemies", "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_5 maps\_utility::spawn_ai();
    var_3 = common_scripts\utility::array_add(var_3, var_6);
    var_6 setthreatbiasgroup("balcony_fall_enemies");
    var_6 allowedstances("stand");
    var_6.health = 10;
    var_6 maps\_utility::disable_long_death();
    var_6.noreload = 1;
    var_6.grenadeawareness = 0;
    var_6.grenadeammo = 0;
    var_6 maps\_utility::set_ignoresuppression(1);
    var_6 setentitytarget(var_1);
    var_7 = undefined;

    if(isDefined(var_5.script_linkto)) {
      var_7 = var_5 maps\homecoming_util::get_linked_struct();
      var_6.deathstruct = var_7;
    }
  }

  common_scripts\utility::flag_wait("FLAG_balcony_strafe");
  var_3 = maps\_utility::array_removedead(var_3);

  foreach(var_12, var_6 in var_3) {
    var_6 maps\_utility::magic_bullet_shield();

    if(isDefined(var_6.deathstruct)) {
      var_10 = var_12 + 1;
      var_11 = common_scripts\utility::random(["artillery_death_1", "artillery_death_2", "artillery_death_3"]);
      var_6.deathstruct maps\_utility::delaythread(0.5, maps\_anim::anim_generic, var_6, "artillery_death_" + var_10);
      var_6 maps\_utility::delaythread(1, maps\homecoming_util::kill_safe);
    }
  }
}

bunker_balcony_cleanup() {
  level.balcony["right"] maps\_utility::hide_entity();
  level.balcony["mid"] maps\_utility::hide_entity();
  level.balcony["left"] maps\_utility::hide_entity();
  maps\_utility::array_delete(level.balcony["models"]);
  level.balcony["turret"].base delete();
  level.balcony["turret"] delete();
  var_0 = getEntArray("bunker_balcony_down", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::show_entity);
}

a10_balcony_strafe_physics() {
  self waittill("strafe_end");
  var_0 = common_scripts\utility::getstruct("balcony_strafe_end", "script_noteworthy");
  physicsexplosionsphere(var_0.origin, 200, 100, 6);
}

beach_wave1_logic() {
  level.availabledrones = 15;
  thread beach_wave1_dialog();
  var_0 = getEntArray("beach_wave1_hovercraft", "script_noteworthy");
  var_1 = maps\_utility::array_spawn(var_0);

  foreach(var_3 in var_1) {
    var_3 vehicle_turnengineoff();
    thread maps\_vehicle::gopath(var_3);
  }

  common_scripts\utility::array_thread(getnodearray("beach_front_nodes", "script_noteworthy"), ::beach_front_nodes_think);
  var_5 = getent("bunker_starting_heli_lander", "script_noteworthy");
  var_6 = var_5 maps\_vehicle::spawn_vehicle_and_gopath();
  var_6.perferred_crash_location = maps\homecoming_util::get_helicopter_crash_location("beach_heli_crash_loc_left");
  var_6 thread maps\homecoming_util::vehicle_allow_player_death(::beach_nh90_damagestate);
  level.startingbunkerheli = var_6;
  thread beach_wave1_enemy_ai(var_6, "bunker_wave1_first_nh90_guys", "wave1_left_heli_goalvolume");
  level.artillery_hit_drones = [];
  level.artillery_hesco_tower_drones = [];
  level.beachfronelinedrones = [];
  var_7 = getEntArray("beach_frontline_drones", "targetname");

  foreach(var_9 in var_7) {
    var_10 = var_9 maps\homecoming_drones::drone_spawn();
    var_10.nodroneweaponsound = 1;
    var_10.muzzleflashoverride = "drone_tracer";

    if(var_9 maps\homecoming_util::noteworthy_check("hesco_tower_drone") || var_9 maps\homecoming_util::parameters_check("hesco_tower_drone"))
      level.artillery_hesco_tower_drones[level.artillery_hesco_tower_drones.size] = var_10;

    if(!isDefined(var_10.magic_bullet_shield))
      var_10 maps\_utility::magic_bullet_shield();

    if(var_9 maps\homecoming_util::noteworthy_check("frontline_artillery_drones"))
      level.artillery_hit_drones = common_scripts\utility::array_add(level.artillery_hit_drones, var_10);
    else if(var_9 maps\homecoming_util::noteworthy_check("beach_javelin_drone")) {} else {
      level.beachfronelinedrones = common_scripts\utility::array_removeundefined(level.beachfronelinedrones);
      level.beachfronelinedrones = common_scripts\utility::array_add(level.beachfronelinedrones, var_10);
    }

    var_11 = var_9 common_scripts\utility::get_linked_ents();

    foreach(var_13 in var_11) {
      if(var_13 maps\homecoming_util::noteworthy_check("respawner"))
        var_10 thread drone_frontline_respawner(var_13);
    }
  }

  thread bunker_trench_drone_runners();
  thread beach_wave1_enemy_drones();
  maps\homecoming_util::waittill_trigger("player_inside_bunker");
  common_scripts\utility::flag_wait("TRIGFLAG_player_at_balcony");
  level notify("stop_intro_flavorburst");
  thread bunker_balcony_bullet_impacts_manager();
  thread beach_bunker_backtrack_blocker();
  common_scripts\utility::flag_set("FLAG_stop_intro_drone_runners");
  maps\homecoming_util::delete_ai_array("intro_drone_runners");
  common_scripts\utility::flag_set("FLAG_wave1_right_helicopter");
  var_5 = getent("bunker_second_heli_lander", "script_noteworthy");
  var_16 = var_5 maps\_vehicle::spawn_vehicle_and_gopath();
  var_16.perferred_crash_location = maps\homecoming_util::get_helicopter_crash_location("beach_heli_crash_loc_right");
  var_16 thread maps\homecoming_util::vehicle_allow_player_death(::beach_nh90_damagestate);
  level.secondbunkerheli = var_16;
  thread beach_wave1_enemy_ai(var_16, "bunker_wave1_second_nh90_guys", "wave1_right_heli_goalvolume");
  var_5 = getent("bunker_third_heli_lander", "script_noteworthy");
  var_17 = var_5 maps\_vehicle::spawn_vehicle_and_gopath();
  var_17.perferred_crash_location = maps\homecoming_util::get_helicopter_crash_location("beach_heli_crash_loc_right");
  var_17 thread maps\homecoming_util::vehicle_allow_player_death(::beach_nh90_damagestate);
  var_17.takeoffdelay = 7;
  level.thirdbunkerheli = var_17;
  common_scripts\utility::waitframe();
  var_16 maps\_utility::ent_flag_wait("unload_complete");
  var_17 maps\_utility::ent_flag_wait("unload_complete");
  thread beach_wave1_artillery_retreat();
  common_scripts\utility::flag_set("FLAG_stop_wave1_loops");

  foreach(var_3 in var_1) {
    var_19 = randomfloatrange(0.5, 1);
    var_3 maps\_utility::delaythread(var_19, maps\_utility::ent_flag_set, "hovercraft_unload_complete");
  }

  wait 7;
  common_scripts\utility::flag_set("FLAG_beach_start_wave_2");
}

beach_nh90_damagestate(var_0) {
  if(isDefined(self.diddamagestate)) {
    return;
  }
  if(self.fakehealth > var_0 / 2) {
    return;
  }
  var_1 = "tag_rotor_fx";
  var_2 = anglesToForward(self gettagangles(var_1));
  playFXOnTag(common_scripts\utility::getfx("nh90_damage_explosion"), self, var_1);
  playFXOnTag(common_scripts\utility::getfx("hind_damage_trail"), self, var_1);
  thread maps\homecoming_util::playloopingfx("hind_damage_trail", 0.05, undefined, var_1, 1);
  thread common_scripts\utility::play_sound_in_space("hind_helicopter_hit", self.origin);
  self.diddamagestate = 1;

  if(!maps\_utility::ent_flag("unload_started"))
    self.fakehealthinvulnerability = 1;

  self waittill("death");
  self notify("stop_looping_fx");
}

beach_bunker_backtrack_blocker() {
  var_0 = getent("player_at_balcony_flagTrig", "targetname");
  common_scripts\utility::flag_wait_all("FLAG_hesh_in_bunker_house", "FLAG_ranger1_in_bunker_house", "FLAG_ranger2_in_bunker_house");

  for(;;) {
    if(level.player istouching(var_0)) {
      var_1 = level.player getplayerangles();
      var_1 = var_1[1];

      if(var_1 < -90 && var_1 >= -180 || var_1 > 90 && var_1 <= 180) {
        break;
      }
    }

    wait 0.05;
  }

  common_scripts\utility::flag_set("FLAG_bunker_balcony_blocker_set");
  common_scripts\utility::exploder("bunker_blocker_collapse");
  var_2 = getEntArray("Bhouse_blocker_destroyed", "targetname");
  common_scripts\utility::array_call(var_2, ::show);
  common_scripts\utility::array_call(var_2, ::solid);
  common_scripts\utility::array_call(var_2, ::disconnectpaths);
  maps\_utility::array_delete(getEntArray("Bhouse_blocker_intact", "targetname"));
}

beach_wave1_enemy_ai(var_0, var_1, var_2) {
  common_scripts\utility::waitframe();
  var_0 maps\_utility::ent_flag_wait("unload_complete");
  var_3 = getEntArray("beach_front_wave1_refillers", "targetname");
  var_2 = maps\homecoming_util::get_goalvolume(var_2);
  var_4 = 0;
  var_5 = var_0.unloadspawners;

  foreach(var_7 in var_5)
  var_4 = var_4 + var_7.script_index;

  while(!common_scripts\utility::flag("FLAG_start_wave1_retreat")) {
    wait(randomintrange(3, 5));
    var_9 = maps\homecoming_util::get_ai_array(var_1);

    if(var_9.size == var_4) {
      continue;
    }
    var_10 = var_4 - var_9.size;

    for(var_11 = 0; var_11 < var_10; var_11++) {
      if(common_scripts\utility::flag("FLAG_start_wave1_retreat")) {
        break;
      }

      var_12 = common_scripts\utility::random(var_3);
      var_13 = var_12 maps\_utility::spawn_ai();

      if(!isDefined(var_13) || !isalive(var_13)) {
        continue;
      }
      var_13 maps\homecoming_util::set_ai_array(var_1);

      if(!isDefined(var_13) || !isalive(var_13)) {
        continue;
      }
      var_13 setgoalvolumeauto(var_2);
      wait(randomfloatrange(0.2, 0.6));
    }
  }
}

beach_wave1_enemy_drones() {
  var_0 = getEntArray("beach_wave1_enemy_drones", "targetname");
  maps\_utility::array_spawn_function(var_0, maps\homecoming_util::hovercraft_drone_default);
  var_1 = ["run_n_gun"];
  var_2 = [0.7, 1.2];
  var_0 thread maps\homecoming_drones::drone_infinite_runners("FLAG_stop_wave1_loops", var_2, var_1, undefined, undefined, 16);
  var_3 = getEntArray("beach_wave1_hovercraft_left_enemy_drones", "targetname");
  maps\_utility::array_spawn_function(var_3, maps\homecoming_util::hovercraft_drone_default);
  var_1 = ["run", "run_n_gun"];
  var_2 = [1, 2];
  var_3 thread maps\homecoming_drones::drone_infinite_runners("FLAG_stop_wave1_loops", var_2, var_1, undefined, undefined, 10);

  while(!level.startingbunkerheli maps\_utility::ent_flag_exist("unload_complete"))
    wait 0.1;

  level.startingbunkerheli maps\_utility::add_wait(maps\_utility::waittill_msg, "death");
  level.startingbunkerheli maps\_utility::add_wait(maps\_utility::ent_flag_wait, "unload_complete");
  maps\_utility::do_wait_any();
  var_4 = getEntArray("beach_wave1_trench_enemy_drones", "targetname");
  var_1 = ["run", "run_n_gun"];
  var_2 = [0.4, 0.8];
  var_5 = [3, 6];
  maps\_utility::array_spawn_function(var_4, maps\homecoming_util::hovercraft_drone_default, 128);
  maps\_utility::array_spawn_function(var_4, maps\homecoming_drones::drone_bloodfx);
  var_4 thread maps\homecoming_drones::drone_infinite_runners("FLAG_stop_wave1_trench_loops", var_2, var_1, undefined, var_5, 10);
}

beach_frontline_abrams() {
  self vehicle_turnengineoff();
  var_0 = self.currentnode;
  var_1 = var_0 common_scripts\utility::get_linked_ents();
  level waittill("beach_tank_destroyed");
  maps\_utility::array_delete(var_1);
  common_scripts\utility::array_thread(self.riders, maps\_utility::stop_magic_bullet_shield);
  self notify("death");
  common_scripts\utility::flag_wait("TRIGFLAG_player_leaving_tower_parking_area");
  self delete();
}

beach_wave1_artillery_retreat() {
  common_scripts\utility::flag_set("FLAG_start_wave1_retreat");
  common_scripts\utility::flag_set("FLAG_stop_wave1_trench_loops");
  thread beach_wave1_artillery_dialog();
  var_0 = common_scripts\utility::getstructarray("bunker_wave1_retreat_spot", "targetname");
  var_1 = maps\homecoming_util::get_ai_array("bunker_wave1_first_nh90_guys");
  var_1 = common_scripts\utility::array_combine(var_1, maps\homecoming_util::get_ai_array("bunker_wave1_second_nh90_guys"));

  foreach(var_3 in var_1) {
    wait(randomfloat(0.8));

    if(!isDefined(var_3) && !isalive(var_3)) {
      continue;
    }
    var_4 = common_scripts\utility::getclosest(var_3.origin, var_0);
    var_3 cleargoalvolume();
    var_3 setgoalpos(var_4.origin);
    var_3.goalradius = 56;
    var_3 thread maps\homecoming_util::waittill_real_goal(var_4, 1);
  }
}

wave1_hovercraft_missile_barrage() {
  thread beach_artillery_balcony_logic();
  thread hovercraft_missile_barrage_player();
  var_0 = undefined;
  var_1 = undefined;
  var_2 = getEntArray("beach_towers_mgs", "script_noteworthy");

  foreach(var_4 in var_2) {
    if(var_4 maps\homecoming_util::parameters_check("hesco"))
      var_0 = var_4;
  }

  thread metal_tower_collapse();
  thread hesco_tower_explosion(var_0);
  thread beach_wave1_artillery_drones();
  common_scripts\utility::flag_set("FLAG_start_artillery_sequence");
  thread hovercraft_missile_barrage("bunker_hovercraft_rocket_g1");
  wait 1.5;
  thread hovercraft_missile_barrage("bunker_hovercraft_rocket_g2");
  common_scripts\utility::flag_wait("bunker_hovercraft_rocket_g2_done");
  thread hovercraft_missile_barrage("bunker_hovercraft_rocket_g3");
  common_scripts\utility::flag_wait_all("bunker_hovercraft_rocket_g1_done", "bunker_hovercraft_rocket_g2_done", "bunker_hovercraft_rocket_g3_done");
  level notify("beach_wave1_artillery_done");
  wait 2;
  common_scripts\utility::flag_set("FLAG_artillery_sequence_done");
}

hovercraft_missile_barrage_player() {
  level waittill("start_player_effects");
  level.player shellshock("homecoming_artillery", 999);
  level waittill("beach_wave1_artillery_done");
  level.player fadeoutshellshock();
}

hovercraft_missile_barrage(var_0) {
  var_1 = common_scripts\utility::getstructarray(var_0, "targetname");
  var_2 = [];

  foreach(var_4 in var_1)
  var_2[var_4.script_index] = var_4;

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_4 = var_2[var_6];

    if(var_4 maps\_utility::script_delay())
      var_4 maps\_utility::script_delay();
    else
      wait 1;

    thread hovercraft_artillery_incoming_missile(var_4, var_0);
  }
}

hovercraft_artillery_incoming_missile(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_3 = vectortoangles(vectornormalize(var_2.origin - var_0.origin));
  var_4 = spawn("script_model", var_0.origin);
  var_4.angles = var_3;
  var_4 setModel("projectile_slamraam_missile");
  playFXOnTag(common_scripts\utility::getfx("hovercraft_missile_trail"), var_4, "tag_fx");
  var_4 thread maps\_utility::play_sound_on_entity("artillery_incoming");
  var_4 moveto(var_2.origin, 1, 0.5, 0);
  var_4 waittill("movedone");
  var_4 delete();

  if(!common_scripts\utility::flag("FLAG_first_hovercraft_missile_hit"))
    common_scripts\utility::flag_set("FLAG_first_hovercraft_missile_hit");

  var_5 = var_2 maps\_utility::get_linked_structs();

  foreach(var_7 in var_5) {
    if(var_7 maps\homecoming_util::parameters_check("sandbag"))
      thread maps\homecoming_util::explosion_throw_sandbags(var_7);
  }

  var_4 thread common_scripts\utility::play_sound_in_space("artillery_explosion", var_2.origin);
  earthquake(0.45, 1.5, var_2.origin, 5000);
  level.player viewkick(20, var_2.origin);
  level.player playrumbleonentity("artillery_rumble");
  thread maps\_utility::set_blur(randomintrange(3, 5), 0.05);
  thread maps\_utility::set_blur(0, 0.25);

  if(isDefined(var_2.script_noteworthy))
    level notify(var_2.script_noteworthy);

  var_2 notify("artillery_hit");
  var_9 = "vfx_hesco_explosion";

  if(isDefined(var_2.script_fxid))
    var_9 = var_2.script_fxid;

  playFX(common_scripts\utility::getfx(var_9), var_2.origin);

  if(var_2 maps\homecoming_util::parameters_check("done"))
    common_scripts\utility::flag_set(var_1 + "_done");
}

hovercraft_artillery_player_weapon() {
  self notify("artillery_hide_weapon");
  self endon("artillery_hide_weapon");
  level.player disableweapons();
  wait 0.75;
  level.player enableweapons();
}

hesco_tower_explosion(var_0) {
  var_1 = getEntArray("artillery_hesco_tower_d", "targetname");
  var_2 = getEntArray("artillery_hesco_tower", "targetname");
  level waittill("artillery_first_hit");
  common_scripts\utility::exploder("hesco_tower_2_exploder");
  common_scripts\utility::array_thread(var_1, maps\_utility::show_entity);
  maps\_utility::array_delete(var_2);
  common_scripts\utility::array_thread(level.artillery_hesco_tower_drones, maps\homecoming_util::delete_safe);
  var_0 delete();
}

metal_tower_collapse() {
  level waittill("beach_metal_tower_destroyed");
  var_0 = getent("artillery_metal_tower_top_nondest", "targetname");
  var_1 = getEntArray("artillery_metal_tower_top_dest", "targetname");
  var_2 = undefined;
  var_3 = [];

  foreach(var_5 in var_1) {
    if(var_5 maps\homecoming_util::parameters_check("window"))
      var_3 = common_scripts\utility::array_add(var_3, var_5);
    else
      var_2 = var_5;

    var_5 show();
  }

  foreach(var_8 in var_3)
  var_8 linkto(var_2);

  var_0 delete();
}

beach_artillery_balcony_logic() {
  common_scripts\utility::flag_wait("FLAG_first_hovercraft_missile_hit");
  thread artillery_disable_player_mg();

  if(common_scripts\utility::flag("player_on_chaingun_turret"))
    common_scripts\utility::flag_waitopen("player_on_chaingun_turret");

  var_0 = level.balcony;
  bunker_balcony_damage_state(var_0);
  var_1 = var_0["mid"];
  thread artillery_balcony_stumble(var_0);
  maps\_utility::delaythread(3, maps\homecoming_util::create_dead_guys, "artillery_dead_bodies", undefined, "FLAG_start_trenches");
  var_2 = getglassarray("balcony_glass");

  foreach(var_4 in var_2) {
    var_5 = randomfloatrange(0, 0.8);
    common_scripts\utility::noself_delaycall(var_5, ::destroyglass, var_4, (0, 500, 0));
    common_scripts\utility::noself_delaycall(var_5 + 1, ::deleteglass, var_4);
  }

  thread maps\homecoming_util::earthquake_loop(0.12);
  common_scripts\utility::exploder("bunker_artillery_raining_dirt");
  var_1 = var_0["mid"];
  var_1 playrumblelooponentity("steady_rumble");

  while(!common_scripts\utility::flag("FLAG_artillery_sequence_done")) {
    var_7 = randomfloatrange(0.4, 0.8);
    var_1 rotateto(var_1.angles + (-2.5, 0, 0), var_7, var_7 / 2, var_7 / 2);
    var_1 waittill("rotatedone");
    var_1 rotateto(var_1.angles + (2.5, 0, 0), var_7, var_7 / 2, var_7 / 2);
    var_1 waittill("rotatedone");
  }

  var_1 stoprumble("steady_rumble");
  maps\_utility::delaythread(0.5, maps\_utility::stop_exploder, "bunker_artillery_raining_dirt");
  level.player notify("stop_earthquake_loop");
}

artillery_balcony_stumble(var_0) {
  artillery_balcony_stumblers_setup(var_0);

  foreach(var_2 in level.balconystumblers) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_3 = var_2.balconyent;
    var_2 linkto(var_3);
    var_3 thread maps\_anim::anim_single_solo(var_2, "balcony_stumble");
    var_2 thread artillery_balcony_stumble_skip();
  }
}

artillery_balcony_stumble_skip() {
  var_0 = randomfloatrange(3, 4);
  wait(var_0);
  self setanimtime(maps\_utility::getanim("balcony_stumble"), 0.53);
}

artillery_balcony_stumblers_setup(var_0) {
  level.secondarygunner.current_follow_path = getnode("secondary_gunner_node", "targetname");
  var_1 = [level.hesh, level.secondarygunner];
  var_1 = common_scripts\utility::array_combine(var_1, level.intro_rangers);

  foreach(var_3 in var_1) {
    var_4 = var_3.current_follow_path;
    var_5 = spawn("script_origin", var_4.origin);
    var_5.angles = var_4.angles;
    var_5.script_noteworthy = var_4.script_noteworthy;
    var_5 linkto(var_0[var_4.script_noteworthy]);
    var_3.balconyent = var_5;
  }

  level.balconystumblers = var_1;
}

artillery_disable_player_mg() {
  var_0 = getent("bunker_turret", "targetname");
  level.player maps\_chaingun_player::chaingun_turret_disable(var_0);
  common_scripts\utility::flag_wait("FLAG_artillery_sequence_done");
  var_0 thread maps\_chaingun_player::chaingun_turret_init(1);
}

beach_wave1_artillery_drones() {
  var_0 = level.artillery_hit_drones;
  var_1 = undefined;
  var_2 = maps\homecoming_util::get_ai_array("inital_beach_guys");

  foreach(var_4 in var_2) {
    if(var_4 maps\homecoming_util::parameters_check("artillery"))
      var_1 = var_4;
  }

  var_6 = ["artillery_death_1", "artillery_death_2", "artillery_death_3"];
  level waittill("beach_artillery_hit_drones");
  var_1 maps\homecoming_util::delete_safe();

  foreach(var_12, var_8 in var_0) {
    var_8 notify("stop_drone_fighting");
    var_8 maps\_utility::anim_stopanimscripted();
    var_8.animname = "generic";
    var_9 = common_scripts\utility::random(var_6);
    var_10 = common_scripts\utility::getstruct(var_8.target, "targetname");
    var_10 thread maps\_anim::anim_generic(var_8, var_9);
    var_11 = getanimlength(maps\_utility::getanim_generic(var_9));
    var_8 common_scripts\utility::delaycall(var_11, ::startragdoll);
    var_8 maps\_utility::delaythread(var_11 + 0.5, maps\homecoming_util::delete_safe);
    wait 0.15;
  }
}

artillery_smoke_grenade() {
  var_0 = common_scripts\utility::getstruct("beach_red_smoke_throwspot", "targetname");
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 = magicgrenade("smoke_grenade_signal", var_0.origin, var_1.origin, 9999);
  var_3 = var_2 common_scripts\utility::spawn_tag_origin();
  var_3 linkto(var_2);
  var_3 thread maps\homecoming_util::playloopingfx("smoke_red_trail", 0.05, undefined, "tag_origin");
  wait 2;
  var_3 notify("stop_looping_fx");
  var_3 unlink();
  var_3.angles = var_1.angles;
  playFXOnTag(common_scripts\utility::getfx("red_signal_smoke"), var_3, "tag_origin");
  var_2 delete();
  common_scripts\utility::flag_set("FLAG_stop_wave1_trench_loops");
  common_scripts\utility::flag_wait("FLAG_artillery_sequence_done");
  var_3 delete();
}

beach_wave1_dialog() {
  common_scripts\utility::flag_wait("FLAG_balcony_gunner_hit");
  level.secondarygunner maps\_utility::dialogue_queue("homcom_smg_welcometotheshit");
  common_scripts\utility::flag_wait("TRIGFLAG_player_at_balcony");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_getonthatgun");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_enemytanksoverlrodwhere");
  maps\_utility::radio_dialogue("homcom_com_fornowyouregoing");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_makeitquickor");
  common_scripts\utility::flag_wait("FLAG_wave1_right_helicopter");
  wait 0.1;

  if(!issentient(level.secondbunkerheli) && isDefined(level.secondbunkerheli) || isalive(level.secondbunkerheli))
    level.secondbunkerheli maps\_utility::ent_flag_wait("landing_gear");

  level.secondarygunner thread maps\_utility::dialogue_queue("homcom_us1_rightsiderightside");

  if(!issentient(level.secondbunkerheli) && isDefined(level.secondbunkerheli) || isalive(level.secondbunkerheli))
    level.secondbunkerheli maps\_utility::ent_flag_wait("unload_complete");

  level.secondarygunner maps\_utility::dialogue_queue("homcom_us1_keepfiringbringit");

  if(!issentient(level.thirdbunkerheli) && isDefined(level.thirdbunkerheli) || isalive(level.thirdbunkerheli))
    level.thirdbunkerheli maps\_utility::ent_flag_wait("landing_gear");

  level.secondarygunner maps\_utility::dialogue_queue("homcom_us1_anotherhelicopterdownthe");

  if(!issentient(level.thirdbunkerheli) && isDefined(level.thirdbunkerheli) || isalive(level.thirdbunkerheli))
    level.thirdbunkerheli maps\_utility::ent_flag_wait("unload_complete");

  level.secondarygunner maps\_utility::dialogue_queue("homcom_us1_keepfiringkeepfiring");
}

beach_wave1_artillery_dialog() {
  wait 4;
  level.secondarygunner maps\_utility::dialogue_queue("homcom_us1_theyreretreating");
  common_scripts\utility::flag_wait("FLAG_beach_start_wave_2");
  wait 1;
  maps\_utility::smart_radio_dialogue("homcom_so3_enemysmoketheyremarking");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_getdownenemyartillery");
  common_scripts\utility::flag_wait("FLAG_start_artillery_sequence");
  wait 0.5;
  level.hesh thread maps\_utility::dialogue_queue("homcom_hsh_holdon");
}

beach_wave2_logic() {
  var_0 = getEntArray("beach_hovercraft_loopers", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, ::beach_hovercraft_looper);
  common_scripts\utility::flag_wait("FLAG_artillery_sequence_done");
  thread maps\_utility::autosave_by_name("bunker_wave2");
  thread beach_wave2_dialogue();
  level.wave2_vehiclewatcher = 0;
  thread beach_battlehinds_start();
  thread beach_wave2_inithinds();
  maps\_utility::delaythread(5, common_scripts\utility::flag_set, "FLAG_wave2_hinds");
  var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("bunker_wave3_drivein_tank");
  common_scripts\utility::array_thread(var_1, ::beach_wave2_tank_setup);
  var_2 = getEntArray("beach_front_attackers", "targetname");
  maps\_utility::array_spawn_function(var_2, maps\homecoming_util::set_ai_array, "beach_front_attackers");
  common_scripts\utility::array_thread(var_2, ::bunker_beach_attackers);
  var_3 = getEntArray("beach_front_runners", "targetname");

  foreach(var_5 in var_3) {
    var_5.drone_lookahead_value = 256;
    var_6 = 0;

    if(isDefined(var_5.script_wait))
      var_6 = var_5.script_wait;

    var_5 maps\_utility::delaythread(var_6, maps\homecoming_drones::beach_path_drones);
  }

  var_8 = common_scripts\utility::getstructarray("hovercraft_drone_fightspots_reference", "targetname");

  foreach(var_10 in var_8) {
    var_11 = var_10 maps\_utility::get_linked_structs();
    common_scripts\utility::array_thread(var_11, maps\homecoming_drones::hovercraft_drone_fightspots);
  }

  var_13 = common_scripts\utility::getstructarray("fake_beach_javelins", "targetname");

  foreach(var_15 in var_13) {
    var_16 = undefined;

    if(isDefined(var_15.target))
      var_16 = common_scripts\utility::getstructarray(var_15.target, "targetname");

    if(var_15 maps\homecoming_util::parameters_check("target_tanks"))
      var_15.javelin_smarttargeting = 1;

    var_15 thread maps\homecoming_drones::drone_fire_fake_javelin_loop(var_16);
  }

  common_scripts\utility::flag_wait("FLAG_a10_return_flybys");
  thread beach_a10_return_flybys();
  maps\_utility::delaythread(5, maps\homecoming_util::a10_vista_strafe_group, "vista_pier_a10s");
  maps\_utility::delaythread(5, maps\homecoming_util::a10_vista_strafe_group, "vista_ship_a10s");
  common_scripts\utility::flag_wait("FLAG_enable_bunker_a10_mechanic");
  thread maps\homecoming_a10::a10_strafe_mechanic("bunker_player_a10_strafe_1");
  thread beach_balcony_collapse_watcher();
}

beach_wave2_dialogue() {
  common_scripts\utility::flag_wait("FLAG_playerhind_targeting");
  wait 1;
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_commandthisisraptor");
  maps\_utility::smart_radio_dialogue("homcom_hqr_rogerraptor21air");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_werelosingthebeach");
  common_scripts\utility::flag_set("FLAG_allow_hind_to_target_player");
  wait(randomintrange(10, 15));
  common_scripts\utility::flag_set("FLAG_a10_return_flybys");
  wait 2;
  maps\_utility::smart_radio_dialogue("homcom_hqr_a10dronesupportis");
  common_scripts\utility::flag_set("FLAG_enable_bunker_a10_mechanic");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_thedronesareready");
}

beach_a10_return_flybys() {
  var_0 = getEntArray("bunker_a10_return_flybys", "targetname");

  foreach(var_2 in var_0) {
    var_3 = 0;

    if(isDefined(var_2.script_wait))
      var_3 = var_2.script_wait;

    var_2 maps\_utility::delaythread(var_3, maps\_vehicle::spawn_vehicle_and_gopath);
  }
}

beach_wave2_vehicle_watcher() {
  if(!isDefined(level.wave2_vehiclewatcher)) {
    return;
  }
  self waittill("death", var_0);

  if(isDefined(var_0) && isplayer(var_0))
    level.wave2_vehiclewatcher++;

  if(level.wave2_vehiclewatcher == 1)
    common_scripts\utility::flag_set("FLAG_beach_start_wave_3");
}

beach_wave2_tank_setup() {
  var_0 = self;

  if(!isDefined(level.beachtanks))
    level.beachtanks = [];

  level.beachtanks = common_scripts\utility::array_add(level.beachtanks, var_0);
  var_0.firetime[0] = 3;
  var_0.firetime[1] = 8;
  level.javelintargets = common_scripts\utility::array_add(level.javelintargets, var_0);
  var_0 thread maps\homecoming_a10::set_a10_strafe_target_vehicle();
  var_0 thread maps\homecoming_util::vehicle_allow_player_death();
  target_set(var_0, (0, 0, 50));
  target_hidefromplayer(var_0, level.player);
}

beach_wave2_inithinds() {
  level endon("FLAG_start_balcony_collapse");
  level.playerhind_attackspots = [];
  level.playerhind_attackspots["default"] = [];
  var_0 = common_scripts\utility::getstructarray("beach_wave2_hind_targets", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy)) {
      var_3 = var_2.script_noteworthy;

      if(!isDefined(level.playerhind_attackspots[var_3]))
        level.playerhind_attackspots[var_3] = [];

      level.playerhind_attackspots[var_3] = common_scripts\utility::array_add(level.playerhind_attackspots[var_3], var_2);
      continue;
    }

    level.playerhind_attackspots["default"] = common_scripts\utility::array_add(level.playerhind_attackspots["default"], var_2);
  }

  var_5 = "bunker_player_attacker_hind";

  for(;;) {
    beach_wave2_playerhind_init(var_5);
    var_5 = "bunker_player_attacker_hind_respawner";
    wait(randomintrange(8, 15));
  }
}

beach_wave2_playerhind_init(var_0) {
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0);
  level.playerattackerhind = var_1;
  level.strafetargetvehicles = common_scripts\utility::array_add(level.strafetargetvehicles, var_1);
  var_1 thread maps\homecoming_util::vehicle_allow_player_death(undefined, ::beach_wave2_playerhind_deathfunc);
  var_1.currentattackgroup = "undefined";
  var_1 waittill("start_targeting_player");
  common_scripts\utility::flag_set("FLAG_playerhind_targeting");
  var_1 thread beach_playerhind_attack_logic();
  var_1 thread beach_hind_balcony_logic();
  var_1 thread playerhind_kill_player_watcher();
  var_1 waittill("reached_dynamic_path_end");
  var_1 thread beach_wave2_playerhind_path_logic();
  var_1 waittill("death");
  common_scripts\utility::flag_set("FLAG_beach_start_wave_3");
}

beach_wave2_playerhind_path_logic() {
  self endon("death");
  self endon("stop_pathing_logic");
  var_0 = self.currentnode;
  var_1 = var_0 maps\_utility::get_linked_structs();
  var_2 = [];
  var_2["default"] = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_parameters)) {
      var_5 = var_4.script_parameters;

      if(!isDefined(var_2[var_5]))
        var_2[var_5] = [];

      var_2[var_5] = common_scripts\utility::array_add(var_2[var_5], var_4);
      continue;
    }

    var_2["default"] = common_scripts\utility::array_add(var_2["default"], var_4);
  }

  for(;;) {
    thread beach_wave2_playerhind_pathing(var_2["default"]);
    var_7 = common_scripts\utility::waittill_notify_or_timeout_return("evading_missile", randomintrange(10, 15));

    if(!common_scripts\utility::flag("player_not_doing_strafe")) {
      continue;
    }
    common_scripts\utility::flag_set("FLAG_hind_is_targeting_player");
    thread beach_wave2_playerhind_strafe(var_2["strafe"]);

    if(isDefined(level.balconystumblers))
      common_scripts\utility::array_thread(level.balconystumblers, ::balcony_allies_playerhind_logic, self);

    thread playerhind_target_player_dialogue();
    thread playerhind_player_hind_hint();
    common_scripts\utility::flag_waitopen("FLAG_hind_is_targeting_player");
    self notify("stop_firing");
    self.currentattackgroup = "undefined";
    self.script_burst_min = undefined;
    self.script_burst_max = undefined;
  }
}

beach_wave2_playerhind_pathing(var_0, var_1) {
  self endon("death");
  self notify("new_tower_path");
  self endon("new_tower_path");
  self endon("stop_pathing_logic");
  self vehicle_setspeed(40, 40, 10);
  self setneargoalnotifydist(64);
  var_2 = "default";

  if(isDefined(var_1))
    var_2 = var_1;

  var_3 = var_0;
  var_4 = common_scripts\utility::getclosest(self.origin, var_3);

  for(;;) {
    self notify("new_goal");
    self vehicle_helisetai(var_4.origin, undefined, undefined, undefined, var_4.script_goalyaw, var_4.angles, var_4.angles[1], 0, 0, 0, 0, 0, 1);
    self waittill("near_goal");

    if(var_4 maps\homecoming_util::noteworthy_check("missiles_fire"))
      thread maps\homecoming_util::heli_fire_missiles(undefined, 1, "tag_missile_left", 0, "missile_attackheli_no_explode");

    var_5 = var_2;

    if(isDefined(var_4.script_parameters))
      var_5 = var_4.script_parameters;

    if(var_5 != self.currentattackgroup) {
      self.currentattackgroup = var_5;
      var_6 = undefined;

      if(var_5 == "strafe") {
        self.targetingplayer = 1;
        var_6 = level.player;
      } else {
        self.targetingplayer = 0;
        var_6 = level.playerhind_attackspots[var_5];
      }

      self notify("new_targets", var_6);
    }

    self waittill("near_goal");
    self vehicle_setspeed(15, 5, 5);
    wait(randomfloat(2));
    var_3 = common_scripts\utility::array_remove(var_0, var_4);
    var_4 = var_3[randomint(var_3.size)];
  }
}

beach_wave2_playerhind_strafe(var_0) {
  self endon("death");
  self notify("new_tower_path");
  self notify("stop_firing");
  self notify("fire_at_target");
  var_1 = common_scripts\utility::getclosest(self.origin, var_0);
  thread beach_playerhind_strafe_attack(self.targetent, var_1);
  self vehicle_helisetai(var_1.origin, 40, 40, 10, var_1.script_goalyaw, var_1.angles, var_1.angles[1], 0, 0, 0, 0, 0, 1);
  self waittill("near_goal");
  var_2 = common_scripts\utility::getstruct("beachhind_strafe_mid", "targetname");
  var_3 = common_scripts\utility::getstruct(var_1.script_linkto, "script_linkname");
  var_4 = [var_2, var_3, var_2, var_1];
  var_5 = 22;

  foreach(var_7 in var_4) {
    var_8 = 1;

    if(var_7 == var_2)
      var_8 = 0;

    self vehicle_helisetai(var_7.origin, var_5, var_5 * 2.5, var_5 * 2.5, 0, 1, var_7.angles[1], 0, 0, 0, 0, 0, 0);
    maps\_utility::add_wait(maps\_utility::waittill_msg, "near_goal");
    level maps\_utility::add_wait(common_scripts\utility::flag_wait, "player_inside_a10");
    maps\_utility::do_wait_any();

    if(common_scripts\utility::flag("player_inside_a10")) {
      break;
    }
  }

  if(!common_scripts\utility::flag("player_inside_a10")) {
    self vehicle_helisetai(var_1.origin, 40, 40, 10, var_1.script_goalyaw, var_1.angles, var_1.angles[1], 0, 0, 0, 0, 0, 1);
    wait 1;
  }

  common_scripts\utility::flag_clear("FLAG_hind_is_targeting_player");
}

beach_playerhind_strafe_attack(var_0, var_1) {
  self endon("death");
  var_2 = common_scripts\utility::getstruct(var_1.target, "targetname");
  var_0.origin = var_2.origin;
  var_3 = var_2 maps\homecoming_util::get_linked_struct();
  self setturrettargetent(var_0);
  self waittill("near_goal");
  var_4 = spawn("script_origin", var_2.origin);
  thread beach_playerhind_strafe_turret(var_0, var_4);
  var_5 = 50;
  var_6 = undefined;
  var_7 = 1;
  var_8 = self.origin[1];

  while(common_scripts\utility::flag("FLAG_hind_is_targeting_player")) {
    if(var_7)
      var_6 = var_8;

    wait 0.05;
    var_8 = self.origin[1];
    var_9 = var_8 - var_6;
    var_10 = var_9;

    if(var_9 < 0)
      var_10 = var_10 * -1;

    if(var_10 < var_5) {
      var_7 = 0;
      continue;
    }

    var_7 = 1;
    var_11 = var_4.origin + (0, var_9, 0);
    var_12 = spawnStruct();
    var_12.origin = var_11;

    if(maps\homecoming_util::postion_dot_check(var_2, var_12) == "behind") {
      continue;
    }
    if(maps\homecoming_util::postion_dot_check(var_3, var_12) == "behind") {
      continue;
    }
    var_4.origin = var_11;
  }

  var_4 delete();
}

beach_playerhind_strafe_turret(var_0, var_1) {
  self endon("death");
  self.script_burst_min = 10000;
  self.script_burst_max = 10001;
  thread maps\homecoming_util::heli_fire_turret(var_0);
  var_2 = squared(200);
  var_3 = 0;

  while(common_scripts\utility::flag("FLAG_hind_is_targeting_player")) {
    var_4 = level.player getstance();

    switch (var_4) {
      case "prone":
        var_3 = randomintrange(70, 100);
        break;
      case "crouch":
        var_3 = randomintrange(70, 100);
        break;
      case "stand":
        var_3 = randomintrange(5, 15);
        break;
    }

    var_5 = var_1.origin;

    if(distance2dsquared(level.player.origin, var_1.origin) < var_2)
      var_5 = level.player.origin + (0, 0, 25);

    var_6 = maps\homecoming_util::return_point_in_circle(var_5, 70);
    var_6 = var_6 + (0, 0, var_3);
    var_0.origin = var_6;
    wait 0.08;
  }
}

beach_playerhind_attack_logic(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1.targetingplayer = 0;
  var_2 = spawn("script_origin", (0, 0, 0));
  var_2 thread common_scripts\utility::delete_on_death(var_2);
  var_1.targetent = var_2;
  var_3 = "default";

  if(isDefined(var_0))
    var_3 = var_0;

  var_4 = level.playerhind_attackspots[var_3];

  for(;;) {
    var_1 thread maps\homecoming_util::heli_fire_turret(var_2);
    var_1 thread beach_playerhind_attack_target(var_4, var_2);
    var_1 waittill("new_targets", var_4);
  }
}

beach_playerhind_attack_target_player(var_0) {
  self notify("fire_at_target");
  self endon("fire_at_target");
  self endon("death");
  var_1 = undefined;
  var_2 = maps\_utility::getdifficulty();

  switch (var_2) {
    case "easy":
      var_1 = 325;
      break;
    case "medium":
      var_1 = 300;
      break;
    case "hard":
      var_1 = 275;
      break;
    case "fu":
      var_1 = 275;
      break;
  }

  var_3 = 80;
  self.helifirecheap = undefined;
  self setlookatent(level.player);
  var_4 = getent("player_at_balcony_flagTrig", "targetname");

  for(;;) {
    var_5 = level.player.origin;
    var_6 = level.player getstance();

    if(var_6 == "stand" || !level.player istouching(var_4))
      var_3 = randomintrange(25, 40);
    else
      var_3 = randomintrange(100, 150);

    var_7 = randomfloatrange(0.2, 0.4) * 1000;
    var_8 = gettime();

    while(gettime() - var_8 < var_7) {
      var_9 = maps\homecoming_util::return_point_in_circle(var_5, var_1);
      var_9 = (var_9[0], var_9[1], var_5[2] + var_3);
      var_0.origin = var_9;
      wait 0.1;
    }
  }
}

beach_playerhind_attack_target(var_0, var_1) {
  self notify("fire_at_target");
  self endon("fire_at_target");
  self endon("death");
  self clearlookatent();

  for(;;) {
    var_2 = common_scripts\utility::random(var_0);
    var_3 = undefined;

    if(isDefined(var_2.height))
      var_3 = var_2.height;

    var_4 = var_2.radius;
    var_5 = randomintrange(5, 10) * 1000;
    var_6 = gettime();

    while(gettime() - var_6 < var_5) {
      var_7 = maps\homecoming_util::return_point_in_circle(var_2.origin, 128, var_3);
      var_1.origin = var_7;
      wait 0.4;
    }

    if(common_scripts\utility::cointoss())
      wait(randomfloatrange(0.4, 0.8));
  }
}

beach_hind_balcony_logic() {
  var_0 = self;
  var_0 endon("death");

  foreach(var_2 in level.balconystumblers)
  var_2.alreadystumbling = 0;

  var_4 = [];
  var_5 = getEntArray("balcony_playercheck_triggers", "targetname");

  foreach(var_7 in var_5)
  var_4[var_7.script_noteworthy] = var_7;

  var_9 = getEntArray("hind_balcony_missile_targets", "targetname");
  var_10 = var_9;

  for(;;) {
    wait(randomintrange(6, 9));

    if(var_0.targetingplayer == 1) {
      continue;
    }
    if(common_scripts\utility::flag("FLAG_hind_is_targeting_player")) {
      continue;
    }
    var_11 = undefined;

    while(!isDefined(var_11)) {
      var_12 = common_scripts\utility::random(var_10);

      if(!level.player istouching(var_4[var_12.script_noteworthy]))
        var_11 = var_12;

      wait 0.1;
    }

    var_0 beach_hind_balcony_missile_logic(var_11);
    var_10 = common_scripts\utility::array_remove(var_9, var_11);
  }
}

beach_hind_balcony_missile_logic(var_0) {
  var_1 = var_0.script_noteworthy;
  var_2 = squared(250);
  var_3 = squared(1000);
  var_4 = 0;

  foreach(var_6 in level.balconystumblers) {
    var_7 = var_6.balconyent;

    if(!isDefined(var_7)) {
      continue;
    }
    if(var_7.script_noteworthy == var_1) {
      if(var_6.alreadystumbling == 1) {
        return;
      }
      var_8 = common_scripts\utility::random(["tag_missile_left", "tag_missile_right"]);
      var_9 = maps\homecoming_util::heli_fire_missiles(var_0, 1, var_8, 0, "missile_attackheli_no_explode");
      var_9 waittill("death");
      var_10 = 0;

      if(isDefined(var_9)) {
        playFX(common_scripts\utility::getfx("heli_missile_explosion"), var_9.origin);
        var_11 = distancesquared(var_9.origin, level.player.origin);

        if(var_11 <= var_2)
          level.player shellshock("default", 2);

        var_11 = distancesquared(var_9.origin, var_7.origin);

        if(var_11 <= var_3)
          var_10 = 1;
      }

      if(var_10)
        var_6 thread beach_tank_balcony_stumble(var_7);
    }
  }
}

playerhind_destory_balcony_mg() {
  var_0 = getEntArray("playerhind_mg_missile_spots", "targetname");
  var_0 = maps\_utility::array_index_by_script_index(var_0);
  common_scripts\utility::flag_wait("FLAG_playerhind_destroy_mg");
  var_1 = 1;
  var_2 = "tag_missile_left";
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_6 = maps\homecoming_util::heli_fire_missiles(var_5, 1, var_2, 0, "missile_attackheli_no_explode");
    var_6 thread playerhind_destory_balcony_mg_missiles(var_1);
    var_1 = 0;
    var_2 = "tag_missile_right";
    wait 0.2;
  }
}

playerhind_destory_balcony_mg_missiles(var_0) {
  var_1 = self;
  var_2 = squared(250);
  var_3 = squared(1000);
  var_1 waittill("death");
  playFX(common_scripts\utility::getfx("heli_missile_explosion"), var_1.origin);
  var_4 = distancesquared(var_1.origin, level.player.origin);

  if(var_4 <= var_2)
    level.player shellshock("default", 2);

  if(var_0) {
    var_5 = level.balcony_turret;
    var_5.destroyed = 1;
    level.player maps\_chaingun_player::chaingun_turret_disable(var_5);
    playFX(common_scripts\utility::getfx("vfx_smoking_gun"), var_5 gettagorigin("j_mg"), anglestoup(var_5 gettagangles("j_mg")));
    var_5 thread maps\homecoming_util::playloopingfx("mg_sparks", 2.5, undefined, "j_mg", 1);
    var_5 setdefaultdroppitch(20);
  }
}

playerhind_target_player_dialogue() {
  var_0 = [];

  if(!isDefined(self.laststrafeline))
    self.laststrafeline = "";

  if(!isDefined(self.firststrafe) || self.laststrafeline == "homcom_hsh_lookslikewereon") {
    self.firststrafe = 1;
    var_0 = ["homcom_hsh_thoseenemytankshave", "homcom_hsh_tanksaremovingup"];
  } else
    var_0 = ["homcom_hsh_lookslikewereon"];

  var_1 = common_scripts\utility::random(var_0);
  self.laststrafeline = var_1;
  level.hesh thread maps\_utility::dialogue_queue(var_1);
}

balcony_allies_playerhind_logic(var_0) {
  self endon("death");
  var_1 = level.balconystumblers;
  var_2 = self.balconyent;
  var_2 thread maps\_anim::anim_generic_loop(self, "coverstand_hide_idle");
  var_0 maps\_utility::add_wait(maps\_utility::waittill_msg, "death");
  maps\_utility::add_wait(common_scripts\utility::flag_waitopen, "FLAG_hind_is_targeting_player");
  maps\_utility::do_wait_any();
  maps\_utility::anim_stopanimscripted();
  var_2 notify("stop_loop");
}

playerhind_player_hind_hint() {
  var_0 = undefined;
  var_1 = maps\_utility::getdifficulty();

  switch (var_1) {
    case "easy":
      var_0 = 0;
      break;
    case "medium":
      var_0 = 0;
      break;
    case "hard":
      var_0 = 1;
      break;
    case "fu":
      var_0 = 1;
      break;
  }

  var_2 = getdvarint("balcony_hind_killed_player");

  if(var_2 < var_0) {
    return;
  }
  var_3 = getkeybinding("+stance");
  var_4 = getkeybinding("toggleprone");
  var_5 = getkeybinding("+prone");

  if(isDefined(var_3) && var_3["count"] > 0)
    maps\_utility::display_hint("hind_prone_hint_hold");
  else if(isDefined(var_4) && var_4["count"] > 0)
    maps\_utility::display_hint("hind_prone_hint_toggle");
  else if(isDefined(var_5) && var_5["count"] > 0)
    maps\_utility::display_hint("hind_prone_hint");
}

playerhind_kill_player_watcher() {
  self endon("death");
  level.player waittill("death", var_0);

  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 != self) {
    return;
  }
  if(!common_scripts\utility::flag("FLAG_hind_is_targeting_player")) {
    return;
  }
  var_1 = getdvarint("balcony_hind_killed_player");
  var_1++;
  setdvar("balcony_hind_killed_player", var_1);
}

beach_tank_balcony_stumble(var_0) {
  if(self.alreadystumbling == 1) {
    return;
  }
  self.alreadystumbling = 1;
  var_1 = randomint(4);
  var_2 = "balcony_stumble_short_" + var_1;
  var_0 thread maps\_anim::anim_generic(self, var_2);
  var_3 = getanimlength(maps\_utility::getanim_generic(var_2));
  thread beach_tank_balcony_stumbler_notetrack(var_3);
  wait(var_3 - 0.2);
  self stopanimscripted();
  self.alreadystumbling = 0;
}

beach_tank_balcony_stumbler_notetrack(var_0) {
  self.dontdonotetracks = 1;
  self notify("stop_sequencing_notetracks");
  wait(var_0);
  self.dontdonotetracks = 0;
}

hind_projectile_damagestate(var_0) {
  if(isDefined(self.diddamagestate)) {
    return;
  }
  if(self.fakehealth > var_0 / 2) {
    return;
  }
  thread hind_damagestate_painfx();
  self.diddamagestate = 1;
  self.doingdamagestate = 1;
  var_1 = self.origin;
  var_2 = randomint(360);
  var_3 = anglesToForward((0, var_2, 0)) * 100;
  var_3 = var_3 + var_1 + (0, 0, randomfloatrange(-175, -125));
  self setneargoalnotifydist(20);
  self vehicle_setspeed(60, 60, 40);
  self setvehgoalpos(var_3, 1);
  common_scripts\utility::waittill_any("near_goal", "goal");
  self vehicle_setspeed(15, 5, 5);
  wait 0.5;
  self.doingdamagestate = undefined;
}

hind_damagestate_painfx() {
  self endon("death");
  var_0 = "tag_engine_left";
  var_1 = anglesToForward(self gettagangles(var_0));
  playFX(common_scripts\utility::getfx("hind_damage_explosion"), self gettagorigin(var_0), var_1);
  thread common_scripts\utility::play_sound_in_space("hind_helicopter_hit", self.origin);

  while(isDefined(self) && isalive(self)) {
    var_2 = self gettagangles(var_0);
    var_1 = anglesToForward(var_2);
    playFX(common_scripts\utility::getfx("hind_damage_trail"), self gettagorigin(var_0), var_1);
    wait(randomfloatrange(0.05, 0.2));
  }
}

beach_wave2_playerhind_deathfunc(var_0) {
  if(var_0 == "a10_30mm_player_homecoming") {
    maps\homecoming_util::heli_enable_rocketdeath(1);
    maps\_vehicle::godoff();
    self notify("death", level.player, undefined, var_0);
    return 1;
  } else {
    maps\_vehicle::godoff();
    self.dontallowexplode = undefined;
    self.forceexploding = 1;
    self notify("death", level.player, undefined, var_0);
  }
}

heli_laser_guided_missile_notify() {
  self endon("death");

  for(;;) {
    level.player waittill("guided_missile_fired", var_0);
    self notify("missile_targeted", var_0);
  }
}

beach_wave3_tank_setup() {
  var_0 = self;
  var_0.firetime[0] = 3;
  var_0.firetime[1] = 8;
  level.javelintargets = common_scripts\utility::array_add(level.javelintargets, var_0);
  var_0 thread maps\homecoming_a10::set_a10_strafe_target_vehicle();
  var_0 thread maps\homecoming_util::vehicle_allow_player_death();
  target_set(var_0, (0, 0, 50));
  target_hidefromplayer(var_0, level.player);
}

beach_tank_balcony_logic(var_0) {
  var_1 = var_0.script_noteworthy;
  var_2 = level.balcony[var_1];

  if(var_2.alreadyrotating == 1) {
    return;
  }
  var_2.alreadyrotating = 1;

  foreach(var_4 in level.balconystumblers) {
    var_5 = var_4.balconyent;

    if(!isDefined(var_5)) {
      continue;
    }
    if(var_5.script_noteworthy == var_1)
      var_4 thread beach_tank_balcony_stumble(var_5);
  }

  for(var_7 = 3; var_7 != 0; var_7--) {
    var_8 = randomfloatrange(0.4, 0.8);
    common_scripts\utility::exploder("bust_" + var_1);
    var_2 rotateto(var_2.rotateangles, var_8, var_8 / 2, var_8 / 2);
    var_2 waittill("rotatedone");
    var_8 = randomfloatrange(0.4, 0.8);
    common_scripts\utility::exploder("bust_" + var_1);
    var_2 rotateto(var_2.originalangles, var_8, var_8 / 2, var_8 / 2);
    var_2 waittill("rotatedone");
  }

  var_2.alreadyrotating = 0;
}

beach_wave1_ai(var_0) {
  level endon("FLAG_stop_wave1_loops");
  var_1 = maps\_utility::array_spawn(getEntArray(var_0, "targetname"));

  if(var_1[0].team == "axis")
    var_2 = ::beach_enemy_default;
  else
    var_2 = ::beach_ally_default;

  common_scripts\utility::array_thread(var_1, var_2);
  var_3 = getEntArray(var_0 + "_respawners", "targetname");
  maps\_utility::array_spawn_function(var_3, var_2);
  var_4 = var_1.size;

  for(;;) {
    wait(randomfloatrange(0.5, 1.5));
    var_1 = maps\homecoming_util::get_ai_array(var_0);
    var_5 = var_4 - var_1.size;

    for(var_6 = 0; var_6 < var_5; var_6++) {
      var_7 = var_3[randomint(var_3.size)];
      var_8 = var_7 maps\_utility::spawn_ai();
      wait(randomfloatrange(0.4, 0.8));
    }
  }
}

bunker_balcony_bullet_impacts_manager() {
  thread bunker_balcony_bullet_impacts();
  common_scripts\utility::flag_wait("FLAG_stop_wave1_loops");
  level notify("stop_balcony_bullet_impacts");
  common_scripts\utility::flag_wait("FLAG_beach_start_wave_2");
  thread bunker_balcony_bullet_impacts();
  common_scripts\utility::flag_wait("FLAG_balcony_fall_done");
  level notify("stop_balcony_bullet_impacts");
}

bunker_balcony_bullet_impacts() {
  level endon("stop_balcony_bullet_impacts");
  var_0 = common_scripts\utility::getstructarray("bunker_balcony_impacts", "targetname");
  var_1 = anglesToForward((0, 180, 0));
  var_2 = ["balcony_impact_sand_1", "balcony_impact_sand_1"];

  foreach(var_4 in var_0)
  var_4 childthread bunker_balcony_bullet_impacts_think(var_1, var_2);
}

bunker_balcony_bullet_impacts_think(var_0, var_1) {
  var_2 = self;
  var_3 = cos(65);

  for(;;) {
    wait(randomfloatrange(0.2, 0.8));

    if(!maps\_utility::within_fov_2d(level.player getEye(), level.player getplayerangles(), var_2.origin, var_3)) {
      continue;
    }
    var_4 = int(var_2.height);
    var_5 = var_2.radius;
    var_6 = var_2.origin[0];
    var_7 = var_2.origin[1] + randomintrange(var_5 * -1, var_5);
    var_8 = var_2.origin[2] + randomintrange(0, var_4);
    var_9 = (var_6, var_7, var_8);
    playFX(common_scripts\utility::getfx(common_scripts\utility::random(var_1)), var_9, var_0);
  }
}

beach_ally_default() {
  self endon("death");
  maps\_utility::delaythread(randomintrange(8, 16), maps\_utility::die);
  var_0 = getEntArray("beach_wave1_allies_targets", "targetname");

  for(;;) {
    var_1 = var_0[randomint(var_0.size)];
    self setentitytarget(var_1);
    wait(randomfloatrange(4, 8));
  }
}

drone_frontline_respawner(var_0) {
  level endon("FLAG_start_balcony_collapse");
  common_scripts\utility::flag_wait("FLAG_artillery_sequence_done");
  wait(randomfloatrange(0, 5));

  if(isDefined(self)) {
    self.customdeathanim = 1;
    var_1 = randomfloatrange(5, 20);
    maps\_utility::delaythread(var_1, maps\homecoming_drones::drone_death_custom);
    common_scripts\utility::waittill_any("death");
  }

  var_2 = undefined;

  for(;;) {
    var_3 = undefined;

    while(!isDefined(var_3)) {
      var_3 = var_0 maps\homecoming_drones::drone_spawn();

      if(!isDefined(var_3))
        wait 0.5;
    }

    var_2 = var_3;
    var_3 maps\_utility::magic_bullet_shield();
    level.beachfronelinedrones = common_scripts\utility::array_removeundefined(level.beachfronelinedrones);
    level.beachfronelinedrones = common_scripts\utility::array_add(level.beachfronelinedrones, var_3);
    var_3 maps\homecoming_drones::drone_animate_on_path();
    var_3.customdeathanim = 1;
    var_3.nodroneweaponsound = 1;
    var_1 = randomfloatrange(5, 15);
    var_3 maps\_utility::delaythread(var_1, maps\homecoming_drones::drone_death_custom);
    var_3 common_scripts\utility::waittill_any("death");
    wait(randomfloatrange(1, 5));
  }

  if(isDefined(var_2))
    var_2 maps\homecoming_util::delete_safe();
}

beach_hovercraft_looper() {
  var_0 = self;
  level endon("hovercraft_loopers_stop");

  if(!isDefined(level.hovercraftloopers))
    level.hovercraftloopers = [];

  var_1 = var_0 common_scripts\utility::get_linked_ents();
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(var_4 maps\homecoming_util::parameters_check("starter")) {
      var_2 = var_4;
      break;
    }
  }

  if(isDefined(var_2)) {
    var_6 = var_2 maps\_vehicle::spawn_vehicle_and_gopath();
    var_6.hovercraftmissiletimeout = 4;
  } else
    var_6 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();

  for(;;) {
    level.hovercraftloopers = common_scripts\utility::array_removeundefined(level.hovercraftloopers);
    level.hovercraftloopers = common_scripts\utility::array_add(level.hovercraftloopers, var_6);
    var_6 vehicle_turnengineoff();
    var_6 waittill("hovercraft_spawn");
    var_6 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();
  }
}

bunker_enemy_cover_drones(var_0, var_1) {
  if(isDefined(var_0))
    level endon(var_0);

  for(;;) {
    var_2 = maps\homecoming_drones::drones_request(1);

    if(var_2) {
      var_3 = maps\_utility::spawn_ai();

      if(isDefined(var_1))
        var_3 maps\homecoming_util::set_ai_array(var_1);

      var_3 maps\homecoming_drones::drones_death_watcher();
    }

    wait(randomintrange(2, 3));
  }
}

bunker_beach_attackers() {
  level endon("beach_attacker_logic_off");
  var_0 = common_scripts\utility::getstruct(self.target, "targetname");

  if(!isDefined(var_0.aiamount))
    var_0.aiamount = 0;

  var_0.aiamount = var_0.aiamount + self.script_index;
  var_0.aliveai = [];

  for(;;) {
    var_0.aliveai = maps\_utility::remove_dead_from_array(var_0.aliveai);

    if(var_0.aiamount - var_0.aliveai.size < 1) {
      wait 1;
      continue;
    }

    while(var_0.aiamount - var_0.aliveai.size > 0) {
      common_scripts\utility::flag_wait("player_not_doing_strafe");
      var_1 = maps\_utility::spawn_ai();

      if(!isDefined(var_1)) {
        wait 0.1;
        continue;
      }

      var_0.aliveai[var_0.aliveai.size] = var_1;
      var_1 thread bunker_beach_attackers_think(var_0);
      wait 0.1;
      var_0.aliveai = maps\_utility::remove_dead_from_array(var_0.aliveai);
    }

    wait(randomintrange(5, 10));
  }
}

bunker_beach_attackers_think(var_0) {
  self endon("death");

  if(!isDefined(var_0))
    var_0 = common_scripts\utility::getstruct(self.target, "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  self.grenadeawareness = 0;
  self setgoalpos(var_0.origin);
  thread maps\homecoming_util::waittill_real_goal(var_0);
  var_1 = randomintrange(8, 20);
  maps\_utility::delaythread(var_1, maps\_utility::die);

  if(!maps\homecoming_util::parameters_check("ignore_nodes"))
    level.beachfrontguys[level.beachfrontguys.size] = self;

  level.bunker_beach_ai = common_scripts\utility::array_removeundefined(level.bunker_beach_ai);
  level.bunker_beach_ai[level.bunker_beach_ai.size] = self;
}

bunker_beach_attackers_death(var_0) {
  self endon("death");
  var_1 = randomintrange(25, 400);
  var_1 = squared(var_1);

  for(;;) {
    var_2 = distance2dsquared(self.origin, var_0.origin);

    if(var_2 <= var_1)
      self kill();

    wait 0.1;
  }
}

beach_bunker_stumble_event() {
  var_0 = self.spawner;
  common_scripts\utility::flag_set("FLAG_bunker_hallway_explosion");
  var_1 = common_scripts\utility::getstruct("house_stairs_explosion_spot", "targetname");
  var_2 = var_0 maps\homecoming_util::get_linked_struct();
  self.animname = "generic";
  maps\_utility::gun_remove();
  var_2 thread maps\_anim::anim_first_frame_solo(self, "wall_stumble");
  thread common_scripts\utility::play_sound_in_space("scn_homecoming_house_incoming", var_1.origin);
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("scn_homecoming_house_exp", var_1.origin);
  var_2 thread beach_bunker_stumbler_sound();
  var_3 = common_scripts\utility::getstructarray("bunker_stairs_explosion_soundspot", "targetname");

  foreach(var_5 in var_3)
  thread common_scripts\utility::play_sound_in_space(var_5.script_sound, var_5.origin);

  common_scripts\utility::exploder("hallway_exp");
  earthquake(0.35, 0.8, var_1.origin, 5000);
  var_7 = common_scripts\utility::getstruct("bunker_hallway_explosion_phys_struct", "targetname");
  physicsexplosionsphere(var_7.origin, 50, 25, 1.5);
  level.player shellshock("homecoming_bunker", 2.5);
  level.player playrumbleonentity("artillery_rumble");
  var_2 thread maps\_anim::anim_single_solo(self, "wall_stumble");
  common_scripts\utility::waitframe();
  self setanimtime(maps\_utility::getanim_generic("wall_stumble"), 0.13);
  var_2 waittill("wall_stumble");
  var_2 thread maps\_anim::anim_loop_solo(self, "wall_stumble_idle");
  common_scripts\utility::flag_wait("FLAG_bunker_balcony_blocker_set");
  maps\homecoming_util::delete_safe();
}

beach_bunker_stumbler_sound() {
  var_0 = spawn("trigger_radius", self.origin, 0, 250, 100);
  var_0 waittill("trigger");
  common_scripts\utility::play_sound_in_space("homcom_us2_moaninginpain");
}

bunker_mg_guy() {
  self.animname = "primary_gunner";
  maps\_utility::gun_remove();
  self notsolid();
  self.name = "";
  self setlookattext("", & "");
  level.secondarygunner = getent("balcony_secondary_gunner", "targetname") maps\_utility::spawn_ai();
  level.secondarygunner.animname = "secondary_gunner";
  level.secondarygunner.name = "SGT. Harmer";
  var_0 = [self, level.secondarygunner];
  var_1 = common_scripts\utility::getstruct("balcony_mg_scene", "targetname");
  var_1 thread maps\_anim::anim_single(var_0, "bunker_mg_scene");
  common_scripts\utility::waitframe();
  var_1 maps\_anim::anim_set_rate(var_0, "bunker_mg_scene", 0);
  var_1 maps\_anim::anim_set_time(var_0, "bunker_mg_scene", 0.47);
  common_scripts\utility::flag_wait("FLAG_start_bunker");
  var_1 maps\_anim::anim_set_rate(var_0, "bunker_mg_scene", 1);
  common_scripts\utility::flag_wait("FLAG_balcony_gunner_hit");
  var_2 = anglesToForward(self gettagangles("j_head"));
  playFX(common_scripts\utility::getfx("headshot_blood"), self gettagorigin("j_head"), var_2 * -1);
  self linkto(level.balcony["mid"]);
}

beach_front_nodes_think() {
  var_0 = self;
  var_1 = squared(350);

  for(;;) {
    if(isDefined(var_0.currentowner)) {
      var_0.currentowner waittill("death");
      var_0.currentowner = undefined;
    }

    for(;;) {
      level.beachfrontguys = maps\_utility::array_removedead_or_dying(level.beachfrontguys);
      var_2 = sortbydistance(level.beachfrontguys, var_0.origin);
      var_3 = undefined;

      foreach(var_5 in var_2) {
        if(isDefined(var_5.hasnode)) {
          continue;
        }
        if(maps\homecoming_util::postion_dot_check(var_0, var_5) == "infront") {
          continue;
        }
        if(distance2dsquared(var_0.origin, var_5.origin) <= var_1) {
          var_6 = var_5.origin[2] - var_0.origin[2];

          if(var_6 > 80) {
            continue;
          }
          var_3 = var_5;
          break;
        }
      }

      if(isDefined(var_3) && isalive(var_3)) {
        var_3 setgoalnode(var_0);
        var_3 thread maps\homecoming_util::goal_radius_constant(16);
        var_3 notify("setting_new_goal");
        var_0.currentowner = var_3;
        var_3.hasnode = 1;
        break;
      }

      wait 0.1;
    }
  }
}

bunker_vehicle_javelin_watcher(var_0) {
  var_0 endon("unload_complete");
  var_0 endon("death");

  for(;;) {
    level.player waittill("missile_fire", var_1, var_2);

    if(var_2 == "javelin_dcburn" && level.javelinlockfinalized == 1) {
      var_3 = level.javelintarget;

      if(var_0 == var_3) {
        wait 2.5;
        var_0 maps\_utility::ent_flag_set("unload_interrupted");
        return;
      }
    }
  }
}

beach_hovercraft_tanks_default() {
  self.firetime = [2.5, 5];
  thread maps\homecoming_util::vehicle_path_notifications();
  thread maps\homecoming_util::vehicle_allow_player_death();
  common_scripts\utility::waitframe();
  maps\_utility::ent_flag_wait("hovercraft_unload_complete");

  if(!isDefined(level.hovercrafttanks))
    level.hovercrafttanks = [];

  level.hovercrafttanks[level.hovercrafttanks.size] = self;
  level.bunker_beach_vehicles[level.bunker_beach_vehicles.size] = self;
}

beach_vehicle_default() {
  thread maps\homecoming_util::vehicle_allow_player_death();
  thread maps\homecoming_util::javelin_target_set(self, (0, 0, 80));
  thread maps\homecoming_util::vehicle_path_notifications();
}

beach_battlehinds_start() {
  level.beachhinds = [];
  var_0 = getEntArray("beach_starting_hinds", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 maps\_vehicle::spawn_vehicle_and_gopath();
    var_3.firesoundoverride = "weap_hind_20home_fire_npc";
    var_3 thread beach_battlehinds_manager(var_2);
  }
}

beach_battlehinds_manager(var_0) {
  level endon("stop_beach_hinds");
  var_1 = self;
  level.beach_ambient_hinds = [];
  var_2 = [];

  if(isDefined(var_1.script_linkto))
    var_2 = var_1 common_scripts\utility::get_linked_ents();
  else
    var_2 = common_scripts\utility::array_add(var_2, var_0);

  var_3 = var_2;

  for(;;) {
    level.beach_ambient_hinds = common_scripts\utility::array_add(level.beach_ambient_hinds, var_1);
    var_1 thread beach_battlehind_default();
    var_1 vehicle_turnengineoff();
    var_1 waittill("death", var_4);
    level.beach_ambient_hinds = common_scripts\utility::array_remove(level.beach_ambient_hinds, var_1);

    if(isDefined(var_4) && isplayer(var_4)) {
      break;
    }

    wait(randomintrange(1, 3));
    var_0 = var_3[randomint(var_3.size)];
    var_1 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();

    if(var_2.size > 1)
      var_3 = common_scripts\utility::array_remove(var_2, var_0);
  }
}

beach_battlehind_default() {
  level.beachhinds[level.beachhinds.size] = self;
  thread maps\homecoming_util::vehicle_path_notifications();
  thread maps\homecoming_util::vehicle_allow_player_death();
  thread maps\homecoming_util::heli_enable_rocketdeath();
  level.strafevehicles = common_scripts\utility::array_add(level.strafevehicles, self);
  self waittill("death");
  level.beachhinds = common_scripts\utility::array_remove(level.beachhinds, self);
}

beach_battlehind_rpgers(var_0) {
  self endon("death");
  missile_createrepulsorent(self, 750, 1000);

  for(;;) {
    wait(randomfloatrange(8, 16));
    var_1 = common_scripts\utility::getclosest(self.origin, var_0);
    magicbullet("rpg_cheap", var_1.origin, self.origin);
  }
}

beach_bunker_drones() {
  var_0 = getEntArray("bunker_beach_drones", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 maps\_utility::spawn_ai();
    var_3.drone_idle_custom = 1;
    var_3.drone_idle_override = maps\homecoming_drones::drone_fight_smart;
    var_3 thread maps\homecoming_util::waittill_death_respawn(var_2, 1.2, 2.4);
  }
}

#using_animtree("generic_human");

bunker_trench_drones() {
  level endon("FLAG_stop_trench_drones");
  var_0 = self;

  for(;;) {
    var_1 = maps\homecoming_drones::drones_request(1);

    if(!var_1) {
      wait 0.1;
      continue;
    }

    var_2 = var_0 maps\_utility::spawn_ai();
    wait(randomintrange(15, 25));
    var_3 = [ % stand_death_tumbleback, % stand_death_headshot_slowfall, % stand_death_shoulderback];
    var_2.deathanim = var_3[randomint(var_3.size)];
    var_2 dodamage(var_2.health + 10, var_2.origin);
    wait(randomintrange(4, 8));
  }
}

bunker_trench_drone_runners() {
  var_0 = getEntArray("bunker_trench_runners", "targetname");
  var_1 = ["run"];
  var_2 = ["drone_fad_fire_npc", "drone_r5rgp_fire_npc"];
  var_3 = [3.2, 5];
  var_0 thread maps\homecoming_drones::drone_infinite_runners("FLAG_stop_trench_drones", var_3, var_1, var_2);
}

bunker_javelin_drones() {
  var_0 = self.spawner;

  if(isDefined(var_0.script_linkto))
    self.javtargets = getEntArray(var_0.script_linkto, "script_linkname");

  self.javelin_smarttargeting = 1;
  self.drone_idle_custom = 1;
  self.drone_idle_override = maps\homecoming_drones::drone_fire_fake_javelin_loop;
  thread maps\_utility::magic_bullet_shield();
}

beach_enemy_default(var_0) {
  if(!isDefined(self)) {
    return;
  }
  self.health = 200;
  self.ignorerandombulletdamage = 1;
  self.grenadeawareness = 0;
  self.disablebulletwhizbyreaction = 1;
  self.ignoresuppression = 1;
  self.norunngun = 1;
  self.a.disablelongdeath = 1;
  self.goalradius = 56;
  self setthreatbiasgroup("beach_enemies");
  thread beach_enemy_default_targeting();
}

beach_enemy_default_targeting() {
  self endon("death");
  var_0 = getEntArray("beach_enemy_targets", "targetname");

  for(;;) {
    var_1 = level common_scripts\utility::waittill_notify_or_timeout_return("beach_enemies_attack_player", randomintrange(2, 5));

    if(isDefined(var_1)) {
      self.favoriteenemy = undefined;
      var_2 = common_scripts\utility::random(var_0);
      self setentitytarget(var_2);
      continue;
    }

    self clearentitytarget();
    self.favoriteenemy = level.player;
    level waittill("beach_enemies_attack_player_stop");
  }
}

beach_enemy_attack_player_manager() {
  level endon("FLAG_start_balcony_collapse");
  var_0 = undefined;
  var_1 = undefined;
  var_2 = maps\_utility::getdifficulty();

  switch (var_2) {
    case "easy":
      var_0 = randomintrange(5, 10);
      var_1 = randomintrange(10, 15);
      break;
    case "medium":
      var_0 = randomintrange(5, 10);
      var_1 = randomintrange(10, 15);
      break;
    case "hard":
      var_0 = randomintrange(5, 10);
      var_1 = randomintrange(5, 10);
      break;
    case "fu":
      var_0 = randomintrange(5, 10);
      var_1 = randomintrange(5, 10);
      break;
  }

  for(;;) {
    wait(var_1);

    if(level.player.health != level.player.maxhealth) {
      continue;
    }
    level notify("beach_enemies_attack_player");
    level.player setthreatbiasgroup();
    var_3 = gettime();

    for(;;) {
      if(gettime() - var_3 >= var_0 * 1000) {
        break;
      }

      if(level.player.health <= 50) {
        break;
      }

      wait 0.1;
    }

    level.player setthreatbiasgroup("bunker_allies");
    level notify("beach_enemies_attack_player_stop");
  }
}