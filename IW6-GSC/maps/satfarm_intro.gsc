/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_intro.gsc
*****************************************************/

intro_init() {
  level.start_point = "intro";
  thread fade_in_from_black();
  thread maps\satfarm_audio::satfarm_intro();
  setsaveddvar("compass", 0);
  level.player freezecontrols(1);
  maps\satfarm_code::kill_spawners_per_checkpoint("intro");
}

intro_main() {
  if(level.start_point != "intro") {
    return;
  }
  level.allytanks = [];
  level.herotanks = [];
  level.othertanks = [];
  level.enemytanks = [];
  level.enemygazs = [];
  level.playertank = maps\_vehicle::spawn_vehicle_from_targetname("intro_playertank");
  level.player.tank = level.playertank;
  level.playertank.driver = level.player;
  level.playertank notify("nodeath_thread");
  level.playertank maps\_vehicle::godon();
  level.lock_on = 0;
  level.player.script_team = "allies";
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player allowjump(0);
  thread maps\satfarm_code::hide_normal_hud_elements();
  level.playertank thread maps\satfarm_code::tank_rumble();
  level.player enableinvulnerability();
  level.playertank makeunusable();
  level.player thread maps\_utility::vision_set_fog_changes("satfarm_c17_intro_tank", 0);
  level.player.old_contents = level.player.contents;
  level.player.contents = 0;
  wait 1.0;
  thread intro_begin();
  common_scripts\utility::flag_wait("intro_end");
  maps\_spawner::killspawner(10);
  maps\satfarm_code::kill_vehicle_spawners_now(10);
}

fade_in_from_black() {
  level.intro_black = maps\_hud_util::create_client_overlay("black", 1, level.player);
  wait 0.5;
  level waittill("screen_fading_in_from_black");
  wait 0.05;
  level.intro_black fadeovertime(1);
  level.intro_black.alpha = 0;
  wait 1.05;
  level.intro_black destroy();
}

intro_begin() {
  thread maps\satfarm_audio::aud_player_tank_int_on();
  thread saf_c17_lower_backdoor_top_setup();
  thread saf_c17_lower_backdoor_setup();
  thread intro_red_flickering_light();
  var_0 = [];
  var_1 = common_scripts\utility::getstruct("playertank_fake_org", "targetname");
  var_2 = maps\_utility::spawn_anim_model("playertank_fake", var_1.origin);
  var_0 = common_scripts\utility::add_to_array(var_0, var_2);
  var_3 = [];
  var_4 = maps\_utility::spawn_anim_model("player_rig");
  var_3[0] = var_4;
  var_5 = maps\_utility::spawn_anim_model("player_rig_legs");
  var_3[1] = var_5;
  var_6 = getent("cargobay_tankdriver", "targetname");
  var_7 = var_6 maps\_utility::spawn_ai(1);
  var_7 maps\_utility::magic_bullet_shield(1);
  var_7.animname = "cargobay_tankdriver";
  var_3[2] = var_7;
  var_8 = getent("cargobay_tankcopilot", "targetname");
  var_9 = var_8 maps\_utility::spawn_ai(1);
  var_9 maps\_utility::magic_bullet_shield(1);
  var_9.animname = "cargobay_tankcopilot";
  var_3[3] = var_9;
  var_1 maps\_anim::anim_first_frame(var_3, "c17_tank_scene");
  level.player playerlinktodelta(var_4, "tag_player", 1, 0, 0, 0, 0, 1);
  thread black_screen_vo(var_7, var_9);
  var_10 = getent("intro_tankman", "targetname");
  var_11 = var_10 maps\_utility::spawn_ai(1, 1);
  var_11.animname = "intro_tankman";
  var_0 = common_scripts\utility::add_to_array(var_0, var_11);
  var_12 = getent("intro_commander", "targetname");
  var_13 = var_12 maps\_utility::spawn_ai(1, 1);
  var_13.animname = "intro_commander";
  var_0 = common_scripts\utility::add_to_array(var_0, var_13);
  var_14 = getent("intro_crateman", "targetname");
  var_15 = var_14 maps\_utility::spawn_ai(1, 1);
  var_15.animname = "intro_crateman";
  var_0 = common_scripts\utility::add_to_array(var_0, var_15);
  var_16 = getent("intro_crewmaster", "targetname");
  var_17 = var_16 maps\_utility::spawn_ai(1, 1);
  var_17.animname = "intro_crewmaster";
  var_0 = common_scripts\utility::add_to_array(var_0, var_17);
  var_18 = getent("intro_helper", "targetname");
  var_19 = var_18 maps\_utility::spawn_ai(1, 1);
  var_19.animname = "intro_helper";
  var_0 = common_scripts\utility::add_to_array(var_0, var_19);
  var_20 = getent("intro_lieutenant", "targetname");
  var_21 = var_20 maps\_utility::spawn_ai(1, 1);
  var_21.animname = "intro_lieutenant";
  var_0 = common_scripts\utility::add_to_array(var_0, var_21);
  var_22 = getent("intro_soldier1", "targetname");
  var_23 = var_22 maps\_utility::spawn_ai(1, 1);
  var_23.animname = "intro_soldier1";
  var_0 = common_scripts\utility::add_to_array(var_0, var_23);
  var_24 = getent("intro_soldier2", "targetname");
  var_25 = var_24 maps\_utility::spawn_ai(1, 1);
  var_25.animname = "intro_soldier2";
  var_0 = common_scripts\utility::add_to_array(var_0, var_25);
  var_26 = getent("intro_turretman", "targetname");
  var_27 = var_26 maps\_utility::spawn_ai(1, 1);
  var_27.animname = "intro_turretman";
  var_0 = common_scripts\utility::add_to_array(var_0, var_27);
  var_28 = maps\_utility::spawn_anim_model("satfarm_cargobay_basecrates_gpr");
  var_0 = common_scripts\utility::add_to_array(var_0, var_28);
  var_29 = maps\_utility::spawn_anim_model("tankman_tank");
  var_0 = common_scripts\utility::add_to_array(var_0, var_29);
  var_30 = maps\_utility::spawn_anim_model("caleb_diaper_01");
  var_0 = common_scripts\utility::add_to_array(var_0, var_30);
  var_31 = maps\_utility::spawn_anim_model("caleb_diaper_02");
  var_0 = common_scripts\utility::add_to_array(var_0, var_31);
  var_32 = spawn("script_model", (0, 0, 0));
  var_32 setModel("saf_federation_crate");
  var_32 linkto(var_28, "J_prop_1", (0, 0, 0), (0, 0, 0));
  var_33 = spawn("script_model", (0, 0, 0));
  var_33 setModel("saf_federation_crate");
  var_33 linkto(var_28, "J_prop_2", (0, 0, 0), (0, 0, 0));
  var_34 = maps\_utility::spawn_anim_model("satfarm_cargobay_topcrate_and_toolbox_gpr");
  var_0 = common_scripts\utility::add_to_array(var_0, var_34);
  var_35 = spawn("script_model", (0, 0, 0));
  var_35 setModel("saf_federation_crate");
  var_35 linkto(var_34, "J_prop_1", (0, 0, 0), (0, 0, 0));
  var_36 = spawn("script_model", (0, 0, 0));
  var_36 setModel("carrier_red_toolbox");
  var_36 linkto(var_34, "J_prop_2", (0, 0, 0), (0, 0, 0));
  var_37 = maps\_utility::spawn_anim_model("satfarm_cargobay_humveecargo_gpr");
  var_0 = common_scripts\utility::add_to_array(var_0, var_37);
  var_38 = spawn("script_model", (0, 0, 0));
  var_38 setModel("saf_federation_crate");
  var_38 linkto(var_37, "J_prop_1", (0, 0, 0), (0, 0, 0));
  var_39 = maps\_utility::spawn_anim_model("satfarm_cargo_crates_in_back_gpr");
  var_0 = common_scripts\utility::add_to_array(var_0, var_39);
  var_40 = spawn("script_model", (0, 0, 0));
  var_40 setModel("saf_federation_crate");
  var_40 linkto(var_39, "J_prop_1", (0, 0, 0), (0, 0, 0));
  var_41 = spawn("script_model", (0, 0, 0));
  var_41 setModel("saf_federation_crate_small");
  var_41 linkto(var_39, "J_prop_2", (0, 0, 0), (0, 0, 0));
  thread setup_camera_roll(var_37);
  var_13 thread intro_commander_waits();
  var_1 maps\_anim::anim_first_frame(var_0, "intro");
  level waittill("screen_fading_in_from_black");
  thread maps\satfarm_audio::intro_tank_foley();
  var_1 thread playertank_fake_player_enter(var_3, var_2);
  level waittill("start_intro");
  thread maps\satfarm_audio::intro_bins();
  var_1 thread maps\_anim::anim_single(var_0, "intro");
  wait 30.0;
  level.player lerpviewangleclamp(1.0, 0.5, 0, 0, 0, 0, 0);
  wait 1.0;
  thread setup_intro_allies();
  var_42 = common_scripts\utility::getstruct("sat_farm_intro_org", "targetname");
  level.herotanks[0] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("crash_site_hero0");
  level.bobcat = level.herotanks[0];
  level.allytanks = common_scripts\utility::array_combine(level.allytanks, level.herotanks);
  var_43 = [];
  level.playertank.animname = "playertank";
  level.playertank useanimtree(level.scr_animtree[level.playertank.animname]);
  var_43 = common_scripts\utility::add_to_array(var_43, level.playertank);
  var_44 = maps\_utility::spawn_anim_model("crashedtank");
  var_43 = common_scripts\utility::add_to_array(var_43, var_44);
  level.herotanks[0].animname = "allytank_right";
  level.herotanks[0] useanimtree(level.scr_animtree[level.herotanks[0].animname]);
  var_43 = common_scripts\utility::add_to_array(var_43, level.herotanks[0]);
  var_45 = maps\_utility::spawn_anim_model("playerc17");
  var_43 = common_scripts\utility::add_to_array(var_43, var_45);
  var_46 = maps\_utility::spawn_anim_model("crashedc17");
  var_43 = common_scripts\utility::add_to_array(var_43, var_46);
  level.crashedc17_missile_org = common_scripts\utility::spawn_tag_origin();
  level.crashedc17_missile_org linkto(var_46, "tag_origin", (-800, -256, 0), (0, 0, 0));
  var_47 = maps\_utility::spawn_anim_model("allyc17_right");
  var_43 = common_scripts\utility::add_to_array(var_43, var_47);
  var_48 = getent("intro_crewmember1", "targetname");
  var_49 = var_48 maps\_utility::spawn_ai(1);
  var_49 maps\_utility::magic_bullet_shield(1);
  var_49 setCanDamage(0);
  var_49.animname = "intro_crewmember1";
  var_43 = common_scripts\utility::add_to_array(var_43, var_49);
  var_50 = maps\_utility::spawn_anim_model("satfarm_infil_falling_crates1");
  var_43 = common_scripts\utility::add_to_array(var_43, var_50);
  var_51 = spawn("script_model", (0, 0, 0));
  var_51 setModel("saf_federation_crate");
  var_51 linkto(var_50, "J_prop_1", (0, 0, 0), (0, 0, 0));
  var_52 = spawn("script_model", (0, 0, 0));
  var_52 setModel("saf_federation_crate");
  var_52 linkto(var_50, "J_prop_2", (0, 0, 0), (0, 0, 0));
  var_53 = maps\_utility::spawn_anim_model("satfarm_infil_falling_crates2");
  var_43 = common_scripts\utility::add_to_array(var_43, var_53);
  var_54 = spawn("script_model", (0, 0, 0));
  var_54 setModel("saf_federation_crate");
  var_54 linkto(var_53, "J_prop_1", (0, 0, 0), (0, 0, 0));
  var_42 thread maps\_anim::anim_single(var_43, "intro");
  thread intro_background_c17();
  common_scripts\utility::flag_set("aud_tank_drop");
  level.playertank thread playertank_waits();
  level.herotanks[0] thread allytank_right_waits();
  var_45 thread playerc17_waits();
  var_46 thread crashedc17_waits();
  var_47 thread allyc17_right_waits();
  var_44 thread crashedtank_waits();
  var_49 thread intro_crewmember1_waits();
  thread mig_fires_at_c17_scene();
  var_44 thread tank_deploy_chutes("_crashedtank");
  level.herotanks[0] thread tank_deploy_chutes("_allytankright");
  thread maps\satfarm_audio::tank_drop();
  level.player thread maps\_utility::vision_set_fog_changes("satfarm", 0.5);
  wait 0.2;

  foreach(var_56 in var_0) {
    if(isDefined(var_56.magic_bullet_shield))
      var_56 maps\_utility::stop_magic_bullet_shield();

    var_56 delete();
  }

  var_32 delete();
  var_33 delete();
  var_35 delete();
  var_38 delete();
  var_36 delete();
  var_40 delete();
  var_41 delete();
  level.player playerlinktodelta(level.playertank, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(2.0, 0.05, 0.05, 25, 25, 15, 5);
  wait 1.0;
  common_scripts\utility::flag_set("stop_red_flickering_light");
  level.playertank waittillmatch("single anim", "end");

  if(isDefined(var_51))
    var_51 delete();

  if(isDefined(var_52))
    var_52 delete();

  if(isDefined(var_54))
    var_54 delete();

  if(isDefined(var_50))
    var_50 delete();

  if(isDefined(var_53))
    var_53 delete();

  common_scripts\utility::flag_wait("crash_site_end");

  if(isDefined(var_49)) {
    if(isDefined(var_49.magic_bullet_shield))
      var_49 maps\_utility::stop_magic_bullet_shield();

    var_49 delete();
  }
}

intro_crewmember1_waits() {
  self waittillmatch("single anim", "body_impact_ground");
  playFX(level._effect["vfx_bodyfall_dust"], self.origin);
}

black_screen_vo(var_0, var_1) {
  wait 0.25;
  var_0 maps\_utility::smart_dialogue("satfarm_us3_parachutesreaddyyy");
  var_1 maps\_utility::smart_dialogue("satfarm_us2_tankpreppedclearthe");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_plt_alltankcrewsprepare");
  level notify("screen_fading_in_from_black");
}

playertank_fake_player_enter(var_0, var_1) {
  level.player lerpviewangleclamp(1.0, 0.05, 0.05, 25, 30, 10, 25);
  thread maps\_anim::anim_single(var_0, "c17_tank_scene");
  var_0[0] waittillmatch("single anim", "begin_clamping_view");
  level.player lerpviewangleclamp(1.0, 0.05, 0, 0, 0, 0, 0);
  var_0[0] waittillmatch("single anim", "fade_to_black");
  level.player lerpfov(22, 1.1667);
  common_scripts\utility::flag_set("aud_move_to_tank_hud");
  var_2 = maps\_hud_util::create_client_overlay("black", 0, level.player);
  var_2 fadeovertime(1.1667);
  var_2.alpha = 1;
  wait 1.1667;
  level.player playerlinktodelta(var_1, "tag_player", 1, 0, 0, 0, 0, 1);
  maps\_utility::array_delete(var_0);
  level.player lerpviewangleclamp(2.0, 0.05, 0.05, 45, 45, 30, 10);
  level.player freezecontrols(0);
  wait 0.1;
  level notify("start_intro");
  level.player lerpfov(65, 0.05);
  thread maps\satfarm_code::tank_hud_initialize();
  thread hud_init_vo();
  thread maps\satfarm_audio::aud_intro_tank_hud();
  var_2 fadeovertime(0.5);
  var_2.alpha = 0;
  wait 0.5;
  level.player thread maps\_utility::vision_set_fog_changes("satfarm_c17_intro", 0);
  var_2 destroy();
}

hud_init_vo() {
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_us1_weaponsystemscomingonline");
  wait 1.0;
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_us1_gpsisfunctional");
}

intro_background_c17() {
  wait 1.5;
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("intro_background_c17");
}

setup_intro_allies() {
  level.herotanks[1] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_hero1");
  level.badger = level.herotanks[1];
  level.allytanks = common_scripts\utility::array_combine(level.allytanks, level.herotanks);
  level.herotanks[1] thread maps\satfarm_code::npc_tank_combat_init();
  level.herotanks[1] thread maps\satfarm_code::tank_relative_speed("base_array_relative_speed", "crash_site_end", 350, 14, 5);
  thread maps\satfarm_code::switch_node_on_flag(level.herotanks[1], "", "switch_crash_site_path_hero1", "crash_site_path_hero1");
  thread maps\satfarm_crash_site::intro_and_crash_site_ally_setup();
}

intro_commander_waits() {
  self waittillmatch("single anim", "turbulence_shift");
  level notify("turbulence_shift");
  thread turbulence(0.5);
  level.player playrumbleonentity("damage_heavy");
  thread maps\satfarm_audio::intro_rumble();
  thread common_scripts\utility::play_sound_in_space("satf_intro_shake_1", level.player.origin);
  self waittillmatch("single anim", "strafe_attack1");
  level notify("strafe_attack1");
  thread start_strafe_1();
  thread turbulence(0.5);
  level.player playrumbleonentity("damage_heavy");
  thread maps\satfarm_audio::bullet_holes1();
  common_scripts\utility::exploder(1001);
  common_scripts\utility::exploder(1005);
  wait 0.5;
  common_scripts\utility::exploder(2003);
  common_scripts\utility::exploder(1003);
  self waittillmatch("single anim", "cargo_bay_doors_open");
  level notify("cargo_bay_doors_open");
  common_scripts\utility::flag_set("cargo_doors_opened");
  thread maps\satfarm_audio::aud_intro_cargo_doors();
  level.player playrumbleonentity("damage_heavy");
  self waittillmatch("single anim", "strafe_attack2");
  level notify("strafe_attack2");
  thread start_strafe_2();
  thread turbulence(0.5);
  level.player playrumbleonentity("damage_heavy");
  thread common_scripts\utility::play_sound_in_space("satf_intro_shake_2", level.player.origin);
  thread maps\satfarm_audio::bullet_holes3();
  common_scripts\utility::exploder(1002);
  self waittillmatch("single anim", "humvee_minor_explosion");
  level notify("humvee_minor_explosion");
  thread turbulence(0.5);
  level.player playrumbleonentity("damage_heavy");
  self waittillmatch("single anim", "deploy_button_pressed");
  level notify("deploy_button_pressed");
  level.player playrumbleonentity("damage_heavy");
  self waittillmatch("single anim", "humvee_explode");
  thread teleport_mask();
  level notify("humvee_explode");
  thread turbulence(0.5);
  level.player playrumbleonentity("damage_heavy");
  level.player shellshock("satfarm_explosion", 4.0);
  common_scripts\utility::exploder(2002);
  common_scripts\utility::exploder(2001);
  thread common_scripts\utility::play_sound_in_space("satf_cargo_explosion", level.player.origin);
}

teleport_mask() {
  wait 0.75;
  var_0 = maps\_hud_util::create_client_overlay("black", 0, level.player);
  var_0 fadeovertime(0.5);
  var_0.alpha = 0.8;
  wait 0.75;
  var_0 fadeovertime(0.5);
  var_0.alpha = 0;
  wait 0.5;
  var_0 destroy();
}

#using_animtree("vehicles");

playertank_waits() {
  wait 2.75;
  level.player lerpviewangleclamp(2.0, 0.5, 0, 0, 0, 0, 0);
  self waittillmatch("single anim", "player_tank_lands");
  playFXOnTag(level._effect["vfx_tank_landing_dust"], self, "tag_origin");
  level.player thread maps\_gameskill::display_screen_effect("dirt", "bottom", "fullscreen_dirt_bottom", "fullscreen_dirt_bottom_b", randomfloatrange(0.55, 0.66));
  level.player screenshakeonentity(2.0, 2.0, 2.0, 2.666, 0, 2.666, 128, 3, 3, 3);
  level.player playrumbleonentity("damage_heavy");
  level.player playrumblelooponentity("subtle_tank_rumble");
  wait 2.666;
  level.playertank maps\_utility::anim_stopanimscripted();
  level.player stoprumble("subtle_tank_rumble");
  level.playertank useanimtree(#animtree);
  level.playertank setanim(%abrams_movement, 1, 0);
  wait 0.05;
  stopFXOnTag(level._effect["vfx_tank_landing_dust"], self, "tag_origin");
  level.player enableslowaim(0.5, 0.25);
  level.player unlink();
  level.playertank makeusable();
  level.playertank useby(level.player);
  level.playertank makeunusable();
  level.player thread maps\satfarm_code::tank_hud(level.playertank);
  level.player lerpviewangleclamp(1, 0.05, 0.05, 180, 180, 30, 5);
  level.playertank thread maps\satfarm_code::player_view_clamp();
  setsaveddvar("cg_viewVehicleInfluence", 0.1);
  level.playertank vehicle_setspeedimmediate(50, 20, 1);
  common_scripts\utility::flag_set("intro_end");
  common_scripts\utility::flag_set("player_in_tank");
  setsaveddvar("aim_aimAssistRangeScale", "1");
  setsaveddvar("aim_autoAimRangeScale", "1");
  thread maps\satfarm_code::tank_zoom();
  level.player thread maps\satfarm_code::init_chatter();
  level.player thread maps\satfarm_code::take_fire_tracking();
  level.playertank thread maps\satfarm_code::tank_health_monitor();
  level.playertank thread maps\satfarm_code::tank_boost();
  level.playertank thread maps\satfarm_code::on_fire_main_cannon();
  level.playertank thread maps\satfarm_code::on_fire_mg();
  level.playertank thread maps\satfarm_code::tank_handle_sabot();
  level.playertank thread maps\satfarm_code::on_pop_smoke();
  level.playertank thread maps\satfarm_code::on_fire_sabot();
  level.playertank thread maps\satfarm_code::tank_quake();
  level.player thread maps\satfarm_code::toggle_thermal();
  thread maps\satfarm_code::mark_friendly_vehicles();
  level.playertank maps\satfarm_code::listen_player();
  thread maps\satfarm_code::exiting_combat_zone();
  thread maps\satfarm_code::fire_tracking_missile_mig();
  level thread maps\satfarm_audio::player_tank_sounds();
  level.player freezecontrols(0);
  var_0 = 0;

  while(var_0 < 1.0) {
    var_1 = level.player getnormalizedmovement();

    if(var_1[0] || var_1[1]) {
      break;
    }

    level.playertank vehicle_setspeedimmediate(50, 20, 1);
    var_0 = var_0 + 0.05;
    wait 0.05;
  }
}

allytank_right_waits() {
  self waittillmatch("single anim", "ally_tank_lands");
  playFXOnTag(level._effect["vfx_tank_landing_dust"], self, "tag_origin");
  self waittillmatch("single anim", "end");
  stopFXOnTag(level._effect["vfx_tank_landing_dust"], self, "tag_origin");
  wait 0.05;
  self useanimtree(#animtree);
  thread maps\satfarm_code::npc_tank_combat_init();
}

crashedtank_waits() {
  self waittillmatch("single anim", "crashed_ally_tank_lands");
  playFXOnTag(level._effect["vfx_tank_landing_dust"], self, "tag_origin");
  self waittillmatch("single anim", "end");
  stopFXOnTag(level._effect["vfx_tank_landing_dust"], self, "tag_origin");
  common_scripts\utility::flag_wait("crash_site_end");

  if(isDefined(self))
    self delete();
}

playerc17_waits() {
  level notify("stop_camera_roll");
  playFXOnTag(level._effect["vfx_smoke_jetfire_geotrail"], self, "tag_engine_left_1");
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0 linkto(self, "tag_origin", (-400, 0, 120), (180, 0, 0));
  playFXOnTag(level._effect["vfx_smk_black_outside"], var_0, "tag_origin");
  wait 0.05;
  playFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_left_1");
  playFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_left_2");
  playFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_right_1");
  playFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_right_2");
  wait 0.05;
  self waittillmatch("single anim", "end");
  stopFXOnTag(level._effect["vfx_smoke_jetfire_geotrail"], self, "tag_engine_left_1");
  stopFXOnTag(level._effect["vfx_smk_black_outside"], var_0, "tag_origin");
  stopFXOnTag(level._effect["vfx_c17_dust_vortex"], self, "tag_origin");
  wait 0.05;
  stopFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_left_1");
  stopFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_left_2");
  stopFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_right_1");
  stopFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_right_2");
  wait 0.05;
  var_0 delete();
  self delete();
}

crashedc17_waits() {
  playFXOnTag(level._effect["vfx_c17_dust_vortex"], self, "tag_origin");
  wait 0.05;
  playFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_left_1");
  playFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_left_2");
  playFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_right_1");
  playFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_right_2");
  self waittillmatch("single anim", "end");
  wait 0.05;
  stopFXOnTag(level._effect["vfx_c17_dust_vortex"], self, "tag_origin");
  wait 0.05;
  stopFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_left_1");
  stopFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_left_2");
  stopFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_right_1");
  stopFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_right_2");
  wait 0.05;
  self delete();
}

allyc17_right_waits() {
  playFXOnTag(level._effect["vfx_c17_dust_vortex"], self, "tag_origin");
  wait 0.05;
  playFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_left_1");
  playFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_left_2");
  playFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_right_1");
  playFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_right_2");
  self waittillmatch("single anim", "end");
  stopFXOnTag(level._effect["vfx_c17_dust_vortex"], self, "tag_origin");
  wait 0.05;
  stopFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_left_1");
  stopFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_left_2");
  stopFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_right_1");
  stopFXOnTag(level._effect["vfx_smk_jetfumes_geotrail"], self, "tag_engine_right_2");
  wait 0.05;
  self delete();
}

mig_fires_at_c17_scene() {
  wait 1.0;
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_mig29_missile_c17_01");
  var_0 thread maps\satfarm_ambient_a10::mig29_afterburners_node_wait();
}

tank_deploy_chutes(var_0) {
  var_1 = common_scripts\utility::getstruct("sat_farm_intro_org", "targetname");
  var_2 = "pilot_chute" + var_0;
  var_3 = maps\_utility::spawn_anim_model(var_2);
  var_3 hide();
  var_4 = [];

  for(var_5 = 0; var_5 <= 2; var_5++) {
    var_2 = "main_chute" + var_5 + var_0;
    var_4[var_5] = maps\_utility::spawn_anim_model(var_2);
    var_4[var_5] hide();
  }

  var_1 thread maps\_anim::anim_first_frame_solo(var_3, "pilot_chute_deploy");
  var_1 thread maps\_anim::anim_first_frame(var_4, "main_chute_deploy");
  self waittillmatch("single anim", "spawn_pilot_chute");
  var_3 show();
  var_1 thread maps\_anim::anim_single_solo(var_3, "pilot_chute_deploy");
  self waittillmatch("single anim", "spawn_main_chutes");

  foreach(var_7 in var_4)
  var_7 show();

  var_1 thread maps\_anim::anim_single(var_4, "main_chute_deploy");
  common_scripts\utility::flag_wait("crash_site_end");
  var_3 delete();

  foreach(var_7 in var_4)
  var_7 delete();
}

intro_cleanup() {
  var_0 = getEntArray("intro_ent", "script_noteworthy");
  maps\_utility::array_delete(var_0);
}

setup_camera_roll(var_0) {
  level endon("stop_camera_roll");
  level.view_rollers = [];
  level.org_view_roll = spawn("script_origin", (0, 0, 0));
  level.org_view_roll linkto(var_0, "J_prop_2", (0, 0, 0), (0, 0, 0));
  level.org_view_roll thread stop_camera_roll();
  setup_bullet_pinholes();
  var_1 = 1;
  var_2[0] = 0.25;
  var_2[1] = 0.625;

  for(;;) {
    var_3 = randomfloatrange(4.0, 6.0);
    var_4 = var_1 * randomfloatrange(var_2[0], var_2[1]);
    var_1 = -1 * var_1;
    var_5 = (0, 0, var_4);
    common_scripts\utility::array_thread(level.view_rollers, ::rotate_rollers_to, var_5, var_3, var_3 / 3, var_3 / 3);
    wait(var_3);
  }
}

rotate_rollers_to(var_0, var_1, var_2, var_3) {
  self rotateto(var_0, var_1, var_2, var_3);
}

stop_camera_roll() {
  level waittill("stop_camera_roll");
  wait 0.05;
  thread cleanup_bullet_pinhole_stuff();
}

turbulence(var_0) {
  thread turbulence_loop();
  var_1 = var_0;
  wait(var_1);
  common_scripts\utility::flag_set("stop_turbulence");
  var_2 = abs(level.turbangles[0]) / 8;
  level.org_view_roll rotateto((0, 0, 0), var_2, 0, 0);
  wait(var_2);
}

turbulence_loop() {
  level endon("stop_turbulence");
  var_0 = 1;
  level.rocking_mag[0] = 0.3;
  level.rocking_mag[1] = 0.5;
  level.pitch_mag[0] = 2;
  level.pitch_mag[1] = 5;

  for(;;) {
    var_1 = randomfloatrange(0.1, 0.2);
    var_2 = var_0 * randomfloatrange(level.pitch_mag[0], level.pitch_mag[1]);
    var_3 = var_0 * randomfloatrange(level.rocking_mag[0], level.rocking_mag[1]);
    var_4 = var_0 * randomfloatrange(level.rocking_mag[0], level.rocking_mag[1]);
    var_0 = -1 * var_0;
    level.turbangles = (var_2, var_3, var_4);
    earthquake(0.1, var_1, level.player.origin, 80000);
    level.org_view_roll rotateto(level.turbangles, var_1, var_1 / 3, var_1 / 3);
    wait(var_1);
  }
}

setup_bullet_pinholes() {
  var_0 = getEntArray("bullet_pinhole_org", "targetname");
  level.strafe_1_bullet_tags = [];
  level.strafe_2_bullet_tags = [];
  level.bullet_pinhole_tag_fx_orgs = [];

  foreach(var_2 in var_0) {
    var_2 hide();
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.origin = var_2.origin;
    level.view_rollers = common_scripts\utility::array_add(level.view_rollers, var_3);
    var_2.fx_org = common_scripts\utility::spawn_tag_origin();
    level.bullet_pinhole_tag_fx_orgs = common_scripts\utility::array_add(level.bullet_pinhole_tag_fx_orgs, var_2.fx_org);
    var_2.fx_org.origin = var_2.origin;
    var_4 = common_scripts\utility::getstruct(var_2.target, "targetname");
    var_2.fx_org.angles = vectortoangles(var_4.origin - var_2.origin);
    var_2.fx_org linkto(var_3);

    if(isDefined(var_2.script_parameters)) {
      if(var_2.script_parameters == "strafe_1_bullet_tags") {
        level.strafe_1_bullet_tags = common_scripts\utility::array_add(level.strafe_1_bullet_tags, var_2);
        continue;
      }

      if(var_2.script_parameters == "strafe_2_bullet_tags")
        level.strafe_2_bullet_tags = common_scripts\utility::array_add(level.strafe_2_bullet_tags, var_2);
    }
  }
}

bullet_strafe_start() {
  wait(randomfloatrange(0.1, 0.75));
  self show();
  var_0 = common_scripts\utility::getstruct(self.target, "targetname");
  magicbullet("minigun_m1a1", self.origin, var_0.origin);
  playFXOnTag(level._effect["large_metal_painted_hull_exit"], self.fx_org, "tag_origin");
  level.player playrumbleonentity("minigun_rumble");
  level waittill("stop_camera_roll");
  stopFXOnTag(level._effect["large_metal_painted_hull_exit"], self.fx_org, "tag_origin");
}

start_strafe_1() {
  level.strafe_1_bullet_tags = sortbydistance(level.strafe_1_bullet_tags, level.player.origin);

  foreach(var_1 in level.strafe_1_bullet_tags)
  var_1 thread bullet_strafe_start();
}

start_strafe_2() {
  level.strafe_2_bullet_tags = sortbydistance(level.strafe_2_bullet_tags, level.player.origin);
  level.strafe_2_bullet_tags = common_scripts\utility::array_reverse(level.strafe_2_bullet_tags);

  foreach(var_1 in level.strafe_2_bullet_tags)
  var_1 thread bullet_strafe_start();
}

cleanup_bullet_pinhole_stuff() {
  maps\_utility::array_delete(level.bullet_pinhole_tag_fx_orgs);
  maps\_utility::array_delete(level.view_rollers);
  maps\_utility::array_delete(level.strafe_1_bullet_tags);
  maps\_utility::array_delete(level.strafe_2_bullet_tags);
}

saf_c17_lower_backdoor_top_setup(var_0) {
  var_1 = getent("saf_c17_lower_backdoor_top", "script_noteworthy");
  var_2 = getEntArray("saf_c17_lower_backdoor_top_script_model", "script_noteworthy");

  foreach(var_4 in var_2)
  var_4 linkto(var_1);

  common_scripts\utility::flag_wait("cargo_doors_opened");

  if(isDefined(var_0))
    wait(var_0);

  common_scripts\utility::exploder(2006);
  var_1 rotateroll(30, 8.0);
  level waittill("stop_camera_roll");
  var_1 delete();
  maps\_utility::array_delete(var_2);
}

saf_c17_lower_backdoor_setup(var_0) {
  var_1 = getent("saf_c17_lower_backdoor", "script_noteworthy");
  var_2 = getEntArray("saf_c17_lower_backdoor_script_model", "script_noteworthy");

  foreach(var_4 in var_2)
  var_4 linkto(var_1);

  common_scripts\utility::flag_wait("cargo_doors_opened");

  if(isDefined(var_0))
    wait(var_0);

  var_1 rotateroll(30, 8.0);
  level waittill("stop_camera_roll");
  var_1 delete();
  maps\_utility::array_delete(var_2);
}

intro_red_flickering_light() {
  var_0 = getent("red_flash", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  level waittill("strafe_attack1");
  var_0 setlightcolor((1, 0, 0));
  common_scripts\utility::flag_wait("stop_red_flickering_light");
  var_0 delete();
}