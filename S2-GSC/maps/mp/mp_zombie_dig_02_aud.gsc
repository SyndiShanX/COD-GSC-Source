/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_dig_02_aud.gsc
*********************************************/

func_00F9() {
  lib_0367::func_8E3E("bp_thule");
  func_7BBA();
  func_5C22();
  level.var_11CB.intermission_music_aliases = ["mus_intermission_dlc2"];
  level.var_11CB.wave_cues = ["dlcx_mus_intro_assault", "dlcx_mus_wave_04", "dlcx_mus_wave_02", "dlcx_mus_wave_03", "dlcx_mus_movin", "dlcx_mus_screetchy1", "dlcx_mus_wave_07", "dlcx_mus_wave_01", "dlcx_mus_wave_05"];
  lib_0366::snd_set_mus_combat_cues_override(level.var_11CB.wave_cues);
  lib_0366::snd_zmb_set_start_intermission_music_override_callback(::start_intermission_music_override_callback);
  lib_0366::snd_zmb_set_map_wave_music_master_volume_scalar(0.8);
}

func_7BBA() {
  lib_0378::func_8DC7("player_connect_map", ::func_7248);
  lib_0378::func_8DC7("player_spawned", ::func_7330);
  lib_0378::func_8DC7("wave_begin", ::func_A979);
  lib_0378::func_8DC7("wave_end", ::func_A97A);
  lib_0378::func_8DC7("aud_resonator_hit", ::aud_resonator_hit);
  lib_0378::func_8DC7("aud_resonator_warming_up", ::aud_resonator_warming_up);
  lib_0378::func_8DC7("aud_resonator_warming_up_stop", ::aud_resonator_warming_up_stop);
  lib_0378::func_8DC7("aud_resonator_usable", ::aud_resonator_usable);
  lib_0378::func_8DC7("aud_resonator_usable_stop", ::aud_resonator_usable_stop);
  lib_0378::func_8DC7("aud_blood_plate_filled", ::aud_blood_plate_filled);
  lib_0378::func_8DC7("aud_blood_plate_absorb", ::aud_blood_plate_absorb);
  lib_0378::func_8DC7("aud_blood_plate_press", ::aud_blood_plate_press);
  lib_0378::func_8DC7("aud_blood_plate_release", ::aud_blood_plate_release);
  lib_0378::func_8DC7("aud_blood_plate_lock", ::aud_blood_plate_lock);
  lib_0378::func_8DC7("aud_turn_on_bloodfalls", ::aud_turn_on_bloodfalls);
  lib_0378::func_8DC7("aud_scavenge_generator_turn_off", ::aud_scavenge_generator_turn_off);
  lib_0378::func_8DC7("aud_scavenge_generator_turn_on", ::aud_scavenge_generator_turn_on);
  lib_0378::func_8DC7("aud_flare_crate_drop", ::aud_flare_crate_drop);
  lib_0378::func_8DC7("aud_pickup_flare", ::aud_pickup_flare);
  lib_0378::func_8DC7("aud_fount_elec_drop", ::aud_fount_elec_drop);
  lib_0378::func_8DC7("aud_brazier_light", ::aud_brazier_light);
  lib_0378::func_8DC7("aud_brazier_light_stop", ::aud_brazier_light_stop);
  lib_0378::func_8DC7("aud_basalt_move", ::aud_basalt_move);
  lib_0378::func_8DC7("aud_rune_pressed", ::aud_rune_pressed);
  lib_0378::func_8DC7("aud_rune_all_runes_pressed", ::aud_rune_all_runes_pressed);
  lib_0378::func_8DC7("aud_rune_all_runes_unpressed", ::aud_rune_all_runes_unpressed);
  lib_0378::func_8DC7("aud_place_sword_piece", ::aud_place_sword_piece);
  lib_0378::func_8DC7("aud_assemble_sword", ::aud_assemble_sword);
  lib_0378::func_8DC7("sword_pieces_combine", ::sword_pieces_combine);
  lib_0378::func_8DC7("aud_pickup_barbarosa_sword", ::aud_pickup_barbarosa_sword);
  lib_0378::func_8DC7("aud_dig_earthquake", ::aud_dig_earthquake);
  lib_0378::func_8DC7("klaus_encounter", ::klaus_encounter);
  lib_0378::func_8DC7("aud_trap_spikes", ::aud_trap_spikes);
  lib_0378::func_8DC7("zombie_soul_suck", ::func_ABF8);
  lib_0378::func_8DC7("zombie_soul_suck_threshold", ::func_ABF9);
}

start_intermission_music_override_callback() {
  var_00 = level.var_11CB.intermission_music_aliases[randomint(level.var_11CB.intermission_music_aliases.size)];
  var_01 = 3;
  var_02 = 5;
  lib_0366::func_8E31(var_00, var_01, var_02);
}

func_5C22() {
  thread func_35E1();
}

func_35E1() {
  wait(0.5);
  lib_0380::func_6842("zmb_dig_bloodfall_room_water_lp", undefined, (6, 1465, 171), 0.5);
}

func_7248() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_altered_state_init();
  if(!isDefined(self.var_11CB)) {
    self.var_11CB = spawnStruct();
  }
}

func_7330() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_player_spawned();
}

func_A979(param_00) {
  soundscripts\_snd_common_zmb_dlc3::dlc3_wave_begin(param_00);
}

func_A97A() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_wave_end();
}

aud_blood_plate_filled(param_00) {}

aud_blood_plate_absorb(param_00) {
  var_01 = self;
  var_02 = spawn("script_origin", var_01.var_116);
  var_03 = 0;
  var_04 = 0.875;
  lib_0380::func_288B("zombie_soul_suck", undefined, var_02, 0, var_04);
  lib_0380::func_288B("zmb_dig_soul_suck_blood", undefined, var_02);
  var_02 moveto(param_00.var_116, 1.9);
  wait(2);
  var_02 delete();
}

aud_blood_plate_press(param_00) {
  lib_0380::func_288B("zmb_dig_blood_plate_press", undefined, param_00);
}

aud_blood_plate_lock(param_00) {
  wait(0.8);
  lib_0380::func_2888("zmb_dig_blood_plate_lock_imp", undefined);
}

aud_blood_plate_release(param_00) {
  lib_0380::func_288B("zmb_dig_blood_plate_release", undefined, param_00);
}

aud_turn_on_bloodfalls(param_00) {
  if(param_00.var_1A5 == "blood_fount_NE") {
    param_00.fall_snd_ne = lib_0380::func_6842("zmb_dig_bloodfall_lp", undefined, (125, 1552, 473), 0.75);
    param_00.splat_snd_ne = lib_0380::func_6842("zmb_dig_bloodfall_splats_lp", undefined, (125, 1552, 131), 0.75);
    if(!isDefined(level.var_11CB.fallcount)) {
      level.var_11CB.fallcount = 1;
    } else {
      level.var_11CB.fallcount++;
    }
  }

  if(param_00.var_1A5 == "blood_fount_SE") {
    param_00.fall_snd_se = lib_0380::func_6842("zmb_dig_bloodfall_lp_2", undefined, (113, 1379, 473), 0.75);
    param_00.splat_snd_se = lib_0380::func_6842("zmb_dig_bloodfall_splats_lp", undefined, (113, 1379, 131), 0.75);
    if(!isDefined(level.var_11CB.fallcount)) {
      level.var_11CB.fallcount = 1;
    } else {
      level.var_11CB.fallcount++;
    }
  }

  if(param_00.var_1A5 == "blood_fount_SW") {
    param_00.fall_snd_sw = lib_0380::func_6842("zmb_dig_bloodfall_lp_3", undefined, (-88, 1381, 473), 0.75);
    param_00.splat_snd_sw = lib_0380::func_6842("zmb_dig_bloodfall_splats_lp", undefined, (-88, 1381, 131), 0.75);
    if(!isDefined(level.var_11CB.fallcount)) {
      level.var_11CB.fallcount = 1;
    } else {
      level.var_11CB.fallcount++;
    }
  }

  if(param_00.var_1A5 == "blood_fount_NW") {
    param_00.fall_snd_nw = lib_0380::func_6842("zmb_dig_bloodfall_lp_4", undefined, (-90, 1541, 473), 0.75);
    param_00.splat_snd_nw = lib_0380::func_6842("zmb_dig_bloodfall_splats_lp", undefined, (-90, 1541, 131), 0.75);
    if(!isDefined(level.var_11CB.fallcount)) {
      level.var_11CB.fallcount = 1;
    } else {
      level.var_11CB.fallcount++;
    }
  }

  if(lib_0547::func_5565(level.var_11CB.fallcount, 3)) {
    lib_0380::func_6842("zmb_dig_amb_blood_room_drips_lp", undefined, (6, 1465, 171), 2);
  }
}

aud_resonator_hit(param_00) {
  level.var_11CB.resonator_pos = param_00.var_116;
  var_01 = lib_0380::func_2889("zmb_dig_resonator_hit", undefined, level.var_11CB.resonator_pos);
}

aud_resonator_warming_up(param_00) {
  level.var_11CB.zmb_dig_resonator_warm_up_lp = lib_0380::func_6842("zmb_dig_resonator_warm_up_lp", undefined, level.var_11CB.resonator_pos);
  lib_0380::func_684E(level.var_11CB.zmb_dig_resonator_warm_up_lp, 0.333, 0.1);
}

aud_resonator_warming_up_stop(param_00) {
  level.var_11CB.zmb_dig_resonator_usealbe_lp = lib_0380::func_6842("zmb_dig_resonator_usealbe_lp", undefined, level.var_11CB.resonator_pos, 6);
  lib_0380::func_684E(level.var_11CB.zmb_dig_resonator_warm_up_lp, 1, 6);
}

aud_resonator_usable(param_00) {}

aud_resonator_usable_stop(param_00) {
  var_01 = 8;
  lib_0380::func_684E(level.var_11CB.zmb_dig_resonator_warm_up_lp, 0, var_01);
  lib_0380::func_684E(level.var_11CB.zmb_dig_resonator_usealbe_lp, 0, var_01);
  wait(var_01 + 1);
  lib_0380::func_6850(level.var_11CB.zmb_dig_resonator_warm_up_lp);
  lib_0380::func_6850(level.var_11CB.zmb_dig_resonator_usealbe_lp);
  level.var_11CB.zmb_dig_resonator_warm_up_lp = undefined;
  level.var_11CB.zmb_dig_resonator_usealbe_lp = undefined;
}

aud_scavenge_generator_turn_off(param_00) {
  level.var_11CB.generator_idle_snd = lib_0380::func_6844("emt_generator_mech_layer_lp", undefined, param_00, 0.3);
}

aud_scavenge_generator_turn_on(param_00) {
  if(isDefined(level.var_11CB.generator_idle_snd)) {
    lib_0380::func_6850(level.var_11CB.generator_idle_snd, 0.5);
  }

  lib_0380::func_288B("zmb_generator_repaired_01", undefined, param_00);
}

aud_rune_pressed(param_00) {
  var_01 = param_00.var_116 + (0, -10, 0);
  param_00.press_snd = lib_0380::func_2889("zmb_dig_rune_press", undefined, var_01);
}

aud_rune_all_runes_pressed(param_00) {
  var_01 = (134, 2871, 421);
  var_02 = lib_0380::func_2889("zmb_dig_rune_wall_hide", undefined, var_01);
}

aud_rune_all_runes_unpressed(param_00) {
  var_01 = (134, 2871, 421);
  wait(0.5);
  var_02 = lib_0380::func_2889("zmb_dig_rune_wall_show", undefined, var_01);
}

aud_place_sword_piece(param_00) {
  switch (param_00.piece) {
    case "hilt":
      lib_0380::func_2889("zmb_dig_barb_place_hilt", undefined, param_00.plate_core.var_116);
      level.var_11CB.sword_piece_place_lp_01 = lib_0380::func_6842("zmb_dig_forge_sword_place_lp_01", undefined, param_00.plate_core.var_116, 1);
      break;

    case "pommel":
      lib_0380::func_2889("zmb_dig_barb_place_pommel", undefined, param_00.plate_core.var_116);
      level.var_11CB.sword_piece_place_lp_02 = lib_0380::func_6842("zmb_dig_forge_sword_place_lp_02", undefined, param_00.plate_core.var_116, 1);
      break;

    case "blade":
      lib_0380::func_2889("zmb_dig_barb_place_blade", undefined, param_00.plate_core.var_116);
      level.var_11CB.sword_piece_place_lp_03 = lib_0380::func_6842("zmb_dig_forge_sword_place_lp_03", undefined, param_00.plate_core.var_116, 1);
      break;
  }
}

aud_assemble_sword() {
  var_00 = self;
  if(isDefined(level.var_11CB.sword_piece_place_lp_01)) {
    lib_0380::func_6850(level.var_11CB.sword_piece_place_lp_01, 0.75);
  }

  if(isDefined(level.var_11CB.sword_piece_place_lp_02)) {
    lib_0380::func_6850(level.var_11CB.sword_piece_place_lp_02, 0.75);
  }

  if(isDefined(level.var_11CB.sword_piece_place_lp_03)) {
    lib_0380::func_6850(level.var_11CB.sword_piece_place_lp_03, 0.75);
  }

  lib_0380::func_2889("zmb_dig_forge_sword_buildup", undefined, var_00.var_116);
  level.var_11CB.sword_assamble_lp = lib_0380::func_6842("zmb_dig_forge_sword_lp", undefined, var_00.var_116, 3);
  thread sword_assemble_elec_oneshots(var_00.var_116);
  thread sword_assemble_whoosh_oneshots(var_00.var_116);
}

sword_pieces_combine(param_00, param_01) {
  var_02 = self;
  wait(param_01 - 1);
  lib_0380::func_2889("zmb_dig_forge_sword_combine_into", undefined, param_00);
}

sword_assemble_elec_oneshots(param_00) {
  level endon("stop_sword_assemble_sounds");
  wait(3);
  for(;;) {
    var_01 = randomintrange(5, 8);
    var_02 = param_00 + (randomintrange(-200, 200), randomintrange(-200, 200), 0);
    lib_0380::func_2889("zmb_dig_forge_sword_elec_oneshot", undefined, var_02);
    wait(var_01);
  }
}

sword_assemble_whoosh_oneshots(param_00) {
  level endon("stop_sword_assemble_sounds");
  wait(3);
  for(;;) {
    var_01 = randomintrange(4, 9);
    var_02 = param_00 + (randomintrange(-200, 200), randomintrange(-200, 200), 0);
    lib_0380::func_2889("zmb_dig_forge_sword_whoosh_oneshot", undefined, var_02);
    wait(var_01);
  }
}

aud_pickup_barbarosa_sword(param_00) {
  lib_0380::func_288B("zmb_pickup_swrd", undefined, self);
  lib_0380::func_6850(level.var_11CB.sword_assamble_lp, 0.5);
  lib_0380::func_2889("zmb_dig_forge_sword_end", undefined, param_00);
  level notify("stop_sword_assemble_sounds");
}

aud_flare_crate_drop() {
  var_00 = self;
  lib_0380::func_288B("zmb_dig_flare_box_imp", undefined, var_00);
}

aud_pickup_flare() {
  var_00 = self;
  lib_0380::func_288B("zmb_dig_flare_box_foley", undefined, var_00);
}

aud_fount_elec_drop() {}

aud_brazier_light() {
  var_00 = self;
  var_00.snd_handle = lib_0380::func_6842("zmb_dig_torch_sml", undefined, var_00.var_116, 0.5);
}

aud_brazier_light_stop() {
  var_00 = self;
  if(isDefined(var_00.snd_handle)) {
    lib_0380::func_6850(var_00.snd_handle, 0.5);
  }
}

aud_basalt_move() {
  var_00 = self;
  lib_0380::func_288B("zmb_dig_rune_compartment", undefined, var_00);
}

aud_dig_earthquake(param_00, param_01, param_02) {
  foreach(var_04 in level.var_744A) {
    var_04 method_8626("dig_earthquake_mix");
  }

  var_06 = 1;
  if(param_02 == 0) {
    var_06 = 0.65;
  }

  if(param_02 == 1) {
    var_06 = 0.8;
  }

  if(param_02 == 2) {
    var_06 = 1;
  }

  switch (param_00) {
    case "rumble1":
      if(!isDefined(level.var_11CB.dig_earthquake_phase1_handle)) {
        var_07 = param_01 * 1.4;
        var_08 = 2.5;
        lib_0366::func_8E30(0.75, var_07);
        level.var_11CB.dig_earthquake_phase1_handle = lib_0380::func_6840("zone1Earthquake_phase1", undefined, var_07, var_06);
      }
      break;

    case "rumble2":
      if(!isDefined(level.var_11CB.dig_earthquake_phase2_handle)) {
        var_07 = param_01;
        var_08 = 1;
        level.var_11CB.dig_earthquake_phase2_handle = lib_0380::func_6840("zone1Earthquake_phase2", undefined, var_07, var_06);
      }
      break;

    case "rumble3":
      if(!isDefined(level.var_11CB.dig_earthquake_phase3_handle)) {
        var_07 = param_01 * 0.6;
        var_08 = 1;
        lib_0366::func_8E30(0.5, var_07);
        level.var_11CB.dig_earthquake_phase3_handle = lib_0380::func_6840("zone1Earthquake_phase3", undefined, var_07, var_06);
      }
      break;

    case "earthquake":
      if(!isDefined(level.var_11CB.dig_earthquake_phase4_handle)) {
        var_07 = 0.75;
        var_08 = param_01 * 0.65;
        lib_0366::func_8E30(0.25, var_07);
        level.var_11CB.dig_earthquake_phase4_handle = lib_0380::func_6840("zone1Earthquake_phase4", undefined, var_07, var_06);
        wait(param_01 * 0.5);
        aud_dig_earthquake_stop(var_08);
        wait(0.4);
        lib_0380::func_6840("zone1Earthquake_settle", undefined, var_07, var_06);
      }
      break;
  }
}

aud_dig_earthquake_stop(param_00) {
  lib_0366::func_8E30(1, param_00);
  foreach(var_02 in level.var_744A) {
    var_02 method_8627("dig_earthquake_mix");
  }

  if(isDefined(level.var_11CB.dig_earthquake_phase1_handle)) {
    lib_0380::func_6850(level.var_11CB.dig_earthquake_phase1_handle, param_00);
  }

  if(isDefined(level.var_11CB.dig_earthquake_phase2_handle)) {
    lib_0380::func_6850(level.var_11CB.dig_earthquake_phase2_handle, param_00 * 1.3);
  }

  if(isDefined(level.var_11CB.dig_earthquake_phase3_handle)) {
    lib_0380::func_6850(level.var_11CB.dig_earthquake_phase3_handle, param_00);
  }

  if(isDefined(level.var_11CB.dig_earthquake_phase4_handle)) {
    lib_0380::func_6850(level.var_11CB.dig_earthquake_phase4_handle, param_00);
  }

  level.var_11CB.dig_earthquake_phase1_handle = undefined;
  level.var_11CB.dig_earthquake_phase2_handle = undefined;
  level.var_11CB.dig_earthquake_phase3_handle = undefined;
  level.var_11CB.dig_earthquake_phase4_handle = undefined;
}

klaus_encounter() {
  if(!isDefined(self.aud_klaus_encounter_index)) {
    self.aud_klaus_encounter_index = 0;
    level.var_11CB.plr_threat_to_whisper_vol_env = [[0, 0.4], [1, 1]];
  }

  var_00 = 5;
  var_01 = common_scripts\utility::func_627D(self.aud_klaus_encounter_index, var_00) + 1;
  self.aud_klaus_encounter_index = self.aud_klaus_encounter_index + 1;
  var_02 = 0;
  var_03 = lib_0378::func_8D72(lib_0366::func_8E14(), level.var_11CB.plr_threat_to_whisper_vol_env);
  lib_0380::func_2888("zmb_dlc3_klaus_encounter" + var_01, self, var_02, var_03);
}

aud_trap_spikes(param_00) {
  wait(0.3);
  var_01 = 1;
  var_02 = 0;
  while(var_01) {
    lib_0380::func_2889("trap_spikes", undefined, param_00);
    lib_0380::func_2889("zmb_dig_spike_trap_splash", undefined, (1, 1490, 192));
    if(var_02 < 19) {
      var_02++;
      continue;
    }

    var_01 = 0;
    wait(1);
  }
}

func_ABF8(param_00, param_01) {
  var_02 = spawn("script_origin", param_00);
  var_03 = 0;
  var_04 = 0.875;
  lib_0380::func_288B("zombie_soul_suck", undefined, var_02, 0, var_04);
  var_02 moveto(param_01, 1.9);
  wait(2);
  var_02 delete();
}

func_ABF9(param_00) {
  lib_0380::func_2889("zombie_soul_suck_threshold", undefined, param_00);
}