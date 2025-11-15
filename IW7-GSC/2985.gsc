/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2985.gsc
***************************************/

func_39B3(var_00, var_01, var_02) {
  scripts\sp\vehicle_build::func_31A3(999, 500, 1500);

  if(issubstr(var_02, "mons") && level.script != "marscrash")
    scripts\sp\vehicle_build::func_31B8("mig_rumble", 0.2, 0.15, 1000000, 0.05, 0.05);
  else
    scripts\sp\vehicle_build::func_31B8("mig_rumble", 0.2, 0.15, 20300, 0.05, 0.05);

  scripts\sp\vehicle_build::func_31C4("axis");
  scripts\sp\vehicle_build::func_319F();
  scripts\sp\vehicle_build::func_31C6(var_02, "default", "vfx\iw7\core\tread\vfx_treadfx_capship_dust_02.vfx", 0);
  scripts\sp\vehicle_build::func_3186(var_00, "tag_origin");
  func_39C7(var_00);

  if(issubstr(var_02, "cheap"))
    func_3995(var_01, var_02);
  else if(issubstr(var_02, "periph"))
    func_3995(var_01, var_02);
  else
    func_3994(var_01);
}

func_396E(var_00) {
  self.func_6A8D = var_00;
  self.func_9B82 = 1;
  self.func_C721 = self.classname;
  thread func_3998();
  thread func_39D4();

  if(self.classname != "script_vehicle_capitalship_missileboat_ca")
    thread func_0BB6::func_39E8();

  thread func_3981();
  thread func_3972();
  thread func_396C();
  thread func_39A6();

  if(issubstr(self.classname, "periph"))
    thread func_246C(self.model);
  else if(issubstr(self.classname, "cheap")) {
    thread func_246C(self.model);
    thread scripts\engine\utility::delaythread(0.1, func_0BB8::func_397F, 1, 0);
  } else {
    thread func_246C(self.model);
    thread scripts\engine\utility::delaythread(0.1, func_0BB8::func_397F, 1, 1);
  }

  self.func_9310 = 1;
  self.func_55A4 = 1;
  self.func_A8EA = -99999;
  self.func_B83F = 0;
  self.func_B794 = 3;
  self.func_B795 = 0;
  self.func_126F3 = 5000;
  self.func_126F4 = 1;
  self getpitchtospot3d(1);
}

func_3972() {
  self endon("entitydeleted");
  self waittill("death");
  func_0BB6::func_398A(0);
  func_0BB8::func_39CD("off");
  func_0BB8::func_39D0("off");
  func_0BB8::func_39CE("off");

  if(isDefined(self.func_12FF3)) {
    if(isDefined(self.func_10250))
      var_00 = 1;
    else
      var_00 = 0;

    func_39AA(self.origin, var_00);
    self delete();
  } else {
    if(isDefined(self.func_BFE3)) {
      return;
    }
    var_01 = spawn("script_model", self.origin);
    var_01 setModel("tag_origin");
    var_1.angles = self.angles;

    if(soundexists("capital_ship_explo")) {
      var_01 playSound("capital_ship_explo");
      var_01 scripts\engine\utility::delaycall(randomfloatrange(1.0, 2.5), ::playsound, "capital_ship_explo_jackal_debris");
    } else {}

    if(isDefined(self.func_4E09)) {
      playFXOnTag(level._effect[self.func_4E09], var_01, "tag_origin");
      return;
    }

    playFXOnTag(level._effect["vfx_generic_ship_death"], var_01, "tag_origin");
  }
}

func_39A6() {
  self endon("death");
  self.health = 99999;

  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04);
    self.health = 99999;
  }
}

func_396C() {
  scripts\engine\utility::waittill_any("death", "entitydeleted", "delete_cleanup");
  func_0BB6::func_39E1();
  func_0BB8::func_39C5();
  func_EA02(self.func_10381);

  if(isDefined(self.func_4074)) {
    foreach(var_01 in self.func_4074) {
      if(isDefined(var_01))
        var_01 delete();
    }

    self.func_4074 = [];
  }
}

func_397B() {
  if(isDefined(self)) {
    self.func_BFE3 = 1;
    self notify("delete_cleanup");
    wait 0.1;
    var_00 = [];

    if(isDefined(self.func_65CD)) {
      foreach(var_02 in self.func_65CD) {
        var_00 = scripts\engine\utility::array_add(var_00, var_2.func_2F00[0]);
        var_00 = scripts\engine\utility::array_add(var_00, var_2.func_101B0[0]);
        var_00 = scripts\engine\utility::array_add(var_00, var_2.func_119EA[0]);
        var_00 = scripts\engine\utility::array_add(var_00, var_2.func_4651);
      }

      foreach(var_05 in var_00) {
        if(isDefined(var_05))
          var_05 delete();
      }
    }

    self delete();
  }
}

func_246C(var_00) {
  wait 0.2;

  if(issubstr(var_00, "_rig") && !issubstr(var_00, "_sa_")) {
    if(isDefined(self.func_B210))
      self attach(self.func_B210, "TAG_ORIGIN");
    else if(issubstr(self.classname, "_cheap")) {
      var_00 = getsubstr(var_00, 0, var_0.size - 4);
      var_00 = var_00 + "_periph";
      self attach(var_00, "TAG_ORIGIN");
    } else {
      var_00 = getsubstr(var_00, 0, var_0.size - 4);
      self attach(var_00, "TAG_ORIGIN");
    }
  }
}

func_3994(var_00) {
  if(!isDefined(level.func_3997)) {
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
    level.func_3997 = 1;
  }

  if(var_00 == "un" && !isDefined(level.func_399A)) {
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
    level.func_399A = 1;
  }

  if(var_00 == "ca" && !isDefined(level.func_3993)) {
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
    level.func_3993 = 1;
  }
}

func_3995(var_00, var_01) {
  if(!isDefined(level.func_3996)) {
    level._effect["light_blue_small"] = loadfx("vfx\iw7\core\light\vfx_blue_light_sml.vfx");
    level._effect["light_red_small"] = loadfx("vfx\core\lights\vfx_orange_lights_med.vfx");
    level._effect["light_blue_large"] = loadfx("vfx\iw7\core\light\vfx_blue_light_lrg.vfx");
    level._effect["light_red_large"] = loadfx("vfx\core\lights\vfx_red_lights_big.vfx");
    level.func_3996 = 1;
  }

  if(var_00 == "un" && !isDefined(level.func_3999)) {
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
    level.func_3999 = 1;
  }

  if(var_00 == "ca" && !isDefined(level.func_3992)) {
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
    level.func_3992 = 1;
  }
}

func_3998() {
  var_00 = "blue";

  if(self.func_6A8D == "ca")
    var_00 = "red";

  func_0BB8::func_7561("light_lod_high", "fx_light_main_a_1", "light_" + var_00 + "_large");
  func_0BB8::func_7562("light_lod_high", "fx_light_running_lrg_b1", "light_" + var_00 + "_small");
  func_0BB8::func_7562("light_lod_high", "fx_light_running_lrg_b2", "light_" + var_00 + "_small");
  func_0BB8::func_7562("light_lod_high", "fx_light_running_lrg_b3", "light_" + var_00 + "_small");
  func_0BB8::func_7562("light_lod_high", "fx_light_running_lrg_b4", "light_" + var_00 + "_small");
  thread func_0BB8::func_39CE("high");
}

func_39D4() {}

func_3981() {
  self.func_5020 = "idle";
  self.func_501F = "idle";

  if(isDefined(self.func_ED7C)) {
    var_00 = strtok(self.func_ED7C, " ");

    if(var_0.size != 2) {}

    self.func_5020 = var_0[0];
    self.func_501F = var_0[1];
  }

  waittillframeend;
  thread func_0BB8::func_39CD(self.func_5020);
  thread func_0BB8::func_39D0(self.func_501F);
}

func_39C7(var_00) {
  var_01 = func_7C33(var_00);
  var_02 = scripts\engine\utility::getstruct(var_01, "targetname");

  if(!isDefined(var_02)) {
    return;
  }
  var_03 = scripts\engine\utility::getstructarray(var_2.target, "targetname");

  if(!isDefined(var_03) || var_3.size == 0) {
    return;
  }
  foreach(var_05 in var_03)
  precachemodel(var_5.script_parameters);
}

func_7C33(var_00) {
  var_01 = var_00 + "_scriptables";

  switch (var_00) {
    case "veh_mil_air_ca_destroyer_sa_breach":
      var_01 = "veh_mil_air_ca_destroyer_scriptables";
      break;
    case "veh_mil_air_ca_destroyer_sa_rig":
      var_01 = "veh_mil_air_ca_destroyer_rig_scriptables";
      break;
    case "veh_mil_air_ca_olympus_mons_sa_rig":
      var_01 = "veh_mil_air_ca_olympus_mons_scriptables_heistspace";
      break;
    case "veh_mil_air_ca_destroyer_yard_end":
      var_01 = "veh_mil_air_ca_destroyer_rig_scriptables_yard";
      break;
    default:
      break;
  }

  return var_01;
}

func_39C9() {
  var_00 = func_7C33(self.model);

  if(isDefined(self.func_EF30))
    var_00 = func_7C33(self.func_EF30);

  var_01 = scripts\engine\utility::getstruct(var_00, "targetname");

  if(!isDefined(var_01)) {}

  if(!isDefined(var_1.angles))
    var_1.angles = (0, 0, 0);

  var_02 = scripts\engine\utility::getstructarray(var_1.target, "targetname");

  if(!isDefined(var_02) || var_2.size == 0) {}

  if(!isDefined(self.func_EF3C))
    self.func_EF3C = [];

  foreach(var_04 in var_02) {
    var_05 = var_4.origin - var_1.origin;
    var_05 = rotatevector(var_05, self.angles);

    if(!isDefined(var_4.angles))
      var_4.angles = (0, 0, 0);

    var_06 = transformmove(self.origin, self.angles, var_1.origin, var_1.angles, var_4.origin, var_4.angles);
    var_07 = spawn("script_model", var_6["origin"]);
    var_07 setModel(var_4.script_parameters);
    var_7.angles = var_6["angles"];
    var_07 linkto(self);
    var_07 setCanDamage(1);
    self.func_EF3C[self.func_EF3C.size] = var_07;
  }

  if(isDefined(self.func_539C) && isDefined(self.func_539C[1]) && isDefined(self.func_539B[2])) {
    self detach(self.func_539C[1], "TAG_ORIGIN");
    thread func_0BB8::func_16C4(self.func_539B[2], 2);
  }
}

func_48AF(var_00) {
  for(var_01 = 1; var_01 <= self.func_C1FB; var_1++) {
    if(var_01 < 10)
      var_02 = "0";
    else
      var_02 = "";

    precachemodel(self.func_CB56 + var_02 + var_01);
  }

  precachemodel(self.func_E505);
  level.func_3979[var_00] = self;
}

func_ACEB(var_00) {
  while(!isDefined(level.func_D127))
    wait 0.05;

  for(;;)
    wait 0.05;
}

func_39AA(var_00, var_01, var_02) {
  if(!isDefined(var_00))
    var_00 = self.origin;

  self.func_BFE3 = 1;

  if(!isDefined(var_01))
    var_01 = 0;

  if(!var_01)
    func_39BE(var_00);

  var_03 = func_3977();
  var_03 give_attacker_kill_rewards(level.func_3979[var_3.type].func_1FAF);
  var_03 thread func_3974(var_00, var_02);
  var_03 thread func_3975();
  self notify("death");

  if(!isDefined(level.func_3971))
    level.func_3971 = [];

  level.func_3971 = scripts\engine\utility::array_add(level.func_3971, var_03);
  return var_03;
}

func_39AC() {
  self.func_BFE3 = 1;
  var_00 = func_3977();
  var_00 give_attacker_kill_rewards(level.func_3979[var_0.type].func_1FAF);
  var_00 _meth_82B0(level.func_3979[var_0.type].func_1FAF, 1);
  self notify("death");
  return var_00;
}

func_39AD() {}

func_39AB() {
  foreach(var_01 in self.func_CB53)
  var_01 delete();

  self delete();
}

func_3974(var_00, var_01) {
  self playSound(level.func_3979[self.type].func_FB8C);
  playFX(level.func_3979[self.type].func_7582, self.origin, anglesToForward(self.angles), anglestoup(self.angles));

  if(!isDefined(level.func_1024A)) {
    if(scripts\engine\utility::is_true(level.func_12FB6) == 1)
      playFX(level.func_3979[self.type].func_7571, self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    else
      playFX(level.func_3979[self.type].func_7570, self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }

  if(scripts\engine\utility::player_is_in_jackal()) {
    thread func_395F();
    var_02 = 0.2;
    var_03 = 4.0;
    var_04 = distance(level.func_D127.origin, var_00);
    var_05 = scripts\sp\math::func_C097(7000, 100000, var_04);
    var_06 = scripts\sp\math::func_6A8E(130, 0, var_05);
    var_07 = scripts\sp\math::func_6A8E(0.8, 0, var_05);
    var_08 = scripts\sp\math::func_6A8E(0.25, 0, var_05);
    var_09 = scripts\sp\math::func_6A8E(0.45, 0.2, var_05);
    earthquake(var_09, 1.9, level.func_D127.origin, 25000);
    var_05 = scripts\sp\math::func_C097(2000, 25000, var_04);
    var_10 = scripts\sp\math::func_6A8E(0.75, 2.5, var_05);
    scripts\engine\utility::delaycall(var_10, ::playsound, "capital_ship_explo_jackal_debris");

    if(isDefined(level.func_A056) && isDefined(var_01) && var_01)
      [[level.func_A056.func_3A02]](var_00, var_06, var_07, var_08, var_02, var_03);
  }
}

func_395F() {
  level.player endon("flag_player_dismounting");

  for(;;) {
    if(isDefined(level.func_D127) && isDefined(self)) {
      var_00 = distancesquared(level.func_D127.origin, self.origin);

      if(var_00 < 400000000) {
        while(var_00 < 400000000) {
          if(!isDefined(level.func_D127.func_4E93)) {
            level.func_D127.func_4E93 = spawn("script_origin", level.func_D127.origin);
            level.func_D127.func_4E93 linkto(level.func_D127);
            wait 0.05;
            level.func_D127.func_4E93 ghostattack(0);
            level.func_D127.func_4E93 playLoopSound("jackal_debris_lp_sfx");
          }

          var_01 = var_00 / 20000;
          var_02 = scripts\sp\math::func_C097(2500, 20000, var_01);
          var_02 = (var_02 - 1) * -1;

          if(isDefined(level.func_D127.func_4E93))
            level.func_D127.func_4E93 ghostattack(var_02, 0.1);

          wait 0.1;
          var_00 = distancesquared(level.func_D127.origin, self.origin);
        }

        if(isDefined(level.func_D127.func_4E93))
          level.func_D127.func_4E93 ghostattack(0, 0.5);

        wait 0.5;

        if(isDefined(level.func_D127.func_4E93)) {
          level.func_D127.func_4E93 stoploopsound("jackal_debris_lp_sfx");
          level.func_D127.func_4E93 delete();
        }
      }
    }

    wait 0.1;
  }
}

func_3975() {
  var_00 = 3;
  var_01 = 4;

  foreach(var_03 in self.func_CB53) {
    var_04 = _getnumparts(var_3.model);

    for(var_05 = 0; var_05 < var_04; var_5++) {
      var_06 = _getpartname(var_3.model, var_05);

      foreach(var_09, var_08 in level.func_3979[self.type].func_7586) {
        if(issubstr(var_06, var_09)) {
          var_03 scripts\sp\utility::func_75C4(var_08, var_06, randomfloatrange(var_00, var_01));
          break;
        }
      }
    }
  }
}

func_3978(var_00) {
  if(!isDefined(var_00))
    var_00 = 0.05;

  foreach(var_02 in self.func_CB53) {
    var_03 = _getnumparts(var_2.model);

    for(var_04 = 0; var_04 < var_03; var_4++) {
      var_05 = _getpartname(var_2.model, var_04);

      foreach(var_08, var_07 in level.func_3979[self.type].func_7586) {
        if(issubstr(var_05, var_08)) {
          var_02 scripts\sp\utility::func_75F8(var_07, var_05, randomfloatrange(0, var_00));
          break;
        }
      }
    }
  }
}

func_39BE(var_00) {
  self notify("predeath");
  var_01 = 4;
  thread func_3976(var_00, var_01);
  thread func_397A(var_00, var_01);
  thread func_3973(var_00, var_01);
  wait(var_01 + 0.3);
}

func_7D02(var_00, var_01) {
  var_02 = distance(self.origin, var_00);
  var_03 = scripts\sp\math::func_C097(200, 7000, var_02);
  var_04 = scripts\sp\math::func_6A8E(0, var_01, var_03);
  var_04 = var_04 + randomfloatrange(-0.2, 0.2);

  if(var_04 < 0)
    var_04 = 0;

  return var_04;
}

func_397A(var_00, var_01) {
  if(!isDefined(self) || !isDefined(self.turrets) || self.turrets.size == 0) {
    return;
  }
  foreach(var_03 in self.turrets) {
    foreach(var_05 in var_03) {
      if(!isDefined(var_05)) {
        continue;
      }
      var_06 = var_05 func_7D02(var_00, var_01);
      var_05 thread func_12A4F(var_06);
    }
  }
}

func_3973(var_00, var_01) {
  if(!isDefined(self) || !isDefined(self.func_10381) || self.func_10381.size == 0) {
    return;
  }
  foreach(var_03 in self.func_10381) {
    if(!isDefined(var_03)) {
      continue;
    }
    var_04 = var_03 func_7D02(var_00, var_01);
    var_03 thread func_4DEA(var_04);
  }
}

func_3976(var_00, var_01) {
  if(!isDefined(self.func_EF3C)) {
    return;
  }
  foreach(var_03 in self.func_EF3C) {
    if(!isDefined(var_03)) {
      continue;
    }
    var_04 = var_03 func_7D02(var_00, var_01);
    var_03 thread func_EF37(var_04);
  }
}

func_4DEA(var_00) {
  self endon("death");
  wait(var_00);
  playFX(scripts\engine\utility::getfx("capital_dead_turret_ship_predeath"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  _playworldsound("capital_ship_turret_explode", self.origin);
}

func_12A4F(var_00) {
  self endon("death");
  wait(var_00);
  func_0BB6::func_12A06();
  thread func_0BB6::func_129DF();
}

func_EF37(var_00) {
  self endon("death");
  wait(var_00);
}

#using_animtree("vehicles");

func_3977() {
  var_00 = level.func_3979[self.func_C721];
  var_01 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_01 setModel(var_0.func_E505);
  var_01 glinton(#animtree);
  var_1.func_CB53 = [];
  var_1.type = self.func_C721;

  if(isDefined(self.func_CB55)) {
    foreach(var_03 in self.func_CB55) {
      var_04 = var_03;

      if(issubstr(var_04, "_mat_rdc")) {
        var_05 = scripts\sp\utility::strip_suffix(var_04, "_mat_rdc");
        var_06 = "tag_" + var_05;
      } else
        var_06 = "tag_" + var_04;

      var_03 = spawn("script_model", self.origin);
      var_03 setModel(var_04);
      var_03 linkto(var_01, var_06, (0, 0, 0), (0, 0, 0));
      var_1.func_CB53 = scripts\engine\utility::array_add(var_1.func_CB53, var_03);
    }
  } else {
    for(var_08 = 1; var_08 <= var_0.func_C1FB; var_8++) {
      if(var_08 < 10)
        var_09 = "0";
      else
        var_09 = "";

      var_04 = var_0.func_CB56 + var_09 + var_08;
      var_06 = "tag_" + var_04;
      var_03 = spawn("script_model", self.origin);
      var_03 setModel(var_04);
      var_03 linkto(var_01, var_06, (0, 0, 0), (0, 0, 0));
      var_1.func_CB53 = scripts\engine\utility::array_add(var_1.func_CB53, var_03);
    }
  }

  return var_01;
}

func_396F(var_00) {
  thread func_B2E5();
  func_3985(var_00);
}

func_9799(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_00))
    var_00 = 1.0;

  if(!isDefined(var_01))
    var_01 = 3.0;

  if(!isDefined(var_02))
    var_02 = 0.3;

  if(!isDefined(var_03))
    var_03 = 0.75;

  var_04 = spawnStruct();
  var_4.func_DCE5 = var_00;
  var_4.func_DCE3 = var_01;
  var_4.func_DCE4 = var_02;
  var_4.func_DCE2 = var_03;
  self.func_B797 = var_04;
}

func_3985(var_00, var_01) {
  if(!isDefined(self.func_B797))
    func_9799();

  if(var_00) {
    thread func_39BD();

    if(!isDefined(var_01) || !var_01) {
      if(isDefined(self.func_8B4F) && isDefined(self.func_8B4F["cap_hardpoint_missile_barrage"]))
        thread func_39B4();

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

  while(!isDefined(level.func_D127))
    wait 0.05;

  scripts\engine\utility::flag_init("flag_changing_capitalship_targets");
  var_00 = undefined;
  var_01 = 50000;
  var_02 = 10000;
  var_03 = 0.99;
  var_04 = 0.85;
  var_05 = 30000;
  var_06 = 25000;
  var_07 = 0.8;

  for(;;) {
    if(!scripts\sp\utility::func_D123()) {
      wait 1;
      continue;
    }

    level.func_F02D = scripts\engine\utility::array_removeundefined(level.func_F02D);

    while(level.func_F02D.size == 0)
      wait 0.05;

    var_08 = anglesToForward(level.func_D127.angles);
    var_09 = undefined;

    foreach(var_11 in level.func_F02D) {
      var_12 = var_11.origin - level.func_D127.origin;
      var_11.func_56EA = length(var_12);
      var_13 = vectornormalize(var_12);
      var_11.func_5ABB = vectordot(var_13, var_08);
      var_14 = 1 - scripts\sp\math::func_C097(0, var_06, var_11.func_56EA);
      var_15 = scripts\sp\math::func_C097(var_07, 1, var_11.func_5ABB);
      var_11.func_1153F = var_14 * var_15;

      if(var_11.func_1153F > 0) {
        if(isDefined(var_09)) {
          if(var_11.func_1153F > var_9.func_1153F)
            var_09 = var_11;
        } else
          var_09 = var_11;
      }

      var_16 = scripts\sp\math::func_C097(var_02, var_01, var_11.func_56EA);
      var_17 = scripts\sp\math::func_6A8E(var_04, var_03, var_16);

      if(var_11.func_5ABB > var_17 && var_11.func_56EA < var_01) {
        if(var_11.func_AEDF.func_3782 != "enemy_capitalship" && var_11.func_3775 == 0) {
          var_11.func_AEDF.func_3782 = "enemy_capitalship";
          var_11 func_0B76::func_F42B(var_11.func_AEDF.func_3782);
          var_11 thread func_3968(1.5);
        }

        continue;
      }

      if(var_11.func_AEDF.func_3782 != "none" && var_11.func_3775 == 0) {
        var_11.func_AEDF.func_3782 = "none";
        var_11 func_0B76::func_F42B(var_11.func_AEDF.func_3782);
        var_11 thread func_3968(1.5);
      }
    }

    if(!scripts\engine\utility::flag("flag_changing_capitalship_targets")) {
      if(isDefined(var_00)) {
        if(isDefined(var_09)) {
          if(var_09 != var_00 && var_9.func_1153F > var_0.func_1153F) {
            var_09 thread func_11308(var_00);
            var_00 = var_09;
          }
        }

        if(var_0.func_56EA > var_05) {
          var_00 thread func_DFD2();
          var_00 = undefined;
        }
      } else if(isDefined(var_09)) {
        var_09 thread func_F2F7();
        var_00 = var_09;
      }
    }

    wait 0.05;
  }
}

func_11308(var_00) {
  scripts\engine\utility::flag_set("flag_changing_capitalship_targets");
  var_00 func_0BB6::func_39C0();
  var_00 waittill("turrets_not_targetable");
  var_0.func_12A8B = 0;
  var_0.func_D436 = 0;

  if(isDefined(self) && isalive(self))
    func_F2F7();
}

func_F2F7() {
  if(!scripts\engine\utility::flag("flag_changing_capitalship_targets"))
    scripts\engine\utility::flag_set("flag_changing_capitalship_targets");

  self.func_D436 = 1;

  if(isDefined(self.func_C825))
    var_00 = self.func_C825;
  else
    var_00 = "turret_ja";

  func_0BB6::func_39CA(0, 1, var_00);
  wait 1;
  scripts\engine\utility::flag_clear("flag_changing_capitalship_targets");
}

func_DFD2() {
  self.func_D436 = 0;
  func_0BB6::func_39C0();
}

func_3968(var_00) {
  self endon("death");
  self notify("new_callout_timer");
  self endon("new_callout_timer");

  for(self.func_3775 = var_00; self.func_3775 > 0; self.func_3775 = self.func_3775 - 0.05)
    wait 0.05;

  self.func_3775 = 0;
}

func_52FD() {
  self.func_B89E = 15000;
  self.func_B89F = 5000;
  self.func_B89B = 25000;
  self.func_B89C = 0.9;
  self.func_B89D = 1.0;
  self.func_B8A3 = 30000;
  self.func_B8A0 = 18000;
  self.func_B8A1 = 0.8;
  self.func_B8A2 = 3.0;
  self.func_B89A = 1;
  self.func_B899 = 1;
}

func_B862() {
  self.func_B89E = 15000;
  self.func_B89F = 5000;
  self.func_B89B = 25000;
  self.func_B89C = 0.9;
  self.func_B89D = 1.0;
  self.func_B8A3 = 30000;
  self.func_B8A0 = 18000;
  self.func_B8A1 = 0.8;
  self.func_B8A2 = 3.0;
  self.func_B89A = 1;
  self.func_B899 = 1;
}

func_F2F5(var_00) {
  self.func_38B5 = var_00;
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

    var_00 = undefined;

    if(func_9C74() && func_396B())
      var_00 = level.func_D127;

    if(isDefined(var_00)) {
      if(func_396A(var_00, self.func_9278)) {
        func_3987(var_00);
        continue;
      }

      if(func_3969(var_00) && var_00 == level.func_D127) {
        var_01 = distance(self.origin, level.func_D127.origin);
        var_02 = anglestoright(self.angles);
        var_03 = anglestoup(self.angles);
        var_04 = vectornormalize(level.func_D127.origin - self.origin);
        var_05 = vectordot(var_02, var_04);
        var_06 = vectordot(var_03, var_04);
        func_0BB6::func_399F(var_01, var_05, var_06);
      }
    }
  }
}

func_3987(var_00) {
  self endon("death");
  self endon("predeath");
  var_01 = anglestoright(self.angles);
  var_02 = anglestoup(self.angles);
  var_03 = vectornormalize(var_0.origin - self.origin);
  var_04 = vectordot(var_01, var_03);
  var_05 = vectordot(var_02, var_03);
  self.func_8B50["cap_hardpoint_missile_barrage"] = scripts\engine\utility::array_removeundefined(self.func_8B50["cap_hardpoint_missile_barrage"]);
  self.func_8B51["cap_hardpoint_missile_barrage"] = scripts\engine\utility::array_removeundefined(self.func_8B51["cap_hardpoint_missile_barrage"]);

  if(var_04 < 0)
    var_06 = self.func_8B50["cap_hardpoint_missile_barrage"];
  else
    var_06 = self.func_8B51["cap_hardpoint_missile_barrage"];

  if(!isDefined(var_06)) {
    return;
  }
  if(var_6.size == 0) {
    if(var_04 < 0)
      var_06 = self.func_8B51["cap_hardpoint_missile_barrage"];
    else
      var_06 = self.func_8B50["cap_hardpoint_missile_barrage"];

    if(var_6.size == 0)
      return;
  }

  thread func_0BB6::func_39A0(var_00, var_06, 5);
  self.func_A8EA = gettime();

  if(isDefined(self.func_B89A) && isDefined(self.func_B899)) {
    if(self.func_B89A == self.func_B899)
      var_07 = self.func_B89A * 1000;
    else
      var_07 = randomfloatrange(self.func_B89A, self.func_B899) * 1000;

    self.func_B83F = var_07;
  }

  while(level.func_D127.func_93D2.size > 0)
    wait 0.05;
}

func_396B() {
  if(!isDefined(level.func_D127))
    return 0;

  if(level.func_D127.func_58B5)
    return 0;

  if(func_0B76::func_7B95() > 0)
    return 0;

  return 1;
}

func_396A(var_00, var_01) {
  if(!isDefined(var_00))
    return 0;

  var_02 = gettime() - self.func_A8EA;

  if(var_02 < self.func_B83F)
    return 0;

  if(isDefined(self.func_38B5) && ![[self.func_38B5]]())
    return 0;

  if(isDefined(level.func_D127) && var_00 == level.func_D127) {
    if(level.func_A056.func_68B3.running)
      return 0;

    if(!isDefined(var_01) || !var_01) {
      if(!level.player scripts\sp\utility::func_65DB("jackal_enemy_homing_missile_allowed"))
        return 0;
    } else if(!level.player scripts\sp\utility::func_65DB("jackal_enemy_homing_missile_allowed_hyperaggressive"))
      return 0;
  }

  return 1;
}

func_3969(var_00) {
  if(isDefined(level.func_D127) && isDefined(var_00) && var_00 == level.func_D127 && func_0B76::func_7B95() > 0)
    return 0;

  return 1;
}

func_9C74() {
  if(!scripts\sp\utility::func_65DF("player_is_near"))
    return 0;

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
  var_00 = undefined;

  for(;;) {
    if(self.func_5ABB >= self.func_B89C) {
      if(isDefined(var_00)) {
        if(gettime() - self.func_B89D * 1000 >= var_00)
          scripts\sp\utility::func_65E1("missiles_player_looking");
      } else
        var_00 = gettime();
    } else {
      scripts\sp\utility::func_65DD("missiles_player_looking");
      var_00 = undefined;
    }

    wait 0.05;
  }
}

func_FF47() {
  for(;;) {
    if(!isDefined(level.func_D127)) {
      scripts\sp\utility::func_65DD("missiles_player_close_force");
      scripts\sp\utility::func_65DD("missiles_player_close");
      wait 0.05;
      continue;
    }

    var_00 = abs(self.origin[2] - level.func_D127.origin[2]);

    if(self.func_56EA <= self.func_B89E && var_00 <= self.func_B89F)
      scripts\sp\utility::func_65E1("missiles_player_close_force");
    else
      scripts\sp\utility::func_65DD("missiles_player_close_force");

    if(self.func_56EA <= self.func_B89B)
      scripts\sp\utility::func_65E1("missiles_player_close");
    else
      scripts\sp\utility::func_65DD("missiles_player_close");

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
  var_00 = undefined;

  for(;;) {
    if(self.func_5ABB < self.func_B8A1) {
      if(isDefined(var_00)) {
        if(gettime() - self.func_B8A2 * 1000 >= var_00)
          scripts\sp\utility::func_65DD("missiles_player_looking");
      } else
        var_00 = gettime();
    } else {
      scripts\sp\utility::func_65E1("missiles_player_looking");
      var_00 = undefined;
    }

    wait 0.05;
  }
}

func_FF6D() {
  self endon("should_not_fire_missiles");
  self endon("death");

  for(;;) {
    if(self.func_56EA >= self.func_B8A3)
      scripts\sp\utility::func_65E1("missiles_player_far_force");
    else
      scripts\sp\utility::func_65DD("missiles_player_far_force");

    if(self.func_56EA >= self.func_B8A0)
      scripts\sp\utility::func_65DD("missiles_player_close");
    else
      scripts\sp\utility::func_65E1("missiles_player_close");

    wait 0.05;
  }
}

func_12A1E() {
  self endon("disable_combat");
  self endon("death");
  self endon("player_not_near");

  for(;;) {
    var_00 = 0;

    if(!scripts\sp\utility::func_D123()) {
      wait 1;
      continue;
    }

    var_01 = distance(level.func_D127.origin, self.origin);

    if(var_01 < 18000 && randomint(100) < 90)
      var_00 = 1;

    if(var_01 <= 8000)
      var_00 = 1;

    if(scripts\sp\utility::func_7B9D() <= 0.1)
      var_00 = 0;
    else if(scripts\sp\utility::func_7B9D() >= 0.6)
      var_00 = 1;

    self.func_1D62 = var_00;
    self.func_11578 = var_00;
    wait 3;
  }
}

func_39D6(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(isDefined(level.func_A056))
    self[[level.func_A056.func_A16E]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, 0);
}

func_EA01() {
  if(isDefined(self))
    self delete();
}

func_EA02(var_00) {
  if(isDefined(var_00)) {
    foreach(var_02 in var_00)
    var_02 func_EA01();
  }
}

func_DFE9(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    if(!isDefined(var_03) || !_isstruct(var_03) && !isalive(var_03)) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  return var_01;
}