/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\finale.gsc
********************************************/

_id_6C54() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("finale_start_player");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("finale_start", ["Salter"]);
  scripts\sp\maps\rogue\civilians::_id_FA4B();
  level._id_71B0 = scripts\sp\utility::_id_22CD("civ_fnl");
  level._id_71B3 = scripts\sp\utility::_id_22CD("civ_fnl_guard");
  level._id_71B4 = [scripts\sp\utility::_id_107EA("civ_fnl_owens"), scripts\sp\utility::_id_107EA("civ_fnl_jones")];
  scripts\engine\utility::array_thread(level._id_71B4, scripts\sp\utility::_id_B14F);
  thread _id_33B3();
}

_id_F0D1() {
  precacheitem("iw7_ar57+reflex+silencer");
  precachemodel("veh_mil_air_ca_dropship_turret_nodraw");
  precacheturret("fighter_spotlight");
  precachemodel("robot_c6");
  precachemodel("tag_laser");
  precachemodel("robot_c6_maintenance_low");
}

_id_F0CB() {
  scripts\engine\utility::flag_init("flag_fnl_start");
  scripts\engine\utility::flag_init("flag_fnl_open_roof");
  scripts\engine\utility::flag_init("flag_fnl_scene");
  scripts\engine\utility::flag_init("flag_fnl_player_fall");
  scripts\engine\utility::flag_init("flag_fnl_move_robots");
  scripts\engine\utility::flag_init("flag_fnl_second_explo");
  scripts\engine\utility::flag_init("finale_dropship_landed");
  scripts\engine\utility::flag_init("finale_dropship_enroute");
  scripts\engine\utility::flag_init("spawn_finale_workers");
  scripts\engine\utility::flag_init("spawn_finale_security");
  scripts\engine\utility::flag_init("finale_scene_start");
  scripts\engine\utility::flag_init("finale_scene_end");
  scripts\engine\utility::flag_init("hangar_lockdown");
  scripts\engine\utility::flag_init("dropship_departs");
  scripts\engine\utility::flag_init("drag_start");
  scripts\engine\utility::flag_init("omar_down");
  scripts\engine\utility::flag_init("fnl_player_out_of_bounds");
  scripts\engine\utility::flag_init("finale_extra_damage_for_cheesin");
  scripts\engine\utility::flag_init("toggle_finale_drag_light");
  scripts\engine\utility::flag_init("civ_back_blocker_set");
  scripts\engine\utility::flag_init("dont_update_sun_on_restart");
}

_id_F0D2() {}

_id_6C45() {
  thread _id_6C3A();
  thread _id_12E35();
  thread finale_player_push();

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  thread flag_if_civ_back_blocked();
  thread _id_6A45();
  var_0 = [1, 0.25, 0.09];
  level._id_111C3.light = 30 * vectorNormalize((var_0[0], var_0[1], var_0[2]));
  setsunlight(level._id_111C3.light[0], level._id_111C3.light[1], level._id_111C3.light[2]);
  level._id_111C3.ent linkTo(level._id_111C3._id_C6EA, "tag_origin", (17000, 40000, 0), (0, 0, 0));
  level._id_111C3._id_1EF6 linkTo(level._id_111C3._id_E6E5, "tag_origin", (0, 0, 0), (-80, 0, 240));
  scripts\sp\maps\rogue\rogue_util::_id_111E7(13, 400, 30, 150, 220);
  scripts\sp\maps\rogue\rogue_util::_id_111E8(7.5, 15.5, 1);
  scripts\engine\utility::flag_clear("sun_vision_blend");
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12958);
  scripts\sp\utility::_id_22CA("final_swarm", ::_id_6C2A);
  scripts\engine\utility::flag_set("flag_fnl_start");
  scripts\engine\utility::flag_set("flag_lgt_finale_start");
  thread _id_134D6();
  setglobalsoundcontext("atmosphere", "helmet", 1);
  var_1 = getEnt("org_cvl_anim", "targetname");
  var_2 = getEnt("button_fnl_roof", "targetname");
  var_3 = getEnt("door_fnl_window", "targetname");
  thread _id_6C44();
  level._id_5D97 = getEnt("dropship_col_ramp", "targetname");
  level._id_5D97._id_4578 = getEnt("dropship_col_ramp_container", "targetname");
  level._id_5D97.origin = level._id_5D97.origin + (0, 0, 1000);
  level._id_5D97._id_4578.origin = level._id_5D97._id_4578.origin + (0, 0, 1000);
  level._id_5D97 notsolid();
  level._id_5D97._id_4578 notsolid();
  level._id_5D97._id_4578 connectpaths();
  _id_95D4();
  var_4 = getEnt("door_fnl_top", "targetname");
  var_5 = getEnt("trig_color_finale", "targetname");
  var_6 = getEnt("trig_fnl_scene", "targetname");
  var_6 scripts\engine\utility::trigger_off();
  level._id_740B = 0.3;
  level.player scripts\sp\utility::_id_F526("normal");
  scripts\engine\utility::flag_set("flag_fnl_open_roof");
  scripts\sp\utility::_id_2669("finale");
  setmusicstate("mx_207_rogue_finale");
  level.player playSound("finale_doors_sfx");
  playworldsound("finale_doors_emt_sfx", (33484, 47342, 371));

  if(isDefined(level._id_3FA7)) {
    level._id_3FA7 notify("stop_loop");
  }

  var_3 movez(88, 1.5, 0.1, 0.5);
  var_4 movez(96, 2.5, 0.5);
  _id_C5F5();
  thread hold_sun_for_player();
  thread _id_8A9F();
  level notify("fin_stop_night_cleanup");

  foreach(var_8 in level._id_10AC8) {
    var_8.combat = 1;
  }

  var_1 notify("combat_stop_loop");
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\utility::_id_F3B5, "r");
  scripts\engine\utility::array_thread(level._id_71B3, scripts\sp\utility::_id_F3B5, "y");
  scripts\engine\utility::array_thread(level._id_71B4, scripts\sp\utility::_id_F3B5, "y");
  scripts\engine\utility::array_thread(level._id_71B3, scripts\sp\utility::_id_51E1, "combat");
  scripts\engine\utility::array_thread(level._id_71B3, scripts\sp\utility::_id_F416, 0);
  scripts\engine\utility::array_thread(level._id_71B3, scripts\sp\utility::_id_F415, 0);
  scripts\engine\utility::array_thread(level._id_71B4, scripts\sp\utility::_id_51E1, "combat");

  foreach(var_11 in level._id_10AC8) {
    var_11 _meth_83A1();
  }

  if(isDefined(level._id_3FA7)) {
    level._id_3FA7 _meth_83A1();
  }

  if(isDefined(level._id_3FA0)) {
    level._id_3FA0 _meth_83A1();
  }

  foreach(var_14 in level._id_71B3) {
    var_14.goalradius = 32;

    if(isDefined(var_14._id_1FBD)) {
      var_14._id_1FBD notify("civ_stop_loop");
      var_14 _meth_83A1();
    }

    var_14 scripts\sp\utility::_id_86E2();
  }

  scripts\sp\utility::_id_15F5("trig_color_finale");
  scripts\engine\utility::exploder("55");
  thread _id_71B6("fnl_roof_1l", 20, 5);
  thread _id_71B6("fnl_roof_1r", 20, 5);
  level._id_111C3.ent linkTo(level._id_111C3._id_C6EA, "tag_origin", (17000, 40000, 0), (0, 0, 0));
  level._id_111C3._id_1EF6 linkTo(level._id_111C3._id_E6E5, "tag_origin", (0, 0, 0), (-80, 0, 240));
  scripts\sp\maps\rogue\rogue_util::_id_111E7(13, 400, 30, 150, 220);
  level.player _meth_8244("steady_rumble");
  thread _id_6C3C(var_6, var_1);
  scripts\engine\utility::flag_wait("hangar_lockdown");
  level.player stoprumble("steady_rumble");
  scripts\engine\utility::delaythread(10, ::_id_2BCD, 1, 2);
  thread _id_D218();
  scripts\engine\utility::flag_wait("flag_fnl_scene");
}

hold_sun_for_player() {
  wait 9;

  if(!scripts\engine\utility::flag("civ_back_blocker_set")) {
    scripts\engine\utility::flag_set("dont_update_sun_on_restart");
    level._id_111C3._id_E6E5 rotateTo(level._id_111C3._id_E6E5.angles, 0.05);
    scripts\sp\maps\rogue\rogue_util::_id_11206(undefined, 1);
    var_0 = level._id_111C3.time;
    earthquake(0.4, 3, level.player.origin, 850);
    thread scripts\sp\maps\rogue\rogue_util::_id_E66C(1.5, 0.4);
    scripts\engine\utility::flag_wait("civ_back_blocker_set");
    scripts\sp\maps\rogue\rogue_util::_id_111E7(var_0, 391, 30, 150, 220);
    scripts\engine\utility::flag_clear("dont_update_sun_on_restart");
  }
}

audio_slomo_settings() {
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("voice_radio_3d", 0.1);
  soundsettimescalefactor("voice_plr_breath_2d", 0.1);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_lfe_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_1_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_2_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_3_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_4_2d", 0.25);
  soundsettimescalefactor("scn_fx_unres_3d", 0.25);
  soundsettimescalefactor("scn_fx_unres_2d", 0);
  soundsettimescalefactor("spear_refl_close_unres_3d_lim", 0.25);
  soundsettimescalefactor("spear_refl_unres_3d_lim", 0.25);
  soundsettimescalefactor("weap_npc_main_3d", 0.25);
  soundsettimescalefactor("weap_npc_mech_3d", 0.25);
  soundsettimescalefactor("weap_npc_mid_3d", 0.25);
  soundsettimescalefactor("weap_npc_lfe_3d", 0);
  soundsettimescalefactor("weap_npc_dist_3d", 0.25);
  soundsettimescalefactor("weap_npc_lo_3d", 0.25);
  soundsettimescalefactor("melee_npc_3d", 0.25);
  soundsettimescalefactor("melee_plr_2d", 0.25);
  soundsettimescalefactor("special_hi_unres_1_3d", 0.25);
  soundsettimescalefactor("special_lo_unres_1_2d", 0);
  soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim", 0.25);
  soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim", 0.25);
  soundsettimescalefactor("bulletflesh_1_unres_3d_lim", 0.25);
  soundsettimescalefactor("bulletflesh_2_unres_3d_lim", 0.25);
  soundsettimescalefactor("foley_plr_mvmt_unres_2d_lim", 0.25);
  soundsettimescalefactor("scn_fx_unres_2d_lim", 0.25);
  soundsettimescalefactor("menu_1_2d_lim", 0);
  soundsettimescalefactor("equip_use_unres_3d", 0.25);
  soundsettimescalefactor("explo_1_3d", 0.3);
  soundsettimescalefactor("explo_2_3d", 0.3);
  soundsettimescalefactor("explo_3_3d", 0.3);
  soundsettimescalefactor("explo_4_3d", 0.3);
  soundsettimescalefactor("explo_5_3d", 0.3);
  soundsettimescalefactor("explo_lfe_3d", 0.3);
}

flag_if_civ_back_blocked() {
  level.player waittill("rogue_back_blocker_set");
  scripts\engine\utility::flag_set("civ_back_blocker_set");
  scripts\sp\maps\rogue\rogue_util::_id_75D6();
}

finale_player_push() {
  level waittill("doors_open");
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    var_2 _meth_8250(1);
  }

  level waittill("doors_close");
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    var_2 _meth_8250(0);
  }
}

_id_12E35() {
  level endon("time_15.5");

  while(!isDefined(level._id_6B0E)) {
    wait 1;
  }

  while(level._id_6B0E.size > 0 || level._id_111C3.time < 15) {
    wait 1;
  }

  level notify("most_enemies_dead");
}

_id_6A45() {
  level endon("flag_fnl_player_fall");
  thread deal_damage_on_hack_punches();

  for(;;) {
    level.player waittill("damage", var_0, var_1);

    if(!isDefined(var_1)) {
      var_1 = level.player;
    }

    if(scripts\engine\utility::flag("finale_extra_damage_for_cheesin")) {
      level.player dodamage(var_0 * 0.15, var_1.origin);
    }
  }
}

deal_damage_on_hack_punches() {
  level endon("flag_fnl_player_fall");

  for(;;) {
    level.player scripts\sp\utility::_id_65E3("is_hacked_robot");
    var_0 = getaiarray("axis");

    foreach(var_2 in var_0) {
      if(isDefined(var_2) && isDefined(var_2.special_finale_hacked)) {
        var_2.special_finale_hacked = undefined;
      }
    }

    while(level.player scripts\sp\utility::_id_65DB("is_hacked_robot")) {
      var_0 = getaiarray("axis");

      foreach(var_2 in var_0) {
        if(!isDefined(var_2.special_finale_hacked)) {
          var_2.special_finale_hacked = 1;
          var_2 thread special_finale_hack_solo();
        }
      }

      wait 0.5;
    }

    level notify("player_no_longer_hacking");
  }
}

special_finale_hack_solo() {
  level endon("player_no_longer_hacking");
  self waittill("death", var_0);
  var_1 = scripts\sp\utility::_id_7E72();
  var_2 = 5;

  switch (var_1) {
    case "easy":
      var_2 = 5;
      break;
    case "medium":
      var_2 = 5;
      break;
    case "hard":
      var_2 = 4;
      break;
    case "fu":
      var_2 = 3;
      break;
  }

  var_3 = level._id_880C / var_2;

  if(isDefined(var_0) && var_0 == level.player) {
    level.player dodamage(var_3 * 4, level.player.origin);
  }
}

_id_D218() {
  for(;;) {
    scripts\engine\utility::flag_wait("fnl_player_out_of_bounds");
    wait 0.5;

    if(scripts\engine\utility::flag("fnl_player_out_of_bounds")) {
      break;
    }
  }

  level notify("stop_blowing_tanks");
  var_0 = sortbydistance(level._id_6C4E, level.player.origin);

  for(var_1 = 0; var_1 < 3; var_1++) {
    if(isDefined(var_0[var_1])) {
      var_0[var_1] thread _id_74AC();
    }
  }

  playFX(level._effect["vfx_ra_finale_expl_megasize"], level.player.origin);
  level.player _meth_81D0();
}

_id_8A9F() {
  var_0 = 7;
  var_1 = getEnt("finale_defend_area", "script_noteworthy");
  var_2 = 0;

  for(;;) {
    var_3 = var_1 scripts\sp\utility::_id_77E3("allies");

    if(isDefined(var_3.size) && var_3.size == var_0) {
      if(scripts\engine\utility::flag("civ_back_blocker_set")) {
        _id_4266();
        thread scripts\sp\maps\rogue\rogue_util::remove_navigating_equipment();
        scripts\engine\utility::flag_set("hangar_lockdown");
        return;
      }
    }

    wait 0.05;
  }
}

_id_134D6() {
  scripts\engine\utility::flag_wait("flag_fnl_open_roof");
  wait 2;
  level.player scripts\sp\utility::play_sound_on_entity("rogue_plr_lzisopenfever");
  wait 0.15;
  level.player scripts\sp\utility::play_sound_on_entity("rogue_slt_youtooraider");
  wait 0.15;
  level.player scripts\sp\utility::play_sound_on_entity("asteroid_plr_marinesprotecty");
  wait 0.1;
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_usf_grabcoverwehold");

  foreach(var_1 in level._id_6B0E) {
    if(isDefined(var_1)) {
      var_1 makeentitysentient(var_1.team, 1);
    }
  }

  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_7412();
  scripts\engine\utility::flag_set("spawn_finale_workers");
  level._id_B33E scripts\sp\utility::_id_10346("rogue_ksh_heywegotcompany");
  scripts\engine\utility::flag_wait("finale_dropship_landed");
  scripts\sp\maps\rogue\rogue_util::_id_404C();
  scripts\engine\utility::delaythread(1, ::_id_F9EA);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  level.player scripts\sp\utility::play_sound_on_entity("rogue_slt_moveitthisplace");
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_usf_letsgogo");
  thread _id_3FBB();
}

_id_3FBB() {
  if(scripts\engine\utility::flag("flag_fnl_player_fall")) {
    return;
  }
  var_0 = sortbydistance(level._id_71B0, level.player.origin);
  var_1 = ["rogue_civ1_runrun", "rogue_civ1_godontstop", "rogue_civ1_uptheramp"];
  var_2 = ["rogue_civ2_comeon", "rogue_civ2_ohpleaseplease", "rogue_civ2_itscomindown"];
  var_3 = ["rogue_civ3_dontlookback", "rogue_civ3_hurry"];
  var_0[0] thread _id_3FA2(var_1);
  wait 0.1;
  var_0[1] thread _id_3FA2(var_2);
  wait 0.1;
  var_0[2] thread _id_3FA2(var_3);
  wait 0.1;
}

_id_3FA2(var_0) {
  level.player endon("setup_for_finale");
  level endon("flag_fnl_player_fall");

  foreach(var_2 in var_0) {
    self playsoundasmaster(var_2, "done_wth_line");
    self waittill("done_wth_line");
    wait 0.2;
  }
}

_id_64E3() {}

_id_33B3() {
  var_0 = scripts\engine\utility::getStructArray("c6_swarm", "targetname");
  var_1 = scripts\engine\utility::getStructArray("c6_swarm_instant", "targetname");

  foreach(var_3 in var_1) {
    var_3 thread _id_10742();
    scripts\engine\utility::waitframe();
  }

  level._id_6B0E = [];
  level._id_6B0F = [];
  var_5 = 0;
  var_6 = "worker";
  var_7 = 0;

  for(var_8 = 0; var_8 < var_0.size; var_8++) {
    if(isDefined(var_0[var_8].script_noteworthy)) {
      var_6 = var_0[var_8].script_noteworthy;
      var_7 = 1;
    } else
      var_7 = 0;

    var_0[var_8] _id_106F3(var_6);

    if(!var_7) {
      var_5++;
      var_5 = scripts\engine\utility::ter_op(var_5 == 2, 0, var_5);
    }
  }

  thread _id_33B5();
}

_id_106F3(var_0) {
  var_1 = scripts\engine\utility::ter_op(var_0 == "worker", "finale_worker_fake", "finale_security_fake");
  var_2 = getspawner(var_1, "targetname");
  var_2.count = 10;
  var_3 = scripts\sp\utility::_id_2C17(var_2);
  var_3 setModel("robot_c6_maintenance_low");
  var_3 dontinterpolate();
  var_3.origin = self.origin;
  var_3.angles = self.angles;
  var_3.type = var_0;
  var_3._id_1FBB = "fake_worker";
  var_4 = "finale_asleep" + randomintrange(1, 2);
  var_3._id_92CC = var_4;
  wait 0.05;
  var_3 thread scripts\sp\anim::_id_1EC3(var_3, var_4);
  var_3 thread _id_6B0C();

  if(distance2d(var_3.origin, level.player.origin) > 1100) {
    var_3 dontcastshadows();
  }

  level._id_6B0E[level._id_6B0E.size] = var_3;
}

_id_6B0C() {
  self endon("death");
  scripts\engine\utility::flag_wait("civ_back_blocker_set");
  thread _id_6B0B();
  scripts\engine\utility::flag_wait("finale_dropship_landed");
  self.team = "team3";
  self freeentitysentient();
}

_id_6B0B() {
  self endon("entitydeleted");
  self setCanDamage(1);
  self.health = 375;
  self.team = "axis";

  while(self.health > 0) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_4) && var_4 == "MOD_CRUSH") {
      thread _id_E585();
      return;
    }

    if(isDefined(var_3)) {
      playFX(level._effect["vfx_electric_spark_burst_b"], var_3);

      if(scripts\engine\utility::cointoss()) {
        playFX(level._id_7649["c6_shock"], var_3);
      }

      wait 1;
    }
  }

  var_5 = spawn("script_model", self.origin);
  var_5.angles = self.angles;
  var_5 hide();
  var_5 setModel(self.model);
  var_5._id_1FBB = "fake_worker";
  var_5 scripts\sp\utility::_id_23B7();
  var_6 = scripts\sp\utility::_id_7DC1(self._id_92CC);
  var_5 setanimknob(var_6, 1, 0, 0);
  var_5 show();
  var_5 startragdoll();
  var_5 thread _id_51A2();
  self delete();
}

_id_E585() {
  wait 0.4;
  var_0 = spawnfx(scripts\engine\utility::getfx("robot_dmg_upper"), self.origin + (0, 0, 45));
  triggerfx(var_0);
  wait 0.3;
  self delete();
  var_0 delete();
}

_id_51A2() {
  self endon("entitydeleted");

  for(;;) {
    if(distance2d(self.origin, level.player.origin) > 350) {
      if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, cos(65))) {
        self delete();
        return;
      }
    } else if(distance2d(self.origin, level.player.origin) > 600) {
      self delete();
      return;
    }

    wait 0.25;
  }
}

_id_5159() {
  if(isDefined(self)) {
    self delete();
  }
}

_id_6B0A() {
  var_0 = scripts\engine\utility::ter_op(self.type == "worker", "finale_worker", "finale_security");
  var_1 = getspawner(var_0, "targetname");
  var_1.count = 10;
  var_2 = var_1 _meth_8393();

  if(!isDefined(var_2)) {
    return;
  }
  if(var_2.classname == "actor_enemy_c6_worker") {
    var_2 _id_0A03::_id_13DC1(0);
  }

  if(self.health > 0) {
    var_3 = self.health;
  } else {
    var_3 = 375;
  }

  var_2.health = var_3;
  var_2.maxhealth = var_3;
  var_2.ignoreme = 1;
  var_2 hide();
  var_2 dontinterpolate();
  var_2 _meth_80F1(self.origin, self.angles, 8000);
  var_2._id_1FBB = "fake_worker";
  var_2 thread scripts\sp\anim::_id_1EC3(var_2, self._id_92CC);
  var_2 show();
  self hide();
  var_2 thread _id_6B0D();
  level._id_6B0E = scripts\engine\utility::array_remove(level._id_6B0E, self);
  self delete();

  if(isalive(var_2)) {
    return var_2;
  } else {
    return undefined;
  }
}

_id_10742() {
  var_0 = getspawner("finale_worker", "targetname");
  var_0.count = 10;
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1 hide();
  var_1 dontinterpolate();
  var_1 _meth_80F1(self.origin, self.angles, 8000);
  var_1.nocorpsedelete = 1;
  var_1.health = 1;
  var_1.ignoreme = 0;
  var_1._id_1FBB = "fake_worker";
  var_1 thread scripts\sp\anim::_id_1EC3(var_1, "finale_asleep" + randomintrange(1, 2));
  var_1 show();
  var_1 waittill("death");
  var_1 _meth_83A1();
}

_id_6B0D() {
  self endon("death");
  var_0 = 0.5;
  thread scripts\sp\maps\rogue\rogue_util::_id_EBD8(1, var_0);
  self playSound("c6_power_up");
  wait(var_0);
  self.ignoreme = 0;
  _id_0A1E::_id_2385();

  if(self.classname == "actor_enemy_c6_worker") {
    _id_0A03::_id_13DC1(1);
  } else {
    thread _id_5775();
  }

  level._id_6B0F[level._id_6B0F.size] = self;

  if(!isDefined(self.enemy)) {
    var_1 = scripts\engine\utility::array_add(level.allies, level.player);
    scripts\sp\utility::_id_F39C(scripts\engine\utility::random(var_1));
  }
}

_id_FC49() {
  self endon("death");
  self dontcastshadows();

  while(distance2dsquared(self.origin, level.player.origin) > squared(600)) {
    wait 0.25;
  }

  self castshadows();
}

_id_5775() {
  self endon("death");
  self.goalradius = 800;

  for(;;) {
    var_0 = self _meth_80E3();

    if(isDefined(var_0)) {
      self.goalradius = 32;
      self _meth_82EE(var_0);
      self waittill("goal");
      self.goalradius = 1000;
      return;
    }

    wait 0.5;
  }
}

_id_33B5() {
  level endon("finale_dropship_enroute");
  scripts\engine\utility::flag_wait("spawn_finale_workers");
  scripts\engine\utility::flag_wait("hangar_lockdown");
  thread _id_33B6();
  level._id_B41B = 5;
  level._id_4B38 = 0;
  var_0 = gettime();
  var_1 = 0;
  var_2 = undefined;
  wait 0.25;
  level._id_4B38++;

  for(;;) {
    if(gettime() - var_0 > 5000) {
      level._id_B41B = level._id_B41B + 2;
      var_0 = gettime();
    }

    if(level._id_4B38 < level._id_B41B) {
      level._id_6B0E = scripts\engine\utility::array_removeundefined(level._id_6B0E);

      if(!level._id_6B0E.size) {
        return;
      }
      var_3 = scripts\engine\utility::getclosest(level.player.origin, level._id_6B0E);
      var_4 = var_3 _id_6B0A();

      if(isDefined(var_4) && !scripts\sp\utility::_id_106ED(var_4)) {
        level._id_4B38++;
        var_4 thread _id_33B4();
        var_4 thread _id_FC49();
        var_1++;
        var_2 = scripts\engine\utility::ter_op(var_1 == 2, 1, undefined);
        var_1 = scripts\engine\utility::ter_op(var_1 == 2, 0, var_1);
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

_id_8A55() {
  level endon("flag_fnl_scene");
  var_0 = scripts\engine\utility::getStructArray("script_explosion", "targetname");

  for(;;) {
    var_0 = scripts\engine\utility::array_randomize(var_0);

    foreach(var_2 in var_0) {
      wait(randomfloatrange(3, 6));

      if(scripts\engine\utility::flag("flag_fnl_scene")) {
        return;
      }
      playFX(scripts\engine\utility::getfx("hangar_explosion"), var_2.origin);
      playworldsound("fuel_tank_explode", var_2.origin);
      earthquake(0.4, 0.25, level.player.origin, 200);
      level.player playRumbleOnEntity("grenade_rumble");
    }

    wait 0.05;
  }
}

_id_8A58() {
  var_0 = getspawnerarray("hangar_floods");
  thread _id_0B77::_id_6F5A(var_0);
  scripts\engine\utility::flag_wait("flag_fnl_scene");

  foreach(var_2 in var_0) {
    var_2 notify("stop current floodspawner");
    var_2 delete();
  }
}

_id_33B6() {
  level endon("finale_dropship_landed");
  var_0 = 2;

  for(;;) {
    var_1 = 0;

    foreach(var_3 in getaiarray("axis")) {
      if(var_3.classname == "actor_enemy_c6_worker") {
        if(level.player scripts\sp\maps\rogue\rogue_util::_id_13DBE(var_3)) {
          var_1++;

          if(var_1 > var_0) {
            if(!isDefined(var_3._id_10B6A)) {
              var_3 _id_10FC6(1);
            }
          }

          continue;
        }

        if(isDefined(var_3._id_10B6A)) {
          var_3 _id_10FC6(0);
        }
      }
    }

    wait 3;
  }
}

_id_10FC6(var_0) {
  if(var_0 && !isDefined(self._id_10B6A)) {
    self._id_10B6A = 1;
    scripts\asm\asm_bb::bb_clearmeleerequest();
    _id_0A03::_id_13DC1(0);
    self setgoalpos(self.origin);
    self.maxvisibledist = 10;
    self.maxsightdistsqrd = squared(2);
    self.ignoreall = 1;
  } else if(!var_0 && isDefined(self._id_10B6A)) {
    self notify("stop_print3d");
    self._id_10B6A = undefined;
    self.ignoreall = 0;
    self.maxvisibledist = 8192;
    self.maxsightdistsqrd = squared(8192);
    _id_0A03::_id_13DC1(1);
  }
}

_id_5142() {
  if(!isDefined(level._id_6B0F)) {
    return;
  }
  level._id_6B0F = scripts\sp\utility::array_removedeadvehicles(level._id_6B0F);
  scripts\engine\utility::array_call(level._id_6B0F, ::delete);
  var_0 = getEnt("dropship_player_pathway", "targetname");

  foreach(var_2 in level._id_6B0E) {
    if(isDefined(var_2) && var_2 istouching(var_0)) {
      var_2 delete();
    }
  }
}

_id_33B4() {
  self endon("entitydeleted");
  self waittill("death");

  if(isDefined(self)) {
    level._id_4B38--;
  }
}

_id_6548() {
  level endon("finale_dropship_enroute");
  level._id_B452 = 3;
  level._id_4BA2 = 0;
  var_0 = scripts\engine\utility::getStructArray("c6_jump", "targetname");

  for(;;) {
    if(level._id_4BA2 < level._id_B452) {
      if(!scripts\engine\utility::flag("spawn_finale_security")) {
        var_1 = getspawnerarray("finale_workers_railing");
      } else {
        var_1 = getspawnerarray("finale_security_railing");
      }

      var_2 = scripts\engine\utility::random(var_1);
      var_3 = var_2 scripts\sp\utility::_id_10619(1);

      if(!scripts\sp\utility::_id_106ED(var_3)) {
        level._id_4BA2++;
        var_3 thread _id_DC29();
        var_0 = scripts\engine\utility::array_randomize(var_0);

        foreach(var_5 in var_0) {
          if(var_5 != level._id_A923) {
            level._id_A923 = var_5;
            var_3 thread _id_3396(var_5);
            break;
          }
        }

        wait(randomfloatrange(1, 1.7));
      }
    }

    wait 0.1;
  }
}

_id_DC29() {
  self waittill("death");
  level._id_4BA2--;
}

_id_3396(var_0) {
  self endon("death");

  if(self.classname == "actor_enemy_c6_worker") {
    _id_0A03::_id_13DC1(0);
  }

  self._id_1FBB = "generic";

  if(scripts\engine\utility::cointoss()) {
    var_1 = "rail_hop_1";
  } else {
    var_1 = "rail_hop_2";
  }

  var_0 scripts\sp\anim::_id_1F17(self, var_1);
  var_0 thread scripts\sp\anim::_id_1F35(self, var_1);
  wait 0.1;

  if(isDefined(var_0.target)) {
    self.target = var_0.target;
    self.goalradius = 32;
    _id_0B77::_id_8409();
  }

  if(self.classname == "actor_enemy_c6_worker") {
    _id_0A03::_id_13DC1(1);
  }
}

_id_95D4() {
  level._id_6C3E = getEntArray("finale_exit_doors", "script_noteworthy");

  foreach(var_1 in level._id_6C3E) {
    var_1.clip = getEnt(var_1.target, "targetname");
    var_1.clip linkTo(var_1);
    var_1.clip disconnectPaths();
    var_1._id_4284 = var_1.origin;
    var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
    var_1._id_C5D9 = var_2.origin;
  }
}

_id_C5F5() {
  var_0 = 1;
  var_1 = 0;
  level notify("doors_open");

  foreach(var_3 in level._id_6C3E) {
    if(!var_1) {
      var_3 playSound("finale_doors_open_fast");
      var_1 = 1;
    }

    var_3 moveTo(var_3._id_C5D9, var_0 / 2, var_0 / 2);
    var_3.clip scripts\engine\utility::delaycall(var_0, ::connectpaths);
  }

  wait(var_0);
}

_id_4266() {
  var_0 = 1;
  var_1 = 0;
  level notify("doors_open");

  foreach(var_3 in level._id_6C3E) {
    if(!var_1) {
      var_3 playSound("finale_doors_close_fast");
      var_1 = 1;
    }

    var_3 moveTo(var_3._id_4284, var_0 / 2, var_0 / 2);
    var_3.clip scripts\engine\utility::delaycall(var_0, ::disconnectpaths);
  }

  wait(var_0);
}

_id_6C3C(var_0, var_1) {
  scripts\engine\utility::flag_wait("hangar_lockdown");
  level scripts\engine\utility::waittill_any("time_15.5", "most_enemies_dead");
  _id_106F5(1);
  scripts\engine\utility::flag_set("finale_dropship_enroute");

  if(level.player scripts\sp\utility::_id_65DB("is_hacked_robot")) {
    thread _id_0E29::_id_87A1();
  }

  level.player._id_87FA = 0;
  thread _id_FB7A();
  level._id_5D6C thread _id_5E3A();
  scripts\sp\utility::_id_2669("dropship_coming");
  scripts\engine\utility::flag_wait("finale_dropship_landed");
  thread _id_19D6(var_1);
  var_0 scripts\engine\utility::trigger_on();
  thread _id_A5EA();
  scripts\engine\utility::flag_wait("flag_fnl_scene");
}

_id_A5EA() {
  level endon("flag_fnl_scene");
  wait 20;
  var_0 = level.player scripts\sp\maps\rogue\surface::_id_79D8(80);
  earthquake(0.5, 1, level.player.origin, 100);
  playFX(level._effect["vfx_ra_finale_expl_medium"], level.player getEye());
  playworldsound("scn_rogue_finale_big_explo", level.player.origin);

  if(scripts\engine\utility::flag("flag_fnl_scene")) {
    return;
  }
  level.player scripts\sp\utility::_id_54C6();
}

_id_19D6(var_0) {
  var_0 notify("stop_loop");
  scripts\sp\maps\rogue\civilians::_id_167A();
  scripts\engine\utility::array_thread(level._id_10AC8, ::_id_71B2, "node_fnl", 1);
  scripts\engine\utility::array_thread(level._id_71B4, ::_id_71B2, "node_fnl", 1);
  scripts\engine\utility::array_thread(level._id_71B4, scripts\sp\utility::_id_F415, 0);
  var_1 = getEnt("civilian_animnode", "targetname");
  var_1 notify("civ_stop_loop");

  foreach(var_3 in level._id_71B0) {
    var_3 thread _id_71B2("node_fnl");
    wait 0.6;
  }

  foreach(var_3 in level._id_71B3) {
    var_3 thread _id_71B2("node_fnl");
    wait 0.6;
  }
}

_id_5E3A() {
  self waittillmatch("noteworthy", "door_open");
  thread _id_5EAC();
  self waittillmatch("noteworthy", "landing");
  self sethoverparams(0, 0, 0);
  level._id_6C3B = self;
  thread _id_0BBC::_id_C5F1("back");
  level thread _id_5DA7();
  self waittill("reached_dynamic_path_end");
  scripts\engine\utility::exploder("56");
  scripts\engine\utility::delaythread(3.5, ::_id_5EBA, 0);
  level._id_5D97.origin = level._id_5D97.origin - (0, 0, 1000);
  level._id_5D97._id_4578.origin = level._id_5D97._id_4578.origin - (0, 0, 1000);
  level._id_5D97 solid();
  level._id_5D97._id_4578 notsolid();
  thread _id_C5F5();
  wait 3;
  scripts\engine\utility::flag_set("finale_dropship_landed");
  level notify("stop_blowing_tanks");
  wait 1;
  level._id_5D6C _id_0BBF::_id_F458(1, undefined, 1);
  level._id_5D6C _id_0BBF::_id_F453("int", "loading", 15);
  thread _id_8A55();
  wait 2;
  level thread _id_2BCD(0.75, 1.5);
  level thread _id_D041();
}

_id_5EAC() {
  var_0 = [scripts\engine\utility::getStruct("spot_sweep_1", "targetname"), scripts\engine\utility::getStruct("spot_sweep_2", "targetname"), scripts\engine\utility::getStruct("landed", "script_noteworthy")];
  self._id_10A5F settargetentity(self._id_10A5F._id_11512);
  scripts\engine\utility::delaythread(0.25, ::_id_5EBA, 1);
  var_1 = 1.2;

  foreach(var_3 in var_0) {
    self._id_10A5F._id_11512 moveTo(var_3.origin, var_1, var_1 * 0.15, var_1 * 0.15);
    wait(var_1);
  }
}

_id_106F5(var_0) {
  thread _id_E64D();
  level.player scripts\sp\utility::play_sound_on_entity("rogue_slt_ihaveavisual");
  var_1 = getEnt("dropship_crush_trig", "targetname");
  var_1 enablelinkTo();
  level._id_5D6C = _id_0BBF::_id_106B8("veh_fnl_dropship_land");
  var_1 linkTo(level._id_5D6C);
  level._id_5D6C._id_1270F = var_1;
  level._id_5D6C dontcastshadows();
  level._id_5D6C._id_FC4B = getEnt("dropship_shadowcaster", "targetname");
  level._id_5D6C._id_FC4B linkTo(level._id_5D6C, "tag_origin");
  level._id_5D6C._id_1FBB = "dropship";
  var_1 thread _id_5DA6();
  level._id_5D6C _id_5EB3();
  level._id_5D6C _id_0BBF::_id_F459(1);

  if(isDefined(var_0)) {
    thread scripts\sp\vehicle_paths::_id_845A(level._id_5D6C);
  }
}

_id_E64D() {
  wait 5;
  setmusicstate("");
}

_id_2BCD(var_0, var_1) {
  level notify("stop_blowing_tanks");
  level endon("stop_blowing_tanks");
  var_2 = scripts\engine\utility::ter_op(scripts\engine\utility::flag("finale_dropship_landed"), level._id_6C4E, level._id_6C41);

  if(isDefined(var_2) && isDefined(var_2.size) && !var_2.size) {}

  var_3 = 0;
  var_2 = sortbydistance(var_2, level.player.origin);

  foreach(var_5 in var_2) {
    if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_5.origin, cos(55)) && !isDefined(var_5._id_9BB8)) {
      var_5 _id_74AC();
      var_3++;

      if(var_3 == var_2.size) {
        level notify("stop_blowing_tanks");
        return;
      }
    }

    wait(randomfloatrange(var_0, var_1));
  }
}

_id_74AC() {
  self._id_9BB8 = 1;
  self setscriptablepartstate("main", "explode");
  earthquake(randomfloatrange(0.5, 1.5), randomfloatrange(0.5, 1), self.origin, 1000);

  if(distance2dsquared(self.origin, level.player.origin) < squared(1000)) {
    level.player playRumbleOnEntity("grenade_rumble");
  }
}

_id_5EB3() {
  var_0 = "j_frontlandinggearpanel";
  var_1 = (10, 0, 15);
  var_2 = self gettagorigin(var_0);
  self._id_10A5F = spawnturret("misc_turret", var_2 + var_1, "fighter_spotlight");
  self._id_10A5F.angles = self.angles;
  self._id_10A5F linkTo(self, var_0, var_1, (0, 0, 0));
  self._id_10A5F setModel("veh_mil_air_ca_dropship_turret_nodraw");
  self._id_10A5F makeunusable();
  self._id_10A5F setmode("manual");
  self._id_10A5F setdefaultdroppitch(-90);
  self._id_10A5F setleftarc(180);
  self._id_10A5F setrightarc(180);
  self._id_10A5F settoparc(180);
  self._id_10A5F setbottomarc(180);
  self._id_10A5F _meth_82C9(0.75, "yaw");
  self._id_10A5F _meth_82C9(0.75, "pitch");
  self._id_10A5F.active = 0;
  self._id_10A5F._id_11512 = scripts\engine\utility::spawn_tag_origin();
}

_id_5EBA(var_0) {
  if(var_0 && !self._id_10A5F.active) {
    wait 1;
    playFXOnTag(scripts\engine\utility::getfx("search_spotlight"), self._id_10A5F, "tag_flash");
    self._id_10A5F.active = 1;
  } else {
    stopFXOnTag(scripts\engine\utility::getfx("search_spotlight"), self._id_10A5F, "tag_flash");
    self._id_10A5F.active = 0;
  }
}

_id_5EB7(var_0) {
  self._id_10A5F settargetentity(self._id_10A5F._id_11512);
  self endon("new_spotlight_target");
  var_1 = distance(self._id_10A5F._id_11512.origin, var_0);
  var_2 = scripts\sp\utility::_id_BD6B(20, var_1);

  if(var_2 <= 0) {
    var_2 = 1;
  }

  self._id_10A5F._id_11512 moveTo(var_0, var_2, var_2 * 0.8, var_2 * 0.2);
  wait(var_2);
}

_id_5DA7() {
  level endon("flag_fnl_scene");

  for(;;) {
    var_0 = level._id_6B0E;
    var_0 = scripts\engine\utility::array_removeundefined(var_0);

    foreach(var_2 in var_0) {
      if(isDefined(var_2) && var_2 istouching(level._id_5D6C._id_1270F)) {
        var_2 thread _id_5DA8();
      }
    }

    wait 0.05;
  }
}

_id_5DA6() {
  level endon("flag_fnl_scene");

  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0)) {
      var_0 thread _id_5DA8();
    }
  }
}

_id_5DA8() {
  if(self.classname != "script_model") {
    if(!isalive(self)) {
      return;
    }
  }

  if(isDefined(self._id_4AB5)) {
    return;
  }
  self._id_4AB5 = 1;
  self dodamage(self.health + 1000, self.origin, undefined, undefined, "MOD_CRUSH");
  wait 3;

  if(isDefined(self)) {
    _id_5159();
  }
}

_id_71B2(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  self.dontmelee = 1;
  var_2 = getnode(var_0 + self._id_111B7, "targetname");

  if(!isnode(var_2)) {
    return;
  }
  scripts\sp\utility::_id_4145();
  scripts\sp\utility::_id_7226(var_2);
  scripts\engine\utility::flag_wait("flag_fnl_scene");

  if(!isDefined(var_1) || !var_1) {
    self delete();
  }
}

_id_9B8B() {
  var_0 = strtok(self.classname, "_");
  return var_0[1] == "civilian";
}

_id_6C39() {
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626(undefined, ["Salter"]);
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12984);
  thread _id_6C44();
  scripts\sp\maps\rogue\civilians::_id_FA4B();
  level._id_71B0 = scripts\sp\utility::_id_22CD("civ_fnl");
  level._id_71B3 = scripts\sp\utility::_id_22CD("civ_fnl_guard");
  level._id_71B4 = [scripts\sp\utility::_id_107EA("civ_fnl_owens"), scripts\sp\utility::_id_107EA("civ_fnl_jones")];
  scripts\engine\utility::array_thread(level._id_71B4, scripts\sp\utility::_id_B14F);
  thread _id_71B6("fnl_roof_1l", 4, 1);
  thread _id_71B6("fnl_roof_1r", 4, 1);
  _id_95D4();
  thread _id_C5F5();
  scripts\sp\maps\rogue\rogue_util::_id_BC53("finale_drag_player");
  _id_106F5();
  scripts\engine\utility::flag_set("flag_fnl_scene");
  scripts\engine\utility::delaythread(1, ::_id_F9EA);
  scripts\engine\utility::flag_set("toggle_finale_drag_light");
}

_id_6C37() {
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_7412();
  visionsetnaked("rogue_escape", 2);

  while(!istransientloaded("weapon_iw7_m4_tr")) {
    wait 0.05;
  }

  level._id_B33B scripts\sp\utility::_id_CC06("iw7_m4", "right");
  level._id_B4F9 scripts\sp\maps\rogue\rogue_util::_id_12958();
  _id_6C38();
}

_id_F9EA() {
  scripts\engine\utility::flag_wait("player_in_scene");

  if(getdvarint("loop_finale", 0) == 1) {
    return;
  }
  if(istransientloaded("rogue_base_tr")) {
    scripts\sp\utility::_id_1264E("rogue_base_tr");
    wait 0.25;
  }

  setpreloadimageprimeset("shipcrib_prisoner_primeimg");
  scripts\sp\utility::_id_BF97(undefined, 0);
}

_id_D041() {
  level endon("flag_fnl_scene");
  var_0 = getEnt("dropship_player_pathway", "targetname");
  var_1 = 5;
  var_2 = var_1 * 20;
  var_3 = 0;

  for(;;) {
    while(!_id_D11A(var_0) && !level.player.burning) {
      var_3++;

      if(var_3 >= var_2) {
        var_4 = level.player scripts\sp\maps\rogue\surface::_id_79D8(80);
        earthquake(0.5, 1, level.player.origin, 100);
        playFX(level._effect["vfx_ra_finale_expl_medium"], level.player getEye());
        playworldsound("scn_rogue_finale_big_explo", level.player.origin);

        if(scripts\engine\utility::flag("flag_fnl_scene")) {
          return;
        }
        level.player scripts\sp\utility::_id_54C6();
      }

      wait 0.05;
    }

    var_3 = 0;
    wait 0.05;
  }
}

_id_D11A(var_0) {
  if(scripts\engine\utility::flag("player_is_outside")) {
    if(!level.player istouching(var_0)) {
      return 0;
    }
  }

  return 1;
}

_id_6C44() {
  var_0 = getEntArray("finale_drag_lights", "script_noteworthy");
  var_1 = getEnt("dropship_backlight", "script_noteworthy");
  var_2 = var_0;
  var_2[var_2.size] = var_1;

  foreach(var_4 in var_2) {
    var_4._id_C385 = var_4 _meth_8134();
    var_4 setlightintensity(0);
    var_4._id_AD83 = [];
    var_4._id_12BB6 = [];
    var_4._id_AD22 = [];
    var_4._id_127C9 = [];
  }

  scripts\engine\utility::flag_wait("flag_fnl_player_fall");
  wait 0.5;

  foreach(var_4 in var_2) {
    var_4 setlightintensity(var_4._id_C385);
  }

  var_1 linkTo(level._id_5D6C, "tag_origin");
  scripts\engine\utility::array_thread(var_0, ::_id_4FD4);
}

#using_animtree("generic_human");

_id_6C38() {
  while(!isDefined(level._id_5D6C)) {
    wait 0.05;
  }

  thread _id_6C4F();
  scripts\sp\maps\rogue\rogue_util::_id_D0D5();
  var_0 = level._id_5D6C;
  thread _id_D066();
  var_1 = getEnt("org_fnl_anim", "targetname");
  var_2 = scripts\sp\utility::_id_10639("player_rig");
  var_2 hide();
  level.player._id_E505 = var_2;
  var_1 scripts\sp\anim::_id_1EC3(var_2, "finale_scene");
  thread _id_F602();
  thread _id_FA0F();
  level.player _meth_823C(var_2, "tag_player", 1, 0, 0.5);
  scripts\engine\utility::flag_set("player_in_scene");
  level.player playerlinktodelta(var_2, "tag_player", 1, 5, 5, 5, 0, 0);
  scripts\sp\maps\rogue\civilians::_id_167A();
  var_3 = _id_1067D();
  var_3._id_1FBB = "civ_burn";
  var_3 thread _id_3F95();
  var_4 = _id_1067D();
  var_4._id_1FBB = "civ_brooks_civ";
  scripts\sp\maps\rogue\rogue_util::_id_10626(undefined, ["Omar", "Kashima", "Brooks"]);
  level._id_13E12 scripts\sp\maps\rogue\rogue_util::_id_12984();
  var_5 = [level._id_13E12, level._id_B4F9, level._id_B33B, var_3, var_4, var_2, var_0];

  foreach(var_7 in var_5) {}

  var_9 = level._id_71B4;
  var_10 = scripts\engine\utility::array_combine(var_5, var_9);
  level._id_6C59 = var_10;

  foreach(var_7 in var_10) {
    var_7 _meth_839E();

    if(!isai(var_7)) {
      continue;
    }
    if(!isDefined(var_7._id_111B7) || !issubstr(var_7._id_111B7, "salter") && !issubstr(var_7._id_111B7, "brooks")) {
      var_7 scripts\sp\utility::_id_F416(1);
    }

    if(!isDefined(var_7._id_B14F)) {
      var_7 scripts\sp\utility::_id_B14F(1);
    }

    if(getdvarint("debug_finale_anims")) {
      var_7 thread scripts\sp\maps\rogue\rogue_util::_id_D8E9(var_7._id_1FBB);
    }
  }

  if(scripts\sp\utility::_id_93A6() && !scripts\sp\specialist_MAYBE::_id_2C95()) {
    level._id_10964 thread scripts\sp\specialist_MAYBE::_id_4E1A(1);
  }

  var_2 show();
  thread _id_6C4B(var_1);
  var_13 = getanimlength(%asteroid_finale_mco_drag);
  thread _id_6C32();
  thread scripts\engine\utility::flag_set_delayed("finale_scene_end", var_13 - 0.1);
  var_1 thread scripts\sp\anim::_id_1F2C(var_10, "finale_scene");
  scripts\sp\utility::_id_266A("finale_drag");
  var_3 thread _id_3F94(var_1);
  var_4 thread _id_4049();

  if(isDefined(level._id_B33B)) {
    level._id_B33B thread _id_4049();
  }

  if(isDefined(level._id_B33E)) {
    level._id_B33E scripts\sp\utility::_id_1101B();
    level._id_B33E delete();
  }

  foreach(var_15 in level._id_71B4) {
    var_15.ignoreme = 1;

    if(var_15._id_1FBB == "civ_owens") {
      var_15 thread _id_4049();
      continue;
    }

    if(var_15._id_1FBB == "civ_lee") {
      var_15 thread _id_3FA1();
    }
  }

  scripts\engine\utility::delaythread(4.75, ::_id_6C1F);
  level.player thread _id_6C4D();
  scripts\engine\utility::flag_set("toggle_finale_drag_light");
  var_13 = 1;
  level.player scripts\engine\utility::delaycall(11, ::lerpviewangleclamp, var_13, var_13 / 2, var_13 / 2, 25, 20, 20, 10);
  thread scripts\engine\utility::flag_set_delayed("drag_start", 11);
  thread _id_6C36();
  level._id_13E12 thread _id_4049();
  thread _id_6C58();
  thread _id_6C57();
  scripts\engine\utility::flag_wait("finale_scene_end");
}

_id_6C57() {
  foreach(var_1 in level._id_71B4) {
    if(var_1._id_1FBB == "civ_lee") {
      var_2 = var_1;
      wait 11.5;
      var_3 = var_2 gettagorigin("j_spineupper");
      playFX(scripts\engine\utility::getfx("civ_blood"), var_3 + (-10, 20, 0), (-1, 1, 0));
      wait 0.1;
      playFX(scripts\engine\utility::getfx("civ_blood"), var_3 + (-10, 20, 0), (-1, 1, 0));
      wait 0.1;
      playFX(scripts\engine\utility::getfx("civ_blood"), var_3 + (-10, 20, 0), (-1, 1, 0));
      wait 0.1;
      playFX(scripts\engine\utility::getfx("civ_blood"), var_3 + (-10, 20, 0), (-1, 1, 0));
      wait 0.1;
      playFX(scripts\engine\utility::getfx("civ_blood"), var_3 + (-10, 20, 0), (-1, 1, 0));
      wait 0.1;
      playFX(scripts\engine\utility::getfx("civ_blood"), var_3 + (-10, 20, 0), (-1, 1, 0));
      wait 0.1;
      playFX(scripts\engine\utility::getfx("civ_blood"), var_3 + (-10, 20, 0), (-1, 1, 0));
      wait 0.1;
      playFX(scripts\engine\utility::getfx("civ_blood"), var_3 + (-10, 20, 0), (-1, 1, 0));
      wait 0.1;
      playFX(scripts\engine\utility::getfx("civ_blood"), var_3 + (-10, 20, 0), (-1, 1, 0));
      wait 0.1;
      playFX(scripts\engine\utility::getfx("civ_blood"), var_3 + (-10, 20, 0), (-1, 1, 0));
      wait 0.1;
      playFX(scripts\engine\utility::getfx("civ_blood"), var_3 + (-10, 20, 0), (-1, 1, 0));
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_burning_civ_fire"), var_2, "tag_origin");
      wait 18;
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_burning_civ_fire"), level._id_B4F9, "tag_origin");
      wait 14;
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_buddy_burn"), level._id_B4F9, "tag_origin");
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_buddy_burn"), var_2, "tag_origin");
      wait 1.5;
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_buddy_burn"), level._id_B4F9, "j_knee_le");
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_buddy_burn"), var_2, "j_knee_ri");
      wait 1.1;
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_burning_civ_fire"), level._id_B4F9, "j_knee_ri");
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_burning_civ_fire"), var_2, "j_hip_ri");
      wait 1.1;
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_buddy_burn"), level._id_B4F9, "j_spinelower");
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_buddy_burn"), var_2, "j_shoulder_le");
      wait 1.1;
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_buddy_burn"), level._id_B4F9, "j_elbow_ri");
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_buddy_burn"), var_2, "j_knee_le");
      wait 1.5;
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_burning_civ_fire"), level._id_B4F9, "j_elbow_le");
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_burning_civ_fire"), var_2, "j_spinelower");
      wait 1.1;
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_buddy_burn"), level._id_B4F9, "j_hip_ri");
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_buddy_burn"), var_2, "j_spineupper");
      wait 1.1;
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_buddy_burn"), level._id_B4F9, "j_spineupper");
      playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_buddy_burn"), var_2, "j_head");
    }
  }
}

_id_6C4D() {
  level._id_B4F9 scripts\sp\utility::_id_72EC("iw7_ar57+reflex+silencer", "primary");
  scripts\engine\utility::flag_set("combat_section_active");
  level.player scripts\sp\utility::_id_1C75(0);
  level.player disableweaponpickup();
  level.player takeallweapons();
  level.player giveweapon("iw7_ar57+reflex+silencer");
  level.player switchtoweaponimmediate("iw7_ar57+reflex+silencer");
  wait 11;
  level.player enableweapons();
}

_id_6C58() {
  scripts\engine\utility::exploder("pldown_ash");
  wait 5;
  wait 6;
  wait 3;
  wait 5;
  thread _id_6C5A();
  wait 5;
  wait 1;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = (34290, 45889, -160);
  var_0 moveTo((33000, 48000, -141), 50, 1, 8);
  var_1 = 100;
  playFXOnTag(level._effect["vfx_ra_finale_rolling_firewall"], var_0, "tag_origin");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    playFX(scripts\engine\utility::getfx("vfx_ra_finale_rolling_firegush"), var_0.origin + (randomfloatrange(-200, 200), randomfloatrange(-200, 200), randomfloatrange(-30, 30)));
    wait 0.1;
    wait 0.1;
    playFX(scripts\engine\utility::getfx("vfx_ra_finale_rolling_firegush"), var_0.origin + (randomfloatrange(-200, 200), randomfloatrange(-200, 200), randomfloatrange(-30, 30)));
    wait 0.1;
    wait 0.1;
    playFX(scripts\engine\utility::getfx("vfx_ra_finale_rolling_firegush"), var_0.origin + (randomfloatrange(-200, 200), randomfloatrange(-200, 200), randomfloatrange(-30, 30)));
    wait 0.1;
    var_3 = distance2d(level.player.origin, var_0.origin);

    if(scripts\engine\utility::cointoss()) {
      if(var_3 < 1000) {
        var_4 = "damage_light";

        if(var_3 < 800) {
          var_4 = "damage_heavy";

          if(var_3 < 700) {
            var_4 = "grenade_rumble";
          }
        }

        level.player playRumbleOnEntity(var_4);
      }

      continue;
    }

    if(var_3 < 700) {
      level.player playRumbleOnEntity("grenade_rumble");
    }
  }
}

_id_6C5A() {
  scripts\engine\utility::exploder("omardebris_01");
  level.player playSound("scn_rogue_finale_left_explo");
  wait 11;
  scripts\engine\utility::exploder("omardebris");
}

_id_6C4F() {
  var_0 = scripts\sp\utility::_id_7C23();
  var_0._id_99E5 = 0;
  var_0 scripts\sp\utility::_id_E7C9(0.1, 2);
  scripts\engine\utility::flag_wait("finale_scene_end");
  var_0 scripts\sp\utility::_id_E7C9(0, 2);
  var_0 delete();
}

_id_FA0F() {
  level.player._id_5942 = 1;
  level.player _meth_80D1();
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player takeallweapons();
  level.player disableweaponpickup();
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player scripts\sp\utility::_id_F416(1);
  thread _id_1033D();
  level.player notify("setup_for_finale");
}

_id_CF9D() {
  for(var_0 = 1; !scripts\engine\utility::flag("finale_scene_end") && var_0 < 5; var_0++) {
    var_1 = 1 / var_0;
    var_2 = 2 / var_0;
    playworldsound("plr_breath_pain_ong_exh", level.player.origin);
    wait(var_1);
    playworldsound("plr_breath_pain_ong_inh", level.player.origin);
    wait(var_2);
  }
}

_id_6C1F() {
  var_0 = getscriptablearray("final_drag_fuel_tanks", "targetname");

  foreach(var_2 in var_0) {
    var_2 _id_74AC();
    wait(randomfloatrange(0.75, 1.25));
  }

  level waittill("slowmotion_over");
  var_0 = getscriptablearray("final_fuel_tank", "targetname");

  foreach(var_2 in var_0) {
    var_2 _id_74AC();
    wait(randomfloatrange(0.25, 0.5));
  }
}

_id_3FA1() {
  wait 11.25;
  setslowmotion(1, 0.25, 0.5);

  for(var_0 = 0; var_0 < 3; var_0++) {
    self playSound("weap_basear_fire_plr");
    wait 0.1;
    playFXOnTag(level._effect["civ_blood"], self, "j_spineupper");
    playFXOnTag(level._effect["civ_blood"], self, "j_elbow_le");
    self playSound("bullet_large_flesh_torso_plr");
    wait 0.15;
  }

  wait 0.25;
  setslowmotion(0.25, 1, 0.5);
  level notify("slowmotion_over");
}

_id_F602() {
  wait 10;
  visionsetnaked("rogue_escape_day", 16);
}

_id_3F95() {
  wait 1.7;
  var_0 = self gettagorigin("tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_burning_civ_fire"), self, "tag_origin");

  for(var_1 = 0; var_1 < 3; var_1++) {
    self playSound("generic_death_falling_scream");
    wait(randomfloatrange(1, 2));
  }
}

_id_6C36() {
  scripts\engine\utility::flag_wait("drag_start");
  wait 2.5;

  for(var_0 = 1; var_0 < 3; var_0++) {
    _id_69B3("fivesec_b0" + var_0);
    wait(randomfloatrange(0.8, 1.5));
  }

  var_1 = scripts\engine\utility::getStructArray("dropship_fire1", "targetname");
  scripts\engine\utility::array_thread(var_1, ::_id_CCED);
  wait 2.25;

  for(var_0 = 3; var_0 < 6; var_0++) {
    _id_69B3("fivesec_b0" + var_0);
    wait(randomfloatrange(0.8, 1.5));
  }

  playFX(scripts\engine\utility::getfx("vfx_ra_finale_camcentr_heavy_ash"), (0, 0, 0));
  var_2 = 2;
  level.player lerpviewangleclamp(var_2, var_2 / 2, var_2 / 2, 19, 20, 20, 10);
  scripts\engine\utility::flag_wait("finale_takeoff_begin");
  wait 2.5;
  var_1 = scripts\engine\utility::getStructArray("dropship_fire2", "targetname");
  scripts\engine\utility::array_thread(var_1, ::_id_CCED);
  wait 1;

  for(var_0 = 6; var_0 < 13; var_0++) {
    _id_69B3("fivesec_b0" + var_0);
    wait(randomfloatrange(0.8, 1.3));
  }

  wait 1.5;
  level thread _id_6C20();
}

_id_32B8() {
  var_0 = getspawnerarray("final_swarm");
  var_1 = 0;

  while(var_1 < 9) {
    foreach(var_3 in var_0) {
      var_4 = var_3 _meth_8393();

      if(!scripts\sp\utility::_id_106ED(var_4)) {
        var_1++;
        wait(randomfloatrange(0.1, 0.25));
      }
    }

    wait 0.05;
  }
}

_id_CCED() {
  playFX(scripts\engine\utility::getfx("vfx_ra_finale_garage_fire_large"), self.origin - (0, 0, 35), anglesToForward((0, randomint(160), 0)));
}

_id_69B3(var_0, var_1) {
  thread scripts\engine\utility::exploder(var_0);
  var_2 = level.player scripts\sp\maps\rogue\surface::_id_79D8(80);
  playworldsound("scn_rogue_finale_explosions", var_2);
  earthquake(0.5, 0.6, level.player getEye(), 100);
  var_3 = scripts\engine\utility::get_array_of_closest(level._id_B4F9.origin, getaiarray("axis"), undefined, undefined, 800, 10);

  if(var_3.size) {
    scripts\engine\utility::array_thread(var_3, scripts\sp\utility::_id_54C6);
  }
}

_id_6C32() {
  thread _id_6C21();
  wait 49;
  var_0 = ["fin_exploderight1", "fin_exploderight2", "fin_exploderight3", "fin_explodeleft1", "fin_explodeleft2", "fin_explodeleft3"];
  var_1 = 0;
  var_2 = level.player scripts\sp\maps\rogue\surface::_id_79D8(80);
  playworldsound("scn_rogue_finale_explosions", var_2);

  foreach(var_4 in var_0) {
    thread scripts\engine\utility::exploder(var_4);
    var_1++;
    earthquake(0.7, 0.6, level.player getEye(), 100);
    level.player playRumbleOnEntity("grenade_rumble");
    wait 0.25;
  }
}

_id_6C21() {
  scripts\engine\utility::flag_wait("final_explosion");

  if(getdvarint("loop_finale", 0) == 0) {
    var_0 = level._id_B8D2 scripts\sp\endmission::_id_7F6B(level.script);
    var_1 = var_0 + 1;

    if(var_0 == level._id_B8D2._id_ABFA.size - 1) {
      var_1 = var_0;
    }

    var_2 = scripts\sp\endmission::_id_7F6D(var_1);
    thread scripts\sp\endmission::_id_1463(var_2);
  }

  wait 1.7;
  thread scripts\engine\utility::exploder("fin_explodefinal1");
  var_3 = anglesToForward(level.player getplayerangles());
  var_4 = level.player.origin + var_3 * 80;
  playFX(level._effect["vfx_ra_finale_expl_medium"], var_4);
  playworldsound("scn_rogue_finale_big_explo", level.player.origin);
  earthquake(0.45, 1, level.player.origin, 100);
  level.player playRumbleOnEntity("grenade_rumble");
  wait 0.25;
  level.player disableweapons();
  var_5 = getweaponmodel(getweaponbasename(level.player getcurrentprimaryweapon()));
  thread _id_0B60::_id_11A18(var_5);
  level.player._id_E505 waittillmatch("single anim", "end");
  _id_4057();
}

_id_6C20() {
  var_0 = getspawnerarray("final_swarm");
  var_1 = 0;

  while(var_1 < 10) {
    foreach(var_3 in var_0) {
      var_4 = var_3 _meth_8393();

      if(!scripts\sp\utility::_id_106ED(var_4)) {
        var_1++;
        wait(randomfloatrange(0.15, 0.4));
      }
    }

    wait 0.05;
  }
}

_id_6C2A() {
  self.goalradius = 50;
  _id_0A03::_id_13DC1(0);

  if(scripts\engine\utility::cointoss()) {
    self setgoalentity(level._id_B4F9);
  } else {
    self setgoalentity(level.player);
  }

  wait 0.15;
  var_0 = scripts\engine\utility::getfx("vfx_ra_glow_c6_head_atteck_a");
  var_1 = scripts\engine\utility::getfx("vfx_ra_glow_c6_head_atteck_b");
  playFXOnTag(var_0, self, "TAG_EYE");
  playFXOnTag(level._effect["RA_burnup_scrnfx"], self, "tag_origin");
}

_id_37BC(var_0) {
  if(isDefined(level._id_9CB9)) {
    return;
  }
  level._id_9CB9 = 1;
  level endon("stop_shake");
  scripts\engine\utility::delaythread(var_0, ::_id_1103C);

  while(isDefined(level._id_9CB9)) {
    var_1 = randomfloatrange(1.6, 2.2);
    var_2 = randomfloatrange(0.9, 1.5);
    var_3 = randomfloatrange(0.6, 1);
    var_4 = 0.15;
    var_5 = var_4 * 0.5;
    var_6 = var_4 * 0.5;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    var_11 = 1;
    level.player _meth_8291(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    wait(var_4);
  }
}

_id_1103C() {
  level._id_9CB9 = undefined;
}

_id_6C55() {
  scripts\engine\utility::exploder("omarsun");
}

_id_1067D() {
  var_0 = getspawner("burning_civ", "targetname");
  var_0.count = 100;
  var_1 = undefined;

  while(!isDefined(var_1)) {
    var_1 = scripts\sp\utility::_id_107EA("burning_civ", 1);
    wait 0.05;
  }

  var_1.diequietly = 1;
  var_1 scripts\sp\utility::_id_5564();
  var_1.ignoreme = 1;
  var_1.ignoreall = 1;
  var_1._id_BFED = 1;
  var_1 thread scripts\sp\utility::_id_5131();
  var_1.name = "";
  return var_1;
}

_id_3F94(var_0) {
  self.a.nodeath = 1;

  while(self _meth_81A6()) {
    wait 0.05;
  }

  var_0 scripts\sp\anim::_id_1EE0(self, "finale_scene");
}

_id_D066() {
  thread audio_slomo_settings();
  level.player thread _id_CFED();
  var_0 = level.player scripts\sp\maps\rogue\surface::_id_79D8(80);
  earthquake(0.5, 1, level.player.origin, 100);
  playFX(level._effect["vfx_ra_finale_expl_medium"], level.player getEye());
  scripts\engine\utility::exploder("preblackout_exploder");
  playworldsound("scn_rogue_finale_big_explo_01", level.player.origin);
  level.player playRumbleOnEntity("grenade_rumble");
  var_1 = spawn("script_origin", level.player.origin);
  var_1 playLoopSound("player_fall_tinnitus");
  level.player _meth_82C0("rogue_knockdown", 2);
  level.player scripts\engine\utility::delaycall(0.15, ::playsound, "rogue_plr_fall");
  thread _id_6C53(1, 0.5, 1);
  scripts\engine\utility::delaythread(3, ::_id_6C52, 0.25);
  scripts\engine\utility::flag_wait("flag_fnl_player_fall");
  level.player playSound("rogue_plr_struggle");
  level.player playRumbleOnEntity("grenade_rumble");
  thread scripts\sp\hud_util::_id_6AA3(0, "black");
  thread _id_6C34();
  thread _id_FB8D();
  level.player._id_5942 = 1;
  level notify("stop_temp_meter");
  thread scripts\sp\maps\rogue\rogue_util::_id_12970();
  thread scripts\sp\maps\rogue\rogue_util::stop_player_burn();
  wait 0.1;
  level._id_71B0 = scripts\engine\utility::array_removeundefined(level._id_71B0);
  scripts\sp\utility::_id_228A(level._id_71B0);
  killfxontag(scripts\engine\utility::getfx("rogue_sun_sprite"), level._id_111C3.ent, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("rogue_skybox_only"), level.player, "tag_origin");
  thread scripts\sp\hud_util::_id_6A99(2, "black");
  thread scripts\sp\utility::_id_111DA((0, 0, 0), (0, 0, 0), 1.0);
  thread _id_4057();
  var_1 _meth_8278(0, 2);
  var_1 scripts\engine\utility::delaycall(2.1, ::delete);
  thread scripts\engine\utility::exploder("playerknockdown");
  scripts\engine\utility::exploder("pldown_01");
  scripts\sp\gameskill::_id_8587("left");
  scripts\sp\gameskill::_id_8587("bottom");
  level.player scripts\engine\utility::delaycall(2, ::clearclienttriggeraudiozone, 30);
}

_id_4057() {
  foreach(var_1 in getaiarray("axis")) {
    if(isDefined(var_1._id_A865)) {
      var_1._id_A865 _meth_81D5();
      var_1._id_A865 delete();
    }

    var_1 delete();
  }
}

_id_6C53(var_0, var_1, var_2) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 1);
  _id_0B0B::_id_F5A0();
  setslowmotion(var_0, var_1, var_2);
  level._id_4BAF = var_1;
}

_id_6C52(var_0) {
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 1);
  setslowmotion(level._id_4BAF, 1, var_0);
  wait(var_0);
  _id_0B0B::_id_F59F();
}

_id_6C34() {
  level.player _meth_81DE(55, 0.05);
  setsaveddvar("r_dof_hq", 1);
  thread _id_0B0A::_id_583F(0, 15.3231, 5.181, 0, 319.554, 2.55, 0.05);
  scripts\engine\utility::flag_wait("drag_start");
  var_0 = 5;
  level.player _meth_81DE(67, var_0);
  thread _id_0B0A::_id_583D(var_0);
}

reset_finale_dof_var(var_0) {
  wait(var_0);
  setsaveddvar("r_dof_hq", 0);
}

_id_CFED() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);
    wait 0.05;
  }
}

_id_4049() {
  self endon("death");

  while(self _meth_81A6()) {
    wait 0.1;
  }

  if(isDefined(self._id_B14F)) {
    scripts\sp\utility::_id_1101B();
  }

  self delete();
}

_id_6C51(var_0) {
  var_1 = _id_1067D();
  var_1._id_1FBB = "civ_dead_0";

  if(getdvarint("debug_finale_anims")) {
    var_1 thread scripts\sp\maps\rogue\rogue_util::_id_D8E9(var_1._id_1FBB);
  }

  var_0 scripts\sp\anim::_id_1F35(var_1, "finale_scene");

  if(isDefined(var_1._id_B14F) && var_1._id_B14F) {
    var_1 scripts\sp\utility::_id_1101B();
  }
}

_id_6C4B(var_0) {
  scripts\engine\utility::delaythread(10, scripts\engine\utility::flag_set, "flag_fnl_move_robots");
  thread _id_5142();
  level.player thread _id_71B5();
  scripts\engine\utility::array_thread(level.allies, ::_id_71B5);
  var_1 = getaiarray("axis");
  var_2 = scripts\engine\utility::get_array_of_closest(level.player.origin, var_1, undefined, 6, 500);
  var_3 = scripts\engine\utility::array_remove_array(var_1, var_2);
  scripts\engine\utility::array_call(var_3, ::delete);
  scripts\engine\utility::array_thread(var_2, scripts\sp\utility::_id_5550);
  scripts\engine\utility::delaythread(0.1, scripts\engine\utility::array_call, var_2, ::_meth_81D0);
  scripts\sp\utility::_id_22CA("opfor_fnl_end", ::_id_71B7);
  scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_22CD, "opfor_fnl_end", 1);

  if(isDefined(level._id_B33E)) {
    var_0 thread scripts\sp\anim::_id_1EC3(level._id_B33E, "finale_corpse");

    if(getdvarint("debug_finale_anims")) {
      level._id_B33E thread scripts\sp\maps\rogue\rogue_util::_id_D8E9(level._id_B33E._id_1FBB);
    }
  }

  level._id_10AC8 = scripts\sp\utility::array_removedeadvehicles(level.allies);
  scripts\sp\maps\rogue\civilians::_id_167A();

  for(var_4 = 2; var_4 <= 4; var_4++) {
    var_5 = _id_1067D();
    var_5._id_1FBB = "civ_dead_" + var_4;
    var_0 thread scripts\sp\anim::_id_1EC3(var_5, "finale_corpse");

    if(getdvarint("debug_finale_anims")) {
      var_5 thread scripts\sp\maps\rogue\rogue_util::_id_D8E9(var_5._id_1FBB);
    }

    wait 0.05;
  }

  scripts\sp\maps\rogue\civilians::_id_167A();
}

_id_71B8() {
  var_0 = gettime();
  var_1 = var_0 + 30000;

  while(var_0 < var_1) {
    scripts\sp\hud_util::_id_6AA3(randomfloatrange(1, 5), "black");
    scripts\sp\hud_util::_id_6A99(randomfloatrange(4, 8), "black");
  }
}

_id_71B6(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, "targetname");
  var_4 = undefined;
  var_5 = undefined;

  foreach(var_8, var_7 in var_3) {
    if(var_7.classname == "script_origin") {
      var_4 = var_7;
      continue;
    }

    if(var_7.classname == "script_brushmodel") {
      var_5 = var_7;
    }
  }

  var_5 linkTo(var_4);

  if(var_4.targetname == "fnl_roof_1l" || var_4.targetname == "fnl_roof_1r") {
    var_9 = var_4 scripts\engine\utility::spawn_tag_origin();
    var_10 = var_4 scripts\sp\maps\rogue\surface::_id_7C15(78, 1);
    var_9.origin = var_10 - (0, 0, 16);
    var_9.angles = var_9.angles - (0, 90, 0);
    var_9 linkTo(var_4);
    playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_ceilingopen_dustfall"), var_9, "tag_origin");
    scripts\engine\utility::noself_delaycall(20, ::stopfxontag, scripts\engine\utility::getfx("vfx_ra_finale_ceilingopen_dustfall"), var_9, "tag_origin");
    var_9 scripts\engine\utility::delaycall(21, ::delete);
  }

  var_11 = getEnt(var_4.script_parameters, "targetname");
  var_12 = var_4.origin[2] - var_11.origin[2];
  var_10 = var_11.origin + (0, 0, var_12);
  var_4 moveTo(var_10, var_1);

  if(!isDefined(var_4.script_noteworthy)) {
    return;
  }
  wait(var_2);
  thread _id_71B6(var_4.script_noteworthy, var_1 - var_2, var_2);
}

_id_71B1(var_0, var_1) {
  self endon("death");
  self.health = 20;
  wait(randomfloat(var_1));
  scripts\sp\utility::_id_7226(var_0);
  self delete();
}

_id_71B7() {
  self endon("death");
  self.health = 20;
  _id_0E29::_id_877F(self);

  while(distance2dsquared(self.origin, level._id_B4F9.origin) > squared(400)) {
    wait 0.05;
  }

  wait(randomfloatrange(0.6, 1.5));
  scripts\sp\utility::_id_54C6();
}

_id_71B5() {
  self notify("kill_flashlight");

  if(!isDefined(self._id_AC92)) {
    return;
  }
  if(isPlayer(self)) {
    stopFXOnTag(level._effect["ra_flashlight"], self._id_AC92, "tag_origin");
  } else {
    stopFXOnTag(level._effect["RA_Buddy_flashlight"], self._id_AC92, "tag_origin");
  }
}

_id_FB8D() {
  wait 3;
  level.player playSound("scn_rogue_outro_dropship_exfil_lr");
  scripts\engine\utility::flag_wait("finale_takeoff_begin");
  wait 5;
  level.player playSound("scn_rogue_outro_dropship_takeoff_lr");
}

_id_FB7A() {
  wait 1.7;
  level._id_5D6C playSound("scn_rogue_outro_dropship_descend");
  scripts\engine\utility::flag_wait("finale_dropship_landed");
  level._id_5D6C scripts\engine\utility::delaycall(2.1, ::playsound, "scn_rogue_outro_dropship_touchdown");
}

_id_4FD4() {
  _id_F34C(0.05, 0.1);
  _id_F612(0.05, 0.1);
  _id_F312(1, 2);
  _id_F5CB(0.5);
  var_0 = self _meth_8134();
  _id_F41E(var_0 * 0.75, var_0);
  thread _id_DAF1();
}

_id_DAF1() {
  self endon("stop_scripted_light");
  self endon("death");

  for(;;) {
    scripts\sp\utility::_id_EF15();
    var_0 = self._id_EDF2;
    var_1 = self._id_EDF2 + (self._id_EDF1 - self._id_EDF2) * 0.4;
    var_2 = self._id_EDF1 - (self._id_EDF1 - self._id_EDF2) * 0.4;
    var_3 = self._id_EDF1;
    var_4 = randomintrange(self.script_count_min, self.script_count_max);

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_6 = randomfloatrange(var_0, var_1);
      scripts\sp\lights::_id_AB83(var_6, _id_7933());
      scripts\sp\utility::script_delay();
      var_6 = randomfloatrange(var_2, var_3);
      scripts\sp\lights::_id_AB83(var_6, _id_7933());
    }

    scripts\sp\lights::_id_AB83(self._id_EDF1, _id_7933());
  }
}

_id_7933() {
  return randomfloatrange(self.script_delay_min, self.script_delay_max);
}

_id_F5CB(var_0) {
  if(!isDefined(self.script_threshold)) {
    self.script_threshold = var_0;
  }

  foreach(var_2 in self._id_AD22) {
    if(!isDefined(var_2.script_threshold)) {
      var_2.script_threshold = self.script_threshold;
    }
  }
}

_id_F34C(var_0, var_1) {
  if(!isDefined(self.script_delay_min)) {
    self.script_delay_min = var_0;
  }

  if(!isDefined(self.script_delay_max)) {
    self.script_delay_max = var_1;
  }
}

_id_F612(var_0, var_1) {
  if(!isDefined(self._id_EF1C)) {
    self._id_EF1C = var_0;
  }

  if(!isDefined(self._id_EF1B)) {
    self._id_EF1B = var_1;
  }
}

_id_F312(var_0, var_1) {
  if(!isDefined(self.script_count_min)) {
    self.script_count_min = var_0;
  }

  if(!isDefined(self.script_count_max)) {
    self.script_count_max = var_1;
  }
}

_id_F41E(var_0, var_1) {
  if(!isDefined(self._id_EDF2)) {
    self._id_EDF2 = var_0;
  }

  if(!isDefined(self._id_EDF1)) {
    self._id_EDF1 = var_1;
  }
}

_id_1033D() {
  var_0 = _id_4938();
  var_1 = _id_4938();
  var_2 = randomintrange(10, 300);
  var_3 = randomintrange(300, 500);
  var_4 = [var_2, var_3];
  var_5 = randomintrange(10, 150);
  var_6 = randomintrange(150, 250);
  var_7 = [var_5, var_6];
  var_8 = scripts\engine\utility::random(var_4);
  var_9 = scripts\engine\utility::random(var_7);
  var_0.x = var_8;
  var_0.y = var_9;
  var_4 = scripts\engine\utility::array_remove(var_4, var_8);
  var_7 = scripts\engine\utility::array_remove(var_7, var_9);
  var_10 = 250;
  var_11 = 350;
  var_12 = 275;
  var_13 = 350;
  var_14 = 0.4;
  var_15 = 0.7;
  var_16 = randomintrange(var_10, var_11);
  var_17 = randomintrange(var_12, var_13);
  var_0 setshader("vfx_ui_player_blood_drip", var_16, var_17);
  var_0.alpha = randomfloatrange(var_14, var_15);
  var_1.x = var_4[0];
  var_1.y = var_7[0];
  var_16 = randomintrange(var_10, var_11);
  var_17 = randomintrange(var_12, var_13);
  var_1 setshader("vfx_ui_player_blood_splat2", var_16, var_17);
  var_1.alpha = randomfloatrange(var_14, var_15);
  var_0 fadeovertime(10);
  var_0.alpha = 0;
  var_1 fadeovertime(10);
  var_1.alpha = 0;
}

_id_4938() {
  var_0 = newclienthudelem(level.player);
  var_0.x = 0;
  var_0.y = 0;
  var_0._id_02B4 = 1;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.foreground = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_0.enablehudlighting = 1;
  return var_0;
}

_id_6C3F(var_0) {
  scripts\engine\utility::exploder("liftoff");
  level.player playSound("scn_rogue_finale_second_last_explo");
}

_id_6C3A() {
  var_0 = getEnt("finale_drag_toggle_light", "targetname");
  var_1 = var_0 _meth_8134();
  var_0 setlightintensity(0);
  scripts\engine\utility::flag_wait("toggle_finale_drag_light");
  var_0 setlightintensity(var_1);
}