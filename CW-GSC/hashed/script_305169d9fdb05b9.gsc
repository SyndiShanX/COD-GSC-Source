/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_305169d9fdb05b9.gsc
***********************************************/

#using script_37f9ff47f340fbe8;
#using script_3dc93ca9902a9cda;
#using script_480b1940332161de;
#using script_4937c6974f43bb71;
#using script_4d0e7ced9714e7d4;
#using script_63ae018f589c2e64;
#using scripts\core_common\activities_util;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\ending;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#namespace namespace_3562695;

function starting(str_objective) {
  spawner::simple_spawn("spawner_perseus_forces", &function_c50c5a2a);
  level thread scene::init_streamer(#"scene_duga_loose_ends", getplayers());
  level thread scene::init_streamer(#"scene_duga_loose_ends_adler", getplayers());
  level thread scene::init_streamer(#"scene_duga_loose_ends_tappy", getplayers());
  level.perseus = spawner::simple_spawn_single("perseus_starting");
  level.perseus.animname = "perseus";
  level.perseus setteam(#"allies");
  level.perseus setgoal(level.perseus.origin);
  level.perseus.goalradius = 32;
  level.perseus thread namespace_ac5221d7::function_f42f6f14();
  level.perseus util::magic_bullet_shield();

  foreach(guy in level.var_69c98a58) {
    if(isDefined(guy.script_noteworthy) && guy.script_noteworthy == "perseus") {
      guy delete();
    }
  }
}

function main(str_objective, b_skipto) {
  level battlechatter::function_2ab9360b(0);
  box02 = getent("box02", "targetname");
  box02.animname = "box02";
  box03 = getent("box03", "targetname");
  box03.animname = "box03";
  box04 = getent("box04", "targetname");
  box04.animname = "box04";
  extinguisher = getent("extinguisher", "targetname");
  extinguisher.animname = "extinguisher";
  level.cig = getent("cigarette", "targetname");
  level.cig.animname = "cigarette";
  level scene::add_scene_func("scene_duga_loose_ends_tappy", &function_cc592b59, "init");
  level scene::init("scene_duga_loose_ends_tappy");
  namespace_e1ccb37b::music("deactivate_2.0_ambush");
  animation::add_notetrack_func("duga_loose_ends::perseus_swap_to_nomask", &function_648dc3bf);
  animation::add_notetrack_func("duga_loose_ends::handle_japanese_sku_for_ending", &function_bf27d987);
  e_player = getplayers()[0];
  frag = getweapon(#"frag_grenade");

  if(e_player hasweapon(frag)) {
    e_player setweaponammoclip(frag, 0);
    e_player setweaponammostock(frag, 0);
  }

  level.adler = spawner::simple_spawn_single("adler_wounded_ending");
  level.adler setteam(#"axis");
  level.adler val::set(#"hash_1fb077ac0e51edb6", "take_weapons", 1);
  level.adler.var_c681e4c1 = 1;
  level.adler ai::gun_remove();
  level.adler.skipdeath = 1;
  level.adler.health = 9999;
  level.adler.animname = "adler";
  level.adler util::magic_bullet_shield();
  s_org = struct::get("tag_align_loose_ends", "targetname");
  level.adler thread animation::first_frame("t9_duga_loose_ends_adler", s_org);
  level thread scene::init("scene_duga_loose_ends");
  var_b9335c1c = getent("roof_door_clip", "targetname");
  door_left = getent("door_left", "targetname");
  door_right = getent("door_right", "targetname");
  door_left.animname = "door_left";
  door_right.animname = "door_right";
  level thread function_f7d3abcf();
  level thread objectives();
  level.perseus thread function_b132d5eb();
  level flag::wait_till("flag_perseus_path_end");
  level thread scene::play("scene_duga_ending_prep", "init", [level.perseus]);
  level waittill(#"hash_54bae82df394800e");
  namespace_e1ccb37b::music("4.0_adler");
  level thread function_45405080();
  level flag::wait_till("flag_loose_ends_complete");

  if(isDefined(level.perseus)) {
    level.perseus util::stop_magic_bullet_shield();
    level.perseus delete();
  }

  if(isDefined(level.adler)) {
    level.adler delete();
  }

  level namespace_ac5221d7::function_ae1eba32();
  skipto::function_4e3ab877(b_skipto);
  activities::function_59e67711("_exit");
  skipto::function_f02f0c63();
  skipto::function_1c2dfc20();
}

function cleanup(name, starting, direct, player) {}

function function_c50c5a2a() {
  self setteam(#"allies");

  if(!isDefined(level.var_69c98a58)) {
    level.var_69c98a58 = [];
  } else if(!isarray(level.var_69c98a58)) {
    level.var_69c98a58 = array(level.var_69c98a58);
  }

  if(!isinarray(level.var_69c98a58, self)) {
    level.var_69c98a58[level.var_69c98a58.size] = self;
  }
}

function function_648dc3bf(params) {
  if(self isattached("c_t9_cp_rus_hero_perseus_head2_gasmask")) {
    self detach("c_t9_cp_rus_hero_perseus_head2_gasmask");
  }

  if(!self isattached("c_t9_cp_rus_hero_perseus_head2")) {
    self attach("c_t9_cp_rus_hero_perseus_head2");
  }
}

function function_b132d5eb() {
  nd = getnode("nd_path_perseus_loose_ends", "targetname");
  self colors::disable();
  self ai::set_behavior_attribute("demeanor", "cqb");
  self thread spawner::go_to_node(nd);
  self.goalradius = 64;
  self waittill(#"goal");
  level flag::set("flag_perseus_in_pos");
  self thread dialogue::queue("vox_cp_duga_01300_pers_overherecomrade_88");
  level flag::wait_till("flag_perseus_path_1");
  level.player thread util::blend_movespeedscale(0.6, 5);
  self thread dialogue::queue("vox_cp_duga_01300_pers_thisisit_b2");
  level flag::wait_till("flag_perseus_path_2");
  self dialogue::queue("vox_cp_duga_01300_pers_yourfriendwentt_9c");
  self thread dialogue::queue("vox_cp_duga_01300_pers_heisnotfar_a1");
  level flag::wait_till("flag_perseus_path_4");
  level.player thread util::blend_movespeedscale(0.5, 2);
  self thread dialogue::queue("vox_cp_duga_01300_pers_comeoutandplayy_c6");
}

function function_f7d3abcf() {
  level.var_709556b8 = dialog_tree::new_tree(undefined, undefined, 1, 1, undefined, 0);
  dialog_tree::function_21780fc5(level.var_709556b8, [1224, 820]);
  var_f562392f = 1;
  level.var_709556b8 dialog_tree::add_option(#"hash_7b62db444c847d8", undefined, undefined, undefined, var_f562392f);
  level.var_709556b8 dialog_tree::function_6ebd37a4();
  level.var_709556b8 dialog_tree::add_option(#"hash_7b630b444c84cf1", undefined, undefined, undefined, var_f562392f);
  level.var_709556b8 dialog_tree::function_6ebd37a4();
}

function objectives() {
  objectives::scripted("obj_loose_ends", undefined, #"hash_34ca6a345039f8df");
  objectives::function_6a43edf3("obj_loose_ends");
  objectives::follow("obj_follow_perseus", level.perseus);
  level flag::wait_till("flag_loose_ends_obj");
  objectives::remove("obj_follow_perseus", level.perseus);
  s_org = struct::get("org_use_prompt_roof_doors", "targetname");
  objectives::goto("obj_loose_ends_door", s_org.origin, #"hash_34ca6a345039f8df");
  objectives::function_6a43edf3("obj_loose_ends_door");
  level flag::wait_till(#"hash_62d033072bf4254b");
  objectives::complete("obj_loose_ends_door");
  level flag::wait_till("flag_obj_kill_adler");
  objectives::update_position("obj_loose_ends", level.adler.origin);
  objectives::show("obj_loose_ends");
  level flag::wait_till("flag_adler_dead");
  objectives::complete("obj_loose_ends");
}

function function_45405080() {
  e_player = getplayers()[0];
  e_player endon(#"death");
  level flag::set("flag_loose_ends_obj");
  str_scene = "scene_duga_loose_ends";
  var_2759773 = struct::get("org_use_prompt_roof_doors", "targetname");
  var_2759773 prompts::create(#"use", #"hash_6e61bbc938438d7d");
  var_2759773 prompts::set_objective("obj_loose_ends_door");
  var_2759773 waittill(#"trigger");
  level.adler util::stop_magic_bullet_shield();
  namespace_82bfe441::fade(1, "FadeSlow");
  e_player showcrosshair(0);
  snd::play("evt_duga_door_open_start");
  level flag::set(#"hash_62d033072bf4254b");
  level thread function_a444d829();
  level thread function_d2a61d5e();
  result = level flag::wait_till_any(["flag_lighter_prompt_used", "flag_adler_killed_no_tappy"]);
  str_shot = "";

  if(result._notify === "flag_lighter_prompt_used") {
    namespace_e1ccb37b::music("4.1_adler_attack", 2);
    level.adler stopsounds();
    globallogic_ui::function_68bb2f48();
    level scene::stop(str_scene + "_adler");
    level scene::play("scene_duga_loose_ends_tappy", "enter", [getplayers()[0], level.adler]);

    if(isDefined(level.cig)) {
      level.cig delete();
    }

    level thread function_3babb313();
    level flag::wait_till("flag_stab_finished");
    str_shot = "tappy_response";
  } else {
    namespace_e1ccb37b::music("4.0_adler_shoot", 2);
    player_decision::function_8c0836dd(1);
    e_player stats::function_dad108fa(#"hash_36445583f679a898", 1);
    snd::play("vox_duga_tappy_adl_exert_struggle_failed_shot_death", level.adler.origin);
    level.player.var_5c361958 = gettime();

    if(level.player.var_5c361958 < level.player.var_bfd336b0) {
      str_shot = "quick_response";
    } else {
      str_shot = "slow_response";
    }
  }

  level flag::set(#"flag_obj_kill_adler");
  e_player showcrosshair(0);

  if(isDefined(level.cig)) {
    level.cig delete();
  }

  wait 1;
  level thread scene::play(str_scene, str_shot, [level.perseus]);
  level waittill(#"hash_7c0b0716af5a9907");
  level.perseus util::create_cursor_hint("j_spine4", undefined, "OBJECTIVES/TALK_TO", 60, undefined, undefined, undefined, undefined, undefined, 0, 1);
  level.perseus prompts::function_92127496(1);
  level.perseus prompts::function_1a5e1da6(#"use", 1);
  level.perseus waittill(#"trigger");
  namespace_e1ccb37b::music("5.0_comrade", 9.666);
  namespace_82bfe441::fade(1, "FadeMedium");
  e_player val::set(#"hash_23bfeea7d10f466b", "disable_weapons", 1);
  level.perseus.propername = # "hash_1208e1b319606beb";
  level thread scene::play(str_scene, "reveal", [level.perseus, e_player]);
  a_actors = [level.perseus, e_player];

  if(is_true(e_player.var_fcd1efa7)) {
    level flag::wait_till(#"hash_5bf9b069e98784a3");
    level thread lui::screen_fade_in(12, "black");
    array::run_all(a_actors, &dontinterpolate);
    level scene::play_from_time("scene_duga_loose_ends", "end", a_actors, 4, 0);
  } else {
    level waittill(#"hash_6166ba3b67203b5b");
    level thread namespace_e1ccb37b::function_5d245761();
    level.var_709556b8 dialog_tree::run();
    level thread function_fc788704();
    level scene::play("scene_duga_loose_ends", "end", a_actors);
  }

  level flag::set(#"flag_loose_ends_complete");
}

function function_bf27d987(params) {
  if(!is_true(level.player.var_fcd1efa7)) {
    return;
  }

  var_fd343efd = 3;
  level lui::screen_fade_out(var_fd343efd, "black");
  level.player val::set(#"hash_7aa136191c3f47ce", "freezecontrols", 1);
  level.perseus.fixednode = 1;
  level.perseus.goalradius = 8;
  level.perseus setgoal(level.perseus.origin, 1);
  level scene::stop("scene_duga_loose_ends");
  var_f21d44f0 = 3;
  wait var_f21d44f0;
  level flag::set(#"hash_5bf9b069e98784a3");
}

function function_fc788704() {
  level waittill(#"hash_505b6b5205f06dfd");
  wait 0.25;
  var_d7022772 = [];

  switch (level.var_de6ca1e4) {
    case 0:
      var_d7022772[var_d7022772.size] = "vox_cp_duga_01300_rms1_yescommander_41";
      break;
    case 1:
      var_d7022772[var_d7022772.size] = "vox_cp_duga_01300_rms1_yessir_f9_1";
      break;
    case 2:
      var_d7022772[var_d7022772.size] = "vox_cp_duga_01300_rms1_yesmaam_6e";
      break;
  }

  level thread dialogue::radio(var_d7022772[0]);
  player_decision::function_8c0836dd(0);
}

function function_d2a61d5e() {
  level endon(#"flag_adler_killed_no_tappy");
  str_scene = "scene_duga_loose_ends";
  e_player = getplayers()[0];
  e_player setstance("stand");
  level.player thread util::function_749362d7(1);
  a_actors = [e_player, level.perseus];
  scene::add_scene_func(str_scene, &function_e0799719, "quick_response");
  scene::add_scene_func(str_scene, &function_e0799719, "slow_response");
  level thread function_69d490da();
  level scene::stop("scene_duga_ending_prep");
  level thread scene::play(str_scene, "enter", a_actors);
  level scene::play(str_scene + "_adler", "enter", level.adler);
  level thread scene::play(str_scene + "_adler", "loop", level.adler, undefined, "loop");
}

function function_3babb313() {
  level endon(#"flag_tappy_succusseful");
  animation::add_notetrack_func("duga_loose_ends::stabby_tappy_success", &function_96bef5d0);
  s_org = struct::get("tag_align_loose_ends", "targetname");
  level.var_4ca79834 = 0.2;
  var_c85e6866 = 1;
  var_f01a6b5d = var_c85e6866;
  level.var_a9cc4859 = 8;
  var_6969be79 = "t9_duga_loose_ends_tappy_adler_struggle_bwd";
  var_9b3e2106 = "t9_duga_loose_ends_tappy_player_struggle_bwd";
  level.player thread animation::play(var_9b3e2106, s_org, undefined, var_c85e6866, undefined, undefined, undefined, 0.5);
  level.adler thread animation::play(var_6969be79, s_org, undefined, var_c85e6866, undefined, undefined, undefined, 0.5);
  var_b807e01e = var_6969be79;
  var_bb34c906 = var_9b3e2106;
  level thread function_6cfa94fc();
  level thread function_597bc742();
  var_3f6d9c15 = gettime();
  var_943b5c70 = 100;

  while(level.var_a9cc4859 > 0) {
    if(level.player.var_5588383e) {
      var_bb34c906 = "t9_duga_loose_ends_tappy_player_struggle_fwd";
      var_b807e01e = "t9_duga_loose_ends_tappy_adler_struggle_fwd";

      if(var_9b3e2106 === "t9_duga_loose_ends_tappy_player_struggle_fwd") {
        var_46096709 = level.player getanimtime(var_9b3e2106);
        var_f01a6b5d = var_c85e6866 - var_46096709;
      }
    } else {
      var_bb34c906 = "t9_duga_loose_ends_tappy_player_struggle_bwd";
      var_b807e01e = "t9_duga_loose_ends_tappy_adler_struggle_bwd";

      if(var_9b3e2106 === "t9_duga_loose_ends_tappy_player_struggle_bwd") {
        var_46096709 = level.player getanimtime(var_9b3e2106);
        var_f01a6b5d = var_c85e6866 - var_46096709;
      }
    }

    if(var_bb34c906 != var_9b3e2106) {
      var_facf831 = 1 - level.player getanimtime(var_9b3e2106);
      var_9b3e2106 = var_bb34c906;
      var_6969be79 = var_b807e01e;
      level.player thread animation::play(var_9b3e2106, s_org, undefined, abs(var_f01a6b5d), undefined, undefined, undefined, var_facf831);
      level.adler thread animation::play(var_6969be79, s_org, undefined, abs(var_f01a6b5d), undefined, undefined, undefined, var_facf831);
    }

    if(var_9b3e2106 === "t9_duga_loose_ends_tappy_player_struggle_bwd" && level.player getanimtime(var_9b3e2106) >= 0.9) {
      level.player thread animation::play("t9_duga_loose_ends_tappy_player_struggle_bwd", s_org, undefined, undefined, undefined, undefined, undefined, level.player getanimtime("t9_duga_loose_ends_tappy_player_struggle_bwd"), undefined, undefined, undefined, 1);
      level.adler thread animation::play("t9_duga_loose_ends_tappy_adler_struggle_bwd", s_org, undefined, undefined, undefined, undefined, undefined, level.adler getanimtime("t9_duga_loose_ends_tappy_adler_struggle_bwd"), undefined, undefined, undefined, 1);
    } else if(gettime() > var_3f6d9c15) {
      var_3f6d9c15 = gettime() + var_943b5c70;

      if(var_9b3e2106 === "t9_duga_loose_ends_tappy_player_struggle_fwd") {
        var_facf831 = level.player getanimtime(var_9b3e2106);
      } else {
        var_facf831 = 1 - level.player getanimtime(var_9b3e2106);
      }

      level.player thread animation::play(var_9b3e2106, s_org, undefined, abs(var_f01a6b5d), undefined, undefined, undefined, level.player getanimtime(var_9b3e2106));
      level.adler thread animation::play(var_6969be79, s_org, undefined, abs(var_f01a6b5d), undefined, undefined, undefined, level.adler getanimtime(var_6969be79));
    }

    level notify(#"hash_5af8d085be324dbd", {
      #var_9b3e2106: var_9b3e2106
    });
    waitframe(1);

    if(getdvarint(#"hash_5f59e2eecf43cc72", 0)) {
      continue;
    }

    level.var_a9cc4859 -= 0.05;
  }

  var_46096709 = level.player getanimtime(var_9b3e2106);
  var_21b989e8 = 0;

  if(var_9b3e2106 === "t9_duga_loose_ends_tappy_player_struggle_fwd" && var_46096709 >= 0.65) {
    var_21b989e8 = 1;
  } else if(var_9b3e2106 === "t9_duga_loose_ends_tappy_player_struggle_bwd" && var_46096709 <= 0.35) {
    var_21b989e8 = 1;
  }

  namespace_e1ccb37b::music("4.2_adler_fail", 3);

  if(var_21b989e8) {
    level thread function_96bef5d0();
  }

  level notify(#"hash_4a089c22c924242b");
  level thread function_f6da646d();

  if(var_9b3e2106 === "t9_duga_loose_ends_tappy_player_struggle_fwd") {
    var_facf831 = 1 - level.player getanimtime(var_9b3e2106);
    var_c5c054a5 = 1 - level.adler getanimtime(var_6969be79);
    var_9b3e2106 = "t9_duga_loose_ends_tappy_player_struggle_bwd";
    var_6969be79 = "t9_duga_loose_ends_tappy_adler_struggle_bwd";
    level.player thread animation::play(var_9b3e2106, s_org, undefined, var_f01a6b5d, undefined, undefined, undefined, var_facf831);
    level.player thread function_5235e07c();
    level.adler animation::play(var_6969be79, s_org, undefined, var_f01a6b5d, undefined, undefined, undefined, var_c5c054a5);
  } else {
    var_facf831 = level.player getanimtime(var_9b3e2106);
    var_c5c054a5 = level.adler getanimtime(var_6969be79);
    level.player thread animation::play(var_9b3e2106, s_org, undefined, 1, undefined, undefined, undefined, var_facf831);
    level.player thread function_5235e07c();
    level.adler animation::play(var_6969be79, s_org, undefined, 1, undefined, undefined, undefined, var_c5c054a5);
  }

  level flag::set("flag_tappy_failed");
  level.player val::set(#"tappy_failed", "health_regen", 0);
  level thread scene::play("scene_duga_loose_ends_tappy", "lose", [level.player, level.adler]);
  level waittill(#"scene_end");
  level.player thread animation::play("t9_duga_loose_ends_tappy_player_lose", s_org, undefined, 1, undefined, undefined, undefined, 1, undefined, undefined, undefined, 1);
  level.adler thread animation::play("t9_duga_loose_ends_tappy_adler_lose", s_org, undefined, 1, undefined, undefined, undefined, 1, undefined, undefined, undefined, 1);
  util::missionfailedwrapper();
}

function function_cc592b59(a_ents) {
  level.var_3b2b8e1f = a_ents[# "lighter"];
}

function function_a444d829() {
  level.player endon(#"death");
  level waittill(#"hash_5769defdfaab860d");
  level endon(#"flag_adler_killed_no_tappy");
  level.player.var_38ea0d27 = gettime();
  level.player.var_bfd336b0 = level.player.var_38ea0d27 + 12000;
  level.player thread util::function_749362d7(0);
  level.adler thread function_699d75f9();
  namespace_82bfe441::fade(0, "FadeSlow");
  level.player showcrosshair(1);
  savegame::checkpoint_save(1);
  level.var_3b2b8e1f prompts::create(#"use", #"hash_7ae9240d49eb6672");
  level.var_3b2b8e1f waittill(#"trigger");
  objectives::complete(#"hash_5b3068f26c6db392");
  level flag::set("flag_lighter_prompt_used");
}

function function_699d75f9() {
  level endon(#"flag_lighter_prompt_used");
  level.player.nohitmarkers = 1;
  damage = self waittill(#"damage");
  waitframe(1);
  level.player.nohitmarkers = 0;
  old_health = self.health;
  self.health = 0;
  damage.attacker thread damagefeedback::update(damage.mod, damage.attacker, undefined, damage.weapon, self, undefined, undefined, 1);
  self.health = old_health;

  if(isDefined(self)) {
    level scene::stop("scene_duga_loose_ends_adler");
    level thread scene::play("scene_duga_loose_ends_adler", "death", [self]);
    level.player val::set(#"hash_36cb7096582b221d", "show_hit_marker", 0);
    self stopsounds();
    level flag::set("flag_adler_killed_no_tappy");
    level.var_3b2b8e1f util::remove_cursor_hint();
  }
}

function function_5235e07c() {
  self endon(#"death");
  self waittill(#"hash_4c606409d590ec9c");
  self clientfield::set_to_player("pstfx_player_stabbed", 1);
  self dodamage(self.health * 0.5, level.adler.origin, level.adler, level.adler);
  self waittill(#"hash_4c606709d590f1b5");
  self dodamage(self.health * 0.3, level.adler.origin, level.adler, level.adler);
}

function function_597bc742() {
  level.adler endon(#"death");
  level.player endon(#"death");
  level endon(#"hash_4a089c22c924242b");
  level.player.var_5588383e = 0;
  e_tag = util::spawn_model("tag_origin", level.adler gettagorigin("j_neck"), level.adler gettagangles("j_neck"));
  e_tag linkto(level.adler, "j_neck");
  level.adler.var_5fedded0 = e_tag;
  e_tag prompts::function_c97a48c7(#"use_tap", {
    #var_de6f0004: 0, #var_4ac77177: 0, #var_5e83875a: 270, #var_87c991f3: 128, #var_8ce60046: 0, #var_be77841a: 0
  });
  e_tag prompts::function_44d7831a(#"use_tap", 2, 0);

  while(true) {
    str_result = level.adler.var_5fedded0 waittilltimeout(0.4, #"trigger");

    if(str_result._notify === "trigger") {
      level.player.var_5588383e = 1;
      continue;
    }

    level.player.var_5588383e = 0;
  }
}

function function_f6da646d() {
  level.adler.var_5fedded0 prompts::remove(#"use_tap");
  level.adler.var_5fedded0 delete();
}

function function_6cfa94fc() {
  level endon(#"hash_4a089c22c924242b");

  while(true) {
    screenshake((15122.8, 10937.6, 355.704), 0.3 * randomfloatrange(0.8, 1.2), 0.1 * randomfloatrange(0.8, 1.2), 0.2 * randomfloatrange(0.8, 1.2), 0.2, 0, 0, 0, 9.6 * randomfloatrange(0.8, 1.2), 5.8 * randomfloatrange(0.8, 1.2), 11 * randomfloatrange(0.8, 1.2), 50 * randomfloatrange(0.8, 1.2));
    wait 0.2;
  }
}

function function_3ced19b6(sourcepoint, scalepitch, var_7a0e1e7a, var_296bd501, duration, durationfadeup, durationfadedown, radius, var_c6c2e5d9, var_d8508ca6, var_9588f89f, exponent) {
  return {
    #sourcepoint: sourcepoint, #scalepitch: scalepitch, #var_7a0e1e7a: var_7a0e1e7a, #var_296bd501: var_296bd501, #duration: duration, #durationfadeup: durationfadeup, #durationfadedown: durationfadedown, #radius: radius, #var_c6c2e5d9: var_c6c2e5d9, #var_d8508ca6: var_d8508ca6, #var_9588f89f: var_9588f89f, #exponent: exponent
  };
}

function function_96bef5d0(params) {
  if(level flag::get("flag_tappy_succusseful")) {
    return;
  }

  level flag::set("flag_tappy_succusseful");
  level notify(#"hash_4a089c22c924242b");
  namespace_e1ccb37b::music("4.2_adler_fail", 3);
  level thread function_f6da646d();
  s_org = struct::get("tag_align_loose_ends", "targetname");
  var_46096709 = level.player getanimtime("t9_duga_loose_ends_tappy_player_struggle_fwd");

  if(var_46096709 < 0.3) {
    var_46096709 = 1 - level.player getanimtime("t9_duga_loose_ends_tappy_player_struggle_bwd");
  }

  level.player thread animation::play("t9_duga_loose_ends_tappy_player_struggle_fwd", s_org, undefined, 1, undefined, undefined, undefined, var_46096709);
  level.adler animation::play("t9_duga_loose_ends_tappy_adler_struggle_fwd", s_org, undefined, 1, undefined, undefined, undefined, var_46096709);
  level.adler setCanDamage(1);
  level scene::play("scene_duga_loose_ends_tappy", "win", [level.player, level.adler]);
  level.adler function_de4103eb();
  level flag::set("flag_stab_finished");
}

function function_e0799719(a_ents) {
  level.var_20c5b092 = a_ents[# "radio"];
}

function function_69d490da() {
  level endon(#"flag_adler_dead");
  level waittill(#"hash_64d9dd69bbc846e9");
  level thread scene::play("scene_duga_loose_ends", "nag", [level.perseus]);
}

function function_de4103eb() {
  self stopsounds();
  self kill(level.player.origin, level.player, level.player, undefined, undefined, 1);
  level flag::set("flag_adler_dead");
}

function function_ea8ca6bb() {
  a_weapons = self getweaponslist();

  foreach(w in a_weapons) {
    self givemaxammo(w);
    self setweaponammoclip(w, w.clipsize);
  }
}

function function_f5d9adcd(str_objective) {
  spawner::simple_spawn("spawner_perseus_forces", &function_c50c5a2a);
  level thread scene::init_streamer(#"scene_duga_loose_ends", getplayers());
  level thread scene::init_streamer(#"scene_duga_loose_ends_adler", getplayers());
  level thread scene::init_streamer(#"scene_duga_loose_ends_tappy", getplayers());
  level.perseus = spawner::simple_spawn_single("perseus");
  level.perseus setteam(#"allies");
  level.perseus setgoal(level.perseus.origin);
  level.perseus.goalradius = 32;
  level.perseus thread namespace_ac5221d7::function_f42f6f14();
  level.perseus util::magic_bullet_shield();
  level scene::add_scene_func("scene_duga_loose_ends_tappy", &function_a444d829, "init");
  level scene::init("scene_duga_loose_ends_tappy");
}

function function_dbe8c8f4(str_objective, b_skipto) {
  level thread function_f7d3abcf();
  var_b9335c1c = getent("roof_door_clip", "targetname");
  door_left = getent("door_left", "targetname");
  door_right = getent("door_right", "targetname");
  door_left.animname = "door_left";
  door_right.animname = "door_right";
  box02 = getent("box02", "targetname");
  box02.animname = "box02";
  box03 = getent("box03", "targetname");
  box03.animname = "box03";
  box04 = getent("box04", "targetname");
  box04.animname = "box04";
  extinguisher = getent("extinguisher", "targetname");
  extinguisher.animname = "extinguisher";
  level.cig = getent("cigarette", "targetname");
  level.cig.animname = "cigarette";
  namespace_e1ccb37b::music("deactivate_2.0_ambush");
  animation::add_notetrack_func("duga_loose_ends::perseus_swap_to_nomask", &function_648dc3bf);
  e_player = getplayers()[0];
  frag = getweapon(#"frag_grenade");

  if(e_player hasweapon(frag)) {
    e_player setweaponammoclip(frag, 0);
    e_player setweaponammostock(frag, 0);
  }

  e_player = getplayers()[0];
  namespace_82bfe441::fade(1, "FadeSlow");
  e_player showcrosshair(0);
  level flag::set(#"hash_62d033072bf4254b");
  level.adler = spawner::simple_spawn_single("adler_wounded_ending");
  level.adler setteam(#"axis");
  level.adler val::set(#"hash_1fb077ac0e51edb6", "take_weapons", 1);
  level.adler.var_c681e4c1 = 1;
  level.adler setCanDamage(1);
  level.adler ai::gun_remove();
  level.adler.skipdeath = 1;
  level.adler.health = 1;
  level.adler.animname = "adler";
  level flag::set(#"hash_62d033072bf4254b");
  level thread scene::play_from_time("scene_duga_loose_ends_adler", "enter", level.adler, 0.9, 1);
  level thread scene::play_from_time("scene_duga_loose_ends", "enter", [level.player, level.perseus], 0.9, 1);
  namespace_e1ccb37b::music("4.0_adler");
  result = level flag::wait_till_any(["flag_lighter_prompt_used", "flag_adler_killed_no_tappy"]);
  str_scene = "scene_duga_loose_ends";
  str_shot = "";
  scene::add_scene_func(str_scene, &function_e0799719, "quick_response");
  scene::add_scene_func(str_scene, &function_e0799719, "slow_response");

  if(result._notify === "flag_lighter_prompt_used") {
    namespace_e1ccb37b::music("4.1_adler_attack");
    level.adler stopsounds();
    level scene::stop(str_scene + "_adler");
    level scene::play("scene_duga_loose_ends_tappy", "enter", [getplayers()[0], level.adler]);
    level thread function_3babb313();
    level flag::wait_till("flag_stab_finished");
    str_shot = "tappy_response";
  } else {
    namespace_e1ccb37b::music("4.0_adler_shoot", 3);
    level.player.var_5c361958 = gettime();

    if(level.player.var_5c361958 < level.player.var_bfd336b0) {
      str_shot = "quick_response";
    } else {
      str_shot = "slow_response";
    }
  }

  level flag::set(#"flag_obj_kill_adler");

  if(isDefined(level.cig)) {
    level.cig delete();
  }

  wait 1;
  level thread scene::play(str_scene, str_shot, [level.perseus]);
  level waittill(#"hash_7c0b0716af5a9907");
  level.perseus util::create_cursor_hint("j_spine4", undefined, "OBJECTIVES/TALK_TO", 80, undefined, undefined, undefined, undefined, 0);
  level.perseus prompts::function_92127496(1);
  level.perseus prompts::function_1a5e1da6(#"use", 1);
  level.perseus waittill(#"trigger");
  namespace_e1ccb37b::music("5.0_comrade", 9.666);
  namespace_82bfe441::fade(1, "FadeMedium");
  e_player showcrosshair(0);
  e_player val::set(#"hash_23bfeea7d10f466b", "disable_weapons", 1);
  level thread scene::play(str_scene, "reveal", [level.perseus, e_player]);
  level waittill(#"hash_6166ba3b67203b5b");
  a_actors = [level.perseus, e_player];
  level.var_709556b8 dialog_tree::run();
  var_d7022772 = [];

  switch (level.var_de6ca1e4) {
    case 0:
      var_d7022772[var_d7022772.size] = "vox_cp_duga_01300_rms1_yescommander_41";
      break;
    case 1:
      var_d7022772[var_d7022772.size] = "vox_cp_duga_01300_rms1_yessir_f9_1";
      break;
    case 2:
      var_d7022772[var_d7022772.size] = "vox_cp_duga_01300_rms1_yesmaam_6e";
      break;
  }

  var_d7022772[var_d7022772.size] = "vox_cp_duga_01300_rms1_asyoucommandper_91";
  level.player thread dialogue::radio(array::random(var_d7022772));
  level scene::play("scene_duga_loose_ends", "end", a_actors);
  level flag::set(#"flag_loose_ends_complete");
  level flag::wait_till("forever");
}