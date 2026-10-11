/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_56abda53e9dd9317.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp\cp_audio;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\engine\utility;
#namespace namespace_be71eb5cb2b493f6;

function main() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player setsoundsubmix("cp_jup_chemical_global");
  location_list = [];
  location_list[0] = (1775, 24475, 5000);
  var_4af21f8a50feeaf5 = [];
  var_4af21f8a50feeaf5[0] = (-6000, 36600, 5000);
  var_4af21f8a50feeaf5[1] = (-5500, 15400, 5000);
  thread scripts\cp\cp_audio::function_ec9b3af8f8e2d59f(3, "flag_dungeon_outro_start", "jup_chemical_alarm_red_alert", "cp_jup_chemical_alarm_attenuate", location_list, "jup_chemical_alarm_red_alert_reflection", var_4af21f8a50feeaf5);
  thread function_6aeab32a6d7a16c8();
  thread scripts\cp\cp_audio::function_f1dd559fdd8216d1(2, 6, 12, 2500, "chemical", "flag_exit_interacted");
  level.player waittill("death");
  level.player clearsoundsubmix("cp_jup_chemical_reactor_gas_inside");
}

function function_6aeab32a6d7a16c8() {
  level endon("game_ended");

  while(!flag("flag_dungeon_outro_start")) {
    if(function_3f51c5f6398bff45() == 1) {
      playsoundatpos((1775, 24475, 5000), "jup_chemical_alarm_red_alert_long");
      wait 3;
    }

    wait 3;
  }
}

function function_5f1d182a1a42d149() {
  level.player setsoundsubmix("cp_jup_chemical_infil");
}

function function_dcfccfbf8b83acb8() {
  level endon("game_ended");
  level.player playsoundonmovingent("jup_chemical_infil_pt06_wind_flutter_transition_lr");
  level.player clearsoundsubmix("cp_jup_chemical_infil", 2);
  level.player setsoundsubmix("cp_jup_chemical_infil_togameplay_compensation", 2);
  flag_wait("flag_player_has_used_parachute_once");
  wait 2;
  level.player clearsoundsubmix("cp_jup_chemical_infil_togameplay_compensation", 25);
}

function function_67d05c35d51c45a6() {
  level endon("game_ended");
  level.player playLoopSound("jup_chemical_infil_pt06_cloth_flutter_descent");
  function_49d6e5ec39a0c4c("player_freefall", 1);
  level.player setsoundsubmix("cp_jup_chemical_infil_dive_gameplay", 0.5);
  level.player setsoundsubmix("cp_jup_chemical_infil_dive_gameplay_build", 4.5);
  flag_wait("flag_player_has_used_parachute_once");
  function_49d6e5ec39a0c4c("player_freefall", 0);
  wait 2;
  level.player stoploopsound("jup_chemical_infil_pt06_cloth_flutter_descent");
  level.player clearsoundsubmix("cp_jup_chemical_infil_dive_gameplay", 6);
  level.player clearsoundsubmix("cp_jup_chemical_infil_dive_gameplay_build", 3);
}

function attack_heli_death(heli) {
  heli waittill("crashing");
  heli playsoundonmovingent("jup_chemical_heli_boss_predestroy_explo_trans_swt");
  heli playsoundonmovingent("jup_chemical_heli_boss_predestroy_spiral");
  level.player setsoundsubmix("cp_jup_chemical_attack_helicopter_predestroy_spiral");
  heli waittill("vehicle_deathComplete", origin, angles);
  var_e3f56840b8c2ce3b = origin;
  playsoundatpos(var_e3f56840b8c2ce3b, "jup_chemical_heli_boss_destroy_explo_trans_swt");
  level.player clearsoundsubmix("cp_jup_chemical_attack_helicopter_predestroy_spiral");
}

function function_6c22b1feac90c495() {
  level.player playSound("jup_door_wood_stuck_01");
}

function function_cba2c362cdb9cfaf() {
  level.player playSound("jup_chemical_reactor_door_button_interact_fail");
}

function function_c4f66546640cf4d() {
  playsoundatpos((0, 0, 0), "jup_chemical_reactor_door_button_interact");
  var_9c347bec78c633d8 = playsoundatpos((2355, 24297, 1068), "jup_chemical_reactor_door_airlock_cycle");
  var_72f0347cf5719d34 = playsoundatpos((2050, 24895, 1068), "jup_chemical_reactor_door_airlock_cycle");
  var_da00fae958af0059 = playsoundatpos((1674, 23832, 1068), "jup_chemical_reactor_door_airlock_cycle");
  var_9c347bec78c633d8 = playsoundatpos((2420, 24278, 1105), "jup_chemical_reactor_door_alarm");
  var_72f0347cf5719d34 = playsoundatpos((2053, 24904, 1115), "jup_chemical_reactor_door_alarm");
  var_da00fae958af0059 = playsoundatpos((1657, 23779, 1096), "jup_chemical_reactor_door_alarm");
}

function function_505b5d4f03fcfa5d() {
  playsoundatpos((0, 0, 0), "jup_chemical_reactor_door_lights_out");
}

function function_f0b25c48410693c3() {
  var_9c347bec78c633d8 = playsoundatpos((2420, 24278, 1105), "jup_chemical_reactor_rotating_light_click");
  var_72f0347cf5719d34 = playsoundatpos((2053, 24904, 1115), "jup_chemical_reactor_rotating_light_click");
  var_da00fae958af0059 = playsoundatpos((1657, 23779, 1096), "jup_chemical_reactor_rotating_light_click");
}

function function_805331ab2b56bc58(fixture) {
  level endon("rotating_lights_off!");

  while(true) {
    var_36772c44e7c43a5e = playsoundatpos(fixture.origin, "jup_chemical_reactor_rotating_light");
    wait 3;
  }
}

function function_42a485923e941c46(inner_door) {
  playsoundatpos(inner_door.origin, "jup_chemical_reactor_door_open");
  level.player clearsoundsubmix("cp_jup_chemical_reactor_heli_doors_closed", 2);
  level.player clearsoundsubmix("cp_jup_chemical_reactor_airlock_seq");
}

function function_d4292a6af1824122(inner_door) {
  playsoundatpos(inner_door.origin, "jup_chemical_reactor_door_close");
  level notify("rotating_lights_off!");
}

function function_6f17d48ccb71478b(outer_door) {
  playsoundatpos(outer_door.origin, "jup_chemical_reactor_door_open");
}

function function_790b84b56975bf8d(outer_door) {
  wait 1;
  playsoundatpos(outer_door.origin, "jup_chemical_reactor_door_close");
}

function function_4b910d98963d85() {
  level.player playSound("jup_chemical_airlock_radio_interference");
}

function function_197f9a69624466d4() {
  level.player setsoundsubmix("cp_jup_chemical_reactor_airlock_vo_laswell");
  level.player playSound("jup_chemical_airlock_radio_interference_voduck_laswell");
}

function function_568ed3749ee38a1a() {
  wait 0.15;
  level.player clearsoundsubmix("cp_jup_chemical_reactor_airlock_vo_laswell");
  level.player setsoundsubmix("cp_jup_chemical_reactor_airlock_vo_gaz");
  level.player playSound("jup_chemical_airlock_radio_interference_voduck_gaz");
}

function function_1b8ce5a62a0f1a83() {
  level.player clearsoundsubmix("cp_jup_chemical_reactor_airlock_vo_gaz");
  level.player setsoundsubmix("cp_jup_chemical_reactor_airlock_vo_soap");
  level.player playSound("jup_chemical_airlock_radio_interference_voduck_soap");
  wait 5.5;
  level.player clearsoundsubmix("cp_jup_chemical_reactor_airlock_vo_soap");
}

function function_2292dd2ddbf9a14e() {
  level.player clearsoundsubmix("cp_jup_chemical_reactor_gas_rising", 0);
  level.player clearsoundsubmix("cp_jup_chemical_reactor_seq", 0);
  setglobalsoundcontext("jup_chemical_checkpoint_restart", "airlock");
}

function function_7d929ff767b262a5() {
  level.player clearsoundsubmix("cp_jup_chemical_reactor_gas_rising", 0);
  level flag_wait("flag_reactor_airlock_passed");
  level.var_9e42b50ac8eec4 playLoopSound("jup_chemical_reactor_seq_heli_pre_entry_lp");
  level.player setsoundsubmix("cp_jup_chemical_reactor_heli_doors_closed");
  level.player setsoundsubmix("cp_jup_chemical_reactor_seq");
  level.player setsoundsubmix("cp_jup_chemical_reactor_airlock_seq");
}

function function_bf33082ba673d7() {
  wait 5;
  level.var_9e42b50ac8eec4 stoploopsound("jup_chemical_reactor_seq_heli_pre_entry_lp");
}

function function_d129d0efbe496101() {
  level endon("game_ended");
  level.player endon("death");
  level.player setsoundsubmix("cp_jup_chemical_reactor_gas_rising", 0);
  function_49d6e5ec39a0c4c("cp_jup_chemical_reactor_gas_damage_volume", 0);
  var_5042fef99270e8 = spawn("script_origin", level.player.origin);
  var_5042fef99270e8 playLoopSound("jup_chemical_reactor_seq_gas_inside_damage_lp");
  var_852cb5bda33d4b85 = spawn("script_origin", level.var_bb8b217506e2d6e4.origin);
  var_852cb5bda33d4b85 playLoopSound("jup_chemical_reactor_seq_gas_rising_lp_3d");
  var_8527cfbda3375bdc = spawn("script_origin", level.player.origin);
  var_8527cfbda3375bdc playLoopSound("jup_chemical_reactor_seq_gas_rising_lp_2d");
  thread function_865209d72fbf0eea();

  while(!flag("flag_exit_interacted")) {
    if(level.var_bb8b217506e2d6e4.origin[2] > level.player.origin[2]) {
      var_8527cfbda3375bdc moveTo(level.player.origin, 0.01);
    } else {
      var_8527cfbda3375bdc moveTo((level.player.origin[0], level.player.origin[1], level.var_bb8b217506e2d6e4.origin[2]), 0.01);
    }

    if(level.var_bb8b217506e2d6e4.origin[2] > level.player.origin[2]) {
      var_852cb5bda33d4b85 moveTo((level.var_bb8b217506e2d6e4.origin[0], level.var_bb8b217506e2d6e4.origin[1], level.player.origin[2]), 0.01);
    } else {
      var_852cb5bda33d4b85 moveTo(level.var_bb8b217506e2d6e4.origin, 0.01);
    }

    wait 0.1;
  }

  function_49d6e5ec39a0c4c("cp_jup_chemical_reactor_gas_damage_volume", 0);
  level.player clearsoundsubmix("cp_jup_chemical_reactor_gas_inside", 1);
  level.player clearsoundsubmix("cp_jup_chemical_reactor_seq", 0);
  level.player clearsoundsubmix("cp_jup_chemical_reactor_gas_rising", 0);
  level.player setsoundsubmix("cp_jup_chemical_reactor_gas_escaped", 8);
  wait 9;
  level.player stoploopsound("jup_chemical_reactor_seq_gas_inside_damage_lp");
  var_8527cfbda3375bdc delete();
  var_852cb5bda33d4b85 delete();
  var_5042fef99270e8 delete();
  wait 2;
  level.player clearsoundsubmix("cp_jup_chemical_reactor_gas_escaped", 0);
}

function function_c0dfabc36952a884() {
  level endon("game_ended");
  level endon("flag_exit_interacted");
  level.player endon("death");
  thread function_51df3487be9d129d();

  while(!isDefined(level.player.var_4f984f22c067230d)) {
    waitframe();
  }

  var_bd7cccd352c13bb3 = 0;

  while(!flag("flag_exit_interacted")) {
    switch (level.player.var_4f984f22c067230d) {
      case #"hash_45408db06620faea":
        function_49d6e5ec39a0c4c("cp_jup_chemical_reactor_gas_damage_volume", 0);
        break;
      case #"hash_661b8493ce623fe":
        function_49d6e5ec39a0c4c("cp_jup_chemical_reactor_gas_damage_volume", 0);
        break;
      case #"hash_8457749ac30ef6d1":
        function_49d6e5ec39a0c4c("cp_jup_chemical_reactor_gas_damage_volume", 0.5);
        break;
      case #"hash_8457719ac30ef218":
        function_49d6e5ec39a0c4c("cp_jup_chemical_reactor_gas_damage_volume", 1);
        break;
    }

    wait 0.25;
  }
}

function function_51df3487be9d129d() {
  level endon("game_ended");
  level endon("flag_exit_interacted");
  level.player endon("death");

  while(!isDefined(level.player.var_4f984f22c067230d)) {
    waitframe();
  }

  var_bd7cccd352c13bb3 = 0;

  while(!flag("flag_exit_interacted")) {
    switch (level.player.var_4f984f22c067230d) {
      case #"hash_45408db06620faea":
        if(var_bd7cccd352c13bb3 != 0) {
          level.player clearsoundsubmix("cp_jup_chemical_reactor_gas_inside");
          var_bd7cccd352c13bb3 = 0;
        }

        break;
      case #"hash_661b8493ce623fe":
        if(var_bd7cccd352c13bb3 != 0) {
          level.player clearsoundsubmix("cp_jup_chemical_reactor_gas_inside");
          var_bd7cccd352c13bb3 = 0;
        }

        break;
      case #"hash_8457749ac30ef6d1":
        if(var_bd7cccd352c13bb3 != 0) {
          level.player clearsoundsubmix("cp_jup_chemical_reactor_gas_inside");
          var_bd7cccd352c13bb3 = 0;
        }

        break;
      case #"hash_8457719ac30ef218":
        if(var_bd7cccd352c13bb3 != 1) {
          level.player setsoundsubmix("cp_jup_chemical_reactor_gas_inside");
          var_bd7cccd352c13bb3 = 1;
        }

        break;
    }

    wait 1.5;
  }
}

function function_865209d72fbf0eea() {
  level endon("game_ended");
  level.player endon("death");
  wait 1;
  thread function_265005cc99564ed();

  for(var_2eaef3f720d4def2 = 0; !flag("flag_exit_interacted"); var_2eaef3f720d4def2 = 0) {
    if(var_2eaef3f720d4def2 == 0) {
      playsoundatpos((1386, 24550, 1250), "jup_chemical_reactor_seq_alarm");
      playsoundatpos((1525, 24850, 1327), "jup_chemical_reactor_seq_alarm_wet_l");
      playsoundatpos((2240, 24630, 1327), "jup_chemical_reactor_seq_alarm_wet_r");
      playsoundatpos((1325, 24235, 1327), "jup_chemical_reactor_seq_alarm_wet_ls");
      playsoundatpos((2050, 24020, 1327), "jup_chemical_reactor_seq_alarm_wet_rs");
      wait 2.75;
      playsoundatpos((1876, 24350, 1290), "jup_chemical_reactor_seq_alarm_accent_a");
      playsoundatpos((1525, 24850, 1327), "jup_chemical_reactor_seq_alarm_wet_l");
      playsoundatpos((2240, 24630, 1327), "jup_chemical_reactor_seq_alarm_wet_r");
      playsoundatpos((1325, 24235, 1327), "jup_chemical_reactor_seq_alarm_wet_ls");
      playsoundatpos((2050, 24020, 1327), "jup_chemical_reactor_seq_alarm_wet_rs");
      wait 2.75;
      var_2eaef3f720d4def2 = 1;
      continue;
    }

    playsoundatpos((2260, 24300, 1250), "jup_chemical_reactor_seq_alarm");
    playsoundatpos((1525, 24850, 1327), "jup_chemical_reactor_seq_alarm_wet_l");
    playsoundatpos((2240, 24630, 1327), "jup_chemical_reactor_seq_alarm_wet_r");
    playsoundatpos((1325, 24235, 1327), "jup_chemical_reactor_seq_alarm_wet_ls");
    playsoundatpos((2050, 24020, 1327), "jup_chemical_reactor_seq_alarm_wet_rs");
    wait 2.75;
    playsoundatpos((1876, 24350, 1290), "jup_chemical_reactor_seq_alarm_accent_a");
    playsoundatpos((1525, 24850, 1327), "jup_chemical_reactor_seq_alarm_wet_l");
    playsoundatpos((2240, 24630, 1327), "jup_chemical_reactor_seq_alarm_wet_r");
    playsoundatpos((1325, 24235, 1327), "jup_chemical_reactor_seq_alarm_wet_ls");
    playsoundatpos((2050, 24020, 1327), "jup_chemical_reactor_seq_alarm_wet_rs");
    wait 2.75;
  }
}

function function_265005cc99564ed() {
  level endon("game_ended");
  level.player endon("death");

  while(!flag("flag_exit_interacted")) {
    playsoundatpos((1876, 24350, 1290), "jup_chemical_reactor_seq_alarm_accent_b");
    var_4d392e89cd2d569a = randomfloatrange(6, 12);
    wait var_4d392e89cd2d569a;
  }
}

function function_8c3edcd5e0af11af() {
  level.player setsoundsubmix("cp_jup_chemical_exfil_part1_chemical_exposure", 1);
}

function function_a905955046e1e5da() {
  level.player clearsoundsubmix("cp_jup_chemical_exfil_part1_chemical_exposure", 0);
}

function function_e54f7091bb7fcc18() {
  level.player setsoundsubmix("cp_jup_chemical_exfil_part2_bink", 0);
}

function function_74453199c2d75d69() {
  level.player clearsoundsubmix("cp_jup_chemical_exfil_part2_bink", 0);
}

function function_588af84fad23df23(str_transient) {
  if(function_1186ca4e2e51afea(str_transient)) {
    return;
  }

  snd_transient_load(str_transient);
}

function function_afad8767dca9b688(str_transient, var_80d54b350039e2f7) {
  if(function_1186ca4e2e51afea(str_transient)) {
    if(isDefined(var_80d54b350039e2f7)) {
      wait var_80d54b350039e2f7;
    }

    snd_transient_unload(str_transient);
    return;
  }

  return;
}