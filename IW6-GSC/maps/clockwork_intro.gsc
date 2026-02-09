/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\clockwork_intro.gsc
*****************************************************/

clockwork_intro_pre_load() {
  common_scripts\utility::flag_init("intro_finished");
  common_scripts\utility::flag_init("FLAG_swap_ally_heads");
  common_scripts\utility::flag_init("FLAG_player_mask_anim");
  common_scripts\utility::flag_init("FLAG_let_btr_pass");
  common_scripts\utility::flag_init("FLAG_start_approach_vo");
  common_scripts\utility::flag_init("delete_ambush_jeep2");
  common_scripts\utility::flag_init("ally_checkpoint_approach");
  common_scripts\utility::flag_init("FLAG_attach_keegan_helmet");
  common_scripts\utility::flag_init("flag_intro_baker_exit");
  common_scripts\utility::flag_init("flag_intro_cipher_exit");
  common_scripts\utility::flag_init("flag_intro_keegan_exit");
  common_scripts\utility::flag_init("trigger_spotlight_b");
  common_scripts\utility::flag_init("FLAG_obj_enterbase");
  common_scripts\utility::flag_init("FLAG_obj_enterbase_complete");
  common_scripts\utility::flag_init("destroy_player_intro");
  common_scripts\utility::flag_init("start_watch_anim");
  common_scripts\utility::flag_init("checkpoint_vo_rook_shoot");
  common_scripts\utility::flag_init("start_enemies_provoked_early");
  common_scripts\utility::flag_init("ok_shoot_radio");
  common_scripts\utility::flag_init("checkpoint_taken");
  common_scripts\utility::flag_init("player_at_checkpoint");
  common_scripts\utility::flag_init("intro_destroy_player_off");
  common_scripts\utility::flag_init("start_ambush_scene");
  common_scripts\utility::flag_init("start_ambush_scene_enemies");
  common_scripts\utility::flag_init("intro_text_done");
  common_scripts\utility::flag_init("start_spotlight_b");
  common_scripts\utility::flag_init("ambush_destroy_player_off");
  common_scripts\utility::flag_init("player_drag_body");
  common_scripts\utility::flag_init("ambush_scene_started");
  common_scripts\utility::flag_init("ambush_anim_finished");
  common_scripts\utility::flag_init("introdrive_finished");
  common_scripts\utility::flag_init("FLAG_obj_bodydrag");
  common_scripts\utility::flag_init("FLAG_obj_bodydrag_complete");
  common_scripts\utility::flag_init("FLAG_baker_bodydrag_complete");
  common_scripts\utility::flag_init("FLAG_obj_getinjeep");
  common_scripts\utility::flag_init("FLAG_obj_getinjeep_complete");
  common_scripts\utility::flag_init("FLAG_obj_pickupbags_complete");
  common_scripts\utility::flag_init("entering_blackbird_vo");
  common_scripts\utility::flag_init("start_intro_convoy");
  common_scripts\utility::flag_init("player_looking_at_tower");
  common_scripts\utility::flag_init("bakerambush_finished");
  common_scripts\utility::flag_init("cipherambush_finished");
  common_scripts\utility::flag_init("keeganambush_finished");
  common_scripts\utility::flag_init("start_enemies_weaponsfree");
  common_scripts\utility::flag_init("FLAG_pay_attention");
  common_scripts\utility::flag_init("ally_dead");
  common_scripts\utility::flag_init("spawn_checkpoint_guards");
  common_scripts\utility::flag_init("bodydrag1_fakedead");
  common_scripts\utility::flag_init("bodydrag2_fakedead");
  common_scripts\utility::flag_init("bodydrag3_fakedead");
  common_scripts\utility::flag_init("player_told_to_get_bags");
  common_scripts\utility::flag_init("player_didnt_shoot_target");
  common_scripts\utility::flag_init("FLAG_cipher_kicks_jeep");
  common_scripts\utility::flag_init("btr_reverse_here");
  common_scripts\utility::flag_init("allies_prep_lightsout");
  common_scripts\utility::flag_init("FLAG_keegan_wave_jeep");
  common_scripts\utility::flag_init("FLAG_baker_out_of_hut");
  common_scripts\utility::flag_init("FLAG_enable_enter_jeep");
  common_scripts\utility::flag_init("ambush_scene_shot");
  common_scripts\utility::flag_init("ambush_scene_stab");
  common_scripts\utility::flag_init("bulbs_parking");
  common_scripts\utility::flag_init("FLAG_gunshot_drag");
  common_scripts\utility::flag_init("FLAG_entrance_drones");
  common_scripts\utility::flag_init("FLAG_player_failcase_tunnel");
  common_scripts\utility::flag_init("btr_sees_playerdrag_body");
  common_scripts\utility::flag_init("spotlight_track_player");
  common_scripts\utility::flag_init("FLAG_intro_light_off");
  common_scripts\utility::flag_init("ambush_player_timeout");
  common_scripts\utility::flag_init("checkpoint_vo_tango");
  common_scripts\utility::flag_init("lights_out");
  common_scripts\utility::flag_init("ambush_scene_timeout");
  common_scripts\utility::flag_init("FLAG_checkcheck");
  common_scripts\utility::flag_init("tower_kill_ok");
  common_scripts\utility::flag_init("checkpoint_taken2");
  common_scripts\utility::flag_init("k_reached_ambush_anim");
  common_scripts\utility::flag_init("c_reached_ambush_anim");
  common_scripts\utility::flag_init("FLAG_take_the_rest");
  common_scripts\utility::flag_init("FLAG_intro_jeeps_pull_away");
  common_scripts\utility::flag_init("FLAG_keegan_drag_door");
  common_scripts\utility::flag_init("keegan_delay_flag_hack");
  common_scripts\utility::flag_init("FLAG_bodydrag2_deathflag");
  common_scripts\utility::flag_init("FLAG_bodydrag_deathflag");
  common_scripts\utility::flag_init("player_near_stab_guy");
  common_scripts\utility::flag_init("player_looking_at_stab_guy");
  common_scripts\utility::flag_init("player_in_position_for_stab_kill");
  common_scripts\utility::flag_init("enable_stab");
  common_scripts\utility::flag_init("intro_cp_radio");
  common_scripts\utility::flag_init("FLAG_the_last_guy");
  common_scripts\utility::flag_init("flag_ambush_knife_fx");
  common_scripts\utility::flag_init("start_watchsync_vo");
  common_scripts\utility::flag_init("start_playerstand_reveal");
  common_scripts\utility::flag_init("destroy_player_ambush");
  common_scripts\utility::flag_init("start_ambush_vo");
  common_scripts\utility::flag_init("ambush_enemies_provoked");
  common_scripts\utility::flag_init("ambush_finished");
  common_scripts\utility::flag_init("ambush_stop_vo");
  common_scripts\utility::flag_init("quiet_kill_balcony_guy");
  common_scripts\utility::flag_init("checkpoint_player_picks_target");
  common_scripts\utility::flag_init("player_in_jeep");
  common_scripts\utility::flag_init("start_intro_drive");
  common_scripts\utility::flag_init("FLAG_start_blackout_vo");
  common_scripts\utility::flag_init("nvg_gun_up");
}

setup_intro2() {
  maps\clockwork_code::dog_setup();
  level.start_point = "intro2";
  maps\clockwork_code::setup_player();
  intro_display_introscreen();
  maps\_utility::disable_trigger_with_targetname("TRIG_checkpoint_taken2");
  maps\_utility::vision_set_changes("clockwork", 0);
}

setup_ambush() {
  maps\clockwork_code::dog_setup();
  level.start_point = "start_ambush";
  maps\clockwork_code::setup_player();
  maps\_utility::vision_set_changes("clockwork", 0);
  common_scripts\utility::flag_set("checkpoint_taken");
  thread delay_keegan_color();
  maps\_utility::disable_trigger_with_targetname("trig_get_in_jeep");
  level.pre_ambush_scene_org = common_scripts\utility::getstruct("ambush_scene_org", "targetname");
  level.ambush_jeep_scene = common_scripts\utility::getstruct("ambush_jeep_scene", "targetname");
  thread maps\clockwork_audio::checkpoint_start_ambush();
  maps\clockwork_code::spawn_allies();

  foreach(var_1 in level.allies) {
    var_1.ignoreall = 1;
    var_1.ignoreme = 1;
    var_1 maps\_utility::forceuseweapon("gm6+scopegm6_sp+silencer03_sp", "primary");
  }

  setup_bodydrag_startpoint();
  thread cipher_ambush_approach(level.allies[2], "cipher", "cipher_bag", "ambush_approach", "ambush_approach_loop", level.pre_ambush_scene_org);
  maps\clockwork_code::init_animated_dufflebags_baker();
  thread handle_baker_ambush_anims(level.pre_ambush_scene_org, level.allies[0], "clock_intro", level.bags[0], level.intro_balcony_guy, undefined);
  thread intro_ambush_vo();
  level.player.ignoreme = 1;
  maps\_utility::battlechatter_off();

  if(level.woof)
    thread handle_dog_ambush();

  thread spawn_ambush_vehicles();
  thread player_failcase_tunnel();
  thread obj_enterbase();
  common_scripts\utility::flag_set("FLAG_obj_enterbase");
}

delay_keegan_color() {
  wait 3.75;
  var_0 = level.allies[1].goalradius;
  var_1 = getnode("keegan_ambush_goal1", "targetname");
  level.allies[1].goalradius = 32;
  level.allies[1] setgoalnode(var_1);
  level.allies[1] waittill("goal");
  common_scripts\utility::flag_set("keegan_delay_flag_hack");
  level.allies[1].goalradius = var_0;
}

setup_checkpoint() {
  maps\clockwork_code::dog_setup();
  level.start_point = "checkpoint";
  maps\clockwork_code::setup_player();
  level.pre_ambush_scene_org = common_scripts\utility::getstruct("ambush_scene_org", "targetname");
  level.ambush_jeep_scene = common_scripts\utility::getstruct("ambush_jeep_scene", "targetname");
  maps\_utility::vision_set_changes("clockwork", 0);
  maps\clockwork_code::spawn_allies();
  maps\_utility::disable_trigger_with_targetname("trig_get_in_jeep");
  maps\_utility::disable_trigger_with_targetname("TRIG_checkpoint_taken2");

  foreach(var_1 in level.allies) {
    var_1.ignoreall = 1;
    var_1.ignoreme = 1;
    var_1 maps\_utility::forceuseweapon("gm6+scopegm6_sp+silencer03_sp", "primary");
  }

  level.player.ignoreme = 1;
  maps\_utility::battlechatter_off();

  if(level.woof)
    thread handle_dog_checkpoint();

  thread intro_checkpoint_vo();
  thread obj_enterbase();
  common_scripts\utility::flag_set("FLAG_obj_enterbase");
  common_scripts\utility::flag_set("FLAG_start_approach_vo");
  level.checkpoint_patrol_anim = [];
  level.checkpoint_patrol_anim[0] = "patrol_walk";
  level.checkpoint_patrol_anim[1] = "walk_gun_unwary";
  level.ambush_recover_anim = [];
  level.ambush_recover_anim[0] = "ambush_enemy_react1";
  level.ambush_recover_anim[1] = "ambush_enemy_react2";
  level.ambush_recover_anim[2] = "ambush_enemy_react3";
  wait 0.5;
  maps\_utility::activate_trigger_with_targetname("TRIG_allies_goto_checkpoint");
}

override_setup_headmodels_for_allies() {
  wait 3;
  var_0 = level.allies[0];
  var_1 = var_0.script_parameters;
  var_0.disguise_head = var_0.headmodel;
  var_0 detach(var_0.headmodel, "");
  var_0 attach(var_1, "", 1);
  var_0.headmodel = var_1;
  var_0 = level.allies[1];
  var_1 = "head_hesh_stealth_b_no_helmet";
  var_0.disguise_head = var_0.headmodel;
  var_0 detach(var_0.headmodel, "");
  var_0 attach(var_1, "", 1);
  var_0.headmodel = var_1;
}

setup_disguise_for_allies() {
  var_0 = level.allies[0];
  var_1 = var_0.disguise_head;
  var_0 detach(var_0.headmodel, "");
  var_0 attach(var_1, "", 1);
  var_0.headmodel = var_1;
  var_0.disguise_head = undefined;
}

begin_intro() {
  maps\clockwork_code::spawn_allies();
  thread override_setup_headmodels_for_allies();

  if(level.woof)
    thread handle_dog_intro();

  foreach(var_1 in level.allies) {
    var_1.ignoreall = 1;
    var_1.ignoreme = 1;
    var_1 maps\_utility::enable_cqbwalk();
    var_1.disable_sniper_glint = 1;
  }

  maps\_utility::disable_trigger_with_targetname("trig_get_in_jeep");
  level.player.ignoreme = 1;
  level.player allowcrouch(0);
  common_scripts\utility::flag_wait("intro_text_done");
  level.checkpoint_patrol_anim = [];
  level.checkpoint_patrol_anim[0] = "patrol_walk";
  level.checkpoint_patrol_anim[1] = "walk_gun_unwary";
  level.ambush_recover_anim = [];
  level.ambush_recover_anim[0] = "ambush_enemy_react1";
  level.ambush_recover_anim[1] = "ambush_enemy_react2";
  level.ambush_recover_anim[2] = "ambush_enemy_react3";
  common_scripts\utility::flag_wait("intro_finished");
}

begin_checkpoint() {}

begin_ambush() {
  thread prepare_ambush();
  thread intro_drive();
  maps\_utility::disable_trigger_with_targetname("trig_get_in_jeep");
  common_scripts\utility::flag_wait("introdrive_finished");
}

intro_display_introscreen() {
  level.player freezecontrols(1);
  take_away_offhands();
  thread maps\_utility::endondeath();
  maps\_utility::intro_screen_create(&"CLOCKWORK_INTROSCREEN_LINE_1", &"CLOCKWORK_INTROSCREEN_LINE_2", &"CLOCKWORK_INTROSCREEN_LINE_5");
  level.introscreen_complete_delay = 2;
  wait 1;
  level.intro_black = thread maps\clockwork_code::introscreen_generic_black_fade_in_on_flag("start_watch_anim", 2.5);
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  thread intro_anims();
  thread obj_enterbase();
  thread spawn_convoy();
  common_scripts\utility::flag_set("intro_text_done");
}

player_intro_anims(var_0, var_1, var_2, var_3) {
  setsaveddvar("cg_cinematicFullScreen", "0");
  var_4 = maps\_utility::spawn_anim_model("player_rig");
  var_5 = maps\_utility::spawn_anim_model("player_rig");
  var_5 setModel("clk_watch_viewhands");
  thread maps\clockwork_code::watch_light_fx(var_4, var_5);
  thread maps\clockwork_code::watch_tick(var_5);
  var_4 show();
  var_5 hide();
  level.player playerlinktoabsolute(var_4, "tag_player");
  var_0 thread maps\_anim::anim_single_solo(var_5, var_1);
  var_0 maps\_anim::anim_single_solo(var_4, var_1);
  var_4 hide();
  var_5 hide();
  setsaveddvar("ammoCounterHide", 1);
  level.player giveweapon("helmet_goggles");
  level.player switchtoweapon("helmet_goggles");
  wait 2.467;

  foreach(var_7 in var_3)
  level.player giveweapon(var_7);

  level.player switchtoweapon("gm6+scopegm6_sp+silencer03_sp");
  level.player takeweapon("helmet_goggles");
  setsaveddvar("ammoCounterHide", 0);
  level.player playerlinktoblend(var_2, "J_prop_1", 1.0);
  wait 1.0;
  give_back_offhands();
  level.player unlink();
  var_4 delete();
  var_5 delete();
  level.player allowcrouch(1);
  level.player freezecontrols(0);
}

take_away_offhands() {
  level.player disableoffhandweapons();
  level.player setweaponammoclip("fraggrenade", 0);
  level.player setweaponammostock("fraggrenade", 0);
  level.player setweaponammoclip("flash_grenade", 0);
  level.player setweaponammostock("flash_grenade", 0);
}

give_back_offhands() {
  level.player enableoffhandweapons();
  level.player giveweapon("fraggrenade");
  var_0 = weaponmaxammo("fraggrenade");
  var_1 = weaponclipsize("fraggrenade");
  level.player setweaponammoclip("fraggrenade", var_1);
  level.player setweaponammostock("fraggrenade", var_0);
  level.player giveweapon("flash_grenade");
  var_0 = weaponmaxammo("flash_grenade");
  var_1 = weaponclipsize("flash_grenade");
  level.player setweaponammoclip("flash_grenade", var_1);
  level.player setweaponammostock("flash_grenade", var_0);
}

intro_anims() {
  thread maps\clockwork_audio::intro_black();
  var_0 = common_scripts\utility::getstruct("intro2_start", "targetname");
  var_1 = maps\_utility::spawn_anim_model("player_view");
  var_0 maps\_anim::anim_first_frame_solo(var_1, "clock_prepare");
  var_2 = level.player getweaponslistprimaries();

  foreach(var_4 in var_2)
  level.player takeweapon(var_4);

  wait 1.5;
  thread player_intro_anims(var_0, "watch_sync_intro", var_1, var_2);
  thread intro_anims_enemies();
  thread maps\clockwork_audio::intro_watch();
  level.allies[0] thread handle_baker_intro_anim(var_0, var_1);
  level.allies[1] thread handle_keegan_intro_anim(var_0);
  level.allies[2] thread handle_cipher_intro_anim(var_0);

  foreach(var_7 in level.allies)
  var_7 maps\_utility::forceuseweapon("gm6+scopegm6_sp+silencer03_sp", "primary");

  wait 1;
  common_scripts\utility::flag_set("start_watch_anim");
  wait 8;
  common_scripts\utility::flag_set("FLAG_obj_enterbase");

  foreach(var_7 in level.allies)
  var_7 maps\_utility::enable_cqbwalk();

  wait 5;
  common_scripts\utility::flag_set("start_intro_convoy");
  thread player_failcase_tunnel();
  wait 1.5;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_jeeppatrol");
  thread intro_checkpoint_vo();
}

handle_baker_intro_anim(var_0, var_1) {
  level.allies[0].animname = "baker";
  var_2 = maps\_utility::spawn_anim_model("baker_mask");
  var_3 = maps\_utility::spawn_anim_model("player_mask");
  thread hide_at_end_anim(var_2);
  thread hide_at_end_anim(var_3);
  var_4 = animscripts\utility::array(var_1, level.allies[0]);
  var_0 thread maps\_anim::anim_single_solo(var_3, "clock_prepare");
  var_0 thread maps\_anim::anim_single_solo(var_2, "clock_prepare");
  var_0 maps\_anim::anim_single(var_4, "clock_prepare");
  maps\_utility::activate_trigger_with_targetname("baker_intro_color");
}

helmet_swap_keegan(var_0) {
  self waittillmatch("single anim", "helmet_attach");
  var_1 = self.disguise_head;
  self detach(self.headmodel, "");
  self attach(var_1, "", 1);
  self.headmodel = var_1;
  self.disguise_head = undefined;
  var_0 delete();
}

handle_keegan_intro_anim(var_0) {
  level.allies[1].animname = "keegan";
  var_1 = maps\_utility::spawn_anim_model("keegan_mask");
  var_0 thread maps\_anim::anim_single_solo(self, "clock_prepare");
  var_0 thread maps\_anim::anim_single_solo(var_1, "clock_prepare");
  thread helmet_swap_keegan(var_1);
  maps\_utility::activate_trigger_with_targetname("kb_intro_color");
}

handle_cipher_intro_anim(var_0) {
  level.allies[2].animname = "cipher";
  var_0 maps\_anim::anim_single_solo(self, "clock_prepare");
  maps\_utility::activate_trigger_with_targetname("intro_allymove_jeep");
}

hide_at_end_anim(var_0) {
  level.allies[0] waittillmatch("single anim", "head_swap");

  if(var_0.animname == "player_mask")
    setup_disguise_for_allies();

  var_0 delete();
}

intro_anims_enemies() {
  var_0 = common_scripts\utility::getstruct("intro2_start", "targetname");
  var_1 = maps\_utility::spawn_anim_model("sm_body1", var_0.origin);
  var_1.animname = "sm_body1";
  var_2 = maps\_utility::spawn_anim_model("sm_body2", var_0.origin);
  var_2.animname = "sm_body2";
  var_3 = maps\_utility::spawn_anim_model("sm_body3", var_0.origin);
  var_3.animname = "sm_body3";
  var_0 thread maps\_anim::anim_first_frame_solo(var_1, "clock_prepare_bodies");
  var_0 thread maps\_anim::anim_first_frame_solo(var_2, "clock_prepare_bodies");
  var_0 maps\_anim::anim_single_solo(var_3, "clock_prepare_bodies");
}

setup_checkpoint_combat() {
  common_scripts\utility::flag_wait("spawn_checkpoint_guards");
  thread player_failcase_tunnel();
  level.pre_ambush_scene_org = common_scripts\utility::getstruct("ambush_scene_org", "targetname");
  level.ambush_jeep_scene = common_scripts\utility::getstruct("ambush_jeep_scene", "targetname");
  maps\_utility::array_spawn_function_targetname("introcp_guy_radio", ::handle_radio_alert);
  maps\_utility::array_spawn_function_targetname("introcp_guys_tower", ::handle_tower_alert);
  maps\_utility::array_spawn_function_targetname("introcp_guys_remaining", ::handle_remaining_alert);
  maps\_utility::array_spawn_function_targetname("intro_bodydrag_enemy", ::handle_remaining_alert);
  maps\_utility::array_spawn_function_targetname("intro_bodydrag2_enemy", ::handle_remaining_alert);
  maps\_utility::array_spawn_function_targetname("balcony_death_guy", ::handle_remaining_alert);
  maps\_utility::array_spawn_function_noteworthy("checkpoint_patrollers", ::checkpoint_patrol, 1);
  thread handle_radiotower_guy();
  level.introcp_guys_tower = maps\_utility::array_spawn_targetname("introcp_guys_tower", 1);
  level.introcp_guys_remaining = maps\_utility::array_spawn_targetname("introcp_guys_remaining", 1);
  level.special_death_guys = [];
  thread handle_balcony_death();
  wait 2;
  thread handle_player_bodydrag_death();
  thread handle_keegandrag_death();
}

handle_radiotower_guy() {
  level.introcp_guy_radio = maps\_utility::spawn_targetname("introcp_guy_radio", 1);
  level.introcp_guy_radio.animname = "radioguy";
  level.introcp_guy_radio.allowdeath = 1;
  level.introcp_guy_radio maps\_utility::gun_remove();
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("com_hand_radio");
  var_0 linkto(level.introcp_guy_radio, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("weapon_binocular");
  var_1 linkto(level.introcp_guy_radio, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  level.pre_ambush_scene_org thread maps\_anim::anim_loop_solo(level.introcp_guy_radio, "lookout");
  thread delete_accessories_on_death(var_1, var_0);
  common_scripts\utility::flag_wait("start_enemies_provoked_early");

  if(isDefined(level.introcp_guy_radio) && isalive(level.introcp_guy_radio))
    magicbullet(level.allies[2].weapon, level.allies[2] gettagorigin("tag_flash"), level.introcp_guy_radio gettagorigin("j_head"));
}

delete_accessories_on_death(var_0, var_1) {
  common_scripts\utility::flag_wait("intro_cp_radio");
  var_0 delete();
  var_1 delete();
}

intro_checkpoint_vo() {
  thread setup_checkpoint_combat();
  thread checkpoint_combat_failsafe();
  thread radio_tower_guy_shot();
  thread ally_checkpoint_approaches();
  level endon("start_enemies_provoked_early");
  common_scripts\utility::flag_wait("FLAG_start_approach_vo");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_checkpointsahead");
  wait 1;
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_diz_northernridge");
  wait 1;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_copyall");
  wait 3;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_quicklyandquietly");
  common_scripts\utility::flag_wait("checkpoint_vo_tango");
  thread maps\_utility::autosave_by_name("checkpoint");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_count8");
  common_scripts\utility::flag_wait("checkpoint_vo_rook_shoot");
  thread look_for_last_guy();
  common_scripts\utility::flag_wait("FLAG_the_last_guy");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_thereheis");
  common_scripts\utility::flag_set("ok_shoot_radio");

  if(isDefined(level.introcp_guy_radio) && isalive(level.introcp_guy_radio)) {
    level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_bestshot");
    thread look_at_tower_early_vo();
    thread nag_shoot_radio_vo();
  }

  thread handle_radio_tower_kill();
  common_scripts\utility::flag_wait("intro_cp_radio");
  wait 1.5;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_wevegot3on");

  foreach(var_1 in level.introcp_guys_tower)
  var_1 thread handle_com_tower_kill();

  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_letsdropemtogether");
  thread look_at_tower_vo();
  thread look_at_tower_vo_timeout();
  common_scripts\utility::flag_wait("player_looking_at_tower");
  thread cipher_keegan_tower_kill();
  thread vo_tower_shoot();
  common_scripts\utility::flag_set("tower_kill_ok");
  maps\_utility::waittill_aigroupcleared("intro_cp_tower");
  level notify("disable_combat_failsafe");

  foreach(var_1 in level.introcp_guys_remaining) {
    if(isDefined(var_1)) {
      var_1 thread handle_remaining_kill();
      var_1 thread alert_enemies();
    }
  }

  foreach(var_1 in level.special_death_guys) {
    if(isDefined(var_1)) {
      var_1 thread handle_remaining_kill();
      var_1 thread alert_enemies();
    }
  }

  thread handle_checkpoint_end_condition();
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_splash3");
  common_scripts\utility::waitframe();
  thread remaining_kill();
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_pickatarget");
  maps\_utility::waittill_aigroupcleared("intro_cp_remaining");
}

ally_checkpoint_approaches() {
  level endon("start_enemies_provoked_early");
  common_scripts\utility::flag_wait("ally_checkpoint_approach");

  foreach(var_1 in level.allies) {
    var_1 maps\_utility::cqb_walk("on");
    var_1 maps\_utility::disable_ai_color();
  }

  thread approach_anims(level.allies[0], "baker", "checkpoint_approach", "checkpoint_approach_loop", level.pre_ambush_scene_org);
  thread approach_anims(level.allies[1], "keegan", "checkpoint_approach", "checkpoint_approach_loop", level.pre_ambush_scene_org);
  thread cipher_approach_anims(level.allies[2], "cipher", "checkpoint_approach", "checkpoint_approach_loop", level.pre_ambush_scene_org);
}

approach_anims(var_0, var_1, var_2, var_3, var_4) {
  level endon("cancel_approach_anims");
  var_0 maps\_utility::disable_ai_color();
  var_0.animname = var_1;
  var_4 maps\_anim::anim_reach_solo(var_0, var_2);
  var_4 maps\_anim::anim_single_solo(var_0, var_2);
  var_4 thread maps\_anim::anim_loop_solo(var_0, var_3, "stop_loop");
  var_0 thread handle_approach_anims_end(var_4);
}

handle_approach_anims_end(var_0) {
  common_scripts\utility::flag_wait_any("intro_finished", "start_enemies_provoked_early");
  var_0 notify("stop_loop");
  maps\_utility::anim_stopanimscripted();
}

cipher_approach_anims(var_0, var_1, var_2, var_3, var_4) {
  level endon("cancel_approach_anims");
  var_0 maps\_utility::disable_ai_color();
  var_0.animname = var_1;
  var_4 maps\_anim::anim_reach_solo(var_0, var_2);
  var_4 maps\_anim::anim_single_solo(var_0, var_2);
  var_4 thread maps\_anim::anim_loop_solo(var_0, var_3, "stop_loop");
  var_0 thread handle_ciper_approach_anims_end(var_4);
}

handle_ciper_approach_anims_end(var_0) {
  common_scripts\utility::flag_wait_any("intro_finished", "start_enemies_provoked_early");

  if(common_scripts\utility::flag("start_enemies_provoked_early"))
    maps\_utility::enable_ai_color();

  var_0 notify("stop_loop");
  maps\_utility::anim_stopanimscripted();
}

cipher_ambush_approach(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0.animname = var_1;
  var_5 maps\_anim::anim_reach_solo(var_0, var_3);
  var_5 maps\_anim::anim_single_solo(var_0, var_3);
  level notify("c_reached_ambush_anim");
  common_scripts\utility::flag_set("c_reached_ambush_anim");

  if(!common_scripts\utility::flag("k_reached_ambush_anim"))
    var_5 thread maps\_anim::anim_loop_solo(var_0, var_4, "stop_loop");

  level waittill("k_reached_ambush_anim");
  var_5 notify("stop_loop");
}

vo_tower_shoot() {
  level endon("start_enemies_provoked_early");
  level endon("player_shot_gun");
  level endon("player_shot_target_on_tower");
  wait 0.75;
  common_scripts\utility::flag_set("FLAG_take_the_rest");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_keeganrightigot");
  wait 3.5;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_adamonyou");
  wait 5;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_adamonyou");
}

radio_tower_guy_shot() {
  level endon("start_enemies_provoked_early");
  common_scripts\utility::flag_wait("intro_cp_radio");

  if(common_scripts\utility::flag("ok_shoot_radio")) {
    wait 0.25;
    level.allies[2] maps\clockwork_code::char_dialog_add_and_go("clockwork_kgn_hesdown");
    wait 1.5;
  }

  if(!common_scripts\utility::flag("ok_shoot_radio"))
    common_scripts\utility::flag_set("start_enemies_provoked_early");
}

handle_checkpoint_end_condition() {
  common_scripts\utility::flag_wait_all("bodydrag1_fakedead", "bodydrag2_fakedead", "bodydrag3_fakedead");
  maps\_utility::battlechatter_off();
  thread maps\clockwork_audio::pre_ambush();
  thread spawn_ambush_vehicles();

  foreach(var_1 in level.allies) {
    var_1 maps\_utility::disable_ai_color();
    var_1.ignoreall = 1;
  }

  common_scripts\utility::flag_set("intro_finished");
  common_scripts\utility::flag_set("checkpoint_taken");
  maps\_utility::enable_trigger_with_targetname("TRIG_checkpoint_taken2");
  thread delay_keegan_color();
  thread cipher_ambush_approach(level.allies[2], "cipher", "cipher_bag", "ambush_approach", "ambush_approach_loop", level.pre_ambush_scene_org);
  maps\clockwork_code::init_animated_dufflebags_baker();
  thread handle_baker_ambush_anims(level.pre_ambush_scene_org, level.allies[0], "clock_intro", level.bags[0], level.intro_balcony_guy, undefined);
  thread intro_ambush_vo();
  thread maps\_utility::autosave_by_name("checkpoint_clear");
}

look_at_tower_early_vo() {
  level endon("player_shot_someone_on_radio");
  level endon("player_shot_target_on_tower");
  level endon("start_enemies_provoked_early");
  var_0 = getent("towerorg", "targetname");

  for(;;) {
    if(level.player maps\_utility::isads() && level.player adsbuttonpressed()) {
      var_0 maps\_utility::waittill_player_lookat_for_time(1, 0.98);
      level notify("reset_radio_tower_vo");
      level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_talltower");
      wait 0.05;
      thread nag_shoot_radio_vo();
      wait 3;
    }

    wait 0.25;
  }
}

nag_shoot_radio_vo() {
  level endon("player_shot_someone_on_radio");
  level endon("start_enemies_provoked_early");
  level endon("reset_radio_tower_vo");

  for(;;) {
    wait 10;
    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_radiotowerrightside");
    wait 10;
    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_timeswastingtakehim");
  }
}

look_for_last_guy() {
  thread look_for_last_guy_timeout();
  level endon("last_guy_out_building");
  level endon("player_shot_someone_on_radio");
  var_0 = getent("lastguyorg", "targetname");

  for(;;) {
    var_0 maps\_utility::waittill_player_lookat_for_time(0.6, 0.98);
    common_scripts\utility::flag_set("FLAG_the_last_guy");
    wait 2;
    break;
  }
}

look_for_last_guy_timeout() {
  wait 3;
  common_scripts\utility::flag_set("FLAG_the_last_guy");
  level notify("last_guy_out_building");
}

look_at_tower_vo() {
  level endon("player_shot_target_on_tower");
  level endon("player_looking_at_tower");
  level endon("start_enemies_provoked_early");
  var_0 = cos(7);
  var_1 = getent("towerorg", "targetname");
  var_1 maps\_utility::waittill_player_lookat_for_time(0.05, var_0);
  common_scripts\utility::flag_set("player_looking_at_tower");
}

look_at_tower_vo_timeout() {
  level endon("start_enemies_provoked_early");
  wait 7;
  common_scripts\utility::flag_set("player_looking_at_tower");
  level notify("player_looking_at_tower");
}

checkpoint_combat_failsafe() {
  level endon("player_shot_target_on_tower");
  level endon("disable_combat_failsafe");
  common_scripts\utility::flag_wait("start_enemies_provoked_early");
  level notify("going_in_hot");
  level notify("cancel_approach_anims");
  maps\_utility::activate_trigger_with_targetname("inhot_color_trig");
  common_scripts\utility::flag_set("FLAG_intro_jeeps_pull_away");
  level notify("start_enemies_provoked_early");
  level.allies[0] stopsounds();
  common_scripts\utility::waitframe();
  wait 1;
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_goinginhot");
  common_scripts\utility::flag_set("FLAG_the_last_guy");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2) && !isDefined(var_2.fake_dead))
      var_2 thread alert_enemies_early();
  }

  var_4 = maps\_utility::get_ai_group_ai("intro_cp_radio");
  var_5 = maps\_utility::get_ai_group_ai("intro_cp_tower");
  var_6 = maps\_utility::get_ai_group_ai("intro_cp_remaining");
  var_7 = maps\_utility::get_ai_group_ai("intro_cp_specialcase");
  var_8 = common_scripts\utility::array_combine(var_4, var_5);
  var_9 = common_scripts\utility::array_combine(var_6, var_7);
  var_10 = common_scripts\utility::array_combine(var_8, var_9);
  wait 1.5;
  thread maps\clockwork_code::attack_targets(level.allies, var_10, 3, 4.5, 1);
  maps\_utility::waittill_aigroupcleared("intro_cp_radio");
  maps\_utility::waittill_aigroupcleared("intro_cp_tower");
  maps\_utility::waittill_aigroupcleared("intro_cp_remaining");
  thread handle_checkpoint_end_condition();
}

handle_radio_tower_kill() {
  level endon("player_shot_someone_on_radio");
  level endon("start_enemies_provoked_early");
  self waittill("damage", var_0, var_1);

  if(var_1 == level.player)
    level notify("player_shot_someone_on_radio");
}

handle_com_tower_kill() {
  level endon("player_shot_target_on_tower");
  level endon("start_enemies_provoked_early");
  self waittill("damage", var_0, var_1);

  if(var_1 == level.player)
    level notify("player_shot_target_on_tower");
}

handle_remaining_kill() {
  level endon("player_shot_someone_in_remaining");
  level endon("start_enemies_provoked_early");
  self waittill("damage", var_0, var_1);

  if(var_1 == level.player)
    level notify("player_shot_someone_in_remaining");
}

cipher_keegan_tower_kill() {
  level endon("start_enemies_provoked_early");
  level waittill("player_shot_target_on_tower");
  level.allies[0] stopsounds();
  var_0 = maps\_utility::get_ai_group_ai("intro_cp_tower");
  maps\clockwork_code::attack_targets(level.allies, var_0, 0.5, 0.75, 1, 1);
  level notify("allies_shot_targets_tower");
}

remaining_kill() {
  var_0 = maps\_utility::get_ai_group_ai("intro_cp_remaining");
  var_1 = maps\_utility::get_ai_group_ai("intro_cp_specialcase");
  var_2 = common_scripts\utility::array_combine(var_0, var_1);
  common_scripts\utility::waittill_notify_or_timeout("player_shot_someone_in_remaining", 5);
  common_scripts\utility::flag_set("checkpoint_player_picks_target");
  maps\clockwork_code::attack_targets(level.allies, var_2, 0.3, 0.6, 1);
  thread force_kill_balcony_keeganguy();
}

force_kill_balcony_keeganguy() {
  wait 1;

  if(isDefined(level.intro_balcony_guy) && isalive(level.intro_balcony_guy))
    magicbullet(level.allies[0].weapon, level.allies[0] gettagorigin("tag_flash"), level.intro_balcony_guy gettagorigin("j_head"));

  wait 1.5;

  if(isDefined(level.intro_keegandrag_guy) && isalive(level.intro_keegandrag_guy))
    magicbullet(level.allies[1].weapon, level.allies[0] gettagorigin("tag_flash"), level.intro_keegandrag_guy gettagorigin("j_head"));
}

handle_radio_alert() {
  self.dropweapon = 0;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.diequietly = 1;
  self.health = 1;
  thread handle_radio_tower_kill();
}

handle_tower_alert() {
  self.dropweapon = 0;
  self.health = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.diequietly = 1;
  self.reactingtobullet = 0;
  self.disablebulletwhizbyreaction = 1;
  self.disable_dive_whizby_react = 1;
  maps\_utility::gun_remove();

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "tower_player_target")
    thread tower_tapglass_scene("tapglass_enemy_a");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "tower_walkout_guy")
    thread tower_tapglass_scene("tapglass_enemy_b");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "leanrailguy") {
    self.allowdeath = 1;
    self.animname = "leanrailguy";
    level.pre_ambush_scene_org thread maps\_anim::anim_loop_solo(self, "scnleanrailguy");
  }

  thread handle_tower_enemy_provoked_early();
}

tower_tapglass_scene(var_0) {
  self endon("death");
  self endon("start_enemies_provoked_early");
  self.fixednode = 1;
  self.alertlevel = "noncombat";
  self.allowdeath = 1;
  self.animname = "generic";
  level.pre_ambush_scene_org maps\_anim::anim_single_solo(self, var_0);
  self setgoalpos(self.origin);
}

handle_remaining_alert() {
  self.dropweapon = 0;
  var_0 = level.pre_ambush_scene_org;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "spotlight_checkpoint_a") {
    thread kill_on_failsafe();
    common_scripts\utility::flag_wait("FLAG_the_last_guy");

    if(isDefined(self) && isalive(self)) {
      self.animname = "generic";
      var_1 = self;
      self.allowdeath = 1;
      maps\_utility::gun_remove();
      thread kill_crate_guy();
      level.pre_ambush_scene_org thread maps\_anim::anim_single_solo(self, "spotlight_enemy_a");
      var_2 = maps\_utility::spawn_anim_model("cp_ammo_jt", var_0.origin);
      var_3 = maps\_utility::spawn_anim_model("cp_ammo_mdl", var_0.origin);
      var_3 linkto(var_2, "J_prop_1");
      var_4 = maps\_utility::spawn_anim_model("cp_ammo_mdl", var_0.origin);
      var_4 linkto(var_2, "J_prop_2");
      var_0 thread maps\_anim::anim_single_solo(var_2, "cp_ammo_joint");
      var_2 thread ammo_crate_failsafe(var_1, var_3, var_4);
    }
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "spotlight_checkpoint_b") {
    thread kill_checkpointb_guy();
    thread handle_spotlight_enemy_b();
    thread kill_on_failsafe();
  }

  if(isDefined(self) && isalive(self)) {
    self.alertlevel = "noncombat";
    self.ignoreme = 1;
    self.ignoreall = 1;
    self.ignoreexplosionevents = 1;
    self.grenadeawareness = 0;
    self.badplaceawareness = 0;
    self.a.nodeath = 0;
    maps\_utility::set_allowdeath(1);
    thread handle_remaining_enemy_provoked_early();
  }
}

kill_crate_guy() {
  self waittill("damage");

  if(isDefined(self) && isalive(self))
    magicbullet(level.allies[2].weapon, level.allies[2] gettagorigin("tag_flash"), self gettagorigin("j_head"));

  if(isDefined(self) && isalive(self))
    self kill();
}

kill_checkpointb_guy() {
  self waittill("damage");

  if(isDefined(self) && isalive(self))
    magicbullet(level.allies[1].weapon, level.allies[1] gettagorigin("tag_flash"), self gettagorigin("j_head"));

  if(isDefined(self) && isalive(self))
    self kill();
}

kill_on_failsafe() {
  common_scripts\utility::flag_wait_any("start_enemies_provoked_early", "checkpoint_player_picks_target");
  wait(randomintrange(1, 2));

  if(isDefined(self) && isalive(self))
    magicbullet(level.allies[2].weapon, level.allies[2] gettagorigin("tag_flash"), self gettagorigin("j_head"));

  wait 1;

  if(isDefined(self) && isalive(self))
    self kill();
}

ammo_crate_failsafe(var_0, var_1, var_2) {
  common_scripts\utility::flag_wait("drop_ammo_crates");
  maps\_utility::anim_stopanimscripted();
  var_0 maps\_utility::anim_stopanimscripted();
  var_3 = randomfloatrange(10, 100);
  var_4 = vectornormalize(var_1.origin - 1 - var_1.origin);
  var_1 unlink();
  var_1 physicslaunchclient(var_1.origin, var_4 * var_3);
  var_5 = vectornormalize(var_2.origin - 1 - var_2.origin);
  var_2 unlink();
  var_2 physicslaunchclient(var_2.origin, var_5 * var_3);
}

handle_spotlight_enemy_b() {
  self endon("death");
  var_0 = level.pre_ambush_scene_org;
  self.animname = "generic";
  var_0 thread maps\_anim::anim_loop_solo(self, "spotlight_enemy_b_loop", "stop_spotlight_enemy_b_loop");
  var_1 = maps\_utility::spawn_anim_model("cp_light_jt", var_0.origin);
  var_2 = maps\_utility::spawn_anim_model("cp_light_mdl", var_0.origin);
  var_2 linkto(var_1, "J_prop_2");
  var_0 thread maps\_anim::anim_first_frame_solo(var_1, "cp_light_joint");
  common_scripts\utility::flag_wait("start_spotlight_b");
  var_0 notify("stop_spotlight_enemy_b_loop");
  var_3 = getent("clip_checkpoint_searchlight", "targetname");
  var_3 linkto(var_2);

  if(isDefined(self) && isalive(self)) {
    var_0 thread maps\_anim::anim_single_solo(self, "spotlight_enemy_b");
    thread stop_spotlight_provoked(self, var_0, var_1, "cp_light_joint");
    thread stop_spotlight_killed(self, var_0, var_1, "cp_light_joint");
    var_0 maps\_anim::anim_single_solo(var_1, "cp_light_joint");
    var_0 notify("spotlight_move_done");
  }
}

stop_spotlight_provoked(var_0, var_1, var_2, var_3) {
  var_1 endon("spotlight_move_done");
  common_scripts\utility::flag_wait("start_enemies_provoked_early");
  var_1 maps\_anim::anim_set_rate_single(var_2, var_3, 0);
  var_1 notify("spotlight_move_done");
}

stop_spotlight_killed(var_0, var_1, var_2, var_3) {
  var_1 endon("spotlight_move_done");
  var_0 waittill("damage");
  var_1 maps\_anim::anim_set_rate_single(var_2, var_3, 0);
  var_1 notify("spotlight_move_done");
}

alert_enemies() {
  self endon("death");
  maps\_utility::clear_run_anim();
  self.animname = "generic";
  var_0 = level.ambush_recover_anim[randomint(level.ambush_recover_anim.size)];

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "checkpoint_patrollers") {
    maps\_utility::cqb_walk("on");
    self waittill("goal");
    thread maps\_anim::anim_single_solo(self, var_0);
    maps\_utility::set_allowdeath(1);
    self waittillmatch("anim single", "end");
    thread maps\_anim::anim_loop_solo(self, "nvg_recover_anim1");
  } else {
    maps\_utility::set_allowdeath(1);
    self waittillmatch("anim single", "end");
    thread maps\_anim::anim_loop_solo(self, "nvg_recover_anim1");
  }

  wait 2;
  self.baseaccuracy = 1;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.grenadeawareness = 0;
  maps\_utility::set_moveplaybackrate(1);
  level.player maps\_utility::set_ignoreme(0);
  self.ignoreall = 0;
  self.disablearrivals = 0;
  self.disableexits = 0;
}

alert_enemies_early() {
  self endon("death");
  maps\_utility::anim_stopanimscripted();
  wait(randomfloatrange(1.5, 2.5));
  self.baseaccuracy = 1;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.grenadeawareness = 0;
  maps\_utility::set_moveplaybackrate(1);

  foreach(var_1 in level.allies) {
    var_1.ignoreall = 0;
    var_1.ignoreme = 0;
    var_1.accuracy = 0.8;
  }

  wait 3;
  level.player maps\_utility::set_ignoreme(0);
}

handle_tower_enemy_provoked_early() {
  level endon("player_shot_target_on_tower");
  level endon("allies_shot_targets_tower");
  level endon("disable_combat_failsafe");
  self addaieventlistener("grenade danger");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("gunshot");
  self addaieventlistener("explode");
  common_scripts\utility::waittill_any("ai_event", "flashbang");
  wait 0.25;
  common_scripts\utility::flag_set("start_enemies_provoked_early");
  self stopanimscripted();
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.fixednode = 0;
  maps\_utility::gun_recall();
}

someone_please_kill_me_now() {
  level endon("player_shot_target_on_tower");
  level endon("allies_shot_targets_tower");
  level endon("disable_combat_failsafe");
  self waittill("damage");
  common_scripts\utility::flag_set("start_enemies_provoked_early");
}

handle_remaining_enemy_provoked_early() {
  self endon("damage");
  level endon("player_shot_target_on_tower");
  level endon("allies_shot_targets_tower");
  level endon("disable_combat_failsafe");
  self addaieventlistener("grenade danger");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("gunshot");
  self addaieventlistener("explode");
  thread someone_please_kill_me_now();
  common_scripts\utility::waittill_any("ai_event", "flashbang", "death", "going_in_hot");
  common_scripts\utility::flag_set("start_enemies_provoked_early");
  maps\_utility::anim_stopanimscripted();
  self.ignoreall = 0;
  self.ignoreme = 0;
}

spawn_convoy() {
  common_scripts\utility::flag_wait("start_intro_convoy");
  thread maps\clockwork_audio::jeeps_by();
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("convoyjeep1");
  var_0 maps\_vehicle::vehicle_lights_on("headlights");
  wait 2;
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("convoyjeep2");
  var_1 maps\_vehicle::vehicle_lights_on("headlights");
  var_2 = [];
  var_2[0] = var_0;
  var_2[1] = var_1;
  var_0 thread damage_watcher_intro();
  var_0 thread destroy_player_intro();
  var_1 thread damage_watcher_intro();
  var_1 thread destroy_player_intro();
}

prepare_ambush() {
  common_scripts\utility::flag_wait_all("checkpoint_taken2", "keegan_delay_flag_hack");

  foreach(var_1 in level.allies) {
    var_1.ignoreall = 1;
    var_1.ignoreme = 1;
    var_1 maps\_utility::disable_cqbwalk();
  }

  level.player.ignoreme = 1;
  thread obj_bodydrag();
  thread obj_getinjeep();
  thread start_ambush_scene();
  level.allies[0].animname = "baker";
  level.allies[1].animname = "keegan";
  level.allies[2].animname = "cipher";
  maps\clockwork_code::init_animated_dufflebags_candk();
  var_3 = [];
  var_3[0] = level.allies[1];
  var_3[1] = level.allies[2];
  var_4 = [];
  var_4[0] = level.bags[1];
  var_4[1] = level.bags[2];
  thread allies_reach_and_start_scene(level.pre_ambush_scene_org, var_3, "clock_intro", var_4, level.intro_keegandrag_guy, undefined);
}

handle_baker_ambush_anims(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("ambush_player_shot");
  level endon("ambush_player_kill");
  level endon("ambush_keegan_kill");
  level endon("player_knifes_driver");
  var_1 maps\_utility::disable_ai_color();
  var_0 maps\_anim::anim_reach_solo(var_1, var_2);
  thread player_stab_driver();
  thread maps\clockwork_audio::baker_drag_body1();
  var_6 = [];
  var_6[0] = var_1;
  var_6[1] = var_3;
  var_6[0].animname = "baker";
  var_6[1].animname = "baker_bag";

  if(isDefined(var_4))
    var_6 = common_scripts\utility::add_to_array(var_6, var_4);

  var_1 maps\clockwork_code::hide_dufflebag();
  var_0 maps\_anim::anim_single(var_6, "clock_intro");

  if(var_4 == level.intro_balcony_guy)
    level.intro_balcony_guy thread kill_guy_at_end_of_anim();

  if(isDefined(var_5))
    common_scripts\utility::flag_set(var_5);

  var_0 thread maps\_anim::anim_loop_solo(var_1, "clock_ambush_hut_wait", "stop_clock_ambush_hut_wait");
  common_scripts\utility::flag_wait("FLAG_baker_out_of_hut");
  var_0 notify("stop_clock_ambush_hut_wait");
  var_1 maps\_utility::anim_stopanimscripted();
  var_0 maps\_anim::anim_single_solo(var_6[0], "clock_ambush_hut_walkout");
}

allies_reach_and_start_scene(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1[0] thread goto_anim_start_spot(var_2, var_0);
  common_scripts\utility::flag_wait_all("k_reached_ambush_anim", "c_reached_ambush_anim");
  thread failsafe_c_k_bags(var_3);
  var_6 = [];
  var_6 = common_scripts\utility::array_combine(var_1, var_3);

  if(isDefined(var_4)) {
    var_4.animname = "keegandrag";
    var_6 = common_scripts\utility::add_to_array(var_6, var_4);
  }

  var_0 thread maps\_anim::anim_single(var_6, "clock_intro");
  thread maps\clockwork_audio::foley_pre_ambush();
  wait 0.05;

  foreach(var_8 in var_1)
  var_8 maps\clockwork_code::hide_dufflebag();

  level.intro_keegandrag_guy thread kill_guy_at_end_of_anim();

  foreach(var_11 in var_1)
  var_11 thread waittill_end_of_anim_for_loop(var_0, "clock_ambush_wait", "stop_clock_ambush_wait");
}

goto_anim_start_spot(var_0, var_1) {
  var_1 maps\_anim::anim_reach_solo(self, var_0);

  if(self.animname == "keegan") {
    level notify("k_reached_ambush_anim");
    common_scripts\utility::flag_set("k_reached_ambush_anim");
  }

  if(self.animname == "cipher") {
    level notify("c_reached_ambush_anim");
    common_scripts\utility::flag_set("c_reached_ambush_anim");
  }
}

failsafe_c_k_bags(var_0) {
  common_scripts\utility::flag_wait("destroy_player_ambush");

  foreach(var_2 in var_0) {
    var_2 maps\_utility::anim_stopanimscripted();
    var_2 hide();
    var_3 = maps\_utility::spawn_anim_model("keegan_bag", var_2.origin);
    var_3.animname = "keegan_bag";
    var_3.origin = var_2.origin;
    var_4 = randomfloatrange(10, 20);
    var_5 = (0, 0, -1);
    wait 0.05;
    var_3 physicslaunchclient(var_3.origin, var_5 * var_4);
  }
}

waittill_end_of_anim_for_loop(var_0, var_1, var_2) {
  level endon("player_knifes_driver");
  level endon("destroy_player_ambush");
  level endon("ambush_player_shot");
  level endon("ambush_player_kill");
  level endon("ambush_keegan_kill");
  level endon("ambush_scene_start");
  self waittillmatch("single anim", "end");
  var_0 maps\_anim::anim_loop_solo(self, var_1, var_2);
}

kill_guy_at_end_of_anim() {
  self waittillmatch("single anim", "end");
  guy_silent_death();
}

obj_enterbase() {
  common_scripts\utility::flag_wait("FLAG_obj_enterbase");
  var_0 = maps\_utility::obj("enterbase");
  objective_add(var_0, "active", &"CLOCKWORK_OBJ_INTO_BASE");
  objective_current(var_0);
  common_scripts\utility::flag_wait("FLAG_obj_enterbase_complete");
  maps\_utility::objective_complete(var_0);
}

obj_bodydrag() {
  common_scripts\utility::flag_wait("FLAG_obj_bodydrag");
  var_0 = maps\_utility::obj("CleanupCheckpoint");
  var_1 = getent("obj_dragbody", "targetname");
  objective_add(var_0, "active", &"CLOCKWORK_OBJ_CHECKPOINT");
  objective_current(var_0);
  objective_position(var_0, var_1.origin);
  common_scripts\utility::flag_wait("FLAG_obj_bodydrag_complete");

  if(!common_scripts\utility::flag("destroy_player_ambush"))
    maps\_utility::objective_complete(var_0);
}

obj_getinjeep() {
  common_scripts\utility::flag_wait("FLAG_enable_enter_jeep");
  wait 2;
  maps\_utility::enable_trigger_with_targetname("trig_get_in_jeep");
  level notify("enable_look_jeep_door_trigger");
  level.gold_jeep_player_door = spawn("script_model", level.jeep.origin);
  level.gold_jeep_player_door setModel("chinese_brave_warrior_obj_door_back_LE");
  level.gold_jeep_player_door.angles = level.jeep.angles;
  level.gold_jeep_player_door linkto(level.jeep);
  common_scripts\utility::flag_wait("FLAG_obj_getinjeep_complete");
}

obj_stabdriver() {
  var_0 = maps\_utility::obj("stab");
  var_1 = getent("obj_stabdriver", "targetname");
  objective_add(var_0, "current", &"CLOCKWORK_OBJ_DRIVER");
  objective_current(var_0);
  thread complete_stabdriver(var_0);
  wait 1.75;
  objective_position(var_0, var_1.origin);
}

complete_stabdriver(var_0) {
  level common_scripts\utility::waittill_any("ambush_player_shot", "ambush_player_kill", "ambush_keegan_kill", "player_knifes_driver", "ambush_scene_start");
  maps\_utility::objective_complete(var_0);
}

spawn_ambush_vehicles() {
  common_scripts\utility::flag_wait("FLAG_baker_bodydrag_complete");
  level.save_aianims = level.vehicle_aianims["script_vehicle_warrior"];
  level.vehicle_aianims["script_vehicle_warrior"][0].death = undefined;
  level.jeep = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_jeep");
  level.jeep hidepart("back_door_left_jnt");
  wait 0.25;
  level.player_door = maps\_utility::spawn_anim_model("jeep_left_door");
  level.player_door linkto(level.jeep, "body_animate_jnt", (0, 0, 0), (0, 0, 0));
  level.jeep2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_jeep2");
  level.jeep maps\_vehicle::vehicle_lights_on("headlights");
  level.jeep2 maps\_vehicle::vehicle_lights_on("headlights");
  level.jeep maps\_vehicle::godon();
  level.jeep2 maps\_vehicle::godon();
  spawn_jeep_riders();
  spawn_jeep2_riders();
  thread maps\clockwork_audio::vehicles_approaching();
  wait 2;
  level.btr_ambush = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_btr_ambush");
  level.btr_ambush maps\_vehicle::vehicle_lights_on("running");
  level.btr_ambush maps\_vehicle::godon();
  level.btr_ambush maps\_vehicle_code::_mgoff();
  level.btr_ambush thread btr_look_logic();
  var_0 = [];
  var_0[0] = level.jeep;
  var_0[1] = level.btr_ambush;
  var_0[2] = level.jeep2;
  thread notify_ambush_destroy_player_off();
  common_scripts\utility::array_thread(level.ambush_enemies, ::damage_watcher_ambush, "ambush_destroy_player_off");
  common_scripts\utility::array_thread(var_0, ::damage_watcher_ambush, "ambush_destroy_player_off");
  common_scripts\utility::array_thread(var_0, ::destroy_player_ambush);
  thread fail_mission_ambush();
  thread bullet_watcher_ambush_failsafe();
  thread destroy_player_ambush_vo();
  thread handle_grenade_thrown_failcase();
}

ambush_jeep2_guy_wave(var_0) {
  level endon("destroy_player_ambush");
  common_scripts\utility::flag_wait("FLAG_baker_out_of_hut");
  var_0 maps\_anim::anim_single_solo(self, "ambush_jeep2_passenger_wave", "tag_passenger");
}

guy_silent_death(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    maps\_utility::stop_magic_bullet_shield();

  self.a.nodeath = 1;
  maps\_utility::set_allowdeath(1);
  maps\_utility::die();
}

swap_head(var_0) {
  wait 2;
  self detach(self.headmodel, "");
  self attach(var_0, "", 1);
  self.headmodel = var_0;
}

spawn_jeep_riders() {
  level.jeep.dontunloadonend = 1;
  level.ambush_jeep_driver = getent("ambush_jeep_driver", "targetname") maps\_utility::spawn_ai(1);
  level.ambush_jeep_driver maps\_utility::magic_bullet_shield();
  level.ambush_jeep_driver maps\_utility::gun_remove();
  level.ambush_jeep_driver.animname = "ambush_jeep_driver";
  level.ambush_jeep_driver.script_startingposition = 0;
  level.jeep thread maps\_vehicle_aianim::guy_enter(level.ambush_jeep_driver);
  level.ambush_jeep_driver thread swap_head("head_fed_army_c_arctic");
  level.ambush_jeep_passenger = getent("ambush_jeep_passenger", "targetname") maps\_utility::spawn_ai(1);
  level.ambush_jeep_passenger maps\_utility::magic_bullet_shield();
  level.ambush_jeep_passenger maps\_utility::gun_remove();
  level.ambush_jeep_passenger.animname = "ambush_jeep_passenger";
  level.ambush_jeep_passenger.script_startingposition = 1;
  level.jeep thread maps\_vehicle_aianim::guy_enter(level.ambush_jeep_passenger);
  level.ambush_jeep_passenger thread swap_head("head_fed_army_a_arctic");
  level.ambush_enemies = [];
  level.ambush_enemies[0] = level.ambush_jeep_driver;
  level.ambush_enemies[1] = level.ambush_jeep_passenger;
}

spawn_jeep2_riders() {
  level.jeep2.dontunloadonend = 1;
  level.ambush_jeep2_driver = getent("ambush_jeep2_driver", "targetname") maps\_utility::spawn_ai(1);
  level.ambush_jeep2_driver maps\_utility::gun_remove();
  level.ambush_jeep2_driver.animname = "ambush_jeep2_driver";
  level.ambush_jeep2_driver.script_startingposition = 0;
  level.jeep2 thread maps\_vehicle_aianim::guy_enter(level.ambush_jeep2_driver);
  level.ambush_jeep2_passenger = getent("ambush_jeep2_passenger", "targetname") maps\_utility::spawn_ai(1);
  level.ambush_jeep2_passenger maps\_utility::gun_remove();
  level.ambush_jeep2_passenger.animname = "ambush_jeep2_passenger";
  level.ambush_jeep2_passenger.script_startingposition = 1;
  level.jeep2 thread maps\_vehicle_aianim::guy_enter(level.ambush_jeep2_passenger);
  level.ambush_jeep2_backr = getent("ambush_jeep2_backR", "targetname") maps\_utility::spawn_ai(1);
  level.ambush_jeep2_backr maps\_utility::gun_remove();
  level.ambush_jeep2_backr.animname = "ambush_jeep2_backR";
  level.ambush_jeep2_backr.script_startingposition = 3;
  level.jeep2 thread maps\_vehicle_aianim::guy_enter(level.ambush_jeep2_backr);
}

handle_player_bodydrag_death() {
  var_0 = level.pre_ambush_scene_org;
  var_1 = getent("intro_bodydrag_enemy", "targetname");
  level.intro_bodydrag_guy = var_1 maps\_utility::spawn_ai(1);
  level.intro_bodydrag_guy.animname = "playerdrag";
  level.intro_bodydrag_guy.allowdeath = 1;
  level.intro_bodydrag_guy.nodrop = 1;
  var_2 = maps\_utility::spawn_anim_model("cp_key_jt", var_0.origin);
  var_3 = maps\_utility::spawn_anim_model("cp_key_mdl", var_0.origin);
  var_3 linkto(var_2, "J_prop_1");
  var_2 thread key_failsafe(var_3);
  var_0 thread maps\_anim::anim_single_solo(var_2, "cp_key_joint");
  level.pre_ambush_scene_org thread maps\_anim::anim_single_solo(level.intro_bodydrag_guy, "keytoss_enemy_b");
  level.intro_bodydrag_guy thread player_bodydrag_damage_watcher();
  level.intro_bodydrag_guy.dontmelee = 1;
  level.special_death_guys[1] = level.intro_bodydrag_guy;
  level.special_death_guys[1].special_case = 1;
  level common_scripts\utility::waittill_any("player_shot_someone_in_remaining", "going_in_hot");

  if(isDefined(level.intro_bodydrag_guy) && isalive(level.intro_bodydrag_guy)) {
    level.intro_bodydrag_guy.ignoreall = 0;
    level.intro_bodydrag_guy.ignoreme = 0;
  }

  wait 3;

  if(isDefined(level.intro_bodydrag_guy) && isalive(level.intro_bodydrag_guy))
    magicbullet(level.allies[2].weapon, level.allies[2] gettagorigin("tag_flash"), level.intro_bodydrag_guy gettagorigin("j_head"));
}

key_failsafe(var_0) {
  common_scripts\utility::flag_wait_any("start_enemies_provoked_early", "bodydrag1_fakedead", "bodydrag2_fakedead");
  maps\_utility::anim_stopanimscripted();
  var_1 = randomfloatrange(10, 100);
  var_2 = vectornormalize(var_0.origin - 1 - var_0.origin);
  var_0 unlink();
  var_0 physicslaunchclient(var_0.origin, var_2 * var_1);
  var_0 delete();
}

player_bodydrag_damage_watcher() {
  self.health = 999;
  self.delete_on_death = 0;
  self.dontdonotetracks = 1;
  self.allowdeath = 0;
  self.allowpain = 0;
  self.no_pain_sound = 1;
  self.diequietly = 1;
  self.a.nodeath = 1;
  self.noragdoll = 1;
  self.nocorpsedelete = 1;
  self.no_dog_target = 1;
  self waittill("damage");

  if(!common_scripts\utility::flag("FLAG_take_the_rest"))
    common_scripts\utility::flag_set("start_enemies_provoked_early");

  thread handle_backpack_objective();
  self.dontevershoot = 1;
  self.ignoreme = 1;
  self setcontents(0);
  maps\_utility::gun_remove();
  self.fake_dead = 1;
  common_scripts\utility::flag_set("bodydrag1_fakedead");
  self.animname = "playerdrag";
  level.pre_ambush_scene_org maps\_anim::anim_single_solo(self, "clock_bodydrag_death");
  self.team = "neutral";
  level.pre_ambush_scene_org maps\_anim::anim_first_frame_solo(self, "clock_bodydrag_drag");
  thread player_body_drag();
}

handle_backpack_objective() {
  var_0 = maps\_utility::spawn_anim_model("backpack");
  var_0 hide();
  level.pre_ambush_scene_org maps\_anim::anim_first_frame_solo(var_0, "clock_bodydrag_drag");
  common_scripts\utility::flag_wait("FLAG_obj_bodydrag");
  var_0 show();
  level waittill("player_triggered_body_drag");
  var_0 delete();
}

handle_keegandrag_death() {
  var_0 = getent("intro_bodydrag2_enemy", "targetname");
  level.intro_keegandrag_guy = var_0 maps\_utility::spawn_ai(1);
  level.intro_keegandrag_guy.animname = "keegandrag";
  level.intro_keegandrag_guy.allowdeath = 1;
  level.intro_keegandrag_guy.nodrop = 1;
  level.pre_ambush_scene_org thread maps\_anim::anim_single_solo(level.intro_keegandrag_guy, "keytoss_enemy_a");
  level.intro_keegandrag_guy thread keegandrag_death_damage_watcher();
  level.intro_keegandrag_guy.dontmelee = 1;
  level.special_death_guys[2] = level.intro_keegandrag_guy;
  level.special_death_guys[2].special_case = 1;
  level common_scripts\utility::waittill_any("player_shot_someone_in_remaining", "going_in_hot");

  if(isDefined(level.intro_keegandrag_guy) && isalive(level.intro_keegandrag_guy)) {
    level.intro_keegandrag_guy.ignoreall = 0;
    level.intro_keegandrag_guy.ignoreme = 0;
  }

  wait 2;

  if(isDefined(level.intro_keegandrag_guy) && isalive(level.intro_keegandrag_guy))
    magicbullet(level.allies[1].weapon, level.allies[1] gettagorigin("tag_flash"), level.intro_keegandrag_guy gettagorigin("j_head"));

  thread keegan_body_door_close();
}

keegan_body_door_close() {
  common_scripts\utility::flag_wait("FLAG_keegan_drag_door");
  var_0 = getent("keegan_body_door_close", "targetname");
  var_0 rotateyaw(-50, 2.5);
}

keegandrag_death_damage_watcher() {
  self.health = 999;
  self.delete_on_death = 0;
  self.dontdonotetracks = 1;
  self.allowdeath = 0;
  self.allowpain = 0;
  self.no_pain_sound = 1;
  self.diequietly = 1;
  self.a.nodeath = 1;
  self.noragdoll = 1;
  self.nocorpsedelete = 1;
  self.grenadeawareness = 0;
  self.no_dog_target = 1;
  self waittill("damage");

  if(!common_scripts\utility::flag("FLAG_take_the_rest"))
    common_scripts\utility::flag_set("start_enemies_provoked_early");

  self.dontevershoot = 1;
  self.ignoreme = 1;
  self setcontents(0);
  maps\_utility::gun_remove();
  self.fake_dead = 1;
  self.no_dog_target = 1;
  common_scripts\utility::flag_set("bodydrag2_fakedead");
  self.animname = "keegandrag";
  level.pre_ambush_scene_org maps\_anim::anim_single_solo(self, "clock_intro_death_guard2");
  level.pre_ambush_scene_org maps\_anim::anim_first_frame_solo(self, "clock_intro");
}

setup_bodydrag_startpoint() {
  thread handle_backpack_objective();
  var_0 = getent("intro_bodydrag_enemy", "targetname");
  level.intro_bodydrag_guy = var_0 maps\_utility::spawn_ai(1);
  level.intro_bodydrag_guy.animname = "playerdrag";
  level.intro_bodydrag_guy.dontmelee = 1;
  level.intro_bodydrag_guy.ignoreme = 1;
  level.intro_bodydrag_guy.ignoreall = 1;
  level.intro_bodydrag_guy setcontents(0);
  level.intro_bodydrag_guy maps\_utility::gun_remove();
  level.pre_ambush_scene_org maps\_anim::anim_first_frame_solo(level.intro_bodydrag_guy, "clock_bodydrag_drag");
  thread player_body_drag();
  var_0 = getent("intro_bodydrag2_enemy", "targetname");
  level.intro_keegandrag_guy = var_0 maps\_utility::spawn_ai(1);
  level.intro_keegandrag_guy.animname = "keegandrag";
  level.intro_keegandrag_guy.dontmelee = 1;
  level.intro_keegandrag_guy.ignoreme = 1;
  level.intro_keegandrag_guy.ignoreall = 1;
  level.intro_keegandrag_guy setcontents(0);
  level.intro_keegandrag_guy maps\_utility::gun_remove();
  level.pre_ambush_scene_org maps\_anim::anim_first_frame_solo(level.intro_keegandrag_guy, "clock_intro");
  var_0 = getent("balcony_death_guy", "targetname");
  level.intro_balcony_guy = var_0 maps\_utility::spawn_ai(1);
  level.intro_balcony_guy.animname = "bakerdrag";
  level.intro_balcony_guy.dontmelee = 1;
  level.intro_balcony_guy.ignoreall = 1;
  level.intro_balcony_guy.ignoreme = 1;
  level.intro_balcony_guy setcontents(0);
  level.intro_balcony_guy.nodrop = 1;
  level.pre_ambush_scene_org maps\_anim::anim_first_frame_solo(level.intro_balcony_guy, "clock_intro");
}

player_body_drag() {
  common_scripts\utility::flag_wait("FLAG_obj_bodydrag");
  thread btr_sees_body();
  var_0 = getent("trig_intro_bodydrag_scene", "targetname");
  var_0 sethintstring(&"CLOCKWORK_HINT_DRAG");
  var_1 = common_scripts\utility::getstruct("body_drag_look_at", "targetname");
  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_0, var_1, undefined, undefined, 1);
  common_scripts\utility::flag_set("FLAG_obj_bodydrag_complete");
  level notify("player_triggered_body_drag");
  level.drag_player_arms = maps\_utility::spawn_anim_model("player_rig");
  level.drag_player_arms hide();
  var_2 = [];
  var_2[0] = level.drag_player_arms;
  var_2[1] = level.intro_bodydrag_guy;
  level.pre_ambush_scene_org maps\_anim::anim_first_frame(var_2, "clock_bodydrag_drag");
  level.player freezecontrols(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player disableweapons();

  if(level.player getstance() != "stand") {
    level.player setstance("stand");
    wait 0.8;
  }

  level.player playerlinktoblend(level.drag_player_arms, "tag_player", 0.6);
  wait 0.6;
  thread maps\clockwork_audio::player_drag_body();
  level.intro_bodydrag_guy.a.nodeath = 1;
  level.intro_bodydrag_guy maps\_utility::set_allowdeath(1);
  level.drag_player_arms show();
  level.pre_ambush_scene_org thread maps\_anim::anim_single(var_2, "clock_bodydrag_drag");
  level.player disableweapons();
  thread maps\clockwork_code::hold_fire_unless_ads("ambush_scene_stab");
  level.intro_bodydrag_guy waittillmatch("single anim", "end");
  common_scripts\utility::waitframe();
  level.player unlink();
  level.drag_player_arms delete();
  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player freezecontrols(0);
  level.intro_bodydrag_guy guy_silent_death();
  level notify("player_hid_barrier_body");
}

btr_sees_body() {
  level endon("player_hid_barrier_body");
  common_scripts\utility::flag_wait("btr_sees_playerdrag_body");
  common_scripts\utility::flag_set("destroy_player_ambush");
}

player_stab_driver() {
  level endon("destroy_player_ambush");
  level endon("ambush_scene_start");
  level endon("ambush_player_kill");
  common_scripts\utility::flag_wait("enable_stab");
  thread obj_stabdriver();
  level notify("enable_stab");
  level.jeep maps\_vehicle::vehicle_stop_named("jeep_ambush_stop", 1, 1);
  wait 0.5;
  level endon("ambush_player_shot");
  level endon("ambush_player_kill");
  level endon("ambush_keegan_kill");
  level.cosine["25"] = cos(25);
  var_0 = maps\_utility::spawn_anim_model("player_rig", level.pre_ambush_scene_org.origin);
  var_0 attach("viewmodel_commando_knife", "TAG_WEAPON_RIGHT");
  var_0 hide();
  level.pre_ambush_scene_org thread maps\_anim::anim_first_frame_solo(var_0, "clock_ambush_end_knife");
  thread stab_enemy_hint();
  thread player_looking_at_stabguy();
  thread waittill_scene_over_enable_weapons();
  waittill_player_triggers_stealth_kill();
  level notify("pre_player_knifes_driver");
  level.player setstance("stand");
  level.player disableweapons();
  level.player playerlinktoblend(var_0, "tag_player", 0.15);
  wait 0.15;

  for(;;) {
    if(level.player ismeleeing()) {
      wait 1;
      break;
    }

    if(level.player isthrowinggrenade()) {
      break;
    }

    break;
  }

  level notify("player_knifes_driver");
  common_scripts\utility::flag_set("ambush_scene_stab");
  level.player notify("player_cancel_hold_fire");
  var_0 show();
  wait 0.15;
  level.pre_ambush_scene_org notify("stop_clock_ambush_wait");
  var_1 = [];
  var_1[0] = var_0;
  var_1[1] = level.ambush_jeep_driver;
  var_1[1] unlink();
  level.pre_ambush_scene_org thread maps\_anim::anim_single(var_1, "clock_ambush_end_knife");
  var_1[1] playSound("enemy_jeep_death");
  level.ambush_jeep_driver thread maps\clockwork_fx::handle_stab_fx();
  level.ambush_jeep_driver thread waittill_clockambush_end_enemies();
  level.ambush_jeep_driver thread waittill_clockambush_driver_dead();
  level.player playerlinktoabsolute(var_0, "tag_player");
  var_0 waittillmatch("single anim", "end");
  level.player unlink();
  var_0 delete();
  level notify("ambush_scene_over");
}

waittill_scene_over_enable_weapons() {
  var_0 = level common_scripts\utility::waittill_any_return("ambush_player_shot", "ambush_player_kill", "ambush_keegan_kill", "player_knifes_driver", "ambush_scene_start");

  if(var_0 == "player_knifes_driver")
    level waittill("ambush_scene_over");

  level.player enableweapons();
  level.player allowmelee(1);
}

player_looking_at_stabguy() {
  level endon("player_knifes_driver");
  level endon("pre_player_knifes_driver");
  level endon("ambush_player_shot");
  level endon("ambush_player_kill");
  level endon("ambush_keegan_kill");
  thread handle_weapon_melee_toggle();
  var_0 = undefined;
  var_1 = getent("trig_player_stab", "script_noteworthy");
  var_2 = getent(var_1.target, "targetname");

  for(;;) {
    wait 0.05;

    if(common_scripts\utility::flag("player_near_stab_guy")) {
      var_0 = common_scripts\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_2.origin, level.cosine["25"]);

      if(var_0)
        common_scripts\utility::flag_set("player_looking_at_stab_guy");
      else
        common_scripts\utility::flag_clear("player_looking_at_stab_guy");

      continue;
    }

    common_scripts\utility::flag_clear("player_looking_at_stab_guy");
  }
}

handle_weapon_melee_toggle() {
  level endon("player_knifes_driver");
  level endon("pre_player_knifes_driver");
  level endon("ambush_player_shot");
  level endon("ambush_player_kill");
  level endon("ambush_keegan_kill");
  level endon("ambush_scene_timeout");
  level endon("ambush_scene_over");

  for(;;) {
    wait 0.05;

    if(common_scripts\utility::flag("player_near_stab_guy")) {
      level.player disableweapons();
      level.player allowmelee(0);
    }

    if(!common_scripts\utility::flag("player_near_stab_guy")) {
      level.player enableweapons();
      level.player allowmelee(1);
    }
  }
}

stab_enemy_hint() {
  level endon("player_knifes_driver");
  level endon("pre_player_knifes_driver");
  level endon("ambush_player_shot");
  level endon("ambush_player_kill");
  level endon("ambush_keegan_kill");
  level endon("ambush_player_timeout");
  var_0 = &"CLOCKWORK_PROMPT_STAB";
  thread stab_enemy_hint_cleanup();

  while(!common_scripts\utility::flag("ambush_scene_stab")) {
    common_scripts\utility::flag_wait("player_looking_at_stab_guy");
    thread maps\_utility::hint(var_0);
    common_scripts\utility::flag_set("player_in_position_for_stab_kill");

    while(common_scripts\utility::flag("player_looking_at_stab_guy"))
      wait 0.05;

    common_scripts\utility::flag_clear("player_in_position_for_stab_kill");
    thread maps\_utility::hint_fade();
  }

  thread maps\_utility::hint_fade();
}

stab_enemy_hint_cleanup() {
  common_scripts\utility::flag_wait_any("ambush_scene_stab", "ambush_scene_shot", "ambush_scene_timeout");
  thread maps\_utility::hint_fade();
}

waittill_player_triggers_stealth_kill() {
  while(!common_scripts\utility::flag("ambush_scene_stab")) {
    wait 0.05;

    if(common_scripts\utility::flag("player_looking_at_stab_guy") && level.player meleebuttonpressed()) {
      break;
    }
  }
}

handle_balcony_death() {
  var_0 = getent("balcony_death_guy", "targetname");
  level.intro_balcony_guy = var_0 maps\_utility::spawn_ai(1);
  level.intro_balcony_guy.animname = "bakerdrag";
  level.intro_balcony_guy.nodrop = 1;
  level.special_death_guys[0] = level.intro_balcony_guy;
  level.special_death_guys[0].special_case = 1;
  level.intro_balcony_guy thread balcony_death_damage_watcher();
  level.intro_balcony_guy.dontmelee = 1;
  level common_scripts\utility::waittill_any("player_shot_someone_in_remaining");
  level.intro_balcony_guy.ignoreall = 0;
  wait 4;

  if(isDefined(level.intro_balcony_guy) && isalive(level.intro_balcony_guy))
    magicbullet(level.allies[0].weapon, level.allies[0] gettagorigin("tag_flash"), level.intro_balcony_guy gettagorigin("j_head"));
}

balcony_death_damage_watcher() {
  self.health = 999;
  self.delete_on_death = 0;
  self.dontdonotetracks = 1;
  self.allowdeath = 0;
  self.allowpain = 0;
  self.no_pain_sound = 1;
  self.diequietly = 1;
  self.a.nodeath = 1;
  self.noragdoll = 1;
  self.nocorpsedelete = 1;
  self.no_dog_target = 1;
  self waittill("damage");

  if(!common_scripts\utility::flag("FLAG_take_the_rest"))
    common_scripts\utility::flag_set("start_enemies_provoked_early");

  self.dontevershoot = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self setcontents(0);
  self.fake_dead = 1;
  common_scripts\utility::flag_set("bodydrag3_fakedead");
  self.animname = "bakerdrag";
  level.pre_ambush_scene_org maps\_anim::anim_single_solo(self, "clock_intro_guy_death");
  level.pre_ambush_scene_org maps\_anim::anim_first_frame_solo(self, "clock_intro");
}

start_ambush_scene() {
  level endon("destroy_player_ambush");
  common_scripts\utility::flag_wait("FLAG_baker_out_of_hut");

  if(!common_scripts\utility::flag("destroy_player_ambush")) {
    thread animate_ambush_scene_enemies();
    level.allies[0].script_startingposition = 1;
    level.allies[1].script_startingposition = 0;
    level.allies[2].script_startingposition = 3;
    level.allies[0].animname = "baker";
    level.allies[1].animname = "keegan";
    level.allies[2].animname = "cipher";
    level waittill("enable_stab");

    foreach(var_1 in level.ambush_enemies)
    var_1 thread ambush_notify_on_player_kill();

    thread ambush_notify_on_player_shot();
    level common_scripts\utility::waittill_any("ambush_player_shot", "ambush_player_kill", "ambush_keegan_kill", "player_knifes_driver", "ambush_scene_start");
    common_scripts\utility::flag_set("ambush_scene_started");
    level.pre_ambush_scene_org notify("stop_clock_ambush_wait");

    if(!common_scripts\utility::flag("destroy_player_ambush")) {
      thread maps\clockwork_audio::foley_post_ambush();
      var_3 = [];
      var_3[0] = level.allies[0];
      var_3[1] = level.allies[2];
      var_3[2] = level.ambush_enemies[1];
      var_3[3] = level.bags[0];
      var_3[4] = level.bags[1];
      var_3[5] = level.bags[2];
      level.jeep.animname = "ambush_jeep";
      level.pre_ambush_scene_org thread maps\_anim::anim_single(var_3, "clock_ambush_end");
      level.jeep.dontunloadonend = 1;

      if(common_scripts\utility::flag("ambush_scene_stab")) {
        level.pre_ambush_scene_org thread maps\_anim::anim_single_solo(level.allies[1], "clock_ambush_end_knife");
        level.pre_ambush_scene_org notify("stop_loop");
        thread vehicle_play_jeep_scripted_anim("clock_ambush_end");
        thread maps\clockwork_audio::ambush_kill_driver_player();
      }

      if(common_scripts\utility::flag("ambush_scene_shot")) {
        level.pre_ambush_scene_org notify("stop_loop");
        common_scripts\utility::flag_set("ambush_scene_stab");
        var_4 = [];
        var_4[0] = level.allies[1];
        var_4[1] = level.ambush_jeep_driver;
        level.pre_ambush_scene_org thread maps\_anim::anim_single_solo(var_4[0], "clock_ambush_end_gunshot");
        level.pre_ambush_scene_org thread maps\_anim::anim_single_solo(var_4[1], "clock_ambush_end_gunshot");
        thread vehicle_play_jeep_scripted_anim("clock_ambush_end_gun");
        var_4[1] thread wait_keegan_drag();
        thread maps\clockwork_audio::ambush_kill_driver_cypher();
        level.allies[1] maps\clockwork_code::char_dialog_add_and_go("clockwork_kgn_goodshot");
      }

      if(common_scripts\utility::flag("ambush_player_timeout")) {
        common_scripts\utility::flag_set("ambush_scene_timeout");
        common_scripts\utility::flag_set("ambush_scene_stab");
        level notify("ambush_scene_timeout");
        level.allies[2] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_cyr_dropem2");
        level.pre_ambush_scene_org notify("stop_loop");
        var_4 = [];
        var_4[0] = level.allies[1];
        var_4[1] = level.ambush_jeep_driver;
        level.pre_ambush_scene_org thread maps\_anim::anim_single_solo(var_4[0], "clock_ambush_end_gunshot");
        thread vehicle_play_jeep_scripted_anim("clock_ambush_end_gun");
        wait 1;
        level.pre_ambush_scene_org thread maps\_anim::anim_single_solo(var_4[1], "clock_ambush_end_gunshot");
        var_4[1] thread wait_keegan_drag();
        thread maps\clockwork_audio::ambush_kill_driver_cypher();
      }

      level.ambush_enemies[1] thread waittill_clockambush_end_enemies();
      common_scripts\utility::flag_set("FLAG_enable_enter_jeep");
      level.allies[0] thread anim_clockambush_finished("bakerambush_finished");
      level.allies[1] thread anim_clockambush_finished("cipherambush_finished");
      level.allies[2] thread anim_clockambush_finished("keeganambush_finished");
      level.bags[0] thread link_bag_to_jeep_after_anim();
      level.bags[1] thread link_bag_to_jeep_after_anim();
      level.bags[2] thread link_bag_to_jeep_after_anim();
      common_scripts\utility::waitframe();

      while(!common_scripts\utility::flag("FLAG_obj_getinjeep_complete")) {
        level.jeep vehicle_setspeed(0, 10);
        wait 0.01;
      }
    }
  }
}

wait_keegan_drag() {
  level endon("destroy_player_ambush");
  wait 1.3;
  self setanim(maps\_utility::getanim("clock_ambush_end_gunshot"), 1.0, 0, 0);
  common_scripts\utility::flag_wait("FLAG_gunshot_drag");
  level.pre_ambush_scene_org thread maps\_anim::anim_single_solo(self, "clock_ambush_end_gunshot_drag");
  waittill_clockambush_end_enemies();
}

animate_ambush_scene_enemies() {
  level endon("ambush_player_shot");
  level endon("ambush_player_kill");
  level endon("ambush_keegan_kill");
  level endon("player_knifes_driver");
  level endon("destroy_player_ambush");
  common_scripts\utility::flag_wait("start_ambush_scene_enemies");

  foreach(var_1 in level.ambush_enemies) {
    var_1.health = 9999;
    var_1.delete_on_death = 0;
    var_1.a.nodeath = 1;
    var_1.allowpain = 1;
    var_1.no_pain_sound = 1;
    var_1.diequietly = 1;
    var_1.dontevershoot = 1;
    var_1.noragdoll = 1;
    var_1.nocorpsedelete = 1;
    var_1.ignoreme = 1;
    var_1 unlink();
  }

  foreach(var_4 in level.ambush_enemies)
  var_4 maps\_utility::anim_stopanimscripted();

  level.jeep notify("stop_loop");
  level.pre_ambush_scene_org maps\_anim::anim_single(level.ambush_enemies, "clock_ambush_start_enemies");
  thread ambush_notify_on_player_timeout(12);

  if(isDefined(level.ambush_enemies[0]) && isalive(level.ambush_enemies[0]))
    level.pre_ambush_scene_org thread maps\_anim::anim_loop_solo(level.ambush_enemies[0], "clock_ambush_wait", "stop_clock_ambush_wait");

  if(isDefined(level.ambush_enemies[1]) && isalive(level.ambush_enemies[1]))
    level.pre_ambush_scene_org thread maps\_anim::anim_loop_solo(level.ambush_enemies[1], "clock_ambush_wait", "stop_clock_ambush_wait");
}

ambush_notify_on_player_timeout(var_0) {
  level endon("ambush_player_shot");
  level endon("ambush_player_kill");
  level endon("ambush_keegan_kill");
  level endon("player_knifes_driver");
  level endon("pre_player_knifes_driver");
  wait(var_0);
  common_scripts\utility::flag_set("ambush_player_timeout");
  level notify("ambush_scene_start");
  wait 1.5;

  if(isDefined(level.ambush_jeep_driver) && isalive(level.ambush_jeep_driver))
    magicbullet(level.allies[2].weapon, level.allies[2] gettagorigin("tag_flash"), level.ambush_jeep_driver gettagorigin("j_head"));

  thread maps\clockwork_audio::ambush_kill_driver_cypher();
}

ambush_notify_on_player_kill() {
  level endon("ambush_player_kill");
  level endon("ambush_keegan_kill");
  level endon("player_knifes_driver");
  self waittill("damage", var_0, var_1);

  if(var_1 == level.player) {
    common_scripts\utility::flag_set("ambush_scene_shot");
    level notify("ambush_player_kill");
  }

  if(var_1 == level.allies[1]) {
    common_scripts\utility::flag_set("ambush_scene_shot");
    level notify("ambush_keegan_kill");
  }
}

ambush_notify_on_player_shot() {
  level endon("ambush_player_kill");
  level endon("ambush_keegan_kill");
  level.player waittill("weapon_fired");
  level notify("ambush_player_shot");
  thread ambush_kill_driver();
}

ambush_kill_driver() {
  if(!common_scripts\utility::flag("start_ambush_scene_enemies"))
    wait 1;

  if(isDefined(level.ambush_jeep_driver) && isalive(level.ambush_jeep_driver)) {
    magicbullet(level.allies[2].weapon, level.allies[2] gettagorigin("tag_flash"), level.ambush_jeep_driver gettagorigin("j_head"));
    common_scripts\utility::flag_set("ambush_scene_shot");
  }
}

waittill_clockambush_end_enemies() {
  self waittillmatch("single anim", "end");
  self.a.nodeath = 1;
  self.allowdeath = 1;
  maps\_utility::stop_magic_bullet_shield();
  maps\_utility::die();
  self unlink();
}

waittill_clockambush_driver_dead() {
  self waittillmatch("single anim", "end");
  common_scripts\utility::exploder("162");
}

anim_clockambush_finished(var_0) {
  level endon("destroy_player_ambush");
  self waittillmatch("single anim", "end");
  common_scripts\utility::flag_set(var_0);
  var_1 = maps\_vehicle_aianim::anim_pos(level.jeep, self.script_startingposition);
  self linkto(level.jeep, var_1.sittag, (0, 0, 0), (0, 0, 0));
  thread maps\_anim::anim_loop_solo(self, "jeep_idle", "stop_idle");
}

vehicle_play_guy_anim(var_0, var_1, var_2, var_3, var_4) {
  var_1 notify("stop_idle");
  var_1 notify("stop_anim");
  var_1 endon("stop_anim");
  var_1 maps\_anim::anim_single_solo(var_1, var_0);

  if(isDefined(var_3) && !var_3) {
    if(isDefined(var_4) && var_4)
      self unlink();

    self notify("vehicle_play_guy_anim_complete");
    return;
  }

  var_1 thread maps\_anim::anim_loop_solo(var_1, "jeep_idle", "stop_idle");
}

link_bag_to_jeep_after_anim() {
  self waittillmatch("single anim", "end");
  self linkto(level.jeep);
  common_scripts\utility::flag_wait("jeep_intro_ride_done");
  self delete();
}

intro_ambush_vo() {
  level endon("player_knifes_driver");
  level endon("ambush_player_shot");
  level endon("ambush_player_kill");
  level endon("ambush_keegan_kill");
  level endon("destroy_player_ambush");

  if(common_scripts\utility::flag("start_enemies_provoked_early"))
    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_beencleaner");
  else
    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_nicejob");

  common_scripts\utility::flag_wait("checkpoint_taken2");
  wait 0.5;
  common_scripts\utility::flag_set("FLAG_obj_bodydrag");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_clearthatbody");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_intheback");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_wherespatrol");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_diz_headedyourway");
  common_scripts\utility::flag_wait("FLAG_baker_bodydrag_complete");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_diz_patrolinbound");
  level.allies[1] maps\clockwork_code::char_dialog_add_and_go("clockwork_kgn_showtime");
  level.allies[2] maps\clockwork_code::char_dialog_add_and_go("clockwork_cyr_betterwork");
  wait 5;
  level.allies[2] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_letthebtrpass");
  common_scripts\utility::flag_set("FLAG_let_btr_pass");
  level waittill("enable_stab");
  thread get_in_jeep_nag_vo();
  wait 1.75;
  level.allies[2] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_cyr_gotthedriver");
  common_scripts\utility::flag_set("ambush_destroy_player_off");
  thread bullet_watcher_ambush();
  wait 6;
  level.allies[2] maps\clockwork_code::char_dialog_add_and_go("clockwork_cyr_movein");
  wait 3;
  level.allies[2] maps\clockwork_code::char_dialog_add_and_go("clockwork_cyr_takeoutdriver");
}

get_in_jeep_nag_vo() {
  level endon("player_in_jeep");
  common_scripts\utility::flag_wait("bakerambush_finished");

  for(;;) {
    wait 5;
    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_wastingtime");
    wait 9;
    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_timetogo");
    wait 15;
    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_rookgetin");
    wait 15;
  }
}

intro_drive() {
  var_0 = 66;
  level waittill("enable_look_jeep_door_trigger");
  var_1 = getent("trig_get_in_jeep", "targetname");
  var_1 sethintstring(&"CLOCKWORK_HINT_VEHICLE");
  var_2 = spawnStruct();
  var_2.origin = (-38223, 9545, 3545);
  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_1, var_2, undefined, undefined, 1);
  common_scripts\utility::flag_set("start_intro_drive");
  level.player freezecontrols(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player disableweapons();
  level.player allowads(0);
  level.frag_ammo = level.player getweaponammostock("fraggrenade");
  level.flash_ammo = level.player getweaponammostock("flash_grenade");
  level.player takeweapon("fraggrenade");
  level.player takeweapon("flash_grenade");

  if(level.player getstance() != "stand") {
    level.player setstance("stand");
    wait 0.8;
  }

  level notify("player_in_jeep");
  thread maps\clockwork_interior::spin_fans("introdrive_finished");
  thread maps\_utility::autosave_by_name("jeep_drive_intro");
  thread maps\clockwork_audio::enter_jeep();
  thread maps\clockwork_interior_nvg::handle_tunnel_ambience();
  thread spawn_enemy_road_jeep();
  thread entrance_drones();

  foreach(var_4 in level.allies)
  var_4.alertlevel = "noncombat";

  level.gold_jeep_player_door delete();
  level.jeep_player_arms = maps\_utility::spawn_anim_model("player_rig");
  level.jeep_player_arms hide();
  var_6[0] = level.player_door;
  var_6[0].animname = "jeep_left_door";
  var_7[0] = level.jeep_player_arms;
  var_7[1] = maps\_utility::spawn_anim_model("player_bag");
  var_7[1] hide();
  level.jeep_player_arms linkto(level.jeep, "tag_guy0", (50, 0, 0), (0, 0, 0));
  level.jeep thread maps\_anim::anim_single_solo(level.jeep_player_arms, "ambush_jeep_enter_player", "tag_guy0");
  common_scripts\utility::waitframe();
  level.jeep_player_arms setanim(level.scr_anim[level.jeep_player_arms.animname]["ambush_jeep_enter_player"], 1.0, 0, 0);
  level.player playerlinktoblend(level.jeep_player_arms, "tag_player", 0.6);
  wait 0.6;
  restore_grenade_weapons();
  level.player_door thread maps\_anim::anim_single_solo(level.player_door, "ambush_jeep_enter_player");
  level.jeep thread maps\_anim::anim_single(var_7, "ambush_jeep_enter_player", "tag_guy0");
  level.jeep_player_arms show();
  wait 0.5;
  var_7[1] show();
  level.jeep_player_arms waittillmatch("single anim", "end");
  level.player freezecontrols(0);
  level.jeep_player_arms hide();
  var_7[1] linkto(level.jeep);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player playerlinktodelta(level.jeep_player_arms, "tag_player", 1, 130, 130, 40, 15);
  common_scripts\utility::flag_set("FLAG_obj_getinjeep_complete");
  common_scripts\utility::flag_wait_all("bakerambush_finished", "cipherambush_finished", "keeganambush_finished", "FLAG_obj_getinjeep_complete");
  level.vehicle_aianims["script_vehicle_warrior"] = level.save_aianims;
  wait 1;
  thread maps\clockwork_audio::vehicle_player_01();
  thread maps\clockwork_fx::turn_effects_on("tubelight_parking", "fx/lights/lights_flourescent");
  thread maps\clockwork_interior_nvg::nvg_area_lights_on_fx();
  common_scripts\utility::exploder(100);
  common_scripts\utility::exploder(300);
  common_scripts\utility::exploder(850);
  level.jeep.attachedpath = undefined;
  level.jeep notify("newpath");
  level.jeep stopanimscripted();
  var_8 = getvehiclenode("intro_road_path", "targetname");
  level.jeep thread maps\_vehicle::vehicle_paths(var_8);
  level.jeep startpath(var_8);
  level.jeep vehicle_setspeed(30, 4, 4);
  level.jeep resumespeed(3);
  level.allies[1].animname = "keegan";
  level.allies[2].animname = "cipher";
  wait 0.3;
  level.jeep thread vehicle_play_guy_anim("clockwork_jeep_bloodwipe", level.allies[0], 1, 1);
  level.jeep thread vehicle_play_guy_anim("clockwork_jeep_bloodwipe", level.allies[1], 0, 1);
  level.jeep thread vehicle_play_guy_anim("clockwork_jeep_bloodwipe", level.allies[2], 3, 1);
  wait 2.5;
  common_scripts\utility::flag_wait("start_watchsync_vo");
  maps\_utility::stop_exploder(2000);
  thread allies_jeep_sync_anim();
  thread blackout_timer(70, &"CLOCKWORK_POWERDOWN", 1, 0);
  thread maps\clockwork_interior_nvg::init_tunnel();
  wait 4;
  level.jeep thread vehicle_play_guy_anim("clockwork_jeep_lookout", level.allies[2], 3, 1);
  wait 1.5;
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_els_copyactualblackbirdis");
  thread enter_blackbird_vo();
  level.jeep thread vehicle_play_guy_anim("clockwork_jeep_guncheck", level.allies[2], 3, 1);
  level.jeep vehicle_play_guy_anim("clockwork_jeep_ack", level.allies[0], 1, 0);
  level.jeep thread vehicle_play_guy_anim("clockwork_jeep_blackbird", level.allies[0], 1, 1);
  thread exit_jeep_anims();
  common_scripts\utility::flag_wait("introdrive_finished");
  thread maps\_utility::autosave_by_name("jeep_drive_exit");
  var_7[1] delete();
}

enter_blackbird_vo() {
  common_scripts\utility::flag_wait("entering_blackbird_vo");
  wait 2;
  level.jeep_player_arms.angles = (0, 0, 0);
  level.player lerpviewangleclamp(2.0, 0.25, 0.25, 41, 115, 40, 15);
}

restore_grenade_weapons() {
  if(level.woof) {
    return;
  }
  level.player giveweapon("fraggrenade");
  level.player giveweapon("flash_grenade");
  level.player setweaponammostock("fraggrenade", level.frag_ammo);
  level.player setweaponammostock("flash_grenade", level.flash_ammo);
}

spawn_enemy_road_jeep() {
  common_scripts\utility::flag_wait("enemy_road_jeep");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_enemy_gaz");
  var_0 maps\_vehicle::vehicle_lights_on("headlights");
  common_scripts\utility::flag_wait("FLAG_keegan_wave_jeep");
}

allies_jeep_sync_anim() {
  level.jeep thread vehicle_play_guy_anim("clockwork_jeep_sync", level.allies[0], 1, 1);
  level.jeep vehicle_play_guy_anim("clockwork_jeep_sync", level.allies[1], 0, 0);
  level.jeep vehicle_play_guy_anim("clockwork_jeep_wave", level.allies[1], 0, 1);
}

vehicle_play_jeep_anim(var_0) {
  level.jeep stopanimscripted();
  var_1 = getanimlength(level.scr_anim[level.jeep.animname][var_0]);
  level.jeep setflaggedanim("jeep_anim", level.scr_anim[level.jeep.animname][var_0]);
  wait(var_1);
  level.jeep clearanim(level.scr_anim[level.jeep.animname][var_0], 0.2);
}

vehicle_play_jeep_scripted_anim(var_0) {
  var_1 = getanimlength(level.scr_anim[level.jeep.animname][var_0]);
  level.jeep thread maps\_anim::anim_single_solo(level.jeep, var_0);
  wait(var_1 - 0.1);
  level.jeep maps\_anim::anim_set_rate_single(level.jeep, var_0, 0);
}

ally_push_player_after_unload() {
  self endon("death");
  common_scripts\utility::waittill_either("jumpedout", "vehicle_play_guy_anim_complete");
  common_scripts\utility::waitframe();
  self pushplayer(1);
}

#using_animtree("generic_human");

exit_jeep_anims() {
  common_scripts\utility::flag_wait("jeep_intro_ride_done");
  level.jeep maps\_vehicle::vehicle_stop_named("jeep_intro_ride_done", 1, 1);
  wait 1;

  if(isDefined(level.start_point) && level.start_point == "interior") {
    level.allies[0].get_out_override = % clockwork_garage_arrival_baker;
    level.allies[1].get_out_override = % clockwork_garage_arrival_keegan;
    level.allies[2].get_out_override = % clockwork_garage_arrival_cypher;
    level.jeep maps\_vehicle::vehicle_unload();
  } else {
    foreach(var_1 in level.allies)
    var_1 thread vehicle_play_guy_anim("clockwork_garage_arrival", var_1, 0, 0, 1);
  }

  common_scripts\utility::flag_set("introdrive_finished");
  thread player_exit_jeep();
  level.allies[0].animname = "baker";
  level.allies[1].animname = "keegan";
  level.allies[2].animname = "cipher";

  foreach(var_1 in level.allies)
  var_1 maps\_utility::gun_recall();

  level.jeep.animname = "garage_arrival_jeep";
  thread vehicle_play_jeep_scripted_anim("clockwork_garage_arrival");

  if(!isDefined(level.player_door))
    level.player_door = maps\_utility::spawn_anim_model("jeep_left_door");

  level.player_door thread maps\_anim::anim_single_solo(level.player_door, "clockwork_garage_arrival");

  foreach(var_6 in level.allies) {
    var_6 maps\_utility::enable_ai_color();
    var_6 thread ally_push_player_after_unload();
  }

  level.player.ignoreme = 0;

  foreach(var_6 in level.allies) {
    var_6.ignoresuppression = 1;
    var_6.ignorerandombulletdamage = 1;
    var_6.ignoreexplosionevents = 1;
    var_6.disablebulletwhizbyreaction = 1;
    var_6.disablefriendlyfirereaction = 1;
    var_6.ignoreme = 0;
    var_6.disableplayeradsloscheck = 1;
  }

  maps\clockwork_code::show_dufflebags();
  thread maps\clockwork_interior_nvg::handle_lights_out_approach();
  thread handle_dog_leaving_jeep();
  wait 10;
  common_scripts\utility::flag_set("start_nvg_guy_anims");
  common_scripts\utility::flag_set("start_closing_vault_door");
}

handle_dog_leaving_jeep() {
  if(!level.woof) {
    return;
  }
  common_scripts\utility::flag_wait("FLAG_player_getout_jeep");
  wait 2;
  level.jeep notify("stop_dog_loop");
  level.dog unlink();
  level.dog stopanimscripted();
  var_0 = common_scripts\utility::getstruct("interior_dog", "targetname");
  level.dog forceteleport(var_0.origin, var_0.angles);
  maps\_utility::delaythread(7, maps\clockwork_code::safe_activate_trigger_with_targetname, "no_dog_left_behind");
  thread maps\clockwork_code::dog_walk_until_flag("nvgs_on");
}

player_exit_jeep() {
  common_scripts\utility::flag_wait("FLAG_player_getout_jeep");
  level.player disableweapons();
  var_0 = maps\_utility::spawn_anim_model("player_rig", level.jeep.origin);
  level.player_rig = var_0;
  level.player_rig hide();
  var_1 = maps\_utility::spawn_anim_model("player_bag");
  thread maps\clockwork_audio::exit_jeep();
  maps\_utility::stop_exploder(150);
  maps\_utility::stop_exploder(100);
  maps\_utility::stop_exploder(850);
  var_2[0] = var_0;
  var_2[1] = var_1;
  var_2[1].animname = "player_bag";
  level.player_rig show();
  level.player playerlinktoabsolute(level.player_rig, "tag_player", 1);
  level.jeep thread maps\_anim::anim_first_frame(var_2, "intro_jeep_exit_player");
  level.jeep thread maps\_anim::anim_single(var_2, "intro_jeep_exit_player");

  if(!common_scripts\utility::flag("interior_start_point"))
    level.player playerlinktoblend(level.player_rig, "tag_player", 1);

  level.player_rig waittillmatch("single anim", "end");
  level.player unlink();
  level.player_rig delete();
  var_1 delete();
  thread maps\clockwork_code::hold_fire_unless_ads("nvgs_on");
  wait 0.8;
  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowads(1);
  level.player allowsprint(0);
  level.player allowjump(0);
  thread maps\clockwork_interior_nvg::player_failcase_leave_garage();
}

checkpoint_patrol(var_0) {
  self endon("death");
  self.ignoreall = var_0;
  self.disablearrivals = var_0;
  self.disableexits = var_0;
  self.animname = "generic";
  var_1 = level.checkpoint_patrol_anim[1];
  maps\_utility::set_run_anim(var_1);
  thread disable_checkpoint_patrol();
}

disable_checkpoint_patrol() {
  self endon("death");
  common_scripts\utility::flag_wait_any("start_enemies_provoked_early", "start_enemies_weaponsfree");
  wait 3;
  self.ignoreall = 0;
  self.disablearrivals = 0;
  self.disableexits = 0;
  maps\_utility::clear_run_anim();
}

damage_watcher_intro() {
  self endon("death");
  self waittill("damage");
  common_scripts\utility::flag_set("destroy_player_intro");
}

damage_watcher_ambush(var_0) {
  self endon("death");

  if(isDefined(var_0))
    level endon(var_0);

  self waittill("damage", var_1, var_2);

  if(var_2 == level.player) {
    common_scripts\utility::flag_set("destroy_player_ambush");
    level notify("destroy_player_ambush");
  }
}

bullet_watcher_ambush_failsafe() {
  level endon("ambush_destroy_player_off");
  level.player common_scripts\utility::waittill_either("weapon_fired", "grenade_fire");
  common_scripts\utility::flag_set("destroy_player_ambush");
  level notify("destroy_player_ambush");
}

bullet_watcher_ambush() {
  level endon("pre_player_knifes_driver");
  level.player common_scripts\utility::waittill_either("weapon_fired", "grenade_fire");
  common_scripts\utility::flag_set("ambush_scene_shot");
  level notify("ambush_player_shot");
}

destroy_player_intro() {
  self endon("death");
  common_scripts\utility::flag_wait("destroy_player_intro");
  wait 1;
  self.ignoreall = 0;
  level.player.ignoreme = 0;
  self vehicle_setspeed(0, randomintrange(5, 35));

  if(self.vehicletype == "gaz_tigr_turret_physics") {
    wait 1;
    maps\_vehicle::vehicle_unload();
  }

  if(self.vehicletype == "btr80") {
    wait 3;
    btr_fire_logic();
  }

  if(self.vehicletype == "humvee") {
    wait 1;
    maps\_vehicle::vehicle_unload();
  }

  wait 3;
  mission_failed_intro();
}

destroy_player_ambush() {
  self endon("death");
  level endon("ambush_destroy_player_off");
  common_scripts\utility::flag_wait("destroy_player_ambush");
  level notify("destroy_player_ambush");
  self.ignoreall = 0;
  level.player.ignoreme = 0;

  foreach(var_1 in level.allies)
  var_1.ignoreme = 0;

  if(self.vehicletype == "btr80") {
    if(common_scripts\utility::flag("btr_reverse_here")) {
      self vehicle_setspeed(0, 99999, 99999);
      wait 1.5;
      self.script_vehicle_selfremove = 1;
      self.attachedpath = undefined;
      self notify("newpath");
      self vehicle_setspeed(1, 4, 4);
      self resumespeed(3);
      var_3 = getvehiclenode("btr_failsafe_path", "targetname");
      thread maps\_vehicle::vehicle_paths(var_3);
      self startpath(var_3);
      self.veh_transmission = "reverse";
      maps\_vehicle::vehicle_wheels_backward();
      wait 1;
      thread btr_fire_logic();
      wait 3;
      self vehicle_setspeed(0, 10, 12);
    } else {
      self vehicle_setspeed(0, 10, 12);
      wait 2;
      thread btr_fire_logic();
    }
  }

  if(self.vehicletype == "humvee") {
    self vehicle_setspeed(0, 10, 12);

    if(!common_scripts\utility::flag("start_ambush_scene_enemies"))
      wait(randomintrange(1, 3));

    var_4 = maps\_vehicle::vehicle_unload("all");

    foreach(var_1 in var_4) {
      var_1 maps\_utility::gun_recall();
      var_1.health = 100;
      var_1.delete_on_death = 1;
      var_1.a.nodeath = 0;
      var_1.allowdeath = 1;
      var_1.allowpain = 1;
      var_1.no_pain_sound = 0;
      var_1.diequietly = 0;
      var_1.noragdoll = 0;
      var_1.nocorpsedelete = 0;
      var_1.ignoreall = 0;
      var_1.ignoreme = 0;
      var_1 thread wait_anim_finished();
    }
  }

  level.allies[0].ignoreall = 0;
  level.allies[0].ignoreme = 0;
  level.allies[0] maps\_utility::anim_stopanimscripted();
  level.allies[1] unlink();
  level.allies[1].ignoreall = 0;
  level.allies[1].ignoreme = 0;
  level.allies[1] maps\_utility::anim_stopanimscripted();
  level.allies[2].ignoreall = 0;
  level.allies[2].ignoreme = 0;
  level.allies[2] maps\_utility::anim_stopanimscripted();
}

fail_mission_ambush() {
  common_scripts\utility::flag_wait("destroy_player_ambush");
  wait 5.5;
  level.allies[1] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_abortmission");
  mission_failed_intro();
}

wait_anim_finished() {
  self waittillmatch("anim single", "end");
  self unlink();
  maps\_utility::anim_stopanimscripted();
}

handle_grenade_thrown_failcase() {
  level endon("ambush_destroy_player_off");
  level.player waittill("grenade_fire");
  wait 4;
  common_scripts\utility::flag_set("destroy_player_ambush");
}

destroy_player_ambush_vo() {
  level endon("ambush_destroy_player_off");
  common_scripts\utility::flag_wait("destroy_player_ambush");
  level.allies[1] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_damnitrook");
}

notify_ambush_destroy_player_off() {
  common_scripts\utility::flag_wait("ambush_destroy_player_off");
  level notify("ambush_destroy_player_off");
}

mission_failed_intro() {
  setDvar("ui_deadquote", &"CLOCKWORK_QUOTE_COMPROMISE");
  maps\_utility::missionfailedwrapper();
}

btr_fire_logic() {
  maps\_vehicle_code::_mgon();

  for(;;) {
    btr_burst(3, 0.75, level.player);
    wait 2;
  }
}

btr_look_logic() {
  common_scripts\utility::flag_wait("FLAG_let_btr_pass");
  level endon("stop_btr_looking");

  for(;;) {
    btr_turret_follow(0.75, level.player);
    wait 0.05;
  }
}

btr_burst(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_4 = self gettagorigin("tag_turret2");
    var_5 = var_2.origin[0] + randomintrange(-64, 64) * var_1;
    var_6 = var_2.origin[1] + randomintrange(-64, 64) * var_1;
    var_7 = var_2.origin[2] + randomintrange(-32, 0) * var_1;
    var_8 = (var_5, var_6, var_7);
    var_9 = vectortoangles(var_8 - var_4);
    var_10 = anglesToForward(var_9);
    var_11 = var_10 * 12;
    var_12 = var_4 + var_11;
    self setturrettargetvec(var_8);
    playFX(common_scripts\utility::getfx("bmp_flash_wv"), var_4, var_10, (0, 0, 1));
    magicbullet("btr80_turret_castle", var_4, var_12);
    self playSound("btr80_fire");
    wait(randomfloatrange(0.1, 0.2));
  }
}

btr_turret_follow(var_0, var_1) {
  level endon("stop_btr_looking");
  thread end_lookat_notify();

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_2 = self gettagorigin("tag_turret2");
    var_3 = var_1.origin[0];
    var_4 = var_1.origin[1];
    var_5 = var_1.origin[2];
    var_6 = (var_3, var_4, var_5);
    var_7 = vectortoangles(var_6 - var_2);
    var_8 = anglesToForward(var_7);
    var_9 = var_8 * 12;
    var_10 = var_2 + var_9;
    self setturrettargetvec(var_6);
    common_scripts\utility::waitframe();
  }
}

end_lookat_notify() {
  wait 5;
  level notify("stop_btr_looking");
}

blackout_timer(var_0, var_1, var_2, var_3) {
  level endon("blackout_early");

  switch (var_3) {
    case 0:
      if(getDvar("notimer") == "1") {
        return;
      }
      if(!isDefined(var_2))
        var_2 = 0;

      level.hudtimerindex = 20;
      level.timer = maps\_hud_util::get_countdown_hud(-250);
      level.timer setpulsefx(30, 900000, 700);
      level.timer.label = var_1;
      level.timer settenthstimer(var_0);
      level.start_time = gettime();
      wait(var_0 - 15);
      break;
    case 1:
      if(getDvar("notimer") == "1") {
        return;
      }
      if(!isDefined(var_2))
        var_2 = 0;

      level.hudtimerindex = 20;
      level.timer = maps\_hud_util::get_countdown_hud(-250);
      level.timer setpulsefx(30, 900000, 700);
      level.timer.label = var_1;
      level.timer settenthstimer(var_0);
      level.start_time = gettime();
      wait 26;
      break;
  }

  thread maps\clockwork_code::radio_dialog_add_and_go("clockwork_diz_15secs");
  thread maps\clockwork_audio::lights_out_music();
  thread maps\clockwork_audio::timer_tick();
  wait 14;
  common_scripts\utility::flag_set("allies_prep_lightsout");
  common_scripts\utility::flag_set("nvg_gun_up");
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_readynvgs");
  wait 1;
  common_scripts\utility::flag_set("lights_out");
  common_scripts\utility::flag_set("lights_off");
  level notify("ready_nvgs");
  level.timer destroy();
}

entrance_drones() {
  common_scripts\utility::flag_wait("FLAG_entrance_drones");
  var_0 = maps\_utility::array_spawn_targetname("exterior_tunnel_guards_patrol");
  var_1 = maps\_utility::array_spawn_targetname("exterior_tunnel_guards");
  level.exterior_guards = common_scripts\utility::array_combine(var_0, var_1);

  foreach(var_3 in var_0) {
    var_3.runanim = maps\_utility::getgenericanim("active_patrolwalk_gundown");

    if(isDefined(self.animation))
      var_3.idleanim = maps\_utility::getgenericanim(self.animation);
  }
}

player_failcase_tunnel() {
  thread player_failcase_tunnel_overrun();
  level endon("player_in_jeep");
  var_0 = [];
  var_0[0] = "clockwork_bkr_getbackhererook";
  var_0[1] = "clockwork_bkr_rookwhereyagoing";

  for(;;) {
    common_scripts\utility::flag_wait("FLAG_player_failcase_tunnel");
    var_1 = 0;

    while(common_scripts\utility::flag("FLAG_player_failcase_tunnel")) {
      if(var_1 > var_0.size - 1) {
        setDvar("ui_deadquote", &"CLOCKWORK_QUOTE_LEFT_TEAM");
        maps\_utility::missionfailedwrapper();
        break;
      }

      level.allies[0] maps\clockwork_code::char_dialog_add_and_go(var_0[var_1]);
      var_1++;
      wait(randomfloatrange(3, 5));
    }
  }
}

player_failcase_tunnel_overrun() {
  level endon("player_in_jeep");
  common_scripts\utility::flag_wait("FLAG_player_failcase_tunnel_overrun");
  setDvar("ui_deadquote", &"CLOCKWORK_QUOTE_LEFT_TEAM");
  maps\_utility::missionfailedwrapper();
}

handle_dog_intro() {
  level.dog thread maps\ally_attack_dog::lock_player_control_until_flag("ally_checkpoint_approach");
  thread maps\clockwork_code::dog_walk_for_time(12);
  thread handle_dog_checkpoint();
}

handle_dog_checkpoint() {
  thread handle_dog_targeting_checkpoint();
  thread handle_dog_ambush();
}

handle_dog_targeting_checkpoint() {
  level endon("intro_finished");
  level.player waittill("dog_attack_command");
  wait 3;
  maps\clockwork_code::dog_run();
  level.dog maps\_utility::set_ignoreall(0);
  level.dog maps\_utility::set_ignoreme(0);
  common_scripts\utility::flag_set("start_enemies_provoked_early");
}

handle_dog_ambush() {
  common_scripts\utility::flag_wait("ambush_scene_started");
  level.dog maps\_utility::set_ignoreall(1);
  level.dog maps\_utility::set_ignoreme(1);
  var_0 = getnode("dog_jumpup_jeep", "targetname");
  var_1 = level.dog.goalradius;
  thread dog_scratch_intro();
  common_scripts\utility::flag_wait("start_intro_drive");
  level.dog.goalradius = var_1;
  wait 3;
  var_0 notify("stop_scritchin");
  maps\clockwork_code::link_dog_to_jeep(level.jeep);
  level.dog thread maps\ally_attack_dog::lock_player_control_until_flag("nvgs_on");
  level.dog thread maps\_utility::play_sound_on_entity("anml_dog_bark");
}

dog_scratch_intro() {
  level endon("start_intro_drive");

  if(common_scripts\utility::flag("start_intro_drive")) {
    return;
  }
  var_0 = getnode("dog_jumpup_jeep", "targetname");
  level.dog.goalradius = 5;

  for(;;) {
    level.dog setgoalnode(var_0);
    var_1 = level.dog common_scripts\utility::waittill_notify_or_timeout_return("goal", 10);

    if(!isDefined(var_1) || var_1 != "timeout") {
      break;
    }

    wait 1;
  }

  wait 2;
  var_0 thread maps\_anim::anim_loop_solo(level.dog, "dog_scratch_door", "stop_scritchin");
}