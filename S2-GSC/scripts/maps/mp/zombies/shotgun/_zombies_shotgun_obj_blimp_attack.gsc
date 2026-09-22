/*********************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\shotgun\_zombies_shotgun_obj_blimp_attack.gsc
*********************************************************************************/

sg_init_obj_blimp_attack() {
  common_scripts\utility::flag_init("sky_rush");
  blimp_init();
  aud_blimp_attack_init();
  level._effect["zmb_zeppelin_shot"] = loadfx("vfx/zombie/zmb_zeppelin_shot");
  level._effect["zmb_zep_battery_fire_trail"] = loadfx("vfx/map/mp_zombie_nest/zmb_zep_battery_fire_trail");
  level._effect["zmb_zeppelin_shot_charge_weak_spot1"] = loadfx("vfx/zombie/prototype_fx/zmb_zeppelin_shot_charge_weak_spot1");
  level._effect["zmb_zeppelin_shot_charge_weak_spot2"] = loadfx("vfx/zombie/prototype_fx/zmb_zeppelin_shot_charge_weak_spot2");
  level._effect["zmb_zeppelin_shot_charge_weak_spot3"] = loadfx("vfx/zombie/prototype_fx/zmb_zeppelin_shot_charge_weak_spot3");
  level._effect["zmb_zeppelin_spotlight"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zeppelin_spotlight");
  level._effect["zmb_zeppelin_battery_explosion"] = loadfx("vfx/explosion/zmb_zeppelin_battery_explosion");
  level._effect["zmb_zeppelin_projectile"] = loadfx("vfx/trail/zmb_zeppelin_projectile");
  level._effect["temp_klaus_radius"] = loadfx("vfx/zombie/prototype_fx/temp_klaus_radius");
  level._effect["zmb_geistkraft_radius_400"] = loadfx("vfx/map/mp_zombie_nest/zmb_geistkraft_radius_400");
  level._effect["zmb_zeppelin_battery_hide_explosion"] = loadfx("vfx/explosion/zmb_zeppelin_battery_hide_explosion");
  level._effect["gk_raven_hc_ee_uber_stg_1"] = loadfx("vfx/zombie/abilities_perks/zmb_gk_uber_charge_stg_1");
  level._effect["gk_raven_hc_ee_uber_stg_2"] = loadfx("vfx/zombie/abilities_perks/zmb_gk_uber_charge_stg_2");
  level._effect["gk_raven_hc_ee_uber_stg_3"] = loadfx("vfx/zombie/abilities_perks/zmb_gk_uber_charge_stg_3");
  level._effect["zmb_zeppelin_battery_damage"] = loadfx("vfx/zombie/prototype_fx/zmb_zeppelin_battery_damage");
  level._effect["zmb_zep_rocket_smoketrail"] = loadfx("vfx/trail/zmb_zep_rocket_smoketrail");
  level._effect["zmb_zeppelin_spotlight_nolight"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zeppelin_spotlight_nolight");
  level._effect["zmb_zeppelin_shot_charge_barrel"] = loadfx("vfx/map/mp_zombie_nest/zmb_zeppelin_shot_charge_barrel");
  level._effect["zmb_zeppelin_shot_charge"] = loadfx("vfx/map/mp_zombie_nest/zmb_zeppelin_shot_charge");
  level._effect["zmb_zeppelin_shot_explosion"] = loadfx("vfx/explosion/zmb_zeppelin_shot_explosion");
  level._effect["zmb_zep_battery_land_explosion"] = loadfx("vfx/explosion/zmb_zep_battery_land_explosion");
  level._effect["zmb_zeppelin_gun_flash_wv"] = loadfx("vfx/muzzleflash/zmb_zeppelin_gun_flash_wv");
  level._effect["zmb_zeppelin_gun_light"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zeppelin_gun_light");
  level._effect["zmb_zeppelin_underlight"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zeppelin_underlight");
  level._effect["zmb_zeppelin_spotlight_assault"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zeppelin_spotlight_assault");
  level._effect["zmb_zeppelin_lightning_bolt"] = loadfx("vfx/map/mp_zombie_nest/zmb_zeppelin_lightning_bolt");
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
  level._id_179A = _getEnt("obj_blimp", "targetname");
  level._id_179A._id_9255 = level._id_179A.origin;
  level._id_179A._id_9189 = level._id_179A.angles;
  level._id_179A ghost();
  level._id_179A blimp_attach_weakpoints("blimp_door_damage_trigger");
  level._id_179A blimp_attach_turret("blimp_main_gun", "turretweapon_zeppelin_gun_zm");
  level._id_179A blimp_attach_battery("blimp_battery");
  level._id_179A blimp_attach_rockets("blimp_rocket_barrage_struct");
  level._id_179A.battery ghost();
  common_scripts\utility::_id_2CB4(5, ::battery_init_drop_points);
}

run_blimp_attack(var_0) {
  if(int(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("zmf_zepplin_pauses_zombie_waves"))) {
    maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
  }

  if(!isDefined(level._id_179A)) {
    return;
  }
  if(common_scripts\utility::_id_562E(level.sg_blimp_is_in_play)) {
    return;
  } else {
    level.sg_blimp_is_in_play = 1;
  }

  var_1 = common_scripts\utility::_id_46B7("zmb_blimp_pieces_struct", "targetname");

  foreach(var_3 in var_1) {
    var_3._id_57F7 = 0;
  }

  level._id_179A blimp_show_hidden_parts();
  level._id_179A blimp_play_anims_and_fx();
  level._id_179A thread turret_zap_players();
  level._id_179A thread rocket_shoot_players();
  level._id_179A thread weakpoint_cycle();
  level._id_179A thread blimp_run_behavior();

  foreach(var_6 in level.players) {
    var_6 setclientomnvar("ui_onevone_class_3", level.blimp_weak_points_count);
    var_6 setclientomnvar("ui_onevone_class_4", 0);
  }

  level._id_179A _id_0378::_id_8D74("aud_blimp_start");
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_rideau_global::run_rideau_zeppelin_comment();
  level._id_179A blimp_set_new_obj();
  var_8 = level common_scripts\utility::waittill_any_return("blimp_all_weakpoints_destroyed", "sg_obj_timeout", "sg_obj_force_end");
  level._id_179A blimp_set_leaving();
  level thread blimp_cleanup_once_left();
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();

  if(var_8 == "blimp_all_weakpoints_destroyed") {
    return 1;
  } else {
    return 0;
  }
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
    var_0 = blimp_wait_for_new_behavior_request();

    switch (var_0) {
      case "blimp_new_objective":
        blimp_set_first_assault();
        blimp_set_all_attacks_enabled();
        common_scripts\utility::flag_set("sky_rush");
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
  var_0 = 0;
  var_1 = 0;
  var_2 = 4;

  for(;;) {
    while(_id_0547::_id_585E()) {
      waitframe();
    }

    var_0 = common_scripts\utility::_id_98E7(var_0 + 1 > var_2, 1, var_0 + 1);
    var_1 = common_scripts\utility::_id_98E7(var_0 + 1 > var_2, 1, var_0 + 1);
    blimp_set_anim_state("s2_zmb_zeppelin_flightpath_idle_circle_0" + var_0);

    if(blimp_is_set_to_leave()) {
      blimp_retreat(var_1, 0);
    }
  }
}

blimp_reset(var_0) {
  if(common_scripts\utility::_id_562E(var_0)) {
    level.blimp_parts_destroyed = 0;
  }

  thread blimp_wait_for_all_weakpoints_destroyed();
  common_scripts\utility::flag_set("sky_rush");
  blimp_cancel_round_wait();
}

blimp_set_first_assault() {
  self._id_4B8B = 0;
  blimp_set_battery_count(3);
  self._id_5704 = 0;
  thread blimp_wait_for_all_weakpoints_destroyed();
}

blimp_set_state_leaving() {
  if(!isDefined(level._id_179A.battery._id_5DDA)) {
    blimp_set_battery_count(0);
  } else {
    blimp_set_battery_count(self.battery._id_5DDA - 1);
  }

  self._id_5704 = 1;
}

blimp_is_set_to_leave() {
  return common_scripts\utility::_id_562E(self._id_5704);
}

blimp_set_state_returning() {
  blimp_reset();
  self._id_5704 = 0;
}

blimp_set_all_attacks_disabled() {
  blimp_set_can_zap_players(0);
  blimp_set_can_rocket_players(0);
}

blimp_set_all_attacks_enabled() {
  _id_7EB8();
  blimp_set_can_zap_players(1);
  blimp_set_can_rocket_players(1);
}

blimp_set_can_zap_players(var_0) {
  self._id_1F8D = var_0;
}

blimp_set_can_rocket_players(var_0) {
  self._id_1F1F = var_0;
}

blimp_attach_weakpoints(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_3._id_65D8 = _getEnt(var_3.target, "targetname");
    var_4 = common_scripts\utility::_id_46B5(var_3._id_65D8.target, "targetname");
    var_5 = spawn("script_model", var_4.origin);
    var_5 setModel("tag_origin");
    var_3._id_65D9 = var_5;
  }

  foreach(var_8 in var_1) {
    var_8 enablelinkTo();
    var_8 linktosynchronizedparent(self);
    var_8._id_65D8 linktosynchronizedparent(self);
    var_8._id_65D9 linktosynchronizedparent(self);
    var_8._id_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_closed_idle");
    var_8._id_65D8 ghost();
  }

  self.blimp_weak_points = var_1;
  level.blimp_weak_points_count = self.blimp_weak_points.size;
}

blimp_attach_rockets(var_0) {
  var_1 = common_scripts\utility::_id_46B5(var_0, "targetname");
  var_2 = getEntArray(var_1.target, "targetname");

  foreach(var_4 in var_2) {
    var_4 linktosynchronizedparent(self);
    var_4 thread rocket_handle_damage();
    var_4 ghost();
  }

  self.rocket_bays = var_2;
}

blimp_attach_turret(var_0, var_1) {
  var_2 = common_scripts\utility::_id_46B5(var_0, "targetname");
  self.blimp_turret = var_2 turret_build(var_1, var_2._id_0165, ::turret_modify_player_damage, ::turret_on_player_damage);
  self.blimp_turret linktosynchronizedparent(self);
  self.blimp_turret ghost();
}

blimp_attach_battery(var_0) {
  self.battery = _getEnt(var_0, "targetname");
  self.battery linktosynchronizedparent(self);
}

blimp_set_battery_count(var_0) {
  self.battery._id_5DDA = var_0;
}

blimp_execute_leave(var_0) {
  blimp_set_anim_state("s2_zmb_zeppelin_flight_exit_0" + var_0);
  level notify("blimp_finished_exit");
}

blimp_display_state(var_0) {}

blimp_retreat(var_0, var_1) {
  blimp_execute_leave(var_0);

  if(common_scripts\utility::_id_562E(var_1)) {
    var_2 = _getEnt("overcharge_trig", "targetname");
    var_3 = 0;

    if(isDefined(var_2)) {
      var_3 = var_2._id_17A9;
    }

    if(common_scripts\utility::_id_562E(level._id_1CBA)) {
      self waittill("cancel blimp wait");
    } else {
      blimp_wait_for_end_of_round(level._id_A980, var_2, var_3);
    }

    if(self.battery._id_5DDA > 0) {
      blimp_set_returning();
      blimp_set_anim_state("s2_zmb_zeppelin_flight_entrance_0" + var_0);
    } else {
      var_4 = "";

      while(var_4 != "blimp_new_objective") {
        self waittill("set_new_blimp_behavior", var_4);
      }

      blimp_set_anim_state("s2_zmb_zeppelin_flight_entrance_0" + var_0);
    }
  }
}

blimp_wait_for_new_behavior_request() {
  self waittill("set_new_blimp_behavior", var_0);
  return var_0;
}

blimp_insert_new_battery() {
  thread blimp_take_damage();
}

blimp_wait_for_all_weakpoints_destroyed() {
  var_0 = undefined;

  foreach(var_2 in self.blimp_weak_points) {
    var_2 childthread weakpoint_take_damage_and_report_death(self);
  }

  level.blimp_parts_destroyed = 0;

  while(level.blimp_parts_destroyed < self.blimp_weak_points.size) {
    self waittill("blimp_weakpoint_destroyed", var_0, var_2);
    thread set_zombies_active_for_seconds(15);
    playFX(level._effect["zmb_zeppelin_battery_explosion"], var_2.origin);
    level.blimp_parts_destroyed++;

    foreach(var_5 in level.players) {
      var_5 setclientomnvar("ui_onevone_class_4", level.blimp_parts_destroyed);
    }
  }

  level notify("blimp_all_weakpoints_destroyed");
}

set_zombies_active_for_seconds(var_0) {
  self endon("blimp_weakpoint_destroyed");
  level endon("blimp_all_weakpoints_destroyed");
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
  wait(var_0);

  if(int(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("zmf_zepplin_pauses_zombie_waves"))) {
    maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
  }
}

blimp_take_damage() {
  self notify("new_battery_primed");
  self endon("new_battery_primed");
  var_0 = undefined;

  foreach(var_2 in self.blimp_weak_points) {
    var_2 childthread weakpoint_take_damage_and_report_death(self);
  }

  self waittill("blimp_weakpoint_destroyed", var_0, var_2);
  playFX(level._effect["zmb_zeppelin_battery_explosion"], var_2.origin);

  if(!isDefined(level.blimp_parts_destroyed)) {
    level.blimp_parts_destroyed = 1;
  } else {
    level.blimp_parts_destroyed++;
  }

  if(level.blimp_parts_destroyed >= self.blimp_weak_points.size) {
    level notify("blimp_all_weakpoints_destroyed");
  }
}

blimp_tesla_damage_mod(var_0, var_1) {
  switch (var_0) {
    case "teslagun_zm":
      var_1 = 2000;
      break;
    case "teslagun_zm_blood":
      var_1 = 3000;
      break;
    case "teslagun_zm_death":
      var_1 = 3000;
      break;
    case "teslagun_zm_moon":
      var_1 = 3000;
      break;
    case "teslagun_zm_storm":
      var_1 = 3000;
      break;
    default:
      break;
  }

  return var_1;
}

blimp_wait_for_end_of_round(var_0, var_1, var_2) {
  level endon("blimp_destroyed");
  self endon("cancel blimp wait");

  if(isDefined(var_1)) {
    while(var_2 == var_1._id_17A9) {
      wait 0.1;
    }
  }

  while(level._id_A980 <= var_0) {
    wait 0.1;
  }
}

blimp_show_hidden_parts() {
  self show();
  self.battery show();
  self.blimp_turret show();

  foreach(var_1 in self.blimp_weak_points) {
    var_1._id_65D8 show();
  }

  foreach(var_4 in self.rocket_bays) {
    var_4 show();
  }
}

blimp_get_num_parts_destroyed() {
  if(!isDefined(level.blimp_parts_destroyed)) {
    level.blimp_parts_destroyed = 0;
  }

  return level.blimp_parts_destroyed;
}

blimp_setup_ref_node() {
  var_0 = common_scripts\utility::_id_46B5("boss_zepplin_scripted_node", "targetname");
  self._id_7B8B = var_0;
  self._id_7B8B.angles = self._id_7B8B.angles - (0, 90, 0);
}

blimp_do_main_entrance() {
  level._id_179A._id_57A9 = 1;
  blimp_set_anim_state("s2_zmb_zeppelin_flightpath_main_entrance");
}

blimp_set_anim_state(var_0) {
  level._id_179A blimp_play_anim_and_wait(var_0);
}

blimp_play_anim_and_wait(var_0, var_1) {
  self scriptmodelclearanim();

  if(isDefined(var_1)) {
    self scriptmodelplayanimdeltamotionfrompos(var_0, var_1.origin, var_1.angles);
  } else {
    self scriptmodelplayanimdeltamotionfrompos(var_0, self._id_7B8B.origin, self._id_7B8B.angles);
  }

  blimp_wait_for_anim_finished(var_0);
}

blimp_wait_for_anim_finished(var_0) {
  var_1 = _getanimlength(blimp_string_to_anim(var_0));
  wait(var_1);
}

#using_animtree("animated_props_zombies");

blimp_string_to_anim(var_0) {
  var_1 = % s2_zmb_zeppelin_flightpath_main_entrance;

  switch (var_0) {
    case "s2_zmb_zeppelin_flightpath_main_entrance":
      var_1 = % s2_zmb_zeppelin_flightpath_main_entrance;
      break;
    case "s2_zmb_zeppelin_flight_entrance_01":
      var_1 = % s2_zmb_zeppelin_flight_entrance_01;
      break;
    case "s2_zmb_zeppelin_flight_entrance_02":
      var_1 = % s2_zmb_zeppelin_flight_entrance_02;
      break;
    case "s2_zmb_zeppelin_flight_entrance_03":
      var_1 = % s2_zmb_zeppelin_flight_entrance_03;
      break;
    case "s2_zmb_zeppelin_flight_entrance_04":
      var_1 = % s2_zmb_zeppelin_flight_entrance_04;
      break;
    case "s2_zmb_zeppelin_flight_exit_01":
      var_1 = % s2_zmb_zeppelin_flight_exit_01;
      break;
    case "s2_zmb_zeppelin_flight_exit_02":
      var_1 = % s2_zmb_zeppelin_flight_exit_02;
      break;
    case "s2_zmb_zeppelin_flight_exit_03":
      var_1 = % s2_zmb_zeppelin_flight_exit_03;
      break;
    case "s2_zmb_zeppelin_flight_exit_04":
      var_1 = % s2_zmb_zeppelin_flight_exit_04;
      break;
    case "s2_zmb_zeppelin_flightpath_idle_circle_01":
      var_1 = % s2_zmb_zeppelin_flightpath_idle_circle_01;
      break;
    case "s2_zmb_zeppelin_flightpath_idle_circle_02":
      var_1 = % s2_zmb_zeppelin_flightpath_idle_circle_02;
      break;
    case "s2_zmb_zeppelin_flightpath_idle_circle_03":
      var_1 = % s2_zmb_zeppelin_flightpath_idle_circle_03;
      break;
    case "s2_zmb_zeppelin_flightpath_idle_circle_04":
      var_1 = % s2_zmb_zeppelin_flightpath_idle_circle_04;
      break;
  }

  return var_1;
}

blimp_cancel_round_wait() {
  level._id_179A notify("cancel blimp wait");
}

blimp_play_anims_and_fx() {
  if(common_scripts\utility::_id_562E(self._id_3F78)) {
    return;
  }
  self._id_3F78 = 1;
  self scriptmodelplayanim("s2_zmb_zeppelin_idle");
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_gun_light"), level._id_179A.blimp_turret, "TAG_YAW");
  _triggerfx(var_0);
  thread blimp_delete_fx_on_death(var_0);
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_underlight"), self, "TAG_ORIGIN");
  _triggerfx(var_0);
  thread blimp_delete_fx_on_death(var_0);
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_A_LE_2");
  _triggerfx(var_0);
  thread blimp_delete_fx_on_death(var_0);
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_spotlight"), self, "J_searchlight_B_LE_2");
  _triggerfx(var_0);
  thread blimp_delete_fx_on_death(var_0);
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_C_LE_2");
  _triggerfx(var_0);
  thread blimp_delete_fx_on_death(var_0);
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_A_RI_2");
  _triggerfx(var_0);
  thread blimp_delete_fx_on_death(var_0);
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_spotlight"), self, "J_searchlight_B_RI_2");
  _triggerfx(var_0);
  thread blimp_delete_fx_on_death(var_0);
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_C_RI_2");
  _triggerfx(var_0);
  thread blimp_delete_fx_on_death(var_0);
}

blimp_delete_fx_on_death(var_0) {
  var_0 endon("death");
  self waittill("death");
  var_0 delete();
}

blimp_destroy() {
  level notify("blimp_destroyed");
  level.sg_blimp_is_in_play = 0;

  if(isDefined(level._id_179A)) {
    level._id_179A.blimp_turret delete();
    level._id_179A.battery delete();

    foreach(var_1 in level._id_179A.blimp_weak_points) {
      var_1 delete();
      var_1._id_65D8 delete();
    }

    foreach(var_4 in level._id_179A.rocket_bays) {
      var_4 delete();
    }

    level._id_179A delete();
  }
}

weakpoint_take_damage_and_report_death(var_0) {
  level endon("blimp_destroyed");
  var_0 endon("blimp_all_weakpoints_destroyed");
  self._id_A996 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("zepplin_weakpoint_health");
  var_1 = 2625.0;
  var_2 = 1750.0;
  var_3 = 875.0;
  var_4 = [var_1, var_2, var_3];
  self._id_4C13 = 0;
  var_5 = undefined;

  while(self._id_A996 > 0) {
    self waittill("damage", var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);

    if(common_scripts\utility::_id_562E(self.is_weakpoint_covered)) {
      continue;
    }
    var_6 = blimp_tesla_damage_mod(var_15, var_6);
    self._id_A996 = self._id_A996 - var_6;

    if(self._id_A996 < 0) {
      self._id_A996 = 0;
    }

    for(var_16 = 0; self._id_4C13 < 2 && self._id_A996 < var_4[self._id_4C13]; self._id_4C13++) {
      var_16 = 1;
    }

    if(var_16) {
      weakpoint_display_damage_status_fx();
    }

    if(randomint(100) < 30) {
      playFX(level._effect["zmb_zeppelin_battery_damage"], self.origin);
    }

    var_7 _id_04C7::_id_A102("standard");
    var_5 = var_7;
  }

  weakpoint_clear_fx();
  var_0 notify("blimp_weakpoint_destroyed", var_5, self);
}

weakpoint_open_doors(var_0, var_1) {
  var_2 = [];
  var_2["zom_zeppelin_panels_01_open"] = % zom_zeppelin_panels_01_open;
  var_2["zom_zeppelin_panels_01_open_idle"] = % zom_zeppelin_panels_01_open_idle;

  if(isDefined(var_0)) {
    var_3 = var_0;
  } else {
    var_3 = self.blimp_weak_points;
  }

  foreach(var_5 in var_3) {
    var_5._id_65D8 scriptmodelclearanim();
  }

  foreach(var_5 in var_3) {
    var_5._id_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_open");
  }

  wait(_getanimlength(var_2["zom_zeppelin_panels_01_open"]));

  if(common_scripts\utility::_id_562E(var_1)) {
    return;
  }
  foreach(var_5 in var_3) {
    var_5._id_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_open_idle");
    var_5._id_65D8 show();
    var_5.is_weakpoint_covered = 0;
    var_5 thread weakpoint_display_damage_status_fx();
  }
}

weakpoint_close_doors(var_0) {
  var_1 = [];
  var_1["zom_zeppelin_panels_01_close"] = % zom_zeppelin_panels_01_close;
  var_1["zom_zeppelin_panels_01_closed_idle"] = % zom_zeppelin_panels_01_closed_idle;

  if(isDefined(var_0)) {
    var_2 = var_0;
  } else {
    var_2 = self.blimp_weak_points;
  }

  foreach(var_4 in var_2) {
    var_4._id_65D8 scriptmodelclearanim();
  }

  foreach(var_4 in var_2) {
    var_4._id_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_close");
  }

  wait(_getanimlength(var_1["zom_zeppelin_panels_01_close"]));

  foreach(var_4 in var_2) {
    var_4._id_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_closed_idle");
  }
}

weakpoint_reveal(var_0) {
  self notify("door_anim_change");
  self endon("door_anim_change");
  var_1 = [];
  var_2 = self.blimp_weak_points;

  foreach(var_4 in self.blimp_weak_points) {
    if(common_scripts\utility::_id_562E(var_0)) {
      break;
    }

    if(isDefined(var_4._id_A996) && var_4._id_A996 <= 0) {
      var_2 = common_scripts\utility::_id_0F93(var_2, var_4);
    }
  }

  for(var_6 = 0; var_6 < 4; var_6++) {
    var_7 = common_scripts\utility::random(var_2);
    var_2 = common_scripts\utility::_id_0F93(var_2, var_7);
    var_1 = common_scripts\utility::_id_0F6F(var_1, var_7);
  }

  var_1 = common_scripts\utility::_id_0F97(var_1);
  weakpoint_open_doors(var_1, var_0);
  return var_1;
}

weakpoint_hide(var_0) {
  var_1 = self;
  var_1 notify("door_anim_change");
  var_1 endon("door_anim_change");

  foreach(var_3 in var_1.blimp_weak_points) {
    var_3.is_weakpoint_covered = 1;
    var_3 weakpoint_clear_fx();
  }

  var_1 weakpoint_close_doors(var_0);
}

weakpoint_display_damage_status_fx() {
  weakpoint_clear_fx();
  waitframe();

  if(!isDefined(self._id_4C13)) {
    self._id_4C13 = 0;
  }

  var_0 = "zmb_zeppelin_shot_charge_weak_spot" + (self._id_4C13 + 1);
  var_1 = common_scripts\utility::_id_44F5(var_0);
  self._id_3F44 = var_1;
  _playFXOnTag(var_1, self._id_65D8, "tag_origin");
}

weakpoint_clear_fx() {
  var_0 = self._id_3F44;

  if(!isDefined(var_0)) {
    return;
  }
  _stopFXOnTag(var_0, self._id_65D8, "tag_origin");
  self._id_3F44 = undefined;
}

weakpoint_cycle() {
  var_0 = self;
  level endon("blimp_destroyed");

  for(;;) {
    var_1 = var_0 weakpoint_reveal();
    var_0 wait_for_weakpoint_destroyed_or_timeout();

    if(level.blimp_parts_destroyed < 3) {
      var_0 weakpoint_hide(var_1);
    } else {
      var_0 weakpoint_reveal(1);
    }

    wait(_randomfloatrange(5, 10));
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
  var_0 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("blimp_attack_weapoint_reveal_time");

  if(var_0 == 0) {
    return;
  } else {
    wait(var_0);
  }

  self notify("weapoint_timeout");
}

turret_build(var_0, var_1, var_2, var_3) {
  var_4 = _spawnturret("misc_turret", self.origin, var_0);
  var_4.angles = self.angles;
  var_4 setModel(var_1);
  var_4 setdefaultdroppitch(0.0);
  var_4 setmode("auto_nonai");
  var_4 setsentryowner(undefined);
  var_4 setturretminimapvisible(0);
  var_4 maketurretsolid();
  var_4 makeunusable();
  var_4 setturretteam("axis");
  var_4 setentityowner(var_4);
  var_4 set_tool_hudelem(1);

  if(isDefined(var_2)) {
    var_4._id_62AD = var_2;
  }

  if(isDefined(var_3)) {
    var_4._id_6B73 = var_3;
  }

  return var_4;
}

turret_set_target(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0) && isPlayer(var_0)) {
    var_1 = (0, 0, 0);
  } else {
    var_1 = (0, 0, 0);
  }

  level._id_179A.blimp_turret settargetentity(var_0, var_1, 1);
}

turret_get_target() {
  return level._id_179A.blimp_turret _meth_80FC();
}

turret_clear_target() {
  level._id_179A.blimp_turret cleartargetentity();
}

turret_check_if_target(var_0) {
  var_1 = turret_get_target();
  return isDefined(var_1) && var_1 == var_0;
}

turret_start_firing() {
  level._id_179A.blimp_turret startfiring();
  level._id_179A.blimp_turret _id_0378::_id_8D74("aud_blimp_projectile");
}

turret_stop_firing() {
  level._id_179A.blimp_turret stopfiring();
}

turret_is_firing() {
  level._id_179A.blimp_turret isfiringturret();
}

turret_modify_player_damage(var_0) {
  if(!isPlayer(self)) {
    return var_0;
  }

  var_0 = self.maxhealth * 0.95;
  return var_0;
}

turret_on_player_damage(var_0) {
  var_1 = self;
  var_2 = _getweaponexplosionradius("turretweapon_zeppelin_gun_zm");
  var_3 = 1 - distance(var_0.origin, var_1.origin) / var_2;

  if(var_3 < 0) {
    var_3 = 0;
  }

  var_1 _id_0547::_id_7419(var_0.origin, var_3 * var_2 + 100);
  var_1 _id_0378::_id_8D74("aud_blimp_hit_plr");
}

turret_zap_players() {
  level endon("blimp_destroyed");
  level._id_17A4 = ["zone1_1_start", "zone1_2_gallows", "zone1_4_bridge", "zone1_4_bridge_tower", "zone1_3_riverside", "zone1_5_rooftops"];
  level._id_17A5 = [];

  for(var_0 = 0; var_0 < level._id_17A4.size; var_0++) {
    var_1 = getEntArray(level._id_17A4[var_0], "targetname");
    level._id_17A5 = common_scripts\utility::_id_0F73(level._id_17A5, var_1);
  }

  if(!isDefined(level._id_179A._id_982A)) {
    level._id_179A._id_982A = spawn("script_model", level._id_179A gettagorigin("J_searchlight_A_RI_2"));
    level._id_179A._id_982A setModel("tag_origin");
    level._id_179A._id_982A linktosynchronizedparent(level._id_179A);
  }

  for(;;) {
    wait 3;

    while(_id_0547::_id_585E()) {
      waitframe();
    }

    if(common_scripts\utility::_id_562E(level._id_179A._id_1F8D)) {
      var_2 = undefined;

      while(!isDefined(var_2) || !isalive(var_2)) {
        var_2 = common_scripts\utility::_id_4461(self.origin, level.players);
        wait 0.25;
      }

      turret_set_target(var_2);
      var_3 = level._id_179A.blimp_turret gettagorigin("TAG_PITCH");
      var_4 = spawn("script_model", var_3);
      var_4 setModel("Tag_Origin");
      var_4 linktosynchronizedparent(level._id_179A.blimp_turret);
      var_4 _id_0378::_id_8D74("aud_blimp_charge");
      var_5 = 0;

      while(isalive(var_2)) {
        var_6 = level._id_179A.blimp_turret gettagorigin("TAG_AIM");
        var_7 = level._id_179A.blimp_turret gettagangles("TAG_AIM");
        var_8 = anglesToForward(var_7);
        var_9 = vectorNormalize(var_2.origin - var_6);
        var_10 = vectordot(var_8, var_9);
        level._id_8C4C = level._id_179A.blimp_turret gettagorigin("TAG_AIM");
        var_11 = (var_2.angles[0], var_2.angles[1], var_2.angles[0]);
        var_12 = (128 + randomint(128)) * vectorNormalize(anglesToForward(var_11));
        level._id_8C46 = var_2.origin + var_12;
        level._id_8C4B = _spawnsighttrace(level._id_8C4C, level._id_8C4C, level._id_8C46, 0);
        var_13 = bulletTrace(level._id_179A.blimp_turret gettagorigin("TAG_AIM"), level._id_8C46, 0, level._id_179A.blimp_turret);
        var_14 = _abs(var_13["position"][2] - var_2.origin[2]);

        if(var_14 > 64) {
          level._id_8C46 = var_2.origin;
          level._id_8C4B = _spawnsighttrace(level._id_8C4C, level._id_8C4C, level._id_8C46, 0);

          if(level._id_8C4B >= 0.99 &var_10 >= 0.99) {
            break;
          }
        } else
          break;

        waitframe();
      }

      var_15 = turret_spawn_strike_point(level._id_8C46 + (0, 0, -12));
      var_13 = bulletTrace(level._id_179A.blimp_turret gettagorigin("TAG_AIM"), var_15.origin, 0, level._id_179A.blimp_turret);
      var_15.origin = var_13["position"];
      var_15.angles = vectortoangles(var_4.origin - var_15.origin);
      turret_set_target(var_15);
      _playFXOnTag(common_scripts\utility::_id_44F5("zmb_zeppelin_shot_charge"), level._id_179A.blimp_turret, "TAG_YAW");
      _playFXOnTag(common_scripts\utility::_id_44F5("zmb_zeppelin_shot_charge_barrel"), level._id_179A.blimp_turret, "TAG_AIM");
      var_16 = level._id_179A.blimp_turret gettagorigin("TAG_LIGHT");
      var_17 = level._id_179A.blimp_turret gettagangles("TAG_LIGHT");
      var_18 = spawn("script_model", var_16);
      var_18 setModel("tag_origin");
      var_18.angles = var_17;
      var_18 linktosynchronizedparent(level._id_179A.blimp_turret);
      _playFXOnTag(level._effect["zmb_zeppelin_spotlight_assault"], var_18, "tag_origin");
      _playFXOnTag(level._effect["zmb_zeppelin_shot"], var_15, "tag_origin");
      wait 1;
      _stopFXOnTag(level._effect["zmb_zeppelin_spotlight_assault"], var_18, "tag_origin");
      turret_start_firing();
      var_19 = _func_382("zmb_tesla_zep_beam", level._id_179A.blimp_turret, "tag_flash", var_15, "tag_origin");
      wait 1;
      turret_stop_firing();
      turret_clear_target();
      var_18 delete();
      var_4 delete();
      wait 0.15;
      var_19 delete();
      var_15 delete();
      continue;
    }

    wait 0.5;
  }
}

turret_spawn_strike_point(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("tag_origin");
  return var_1;
}

battery_init_drop_points() {
  var_0 = common_scripts\utility::_id_46B7("zmb_blimp_pieces_struct", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      switch (var_5._id_0165) {
        case "zmb_blimp_pieces_holder":
          var_2._id_4DEA = var_5;
          break;
        case "zmb_blimp_pieces_uber":
          var_2._id_9FE1 = var_5;
          break;
        case "zmb_blimp_pieces_rubble":
          var_2._id_7F40 = var_5;
          break;
        case "zmb_blimp_pieces_clip":
          var_2._id_241F = var_5;
          var_2._id_241F notsolid();
          var_2._id_241F connectpaths();
          var_2._id_241F ghost();
          break;
      }
    }
  }
}

battery_spawn(var_0) {
  var_1 = level._id_179A.blimp_turret battery_spawn_drop(var_0);
  var_2 = "zombie_battery_death_" + self.targetname + "_" + blimp_get_num_parts_destroyed();

  if(common_scripts\utility::_id_562E(level._id_1CBA)) {
    maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8606();
  }

  if(battery_should_collect_souls()) {
    _playFXOnTag(level._effect["zmb_geistkraft_radius_400"], var_1, "TAG_ORIGIN");
    var_3 = 20;
    thread battery_show_soul_collect_progress(var_1);
    var_1 maps\mp\mp_zombies_soul_collection::_id_170B(var_3, 400, 100, var_2, undefined, "tag_fx", "zmb_zep_receiver_charge_pnt", "tag_origin", undefined, var_1._id_34A5._id_7F41, (0, 0, 48));
    _stopFXOnTag(level._effect["zmb_geistkraft_radius_400"], var_1, "TAG_ORIGIN");
  }

  _id_0585::_id_8F7E(var_1.origin, undefined, undefined, undefined, undefined);
  var_1._id_9FE6 delete();
  var_1._id_34A5 battery_set_drop_point_inactive();
  playFX(loadfx("vfx/explosion/zmb_zeppelin_battery_hide_explosion"), var_1.origin);
  var_1 delete();
}

battery_show_soul_collect_progress(var_0) {
  var_1 = [7, 14, 20];
  var_2 = 0;
  var_3 = undefined;

  while(!isDefined(var_0._id_695B)) {
    waitframe();
  }

  for(;;) {
    while(isDefined(var_0) && isDefined(var_0._id_AC2C) && var_0._id_AC2C < var_1[var_2]) {
      level waittill(var_0._id_695B);
      waittillframeend;
    }

    if(var_2 == var_1.size - 1) {
      var_3 delete();
      break;
    }

    if(isDefined(var_3)) {
      var_3 delete();
      waitframe();
    }

    var_3 = _spawnfx(level._effect["gk_raven_hc_ee_uber_stg_" + (var_2 + 1)], var_0._id_9FE6.origin, anglesToForward(var_0._id_9FE6.angles), anglestoup(var_0._id_9FE6.angles));
    _triggerfx(var_3);
    var_2++;
  }
}

battery_should_collect_souls() {
  return 1;
}

battery_fall_onto_pos(var_0) {
  playsoundatpos(self.origin, "zmb_blimp_mortar_inc");
  var_1 = var_0 - self.origin;
  var_2 = _sqrt(_abs(var_1[2] * 2 / 800));
  var_3 = 1 / var_2;
  var_4 = var_1 * (var_3, var_3, 0);
  self movegravity(var_4, var_2);
  thread battery_rotate_to_motion();
  wait(var_2);
  self.origin = var_0;
  playFX(loadfx("vfx/explosion/zmb_zep_rocket_impact"), var_0);
  self notify("blimp_battery_detonate");
  playsoundatpos(var_0, "zmb_blimp_mortar_exp");
  _earthquake(0.55, 0.6, var_0, 200);
  waitframe();
  var_5 = _id_0547::_id_408F();
  var_6 = common_scripts\utility::_id_0F73(var_5, level.players);

  foreach(var_8 in var_6) {
    if(distance(var_0, var_8.origin) < 128) {
      if(isPlayer(var_8)) {
        var_8 setblurforplayer(3, 0.8);
      } else if(common_scripts\utility::_id_562E(var_8._id_A87C)) {
        continue;
      } else {
        var_8._id_A87C = 1;
      }

      if(isPlayer(var_8)) {
        var_8 dodamage(15, var_0, self, self, "MOD_EXPLOSIVE");
        continue;
      }

      var_8 dodamage(15, var_0, self, self, "MOD_RIFLE_BULLET");
    }
  }

  self delete();
}

battery_rotate_to_motion() {
  var_0 = self.origin;
  level endon("blimp_destroyed");
  self endon("blimp_battery_detonate");

  for(;;) {
    waitframe();
    var_1 = vectortoangles(var_0 - self.origin);
    self.angles = var_1;
    var_0 = self.origin;
  }
}

battery_spawn_drop(var_0, var_1) {
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("zmb_uberschnalle_battery_chunk_01");
  _playFXOnTag(level._effect["zmb_zep_battery_fire_trail"], var_2, "tag_origin");
  var_2 _id_0378::_id_8D74("aud_blimp_turret_explode");
  var_3 = common_scripts\utility::_id_46B7("zmb_blimp_pieces_struct", "targetname");
  var_4 = (0, 0, -800);
  var_5 = 4;

  if(isDefined(level._id_1CBF)) {
    var_6 = battery_get_closest_valid_drop_point(self.origin, level._id_1CBC);
  } else {
    var_6 = battery_get_closest_valid_drop_point(self.origin, var_3);
  }

  var_7 = var_6;
  var_8 = var_7._id_4DEA.origin - self.origin;
  var_5 = _sqrt(_abs(var_8[2] * 2 / 800));
  var_9 = 1 / var_5;
  var_10 = var_8 * (var_9, var_9, 0);
  var_2 movegravity(var_10, var_5);

  if(isDefined(var_7._id_4DEA.angles)) {
    var_2 rotateTo(var_7._id_4DEA.angles, var_5);
  }

  wait(var_5);

  if(!common_scripts\utility::_id_562E(var_1)) {
    var_7 battery_set_drop_point_active();
  }

  var_2.origin = var_7._id_4DEA.origin;
  var_2._id_9FE6 = spawn("script_model", var_7._id_9FE1.origin);
  var_2._id_9FE6 setModel("zmb_gp_uber_01");

  if(isDefined(var_7._id_9FE1.angles)) {
    var_2._id_9FE6.angles = var_7._id_9FE1.angles;
  }

  var_2._id_9FE6 linktosynchronizedparent(var_2);

  if(isDefined(level._id_1CBF)) {
    var_2.origin = var_2.origin + (0, 0, 4);
  }

  playFX(level._effect["zmb_zep_battery_land_explosion"], var_7._id_4DEA.origin + (0, 0, -20));
  _id_0378::_id_8D74("aud_blimp_battery_land", var_7._id_4DEA);
  var_2._id_34A5 = var_7;
  return var_2;
}

battery_get_closest_valid_drop_point(var_0, var_1) {
  for(;;) {
    if(var_1.size == 0) {
      return undefined;
    }

    var_2 = common_scripts\utility::_id_4461(var_0, var_1);

    if(!isDefined(var_2._id_57F7) || !var_2._id_57F7) {
      return var_2;
    } else {
      var_1 = common_scripts\utility::_id_0F93(var_1, var_2);
    }
  }
}

battery_set_drop_point_active() {
  var_0 = spawn("script_model", self._id_7F40.origin);

  if(isDefined(self._id_7F40.angles)) {
    var_0.angles = self._id_7F40.angles;
  }

  var_0 setModel("zmb_uberschnalle_battery_rubble_01");
  self._id_7F41 = var_0;
  self._id_241F solid();
  self._id_241F show();
  self._id_241F disconnectPaths();
  var_1 = common_scripts\utility::_id_0F73(level.players, _id_0547::_id_408F());

  foreach(var_3 in var_1) {
    if(_isagent(var_3)) {
      if(var_3._id_0A4B == "zombie_boss_village") {
        continue;
      }
    }

    if(var_3 istouching(self._id_241F)) {
      if(isPlayer(var_3)) {
        var_4 = self.origin;

        if(_canspawn(var_4)) {
          var_3 setOrigin(var_4);
        } else {
          var_5 = _func_2E1(var_4);

          if(_canspawn(var_5)) {
            var_3 setOrigin(var_5);
          } else {
            _id_0488::_id_A047(var_3, 0);
          }
        }

        var_3 dodamage(var_3.health + 666, self._id_7F40.origin, undefined, undefined, "MOD_CRUSH");
        continue;
      }

      var_3 dodamage(var_3.health + 666, self._id_7F40.origin, undefined, undefined, "MOD_EXPLOSIVE");
    }
  }

  self._id_57F7 = 1;
  thread battery_clip_exploit_listener();
}

battery_set_drop_point_inactive() {
  if(isDefined(self._id_7F41)) {
    self._id_7F41 delete();
  }

  self._id_241F connectpaths();
  self._id_241F notsolid();
  self._id_241F hide();
  self._id_57F7 = 0;
  self notify("stop_exploit_listener");
}

battery_clip_exploit_listener() {
  self endon("stop_exploit_listener");

  if(!isDefined(self._id_241F)) {
    return;
  }
  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = var_1 getgroundentity();

      if(isDefined(var_2) && var_2 == self._id_241F) {
        var_3 = self.origin;

        if(_canspawn(var_3)) {
          var_1 setOrigin(var_3);
        } else {
          var_4 = _func_2E1(var_3);

          if(_canspawn(var_4)) {
            var_1 setOrigin(var_4);
          } else {
            _id_0488::_id_A047(var_1, 0);
          }
        }

        var_1 dodamage(var_1.health + 666, self._id_7F40.origin, undefined, undefined, "MOD_CRUSH");
      }
    }

    wait 0.5;
  }
}

rocket_modify_damage(var_0, var_1, var_2, var_3) {
  var_3 = blimp_tesla_damage_mod(var_1, var_3);

  if(randomint(100) < 30) {
    playFX(level._effect["zmb_zeppelin_battery_damage"], self.origin);
  }

  var_4 = var_3;

  if(getdvarint("spv_zm_difficulty_enabled", 0) == 1) {
    var_4 = maps\mp\zombies\_zombies_progression::zombie_shotgun_mode_bonus_damage(var_0, var_4, var_1);
  }

  return var_4;
}

rocket_on_destroyed(var_0, var_1, var_2, var_3) {
  self notify("death", var_0, var_2, var_1);
  self._id_57B1 = 1;
  self ghost();
}

rocket_shoot_players() {
  level endon("blimp_destroyed");

  for(;;) {
    wait 5;
    var_0 = 0;
    var_1 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("blimp_attack_sizzlers_create");

    foreach(var_3 in _id_0547::_id_408F()) {
      var_4 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("blimp_attack_sizzlers_create_wave");

      if(level.objectivescompleted < var_4) {
        break;
      }

      if(var_3 maps\mp\zombies\sg_events_v1\extermination::try_to_become_a_sizzler()) {
        var_0++;
      }

      if(var_0 >= var_1) {
        break;
      }
    }

    while(_id_0547::_id_585E()) {
      waitframe();
    }

    if(common_scripts\utility::_id_562E(self._id_1F1F)) {
      if(!maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("blimp_attack_rockets_quickdraw")) {
        wait 8;
      }

      foreach(var_7 in self.rocket_bays) {
        if(common_scripts\utility::_id_562E(var_7._id_57B1)) {
          continue;
        }
        var_8 = 512;

        if(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("blimp_attack_rockets_focuses")) {
          var_8 = 8;
        }

        var_9 = common_scripts\utility::random(level.players);
        var_10 = _func_2E1(var_9.origin + (randomint(var_8) - var_8 / 2, randomint(var_8) - var_8 / 2, 0), var_9);
        var_11 = var_7.origin + var_7 rocket_get_pos_offset();
        var_12 = _bullettracepassed(var_11, var_10, 0, var_7);
        var_13 = _bullettracepassed(var_10, var_11, 0, var_7);

        if(!var_12 || !var_13 || common_scripts\utility::_id_562E(var_7._id_56EF)) {
          continue;
        }
        var_7 thread rocket_fire(var_9.origin);
        wait 0.25;
      }
    }
  }
}

rocket_get_pos_offset() {
  if(!isDefined(self) || !isDefined(self.angles)) {
    return (0, 0, 0);
  }

  return 64 * vectorNormalize(anglesToForward(self.angles)) + (0, 0, 16);
}

rocket_fire(var_0) {
  level endon("blimp_destroyed");
  self._id_56EF = 1;
  self scriptmodelclearanim();
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_open");
  wait(_getanimlength(%zmb_zeppelin_rocket_pod_open));
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_open_idle");
  var_1 = spawn("script_model", self.origin + rocket_get_pos_offset());
  var_1 setModel("npc_usa_bazooka_rocket_base");
  _playFXOnTag(level._effect["zmb_zep_rocket_smoketrail"], var_1, "tag_origin");
  var_1 thread battery_fall_onto_pos(var_0);
  wait 0.5;
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_close");
  wait(_getanimlength(%zmb_zeppelin_rocket_pod_close));
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_close_idle");
  self._id_56EF = 0;
}

_id_7EB8() {
  foreach(var_1 in self.rocket_bays) {
    var_1 notify("damage", 100000);
    var_1._id_57B1 = 0;
    var_1 show();
  }

  waitframe();

  foreach(var_1 in self.rocket_bays) {
    var_1 thread rocket_handle_damage();
  }
}

rocket_handle_damage() {
  var_0 = 1000;
  self.health = var_0;
  self._id_93FD = 0;
  self setCanDamage(1);
  self._id_57B1 = 0;
  thread maps\mp\gametypes\_damage::_id_8676(var_0, undefined, ::rocket_on_destroyed, ::rocket_modify_damage);
}

aud_blimp_attack_init() {
  _id_0378::_id_8DC7("aud_play_blimp_dialog", ::aud_play_blimp_dialog);
  _id_0378::_id_8DC7("aud_play_pa_dialog", ::aud_play_pa_dialog);
  _id_0378::_id_8DC7("aud_stop_pa_dialog", ::aud_stop_pa_dialog);
  _id_0378::_id_8DC7("aud_play_pa_music", ::aud_play_pa_music);
  _id_0378::_id_8DC7("aud_zombie_soul_suck", ::aud_zombie_soul_suck);
  _id_0378::_id_8DC7("aud_zombie_soul_suck_threshold", ::aud_zombie_soul_suck_threshold);
  _id_0378::_id_8DC7("aud_blimp_start", ::aud_blimp_start);
  _id_0378::_id_8DC7("aud_blimp_charge", ::aud_blimp_charge);
  _id_0378::_id_8DC7("aud_blimp_projectile", ::aud_blimp_projectile);
  _id_0378::_id_8DC7("aud_blimp_hit_plr", ::aud_blimp_hit_plr);
  _id_0378::_id_8DC7("aud_blimp_turret_explode", ::aud_blimp_turret_explode);
  _id_0378::_id_8DC7("aud_blimp_battery_land", ::aud_blimp_battery_land);
  _id_0378::_id_8DC7("aud_blimp_projectile_impact", ::aud_blimp_projectile_impact);
}

aud_play_blimp_dialog(var_0, var_1) {
  if(common_scripts\utility::_id_562E(level._id_943B._id_90C2)) {
    return;
  }
  _id_0380::_id_288D(var_0, undefined, var_1, 0, 1, 3.0);
}

aud_play_pa_dialog(var_0, var_1, var_2) {
  if(isDefined(var_2) && _isarray(var_2)) {
    foreach(var_4 in level.players) {
      var_4 thread aud_sndx_play_on_pa_system(var_0, var_2, "exterior");
    }
  }
}

aud_stop_pa_dialog() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_071D._id_6DDA)) {
      _id_0380::_id_6850(var_1._id_071D._id_6DDA, 0.25);
      var_1._id_071D._id_6DDA = undefined;
    }

    if(isDefined(var_1._id_071D._id_6DD9)) {
      _id_0380::_id_6850(var_1._id_071D._id_6DD9, 0.25);
      var_1._id_071D._id_6DD9 = undefined;
    }

    if(isDefined(var_1._id_071D._id_6DDB)) {
      foreach(var_3 in var_1._id_071D._id_6DDB) {
        _id_0380::_id_6850(var_3, 0.25);
      }

      var_1._id_071D._id_6DDB = [];
    }
  }
}

aud_sndx_play_on_pa_system(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = 0.3;
  var_5 = undefined;
  var_6 = 1.0;
  var_7 = 1;

  if(!isDefined(var_3._id_071D._id_6DD8)) {
    var_3._id_071D._id_6DDB = [];
  }

  wait(_randomintrange(1, 2));

  if(var_2 == "exterior") {
    var_5 = var_0 + "2";

    if(!_soundexists(var_5)) {
      var_5 = var_0 + "_2";

      if(!_soundexists(var_5)) {
        var_5 = undefined;
      }
    }
  }

  var_3._id_071D._id_6DD3 = [];

  for(var_8 = 0; var_8 < var_1.size; var_8++) {
    var_9 = var_1[var_8];
    var_10 = spawnStruct();
    var_10._id_90BE = var_9;
    var_10._id_3018 = distance(var_3.origin, var_9.origin);
    var_3._id_071D._id_6DD3[var_8] = var_10;
  }

  var_11 = common_scripts\utility::_id_7897(var_3._id_071D._id_6DD3, ::aud_play_pa_dialog_qsort_compare_func);

  if(isDefined(var_3._id_071D._id_6DDA)) {
    _id_0380::_id_6850(var_3._id_071D._id_6DDA, 0.25);
    var_3._id_071D._id_6DDA = undefined;
  }

  var_3._id_071D._id_6DDA = _id_0380::_id_6846(var_0, var_3, var_3, 0, 1);

  if(isDefined(var_3._id_071D._id_6DD9)) {
    _id_0380::_id_6850(var_3._id_071D._id_6DD9, 0.25);
    var_3._id_071D._id_6DD9 = undefined;
  }

  if(isDefined(var_5)) {
    var_3._id_071D._id_6DD9 = _id_0380::_id_6840(var_5, var_3, 0, 0.5);
  }

  foreach(var_13 in var_3._id_071D._id_6DDB) {
    _id_0380::_id_6850(var_13, 0.25);
  }

  var_3._id_071D._id_6DDB = [];
  var_15 = _min(var_7, var_1.size);

  for(var_8 = 0; var_8 < var_15; var_8++) {
    wait(var_4);
    var_9 = var_11[var_8]._id_90BE;
    var_6 = var_6 * 0.5;
    var_3._id_071D._id_6DDB[var_3._id_071D._id_6DDB.size] = _id_0380::_id_6842(var_0 + "_delay", var_3, var_9.origin, 0, var_6);
  }
}

aud_sndx_player_pa_monitor() {
  self endon("disconnect");
  var_0 = 0.5;
  var_1 = 1;
  var_2 = 1.0;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    self clientaddsoundsubmix("pa_inside", 1.0);
    wait(var_0);
  }
}

aud_play_pa_music(var_0) {
  var_1 = "zmb_wwii_march_music";

  if(!isDefined(var_0) || var_0.size <= 0) {
    return;
  }
  foreach(var_3 in level.players) {
    _id_0380::_id_2889(var_1, var_3, var_0[0].origin, 0, 1);
  }
}

aud_play_pa_dialog_qsort_compare_func(var_0, var_1) {
  return var_0._id_3018 <= var_1._id_3018;
}

aud_zombie_soul_suck(var_0, var_1) {
  var_2 = spawn("script_origin", var_0);
  _id_0380::_id_288B("zombie_soul_suck", undefined, var_2);
  var_2 moveTo(var_1, 1.9);
  wait 2;
  var_2 delete();
}

aud_zombie_soul_suck_threshold(var_0) {
  _id_0380::_id_2889("zombie_soul_suck_threshold", undefined, var_0);
}

aud_blimp_start() {
  var_0 = self;
  var_1 = undefined;
  var_2 = 2.0;
  var_3 = 1.0;
  var_4 = 5.0;
  wait 1;
  var_5 = spawn("script_origin", var_0.origin);
  var_5 linkTo(var_0, "tag_origin", (0, 0, -720), (0, 0, 0));
  var_6 = _id_0380::_id_6846("zmb_blimp_engine_lp", var_1, var_5, var_4, var_3, var_4);
  var_6 = _id_0380::_id_6846("zmb_blimp_engine_lfe_lp", var_1, var_5, var_4, var_3, var_4);
  var_0 thread aud_blimp_cleanup_on_death(var_5);
}

aud_blimp_cleanup_on_death(var_0) {
  self waittill("death");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

aud_blimp_charge() {
  wait 0.75;
  _id_046C::_id_8DA0("zmb_blimp_elec_turret_charge", self.origin);
}

aud_blimp_projectile() {
  _id_046C::_id_8DA0("zmb_blimp_elec_turret_shoot", self.origin);
  wait 0.3;

  if(isDefined(self)) {
    _id_046C::_id_8DA2("zmb_blimp_elec_turret_projectile", self);
  }
}

aud_blimp_hit_plr() {
  _id_046C::_id_8DA2("zmb_blimp_elec_turret_hit_plr", self);
}

aud_blimp_turret_explode() {
  _id_046C::_id_8DA0("zmb_blimp_elec_turret_explo", self.origin);
  wait 1.2;

  if(isDefined(self)) {
    _id_046C::_id_8DA2("zmb_blimp_elec_turret_fall", self);
  }
}

aud_blimp_battery_land(var_0) {
  _id_046C::_id_8DA0("zmb_blimp_elec_turret_land", var_0.origin);
}

aud_blimp_projectile_impact() {
  _id_046C::_id_8DA0("zmb_blimp_elec_turret_impact", self.origin);
}