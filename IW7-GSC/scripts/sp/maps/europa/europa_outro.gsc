/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\maps\europa\europa_outro.gsc
***************************************************/

func_C7C6() {
  setdvarifuninitialized("outro_nohelmet", "0");
  setdvarifuninitialized("new_dof", "1");
  var_0 = getent("nrg_weapon", "targetname");
  var_0 delete();
  precachemodel("vm_hero_protagonist_helmet_glass_crack_clear");
  precachemodel("vm_hero_protagonist_helmet_glass_crack_01_clear");
  precachemodel("vm_hero_protagonist_helmet_glass_crack_02_clear");
  precachemodel("vm_hero_protagonist_helmet_glass_crack_03_clear");
  precachemodel("veh_mil_air_ca_olympus_mons");
  precachemodel("veh_mil_air_ca_olympus_mons_detail_01");
  precachemodel("oxygen_bottle_air_boss");
  precachemodel("helmet_hero_sipes_crushed");
  precachemodel("helmet_hero_t_crushed");
  thread func_FC0E();
  level._effect["kotch_muzzleflash"] = loadfx("vfx\iw7\core\muzflash\emc\vfx_muz_emc_v.vfx");
  var_1 = [];
  var_1[var_1.size] = getent("outro_dropship_static", "targetname");
  var_1[var_1.size] = getent("outro_mons", "targetname");
  var_2 = getent("outro_tram_brushmodel", "targetname");
  var_1[var_1.size] = var_2;
  var_1 = scripts\engine\utility::array_combine(var_1, getEntArray(var_2.target, "targetname"));
  foreach(var_4 in var_1) {
    var_4 hide();
    var_4 notsolid();
  }

  scripts\engine\utility::flag_init("outro_freeze");
  scripts\engine\utility::flag_init("helmet_critical_paused");
  scripts\engine\utility::flag_init("pause_dynamic_dof");
  thread func_94FB();
}

func_C7D3() {
  scripts\sp\maps\europa\europa_util::func_107C5();
  level.player takeallweapons();
  level.player setclientomnvar("ui_hide_hud", 1);
  scripts\engine\utility::flag_set("start_decompress_player");
  setdvar("skip_outro", "0");
  var_0 = scripts\sp\hud_util::func_7B4F();
  var_0.alpha = 1;
  level.player _meth_82C0("europa_suck_out_hit_fade_to_black", 0);
  setmusicstate("");
  scripts\engine\utility::flag_set("player_holding_on");
  thread scripts\sp\maps\europa\europa_util::func_67B6(1, "done", &"EUROPA_OBJECTIVE_ACCESS");
  thread scripts\sp\maps\europa\europa_util::func_67B6(2, "done", &"EUROPA_OBJECTIVE_FSPAR");
  thread scripts\sp\maps\europa\europa_util::func_67B6(3, "current", &"EUROPA_OBJECTIVE_ESCAPE");
}

func_94FB() {
  var_0 = scripts\engine\utility::array_combine(getEntArray("europa_lights_outro_1", "targetname"), getEntArray("europa_lights_outro_2", "targetname"));
  if(!var_0.size) {
    return;
  }

  foreach(var_2 in var_0) {
    var_2.var_99E5 = var_2 _meth_8134();
    var_2.color = var_2 _meth_8131();
    var_2 setlightintensity(0);
  }
}

func_6222() {
  var_0 = scripts\engine\utility::array_combine(getEntArray("europa_lights_outro_1", "targetname"), getEntArray("europa_lights_outro_2", "targetname"));
  if(!var_0.size) {
    return;
  }

  foreach(var_2 in var_0) {
    if(isDefined(var_2.var_99E5)) {
      var_2 setlightintensity(var_2.var_99E5);
      continue;
    }

    if(isDefined(self.script_intensity_01)) {
      var_2 setlightintensity(var_2.script_intensity_01);
    }
  }
}

func_C7B4() {
  wait(2.5);
  setomnvar("ui_show_compass", 0);
  scripts\engine\utility::delaythread(0.6, ::func_6222);
  visionsetnaked("europa_outro", 1);
  var_0 = getdvarint("skip_outro");
  scripts\sp\utility::func_28D7();
  physics_setgravity((0, 0, -386.09));
  thread func_ABE1();
  setsaveddvar("r_mbRadialoverridechromaticAberration", 0);
  setsaveddvar("r_mbradialoverridestrength", 0);
  setglobalsoundcontext("storm", "storm_ext", 1);
  setglobalsoundcontext("atmosphere", "helmet", 1);
  scripts\engine\utility::exploder("outro_amb_fx");
  var_1 = getent("intro_surface_vista_01", "targetname");
  var_1 show();
  scripts\sp\maps\europa\europa_util::toggle_cockpit_lights(0);
  if(getdvarint("debug_europa")) {
    level.var_37CE = 0;
  }

  if(!var_0) {
    func_11628();
    func_EBEA();
  }

  level notify("end_europa_mission");
  scripts\sp\utility::func_BF95();
}

func_ABE1() {
  scripts\sp\utility::func_1264E("europa_fatty_tr");
  wait(0.05);
  thread scripts\sp\utility::func_BF97();
}

func_EBEA() {
  level.var_C7BD = [];
  setsaveddvar("r_mbenable", "0");
  var_0 = scripts\sp\utility::func_22CD("outro_enemies", 1);
  var_1 = [];
  foreach(var_3 in var_0) {
    if(var_3.var_1FBB == "sdf1") {
      var_3 scripts\sp\utility::func_72EC("iw7_m4", "primary");
      var_3.a.nodeath = 1;
      var_1[var_1.size] = var_3;
      level.var_C7D2 = var_3;
      continue;
    } else if(var_3.var_1FBB == "sdf2") {
      var_3 scripts\sp\utility::func_72EC("iw7_m4", "primary");
      var_1[var_1.size] = var_3;
      var_3 scripts\sp\utility::func_F6FE("vignette");
      var_3 lib_0A1E::func_2318();
      continue;
    } else {
      if(var_3.var_1FBB == "kotch") {
        var_3 scripts\sp\utility::func_86E4();
        level.var_A70E = var_3;
        level.var_C7BD[level.var_C7BD.size] = var_3;
        continue;
      }

      if(var_3.unittype == "c6" || var_3.var_1FBB == "sdf4") {
        level.var_C7BD[level.var_C7BD.size] = var_3;
        var_3 scripts\sp\utility::func_72EC("iw7_m4", "primary");
        continue;
      }

      if(var_3.var_1FBB == "sdf3") {
        level.var_C7C1 = var_3;
      }
    }
  }

  foreach(var_6 in level.var_EBCA) {
    var_6 scripts\engine\utility::delaythread(0.5, ::scripts\sp\utility::func_86E4);
  }

  var_8 = 0;
  if(scripts\sp\utility::func_93A6()) {
    scripts\sp\specialist_MAYBE::func_F52F(1);
    level.player.helmet = level.var_10964.helmet;
  }

  if(!var_8) {
    level.player.helmet notsolid();
    level.player.helmet _meth_83CB(level.player);
    level.player.helmet setModel("vm_hero_protagonist_helmet_glass_crack_01_clear");
    level.player.helmet _meth_81E2(level.player, "tag_playerhelmet", (-2, 0, 0), (12, 0, 0), 1, "view_jostle");
    lib_0E4B::func_8E0A();
  }

  var_9 = scripts\engine\utility::getstruct("outro_anim_spot", "targetname");
  level.player thread scripts\sp\maps\europa\europa_util::func_8E34(1);
  thread scripts\sp\maps\europa\europa_util::func_8E46(1);
  level.var_A70E attach("oxygen_bottle_air_boss", "tag_accessory_right");
  thread func_C7C9();
  scripts\engine\utility::array_thread(level.var_EBCA, ::scripts\sp\utility::func_DC45, "lower");
  level.player.var_E505 = scripts\sp\player_rig::get_player_score(1);
  var_1[var_1.size] = level.player.var_E505;
  var_1[var_1.size] = level.var_EBBB;
  var_1[var_1.size] = level.var_EBBC;
  level.player.var_E505 setModel("viewmodel_un_jackal_pilots_frost");
  level.player.var_8632 = spawn("script_origin", level.player.origin);
  level.player.var_8632 linkto(level.player.var_E505, "tag_player", (0, 0, 0), (0, 0, 0));
  level.player takeallweapons();
  level.player getradiuspathsighttestnodes();
  level.player getrawbaseweaponname(0.2, 0.2);
  level.player givefriendlyperks(5, 5, 5, 5, 1);
  level.player playerlinktodelta(level.player.var_E505, "tag_player", 1, 0, 0, 0, 0, 1);
  var_0A = getdvarint("skip_outro_fadeup");
  var_9 scripts\sp\anim::func_1EC1(var_1, "outro");
  if(!var_0A) {
    wait(1);
  }

  thread func_FB84();
  level.player _meth_82C0("europa_wake_up_scene", 12);
  wait(8);
  thread func_912F();
  level.player scripts\engine\utility::delaycall(4.5, ::setclientomnvar, "ui_hide_hud", 0);
  thread scripts\sp\hud_util::func_6A99(8);
  thread func_C7BC();
  setmusicstate("mx_173_cine_europaoutro");
  level.player.var_8632 = spawn("script_origin", level.player.origin);
  level.player.var_8632 linkto(level.player.var_E505, "tag_player", (0, 0, 0), (0, 0, 0));
  level.player.var_E505 thread func_D20A(var_9);
  thread func_C7D7();
  level.player giveplayerscore(1, 1, 1);
  level.player lerpviewangleclamp(3, 1.5, 1.5, 20, 20, 20, 20);
  var_9 thread scripts\sp\anim::func_1F2C(var_1, "outro");
  scripts\engine\utility::noself_delaycall(112, ::objective_state, 3, "failed");
  scripts\engine\utility::flag_wait("outro_freeze");
  level.player _meth_82C0("europa_end_cut_hard", 0.05);
}

func_DB9C() {
  wait(0.05);
}

func_912F() {
  thread scripts\sp\hud::func_8DFD(2, 1);
  thread scripts\sp\hud::func_8DFF(-280, 1);
  level.player waittill("o2_in");
  thread scripts\sp\hud::func_8DFD(7, 10);
  level.player waittill("o2_out");
  thread scripts\sp\hud::func_8DFD(0, 1);
}

func_C7D7() {
  if(getdvarint("new_dof")) {
    thread func_BF03();
    return;
  }

  thread func_584C();
  wait(0.05);
  func_F4B0(30, 0.1);
}

func_BF03() {
  scripts\sp\art::func_583F(0, 60, 1, 0, 0, 0, 0.5);
  level.player waittill("kotch_intro");
  level waittill("kotch_kneel");
  scripts\sp\art::func_583F(0, 0, 0, 53, 88, 1.28, 1);
  level waittill("look_at_friendlies");
  scripts\sp\art::func_583D(1.5);
  level waittill("kotch_stands");
  level waittill("kotch_kneel2");
  scripts\sp\art::func_583F(0, 0, 0, 53, 88, 1.5, 2);
  level.player waittill("o2_out");
  scripts\sp\art::func_583D(0.5);
  level.player waittill("connor");
  scripts\sp\art::func_583F(0, 35, 3, 0, 0, 0, 2);
}

func_584C() {
  level endon("stop_dof_target_thread");
  var_0 = spawn("script_origin", level.player getEye());
  level.var_584B = level.var_EBBB;
  var_1 = vectornormalize(level.var_584B gettagorigin("j_neck") - level.player getEye());
  var_0.origin = level.player getEye() + var_1 * 2;
  level.var_5840 = var_0;
  wait(5);
  var_0 thread func_5841();
  var_2 = scripts\engine\utility::array_combine(level.var_C7BD, level.var_EBCA);
  for(;;) {
    var_3 = level.player getplayerangles();
    var_4 = level.player getEye();
    var_5 = func_77D9(level.var_584B, var_4, var_3);
    var_6 = scripts\engine\utility::array_remove(var_2, level.var_584B);
    var_7 = level.var_584B;
    foreach(var_9 in var_2) {
      if(!isalive(var_9)) {
        continue;
      }

      var_0A = func_77D9(var_9, var_4, var_3);
      if(var_0A > var_5) {
        var_7 = var_9;
        var_5 = var_0A;
      }
    }

    level.var_584B = var_7;
    wait(0.05);
  }
}

func_77D9(var_0, var_1, var_2) {
  var_3 = var_0 gettagorigin("j_neck");
  var_4 = vectornormalize(var_3 - var_1);
  var_5 = anglesToForward(var_2);
  return vectordot(var_5, var_4);
}

func_5841() {
  level notify("stop_dof_ent_thread");
  level endon("stop_dof_ent_thread");
  var_0 = 15;
  var_1 = squared(8);
  var_2 = 1;
  for(;;) {
    scripts\engine\utility::flag_waitopen("pause_dynamic_dof");
    var_3 = level.var_584B gettagorigin("j_neck");
    var_4 = vectornormalize(var_3 - self.origin);
    if(distancesquared(self.origin, var_3) > var_1) {
      self.origin = self.origin + var_4 * var_0;
      var_2 = distance(self.origin, level.player getEye());
    }

    var_5 = 0;
    if(isDefined(level.var_584B) && level.var_584B == level.var_A70E) {
      var_5 = 1;
    }

    func_F4B0(var_2, 0, var_5);
    wait(0.05);
  }
}

func_F4B0(var_0, var_1, var_2) {
  level endon("pause_dynamic_dof");
  var_3 = 1;
  var_4 = 0.1;
  var_5 = 0.28;
  var_6 = 0.85;
  var_7 = 1.5;
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(var_2) {
    var_8 = var_0 * 0.7;
  } else {
    var_8 = var_1 * 0.2;
  }

  var_9 = var_0 * 1.15;
  if(isDefined(level.var_5844)) {
    var_8 = var_8 * 0.5;
  }

  if(var_8 < 1) {
    var_8 = 1;
  }

  if(var_9 < var_0) {
    var_9 = var_0;
  }

  var_0A = var_8 * var_5;
  var_0B = var_9 + 150;
  scripts\sp\art::func_583F(var_0A, var_8, var_3, var_9, var_0B, var_4, var_1);
}

func_D20A(var_0) {
  for(;;) {
    self waittill("single anim", var_1);
    if(isstring(var_1)) {
      var_1 = [var_1];
    }

    foreach(var_3 in var_1) {
      switch (var_3) {
        case "start_anim_kotch":
          level.player notify("kotch_intro");
          func_C7BD(var_0);
          break;

        case "start_anim_sdf03":
          func_C7C0(var_0);
          break;

        case "cam_lock_on":
          func_CFA4();
          break;

        case "cam_lock_off":
          func_CFA5();
          break;
      }
    }
  }
}

func_CFA4() {
  level.player lerpviewangleclamp(0.25, 0.25, 0, 0, 0, 0, 0);
}

func_CFA5() {
  level.player lerpviewangleclamp(0.5, 0.5, 0, 20, 20, 20, 20);
}

func_C06D() {
  level.player lerpviewangleclamp(0.5, 0.5, 0, 20, 0, 20, 20);
}

func_C7BD(var_0) {
  level.var_A70E scripts\sp\utility::func_72EC("iw7_nrg", "primary");
  level.var_A70E scripts\anim\shared::placeweaponon("iw7_nrg", "left");
  var_1 = scripts\sp\utility::func_10639("kotch_gun", level.var_A70E.origin);
  level.var_A70E.var_1FB6 = var_1;
  var_2 = level.var_C7BD;
  var_2[var_2.size] = var_1;
  scripts\engine\utility::delaythread(8, ::func_C06D);
  scripts\engine\utility::delaythread(11, ::func_CFA5);
  var_3 = scripts\sp\maps\europa\europa_util::func_5F32(var_0);
  wait(0.05);
  var_3 thread scripts\sp\anim::func_1F2C(var_2, "outro");
}

func_C7C0(var_0) {
  var_1 = scripts\sp\maps\europa\europa_util::func_5F32(var_0);
  level.var_C7C1 scripts\sp\utility::func_86E4();
  var_2 = scripts\sp\utility::func_10639("flag");
  var_3 = [level.var_C7C1, var_2];
  var_1 thread scripts\sp\anim::func_1F2C(var_3, "outro");
}

func_C7C9() {
  var_0 = getent("outro_mons", "targetname");
  var_0 show();
  var_0 attach("veh_mil_air_ca_olympus_mons_detail_01", "tag_origin");
  var_0 attach("veh_mil_air_ca_olympus_mons", "tag_origin");
  var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_0 scripts\engine\utility::delaycall(15, ::moveto, var_1.origin, 60, 0, 10);
  var_0.var_5020 = "idle";
  var_0.var_501F = "idle";
  playFXOnTag(scripts\engine\utility::getfx("mons_thrust_bottom_front_idle"), var_0, "tag_engine_bottom_front");
  playFXOnTag(scripts\engine\utility::getfx("mons_thrust_bottom_middle_idle"), var_0, "tag_engine_bottom_front");
  playFXOnTag(scripts\engine\utility::getfx("mons_thrust_bottom_rear_idle"), var_0, "tag_engine_bottom_rear");
  playFXOnTag(scripts\engine\utility::getfx("mons_thrust_rear_idle"), var_0, "tag_engine_rear");
}

func_BA4A(var_0) {}

func_C7BC() {
  var_0 = getent("outro_dropship_static", "targetname");
  var_0 show();
  var_0 thread func_5E0B();
  wait(22);
  var_1 = scripts\sp\vehicle::func_1080C("outro_dropship");
  var_1.var_55A4 = 1;
  var_1 notsolid();
  foreach(var_3 in var_1.mgturret) {
    var_3 notsolid();
  }

  wait(1);
  var_1 scripts\sp\vehicle_paths::setsuit();
}

func_5E0B() {
  thread func_5E0C();
  thread func_5E0E();
  var_0 = self.origin;
  var_1 = 4;
  var_2 = 5;
  var_3 = -20;
  var_4 = 20;
  var_5 = -20;
  var_6 = 20;
  var_7 = -20;
  var_8 = 20;
  for(;;) {
    var_9 = randomfloatrange(var_3, var_4);
    var_0A = randomfloatrange(var_5, var_6);
    var_0B = randomfloatrange(var_7, var_8);
    var_0C = var_0 + (var_9, var_0A, var_0B);
    var_0D = randomfloatrange(var_1, var_2);
    self moveto(var_0C, var_0D, var_0D * 0.5, var_0D * 0.5);
    wait(var_0D);
    var_9 = randomfloatrange(var_3, var_4);
    var_0A = randomfloatrange(var_5, var_6);
    var_0B = randomfloatrange(var_7, var_8) * -1;
    var_0C = var_0 + (var_9, var_0A, var_0B);
    var_0D = randomfloatrange(var_1, var_2);
    self moveto(var_0C, var_0D, var_0D * 0.5, var_0D * 0.5);
    wait(var_0D);
  }
}

func_5E0C() {
  var_0 = scripts\engine\utility::getfx("axis_dropship_thrust_landed");
  var_1 = ["tag_front_thruster_1_le", "tag_front_thruster_2_le", "tag_front_thruster_1_ri", "tag_front_thruster_2_ri"];
  var_2 = ["tag_back_thruster_1_le", "tag_back_thruster_2_le", "tag_back_thruster_1_ri", "tag_back_thruster_2_ri"];
  var_3 = ["tag_back_thruster_3_le", "tag_back_thruster_4_le", "tag_back_thruster_3_ri", "tag_back_thruster_4_ri"];
  var_4 = ["tag_front_thruster_1_le", "tag_front_thruster_1_ri", "tag_back_thruster_1_le", "tag_back_thruster_1_ri"];
  func_5E0D(var_1, var_0);
  wait(0.1);
  func_5E0D(var_2, var_0);
  wait(0.1);
  func_5E0D(var_3, var_0);
  wait(0.1);
  func_5E0D(var_4, var_0);
}

func_5E0D(var_0, var_1) {
  foreach(var_3 in var_0) {
    playFXOnTag(var_1, self, var_3);
  }
}

func_5E0E() {
  var_0 = self.origin;
  var_1 = self.angles[1];
  var_2 = 0;
  var_3 = -5;
  var_4 = 5;
  var_5 = 10;
  var_6 = 15;
  for(;;) {
    var_7 = randomfloatrange(var_5, var_6);
    var_8 = randomfloatrange(0, var_4);
    var_9 = var_2 * -1;
    var_0A = var_8 + var_9;
    self rotateyaw(var_0A, var_7, var_7 * 0.5, var_7 * 0.5);
    var_2 = var_0A;
    wait(var_7);
    var_7 = randomfloatrange(var_5, var_6);
    var_8 = randomfloatrange(var_3, 0);
    var_9 = var_2 * -1;
    var_0A = var_8 + var_9;
    self rotateyaw(var_0A, var_7, var_7 * 0.5, var_7 * 0.5);
    var_2 = var_0A;
    wait(var_7);
  }
}

func_EBEF() {
  var_0 = 3;
  wait(level.var_C7D5 - var_0);
  thread scripts\sp\hud_util::func_6AA3(var_0);
  waittillframeend;
  var_1 = scripts\sp\hud_util::func_7B4F();
  var_1.foreground = 0;
  wait(var_0);
}

func_8E0B() {
  level endon("outro_freeze");
  level.var_8E0F = "critical";
  var_0["critical"] = "europa_cmp_oxygenlevelcrit";
  var_0["depleted"] = "europa_cmp_oxygendepleted";
  var_0["good"] = "DONT HAVE ANYTHING!";
  var_1 = 5000;
  var_2 = "critical";
  var_3 = 0;
  var_4["critical"] = 500;
  var_4["depleted"] = 200;
  var_4["good"] = 99999;
  for(;;) {
    if(var_2 != level.var_8E0F) {
      var_2 = level.var_8E0F;
      var_1 = gettime() + 500;
      var_3 = gettime() + var_4[level.var_8E0F];
      if(level.var_8E0F == "good") {
        var_3 = 999999;
        var_1 = 999999;
      }
    }

    if(gettime() > var_1) {
      var_1 = gettime() + 6000;
      thread scripts\sp\utility::func_10350(var_0[level.var_8E0F]);
    }

    if(gettime() > var_3) {
      level.player playSound("helmet_critical_beep");
      var_3 = gettime() + var_4[level.var_8E0F];
    }

    wait(0.05);
  }
}

func_11628() {
  var_0 = [level.player, level.var_EBBB, level.var_EBBC];
  if(level.player islinked()) {
    level.player unlink(1);
  }

  var_1 = scripts\engine\utility::getstructarray("outro_spot", "targetname");
  foreach(var_3 in var_1) {
    foreach(var_5 in var_0) {
      if(isplayer(var_5) && var_3.script_noteworthy == "player") {
        var_5 setorigin(var_3.origin);
        var_5 setplayerangles(var_3.angles);
        var_5 freezecontrols(1);
        break;
      } else if(isai(var_5) && var_3.script_noteworthy == var_5.script_noteworthy) {
        var_5 _meth_80F1(var_3.origin);
        var_5 give_mp_super_weapon(var_3.origin);
        break;
      }
    }
  }
}

func_D906() {}

func_FC0E() {
  soundsettimescalefactor("scn_fx_unres_2d", 0);
  soundsettimescalefactor("scn_fx_unres_3d", 0);
  soundsettimescalefactor("plr_ui_ingame_unres_2d", 0);
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
}

func_FB84() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkto(level.player);
  var_1 = spawn("script_origin", level.player.origin);
  var_1 linkto(level.player);
  var_0 thread func_FB47();
  var_1 thread func_FB33();
  level.player playSound("scn_europa_outro_fadeup");
  wait(13.1);
  level.player notify("o2_lvl_2");
  wait(11);
  level.player notify("o2_lvl_3");
  level.player waittill("o2_in");
  level.player playSound("scn_europa_outro_air_swt_01");
  wait(0.1);
  level.player playSound("scn_europa_outro_air_hookup");
  level.player waittill("o2_out");
  wait(0.2);
  level.player playSound("scn_europa_outro_air_detach");
  wait(8);
  level.player notify("o2_lvl_4");
}

func_FB33() {
  scripts\sp\utility::func_10461("plr_helmet_air_leak_lp", 1, 4, 1);
  level.player waittill("o2_in");
  self stoploopsound();
  level.player waittill("o2_out");
  scripts\engine\utility::delaythread(11, ::scripts\sp\utility::func_10461, "plr_helmet_air_leak_lp", 1, 2, 1);
  level.player waittill("sfx_beep_fade");
  scripts\sp\utility::func_10460(1);
}

func_FB47() {
  scripts\sp\utility::func_10461("plr_helmet_o2_level_ok_lp", 1, 4, 1);
  wait(6);
  level.player thread scripts\sp\utility::func_10350("europa_cmp_oxygendepleted");
  level.player waittill("o2_lvl_2");
  self stoploopsound();
  self playLoopSound("plr_helmet_o2_level_low_lp");
  thread scripts\sp\utility::func_10350("europa_cmp_oxygendepleted");
  level.player waittill("o2_lvl_3");
  thread scripts\sp\utility::func_10350("europa_cmp_oxygenlevelcrit");
  wait(1);
  self stoploopsound();
  self playLoopSound("plr_helmet_o2_level_critical_lp");
  wait(4.1);
  thread scripts\sp\utility::func_10350("europa_cmp_oxygenlevelcrit");
  wait(8);
  thread scripts\sp\utility::func_10350("europa_cmp_oxygenlevelcrit");
  level.player waittill("o2_in");
  self stoploopsound();
  level.player waittill("o2_out");
  wait(0.6);
  scripts\sp\utility::func_10461("plr_helmet_o2_level_low_lp", 1, 2, 1);
  wait(2);
  thread scripts\sp\utility::func_10350("europa_cmp_oxygendepleted");
  level.player waittill("o2_lvl_4");
  thread scripts\sp\utility::func_10350("europa_cmp_oxygenlevelcrit");
  self stoploopsound();
  self playLoopSound("plr_helmet_o2_level_critical_lp");
  level.player waittill("sfx_beep_fade");
  scripts\sp\utility::func_10460(1);
}