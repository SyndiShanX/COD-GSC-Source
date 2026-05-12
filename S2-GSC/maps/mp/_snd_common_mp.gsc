/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_snd_common_mp.gsc
*********************************************/

func_8D80() {
  func_7BA3();
  thread func_51D8();
  thread func_8D81();
}

func_51D8() {}

func_8D81() {
  level.var_071D.var_351F = 0;
  if(isDefined(level.var_744A) && level.var_744A.size > 0) {
    foreach(var_01 in level.var_744A) {
      var_01 method_8626("mp_init_mix");
      wait 0.05;
      var_01 method_8626("mp_pre_event_mix");
      wait 0.05;
    }
  }
}

func_8D82() {
  level.var_071D.var_351F = 1;
  if(isDefined(level.var_744A) && level.var_744A.size > 0) {
    foreach(var_01 in level.var_744A) {
      var_01 method_8627("mp_pre_event_mix");
      wait 0.05;
      var_01 method_8626("mp_post_event_mix");
      wait 0.05;
    }
  }
}

func_7BA3() {
  lib_0378::func_8DC7("player_connect", ::func_7247);
  lib_0378::func_8DC7("mp_headshot_killed", ::func_64FD);
  lib_0378::func_8DC7("mp_headshot_killer", ::func_64FE);
  lib_0378::func_8DC7("snd_mp_player_death", ::func_8D83);
  lib_0378::func_8DC7("ks_carepackage_flyby", ::func_5ABE);
  lib_0378::func_8DC7("carepackage_airplane", ::func_1FF6);
  lib_0378::func_8DC7("ks_carepackage_parachute", ::func_1FF8);
  lib_0378::func_8DC7("ks_carepackage_firstImpact", ::func_1FF7);
  lib_0378::func_8DC7("ks_emergency_carepackage", ::func_35D8);
  lib_0378::func_8DC7("ks_paratroopers_parachute", ::func_6E73);
  lib_0378::func_8DC7("aud_player_parachute_open", ::player_parachute_open);
  lib_0378::func_8DC7("ks_uav_deathspin", ::func_5AC6);
  lib_0378::func_8DC7("ks_uav_explode", ::func_5AC7);
  lib_0378::func_8DC7("ks_flak_cannon_explo", ::func_5AC2);
  lib_0378::func_8DC7("ks_firebomb_explo", ::func_5AC0);
  lib_0378::func_8DC7("ks_firebomb_explo_fire", ::func_5AC1);
  lib_0378::func_8DC7("ks_bombing_run_location_selected", ::func_5ABD);
  lib_0378::func_8DC7("ks_bombing_run_flyby", ::func_5ABC);
  lib_0378::func_8DC7("ks_fighterstrike_flyby", ::func_5ABF);
  lib_0378::func_8DC7("ks_projectile_fired", ::func_5AC5);
  lib_0378::func_8DC7("ks_incoming_projectile", ::func_5AC4);
  lib_0378::func_8DC7("ks_fritzx_dropped", ::func_5AC3);
  lib_0378::func_8DC7("aud_v2_incoming", ::v2_incoming);
  lib_0378::func_8DC7("aud_v2_explosion", ::v2_explosion);
  lib_0378::func_8DC7("aud_player_parachute_submix", ::player_parachute_submix);
  lib_0378::func_8DC7("aud_serum_syringe_foley", ::serum_syringe_foley);
  lib_0378::func_8DC7("aud_serum_buff_start", ::serum_buff_start);
  lib_0378::func_8DC7("aud_serum_buff_end", ::serum_buff_end);
  lib_0378::func_8DC7("wpn_bouncingbetty_trigger", ::func_AA91);
  lib_0378::func_8DC7("wpn_bouncingbetty_spin", ::func_AA90);
  lib_0378::func_8DC7("wpn_bouncingbetty_exp", ::func_AA8F);
  lib_0378::func_8DC7("aud_mp_zombie_relic_pickup", ::mp_zombie_relic_pickup);
  lib_0378::func_8DC7("aud_mp_zombie_relic_drop", ::mp_zombie_relic_drop);
  lib_0378::func_8DC7("aud_mp_zombie_relic_soul_captured", ::mp_zombie_relic_soul_captured);
  lib_0378::func_8DC7("aud_mp_zombie_relic_teleport", ::mp_zombie_relic_teleport);
  lib_0378::func_8DC7("aud_zombie_spawn", ::undead_hardpoint_zombie_spawn);
  lib_0378::func_8DC7("hqs_level_up_flag_start", ::func_4F26);
  lib_0378::func_8DC7("prestige_fanfare_aircraft_flying", ::func_4F27);
  lib_0378::func_8DC7("prestige_fireworks_start", ::func_4F28);
  lib_0378::func_8DC7("prestige_level_up_flag_start", ::func_4F29);
}

func_7247() {
  self method_85A7("ClientScriptInit", "mp");
  self method_8626("mp_init_mix");
  thread func_8D7F();
  if(!isDefined(level.var_071D.var_351F) || !level.var_071D.var_351F) {
    self method_8626("mp_pre_event_mix");
    return;
  }

  self method_8627("mp_pre_event_mix");
  self method_8626("mp_post_event_mix");
}

func_8D7F() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    lib_0378::func_8D74("spawned");
    wait(1);
    if(!function_0367()) {
      thread lib_0378::func_92F3(0.75, 0.01);
      thread lib_0378::func_1BBD();
      thread lib_0378::func_1BBE();
      thread lib_0378::func_1BBF();
    }
  }
}

func_8D7E() {
  var_00 = self;
  var_01 = gettime();
  var_02 = 1500;
  var_00 method_8626("mp_focus_mode_mix");
  if(var_01 > self.var_3D9C + var_02) {
    var_00.var_3D98 = 0;
    lib_0380::func_2888("focus_mode_begin", var_00);
    var_00.var_3D9E = lib_0380::func_2888("focus_mode_lp", var_00, 1);
    self.var_3D9C = var_01;
  }
}

func_8D7D(param_00) {
  var_01 = self;
  var_02 = gettime();
  var_03 = 500;
  var_01 method_8627("mp_focus_mode_mix");
  if(isDefined(self.var_3D9B) && var_02 > self.var_3D9B + var_03) {
    if(!isDefined(param_00) || !param_00) {
      var_01.var_3D9D = lib_0380::func_2888("focus_mode_end", var_01);
    }

    lib_0380::func_2893(var_01.var_3D9E, 1);
    self.var_3D9B = var_02;
  }
}

func_8D83() {
  var_00 = lib_0380::func_2888("mp_player_death", self);
}

func_64FD() {
  var_00 = self;
  lib_0380::func_6844("mp_headshot_killed", undefined, var_00);
}

func_64FE() {
  var_00 = self;
  lib_0380::func_6840("mp_headshot_killer", var_00);
}

func_5AC2(param_00) {
  lib_0380::func_6842("ks_flak_exp", undefined, param_00);
}

func_5AC0(param_00) {}

func_5AC1() {}

func_5ABD() {
  var_00 = self;
  lib_0380::func_6844("mp_ks_target_select_circle_target", var_00, self);
}

func_5ABC() {
  var_00 = self;
  var_01 = 1;
  wait(var_01);
  lib_0380::func_6846("ks_plane_by_carpet_bomb", undefined, var_00);
}

func_5ABA() {
  var_00 = self;
  var_00 waittill("death");
  if(!isDefined(var_00) || !isDefined(var_00.var_0116)) {
    return;
  }

  var_01 = var_00.var_0116;
  var_02 = var_00.var_001D;
  var_03 = var_00.var_0117;
  var_04 = var_00.var_01A7;
  lib_0380::func_6842("ks_bomb_run_exp", undefined, var_01);
}

func_5ABB() {
  var_00 = self;
  var_01 = var_00.var_0116;
  wait(1.5);
  if(isDefined(var_00)) {
    lib_0380::func_6842("ks_bomb_run_final_tail", undefined, var_01);
  }
}

func_5ABF() {}

func_5ABE() {
  var_00 = self;
  lib_0380::func_6846("ks_plane_by_supply_drop", undefined, var_00);
}

func_35D8() {
  var_00 = self;
  lib_0380::func_6846("ks_plane_by_emergency_drop", undefined, var_00);
}

func_1FF6() {}

func_1FF8() {
  var_00 = self;
  var_01 = 0.5;
  var_02 = 0.5;
  var_03 = lib_0380::func_6844("ks_crpkg_parachute_lp", undefined, var_00, var_01);
  var_00 waittill("detach");
  lib_0380::func_6850(var_03, var_02);
  lib_0380::func_6842("ks_crpkg_parachute_release", undefined, var_00.var_0116);
}

func_1FF7() {
  var_00 = self;
  if(self.var_01A7 == "allies") {
    lib_0380::func_6844("mp_ks_crpkg_imp_allies", undefined, self);
    return;
  }

  lib_0380::func_6844("mp_ks_crpkg_imp_axis", undefined, self);
}

func_6E73() {
  var_00 = self;
  var_01 = 0.5;
  var_02 = 0.5;
  var_03 = lib_0380::func_288B("ks_ptps_parachute_lp", undefined, var_00, var_01);
  var_00 common_scripts\utility::func_A70A("paratrooper_released", "detach");
  lib_0380::func_2893(var_03, var_02);
  lib_0380::func_2889("ks_ptps_parachute_release", undefined, var_00.var_0116);
}

player_parachute_open() {
  lib_0380::func_6847("player_parachute_lp", self, self, 0, 1, 1, self, "aud_stop_parachute_loop");
  lib_0380::func_6847("player_parachute_jingles_lp", self, self, 0, 1, 1, self, "aud_stop_parachute_loop");
  common_scripts\utility::func_A70A("paratrooper_released", "detach");
  lib_0380::func_6844("player_parachute_release", self, self);
  self notify("aud_stop_parachute_loop");
}

func_5AC6(param_00) {
  var_01 = self;
  var_02 = param_00 - 0.05;
  lib_0380::func_6844("ks_plane_destruct_deathspin", undefined, var_01);
  wait(var_02);
  var_03 = var_01.var_0116;
  lib_0380::func_6842("ks_plane_destruct_explode", undefined, var_03);
}

func_5AC7() {
  var_00 = self;
  lib_0380::func_6844("ks_plane_destruct_explode", undefined, var_00);
}

func_7B08() {
  var_00 = self;
}

func_1FF2() {
  var_00 = self;
}

func_644E() {
  var_00 = self;
}

func_0FD5() {
  var_00 = self;
}

func_7C61() {
  var_00 = self;
}

func_3CFD() {
  var_00 = self;
}

func_3BB4() {
  var_00 = self;
}

func_2000() {
  var_00 = self;
}

func_1163() {
  var_00 = self;
}

func_5AC5(param_00) {
  self endon("killstreakOwnerDisconnect");
  var_01 = self;
  var_02 = "missile_strike";
  var_03 = 75;
  var_04 = "mortar_strike";
  if(param_00 == var_02) {
    lib_0380::func_6842("ks_mstrike_fire", undefined, var_01.var_0116);
    lib_0380::func_6844("mp_ks_incoming", undefined, var_01);
    var_01 waittill("death");
    if(isDefined(var_01)) {
      var_05 = var_01.var_0116;
      lib_0380::func_6842("ks_mstrike_exp", undefined, var_05);
    }
  }

  if(param_00 == var_04) {
    lib_0380::func_6842("ks_mortar_strike_fire", undefined, var_01.var_0116);
    lib_0380::func_6844("ks_mortar_strike_inc", undefined, var_01);
    var_01 waittill("death");
    if(isDefined(var_01)) {
      var_05 = var_01.var_0116;
      lib_0380::func_6842("ks_mstrike_exp", undefined, var_05);
    }
  }
}

func_5AC4(param_00) {
  if(param_00 == "missile_strike") {
    lib_0380::func_6844("mp_ks_incoming_close", undefined, self);
    return;
  }

  if(param_00 == "mortar_strike") {
    lib_0380::func_6844("mp_ks_incoming_close", undefined, self);
  }
}

func_5AC3() {
  var_00 = self;
}

v2_incoming() {
  wait(0.55);
  var_00 = lib_0380::func_6840("ks_v2_incoming", undefined);
  level waittill("nuke_death");
  lib_0380::func_6850(var_00, 0.1);
}

v2_explosion() {
  lib_0380::func_6840("ks_v2_impact_main", undefined);
  lib_0380::func_6840("ks_v2_shockwave", undefined);
}

player_parachute_submix() {
  self method_8626("mp_tunisia_parachute_mix");
  common_scripts\utility::func_A70A("paratrooper_released", "detach");
  self method_8627("mp_tunisia_parachute_mix");
}

serum_syringe_foley() {
  lib_0380::func_2888("serum_syringe_foley", self);
}

serum_buff_start() {
  wait(0.1);
  lib_0380::func_2888("serum_buff_on", self);
}

serum_buff_end() {
  lib_0380::func_2888("serum_buff_off", self);
}

func_AA91() {
  var_00 = self;
  lib_0380::func_6844("mp_wpn_betty_triggered", undefined, var_00);
}

func_AA90() {
  var_00 = self;
}

func_AA8F() {
  var_00 = self;
  var_00 lib_0380::func_6844("mp_wpn_betty_exp", undefined, var_00);
}

mp_zombie_relic_pickup() {
  var_00 = self;
  lib_0380::func_288B("mp_zombie_relic_pickup", undefined, var_00);
}

mp_zombie_relic_drop() {
  var_00 = self;
  level.var_11CB.relic_drop = lib_0380::func_288B("mp_zombie_relic_drop", undefined, var_00);
}

mp_zombie_relic_soul_captured(param_00) {
  lib_0380::func_2893(level.var_11CB.relic_drop);
  level waittill("mp_relic_teleport_start");
  lib_0380::func_2893(level.var_11CB.relic_teleport);
}

mp_zombie_relic_teleport(param_00) {
  level notify("mp_relic_teleport_start");
  level.var_11CB.relic_teleport = lib_0380::func_2889("mp_zombie_relic_teleport", undefined, param_00);
}

undead_hardpoint_zombie_spawn(param_00) {
  lib_0380::func_6842("mp_zmb_undead_spawn_elec", undefined, param_00);
}

func_4F26() {
  var_00 = self;
  lib_0380::func_6842("ui_in_hub_level_up_flair", undefined, var_00.var_0116);
}

func_4F27() {
  var_00 = self;
  lib_0380::func_6844("mp_hub_prestige_flyby", undefined, var_00);
}

func_4F28(param_00) {
  var_01 = self;
  var_02 = (-2618, 7584, 737);
  if(isDefined(param_00)) {
    if(param_00 == 1) {
      lib_0380::func_6842("mp_hub_prestige_fireworks_rank_01", undefined, var_02);
    }

    if(param_00 == 2) {
      lib_0380::func_6842("mp_hub_prestige_fireworks_rank_02", undefined, var_02);
    }

    if(param_00 == 3) {
      lib_0380::func_6842("mp_hub_prestige_fireworks_rank_03", undefined, var_02);
    }

    if(param_00 == 4) {
      lib_0380::func_6842("mp_hub_prestige_fireworks_rank_04", undefined, var_02);
    }

    if(param_00 == 5) {
      lib_0380::func_6842("mp_hub_prestige_fireworks_rank_05", undefined, var_02);
    }

    if(param_00 == 6) {
      lib_0380::func_6842("mp_hub_prestige_fireworks_rank_06", undefined, var_02);
    }

    if(param_00 == 7) {
      lib_0380::func_6842("mp_hub_prestige_fireworks_rank_07", undefined, var_02);
    }

    if(param_00 == 8) {
      lib_0380::func_6842("mp_hub_prestige_fireworks_rank_08", undefined, var_02);
    }

    if(param_00 == 9) {
      lib_0380::func_6842("mp_hub_prestige_fireworks_rank_09", undefined, var_02);
    }

    if(param_00 == 10) {
      lib_0380::func_6842("mp_hub_prestige_fireworks_rank_10", undefined, var_02);
    }
  }
}

func_4F29() {
  var_00 = self;
  lib_0380::func_6842("ui_in_hub_level_up_flair", undefined, var_00.var_0116);
}