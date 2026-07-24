/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\pearlharbor\pearlharbor_un_building_fleet.gsc
*************************************************************************/

_id_C9E5() {
  scripts\engine\utility::flag_init("fleet_retribution_flyby");
  scripts\engine\utility::flag_init("fleet_jackal_angles_walkway");
  scripts\engine\utility::flag_init("fleet_jackal_angles_checkpoint");
  scripts\engine\utility::flag_init("fleet_parade_1_stop");
  scripts\engine\utility::flag_init("fleet_parade_2_stop");
  scripts\engine\utility::flag_init("rooftop_go");
  scripts\engine\utility::flag_init("rooftop_jackal_go");
  scripts\engine\utility::flag_init("rooftop_box_movers_go");
  scripts\engine\utility::flag_init("dropship_wave");
  scripts\engine\utility::flag_init("dropship_landing");
  precachemodel("veh_mil_air_un_destroyer");
  precachemodel("veh_mil_air_un_destroyer_periph");
  precachemodel("veh_mil_air_un_cruiser_periph");
  precachemodel("veh_mil_air_un_retribution_rig");
  precachemodel("veh_mil_air_un_retribution_detail_parade");
  precachemodel("veh_mil_air_un_dropship_hero");
  precachemodel("veh_mil_air_un_dropship_drone_periph");
  precachemodel("veh_mil_air_un_cruiser_periph_details");
  precachemodel("veh_civ_domestic_bus_static_vista");
  precachemodel("veh_civ_lnd_un_hatchback_static_vista");
  precachemodel("veh_civ_lnd_un_hatchback_static_vista_black");
  precachemodel("veh_civ_lnd_un_hatchback_static_vista_blue");
  precachemodel("veh_civ_lnd_un_hatchback_static_vista_orange");
  precachemodel("veh_civ_lnd_un_hatchback_static_vista_red");
  precachemodel("veh_civ_lnd_utility_van_static_vista");
  precachemodel("crates_plastic_tech_01");
}

_id_13238(var_0, var_1) {
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel(var_0);
  var_2 notsolid();

  if(!isDefined(var_1)) {
    var_2 hide();
  }

  if(var_0 == "veh_mil_air_un_destroyer_periph") {
    playFXOnTag(level._effect["vfx_ph_destroyer_thruster_low"], var_2, "tag_origin");
  } else if(var_0 == "veh_mil_air_un_cruiser_periph") {
    playFXOnTag(level._effect["vfx_ph_cruiser_thruster_low"], var_2, "tag_origin");
    var_2 attach("veh_mil_air_un_cruiser_periph_details", "tag_origin");
  }

  var_2._id_10984 = undefined;
  var_2._id_1098D = undefined;
  var_2._id_1098A = undefined;
  return var_2;
}

vehicle_cleanup_handler() {
  level waittill("parade_player_in_dropship");
  _id_0BA9::_id_397B();
}

vehicle_cleanupexitboundinginfo(var_0) {
  if(isDefined(var_0)) {
    self waittill("end_spline");
  } else if(self.classname == "script_model") {
    self waittill("pathdone");
  } else {
    self waittill("reached_end_node");
  }

  wait 0.05;

  if(isDefined(var_0)) {
    self delete();
    return;
  }

  _id_0BA9::_id_397B();
}

_id_131D9(var_0, var_1) {
  if(isDefined(var_0)) {
    var_2 = getvehiclenode(var_0, "targetname");
  } else {
    var_2 = getvehiclenode(self.target, "targetname");
  }

  self dontinterpolate();
  self.origin = var_2.origin;
  self.angles = var_2.angles;
  self show();
  var_3 = 1;
  var_4 = 100;

  while(var_3) {
    var_5 = abs(distance(self.origin, var_2.origin));

    if(var_5 != 0) {
      self._id_10984 = var_4;

      if(isDefined(self._id_1098D)) {
        self._id_10984 = self._id_1098D;
        self._id_1098D = undefined;
      } else if(isDefined(var_2.speed))
        self._id_10984 = var_2.speed;

      var_6 = var_5 / self._id_10984;
      self moveTo(var_2.origin, var_6);
      self rotateTo(var_2.angles, var_6);
      thread _id_131DA(var_6);
      self waittill("ph_capship_movedone");
    }

    if(isDefined(self._id_1098A)) {
      self._id_1098A = undefined;
      continue;
    }

    if(isDefined(var_2.script_noteworthy)) {
      self notify(var_2.script_noteworthy);
    }

    if(isDefined(var_2.target)) {
      var_2 = getvehiclenode(var_2.target, "targetname");

      if(!isDefined(var_2)) {
        var_3 = 0;
        self notify("pathdone");
      }

      continue;
    }

    if(!isDefined(var_1)) {
      self moveTo(var_2.origin + (0, 30000, 0), 10);
      self waittill("movedone");
    }

    var_3 = 0;
    self notify("pathdone");
  }

  self delete();
}

_id_131DA(var_0) {
  self endon("ph_capship_movedone");
  var_0 = var_0 - 0.1;

  if(var_0 < 0) {
    var_0 = 0;
  }

  wait(var_0);
  self notify("ph_capship_movedone");
}

_id_E6CC(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_1 = 1;
  } else {
    var_1 = 0;
  }

  if(isDefined(var_2)) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  var_3 = getEnt(var_0, "targetname") scripts\sp\utility::_id_10619(1);

  if(!isDefined(var_3._id_ED1B)) {
    if(isDefined(self.weapon) && var_1) {
      var_3 scripts\sp\utility::_id_86E4();
    }

    if(!var_2) {
      var_3 scripts\sp\utility::_id_51E1("casual");
    }

    var_3 scripts\sp\utility::_id_F3BC();
    var_3 scripts\sp\utility::_id_F415(1);
  }

  return var_3;
}

_id_6EF6(var_0) {
  musicstop();
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 6);
  setsaveddvar("r_umbraMinObjectContribution", 12);
  level._id_6EFA = ["vfx_jackal_rear_show_trail_blue_01", "vfx_jackal_rear_show_trail_white_01", "vfx_jackal_rear_show_trail_red_01"];
  level._id_6EFB = 0;
  _id_6EEF();
  thread _id_6EF7(var_0);
  thread _id_6EFD();
  thread _id_6F06(var_0);
  thread _id_6EF5();
  thread _id_E6CB();
  thread _id_1D85();
  scripts\engine\utility::array_thread(getEntArray("boat_floater", "targetname"), ::_id_1D7B);
  scripts\engine\utility::array_thread(getEntArray("boat_mover", "targetname"), ::_id_131D9);
  var_1 = getEntArray("turret_un_rooftop", "targetname");
  scripts\engine\utility::array_thread(var_1, ::_id_12A48);
  scripts\engine\utility::exploder("fireworks");
}

_id_6EEF() {
  level._id_42B8 = [];
  level._id_42B8[0] = getvehiclenode("parade_1_far", "targetname");
  level._id_42B8[1] = getvehiclenode("parade_1_mid", "targetname");
  level._id_42B8[2] = getvehiclenode("parade_1_close", "targetname");
  level._id_42B8[3] = getvehiclenode("parade_2_close", "targetname");
  level._id_42B8[4] = getvehiclenode("parade_2_mid", "targetname");
  level._id_42B9 = [];
  level._id_42B9[0] = getvehiclenode("parade_1_far_end", "targetname");
  level._id_42B9[1] = getvehiclenode("parade_1_mid_end", "targetname");
  level._id_42B9[2] = getvehiclenode("parade_1_close_end", "targetname");
  level._id_42B9[3] = getvehiclenode("parade_2_close_end", "targetname");
  level._id_42B9[4] = getvehiclenode("parade_2_mid_end", "targetname");
  level._id_6EF0 = [];

  foreach(var_1 in level._id_42B8) {
    var_2 = getvehiclenode(var_1.target, "targetname");
    var_3 = getvehiclenode(var_2.target, "targetname");
    var_1._id_54DA = vectortoangles(var_3.origin - var_2.origin);
    var_1.pos = var_2 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_36FF((12000, 0, 0), var_1._id_54DA);
    var_4 = scripts\engine\utility::spawn_tag_origin(var_1.pos, var_1._id_54DA);
    playFXOnTag(level._effect["vfx_ph_parade_ship_sml_clouds_01"], var_4, "tag_origin");
    level._id_6EF0 = scripts\engine\utility::array_add(level._id_6EF0, var_4);
  }

  foreach(var_1 in level._id_42B9) {
    var_2 = var_1;
    var_1._id_54DA = (0, 270, 0);

    if(var_1 == level._id_42B9[0] || var_1 == level._id_42B9[1]) {
      var_7 = scripts\engine\utility::spawn_tag_origin(var_1.origin + (-20000, -5000, -10000), var_1._id_54DA);
      playFXOnTag(level._effect["vfx_ph_parade_ship_sml_clouds_01"], var_7, "tag_origin");
    }

    var_4 = scripts\engine\utility::spawn_tag_origin(var_1.origin + (-5000, 0, -10000), var_1._id_54DA);
    var_8 = scripts\engine\utility::spawn_tag_origin(var_1.origin + (-20000, -20000, -2000), var_1._id_54DA);
    playFXOnTag(level._effect["vfx_ph_parade_ship_sml_clouds_01"], var_4, "tag_origin");
    playFXOnTag(level._effect["vfx_ph_parade_ship_sml_clouds_01"], var_8, "tag_origin");
    level._id_6EF0 = scripts\engine\utility::array_add(level._id_6EF0, var_4);
  }
}

_id_6F06(var_0) {
  var_1 = getEnt("fleet_retribution", "targetname");

  if(!isDefined(var_0)) {
    var_2 = var_1 scripts\sp\vehicle::_id_1080B();
    var_2 _id_6F07();
    level._id_E35D = var_2;
    var_2 scripts\engine\utility::delaycall(4.5, ::playsound, "scn_phparade_retribution_flyby");
    level.player scripts\engine\utility::delaycall(4.5, ::playsound, "scn_phparade_retribution_flyby_rattle_lr");
    scripts\engine\utility::delaythread(3.0, ::_id_E306);
    var_3 = scripts\engine\utility::getStruct("retribution_fly_in_ap", "targetname");
    var_3 thread scripts\sp\anim::_id_1F35(var_2, "fly_in");
    wait 18.0;
    var_2 _meth_83A1();
  } else {
    var_1.target = "retribution_path_mid";
    var_2 = var_1 scripts\sp\vehicle::_id_1080B();
    var_2 _id_6F07();
  }
}

_id_6F07() {
  wait 0.05;
  self._id_1FBB = "retribution";
  scripts\sp\utility::_id_23B7("retribution");
  _id_0BB8::_id_39BB();
  _id_0BB8::_id_397F(1, 1);
  thread _id_119C7();
  thread _id_0BB8::_id_39AE();
  self castdistantshadows();
  thread vehicle_cleanup_handler();
  self.team = "allies";
  _id_0BB6::_id_39E1();
  self._id_EEF9 = "missile_cluster_turret_un";
  _id_0BB6::_id_39E8();
  wait 0.1;
  thread _id_E304();
  wait 0.5;
  self detach("veh_mil_air_un_retribution_periph", "tag_origin");
  self attach("veh_mil_air_un_retribution", "tag_origin", 1);
}

_id_E306() {
  level._id_E35D notify("kill_rumble_forever");
  wait 1.25;
  var_0 = scripts\sp\utility::_id_7C23("steady_rumble");
  var_0 scripts\sp\utility::_id_F581(0);
  var_0 thread scripts\sp\utility::_id_E7C9(0.4, 10.0);
  level.player _meth_8291(0.3, 0.3, 0.3, 3, 0, -1, 0, 12, 12, 12);
  wait 2;
  level.player _meth_8291(0.25, 0.25, 0.25, 15, 0, -1, 0, 30, 30, 30);
  wait 7;
  var_0 scripts\sp\utility::_id_E7C9(0, 5.0);
  var_0 delete();
}

_id_119C7() {
  wait 1;
  thread _id_0BB8::_id_39D0("off");
  thread _id_0BB8::_id_39CD("off");
  wait 1;
  thread _id_0BB8::_id_39D0("idle");
  thread _id_0BB8::_id_39CD("idle");
}

_id_E304() {
  var_0 = anglesToForward(self.angles);
  var_1 = anglestoright(self.angles);
  var_2 = anglestoup(self.angles);
  var_3 = self.origin + var_0 * 9450 + var_1 * 10800 + var_2 * 3600;
  var_4 = scripts\engine\utility::spawn_tag_origin(var_3, self.angles);
  var_4 linkTo(self);
  var_3 = self.origin + var_0 * -9400 + var_1 * 10000 + var_2 * 2200;
  var_5 = scripts\engine\utility::spawn_tag_origin(var_3, self.angles);
  var_5 linkTo(self);
  wait 3.0;

  foreach(var_7 in self.turrets["cap_turret_missile_barrage"]) {
    var_7 settargetentity(var_5);
  }

  wait 12.0;

  foreach(var_7 in self.turrets["cap_turret_missile_barrage"]) {
    var_7 settargetentity(var_4);
  }
}

_id_6EF5() {
  scripts\engine\utility::flag_wait("roof_second_stop");
  var_0 = getEnt("capship_eclipse", "targetname");
  var_0._id_B210 = "veh_mil_air_un_destroyer";
  level._id_3A01 = var_0 scripts\sp\vehicle::_id_1080B();
  level._id_3A01._id_EA1A = 1;
  level._id_3A01 _id_0BB8::_id_39BB();
  level._id_3A01 _id_0BB8::_id_397F(1, 1);
  level._id_3A01 thread _id_0BB8::_id_39AE();
  level._id_3A01 castdistantshadows();
  level._id_3A01 thread vehicle_cleanupexitboundinginfo();
  level._id_3A01 scripts\engine\utility::delaycall(0.3, ::playsound, "scn_phparade_eclipse_flyby");
  level.player scripts\engine\utility::delaycall(0.2, ::playsound, "scn_phparade_eclipse_flyby_rattle_lr");
  level._id_3A01 waittill("eclipse_zone_stop");
  level._id_3A01._id_EA1A = 0;
  wait 0.05;
}

_id_12A48() {
  var_0 = anglesToForward(self.angles) * 384;
  var_1 = anglestoup(self.angles) * 128;
  var_2 = anglestoright(self.angles) * 384;
  var_3 = var_2 * -1;
  self._id_1A45 = [];
  self._id_1A45[0] = self.origin + var_0 + var_3 + var_1 + (0, 0, 160);
  self._id_1A45[1] = self.origin + var_0 + var_1 + (0, 0, 160);
  self._id_1A45[2] = self.origin + var_0 + var_2 + var_1 + (0, 0, 160);
  self._id_1A45[3] = self.origin + var_0 + var_3 + (0, 0, 160);
  self._id_1A45[4] = self.origin + var_0 + (0, 0, 160);
  self._id_1A45[5] = self.origin + var_0 + var_2 + (0, 0, 160);
  self._id_4B9D = 0;
  self._id_5F27 = scripts\engine\utility::spawn_tag_origin();
  self._id_5F27.origin = self._id_1A45[0];
  self settargetentity(self._id_5F27);

  for(;;) {
    var_4 = _id_12A49();
    self._id_4B9D = var_4;
    var_5 = randomfloatrange(9.0, 12.1);
    var_6 = var_5 / 2;
    self._id_5F27 moveTo(self._id_1A45[var_4], var_5, var_6, var_6);
    thread _id_12A4A();
    wait(var_5 - var_6);
    self notify("turret_sound_done");
    wait(var_6 + randomfloatrange(1.0, 2.1));
  }
}

_id_12A4A() {
  self playSound("phparade_turret_move_start");
  var_0 = scripts\engine\utility::play_loopsound_in_space("phparade_turret_move_lp", self.origin);
  var_0 _meth_8278(0, 0);
  wait 0.05;
  var_0 _meth_8278(1, 1.7);
  self waittill("turret_sound_done");
  wait 2.3;
  var_0 _meth_8278(0, 1.2);
  self playSound("phparade_turret_move_end");
  wait 1.2;
  var_0 stoploopsound();
  var_0 delete();
}

_id_12A49() {
  for(var_0 = self._id_4B9D; var_0 == self._id_4B9D; var_0 = randomint(self._id_1A45.size)) {}

  return var_0;
}

_id_1D85() {
  var_0 = ["veh_civ_domestic_bus_static_vista", "veh_civ_lnd_un_hatchback_static_vista", "veh_civ_lnd_un_hatchback_static_vista_black", "veh_civ_lnd_un_hatchback_static_vista_blue", "veh_civ_lnd_un_hatchback_static_vista_orange", "veh_civ_lnd_un_hatchback_static_vista_red", "veh_civ_lnd_utility_van_static_vista"];

  for(;;) {
    thread _id_1D86(var_0, "ambient_cars_1");
    thread _id_1D86(var_0, "ambient_cars_2");
    thread _id_1D86(var_0, "ambient_cars_3");
    thread _id_1D86(var_0, "ambient_cars_4");
    wait(randomfloatrange(0.75, 3.1));
  }
}

_id_1D86(var_0, var_1) {
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel(scripts\engine\utility::random(var_0));
  var_2 notsolid();
  var_2 thread _id_131D9(var_1, var_2);
}

_id_1D7B() {
  wait(randomfloatrange(1.5, 5.0));

  for(;;) {
    self moveTo(self.origin + (128, 128, 0), 3.0);
    self rotateby((0, 20, 20), 3.0);
    self waittill("movedone");
    self moveTo(self.origin + (-128, 128, 0), 3.0);
    self rotateby((0, -20, -20), 3.0);
    self waittill("movedone");
    self moveTo(self.origin + (-128, -128, 0), 3.0);
    self rotateby((0, -20, -20), 3.0);
    self waittill("movedone");
    self moveTo(self.origin + (128, -128, 0), 3.0);
    self rotateby((0, 20, 20), 3.0);
    self waittill("movedone");
  }
}

_id_6EF7(var_0) {
  thread _id_6EF8();
  wait 3.5;

  if(!isDefined(var_0)) {
    thread _id_6EFC("fleet_jackal_angles_initial");
  }

  scripts\engine\utility::flag_wait("fleet_parade_1_stop");
}

_id_6EF8() {
  var_0 = ["veh_mil_air_un_destroyer_periph", "veh_mil_air_un_cruiser_periph", "veh_mil_air_un_destroyer_periph", "veh_mil_air_un_cruiser_periph", "veh_mil_air_un_destroyer_periph", "veh_mil_air_un_destroyer_periph", "veh_mil_air_un_cruiser_periph", "veh_mil_air_un_destroyer_periph"];
  var_1 = ["parade_1_far_1", "parade_1_mid_1", "parade_1_close_1", "parade_1_far_2", "parade_1_mid_2", "parade_1_far_3", "parade_1_mid_3", "parade_1_close_3"];

  foreach(var_5, var_3 in var_1) {
    var_4 = _id_13238(var_0[var_5], 1);
    wait 0.05;
    var_4 thread _id_131D9(var_3);

    if(issubstr(var_3, "parade_1_close")) {
      var_4 thread _id_6F02();
    }

    var_4 thread _id_FB58(var_3);
  }
}

_id_6EF9() {
  level endon("fleet_parade_1_stop");
  var_0 = getEntArray("fleet_jackal_initial", "targetname");

  while(!scripts\engine\utility::flag("fleet_parade_1_stop")) {
    foreach(var_2 in var_0) {
      var_3 = var_2 scripts\sp\utility::_id_10808();
      var_3 notsolid();
      wait 1.0;
      var_3 notify("notify_stop_thrust_audio");
      var_3 thread _id_0BDC::_id_A342(scripts\sp\utility::_id_7C9A(var_2.target), 0.2);
      var_3 _meth_8485(3.0);
      var_3 thread vehicle_cleanupexitboundinginfo(1);
    }

    wait 5.0;
  }
}

_id_6EFD() {
  level._id_3961 = ["veh_mil_air_un_destroyer_periph", "veh_mil_air_un_cruiser_periph"];
  level._id_C8BA = ["parade_1_far", "parade_1_mid", "parade_1_close"];
  level._id_C8BC = ["parade_2_mid", "parade_2_close"];
  level._id_C8B9 = [];
  level._id_C8B9[0] = ["parade_1_far_dropship_1", "parade_1_far_dropship_2"];
  level._id_C8B9[1] = ["parade_1_mid_dropship_1", "parade_1_mid_dropship_2"];
  level._id_C8B9[2] = ["parade_1_close_dropship_1", "parade_1_close_dropship_2"];
  level._id_C8BB = [];
  level._id_C8BB[0] = ["parade_2_mid_dropship_1", "parade_2_mid_dropship_2"];
  level._id_C8BB[1] = ["parade_2_close_dropship_1", "parade_2_close_dropship_2"];
  level._id_C8C8 = [(-2000, 1600, -1000), (-1900, -1600, 1000), (-4000, 3200, -2000), (-3900, -3200, 2000), (-6000, 4800, -3000), (-5900, -4800, 3000)];
  level._id_C8C9 = 1;
  thread _id_6F01(level._id_C8B9[0], 1);
  thread _id_6F01(level._id_C8B9[2], 1);
  thread _id_6F01(level._id_C8B9[1], 1);
  thread _id_6EFE();
  thread _id_6EFF();
  thread _id_6F00();
  thread _id_A29F();
  scripts\engine\utility::flag_wait("roof_second_stop");
  level._id_C8BA = scripts\engine\utility::array_remove(level._id_C8BA, "parade_1_close");
  level._id_C8BA = scripts\engine\utility::array_remove(level._id_C8BA, "parade_1_far");
}

_id_A29F() {
  wait 9;
  thread _id_6EFC("fleet_jackal_angles_walkway", 2.0);
}

_id_6EFE() {
  level endon("fleet_parade_1_stop");

  while(!scripts\engine\utility::flag("fleet_parade_1_stop")) {
    foreach(var_3, var_1 in level._id_C8BA) {
      var_2 = _id_13238(scripts\engine\utility::random(level._id_3961));
      var_2 dontcastshadows();
      wait 0.05;

      if(level._id_C8B9[var_3].size > 0) {
        var_2 thread _id_6F01(level._id_C8B9[var_3]);
      }

      var_2 thread _id_131D9(var_1);

      if(issubstr(var_1, "parade_1_close")) {
        var_2 thread _id_6F02();
      }

      var_2 thread _id_FB58(var_1);
      wait(randomfloatrange(3.0, 6.1));
    }

    wait(randomfloatrange(15.0, 20.1));
  }
}

_id_6F02() {
  self endon("death");
  self waittill("eclipse_zone_pre");
  self._id_3DCB = 1;
  self._id_3D71 = 1;
  thread _id_6F03();
  self waittill("eclipse_zone_start");
  thread _id_6F04();
}

_id_6F03() {
  self endon("death");
  self endon("eclipse_zone_start");

  while(self._id_3DCB) {
    if(isDefined(level._id_3A01) && isDefined(level._id_3A01._id_EA1A) && level._id_3A01._id_EA1A) {
      self._id_3D71 = 0;
      var_0 = self._id_10984;
      self._id_1098D = self._id_10984 * 0.4;
      self._id_1098A = 1;
      self notify("ph_capship_movedone");
      break;
    }

    wait 0.1;
  }
}

_id_6F04() {
  self endon("death");
  self endon("eclipse_zone_stop");

  while(self._id_3D71) {
    if(isDefined(level._id_3A01) && isDefined(level._id_3A01._id_EA1A) && level._id_3A01._id_EA1A) {
      var_0 = self._id_10984;
      self._id_1098D = self._id_10984 * 1.75;
      self._id_1098A = 1;
      self notify("ph_capship_movedone");
      break;
    }

    wait 0.1;
  }
}

_id_6F01(var_0, var_1) {
  if(!isDefined(var_1)) {
    self waittill("dropships_go");
  }

  foreach(var_3 in var_0) {
    var_4 = getEnt(var_3, "targetname");
    var_5 = var_4 scripts\sp\vehicle::_id_1080B();
    var_5 setModel("veh_mil_air_un_dropship_drone_periph");
    var_5 thread _id_6EF4();
    var_5 notsolid();
    playFXOnTag(level._effect["vfx_ph_dropship_thruster_low"], var_5, "tag_origin");
    var_5 thread _id_FB77(var_3);
    var_5 vehicle_setspeed(randomintrange(550, 800), 100);
    var_5 thread vehicle_cleanupexitboundinginfo();
  }

  if(isDefined(var_1)) {
    return;
  }
}

_id_6EF4() {
  level._id_C8C9++;

  if(level._id_C8C9 > 5) {
    level._id_C8C9 = 1;
  }

  var_0 = [];

  for(var_1 = 0; var_1 <= level._id_C8C9; var_1++) {
    var_2 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_36FF(level._id_C8C8[var_1]);
    var_3 = spawn("script_model", var_2);
    var_3 setModel("veh_mil_air_un_dropship_drone_periph");
    var_3.angles = self.angles;
    var_3 linkTo(self);
    var_3 notsolid();
    playFXOnTag(level._effect["vfx_ph_dropship_thruster_low"], var_3, "tag_origin");
    var_0[var_1] = var_3;
  }

  self waittill("reached_end_node");

  foreach(var_3 in var_0) {
    var_3 delete();
  }
}

_id_6F00() {
  var_0 = ["veh_mil_air_un_cruiser_periph"];
  var_1 = ["parade_2_close_1"];
  scripts\engine\utility::flag_wait("roof_second_stop");
  thread _id_6F01(level._id_C8BB[0], 1);
  thread _id_6F01(level._id_C8BB[1], 1);

  foreach(var_5, var_3 in var_1) {
    var_4 = _id_13238(var_0[var_5]);
    var_4 dontcastshadows();
    wait 0.05;
    var_4 thread _id_FB58(var_3);
    var_4 thread _id_131D9(var_3);
  }
}

_id_6EFF() {
  scripts\engine\utility::flag_wait("roof_second_stop");
  wait 2.0;

  while(!scripts\engine\utility::flag("fleet_parade_2_stop")) {
    foreach(var_3, var_1 in level._id_C8BC) {
      var_2 = _id_13238(scripts\engine\utility::random(level._id_3961));
      var_2 dontcastshadows();
      wait 0.05;

      if(level._id_C8BB[var_3].size > 0) {
        var_2 thread _id_6F01(level._id_C8BB[var_3]);
      }

      var_2 thread _id_FB58(var_1);
      var_2 thread _id_131D9(var_1);
      wait(randomfloatrange(1.5, 3.1));
    }

    wait(randomfloatrange(10.0, 15.1));
  }
}

_id_6EFC(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = 1.0;
  }

  var_3 = 0;
  var_4 = getEntArray(var_0, "targetname");

  foreach(var_6 in var_4) {
    var_7 = var_6 scripts\sp\utility::_id_10808();
    var_7 notsolid();
    var_3++;
    wait 0.25;
    var_7 notify("notify_stop_thrust_audio");
    var_7 thread _id_0BDC::_id_A342(scripts\sp\utility::_id_7C9A(var_6.target), 0.2);
    var_7 _meth_8485(var_2);
    var_7 thread vehicle_cleanupexitboundinginfo(1);
    playFXOnTag(level._effect[_id_79BF()], var_7, "tag_origin");

    if(var_3 == 1) {
      if(var_0 == "fleet_jackal_angles_initial") {
        var_7 playSound("scn_phparade_balcony_jackal_flybys_01");
        continue;
      }

      var_7 playSound("scn_phparade_balcony_jackal_flybys_02");
    }
  }

  playworldsound("phparade_crowd_dist_cheer", (-23253, -17800, -26332));
}

_id_79BF() {
  level._id_6EFB++;

  if(level._id_6EFB > 2) {
    level._id_6EFB = 0;
  }

  return level._id_6EFA[level._id_6EFB];
}

_id_E6CB() {
  scripts\engine\utility::flag_wait("roof_second_stop");

  if(!isDefined(level._id_E6C2)) {
    level._id_E6C2 = [];
  }

  _id_FA2D();
  _id_FA2C();
  _id_FA2E();
  _id_FA2F();
  wait 0.05;
  thread _id_CDE9();
  thread _id_CDE6();
}

_id_FA2F() {
  _id_FA30();
  _id_FA32();
  _id_FA31();
}

_id_FA32() {
  var_0 = scripts\engine\utility::getStruct("engine_repair_ap", "targetname");
  var_0 = var_0 scripts\engine\utility::spawn_script_origin();
  var_0.origin = var_0.origin + (0, 0, 1.3);
  var_1 = scripts\sp\utility::_id_107EA("engine_repair_a", "targetname");
  var_2 = scripts\sp\utility::_id_107EA("engine_repair_b", "targetname");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_armory_catwalk_vig_idle_01_guyA");
  var_0 thread scripts\sp\anim::_id_1ECC(var_2, "shipcrib_armory_catwalk_vig_idle_01_guyB");
}

_id_FA30() {
  var_0 = scripts\engine\utility::getStruct("c12_maintenance_guys", "targetname");
  var_1 = scripts\sp\utility::_id_107EA("rooftop_c12_a", "targetname");
  var_2 = scripts\sp\utility::_id_107EA("rooftop_c12_b", "targetname");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_console_serv_01_A");
  var_0 thread scripts\sp\anim::_id_1ECC(var_2, "shipcrib_console_serv_01_B");
}

_id_FA31() {
  var_0 = scripts\engine\utility::getStruct("hangar_box_movers_01", "targetname");
  var_1 = scripts\sp\utility::_id_107EA("rooftop_box_mover_a", "targetname");
  var_1._id_1FBB = "crate_mover_guyA";
  var_1._id_1EF1 = scripts\sp\utility::_id_10639("crate_move_A");
  var_2 = scripts\sp\utility::_id_107EA("rooftop_box_mover_b", "targetname");
  var_2._id_1FBB = "crate_mover_guyB";
  var_2._id_1EF1 = scripts\sp\utility::_id_10639("crate_move_B");
  level._id_4851 = getEnt("crate_clipA", "targetname");
  level._id_4852 = getEnt("crate_clipB", "targetname");
  var_2 scripts\sp\utility::_id_86E4();
  thread _id_CDEA([var_1, var_2, var_1._id_1EF1, var_2._id_1EF1], var_0);
  thread _id_40B8([var_1._id_1EF1, var_2._id_1EF1], var_0);
  var_1 scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_E693();
  var_2 scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_E693();
}

_id_CDEA(var_0, var_1) {
  var_0[0] endon("death");
  var_1 thread scripts\sp\anim::_id_1EE7(var_0, "crate_move_pre_idle");
  level waittill("rooftop_box_movers_go");
  wait 2;
  var_1 notify("stop_loop");
  var_1 scripts\sp\anim::_id_1EC1(var_0, "crate_move");
  level._id_4851 linkTo(var_0[2]);
  level._id_4852 linkTo(var_0[3]);
  var_1 scripts\sp\anim::_id_1F2C(var_0, "crate_move");
  var_1 thread scripts\sp\anim::_id_1EE7(var_0, "crate_move_post_idle");
  var_0[1] thread _id_0EE5::_id_202D();
}

_id_40B8(var_0, var_1) {
  level waittill("rooftop_cleanup");
  var_1 notify("stop_loop");
  var_1 thread scripts\sp\anim::_id_1EE0(var_0[0], "crate_move");
  var_1 thread scripts\sp\anim::_id_1EE0(var_0[1], "crate_move");
}

_id_FA2E() {
  var_0 = scripts\engine\utility::getStruct("catwalk_flat_pair_ap", "targetname");
  var_1 = scripts\sp\utility::_id_107EA("catwalk_flat_pair_a", "targetname");
  var_2 = scripts\sp\utility::_id_107EA("catwalk_flat_pair_b", "targetname");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "ph_parade_catwalk_flat_guyA_01");
  var_0 thread scripts\sp\anim::_id_1ECC(var_2, "ph_parade_catwalk_flat_guyB_01");
  var_1 scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_E693();
  var_2 scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_E693();
  var_3 = scripts\engine\utility::getStruct("wall_looker_1_ap", "targetname");
  var_4 = scripts\sp\utility::_id_107EA("wall_looker_1", "targetname");
  var_3 thread scripts\sp\anim::_id_1ECC(var_4, "shipcrib_return_deck_catwalk_idle01");
  var_4 scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_E693();
}

_id_FA2C() {
  level._id_5EDC = scripts\engine\utility::getStruct("dropship_wave_ap", "targetname");
  level._id_5EDC = level._id_5EDC scripts\engine\utility::spawn_script_origin();
  level._id_5EDC.origin = level._id_5EDC.origin + (0, 0, 16.5);
  level._id_5EDB = _id_E6CC("dropship_wave");
  level._id_5EDB._id_1FBB = "jackal_a_wave1";
  level._id_5EDC thread scripts\sp\anim::_id_1EEA(level._id_5EDB, "jackal_wave_wait");
  level._id_5EDB scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_E693();
}

_id_CDE6() {
  level._id_5EDB endon("death");
  scripts\engine\utility::flag_wait("roof_second_stop");
  wait 3.5;
  level._id_5EDC notify("stop_loop");
  level._id_5EDC thread scripts\sp\anim::_id_1F35(level._id_5EDB, "jackal_wave_enter");
  wait 17.0;
  level._id_5EDB thread scripts\sp\anim::_id_1EEA(level._id_5EDB, "shipcrib_inspection_90_high_idle");
  wait 1;
  level._id_5EDB._id_247B = spawn("script_model", level._id_5EDB gettagorigin("tag_inhand"));
  level._id_5EDB._id_247B setModel("p7_desk_metal_military_03_tablet");
  level._id_5EDB._id_247B linkTo(level._id_5EDB, "tag_inhand", (0, 0, 0), (0, 0, 0));
}

_id_FA2D() {
  var_0 = scripts\engine\utility::getStruct("rooftop_jackal_animnode", "targetname");
  level._id_E69C = var_0 scripts\engine\utility::spawn_script_origin();
  level._id_E69C.origin = level._id_E69C.origin + (0, 0, 12.7);
  var_0 = level._id_E69C;
  level._id_E69B = [];
  var_1 = "rooftop_jackal_";
  level._id_E69B["section1_guyB"] = _id_E6CC(var_1 + "section1_guyB");
  level._id_E69B["section2_guyA"] = _id_E6CC(var_1 + "section2_guyA");
  level._id_E69B["section2_guyB"] = _id_E6CC(var_1 + "section2_guyB");
  level._id_E69B["section3_guyA"] = _id_E6CC(var_1 + "section3_guyA");
  level._id_E69B["section3_guyB"] = _id_E6CC(var_1 + "section3_guyB");
  level._id_E69B["waverA"] = _id_E6CC(var_1 + "waverA");
  level._id_E69B["waverB"] = _id_E6CC(var_1 + "waverB");
  level._id_E6A7 = [];
  level._id_E6A7 = [];
  level._id_E6A7["section1_toolbox"] = ::scripts\sp\utility::_id_10639("jackal_toolbox_1", level._id_E69C.origin);
  level._id_E6A7["section2_toolbox"] = ::scripts\sp\utility::_id_10639("jackal_toolbox_2", level._id_E69C.origin);
  level._id_E6A7["section3_toolbox"] = ::scripts\sp\utility::_id_10639("jackal_toolbox_3", level._id_E69C.origin);
  level._id_E6A7["section1_toolbox"]._id_2485 = "jackal_toolbox_pc";
  level._id_E6A7["section2_toolbox"]._id_2485 = "jackal_toolbox_pc";
  level._id_E6A7["section3_toolbox"]._id_2485 = "jackal_toolbox_tablet";
  level._id_E6A7["section1_toolbox"].attach_offset = [(-6, -2, 38), (0, 0, 0)];
  level._id_E6A7["section2_toolbox"].attach_offset = [(-4, -6, 38), (0, 356, 0)];
  level._id_E6A7["section3_toolbox"].attach_offset = [(6, 2, 38), (0, 356, 0)];
  var_2 = getarraykeys(level._id_E69B);

  foreach(var_4 in var_2) {
    level._id_E69B[var_4]._id_1FBB = var_4;
  }

  foreach(var_7 in level._id_E69B) {
    var_0 thread scripts\sp\anim::_id_1EEA(var_7, "jackal_land_entrance_idle", "stop_" + var_7._id_1FBB);
  }

  foreach(var_10 in level._id_E6A7) {
    var_0 scripts\sp\anim::_id_1EC3(var_10, "jackal_land_entrance");

    if(isDefined(var_10._id_2485)) {
      var_11 = scripts\sp\utility::_id_10639(var_10._id_2485);
      var_11 linkTo(var_10, "tag_origin", var_10.attach_offset[0], var_10.attach_offset[1]);
    }
  }
}

_id_CDE9() {
  scripts\engine\utility::flag_wait("rooftop_jackal_go");
  level._id_E69A = scripts\sp\vehicle::_id_1080C("rooftop_jackal_land");
  level._id_E69A _id_0BDC::_id_19A0();
  level._id_E69A._id_1FBB = "jackal";
  var_0 = getspawner("dropship_pilot_spawner", "targetname");
  var_0.count++;
  level.jackal_pilot = scripts\sp\utility::_id_107EA("dropship_pilot_spawner");
  level.jackal_pilot._id_1FBB = "jackal_pilot";
  level.jackal_pilot scripts\sp\utility::_id_86E4();
  var_1 = scripts\engine\utility::spawn_script_origin(level._id_E69A.origin, level._id_E69A.angles);
  var_1 linkTo(level._id_E69A, "", (0, 0, 12), (0, 0, 0));
  level.jackal_pilot linkTo(level._id_E69A);
  var_1 thread scripts\sp\anim::_id_1EEA(level.jackal_pilot, "pilot_idle");
  thread _id_E6A0();
  wait 1;
  level._id_E69B["waverA"] thread _id_CDE7();
  wait 6;
  level._id_E69B["section1_guyB"] thread _id_CDE7();
  level._id_E6A7["section1_toolbox"] thread _id_CDE8();
  level._id_E69B["section2_guyA"] thread _id_CDE7();
  level._id_E69B["section2_guyB"] thread _id_CDE7();
  level._id_E6A7["section2_toolbox"] thread _id_CDE8();
  level._id_E69B["section3_guyA"] thread _id_CDE7();
  level._id_E69B["section3_guyB"] thread _id_CDE7();
  level._id_E6A7["section3_toolbox"] thread _id_CDE8();
  wait 9.5;
  level._id_E69B["waverB"] thread _id_CDE7();
}

_id_E6A0() {
  var_0 = scripts\engine\utility::getStruct("rooftop_jackal_animnode", "targetname");
  var_0 = var_0 scripts\engine\utility::spawn_script_origin();
  var_0.origin = var_0.origin + (0, 0, -3);
  var_1 = getstartorigin(var_0.origin, var_0.angles, level._id_EC85["jackal"]["ph_parade_jackal_land_idle"][0]);
  var_2 = getstartangles(var_0.origin, var_0.angles, level._id_EC85["jackal"]["ph_parade_jackal_land_idle"][0]);
  scripts\engine\utility::waitframe();
  var_0 thread scripts\sp\anim::_id_1F35(level._id_E69A, "ph_parade_jackal_land");
  wait 18.0;
  var_3 = scripts\engine\utility::play_loopsound_in_space("phparade_jackal_idle", level._id_E69A.origin);
  var_3 linkTo(level._id_E69A);
  level._id_E69A _id_0BDC::_id_6B4C("landed_mode", 1);
  var_0 waittill("ph_parade_jackal_land");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_E69A, "ph_parade_jackal_land_idle");
}

_id_CDE7() {
  self endon("death");
  var_0 = level._id_E69C;
  var_0 notify("stop_" + self._id_1FBB);
  var_0 thread scripts\sp\anim::_id_1F35(self, "jackal_land_entrance");
  var_1 = getanimlength(scripts\sp\utility::_id_7DC1("jackal_land_entrance"));
  scripts\engine\utility::flag_wait_or_timeout("parade_player_in_dropship", var_1);
  var_0 scripts\sp\anim::_id_1EEA(self, "jackal_maintenance_idle");
}

_id_CDE8() {
  var_0 = level._id_E69C;
  var_0 scripts\sp\anim::_id_1F35(self, "jackal_land_entrance");
  var_0 scripts\sp\anim::_id_1EE0(self, "jackal_land_entrance");
}

_id_FB77(var_0) {
  if(issubstr(var_0, "close")) {
    scripts\sp\utility::play_loop_sound_on_tag("scn_phparade_dropships_close_lp", "tag_origin", 1, 1);
  } else if(issubstr(var_0, "mid")) {
    scripts\sp\utility::play_loop_sound_on_tag("scn_phparade_dropships_med_lp", "tag_origin", 1, 1);
  } else if(issubstr(var_0, "far")) {
    scripts\sp\utility::play_loop_sound_on_tag("scn_phparade_dropships_dist_lp", "tag_origin", 1, 1);
  }
}

_id_FB58(var_0) {
  if(issubstr(var_0, "close")) {
    scripts\sp\utility::play_loop_sound_on_tag("scn_phparade_capital_ship_close_lp", "tag_origin", 1, 1);
  } else if(issubstr(var_0, "mid")) {
    scripts\sp\utility::play_loop_sound_on_tag("scn_phparade_capital_ship_med_lp", "tag_origin", 1, 1);
  }
}