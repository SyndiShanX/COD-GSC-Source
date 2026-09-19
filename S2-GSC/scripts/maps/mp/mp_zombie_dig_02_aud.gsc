/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_dig_02_aud.gsc
****************************************************/

main() {
  _id_0367::_id_8E3E("bp_thule");
  _id_7BBA();
  _id_5C22();
  level._id_11CB.intermission_music_aliases = ["mus_intermission_dlc2"];
  level._id_11CB.wave_cues = ["dlcx_mus_intro_assault", "dlcx_mus_wave_04", "dlcx_mus_wave_02", "dlcx_mus_wave_03", "dlcx_mus_movin", "dlcx_mus_screetchy1", "dlcx_mus_wave_07", "dlcx_mus_wave_01", "dlcx_mus_wave_05"];
  _id_0366::snd_set_mus_combat_cues_override(level._id_11CB.wave_cues);
  _id_0366::snd_zmb_set_start_intermission_music_override_callback(::start_intermission_music_override_callback);
  _id_0366::snd_zmb_set_map_wave_music_master_volume_scalar(0.8);
}

_id_7BBA() {
  _id_0378::_id_8DC7("player_connect_map", ::_id_7248);
  _id_0378::_id_8DC7("player_spawned", ::_id_7330);
  _id_0378::_id_8DC7("wave_begin", ::_id_A979);
  _id_0378::_id_8DC7("wave_end", ::_id_A97A);
  _id_0378::_id_8DC7("aud_resonator_hit", ::aud_resonator_hit);
  _id_0378::_id_8DC7("aud_resonator_warming_up", ::aud_resonator_warming_up);
  _id_0378::_id_8DC7("aud_resonator_warming_up_stop", ::aud_resonator_warming_up_stop);
  _id_0378::_id_8DC7("aud_resonator_usable", ::aud_resonator_usable);
  _id_0378::_id_8DC7("aud_resonator_usable_stop", ::aud_resonator_usable_stop);
  _id_0378::_id_8DC7("aud_blood_plate_filled", ::aud_blood_plate_filled);
  _id_0378::_id_8DC7("aud_blood_plate_absorb", ::aud_blood_plate_absorb);
  _id_0378::_id_8DC7("aud_blood_plate_press", ::aud_blood_plate_press);
  _id_0378::_id_8DC7("aud_blood_plate_release", ::aud_blood_plate_release);
  _id_0378::_id_8DC7("aud_blood_plate_lock", ::aud_blood_plate_lock);
  _id_0378::_id_8DC7("aud_turn_on_bloodfalls", ::aud_turn_on_bloodfalls);
  _id_0378::_id_8DC7("aud_scavenge_generator_turn_off", ::aud_scavenge_generator_turn_off);
  _id_0378::_id_8DC7("aud_scavenge_generator_turn_on", ::aud_scavenge_generator_turn_on);
  _id_0378::_id_8DC7("aud_flare_crate_drop", ::aud_flare_crate_drop);
  _id_0378::_id_8DC7("aud_pickup_flare", ::aud_pickup_flare);
  _id_0378::_id_8DC7("aud_fount_elec_drop", ::aud_fount_elec_drop);
  _id_0378::_id_8DC7("aud_brazier_light", ::aud_brazier_light);
  _id_0378::_id_8DC7("aud_brazier_light_stop", ::aud_brazier_light_stop);
  _id_0378::_id_8DC7("aud_basalt_move", ::aud_basalt_move);
  _id_0378::_id_8DC7("aud_rune_pressed", ::aud_rune_pressed);
  _id_0378::_id_8DC7("aud_rune_all_runes_pressed", ::aud_rune_all_runes_pressed);
  _id_0378::_id_8DC7("aud_rune_all_runes_unpressed", ::aud_rune_all_runes_unpressed);
  _id_0378::_id_8DC7("aud_place_sword_piece", ::aud_place_sword_piece);
  _id_0378::_id_8DC7("aud_assemble_sword", ::aud_assemble_sword);
  _id_0378::_id_8DC7("sword_pieces_combine", ::sword_pieces_combine);
  _id_0378::_id_8DC7("aud_pickup_barbarosa_sword", ::aud_pickup_barbarosa_sword);
  _id_0378::_id_8DC7("aud_dig_earthquake", ::aud_dig_earthquake);
  _id_0378::_id_8DC7("klaus_encounter", ::klaus_encounter);
  _id_0378::_id_8DC7("aud_trap_spikes", ::aud_trap_spikes);
  _id_0378::_id_8DC7("zombie_soul_suck", ::_id_ABF8);
  _id_0378::_id_8DC7("zombie_soul_suck_threshold", ::_id_ABF9);
}

start_intermission_music_override_callback() {
  var_0 = level._id_11CB.intermission_music_aliases[randomint(level._id_11CB.intermission_music_aliases.size)];
  var_1 = 3.0;
  var_2 = 5.0;
  _id_0366::_id_8E31(var_0, var_1, var_2);
}

_id_5C22() {
  thread _id_35E1();
}

_id_35E1() {
  wait 0.5;
  _id_0380::_id_6842("zmb_dig_bloodfall_room_water_lp", undefined, (6, 1465, 171), 0.5);
}

_id_7248() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_altered_state_init();

  if(!isDefined(self._id_11CB))
    self._id_11CB = spawnStruct();
}

_id_7330() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_player_spawned();
}

_id_A979(var_0) {
  soundscripts\_snd_common_zmb_dlc3::dlc3_wave_begin(var_0);
}

_id_A97A() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_wave_end();
}

aud_blood_plate_filled(var_0) {}

aud_blood_plate_absorb(var_0) {
  var_1 = self;
  var_2 = spawn("script_origin", var_1.origin);
  var_3 = 0;
  var_4 = 0.875;
  _id_0380::_id_288B("zombie_soul_suck", undefined, var_2, 0, var_4);
  _id_0380::_id_288B("zmb_dig_soul_suck_blood", undefined, var_2);
  var_2 _meth_82B1(var_0.origin, 1.9);
  wait 2.0;
  var_2 delete();
}

aud_blood_plate_press(var_0) {
  _id_0380::_id_288B("zmb_dig_blood_plate_press", undefined, var_0);
}

aud_blood_plate_lock(var_0) {
  wait 0.8;
  _id_0380::_id_2888("zmb_dig_blood_plate_lock_imp", undefined);
}

aud_blood_plate_release(var_0) {
  _id_0380::_id_288B("zmb_dig_blood_plate_release", undefined, var_0);
}

aud_turn_on_bloodfalls(var_0) {
  if(var_0.targetname == "blood_fount_NE") {
    var_0.fall_snd_ne = _id_0380::_id_6842("zmb_dig_bloodfall_lp", undefined, (125, 1552, 473), 0.75);
    var_0.splat_snd_ne = _id_0380::_id_6842("zmb_dig_bloodfall_splats_lp", undefined, (125, 1552, 131), 0.75);

    if(!isDefined(level._id_11CB.fallcount))
      level._id_11CB.fallcount = 1;
    else
      level._id_11CB.fallcount++;
  }

  if(var_0.targetname == "blood_fount_SE") {
    var_0.fall_snd_se = _id_0380::_id_6842("zmb_dig_bloodfall_lp_2", undefined, (113, 1379, 473), 0.75);
    var_0.splat_snd_se = _id_0380::_id_6842("zmb_dig_bloodfall_splats_lp", undefined, (113, 1379, 131), 0.75);

    if(!isDefined(level._id_11CB.fallcount))
      level._id_11CB.fallcount = 1;
    else
      level._id_11CB.fallcount++;
  }

  if(var_0.targetname == "blood_fount_SW") {
    var_0.fall_snd_sw = _id_0380::_id_6842("zmb_dig_bloodfall_lp_3", undefined, (-88, 1381, 473), 0.75);
    var_0.splat_snd_sw = _id_0380::_id_6842("zmb_dig_bloodfall_splats_lp", undefined, (-88, 1381, 131), 0.75);

    if(!isDefined(level._id_11CB.fallcount))
      level._id_11CB.fallcount = 1;
    else
      level._id_11CB.fallcount++;
  }

  if(var_0.targetname == "blood_fount_NW") {
    var_0.fall_snd_nw = _id_0380::_id_6842("zmb_dig_bloodfall_lp_4", undefined, (-90, 1541, 473), 0.75);
    var_0.splat_snd_nw = _id_0380::_id_6842("zmb_dig_bloodfall_splats_lp", undefined, (-90, 1541, 131), 0.75);

    if(!isDefined(level._id_11CB.fallcount))
      level._id_11CB.fallcount = 1;
    else
      level._id_11CB.fallcount++;
  }

  if(_id_0547::_id_5565(level._id_11CB.fallcount, 3))
    _id_0380::_id_6842("zmb_dig_amb_blood_room_drips_lp", undefined, (6, 1465, 171), 2);
}

aud_resonator_hit(var_0) {
  level._id_11CB.resonator_pos = var_0.origin;
  var_1 = _id_0380::_id_2889("zmb_dig_resonator_hit", undefined, level._id_11CB.resonator_pos);
}

aud_resonator_warming_up(var_0) {
  level._id_11CB.zmb_dig_resonator_warm_up_lp = _id_0380::_id_6842("zmb_dig_resonator_warm_up_lp", undefined, level._id_11CB.resonator_pos);
  _id_0380::_id_684E(level._id_11CB.zmb_dig_resonator_warm_up_lp, 0.333, 0.1);
}

aud_resonator_warming_up_stop(var_0) {
  level._id_11CB.zmb_dig_resonator_usealbe_lp = _id_0380::_id_6842("zmb_dig_resonator_usealbe_lp", undefined, level._id_11CB.resonator_pos, 6.0);
  _id_0380::_id_684E(level._id_11CB.zmb_dig_resonator_warm_up_lp, 1.0, 6.0);
}

aud_resonator_usable(var_0) {}

aud_resonator_usable_stop(var_0) {
  var_1 = 8.0;
  _id_0380::_id_684E(level._id_11CB.zmb_dig_resonator_warm_up_lp, 0, var_1);
  _id_0380::_id_684E(level._id_11CB.zmb_dig_resonator_usealbe_lp, 0, var_1);
  wait(var_1 + 1);
  _id_0380::_id_6850(level._id_11CB.zmb_dig_resonator_warm_up_lp);
  _id_0380::_id_6850(level._id_11CB.zmb_dig_resonator_usealbe_lp);
  level._id_11CB.zmb_dig_resonator_warm_up_lp = undefined;
  level._id_11CB.zmb_dig_resonator_usealbe_lp = undefined;
}

aud_scavenge_generator_turn_off(var_0) {
  level._id_11CB.generator_idle_snd = _id_0380::_id_6844("emt_generator_mech_layer_lp", undefined, var_0, 0.3);
}

aud_scavenge_generator_turn_on(var_0) {
  if(isDefined(level._id_11CB.generator_idle_snd))
    _id_0380::_id_6850(level._id_11CB.generator_idle_snd, 0.5);

  _id_0380::_id_288B("zmb_generator_repaired_01", undefined, var_0);
}

aud_rune_pressed(var_0) {
  var_1 = var_0.origin + (0, -10, 0);
  var_0.press_snd = _id_0380::_id_2889("zmb_dig_rune_press", undefined, var_1);
}

aud_rune_all_runes_pressed(var_0) {
  var_1 = (134, 2871, 421);
  var_2 = _id_0380::_id_2889("zmb_dig_rune_wall_hide", undefined, var_1);
}

aud_rune_all_runes_unpressed(var_0) {
  var_1 = (134, 2871, 421);
  wait 0.5;
  var_2 = _id_0380::_id_2889("zmb_dig_rune_wall_show", undefined, var_1);
}

aud_place_sword_piece(var_0) {
  switch (var_0.piece) {
    case "hilt":
      _id_0380::_id_2889("zmb_dig_barb_place_hilt", undefined, var_0.plate_core.origin);
      level._id_11CB.sword_piece_place_lp_01 = _id_0380::_id_6842("zmb_dig_forge_sword_place_lp_01", undefined, var_0.plate_core.origin, 1);
      break;
    case "pommel":
      _id_0380::_id_2889("zmb_dig_barb_place_pommel", undefined, var_0.plate_core.origin);
      level._id_11CB.sword_piece_place_lp_02 = _id_0380::_id_6842("zmb_dig_forge_sword_place_lp_02", undefined, var_0.plate_core.origin, 1);
      break;
    case "blade":
      _id_0380::_id_2889("zmb_dig_barb_place_blade", undefined, var_0.plate_core.origin);
      level._id_11CB.sword_piece_place_lp_03 = _id_0380::_id_6842("zmb_dig_forge_sword_place_lp_03", undefined, var_0.plate_core.origin, 1);
      break;
  }
}

aud_assemble_sword() {
  var_0 = self;

  if(isDefined(level._id_11CB.sword_piece_place_lp_01))
    _id_0380::_id_6850(level._id_11CB.sword_piece_place_lp_01, 0.75);

  if(isDefined(level._id_11CB.sword_piece_place_lp_02))
    _id_0380::_id_6850(level._id_11CB.sword_piece_place_lp_02, 0.75);

  if(isDefined(level._id_11CB.sword_piece_place_lp_03))
    _id_0380::_id_6850(level._id_11CB.sword_piece_place_lp_03, 0.75);

  _id_0380::_id_2889("zmb_dig_forge_sword_buildup", undefined, var_0.origin);
  level._id_11CB.sword_assamble_lp = _id_0380::_id_6842("zmb_dig_forge_sword_lp", undefined, var_0.origin, 3);
  thread sword_assemble_elec_oneshots(var_0.origin);
  thread sword_assemble_whoosh_oneshots(var_0.origin);
}

sword_pieces_combine(var_0, var_1) {
  var_2 = self;
  wait(var_1 - 1);
  _id_0380::_id_2889("zmb_dig_forge_sword_combine_into", undefined, var_0);
}

sword_assemble_elec_oneshots(var_0) {
  level endon("stop_sword_assemble_sounds");
  wait 3;

  for(;;) {
    var_1 = _func_0A4(5, 8);
    var_2 = var_0 + (_func_0A4(-200, 200), _func_0A4(-200, 200), 0);
    _id_0380::_id_2889("zmb_dig_forge_sword_elec_oneshot", undefined, var_2);
    wait(var_1);
  }
}

sword_assemble_whoosh_oneshots(var_0) {
  level endon("stop_sword_assemble_sounds");
  wait 3;

  for(;;) {
    var_1 = _func_0A4(4, 9);
    var_2 = var_0 + (_func_0A4(-200, 200), _func_0A4(-200, 200), 0);
    _id_0380::_id_2889("zmb_dig_forge_sword_whoosh_oneshot", undefined, var_2);
    wait(var_1);
  }
}

aud_pickup_barbarosa_sword(var_0) {
  _id_0380::_id_288B("zmb_pickup_swrd", undefined, self);
  _id_0380::_id_6850(level._id_11CB.sword_assamble_lp, 0.5);
  _id_0380::_id_2889("zmb_dig_forge_sword_end", undefined, var_0);
  level notify("stop_sword_assemble_sounds");
}

aud_flare_crate_drop() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dig_flare_box_imp", undefined, var_0);
}

aud_pickup_flare() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dig_flare_box_foley", undefined, var_0);
}

aud_fount_elec_drop() {}

aud_brazier_light() {
  var_0 = self;
  var_0.snd_handle = _id_0380::_id_6842("zmb_dig_torch_sml", undefined, var_0.origin, 0.5);
}

aud_brazier_light_stop() {
  var_0 = self;

  if(isDefined(var_0.snd_handle))
    _id_0380::_id_6850(var_0.snd_handle, 0.5);
}

aud_basalt_move() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dig_rune_compartment", undefined, var_0);
}

aud_dig_earthquake(var_0, var_1, var_2) {
  foreach(var_4 in level.players)
  var_4 _meth_8626("dig_earthquake_mix");

  var_6 = 1;

  if(var_2 == 0)
    var_6 = 0.65;

  if(var_2 == 1)
    var_6 = 0.8;

  if(var_2 == 2)
    var_6 = 1;

  switch (var_0) {
    case "rumble1":
      if(!isDefined(level._id_11CB.dig_earthquake_phase1_handle)) {
        var_7 = var_1 * 1.4;
        var_8 = 2.5;
        _id_0366::_id_8E30(0.75, var_7);
        level._id_11CB.dig_earthquake_phase1_handle = _id_0380::_id_6840("zone1Earthquake_phase1", undefined, var_7, var_6);
      }

      break;
    case "rumble2":
      if(!isDefined(level._id_11CB.dig_earthquake_phase2_handle)) {
        var_7 = var_1;
        var_8 = 1.0;
        level._id_11CB.dig_earthquake_phase2_handle = _id_0380::_id_6840("zone1Earthquake_phase2", undefined, var_7, var_6);
      }

      break;
    case "rumble3":
      if(!isDefined(level._id_11CB.dig_earthquake_phase3_handle)) {
        var_7 = var_1 * 0.6;
        var_8 = 1.0;
        _id_0366::_id_8E30(0.5, var_7);
        level._id_11CB.dig_earthquake_phase3_handle = _id_0380::_id_6840("zone1Earthquake_phase3", undefined, var_7, var_6);
      }

      break;
    case "earthquake":
      if(!isDefined(level._id_11CB.dig_earthquake_phase4_handle)) {
        var_7 = 0.75;
        var_8 = var_1 * 0.65;
        _id_0366::_id_8E30(0.25, var_7);
        level._id_11CB.dig_earthquake_phase4_handle = _id_0380::_id_6840("zone1Earthquake_phase4", undefined, var_7, var_6);
        wait(var_1 * 0.5);
        aud_dig_earthquake_stop(var_8);
        wait 0.4;
        _id_0380::_id_6840("zone1Earthquake_settle", undefined, var_7, var_6);
      }

      break;
  }
}

aud_dig_earthquake_stop(var_0) {
  _id_0366::_id_8E30(1.0, var_0);

  foreach(var_2 in level.players)
  var_2 _meth_8627("dig_earthquake_mix");

  if(isDefined(level._id_11CB.dig_earthquake_phase1_handle))
    _id_0380::_id_6850(level._id_11CB.dig_earthquake_phase1_handle, var_0);

  if(isDefined(level._id_11CB.dig_earthquake_phase2_handle))
    _id_0380::_id_6850(level._id_11CB.dig_earthquake_phase2_handle, var_0 * 1.3);

  if(isDefined(level._id_11CB.dig_earthquake_phase3_handle))
    _id_0380::_id_6850(level._id_11CB.dig_earthquake_phase3_handle, var_0);

  if(isDefined(level._id_11CB.dig_earthquake_phase4_handle))
    _id_0380::_id_6850(level._id_11CB.dig_earthquake_phase4_handle, var_0);

  level._id_11CB.dig_earthquake_phase1_handle = undefined;
  level._id_11CB.dig_earthquake_phase2_handle = undefined;
  level._id_11CB.dig_earthquake_phase3_handle = undefined;
  level._id_11CB.dig_earthquake_phase4_handle = undefined;
}

klaus_encounter() {
  if(!isDefined(self.aud_klaus_encounter_index)) {
    self.aud_klaus_encounter_index = 0;
    level._id_11CB.plr_threat_to_whisper_vol_env = [[0.0, 0.4], [1.0, 1.0]];
  }

  var_0 = 5;
  var_1 = common_scripts\utility::_id_627D(self.aud_klaus_encounter_index, var_0) + 1;
  self.aud_klaus_encounter_index = self.aud_klaus_encounter_index + 1;
  var_2 = 0;
  var_3 = _id_0378::_id_8D72(_id_0366::_id_8E14(), level._id_11CB.plr_threat_to_whisper_vol_env);
  _id_0380::_id_2888("zmb_dlc3_klaus_encounter" + var_1, self, var_2, var_3);
}

aud_trap_spikes(var_0) {
  wait 0.3;
  var_1 = 1;
  var_2 = 0;

  while(var_1) {
    _id_0380::_id_2889("trap_spikes", undefined, var_0);
    _id_0380::_id_2889("zmb_dig_spike_trap_splash", undefined, (1, 1490, 192));

    if(var_2 < 19)
      var_2++;
    else
      var_1 = 0;

    wait 1;
  }
}

_id_ABF8(var_0, var_1) {
  var_2 = spawn("script_origin", var_0);
  var_3 = 0;
  var_4 = 0.875;
  _id_0380::_id_288B("zombie_soul_suck", undefined, var_2, 0, var_4);
  var_2 _meth_82B1(var_1, 1.9);
  wait 2.0;
  var_2 delete();
}

_id_ABF9(var_0) {
  _id_0380::_id_2889("zombie_soul_suck_threshold", undefined, var_0);
}