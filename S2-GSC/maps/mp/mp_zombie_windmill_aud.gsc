/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_windmill_aud.gsc
**********************************************/

func_00F9() {
  lib_0367::func_8E3E("bp_wind");
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
  lib_0378::func_8DC7("zombie_soul_suck", ::func_ABF8);
  lib_0378::func_8DC7("frank_rope_shot", ::frank_rope_shot);
  lib_0378::func_8DC7("frank_pull_branch", ::frank_pull_branch);
  lib_0378::func_8DC7("lightning_strike", ::lightning_strike_in_play_space);
  lib_0378::func_8DC7("bomber_barricade_explosion", ::bomber_barricade_explosion);
  lib_0378::func_8DC7("start_windmill_rotate", ::start_windmill_rotate);
  lib_0378::func_8DC7("stop_windmill", ::stop_windmill);
  lib_0378::func_8DC7("start_gears", ::start_gears);
  lib_0378::func_8DC7("stop_gears", ::stop_gears);
  lib_0378::func_8DC7("wustling_arm_jam", ::wustling_arm_jam);
  lib_0378::func_8DC7("drop_bombs_fall", ::drop_bombs_fall);
  lib_0378::func_8DC7("drop_bombs_explosion", ::drop_bombs_explosion);
  lib_0378::func_8DC7("aud_droppod_launch", ::aud_droppod_launch);
  lib_0378::func_8DC7("aud_droppod_landed", ::aud_droppod_landed);
  lib_0378::func_8DC7("aud_open_droppod_door", ::aud_open_droppod_door);
  lib_0378::func_8DC7("wine_cellar_door_open", ::wine_cellar_door_open);
  lib_0378::func_8DC7("call_lightning_do_strike", ::call_lightning_do_strike);
  lib_0378::func_8DC7("call_lightning_frank_fall", ::call_lightning_frank_fall);
  lib_0378::func_8DC7("aud_radio_repaired", ::radio_repaired);
}

func_5C22() {
  thread func_35E1();
}

func_35E1() {
  wait(0.5);
  lib_0380::func_6842("emt_wm_fire_metal_small_lp", undefined, (-13818, 1699, -251));
  lib_0380::func_6842("emt_wm_fire_wood_small_lp", undefined, (-13645, 1957, -306));
  lib_0380::func_6842("emt_wm_fireplace2_lp", undefined, (-13043, 3863, -243));
}

start_intermission_music_override_callback() {
  var_00 = level.var_11CB.intermission_music_aliases[randomint(level.var_11CB.intermission_music_aliases.size)];
  var_01 = 3;
  var_02 = 5;
  lib_0366::func_8E31(var_00, var_01, var_02);
}

func_7248() {
  if(!isDefined(self.var_11CB)) {
    self.var_11CB = spawnStruct();
  }
}

func_7330() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_player_spawned();
  self method_8626("windmill_default_mix");
}

func_A979(param_00) {
  soundscripts\_snd_common_zmb_dlc3::dlc3_wave_begin(param_00);
  self method_8627("wm_intermission_mix");
}

func_A97A() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_wave_end();
  self method_8626("wm_intermission_mix");
}

lightning_strike_in_play_space(param_00, param_01) {
  if(!isDefined(level.var_11CB.lightning_strike_counter)) {
    level.var_11CB.lightning_strike_counter = 0;
  }

  var_02 = undefined;
  var_03 = common_scripts\utility::func_627D(level.var_11CB.lightning_strike_counter, 2);
  if(var_03) {
    var_04 = lib_0380::func_6842("zmb_wm_lightning_strike", undefined, param_01);
    lib_0378::func_8D14(isDefined(var_04), "lightning_strike", 1);
  } else {
    var_03 = spawn("script_origin", param_01);
    var_04 = lib_0380::func_6844("zmb_wm_lightning_strike", undefined, var_03);
    lib_0378::func_8D14(isDefined(var_04), "lightning_strike", 1);
    var_02 moveto(param_01, 0.2);
  }

  level.var_11CB.lightning_strike_counter = level.var_11CB.lightning_strike_counter + 1;
  var_04 = lib_0380::func_6842("zmb_wm_thunder", undefined, param_00);
  lib_0378::func_8D14(isDefined(var_04), "lightning_strike", 1);
  wait(0.25);
  var_04 = lib_0380::func_6842("exp_grnd_zero_rock_tear", undefined, param_01, 0, 0.333);
  lib_0378::func_8D14(isDefined(var_04), "lightning_strike", 1);
  var_04 = lib_0380::func_6842("exp_debris_dirt_chunks", undefined, param_01, 0, 0.333);
  lib_0378::func_8D14(isDefined(var_04), "lightning_strike", 1);
  wait(0.2);
  if(isDefined(var_02)) {
    wait(10);
    var_02 delete();
  }
}

bomber_barricade_explosion(param_00) {
  foreach(var_02 in param_00) {
    lib_0380::func_2889("bomber_barricade_explo_debris", undefined, var_02.var_116);
    wait(0.25);
  }
}

start_windmill_rotate(param_00) {
  var_01 = self;
  if(param_00 > 0) {
    var_02 = var_01.var_116 + (0, -150, 0);
    lib_0380::func_2889("zmb_dig_windmill_strt", undefined, var_02);
    level.var_11CB.windmill_lp = lib_0380::func_6842("zmb_dig_windmill_lp", undefined, var_02, 0.3);
    thread windmill_rotate_wood_creaks(var_02, param_00);
    thread windmill_rotate_metal_creaks(var_02, param_00);
  }
}

windmill_rotate_wood_creaks(param_00, param_01) {
  level endon("game_ended");
  self endon("windmill_snd_stopped");
  var_02 = self;
  for(;;) {
    var_03 = randomintrange(5, 8);
    var_04 = lib_0380::func_2889("zmb_dig_windmill_wood_creaks", undefined, param_00);
    wait(var_03);
  }
}

windmill_rotate_metal_creaks(param_00, param_01) {
  level endon("game_ended");
  self endon("windmill_snd_stopped");
  var_02 = self;
  for(;;) {
    var_03 = randomintrange(12, 18);
    var_04 = lib_0380::func_2889("zmb_dig_windmill_metal_creaks", undefined, param_00);
    wait(var_03);
  }
}

stop_windmill(param_00) {
  var_01 = self;
  var_02 = var_01.var_116 + (0, -150, 0);
  lib_0380::func_6850(level.var_11CB.windmill_lp, param_00);
  lib_0380::func_2889("zmb_dig_windmill_stop", undefined, var_02);
  self notify("windmill_snd_stopped");
}

start_gears(param_00) {
  var_01 = param_00[0];
  var_02 = var_01.var_116 + (75, 10, 100);
  level.var_11CB.gears_lp = lib_0380::func_6842("zmb_windmill_gears_lp", undefined, var_02, 0.3);
  gear_one_shots(var_02, var_01);
}

gear_one_shots(param_00, param_01) {
  param_01 endon("gear_sounds_stopped");
  for(;;) {
    var_02 = randomintrange(5, 8);
    var_03 = lib_0380::func_2889("zmb_windmill_gear_creaks", undefined, param_00);
    lib_0380::func_288F(var_03, param_01, "gear_creak_done");
    param_01 waittill("gear_creak_done");
    wait(var_02);
  }
}

stop_gears(param_00) {
  var_01 = param_00[0];
  var_02 = var_01.var_116 + (75, 10, 100);
  lib_0380::func_6850(level.var_11CB.gears_lp, 0.5);
  lib_0380::func_2889("zmb_windmill_gears_stop", undefined, var_02);
  var_01 notify("gear_sounds_stopped");
}

wustling_arm_jam() {
  lib_0380::func_288B("zmb_windmill_wustling_arm_toss", undefined, self);
}

drop_bombs_fall(param_00, param_01) {
  drop_bombs_fall_stop_fall_sounds(param_00);
  var_02 = 7;
  var_03 = 4;
  var_04 = 0.666;
  var_05 = var_02 * randomfloatrange(0.25, 0.75);
  maps\mp\_utility::func_2CED(param_01 - var_02, ::lib_0380::func_6842, "zmb_bomb_drop_incoming_whistle", level.var_744A, param_00.var_116, var_05);
  maps\mp\_utility::func_2CED(param_01 - var_03, ::lib_0380::func_6842, "zmb_bomb_drop_incoming", level.var_744A, param_00.var_116);
  maps\mp\_utility::func_2CED(param_01 - var_04, ::lib_0380::func_6842, "zmb_bomb_drop_incoming_close", level.var_744A, param_00.var_116);
}

drop_bombs_explosion(param_00) {
  drop_bombs_fall_stop_fall_sounds(param_00);
  var_01 = lib_0380::func_6842("zmb_bomb_drop_explo", undefined, param_00.var_116);
}

drop_bombs_fall_stop_fall_sounds(param_00) {
  lib_0380::func_6850(param_00.aud_zmb_bomb_drop_incoming_whistle, 0.1);
  lib_0380::func_6850(param_00.aud_zmb_bomb_drop_incoming, 0.1);
  lib_0380::func_6850(param_00.aud_zmb_bomb_drop_incoming_close, 0.1);
  param_00.aud_zmb_bomb_drop_incoming_whistle = undefined;
  param_00.aud_zmb_bomb_drop_incoming = undefined;
  param_00.aud_zmb_bomb_drop_incoming_close = undefined;
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

frank_rope_shot() {
  var_00 = self;
  wait 0.05;
  lib_0380::func_2889("zmb_windmill_rope_shot", undefined, var_00.var_116);
}

frank_pull_branch(param_00) {
  var_01 = self;
  switch (param_00) {
    case "pulling":
      lib_0380::func_288B("zmb_windmill_branch_start", undefined, var_01);
      var_01.branch_drag_lp = lib_0380::func_6844("zmb_windmill_drag_branch_lp", undefined, var_01, 0.3);
      break;

    case "stopped":
      if(!common_scripts\utility::func_3C77("ee_find_rope_branch_pull_complete")) {
        lib_0380::func_6850(var_01.branch_drag_lp, 0.3);
        lib_0380::func_288B("zmb_windmill_branch_stop", undefined, var_01);
      }

      break;

    case "end":
      if(common_scripts\utility::func_3C77("ee_find_rope_branch_pull_complete")) {
        lib_0380::func_6850(var_01.branch_drag_lp, 0.3);
        lib_0380::func_288B("zmb_windmill_branch_end", undefined, var_01);
      }

      break;
  }
}

func_ABF9(param_00) {
  lib_0380::func_2889("zombie_soul_suck_threshold", undefined, param_00);
}

js_corpse_becomes_zombie() {
  lib_0366::snd_not_so_simple_jump_scare();
}

aud_droppod_launch() {
  var_00 = self;
  level.var_11CB.droppod_released = lib_0380::func_288B("zmb_dig_zepp_droppod_released", undefined, var_00);
}

aud_droppod_landed(param_00) {
  lib_0380::func_2893(level.var_11CB.droppod_released, 0.3);
  lib_0380::func_2889("zmb_dig_droppod_impact", undefined, param_00);
}

aud_open_droppod_door() {
  var_00 = self;
  lib_0380::func_288B("zmb_dig_droppod_door_open", undefined, var_00);
}

wine_cellar_door_open(param_00) {
  lib_0380::func_2889("wine_cellar_door_open", undefined, param_00);
}

call_lightning_do_strike(param_00) {
  lib_0380::func_2889("zmb_lightning_shock", undefined, param_00);
}

call_lightning_frank_fall(param_00) {
  wait 0.05;
  var_01 = lib_0380::func_6844("zmb_lightning_death_scream", undefined, param_00);
  var_02 = lib_0380::func_6844("zmb_windmill_frank_fall", undefined, param_00);
  wait(2);
  lib_0380::func_6844("zmb_windmill_frank_land", undefined, param_00);
}

radio_repaired() {
  var_00 = self;
  lib_0380::func_288B("zmb_windmill_radio_repair_done", undefined, var_00);
}