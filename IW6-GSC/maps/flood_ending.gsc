/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_ending.gsc
*****************************************************/

section_main() {
  level.ending_vo_heli_time = undefined;
}

section_precache() {
  precacheshader("hud_icon_p226");
  precacherumble("heavygun_fire");
  precacherumble("damage_heavy");
  precacherumble("damage_light");
  precacherumble("steady_rumble");
  precacherumble("subtle_tank_rumble");
  precacheshellshock("flood_helicopter");
  precachemodel("vehicle_nh90_flood_front");
  precachemodel("vehicle_nh90_flood_mid");
  precachemodel("flood_outro_wire");
  precachemodel("flood_outro_gate");
  precachemodel("head_venezuela_army_head_db");
  precacheitem("p226_flood_ending");
  level._effect["fx_usp_muzzle_flash"] = loadfx("fx/muzzleflashes/beretta_flash_wv");
}

section_flag_inits() {
  common_scripts\utility::flag_init("ending_ally_0_breach_ready");
  common_scripts\utility::flag_init("ending_ally_1_breach_ready");
  common_scripts\utility::flag_init("ending_done");
  common_scripts\utility::flag_init("smash_rate_bad");
  common_scripts\utility::flag_init("qte_prompt_solid");
  common_scripts\utility::flag_init("already_failing");
  common_scripts\utility::flag_init("hvt_dead");
  common_scripts\utility::flag_init("ending_qte_catch_active");
  common_scripts\utility::flag_init("ending_qte_reach_active");
  common_scripts\utility::flag_init("ending_gate_open");
  common_scripts\utility::flag_init("player_entering_final_area");
  common_scripts\utility::flag_init("vignette_ending_qte_grabbed");
  common_scripts\utility::flag_init("ending_anims_ready");
  common_scripts\utility::flag_init("ending_vo_breach");
  common_scripts\utility::flag_init("ending_vo_2");
  common_scripts\utility::flag_init("ending_vo_3");
  common_scripts\utility::flag_init("ending_vo_pt2_start");
  common_scripts\utility::flag_init("ending_vo_done");
}

ending_start() {
  maps\flood_util::player_move_to_checkpoint_start("ending_start");
  maps\flood_util::spawn_allies();
  level.allies[0] maps\_utility::set_force_color("r");
  level.allies[1] maps\_utility::set_force_color("y");
  level.allies[2] maps\_utility::set_force_color("g");
  common_scripts\utility::flag_set("garage_ally_0_door_ready");
  common_scripts\utility::flag_set("garage_ally_1_door_ready");
  common_scripts\utility::flag_set("garage_ally_2_door_ready");
  maps\_utility::activate_trigger_with_targetname("garage_ally_move480");
  level thread maps\flood_garage::door_open();
  level.player takeweapon("r5rgp");
  level.player takeweapon("p226");
  level.player giveweapon("pp19+eotechsmg_sp");
  maps\flood_anim::debris_bridge_final_loop();
  maps\flood_rooftops::rooftops_cleanup_post_debrisbridge();
  level thread ending_vo_main();
}

ending() {
  common_scripts\utility::flag_wait("garage_done");
  setdvar("ui_deadquote", "");
  thread maps\flood_swept::swept_water_toggle("swim", "hide");
  thread maps\flood_swept::swept_water_toggle("debri_bridge", "hide");
  thread maps\flood_swept::swept_water_toggle("ending_water", "show");
  level thread maps\_utility::autosave_by_name_silent("ending_start");
  level thread maps\flood_anim::ending_animatic_setup();
  level thread move_to_breach();
  thread door_close_behind();
  common_scripts\utility::flag_wait("ending_done");
  maps\_utility::nextmission();
  level waittill("forever");
}

move_to_breach() {
  var_0 = getent("garage_ally_move480", "targetname");

  if(isDefined(var_0)) {
    var_0 delete();
  }

  maps\_utility::activate_trigger_with_targetname("ending_color_order_start");
}

ending_set_stacked_flag(var_0) {
  var_1 = getnode("ending_ally_" + var_0 + "_node", "targetname");

  while(distance(self.origin, var_1.origin) > 32) {
    wait 0.05;
  }

  common_scripts\utility::flag_set("ending_ally_" + var_0 + "_breach_ready");
}

door_open(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  var_3 = getEntArray(var_1, "targetname");
  var_4 = 0.3;

  foreach(var_6 in var_2) {
    var_6 rotateyaw(130, var_4, 0, 0.2);

    if(var_6.classname == "script_brushmodel") {
      var_6 connectpaths();
    }
  }

  foreach(var_6 in var_3) {
    var_6 rotateyaw(-130, var_4, 0, 0.2);

    if(var_6.classname == "script_brushmodel") {
      var_6 connectpaths();
    }
  }

  wait(var_4);
}

door_close_behind() {
  common_scripts\utility::flag_wait("ending_transient_trigger");
  var_0 = level.allies;
  var_1 = getent("ally_door_check", "targetname");
  var_2 = var_1 maps\_utility::get_ai_touching_volume("allies");
  var_0 = common_scripts\utility::array_remove_array(var_0, var_2);
  var_3 = "";

  foreach(var_5 in var_0) {
    if(var_5 == level.allies[0]) {
      var_3 = "ending_door_teleport_0";
    }

    if(var_5 == level.allies[1]) {
      var_3 = "ending_door_teleport_1";
    }

    if(var_5 == level.allies[2]) {
      var_3 = "ending_door_teleport_2";
    }

    var_6 = common_scripts\utility::getstruct(var_3, "targetname");
    var_5 forceteleport(var_6.origin, var_6.angles);
  }

  if(isDefined(level.ending_gate_l)) {
    level.ending_gate_node_left maps\_anim::anim_first_frame_solo(level.ending_gate_l, "outro_pt1_breach");
    level.ending_gate_node_right maps\_anim::anim_first_frame_solo(level.ending_gate_r, "outro_pt1_breach");
  } else {
    var_8 = getEntArray("garage_door_l", "targetname");
    var_9 = getEntArray("garage_door_r", "targetname");
    var_10 = 0.3;

    foreach(var_12 in var_8) {
      var_12 rotateyaw(-130, var_10, 0, 0.2);

      if(var_12.classname == "script_brushmodel") {
        var_12 disconnectpaths();
      }
    }

    foreach(var_12 in var_9) {
      var_12 rotateyaw(130, var_10, 0, 0.2);

      if(var_12.classname == "script_brushmodel") {
        var_12 disconnectpaths();
      }
    }
  }
}

heli_jump_fire_fail() {
  level endon("vignette_ending_player_jumped_flag");
  common_scripts\utility::waittill_any("weapon_fired", "grenade_fire");
  var_0 = [level.ending_opfor_0, level.ending_opfor_1, level.ending_opfor_2, level.allies[0], level.allies[1]];
  level thread maps\_anim::anim_set_rate_single(level.ending_heli, "outro_pt1_heli", 1.4);
  level thread maps\_anim::anim_set_rate(var_0, "outro_pt1_breach", 1.4);
}

final_sequence_fail_condition() {
  level endon("missionfailed");
  level endon("vignette_ending_player_jumped_flag");
  wait 6.0;
  setdvar("ui_deadquote", &"FLOOD_ENDING_JUMP_FAIL");
  level thread maps\_utility::missionfailedwrapper();
}

ending_breach_ally() {
  var_0 = getnode("ending_ally_0_node", "targetname");
  level.allies[0] forceteleport(var_0.origin, var_0.angles, 1024);
  var_0 = getnode("ending_ally_1_node", "targetname");
  level.allies[1] forceteleport(var_0.origin, var_0.angles, 1024);
  level.allies[0] maps\_vignette_util::vignette_actor_ignore_everything();
  level.allies[0].disableplayeradsloscheck = 1;
  level.allies[0] pushplayer(1);
  level.allies[0] maps\_utility::disable_cqbwalk();
  level.allies[0] maps\_utility::enable_heat_behavior();
  level.allies[1] maps\_vignette_util::vignette_actor_ignore_everything();
  level.allies[1].disableplayeradsloscheck = 1;
  level.allies[1] pushplayer(1);
  level.allies[1] maps\_utility::disable_cqbwalk();
  level.allies[1] maps\_utility::enable_heat_behavior();
  wait 0.2;
}

ending_player_reach_final_sequence() {
  self endon("weapon_fired");
  self endon("grenade_fire");

  while(72 < distance(level.player.origin, level.ending_heli gettagorigin("doorHinge_BB_mid"))) {
    wait 0.05;
  }

  common_scripts\utility::flag_set("vignette_ending_player_jumped_flag");
  level.ending_opfor_0 thread maps\_utility::magic_bullet_shield();
  level.ending_opfor_1 thread maps\_utility::magic_bullet_shield();
  level.ending_opfor_2 thread maps\_utility::magic_bullet_shield();
}

ending_player_land_on_heli_effects(var_0) {
  level.player playrumblelooponentity("subtle_tank_rumble");
  wait 0.6;
  stopallrumbles();
  level.player thread maps\flood_util::earthquake_w_fade(0.16, 64);
}

ending_price_gets_capped(var_0) {
  level endon("vignette_ending_qte_success");
  wait 8.5;
  playFXOnTag(level._effect["fx_usp_muzzle_flash"], level.enemy_gun, "tag_flash");
  magicbullet("p226", level.enemy_gun gettagorigin("tag_flash"), (0, 0, 0));
  common_scripts\utility::flag_set("vignette_ending_qte_failure");
}

ending_opfor_kill_pilot() {
  wait 1.0;
  level.ending_opfor_2 shoot(1.0, level.ending_opfor_3.origin);
  wait 0.2;
  level.ending_opfor_2 shoot(1.0, level.ending_opfor_3.origin);
  wait 0.2;
  level.ending_opfor_2 shoot(1.0, level.ending_opfor_3.origin);
}

ending_shake_effects() {
  level.player playrumblelooponentity("subtle_tank_rumble");
  level.player thread maps\flood_util::earthquake_w_fade(0.3, 64, 2.5);
}

ending_player_punch_enemy_rumble(var_0) {
  level.player playrumblelooponentity("subtle_tank_rumble");
  wait 0.6;
  stopallrumbles();
}

ending_player_fade(var_0) {}

ending_player_slowmo_start(var_0) {
  level.player setclienttriggeraudiozone("flood_exfil_02", 0.1);
  setslowmotion(1.0, 0.25, 0.5);
}

ending_player_slowmo_end(var_0) {
  thread maps\flood_audio::sfx_exfil_slomo00();
  setslowmotion(0.25, 1.0, 0.05);
  thread maps\flood_audio::sfx_exfil_slomo01();
}

ending_player_slowmo_boss_shot() {
  thread maps\flood_audio::sfx_boss_shot_begin();
  wait 0.2;
  setslowmotion(1.0, 0.15, 0.05);
  wait 0.25;
  thread maps\flood_audio::sfx_boss_shot_end();
  setslowmotion(0.15, 1.0, 0.5);
}

ending_player_broken_nose(var_0) {
  level.player dodamage(70, level.player.origin, level.ending_hvt);
  thread maps\flood_fx::ending_white_fade(0.02, 0.1, 0.05);
  level.player shellshock("flood_helicopter", 3.0);
  common_scripts\utility::waitframe();
  playFXOnTag(common_scripts\utility::getfx("flood_moving_cabin_dust"), level.ending_heli, "tag_fx_015");
  common_scripts\utility::noself_delaycall(0.2, ::setblur, 0.0, 3.0);
  level.player playrumblelooponentity("subtle_tank_rumble");
  wait 0.6;
  stopallrumbles();
}

ending_player_enemy_broken_nose(var_0) {
  level.ending_opfor_0 detach(level.ending_opfor_0.headmodel);
  level.ending_opfor_0 attach("head_venezuela_army_head_db");
  level.ending_opfor_0.headmodel = "head_venezuela_army_head_db";
  ending_player_take_damage(var_0);
}

ending_player_take_damage(var_0) {
  level.player playrumbleonentity("damage_heavy");
}

ending_player_failed_qte_0(var_0) {
  playFXOnTag(level._effect["fx_usp_muzzle_flash"], level.ending_gun, "tag_flash");
  magicbullet("p226", level.ending_gun gettagorigin("tag_flash"), level.player getEye());
  level.player playrumbleonentity("damage_heavy");
  setdvar("ui_deadquote", "");
  level thread maps\_utility::missionfailedwrapper();
}

ending_player_qte_0_logic() {
  self endon("death");
  self endon("qte_0_fail");
  self waittill("qte_0_start");
  level thread ending_qte_0_prompt_logic();

  while(level.player attackbuttonpressed()) {
    wait 0.05;
  }

  while(!level.player attackbuttonpressed()) {
    wait 0.05;
  }

  self playrumbleonentity("heavygun_fire");
  playFXOnTag(level._effect["vfx_muz_pis_w"], level.ending_gun, "tag_flash");
  self playSound("weap_p226_fire_plr");
  common_scripts\utility::flag_set("vignette_ending_qte_success");
}

ending_qte_0_prompt_logic() {
  ending_create_qte_prompt(&"FLOOD_ENDING_QTE_0_PROMPT");
  wait 0.4;
  ending_fade_qte_prompt(0.1, 1.0);
  common_scripts\utility::flag_wait_or_timeout("vignette_ending_qte_success", 0.933);
  ending_fade_qte_prompt(0.1, 0.0);
  ending_destroy_qte_prompt();
}

ending_player_pickup_logic() {
  wait 1.55;
  ending_create_qte_prompt(&"FLOOD_ENDING_QTE_1_PROMPT", "hud_icon_p226");
  ending_fade_qte_prompt(0.05, 1.0);
  level.can_still_save_price = 1;
  var_0 = 1;

  while(level.can_still_save_price && var_0) {
    var_1 = 0;

    while(self usebuttonpressed()) {
      var_1 = var_1 + 0.05;
      wait 0.05;

      if(0.25 <= var_1) {
        var_0 = 0;
        break;
      }
    }

    wait 0.05;
  }

  ending_fade_qte_prompt(0.05, 0.0);
  ending_destroy_qte_prompt();

  if(level.can_still_save_price) {
    common_scripts\utility::flag_set("vignette_ending_qte_pickup_gun");
  }
}

ending_player_qte_shoot_logic() {
  level.ending_hvt thread ending_player_qte_success_logic();
  level.allies[0] thread ending_player_qte_failure_logic();
}

ending_player_qte_success_logic() {
  level thread ending_player_flashout_heli_crash();
  level endon("hvt_dead");
  thread ending_hvt_handle_damage();
  self waittill("damage");
  common_scripts\utility::flag_set("vignette_ending_qte_success");
}

ending_hvt_handle_damage() {
  self endon("vignette_ending_crash_flag");
  thread ending_hvt_shot_blood_fx("vignette_ending_crash_flag");
  self waittill("damage", var_0, var_1, var_2, var_3);
  thread ending_player_slowmo_boss_shot();
}

ending_hvt_shot_blood_fx(var_0) {
  level endon(var_0);

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    var_9 = common_scripts\utility::spawn_tag_origin();
    var_9.origin = var_4;
    var_9.angles = var_3;
    var_9 linkto(self, var_8, (0, 0, 0), (0, 0, 0));
    playFXOnTag(level._effect["vfx_blood_impact_almagro"], var_9, "tag_origin");
    wait 0.05;
  }
}

ending_player_flashout_heli_crash() {
  common_scripts\utility::flag_wait("vignette_ending_qte_success");
  wait 4.5;
  var_0 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  var_0.foreground = 0;
  wait 0.1;
  var_0.alpha = 0;
  wait 0.13;
  var_0.alpha = 1;
  wait 0.05;
  var_0.alpha = 0;
  wait 0.08;
  var_0.alpha = 1;
  wait 0.03;
  var_0.alpha = 0;
  wait 0.35;
  var_0.alpha = 1;
  common_scripts\utility::flag_wait("vignette_ending_scene_start");
  wait 5.75;
  level thread maps\flood_anim::ending_blur_logic();
  var_0 fadeovertime(5.0);
  var_0.alpha = 0;
}

ending_player_qte_failure_logic() {
  level endon("vignette_ending_qte_success");
  self waittill("damage", var_0, var_1);

  if(var_1 == level.player && !common_scripts\utility::flag("already_failing")) {
    common_scripts\utility::flag_set("already_failing");
    setdvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
    level thread maps\_utility::missionfailedwrapper();
  }
}

ending_player_qte_reach_logic(var_0) {
  ending_create_qte_prompt(&"FLOOD_ENDING_QTE_2_PROMPT");
  level.player thread ending_player_qte_button_smash_logic();
  level.player thread ending_player_qte_show_and_blink_logic();
  wait 1.5;

  for(var_1 = 1; !common_scripts\utility::flag("vignette_ending_qte_grabbed"); level.player.button_smash_count = 0) {
    wait 0.25;

    if(var_1 > level.player.button_smash_count) {
      common_scripts\utility::flag_set("smash_rate_bad");
      continue;
    }

    common_scripts\utility::flag_clear("smash_rate_bad");
  }
}

ending_player_fov_change() {
  var_0 = getdvarint("cg_fov");
  var_1 = var_0;

  while(!common_scripts\utility::flag("vignette_ending_qte_grabbed")) {
    wait 1.0;
    var_1 = var_1 - 2;

    if(!common_scripts\utility::flag("smash_rate_bad")) {
      self lerpfov(var_1, 1.0);
    }
  }

  self lerpfov(var_0, 2.5);
}

ending_player_qte_button_smash_logic() {
  self.button_smash_count = 0;

  while(!common_scripts\utility::flag("vignette_ending_qte_grabbed")) {
    while(!level.player usebuttonpressed()) {
      wait 0.05;
    }

    self.button_smash_count++;

    while(level.player usebuttonpressed()) {
      wait 0.05;
    }
  }
}

ending_player_qte_show_and_blink_logic() {
  common_scripts\utility::flag_wait("smash_rate_bad");
  level thread ending_fade_qte_prompt(0.2, 1.0);
  common_scripts\utility::flag_wait("qte_prompt_solid");
  level thread ending_blink_qte_prompt();
  common_scripts\utility::flag_wait("vignette_ending_qte_grabbed");
  common_scripts\utility::flag_wait("qte_prompt_solid");
  level notify("stop_blink");
  level thread ending_fade_qte_prompt(0.2, 0.0);
}

ending_player_let_go_interaction(var_0) {
  level endon("ending_player_failed");

  if(isDefined(level.console) && level.console) {
    ending_create_qte_prompt(&"FLOOD_ENDING_QTE_4B_PROMPT_TEXT");
  } else {
    ending_create_qte_prompt(&"FLOOD_ENDING_QTE_4_PROMPT_TEXT");
  }

  level thread ending_fade_qte_prompt(0.2, 1.0);
  common_scripts\utility::flag_wait("qte_prompt_solid");

  if(isDefined(level.console) && level.console) {
    while(!level.player buttonpressed("BUTTON_B")) {
      common_scripts\utility::waitframe();
    }
  } else {
    while(!level.player meleebuttonpressed()) {
      common_scripts\utility::waitframe();
    }
  }

  level thread ending_fade_qte_prompt(0.2, 0.0);
  common_scripts\utility::flag_set("ending_let_go");
  thread maps\flood_audio::sfx_let_go();
}

ending_let_go_scene_player_experience() {
  wait 5.0;
  level.player playrumblelooponentity("subtle_tank_rumble");
  wait 4.0;
  stopallrumbles();
  level.player thread maps\flood_util::earthquake_w_fade(0.2, 2, 1, 1);
  level.player playrumbleonentity("damage_light");
  level.player playrumblelooponentity("subtle_tank_rumble");
  wait 2.0;
  stopallrumbles();
  level.player thread maps\flood_util::earthquake_w_fade(0.25, 3, 1, 1);
  level.player playrumbleonentity("damage_heavy");
  level.player playrumblelooponentity("steady_rumble");
  wait 2.0;
  stopallrumbles();
  level.player thread maps\flood_util::earthquake_w_fade(0.3, 64, 1);
  level.player playrumbleonentity("heavy_2s");
  level.player playrumblelooponentity("steady_rumble");
}

ending_create_qte_prompt(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = &"FLOOD_ENDING_QTE_0_PROMPT";
  }

  var_2 = 90;
  var_3 = 35;
  var_4 = 2;
  var_5 = -5;
  var_6 = 90;
  var_7 = [];

  if(var_0 == &"FLOOD_ENDING_QTE_1_PROMPT") {
    var_3 = -3;
    var_2 = 70;
    var_4 = 1.5;
    var_5 = 3;
    var_6 = 95;
  } else if(var_0 == &"FLOOD_ENDING_QTE_3_PROMPT" || var_0 == &"FLOOD_ENDING_QTE_3_PROMPT_PC" || var_0 == &"FLOOD_ENDING_QTE_3_PROMPT_TOGGLE" || var_0 == &"FLOOD_ENDING_QTE_3_PROMPT_TOGGLEADS_THROW")
    var_2 = getdvarfloat("foo");

  var_8 = level.player maps\_hud_util::createclientfontstring("default", var_4);
  var_8.x = var_3 * -1;
  var_8.y = var_2;
  var_8.horzalign = "right";
  var_8.alignx = "right";
  var_8.alignx = "center";
  var_8.aligny = "middle";
  var_8.horzalign = "center";
  var_8.vertalign = "middle";
  var_8.hidewhendead = 1;
  var_8.hidewheninmenu = 1;
  var_8.sort = 205;
  var_8.foreground = 1;
  var_8.alpha = 0;
  var_8 settext(var_0);
  var_7["text"] = var_8;

  if(isDefined(var_1)) {
    var_9 = maps\_hud_util::createicon(var_1, 64, 32);
    var_9.x = var_5;
    var_9.y = var_6;
    var_9.alignx = "center";
    var_9.aligny = "middle";
    var_9.horzalign = "center";
    var_9.vertalign = "middle";
    var_9.hidewhendead = 1;
    var_9.hidewheninmenu = 1;
    var_9.sort = 205;
    var_9.foreground = 1;
    var_9.alpha = 0;
    var_7["icon"] = var_9;
  }

  if(var_0 == &"FLOOD_ENDING_QTE_2_PROMPT") {
    var_8 = level.player maps\_hud_util::createclientfontstring("default", var_4);
    var_8.x = var_3 * -1 + 24;
    var_8.y = var_2 - 2;
    var_8.horzalign = "right";
    var_8.alignx = "left";
    var_8.aligny = "middle";
    var_8.horzalign = "center";
    var_8.vertalign = "middle";
    var_8.hidewhendead = 1;
    var_8.hidewheninmenu = 1;
    var_8.sort = 205;
    var_8.foreground = 1;
    var_8.alpha = 0;
    var_8 settext(&"FLOOD_ENDING_QTE_2_PROMPT_TEXT");
    var_7["text_2"] = var_8;
  }

  level.ending_qte_prompt = var_7;
}

ending_destroy_qte_prompt() {
  if(!isDefined(level.ending_qte_prompt)) {}

  level notify("stop_blink");

  foreach(var_1 in level.ending_qte_prompt) {
    var_1 destroy();
  }

  level.ending_qte_prompt = undefined;
}

ending_fade_qte_prompt(var_0, var_1) {
  if(!isDefined(level.ending_qte_prompt)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = 1.5;
  }

  foreach(var_3 in level.ending_qte_prompt) {
    var_3 fadeovertime(var_0);
    var_3.alpha = var_1;
  }

  if(var_1 > 0.75) {
    wait(var_0);
    common_scripts\utility::flag_set("qte_prompt_solid");
  } else {
    wait(var_0);
    common_scripts\utility::flag_clear("qte_prompt_solid");
  }
}

ending_blink_qte_prompt() {
  level endon("stop_blink");

  if(!isDefined(level.ending_qte_prompt)) {
    return;
  }
  var_0 = level.ending_qte_prompt["text"];

  for(;;) {
    var_0 fadeovertime(0.01);
    var_0.alpha = 1.0;
    var_0 changefontscaleovertime(0.01);
    var_0.fontscale = 2;
    wait 0.1;
    common_scripts\utility::flag_set("qte_prompt_solid");
    var_0 fadeovertime(0.1);
    var_0.alpha = 0.0;
    var_0 changefontscaleovertime(0.1);
    var_0.fontscale = 0.25;
    wait 0.2;
    common_scripts\utility::flag_clear("qte_prompt_solid");
  }
}

ending_player_camera_logic() {
  var_0 = 20;
  self enableslowaim(0.25, 0.325);
  self playerlinktoblend(level.ending_arms, "tag_player", 0.3, 0.1, 0.1);
  wait 0.3;
  self playerlinktodelta(level.ending_arms, "tag_player", 1.0, 0, 0, 0, 0, 1);
  self lerpviewangleclamp(0.5, 0.1, 0.1, var_0, var_0, var_0, var_0);
  common_scripts\utility::flag_wait("vignette_ending_qte_success");
  self lerpviewangleclamp(0.25, 0.4, 0.5, 0, 0, 0, 0);
  level.ending_heli waittill("outro_pt1_garcia_punch");
  self playerlinktodelta(level.ending_arms, "tag_player", 0.92, 0, 0, 0, 0, 1);
  self lerpviewangleclamp(0.5, 0.1, 0.1, var_0, var_0, var_0, var_0);
  common_scripts\utility::flag_wait("vignette_ending_qte_pickup_gun");
  self playerlinktodelta(level.ending_arms, "tag_player", 1, 0, 0, 0, 0, 1);
  self lerpviewangleclamp(0.5, 0.1, 0.1, var_0, var_0, var_0, var_0);
  common_scripts\utility::flag_wait("ending_vo_pt2_start");
  self playerlinktodelta(level.ending_arms, "tag_player", 0.92, 0, 0, 0, 0, 1);
  self springcamenabled(1.0, 3.2, 1.6);
  self lerpviewangleclamp(0.5, 0.1, 0.1, var_0, var_0, var_0, var_0);
}

ending_player_weapon_logic() {
  var_0 = self getweaponslistall();

  foreach(var_2 in var_0) {
    self takeweapon(var_2);
  }

  self giveweapon("p226_flood_ending");
  self switchtoweapon("p226_flood_ending");
  common_scripts\utility::flag_wait("vignette_ending_qte_success");
  common_scripts\utility::flag_waitopen("vignette_ending_qte_success");
  thread ending_player_pickup_logic();
  common_scripts\utility::flag_wait("vignette_ending_qte_pickup_gun");
  var_4 = "outro_pt1_garcia_kill_pt2";
  level.ending_heli thread maps\_anim::anim_single(maps\_utility::make_array(level.ending_arms), var_4, "tag_origin");
  level.ending_heli waittill(var_4);
  level.ending_gun hide();
  self showviewmodel();
  self enableweapons();
  thread ending_player_qte_shoot_logic();
}

ending_qte_catch(var_0) {
  self endon("death");
  thread ending_qte_catch_prompt(var_0);
  level.outro_node endon(var_0);
  common_scripts\utility::flag_wait("ending_qte_catch_active");
  wait 0.05;

  while(!self adsbuttonpressed() || !self attackbuttonpressed()) {
    wait 0.05;
  }

  common_scripts\utility::flag_set("vignette_ending_qte_success");
}

ending_qte_catch_prompt(var_0) {
  var_1 = &"FLOOD_ENDING_QTE_3_PROMPT";

  if(maps\flood_util::game_is_pc()) {
    maps\flood_util::registeractionbinding("ADS", "+speed_throw", &"FLOOD_ENDING_QTE_3_PROMPT_PC");
    maps\flood_util::registeractionbinding("ADS", "+toggleads", &"FLOOD_ENDING_QTE_3_PROMPT_TOGGLE");
    maps\flood_util::registeractionbinding("ADS", "+toggleads_throw", &"FLOOD_ENDING_QTE_3_PROMPT_TOGGLEADS_THROW");
    var_2 = maps\flood_util::getactionbind("ADS");
    var_1 = var_2.hint;
  }

  common_scripts\utility::flag_wait("ending_qte_catch_active");
  ending_create_qte_prompt(var_1);
  level thread ending_fade_qte_prompt(0.1, 1.0);
  level.ending_qte_prompt["text"] thread ending_qte_catch_pulse();
  ending_qte_catch_wait(var_0);
  ending_fade_qte_prompt(0.1, 0.0);
  ending_destroy_qte_prompt();
}

ending_qte_catch_pulse() {
  self endon("death");
  var_0 = 0.15;
  var_1 = 0.3;
  wait 0.1;

  for(;;) {
    self fadeovertime(var_0);
    self.alpha = 0.4;
    wait(var_0);
    self fadeovertime(var_0);
    self.alpha = 1.0;
    wait(var_0);
    wait(var_1);
  }
}

ending_qte_catch_wait(var_0) {
  level endon("vignette_ending_qte_success");
  level.outro_node waittill(var_0);
}

ending_qte_reach() {
  self endon("death");
  level.outro_node endon("outro_pt2_save_vargas");
  level.outro_node endon("outro_pt2_save_vargas_win_01");
  common_scripts\utility::flag_wait("ending_qte_reach_active");
  ending_create_qte_prompt(&"FLOOD_ENDING_QTE_2_PROMPT");
  wait 0.4;
  ending_fade_qte_prompt(0.1, 1.0);

  for(;;) {
    if(self usebuttonpressed()) {
      break;
    }

    wait 0.05;
  }

  common_scripts\utility::flag_set("vignette_ending_qte_success");
  ending_fade_qte_prompt(0.1, 0.0);
  ending_destroy_qte_prompt();
  thread ending_qte_reach();
}

ending_lower_raise_weapon_logic() {
  level endon("vignette_ending_player_jumped_flag");
  var_0 = getent("ending_lower_weapon", "targetname");
  var_0 waittill("trigger");
  self disableweapons();
  var_0 = getent("ending_raise_weapon", "targetname");
  var_0 waittill("trigger");
  self enableweapons();
}

ending_transition() {
  level endon("player_entering_final_area");
  level.player endon("death");
  common_scripts\utility::flag_set("rooftops_done");
  thread ending_heli_callout_vo();
  thread ending_open_doors();
  thread ending_vo_main();
  var_0 = 0;

  for(;;) {
    var_1 = getaiarray("axis");

    if(0 >= var_1.size) {
      break;
    }

    if(3 > var_1.size && !var_0) {
      foreach(var_3 in var_1) {
        var_3.attackeraccuracy = 25;
      }

      maps\_utility::activate_trigger_with_targetname("ending_heli_path");
      var_0 = 1;
    }

    wait 0.05;
  }

  ending_wait_for_vo_window();
  level.allies[1] maps\_utility::smart_dialogue("flood_vrg_wegottagetthrough");
  common_scripts\utility::flag_set("garage_done");
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  level.allies[0] maps\_utility::disable_cqbwalk();
  level.allies[1] maps\_utility::disable_cqbwalk();
  level.allies[2] maps\_utility::disable_cqbwalk();
  common_scripts\utility::flag_wait("ending_vo_push_forward");

  if(!common_scripts\utility::flag("ending_vo_1")) {
    common_scripts\utility::flag_wait("ending_vo_approach");
    level.allies[0] maps\_utility::smart_dialogue("flood_pri_eliasvargasyourewith");
    level.allies[0] maps\_utility::smart_dialogue("flood_pri_merrickcheckforsurvivors");
  }
}

ending_wait_for_vo_window() {
  for(;;) {
    if(isDefined(level.ending_vo_heli_time)) {
      if(200 < gettime() - level.ending_vo_heli_time) {
        break;
      }
    }

    wait 0.2;
  }
}

ending_vo_main() {
  common_scripts\utility::flag_clear("rooftops_vo_push_forward_hassle");
  common_scripts\utility::flag_wait("ending_vo_1");

  if(!common_scripts\utility::flag("garage_done")) {
    level.allies[0] thread maps\_utility::smart_dialogue("flood_pri_wegottoget");
  }

  if(!common_scripts\utility::flag("rooftops_vo_push_forward_hassle")) {
    level.allies[0] thread maps\flood_util::nag_end_on_notify(maps\_utility::make_array("flood_pri_eliasgetthedoor", "flood_pri_openthedoorwell", "flood_pri_weregonnalosegarcia"), "flag_set", 1);
    common_scripts\utility::flag_wait("rooftops_vo_push_forward_hassle");
    level.allies[0] notify("flag_set");
  }

  common_scripts\utility::flag_wait("ending_vo_2");
  level.allies[0] thread maps\_utility::smart_dialogue("flood_pri_jump");
  common_scripts\utility::flag_wait("ending_vo_3");
  wait 0.2;
  level.allies[0] thread maps\_utility::smart_dialogue("flood_pri_getgarcia");
  common_scripts\utility::flag_wait("ending_vo_pt2_start");
  wait 1.4;
  level.allies[1] maps\_utility::smart_dialogue("flood_mrk_everyonegood");
  level waittill("ending_player_success");

  if(common_scripts\utility::flag("ending_let_go")) {
    wait 3.5;
    thread flood_ending_fadeout();
    wait 2.0;
    maps\_utility::smart_radio_dialogue("flood_hsh_sowhatdidyou");
    wait 1.75;
    maps\_utility::smart_radio_dialogue("flood_els_imadethehardest");
    wait 2.0;
    common_scripts\utility::flag_set("ending_done");
  }
}

ending_rush_vo() {
  wait 0.15;
  level.allies[0] thread maps\_utility::smart_dialogue("flood_rke_ruuuuun");
}

flood_ending_fadeout() {
  var_0 = maps\_hud_util::create_client_overlay("black", 0, level.player);
  var_0.foreground = 0;
  var_0 fadeovertime(3.0);
  var_0.alpha = 1;
  wait 2.0;
}

ending_heli_callout_vo() {
  maps\_utility::wait_for_targetname_trigger("ending_heli_path");
  var_0 = getent("ending_heli_path_veh", "targetname");
  level.ending_heli_path = maps\_vehicle::vehicle_spawn(var_0);
  level.ending_heli_path maps\_vehicle::godon();
  level.ending_heli_path thread maps\_vehicle::gopath();
  level.ending_heli_path vehicle_turnengineoff();
  level.ending_heli_path thread maps\flood_audio::sfx_heli_final_passby();
  wait 2.0;
  level.allies[2] maps\_utility::smart_dialogue("flood_mrk_heloinbound");
  wait 1.0;
  level.allies[0] maps\_utility::smart_dialogue("flood_pri_theyrepickingupgarcia");
  level.ending_vo_heli_time = gettime();
  common_scripts\utility::flag_wait("player_entering_final_area");

  if(isDefined(level.ending_heli_path)) {
    level.ending_heli_path delete();
  }
}

ending_open_doors() {
  maps\flood_anim::setup_enemies_open_gate();
  maps\flood_util::waittill_enemy_count_or_trigger(2, "ending_heli_path");
  maps\flood_anim::enemies_open_gate();
}

ending_swing_doors_open() {
  var_0 = getEntArray("garage_door_l", "targetname");
  var_1 = getEntArray("garage_door_r", "targetname");
  var_2 = 0.3;

  foreach(var_4 in var_0) {
    if(var_4.classname == "script_brushmodel") {
      var_4 connectpaths();
    }
  }

  foreach(var_4 in var_1) {
    if(var_4.classname == "script_brushmodel") {
      var_4 connectpaths();
    }
  }

  getnode("ending_trouble_node", "targetname") disconnectnode();
}

ending_temp_ignore() {
  self endon("death");
  self.ignoreall = 1;
  common_scripts\utility::flag_wait("ending_gate_open");
  self setgoalvolumeauto(getent("ending_golvolume", "targetname"));
  wait 1.2;
  self.ignoreall = 0;
}

ending_remove_gate_keepers() {
  self endon("death");
  common_scripts\utility::flag_wait("vignette_ending_doorbreach_flag");
  self delete();
}