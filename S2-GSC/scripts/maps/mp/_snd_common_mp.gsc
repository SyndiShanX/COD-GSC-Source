/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_snd_common_mp.gsc
**********************************************/

_id_8D80() {
  _id_7BA3();
  thread _id_51D8();
  thread _id_8D81();
}

_id_51D8() {}

_id_8D81() {
  level._id_071D._id_351F = 0;

  if(isDefined(level.players) && level.players.size > 0) {
    foreach(var_1 in level.players) {
      var_1 _meth_8626("mp_init_mix");
      waitframe();
      var_1 _meth_8626("mp_pre_event_mix");
      waitframe();
    }
  }
}

_id_8D82() {
  level._id_071D._id_351F = 1;

  if(isDefined(level.players) && level.players.size > 0) {
    foreach(var_1 in level.players) {
      var_1 _meth_8627("mp_pre_event_mix");
      waitframe();
      var_1 _meth_8626("mp_post_event_mix");
      waitframe();
    }
  }
}

_id_7BA3() {
  _id_0378::_id_8DC7("player_connect", ::_id_7247);
  _id_0378::_id_8DC7("mp_headshot_killed", ::_id_64FD);
  _id_0378::_id_8DC7("mp_headshot_killer", ::_id_64FE);
  _id_0378::_id_8DC7("snd_mp_player_death", ::_id_8D83);
  _id_0378::_id_8DC7("ks_carepackage_flyby", ::_id_5ABE);
  _id_0378::_id_8DC7("carepackage_airplane", ::_id_1FF6);
  _id_0378::_id_8DC7("ks_carepackage_parachute", ::_id_1FF8);
  _id_0378::_id_8DC7("ks_carepackage_firstImpact", ::_id_1FF7);
  _id_0378::_id_8DC7("ks_emergency_carepackage", ::_id_35D8);
  _id_0378::_id_8DC7("ks_paratroopers_parachute", ::_id_6E73);
  _id_0378::_id_8DC7("aud_player_parachute_open", ::player_parachute_open);
  _id_0378::_id_8DC7("ks_uav_deathspin", ::_id_5AC6);
  _id_0378::_id_8DC7("ks_uav_explode", ::_id_5AC7);
  _id_0378::_id_8DC7("ks_flak_cannon_explo", ::_id_5AC2);
  _id_0378::_id_8DC7("ks_firebomb_explo", ::_id_5AC0);
  _id_0378::_id_8DC7("ks_firebomb_explo_fire", ::_id_5AC1);
  _id_0378::_id_8DC7("ks_bombing_run_location_selected", ::_id_5ABD);
  _id_0378::_id_8DC7("ks_bombing_run_flyby", ::_id_5ABC);
  _id_0378::_id_8DC7("ks_fighterstrike_flyby", ::_id_5ABF);
  _id_0378::_id_8DC7("ks_projectile_fired", ::_id_5AC5);
  _id_0378::_id_8DC7("ks_incoming_projectile", ::_id_5AC4);
  _id_0378::_id_8DC7("ks_fritzx_dropped", ::_id_5AC3);
  _id_0378::_id_8DC7("aud_v2_incoming", ::v2_incoming);
  _id_0378::_id_8DC7("aud_v2_explosion", ::v2_explosion);
  _id_0378::_id_8DC7("aud_player_parachute_submix", ::player_parachute_submix);
  _id_0378::_id_8DC7("aud_serum_syringe_foley", ::serum_syringe_foley);
  _id_0378::_id_8DC7("aud_serum_buff_start", ::serum_buff_start);
  _id_0378::_id_8DC7("aud_serum_buff_end", ::serum_buff_end);
  _id_0378::_id_8DC7("wpn_bouncingbetty_trigger", ::_id_AA91);
  _id_0378::_id_8DC7("wpn_bouncingbetty_spin", ::_id_AA90);
  _id_0378::_id_8DC7("wpn_bouncingbetty_exp", ::_id_AA8F);
  _id_0378::_id_8DC7("aud_mp_zombie_relic_pickup", ::mp_zombie_relic_pickup);
  _id_0378::_id_8DC7("aud_mp_zombie_relic_drop", ::mp_zombie_relic_drop);
  _id_0378::_id_8DC7("aud_mp_zombie_relic_soul_captured", ::mp_zombie_relic_soul_captured);
  _id_0378::_id_8DC7("aud_mp_zombie_relic_teleport", ::mp_zombie_relic_teleport);
  _id_0378::_id_8DC7("aud_zombie_spawn", ::undead_hardpoint_zombie_spawn);
  _id_0378::_id_8DC7("hqs_level_up_flag_start", ::_id_4F26);
  _id_0378::_id_8DC7("prestige_fanfare_aircraft_flying", ::_id_4F27);
  _id_0378::_id_8DC7("prestige_fireworks_start", ::_id_4F28);
  _id_0378::_id_8DC7("prestige_level_up_flag_start", ::_id_4F29);
}

_id_7247() {
  self _meth_85A7("ClientScriptInit", "mp");
  self _meth_8626("mp_init_mix");
  thread _id_8D7F();

  if(!isDefined(level._id_071D._id_351F) || !level._id_071D._id_351F)
    self _meth_8626("mp_pre_event_mix");
  else {
    self _meth_8627("mp_pre_event_mix");
    self _meth_8626("mp_post_event_mix");
  }
}

_id_8D7F() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    _id_0378::_id_8D74("spawned");
    wait 1;

    if(!_func_367()) {
      thread _id_0378::_id_92F3(0.75, 0.01);
      thread _id_0378::_id_1BBD();
      thread _id_0378::_id_1BBE();
      thread _id_0378::_id_1BBF();
    }
  }
}

_id_8D7E() {
  var_0 = self;
  var_1 = gettime();
  var_2 = 1500;
  var_0 _meth_8626("mp_focus_mode_mix");

  if(var_1 > self._id_3D9C + var_2) {
    var_0._id_3D98 = 0;
    _id_0380::_id_2888("focus_mode_begin", var_0);
    var_0._id_3D9E = _id_0380::_id_2888("focus_mode_lp", var_0, 1.0);
    self._id_3D9C = var_1;
  }
}

_id_8D7D(var_0) {
  var_1 = self;
  var_2 = gettime();
  var_3 = 500;
  var_1 _meth_8627("mp_focus_mode_mix");

  if(isDefined(self._id_3D9B) && var_2 > self._id_3D9B + var_3) {
    if(!isDefined(var_0) || !var_0)
      var_1._id_3D9D = _id_0380::_id_2888("focus_mode_end", var_1);

    _id_0380::_stoplocalsound(var_1._id_3D9E, 1.0);
    self._id_3D9B = var_2;
  }
}

_id_8D83() {
  var_0 = _id_0380::_id_2888("mp_player_death", self);
}

_id_64FD() {
  var_0 = self;
  _id_0380::_id_6844("mp_headshot_killed", undefined, var_0);
}

_id_64FE() {
  var_0 = self;
  _id_0380::_id_6840("mp_headshot_killer", var_0);
}

_id_5AC2(var_0) {
  _id_0380::_id_6842("ks_flak_exp", undefined, var_0);
}

_id_5AC0(var_0) {}

_id_5AC1() {}

_id_5ABD() {
  var_0 = self;
  _id_0380::_id_6844("mp_ks_target_select_circle_target", var_0, self);
}

_id_5ABC() {
  var_0 = self;
  var_1 = 1;
  wait(var_1);
  _id_0380::_id_6846("ks_plane_by_carpet_bomb", undefined, var_0);
}

_id_5ABA() {
  var_0 = self;
  var_0 waittill("death");

  if(!isDefined(var_0) || !isDefined(var_0.origin)) {
    return;
  }
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = var_0._id_0117;
  var_4 = var_0.team;
  _id_0380::_id_6842("ks_bomb_run_exp", undefined, var_1);
}

_id_5ABB() {
  var_0 = self;
  var_1 = var_0.origin;
  wait 1.5;

  if(isDefined(var_0))
    _id_0380::_id_6842("ks_bomb_run_final_tail", undefined, var_1);
}

_id_5ABF() {}

_id_5ABE() {
  var_0 = self;
  _id_0380::_id_6846("ks_plane_by_supply_drop", undefined, var_0);
}

_id_35D8() {
  var_0 = self;
  _id_0380::_id_6846("ks_plane_by_emergency_drop", undefined, var_0);
}

_id_1FF6() {}

_id_1FF8() {
  var_0 = self;
  var_1 = 0.5;
  var_2 = 0.5;
  var_3 = _id_0380::_id_6844("ks_crpkg_parachute_lp", undefined, var_0, var_1);
  var_0 waittill("detach");
  _id_0380::_id_6850(var_3, var_2);
  _id_0380::_id_6842("ks_crpkg_parachute_release", undefined, var_0.origin);
}

_id_1FF7() {
  var_0 = self;

  if(self.team == "allies")
    _id_0380::_id_6844("mp_ks_crpkg_imp_allies", undefined, self);
  else
    _id_0380::_id_6844("mp_ks_crpkg_imp_axis", undefined, self);
}

_id_6E73() {
  var_0 = self;
  var_1 = 0.5;
  var_2 = 0.5;
  var_3 = _id_0380::_id_288B("ks_ptps_parachute_lp", undefined, var_0, var_1);
  var_0 common_scripts\utility::_id_A70A("paratrooper_released", "detach");
  _id_0380::_stoplocalsound(var_3, var_2);
  _id_0380::_id_2889("ks_ptps_parachute_release", undefined, var_0.origin);
}

player_parachute_open() {
  _id_0380::_id_6847("player_parachute_lp", self, self, 0, 1, 1, self, "aud_stop_parachute_loop");
  _id_0380::_id_6847("player_parachute_jingles_lp", self, self, 0, 1, 1, self, "aud_stop_parachute_loop");
  common_scripts\utility::_id_A70A("paratrooper_released", "detach");
  _id_0380::_id_6844("player_parachute_release", self, self);
  self notify("aud_stop_parachute_loop");
}

_id_5AC6(var_0) {
  var_1 = self;
  var_2 = var_0 - 0.05;
  _id_0380::_id_6844("ks_plane_destruct_deathspin", undefined, var_1);
  wait(var_2);
  var_3 = var_1.origin;
  _id_0380::_id_6842("ks_plane_destruct_explode", undefined, var_3);
}

_id_5AC7() {
  var_0 = self;
  _id_0380::_id_6844("ks_plane_destruct_explode", undefined, var_0);
}

_id_7B08() {
  var_0 = self;
}

_id_1FF2() {
  var_0 = self;
}

_id_644E() {
  var_0 = self;
}

_id_0FD5() {
  var_0 = self;
}

_id_7C61() {
  var_0 = self;
}

_id_3CFD() {
  var_0 = self;
}

_id_3BB4() {
  var_0 = self;
}

_id_2000() {
  var_0 = self;
}

_id_1163() {
  var_0 = self;
}

_id_5AC5(var_0) {
  self endon("killstreakOwnerDisconnect");
  var_1 = self;
  var_2 = "missile_strike";
  var_3 = 75;
  var_4 = "mortar_strike";

  if(var_0 == var_2) {
    _id_0380::_id_6842("ks_mstrike_fire", undefined, var_1.origin);
    _id_0380::_id_6844("mp_ks_incoming", undefined, var_1);
    var_1 waittill("death");

    if(isDefined(var_1)) {
      var_5 = var_1.origin;
      _id_0380::_id_6842("ks_mstrike_exp", undefined, var_5);
    }
  }

  if(var_0 == var_4) {
    _id_0380::_id_6842("ks_mortar_strike_fire", undefined, var_1.origin);
    _id_0380::_id_6844("ks_mortar_strike_inc", undefined, var_1);
    var_1 waittill("death");

    if(isDefined(var_1)) {
      var_5 = var_1.origin;
      _id_0380::_id_6842("ks_mstrike_exp", undefined, var_5);
    }
  }
}

_id_5AC4(var_0) {
  if(var_0 == "missile_strike")
    _id_0380::_id_6844("mp_ks_incoming_close", undefined, self);
  else if(var_0 == "mortar_strike")
    _id_0380::_id_6844("mp_ks_incoming_close", undefined, self);
}

_id_5AC3() {
  var_0 = self;
}

v2_incoming() {
  wait 0.55;
  var_0 = _id_0380::_id_6840("ks_v2_incoming", undefined);
  level waittill("nuke_death");
  _id_0380::_id_6850(var_0, 0.1);
}

v2_explosion() {
  _id_0380::_id_6840("ks_v2_impact_main", undefined);
  _id_0380::_id_6840("ks_v2_shockwave", undefined);
}

player_parachute_submix() {
  self _meth_8626("mp_tunisia_parachute_mix");
  common_scripts\utility::_id_A70A("paratrooper_released", "detach");
  self _meth_8627("mp_tunisia_parachute_mix");
}

serum_syringe_foley() {
  _id_0380::_id_2888("serum_syringe_foley", self);
}

serum_buff_start() {
  wait 0.1;
  _id_0380::_id_2888("serum_buff_on", self);
}

serum_buff_end() {
  _id_0380::_id_2888("serum_buff_off", self);
}

_id_AA91() {
  var_0 = self;
  _id_0380::_id_6844("mp_wpn_betty_triggered", undefined, var_0);
}

_id_AA90() {
  var_0 = self;
}

_id_AA8F() {
  var_0 = self;
  var_0 _id_0380::_id_6844("mp_wpn_betty_exp", undefined, var_0);
}

mp_zombie_relic_pickup() {
  var_0 = self;
  _id_0380::_id_288B("mp_zombie_relic_pickup", undefined, var_0);
}

mp_zombie_relic_drop() {
  var_0 = self;
  level._id_11CB.relic_drop = _id_0380::_id_288B("mp_zombie_relic_drop", undefined, var_0);
}

mp_zombie_relic_soul_captured(var_0) {
  _id_0380::_stoplocalsound(level._id_11CB.relic_drop);
  level waittill("mp_relic_teleport_start");
  _id_0380::_stoplocalsound(level._id_11CB.relic_teleport);
}

mp_zombie_relic_teleport(var_0) {
  level notify("mp_relic_teleport_start");
  level._id_11CB.relic_teleport = _id_0380::_id_2889("mp_zombie_relic_teleport", undefined, var_0);
}

undead_hardpoint_zombie_spawn(var_0) {
  _id_0380::_id_6842("mp_zmb_undead_spawn_elec", undefined, var_0);
}

_id_4F26() {
  var_0 = self;
  _id_0380::_id_6842("ui_in_hub_level_up_flair", undefined, var_0.origin);
}

_id_4F27() {
  var_0 = self;
  _id_0380::_id_6844("mp_hub_prestige_flyby", undefined, var_0);
}

_id_4F28(var_0) {
  var_1 = self;
  var_2 = (-2618, 7584, 737);

  if(isDefined(var_0)) {
    if(var_0 == 1)
      _id_0380::_id_6842("mp_hub_prestige_fireworks_rank_01", undefined, var_2);

    if(var_0 == 2)
      _id_0380::_id_6842("mp_hub_prestige_fireworks_rank_02", undefined, var_2);

    if(var_0 == 3)
      _id_0380::_id_6842("mp_hub_prestige_fireworks_rank_03", undefined, var_2);

    if(var_0 == 4)
      _id_0380::_id_6842("mp_hub_prestige_fireworks_rank_04", undefined, var_2);

    if(var_0 == 5)
      _id_0380::_id_6842("mp_hub_prestige_fireworks_rank_05", undefined, var_2);

    if(var_0 == 6)
      _id_0380::_id_6842("mp_hub_prestige_fireworks_rank_06", undefined, var_2);

    if(var_0 == 7)
      _id_0380::_id_6842("mp_hub_prestige_fireworks_rank_07", undefined, var_2);

    if(var_0 == 8)
      _id_0380::_id_6842("mp_hub_prestige_fireworks_rank_08", undefined, var_2);

    if(var_0 == 9)
      _id_0380::_id_6842("mp_hub_prestige_fireworks_rank_09", undefined, var_2);

    if(var_0 == 10)
      _id_0380::_id_6842("mp_hub_prestige_fireworks_rank_10", undefined, var_2);
  }
}

_id_4F29() {
  var_0 = self;
  _id_0380::_id_6842("ui_in_hub_level_up_flair", undefined, var_0.origin);
}