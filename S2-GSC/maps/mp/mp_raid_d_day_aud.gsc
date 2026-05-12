/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_d_day_aud.gsc
*********************************************/

func_00F9() {
  register_mp_raid_dday_snd_messages();
  level thread lib_04F3::func_533A();
  level thread init_dday_war_mix();
  level thread func_18F5();
}

register_mp_raid_dday_snd_messages() {
  lib_0378::func_8DC7("aud_intro_start_sfx", ::intro_start_sfx);
  lib_0378::func_8DC7("aud_intro_allies_mixing", ::intro_allies_mixing);
  lib_0378::func_8DC7("aud_intro_axis_mixing", ::intro_axis_mixing);
  lib_0378::func_8DC7("aud_allies_victory_sfx", ::allies_victory_sfx);
  lib_0378::func_8DC7("aud_axis_victory_sfx", ::axis_victory_sfx);
  lib_0378::func_8DC7("aud_beach_mortar", ::beach_mortar);
  lib_0378::func_8DC7("aud_beach_mortar_explode_npc", ::beach_mortars_explode_npc);
  lib_0378::func_8DC7("aud_interlude_artillery", ::interlude_artillery);
  lib_0378::func_8DC7("aud_cannon_firing", ::cannon_firing);
  lib_0378::func_8DC7("aud_cannon_bombed", ::cannon_bombed);
}

init_dday_war_mix() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread apply_dday_war_mix();
  }
}

apply_dday_war_mix() {
  self endon("disconnect");
  var_00 = self;
  for(;;) {
    self waittill("spawned_player");
    var_00 maps\mp\_audio_submixes::func_8A9D("mp_war_dday_init_mix", 0.1, 1);
  }
}

func_18F5() {
  var_00 = common_scripts\utility::func_46B5("gun_01", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  level endon("guns_done");
  for(;;) {
    var_00 waittill("bomb_planted");
    lib_04F3::raidmusiconteam("attackers", "objective_bomb_planted", "objective_bomb_defused");
    var_00 waittill("bomb_defused");
    lib_04F3::raidmusiconteam("defenders", "objective_bomb_planted", "objective_bomb_defused");
  }
}

intro_start_sfx() {
  var_00 = 17;
  foreach(var_02 in level.var_744A) {
    var_02 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_master", 0.1, 1);
    var_02 thread intro_mix_clear(var_00);
  }

  lib_0380::func_6840("dday_intro_allies_planes", undefined);
  lib_0380::func_6840("dday_intro_allies_ocean", undefined);
  lib_0380::func_6840("dday_intro_allies_boat", undefined);
  wait(2.67);
  lib_0380::func_6840("dday_intro_allies_explosion", undefined);
  wait(11.14);
  lib_0380::func_6840("dday_intro_allies_beaching", undefined);
  wait(2.4);
  lib_0380::func_6840("dday_intro_allies_ramp", undefined);
  wait(4.22);
  lib_0380::func_6840("dday_intro_allies_footsteps", undefined);
  wait(0.98);
  lib_0380::func_6840("dday_intro_allies_mg42s", undefined);
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
  var_05 = 20;
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

beach_mortar() {
  var_00 = self;
  wait(1);
  lib_0380::func_6846("dday_beach_exp_incoming", undefined, var_00);
  wait(randomfloatrange(1, 1.3));
  lib_0380::func_6846("dday_beach_exp_incoming_close", undefined, var_00);
  var_00 waittill("death");
  if(isDefined(var_00)) {
    var_01 = var_00.var_116;
    lib_0380::func_6842("dday_beach_exp_close", undefined, var_01);
  }
}

beach_mortars_explode_npc() {
  var_00 = self.var_116;
  lib_0380::func_6842("dday_beach_exp_close", undefined, var_00);
}

interlude_artillery() {
  var_00 = self;
  wait(1);
  lib_0380::func_6846("dday_beach_exp_incoming", undefined, var_00);
  wait(randomfloatrange(1, 1.3));
  lib_0380::func_6846("dday_beach_exp_incoming_close", undefined, var_00);
  var_00 waittill("death");
  if(isDefined(var_00)) {
    var_01 = var_00.var_116;
    lib_0380::func_6842("ks_mstrike_exp", undefined, var_01);
  }
}

cannon_firing() {
  var_00 = self;
  lib_0380::func_6844("cannon_shot_tail", undefined, var_00);
}

cannon_bombed(param_00, param_01, param_02) {
  var_03 = 1;
  var_04 = 1;
  var_05 = "aud_stop_intact_arty_lps";
  if(isDefined(param_02) && isDefined(param_00) && isDefined(param_01)) {
    if(param_02 == 1) {
      var_06 = lib_0380::func_2889("mp_war_dday_arty_light_smolder_lp", undefined, param_01, var_03);
      lib_0380::func_5F2(var_06, var_04, var_05);
    }

    if(param_02 == 2) {
      var_07 = lib_0380::func_2889("mp_war_dday_arty_thermite_lp", undefined, param_01, var_03);
      lib_0380::func_5F2(var_07, var_04, var_05);
    }

    if(param_02 == 3) {
      var_08 = lib_0380::func_2889("mp_war_dday_arty_final_metal", undefined, param_00);
      var_09 = lib_0380::func_2889("mp_war_dday_arty_final_smolder_lp", undefined, param_01, var_03);
      level notify(var_05);
    }
  }
}

allies_victory_sfx() {
  lib_0380::func_6840("dday_allies_victory_amb_front", undefined);
  lib_0380::func_6840("dday_allies_victory_amb_rear", undefined);
  lib_0380::func_6840("dday_allies_victory_bodyfalls", undefined);
  lib_0380::func_6840("dday_allies_victory_bullets", undefined);
  lib_0380::func_6840("dday_allies_victory_explo", undefined);
  lib_0380::func_6840("dday_allies_victory_fire_fall", undefined);
  lib_0380::func_6840("dday_allies_victory_footsteps", undefined);
  lib_0380::func_6840("dday_allies_victory_guns", undefined);
  lib_0380::func_6840("dday_allies_victory_guy_gets_judoed", undefined);
}

axis_victory_sfx() {
  lib_0380::func_6840("dday_axis_victory_mgs", undefined);
  lib_0380::func_6840("dday_axis_victory_exp", undefined);
  lib_0380::func_6840("dday_axis_victory_amb", undefined);
}