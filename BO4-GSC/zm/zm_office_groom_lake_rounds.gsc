/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_office_groom_lake_rounds.gsc
***********************************************/

#include script_174ebb9642933bf7;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_office_special_rounds;
#include scripts\zm\zm_office_teleporters;
#include scripts\zm_common\util\ai_dog_util;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_round_logic;
#namespace zm_office_groom_lake_rounds;

init() {
  level thread function_88b87834();
}

function_fac06066() {
  a_e_zombies = getaiarray();

  foreach(e_zombie in a_e_zombies) {
    e_zombie thread zm_cleanup::cleanup_zombie();
  }

  level.var_894a83d8 = 1;
  level flag::clear("spawn_zombies");
  level flag::set("pause_round_timeout");
  level.var_37769559 = 10;
  level.var_baf33f0e = 0;
  zm_powerups::function_74b8ec6b("full_ammo");
  zm_powerups::function_74b8ec6b("bonus_points_team");
  zm_powerups::function_74b8ec6b("double_points");
  callback::on_ai_killed(&function_1cae4e0a);
  level thread function_bcae2e4b();
  wait 15;
  level thread round_spawning();
}

function_4074a9e2() {
  a_e_zombies = getaiarray();

  foreach(e_zombie in a_e_zombies) {
    e_zombie.exclude_cleanup_adding_to_total = 1;
    e_zombie thread zm_cleanup::cleanup_zombie();
  }

  level.var_894a83d8 = 0;
  level flag::clear(#"in_groom_lake");
  level flag::set("spawn_zombies");
  level flag::set("pause_round_timeout");
  callback::remove_on_ai_killed(&function_1cae4e0a);
  zm_powerups::function_41cedb05("full_ammo");
  zm_powerups::function_41cedb05("bonus_points_team");
  zm_powerups::function_41cedb05("double_points");

  iprintlnbold("<dev string:x38>" + level.var_baf33f0e + "<dev string:x4e>");

  level thread function_88b87834();
}

function_1cae4e0a(s_params) {
  if(self.b_cleaned_up !== 1) {
    level.var_baf33f0e++;

    if(level.var_bdc8b034.size < 1 && zombie_utility::get_current_zombie_count() < 2) {
      level thread zm_powerups::specific_powerup_drop("full_ammo", self.origin, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
    }
  }
}

function_b741acea() {
  level.var_bdc8b034 = [];
  level.var_bdc8b034[#"zombie"] = zm_round_logic::get_zombie_count_for_round(level.var_37769559, level.activeplayers.size);
  var_d90bc041 = min((level.var_37769559 - 10) / 40, 1);
  var_82981c27 = lerpfloat(0.1, 0.3, var_d90bc041);
  var_2f8a58bb = lerpfloat(0.2, 0.4, var_d90bc041);
  var_8c110732 = randomfloatrange(var_82981c27, var_2f8a58bb);
  var_778b517c = int(var_8c110732 * level.var_bdc8b034[#"zombie"]);
  level.var_bdc8b034[#"zombie"] -= var_778b517c;
  level.var_bdc8b034[#"zombie_dog"] = int(randomfloatrange(0.2, 0.4) * var_778b517c);
  level.var_bdc8b034[#"nova_crawler"] = var_778b517c - level.var_bdc8b034[#"zombie_dog"];
  arrayremovevalue(level.var_bdc8b034, 0, 1);
}

function_88b87834() {
  level waittill(#"groom_lake_enter");
  level flag::set(#"in_groom_lake");
  function_fac06066();
}

function_bcae2e4b() {
  level waittill(#"groom_lake_exit");
  function_4074a9e2();
}

round_spawning() {
  level endon(#"groom_lake_exit");
  function_b741acea();
  n_spawn_delay = zm_round_logic::get_zombie_spawn_delay(level.var_37769559);

  while(level.var_bdc8b034.size > 0) {
    for(var_404e4288 = zombie_utility::get_current_zombie_count(); var_404e4288 >= level.zombie_ai_limit; var_404e4288 = zombie_utility::get_current_zombie_count()) {
      wait 0.1;
    }

    while(zombie_utility::get_current_actor_count() >= level.zombie_actor_limit) {
      zombie_utility::clear_all_corpses();
      wait 0.1;
    }

    level flag::wait_till_clear(#"nuke_stop_special_spawning");
    str_archetype = get_archetype();
    ai = spawn_archetype(str_archetype);

    if(isDefined(ai)) {
      ai._starting_round_number = level.var_37769559;
      level.var_bdc8b034[str_archetype]--;

      if(level.var_bdc8b034[str_archetype] == 0) {
        arrayremoveindex(level.var_bdc8b034, str_archetype, 1);
      }

      ai thread zombie_utility::round_spawn_failsafe();
      var_404e4288++;

      if(ai ai::has_behavior_attribute("can_juke")) {
        ai ai::set_behavior_attribute("can_juke", 0);
      }

      wait n_spawn_delay;
    }

    util::wait_network_frame();
  }

  while(zombie_utility::get_current_zombie_count() > 0) {
    wait 0.1;
  }

  level thread end_round();
}

get_archetype() {
  a_keys = getarraykeys(level.var_bdc8b034);
  return array::random(a_keys);
}

spawn_archetype(str_archetype) {
  switch (str_archetype) {
    case #"zombie":
      spawner = array::random(level.zombie_spawners);
      ai = zombie_utility::spawn_zombie(spawner);
      break;
    case #"zombie_dog":
      ai = zombie_dog_util::function_62db7b1c();
      break;
    case #"nova_crawler":
      ai = nova_crawler_util::spawn_nova_crawler();
      break;
    default:
      assertmsg("<dev string:x60>");
      break;
  }

  return ai;
}

end_round() {
  level endon(#"groom_lake_exit");
  wait 15;
  function_d89bf8aa();
}

function_d89bf8aa() {
  level.var_37769559 += 5;
  level thread round_spawning();
}