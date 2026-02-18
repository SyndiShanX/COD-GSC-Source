/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2856038948e153b5.gsc
***********************************************/

#using script_1b9f100b85b7e21d;
#using script_1fd2c6e5fc8cb1c3;
#using script_3dc93ca9902a9cda;
#using script_4ec222619bffcfd1;
#using script_4fdb32cc1d125464;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#namespace kgb_aslt_escape_deploy_gas;

function starting(var_d3440450) {
  level thread namespace_e77bf565::function_277bceaa(0);
}

function main(var_d3440450, var_50cc0d4f) {
  level flag::set("aslt_bunker_escape_deploy_gas_begin");

  if(is_true(var_50cc0d4f)) {
    level.adler = namespace_e77bf565::function_52fe0eb3(var_d3440450, "adler_shotgun");
    level thread scene::skipto_end_noai("scene_kgb_door_kick", "Last_Frame", undefined, 1);
    level thread scene::skipto_end_noai("scene_kgb_utility_room_adler", "Door_Closed", undefined, 1);
    level thread namespace_e77bf565::function_1067ebf5("rotating_object_bunker", "player_grabbed_armor");
  }

  level.adler battlechatter::function_2ab9360b(0);
  level thread namespace_e77bf565::escape_objective(var_d3440450, var_50cc0d4f);
  level thread function_b735db01();
  level thread function_d0ef0702(var_d3440450);
  level thread kgb_aslt_exfil_escape::function_1f999428();
  level thread namespace_e77bf565::function_5dfd7fb1("window_traversal_near_rescue_belikov", "script_noteworthy", 0);
  spawner::add_spawn_function_ai_group("gas_masked_shotgun_seekers", &function_92d72c13);
  spawner::add_spawn_function_ai_group("deploy_gas_initial_guys", &function_2adf5677);
  spawner::add_spawn_function_ai_group("deploy_gas_gassed_guys", &function_2f389b60);

  if(!level flag::get("scene_kgb_elevator_intro_inited")) {
    level thread scene::init("scene_kgb_elevator_intro");
  }

  level thread scene::init("scene_kgb_lights_out");
  level thread scene::init("scene_kgb_elevator_exfil_intro_adler");
  level thread scene::init("scene_kgb_elevator_exfil_intro_insideman");
  level thread function_15d8d7cd();
  level flag::set("turn_on_elevator_alarm_light");
  level flag::wait_till("aslt_bunker_escape_deploy_gas_complete");

  if(isDefined(var_d3440450)) {
    skipto::function_4e3ab877(var_d3440450);
  }
}

function function_2adf5677() {
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.var_c681e4c1 = 1;
  self battlechatter::function_2ab9360b(0);
}

function function_2f389b60() {
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.var_c681e4c1 = 1;
  self ai::gun_remove();
  self.dontdropweapon = 1;
  self battlechatter::function_2ab9360b(0);
}

function cleanup(name, starting, direct, player) {}

function init_flags() {
  level flag::init("aslt_bunker_escape_deploy_gas_begin");
  level flag::init("aslt_bunker_escape_deploy_gas_complete");
  level flag::init("adler_at_deploy_gas_start_node");
  level flag::init("player_at_deploy_gas_door");
  level flag::init("gas_deployed");
  level flag::init("enable_inside_man_interact");
  level flag::init("enable_inside_man_rescue_objective");
  level flag::init("inside_man_rescued");
  level flag::init("inside_man_rescue_done");
  level flag::init("turn_on_elevator_alarm_light");
  level flag::init("player_gasmask_on");
  level flag::init("inside_man_use_tag_obj_created");
  level flag::init("inside_man_rescue_objective_cleaned_up");
}

function init_clientfields() {
  clientfield::register("toplayer", "set_player_pbg_bank", 1, 2, "int");
}

function function_22b7fffd() {
  animation::add_notetrack_func("kgb_aslt_escape_deploy_gas::adler_swap_to_gas_mask_head", &function_dfe94ac6);
  animation::add_notetrack_func("kgb_aslt_escape_deploy_gas::adler_attach_gas_mask", &function_7dbd8101);
  animation::add_notetrack_func("kgb_aslt_escape_deploy_gas::adler_detach_gas_mask", &function_f8337223);
  animation::add_notetrack_func("kgb_aslt_escape_deploy_gas::belikov_swap_to_gas_mask_head", &function_bd86663d);
  animation::add_notetrack_func("kgb_aslt_escape_deploy_gas::belikov_attach_gas_mask", &function_ba4e8f8f);
  animation::add_notetrack_func("kgb_aslt_escape_deploy_gas::belikov_detach_gas_mask", &function_59131084);
  animation::add_notetrack_func("kgb_aslt_escape_deploy_gas::attach_gas_mask", &function_59dd75dc);
  animation::add_notetrack_func("kgb_aslt_escape_deploy_gas::detach_gas_mask", &function_b5b663);
  animation::add_notetrack_func("kgb_aslt_escape_deploy_gas::pa_you_are_surrounded", &function_9074c842);
  animation::add_notetrack_func("kgb_aslt_escape_deploy_gas::player_rescue_anim_done", &function_c4fbab80);
  animation::add_notetrack_func("kgb_aslt_escape_deploy_gas::adler_rescue_anim_done", &function_6671538f);
  animation::add_notetrack_func("kgb_aslt_escape_deploy_gas::belikov_rescue_anim_done", &function_548627b8);
}

function function_d0ef0702(var_d3440450) {
  level thread function_36e68765(var_d3440450);
  level flag::wait_till("player_at_deploy_gas_door");
  namespace_353d803e::music("13.7_holding_belikov");
  thread namespace_353d803e::function_b6b29051();
  level flag::wait_till("inside_man_rescue_done");
  waittillframeend();
  namespace_353d803e::music("14.0b_full_alert");
  level flag::wait_till("heavy_gear_vo");
  level.inside_man dialogue::queue("vox_cp_rkgb_05300_blkv_thereareheavywe_b0");
  wait 0.5;
  level.inside_man dialogue::queue("vox_cp_rkgb_05300_blkv_weneedtoarmours_51");
  wait 1;
  level.inside_man dialogue::queue("vox_cp_rkgb_05300_blkv_keepmovingthege_d6");
  level.inside_man battlechatter::function_2ab9360b(1);
  level.adler battlechatter::function_2ab9360b(1);
  level thread savegame::checkpoint_save();
}

function function_9074c842(params) {
  detonate_gas_speaker_org = struct::get("detonate_gas_speaker_org", "targetname");
  sndobj = snd::function_9ae4fc6f("vox_cp_rkgb_05100_rms1_youaresurrounde_83", detonate_gas_speaker_org.origin);
}

function function_ba2191eb() {
  level endon(#"gas_deployed");
  wait 1;
  detonate_gas_speaker_org = struct::get("detonate_gas_speaker_org", "targetname");
  sndobj = snd::function_9ae4fc6f("vox_cp_rkgb_05100_rms1_dropyourweapons_cf", detonate_gas_speaker_org.origin);
  snd::function_2fdc4fb(sndobj);
  wait 2;
  detonate_gas_speaker_org = struct::get("detonate_gas_speaker_org", "targetname");
  sndobj = snd::function_9ae4fc6f("vox_cp_rkgb_05100_rms1_thisisyourfinal_f1", detonate_gas_speaker_org.origin);
}

function function_c4fbab80(params) {
  level.player endon(#"death");
  level.player val::reset(#"scene_kgb_inside_man_on_knees", "disable_weapons");
  wait 10;
  level.player clientfield::set_to_player("stream_deploy_gas_assets", 0);
}

function function_6671538f(params) {
  level.adler endon(#"death");
  wait 4;
  level.adler ai::set_behavior_attribute("demeanor", "cqb");
}

function function_548627b8(params) {
  level.inside_man endon(#"death");
  wait 4;
  level.inside_man ai::set_behavior_attribute("demeanor", "cqb");
}

function function_36e68765(var_d3440450) {
  level.player endon(#"death");
  level flag::wait_till("adler_exit_walkup_loop");
  wait 4.5;
  level.inside_man = namespace_e77bf565::function_e4660071(undefined, "inside_man_shotgun");
  level.inside_man battlechatter::function_2ab9360b(0);
  level.inside_man.primaryweapon = getweapon(#"shotgun_pump_t9");
  level.gas_guards = spawner::simple_spawn("gas_guards");
  level thread scene::play("scene_kgb_inside_man_on_knees", "Intro", level.gas_guards);
  level flag::wait_till("gas_deployed");
  level flag::wait_till("player_gasmask_on");
  level thread scene::play("scene_kgb_inside_man_on_knees", "Outro", level.gas_guards);
  level flag::wait_till("enable_inside_man_interact");
  level.var_a910b1a = util::spawn_model("tag_origin", (0, 0, 0), (0, 0, 0));
  level.var_a910b1a linkto(level.inside_man, "j_spine4", (0, 0, 0), (0, 0, 0));
  level.var_a910b1a dontinterpolate();
  level flag::set("enable_inside_man_rescue_objective");
  level flag::wait_till("inside_man_use_tag_obj_created");
  level.var_a910b1a util::create_cursor_hint("tag_origin", undefined, #"hash_47c6b9a9b0461df0", 96, undefined, undefined, undefined, undefined, undefined, undefined, 0, 1);
  level.var_a910b1a prompts::set_objective("obj_goto");
  s_result = level.var_a910b1a waittilltimeout(20, #"trigger");
  level.var_a910b1a util::remove_cursor_hint();
  function_1eaaceab(level.gas_guards);
  level thread scene::play("scene_kgb_inside_man_on_knees", "Downed_Loop", level.gas_guards);

  if(s_result._notify == # "trigger") {
    level.player val::set(#"scene_kgb_inside_man_on_knees", "disable_weapons", 1);
    level flag::set("inside_man_rescued");
    level.inside_man scene::stop();
    level.inside_man stopanimscripted(0.2);
    level thread scene::play("scene_kgb_inside_man_rescue", "rescue");
    level.inside_man ai::set_behavior_attribute("demeanor", "combat");
    level.inside_man colors::set_force_color("g");
    level.inside_man colors::enable();
    level.adler.fixednode = 0;
    level.adler ai::set_behavior_attribute("demeanor", "combat");
    level.adler colors::set_force_color("g");
    level.adler colors::enable();
    level thread savegame::checkpoint_save();
    level flag::wait_till("inside_man_rescue_objective_cleaned_up");
    level.var_a910b1a delete();
    level thread namespace_e77bf565::cleanup_corpses();
    return;
  }

  if(s_result._notify == # "timeout") {
    level.var_a910b1a delete();
    util::missionfailedwrapper(#"hash_7880a61f047fcad3", #"hash_2190ae4a3848729d");
  }
}

function function_b735db01() {
  level.player endon(#"death");
  level.adler endon(#"death");
  level.adler colors::disable();
  level.adler ai::set_behavior_attribute("demeanor", "combat");
  level.adler ai::set_behavior_attribute("sprint", 1);
  scene::play("scene_kgb_detonate_gas", "Walkup");
  level.adler ai::set_behavior_attribute("sprint", 0);
  level.player clientfield::set_to_player("stream_deploy_gas_assets", 1);
  level thread scene::play("scene_kgb_detonate_gas", "Walkup_Loop");
  level flag::set("adler_in_walkup_loop");
  level flag::wait_till("adler_exit_walkup_loop");
  scene::play("scene_kgb_detonate_gas", "Intro");
  level thread scene::play("scene_kgb_detonate_gas", "Intro_Loop");
  level flag::set("adler_at_deploy_gas_start_node");
  level flag::wait_till("player_at_deploy_gas_door");
  level thread function_ba2191eb();
  level thread function_7fa2d5b9();
  level thread function_ade558b6();
  level thread savegame::checkpoint_save();
  level flag::wait_till_timeout(12.5, "gas_deployed");

  if(level flag::get("gas_deployed")) {
    level flag::wait_till("player_gasmask_on");
    scene::play("scene_kgb_detonate_gas", "Outro");
    adler_idle_near_inside_man_node = getnode("adler_idle_near_inside_man_node", "targetname");
    level.adler.fixednode = 1;
    level.adler thread spawner::go_to_node(adler_idle_near_inside_man_node);
    level.adler thread function_d32b06fc();
    level.inside_man thread function_d32b06fc();
    return;
  }

  level.player notify(#"hash_5a2a78b8d7615e79");
  level notify(#"hash_a883de88fd6a223");
  level notify(#"hash_398eb960e1259f24");
  level thread hint_tutorial::function_9f427d88();
  level thread scene::play("scene_kgb_inside_man_on_knees", "death");
  wait 1.5;
  util::missionfailedwrapper(#"hash_7880a61f047fcad3", #"hash_7d9fc9dea1de6a04");
}

function function_d32b06fc() {
  self endon(#"death");
  self.og_maxsightdistsqrd = self.maxsightdistsqrd;
  self.var_4285accc = self.newenemyreactiondistsq;
  self.maxsightdistsqrd = 1000000;
  self.newenemyreactiondistsq = 1000000;
  level flag::wait_till("reset_gas_masked_enemy_sighting");
  self.maxsightdistsqrd = self.og_maxsightdistsqrd;
  self.newenemyreactiondistsq = self.var_4285accc;
}

function function_7fa2d5b9() {
  level endon(#"hash_398eb960e1259f24");
  level.player endon(#"death");
  var_431bb046 = getweapon(#"hash_6187f05e80231ce6");
  level.player val::set(#"detonate_gas", "disable_weapon_fire", 1);
  level.player val::set(#"detonate_gas", "disable_weapon_reload", 1);
  level.player val::set(#"detonate_gas", "disable_weapon_cycling", 1);
  level.player val::set(#"detonate_gas", "disable_offhand_weapons", 1);
  level.player val::set(#"detonate_gas", "disable_offhand_special", 1);
  level.player val::set(#"detonate_gas", "allow_ads", 0);
  wait 0.5;
  level.player giveweapon(var_431bb046);
  level.player switchtoweapon(var_431bb046, 1);
  level.player gestures::function_b6cc48ed("ges_t9_gas_detonator_and_mask", undefined, 1, 0.2, undefined, 1, 1);
  thread namespace_353d803e::function_62f3e8ea();
  wait 2.5;
  level thread hint_tutorial::function_4c2d4fc4(#"hash_1666923bbed40ff0", undefined, undefined, undefined, 2);
  level.player notifyonplayercommand("use_gas", "+smoke");
  level.player notifyonplayercommand("use_gas", "+equip_toggle_throw");
  level.player waittill(#"use_gas");
  level.player notifyonplayercommandremove("use_gas", "+smoke");
  level.player notifyonplayercommandremove("use_gas", "+equip_toggle_throw");
  level.player notify(#"hash_5a2a78b8d7615e79");
  level notify(#"hash_a883de88fd6a223");
  level thread hint_tutorial::function_9f427d88();
  level flag::set("gas_deployed");
  namespace_353d803e::music("14.0_knockout");
  level.player stopgestureviewmodel("ges_t9_gas_detonator_and_mask");
  wait 0.07;
  snd::client_msg(#"hash_4a58b7be1af1818c");
  level thread namespace_353d803e::evt_kgb_deploygas_gas_mask_on();
  wait 2.5;
  wait 1;
  level.player namespace_e77bf565::gasmask_on(1);
  level flag::set("player_gasmask_on");
  exploder::exploder("gas");
  level.player clientfield::set_to_player("set_player_pbg_bank", 2);

  while(level.player isgestureplaying("ges_t9_gas_detonator_and_mask")) {
    wait 0.05;
  }

  level.player takeweapon(var_431bb046);
  level.player val::reset_all(#"detonate_gas");
}

function function_59dd75dc(params) {
  if(!isentity(self)) {
    return;
  }

  self endon(#"death");
  waittillframeend();

  if(self haspart("J_Helmet")) {
    self attach("c_t9_rus_gasmask_wm_01", "J_Helmet");
  }
}

function function_b5b663(params) {
  if(!isentity(self)) {
    return;
  }

  self endon(#"death");
  waittillframeend();

  if(self isattached("c_t9_rus_gasmask_wm_01", "J_Helmet")) {
    self detach("c_t9_rus_gasmask_wm_01", "J_Helmet");
  }
}

function function_dfe94ac6(params) {
  if(!isentity(self)) {
    return;
  }

  self endon(#"death");
  waittillframeend();

  if(self isattached("c_t9_cp_usa_hero_adler_head1")) {
    self detach("c_t9_cp_usa_hero_adler_head1");
  }

  if(!self isattached("c_t9_cp_usa_hero_adler_head1_kgb_gasmask")) {
    self attach("c_t9_cp_usa_hero_adler_head1_kgb_gasmask");
  }
}

function function_7dbd8101(params) {
  if(!isentity(self)) {
    return;
  }

  self endon(#"death");
  waittillframeend();

  if(!self isattached("c_t9_cp_usa_hero_adler_prop_kgb_gasmask")) {
    self attach("c_t9_cp_usa_hero_adler_prop_kgb_gasmask", "j_helmet");
  }
}

function function_f8337223(params) {
  if(!isentity(self)) {
    return;
  }

  self endon(#"death");
  waittillframeend();

  if(self isattached("c_t9_cp_usa_hero_adler_prop_kgb_gasmask")) {
    self detach("c_t9_cp_usa_hero_adler_prop_kgb_gasmask", "j_helmet");
  }
}

function function_bd86663d(params) {
  if(!isentity(self)) {
    return;
  }

  self endon(#"death");
  waittillframeend();

  if(self isattached("c_t9_cp_rus_kgb_hq_vip_belikov_head_injured")) {
    self detach("c_t9_cp_rus_kgb_hq_vip_belikov_head_injured");
  }

  if(!self isattached("c_t9_cp_rus_kgb_hq_vip_belikov_head_gasmask")) {
    self attach("c_t9_cp_rus_kgb_hq_vip_belikov_head_gasmask");
  }
}

function function_ba4e8f8f(params) {
  if(!isentity(self)) {
    return;
  }

  self endon(#"death");
  waittillframeend();

  if(!self isattached("c_t9_cp_rus_hero_belikov_prop_kgb_gasmask")) {
    self attach("c_t9_cp_rus_hero_belikov_prop_kgb_gasmask", "j_helmet");
  }
}

function function_59131084(params) {
  if(!isentity(self)) {
    return;
  }

  self endon(#"death");
  waittillframeend();

  if(self isattached("c_t9_cp_rus_hero_belikov_prop_kgb_gasmask")) {
    self detach("c_t9_cp_rus_hero_belikov_prop_kgb_gasmask", "j_helmet");
  }
}

function function_ade558b6() {
  level endon(#"hash_a883de88fd6a223");
  level.player endon(#"death");
  var_ade558b6 = [];
  var_ade558b6[var_ade558b6.size] = "vox_cp_rkgb_05100_adlr_belldetonatethe_fc";
  var_ade558b6[var_ade558b6.size] = "vox_cp_rkgb_05100_adlr_setoffthegas_71";
  var_ade558b6[var_ade558b6.size] = "vox_cp_rkgb_05100_adlr_triggerthegasbe_a9";
  wait 10;
  i = 0;

  while(true) {
    level.player thread objectives_ui::show_objectives();
    hint_tutorial::function_4c2d4fc4(#"hash_1666923bbed40ff0", undefined, undefined, undefined, 2, 10);
    level.adler dialogue::queue("" + var_ade558b6[i]);
    i++;

    if(i + 1 > var_ade558b6.size) {
      i = 0;
    }

    wait 15;
  }
}

function function_92d72c13() {
  self endon(#"death");
  self ai::set_behavior_attribute("demeanor", "cqb");
  self.og_maxsightdistsqrd = self.maxsightdistsqrd;
  self.var_4285accc = self.newenemyreactiondistsq;
  self.maxsightdistsqrd = 1000000;
  self.newenemyreactiondistsq = 1000000;
  level flag::wait_till("reset_gas_masked_enemy_sighting");
  self ai::set_behavior_attribute("demeanor", "combat");
  self.maxsightdistsqrd = self.og_maxsightdistsqrd;
  self.newenemyreactiondistsq = self.var_4285accc;
}

function function_15d8d7cd() {
  level flag::wait_till("start_elevator_escape_intro");
  level thread scene::init("scene_kgb_elevator_exfil_intro_player");
  level thread scene::play("scene_kgb_elevator_intro");
  wait 0.25;
  level thread scene::play("scene_kgb_elevator_exfil_armored_guy_entry");
  wait 0.5;
  level thread scene::play("scene_kgb_elevator_exfil_armored_guy_entry_02");
}