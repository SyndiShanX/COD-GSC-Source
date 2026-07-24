/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\yard\yard_audio.gsc
***********************************************/

main() {
  _id_0F00::_id_25D8(32);
  _id_953A();
  _id_969E();
  _id_953B();
  setdvarifuninitialized("snd_yardHackStaticTime", "0.333");
}

_id_953A() {}

_id_969E() {
  anim.notetracks["vo_yard_slt_reyeswerefree"] = ::_id_25E8;
  anim.notetracks["vo_yard_plr_firingcontrolis"] = ::_id_25E7;
  anim.notetracks["panel_pull_small_start"] = ::_id_2589;
  anim.notetracks["panel_pull_large_start"] = ::_id_2588;
}

_id_953B() {
  level._id_1188._id_10DED = [];
  level._id_1188._id_10DED = _id_25EF(level._id_1188._id_10DED, "elevator_arrival", ::_id_259E);
  level._id_1188._id_10DED = _id_25EF(level._id_1188._id_10DED, "elevator_combat", ::_id_25A0);
  level._id_1188._id_10DED = _id_25EF(level._id_1188._id_10DED, "elevator_mac_death", ::_id_25A3);
  level._id_1188._id_10DED = _id_25EF(level._id_1188._id_10DED, "elevator_ambush", ::_id_259D);
  level._id_1188._id_10DED = _id_25EF(level._id_1188._id_10DED, "junction_tram", ::_id_25CC);
  level._id_1188._id_10DED = _id_25EF(level._id_1188._id_10DED, "junction_arrive", ::_id_25C9);
  level._id_1188._id_10DED = _id_25EF(level._id_1188._id_10DED, "junction_capture", ::_id_25CA);
  level._id_1188._id_10DED = _id_25EF(level._id_1188._id_10DED, "junction_spaced", ::_id_25CB);
  level._id_1188._id_10DED = _id_25EF(level._id_1188._id_10DED, "central_elevator", ::_id_2581);
  level._id_1188._id_10DED = _id_25EF(level._id_1188._id_10DED, "central_defend", ::_id_2580);
  level._id_1188._id_10DED = _id_25EF(level._id_1188._id_10DED, "central_hack_ethan", ::_id_2586);
  level._id_1188._id_10DED = _id_25EF(level._id_1188._id_10DED, "central_escape", ::_id_2584);
}

_id_25EF(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) == 0) {
    var_3 = 0;
  }

  var_4 = spawnStruct();
  var_4.name = var_1;
  var_4._id_373B = var_2;
  var_4._id_13D20 = var_3;
  var_4._id_10D8F = undefined;
  var_0[var_0.size] = var_4;
  return var_0;
}

_id_25F4(var_0) {
  for(var_1 = 0; var_1 < level._id_1188._id_10DED.size; var_1++) {
    var_2 = level._id_1188._id_10DED[var_1];

    if(isDefined(var_2) == 1 && var_2.name == var_0) {
      return var_2;
    }
  }

  return undefined;
}

_id_25EE(var_0, var_1) {
  var_2 = getdvarint("snd_debugShipAssault");
  var_3 = _id_25F4(var_0);

  if(isDefined(var_3) == 0) {
    return;
  }
  if(isDefined(var_3._id_10D8F) == 0) {
    if(var_1 == "catchup" && var_3._id_13D20 == 0) {
      return;
    }
    thread[[var_3._id_373B]]();

    if(isDefined(var_1) == 1) {
      var_3._id_10D8F = var_1;
    } else {
      var_3._id_10D8F = 1;
    }
  } else {}
}

_id_259E() {}

_id_25A0() {}

_id_25A3() {
  level thread _id_2594();
  level thread _id_2597();
}

_id_259D() {}

_id_25CC() {}

_id_25C9() {}

_id_25CA() {}

_id_25CB() {}

_id_2581() {}

_id_2580() {}

_id_2586() {}

_id_2584() {}

_id_1214(var_0, var_1) {}

_id_8203() {
  if(!isDefined(self.velocity)) {
    self.velocity = (0, 0, 0);
  }

  if(!isDefined(self._id_C717)) {
    self._id_C717 = self.origin;
  }

  self.velocity = self.origin - self._id_C717;
  self._id_C717 = self.origin;
  return self.velocity;
}

_id_1326D() {
  self endon("death");
  self endon("deleted");
  self endon("movedone");
  self endon("velocitydone");
  self._id_1326E = 0.0;

  for(;;) {
    var_0 = _id_8203();
    self._id_1326E = length(var_0);
    scripts\engine\utility::waitframe();
  }
}

_id_25A6(var_0) {
  var_1 = self;
  var_1 playSound("scn_elevator_shutters_start");
  wait 0.15;
  var_1 playLoopSound("scn_elevator_shutters_lp");
  wait(var_0 - 0.15);
  var_1 playSound("scn_elevator_shutters_stop");
  wait 0.2666;
  var_1 stoploopsound("scn_elevator_shutters_lp");
}

_id_25A5(var_0) {
  var_1 = 0.1;
  var_2 = 25.6;
  var_3 = 0.0;
  var_4 = 2.0;
  self endon("death");
  self endon("deleted");
  self endon("velocitydone");
  thread _id_1326D();
  scripts\engine\utility::waitframe();

  while(isent(self) == 1 && self._id_1326E > 0.001) {
    var_5 = clamp(_id_0F00::_id_EBAF(self._id_1326E, var_1, var_2, var_3, var_4), 0.0, 2.0);
    var_0 _meth_8277(var_5, 0.05);
    scripts\engine\utility::waitframe();
  }
}

_id_25A4(var_0, var_1, var_2) {
  var_3 = level.player.origin + anglesToForward(level.player.angles) * 160.0;
  var_4 = _id_0F00::_id_13EB(var_3);
  var_4._id_10475 = "scn_elevator_lp";
  var_4 _meth_8278(0, 0);
  var_4 playLoopSound(var_4._id_10475);
  scripts\engine\utility::waitframe();
  var_4 _meth_8278(1.0, 1.5);
  var_0._id_C6EA thread _id_25A5(var_4);
  scripts\engine\utility::flag_wait("stop_elevator");
  level.player playSound("scn_elevator_change");
  wait 3.666;
  level.player playSound("scn_elevator_stop");
  var_4 _meth_8278(0.0, 1.666);
  wait 1.666;
  var_4 notify("velocitydone");
  var_4 stoploopsound();
  var_4 _id_0F00::_id_13EC();
}

_id_259F() {
  level._id_B4F1 thread _id_0F00::_id_CE35("scn_elevator_seat_display_mac", 836, -0.5);
  level._id_B4F1 thread _id_0F00::_id_CE35("scn_elevator_harness_mac", 850);
  level._id_EA2C thread _id_0F00::_id_CE35("scn_elevator_seat_display_salt", 835, -0.5);
  level._id_EA2C thread _id_0F00::_id_CE35("scn_elevator_harness_salt", 847);

  while(!isDefined(level._id_D267)) {
    scripts\engine\utility::waitframe();
  }

  level._id_D267 waittillmatch("single anim", "end");
  level._id_D267 thread _id_0F00::_id_CE35("scn_elevator_seat_display_plr", 23, -0.5);
  level._id_D267 thread _id_0F00::_id_CE35("scn_elevator_harness_plr", 19);
  level._id_D267 thread _id_0F00::_id_CE35("yard_plr_pickup_weapon", 100);
}

_id_25D9(var_0) {
  self endon("velocitydone");

  while(isent(self) == 1 && self._id_1326E > 0.001) {
    var_1 = clamp(_id_0F00::_id_EBAF(1.18921 * self._id_1326E, 0.0, 1.0, 0.840896, 1.18921), 0.0, 2.0);
    var_0 _meth_8277(var_1, 0.05);
    scripts\engine\utility::waitframe();
  }
}

_id_25DA(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self._id_D615) == 0) {
    return;
  }
  var_2 = _id_0F00::_id_13EB(self._id_D615.origin);

  if(isDefined(var_2) == 0) {
    return;
  }
  var_2 linkTo(self._id_D615);
  var_2 _meth_8278(0.0, 0.0);
  self._id_D615 _meth_8278(1.0, 0.0);
  thread _id_1326D();
  scripts\engine\utility::waitframe();
  self._id_D615 playSound("scn_storage_pod_move_start");
  var_2._id_10475 = "scn_storage_pod_move_lp";
  var_2 playLoopSound(var_2._id_10475);
  var_2 _meth_8278(1.0, 2.0);
  scripts\engine\utility::waitframe();

  while(isent(self) == 1 && self._id_1326E <= 0.001) {
    scripts\engine\utility::waitframe();
  }

  thread _id_25D9(var_2);

  if(isent(self) == 1 && isDefined(var_1) == 1) {
    var_3 = var_0 - var_1;
    wait(var_3);

    if(isent(self) == 1) {
      self._id_D615 playSound("scn_storage_pod_move_end");
    }

    var_2 _meth_8278(0.0, var_1 - 0.05);
    wait(var_1);
  }

  self notify("velocitydone");
  var_2 stoploopsound();
  var_2 unlink();
  var_2 _id_0F00::_id_13EC();
}

_id_2594() {
  setaudiotriggerstate("airlock_pod_chamber", "");
  level waittill("airlock_kiosk_used");
  wait 0.35;
  level._id_D267 thread _id_0F00::_id_CE33("airlock_console_button_1", "j_mid_ri_3", 18);
  level._id_D267 thread _id_0F00::_id_CE33("airlock_console_button_2", "j_mid_ri_3", 37);
  level._id_D267 thread _id_0F00::_id_CE33("airlock_console_button_lg", "j_wrist_le", 59);
  _id_0F00::_id_1358F(59);
  setaudiotriggerstate("airlock_pod_chamber", "active", 0.666);
  level waittill("airlock_special_cycle_done");
  setaudiotriggerstate("airlock_pod_chamber", "droppod", 0.666);
}

_id_2597() {
  var_0 = (-1474, 116, 768);
  var_1 = (-1474, 116, -768);
  var_2 = (-1474, 116, 768);
  var_3 = (-1474, 116, -768);
  level._id_1188._id_10E38 = _id_0F00::_id_FBB7("static_crackle_pop_lp", 1, var_1, var_0, 0.25, 0.25, "stop_sfx_line_loop");
  level thread _id_0F00::_id_FB80("spark_sm", var_3, var_2, 0.05, 0.5);
}

_id_2598() {
  if(isDefined(level._id_1188._id_10E38) == 1) {
    level._id_1188._id_10E38 notify("stop_sfx_line_loop");
  }

  level notify("stop_sfx_emitter_line");
}

_id_25D3() {
  self endon("death");
  self endon("dont_tell_mom_the_babysitters_dead");

  for(;;) {
    if(isDefined(self._blackboard) && self._blackboard.movetype != "walk") {
      self._blackboard.movetype = "walk";
    }

    if(isDefined(self.a) && self.a.movement != "walk") {
      self.a.movement = "walk";
    }

    scripts\engine\utility::waitframe();
  }
}

_id_25D0(var_0, var_1) {
  _id_0F00::_id_1358F(var_0, var_1);
  level._id_D61B _meth_8278(0.223872, 0);
  level._id_D61B playSound("scn_deathpod_charge_timer");
  wait 2.7666;
  level._id_D61B _meth_8278(0.063095, 0.1333);
  wait 0.1333;
  level._id_D61B _meth_8278(0.223872, 12);
}

_id_25D1(var_0, var_1, var_2) {
  _id_0F00::_id_1358F(var_0, var_1);

  if(isDefined(var_2) == 0) {
    var_2 = 0.0;
  }

  level._id_D61B _meth_8278(0.0, var_2);
  wait(var_2);
  level._id_D61B stopsounds();
}

_id_117B(var_0, var_1, var_2) {
  var_3 = strtok(var_0, ",");

  if(var_3.size < 2) {
    thread scripts\sp\utility::play_sound_on_tag(var_0, "j_head", 1);
  } else {
    thread scripts\sp\utility::play_sound_on_tag(var_3[0], var_3[1], 1);
  }
}

_id_25D7() {
  var_0 = (-1474, 116, -512);
  var_1 = (-1474, 116, 768);
  level._id_B4F1._id_1EFF = ::_id_117B;
  level._id_EA2C._id_1EFF = ::_id_117B;
  level._id_B4F1 thread _id_25D3();
  level._id_EA2C thread _id_25D3();
  level._id_B4F1 _meth_8460("terrain", "metal_grate");
  level._id_EA2C _meth_8460("terrain", "metal_grate");
  level.player _meth_8460("terrain", "metal_grate");
  scripts\engine\utility::flag_wait("mac_death_scene_c_start");
  level.player _meth_8559(0);
  level.player _meth_82C0("yard_deathpod", 5.0);
  level._id_EA2C thread _id_0F00::_id_CE35("scn_deathpod_salt_toss", 126, -0.39);
  level.player thread _id_0F00::_id_CE35("scn_deathpod_plr_charge_foley", 137);
  level._id_D61B thread _id_25D0(177, 0);
  level._id_B4F1 thread _id_0F00::_id_CE33("scn_deathpod_mac_button", "j_mid_ri_3", 221);
  level._id_D617 thread _id_0F00::_id_CE35("scn_deathpod_door_open", 223);
  level._id_D618 thread _id_0F00::_id_CE33("scn_deathpod_c6_vox_wiggle", "j_neck", 260);
  level._id_D618 thread _id_0F00::_id_CE33("scn_deathpod_c6_plr_grab", "j_wrist_le", 273, -0.333);
  level._id_B4F1 thread _id_0F00::_id_CE33("scn_deathpod_mac_stab_foley", "j_chest", 341, -0.42);
  level._id_D618 thread _id_0F00::_id_CE35("scn_deathpod_c6_stab_n_grab", 341);
  level._id_D617 thread _id_0F00::_id_CE35("scn_deathpod_door_hold", 412);
  level._id_EA2C thread _id_0F00::_id_CE33("scn_deathpod_door_grab_salt", "j_wrist_ri", 417);
  level.player thread _id_0F00::_id_CE33("scn_deathpod_door_grab_plr", "j_wrist_ri", 440);
  scripts\engine\utility::flag_wait("mac_death_scene_d_start");
  scripts\engine\utility::flag_wait("mac_death_scene_e_start");
  level._id_D617 thread _id_0F00::_id_CE35("scn_deathpod_door_close", 75);
  level._id_D618 _meth_8278(0.0, 0.666);
  level._id_D61B thread _id_25D1(86, 0.0, 0.5);
  level._id_D617 scripts\engine\utility::delaythread(3.8333, ::_id_2596, -2600, 2.0, 0.0);
  thread _id_0F00::_id_CE23("scn_deathpod_explo", var_0, 140);
  thread _id_0F00::_id_CE23("scn_deathpod_explo_fireball", var_1, 150);
  level.player scripts\engine\utility::delaycall(8.666, ::clearclienttriggeraudiozone, 5.0);
  level._id_EA2C thread _id_0F00::_id_CE35("scn_deathpod_salt_punch_foley", 256, -0.267);
  thread _id_0F00::_id_CE23("scn_deathpod_salt_punch", (-1373, 115, 958), 256, -0.05);
  scripts\engine\utility::flag_wait("mac_death_scene_end");
  level._id_B4F1 notify("dont_tell_mom_the_babysitters_dead");
  level._id_EA2C notify("dont_tell_mom_the_babysitters_dead");
  wait 2.666;
  level.player _meth_8559(1);
  level._id_EA2C _meth_8460("terrain", "");
  level.player _meth_8460("terrain", "");
  level._id_EA2C._id_1EFF = undefined;
}

_id_2599() {
  var_0 = (-1480, 160, 1048);
  var_1 = (-1480, 160, 960);
  var_2 = _id_0F00::_id_13EB(var_0);
  var_2._id_10475 = "droppod_mech_load";
  var_2 playSound(var_2._id_10475, "sounddone");
  wait 2.0;
  var_3 = _id_0F00::_id_13EB(var_1);
  var_3._id_10475 = "droppod_mech_aim";
  var_3 playSound(var_3._id_10475, "sounddone");
  var_3 _id_0F00::_id_13EC();
  var_2 _id_0F00::_id_13EC();
}

_id_2595(var_0, var_1, var_2) {
  var_3 = var_0 / var_1;
  var_4 = 6.666;
  var_5 = _id_0F00::_id_13EB(self.origin, self.angles);
  var_5 _meth_8277(1.0, 0.0);
  var_5 playSound("droppod_launch", "sounddone");
  var_5 movez(var_3 * var_4, var_4, 0.1, 0);
  var_6 = 48.0;
  var_7 = 0.917004;
  var_5 thread _id_0F00::_id_FB6F(var_6, var_7, 0.0, 1);
  var_5 waittill("movedone");
  wait 0.666;
  var_5 _id_0F00::_id_13EC();
}

_id_2596(var_0, var_1, var_2) {
  var_3 = var_0 / var_1;
  var_4 = 6.666;
  var_5 = _id_0F00::_id_13EB(self.origin, self.angles);
  var_5 _meth_8277(1.0, 0.0);
  var_5 playSound("droppod_launch", "sounddone");
  var_5 movez(var_3 * var_4, var_4, 0.1, 0);
  var_6 = 48.0;
  var_7 = 1.18921;
  var_5 thread _id_0F00::_id_FB6F(var_6, var_7, 0.0, 1);
  var_5 waittill("movedone");
  wait 0.666;
  var_5 _id_0F00::_id_13EC();
  _id_0F00::_id_13E9();
}

_id_25D2(var_0) {
  level._id_D7C7 thread _id_0F00::_id_CE35("scn_deathpod_airlock_door_closing", 48, 0);
  level._id_D7C7 thread _id_0F00::_id_CE35("scn_deathpod_airlock_door_shut", 130, 0);
  level._id_D7C7 thread _id_0F00::_id_CE35("scn_deathpod_airlock_door_handle", 155, -0.4666);
  level._id_EA2C thread _id_0F00::_id_CE33("scn_deathpod_airlock_buttons", "j_index_le_3", 200, 0);
  _id_0F00::_id_1358F(48);
  setaudiotriggerstate("airlock_droppod", "closed", 3.666);
  _id_0F00::_id_1358F(82);
  level thread _id_2598();
}

_id_2579(var_0) {
  setaudiotriggerstate("airlock_droppod", "active", 0.666);
  wait 0.666;
  setaudiotriggerstate("airlock_droppod", "mute_emitters", 0.1);

  while(isDefined(level._id_D7D8) == 0) {
    scripts\engine\utility::waitframe();
  }

  level._id_D7D8 scripts\sp\utility::_id_65E3("begin_opening");
  wait 1.9666;
  setaudiotriggerstate("airlock_droppod", "corridor", 0.666);
}

_id_2592() {
  var_0 = 136.47;
  thread _id_0B0B::_id_257D(var_0);
}

_id_2600(var_0) {
  level thread _id_25CD();
  level.player _meth_82C0("yard_shuttle", 0.666);
  var_1 = level._id_11B49._id_5978.origin + (-4, 39, 52);
  var_2 = var_1 + (-256, 0, 0);
  var_3 = _id_0F00::_id_13EB(var_1);
  var_4 = _id_0F00::_id_13EB(var_2);
  var_3 linkTo(level._id_11B49._id_C6EA, "tag_origin");
  var_4 linkTo(level._id_11B49._id_C6EA, "tag_origin");
  var_3._id_10475 = "scn_tram_start";
  var_4._id_10475 = "scn_tram_start_rvb";
  var_3 playSound(var_3._id_10475);
  var_4 playSound(var_4._id_10475);
  wait 10.0;
  var_3._id_10475 = "scn_tram_move";
  var_4._id_10475 = "scn_tram_move_rvb";
  var_3 playSound(var_3._id_10475);
  var_4 playSound(var_4._id_10475);
  wait 19.666;
  var_3._id_10475 = "scn_tram_stop";
  var_4._id_10475 = "scn_tram_stop_rvb";
  var_3 playSound(var_3._id_10475, "sounddone");
  var_4 playSound(var_4._id_10475, "sounddone");
  level._id_11B49._id_C6EA waittill("movedone");
  var_3 waittill("sounddone");
  var_4 waittill("sounddone");
  scripts\engine\utility::flag_wait("junction_tram_end");
  var_3 _id_0F00::_id_13EC();
  var_4 _id_0F00::_id_13EC();
  level.player clearclienttriggeraudiozone(0.666);
}

_id_25CD() {
  var_0 = 2600.0;
  var_1 = 166.6;
  var_2 = 0.840896;
  var_3 = _id_0F00::_id_13EB((234, 14634, 1034));
  var_3._id_10475 = "scn_tram_satellite_whoosh_by";
  var_3 _meth_8278(1.0, 0.0);

  while(distance(var_3.origin, level.player getvieworigin()) > var_0) {
    scripts\engine\utility::waitframe();
  }

  var_3 thread _id_0F00::_id_FB6F(var_1, var_2, 1.0, 1);
  scripts\engine\utility::waitframe();
  var_3 playLoopSound("scn_tram_satellite_whoosh_by");
  scripts\engine\utility::flag_wait("junction_tram_end");
  var_3 _meth_8278(0.0, 0.05);
  scripts\engine\utility::waitframe();
  var_3 stoploopsound();
  var_3 _id_0F00::_id_13EC();
  var_3 = undefined;
}

_id_10523() {
  level.player _id_0F00::_id_CE24("scn_spaced_fall_start");
  level.player _id_0F00::_id_CE24("scn_spaced_fall_end", 1.5);
  level.player _id_0F00::_id_CE24("scn_spaced_crouch", 2.5);
  thread _id_1051F();
}

_id_1051F() {
  var_0 = scripts\engine\utility::spawn_tag_origin((1426, 23658, 615));
  var_1 = scripts\engine\utility::spawn_tag_origin((1434, 23959, 615));
  var_2 = scripts\engine\utility::spawn_tag_origin((1434, 23959, 615));
  var_0 _id_0F00::_id_CE24("scn_spaced_inner_door_shut", 4);
  var_1 _id_0F00::_id_CE24("scn_spaced_hydraulics", 6);
  var_1 _id_0F00::_id_CE24("scn_spaced_creek_debris", 6.5);
  var_1 _id_0F00::_id_CE24("scn_spaced_growl", 6.6);
  var_1 _id_0F00::_id_CE24("scn_spaced_outer_door_open", 7.5);
  var_2 _id_0F00::_id_CE24("scn_spaced_wind", 7.5);
  var_1 _id_0F00::_id_CE24("scn_spaced_screams", 7.8);
  var_1 _id_0F00::_id_CE24("scn_spaced_moan_settle", 8);
  var_1 _id_0F00::_id_CE24("scn_spaced_robot_whoosh", 8.2);
  var_1 _id_0F00::_id_CE24("scn_spaced_outer_door_shut", 12);
  wait 12;
  var_2 scripts\sp\utility::_id_10460(0.2);
  wait 8;
  var_0 delete();
  var_1 scripts\sp\utility::_id_10460(4);
}

_id_2583(var_0) {
  var_1 = 0.1;
  var_2 = 3.0;
  var_3 = 0.5;
  var_4 = 1.0;
  self endon("death");
  self endon("deleted");
  self endon("movedone");
  self endon("velocitydone");
  thread _id_1326D();
  scripts\engine\utility::waitframe();

  for(;;) {
    var_5 = clamp(_id_0F00::_id_EBAF(self._id_1326E, var_1, var_2, var_3, var_4), 0.0, 2.0);
    var_0 _meth_8277(var_5, 0.05);
    scripts\engine\utility::waitframe();
  }
}

_id_2582() {
  self playSound("scn_central_lift_start");
  var_0 = _id_0F00::_id_13EB(self.origin);
  var_0 linkTo(self);
  var_0._id_10475 = "scn_central_lift_lp";
  var_0 _meth_8278(0.0, 0.0);
  var_0 playLoopSound(var_0._id_10475);
  scripts\engine\utility::waitframe();
  var_0 _meth_8278(1.0, 2.0);
  thread _id_2583(var_0);
  self waittill("movedone");
  self playSound("scn_central_lift_stop");
  var_0 _meth_8278(0.0, 0.333);
  wait 0.383;
  var_0 stoploopsound();
  var_0 unlink();
  var_0 _id_0F00::_id_13EC();
}

_id_2606() {
  if(isDefined(self.end._id_2A3E) == 0) {
    self.end._id_2A3E = [];
  }

  if(isDefined(self.end._id_2A3E) && self.end._id_2A3E.size >= 4) {
    var_0 = self.end._id_2A3E[0];
    var_0 stopsounds();
    scripts\engine\utility::waitframe();
    self.end._id_2A3E = scripts\engine\utility::array_remove(self.end._id_2A3E, var_0);
    scripts\engine\utility::waitframe();
  }

  var_1 = _id_0F00::_id_13EB(self.end.origin);
  self.end._id_2A3E = scripts\engine\utility::array_add(self.end._id_2A3E, var_1);
  var_1 playSound("sfx_yard_emi_beam_arc", "sounddone");
  var_1 waittill("sounddone");
  self.end._id_2A3E = scripts\engine\utility::array_remove(self.end._id_2A3E, var_1);
  var_1 _id_0F00::_id_13EC();
  var_1 = undefined;
}

_id_2607() {
  if(isDefined(self) == 0) {
    return;
  }
  if(isDefined(self.end) == 0) {
    return;
  }
  var_0 = level.player getvieworigin();
  var_1 = distance(self.end.origin, var_0);

  if(var_1 <= 666.0) {
    var_2 = randomintrange(0, 4);

    if(var_2 > 0) {
      var_3 = var_2 * 0.05;
      wait(var_3);
    }

    thread _id_2606();
  }
}

_id_258A() {
  level._id_2571._id_8800 = _id_0F00::_id_13EB((1744, 2396, 376));
  level._id_2571._id_8801 = _id_0F00::_id_13EB((1744, 2396, 376));
  level._id_2571._id_8800._id_10475 = "scn_hack_emi_mid_lp";
  level._id_2571._id_8801._id_10475 = "scn_hack_emi_close_lp";
  level._id_2571._id_8800 _meth_8278(0.0, 0.0);
  level._id_2571._id_8801 _meth_8278(0.0, 0.0);
  thread _id_25B8();
  level._id_8805 = "yard_hack_eth3n";
  level.player._id_883B = "scn_hack_limp_eth";
  level.player waittill("player_is_hacked_robot", var_0);
  level.player _meth_82C0(level._id_8805, 0.4);
  scripts\engine\utility::flag_wait("central_hack_hatch_pulled");
  level.player thread _id_0F00::_id_CE35("scn_hack_floor_eth_servos", 0);

  while(isDefined(level._id_1189) == 0) {
    scripts\engine\utility::waitframe();
  }

  level._id_1189 thread _id_0F00::_id_CE35("scn_hack_floor_pull_off", 26);
  level._id_1189 thread _id_0F00::_id_CE35("scn_hack_floor_toss_aside", 146);
  scripts\engine\utility::flag_wait("central_hack_hatch_fell");
  level._id_8805 = "yard_hack_eth3n_core";
  level.player _meth_82C0(level._id_8805, 0.666);
  thread _id_25B9();
  level.player thread _id_0F00::_id_CE35("scn_hack_floor_eth_drop_down", 28, -0.9);
  level waittill("core_pull_started");
  scripts\engine\utility::flag_wait("core_destroyed");
  wait 1.0;
  level._id_2571._id_8801 _meth_8278(0.0, 0.1);
  wait 0.1;
  level._id_2571._id_8801 stoploopsound();
  scripts\engine\utility::flag_wait("central_hack_ethan_end");
  level._id_2571._id_8800 _id_0F00::_id_13EC();
  level._id_2571._id_8801 _id_0F00::_id_13EC();
  level._id_2571._id_8800 = undefined;
  level._id_2571._id_8801 = undefined;
  level._id_8805 = undefined;
  level.player._id_883B = undefined;
}

_id_258E(var_0, var_1, var_2) {
  var_3 = _id_0F00::_id_13EB(self.origin);

  if(isDefined(var_3) == 0) {
    return;
  }
  var_3._id_10475 = "scn_hack_magnet_piece_lp";
  var_3 linkTo(self);
  var_3 playLoopSound(var_3._id_10475);
  var_3 thread _id_0F00::_id_FB6F(var_0, var_1, 0.0, 1);
  scripts\engine\utility::flag_wait("central_hack_ethan_end");
  level notify("end_emi_close_lp");
  var_3 notify("stop_doppler");
  var_3 stoploopsound();
  var_3 unlink();
  var_3 _id_0F00::_id_13EC();
  var_3 = undefined;
}

_id_258F(var_0, var_1, var_2) {
  var_3 = 192.0;
  var_4 = 1.33484;
  var_5 = var_4 * 1.25992;
  var_6 = var_4 * 1.49831;
  var_0 thread _id_258E(var_3, var_4, "core_piece_destroyed_1");
  var_1 thread _id_258E(var_3, var_5, "core_piece_destroyed_2");
  var_2 thread _id_258E(var_3, var_6, "core_piece_destroyed_3");
  scripts\engine\utility::flag_wait_all("core_piece_destroyed_1", "core_piece_destroyed_2", "core_piece_destroyed_3");
  _id_0F00::_id_13E9();
}

_id_2589(var_0, var_1) {
  thread scripts\sp\utility::play_sound_on_tag("scn_hack_metal_stress", "j_wrist_ri");
}

_id_2588(var_0, var_1) {
  thread scripts\sp\utility::play_sound_on_tag("scn_hack_metal_stress", "j_wrist_le");
  thread scripts\sp\utility::play_sound_on_tag("scn_hack_metal_stress", "j_elbow_ri");
  scripts\engine\utility::delaythread(randomfloatrange(0.2666, 0.3666), scripts\sp\utility::play_sound_on_tag, "scn_hack_metal_yank", "j_elbow_ri");
}

_id_2587() {
  while(!scripts\engine\utility::flag("core_destroyed")) {
    var_0 = getdvarfloat("snd_yardHackStaticTime");
    level.player playSound("scn_hack_hud_static");
    wait(_id_0F00::_id_DCC4(0.05, var_0, 0.05));
  }
}

_id_25AA(var_0) {
  switch (var_0) {
    default:
      break;
    case "panel_start_02":
      _id_0F00::_id_CE35("scn_hack_core_dislodge", 5);
      break;
    case "panel_end":
      level.player thread scripts\sp\utility::play_sound_on_tag("scn_hack_metal_stress", "j_wrist_le");
      level.player thread scripts\sp\utility::play_sound_on_tag("scn_hack_metal_stress", "j_wrist_ri");
      thread _id_0F00::_id_CE35("scn_hack_core_tearoff", 5);
      thread _id_0F00::_id_CE35("scn_hack_core_eth_blowback_fall", 35);
      thread _id_0F00::_id_CE35("scn_hack_core_eth_blowback_stand", 75);
      _id_25B7();
      wait 1.333;
      level.player thread _id_2587();
      break;
  }
}

_id_118C() {
  level._id_2571._id_11910 endon("timerdone");

  while(level._id_2571._id_11910.isactive == 1) {
    scripts\engine\utility::waitframe();
    level._id_2571._id_11910.time = (gettime() - level._id_2571._id_11910._id_11932) * 0.001;
    level._id_2571._id_11910._id_912F setvalue(level._id_2571._id_11910.time);
  }
}

_id_118A() {
  if(isDefined(level._id_2571._id_11910)) {
    level._id_2571._id_11910 = undefined;
  }

  level._id_2571._id_11910 = spawnStruct();

  if(isDefined(level._id_2571._id_11910._id_912F)) {
    level._id_2571._id_11910._id_912F destroy();
  }

  level._id_2571._id_11910._id_912F = newhudelem();
  level._id_2571._id_11910._id_912F.x = 320;
  level._id_2571._id_11910._id_912F.y = 240;
  level._id_2571._id_11910.isactive = 1;
  level._id_2571._id_11910._id_11932 = gettime();
  level._id_2571._id_11910 thread _id_118C();
}

_id_118B() {
  level._id_2571._id_11910 notify("timerdone");
  level._id_2571._id_11910.isactive = 0;
  level._id_2571._id_11910._id_912F destroy();
  level._id_2571._id_11910 = undefined;
}

_id_2590(var_0, var_1, var_2, var_3, var_4) {
  level._id_2571._id_8801 playLoopSound(level._id_2571._id_8801._id_10475);
  var_2 playSound("scn_hack_core_periscope");
  var_5 = 0.75;
  level._id_2571._id_8800 _meth_8278(0.8663, var_5);
  level._id_2571._id_8801 _meth_8278(0.5, var_5);
  var_2 waittill("movedone");
  var_3 playSound("scn_hack_core_periscope");
  var_5 = 1.25;
  level._id_2571._id_8800 _meth_8278(0.5, var_5);
  level._id_2571._id_8801 _meth_8278(0.8663, var_5);
  var_3 waittill("movedone");
  var_4 playSound("scn_hack_core_periscope");
  var_5 = 1.25;
  level._id_2571._id_8800 _meth_8278(0.0, var_5);
  level._id_2571._id_8801 _meth_8278(1.0, var_5);
  var_4 waittill("movedone");
  var_4 playSound("scn_hack_core_periscope");
  waittillframeend;
  level._id_2571._id_8800 stoploopsound();
}

_id_25B8() {
  level.player setsoundsubmix("yard_ethan_hack_hatch");
  _id_0F00::_id_CD7B("scn_hack_emi_dist_lp", (1433, 2400, 977), 0.5, "end_emi_dist_lp", 0.666);
  scripts\engine\utility::flag_wait("central_hack_hatch_pulled");
  _id_0F00::_id_1358F(80);
  level.player clearsoundsubmix();
  level._id_2571._id_8800 _meth_8278(1.0, 0.666);
  level._id_2571._id_8800 playLoopSound(level._id_2571._id_8800._id_10475);
}

_id_25B9() {
  level notify("end_emi_dist_lp");
}

_id_25B7() {
  level notify("end_emi_mid_lp");
}

_id_258B(var_0) {
  var_1 = "scn_escape_table_cinematic";
  _id_0F00::_id_CCC7(var_1, var_0);
}

_id_25AB(var_0, var_1, var_2) {
  var_3 = 2;

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(var_2 < var_3) {
    var_4 = 96.0;
    var_5 = 1.18921;
    thread _id_0F00::_id_FB6F(var_4, var_5, 0.0, 1);
    self playLoopSound("scn_escape_missile_lp");
  }
}

_id_2609() {
  level.player _meth_8559(0);
  level.player _meth_82C0("yard_suck_out", 0.5);
  wait 0.1;
  level.player playSound("scn_yard_suck_decomp_blast_lr");
  wait 1.0;
  level.player playSound("scn_yard_suck_air_01_lr");
}

_id_2585() {
  level.player _meth_82C0("yard_escape", 5.0);
  level.player _meth_8559(0);
}

_id_25E5() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playLoopSound("radio_bg_fire_amb_lp");
  level waittill("stop_radio_bg_fire");
  var_0 stoploopsound();
  scripts\engine\utility::waitframe();
  var_0 delete();
}

_id_25E8(var_0, var_1) {
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2 playLoopSound("radio_bg_fire_amb_lp");
  level scripts\engine\utility::waittill_any_timeout(4, "stop_radio_bg_fire");
  var_2 stoploopsound();
  scripts\engine\utility::waitframe();
  var_2 delete();
}

_id_25E7(var_0, var_1) {
  level notify("stop_radio_bg_fire");
}

_id_25E6() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playLoopSound("radio_bg_fire_amb_lp");
  wait 1;

  while(iscinematicplaying() == 1) {
    scripts\engine\utility::waitframe();
  }

  var_0 stoploopsound();
  scripts\engine\utility::waitframe();
  var_0 delete();
}