/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_windmill_aud.gsc
******************************************************/

main() {
  _id_0367::_id_8E3E("bp_wind");
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
  _id_0378::_id_8DC7("zombie_soul_suck", ::_id_ABF8);
  _id_0378::_id_8DC7("frank_rope_shot", ::frank_rope_shot);
  _id_0378::_id_8DC7("frank_pull_branch", ::frank_pull_branch);
  _id_0378::_id_8DC7("lightning_strike", ::lightning_strike_in_play_space);
  _id_0378::_id_8DC7("bomber_barricade_explosion", ::bomber_barricade_explosion);
  _id_0378::_id_8DC7("start_windmill_rotate", ::start_windmill_rotate);
  _id_0378::_id_8DC7("stop_windmill", ::stop_windmill);
  _id_0378::_id_8DC7("start_gears", ::start_gears);
  _id_0378::_id_8DC7("stop_gears", ::stop_gears);
  _id_0378::_id_8DC7("wustling_arm_jam", ::wustling_arm_jam);
  _id_0378::_id_8DC7("drop_bombs_fall", ::drop_bombs_fall);
  _id_0378::_id_8DC7("drop_bombs_explosion", ::drop_bombs_explosion);
  _id_0378::_id_8DC7("aud_droppod_launch", ::aud_droppod_launch);
  _id_0378::_id_8DC7("aud_droppod_landed", ::aud_droppod_landed);
  _id_0378::_id_8DC7("aud_open_droppod_door", ::aud_open_droppod_door);
  _id_0378::_id_8DC7("wine_cellar_door_open", ::wine_cellar_door_open);
  _id_0378::_id_8DC7("call_lightning_do_strike", ::call_lightning_do_strike);
  _id_0378::_id_8DC7("call_lightning_frank_fall", ::call_lightning_frank_fall);
  _id_0378::_id_8DC7("aud_radio_repaired", ::radio_repaired);
}

_id_5C22() {
  thread _id_35E1();
}

_id_35E1() {
  wait 0.5;
  _id_0380::_id_6842("emt_wm_fire_metal_small_lp", undefined, (-13818, 1699, -251));
  _id_0380::_id_6842("emt_wm_fire_wood_small_lp", undefined, (-13645, 1957, -306));
  _id_0380::_id_6842("emt_wm_fireplace2_lp", undefined, (-13043, 3863, -243));
}

start_intermission_music_override_callback() {
  var_0 = level._id_11CB.intermission_music_aliases[randomint(level._id_11CB.intermission_music_aliases.size)];
  var_1 = 3.0;
  var_2 = 5.0;
  _id_0366::_id_8E31(var_0, var_1, var_2);
}

_id_7248() {
  if(!isDefined(self._id_11CB))
    self._id_11CB = spawnStruct();
}

_id_7330() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_player_spawned();
  self clientaddsoundsubmix("windmill_default_mix");
}

_id_A979(var_0) {
  soundscripts\_snd_common_zmb_dlc3::dlc3_wave_begin(var_0);
  self clientclearsoundsubmix("wm_intermission_mix");
}

_id_A97A() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_wave_end();
  self clientaddsoundsubmix("wm_intermission_mix");
}

lightning_strike_in_play_space(var_0, var_1) {
  if(!isDefined(level._id_11CB.lightning_strike_counter))
    level._id_11CB.lightning_strike_counter = 0;

  var_2 = undefined;
  var_3 = common_scripts\utility::_id_627D(level._id_11CB.lightning_strike_counter, 2);

  if(var_3) {
    var_4 = _id_0380::_id_6842("zmb_wm_lightning_strike", undefined, var_1);
    _id_0378::_id_8D14(isDefined(var_4), "lightning_strike", 1);
  } else {
    var_2 = spawn("script_origin", var_0);
    var_4 = _id_0380::_id_6844("zmb_wm_lightning_strike", undefined, var_2);
    _id_0378::_id_8D14(isDefined(var_4), "lightning_strike", 1);
    var_2 moveto(var_1, 0.2);
  }

  level._id_11CB.lightning_strike_counter = level._id_11CB.lightning_strike_counter + 1;
  var_4 = _id_0380::_id_6842("zmb_wm_thunder", undefined, var_0);
  _id_0378::_id_8D14(isDefined(var_4), "lightning_strike", 1);
  wait 0.25;
  var_4 = _id_0380::_id_6842("exp_grnd_zero_rock_tear", undefined, var_1, 0, 0.333);
  _id_0378::_id_8D14(isDefined(var_4), "lightning_strike", 1);
  var_4 = _id_0380::_id_6842("exp_debris_dirt_chunks", undefined, var_1, 0, 0.333);
  _id_0378::_id_8D14(isDefined(var_4), "lightning_strike", 1);
  wait 0.2;

  if(isDefined(var_2)) {
    wait 10;
    var_2 delete();
  }
}

bomber_barricade_explosion(var_0) {
  foreach(var_2 in var_0) {
    _id_0380::_id_2889("bomber_barricade_explo_debris", undefined, var_2.origin);
    wait 0.25;
  }
}

start_windmill_rotate(var_0) {
  var_1 = self;

  if(var_0 > 0) {
    var_2 = var_1.origin + (0, -150, 0);
    _id_0380::_id_2889("zmb_dig_windmill_strt", undefined, var_2);
    level._id_11CB.windmill_lp = _id_0380::_id_6842("zmb_dig_windmill_lp", undefined, var_2, 0.3);
    thread windmill_rotate_wood_creaks(var_2, var_0);
    thread windmill_rotate_metal_creaks(var_2, var_0);
  }
}

windmill_rotate_wood_creaks(var_0, var_1) {
  level endon("game_ended");
  self endon("windmill_snd_stopped");
  var_2 = self;

  for(;;) {
    var_3 = _randomintrange(5, 8);
    var_4 = _id_0380::_id_2889("zmb_dig_windmill_wood_creaks", undefined, var_0);
    wait(var_3);
  }
}

windmill_rotate_metal_creaks(var_0, var_1) {
  level endon("game_ended");
  self endon("windmill_snd_stopped");
  var_2 = self;

  for(;;) {
    var_3 = _randomintrange(12, 18);
    var_4 = _id_0380::_id_2889("zmb_dig_windmill_metal_creaks", undefined, var_0);
    wait(var_3);
  }
}

stop_windmill(var_0) {
  var_1 = self;
  var_2 = var_1.origin + (0, -150, 0);
  _id_0380::_id_6850(level._id_11CB.windmill_lp, var_0);
  _id_0380::_id_2889("zmb_dig_windmill_stop", undefined, var_2);
  self notify("windmill_snd_stopped");
}

start_gears(var_0) {
  var_1 = var_0[0];
  var_2 = var_1.origin + (75, 10, 100);
  level._id_11CB.gears_lp = _id_0380::_id_6842("zmb_windmill_gears_lp", undefined, var_2, 0.3);
  gear_one_shots(var_2, var_1);
}

gear_one_shots(var_0, var_1) {
  var_1 endon("gear_sounds_stopped");

  for(;;) {
    var_2 = _randomintrange(5, 8);
    var_3 = _id_0380::_id_2889("zmb_windmill_gear_creaks", undefined, var_0);
    _id_0380::_id_288F(var_3, var_1, "gear_creak_done");
    var_1 waittill("gear_creak_done");
    wait(var_2);
  }
}

stop_gears(var_0) {
  var_1 = var_0[0];
  var_2 = var_1.origin + (75, 10, 100);
  _id_0380::_id_6850(level._id_11CB.gears_lp, 0.5);
  _id_0380::_id_2889("zmb_windmill_gears_stop", undefined, var_2);
  var_1 notify("gear_sounds_stopped");
}

wustling_arm_jam() {
  _id_0380::_id_288B("zmb_windmill_wustling_arm_toss", undefined, self);
}

drop_bombs_fall(var_0, var_1) {
  drop_bombs_fall_stop_fall_sounds(var_0);
  var_2 = 7;
  var_3 = 4;
  var_4 = 0.666;
  var_5 = var_2 * _randomfloatrange(0.25, 0.75);
  maps\mp\_utility::_id_2CED(var_1 - var_2, _id_0380::_id_6842, "zmb_bomb_drop_incoming_whistle", level.players, var_0.origin, var_5);
  maps\mp\_utility::_id_2CED(var_1 - var_3, _id_0380::_id_6842, "zmb_bomb_drop_incoming", level.players, var_0.origin);
  maps\mp\_utility::_id_2CED(var_1 - var_4, _id_0380::_id_6842, "zmb_bomb_drop_incoming_close", level.players, var_0.origin);
}

drop_bombs_explosion(var_0) {
  drop_bombs_fall_stop_fall_sounds(var_0);
  var_1 = _id_0380::_id_6842("zmb_bomb_drop_explo", undefined, var_0.origin);
}

drop_bombs_fall_stop_fall_sounds(var_0) {
  _id_0380::_id_6850(var_0.aud_zmb_bomb_drop_incoming_whistle, 0.1);
  _id_0380::_id_6850(var_0.aud_zmb_bomb_drop_incoming, 0.1);
  _id_0380::_id_6850(var_0.aud_zmb_bomb_drop_incoming_close, 0.1);
  var_0.aud_zmb_bomb_drop_incoming_whistle = undefined;
  var_0.aud_zmb_bomb_drop_incoming = undefined;
  var_0.aud_zmb_bomb_drop_incoming_close = undefined;
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

frank_rope_shot() {
  var_0 = self;
  waitframe();
  _id_0380::_id_2889("zmb_windmill_rope_shot", undefined, var_0.origin);
}

frank_pull_branch(var_0) {
  var_1 = self;

  switch (var_0) {
    case "pulling":
      _id_0380::_id_288B("zmb_windmill_branch_start", undefined, var_1);
      var_1.branch_drag_lp = _id_0380::_id_6844("zmb_windmill_drag_branch_lp", undefined, var_1, 0.3);
      break;
    case "stopped":
      if(!common_scripts\utility::_id_3C77("ee_find_rope_branch_pull_complete")) {
        _id_0380::_id_6850(var_1.branch_drag_lp, 0.3);
        _id_0380::_id_288B("zmb_windmill_branch_stop", undefined, var_1);
      }
    case "end":
      if(common_scripts\utility::_id_3C77("ee_find_rope_branch_pull_complete")) {
        _id_0380::_id_6850(var_1.branch_drag_lp, 0.3);
        _id_0380::_id_288B("zmb_windmill_branch_end", undefined, var_1);
        return;
      }
  }
}

_id_ABF9(var_0) {
  _id_0380::_id_2889("zombie_soul_suck_threshold", undefined, var_0);
}

js_corpse_becomes_zombie() {
  _id_0366::snd_not_so_simple_jump_scare();
}

aud_droppod_launch() {
  var_0 = self;
  level._id_11CB.droppod_released = _id_0380::_id_288B("zmb_dig_zepp_droppod_released", undefined, var_0);
}

aud_droppod_landed(var_0) {
  _id_0380::_stoplocalsound(level._id_11CB.droppod_released, 0.3);
  _id_0380::_id_2889("zmb_dig_droppod_impact", undefined, var_0);
}

aud_open_droppod_door() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dig_droppod_door_open", undefined, var_0);
}

wine_cellar_door_open(var_0) {
  _id_0380::_id_2889("wine_cellar_door_open", undefined, var_0);
}

call_lightning_do_strike(var_0) {
  _id_0380::_id_2889("zmb_lightning_shock", undefined, var_0);
}

call_lightning_frank_fall(var_0) {
  waitframe();
  var_1 = _id_0380::_id_6844("zmb_lightning_death_scream", undefined, var_0);
  var_2 = _id_0380::_id_6844("zmb_windmill_frank_fall", undefined, var_0);
  wait 2;
  _id_0380::_id_6844("zmb_windmill_frank_land", undefined, var_0);
}

radio_repaired() {
  var_0 = self;
  _id_0380::_id_288B("zmb_windmill_radio_repair_done", undefined, var_0);
}