/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_empambush\sa_empambush_audio.gsc
***************************************************************/

_id_E9A4() {
  _id_25AC();
  thread _id_DEB0();
  level._id_2576 = 0;
}

_id_25AC() {
  scripts\engine\utility::flag_init("stop_cap_ship_thruster_ambience");
  scripts\engine\utility::flag_init("ignore_charge_up");
  level._id_1D66 = ["exterior_ambience_battle", "interior_ambience"];

  foreach(var_1 in level._id_1D66)
  scripts\engine\utility::flag_init(var_1);
}

_id_5E15() {}

_id_13EB7() {}

_id_615F() {}

_id_616D() {
  scripts\engine\utility::flag_set("stop_cap_ship_thruster_ambience");
}

_id_91BA() {}

_id_9A75() {}

_id_5874() {}

_id_13EB8() {}

_id_6160() {
  scripts\engine\utility::flag_set("start_thruster_loops");
  level._id_2571 thread _id_CCC0();
  _id_0F00::_id_CDD1("amb_sa_emp_space_ext_01_lr", "amb_sa_emp_space_ext_01_lsrs");
}

_id_616E() {
  scripts\engine\utility::flag_set("start_thruster_loops");
  level._id_2571 thread _id_CCC0();
  _id_0F00::_id_CDD1("amb_sa_emp_space_ext_01_lr", "amb_sa_emp_space_ext_01_lsrs");
}

_id_91BB() {
  scripts\engine\utility::flag_set("ignore_charge_up");
  _id_0F00::_id_CDD1("amb_sa_emp_space_ext_02_lr", "amb_sa_emp_space_ext_02_lsrs");
  thread _id_6A27();
  thread _id_993B();
}

_id_9A76() {
  _id_0F00::_id_CDD1("amb_sa_emp_space_ext_02_lr", "amb_sa_emp_space_ext_02_lsrs");
  thread _id_6A27();
  thread _id_993B();
}

_id_5875() {
  _id_0F00::_id_FC1C();
  _id_0F00::_id_CDD1("amb_sa_emp_ship_int_01_lr", "amb_sa_emp_ship_int_01_lsrs", 2);
}

_id_5E17() {}

_id_13EB9() {
  level.player _meth_82C0("intro");
  level._id_2571 thread _id_CCC0();
  _id_0F00::_id_CDD1("amb_sa_emp_space_ext_01_lr", "amb_sa_emp_space_ext_01_lsrs");
  thread _id_23ED();
  wait 9;
  level.player clearclienttriggeraudiozone(2);
}

_id_BC8D() {
  wait 3;
  level._id_EA2C thread _id_0F33::_id_C190(0, "null");
  wait 1.5;
  scripts\engine\utility::flag_wait("about_to_cross");
  wait 5;
  level._id_EA2C thread _id_0F33::_id_C191();
  wait 8;
  level._id_EA2C thread _id_0F33::_id_C190(0, "null");
}

_id_6161() {}

_id_616F() {
  scripts\engine\utility::flag_wait("stop_cap_ship_thruster_ambience");
  _id_0F00::_id_CDD1("amb_sa_emp_space_ext_02_lr", "amb_sa_emp_space_ext_02_lsrs", 5);
  level.player notify("started_dynamic_ambience");
}

_id_91BC() {
  scripts\engine\utility::flag_clear("interior_ambience");
  thread _id_6A27();
  thread _id_993B();
  thread _id_8ABF();
}

_id_9A77() {
  thread _id_8ACC();
  thread _id_DAA8();
  scripts\engine\utility::flag_wait("entering_ship_interior");
}

_id_23ED() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("sa_emp_asteroid_bump_small", 0.5, 15, 3, 7, 3000, 3001, 300, 45, 359, 8, 0, 0, 0);
  thread _id_0F00::_id_FBEF("sa_emp_asteroid_bump_large", 0.5, 15, 3, 7, 3000, 3001, 300, 45, 359, 8, 0, 0, 0);
  thread _id_0F00::_id_FBEF("sa_emp_asteroid_movement", 3, 15, 3, 7, 3000, 3001, 300, 90, 359, 5, 0, 0, 0);
}

_id_6A27() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("sa_ext_expl_close", 2, 10, 4, 15, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("sa_ext_expl_med", 2, 5, 3, 7, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
}

_id_9A63() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_large", 12, 24, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium_distant", 10, 20, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_air_release_distant", 18, 30, 15, 17, 3000, 3001, 300, 270, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_impact_distant", 10, 18, 0, 3, 3000, 3001, 300, 0, 90, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_long", 14, 25, 8, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_short", 9, 16, 3, 6, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_servo_distant", 8, 12, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_dist", 20, 30, 25, 28, 3000, 3001, 300, 180, 270, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_distant", 15, 27, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_short_distant", 22, 34, 1, 5, 3000, 3001, 300, 90, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium_distant", 10, 20, 9, 14, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_alarm_buzzer", 20, 31, 13, 15, 5000, 5001, 300, 0, 100, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_battle_distant", 3, 10, 3, 10, 100, 1000, 300, 90, 90, 4, 0, 0, 0);
  thread _id_0F00::_id_FBEF("empambush_int_explosion_sm", 0.2, 18, 3, 8, 100, 1000, 300, 5, 5, 2, 1, 0.2, 0.1);
  thread _id_0F00::_id_FBEF("empambush_int_explosion_lg", 0.2, 25, 3, 8, 100, 1000, 300, 5, 5, 2, 1, 0.7, 0.1);
  thread _id_0F00::_id_FBEF("empambush_int_mixed_battle_thumps", 4, 5, 4, 5, 5000, 6000, 10, 30, 50, 6, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_battle_tracer_short", 4, 8, 2, 10, 100, 1000, 300, 45, 90, 1, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_battle_jack_flyby", 18, 30, 1, 10, 100, 1000, 300, 180, 360, 2, 0, 0, 0);
}

_id_5876() {
  level waittill("jackal_enter");
  level.player notify("started_dynamic_ambience");
  _id_0F00::_id_11034(1);
  level thread _id_0F00::_id_E9C3();
  thread _id_5885();
}

_id_993B() {
  var_0 = level._id_1D66;

  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_in_array_return(var_0);

    switch (var_1) {
      case "interior_ambience":
        _id_9A63();
        break;
      case "exterior_ambience_battle":
        _id_6A27();
        break;
      default:
        break;
    }

    wait 0.05;
    var_0 = scripts\sp\utility::_id_2290(level._id_1D66, [var_1]);

    foreach(var_3 in var_0)
    scripts\engine\utility::flag_clear(var_3);
  }
}

_id_5E1E() {
  wait 0.1;
  level.player clearsoundsubmix();
  level.player playSound("sa_emp_dropship_intro_lr");
}

_id_CCC0() {
  scripts\engine\utility::flag_wait("start_thruster_loops");

  if(!scripts\engine\utility::flag("stop_cap_ship_thruster_ambience")) {
    thread _id_3AAB();
    thread _id_3AAA();
  }
}

_id_3AAB() {
  thread _id_ACE2("turbine", "sa_emp_carrier_engine_turbine_lp", (10481, -2238, 697), (10425, 2239, 429));
  thread _id_ACE2("vapor", "sa_emp_carrier_engine_vapor", (10481, -2238, 697), (10425, 2239, 429));
  thread _id_ACE2("close_engine", "sa_emp_carrier_engine_close_lp", (11481, -2238, 697), (11425, 2239, 429));
  thread _id_ACE2("mid_engine", "sa_emp_carrier_engine_mid_lp", (11481, -2238, 697), (11425, 2239, 429));
  thread _id_ACE2("dist_engine", "sa_emp_carrier_engine_dist_lp", (11481, -2238, 697), (11425, 2239, 429));
  thread _id_3AAC();
  scripts\engine\utility::flag_wait("stop_cap_ship_thruster_ambience");
  level notify("turbine_line_emitter_stop");
  level notify("vapor_line_emitter_stop");
  level notify("close_engine_line_emitter_stop");
  level notify("mid_engine_line_emitter_stop");
  level notify("dist_engine_line_emitter_stop");
  _id_0F00::_id_CD7B("sa_emp_carrier_engine_heat_01", (10781, -1951, 1114));
  _id_0F00::_id_CD7B("sa_emp_carrier_engine_heat_02", (10654, -2642, 357));
  thread _id_612E();
}

_id_3AAA() {
  while(!scripts\engine\utility::flag("emp_ready_to_set")) {
    _id_0F00::_id_CE21("sa_emp_carrier_engine_repair", (11481, -2238, 697));
    wait(randomfloatrange(3, 10));
  }
}

_id_3AAC() {
  thread _id_12928();
  thread _id_12929();
}

_id_12928() {
  var_0 = scripts\engine\utility::spawn_tag_origin((10938, -1846, 962));
  var_0 playLoopSound("sa_emp_carrier_engine_turbine_blades_lp");
  scripts\engine\utility::flag_wait("stop_cap_ship_thruster_ambience");
  var_0 stopsounds();
  scripts\engine\utility::waitframe();
  var_0 delete();
}

_id_12929() {
  var_0 = scripts\engine\utility::spawn_tag_origin((10866, -2588, 121));
  var_0 playLoopSound("sa_emp_carrier_engine_turbine_blades_lp");
  scripts\engine\utility::flag_wait("stop_cap_ship_thruster_ambience");
  var_0 stopsounds();
  scripts\engine\utility::waitframe();
  var_0 delete();
}

_id_A30E() {
  scripts\engine\utility::flag_wait("emp_intro_jackal_fly_over");

  if(!isDefined(self)) {
    return;
  }
  self playSound("sa_emp_jackal_search");
  wait 10;
}

_id_13EA5() {
  scripts\engine\utility::flag_set("start_thruster_loops");
  self playSound("sa_emp_dropship_1_approach");
  wait 22.5;
  self playSound("sa_emp_dropship_1_dropoff");
  wait 4;
  self playSound("sa_emp_dropship_1_leave");
}

_id_C989(var_0) {
  if(var_0 == "jackal_patrol1")
    self playSound("sa_emp_jackal_patrol_by");
}

_id_6149() {
  thread _id_6131();
  wait 25;
  self playSound("sa_emp_dropship_2_approach");
}

_id_6131() {
  scripts\engine\utility::flag_wait("emp_dropship_start_unload");
}

_id_1184F() {
  var_0 = scripts\engine\utility::spawn_tag_origin((11481, -2238, 697));
  var_0 playSound("sa_emp_carrier_engine_powerdown_02", "sounddone");
  var_0 waittill("sounddone");
  wait 0.2;
  var_0 delete();
}

_id_11850() {
  var_0 = scripts\engine\utility::spawn_tag_origin((11425, 2239, 429));
  var_0 playSound("sa_emp_carrier_engine_powerdown_01", "sounddone");
  var_0 waittill("sounddone");
  wait 0.2;
  var_0 delete();
}

_id_6143() {
  level.player _id_0F00::_id_CE24("sa_emp_device_start");
  level.player _id_0F00::_id_CE24("sa_emp_device_plant", 2);
  level.player _id_0F00::_id_CE24("sa_emp_device_pull", 3.11);
  level.player _id_0F00::_id_CE24("sa_emp_device_push", 3.62);
  level.player _id_0F00::_id_CE24("sa_emp_device_finish", 4.83);
  wait 5;
  _id_13EF4();
  wait 5.2;
  thread _id_0F33::_id_D0AF();
  wait 0.5;
  thread _id_0F33::_id_D0AA();
  wait 1.1;
  thread _id_0F33::_id_D0AE();
}

_id_13EF4() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 _meth_8278(0);
  scripts\engine\utility::waitframe();
  var_0 _meth_8278(1, 0.5);
  level.player playSound("zero_g_mvmt_start");
  var_0 playLoopSound("zero_g_mvmt_loop");
  wait 5.5;
  level.player playSound("zero_g_mvmt_end");
  scripts\engine\utility::waitframe();
  var_0 stopsounds();
  scripts\engine\utility::waitframe();
  var_0 delete();
}

_id_613A(var_0, var_1) {
  if(scripts\engine\utility::flag("ignore_charge_up")) {
    return;
  }
  switch (var_1) {
    case "r":
      wait 0.9;
      var_2 = scripts\engine\utility::spawn_tag_origin(var_0);
      var_2 playSound("sa_scn_emp_charge_rise_01", "sounddone");
      var_2 waittill("sounddone");
      wait 0.2;
      var_2 delete();
      break;
    case "l":
      thread _id_0F00::_id_11021(6);
      wait 0.9;
      var_3 = scripts\engine\utility::spawn_tag_origin(var_0);
      var_3 playSound("sa_scn_emp_charge_rise_02", "sounddone");
      var_3 waittill("sounddone");
      wait 0.2;
      var_3 delete();
      break;
    default:
      break;
  }
}

_id_614F() {
  self playSound("sa_scn_emp_explosion_1");
}

_id_614E() {
  self playSound("sa_scn_emp_explosion_2");
}

_id_6150() {
  wait 4;
  _id_0F00::_id_CE21("sa_scn_emp_electricity", (11678, -2282, 741));
}

_id_612E() {
  self endon("death");
  wait 2;

  while(!scripts\engine\utility::flag("entering_ship_interior")) {
    _id_0F00::_id_CE21("sa_scn_emp_explosion_alarm", (8733, 3, 1753));
    wait 2.5;
  }
}

_id_E3A8() {
  _id_0F00::_id_CE21("retribution_ftl_wave", (2960, 10446, 6874));
  wait 2;
  _id_0F00::_id_CE21("retribution_ftl_in", (2960, 10446, 6874));
  level notify("stop_doppler");
}

_id_8ABF() {
  _id_0F00::_id_CD7B("hangar_rumble1_lp", (-3577, -693, 447));
}

_id_DAA8() {
  _id_0F00::_id_CD7B("prototype_ext_idle_lp", (-5449, -2087, -138));
}

_id_8ACC() {
  _id_0F00::_id_CD7B("amb_ship_steam_wide_01", (-3267, -1719, 46));
  _id_0F00::_id_CD7B("amb_ship_steam_wide_02", (-4316, -2107, 46));
  _id_0F00::_id_CD7B("amb_ship_steam_wide_03", (-4931, -2550, 46));
  _id_0F00::_id_CD7B("amb_ship_steam_wide_04", (-5506, -2069, 46));
  _id_0F00::_id_CD7B("amb_ship_steam_wide_05", (-5446, -1693, 46));
}

_id_DAAA() {
  level waittill("jackal_enter");
  level.player _id_0F00::_id_CE24("plr_foley_prototype_jackal_enter");
  thread _id_A107();
  level.player _id_0F00::_id_CE24("plr_foley_prototype_jackal_start", 4.75);
  level.player _id_0F00::_id_CE24("prototype_wpn_mvmt_takeoff", 4.75);
  level.player _id_0F00::_id_CE24("proto_jackal_warmup", 5.75);
  level.player _id_0F00::_id_CE24("prototype_jackal_start_hum", 8.45);
  thread _id_DAAD();
}

_id_DAAD() {
  level.player endon("death");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 _meth_8278(0);
  thread _id_DAA7(var_0);
  level.player scripts\engine\utility::waittill_any_timeout(15, "player_takeoff", "bust_out");
  scripts\engine\utility::waitframe();
  var_0 playLoopSound("prototype_jackal_hum_lp");
  scripts\engine\utility::waitframe();
  var_0 _meth_8278(1, 4);
  scripts\engine\utility::flag_wait("dogfight_over");
  var_0 _meth_8278(0, 5);
  wait 5;
  var_0 stopsounds();
  scripts\engine\utility::waitframe();
  var_0 delete();
}

_id_DAA7(var_0) {
  level.player scripts\engine\utility::waittill_any("player_takeoff", "bust_out");
  wait 2.8;
  var_0 _meth_8278(0.17, 2);
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1 playSound("proto_jackal_launch", "sounddone");
  var_1 waittill("sounddone");
  var_1 delete();
}

_id_A107() {
  wait 4;
  level.player notify("started_dynamic_ambience");
  level.player notify("end_zerog_movement");
  level.player setsoundsubmix("sa_player_jackal_interior");
  level.player _meth_82C0("exfil_cockpit_filter");
}

_id_8A37() {
  level._id_2576 = level._id_2576 + 1;

  if(level._id_2576 == 1)
    level.player _id_0F00::_id_CE24("hangar_door_explosion");
}

_id_8AA1() {
  level.player _id_0F00::_id_CE24("proto_missile_launch_door");
}

_id_DEB0() {
  anim.notetracks["emp_anim_start"] = ::_id_612F;
  anim.notetracks["emp_device_plant"] = ::_id_6147;
  anim.notetracks["emp_plr_device_grab"] = ::_id_6180;
  anim.notetracks["emp_device_dial_pull"] = ::_id_6144;
  anim.notetracks["emp_device_dial_turn"] = ::_id_6146;
  anim.notetracks["emp_device_dial_push"] = ::_id_6145;
  anim.notetracks["emp_plr_0g_move_stop_01"] = ::_id_617E;
  anim.notetracks["emp_plr_0g_move_start"] = ::_id_617D;
  anim.notetracks["emp_plr_0g_move_stop_02"] = ::_id_617F;
  anim.notetracks["emp_plr_grapple_fire"] = ::_id_6181;
  anim.notetracks["emp_plr_grapple_stop"] = ::_id_6182;
}

_id_612F(var_0, var_1) {}

_id_6147(var_0, var_1) {}

_id_6180(var_0, var_1) {}

_id_6144(var_0, var_1) {}

_id_6146(var_0, var_1) {}

_id_6145(var_0, var_1) {}

_id_617D(var_0, var_1) {}

_id_617E(var_0, var_1) {}

_id_617F(var_0, var_1) {}

_id_6181(var_0, var_1) {}

_id_6182(var_0, var_1) {}

_id_5885() {
  level.player notify("started_dynamic_ambience");
  level.player notify("end_zerog_movement");
  level.player thread _id_0BDB::_id_A1A7();
  level.player thread _id_0BDB::_id_A1A6();
}

_id_A1FC() {
  level.player waittill("flag_player_is_flying");
}

_id_ACE2(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0.1;
  var_7 = 0.1;

  if(isDefined(var_4)) {
    var_6 = max(var_4, 0);
    var_7 = max(var_4, 0);
  }

  if(isDefined(var_5))
    var_7 = max(var_5, 0);

  var_8 = spawn("script_origin", (0, 0, 0));
  var_8.alias = var_1;
  var_8.is_playing = 0;
  var_8._id_D631 = var_2;
  var_8._id_D632 = var_3;
  var_8._id_6A99 = var_6;
  var_8.label = var_0;
  var_8 thread _id_ACE3();
  level waittill(var_0 + "_line_emitter_stop");
  var_8 _meth_8278(0, var_7);
  wait(var_7);
  var_8 stoploopsound();
  wait 0.05;
  var_8 delete();
}

_id_ACE3() {
  level endon(self.label + "_line_emitter_stop");
  var_0 = self._id_D632 - self._id_D631;
  var_1 = vectorNormalize(var_0);
  var_2 = distance(self._id_D631, self._id_D632);
  var_3 = 0.1;

  for(;;) {
    var_4 = level.player.origin - self._id_D631;
    var_5 = vectordot(var_4, var_1);
    var_5 = clamp(var_5, 0, var_2);
    var_6 = self._id_D631 + var_1 * var_5;

    if(!self.is_playing) {
      self.origin = var_6;
      self playLoopSound(self.alias);
      self _meth_8278(0);
      wait 0.05;
      self _meth_8278(1.0, self._id_6A99);
      self.is_playing = 1;
    } else
      self moveTo(var_6, var_3);

    wait(var_3);
  }
}