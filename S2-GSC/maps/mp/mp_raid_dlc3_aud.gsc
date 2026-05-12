/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_dlc3_aud.gsc
*********************************************/

func_00F9() {
  lib_02F0::func_7FE7();
  level thread lib_04F3::func_533A();
  func_51D8();
  maps\mp\_audio_submixes::func_524C();
  func_5C22();
  thread func_5C18();
  func_7BD2();
  lib_02F0::func_8014("sndentity");
}

func_51D8() {}

func_5C22() {}

func_5C18() {
  wait(0.5);
  lib_0380::func_6842("fire_wolod_lrg_lp", undefined, (-3906, 3150, 424));
  lib_0380::func_6842("fire_wolod_sml_lp", undefined, (-4009, 3141, 415));
  lib_0380::func_6842("fire_metal_med_lp", undefined, (-3787, 3133, 415));
  lib_0380::func_6842("fire_metal_med_lp", undefined, (-6116, 5037, 443));
  lib_0380::func_6842("fire_wolod_lrg_lp", undefined, (-3773, 5165, 410));
  lib_0380::func_6842("fire_wolod_lrg_lp", undefined, (-3018, 3298, 654));
  lib_0380::func_6842("fire_wolod_sml_lp", undefined, (-2993, 3383, 576));
  lib_0380::func_6842("fire_wolod_lrg_lp", undefined, (-2747, 3625, 420));
  lib_0380::func_6842("fire_wolod_mked_lp", undefined, (-2072, 3309, 462));
  lib_0380::func_6842("fire_wolod_mked_lp", undefined, (-3588, 5151, 304));
  lib_0380::func_6842("fire_wolod_sml_lp", undefined, (-707, 2102, 528));
  lib_0380::func_6842("fire_wolod_mked_lp", undefined, (-229, 2602, 467));
  lib_0380::func_6842("fire_wolod_sml_lp", undefined, (-754, 2333, 384));
  lib_0380::func_6842("fire_wolod_lrg_lp", undefined, (509, 2962, 513));
  lib_0380::func_6842("fire_metal_med_lp", undefined, (-1547, 2843, 426));
  lib_0380::func_6842("fire_wolod_lrg_lp", undefined, (1055, 3250, 489));
  lib_0380::func_6842("fire_wolod_mked_lp", undefined, (1924, 2823, 495));
  lib_0380::func_6842("fire_wolod_mked_lp", undefined, (1939, 3976, 588));
  lib_0380::func_6842("fire_wolod_sml_lp", undefined, (1828, 3913, 504));
  lib_0380::func_6842("fire_wolod_sml_lp", undefined, (1424, 4400, 569));
  lib_0380::func_6842("fire_wolod_sml_lp", undefined, (938, 4757, 590));
  lib_0380::func_6842("fire_wolod_sml_lp", undefined, (1160, 4566, 554));
  lib_0380::func_6842("fire_wolod_lrg_lp", undefined, (571, 4032, 666));
  lib_0380::func_6842("fire_wolod_mked_lp", undefined, (-890, 4497, 709));
  lib_0380::func_6842("fire_wolod_mked_lp", undefined, (-737, 2101, 482));
  lib_0380::func_6842("fire_wolod_mked_lp", undefined, (-1205, 4359, 709));
  lib_0380::func_6842("fire_wolod_mked_lp", undefined, (-3056, 3294, 636));
  lib_0380::func_6842("fire_wolod_sml_lp", undefined, (3092, 5386, 324));
  lib_0380::func_6842("fire_wolod_mked_lp", undefined, (5557, 6672, 373));
  lib_0380::func_6842("fire_wolod_mked_lp", undefined, (2383, 4926, 361));
  lib_0380::func_6842("fire_wolod_sml_lp", undefined, (3888, 5600, 326));
  lib_0380::func_6842("fire_wolod_lrg_lp", undefined, (2705, 4525, 472));
}

func_7BD2() {
  lib_0378::func_8DC7("aud_train_start_moving", ::train_start_moving);
  lib_0378::func_8DC7("aud_sandstorm_start", ::sandstorm_start);
  lib_0378::func_8DC7("aud_npc_tank_enter", ::npc_tank_enter);
  lib_0378::func_8DC7("aud_bridge_bomb_A_exp", ::bridge_bomb_a_exp);
  lib_0378::func_8DC7("aud_bridge_bomb_B_exp", ::bridge_bomb_b_exp);
  lib_0378::func_8DC7("aud_bridge_bomb_C_exp", ::bridge_bomb_c_exp);
  lib_0378::func_8DC7("aud_bridge_bomb_D_exp", ::bridge_bomb_d_exp);
  lib_0378::func_8DC7("aud_intro_start_sfx", ::intro_start_sfx);
  lib_0378::func_8DC7("aud_intro_allies_mixing", ::intro_allies_mixing);
  lib_0378::func_8DC7("aud_intro_axis_mixing", ::intro_axis_mixing);
  lib_0378::func_8DC7("aud_allies_victory_sfx", ::allies_victory_sfx);
  lib_0378::func_8DC7("aud_axis_victory_sfx", ::axis_victory_sfx);
}

intro_start_sfx() {
  var_00 = 27;
  foreach(var_02 in level.var_744A) {
    var_02 thread maps\mp\_audio_submixes::func_8A9D("mp_war_intro_master", 0.1, 1);
    var_02 thread intro_mix_clear(var_00);
  }

  thread play_allies_intro_sfx();
  thread play_axis_intro_sfx();
}

play_allies_intro_sfx() {
  wait(0.1);
  lib_0380::func_6840("mp_tun_allies_intro_planes", undefined);
  wait(8.404);
  lib_0380::func_6840("mp_tun_allies_intro_fs_01", undefined);
  lib_0380::func_6840("mp_tun_allies_intro_fly_01", undefined);
  wait(7.227);
  lib_0380::func_6840("mp_tun_allies_intro_fs_02", undefined);
  lib_0380::func_6840("mp_tun_allies_intro_fly_02", undefined);
}

play_axis_intro_sfx() {
  wait(2.906);
  lib_0380::func_6840("mp_tun_axis_intro_fs_01", undefined);
  lib_0380::func_6840("mp_tun_axis_intro_fly_01", undefined);
  lib_0380::func_6840("mp_tun_axis_intro_planes", undefined);
}

intro_mix_clear(param_00) {
  wait(param_00);
  maps\mp\_audio_submixes::func_8A9F("mp_war_intro_master", 5);
}

intro_spectator_mixing() {
  maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_vignette", 1);
  maps\mp\_audio_submixes::func_8A9F("mp_war_intro_axis_vignette", 1);
}

intro_allies_mixing() {
  var_00 = self;
  var_01 = 1;
  var_02 = 6;
  var_03 = 0.707945;
  var_04 = 1 - var_03;
  var_05 = 30;
  var_06 = 1;
  if(isDefined(level.var_54D0["allies"]) == 1 && isDefined(level.var_54D0["allies"].var_9309) == 1) {
    var_07 = level.var_54D0["allies"].var_9309;
    var_00 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_vignette", 0.1, 1);
    wait 0.05;
    var_00 maps\mp\_audio_submixes::func_8A9E("mp_war_intro_master", var_04, var_01);
    wait(var_01);
    var_08 = gettime();
    var_09 = var_08 - var_07;
    var_0A = var_09 * 0.001;
    if(var_0A < var_02) {
      var_02 = var_02 - var_0A;
    }

    var_00 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_master", var_02);
    var_0B = var_05 - var_02 - var_01;
    if(var_0B > 0.05) {
      wait(var_0B);
    }

    var_00 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_vignette", var_06);
  }
}

intro_axis_mixing() {
  var_00 = self;
  var_01 = 1;
  var_02 = 6;
  var_03 = 0.707945;
  var_04 = 1 - var_03;
  var_05 = 30;
  var_06 = 1;
  if(isDefined(level.var_54D0["axis"]) == 1 && isDefined(level.var_54D0["allies"].var_9309) == 1) {
    var_07 = level.var_54D0["axis"].var_9309;
    var_00 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_axis_vignette", 0.1, 1);
    wait 0.05;
    var_00 maps\mp\_audio_submixes::func_8A9E("mp_war_intro_master", var_04, var_01);
    wait(var_01);
    var_08 = gettime();
    var_09 = var_08 - var_07;
    var_0A = var_09 * 0.001;
    if(var_0A < var_02) {
      var_02 = var_02 - var_0A;
    }

    var_00 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_master", var_02);
    var_0B = var_05 - var_02 - var_01;
    if(var_0B > 0.05) {
      wait(var_0B);
    }

    var_00 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_axis_vignette", var_06);
  }
}

allies_victory_sfx() {
  thread outro_vignette_submix();
  lib_0380::func_6840("mp_tun_allies_outro_fs_01", undefined);
  lib_0380::func_6840("mp_tun_allies_outro_fly_01", undefined);
  lib_0380::func_6840("mp_tun_allies_outro_gun_shots", undefined);
  wait(0.285);
  lib_0380::func_6840("mp_tun_stun_grenade_exp", undefined);
}

axis_victory_sfx() {
  thread outro_vignette_submix();
  lib_0380::func_6840("mp_tun_axis_outro_fs_01", undefined);
  lib_0380::func_6840("mp_tun_axis_outro_fly_01", undefined);
}

outro_vignette_submix() {
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_outro_vignette");
  }
}

npc_tank_enter() {
  wait(0.4);
  self endon("death");
  var_00 = 0;
  var_01 = lib_0380::func_6844("tunisia_tank_npc_med_lp", undefined, self, 1, 1);
  var_02 = lib_0380::func_6844("tunisia_tank_npc_idle_lp", undefined, self, 1, 1);
  var_03 = lib_0380::func_6844("tunisia_tank_npc_tread_lp", undefined, self, 1, 1);
  var_04 = lib_0380::func_6844("tunisia_tank_npc_crunch_lp", undefined, self, 1, 1);
  while(isDefined(self) == 1) {
    var_05 = self method_8283();
    if(var_05 == 0) {
      if(var_00 == 1) {
        var_00 = 0;
        lib_0380::func_6844("tunisia_tank_npc_brake", undefined, self, 0, 1);
        lib_0380::func_684E(var_01, 0, 0.5);
        lib_0380::func_684E(var_03, 0, 0.5);
        lib_0380::func_684E(var_04, 0, 0.5);
        lib_0380::func_684E(var_02, 1, 0.5);
      }

      continue;
    }

    if(var_00 == 0) {
      var_00 = 1;
      lib_0380::func_6844("tunisia_tank_npc_ramp_up", undefined, self, 0, 1);
      lib_0380::func_684E(var_01, 1, 0.5);
      lib_0380::func_684E(var_03, 1, 0.5);
      lib_0380::func_684E(var_04, 1, 0.5);
      lib_0380::func_684E(var_02, 0, 0.5);
    }

    wait 0.05;
  }
}

train_start_moving() {
  var_00 = self;
  var_01 = spawn("script_origin", var_00.var_116);
  wait(0.5);
  lib_0380::func_6844("train_whistle", undefined, var_01);
  wait(3);
  lib_0380::func_6844("train_move", undefined, var_01);
  wait(4);
  var_01 moveto((246, 1450, 1217), 14);
}

bridge_bomb_a_exp(param_00) {
  var_01 = (-524, 4370, 799);
  function_0349("mp_tunisia_bridge_exp_mix");
  lib_0380::func_6842("bridge_a_charge_explode", undefined, var_01);
  wait(param_00);
  function_034A("mp_tunisia_bridge_exp_mix");
  lib_0380::func_6842("bridge_a_explode_main", undefined, var_01);
  wait(0.85);
  lib_0380::func_6842("bridge_boulder_impact", undefined, (-427, 4200, 630));
  wait(0.15);
  lib_0380::func_6842("bridge_boulder_impact", undefined, (-433, 4535, 630));
  wait(0.5);
  lib_0380::func_6842("bridge_boulder_impact", undefined, (-427, 4200, 630));
}

bridge_bomb_b_exp(param_00) {
  var_01 = (-366, 3877, 774);
  lib_0380::func_6842("bridge_b_charge_explode", undefined, var_01);
  wait(param_00);
  lib_0380::func_6842("bridge_b_explode_main", undefined, var_01);
  wait(0.85);
  lib_0380::func_6842("bridge_boulder_impact", undefined, (-426, 4118, 645));
  wait(0.1);
  lib_0380::func_6842("bridge_boulder_impact", undefined, (-252, 3694, 576));
}

bridge_bomb_c_exp(param_00) {
  var_01 = (-216, 3372, 683);
  lib_0380::func_6842("bridge_c_charge_explode", undefined, var_01);
  wait(param_00);
  lib_0380::func_6842("bridge_c_explode_main", undefined, var_01);
  wait(0.85);
  lib_0380::func_6842("bridge_boulder_impact", undefined, (51, 3151, 482));
  wait(0.3);
  lib_0380::func_6842("bridge_boulder_impact", undefined, (-305, 3573, 578));
  wait(0.3);
  lib_0380::func_6842("bridge_boulder_impact", undefined, (-8, 3237, 555));
}

bridge_bomb_d_exp(param_00) {
  var_01 = (-87, 2867, 668);
  lib_0380::func_6842("bridge_d_charge_explode", undefined, var_01);
  wait(param_00);
  lib_0380::func_6842("bridge_d_explode_main", undefined, var_01);
  wait(0.6);
  lib_0380::func_6842("bridge_boulder_impact", undefined, (-58, 3084, 453));
  wait(1.15);
  lib_0380::func_6842("bridge_boulder_impact", undefined, (-58, 3084, 453));
}

sandstorm_start() {
  if(isDefined(level.var_744A) && level.var_744A.size > 0) {
    foreach(var_01 in level.var_744A) {
      lib_0380::func_6844("sandstorm_lp", var_01, var_01, 10);
    }
  }
}