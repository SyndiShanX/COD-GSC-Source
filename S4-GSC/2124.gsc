/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2124.gsc
*************************************************/

_id_629F(var_0) {
  _id_0847::_id_DF08("explo_generic_main", var_0);
}

plane_explode(var_0) {
  _id_0847::_id_DF08("explo_plane_close_main", var_0);
  _id_0847::_id_DF08("explo_plane_distant", var_0);
}

_id_F8EB(var_0, var_1) {
  if(var_1 == "counter_spy_plane") {
    thread _id_3DA1(var_0);
  } else {
    _id_0847::_id_DF08("kstreak_uav_enter", var_0);
  }
}

_id_F8EC(var_0, var_1) {
  if(var_1 == "uav") {
    _id_0847::_id_DF08("kstreak_uav_exit", var_0);
  }
}

_id_3DA1(var_0) {
  var_0 endon("death");
  _id_0847::_id_DF08("kstreak_couterspyplane_enter", var_0);
  wait 3;
  var_1 = _id_0847::_id_DF08("kstreak_couterspyplane_loop", var_0);
  _id_0847::_id_DF24(var_1, var_0, "death");
  var_0 waittill("leaving");
  _id_0847::_id_DF08("kstreak_couterspyplane_exit", var_0);
  wait 2;
  _id_0847::_id_DF21(var_1);
}

_id_13BF() {
  _id_0847::_id_DF08("kstreak_airstrike_air_raid_siren", level._id_9AAC + (0, 0, 5000));
}

_id_13C9(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_5 == "precision_airstrike" || var_5 == "multi_airstrike") {
    var_6 = "kstreak_airstrike_plane_flyby";
  } else {
    var_6 = "kstreak_bomber_flyby";
  }

  var_7 = var_1 + var_2 * var_3;
  var_8 = scripts\engine\utility::_id_E1E9(var_1);
  var_8 moveto(var_7, var_4);
  var_9 = _id_0847::_id_DF08(var_6, var_8);
  thread airstrike_plane_explode_watcher(var_0, var_8, var_4);
  thread airstrike_death_sfx_org_watcher(var_8, var_4);
  var_0 waittill("death");
  _id_0847::_id_DF21(var_9, 0.1);
}

airstrike_plane_explode_watcher(var_0, var_1, var_2, var_3) {
  var_0 waittill("aud_plane_destruct_sequence");
  _id_0847::_id_DF08("explo_plane_death_spin_long", var_1);
  wait 1.85;
  _id_0847::_id_DF08("explo_plane_close_main", var_1.origin);
  _id_0847::_id_DF08("explo_plane_distant", var_1.origin);
}

airstrike_death_sfx_org_watcher(var_0, var_1) {
  wait(var_1 + 2);
  var_0 delete();
}

_id_E9F9(var_0, var_1) {
  var_2 = 0;
  var_3 = 0.08;
  _id_0847::_id_DF08("kstreak_strafing_run_first_shot_dist", var_0.origin);
  wait(var_3);

  while(var_2 <= var_1) {
    if(isDefined(var_0)) {
      _id_0847::_id_DF08("kstreak_strafing_run_shot_dist", var_0.origin);
      wait(var_3);
    }

    var_2++;
  }
}

bombing_run_incoming_close(var_0) {
  _id_0847::_id_DF08("kstreak_bomb_incoming_distant", var_0);
}

_id_5B63(var_0) {
  var_1 = _id_0847::_id_DF08("kstreak_firebombing_flyby", var_0);
  var_0 waittill("death");
  _id_0847::_id_DF21(var_1, 0.1);
}

_id_5B62(var_0, var_1) {
  if(isDefined(level._id_1E77)) {
    _id_0847::_id_DF08(level._id_1E77, var_0 + (0, 0, 50));

    if(level._id_1E77 == "kstreak_firebombing_explo_main") {
      var_2 = _id_0847::_id_DF08("kstreak_firebombing_fire_lrg_lp", var_0 + (0, 0, 50));
    } else {
      _id_0847::_id_DF08(level._id_1E77, var_0 + (0, 0, 50));
      var_2 = _id_0847::_id_DF08("kstreak_firebombing_fire_med_lp", var_0 + (0, 0, 50));
    }

    wait(var_1 - 4);
    _id_0847::_id_DF21(var_2, 5);
  }
}

_id_5B60(var_0) {
  thread _id_13BF();
  var_1 = 1;

  for(level._id_1E77 = "kstreak_firebombing_explo_main"; var_1 <= var_0; var_1++) {
    level waittill("aud_firebomb_exp");

    if(level._id_1E77 == "kstreak_firebombing_explo_main") {
      level._id_1E77 = "kstreak_firebombing_explo_short_trans";
      continue;
    }

    level._id_1E77 = "kstreak_firebombing_explo_main";
  }
}

_id_3262(var_0) {
  if(scripts\mp\utility\game::isholidayenabled(2)) {
    var_1 = _id_0847::_id_DF08("mp_codmas_plane_flyby", var_0);
    var_0 waittill("death");
    _id_0847::_id_DF21(var_1, 0.1);
  } else {
    var_1 = _id_0847::_id_DF08("kstreak_carepackage_plane_flyby", var_0);
    var_0 waittill("death");
    _id_0847::_id_DF21(var_1, 0.1);
  }
}

carepackage_impact_small(var_0) {
  _id_0847::_id_DF08("kstreak_carepackage_land_small", var_0);
}

carepackage_impact_med(var_0) {
  _id_0847::_id_DF08("kstreak_carepackage_land_medium", var_0);
}

carepackage_impact_large(var_0) {
  _id_0847::_id_DF08("kstreak_carepackage_land_large", var_0);
}

carepackage_open(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(var_3)) {
      if(var_3 == var_0) {
        if(scripts\mp\utility\game::isholidayenabled(2)) {
          var_3 playsoundtoplayer("mp_codmas_kstreak_carepackage_use_layer_plr", var_3, var_0);
        }

        var_3 playsoundtoplayer("kstreak_carepackage_use_plr", var_3, var_0);
        continue;
      }

      if(scripts\mp\utility\game::isholidayenabled(2)) {
        var_3 playsoundtoplayer("mp_codmas_kstreak_carepackage_use_layer_npc", var_3, var_0);
      }

      var_3 playsoundtoplayer("kstreak_carepackage_use_npc", var_3, var_0);
    }
  }
}

_id_A16E(var_0) {
  var_1 = _id_0847::_id_DF08("kstreak_mortar_incoming_distant", var_0);
  wait 0.7;
  var_2 = _id_0847::_id_DF08("kstreak_mortar_incoming_close", var_0);
  var_0 waittill("death");
  _id_0847::_id_DF21(var_1, 0.01);
  _id_0847::_id_DF21(var_2, 0.01);
}

_id_A16D(var_0) {
  _id_0847::_id_DF08("kstreak_mortar_explo_main", var_0 + (0, 0, 50));
}

_id_701E(var_0) {
  var_1 = "mp_glidebomb_mix";
  var_2 = 0.5;
  var_3 = 0.5;
  var_4 = 1;
  _id_0847::_id_DF08("kstreak_glidebomb_incoming_npc", var_0.origin);

  foreach(var_6 in level.players) {
    if(isDefined(var_6)) {
      if(var_6 == var_0.owner) {
        var_6 _meth_867F(var_1, var_2, var_4);
        var_6 playsoundtoplayer("kstreak_glidebomb_incoming_plr", var_6, var_0);
        continue;
      }

      var_6 playsoundtoplayer("kstreak_glidebomb_incoming_npc_accent", var_6, var_0);
    }
  }

  var_0.owner waittill("cruise_missile_explode");
  var_0 _meth_83F8();

  foreach(var_6 in level.players) {
    if(isDefined(var_6)) {
      var_6 _meth_8680(var_1, var_3);
    }
  }
}

glidebomb_explosion(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::_id_E1E9(var_0 + (0, 0, 300));

  foreach(var_5 in level.players) {
    if(isDefined(var_5)) {
      if(var_5 == var_1.owner) {
        var_5 playsoundtoplayer("kstreak_glidebomb_explo_main_plr", var_5);
        continue;
      }

      var_5 playsoundtoplayer("kstreak_glidebomb_explo_main", var_5, var_3);
    }
  }

  wait 11;
  var_3 delete();
}

v2_timer_tick(var_0) {
  _id_0847::_id_DF08("kstreak_v2_timer_tick", var_0);
}

v2_timer_start(var_0) {
  _id_0847::_id_DF08("kstreak_v2_timer_start", var_0);
}

v2_incoming(var_0) {
  wait 0.5;
  _id_0847::_id_DF08("kstreak_v2_incoming", var_0);
}

v2_explosion(var_0) {
  _id_0847::_id_DF08("kstreak_v2_explosion");
  wait 1.8;

  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      thread v2_shockwave(var_2, var_0);
    }
  }
}

v2_shockwave(var_0, var_1) {
  _func_0428("nuke");
  _id_0847::_id_DF08("kstreak_v2_wind", var_0);
  wait 1.35;
  _id_0847::_id_DF08("kstreak_v2_shockwave_approach", var_1);
  _id_0847::_id_DF08("kstreak_v2_shockwave_main", var_0);
}

flamenaut_mask_on(var_0) {
  var_0 playsoundtoplayer("kstreak_flamenaut_mask_on", var_0);
}

flamenaut_death_explosion(var_0) {
  _id_0847::_id_DF08("kstreak_flamenaut_explode_main", var_0);
}

dog_whistle(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      if(var_2 == var_0) {
        var_2 playsoundtoplayer("kstreak_dog_call_foley_plr", var_0);
        continue;
      }

      var_2 playsoundtoplayer("kstreak_dog_call_whistle_npc", var_2, var_0);
    }
  }
}

ball_turret_gunner_vehicle_loop(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(var_3)) {
      if(var_3 == var_0.owner) {
        thread ball_turret_gunner_player_loop(var_0);
        continue;
      }

      thread ball_turret_gunner_npc_loop(var_0);
    }
  }
}

ball_turret_gunner_player_loop(var_0) {
  thread ball_turret_damaged_loop_pc(var_0);
  var_1 = _id_0847::_id_DF08("kstreak_ball_gunner_plr_loop", var_0);
  var_0 scripts\engine\utility::_id_10883("leaving", "crashing", "death", "game_ended", "disconnect");
  _id_0847::_id_DF21(var_1, 2);
}

ball_turret_damaged_loop_pc(var_0) {
  var_0 waittill("BTG_Damage");
  var_1 = _id_0847::_id_DF08("kstreak_ball_gunner_plr_damage_mvmt", var_0);
  var_0 scripts\engine\utility::_id_10883("leaving", "crashing", "death", "game_ended", "disconnect");
  _id_0847::_id_DF21(var_1, 1);
}

ball_turret_gunner_damaged(var_0) {
  level notify("BTG_Damage");
  var_1 = _id_0847::_id_DF08("kstreak_ball_gunner_plr_damage_mvmt", var_0);
  var_2 = _id_0847::_id_DF08("kstreak_ball_gunner_plr_alarm", var_0);
  var_0 scripts\engine\utility::_id_10883("leaving", "crashing", "death", "game_ended", "disconnect");
  _id_0847::_id_DF21(var_1, 1);
  _id_0847::_id_DF21(var_2, 1);
}

ball_turret_gunner_shotat(var_0) {
  _id_0847::_id_DF08("kstreak_btg_bullet_impact_plr", var_0);
}

ball_turret_gunner_npc_loop(var_0) {
  var_1 = _id_0847::_id_DF08("kstreak_ball_gunner_npc_loop", var_0);
  thread ball_turret_damaged_loop_npc(var_0);
  var_0 scripts\engine\utility::_id_10883("leaving", "crashing", "death", "game_ended", "disconnect");
  _id_0847::_id_DF21(var_1, 2);
}

ball_turret_damaged_loop_npc(var_0) {
  var_0 waittill("BTG_Damage");
  var_1 = _id_0847::_id_DF08("kstreak_btg_npc_engine_damage", var_0);
  var_0 scripts\engine\utility::_id_10883("leaving", "crashing", "death", "game_ended", "disconnect");
  _id_0847::_id_DF21(var_1, 1);
}

ball_turret_gunner_exit(var_0) {
  var_1 = _id_0847::_id_DF08("kstreak_ball_gunner_npc_exit", var_0);
}

ball_turret_gunner_damage_explosion(var_0) {
  _id_0847::_id_DF08("explo_plane_distant", var_0);
}

ball_turret_gunner_explosion(var_0) {
  _id_0847::_id_DF08("explo_plane_death_spin_long", var_0);
}

ball_turret_gunner_explosion2(var_0) {
  _id_0847::_id_DF08("explo_plane_distant", var_0);
}

field_mic_plant(var_0) {
  _id_0847::_id_DF08("mp_fldupgrds_field_mic_deploy", var_0);
}

field_mic_explode(var_0) {
  _id_0847::_id_DF08("mp_fldupgrds_field_mic_explode", var_0);
}

jammer_plant(var_0, var_1) {
  _id_0847::_id_DF08("mp_fldupgrds_jammer_deploy", var_1);
  wait 1;
  var_2 = _id_0847::_id_DF08("mp_fldupgrds_jammer_lp", var_1.origin);
  var_0 waittill("jammer_destroyed");
  _id_0847::_id_DF21(var_2);
}

jammer_explode(var_0, var_1) {
  _id_0847::_id_DF08("mp_fldupgrds_jammer_explode", var_1);
  var_0 notify("jammer_destroyed");
}

trophy_plant(var_0) {
  _id_0847::_id_DF08("mp_fldupgrds_trophy_deploy", var_0);
}

trophy_fire(var_0, var_1) {
  _id_0847::_id_DF08("mp_fldupgrds_trophy_fire", var_0);
  _id_0847::_id_DF08("mp_fldupgrds_trophy_whizby", var_1);
}

trophy_successful_explosion(var_0) {
  _id_0847::_id_DF08("mp_fldupgrds_trophy_succesful_explosion", var_0);
}

goliath_explosion(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_2.origin + (0, 0, 50));

  foreach(var_5 in level.players) {
    if(isDefined(var_5)) {
      if(var_5 == var_1) {
        var_5 playsoundtoplayer("kstreak_goliath_explode_plr_main", var_5, var_3);
        continue;
      }

      var_5 playsoundtoplayer("kstreak_goliath_explode_main", var_5, var_3);
    }
  }

  waitframe();
  var_3 delete();
}

_id_3651() {
  scripts\engine\utility::_id_5C11("aud_chopper_gunner_us_loudspeaker_active");
  scripts\engine\utility::_id_5C11("aud_chopper_gunner_vc_loudspeaker_active");
  thread _id_3652();
}

_id_3652() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 _meth_867F("mp_killstreak_chopper_gunner_owner_mute");
  }
}

_id_364C(var_0, var_1) {
  var_2 = _id_0847::_id_DF08("kstreak_chopper_gun_plr_heli_oneshot_lp", var_1);
  _id_0847::_id_DF24(var_2, var_0, "death");
  _id_0847::_id_DF24(var_2, var_0, "crashing");
  var_1 _meth_8680("mp_killstreak_chopper_gunner_owner_mute");
  var_1 _meth_867F("mp_killstreak_chopper_gunner_owner");
  thread _id_3654(var_0, var_1);

  if(var_0.team == "allies") {
    var_3 = _id_0847::_id_DF08([0.5, "kstreak_chopper_gun_plr_us_music", 0], var_1);
    _id_0847::_id_DF24(var_3, var_0, "death");
    _id_0847::_id_DF24(var_3, var_0, "crashing");
  } else {
    var_3 = _id_0847::_id_DF08([0.5, "kstreak_chopper_gun_plr_us_music", 0], var_1);
    _id_0847::_id_DF24(var_3, var_0, "death");
    _id_0847::_id_DF24(var_3, var_0, "crashing");
  }

  var_4 = _id_0847::_id_DF08("kstreak_chopper_gun_npc_heli_oneshot_lp", var_0);
  _id_0847::_id_DF24(var_4, var_0, "death");
  _id_0847::_id_DF24(var_4, var_0, "crashing");

  if(!scripts\engine\utility::_id_5C00("aud_chopper_gunner_us_loudspeaker_active")) {
    scripts\engine\utility::_id_5C1B("aud_chopper_gunner_us_loudspeaker_active");
    thread _id_1E75(var_0);
    var_5 = _id_0847::_id_DF08("kstreak_chopper_gun_npc_us_loudspeaker", var_0);
    _id_0847::_id_DF24(var_5, var_0, "death");
    _id_0847::_id_DF24(var_5, var_0, "crashing");
  } else if(!scripts\engine\utility::_id_5C00("aud_chopper_gunner_vc_loudspeaker_active")) {
    scripts\engine\utility::_id_5C1B("aud_chopper_gunner_vc_loudspeaker_active");
    thread _id_1E76(var_0);
    var_5 = _id_0847::_id_DF08("kstreak_chopper_gun_npc_vc_loudspeaker", var_0);
    _id_0847::_id_DF24(var_5, var_0, "death");
    _id_0847::_id_DF24(var_5, var_0, "crashing");
  }

  thread _id_3653(var_0);
}

_id_3654(var_0, var_1) {
  var_2 = var_0 scripts\engine\utility::waittill_any_return("death", "crashing", "leaving");

  if(var_2 == "leaving") {
    var_1 _meth_8680("mp_killstreak_chopper_gunner_owner", 4);
    var_1 _meth_867F("mp_killstreak_chopper_gunner_owner_mute", 4);
  } else {
    var_1 _meth_8680("mp_killstreak_chopper_gunner_owner");
    var_1 _meth_867F("mp_killstreak_chopper_gunner_owner_mute", 4);
  }
}

_id_1E75(var_0) {
  var_0 scripts\engine\utility::_id_1087F("death", "crashing", "leaving");
  scripts\engine\utility::_id_5C04("aud_chopper_gunner_us_loudspeaker_active");
}

_id_1E76(var_0) {
  var_0 scripts\engine\utility::_id_1087F("death", "crashing", "leaving");
  scripts\engine\utility::_id_5C04("aud_chopper_gunner_vc_loudspeaker_active");
}

_id_3653(var_0) {
  var_0 endon("death");
  var_0 endon("crashing");
  var_0 waittill("leaving");
  _id_0847::_id_DF08("kstreak_chopper_gun_plr_heli_exit", var_0);
  _id_0847::_id_DF08("kstreak_chopper_gun_npc_heli_exit", var_0);
}

_id_364F(var_0) {
  _id_0847::_id_DF08("explo_vehicle_plane_main", var_0);
}

_id_1E7B(var_0) {
  _id_0847::_id_DF08("kstreak_napalm_strike_plane_by_2d", var_0);
}

_id_1E79(var_0) {
  _id_0847::_id_DF08("kstreak_napalm_strike_explo_main", var_0);
  wait(randomfloatrange(0.05, 1.5));
  _id_0847::_id_DF08("kstreak_napalm_strike_explo_flame", var_0);
}

_id_1E7A(var_0, var_1) {
  var_2 = var_0.origin;
  wait(var_1);
}