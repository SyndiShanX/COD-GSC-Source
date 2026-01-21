/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_streets.gsc
*****************************************************/

section_main() {
  maps\_utility::add_hint_string("launcher_qte", &"FLOOD_LAUNCHER_MELEE", ::mlrs_stop_qte_hint);
}

section_precache() {
  precachemodel("vehicle_silenthawk_wings");
  precacheitem("rpg_straight");
  precacherumble("artillery_rumble");
  precacherumble("heavy_1s");
  precacherumble("heavy_2s");
  precachemodel("viewhands_player_gs_flood");
  precachemodel("vehicle_m880_launcher_obj");
  precachemodel("com_trafficcone02");
  precachemodel("flood_light_generator");
  precachestring(&"SCRIPT_PLATFORM_BREACH_ACTIVATE");
  precachestring(&"FLOOD_DISABLE_LAUNCHER");
  precacheshellshock("default");
  precacheshader("flood_ui_vignette");
}

section_flag_inits() {
  common_scripts\utility::flag_init("looked_at_missiles");
  common_scripts\utility::flag_init("missiles_fired");
  common_scripts\utility::flag_init("missiles_ready");
  common_scripts\utility::flag_init("looked_at_missiles_failsafe");
  common_scripts\utility::flag_init("start_flood");
  common_scripts\utility::flag_init("level_faded_to_black");
  common_scripts\utility::flag_init("end_of_dam");

  if(!common_scripts\utility::flag_exist("player_on_ladder"))
    common_scripts\utility::flag_init("player_on_ladder");

  common_scripts\utility::flag_init("streets_to_dam_enemies_dead");
  common_scripts\utility::flag_init("streets_to_dam_enemies_ALMOST_dead");
  common_scripts\utility::flag_init("streets_to_dam_enemies_last_guy");
  common_scripts\utility::flag_init("enemy_advance");
  common_scripts\utility::flag_init("allies_shot_at");
  common_scripts\utility::flag_init("enemy_alerted");
  common_scripts\utility::flag_init("enemy_surprised");
  common_scripts\utility::flag_init("everyone_in_garage");
  common_scripts\utility::flag_init("baker_move_up");
  common_scripts\utility::flag_init("baker_anim_done");
  common_scripts\utility::flag_init("player_ready_to_progress");
  common_scripts\utility::flag_init("rpg_spawn");
  common_scripts\utility::flag_init("see_convoy");
  common_scripts\utility::flag_init("player_move_up");
  common_scripts\utility::flag_init("missile_launcher_in_place");
  common_scripts\utility::flag_init("missile_launcher_destruction_done");
  common_scripts\utility::flag_init("convoy_gone");
  common_scripts\utility::flag_init("start_cover_fire");
  common_scripts\utility::flag_init("rpg_fired_at_launcher");
  common_scripts\utility::flag_init("close_to_checkpoint");
  common_scripts\utility::flag_init("start_heli_attack");
  common_scripts\utility::flag_init("vignette_lens");
  common_scripts\utility::flag_init("vignette_lens_fade_out");
  common_scripts\utility::flag_init("spawn_m880");
  common_scripts\utility::flag_init("m880_has_spawned");
  common_scripts\utility::flag_init("enemy_tank_2_firing_at_player");
  common_scripts\utility::flag_init("grenade_thrown");
  common_scripts\utility::flag_init("played_radio_part_1");
  common_scripts\utility::flag_init("played_radio_part_2");
  common_scripts\utility::flag_init("player_out_of_garage");
  common_scripts\utility::flag_init("player_looking_away");
  common_scripts\utility::flag_init("launcher_objective_given");

  if(!common_scripts\utility::flag_exist("launcher_2_objective_given"))
    common_scripts\utility::flag_init("launcher_2_objective_given");
}

test_tracer_fire(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getstruct(var_1, "targetname");

  while(!isDefined(var_3)) {
    var_3 = common_scripts\utility::getstruct(var_1, "targetname");
    wait 0.1;
  }

  var_4 = common_scripts\utility::getstruct(var_2, "targetname");

  while(!isDefined(var_4)) {
    var_4 = common_scripts\utility::getstruct(var_2, "targetname");
    wait 0.1;
  }

  for(;;) {
    fire_at_target(var_3.origin, var_4.origin, 1, level.player, var_0);
    wait 0.5;
  }
}

hide_missile_launcher_collision() {
  var_0 = getEntArray("missile_launcher_collision", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
    var_2 notsolid();
  }
}

show_missile_launcher_collision() {
  common_scripts\utility::flag_wait("missile_launcher_in_place");
  wait 1.0;
  var_0 = getEntArray("missile_launcher_collision", "targetname");

  foreach(var_2 in var_0) {
    var_2 show();
    var_2 solid();
  }
}

enemy_init() {
  var_0 = common_scripts\utility::getstruct("heli_start_firing_1", "script_noteworthy");
  var_0 waittill("trigger");
  wait 2.0;
}

infil_heli_anim_skip() {
  var_0 = maps\_utility::getanim("infil");
  var_1 = getnotetracktimes(var_0, "infil_heli_takeoff")[0];
  common_scripts\utility::delaycall(0.05, ::setanimtime, var_0, var_1);
}

notify_with_trigger_targetname(var_0, var_1) {
  var_2 = getent(var_1, "targetname");
  var_2 waittill("trigger");
  self notify(var_0);
}

draw_turret_target_line() {
  self endon("death");

  for(;;) {
    var_0 = self getturrettarget(0);

    if(isDefined(var_0))
      thread common_scripts\utility::draw_line_for_time(self.origin, var_0.origin, 1, 0, 0, 0.1);

    wait 0.1;
  }
}

rumble_when_tank_breaks_wall() {
  wait 0.1;
  level.player playrumbleonentity("artillery_rumble");
}

fake_tank_rumble() {
  self endon("death");

  for(;;) {
    level.player playrumbleonentity("tank_rumble");
    wait 0.1;
  }
}

destroy_planter(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.targetname) && var_3.targetname == "planter_trigger")
      var_3 notify("trigger");
  }
}

destroy_corner() {
  var_0 = getEntArray("corner_exploder_trigger", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 notify("trigger");
}

kill_ally_in_volume(var_0) {
  var_1 = getaiarray("allies");

  foreach(var_3 in var_1) {
    if(var_3 istouching(var_0)) {
      if(!maps\_utility::is_in_array(level.allies, var_3)) {
        if(isDefined(var_3.magic_bullet_shield) && var_3.magic_bullet_shield)
          var_3 maps\_utility::stop_magic_bullet_shield();

        var_3 kill();
      }
    }
  }
}

run_faster_behavior(var_0) {
  if(var_0) {
    self.animplaybackrate = 1.2;
    self.moveplaybackrate = 1.2;
    self.movetransitionrate = 1.2;
  } else {
    self.animplaybackrate = randomfloatrange(0.9, 1.1);
    self.moveplaybackrate = 1.0;
    self.movetransitionrate = randomfloatrange(0.9, 1.1);
  }
}

converge_on_target(var_0, var_1, var_2) {
  self endon("new_converge");
  self cleartargetentity();
  self settargetentity(var_0);

  for(;;) {
    var_3 = distance2d(var_1.origin, var_0.origin);

    if(var_3 < 0)
      var_3 = abs(var_3);

    if(var_3 == 0)
      var_3 = 1;

    var_4 = var_3 / var_2;
    var_0 moveto(var_1.origin + (0, 0, 16), var_4);
    wait 0.1;
  }
}

fire_turret(var_0) {
  self endon("stop_firing");
  self endon("death");
  var_1 = 5;
  var_2 = 15;
  var_3 = 1.0;
  var_4 = 1;
  var_5 = 5;
  var_6 = 0;
  self startfiring();

  for(;;) {
    if(var_0) {
      if(var_4) {
        var_5 = randomfloatrange(var_1, var_2);
        var_6 = 0;
        var_4 = 0;
      }

      if(var_6 >= var_5) {
        var_4 = 1;
        wait(randomfloat(var_3));
      }
    }

    self shootturret();
    var_6 = var_6 + 1;
    wait 0.1;
  }
}

player_forward_skip_baker_hold_up() {
  var_0 = getent("hold_up_check", "targetname");
  var_0 waittill("trigger");
  common_scripts\utility::flag_set("player_move_up");
}

set_group_goalvolume(var_0) {
  var_1 = self;
  var_2 = getent(var_0, "targetname");

  foreach(var_4 in var_1) {
    var_4 cleargoalvolume();
    var_4 setgoalvolumeauto(var_2);
  }
}

fire_at_target(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("stop_the_shooting");
  var_6 = 0;
  var_7 = 64;
  var_8 = 0.08;
  var_9 = 0.11;
  var_10 = 0.5;
  var_11 = 1;
  var_12 = 9;
  var_13 = 15;
  var_14 = randomintrange(var_12, var_13);

  for(var_15 = 0; var_15 < var_14; var_15++) {
    if(isDefined(var_5) && var_5) {
      var_16 = var_0.origin;
      var_17 = var_1.origin;
    } else {
      var_16 = var_0;
      var_17 = var_1;
    }

    var_18 = 0;

    if(isDefined(var_2) && var_2) {
      var_19 = var_17[0] + randomintrange(var_6, var_7);
      var_20 = var_17[1] + randomintrange(var_6, var_7);
      var_21 = var_17[2] + randomintrange(var_6, var_7) / 2;
    } else {
      var_19 = var_17[0];
      var_20 = var_17[1];
      var_21 = var_17[2];
    }

    var_22 = (var_19, var_20, var_21);

    if(isDefined(var_3)) {
      if(!isarray(var_3))
        var_3 = maps\_utility::make_array(var_3);

      var_23 = bulletTrace(var_16, var_22, 1);
      var_24 = var_23["entity"];

      if(isDefined(var_24)) {
        for(var_15 = 0; var_15 < var_3.size; var_15++) {
          if(var_24 == var_3[var_15])
            var_18 = 1;
        }

        if(var_18)
          continue;
      }
    }

    if(var_18) {}

    if(isDefined(var_4))
      magicbullet(var_4, var_16, var_22);
    else {
      var_25 = level.player getcurrentweapon();

      if(isDefined(var_25) && var_25 != "none")
        magicbullet(var_25, var_16, var_22);
    }

    wait(randomfloatrange(var_8, var_9));
  }

  wait(randomfloatrange(var_10, var_11));
}

turret_fire_at_target(var_0, var_1, var_2, var_3, var_4) {
  level endon("stop_the_shooting");
  var_5 = 0;
  var_6 = 64;
  var_7 = 0.08;
  var_8 = 0.11;
  var_9 = 0.5;
  var_10 = 1;
  var_11 = 9;
  var_12 = 15;
  var_13 = randomintrange(var_11, var_12);

  for(var_14 = 0; var_14 < var_13; var_14++) {
    var_15 = self gettagorigin(var_0);
    var_16 = var_1.origin;
    var_17 = 0;

    if(isDefined(var_2) && var_2) {
      var_18 = var_16[0] + randomintrange(var_5, var_6);
      var_19 = var_16[1] + randomintrange(var_5, var_6);
      var_20 = var_16[2] + randomintrange(var_5, var_6) / 2;
    } else {
      var_18 = var_16[0];
      var_19 = var_16[1];
      var_20 = var_16[2];
    }

    var_21 = (var_18, var_19, var_20);

    if(isDefined(var_3)) {
      if(!isarray(var_3))
        var_3 = maps\_utility::make_array(var_3);

      var_22 = bulletTrace(var_15, var_21, 1);
      var_23 = var_22["entity"];

      if(isDefined(var_23)) {
        for(var_14 = 0; var_14 < var_3.size; var_14++) {
          if(var_23 == var_3[var_14])
            var_17 = 1;
        }

        if(var_17)
          continue;
      }
    }

    if(var_17) {}

    if(isDefined(var_4))
      magicbullet(var_4, var_15, var_21);
    else {
      var_24 = level.player getcurrentweapon();

      if(isDefined(var_24) && var_24 != "none")
        magicbullet(var_24, var_15, var_21);
    }

    wait(randomfloatrange(var_7, var_8));
  }

  wait(randomfloatrange(var_9, var_10));
}

set_goal_volume(var_0) {
  self setgoalvolumeauto(var_0);
}

streets_to_dam_start() {
  level.street_start_allies = [];
  maps\flood_util::player_move_to_checkpoint_start("streets_to_dam_start");
  maps\flood_util::spawn_allies();
  level thread enter_garage();
  level thread garage_opening_collapse();
  level thread aim_missiles_2();
  level thread hide_missile_launcher_collision();
  level thread hide_garage_debris();
  level thread maps\flood_infil::kill_player_with_tanks("streets_beyond_enemy_tank_2");
  level thread maps\flood_infil::setup_dead_destroyed_and_misc();
  level thread hide_spire();
  level thread init_turn_off_lean_volumes();
  level thread maps\flood_util::flood_battlechatter_on(1);
  common_scripts\utility::flag_set("everyone_in_garage");
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
}

streets_to_dam() {
  level thread adjust_ally_movement();
  level thread convoy_think();
  level thread streets_to_dam_sequence();
  level thread streets_to_dam_wave_1_init();
  level thread streets_to_dam_drive_missile_launcher();
  level thread wait_for_player_to_use_ladder();
  level thread spawn_rpg_guys();
  level thread dialogue_streets_to_dam();
  level thread make_allies_shoot_at_targets();
  level thread disable_combat_nodes();
  level thread disable_ally_nag_nodes();
  level thread hide_unhide_crashed_convoy(1);
  level thread convoy_kill_player();
  level thread block_garage_exit();
  level thread garage_autosave_before_heli_attack();
  level thread rotate_checkpoint_concrete_barrier_when_near_m880(210);
  level thread maps\flood_infil::nh90_convoy_choppers();
  level thread m880_open_path_init();
  level thread m880_connect_path_nodes(0);
  level thread maps\flood_anim::m880_crash_anim_init();
  level thread m880_kill_collision_change();
  level thread manage_mantles();
  common_scripts\utility::exploder("dam_pre_waterfall");
  common_scripts\utility::flag_wait("player_on_ladder");
  wait 2.0;
  level thread streets_to_dam_2_side_guys_spawn_logic();
  var_0 = getent("streets_to_dam_wave_2_start", "targetname");
  var_0 waittill("trigger");
  level notify("end_of_streets_to_dam");
}

enter_garage() {
  level endon("firing_garage_shot");
  var_0 = getent("into_parking_garage", "targetname");

  if(isDefined(var_0))
    var_0 waittill("trigger");

  if(isDefined(level.enemy_tank_3)) {
    level.enemy_tank_3 notify("stop_firing");
    level notify("stop_shooting_player");
    level.enemy_tank_3 maps\_vehicle::mgoff();
    var_1 = getent("enemy_tank_2_garage_target", "targetname");
    level.enemy_tank_3 setturrettargetvec(var_1.origin);
    var_0 = getent("parking_garage_doorway", "targetname");

    if(isDefined(var_0))
      var_0 waittill("trigger");

    wait 0.5;
    level thread turret_too_slow_failsafe();
    level.player enableinvulnerability();
    level.enemy_tank_3 maps\flood_infil::fire_cannon_at_target(var_1, 1);
  } else
    wait 1.0;

  level thread garage_player_invulnerable();
  level notify("firing_garage_shot");
}

garage_player_invulnerable() {
  wait 1.0;
  level.player disableinvulnerability();
  wait 1.0;
}

turret_too_slow_failsafe() {
  level endon("firing_garage_shot");
  var_0 = getent("player_far_enough_in_garage", "targetname");

  if(isDefined(var_0))
    var_0 waittill("trigger");

  level.enemy_tank_3 fireweapon();
  level.enemy_tank_3 notify("stop_firing");
  level notify("firing_garage_shot");
}

garage_opening_collapse() {
  level waittill("firing_garage_shot");

  if(isDefined(level.enemy_tank_3))
    level.enemy_tank_3 playSound("flood_t90_sweetener");

  wait 0.5;
  thread teleport_allies_on_flag();
  var_0 = level.player getplayerangles();
  var_1 = anglesToForward(var_0);
  level thread maps\flood_infil::kill_infil_enemies();
  playFX(level._effect["tank_concrete_explosion_omni"], level.player.origin, var_1);
  var_2 = getent("garage_collapse_fx_node", "targetname");
  playFX(level._effect["tank_concrete_explosion_omni"], var_2.origin + (-50, 100, 0), (-1, 2, 0));
  playFX(level._effect["garage_explosion_flash"], level.player.origin);
  level.player shellshock("default_nosound", 3);
  level thread slow_player_down(4);
  thread stumble_and_quake();
  wait 0.1;
  make_player_look_away("garage_collapse_back_look_check", (45, 135, 0), 0.15, 0);
  thread show_garage_debris();
  thread maps\flood_audio::sfx_parking_lot_explode();
  level.player playrumbleonentity("heavy_2s");
  common_scripts\utility::exploder("garage_dust");
  var_3 = getent("garage_collapse_push_volume", "targetname");
  var_4 = (-20, 20, 0);
  push_player_out_of_volume(var_3, var_4);

  if(isalive(level.enemy_tank_3)) {
    var_5 = getent("enemy_tank_3_post_garage_target", "targetname");
    level.enemy_tank_3 setturrettargetent(var_5);
    level.enemy_tank_3.mgturret[1] cleartargetentity();
    var_6 = getent("enemy_tank_3_post_garage_backup", "targetname");
    level.enemy_tank_3 startpath();
    level.enemy_tank_3 vehicle_setspeed(40);
    level.enemy_tank_3 common_scripts\utility::delaycall(0.5, ::vehicle_setspeed, 0);
  }

  make_player_look_away("garage_collapse_back_look_check", (45, 135, 0), 0.15, 0);
  common_scripts\utility::flag_set("player_looking_away");
  common_scripts\utility::flag_set("everyone_in_garage");
  common_scripts\utility::flag_set("player_ready_to_progress");
  wait 0.1;
  thread maps\_utility::autosave_by_name("garage_collapse");
}

teleport_allies_on_flag() {
  common_scripts\utility::flag_wait("player_looking_away");
  var_0 = getent("inside_garage_volume", "targetname");
  var_1[0] = getent("streets_to_dam_ally_0_failsafe", "targetname");
  var_1[1] = getent("streets_to_dam_ally_1_failsafe", "targetname");
  var_1[2] = getent("streets_to_dam_ally_2_failsafe", "targetname");

  for(var_2 = 0; var_2 < level.allies.size; var_2++) {
    if(!level.allies[var_2] istouching(var_0)) {
      var_3 = var_1[var_2];
      level.allies[var_2] forceteleport(var_3.origin, var_3.angles);
    }
  }
}

push_player_out_of_volume(var_0, var_1) {
  while(level.player istouching(var_0)) {
    level.player pushplayervector(var_1, 1);
    common_scripts\utility::waitframe();
  }

  level.player pushplayervector((0, 0, 0));
}

stumble_and_quake() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.angles = (0, 0, 0);
  level.player playersetgroundreferenceent(var_0);
  var_1 = common_scripts\utility::spawn_tag_origin();
  earthquake(0.25, 4, level.player.origin, 5000);
  var_2 = var_0.angles;
  var_1.angles = var_0.angles;
  var_1 addpitch(10);
  var_1 addroll(5);
  var_3 = 0.4;
  var_0 rotateto(var_1.angles, var_3, 0.2, 0.2);
  wait(var_3);
  var_1 addpitch(-5);
  var_1 addroll(-5);
  var_0 rotateto(var_1.angles, 0.1);
  wait 0.1;
  var_1 addpitch(5);
  var_1 addroll(5);
  var_0 rotateto(var_1.angles, 0.1);
  wait 0.1;
  var_1 addpitch(-35);
  var_1 addroll(-15);
  var_0 rotateto(var_1.angles, var_3, 0.2, 0.2);
  wait(var_3);
  var_0 rotateto(var_2, var_3 + 0.1, 0.2, 0.2);
}

adjust_angles_to_player(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[2];
  var_3 = anglestoright(self.angles);
  var_4 = anglesToForward(self.angles);
  var_5 = (var_3[0], 0, var_3[1] * -1);
  var_6 = (var_4[0], 0, var_4[1] * -1);
  var_7 = var_5 * var_1;
  var_7 = var_7 + var_6 * var_2;
  return var_7 + (0, var_0[1], 0);
}

find_teleport_spot_for_ally(var_0, var_1) {
  while(var_1 < var_0.size) {
    var_2 = var_0[var_1];

    if(isDefined(var_2)) {
      if(distance2d(level.player.origin, var_2.origin) > 32) {
        if(!maps\_utility::player_looking_at(var_2.origin + (0, 0, 16), 0.5, 1))
          return var_1;
        else {}
      } else {}
    } else {}

    var_1++;
  }

  return -1;
}

player_vision_blind(var_0) {
  var_1 = getdvar("vision_set_current");
  visionsetnaked("generic_flash", 0.2);
  wait(var_0);
  visionsetnaked(var_1, 0.2);
}

make_player_look_away(var_0, var_1, var_2, var_3) {
  var_4 = getEntArray(var_0, "targetname");
  var_5 = 0;

  foreach(var_7 in var_4) {
    if(maps\_utility::player_looking_at(var_7.origin))
      var_5 = 1;
  }

  if(var_3 || var_5) {
    var_9 = spawn("script_origin", (0, 0, 0));
    var_9.origin = level.player.origin;
    var_9.angles = level.player getplayerangles();
    level.player playerlinkto(var_9, "", 1.0);
    var_9 rotateto(var_1, var_2, var_2 * 0.25);
    wait(var_2 / 2);
    wait(var_2 / 2);
    var_9 delete();
  }
}

slow_player_down(var_0) {
  level.player setmovespeedscale(0.5);
  wait(var_0);
  level.player setmovespeedscale(0.75);
  wait(var_0 / 2);
  level.player setmovespeedscale(1.0);
}

hide_garage_debris() {
  var_0 = getEntArray("garage_debris", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] hide();
    var_0[var_1] notsolid();
  }

  wait 1.0;
  var_2 = getnodearray("garage_opening_path_node", "targetname");

  for(var_1 = 0; var_1 < var_2.size; var_1++)
    var_2[var_1] connectnode();
}

show_garage_debris() {
  wait 0.5;
  var_0 = getEntArray("garage_debris", "targetname");
  var_1 = getEntArray("garage_debris_origin", "targetname");

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(level.player istouching(var_0[var_2]))
      var_0[var_2] maps\flood_anim::push_player_out_of_brush((0, 40, 0));

    var_0[var_2] show();
    var_0[var_2] solid();
  }
}

adjust_ally_movement() {
  level.allies[1] maps\_utility::set_force_color("p");
  level.allies[2] maps\_utility::set_force_color("r");

  foreach(var_1 in level.allies)
  var_1 ignore_everything(0.0);

  common_scripts\utility::flag_wait("everyone_in_garage");
  level thread set_flag_when_player_ready_to_progress("player_ready_to_progress");
  common_scripts\utility::flag_wait("player_ready_to_progress");
  level.allies[0] thread send_ally_to_garage_node("ally_garage_path_0", "ally_garage_path_0_skip");
  var_3 = undefined;
  var_4 = getent("past_traversal_volume", "targetname");

  for(var_5 = 2; var_5 > 0; var_5--) {
    if(level.allies[var_5] istouching(var_4)) {
      if(isDefined(var_3)) {
        if(level.allies[var_5].origin[0] < var_3.origin[0])
          var_3 = level.allies[var_5];

        continue;
      }

      var_3 = level.allies[var_5];
    }
  }

  if(isDefined(var_3) && var_3 == level.allies[1]) {
    level.allies[2] thread send_ally_to_garage_node("ally_garage_path_1", "ally_garage_path_1_skip");
    level.allies[1] thread send_ally_to_garage_node("ally_garage_path_2", "ally_garage_path_2_skip");
  } else {
    level.allies[1] thread send_ally_to_garage_node("ally_garage_path_1", "ally_garage_path_1_skip");
    level.allies[2] thread send_ally_to_garage_node("ally_garage_path_2", "ally_garage_path_2_skip");
  }

  common_scripts\utility::flag_wait("everyone_in_garage");
  wait 1.0;
  var_6 = [];
  var_6[var_6.size] = "run_stumble";
  var_6[var_6.size] = "run_flinch";
  var_6[var_6.size] = "run_duck";

  foreach(var_8, var_1 in level.allies) {
    var_1 thread stumble_anim(var_6[var_8]);
    wait(randomfloat(0.5));
  }

  var_9 = [];

  for(var_5 = 0; var_5 < level.allies.size; var_5++) {
    level.allies[var_5] pushplayer(1);
    var_9[var_5] = level.allies[var_5].moveplaybackrate;
    level.allies[var_5] maps\_utility::enable_cqbwalk();
  }

  level thread turn_off_cqb_if_player_too_far_forward();
  wait 5;

  for(var_5 = 0; var_5 < level.allies.size; var_5++)
    level.allies[var_5] pushplayer(0);

  var_10 = getent("baker_hold_up", "targetname");

  if(isDefined(var_10))
    var_10 waittill("trigger");

  level notify("stop_distance_check");

  for(var_5 = 0; var_5 < level.allies.size; var_5++) {
    level.allies[var_5] maps\_utility::disable_cqbwalk();
    level.allies[var_5] maps\_utility::disable_sprint();
    level.allies[var_5] maps\_utility::set_moveplaybackrate(var_9[var_5]);
  }

  common_scripts\utility::flag_wait("player_on_ladder");
  level.allies[1] maps\_utility::set_force_color("r");
}

send_ally_to_garage_node(var_0, var_1) {
  var_2 = getnode(var_0, "targetname");

  if(self.origin[0] < var_2.origin[0])
    var_2 = getnode(var_1, "targetname");

  thread maps\_utility::follow_path(var_2, 650);
}

set_flag_when_player_ready_to_progress(var_0) {
  var_1 = getent("player_far_enough_in_garage", "targetname");

  if(isDefined(var_1))
    var_1 waittill("trigger");

  common_scripts\utility::flag_set(var_0);
}

garage_progress_look_at_test(var_0) {
  maps\_utility::waittill_player_lookat_for_time(1.5);
  common_scripts\utility::flag_set(var_0);
}

stumble_anim(var_0) {
  var_0 = maps\_utility::getgenericanim(var_0);
  self.run_overrideanim = var_0;
  self setflaggedanimknob("stumble_run", var_0, 1, 0.2, 1, 1);
  wait 1.5;
  var_1 = maps\_utility::getgenericanim("run_root");
  var_2 = 0;

  for(;;) {
    if(self getanimtime(var_1) < var_2) {
      break;
    }

    var_2 = self getanimtime(var_1);
    wait 0.05;
  }

  self.run_overrideanim = undefined;
  self notify("movemode");
}

turn_off_cqb_if_player_too_far_forward(var_0) {
  level endon("stop_distance_check");
  var_1 = getent("streets_to_dam_autosave", "targetname");

  if(isDefined(var_1))
    var_1 waittill("trigger");

  var_2 = getent("garage_hallway_position_check", "targetname");
  var_3 = 1;

  while(var_3) {
    var_3 = 0;
    var_4 = distance2d(level.player.origin, var_2.origin);
    var_4 = var_4 - 50;

    foreach(var_6 in level.allies) {
      var_7 = distance2d(var_6.origin, var_2.origin);

      if(var_7 < var_4)
        var_3 = 1;
    }

    wait 0.1;
  }

  foreach(var_6 in level.allies)
  var_6 maps\_utility::disable_cqbwalk();
}

play_baker_anim(var_0) {
  var_0 maps\_anim::anim_single_solo(self, "ally_hold_01");
  common_scripts\utility::flag_set("baker_anim_done");
}

allies_cqbwalk(var_0) {
  if(var_0) {
    level.allies[0] maps\_utility::enable_cqbwalk(var_0);
    level.allies[1] maps\_utility::enable_cqbwalk(var_0);
    level.allies[2] maps\_utility::enable_cqbwalk(var_0);
  } else {
    level.allies[0] maps\_utility::disable_cqbwalk();
    level.allies[1] maps\_utility::disable_cqbwalk();
    level.allies[2] maps\_utility::disable_cqbwalk();
  }
}

setup_allies_streets_to_dam() {
  wait 0.5;
  var_0 = level.allies;

  foreach(var_2 in var_0)
  var_2 ally_think_streets_to_dam();
}

ally_think_streets_to_dam() {
  maps\_utility::enable_cqbwalk();
  common_scripts\utility::flag_wait("baker_move_up");
  maps\_utility::disable_cqbwalk();
}

convoy_think() {
  level.convoy = [];
  var_0 = getEntArray("enemy_convoy_vehicles_broken", "targetname");

  foreach(var_2 in var_0) {
    var_2 maps\_utility::add_spawn_function(::convoy_spawn_func);
    var_3 = var_2 maps\_vehicle::spawn_vehicle_and_gopath();
    wait 0.1;
  }

  level thread convoy_spawn_logic();
  wait 0.2;
  level thread convoy_check();
  level thread set_flag_when_launcher_in_right_spot();
}

convoy_spawn_logic() {
  var_0 = getEntArray("enemy_convoy_vehicles", "targetname");

  foreach(var_2 in var_0)
  var_2 maps\_utility::add_spawn_function(::convoy_spawn_func);

  var_4 = [1, 2, 0, 1, 2, 1, 0];
  var_5 = 0;
  var_6 = 0;

  while(!common_scripts\utility::flag("spawn_m880")) {
    var_7 = var_0[var_4[var_5]] maps\_vehicle::spawn_vehicle_and_gopath();
    var_7 thread maps\flood_audio::flood_convoy_sfx(var_5);
    var_7 vehicle_turnengineoff();
    var_5++;

    if(var_5 >= var_4.size)
      var_5 = 0;

    var_8 = getvehiclenode("convoy_next_node_1", "targetname");
    var_9 = getvehiclenode("convoy_next_node_2", "targetname");
    common_scripts\utility::waittill_any_ents(var_8, "trigger", var_9, "trigger");
    wait 0.5;
  }

  var_10 = getEntArray("enemy_convoy_vehicles_tank", "targetname");

  foreach(var_12 in var_10) {
    var_12 maps\_utility::add_spawn_function(::convoy_spawn_func);
    var_12 maps\_vehicle::spawn_vehicle_and_gopath();
    wait 0.1;
  }

  var_14 = getent("enemy_convoy_vehicles_launcher", "targetname");
  var_14 maps\_utility::add_spawn_function(::launcher_spawn_func);
  var_14 = var_14 maps\_utility::spawn_vehicle();
  level thread ladder_spot_glow();
  wait 0.1;
  var_14 maps\_vehicle::gopath();
  common_scripts\utility::flag_set("m880_has_spawned");
  var_15 = getent("enemy_convoy_vehicles_launcher_lynx", "targetname");
  var_15 maps\_utility::add_spawn_function(::launcher_lynx_spawn_func);
  var_15 maps\_vehicle::spawn_vehicle_and_gopath();
}

convoy_spawn_func() {
  self endon("death");
  var_0 = level.convoy.size;
  level.convoy[var_0] = self;
  thread convoy_death_func();
  maps\_vehicle::godon();
  self vehicle_setspeed(25, 25, 25);

  if(self.vehicletype != "iveco_lynx") {
    while(!self.riders.size)
      wait 0.1;

    var_1 = self.riders.size;
    wait 0.2;

    foreach(var_3 in self.riders) {
      if(isDefined(var_3.script_startingposition) && var_3.script_startingposition != 0) {
        var_4 = randomint(2);

        if(var_4 == 0 && var_1 > 2) {
          var_1--;
          var_3 delete();
        } else
          var_3 thread convoy_riders_death_func();
      }
    }
  }

  common_scripts\utility::flag_wait("spawn_m880");
  var_6 = randomintrange(1, 3);
  self vehicle_setspeed(25, 7, 7);

  while(!common_scripts\utility::flag("start_heli_attack")) {
    convoy_spacing_func(var_0, 450, 600);
    common_scripts\utility::waitframe();
  }

  wait 2.0;
  self vehicle_setspeed(25, 2, 2);
}

launcher_spawn_func() {
  thread maps\flood_audio::flood_convoy_exp_sfx();
  self endon("death");
  level.first_launcher = self;
  self.animname = "m880_crash_m880";
  maps\_vehicle::godon();
  self vehicle_setspeed(25, 25, 25);
  common_scripts\utility::flag_wait("start_heli_attack");
  thread maps\flood_audio::flood_launcher_crash_sfx();
  wait 2.0;
  self vehicle_setspeed(25, 2, 2);

  while(level.first_launcher.origin[1] < -10000)
    common_scripts\utility::waitframe();

  level.first_launcher thread maps\_vehicle::vehicle_stop_named("m880_crashed", 25, 25);
  level.launcher_lynx thread m880_crash_kill_player_in_lynx_volume();
  maps\_utility::delaythread(2.5, ::m880_crash_kill_in_volume);
  maps\flood_anim::m880_crash_spawn(level.first_launcher, level.launcher_lynx);
  common_scripts\utility::flag_set("missile_launcher_in_place");
  level notify("remove_checkpoint_kill_trigger");
  level thread connect_nodes_after_crash();
  maps\flood_anim::m880_crash_loop(level.first_launcher);
}

debug_timer() {
  common_scripts\utility::flag_init("debug_timer_stop");
  var_0 = 0;

  while(!common_scripts\utility::flag("debug_timer_stop")) {
    var_0++;
    common_scripts\utility::waitframe();
  }

  iprintln("waited " + var_0 + " frames");
}

m880_crash_kill_in_volume() {
  var_0 = getaiarray("axis");
  var_1 = getent("m880_crash_kill_volume", "targetname");

  if(level.player istouching(var_1)) {
    level.player kill();
    wait 0.1;
    setdvar("ui_deadquote", &"FLOOD_FAIL_VEHICLE_CRUSH");
    level thread maps\_utility::missionfailedwrapper();
  }

  foreach(var_3 in var_0) {
    if(var_3 istouching(var_1))
      var_3 kill();
  }
}

m880_crash_kill_player_in_lynx_volume() {
  level waittill("lynx_crash_start");
  var_0 = getent("lynx_collision_path_200", "targetname");
  var_0 thread wait_then_check_if_player_touching_kill(2.0, 2.8);
  var_0 = getent("lynx_collision_path_250", "targetname");
  var_0 thread wait_then_check_if_player_touching_kill(2.5, 3.14);
  var_0 = getent("lynx_collision_path_290", "targetname");
  var_0 thread wait_then_check_if_player_touching_kill(2.9, 3.6);
  var_0 = getent("lynx_collision_path_330", "targetname");
  var_0 thread wait_then_check_if_player_touching_kill(3.3, 4.5);
  var_0 = getent("lynx_collision_path_385", "targetname");
  var_0 thread wait_then_check_if_player_touching_kill(3.85, 4.6);
}

wait_then_check_if_player_touching_kill(var_0, var_1) {
  self endon("stop" + var_0);
  self endon("death");
  var_2 = var_1 - var_0;
  wait(var_0);
  thread maps\_utility::notify_delay("stop" + var_0, var_2);

  for(;;) {
    if(level.player istouching(self)) {
      level.player kill();
      wait 0.1;
      setdvar("ui_deadquote", &"FLOOD_FAIL_VEHICLE_CRUSH");
      level thread maps\_utility::missionfailedwrapper();
    }

    wait 0.1;
  }
}

connect_nodes_after_crash() {
  var_0 = getnodearray("connect_after_crash", "targetname");

  foreach(var_2 in var_0)
  var_2 connectnode();

  var_0 = getnodearray("disconnect_after_crash", "targetname");

  foreach(var_2 in var_0)
  var_2 disconnectnode();
}

launcher_lynx_spawn_func() {
  self endon("death");
  level.launcher_lynx = self;
  self.animname = "convoy_lynx";
  maps\_vehicle::godon();
  self vehicle_setspeed(25, 25, 25);
  common_scripts\utility::flag_wait("start_heli_attack");
}

convoy_kill_player() {
  level endon("remove_checkpoint_kill_trigger");
  var_0 = getent("kill_player_checkpoint", "targetname");
  var_0 waittill("trigger");
  level.player kill();
  wait 0.1;
  setdvar("ui_deadquote", &"FLOOD_FAIL_VEHICLE_CRUSH");
  level thread maps\_utility::missionfailedwrapper();
}

convoy_death_func() {
  self endon("death");

  while(!common_scripts\utility::flag("streets_to_dam_enemies_dead")) {
    var_0 = getent("kill_convoy", "targetname");
    var_0 waittill("trigger", var_1);

    if(var_1 == self) {
      break;
    }
  }

  self delete();
}

convoy_riders_death_func() {
  self endon("death");

  while(!common_scripts\utility::flag("streets_to_dam_enemies_dead")) {
    var_0 = getent("kill_truck_guys", "targetname");
    var_0 waittill("trigger", var_1);

    if(var_1 == self) {
      break;
    }
  }

  self delete();
}

convoy_riders_react_func(var_0) {
  var_0 endon("death");
  wait 0.3;

  foreach(var_2 in var_0.riders) {
    var_2 thread notify_on_msg(self, "riders_shot", "death");
    var_2 thread notify_on_msg(self, "riders_shot", "damage");
  }

  self waittill("riders_shot");
  wait(randomfloat(0.2));

  if(isDefined(self) && isalive(self)) {
    var_4 = level.vehicle_aianims[var_0.classname][2];
    self setanim(var_4.death);
  }
}

check_if_player_close_to_checkpoint() {
  var_0 = getent("close_to_checkpoint", "targetname");

  if(isDefined(var_0))
    var_0 waittill("trigger");

  common_scripts\utility::flag_set("close_to_checkpoint");
}

convoy_spacing_func(var_0, var_1, var_2) {
  var_3 = 21;
  var_4 = 27;

  if(isDefined(level.convoy[var_0 - 1]) && isDefined(level.convoy[var_0])) {
    if(distance2d(level.convoy[var_0].origin, level.convoy[var_0 - 1].origin) > var_2) {
      var_5 = level.convoy[var_0] vehicle_getspeed();
      var_6 = randomintrange(1, 3);
      var_7 = var_5 + var_6;

      if(var_7 > var_4)
        var_7 = var_4;

      level.convoy[var_0] vehicle_setspeed(var_7, 10, 10);
    }

    if(distance2d(level.convoy[var_0].origin, level.convoy[var_0 - 1].origin) < var_1) {
      var_5 = level.convoy[var_0] vehicle_getspeed();
      var_6 = randomintrange(1, 3);
      var_7 = var_5 - var_6;

      if(var_7 < var_3)
        var_7 = var_3;

      level.convoy[var_0] vehicle_setspeed(var_7, 10, 10);
    }
  }
}

rotate_checkpoint_gate_when_near_m880(var_0) {
  var_1 = getent("checkpoint_gate", "targetname");
  var_2 = (0, 0, -15);

  while(!isDefined(level.first_launcher))
    wait 0.1;

  while(distance2d(level.first_launcher.origin, var_1.origin) > var_0)
    wait 0.1;

  var_1 rotateto(var_2, 0.25);
}

rotate_checkpoint_concrete_barrier_when_near_m880(var_0) {
  level endon("end_of_streets_to_dam");
  var_1 = getent("checkpoint_concrete_barrier_1", "targetname");
  var_2 = getent("checkpoint_concrete_barrier_2", "targetname");
  var_2 hide();
  var_3 = var_2.angles;
  var_4 = var_2.origin;

  while(!isDefined(level.first_launcher))
    wait 0.1;

  while(distance2d(level.first_launcher.origin, var_1.origin) > var_0)
    wait 0.1;

  var_1 rotateto(var_3, 0.15);
  var_1 moveto(var_4, 0.15);
  var_5 = getEntArray("checkpoint_concrete_barrier_1_clip", "targetname");

  foreach(var_7 in var_5)
  var_7 delete();

  level waittill("player_failed_stab");
  var_1 hide();
}

streets_to_dam_sequence() {
  var_0 = getent("rpg_guys_death_trigger", "targetname");
  var_0 waittill("trigger");
  maps\_utility::kill_deathflag("rpg_guys");
}

streets_to_dam_wave_1_init() {
  var_0 = getEntArray("streets_to_dam_wave_1", "targetname");
  maps\_utility::array_spawn_function(var_0, ::streets_to_dam_wave_1_spawn_func);
  var_0 = getEntArray("streets_to_dam_wave_1", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::spawn_ai);
  var_0 = getEntArray("streets_to_dam_wave_1_street_patrol", "targetname");
  maps\_utility::array_spawn_function(var_0, ::streets_to_dam_wave_1_street_patrol_spawn_func);
  var_0 = getEntArray("streets_to_dam_wave_1_street_patrol", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::spawn_ai);
  var_1 = getaiarray("axis");
  common_scripts\utility::array_thread(var_1, ::ignore_everything);
  var_2 = getaiarray("allies");
  common_scripts\utility::array_thread(var_2, ::ignore_everything);
  level thread block_off_road_during_convoy();
  level thread set_up_vignette_enemies();
  level thread watch_player_for_attack();
  level thread watch_player_for_trigger();
  level thread watch_for_ally_see_convoy();
  level thread swap_nodes_init();
  common_scripts\utility::flag_wait_any("see_convoy", "player_move_up", "enemy_alerted");

  if(common_scripts\utility::flag("player_move_up")) {}

  if(common_scripts\utility::flag("enemy_alerted")) {}

  var_3 = getent("spawn_scaffold_guys_trigger", "targetname");

  if(isDefined(var_3))
    var_3 notify("trigger");

  level thread start_combat_after_seeing_launcher();
  level thread enemy_checkpoint_dialogue();
  level thread heli_strafing_run();
  common_scripts\utility::flag_wait_any("enemy_alerted", "start_cover_fire");

  if(!common_scripts\utility::flag("enemy_alerted")) {
    common_scripts\utility::flag_set("enemy_surprised");
    wait 2.5;
    var_2 = getaiarray("allies");
    common_scripts\utility::array_thread(var_2, ::clear_ignore_everything);

    foreach(var_5 in var_2) {
      var_5.ignoreme = 1;
      var_5.ignoresuppression = 1;
    }

    level.player.ignoreme = 1;
    var_1 = getaiarray("axis");

    foreach(var_5 in var_1)
    var_5 maps\_utility::delaythread(randomfloatrange(0.1, 1.0), ::clear_ignore_everything);

    level thread checkpoint_enemies_run_for_cover();
    wait 3.0;
  } else {
    var_9 = maps\_utility::get_ai_group_ai("rpg_guys");
    common_scripts\utility::array_thread(var_9, ::clear_ignore_everything);
  }

  var_2 = getaiarray("allies");
  common_scripts\utility::array_thread(var_2, ::clear_ignore_everything);

  foreach(var_5 in var_2)
  var_5.ignoreme = 0;

  level.player.ignoreme = 0;
  var_9 = maps\_utility::get_ai_group_ai("rpg_guys");
  var_1 = getaiarray("axis");
  var_1 = common_scripts\utility::array_remove_array(var_1, var_9);
  common_scripts\utility::array_thread(var_1, ::clear_ignore_everything);

  foreach(var_5 in var_1) {
    if(isDefined(var_5)) {
      var_5 clear_ignore_everything();
      wait(randomfloatrange(0.2, 0.5));
    }
  }

  wait 0.5;

  while(maps\_utility::get_ai_group_sentient_count("streets_to_dam_wave_1") + maps\_utility::get_ai_group_sentient_count("rpg_guys") > 4)
    wait 0.1;

  common_scripts\utility::flag_set("streets_to_dam_enemies_ALMOST_dead");
  wait 2;
  var_14 = getent("streets_to_dam_garage_exit", "targetname");

  if(isDefined(var_14))
    var_14 notify("trigger");

  while(maps\_utility::get_ai_group_sentient_count("streets_to_dam_wave_1") + maps\_utility::get_ai_group_sentient_count("rpg_guys") > 1)
    wait 0.1;

  common_scripts\utility::flag_set("streets_to_dam_enemies_last_guy");
  maps\_utility::waittill_aigroupcleared("streets_to_dam_wave_1");
  maps\_utility::waittill_aigroupcleared("rpg_guys");
  wait 0.5;
  common_scripts\utility::flag_set("streets_to_dam_enemies_dead");
}

watch_for_ally_see_convoy() {
  var_0 = getent("baker_hold_up", "targetname");
  var_0 waittill("trigger");
  common_scripts\utility::flag_set("see_convoy");
}

checkpoint_enemies_run_for_cover() {
  var_0 = spawn("script_origin", level.heli_turret.origin);
  wait 0.1;
  var_0.origin = level.heli_turret.origin + (0, 0, 300);
  var_0 linkto(level.heli_turret);
  var_1 = getnodearray("checkpoint_alert_node", "script_noteworthy");
  var_2 = maps\_utility::get_ai_group_ai("streets_to_dam_wave_1");
  var_3 = var_2[0].goalradius;

  foreach(var_5 in var_1) {
    var_6 = common_scripts\utility::get_array_of_closest(var_5.origin, var_2);

    if(var_6.size > 0) {
      var_6[0].goalradius = 32;
      var_6[0] setgoalnode(var_5);
      var_6[0] setentitytarget(var_0);
      var_2 = common_scripts\utility::array_remove(var_2, var_6[0]);
    }
  }

  wait 1.5;
  var_2 = maps\_utility::get_ai_group_ai("streets_to_dam_wave_1");

  foreach(var_9 in var_2) {
    var_9.goalradius = var_3;
    var_9 clearentitytarget();
  }
}

checkpoint_rpg_enemies_fire_at_heli() {
  for(var_0 = maps\_utility::get_ai_group_ai("rpg_guys"); var_0.size < 2; var_0 = maps\_utility::get_ai_group_ai("rpg_guys"))
    wait 0.1;

  var_1 = getent("streets_to_dam_rpg_target_1", "targetname");
  var_0 = common_scripts\utility::get_array_of_closest(var_1.origin, var_0);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isDefined(var_0[var_2])) {
      if(var_2 != 0)
        var_1 = getent("streets_to_dam_rpg_target_2", "targetname");

      var_0[var_2] thread rpg_guy_wait_and_fire_at_target(var_1);
    }
  }
}

rpg_guy_wait_and_fire_at_target(var_0) {
  self endon("death");

  if(common_scripts\utility::flag("enemy_surprised")) {
    self.dontevershoot = 1;
    self setentitytarget(var_0);
    thread ignore_everything();

    while(level.heli_turret.origin[1] < var_0.origin[1])
      wait 0.1;

    self.dontevershoot = undefined;
    wait 2.0;
    self clearentitytarget();
    wait 0.1;
    self.dontevershoot = undefined;
    thread clear_ignore_everything();
  }

  self.ignoresuppression = 1;
}

set_up_vignette_enemies() {
  var_0 = getEntArray("streets_to_dam_wave_1_vignette", "targetname");
  maps\_utility::array_spawn_function(var_0, ::streets_to_dam_wave_1_spawn_func);
  maps\_utility::array_spawn_function(var_0, ::streets_to_dam_wave_1_vignette_spawn_func);
  var_1 = 0;
  var_2 = [];

  foreach(var_4 in var_0) {
    var_2[var_1] = var_4 maps\_utility::spawn_ai();
    var_1++;
    var_2[var_1 - 1].animname = "convoy_checkpoint_opfor0" + var_1;
  }

  var_0 = getEntArray("streets_to_dam_wave_1_vignette_extra", "targetname");
  maps\_utility::array_spawn_function(var_0, ::streets_to_dam_wave_1_spawn_func);
  maps\_utility::array_spawn_function(var_0, ::streets_to_dam_wave_1_vignette_extra_spawn_func);
  maps\_utility::array_spawn(var_0);
  wait 1.0;
  common_scripts\utility::flag_wait("vignette_convoy_checkpoint_flag");

  if(!common_scripts\utility::flag("enemy_alerted"))
    maps\flood_anim::convoy_checkpoint(var_2[0], var_2[1], var_2[2], var_2[3]);
}

delete_on_flag(var_0) {
  self endon("death");
  common_scripts\utility::flag_wait(var_0);
  self delete();
}

streets_to_dam_wave_1_vignette_spawn_func() {
  self endon("death");

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "enemy_13")
      level.enemy_13 = self;

    if(self.script_noteworthy == "enemy_14")
      level.enemy_14 = self;

    if(self.script_noteworthy == "enemy_15")
      level.enemy_15 = self;
  }

  thread set_flag_if_damaged();
  ignore_everything();
  common_scripts\utility::flag_wait("enemy_alerted");
  clear_ignore_everything();
  self stopanimscripted();
}

streets_to_dam_wave_1_vignette_extra_spawn_func() {
  self endon("death");
  self.animname = "convoy_checkpoint_opfor02";
  ignore_everything();
  var_0 = getent("streets_to_dam_extra_waver_node", "script_noteworthy");
  var_0.origin = var_0.origin + (30, 150, 0);
  var_1 = [];
  var_1["convoy_checkpoint_opfor02"] = self;
  var_0 thread maps\_anim::anim_single(var_1, "convoy_checkpoint");
  common_scripts\utility::flag_wait("enemy_alerted");
  clear_ignore_everything();
  self stopanimscripted();
}

start_combat_after_seeing_launcher() {
  common_scripts\utility::flag_wait("rpg_fired_at_launcher");
  common_scripts\utility::flag_set("start_cover_fire");
}

kill_guys_near_rpg() {
  wait 2.0;
  var_0 = getent("enemies_near_rpg_volume", "targetname");
  kill_deathflag_in_area("streets_to_dam_checkpoint_enemies_close", var_0, 2.0);
}

garage_autosave_before_heli_attack() {
  common_scripts\utility::flag_wait("m880_has_spawned");
  thread maps\_utility::autosave_by_name("garage_before_heli");
}

allies_convoy_dialogue() {
  var_0 = lookupsoundlength("flood_pri_helixonewevegot");
  var_0 = var_0 / 1000;
  level.allies[0] thread maps\_utility::smart_dialogue("flood_pri_helixonewevegot");
  wait(var_0);
  maps\_utility::smart_radio_dialogue("flood_hlx_alreadypickeditup");
  wait 0.5;
  level.allies[0] maps\_utility::smart_dialogue("flood_pri_getreadyforthe");
}

enemy_checkpoint_dialogue() {
  while(!isDefined(level.enemy_13))
    wait 0.1;

  while(!isDefined(level.enemy_14))
    wait 0.1;

  while(!isDefined(level.enemy_15))
    wait 0.1;
}

enemy_dialogue(var_0) {
  if(!common_scripts\utility::flag("enemy_alerted"))
    maps\_utility::smart_dialogue(var_0);
}

heli_strafing_run() {
  common_scripts\utility::flag_wait("start_heli_attack");
  level maps\_utility::delaythread(1, maps\_vehicle::spawn_vehicles_from_targetname_and_drive, "convoy_flyin_jet");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname("streets_to_dam_strafe_blackhawk");
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname("streets_to_dam_strafe_blackhawk_2");
  var_0 maps\_vehicle::godon();
  var_1 maps\_vehicle::godon();
  var_2 = var_0 thread add_turret_to_heli(1);
  var_3 = var_1 thread add_turret_to_heli(2);
  var_0 maps\_vehicle::gopath();
  var_0 vehicle_turnengineoff();
  var_0 thread maps\flood_audio::flood_convoy_attackheli01_sfx();
  var_1 maps\_vehicle::gopath();
  var_1 vehicle_turnengineoff();
  var_1 thread maps\flood_audio::flood_convoy_attackheli02_sfx();
  var_0 waittill("start_firing");
  var_0 thread heli_strafing_think();
  common_scripts\utility::flag_set("rpg_fired_at_launcher");
  wait 1.0;
  wait 1.0;
  wait 3.0;
  var_0 notify("stop_firing_mg");
  var_1 notify("stop_firing_mg");
}

display_speed() {
  self endon("death");

  for(;;) {
    var_0 = self vehicle_getspeed();
    wait 0.1;
  }
}

heli_strafing_think() {
  self endon("death");
  self endon("stop_firing");
  fire_heli_missile("new_streets_to_dam_heli_target_1");
  wait 0.2;
  wait 0.3;
  fire_heli_missile("new_streets_to_dam_heli_target_3");
  wait 0.5;
  wait 0.2;
  fire_heli_missile("new_streets_to_dam_heli_target_6");
  wait 0.6;
  fire_heli_missile("new_streets_to_dam_heli_target_8");
  wait 0.2;
  fire_heli_missile("new_streets_to_dam_heli_target_11");
  wait 0.4;
  fire_heli_missile("new_streets_to_dam_heli_target_12");
  self notify("stop_firing");
}

fire_heli_missile(var_0) {
  var_1 = self gettagorigin("tag_flash");
  var_1 = (var_1[0], var_1[1] + 50, var_1[2]);
  var_2 = getent(var_0, "targetname");
  magicbullet("rpg_straight", var_1, var_2.origin);
}

add_turret_to_heli(var_0) {
  var_1 = "vehicle_silenthawk_wings";
  var_2 = level.first_launcher gettagorigin("tag_origin");
  var_3 = spawn("script_model", var_2);
  var_3 setModel(var_1);
  var_3 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_4 = self gettagorigin("tag_doorgun");
  var_4 = self.origin;

  if(var_0 == 1) {
    level.heli_turret = spawnturret("misc_turret", var_4, "dshk_gaz");
    var_5 = level.heli_turret;
  } else
    var_5 = spawnturret("misc_turret", var_4, "dshk_gaz");

  var_5 setModel("vehicle_m1a2_abrams_remote_gun");
  var_5.team = "allies";
  wait 0.1;
  var_5.origin = self gettagorigin("tag_doorgun");
  var_5 linkto(self, "tag_doorgun", (0, 0, 0), self.angles + (0, 0, 90));
  var_5 setmode("manual");
  var_5 setturretteam("allies");
  var_5 hide();

  while(isDefined(self))
    wait 1.0;

  var_5 delete();
}

fire_heli_turret() {
  self endon("death");
  self endon("stop_firing_mg");
  self waittill("stop_firing");
  var_0 = level.heli_turret;
  var_1 = getent("missile_smoke_origin_3", "targetname");
  var_0 settargetentity(var_1);
  var_0 startfiring();

  while(isDefined(var_0)) {
    var_0 shootturret();
    wait 0.1;
  }
}

block_off_road_during_convoy() {
  var_0 = getent("streets_to_dam_bad_place_brush", "targetname");
  badplace_brush("street_blocker", -1, var_0, "axis");
  common_scripts\utility::flag_wait("convoy_gone");
  wait 3.0;
  badplace_delete("street_blocker");
}

watch_player_for_attack() {
  level thread watch_for_player_grenade();

  while(!common_scripts\utility::flag("enemy_alerted")) {
    if(level.player attackbuttonpressed() && level.player getcurrentweaponclipammo() > 0) {
      break;
    }

    wait 0.1;
  }

  common_scripts\utility::flag_set("enemy_alerted");
}

watch_for_player_grenade() {
  while(!common_scripts\utility::flag("enemy_alerted") && !common_scripts\utility::flag("grenade_thrown")) {
    var_0 = getEntArray("grenade", "classname");

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(isDefined(var_0[var_1])) {
        var_2 = getmissileowner(var_0[var_1]);

        if(var_2 == level.player) {
          common_scripts\utility::flag_set("grenade_thrown");
          break;
        }
      }
    }

    common_scripts\utility::waitframe();
  }

  wait(randomfloatrange(1.5, 2));
  common_scripts\utility::flag_set("enemy_alerted");
}

watch_player_for_trigger() {
  var_0 = getent("streets_to_dam_garage_exit", "targetname");
  var_0 waittill("trigger");
  common_scripts\utility::flag_set("enemy_alerted");
}

watch_enemy_for_damage() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2 thread set_flag_if_damaged();
}

set_flag_if_damaged() {
  level endon("enemy_alerted");
  waitill_damage_or_death();
  self dodamage(10, level.player.origin, level.player);
  common_scripts\utility::flag_set("enemy_alerted");
}

notify_on_msg(var_0, var_1, var_2) {
  self waittill(var_2);
  var_0 notify(var_1);
}

waitill_damage_or_death() {
  self endon("damage");
  self endon("death");

  for(;;)
    wait 0.1;
}

swap_nodes_init() {
  var_0 = getEntArray("swap_node_trigger", "targetname");

  foreach(var_2 in var_0)
  var_2 thread swap_nodes();
}

swap_nodes() {
  level endon("end_of_streets_to_dam");

  if(isDefined(self.target)) {
    while(!common_scripts\utility::flag("streets_to_dam_enemies_dead")) {
      self waittill("trigger");
      wait 0.5;

      if(level.player istouching(self)) {
        for(var_0 = 0; var_0 < level.allies.size; var_0++) {
          if(level.allies[var_0] istouching(self)) {
            var_1 = getnode(self.target, "targetname");
            level.allies[var_0] setgoalnode(var_1);
          }
        }
      }
    }
  }
}

trigger_named_and_turn_off_prior(var_0, var_1) {
  var_2 = 1;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(var_2) {
      if(var_0[var_3] == var_1) {
        var_4 = getent(var_0[var_3], "targetname");

        if(isDefined(var_4))
          var_4 notify("trigger");

        var_2 = 0;
      }

      var_4 = getent(var_0[var_3], "targetname");

      if(isDefined(var_4))
        var_4 common_scripts\utility::trigger_off();
    }
  }
}

set_flag_when_launcher_in_right_spot() {
  while(!isDefined(level.first_launcher))
    wait 0.1;

  while(level.first_launcher.origin[1] < -10500)
    wait 0.1;

  common_scripts\utility::flag_set("start_heli_attack");
}

convoy_check() {
  while(!isDefined(level.first_launcher))
    wait 0.1;

  var_0 = level.first_launcher;
  var_1 = -8200;
  var_2 = 1;

  while(var_2) {
    if(!isDefined(var_0)) {
      var_3 = getent("missile_launcher_2", "targetname");

      if(!isDefined(var_3)) {
        break;
      } else
        var_0 = var_3;
    }

    if(var_0.origin[1] > var_1)
      var_2 = 0;

    if(level.player.origin[1] > var_0.origin[1] - 190) {
      if(level.player.origin[0] > var_0.origin[0] - 100 && level.player.origin[0] < var_0.origin[0] + 100) {
        wait 0.2;
        level.player kill();
        wait 0.1;
        setdvar("ui_deadquote", &"FLOOD_FAIL_VEHICLE_CRUSH");
        level thread maps\_utility::missionfailedwrapper();
      }
    }

    wait 0.1;
  }

  common_scripts\utility::flag_set("convoy_gone");
}

disable_combat_nodes() {
  var_0 = getnodearray("nodes_to_disconnect", "targetname");

  foreach(var_2 in var_0)
  var_2 disconnectnode();

  common_scripts\utility::flag_wait("enemy_alerted");
  var_0 = getnodearray("nodes_to_disconnect", "targetname");

  foreach(var_2 in var_0)
  var_2 connectnode();
}

disable_ally_nag_nodes() {
  var_0 = getnodearray("nodes_to_disconnect_ally", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 disconnectnode();

  common_scripts\utility::flag_wait_either("player_on_ladder", "streets_to_dam_enemies_dead");
  var_0 = getnodearray("nodes_to_disconnect_ally", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 connectnode();
}

spawn_rpg_guys() {
  common_scripts\utility::flag_wait_any("rpg_spawn", "enemy_alerted", "enemy_surprised");
  var_0 = getEntArray("streets_to_dam_wave_1_rpg", "targetname");
  maps\_utility::array_spawn_function(var_0, ::streets_to_dam_wave_1_rpg_spawn_func);
  wait 0.5;
  var_1 = getent("rpg_guy_2", "script_noteworthy");
  var_2 = getent("streets_to_dam_rpg_target_2", "targetname");
  var_1 maps\_utility::add_spawn_function(::rpg_guy_wait_and_fire_at_target, var_2);
  var_1 = var_1 maps\_utility::spawn_ai();
  wait 0.5;
  var_3 = getent("rpg_guy_1", "script_noteworthy");
  var_2 = getent("streets_to_dam_rpg_target_1", "targetname");
  var_3 maps\_utility::add_spawn_function(::rpg_guy_wait_and_fire_at_target, var_2);
  var_3 = var_3 maps\_utility::spawn_ai();
  wait 0.5;
}

streets_to_dam_wave_1_rpg_spawn_func() {
  self endon("death");
  thread set_flag_if_damaged();
  thread remove_rpgs_on_death();
  common_scripts\utility::flag_wait("enemy_alerted");
  self notify("stop_going_to_node");
  clear_ignore_everything();
  self.ignoresuppression = 1;

  if(self.script_noteworthy == "rpg_guy_1")
    var_0 = getnode("rpg_node_1", "targetname");
  else
    var_0 = getnode("rpg_node_2", "targetname");

  var_1 = self.goalradius;
  self.goalradius = var_0.radius;
  self.goalradius = 16;
  self setgoalnode(var_0);
  self waittill("goal");
  wait 10;
  self.goalradius = var_1;
}

remove_rpgs_on_death() {
  self waittill("death");

  if(isDefined(self.weapon))
    maps\_utility::gun_remove();
}

streets_to_dam_wave_1_street_patrol_spawn_func() {
  self endon("death");
  thread maps\_patrol::patrol();
  common_scripts\utility::flag_wait("enemy_alerted");
  self notify("stop_going_to_node");

  if(common_scripts\utility::flag("convoy_gone"))
    var_0 = getent("enemies_left_goal_volume", "targetname");
  else
    var_0 = getent("enemies_convoy_goal_volume", "targetname");

  self setgoalvolumeauto(var_0);
  self.grenadeammo = randomint(1);

  while(!common_scripts\utility::flag("convoy_gone"))
    wait 0.1;

  var_0 = getent("enemies_left_goal_volume", "targetname");
  self setgoalvolumeauto(var_0);
  common_scripts\utility::flag_wait("streets_to_dam_enemies_ALMOST_dead");
  var_0 = getent("enemies_left_small_goal_volume", "targetname");
  self setgoalvolumeauto(var_0);
  common_scripts\utility::flag_wait("streets_to_dam_enemies_last_guy");
  var_0 = getent("enemies_left_last_guy_goal_volume", "targetname");
  self setgoalvolumeauto(var_0);
}

spawn_scaffold_guys() {
  if(!common_scripts\utility::flag("player_on_ladder")) {
    var_0 = getEntArray("streets_to_dam_wave_1_5_scaffold", "targetname");
    common_scripts\utility::array_thread(var_0, maps\_utility::spawn_ai);
  }

  var_1 = getent("scaffold_guys_fight", "targetname");
  var_1 notify("trigger");
}

scaffold_test_2() {
  wait 0.5;

  while(maps\_utility::get_ai_group_sentient_count("streets_to_dam_wave_1") + maps\_utility::get_ai_group_sentient_count("rpg_guys") > 1)
    wait 0.1;

  level notify("spawn_scaffold_guys");
}

scaffold_test_3() {
  wait 1.0;
  level notify("spawn_scaffold_guys");
}

streets_to_dam_wave_1_spawn_func() {
  self endon("death");
  ignore_everything();
  thread set_flag_if_damaged();
  common_scripts\utility::flag_wait("enemy_alerted");
  var_0 = getent("enemies_convoy_goal_volume", "targetname");
  self setgoalvolumeauto(var_0);
  wait 2.0;

  if(common_scripts\utility::flag("convoy_gone"))
    var_0 = getent("enemies_left_goal_volume", "targetname");
  else
    var_0 = getent("enemies_convoy_goal_volume", "targetname");

  self setgoalvolumeauto(var_0);
  self.grenadeammo = randomint(1);

  while(!common_scripts\utility::flag("convoy_gone"))
    wait 0.1;

  var_0 = getent("enemies_left_goal_volume", "targetname");
  self setgoalvolumeauto(var_0);
  common_scripts\utility::flag_wait("streets_to_dam_enemies_ALMOST_dead");
  var_0 = getent("enemies_left_small_goal_volume", "targetname");
  self setgoalvolumeauto(var_0);
  common_scripts\utility::flag_wait("streets_to_dam_enemies_last_guy");
  var_0 = getent("enemies_left_last_guy_goal_volume", "targetname");
  self setgoalvolumeauto(var_0);
}

streets_to_dam_drive_missile_launcher() {
  var_0 = getent("missile_launcher_2", "targetname");
  common_scripts\utility::flag_wait("rpg_fired_at_launcher");
  level thread show_missile_launcher_collision();
  wait 0.2;
  common_scripts\utility::flag_wait("player_on_ladder");
  level.first_launcher notify("stop_crash_loop");
  level.first_launcher stopanimscripted();
  missile_launcher_destruction_vignette();

  if(level.stabbed)
    wait 1.0;
}

m880_open_path_init() {
  var_0 = getEntArray("m880_show_to_open_path", "targetname");

  foreach(var_2 in var_0)
  var_2 hide();
}

m880_open_path() {
  var_0 = getEntArray("m880_delete_to_open_path", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();

  var_0 = getEntArray("m880_collision_brush", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 delete();

  var_0 = getEntArray("m880_show_to_open_path", "targetname");

  foreach(var_2 in var_0)
  var_2 show();
}

m880_connect_path_nodes(var_0) {
  wait 3.0;
  var_1 = getnodearray("m880_kill_connect_nodes", "targetname");

  foreach(var_3 in var_1) {
    if(var_0) {
      var_3 connectnode();
      continue;
    }

    var_3 disconnectnode();
  }
}

missile_launcher_vo() {
  if(!common_scripts\utility::flag("player_on_ladder")) {
    level.allies[1] maps\_utility::smart_dialogue("flood_diz_multiplesams");
    wait 3.0;
  }

  if(!common_scripts\utility::flag("player_on_ladder"))
    level.allies[0] maps\_utility::smart_dialogue("flood_bkr_getinposition");
}

missile_launcher_destruction_vignette() {
  level thread ignore_player(1);
  maps\_utility::delaythread(2.0, ::ignore_player, 0);
  setsaveddvar("sm_sunSampleSizeNear", 0.15);
  mlrs_kill1_spawn();
  level thread missile_launcher_destruction_vignette_allies();
  wait 0.5;
  level thread m880_open_path();
  thread maps\_utility::autosave_by_name("after_mlrs_kill");
  common_scripts\utility::flag_set("missile_launcher_destruction_done");
  thread maps\flood_audio::sfx_stop_buzzer("sfx_launcher_destroyed");
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
}

missile_launcher_destruction_vignette_allies() {
  var_0 = getent("post_missile_launcher_location_ally1", "targetname");
  level.allies[0] forceteleport(var_0.origin, var_0.angles);
  level.allies[0] ignore_everything();
  var_0 = getent("post_missile_launcher_location_ally2", "targetname");
  level.allies[1] forceteleport(var_0.origin, var_0.angles);
  level.allies[1] ignore_everything();
  var_0 = getent("post_missile_launcher_location_ally3", "targetname");
  level.allies[2] forceteleport(var_0.origin, var_0.angles);
  level.allies[2] ignore_everything();
  wait 7.0;
  level.allies[0] clear_ignore_everything();
  level.allies[1] clear_ignore_everything();
  level.allies[2] clear_ignore_everything();
  wait 0.5;
  var_1 = getent("streets_to_dam_wave_2_start", "targetname");

  if(isDefined(var_1))
    var_1 notify("trigger");
}

mlrs_kill1_spawn() {
  var_0 = level.first_launcher;
  var_0.animname = "mlrs_kill1_m880";
  var_1 = maps\_vignette_util::vignette_drone_spawn("vignette_mrls_kill_opfor", "mlrs_kill1_opfor");
  mlrs_kill1_start(var_0, var_1);
  var_1 delete();
}

mlrs_kill1_start(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct("vignette_m880_crash", "script_noteworthy");
  var_3 = maps\_utility::spawn_anim_model("mlrs_kill1_knife");
  var_3 dontcastshadows();
  var_4 = maps\_utility::spawn_anim_model("mlrs_kill1_gun");
  var_5 = getdvarint("g_friendlyNameDist");
  setsaveddvar("g_friendlyNameDist", 0);
  level.player enableinvulnerability();
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  level.player stopsliding();

  if(level.player getstance() == "prone") {
    level.player setstance("crouch");

    while(level.player getstance() != "crouch")
      common_scripts\utility::waitframe();
  }

  if(level.player getstance() == "crouch") {
    level.player setstance("stand");

    while(level.player getstance() != "stand")
      common_scripts\utility::waitframe();
  }

  level.player allowprone(0);
  level.player allowcrouch(0);
  var_6 = maps\_utility::spawn_anim_model("player_rig");
  var_6 dontcastshadows();
  level.player thread delay_hide_view_model(0.4);
  var_6 thread hide_and_show(0.45);
  var_7 = [];
  var_7["player_rig"] = var_6;
  var_7["mlrs_kill1_opfor"] = var_1;
  var_7["mlrs_kill1_knife"] = var_3;
  var_7["mlrs_kill1_gun"] = var_4;
  var_2 maps\_anim::anim_first_frame(var_7, "mlrs_kill1_start");
  thread player_wait_link_to_blend(0.0, var_6);
  var_0 move_to_anim_start_point("mlrs_kill1_m880", "mlrs_kill1_start", var_2, 0.0);
  level.m880_radiation_gate thread move_to_anim_start_point("m880_radiation_gate", "mlrs_kill1_start", var_2, 0.2);
  var_8 = level.player getcurrentweapon();
  var_9 = weaponclipsize(var_8);
  var_10 = level.player getweaponammoclip(var_8);
  level.player setweaponammoclip(var_8, var_9);
  setsaveddvar("ammoCounterHide", 1);
  var_11 = 15;
  level thread m880_kill1_start_spring_cam(var_6, 0.5);
  thread maps\flood_audio::mssl_launch_destory_sfx();
  common_scripts\utility::flag_init("qte_window_closed");
  level.stabbed = 0;
  thread mlrs_kill1_barricades(var_2);
  var_7 = [];
  var_7["mlrs_kill1_m880"] = var_0;
  var_7["player_rig"] = var_6;
  var_7["mlrs_kill1_opfor"] = var_1;
  var_7["mlrs_kill1_knife"] = var_3;
  var_7["mlrs_kill1_gun"] = var_4;
  var_7["m880_radiation_gate"] = level.m880_radiation_gate;
  var_2 maps\_anim::anim_single(var_7, "mlrs_kill1_start");
  common_scripts\utility::flag_set("qte_window_closed");

  if(!level.stabbed) {
    level notify("player_failed_stab");
    level.player disableinvulnerability();
    magicbullet("pp19", var_4.origin, level.player.origin);
    level.player dodamage(level.player.health - 20, var_4.origin);
    level.lnchr_dstry_sfx stopsounds();
    thread m880_kill1_fail(var_2, var_6, var_1, var_3, var_4);
    level.convoy_tall_barricade_01 hide();
    level.convoy_tall_barricade_02 hide();
    setslowmotion(0.25, 1.0, 0.25);
    wait 1.0;
    setdvar("ui_deadquote", &"FLOOD_LAUNCHER_QTE_FAIL");
    level thread maps\_utility::missionfailedwrapper();
  } else {
    mlrs_kill1_end_spawn(var_2, var_6, var_0, var_1, var_3, var_4, level.m880_radiation_gate);
    level.player unlink();
    level.player showviewmodel();
    var_6 delete();
    level.player setweaponammoclip(var_8, var_10);
    setsaveddvar("ammoCounterHide", 0);
    level.player enableweapons();
    level.player freezecontrols(0);
    level.player allowprone(1);
    level.player allowcrouch(1);
  }

  setsaveddvar("g_friendlyNameDist", var_5);
  level.player disableinvulnerability();
  level maps\_utility::delaythread(2, maps\_vehicle::spawn_vehicles_from_targetname_and_drive, "streets_enemy_dam_chopper");
  thread maps\flood_audio::flood_streets_distant_helipass();
}

delay_hide_view_model(var_0) {
  wait(var_0);
  self hideviewmodel();
}

player_wait_link_to_blend(var_0, var_1) {
  wait(var_0);
  var_2 = 0.25;
  level.player playerlinktoblend(var_1, "tag_player", var_2, 0, 0);
}

move_to_anim_start_point(var_0, var_1, var_2, var_3) {
  var_4 = level.scr_anim[var_0][var_1];
  var_5 = spawn("script_origin", (0, 0, 0));
  var_5.origin = getstartorigin(var_2.origin, var_2.angles, var_4);
  var_5.angles = getstartangles(var_2.origin, var_2.angles, var_4);

  if(maps\_vehicle::isvehicle()) {
    self vehicle_orientto(var_5.origin, var_5.angles, 0, 0);
    self waittill("orientto_complete");
    self notify("suspend_drive_anims");
  } else {
    var_6 = spawn("script_origin", (0, 0, 0));
    var_6.origin = self.origin;
    var_6.angles = self.angles;
    self linkto(var_6);
    var_6 moveto(var_5.origin, var_3);
    var_6 rotateto(var_5.angles, var_3);
    self unlink();
    var_6 delete();
  }

  var_5 delete();
}

m880_kill1_start_spring_cam(var_0, var_1) {
  wait(var_1);
  var_2 = 15;
  level.player playerlinktodelta(var_0, "tag_player", 1, var_2, var_2, var_2, var_2, 1);
  level.player springcamenabled(1, 3.2, 1.6);
}

m880_kill1_fail(var_0, var_1, var_2, var_3, var_4) {
  var_0 = common_scripts\utility::getstruct("vignette_m880_crash", "script_noteworthy");
  var_5 = [];
  var_5["mlrs_kill1_opfor"] = var_2;
  var_5["player_rig"] = var_1;
  var_5["mlrs_kill1_knife"] = var_3;
  var_5["mlrs_kill1_gun"] = var_4;
  var_0 maps\_anim::anim_single(var_5, "m880_kill1_fail");
}

m880_kill_collision_change() {
  var_0 = getEntArray("clip_after_m880_kill", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
    var_2 notsolid();
  }

  common_scripts\utility::flag_wait("missile_launcher_destruction_done");
  var_0 = getEntArray("clip_after_m880_kill", "targetname");

  foreach(var_2 in var_0) {
    if(level.player istouching(var_2)) {
      var_2 thread maps\flood_anim::push_player_out_of_brush((-20, 0, 0));
      continue;
    }

    var_2 show();
    var_2 solid();
  }
}

mlrs_kill1_end_spawn(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = maps\_vignette_util::vignette_drone_spawn("vignette_mrls_kill_player_body", "mlrs_kill1_end_player_legs");
  mlrs_kill1_end(var_0, var_1, var_2, var_3, var_4, var_5, var_7, var_6);
  var_7 maps\_vignette_util::vignette_actor_delete();
}

mlrs_kill1_end(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = maps\_utility::spawn_anim_model("mlrs_kill1_end_grenade");
  var_8 dontcastshadows();
  var_9 = [];
  var_9["player_rig"] = var_1;
  var_9["mlrs_kill1_opfor"] = var_3;
  var_9["mlrs_kill1_knife"] = var_4;
  var_9["mlrs_kill1_end_player_legs"] = var_6;
  var_9["mlrs_kill1_end_grenade"] = var_8;
  var_9["mlrs_kill1_gun"] = var_5;
  var_9["m880_radiation_gate"] = var_7;
  thread play_mlrs_m880_end(var_0, var_2);
  var_0 maps\_anim::anim_single(var_9, "mlrs_kill1_end");

  if(isDefined(var_4))
    var_4 delete();

  if(isDefined(var_8))
    var_8 delete();
}

play_mlrs_m880_end(var_0, var_1) {
  var_2 = [];
  var_2["mlrs_kill1_m880"] = var_1;
  var_0 maps\_anim::anim_single(var_2, "mlrs_kill1_end");
}

mlrs_kill1_barricades(var_0) {
  var_1 = maps\_utility::spawn_anim_model("mlrs_kill1_barricade_01");
  var_2 = maps\_utility::spawn_anim_model("mlrs_kill1_barricade_02");
  var_1 thread hide_and_show(1.0);
  var_2 thread hide_and_show(1.0);
  var_3 = [];
  var_3["mlrs_kill1_barricade_01"] = var_1;
  var_3["mlrs_kill1_barricade_02"] = var_2;
  var_0 maps\_anim::anim_single(var_3, "mlrs_kill1_barricades");
}

hide_and_show(var_0) {
  self hide();
  wait(var_0);
  self show();
}

mlrs_start_qte(var_0) {
  thread mlrs_qte_prompt();
  thread maps\flood_audio::launcher_destroy_slomo_sfx();
  setslowmotion(1.0, 0.25, 0.5);

  for(;;) {
    if(level.player meleebuttonpressed()) {
      common_scripts\utility::flag_set("qte_window_closed");
      setslowmotion(0.25, 1.0, 0.05);
      thread maps\flood_audio::launcher_destroy_stop_slomo_sfx();
      level.stabbed = 1;
      return;
    }

    wait 0.05;
  }
}

mlrs_stop_qte_hint() {
  if(common_scripts\utility::flag("qte_window_closed"))
    return 1;
  else
    return 0;
}

ladder_spot_glow() {
  while(!isDefined(level.first_launcher))
    wait 0.1;

  common_scripts\utility::flag_wait("missile_launcher_in_place");
  var_0 = "vehicle_m880_launcher_obj";
  var_1 = level.first_launcher gettagorigin("tag_ladder");
  var_2 = spawn("script_model", var_1);
  var_2 setModel(var_0);
  var_2 linkto(level.first_launcher, "tag_ladder", (0, 0, 0), (0, 0, 0));
  common_scripts\utility::flag_wait("player_on_ladder");
  wait 3.0;
  var_2 delete();
}

wait_for_player_to_use_ladder() {
  var_0 = getent("player_climb_ladder_trigger_no_use", "targetname");
  var_0 common_scripts\utility::trigger_off();
  common_scripts\utility::flag_wait("missile_launcher_in_place");
  var_0 = getent("streets_to_dam_garage_exit", "targetname");

  if(isDefined(var_0))
    var_0 common_scripts\utility::trigger_off();

  level thread end_of_combat_autosave();
  var_0 = getent("player_climb_ladder_trigger_no_use", "targetname");
  var_0 common_scripts\utility::trigger_on();
  var_0 waittill("trigger");
  common_scripts\utility::flag_set("player_on_ladder");
  var_0 = getent("player_climb_ladder_trigger", "targetname");
  var_0 common_scripts\utility::trigger_off();
  maps\_utility::kill_deathflag("streets_to_dam_checkpoint_enemies");
  maps\_utility::kill_deathflag("streets_to_dam_checkpoint_enemies_close");
  maps\_utility::kill_deathflag("rpg_guys");
}

end_of_combat_autosave() {
  common_scripts\utility::flag_wait("streets_to_dam_enemies_dead");

  if(!common_scripts\utility::flag("player_on_ladder")) {
    var_0 = getent("streets_to_dam_end_combat_autosave", "targetname");
    var_0 waittill("trigger");
    thread maps\_utility::autosave_by_name("checkpoint_combat_end");
  }
}

block_garage_exit() {
  var_0 = getent("garage_exit_player_clip", "targetname");
  var_0 hide();
  var_0 notsolid();
  var_1 = getent("streets_to_dam_end_combat_autosave", "targetname");
  var_1 waittill("trigger");

  while(level.player istouching(var_0))
    wait 0.1;

  var_0 show();
  var_0 solid();
  common_scripts\utility::flag_set("player_out_of_garage");
}

teleport_failsafe() {
  wait 10.5;
  var_0 = getent("streets_to_dam_end_combat_autosave", "targetname");

  if(level.allies[0] istouching(var_0)) {
    var_1 = getent("post_missile_launcher_location_ally1", "targetname");
    level.allies[0] forceteleport(var_1.origin, var_1.angles);
  }

  if(level.allies[1] istouching(var_0)) {
    var_1 = getent("post_missile_launcher_location_ally2", "targetname");
    level.allies[1] forceteleport(var_1.origin, var_1.angles);
  }

  if(level.allies[2] istouching(var_0)) {
    var_1 = getent("post_missile_launcher_location_ally3", "targetname");
    level.allies[2] forceteleport(var_1.origin, var_1.angles);
  }
}

make_allies_shoot_at_targets() {
  common_scripts\utility::flag_wait_either("player_on_ladder", "streets_to_dam_enemies_dead");

  if(!common_scripts\utility::flag("player_on_ladder")) {
    var_0 = getent("streets_to_dam_garage_exit", "targetname");

    if(isDefined(var_0)) {
      var_0 notify("trigger");
      wait 1.0;
    }

    wait 0.2;
    var_1 = getnode("streets_to_dam_ally_0_node", "targetname");
    level.allies[0] setgoalnode(var_1);
    var_0 = getent("streets_to_dam_garage_exit", "targetname");

    if(isDefined(var_0))
      wait 2.0;

    var_1 = getnode("streets_to_dam_ally_1_node", "targetname");
    level.allies[1] thread play_ally_launcher_vignette_wrapper("launcher_callout_ally02", var_1, maps\flood_anim::launcher_callout_ally02, "player_on_ladder", (0, 0, 0));
    var_0 = getent("streets_to_dam_garage_exit", "targetname");

    if(isDefined(var_0))
      wait 2.0;

    var_1 = getnode("streets_to_dam_ally_2_node", "targetname");
    level.allies[2] thread play_ally_launcher_vignette_wrapper("launcher_callout_ally03", var_1, maps\flood_anim::launcher_callout_ally03, "player_on_ladder", (0, 225, 0));
    common_scripts\utility::flag_wait("player_on_ladder");
    level.allies[0] notify("player_now_on_ladder");
    level.allies[1] notify("player_now_on_ladder");
    level.allies[2] notify("player_now_on_ladder");
    level.allies[0] clearentitytarget();
    level.allies[1] clearentitytarget();
    level.allies[2] clearentitytarget();
  } else {}
}

play_ally_launcher_vignette_wrapper(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self.animname;
  var_6 = self.goalradius;
  play_ally_launcher_vignette(var_0, var_1, var_2, var_3, var_4);
  self stopanimscripted();

  if(isDefined(var_5))
    self.animname = var_5;

  self.goalradius = var_6;
}

play_ally_launcher_vignette(var_0, var_1, var_2, var_3, var_4) {
  self endon("player_now_on_ladder");
  self setgoalnode(var_1);
  self.goalradius = 16;
  self waittill("goal");
  self.animname = var_0;

  if(isDefined(var_3)) {
    while(!common_scripts\utility::flag(var_3)) {
      level waittill("nagging");
      wait(randomfloatrange(0.2, 1.0));

      if(isDefined(var_4)) {
        [[var_2]](self, var_1.origin, var_4);
        continue;
      }

      [[var_2]](self, var_1.origin, var_1.angles);
    }
  }
}

hide_unhide_crashed_convoy(var_0) {
  if(var_0) {
    var_1 = getent("crashed_truck", "targetname");

    if(isDefined(var_1))
      var_1 hide();

    var_1 = getent("crashed_tank", "targetname");

    if(isDefined(var_1))
      var_1 delete();

    var_1 = getent("crashed_m880", "targetname");

    if(isDefined(var_1))
      var_1 delete();

    common_scripts\utility::flag_wait("player_on_ladder");
  }

  var_1 = getent("crashed_truck", "targetname");

  if(isDefined(var_1)) {
    wait 2.0;
    var_1 show();
  }
}

dialogue_streets_to_dam() {
  maps\_utility::battlechatter_off("allies");
  common_scripts\utility::flag_set("everyone_in_garage");
  wait 2.0;
  level.allies[2] maps\_utility::smart_dialogue("flood_kgn_wereblockedinnow");
  level.allies[0] maps\_utility::smart_dialogue("flood_bkr_doesntmatterweneed");
  level thread nag_player_in_garage();
  var_0 = getent("baker_hold_up", "targetname");
  var_0 waittill("trigger");
  level notify("going_to_start_convoy_section");
  level.allies[0] maps\_utility::smart_dialogue("flood_bkr_holdup");
  level thread allies_convoy_dialogue();
  wait 2.0;
  common_scripts\utility::flag_set("spawn_m880");
  common_scripts\utility::flag_wait("m880_has_spawned");

  if(common_scripts\utility::flag("enemy_alerted"))
    maps\_utility::battlechatter_on("allies");

  wait 6;
  maps\_utility::smart_radio_dialogue("flood_hlx_goinghot");
  common_scripts\utility::flag_wait("rpg_fired_at_launcher");

  if(common_scripts\utility::flag("enemy_surprised")) {
    wait 3.0;
    level.allies[0] maps\_utility::smart_dialogue("flood_bkr_weaponsfree");
  }

  wait 0.5;
  common_scripts\utility::flag_wait_either("enemy_alerted", "enemy_surprised");
  maps\_utility::battlechatter_on("allies");
  common_scripts\utility::flag_wait_either("player_out_of_garage", "streets_to_dam_enemies_dead");

  if(common_scripts\utility::flag("player_out_of_garage")) {
    maps\_utility::battlechatter_off("allies");
    wait 2.0;
    level.allies[0] maps\_utility::smart_dialogue("flood_vrg_eliasstopthemissile");
    common_scripts\utility::flag_set("launcher_objective_given");
    maps\_utility::battlechatter_on("allies");
    common_scripts\utility::flag_wait("streets_to_dam_enemies_dead");
    wait 2.0;
    level.allies[0] maps\_utility::smart_dialogue("flood_pri_takethatlauncherout");
    maps\_utility::battlechatter_off("allies");
  } else {
    maps\_utility::battlechatter_off("allies");
    wait 4.0;

    if(!common_scripts\utility::flag("player_on_ladder")) {
      level.allies[0] maps\_utility::smart_dialogue("flood_vrg_eliasstopthemissile");
      common_scripts\utility::flag_set("launcher_objective_given");
    }
  }

  wait 1;

  if(!common_scripts\utility::flag("player_on_ladder")) {
    common_scripts\utility::flag_set("played_radio_part_1");
    maps\_utility::smart_radio_dialogue("flood_hqr_beadvisedenemyforces");
  }

  if(!common_scripts\utility::flag("player_on_ladder") && common_scripts\utility::flag("played_radio_part_1")) {
    common_scripts\utility::flag_set("played_radio_part_2");
    maps\_utility::smart_radio_dialogue("flood_gs1_rogeroverlordwehave");
  }

  wait 3;

  if(!common_scripts\utility::flag("player_on_ladder")) {
    var_1 = ["flood_pri_takethatlauncherout", "flood_vrg_theresaladderon"];
    level.allies[0] thread maps\flood_util::play_nag(var_1, "player_on_ladder", 10, 30, 2, 2, "flag_set");
  }

  common_scripts\utility::flag_wait("player_on_ladder");
  level.allies[0] notify("flag_set");
}

nag_player_in_garage() {
  level endon("going_to_start_convoy_section");
  wait 10;

  for(;;) {
    if(distance(level.player.origin, level.allies[0].origin) > 650) {
      level.allies[0] maps\_utility::smart_dialogue("flood_bkr_uphere");
      break;
    }

    wait 0.05;
  }
}

streets_nag_end_on_notify(var_0, var_1, var_2) {
  wait 3.0;

  if(!common_scripts\utility::flag(var_1))
    level.allies[0] thread maps\flood_util::play_nag(var_0, var_1, 8, 30, 1, 1.5, "flag_set");
}

init_turn_off_lean_volumes() {
  var_0 = getEntArray("turn_off_lean", "targetname");

  foreach(var_2 in var_0)
  var_2 turn_off_lean();
}

turn_off_lean() {
  var_0 = 0;

  while(!common_scripts\utility::flag("end_of_dam")) {
    if(level.player istouching(self)) {
      if(!var_0) {
        level.player allowlean(0);
        var_0 = 1;
      }
    } else if(var_0) {
      level.player allowlean(1);
      var_0 = 0;
    }

    wait 0.1;
  }
}

streets_to_dam_2_start() {
  maps\flood_util::player_move_to_checkpoint_start("streets_to_dam_2_start");
  maps\flood_util::spawn_allies();
  level thread aim_missiles_2();
  level thread hide_unhide_crashed_convoy(0);
  level thread hide_spire();
  level thread init_turn_off_lean_volumes();
  level thread streets_to_dam_2_side_guys_spawn_logic();
  level thread put_launcher_in_place();
  level thread manage_mantles();
  level thread maps\flood_infil::setup_dead_destroyed_and_misc();
  level thread maps\flood_util::flood_battlechatter_on(1);
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
}

streets_to_dam_2() {
  level thread make_enemies_miss_player_at_first();
  level thread streets_to_dam_wave_2_sequence();
  level thread dialogue_streets_to_dam_2();
  level thread harassers_ignore_player();
  level thread streets_to_dam_heli_flyover_hover();
  level thread teleport_failsafe();
  level thread flood_shake_tree();
  level thread hide_missile_launcher_collision();
  level thread m880_connect_path_nodes(1);
  level thread spawn_dam_harrassers();
  level thread fake_mantle_text();
  level notify("going_to_start_convoy_section");
  common_scripts\utility::flag_set("missile_launcher_destruction_done");
  var_0 = getent("aim_missiles_2", "targetname");
  var_0 waittill("trigger");
  level notify("end_of_streets_to_dam_2");
}

put_launcher_in_place() {
  var_0 = getent("missile_launcher_2", "targetname");
  var_0.origin = (-1643, -6966, -64);
  var_0.angles = (0, 66.5, 0);
  var_0 show();
}

make_enemies_miss_player_at_first() {
  var_0 = level.player.gs.player_attacker_accuracy;
  level.player maps\_utility::set_player_attacker_accuracy(0.0);
  var_1 = getent("streets_to_dam_first_retreat", "targetname");

  if(isDefined(var_1))
    var_1 common_scripts\utility::waittill_notify_or_timeout("trigger", 4.0);

  level.player maps\_utility::set_player_attacker_accuracy(0.1);
  var_1 = getent("streets_to_dam_wave_2_first_advance", "targetname");

  if(isDefined(var_1))
    var_1 common_scripts\utility::waittill_notify_or_timeout("trigger", 6.0);

  level.player maps\_utility::set_player_attacker_accuracy(var_0);
}

streets_to_dam_2_side_guys_spawn_logic() {
  level.side_guys = [];
  var_0 = getEntArray("streets_to_dam_wave_2_side", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, ::streets_to_dam_wave_2_side_spawn_func);
  common_scripts\utility::array_thread(var_0, maps\_utility::spawn_ai);
}

streets_to_dam_wave_2_sequence() {
  var_0 = ["streets_to_dam_wave_2_1_trigger", "streets_to_dam_wave_2_first_advance", "streets_to_dam_wave_2_5_spawn", "streets_to_dam_wave_2_2_trigger", "streets_to_dam_wave_2_second_advance", "streets_to_dam_final_advance", "streets_to_dam_3_5_advance", "streets_to_dam_enemy_retreat"];
  level thread throw_grenade_if_player_behind_tank();
  level thread adjust_suppression_on_enemies();
  var_1 = getent("crashed_tank", "targetname");

  if(isDefined(var_1))
    var_1 hide();

  var_2 = getent("streets_to_dam_wave_2_start", "targetname");
  var_2 notify("trigger");
  var_3 = getEntArray("streets_to_dam_wave_2_first", "targetname");
  common_scripts\utility::array_thread(var_3, maps\_utility::add_spawn_function, ::streets_to_dam_wave_2_first_spawn_func);
  common_scripts\utility::array_thread(var_3, maps\_utility::spawn_ai);

  foreach(var_5 in level.side_guys)
  var_5 notify("stop_ignoring_player");

  common_scripts\utility::flag_wait("missile_launcher_destruction_done");
  var_3 = getEntArray("streets_to_dam_wave_2", "targetname");
  common_scripts\utility::array_thread(var_3, maps\_utility::add_spawn_function, ::streets_to_dam_wave_2_spawn_func);
  common_scripts\utility::array_thread(var_3, maps\_utility::spawn_ai);
  wait 0.1;
  var_7 = getEntArray("streets_to_dam_wave_2_1", "targetname");
  common_scripts\utility::array_thread(var_7, maps\_utility::add_spawn_function, ::streets_to_dam_wave_2_1_spawn_func);
  wait 0.1;
  common_scripts\utility::array_thread(var_7, maps\_utility::spawn_ai);
  maps\flood_util::waittill_aigroupcount_or_trigger_targetname("streets_to_dam_wave_2", 9, "streets_to_dam_wave_2_first_advance");
  trigger_named_and_turn_off_prior(var_0, "streets_to_dam_wave_2_first_advance");
  wait 0.1;
  maps\flood_util::waittill_aigroupcount_or_trigger_targetname("streets_to_dam_wave_2", 7, "streets_to_dam_wave_2_2_trigger");
  trigger_named_and_turn_off_prior(var_0, "streets_to_dam_wave_2_2_trigger");
  var_7 = getEntArray("streets_to_dam_wave_2_5", "targetname");
  common_scripts\utility::array_thread(var_7, maps\_utility::add_spawn_function, ::streets_to_dam_wave_2_5_spawn_func);
  common_scripts\utility::array_thread(var_7, maps\_utility::spawn_ai);
  wait 0.1;
  level thread send_allies_to_nodes_and_play_anim();
  maps\flood_util::waittill_aigroupcount_or_trigger_targetname("streets_to_dam_wave_2", 1, "streets_to_dam_3_5_advance");
  streets_to_dam_2_staggered_retreat();
  maps\flood_util::waittill_aigroupcount_or_trigger_targetname("streets_to_dam_wave_2", 1, "streets_to_dam_final_advance");
  var_2 = getent("streets_to_dam_final_advance", "targetname");

  if(isDefined(var_2)) {
    var_2 notify("trigger");
    wait 0.1;
  }

  maps\flood_util::waittill_aigroupcount_or_trigger_targetname("streets_to_dam_wave_2", 1, "streets_to_dam_enemy_retreat");
  trigger_named_and_turn_off_prior(var_0, "streets_to_dam_enemy_retreat");
  var_8 = getent("final_advance_kill_volume", "targetname");
  kill_deathflag_in_area("streets_to_dam_wave_2", var_8, 0);
  var_9 = getent("dam_far_goal_volume", "targetname");
  var_3 = maps\_utility::get_ai_group_ai("streets_to_dam_wave_2");

  if(var_3.size > 4) {
    foreach(var_5 in var_3)
    var_5.favoriteenemy = level.player;
  } else {
    foreach(var_5 in var_3) {
      if(isDefined(var_5) && isalive(var_5)) {
        var_5 setgoalvolumeauto(var_9);
        wait(randomfloatrange(0.1, 0.5));
      }
    }
  }
}

throw_grenade_if_player_behind_tank() {
  var_0 = getent("streets_to_dam_grenade_check", "targetname");
  var_0 waittill("trigger");
  wait 2.0;

  if(level.player istouching(var_0)) {
    var_1 = getaiarray("axis");

    foreach(var_3 in var_1)
    var_3 thread maps\_utility::throwgrenadeatplayerasap();
  }
}

adjust_suppression_on_enemies() {
  for(;;) {
    var_0 = getent("streets_to_dam_3_5_advance", "targetname");

    if(isDefined(var_0)) {
      var_1 = getaiarray("axis");

      if(var_1.size > 5) {
        var_1 = common_scripts\utility::get_array_of_farthest(level.player.origin, var_1);
        var_2 = var_1.size - 5;

        for(var_3 = 0; var_3 < var_1.size; var_3++) {
          if(var_3 < var_2) {
            var_1[var_3].suppressionwait = 5;
            continue;
          }

          var_1[var_3].suppressionwait = 1;
        }
      }
    } else
      break;

    wait 0.1;
  }
}

streets_to_dam_2_staggered_retreat() {
  var_0 = maps\_utility::get_ai_group_ai("streets_to_dam_wave_2");
  var_0 = common_scripts\utility::get_array_of_farthest(level.player.origin, var_0);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_1 < 3 || var_0.size > 5) {
      if(var_0.size > 5)
        var_0[var_1].favoriteenemy = level.player;

      var_2 = getent("streets_to_dam_goal_volume_3_5", "targetname");
    } else {
      var_0[var_1] ignore_everything();
      var_2 = getent("dam_far_goal_volume", "targetname");
    }

    var_0[var_1] setgoalvolumeauto(var_2);
  }
}

streets_to_dam_wave_2_spawn_func() {
  self endon("death");
  self.favoriteenemy = level.player;
  var_0 = getent("streets_to_dam_goal_volume_2", "targetname");
  self setgoalvolumeauto(var_0);
  var_1 = getent("streets_to_dam_wave_2_2_trigger", "targetname");
  var_1 waittill("trigger");
  var_0 = getent("streets_to_dam_goal_volume_3", "targetname");
  self setgoalvolumeauto(var_0);
  var_1 = getent("streets_to_dam_wave_2_second_advance", "targetname");
  var_1 waittill("trigger");
  var_0 = getent("streets_to_dam_goal_volume_3_mid", "targetname");
  self setgoalvolumeauto(var_0);
}

streets_to_dam_wave_2_1_spawn_func() {
  self endon("death");
  var_0 = getent("streets_to_dam_goal_volume_2_5", "targetname");
  self setgoalvolumeauto(var_0);
  var_1 = getent("streets_to_dam_wave_2_second_advance", "targetname");
  var_1 waittill("trigger");
  var_0 = getent("streets_to_dam_goal_volume_3_mid", "targetname");
  self setgoalvolumeauto(var_0);
}

streets_to_dam_wave_2_5_spawn_func() {
  self endon("death");
  var_0 = getent("streets_to_dam_goal_volume_3", "targetname");
  self setgoalvolumeauto(var_0);
  var_1 = getent("streets_to_dam_wave_2_second_advance", "targetname");
  var_1 waittill("trigger");
  var_0 = getent("streets_to_dam_goal_volume_3_mid", "targetname");
  self setgoalvolumeauto(var_0);
}

streets_to_dam_wave_2_first_spawn_func() {
  self endon("death");
  var_0 = getent("streets_to_dam_goal_volume_2_first", "targetname");
  self setgoalvolumeauto(var_0);

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "exposed_guy")
    thread exposed_guy_think();
  else {
    self.favoriteenemy = level.player;
    common_scripts\utility::flag_wait("missile_launcher_destruction_done");
    self.favoriteenemy = level.player;
    var_1 = getent("streets_to_dam_wave_2_1_trigger", "targetname");
    var_1 waittill("trigger");
    var_1 = getent("streets_to_dam_wave_2_first_advance", "targetname");
    common_scripts\utility::waittill_notify_or_timeout_return("trigger", randomfloatrange(5.0, 7.0));
    wait(randomfloat(2.0));
    var_0 = getent("streets_to_dam_goal_volume_2_5", "targetname");
    self setgoalvolumeauto(var_0);
  }

  var_1 = getent("streets_to_dam_wave_2_second_advance", "targetname");

  if(isDefined(var_1))
    var_1 waittill("trigger");

  var_0 = getent("streets_to_dam_goal_volume_3_mid", "targetname");
  self setgoalvolumeauto(var_0);
}

streets_to_dam_wave_2_side_spawn_func() {
  self endon("death");
  level.side_guys[level.side_guys.size] = self;
  ignore_everything(0.0);
  self waittill("stop_ignoring_player");
  clear_ignore_everything();
  var_0 = getent("streets_to_dam_2_side_goal_volume", "targetname");
  self setgoalvolumeauto(var_0);
  var_1 = getent("streets_to_dam_wave_2_first_advance", "targetname");
  var_1 waittill("trigger");
  var_0 = getent("streets_to_dam_2_side_2_goal_volume", "targetname");
  self setgoalvolumeauto(var_0);
  var_1 = getent("streets_to_dam_wave_2_5_spawn", "targetname");
  var_1 waittill("trigger");
  var_2 = getent("force_retreat_volume", "targetname");

  if(self istouching(var_2)) {
    thread ignore_everything(3.0);
    var_3 = getnode("force_retreat_goal_node", "targetname");
    self setgoalnode(var_3);
  }

  var_1 = getent("streets_to_dam_wave_2_2_trigger", "targetname");

  if(isDefined(var_1))
    var_1 waittill("trigger");

  var_0 = getent("streets_to_dam_goal_volume_3", "targetname");
  self setgoalvolumeauto(var_0);
  var_1 = getent("streets_to_dam_wave_2_second_advance", "targetname");
  var_1 waittill("trigger");
  var_0 = getent("streets_to_dam_goal_volume_3_mid", "targetname");
  self setgoalvolumeauto(var_0);
}

spawn_dam_harrassers() {
  var_0 = getent("streets_to_dam_final_advance", "targetname");
  var_0 waittill("trigger");
  var_1 = getEntArray("dam_missile_harassers", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::streets_to_dam_2_harrassers_spawn_func);
  common_scripts\utility::array_thread(var_1, maps\_utility::spawn_ai);
  var_1 = getEntArray("dam_missile_harassers_close", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::streets_to_dam_2_harrassers_close_spawn_func);
  common_scripts\utility::array_thread(var_1, maps\_utility::spawn_ai);
}

spawn_dam_harrassers_fake() {
  var_0 = getent("streets_to_dam_final_advance", "targetname");
  var_0 waittill("trigger");
  var_1 = getEntArray("dam_missile_harassers_fake", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::streets_to_dam_2_harrassers_spawn_func);
  common_scripts\utility::array_thread(var_1, maps\_utility::spawn_ai);
  var_1 = getEntArray("dam_missile_harassers_close_fake", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::streets_to_dam_2_harrassers_close_spawn_func);
  common_scripts\utility::array_thread(var_1, maps\_utility::spawn_ai);
}

streets_to_dam_2_harrassers_spawn_func() {
  var_0 = getent("dam_far_goal_volume", "targetname");
  self setgoalvolumeauto(var_0);
  self.ignoresuppression = 1;
  wait 0.5;
  self.ignoreall = 0;
}

streets_to_dam_2_harrassers_close_spawn_func() {
  var_0 = getent("dam_far_goal_volume_close", "targetname");
  self setgoalvolumeauto(var_0);
  self.ignoresuppression = 1;
  wait 0.5;
  self.ignoreall = 0;
}

exposed_guy_think() {
  self endon("death");
  ignore_everything(0.0);
  var_0 = getnode("exposed_guy_node_first", "targetname");
  self setgoalnode(var_0);
  var_1 = self.goalradius;
  self.goalradius = 16;
  self waittill("goal");
  self.goalradius = var_1;
  var_2 = getent("streets_to_dam_wave_2_1_trigger", "targetname");

  if(isDefined(var_2))
    var_2 common_scripts\utility::waittill_notify_or_timeout("trigger", 20.0);

  var_3 = getent("exposed_node_first", "targetname");
  self setgoalvolumeauto(var_3);
  var_0 = getnode("node_exposed", "targetname");
  self setgoalnode(var_0);
  var_1 = self.goalradius;
  self.goalradius = 16;
  self waittill("goal");
  clear_ignore_everything();
  self.goalradius = var_1;
  var_2 = getent("streets_to_dam_wave_2_5_spawn", "targetname");

  if(isDefined(var_2))
    var_2 waittill("trigger");

  var_4 = getent("streets_to_dam_goal_volume_2_5", "targetname");
  self setgoalvolumeauto(var_4);
}

send_allies_to_nodes_and_play_anim() {
  var_0 = getent("streets_to_dam_enemy_retreat", "targetname");
  var_0 waittill("trigger");
  var_1 = getnode("streets_to_dam_2_ally_0_node", "targetname");
  level.allies[0] setgoalnode(var_1);
  var_1 = getnode("streets_to_dam_2_ally_2_node", "targetname");
  level.allies[1] setgoalnode(var_1);
  var_1 = getnode("streets_to_dam_2_ally_1_node", "targetname");
  level.allies[2] setgoalnode(var_1);
  common_scripts\utility::flag_wait("looked_at_missiles_failsafe");
  level.allies[0] notify("player_now_on_ladder");
  level.allies[2] notify("player_now_on_ladder");
}

kill_deathflag_in_area(var_0, var_1, var_2) {
  if(!isDefined(level.flag[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 0;

  foreach(var_4 in level.deathflags[var_0]) {
    foreach(var_6 in var_4) {
      if(isalive(var_6)) {
        if(var_6 istouching(var_1))
          var_6 thread maps\_utility_code::kill_deathflag_proc(var_2);

        continue;
      }

      var_6 delete();
    }
  }
}

delete_corpse_in_volume(var_0) {
  if(self istouching(var_0))
    self delete();
}

fake_mantle_text() {
  var_0 = getent("fake_mantle_trigger", "targetname");
  var_1 = getent(var_0.target, "targetname");
  var_2 = 1;

  while(!common_scripts\utility::flag("end_of_dam")) {
    var_3 = level.player getvelocity();

    if(level.player istouching(var_0)) {
      if(!var_2) {
        var_2 = 1;
        var_1 movez(1000, 0.1);
        wait 0.1;
      }
    } else if(var_2) {
      var_2 = 0;
      var_1 movez(-1000, 0.1);
      wait 0.1;
    }

    wait 0.1;
  }
}

dialogue_streets_to_dam_2() {
  wait 3;
  var_0 = 3;

  if(common_scripts\utility::flag("played_radio_part_1") && !common_scripts\utility::flag("played_radio_part_2")) {
    common_scripts\utility::flag_set("played_radio_part_2");
    maps\_utility::smart_radio_dialogue("flood_gs1_rogeroverlordwehave");
    var_0--;
    var_0--;
  }

  wait(var_0);
  maps\_utility::battlechatter_off("allies");
  level.allies[0] maps\_utility::smart_dialogue("flood_bkr_launcherdown");
  level.allies[1] maps\_utility::smart_dialogue("flood_diz_stillonemore");
  level.allies[0] maps\_utility::smart_dialogue("flood_bkr_blowthatonetoo");
  common_scripts\utility::flag_set("launcher_2_objective_given");
  maps\_utility::battlechatter_on("allies");
  var_1 = getent("streets_to_dam_final_advance", "targetname");
  wait 3.0;

  if(isDefined(var_1)) {
    maps\_utility::battlechatter_off("allies");
    wait 1.0;
  }

  wait 3.0;

  if(isDefined(var_1)) {
    level.allies[1] maps\_utility::smart_dialogue("flood_vrg_wevegotabouta");
    wait 1.0;
  }

  if(isDefined(var_1))
    level.allies[0] maps\_utility::smart_dialogue("flood_pri_wecantletthat");

  if(isDefined(var_1) && !common_scripts\utility::flag("played_radio_part_1")) {
    common_scripts\utility::flag_set("played_radio_part_1");
    maps\_utility::smart_radio_dialogue("flood_hqr_beadvisedenemyforces");
  }

  if(isDefined(var_1) && !common_scripts\utility::flag("played_radio_part_2")) {
    common_scripts\utility::flag_set("played_radio_part_2");
    maps\_utility::smart_radio_dialogue("flood_gs1_rogeroverlordwehave");
  }

  maps\_utility::battlechatter_on("allies");

  if(isDefined(var_1))
    var_1 waittill("trigger");

  maps\_utility::battlechatter_off("allies");
  level.allies[0] thread maps\_utility::smart_dialogue("flood_bkr_getaway");
  maps\_utility::battlechatter_on("allies");
}

streets_to_dam_heli_flyover() {
  var_0 = getent("trig_dam_heli_flyover", "targetname");
  var_0 waittill("trigger");
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("streets_dam_flyover_1_blackhawk");
  var_1.path_gobbler = 1;
  var_1.script_vehicle_selfremove = 1;
  var_1 vehicle_setspeed(60);
  var_1 maps\_vehicle::gopath();
  var_1 vehicle_turnengineoff();
  var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("streets_dam_flyover_2_blackhawk");
  var_2.path_gobbler = 1;
  var_2.script_vehicle_selfremove = 1;
  var_2 vehicle_setspeed(60);
  var_2 maps\_vehicle::gopath();
  var_2 vehicle_turnengineoff();
}

streets_to_dam_heli_flyover_hover() {
  var_0 = getent("trig_dam_heli_flyover_hover", "targetname");
  var_0 waittill("trigger");
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("streets_dam_flyover_3_blackhawk");
  var_1.path_gobbler = 1;
  var_1 vehicle_setspeed(75);
  var_1 thread maps\flood_audio::sfx_heli_dam_passby();
  var_1 maps\_vehicle::gopath();
  var_1 vehicle_turnengineoff();
  var_1 waittill("reached_dynamic_path_end");
  var_1 delete();
}

dam_heli_flyover_hover() {}

streets_to_dam_heli_far_flyby() {
  var_0 = getent("trig_dam_heli_far_flyby", "targetname");
  var_0 waittill("trigger");
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("streets_dam_far_flyby_1_blackhawk");
  var_1.path_gobbler = 1;
  var_1.script_vehicle_selfremove = 1;
  var_1 vehicle_setspeed(100);
  var_1 maps\_vehicle::gopath();
  var_1 vehicle_turnengineoff();
  var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("streets_dam_far_flyby_2_blackhawk");
  iprintlnbold("these guys 01???");
  var_2.path_gobbler = 1;
  var_2.script_vehicle_selfremove = 1;
  var_2 vehicle_setspeed(100);
  var_2 maps\_vehicle::gopath();
  var_2 vehicle_turnengineoff();
  var_3 = common_scripts\utility::getstruct("streets_dam_far_flyby_1", "targetname");

  while(distancesquared(var_3.origin, var_1.origin) > 100)
    wait 0.05;

  var_1 delete();
  var_2 delete();
}

remove_streets_ents() {
  delete_ent_by_targetname("streets_start");
  delete_ent_by_targetname("streets_ally_0");
  delete_ent_by_targetname("streets_ally_2");
  delete_ent_by_targetname("streets_ally_1");
  delete_ent_by_targetname("enemy_tank_2_garage_target");
  delete_ent_by_targetname("enemy_tank_3_post_garage_target");
  delete_ent_by_targetname("bullet_target_4");
  delete_ent_by_targetname("humvee_missile_start");
  delete_ent_by_targetname("streets_to_dam_start");
  delete_ent_by_targetname("streets_to_dam_ally_0");
  delete_ent_by_targetname("streets_to_dam_ally_1");
  delete_ent_by_targetname("streets_to_dam_bullet_origin");
  delete_ent_by_targetname("missile_smoke_origin_3");
  delete_ent_by_targetname("bullet_origin_2");
  delete_ent_by_targetname("allied_tank_infil_destroyed");
  delete_ent_by_targetname("enemy_tank_infil_destroyed");
  delete_ent_by_targetname("streets_destroyed_tank_01");
  delete_ent_by_targetname("streets_destroyed_tank_02");
  delete_ent_by_targetname("enemy_tank");
  delete_ent_by_targetname("allied_tank");
  delete_ent_by_targetname("allied_tank_2");
  delete_ent_by_targetname("streets_enemy_tank_soldiers");
  delete_ent_by_targetname("enemy_convoy_vehicles_infil");
  delete_ent_by_targetname("enemy_tank_3");
  delete_ent_by_targetname("enemy_tank_2");
  delete_ent_by_targetname("streets_wave_2");
  delete_ent_by_targetname("enemy_tank_2_mock_1");
  delete_ent_by_targetname("allied_tank_2_mock");
  delete_ent_by_targetname("allied_tank_mock");
  delete_ent_by_targetname("street_start_allies");
  delete_ent_by_targetname("allied_tank_2_fake");
  delete_ent_by_script_noteworthy("planter");
  delete_ent_by_script_noteworthy("planter_07");
  delete_ent_by_script_noteworthy("planter_06");
  delete_ent_by_script_noteworthy("planter_08");
  delete_ent_by_script_noteworthy("planter_02");
}

remove_streets_to_dam_ents() {
  thread maps\flood_anim::m880_cleanup();
  var_0 = getweaponarray();

  foreach(var_2 in var_0)
  var_2 delete();

  delete_ent_by_targetname("enemy_convoy_vehicles_launcher");
  delete_ent_by_targetname("enemy_convoy_vehicles_tank");
  delete_ent_by_targetname("enemy_convoy_vehicles");
  delete_ent_by_targetname("enemy_convoy_vehicles_broken");
  delete_ent_by_targetname("missile_launcher_2");
  delete_ent_by_targetname("crashed_m880");
  delete_ent_by_targetname("streets_to_dam_tank_shoot_at_player");
  delete_ent_by_targetname("streets_to_dam_tank_kill_player");
  delete_ent_by_targetname("streets_to_dam_convoy");
  delete_ent_by_targetname("streets_to_dam_wave_1_vignette_extra");
  delete_ent_by_targetname("streets_to_dam_wave_1_street_patrol");
  delete_ent_by_targetname("streets_to_dam_wave_1_vignette");
  delete_ent_by_targetname("streets_to_dam_wave_1");
  delete_ent_by_targetname("streets_to_dam_wave_1_rpg");
  delete_ent_by_targetname("streets_to_dam_heli_target_2");
  delete_ent_by_targetname("streets_to_dam_heli_target_1");
  delete_ent_by_targetname("streets_to_dam_extra_waver_node");
  delete_ent_by_targetname("streets_to_dam_heli_target_3");
  delete_ent_by_targetname("streets_to_dam_heli_target_4");
  delete_ent_by_targetname("streets_to_dam_rpg_target_1");
  delete_ent_by_targetname("m880_kill_teleport");
  delete_ent_by_targetname("post_missile_launcher_location_ally3");
  delete_ent_by_targetname("post_missile_launcher_location_ally2");
  delete_ent_by_targetname("streets_to_dam_2_ally_1");
  delete_ent_by_targetname("post_missile_launcher_location");
  delete_ent_by_targetname("streets_to_dam_2_ally_0");
  delete_ent_by_targetname("streets_to_dam_rpg_target_2");
  delete_ent_by_targetname("clip_after_m880_crash");
  delete_ent_by_script_noteworthy("planter");
  delete_ent_by_script_noteworthy("streets_helicopter_crash_location");
}

delete_ent_by_targetname(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(isDefined(var_1)) {
    if(!isarray(var_1))
      var_1 = maps\_utility::make_array(var_1);

    foreach(var_3 in var_1) {
      if(isDefined(var_3))
        var_3 delete();
    }
  }
}

delete_ent_by_script_noteworthy(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");

  if(isDefined(var_1)) {
    if(!isarray(var_1))
      var_1 = maps\_utility::make_array(var_1);

    foreach(var_3 in var_1) {
      if(isDefined(var_3))
        var_3 delete();
    }
  }
}

flood_shake_tree() {
  var_0 = [];
  var_0[0] = "flood_shake_tree_left_1";
  var_0[1] = "flood_shake_tree_left_2";
  var_0[2] = "flood_shake_tree_left_3";
  var_0[3] = "flood_shake_tree_left_4";
  var_0[4] = "flood_shake_tree_left_5";
  var_0[5] = "flood_shake_tree_right_1";
  var_0[6] = "flood_shake_tree_right_2";
  var_0[7] = "flood_shake_tree_right_3";
  var_0[8] = "flood_shake_tree_right_4";
  var_0[9] = "flood_shake_tree_right_5";
  var_0[10] = "flood_shake_tree_right_6";

  foreach(var_2 in var_0) {
    var_3 = getent(var_2, "script_noteworthy");
    var_3 thread flood_shake_tree_internal();
  }
}

flood_shake_tree_internal() {
  level waittill(self.script_noteworthy);

  if(randomfloat(1.0) < 0.3333)
    playFXOnTag(level._effect["birds_flood_street_birds_01"], self, "J_Tip2_Tall2");
  else if(self.script_noteworthy == "flood_shake_tree_right_4" || self.script_noteworthy == "flood_shake_tree_left_4" || self.script_noteworthy == "flood_shake_tree_right_5" || self.script_noteworthy == "flood_shake_tree_right_6")
    playFXOnTag(level._effect["birds_flood_street_birds_01"], self, "J_Tip2_Tall2");

  var_0 = 1;
  var_1 = 1 + randomfloat(0.4);
  self setanimknobrestart(level.anim_prop_models[self.model]["flood"], var_0, 0.02, var_1);
}

dam_start() {
  maps\flood_util::player_move_to_checkpoint_start("dam_start");
  maps\flood_util::spawn_allies();
  level thread spawn_dam_harrassers_fake();
  level thread harassers_ignore_player();
  level thread aim_missiles_2();
  level thread dam_heli_flyover_hover();
  level thread trigger_missile_launcher_aim_flag();
  level thread hide_spire();
  level thread send_allies_to_nodes_and_play_anim();
  level thread flood_shake_tree();
  level thread fake_mantle_text();
  level thread maps\flood_util::flood_battlechatter_on(1);
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
  wait 0.5;
  var_0 = getent("streets_to_dam_final_advance", "targetname");
  var_0 notify("trigger");
}

dam() {
  common_scripts\utility::flag_wait("missiles_ready");
  thread maps\_utility::autosave_by_name("before_dam_break");
  level thread fire_missiles();
  level thread dialogue_dam();
  common_scripts\utility::flag_wait("start_flood");
  level.dam_break_weapon = level.player getcurrentweapon();
  level thread remove_allies();
  level thread ignore_player(0);
  common_scripts\utility::flag_wait("looked_at_missiles_failsafe");
  level maps\_utility::delaythread(1, ::remove_streets_to_dam_ents);
  common_scripts\utility::flag_wait("vignette_dam_break_end_flag");
  common_scripts\utility::flag_set("end_of_dam");
}

trigger_missile_launcher_aim_flag() {
  common_scripts\utility::flag_set("vignette_dam_break_m880_launch_prep");
}

harassers_ignore_player() {
  var_0 = getent("streets_to_dam_final_advance", "targetname");
  var_0 waittill("trigger");
  var_1 = 1;

  while(var_1) {
    var_2 = getent("streets_to_dam_goal_volume_3", "targetname");
    var_3 = var_2 maps\_utility::get_ai_touching_volume("axis");
    var_4 = var_3.size;
    var_2 = getent("dam_remove_dead_bodies", "targetname");
    var_3 = var_2 maps\_utility::get_ai_touching_volume("axis");
    var_4 = var_4 + var_3.size;

    if(var_4 > 0) {
      wait 0.1;
      continue;
    }

    var_1 = 0;
  }

  level thread ignore_player(1);
}

ignore_player(var_0) {
  level.player.ignoreme = var_0;
}

aim_missiles_2() {
  common_scripts\utility::flag_wait("vignette_dam_break_m880_launch_prep");
  wait 1.0;
  thread maps\flood_audio::sfx_missile_buzzer(level.dam_break_m880, "sfx_missiles_launched");
  common_scripts\utility::exploder("m880_redlight");
  wait 1.5;
  thread maps\flood_audio::sfx_rocket_aiming_sound();
  common_scripts\utility::flag_set("missiles_ready");
  level thread c4_spot_glow();
}

spawn_ml_drivers() {
  var_0 = getEntArray("dam_missile_drivers", "targetname");

  foreach(var_2 in var_0)
  var_2 maps\_utility::add_spawn_function(::ml_driver_spawn_func);

  maps\_utility::array_spawn(var_0);
}

ml_driver_spawn_func() {
  ignore_everything();
  var_0 = getent("missile_launcher_driver_kill_trigger", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1) && self == var_1) {
      break;
    }
  }

  clear_ignore_everything();
  var_2 = getent("dam_far_goal_volume", "targetname");
  set_goal_volume(var_2);
}

fire_missiles() {
  level thread missile_launch_failsafe();
  common_scripts\utility::flag_wait_any("looked_at_missiles", "looked_at_missiles_failsafe");
  level thread remove_live_grenades();
  level thread remove_stuff_for_animation();
  level thread remove_dyn_objects();
  var_0 = getent("dam_remove_dead_bodies", "targetname");
  common_scripts\utility::array_thread(getcorpsearray(), ::delete_corpse_in_volume, var_0);
  wait 0.1;
  level thread kill_enemies();
  wait 1.0;
  level thread retreat_dam_harassers();
  wait 3.0;
  wait 1.0;
  common_scripts\utility::flag_set("start_flood");
}

fade_to_black(var_0, var_1, var_2) {
  level.black_overlay = maps\_hud_util::create_client_overlay("black", 0, level.player);
  level.black_overlay fadeovertime(var_0);
  level.black_overlay.alpha = 1;
  wait(var_0);
  common_scripts\utility::flag_set("level_faded_to_black");
  wait(var_1);

  if(isDefined(var_2)) {
    level.black_overlay fadeovertime(var_2);
    level.black_overlay.alpha = 0;
  }
}

c4_spot_glow() {
  var_0 = level.dam_break_m880;
  var_1 = "vehicle_m880_launcher_obj";
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("vehicle_m880_launcher_obj");
  var_2.angles = var_0.angles;
  common_scripts\utility::flag_wait("looked_at_missiles_failsafe");
  wait 0.5;
  var_2 delete();
}

manage_mantles() {
  var_0 = getEntArray("mantle_trigger", "targetname");

  foreach(var_2 in var_0)
  var_2 thread show_hide_mantle();
}

show_hide_mantle() {
  var_0 = getent(self.target, "targetname");
  var_1 = 0;
  var_0 movez(-1000, 0.1);

  while(!common_scripts\utility::flag("end_of_dam")) {
    if(level.player istouching(self)) {
      if(!var_1) {
        var_1 = 1;
        var_0 movez(1000, 0.1);
      }
    } else if(var_1) {
      var_1 = 0;
      var_0 movez(-1000, 0.1);
    }

    common_scripts\utility::waitframe();
  }
}

kill_enemies() {
  wait 0.5;
  var_0 = getaiarray("axis");

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2) && isalive(var_2)) {
        var_2.no_pain_sound = 1;
        var_2.diequietly = 1;
        var_2 kill();
        wait(randomfloatrange(0.05, 0.25));
      }
    }
  }
}

retreat_dam_harassers() {
  var_0 = maps\_utility::get_ai_group_ai("dam_missile_harassers");
  var_0 set_group_goalvolume("dam_harrassers_retreat_goal_volume");
}

push_player_around(var_0) {
  level.player pushplayervector((0, var_0, 0));
  wait 0.1;
  level.player pushplayervector((0, var_0 / 2, 0));
  wait 0.1;
  level.player pushplayervector((0, var_0 / 4, 0));
  wait 0.2;
  level.player pushplayervector((0, 0, 0));
}

temp_missile_impacts() {
  var_0 = getEntArray("missile_impact_origin", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1]))
      playFX(level._effect["temp_missile_impact"], var_0[var_1].origin);

    var_2 = randomfloatrange(0.25, 1.0);
    wait(var_2);
  }
}

missile_launch_failsafe() {
  common_scripts\utility::flag_wait("vignette_dam_break");
  common_scripts\utility::flag_set("looked_at_missiles_failsafe");
}

flee_from_flood() {
  var_0 = maps\_utility::get_ai_group_ai("advancing_allies");
  var_0 set_group_goalvolume("post_dam_flee");
}

ignore_everything(var_0) {
  self endon("death");
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  maps\_utility::disable_pain();
  self.dontavoidplayer = 1;
  self.og_newenemyreactiondistsq = self.newenemyreactiondistsq;
  self.newenemyreactiondistsq = 0;

  if(isDefined(var_0) && var_0 != 0.0) {
    wait(var_0);
    clear_ignore_everything();
  }
}

clear_ignore_everything() {
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.disablebulletwhizbyreaction = 0;
  maps\_utility::enable_pain();
  self.dontavoidplayer = 0;
  self.script_dontpeek = 0;

  if(isDefined(self.og_newenemyreactiondistsq))
    self.newenemyreactiondistsq = self.og_newenemyreactiondistsq;
}

dialogue_dam() {
  var_0 = getent("aim_missiles_2", "targetname");
  var_0 waittill("trigger");

  if(isDefined(level.e3_demo))
    wait 3.0;

  maps\_utility::battlechatter_off("allies");

  if(!common_scripts\utility::flag("looked_at_missiles_failsafe"))
    level.allies[0] maps\_utility::smart_dialogue("flood_pri_takethatlauncherout");

  if(level.start_point == "dam")
    wait 3.0;

  wait 1.0;

  if(!common_scripts\utility::flag("looked_at_missiles_failsafe"))
    level.allies[1] maps\_utility::smart_dialogue("flood_diz_samsgonnafire");

  if(isDefined(level.e3_demo))
    wait 0.5;

  if(!common_scripts\utility::flag("looked_at_missiles_failsafe"))
    level.allies[2] maps\_utility::smart_dialogue("flood_mrk_whatthehellis");

  wait 0.5;

  if(!common_scripts\utility::flag("looked_at_missiles_failsafe"))
    level.allies[0] maps\_utility::smart_dialogue("flood_bkr_gotyoucovered");

  if(!common_scripts\utility::flag("looked_at_missiles_failsafe"))
    level.allies[0] thread streets_nag_end_on_notify(maps\_utility::make_array("flood_pri_takethatlauncherout", "flood_bkr_gotyoucovered", "flood_bkr_stopsequence"), "looked_at_missiles_failsafe", "flag_set");

  common_scripts\utility::flag_wait("looked_at_missiles_failsafe");
  level.allies[0] stopsounds();
  level.allies[1] stopsounds();
  level.allies[2] stopsounds();
  level.allies[0] notify("flag_set");
}

remove_allies() {
  var_0 = maps\_utility::get_ai_group_ai("street_start_allies");

  if(var_0.size > 0) {
    foreach(var_2 in var_0)
    var_2 delete();
  }
}

remove_live_grenades() {
  var_0 = getEntArray("grenade", "classname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1]))
      var_0[var_1] delete();
  }
}

remove_dyn_objects() {
  physicsexplosionsphere(level.player.origin, 310, 300, 2.0);
}

remove_stuff_for_animation() {
  wait 2.0;
  var_0 = getEntArray("dam_break_delete", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1]))
      var_0[var_1] delete();
  }
}

add_dam_vignette_hud_overlay() {
  self.hud_overlay = create_hud_static_overlay("flood_ui_vignette", 0, 0.0);
  var_0 = 0;
  var_1 = 7.5;

  while(var_0 < 75) {
    self.hud_overlay.alpha = var_0 / 100;
    var_0 = var_0 + var_1;
    wait 0.1;
  }

  common_scripts\utility::flag_wait("vignette_lens_fade_out");
  var_1 = 4;

  while(var_0 > 0) {
    self.hud_overlay.alpha = var_0 / 100;
    var_0 = var_0 - var_1;
    wait 0.1;
  }

  self.hud_overlay destroy();
}

create_hud_static_overlay(var_0, var_1, var_2) {
  var_3 = newhudelem();
  var_3.x = 0;
  var_3.y = 0;
  var_3.sort = var_1;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.alpha = var_2;
  var_3 setshader(var_0, 640, 480);
  return var_3;
}

hide_spire() {
  var_0 = getent("flood_church_spire", "targetname");
  var_0 hide();
}

mlrs_qte_prompt() {
  maps\flood_ending::ending_create_qte_prompt(&"FLOOD_LAUNCHER_MELEE", undefined);
  thread maps\flood_ending::ending_fade_qte_prompt(0.5, 1.0);
  common_scripts\utility::flag_wait("qte_window_closed");
  maps\flood_ending::ending_fade_qte_prompt(0.25, 0.0);
  maps\flood_ending::ending_destroy_qte_prompt();
}

dam_waterfall_hide() {
  wait 8.3;
  var_0 = getEntArray("dam_waterfall_to_hide", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();
}