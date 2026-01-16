/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_ee_tundragun.gsc
***********************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_orange_util;
#include scripts\zm_common\zm_sq;
#include scripts\zm_common\zm_utility;

#namespace zm_orange_ee_tundragun;

init() {
  init_clientfields();
  init_flags();
}

init_clientfields() {}

init_flags() {
  level flag::init(#"hash_478e70a97b556206");
  level flag::init(#"hash_6a417acc02a28c9d");
  level flag::init(#"hash_6b5e9a7b23ad25a5");
}

main() {
  level.var_97da986d = spawnStruct();
  level.var_97da986d.var_6f9b20c6 = 0;
  level.var_97da986d.var_7d4c9076 = 105000;
  level.var_97da986d.n_start_time = 0;
  var_954f6810 = struct::get("ee_tundragun_weapon_box");
  var_5fbb6b48 = struct::get("ee_tundragun_weapon_box_lid");

  if(isDefined(var_954f6810) && isDefined(var_5fbb6b48)) {
    level.var_97da986d.var_954f6810 = var_954f6810;
    e_model = util::spawn_model(var_954f6810.model, var_954f6810.origin, var_954f6810.angles);
    level.var_97da986d.var_954f6810.e_model = e_model;
    level.var_97da986d.var_5fbb6b48 = var_5fbb6b48;
    e_model = util::spawn_model(var_5fbb6b48.model, var_5fbb6b48.origin, var_5fbb6b48.angles);
    level.var_97da986d.var_5fbb6b48.e_model = e_model;
  }

  zm_sq::register(#"ee_tundragun", #"step_1", #"ee_tundragun_step1", &ee_tundragun_step1_setup, &ee_tundragun_step1_cleanup);
  zm_sq::register(#"ee_tundragun", #"step_2", #"ee_tundragun_step2", &ee_tundragun_step2_setup, &ee_tundragun_step2_cleanup);
  zm_sq::start(#"ee_tundragun", !zm_utility::is_standard());
}

ee_tundragun_step1_setup(var_5ea5c94d) {

  iprintlnbold("<dev string:x38>");

    level.var_97da986d.a_s_targets = struct::get_array("ee_tundragun_target");

  foreach(s_target in level.var_97da986d.a_s_targets) {
    if(isDefined(s_target.model)) {
      s_target.e_target = util::spawn_model(s_target.model, s_target.origin, s_target.angles);
      s_target.e_target setCanDamage(1);
      s_target.e_target val::set("ee_tundragun", "allowDeath", 0);
      s_target.e_target.script_int = s_target.script_int;
      s_target.e_target thread function_f16c0259();
    }
  }

  if(!var_5ea5c94d) {
    level flag::wait_till(#"hash_478e70a97b556206");
  }
}

ee_tundragun_step1_cleanup(var_5ea5c94d, ended_early) {

  iprintlnbold("<dev string:x55>");

    if(var_5ea5c94d || ended_early) {
      level flag::set(#"hash_478e70a97b556206");
    }
}

private function_f16c0259() {
  self endon(#"death");
  level endon(#"end_game", #"hash_478e70a97b556206");

  while(true) {
    s_notify = self waittill(#"damage");
    level.var_97da986d.var_af9bf642 = s_notify.inflictor;
    var_b6d64a72 = isDefined(s_notify.weapon) && (s_notify.weapon.rootweapon === level.w_snowball || s_notify.weapon.rootweapon === level.w_snowball_upgraded || s_notify.weapon.rootweapon === level.w_snowball_yellow || s_notify.weapon.rootweapon === level.w_snowball_yellow_upgraded);
    var_d35fda46 = level.var_97da986d.var_2759714a === level.var_97da986d.var_af9bf642 || level.var_97da986d.var_6f9b20c6 === 0;

    if(var_b6d64a72 && var_d35fda46) {
      var_cf41b762 = self.script_int === level.var_97da986d.var_6f9b20c6;

      if(var_cf41b762) {
        self playSound(#"hash_4a51cdb0e1682b6c");

        if(level.var_97da986d.var_6f9b20c6 === 0) {
          level thread function_213f1c48();
          level.var_97da986d.var_2759714a = level.var_97da986d.var_af9bf642;
        }

        n_time_remaining = (level.var_97da986d.var_7d4c9076 - gettime() - level.var_97da986d.n_start_time) / 1000 / 60;

        iprintlnbold("<dev string:x74>" + self.script_int + 1 + "<dev string:x8c>" + n_time_remaining + "<dev string:xaf>");

          level.var_97da986d.var_6f9b20c6++;

        if(level.var_97da986d.var_6f9b20c6 === level.var_97da986d.a_s_targets.size) {

          iprintlnbold("<dev string:xbb>");

            level notify(#"hash_3dcff814c31d2298");
          level flag::set(#"hash_478e70a97b556206");
        }

        continue;
      }

      iprintlnbold("<dev string:xed>");

        function_c19f52ea();
    }
  }
}

private function_213f1c48() {
  level endon(#"end_game", #"hash_3dcff814c31d2298");

  iprintlnbold("<dev string:x12c>" + 1.75 + "<dev string:xaf>");

    level flag::clear(#"hash_6a417acc02a28c9d");
  level.var_97da986d.n_start_time = gettime();

  while(gettime() < level.var_97da986d.n_start_time + level.var_97da986d.var_7d4c9076) {
    wait 0.5;
  }

  iprintlnbold("<dev string:x156>");

    level flag::set(#"hash_6a417acc02a28c9d");
  function_c19f52ea();
}

private function_c19f52ea() {
  if(level.var_97da986d.var_6f9b20c6 > 0 && math::cointoss()) {
    level.var_97da986d.var_af9bf642 thread zm_orange_util::function_51b752a9("vox_generic_responses_negative");
  }

  level.var_97da986d.var_6f9b20c6 = 0;
  level notify(#"hash_3dcff814c31d2298");
}

ee_tundragun_step2_setup(var_5ea5c94d) {

  iprintlnbold("<dev string:x195>");

  iprintlnbold("<dev string:x1b3>");

    s_weapon_pickup = struct::get("ee_tundragun_weapon");
  level.var_97da986d.s_weapon_pickup = s_weapon_pickup;
  e_weapon = util::spawn_model(s_weapon_pickup.model, s_weapon_pickup.origin, s_weapon_pickup.angles);
  level.var_97da986d.s_weapon_pickup.e_weapon = e_weapon;
  e_lid = level.var_97da986d.var_5fbb6b48.e_model;
  e_lid playSound(#"hash_1cfa90c531f36b92");
  e_lid rotatepitch(-100, 1.5);
  e_lid waittill(#"rotatedone");

  if(isDefined(s_weapon_pickup)) {
    e_weapon moveto(e_weapon.origin + (0, 0, 16), 1.5);
    e_weapon waittill(#"movedone");
    level.var_97da986d.s_weapon_pickup.e_weapon zm_orange_util::start_zombies_collision_manager(getweapon("tundragun"), &function_37d390f8);
  }

  if(!var_5ea5c94d) {
    level flag::wait_till(#"hash_6b5e9a7b23ad25a5");

    if(isDefined(level.var_97da986d.s_weapon_pickup) && isDefined(level.var_97da986d.s_weapon_pickup.e_weapon)) {
      level.var_97da986d.s_weapon_pickup.e_weapon delete();
    }
  }
}

ee_tundragun_step2_cleanup(var_5ea5c94d, ended_early) {

  iprintlnbold("<dev string:x1de>");

    if(var_5ea5c94d || ended_early) {
      level flag::set(#"hash_6b5e9a7b23ad25a5");
    }
}

private function_37d390f8(e_player, b_get_weapon) {
  if(b_get_weapon) {
    e_player thread zm_orange_util::function_51b752a9("vox_tundragun_get");
  }

  level flag::set(#"hash_6b5e9a7b23ad25a5");
}