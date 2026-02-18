/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_nam_prisoner_rat_tunnels.gsc
***********************************************/

#using script_1351b3cdb6539f9b;
#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_5a7c9cfbe3d9580c;
#using script_61fee52bb750ac99;
#using scripts\core_common\ai\zombie_eye_glow;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_nam_prisoner;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd_utility;
#using scripts\cp_common\util;
#namespace cp_nam_prisoner_rat_tunnels;

function start(str_objective) {
  level thread function_4b429874("rat_tunnels");
}

function main(str_objective, var_50cc0d4f) {
  if(level.var_731c10af.var_42659717 == 0) {
    next_obj = "path_end_1";
  }

  if(level.var_731c10af.var_42659717 == 1) {
    next_obj = "path_end_2";
  }

  if(level.var_731c10af.var_42659717 == 2) {
    next_obj = "path_end_3";
  }

  if(level.var_731c10af.var_42659717 == 3) {
    next_obj = "path_end_4";
  }

  level thread cp_nam_prisoner::function_1f911b89(next_obj);
  flag = "rat_tunnels";
  level flag::wait_till(flag + "_complete");
  level skipto::function_4e3ab877(var_50cc0d4f, 0);
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  wait 1;
  enemy_rat_tunnels_large = getEntArray("enemy_rat_tunnels_large", "targetname");
  array::thread_all(enemy_rat_tunnels_large, &namespace_d9b153b9::ent_cleanup);
  enemy_rat_tunnels_hall = getEntArray("enemy_rat_tunnels_hall", "targetname");
  array::thread_all(enemy_rat_tunnels_hall, &namespace_d9b153b9::ent_cleanup);
  rat_tunnels_triggers = getEntArray("rat_tunnels_triggers", "script_noteworthy");
  array::thread_all(rat_tunnels_triggers, &namespace_d9b153b9::ent_cleanup);
  door_struct = namespace_d9b153b9::door_setup("rat_tunnels_door_struct", 1, 1);
  door_struct thread namespace_d9b153b9::ent_cleanup();
}

function function_c26b0bc0() {
  level flag::init("rat_tunnels_complete");
  level flag::init("flag_rat_tunnels_obj_on");
  level flag::init("flag_disable_rat_tunnel_trap");
  level flag::init("flag_enable_rat_tunnel_trap_damage");
  level flag::init("flag_rat_tunnels_player_dead");
}

function rat_tunnels() {
  level endon(#"start_outro");
  var_c79d614f = "rat_tunnels";
  level flag::wait_till("flag_" + var_c79d614f);
  level.var_3f5c80c8 = "rat_tunnels";
  level.player clientfield::set_to_player("force_stream_weapons", 6);
  level.player util::delay(3, undefined, &clientfield::set_to_player, "rt_character_visibility", 2);
  level thread savegame::checkpoint_save();
  var_2cf9fe23 = level.var_731c10af.var_42659717 + 1;
  str = "visit_" + var_2cf9fe23 + "_" + var_c79d614f;
  bb::function_cd497743(str, level.player);

  while(true) {
    level thread namespace_d9b153b9::function_a57f6629(var_c79d614f);
    level function_a7ec2e8f(var_c79d614f);

    if(level flag::get(var_c79d614f + "_complete")) {
      break;
    }

    wait 0.5;
    level flag::wait_till("flag_" + var_c79d614f);
  }

  level.player clientfield::set_to_player("lerp_fov", 0);
  level thread scene::init("scene_rat_tunnel_entrance");
}

function function_4b429874(var_c79d614f) {
  level thread scene::init("scene_rat_tunnel_entrance");

  if(level flag::get("exit_ready")) {
    return;
  }

  if(isDefined(level.var_731c10af.paths[# "rat_tunnels"].count) && level.var_731c10af.paths[# "rat_tunnels"].count != 0) {
    return;
  }

  var_378b332b = struct::get("struct_rat_tunnel_trap_door", "targetname");
  var_271a2988 = spawn("script_model", var_378b332b.origin);
  var_271a2988 setModel("tag_origin");
  var_271a2988 util::create_cursor_hint("tag_origin", (0, 0, 8), #"hash_4aba34f692d535a6", 300, undefined, undefined, undefined, 512);
  thread function_c4c216b0(var_271a2988);
  var_271a2988 waittill(#"trigger");
  level flag::set("flag_rat_tunnels");
  level districts::function_a7d79fcb(["rat_tunnels"]);
  thread namespace_b6fe1dbe::function_1e0e9b39(var_c79d614f);
  wait 2;
  level thread dialogue::radio("vox_cp_prsn_02200_adlr_whyisfacingaway_ab");
}

function function_c4c216b0(var_271a2988) {
  var_271a2988 util::waittill_any_ents(var_271a2988, "trigger", level, "visit_restart");
  var_271a2988 util::remove_cursor_hint();
  var_271a2988 delete();
}

function function_a7ec2e8f(var_c79d614f) {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  level endon(var_c79d614f + "_end");
  level.disableweapondrop = 1;
  level thread function_a1c9e125();
  level thread function_6deb6ac2();
  level thread function_9bea58bf();
  level thread function_1fd8aab8(var_c79d614f);
  level thread function_782d78d1(var_c79d614f);
  level function_4e2f193b();
  level function_c0073eb7();
  level.disableweapondrop = 0;
  level flag::wait_till(var_c79d614f + "_door_opened");
  namespace_d9b153b9::function_e106e062(var_c79d614f);
  level flag::set(var_c79d614f + "_complete");
  level flag::set(var_c79d614f + "_exited");
}

function function_1fd8aab8(var_c79d614f) {
  namespace_82bfe441::fade(1, "FadeImmediate");
  var_4c7200d2 = getent("clip_rat_tunnel_ladder", "targetname");
  var_a5cfc1d9 = getEntArray("model_rat_tunnels_ladder", "targetname");
  level thread namespace_b6fe1dbe::function_3047c3a4();
  var_4c7200d2 delete();

  foreach(e_model in var_a5cfc1d9) {
    e_model delete();
  }

  level.player enableinvulnerability();
  level.player val::set(#"hash_1758bde589c2e32c", "freezecontrols", 1);
  level.player val::set(#"hash_1758bde589c2e32c", "disable_weapons", 1);
  level globallogic_ui::function_d0a59ab9();
  level scene::play("scene_rat_tunnel_entrance", "shot 1");
  level.player clientfield::set_to_player("lerp_fov", 5);
  wait 1;
  level.player setstance("crouch");
  level.player disableinvulnerability();
  level flag::set("flag_rat_tunnels_entrance_progression");
}

function function_782d78d1(var_c79d614f) {
  level flag::wait_till("flag_rat_tunnels_entrance_progression");
  level thread namespace_b6fe1dbe::music("9.0_zombies");
  wait 1;
  level thread function_ef3d3d18(var_c79d614f);
  wait 3;
  level thread namespace_d9b153b9::force_weapon_loadout("rat_tunnels");
  namespace_82bfe441::fade(0, "FadeMedium");
  level globallogic_ui::function_16b7aa78();
  level.player val::reset(#"hash_1758bde589c2e32c", "freezecontrols");
  level.player val::reset(#"hash_1758bde589c2e32c", "disable_weapons");
  level.player.var_cef36b49 = 0;
  level.player function_6afceef5();
  level.player thread function_441539b();
  level.player function_bc4360c2();
  level flag::wait_till("flag_rat_tunnels_entrance_map");
  level flag::wait_till("flag_rat_tunnels_entrance_tunnel");
  function_2c200d72(var_c79d614f);
}

function function_2c200d72(var_c79d614f) {
  var_f1653cd7 = spawner::simple_spawn_single("enemy_rat_tunnels_hall", &function_b331c583);
  level.var_c6a04675 = 0.5;
  level.var_22caf5d5 = 2;
  thread namespace_b6fe1dbe::function_8c05dc42(var_f1653cd7);
  thread namespace_b6fe1dbe::rat_tunnels_amb_zombies();
  wait 2;

  if(isalive(var_f1653cd7)) {
    util::stop_magic_bullet_shield(var_f1653cd7);
    var_f1653cd7 delete();
  }

  level.var_c6a04675 = 1;
  level.var_22caf5d5 = 3;
}

function function_9bea58bf() {
  level thread namespace_d9b153b9::function_c318ce4a("light_rat_tunnel_torch");
  level thread namespace_d9b153b9::function_c318ce4a("light_rat_tunnel_door");
  level thread namespace_b508dca::function_ed113f39(1, "rat_tunnels_door_struct");
  level flag::wait_till("flag_rat_tunnels_large_enter");
  wait 3;
  thread namespace_b6fe1dbe::rat_tunnels_throb_high();
}

function function_6deb6ac2() {
  e_model = getent("model_rat_tunnel_rock_blocker", "targetname");
  e_clip = getent("clip_rat_tunnel_blocker", "targetname");
  e_model hide();
  e_clip hide();
  level flag::wait_till("flag_rat_tunnels_large_enter");
  e_model show();
  e_clip show();
}

function function_4e2f193b() {
  level flag::wait_till("flag_rat_tunnels_large_enter");
  level thread savegame::checkpoint_save();
  level notify(#"hash_1f23b5e993149d88");
  level childthread function_7c0058e9();
  wait 10;
  level.player val::set("rat_fight", "allowdeath", 0);
  level.var_9d4a1f15 = 0;
  callback::on_player_damage(&function_6b6ab2a9);
  level function_67ae9ffa();
}

function function_7c0058e9() {
  i = 0;

  for(wait_time = 6; true; wait_time = 1) {
    var_97f2da81 = function_152d5ce7();
    var_6758a09d = function_a7dd4e7f(var_97f2da81);

    if(level flag::get("flag_rat_tunnels_player_dead")) {
      break;
    }

    if(!isDefined(var_6758a09d)) {
      waitframe(1);
      continue;
    }

    snd::play("amb_rat_tunnels_zomb_amb", var_6758a09d.origin);
    wait wait_time;
    i += wait_time;
    wait_time -= 2;

    if(wait_time < 1) {}
  }
}

function function_67ae9ffa() {
  level endon(#"flag_rat_tunnels_player_dead");
  childthread function_a8e922fd();
  level.var_c6a04675 = 0.5;
  level.var_22caf5d5 = 2;
  wait 5;
  childthread function_a8e922fd();
  wait 5;
  i = 0;

  while(i < 5) {
    if(level flag::get("flag_rat_tunnels_player_dead")) {
      break;
    }

    childthread function_a8e922fd();
    i++;

    if(level flag::get("flag_rat_tunnels_player_dead")) {
      break;
    }

    wait randomfloatrange(2.5, 4);
  }

  i = 0;

  while(true) {
    if(level flag::get("flag_rat_tunnels_player_dead")) {
      break;
    }

    childthread function_a8e922fd();
    i++;

    if(level flag::get("flag_rat_tunnels_player_dead")) {
      break;
    }

    if(i >= 5) {
      wait 0.25;
      childthread function_a8e922fd();
      i++;
    }

    if(level flag::get("flag_rat_tunnels_player_dead")) {
      break;
    }

    if(i >= 12) {
      wait 0.25;
      childthread function_a8e922fd();
      i++;
    }

    if(level flag::get("flag_rat_tunnels_player_dead")) {
      break;
    }

    wait randomfloatrange(0.5, 3);
  }
}

function function_a8e922fd() {
  if(level flag::get("flag_rat_tunnels_player_dead")) {
    return;
  }

  var_4caaf0f5 = function_bc8dde2();
  a_e_enemies = getaiteamarray("axis");

  if(var_4caaf0f5.size - 1 > 0 && a_e_enemies.size <= 10) {
    var_a881a891 = function_a7dd4e7f(var_4caaf0f5);
    e_enemies = spawner::simple_spawn(var_a881a891, &function_4dab8b6d);
    ai::waittill_dead(e_enemies);
  }
}

function function_bc8dde2() {
  var_b162e4f3 = getspawnerarray("enemy_rat_tunnels_large", "targetname");
  var_4caaf0f5 = function_f2189eab(var_b162e4f3);
  return var_4caaf0f5;
}

function function_152d5ce7() {
  var_48dd9943 = struct::get_array("struct_rat_tunnels_large", "targetname");
  var_7aae50ea = function_f2189eab(var_48dd9943);
  return var_7aae50ea;
}

function function_f2189eab(var_32ec319a) {
  var_785516d0 = [];

  foreach(s_object in var_32ec319a) {
    var_bdfc75d9 = level.player util::point_in_fov(s_object.origin, 0.423, 1);

    if(!var_bdfc75d9) {
      if(!isDefined(var_785516d0)) {
        var_785516d0 = [];
      } else if(!isarray(var_785516d0)) {
        var_785516d0 = array(var_785516d0);
      }

      var_785516d0[var_785516d0.size] = s_object;
    }
  }

  return var_785516d0;
}

function function_a7dd4e7f(var_32ec319a) {
  if(var_32ec319a.size - 1 > 0) {
    s_object = var_32ec319a[randomint(var_32ec319a.size - 1)];
    return s_object;
  }

  return undefined;
}

function function_6b6ab2a9(params) {
  var_7639372f = level.player getnormalhealth();

  if(var_7639372f <= 0.25 && !level.var_9d4a1f15) {
    level.var_9d4a1f15 = 1;
    level callback::remove_on_player_damage(&function_6b6ab2a9);
    level.player.health = 1;
    level.player setstance("prone");
    level.player val::set("teleport_controls", "freezecontrols", 1);
    level thread lui::screen_fade_out(0.5, "black");
    level notify(#"hash_6092ec21fbb6a05");
    level flag::set("flag_rat_tunnels_player_dead");
    wait 0.6;
    a_e_enemies = getactorarray("axis");

    foreach(e_enemy in a_e_enemies) {
      if(isalive(e_enemy)) {
        e_enemy delete();
      }
    }

    util::function_323d3227();
    s_teleport = struct::get("struct_rat_tunnels2_lookat_door", "targetname");
    e_teleport = util::spawn_model("tag_origin", s_teleport.origin, s_teleport.angles);
    level.player setorigin(e_teleport.origin);
    level.player playerlinktodelta(e_teleport, "tag_origin", 0, 0, 0, 0, 0);
    thread namespace_b6fe1dbe::rat_tunnels_ambience_fade_out();
    level notify(#"rat_tunnels_ambience_fade_out");
    wait 7;
    level thread lui::screen_fade_in(0.5, "black");
    wait 0.25;
    e_teleport delete();
    level.player unlink();
    level.player disableinvulnerability();
    level.player setstance("stand");
    level.player val::set("teleport_controls", "freezecontrols", 0);
    level.player val::set("rat_fight", "allowdeath", 1);
  }
}

function function_c0073eb7() {
  if(level.player.var_cef36b49) {
    level.player function_6afceef5();
  }

  function_ae264f6a();
  level.player util::function_658a8750(3);
  wait 0.6;
  level thread namespace_d9b153b9::function_b96db417("light_rat_tunnel_door");
  level thread namespace_b508dca::function_ed113f39(undefined, "rat_tunnels_door_struct");
}

function function_b331c583() {
  self.goalradius = 16;
  self.grenadeammo = 0;
  self.holdfire = 1;
  self.ignoreall = 1;
  self setdesiredspeed(150);
  self.forcesprint = 1;
  util::magic_bullet_shield(self);
  self.var_c681e4c1 = 1;
}

function function_4dab8b6d() {
  self.goalradius = 16;
  self.grenadeammo = 0;
  self.holdfire = 1;
  self.forcesprint = 1;
  self.dontdropweapon = 1;
  self.var_c681e4c1 = 1;
  self.zombie_move_speed = "sprint";
  self setdesiredspeed(250);
  self ai::set_behavior_attribute("disablearrivals", 1);
  self ai::set_behavior_attribute("demeanor", "combat");
  self zombie_eye_glow::function_b43f92cd(1);
  self thread function_c82c7ffe();
  self thread function_42ac3805();

  while(isalive(self)) {
    if(isDefined(level.player)) {
      var_1c7be65d = getclosestpointonnavmesh(level.player.origin, 64, 16);
      self thread ai::force_goal(var_1c7be65d);
    }

    waitframe(1);
  }
}

function function_c82c7ffe() {
  while(isalive(self)) {
    snd::play("amb_rat_tunnels_zomb_scream", [self, "j_head"]);
    wait randomfloatrange(1.5, 4);
  }
}

function function_42ac3805() {
  while(isalive(self)) {
    snd::play("amb_rat_tunnels_zomb_step", [self, "tag_origin"]);
    wait randomfloatrange(0.2, 0.3);
  }
}

function function_15ea2f81() {
  self endon(#"death");
  self.grenadeammo = 0;
  self.var_c681e4c1 = 1;
  level flag::wait_till("flag_rat_tunnels_alcove1");

  while(true) {
    level scene::play("scene_rat_tunnels2_first_tunnel_alcove", "shot 3", self);
    level thread scene::play("scene_rat_tunnels2_first_tunnel_alcove", "shot 2", self);
    wait randomfloatrange(1.5, 3.25);
  }
}

function function_441539b() {
  level endon(#"hash_6092ec21fbb6a05");
  level.player function_2d7d736();
}

function function_4f5b7f27() {
  while(!level.player.var_cef36b49) {
    waitframe(1);
  }

  level notify(#"hash_24e533c13c2740b6");
}

function function_a1c9e125() {
  level notify(#"waterfall_end_vo_idle");
  level notify(#"hash_411bceb4b6375aff");
}

function function_ef3d3d18(var_c79d614f) {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  level endon(var_c79d614f + "_end");
  var_798585bd = 1;
  dialogue::radio("vox_cp_prsn_13500_adlr_atunnelyouuhyou_c8");
  level flag::wait_till("flag_rat_tunnels_entrance_map");
  childthread namespace_d9b153b9::function_f6cbf7fd(&function_d727891e, 1, 15, "flag_rat_tunnels_large_enter");
  level flag::wait_till("flag_rat_tunnels_player_dead");
  thread namespace_b6fe1dbe::function_64a39ad();
  wait 3.2;
  thread dialogue::radio("vox_cp_prsn_14900_adlr_stoplyingbellst_cc");
  thread namespace_b6fe1dbe::rat_tunnels_ambience_fade_out();
  level notify(#"rat_tunnels_ambience_fade_out");
  wait 7;
}

function function_d727891e() {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  level endon(#"hash_6404f5fcf0805b8e");
  level endon(#"hash_1f23b5e993149d88");
  dialogue::radio("vox_cp_prsn_14900_adlr_thisisallextrem_0e");
}

function function_2d7d736() {
  self endon(#"death");

  while(true) {
    if(self actionslotthreebuttonPressed() && !self sprintbuttonPressed()) {
      self function_6afceef5();

      while(self actionslotthreebuttonPressed()) {
        waitframe(1);
      }

      continue;
    } else {
      waitframe(1);
      continue;
    }

    if(self actionslotthreebuttonPressed()) {
      self function_6afceef5();

      while(self actionslotthreebuttonPressed()) {
        waitframe(1);
      }

      continue;
    }

    waitframe(1);
  }
}

function function_6afceef5() {
  if(self.var_cef36b49) {
    self clientfield::set_to_player("rt_flashlight", 0);
    self.var_cef36b49 = 0;
    exploder::stop_exploder("flashlight_probes");
    self util::function_5b2f930e(3, #"uie_ui_hud_cp_actionslot_icon_black_light");
    return;
  }

  self util::function_5b2f930e(3, #"hash_7d3611ef4bd2af93");
  self clientfield::set_to_player("rt_flashlight", 1);
  self.var_cef36b49 = 1;
  exploder::exploder("flashlight_probes");
}

function function_bc4360c2() {
  probe = getent("flashlight_probe_1", "targetname");

  if(isDefined(probe)) {
    probe linkto(self, "tag_eye", (80, 0, 0), (0, 0, 0));
  }

  probe = getent("flashlight_probe_2", "targetname");

  if(isDefined(probe)) {
    probe linkto(self, "tag_eye", (-32, 0, 0), (0, 0, 0));
  }

  probe = getent("flashlight_near_probe", "targetname");

  if(isDefined(probe)) {
    probe linkto(self, "tag_eye", (8, 0, 0), (0, 0, 0));
  }
}

function function_ae264f6a() {
  probe = getent("flashlight_probe_1", "targetname");

  if(isDefined(probe)) {
    probe unlink();
  }

  probe = getent("flashlight_probe_2", "targetname");

  if(isDefined(probe)) {
    probe unlink();
  }

  probe = getent("flashlight_near_probe", "targetname");

  if(isDefined(probe)) {
    probe unlink();
  }
}

function function_73fb7422() {
  util::show_hint_text(#"hash_2c629fcbcbf5093");
}

function function_8e1cdc07() {
  wait 1;
  util::hide_hint_text();
}