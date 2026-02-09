/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ship_graveyard_new_trench.gsc
**********************************************/

main() {
  setsaveddvar("bg_viewKickMax", 30);
  setsaveddvar("ammoCounterHide", 1);
  level.baker thread maps\ship_graveyard_util::dyn_swimspeed_disable();
  level.player disableweapons();
  level.player thread maps\_utility::vision_set_fog_changes("shpg_start_chasm_lessfog", 0.05);
  level.killfirm_suffix = "_loud";
  setsaveddvar("player_swimSpeed", 80);
  setsaveddvar("player_sprintUnlimited", "1");
  maps\ship_graveyard_stealth::stealth_disable();
  level.baker.goalradius = 64;
  level.baker.pathrandompercent = 0;
  level.stealth_ally_accu = 1;
  level.baker.baseaccuracy = level.stealth_ally_accu;
  maps\ship_graveyard_util::set_start_positions("new_trench");
  maps\_utility::autosave_by_name_silent("drown");
  maps\ship_graveyard_util::baker_glint_off();
  thread trench_drowning();
  thread trench_things_crashing();
  thread trench_light_flicker();
}

trench_intel_drop() {
  common_scripts\utility::flag_wait("start_new_canyon");
  var_0 = getent("intelligence_item", "targetname");
  var_1 = getent(var_0.target, "targetname");
  var_2 = 800;
  var_3 = 185;
  var_4 = 20;
  var_1.old_org = var_1.origin;
  var_1.old_ang = var_1.angles;
  var_0.origin = var_0.origin + (0, 0, -1 * var_2);
  var_1.origin = var_1.origin + (0, 0, var_2);
  var_1.angles = var_1.angles + (var_3, var_3, var_3);
  var_1 moveto(var_1.old_org, var_4);
  var_1 rotateto(var_1.old_ang, var_4);
  var_1 waittill("movedone");
  var_0.origin = var_0.origin + (0, 0, var_2);
}

trench_light_flicker() {
  level endon("start_new_canyon");
  var_0 = common_scripts\utility::get_target_ent("new_trench_drown_light");
  var_1 = var_0 getlightintensity();

  for(;;) {
    var_2 = randomfloatrange(var_1 * 0.7, var_1 * 1.2);
    var_0 setlightintensity(var_2);
    wait 0.05;
  }
}

canyon_main() {
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("bg_viewKickMax", 20);
  level.killfirm_suffix = "_loud";
  common_scripts\utility::flag_set("allow_killfirms");
  level.baker.pathrandompercent = 50;
  level.baker thread maps\ship_graveyard_util::dyn_swimspeed_disable();
  level.baker.moveplaybackrate = 1.25;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  thread start_canyon_combat();
  thread hit_player_when_flag();
  thread trench_intel_drop();
}

trench_drowning() {
  var_0 = getDvar("g_friendlyNameDist");
  setsaveddvar("g_friendlyNameDist", 0);
  var_1 = common_scripts\utility::get_target_ent("new_trench_first_crash");
  var_1 delete();
  level.ro_index = 0;
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player notify("stop_scuba_breathe");
  level.player thread maps\_swim_player::shellshock_forever();
  var_2 = maps\_utility::spawn_anim_model("crash_chopper");
  level.baker.animname = "generic";
  var_3 = common_scripts\utility::get_target_ent("trench_bottom_boat");
  var_4 = getEntArray("trench_bottom_boat_attach", "targetname");
  common_scripts\utility::array_call(var_4, ::linkto, var_3);
  var_5 = maps\_utility::spawn_anim_model("trench_boat");
  var_6 = maps\_utility::spawn_anim_model("debris");
  var_7 = maps\_utility::spawn_anim_model("breather_hose");
  var_8 = (0, 0, 48);
  var_9 = maps\_player_rig::get_player_rig();
  var_9.origin = level.player.origin - var_8;
  var_9.angles = level.player.angles;
  var_10 = common_scripts\utility::spawn_tag_origin();
  var_10.origin = var_9.origin;
  var_10.angles = var_9.angles;
  var_10 linkto(var_9, "tag_player", var_8, (0, 0, 0));
  level.player playerlinktoabsolute(var_10, "tag_origin");
  var_11 = [var_9, var_2, level.baker, var_5, var_7, var_6];
  var_12 = common_scripts\utility::get_target_ent("new_trench_anim_node");
  var_12 maps\_anim::anim_first_frame(var_11, "trench_drown");
  wait 0.5;
  level notify("stop_sun_movement");
  resetsundirection();
  level.f_min["gasmask_overlay"] = 0.7;
  level.f_max["gasmask_overlay"] = 0.9;
  level.player.breathing_overlay["gasmask_overlay"].alpha = 0.9;
  var_3 linkto(var_5);
  common_scripts\utility::exploder("lcs_collapsing");
  wait 2;
  common_scripts\utility::exploder("dead_bodies_underwater");
  common_scripts\utility::exploder("lcs_collapsing");
  thread drowning_hudfx();
  var_7 thread hose_fx();
  var_7 thread maps\_utility::play_sound_on_tag("scn_shipg_rescue_hose", "tag_fx");
  thread drowning_dialogue();
  var_2 thread chopper_fx();
  var_2 hide();
  level.f_min["halo_overlay_scuba_steam"] = 0.7;
  level.f_max["halo_overlay_scuba_steam"] = 0.9;
  level.player.breathing_overlay["halo_overlay_scuba_steam"].alpha = 0.9;
  maps\_utility::delaythread(14, ::player_gives_up);
  thread rig_fx(var_9);
  thread rebreather_plug_in();
  thread unlink_player(var_12, var_9, var_7, var_5);
  thread unlink_baker();
  thread lcs_back();
  thread drowning_dof(var_10, var_9);
  var_13 = common_scripts\utility::get_target_ent("first_cheap_object");
  var_13.origin = var_13.origin + (0, 0, 500);
  var_13 maps\_utility::delaythread(22.5, ::generate_cheap_falling_object, 217, 50);
  level.baker maps\_utility::disable_exits();
  var_12 maps\_anim::anim_single(var_11, "trench_drown");
  wait 0.2;
  level.baker maps\_utility::enable_exits();
  var_10 delete();
  setsaveddvar("g_friendlyNameDist", var_0);
}

rescue_scene_sfx() {
  wait 8.266;
  level.player playSound("scn_shipg_rescue_hand");
  wait 9.3;
  level.player playSound("scn_shipg_rescue_helmet");
  wait 2.634;
  level.player playSound("scn_shipg_rescue_heave");
  wait 10.166;
  level.player playSound("scn_shipg_rescue_heli");
  wait 3.734;
  level.player playSound("scn_shipg_rescue_hitback");
}

drowning_dof(var_0, var_1) {
  wait 7.25;
  common_scripts\utility::flag_set("pause_dynamic_dof");
  maps\_art::dof_enable_script(0, 0, 10, 30, 60, 1.5, 1);
  common_scripts\utility::flag_wait("drown_rebreather_plugin");
  wait 4.5;
  maps\_art::dof_enable_script(0, 0, 10, 450, 750, 1.5, 3.5);
  common_scripts\utility::flag_wait("drown_debris_impact");
  var_1 hide();
  level.player enableslowaim(0.5, 0.5);
  level.player allowsprint(0);
  setsaveddvar("player_swimSpeed", 15);
  setsaveddvar("player_swimVerticalSpeed", 15);
  wait 0.5;
  maps\_art::dof_enable_script(0, 0, 10, 450, 750, 3, 2.5);
  common_scripts\utility::flag_wait("drown_chopper_i1");
  var_1 show();
  level.player disableslowaim();
  level.player allowsprint(1);
  level.player playerlinktoblend(var_0, "tag_origin", 0.5, 0, 0);
  wait 0.05;
  maps\_art::dof_enable_script(0, 150, 10, 1100, 5000, 5, 0.5);
  common_scripts\utility::flag_wait("drown_chopper_i2");
  maps\_art::dof_disable_script(1);
  wait 1;
  common_scripts\utility::flag_clear("pause_dynamic_dof");
}

drowning_dialogue() {
  level.player endon("death");
  level.baker waittillmatch("single anim", "shipg_bkr_rookrook");
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_rookrook_new");
  level.baker waittillmatch("single anim", "shipg_bkr_cmonstaywithme");
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_cmonstaywithme_new");
  level.baker waittillmatch("single anim", "shipg_bkr_alrightletsgetthis");
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_alrightletsgetthis_new");
  level.f_min["gasmask_overlay"] = 0.3;
  level.f_max["gasmask_overlay"] = 0.95;
  level.baker waittillmatch("single anim", "shipg_bkr_grunt");
  thread maps\_utility::smart_radio_dialogue_overlap("shipg_bkr_grunt_new");
  maps\_utility::delaythread(7.5, maps\_utility::smart_radio_dialogue_overlap, "shipg_bkr_youok");
  level.baker waittillmatch("single anim", "shipg_bkr_whatthe");
  thread maps\_utility::smart_radio_dialogue_overlap("shipg_bkr_whatthe_new");
  level.baker waittillmatch("single anim", "shipg_bkr_move_2");
  thread maps\_utility::smart_radio_dialogue_overlap("shipg_bkr_move_2_new");
}

drowning_hudfx() {
  wait 2;
  thread maps\_hud_util::fade_in(5.5);
  level.player setblurforplayer(0, 6);
  wait 4.5;
  thread mash_to_survive();
}

mash_to_survive() {
  wait 2;
  fade_in_x_hint(2);
  thread x_hint_blinks();
  thread increase_difficulty();
  level endon("drown_rebreather_plugin");
  level.player endon("death");
  level.fade_out_death_time = 2.5;
  level.occumulator = 0;
  level.drown_max_alpha = 0;

  for(;;) {
    fade_out_death();
    wait 0.05;
  }
}

increase_difficulty() {
  level waittill("player_hit_x");
}

fade_out_death() {
  thread wait_for_x_input();
  level endon("player_hit_x");
  thread maps\_hud_util::fade_out(level.fade_out_death_time);
  var_0 = max(0, level.fade_out_death_time - 1.75);
  var_1 = level.fade_out_death_time - var_0;
  wait(var_0);
  level.occumulator = 0;
  wait(var_1);
  level.player.overlay["black"].foreground = 0;
  fade_out_x_hint(0.25);
  maps\ship_graveyard_util::force_deathquote(&"SHIP_GRAVEYARD_HINT_DROWN");
  level.player kill();
}

wait_for_x_input() {
  level.player endon("death");
  level endon("drown_rebreather_plugin");

  while(use_pressed())
    wait 0.05;

  while(!use_pressed())
    wait 0.05;

  level notify("player_hit_x");
  thread fade_in_to_alpha(0.1, level.drown_max_alpha);
  earthquake(0.25, 0.2, level.player.origin, 512);
  level.player playrumbleonentity("damage_light");
  level.occumulator = level.occumulator + 1;
}

fade_in_to_alpha(var_0, var_1) {
  if(level.missionfailed) {
    return;
  }
  var_2 = maps\_hud_util::get_optional_overlay("black");
  var_2 fadeovertime(var_0);
  var_2.alpha = var_1;
  wait(var_0);
}

fade_in_x_hint(var_0) {
  if(maps\ship_graveyard_util::greenlight_check()) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = 1.5;

  if(!isDefined(level.x_hint))
    draw_x_hint();

  foreach(var_2 in level.x_hint) {
    var_2 fadeovertime(var_0);
    var_2.alpha = 0.95;
  }
}

draw_x_hint() {
  var_0 = 125;
  var_1 = 0;
  var_2 = level.player maps\_hud_util::createclientfontstring("default", 2);
  var_2.x = var_1 * -1;
  var_2.y = var_0;
  var_2.horzalign = "right";
  var_2.alignx = "right";
  var_2 set_default_hud_stuff();
  var_2 settext(&"SHIP_GRAVEYARD_HINT_RT");
  var_3 = [];
  var_3["text"] = var_2;
  level.x_hint = var_3;
}

x_hint_blinks() {
  if(maps\ship_graveyard_util::greenlight_check()) {
    return;
  }
  level notify("fade_out_x_hint");
  level endon("fade_out_x_hint");

  if(!isDefined(level.x_hint))
    draw_x_hint();

  var_0 = 0.6;
  var_1 = 0.2;

  foreach(var_3 in level.x_hint) {
    var_3 fadeovertime(0.1);
    var_3.alpha = 0.95;
  }

  wait 0.1;
  var_5 = level.x_hint["text"];
  var_6 = 3;

  for(;;) {
    var_5 fadeovertime(0.01);
    var_5.alpha = 0.95;
    var_5 changefontscaleovertime(0.01);

    if(!level.console && !level.player usinggamepad())
      var_5.fontscale = 2;
    else
      var_5.fontscale = 2 * var_6;

    wait 0.18;
    var_5 fadeovertime(var_0);
    var_5.alpha = 0.0;
    var_5 changefontscaleovertime(var_0);

    if(!level.console && !level.player usinggamepad())
      var_5.fontscale = 0.25;
    else
      var_5.fontscale = 0.25 * var_6;

    wait(var_1);
    var_7 = 4;

    while(isDefined(level.occumulator)) {
      if(level.occumulator < var_7) {
        break;
      }

      foreach(var_3 in level.x_hint)
      var_3.alpha = 0;

      var_0 = 0.3;
      var_1 = 0.1;
      wait 0.05;
    }
  }
}

fade_out_x_hint(var_0) {
  level notify("fade_out_x_hint");

  if(!isDefined(var_0))
    var_0 = 1.5;

  if(!isDefined(level.x_hint))
    draw_x_hint();

  foreach(var_2 in level.x_hint) {
    var_2 fadeovertime(var_0);
    var_2.alpha = 0;
  }
}

set_default_hud_stuff() {
  self.alignx = "center";
  self.aligny = "middle";
  self.horzalign = "center";
  self.vertalign = "middle";
  self.hidewhendead = 1;
  self.hidewheninmenu = 1;
  self.sort = 205;
  self.foreground = 1;
  self.alpha = 0;
}

use_pressed() {
  return level.player attackbuttonpressed();
}

player_gives_up() {
  level notify("stop_drowning");
  level.fade_out_death_time = 1;
  level.drown_max_alpha = 0.5;
}

lcs_back_bubbles() {
  maps\_utility::script_delay();
  playFXOnTag(common_scripts\utility::getfx(self.script_fxid), self, "Tag_origin");
  self waittill("stopfx");
  maps\_utility::script_delay();
  stopFXOnTag(common_scripts\utility::getfx(self.script_fxid), self, "Tag_origin");
  maps\_utility::script_delay();
  self delete();
}

lcs_back() {
  var_0 = common_scripts\utility::get_target_ent("first_lcs_crash");
  var_1 = var_0 common_scripts\utility::get_linked_ents();
  var_0 hide();
  var_2 = var_0 common_scripts\utility::spawn_tag_origin();
  var_2 linkto(var_0);
  var_3 = [];
  var_4 = maps\_utility::getstructarray_delete("lcs_back_bubble_fx", "targetname");
  var_5 = 0.0;

  foreach(var_7 in var_4) {
    var_8 = common_scripts\utility::spawn_tag_origin();
    var_8.origin = var_7.origin;
    var_8.angles = var_7.angles;
    var_8.script_fxid = var_7.script_fxid;
    var_8.script_delay = var_5;
    var_5 = var_5 + 0.2;
    var_3 = common_scripts\utility::array_add(var_3, var_8);
    var_8 linkto(var_0);
  }

  common_scripts\utility::flag_wait("drown_drop_lcs");
  common_scripts\utility::array_thread(var_3, ::lcs_back_bubbles);
  wait 1;
  var_0 thread maps\_utility::play_sound_on_entity("scn_shipg_lcs_back_fall");
  var_0 thread crash_model_go(var_1);
  common_scripts\utility::array_thread(var_1, ::lcs_back_damage);
  var_10 = common_scripts\utility::get_target_ent("lcs_back_crash_vol");
  var_10 thread lcs_back_damage();
  var_11 = var_0 common_scripts\utility::get_target_ent();
  var_0 common_scripts\utility::delaycall(0.5, ::rotateto, var_11.angles, 6, 0, 6);
  wait 3.5;
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_timetogo");
  common_scripts\utility::flag_set("trench_allow_things_to_crash");
  common_scripts\utility::flag_set("start_base_alarm");
  level.player thread maps\_utility::vision_set_fog_changes("", 4);
  wait 1;
  common_scripts\utility::array_thread(var_3, maps\_utility::send_notify, "stopfx");
  maps\_utility::music_play("mus_shipgrave_trenchrun_battle");
  wait 2;
  var_2 delete();
}

lcs_back_damage() {
  self waittill("stop_damage");
  var_0 = common_scripts\utility::get_target_ent("lcs_back_crash_vol");

  if(var_0 != self)
    var_0 notify("stop_damage");

  if(level.player istouching(self))
    player_smash_death();
}

rebreather_plug_in() {
  wait 4;
  thread scn_rescue_shockfile_thread();
  level.player lerpfov(50, 10);
  common_scripts\utility::flag_wait("drown_rebreather_plugin");
  thread fade_out_x_hint(0.25);
  level.player lerpfov(65, 0.6);
  level notify("stop_shellshock");
  level.player thread maps\_utility::play_sound_on_entity("shipg_player_better_breath");
  level.player.playerfxorg = spawn("script_model", level.player.origin + (0, 0, 0));
  level.player.playerfxorg setModel("tag_origin");
  level.player maps\_utility::delaythread(0.1, maps\ship_graveyard_util::player_panic_bubbles);
  thread maps\_hud_util::fade_in(0.1);
  level.player.playerfxorg.angles = level.player getplayerangles();
  level.player.playerfxorg.origin = level.player getEye() - (0, 0, 10);
  level.player.playerfxorg linktoplayerview(level.player, "tag_origin", (5, 0, -55), (0, 0, 0), 1);
  playFXOnTag(common_scripts\utility::getfx("scuba_bubbles"), level.player.playerfxorg, "TAG_ORIGIN");
  wait 0.25;
  thread maps\_hud_util::fade_out(3);
  level.f_min["gasmask_overlay"] = 0.1;
  level.f_max["gasmask_overlay"] = 0.2;
  wait 0.5;
  maps\_hud_util::fade_in(1);
  level.f_min["halo_overlay_scuba_steam"] = 0.4;
  level.f_max["halo_overlay_scuba_steam"] = 0.6;
  wait 0.5;
  level.player.playerfxorg delete();
  wait 0.1;
  level.player thread maps\_underwater::player_scuba();
  wait 0.1;
  level.player thread maps\_swim_player::flashlight();
}

scn_rescue_shockfile_thread() {
  wait 10;
  level.player shellshock("shipg_player_drown", 5);
}

rig_fx(var_0) {
  wait 10.66;
  var_1 = var_0 gettagorigin("j_wrist_ri");
  playFX(common_scripts\utility::getfx("player_arm_blood"), var_1, (0, 0, 1), (1, 0, 0));
}

unlink_player(var_0, var_1, var_2, var_3) {
  setsaveddvar("sv_znear", "1");
  common_scripts\utility::flag_wait("drown_hand_sound");
  var_1 thread maps\_utility::play_sound_on_tag("scn_shipg_rescue_hand", "j_wrist_ri");
  common_scripts\utility::flag_init("drown_player_triggered_unlink");
  level.player freezecontrols(0);
  common_scripts\utility::flag_wait("drown_debris_impact");
  level.player playSound("scn_shipg_rescue_metal_drop");
  common_scripts\utility::exploder(49);
  common_scripts\utility::flag_wait("drown_player_impact");
  earthquake(0.4, 0.5, level.player.origin, 512);
  level.player playrumbleonentity("damage_heavy");
  common_scripts\utility::flag_wait("drown_pre_unlink_player");
  setsaveddvar("sv_znear", "4");
  level.player enableweapons();
  thread unlink_on_stick();
  common_scripts\utility::flag_wait_either("drown_unlink_player", "drown_player_triggered_unlink");
  thread trench_smash_death();
  thread trench_stay_close_1();
  thread trench_stay_close_2();
  level.player unlink();
  thread deathquote_on_death();
  setsaveddvar("player_swimSpeed", 80);
  setsaveddvar("player_swimVerticalSpeed", 80);
  level.f_min["gasmask_overlay"] = 0.3;
  level.f_max["gasmask_overlay"] = 0.95;
  var_1 hide();
  var_2 hide();
  var_3 hide();
  maps\_utility::autosave_by_name("trench");
  common_scripts\utility::flag_wait("drown_unlink_player");
  var_1 delete();
  var_2 delete();
  var_3 delete();
  level.player clearclienttriggeraudiozone(1.0);
  thread trench_run_dialogue();
  thread random_trench_falling();
}

unlink_on_stick() {
  level endon("drown_unlink_player");

  while(distance(level.player getnormalizedmovement(), (0, 0, 0)) < 0.3)
    wait 0.05;

  common_scripts\utility::flag_set("drown_player_triggered_unlink");
}

unlink_baker() {
  level.baker.goalradius = 128;
  level.baker.moveplaybackrate = 1.2;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  level.baker thread maps\ship_graveyard_util::dyn_swimspeed_enable(500);
  level.baker thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("new_trench_baker_path"), 0);
}

chopper_fx() {
  common_scripts\utility::flag_wait("drown_chopper_start");
  self show();
  playFXOnTag(common_scripts\utility::getfx("ship_wreckage_spark_underwater"), self, "tag_fire");
  playFXOnTag(common_scripts\utility::getfx("ship_wreckage_spark_underwater"), self, "main_rotor");
  common_scripts\utility::flag_wait("drown_chopper_i1");
  wait 0.1;
  common_scripts\utility::exploder(51);
  earthquake(0.5, 0.7, self.origin, 2000);
  common_scripts\utility::flag_wait("drown_chopper_i2");
  earthquake(0.7, 1.5, self.origin, 3000);
  common_scripts\utility::exploder(52);
  player_shake(100);
  level.player playrumbleonentity("damage_light");
  level.player common_scripts\utility::delaycall(0.25, ::playrumbleonentity, "damage_heavy");
  common_scripts\utility::flag_wait("drown_chopper_i3");
  level.player playrumbleonentity("damage_heavy");
  common_scripts\utility::exploder(53);
  wait 4;
  stopFXOnTag(common_scripts\utility::getfx("ship_wreckage_spark_underwater"), self, "tag_fire");
  wait 0.1;
  stopFXOnTag(common_scripts\utility::getfx("ship_wreckage_spark_underwater"), self, "main_rotor");
}

hose_fx() {
  playFXOnTag(common_scripts\utility::getfx("rebreather_hose_bubbles"), self, "TAG_FX");
  common_scripts\utility::flag_wait("drown_rebreather_plugin");
  stopFXOnTag(common_scripts\utility::getfx("rebreather_hose_bubbles"), self, "TAG_FX");
}

trench_wakeup() {
  var_0 = getdvarint("trench_drown", 1);

  if(var_0) {
    thread trench_drowning();
    return;
  }

  common_scripts\utility::flag_set("trench_allow_things_to_crash");
  level.player freezecontrols(1);
  level.player disableweapons();
  common_scripts\utility::waitframe();
  var_1 = common_scripts\utility::getstructarray("new_trench", "targetname");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(var_4.script_noteworthy == "player") {
      var_2 = var_4;
      break;
    }
  }

  var_6 = var_2 common_scripts\utility::spawn_tag_origin();
  level.player playerlinktoabsolute(var_6, "tag_origin");
  level.baker.moveplaybackrate = 1.15;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  level.baker thread maps\ship_graveyard_util::dyn_swimspeed_enable(300);
  level.player thread maps\_swim_player::shellshock_forever();
  wait 1;
  level.player playerlinktodelta(var_6, "tag_origin", 1, 40, 40, 40, 40);
  var_7 = common_scripts\utility::get_target_ent("new_trench_first_crash");
  var_8 = var_7 common_scripts\utility::get_linked_ents();
  var_7 thread crash_model_go(var_8);
  wait 3;
  common_scripts\utility::flag_set("start_base_alarm");
  thread maps\_hud_util::fade_in(5);
  wait 2;
  level notify("player_wakeup");
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_wakeup");
  level notify("stop_shellshock");
  common_scripts\utility::flag_wait("new_trench_first_crash");
  level.player freezecontrols(0);
  trench_death_warning();
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_pain2");
  wait 2.75;
  level.baker thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("new_trench_baker_path"), 0);
  level.player freezecontrols(0);
  level.player enableweapons();
  maps\_utility::autosave_by_name("trench");
  thread trench_run_dialogue();
  thread random_trench_falling();
  wait 0.25;
  level.player unlink();
  var_6 delete();
}

deathquote_on_death() {
  level endon("start_new_canyon");
  level.player waittill("death");
  var_0 = getdvarint("shpg_trench_times_died", 0);
  setDvar("shpg_trench_times_died", var_0 + 1);
  maps\ship_graveyard_util::force_deathquote(&"SHIP_GRAVEYARD_HINT_TRENCH");
}

trench_sprint_hint() {
  wait 0.75;
  var_0 = getdvarint("shpg_trench_times_died", 0);

  if(var_0 > 1 || level.gameskill == 0)
    thread maps\_utility::display_hint("hint_sprint");
}

trench_run_dialogue() {
  level.baker maps\_utility::disable_pain();
  thread trench_sprint_hint();
  wait 1.12;
  maps\_utility::smart_radio_dialogue("shipg_bkr_clearedforphase2");
  wait 1.27;
  maps\_utility::smart_radio_dialogue("shipg_orb_quiteastir");
  wait 0.96;
  maps\_utility::smart_radio_dialogue("shipg_bkr_handleourselves2");
  wait 3.25;
  level.baker maps\_utility::enable_pain();

  if(maps\ship_graveyard_util::greenlight_check() && level.start_point == "e3") {
    return;
  }
  common_scripts\utility::flag_wait("new_canyon_combat_start");
  wait 4;
  maps\_utility::smart_radio_dialogue("shipg_hsh_morediverstakeem");
  wait 5;
  maps\_utility::smart_radio_dialogue("shipg_bkr_movethisway");
}

fake_shellshock_sound() {
  level.player thread common_scripts\utility::play_loop_sound_on_entity("scn_shipg_drowning_loop");
  level waittill("stop_shellshock");
  level.player maps\_utility::delaythread(0.5, common_scripts\utility::stop_loop_sound_on_entity, "scn_shipg_drowning_loop");
  level.player maps\_utility::play_sound_on_entity("scn_shipg_drowning_end");
}

trench_things_crashing() {
  thread trench_lcs_crashing();
  common_scripts\utility::array_thread(getEntArray("crashing_trigger", "targetname"), ::crash_trigger_think);
  var_0 = common_scripts\utility::get_target_ent("trench_cars_node");
  var_1 = maps\_utility::spawn_anim_model("cars");
  var_2 = getEntArray("trench_crashing_cars", "targetname");
  var_0 thread maps\_anim::anim_first_frame([var_1], "car_crash");
  wait 0.1;

  foreach(var_4 in var_2) {
    var_4 linkto(var_1, "tag_" + var_4.script_parameters);
    wait 0.1;
    var_5 = var_4 common_scripts\utility::get_linked_ents();
    common_scripts\utility::array_thread(var_5, ::trigger_enablelinkto);
    common_scripts\utility::array_call(var_5, ::linkto, var_4);
    common_scripts\utility::array_thread(var_5, ::crash_model_damage);
  }

  var_1 hide();
  maps\_utility::trigger_wait_targetname("car_crashing_trigger");
  var_0 thread maps\_anim::anim_single([var_1], "car_crash");
  var_7 = var_1 gettagorigin("tag_car0");
  var_1 thread maps\_utility::play_sound_on_tag("scn_shipg_car_fall", "tag_car0");
  wait 2.2;
  playFXOnTag(common_scripts\utility::getfx("falling_car_bubbles"), var_1, "tag_car0");
  thread common_scripts\utility::play_sound_in_space("scn_shipg_car_fall_debris", var_7);
  var_0 waittill("car_crash");
  var_1 delete();
}

trench_lcs_crashing() {
  var_0 = common_scripts\utility::get_target_ent("trench_cars_node");
  var_1 = common_scripts\utility::get_target_ent("lcs_crashing_animated");
  var_1.animname = "lcs";
  var_1 maps\_anim::setanimtree();
  var_1 hide();
  var_2 = common_scripts\utility::get_target_ent("barge_crashing_animated");
  var_2.animname = "barge";
  var_2 maps\_anim::setanimtree();
  var_3 = var_1 common_scripts\utility::get_linked_ents();
  common_scripts\utility::array_call(var_3, ::linkto, var_1, "j_front");
  var_4 = var_1 common_scripts\utility::spawn_tag_origin();
  var_4 linkto(var_1, "j_front");
  wait 0.1;
  var_0 thread maps\_anim::anim_first_frame([var_1, var_2], "lcs_crash");
  common_scripts\utility::flag_wait("trench_lcs_crash");
  var_1 show();
  var_0 thread maps\_anim::anim_single([var_1, var_2], "lcs_crash");
  playFXOnTag(common_scripts\utility::getfx("lcs_front_lights"), var_4, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("lcs_front_bubbles"), var_4, "tag_origin");
  var_1 thread maps\_utility::play_sound_on_entity("scn_shipg_lcs_fall");
  common_scripts\utility::flag_wait("trench_lcs_hit_ground");
  common_scripts\utility::exploder(60);
  common_scripts\utility::flag_wait("trench_lcs_hit_barge");
  wait 0.5;

  for(var_5 = 0; var_5 < 5; var_5++) {
    var_6 = getglass("barge_glass_" + var_5);
    destroyglass(var_6, (0, 0, -1));
    wait(randomfloatrange(0.05, 0.15));
  }

  common_scripts\utility::flag_wait("start_new_canyon");
  stopFXOnTag(common_scripts\utility::getfx("lcs_front_lights"), var_4, "Tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("lcs_front_bubbles"), var_4, "tag_origin");
  var_4 delete();
}

crash_trigger_think() {
  var_0 = getEntArray(self.target, "targetname");
  common_scripts\utility::array_thread(var_0, ::crash_model_think);
  common_scripts\utility::flag_wait("trench_allow_things_to_crash");
  self waittill("trigger");
  common_scripts\utility::array_thread(var_0, maps\_utility::send_notify, "trigger");
}

crash_model_think() {
  var_0 = self;
  var_0 hide();
  var_1 = var_0 common_scripts\utility::get_linked_ents();
  common_scripts\utility::array_call(var_1, ::hide);
  var_0 waittill("trigger");
  var_0 crash_model_go(var_1);
}

crash_model_go(var_0) {
  var_1 = self;
  var_1 show();
  common_scripts\utility::array_call(var_0, ::show);
  common_scripts\utility::array_thread(var_0, ::trigger_enablelinkto);
  common_scripts\utility::array_call(var_0, ::linkto, var_1);
  common_scripts\utility::array_thread(var_0, ::crash_model_damage, var_1);
  var_2 = 20;
  var_3 = 0;
  var_4 = 0;
  var_5 = var_1 common_scripts\utility::get_target_ent();
  var_6 = 0;
  var_7 = [];

  if(isDefined(var_1.script_soundalias))
    var_1 thread maps\_utility::play_sound_on_entity(var_1.script_soundalias);

  var_8 = undefined;
  var_9 = undefined;
  var_10 = 0;
  var_11 = undefined;
  var_12 = 0;

  if(var_1.model == "shpg_machinery_baggage_container_dmg") {
    var_1.fxorg = var_1;
    var_8 = "falling_box_bubbles";
    var_9 = "tag_origin";
    var_10 = 1;
    var_12 = 1;
  } else if(var_1.model == "vehicle_mi24p_hind_plaza_body_destroy_animated") {
    var_11 = common_scripts\utility::spawn_tag_origin();
    var_11 linkto(var_1, "tag_origin", (28, 152, -48), (0, 0, 0));
    playFXOnTag(common_scripts\utility::getfx("ship_wreckage_spark_underwater"), var_11, "tag_origin");
    var_8 = "falling_box_bubbles";
    var_9 = "tag_origin";
    var_10 = 1;
  } else if(var_1.model == "com_boat_fishing_1") {
    self.fxorg = var_1 common_scripts\utility::spawn_tag_origin();
    self.fxorg linkto(var_1);
    var_8 = "falling_box_bubbles";
    var_9 = "tag_origin";
    var_10 = 1;
  }

  if(var_10)
    playFXOnTag(common_scripts\utility::getfx(var_8), var_1.fxorg, var_9);

  while(isDefined(var_5)) {
    if(isDefined(var_5.speed))
      var_2 = var_5.speed;

    if(isDefined(var_5.script_accel))
      var_3 = var_5.script_accel;

    if(isDefined(var_5.script_decel))
      var_4 = var_5.script_decel;

    if(isDefined(var_5.script_fxid)) {
      if(var_5.script_fxid == "boat_fall_impact_wreck")
        var_5 thread play_boat_crash_fx_early(var_7, var_1);
    }

    var_1 maps\ship_graveyard_util::moveto_rotateto_speed(var_5, var_2, var_3, var_4);
    var_13 = distance(level.player.origin, var_1.origin);

    if(isDefined(var_5.script_flag_set))
      common_scripts\utility::flag_set(var_5.script_flag_set);

    if(isDefined(var_5.script_earthquake))
      thread common_scripts\utility::do_earthquake(var_5.script_earthquake, var_1.origin);

    if(isDefined(var_5.script_soundalias))
      var_1 thread maps\_utility::play_sound_on_entity(var_5.script_soundalias);

    if(isDefined(var_5.script_fxid)) {
      if(var_5.script_fxid != "boat_fall_impact_wreck") {
        var_14 = -1 * anglestoup(var_1.angles);

        if(vectordot((0, 0, -1), var_14) < 0.2)
          var_14 = (0, 0, -1);

        var_15 = bulletTrace(var_1.origin, var_1.origin + var_14 * 500, 0, var_1);
        var_16 = common_scripts\utility::spawn_tag_origin();
        var_16.origin = var_15["position"];
        var_16.angles = var_1.angles;
        var_16 linkto(var_1);
        playFX(common_scripts\utility::getfx(var_5.script_fxid), var_16.origin, (0, 0, 1), var_16.origin - level.player.origin);
        var_7[var_7.size] = var_16;
      }
    }

    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "crash") {
      if(isDefined(var_5.target)) {
        var_6 = 1;
        var_14 = -1 * anglestoup(var_1.angles);

        if(vectordot((0, 0, -1), var_14) < 0.2)
          var_14 = (0, 0, -1);

        if(isDefined(var_1.fxorg) && var_1.fxorg != var_1)
          var_1.sliding_fx_org = var_1.fxorg;
        else {
          var_1.sliding_fx_org = common_scripts\utility::spawn_tag_origin();
          var_1.sliding_fx_org.origin = var_1.origin;
          var_1.sliding_fx_org.angles = var_1.angles;
          var_1.sliding_fx_org linkto(var_1);
          var_7[var_7.size] = var_1.sliding_fx_org;
        }

        if(!var_12)
          playFXOnTag(common_scripts\utility::getfx("boat_fall_slide"), var_1.sliding_fx_org, "tag_origin");

        var_1 thread sliding_earthquake(var_5.script_earthquake);
        var_1 playrumblelooponentity("littoral_ship_rumble");
      }

      if(var_13 < 300) {
        if(isDefined(var_5.script_earthquake) && var_5.script_earthquake != "small")
          thread player_shake(var_13);

        thread maps\ship_graveyard_util::thrash_player(300, 0.1, var_1.origin);
      }
    }

    if(isDefined(var_5.target)) {
      var_5 = var_5 common_scripts\utility::get_target_ent();
      continue;
    }

    var_5 = undefined;
  }

  if(var_6) {
    stopFXOnTag(common_scripts\utility::getfx("boat_fall_slide"), var_1.sliding_fx_org, "tag_origin");
    var_1 stoprumble("littoral_ship_rumble");
    var_1 notify("stopped");
    var_13 = distance(level.player.origin, var_1.origin);

    if(var_13 < 300 && !var_12) {
      earthquake(0.35, 0.7, var_1.origin, 1500);
      level.player playrumbleonentity("damage_heavy");
      thread maps\ship_graveyard_util::thrash_player(300, 0.1, var_1.origin);
    }
  }

  if(var_10)
    stopFXOnTag(common_scripts\utility::getfx(var_8), var_1.fxorg, var_9);

  if(isDefined(var_1.fxorg) && var_1.fxorg != var_1)
    var_1.fxorg delete();

  common_scripts\utility::array_thread(var_0, maps\_utility::send_notify, "stop_damage");

  foreach(var_18 in var_7)
  var_18 delete();

  if(var_1.model == "vehicle_mi24p_hind_plaza_body_destroy_animated") {
    wait 8;
    stopFXOnTag(common_scripts\utility::getfx("ship_wreckage_spark_underwater"), var_11, "tag_origin");
    var_11 delete();
  }
}

play_boat_crash_fx_early(var_0, var_1) {
  wait 3.2;
  var_2 = -1 * anglestoup(var_1.angles);

  if(vectordot((0, 0, -1), var_2) < 0.2)
    var_2 = (0, 0, -1);

  var_3 = bulletTrace(var_1.origin, var_1.origin + var_2 * 500 - (0, 650, 0), 0, var_1);
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4.origin = var_3["position"];
  var_4.angles = var_1.angles;
  var_4 linkto(var_1);
  playFX(common_scripts\utility::getfx(self.script_fxid), var_4.origin, (0, 0, 1), var_4.origin - level.player.origin);
  var_0[var_0.size] = var_4;
}

player_shake(var_0) {
  if(var_0 < 200) {
    level.player playrumbleonentity("damage_heavy");
    level.player shellshock("nearby_crash_underwater", 3.5);
    level.player thread maps\ship_graveyard_util::delay_reset_swim_shock(5);
  } else if(var_0 < 300) {
    level.player playrumbleonentity("damage_light");
    level.player shellshock("nearby_crash_underwater", 2.5);
    level.player thread maps\ship_graveyard_util::delay_reset_swim_shock(3);
  } else
    level.player playrumbleonentity("damage_light");
}

sliding_earthquake(var_0) {
  self endon("death");
  self endon("stopped");
  var_1 = 512;

  if(isDefined(var_0)) {
    switch (var_0) {
      case "small":
        var_1 = 50;
        break;
    }
  }

  for(;;) {
    earthquake(0.3, 0.2, self.origin, var_1);
    wait 0.1;
  }
}

crash_model_damage(var_0) {
  if(isDefined(var_0) && self.classname == "script_model") {
    if(self.model == "tag_origin") {
      var_0.fxorg = self;
      return;
    }
  }

  if(self.classname != "script_brushmodel" && self.classname != "trigger_multiple") {
    return;
  }
  self endon("stop_damage");

  if(isDefined(self.damage))
    var_1 = self.damage;
  else
    var_1 = 60;

  for(;;) {
    if(level.player istouching(self)) {
      level.player dodamage(var_1, self.origin);
      wait 0.05;
      continue;
    }

    wait 0.1;
  }
}

random_trench_falling() {
  level endon("new_canyon_combat_start");
  level.ro_index = 0;
  var_0 = maps\_utility::getstructarray_delete("new_trench_random", "targetname");

  for(;;) {
    var_1 = common_scripts\utility::random(var_0);

    if(distance2d(var_1.origin, level.player.origin) < 1000) {
      wait 0.1;
      continue;
    }

    var_1 thread generate_cheap_falling_object();
    wait(randomfloatrange(3, 6));
  }
}

generate_cheap_falling_object(var_0, var_1) {
  var_2 = bulletTrace(self.origin, self.origin - (0, 0, 9999), 0);
  var_3 = spawn("script_model", self.origin);
  var_3 setModel(common_scripts\utility::random(level.debris));
  var_3.angles = (randomfloatrange(0, 360), randomfloatrange(0, 360), randomfloatrange(0, 360));
  var_3.target = "randomobject" + level.ro_index;
  var_4 = spawn("script_origin", var_2["position"] - (0, 0, 30));
  var_4.targetname = "randomobject" + level.ro_index;

  if(!isDefined(var_0))
    var_4.speed = randomfloatrange(200, 260);
  else
    var_4.speed = var_0;

  var_4.script_earthquake = "small";
  var_4.script_soundalias = "scn_shipg_box_fall_generic";
  var_4.script_noteworthy = "crash";
  var_4.target = var_4.targetname + "_2";
  var_4.angles = (0, 0, 0);
  var_4.script_decel = 0.1;

  if(isDefined(var_1))
    var_4.script_exploder = var_1;
  else
    var_4.script_fxid = "boat_fall_impact_small";

  level.ro_index = level.ro_index + 1;
  var_5 = spawn("script_origin", var_4.origin - (0, 0, 80));
  var_5.speed = 30;
  var_5.script_accel = 0.4;
  var_5.targetname = var_4.targetname + "_2";
  var_5.angles = var_3.angles;
  var_4.script_decel = 0.1;
  var_3 crash_model_go([]);
  wait 0.5;
  var_4 delete();
  var_5 delete();

  while(distance2d(var_3.origin, level.player.origin) < 800 && level.player maps\_utility::player_looking_at(var_3.origin, 0.6, 1))
    wait 0.1;

  var_3 delete();
}

trigger_enablelinkto() {
  if(self.classname == "trigger_multiple")
    self enablelinkto();
}

trench_smash_death() {
  level endon("new_canyon_combat_start");
  common_scripts\utility::flag_wait("new_trench_smash_death");
  player_smash_death();
}

trench_stay_close_1() {
  level.player endon("death");
  level endon("new_canyon_combat_start");

  for(;;) {
    if(distance(level.player.origin, level.baker.origin) > 750) {
      trench_death_warning();
      wait 6;

      if(distance(level.player.origin, level.baker.origin) > 750)
        player_smash_death();
    }

    wait 0.1;
  }
}

trench_death_warning() {
  var_0 = anglesToForward(level.player.angles);
  var_1 = level.player.origin - var_0 * 64;
  playFX(common_scripts\utility::getfx("boat_fall_impact"), var_1, (0, 0, 1), var_1 - level.player.origin);
  thread common_scripts\utility::play_sound_in_space("middle_boat_crash", var_1);
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.35, 0.7, var_1, 1500);
  level.player viewkick(100, var_1);
  level.player playrumbleonentity("damage_heavy");
  level.player thread maps\_gameskill::blood_splat_on_screen("bottom");
  level.player maps\_utility::delaythread(0.1, maps\_utility::playlocalsoundwrapper, "breathing_hurt");
  level.player dodamage(30, var_1);
}

trench_stay_close_2() {
  level.player endon("death");
  level endon("new_canyon_combat_start");

  for(;;) {
    if(distance(level.player.origin, level.baker.origin) > 1200) {
      player_smash_death();
      return;
    }

    wait 0.1;
  }
}

player_smash_death() {
  level.player notify("smash_death");
  thread trench_death_warning();
  wait 0.25;
  level.player kill();
}

start_canyon_combat() {
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("new_canyon_boats_1");
  common_scripts\utility::array_thread(var_0, ::trench_boat_think);
  common_scripts\utility::flag_wait("new_canyon_combat_start");
  maps\_utility::autosave_by_name("new_canyon");

  if(!maps\ship_graveyard_util::greenlight_check())
    level.baker maps\_utility::set_force_color("r");

  maps\ship_graveyard_util::baker_glint_off();
  maps\_utility::array_spawn_targetname("nc_enemies_1");
  maps\_utility::delaythread(45, maps\ship_graveyard_util::try_to_melee_player, "start_depth_charges");
}

trench_boat_think() {
  self endon("death");
  self waittill("reached_end_node");
  var_0 = common_scripts\utility::get_target_ent(self.script_noteworthy + "_trigger");
  var_0 common_scripts\utility::trigger_off();
  common_scripts\utility::flag_wait("new_canyon_combat_start");
  var_1 = maps\_utility::array_spawn_targetname(self.script_noteworthy + "_guys");
  common_scripts\utility::array_thread(var_1, ::canyon_jumper_setup);
  var_1[0] common_scripts\utility::waittill_either("done_jumping_in", "death");
  wait(randomfloatrange(1, 3));
  level endon("stop_killing_player");
  level waittill("never");
  thread maps\ship_graveyard_util::boat_shoot_entity(level.player, "stop_killing_player");
  var_0 common_scripts\utility::trigger_on();

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(var_2 == level.player) {
      break;
    }
  }

  self notify("stop_shooting");
  var_3 = common_scripts\utility::get_target_ent(self.script_noteworthy + "_body");
  var_4 = var_3 maps\_utility::spawn_ai(1);
  var_4.origin = (var_3.origin[0], var_3.origin[1], level.water_level_z + 5);
  common_scripts\utility::waitframe();
  var_5 = var_3;
  var_6 = anglesToForward(var_5.angles);
  var_5.origin = var_5.origin + var_6 * 16;
  var_4 thread maps\_utility::magic_bullet_shield();
  var_4.forceragdollimmediate = 1;
  var_4.skipdeathanim = 1;
  playFXOnTag(common_scripts\utility::getfx("underwater_object_trail"), var_4, "tag_origin");
  var_3 thread maps\_anim::anim_generic(var_4, "death_boat_A");
  wait 1.5;
  playFX(common_scripts\utility::getfx("jump_into_water_splash"), var_5.origin);
  thread common_scripts\utility::play_sound_in_space("enemy_water_splash", var_5.origin);
  var_3 waittill("death_boat_A");
  var_7 = var_4 common_scripts\utility::spawn_tag_origin();
  var_4 linkto(var_7, "tag_origin");
  var_8 = getweaponmodel(var_4.weapon);
  var_9 = var_4.weapon;

  if(isDefined(var_8)) {
    var_4 detach(var_8, "tag_weapon_right");
    var_5 = var_4 gettagorigin("tag_weapon_right");
    var_10 = var_4 gettagangles("tag_weapon_right");
    var_11 = spawn("weapon_" + var_9, (0, 0, 0));
    var_11.angles = var_10;
    var_11.origin = var_5;
  }

  var_7 thread maps\_anim::anim_generic_loop(var_4, "death_boat_A_loop");
  var_12 = bulletTrace(var_4.origin - (0, 0, 200), var_4.origin - (0, 0, 6000), 0, var_4);
  var_13 = var_12["position"];
  var_13 = (var_13[0], var_13[1], var_13[2] + 50);
  var_7 maps\ship_graveyard_util::moveto_speed(var_13, 100, 0, 0);
  stopFXOnTag(common_scripts\utility::getfx("underwater_object_trail"), var_4, "tag_origin");
  var_4 maps\_utility::stop_magic_bullet_shield();
  var_4 startragdoll();
  var_4 unlink();
  var_7 notify("stop_loop");
  wait 0.1;
  var_7 delete();
  wait 0.5;
  var_4 kill();
}

canyon_jumper_setup() {
  self endon("death");
  var_0 = common_scripts\utility::get_target_ent();

  if(isDefined(var_0)) {
    if(isDefined(var_0.target)) {
      self waittill("done_jumping_in");
      var_0 = var_0 common_scripts\utility::get_target_ent();
      maps\_utility::follow_path_and_animate(var_0, 0);
    }
  }
}

hit_player_when_flag() {
  level endon("stop_killing_player");

  for(;;) {
    if(common_scripts\utility::flag("trench_shoot_player")) {
      var_0 = anglesToForward(level.player.angles);
      var_1 = level.player getEye() + (0, 0, 5) + var_0;
      var_2 = level.player getEye();
      magicbullet("aps_underwater", var_1, var_2);
    }

    wait(randomfloatrange(0.3, 0.5));
  }
}