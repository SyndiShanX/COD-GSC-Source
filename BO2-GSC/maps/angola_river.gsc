/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_river.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\_anim;
#include maps\_audio;
#include maps\angola_2_util;
#include animscripts\utility;
#include maps\_music;
#include maps\_skipto;
#include maps\createart\angola_art;
#include maps\angola_barge;
#include maps\_turret;

init_flags() {
  flag_init("moving_boat");
  flag_init("heli_moving_to_location");
  flag_init("player_jump_on_barge");
  flag_init("barge_knockoff_started");
}

init_heroes() {
  level.hudson = init_hero("hudson");
  level.hudson.non_wet_model = level.hudson.model;
  level.hudson setmodel("c_usa_angola_hudson_wet_fb");
  level.hudson detach("c_usa_angola_hudson_glasses");
  level.hudson detach("c_usa_angola_hudson_hat");
}

setup_level() {
  level.player thread maps\createart\angola_art::river();
  level.barge_spawners = [];
  level.barge_spawners[0] = getent("river_barge_convoy_2_guards_assault", "targetname");
  level.barge_spawners[1] = getent("river_barge_convoy_2_guards_assault", "targetname");
  level.max_river_heli_speed = 65;
  level.main_barge = getent("main_barge", "targetname");
  level.escort_boat = getent("main_convoy_escort_boat_medium_1", "targetname");
  level.escort_boat_2 = getent("main_convoy_escort_boat_medium_2", "targetname");
  level.escort_boat_3 = getent("main_convoy_escort_boat_medium_4", "targetname");
  level.escort_boat_small = getentarray("main_convoy_escort_boat_small", "targetname");
  level.boarding_vo_playing = 0;
  level.overrideactordamage = ::actor_turret_damage_override;
  level.num_enemy_falls_off = 0;
  exploder(100);
  setsaveddvar("aim_slowdown_enabled", 0);
  setsaveddvar("aim_lockon_enabled", 0);
  setup_boat_goal_sets();
  boat_convoy_setup();
  level thread maps\angola_barge::determine_convoy_spawn_points();
}

skipto_river() {
  level thread screen_fade_out(0, undefined, 1);
  level.hudson = init_hero("hudson");
  skipto_teleport_players("player_skipto_river");
  skipto_teleport_ai("player_skipto_river");
  wait 0.01;
  level clientnotify("f35_interior");
}

skipto_heli_jump() {
  load_gump("angola_2_gump_river");
  init_flags();
  setup_level();
  init_heroes();
  setup_main_barge();
  setup_hudson_heli();
  level thread blackscreen(0, 2.2, 0);

  for(i = 0; i < level.escort_boat_small.size; i++)
    level.escort_boat_small[i] delete();

  wait 0.01;
  level clientnotify("f35_interior");
}

river_main() {
  load_gump("angola_2_gump_river");
  init_flags();
  setup_level();
  init_heroes();
  setup_hudson_heli();
  setup_main_barge();
  level thread voice_over_river();
  level thread hudson_heli_think();
  river_intro();
}

heli_jump_main() {
  heli_jump();
  level thread clean_up_barge_ents();
}

setup_hudson_heli(player_driver) {
  if(!isDefined(player_driver))
    player_driver = 0;

  vh_river_heli = spawn_vehicle_from_targetname("river_player_heli");
  vh_river_heli.player_transfer_location = getent("heli_transfer_player_location", "targetname");
  vh_river_heli.rpg_target = getent("heli_target_origin", "targetname");
  vh_river_heli.rpg_target linkto(vh_river_heli, "tag_origin", (800, 0, -100));
  vh_river_heli.player_transfer_location linkto(vh_river_heli, "tag_origin", vectorscale((0, 0, -1), 100.0));
  vh_river_heli setmovingplatformenabled(1);
  vh_river_heli thread veh_magic_bullet_shield(1);
  playfxontag(level._effect["heli_trail"], vh_river_heli, "tag_origin");

  if(player_driver) {
    vh_river_heli usevehicle(level.player, 0);
    vh_river_heli.player_vehicle = 1;
  } else
    vh_river_heli.player_vehicle = 0;

  level thread run_scene("handles_loop");
}

match_origin(other_ent) {
  self endon("stop_match_origin");

  while(true) {
    self.origin = other_ent.origin;
    self.angles = other_ent.angles;
    wait 0.05;
  }
}

#using_animtree("player");

river_intro() {
  level.player thread take_and_giveback_weapons("give_player_weapon_back", 0);
  main_barge = getent("main_barge", "targetname");
  main_barge.animname = "main_barge";
  level.player setclientdvar("r_waterSheetingFX_allowed", 0);
  wait 2;
  level thread run_scene("heli_attack_player_intro");
  setmusicstate("ANGOLA_CHOPPER_IN");
  level screen_fade_in();
  set_objective(level.obj_secure_the_barge);
  timer = getanimlength( % ch_ang_05_01_rundown_intro_player);
  wait(timer - 9.85);
  vh_heli = getent("river_player_heli", "targetname");
  fake_fire_origin = getentarray("fake_fire_origin", "targetname");
  magicbullet("rpg_magic_bullet_sp_angola", fake_fire_origin[0].origin, vh_heli.origin, level.main_barge, vh_heli, (400, -512, -140));
  level thread heli_alarm_on();
  scene_wait("heli_attack_player_intro");
  level.hudson thread say_dialog("huds_shit_missile_incom_0");
  level notify("stop_firing_bullets_at_heli");
  level thread run_scene("heli_attack_player_idle");
  level.player notify("give_player_weapon_back");
  level.player player_enable_weapons();
  wait 3;
  level.hudson thread say_dialog("huds_jump_mason_jump_0");
  run_scene("heli_attack_player_fall");
  level.player setclientdvar("r_waterSheetingFX_allowed", 1);
}

hudson_heli_think() {
  path_node_start_heli = getvehiclenode("heli_start_node", "targetname");
  vh_heli = getent("river_player_heli", "targetname");
  vh_heli hidepart("tag_weapons_pod");
  vh_heli hidepart("Tag_gunner_barrel2");
  vh_heli hidepart("Tag_gunner_barrel4");
  vh_heli attach("veh_t6_air_alouette_dmg_att", "tag_origin");
  level.hudson linkto(vh_heli, "tag_driver");
  level thread run_scene("heli_attack_hudson_idle");
  level.player playrumblelooponentity("angola_hind_ride");
  vh_heli thread go_path(path_node_start_heli);
  vh_heli pathvariableoffset(vectorscale((1, 1, 1), 125.0), 2.5);
  wait 11;
  level notify("reached_convoy_one");
}

heli_jump() {
  level.player.ignoreme = 1;
  main_barge = getent("main_barge", "targetname");
  m_jumpto_spot = getent("barge_jumpto_obj_spot", "targetname");
  m_jumpto_spot.use_obj_offset = vectorscale((0, 0, 1), 64.0);
  set_objective(level.obj_secure_the_barge, m_jumpto_spot, "jump");
  level.player enableweapons();
  weapons = level.player getweaponslistprimaries();

  if(weapons.size > 0)
    level.player switchtoweapon(weapons[0]);

  fake_body = spawn("script_model", level.player.origin);
  fake_body setmodel("c_usa_seal80s_mason_viewbody");
  fake_body.animname = "player_body_river";
  fake_body.targetname = "player_body_river";
  fake_body hide();
  fake_body thread match_origin(level.player);
  fake_body useanimtree(#animtree);
  level thread fail_player_for_not_jumping();
  trigger_wait("heli_jump_trigger");
  set_objective(level.obj_secure_the_barge, m_jumpto_spot, "remove");
  level notify("player_jumped");
  stopallrumbles();
  level.hudson linkto(main_barge);
  end_scene("heli_hold_steady");
  spawners = getent("river_barge_convoy_2_guards_assault", "targetname");
  machete_dude = simple_spawn_single(spawners);
  machete_dude thread magic_bullet_shield();
  machete_dude.animname = "machete_dude";
  createstreamermodelhint(machete_dude.model, 8.0);
  machete_dude attach("t6_wpn_machete_prop", "tag_weapon_left");
  machete_dude thread remove_machete_prop();
  machete_dude linkto(main_barge);
  machete_dude thread stop_magic_bullet_shield();
  level thread run_scene("machete_jump");
  fake_body notify("stop_match_origin");
  fake_body linkto(main_barge);
  main_barge thread anim_single_aligned(fake_body, "player_jump_on_boat");
  fake_body show();
  level.player playerlinktoabsolute(fake_body, "tag_player");
  level.player disableweapons();
  level.player hideviewmodel();
  wait 0.05;
  level notify("hel_alrm_off");
  level.hudson gun_recall();
  level clientnotify("alouette_jumped");
  level thread maps\_audio::switch_music_wait("ANGOLA_MACHETE", 0.5);
  vh_heli = getent("river_player_heli", "targetname");
  vh_heli thread heli_crash_audio();
  vh_heli play_fx("heli_fire", vh_heli.origin, vh_heli.angles, undefined, 1, "tag_origin");
  main_barge waittill("player_jump_on_boat");
  level.player unlink();
  level.player enableweapons();
  level.player showviewmodel();
  fake_body delete();
  level.hudson thread say_dialog("huds_clear_the_deck_0");
  autosave_by_name("angola_2_river");
  setmusicstate("ANGOLA_BARGE_RIVERFIGHT");
  clientnotify("imp_context");
  level.player allowstand(1);
  level.player setstance("stand");
  level.player unlink();
  end_scene("handles_loop");
  level.hudson unlink();
  wait 1;
  level thread hudson_barge_think();
  wait 2;
  level thread cleanup_river_lance_trash();
  level notify("river_heli_delete");
  vh_heli delete();
  level.main_barge setspeed(30);
  level.player.ignoreme = 0;
}

remove_machete_prop() {
  wait 9;
  self detach("t6_wpn_machete_prop", "tag_weapon_left");
}

heli_alarm_on() {
  level endon("boat_convoy_section_finished");
  wait 4;
  heli_alarm_ent = spawn("script_origin", level.player.origin);
  heli_alarm_ent playloopsound("veh_heli_alarm");
  level waittill("hel_alrm_off");
  heli_alarm_ent stoploopsound(0.2);
  wait 1;
  heli_alarm_ent delete();
}

hudson_barge_think() {
  level.hudson.fixednode = 0;
  level.hudson setgoalnode(getnode("hudson_first_barge_node", "targetname"));
  flag_wait("barge_defend_done");
  level.hudson say_dialog("huds_okay_mason_we_re_0", 2);
  level.hudson say_dialog("huds_open_up_the_containe_0", 1);
  wait 1;
  hudson_cover = getnode("hudson_open_container_node", "targetname");
  level.hudson anim_set_blend_in_time(1);
  level.hudson.goalradius = 16;
  level.hudson setgoalnode(hudson_cover);
  level.hudson waittill_any_or_timeout(15, "goal");
  run_scene("hudson_container_approach");
  run_scene("hudson_container_loop");
  level thread run_scene("hudson_container_loop_novo");
}

heli_reached_barge_rear() {
  self endon("death");
  self waittill("barge_rear");
  level.main_barge.b_no_speed_match = undefined;
}

heli_follow_boat(boat) {
  self endon("death");

  while(true) {
    self setvehgoalpos(boat.origin + vectorscale((0, 0, 1), 1000.0), 1);
    wait 1;
  }
}

heli_monitor_near_goal() {
  self waittill_any("goal", "near_goal");
  self.near_goal = 1;
}

heli_match_best_boat_speed() {
  self endon("death");
  self endon("stop_match_speed");
  level.best_boat_count = 0;

  if(!level.ignore_timer) {
    vehicles = getvehiclearray();

    foreach(vehicle in vehicles) {
      if(vehicle.vehicleclass == "boat" && !isDefined(vehicle.b_no_speed_match) && vehicle.health > 0) {
        vehicle.timer = 0;
        vehicle thread wait_for_best_boat_to_die();
      }
    }
  }

  while(true) {
    best_boat = undefined;
    best_boat_dist = 999999;
    vehicles = getvehiclearray();

    foreach(vehicle in vehicles) {
      if(vehicle.vehicleclass == "boat" && !isDefined(vehicle.b_no_speed_match) && vehicle.health > 0) {
        delta = self.origin - vehicle.origin;
        delta = (delta[0], delta[1], 0);
        angles = vehicle.angles;
        angles = (0, angles[1], angles[2]);
        angles = (angles[0], angles[1], 0);
        fwd = anglestoforward(angles);
        right = anglestoright(angles);
        dist = abs(vectordot(delta, fwd));
        dist_y = abs(vectordot(delta, right));

        if(dist < 1000 && dist_y < 5000 && dist < best_boat_dist) {
          if(!level.ignore_timer) {
            if(vehicle.timer >= 5.0)
              continue;
          }

          best_boat_dist = dist;
          best_boat = vehicle;
        }
      }
    }

    if(isDefined(best_boat)) {
      if(!level.ignore_timer) {
        best_boat.timer = best_boat.timer + 0.05;

        if(best_boat.timer >= 5.0)
          level.best_boat_count++;

        if(level.best_boat_count >= 5)
          level notify("stop_match_speed");
      }

      n_speed = best_boat getspeedmph();
      self setspeed(n_speed + 2);
    } else
      self setspeed(level.max_river_heli_speed);

    wait 0.05;
  }
}

wait_for_best_boat_to_die() {
  self endon("deleted");
  self waittill("death");
  level.best_boat_count++;

  if(level.best_boat_count >= 5)
    level notify("stop_match_speed");
}

stop_boat_on_damage() {
  self waittill("damage");

  if(isDefined(self))
    self setspeed(0);
}

fire_machine_gun_on(target) {
  self maps\_turret::set_turret_target(target, vectorscale((0, 0, -1), 50.0), 1);
  self maps\_turret::set_turret_target(target, vectorscale((0, 0, -1), 50.0), 2);
  self maps\_turret::set_turret_target(target, vectorscale((0, 0, -1), 50.0), 3);
  self maps\_turret::set_turret_target(target, vectorscale((0, 0, -1), 50.0), 4);
  wait 0.5;
  self thread maps\_turret::fire_turret_for_time(6, 1);
  self thread maps\_turret::fire_turret_for_time(6, 2);
  self thread maps\_turret::fire_turret_for_time(5, 3);
  wait 0.5;
  self thread maps\_turret::fire_turret_for_time(5, 4);
}

fail_player_for_not_jumping() {
  trigger = getent("heli_jump_trigger", "targetname");
  trigger endon("trigger");
  missile_fired = 0;

  for(timer = 0; timer < 3.1; timer = timer + 0.05)
    wait 0.05;

  vh_heli = getent("river_player_heli", "targetname");
  playfxontag(getfx("intro_heli_missle_exp"), vh_heli, "tag_origin");
  wait 0.5;
  level.player kill();
}

heli_crash_audio() {
  fake_heli_snd = spawn("script_origin", self.origin);
  fake_heli_snd linkto(self);
  fake_heli_snd playloopsound("evt_heli_crash_loop", 1.5);
  wait 1;
  fake_heli_snd playsound("evt_heli_crash");
  wait 2;
  fake_heli_snd stoploopsound(0.5);
  fake_heli_snd stopsound("evt_heli_crash");
  fake_heli_snd playsound("evt_heli_river_exp");
  wait 5;
  fake_heli_snd delete();
}

barge_audio(alias) {
  sound_ent = spawn("script_origin", self.origin);
  sound_ent linkto(self);
  sound_ent playloopsound(alias, 0.05);
  sound_ent_back = spawn("script_origin", self.origin);
  sound_ent_back linkto(self, "tag_origin", vectorscale((1, 0, 0), 400.0));
  sound_ent_back playloopsound("veh_barge2_motor_high_plr", 0.05);
  sound_ent_back thread swap_engine_sound();
  sound_ent_side_left = spawn("script_origin", self.origin);
  sound_ent_side_left linkto(self, "tag_origin", (-500, 400, 0));
  sound_ent_side_left playloopsound("veh_barge2_water_side_left", 0.05);
  sound_ent_side_right = spawn("script_origin", self.origin);
  sound_ent_side_right linkto(self, "tag_origin", (-500, -400, 0));
  sound_ent_side_right playloopsound("veh_barge2_water_side_right", 0.05);
  sound_ent_back_water = spawn("script_origin", self.origin);
  sound_ent_back_water linkto(self, "tag_origin", vectorscale((-1, 0, 0), 800.0));
  sound_ent_back_water playloopsound("veh_barge2_water_back", 0.05);
  level thread barge_sound_cleanup();
  level waittill("stop_boat_audio");
  sound_ent delete();
  sound_ent_side_left delete();
  sound_ent_side_right delete();
  sound_ent_back delete();
  sound_ent_back_water delete();
}

swap_engine_sound() {
  level waittill("engine_dmg_snd");
  self stoploopsound(0.1);
  wait 1;
  self playloopsound("veh_barge_engine_dmg", 1);
}

barge_sound_cleanup() {
  level waittill("death");
  level notify("stop_boat_audio");
}

magic_missile_turret() {
  self endon("death");
  self endon("delete");
  self.v_my_boat endon("death");
  self.v_my_boat endon("delete");
  fire_from = getent(self.target, "targetname");

  while(true) {
    random = randomint(10);

    if(random < 6) {
      fire_at_target = fire_from.origin;
      foward = anglestoforward((randomfloatrange(2, 7.5), randomfloatrange(-15, 15), 0) + self.v_my_boat.angles);
      fire_at_target = fire_at_target + foward * 500;
      magicbullet("rpg_magic_bullet_sp", fire_from.origin, fire_at_target);
    } else
      magicbullet("rpg_magic_bullet_sp", fire_from.origin, level.player.origin + (randomintrange(-32, 32), randomintrange(-32, 32), 40));

    wait(randomfloatrange(2, 4));
  }
}

boat_gunner_damage_override(einflictor, eattacker, idamage, idflags, type, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(isDefined(level.hudson)) {
    if(eattacker != level.player && eattacker != level.hudson)
      return 0;
  }

  if(isDefined(self.is_driver)) {
    if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE_SPLASH")
      idamage = 0;
    else
      idamage = int(idamage * 0.33);
  }

  return idamage;
}

boat_damage_override(einflictor, eattacker, idamage, idflags, type, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  idamage = 0;
  a_window_tags = array("tag_window1", "tag_window2", "tag_window3", "tag_door_l_window", "tag_door_r_window");

  foreach(str_tag in a_window_tags) {
    if(partname == str_tag)
      self hidepart(partname);
  }

  if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE_SPLASH")
    idamage = int(self.healthmax * 0.5);
  else if(sweapon == "auto_gun_turret_sp_barge") {
    self notify("signature_death");
    idamage = int(self.healthmax * 0.07);
  }

  if(idamage >= self.health && distance2dsquared(self.origin, level.main_barge.origin) > 2048 * 2048) {
    if(!isDefined(self.in_death_anim)) {
      self.in_death_anim = 1;
      self boat_unique_death_anim();
      idamage = self.healthmax;
    }
  }

  return idamage;
}

boat_unique_death_anim() {
  self.do_scripted_crash = 0;
  self.overidevehicledamage = undefined;
  self veh_magic_bullet_shield(1);
  str_anim = "boat_death_0" + randomint(4);

  if(issubstr(self.model, "medium")) {
    str_fx = "medium_boat_explosion";
    self.animname = "boarding_boat";
  } else {
    str_fx = "ship_explosion";
    self.animname = "small_boat";
  }

  playfxontag(getfx(str_fx), self, "tag_origin");
  self anim_single(self, str_anim);
  self veh_magic_bullet_shield(0);
}

signature_boat_override(einflictor, eattacker, idamage, idflags, type, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(eattacker != level.player)
    return 0;

  if(self.health - idamage < 300) {
    self notify("signature_death");
    return self.health - 1;
  }

  return idamage;
}

delete_on_death() {
  self endon("delete");
  self waittill("death_finished");

  if(isDefined(self)) {
    self.delete_on_death = 1;
    self notify("death");

    if(!isalive(self))
      self delete();
  }
}

unlink_from_barge_on_death() {
  self waittill("explosive_death");
  self.origin = self.origin - vectorscale((0, 0, 1), 50.0);
  smoke_tag = spawn_model("tag_origin", self.origin, self.angles);
  smoke_tag linkto(self);
  smoke_tag play_fx("small_boat_smoke_trail", smoke_tag.origin, smoke_tag.angles, undefined, 1, "tag_origin");
  run_scene(self.death_animation);
  wait 5;
  smoke_tag delete();
}

signature_death() {
  self waittill("signature_death");
  self.origin = self.origin - vectorscale((0, 0, 1), 50.0);
  self play_fx("signature_death_explosion", self.origin, self.angles);
  level thread run_scene("signature_gunboat_death");
  level thread run_scene("signature_small_gunboat_death");
  smoke_tag = spawn_model("tag_origin", self.origin, self.angles);
  smoke_tag linkto(self);
  smoke_tag play_fx("small_boat_smoke_trail", smoke_tag.origin, smoke_tag.angles, undefined, 1, "tag_origin");
  wait 5;
  smoke_tag delete();
}

ai_gunner_think(n_gunner, ai) {
  self endon("death");
  self endon("delete");
  ai endon("death");
  ai endon("delete");
  self thread gunner_aim_think(n_gunner, ai);

  while(true) {
    self thread maps\_turret::fire_turret_for_time(3, n_gunner);
    wait(randomfloatrange(4, 5));
  }
}

gunner_aim_think(n_gunner, ai) {
  self endon("death");
  self endon("delete");
  level endon("boat_convoy_section_finished");
  ai endon("death");
  ai endon("delete");

  while(true) {
    v_forward = anglestoforward(level.main_barge.angles) * 50;
    self maps\_turret::set_turret_target(level.player, v_forward + vectorscale((0, 0, 1), 40.0), n_gunner);
    wait 0.05;
  }
}

track_gunner_death() {
  self.v_im_on_a_boat endon("death");
  self.v_im_on_a_boat endon("delete");
  level endon("boat_convoy_section_finished");
  self waittill("death");
  self.v_im_on_a_boat maps\_turret::stop_turret(self.n_my_turret_index, 1);
}

check_distance_from_convoy() {
  level endon("boat_convoy_section_finished");

  while(true) {
    iprintlnbold(get_scene_start_pos("enemy_boat_ram_barge", "enemy_ramming_boat_left"));
    wait 1;
  }
}

boat_convoy_setup() {
  level.boat_convoy = [];
  level.boat_convoy[0] = convoy_boat_spawn("mediumboat_01", (3000, 500, 0), 1);
  level.boat_convoy[0].death_animation = "m_gunboat_death_right_01";
  level.boat_convoy_small[0] = convoy_boat_spawn("smallboat_02", vectorscale((1, 0, 0), 3500.0), 1);
  level.boat_convoy[1] = convoy_boat_spawn("mediumboat_01", (2500, -500, 0), 2);
  level.boat_convoy[1].death_animation = "m_gunboat_death_left_01";
}

convoy_boat_spawn(str_boat_spawner_targetname, v_path_offset, n_gunner_count) {
  s_origin = getstruct("river_small_boat_spawn", "targetname");
  vh_boat = spawn_vehicle_from_targetname(str_boat_spawner_targetname);
  vh_boat setspeed(5);
  vh_boat.origin = s_origin.origin;
  vh_boat.v_path_offset = v_path_offset;

  for(i = 0; i < n_gunner_count; i++) {
    vh_boat convoy_boat_add_gunner(i + 1);
    wait_network_frame();
  }

  if(str_boat_spawner_targetname == "smallboat_02")
    vh_boat thread convoy_boat_add_rpg_guy();

  vh_boat thread play_damage_fx_on_boat();
  vh_boat convoy_boat_add_driver();
  vh_boat pathfixedoffset(vh_boat.v_path_offset);
  vh_boat thread go_path(getvehiclenode("gun_boat_start_00", "targetname"));
  return vh_boat;
}

convoy_boat_add_driver() {
  ai_driver = maps\angola_barge::spawn_barge_ai();
  ai_driver.animname = "enemy_ai_driver";
  ai_driver.allowdeath = 1;
  ai_driver.is_driver = 1;
  str_append = self.targetname == "mediumboat_01" ? "medium" : "small";
  str_anim = "boat_driver_" + str_append;
  v_tag_origin = self gettagorigin("tag_driver");
  v_tag_angles = self gettagangles("tag_driver");
  v_origin = getstartorigin(v_tag_origin, v_tag_angles, level.scr_anim["enemy_ai_driver"][str_anim][0]);
  v_angles = getstartangles(v_tag_origin, v_tag_angles, level.scr_anim["enemy_ai_driver"][str_anim][0]);
  ai_driver forceteleport(v_origin, v_angles);
  ai_driver linkto(self, "tag_origin");
  ai_driver thread maps\angola_barge::kill_on_boat_death(self);
  ai_driver thread watch_driver_death(self);
  self thread anim_loop_aligned(ai_driver, str_anim, "tag_origin");
  self.driver = ai_driver;
}

watch_driver_death(vh_boat) {
  self endon("delete");
  self waittill("death");

  if(isDefined(vh_boat))
    vh_boat notify("driver_dead");
}

convoy_boat_add_gunner(n_gunner_index) {
  ai_gunner = maps\angola_barge::spawn_barge_ai();
  ai_gunner enter_vehicle(self, "tag_gunner" + n_gunner_index);
  ai_gunner.v_im_on_a_boat = self;
  ai_gunner.n_my_turret_index = n_gunner_index;
  ai_gunner thread track_gunner_death();
  self thread intro_gunner_think(n_gunner_index, ai_gunner);

  if(!isDefined(self.gunner))
    self.gunner = [];

  self.gunner[self.gunner.size] = ai_gunner;
  ai_gunner thread maps\angola_barge::kill_on_boat_death(self);
}

convoy_boat_add_rpg_guy() {
  ai_guy = simple_spawn_single("rpg_gun_smallboat", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  v_origin = self gettagorigin("tag_enter_gunner2");
  v_angles = self gettagangles("tag_enter_gunner2");
  ai_guy.overrideactordamage = ::boat_gunner_damage_override;
  ai_guy forceteleport(v_origin, v_angles);
  ai_guy linkto(self, "tag_enter_gunner2");
  self.gunner[1] = ai_guy;
  ai_guy thread maps\angola_barge::kill_on_boat_death(self);
}

intro_gunner_think(index, gunner) {
  self endon("death");
  self endon("delete");
  gunner endon("death");
  gunner endon("delete");
  level endon("player_jumped");
  level endon("boat_convoy_section_finished");
  self thread gunner_aim_think(index, gunner);

  while(true) {
    self thread maps\_turret::fire_turret_for_time(3, index);
    wait(randomfloatrange(4, 5));
  }
}

setup_and_anim_crane(str_crane_tag, n_crane, str_noteworthy) {
  if(!isDefined(str_noteworthy))
    str_noteworthy = undefined;

  n_origin = level.main_barge gettagorigin(str_crane_tag);
  n_angles = level.main_barge gettagangles(str_crane_tag);
  crane_model = spawn_model("fxanim_angola_barge_crane_mod", n_origin, n_angles);
  crane_model linkto(level.main_barge, str_crane_tag);
  crane_model.animname = "barge_crane_" + n_crane;
  crane_model.targetname = "barge_crane_" + n_crane;

  if(isDefined(str_noteworthy))
    crane_model.script_noteworthy = str_noteworthy;

  crane_model attach("p6_barge_crane_top", "crane_link_jnt");
  wait 0.5;

  while(true) {
    run_scene("crane_loop_idle_" + n_crane);
    level waittill("play_crane_hit");
    run_scene("crane_hit");
  }
}

destroy_rear_crane() {
  wait 1;
  m_crane = getent("rear_crane", "script_noteworthy");
  m_crane setcandamage(1);
  level waittill("gunboat_ram_left");
  end_scene("crane_loop_idle_2");
  run_scene("crane_fall");
  wait 1;
  level thread run_scene("crane_fall_idle");
}

setup_barge_side_panel(str_tag) {
  self endon("delete");
  n_origin = level.main_barge gettagorigin(str_tag);
  n_angles = level.main_barge gettagangles(str_tag);
  m_panel = spawn_model("fxanim_angola_barge_side_panel_mod", n_origin, n_angles);
  m_panel linkto(level.main_barge, str_tag);
  m_panel setcandamage(1);
  m_panel thread panel_delete_in_container();

  for(i = 0; i < 30; i++) {
    m_panel thread watch_for_knockoff();
    m_panel waittill_either("damage", "barge_knockoff_clear");

    if(flag("barge_knockoff_started") && str_tag == "TAG_LEFT_SIDE_PANEL_02")
      i = i + 30;
  }

  m_panel useanimtree(level.scr_animtree["barge_side_panel"]);
  m_panel.animname = "barge_side_panel_" + randomint(3);
  panel_tag = spawn_model("tag_origin", m_panel.origin, m_panel.angles);
  m_panel setcandamage(0);
  panel_tag anim_single_aligned(m_panel, "panel_fall_off");
  m_panel delete();
  panel_tag delete();
}

watch_for_knockoff() {
  self endon("delete");
  flag_wait("barge_knockoff_started");
  self notify("barge_knockoff_clear");
}

panel_delete_in_container() {
  self endon("delete");
  level waittill("spawn_hind");

  if(isDefined(self))
    self delete();
}

setup_boat_goal_sets() {
  level.boat_goal_sets = [];
  level.boat_goal_sets["med_boat_1"] = [];
  level.boat_goal_sets["med_boat_1"][0] = getent("boat_goal_set_m1f", "script_noteworthy");
  level.boat_goal_sets["med_boat_1"]["left"] = getent("boat_goal_set_m1b", "script_noteworthy");
  level.boat_goal_sets["med_boat_2"] = [];
  level.boat_goal_sets["med_boat_2"]["small_boat"] = getent("boat_goal_set_m2f", "script_noteworthy");
  level.boat_goal_sets["med_boat_2"]["right"] = getent("boat_goal_set_m2b", "script_noteworthy");
  level.boat_goal_sets["med_boat_2"]["left"] = getent("boat_goal_set_m1b", "script_noteworthy");
  level.boat_goal_sets["med_boat_2"]["frontleft"] = getent("boat_goal_set_frontleft", "script_noteworthy");
  level.boat_goal_sets["med_boat_2"]["frontright"] = getent("boat_goal_set_frontright", "script_noteworthy");
}

goal_set_logic_small(s_goal_set) {
  self endon("death");
  self endon("delete");
  level endon("boat_convoy_section_finished");
  goal_set = level.boat_goal_sets[s_goal_set];
  current_goal = 0;
  hold_position = 0;
  hold_timer = 0.0;
  sets = [];
  sets[0] = "small_boat_1";
  sets[1] = "small_boat_1";
  set_index = 0;

  while(true) {
    if(distancesquared(goal_set[current_goal].origin, self.origin) < 1440000) {
      if(!hold_position) {
        hold_position = 1;
        hold_timer = 0.0;
        self setspeed(32, 20, 20);
        self cancelaimove();
      } else if(hold_timer > 3.0) {
        hold_position = 0;
        hold_timer = 0.0;
        current_goal = (current_goal + 1) % 2;

        if(current_goal) {
          self setspeed(40, 20);
          set_index = randomint(sets.size);
          goal_set = level.boat_goal_sets[sets[set_index]];
        } else {
          self setspeed(20, 20);
          set_index = (set_index + 1) % 2;
          goal_set = level.boat_goal_sets[sets[set_index]];
        }
      }
    }

    if(distancesquared(goal_set[current_goal].origin, self.origin) > 4000000) {
      self setspeed(50, 20);
      hold_position = 0;
    }

    self setvehgoalpos(goal_set[1].origin + vectorscale((0, 0, 1), 100.0), 0, 1);
    wait 0.2;

    if(hold_position)
      hold_timer = hold_timer + 0.2;
  }
}

get_player_on_barge() {
  level thread player_fails_to_jump_to_barge();
  wait 5;
  trigger_wait("boat_ram_player_jump_trigger");
  level.jumped_to_barge = 1;
  player_jump_origin = getent("player_barge_jump_origin", "targetname");
  level.player setplayerangles(player_jump_origin.angles);
  level.player setorigin(level.player.origin + anglestoforward(player_jump_origin.angles) * 75);
}

player_fails_to_jump_to_barge() {
  level.gun_boat_alive = 1;
  level.jumped_to_barge = 0;

  while(level.gun_boat_alive) {
    if(level.jumped_to_barge) {
      return;
    }
    wait 1;
  }

  level.player missionfailedwrapper("You_failed_to_jump_onto_the_barge");
}

escort_boat_follow(follow_ent) {
  self endon("death");

  while(true) {
    self setvehgoalpos(follow_ent.nextnode.origin, 1, 1);
    wait 2;
  }
}

barge_chase_boats(start_origin) {
  level.challenge_hmg_boat_destroy = 0;
  offsets = [];
  offsets[0] = (-500, -700, 0);
  offsets[1] = (350, 650, 0);
  offsets[2] = (1500, -850, 0);
  offsets[3] = (1250, 1000, 0);
  level.chase_boats_slots = [];
  level.chase_boats_slots[0] = (5000, 1500, 0);
  level.chase_boats_slots[1] = (4000, 1000, 0);
  level.chase_boats_slots[2] = (4000, -1000, 0);

  for(i = 0; i < 2; i++) {
    boat = spawn_vehicle_from_targetname("barge_chase_small");
    boat thread watch_boat_hmg_death();
    new_pos = start_origin + offsets[i];
    new_pos = (new_pos[0], new_pos[1], start_origin[2] - 25);
    boat.origin = new_pos;
    delta = level.escort_boat.origin - boat.origin;
    delta = (delta[0], delta[1], 0);
    yaw = vectortoangles(vectornormalize(delta))[1];
    boat setphysangles((0, yaw, 0));
    boat thread barge_chase_boat_think(offsets[i], i);
    wait 1.0;
  }

  new_pos = start_origin + offsets[2];
  boat = spawn_vehicle_from_targetname("barge_chase_medium");
  boat.origin = new_pos;
  boat thread watch_boat_hmg_death();
  delta = level.escort_boat.origin - boat.origin;
  delta = (delta[0], delta[1], 0);
  yaw = vectortoangles(vectornormalize(delta))[1];
  boat setphysangles((0, yaw, 0));
  boat thread barge_chase_boat_think((0, 0, 0), 2);
}

watch_boat_hmg_death() {
  self waittill("death");

  if(isDefined(level.player.viewlockedentity))
    level.challenge_hmg_boat_destroy++;
}

barge_chase_boat_think(offset, id) {
  self endon("death");
  level endon("prison_barge_event_start");
  level endon("boat_convoy_section_finished");
  self pathfixedoffset(offset);
  self thread barge_chase_boat_delete();
  self thread boat_river_bob();
  self thread barge_chase_boat_fire(level.escort_boat);
  self setspeed(80, 35);
  wait 12;

  while(true) {
    position = level.escort_boat.origin + anglestoforward(level.escort_boat.angles) * level.chase_boats_slots[id][0] + anglestoright(level.escort_boat.angles) * level.chase_boats_slots[id][1];
    self setvehgoalpos(position);

    line(self.origin, position, (1, 1, 0), 1, 0, 10);

    wait 0.5;
  }
}

barge_chase_boat_fire(target) {
  self endon("death");
  level endon("boat_convoy_section_finished");
  self set_turret_target(target, vectorscale((0, 0, 1), 30.0), 1);

  while(true) {
    self fire_turret_for_time(randomintrange(3, 5), 1);
    wait(randomintrange(1, 3));
  }
}

barge_chase_boat_delete() {
  level endon("boat_convoy_section_finished");
  self endon("death");
  level waittill("prison_barge_event_start");
  self delete();
}

setup_main_barge() {
  path_node_start_boat = getvehiclenode("intro_river_boat_path", "targetname");
  n_delay = 7;

  if(is_after_skipto("river"))
    n_delay = 0;

  level.main_barge thread setup_barge(path_node_start_boat, n_delay);
}

populate_river_boats() {
  start_nodes = getvehiclenodearray("river_scatter_boat_node", "targetname");

  for(i = 0; i < 2; i++) {
    boat = spawn_vehicle_from_targetname("random_small_boat_spawner");
    boat thread setup_small_boat(start_nodes[i]);
  }
}

clean_up_barge_ents() {
  level waittill("clean_up_barge_ents");
  boat_goals = getentarray("chase_boat_goal", "targetname");
  array_delete(boat_goals);
  hind_fly_path = getentarray("hind_fly_path", "targetname");
  array_delete(boat_goals);
  hind_start_path = getent("heli_destination_start", "targetname");

  if(isDefined(hind_start_path))
    hind_start_path delete();

  heli_jump_trigger = getent("heli_jump_trigger", "targetname");

  if(isDefined(heli_jump_trigger))
    heli_jump_trigger delete();

  side_damage_clip = getent("side_damage_clip", "targetname");

  if(isDefined(side_damage_clip))
    side_damage_clip delete();

  rear_damage_clip = getent("rear_damage_clip", "targetname");

  if(isDefined(rear_damage_clip))
    rear_damage_clip delete();

  trigger = getent("trigger_ammo_refill", "script_noteworthy");

  if(isDefined(trigger))
    trigger delete();

  clip = getent("ammo_refill_clip", "targetname");

  if(isDefined(clip))
    clip delete();

  model = getent("ammo_crate_model", "targetname");

  if(isDefined(model))
    model delete();

  fake_fire_origin = getentarray("fake_fire_origin", "targetname");
  array_delete(fake_fire_origin);
  crates = getentarray("barge_crates", "targetname");
  array_delete(crates);
}

barge_link_model(str_ent_name) {
  wait_network_frame();
  a_ent = getentarray(str_ent_name, "targetname");

  if(!a_ent.size)
    a_ent = getentarray(str_ent_name, "script_noteworthy");

  if(!a_ent.size) {
    println(str_ent_name);

  }

  foreach(e_ent in a_ent) {
    e_ent enablelinkto();
    e_ent linkto(self);
    e_ent setmovingplatformenabled(1);

    if(isDefined(e_ent.script_string) && e_ent.script_string == "not_solid")
      e_ent notsolid();
  }
}

setup_barge(start_node, path_start_delay) {
  self thread barge_audio("veh_barge2_engine_high_plr");
  self.b_no_speed_match = 1;
  m_collectible = getent("barge_collectible", "script_noteworthy");

  if(isDefined(m_collectible))
    m_collectible.trigger.script_noteworthy = "barge_collectible_trig";

  m_barrel_fxanim = spawn_model("fxanim_angola_barge_barrels_mod", level.main_barge.origin, level.main_barge.angles);
  m_barrel_fxanim.targetname = "barrel_fxanim_parent";
  m_barrel_fxanim.animname = "barrel_fxanim_parent";
  a_barrels = getentarray("barge_barrel", "targetname");
  array_delete(a_barrels);

  for(i = 0; i < 4; i++) {
    str_tag = "barrel0" + (i + 1) + "_jnt";
    m_barrel_fxanim attach("p6_industrial_barrel_02", str_tag);
  }

  a_barge_model_names = array("hind_fly_path", "heli_destination_start", "chase_boat_goal", "woods_container", "barge_jumpto_obj_spot", "barge_ammo_obj_spot", "heli_jump_trigger", "woods_container_clip", "side_damage_clip", "rear_damage_clip", "barge_ladder_blocker_origin", "barge_gl_turret", "barge_barrel_top_trig", "crate_clips", "barrel_fxanim_parent", "barge_avoidance_linker", "barge_collectible", "barge_collectible_trig", "barge_ammo_cache", "bargeback_ammo_cache", "intruder_box", "intruder_box_trig", "barge_cover_back");

  foreach(str_name in a_barge_model_names)
  self barge_link_model(str_name);

  a_avoid_linker = getentarray("barge_avoidance_linker", "targetname");

  foreach(vh_avoid in a_avoid_linker)
  vh_avoid setvehicleavoidance(1, 375, 100);

  a_turrets = getentarray("barge_gl_turret", "targetname");

  foreach(vh_turret in a_turrets)
  vh_turret veh_magic_bullet_shield(1);

  level thread barge_intruder_box();
  cables = spawn("script_model", level.main_barge.origin);
  cables setmodel("fxanim_angola_barge_cables_mod");
  cables.angles = level.main_barge.angles;
  cables.animname = "barge_wheel_house_cables";
  cables.targetname = "barge_wheel_house_cables";
  cables linkto(level.main_barge);
  level thread run_scene("barge_cable_loop");
  side_damage_clip = getent("side_damage_clip", "targetname");
  side_damage_clip notsolid();
  rear_damage_clip = getent("rear_damage_clip", "targetname");
  rear_damage_clip notsolid();
  level thread manage_barge_bend("RIGHT");
  level thread manage_barge_bend("LEFT");
  level thread setup_and_anim_crane("TAG_FRONT_CRANE", 1);
  level thread setup_and_anim_crane("TAG_REAR_CRANE", 2, "rear_crane");
  level thread destroy_rear_crane();
  a_panel_tags = array("TAG_LEFT_SIDE_PANEL_02", "TAG_LEFT_SIDE_PANEL_03", "TAG_RIGHT_SIDE_PANEL_01", "TAG_RIGHT_SIDE_PANEL_02");

  foreach(str_tag in a_panel_tags)
  level thread setup_barge_side_panel(str_tag);

  woods_truck_trigger = getent("woods_truck_trigger", "targetname");
  woods_truck_trigger enablelinkto();
  woods_truck_trigger linkto(self);
  woods_truck_trigger trigger_off();
  woods_truck_trigger setcursorhint("hint_noicon");
  a_gun_spots = getentarray("barge_rpg_spot", "targetname");

  foreach(m_gun_spot in a_gun_spots) {
    m_gun = spawn("weapon_rpg_sp", m_gun_spot.origin);
    m_gun.angles = m_gun_spot.angles;
    m_gun itemweaponsetammo(1, 4);
  }

  fake_fire_origin = getentarray("fake_fire_origin", "targetname");

  for(i = 0; i < fake_fire_origin.size; i++)
    fake_fire_origin[i] linkto(self);

  self setmovingplatformenabled(1);
  crates = getentarray("barge_crates", "script_noteworthy");
  crates[0] linkto(self);

  for(i = 1; i < crates.size; i++)
    crates[i] linkto(crates[0]);

  tarps = getentarray("crate_tarps", "targetname");

  for(i = 0; i < tarps.size; i++)
    tarps[i] linkto(crates[0]);

  weapon_origin = getent("launcher_origin", "targetname");
  weapon_origin linkto(crates[0]);
  barge_origin_struct = spawn("script_origin", level.main_barge gettagorigin("tag_origin"));
  barge_origin_struct linkto(self, "tag_origin");
  barge_origin_struct.targetname = "barge_origin_struct";
  player_jump_origin = getent("player_barge_jump_origin", "targetname");
  player_jump_origin linkto(self);
  housing_origin = getent("hind_fire_at_housing", "targetname");
  housing_trigger = getent("tigger_hind_fire_at_housing", "targetname");
  housing_trigger enablelinkto();
  housing_origin linkto(level.main_barge);
  housing_trigger linkto(housing_origin);
  a_player_clip = getentarray("barge_player_clip", "targetname");

  foreach(m_clip in a_player_clip) {
    m_clip linkto(housing_origin);
    m_clip setmovingplatformenabled(1);
  }

  level thread setup_dyn_ents();
  run_scene_first_frame("container_open");

  if(isDefined(start_node)) {
    if(isDefined(path_start_delay))
      wait(path_start_delay);

    self thread go_path(start_node);
  }

  if(!is_after_skipto("heli_jump"))
    level thread barge_intro_ai_think();

  level.main_barge thread barge_play_exhaust_fx();
  wait 1;
  level notify("place_dyn_ents");
}

manage_barge_bend(str_side) {
  level.main_barge hidepart("TAG_" + str_side + "_PORT_BENT");
  level waittill("gunboat_ram_left");
  level.main_barge showpart("TAG_" + str_side + "_PORT_BENT");
  level.main_barge hidepart("TAG_" + str_side + "_PORT_PRISTINE");
  level waittill("aft_explosion");
  level.main_barge hidepart("TAG_" + str_side + "_PORT_BENT");
}

barge_play_exhaust_fx() {
  if(!is_after_skipto("heli_jump")) {
    m_fx_point = spawn_model("tag_origin", self.origin, self.angles);
    m_fx_point linkto(self);
    playfxontag(getfx("barge_exhaust_intro"), m_fx_point, "tag_origin");
    level waittill("intro_heli_hit_by_missile");
    m_fx_point delete();
  }

  m_fx_point = spawn_model("tag_origin", self gettagorigin("tag_exhaust_fx"), self gettagangles("tag_exhaust_fx"));
  m_fx_point linkto(self, "tag_exhaust_fx");
  playfxontag(getfx("barge_exhaust"), m_fx_point, "tag_origin");
  level waittill("barge_wheelhouse_destroyed");
  m_fx_point delete();
}

barge_intruder_box() {
  level endon("hind_crash");
  t_intruder = getent("intruder_box_trig", "targetname");
  level thread barge_intruder_box_cleanup();

  if(level.player hasperk("specialty_intruder")) {
    t_intruder setcursorhint("HINT_NOICON");
    t_intruder sethintstring(&"SCRIPT_HINT_INTRUDER");
    m_box = getent("intruder_box", "targetname");
    m_box.use_obj_offset = vectorscale((0, 0, 1), 32.0);
    set_objective(level.obj_intruder, m_box, "interact", undefined, 0);
    m_box thread barge_intruder_hide_marker_in_container();
    m_origin = spawn_model("tag_origin", m_box.origin, m_box.angles);
    m_origin linkto(level.main_barge);
    trigger_wait("intruder_box_trig");
    set_objective(level.obj_intruder, m_box, "delete", undefined, 0);
    m_box notify("intruder_box_opened");
    level.player.ignoreme = 1;
    level thread run_scene("intruder");
    level.player.ignoreme = 0;
    a_models = get_model_or_models_from_scene("intruder");

    foreach(m_anim_model in a_models) {
      m_anim_model unlink();
      m_anim_model linkto(m_origin);
    }

    level.player setperk("specialty_flakjacket");
    scene_wait("intruder");
    thread screen_message_create(&"ANGOLA_2_PERK_FLAK_JACKET", undefined, undefined, undefined, 3);
  }

  t_intruder = getent("intruder_box_trig", "targetname");
  t_intruder delete();
}

barge_intruder_box_cleanup() {
  flag_wait("hind_crash");
  set_objective(level.obj_intruder, undefined, "delete", undefined, 0);
  delete_scene_all("intruder", 1, 0);
}

barge_intruder_hide_marker_in_container() {
  self endon("intruder_box_opened");
  trigger_wait("woods_truck_trigger");
  set_objective(level.obj_intruder, undefined, "delete", undefined, 0);
  level waittill("engine_dmg_snd");
  set_objective(level.obj_intruder, self, "interact", undefined, 0);
}

barge_intro_ai_think() {
  vh_heli = getent("river_player_heli", "targetname");
  a_top_deck = getnodearray("top_goto_pos", "targetname");
  a_bottom = getnodearray("intro_bottom_cover", "targetname");
  wait 1;
  a_ai = maps\angola_barge::spawn_barge_ai_at_node("temp_spawn_front_right", 3);

  for(i = 0; i < a_ai.size; i++) {
    a_ai[i] setgoalnode(a_top_deck[i]);
    a_ai[i] thread shoot_at_target_untill_dead(vh_heli);
    a_ai[i].script_noteworthy = "barge_intro_ai";
  }

  a_ai = maps\angola_barge::spawn_barge_ai_at_node("temp_spawn_back_right", 2);
  a_ai = arraycombine(a_ai, maps\angola_barge::spawn_barge_ai_at_node("temp_spawn_back_left", 2), 1, 0);

  for(i = 0; i < a_ai.size; i++) {
    a_ai[i] setgoalpos(a_ai[i].origin);
    a_ai[i] thread shoot_at_target_untill_dead(vh_heli);
    a_ai[i].script_noteworthy = "barge_intro_ai";
  }

  level waittill("stop_firing_bullets_at_heli");
  a_ai = array_removedead(a_ai);

  for(i = 0; i < a_ai.size; i++) {
    a_ai[i] thread barge_intro_ai_fallback(a_bottom[i]);
    wait(randomfloatrange(0.0, 0.5));
  }
}

barge_intro_ai_fallback(nd_goto) {
  self endon("death");
  self stop_shoot_at_target();
  self.fixednode = 1;
  self setgoalnode(nd_goto);
  level waittill("river_heli_delete");
  self.fixednode = 0;
  self.cansee_override = 1;
}

setup_dyn_ents() {
  dyn_ent_spawn = getent("place_dyn_ent", "targetname");
  dyn_ent_spawn linkto(level.main_barge);
  dyn_ent_spawn setclientflag(9);
  level waittill("place_dyn_ents");
  level clientnotify("unlink_box");
  wait 0.05;
  physicsjolt(dyn_ent_spawn.origin, 10000, 1000, vectorscale((1, 1, 1), 0.01));
}

setup_small_boat(start_node, start_path_delay, path_fixed_offset) {
  self endon("death");
  vh_heli = getent("river_player_heli", "targetname");
  self thread fire_weapon_on_target(vh_heli);
  self thread boat_river_bob();
  self.dont_kill_riders = 1;

  if(isDefined(path_fixed_offset)) {
    self.spline_offset = path_fixed_offset[1];
    self pathfixedoffset(path_fixed_offset);
  }

  if(isDefined(start_node)) {
    if(isDefined(start_path_delay))
      wait(start_path_delay);

    self thread go_path(start_node);
  }
}

rear_convoy_boat_death_monitor(boat1, boat2, death_notify) {
  boats = [];

  if(isDefined(boat1))
    boats[boats.size] = boat1;

  if(isDefined(boat2))
    boats[boats.size] = boat2;

  array_wait(boats, "death");
  level notify(death_notify);
}

fire_weapon_on_heli(str_notify, vh_heli) {
  if(!isDefined(vh_heli))
    vh_heli = undefined;

  self endon("death");
  guards = simple_spawn("main_convoy_escort_boat_medium_1_guard", ::guard_setup);

  if(!isDefined(vh_heli))
    vh_heli = getent("river_player_heli", "targetname");

  if(isDefined(guards[0]))
    guards[0] enter_vehicle(self, "tag_gunner1");

  if(isDefined(guards[1]))
    guards[1] enter_vehicle(self, "tag_gunner2");

  if(isDefined(str_notify))
    level waittill("str_notify");

  self maps\_turret::set_turret_target(vh_heli, vectorscale((0, 0, -1), 40.0), 1);
  self maps\_turret::set_turret_target(vh_heli, vectorscale((0, 0, -1), 40.0), 2);

  while(true) {
    if(isalive(guards[0]))
      self thread maps\_turret::fire_turret_for_time(1, 1);
    else
      self maps\_turret::clear_turret_target(1);

    if(isalive(guards[1]))
      self thread maps\_turret::fire_turret_for_time(1, 2);
    else
      self maps\_turret::clear_turret_target(2);

    if(!isalive(guards[0]) && !isalive(guards[1])) {
      break;
    }

    wait 1;
  }
}

fire_weapon_on_ent(str_notify, ent) {
  self endon("death");
  guards = simple_spawn("main_convoy_escort_boat_medium_1_guard");

  if(isDefined(guards[0]))
    guards[0] enter_vehicle(self, "tag_gunner1");

  if(isDefined(guards[1]))
    guards[1] enter_vehicle(self, "tag_gunner2");

  if(isDefined(str_notify))
    level waittill("str_notify");

  self maps\_turret::set_turret_target(ent, vectorscale((0, 0, -1), 40.0), 1);
  self maps\_turret::set_turret_target(ent, vectorscale((0, 0, -1), 40.0), 2);

  while(true) {
    if(isalive(guards[0]))
      self thread maps\_turret::fire_turret_for_time(1, 1);
    else
      self maps\_turret::clear_turret_target(1);

    if(isalive(guards[1]))
      self thread maps\_turret::fire_turret_for_time(1, 2);
    else
      self maps\_turret::clear_turret_target(2);

    if(!isalive(guards[0]) && !isalive(guards[1])) {
      break;
    }

    wait 1;
  }
}

guard_setup() {
  self endon("death");
  level endon("kill_all_on_turret");
  heli_target = getent("heli_target_origin", "targetname");
  vh_heli = getent("river_player_heli", "targetname");
  self setentitytarget(vh_heli);

  if(isDefined(self.target)) {
    node = getnode(self.target, "targetname");
    self forceteleport(node.origin, node.angles);
  }
}

kill_self_if_falls() {
  self endon("death");

  while(true) {
    if(self.origin[2] < 50) {
      level.num_enemy_falls_off++;
      iprintln(level.num_enemy_falls_off);
      self die();
    }

    wait 0.5;
  }
}

update_yaw(barge) {
  while(true) {
    self setgoalyaw(barge.angles[1]);
    wait 0.5;
  }
}

play_death_fx_on_turret(boat, turret) {
  boat endon("death");
  self waittill("death");

  if(isDefined(boat))
    playfxontag(level._effect["turret_explosion"], boat, turret);
}

obj_fail_if_truck_takes_damage() {
  while(true) {
    self waittill("trigger", ent);

    if(ent == level.player) {
      gaz_truck = getent("gaz_trucks", "script_noteworthy");
      playfxontag(level._effect["ship_explosion"], gaz_truck, "tag_origin");
      playfxontag(level._effect["ship_fire"], gaz_truck, "tag_origin");
      wait 2;
      missionfailedwrapper(&"ANGOLA_2_TRUCK_DESTROY");
    }

    wait 0.5;
  }
}

boat_adjusting() {
  level.escort_boat thread boat_swaying();
  level.escort_boat_2 thread boat_swaying();
  level.escort_boat_4 thread boat_swaying();
  wait 1;

  for(i = 0; i < level.escort_boat_small.size; i++) {
    level.escort_boat_small[i] thread boat_swaying();
    wait 1;
  }
}

boat_swaying() {
  self endon("kill_sway");
  self endon("death");

  while(true) {
    num = 150;
    self set_boat_swaying(num);
    self set_boat_swaying(num * -1);
    self set_boat_swaying(num * -1);
    self set_boat_swaying(num);
  }
}

set_boat_swaying(num) {
  self endon("kill_sway");
  self endon("death");
  moverate = num / 60;
  movement = 0;

  for(i = 0; i < 60; i++) {
    movement = movement + moverate;
    self pathfixedoffset((0, self.spline_offset + movement, 0));
    wait 0.05;
  }

  self.spline_offset = self.spline_offset + movement;
}

attach_all_origin_to_boat() {
  a_origin = getentarray("convoy_spawn_spot", "script_noteworthy");
  main_barge = getent("main_barge", "targetname");

  for(i = 0; i < a_origin.size; i++)
    a_origin[i] linkto(main_barge);
}

set_threat_bias_group_for_barge_ai() {
  createthreatbiasgroup("barge_ai");
  createthreatbiasgroup("hudson");
  createthreatbiasgroup("player");
  level.player setthreatbiasgroup("player");
  level.hudson setthreatbiasgroup("hudson");

  foreach(ai in level.main_barge_guard) {
    if(isDefined(ai) && isalive(ai))
      ai setthreatbiasgroup("barge_ai");
  }

  setthreatbias("hudson", "barge_ai", 2000);
  setthreatbias("barge_ai", "hudson", 2000);
  setthreatbias("player", "barge_ai", -2000);
  setthreatbias("barge_ai", "player", -2000);
}

#using_animtree("vehicles");

strella_guard_run() {
  spawners = getent("river_barge_convoy_2_guards_assault", "targetname");
  start_node = getnode("strella_guard_start", "targetname");
  strella_guard = simple_spawn_single(spawners);
  strella_guard.animname = "strella_guy";
  strella_guard forceteleport(start_node.origin, start_node.angles);
  gaz66 = getent("strella_truck", "targetname");
  gaz66 useanimtree(#animtree);
  gaz66 setanim( % v_ang_05_03_ghaz_cargo_open_cargo, 1, 0, 1);
}

clear_all_guards_on_medium_boat() {
  level notify("kill_all_on_turret");
  guards = get_ai_array("main_convoy_escort_boat_medium_1_guard_ai", "targetname");

  for(i = 0; i < guards.size; i++) {
    guards[i] die();
    guards[i] delete();
  }

  guards = get_ai_array("main_convoy_escort_boat_medium_2_guard_ai", "targetname");

  for(i = 0; i < guards.size; i++) {
    guards[i] die();
    guards[i] delete();
  }

  guards = get_ai_array("main_convoy_escort_boat_medium_3_guard_ai", "targetname");

  for(i = 0; i < guards.size; i++) {
    guards[i] die();
    guards[i] delete();
  }

  guards = get_ai_array("main_convoy_escort_boat_medium_4_guard_ai", "targetname");

  for(i = 0; i < guards.size; i++) {
    guards[i] die();
    guards[i] delete();
  }

  guards = get_ai_array("river_barge_convoy_2_guards_launcher_ai", "targetname");

  for(i = 0; i < guards.size; i++) {
    guards[i] die();
    guards[i] delete();
  }
}

make_guards_fire_on_boat() {
  fire_origin = getentarray("fake_fire_origin", "targetname");

  for(i = 0; i < 50; i++) {
    magicbullet("m60_sp", fire_origin[fire_origin.size].origin, level.hudson.origin + vectorscale((0, 0, 1), 40.0));
    wait(randomfloatrange(0.3, 0.5));
  }
}

explosive_death() {
  self waittill("death");
  guard = simple_spawn_single("river_barge_convoy_2_guards_assault");
  guard.animname = "chase_boat_gunner_front";
  guard thread anim_single(guard, "front_death");
}

cleanup_river_intro_barge() {
  e_trash = getentarray("river_boat_intro_cleanup", "script_noteworthy");

  for(i = 0; i < e_trash.size; i++) {
    e_trash[i] die();

    if(isDefined(e_trash[i]))
      e_trash[i] delete();
  }
}

cleanup_river_intro_boats() {
  e_trash = getentarray("river_boat_cleanup", "script_noteworthy");

  for(i = 0; i < e_trash.size; i++)
    e_trash[i] notify("death");
}

cleanup_river_lance_trash() {
  e_trash = getentarray("river_boats_lance_cleanup", "script_noteworthy");

  for(i = 0; i < e_trash.size; i++) {
    e_trash[i] notify("death");
    e_trash[i] delete();
  }
}

delete_all_corpse() {
  level endon("hind_crash");

  while(true) {
    wait 20;
    clearallcorpses();
  }
}

trigger_gun_flak() {
  level endon("heli_ride_done");

  while(true) {
    flak_spot = get_flak_spot();
    type = randomint(100);

    if(type < 40)
      playfx(level._effect["medium_flak"], flak_spot);
    else if(type > 60)
      playfx(level._effect["small_flak"], flak_spot);
    else
      playfx(level._effect["large_flak"], flak_spot);

    wait 0.7;
  }
}

get_flak_spot() {
  main_barge = getent("main_barge", "targetname");
  x = main_barge.origin[0] + randomintrange(-1500, 1500);
  y = main_barge.origin[1] + randomintrange(-1500, 1500);
  z = main_barge.origin[2] + randomintrange(500, 1000);
  fx_spot = (x, y, z);
  return fx_spot;
}

setup_specialty_perk() {
  boat = getent("main_convoy_escort_boat_medium_1", "targetname");
  boat attach("veh_t6_sea_gunboat_medium_waterbox", "tag_origin");
  specialty_trigger = getent("player_turret_special_trigger", "targetname");
  specialty_trigger enablelinkto();
  specialty_trigger linkto(boat);
  specialty_trigger setcursorhint("HINT_NOICON");
  specialty_trigger sethintstring("");
  level waittill("heli_ride_done");
  level.escort_boat setseatoccupied(2, 1);
  level.player waittill_player_has_brute_force_perk();
  e_obj_location = spawn("script_model", boat gettagorigin("tag_gunner2") + vectorscale((0, 0, 1), 60.0));
  e_obj_location setmodel("tag_origin");
  e_obj_location linkto(boat);
  set_objective(level.obj_brute_force, e_obj_location, "interact");
  specialty_trigger sethintstring(&"ANGOLA_2_UNJAM_GUN");
  specialty_trigger waittill("trigger");
  set_objective(level.obj_brute_force, e_obj_location, "remove");
  run_scene("player_unlock_gun");
  level.escort_boat setseatoccupied(2, 0);
  specialty_trigger delete();
  boat usevehicle(level.player, 2);
  damage_trigger = getent("player_turret_damage_trigger", "targetname");

  while(isDefined(boat)) {
    if(isDefined(boat getseatoccupant(2))) {
      damage_trigger waittill("trigger", amount, attacker, vec);
      level.player dodamage(10, (0, 0, 0));
    }

    wait 0.1;
  }
}

play_damage_fx_on_boat() {
  self endon("death");
  count = 0;
  str_boattype = self.targetname == "mediumboat_01" ? "medium" : "small";

  while(true) {
    self waittill("damage", amount, attacker, vec, p, type);

    if((type == "MOD_GRENADE" || type == "MOD_PROJECTILE" || type == "MOD_EXPLOSIVE" || self.health < self.healthmax * 0.5) && count == 0) {
      playfxontag(level._effect[str_boattype + "_boat_damage_1"], self, "tag_origin");
      count++;
    } else if((type == "MOD_GRENADE" || type == "MOD_PROJECTILE" || type == "MOD_EXPLOSIVE") && count == 1) {
      count++;
      return;
    }

    wait 0.5;
  }
}

chase_sequence_fail_state(time) {
  level endon("player_ram_boat_start");
  wait 120;
  missionfailedwrapper(&"ANGOLA_2_CHASE_BOAT_FAIL");
}

voice_over_river() {
  wait 3;
  level.hudson say_dialog("huds_comin_on_the_convoy_0");
  wait 3;
  level.hudson say_dialog("maso_the_barge_matches_sa_0");
  level.player say_dialog("maso_bring_us_closer_0");
  level.hudson say_dialog("huds_dammit_we_re_taking_0");
}

boat_river_bob() {
  self pathvariableoffset(vectorscale((0, 0, 1), 100.0), randomfloatrange(0.75, 1.25));
}

boat_river_bob_spline() {
  self pathvariableoffset(vectorscale((0, 0, 1), 20.0), randomfloatrange(0.75, 1.25));
}

actor_turret_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(sweapon == "pbr_gun_turret")
    idamage = 0;

  team = eattacker.team;

  if(isDefined(team) && team == "axis")
    idamage = 0;

  return idamage;
}

hind_go_to_position_and_hold(destination) {
  self endon("death");
  level endon("hind_crash");
  level endon("player_control_hind");

  while(true) {
    level.river_hind setvehgoalpos(destination.origin, 0);
    wait 0.05;
  }
}