/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\pearlharbor\pearlharbor_crash.gsc
*************************************************************/

_id_C9DD() {
  setdvarifuninitialized("dropship_damage_debug", 0);
  setdvarifuninitialized("jank_civ", 0);
  precachemodel("veh_mil_air_un_dropship_hero_interior");
  precachemodel("veh_mil_air_un_dropship_hero_interior_rig");
  precachemodel("veh_mil_air_un_dropship_hero_interior_cockpit_dash");
  precachemodel("veh_mil_air_un_dropship_hero_interior_pilot_seat");
  precachemodel("veh_mil_air_un_dropship_hero_interior_screens_dest1");
  precachemodel("veh_mil_air_un_dropship_hero_interior_screens_dest2");
  precachemodel("veh_mil_air_un_dropship_hero_interior_screens_dest3");
  precachemodel("veh_mil_air_un_dropship_hero_interior_screens_dest4");
  precachemodel("veh_mil_air_un_dropship_hero_interior_props_cockpit");
  precachemodel("veh_mil_air_un_dropship_hero_windshield_spiderweb");
  precachemodel("veh_mil_air_un_dropship_hero_windshield_cracked");
  precachemodel("weapon_g18_vm");
  precachemodel("frag_grenade_prop");
  scripts\engine\utility::flag_init("crash_bar_dialogue_done");
  scripts\engine\utility::flag_init("cart_destroyed");
  scripts\engine\utility::flag_init("crash_wakeup_start");
  scripts\engine\utility::flag_init("crash_wakeup_complete");
  scripts\engine\utility::flag_init("crash_wakeup_jumpout");
  scripts\engine\utility::flag_init("crash_player_jumper_dead");
  scripts\engine\utility::flag_init("crash_salter_jumper_dead");
  scripts\engine\utility::flag_init("mall_dropship_leaving");
  scripts\engine\utility::flag_init("grenade_tutorial_success");
  scripts\engine\utility::flag_init("grenade_dropship_leave");
  scripts\engine\utility::flag_init("grenade_tut_target_player");
  scripts\engine\utility::flag_init("grenade_tut_shooting_civis");
  scripts\engine\utility::flag_init("grenade_tut_allies_attack");
  scripts\engine\utility::flag_init("grenade_tut_dropship_unload");
  scripts\engine\utility::flag_init("grenade_give_scene_started");
  scripts\engine\utility::flag_init("grenade_give_scene_done");
  scripts\engine\utility::flag_init("player_threw_grenade");
  scripts\engine\utility::flag_init("grenade_tut_player_threw_grenade");
  scripts\engine\utility::flag_init("grenade_enemies_alerted");
  scripts\engine\utility::flag_init("start_running_civs");
  scripts\engine\utility::flag_init("kill_bar_corpses");
  scripts\engine\utility::flag_init("salter_jumped_out");
  scripts\engine\utility::flag_init("player_has_gun_mall");
  scripts\engine\utility::flag_init("grenade_vo_complete");
  scripts\engine\utility::flag_init("crash_combat_started");
  scripts\engine\utility::flag_init("ignore_player_intro");
  scripts\sp\utility::_id_22CA("harbor_vista_capitalships", ::_id_8B26);
  scripts\sp\utility::_id_22C9("bar_sdf_armada", ::_id_281A);
  scripts\sp\utility::_id_22C9("grenade_tut_dropship_guys", ::_id_85A6);
  scripts\sp\utility::_id_22C9("grenade_tut_civi_runners", ::_id_85A3);
  getEnt("crash_bar_flyby_dropship", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_47F1);
  getEnt("grenade_tut_dropship", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_85A4);
  getspawner("grenade_tut_seeker_civ", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_85A9);
  scripts\engine\utility::array_thread(getEntArray("enable_cqb", "script_noteworthy"), scripts\sp\maps\pearlharbor\pearlharbor_util::_id_61E6);
  scripts\engine\utility::array_thread(getEntArray("disable_cqb", "script_noteworthy"), scripts\sp\maps\pearlharbor\pearlharbor_util::_id_5513);
  scripts\sp\utility::_id_16EB("grenade_tut", &"PHSTREETS_GRENADE_TUT", ::_id_85AA);
  thread _id_8595(1);
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_lfe_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_1_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_alt_2_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_alt_3_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_alt_4_2d", 0.15);
  soundsettimescalefactor("weap_npc_main_3d", 0.2);
  soundsettimescalefactor("weap_npc_mech_3d", 0.2);
  soundsettimescalefactor("weap_npc_mid_3d", 0.2);
  soundsettimescalefactor("weap_npc_lfe_3d", 0);
  soundsettimescalefactor("weap_npc_dist_3d", 0.2);
  soundsettimescalefactor("weap_npc_lo_3d", 0.2);
  soundsettimescalefactor("spear_refl_close_unres_3d_lim", 0.15);
  soundsettimescalefactor("spear_refl_unres_3d_lim", 0.15);
  soundsettimescalefactor("explo_1_3d", 0.2);
  soundsettimescalefactor("explo_2_3d", 0.2);
  soundsettimescalefactor("explo_3_3d", 0.2);
  soundsettimescalefactor("explo_4_3d", 0.2);
  soundsettimescalefactor("bulletflesh_1_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_2_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_lfe_unres_2d_lim", 0);
  soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_npcnpc1_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_npcnpc2_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletimpact_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletimpact_lo_unres_3d_lim", 0.2);
  soundsettimescalefactor("bullet_ricochets_unres_3d_lim", 0.2);
  soundsettimescalefactor("physics_lo_unres_3d_lim", 0.2);
  soundsettimescalefactor("foley_npc_step_3d", 0.2);
  soundsettimescalefactor("foley_npc_mvmt_unres_3d_lim", 0.2);
  soundsettimescalefactor("whizby_out_unres_3d_lim", 0.2);
  soundsettimescalefactor("whizby_in_unres_3d_lim", 0.2);
  soundsettimescalefactor("special_lo_unres_1_2d", 0.15);
  soundsettimescalefactor("voice_plr_breath_2d", 0.15);
  soundsettimescalefactor("scn_lfe_unres_3d", 0);
  soundsettimescalefactor("scn_lfe_unres_2d", 0);
  soundsettimescalefactor("pa_speaker", 0.15);
  soundsettimescalefactor("amb_bed_2d", 0.25);
  soundsettimescalefactor("amb_elm_unres_3d", 0.25);
  soundsettimescalefactor("amb_elm_ext_unres_3d", 0.25);
  soundsettimescalefactor("amb_elm_ext_special_unres_3d", 0.25);
  soundsettimescalefactor("vehicle_air_loops_3d_lim", 0.15);
}

_id_481B() {
  thread _id_47F0();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_crash");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("", 1);
  scripts\sp\utility::_id_15F5("mall_corpse_trig");
}

_id_47F0() {
  level.player _meth_82C0("phstreets_atrium_dropship_start", 0.0);
  wait 6;
  wait 1.5;
  level.player _meth_82C0("phstreets_atrium_dropship_fall", 5.0);
}

_id_480E() {
  thread _id_480F();
  level.player _meth_80D1();
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player _meth_8185();

  while(iscinematicplaying()) {
    wait 0.05;
  }

  setsaveddvar("r_dof_hq", 1);
  level.player allowreload(0);
  level.player disableweaponpickup();
  level.player freezecontrols(0);
  level.player showhud();

  if(scripts\sp\utility::_id_93A6()) {
    level.player.ignoreme = 1;
    scripts\sp\specialist_MAYBE::_id_F2A6(1);
  }

  if(!scripts\sp\utility::_id_93A6()) {
    level.player takeallweapons();
  }

  level.player disableweapons();
  scripts\sp\utility::_id_15F5("mall_corpse_trig");
  thread _id_13857();
  thread _id_481D();
  level.allies["admiral"] scripts\sp\utility::_id_F3B5("g");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("b");
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("y");
  level.allies["salter"] scripts\sp\utility::_id_86E4();
  level.allies["salter"] thread scripts\sp\utility::_id_BE49();

  foreach(var_1 in level.allies) {
    var_1.ignoreme = 1;
    var_1.ignoreall = 1;
  }

  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "scn_phstreets_dropship_ringing_intro_lr");
  wait 6;
  var_3 = scripts\engine\utility::getStruct("dropship_wakeup_struct", "targetname");
  var_4 = scripts\sp\utility::_id_10639("player_rig", level.player.origin);
  level.player._id_4815 = var_4;
  var_5 = scripts\sp\utility::_id_10639("dropship");
  var_5 attach("veh_mil_air_un_dropship_hero_interior_rig", "tag_connect");
  var_5 attach("veh_mil_air_un_dropship_hero_interior", "tag_connect");
  var_5 attach("veh_mil_air_un_dropship_hero_interior_cockpit_dash", "TAG_COCKPIT_DASH");
  var_5 attach("veh_mil_air_un_dropship_hero_interior_pilot_seat", "TAG_PILOT_SEAT_LE");
  var_5 attach("veh_mil_air_un_dropship_hero_interior_pilot_seat", "TAG_PILOT_SEAT_RI");
  var_5 attach("veh_mil_air_un_dropship_hero_interior_props_cockpit", "TAG_PROPS_COCKPIT");
  var_5 thread _id_5E97();
  var_5 thread _id_5E00();
  var_5._id_1FBB = "dropship";
  level._id_4820 = var_5;
  var_6 = _id_4331();
  var_6["player"] thread _id_4313(var_4);
  scripts\engine\utility::flag_set("crash_wakeup_start");
  thread _id_D0E9();
  thread _id_11770();
  thread _id_B2B9();
  thread _id_47FB();
  var_6["player"] thread _id_A4E0();
  var_3 _id_432E(var_4, var_5, var_6);
  var_3 thread _id_432A(var_4, var_6["player"]);
  var_3 thread _id_432B(level.allies["salter"], var_6["salter"]);
  var_3 _id_4314(var_4);
  level.allies["salter"] thread scripts\sp\utility::_id_19FA(level.allies["salter"].weapon, "iw7_m8+m8scope_sp", 512, 0);
  setsaveddvar("r_dof_hq", 0);
  scripts\engine\utility::flag_set("crash_wakeup_complete");

  foreach(var_8 in level.allies) {
    var_8.ignoreme = 0;
    var_8.ignoreall = 0;

    if(var_8 == level.allies["salter"]) {
      continue;
    }
    var_9 = scripts\engine\utility::getStruct("crash_combat_tele_" + var_8._id_1FBB, "targetname");
    var_8 _meth_80F1(var_9.origin, var_9.angles);
  }

  level.allies["salter"] thread scripts\sp\utility::_id_BE4A();
  level thread _id_5E5B(var_5);
  scripts\engine\utility::flag_set("ignore_player_intro");
}

_id_480F() {
  var_0 = scripts\sp\hud_util::_id_48B7("black", 1, level.player);
  scripts\engine\utility::flag_wait("crash_wakeup_start");
  wait 2;
  var_1 = 2;
  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
}

_id_5E97() {
  var_0 = undefined;
  var_1 = gettime();
  var_2 = 21500;

  while(gettime() - var_1 < var_2) {
    wait(randomfloatrange(0.05, 0.1));

    if(isDefined(var_0)) {
      self detach(var_0, "TAG_COCKPIT_SCREENS");
    }

    if(scripts\engine\utility::cointoss()) {
      var_0 = undefined;
      continue;
    }

    var_0 = "veh_mil_air_un_dropship_hero_interior_screens_dest" + randomintrange(1, 4);
    self attach(var_0, "TAG_COCKPIT_SCREENS");
  }

  if(isDefined(var_0)) {
    self detach(var_0, "TAG_COCKPIT_SCREENS");
  }
}

_id_5E00() {
  self attach("veh_mil_air_un_dropship_hero_windshield_spiderweb", "TAG_GLASS");
  wait 21.5;
  self detach("veh_mil_air_un_dropship_hero_windshield_spiderweb", "TAG_GLASS");
  self attach("veh_mil_air_un_dropship_hero_windshield_cracked", "TAG_GLASS");
}

_id_D0E9() {
  level.player.ignoreme = 1;
  scripts\engine\utility::flag_wait("ignore_player_intro");
  wait 2;
  level.player.ignoreme = 0;
}

_id_5E5B(var_0) {
  var_1 = spawn("script_model", var_0 gettagorigin("tag_connect"));
  var_1 setModel("veh_mil_air_un_dropship_hero_interior");
  var_1.angles = var_0 gettagangles("tag_connect");
  var_2 = spawn("script_model", var_0 gettagorigin("TAG_COCKPIT_DASH"));
  var_2 setModel("veh_mil_air_un_dropship_hero_interior_cockpit_dash");
  var_2.angles = var_0 gettagangles("TAG_COCKPIT_DASH");
  var_3 = spawn("script_model", var_0 gettagorigin("TAG_PILOT_SEAT_LE"));
  var_3 setModel("veh_mil_air_un_dropship_hero_interior_pilot_seat");
  var_3.angles = var_0 gettagangles("TAG_PILOT_SEAT_LE");
  var_4 = spawn("script_model", var_0 gettagorigin("TAG_PILOT_SEAT_RI"));
  var_4 setModel("veh_mil_air_un_dropship_hero_interior_pilot_seat");
  var_4.angles = var_0 gettagangles("TAG_PILOT_SEAT_RI");
  var_0 detachall();
  scripts\engine\utility::flag_wait("grenade_give_scene_started");
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
}

_id_B2B9() {
  var_0 = scripts\engine\utility::getStruct("dropship_wakeup_struct", "targetname");
  var_1 = scripts\sp\vehicle::_id_1080C("cockpit_wakeup_enemy_dropship");
  var_1._id_1FBB = "sdf_dropship";
  var_1 hidepart("j_backlandinggear_ri", "veh_mil_air_ca_dropship");
  var_1 hidepart("j_backlandinggear_le", "veh_mil_air_ca_dropship");
  var_1 thread _id_5ED0("dropship_turret_1", 1);
  var_1 thread _id_B2B8();
  var_0 scripts\sp\anim::_id_1F35(var_1, "mall_sdf_dropship_2");
  var_1 delete();
  var_1 thread _id_135C2();
}

_id_B2B8() {
  var_0 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_B284(level.player);
  var_0 scripts\sp\utility::_id_E7C9(0.1, 5);
  wait 3;
  var_0 scripts\sp\utility::_id_E7C9(0.35, 0.5);
  wait 4;
  var_0 scripts\sp\utility::_id_E7C9(0.1, 1);
  wait 8;
  earthquake(0.7, 1.5, level.player.origin, 100);
  var_0 scripts\sp\utility::_id_E7C9(3, 0.05);
  level.player playRumbleOnEntity("grenade_rumble");
  wait 2;
  var_0 delete();
}

_id_135C2() {
  self waittill("single anim");
  self delete();
}

_id_5D30() {
  wait 11;
  scripts\sp\vehicle::_id_13253();
}

_id_5ED0(var_0, var_1) {
  var_2 = self.mgturret[0];
  var_2 setmode("manual");
  var_2 hide();

  if(!var_1) {
    level._id_5014 = var_2;
  }

  var_3 = scripts\sp\utility::_id_10639("dropship_turret");
  level._id_5014 = var_3;
  scripts\sp\anim::_id_1EC3(var_3, var_0);
  var_3 linkTo(self);
  var_3 thread _id_12926(var_1);
  thread scripts\sp\anim::_id_1F35(var_3, var_0);
  level waittill("stop_fire");
  var_3 scripts\engine\utility::stop_loop_sound_on_entity("dropship_gatling_fire");
  self waittill("single anim");
  var_3 delete();
}

_id_12926(var_0) {
  level endon("stop_fire");

  if(var_0) {
    level waittill("start_fire");
  } else {
    wait 9;
  }

  var_1 = "tag_flash";
  var_2 = "generic_mg_turret_nosound";
  thread scripts\sp\utility::play_loop_sound_on_tag("dropship_gatling_fire", var_1, 1, 1, "dropship_gatling_release");

  for(;;) {
    var_3 = anglesToForward(self gettagangles(var_1)) * 250;
    var_4 = self gettagorigin(var_1);
    var_5 = self.origin + anglesToForward(self gettagangles(var_1)) * 999;
    var_6 = bulletTrace(var_4, var_5, 0, self);
    var_5 = var_6["position"];
    var_7 = magicbullet(var_2, var_4, var_5);
    playFXOnTag(level._effect["30mm_flash"], self, var_1);
    bullettracer(var_4, var_5, undefined, 1);
    wait 0.1;
  }

  self notify("stop sounddropship_gatling_release");
}

_id_481D() {
  scripts\engine\utility::flag_wait("crash_wakeup_start");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0._id_1120D = (-38, 62, 0);
  var_0._id_75AC = (0, 0, 0);
  var_1 = (150000, 0, 0);
  var_1 = rotatevector(var_1, var_0._id_1120D + var_0._id_75AC);
  var_2 = level.player.origin;
  var_0.origin = var_2 + var_1;
  scripts\engine\utility::flag_wait("ledge_guys_fallback");
}

_id_432E(var_0, var_1, var_2, var_3) {
  var_4 = [var_0, var_1, level.allies["salter"]];
  var_4 = scripts\engine\utility::array_combine(var_4, var_2);
  playFXOnTag(level._effect["vfx_ph_crash_cabin_smoke"], var_1, "tag_origin");
  level.player _meth_823B(var_0, "tag_player");
  thread _id_C5F8(var_0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player _meth_80D1();
  thread _id_10BEF();
  thread _id_4809();
  thread _id_13859();
  wait 0.1;
  level._id_4820 hidepart("tag_glass");
  var_5 = scripts\sp\utility::_id_10639("g18", level.allies["salter"] gettagorigin("tag_inhand"), level.allies["salter"] gettagangles("tag_inhand"));
  var_5 linkTo(level.allies["salter"], "tag_inhand");
  var_5 scripts\engine\utility::delaycall(20, ::delete);
  thread _id_13854();
  thread _id_13856();
  thread _id_13855();
  thread scripts\sp\anim::_id_1F2C(var_4, "dropship_wakeup");
}

_id_13855() {
  wait 16;
  level.player lerpviewangleclamp(2, 1, 1, 0, 0, 0, 0);
  wait 5;
  var_0 = 20;
  level.player lerpviewangleclamp(2, 1, 1, var_0, var_0, var_0, var_0);
}

_id_C5F8(var_0) {
  wait 6;
  var_1 = 20;
  level.player playerlinktodelta(var_0, "tag_player", 1, var_1, var_1, var_1, var_1, 1);
}

_id_13854() {
  wait 1;
  setblur(10, 1);
  wait 2;
  setmusicstate("mx_101_crash_wakeup");
  setblur(0, 1.5);
}

_id_13856() {
  level.player _meth_81DE(50, 0.05);
  wait 2;
  thread _id_0B0A::_id_583F(0, 25, 3.9, 7500, 8950, 1.5, 3);
  wait 6;
  level.player _meth_81DE(65, 4);
  thread _id_0B0A::_id_583F(0, 25, 3.9, 0, 75000, 1.5, 3);
  wait 9;
  thread _id_0B0A::_id_583F(0, 25, 3.9, 7200, 9000, 1.5, 3);
  wait 1;
  thread _id_0B0A::_id_583F(0, 25, 3.9, 2300, 17000, 1.5, 4);
  thread _id_0B0A::_id_583D(1);
}

_id_5EDA(var_0) {
  scripts\sp\anim::_id_1F35(var_0, "dropship_wakeup");
}

_id_50D9(var_0) {
  wait 2;
  var_1 = 2;
  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
}

_id_10BEF() {
  wait 10;
  scripts\engine\utility::flag_set("start_running_civs");
}

_id_432A(var_0, var_1) {
  wait(getanimlength(var_0 scripts\sp\utility::_id_7DC1("dropship_wakeup")));
  level.player _meth_80A1();
  level notify("delete_patio_furniture");
  thread _id_4312(var_0);

  if(scripts\engine\utility::flag("crash_player_jumper_dead")) {
    return;
  }
  thread scripts\sp\anim::_id_1EEA(var_1, "dropship_wakeup_struggle");
}

_id_4312(var_0) {
  level endon("crash_player_jumper_dead");
  level endon("crash_wakeup_complete");
  level.player waittill("death");
  var_1 = 0;
  level.player playerlinktodelta(var_0, "tag_player", 1, var_1, var_1, var_1, var_1, 1);
  thread scripts\sp\anim::_id_1F35(var_0, "dropship_wakeup_death");
  setslowmotion(0.15, 1, 0.25);
}

_id_AD0E() {
  var_0 = level.player._id_4815;
  var_0._id_AB36 = 47;
  var_0._id_E514 = 35;
  var_0._id_12D73 = 35;
  var_0._id_5AEF = 15;
  level.player playerlinktodelta(var_0, "tag_player", 1, var_0._id_E514, var_0._id_AB36, var_0._id_12D73, var_0._id_5AEF, 1);
}

_id_4313(var_0) {
  level endon("salter_jumper_takedown");
  level waittill("player_jumper_allow_death");
  var_1 = 125;
  setglobalsoundcontext("atmosphere", "killcam", 0.05);
  scripts\engine\utility::flag_set("player_has_gun_mall");

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_2, var_2, var_2, var_6, var_2, var_2);

    if(var_3 == level.player) {
      if(isDefined(var_6) && var_6 == "j_helmet") {
        thread _id_0C60::_id_8E17();
      }

      var_7 = scripts\sp\damagefeedback::isheadshot(var_6);
      level.player scripts\sp\damagefeedback::updatehitmarker("high_damage", 1, var_7, self);
      scripts\sp\utility::_id_DFE6(scripts\sp\damagefeedback::_id_4D4C);
      break;
    }
  }

  scripts\engine\utility::flag_set("crash_player_jumper_dead");
  var_8 = scripts\engine\utility::getStruct("dropship_wakeup_struct", "targetname");
  var_8 scripts\sp\anim::_id_1F35(self, "dropship_wakeup_takedown");
}

_id_117F5() {
  var_0 = self._id_AB36;
  var_1 = self._id_E514;
  var_2 = self._id_12D73;
  var_3 = self._id_5AEF;
  var_4 = 2;
  level.player freezecontrols(1);

  while(var_0 > 0 || var_1 > 0 || var_2 > 0 || var_3 > 0) {
    var_0 = _id_C247(var_0, var_4);
    var_1 = _id_C247(var_1, var_4);
    var_2 = _id_C247(var_2, var_4);
    var_3 = _id_C247(var_3, var_4);

    if(isDefined(self)) {
      level.player playerlinktodelta(self, "tag_player", 1, var_1, var_0, var_2, var_3, 1);
    } else {
      break;
    }

    wait 0.05;
  }

  level.player freezecontrols(0);
}

_id_C247(var_0, var_1) {
  if(var_0 > 0) {
    if(var_0 - var_1 <= 0) {
      var_0 = 0;
    } else {
      var_0 = var_0 - var_1;
    }
  }

  return var_0;
}

_id_430C() {
  var_0 = scripts\engine\utility::getStruct("dropship_wakeup_struct", "targetname");
  var_1 = getstartorigin(var_0.origin, var_0.angles, scripts\sp\utility::_id_7DC1("dropship_wakeup_takedown"));
  var_2 = getstartangles(var_0.origin, var_0.angles, scripts\sp\utility::_id_7DC1("dropship_wakeup_takedown"));
  self _meth_80F1(var_1, var_2);
  self animmode("gravity");
  self orientmode("face angle", var_2[1]);
  self _meth_82EA("cockpitDeathAnim", scripts\sp\utility::_id_7DC1("dropship_wakeup_takedown"), 1, 0.2, 1);
  _id_0A1E::_id_231F(self.asmname, "cockpitDeathAnim");
}

_id_432B(var_0, var_1) {
  var_1 thread _id_EAAA();
  var_2 = getanimlength(var_0 scripts\sp\utility::_id_7DC1("dropship_wakeup"));
  scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "crash_salter_jumper_dead");
  scripts\sp\utility::_id_178D(scripts\engine\utility::_timeout, var_2);
  scripts\sp\utility::_id_57D6();
  var_3 = [var_0, var_1];

  if(!scripts\engine\utility::flag("crash_salter_jumper_dead")) {
    var_1 scripts\sp\utility::_id_86E4();
    thread scripts\sp\anim::_id_1EE7(var_3, "dropship_wakeup_struggle");
  }

  var_0 scripts\sp\utility::_id_86E2();
  scripts\engine\utility::flag_wait_either("crash_player_jumper_dead", "crash_salter_jumper_dead");
  scripts\sp\utility::_id_178D(scripts\sp\utility::timeout, 0.5);
  scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "crash_salter_jumper_dead");
  scripts\sp\utility::_id_57D6();
  self notify("stop_loop");

  if(!scripts\engine\utility::flag("crash_salter_jumper_dead")) {
    level notify("salter_jumper_takedown");
    setslowmotion(0.15, 1, 1.5);
    var_1 thread _id_EAAB();
    scripts\sp\anim::_id_1F2C(var_3, "dropship_wakeup_tmout_takedown");
    scripts\engine\utility::flag_set("crash_salter_jumper_dead");
  } else {
    thread scripts\sp\anim::_id_1F35(var_1, "dropship_wakeup_takedown");
    scripts\sp\anim::_id_1F35(var_0, "dropship_wakeup_takedown");
  }

  thread scripts\sp\anim::_id_1F35(var_0, "dropship_wakeup_jumpout");
}

_id_EAAA() {
  level endon("crash_salter_jumper_dead");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_4, var_4, var_5, var_4, var_4);

    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 == level.player) {
      if(isDefined(var_5) && var_5 == "j_helmet") {
        thread _id_0C60::_id_8E17();
      }

      break;
    }
  }

  scripts\engine\utility::flag_set("crash_salter_jumper_dead");
}

_id_EAAB() {
  wait 1.4;
  _id_0C60::_id_8E17();
  playFX(level._id_7649["human_gib_head"], self gettagorigin("j_head"), (0, 0, 1));
}

_id_4314(var_0) {
  scripts\engine\utility::flag_wait("crash_player_jumper_dead");
  level.player _meth_80D1();
  level._id_5A5E = 0;
  scripts\engine\utility::flag_wait("crash_salter_jumper_dead");
  setslowmotion(0.15, 1, 0.5);
  scripts\engine\utility::flag_set("crash_wakeup_jumpout");
  var_0 hide();
  setglobalsoundcontext("atmosphere", "", 0.5);
  wait 0.5;
  level.player thread scripts\engine\utility::delaycall(2.5, ::clearclienttriggeraudiozone, 0.5);
  level.player scripts\sp\utility::_id_D090("ges_ph_crash_wakeup_jumpout");
  level.player _meth_823C(var_0, "tag_player", 0.25, 0, 0);
  scripts\sp\anim::_id_1F35(var_0, "dropship_wakeup_jumpout");

  if(scripts\sp\utility::_id_93A6()) {
    thread _id_10961();
  } else {
    level.player _meth_80A1();
  }

  thread scripts\sp\utility::_id_266F();
  level.player allowreload(1);
  level.player _meth_80DB();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player unlink();
  var_0 delete();
  _id_1160E();
  level._id_5A5E = 1;
}

_id_10961() {
  level.player.ignoreme = 0;
  scripts\sp\specialist_MAYBE::_id_F2A6(0);
  scripts\sp\specialist_MAYBE::_id_8E05();
  wait 2;
  level.player _meth_80A1();
}

_id_1160E() {
  var_0 = scripts\engine\utility::getStruct("crash_combat_tele_eth3n", "targetname");
  level.allies["eth3n"] _meth_83B9(var_0.origin + (0, 0, 50), var_0.angles);
  var_1 = scripts\engine\utility::getStruct("crash_combat_tele_admiral", "targetname");
  level.allies["admiral"] _meth_83B9(var_1.origin, var_1.angles);
}

_id_4331() {
  var_0 = [];
  var_1 = getspawnerarray("crash_dropship_jumpers");

  foreach(var_5, var_3 in var_1) {
    var_4 = var_3 scripts\sp\utility::_id_10619(1);
    var_4._id_1FBB = "jumper_" + var_5;
    var_4 scripts\sp\utility::_id_B14F(1);
    var_4.dropweapon = 0;

    if(var_5 == 0) {
      var_0["player"] = var_4;
      continue;
    }

    var_0["salter"] = var_4;
    var_4 scripts\sp\utility::_id_72EC(level.allies["salter"].weapon, "primary");
  }

  return var_0;
}

_id_A4E0() {
  wait 7;
  self playSound("phstreets_sf1_fanoutfireat");
  wait 2;
  self playSound("phstreets_sf1_targetanythingthat");
  wait 3;
  self playSound("phstreets_sf1_directfirenorth");
  wait 3;
  wait 2;
  self playSound("phsptreets_sdf2_getupthere");
}

_id_4332(var_0) {
  level.player thread _id_82C2();
}

_id_82C2(var_0, var_1) {
  self takeallweapons();
  self giveweapon("iw7_g18+elopstl");
  self givemaxammo("iw7_g18+elopstl");

  if(scripts\engine\utility::flag("crash_combat_complete")) {
    self takeweapon("iw7_g18+elopstl");
    self giveweapon("iw7_ar57+ar57scope");
    self givemaxammo("iw7_ar57+ar57scope");
    self switchtoweapon("iw7_ar57+ar57scope");
    self giveweapon("iw7_fhr");
    self givemaxammo("iw7_fhr");
  } else
    self switchtoweapon("iw7_g18+elopstl");

  if(isDefined(var_0) && var_0) {
    self _meth_831C("frag");
    self giveweapon("frag");
    self givemaxammo("frag");

    if(getdvarint("E3", 1)) {
      self takeweapon("frag");
      self giveweapon("seeker");
      self givemaxammo("seeker");
    }
  }

  if(isDefined(var_1) && var_1) {
    self giveweapon("hackingdevice");
    self givemaxammo("hackingdevice");
  }

  self enableweapons();
}

_id_4330() {
  var_0 = scripts\engine\utility::getStruct("mall_dropship_unload_node", "script_noteworthy");
  self._id_E7D0 = 0;
  self notsolid();
  var_1 = var_0 scripts\sp\utility::_id_7A97();
  var_2 = [];

  foreach(var_4 in var_1) {
    var_2[var_2.size] = var_4 scripts\engine\utility::spawn_tag_origin();
  }

  var_6 = self.mgturret[0];
  var_6 setmode("manual");
  var_6._id_ED25 = var_6._id_ED26;
  var_6.script_delay_max = var_6.script_delay_min;
  var_0 waittill("trigger");
  scripts\engine\utility::flag_wait("crash_wakeup_jumpout");
  scripts\sp\utility::_id_228A(var_2);
  self._id_E7D0 = 1;
}

_id_47FB() {
  thread _id_47FA();
  thread _id_2B1A("bl_civ_node_0", "blCiv0");
  thread _id_2B1A("bl_civ_node_1", "blCiv1", "blCiv1_idle");
}

_id_2B1A(var_0, var_1, var_2) {
  wait 10;
  var_3 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_4 = getspawner(var_3.target, "targetname");
  var_5 = var_4 scripts\sp\utility::_id_10619(1);
  var_5._id_1FBB = "crash_civ";
  var_5 setCanDamage(1);
  var_5 scripts\sp\utility::_id_F2A8(1);
  var_5._id_10265 = 1;
  var_5.forceragdollimmediate = 1;
  var_5 endon("death");
  var_3 scripts\sp\anim::_id_1EC3(var_5, var_1);

  if(isDefined(var_2)) {
    scripts\engine\utility::flag_wait("player_has_gun_mall");
    var_3 scripts\sp\anim::_id_1F35(var_5, var_1);
    var_3 thread scripts\sp\anim::_id_1EEA(var_5, var_2, "stop_idle");
    scripts\engine\utility::flag_wait("crash_bar_dialogue_done");
    var_5 delete();
  } else {
    scripts\engine\utility::flag_wait("player_has_gun_mall");
    var_5 thread _id_4867();
    var_3 scripts\sp\anim::_id_1F35(var_5, var_1);
    var_5 scripts\sp\utility::_id_19D3();
  }
}

_id_4867() {
  self endon("death");
  wait 18;
  scripts\anim\death::play_blood_pool();
}

_id_47FA() {
  var_0 = scripts\engine\utility::getStruct("dropship_wakeup_struct", "targetname");
  var_1 = getspawnerarray("crash_civ_tl");
  var_2 = getspawnerarray("crash_sdf_tl");
  var_3 = scripts\sp\utility::_id_22C6(var_1, 1);
  var_4 = scripts\sp\utility::_id_22C6(var_2, 1);
  wait 2;

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_3[var_5]._id_1FBB = "crash_civ_" + var_5;
    var_0 thread _id_3FB9(var_3[var_5], "wake_up_civs");
  }

  level._id_13853 = [];

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    level._id_13853[var_5] = var_4[var_5];
    var_4[var_5]._id_1FBB = "crash_sdf_" + var_5;
    var_0 thread _id_F05F(var_4[var_5], "wake_up_civs");
  }
}

_id_11770() {
  var_0 = scripts\engine\utility::getStruct("mall_lovers_node", "targetname");
  var_1 = getspawner("mall_lovers_male", "targetname");
  var_2 = getspawner("mall_lovers_fem", "targetname");
  var_1._id_ED1B = 1;
  var_2._id_ED1B = 1;
  var_1 = var_1 scripts\sp\utility::_id_10619(1);
  var_2 = var_2 scripts\sp\utility::_id_10619(1);
  var_1._id_1FBB = "lover_male";
  var_2._id_1FBB = "lover_female";
  var_3 = [var_1, var_2];
  var_0 scripts\sp\anim::_id_1EC1(var_3, "ph_lovers");
  level waittill("ds_falling");
  wait 1;
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "ph_lovers");
  var_0 thread scripts\sp\anim::_id_1F35(var_2, "ph_lovers");
  var_1 notsolid();
  var_2 notsolid();
  scripts\engine\utility::flag_wait("crash_combat_complete");
  var_1 delete();
  var_2 delete();
}

_id_3FB9(var_0, var_1) {
  scripts\sp\anim::_id_1EC3(var_0, var_1);
  scripts\sp\anim::_id_1F35(var_0, var_1);
  wait 7;
  var_0 delete();
}

_id_3FBA(var_0) {
  var_1 = level._id_5014;

  if(var_0._id_1FBB == "crash_civ_10") {
    var_1 = level._id_13853[0];
  }

  if(var_0._id_1FBB == "crash_civ_11") {
    var_1 = level._id_13853[1];
  }

  var_2 = ["tag_eye", "j_clavicle_le", "j_clavicle_ri", "j_hip_ri"];

  if(var_1 == level._id_5014) {
    for(var_3 = 0; var_3 < 3; var_3++) {
      var_4 = var_2[randomintrange(0, var_2.size)];
      var_5 = var_0 gettagorigin(var_4);
      playFXOnTag(level._effect["vfx_ph_big_civ_blood"], var_0, var_4);
      wait 0.25;
    }

    var_1 notify("stopfiring");
  } else {
    for(var_3 = 0; var_3 < randomintrange(3, 5); var_3++) {
      wait 0.1;
      var_4 = var_2[randomintrange(0, var_2.size)];
      var_5 = var_0 gettagorigin(var_4);
      playFXOnTag(level._effect["vfx_ph_big_civ_blood"], var_0, var_4);
    }
  }
}

_id_F05F(var_0, var_1) {
  scripts\sp\anim::_id_1EC3(var_0, var_1);
  scripts\sp\anim::_id_1F35(var_0, var_1);
  var_0 delete();
}

_id_13859() {
  wait 0.5;
  scripts\engine\utility::exploder("crashglass");
}

_id_4809() {
  scripts\engine\utility::exploder("55");
  var_0 = scripts\engine\utility::getStruct("dropship_wakeup_struct", "targetname");
  var_1 = [];
  var_2 = [];

  for(var_3 = 0; var_3 < 33; var_3++) {
    var_1[var_3] = ::scripts\sp\utility::_id_10639("crash_chair");
    var_1[var_3] notsolid();
    var_0 thread _id_C97A(var_1[var_3], "chair_" + var_3);
  }

  for(var_3 = 0; var_3 < 12; var_3++) {
    var_2[var_3] = ::scripts\sp\utility::_id_10639("crash_umbrella");
    var_2[var_3] notsolid();
    var_2[var_3]._id_113AF = scripts\sp\utility::_id_10639("crash_table");
    var_2[var_3]._id_113AF notsolid();
    var_2[var_3]._id_113AF.origin = var_2[var_3].origin;
    var_2[var_3]._id_113AF.angles = var_2[var_3].angles;
    var_2[var_3]._id_113AF linkTo(var_2[var_3]);
    var_0 thread _id_C97A(var_2[var_3], "umbrella_" + var_3);
  }
}

_id_13857() {
  var_0 = getspawnerarray("wake_up_slaughter_civ");

  foreach(var_2 in var_0) {
    var_2 thread _id_102CF();
  }
}

_id_102CF() {
  var_0 = self.animation;
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_2 = scripts\sp\utility::_id_10619(1);
  var_2._id_1FBB = "slaughter_civ";
  var_1 scripts\sp\anim::_id_1EC3(var_2, var_0);
  scripts\engine\utility::flag_wait("player_has_gun_mall");
  var_1 scripts\sp\anim::_id_1F35(var_2, var_0);
  var_2 notsolid();
  scripts\engine\utility::flag_wait("crash_combat_complete");
  var_2 delete();
}

_id_C97A(var_0, var_1) {
  scripts\sp\anim::_id_1F35(var_0, var_1);

  if(isDefined(var_0._id_113AF)) {
    var_0._id_113AF delete();
  }

  var_0 delete();
}

_id_47F7() {
  scripts\engine\utility::flag_set("crash_wakeup_complete");
  thread _id_481D();
  scripts\engine\utility::flag_set("crash_wakeup_start");
  level.allies["admiral"] scripts\sp\utility::_id_F3B5("g");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("b");
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("y");
  level.allies["salter"] thread scripts\sp\utility::_id_19FA(level.allies["salter"].weapon, "iw7_m8+m8scope_sp", 512, 0);

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_8E06();
  }
}

_id_4802() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_crash_combat");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("", 1);
  scripts\sp\utility::_id_15F5("mall_corpse_trig");
  thread _id_10743();
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_crash_combat", var_0);
  _id_8595();
}

_id_4800() {
  thread scripts\sp\utility::_id_12643(["phstreets_streets_tr", "geneva_periph_south_tr"]);
  level.player _meth_80D1();
  level.player scripts\engine\utility::delaycall(1, ::_meth_80A1);
  scripts\sp\utility::_id_28D8("axis");
  scripts\engine\utility::flag_set("crash_combat_started");
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("g");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("b");
  level.allies["admiral"] scripts\sp\utility::_id_F3B5("y");
  scripts\sp\utility::_id_15F5("start_crash_color_trig");
  thread _id_B2BB();
  thread _id_1CEE();
  thread _id_2814();
  _id_3B07();
  _id_1DB2();
  thread _id_47FE();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_1510("lake_vista_aatis_guns");
  thread _id_D22A();
  var_0 = getaiarray("axis");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_51E1("frantic");
  }

  thread _id_4801();
  thread _id_281B();
  thread _id_47FD();
  scripts\engine\utility::flag_wait("crash_combat_complete");
  waitforalltransients();
  scripts\engine\utility::flag_set("bar_color_trig");
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D7("axis");
}

_id_47FD() {
  scripts\engine\utility::flag_wait("crash_player_leaving_bar");
  scripts\sp\utility::_id_229F(getaiarray("axis"));
}

_id_281B() {
  level endon("grenade_give_started");
  scripts\engine\utility::flag_wait("bar_color_trig");
  scripts\sp\utility::_id_15F5("gate_color_trig");
  level.allies["admiral"] thread _id_281C("bar_stairs_run", "g");
  level.allies["salter"] thread _id_281C("bar_stairs_run", "b");
  level.allies["eth3n"] thread _id_281C("bar_stairs_run", "y");
}

_id_4801() {
  var_0 = getaiarray("axis");
  level._id_B2BA = 0;

  foreach(var_2 in var_0) {
    var_2 thread _id_874B();
  }

  var_4 = 3;

  while(!scripts\engine\utility::flag("mall_combat_retreat_1")) {
    var_0 = getaiarray("axis");

    foreach(var_2 in var_0) {
      if(!isDefined(var_2._id_EC1D)) {
        var_2 thread _id_874B();
      }
    }

    if(level._id_B2BA >= var_4) {
      scripts\engine\utility::flag_set("mall_combat_retreat_1");
      break;
    }

    wait 1;
  }

  level notify("score_reset");
  level._id_B2BA = 0;
  wait 0.5;
  var_7 = 4;

  while(!scripts\engine\utility::flag("mall_combat_retreat_2")) {
    var_0 = getaiarray("axis");

    foreach(var_2 in var_0) {
      if(!isDefined(var_2._id_EC1D)) {
        var_2 thread _id_874B();
      }
    }

    if(level._id_B2BA >= var_7) {
      scripts\engine\utility::flag_set("mall_combat_retreat_2");
      break;
    }

    wait 1;
  }
}

_id_B2BB() {
  var_0 = getspawnerteamarray("axis");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "mall_spawner") {
      var_1[var_1.size] = var_3;
    }
  }

  scripts\engine\utility::flag_wait("mall_combat_retreat_1");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_EDA0) && var_3._id_EDA0 == "mall_combat_retreat_1") {
      var_6 = var_3 scripts\engine\utility::get_target_ent();
      var_7 = var_6 scripts\engine\utility::get_target_ent();
      var_3.target = var_7.targetname;
    }
  }

  scripts\engine\utility::flag_wait("mall_combat_retreat_2");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_EDA0) && var_3._id_EDA0 == "mall_combat_retreat_2") {
      var_6 = var_3 scripts\engine\utility::get_target_ent();
      var_7 = var_6 scripts\engine\utility::get_target_ent();
      var_3.target = var_7.targetname;
    }
  }

  scripts\engine\utility::flag_wait("mall_combat_retreat_3");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_EDA0) && var_3._id_EDA0 == "mall_combat_retreat_3") {
      var_6 = var_3 scripts\engine\utility::get_target_ent();
      var_7 = var_6 scripts\engine\utility::get_target_ent();
      var_3.target = var_7.targetname;
    }
  }
}

_id_874B() {
  level endon("score_reset");
  self._id_EC1D = 0;
  self waittill("death", var_0);

  if(var_0 == level.player) {
    level._id_B2BA++;
  }
}

_id_10743() {
  level endon("crash_combat_complete");
  var_0 = getspawnerarray("crash_initial_spawner");
  _id_0B77::_id_6F5A(var_0);
  scripts\sp\utility::_id_127B3("top_guys_spawn_trig");
  var_0 = getspawnerarray("top_guy_spawner_mall");
  var_1 = scripts\sp\utility::_id_22C6(var_0, 1);

  foreach(var_3 in var_1) {
    var_3.fixednode = 1;
    var_3 thread _id_119F1();
  }

  scripts\engine\utility::flag_wait("top_guy_shot_at");

  foreach(var_3 in var_1) {
    if(isalive(var_3)) {
      var_3.ignoreall = 0;
    }
  }
}

_id_119F1() {
  self endon("death");
  level endon("crash_combat_complete");
  self.ignoreall = 1;

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player || var_1 == level.allies["salter"]) {
      break;
    }
  }

  scripts\engine\utility::flag_set("top_guy_shot_at");
}

_id_47FE() {
  level.player endon("death");
  thread _id_47FF();
  wait 0.1;
  level.allies["eth3n"] scripts\sp\utility::_id_10347("phstreets_eth_sirtheyrefiringoninn");
  level.allies["salter"] scripts\sp\utility::_id_10347("phstreets_slt_evacuatethisarea");
  wait 0.15;
  level.player scripts\sp\utility::_id_1034D("phstreets_plr_usingouratisguns");
  wait 0.1;
  level.allies["salter"] scripts\sp\utility::_id_10347("phstreets_slt_wehavetogettothetower");
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8("allies");
  scripts\engine\utility::flag_wait("mall_combat_retreat_3");

  if(isDefined(level._id_11A08)) {
    level._id_11A08 = undefined;
  } else {
    scripts\sp\utility::_id_10350("phstreets_plr_ethanwerepushin");
    level.allies["eth3n"] scripts\sp\utility::_id_10347("phstreets_eth_rog");
  }

  while(getaiarray("axis").size > 1) {
    wait 0.1;
  }

  var_0 = getaiarray("axis")[0];

  if(isDefined(var_0)) {
    var_0 scripts\sp\utility::_id_54F7();
    var_0 scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_19DB();
    var_0 waittill("death");
  }

  wait 1;
  level.allies["salter"] scripts\sp\utility::_id_10347("phstreets_slt_clear1");
  level.allies["eth3n"] scripts\sp\utility::_id_10347("phstreets_eth_allclear1");
}

_id_47FF() {
  level endon("crash_combat_complete");
  level endon("mall_combat_retreat_3");
  var_0 = getEnt("mall_flank_player", "targetname");
  var_0 waittill("trigger");
  level._id_11A08 = 1;
  scripts\sp\utility::_id_10350("phstreets_plr_ethanwerepushin");
  level.allies["eth3n"] scripts\sp\utility::_id_10347("phstreets_eth_rog");
  level.allies["salter"] thread scripts\sp\utility::_id_10347("phstreets_slt_onyoureyes");
  wait 1;
  level.allies["salter"] scripts\sp\utility::_id_10347("phstreets_slt_illcover");
}

_id_D22A() {
  level.player waittill("pickup");
  level.player waittill("weapon_change");
  level.player givemaxammo(level.player getcurrentweapon());
}

_id_B2B7() {
  self endon("death");
  var_0 = scripts\sp\utility::_id_7A96();
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  thread scripts\engine\utility::delete_on_death(var_1);
  self _meth_82DE(var_1);
  scripts\engine\utility::flag_wait("mall_combat_player_upstairs");
  var_2 = gettime();
  var_3 = self._id_A906._id_EF15 * 1000;

  while(gettime() - var_2 <= var_3) {
    if(!self.pacifist) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(self) && isalive(self)) {
    self clearentitytarget();
  }

  var_1 delete();
}

_id_18B9() {
  if(level.player adsButtonPressed()) {
    return 1;
  }

  return 0;
}

_id_3B07() {
  var_0 = scripts\engine\utility::getStructArray("cart_fake_grenade_struct", "targetname");
  var_0 = sortbydistance(var_0, level.player.origin);
  var_0[0]._id_2634 = 1;

  foreach(var_2 in var_0) {
    var_2 thread _id_3B06();
  }
}

_id_3B06() {
  level endon("crash_combat_complete");
  var_0 = spawn("trigger_radius", self.origin, 0, 500, 96);
  var_1 = scripts\engine\utility::getStruct(self.target, "targetname");

  if(!isDefined(self._id_2634)) {
    var_0 waittill("trigger");
  }

  magicgrenade("frag", var_1.origin, self.origin, 3, 1);
  wait 2;
  scripts\engine\utility::flag_set("cart_destroyed");
}

_id_1DB2() {
  var_0 = scripts\engine\utility::getStructArray("ambient_fake_fire_struct", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_6AEA();
  }
}

_id_6AEA(var_0) {
  var_1 = getEnt("fake_fire_stop_trig", "targetname");
  var_1 endon("trigger");
  var_2 = scripts\engine\utility::getStructArray(self.target, "targetname");
  wait(randomfloatrange(0.65, 1.65));

  for(;;) {
    var_2 = scripts\engine\utility::array_randomize(var_2);

    foreach(var_4 in var_2) {
      for(var_5 = 0; var_5 < randomintrange(3, 5); var_5++) {
        var_6 = -45;
        var_7 = 45;
        var_8 = self.origin + (randomfloatrange(var_6, var_7), randomfloatrange(var_6, var_7), 0);
        var_9 = var_4.origin + (randomfloatrange(var_6, var_7), randomfloatrange(var_6, var_7), 0);
        magicbullet("iw7_ar57", var_8, var_9);
        bullettracer(var_8, var_9, "iw7_ar57", 1);
        var_10 = physicstrace(var_8, var_9);

        if(isDefined(var_10)) {
          physicsexplosionsphere(var_10, 76, 48, 0.25);
        }

        wait 0.05;
      }

      wait(randomfloatrange(0.65, 1.65));
    }

    var_2 = scripts\engine\utility::array_randomize(var_2);
  }
}

_id_47FC() {
  scripts\engine\utility::flag_set("crash_combat_complete");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_1510("lake_vista_aatis_guns");
}

_id_281D() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_bar");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_bar", var_0);
  level.allies["admiral"] thread _id_281C("bar_stairs_run", "g");
  level.allies["salter"] thread _id_281C("bar_stairs_run", "b");
  level.allies["eth3n"] thread _id_281C("bar_stairs_run", "y");
  _id_1064B();
  scripts\sp\utility::_id_15F5("bar_color_trig");
  level.player takeweapon("frag");
  _id_8595();
  thread _id_281E();
}

_id_2819() {
  thread _id_2815();
  thread _id_8B25();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EF24("streets_scriptable_cars");
  thread _id_2816();
  thread _id_2817();
}

_id_281E() {
  var_0 = scripts\sp\hud_util::_id_48B7("black", 1, level.player);
  var_1 = 4;
  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
}

_id_1064B() {
  var_0 = getEnt("bar_corpse_start_trig", "targetname");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3.script_parameters = "notsolid";
  }

  scripts\sp\utility::_id_15F5("bar_corpse_start_trig");
}

_id_2817() {
  wait 13.5;
  var_0 = 0;
  level endon("stop_searching_for_ambient_shooters");
  level thread scripts\sp\utility::_id_C12D("stop_searching_for_ambient_shooters", 6);

  for(;;) {
    var_1 = vehicle_getarray();
    var_1 = sortbydistance(var_1, level.player.origin);

    foreach(var_3 in var_1) {
      if(_id_13266(var_3)) {
        if(!isDefined(var_3._id_B316)) {
          var_3._id_B316 = 1;
          var_3 thread _id_1DA9();
          var_0++;

          if(var_0 == 2) {
            return;
          }
        }
      }
    }

    wait 0.5;
  }
}

_id_13266(var_0) {
  if(distance2dsquared(var_0.origin, level.player.origin) < squared(10000)) {
    if(issubstr(var_0.classname, "dropship") && isDefined(var_0.mgturret) && level.player scripts\sp\math::_id_9C85(var_0.origin)) {
      return 1;
    }
  }

  return 0;
}

_id_1DA9() {
  self endon("death");
  var_0 = self.mgturret[0];

  if(!isDefined(var_0)) {
    return;
  }
  var_0 setmode("manual");

  for(;;) {
    var_1 = randomintrange(15, 25);
    var_0 setdefaultdroppitch(randomintrange(130, 160));

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_0 shootturret();
      wait 0.165;
    }

    wait 0.6;
  }
}

_id_2816() {
  scripts\engine\utility::flag_wait("crash_player_leaving_bar");
  scripts\engine\utility::exploder("ganeva_fountain");
  wait 2;
  level endon("crash_player_approaching_gate");
  var_0 = 0;
  var_1 = getEntArray("lake_vista_aatis_guns", "script_noteworthy");
  var_1 = sortbydistance(var_1, level.player.origin);

  for(;;) {
    foreach(var_3 in var_1) {
      if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_3.origin, cos(55))) {
        var_3 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_150C(1);
        wait 1.3;
        var_3 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_150C(1);
        wait 1.3;
        var_0++;

        if(var_0 > 4) {
          return;
        }
      }
    }

    wait 0.05;
  }
}

_id_2815() {
  level.player endon("death");
  setmusicstate("");
  wait 2.25;
  level.allies["admiral"] scripts\sp\utility::_id_10347("phstreets_adm_getustherelieut");
  level.player scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_D090, "ges_radio");
  level.player scripts\engine\utility::delaythread(3.25, scripts\sp\utility::_id_1102B, "ges_radio");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  level.player scripts\engine\utility::delaycall(3.25, ::playsound, "ges_plr_radio_off");
  level.player scripts\sp\utility::_id_1034D("phstreets_plr_affirmative");
  level.allies["eth3n"] scripts\sp\utility::_id_10347("phstreets_eth_communicationsm");
  scripts\engine\utility::flag_wait("crash_player_leaving_bar");

  foreach(var_1 in level.allies) {
    var_1.ignoreall = 1;
  }

  level.allies["eth3n"] scripts\sp\utility::_id_10347("phstreets_eth_setdefassaultsh");
  scripts\engine\utility::exploder("grenades_explosion_01");
  level.player scripts\sp\utility::_id_1034D("phstreets_adm_theyrelandingtr");
  wait 0.1;
  level.allies["admiral"] scripts\sp\utility::_id_10347("phstreets_adm_weneedthoseguns");
  scripts\engine\utility::flag_set("crash_bar_dialogue_done");
  wait 0.25;

  if(scripts\engine\utility::flag("grenade_give_scene_started")) {
    return;
  }
  level.allies["salter"] scripts\sp\utility::_id_10347("phstreets_slt_gunsaintcuttini");

  if(scripts\engine\utility::flag("grenade_give_scene_started")) {
    return;
  }
  level.player scripts\sp\utility::_id_1034D("phstreets_plr_weneedantiperso");
}

_id_281C(var_0, var_1) {
  level endon("grenade_give_started");
  wait 0.5;
  var_2 = scripts\engine\utility::getStruct("bar_stairs_animnode", "targetname");
  var_2 scripts\sp\anim::_id_1F17(self, var_0);
  var_2 scripts\sp\anim::_id_1F35(self, var_0);
  scripts\sp\utility::_id_F3B5(var_1);
  scripts\sp\utility::_id_61C7();
}

_id_47F1() {
  self endon("death");
  level.player thread scripts\sp\utility::play_sound_on_entity("scn_phstreets_bar_flyover_quake_lr");
  wait 1.25;
  var_0 = 0;
  var_1 = [0, 0.25, 0.35, 0.45, 0.25, 0.65];

  for(var_2 = 0; var_2 < 6; var_2++) {
    var_0 = var_0 + var_1[var_2];
    var_3 = getglass("mall_hallway_glass_" + var_2);
    var_4 = anglesToForward((0, 360, 0));

    if(var_0 > 0) {
      if(isDefined(var_3) && isDefined(var_4)) {
        scripts\engine\utility::noself_delaycall(var_0, ::destroyglass, var_3, var_4);
      }

      continue;
    }

    if(isDefined(var_3) && isDefined(var_4)) {
      destroyglass(var_3, var_4);
    }
  }

  thread _id_47F2();
  thread _id_C74C();
  var_5 = 3;
  var_6 = var_5 * 10;

  for(var_2 = 0; var_2 < var_6; var_2++) {
    earthquake(0.28, 1, self.origin, 3000);
    wait 0.1;
  }
}

_id_47F2() {
  var_0 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_B284(level.player);
  var_0 scripts\sp\utility::_id_E7C9(0.55, 1.5);
  wait 1.5;
  var_0 scripts\sp\utility::_id_E7C9(0, 1.5);
  var_0 delete();
}

_id_C74C() {
  var_0 = getEnt("out_of_bar_trig", "targetname");
  var_0 waittill("trigger");
  wait 0.5;
  var_1 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_B284(level.player);
  var_1 scripts\sp\utility::_id_E7C9(0.55, 1.5);
  wait 1;
  var_1 scripts\sp\utility::_id_E7C9(0, 0.5);
  var_1 scripts\sp\utility::_id_E7C9(0.55, 0.5);
  wait 1;
  var_1 scripts\sp\utility::_id_E7C9(0, 1);
  var_1 delete();
}

_id_2814(var_0) {
  scripts\engine\utility::flag_wait("mall_combat_retreat_2");
  _id_1064B();
}

_id_281A() {
  var_0 = self.spawner;

  if(isDefined(var_0.script_sound)) {
    thread scripts\sp\utility::play_sound_on_entity(var_0.script_sound);
  }
}

_id_2813() {
  scripts\engine\utility::exploder("ganeva_fountain");
  scripts\engine\utility::flag_set("crash_bar_dialogue_done");
}

_id_85D9() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_grenades");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_grenades", var_0);
  _id_8595();
  level.player takeweapon("frag");

  foreach(var_2 in level.allies) {
    var_2.ignoreall = 1;
  }

  scripts\engine\utility::flag_set("crash_player_approaching_gate");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EF24("streets_scriptable_cars");
  thread _id_8B25();
  scripts\sp\utility::_id_15F5("harbor_vista_capitalships_trig");
  scripts\sp\utility::_id_15F5("grenade_gate_corpse_trig");
}

_id_85D8() {
  scripts\engine\utility::flag_wait("crash_player_approaching_gate");
  _id_0A2F::_id_12BD8("frag");
  var_0 = scripts\sp\vehicle::_id_1080D("grenade_tut_dropships_dist");
  scripts\engine\utility::flag_wait("crash_bar_dialogue_done");

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  thread _id_8586();
  var_1 = scripts\engine\utility::getStruct("grenade_gate_hint", "targetname");
  var_1 _id_0E46::_id_48C4(undefined, undefined, &"PHSTREETS_OPEN");
  scripts\sp\utility::_id_B979(var_1, "stand");
  clearallcorpses();
  thread _id_BC10();
  level.player playSound("scn_phstreets_gate_grab");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "scn_phstreets_gate_open");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_DD5A(2, 800, 5);
  level._id_85AB = 0;
  var_0 = scripts\sp\vehicle::_id_1080D("grenade_tut_dropship");
  var_0 thread _id_8577();

  foreach(var_3 in level.allies) {
    var_3.ignoreme = 1;
    var_3.ignoreall = 1;
    var_3 scripts\sp\utility::_id_51E1("cqb");
  }

  level.player.ignoreme = 1;
  scripts\engine\utility::flag_set("grenade_give_scene_started");
  setsaveddvar("r_dof_hq", 1);
  _id_8594();
  setsaveddvar("r_dof_hq", 0);
  thread grenade_civilian_tracers();
  scripts\engine\utility::array_thread(scripts\engine\utility::getStructArray("grenade_tut_strafe_start", "script_noteworthy"), ::_id_8596);
  scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_56BE, "grenade_tut", 10);
  level.allies["admiral"] scripts\sp\utility::_id_F3B5("g");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("b");
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("y");
  scripts\sp\utility::_id_15F5("grenade_tut_start_colortrig");
  scripts\sp\vehicle::_id_1080D("grenade_tut_rightside_dropship");
  scripts\engine\utility::flag_wait_any("grenade_enemies_alerted", "grenade_tut_allies_attack");
  level._id_858D = gettime();
  scripts\engine\utility::flag_set("grenade_tut_enemies1_moveup");
  scripts\engine\utility::flag_set("grenade_tut_enemies2_moveup");
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D8("axis");

  foreach(var_3 in level.allies) {
    var_3.ignoreme = 0;
    var_3.ignoreall = 0;
    var_3 scripts\sp\utility::_id_4145();
  }

  level.player.ignoreme = 0;
  scripts\engine\utility::delaythread(0, scripts\sp\utility::_id_22CD, "grenade_tut_street_enemies");
  scripts\engine\utility::flag_wait("grenades_complete");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_DD59();
}

_id_BC10() {
  var_0 = getEntArray("out_of_bar_door", "targetname");

  foreach(var_2 in var_0) {
    getEnt(var_2.script_linkto, "script_linkname") delete();
    getEnt(var_2.target, "targetname") linkTo(var_2);

    if(var_2.angles[1] < 180) {
      var_2 rotateYaw(90, 0.05);
      continue;
    }

    var_2 rotateYaw(-90, 0.05);
  }

  var_4 = getEnt("out_of_bar_door_blackness", "targetname");
  var_4 scripts\sp\utility::_id_100D7();
  scripts\engine\utility::flag_wait("start_dust_area");
  var_4 delete();

  foreach(var_2 in var_0) {
    getEnt(var_2.target, "targetname") delete();
    var_2 delete();
  }
}

_id_8577() {
  var_0 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_B284(level.player);
  var_0 scripts\sp\utility::_id_E7C9(0.35, 3);

  while(isDefined(self) && isalive(self) && distance2dsquared(self.origin, level.player.origin) < squared(2400)) {
    var_1 = randomfloatrange(0.2, 0.4);
    var_2 = randomfloatrange(0.25, 0.5);
    var_3 = randomfloatrange(0.25, 0.5);
    var_4 = 0.1;
    var_5 = var_4 / 2;
    var_6 = var_4 / 2;
    level.player _meth_8291(var_1, var_2, var_3, var_4, var_5, var_6);
    var_0._id_99E5 = randomfloatrange(0.1, 0.35);
    wait(var_4);
  }

  var_0 scripts\sp\utility::_id_E7C9(0, 2);
  var_0 delete();
}

_id_8586() {
  scripts\engine\utility::flag_wait_any("grenade_enemies_alerted", "grenade_tut_shooting_civis");

  if(!scripts\engine\utility::flag("grenade_enemies_alerted")) {
    level.allies["admiral"] scripts\sp\utility::_id_10347("phstreets_adm_theyreshootingc");
    scripts\engine\utility::flag_set("grenade_tut_allies_attack");
  }

  if(!scripts\engine\utility::flag("player_threw_grenade")) {
    scripts\sp\utility::_id_10350("phstreets_plr_openfire");
  }

  scripts\engine\utility::flag_set("grenade_vo_complete");
}

_id_85A1() {
  level endon("grenade_enemies_alerted");
  level.player waittill("grenade_fire");
  level.player thread scripts\sp\utility::play_sound_on_entity("UN_plr_inform_attack_grenade");
}

_id_8592() {
  wait 5;

  if(!scripts\engine\utility::flag("grenade_give_scene_started")) {
    level.allies["salter"] thread scripts\sp\utility::_id_10347("phstreets_slt_onyoureyes");
  }

  wait 5;

  if(!scripts\engine\utility::flag("grenade_give_scene_started")) {
    level.allies["admiral"] thread scripts\sp\utility::_id_10347("phstreets_adm_getustothattowe");
  }
}

_id_8594() {
  var_0 = scripts\engine\utility::getStruct("grenade_gate_scene_struct", "targetname");
  var_1 = scripts\sp\utility::_id_10639("player_rig");
  var_2 = scripts\sp\utility::_id_10639("grenade");
  var_1 hide();
  var_0 thread scripts\sp\anim::_id_1EC3(var_1, "grenade_give");
  level.player _id_0B1F::_id_598D();
  var_3 = level.player scripts\engine\utility::spawn_tag_origin();
  var_3.origin = level.player.origin;
  var_3.angles = level.player getplayerangles();
  level.player playerlinkTo(var_3, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_4 = 0.35;
  var_5 = var_4 / 4;
  level.player _meth_81DE(50, 2);
  level.player _meth_823C(var_1, "tag_player", var_4, var_5, var_5);
  wait(var_4);
  level.player playerlinktodelta(var_1, "tag_player", 1, 0, 0, 0, 0, 1);
  var_3 delete();
  var_1 show();
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_BE49);
  level notify("grenade_give_started");

  foreach(var_7 in level.allies) {
    scripts\sp\anim::_id_1F12(var_7);
    var_7 _meth_83A1();
  }

  var_9 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_grenades", var_9);
  var_10 = [var_1, var_2, level.allies["salter"]];
  var_10 = scripts\engine\utility::array_combine(var_10, level._id_8590["gates"]);
  var_0 thread scripts\sp\anim::_id_1F2C(var_10, "grenade_give");
  level thread _id_8591();
  level waittill("give_grenades");
  level.player giveweapon("frag");
  level.player givemaxammo("frag");
  level.player assignweaponoffhandprimary("frag");
  _id_0A2F::_id_66A4("frag");
  var_0 waittill("grenade_give");

  foreach(var_12 in level._id_8590["clip"]) {
    var_12 connectpaths();
    var_12 disconnectPaths();
  }

  level.player _id_0B1F::_id_5990();
  level.player unlink();
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_BE4A);
  var_1 delete();
  var_2 delete();
  scripts\engine\utility::flag_set("grenade_give_scene_done");
}

#using_animtree("generic_human");

_id_8593(var_0) {
  var_1 = level.allies["salter"];
  var_1 detach(var_1.headmodel);
  var_1 _meth_82A2(%mayhem_ph_coast_give_plr_grenades_xo, 1.0, 0.0, 1.0);
  scripts\engine\utility::flag_wait("grenade_give_scene_done");
  var_1 _meth_82A2(%mayhem_ph_coast_give_plr_grenades_xo, 0.0, 0.0, 1.0);
  var_1 attach(var_1.headmodel);
}

_id_8591() {
  thread _id_0B0A::_id_583F(0, 0, 3.9, 0, 250, 10, 0);
  thread _id_858F();
  level waittill("give_grenades");
  var_0 = 0.25;
  _id_0B0A::_id_583F(0, 0, 0, 0, 75, 10, var_0);
  wait(var_0 + 0.5);
  thread _id_0B0A::_id_583D(0.1);
}

_id_858F() {
  wait 3.7;
  level.player _meth_81DE(65, 0.41);
}

_id_8595(var_0) {
  if(isDefined(var_0)) {
    wait 1;
  }

  var_1 = getEnt("grenade_gate_left", "targetname");
  var_1._id_1FBB = "grenade_gate_left";
  var_1 _meth_83D0(level._id_EC87["grenade_gate"]);
  var_2 = getEnt("grenade_gate_right", "targetname");
  var_2._id_1FBB = "grenade_gate_right";
  var_2 _meth_83D0(level._id_EC87["grenade_gate"]);
  var_3 = getEnt("grenade_gate_clip_left", "targetname");
  var_3 linkTo(var_1);
  var_4 = getEnt("grenade_gate_clip_right", "targetname");
  var_4 linkTo(var_2);
  level._id_8590["gates"] = [var_1, var_2];
  level._id_8590["clip"] = [var_3, var_4];
  scripts\engine\utility::flag_wait("crash_combat_complete");
}

_id_85AA() {
  if(level.player isthrowinggrenade()) {
    scripts\engine\utility::flag_set("player_threw_grenade");
    return 1;
  }

  return 0;
}

_id_85A4() {
  self._id_CA16 = scripts\engine\utility::getStruct("grenade_heli_crash_loc", "targetname");
  self.team = "axis";
  self._id_5958 = 1;
  self makevehiclenotcollidewithplayers(1);
  var_0 = scripts\engine\utility::spawn_tag_origin((53792, 29976, -34300));

  foreach(var_2 in self._id_E4FB) {
    var_2 thread _id_8547(var_0);
  }

  scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_22CD, "grenade_tut_dropship_civis", 1);
  scripts\engine\utility::exploder("rattle_tree_dropship_grenades");
  scripts\engine\utility::delaythread(2.5, _id_0BBD::_id_5DB9, "back");
  scripts\engine\utility::flag_wait("grenade_dropship_leave");
  scripts\engine\utility::delaythread(5, scripts\sp\utility::_id_10FEC, "rattle_tree_dropship_grenades");
  scripts\engine\utility::delaythread(1, _id_0BBD::_id_5DB7, "back");
  self waittill("death");
  var_0 delete();
}

_id_85A6() {
  self endon("death");
  var_0 = self.spawner;
  self._id_1FBB = var_0.script_parameters;
  self.grenadeawareness = 0;
  self.ignoresuppression = 1;
  self.ignoreall = 1;
  scripts\sp\utility::_id_F3E6(0);
  scripts\sp\utility::_id_5528();
  scripts\sp\utility::_id_5504();
  self._id_8020 = ::_id_85A8;
  self._id_E500 waittill("start_unload");
  thread _id_85A7();
  _id_858E();

  if(self.script_parameters == "sdf5") {
    scripts\engine\utility::flag_set("grenade_dropship_leave");
  }

  scripts\engine\utility::waitframe();
  self _meth_83A1();
  var_1 = 0;

  if(gettime() - level._id_858D > 500) {
    var_1 = 1;
  }

  if(!scripts\engine\utility::flag("grenade_tut_player_threw_grenade") || var_1) {
    if(self.script_parameters == "sdf2") {
      wait 0.25;
      self.favoriteenemy = level._id_EA2C;
      self.maxfaceenemydist = 999999;
      scripts\engine\utility::delaythread(6, scripts\sp\utility::_id_F39C, undefined);
    } else if(gettime() - level._id_858D < 100)
      wait(randomfloat(1.2));

    if(self.script_parameters == "sdf5") {
      if(self.health < 150) {
        self.health = 150 - self.health;
      }
    }

    var_2 = getnode(self.script_linkto, "script_linkname");
    thread scripts\sp\utility::_id_7226(var_2);
    scripts\sp\utility::_id_550C();
    scripts\sp\utility::_id_5564();
    scripts\engine\utility::delaythread(4, scripts\sp\utility::_id_61DF);
    scripts\engine\utility::delaythread(4, scripts\sp\utility::_id_5564);
    self.grenadeawareness = 1;
    self.ignoreall = 0;
    self.ignoresuppression = 0;
  } else {
    scripts\engine\utility::delaythread(level._id_85AB, scripts\sp\utility::play_sound_on_entity, "SD_" + randomint(5) + "_inform_incoming_grenade");
    level._id_85AB = level._id_85AB + randomfloat(0.6);
    scripts\sp\utility::_id_F2A8(1);
    self setCanDamage(1);
    scripts\sp\utility::_id_5564();
    scripts\engine\utility::delaythread(5, scripts\sp\utility::_id_6224);
    var_3 = scripts\engine\utility::random(level._id_EC85["generic"]["frantic_run_twitches"]);
    scripts\asm\asm::asm_setdemeanoranimoverride("combat", "move", var_3);
    scripts\engine\utility::delaythread(6, scripts\asm\asm::asm_cleardemeanoranimoverride, "combat", "move");
    scripts\engine\utility::delaythread(6, scripts\sp\utility::_id_F415, 0);
    scripts\engine\utility::delaythread(6, scripts\sp\utility::_id_F417, 0);
  }
}

grenade_civilian_tracers() {
  var_0 = getEnt("grenade_combat_civi_killtrigger", "targetname");
  var_0 endon("trigger");
  scripts\sp\utility::_id_127B3("grenade_combat_civi_trigger");
  thread grenade_civilian_tracers_go();
}

grenade_civilian_tracers_go() {
  level endon("grenade_tut_dock_final_retreat");
  var_0 = (54422, 30194, -34612);
  var_1 = (53686, 29976, -34650);
  var_2 = 200;
  var_3 = 100;
  var_4 = gettime();

  while(gettime() - var_4 < 3000) {
    var_5 = randomintrange(6, 12);

    for(var_6 = 0; var_6 < var_5; var_6++) {
      var_7 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(var_0, var_2);
      var_8 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(var_1, var_3, 56);
      magicbullet("iw7_crb", var_7, var_7 + (0, 0, 1));
      bullettracer(var_7, var_8, "sdf_mg_turret_phhill");
      wait(randomfloatrange(0.05, 0.1));
    }

    wait(randomfloatrange(0.2, 0.4));
  }
}

_id_8596() {
  level endon("grenades_complete");
  self waittill("trigger", var_0);
  var_0.favoriteenemy = level._id_EA2C;
  var_0.maxfaceenemydist = 999999;
  var_0.ignoreall = 0;
  var_1 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_7E98(self.target, "targetname");
  var_1 waittill("trigger");
  var_0.favoriteenemy = undefined;
}

_id_8547(var_0) {
  self endon("death");
  self waittill("unload");
  self waittill("single anim");
  wait(randomfloatrange(0.5, 1.5));

  if(scripts\engine\utility::flag("grenade_enemies_alerted")) {
    return;
  }
  self.ignoreall = 0;
  self _meth_82DE(var_0);

  if(self.script_parameters != "sdf5") {
    thread _id_EC93(var_0);
  }

  thread scripts\engine\utility::flag_set_delayed("grenade_tut_shooting_civis", 3);
  scripts\engine\utility::flag_wait("grenade_enemies_alerted");
  self.ignoreall = 1;
  self clearentitytarget();
}

_id_EC93(var_0) {
  self endon("death");
  wait(randomfloat(1));
  level endon("grenade_enemies_alerted");
  self endon("stop_scr_shoot");
  thread scripts\sp\utility::_id_C12D("stop_scr_shoot", 3);

  for(;;) {
    self shoot(1, var_0, 1);
    wait(randomfloatrange(0.05, 0.35));
  }
}

_id_85A8() {
  scripts\engine\utility::flag_wait("grenade_dropship_leave");
  return 1;
}

_id_85A7() {
  wait 2;
  self hide();
  scripts\engine\utility::delaycall(0.75, ::show);
  self unlink();
  var_0 = scripts\engine\utility::getStruct("grenade_dropship_unload_struct", "script_noteworthy");
  var_0 thread scripts\sp\anim::_id_1F35(self, "grenade_dropship_unload");

  if(self.script_parameters == "sdf5") {
    self.health = 15;
    scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "grenade_dropship_leave");
    scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
    scripts\sp\utility::_id_57D6();
    scripts\engine\utility::flag_set("grenade_dropship_leave");
  }
}

_id_858E() {
  self endon("death");
  scripts\sp\utility::_id_F2A8(1);
  self setCanDamage(1);
  level waittill(self._id_1FBB + "_allow_interrupt");
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("explode");
  thread _id_68B2();
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "ai_events");
  level scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "grenade_tut_stealth_flag");
  level scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "grenade_enemies_alerted");
  scripts\sp\utility::_id_57D6();

  if(scripts\engine\utility::cointoss()) {
    wait(randomfloatrange(0.25, 0.75));
  }

  scripts\engine\utility::flag_set("grenade_enemies_alerted");
}

_id_68B2() {
  self waittill("ai_events", var_0);
  var_1 = 1;

  foreach(var_3 in var_0) {
    if(var_3.type == "grenade danger") {
      var_1 = 0;
      break;
    }
  }

  if(var_1) {
    return;
  }
  scripts\engine\utility::flag_set("grenade_tut_player_threw_grenade");
}

_id_85A5(var_0, var_1, var_2) {
  self endon("death");

  for(;;) {
    var_0 = scripts\sp\utility::_id_22B9(var_0);
    var_3 = 1;

    foreach(var_5 in var_0) {
      if(var_5 istouching(var_1)) {
        var_3 = 0;
      }
    }

    if(var_3) {
      break;
    }

    wait 0.1;
  }

  wait 2;
  self unlink();
  var_2 delete();
  scripts\engine\utility::flag_set("grenade_dropship_leave");
}

_id_5DAA() {
  if(!getdvarint("dropship_damage_debug")) {
    return;
  }
  scripts\sp\vehicle::_id_8441();

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_1 != level.player) {
      continue;
    }
    iprintlnbold(var_4);
  }
}

_id_11A16(var_0, var_1) {
  if(!self istouching(var_0)) {
    return;
  }
  scripts\sp\utility::_id_86E4();
  self._id_4E2A = % death_explosion_stand_f_v1;
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_3 = anglesToForward(var_1.angles);
  var_2.angles = vectortoangles(var_3 * -1);
  self linkTo(var_2, "tag_origin");
  scripts\sp\utility::_id_54C6();
  var_2 delete();
}

_id_5E4C() {
  level endon("grenade_dropship_leave");
  scripts\sp\vehicle::_id_8441();
  var_0 = getEnt("grenade_tut_damage_trigger", "targetname");

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!isDefined(var_2) || var_2 != level.player) {
      continue;
    }
    if(var_5 == "MOD_GRENADE_SPLASH") {
      break;
    }
  }

  radiusdamage(self.origin, 500, 9999, 9999);
  scripts\sp\vehicle::_id_8440();
  self unlink();
  self notify("death");
  scripts\engine\utility::flag_set("grenade_tutorial_success");
}

_id_85A3() {
  self endon("death");
  var_0 = self.spawner;
  var_1 = var_0 scripts\sp\utility::_id_7A96();
  scripts\sp\utility::_id_550C();
  self.grenadeawareness = 0;
  self.combatmode = "no_cover";

  if(isDefined(var_0._id_EE2C)) {
    thread scripts\sp\utility::_id_F492(var_0._id_EE2C);
  }

  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_19C5(var_1);
}

_id_85A9() {
  self._id_55ED = 1;
  self._id_1FBB = "generic";
  scripts\sp\utility::_id_F48E("combat", "hm_grnd_red_civ_run_twitch04");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_CA95(0, 0.6);
  thread scripts\sp\utility::play_sound_on_entity("phstreets_fcv1_cryscream2");
}

_id_8B25() {
  thread _id_0B0F::_id_10D23("harbor_vista_airbattle");
}

_id_8B26() {
  self endon("death");

  if(!isDefined(level._id_8B26)) {
    level._id_8B26 = [];
  }

  level._id_8B26[level._id_8B26.size] = self;
  self notsolid();
  self dontcastshadows();

  if(self.classname == "script_vehicle_capitalship_carrier_ca") {
    return;
  }
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_39BC("no_effect", undefined);

  if(scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C8ED("heli")) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_39A7();
  }

  scripts\sp\utility::_id_127B3("hill_vista_capitalships_trig");
  _id_0BA9::_id_397B();
}

_id_1CEE() {
  foreach(var_1 in level.allies) {
    var_1._id_C3C1 = var_1.grenadeammo;
    var_1 scripts\sp\utility::_id_F3E6(0);
  }

  scripts\engine\utility::flag_wait("grenade_give_scene_done");

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_F3E6(var_1.grenadeammo);
    var_1._id_C3C1 = undefined;
  }
}

_id_85D6() {
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D8("axis");
  level.allies["admiral"] scripts\sp\utility::_id_F3B5("g");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("b");
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("y");
  scripts\engine\utility::flag_set("grenade_give_scene_done");
  scripts\engine\utility::flag_set("grenade_vo_complete");
}