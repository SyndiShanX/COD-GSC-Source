/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3854.gsc
***************************************/

func_D7F8() {
  precacherumble("steady_rumble");
  precacheshader("overlay_static");
  precacheshader("hud_jackal_overlay_damage");
  precacheshader("hud_iw7_warning");
  precacheshader("hud_iw7_incoming");
  precacheshader("heli_warning_missile_red");
  precacheshader("ac130_hud_friendly_vehicle_diamond_s_w");
  precacheshader("reticle_center_cook");
  precacheshader("hud_offscreenobjectivepointer");
  _func_17C();
}

func_F901() {
  level.func_12A71 = undefined;
  level.func_12A70 = undefined;
  level.func_12A6D = undefined;
  level.func_12A96 = undefined;
  level.func_B8B5 = 1;
  level.func_C07D = 1;
  level.func_A427 = undefined;
  level.func_11937 = 0.05;
  level.func_A3BE = 1;
  level.player func_0BB6::func_B7EA();
}

func_F902() {
  scripts\engine\utility::flag_init("event_turrets_down");
  scripts\engine\utility::flag_init("event_capitalship_down");
  scripts\engine\utility::flag_init("capital_ship_spawned");
  scripts\engine\utility::flag_init("jackalObjectiveDead");
  scripts\engine\utility::flag_init("player_in_jackal");
  scripts\engine\utility::flag_init("hide_hull");
  scripts\engine\utility::flag_init("show_hull");
}

func_A122(var_00, var_01, var_02) {
  var_03 = func_0BDC::func_1079F(var_01, var_00);
  level.func_D127 = var_03;
  func_0BDC::func_10CD1(var_03, var_00, var_02);
  wait 0.1;
  func_0BD6::func_621A();
  thread func_0BD5::func_88DB();
}

func_F900(var_00, var_01, var_02) {
  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  var_03 = getent(var_00, "targetname");
  var_3.script_disconnectpaths = 0;

  if(isDefined(var_01)) {
    var_3.func_EEF9 = var_01;
  } else {
    switch (var_3.model) {
      case "veh_mil_air_ca_carrier_sa_rig":
      case "veh_mil_air_ca_carrier_sa":
      case "veh_mil_air_ca_cruiser":
        var_3.func_EEF9 = "cannon_small_ca cannon_flak_ca";
        break;
      case "veh_mil_air_ca_destroyer":
      default:
        var_3.func_EEF9 = "cannon_small_ca,1,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_m_3,amb_turret_sml_m_4,amb_turret_sml_r_b_1,amb_turret_sml_l_b_1 cannon_flak_ca cannon_missile_ca cannon_large_lock_ca,1,1,amb_turret_sml_m_2,amb_turret_sml_m_1";
        break;
    }
  }

  if(!isDefined(level.func_3965)) {
    var_04 = scripts\sp\vehicle::func_1080E(var_00);
    level.func_3965 = var_4[0];
  }

  level.func_3965 scripts\sp\vehicle::playgestureviewmodel();
  level.func_3965.script_disconnectpaths = 0;

  if(!var_02) {
    level.func_3965.func_12FBA = 1;
  }

  thread func_119C9();
  scripts\engine\utility::flag_set("capital_ship_spawned");
}

func_119C9() {
  level.func_3965 endon("death");
  thread func_119CA();

  for(;;) {
    level.func_3965 waittill("hide_hull");
    level.func_3965 hide();
    level.func_3965 notsolid();
    level.func_3965 func_0BB8::func_39CD("off");
    level.func_3965 func_0BB8::func_39D0("off");
    level.func_3965 func_0BB8::func_39CE("off");
    level.func_3965 waittill("show_hull");
    level.func_3965 show();
    level.func_3965 solid();
    level.func_3965 func_0BB8::func_39CD("idle");
    level.func_3965 func_0BB8::func_39D0("idle");
    level.func_3965 func_0BB8::func_39CE("high");
  }
}

func_119CA() {
  level.func_3965 endon("death");

  for(;;) {
    scripts\engine\utility::flag_wait("hide_hull");
    level.func_3965 notify("hide_hull");
    scripts\engine\utility::flag_clear("hide_hull");
    scripts\engine\utility::flag_wait("show_hull");
    level.func_3965 notify("show_hull");
    scripts\engine\utility::flag_clear("show_hull");
  }
}

func_88BD(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(!isDefined(var_08)) {
    var_08 = 0;
  }

  if(isDefined(var_00)) {
    for(var_09 = 0; var_09 < var_01; var_9++) {
      var_00 waittill("turret_destroyed");
    }
  }

  scripts\engine\utility::flag_set("event_turrets_down");
  var_10 = getent(var_02, "targetname");

  if(isDefined(var_05) && var_05) {
    if(isDefined(var_10) && isDefined(var_10.script_parameters)) {
      var_10.script_parameters = var_10.script_parameters + "doNotCountTurrets 1";
    } else {
      var_10.script_parameters = "doNotCountTurrets 1";
    }
  }

  if(isDefined(var_06)) {
    var_10.func_EEF9 = var_06;
  } else {
    switch (var_10.model) {
      case "veh_mil_air_ca_cruiser":
        var_10.func_EEF9 = "";
        break;
      case "veh_mil_air_ca_frigate":
        var_10.func_EEF9 = "cannon_small_ca,1,1 cannon_flak_ca,1,1";
        break;
      case "veh_mil_air_ca_destroyer":
      default:
        var_10.func_EEF9 = "cannon_small_ca,1,2,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_m_3,amb_turret_sml_m_4,amb_turret_sml_r_b_1,amb_turret_sml_l_b_1 cannon_flak_ca,1,2";
        break;
    }
  }

  if(scripts\engine\utility::is_true(var_07)) {
    var_11 = scripts\sp\vehicle::func_1080C(var_02);
  } else {
    var_11 = func_0BB8::func_398E(var_02, "idle", "heavy", "high");
  }

  level notify("event_capitalship_ftl_in", var_11);

  if(!var_08) {
    var_11.func_12FBA = 1;
  }

  if(isDefined(var_03)) {
    var_12 = getvehiclenode(var_03, "targetname");
    var_11 scripts\sp\vehicle::func_2471(var_12);
  }

  wait 0.1;
  var_11 thread func_0BB6::func_39F0(undefined, undefined, 1);

  for(var_09 = 0; var_09 < var_04; var_9++) {
    var_11 waittill("turret_destroyed");
  }

  scripts\engine\utility::flag_set("event_capitalship_down");
  level notify("event_capitalship_ftl_out");
  var_11 func_0BB8::func_3991();
  var_11 delete();
}

func_88BE(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(!isDefined(var_09)) {
    var_09 = 0;
  }

  if(isDefined(var_00)) {
    for(var_10 = 0; var_10 < var_01; var_10++) {
      var_00 waittill("turret_destroyed");
    }
  }

  scripts\engine\utility::flag_set("event_turrets_down");
  var_11 = getent(var_02, "targetname");

  if(isDefined(var_05) && var_05) {
    if(isDefined(var_11) && isDefined(var_11.script_parameters)) {
      var_11.script_parameters = var_11.script_parameters + "doNotCountTurrets 1";
    } else {
      var_11.script_parameters = "doNotCountTurrets 1";
    }
  }

  if(isDefined(var_06)) {
    var_11.func_EEF9 = var_06;
  } else {
    switch (var_11.model) {
      case "veh_mil_air_ca_cruiser":
        var_11.func_EEF9 = "";
        break;
      case "veh_mil_air_ca_frigate":
        var_11.func_EEF9 = "cannon_small_ca,1,1 cannon_flak_ca,1,1";
        break;
      case "veh_mil_air_ca_destroyer":
      default:
        var_11.func_EEF9 = "cannon_small_ca,1,2,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_m_3,amb_turret_sml_m_4,amb_turret_sml_r_b_1,amb_turret_sml_l_b_1 cannon_flak_ca,1,2";
        break;
    }
  }

  if(scripts\engine\utility::is_true(var_07)) {
    var_12 = scripts\sp\vehicle::func_1080C(var_02);
  } else {
    var_12 = func_0BB8::func_398E(var_02, "idle", "heavy", "high");
  }

  if(!var_09) {
    var_12.func_12FBA = 1;
  }

  level notify("event_capitalship_ftl_in", var_12);

  if(isDefined(var_03)) {
    var_13 = getvehiclenode(var_03, "targetname");
    var_12 scripts\sp\vehicle::func_2471(var_13);
  }

  wait 0.1;

  if(!isDefined(var_08)) {
    var_12 thread func_0BB6::func_39F0(undefined, undefined, 1);
  }

  return var_12;
}

func_88D0(var_00, var_01) {
  playFX(scripts\engine\utility::getfx("destroyer_explode"), var_0.origin);

  if(isDefined(var_01) && var_01 == 1) {
    var_00 delete();
  }
}

func_C28F() {
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_01 = "tag_origin";
  var_00 linkto(self, var_01, (0, 0, 0), (0, 0, 0));
  _target_set(var_00, (0, 0, 60));
  _target_setminsize(var_00, 100, 0);
  _target_setmaxsize(var_00, 100);

  for(;;) {
    if(!isalive(self) || !isDefined(self)) {
      break;
    }
    _target_setshader(var_00, "jackal_objective1");
    _target_setoffscreenshader(var_00, "jackal_objective1");
    wait 0.1;
  }

  var_00 delete();
}

func_FA4E(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = var_00 gettagorigin(var_02);
  var_07 = var_00 gettagangles(var_02);
  var_08 = spawn("script_model", var_06);
  var_8.angles = var_07;
  var_8.func_AD42 = var_02;
  var_8.func_C841 = self;
  var_8.health = var_04;
  var_8.team = "axis";
  var_8.script_team = "axis";
  var_08 setCanDamage(1);
  var_08 getrandomweaponfromcategory();
  var_08 func_0BDC::func_105DB("turret");
  var_08 setModel(var_01);
  var_08 linkto(var_00, var_02, (0, 0, 0), (0, 0, 0));
  var_8.func_4D1E = spawnStruct();
  var_8.func_4D1E.fx = spawnStruct();
  var_8.func_4D1E.fx.func_1037F = "capital_turret_smolder_lg";
  var_8.func_4D1E.fx.func_4CD9 = "capital_turret_damage1_lg";
  var_8.func_4D1E.fx.func_4CDA = "capital_turret_damage2_lg";
  var_8.func_4D1E.fx.death = "capital_turret_death_lg";

  if(isDefined(var_03)) {
    switch (var_03) {
      case "ALL":
        var_08 thread func_0BB6::func_129DD();
        var_08 thread func_613D(var_05);
        break;
      case "EMP":
        var_08 thread func_613D(var_05);
        break;
      default:
        var_08 thread func_0BB6::func_129DD();
    }
  } else
    var_08 thread func_0BB6::func_129DD();

  var_08 scripts\sp\utility::func_F40A("enemy", 0);
}

func_613D(var_00) {
  self endon("terminate_ai_threads");
  self endon("death");
  self endon("entitydeleted");

  if(!isDefined(level.func_10951)) {
    level.func_10951 = [];
  }

  level.func_10951[level.func_10951.size] = self;
  self waittill("emp", var_01, var_02, var_03);
  self.func_4B43 = var_03;
  scripts\engine\utility::flag_set(var_00);
  self hudoutlinedisable();
}

func_B2DB(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(isDefined(var_08)) {
    level endon(var_08);
  }

  func_F9B7();
  self.func_FE2D = [];

  for(var_09 = 0; var_09 <= var_03; var_9++) {
    if(var_09 > var_02) {
      func_13796(self.func_FE2D, self.func_FE2D.size);
    }

    var_10 = func_EF53(var_00 + scripts\sp\utility::string(var_09), var_01 + scripts\sp\utility::string(var_09));

    if(!isDefined(var_10)) {
      continue;
    }
    scripts\engine\utility::waitframe();

    if(!isDefined(var_07) || var_07 == 0) {
      thread func_EF54(var_10);
    }

    func_8927(var_10, var_05, var_06);
    self.func_FE2D = scripts\engine\utility::array_add(self.func_FE2D, var_10);
  }

  if(isDefined(var_04)) {
    level notify(var_04);
  }
}

func_EF53(var_00, var_01, var_02, var_03) {
  var_04 = getent(var_00, "targetname");

  if(!isDefined(var_04)) {
    return;
  }
  var_05 = var_04 scripts\sp\utility::func_10808();
  var_05 func_0BDC::func_19A0(1);

  if(scripts\engine\utility::flag_exist("jackal_wait_launch")) {
    scripts\engine\utility::flag_wait("jackal_wait_launch");
    wait(randomfloat(0.25));
  }

  var_05 thread func_0BDC::func_A1EF(scripts\sp\utility::func_7C9A(var_01));
  return var_05;
}

func_EF54(var_00) {
  var_00 waittill("end_spline");
  var_00 func_0BDC::func_19A0(0);
}

func_EF55(var_00, var_01) {
  var_00 waittill("end_spline");
  var_02 = scripts\sp\utility::func_7C9A(var_01);
  var_00 thread func_0BDC::func_A1EF(var_02);
}

func_B2D9(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(isDefined(var_06)) {
    level endon(var_06);
  }

  func_F9B7();
  self.func_FE2D = [];
  var_07 = getEntArray(var_00, "targetname");
  var_08 = 0;

  if(!isDefined(level.func_C072)) {
    level.func_C072 = 0;
  }

  while(var_08 != var_01) {
    foreach(var_10 in var_07) {
      scripts\engine\utility::waitframe();

      if(var_08 >= var_01) {
        break;
      }
      var_10 scripts\sp\utility::func_1747(func_0BDC::func_19AB, 250);
      var_11 = var_10 scripts\sp\utility::func_10808();
      scripts\engine\utility::waitframe();
      func_8927(var_11, var_04, var_05);
      self.func_FE2D = scripts\engine\utility::array_add(self.func_FE2D, var_11);
      var_8++;
    }
  }

  if(var_02 == -1) {
    var_08 = -2;
  }

  while(var_02 < 0 || var_08 < var_02 && self.func_FE2D.size > 0) {
    self.func_FE2D = scripts\engine\utility::array_removeundefined(self.func_FE2D);

    if(isDefined(level.func_B74A)) {
      func_13796(self.func_FE2D, level.func_B74A);
    } else {
      func_13796(self.func_FE2D, self.func_FE2D.size);
    }

    self.func_FE2D = scripts\engine\utility::array_removeundefined(self.func_FE2D);

    if(self.func_FE2D.size < var_01 && var_08 < var_02) {
      foreach(var_10 in var_07) {
        var_10 scripts\sp\utility::func_1747(func_0BDC::func_19AB, 250);
        var_11 = var_10 scripts\sp\utility::func_10808();

        if(var_02 != -1) {
          var_8++;
        }

        func_8927(var_11, var_04, var_05);
        self.func_FE2D = scripts\engine\utility::array_add(self.func_FE2D, var_11);
        scripts\engine\utility::waitframe();
      }
    }

    wait 1;
  }

  if(isDefined(var_03)) {
    level notify(var_03);
  }
}

func_8927(var_00, var_01, var_02) {
  if(isDefined(var_01)) {
    var_03 = _getcsplineidarray("path_starts");

    if(isDefined(var_03) && isDefined(var_3.size) && var_3.size > 0) {
      var_00 func_0BDC::func_19B3("patrol", "path_starts");
    }
  } else {
    var_03 = _getcsplineidarray("path_starts");

    if(isDefined(var_03) && isDefined(var_3.size) && var_3.size > 0) {
      var_00 func_0BDC::func_19B3("patrol", "path_starts");
    }
  }

  if(isDefined(level.func_A427) && level.func_A427) {
    thread func_A290(var_00);
  }

  if(isDefined(level.func_A3BE) && level.func_A3BE) {
    var_00 thread func_A2D0(var_00);
  }

  var_00 setthreatbiasgroup("jackals");

  if(isDefined(var_02)) {
    if(level.func_C072 >= var_02) {
      var_00 func_0BDC::func_19B1(0);
    } else {
      level.func_C072++;

      if(isDefined(level.func_C07D) && level.func_C07D) {
        thread func_A290(var_00);
      }
    }
  }
}

func_A2D0(var_00) {
  var_01 = scripts\engine\utility::getstructarray("jackal_targets", "targetname");
  var_00 thread func_A13D();
  var_00 thread func_A1C0(var_01);
  var_00 thread func_A1C3(var_01);
}

func_A13D() {
  self endon("stop_firing_turrets_scripted");
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    self waittill("start_death");

    if(!(level.player scripts\sp\utility::func_65DF("player_inside_ship") && level.player scripts\sp\utility::func_65DB("player_inside_ship"))) {
      var_00 = 4;

      if(isDefined(self.script_parameters) && float(self.script_parameters) > 0) {
        var_00 = ceil(float(self.script_parameters));
      }

      if(var_00 == 1) {
        scripts\sp\utility::func_54C6();
      } else {
        var_01 = randomintrange(1, var_00);

        if(var_01 == 1) {
          scripts\sp\utility::func_54C6();
        }
      }
    }
  }
}

func_A1C0(var_00) {
  self endon("stop_firing_turrets_scripted");
  self endon("death");
  self endon("entitydeleted");

  if(!isDefined(level.missiles)) {
    level.missiles = 0;
    level.func_B8AD = [];
  }

  for(;;) {
    self waittill("start_missiles");
    var_01 = gettime();
    var_02 = randomfloatrange(1, 3);

    while(gettime() - var_01 <= var_02) {
      if(!(level.player scripts\sp\utility::func_65DF("player_inside_ship") && level.player scripts\sp\utility::func_65DB("player_inside_ship"))) {
        var_03 = func_A365(var_00, 1);
        func_A1BD(var_03, "missile");
      }

      wait 0.1;
    }
  }
}

func_A1C3(var_00) {
  self endon("stop_firing_turrets_scripted");
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    self waittill("start_strafe");
    var_01 = gettime();
    var_02 = randomfloatrange(1, 3);

    while(gettime() - var_01 <= var_02) {
      if(!(level.player scripts\sp\utility::func_65DF("player_inside_ship") && level.player scripts\sp\utility::func_65DB("player_inside_ship"))) {
        var_03 = func_A365(var_00);
        func_A1BD(var_03, "bullet");
      }

      wait 0.1;
    }
  }
}

func_A365(var_00, var_01) {
  if(isDefined(var_01) && var_01 == 1) {
    var_02 = randomint(var_0.size);
    var_03 = var_0[var_02] scripts\engine\utility::spawn_tag_origin();
  } else {
    var_00 = sortbydistance(var_00, self.origin);

    if(scripts\engine\utility::cointoss()) {
      var_03 = var_0[0] scripts\engine\utility::spawn_tag_origin();
    } else {
      var_03 = var_0[1] scripts\engine\utility::spawn_tag_origin();
    }
  }

  thread func_A35F(var_03);
  return var_03;
}

func_A35F(var_00) {
  wait 8;
  var_00 delete();
}

func_A1BD(var_00, var_01) {
  var_02 = self gettagorigin(self.func_284C[self.func_284B]) + (0, 0, 100);
  var_03 = self gettagangles(self.func_284C[self.func_284B]);
  var_04 = var_0.origin;
  self.func_6D1D = "cap_turret_proj_missile_barrage";

  if(isDefined(var_01) && var_01 == "missile") {
    self.func_114FB = var_00;
    scripts\engine\utility::waitframe();
    thread func_0BB6::func_6D51(var_02, var_03, self.func_284C[self.func_284B], 1);
    wait 0.1;
    self.func_284B = (self.func_284B + 1) % self.func_284C.size;
    var_02 = self gettagorigin(self.func_284C[self.func_284B]) + (0, 0, 100);
    var_03 = self gettagangles(self.func_284C[self.func_284B]);
    thread func_0BB6::func_6D51(var_02, var_03, self.func_284C[self.func_284B], 1);
  } else
    magicbullet("magic_spaceship_30mm_projectile_fake", var_02, var_04 + (0, 0, randomfloatrange(-100, 100)));

  self.func_284B = (self.func_284B + 1) % self.func_284C.size;
}

func_890D() {
  if(!isDefined(level.func_26EB)) {
    return;
  }
  if(!isDefined(level.func_26EB.func_FE2D)) {
    return;
  }
  foreach(var_01 in level.func_26EB.func_FE2D) {
    if(isDefined(var_01) && _target_istarget(var_01)) {
      var_01 _meth_8558();
      var_01 _meth_84C1();
      _target_hidefromplayer(var_01, level.player);
    }
  }
}

func_890C() {
  if(!isDefined(level.func_1D0A)) {
    return;
  }
  if(!isDefined(level.func_1D0A.func_FE2D)) {
    return;
  }
  foreach(var_01 in level.func_1D0A.func_FE2D) {
    if(isDefined(var_01) && _target_istarget(var_01)) {
      _target_hidefromplayer(var_01, level.player);
    }
  }
}

func_8968() {
  if(!isDefined(level.func_1D0A)) {
    return;
  }
  if(!isDefined(level.func_1D0A.func_FE2D)) {
    return;
  }
  foreach(var_01 in level.func_1D0A.func_FE2D) {
    if(isDefined(var_01) && _target_istarget(var_01)) {
      _target_showtoplayer(var_01, level.player);
    }
  }
}

func_11AAB() {
  self waittill("death");
  level.func_C072--;
}

func_E20A(var_00) {
  if(isDefined(var_00)) {
    level.func_C072 = level.func_C072 - int(var_00);

    if(level.func_C072 < 0) {
      level.func_C072 = 0;
    }
  } else
    level.func_C072 = 0;
}

func_13796(var_00, var_01, var_02) {
  var_10 = spawnStruct();

  if(isDefined(var_02)) {
    var_10 endon("thread_timed_out");
    var_10 thread scripts\sp\utility_code::func_13758(var_02);
  }

  var_10.count = var_0.size;

  if(isDefined(var_01) && var_01 < var_10.count) {
    var_10.count = var_01;
  }

  scripts\engine\utility::array_thread(var_00, scripts\sp\utility_code::func_13757, var_10);

  while(var_10.count > 0) {
    var_10 waittill("waittill_dead guy died");
  }
}

func_F3ED(var_00) {
  foreach(var_02 in var_00) {
    var_2.ignoreall = 1;
    var_02 func_0BDC::func_19B1(0);
  }
}

func_A290(var_00) {
  if(!isDefined(scripts\sp\utility::func_C264("OBJ_KILL_JACKALS"))) {
    func_963D();
    scripts\engine\utility::waitframe();
  }

  var_00 thread func_F436();
}

func_963D() {
  _objective_add(scripts\sp\utility::func_C264("OBJ_KILL_JACKALS"), "current", "Kill the jackals");
}

func_F436() {
  if(!isDefined(level.func_A40E)) {
    level.func_A40E = 0;
  }

  var_00 = level.func_A40E;
  _objective_additionalentity(scripts\sp\utility::func_C264("OBJ_KILL_JACKALS"), var_00, self, (0, 0, 60));
  level.func_A40E++;
  thread func_F437(var_00);
  scripts\engine\utility::waittill_any("death", "remove_objective_marker");
  level notify("key_jackal_death");
  _objective_additionalposition(scripts\sp\utility::func_C264("OBJ_KILL_JACKALS"), var_00, (0, 0, 0));
}

func_F437(var_00) {
  level waittill("ship_infil_triggered");
  _objective_additionalposition(scripts\sp\utility::func_C264("OBJ_KILL_JACKALS"), var_00, (0, 0, 0));
}

func_13795() {
  _objective_setpointertextoverride(scripts\sp\utility::func_C264("OBJ_KILL_JACKALS"), "KILL");

  while(level.func_A40E > 0) {
    level waittill("key_jackal_death");
    level.func_A40E--;
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("jackalObjectiveDead");
  scripts\sp\utility::func_C27C(scripts\sp\utility::func_C264("OBJ_KILL_JACKALS"));
}

func_F43B(var_00, var_01) {
  if(!isDefined(self)) {
    return;
  }
  var_02 = scripts\engine\utility::spawn_tag_origin();

  if(!isDefined(var_00)) {
    var_00 = (0, 0, 350);
  }

  if(scripts\sp\utility::hastag(self.model, "j_mainroot")) {
    var_03 = "j_mainroot";
  } else if(scripts\sp\utility::hastag(self.model, "j_mainroot_ship")) {
    var_03 = "j_mainroot_ship";
  } else {
    var_03 = "tag_origin";
  }

  var_02 linkto(self, var_03, (0, 0, 0), (0, 0, 0));
  _target_set(var_02, var_00);
  thread func_A294(var_02);
  thread func_A292(var_02, var_01);
  _target_setminsize(var_02, 100, 0);
  _target_setmaxsize(var_02, 100);
  scripts\engine\utility::waittill_any("death", "entiydeleted", "remove_objective_marker");
  _target_remove(var_02);
  var_02 delete();
}

func_A294(var_00) {
  self endon("entitydeleted");
  self endon("death");
  self endon("remove_objective_marker");

  for(;;) {
    if(isDefined(self.func_AF28)) {
      if(self.func_AF28.func_AF21 || self.func_AF28.locked) {
        _target_setshader(var_00, "ac130_hud_target_flash");
      } else {
        _target_setshader(var_00, "veh_jackal_target");
      }
    } else
      _target_setshader(var_00, "veh_jackal_target");

    wait 0.15;
  }
}

func_A292(var_00, var_01) {
  self endon("entitydeleted");
  self endon("death");
  self endon("remove_objective_marker");
  var_02 = "veh_jackal_target";

  if(isDefined(var_01)) {
    var_02 = var_01;
  }

  for(;;) {
    _target_setoffscreenshader(var_00, var_02);
    wait 0.2;
    _target_setoffscreenshader(var_00, "ac130_hud_target_flash");
    wait 0.1;
  }
}

func_E04A() {
  if(isDefined(self)) {
    self notify("remove_objective_marker");
  }
}

func_F9B7() {
  createthreatbiasgroup("jackals");
  setignoremegroup("allies", "jackals");
  setignoremegroup("axis", "jackals");
  setignoremegroup("jackals", "allies");
  setignoremegroup("jackals", "axis");
}