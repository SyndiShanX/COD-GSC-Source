/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_aud.gsc
****************************************************/

main() {
  _id_5196();
  _id_0367::_id_8E3E("isla");
  _id_7BBA();
  _id_5C22();
  level._id_11CB.intermission_music_aliases = ["mus_intermission_dlc1"];
  level._id_11CB.wave_cues = ["dlcx_mus_intro_assault", "dlcx_mus_wave_04", "dlcx_mus_wave_02", "dlcx_mus_wave_03", "dlcx_mus_movin", "dlcx_mus_screetchy1", "dlcx_mus_wave_01", "dlcx_mus_wave_05"];
  level._id_11CB.pagan_tone_handle = undefined;
  _id_0366::snd_set_mus_combat_cues_override(level._id_11CB.wave_cues);
  _id_0366::snd_zmb_set_start_intermission_music_override_callback(::island_start_intermission_music_override_callback);
}

island_start_intermission_music_override_callback() {
  var_0 = level._id_11CB.intermission_music_aliases[randomint(level._id_11CB.intermission_music_aliases.size)];
  var_1 = 3.0;
  var_2 = 5.0;
  _id_0366::_id_8E31(var_0, var_1, var_2);
}

_id_7BBA() {
  _id_0378::_id_8DC7("player_connect_map", ::_id_7248);
  _id_0378::_id_8DC7("player_spawned", ::_id_7330);
  _id_0378::_id_8DC7("wave_begin", ::_id_A979);
  _id_0378::_id_8DC7("wave_end", ::_id_A97A);
  _id_0378::_id_8DC7("begin_intro_assault", ::begin_intro_assault);
  _id_0378::_id_8DC7("end_intro_assault", ::end_intro_assault);
  _id_0378::_id_8DC7("aud_fog_rolling_in", ::aud_fog_rolling_in);
  _id_0378::_id_8DC7("aud_fog_rolling_out", ::aud_fog_rolling_out);
  _id_0378::_id_8DC7("aud_fog_settled", ::snd_zmb_fog_assassin_vox);
  _id_0378::_id_8DC7("aud_fog_lifted", ::aud_fog_lifted);
  _id_0378::_id_8DC7("aud_scare_off_crows", ::aud_scare_off_crows);
  _id_0378::_id_8DC7("mine_cart_lever", ::mine_cart_lever);
  _id_0378::_id_8DC7("mine_cart_gate_opening", ::mine_cart_gate_opening);
  _id_0378::_id_8DC7("mine_cart_gate_closing", ::mine_cart_gate_closing);
  _id_0378::_id_8DC7("mine_cart_transportation", ::mine_cart_transportation);
  _id_0378::_id_8DC7("sub_pen_floor_trap_warning_fire", ::sub_pen_floor_trap_warning_fire);
  _id_0378::_id_8DC7("sub_pen_floor_trap_pyro_flame", ::sub_pen_floor_trap_pyro_flame);
  _id_0378::_id_8DC7("sub_pen_floor_trap_decaying_fire", ::sub_pen_floor_trap_decaying_fire);
  _id_0378::_id_8DC7("sub_pen_prop_trap_start", ::sub_pen_prop_trap_start);
  _id_0378::_id_8DC7("sub_pen_prop_trap_extend", ::sub_pen_prop_trap_extend);
  _id_0378::_id_8DC7("sub_pen_prop_trap_stop", ::sub_pen_prop_trap_stop);
  _id_0378::_id_8DC7("sub_pen_prop_trap_hit", ::sub_pen_prop_trap_hit);
  _id_0378::_id_8DC7("sub_pen_prop_trap_player_hit", ::sub_pen_prop_trap_player_hit);
  _id_0378::_id_8DC7("gas_valve_state", ::_id_3FE4);
  _id_0378::_id_8DC7("zombie_soul_suck", ::_id_ABF8);
  _id_0378::_id_8DC7("zombie_soul_suck_threshold", ::_id_ABF9);
  _id_0378::_id_8DC7("start_corpse_gate_alarm", ::start_corpse_gate_alarm);
  _id_0378::_id_8DC7("stop_corpse_gate_alarm", ::stop_corpse_gate_alarm);
  _id_0378::_id_8DC7("aud_corpse_gate_open", ::corpse_gate_open);
  _id_0378::_id_8DC7("aud_isla_fireman_intro", ::isla_fireman_intro);
  _id_0378::_id_8DC7("fire_panel_turn_off", ::fire_panel_turn_off);
  _id_0378::_id_8DC7("fire_panel_turn_on", ::fire_panel_turn_on);
  _id_0378::_id_8DC7("aud_plane_mission_start", ::plane_mission_start);
  _id_0378::_id_8DC7("aud_plane_spawn", ::plane_spawn);
  _id_0378::_id_8DC7("aud_plane_firing", ::plane_firing);
  _id_0378::_id_8DC7("aud_plane_damage_player", ::plane_damage_player);
  _id_0378::_id_8DC7("aud_plane_tailspin", ::plane_tailspin);
  _id_0378::_id_8DC7("aud_plane_explode", ::plane_explode);
  _id_0378::_id_8DC7("aud_last_plane_spawn", ::last_plane_spawn);
  _id_0378::_id_8DC7("aud_last_plane_crash", ::last_plane_crash);
  _id_0378::_id_8DC7("dist_artillery_shot", ::dist_artillery_shot);
  _id_0378::_id_8DC7("dist_ship_artillery_inc", ::dist_ship_artillery_inc);
  _id_0378::_id_8DC7("dist_ship_artillery_impact", ::dist_ship_artillery_impact);
  _id_0378::_id_8DC7("distant_ship_explode", ::distant_ship_explode);
  _id_0378::_id_8DC7("distant_water_explode", ::distant_water_explode);
  _id_0378::_id_8DC7("artillery_battery_placed", ::artillery_battery_placed);
  _id_0378::_id_8DC7("artillery_valve_vert_turn", ::artillery_valve_vert_turn);
  _id_0378::_id_8DC7("artillery_valve_hor_turn", ::artillery_valve_hor_turn);
  _id_0378::_id_8DC7("artillery_valve_vert_no_turn", ::artillery_valve_vert_no_turn);
  _id_0378::_id_8DC7("artillery_valve_hor_no_turn", ::artillery_valve_hor_no_turn);
  _id_0378::_id_8DC7("artillery_power_filled", ::artillery_power_filled);
  _id_0378::_id_8DC7("artillery_power_depleted", ::artillery_power_depleted);
  _id_0378::_id_8DC7("artillery_cannon_shot", ::artillery_cannon_shot);
  _id_0378::_id_8DC7("flak_gun_gate_up", ::flak_gun_gate_up);
  _id_0378::_id_8DC7("flak_gun_gate_down", ::flak_gun_gate_down);
  _id_0378::_id_8DC7("artillery_bunker_trap_spikes", ::artillery_bunker_trap_spikes);
  _id_0378::_id_8DC7("radio_tower_artillery_shot", ::radio_tower_artillery_shot);
  _id_0378::_id_8DC7("radio_tower_incoming_mortar", ::radio_tower_incoming_mortar);
  _id_0378::_id_8DC7("radio_tower_mortar_impact", ::radio_tower_mortar_impact);
  _id_0378::_id_8DC7("radio_tower_explosion", ::radio_tower_explosion);
  _id_0378::_id_8DC7("pap_schell_insert", ::pap_schell_insert);
  _id_0378::_id_8DC7("pap_schell_insert_final", ::pap_schell_insert_final);
  _id_0378::_id_8DC7("pap_elevator_move", ::pap_elevator_move);
  _id_0378::_id_8DC7("pap_elevator_door_open", ::pap_elevator_door_open);
  _id_0378::_id_8DC7("pagen_door_place_stone", ::pagen_door_place_stone);
  _id_0378::_id_8DC7("pagen_door_opened", ::pagen_door_opened);
  _id_0378::_id_8DC7("pagen_door_closing", ::pagen_door_closing);
  _id_0378::_id_8DC7("pagan_head_place", ::pagan_head_place);
  _id_0378::_id_8DC7("pagen_room_flush_begin", ::pagen_room_flush_begin);
  _id_0378::_id_8DC7("pagen_room_flush_end", ::pagen_room_flush_end);
  _id_0378::_id_8DC7("assassin_hc_cry", ::assassin_hc_cry);
  _id_0378::_id_8DC7("corpse_gate_talk", ::corpse_gate_talk);
  _id_0378::_id_8DC7("ripsaw_collect_gun_chassis", ::ripsaw_collect_gun_chassis);
  _id_0378::_id_8DC7("ripsaw_collect_saw_blade", ::ripsaw_collect_saw_blade);
  _id_0378::_id_8DC7("ripsaw_insert_chassis", ::ripsaw_insert_chassis);
  _id_0378::_id_8DC7("ripsaw_insert_sawblade", ::ripsaw_insert_sawblade);
  _id_0378::_id_8DC7("ripsaw_insert_charged_spine", ::ripsaw_insert_charged_spine);
  _id_0378::_id_8DC7("ripsaw_weapon_build_infusion", ::ripsaw_weapon_build_infusion);
  _id_0378::_id_8DC7("ripsaw_spine_cut", _id_0366::ripsaw_spine_cut);
  _id_0378::_id_8DC7("ripsaw_fatal_melee", _id_0366::ripsaw_fatal_melee);
  _id_0378::_id_8DC7("ripsaw_charge", ::ripsaw_charge);
  _id_0378::_id_8DC7("charged_ripsaw_hit_pest", ::charged_ripsaw_hit_pest);
  _id_0378::_id_8DC7("aud_ripsaw_start_spinning", _id_0366::ripsaw_start_spinning);
  _id_0378::_id_8DC7("aud_ripsaw_stop_spinning", _id_0366::ripsaw_stop_spinning);
  _id_0378::_id_8DC7("pommel_earthquake", ::pagan_room_earthquake);
  _id_0378::_id_8DC7("pommel_earthquake_stop", ::pagan_room_earthquake_stop);
  _id_0378::_id_8DC7("pommel_skull_destroyed", ::pommel_skull_destroyed);
  _id_0378::_id_8DC7("pommel_pickup", ::pommel_pickup);
  _id_0378::_id_8DC7("freezer_crane_retrieving", ::freezer_crane_retrieving);
  _id_0378::_id_8DC7("nazi_head_roll", ::nazi_head_roll);
  _id_0378::_id_8DC7("radio_part_drops", ::radio_part_drops);
  _id_0378::_id_8DC7("radio_parts_assemble", ::radio_parts_assemble);
  _id_0378::_id_8DC7("js_corpse_becomes_zombie", ::js_corpse_becomes_zombie);
  _id_0378::_id_8DC7("js_assassin_landing", ::js_assassin_landing);
  _id_0378::_id_8DC7("zmb_pomel_grenade_cook", ::zmb_pomel_grenade_cook);
  _id_0378::_id_8DC7("zmb_pomel_grenade_detonate", ::zmb_pomel_grenade_detonate);
  _id_0378::_id_8DC7("zmb_pomel_grenade_force_field", ::zmb_pomel_grenade_force_field);
  _id_0378::_id_8DC7("zmb_pomel_grenade_final_explosion", ::zmb_pomel_grenade_final_explosion);
  _id_0378::_id_8DC7("zmb_pomel_grenade_float", ::zmb_pomel_grenade_float);
  _id_0378::_id_8DC7("zmb_pomel_grenade_retrieval", ::zmb_pomel_grenade_retrieval);
  _id_0378::_id_8DC7("aud_ibeam_squeak", ::ibeam_squeak);
  _id_0378::_id_8DC7("aud_ibeam_complete", ::ibeam_complete);
}

_id_7248() {
  if(!isDefined(self._id_11CB))
    self._id_11CB = spawnStruct();

  if(isDefined(level._id_11CB.intro_assault_executing)) {
    var_0 = 1;
    _id_0366::_id_8E4D();
    _id_A979(var_0);
  }
}

_id_7330() {
  thread fog_music_mix_monitor();
  thread _id_8E8F();
  _id_0366::snd_zmb_set_plr_vox_scare_count_max(0);
}

_id_A979(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  self _meth_85A7("snd_randomize_ambient_mus_layers");
  waitframe();

  if(!common_scripts\utility::_id_562E(var_0))
    thread isla_wave_mus_switcher();
}

_id_A97A() {
  self notify("kill_isla_wave_mus_switcher");
}

isla_wave_mus_switcher() {
  self endon("death");
  self endon("kill_isla_wave_mus_switcher");
  var_0 = self;
  var_0 endon("disconnect");
  var_1 = 180000;
  var_2 = 2000;
  var_3 = 0.1;
  var_4 = gettime();
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 1;
  var_9 = var_0.origin;
  var_10 = 1;
  var_11 = 6;
  var_12 = 14;
  var_13 = 3;
  var_14 = _id_0366::snd_get_curr_combat_cue_name();
  wait 1;

  for(;;) {
    var_15 = gettime() - var_4;
    var_16 = var_0 _id_0366::_id_8E14();
    var_17 = var_0.origin != var_9;
    var_9 = var_0.origin;
    var_18 = var_2;

    if(var_0 _id_0366::snd_zmb_plr_is_in_thick_fog())
      var_18 = var_18 * 2;

    if(var_17) {
      if(!var_8) {
        var_8 = 1;
        var_7 = var_15;
      }
    } else if(var_8) {
      var_8 = 0;
      var_6 = var_15;
    }

    if(!var_17 && var_15 - var_6 > var_18 && var_16 <= var_3 && var_10) {
      var_10 = 0;
      _id_0366::_id_8E32(var_12);
    } else if(!var_10 && (var_17 || var_16 > var_3 && var_15 - var_7 > var_18 * 0.5)) {
      var_10 = 1;
      _id_0366::_id_8E31(var_14, var_11);
    } else if(var_10 && var_15 - var_5 > var_1) {
      var_5 = var_15;
      var_14 = var_0 _id_0366::_id_8D46();
      var_0 _id_0366::_id_8DCF(var_14);
      _id_0366::_id_8E32(var_12);
      wait 0.1;
      _id_0366::_id_8E31(var_14, var_13);
    }

    wait 0.5;
  }
}

begin_intro_assault() {
  level._id_11CB.intro_assault_executing = 1;
}

end_intro_assault() {
  level._id_11CB.intro_assault_executing = undefined;

  foreach(var_1 in level.players) {
    var_1 _id_0366::_id_8E4E();
    var_1 _id_A97A();
  }
}

_id_5196() {
  var_0 = "conv_startbeach";
  var_1 = [];
  var_1["primary"]["mari"] = ["startbeach_both", 1.0];
  var_1["primary"]["jeff"] = ["startbeach_both", 1.0];
  var_1["primary"]["oliv"] = ["startbeach_both", 1.0];
  var_1["primary"]["dros"] = ["startbeach_both", 1.0];
  var_1["secondary"]["mari"] = ["startbeach_both", 1.0];
  var_1["secondary"]["jeff"] = ["startbeach_both", 1.0];
  var_1["secondary"]["oliv"] = ["startbeach_both", 1.0];
  var_1["secondary"]["dros"] = ["startbeach_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_mg42look";
  var_1 = [];
  var_1["primary"]["mari"] = ["mg42look_both", 1.0];
  var_1["primary"]["jeff"] = ["mg42look_both", 1.0];
  var_1["primary"]["oliv"] = ["mg42look_both", 1.0];
  var_1["primary"]["dros"] = ["mg42look_both", 1.0];
  var_1["secondary"]["mari"] = ["mg42look_both", 1.0];
  var_1["secondary"]["jeff"] = ["mg42look_both", 1.0];
  var_1["secondary"]["oliv"] = ["mg42look_both", 1.0];
  var_1["secondary"]["dros"] = ["mg42look_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_mg42nag";
  var_1 = [];
  var_1["primary"]["mari"] = ["mg42nag__both", 1.0];
  var_1["primary"]["jeff"] = ["mg42nag__both", 1.0];
  var_1["primary"]["oliv"] = ["mg42nag__both", 1.0];
  var_1["primary"]["dros"] = ["mg42nag__both", 1.0];
  var_1["secondary"]["mari"] = ["mg42nag__both", 1.0];
  var_1["secondary"]["jeff"] = ["mg42nag__both", 1.0];
  var_1["secondary"]["oliv"] = ["mg42nag__both", 1.0];
  var_1["secondary"]["dros"] = ["mg42nag__both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_beachover";
  var_1 = [];
  var_1["primary"]["mari"] = ["beachover_both", 1.0];
  var_1["primary"]["jeff"] = ["beachover_both", 1.0];
  var_1["primary"]["oliv"] = ["beachover_both", 1.0];
  var_1["primary"]["dros"] = ["beachover_both", 1.0];
  var_1["secondary"]["mari"] = ["beachover_both", 1.0];
  var_1["secondary"]["jeff"] = ["beachover_both", 1.0];
  var_1["secondary"]["oliv"] = ["beachover_both", 1.0];
  var_1["secondary"]["dros"] = ["beachover_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_followpath";
  var_1 = [];
  var_1["primary"]["mari"] = ["followpath_both", 1.0];
  var_1["primary"]["jeff"] = ["followpath_both", 1.0];
  var_1["primary"]["oliv"] = ["followpath_both", 1.0];
  var_1["primary"]["dros"] = ["followpath_both", 1.0];
  var_1["secondary"]["mari"] = ["followpath_both", 1.0];
  var_1["secondary"]["jeff"] = ["followpath_both", 1.0];
  var_1["secondary"]["oliv"] = ["followpath_both", 1.0];
  var_1["secondary"]["dros"] = ["followpath_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_bloodtrailtwo";
  var_1 = [];
  var_1["primary"]["mari"] = ["bloodtrailtwo_both", 1.0];
  var_1["primary"]["jeff"] = ["bloodtrailtwo_both", 1.0];
  var_1["primary"]["oliv"] = ["bloodtrailtwo_both", 1.0];
  var_1["primary"]["dros"] = ["bloodtrailtwo_both", 1.0];
  var_1["secondary"]["mari"] = ["bloodtrailtwo_both", 1.0];
  var_1["secondary"]["jeff"] = ["bloodtrailtwo_both", 1.0];
  var_1["secondary"]["oliv"] = ["bloodtrailtwo_both", 1.0];
  var_1["secondary"]["dros"] = ["bloodtrailtwo_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_bloodtrailfollow";
  var_1 = [];
  var_1["primary"]["mari"] = ["bloodtrailfollow_both", 1.0];
  var_1["primary"]["jeff"] = ["bloodtrailfollow_both", 1.0];
  var_1["primary"]["oliv"] = ["bloodtrailfollow_both", 1.0];
  var_1["primary"]["dros"] = ["bloodtrailfollow_both", 1.0];
  var_1["secondary"]["mari"] = ["bloodtrailfollow_both", 1.0];
  var_1["secondary"]["jeff"] = ["bloodtrailfollow_both", 1.0];
  var_1["secondary"]["oliv"] = ["bloodtrailfollow_both", 1.0];
  var_1["secondary"]["dros"] = ["bloodtrailfollow_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_rippedapart";
  var_1 = [];
  var_1["primary"]["mari"] = ["rippedapart_both", 1.0];
  var_1["primary"]["jeff"] = ["rippedapart_both", 1.0];
  var_1["primary"]["oliv"] = ["rippedapart_both", 1.0];
  var_1["primary"]["dros"] = ["rippedapart_both", 1.0];
  var_1["secondary"]["mari"] = ["rippedapart_both", 1.0];
  var_1["secondary"]["jeff"] = ["rippedapart_both", 1.0];
  var_1["secondary"]["oliv"] = ["rippedapart_both", 1.0];
  var_1["secondary"]["dros"] = ["rippedapart_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
}

_id_5C22() {
  thread _id_35E1();
}

_id_35E1() {
  wait 0.5;
  thread ocean_waves_oneshots();
  thread waves_splash_on_rocks();
  _id_0380::_id_6842("zmb_isl_beach_ocean_close", undefined, (358, 1751, 45));
  _id_0380::_id_6842("zmb_hvac_rattle_lp_03", undefined, (922, 4466, 518));
  _id_0380::_id_6842("zmb_hvac_rattle_lp_01", undefined, (1974, 4869, 518));
  _id_0380::_id_6842("zmb_hvac_rattle_lp_02", undefined, (1538, 4475, 518));
  _id_0380::_id_6842("zmb_steam_exhaust_lp", undefined, (2275, 4518, 241));
  _id_0380::_id_6842("zmb_steam_exhaust_lp", undefined, (2378, 4725, 241));
  _id_0380::_id_6842("zmb_steam_exhaust_lp", undefined, (2499, 4198, 364));
  _id_0380::_id_6842("zmb_freezer_fan_lp", undefined, (1330, 3839, 466));
  _id_0380::_id_6842("zmb_isla_subpen_submarine_drips_lp", undefined, (1745, 4670, 375));
}

ocean_waves_oneshots() {
  level endon("death");

  for(;;) {
    _id_0380::_id_2889("isl_waves_ocean", undefined, (358, 1751, 45));
    wait(_randomintrange(5, 8));
  }
}

waves_splash_on_rocks() {
  level endon("death");

  for(;;) {
    _id_0380::_id_2889("zmb_splash_on_rock", undefined, (983, 2284, 107));
    wait(_randomintrange(8, 12));
  }
}

_id_1CC1() {
  foreach(var_1 in level.players)
  var_1 clientaddsoundsubmix("brute_intro", 2.0);

  _id_0366::_id_8E33(3);
  _id_0380::_id_6840("zmb_mus_brute_intro");
}

_id_1CC2() {
  foreach(var_1 in level.players) {
    var_2 = 0.0;
    var_3 = 1.0;
    var_4 = "zmb_mus_wave_04";
    var_1 _id_0366::_id_8E31(var_4, var_2, var_3);
    var_1 clientclearsoundsubmix("brute_intro", 0.1);
  }
}

snd_zmb_fog_assassin_vox() {
  waitframe();

  foreach(var_1 in level.players)
  var_1 thread ambient_assassin_vox_watcher();
}

ambient_assassin_vox_watcher() {
  level endon("aud_fog_lifted");
  var_0 = self;
  level._id_11CB.amb_assassin_clicks = undefined;
  var_1 = _randomintrange(10, 18);
  var_2 = 1000;

  for(;;) {
    if(common_scripts\utility::_id_562E(self.isinfogzone)) {
      var_3 = 1;
      var_4 = _id_0366::_id_8E1A();

      foreach(var_6 in var_4) {
        var_7 = var_6._id_0A4B;
        var_8 = distance(var_6.origin, var_0.origin);

        if(isDefined(var_7) && var_7 == "zombie_assassin" && var_8 < var_2 || isDefined(level._id_11CB.amb_assassin_clicks)) {
          var_3 = 0;
          break;
        }
      }

      if(var_3) {
        var_10 = var_0.origin + (_randomintrange(150, 250), _randomintrange(150, 250), var_0.origin[2]);
        level._id_11CB.amb_assassin_clicks = _id_0380::_id_2889("zvox_ass_dist_clicks", undefined, var_10);
        wait(var_1);
        level._id_11CB.amb_assassin_clicks = undefined;
      }
    }

    wait 0.2;
  }
}

aud_fog_rolling_in() {
  var_0 = self;
  wait 2;

  if(var_0.current_volume_is_interior)
    _id_0380::_id_6840("zmb_indoor_fog_rolling_in", var_0);
  else
    _id_0380::_id_6840("zmb_fog_rolling_in", var_0);
}

aud_fog_rolling_out() {
  var_0 = self;

  if(var_0.current_volume_is_interior)
    _id_0380::_id_6840("zmb_indoor_fog_rolling_out", var_0);
  else
    _id_0380::_id_6840("zmb_fog_rolling_out", var_0);
}

aud_fog_lifted() {
  level notify("aud_fog_lifted");
}

aud_scare_off_crows() {
  _id_0380::_id_6844("zmb_crow_chains", undefined, self);
}

fog_music_mix_monitor() {
  var_0 = self;
  var_1 = 5;
  var_2 = _id_0366::snd_zmb_plr_is_in_thick_fog();

  if(var_2)
    var_0 clientaddsoundsubmix("fog_music_mix");
  else
    var_0 clientaddsoundsubmix("no_fog_music_mix");

  var_3 = var_2;

  for(;;) {
    var_2 = _id_0366::snd_zmb_plr_is_in_thick_fog();

    if(var_2 && !var_3) {
      var_0 clientaddsoundsubmix("fog_music_mix", var_1);
      var_0 clientclearsoundsubmix("no_fog_music_mix", var_1);
    } else if(!var_2 && var_3) {
      var_0 clientclearsoundsubmix("fog_music_mix", var_1);
      var_0 clientaddsoundsubmix("no_fog_music_mix", var_1);
    }

    var_3 = var_2;
    wait 1.5;
  }
}

_id_8E8F() {
  self endon("disconnect");
  var_0 = 0.5;
  var_1 = 1;
  var_2 = 1.0;

  for(;;) {
    var_3 = !self.current_volume_is_interior;

    if(!isDefined(self)) {
      break;
    }

    if(var_3 != var_1) {
      if(var_3)
        self clientclearsoundsubmix("pa_inside", 1.0);
      else
        self clientaddsoundsubmix("pa_inside", 1.0);

      var_1 = var_3;
    }

    wait(var_0);
  }
}

mine_cart_lever() {
  var_0 = self;
  _id_0380::_id_288B("zmb_mine_cart_lever", undefined, var_0);
}

mine_cart_transportation(var_0) {
  switch (var_0) {
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

cart_begin_leave(var_0) {
  _id_0380::_id_288B("zmb_mine_cart_start", undefined, var_0);
}

cart_begin_roundabout(var_0) {
  level._id_11CB.mine_cart_lp_handle = _id_0380::_id_6844("zmb_mine_cart_lp", undefined, var_0, 2.0);
}

cart_begin_arrival(var_0) {
  if(!isDefined(level._id_11CB.mine_cart_lp_handle)) {
    level._id_11CB.mine_cart_lp_handle = _id_0380::_id_6844("zmb_mine_cart_lp", undefined, var_0);
    wait 0.1;
    _id_0380::_id_6850(level._id_11CB.mine_cart_lp_handle, 3.4);
    level._id_11CB.mine_cart_lp_handle = undefined;
    wait 0.6;
    _id_0380::_id_288B("zmb_mine_cart_end", undefined, var_0);
  } else {
    _id_0380::_id_6850(level._id_11CB.mine_cart_lp_handle, 3.5);
    level._id_11CB.mine_cart_lp_handle = undefined;
    wait 0.7;
    _id_0380::_id_288B("zmb_mine_cart_end", undefined, var_0);
  }
}

mine_cart_gate_closing() {
  var_0 = self;
  _id_0380::_id_288B("zmb_mine_cart_gate_close", undefined, var_0);
}

mine_cart_gate_opening() {
  var_0 = self;
  _id_0380::_id_288B("zmb_mine_cart_gate_open", undefined, var_0);
}

sub_pen_floor_trap_warning_fire() {
  var_0 = self;
  _id_0380::_id_6844("floor_panel_warning_fire", undefined, var_0);
}

sub_pen_floor_trap_pyro_flame() {
  var_0 = self;
  _id_0380::_id_6844("floor_panel_pyro_flame", undefined, var_0);
  _id_0380::_id_6844("floor_panel_heated_metal", undefined, var_0);
}

sub_pen_floor_trap_decaying_fire() {
  var_0 = self;
  _id_0380::_id_6844("floor_panel_decaying_fire", undefined, var_0, 1.5);
}

sub_pen_prop_trap_start() {
  var_0 = self;
  wait 1.0;
  _id_0380::_id_288B("zmb_trap_sub_start", undefined, var_0);
  wait 2.0;
  level._id_11CB.sub_trap_loop_handle = _id_0380::_id_6844("zmb_trap_sub_lp", undefined, var_0, 2.5);
}

sub_pen_prop_trap_extend() {
  var_0 = self;
  _id_0380::_id_288B("zmb_trap_sub_extend", undefined, var_0);
}

sub_pen_prop_trap_stop() {
  var_0 = self;
  _id_0380::_id_6850(level._id_11CB.sub_trap_loop_handle, 1.0);
  level._id_11CB.sub_trap_loop_handle = undefined;
  wait 0.5;
  _id_0380::_id_288B("zmb_trap_sub_stop", undefined, var_0);
}

sub_pen_prop_trap_hit(var_0) {
  _id_0380::_id_2889("zmb_trap_sub_hit", undefined, var_0);
}

sub_pen_prop_trap_player_hit(var_0) {
  _id_0380::_id_2888("zmb_hit", var_0);
}

_id_3FE4(var_0, var_1) {
  var_2 = self;
  var_3 = var_2 getentitynumber();

  if(!isDefined(level._id_11CB._id_A28E))
    level._id_11CB._id_A28E = [];

  var_4 = level._id_11CB._id_A28E[var_3];

  if(!isDefined(var_4)) {
    var_4 = spawnStruct();
    level._id_11CB._id_A28E[var_3] = var_4;
  }

  switch (var_0) {
    case "start_opening":
      if(var_1) {
        var_5 = var_2.origin + (0, 0, 100);
        var_4._id_3FE3 = _id_0380::_id_6842("zmb_valve_gas_flow_lp", undefined, var_5);
        _id_0380::_id_684E(var_4._id_3FE3, 0, 0);
      }

      _id_046C::_id_8DA0("zmb_valve_start_unlock", var_2.origin);
      break;
    case "opening":
      if(isDefined(var_4._id_9E98))
        _func_352(var_4._id_9E98, 0.1);

      var_4._id_9E98 = _func_351("zmb_valve_opening_lp", var_2, undefined, undefined, undefined, "hard");

      if(var_1)
        _id_0380::_id_684E(var_4._id_3FE3, 1, self._id_A29D);

      break;
    case "closing":
      if(isDefined(var_4._id_9E98))
        _func_352(var_4._id_9E98, 0.1);

      var_4._id_9E98 = _func_351("zmb_valve_closing_lp", var_2, undefined, undefined, undefined, "hard");

      if(var_1)
        _id_0380::_id_684E(var_4._id_3FE3, 0, self._id_A29D);

      break;
    case "open":
      _id_046C::_id_8DA0("zmb_valve_open", var_2.origin);

      if(var_1)
        _id_0380::_id_684E(var_4._id_3FE3, 0.666, 2.0);

      _func_352(var_4._id_9E98, 0.1);
      break;
    case "closed":
      _id_046C::_id_8DA0("zmb_valve_stop_lock", var_2.origin);

      if(isDefined(var_4._id_9E98))
        _func_352(var_4._id_9E98, 0.1);

      if(isDefined(var_4._id_3FE3)) {
        _id_0380::_id_6850(var_4._id_3FE3, 0.1);
        var_4._id_3FE3 = undefined;
      }

      break;
  }
}

_id_ABF8(var_0, var_1) {
  var_2 = spawn("script_origin", var_0);
  var_3 = 0;
  var_4 = 0.875;
  _id_0380::_id_288B("zombie_soul_suck", undefined, var_2, 0, var_4);
  var_2 moveto(var_1, 1.9);
  wait 2.0;
  var_2 delete();
}

_id_ABF9(var_0) {
  _id_0380::_id_2889("zombie_soul_suck_threshold", undefined, var_0);
}

start_corpse_gate_alarm() {
  var_0 = (1622, 4461, 41);
  level._id_11CB.corpse_gate_alarm_ent = undefined;

  while(!common_scripts\utility::_id_3C77("flag_subpen_traps_completed") && !common_scripts\utility::_id_562E(level.stop_final_boss_fire_alarm)) {
    level._id_11CB.corpse_gate_alarm_ent = _id_0380::_id_2889("zmb_corpse_gate_alarm", undefined, var_0);
    wait 5.5;
    level._id_11CB.corpse_gate_alarm_ent = undefined;
    waitframe();
  }
}

stop_corpse_gate_alarm() {
  if(isDefined(level._id_11CB.corpse_gate_alarm_ent)) {
    _id_0380::_stoplocalsound(level._id_11CB.corpse_gate_alarm_ent, 1.5);
    level._id_11CB.corpse_gate_alarm_ent = undefined;
  }
}

corpse_gate_open() {
  var_0 = self;
  _id_0380::_id_2889("zmb_corpse_gate", undefined, var_0.origin);
}

isla_fireman_intro() {
  var_0 = self;
  _id_0380::_id_6844("zmb_isla_fireman_intro_jump_land", undefined, var_0);
}

fire_panel_turn_off() {
  var_0 = self;
  _id_0380::_id_288B("steam_bursts", undefined, var_0);
  _id_0380::_id_288B("zmb_isla_fire_panel_turn_off", undefined, var_0);
  _id_0380::_id_6850(var_0.panel_handle, 0.5);
}

fire_panel_turn_on() {
  var_0 = self;
  var_0.panel_handle = _id_0380::_id_6844("zmb_isla_fire_panel_flame_lp", undefined, var_0);
  _id_0380::_id_684F(var_0.panel_handle, 0.5, "flag_subpen_traps_completed");
}

plane_mission_start() {
  level endon("stop_plane_int_submix");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1.current_volume_is_interior) {
        var_1 clientaddsoundsubmix("isl_plane_interior_mix");
        continue;
      }

      var_1 clientclearsoundsubmix("isl_plane_interior_mix");
    }

    wait 0.2;
  }
}

plane_spawn() {
  common_scripts\utility::flag_init("aud_last_plane_spawned");
  var_0 = self;

  foreach(var_2 in level.players)
  var_2 thread plane_spawn_watcher(var_0);
}

plane_spawn_watcher(var_0) {
  var_0 endon("death");
  var_1 = self;

  while(1 && isDefined(var_0)) {
    var_2 = distance(var_0.origin, var_1.origin);

    if(var_2 <= 8000) {
      var_3 = _id_0380::_id_288B("plane_flyby", undefined, var_0);
      _id_0380::_id_288F(var_3, var_0, "plane_sound_done");
      var_0 waittill("plane_sound_done");
    }

    wait 0.3;
  }
}

plane_firing() {
  self endon("death");
  var_0 = self;

  while(common_scripts\utility::_id_3794("turret_on")) {
    _id_0380::_id_288B("veh_stuka_mg_shot", undefined, var_0);
    wait 0.1;
  }
}

plane_damage_player() {
  var_0 = self;
  _id_0380::_id_2888("bullet_large_flesh_plr");

  if(_id_0378::_id_8D1B(0.3)) {
    wait 0.1;
    var_1 = var_0.origin + (_randomintrange(25, 50), _randomintrange(25, 50), var_0.origin[2]);
    _id_0380::_id_2889("whizby_near", undefined, var_0.origin);
  }
}

plane_tailspin() {
  self endon("death");
  var_0 = self;

  if(!common_scripts\utility::_id_3C77("aud_last_plane_spawned"))
    _id_0380::_id_288D("plane_destruct_death_pop", undefined, var_0, undefined, undefined, 0.1);
  else
    _id_0380::_id_288D("last_plane_crash_flyby_main", undefined, var_0, undefined, undefined, 0.1);
}

plane_explode(var_0) {
  _id_0380::_id_2889("plane_destruct_exp_close", undefined, var_0);
}

last_plane_spawn() {
  var_0 = self;

  foreach(var_2 in level.players)
  var_2 thread last_plane_spawn_watcher(var_0);
}

last_plane_spawn_watcher(var_0) {
  var_0 endon("death");
  var_1 = self;

  for(;;) {
    var_2 = distance(var_0.origin, var_1.origin);

    if(var_2 <= 12500) {
      common_scripts\utility::flag_set("aud_last_plane_spawned");
      level._id_11CB.last_play_flyby_snd = _id_0380::_id_288B("last_plane_flyby", undefined, var_0);
      _id_0380::_id_288F(level._id_11CB.last_play_flyby_snd, var_0, "last_plane_sound_done");
      var_0 waittill("last_plane_sound_done");
    }

    wait 0.3;
  }
}

last_plane_crash(var_0) {
  common_scripts\utility::_id_3C7B("aud_last_plane_spawned");
  _id_0380::_stoplocalsound(level._id_11CB.last_play_flyby_snd, 0.1);
  _id_0380::_id_2889("last_plane_crash_explode_main", undefined, var_0);
  level notify("stop_plane_int_submix");

  foreach(var_2 in level.players)
  var_2 clientclearsoundsubmix("isl_plane_interior_mix");
}

dist_artillery_shot() {
  var_0 = self;
  _id_0380::_id_288B("zmb_ship_dist_artillery", undefined, var_0);
}

dist_ship_artillery_inc() {
  var_0 = self;
  _id_0380::_id_288B("zmb_ship_artillery_inc", undefined, var_0);
  wait 2.7;

  if(isDefined(var_0))
    _id_0380::_id_288B("zmb_ship_artillery_inc_whizby", undefined, var_0);
}

dist_ship_artillery_impact() {
  var_0 = self;
  _id_0380::_id_288B("zmb_ship_mortar_exp", undefined, var_0);
}

distant_ship_explode() {
  _id_0380::_id_288B("zmb_ship_destruct_explode", undefined, self);
}

distant_water_explode() {
  _id_0380::_id_288B("zmb_ship_destruct_water_explode", undefined, self);
}

artillery_battery_placed() {
  var_0 = (-13, 3572, 1049);
  _id_0380::_id_2889("zmb_artillery_battery_placement", undefined, var_0);
  level._id_11CB.artillery_battery_placed = 1;
}

artillery_valve_vert_turn() {
  var_0 = (396, 3245, 1033);
  _id_0380::_id_2889("zmb_artillery_valve_open", undefined, var_0);
}

artillery_valve_vert_no_turn() {
  var_0 = (396, 3245, 1033);
  _id_0380::_id_2889("zmb_artillery_valve_stop_lock", undefined, var_0);
}

artillery_valve_hor_turn() {
  var_0 = (141, 3259, 1036);
  _id_0380::_id_2889("zmb_artillery_valve_open", undefined, var_0);
}

artillery_valve_hor_no_turn() {
  var_0 = (141, 3259, 1036);
  _id_0380::_id_2889("zmb_artillery_valve_stop_lock", undefined, var_0);
}

artillery_power_filled() {
  waitframe();
  var_0 = (285, 3469, 1153);

  if(level._id_11CB.artillery_battery_placed)
    level._id_11CB.artillery_battery_placed = 0;
  else
    _id_0380::_id_2889("zmb_artillery_charged_up", undefined, var_0);
}

artillery_power_depleted() {
  var_0 = (285, 3469, 1153);
  _id_0380::_id_2889("zmb_artillery_charged_down", undefined, var_0);
}

artillery_cannon_shot(var_0) {
  var_1 = (285, 3469, 1153);
  _id_0380::_id_2889("zmb_artillery_cannon_shot", undefined, var_0);
  wait 1.5;
  _id_0380::_id_2889("zmb_artillery_room_shake", undefined, var_1);
}

flak_gun_gate_up() {
  var_0 = self;
  _id_0380::_id_288B("zmb_flak_gun_gate_up", undefined, var_0);
}

flak_gun_gate_down() {
  var_0 = self;
  _id_0380::_id_288B("zmb_flak_gun_gate_down", undefined, var_0);
}

artillery_bunker_trap_spikes(var_0) {
  _id_0380::_id_2889("trap_spikes_start", undefined, var_0);
  wait 0.3;
  var_1 = 0;

  while(var_1 <= 32) {
    _id_0380::_id_2889("floor_spike_trap", undefined, var_0);
    var_1++;
    wait 0.6;
  }

  _id_0380::_id_2889("trap_spikes_end", undefined, var_0);
}

radio_tower_artillery_shot() {
  var_0 = self;
  _id_0380::_id_288B("zmb_ship_dist_artillery", undefined, var_0);
}

radio_tower_incoming_mortar() {
  var_0 = self;
  wait 0.3;
  _id_0380::_id_288B("zmb_ship_artillery_inc", undefined, var_0);
  wait 2.7;

  if(isDefined(var_0))
    _id_0380::_id_288B("zmb_ship_artillery_inc_whizby", undefined, var_0);
}

radio_tower_mortar_impact() {
  var_0 = self;
  _id_0380::_id_288B("zmb_ship_mortar_exp", undefined, var_0);
}

radio_tower_explosion(var_0) {
  _id_0380::_id_2889("zmb_radio_tower_explosion", undefined, var_0);
  _id_0380::_id_2889("zmb_radio_tower_fall", undefined, var_0);
  _id_0380::_id_2889("zmb_radio_tower_fall_impacts", undefined, var_0);
  _id_0380::_id_2889("zmb_radio_tower_fall_sparks", undefined, var_0);
}

pap_schell_insert() {
  var_0 = self;
  _id_0380::_id_288B("zmb_island_pap_schell_insert", undefined, var_0);
  _id_0380::_id_288B("zmb_island_pap_schell_insert_elec", undefined, var_0);
}

pap_schell_insert_final() {
  var_0 = self;
  _id_0380::_id_288B("zmb_island_pap_schell_insert", undefined, var_0);
  _id_0380::_id_288B("zmb_island_pap_machine_react", undefined, var_0);
}

pap_elevator_move() {
  var_0 = self;
  _id_0380::_id_288B("zmb_island_pap_elevator_move", undefined, var_0);
}

pap_elevator_door_open() {
  var_0 = self;
  _id_0380::_id_288B("zmb_island_pap_elev_door_open", undefined, var_0);
}

pagen_door_place_stone() {
  var_0 = self;
  _id_0380::_id_288B("zmb_pagen_door_place_stone", undefined, var_0);
}

pagen_door_opened() {
  var_0 = self;
  wait 1.0;
  _id_0380::_id_288B("zmb_pagen_door_opened", undefined, var_0);
}

pagen_door_closing() {
  var_0 = self;
  _id_0380::_id_288B("zmb_pagen_door_closing", undefined, var_0);
  wait 2.5;
  _id_0380::_id_288B("zmb_pagen_door_closing_stop", undefined, var_0);
  wait 0.5;
  _id_0380::_id_288B("zmb_pagen_door_closed", undefined, var_0);
}

pagen_room_flush_begin() {
  var_0 = self;
  _id_0380::_id_288B("zmb_pagen_room_flush_main", undefined, var_0);
}

pagen_room_flush_end() {
  var_0 = self;
  _id_0380::_id_288B("zmb_pagen_room_flush_splash", undefined, var_0);
  _id_0380::_id_288B("zmb_pagen_room_flush_foley", undefined, var_0);
}

assassin_hc_cry() {
  var_0 = self;
  _id_0380::_id_288B("zmb_island_hc_assassin_cry", undefined, var_0);
}

ripsaw_collect_gun_chassis(var_0) {
  _id_0380::_id_2889("zmb_ripsaw_obtain_chassis", undefined, var_0);
}

ripsaw_collect_saw_blade(var_0) {
  _id_0380::_id_2889("zmb_ripsaw_obtain_sawblade", undefined, var_0);
}

ripsaw_insert_chassis() {
  var_0 = self;
  _id_0380::_id_288B("zmb_ripsaw_insert_chassis", undefined, var_0);
}

ripsaw_insert_sawblade() {
  var_0 = self;
  _id_0380::_id_288B("zmb_ripsaw_insert_sawblade", undefined, var_0);
}

ripsaw_insert_charged_spine() {
  var_0 = self;
  _id_0380::_id_288B("zmb_ripsaw_insert_spine_case", undefined, var_0);
}

ripsaw_weapon_build_infusion(var_0) {
  _id_0380::_id_2889("zmb_ripsaw_build_infusion", undefined, var_0);
}

ripsaw_charge() {
  var_0 = self;
  _id_0380::_id_288B("zmb_ripsaw_charge", undefined, var_0);
}

charged_ripsaw_hit_pest() {
  var_0 = self;
  _id_0380::_id_288B("zmb_ripsaw_charged_impact", undefined, var_0);
}

corpse_gate_talk(var_0) {
  var_1 = self._id_00B9;

  if(!isDefined(var_0)) {
    return;
  }
  var_2 = undefined;

  switch (var_0) {
    case "awake":
      var_2 = "zmb_isla_cgo_uhuhwasistdennhierlos";
      break;
    case "alarm":
      var_2 = common_scripts\utility::random(["zmb_isla_cgo_wobinichfeindehieralarmal", "zmb_isla_cgo_brenntihrbastardebrennt"]);
    case "beg":
      var_2 = common_scripts\utility::random(["zmb_isla_cgo_waitwaitiamonyourside", "zmb_isla_cgo_iwashelpingyou", "zmb_isla_cgo_pleasedontdothis", "zmb_isla_cgo_bittemachtdasnicht", "zmb_isla_cgo_bittebittebefreitmichvond", "zmb_isla_cgo_wartetwartetichbinaufeure", "zmb_isla_cgo_ichhabeuchdochgeholfen"]);
      break;
    case "talk":
      var_2 = common_scripts\utility::random(["zmb_isla_cgo_soundsofweepingifearthati", "zmb_isla_cgo_thisisredridinghoodwithaf", "zmb_isla_cgo_contdevennowhecarriestheh", "zmb_isla_cgo_angrybreathinghehasremove", "zmb_isla_cgo_iamnotsurewhetherishouldc", "zmb_isla_cgo_hisrecentexperimentswithr", "zmb_isla_cgo_contdandstraubwellheisfur", "zmb_isla_cgo_ravencrownthisisredriding", "zmb_isla_cgo_ravencrowistillhavenothea", "zmb_isla_cgo_youmustknowsinceourlastco", "zmb_isla_cgo_nervousisthisworkingtapta"]);
      break;
    case "scream":
      var_2 = common_scripts\utility::random(["zmb_isla_cgo_aaaaaaaaaaaaaaarrrgh", "zmb_isla_cgo_neinneinaaaargh"]);
      break;
  }

  if(isDefined(var_2))
    corpse_gate_german_dialogue(var_2);
}

corpse_gate_german_dialogue(var_0) {
  if(common_scripts\utility::_id_562E(self.is_opened) || !isDefined(self._id_00B9)) {
    return;
  }
  while(common_scripts\utility::_id_562E(self._id_00B9.is_speaking))
    waitframe();

  self._id_00B9.is_speaking = 1;
  var_1 = self._id_00B9;
  var_1.head_talk_snd = _id_0380::_id_288B(var_0, undefined, var_1);
  _id_0380::_id_288F(var_1.head_talk_snd, var_1, "head_dialogue_done");
  var_1 waittill("head_dialogue_done");
  self._id_00B9.is_speaking = 0;
}

pagan_head_place(var_0, var_1) {
  switch (var_1) {
    case "flag_anointed_monk_head_placed":
      _id_0380::_id_6850(level._id_11CB.pagan_tone_handle, 0.5);
      _id_0380::_id_6844("pagan_head_place_01", undefined, var_0);
      wait 1.0;
      level._id_11CB.pagan_tone_handle = _id_0380::_id_6844("pagan_head_place_tone_01", undefined, var_0);
      break;
    case "flag_anointed_fol_head_placed":
      _id_0380::_id_6850(level._id_11CB.pagan_tone_handle, 0.5);
      _id_0380::_id_6844("pagan_head_place_02", undefined, var_0);
      wait 1.0;
      level._id_11CB.pagan_tone_handle = _id_0380::_id_6844("pagan_head_place_tone_02", undefined, var_0);
      break;
    case "flag_anointed_asn_head_placed":
      _id_0380::_id_6850(level._id_11CB.pagan_tone_handle, 0.5);
      _id_0380::_id_6844("pagan_head_place_03", undefined, var_0);
      wait 1.0;
      level._id_11CB.pagan_tone_handle = _id_0380::_id_6844("pagan_head_place_tone_03", undefined, var_0);
      break;
    case "flag_anointed_pest_head_placed":
      _id_0380::_id_6850(level._id_11CB.pagan_tone_handle, 0.5);
      _id_0380::_id_6844("pagan_head_place_04", undefined, var_0);
      wait 1.0;
      level._id_11CB.pagan_tone_handle = _id_0380::_id_6844("pagan_head_place_tone_04", undefined, var_0);
      break;
    default:
      break;
  }
}

pagan_room_earthquake(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(distance(var_4.origin, var_2) < 500)
      var_4 clientaddsoundsubmix("paganearthquake");
  }

  switch (var_0) {
    case "rumble":
      if(!isDefined(level._id_11CB.paganearthquake_rumble_handle)) {
        var_6 = var_1;
        var_7 = 2.5;
        _id_0366::_id_8E30(0.75, var_6);
        level._id_11CB.paganearthquake_rumble_handle = _id_0380::_id_6842("zmb_isla_earthquake_rumble_lp", undefined, var_2, var_6);
      }

      break;
    case "earthquake":
      if(!isDefined(level._id_11CB.paganearthquake_quake_handle)) {
        var_6 = 0.25;
        var_7 = var_1 * 0.5 * 0.95;
        _id_0366::_id_8E30(0.25, var_6);
        level._id_11CB.paganearthquake_quake_handle = _id_0380::_id_6842("zmb_isla_earthquake_lp", undefined, var_2, var_6);
        wait(var_1 * 0.5);
        _id_0380::_id_6842("zmb_isla_earthquake_settle", undefined, var_2, var_6);
        pagan_room_earthquake_stop(var_7);
      }

      break;
  }
}

pagan_room_earthquake_stop(var_0) {
  _id_0366::_id_8E30(1.0, var_0);

  foreach(var_2 in level.players)
  var_2 clientclearsoundsubmix("paganearthquake");

  if(isDefined(level._id_11CB.paganearthquake_rumble_handle))
    _id_0380::_id_6850(level._id_11CB.paganearthquake_rumble_handle, var_0);

  if(isDefined(level._id_11CB.zone1earthquake_quake_handle))
    _id_0380::_id_6850(level._id_11CB.zone1earthquake_quake_handle, var_0);

  level._id_11CB.paganearthquake_rumble_handle = undefined;
  level._id_11CB.paganearthquake_quake_handle = undefined;
}

pommel_skull_destroyed(var_0) {
  _id_0380::_id_288B("zmb_pommel_skull_destroy", undefined, var_0);
}

pommel_pickup() {
  var_0 = self;
  var_1 = var_0.origin;
  var_2 = _id_0380::_id_6844("zmb_pommel_energy_lp", undefined, var_0, 1.5);
  level waittill("aud_stop_pommel_energy_loop");
  _id_0380::_id_6850(var_2);
  var_2 = undefined;
  _id_0380::_id_2889("zmb_pommel_pick_up", undefined, var_1);
}

freezer_crane_retrieving() {
  var_0 = self;
  var_1 = self.origin;
  _id_0380::_id_288B("zmb_freezer_crane_start", undefined, var_0);
  _id_0380::_id_2889("zmb_freezer_crane_movement", undefined, var_1);
  wait 11.415;
  _id_0380::_id_2889("zmb_freezer_crane_retrieve", undefined, var_1);
  wait 12.7;
  _id_0380::_id_288B("zmb_freezer_crane_end", undefined, var_0);
}

nazi_head_roll() {
  var_0 = self;
  var_1 = var_0.origin;
  _id_0380::_id_2889("zmb_nazi_head_roll", undefined, var_1);
  _id_0380::_id_2889("zmb_nazi_head_blood_splat", undefined, var_1);
}

radio_part_drops() {
  var_0 = self;
  wait 0.8;
  _id_0380::_id_288B("zmb_radio_part_drops", undefined, var_0);
}

radio_parts_assemble() {
  var_0 = self;
  _id_0380::_id_288B("zmb_radio_part_assemble", undefined, var_0);
}

js_corpse_becomes_zombie() {
  _id_0366::snd_not_so_simple_jump_scare();
}

js_assassin_landing() {
  _id_0366::snd_not_so_simple_jump_scare();
}

ibeam_squeak() {
  var_0 = self;
  wait 0.1;
  _id_0380::_id_288B("zmb_ibeam_squeak", undefined, var_0);
}

ibeam_complete() {
  var_0 = self;
  _id_0380::_id_288B("zmb_ibeam_stop", undefined, var_0);
}

get_random_alive_player() {
  var_0 = common_scripts\utility::array_randomize(level.players);

  foreach(var_2 in var_0) {
    if(!isalive(var_2)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_2._id_5728)) {
      continue;
    }
    return var_2;
  }

  return level.player;
}

get_closest_alive_player(var_0) {
  var_1 = common_scripts\utility::_id_40B0(var_0, level.players);

  foreach(var_3 in var_1) {
    if(!isalive(var_3)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_3._id_5728)) {
      continue;
    }
    return var_3;
  }

  return level.player;
}

get_player_looking_at(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::array_randomize(level.players);

  foreach(var_5 in var_3) {
    if(!isalive(var_5)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_5._id_5728)) {
      continue;
    }
    if(distance(var_5.origin, var_0.origin) > var_1) {
      continue;
    }
    if(!maps\mp\_utility::_id_3B8E(var_5, var_0, var_2)) {
      continue;
    }
    return var_5;
  }

  return undefined;
}

get_specific_player_for_vo(var_0) {
  foreach(var_2 in level.players) {
    if(!isalive(var_2)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_2._id_5728)) {
      continue;
    }
    var_3 = get_type_by_player_char(var_0);

    if(!_id_0547::_id_5565(var_2._id_20DA, var_3)) {
      continue;
    }
    return var_2;
  }
}

get_type_by_player_char(var_0) {
  var_1 = "offi";

  switch (var_0) {
    case "jefferson":
      var_1 = "sold";
      break;
    case "drostan":
      var_1 = "arch";
      break;
    case "marie":
      var_1 = "offi";
      break;
    case "olivia":
      var_1 = "figh";
      break;
  }

  return var_1;
}

zmb_pomel_grenade_cook() {
  var_0 = self;
  var_1 = _id_0380::_id_6844("zmb_big_pommel_energy_lp", undefined, var_0, 0.5);
  var_0 waittill("aud_stop_pomel_nade_cook");
  _id_0380::_id_6850(var_1);
  var_1 = undefined;
}

zmb_pomel_grenade_detonate(var_0) {
  _id_0380::_id_2889("wpn_pomel_grenade_detonate", undefined, var_0);
}

zmb_pomel_grenade_force_field(var_0) {
  _id_0380::_id_2889("wpn_pomel_grenade_force_field", undefined, var_0);
}

zmb_pomel_grenade_final_explosion(var_0) {
  _id_0380::_id_2889("wpn_pomel_grenade_explosion", undefined, var_0);
}

zmb_pomel_grenade_float(var_0) {
  var_1 = self;
  var_2 = _id_0380::_id_6844("zmb_pommel_energy_lp", undefined, var_1, 0.5);
  var_0 waittill("aud_stop_pommel_float_lp");
  _id_0380::_id_6850(var_2);
  var_2 = undefined;
}

zmb_pomel_grenade_retrieval() {
  var_0 = self;
  var_0 notify("aud_stop_pommel_float_lp");
  _id_0380::_id_288B("zmb_pommel_pick_up", undefined, var_0);
}