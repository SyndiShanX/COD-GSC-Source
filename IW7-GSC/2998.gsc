/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2998.gsc
***************************************/

func_12A89() {
  scripts\engine\utility::flag_init("show_capital_turrets");
  scripts\engine\utility::flag_init("turrets_destroyed");
  scripts\engine\utility::flag_init("capital_ship_spawned");
  level.func_C214 = 4;
  precachemodel("ship_exterior_ca_cannon_a_rig");
  precachemodel("ship_exterior_ca_cannon_a_rig_dst");
  precachemodel("ship_exterior_un_cannon_b_rig");
  precachemodel("ship_exterior_un_cannon_b_rig_dst");
  precachemodel("ship_exterior_un_turret_a_rig");
  precachemodel("ship_exterior_un_turret_a_rig_dst");
  precachemodel("ship_exterior_un_turret_b_rig");
  precachemodel("ship_exterior_un_turret_b_rig_dst");
  precachemodel("sdf_ship_exterior_un_turret_b_rig");
  precachemodel("sdf_ship_exterior_un_turret_b_rig_s0p75");
  precachemodel("sdf_ship_exterior_un_turret_b_rig_dst");
  precachemodel("ship_exterior_missile_pod_a_rig");
  precachemodel("ship_exterior_missile_pod_a_rig_dst");
  precachemodel("ship_exterior_ca_turret_missile_b");
  precachemodel("ship_exterior_ca_turret_missile_b_s0p75");
  precachemodel("ship_exterior_ca_turret_missile_b_dst");
  precachemodel("cap_turret_missile_un");
  precachemodel("ship_exterior_missile_pod_a_rig");
  precachemodel("cap_turret_small_ca");
  precachemodel("cap_turret_missile_ca");
  precachemodel("veh_mil_air_ca_missile_boat_turret");
  precachemodel("veh_mil_air_ca_missile_boat_turret_dst");
  precachemodel("jackal_arena_aa_turret_01");
  precachemodel("ship_exterior_ca_missile_hatch_a");
  precachemodel("ship_exterior_turret_mg_01");
  precachemodel("ship_exterior_damage_piece_d_crater_01_dst");
  precachemodel("ship_exterior_damage_piece_d_crater_04_dst_s1p2");
  precachemodel("ship_exterior_damage_piece_d_crater_16_dst_s0p8");
  precachemodel("ship_exterior_damage_piece_d_crater_22_dst");
  precachemodel("ship_exterior_ca_turret_missile_b_01_dst");
  precachemodel("ship_exterior_ca_turret_missile_b_02_dst");
  precachemodel("ship_exterior_ca_turret_missile_b_03_dst");
  precachemodel("ship_exterior_ca_turret_missile_b_04_dst");
  precachemodel("ship_exterior_ca_turret_missile_b_01_dst_s0p75");
  precachemodel("ship_exterior_ca_turret_missile_b_02_dst_s0p75");
  precachemodel("ship_exterior_ca_turret_missile_b_03_dst_s0p75");
  precachemodel("ship_exterior_ca_turret_missile_b_04_dst_s0p75");
  precachemodel("projectile_c12rocket_boxcoll");
  precacheturret("cap_turret_med_flak");
  precacheturret("cap_turret_small_constant");
  precacheturret("cap_turret_missile_barrage");
  precacheturret("cap_turret_large");
  precacheturret("cap_turret_cannon_large_ca");
  precacheturret("cap_turret_cannon_large_ca_zerog_noexp");
  precacheturret("cap_turret_phalanx");
  precacheitem("cap_turret_proj_missile_barrage");
  precacheitem("cap_turret_proj_small_constant");
  precacheitem("cap_turret_proj_med_flak");
  precacheitem("cap_turret_proj_weapon");
  precacheitem("cap_mons_projectile");
  precacheitem("cap_missileboat_projectile");
  precacheshader("hud_iw7_warning");
  precacheshader("hud_iw7_incoming");
  precacheshader("heli_warning_missile_red");
  precacheshader("ac130_hud_friendly_vehicle_diamond_s_w");
  _setsaveddvar("r_hudOutlineEnable", 1);
  func_12A87();
}

func_12A87() {
  level._effect["jet_missile_imp_water"] = loadfx("vfx\old\space_fighter\vfx_jet_missile_imp_water.vfx");
  level._effect["jet_missile_imp_generic"] = loadfx("vfx\iw7\levels\moon\vfx_jet_missile_imp_generic_moon.vfx");
  level._effect["jet_missile_imp_airburst"] = loadfx("vfx\iw7\levels\moon\vfx_jet_missile_imp_generic_moon_premature.vfx");
  level._effect["capital_turret_death_sm"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_death_sm.vfx");
  level._effect["capital_turret_damage1_sm"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_dmg1.vfx");
  level._effect["capital_turret_damage2_sm"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_dmg2.vfx");
  level._effect["capital_turret_smolder_sm"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_smolder_sm.vfx");
  level._effect["capital_turret_muzzle_sm"] = loadfx("vfx\iw7\core\muzflash\cannon\vfx_muzflash_capital_30mm_looping.vfx");
  level._effect["capital_turret_muzzle_sm_noloop"] = loadfx("vfx\iw7\core\muzflash\cannon\vfx_muzflash_capital_30mm.vfx");
  level._effect["capital_turret_death_md"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_death_md.vfx");
  level._effect["capital_turret_damage1_md"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_dmg1.vfx");
  level._effect["capital_turret_damage2_md"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_dmg2.vfx");
  level._effect["capital_turret_smolder_md"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_smolder_md.vfx");
  level._effect["capital_turret_muzzle_md"] = loadfx("vfx\iw7\core\muzflash\cannon\vfx_muzflash_capital_40mm_flak.vfx");
  level._effect["capital_turret_explosion_md"] = loadfx("vfx\iw7\core\expl\weap\flak\vfx_flak_blast_a_runner.vfx");
  level._effect["capital_turret_death_lg"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_death_lrg.vfx");
  level._effect["capital_turret_damage1_lg"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_dmg1.vfx");
  level._effect["capital_turret_damage2_lg"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_dmg2.vfx");
  level._effect["capital_turret_smolder_lg"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_smolder_lrg.vfx");
  level._effect["capital_turret_muzzle_lg"] = loadfx("vfx\iw7\core\muzflash\cannon\vfx_mega_cannon_muzflash.vfx");
  level._effect["capital_turret_laser_lg"] = loadfx("vfx\old\_requests\prisoner\pnr_sniper_laser_scan.vfx");
  level._effect["capital_turret_fire_laser_lg"] = loadfx("vfx\iw7\_requests\mp\vfx_disruptor_laser");
  level._effect["capital_turret_death_smt"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_death_smt.vfx");
  level._effect["capital_turret_damage1_smt"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_dmg1.vfx");
  level._effect["capital_turret_damage2_smt"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_dmg2.vfx");
  level._effect["capital_turret_smolder_smt"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_smolder_smt.vfx");
  level._effect["capital_turret_muzzle_smt"] = loadfx("vfx\old\core\muzflash\vfx_flash_missile_tube_launch");
  level._effect["capital_missile_flare_smt"] = loadfx("vfx\iw7\core\smktrail\vfx_seeking_missile_trail.vfx");
  level._effect["capital_missile_imp_airburst_smt"] = loadfx("vfx\iw7\core\expl\weap\missile\vfx_missile_shotdown.vfx");
  level._effect["capital_missile_imp_capship_gen"] = loadfx("vfx\iw7\core\expl\weap\missile\vfx_missile_imp_capship_generic.vfx");
  level._effect["capital_dead_turret_ship_predeath"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_ship_explo_dead_turret.vfx");
  level._effect["capital_turret_death_emp"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_death.vfx");
  level._effect["capital_turret_damage1_emp"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_dmg1.vfx");
  level._effect["capital_turret_damage2_emp"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_dmg2.vfx");
  level._effect["capital_turret_smolder_emp"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_smolder_sm.vfx");
  level._effect["capital_turret_muzzle_emp"] = loadfx("vfx\level\moon\vfx_turret_muzz_tracer_ground");
  level._effect["capital_turret_death_wh"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_death.vfx");
  level._effect["capital_turret_damage1_wh"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_dmg1.vfx");
  level._effect["capital_turret_damage2_wh"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_dmg2.vfx");
  level._effect["capital_missile_imp_airburst_wh"] = loadfx("vfx\iw7\core\expl\weap\missile\vfx_missile_shotdown.vfx");
  level._effect["capital_turret_smoke_trail"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_smk_trail.vfx");
  level._effect["capital_turret_smoke_trail"] = loadfx("vfx\iw7\core\vehicle\turret\vfx_cap_turret_smk_trail.vfx");
  level._effect["capital_turret_sml_cheap"] = loadfx("vfx\iw7\core\muzflash\cannon\vfx_turret_small_cheap.vfx");
  level._effect["capital_un_turret_sml_cheap"] = loadfx("vfx\iw7\core\muzflash\cannon\vfx_un_turret_small_cheap.vfx");
  level._effect["capital_turret_flak_cheap"] = loadfx("vfx\iw7\core\muzflash\cannon\vfx_flack_cannon_cheap.vfx");
}

func_39E8(var_00) {
  self.turrets = [];
  self.func_B8B6 = [];
  self.func_8B4F = [];
  self.func_12A09 = 1;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "no_turrets") {
    return;
  }
  if(isDefined(self.func_EEF9) && self.func_EEF9 == "none") {
    return;
  }
  var_01 = [];

  if(issubstr(self.classname, "turret")) {
    if(self.func_6A8D == "un")
      var_01 = ["cannon_small_un", "cannon_flak_un", "cannon_missile_un"];
    else
      var_01 = ["cannon_small_ca", "cannon_flak_ca", "cannon_missile_ca"];
  } else if(self.func_6A8D == "un")
    var_01 = ["cannon_large_un"];
  else if(issubstr(self.classname, "missileboat")) {
    if(!issubstr(self.classname, "plane"))
      var_01 = ["cannon_missile_ca_hardpoint", "cannon_small_ca"];
  } else
    var_01 = ["cannon_large_ca"];

  if(var_1.size == 0) {
    return;
  }
  if(!scripts\sp\utility::func_65DF("hold_fire"))
    scripts\sp\utility::func_65E0("hold_fire");

  if(isDefined(self.func_EEF9)) {
    self.func_12A09 = 0;
    var_01 = strtok(self.func_EEF9, " ");
  }

  if(isDefined(self.script_parameters)) {
    var_02 = strtok(self.script_parameters, " ");

    for(var_03 = 0; var_03 < var_2.size; var_3++) {
      if(var_2[var_03] == "doNotCountTurrets")
        self.func_592A = var_2[var_03 + 1];
    }
  }

  foreach(var_05 in var_01)
  func_39E0(var_05);

  self.func_129D1 = var_01;
  func_39EA(var_01, self.func_592A);
  self notify("turrets_spawned");
}

func_39E0(var_00) {
  if(!isDefined(level.func_39DD))
    level.func_39DD = [];

  var_01 = strtok(var_00, ",");
  var_02 = var_1[0];
  var_03 = var_1[1];
  var_04 = var_1[2];

  if(isDefined(level.func_39DD[var_02])) {
    return;
  }
  var_05 = spawnStruct();

  switch (var_02) {
    case "cannon_large_un":
      var_05 func_0BB7::func_F8F9();
      break;
    case "cannon_large_ca":
      var_05 func_0BB7::func_F8F8();
      break;
    case "cannon_small_ca":
      var_05 func_0BB7::func_F8FE(self.script_team, var_03, var_04, self);
      break;
    case "cannon_small_ca_mons":
      var_05 func_0BB7::func_F8FF(self.script_team, var_03, var_04, self);
      break;
    case "cannon_small_un":
      var_05 func_0BB7::func_F8FE(self.script_team, var_03, var_04, self);
      break;
    case "cannon_flak_ca":
      var_05 func_0BB7::func_F8F6(self.script_team, var_03, var_04);
      break;
    case "cannon_missile_ca":
      var_05 func_0BB7::func_F8FA(self.script_team, var_03, var_04);
      break;
    case "cannon_missile_long_ca":
      var_05 func_0BB7::func_F8FC(self.script_team, var_03, var_04);
      break;
    case "missile_cluster_turret_un":
      var_05 func_0BB7::func_F9D6(self.script_team, var_03, var_04);
      break;
    case "cannon_missile_ca_hardpoint":
      var_05 func_0BB7::func_F8FB(self.script_team, var_03, var_04, self);
      break;
    case "cannon_large_lock_ca":
      var_05 func_0BB7::func_F8F7(self.script_team, var_03, var_04);
      break;
    case "cannon_phalanx":
      var_05 func_0BB7::func_F8FD(self.script_team, var_03, var_04);
      break;
    case "missile_tube_un":
      var_05 func_0BB7::func_F9DA();
      break;
    case "missile_tube_ca":
      var_05 func_0BB7::func_F9D8();
      break;
    case "missile_tube_ca_mons":
      var_05 func_0BB7::func_F9D9();
      break;
    case "cannon_missileboat_small":
      self.func_12A09 = 0;
      var_05 func_0BB7::func_F9DB();
      break;
    default:
      break;
  }

  level.func_39DD[var_02] = var_05;
}

func_39EA(var_00, var_01) {
  if(!isDefined(level.func_B4D0)) {
    level.func_B4D0 = 0;
    level.func_12A91 = 0;
  }

  foreach(var_03 in var_00) {
    var_04 = strtok(var_03, ",");
    var_05 = var_4[0];
    var_06 = level.func_39DD[var_05];

    if(isDefined(var_4[3])) {
      for(var_07 = 3; isDefined(var_4[var_07]); var_7++) {
        var_08 = strtok(var_4[var_07], ":");
        var_09 = var_8[0];
        var_10 = undefined;

        if(var_8.size == 5)
          var_10 = [int(var_8[1]), int(var_8[2]), int(var_8[3]), int(var_8[4])];

        if(self.func_12A09 == 0 && scripts\sp\utility::hastag(self.model, var_09))
          func_107FC(var_06, var_05, var_09, undefined, var_10);
      }

      continue;
    }

    var_11 = 0;

    foreach(var_13 in var_6.tag) {
      var_07 = 1;

      for(;;) {
        var_09 = var_13 + "_" + var_07;

        if(scripts\sp\utility::hastag(self.model, var_09)) {
          if(isDefined(var_6.func_8B3B) && var_6.func_8B3B)
            func_1072D(var_06, var_05, var_09);
          else if(self.func_12A09 == 0) {
            if(var_05 != "cannon_missile_ca")
              func_107FC(var_06, var_05, var_09, var_01, var_6.func_2106[var_09]);
            else if(var_05 == "cannon_missile_ca" && scripts\engine\utility::mod(var_07, level.func_C214) == 1)
              func_39E6(var_06, var_05, var_13, var_07);
          } else
            func_107FD(var_06, var_05, var_09);

          var_11++;
          var_7++;
        } else
          break;

        if(var_11 >= 8) {
          var_11 = 0;
          wait 0.05;
        }
      }
    }
  }

  if(isDefined(level.func_12A71) && level.func_12A71)
    func_8933();
}

func_39CA(var_00, var_01, var_02) {
  if(self.script_team == "allies") {
    return;
  }
  if(!isDefined(var_01))
    var_01 = 0;

  if(!isDefined(var_02))
    var_02 = "turret";

  thread func_39CB(var_00, var_01, var_02);
}

func_39CB(var_00, var_01, var_02) {
  if(!isDefined(var_00))
    var_00 = 0;

  self notify("turret_target_status_change");
  self endon("death");
  self endon("turret_target_status_change");

  if(var_00) {
    thread func_0B76::func_39C3(3);
    wait 1;
  }

  var_03 = [];

  foreach(var_05 in self.turrets) {
    var_05 = scripts\engine\utility::array_removeundefined(var_05);
    var_03 = scripts\engine\utility::array_combine(var_03, var_05);
  }

  if(var_01) {
    foreach(var_08 in self.func_8B4F)
    var_03 = scripts\engine\utility::array_combine(var_03, var_08);
  }

  func_39CF(var_03, var_00, var_02);
}

func_39CF(var_00, var_01, var_02) {
  if(!isDefined(var_01))
    var_01 = 0;

  var_03 = "turret";

  if(isDefined(var_02))
    var_03 = var_02;

  var_00 = scripts\engine\utility::array_randomize(var_00);

  foreach(var_05 in var_00) {
    if(isDefined(var_05)) {
      if(!isDefined(var_5.script_team)) {}

      if(isDefined(var_5.func_11549))
        var_06 = var_5.func_11549;
      else
        var_06 = "turret";

      if(isDefined(var_5.func_3AF3))
        var_07 = var_5.func_3AF3;
      else
        var_07 = "medium_target";

      if(scripts\sp\utility::func_B324())
        var_05[[level.func_A056.func_11543]](var_03, var_06, var_07, "enemy_jackal");

      if(var_01)
        var_05 playSound("jackal_target_is_set");

      wait 0.05;
    }
  }
}

func_39C0() {
  thread func_39C1();
}

func_39C1(var_00) {
  self notify("turret_target_status_change");
  self endon("death");
  self endon("turret_target_status_change");
  var_00 = [];

  if(isDefined(self.func_12A69)) {
    foreach(var_02 in self.func_12A69)
    var_00 = scripts\engine\utility::array_combine(var_00, var_02);
  } else {
    foreach(var_05 in self.turrets)
    var_00 = scripts\engine\utility::array_combine(var_00, var_05);
  }

  if(isDefined(self.func_8B4F)) {
    foreach(var_08 in self.func_8B4F)
    var_00 = scripts\engine\utility::array_combine(var_00, var_08);
  }

  func_39C2(var_00);
  self notify("turrets_not_targetable");
}

func_39C2(var_00) {
  var_00 = scripts\engine\utility::array_randomize(var_00);

  foreach(var_02 in var_00) {
    if(isDefined(var_02) && isDefined(var_2.func_AEDF) && var_2.func_AEDF.func_AEEA) {
      if(scripts\sp\utility::func_B324())
        var_02[[level.func_A056.func_11540]]();
    }

    wait 0.05;
  }
}

func_39E6(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(self.func_12A69))
    self.func_12A69 = [];

  if(!isDefined(var_04))
    var_04 = level.func_C214;

  var_05 = [];

  for(var_06 = 0; var_06 < var_04; var_6++) {
    var_07 = var_03 + var_06;
    var_08 = var_02 + "_" + var_07;

    if(scripts\sp\utility::hastag(self.model, var_08))
      var_5[var_5.size] = func_107FC(var_00, var_01, var_08);
  }

  self.func_12A69[self.func_12A69.size] = var_05;
  thread func_39E7(var_05);
}

func_39E7(var_00) {
  func_13819(var_00, 1);
  scripts\engine\utility::array_thread(var_00, ::func_129E0);
}

func_107FC(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_0.type;

  if(isDefined(level.func_241D) && !level.func_241D)
    var_05 = var_0.func_12AE6;

  var_06 = spawnturret("misc_turret", self gettagorigin(var_02), var_05, 0);
  var_6.class = var_01;
  var_6.type = var_0.type;
  var_6.func_AD42 = var_02;

  if(scripts\engine\utility::is_true(self.spawn_hidden_turrets))
    var_06 hide();

  var_07 = (0, 0, 0);

  if(isDefined(self.func_12A08) && isDefined(self.func_12A08[var_02])) {
    var_07 = self.func_12A08[var_02];
    var_6.func_ACFF = var_07;
  }

  var_06 linkto(self, var_02, (0, 0, 0), var_07);
  var_06 setModel(var_0.model);
  var_06 setturretteam(var_0.team);
  var_6.team = var_0.team;
  var_6.script_team = var_0.team;
  var_6.func_9FF0 = 1;
  var_6.func_C841 = self;
  var_06 makeunusable();
  var_06 setCanDamage(1);
  var_06 give_player_session_tokens(var_0.func_B8F9);
  var_06 getrandomweaponfromcategory();
  var_06 _meth_8534(1);
  var_6.class_progression_init = var_00;

  if(var_0.team != "allies") {}

  if(isDefined(var_0.func_3AF3))
    var_6.func_3AF3 = var_0.func_3AF3;

  if(isDefined(var_0.func_11549))
    var_6.func_11549 = var_0.func_11549;

  if(isDefined(var_0.func_6D1D))
    var_6.func_6D1D = var_0.func_6D1D;

  var_6.func_2103 = var_0.func_2103;
  var_6.func_2107 = var_0.func_2107;
  var_6.func_2109 = var_0.func_2109;
  var_6.func_2100 = var_0.func_2100;

  if(isDefined(var_04)) {
    var_6.func_2103 = var_4[0];
    var_6.func_2107 = var_4[1];
    var_6.func_2109 = var_4[2];
    var_6.func_2100 = var_4[3];
  }

  var_6.func_2104 = cos(var_6.func_2103);
  var_6.func_2108 = cos(var_6.func_2107);
  var_6.func_210A = cos(var_6.func_2109);
  var_6.func_2101 = cos(var_6.func_2100);
  var_06 setleftarc(var_6.func_2103);
  var_06 setrightarc(var_6.func_2107);
  var_06 settoparc(var_6.func_2109);
  var_06 give_crafted_gascan(var_6.func_2100);
  var_06 setdefaultdroppitch(0);

  if(isDefined(var_0.func_45E4)) {
    var_6.func_45E4 = var_0.func_45E4;
    var_06 _meth_82C9(var_0.func_45E4, "yaw");
  } else {
    var_6.func_45E4 = 5;
    var_06 _meth_82C9(5, "yaw");
  }

  if(isDefined(var_0.func_45E3)) {
    var_6.func_45E3 = var_0.func_45E3;
    var_06 _meth_82C9(var_0.func_45E3, "pitch");
  } else {
    var_6.func_45E3 = 5;
    var_06 _meth_82C9(5, "pitch");
  }

  var_06 settargetentity(var_06, (0, 0, 0));
  var_6.func_114FB = var_06;
  var_6.func_10241 = var_0.func_10241;
  var_6.health = var_0.func_10241.health;
  var_6.func_4D1E = var_0.func_4D1E;
  var_6.func_1D52 = var_0.func_1D52;
  var_6.func_934D = var_0.func_934D;
  var_06 thread func_129DD();

  if(!isDefined(self.turrets[var_0.type]))
    self.turrets[var_0.type] = [];

  self.turrets[var_0.type][self.turrets[var_0.type].size] = var_06;
  var_08 = undefined;
  var_09 = undefined;

  if(var_01 == "cannon_missileboat_small") {
    var_09 = strtok(var_02, "_");
    var_09 = int(var_9[var_9.size - 1]);

    if(var_09 < 7)
      var_08 = self.func_12A33[0];
    else
      var_08 = self.func_12A33[1];

    if(!isDefined(var_8.turrets))
      var_8.turrets = [];

    var_6.func_C8F3 = self;
    var_8.turrets[var_8.turrets.size] = var_06;
    func_0BB7::func_B878(var_06, self, var_02);
  }

  if(isDefined(var_03)) {
    return;
  }
  if(isDefined(level.func_12A70) && level.func_12A70) {
    var_10 = "ac130_hud_target";
    var_11 = (1, 0, 0);
    thread func_1150D(var_06, var_10, var_11, 128, (0, 0, 96));
  }

  var_06 thread func_129D2();
  level.func_12A91++;
  level.func_B4D0++;
  return var_06;
}

func_129D2() {
  self waittill("death");

  if(isDefined(self.func_B04A)) {
    self.func_B04A stoploopsound();
    scripts\engine\utility::waitframe();

    if(isDefined(self.func_B04A))
      self.func_B04A delete();
  }
}

func_1072D(var_00, var_01, var_02) {
  if(isDefined(var_0.model)) {
    var_03 = spawn("script_model", self gettagorigin(var_02));
    var_3.angles = self gettagangles(var_02);
    var_03 setModel(var_0.model);
    var_03 linkto(self);
    var_3.func_C841 = self;
    var_3.team = var_0.team;
    var_3.script_team = var_0.team;
    var_03 setCanDamage(1);
    var_3.health = var_0.func_10241.health;
    var_3.func_4D1E = var_0.func_4D1E;
    var_3.func_1D52 = var_0.func_1D52;
    var_03 thread func_129DD();

    if(scripts\engine\utility::is_true(self.spawn_hidden_turrets))
      var_03 hide();
  } else
    var_03 = spawnStruct();

  var_3.class = var_01;
  var_3.tag = var_02;
  var_3.func_AD42 = var_02;
  var_3.type = var_0.type;
  var_3.func_10241 = var_0.func_10241;

  if(isDefined(var_0.func_10241.func_EF60))
    var_3.func_EF60 = var_0.func_10241.func_EF60;

  if(isDefined(var_0.func_10241.func_EF5F))
    var_3.func_EF5F = var_0.func_10241.func_EF5F;

  if(isDefined(var_0.func_3AF3))
    var_3.func_3AF3 = var_0.func_3AF3;

  if(isDefined(var_0.func_11549))
    var_3.func_11549 = var_0.func_11549;

  if(!isDefined(self.func_8B4F[var_0.type])) {
    self.func_8B4F[var_0.type] = [];
    self.func_8B50[var_0.type] = [];
    self.func_8B51[var_0.type] = [];
  }

  self.func_8B4F[var_0.type][self.func_8B4F[var_0.type].size] = var_03;

  if(issubstr(var_02, "_l_"))
    self.func_8B50[var_0.type][self.func_8B4F[var_0.type].size] = var_03;
  else
    self.func_8B51[var_0.type][self.func_8B4F[var_0.type].size] = var_03;
}

func_39EF() {
  foreach(var_01 in self.turrets) {
    foreach(var_03 in var_01) {
      if(isDefined(self.func_129C4[var_3.func_AD42])) {
        var_04 = self.func_129C4[var_3.func_AD42];

        if(var_4.size != 4) {}

        var_03 setleftarc(var_4[0]);
        var_03 setrightarc(var_4[1]);
        var_03 settoparc(var_4[2]);
        var_03 give_crafted_gascan(var_4[3]);
        var_3.func_2103 = var_4[0];
        var_3.func_2107 = var_4[1];
        var_3.func_2109 = var_4[2];
        var_3.func_2100 = var_4[3];
        var_3.func_2104 = cos(var_3.func_2103);
        var_3.func_2108 = cos(var_3.func_2107);
        var_3.func_210A = cos(var_3.func_2109);
        var_3.func_2101 = cos(var_3.func_2100);
      }
    }
  }
}

func_3984(var_00) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  foreach(var_02 in self.turrets) {
    foreach(var_04 in var_02) {
      if(!isDefined(var_04)) {
        continue;
      }
      var_4.func_AF58 = self.func_12A09;
      var_04 thread func_39ED(var_00, !self.func_12A09);
      wait(randomfloatrange(0.01, 0.3));
    }
  }
}

func_3983(var_00) {
  if(isarray(var_00))
    var_01 = var_00;
  else
    var_01 = [var_00];

  foreach(var_03 in self.func_8B4F)
  thread func_399D(var_03, var_01, 1);
}

func_3989(var_00, var_01, var_02, var_03, var_04) {
  var_05 = [var_00];
  var_06 = undefined;

  if(!isDefined(self.func_8B4F) || self.func_8B4F.size == 0) {
    return;
  }
  var_07 = randomint(self.func_8B4F.size);
  var_08 = -1;

  foreach(var_10 in self.func_8B4F) {
    var_8++;

    if(var_08 == var_07)
      var_06 = var_10;
  }

  var_06 = [var_6[randomint(var_6.size)]];
  var_12 = var_6[0].class;
  var_13 = level.func_39DD[var_12].func_10241;

  if(isDefined(self.func_10245) && isDefined(self.func_10245[var_12]))
    var_13 = self.func_10245[var_12];

  self[[var_13.func_6CF8]](var_05, var_06, var_13, var_01, var_02, var_03, var_04);
}

func_39F4(var_00, var_01) {
  if(!isDefined(self.func_10245))
    self.func_10245 = [];

  self.func_10245[var_00] = var_01;
}

func_107FD(var_00, var_01, var_02) {
  var_03 = spawn("script_model", self gettagorigin(var_02));
  var_3.class = var_01;
  var_3.type = var_0.type;
  var_03 linkto(self, var_02, (0, 0, 0), (0, 0, 0));
  var_03 setModel(var_0.model);
  var_03 notsolid();
  var_3.script_team = var_0.team;
  var_3.func_AD42 = var_02;

  if(!isDefined(self.turrets[var_0.type]))
    self.turrets[var_0.type] = [];

  self.turrets[var_0.type][self.turrets[var_0.type].size] = var_03;
  var_04 = undefined;
  var_05 = undefined;

  if(var_01 == "cannon_missileboat_small") {
    var_05 = strtok(var_02, "_");
    var_05 = int(var_5[var_5.size - 1]);

    if(var_05 < 7)
      var_04 = self.func_12A33[0];
    else
      var_04 = self.func_12A33[1];

    if(!isDefined(var_4.turrets))
      var_4.turrets = [];

    var_3.func_C8F3 = self;
    var_4.turrets[var_4.turrets.size] = var_03;
    func_0BB7::func_B878(var_03, self, var_02);
  }
}

func_39E9(var_00, var_01) {
  if(self.func_12A09 == var_00 && (isDefined(var_01) && !var_01)) {
    return;
  }
  self.func_12A09 = var_00;
  func_39E1();
  func_39EA(self.func_129D1);
}

func_39EE(var_00) {
  if(!isDefined(var_00))
    var_00 = 0;

  foreach(var_02 in self.turrets) {
    foreach(var_04 in var_02) {
      if(isDefined(var_04)) {
        if(var_00) {
          var_04 hide();
          continue;
        }

        var_04 show();
      }
    }
  }
}

func_39E1() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.turrets)) {
    foreach(var_01 in self.turrets) {
      foreach(var_03 in var_01) {
        if(isDefined(var_03))
          var_03 delete();
      }
    }

    self.turrets = [];
  }

  if(isDefined(self.func_8B4F)) {
    foreach(var_07 in self.func_8B4F) {
      foreach(var_09 in var_07) {
        if(isDefined(var_09) && !_isstruct(var_09)) {
          var_09 delete();
          continue;
        }

        var_09 = undefined;
      }
    }
  }
}

func_39ED(var_00, var_01) {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_00)) {
    return;
  }
  var_02 = (0, 0, 0);

  if(isDefined(var_0.func_24C4) && var_0.classname != "script_vehicle_corpse") {
    var_03 = scripts\engine\utility::random(var_0.func_24C4);

    if(!scripts\sp\utility::hastag(var_0.model, var_03)) {
      return;
    }
    var_04 = var_00 gettagorigin(var_03);
    var_05 = (randomintrange(-2000, 2000), randomintrange(-2000, 2000), randomintrange(-750, 750));
    var_02 = var_04 - var_0.origin;
    var_02 = var_02 + var_05;
    self.func_24C3 = var_04;
    self.func_24C5 = var_00;
  }

  self.func_114FB = var_00;
  self.func_1DF8 = var_00;

  if(self.func_AF58 == 0 && !isDefined(self.func_D92F))
    self settargetentity(var_00, var_02);

  func_39E2(var_01);
}

func_39EC() {
  if(!isDefined(self)) {
    return;
  }
  self cleartargetentity();
  func_39EB();
  self.func_114FB = self;
}

func_39DC(var_00) {
  var_01 = [];

  if(!scripts\sp\utility::hastag(var_00, "tag_flash_3")) {
    for(var_02 = 1; scripts\sp\utility::hastag(var_00, "tag_flash_" + var_02); var_2++)
      var_1[var_1.size] = "tag_flash_" + var_02;
  }

  if(var_1.size == 0) {
    if(scripts\sp\utility::hastag(var_00, "tag_flash"))
      var_1[var_1.size] = "tag_flash";
    else if(scripts\sp\utility::hastag(var_00, "jackal_arena_aa_turret_01_guns_part"))
      var_1[var_1.size] = "jackal_arena_aa_turret_01_guns_part";
    else if(scripts\sp\utility::hastag(var_00, "tag_origin"))
      var_1[var_1.size] = "tag_origin";
    else {}
  }

  return var_01;
}

func_39E2(var_00) {
  if(!isDefined(self)) {
    return;
  }
  self notify("stop_shooting");
  self endon("stop_shooting");
  self endon("death");
  self endon("entitydeleted");
  var_01 = func_39DC(self.model);
  var_02 = 0;
  var_03 = 0;
  var_04 = 1;
  var_05 = level.func_39DD[self.class].func_10241;

  if(isDefined(self.func_C841) && isDefined(self.func_C841.func_10245) && isDefined(self.func_C841.func_10245[self.class]))
    var_05 = self.func_C841.func_10245[self.class];

  wait(randomfloat(2));

  for(;;) {
    if(isDefined(self.func_1D65) && self.func_1D65 == 1)
      var_06 = var_5.func_1DFC;
    else
      var_06 = 1.0;

    if(randomfloat(1) < var_06) {
      if(var_5.func_13536[0] == var_5.func_13536[1])
        var_02 = var_5.func_13536[0];
      else
        var_02 = randomfloatrange(var_5.func_13536[0], var_5.func_13536[1]);
    }

    while(var_02 > 0) {
      if(var_00)
        self waittill("turret_on_target");

      if(!func_12A32(var_01)) {
        var_07 = 0;

        foreach(var_09 in var_01) {
          if(isDefined(var_5.func_10943)) {
            self[[var_5.func_10943]](var_09);
            continue;
          }

          if(self.func_AF58 == 0 && !isDefined(self.func_C841.func_12FBA)) {
            if(!var_07 && soundexists("capitalship_cannon_fire")) {
              self playSound("capitalship_cannon_fire");
              var_07 = 1;
            }

            self shootturret(var_09);
            continue;
          }

          if(!isDefined(var_5.func_6CF8)) {
            return;
          }
          var_10 = func_12A36(var_09);
          var_11 = func_12A37(var_09, var_10);
          var_10 = anglesToForward(var_10);
          self thread[[var_5.func_6CF8]](var_11, var_10, var_09);
        }

        thread func_12A02(0.33);
      }

      if(isDefined(self.func_C841) && isDefined(self.func_C841.func_24C2) && randomint(100) < self.func_C841.func_24C2) {
        if(isDefined(self.func_24C3) && isDefined(self.func_24C5)) {
          var_13 = (randomintrange(-2000, 2000), randomintrange(-2000, 2000), randomintrange(-750, 750));
          var_14 = self.func_24C3 - self.func_24C5.origin;
          var_14 = var_14 + var_13;

          if(self.func_AF58 == 0 && !isDefined(self.func_D92F))
            self settargetentity(self.func_24C5, var_14);
        }
      }

      wait(var_5.func_6D20);
      var_02 = var_02 - var_5.func_6D20;
    }

    var_03 = randomfloatrange(var_5.func_13535[0], var_5.func_13535[1]);
    wait(var_03);
  }
}

func_39EB() {
  self notify("stop_shooting");
}

func_6D4D(var_00, var_01, var_02, var_03) {
  var_04 = level.func_39DD[self.class];
  var_05 = var_4.func_4D1E.fx;

  if(scripts\sp\utility::hastag(self.model, "tag_flash_1") && scripts\sp\utility::hastag(self.model, "tag_flash_2")) {
    var_02 = "tag_flash_1";

    if(scripts\engine\utility::is_true(self.func_6D40)) {
      var_02 = "tag_flash_2";
      self.func_6D40 = 0;
    } else
      self.func_6D40 = 1;

    playFXOnTag(scripts\engine\utility::getfx(var_5.func_BDFF), self, var_02);
  } else if(scripts\sp\utility::hastag(self.model, "TAG_FLASH"))
    playFXOnTag(scripts\engine\utility::getfx(var_5.func_BDFF), self, "TAG_FLASH");
  else
    playFX(scripts\engine\utility::getfx(var_5.func_BDFF), var_00, var_01);

  if(isDefined(var_4.func_10241.func_6D32) && soundexists(var_4.func_10241.func_6D32))
    self playSound(var_4.func_10241.func_6D32);
  else if(isDefined(var_4.func_10241.func_6D34) && soundexists(var_4.func_10241.func_6D34)) {
    self notify("new_loop_sound");
    self endon("new_loop_sound");

    if(!isDefined(self.func_B04A)) {
      self.func_B04A = spawn("script_origin", self gettagorigin("TAG_FLASH"));
      self.func_B04A.angles = self gettagangles("TAG_FLASH");
      self.func_B04A linkto(self);
      self.func_B04A playLoopSound(self.func_10241.func_6D34);
    }

    wait 0.5;

    if(!isDefined(self) || !isalive(self)) {
      return;
    }
    if(isDefined(self) && isDefined(self.func_B04A))
      self.func_B04A stoploopsound(self.func_10241.func_6D34);

    self stoploopsound(self.func_10241.func_6D34);
    self playSound(self.func_10241.func_6D36);
    self.func_B04A delete();
  }
}

func_39A3(var_00) {
  if(!isDefined(self.func_B797))
    func_0BA9::func_9799();

  if(var_00) {
    if(isDefined(self.func_8B47) && self.func_8B47)
      return;
    else
      thread func_39A5();
  } else
    func_39A4();
}

func_39A5() {
  self.func_8B47 = 1;
  self.shooting_missile_barrage = 0;
  self endon("stop_hardpoint_multiattack");
  self endon("death");
  self endon("predeath");
  var_00 = 0;

  for(;;) {
    if(!scripts\sp\utility::func_D123()) {
      wait 1;
      continue;
    }

    var_01 = distance(self.origin, level.func_D127.origin);
    var_02 = anglestoright(self.angles);
    var_03 = anglestoup(self.angles);
    var_04 = vectornormalize(level.func_D127.origin - self.origin);
    var_05 = vectordot(var_02, var_04);
    var_06 = vectordot(var_03, var_04);

    if(!func_39A2(var_01, var_05, var_06))
      func_399F(var_01, var_05, var_06);

    wait 0.05;
  }
}

func_39A2(var_00, var_01, var_02) {
  self endon("death");
  self endon("predeath");

  if(!func_0BA9::func_396A(level.func_D127))
    return 0;

  if(var_01 < 0)
    var_03 = self.func_8B50["cap_hardpoint_missile_barrage"];
  else
    var_03 = self.func_8B51["cap_hardpoint_missile_barrage"];

  if(!isDefined(var_03))
    return 0;

  if(var_3.size == 0) {
    wait 0.1;
    return 0;
  }

  func_39A1(var_03, 5);

  while(level.func_D127.func_93D2.size > 0)
    wait 0.05;

  self.func_A8EA = gettime();
  self.func_B83F = randomfloatrange(1500, 4500);
  wait(randomfloatrange(0.5, 2.5));
  return 1;
}

func_39A1(var_00, var_01) {
  func_39A0(level.func_D127, var_00, var_01);
}

func_39A0(var_00, var_01, var_02) {
  self endon("death");
  self endon("predeath");
  var_03 = 0;
  var_01 = scripts\engine\utility::array_randomize(var_01);
  self.shooting_missile_barrage = 1;

  foreach(var_05 in var_01) {
    if(var_03 >= var_02) {
      break;
    }
    if(isDefined(var_05)) {
      var_05 thread func_0B76::func_1945(var_00, ["tag_flash_1"], 1);
      wait 0.2;
      var_3++;
    }
  }

  self.shooting_missile_barrage = 0;
}

func_399F(var_00, var_01, var_02) {
  self endon("death");
  self endon("predeath");

  if(var_00 > 30000)
    return 0;

  if(abs(var_01) < 0.05)
    return 0;

  if(var_02 < -0.29)
    return 0;

  if(var_01 < 0)
    var_03 = self.func_8B50["cap_hardpoint_missile_barrage"];
  else
    var_03 = self.func_8B51["cap_hardpoint_missile_barrage"];

  var_04 = scripts\engine\utility::array_reverse(var_03);
  var_03 = scripts\engine\utility::array_combine(var_03, var_04);

  foreach(var_06 in var_03) {
    if(isDefined(var_06)) {
      var_06 thread func_399E("tag_flash_1", 1, self.func_9278);
      wait 0.1;
    }
  }

  if(isDefined(self.func_9278) && self.func_9278)
    wait(randomfloatrange(0.3, 0.75));
  else
    func_13695(randomfloatrange(1, 3.0));

  return 1;
}

func_13695(var_00) {
  self endon("start_agro_attack");
  wait(var_00);
}

func_399E(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_03))
    var_03 = 1;

  if(isDefined(var_02) && var_02)
    var_04 = scripts\sp\math::func_C097(level.func_A48E.func_3A04, level.func_A48E.func_3A03, level.func_A056.func_67D9);
  else
    var_04 = scripts\sp\math::func_C097(level.func_A48E.func_3A06, level.func_A48E.func_3A05, level.func_A056.func_67D9);

  var_05 = self.origin - level.func_D127.origin;
  var_06 = length(var_05);
  var_07 = var_06 * 0.3;
  var_08 = var_06 * 0.5;

  if(var_07 > 2000)
    var_07 = 2000;

  if(var_08 > 5000)
    var_08 = 5000;

  var_09 = scripts\sp\math::func_6A8E(350, 900, var_04);
  var_07 = scripts\sp\math::func_6A8E(800, var_07, var_04);
  var_08 = scripts\sp\math::func_6A8E(1500, var_08, var_04);
  var_10 = vectortoangles(var_05);
  var_11 = vectornormalize(var_05);
  var_12 = -1 * var_05;
  var_13 = randomfloatrange(var_07, var_08);
  var_14 = var_11 * var_13 * var_01;
  var_15 = anglestoright(var_10) * randomfloatrange(-1 * var_09, var_09) * var_01;
  var_16 = anglestoup(var_10) * randomfloatrange(-1 * var_09, var_09) * var_01;
  var_17 = self.origin;
  var_18 = scripts\sp\math::func_C097(4000, 30000, var_06);
  var_19 = scripts\sp\math::func_6A8E(7, 20, var_18);
  var_20 = level.func_D127.spaceship_vel * var_19;
  var_21 = level.func_D127.origin + var_14 + var_15 + var_16 + var_20;
  playFXOnTag(scripts\engine\utility::getfx("miniflak_muzzle"), self, var_00);
  var_22 = vectornormalize(var_21 - self.origin);
  var_23 = scripts\engine\utility::spawn_tag_origin();

  if(var_03)
    self playSound("weap_capital_ship_flak_fire_plr");

  var_23.angles = vectortoangles(var_22);
  playFXOnTag(scripts\engine\utility::getfx("miniflak_trace"), var_23, "tag_origin");
  var_24 = scripts\sp\math::func_C097(1000, 35000, var_06);
  var_24 = scripts\sp\math::func_6A8E(0.1, 0.75, var_24);
  var_23 moveto(var_21, var_24);
  wait(var_24);
  wait 0.05;
  var_23 thread func_11A7D();
  playFX(scripts\engine\utility::getfx("miniflak"), var_21, var_22, (0, 0, 1));
  thread scripts\engine\utility::play_sound_in_space("miniflak_airburst_plr", var_21);

  if(isDefined(self))
    var_25 = self;
  else
    var_25 = undefined;

  var_06 = distance(var_21, level.func_D127.origin);
  var_26 = scripts\sp\math::func_C097(500, 8000, var_06);
  var_27 = scripts\sp\math::func_6A8E(0.2, 0, var_26);

  if(var_27 > 0.01)
    earthquake(var_27, 0.5, level.func_D127.origin, 20000);

  var_26 = scripts\sp\math::func_C097(200, 2000, var_06);
  var_28 = scripts\sp\math::func_6A8E(100, 0, var_26);

  if(var_28 <= 0) {
    return;
  }
  if(isDefined(self))
    var_17 = self.origin;

  level.func_D127 getrandomarmkillstreak(var_28, var_17, var_25, var_25, "MOD_EXPLOSIVE_BULLET", "spaceship_scripted_miniflak");
}

func_11A7D() {
  wait 0.05;
  self delete();
}

func_39A4() {
  self.func_8B47 = 0;
  self notify("stop_hardpoint_multiattack");
}

func_398A(var_00) {
  if(var_00)
    thread scripts\sp\utility::func_75C4("flak_omni_space", "TAG_ORIGIN");
  else
    thread scripts\sp\utility::func_75F8("flak_omni_space", "TAG_ORIGIN");
}

func_3966(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(!isDefined(self) || !isDefined(var_02)) {
    return;
  }
  var_08 = [var_02];

  if(isDefined(var_03))
    var_08 = scripts\engine\utility::array_add(var_08, var_03);

  if(isDefined(var_04))
    var_08 = scripts\engine\utility::array_add(var_08, var_04);

  if(isDefined(var_05))
    var_08 = scripts\engine\utility::array_add(var_08, var_05);

  if(isDefined(var_06))
    var_08 = scripts\engine\utility::array_add(var_08, var_06);

  self notify("end_capitalship_ambient_targets");
  self endon("end_capitalship_ambient_targets");
  self endon("end_capitalship_attacking");

  if(var_00 == 1) {
    var_09 = 0;

    foreach(var_11 in self.turrets) {
      foreach(var_13 in var_11) {
        var_14 = var_8[var_09];

        if(!isDefined(var_13)) {
          continue;
        }
        var_13.func_1DF8 = var_14;
        var_13.func_1D65 = 1;
        var_13.func_AF58 = self.func_12A09;
        var_15 = 0;

        if(scripts\engine\utility::cointoss())
          var_15 = randomfloatrange(0, 2.5);

        var_13 scripts\engine\utility::delaythread(var_15, ::func_39ED, var_14, !self.func_12A09);
        wait 0.05;
      }

      var_9++;

      if(var_09 == var_8.size)
        var_09 = 0;
    }
  }

  if(var_01 == 1) {
    self.func_1DF8 = scripts\engine\utility::random(var_08);

    if(isDefined(self.func_8B4F["cap_hardpoint_missile_barrage"]))
      thread func_39B8("cap_hardpoint_missile_barrage", undefined, undefined);
    else {
      foreach(var_19 in self.func_8B4F) {
        wait(randomfloatrange(0, 5));
        thread func_399D(var_19, var_08);
      }
    }
  }
}

func_3967() {
  self notify("end_capitalship_ambient_targets");
  self notify("end_capitalship_attacking");
  self notify("stop_shooting_missiles");
  self notify("stop_shooting");
  self.func_1DF8 = undefined;

  foreach(var_01 in self.turrets) {
    foreach(var_03 in var_01) {
      if(!isDefined(var_03)) {
        continue;
      }
      var_3.func_1DF8 = undefined;

      if(var_3.classname == "misc_turret")
        var_03 thread func_39EC();
    }
  }
}

func_39E5(var_00, var_01, var_02) {
  self endon("end_capitalship_ambient_targets");
  self endon("end_capitalship_attacking");
  self endon(var_00 + "_stop_attacking");

  if(!isDefined(self.func_129F5) || !isDefined(self.func_129F5[var_00])) {
    return;
  }
  var_03 = (0, 0, 0);

  if(var_00 == "front_left")
    var_03 = (1, 0, 0);
  else if(var_00 == "front_right")
    var_03 = (0, 1, 0);
  else if(var_00 == "back_left")
    var_03 = (0, 1, 1);
  else if(var_00 == "back_right")
    var_03 = (1, 1, 0);

  var_04 = [var_01];

  if(isDefined(var_02))
    var_4[var_4.size] = var_02;

  var_05 = self.func_129F5[var_00];
  var_06 = 0;

  foreach(var_08 in self.turrets) {
    foreach(var_10 in var_08) {
      if(!isDefined(var_10)) {
        continue;
      }
      if(!scripts\engine\utility::array_contains(var_05, var_10.func_AD42)) {
        continue;
      }
      var_10.func_1D65 = 1;
      var_10.func_1DF8 = scripts\engine\utility::random(var_04);
      var_10.func_AF58 = self.func_12A09;
      var_11 = 0;

      if(scripts\engine\utility::cointoss())
        var_11 = randomfloatrange(0, 2.5);

      var_10 scripts\engine\utility::delaythread(var_11, ::func_39ED, var_10.func_1DF8, !self.func_12A09);
      wait 0.05;
    }
  }
}

func_399C(var_00, var_01) {
  if(isDefined(self.func_8B4F["cap_hardpoint_missile_barrage"]))
    thread func_39B8("cap_hardpoint_missile_barrage", undefined, undefined, var_01, var_00);
  else {}
}

func_399D(var_00, var_01, var_02) {
  self notify("stop_shooting_missiles");
  self endon("stop_shooting_missiles");
  self endon("death");
  self endon("entitydeleted");
  var_03 = var_0[0].class;
  var_04 = level.func_39DD[var_03].func_10241;

  if(isDefined(self.func_10245) && isDefined(self.func_10245[var_03]))
    var_04 = self.func_10245[var_03];

  if(!isDefined(var_4.func_6CF8)) {
    return;
  }
  for(;;) {
    var_01 = scripts\engine\utility::array_removeundefined(var_01);

    if(var_1.size == 0) {
      return;
    }
    self[[var_4.func_6CF8]](var_01, var_00, var_04, undefined, undefined, 1, 0);
    wait 0.05;

    if(isDefined(var_02) && var_02)
      return;
  }
}

func_6D0E(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  self endon("death");
  var_07 = scripts\engine\utility::random(var_00);

  if(!isDefined(var_07)) {
    return;
  }
  var_08 = func_0B76::func_A26D(0.15, 0.3, 150, 0.15, 0.3, 150);
  var_09 = 300;
  var_10 = 400;
  var_11 = 500;
  var_12 = 1.5;
  var_13 = (0, 0, 0);
  var_14 = 0;

  foreach(var_16 in var_01) {
    if(!isDefined(self)) {
      return;
    }
    if(!isDefined(var_07)) {
      return;
    }
    var_17 = self gettagangles(var_16.tag);
    var_17 = invertangles(var_17);
    var_18 = scripts\engine\utility::spawn_tag_origin();
    var_18.origin = self gettagorigin(var_16.tag);
    var_18.angles = var_17;
    var_19 = (0, 0, 0);

    if(isDefined(var_7.func_24C4)) {
      var_20 = scripts\engine\utility::random(var_7.func_24C4);
      var_21 = var_07 gettagorigin(var_20);
      var_19 = var_7.origin - var_21;
    }

    var_22 = 0;

    if(isDefined(var_05) && !var_05)
      var_22 = 1;

    var_23 = 0;

    if(isDefined(var_06) && !var_06)
      var_23 = 1;

    if(isDefined(level.func_39B6) && !level.func_39B6)
      var_23 = 1;

    if(var_14 == 0)
      self playSound("capitalship_missile_salvo_mixed");

    var_24 = var_09;
    var_25 = var_10;
    var_26 = var_11;

    if(isDefined(self.func_B824))
      var_24 = self.func_B824;

    if(isDefined(self.func_B825))
      var_25 = self.func_B825;

    if(isDefined(self.func_B823))
      var_26 = self.func_B823;

    if(isDefined(self.func_B822))
      var_12 = self.func_B822;

    if(isDefined(self.func_12FB8) && self.func_12FB8)
      var_18.func_C180 = 1;

    var_18.func_AA99 = "capitalship_missile_launch";
    var_18.func_69E9 = "capitalship_missile_impact";
    var_18.func_BFEC = var_23;
    var_18 thread func_0B76::func_A332(var_07, 0, self, var_03, var_25, var_13, 0, var_04, var_24, 1, var_12, var_22, var_19, var_08, var_26);
    var_14 = var_14 + 1;

    if(var_14 >= var_2.func_B46E) {
      break;
    }
    wait(var_2.func_6D20);
  }

  wait(randomfloatrange(var_2.func_13535[0], var_2.func_13535[1]));
}

func_6D0C(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(1) {
    self endon("death");
    var_07 = scripts\engine\utility::random(var_00);

    if(!isDefined(var_07)) {
      return;
    }
    var_08 = (0, 0, 0);
    var_09 = func_0B76::func_A26D(0.1, 0.15, 75, 0.2, 0.3, 75);
    var_10 = 400;
    var_11 = 1.5;
    var_12 = 0;

    foreach(var_14 in var_01) {
      if(!isDefined(self)) {
        return;
      }
      if(!isDefined(var_07)) {
        return;
      }
      var_00 = func_0BA9::func_DFE9(var_00);

      if(var_0.size == 0) {
        return;
      }
      if(!isDefined(var_14)) {
        wait(var_2.func_6D20);
        continue;
      }

      var_07 = scripts\engine\utility::random(var_00);

      if(isDefined(var_7.func_24C4)) {
        var_15 = scripts\engine\utility::random(var_7.func_24C4);
        var_16 = var_07 gettagorigin(var_15);
        var_08 = var_7.origin - var_16;
      }

      var_17 = self gettagangles(var_14.tag);
      var_17 = invertangles(var_17);
      var_18 = scripts\engine\utility::spawn_tag_origin();
      var_18.origin = self gettagorigin(var_14.tag);
      var_18.angles = var_17;

      if(isDefined(self.func_B80E))
        var_18.origin = var_18.origin + self.func_B80E;

      var_19 = 0;

      if(isDefined(var_05) && !var_05)
        var_19 = 1;

      var_20 = 0;

      if(isDefined(var_06) && !var_06)
        var_20 = 1;

      if(isDefined(level.func_39B6) && !level.func_39B6)
        var_20 = 1;

      if(isDefined(self.func_12FB8) && self.func_12FB8)
        var_18.func_C180 = 1;

      var_18.func_AA99 = "capitalship_missile_launch";
      var_18.func_69E9 = "capitalship_missile_impact";
      var_18.func_BFEC = var_20;
      var_18 thread func_0B76::func_A332(var_07, 1, self, var_03, var_10, undefined, 0, var_04, 500, 1, var_11, var_19, var_08, var_09, 500);
      var_12 = var_12 + 1;

      if(var_12 >= var_2.func_B46E) {
        break;
      }
      if(var_12 % 4 == 0)
        wait 0.85;

      wait(var_2.func_6D20);
    }
  }

  wait(randomfloatrange(var_2.func_13535[0], var_2.func_13535[1]));
}

func_39B6() {
  self endon("death");
  self waittill("missile_explode");

  if(isDefined(level.func_39B6) && !level.func_39B6) {
    return;
  }
  earthquake(0.25, 1, self.origin, 5000);
}

func_39F0(var_00, var_01, var_02, var_03) {
  if(isDefined(self.turrets["cap_turret_missile_barrage"])) {
    self.turrets["cap_turret_missile_barrage"] = scripts\engine\utility::array_removeundefined(self.turrets["cap_turret_missile_barrage"]);

    if(self.turrets["cap_turret_missile_barrage"].size > 0)
      thread func_39B7("cap_turret_missile_barrage", var_02, var_03);
  }

  if(isDefined(self.func_8B4F["cap_hardpoint_missile_barrage"])) {
    self.func_8B4F["cap_hardpoint_missile_barrage"] = scripts\engine\utility::array_removeundefined(self.func_8B4F["cap_hardpoint_missile_barrage"]);

    if(self.func_8B4F["cap_hardpoint_missile_barrage"].size > 0)
      thread func_39B8("cap_hardpoint_missile_barrage", var_02, var_03);
  }

  foreach(var_05 in self.turrets) {
    var_05 = scripts\engine\utility::array_removeundefined(var_05);

    if(var_5.size <= 0) {
      continue;
    }
    if(var_5[0].type == "cap_turret_missile_barrage") {
      continue;
    }
    foreach(var_07 in var_05) {
      if(!isDefined(var_07)) {
        continue;
      }
      var_7.func_AF58 = 0;

      if(var_5[0].type == "cap_turret_large")
        var_07 thread func_39E3(1);
      else if(var_5[0].type == "cap_turret_small_constant")
        var_07 thread func_39E3(var_00, 1);
      else
        var_07 thread func_39E3(var_00);

      if(var_5[0].type == "cap_turret_small_constant") {
        if(!isDefined(self.func_5099)) {
          self.func_5099 = spawnStruct();
          self.func_5099.turrets = 0;
          self.func_5099.func_B738 = 0;
          self.func_5099.func_B417 = 1;
        }

        self.func_5099.turrets++;
      }
    }
  }

  if(isDefined(var_01) && isDefined(level.func_12A71) && level.func_12A71)
    func_8933(var_01);
}

func_39F1() {
  self notify("stop_shooting_missiles");

  foreach(var_01 in self.turrets) {
    foreach(var_03 in var_01) {
      if(!isDefined(var_03)) {
        continue;
      }
      if(var_3.type == "cap_turret_missile_barrage") {
        continue;
      }
      var_03 notify("stop_shooting");
    }
  }
}

func_39DF() {
  wait 1;

  if(level.func_12A91 != 0)
    level.func_3965 thread func_39DE();
}

func_39DE() {
  scripts\engine\utility::flag_wait("capital_ship_spawned");
  scripts\engine\utility::waitframe();

  foreach(var_01 in self.turrets) {
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        if(isDefined(var_03))
          var_03 delete();
      }
    }
  }

  func_409E();
}

func_39B5(var_00, var_01, var_02) {
  while(!isDefined(self.func_5099))
    scripts\engine\utility::waitframe();

  if(!isDefined(var_01))
    self.func_5099.func_B738 = 1000;

  if(!isDefined(var_02))
    self.func_5099.func_B417 = 5000;

  if(!isDefined(var_00))
    var_00 = 1;

  for(;;) {
    if(self.func_5099.turrets < var_00) {
      self.func_5099.func_B738 = 0;
      self.func_5099.func_B417 = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

func_12A37(var_00, var_01) {
  var_02 = self gettagorigin(var_00);

  if(!isDefined(var_01))
    var_01 = func_12A36(var_00);

  if(isDefined(self.func_4D1E) && isDefined(self.func_4D1E.fx.func_BE00)) {
    var_03 = anglestoright(var_01);
    var_04 = var_02 - self.origin;

    if(vectordot(var_04, var_03) > 0)
      var_05 = 1;
    else
      var_05 = -1;

    var_06 = var_03 * (self.func_4D1E.fx.func_BE00 * var_05);
    var_02 = var_02 + var_06;
  }

  return var_02;
}

func_12A36(var_00) {
  return self gettagangles(var_00);
}

func_12A32(var_00) {
  foreach(var_02 in var_00) {
    var_03 = func_12A36(var_02);
    var_04 = func_12A37(var_02, var_03);
    var_05 = scripts\engine\trace::ray_trace(var_04, var_04 + anglesToForward(var_03) * 7000, undefined, 1);

    if(isDefined(var_5["entity"]) && isDefined(var_5["entity"].script_team) && var_5["entity"].script_team == self.script_team)
      return 1;
  }

  return 0;
}

func_12A02(var_00) {
  if(!isDefined(self.classname) || self.classname != "misc_turret") {
    return;
  }
  self endon("death");
  self notify("turret_hold_still");
  self endon("turret_hold_still");
  self _meth_8535(1);
  wait(var_00);
  self _meth_8535(0);
}

func_39E3(var_00, var_01) {
  self notify("stop_shooting");
  self endon("stop_shooting");
  self endon("death");
  self endon("entitydeleted");
  self.team = self.script_team;
  var_02 = func_39DC(self.model);
  var_03 = 0;
  var_04 = 0;
  var_05 = undefined;

  if(isDefined(self.func_10241))
    var_05 = self.func_10241;
  else if(isDefined(level.func_39DD[self.class].func_10241))
    var_05 = level.func_39DD[self.class].func_10241;

  if(isDefined(self.func_4D1E) && isDefined(self.func_4D1E.func_DCCA))
    var_06 = self.func_4D1E.func_DCCA;
  else
    var_06 = 5000;

  thread func_88ED();
  wait(randomfloat(2));

  for(;;) {
    if(self.func_C841 scripts\sp\utility::func_65DF("player_inside_ship") && self.func_C841 scripts\sp\utility::func_65DB("player_inside_ship")) {
      wait 1;
      continue;
    }

    if(isDefined(var_05) && isDefined(self.func_1D65) && self.func_1D65 == 1)
      var_07 = var_5.func_1DFC;
    else
      var_07 = 100;

    if(isDefined(var_05) && randomfloat(1) < var_07) {
      if(var_5.func_13536[0] == var_5.func_13536[1])
        var_03 = var_5.func_13536[0];
      else
        var_03 = randomfloatrange(var_5.func_13536[0], var_5.func_13536[1]);
    } else
      var_03 = 1;

    var_08 = 1;

    if(isDefined(var_01)) {
      foreach(var_10 in var_02)
      playFXOnTag(scripts\engine\utility::getfx(self.func_4D1E.fx.func_BDFF), self, var_10);
    }

    while(var_03 > 0) {
      if(func_12A3B(var_06, self.func_114FB) || scripts\engine\utility::is_true(self.func_C841.func_1D62) || isDefined(self.func_102A6)) {
        self.func_114FB = self;
        func_B2CA(var_06, 1);
      }

      if(isDefined(var_00) && var_00) {
        if(!isDefined(self.func_114FB) || self.func_114FB == self) {
          scripts\engine\utility::waitframe();
          continue;
        }

        var_12 = scripts\engine\utility::waittill_notify_or_timeout_return("turret_on_target", 2);

        if(isDefined(var_12) && var_12 == "timeout") {
          scripts\engine\utility::waitframe();
          continue;
        }
      }

      if(scripts\sp\utility::func_D123() && self.func_114FB == level.func_D127) {
        if(isDefined(self.func_10241.func_6D35)) {
          if(!isDefined(self.func_B04A)) {
            self.func_B04A = spawn("script_origin", self.origin);
            self.func_B04A linkto(self, "tag_flash", (0, 0, 0), (0, 0, 0));
          }

          if(!isDefined(self.func_B04C)) {
            self.func_B04C = 1;
            self.func_B04A playLoopSound(self.func_10241.func_6D35);
          }
        } else if(isDefined(self.func_10241.func_6D33))
          thread scripts\engine\utility::play_sound_in_space(self.func_10241.func_6D33, self.origin);
      }

      foreach(var_10 in var_02) {
        if(!func_12A32([var_10])) {
          if(!scripts\engine\utility::is_true(self.func_AF58) && !isDefined(self.func_C841.func_12FBA)) {
            if(isDefined(var_5.func_10943))
              self[[var_5.func_10943]](var_10);
            else
              self shootturret(var_10);

            continue;
          }

          var_14 = func_12A36(var_10);
          var_15 = self gettagangles(var_10);
          var_15 = vectornormalize(anglesToForward(var_15));
          var_16 = func_12A37(var_10, var_14) + var_15 * 75;
          self thread[[var_5.func_AF57]](var_16, var_14, var_10);
        }
      }

      if(!isDefined(var_01))
        thread func_12A02(0.33);

      if(isDefined(var_05)) {
        wait(var_5.func_6D20);
        var_03 = var_03 - var_5.func_6D20;
      } else {
        wait 1;
        var_03 = var_03 - 1;
      }

      if(isDefined(self.func_1D52) && var_08 == self.func_1D52) {
        var_08 = 1;
        continue;
      }

      var_8++;
    }

    if(isDefined(var_01)) {
      foreach(var_10 in var_02)
      stopFXOnTag(scripts\engine\utility::getfx(self.func_4D1E.fx.func_BDFF), self, var_10);
    }

    if(isDefined(self.func_B04C)) {
      if(isDefined(self) && isDefined(self.func_B04A)) {
        self.func_B04A stoploopsound(self.func_10241.func_6D35);
        self.func_B04A playSound(self.func_10241.func_6D37);
        self.func_B04C = undefined;
      }
    }

    if(isDefined(var_05))
      var_04 = randomfloatrange(var_5.func_13535[0], var_5.func_13535[1]);
    else
      var_04 = 0.5;

    wait(var_04);
  }
}

func_12A3E(var_00) {
  if(isDefined(self.func_AD42) && isDefined(self.func_C841) && isDefined(self.class_progression_init)) {
    if(self.func_2103 == 0 && self.func_2107 == 0 && self.func_2109 == 0 && self.func_2100 == 0)
      return 1;

    var_01 = self.func_C841 gettagangles(self.func_AD42);
    var_02 = self.func_C841 gettagorigin(self.func_AD42);
    var_03 = var_0.origin - var_02;
    var_04 = rotatevectorinverted(var_03, var_01);
    var_05 = vectornormalize((var_4[0], var_4[1], 0));
    var_06 = vectordot(var_05, (1, 0, 0));

    if(var_5[1] >= 0 && var_06 < self.func_2104)
      return 0;

    if(var_5[1] <= 0 && var_06 < self.func_2108)
      return 0;

    var_07 = vectortoangles(var_04);
    var_08 = vectornormalize(rotatevector(var_04, (0, var_7[1] * -1.0, 0)));
    var_09 = vectordot(var_08, (1, 0, 0));

    if(var_8[2] <= 0 && var_09 < self.func_2101)
      return 0;

    if(var_8[2] >= 0 && var_09 < self.func_210A)
      return 0;
  }

  return 1;
}

func_12A3B(var_00, var_01) {
  if(!isDefined(var_01))
    return 1;

  var_02 = distancesquared(var_1.origin, self.origin);

  if(var_02 > squared(var_00) || self == var_01)
    return 1;

  if(!func_12A3E(var_01))
    return 1;

  return 0;
}

func_B2CA(var_00, var_01) {
  var_02 = squared(var_00);
  var_03 = var_02;

  if(isDefined(self) && isDefined(self.func_12A01) && self.func_12A01.size > 0) {
    foreach(var_05 in self.func_12A01) {
      if(isDefined(var_05) && isDefined(var_5.func_1153C) && var_5.func_1153C == 1 && self _meth_8540(var_5.origin)) {
        self settargetentity(var_05, (0, 0, 0));
        return;
      }
    }

    var_03 = func_B2CB(self.func_12A01, var_03, var_02);
  }

  if(isDefined(self.func_C841) && isDefined(self.func_C841.func_39A9) && self.func_C841.func_39A9.size > 0)
    var_03 = func_B2CB(self.func_C841.func_39A9, var_03, var_02);

  if(isDefined(level.func_39A9) && level.func_39A9.size > 0)
    var_03 = func_B2CB(level.func_39A9, var_03, var_02);

  if(isDefined(level.func_1678) && isDefined(self.type) && self.type == "cap_turret_small_constant") {
    var_03 = func_B2CB(level.func_1678, var_03, var_02);

    if(isDefined(self.func_114FB) && self.func_114FB != self && self _meth_8540(self.func_114FB.origin)) {
      if(isDefined(var_01) && self.classname == "misc_turret") {
        self settargetentity(self.func_114FB, (0, 0, 0));
        return;
      }
    }
  }

  if(isDefined(level.func_D127)) {
    if(!isDefined(level.func_C0B7) || isDefined(level.func_C0B7) && level.func_C0B7 == 0) {
      if(isDefined(self.func_C841) && isDefined(self.func_C841.func_11578) && self.func_C841.func_11578) {
        if(isDefined(var_01) && self.classname == "misc_turret" && (!isDefined(self.func_10241.func_102A6) || !self.func_10241.func_102A6)) {
          var_07 = self _meth_8540(level.func_D127.origin);
          var_08 = distancesquared(self.origin, level.func_D127.origin);

          if(var_07 && var_08 < 225000000) {
            self.func_114FB = level.func_D127;
            thread func_12A46(self.func_114FB);
            return;
          } else
            self notify("stop_debug_line_loop");
        }
      }
    }
  }

  var_09 = level.func_A056.func_1630;

  if(isDefined(var_09) && var_03 > 0) {
    var_03 = squared(sqrt(var_03) + 5000);
    var_03 = func_B2CB(var_09, var_03, var_02);
  }

  if(isDefined(var_01) && self.classname == "misc_turret") {
    if(self.func_114FB == self || scripts\engine\utility::is_true(self.func_10241.func_102A6) || !self _meth_8540(self.func_114FB.origin))
      func_11547();
    else
      self settargetentity(self.func_114FB, (0, 0, 0));
  }
}

func_12A46(var_00) {
  self notify("track_new_target");
  self endon("track_new_target");
  self endon("death");
  self _meth_82C9(0, "yaw");
  self _meth_82C9(0, "pitch");
  var_01 = (0, 0, 0);

  for(;;) {
    var_02 = (0, 0, 0);

    if(isDefined(self.func_C841))
      var_02 = self.func_C841 vehicle_getvelocity();

    var_03 = (0, 0, 0);

    if(isDefined(level.func_D127) && var_00 == level.func_D127 && scripts\sp\utility::func_D123())
      var_03 = level.func_D127 getentityvelocity();

    if(isDefined(level.func_4BA1))
      var_03 = var_03 + (level.func_4BA1 * 15, 0, 0);

    var_04 = self gettagorigin("tag_flash");
    var_05 = _projectileintercept(var_04, var_02, 20000, var_0.origin, var_03);

    if(isDefined(var_05))
      var_06 = var_05 - var_0.origin;
    else
      var_06 = var_01;

    self settargetentity(var_00, var_06);
    var_07 = anglesToForward(self gettagangles("tag_aim"));
    var_01 = var_06;
    wait 0.05;
  }
}

func_11547() {
  if(isDefined(self.func_C841.func_102A9) && !isDefined(self.func_102A8)) {
    var_00 = 0;

    while(var_00 < 10) {
      var_01 = scripts\engine\utility::random(self.func_C841.func_102A9);

      if(self _meth_8540(var_1.origin)) {
        self.func_114FB = var_01;
        self.func_102A8 = var_01;
        self settargetentity(self.func_114FB, (0, 0, 0));
        thread func_4180();
        break;
      } else
        var_00 = var_00 + 1;

      wait 0.05;
    }
  }
}

func_4180() {
  wait(randomfloatrange(0.5, 1.5));
  self.func_102A8 = undefined;
}

func_F5C0(var_00, var_01) {
  var_02 = var_00 getentitynumber();

  if(var_01 > 0) {
    var_0.func_1153C = var_01;

    if(!isDefined(self.func_39A9))
      self.func_39A9 = [];

    self.func_39A9[var_02] = var_00;
  } else {
    var_0.func_1153C = undefined;

    if(isDefined(self.func_39A9))
      self.func_39A9[var_02] = undefined;
  }

  if(isDefined(self.func_39A9) && self.func_39A9.size == 0)
    self.func_39A9 = undefined;
}

func_F5C1(var_00, var_01) {
  var_02 = var_00 getentitynumber();

  if(var_01 > 0) {
    var_0.func_1153C = var_01;

    if(!isDefined(self.func_12A01))
      self.func_12A01 = [];

    self.func_12A01[var_02] = var_00;
  } else {
    var_0.func_1153C = undefined;

    if(isDefined(self.func_12A01))
      self.func_12A01[var_02] = undefined;
  }

  if(isDefined(self.func_12A01) && self.func_12A01.size == 0)
    self.func_12A01 = undefined;
}

func_445E(var_00, var_01) {
  var_02 = 0;
  var_03 = 0;

  if(isDefined(var_00) && isDefined(var_0.func_1153C))
    var_02 = var_0.func_1153C;

  if(isDefined(var_01) && isDefined(var_1.func_1153C))
    var_03 = var_1.func_1153C;

  return var_02 - var_03;
}

func_B2CB(var_00, var_01, var_02) {
  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(var_02))
    var_02 = var_01;

  foreach(var_04 in var_00) {
    if(!isDefined(var_00)) {
      return;
    }
    if(!isDefined(var_04)) {
      continue;
    }
    if(!isDefined(var_4.team))
      var_4.team = "allies";

    if(var_4.team != self.team && !scripts\engine\utility::is_true(var_4.func_12A88)) {
      var_05 = distancesquared(var_4.origin, self.origin);
      var_06 = func_445E(var_04, self.func_114FB);

      if(var_06 > 0 && var_05 < var_02 && func_12A3E(var_04)) {
        self.func_114FB = var_04;
        var_01 = var_05;
      }

      if(var_06 <= 0 && var_05 < var_01) {
        if(!func_12A3E(var_04)) {
          continue;
        }
        var_01 = var_05;
        self.func_114FB = var_04;
      }
    }
  }

  return var_01;
}

func_6D4F(var_00, var_01, var_02, var_03) {
  var_04 = self.func_4D1E.func_10AA2;
  var_05 = self.func_4D1E.fx.func_11A7B;
  var_06 = randomfloatrange(-1 * var_04, var_04);
  var_07 = randomfloatrange(-1 * var_04, var_04);
  var_08 = randomfloatrange(-1 * var_04, var_04);
  var_09 = var_00 + self.func_4D1E.func_DCCA * anglesToForward(var_01);
  var_10 = var_00 + (self.func_4D1E.func_DCCA * anglesToForward(var_01) + (var_06, var_07, var_08));
  var_11 = vectortoangles(vectornormalize(var_09 - var_00));
  var_12 = vectortoangles(vectornormalize(var_10 - var_00));
  func_129CA(var_00, var_09, var_11, 1500, undefined, var_02, undefined, "capital_ship_turret_fire", var_03);
}

func_6D4E(var_00, var_01, var_02, var_03) {
  var_04 = self.func_4D1E.fx.func_A865;
  var_05 = self.func_4D1E.fx.func_6D02;
  var_06 = self.func_4D1E.fx.func_11A7B;
  var_07 = var_00 + self.func_4D1E.func_DCCA * anglesToForward(var_01);
  var_08 = vectortoangles(vectornormalize(var_07 - var_00));
  func_129CA(var_00, var_07, var_08, 1500, self.func_4D1E.fx.func_BDFF, var_02, undefined, "capital_ship_turret_fire");
}

func_6D4C(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_04))
    var_04 = 500;

  if(isDefined(self.func_114FB) && self != self.func_114FB)
    self.func_4D1E.func_32BA = distance(self.origin, self.func_114FB.origin);
  else
    self.func_4D1E.func_32BA = 10000;

  if(isDefined(self.func_114FB.func_5099) && isDefined(self.func_114FB.func_5099.func_B738) && isDefined(self.func_114FB.func_5099.func_B417))
    self.func_4D1E.func_32BA = self.func_4D1E.func_32BA - randomfloatrange(self.func_114FB.func_5099.func_B738, self.func_114FB.func_5099.func_B417);

  if(self.func_114FB == level.player)
    var_06 = 1;
  else
    var_06 = 0;

  var_07 = (randomfloatrange(-1 * var_04, var_04), randomfloatrange(-1 * var_04, var_04), randomfloatrange(-1 * var_04, var_04));
  var_08 = var_00 + 10000 * anglesToForward(var_01) + var_07;
  var_09 = vectortoangles(var_08 - var_00);

  if(isDefined(var_05)) {
    var_10 = bulletTrace(var_00, var_08, 1);

    if(length(var_10["position"] - var_00) < var_05)
      return;
  }

  var_11 = self.func_4D1E.fx.func_11A7B;
  thread func_129CB(var_00, var_08, var_09, 730, self.func_4D1E.fx.func_BDFF, var_02, var_06, undefined, "capital_ship_turret_fire", "flak_explo_space", self.func_4D1E.fx.func_69DA);
}

func_129CA(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(isDefined(var_07))
    thread func_D528(var_07, var_00);

  if(!isDefined(var_08))
    var_08 = 1;

  if(isDefined(var_04)) {
    var_10 = anglesToForward(var_02);
    var_11 = anglestoup(var_02);
    playFX(scripts\engine\utility::getfx(var_04), var_00, var_10, var_11);
  }

  if(var_08 == 1)
    func_88BC(var_00, var_01, var_03, self.func_934D, self.func_4D1E, self, var_06, var_09);
}

func_129CB(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  var_12 = self.func_4D1E.func_32B9;
  var_13 = self.func_4D1E.func_32B2;

  if(isDefined(var_08))
    thread func_D528(var_08, var_00);

  var_14 = anglesToForward(var_02);
  var_15 = anglestoup(var_02);
  playFX(scripts\engine\utility::getfx(var_04), var_00, var_14, var_15);
  var_16 = func_88BC(var_00, var_01, var_03, self.func_934D, self.func_4D1E, self, var_07, var_11);

  if(isDefined(var_16))
    thread func_1A8A(var_16, var_02, var_12, var_13, var_09, var_10, var_06);
}

func_1A8A(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(isDefined(self))
    var_07 = self;
  else
    var_07 = undefined;

  if(!isDefined(var_05))
    playFX(scripts\engine\utility::getfx("aa_burst"), var_00, anglesToForward(var_01), anglestoup(var_01));
  else
    playFX(scripts\engine\utility::getfx(var_05), var_00, anglesToForward(var_01), anglestoup(var_01));

  radiusdamage(var_00, var_02, var_03, 0, var_07, "MOD_EXPLOSIVE");
  var_08 = distancesquared(level.player.origin, var_00);

  if(isDefined(var_06) && var_06 == 1 && isDefined(var_04))
    thread func_D528(var_04, var_00);

  if(var_08 < squared(1000))
    level.player playrumbleonentity("grenade_rumble");
  else if(var_08 < squared(3000))
    level.player playrumbleonentity("damage_heavy");
  else if(var_08 < squared(6000))
    level.player playrumbleonentity("damage_light");
  else
    return;

  var_09 = 0.2;
  var_10 = scripts\sp\math::func_C097(400, 10000, sqrt(var_08));
  var_11 = scripts\sp\math::func_6A8E(0.01, var_09, var_10);
  thread func_1A8B(var_11);
}

func_1A8B(var_00) {
  if(!isDefined(level.player.func_4B39))
    level.player.func_4B39 = 0;

  if(var_00 < level.player.func_4B39) {
    return;
  }
  level notify("notify_new_airburst_quake");
  level endon("notify_new_airburst_quake");
  level.player.func_4B39 = var_00;
  earthquake(var_00, 1.2, level.player.origin, 5000);
  wait 0.5;
  level.player.func_4B39 = level.player.func_4B39 * 0.5;
  wait 0.25;
  level.player.func_4B39 = level.player.func_4B39 * 0.5;
  wait 0.25;
  level.player.func_4B39 = level.player.func_4B39 * 0.0;
}

func_88BC(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(!isDefined(var_07))
    var_07 = 0;

  var_08 = var_00;
  var_09 = self.team;
  var_10 = 0;
  var_11 = vectornormalize(var_01 - var_08);

  if(isDefined(var_4.func_32BA)) {
    if(var_4.func_32BA - var_4.func_DCCC < var_4.func_DCCB) {
      var_12 = var_4.func_32BA - var_4.func_DCCB;

      if(var_12 < 0)
        var_12 = 0.01;
    } else
      var_12 = var_4.func_DCCC;

    var_13 = var_4.func_32BA + randomfloatrange(-1 * var_12, var_12);
  } else
    var_13 = var_4.func_DCCA;

  var_14 = undefined;
  var_15 = undefined;
  var_16 = 0;
  var_01 = var_08 + var_11 * var_02;
  var_17 = distancesquared(var_08, var_01);

  for(;;) {
    var_01 = var_08 + var_11 * var_02;

    if(var_07) {}

    var_14 = func_8913(var_08, var_01, var_11, var_09, var_17);

    if(isDefined(var_14)) {
      if(isDefined(level.func_D127) && level.func_D127.spaceship_mode != "hover") {
        var_15 = bulletTrace(var_08, var_01, 1);

        if(isDefined(var_15["entity"])) {
          var_16 = 1;
          break;
        }
      }
    } else {
      var_10 = var_10 + var_02;

      if(var_10 >= var_13)
        return var_01;
    }

    var_08 = var_01;
    wait(level.func_11937);
  }

  thread func_4C7C(var_14, var_15, var_01, var_03, var_06);
  var_18 = scripts\sp\math::func_C097(0, var_13, var_10);
  var_19 = scripts\sp\math::func_6A8E(var_4.func_B428, var_4.func_B73D, var_18);
  var_20 = scripts\sp\math::func_6A8E(var_4.func_B465, var_4.func_B753, var_18);

  if(!isDefined(var_05))
    var_05 = level.player;

  if(var_16)
    var_14 func_54DF(int(var_19), var_01, var_05);
}

func_88ED() {
  self endon("stop_shooting");
  self endon("death");
  self endon("entitydeleted");
  level endon("ship_infil_triggered");
  level.func_9D8F = 0;
  var_00 = 0;
  var_01 = 0;
  var_02 = self.func_45E3;
  var_03 = self.func_45E4;

  for(;;) {
    if(isDefined(level.func_D127) && level.func_D127.spaceship_mode == "hover")
      var_00 = var_00 + 0.05;
    else
      var_00 = var_00 - 0.05;

    if(var_00 >= 0.6)
      level.func_9D8F = 1;
    else
      level.func_9D8F = 0;

    wait 0.05;
  }
}

func_54DF(var_00, var_01, var_02) {
  if(isDefined(self.func_8CBE))
    var_03 = self.func_8CBE;
  else
    var_03 = self;

  var_03 getrandomarmkillstreak(var_00, var_01, var_02, var_02, "MOD_EXPLOSIVE");
}

func_8913(var_00, var_01, var_02, var_03, var_04) {
  var_05 = undefined;

  if(isDefined(level.func_1678))
    var_05 = func_3DA7(level.func_1656, var_00, var_01, var_02, var_03, var_04);

  if(isDefined(var_05))
    return var_05;

  var_6[0] = level.func_D127;
  var_05 = func_3DA7(var_06, var_00, var_01, var_02, var_03, var_04);

  if(isDefined(var_05))
    return var_05;

  if(isDefined(level.func_A056.func_1630)) {
    var_07 = level.func_A056.func_1630;
    var_05 = func_3DA7(var_07, var_00, var_01, var_02, var_03, var_04);
  }

  return var_05;
}

func_3DA7(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_00)) {
    return;
  }
  foreach(var_07 in var_00) {
    if(!isDefined(var_00)) {
      return;
    }
    if(!isDefined(var_07)) {
      continue;
    }
    if(!isDefined(var_7.team))
      var_7.team = "allies";

    if(var_7.team != var_04) {
      var_08 = vectornormalize(var_01 - var_7.origin);
      var_09 = vectordot(var_03, var_08);

      if(var_09 > 0) {
        var_10 = distancesquared(var_7.origin, var_02);

        if(var_10 < 65536.0)
          return var_07;
        else if(var_10 < var_05) {
          if(var_09 > 0.85 || var_09 < -0.85)
            return var_07;
        }
      }
    }
  }

  return;
}

func_4C7C(var_00, var_01, var_02, var_03, var_04) {
  self endon("death");

  if(isDefined(var_00) && isDefined(var_0.func_112DC))
    var_05 = var_0.func_112DC;
  else if(isDefined(var_00) && isDefined(var_0.surfacetype))
    var_05 = var_0.surfacetype;
  else if(isDefined(var_01) && isDefined(var_1["surfacetype"]))
    var_05 = var_1["surfacetype"];
  else
    var_05 = "metal";

  if(!isDefined(var_04))
    var_06 = func_4C45(var_05, var_03);
  else
    var_6[0] = var_04;

  playFX(scripts\engine\utility::getfx(var_6[0]), var_02);

  if(isDefined(var_6[1]))
    thread func_D528(var_6[1], var_02);
}

func_4C45(var_00, var_01) {
  var_02 = "";
  var_03 = "";
  var_04 = 0;

  if(!isDefined(var_00))
    var_00 = "jackal";

  if(!isDefined(var_01))
    var_01 = "turret";

  switch (var_00) {
    case "metal":
      switch (var_01) {
        case "turret":
          var_02 = "jet_gun_imp_metal";
          var_03 = "capitalship_cannon_impact";
          var_04 = 5;
          break;
        case "viper_gun_small":
          var_02 = "jet_gun_imp_metal";
          var_03 = "viper_bullet_player_metal";
          var_04 = 5;
          break;
        case "viper_gun_large":
          var_02 = "jet_gun_imp_large_metal";
          var_03 = "viper_bullet_player_metal";
          var_04 = 5;
          break;
        case "missile":
          var_02 = "capital_missile_imp_capship_gen";
          var_03 = "capitalship_missile_impact";
          var_04 = 5;
          break;
      }

      break;
    case "rock":
      switch (var_01) {
        case "turret":
          var_02 = "jet_gun_imp_rock";
          var_03 = "capitalship_cannon_impact";
          var_04 = 5;
          break;
        case "viper_gun_small":
          var_02 = "jet_gun_imp_rock";
          var_03 = "viper_bullet_player_metal";
          var_04 = 5;
          break;
        case "viper_gun_large":
          var_02 = "jet_gun_imp_large_rock";
          var_03 = "viper_bullet_player_metal";
          var_04 = 5;
          break;
        case "missile":
          var_02 = "jet_missile_imp_generic";
          var_03 = "capitalship_missile_impact";
          var_04 = 5;
          break;
      }

      break;
    case "water":
      switch (var_01) {
        case "turret":
          var_02 = "jet_gun_imp_water";
          var_03 = "turret_bullet_impact_water";
          var_04 = 5;
          break;
        case "viper_gun_small":
          var_02 = "jet_gun_imp_water";
          var_03 = "jet_bullet_impact_water";
          var_04 = 5;
          break;
        case "viper_gun_large":
          var_02 = "jet_gun_imp_water";
          var_03 = "jet_bullet_impact_water";
          var_04 = 5;
          break;
        case "missile":
          var_02 = "jet_missile_imp_water";
          var_03 = "capitalship_missile_impact";
          var_04 = 5;
          break;
      }

      break;
    case "jackal":
      switch (var_01) {
        case "turret":
          var_02 = "fighter_spaceship_damage_med";
          var_03 = "capitalship_cannon_impact";
          var_04 = 5;
          break;
        case "viper_gun_small":
          var_02 = "fighter_spaceship_damage_med";
          var_03 = "viper_bullet_player_metal";
          var_04 = 5;
          break;
        case "viper_gun_large":
          var_02 = "fighter_spaceship_damage_med";
          var_03 = "viper_bullet_player_metal";
          var_04 = 5;
          break;
        case "missile":
          var_02 = "jet_missile_imp_generic";
          var_03 = "capitalship_missile_impact";
          var_04 = 5;
          break;
      }

      break;
    default:
      switch (var_01) {
        case "turret":
          var_02 = "jet_gun_imp_boat_dx";
          var_03 = "capitalship_cannon_impact";
          var_04 = 5;
          break;
        case "viper_gun_small":
          var_02 = "jet_gun_imp_boat_dx";
          var_03 = "viper_bullet_player_metal";
          var_04 = 5;
          break;
        case "viper_gun_large":
          var_02 = "jet_gun_imp_boat_dx";
          var_03 = "viper_bullet_player_metal";
          var_04 = 5;
          break;
        case "missile":
          var_02 = "capital_missile_imp_capship_gen";
          var_03 = "capitalship_missile_impact";
          var_04 = 5;
          break;
      }

      break;
  }

  return [var_02, var_03, var_04];
}

func_D528(var_00, var_01) {
  var_02 = spawn("script_origin", var_01);
  var_02 playSound(var_00, "sounddone");
  var_02 waittill("sounddone");
  var_02 delete();
}

func_39B7(var_00, var_01, var_02) {
  self notify("stop_shooting_missiles");
  self endon("stop_shooting_missiles");
  self endon("death");
  self endon("entitydeleted");
  self.team = self.script_team;
  var_03 = func_39DC(self.turrets[var_00][0].model);
  var_04 = 0;
  var_05 = 0;
  var_06 = undefined;

  if(isDefined(self.turrets[var_00][0].func_10241))
    var_06 = self.turrets[var_00][0].func_10241;
  else if(isDefined(level.func_39DD[self.turrets[var_00][0].class].func_10241))
    var_06 = level.func_39DD[self.turrets[var_00][0].class].func_10241;

  if(isDefined(self.turrets[var_00][0].func_4D1E) && isDefined(self.turrets[var_00][0].func_4D1E.func_DCCA))
    var_07 = self.turrets[var_00][0].func_4D1E.func_DCCA;
  else
    var_07 = 5000;

  wait(randomfloat(2));

  for(;;) {
    if(scripts\sp\utility::func_65DF("player_inside_ship") && scripts\sp\utility::func_65DB("player_inside_ship")) {
      wait 1;
      continue;
    }

    if(isDefined(var_06) && isDefined(self.func_1D65) && self.func_1D65 == 1)
      var_08 = var_6.func_1DFC;
    else
      var_08 = 100;

    if(isDefined(var_06) && randomfloat(1) < var_08)
      var_04 = randomfloatrange(var_6.func_13536[0], var_6.func_13536[1]);
    else
      var_04 = 1;

    var_09 = 0;

    while(var_04 > 0) {
      if(!isDefined(self.turrets[var_00])) {
        return;
      }
      self.turrets[var_00] = func_0BA9::func_DFE9(self.turrets[var_00]);

      if(isDefined(self.turrets[var_00]) && self.turrets[var_00].size == 0) {
        return;
      }
      if(func_12A3B(var_07, self.func_114FB) || scripts\engine\utility::is_true(self.func_1D62))
        func_B2CA(var_07);

      if(!isDefined(self.func_114FB) || self.func_114FB == self) {
        wait 0.1;
        continue;
      }

      if(isDefined(self.func_114FB) && isDefined(level.func_D127) && self.func_114FB == level.func_D127)
        wait 2;

      if(!isDefined(level.missiles)) {
        level.missiles = 0;
        level.func_B8AD = [];
      }

      if(scripts\engine\utility::is_true(var_02)) {
        if(isDefined(self.func_114FB)) {
          foreach(var_11 in var_03)
          thread func_399B(var_11, var_01);
        }
      } else if(isDefined(var_6.func_10943))
        self[[var_6.func_10943]](var_00, var_06, var_03, var_07);
      else {
        var_13 = 0;

        foreach(var_15 in self.turrets[var_00]) {
          if(isDefined(var_15)) {
            foreach(var_11 in var_03) {
              var_17 = var_15 func_12A36(var_11);
              var_18 = var_15 func_12A37(var_11, var_17);

              if(self.func_114FB != self)
                var_15.func_114FB = self.func_114FB;

              if(scripts\engine\utility::mod(var_13, level.func_C214) == var_09) {
                var_19 = [];
                var_19[0] = var_11;
                var_15 func_0B76::func_1945(var_15.func_114FB, var_19, 1);
              }
            }

            if(isDefined(var_06))
              wait(var_6.func_6D39);
            else
              wait 1;
          }

          var_13++;
        }
      }

      if(isDefined(var_06)) {
        wait(var_6.func_6D20);
        var_04 = var_04 - var_6.func_6D20;
        continue;
      }

      wait 1;
      var_04 = var_04 - 1;
    }

    var_9++;

    if(var_09 == level.func_C214)
      var_09 = 0;

    if(isDefined(var_06))
      var_05 = randomfloatrange(var_6.func_13535[0], var_6.func_13535[1]);
    else
      var_05 = 0.5;

    wait(var_05);
  }
}

func_39B8(var_00, var_01, var_02, var_03, var_04) {
  self notify("stop_shooting_missiles");
  self endon("stop_shooting_missiles");
  self endon("death");
  self endon("entitydeleted");
  self.team = self.script_team;
  self.func_8B4F[var_00] = scripts\engine\utility::array_removeundefined(self.func_8B4F[var_00]);

  if(self.func_8B4F[var_00].size == 0) {
    return;
  }
  var_05 = func_39DC(self.func_8B4F[var_00][0].model);
  var_06 = 0;
  var_07 = 0;
  var_08 = undefined;

  if(isDefined(self.func_8B4F[var_00][0].func_10241))
    var_08 = self.func_8B4F[var_00][0].func_10241;
  else if(isDefined(level.func_39DD[self.func_8B4F[var_00][0].class].func_10241))
    var_08 = level.func_39DD[self.func_8B4F[var_00][0].class].func_10241;

  if(isDefined(self.func_8B4F[var_00][0].func_4D1E) && isDefined(self.func_8B4F[var_00][0].func_4D1E.func_DCCA))
    var_09 = self.func_8B4F[var_00][0].func_4D1E.func_DCCA;
  else
    var_09 = 5000;

  wait(randomfloat(2));

  for(;;) {
    if(scripts\sp\utility::func_65DF("player_inside_ship") && scripts\sp\utility::func_65DB("player_inside_ship")) {
      wait 1;
      continue;
    }

    if(isDefined(var_08) && isDefined(self.func_1D65) && self.func_1D65 == 1)
      var_10 = var_8.func_1DFC;
    else
      var_10 = 100;

    if(isDefined(var_08) && randomfloat(1) < var_10)
      var_06 = randomfloatrange(var_8.func_13536[0], var_8.func_13536[1]);
    else
      var_06 = 1;

    var_11 = 0;

    while(var_06 > 0) {
      self.func_8B4F[var_00] = scripts\engine\utility::array_removeundefined(self.func_8B4F[var_00]);

      if(isDefined(self.func_8B4F[var_00]) && self.func_8B4F[var_00].size == 0) {
        return;
      }
      if(isDefined(var_03))
        self.func_114FB = var_03;
      else if(isDefined(self.func_1DF8))
        self.func_114FB = self.func_1DF8;
      else if(func_12A3B(var_09, self.func_114FB) || scripts\engine\utility::is_true(self.func_1D62))
        func_B2CA(var_09);

      if(!isDefined(self.func_114FB) || self.func_114FB == self) {
        wait 0.1;
        continue;
      }

      if(!isDefined(self.func_114FB) || self.func_114FB == self) {
        wait 0.1;
        continue;
      }

      if(isDefined(self.func_114FB) && isDefined(level.func_D127) && self.func_114FB == level.func_D127)
        wait 2;

      if(!isDefined(level.missiles)) {
        level.missiles = 0;
        level.func_B8AD = [];
      }

      if(scripts\engine\utility::is_true(var_02)) {
        if(isDefined(self.func_114FB)) {
          foreach(var_13 in var_05)
          thread func_399B(var_13, var_01);
        }
      } else if(isDefined(var_8.func_10943))
        self[[var_8.func_10943]](var_00, var_08, var_05, var_09);
      else {
        var_15 = 0;

        foreach(var_17 in self.func_8B4F[var_00]) {
          if(isDefined(var_17)) {
            if(isDefined(var_04)) {
              if(!isDefined(self.func_8B46) || !isDefined(self.func_8B46[var_04])) {
                wait 0.05;
                var_15++;
                continue;
              }

              var_18 = self.func_8B46[var_04];

              if(!scripts\engine\utility::array_contains(var_18, var_17.func_AD42)) {
                wait 0.05;
                var_15++;
                continue;
              }
            }

            foreach(var_13 in var_05) {
              var_20 = var_17 func_12A36(var_13);
              var_21 = var_17 func_12A37(var_13, var_20);

              if(self.func_114FB != self)
                var_17.func_114FB = self.func_114FB;

              if(level.func_C214 == -1 || scripts\engine\utility::mod(var_15, level.func_C214) == var_11) {
                var_22 = [];
                var_22[0] = var_13;
                var_17 func_0B76::func_1945(var_17.func_114FB, var_22, 1);
              }
            }

            if(isDefined(var_08))
              wait(var_8.func_6D39);
            else
              wait 1;
          }

          var_15++;
        }
      }

      if(isDefined(var_08)) {
        wait(var_8.func_6D20);
        var_06 = var_06 - var_8.func_6D20;
        continue;
      }

      wait 1;
      var_06 = var_06 - 1;
    }

    var_11++;

    if(var_11 == level.func_C214)
      var_11 = 0;

    if(isDefined(var_08))
      var_07 = randomfloatrange(var_8.func_13535[0], var_8.func_13535[1]);
    else
      var_07 = 0.5;

    wait(var_07);
  }
}

func_399B(var_00, var_01) {
  var_02 = randomint(self.func_12A69.size);
  scripts\engine\utility::array_thread(self.func_12A69[var_02], ::func_6D52, self, var_00, var_01);
}

func_39BF(var_00, var_01, var_02, var_03) {
  var_04 = self.turrets[var_02];
  var_05 = scripts\engine\utility::array_randomize(var_04);
  var_06 = 0;

  foreach(var_08 in var_05) {
    if(isDefined(var_08)) {
      var_09 = var_08 func_12A36(var_00);
      var_10 = var_08 func_12A37(var_00, var_09);
      var_09 = var_09 + (randomfloatrange(-10, 10), randomfloatrange(-10, 10), randomfloatrange(-10, 10));

      if(self.func_114FB != self)
        var_8.func_114FB = self.func_114FB;

      var_08 thread func_6D51(var_10, var_09, var_00, 1);
      var_6++;

      if(var_06 > 6) {
        return;
      }
      if(isDefined(var_01))
        wait(var_1.func_6D39);
      else
        wait 0.2;
    }
  }
}

func_6D52(var_00, var_01, var_02) {
  var_03 = self;
  wait(randomfloatrange(0.05, 1));

  if(isDefined(var_03) && isDefined(var_00)) {
    if(var_0.func_114FB != var_00)
      var_3.func_114FB = var_0.func_114FB;

    var_04 = var_03 func_12A36(var_01);
    var_05 = var_03 func_12A37(var_01, var_04);
    var_04 = var_04 + (randomfloatrange(-10, 10), randomfloatrange(-10, 10), randomfloatrange(-10, 10));

    if(!isDefined(var_0.func_114FB)) {
      return;
    }
    var_06 = [];
    var_6[0] = var_01;
    var_03 func_0B76::func_1945(var_0.func_114FB, var_06, 1);
  }
}

func_6D51(var_00, var_01, var_02, var_03) {
  if(!isDefined(self.func_114FB) || self.func_114FB == self) {
    return;
  }
  if(scripts\engine\utility::is_true(var_03)) {
    if(!isDefined(self.func_6D1D)) {
      return;
    }
    var_04 = self;
    var_05 = var_00 + 10000 * anglesToForward(var_01);
    var_06 = magicbullet(var_4.func_6D1D, var_00, var_05);
    var_06 thread func_396D();
    var_6.team = self.script_team;
    var_06 setCanDamage(1);

    if(isDefined(level.func_D127) && self.func_114FB == level.func_D127 && isDefined(level.func_B8B5) && level.func_B8B5)
      level.player thread func_11AA8(var_06);

    level.missiles++;
    wait(randomfloatrange(0.25, 1));

    if(isDefined(var_06) && isvalidmissile(var_06) && isDefined(var_04) && isDefined(var_4.func_114FB)) {
      var_06 missile_settargetent(var_4.func_114FB);
      return;
    }
  } else {
    var_06 = spawn("script_model", var_00);
    var_06 setModel("projectile_c12rocket_boxcoll");
    var_6.origin = var_00;
    var_6.angles = var_01;
    var_6.team = self.script_team;
    var_06 getrandomweaponfromcategory();

    if(isDefined(level.func_D127) && self.func_114FB == level.func_D127 && isDefined(level.func_B8B5) && level.func_B8B5)
      level.player thread func_11AA8(var_06);

    var_07 = getent("missile_trigger", "targetname");
    var_08 = spawn("script_model", var_00);
    var_6.func_438D = var_08;
    var_6.func_438D clonebrushmodeltoscriptmodel(var_07);
    var_6.func_438D.origin = var_00;
    var_6.func_438D.angles = var_01;
    var_6.func_438D setCanDamage(1);
    var_6.func_438D linkto(var_06);
    var_6.func_438D.owner = var_06;
    thread func_B887(var_6.func_438D);
    thread func_51BB(var_6.func_438D);
    var_09 = self.func_114FB.origin;

    if(isDefined(self.func_114FB.func_5099) && isDefined(self.func_114FB.func_5099.func_B738) && isDefined(self.func_114FB.func_5099.func_B417))
      var_10 = randomfloatrange(self.func_114FB.func_5099.func_B738, self.func_114FB.func_5099.func_B417);
    else
      var_10 = 0;

    if(isDefined(self.func_114FB)) {
      var_11 = self.func_114FB;
      var_12 = 1;
    } else {
      var_11 = scripts\engine\utility::spawn_tag_origin();
      var_11.origin = var_09;
      var_11.func_5F27 = 1;
      var_12 = 1;
    }

    if(isDefined(self.func_4D1E) && isDefined(self.func_4D1E.fx) && isDefined(self.func_4D1E.fx.func_BDFF))
      playFX(scripts\engine\utility::getfx(self.func_4D1E.fx.func_BDFF), var_00, anglesToForward(var_01), anglestoup(var_01));
    else
      playFX(scripts\engine\utility::getfx("capital_turret_muzzle_smt"), var_00, anglesToForward(var_01), anglestoup(var_01));

    self.func_114FB notify("missile_inbound");
    level.missiles++;
    level.func_B8AD[level.func_B8AD.size] = var_08;

    if(isDefined(self.func_4D1E)) {
      var_6.loop_sound = "jackal_missile_lp_space";
      var_6.func_AA99 = "capitalship_missile_launch";
      var_6.func_69E9 = "capitalship_cannon_impact";
      var_06 func_0B76::func_A332(var_11, var_12, self, self.func_4D1E.fx.func_B036, undefined, (0, 0, 500), var_10, [self.func_4D1E.fx.func_69DA, "capitalship_cannon_impact", 5], undefined, undefined, undefined, 1);
    } else
      var_06 func_0B76::func_A332(var_11, var_12, self);

    if(isDefined(var_06) && isDefined(self) && isDefined(self.func_4D1E))
      radiusdamage(var_6.origin, self.func_4D1E.func_DCCA, self.func_4D1E.func_B428, self.func_4D1E.func_B73D, self, "MOD_EXPLOSIVE", "viper_missile");
    else if(isDefined(var_06) && !isDefined(self))
      radiusdamage(var_6.origin, 500, 50, 50, var_06, "MOD_EXPLOSIVE", "viper_missile");

    scripts\engine\utility::waitframe();

    if(isDefined(var_08))
      var_08 delete();

    if(isDefined(var_06))
      var_06 delete();

    level.missiles--;
    level.func_B8AD = scripts\engine\utility::array_removeundefined(level.func_B8AD);
  }
}

func_B887(var_00) {
  var_0.health = 9999;

  if(isDefined(self.func_4D1E) && isDefined(self.func_4D1E.fx) && isDefined(self.func_4D1E.fx.func_B036))
    var_01 = self.func_4D1E.fx.func_B036;
  else
    var_01 = "capital_missile_flare_smt";

  var_02 = "jackal_missile_lp_space";

  if(isDefined(self.func_4D1E) && isDefined(self.func_4D1E.fx) && isDefined(self.func_4D1E.fx.func_69DA))
    var_03 = [self.func_4D1E.fx.func_69DA, "capitalship_missile_impact", 5];
  else
    var_03 = ["capital_missile_imp_airburst_smt", "capitalship_missile_impact", 5];

  var_04 = 0;

  for(;;) {
    var_00 waittill("damage", var_05, var_06, var_07, var_08, var_09);

    if(isDefined(var_06) && isDefined(var_6.team) && isDefined(var_0.owner.team) && var_6.team != var_0.owner.team) {
      if(isplayer(var_06))
        var_4++;

      if(isDefined(var_00)) {
        if(isDefined(var_0.owner)) {
          var_0.owner notify("missile_destroyed");
          stopFXOnTag(scripts\engine\utility::getfx(var_01), var_0.owner, "tag_origin");
          var_0.owner stoploopsound(var_02);
          var_10 = scripts\engine\trace::ray_trace(var_0.owner.origin, var_08, [var_0.owner, var_06], undefined, 1);
          thread func_0B76::func_4C7B(var_10, "missile", var_03);
        }

        var_00 delete();
        break;
      }
    }
  }
}

func_51BB(var_00) {
  if(isDefined(self.func_4D1E) && isDefined(self.func_4D1E.fx) && isDefined(self.func_4D1E.fx.func_B036))
    var_01 = self.func_4D1E.fx.func_B036;
  else
    var_01 = "capital_missile_flare_smt";

  var_02 = "jackal_missile_lp_space";

  if(isDefined(self.func_4D1E) && isDefined(self.func_4D1E.fx) && isDefined(self.func_4D1E.fx.func_69DA))
    var_03 = [self.func_4D1E.fx.func_69DA, "capitalship_missile_impact", 5];
  else
    var_03 = ["capital_missile_imp_airburst_smt", "capitalship_missile_impact", 5];

  self waittill("death", var_04, var_05, var_06);

  if(isDefined(self) && isDefined(var_00)) {
    var_0.owner notify("missile_destroyed");

    if(isDefined(var_0.owner)) {
      stopFXOnTag(scripts\engine\utility::getfx(var_01), var_0.owner, "tag_origin");
      var_0.owner stoploopsound(var_02);
      var_0.owner delete();
    }

    var_07 = scripts\engine\trace::ray_trace(var_0.origin, self.origin, [var_00, var_04], undefined, 1);
    thread func_0B76::func_4C7B(var_07, "missile", var_03);
    var_00 delete();
  }
}

func_396D() {
  self waittill("death");
  level.missiles--;
}

func_129DD() {
  self endon("entitydeleted");
  var_00 = self getlinkedparent();
  self.health = int(self.health * level.func_A48E.func_39F9);
  self.health = self.health + 30000;

  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_03, var_04, var_03, var_03, var_03, var_03, var_05);

    if(self.health > 0 && isDefined(var_2.script_team) && var_2.script_team == self.script_team) {
      self.health = self.health + var_01;
      continue;
    } else if(self.health > 0 && isDefined(var_2.classname) && var_2.classname == "worldspawn") {
      self.health = self.health + var_01;
      continue;
    }

    if(var_02 == level.player || isDefined(level.func_D127) && var_02 == level.func_D127) {
      if(self.func_C841.classname == "script_vehicle_capitalship_missileboat_ca") {
        if(var_04 != "MOD_PROJECTILE") {
          var_06 = ["spaceship_cannon_projectile", "spaceship_cannon_projectile_weapupgrade", "spaceship_cleaver_projectile", "spaceship_cleaver_projectile_weapupgrade", "spaceship_anvil_projectile", "spaceship_anvil_projectile_weapupgrade"];

          if(var_04 == "MOD_PROJECTILE_SPLASH" && scripts\engine\utility::array_contains(var_06, var_05))
            self.health = self.health + int(var_01 * 0.45);
        }
      }
    }

    if(!isalive(self) || self.health <= 30000) {
      if(isDefined(self)) {
        foreach(var_08 in var_0.turrets)
        var_08 = scripts\engine\utility::array_remove(var_08, self);

        thread func_129DF();
        return;
      }
    }
  }
}

func_129E0(var_00) {
  wait(randomfloatrange(0.25, 1));

  if(isDefined(self))
    func_129DF(var_00);
}

func_129DF(var_00) {
  var_01 = self getlinkedparent();
  var_01 notify("turret_destroyed", self.class);
  level notify("turret_destroyed", self.class, var_01);

  if(isDefined(level.func_12A71) && level.func_12A71)
    var_01 func_12DFA(self);

  if(!isDefined(var_1.func_10381))
    var_1.func_10381 = [];

  var_02 = scripts\engine\utility::spawn_tag_origin();
  thread func_129C5(var_02);
  var_02 linkto(var_01, self.func_AD42, (0, 0, 0), (0, 0, 0));
  var_2.func_AD42 = self.func_AD42;
  var_1.func_10381 = scripts\engine\utility::array_add(var_1.func_10381, var_02);
  self delete();

  if(isDefined(self.func_4D1E)) {
    playFXOnTag(scripts\engine\utility::getfx(self.func_4D1E.fx.death), var_02, "tag_origin");

    if(isDefined(self.func_4D1E.fx.func_1037F)) {
      playFXOnTag(scripts\engine\utility::getfx(self.func_4D1E.fx.func_1037F), var_02, "tag_origin");
      var_2.func_10380 = self.func_4D1E.fx.func_1037F;
    }
  }

  if(!isDefined(var_00))
    var_00 = 0;

  if(!var_00)
    var_02 playSound("capital_ship_turret_explode");
}

func_129C5(var_00) {
  if(isDefined(self.func_129D9) && !self.func_129D9) {
    return;
  }
  var_01 = [];

  switch (self.model) {
    case "ship_exterior_ca_cannon_a_rig_periph":
    case "sdf_ship_exterior_un_turret_b_rig_s0p75":
    case "sdf_ship_exterior_un_turret_b_rig":
    case "ship_exterior_un_cannon_b_rig":
    case "ship_exterior_ca_cannon_a_rig":
      var_01 = ["ship_exterior_damage_piece_d_crater_01_dst", "ship_exterior_damage_piece_d_crater_04_dst_s1p2", "ship_exterior_damage_piece_d_crater_16_dst_s0p8", "ship_exterior_damage_piece_d_crater_22_dst"];
      break;
    case "ship_exterior_ca_turret_missile_b_s0p75":
    case "ship_exterior_ca_turret_missile_b":
    case "ship_exterior_missile_pod_a_rig":
      var_01 = ["ship_exterior_ca_turret_missile_b_01_dst", "ship_exterior_ca_turret_missile_b_02_dst", "ship_exterior_ca_turret_missile_b_03_dst", "ship_exterior_ca_turret_missile_b_04_dst"];
      break;
    case "veh_mil_air_ca_missile_boat_turret":
      var_01 = ["ship_exterior_ca_turret_missile_b_01_dst_s0p75", "ship_exterior_ca_turret_missile_b_02_dst_s0p75", "ship_exterior_ca_turret_missile_b_03_dst_s0p75", "ship_exterior_ca_turret_missile_b_04_dst_s0p75"];
      break;
    default:
      var_02 = self.model + "_dst";
      break;
  }

  if(var_1.size == 0) {
    return;
  }
  var_02 = scripts\engine\utility::random(var_01);
  var_00 setModel(var_02);
  var_00 show();
  var_00 rotateyaw(randomintrange(0, 360), 0.05);
}

func_12A06() {
  if(!isDefined(self.func_B8A4)) {
    return;
  }
  self.func_B8A4 = scripts\engine\utility::array_removeundefined(self.func_B8A4);

  foreach(var_01 in self.func_B8A4) {
    thread scripts\engine\utility::play_sound_in_space("capitalship_missile_impact");
    playFX(scripts\engine\utility::getfx("jet_missile_imp_airburst"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    self delete();
  }
}

func_1150D(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(var_04))
    var_04 = (0, 0, 0);

  if(!isDefined(var_05))
    var_05 = 16;

  if(!isDefined(var_06))
    var_06 = 24;

  _target_alloc(var_00, var_04);
  _target_setshader(var_00, var_01);
  _target_setscaledrendermode(var_00, 1);
  _target_drawsquare(var_00);
  _target_drawsingle(var_00);
  _target_drawcornersonly(var_00, 1);

  if(isDefined(var_02))
    _target_setcolor(var_00, var_02);

  _target_setmaxsize(var_00, var_06);
  _target_setminsize(var_00, var_05, 0);
  wait(level.func_12A91 * 0.05);
  _target_flush(var_00);
}

func_11509(var_00) {
  if(!isDefined(var_00)) {
    return;
  }
  _target_remove(var_00);
}

func_8935(var_00) {
  var_01 = getent(var_00, "targetname");
  level.func_12A90 = [];

  foreach(var_03 in self.turrets) {
    foreach(var_05 in var_03) {
      if(ispointinvolume(var_5.origin, var_01)) {
        var_05 scripts\sp\utility::func_F40A("enemy", 0, 0);
        level.func_12A90[level.func_12A90.size] = var_05;
      }

      scripts\engine\utility::waitframe();
    }
  }

  func_13819(level.func_12A90, level.func_12A90.size);
  scripts\engine\utility::flag_set("turrets_destroyed");
}

func_13819(var_00, var_01, var_02) {
  var_10 = spawnStruct();

  if(isDefined(var_02)) {
    var_10 endon("thread_timed_out");
    var_10 thread scripts\sp\utility_code::func_13758(var_02);
  }

  var_10.count = var_0.size;

  if(isDefined(var_01) && var_01 < var_10.count)
    var_10.count = var_01;

  scripts\engine\utility::array_thread(var_00, scripts\sp\utility_code::func_13757, var_10);

  while(var_10.count > 0)
    var_10 waittill("waittill_dead guy died");
}

func_8933(var_00) {
  if(isDefined(level.func_FD6C))
    level.func_FD6C.func_4C11 destroy();
  else
    level.func_FD6C = spawnStruct();

  level.func_FD6C.func_4C11 = level.player scripts\sp\hud_util::func_4999("default", 2);
  level.func_FD6C.func_4C11.hidewheninmenu = 1;
  level.func_FD6C.func_4C11.hidewhendead = 1;
  level.func_FD6C.func_4C11.alignx = "left";
  level.func_FD6C.func_4C11.aligny = "top";
  level.func_FD6C.func_4C11.horzalign = "left";
  level.func_FD6C.func_4C11.vertalign = "top";
  level.func_FD6C.func_4C11.alpha = 1;
  level.func_FD6C.func_4C11.font = "default";
  level.func_FD6C.func_4C11.color = (1, 1, 1);

  if(isDefined(var_00)) {
    level.func_C3F7 = level.func_B4D0;
    level.func_12A91 = var_00;
    level.func_B4D0 = var_00;
  }

  level.func_FD6C.func_4C11 give_zap_perk(scripts\sp\utility::string(level.func_12A91) + " / " + scripts\sp\utility::string(level.func_B4D0) + " Turrets");
}

func_12DFA(var_00) {
  if(level.func_12A91 == 0) {
    return;
  }
  if(isDefined(self.func_592A) && int(self.func_592A)) {
    return;
  }
  level.func_12A91--;
  level.func_FD6C.func_4C11 give_zap_perk(scripts\sp\utility::string(level.func_12A91) + " / " + scripts\sp\utility::string(level.func_B4D0) + " Turrets");

  if(level.func_12A91 == 0)
    thread func_409E();
}

func_409E() {
  scripts\engine\utility::flag_set("turrets_destroyed");
  wait 1;

  if(isDefined(level.func_FD6C) && isDefined(level.func_FD6C.func_4C11)) {
    level.func_FD6C.func_4C11 give_zap_perk("Turrets Destroyed");

    for(var_00 = 1; var_00 > 0; var_00 = var_00 - 0.1) {
      level.func_FD6C.func_4C11.alpha = var_00;
      wait 0.5;
    }

    scripts\engine\utility::waitframe();
    level.func_FD6C.func_4C11 destroy();
  }
}

func_B7EA() {
  if(isDefined(self.func_912F)) {
    return;
  }
  self.func_912F = [];
  self.func_912F["lock_on"] = scripts\sp\hud_util::func_499B("hud_iw7_warning", 256, 64);
  self.func_912F["lock_on"].alignx = "center";
  self.func_912F["lock_on"].aligny = "top";
  self.func_912F["lock_on"].horzalign = "center";
  self.func_912F["lock_on"].vertalign = "top";
  self.func_912F["lock_on"].y = 50;
  self.func_912F["lock_on"].foreground = 0;
  self.func_912F["lock_on"].alpha = 0;
  self.func_912F["lock_on"].sort = -99;
  var_00 = 22;
  var_01 = 16;
  var_02 = 0.25;
  thread func_C8E0(self.func_912F["lock_on"], var_00, var_01, var_02);
  self.func_8D63 = [];
  self.func_AEEF = [];
  self.func_AEF0 = [];
  thread func_88FB();
}

func_C8E0(var_00, var_01, var_02, var_03, var_04) {
  var_00 notify("visor_parallaxing");
  var_00 endon("visor_parallaxing");
  var_00 endon("element_off");
  var_00 endon("death");

  while(!isDefined(self.func_C09D))
    wait 0.1;

  var_05 = 0;
  var_06 = 0;
  var_07 = var_0.x;
  var_08 = var_0.y;
  var_09 = 0.15;
  var_10 = 0.15;

  for(;;) {
    if(isDefined(var_0.alpha) && var_0.alpha == 0) {
      wait 0.05;
      continue;
    }

    var_11 = var_01 * self.func_C09D[1];
    var_12 = var_02 * self.func_C09D[0];
    var_13 = var_11 - var_05;
    var_14 = var_12 - var_06;

    if(!isDefined(var_04))
      var_15 = 0;
    else
      var_15 = randomfloatrange(0, var_04);

    var_16 = var_05 + var_13 * var_09 + var_15;
    var_17 = var_06 + var_14 * var_10 + var_15;
    var_00 moveovertime(0.05);
    var_0.x = var_07 - var_16;
    var_0.y = var_08 + var_17;
    var_05 = var_16;
    var_06 = var_17;
    wait 0.05;
  }
}

func_88FB() {
  thread func_88FD();
  thread func_88FF();

  for(;;) {
    self waittill("locking_target", var_00);

    if(self.func_AEF0.size == 0)
      self notify("start_locking");

    thread func_11AA8(var_00);
  }
}

func_11AA8(var_00) {
  var_0.icon = newclienthudelem(self);
  var_0.icon setshader("ac130_hud_friendly_vehicle_diamond_s_w", 32, 32);
  var_0.icon.color = (1, 0, 0);
  var_0.icon.alpha = 1.0;
  var_0.icon setwaypoint(0, 0, 1);
  var_0.icon settargetent(var_00);
  var_0.func_928C = newclienthudelem(self);
  var_0.func_928C setshader("heli_warning_missile_red", 1, 2);
  var_0.func_928C.color = (1, 0, 0);
  var_0.func_928C.alpha = 0.5;
  var_0.func_928C setwaypoint(0, 1, 1);
  var_0.func_928C settargetent(var_00);
  var_0.func_928C thread func_9141(0.1, 0.1, 0.9, "death");
  self.func_AEEF = scripts\engine\utility::array_add(self.func_AEEF, var_00);
  var_00 scripts\engine\utility::waittill_any("death", "guided_missile_fire", "target_lost");
  self.func_AEEF = scripts\engine\utility::array_remove(self.func_AEEF, var_00);
  var_0.icon destroy();
  var_0.func_928C destroy();

  if(self.func_AEEF.size == 0)
    self notify("stop_locking");
}

func_88FD() {
  for(;;) {
    self waittill("start_locking");
    self.func_912F["lock_on"] setshader("hud_iw7_warning", 256, 64);
    self.func_912F["lock_on"] thread func_9141(0.5, 0, 0.9, "stop_locking");

    foreach(var_01 in self.func_8D63)
    var_01 thread func_9142(0.5, (1, 0, 0), (0, 1, 0), "stop_locking");

    thread scripts\engine\utility::play_loop_sound_on_entity("unguided_missile_warning");
    self waittill("stop_locking");
    self.func_912F["lock_on"] notify("stop_locking");
    self.func_912F["lock_on"].alpha = 0.0;

    foreach(var_01 in self.func_8D63) {
      var_01 notify("stop_locking");
      var_1.color = (0, 1, 0);
    }

    thread scripts\engine\utility::stop_loop_sound_on_entity("unguided_missile_warning");
  }
}

func_88FF() {
  for(;;) {
    self waittill("start_warning");
    self notify("stop_locking");
    self.func_912F["lock_on"] setshader("hud_iw7_incoming", 256, 64);
    self.func_912F["lock_on"] thread func_9141(0.1, 0.25, 0.9, "stop_warning");

    foreach(var_01 in self.func_8D63)
    var_01 thread func_9142(0.1, (0.9, 0, 0), (0.75, 0, 0), "stop_warning");

    thread scripts\engine\utility::play_loop_sound_on_entity("guided_missile_incoming");
    scripts\engine\utility::waittill_any_timeout(2, "stop_warning");
    thread scripts\engine\utility::stop_loop_sound_on_entity("guided_missile_incoming");
    self.func_912F["lock_on"] notify("stop_warning");

    foreach(var_01 in self.func_8D63) {
      var_01 notify("stop_warning");
      var_1.color = (0, 1, 0);
    }

    if(self.func_AEEF.size > 0) {
      self notify("start_locking");
      continue;
    }

    self.func_912F["lock_on"].alpha = 0.0;
  }
}

func_88FE() {
  self.func_912F["lock_on"] setshader("hud_iw7_warning", 256, 64);
  self.func_912F["lock_on"] thread func_9141(0.5, 0, 0.9, "stop_locking");
  self.func_912F["lock_on"].func_AF21 = 1;

  foreach(var_01 in self.func_8D63)
  var_01 thread func_9142(0.5, (1, 0, 0), (0, 1, 0), "stop_locking");

  thread scripts\engine\utility::play_loop_sound_on_entity("missile_locking");
  self.func_912F["lock_on"] scripts\engine\utility::waittill_any_timeout(2, "stop_locking");
  thread func_88FC();
  self.func_912F["lock_on"].func_AF21 = 0;
  self.func_912F["lock_on"] notify("stop_locking");
  self.func_912F["lock_on"].alpha = 0.0;

  foreach(var_01 in self.func_8D63) {
    var_01 notify("stop_locking");
    var_1.color = (0, 1, 0);
  }

  thread scripts\engine\utility::stop_loop_sound_on_entity("missile_locking");
}

func_9141(var_00, var_01, var_02, var_03) {
  self endon(var_03);
  var_00 = scripts\engine\utility::ter_op(isDefined(var_00), var_00, 0.05);
  var_00 = scripts\engine\utility::ter_op(var_00 > 0.05, var_00, 0.05);

  for(;;) {
    self.alpha = var_02;
    wait(var_00);
    self.alpha = var_01;
    wait(var_00);
  }
}

func_9142(var_00, var_01, var_02, var_03) {
  self endon(var_03);
  var_00 = scripts\engine\utility::ter_op(isDefined(var_00), var_00, 0.05);
  var_00 = scripts\engine\utility::ter_op(var_00 > 0.05, var_00, 0.05);

  for(;;) {
    self.color = var_01;
    wait(var_00);
    self.color = var_02;
    wait(var_00);
  }
}

func_88FC() {
  self.func_912F["lock_on"] setshader("hud_iw7_incoming", 256, 64);
  self.func_912F["lock_on"] thread func_9141(0.1, 0.25, 0.9, "stop_warning");

  foreach(var_01 in self.func_8D63)
  var_01 thread func_9142(0.1, (0.9, 0, 0), (0.75, 0, 0), "stop_warning");

  thread scripts\engine\utility::play_loop_sound_on_entity("missile_locked");
  scripts\engine\utility::waittill_any_timeout(6, "missile_barrage_end");
  thread scripts\engine\utility::stop_loop_sound_on_entity("missile_locked");
  self.func_912F["lock_on"] notify("stop_warning");

  foreach(var_01 in self.func_8D63) {
    var_01 notify("stop_warning");
    var_1.color = (0, 1, 0);
  }

  self.func_912F["lock_on"].alpha = 0.0;
}

func_4098() {
  for(;;) {
    if(scripts\engine\utility::is_true(level.player.func_912F["lock_on"].func_AF21))
      level.player.func_912F["lock_on"] notify("stop_locking");

    if(isDefined(level.missiles) && level.missiles == 0) {
      level.player notify("missile_barrage_end");
      break;
    }

    if(isDefined(level.func_FD6C) && !isDefined(level.func_FD6C.func_4C11)) {
      level.player notify("missile_barrage_end");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_4335(var_00, var_01, var_02, var_03) {
  var_04 = spawnStruct();
  var_4.missiles = [];
  var_05 = undefined;

  if(!isDefined(var_02))
    var_02 = 1;

  if(var_01 == level.func_D127)
    thread func_0B76::func_D195(1);

  var_06 = 0;

  if(isDefined(var_03)) {
    if(scripts\sp\utility::hastag(self.model, var_03 + "_1"))
      var_06 = 1;
  }

  if(isDefined(var_1.script_linkto))
    var_05 = var_01 scripts\sp\utility::func_7A97();

  for(var_07 = 1; var_07 < var_00; var_7++) {
    if(isDefined(var_05))
      var_01 = scripts\engine\utility::random(var_05);

    if(var_06) {
      var_08 = var_03 + "_" + var_07;
      var_09 = func_433A("cap_mons_projectile", var_01, var_08);
    } else
      var_09 = func_433A("cap_mons_projectile", var_01, var_03);

    if(isDefined(var_09)) {
      if(isDefined(level.func_D127) && var_01 == level.func_D127) {
        if(var_02) {
          var_09 makeentitysentient("axis");
          var_9.ignoreme = 1;
          var_09 _meth_84BE("turret");
          var_09 _meth_8339(0);
          var_4.missiles[var_4.missiles.size] = var_09;
          var_9.group = var_04;
        }

        var_09 thread func_433B(self);
      } else
        var_09 childthread func_4338();
    }

    wait 0.75;
  }

  func_13748(var_04);
  func_0B76::func_D195(0);
}

func_13748(var_00) {
  for(;;) {
    var_0.missiles = scripts\engine\utility::array_removeundefined(var_0.missiles);

    if(!var_0.missiles.size) {
      return;
    }
    wait 0.5;
  }
}

func_529F(var_00) {
  if(isDefined(var_0.func_9BBA)) {
    return;
  }
  var_0.func_9BBA = 1;
  var_0.missiles = scripts\engine\utility::array_removeundefined(var_0.missiles);
  var_01 = 0;

  foreach(var_03 in var_0.missiles) {
    wait 0.15;

    if(isDefined(var_03) && isvalidmissile(var_03))
      var_03 detonate();
  }
}

func_433B(var_00) {
  thread func_4337();
  self endon("death");
  self missile_settargetent(level.func_D127, scripts\engine\utility::randomvectorrange(200, 400));
  childthread func_4336(level.func_D127, var_00);
  childthread func_4338();
  childthread func_4339();
}

func_4336(var_00, var_01) {
  var_02 = level.func_D127.func_6E9C.func_12B86;
  var_03 = undefined;

  for(;;) {
    if(distancesquared(self.origin, var_0.origin) < squared(7000) || var_2.size > 0) {
      break;
    }
    wait 0.05;
  }

  if(isDefined(var_01) && var_1.class == "cannon_missileboat_small") {
    var_04 = self.anglelerprate;
    self missile_settargetent(var_00);

    for(var_05 = 0; var_05 < 40; var_5++) {
      if(distancesquared(self.origin, var_0.origin) < squared(1000) || var_2.size > 0) {
        break;
      }
      wait 0.05;
    }

    if(level.func_D127.func_B855 < 0.06 && var_2.size < 1)
      self.anglelerprate = 999999;
    else {
      if(var_2.size > 0)
        var_03 = scripts\engine\utility::random(var_02);
      else
        var_03 = var_00;

      self missile_settargetpos(var_3.origin);

      if(_target_istarget(self))
        _target_remove(self);
    }

    wait 2.0;
    self.anglelerprate = var_04;
  } else
    self missile_settargetent(var_00, (600, 0, 0));
}

func_433A(var_00, var_01, var_02) {
  var_02 = scripts\engine\utility::ter_op(isDefined(var_02), var_02, "tag_origin");
  var_03 = self gettagorigin(var_02);

  if(isDefined(self) && self.class == "cannon_missileboat_small")
    var_00 = "cap_missileboat_projectile";

  var_00 = scripts\engine\utility::ter_op(isDefined(var_00), var_00, "cap_turret_proj_weapon");

  if(isDefined(self) && self.class == "cannon_missileboat_small")
    var_04 = magicbullet(var_00, var_03, var_1.origin);
  else
    var_04 = magicbullet(var_00, var_03, var_03 + (0, 0, 500));

  return var_04;
}

func_4339() {
  wait 1.0;
  level notify("locked_on_player");
  _target_set(self);
  _target_setscaledrendermode(self, 0);
  _target_setshader(self, "apache_target_lock");
  _target_setminsize(self, 15, 0);
  _target_setmaxsize(self, 20, 0);
}

func_4337() {
  self setCanDamage(1);
  self.health = 10000;

  for(;;) {
    self waittill("damage", var_00, var_01);
    var_02 = "undefined";

    if(isDefined(var_01) && isDefined(var_1.classname))
      var_02 = var_1.classname;

    if(isDefined(var_01) && var_1.classname == "script_vehicle_jackal_friendly") {
      var_03 = self.origin;
      func_529F(self.group);
      return;
    }
  }
}

func_4338() {
  self endon("death");

  for(var_00 = 0; func_0B76::func_9C19(self) || var_00 <= 3; var_0++)
    wait 1.5;

  if(isDefined(self.group))
    func_529F(self.group);

  wait 0.05;
  self delete();
}