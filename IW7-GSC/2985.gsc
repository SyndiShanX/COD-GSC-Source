/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2985.gsc
**************************************/

func_39B3(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::func_31A3(999, 500, 1500);

  if(issubstr(var_2, "mons") && level.script != "marscrash") {
    scripts\sp\vehicle_build::func_31B8("mig_rumble", 0.2, 0.15, 1000000, 0.05, 0.05);
  } else {
    scripts\sp\vehicle_build::func_31B8("mig_rumble", 0.2, 0.15, 20300, 0.05, 0.05);
  }

  scripts\sp\vehicle_build::func_31C4("axis");
  scripts\sp\vehicle_build::func_319F();
  scripts\sp\vehicle_build::func_31C6(var_2, "default", "vfx\iw7\core\tread\vfx_treadfx_capship_dust_02.vfx", 0);
  scripts\sp\vehicle_build::func_3186(var_0, "tag_origin");
  func_39C7(var_0);

  if(issubstr(var_2, "cheap")) {
    func_3995(var_1, var_2);
  } else if(issubstr(var_2, "periph")) {
    func_3995(var_1, var_2);
  } else {
    func_3994(var_1);
  }
}

func_396E(var_0) {
  self.var_6A8D = var_0;
  self.var_9B82 = 1;
  self.var_C721 = self.classname;
  thread func_3998();
  thread func_39D4();

  if(self.classname != "script_vehicle_capitalship_missileboat_ca") {
    thread func_0BB6::func_39E8();
  }

  thread func_3981();
  thread func_3972();
  thread func_396C();
  thread func_39A6();

  if(issubstr(self.classname, "periph")) {
    thread func_246C(self.model);
  } else if(issubstr(self.classname, "cheap")) {
    thread func_246C(self.model);
    thread scripts\engine\utility::delaythread(0.1, func_0BB8::func_397F, 1, 0);
  } else {
    thread func_246C(self.model);
    thread scripts\engine\utility::delaythread(0.1, func_0BB8::func_397F, 1, 1);
  }

  self.var_9310 = 1;
  self.var_55A4 = 1;
  self.var_A8EA = -99999;
  self.var_B83F = 0;
  self.var_B794 = 3;
  self.var_B795 = 0;
  self.var_126F3 = 5000;
  self.var_126F4 = 1;
  self getpitchtospot3d(1);
}

func_3972() {
  self endon("entitydeleted");
  self waittill("death");
  func_0BB6::func_398A(0);
  func_0BB8::func_39CD("off");
  func_0BB8::func_39D0("off");
  func_0BB8::func_39CE("off");

  if(isDefined(self.var_12FF3)) {
    if(isDefined(self.var_10250)) {
      var_0 = 1;
    } else {
      var_0 = 0;
    }

    func_39AA(self.origin, var_0);
    self delete();
  } else {
    if(isDefined(self.var_BFE3)) {
      return;
    }
    var_1 = spawn("script_model", self.origin);
    var_1 setModel("tag_origin");
    var_1.angles = self.angles;

    if(soundexists("capital_ship_explo")) {
      var_1 playSound("capital_ship_explo");
      var_1 scripts\engine\utility::delaycall(randomfloatrange(1.0, 2.5), ::playsound, "capital_ship_explo_jackal_debris");
    }

    if(isDefined(self.var_4E09)) {
      playFXOnTag(level._effect[self.var_4E09], var_1, "tag_origin");
      return;
    }

    playFXOnTag(level._effect["vfx_generic_ship_death"], var_1, "tag_origin");
  }
}

func_39A6() {
  self endon("death");
  self.health = 99999;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);
    self.health = 99999;
  }
}

func_396C() {
  scripts\engine\utility::waittill_any("death", "entitydeleted", "delete_cleanup");
  func_0BB6::func_39E1();
  func_0BB8::func_39C5();
  func_EA02(self.var_10381);

  if(isDefined(self.var_4074)) {
    foreach(var_1 in self.var_4074) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }

    self.var_4074 = [];
  }
}

func_397B() {
  if(isDefined(self)) {
    self.var_BFE3 = 1;
    self notify("delete_cleanup");
    wait 0.1;
    var_0 = [];

    if(isDefined(self.var_65CD)) {
      foreach(var_2 in self.var_65CD) {
        var_0 = scripts\engine\utility::array_add(var_0, var_2.var_2F00[0]);
        var_0 = scripts\engine\utility::array_add(var_0, var_2.var_101B0[0]);
        var_0 = scripts\engine\utility::array_add(var_0, var_2.var_119EA[0]);
        var_0 = scripts\engine\utility::array_add(var_0, var_2.var_4651);
      }

      foreach(var_5 in var_0) {
        if(isDefined(var_5)) {
          var_5 delete();
        }
      }
    }

    self delete();
  }
}

func_246C(var_0) {
  wait 0.2;

  if(issubstr(var_0, "_rig") && !issubstr(var_0, "_sa_")) {
    if(isDefined(self.var_B210)) {
      self attach(self.var_B210, "TAG_ORIGIN");
    } else if(issubstr(self.classname, "_cheap")) {
      var_0 = getsubstr(var_0, 0, var_0.size - 4);
      var_0 = var_0 + "_periph";
      self attach(var_0, "TAG_ORIGIN");
    } else {
      var_0 = getsubstr(var_0, 0, var_0.size - 4);
      self attach(var_0, "TAG_ORIGIN");
    }
  }
}

func_3994(var_0) {
  if(!isDefined(level.var_3997)) {
    level._effect["light_blue_small"] = loadfx("vfx\iw7\core\light\vfx_blue_light_sml.vfx");
    level._effect["light_red_small"] = loadfx("vfx\core\lights\vfx_orange_lights_med.vfx");
    level._effect["light_blue_large"] = loadfx("vfx\iw7\core\light\vfx_blue_light_lrg.vfx");
    level._effect["light_red_large"] = loadfx("vfx\core\lights\vfx_red_lights_big.vfx");
    level._effect["flak_omni_space"] = loadfx("vfx\iw7\core\vehicle\capship\vfx_capship_flak_omni_space_opt.vfx");
    level._effect["flak_wall_space"] = loadfx("vfx\iw7\core\vehicle\capship\vfx_capship_flak_wall_space.vfx");
    level._effect["phalanx_burst_fire"] = loadfx("vfx\iw7\core\vehicle\capship\vfx_capship_phalanx_spray_space.vfx");
    level._effect["miniflak_muzzle"] = loadfx("vfx\iw7\core\vehicle\capship\vfx_capship_flak_mini_muzz.vfx");
    level._effect["miniflak_trace"] = loadfx("vfx\iw7\core\vehicle\capship\vfx_capship_flak_mini_trace.vfx");
    level._effect["miniflak"] = loadfx("vfx\iw7\core\vehicle\capship\vfx_capship_flak_mini.vfx");
    level._effect["damage_heavy_fire"] = loadfx("vfx\iw7\core\vehicle\capship\vfx_capship_damage_heavy_fire.vfx");
    level._effect["missile_flare_generic"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_player_missile.vfx");
    level._effect["jet_missile_imp_water"] = loadfx("vfx\old\space_fighter\vfx_jet_missile_imp_water.vfx");
    level._effect["jet_missile_imp_generic"] = loadfx("vfx\iw7\levels\moon\vfx_jet_missile_imp_generic_moon.vfx");
    level._effect["jet_missile_imp_airburst"] = loadfx("vfx\iw7\levels\moon\vfx_jet_missile_imp_generic_moon_premature.vfx");
    level._effect["vfx_generic_ship_death"] = loadfx("vfx\iw7\core\expl\vehicle\vfx_destroyer_death_dps.vfx");
    level._effect["vfx_capship_ca_death_small"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_death_small.vfx");
    level._effect["vfx_capship_ca_death_med"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_death_med.vfx");
    level._effect["vfx_capship_ca_death_large"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_death_large.vfx");
    level._effect["vfx_capship_ca_death_huge"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_death_huge.vfx");
    level.var_3997 = 1;
  }

  if(var_0 == "un" && !isDefined(level.var_399A)) {
    level._effect["un_thruster_down_sml_idle"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_sml_idle.vfx");
    level._effect["un_thruster_down_sml_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_sml_heavy.vfx");
    level._effect["un_thruster_down_sml_launch"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_sml_heavy.vfx");
    level._effect["un_thruster_down_med_idle"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_med_idle.vfx");
    level._effect["un_thruster_down_med_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_med_heavy.vfx");
    level._effect["un_thruster_down_med_launch"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_med_launch.vfx");
    level._effect["un_thruster_down_lrg_idle"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_lrg_idle.vfx");
    level._effect["un_thruster_down_lrg_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_lrg_heavy.vfx");
    level._effect["un_thruster_down_lrg_launch"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_lrg_launch.vfx");
    level._effect["un_thruster_rear_med_idle"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_med_idle.vfx");
    level._effect["un_thruster_rear_med_light"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_med_light.vfx");
    level._effect["un_thruster_rear_med_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_med_heavy.vfx");
    level._effect["un_thruster_rear_med_launch"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_med_launch.vfx");
    level._effect["un_thruster_rear_lrg_idle"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_lrg_idle.vfx");
    level._effect["un_thruster_rear_lrg_idle_light"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_lrg_idle_light.vfx");
    level._effect["un_thruster_rear_lrg_light"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_lrg_light.vfx");
    level._effect["un_thruster_rear_lrg_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_lrg_heavy.vfx");
    level._effect["un_thruster_rear_lrg_launch"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_lrg_launch.vfx");
    level.var_399A = 1;
  }

  if(var_0 == "ca" && !isDefined(level.var_3993)) {
    level._effect["ca_thruster_down_sml_idle"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_down_sml_idle.vfx");
    level._effect["ca_thruster_down_sml_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_down_sml_heavy.vfx");
    level._effect["ca_thruster_down_sml_launch"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_down_sml_launch.vfx");
    level._effect["ca_thruster_down_med_idle"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_down_med_idle.vfx");
    level._effect["ca_thruster_down_med_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_down_med_heavy.vfx");
    level._effect["ca_thruster_down_lrg_idle"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_down_lrg_idle.vfx");
    level._effect["ca_thruster_down_lrg_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_down_lrg_heavy.vfx");
    level._effect["ca_thruster_down_lrg_launch"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_down_lrg_launch.vfx");
    level._effect["ca_thruster_rear_sml_idle"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_sml_idle.vfx");
    level._effect["ca_thruster_rear_sml_light"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_sml_light.vfx");
    level._effect["ca_thruster_rear_sml_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_sml_heavy.vfx");
    level._effect["ca_thruster_rear_sml_burst"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_sml_heavy_burst.vfx");
    level._effect["ca_thruster_rear_sml_launch"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_sml_launch.vfx");
    level._effect["ca_thruster_rear_med_idle"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_med_idle.vfx");
    level._effect["ca_thruster_rear_med_light"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_med_light.vfx");
    level._effect["ca_thruster_rear_med_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_med_heavy.vfx");
    level._effect["ca_thruster_rear_med_burst"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_med_heavy_burst.vfx");
    level._effect["ca_thruster_rear_med_launch"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_med_launch.vfx");
    level._effect["ca_thruster_rear_lrg_idle"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_lrg_idle.vfx");
    level._effect["ca_thruster_rear_lrg_light"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_lrg_light.vfx");
    level._effect["ca_thruster_rear_lrg_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_lrg_heavy.vfx");
    level._effect["ca_thruster_rear_lrg_burst"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_lrg_heavy_burst.vfx");
    level._effect["ca_thruster_rear_lrg_launch"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_lrg_launch.vfx");
    level.var_3993 = 1;
  }
}

func_3995(var_0, var_1) {
  if(!isDefined(level.var_3996)) {
    level._effect["light_blue_small"] = loadfx("vfx\iw7\core\light\vfx_blue_light_sml.vfx");
    level._effect["light_red_small"] = loadfx("vfx\core\lights\vfx_orange_lights_med.vfx");
    level._effect["light_blue_large"] = loadfx("vfx\iw7\core\light\vfx_blue_light_lrg.vfx");
    level._effect["light_red_large"] = loadfx("vfx\core\lights\vfx_red_lights_big.vfx");
    level.var_3996 = 1;
  }

  if(var_0 == "un" && !isDefined(level.var_3999)) {
    level._effect["un_thruster_down_sml_idle"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_sml_idle.vfx");
    level._effect["un_thruster_down_sml_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_sml_heavy.vfx");
    level._effect["un_thruster_down_med_idle"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_med_idle.vfx");
    level._effect["un_thruster_down_med_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_med_heavy.vfx");
    level._effect["un_thruster_down_lrg_idle"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_lrg_idle.vfx");
    level._effect["un_thruster_down_lrg_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_down_lrg_heavy.vfx");
    level._effect["un_thruster_rear_med_idle"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_med_idle.vfx");
    level._effect["un_thruster_rear_med_light"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_med_light.vfx");
    level._effect["un_thruster_rear_lrg_idle"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_lrg_idle.vfx");
    level._effect["un_thruster_rear_lrg_light"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_lrg_light.vfx");
    level._effect["un_thruster_rear_med_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_med_heavy.vfx");
    level._effect["un_thruster_rear_lrg_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_thruster_rear_lrg_heavy.vfx");
    level.var_3999 = 1;
  }

  if(var_0 == "ca" && !isDefined(level.var_3992)) {
    level._effect["ca_thruster_down_sml_idle"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_down_sml_idle.vfx");
    level._effect["ca_thruster_down_sml_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_down_sml_heavy.vfx");
    level._effect["ca_thruster_down_med_idle"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_down_med_idle.vfx");
    level._effect["ca_thruster_down_med_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_down_med_heavy.vfx");
    level._effect["ca_thruster_down_lrg_idle"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_down_lrg_idle.vfx");
    level._effect["ca_thruster_down_lrg_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_down_lrg_heavy.vfx");
    level._effect["ca_thruster_rear_sml_idle"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_sml_idle.vfx");
    level._effect["ca_thruster_rear_sml_light"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_sml_light.vfx");
    level._effect["ca_thruster_rear_med_idle"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_med_idle.vfx");
    level._effect["ca_thruster_rear_med_light"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_med_light.vfx");
    level._effect["ca_thruster_rear_lrg_idle"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_lrg_idle.vfx");
    level._effect["ca_thruster_rear_lrg_light"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_lrg_light.vfx");
    level._effect["ca_thruster_rear_sml_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_sml_heavy.vfx");
    level._effect["ca_thruster_rear_med_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_med_heavy.vfx");
    level._effect["ca_thruster_rear_lrg_heavy"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_thruster_rear_lrg_heavy.vfx");
    level.var_3992 = 1;
  }
}

func_3998() {
  var_0 = "blue";

  if(self.var_6A8D == "ca") {
    var_0 = "red";
  }

  func_0BB8::func_7561("light_lod_high", "fx_light_main_a_1", "light_" + var_0 + "_large");
  func_0BB8::func_7562("light_lod_high", "fx_light_running_lrg_b1", "light_" + var_0 + "_small");
  func_0BB8::func_7562("light_lod_high", "fx_light_running_lrg_b2", "light_" + var_0 + "_small");
  func_0BB8::func_7562("light_lod_high", "fx_light_running_lrg_b3", "light_" + var_0 + "_small");
  func_0BB8::func_7562("light_lod_high", "fx_light_running_lrg_b4", "light_" + var_0 + "_small");
  thread func_0BB8::func_39CE("high");
}

func_39D4() {}

func_3981() {
  self.var_5020 = "idle";
  self.var_501F = "idle";

  if(isDefined(self.var_ED7C)) {
    var_0 = strtok(self.var_ED7C, " ");

    if(var_0.size != 2) {}

    self.var_5020 = var_0[0];
    self.var_501F = var_0[1];
  }

  waittillframeend;
  thread func_0BB8::func_39CD(self.var_5020);
  thread func_0BB8::func_39D0(self.var_501F);
}

func_39C7(var_0) {
  var_1 = func_7C33(var_0);
  var_2 = scripts\engine\utility::getstruct(var_1, "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = scripts\engine\utility::getstructarray(var_2.target, "targetname");

  if(!isDefined(var_3) || var_3.size == 0) {
    return;
  }
  foreach(var_5 in var_3) {
    precachemodel(var_5.script_parameters);
  }
}

func_7C33(var_0) {
  var_1 = var_0 + "_scriptables";

  switch (var_0) {
    case "veh_mil_air_ca_destroyer_sa_breach":
      var_1 = "veh_mil_air_ca_destroyer_scriptables";
      break;
    case "veh_mil_air_ca_destroyer_sa_rig":
      var_1 = "veh_mil_air_ca_destroyer_rig_scriptables";
      break;
    case "veh_mil_air_ca_olympus_mons_sa_rig":
      var_1 = "veh_mil_air_ca_olympus_mons_scriptables_heistspace";
      break;
    case "veh_mil_air_ca_destroyer_yard_end":
      var_1 = "veh_mil_air_ca_destroyer_rig_scriptables_yard";
      break;
    default:
      break;
  }

  return var_1;
}

func_39C9() {
  var_0 = func_7C33(self.model);

  if(isDefined(self.var_EF30)) {
    var_0 = func_7C33(self.var_EF30);
  }

  var_1 = scripts\engine\utility::getstruct(var_0, "targetname");

  if(!isDefined(var_1)) {}

  if(!isDefined(var_1.angles)) {
    var_1.angles = (0, 0, 0);
  }

  var_2 = scripts\engine\utility::getstructarray(var_1.target, "targetname");

  if(!isDefined(var_2) || var_2.size == 0) {}

  if(!isDefined(self.var_EF3C)) {
    self.var_EF3C = [];
  }

  foreach(var_4 in var_2) {
    var_5 = var_4.origin - var_1.origin;
    var_5 = rotatevector(var_5, self.angles);

    if(!isDefined(var_4.angles)) {
      var_4.angles = (0, 0, 0);
    }

    var_6 = transformmove(self.origin, self.angles, var_1.origin, var_1.angles, var_4.origin, var_4.angles);
    var_7 = spawn("script_model", var_6["origin"]);
    var_7 setModel(var_4.script_parameters);
    var_7.angles = var_6["angles"];
    var_7 linkto(self);
    var_7 setCanDamage(1);
    self.var_EF3C[self.var_EF3C.size] = var_7;
  }

  if(isDefined(self.var_539C) && isDefined(self.var_539C[1]) && isDefined(self.var_539B[2])) {
    self detach(self.var_539C[1], "TAG_ORIGIN");
    thread func_0BB8::func_16C4(self.var_539B[2], 2);
  }
}

func_48AF(var_0) {
  for(var_1 = 1; var_1 <= self.var_C1FB; var_1++) {
    if(var_1 < 10) {
      var_2 = "0";
    } else {
      var_2 = "";
    }

    precachemodel(self.var_CB56 + var_2 + var_1);
  }

  precachemodel(self.var_E505);
  level.var_3979[var_0] = self;
}

func_ACEB(var_0) {
  while(!isDefined(level.var_D127)) {
    wait 0.05;
  }

  for(;;) {
    wait 0.05;
  }
}

func_39AA(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = self.origin;
  }

  self.var_BFE3 = 1;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!var_1) {
    func_39BE(var_0);
  }

  var_3 = func_3977();
  var_3 give_attacker_kill_rewards(level.var_3979[var_3.type].var_1FAF);
  var_3 thread func_3974(var_0, var_2);
  var_3 thread func_3975();
  self notify("death");

  if(!isDefined(level.var_3971)) {
    level.var_3971 = [];
  }

  level.var_3971 = scripts\engine\utility::array_add(level.var_3971, var_3);
  return var_3;
}

func_39AC() {
  self.var_BFE3 = 1;
  var_0 = func_3977();
  var_0 give_attacker_kill_rewards(level.var_3979[var_0.type].var_1FAF);
  var_0 _meth_82B0(level.var_3979[var_0.type].var_1FAF, 1);
  self notify("death");
  return var_0;
}

func_39AD() {}

func_39AB() {
  foreach(var_1 in self.var_CB53) {
    var_1 delete();
  }

  self delete();
}

func_3974(var_0, var_1) {
  self playSound(level.var_3979[self.type].var_FB8C);
  playFX(level.var_3979[self.type].var_7582, self.origin, anglesToForward(self.angles), anglestoup(self.angles));

  if(!isDefined(level.var_1024A)) {
    if(scripts\engine\utility::is_true(level.var_12FB6) == 1) {
      playFX(level.var_3979[self.type].var_7571, self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    } else {
      playFX(level.var_3979[self.type].var_7570, self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    }
  }

  if(scripts\engine\utility::player_is_in_jackal()) {
    thread func_395F();
    var_2 = 0.2;
    var_3 = 4.0;
    var_4 = distance(level.var_D127.origin, var_0);
    var_5 = scripts\sp\math::func_C097(7000, 100000, var_4);
    var_6 = scripts\sp\math::func_6A8E(130, 0, var_5);
    var_7 = scripts\sp\math::func_6A8E(0.8, 0, var_5);
    var_8 = scripts\sp\math::func_6A8E(0.25, 0, var_5);
    var_9 = scripts\sp\math::func_6A8E(0.45, 0.2, var_5);
    earthquake(var_9, 1.9, level.var_D127.origin, 25000);
    var_5 = scripts\sp\math::func_C097(2000, 25000, var_4);
    var_10 = scripts\sp\math::func_6A8E(0.75, 2.5, var_5);
    scripts\engine\utility::delaycall(var_10, ::playsound, "capital_ship_explo_jackal_debris");

    if(isDefined(level.var_A056) && isDefined(var_1) && var_1) {
      [
        [level.var_A056.var_3A02]
      ](var_0, var_6, var_7, var_8, var_2, var_3);
    }
  }
}

func_395F() {
  level.player endon("flag_player_dismounting");

  for(;;) {
    if(isDefined(level.var_D127) && isDefined(self)) {
      var_0 = distancesquared(level.var_D127.origin, self.origin);

      if(var_0 < 400000000) {
        while(var_0 < 400000000) {
          if(!isDefined(level.var_D127.var_4E93)) {
            level.var_D127.var_4E93 = spawn("script_origin", level.var_D127.origin);
            level.var_D127.var_4E93 linkto(level.var_D127);
            wait 0.05;
            level.var_D127.var_4E93 ghostattack(0);
            level.var_D127.var_4E93 playLoopSound("jackal_debris_lp_sfx");
          }

          var_1 = var_0 / 20000;
          var_2 = scripts\sp\math::func_C097(2500, 20000, var_1);
          var_2 = (var_2 - 1) * -1;

          if(isDefined(level.var_D127.var_4E93)) {
            level.var_D127.var_4E93 ghostattack(var_2, 0.1);
          }

          wait 0.1;
          var_0 = distancesquared(level.var_D127.origin, self.origin);
        }

        if(isDefined(level.var_D127.var_4E93)) {
          level.var_D127.var_4E93 ghostattack(0, 0.5);
        }

        wait 0.5;

        if(isDefined(level.var_D127.var_4E93)) {
          level.var_D127.var_4E93 stoploopsound("jackal_debris_lp_sfx");
          level.var_D127.var_4E93 delete();
        }
      }
    }

    wait 0.1;
  }
}

func_3975() {
  var_0 = 3;
  var_1 = 4;

  foreach(var_3 in self.var_CB53) {
    var_4 = _getnumparts(var_3.model);

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_6 = _getpartname(var_3.model, var_5);

      foreach(var_9, var_8 in level.var_3979[self.type].var_7586) {
        if(issubstr(var_6, var_9)) {
          var_3 scripts\sp\utility::func_75C4(var_8, var_6, randomfloatrange(var_0, var_1));
          break;
        }
      }
    }
  }
}

func_3978(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.05;
  }

  foreach(var_2 in self.var_CB53) {
    var_3 = _getnumparts(var_2.model);

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = _getpartname(var_2.model, var_4);

      foreach(var_8, var_7 in level.var_3979[self.type].var_7586) {
        if(issubstr(var_5, var_8)) {
          var_2 scripts\sp\utility::func_75F8(var_7, var_5, randomfloatrange(0, var_0));
          break;
        }
      }
    }
  }
}

func_39BE(var_0) {
  self notify("predeath");
  var_1 = 4;
  thread func_3976(var_0, var_1);
  thread func_397A(var_0, var_1);
  thread func_3973(var_0, var_1);
  wait(var_1 + 0.3);
}

func_7D02(var_0, var_1) {
  var_2 = distance(self.origin, var_0);
  var_3 = scripts\sp\math::func_C097(200, 7000, var_2);
  var_4 = scripts\sp\math::func_6A8E(0, var_1, var_3);
  var_4 = var_4 + randomfloatrange(-0.2, 0.2);

  if(var_4 < 0) {
    var_4 = 0;
  }

  return var_4;
}

func_397A(var_0, var_1) {
  if(!isDefined(self) || !isDefined(self.turrets) || self.turrets.size == 0) {
    return;
  }
  foreach(var_3 in self.turrets) {
    foreach(var_5 in var_3) {
      if(!isDefined(var_5)) {
        continue;
      }
      var_6 = var_5 func_7D02(var_0, var_1);
      var_5 thread func_12A4F(var_6);
    }
  }
}

func_3973(var_0, var_1) {
  if(!isDefined(self) || !isDefined(self.var_10381) || self.var_10381.size == 0) {
    return;
  }
  foreach(var_3 in self.var_10381) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = var_3 func_7D02(var_0, var_1);
    var_3 thread func_4DEA(var_4);
  }
}

func_3976(var_0, var_1) {
  if(!isDefined(self.var_EF3C)) {
    return;
  }
  foreach(var_3 in self.var_EF3C) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = var_3 func_7D02(var_0, var_1);
    var_3 thread func_EF37(var_4);
  }
}

func_4DEA(var_0) {
  self endon("death");
  wait(var_0);
  playFX(scripts\engine\utility::getfx("capital_dead_turret_ship_predeath"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  _playworldsound("capital_ship_turret_explode", self.origin);
}

func_12A4F(var_0) {
  self endon("death");
  wait(var_0);
  func_0BB6::func_12A06();
  thread func_0BB6::func_129DF();
}

func_EF37(var_0) {
  self endon("death");
  wait(var_0);
}

#using_animtree("vehicles");

func_3977() {
  var_0 = level.var_3979[self.var_C721];
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel(var_0.var_E505);
  var_1 glinton(#animtree);
  var_1.var_CB53 = [];
  var_1.type = self.var_C721;

  if(isDefined(self.var_CB55)) {
    foreach(var_3 in self.var_CB55) {
      var_4 = var_3;

      if(issubstr(var_4, "_mat_rdc")) {
        var_5 = scripts\sp\utility::strip_suffix(var_4, "_mat_rdc");
        var_6 = "tag_" + var_5;
      } else
        var_6 = "tag_" + var_4;

      var_3 = spawn("script_model", self.origin);
      var_3 setModel(var_4);
      var_3 linkto(var_1, var_6, (0, 0, 0), (0, 0, 0));
      var_1.var_CB53 = scripts\engine\utility::array_add(var_1.var_CB53, var_3);
    }
  } else {
    for(var_8 = 1; var_8 <= var_0.var_C1FB; var_8++) {
      if(var_8 < 10) {
        var_9 = "0";
      } else {
        var_9 = "";
      }

      var_4 = var_0.var_CB56 + var_9 + var_8;
      var_6 = "tag_" + var_4;
      var_3 = spawn("script_model", self.origin);
      var_3 setModel(var_4);
      var_3 linkto(var_1, var_6, (0, 0, 0), (0, 0, 0));
      var_1.var_CB53 = scripts\engine\utility::array_add(var_1.var_CB53, var_3);
    }
  }

  return var_1;
}

func_396F(var_0) {
  thread func_B2E5();
  func_3985(var_0);
}

func_9799(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 1.0;
  }

  if(!isDefined(var_1)) {
    var_1 = 3.0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.3;
  }

  if(!isDefined(var_3)) {
    var_3 = 0.75;
  }

  var_4 = spawnStruct();
  var_4.var_DCE5 = var_0;
  var_4.var_DCE3 = var_1;
  var_4.var_DCE4 = var_2;
  var_4.var_DCE2 = var_3;
  self.var_B797 = var_4;
}

func_3985(var_0, var_1) {
  if(!isDefined(self.var_B797)) {
    func_9799();
  }

  if(var_0) {
    thread func_39BD();

    if(!isDefined(var_1) || !var_1) {
      if(isDefined(self.var_8B4F) && isDefined(self.var_8B4F["cap_hardpoint_missile_barrage"])) {
        thread func_39B4();
      }

      thread func_0BB6::func_398A(0);
      thread func_0BB6::func_398A(1);
    }

    func_0BB6::func_39F1();
    thread func_0BB6::func_39F0();
  } else {
    self notify("disable_combat");
    thread func_0BB6::func_398A(0);
    thread func_0BB6::func_39F1();
  }
}

func_B2E5() {
  if(scripts\engine\utility::flag_exist("flag_capitalship_targeting_init")) {
    return;
  }
  scripts\engine\utility::flag_init("flag_capitalship_targeting_init");

  while(!isDefined(level.var_D127)) {
    wait 0.05;
  }

  scripts\engine\utility::flag_init("flag_changing_capitalship_targets");
  var_0 = undefined;
  var_1 = 50000;
  var_2 = 10000;
  var_3 = 0.99;
  var_4 = 0.85;
  var_5 = 30000;
  var_6 = 25000;
  var_7 = 0.8;

  for(;;) {
    if(!scripts\sp\utility::func_D123()) {
      wait 1;
      continue;
    }

    level.var_F02D = scripts\engine\utility::array_removeundefined(level.var_F02D);

    while(level.var_F02D.size == 0) {
      wait 0.05;
    }

    var_8 = anglesToForward(level.var_D127.angles);
    var_9 = undefined;

    foreach(var_11 in level.var_F02D) {
      var_12 = var_11.origin - level.var_D127.origin;
      var_11.var_56EA = length(var_12);
      var_13 = vectornormalize(var_12);
      var_11.var_5ABB = vectordot(var_13, var_8);
      var_14 = 1 - scripts\sp\math::func_C097(0, var_6, var_11.var_56EA);
      var_15 = scripts\sp\math::func_C097(var_7, 1, var_11.var_5ABB);
      var_11.var_1153F = var_14 * var_15;

      if(var_11.var_1153F > 0) {
        if(isDefined(var_9)) {
          if(var_11.var_1153F > var_9.var_1153F) {
            var_9 = var_11;
          }
        } else
          var_9 = var_11;
      }

      var_16 = scripts\sp\math::func_C097(var_2, var_1, var_11.var_56EA);
      var_17 = scripts\sp\math::func_6A8E(var_4, var_3, var_16);

      if(var_11.var_5ABB > var_17 && var_11.var_56EA < var_1) {
        if(var_11.var_AEDF.var_3782 != "enemy_capitalship" && var_11.var_3775 == 0) {
          var_11.var_AEDF.var_3782 = "enemy_capitalship";
          var_11 func_0B76::func_F42B(var_11.var_AEDF.var_3782);
          var_11 thread func_3968(1.5);
        }

        continue;
      }

      if(var_11.var_AEDF.var_3782 != "none" && var_11.var_3775 == 0) {
        var_11.var_AEDF.var_3782 = "none";
        var_11 func_0B76::func_F42B(var_11.var_AEDF.var_3782);
        var_11 thread func_3968(1.5);
      }
    }

    if(!scripts\engine\utility::flag("flag_changing_capitalship_targets")) {
      if(isDefined(var_0)) {
        if(isDefined(var_9)) {
          if(var_9 != var_0 && var_9.var_1153F > var_0.var_1153F) {
            var_9 thread func_11308(var_0);
            var_0 = var_9;
          }
        }

        if(var_0.var_56EA > var_5) {
          var_0 thread func_DFD2();
          var_0 = undefined;
        }
      } else if(isDefined(var_9)) {
        var_9 thread func_F2F7();
        var_0 = var_9;
      }
    }

    wait 0.05;
  }
}

func_11308(var_0) {
  scripts\engine\utility::flag_set("flag_changing_capitalship_targets");
  var_0 func_0BB6::func_39C0();
  var_0 waittill("turrets_not_targetable");
  var_0.var_12A8B = 0;
  var_0.var_D436 = 0;

  if(isDefined(self) && isalive(self)) {
    func_F2F7();
  }
}

func_F2F7() {
  if(!scripts\engine\utility::flag("flag_changing_capitalship_targets")) {
    scripts\engine\utility::flag_set("flag_changing_capitalship_targets");
  }

  self.var_D436 = 1;

  if(isDefined(self.var_C825)) {
    var_0 = self.var_C825;
  } else {
    var_0 = "turret_ja";
  }

  func_0BB6::func_39CA(0, 1, var_0);
  wait 1;
  scripts\engine\utility::flag_clear("flag_changing_capitalship_targets");
}

func_DFD2() {
  self.var_D436 = 0;
  func_0BB6::func_39C0();
}

func_3968(var_0) {
  self endon("death");
  self notify("new_callout_timer");
  self endon("new_callout_timer");

  for(self.var_3775 = var_0; self.var_3775 > 0; self.var_3775 = self.var_3775 - 0.05) {
    wait 0.05;
  }

  self.var_3775 = 0;
}

func_52FD() {
  self.var_B89E = 15000;
  self.var_B89F = 5000;
  self.var_B89B = 25000;
  self.var_B89C = 0.9;
  self.var_B89D = 1.0;
  self.var_B8A3 = 30000;
  self.var_B8A0 = 18000;
  self.var_B8A1 = 0.8;
  self.var_B8A2 = 3.0;
  self.var_B89A = 1;
  self.var_B899 = 1;
}

func_B862() {
  self.var_B89E = 15000;
  self.var_B89F = 5000;
  self.var_B89B = 25000;
  self.var_B89C = 0.9;
  self.var_B89D = 1.0;
  self.var_B8A3 = 30000;
  self.var_B8A0 = 18000;
  self.var_B8A1 = 0.8;
  self.var_B8A2 = 3.0;
  self.var_B89A = 1;
  self.var_B899 = 1;
}

func_F2F5(var_0) {
  self.var_38B5 = var_0;
}

func_39B4() {
  self notify("miniflak_and_missiles_think");
  self endon("miniflak_and_missiles_think");
  self endon("death");
  self endon("disable_combat");

  for(;;) {
    wait 0.2;

    if(!scripts\sp\utility::func_D123()) {
      wait 1;
      continue;
    }

    var_0 = undefined;

    if(func_9C74() && func_396B()) {
      var_0 = level.var_D127;
    }

    if(isDefined(var_0)) {
      if(func_396A(var_0, self.var_9278)) {
        func_3987(var_0);
        continue;
      }

      if(func_3969(var_0) && var_0 == level.var_D127) {
        var_1 = distance(self.origin, level.var_D127.origin);
        var_2 = anglestoright(self.angles);
        var_3 = anglestoup(self.angles);
        var_4 = vectornormalize(level.var_D127.origin - self.origin);
        var_5 = vectordot(var_2, var_4);
        var_6 = vectordot(var_3, var_4);
        func_0BB6::func_399F(var_1, var_5, var_6);
      }
    }
  }
}

func_3987(var_0) {
  self endon("death");
  self endon("predeath");
  var_1 = anglestoright(self.angles);
  var_2 = anglestoup(self.angles);
  var_3 = vectornormalize(var_0.origin - self.origin);
  var_4 = vectordot(var_1, var_3);
  var_5 = vectordot(var_2, var_3);
  self.var_8B50["cap_hardpoint_missile_barrage"] = scripts\engine\utility::array_removeundefined(self.var_8B50["cap_hardpoint_missile_barrage"]);
  self.var_8B51["cap_hardpoint_missile_barrage"] = scripts\engine\utility::array_removeundefined(self.var_8B51["cap_hardpoint_missile_barrage"]);

  if(var_4 < 0) {
    var_6 = self.var_8B50["cap_hardpoint_missile_barrage"];
  } else {
    var_6 = self.var_8B51["cap_hardpoint_missile_barrage"];
  }

  if(!isDefined(var_6)) {
    return;
  }
  if(var_6.size == 0) {
    if(var_4 < 0) {
      var_6 = self.var_8B51["cap_hardpoint_missile_barrage"];
    } else {
      var_6 = self.var_8B50["cap_hardpoint_missile_barrage"];
    }

    if(var_6.size == 0) {
      return;
    }
  }

  thread func_0BB6::func_39A0(var_0, var_6, 5);
  self.var_A8EA = gettime();

  if(isDefined(self.var_B89A) && isDefined(self.var_B899)) {
    if(self.var_B89A == self.var_B899) {
      var_7 = self.var_B89A * 1000;
    } else {
      var_7 = randomfloatrange(self.var_B89A, self.var_B899) * 1000;
    }

    self.var_B83F = var_7;
  }

  while(level.var_D127.var_93D2.size > 0) {
    wait 0.05;
  }
}

func_396B() {
  if(!isDefined(level.var_D127)) {
    return 0;
  }

  if(level.var_D127.var_58B5) {
    return 0;
  }

  if(func_0B76::func_7B95() > 0) {
    return 0;
  }

  return 1;
}

func_396A(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = gettime() - self.var_A8EA;

  if(var_2 < self.var_B83F) {
    return 0;
  }

  if(isDefined(self.var_38B5) && ![[self.var_38B5]]()) {
    return 0;
  }

  if(isDefined(level.var_D127) && var_0 == level.var_D127) {
    if(level.var_A056.var_68B3.running) {
      return 0;
    }

    if(!isDefined(var_1) || !var_1) {
      if(!level.player scripts\sp\utility::func_65DB("jackal_enemy_homing_missile_allowed")) {
        return 0;
      }
    } else if(!level.player scripts\sp\utility::func_65DB("jackal_enemy_homing_missile_allowed_hyperaggressive"))
      return 0;
  }

  return 1;
}

func_3969(var_0) {
  if(isDefined(level.var_D127) && isDefined(var_0) && var_0 == level.var_D127 && func_0B76::func_7B95() > 0) {
    return 0;
  }

  return 1;
}

func_9C74() {
  if(!scripts\sp\utility::func_65DF("player_is_near")) {
    return 0;
  }

  return scripts\sp\utility::func_65DB("player_is_near");
}

func_39BD() {
  self notify("player_jackal_near_think");
  self endon("player_jackal_near_think");
  self endon("death");
  self endon("disable_combat");

  if(!scripts\sp\utility::func_65DF("player_is_near")) {
    scripts\sp\utility::func_65E0("missiles_player_close_force");
    scripts\sp\utility::func_65E0("missiles_player_far_force");
    scripts\sp\utility::func_65E0("missiles_player_looking");
    scripts\sp\utility::func_65E0("missiles_player_close");
    scripts\sp\utility::func_65E0("player_is_near");
  }

  scripts\sp\utility::func_65DD("player_is_near");

  for(;;) {
    if(!scripts\sp\utility::func_D123()) {
      wait 1;
      continue;
    }

    func_B8AA();
    scripts\sp\utility::func_65E1("player_is_near");
    thread func_12A1E();
    func_B8AB();
    scripts\sp\utility::func_65DD("player_is_near");
    self notify("player_not_near");
  }
}

func_B8AA() {
  self endon("should_fire_missiles");
  self endon("death");
  childthread func_FF48();
  childthread func_FF47();
  wait 0.1;

  for(;;) {
    if(scripts\sp\utility::func_65DB("missiles_player_looking") && scripts\sp\utility::func_65DB("missiles_player_close")) {
      break;
    } else if(scripts\sp\utility::func_65DB("missiles_player_close_force")) {
      break;
    }
    wait 0.05;
  }
}

func_FF48() {
  var_0 = undefined;

  for(;;) {
    if(self.var_5ABB >= self.var_B89C) {
      if(isDefined(var_0)) {
        if(gettime() - self.var_B89D * 1000 >= var_0) {
          scripts\sp\utility::func_65E1("missiles_player_looking");
        }
      } else
        var_0 = gettime();
    } else {
      scripts\sp\utility::func_65DD("missiles_player_looking");
      var_0 = undefined;
    }

    wait 0.05;
  }
}

func_FF47() {
  for(;;) {
    if(!isDefined(level.var_D127)) {
      scripts\sp\utility::func_65DD("missiles_player_close_force");
      scripts\sp\utility::func_65DD("missiles_player_close");
      wait 0.05;
      continue;
    }

    var_0 = abs(self.origin[2] - level.var_D127.origin[2]);

    if(self.var_56EA <= self.var_B89E && var_0 <= self.var_B89F) {
      scripts\sp\utility::func_65E1("missiles_player_close_force");
    } else {
      scripts\sp\utility::func_65DD("missiles_player_close_force");
    }

    if(self.var_56EA <= self.var_B89B) {
      scripts\sp\utility::func_65E1("missiles_player_close");
    } else {
      scripts\sp\utility::func_65DD("missiles_player_close");
    }

    wait 0.05;
  }
}

func_B8AB() {
  childthread func_FF6E();
  childthread func_FF6D();
  wait 0.1;

  for(;;) {
    wait 0.05;

    if(scripts\sp\utility::func_65DB("missiles_player_far_force")) {
      break;
    }
    if(!scripts\sp\utility::func_65DB("missiles_player_looking") && !scripts\sp\utility::func_65DB("missiles_player_close")) {
      break;
    }
  }

  self notify("should_not_fire_missiles");
}

func_FF6E() {
  self endon("should_not_fire_missiles");
  self endon("death");
  var_0 = undefined;

  for(;;) {
    if(self.var_5ABB < self.var_B8A1) {
      if(isDefined(var_0)) {
        if(gettime() - self.var_B8A2 * 1000 >= var_0) {
          scripts\sp\utility::func_65DD("missiles_player_looking");
        }
      } else
        var_0 = gettime();
    } else {
      scripts\sp\utility::func_65E1("missiles_player_looking");
      var_0 = undefined;
    }

    wait 0.05;
  }
}

func_FF6D() {
  self endon("should_not_fire_missiles");
  self endon("death");

  for(;;) {
    if(self.var_56EA >= self.var_B8A3) {
      scripts\sp\utility::func_65E1("missiles_player_far_force");
    } else {
      scripts\sp\utility::func_65DD("missiles_player_far_force");
    }

    if(self.var_56EA >= self.var_B8A0) {
      scripts\sp\utility::func_65DD("missiles_player_close");
    } else {
      scripts\sp\utility::func_65E1("missiles_player_close");
    }

    wait 0.05;
  }
}

func_12A1E() {
  self endon("disable_combat");
  self endon("death");
  self endon("player_not_near");

  for(;;) {
    var_0 = 0;

    if(!scripts\sp\utility::func_D123()) {
      wait 1;
      continue;
    }

    var_1 = distance(level.var_D127.origin, self.origin);

    if(var_1 < 18000 && randomint(100) < 90) {
      var_0 = 1;
    }

    if(var_1 <= 8000) {
      var_0 = 1;
    }

    if(scripts\sp\utility::func_7B9D() <= 0.1) {
      var_0 = 0;
    } else if(scripts\sp\utility::func_7B9D() >= 0.6) {
      var_0 = 1;
    }

    self.var_1D62 = var_0;
    self.var_11578 = var_0;
    wait 3;
  }
}

func_39D6(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(level.var_A056)) {
    self[[level.var_A056.var_A16E]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, 0);
  }
}

func_EA01() {
  if(isDefined(self)) {
    self delete();
  }
}

func_EA02(var_0) {
  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      var_2 func_EA01();
    }
  }
}

func_DFE9(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3) || !_isstruct(var_3) && !isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}