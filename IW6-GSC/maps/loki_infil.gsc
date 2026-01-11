/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\loki_infil.gsc
*****************************************************/

section_

section_precache() {
  precachemodel("viewmodel_arx_160");
  precachemodel("viewmodel_acog_iw6");
  precachemodel("viewmodel_reticle_acog");
  precachemodel("viewmodel_grenade_launcher");
  precacherumble("steady_rumble");
  precacherumble("light_2s");
  precacherumble("light_3s");
  precacherumble("heavy_1s");
  precacherumble("heavy_3s");
}

section_flag_inits() {
  common_scripts\utility::flag_init("first_wave_spawned");
  common_scripts\utility::flag_init("left_pressed");
  common_scripts\utility::flag_init("right_pressed");
}

infil_start() {
  maps\loki_util::player_move_to_checkpoint_start("infil");
  maps\loki_util::spawn_allies();
  thread setup_fuel_leak_lighting();
  level.accuracy_ally = 0.6;
  level.accuracy_enemy = 1.4;
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("actionSlotsHide", 1);
  setsaveddvar("hud_showStance", 0);
  level.player allowsprint(0);
  level notify("kill_thrusters");
  level.allies[0].fixednode = 1;
  level.allies[1].baseaccuracy = level.accuracy_ally;
  level.allies[2].fixednode = 1;
  level.allies[2].baseaccuracy = level.accuracy_ally;
  level thread maps\loki_combat_one::firstframe_combat_one_door();
}

infil() {
  maps\loki_util::loki_autosave_by_name_silent("infil");
  thread maps\loki_audio::audio_set_fadein_ambience();
  common_scripts\utility::exploder("c1_sunflare");
  common_scripts\utility::flag_wait("infil_introscreen_done");
  thread maps\loki_audio::audio_set_infil_ambience();
  thread maps\loki_fx::loki_infil_lighting();
  level thread infil_vignette();

  if(maps\_utility::is_gen4()) {
    setsaveddvar("r_mbEnable", 0);
  }

  common_scripts\utility::flag_wait("infil_done");
}

infil_vignette() {
  var_0 = getent("infil_vignette", "targetname");
  var_1 = getent("infil_vignette_shuttle", "targetname");
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player hideviewmodel();
  level.player enableinvulnerability();
  level.player.ignoreme = 1;
  var_2 = maps\_utility::spawn_anim_model("player_rig");
  level.player_rig = var_2;
  var_3 = maps\_utility::spawn_anim_model("infil_shuttle");
  var_4 = maps\_utility::spawn_anim_model("infil_shuttle_interior");
  var_5 = common_scripts\utility::spawn_tag_origin();
  var_5.angles = (0, -90, 0);
  var_5 linkto(var_3);
  playFXOnTag(level._effect["interior_shuttle_light"], var_4, "tag_fx_001");
  playFXOnTag(level._effect["interior_shuttle_light"], var_4, "tag_fx_002");
  common_scripts\utility::waitframe();
  playFXOnTag(level._effect["interior_shuttle_light"], var_4, "tag_fx_003");
  playFXOnTag(level._effect["interior_shuttle_light"], var_4, "tag_fx_004");
  playFXOnTag(level._effect["interior_shuttle_flare_lights"], var_4, "tag_fx_005");
  common_scripts\utility::waitframe();
  playFXOnTag(level._effect["interior_shuttle_light"], var_4, "tag_fx_006");
  level.infil_grenade = maps\_utility::spawn_anim_model("infil_grenade");
  level.infil_grenade linkto(var_3);
  var_6 = maps\_utility::spawn_anim_model("infil_arx");
  var_6 linkto(var_3);
  var_6 attach("viewmodel_acog_iw6", "TAG_ACOG_2", 1);
  var_6 attach("viewmodel_reticle_acog", "TAG_RETICLE_ATTACH", 1);
  var_6 attach("viewmodel_grenade_launcher", "TAG_GRENADE_LAUNCHER", 1);
  var_6 hidepart("TAG_SIGHT_ON", "viewmodel_arx_160");
  var_2 linkto(var_3);
  var_4 linkto(var_3);
  var_7 = [];
  var_7["player_rig"] = var_2;
  var_7["infil_arx"] = var_6;
  var_7["infil_grenade"] = level.infil_grenade;
  level.player playerlinktodelta(var_2, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player playersetgroundreferenceent(var_5);
  level.player common_scripts\utility::delaycall(0.2, ::playerlinktodelta, var_2, "tag_player", 1, 45, 45, 45, 30, 1);
  thread infil_ally(var_0, level.allies[0], "cover_one_ally0_node1", var_3);
  thread infil_ally(var_0, level.allies[1], "cover_one_ally1_node1", var_3);
  thread infil_ally(var_0, level.allies[2], "cover_one_ally2_node1", var_3);
  thread create_redshirts(var_0, var_3);
  maps\_utility::delaythread(17, maps\loki_audio::sfx_temp_redshirt_stinger);
  maps\_utility::delaythread(15, maps\loki_combat_one::spawn_wave1_enemies, 0);
  var_0 thread maps\_anim::anim_single_solo(var_3, "infil");
  var_4 thread maps\_anim::anim_single_solo(var_4, "infil_still");
  var_8 = getanimlength(var_2 maps\_utility::getanim("infil_still"));
  level.player maps\_utility::delaythread(var_8 - 2.5, ::enablesomecontrol, var_2);
  level.player thread maps\loki_audio::sfx_intro_load_weapon();
  level.player thread maps\loki_audio::sfx_intro_seat_unlock();
  var_2 maps\_anim::anim_single(var_7, "infil_still");
  level.player playersetgroundreferenceent(undefined);
  level.player unlink();
  level thread maps\_space_player::space_thruster_audio();
  level thread infil_push();
  level thread maps\loki_combat_one::movement_hints();
  var_2 delete();
  var_6 delete();
  var_5 delete();
  level.player disableinvulnerability();
  level.player maps\_utility::delaythread(4, ::ignore_player, 0);
  level maps\_utility::delaythread(4, maps\loki_util::player_boundaries_on);
  common_scripts\utility::flag_set("infil_done");
  killfxontag(level._effect["interior_shuttle_light"], var_4, "tag_fx_001");
  killfxontag(level._effect["interior_shuttle_light"], var_4, "tag_fx_002");
  common_scripts\utility::waitframe();
  killfxontag(level._effect["interior_shuttle_light"], var_4, "tag_fx_003");
  killfxontag(level._effect["interior_shuttle_light"], var_4, "tag_fx_004");
  killfxontag(level._effect["interior_shuttle_flare_lights"], var_4, "tag_fx_005");
  common_scripts\utility::waitframe();
  killfxontag(level._effect["interior_shuttle_light"], var_4, "tag_fx_006");
}

infil_grenade_delete(var_0) {
  level.infil_grenade delete();
}

ignore_player(var_0) {
  level.player.ignoreme = var_0;
}

enablesomecontrol(var_0) {
  level.player endon("death");
  var_0 hide();
  level.player freezecontrols(0);
  level.player enableweapons();
  level.player showviewmodel();
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("actionSlotsHide", 0);
  wait 5;
  level maps\_utility::smart_radio_dialogue("loki_kgn_thompsontangos12high");
}

infil_push() {
  level.player endon("death");
  level endon("stop_pushing");
  maps\loki_util::jkuprint("PUSHING");
  level thread infil_blend_push_out();
  level.infil_ratex = 2400;
  level.infil_ratey = 10000;
  level.infil_ratez = 6700;
  var_0 = 9;
  var_0 = var_0 * 1000;
  var_1 = var_0 / 50;
  var_2 = level.infil_ratex / var_1;
  var_3 = level.infil_ratey / var_1;
  var_4 = level.infil_ratez / var_1;

  for(var_5 = 0; var_5 < var_1; var_5++) {
    setsaveddvar("player_swimWaterCurrent", (level.infil_ratex, level.infil_ratey, level.infil_ratez));

    if(level.infil_ratex > 0) {
      level.infil_ratex = level.infil_ratex - var_2;
    }

    if(level.infil_ratey > 0) {
      level.infil_ratey = level.infil_ratey - var_3;
    }

    if(level.infil_ratez > 0) {
      level.infil_ratez = level.infil_ratez - var_4;
    }

    common_scripts\utility::waitframe();
  }

  level notify("stop_pushing_blend_out");
  level.player allowsprint(1);
  setsaveddvar("player_swimWaterCurrent", (0, 0, 0));
}

infil_blend_push_out() {
  level.player endon("death");
  level endon("stop_pushing_blend_out");
  var_0 = 0;

  for(;;) {
    var_1 = level.player getnormalizedmovement();

    if(abs(var_1[0]) > 0.15 || abs(var_1[1]) > 0.15) {
      var_0++;

      if(var_0 > 20) {
        break;
      }
    }

    if(level.player fragbuttonpressed()) {
      var_0++;

      if(var_0 > 20) {
        break;
      }
    }

    common_scripts\utility::waitframe();
  }

  level notify("stop_pushing");
  maps\loki_util::jkuprint("STOP PUSHING");
  var_2 = 2;
  var_2 = var_2 * 1000;
  var_3 = var_2 / 50;
  var_4 = level.infil_ratex / var_3;
  var_5 = level.infil_ratey / var_3;
  var_6 = level.infil_ratez / var_3;

  for(var_7 = 0; var_7 < var_3; var_7++) {
    setsaveddvar("player_swimWaterCurrent", (level.infil_ratex, level.infil_ratey, level.infil_ratez));

    if(level.infil_ratex > 0) {
      level.infil_ratex = level.infil_ratex - var_4;
    }

    if(level.infil_ratey > 0) {
      level.infil_ratey = level.infil_ratey - var_5;
    }

    if(level.infil_ratez > 0) {
      level.infil_ratez = level.infil_ratez - var_6;
    }

    common_scripts\utility::waitframe();
  }

  level.player allowsprint(1);
  setsaveddvar("player_swimWaterCurrent", (0, 0, 0));
}

infil_ally(var_0, var_1, var_2, var_3) {
  var_1 endon("death");
  var_1 forceteleport(var_3.origin, var_3.angles);
  var_1 linkto(var_3);
  var_1 maps\_utility::ent_flag_clear("lights_on");
  var_2 = getnode(var_2, "targetname");
  var_1 setgoalnode(var_2);
  var_1 maps\_anim::anim_single_solo(var_1, "infil_still");
  var_1 unlink();

  if(var_1.animname == "ally_2") {
    var_4 = maps\_vignette_util::vignette_actor_spawn("infil_opfor", "infil_opfor");
    var_4 thread maps\_space_ai::space_actor_lights();
    var_4 thread maps\loki_combat_one::force_traversal_check_hit();
    var_5 = [];
    var_5["ally_2"] = level.allies[2];
    var_5["infil_opfor"] = var_4;
    var_0 maps\_anim::anim_single(var_5, "infil");
    var_4 thread kill_after_vignette();
  } else {
    var_5 = [];
    var_5[var_1.animname] = var_1;
    var_0 maps\_anim::anim_single(var_5, "infil");
  }
}

create_redshirts(var_0, var_1) {
  var_2 = [];
  var_2[0] = maps\loki_util::spawn_space_ai_from_targetname("infil_redshirt_0");
  var_2[0].animname = "redshirt_0";
  var_2[0].first_goal_node = "cover_one_redshirt2_node1";
  var_2[0] setModel("us_space_assault_b_body_cracked");
  var_2[1] = maps\loki_util::spawn_space_ai_from_targetname("infil_redshirt_1");
  var_2[1].animname = "redshirt_1";
  var_2[1].first_goal_node = "cover_one_redshirt1_node1";
  var_2[2] = maps\loki_util::spawn_space_ai_from_targetname("infil_redshirt_2");
  var_2[2].animname = "redshirt_2";
  var_2[2].first_goal_node = "cover_one_redshirt2_node1";
  var_2[3] = maps\loki_util::spawn_space_ai_from_targetname("infil_redshirt_3");
  var_2[3].animname = "redshirt_3";
  var_2[3].first_goal_node = "cover_one_redshirt2_node1";
  var_2[3].ignoreme = 1;
  level.redshirts = var_2;

  foreach(var_4 in var_2) {
    var_4 thread infil_redshirt(var_0, var_1);
  }
}

infil_redshirt(var_0, var_1) {
  self endon("death");
  thread maps\loki_util::loki_drop_weapon();
  self.grenadeammo = 0;
  maps\_utility::set_force_color("r");
  self.health = 75;
  maps\_utility::ent_flag_clear("lights_on");
  self.baseaccuracy = level.accuracy_ally;
  maps\_utility::magic_bullet_shield(1);
  var_2 = getnode(self.first_goal_node, "targetname");
  self setgoalnode(var_2);

  if(isDefined(var_1)) {
    self forceteleport(var_1.origin, var_1.angles);
    self linkto(var_1);
    maps\_anim::anim_single_solo(self, "infil_still");
    self unlink();

    if(self.animname != "redshirt_0") {
      var_0 maps\_anim::anim_single_solo(self, "infil");
      maps\_utility::stop_magic_bullet_shield();
    }
  }

  if(self.animname == "redshirt_3" || self.animname == "redshirt_0") {
    thread kill_after_vignette();
  }
}

lights_on(var_0) {
  var_0 thread maps\_utility::ent_flag_set("lights_on");
}

kill_during_vignette(var_0) {
  var_0 notify("faux_death");
  var_0 notify("stop_traversal_hit_detection");
  var_0 maps\_utility::clear_force_color();
  var_0.team = "neutral";
}

kill_after_vignette() {
  self.deathfunction = maps\_space_ai::ai_space_death;

  if(isDefined(self.magic_bullet_shield)) {
    maps\_utility::stop_magic_bullet_shield();
  }

  self.script_noteworthy = "combat_one_cleanup";
  self.grenadeammo = 0;
  self.a.nodeath = 1;
  self.diequietly = 1;
  self kill();
}

doors_open(var_0) {
  level.player endon("death");
  level maps\_utility::smart_radio_dialogue("loki_shp1_baydoorsopeningicarus");
  level maps\_utility::smart_radio_dialogue("loki_mrk_makeitfasticarus");
  level maps\_utility::smart_radio_dialogue("loki_kgn_readyforsomerevenge");
  level maps\_utility::smart_radio_dialogue("loki_kgn_evasuitsareen");
  wait 1;
  common_scripts\utility::flag_set("combat_one_music_start");
  level maps\_utility::smart_radio_dialogue("loki_kgn_weaponshot");
}

doors_open_flicker(var_0) {
  level.player endon("death");
  var_1 = maps\loki_util::create_rumble_ent(895, "infil_cleanup", 7.25);
  var_1 common_scripts\utility::delaycall(0.5, ::playrumblelooponentity, "steady_rumble");
  wait 2.0;
  level thread maps\loki_fx::loki_default_lighting_lerp_setup();
}

setup_fuel_leak_lighting() {
  var_0 = getEntArray("combat_one_light", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 setlightradius(13);
    var_2 setlightintensity(0.01);
  }
}

infil_quakes() {
  level.player endon("death");
  level endon("end_infil_quakes");
  level thread infil_light_flicker(3);
  earthquake(0.15, 0.5, level.player.origin, 1600);
  wait 1.5;
  level thread infil_light_flicker(3);
  earthquake(0.25, 0.5, level.player.origin, 1600);
  wait 2.5;
  level thread infil_light_flicker(3);
  earthquake(0.25, 0.5, level.player.origin, 1600);
  wait 2.25;
  level thread infil_light_flicker(3);
  earthquake(0.35, 0.5, level.player.origin, 1600);
  wait 2;
  level thread infil_light_flicker(3);
  earthquake(0.25, 0.5, level.player.origin, 1600);
  wait 0.5;
  level thread infil_light_flicker(3);
  earthquake(0.25, 0.5, level.player.origin, 1600);
  wait 1;
  level thread infil_light_flicker(3);
  earthquake(0.25, 0.5, level.player.origin, 1600);
  wait 2;
  earthquake(0.5, 1, level.player.origin, 1600);
  wait 1.5;
  earthquake(0.5, 1, level.player.origin, 1600);
  wait 1.75;
  earthquake(0.35, 0.5, level.player.origin, 1600);
}

infil_light_flicker(var_0) {
  if(randomint(var_0) == 0) {
    if(common_scripts\utility::cointoss()) {
      level.player maps\_hud_util::fade_out(0.05, "black");
      wait 0.05;
      level.player maps\_hud_util::fade_in(0.1, "black");
    } else {
      level.player maps\_hud_util::fade_out(0.05, "black");
      wait 0.05;
      level.player maps\_hud_util::fade_in(0.1, "black");
      wait 0.2;
      level.player maps\_hud_util::fade_out(0.05, "black");
      wait 0.15;
      level.player maps\_hud_util::fade_in(0.1, "black");
    }
  }
}

infil_cleanup() {
  var_0 = getEntArray("infil_cleanup", "script_noteworthy");
  maps\loki_util::jkuprint(var_0.size + ": infil ents cleaned up");
  maps\_utility::array_delete(var_0);
}

first_move(var_0) {
  maps\loki_util::loki_autosave_by_name_silent("combat_one");
  var_1 = maps\loki_util::create_rumble_ent(-800, "infil_cleanup", 8);
  var_1 playrumbleonentity("light_2s");
}

ally_through_sat_panel(var_0) {
  glassradiusdamage(var_0.origin, 80, 1000, 1000);
}

headshot_redshirt(var_0) {
  var_1 = common_scripts\utility::getstruct("combat_one_ally_2", "targetname");
  wait 0.5;
  magicbullet("arx160_space", var_1.origin, var_0 gettagorigin("J_Head"));
  common_scripts\utility::noself_delaycall(0.1, ::magicbullet, "arx160_space", var_1.origin, var_0 gettagorigin("J_Head"));
  var_0 thread maps\_space_ai::ai_space_headshot_death();
}