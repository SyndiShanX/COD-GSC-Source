/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7901e9dc8618be8a.gsc
***********************************************/

#using script_1fd2c6e5fc8cb1c3;
#using script_4ec222619bffcfd1;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\manager;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace kgb_aslt_escape_lights_out;

function starting(var_d3440450) {
  level thread namespace_e77bf565::function_277bceaa(0);
}

function main(var_d3440450, var_50cc0d4f) {
  level flag::set("aslt_bunker_escape_lights_out_begin");
  level battlechatter::function_2ab9360b(1);
  namespace_353d803e::function_7ecf08d8();
  setsaveddvar(#"hash_7bf40e4b6a830d11", 0);

  if(is_true(var_50cc0d4f)) {
    level.adler = namespace_e77bf565::function_52fe0eb3(var_d3440450, "adler_shotgun");
    level thread scene::skipto_end_noai("scene_kgb_door_kick", "Last_Frame", undefined, 1);
    level thread scene::skipto_end_noai("scene_kgb_utility_room_adler", "Door_Closed", undefined, 1);
    level thread scene::init("scene_kgb_tunnel_catwalk_transition");
    level thread scene::init("scene_kgb_lights_out");
    level thread function_a0d18564();
    level thread namespace_e77bf565::function_1067ebf5("rotating_object_bunker", "player_grabbed_armor");
  }

  level.adler battlechatter::function_2ab9360b(0);
  spawner::add_spawn_function_group("ambient_cqb_searcher", "script_noteworthy", &function_dfeaa423);
  spawner::add_spawn_function_group("ambusher", "script_noteworthy", &function_adbd78ad);
  level thread namespace_e77bf565::escape_objective(var_d3440450, var_50cc0d4f);
  level thread function_5b6d6f91();
  level thread spawn_ambient_cqb_searchers();
  exploder::exploder("lights_out");
  level flag::wait_till("aslt_bunker_escape_lights_out_complete");

  if(isDefined(var_d3440450)) {
    skipto::function_4e3ab877(var_d3440450);
  }
}

function cleanup(name, starting, direct, player) {}

function init_flags() {
  level flag::init("aslt_bunker_escape_lights_out_begin");
  level flag::init("aslt_bunker_escape_lights_out_complete");
  level flag::init("lights_out_done");
}

function init_clientfields() {
  clientfield::register("actor", "set_flashlight_fx", 1, 1, "int");
  clientfield::register("actor", "set_flashlight_gun_tag", 1, 1, "int");
}

function function_22b7fffd() {}

function function_a0d18564() {
  exploder::exploder("lights_out_group_back_100");
  exploder::exploder("lights_out_group_back_90");
  exploder::exploder("lights_out_group_back_80");
  exploder::exploder("lights_out_group_back_70");
  exploder::exploder("lights_out_group_back_60");
  exploder::exploder("lights_out_group_20");
  exploder::exploder("lights_out_group_40");
  exploder::exploder("lights_out_group_60");
  exploder::exploder("lights_out_group_80");
}

function function_c39765b2(start_delay) {
  wait start_delay;
  var_5abcb701 = 0.5;
  exploder::stop_exploder("lights_out_group_back_100");
  exploder::stop_exploder("lights_out_group_back_90");
  wait var_5abcb701;
  exploder::stop_exploder("lights_out_group_back_80");
  exploder::stop_exploder("lights_out_group_back_70");
  namespace_353d803e::function_9f617fd();
  wait var_5abcb701;
  exploder::stop_exploder("lights_out_group_back_60");
  exploder::stop_exploder("lights_out_group_20");
  namespace_353d803e::function_247bcd08();
  wait var_5abcb701;
  exploder::stop_exploder("lights_out_group_40");
  exploder::stop_exploder("lights_out_group_60");
  namespace_353d803e::function_3632f076();
  wait var_5abcb701;
  namespace_353d803e::function_d2c6a99f();
  exploder::stop_exploder("lights_out_group_80");
  exploder::stop_exploder("lights_out");
  level flag::set("lights_out_done");
  level thread savegame::checkpoint_save();
}

function function_5b6d6f91() {
  level.player endon(#"death");
  level.adler ai::set_behavior_attribute("demeanor", "cqb");
  level scene::play("scene_kgb_lights_out", "intro");
  level thread scene::play("scene_kgb_lights_out", "intro_loop");
  level flag::set("adler_idling_at_lights_out_door");
  level flag::wait_till("start_lights_out_scene");
  namespace_353d803e::music("deactivate_13.5_lockdown");
  level.player thread util::blend_movespeedscale(0.5, 1);
  level scene::play("scene_kgb_lights_out", "lights_out");

  if(flag::get("start_lights_out_moment")) {
    level thread function_c39765b2(1.9);
    level scene::play("scene_kgb_lights_out", "ambush_immediate");
  } else {
    level scene::play("scene_kgb_lights_out", "ambush_delayed_intro");
    level thread scene::play("scene_kgb_lights_out", "ambush_delayed_loop");
    level flag::wait_till("start_lights_out_moment");
    level thread function_c39765b2(1.9);
    level scene::play("scene_kgb_lights_out", "ambush_delayed_outro");
  }

  namespace_353d803e::music("13.6_lockdown_2", 3);
  level thread function_b735db01();
  wait 2;
  level.player thread util::blend_movespeedscale_default(5);
}

function function_b735db01() {
  level.adler thread dialogue::queue("vox_cp_rkgb_05050_adlr_keepmovingwenee_57");
  lights_out_adler_start_node = getnode("lights_out_adler_start_node", "targetname");
  level.adler spawner::go_to_node(lights_out_adler_start_node);
  level.adler colors::set_force_color("g");
  level.adler colors::enable();
  level thread savegame::checkpoint_save();
  wait 1;
  level flag::set("spawn_ambient_cqb_searchers");
}

function spawn_ambient_cqb_searchers() {
  level flag::wait_till("spawn_ambient_cqb_searchers");
  spawner::simple_spawn("ambient_cqb_searcher");
  namespace_353d803e::function_eb78fac3();
}

function function_dfeaa423() {
  self ai::set_behavior_attribute("demeanor", "cqb");
  self ai::gun_remove();
  weapon = getweapon(#"hash_2f8a6a0e48c03a9b", "light");
  self aiutility::setcurrentweapon(weapon);
  self aiutility::setprimaryweapon(weapon);
  self ai::gun_switchto(weapon, "right");
  self thread function_f1c7e164();
}

function function_f1c7e164() {
  self clientfield::set("set_flashlight_gun_tag", 1);
  self waittill(#"death");
  self clientfield::set("set_flashlight_gun_tag", 0);
}

function function_adbd78ad() {
  self endon(#"death");
  level.player endon(#"death");
  var_fdca0d51 = [level.player, level.adler];
  self ai::gun_remove();
  weapon = getweapon(#"hash_2f8a6a0e48c03a9b", "light");
  self aiutility::setcurrentweapon(weapon);
  self aiutility::setprimaryweapon(weapon);
  self ai::gun_switchto(weapon, "right");
  self ai::set_behavior_attribute("disablepeek", 1);
  self ai::set_behavior_attribute("disablelean", 1);
  self.fixednode = 1;
  self ai::set_behavior_attribute("demeanor", "combat");
  self.var_e7ea517e = 0;
  self.ignoresuppression = 1;
  self.grenadeammo = 0;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self battlechatter::function_2ab9360b(0);
  self thread function_411f4f72();
  self thread function_5b8d4a66();
  self thread function_2f5a3b31();
  enemy = undefined;
  waitresult = self waittill(#"ambush", #"grenadedanger");
  self notify(#"ambush");

  if(isDefined(waitresult.target)) {
    enemy = waitresult.target;
  }

  if(isDefined(waitresult.owner)) {
    enemy = waitresult.owner;
  }

  if(!isDefined(enemy) && isDefined(self.enemy)) {
    enemy = self.enemy;
  }

  if(!isDefined(enemy)) {
    closest = arraysortclosest(var_fdca0d51, self.origin);
    enemy = closest[0];
  }

  self.ignoreall = 0;
  self.fixednode = 0;
  self getperfectinfo(enemy);
  self.goalradius = 200;
  self setgoal(enemy, 1);
  self thread function_ba241b07();
  wait 1;
  self thread function_f1c7e164();
  self.ignoreme = 0;
  self.var_e7ea517e = 1;
  self battlechatter::function_2ab9360b(1);
  wait 2;
  self ai::set_behavior_attribute("disablepeek", 0);
  self ai::set_behavior_attribute("disablelean", 0);
}

function function_2f5a3b31() {
  self waittill(#"ambush", #"death");

  if(isDefined(self.var_8f8a8e65)) {
    self.var_8f8a8e65 delete();
  }
}

function function_5b8d4a66() {
  self endon(#"death");
  self endon(#"ambush");
  level.player endon(#"death");
  node = getnode(self.target, "targetname");
  waitresult = self waittill(#"damage");

  if(isDefined(waitresult.inflictor)) {
    self notify(#"ambush", {
      #target: waitresult.inflictor
    });
  }
}

function function_411f4f72() {
  self endon(#"death");
  self endon(#"ambush");
  level.player endon(#"death");
  node = getnode(self.target, "targetname");

  if(!isDefined(node)) {
    return;
  }

  self.var_8f8a8e65 = spawn("trigger_radius", node.origin, 98311, 350, 128);
  self.var_8f8a8e65 setvisibletoall();
  self.var_8f8a8e65 setteamfortrigger(#"allies");
  waitresult = self.var_8f8a8e65 waittill(#"trigger");

  if(isDefined(waitresult.activator)) {
    self notify(#"ambush", {
      #target: waitresult.activator
    });
  }
}

function function_ba241b07() {
  self endon(#"death");
  level.player endon(#"death");
  var_e3c067a4 = randomintrangeinclusive(1, 3);
  shots_fired = 0;
  start_time = gettime();

  while(true) {
    current_time = gettime();
    timeout = 4000;

    if(current_time >= start_time + timeout) {
      break;
    }

    if(shots_fired >= var_e3c067a4) {
      break;
    }

    if(isDefined(self.enemy) && self cansee(self.enemy) && util::within_fov(self gettagorigin("tag_flash"), self gettagangles("tag_flash"), self.enemy getEye(), cos(15)) && bullettracepassed(self gettagorigin("tag_flash"), self.enemy getEye(), 0, self)) {
      self thread function_f1c7e164();
      self shoot();
      shots_fired++;
      wait 0.2;
      continue;
    }

    wait 0.05;
  }
}