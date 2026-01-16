/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\enemyhq_vip.gsc
*****************************************************/

enemyhq_vip_pre_load() {
  common_scripts\utility::flag_init("start_sniper_vip_breach");
  common_scripts\utility::flag_init("vip_breach_hot");
  common_scripts\utility::flag_init("done_sniping_early");
  common_scripts\utility::flag_init("sniping_done");
  common_scripts\utility::flag_init("interrogation_done");
  common_scripts\utility::flag_init("clear_left");
  common_scripts\utility::flag_init("clear_right");
  common_scripts\utility::flag_init("interrogatee_killed");
  common_scripts\utility::flag_init("vip_done");
}

setup_vip() {
  level.start_point = "vip";
  maps\enemyhq::setup_common();
  thread maps\enemyhq_audio::aud_check("vip");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("vip_allies_set_up");
}

begin_vip() {
  level.sniper_vision_override = "enemyhq_sniper_view_b";
  thread maps\_utility::battlechatter_off("allies");
  thread maps\_utility::battlechatter_off("axis");
  maps\_utility::delaythread(0.05, maps\_utility::set_team_bcvoice, "allies", "taskforce");
  level.dog maps\enemyhq_code::set_dog_scripted_mode(level.player);
  maps\_utility::autosave_by_name("vip_room");
  level.remote_sniper_return_struct = common_scripts\utility::getstruct("vip_return_struct", "targetname");
  level.dog maps\enemyhq_code::lock_player_control();
  thread ally_vo();
  common_scripts\utility::flag_wait("setup_vip_enemies");
  thread maps\enemyhq_code::handle_leave_team_fail("leaving_VIP", "left_VIP");
  thread animate_vip_enemies();
  thread animate_ally_breach();
  thread maps\enemyhq_code::toggle_ally_outlines(0);
  thread vip_handle_ps4_ssao();
  common_scripts\utility::array_thread(level.allies, maps\_utility::disable_surprise);
  common_scripts\utility::array_thread(level.allies, maps\_utility::disable_pain);
  level.player waittill("player_switching_to_tablet");
  common_scripts\utility::flag_set("start_sniper_vip_breach");
  thread maps\enemyhq_audio::aud_start_sniper("enhq_atrium_covered");
  common_scripts\utility::exploder(8);
  common_scripts\utility::exploder(1111);
  common_scripts\utility::exploder(890);
  maps\_utility::stop_exploder(9090);
  maps\_utility::stop_exploder(9080);
  maps\_utility::stop_exploder(5700);
  maps\_utility::stop_exploder(5600);
  maps\_utility::stop_exploder(8010);
  maps\_utility::stop_exploder(9094);
  level waittill("vip_breach_hot");
  level.player waittill("remote_sniper_pad_down");
  level.player disableweaponswitch();
  level.player disableweapons();
  setsaveddvar("ammoCounterHide", 1);
  common_scripts\utility::flag_set("sniping_done");
  maps\_utility::stop_exploder(8011);
  common_scripts\utility::exploder(89);
  level.player disableweaponpickup();
  var_0 = common_scripts\utility::getstruct("new_vip_breach_e5", "targetname");
  thread delete_corpses_around_origin(var_0.origin, 120);
  var_1 = getaiarray("axis");
  common_scripts\utility::array_thread(var_1, maps\enemyhq_code::die_quietly);
  thread player_back_from_sniping();
  common_scripts\utility::flag_wait_any("interrogatee_killed", "start_rpg_ambush");
  level.player enableweapons();
  level.player enableweaponswitch();
  level.player takeweapon("freerunner");
  level.player switchtoweaponimmediate(level.pre_pre_sniping_weapon);
  setsaveddvar("ammoCounterHide", 0);
  level.player enableweaponpickup();

  if(!common_scripts\utility::flag("start_rpg_ambush"))
    maps\enemyhq_code::safe_activate_trigger_with_targetname("traversal_allies1");

  common_scripts\utility::flag_wait_any("interrogation_done", "start_rpg_ambush");

  if(!common_scripts\utility::flag("interrogation_done")) {
    common_scripts\utility::flag_set("interrogation_done");
    common_scripts\utility::array_thread(level.allies, maps\_utility::anim_stopanimscripted);
    common_scripts\utility::array_thread(level.allies, maps\_utility::enable_ai_color);

    if(isalive(level.interogatee)) {
      level.interogatee maps\_utility::stop_magic_bullet_shield();
      level.interogatee maps\_utility::anim_stopanimscripted();
      level.interogatee maps\_utility::die();
    }

    level.dog maps\_utility::anim_stopanimscripted();
    level.dog maps\_utility::enable_ai_color();
    level.dog maps\_utility_dogs::disable_dog_sniff();
  }

  if(isDefined(level.knife))
    hide_knife(level.allies[1]);

  common_scripts\utility::array_thread(level.allies, maps\_utility::enable_surprise);
  common_scripts\utility::array_thread(level.allies, maps\_utility::enable_pain);
}

vip_handle_ps4_ssao() {
  if(!level.ps4) {
    return;
  }
  level.player waittill("remote_sniper_pad_down");
  setsaveddvar("r_ssaoScriptScale", 0);
  common_scripts\utility::flag_wait("start_pre_rpg_ambush");
  maps\_art::enable_ssao_over_time(2);
}

auto_breach() {
  common_scripts\utility::flag_wait("start_sniper_vip_breach");
  wait 8.0;
  level notify("vip_breach_hot");
}

animate_vip_enemies() {
  var_0 = getent("vip_enemy_volume", "targetname");
  var_1 = getEntArray("new_vip_enemy", "targetname");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = var_4.script_noteworthy;
    var_6 = common_scripts\utility::getstruct(var_4.target, "targetname");
    var_7 = var_4 maps\_utility::spawn_ai(1);
    var_7 thread vip_notify_on_death();
    var_7.animname = var_5;
    var_7.struct = var_6;
    var_7.allowdeath = 1;

    if(isDefined(level.scr_anim[var_5]["new_vip_enemy_intro"]))
      var_6 thread vip_enemy_animate_intro(var_7);
    else
      var_6 thread maps\_anim::anim_loop_solo(var_7, "new_vip_enemy", "stop_loop");

    var_7 thread vip_enemy_interrupt(var_0);
    var_2 = common_scripts\utility::array_add(var_2, var_7);
  }

  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_2, var_2.size, "done_sniping_early");
  level waittill("vip_breach_hot");
  wait 0.25;

  foreach(var_7 in var_2) {
    if(isalive(var_7))
      var_7 notify("go_time");
  }
}

vip_notify_on_death() {
  var_0 = undefined;

  switch (self.script_noteworthy) {
    case "new_vip_e2":
      var_0 = "clear_left";
      break;
    case "new_vip_e4":
      var_0 = "clear_right";
      break;
  }

  if(isDefined(var_0)) {
    self waittill("death");
    common_scripts\utility::flag_set(var_0);
  }
}

vip_enemy_animate_intro(var_0) {
  var_0 endon("death");
  var_0 endon("go_time");
  var_1 = self;
  var_1 thread maps\_anim::anim_first_frame_solo(var_0, "new_vip_enemy_intro");
  common_scripts\utility::flag_wait("start_sniper_vip_breach");
  wait 2;
  var_1 maps\_anim::anim_single_solo(var_0, "new_vip_enemy_intro");
  var_1 thread maps\_anim::anim_loop_solo(var_0, "new_vip_enemy", "stop_loop");
}

vip_enemy_interrupt(var_0) {
  self endon("death");
  common_scripts\utility::waittill_any("death", "damage", "go_time");
  self notify("go_time");

  if(isDefined(self.struct))
    self.struct notify("stop_loop");

  maps\_utility::anim_stopanimscripted();
  self.allowdeath = 1;
  self.ignoreme = 0;
  maps\_utility::enable_ai_color();
  thread maps\_anim::anim_single_solo(self, "vip_breach_react");

  if(isDefined(level.breach_react_starttime[self.animname]["vip_breach_react"])) {
    var_1 = level.scr_anim[self.animname]["vip_breach_react"];
    var_2 = getanimlength(var_1);
    var_3 = level.breach_react_starttime[self.animname]["vip_breach_react"] / var_2;
    self setanimtime(var_1, var_3);
  }

  self waittillmatch("single anim", "end");
  wait(randomfloatrange(0.1, 0.25));
  self.ignoreall = 0;
}

vip_dog_attack() {
  var_0 = maps\_utility::make_array("new_vip_e6", "new_vip_e5", "new_vip_e2", "new_vip_e2", "new_vip_e1");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = getEntArray(var_3, "script_noteworthy");
    var_3 = pickai(var_4);

    if(isDefined(var_3)) {
      var_3.name = var_3.script_noteworthy;
      var_3.script_friendname = var_3.script_noteworthy;
      var_1[var_1.size] = var_3;
    }
  }

  level.dog maps\enemyhq_code::dog_attack_targets_by_priority(var_1, "sniping_done", 1);
}

pickai(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isai(var_2) && isalive(var_2))
      return var_2;
  }

  return undefined;
}

animate_ally_breach() {
  var_0 = common_scripts\utility::getstruct("vip_breach1b", "targetname");
  level waittill("vip_breach_hot");
  wait 0.5;
  thread open_vip_doors();
  var_1 = 1;

  foreach(var_3 in level.allies) {
    var_3.animname = "ally" + maps\_utility::string(var_1);

    if(var_1 > 1)
      var_0 = common_scripts\utility::getstruct("vip_breach1", "targetname");

    var_0 thread maps\_anim::anim_single_solo(var_3, "vip_breach");
    var_1++;
  }

  thread maps\enemyhq_code::toggle_ally_outlines(1);
  maps\enemyhq_code::safe_activate_trigger_with_targetname("vip_allies_enter");
  thread vip_dog_attack();
}

open_vip_doors() {
  var_0 = getent("vip_doorhandle_l", "targetname");
  var_1 = getent("vip_doorhandle_r", "targetname");
  var_2 = getent("vip_door_l", "targetname");
  var_3 = getent("vip_door_r", "targetname");
  var_1 linkto(var_3);
  var_0 linkto(var_2);
  var_1 notsolid();
  var_0 notsolid();
  var_2 rotateyaw(93, 0.2, 0.1, 0.1);
  var_2 disconnectpaths();
  var_2 connectpaths();
  var_3 rotateyaw(-92, 0.2, 0.1, 0.1);
  var_3 disconnectpaths();
  var_3 connectpaths();
}

player_back_from_sniping() {
  thread handle_vip_drones();
  level.knife = spawn("script_model", (0, 0, 0));
  level.knife setModel("weapon_knife_iw6");
  level.knife hide();
  level.dog maps\_utility_dogs::enable_dog_sniff();
  var_0 = getnode("vip_hesh_loc", "targetname");
  level.allies[2] maps\_utility::teleport_ai(var_0);
  maps\enemyhq_code::safe_activate_trigger_with_targetname("vip_allies_search");
  var_1 = getent("vip_interrogatee", "targetname");
  var_2 = var_1 maps\_utility::spawn_ai(1);
  level.interogatee = var_2;
  var_3 = common_scripts\utility::getstruct("vip_interrogate", "targetname");
  var_4 = maps\_utility::make_array(level.allies[1], level.allies[2], var_2, level.dog);
  level.allies[1].animname = "goodguy";
  level.allies[2].animname = "hesh";
  level.dog.animname = "dog";
  var_2.animname = "badguy";
  var_2 maps\_utility::magic_bullet_shield();
  level.dog maps\_utility::anim_stopanimscripted();
  level.dog unlink();
  common_scripts\utility::waitframe();
  var_3 maps\_anim::anim_first_frame(var_4, "vip_interrogate");
  common_scripts\utility::flag_wait_or_timeout("start_interrogation_anims", 15);
  common_scripts\utility::flag_set("start_interrogation_anims");
  var_3 thread maps\_anim::anim_single_run(var_4, "vip_interrogate");
  thread let_player_through();
  wait 11;
  common_scripts\utility::array_thread(level.allies, maps\_utility::enable_ai_color);
  maps\enemyhq_code::safe_activate_trigger_with_targetname("vip_allies_pre_leave");
  level.dog maps\_utility::enable_ai_color();
  level.dog waittillmatch("single anim", "end");
  wait 2;
  level.dog maps\_utility_dogs::disable_dog_sniff();
  level.allies[1] waittillmatch("single anim", "end");
  common_scripts\utility::flag_set("interrogation_done");
}

keegan_vip_line1(var_0) {
  if(!common_scripts\utility::flag("start_pre_rpg_ambush"))
    level.allies[1] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_kgn_whereishe");
}

keegan_vip_line2(var_0) {
  if(!common_scripts\utility::flag("start_pre_rpg_ambush"))
    level.allies[1] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_kgn_whereishe_4");
}

badguyline1(var_0) {
  var_0 maps\enemyhq_code::char_dialog_add_and_go("enemyhq_saf1_getthatdogaway");
}

badguyline2(var_0) {
  var_0 maps\enemyhq_code::char_dialog_add_and_go("enemyhq_fs5_idontknowwhere");
}

badguyline3(var_0) {
  var_0 maps\enemyhq_code::char_dialog_add_and_go("enemyhq_saf1_iidontdeath");
}

let_player_through() {
  wait 15;
  var_0 = getent("vip_player_clip", "targetname");
  var_0 notsolid();
  common_scripts\utility::flag_set("vip_done");
}

show_knife(var_0) {
  level.knife linkto(var_0, "tag_inhand", (0, 0, 0), (0, 0, 0));
  level.knife show();
}

hide_knife(var_0) {
  level.knife unlink();
  level.knife hide();
  level.knife delete();
}

set_search_walk(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self.disablearrivals = var_0;
  self.disableexits = var_0;

  if(var_0) {
    self.animname = "generic";
    maps\_utility::set_run_anim("search_walk", 1);
  } else
    maps\_utility::clear_run_anim();
}

handle_vip_drones() {
  level endon("death");
  thread handle_drone_nags();
  var_0 = getEntArray("vip_drone", "targetname");
  var_0 = common_scripts\utility::array_randomize(var_0);

  foreach(var_2 in var_0) {
    var_2 spawn_vip_drone();
    wait(randomfloatrange(0.2, 0.75));
  }
}

spawn_vip_drone() {
  var_0 = maps\_utility::dronespawn(self);
  var_0.spawner = self;
  var_0 thread handle_vip_drone();
}

handle_vip_drone() {
  self endon("death");
  thread nag_if_shot();
  common_scripts\utility::waittill_any("goal", "death");

  if(!common_scripts\utility::flag("traverse_done"))
    self.spawner spawn_vip_drone();

  self delete();
}

nag_if_shot() {
  self endon("death");
  level endon("traverse_done");

  for(;;) {
    common_scripts\utility::waittill_any("damage", "bulletwhizby");
    level notify("shot_drone");
  }
}

handle_drone_nags() {
  level endon("traverse_done");
  var_0 = [];
  var_0[0] = "enemyhq_mrk_logangetoverit";
  var_0[1] = "enemyhq_mrk_knockitoff";
  var_0[2] = "enemyhq_mrk_lastthingweneed";
  var_1 = 0;

  while(!common_scripts\utility::flag("traverse_done")) {
    level waittill("shot_drone");
    level.player maps\enemyhq_code::radio_dialog_add_and_go(var_0[var_1]);
    wait 2;
    var_1++;

    if(var_1 >= var_0.size)
      var_1 = 0;
  }
}

ally_vo() {
  thread maps\enemyhq_audio::aud_enemy_muffled_vo("vip_breach_hot", "vip_conv_loc", "start_vip_conv");
  common_scripts\utility::flag_wait("setup_vip_enemies");
  thread maps\_utility::autosave_tactical();
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_thisshouldbewhere");
  thread maps\enemyhq_code::nag_player_until_flag(level.allies[0], "start_sniper_vip_breach", "enemyhq_mrk_adamscopeitout", "enemyhq_mrk_usetheremotesniper", "enemyhq_mrk_getonthatremote");
  wait 1;
  level.pre_pre_sniping_weapon = level.player getcurrentweapon();
  common_scripts\utility::flag_set("activate_vip_sniper");
  thread maps\enemyhq_code::sniper_hint("start_sniper_vip_breach", 4);
  common_scripts\utility::flag_wait("start_sniper_vip_breach");
  wait 2;
  maps\_utility::delaythread(0.5, maps\enemyhq_code::nag_player_until_flag, level.player, "vip_breach_hot", "enemyhq_mrk_wellbreachonyour", "enemyhq_mrk_onyou", "enemyhq_mrk_takeashot");
  level waittill("vip_breach_hot");
  common_scripts\utility::flag_set("vip_breach_hot");
  thread maps\enemyhq_audio::aud_vip_breach();
  maps\_utility::radio_dialogue_stop();
  wait 0.25;
  thread maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_mrk_gogogo");
  wait 1;
  thread ally_breach_vo();
  common_scripts\utility::flag_wait("sniping_done");
  maps\_utility::radio_dialogue_stop();
  thread maps\enemyhq_audio::aud_interrogation();
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_roomsecure");
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_hesnothere");
  wait 0.5;
  level endon("start_pre_rpg_ambush");
  level.allies[1] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_kgn_whereishe_2");
  wait 0.5;
  level.allies[1] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_kgn_whereishe_3");
  wait 0.5;
  level.allies[1] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_kgn_wheredidyoutake");
  common_scripts\utility::flag_wait("start_interrogation_anims");
}

delete_corpses_around_origin(var_0, var_1) {
  var_2 = getcorpsearray();

  foreach(var_4 in var_2) {
    if(distance(var_4.origin, var_0) < var_1)
      var_4 delete();
  }
}

ally_breach_vo() {
  level endon("sniping_done");
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_mrk_12oclock12oclock");
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_hsh_runnerontheleft");
  common_scripts\utility::flag_wait("clear_right");
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_mrk_clearright");
  common_scripts\utility::flag_wait("clear_left");
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_kgn_clearleft");
}

kill_dude(var_0) {
  common_scripts\utility::flag_set("interrogatee_killed");
  maps\enemyhq_code::get_killed(var_0);
}