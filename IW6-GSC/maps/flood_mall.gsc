/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_mall.gsc
*****************************************************/

section_

section_precache() {
  precachemodel("com_plastic_crate_pallet");
  precachemodel("street_trashcan_open_iw6");
  precachemodel("com_folding_chair");
  precachemodel("com_trashbin01");
  precachemodel("com_barrel_green");
  precachemodel("flood_crate_plastic_single02");
  precachemodel("com_cardboardboxshortclosed_1");
  precachemodel("com_pallet_2");
  precachemodel("ac_unit_1_lrg_scaled");
  precachemodel("ac_unit_2_box1");
  precachemodel("ac_unit_2_wide_scaled");
  precachemodel("com_plasticcase_beige_rifle");
  precachemodel("maintenance_box");
  precachemodel("com_plasticcase_beige_big_iw6");
  precachemodel("com_plasticcase_beige_big_iw6");
  precachemodel("flood_debris_small");
  precachemodel("pipe_metal_thick_straight_16_black");
  precachemodel("pipe_metal_thick_joint_90_medium_black");
  precachemodel("pipe_metal_thick_joint_2way_black");
  precachemodel("pipe_metal_thick_straight_64_black");
  precachemodel("debris_rubble_pile_02");
  precachemodel("flood_antenna_mobile_2");
  precachemodel("vehicle_civilian_sedan_gray_destroy_iw6");
  precachemodel("vehicle_civilian_sedan_red_destroy_iw6");
  precachemodel("vehicle_civilian_sedan_bronze_iw6");
  precachemodel("vehicle_city_car_blue");
  precachemodel("vehicle_city_car_silver");
  precachemodel("vehicle_city_car_red");
}

section_flag_inits() {
  level.player maps\_utility::ent_flag_init("player_in_swept");
  common_scripts\utility::flag_init("player_on_mall_roof");
  common_scripts\utility::flag_init("mall_attack_player");
  common_scripts\utility::flag_init("rocket_event");
  common_scripts\utility::flag_init("ally0_breach_ready");
  common_scripts\utility::flag_init("ally2_breach_ready");
  common_scripts\utility::flag_init("breach_door_open");
  common_scripts\utility::flag_init("event_quaker_big");
  common_scripts\utility::flag_init("mall_rooftop_heli_flyaway");
  common_scripts\utility::flag_init("mall_rooftop_sfx_fadeout");
  common_scripts\utility::flag_init("stair_post_quake_vo_done");
  common_scripts\utility::flag_init("mall_weapons_free");
  common_scripts\utility::flag_init("mall_player_falling");
}

mall_start() {
  maps\flood_util::player_move_to_checkpoint_start("mall_start");
  visionsetnaked("flood_warehouse", 0);
  maps\_utility::fog_set_changes("flood_warehouse", 0);
  level.cw_vision_above = "flood_warehouse";
  level.cw_fog_above = "flood_warehouse";
  maps\flood_util::spawn_allies();
  maps\flood_util::allies_move_to_checkpoint_start("mall", 1);
  common_scripts\utility::flag_set("stair_post_quake_vo_done");
  level.allies[0] thread ally0_mall();
  level.allies[1] thread ally1_mall();
  level.allies[2] thread ally2_mall();
  thread maps\flood_flooding::start_coverheight_water_rising(2, 1, "coverwater_warehouse");
  thread maps\flood_coverwater::register_coverwater_area("coverwater_warehouse", "swept_away");
  level.cw_player_in_rising_water = 0;
  level.cw_player_allowed_underwater_time = 1;
  thread mall_roof_door_firstframe();
  maps\flood_util::setup_default_weapons();
  thread maps\flood_flooding::enemy_spanish_vo();
  thread maps\flood_audio::sfx_flood_int_alarm_stop();
  thread maps\flood_streets::delete_ent_by_script_noteworthy("streets_helicopter_crash_location");
  thread maps\flood_fx::mall_light_cleanup();
  thread maps\flood_fx::warelights_off();
  thread maps\flood_fx::garage_malllight_off();
}

mall() {
  level thread maps\_utility::autosave_by_name("mall");
  common_scripts\utility::flag_clear("cw_player_no_speed_adj");
  thread maps\flood_audio::sfx_stop_stairwell_water();
  thread maps\flood_audio::sfx_mall_water();
  thread toggle_mall_door_clip("hide");
  thread watch_player();
  thread watch_goalvolume();
  thread enemy_setup_vign();
  thread enemy_twitch();
  thread mall_rootop_event();
  thread mall_rooftop_pickup_heli();
  thread mall_rooftop_flyby_helis();
  thread mall_attack_player_vo();
  thread trigger_player_mall_rooftop();
  thread maps\flood_fx::fx_mall_roof_water_show();
  thread maps\flood_fx::fx_mall_roof_amb_fx();
  thread maps\flood_fx::fx_mall_rooftop_debris();
  thread mall_door_temp_collision();
  level waittill("swept_away");
  thread maps\flood_util::kill_all_enemies();
  thread maps\flood_audio::sfx_stop_mall_water();
  var_0 = level.player getweaponslistprimaries();

  foreach(var_2 in var_0)
  level.player takeweapon(var_2);

  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
}

block_until_ground_collapse(var_0) {
  self endon("death");
  level endon("swept_away");
  var_1 = getent("mall_floor", "targetname");

  if(!isDefined(var_0))
    var_0 = 8;

  var_2 = undefined;
  var_3 = undefined;

  for(;;) {
    var_4 = bulletTrace(self.origin + (0, 0, 12), self.origin - (0, 0, 1024), 0, var_1);
    var_5 = bulletTrace(self.origin + (0, 6, 12), self.origin - (0, 6, 1024), 0, var_1);

    if(isDefined(var_4["entity"]) && isDefined(var_4["entity"].targetname)) {
      if(var_4["entity"].targetname == "flood_mallroof_center" || var_4["entity"].targetname == "flood_mallroof_back" || var_4["entity"].targetname == "acbox_obj")
        var_2 = 1;
      else
        var_2 = 0;
    } else
      var_2 = 0;

    if(isDefined(var_5["entity"]) && isDefined(var_5["entity"].targetname)) {
      if(var_5["entity"].targetname == "flood_mallroof_center" || var_5["entity"].targetname == "flood_mallroof_back" || var_5["entity"].targetname == "acbox_obj")
        var_3 = 1;
      else
        var_3 = 0;
    } else
      var_3 = 0;

    if(var_2) {
      if(isplayer(self)) {
        if(abs(self.origin[2] - var_4["position"][2]) > var_0 && self isonground()) {
          maps\flood_util::jkuprint("PLAYER FALLING! " + var_4["surfacetype"] + " " + (self.origin[2] - var_4["position"][2]));
          player_ground_collapse();
          break;
        }
      } else if(abs(self.origin[2] - var_4["position"][2]) > var_0) {
        maps\flood_util::jkuprint("AI FALLING! " + var_4["surfacetype"] + " " + (self.origin[2] - var_4["position"][2]));
        break;
      }
    } else if(var_3) {
      if(isplayer(self)) {
        if(abs(self.origin[2] - var_5["position"][2]) > var_0 && self isonground()) {
          maps\flood_util::jkuprint("PLAYER FALLING! " + var_5["surfacetype"] + " " + (self.origin[2] - var_5["position"][2]));
          player_ground_collapse();
          break;
        }
      } else if(abs(self.origin[2] - var_5["position"][2]) > var_0) {
        maps\flood_util::jkuprint("AI FALLING! " + var_5["surfacetype"] + " " + (self.origin[2] - var_5["position"][2]));
        break;
      }
    } else if(isplayer(self)) {
      player_ground_collapse();
      break;
    } else if(isai(self)) {
      break;
    }

    common_scripts\utility::waitframe();
  }
}

player_ground_collapse() {
  common_scripts\utility::flag_set("mall_rooftop_sfx_fadeout");
  level.swept_away = 1;
  earthquake(0.3, 1, level.player.origin, 1600);
}

watch_player() {
  level endon("swept_away");
  level endon("mall_attack_player");
  common_scripts\utility::flag_wait("breach_door_open");
  var_0 = 0;
  var_1 = randomfloatrange(10, 12.5);

  for(;;) {
    var_2 = undefined;
    var_3 = undefined;
    var_4 = getEntArray("grenade", "classname");

    foreach(var_6 in var_4) {
      if(getmissileowner(var_6) == level.player) {
        var_2 = 1;
        var_3 = var_6.model;
        break;
      }
    }

    if(isDefined(var_2) && var_2) {
      if(var_3 == "projectile_m67fraggrenade" || var_3 == "projectile_m84_flashbang_grenade")
        wait 0.75;

      break;
    } else if(level.player attackbuttonpressed()) {
      break;
    }

    common_scripts\utility::waitframe();
  }

  thread mall_attack_player();
}

watch_glass() {
  level endon("swept_away");
  level endon("mall_attack_player");
  common_scripts\utility::flag_wait("mall_breach_start");
  var_0 = getglassarray("mall_roof_glass");
  var_1 = 0;

  while(!var_1) {
    foreach(var_3 in var_0) {
      if(isglassdestroyed(var_3))
        var_1 = 1;
    }

    common_scripts\utility::waitframe();
  }

  thread mall_attack_player();
}

watch_player_pos() {
  if(common_scripts\utility::flag("mall_attack_player")) {
    return;
  }
  self endon("death");
  level endon("swept_away");
  level endon("mall_attack_player");
  common_scripts\utility::flag_wait("player_on_mall_roof");
  var_0 = 1;

  while(var_0) {
    var_1 = gettime();

    while(self cansee(level.player)) {
      if(gettime() - var_1 > 2000) {
        var_0 = 0;
        break;
      }

      common_scripts\utility::waitframe();
    }

    common_scripts\utility::waitframe();
  }

  self.spotter = 1;
  level.allies[0] thread maps\_utility::dialogue_queue("flood_bkr_spottedus");
  thread mall_attack_player();
}

watch_player_onroof_timer() {
  if(common_scripts\utility::flag("mall_attack_player")) {
    return;
  }
  level endon("swept_away");
  level endon("mall_attack_player");
  common_scripts\utility::flag_wait("player_on_mall_roof");
  wait 0.5;
  maps\_utility::radio_dialogue("flood_bkr_hotonrooksmark");
  wait 1;
  maps\_utility::radio_dialogue("flood_bkr_thejump");
  wait 3;
  maps\_utility::radio_dialogue("flood_bkr_cantwait");
  wait 0.5;
  common_scripts\utility::flag_set("mall_weapons_free");
  level.allies[0].ignoreall = 0;
  level.allies[1].ignoreall = 0;
  level.allies[2].ignoreall = 0;
  wait 2;
  thread mall_attack_player();
}

watch_goalvolume() {
  level endon("swept_away");
  level endon("roofcollapse_start");
  common_scripts\utility::flag_clear("enemies_use_left");
  common_scripts\utility::flag_clear("enemies_use_main");

  for(;;) {
    common_scripts\utility::flag_wait("enemies_use_left");
    common_scripts\utility::flag_clear("enemies_use_main");
    var_0 = maps\_utility::get_ai_group_ai("mall_ai");
    maps\flood_util::reassign_goal_volume(var_0, "mall_goalvolume_left");
    common_scripts\utility::flag_wait("enemies_use_main");
    common_scripts\utility::flag_clear("enemies_use_left");
    var_0 = maps\_utility::get_ai_group_ai("mall_ai");
    maps\flood_util::reassign_goal_volume(var_0, "mall_goalvolume_main");
  }
}

flood_spawner(var_0, var_1, var_2) {
  level endon("swept_away");
  level endon(var_0);
  var_3 = [];
  var_3[0] = getent("mall_ai_rocket_jumprail", "targetname");
  var_3[1] = getent("mall_ai_rocket_farbalc", "targetname");
  var_3[2] = getent("mall_ai_rocket_backwalkway", "targetname");
  var_3[3] = getent("mall_ai_walkway_a", "targetname");
  var_3[4] = getent("mall_ai_walkway_b", "targetname");

  for(;;) {
    var_4 = maps\_utility::get_living_ai_array("mall_ai", "script_noteworthy");

    if(var_4.size <= var_1) {
      if(common_scripts\utility::flag("enemies_use_main"))
        var_5 = var_3[randomint(var_3.size)];
      else
        var_5 = var_3[randomint(var_3.size - 2)];

      var_5 maps\_utility::remove_spawn_function(::mall_enemy_spawn_func);
      var_5 maps\_utility::add_spawn_function(::mall_enemy_spawn_func, var_2);
      var_5 maps\_utility::spawn_ai(1);
      wait 1;
    }

    common_scripts\utility::waitframe();
  }
}

weapon_make_fall() {
  self endon("death");
  common_scripts\utility::flag_wait("ally_area_falling");
  var_0 = spawn("script_model", self.origin);
  wait 0.1;
  var_0 thread event_gravity();
  self linkto(var_0);
  wait 1;
  self delete();
  var_0 delete();
}

mall_delete_warehouse_ents() {
  var_0 = getEntArray("mall_ware_brush_hide", "targetname");
  maps\_utility::array_delete(var_0);
  var_0 = getEntArray("mall_brush_hide", "targetname");
  maps\_utility::array_delete(var_0);
  var_0 = getEntArray("warevolumes", "targetname");
  maps\_utility::array_delete(var_0);
  var_0 = getEntArray("mall_ware_model_hide", "targetname");
  maps\_utility::array_delete(var_0);
  var_1 = getEntArray("warehouse_door_burst1", "targetname");
  maps\_utility::array_delete(var_1);
  var_1 = getEntArray("warehouse_door_burst2", "targetname");
  maps\_utility::array_delete(var_1);
  var_1 = getEntArray("warehouse_door_burst3", "targetname");
  maps\_utility::array_delete(var_1);
}

mall_delete_rooftop_ents() {
  var_0 = getEntArray("mall_cleanup", "targetname");
  maps\_utility::array_delete(var_0);
  var_0 = getEntArray("acbox_obj", "targetname");
  maps\_utility::array_delete(var_0);
  var_0 = getEntArray("mall_bokehdot", "targetname");
  maps\_utility::array_delete(var_0);
  var_0 = getEntArray("mall_cleanup", "script_noteworthy");
  maps\_utility::array_delete(var_0);
  var_0 = getEntArray("mall_ai", "script_noteworthy");
  maps\_utility::array_delete(var_0);
  var_1 = getEntArray("mall_rooftop_heli", "targetname");
  maps\_utility::array_delete(var_1);
  var_1 = getEntArray("mall_rooftop_heli_flyby1", "targetname");
  maps\_utility::array_delete(var_1);
  var_1 = getEntArray("mall_rooftop_heli_flyby2", "targetname");
  maps\_utility::array_delete(var_1);
  var_1 = getEntArray("mall_rooftop_heli_flyby3", "targetname");
  maps\_utility::array_delete(var_1);
}

mall_rootop_event() {
  level.player endon("death");
  level endon("swept_away");
  mallroof_firstframe();
  level.mallroof_struct thread maps\_anim::anim_loop_solo(level.mallroof_impact, "mallroof_idle", "stop_loop");
  var_0 = getent("warehouse_waters_retarget", "targetname");
  level.mallroof_acboxes thread maps\flood_util::spawn_and_link_models_to_tags("acbox_obj", var_0);
  level.mallroof_smallrubble thread maps\flood_util::spawn_and_link_models_to_tags("acbox_obj", var_0);
  mall_delete_warehouse_ents();
  common_scripts\utility::exploder("mr_dust_slight");
  var_1 = getEntArray("mall_ware_brush_show", "targetname");

  foreach(var_3 in var_1)
  var_3 show();

  common_scripts\utility::flag_wait("mall_attack_player");
  var_5 = getent("flood_mall_roof_opfor", "targetname");
  var_5.animname = "generic";
  var_5 thread maps\_utility::dialogue_queue("flood_vz2_americans");
  var_6 = getent("mall_ai_rocket_backwalkway", "targetname");
  var_6 maps\_utility::add_spawn_function(::mall_enemy_spawn_func, "mall_goalvolume_main", "mall_enemy_cover_close");
  var_6 maps\_utility::spawn_ai(1);
  var_6 = getent("mall_ai_rocket_farbalc", "targetname");
  var_6 maps\_utility::add_spawn_function(::mall_enemy_spawn_func, "mall_goalvolume_main", "mall_enemy_cover_balc");
  var_6 maps\_utility::spawn_ai(1);
  var_6 = getent("mall_ai_rocket_jumprail", "targetname");
  var_6 maps\_utility::add_spawn_function(::mall_enemy_spawn_func, "mall_goalvolume_main", "mall_enemy_cover_farplant");
  var_6 maps\_utility::spawn_ai(1);
  common_scripts\utility::flag_wait("player_on_mall_roof");
  thread flood_spawner("rocket_event", 4, "mall_goalvolume_main");
  var_7 = 8.0;
  wait(var_7);
  thread ally_roof_collapse_vo();
  common_scripts\utility::exploder("mall_roof_dust");
  var_8 = 5.0;
  wait(var_8);
  maps\_utility::stop_exploder("mr_dust_slight");
  common_scripts\utility::exploder("mall_roof_dust");
  common_scripts\utility::exploder("mr_dust_freguent");
  common_scripts\utility::exploder("mr_updust");
  wait 3;
  level notify("roofcollapse_start");
  common_scripts\utility::flag_set("rocket_event");
  var_9 = maps\_utility::get_ai_group_ai("mall_ai");

  foreach(var_11 in var_9) {
    var_11.ignoreall = 1;
    var_11 maps\_utility::set_ignoresuppression(1);
    var_11 thread ramp_down_accurracy(2, 0);
  }

  maps\flood_util::reassign_goal_volume(var_9, "mall_goalvolume_roofcollapse");

  foreach(var_11 in var_9)
  var_11 thread roofcollapse_retreat();

  thread flood_spawner("swept_away", 4, "mall_goalvolume_roofcollapse");
  common_scripts\utility::exploder("mr_updust");
  wait 3;
  level.mallroof_struct notify("stop_loop");
  level.mallroof_struct thread maps\_anim::anim_single(level.mallroof_array, "mallroof_collapse");
  thread maps\flood_audio::sfx_rooftop_collapse();
  thread event_quaker_collapse();
  common_scripts\utility::exploder("mall_roof_dust");
  common_scripts\utility::flag_wait("enemy_area_falling");
  var_15 = [];
  var_16 = level.scr_model[level.mallroof_far.animname];
  var_17 = getnumparts(var_16);

  for(var_18 = 0; var_18 < var_17; var_18++) {
    var_19 = getpartname(var_16, var_18);
    var_20 = getsubstr(var_19, 0, var_19.size - 3);

    if(var_20 == "tag_corpse") {
      var_15[var_15.size] = level.mallroof_far gettagorigin(var_19);
      continue;
    }

    var_15[var_15.size] = (99999, 99999, 99999);
  }

  var_21 = getcorpsearray();
  var_22 = getent("corpse_fall_volume", "targetname");
  var_23 = [];
  var_23[var_23.size] = "j_mainroot";
  var_23[var_23.size] = "j_neck";
  var_23[var_23.size] = "j_ankle_le";
  var_23[var_23.size] = "j_ankle_ri";

  foreach(var_25 in var_21) {
    var_26 = var_25 common_scripts\utility::spawn_tag_origin();

    if(var_26 istouching(var_22)) {
      var_27 = [];

      foreach(var_29 in var_23) {
        var_30 = maps\flood_util::bullet_trace_debug(var_25 gettagorigin(var_29) + (0, 0, 12), var_25 gettagorigin(var_29) - (0, 0, 60), 0, "white", 200, 0);

        if(isDefined(var_30["entity"]) && isDefined(var_30["entity"].targetname) && var_30["entity"].targetname == "flood_mallroof_far")
          var_27[var_27.size] = var_30["position"];
      }

      if(var_27.size > 0) {
        var_32 = [];

        foreach(var_34 in var_27)
        var_32[var_32.size] = maps\_utility::get_closest_point(var_34, var_15);

        var_36 = [];

        foreach(var_34 in var_27)
        var_36[var_36.size] = distance2d(var_34, var_32[var_36.size]);

        var_39 = var_36[0];
        var_40 = 0;

        for(var_18 = 0; var_18 < var_36.size; var_18++) {
          if(var_36[var_18] < var_39)
            var_40 = var_18;
        }

        var_25 linkto(level.mallroof_far, getpartname(var_16, common_scripts\utility::array_find(var_15, var_32[var_40])));
      }
    }

    var_26 delete();
  }

  common_scripts\utility::flag_wait("player_area_falling");
  thread maps\flood_swept::swept_water_toggle("swim", "show");
  thread ally_roof_collapsing_vo();
  thread player_disallow_jump();
  level.player disableweaponpickup();
  var_42 = getent("weapon_fall_volume", "targetname");
  var_43 = maps\_utility::getallweapons();

  foreach(var_45 in var_43) {
    if(var_45 istouching(var_42))
      var_45 thread weapon_make_fall();
  }

  maps\_utility::stop_exploder("mall_floating_debri_med");
  maps\_utility::delete_exploder("mall_floating_debri_med");
  level.player block_until_ground_collapse();
  var_47 = getEntArray("grenade", "classname");

  foreach(var_49 in var_47)
  var_49 delete();

  level.player enableinvulnerability();
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  level.player hideviewmodel();
  maps\_utility::slowmo_start();
  maps\_utility::slowmo_setspeed_slow(0.5);
  maps\_utility::slowmo_setlerptime_in(0.1);
  maps\_utility::slowmo_lerp_in();
  var_51 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_51.angles = level.player.angles;
  thread smooth_player_link(var_51, 0.25);
  level.player thread maps\_anim::anim_single_solo(var_51, "mall_roofcollapse_player01");
  common_scripts\utility::flag_set("mall_player_falling");
  level.flood_mall_weapon_model = level.player maps\flood_util::create_world_model_from_ent_weapon();
  level.flood_mall_weapon_model.origin = var_51 gettagorigin("tag_weapon");
  level.flood_mall_weapon_model.angles = var_51 gettagangles("tag_weapon");
  level.flood_mall_weapon_model linkto(var_51, "tag_weapon");

  for(;;) {
    var_52 = bulletTrace(level.player.origin + (0, 0, 52), level.player.origin + (0, 0, 100), 0, self);

    if(var_52["surfacetype"] == "water") {
      thread maps\flood_swept::swept_underwater();
      break;
    }

    common_scripts\utility::waitframe();
  }

  level.player notify("noHealthOverlay");
  level.cover_warnings_disabled = 1;
  thread maps\flood_audio::swept_away_scene("beginning");
  maps\_utility::slowmo_setlerptime_out(0.5);
  maps\_utility::slowmo_lerp_out();
  maps\_utility::slowmo_end();
  level.player unlink();
  var_51 delete();
  level.player freezecontrols(0);
  thread maps\flood_audio::kill_sfx_dam_sirens();
  level notify("swept_away");
}

ramp_down_accurracy(var_0, var_1) {
  self endon("death");
  var_0 = var_0 * 1000;
  var_2 = var_0 / 50;
  var_3 = self.baseaccuracy / var_2;

  for(var_4 = 0; var_4 < var_2; var_4++) {
    self.baseaccuracy = self.baseaccuracy - var_3;
    common_scripts\utility::waitframe();
  }

  self.baseaccuracy = var_1;
}

corpse_ragdoll_when_vertical() {
  self endon("death");
  level endon("swept_away");

  if(isalive(self)) {
    var_0 = self gettagangles("tag_origin");

    while(abs(var_0[2]) < 35 && isalive(self)) {
      var_0 = self gettagangles("tag_origin");
      common_scripts\utility::waitframe();
    }
  }

  maps\flood_util::jkuprint("vertical");
  self unlink();
  var_1 = common_scripts\utility::spawn_tag_origin();
  self linkto(var_1);
  var_1 movegravity((0, 0, -100), 3);
  wait 3;
  var_1 delete();
}

player_disallow_jump() {
  level.player allowjump(0);
}

smooth_player_link(var_0, var_1) {
  level.player setstance("stand");
  level.player playerlinktoblend(var_0, "tag_player", var_1);
  wait(var_1);
  level.player playerlinktodelta(var_0, "tag_player", 1, 15, 15, 15, 15, 1);
}

mall_rooftop_flyby_helis() {
  var_0 = getent("player_mall_rooftop", "targetname");
  var_0 waittill("trigger");
  thread mall_rooftop_flyby_heli1();
  thread mall_rooftop_flyby_heli2();
  thread mall_rooftop_flyby_heli3();
}

mall_rooftop_flyby_heli1() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("mall_rooftop_heli_flyby1");
  var_0 endon("deathspin");
  var_0 vehicle_turnengineoff();
  thread maps\flood_audio::sfx_chopper_4_play(var_0);
  var_0 sethoverparams(10, 10, 20);
  var_0 setmaxpitchroll(30, 30);
  var_0 vehicle_setspeed(30, 10, 10);
  var_1 = common_scripts\utility::getstruct("mall_rooftop_heli_flyby1_hover", "targetname");

  while(distancesquared(var_1.origin, var_0.origin) > 400000)
    wait 0.05;

  var_0 thread maps\_utility::vehicle_detachfrompath();
  var_2 = common_scripts\utility::getstruct("mall_rooftop_heli_flyby1_flyaway", "targetname");
  var_0 setvehgoalpos(var_2.origin, 1);
  var_0 vehicle_setspeed(20);
  wait 8.0;
  var_0 thread maps\_vehicle::vehicle_paths(var_2);
  level waittill("swept_away");

  if(isDefined(var_0))
    var_0 delete();
}

mall_rooftop_flyby_heli2() {
  wait 15.0;
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("mall_rooftop_heli_flyby2");
  var_0 endon("deathspin");
  var_0 vehicle_turnengineoff();
  thread maps\flood_audio::sfx_chooper_wait_and_play(var_0);
  var_0 setmaxpitchroll(30, 30);
  level waittill("swept_away");

  if(isDefined(var_0))
    var_0 delete();
}

mall_rooftop_flyby_heli3() {
  wait 25.0;
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("mall_rooftop_heli_flyby3");
  var_0 setmaxpitchroll(30, 30);
  level waittill("swept_away");

  if(isDefined(var_0))
    var_0 delete();
}

mall_rooftop_pickup_heli() {
  common_scripts\utility::flag_wait("mall_attack_player");
  wait 6.0;
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("mall_rooftop_heli");
  var_0 vehicle_turnengineoff();
  thread maps\flood_audio::sfx_play_chopper_5(var_0);
  var_1 = getent("mall_roof_helicopter_crash_location", "targetname");
  var_0.perferred_crash_location = var_1;
  var_0 setmaxpitchroll(30, 60);
  var_0 setyawspeedbyname("slow");
  var_0 sethoverparams(50, 10, 20);
  var_0.path_gobbler = 1;
  var_0 endon("death");
  var_2 = common_scripts\utility::getstruct("mall_rooftop_heli_hover", "targetname");

  while(distancesquared(var_2.origin, var_0.origin) > 4000)
    wait 0.05;

  var_3 = spawn("script_model", (2176, -6784, 672));
  var_0 setlookatent(var_3);
  common_scripts\utility::flag_set("mall_rooftop_heli_flyaway");
  var_0 thread maps\_utility::vehicle_detachfrompath();
  var_4 = common_scripts\utility::getstruct("mall_rooftop_heli_flyaway", "targetname");
  var_0 vehicle_setspeed(2);
  var_0 setvehgoalpos(var_4.origin, 1);
  common_scripts\utility::flag_wait("rocket_event");
  wait 7.0;
  var_0.script_vehicle_selfremove = 1;
  var_0 clearlookatent();
  var_0 thread maps\_vehicle::vehicle_paths(var_4);
  wait 2.0;
  var_0 setyawspeed(100, 15);
}

mall_rooftop_heli_damage_watcher() {
  self endon("death");
  var_0 = 0;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(var_2 == level.player)
      var_0++;

    if(var_0 > 15) {
      if(!common_scripts\utility::flag("mall_rooftop_heli_flyaway")) {
        thread maps\_utility::vehicle_detachfrompath();
        var_11 = common_scripts\utility::getstruct("mall_rooftop_heli_hover", "targetname");
        self vehicle_setspeed(2);
        self setvehgoalpos(var_11.origin, 1);
      }

      wait 2.5;
      thread maps\flood_audio::sfx_kill_chopper_sound();
      self kill();
      break;
    }
  }
}

event_quaker_big(var_0) {
  common_scripts\utility::flag_set("event_quaker_big");
  level thread post_quake_vo();
  level.player playSound("scn_flood_mall_rumble_shake_int_lg");
  wait 1.893;
  earthquake(0.5, 1.5, level.player.origin, 1600);
  level.player playrumbleonentity("light_1s");
  common_scripts\utility::exploder("stairwell_dust");
  thread maps\flood_fx::light_flicker("mall_flicker_light");
  wait 2.0;
  thread event_quaker_indoor();
}

post_quake_vo() {
  level.player endon("death");
  level.allies[0] endon("death");
  level.allies[2] endon("death");
  wait 2.9;
  level.allies[2] maps\_utility::dialogue_queue("flood_bkr_thisplaceisntgonna");
  wait 4.8;
  level.allies[0] maps\_utility::dialogue_queue("flood_vrg_allrightletsgo");
  common_scripts\utility::flag_set("stair_post_quake_vo_done");
}

event_quaker_indoor() {
  level endon("swept_away");
  level endon("player_on_mall_roof");

  for(;;) {
    level.player playSound("scn_flood_mall_rumble_shake_int");
    thread maps\flood_audio::sfx_mall_ceiling_debris();
    earthquake(randomfloatrange(0.05, 0.175), randomfloatrange(0.5, 1), level.player.origin, 1600);
    level.player playrumbleonentity("light_1s");
    common_scripts\utility::exploder("stairwell_dust");
    wait(randomfloatrange(4, 7));
  }
}

event_quaker_outdoor() {
  level endon("swept_away");
  level endon("roofcollapse_start");
  common_scripts\utility::flag_wait("player_on_mall_roof");

  for(;;) {
    earthquake(randomfloatrange(0.075, 0.2), randomfloatrange(2, 3), level.player.origin, 1600);
    level.player playrumbleonentity("light_1s");
    common_scripts\utility::exploder("mall_roof_dust");
    wait(randomfloatrange(3, 7));
  }
}

event_quaker_collapse() {
  level endon("swept_away");
  level thread event_rumble_collapse();
  earthquake(0.15, 11, level.player.origin, 1600);
  level.player playSound("scn_flood_mall_rumble_02");
  level.player playrumbleonentity("light_1s");
  wait 4;
  earthquake(0.4, 1, level.player.origin, 1600);
  level.player playSound("scn_flood_mall_rumble_03");
  level.player playrumbleonentity("heavy_1s");
  wait 1;
  earthquake(0.25, 1, level.player.origin, 1600);
  level.player playSound("scn_flood_mall_rumble_04");
  level.player playrumbleonentity("light_1s");
  wait 2.5;
  earthquake(0.5, 1, level.player.origin, 1600);
  level.player playSound("scn_flood_mall_rumble_05");
  level.player playrumbleonentity("heavy_1s");
  wait 1.5;
}

event_rumble_collapse() {
  var_0 = level.player maps\flood_util::create_rumble_ent(1000, "mall_cleanup");
  var_0 playrumblelooponentity("steady_rumble");

  while(!common_scripts\utility::flag("mall_player_falling")) {
    var_1 = distance(var_0.origin, level.player.origin);

    if(var_1 > 666)
      var_0.origin = var_0.origin + (0, 0, -2);
    else
      var_0.origin = var_0.origin + (0, 0, -8);

    var_0 linkto(level.player);
    common_scripts\utility::waitframe();
  }

  var_0 delete();
}

event_gravity() {
  self endon("death");
  var_0 = -105;
  var_1 = 105;
  self movegravity((randomfloatrange(var_0, var_1), randomfloatrange(var_0, var_1), randomfloatrange(var_0, var_1)), 5);
}

event_debris_fall() {
  var_0 = 2;
  self rotatevelocity((randomfloatrange(-200, 200), randomfloatrange(-200, 200), randomfloatrange(-200, 200)), 3000);
  self moveto(self.origin + (0, 0, -300), var_0);
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  playFXOnTag(level._effect["giant_water_splash"], var_1, "tag_origin");
  wait(var_0);
  stopFXOnTag(level._effect["giant_water_splash"], var_1, "tag_origin");
  self delete();
}

roofcollapse_retreat() {
  self endon("death");
  self waittill("goal");
  self.ignoreall = 0;
  maps\_utility::set_ignoresuppression(0);
}

mall_enemy_spawn_func(var_0, var_1) {
  self endon("death");

  if(!common_scripts\utility::flag("player_on_mall_roof")) {
    if(randomint(2) == 0)
      var_2 = getent("mall_goalvolume_camper1", "targetname");
    else
      var_2 = getent("mall_goalvolume_camper2", "targetname");
  } else
    var_2 = getent(var_0, "targetname");

  self setgoalvolumeauto(var_2);
  self.animname = "generic";
  self.noragdoll = 1;
  self.dropweapon = 0;
  self.grenadeammo = 0;

  if(isDefined(var_1) && common_scripts\utility::flag("player_on_mall_roof")) {
    self.goalradius = 8;
    var_3 = getnode(var_1, "targetname");
    self setgoalnode(var_3);
    self waittill("goal");
    self.goalradius = 2048;
  }

  common_scripts\utility::flag_wait("mall_attack_player");
  self.ignoreall = 0;
}

enemy_setup_vign() {
  var_0 = getent("flood_mall_roof_opfor", "targetname");
  thread enemy_setup_vign_floor(var_0);
  var_1 = maps\_utility::spawn_anim_model("mall_roof_opfor_geo", var_0.origin);
  var_2 = getent("warehouse_waters_retarget", "targetname");
  var_1 retargetscriptmodellighting(var_2);
  var_3 = getent("mall_help_hanging_guy", "targetname");
  var_4 = var_3 maps\_utility::spawn_ai(1);
  var_4.animname = "opfor_1";
  var_4 setgoalvolumeauto(getent("mall_goalvolume_main", "targetname"));
  var_4.noragdoll = 1;
  var_4.health = 1;
  var_4.grenadeammo = 0;
  var_4 maps\_utility::gun_remove();
  var_4.spotter = 0;
  var_4.a.pose = "crouch";
  var_4.allowdeath = 1;
  var_4 thread watch_player_pos();
  var_3 = getent("mall_hanging_guy", "targetname");
  var_5 = var_3 maps\_utility::spawn_ai(1);
  var_5.animname = "opfor_2";
  var_5.ignoreme = 1;
  var_5.grenadeammo = 0;
  var_6 = [];
  var_6["opfor_1"] = var_4;
  var_6["opfor_2"] = var_5;
  var_6["mall_roof_opfor_geo"] = var_1;
  var_0 thread maps\_anim::anim_loop(var_6, "flood_mall_roof_opfor", "stop_loop");
  thread enemy_hanging_guy_vo(var_4, var_5);
  common_scripts\utility::flag_wait("mall_attack_player");
  var_0 notify("stop_loop");
  var_4 thread kill_help_hanging_guy();
  var_6 = [];
  var_6["opfor_2"] = var_5;
  var_6["mall_roof_opfor_geo"] = var_1;
  var_0 maps\_anim::anim_single(var_6, "flood_mall_roof_opfor_shot");
  var_5.a.nodeath = 1;
  var_5.allowdeath = 1;
  var_5 kill();
}

enemy_setup_vign_floor(var_0) {
  var_1 = getent("warehouse_waters_retarget", "targetname");
  var_2 = getent("roof_collapse_faling_floor_vign1", "targetname");
  var_2 show();
  var_2.animname = "mall_roof_opfor_geo_vign";
  var_2 maps\_utility::assign_animtree();
  var_2 retargetscriptmodellighting(var_1);
  var_3 = level.scr_model[var_2.animname];
  var_4 = getnumparts(var_3);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = getpartname(var_3, var_5);
    var_7 = getsubstr(var_6, 4, var_6.size - 4);

    if(var_6 == "tag_ac_unit_2_wide_scaled_01 ") {
      var_8 = spawn("script_model", var_2 gettagorigin(var_6));
      var_8 setModel(var_7);
      var_8.angles = var_2 gettagangles(var_6);
      var_8.targetname = "acbox_obj";
      var_8 linkto(var_2, var_6);
      var_8 retargetscriptmodellighting(var_1);
    }

    common_scripts\utility::waitframe();
  }

  var_0 thread maps\_anim::anim_first_frame_solo(var_2, "flood_mall_roof_opfor_vign1");
  common_scripts\utility::flag_wait_any("player_on_mall_roof", "mall_attack_player");
  thread maps\flood_audio::sfx_mall_hanging_falling_floor();
  var_0 thread maps\_anim::anim_single_solo(var_2, "flood_mall_roof_opfor_vign1");
}

kill_help_hanging_guy() {
  self endon("death");
  var_0 = self.origin;

  if(isalive(self))
    thread maps\_anim::anim_loop_solo(self, "flood_mall_roof_opfor_shot", "stop_loop");

  while(isalive(self)) {
    wait(randomfloatrange(1.0, 1.5));
    var_0 = self.origin;
    self stopanimscripted();
    magicbullet("pp19", self.origin, self.origin + (0, 0, 32));
  }

  wait 0.1;
  magicbullet("pp19", (340, -1798, 284), var_0 + (0, 0, 36));
}

enemy_hanging_guy_vo(var_0, var_1) {
  var_1 endon("death");
  var_0 endon("death");
  level endon("mall_attack_player");
  common_scripts\utility::flag_wait("player_on_mall_roof");
  wait 0.5;
  var_0 maps\_utility::dialogue_queue("flood_vs4_holdon");
  var_1 maps\_utility::dialogue_queue("flood_vs5_holdingon");
  var_1 maps\_utility::dialogue_queue("flood_vs5_pullmeup");
  var_0 maps\_utility::dialogue_queue("flood_vs4_getanyleverage");
  var_1 maps\_utility::dialogue_queue("flood_vs5_imslipping");
  wait(randomfloatrange(2, 3));

  for(;;) {
    switch (randomint(4)) {
      case 0:
        var_0 maps\_utility::dialogue_queue("flood_vs4_holdon");
        break;
      case 1:
        var_1 maps\_utility::dialogue_queue("flood_vs5_pullmeup");
        break;
      case 2:
        var_0 maps\_utility::dialogue_queue("flood_vs4_getanyleverage");
        break;
      case 3:
        var_1 maps\_utility::dialogue_queue("flood_vs5_imslipping");
        break;
    }

    wait(randomfloatrange(1, 2));
  }
}

enemy_twitch() {
  common_scripts\utility::flag_wait("player_on_mall_roof");
  var_0 = getent("mall_lookat_hanging_guy", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai(1);
  var_1 setgoalvolumeauto(getent("mall_goalvolume_main", "targetname"));
  var_1.animname = "generic";
  var_1.allowdeath = 1;
  var_1.health = 150;
  var_1.noragdoll = 1;
  var_1.spotter = 0;
  var_1.grenadeammo = 0;
  var_1 thread watch_player_pos();
  var_1 thread enemy_stop_vign_and_attack();
  var_1 thread enemy_twitch_runstumble();
}

enemy_twitch_runstumble() {
  self endon("death");
  level endon("mall_attack_player");
  common_scripts\utility::flag_wait("player_on_mall_roof");

  if(!common_scripts\utility::flag("mall_attack_player")) {
    var_0 = common_scripts\utility::getstruct("runstumble_runstumble", "targetname");
    var_0 maps\_anim::anim_reach_solo(self, "run_react_stumble_non_loop");
    var_0 maps\_anim::anim_generic_run(self, "run_react_stumble_non_loop");
    maps\_anim::anim_generic(self, "run_trans_2_readystand_1");
    thread maps\_anim::anim_generic_loop(self, "readystand_idle_twitch_1", "stop_loop");
  }
}

enemy_stop_vign_and_attack() {
  self endon("death");
  common_scripts\utility::flag_wait("mall_attack_player");
  self notify("stop_loop");
  self stopanimscripted();
  self.ignoreall = 0;
}

enemy_rnd_runner() {
  self endon("death");
  var_0 = getnodearray("mall_rnd_runner", "targetname");
  var_1 = var_0[randomint(var_0.size)];
  var_2 = var_0[randomint(var_0.size)];
  self.fixednode = 1;
  thread maps\_utility::enable_cqbwalk();

  while(!common_scripts\utility::flag("mall_attack_player")) {
    while(distance2d(var_1.origin, var_2.origin) < 300) {
      var_2 = var_0[randomint(var_0.size)];
      wait 0.05;
    }

    self.goalradius = 96;
    self setgoalpos(var_2.origin);
    self waittill("goal");
    var_1 = var_2;
    wait(randomfloatrange(0.75, 2));
  }

  thread maps\_utility::disable_cqbwalk();
  self.goalradius = 2048;
  self.ignoreall = 0;
  self.fixednode = 0;
}

ally_make_fall() {
  self endon("death");
  common_scripts\utility::flag_wait("ally_area_falling");
  thread maps\_anim::anim_single_solo(self, "flood_mall_roof_fall");
  self.grenadeammo = self.mall_grenadeammo;
}

ally0_mall() {
  self.ignoreall = 1;
  maps\_utility::clear_force_color();
  self.goalradius = 8;
  self pushplayer(1);
  thread maps\_utility::enable_cqbwalk();
  self.mall_grenadeammo = self.grenadeammo;
  self.grenadeammo = 0;
  var_0 = common_scripts\utility::getstruct("mall_breach_origin", "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "flood_mall_roof_door");
  var_0 thread maps\_anim::anim_loop_solo(self, "flood_mall_roof_door_loop", "stop_loop");
  common_scripts\utility::flag_set("ally0_breach_ready");
  level waittill("breach_start");
  var_0 notify("stop_loop");
  var_0 maps\_anim::anim_single_solo(self, "flood_mall_roof_door");
  self pushplayer(1);
  thread ally_make_fall();
  self.goalradius = 256;
  var_0 = getnode("ally0_breach_goal", "targetname");
  self setgoalnode(var_0);
  self waittill("goal");
  thread watch_player_onroof_timer();
  common_scripts\utility::flag_wait("mall_attack_player");
  maps\flood_flooding::ally_clear_flee_behavior();
  self.ignoreall = 0;
}

ally1_mall() {
  self.ignoreall = 1;
  maps\_utility::clear_force_color();
  self.goalradius = 8;
  self pushplayer(1);
  thread maps\_utility::enable_cqbwalk();
  self.mall_grenadeammo = self.grenadeammo;
  self.grenadeammo = 0;
  var_0 = common_scripts\utility::getstruct("mall_breach_origin", "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "flood_mall_roof_door");
  var_0 thread maps\_anim::anim_loop_solo(self, "flood_mall_roof_door_loop", "stop_loop");
  common_scripts\utility::flag_wait("mall_breach_start");
  common_scripts\utility::flag_wait("flood_mid_tr_loaded");
  common_scripts\utility::flag_wait_all("ally0_breach_ready", "ally2_breach_ready", "stair_post_quake_vo_done");
  var_0 notify("stop_loop");
  common_scripts\utility::exploder("warehouse_wall_explode");
  thread maps\flood_audio::mall_ext_sirens();
  common_scripts\utility::exploder("mr_doorglow");
  level notify("breach_start");
  thread maps\flood_audio::sfx_flood_int_door();
  level.allies[0] maps\_utility::delaythread(4, maps\_utility::dialogue_queue, "flood_diz_tangosoutthere");
  maps\_utility::delaythread(6, ::remove_hall_clip);
  maps\flood_util::flag_set_delayed("breach_door_open", 6);
  var_0 thread maps\_anim::anim_single_solo(level.flood_mall_roof_door_model, "flood_mall_roof_door");
  var_0 maps\_anim::anim_single_solo(self, "flood_mall_roof_door");
  self.goalradius = 96;
  var_0 thread maps\_anim::anim_loop_solo(self, "flood_mall_roof_door_open_loop", "stop_loop");
  var_1 = [];
  var_1[0] = "flood_diz_outthererook";
  maps\_utility::delaythread(8.0, maps\flood_util::play_nag, var_1, "player_on_mall_roof", 5, 30, 1, 4);
  common_scripts\utility::flag_wait("player_on_mall_roof");
  self notify("stop nags");
  var_0 notify("stop_loop");
  thread maps\flood_audio::sfx_mall_exit_door();
  thread rooftop_door_outdoor(var_0);
  var_0 maps\_anim::anim_single_solo(self, "flood_mall_roof_door_outdoor");
  self pushplayer(1);
  thread ally_make_fall();
  self.goalradius = 256;
  var_0 = getnode("ally1_breach_goal", "targetname");
  self setgoalnode(var_0);
  self waittill("goal");
  common_scripts\utility::flag_wait("mall_attack_player");
  maps\flood_flooding::ally_clear_flee_behavior();
  self.ignoreall = 0;
}

rooftop_door_outdoor(var_0) {
  var_0 maps\_anim::anim_single_solo(level.flood_mall_roof_door_model, "flood_mall_roof_door_outdoor");
  thread mall_door_temp_collision();
  var_1 = getEntArray("mall_roof_door", "targetname");

  foreach(var_3 in var_1)
  var_3 solid();
}

ally2_mall() {
  self.flood_hasmantled = 1;
  self.ignoreall = 1;
  maps\_utility::clear_force_color();
  self.goalradius = 8;
  self pushplayer(1);
  thread maps\_utility::enable_cqbwalk();
  self.mall_grenadeammo = self.grenadeammo;
  self.grenadeammo = 0;
  var_0 = common_scripts\utility::getstruct("mall_breach_origin", "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "flood_mall_roof_door_walkup");
  var_0 maps\_anim::anim_single_solo(self, "flood_mall_roof_door_walkup");
  var_0 thread maps\_anim::anim_loop_solo(self, "flood_mall_roof_door_loop", "stop_loop");
  common_scripts\utility::flag_set("ally2_breach_ready");
  self.moveplaybackrate = 1;
  self.movetransitionrate = 1;
  self.animplaybackrate = 1;
  level waittill("breach_start");
  thread maps\flood_audio::change_zone_stairwell();
  var_0 notify("stop_loop");
  var_0 maps\_anim::anim_single_solo(self, "flood_mall_roof_door");
  self pushplayer(1);
  thread ally_make_fall();
  self.goalradius = 256;
  var_0 = getnode("ally2_breach_goal", "targetname");
  self setgoalnode(var_0);
  self waittill("goal");
  common_scripts\utility::flag_wait("mall_attack_player");
  maps\flood_flooding::ally_clear_flee_behavior();
  self.ignoreall = 0;
}

ally_roof_collapse_vo() {
  level.player endon("death");
  level endon("swept_away");
  level.player maps\flood_audio::sfx_mall_first_screen_shake();
  earthquake(0.5, 1, level.player.origin, 1600);
  level.player playrumbleonentity("light_1s");
  level.allies[1] maps\_utility::dialogue_queue("flood_kgn_keepmoving");
  level.allies[2] maps\_utility::dialogue_queue("flood_diz_gettingshotat");
  level.allies[0] maps\_utility::dialogue_queue("flood_diz_engagingtargets");
}

ally_roof_collapsing_vo() {
  level.player endon("death");
  level endon("swept_away");
  level.allies[2] maps\_utility::dialogue_queue("flood_mrk_halftheroofsgone");
  level.allies[0] maps\_utility::dialogue_queue("flood_pri_wellihopeyou");
}

trigger_player_mall_rooftop() {
  var_0 = getent("player_mall_rooftop", "targetname");
  var_0 waittill("trigger");
  common_scripts\utility::flag_set("player_on_mall_roof");
  maps\flood_util::jkuprint("player on mall roof");
  thread toggle_mall_door_clip("show");
  thread maps\flood_fx::destroy_fx_warehouse_floating_debris();
  var_1 = getEntArray("coverwater_warehouse", "targetname");
  var_2 = getent("coverwater_warehouse_above", "targetname");
  var_3 = getent("coverwater_warehouse_under", "targetname");
  var_1 = common_scripts\utility::array_add(var_1, var_2);
  var_1 = common_scripts\utility::array_add(var_1, var_3);

  foreach(var_5 in var_1) {
    var_5 hide();
    var_5 notsolid();
  }
}

toggle_mall_door_clip(var_0) {
  var_1 = getent("mall_door_clip", "targetname");

  switch (var_0) {
    case "show":
      var_1 show();
      var_1 solid();
      break;
    case "hide":
      var_1 hide();
      var_1 notsolid();
      break;
  }
}

breach_door_open() {
  var_0 = getent("mall_door_roof", "targetname");
  var_1 = getEntArray(var_0.target, "targetname");
  common_scripts\utility::array_call(var_1, ::linkto, var_0);
  var_2 = 1;
  var_0 rotateyaw(-65, var_2, 0.1, 0.1);
  wait(var_2);
  var_0 connectpaths();
}

breach_door_close() {
  var_0 = getent("mall_door_roof", "targetname");
  var_1 = getEntArray(var_0.target, "targetname");
  common_scripts\utility::array_call(var_1, ::linkto, var_0);
  var_2 = 0.2;
  var_0 rotateyaw(65, var_2, 0.1, 0.1);
  wait(var_2);
  var_0 disconnectpaths();
}

breach_door_open_close() {
  var_0 = getent("mall_door_roof", "targetname");
  var_1 = getEntArray(var_0.target, "targetname");
  common_scripts\utility::array_call(var_1, ::linkto, var_0);
  var_0 rotateyaw(125, 0.2, 0.1, 0.1);
  var_0 connectpaths();
  wait 0.3;
  var_0 rotateyaw(-125, 0.2, 0.1, 0.1);
  wait 0.3;
  var_0 disconnectpaths();
}

ally_breach_goal(var_0) {
  self.ignoreall = 1;
  var_1 = getnode(var_0, "targetname");
  self setgoalnode(var_1);
  self waittill("goal");
  wait(randomfloatrange(6, 7));
  self.ignoreall = 0;
}

mall_rooftop_floor_splash() {
  level endon("swept_away");
  var_0 = getent("mall_under_rooftop_splash", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  wait 0.1;

  for(;;) {
    playFXOnTag(level._effect["giant_water_splash"], var_1, "tag_origin");
    wait(randomfloatrange(4.5, 10.0));
  }
}

mall_breach_enemy_1() {
  var_0 = getent("mall_breacher_1", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai(1);
  var_1 thread mall_breach_enemy_setup();
  var_2 = common_scripts\utility::getstruct("mall_breach_enemy_loc1", "targetname");
  var_2 maps\_anim::anim_generic(var_1, "mall_breach_enemy_1");
}

mall_breach_enemy_2() {
  var_0 = getent("mall_breacher_2", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai(1);
  var_1 thread mall_breach_enemy_setup();
  var_1.animname = "breacher2";
  var_0 = getent("mall_breacher_3", "targetname");
  var_2 = var_0 maps\_utility::spawn_ai(1);
  var_2 thread mall_breach_enemy_setup();
  var_2.animname = "breacher3";
  var_3 = maps\_utility::make_array(var_1, var_2);
  var_4 = common_scripts\utility::getstruct("mall_breach_enemy_loc2", "targetname");
  var_4 maps\_anim::anim_single(var_3, "mall_breach_enemy_2");
}

mall_breach_enemy_ragdoll_on_death() {
  self endon("breach_enemy_cancel_ragdoll_death");
  self.ragdoll_immediate = 1;
  var_0 = common_scripts\utility::waittill_any_return("death", "finished_breach_start_anim");

  if(var_0 == "finished_breach_start_anim")
    self.ragdoll_immediate = undefined;
}

mall_breach_enemy_setup() {
  thread mall_breach_enemy_ragdoll_on_death();
  self.grenadeammo = 0;
  self.allowdeath = 1;
  self.health = 10;
  self.baseaccuracy = 5000;
}

watch_glass_shot() {
  var_0 = getEntArray("mall_roof_glass_breaker", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(var_2.target == "mall_roof_glass_2a" || var_2.target == "mall_roof_glass_3b" || var_2.target == "mall_roof_glass_4a" || var_2.target == "mall_roof_glass_4b" || var_2.target == "mall_roof_glass_6b" || var_2.target == "mall_roof_glass_9b") {
      var_3 = getglass(var_2.target);
      destroyglass(var_3);
      var_2 delete();
      continue;
    }

    var_2 thread wait_for_bullet();
  }
}

wait_for_bullet() {
  level endon("swept_away");
  level waittill("breach_start");
  self setCanDamage(1);
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  var_7 = getglass(self.target);
  destroyglass(var_7);
  thread mall_attack_player();
  self delete();
}

mall_roof_door_firstframe() {
  level.flood_mall_roof_door_model = maps\_utility::spawn_anim_model("flood_mall_roof_door_model");
  var_0 = common_scripts\utility::getstruct("mall_breach_origin", "targetname");
  var_0 thread maps\_anim::anim_first_frame_solo(level.flood_mall_roof_door_model, "flood_mall_roof_door");
  var_1 = getEntArray("mall_roof_door", "targetname");

  foreach(var_3 in var_1)
  var_3 linkto(level.flood_mall_roof_door_model);
}

remove_hall_clip() {
  var_0 = getent("mall_roof_door_hall_clip", "targetname");
  var_0 hide();
  var_0 notsolid();
}

mallroof_firstframe(var_0) {
  common_scripts\utility::flag_wait("flood_mid_tr_loaded");
  level.mallroof_back = getent("flood_mallroof_back", "targetname");
  level.mallroof_back.animname = "mallroof_back";
  level.mallroof_back maps\_utility::assign_animtree();
  level.mallroof_center = getent("flood_mallroof_center", "targetname");
  level.mallroof_center.animname = "mallroof_center";
  level.mallroof_center maps\_utility::assign_animtree();
  level.mallroof_center retargetscriptmodellighting(level.mallroof_back);
  level.mallroof_far = getent("flood_mallroof_far", "targetname");
  level.mallroof_far.animname = "mallroof_far";
  level.mallroof_far maps\_utility::assign_animtree();
  level.mallroof_impact = getent("flood_mallroof_impact", "targetname");
  level.mallroof_impact.animname = "mallroof_impact";
  level.mallroof_impact maps\_utility::assign_animtree();
  level.mallroof_rafters1 = getent("flood_mallroof_rafters1", "targetname");
  level.mallroof_rafters1.animname = "mallroof_rafters1";
  level.mallroof_rafters1 maps\_utility::assign_animtree();
  level.mallroof_rafters2 = getent("flood_mallroof_rafters2", "targetname");
  level.mallroof_rafters2.animname = "mallroof_rafters2";
  level.mallroof_rafters2 maps\_utility::assign_animtree();
  level.mallroof_acboxes = getent("flood_mallroof_acboxes", "targetname");
  level.mallroof_acboxes.animname = "mallroof_acboxes";
  level.mallroof_acboxes maps\_utility::assign_animtree();
  level.mallroof_smallrubble = getent("flood_mallroof_smallrubble", "targetname");
  level.mallroof_smallrubble.animname = "mallroof_smallrubble";
  level.mallroof_smallrubble maps\_utility::assign_animtree();
  level.mallroof_cables = getent("flood_mallroof_cables", "targetname");
  level.mallroof_cables.animname = "mallroof_cables";
  level.mallroof_cables maps\_utility::assign_animtree();
  level.mallroof_struct = common_scripts\utility::getstruct("mallroof_collapse", "targetname");
  level.mallroof_array = [];
  level.mallroof_array["mallroof_back"] = level.mallroof_back;
  level.mallroof_array["mallroof_center"] = level.mallroof_center;
  level.mallroof_array["mallroof_far"] = level.mallroof_far;
  level.mallroof_array["mallroof_impact"] = level.mallroof_impact;
  level.mallroof_array["mallroof_rafters1"] = level.mallroof_rafters1;
  level.mallroof_array["mallroof_rafters2"] = level.mallroof_rafters2;
  level.mallroof_array["mallroof_acboxes"] = level.mallroof_acboxes;
  level.mallroof_array["mallroof_smallrubble"] = level.mallroof_smallrubble;
  level.mallroof_array["mallroof_cables"] = level.mallroof_cables;

  if(isDefined(var_0) && var_0 == "hide") {
    foreach(var_2 in level.mallroof_array)
    var_2 hide();

    var_4 = getent("roof_collapse_faling_floor_vign1", "targetname");
    var_4 hide();
  } else {
    level.mallroof_struct thread maps\_anim::anim_first_frame(level.mallroof_array, "mallroof_collapse");
    maps\_utility::delaythread(0.5, ::mallroof_firstframe_show_objects);
  }
}

mallroof_firstframe_show_objects() {
  foreach(var_1 in level.mallroof_array)
  var_1 show();
}

mall_door_temp_collision(var_0) {
  var_1 = getent("mall_door_temp_collision", "targetname");

  if(!isDefined(var_0)) {
    var_1 hide();
    var_1 notsolid();
    var_1 connectpaths();
  } else {
    var_1 show();
    var_1 solid();
    var_1 disconnectpaths();
  }
}

mall_attack_player() {
  level.player endon("death");
  common_scripts\utility::flag_set("mall_attack_player");
  level notify("mall_attack_player");
  level.allies[1] notify("stop nags");
  var_0 = getent("mall_start_cover_hack", "targetname");
  var_0 hide();
  var_0 notsolid();
}

mall_attack_player_vo() {
  level.player endon("death");
  common_scripts\utility::flag_wait_any("mall_attack_player", "mall_weapons_free");
  level.allies[0] thread maps\_utility::dialogue_queue("flood_bkr_weaponsfree");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
}