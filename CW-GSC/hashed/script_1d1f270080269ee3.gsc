/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1d1f270080269ee3.gsc
***********************************************/

#using script_1fd2c6e5fc8cb1c3;
#using script_2d443451ce681a;
#using script_4ec222619bffcfd1;
#using script_7901e9dc8618be8a;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace kgb_aslt_bunker;

function starting(var_d3440450) {
  level thread namespace_e77bf565::function_277bceaa(0);
  level.player util::delay(0.05, undefined, &clientfield::set_to_player, "stream_adler_assault_assets", 1);
  level thread scene::init_streamer("scene_kgb_bunker_intro_elevator", getplayers());
}

function main(var_d3440450, var_50cc0d4f) {
  level.player endon(#"death");
  level flag::set("aslt_bunker_begin");
  level battlechatter::function_2ab9360b(1);
  spawner::add_spawn_function_ai_group("bunker_intro_security", &function_5f5e32bd);

  if(is_true(var_50cc0d4f)) {
    level thread scene::init("scene_kgb_bunker_intro_elevator");
  }

  level thread scene::init("scene_kgb_door_kick");
  level thread scene::init("scene_kgb_utility_room_adler");
  level thread scene::init("scene_kgb_utility_room_player");
  level.player setlowready(1);
  level thread function_8f134086();
  level thread namespace_e77bf565::function_7feb07bb(var_d3440450, var_50cc0d4f);
  level thread function_1c059274();
  level thread function_deb648d2();
  level thread function_c8052750();

  if(!isDefined(level.adler)) {
    level.adler = namespace_e77bf565::function_52fe0eb3(var_d3440450);
    level.adler namespace_e77bf565::function_5770c74("assault");
  }

  level.adler.ignoreall = 0;
  level.adler.ignoreme = 0;
  level thread function_c353f42a();
  level thread function_8279b9f2();
  level thread function_19b7217e();
  level thread namespace_e77bf565::function_1067ebf5("rotating_object_bunker", "player_grabbed_armor");
  namespace_353d803e::music("10.0_combat_intro");
  level thread kgb_aslt_escape_lights_out::function_a0d18564();
  level flag::wait_till("aslt_bunker_complete");

  if(isDefined(var_d3440450)) {
    skipto::function_4e3ab877(var_d3440450);
  }
}

function function_b735db01() {
  level.adler endon(#"death");
  level.player endon(#"death");
  level notify(#"hash_49ad3ddc839a715c");
  ai::setaiattribute(level.adler, "can_melee", 0);
  level.adler.script_accuracy = 500;
  level.adler.perfectaim = 1;
  level.adler.ignoresuppression = 1;
  scene::remove_scene_func("scene_kgb_bunker_intro_adler", &function_b735db01, "done");
  scene::remove_scene_func("scene_kgb_bunker_intro_adler", &function_b735db01, "stop");
  bunker_intro_adler_node = getnode("bunker_intro_adler_node", "targetname");
  level.adler.fixednode = 1;
  level.adler spawner::go_to_node(bunker_intro_adler_node);
  level flag::wait_till("bunker_intro_security_cleared");
  level.player clientfield::set_to_player("stream_adler_assault_assets", 0);
  level.adler.script_accuracy = 1;
  level.adler.perfectaim = 0;
  level.adler.ignoresuppression = 0;
  level flag::set("enable_adler_kick_door");
  level flag::wait_till("start_adler_door_kick");
  level.adler.fixednode = 0;
  level.adler thread dialogue::queue("vox_cp_rkgb_03300_adlr_thiswaytothevau_e7");
  level scene::play("scene_kgb_door_kick", "Enter");
  ai::setaiattribute(level.adler, "can_melee", 1);
  level.adler colors::set_force_color("g");
  level.adler colors::enable();
  level flag::wait_till("player_reached_end_of_bunker");
  enemies = getaiteamarray(#"axis");

  foreach(enemy in enemies) {
    if(isDefined(enemy) && isalive(enemy)) {
      if(distancesquared(enemy.origin, level.player.origin) > 722500) {
        enemy delete();
      }
    }
  }

  level.adler.script_accuracy = 500;
  level.adler.perfectaim = 1;
  level.adler.ignoresuppression = 1;

  while(true) {
    if(level flag::get("aslt_bunker_complete")) {
      break;
    }

    enemies = getaiteamarray(#"axis");

    if(!isDefined(enemies) || isDefined(enemies) && enemies.size <= 4) {
      break;
    }

    wait 0.1;
  }

  enemies = getaiteamarray(#"axis");

  if(isDefined(enemies)) {
    foreach(enemy in enemies) {
      if(isDefined(enemy) && isalive(enemy)) {
        if(isDefined(enemy.script_noteworthy) && enemy.script_noteworthy == "retreat_and_delete_because_cannot_seek_player") {
          if(isDefined(enemy.script_parameters)) {
            node = getnode(enemy.script_parameters, "targetname");

            if(isDefined(node)) {
              enemy thread namespace_e77bf565::function_bf9d2fd0(node);
              continue;
            }
          }

          continue;
        }

        enemy thread function_a99a76b0();
      }
    }
  }

  level.adler.script_accuracy = 1;
  level.adler.perfectaim = 0;
  level.adler.ignoresuppression = 0;
}

function function_a99a76b0() {
  self notify("1c5d66e5be5d7d25");
  self endon("1c5d66e5be5d7d25");
  self endon(#"death");
  level.player endon(#"death");
  closest = arraysortclosest([level.player, level.adler], self.origin);
  target = closest[0];
  self.ignoresuppression = 1;
  self.goalradius = 300;
  self setgoal(target, 1);
  self namespace_e77bf565::function_7d2d1987(1440000, undefined, 1);
}

function function_5f5e32bd() {
  ai::setaiattribute(level.adler, "can_melee", 0);
}

function function_68025c07() {
  level.player endon(#"death");
  level endon(#"hash_742020afbebe9132");

  while(true) {
    if(level.player adsButtonPressed() || level.player meleeButtonPressed() || level.player attackButtonPressed() || level.player sprintbuttonPressed()) {
      level notify(#"hash_742020afbebe9132");
      break;
    }

    wait 0.05;
  }
}

function function_8f134086() {
  level.player endon(#"death");
  level waittill(#"hash_742020afbebe9132");
  level.player setlowready(0);
}

function cleanup(name, starting, direct, player) {}

function init_flags() {
  level flag::init("aslt_bunker_begin");
  level flag::init("aslt_bunker_complete");
  level flag::init("bunker_intro_runners_fallback");
  level flag::init("bunker_three_story_guys_fallback");
  level flag::init("bunker_pre_conf_room_initial_guys_fallback");
  level flag::init("bunker_pre_conf_room_guys_fallback");
  level flag::init("bunker_conf_room_guys_fallback");
  level flag::init("enable_obj_retrieve_intel");
}

function init_clientfields() {}

function function_22b7fffd() {}

function function_8279b9f2() {
  level.var_8dad5090 = "React_Fast";
  level.bunker_intro_phone = util::spawn_anim_model("rus_phone_wall_01_anim");
  var_6b5c13c2 = [];
  var_6b5c13c2[#"bunker_intro_phone"] = level.bunker_intro_phone;
  level thread scene::play("scene_kgb_bunker_intro_elevator", "Start");
  scene::add_scene_func("scene_kgb_bunker_intro_guard01", &function_25831409, "Loop");
  level thread scene::play("scene_kgb_bunker_intro_guard01", "Loop");
  scene::add_scene_func("scene_kgb_bunker_intro_guard02", &function_c44b308e, "Loop");
  level thread scene::play("scene_kgb_bunker_intro_guard02", "Loop");
  scene::add_scene_func("scene_kgb_bunker_intro_guard03", &function_65b9c362, "Loop");
  level thread scene::play("scene_kgb_bunker_intro_guard03", "Loop");
  level thread scene::play("scene_kgb_bunker_intro_guard04", "Loop");
  level thread scene::play("scene_kgb_bunker_intro_phone", "Loop", var_6b5c13c2);
  scene::add_scene_func("scene_kgb_bunker_intro_adler", &function_b735db01, "done");
  scene::add_scene_func("scene_kgb_bunker_intro_adler", &function_b735db01, "stop");
  level thread scene::play("scene_kgb_bunker_intro_adler", "Start", [level.adler]);
  level thread function_68025c07();
  level thread function_476dd8fe();
  level waittill(#"hash_49ad3ddc839a715c", #"bunker_intro_security_cleared");
  thread namespace_353d803e::function_81eee847();
  thread namespace_353d803e::function_71d7c94f();
  namespace_353d803e::music("10.2_combat_loop");
  level notify(#"hash_742020afbebe9132");

  if(scene::is_active("scene_kgb_bunker_intro_adler")) {
    if(!isDefined(level.var_e2e2c645)) {
      level scene::stop("scene_kgb_bunker_intro_adler");
    }
  }

  scene::add_scene_func("scene_kgb_bunker_intro_guard01", &function_97192259, level.var_8dad5090);
  level thread scene::play("scene_kgb_bunker_intro_guard01", level.var_8dad5090);
  scene::add_scene_func("scene_kgb_bunker_intro_guard02", &function_1cb30cf6, level.var_8dad5090);
  level thread scene::play("scene_kgb_bunker_intro_guard02", level.var_8dad5090);
  scene::add_scene_func("scene_kgb_bunker_intro_guard03", &function_82cb64f1, level.var_8dad5090);
  level thread scene::play("scene_kgb_bunker_intro_guard03", level.var_8dad5090);
  level thread scene::play("scene_kgb_bunker_intro_guard04", level.var_8dad5090);
  level thread scene::play("scene_kgb_bunker_intro_phone", level.var_8dad5090);
}

function function_c8052750() {
  level waittill(#"hash_619863a87e777fd1");
  level.var_8dad5090 = "React";
  level.var_e2e2c645 = 1;
  level notify(#"hash_49ad3ddc839a715c");
}

function function_476dd8fe() {
  level.player endon(#"death");
  level.player waittill(#"weapon_fired");
  level notify(#"hash_49ad3ddc839a715c");
}

function function_1c059274() {
  level flag::wait_till("bunker_intro_security_cleared");
  level thread savegame::checkpoint_save(0);
  level flag::wait_till("adler_vo_keep_moving");
  level thread savegame::checkpoint_save(0);
  level.adler dialogue::queue("vox_cp_rkgb_03400_adlr_keepmovingtowar_27");
  level flag::wait_till("adler_vo_advance");
  level.adler dialogue::queue("vox_cp_rkgb_03400_adlr_advance_d3");
  level thread savegame::checkpoint_save(0);
  level flag::wait_till("adler_vo_getting_close");
  level.adler dialogue::queue("vox_cp_rkgb_03400_adlr_weregettingclos_a7");
  level thread savegame::checkpoint_save(0);
}

function function_6e6f3309() {
  level thread namespace_e77bf565::function_23705b46("bunker_intro_runners", 2, "bunker_intro_runners_fallback");
  level thread namespace_e77bf565::function_23705b46("bunker_three_story_guys", 3, "bunker_three_story_guys_fallback");
  level thread namespace_e77bf565::function_23705b46("bunker_pre_conf_room_initial_guys", 2, "bunker_pre_conf_room_initial_guys_fallback");
  level thread namespace_e77bf565::function_23705b46("bunker_pre_conf_room_guys", 2, "bunker_pre_conf_room_guys_fallback");
  level thread namespace_e77bf565::function_23705b46("bunker_conf_room_guys", 3, "bunker_conf_room_guys_fallback");
}

function function_deb648d2() {}

function function_c353f42a() {
  level flag::wait_till_all(["bunker_intro_security_cleared", "bunker_intro_runners_cleared", "bunker_secondary_guys_cleared", "bunker_three_story_guys_cleared", "bunker_pre_conf_room_initial_guys_cleared", "bunker_pre_conf_room_guys_cleared", "bunker_conf_room_guys_cleared", "bunker_end_guys_cleared"]);
  level flag::set("aslt_bunker_complete");
}

function function_25831409(a_ents) {
  guy = a_ents[#"bunker_intro_guard01"];
  guy endon(#"death");
  level endon(#"hash_619863a87e777fd1");
  level waittill(#"hash_5945fb19f4765b76");
  guy thread dialogue::queue("vox_cp_rkgb_03300_rms1_laugh_62");
}

function function_97192259(a_ents) {
  guy = a_ents[#"bunker_intro_guard01"];
  guy endon(#"death");
  guy thread dialogue::function_47b06180();
  level waittill(#"hash_3d671f3adb08034");
  guy thread dialogue::queue("vox_cp_rkgb_03300_rms1_putthoseweapons_c7", undefined, 1);
}

function function_c44b308e(a_ents) {
  guy = a_ents[#"bunker_intro_guard02"];
  guy endon(#"death");
  level endon(#"hash_619863a87e777fd1");
  level waittill(#"hash_2597a9a7421731ab");
  guy thread dialogue::queue("vox_cp_rkgb_03300_rms2_laugh_62");
}

function function_1cb30cf6(a_ents) {
  guy = a_ents[#"bunker_intro_guard02"];
  guy endon(#"death");
  guy thread dialogue::function_47b06180();
  level waittill(#"hash_51e288b6c1579efd");
  guy thread dialogue::queue("vox_cp_rkgb_03300_rms2_thisareasofflim_44", undefined, 1);
}

function function_65b9c362(a_ents) {
  guy = a_ents[#"bunker_intro_guard03"];
  guy endon(#"death");
  level endon(#"hash_619863a87e777fd1");
  level waittill(#"hash_772597925aee74a4");
  guy thread dialogue::queue("vox_cp_rkgb_03300_rms3_laugh_62");
  level waittill(#"hash_51063caa12ea0f88");
  guy thread dialogue::queue("vox_cp_rkgb_03300_rms3_andbeforekravch_31", undefined, 1);
}

function function_82cb64f1(a_ents) {
  guy = a_ents[#"bunker_intro_guard03"];
  guy endon(#"death");
  guy thread dialogue::function_47b06180();
}

function function_19b7217e() {
  var_9ff26cee = getEntArray("bunker_enemy_cleanup_trigger", "targetname");

  if(isDefined(var_9ff26cee)) {
    array::thread_all(var_9ff26cee, &function_3c9ae8b3);
  }
}

function function_3c9ae8b3() {
  self endon(#"death");
  self waittill(#"trigger");
  volume = getent(self.target, "targetname");

  if(isDefined(volume)) {
    enemies = volume ai::function_18c4ff86("axis");
    array::delete_all(enemies);
  }
}