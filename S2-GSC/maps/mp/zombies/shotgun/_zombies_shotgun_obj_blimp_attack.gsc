/*************************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\shotgun\_zombies_shotgun_obj_blimp_attack.gsc
*************************************************************************/

sg_init_obj_blimp_attack() {
  common_scripts\utility::func_3C87("sky_rush");
  blimp_init();
  aud_blimp_attack_init();
  level.var_611["zmb_zeppelin_shot"] = loadfx("vfx/zombie/zmb_zeppelin_shot");
  level.var_611["zmb_zep_battery_fire_trail"] = loadfx("vfx/map/mp_zombie_nest/zmb_zep_battery_fire_trail");
  level.var_611["zmb_zeppelin_shot_charge_weak_spot1"] = loadfx("vfx/zombie/prototype_fx/zmb_zeppelin_shot_charge_weak_spot1");
  level.var_611["zmb_zeppelin_shot_charge_weak_spot2"] = loadfx("vfx/zombie/prototype_fx/zmb_zeppelin_shot_charge_weak_spot2");
  level.var_611["zmb_zeppelin_shot_charge_weak_spot3"] = loadfx("vfx/zombie/prototype_fx/zmb_zeppelin_shot_charge_weak_spot3");
  level.var_611["zmb_zeppelin_spotlight"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zeppelin_spotlight");
  level.var_611["zmb_zeppelin_battery_explosion"] = loadfx("vfx/explosion/zmb_zeppelin_battery_explosion");
  level.var_611["zmb_zeppelin_projectile"] = loadfx("vfx/trail/zmb_zeppelin_projectile");
  level.var_611["temp_klaus_radius"] = loadfx("vfx/zombie/prototype_fx/temp_klaus_radius");
  level.var_611["zmb_geistkraft_radius_400"] = loadfx("vfx/map/mp_zombie_nest/zmb_geistkraft_radius_400");
  level.var_611["zmb_zeppelin_battery_hide_explosion"] = loadfx("vfx/explosion/zmb_zeppelin_battery_hide_explosion");
  level.var_611["gk_raven_hc_ee_uber_stg_1"] = loadfx("vfx/zombie/abilities_perks\zmb_gk_uber_charge_stg_1");
  level.var_611["gk_raven_hc_ee_uber_stg_2"] = loadfx("vfx/zombie/abilities_perks\zmb_gk_uber_charge_stg_2");
  level.var_611["gk_raven_hc_ee_uber_stg_3"] = loadfx("vfx/zombie/abilities_perks\zmb_gk_uber_charge_stg_3");
  level.var_611["zmb_zeppelin_battery_damage"] = loadfx("vfx/zombie/prototype_fx/zmb_zeppelin_battery_damage");
  level.var_611["zmb_zep_rocket_smoketrail"] = loadfx("vfx/trail/zmb_zep_rocket_smoketrail");
  level.var_611["zmb_zeppelin_spotlight_nolight"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zeppelin_spotlight_nolight");
  level.var_611["zmb_zeppelin_shot_charge_barrel"] = loadfx("vfx/map/mp_zombie_nest/zmb_zeppelin_shot_charge_barrel");
  level.var_611["zmb_zeppelin_shot_charge"] = loadfx("vfx/map/mp_zombie_nest/zmb_zeppelin_shot_charge");
  level.var_611["zmb_zeppelin_shot_explosion"] = loadfx("vfx/explosion/zmb_zeppelin_shot_explosion");
  level.var_611["zmb_zep_battery_land_explosion"] = loadfx("vfx/explosion/zmb_zep_battery_land_explosion");
  level.var_611["zmb_zeppelin_gun_flash_wv"] = loadfx("vfx/muzzleflash/zmb_zeppelin_gun_flash_wv");
  level.var_611["zmb_zeppelin_gun_light"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zeppelin_gun_light");
  level.var_611["zmb_zeppelin_underlight"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zeppelin_underlight");
  level.var_611["zmb_zeppelin_spotlight_assault"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zeppelin_spotlight_assault");
  level.var_611["zmb_zeppelin_lightning_bolt"] = loadfx("vfx/map/mp_zombie_nest/zmb_zeppelin_lightning_bolt");
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("blimp_attack", ::run_blimp_attack, 240, 0, 1);
}

blimp_set_leaving() {
  self notify("set_new_blimp_behavior", "blimp_leave");
}

blimp_set_returning() {
  self notify("set_new_blimp_behavior", "blimp_return");
}

blimp_set_new_obj() {
  self notify("set_new_blimp_behavior", "blimp_new_objective");
}

blimp_init() {
  level.var_179A = getent("obj_blimp", "targetname");
  level.var_179A.var_9255 = level.var_179A.var_116;
  level.var_179A.var_9189 = level.var_179A.var_1D;
  level.var_179A method_8511();
  level.var_179A blimp_attach_weakpoints("blimp_door_damage_trigger");
  level.var_179A blimp_attach_turret("blimp_main_gun", "turretweapon_zeppelin_gun_zm");
  level.var_179A blimp_attach_battery("blimp_battery");
  level.var_179A blimp_attach_rockets("blimp_rocket_barrage_struct");
  level.var_179A.battery method_8511();
  common_scripts\utility::func_2CB4(5, ::battery_init_drop_points);
}

run_blimp_attack(param_00) {
  if(int(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("zmf_zepplin_pauses_zombie_waves"))) {
    maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8608();
  }

  if(!isDefined(level.var_179A)) {
    return;
  }

  if(common_scripts\utility::func_562E(level.sg_blimp_is_in_play)) {
    return;
  } else {
    level.sg_blimp_is_in_play = 1;
  }

  var_01 = common_scripts\utility::func_46B7("zmb_blimp_pieces_struct", "targetname");
  foreach(var_03 in var_01) {
    var_03.var_57F7 = 0;
  }

  level.var_179A blimp_show_hidden_parts();
  level.var_179A blimp_play_anims_and_fx();
  level.var_179A thread turret_zap_players();
  level.var_179A thread rocket_shoot_players();
  level.var_179A thread weakpoint_cycle();
  level.var_179A thread blimp_run_behavior();
  foreach(var_06 in level.var_744A) {
    var_06 setclientomnvar("ui_onevone_class_3", level.blimp_weak_points_count);
    var_06 setclientomnvar("ui_onevone_class_4", 0);
  }

  level.var_179A lib_0378::func_8D74("aud_blimp_start");
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_rideau_global::run_rideau_zeppelin_comment();
  level.var_179A blimp_set_new_obj();
  var_08 = level common_scripts\utility::func_A715("blimp_all_weakpoints_destroyed", "sg_obj_timeout", "sg_obj_force_end");
  level.var_179A blimp_set_leaving();
  level thread blimp_cleanup_once_left();
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8607();
  if(var_08 == "blimp_all_weakpoints_destroyed") {
    return 1;
  }

  return 0;
}

blimp_skip_cleanup() {
  level endon("blimp_all_weakpoints_destroyed");
  level endon("sg_obj_timeout");
  level waittill("skipWave");
  level notify("sg_obj_force_end");
}

blimp_cleanup_once_left() {
  level waittill("blimp_finished_exit");
  blimp_destroy();
}

blimp_run_behavior() {
  level endon("blimp_destroyed");
  thread blimp_patrol();
  thread blimp_set_can_zap_players(0);
  for(;;) {
    var_00 = blimp_wait_for_new_behavior_request();
    switch (var_00) {
      case "blimp_new_objective":
        blimp_set_first_assault();
        blimp_set_all_attacks_enabled();
        common_scripts\utility::func_3C8F("sky_rush");
        break;

      case "blimp_leave":
        blimp_set_all_attacks_disabled();
        blimp_set_state_leaving();
        break;

      case "blimp_return":
        blimp_set_all_attacks_enabled();
        blimp_set_state_returning();
        break;
    }
  }
}

blimp_patrol() {
  level endon("blimp_destroyed");
  blimp_setup_ref_node();
  blimp_do_main_entrance();
  var_00 = 0;
  var_01 = 0;
  var_02 = 4;
  for(;;) {
    while(lib_0547::func_585E()) {
      wait 0.05;
    }

    var_00 = common_scripts\utility::func_98E7(var_00 + 1 > var_02, 1, var_00 + 1);
    var_01 = common_scripts\utility::func_98E7(var_00 + 1 > var_02, 1, var_00 + 1);
    blimp_set_anim_state("s2_zmb_zeppelin_flightpath_idle_circle_0" + var_00);
    if(blimp_is_set_to_leave()) {
      blimp_retreat(var_01, 0);
    }
  }
}

blimp_reset(param_00) {
  if(common_scripts\utility::func_562E(param_00)) {
    level.blimp_parts_destroyed = 0;
  }

  thread blimp_wait_for_all_weakpoints_destroyed();
  common_scripts\utility::func_3C8F("sky_rush");
  blimp_cancel_round_wait();
}

blimp_set_first_assault() {
  self.var_4B8B = 0;
  blimp_set_battery_count(3);
  self.var_5704 = 0;
  thread blimp_wait_for_all_weakpoints_destroyed();
}

blimp_set_state_leaving() {
  if(!isDefined(level.var_179A.battery.var_5DDA)) {
    blimp_set_battery_count(0);
  } else {
    blimp_set_battery_count(self.battery.var_5DDA - 1);
  }

  self.var_5704 = 1;
}

blimp_is_set_to_leave() {
  return common_scripts\utility::func_562E(self.var_5704);
}

blimp_set_state_returning() {
  blimp_reset();
  self.var_5704 = 0;
}

blimp_set_all_attacks_disabled() {
  blimp_set_can_zap_players(0);
  blimp_set_can_rocket_players(0);
}

blimp_set_all_attacks_enabled() {
  func_7EB8();
  blimp_set_can_zap_players(1);
  blimp_set_can_rocket_players(1);
}

blimp_set_can_zap_players(param_00) {
  self.var_1F8D = param_00;
}

blimp_set_can_rocket_players(param_00) {
  self.var_1F1F = param_00;
}

blimp_attach_weakpoints(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  foreach(var_03 in var_01) {
    var_03.var_65D8 = getent(var_03.var_1A2, "targetname");
    var_04 = common_scripts\utility::func_46B5(var_03.var_65D8.var_1A2, "targetname");
    var_05 = spawn("script_model", var_04.var_116);
    var_05 setModel("tag_origin");
    var_03.var_65D9 = var_05;
  }

  foreach(var_08 in var_01) {
    var_08 enablelinkto();
    var_08 method_8449(self);
    var_08.var_65D8 method_8449(self);
    var_08.var_65D9 method_8449(self);
    var_08.var_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_closed_idle");
    var_08.var_65D8 method_8511();
  }

  self.blimp_weak_points = var_01;
  level.blimp_weak_points_count = self.blimp_weak_points.size;
}

blimp_attach_rockets(param_00) {
  var_01 = common_scripts\utility::func_46B5(param_00, "targetname");
  var_02 = getEntArray(var_01.var_1A2, "targetname");
  foreach(var_04 in var_02) {
    var_04 method_8449(self);
    var_04 thread rocket_handle_damage();
    var_04 method_8511();
  }

  self.rocket_bays = var_02;
}

blimp_attach_turret(param_00, param_01) {
  var_02 = common_scripts\utility::func_46B5(param_00, "targetname");
  self.blimp_turret = var_02 turret_build(param_01, var_02.var_165, ::turret_modify_player_damage, ::turret_on_player_damage);
  self.blimp_turret method_8449(self);
  self.blimp_turret method_8511();
}

blimp_attach_battery(param_00) {
  self.battery = getent(param_00, "targetname");
  self.battery method_8449(self);
}

blimp_set_battery_count(param_00) {
  self.battery.var_5DDA = param_00;
}

blimp_execute_leave(param_00) {
  blimp_set_anim_state("s2_zmb_zeppelin_flight_exit_0" + param_00);
  level notify("blimp_finished_exit");
}

blimp_display_state(param_00) {}

blimp_retreat(param_00, param_01) {
  blimp_execute_leave(param_00);
  if(common_scripts\utility::func_562E(param_01)) {
    var_02 = getent("overcharge_trig", "targetname");
    var_03 = 0;
    if(isDefined(var_02)) {
      var_03 = var_02.var_17A9;
    }

    if(common_scripts\utility::func_562E(level.var_1CBA)) {
      self waittill("cancel blimp wait");
    } else {
      blimp_wait_for_end_of_round(level.var_A980, var_02, var_03);
    }

    if(self.battery.var_5DDA > 0) {
      blimp_set_returning();
      blimp_set_anim_state("s2_zmb_zeppelin_flight_entrance_0" + param_00);
      return;
    }

    var_04 = "";
    while(var_04 != "blimp_new_objective") {
      self waittill("set_new_blimp_behavior", var_04);
    }

    blimp_set_anim_state("s2_zmb_zeppelin_flight_entrance_0" + param_00);
  }
}

blimp_wait_for_new_behavior_request() {
  self waittill("set_new_blimp_behavior", var_00);
  return var_00;
}

blimp_insert_new_battery() {
  thread blimp_take_damage();
}

blimp_wait_for_all_weakpoints_destroyed() {
  var_00 = undefined;
  foreach(var_02 in self.blimp_weak_points) {
    var_02 childthread weakpoint_take_damage_and_report_death(self);
  }

  level.blimp_parts_destroyed = 0;
  while(level.blimp_parts_destroyed < self.blimp_weak_points.size) {
    self waittill("blimp_weakpoint_destroyed", var_00, var_02);
    thread set_zombies_active_for_seconds(15);
    playFX(level.var_611["zmb_zeppelin_battery_explosion"], var_02.var_116);
    level.blimp_parts_destroyed++;
    foreach(var_05 in level.var_744A) {
      var_05 setclientomnvar("ui_onevone_class_4", level.blimp_parts_destroyed);
    }
  }

  level notify("blimp_all_weakpoints_destroyed");
}

set_zombies_active_for_seconds(param_00) {
  self endon("blimp_weakpoint_destroyed");
  level endon("blimp_all_weakpoints_destroyed");
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8607();
  wait(param_00);
  if(int(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("zmf_zepplin_pauses_zombie_waves"))) {
    maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8608();
  }
}

blimp_take_damage() {
  self notify("new_battery_primed");
  self endon("new_battery_primed");
  var_00 = undefined;
  foreach(var_02 in self.blimp_weak_points) {
    var_02 childthread weakpoint_take_damage_and_report_death(self);
  }

  self waittill("blimp_weakpoint_destroyed", var_00, var_02);
  playFX(level.var_611["zmb_zeppelin_battery_explosion"], var_02.var_116);
  if(!isDefined(level.blimp_parts_destroyed)) {
    level.blimp_parts_destroyed = 1;
  } else {
    level.blimp_parts_destroyed++;
  }

  if(level.blimp_parts_destroyed >= self.blimp_weak_points.size) {
    level notify("blimp_all_weakpoints_destroyed");
  }
}

blimp_tesla_damage_mod(param_00, param_01) {
  switch (param_00) {
    case "teslagun_zm":
      param_01 = 2000;
      break;

    case "teslagun_zm_blood":
      param_01 = 3000;
      break;

    case "teslagun_zm_death":
      param_01 = 3000;
      break;

    case "teslagun_zm_moon":
      param_01 = 3000;
      break;

    case "teslagun_zm_storm":
      param_01 = 3000;
      break;

    default:
      break;
  }

  return param_01;
}

blimp_wait_for_end_of_round(param_00, param_01, param_02) {
  level endon("blimp_destroyed");
  self endon("cancel blimp wait");
  if(isDefined(param_01)) {
    while(param_02 == param_01.var_17A9) {
      wait(0.1);
    }
  }

  while(level.var_A980 <= param_00) {
    wait(0.1);
  }
}

blimp_show_hidden_parts() {
  self method_805B();
  self.battery method_805B();
  self.blimp_turret method_805B();
  foreach(var_01 in self.blimp_weak_points) {
    var_01.var_65D8 method_805B();
  }

  foreach(var_04 in self.rocket_bays) {
    var_04 method_805B();
  }
}

blimp_get_num_parts_destroyed() {
  if(!isDefined(level.blimp_parts_destroyed)) {
    level.blimp_parts_destroyed = 0;
  }

  return level.blimp_parts_destroyed;
}

blimp_setup_ref_node() {
  var_00 = common_scripts\utility::func_46B5("boss_zepplin_scripted_node", "targetname");
  self.var_7B8B = var_00;
  self.var_7B8B.var_1D = self.var_7B8B.var_1D - (0, 90, 0);
}

blimp_do_main_entrance() {
  level.var_179A.var_57A9 = 1;
  blimp_set_anim_state("s2_zmb_zeppelin_flightpath_main_entrance");
}

blimp_set_anim_state(param_00) {
  level.var_179A blimp_play_anim_and_wait(param_00);
}

blimp_play_anim_and_wait(param_00, param_01) {
  self scriptmodelclearanim();
  if(isDefined(param_01)) {
    self method_8495(param_00, param_01.var_116, param_01.var_1D);
  } else {
    self method_8495(param_00, self.var_7B8B.var_116, self.var_7B8B.var_1D);
  }

  blimp_wait_for_anim_finished(param_00);
}

blimp_wait_for_anim_finished(param_00) {
  var_01 = getanimlength(blimp_string_to_anim(param_00));
  wait(var_01);
}

blimp_string_to_anim(param_00) {
  var_01 = % s2_zmb_zeppelin_flightpath_main_entrance;
  switch (param_00) {
    case "s2_zmb_zeppelin_flightpath_main_entrance":
      var_01 = % s2_zmb_zeppelin_flightpath_main_entrance;
      break;

    case "s2_zmb_zeppelin_flight_entrance_01":
      var_01 = % s2_zmb_zeppelin_flight_entrance_01;
      break;

    case "s2_zmb_zeppelin_flight_entrance_02":
      var_01 = % s2_zmb_zeppelin_flight_entrance_02;
      break;

    case "s2_zmb_zeppelin_flight_entrance_03":
      var_01 = % s2_zmb_zeppelin_flight_entrance_03;
      break;

    case "s2_zmb_zeppelin_flight_entrance_04":
      var_01 = % s2_zmb_zeppelin_flight_entrance_04;
      break;

    case "s2_zmb_zeppelin_flight_exit_01":
      var_01 = % s2_zmb_zeppelin_flight_exit_01;
      break;

    case "s2_zmb_zeppelin_flight_exit_02":
      var_01 = % s2_zmb_zeppelin_flight_exit_02;
      break;

    case "s2_zmb_zeppelin_flight_exit_03":
      var_01 = % s2_zmb_zeppelin_flight_exit_03;
      break;

    case "s2_zmb_zeppelin_flight_exit_04":
      var_01 = % s2_zmb_zeppelin_flight_exit_04;
      break;

    case "s2_zmb_zeppelin_flightpath_idle_circle_01":
      var_01 = % s2_zmb_zeppelin_flightpath_idle_circle_01;
      break;

    case "s2_zmb_zeppelin_flightpath_idle_circle_02":
      var_01 = % s2_zmb_zeppelin_flightpath_idle_circle_02;
      break;

    case "s2_zmb_zeppelin_flightpath_idle_circle_03":
      var_01 = % s2_zmb_zeppelin_flightpath_idle_circle_03;
      break;

    case "s2_zmb_zeppelin_flightpath_idle_circle_04":
      var_01 = % s2_zmb_zeppelin_flightpath_idle_circle_04;
      break;
  }

  return var_01;
}

blimp_cancel_round_wait() {
  level.var_179A notify("cancel blimp wait");
}

blimp_play_anims_and_fx() {
  if(common_scripts\utility::func_562E(self.var_3F78)) {
    return;
  }

  self.var_3F78 = 1;
  self scriptmodelplayanim("s2_zmb_zeppelin_idle");
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_gun_light"), level.var_179A.blimp_turret, "TAG_YAW");
  triggerfx(var_00);
  thread blimp_delete_fx_on_death(var_00);
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_underlight"), self, "TAG_ORIGIN");
  triggerfx(var_00);
  thread blimp_delete_fx_on_death(var_00);
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_A_LE_2");
  triggerfx(var_00);
  thread blimp_delete_fx_on_death(var_00);
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_spotlight"), self, "J_searchlight_B_LE_2");
  triggerfx(var_00);
  thread blimp_delete_fx_on_death(var_00);
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_C_LE_2");
  triggerfx(var_00);
  thread blimp_delete_fx_on_death(var_00);
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_A_RI_2");
  triggerfx(var_00);
  thread blimp_delete_fx_on_death(var_00);
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_spotlight"), self, "J_searchlight_B_RI_2");
  triggerfx(var_00);
  thread blimp_delete_fx_on_death(var_00);
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_C_RI_2");
  triggerfx(var_00);
  thread blimp_delete_fx_on_death(var_00);
}

blimp_delete_fx_on_death(param_00) {
  param_00 endon("death");
  self waittill("death");
  param_00 delete();
}

blimp_destroy() {
  level notify("blimp_destroyed");
  level.sg_blimp_is_in_play = 0;
  if(isDefined(level.var_179A)) {
    level.var_179A.blimp_turret delete();
    level.var_179A.battery delete();
    foreach(var_01 in level.var_179A.blimp_weak_points) {
      var_01 delete();
      var_01.var_65D8 delete();
    }

    foreach(var_04 in level.var_179A.rocket_bays) {
      var_04 delete();
    }

    level.var_179A delete();
  }
}

weakpoint_take_damage_and_report_death(param_00) {
  level endon("blimp_destroyed");
  param_00 endon("blimp_all_weakpoints_destroyed");
  self.var_A996 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("zepplin_weakpoint_health");
  var_01 = 2625;
  var_02 = 1750;
  var_03 = 875;
  var_04 = [var_01, var_02, var_03];
  self.var_4C13 = 0;
  for(var_05 = undefined; self.var_A996 > 0; var_05 = var_07) {
    self waittill("damage", var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F);
    if(common_scripts\utility::func_562E(self.is_weakpoint_covered)) {
      continue;
    }

    var_06 = blimp_tesla_damage_mod(var_0F, var_06);
    self.var_A996 = self.var_A996 - var_06;
    if(self.var_A996 < 0) {
      self.var_A996 = 0;
    }

    var_10 = 0;
    while(self.var_4C13 < 2 && self.var_A996 < var_04[self.var_4C13]) {
      var_10 = 1;
      self.var_4C13++;
    }

    if(var_10) {
      weakpoint_display_damage_status_fx();
    }

    if(randomint(100) < 30) {
      playFX(level.var_611["zmb_zeppelin_battery_damage"], self.var_116);
    }

    var_07 maps\mp\gametypes\_damagefeedback::func_A102("standard");
  }

  weakpoint_clear_fx();
  param_00 notify("blimp_weakpoint_destroyed", var_05, self);
}

weakpoint_open_doors(param_00, param_01) {
  var_02 = [];
  var_02["zom_zeppelin_panels_01_open"] = % zom_zeppelin_panels_01_open;
  var_02["zom_zeppelin_panels_01_open_idle"] = % zom_zeppelin_panels_01_open_idle;
  if(isDefined(param_00)) {
    var_03 = param_00;
  } else {
    var_03 = self.blimp_weak_points;
  }

  foreach(var_05 in var_03) {
    var_05.var_65D8 scriptmodelclearanim();
  }

  foreach(var_05 in var_03) {
    var_05.var_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_open");
  }

  wait(getanimlength(var_02["zom_zeppelin_panels_01_open"]));
  if(common_scripts\utility::func_562E(param_01)) {
    return;
  }

  foreach(var_05 in var_03) {
    var_05.var_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_open_idle");
    var_05.var_65D8 method_805B();
    var_05.is_weakpoint_covered = 0;
    var_05 thread weakpoint_display_damage_status_fx();
  }
}

weakpoint_close_doors(param_00) {
  var_01 = [];
  var_01["zom_zeppelin_panels_01_close"] = % zom_zeppelin_panels_01_close;
  var_01["zom_zeppelin_panels_01_closed_idle"] = % zom_zeppelin_panels_01_closed_idle;
  if(isDefined(param_00)) {
    var_02 = param_00;
  } else {
    var_02 = self.blimp_weak_points;
  }

  foreach(var_04 in var_02) {
    var_04.var_65D8 scriptmodelclearanim();
  }

  foreach(var_04 in var_02) {
    var_04.var_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_close");
  }

  wait(getanimlength(var_01["zom_zeppelin_panels_01_close"]));
  foreach(var_04 in var_02) {
    var_04.var_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_closed_idle");
  }
}

weakpoint_reveal(param_00) {
  self notify("door_anim_change");
  self endon("door_anim_change");
  var_01 = [];
  var_02 = self.blimp_weak_points;
  foreach(var_04 in self.blimp_weak_points) {
    if(common_scripts\utility::func_562E(param_00)) {
      break;
    }

    if(isDefined(var_04.var_A996) && var_04.var_A996 <= 0) {
      var_02 = common_scripts\utility::func_F93(var_02, var_04);
    }
  }

  for(var_06 = 0; var_06 < 4; var_06++) {
    var_07 = common_scripts\utility::func_7A33(var_02);
    var_02 = common_scripts\utility::func_F93(var_02, var_07);
    var_01 = common_scripts\utility::func_F6F(var_01, var_07);
  }

  var_01 = common_scripts\utility::func_F97(var_01);
  weakpoint_open_doors(var_01, param_00);
  return var_01;
}

weakpoint_hide(param_00) {
  var_01 = self;
  var_01 notify("door_anim_change");
  var_01 endon("door_anim_change");
  foreach(var_03 in var_01.blimp_weak_points) {
    var_03.is_weakpoint_covered = 1;
    var_03 weakpoint_clear_fx();
  }

  var_01 weakpoint_close_doors(param_00);
}

weakpoint_display_damage_status_fx() {
  weakpoint_clear_fx();
  wait 0.05;
  if(!isDefined(self.var_4C13)) {
    self.var_4C13 = 0;
  }

  var_00 = "zmb_zeppelin_shot_charge_weak_spot" + self.var_4C13 + 1;
  var_01 = common_scripts\utility::func_44F5(var_00);
  self.var_3F44 = var_01;
  playFXOnTag(var_01, self.var_65D8, "tag_origin");
}

weakpoint_clear_fx() {
  var_00 = self.var_3F44;
  if(!isDefined(var_00)) {
    return;
  }

  stopFXOnTag(var_00, self.var_65D8, "tag_origin");
  self.var_3F44 = undefined;
}

weakpoint_cycle() {
  var_00 = self;
  level endon("blimp_destroyed");
  for(;;) {
    var_01 = var_00 weakpoint_reveal();
    var_00 wait_for_weakpoint_destroyed_or_timeout();
    if(level.blimp_parts_destroyed < 3) {
      var_00 weakpoint_hide(var_01);
    } else {
      var_00 weakpoint_reveal(1);
    }

    wait(randomfloatrange(5, 10));
  }
}

wait_for_weakpoint_destroyed_or_timeout() {
  self endon("weapoint_timeout");
  thread weakpoint_timeout();
  self waittill("blimp_weakpoint_destroyed");
}

weakpoint_timeout() {
  self endon("weapoint_timeout");
  self endon("blimp_weakpoint_destroyed");
  var_00 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("blimp_attack_weapoint_reveal_time");
  if(var_00 == 0) {
    return;
  } else {
    wait(var_00);
  }

  self notify("weapoint_timeout");
}

turret_build(param_00, param_01, param_02, param_03) {
  var_04 = spawnturret("misc_turret", self.var_116, param_00);
  var_04.var_1D = self.var_1D;
  var_04 setModel(param_01);
  var_04 setdefaultdroppitchyaw(0);
  var_04 setmode("auto_nonai");
  var_04 method_80F9(undefined);
  var_04 method_80FB(0);
  var_04 method_8131();
  var_04 makeunusable();
  var_04 method_8130("axis");
  var_04 setentityowner(var_04);
  var_04 turretdontresetanglesonexitornotarget(1);
  if(isDefined(param_02)) {
    var_04.var_62AD = param_02;
  }

  if(isDefined(param_03)) {
    var_04.var_6B73 = param_03;
  }

  return var_04;
}

turret_set_target(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  if(isDefined(param_00) && isPlayer(param_00)) {
    var_01 = (0, 0, 0);
  } else {
    var_01 = (0, 0, 0);
  }

  level.var_179A.blimp_turret setturrettargetentity(param_00, var_01, 1);
}

turret_get_target() {
  return level.var_179A.blimp_turret getturrettargetent();
}

turret_clear_target() {
  level.var_179A.blimp_turret clearturrettargetentity();
}

turret_check_if_target(param_00) {
  var_01 = turret_get_target();
  return isDefined(var_01) && var_01 == param_00;
}

turret_start_firing() {
  level.var_179A.blimp_turret method_80D5();
  level.var_179A.blimp_turret lib_0378::func_8D74("aud_blimp_projectile");
}

turret_stop_firing() {
  level.var_179A.blimp_turret method_80D6();
}

turret_is_firing() {
  level.var_179A.blimp_turret method_80D7();
}

turret_modify_player_damage(param_00) {
  if(!isPlayer(self)) {
    return param_00;
  }

  param_00 = self.var_FB * 0.95;
  return param_00;
}

turret_on_player_damage(param_00) {
  var_01 = self;
  var_02 = getweaponexplosionradius("turretweapon_zeppelin_gun_zm");
  var_03 = 1 - distance(param_00.var_116, var_01.var_116) / var_02;
  if(var_03 < 0) {
    var_03 = 0;
  }

  var_01 lib_0547::func_7419(param_00.var_116, var_03 * var_02 + 100);
  var_01 lib_0378::func_8D74("aud_blimp_hit_plr");
}

turret_zap_players() {
  level endon("blimp_destroyed");
  level.var_17A4 = ["zone1_1_start", "zone1_2_gallows", "zone1_4_bridge", "zone1_4_bridge_tower", "zone1_3_riverside", "zone1_5_rooftops"];
  level.var_17A5 = [];
  for(var_00 = 0; var_00 < level.var_17A4.size; var_00++) {
    var_01 = getEntArray(level.var_17A4[var_00], "targetname");
    level.var_17A5 = common_scripts\utility::func_F73(level.var_17A5, var_01);
  }

  if(!isDefined(level.var_179A.var_982A)) {
    level.var_179A.var_982A = spawn("script_model", level.var_179A gettagorigin("J_searchlight_A_RI_2"));
    level.var_179A.var_982A setModel("tag_origin");
    level.var_179A.var_982A method_8449(level.var_179A);
  }

  for(;;) {
    wait(3);
    while(lib_0547::func_585E()) {
      wait 0.05;
    }

    if(common_scripts\utility::func_562E(level.var_179A.var_1F8D)) {
      var_02 = undefined;
      while(!isDefined(var_02) || !isalive(var_02)) {
        var_02 = common_scripts\utility::func_4461(self.var_116, level.var_744A);
        wait(0.25);
      }

      turret_set_target(var_02);
      var_03 = level.var_179A.blimp_turret gettagorigin("TAG_PITCH");
      var_04 = spawn("script_model", var_03);
      var_04 setModel("Tag_Origin");
      var_04 method_8449(level.var_179A.blimp_turret);
      var_04 lib_0378::func_8D74("aud_blimp_charge");
      var_05 = 0;
      while(isalive(var_02)) {
        var_06 = level.var_179A.blimp_turret gettagorigin("TAG_AIM");
        var_07 = level.var_179A.blimp_turret gettagangles("TAG_AIM");
        var_08 = anglesToForward(var_07);
        var_09 = vectornormalize(var_02.var_116 - var_06);
        var_0A = vectordot(var_08, var_09);
        level.var_8C4C = level.var_179A.blimp_turret gettagorigin("TAG_AIM");
        var_0B = (var_02.var_1D[0], var_02.var_1D[1], var_02.var_1D[0]);
        var_0C = 128 + randomint(128) * vectornormalize(anglesToForward(var_0B));
        level.var_8C46 = var_02.var_116 + var_0C;
        level.var_8C4B = spawnsighttrace(level.var_8C4C, level.var_8C4C, level.var_8C46, 0);
        var_0D = bulletTrace(level.var_179A.blimp_turret gettagorigin("TAG_AIM"), level.var_8C46, 0, level.var_179A.blimp_turret);
        var_0E = abs(var_0D["position"][2] - var_02.var_116[2]);
        if(var_0E > 64) {
          level.var_8C46 = var_02.var_116;
          level.var_8C4B = spawnsighttrace(level.var_8C4C, level.var_8C4C, level.var_8C46, 0);
          if(level.var_8C4B >= 0.99 &var_0A >= 0.99) {
            break;
          }

          continue;
        }

        break;
        wait 0.05;
      }

      var_0F = turret_spawn_strike_point(level.var_8C46 + (0, 0, -12));
      var_0D = bulletTrace(level.var_179A.blimp_turret gettagorigin("TAG_AIM"), var_0F.var_116, 0, level.var_179A.blimp_turret);
      var_0F.var_116 = var_0D["position"];
      var_0F.var_1D = vectortoangles(var_04.var_116 - var_0F.var_116);
      turret_set_target(var_0F);
      playFXOnTag(common_scripts\utility::func_44F5("zmb_zeppelin_shot_charge"), level.var_179A.blimp_turret, "TAG_YAW");
      playFXOnTag(common_scripts\utility::func_44F5("zmb_zeppelin_shot_charge_barrel"), level.var_179A.blimp_turret, "TAG_AIM");
      var_10 = level.var_179A.blimp_turret gettagorigin("TAG_LIGHT");
      var_11 = level.var_179A.blimp_turret gettagangles("TAG_LIGHT");
      var_12 = spawn("script_model", var_10);
      var_12 setModel("tag_origin");
      var_12.var_1D = var_11;
      var_12 method_8449(level.var_179A.blimp_turret);
      playFXOnTag(level.var_611["zmb_zeppelin_spotlight_assault"], var_12, "tag_origin");
      playFXOnTag(level.var_611["zmb_zeppelin_shot"], var_0F, "tag_origin");
      wait(1);
      stopFXOnTag(level.var_611["zmb_zeppelin_spotlight_assault"], var_12, "tag_origin");
      turret_start_firing();
      var_13 = launchbeam("zmb_tesla_zep_beam", level.var_179A.blimp_turret, "tag_flash", var_0F, "tag_origin");
      wait(1);
      turret_stop_firing();
      turret_clear_target();
      var_12 delete();
      var_04 delete();
      wait(0.15);
      var_13 delete();
      var_0F delete();
      continue;
    }

    wait(0.5);
  }
}

turret_spawn_strike_point(param_00) {
  var_01 = spawn("script_model", param_00);
  var_01 setModel("tag_origin");
  return var_01;
}

battery_init_drop_points() {
  var_00 = common_scripts\utility::func_46B7("zmb_blimp_pieces_struct", "targetname");
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_44BE(var_02.var_1A2, "targetname");
    foreach(var_05 in var_03) {
      switch (var_05.var_165) {
        case "zmb_blimp_pieces_holder":
          var_02.var_4DEA = var_05;
          break;

        case "zmb_blimp_pieces_uber":
          var_02.var_9FE1 = var_05;
          break;

        case "zmb_blimp_pieces_rubble":
          var_02.var_7F40 = var_05;
          break;

        case "zmb_blimp_pieces_clip":
          var_02.var_241F = var_05;
          var_02.var_241F notsolid();
          var_02.var_241F method_8060();
          var_02.var_241F method_8511();
          break;
      }
    }
  }
}

battery_spawn(param_00) {
  var_01 = level.var_179A.blimp_turret battery_spawn_drop(param_00);
  var_02 = "zombie_battery_death_" + self.var_1A5 + "_" + blimp_get_num_parts_destroyed();
  if(common_scripts\utility::func_562E(level.var_1CBA)) {
    maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8606();
  }

  if(battery_should_collect_souls()) {
    playFXOnTag(level.var_611["zmb_geistkraft_radius_400"], var_01, "TAG_ORIGIN");
    var_03 = 20;
    thread battery_show_soul_collect_progress(var_01);
    var_01 maps\mp\mp_zombies_soul_collection::func_170B(var_03, 400, 100, var_02, undefined, "tag_fx", "zmb_zep_receiver_charge_pnt", "tag_origin", undefined, var_01.var_34A5.var_7F41, (0, 0, 48));
    stopFXOnTag(level.var_611["zmb_geistkraft_radius_400"], var_01, "TAG_ORIGIN");
  }

  lib_0585::func_8F7E(var_01.var_116, undefined, undefined, undefined, undefined);
  var_01.var_9FE6 delete();
  var_01.var_34A5 battery_set_drop_point_inactive();
  playFX(loadfx("vfx/explosion/zmb_zeppelin_battery_hide_explosion"), var_01.var_116);
  var_01 delete();
}

battery_show_soul_collect_progress(param_00) {
  var_01 = [7, 14, 20];
  var_02 = 0;
  var_03 = undefined;
  while(!isDefined(param_00.var_695B)) {
    wait 0.05;
  }

  for(;;) {
    while(isDefined(param_00) && isDefined(param_00.var_AC2C) && param_00.var_AC2C < var_01[var_02]) {
      level waittill(param_00.var_695B);
      waittillframeend;
    }

    if(var_02 == var_01.size - 1) {
      var_03 delete();
      break;
    }

    if(isDefined(var_03)) {
      var_03 delete();
      wait 0.05;
    }

    var_03 = spawnfx(level.var_611["gk_raven_hc_ee_uber_stg_" + var_02 + 1], param_00.var_9FE6.var_116, anglesToForward(param_00.var_9FE6.var_1D), anglestoup(param_00.var_9FE6.var_1D));
    triggerfx(var_03);
    var_02++;
  }
}

battery_should_collect_souls() {
  return 1;
}

battery_fall_onto_pos(param_00) {
  playsoundatpos(self.var_116, "zmb_blimp_mortar_inc");
  var_01 = param_00 - self.var_116;
  var_02 = sqrt(abs(var_01[2] * 2 / 800));
  var_03 = 1 / var_02;
  var_04 = var_01 * (var_03, var_03, 0);
  self gravitymove(var_04, var_02);
  thread battery_rotate_to_motion();
  wait(var_02);
  self.var_116 = param_00;
  playFX(loadfx("vfx/explosion/zmb_zep_rocket_impact"), param_00);
  self notify("blimp_battery_detonate");
  playsoundatpos(param_00, "zmb_blimp_mortar_exp");
  earthquake(0.55, 0.6, param_00, 200);
  wait 0.05;
  var_05 = lib_0547::func_408F();
  var_06 = common_scripts\utility::func_F73(var_05, level.var_744A);
  foreach(var_08 in var_06) {
    if(distance(param_00, var_08.var_116) < 128) {
      if(isPlayer(var_08)) {
        var_08 setblurforplayer(3, 0.8);
      } else if(common_scripts\utility::func_562E(var_08.var_A87C)) {
        continue;
      } else {
        var_08.var_A87C = 1;
      }

      if(isPlayer(var_08)) {
        var_08 dodamage(15, param_00, self, self, "MOD_EXPLOSIVE");
        continue;
      }

      var_08 dodamage(15, param_00, self, self, "MOD_RIFLE_BULLET");
    }
  }

  self delete();
}

battery_rotate_to_motion() {
  var_00 = self.var_116;
  level endon("blimp_destroyed");
  self endon("blimp_battery_detonate");
  for(;;) {
    wait 0.05;
    var_01 = vectortoangles(var_00 - self.var_116);
    self.var_1D = var_01;
    var_00 = self.var_116;
  }
}

battery_spawn_drop(param_00, param_01) {
  var_02 = spawn("script_model", self.var_116);
  var_02 setModel("zmb_uberschnalle_battery_chunk_01");
  playFXOnTag(level.var_611["zmb_zep_battery_fire_trail"], var_02, "tag_origin");
  var_02 lib_0378::func_8D74("aud_blimp_turret_explode");
  var_03 = common_scripts\utility::func_46B7("zmb_blimp_pieces_struct", "targetname");
  var_04 = (0, 0, -800);
  var_05 = 4;
  if(isDefined(level.var_1CBF)) {
    var_06 = battery_get_closest_valid_drop_point(self.var_116, level.var_1CBC);
  } else {
    var_06 = battery_get_closest_valid_drop_point(self.var_116, var_04);
  }

  var_07 = var_06;
  var_08 = var_07.var_4DEA.var_116 - self.var_116;
  var_05 = sqrt(abs(var_08[2] * 2 / 800));
  var_09 = 1 / var_05;
  var_0A = var_08 * (var_09, var_09, 0);
  var_02 gravitymove(var_0A, var_05);
  if(isDefined(var_07.var_4DEA.var_1D)) {
    var_02 rotateto(var_07.var_4DEA.var_1D, var_05);
  }

  wait(var_05);
  if(!common_scripts\utility::func_562E(param_01)) {
    var_07 battery_set_drop_point_active();
  }

  var_02.var_116 = var_07.var_4DEA.var_116;
  var_02.var_9FE6 = spawn("script_model", var_07.var_9FE1.var_116);
  var_02.var_9FE6 setModel("zmb_gp_uber_01");
  if(isDefined(var_07.var_9FE1.var_1D)) {
    var_02.var_9FE6.var_1D = var_07.var_9FE1.var_1D;
  }

  var_02.var_9FE6 method_8449(var_02);
  if(isDefined(level.var_1CBF)) {
    var_02.var_116 = var_02.var_116 + (0, 0, 4);
  }

  playFX(level.var_611["zmb_zep_battery_land_explosion"], var_07.var_4DEA.var_116 + (0, 0, -20));
  lib_0378::func_8D74("aud_blimp_battery_land", var_07.var_4DEA);
  var_02.var_34A5 = var_07;
  return var_02;
}

battery_get_closest_valid_drop_point(param_00, param_01) {
  for(;;) {
    if(param_01.size == 0) {
      return undefined;
    }

    var_02 = common_scripts\utility::func_4461(param_00, param_01);
    if(!isDefined(var_02.var_57F7) || !var_02.var_57F7) {
      return var_02;
    } else {
      param_01 = common_scripts\utility::func_F93(param_01, var_02);
    }
  }
}

battery_set_drop_point_active() {
  var_00 = spawn("script_model", self.var_7F40.var_116);
  if(isDefined(self.var_7F40.var_1D)) {
    var_00.var_1D = self.var_7F40.var_1D;
  }

  var_00 setModel("zmb_uberschnalle_battery_rubble_01");
  self.var_7F41 = var_00;
  self.var_241F solid();
  self.var_241F method_805B();
  self.var_241F method_805F();
  var_01 = common_scripts\utility::func_F73(level.var_744A, lib_0547::func_408F());
  foreach(var_03 in var_01) {
    if(function_01EF(var_03)) {
      if(var_03.var_A4B == "zombie_boss_village") {
        continue;
      }
    }

    if(var_03 istouching(self.var_241F)) {
      if(isPlayer(var_03)) {
        var_04 = self.var_116;
        if(canspawn(var_04)) {
          var_03 setorigin(var_04);
        } else {
          var_05 = getclosestpointonnavmesh(var_04);
          if(canspawn(var_05)) {
            var_03 setorigin(var_05);
          } else {
            maps\mp\_movers::func_A047(var_03, 0);
          }
        }

        var_03 dodamage(var_03.var_BC + 666, self.var_7F40.var_116, undefined, undefined, "MOD_CRUSH");
        continue;
      }

      var_03 dodamage(var_03.var_BC + 666, self.var_7F40.var_116, undefined, undefined, "MOD_EXPLOSIVE");
    }
  }

  self.var_57F7 = 1;
  thread battery_clip_exploit_listener();
}

battery_set_drop_point_inactive() {
  if(isDefined(self.var_7F41)) {
    self.var_7F41 delete();
  }

  self.var_241F method_8060();
  self.var_241F notsolid();
  self.var_241F method_805C();
  self.var_57F7 = 0;
  self notify("stop_exploit_listener");
}

battery_clip_exploit_listener() {
  self endon("stop_exploit_listener");
  if(!isDefined(self.var_241F)) {
    return;
  }

  for(;;) {
    foreach(var_01 in level.var_744A) {
      var_02 = var_01 method_8551();
      if(isDefined(var_02) && var_02 == self.var_241F) {
        var_03 = self.var_116;
        if(canspawn(var_03)) {
          var_01 setorigin(var_03);
        } else {
          var_04 = getclosestpointonnavmesh(var_03);
          if(canspawn(var_04)) {
            var_01 setorigin(var_04);
          } else {
            maps\mp\_movers::func_A047(var_01, 0);
          }
        }

        var_01 dodamage(var_01.var_BC + 666, self.var_7F40.var_116, undefined, undefined, "MOD_CRUSH");
      }
    }

    wait(0.5);
  }
}

rocket_modify_damage(param_00, param_01, param_02, param_03) {
  param_03 = blimp_tesla_damage_mod(param_01, param_03);
  if(randomint(100) < 30) {
    playFX(level.var_611["zmb_zeppelin_battery_damage"], self.var_116);
  }

  var_04 = param_03;
  if(getdvarint("spv_zm_difficulty_enabled", 0) == 1) {
    var_04 = maps\mp\zombies\_zombies_progression::zombie_shotgun_mode_bonus_damage(param_00, var_04, param_01);
  }

  return var_04;
}

rocket_on_destroyed(param_00, param_01, param_02, param_03) {
  self notify("death", param_00, param_02, param_01);
  self.var_57B1 = 1;
  self method_8511();
}

rocket_shoot_players() {
  level endon("blimp_destroyed");
  for(;;) {
    wait(5);
    var_00 = 0;
    var_01 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("blimp_attack_sizzlers_create");
    foreach(var_03 in lib_0547::func_408F()) {
      var_04 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("blimp_attack_sizzlers_create_wave");
      if(level.objectivescompleted < var_04) {
        break;
      }

      if(var_03 maps\mp\zombies\sg_events_v1\extermination::try_to_become_a_sizzler()) {
        var_00++;
      }

      if(var_00 >= var_01) {
        break;
      }
    }

    while(lib_0547::func_585E()) {
      wait 0.05;
    }

    if(common_scripts\utility::func_562E(self.var_1F1F)) {
      if(!maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("blimp_attack_rockets_quickdraw")) {
        wait(8);
      }

      foreach(var_07 in self.rocket_bays) {
        if(common_scripts\utility::func_562E(var_07.var_57B1)) {
          continue;
        }

        var_08 = 512;
        if(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("blimp_attack_rockets_focuses")) {
          var_08 = 8;
        }

        var_09 = common_scripts\utility::func_7A33(level.var_744A);
        var_0A = getclosestpointonnavmesh(var_09.var_116 + (randomint(var_08) - var_08 / 2, randomint(var_08) - var_08 / 2, 0), var_09);
        var_0B = var_07.var_116 + var_07 rocket_get_pos_offset();
        var_0C = bullettracepassed(var_0B, var_0A, 0, var_07);
        var_0D = bullettracepassed(var_0A, var_0B, 0, var_07);
        if(!var_0C || !var_0D || common_scripts\utility::func_562E(var_07.var_56EF)) {
          continue;
        }

        var_07 thread rocket_fire(var_09.var_116);
        wait(0.25);
      }
    }
  }
}

rocket_get_pos_offset() {
  if(!isDefined(self) || !isDefined(self.var_1D)) {
    return (0, 0, 0);
  }

  return 64 * vectornormalize(anglesToForward(self.var_1D)) + (0, 0, 16);
}

rocket_fire(param_00) {
  level endon("blimp_destroyed");
  self.var_56EF = 1;
  self scriptmodelclearanim();
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_open");
  wait(getanimlength(%zmb_zeppelin_rocket_pod_open));
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_open_idle");
  var_01 = spawn("script_model", self.var_116 + rocket_get_pos_offset());
  var_01 setModel("npc_usa_bazooka_rocket_base");
  playFXOnTag(level.var_611["zmb_zep_rocket_smoketrail"], var_01, "tag_origin");
  var_01 thread battery_fall_onto_pos(param_00);
  wait(0.5);
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_close");
  wait(getanimlength(%zmb_zeppelin_rocket_pod_close));
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_close_idle");
  self.var_56EF = 0;
}

func_7EB8() {
  foreach(var_01 in self.rocket_bays) {
    var_01 notify("damage", 100000);
    var_01.var_57B1 = 0;
    var_01 method_805B();
  }

  wait 0.05;
  foreach(var_01 in self.rocket_bays) {
    var_01 thread rocket_handle_damage();
  }
}

rocket_handle_damage() {
  var_00 = 1000;
  self.var_BC = var_00;
  self.var_93FD = 0;
  self setCanDamage(1);
  self.var_57B1 = 0;
  thread maps\mp\gametypes\_damage::func_8676(var_00, undefined, ::rocket_on_destroyed, ::rocket_modify_damage);
}

aud_blimp_attack_init() {
  lib_0378::func_8DC7("aud_play_blimp_dialog", ::aud_play_blimp_dialog);
  lib_0378::func_8DC7("aud_play_pa_dialog", ::aud_play_pa_dialog);
  lib_0378::func_8DC7("aud_stop_pa_dialog", ::aud_stop_pa_dialog);
  lib_0378::func_8DC7("aud_play_pa_music", ::aud_play_pa_music);
  lib_0378::func_8DC7("aud_zombie_soul_suck", ::aud_zombie_soul_suck);
  lib_0378::func_8DC7("aud_zombie_soul_suck_threshold", ::aud_zombie_soul_suck_threshold);
  lib_0378::func_8DC7("aud_blimp_start", ::aud_blimp_start);
  lib_0378::func_8DC7("aud_blimp_charge", ::aud_blimp_charge);
  lib_0378::func_8DC7("aud_blimp_projectile", ::aud_blimp_projectile);
  lib_0378::func_8DC7("aud_blimp_hit_plr", ::aud_blimp_hit_plr);
  lib_0378::func_8DC7("aud_blimp_turret_explode", ::aud_blimp_turret_explode);
  lib_0378::func_8DC7("aud_blimp_battery_land", ::aud_blimp_battery_land);
  lib_0378::func_8DC7("aud_blimp_projectile_impact", ::aud_blimp_projectile_impact);
}

aud_play_blimp_dialog(param_00, param_01) {
  if(common_scripts\utility::func_562E(level.var_943B.var_90C2)) {
    return;
  }

  lib_0380::func_288D(param_00, undefined, param_01, 0, 1, 3);
}

aud_play_pa_dialog(param_00, param_01, param_02) {
  if(isDefined(param_02) && isarray(param_02)) {
    foreach(var_04 in level.var_744A) {
      var_04 thread aud_sndx_play_on_pa_system(param_00, param_02, "exterior");
    }
  }
}

aud_stop_pa_dialog() {
  foreach(var_01 in level.var_744A) {
    if(isDefined(var_01.var_71D.var_6DDA)) {
      lib_0380::func_6850(var_01.var_71D.var_6DDA, 0.25);
      var_01.var_71D.var_6DDA = undefined;
    }

    if(isDefined(var_01.var_71D.var_6DD9)) {
      lib_0380::func_6850(var_01.var_71D.var_6DD9, 0.25);
      var_01.var_71D.var_6DD9 = undefined;
    }

    if(isDefined(var_01.var_71D.var_6DDB)) {
      foreach(var_03 in var_01.var_71D.var_6DDB) {
        lib_0380::func_6850(var_03, 0.25);
      }

      var_01.var_71D.var_6DDB = [];
    }
  }
}

aud_sndx_play_on_pa_system(param_00, param_01, param_02) {
  var_03 = self;
  var_04 = 0.3;
  var_05 = undefined;
  var_06 = 1;
  var_07 = 1;
  if(!isDefined(var_03.var_71D.var_6DD8)) {
    var_03.var_71D.var_6DDB = [];
  }

  wait(randomintrange(1, 2));
  if(param_02 == "exterior") {
    var_05 = param_00 + "2";
    if(!function_0344(var_05)) {
      var_05 = param_00 + "_2";
      if(!function_0344(var_05)) {
        var_05 = undefined;
      }
    }
  }

  var_03.var_71D.var_6DD3 = [];
  for(var_08 = 0; var_08 < param_01.size; var_08++) {
    var_09 = param_01[var_08];
    var_0A = spawnStruct();
    var_0A.var_90BE = var_09;
    var_0A.var_3018 = distance(var_03.var_116, var_09.var_116);
    var_03.var_71D.var_6DD3[var_08] = var_0A;
  }

  var_0B = common_scripts\utility::func_7897(var_03.var_71D.var_6DD3, ::aud_play_pa_dialog_qsort_compare_func);
  if(isDefined(var_03.var_71D.var_6DDA)) {
    lib_0380::func_6850(var_03.var_71D.var_6DDA, 0.25);
    var_03.var_71D.var_6DDA = undefined;
  }

  var_03.var_71D.var_6DDA = lib_0380::func_6846(param_00, var_03, var_03, 0, 1);
  if(isDefined(var_03.var_71D.var_6DD9)) {
    lib_0380::func_6850(var_03.var_71D.var_6DD9, 0.25);
    var_03.var_71D.var_6DD9 = undefined;
  }

  if(isDefined(var_05)) {
    var_03.var_71D.var_6DD9 = lib_0380::func_6840(var_05, var_03, 0, 0.5);
  }

  foreach(var_0D in var_03.var_71D.var_6DDB) {
    lib_0380::func_6850(var_0D, 0.25);
  }

  var_03.var_71D.var_6DDB = [];
  var_0F = min(var_07, param_01.size);
  for(var_08 = 0; var_08 < var_0F; var_08++) {
    wait(var_04);
    var_09 = var_0B[var_08].var_90BE;
    var_06 = var_06 * 0.5;
    var_03.var_71D.var_6DDB[var_03.var_71D.var_6DDB.size] = lib_0380::func_6842(param_00 + "_delay", var_03, var_09.var_116, 0, var_06);
  }
}

aud_sndx_player_pa_monitor() {
  self endon("disconnect");
  var_00 = 0.5;
  var_01 = 1;
  var_02 = 1;
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    self method_8626("pa_inside", 1);
    wait(var_00);
  }
}

aud_play_pa_music(param_00) {
  var_01 = "zmb_wwii_march_music";
  if(!isDefined(param_00) || param_00.size <= 0) {
    return;
  }

  foreach(var_03 in level.var_744A) {
    lib_0380::func_2889(var_01, var_03, param_00[0].var_116, 0, 1);
  }
}

aud_play_pa_dialog_qsort_compare_func(param_00, param_01) {
  return param_00.var_3018 <= param_01.var_3018;
}

aud_zombie_soul_suck(param_00, param_01) {
  var_02 = spawn("script_origin", param_00);
  lib_0380::func_288B("zombie_soul_suck", undefined, var_02);
  var_02 moveto(param_01, 1.9);
  wait(2);
  var_02 delete();
}

aud_zombie_soul_suck_threshold(param_00) {
  lib_0380::func_2889("zombie_soul_suck_threshold", undefined, param_00);
}

aud_blimp_start() {
  var_00 = self;
  var_01 = undefined;
  var_02 = 2;
  var_03 = 1;
  var_04 = 5;
  wait(1);
  var_05 = spawn("script_origin", var_00.var_116);
  var_05 linkto(var_00, "tag_origin", (0, 0, -720), (0, 0, 0));
  var_06 = lib_0380::func_6846("zmb_blimp_engine_lp", var_01, var_05, var_04, var_03, var_04);
  var_06 = lib_0380::func_6846("zmb_blimp_engine_lfe_lp", var_01, var_05, var_04, var_03, var_04);
  var_00 thread aud_blimp_cleanup_on_death(var_05);
}

aud_blimp_cleanup_on_death(param_00) {
  self waittill("death");
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

aud_blimp_charge() {
  wait(0.75);
  maps\mp\_audio::func_8DA0("zmb_blimp_elec_turret_charge", self.var_116);
}

aud_blimp_projectile() {
  maps\mp\_audio::func_8DA0("zmb_blimp_elec_turret_shoot", self.var_116);
  wait(0.3);
  if(isDefined(self)) {
    maps\mp\_audio::func_8DA2("zmb_blimp_elec_turret_projectile", self);
  }
}

aud_blimp_hit_plr() {
  maps\mp\_audio::func_8DA2("zmb_blimp_elec_turret_hit_plr", self);
}

aud_blimp_turret_explode() {
  maps\mp\_audio::func_8DA0("zmb_blimp_elec_turret_explo", self.var_116);
  wait(1.2);
  if(isDefined(self)) {
    maps\mp\_audio::func_8DA2("zmb_blimp_elec_turret_fall", self);
  }
}

aud_blimp_battery_land(param_00) {
  maps\mp\_audio::func_8DA0("zmb_blimp_elec_turret_land", param_00.var_116);
}

aud_blimp_projectile_impact() {
  maps\mp\_audio::func_8DA0("zmb_blimp_elec_turret_impact", self.var_116);
}