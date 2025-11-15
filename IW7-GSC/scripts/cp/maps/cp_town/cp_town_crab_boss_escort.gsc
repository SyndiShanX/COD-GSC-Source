/****************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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

push_bomb(param_00, param_01) {
  level endon("escort_sequence_ended");
  level notify("player_pushing_bomb");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  enter_bomb_push(param_01, param_00);
  increase_escort_vehicle_speed();
  while(param_01 usebuttonpressed()) {
    scripts\engine\utility::waitframe();
  }

  decrease_escort_vehicle_speed();
  exit_bomb_push(param_01);
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
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
  var_00 = scripts\engine\utility::getstructarray("push_bomb", "script_noteworthy");
  foreach(var_02 in var_00) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_02);
  }

  var_04 = getvehiclenode("bomb_vehicle_start", "targetname");
  var_05 = spawnvehicle("cp_town_bomb_delivery_vehicle", "bomb_vehicle", "cp_town_bomb_vehicle", var_04.origin, var_04.angles);
  var_05 attachpath(var_04);
  var_06 = getent("bomb_vehicle_clip", "targetname");
  var_06 linkto(var_05);
  var_05.escort_vehicle_clip = var_06;
  var_05 startpath();
  var_05 vehicle_setspeedimmediate(0, 1, 1);
  var_05 setCanDamage(0);
  level.escort_vehicle = var_05;
  level.num_of_player_pushing_bomb = 0;
}

equip_bomb() {
  playFX(level._effect["vfx_bomb_portal_in"], level.escort_vehicle.origin + (0, 0, 20));
  var_00 = level.escort_vehicle;
  var_01 = var_00 gettagorigin("tag_bomb");
  var_01 = var_01 + (0, 0, 3);
  var_02 = spawn("script_model", var_01);
  var_02 setModel("cp_town_nuke");
  var_02.angles = var_00.angles;
  var_00.escort_vehicle_bomb = var_02;
  var_02 linkto(var_00);
}

player_nearby_monitor() {
  level endon("stop_player_near_by_monitor");
  var_00 = level.escort_vehicle;
  var_01 = 0;
  for(;;) {
    if(var_01 == 0 && any_player_near_by()) {
      level notify("bomb escort vehicle moving");
      thread push_bomb_cart_sfx_start();
      var_01 = 1;
      var_00 vehicle_setspeedimmediate(2, 1, 1);
      var_00 setscriptablepartstate("wheel", "active");
    } else if(var_01 == 1 && !any_player_near_by()) {
      var_01 = 0;
      thread push_bomb_cart_sfx_stop();
      var_00 vehicle_setspeedimmediate(0, 1, 1);
      var_00 setscriptablepartstate("wheel", "off");
    }

    scripts\engine\utility::waitframe();
  }
}

any_player_near_by() {
  var_00 = -3036;
  var_01 = 30;
  foreach(var_03 in level.players) {
    if(scripts\engine\utility::istrue(var_03.inlaststand)) {
      continue;
    }

    if(distancesquared(var_03.origin, level.escort_vehicle.origin) > var_00) {
      continue;
    }

    if(level.escort_vehicle.origin[2] > var_03.origin[2] + var_01) {
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
  var_00 = level.num_of_player_pushing_bomb / level.players.size * 2;
  var_01 = level.escort_vehicle;
  var_01 vehicle_setspeedimmediate(var_00, 1, 1);
  if(var_00 == 0) {
    var_01 setscriptablepartstate("wheel", "off");
    return;
  }

  var_01 setscriptablepartstate("wheel", "active");
}

pair_push_origins_with_interaction_struct(param_00) {
  var_01 = scripts\engine\utility::getstructarray("push_bomb", "script_noteworthy");
  foreach(var_03 in var_01) {
    var_04 = scripts\engine\utility::getclosest(var_03.origin, param_00);
    var_03.push_origin = var_04;
    var_03 thread follow_push_origin(var_03, var_04);
  }
}

enable_bomb_push_interactions() {
  var_00 = scripts\engine\utility::getstructarray("push_bomb", "script_noteworthy");
  foreach(var_02 in var_00) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_02);
  }
}

disable_bomb_push_interactions() {
  var_00 = scripts\engine\utility::getstructarray("push_bomb", "script_noteworthy");
  foreach(var_02 in var_00) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_02);
  }
}

follow_push_origin(param_00, param_01) {
  level endon("escort_sequence_ended");
  for(;;) {
    param_00.origin = param_00.push_origin.origin;
    scripts\engine\utility::waitframe();
  }
}

spawn_push_origins() {
  var_00 = [];
  var_01 = level.escort_vehicle;
  var_02 = scripts\engine\utility::getstructarray("vehicle_push_origin", "targetname");
  foreach(var_04 in var_02) {
    var_05 = spawn("script_origin", var_04.origin);
    var_05 linkto(var_01);
    var_00[var_00.size] = var_05;
  }

  var_01.push_origins = var_00;
  return var_00;
}

escort_end_monitor() {
  level endon("game_ended");
  var_00 = getvehiclenode("bomb_vehicle_start", "targetname");
  for(;;) {
    var_00 = getvehiclenode(var_00.target, "targetname");
    var_00 waittill("trigger");
    if(isDefined(var_00.script_noteworthy) && var_00.script_noteworthy == "bomb_vehicle_end") {
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
  var_00 = getvehiclenode("bomb_vehicle_start", "targetname");
  for(;;) {
    if(!isDefined(var_00.target)) {
      return;
    }

    var_00 = getvehiclenode(var_00.target, "targetname");
    var_00 waittill("trigger");
    if(isDefined(var_00.script_noteworthy)) {
      switch (var_00.script_noteworthy) {
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
  var_00 = level.escort_vehicle;
  var_01 = spawn("script_model", var_00.origin);
  var_01.angles = var_00.angles;
  var_01 setModel("cp_town_bomb_delivery_vehicle");
  var_00.escort_vehicle_bomb unlink();
  level.escort_vehicle = var_01;
  level.escort_vehicle.escort_vehicle_bomb = var_00.escort_vehicle_bomb;
  level.escort_vehicle.escort_vehicle_bomb linkto(var_01, "tag_bomb");
  var_00 delete();
  level.escort_vehicle setscriptablepartstate("launch", "active");
  level.escort_vehicle.escort_vehicle_bomb scriptmodelplayanim("iw7_cp_bosscrab_emerge_slingshot_nuke_01");
  level.escort_vehicle playSound("town_bomb_cart_launch_sequence");
}

move_escort_vehicle_to_end() {}

delete_push_origins() {
  var_00 = level.escort_vehicle;
  if(isDefined(var_00.push_origins)) {
    var_01 = var_00.push_origins;
    foreach(var_03 in var_01) {
      var_03 delete();
    }
  }
}

enter_bomb_push(param_00, param_01) {
  param_00 play_bomb_push_gesture(param_00);
  param_00 playerlinkto(param_01.push_origin);
  param_00 playerlinkedoffsetenable();
  param_00 scripts\cp\powers\coop_powers::power_disablepower();
  param_00.is_pushing_bomb = 1;
}

exit_bomb_push(param_00) {
  param_00 stop_bomb_push_gesture(param_00);
  param_00 scripts\cp\powers\coop_powers::power_enablepower();
  param_00 unlink();
  param_00 teleport_out_of_geo(param_00);
  param_00.is_pushing_bomb = undefined;
}

teleport_out_of_geo(param_00) {
  var_01 = scripts\engine\utility::drop_to_ground(param_00.origin, 100, -200);
  if(var_01[2] > param_00.origin[2]) {
    param_00 setorigin(var_01);
  }
}

play_bomb_push_gesture(param_00) {
  param_00.pre_bomb_push_gesture_weapon = param_00 scripts\cp\utility::getvalidtakeweapon();
  param_00 giveweapon("iw7_gunless_zm");
  param_00 switchtoweapon("iw7_gunless_zm");
  param_00 allowmelee(0);
  param_00 getraidspawnpoint();
  param_00 forceplaygestureviewmodel("ges_bomb_trailer_push", param_00);
}

stop_bomb_push_gesture(param_00) {
  param_00 takeweapon("iw7_gunless_zm");
  param_00 enableweaponswitch();
  param_00 switchtoweapon(param_00.pre_bomb_push_gesture_weapon);
  param_00 allowmelee(1);
  param_00 stopgestureviewmodel("ges_bomb_trailer_push");
}

players_exit_bomb_push() {
  foreach(var_01 in level.players) {
    if(scripts\engine\utility::istrue(var_01.is_pushing_bomb)) {
      exit_bomb_push(var_01);
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

launch_egg_sac(param_00, param_01, param_02, param_03, param_04) {
  param_01 = getclosestpointonnavmesh(param_01);
  var_05 = spawn("script_model", param_00);
  var_05 setModel(get_egg_sac_model(param_03));
  var_05 playSound("boss_crog_fire_egg_launch");
  var_05 thread egg_sac_or_bomb_incoming_delayed(param_02);
  var_05 thread egg_sac_damage_monitor(var_05, param_03);
  var_05 thread egg_sac_fly(var_05, param_00, param_01, param_02, param_03, param_04);
}

egg_sac_or_bomb_incoming_delayed(param_00) {
  self endon("death");
  wait(param_00 - 1);
  self playsoundonmovingent("minion_egg_incoming");
}

get_egg_sac_model(param_00) {
  if(scripts\engine\utility::istrue(param_00)) {
    return "cp_town_temp_egg_sac_green";
  }

  return "cp_town_temp_egg_sac_orange";
}

egg_sac_fly(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 endon("death");
  var_06 = 386.09;
  scripts\engine\utility::waitframe();
  show_flying_trail(param_00, param_04);
  var_07 = var_06 * (0, 0, -1);
  var_08 = trajectorycalculateinitialvelocity(param_01, param_02, var_07, param_03);
  var_09 = param_03 * 20;
  play_launch_muzzle_flash(param_01, var_08, param_04);
  param_00 thread egg_sac_safe_delete(param_00, param_03);
  for(var_0A = 1; var_0A <= var_09; var_0A++) {
    var_0B = var_0A / 20;
    var_0C = 0.5 * var_07 * var_0B * var_0B + var_08 * var_0B + param_01;
    param_00.origin = var_0C;
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::waitframe();
  egg_sac_landing_sequence(param_00, param_02, param_04, param_05);
}

egg_sac_safe_delete(param_00, param_01) {
  wait(param_01 + 0.1);
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

play_launch_muzzle_flash(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(param_02)) {
    var_04 = "egg_sac_spawn_muzzleflash";
  } else {
    var_04 = "egg_sac_bomb_muzzleflash";
  }

  playFX(level._effect[var_04], param_00, anglestoup(vectortoangles(param_01)), param_01);
}

egg_sac_landing_sequence(param_00, param_01, param_02, param_03) {
  do_earthquake(param_01);
  do_radius_damage(param_00, param_01);
  play_landing_explosion(param_01, param_02);
  hide_flying_trail(param_00);
  hide_landing_marker(param_00);
  if(scripts\engine\utility::istrue(param_02)) {
    param_00 thread egg_sac_spawn(param_00, param_01, param_03);
    return;
  }

  delete_egg_sac(param_00);
}

do_earthquake(param_00) {
  earthquake(0.8, 1, param_00, 300);
}

do_radius_damage(param_00, param_01) {
  foreach(var_03 in level.players) {
    if(distance2dsquared(var_03.origin, param_01) > 16900) {
      continue;
    }

    var_03 dodamage(50, param_01);
    var_04 = var_03.origin - param_01 * (1, 1, 0);
    var_05 = vectornormalize(var_04);
    var_06 = 3000 * 1 - length(var_04) / 130;
  }
}

set_up_landing_ent(param_00, param_01) {
  var_02 = spawn("script_model", param_01);
  var_02 setModel("crab_boss_origin");
  param_00.landing_ent = var_02;
}

show_flying_trail(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_01)) {
    param_00 setscriptablepartstate("egg_sac_flying_trail", "spawn");
    return;
  }

  param_00 setscriptablepartstate("egg_sac_flying_trail", "bomb");
}

hide_flying_trail(param_00) {
  param_00 setscriptablepartstate("egg_sac_flying_trail", "off");
}

show_landing_marker(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_01)) {
    param_00.landing_ent setscriptablepartstate("egg_sac_landing_marker", "spawn");
    return;
  }

  param_00.landing_ent setscriptablepartstate("egg_sac_landing_marker", "bomb");
}

hide_landing_marker(param_00) {
  if(isDefined(param_00.landing_ent)) {
    param_00.landing_ent setscriptablepartstate("egg_sac_landing_marker", "off");
  }
}

play_landing_explosion(param_00, param_01) {
  if(param_01 == 1) {
    thread scripts\engine\utility::play_sound_in_space("minion_egg_land", param_00 + (0, 0, 30));
  } else {
    thread scripts\engine\utility::play_sound_in_space("town_frag_grenade_explode", param_00 + (0, 0, 30));
  }

  var_02 = get_landing_explosion_vfx_alias(param_00, param_01);
  playFX(level._effect[var_02], param_00);
}

get_landing_explosion_vfx_alias(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_01)) {
    return "egg_sac_spawn_landing";
  }

  var_02 = bulletTrace(param_00 + (0, 0, 10), param_00 + (0, 0, -10), 0);
  if(issubstr(var_02["surfacetype"], "sand")) {
    return "egg_sac_bomb_landing_sand";
  }

  return "egg_sac_bomb_landing_non_sand";
}

egg_sac_damage_monitor(param_00, param_01) {
  param_00 endon("death");
  param_00.health = 999999;
  param_00.fake_health = 1;
  param_00 setCanDamage(1);
  for(;;) {
    param_00 waittill("damage", var_02, var_03);
    param_00.health = 999999;
    param_00.fake_health = param_00.fake_health - var_02;
    if(isplayer(var_03)) {
      show_hit_marker(param_00, var_03);
    }

    if(param_00.fake_health < 0) {
      break;
    }
  }

  if(isDefined(var_03) && isplayer(var_03)) {
    var_03 scripts\cp\cp_merits::processmerit("mt_dlc3_eggs_killed");
  }

  play_damage_explosion_fx(param_00, param_01);
  delete_egg_sac(param_00);
}

play_damage_explosion_fx(param_00, param_01) {
  if(param_01 == 1) {
    thread scripts\engine\utility::play_sound_in_space("minion_egg_land", param_00.origin);
  } else {
    thread scripts\engine\utility::play_sound_in_space("town_frag_grenade_explode", param_00.origin);
  }

  if(scripts\engine\utility::istrue(param_01)) {
    playFX(level._effect["egg_sac_spawn_aerial_explosion"], param_00.origin);
    return;
  }

  playFX(level._effect["egg_sac_bomb_aerial_explosion"], param_00.origin);
}

show_hit_marker(param_00, param_01) {
  if(param_00.fake_health < 0) {
    param_01 scripts\cp\cp_damage::updatedamagefeedback("pink_arcane_cp");
    return;
  }

  param_01 scripts\cp\cp_damage::updatedamagefeedback("standard");
}

delete_egg_sac(param_00) {
  scripts\engine\utility::waitframe();
  if(isDefined(param_00.landing_ent)) {
    param_00.landing_ent delete();
  }

  if(isDefined(param_00)) {
    param_00 delete();
  }
}

egg_sac_spawn(param_00, param_01, param_02) {
  param_00 endon("death");
  playFX(level._effect["egg_sac_hatching"], param_00.origin);
  var_03 = make_egg_sac_spawner(param_01, param_02);
  var_04 = var_03 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("crab_mini", 1, var_03);
  if(isDefined(var_04)) {
    adjust_crab_mini_health(var_04);
  }

  thread delete_egg_sac(param_00);
  return var_04;
}

make_egg_sac_spawner(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.origin = param_00;
  var_02.angles = param_01;
  return var_02;
}

calculate_egg_sac_bomb_pos() {
  var_00 = [];
  var_01 = get_num_of_egg_sac_bomb();
  var_02 = level.escort_vehicle;
  var_03 = var_02.angles;
  foreach(var_05 in level.players) {
    if(coin_flip()) {
      var_00[var_00.size] = get_point_near_target_within_range(var_05.origin, 30);
    }
  }

  var_07 = var_01 - var_00.size;
  for(var_08 = 0; var_08 < var_07; var_08++) {
    var_00[var_00.size] = get_point_near_target_within_range(var_02.origin, 400);
  }

  var_00 = scripts\engine\utility::array_randomize(var_00);
  return var_00;
}

coin_flip() {
  return randomint(100) > 50;
}

get_point_near_target_within_range(param_00, param_01) {
  var_02 = (param_00[0] + randomfloatrange(param_01 * -1, param_01), param_00[1] + randomfloatrange(param_01 * -1, param_01), param_00[2]);
  var_02 = getclosestpointonnavmesh(var_02);
  var_02 = scripts\engine\utility::drop_to_ground(var_02, 0, -100);
  return var_02;
}

calculate_egg_sac_spawn_pos() {
  var_00 = [];
  var_01 = get_num_of_egg_sac_spawn();
  if(var_01 > 0) {
    var_02 = level.escort_vehicle;
    var_03 = level.crab_boss;
    var_04 = vectornormalize(var_03.origin - var_02.origin * (1, 1, 0));
    var_05 = vectortoangles(var_04);
    var_06 = 180 / var_01;
    var_07 = var_05[1] - 90 + var_06 / 2;
    for(var_08 = 0; var_08 < var_01; var_08++) {
      var_09 = var_07 + var_08 * var_06;
      var_0A = (var_05[0], var_09, var_05[2]);
      var_0B = randomfloatrange(400, 1000);
      var_0C = getclosestpointonnavmesh(var_02.origin + anglesToForward(var_0A) * var_0B);
      var_0C = scripts\engine\utility::drop_to_ground(var_0C, 0, -100);
      var_00[var_00.size] = var_0C;
    }
  }

  return var_00;
}

get_num_of_egg_sac_bomb() {
  return 24;
}

get_num_of_egg_sac_spawn() {
  var_00 = level.egg_sac_spawn_count_per_player * level.players.size;
  var_01 = level.spawned_enemies.size;
  var_02 = 24 - var_01;
  return int(min(var_00, var_02));
}

adjust_crab_mini_health(param_00) {
  param_00.maxhealth = 1000;
  param_00.health = param_00.maxhealth;
}

increase_egg_sac_spawn_count() {
  level endon("escort_sequence_ended");
  for(var_00 = 3; var_00 <= 6; var_00++) {
    level.egg_sac_spawn_count_per_player = var_00;
    wait(60);
  }
}

teleport_players_to_beach() {
  var_00 = [(1654, -1472, 304), (1812, -1366, 239), (1914, -1174, 187), (2185, -1170, 185)];
  var_01 = level.crab_boss;
  foreach(var_05, var_03 in level.players) {
    var_04 = spawnStruct();
    var_04.origin = var_00[var_05];
    var_04.angles = vectortoangles(var_01.origin - var_00[var_05]);
    level thread scripts\cp\maps\cp_town\cp_town_fast_travel::move_player_through_portal_tube(var_03, [var_04]);
  }
}

play_escort_intro_vo() {
  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::play_vo_at_start_of_boss_fight();
  wait(30);
  var_00 = scripts\engine\utility::random(level.players);
  if(isDefined(var_00.vo_prefix)) {
    switch (var_00.vo_prefix) {
      case "p1_":
        var_00 thread scripts\cp\cp_vo::try_to_play_vo("sally_escort_bomb_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p2_":
        var_00 thread scripts\cp\cp_vo::try_to_play_vo("pdex_escort_bomb_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p3_":
        var_00 thread scripts\cp\cp_vo::try_to_play_vo("andre_escort_bomb_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p4_":
        var_00 thread scripts\cp\cp_vo::try_to_play_vo("aj_escort_bomb_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      default:
        break;
    }
  }
}

escort_nav_obstacle_monitor() {
  level endon("game_ended");
  var_00 = 100;
  var_01 = 25;
  var_02 = 80;
  var_03 = level.escort_vehicle;
  var_04 = createnavobstaclebybounds(var_03.origin, (var_00, var_01, var_02), var_03.angles);
  var_05 = var_03.origin;
  for(;;) {
    wait(0.5);
    if(var_03.origin != var_05) {
      destroynavobstacle(var_04);
      var_04 = createnavobstaclebybounds(var_03.origin, (var_00, var_01, var_02), var_03.angles);
      var_05 = var_03.origin;
    }

    if(scripts\engine\utility::istrue(level.escort_vehicle_reaches_end)) {
      break;
    }
  }

  destroynavobstacle(var_04);
  var_04 = createnavobstaclebybounds(var_03.origin, (var_00, var_01, var_02), var_03.angles);
}