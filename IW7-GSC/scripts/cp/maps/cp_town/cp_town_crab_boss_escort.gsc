/****************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_crab_boss_escort.gsc
****************************************************************/

start_escort_sequence() {
  precachempanim("iw7_cp_bosscrab_emerge_slingshot_nuke_01");
  if(scripts\engine\utility::istrue(level.debug_start_crab_boss)) {
    level waittill("crab_boss_ready_for_combat");
  }

  if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    teleport_players_to_beach();
  }

  wait(2.3);
  equip_bomb();
  level thread play_escort_intro_vo();
  scripts\engine\utility::flag_wait("crab_boss_combat_ready");
  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(4, 4, 4, 4);
  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1.5, 1.5, 1.5, 1.5);
  scripts\engine\utility::flag_set("crab_boss_zombie_spawn");
  level.disable_loot_fly_to_player = 1;
  level.loot_time_out = 99999;
  level.allow_wave_spawn = 1;
  level.max_wave_spawn_num = 20;
  level thread egg_sac_spawn_attacks();
  level thread player_nearby_monitor();
  level thread increase_egg_sac_spawn_count();
  level thread escort_end_monitor();
  level thread escort_nav_obstacle_monitor();
  level thread escort_zombie_spawn_manager();
}

push_bomb(var_0, var_1) {
  level endon("escort_sequence_ended");
  level notify("player_pushing_bomb");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  enter_bomb_push(var_1, var_0);
  increase_escort_vehicle_speed();
  while(var_1 usebuttonpressed()) {
    scripts\engine\utility::waitframe();
  }

  decrease_escort_vehicle_speed();
  exit_bomb_push(var_1);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

push_bomb_cart_sfx_start() {
  level notify("started_cart_sfx_loop");
  if(!isDefined(level.bomb_cart_sfx_loop)) {
    level.bomb_cart_sfx_loop = 1;
    level.escort_vehicle playLoopSound("town_bomb_cart_wheels_lp");
  }
}

push_bomb_cart_sfx_stop() {
  level endon("started_cart_sfx_loop");
  wait(0.25);
  if(isDefined(level.bomb_cart_sfx_loop)) {
    level.bomb_cart_sfx_loop = undefined;
    level.escort_vehicle stoploopsound("town_bomb_cart_wheels_lp");
  }
}

init_escort_sequence() {
  var_0 = scripts\engine\utility::getstructarray("push_bomb", "script_noteworthy");
  foreach(var_2 in var_0) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
  }

  var_4 = getvehiclenode("bomb_vehicle_start", "targetname");
  var_5 = spawnvehicle("cp_town_bomb_delivery_vehicle", "bomb_vehicle", "cp_town_bomb_vehicle", var_4.origin, var_4.angles);
  var_5 attachpath(var_4);
  var_6 = getent("bomb_vehicle_clip", "targetname");
  var_6 linkto(var_5);
  var_5.escort_vehicle_clip = var_6;
  var_5 startpath();
  var_5 vehicle_setspeedimmediate(0, 1, 1);
  var_5 setCanDamage(0);
  level.escort_vehicle = var_5;
  level.num_of_player_pushing_bomb = 0;
}

equip_bomb() {
  playFX(level._effect["vfx_bomb_portal_in"], level.escort_vehicle.origin + (0, 0, 20));
  var_0 = level.escort_vehicle;
  var_1 = var_0 gettagorigin("tag_bomb");
  var_1 = var_1 + (0, 0, 3);
  var_2 = spawn("script_model", var_1);
  var_2 setModel("cp_town_nuke");
  var_2.angles = var_0.angles;
  var_0.escort_vehicle_bomb = var_2;
  var_2 linkto(var_0);
}

player_nearby_monitor() {
  level endon("stop_player_near_by_monitor");
  var_0 = level.escort_vehicle;
  var_1 = 0;
  for(;;) {
    if(var_1 == 0 && any_player_near_by()) {
      level notify("bomb escort vehicle moving");
      thread push_bomb_cart_sfx_start();
      var_1 = 1;
      var_0 vehicle_setspeedimmediate(2, 1, 1);
      var_0 setscriptablepartstate("wheel", "active");
    } else if(var_1 == 1 && !any_player_near_by()) {
      var_1 = 0;
      thread push_bomb_cart_sfx_stop();
      var_0 vehicle_setspeedimmediate(0, 1, 1);
      var_0 setscriptablepartstate("wheel", "off");
    }

    scripts\engine\utility::waitframe();
  }
}

any_player_near_by() {
  var_0 = -3036;
  var_1 = 30;
  foreach(var_3 in level.players) {
    if(scripts\engine\utility::istrue(var_3.inlaststand)) {
      continue;
    }

    if(distancesquared(var_3.origin, level.escort_vehicle.origin) > var_0) {
      continue;
    }

    if(level.escort_vehicle.origin[2] > var_3.origin[2] + var_1) {
      continue;
    }

    return 1;
  }

  return 0;
}

increase_escort_vehicle_speed() {
  level.num_of_player_pushing_bomb++;
  update_escort_vehicle_speed();
}

decrease_escort_vehicle_speed() {
  level.num_of_player_pushing_bomb--;
  update_escort_vehicle_speed();
}

update_escort_vehicle_speed() {
  var_0 = level.num_of_player_pushing_bomb / level.players.size * 2;
  var_1 = level.escort_vehicle;
  var_1 vehicle_setspeedimmediate(var_0, 1, 1);
  if(var_0 == 0) {
    var_1 setscriptablepartstate("wheel", "off");
    return;
  }

  var_1 setscriptablepartstate("wheel", "active");
}

pair_push_origins_with_interaction_struct(var_0) {
  var_1 = scripts\engine\utility::getstructarray("push_bomb", "script_noteworthy");
  foreach(var_3 in var_1) {
    var_4 = scripts\engine\utility::getclosest(var_3.origin, var_0);
    var_3.push_origin = var_4;
    var_3 thread follow_push_origin(var_3, var_4);
  }
}

enable_bomb_push_interactions() {
  var_0 = scripts\engine\utility::getstructarray("push_bomb", "script_noteworthy");
  foreach(var_2 in var_0) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
  }
}

disable_bomb_push_interactions() {
  var_0 = scripts\engine\utility::getstructarray("push_bomb", "script_noteworthy");
  foreach(var_2 in var_0) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
  }
}

follow_push_origin(var_0, var_1) {
  level endon("escort_sequence_ended");
  for(;;) {
    var_0.origin = var_0.push_origin.origin;
    scripts\engine\utility::waitframe();
  }
}

spawn_push_origins() {
  var_0 = [];
  var_1 = level.escort_vehicle;
  var_2 = scripts\engine\utility::getstructarray("vehicle_push_origin", "targetname");
  foreach(var_4 in var_2) {
    var_5 = spawn("script_origin", var_4.origin);
    var_5 linkto(var_1);
    var_0[var_0.size] = var_5;
  }

  var_1.push_origins = var_0;
  return var_0;
}

escort_end_monitor() {
  level endon("game_ended");
  var_0 = getvehiclenode("bomb_vehicle_start", "targetname");
  for(;;) {
    var_0 = getvehiclenode(var_0.target, "targetname");
    var_0 waittill("trigger");
    if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "bomb_vehicle_end") {
      break;
    }
  }

  level.escort_vehicle_reaches_end = 1;
  level notify("stop_player_near_by_monitor");
  level.escort_vehicle setscriptablepartstate("wheel", "off");
  wait(1.5);
  level.escort_sequence_completed = 1;
  end_escort_sequence();
}

escort_zombie_spawn_manager() {
  level endon("game_ended");
  var_0 = getvehiclenode("bomb_vehicle_start", "targetname");
  for(;;) {
    if(!isDefined(var_0.target)) {
      return;
    }

    var_0 = getvehiclenode(var_0.target, "targetname");
    var_0 waittill("trigger");
    if(isDefined(var_0.script_noteworthy)) {
      switch (var_0.script_noteworthy) {
        case "1":
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(8, 8, 8, 8);
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1.5, 1.6, 1.8, 2);
          level.max_wave_spawn_num = 8;
          level.wait_time_between_wave = 17;
          break;

        case "2":
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(9, 9, 9, 9);
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1.4, 1.5, 1.7, 1.9);
          level.max_wave_spawn_num = 9;
          level.wait_time_between_wave = 16;
          break;

        case "3":
          level.crab_boss_num_submerge_spawn = 4;
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(10, 10, 9, 9);
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1.3, 1.4, 1.6, 1.8);
          level.max_wave_spawn_num = 10;
          level.wait_time_between_wave = 15;
          break;

        case "4":
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(11, 11, 10, 10);
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1.2, 1.3, 1.5, 1.7);
          level.max_wave_spawn_num = 11;
          level.wait_time_between_wave = 14;
          break;

        case "5":
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(12, 8, 8, 10);
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1.1, 1.6, 1.6, 1.6);
          level.max_wave_spawn_num = 12;
          level.wait_time_between_wave = 13;
          break;

        case "6":
          level.crab_boss_num_submerge_spawn = 6;
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(13, 13, 12, 11);
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1, 1.1, 1.3, 1.5);
          level.max_wave_spawn_num = 13;
          level.wait_time_between_wave = 12;
          break;

        case "7":
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(14, 14, 13, 12);
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(0.9, 1, 1.2, 1.4);
          level.max_wave_spawn_num = 14;
          level.wait_time_between_wave = 11;
          break;

        case "8":
          level.crab_boss_num_submerge_spawn = level.players.size * 1;
          level notify("bomb escort passed overhead bridge");
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(15, 14, 13, 13);
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(0.8, 0.9, 1.1, 1.3);
          level.max_wave_spawn_num = 15;
          level.wait_time_between_wave = 10;
          break;

        case "9":
          level.crab_boss_num_submerge_spawn = level.players.size * 2;
          level.crab_boss_num_submerge_spawn = 8;
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(15, 15, 14, 14);
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(0.7, 0.8, 1, 1.2);
          level.max_wave_spawn_num = 16;
          level.wait_time_between_wave = 9;
          break;

        case "10":
          level.crab_boss_num_submerge_spawn = level.players.size * 3;
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(15, 15, 15, 15);
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(0.6, 0.7, 0.9, 1.1);
          level.max_wave_spawn_num = 17;
          level.wait_time_between_wave = 8;
          break;

        case "11":
          level.crab_boss_num_submerge_spawn = level.players.size * 4;
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(15, 15, 15, 15);
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(0.5, 0.6, 0.8, 1);
          level.max_wave_spawn_num = 18;
          level.wait_time_between_wave = 7;
          break;

        case "12":
          level.stop_crab_boss_submerge_bomb = 1;
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(15, 15, 15, 15);
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(0.4, 0.5, 0.7, 0.9);
          level.max_wave_spawn_num = 19;
          level.wait_time_between_wave = 6;
          break;

        case "13":
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(15, 15, 15, 15);
          scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(0.3, 0.4, 0.6, 0.8);
          level.max_wave_spawn_num = 20;
          level.wait_time_between_wave = 5;
          break;

        case "14":
          scripts\engine\utility::flag_clear("crab_boss_zombie_spawn");
          break;

        case "16":
          scripts\cp\cp_vo::try_to_play_vo_on_all_players("boss_phase_1_success_bomb_escort");
          break;
      }
    }
  }
}

end_escort_sequence() {
  level notify("escort_sequence_ended");
  bomb_launching_sequence();
  players_exit_bomb_push();
}

bomb_launching_sequence() {
  var_0 = level.escort_vehicle;
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("cp_town_bomb_delivery_vehicle");
  var_0.escort_vehicle_bomb unlink();
  level.escort_vehicle = var_1;
  level.escort_vehicle.escort_vehicle_bomb = var_0.escort_vehicle_bomb;
  level.escort_vehicle.escort_vehicle_bomb linkto(var_1, "tag_bomb");
  var_0 delete();
  level.escort_vehicle setscriptablepartstate("launch", "active");
  level.escort_vehicle.escort_vehicle_bomb scriptmodelplayanim("iw7_cp_bosscrab_emerge_slingshot_nuke_01");
  level.escort_vehicle playSound("town_bomb_cart_launch_sequence");
}

move_escort_vehicle_to_end() {}

delete_push_origins() {
  var_0 = level.escort_vehicle;
  if(isDefined(var_0.push_origins)) {
    var_1 = var_0.push_origins;
    foreach(var_3 in var_1) {
      var_3 delete();
    }
  }
}

enter_bomb_push(var_0, var_1) {
  var_0 play_bomb_push_gesture(var_0);
  var_0 playerlinkto(var_1.push_origin);
  var_0 playerlinkedoffsetenable();
  var_0 scripts\cp\powers\coop_powers::power_disablepower();
  var_0.is_pushing_bomb = 1;
}

exit_bomb_push(var_0) {
  var_0 stop_bomb_push_gesture(var_0);
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0 unlink();
  var_0 teleport_out_of_geo(var_0);
  var_0.is_pushing_bomb = undefined;
}

teleport_out_of_geo(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(var_0.origin, 100, -200);
  if(var_1[2] > var_0.origin[2]) {
    var_0 setorigin(var_1);
  }
}

play_bomb_push_gesture(var_0) {
  var_0.pre_bomb_push_gesture_weapon = var_0 scripts\cp\utility::getvalidtakeweapon();
  var_0 giveweapon("iw7_gunless_zm");
  var_0 switchtoweapon("iw7_gunless_zm");
  var_0 allowmelee(0);
  var_0 getraidspawnpoint();
  var_0 forceplaygestureviewmodel("ges_bomb_trailer_push", var_0);
}

stop_bomb_push_gesture(var_0) {
  var_0 takeweapon("iw7_gunless_zm");
  var_0 enableweaponswitch();
  var_0 switchtoweapon(var_0.pre_bomb_push_gesture_weapon);
  var_0 allowmelee(1);
  var_0 stopgestureviewmodel("ges_bomb_trailer_push");
}

players_exit_bomb_push() {
  foreach(var_1 in level.players) {
    if(scripts\engine\utility::istrue(var_1.is_pushing_bomb)) {
      exit_bomb_push(var_1);
    }
  }
}

load_escort_vfx() {
  level._effect["egg_sac_bomb_landing_sand"] = loadfx("vfx\iw7\levels\cp_town\boss_proj\vfx_bomb_landing_explosion.vfx");
  level._effect["egg_sac_bomb_landing_non_sand"] = loadfx("vfx\iw7\levels\cp_town\boss_proj\vfx_bomb_explosion_smoky.vfx");
  level._effect["egg_sac_spawn_landing"] = loadfx("vfx\iw7\levels\cp_town\boss_proj\vfx_eggsack_landing.vfx");
  level._effect["egg_sac_spawn_aerial_explosion"] = loadfx("vfx\iw7\levels\cp_town\boss_proj\vfx_eggsack_aerial_explode.vfx");
  level._effect["egg_sac_bomb_aerial_explosion"] = loadfx("vfx\iw7\levels\cp_town\boss_proj\vfx_bomb_aerial_explosion.vfx");
  level._effect["egg_sac_hatching"] = loadfx("vfx\iw7\levels\cp_town\boss_proj\vfx_eggsack_hatching.vfx");
  level._effect["egg_sac_bomb_muzzleflash"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_bomb_muzzleflash.vfx");
  level._effect["egg_sac_spawn_muzzleflash"] = loadfx("vfx\iw7\levels\cp_town\boss_proj\vfx_eggsack_muzzleflash.vfx");
  level._effect["lure_glow"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_lure_glow.vfx");
  level._effect["lure_glow_burst"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_lure_glow_burst.vfx");
  level._effect["lure_glow_charge"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_lure_glow_charge.vfx");
  level._effect["mouth_buildup"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_mouth_buildup.vfx");
  level._effect["mouth_spray"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_mouth_spray.vfx");
  level._effect["mouth_roar_bits"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_mouth_roar_bits.vfx");
  level._effect["crog_emerge"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_crog_emerge.vfx");
  level._effect["crog_submerge"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_crog_submerge.vfx");
  level._effect["crog_submerge_idle"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_crog_submerge_idle.vfx");
  level._effect["leg_splashes"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_bc_leg_splashes.vfx");
  level._effect["leg_splashes_heavy"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_bc_leg_splashes_heavy.vfx");
  level._effect["crog_flashbang"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_crog_flashbang.vfx");
  level._effect["claw_trail"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_claw_smash_trail.vfx");
  level._effect["claw_trail_sand"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_claw_smash_imp_sch.vfx");
  level._effect["lure_glow_burst_ricochet"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_lg_burst_rico.vfx");
  level._effect["lure_glow_ricochet"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_lg_charge_ricochet.vfx");
  level._effect["food_search_debris"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_bc_tanker_debris.vfx");
}

egg_sac_spawn_attacks() {
  level endon("escort_sequence_ended");
  level.crab_boss_num_submerge_spawn = 0;
  level waittill("bomb escort vehicle moving");
  egg_sac_bomb_attack();
  level waittill("bomb escort passed overhead bridge");
  for(;;) {
    if(scripts\engine\utility::istrue(level.stop_crab_boss_submerge_bomb)) {
      return;
    }

    egg_sac_bomb_attack();
    wait(randomfloatrange(3.5, 4.5));
    level waittill("bomb escort vehicle moving");
  }
}

egg_sac_bomb_attack() {
  level.crab_boss scripts\aitypes\crab_boss\behaviors::dosubmergebomb();
  level.crab_boss waittill("submerge_bomb_complete");
}

egg_sac_spawn_attack() {
  level.crab_boss scripts\aitypes\crab_boss\behaviors::dosubmergespawn();
  level.crab_boss waittill("submerge_spawn_complete");
}

launch_egg_sac(var_0, var_1, var_2, var_3, var_4) {
  var_1 = getclosestpointonnavmesh(var_1);
  var_5 = spawn("script_model", var_0);
  var_5 setModel(get_egg_sac_model(var_3));
  var_5 playSound("boss_crog_fire_egg_launch");
  var_5 thread egg_sac_or_bomb_incoming_delayed(var_2);
  var_5 thread egg_sac_damage_monitor(var_5, var_3);
  var_5 thread egg_sac_fly(var_5, var_0, var_1, var_2, var_3, var_4);
}

egg_sac_or_bomb_incoming_delayed(var_0) {
  self endon("death");
  wait(var_0 - 1);
  self playsoundonmovingent("minion_egg_incoming");
}

get_egg_sac_model(var_0) {
  if(scripts\engine\utility::istrue(var_0)) {
    return "cp_town_temp_egg_sac_green";
  }

  return "cp_town_temp_egg_sac_orange";
}

egg_sac_fly(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_6 = 386.09;
  scripts\engine\utility::waitframe();
  show_flying_trail(var_0, var_4);
  var_7 = var_6 * (0, 0, -1);
  var_8 = trajectorycalculateinitialvelocity(var_1, var_2, var_7, var_3);
  var_9 = var_3 * 20;
  play_launch_muzzle_flash(var_1, var_8, var_4);
  var_0 thread egg_sac_safe_delete(var_0, var_3);
  for(var_0A = 1; var_0A <= var_9; var_0A++) {
    var_0B = var_0A / 20;
    var_0C = 0.5 * var_7 * var_0B * var_0B + var_8 * var_0B + var_1;
    var_0.origin = var_0C;
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::waitframe();
  egg_sac_landing_sequence(var_0, var_2, var_4, var_5);
}

egg_sac_safe_delete(var_0, var_1) {
  wait(var_1 + 0.1);
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

play_launch_muzzle_flash(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(var_2)) {
    var_4 = "egg_sac_spawn_muzzleflash";
  } else {
    var_4 = "egg_sac_bomb_muzzleflash";
  }

  playFX(level._effect[var_4], var_0, anglestoup(vectortoangles(var_1)), var_1);
}

egg_sac_landing_sequence(var_0, var_1, var_2, var_3) {
  do_earthquake(var_1);
  do_radius_damage(var_0, var_1);
  play_landing_explosion(var_1, var_2);
  hide_flying_trail(var_0);
  hide_landing_marker(var_0);
  if(scripts\engine\utility::istrue(var_2)) {
    var_0 thread egg_sac_spawn(var_0, var_1, var_3);
    return;
  }

  delete_egg_sac(var_0);
}

do_earthquake(var_0) {
  earthquake(0.8, 1, var_0, 300);
}

do_radius_damage(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distance2dsquared(var_3.origin, var_1) > 16900) {
      continue;
    }

    var_3 dodamage(50, var_1);
    var_4 = var_3.origin - var_1 * (1, 1, 0);
    var_5 = vectornormalize(var_4);
    var_6 = 3000 * 1 - length(var_4) / 130;
  }
}

set_up_landing_ent(var_0, var_1) {
  var_2 = spawn("script_model", var_1);
  var_2 setModel("crab_boss_origin");
  var_0.landing_ent = var_2;
}

show_flying_trail(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1)) {
    var_0 setscriptablepartstate("egg_sac_flying_trail", "spawn");
    return;
  }

  var_0 setscriptablepartstate("egg_sac_flying_trail", "bomb");
}

hide_flying_trail(var_0) {
  var_0 setscriptablepartstate("egg_sac_flying_trail", "off");
}

show_landing_marker(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1)) {
    var_0.landing_ent setscriptablepartstate("egg_sac_landing_marker", "spawn");
    return;
  }

  var_0.landing_ent setscriptablepartstate("egg_sac_landing_marker", "bomb");
}

hide_landing_marker(var_0) {
  if(isDefined(var_0.landing_ent)) {
    var_0.landing_ent setscriptablepartstate("egg_sac_landing_marker", "off");
  }
}

play_landing_explosion(var_0, var_1) {
  if(var_1 == 1) {
    thread scripts\engine\utility::play_sound_in_space("minion_egg_land", var_0 + (0, 0, 30));
  } else {
    thread scripts\engine\utility::play_sound_in_space("town_frag_grenade_explode", var_0 + (0, 0, 30));
  }

  var_2 = get_landing_explosion_vfx_alias(var_0, var_1);
  playFX(level._effect[var_2], var_0);
}

get_landing_explosion_vfx_alias(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1)) {
    return "egg_sac_spawn_landing";
  }

  var_2 = bulletTrace(var_0 + (0, 0, 10), var_0 + (0, 0, -10), 0);
  if(issubstr(var_2["surfacetype"], "sand")) {
    return "egg_sac_bomb_landing_sand";
  }

  return "egg_sac_bomb_landing_non_sand";
}

egg_sac_damage_monitor(var_0, var_1) {
  var_0 endon("death");
  var_0.health = 999999;
  var_0.fake_health = 1;
  var_0 setCanDamage(1);
  for(;;) {
    var_0 waittill("damage", var_2, var_3);
    var_0.health = 999999;
    var_0.fake_health = var_0.fake_health - var_2;
    if(isplayer(var_3)) {
      show_hit_marker(var_0, var_3);
    }

    if(var_0.fake_health < 0) {
      break;
    }
  }

  if(isDefined(var_3) && isplayer(var_3)) {
    var_3 scripts\cp\cp_merits::processmerit("mt_dlc3_eggs_killed");
  }

  play_damage_explosion_fx(var_0, var_1);
  delete_egg_sac(var_0);
}

play_damage_explosion_fx(var_0, var_1) {
  if(var_1 == 1) {
    thread scripts\engine\utility::play_sound_in_space("minion_egg_land", var_0.origin);
  } else {
    thread scripts\engine\utility::play_sound_in_space("town_frag_grenade_explode", var_0.origin);
  }

  if(scripts\engine\utility::istrue(var_1)) {
    playFX(level._effect["egg_sac_spawn_aerial_explosion"], var_0.origin);
    return;
  }

  playFX(level._effect["egg_sac_bomb_aerial_explosion"], var_0.origin);
}

show_hit_marker(var_0, var_1) {
  if(var_0.fake_health < 0) {
    var_1 scripts\cp\cp_damage::updatedamagefeedback("pink_arcane_cp");
    return;
  }

  var_1 scripts\cp\cp_damage::updatedamagefeedback("standard");
}

delete_egg_sac(var_0) {
  scripts\engine\utility::waitframe();
  if(isDefined(var_0.landing_ent)) {
    var_0.landing_ent delete();
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

egg_sac_spawn(var_0, var_1, var_2) {
  var_0 endon("death");
  playFX(level._effect["egg_sac_hatching"], var_0.origin);
  var_3 = make_egg_sac_spawner(var_1, var_2);
  var_4 = var_3 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("crab_mini", 1, var_3);
  if(isDefined(var_4)) {
    adjust_crab_mini_health(var_4);
  }

  thread delete_egg_sac(var_0);
  return var_4;
}

make_egg_sac_spawner(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.angles = var_1;
  return var_2;
}

calculate_egg_sac_bomb_pos() {
  var_0 = [];
  var_1 = get_num_of_egg_sac_bomb();
  var_2 = level.escort_vehicle;
  var_3 = var_2.angles;
  foreach(var_5 in level.players) {
    if(coin_flip()) {
      var_0[var_0.size] = get_point_near_target_within_range(var_5.origin, 30);
    }
  }

  var_7 = var_1 - var_0.size;
  for(var_8 = 0; var_8 < var_7; var_8++) {
    var_0[var_0.size] = get_point_near_target_within_range(var_2.origin, 400);
  }

  var_0 = scripts\engine\utility::array_randomize(var_0);
  return var_0;
}

coin_flip() {
  return randomint(100) > 50;
}

get_point_near_target_within_range(var_0, var_1) {
  var_2 = (var_0[0] + randomfloatrange(var_1 * -1, var_1), var_0[1] + randomfloatrange(var_1 * -1, var_1), var_0[2]);
  var_2 = getclosestpointonnavmesh(var_2);
  var_2 = scripts\engine\utility::drop_to_ground(var_2, 0, -100);
  return var_2;
}

calculate_egg_sac_spawn_pos() {
  var_0 = [];
  var_1 = get_num_of_egg_sac_spawn();
  if(var_1 > 0) {
    var_2 = level.escort_vehicle;
    var_3 = level.crab_boss;
    var_4 = vectornormalize(var_3.origin - var_2.origin * (1, 1, 0));
    var_5 = vectortoangles(var_4);
    var_6 = 180 / var_1;
    var_7 = var_5[1] - 90 + var_6 / 2;
    for(var_8 = 0; var_8 < var_1; var_8++) {
      var_9 = var_7 + var_8 * var_6;
      var_0A = (var_5[0], var_9, var_5[2]);
      var_0B = randomfloatrange(400, 1000);
      var_0C = getclosestpointonnavmesh(var_2.origin + anglesToForward(var_0A) * var_0B);
      var_0C = scripts\engine\utility::drop_to_ground(var_0C, 0, -100);
      var_0[var_0.size] = var_0C;
    }
  }

  return var_0;
}

get_num_of_egg_sac_bomb() {
  return 24;
}

get_num_of_egg_sac_spawn() {
  var_0 = level.egg_sac_spawn_count_per_player * level.players.size;
  var_1 = level.spawned_enemies.size;
  var_2 = 24 - var_1;
  return int(min(var_0, var_2));
}

adjust_crab_mini_health(var_0) {
  var_0.maxhealth = 1000;
  var_0.health = var_0.maxhealth;
}

increase_egg_sac_spawn_count() {
  level endon("escort_sequence_ended");
  for(var_0 = 3; var_0 <= 6; var_0++) {
    level.egg_sac_spawn_count_per_player = var_0;
    wait(60);
  }
}

teleport_players_to_beach() {
  var_0 = [(1654, -1472, 304), (1812, -1366, 239), (1914, -1174, 187), (2185, -1170, 185)];
  var_1 = level.crab_boss;
  foreach(var_5, var_3 in level.players) {
    var_4 = spawnStruct();
    var_4.origin = var_0[var_5];
    var_4.angles = vectortoangles(var_1.origin - var_0[var_5]);
    level thread scripts\cp\maps\cp_town\cp_town_fast_travel::move_player_through_portal_tube(var_3, [var_4]);
  }
}

play_escort_intro_vo() {
  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::play_vo_at_start_of_boss_fight();
  wait(30);
  var_0 = scripts\engine\utility::random(level.players);
  if(isDefined(var_0.vo_prefix)) {
    switch (var_0.vo_prefix) {
      case "p1_":
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("sally_escort_bomb_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p2_":
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pdex_escort_bomb_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p3_":
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("andre_escort_bomb_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p4_":
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("aj_escort_bomb_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      default:
        break;
    }
  }
}

escort_nav_obstacle_monitor() {
  level endon("game_ended");
  var_0 = 100;
  var_1 = 25;
  var_2 = 80;
  var_3 = level.escort_vehicle;
  var_4 = createnavobstaclebybounds(var_3.origin, (var_0, var_1, var_2), var_3.angles);
  var_5 = var_3.origin;
  for(;;) {
    wait(0.5);
    if(var_3.origin != var_5) {
      destroynavobstacle(var_4);
      var_4 = createnavobstaclebybounds(var_3.origin, (var_0, var_1, var_2), var_3.angles);
      var_5 = var_3.origin;
    }

    if(scripts\engine\utility::istrue(level.escort_vehicle_reaches_end)) {
      break;
    }
  }

  destroynavobstacle(var_4);
  var_4 = createnavobstaclebybounds(var_3.origin, (var_0, var_1, var_2), var_3.angles);
}