/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_island_aud.gsc
*********************************************/

main() {
  func_5196();
  lib_0367::func_8E3E("isla");
  func_7BBA();
  func_5C22();
  level.var_11CB.intermission_music_aliases = ["mus_intermission_dlc1"];
  level.var_11CB.wave_cues = ["dlcx_mus_intro_assault", "dlcx_mus_wave_04", "dlcx_mus_wave_02", "dlcx_mus_wave_03", "dlcx_mus_movin", "dlcx_mus_screetchy1", "dlcx_mus_wave_01", "dlcx_mus_wave_05"];
  level.var_11CB.pagan_tone_handle = undefined;
  lib_0366::snd_set_mus_combat_cues_override(level.var_11CB.wave_cues);
  lib_0366::snd_zmb_set_start_intermission_music_override_callback(::island_start_intermission_music_override_callback);
}

island_start_intermission_music_override_callback() {
  var_00 = level.var_11CB.intermission_music_aliases[randomint(level.var_11CB.intermission_music_aliases.size)];
  var_01 = 3;
  var_02 = 5;
  lib_0366::func_8E31(var_00, var_01, var_02);
}

func_7BBA() {
  lib_0378::func_8DC7("player_connect_map", ::func_7248);
  lib_0378::func_8DC7("player_spawned", ::func_7330);
  lib_0378::func_8DC7("wave_begin", ::func_A979);
  lib_0378::func_8DC7("wave_end", ::func_A97A);
  lib_0378::func_8DC7("begin_intro_assault", ::begin_intro_assault);
  lib_0378::func_8DC7("end_intro_assault", ::end_intro_assault);
  lib_0378::func_8DC7("aud_fog_rolling_in", ::aud_fog_rolling_in);
  lib_0378::func_8DC7("aud_fog_rolling_out", ::aud_fog_rolling_out);
  lib_0378::func_8DC7("aud_fog_settled", ::snd_zmb_fog_assassin_vox);
  lib_0378::func_8DC7("aud_fog_lifted", ::aud_fog_lifted);
  lib_0378::func_8DC7("aud_scare_off_crows", ::aud_scare_off_crows);
  lib_0378::func_8DC7("mine_cart_lever", ::mine_cart_lever);
  lib_0378::func_8DC7("mine_cart_gate_opening", ::mine_cart_gate_opening);
  lib_0378::func_8DC7("mine_cart_gate_closing", ::mine_cart_gate_closing);
  lib_0378::func_8DC7("mine_cart_transportation", ::mine_cart_transportation);
  lib_0378::func_8DC7("sub_pen_floor_trap_warning_fire", ::sub_pen_floor_trap_warning_fire);
  lib_0378::func_8DC7("sub_pen_floor_trap_pyro_flame", ::sub_pen_floor_trap_pyro_flame);
  lib_0378::func_8DC7("sub_pen_floor_trap_decaying_fire", ::sub_pen_floor_trap_decaying_fire);
  lib_0378::func_8DC7("sub_pen_prop_trap_start", ::sub_pen_prop_trap_start);
  lib_0378::func_8DC7("sub_pen_prop_trap_extend", ::sub_pen_prop_trap_extend);
  lib_0378::func_8DC7("sub_pen_prop_trap_stop", ::sub_pen_prop_trap_stop);
  lib_0378::func_8DC7("sub_pen_prop_trap_hit", ::sub_pen_prop_trap_hit);
  lib_0378::func_8DC7("sub_pen_prop_trap_player_hit", ::sub_pen_prop_trap_player_hit);
  lib_0378::func_8DC7("gas_valve_state", ::func_3FE4);
  lib_0378::func_8DC7("zombie_soul_suck", ::func_ABF8);
  lib_0378::func_8DC7("zombie_soul_suck_threshold", ::func_ABF9);
  lib_0378::func_8DC7("start_corpse_gate_alarm", ::start_corpse_gate_alarm);
  lib_0378::func_8DC7("stop_corpse_gate_alarm", ::stop_corpse_gate_alarm);
  lib_0378::func_8DC7("aud_corpse_gate_open", ::corpse_gate_open);
  lib_0378::func_8DC7("aud_isla_fireman_intro", ::isla_fireman_intro);
  lib_0378::func_8DC7("fire_panel_turn_off", ::fire_panel_turn_off);
  lib_0378::func_8DC7("fire_panel_turn_on", ::fire_panel_turn_on);
  lib_0378::func_8DC7("aud_plane_mission_start", ::plane_mission_start);
  lib_0378::func_8DC7("aud_plane_spawn", ::plane_spawn);
  lib_0378::func_8DC7("aud_plane_firing", ::plane_firing);
  lib_0378::func_8DC7("aud_plane_damage_player", ::plane_damage_player);
  lib_0378::func_8DC7("aud_plane_tailspin", ::plane_tailspin);
  lib_0378::func_8DC7("aud_plane_explode", ::plane_explode);
  lib_0378::func_8DC7("aud_last_plane_spawn", ::last_plane_spawn);
  lib_0378::func_8DC7("aud_last_plane_crash", ::last_plane_crash);
  lib_0378::func_8DC7("dist_artillery_shot", ::dist_artillery_shot);
  lib_0378::func_8DC7("dist_ship_artillery_inc", ::dist_ship_artillery_inc);
  lib_0378::func_8DC7("dist_ship_artillery_impact", ::dist_ship_artillery_impact);
  lib_0378::func_8DC7("distant_ship_explode", ::distant_ship_explode);
  lib_0378::func_8DC7("distant_water_explode", ::distant_water_explode);
  lib_0378::func_8DC7("artillery_battery_placed", ::artillery_battery_placed);
  lib_0378::func_8DC7("artillery_valve_vert_turn", ::artillery_valve_vert_turn);
  lib_0378::func_8DC7("artillery_valve_hor_turn", ::artillery_valve_hor_turn);
  lib_0378::func_8DC7("artillery_valve_vert_no_turn", ::artillery_valve_vert_no_turn);
  lib_0378::func_8DC7("artillery_valve_hor_no_turn", ::artillery_valve_hor_no_turn);
  lib_0378::func_8DC7("artillery_power_filled", ::artillery_power_filled);
  lib_0378::func_8DC7("artillery_power_depleted", ::artillery_power_depleted);
  lib_0378::func_8DC7("artillery_cannon_shot", ::artillery_cannon_shot);
  lib_0378::func_8DC7("flak_gun_gate_up", ::flak_gun_gate_up);
  lib_0378::func_8DC7("flak_gun_gate_down", ::flak_gun_gate_down);
  lib_0378::func_8DC7("artillery_bunker_trap_spikes", ::artillery_bunker_trap_spikes);
  lib_0378::func_8DC7("radio_tower_artillery_shot", ::radio_tower_artillery_shot);
  lib_0378::func_8DC7("radio_tower_incoming_mortar", ::radio_tower_incoming_mortar);
  lib_0378::func_8DC7("radio_tower_mortar_impact", ::radio_tower_mortar_impact);
  lib_0378::func_8DC7("radio_tower_explosion", ::radio_tower_explosion);
  lib_0378::func_8DC7("pap_schell_insert", ::pap_schell_insert);
  lib_0378::func_8DC7("pap_schell_insert_final", ::pap_schell_insert_final);
  lib_0378::func_8DC7("pap_elevator_move", ::pap_elevator_move);
  lib_0378::func_8DC7("pap_elevator_door_open", ::pap_elevator_door_open);
  lib_0378::func_8DC7("pagen_door_place_stone", ::pagen_door_place_stone);
  lib_0378::func_8DC7("pagen_door_opened", ::pagen_door_opened);
  lib_0378::func_8DC7("pagen_door_closing", ::pagen_door_closing);
  lib_0378::func_8DC7("pagan_head_place", ::pagan_head_place);
  lib_0378::func_8DC7("pagen_room_flush_begin", ::pagen_room_flush_begin);
  lib_0378::func_8DC7("pagen_room_flush_end", ::pagen_room_flush_end);
  lib_0378::func_8DC7("assassin_hc_cry", ::assassin_hc_cry);
  lib_0378::func_8DC7("corpse_gate_talk", ::corpse_gate_talk);
  lib_0378::func_8DC7("ripsaw_collect_gun_chassis", ::ripsaw_collect_gun_chassis);
  lib_0378::func_8DC7("ripsaw_collect_saw_blade", ::ripsaw_collect_saw_blade);
  lib_0378::func_8DC7("ripsaw_insert_chassis", ::ripsaw_insert_chassis);
  lib_0378::func_8DC7("ripsaw_insert_sawblade", ::ripsaw_insert_sawblade);
  lib_0378::func_8DC7("ripsaw_insert_charged_spine", ::ripsaw_insert_charged_spine);
  lib_0378::func_8DC7("ripsaw_weapon_build_infusion", ::ripsaw_weapon_build_infusion);
  lib_0378::func_8DC7("ripsaw_spine_cut", ::lib_0366::ripsaw_spine_cut);
  lib_0378::func_8DC7("ripsaw_fatal_melee", ::lib_0366::ripsaw_fatal_melee);
  lib_0378::func_8DC7("ripsaw_charge", ::ripsaw_charge);
  lib_0378::func_8DC7("charged_ripsaw_hit_pest", ::charged_ripsaw_hit_pest);
  lib_0378::func_8DC7("aud_ripsaw_start_spinning", ::lib_0366::ripsaw_start_spinning);
  lib_0378::func_8DC7("aud_ripsaw_stop_spinning", ::lib_0366::ripsaw_stop_spinning);
  lib_0378::func_8DC7("pommel_earthquake", ::pagan_room_earthquake);
  lib_0378::func_8DC7("pommel_earthquake_stop", ::pagan_room_earthquake_stop);
  lib_0378::func_8DC7("pommel_skull_destroyed", ::pommel_skull_destroyed);
  lib_0378::func_8DC7("pommel_pickup", ::pommel_pickup);
  lib_0378::func_8DC7("freezer_crane_retrieving", ::freezer_crane_retrieving);
  lib_0378::func_8DC7("nazi_head_roll", ::nazi_head_roll);
  lib_0378::func_8DC7("radio_part_drops", ::radio_part_drops);
  lib_0378::func_8DC7("radio_parts_assemble", ::radio_parts_assemble);
  lib_0378::func_8DC7("js_corpse_becomes_zombie", ::js_corpse_becomes_zombie);
  lib_0378::func_8DC7("js_assassin_landing", ::js_assassin_landing);
  lib_0378::func_8DC7("zmb_pomel_grenade_cook", ::zmb_pomel_grenade_cook);
  lib_0378::func_8DC7("zmb_pomel_grenade_detonate", ::zmb_pomel_grenade_detonate);
  lib_0378::func_8DC7("zmb_pomel_grenade_force_field", ::zmb_pomel_grenade_force_field);
  lib_0378::func_8DC7("zmb_pomel_grenade_final_explosion", ::zmb_pomel_grenade_final_explosion);
  lib_0378::func_8DC7("zmb_pomel_grenade_float", ::zmb_pomel_grenade_float);
  lib_0378::func_8DC7("zmb_pomel_grenade_retrieval", ::zmb_pomel_grenade_retrieval);
  lib_0378::func_8DC7("aud_ibeam_squeak", ::ibeam_squeak);
  lib_0378::func_8DC7("aud_ibeam_complete", ::ibeam_complete);
}

func_7248() {
  if(!isDefined(self.var_11CB)) {
    self.var_11CB = spawnStruct();
  }

  if(isDefined(level.var_11CB.intro_assault_executing)) {
    var_00 = 1;
    lib_0366::func_8E4D();
    func_A979(var_00);
  }
}

func_7330() {
  thread fog_music_mix_monitor();
  thread func_8E8F();
  lib_0366::snd_zmb_set_plr_vox_scare_count_max(0);
}

func_A979(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  self method_85A7("snd_randomize_ambient_mus_layers");
  wait 0.05;
  if(!common_scripts\utility::func_562E(param_00)) {
    thread isla_wave_mus_switcher();
  }
}

func_A97A() {
  self notify("kill_isla_wave_mus_switcher");
}

isla_wave_mus_switcher() {
  self endon("death");
  self endon("kill_isla_wave_mus_switcher");
  var_00 = self;
  var_00 endon("disconnect");
  var_01 = 180000;
  var_02 = 2000;
  var_03 = 0.1;
  var_04 = gettime();
  var_05 = 0;
  var_06 = 0;
  var_07 = 0;
  var_08 = 1;
  var_09 = var_00.origin;
  var_0A = 1;
  var_0B = 6;
  var_0C = 14;
  var_0D = 3;
  var_0E = lib_0366::snd_get_curr_combat_cue_name();
  wait(1);
  for(;;) {
    var_0F = gettime() - var_04;
    var_10 = var_00 lib_0366::func_8E14();
    var_11 = var_00.origin != var_09;
    var_09 = var_00.origin;
    var_12 = var_02;
    if(var_00 lib_0366::snd_zmb_plr_is_in_thick_fog()) {
      var_12 = var_12 * 2;
    }

    if(var_11) {
      if(!var_08) {
        var_08 = 1;
        var_07 = var_0F;
      }
    } else if(var_08) {
      var_08 = 0;
      var_06 = var_0F;
    }

    if(!var_11 && var_0F - var_06 > var_12 && var_10 <= var_03 && var_0A) {
      var_0A = 0;
      lib_0366::func_8E32(var_0C);
    } else if(!var_0A && var_11 || var_10 > var_03 && var_0F - var_07 > var_12 * 0.5) {
      var_0A = 1;
      lib_0366::func_8E31(var_0E, var_0B);
    } else if(var_0A && var_0F - var_05 > var_01) {
      var_05 = var_0F;
      var_0E = var_00 lib_0366::func_8D46();
      var_00 lib_0366::func_8DCF(var_0E);
      lib_0366::func_8E32(var_0C);
      wait(0.1);
      lib_0366::func_8E31(var_0E, var_0D);
    }

    wait(0.5);
  }
}

begin_intro_assault() {
  level.var_11CB.intro_assault_executing = 1;
}

end_intro_assault() {
  level.var_11CB.intro_assault_executing = undefined;
  foreach(var_01 in level.players) {
    var_01 lib_0366::func_8E4E();
    var_01 func_A97A();
  }
}

func_5196() {
  var_00 = "conv_startbeach";
  var_01 = [];
  var_01["primary"]["mari"] = ["startbeach_both", 1];
  var_01["primary"]["jeff"] = ["startbeach_both", 1];
  var_01["primary"]["oliv"] = ["startbeach_both", 1];
  var_01["primary"]["dros"] = ["startbeach_both", 1];
  var_01["secondary"]["mari"] = ["startbeach_both", 1];
  var_01["secondary"]["jeff"] = ["startbeach_both", 1];
  var_01["secondary"]["oliv"] = ["startbeach_both", 1];
  var_01["secondary"]["dros"] = ["startbeach_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_mg42look";
  var_01 = [];
  var_01["primary"]["mari"] = ["mg42look_both", 1];
  var_01["primary"]["jeff"] = ["mg42look_both", 1];
  var_01["primary"]["oliv"] = ["mg42look_both", 1];
  var_01["primary"]["dros"] = ["mg42look_both", 1];
  var_01["secondary"]["mari"] = ["mg42look_both", 1];
  var_01["secondary"]["jeff"] = ["mg42look_both", 1];
  var_01["secondary"]["oliv"] = ["mg42look_both", 1];
  var_01["secondary"]["dros"] = ["mg42look_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_mg42nag";
  var_01 = [];
  var_01["primary"]["mari"] = ["mg42nag__both", 1];
  var_01["primary"]["jeff"] = ["mg42nag__both", 1];
  var_01["primary"]["oliv"] = ["mg42nag__both", 1];
  var_01["primary"]["dros"] = ["mg42nag__both", 1];
  var_01["secondary"]["mari"] = ["mg42nag__both", 1];
  var_01["secondary"]["jeff"] = ["mg42nag__both", 1];
  var_01["secondary"]["oliv"] = ["mg42nag__both", 1];
  var_01["secondary"]["dros"] = ["mg42nag__both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_beachover";
  var_01 = [];
  var_01["primary"]["mari"] = ["beachover_both", 1];
  var_01["primary"]["jeff"] = ["beachover_both", 1];
  var_01["primary"]["oliv"] = ["beachover_both", 1];
  var_01["primary"]["dros"] = ["beachover_both", 1];
  var_01["secondary"]["mari"] = ["beachover_both", 1];
  var_01["secondary"]["jeff"] = ["beachover_both", 1];
  var_01["secondary"]["oliv"] = ["beachover_both", 1];
  var_01["secondary"]["dros"] = ["beachover_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_followpath";
  var_01 = [];
  var_01["primary"]["mari"] = ["followpath_both", 1];
  var_01["primary"]["jeff"] = ["followpath_both", 1];
  var_01["primary"]["oliv"] = ["followpath_both", 1];
  var_01["primary"]["dros"] = ["followpath_both", 1];
  var_01["secondary"]["mari"] = ["followpath_both", 1];
  var_01["secondary"]["jeff"] = ["followpath_both", 1];
  var_01["secondary"]["oliv"] = ["followpath_both", 1];
  var_01["secondary"]["dros"] = ["followpath_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_bloodtrailtwo";
  var_01 = [];
  var_01["primary"]["mari"] = ["bloodtrailtwo_both", 1];
  var_01["primary"]["jeff"] = ["bloodtrailtwo_both", 1];
  var_01["primary"]["oliv"] = ["bloodtrailtwo_both", 1];
  var_01["primary"]["dros"] = ["bloodtrailtwo_both", 1];
  var_01["secondary"]["mari"] = ["bloodtrailtwo_both", 1];
  var_01["secondary"]["jeff"] = ["bloodtrailtwo_both", 1];
  var_01["secondary"]["oliv"] = ["bloodtrailtwo_both", 1];
  var_01["secondary"]["dros"] = ["bloodtrailtwo_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_bloodtrailfollow";
  var_01 = [];
  var_01["primary"]["mari"] = ["bloodtrailfollow_both", 1];
  var_01["primary"]["jeff"] = ["bloodtrailfollow_both", 1];
  var_01["primary"]["oliv"] = ["bloodtrailfollow_both", 1];
  var_01["primary"]["dros"] = ["bloodtrailfollow_both", 1];
  var_01["secondary"]["mari"] = ["bloodtrailfollow_both", 1];
  var_01["secondary"]["jeff"] = ["bloodtrailfollow_both", 1];
  var_01["secondary"]["oliv"] = ["bloodtrailfollow_both", 1];
  var_01["secondary"]["dros"] = ["bloodtrailfollow_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_rippedapart";
  var_01 = [];
  var_01["primary"]["mari"] = ["rippedapart_both", 1];
  var_01["primary"]["jeff"] = ["rippedapart_both", 1];
  var_01["primary"]["oliv"] = ["rippedapart_both", 1];
  var_01["primary"]["dros"] = ["rippedapart_both", 1];
  var_01["secondary"]["mari"] = ["rippedapart_both", 1];
  var_01["secondary"]["jeff"] = ["rippedapart_both", 1];
  var_01["secondary"]["oliv"] = ["rippedapart_both", 1];
  var_01["secondary"]["dros"] = ["rippedapart_both", 1];
  lib_0367::func_8E38(var_00, var_01);
}

func_5C22() {
  thread func_35E1();
}

func_35E1() {
  wait(0.5);
  thread ocean_waves_oneshots();
  thread waves_splash_on_rocks();
  lib_0380::func_6842("zmb_isl_beach_ocean_close", undefined, (358, 1751, 45));
  lib_0380::func_6842("zmb_hvac_rattle_lp_03", undefined, (922, 4466, 518));
  lib_0380::func_6842("zmb_hvac_rattle_lp_01", undefined, (1974, 4869, 518));
  lib_0380::func_6842("zmb_hvac_rattle_lp_02", undefined, (1538, 4475, 518));
  lib_0380::func_6842("zmb_steam_exhaust_lp", undefined, (2275, 4518, 241));
  lib_0380::func_6842("zmb_steam_exhaust_lp", undefined, (2378, 4725, 241));
  lib_0380::func_6842("zmb_steam_exhaust_lp", undefined, (2499, 4198, 364));
  lib_0380::func_6842("zmb_freezer_fan_lp", undefined, (1330, 3839, 466));
  lib_0380::func_6842("zmb_isla_subpen_submarine_drips_lp", undefined, (1745, 4670, 375));
}

ocean_waves_oneshots() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("isl_waves_ocean", undefined, (358, 1751, 45));
    wait(randomintrange(5, 8));
  }
}

waves_splash_on_rocks() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("zmb_splash_on_rock", undefined, (983, 2284, 107));
    wait(randomintrange(8, 12));
  }
}

func_1CC1() {
  foreach(var_01 in level.players) {
    var_01 setaltsceneobj("brute_intro", 2);
  }

  lib_0366::func_8E33(3);
  lib_0380::func_6840("zmb_mus_brute_intro");
}

func_1CC2() {
  foreach(var_01 in level.players) {
    var_02 = 0;
    var_03 = 1;
    var_04 = "zmb_mus_wave_04";
    var_01 lib_0366::func_8E31(var_04, var_02, var_03);
    var_01 method_8627("brute_intro", 0.1);
  }
}

snd_zmb_fog_assassin_vox() {
  wait 0.05;
  foreach(var_01 in level.players) {
    var_01 thread ambient_assassin_vox_watcher();
  }
}

ambient_assassin_vox_watcher() {
  level endon("aud_fog_lifted");
  var_00 = self;
  level.var_11CB.amb_assassin_clicks = undefined;
  var_01 = randomintrange(10, 18);
  var_02 = 1000;
  for(;;) {
    if(common_scripts\utility::func_562E(self.isinfogzone)) {
      var_03 = 1;
      var_04 = lib_0366::func_8E1A();
      foreach(var_06 in var_04) {
        var_07 = var_06.var_A4B;
        var_08 = distance(var_06.origin, var_00.origin);
        if((isDefined(var_07) && var_07 == "zombie_assassin" && var_08 < var_02) || isDefined(level.var_11CB.amb_assassin_clicks)) {
          var_03 = 0;
          break;
        }
      }

      if(var_03) {
        var_0A = var_00.origin + (randomintrange(150, 250), randomintrange(150, 250), var_00.origin[2]);
        level.var_11CB.amb_assassin_clicks = lib_0380::func_2889("zvox_ass_dist_clicks", undefined, var_0A);
        wait(var_01);
        level.var_11CB.amb_assassin_clicks = undefined;
      }
    }

    wait(0.2);
  }
}

aud_fog_rolling_in() {
  var_00 = self;
  wait(2);
  if(var_00.current_volume_is_interior) {
    lib_0380::func_6840("zmb_indoor_fog_rolling_in", var_00);
    return;
  }

  lib_0380::func_6840("zmb_fog_rolling_in", var_00);
}

aud_fog_rolling_out() {
  var_00 = self;
  if(var_00.current_volume_is_interior) {
    lib_0380::func_6840("zmb_indoor_fog_rolling_out", var_00);
    return;
  }

  lib_0380::func_6840("zmb_fog_rolling_out", var_00);
}

aud_fog_lifted() {
  level notify("aud_fog_lifted");
}

aud_scare_off_crows() {
  lib_0380::func_6844("zmb_crow_chains", undefined, self);
}

fog_music_mix_monitor() {
  var_00 = self;
  var_01 = 5;
  var_02 = lib_0366::snd_zmb_plr_is_in_thick_fog();
  if(var_02) {
    var_00 setaltsceneobj("fog_music_mix");
  } else {
    var_00 setaltsceneobj("no_fog_music_mix");
  }

  var_03 = var_02;
  for(;;) {
    var_02 = lib_0366::snd_zmb_plr_is_in_thick_fog();
    if(var_02 && !var_03) {
      var_00 setaltsceneobj("fog_music_mix", var_01);
      var_00 method_8627("no_fog_music_mix", var_01);
    } else if(!var_02 && var_03) {
      var_00 method_8627("fog_music_mix", var_01);
      var_00 setaltsceneobj("no_fog_music_mix", var_01);
    }

    var_03 = var_02;
    wait(1.5);
  }
}

func_8E8F() {
  self endon("disconnect");
  var_00 = 0.5;
  var_01 = 1;
  var_02 = 1;
  for(;;) {
    var_03 = !self.current_volume_is_interior;
    if(!isDefined(self)) {
      break;
    }

    if(var_03 != var_01) {
      if(var_03) {
        self method_8627("pa_inside", 1);
      } else {
        self setaltsceneobj("pa_inside", 1);
      }

      var_01 = var_03;
    }

    wait(var_00);
  }
}

mine_cart_lever() {
  var_00 = self;
  lib_0380::func_288B("zmb_mine_cart_lever", undefined, var_00);
}

mine_cart_transportation(param_00) {
  switch (param_00) {
    case 0:
      thread cart_begin_leave(self);
      break;

    case 1:
      thread cart_begin_roundabout(self);
      break;

    case 2:
      thread cart_begin_arrival(self);
      break;
  }
}

cart_begin_leave(param_00) {
  lib_0380::func_288B("zmb_mine_cart_start", undefined, param_00);
}

cart_begin_roundabout(param_00) {
  level.var_11CB.mine_cart_lp_handle = lib_0380::func_6844("zmb_mine_cart_lp", undefined, param_00, 2);
}

cart_begin_arrival(param_00) {
  if(!isDefined(level.var_11CB.mine_cart_lp_handle)) {
    level.var_11CB.mine_cart_lp_handle = lib_0380::func_6844("zmb_mine_cart_lp", undefined, param_00);
    wait(0.1);
    lib_0380::func_6850(level.var_11CB.mine_cart_lp_handle, 3.4);
    level.var_11CB.mine_cart_lp_handle = undefined;
    wait(0.6);
    lib_0380::func_288B("zmb_mine_cart_end", undefined, param_00);
    return;
  }

  lib_0380::func_6850(level.var_11CB.mine_cart_lp_handle, 3.5);
  level.var_11CB.mine_cart_lp_handle = undefined;
  wait(0.7);
  lib_0380::func_288B("zmb_mine_cart_end", undefined, param_00);
}

mine_cart_gate_closing() {
  var_00 = self;
  lib_0380::func_288B("zmb_mine_cart_gate_close", undefined, var_00);
}

mine_cart_gate_opening() {
  var_00 = self;
  lib_0380::func_288B("zmb_mine_cart_gate_open", undefined, var_00);
}

sub_pen_floor_trap_warning_fire() {
  var_00 = self;
  lib_0380::func_6844("floor_panel_warning_fire", undefined, var_00);
}

sub_pen_floor_trap_pyro_flame() {
  var_00 = self;
  lib_0380::func_6844("floor_panel_pyro_flame", undefined, var_00);
  lib_0380::func_6844("floor_panel_heated_metal", undefined, var_00);
}

sub_pen_floor_trap_decaying_fire() {
  var_00 = self;
  lib_0380::func_6844("floor_panel_decaying_fire", undefined, var_00, 1.5);
}

sub_pen_prop_trap_start() {
  var_00 = self;
  wait(1);
  lib_0380::func_288B("zmb_trap_sub_start", undefined, var_00);
  wait(2);
  level.var_11CB.sub_trap_loop_handle = lib_0380::func_6844("zmb_trap_sub_lp", undefined, var_00, 2.5);
}

sub_pen_prop_trap_extend() {
  var_00 = self;
  lib_0380::func_288B("zmb_trap_sub_extend", undefined, var_00);
}

sub_pen_prop_trap_stop() {
  var_00 = self;
  lib_0380::func_6850(level.var_11CB.sub_trap_loop_handle, 1);
  level.var_11CB.sub_trap_loop_handle = undefined;
  wait(0.5);
  lib_0380::func_288B("zmb_trap_sub_stop", undefined, var_00);
}

sub_pen_prop_trap_hit(param_00) {
  lib_0380::func_2889("zmb_trap_sub_hit", undefined, param_00);
}

sub_pen_prop_trap_player_hit(param_00) {
  lib_0380::func_2888("zmb_hit", param_00);
}

func_3FE4(param_00, param_01) {
  var_02 = self;
  var_03 = var_02 getentitynumber();
  if(!isDefined(level.var_11CB.var_A28E)) {
    level.var_11CB.var_A28E = [];
  }

  var_04 = level.var_11CB.var_A28E[var_03];
  if(!isDefined(var_04)) {
    var_04 = spawnStruct();
    level.var_11CB.var_A28E[var_03] = var_04;
  }

  switch (param_00) {
    case "start_opening":
      if(param_01) {
        var_05 = var_02.origin + (0, 0, 100);
        var_04.var_3FE3 = lib_0380::func_6842("zmb_valve_gas_flow_lp", undefined, var_05);
        lib_0380::func_684E(var_04.var_3FE3, 0, 0);
      }

      maps\mp\_audio::func_8DA0("zmb_valve_start_unlock", var_02.origin);
      break;

    case "opening":
      if(isDefined(var_04.var_9E98)) {
        stopclientsound(var_04.var_9E98, 0.1);
      }

      var_04.var_9E98 = playclientsound("zmb_valve_opening_lp", var_02, undefined, undefined, undefined, "hard");
      if(param_01) {
        lib_0380::func_684E(var_04.var_3FE3, 1, self.var_A29D);
      }
      break;

    case "closing":
      if(isDefined(var_04.var_9E98)) {
        stopclientsound(var_04.var_9E98, 0.1);
      }

      var_04.var_9E98 = playclientsound("zmb_valve_closing_lp", var_02, undefined, undefined, undefined, "hard");
      if(param_01) {
        lib_0380::func_684E(var_04.var_3FE3, 0, self.var_A29D);
      }
      break;

    case "open":
      maps\mp\_audio::func_8DA0("zmb_valve_open", var_02.origin);
      if(param_01) {
        lib_0380::func_684E(var_04.var_3FE3, 0.666, 2);
      }

      stopclientsound(var_04.var_9E98, 0.1);
      break;

    case "closed":
      maps\mp\_audio::func_8DA0("zmb_valve_stop_lock", var_02.origin);
      if(isDefined(var_04.var_9E98)) {
        stopclientsound(var_04.var_9E98, 0.1);
      }

      if(isDefined(var_04.var_3FE3)) {
        lib_0380::func_6850(var_04.var_3FE3, 0.1);
        var_04.var_3FE3 = undefined;
      }
      break;
  }
}

func_ABF8(param_00, param_01) {
  var_02 = spawn("script_origin", param_00);
  var_03 = 0;
  var_04 = 0.875;
  lib_0380::func_288B("zombie_soul_suck", undefined, var_02, 0, var_04);
  var_02 moveTo(param_01, 1.9);
  wait(2);
  var_02 delete();
}

func_ABF9(param_00) {
  lib_0380::func_2889("zombie_soul_suck_threshold", undefined, param_00);
}

start_corpse_gate_alarm() {
  var_00 = (1622, 4461, 41);
  level.var_11CB.corpse_gate_alarm_ent = undefined;
  while(!common_scripts\utility::func_3C77("flag_subpen_traps_completed") && !common_scripts\utility::func_562E(level.stop_final_boss_fire_alarm)) {
    level.var_11CB.corpse_gate_alarm_ent = lib_0380::func_2889("zmb_corpse_gate_alarm", undefined, var_00);
    wait(5.5);
    level.var_11CB.corpse_gate_alarm_ent = undefined;
    wait 0.05;
  }
}

stop_corpse_gate_alarm() {
  if(isDefined(level.var_11CB.corpse_gate_alarm_ent)) {
    lib_0380::_stoplocalsound(level.var_11CB.corpse_gate_alarm_ent, 1.5);
    level.var_11CB.corpse_gate_alarm_ent = undefined;
  }
}

corpse_gate_open() {
  var_00 = self;
  lib_0380::func_2889("zmb_corpse_gate", undefined, var_00.origin);
}

isla_fireman_intro() {
  var_00 = self;
  lib_0380::func_6844("zmb_isla_fireman_intro_jump_land", undefined, var_00);
}

fire_panel_turn_off() {
  var_00 = self;
  lib_0380::func_288B("steam_bursts", undefined, var_00);
  lib_0380::func_288B("zmb_isla_fire_panel_turn_off", undefined, var_00);
  lib_0380::func_6850(var_00.panel_handle, 0.5);
}

fire_panel_turn_on() {
  var_00 = self;
  var_00.panel_handle = lib_0380::func_6844("zmb_isla_fire_panel_flame_lp", undefined, var_00);
  lib_0380::func_684F(var_00.panel_handle, 0.5, "flag_subpen_traps_completed");
}

plane_mission_start() {
  level endon("stop_plane_int_submix");
  for(;;) {
    foreach(var_01 in level.players) {
      if(var_01.current_volume_is_interior) {
        var_01 setaltsceneobj("isl_plane_interior_mix");
        continue;
      }

      var_01 method_8627("isl_plane_interior_mix");
    }

    wait(0.2);
  }
}

plane_spawn() {
  common_scripts\utility::flag_init("aud_last_plane_spawned");
  var_00 = self;
  foreach(var_02 in level.players) {
    var_02 thread plane_spawn_watcher(var_00);
  }
}

plane_spawn_watcher(param_00) {
  param_00 endon("death");
  var_01 = self;
  while(1 && isDefined(param_00)) {
    var_02 = distance(param_00.origin, var_01.origin);
    if(var_02 <= 8000) {
      var_03 = lib_0380::func_288B("plane_flyby", undefined, param_00);
      lib_0380::func_288F(var_03, param_00, "plane_sound_done");
      param_00 waittill("plane_sound_done");
    }

    wait(0.3);
  }
}

plane_firing() {
  self endon("death");
  var_00 = self;
  while(common_scripts\utility::func_3794("turret_on")) {
    lib_0380::func_288B("veh_stuka_mg_shot", undefined, var_00);
    wait(0.1);
  }
}

plane_damage_player() {
  var_00 = self;
  lib_0380::func_2888("bullet_large_flesh_plr");
  if(lib_0378::func_8D1B(0.3)) {
    wait(0.1);
    var_01 = var_00.origin + (randomintrange(25, 50), randomintrange(25, 50), var_00.origin[2]);
    lib_0380::func_2889("whizby_near", undefined, var_00.origin);
  }
}

plane_tailspin() {
  self endon("death");
  var_00 = self;
  if(!common_scripts\utility::func_3C77("aud_last_plane_spawned")) {
    lib_0380::func_288D("plane_destruct_death_pop", undefined, var_00, undefined, undefined, 0.1);
    return;
  }

  lib_0380::func_288D("last_plane_crash_flyby_main", undefined, var_00, undefined, undefined, 0.1);
}

plane_explode(param_00) {
  lib_0380::func_2889("plane_destruct_exp_close", undefined, param_00);
}

last_plane_spawn() {
  var_00 = self;
  foreach(var_02 in level.players) {
    var_02 thread last_plane_spawn_watcher(var_00);
  }
}

last_plane_spawn_watcher(param_00) {
  param_00 endon("death");
  var_01 = self;
  for(;;) {
    var_02 = distance(param_00.origin, var_01.origin);
    if(var_02 <= 12500) {
      common_scripts\utility::flag_set("aud_last_plane_spawned");
      level.var_11CB.last_play_flyby_snd = lib_0380::func_288B("last_plane_flyby", undefined, param_00);
      lib_0380::func_288F(level.var_11CB.last_play_flyby_snd, param_00, "last_plane_sound_done");
      param_00 waittill("last_plane_sound_done");
    }

    wait(0.3);
  }
}

last_plane_crash(param_00) {
  common_scripts\utility::func_3C7B("aud_last_plane_spawned");
  lib_0380::_stoplocalsound(level.var_11CB.last_play_flyby_snd, 0.1);
  lib_0380::func_2889("last_plane_crash_explode_main", undefined, param_00);
  level notify("stop_plane_int_submix");
  foreach(var_02 in level.players) {
    var_02 method_8627("isl_plane_interior_mix");
  }
}

dist_artillery_shot() {
  var_00 = self;
  lib_0380::func_288B("zmb_ship_dist_artillery", undefined, var_00);
}

dist_ship_artillery_inc() {
  var_00 = self;
  lib_0380::func_288B("zmb_ship_artillery_inc", undefined, var_00);
  wait(2.7);
  if(isDefined(var_00)) {
    lib_0380::func_288B("zmb_ship_artillery_inc_whizby", undefined, var_00);
  }
}

dist_ship_artillery_impact() {
  var_00 = self;
  lib_0380::func_288B("zmb_ship_mortar_exp", undefined, var_00);
}

distant_ship_explode() {
  lib_0380::func_288B("zmb_ship_destruct_explode", undefined, self);
}

distant_water_explode() {
  lib_0380::func_288B("zmb_ship_destruct_water_explode", undefined, self);
}

artillery_battery_placed() {
  var_00 = (-13, 3572, 1049);
  lib_0380::func_2889("zmb_artillery_battery_placement", undefined, var_00);
  level.var_11CB.artillery_battery_placed = 1;
}

artillery_valve_vert_turn() {
  var_00 = (396, 3245, 1033);
  lib_0380::func_2889("zmb_artillery_valve_open", undefined, var_00);
}

artillery_valve_vert_no_turn() {
  var_00 = (396, 3245, 1033);
  lib_0380::func_2889("zmb_artillery_valve_stop_lock", undefined, var_00);
}

artillery_valve_hor_turn() {
  var_00 = (141, 3259, 1036);
  lib_0380::func_2889("zmb_artillery_valve_open", undefined, var_00);
}

artillery_valve_hor_no_turn() {
  var_00 = (141, 3259, 1036);
  lib_0380::func_2889("zmb_artillery_valve_stop_lock", undefined, var_00);
}

artillery_power_filled() {
  wait 0.05;
  var_00 = (285, 3469, 1153);
  if(level.var_11CB.artillery_battery_placed) {
    level.var_11CB.artillery_battery_placed = 0;
    return;
  }

  lib_0380::func_2889("zmb_artillery_charged_up", undefined, var_00);
}

artillery_power_depleted() {
  var_00 = (285, 3469, 1153);
  lib_0380::func_2889("zmb_artillery_charged_down", undefined, var_00);
}

artillery_cannon_shot(param_00) {
  var_01 = (285, 3469, 1153);
  lib_0380::func_2889("zmb_artillery_cannon_shot", undefined, param_00);
  wait(1.5);
  lib_0380::func_2889("zmb_artillery_room_shake", undefined, var_01);
}

flak_gun_gate_up() {
  var_00 = self;
  lib_0380::func_288B("zmb_flak_gun_gate_up", undefined, var_00);
}

flak_gun_gate_down() {
  var_00 = self;
  lib_0380::func_288B("zmb_flak_gun_gate_down", undefined, var_00);
}

artillery_bunker_trap_spikes(param_00) {
  lib_0380::func_2889("trap_spikes_start", undefined, param_00);
  wait(0.3);
  var_01 = 0;
  while(var_01 <= 32) {
    lib_0380::func_2889("floor_spike_trap", undefined, param_00);
    var_01++;
    wait(0.6);
  }

  lib_0380::func_2889("trap_spikes_end", undefined, param_00);
}

radio_tower_artillery_shot() {
  var_00 = self;
  lib_0380::func_288B("zmb_ship_dist_artillery", undefined, var_00);
}

radio_tower_incoming_mortar() {
  var_00 = self;
  wait(0.3);
  lib_0380::func_288B("zmb_ship_artillery_inc", undefined, var_00);
  wait(2.7);
  if(isDefined(var_00)) {
    lib_0380::func_288B("zmb_ship_artillery_inc_whizby", undefined, var_00);
  }
}

radio_tower_mortar_impact() {
  var_00 = self;
  lib_0380::func_288B("zmb_ship_mortar_exp", undefined, var_00);
}

radio_tower_explosion(param_00) {
  lib_0380::func_2889("zmb_radio_tower_explosion", undefined, param_00);
  lib_0380::func_2889("zmb_radio_tower_fall", undefined, param_00);
  lib_0380::func_2889("zmb_radio_tower_fall_impacts", undefined, param_00);
  lib_0380::func_2889("zmb_radio_tower_fall_sparks", undefined, param_00);
}

pap_schell_insert() {
  var_00 = self;
  lib_0380::func_288B("zmb_island_pap_schell_insert", undefined, var_00);
  lib_0380::func_288B("zmb_island_pap_schell_insert_elec", undefined, var_00);
}

pap_schell_insert_final() {
  var_00 = self;
  lib_0380::func_288B("zmb_island_pap_schell_insert", undefined, var_00);
  lib_0380::func_288B("zmb_island_pap_machine_react", undefined, var_00);
}

pap_elevator_move() {
  var_00 = self;
  lib_0380::func_288B("zmb_island_pap_elevator_move", undefined, var_00);
}

pap_elevator_door_open() {
  var_00 = self;
  lib_0380::func_288B("zmb_island_pap_elev_door_open", undefined, var_00);
}

pagen_door_place_stone() {
  var_00 = self;
  lib_0380::func_288B("zmb_pagen_door_place_stone", undefined, var_00);
}

pagen_door_opened() {
  var_00 = self;
  wait(1);
  lib_0380::func_288B("zmb_pagen_door_opened", undefined, var_00);
}

pagen_door_closing() {
  var_00 = self;
  lib_0380::func_288B("zmb_pagen_door_closing", undefined, var_00);
  wait(2.5);
  lib_0380::func_288B("zmb_pagen_door_closing_stop", undefined, var_00);
  wait(0.5);
  lib_0380::func_288B("zmb_pagen_door_closed", undefined, var_00);
}

pagen_room_flush_begin() {
  var_00 = self;
  lib_0380::func_288B("zmb_pagen_room_flush_main", undefined, var_00);
}

pagen_room_flush_end() {
  var_00 = self;
  lib_0380::func_288B("zmb_pagen_room_flush_splash", undefined, var_00);
  lib_0380::func_288B("zmb_pagen_room_flush_foley", undefined, var_00);
}

assassin_hc_cry() {
  var_00 = self;
  lib_0380::func_288B("zmb_island_hc_assassin_cry", undefined, var_00);
}

ripsaw_collect_gun_chassis(param_00) {
  lib_0380::func_2889("zmb_ripsaw_obtain_chassis", undefined, param_00);
}

ripsaw_collect_saw_blade(param_00) {
  lib_0380::func_2889("zmb_ripsaw_obtain_sawblade", undefined, param_00);
}

ripsaw_insert_chassis() {
  var_00 = self;
  lib_0380::func_288B("zmb_ripsaw_insert_chassis", undefined, var_00);
}

ripsaw_insert_sawblade() {
  var_00 = self;
  lib_0380::func_288B("zmb_ripsaw_insert_sawblade", undefined, var_00);
}

ripsaw_insert_charged_spine() {
  var_00 = self;
  lib_0380::func_288B("zmb_ripsaw_insert_spine_case", undefined, var_00);
}

ripsaw_weapon_build_infusion(param_00) {
  lib_0380::func_2889("zmb_ripsaw_build_infusion", undefined, param_00);
}

ripsaw_charge() {
  var_00 = self;
  lib_0380::func_288B("zmb_ripsaw_charge", undefined, var_00);
}

charged_ripsaw_hit_pest() {
  var_00 = self;
  lib_0380::func_288B("zmb_ripsaw_charged_impact", undefined, var_00);
}

corpse_gate_talk(param_00) {
  var_01 = self.var_B9;
  if(!isDefined(param_00)) {
    return;
  }

  var_02 = undefined;
  switch (param_00) {
    case "awake":
      var_02 = "zmb_isla_cgo_uhuhwasistdennhierlos";
      break;

    case "alarm":
      var_02 = common_scripts\utility::random(["zmb_isla_cgo_wobinichfeindehieralarmal", "zmb_isla_cgo_brenntihrbastardebrennt"]);
      break;

    case "beg":
      var_02 = common_scripts\utility::random(["zmb_isla_cgo_waitwaitiamonyourside", "zmb_isla_cgo_iwashelpingyou", "zmb_isla_cgo_pleasedontdothis", "zmb_isla_cgo_bittemachtdasnicht", "zmb_isla_cgo_bittebittebefreitmichvond", "zmb_isla_cgo_wartetwartetichbinaufeure", "zmb_isla_cgo_ichhabeuchdochgeholfen"]);
      break;

    case "talk":
      var_02 = common_scripts\utility::random(["zmb_isla_cgo_soundsofweepingifearthati", "zmb_isla_cgo_thisisredridinghoodwithaf", "zmb_isla_cgo_contdevennowhecarriestheh", "zmb_isla_cgo_angrybreathinghehasremove", "zmb_isla_cgo_iamnotsurewhetherishouldc", "zmb_isla_cgo_hisrecentexperimentswithr", "zmb_isla_cgo_contdandstraubwellheisfur", "zmb_isla_cgo_ravencrownthisisredriding", "zmb_isla_cgo_ravencrowistillhavenothea", "zmb_isla_cgo_youmustknowsinceourlastco", "zmb_isla_cgo_nervousisthisworkingtapta"]);
      break;

    case "scream":
      var_02 = common_scripts\utility::random(["zmb_isla_cgo_aaaaaaaaaaaaaaarrrgh", "zmb_isla_cgo_neinneinaaaargh"]);
      break;
  }

  if(isDefined(var_02)) {
    corpse_gate_german_dialogue(var_02);
  }
}

corpse_gate_german_dialogue(param_00) {
  if(common_scripts\utility::func_562E(self.is_opened) || !isDefined(self.var_B9)) {
    return;
  }

  while(common_scripts\utility::func_562E(self.var_B9.is_speaking)) {
    wait 0.05;
  }

  self.var_B9.is_speaking = 1;
  var_01 = self.var_B9;
  var_01.head_talk_snd = lib_0380::func_288B(param_00, undefined, var_01);
  lib_0380::func_288F(var_01.head_talk_snd, var_01, "head_dialogue_done");
  var_01 waittill("head_dialogue_done");
  self.var_B9.is_speaking = 0;
}

pagan_head_place(param_00, param_01) {
  switch (param_01) {
    case "flag_anointed_monk_head_placed":
      lib_0380::func_6850(level.var_11CB.pagan_tone_handle, 0.5);
      lib_0380::func_6844("pagan_head_place_01", undefined, param_00);
      wait(1);
      level.var_11CB.pagan_tone_handle = lib_0380::func_6844("pagan_head_place_tone_01", undefined, param_00);
      break;

    case "flag_anointed_fol_head_placed":
      lib_0380::func_6850(level.var_11CB.pagan_tone_handle, 0.5);
      lib_0380::func_6844("pagan_head_place_02", undefined, param_00);
      wait(1);
      level.var_11CB.pagan_tone_handle = lib_0380::func_6844("pagan_head_place_tone_02", undefined, param_00);
      break;

    case "flag_anointed_asn_head_placed":
      lib_0380::func_6850(level.var_11CB.pagan_tone_handle, 0.5);
      lib_0380::func_6844("pagan_head_place_03", undefined, param_00);
      wait(1);
      level.var_11CB.pagan_tone_handle = lib_0380::func_6844("pagan_head_place_tone_03", undefined, param_00);
      break;

    case "flag_anointed_pest_head_placed":
      lib_0380::func_6850(level.var_11CB.pagan_tone_handle, 0.5);
      lib_0380::func_6844("pagan_head_place_04", undefined, param_00);
      wait(1);
      level.var_11CB.pagan_tone_handle = lib_0380::func_6844("pagan_head_place_tone_04", undefined, param_00);
      break;

    default:
      break;
  }
}

pagan_room_earthquake(param_00, param_01, param_02) {
  foreach(var_04 in level.players) {
    if(distance(var_04.origin, param_02) < 500) {
      var_04 setaltsceneobj("paganearthquake");
    }
  }

  switch (param_00) {
    case "rumble":
      if(!isDefined(level.var_11CB.paganearthquake_rumble_handle)) {
        var_06 = param_01;
        var_07 = 2.5;
        lib_0366::func_8E30(0.75, var_06);
        level.var_11CB.paganearthquake_rumble_handle = lib_0380::func_6842("zmb_isla_earthquake_rumble_lp", undefined, param_02, var_06);
      }
      break;

    case "earthquake":
      if(!isDefined(level.var_11CB.paganearthquake_quake_handle)) {
        var_06 = 0.25;
        var_07 = param_01 * 0.5 * 0.95;
        lib_0366::func_8E30(0.25, var_06);
        level.var_11CB.paganearthquake_quake_handle = lib_0380::func_6842("zmb_isla_earthquake_lp", undefined, param_02, var_06);
        wait(param_01 * 0.5);
        lib_0380::func_6842("zmb_isla_earthquake_settle", undefined, param_02, var_06);
        pagan_room_earthquake_stop(var_07);
      }
      break;
  }
}

pagan_room_earthquake_stop(param_00) {
  lib_0366::func_8E30(1, param_00);
  foreach(var_02 in level.players) {
    var_02 method_8627("paganearthquake");
  }

  if(isDefined(level.var_11CB.paganearthquake_rumble_handle)) {
    lib_0380::func_6850(level.var_11CB.paganearthquake_rumble_handle, param_00);
  }

  if(isDefined(level.var_11CB.zone1earthquake_quake_handle)) {
    lib_0380::func_6850(level.var_11CB.zone1earthquake_quake_handle, param_00);
  }

  level.var_11CB.paganearthquake_rumble_handle = undefined;
  level.var_11CB.paganearthquake_quake_handle = undefined;
}

pommel_skull_destroyed(param_00) {
  lib_0380::func_288B("zmb_pommel_skull_destroy", undefined, param_00);
}

pommel_pickup() {
  var_00 = self;
  var_01 = var_00.origin;
  var_02 = lib_0380::func_6844("zmb_pommel_energy_lp", undefined, var_00, 1.5);
  level waittill("aud_stop_pommel_energy_loop");
  lib_0380::func_6850(var_02);
  var_02 = undefined;
  lib_0380::func_2889("zmb_pommel_pick_up", undefined, var_01);
}

freezer_crane_retrieving() {
  var_00 = self;
  var_01 = self.origin;
  lib_0380::func_288B("zmb_freezer_crane_start", undefined, var_00);
  lib_0380::func_2889("zmb_freezer_crane_movement", undefined, var_01);
  wait(11.415);
  lib_0380::func_2889("zmb_freezer_crane_retrieve", undefined, var_01);
  wait(12.7);
  lib_0380::func_288B("zmb_freezer_crane_end", undefined, var_00);
}

nazi_head_roll() {
  var_00 = self;
  var_01 = var_00.origin;
  lib_0380::func_2889("zmb_nazi_head_roll", undefined, var_01);
  lib_0380::func_2889("zmb_nazi_head_blood_splat", undefined, var_01);
}

radio_part_drops() {
  var_00 = self;
  wait(0.8);
  lib_0380::func_288B("zmb_radio_part_drops", undefined, var_00);
}

radio_parts_assemble() {
  var_00 = self;
  lib_0380::func_288B("zmb_radio_part_assemble", undefined, var_00);
}

js_corpse_becomes_zombie() {
  lib_0366::snd_not_so_simple_jump_scare();
}

js_assassin_landing() {
  lib_0366::snd_not_so_simple_jump_scare();
}

ibeam_squeak() {
  var_00 = self;
  wait(0.1);
  lib_0380::func_288B("zmb_ibeam_squeak", undefined, var_00);
}

ibeam_complete() {
  var_00 = self;
  lib_0380::func_288B("zmb_ibeam_stop", undefined, var_00);
}

get_random_alive_player() {
  var_00 = common_scripts\utility::array_randomize(level.players);
  foreach(var_02 in var_00) {
    if(!isalive(var_02)) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_02.var_5728)) {
      continue;
    }

    return var_02;
  }

  return level.player;
}

get_closest_alive_player(param_00) {
  var_01 = common_scripts\utility::func_40B0(param_00, level.players);
  foreach(var_03 in var_01) {
    if(!isalive(var_03)) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_03.var_5728)) {
      continue;
    }

    return var_03;
  }

  return level.player;
}

get_player_looking_at(param_00, param_01, param_02) {
  var_03 = common_scripts\utility::array_randomize(level.players);
  foreach(var_05 in var_03) {
    if(!isalive(var_05)) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_05.var_5728)) {
      continue;
    }

    if(distance(var_05.origin, param_00.origin) > param_01) {
      continue;
    }

    if(!maps\mp\_utility::func_3B8E(var_05, param_00, param_02)) {
      continue;
    }

    return var_05;
  }

  return undefined;
}

get_specific_player_for_vo(param_00) {
  foreach(var_02 in level.players) {
    if(!isalive(var_02)) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_02.var_5728)) {
      continue;
    }

    var_03 = get_type_by_player_char(param_00);
    if(!lib_0547::func_5565(var_02.var_20DA, var_03)) {
      continue;
    }

    return var_02;
  }
}

get_type_by_player_char(param_00) {
  var_01 = "offi";
  switch (param_00) {
    case "jefferson":
      var_01 = "sold";
      break;

    case "drostan":
      var_01 = "arch";
      break;

    case "marie":
      var_01 = "offi";
      break;

    case "olivia":
      var_01 = "figh";
      break;
  }

  return var_01;
}

zmb_pomel_grenade_cook() {
  var_00 = self;
  var_01 = lib_0380::func_6844("zmb_big_pommel_energy_lp", undefined, var_00, 0.5);
  var_00 waittill("aud_stop_pomel_nade_cook");
  lib_0380::func_6850(var_01);
  var_01 = undefined;
}

zmb_pomel_grenade_detonate(param_00) {
  lib_0380::func_2889("wpn_pomel_grenade_detonate", undefined, param_00);
}

zmb_pomel_grenade_force_field(param_00) {
  lib_0380::func_2889("wpn_pomel_grenade_force_field", undefined, param_00);
}

zmb_pomel_grenade_final_explosion(param_00) {
  lib_0380::func_2889("wpn_pomel_grenade_explosion", undefined, param_00);
}

zmb_pomel_grenade_float(param_00) {
  var_01 = self;
  var_02 = lib_0380::func_6844("zmb_pommel_energy_lp", undefined, var_01, 0.5);
  param_00 waittill("aud_stop_pommel_float_lp");
  lib_0380::func_6850(var_02);
  var_02 = undefined;
}

zmb_pomel_grenade_retrieval() {
  var_00 = self;
  var_00 notify("aud_stop_pommel_float_lp");
  lib_0380::func_288B("zmb_pommel_pick_up", undefined, var_00);
}