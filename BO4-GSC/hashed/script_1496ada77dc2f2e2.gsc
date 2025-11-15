/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_1496ada77dc2f2e2.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\music_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;

#namespace namespace_c1466447;

autoexec __init__system__() {
  system::register(#"hash_2c983afcd92a9970", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  clientfield::register("toplayer", "" + #"hash_b905d796914b710", 14000, 1, "int");
  clientfield::register("toplayer", "" + #"hash_1b9477ddcf30191f", 16000, 1, "int");
  clientfield::register("toplayer", "" + #"hash_52347bec3f1339fd", 16000, 4, "int");
  zm_trial::register_challenge(#"hash_6c768f3c15d55377", &on_begin, &on_end);
}

private on_begin(str_style) {
  level.var_4ecf5754 = isDefined(str_style) ? str_style : #"silent_film";

  switch (level.var_4ecf5754) {
    case #"silent_film":
      level thread function_40c7a8fd();
      break;
    case #"hash_5a202c5d6f53d672":
      foreach(player in getplayers()) {
        player thread function_69fa75f8();
      }

      break;
    case #"perk_drunk":
      foreach(player in getplayers()) {
        player thread function_6d8cf829();
      }

      break;
    case #"random_blindness":
      callback::add_callback(#"on_host_migration_end", &function_604ff1eb);

      foreach(player in getplayers()) {
        player thread function_ad641569();
      }

      break;
  }

  callback::on_spawned(&on_player_spawned);
}

private on_end(round_reset) {
  switch (level.var_4ecf5754) {
    case #"silent_film":
      foreach(player in getplayers()) {
        player thread clientfield::set_to_player("" + #"hash_b905d796914b710", 0);
      }

      setslowmotion(1.25, 1);

      if(isDefined(level.var_79514f31)) {
        level.var_79514f31 delete();
      }

      break;
    case #"hash_5a202c5d6f53d672":
      if(!round_reset) {
        foreach(player in getplayers()) {
          player showcrosshair(1);
          player clientfield::set_to_player("" + #"hash_1b9477ddcf30191f", 0);
        }
      }

      break;
    case #"perk_drunk":
      foreach(player in getplayers()) {
        player clientfield::set_to_player("" + #"hash_52347bec3f1339fd", 0);
      }

      break;
    case #"random_blindness":
      callback::remove_callback(#"on_host_migration_end", &function_604ff1eb);
      break;
  }

  level.var_4ecf5754 = undefined;
  callback::remove_on_spawned(&on_player_spawned);
}

private on_player_spawned() {
  if(level.var_4ecf5754 === #"silent_film") {
    self clientfield::set_to_player("" + #"hash_b905d796914b710", 1);
  }
}

function_40c7a8fd() {
  level endon(#"hash_7646638df88a3656", #"end_game");
  wait 3.5;

  foreach(player in getplayers()) {
    player clientfield::set_to_player("" + #"hash_b905d796914b710", 1);
  }

  wait 2;
  setslowmotion(1, 1.25);
  level.var_79514f31 = spawn("script_origin", (0, 0, 0));
  level.var_79514f31 playLoopSound(#"hash_1eafdf46ffbf2308");
}

private function_69fa75f8() {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");

  while(true) {
    self clientfield::set_to_player("" + #"hash_1b9477ddcf30191f", 1);
    self showcrosshair(0);

    while(true) {
      s_waitresult = self waittilltimeout(1, #"weapon_fired", #"hash_3e0895cd0cc16d2d", #"lightning_ball_created", #"viper_bite_projectile");

      if(s_waitresult._notify != "timeout") {
        self clientfield::set_to_player("" + #"hash_1b9477ddcf30191f", 0);
        self showcrosshair(1);
        continue;
      }

      break;
    }
  }
}

function_6d8cf829() {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656", #"end_game");

  while(true) {
    n_perks = self.var_67ba1237.size + self.var_466b927f.size;
    self clientfield::set_to_player("" + #"hash_52347bec3f1339fd", n_perks);
    wait 1;
  }
}

private function_ad641569() {
  self notify("3d0a827cbf03ae74");
  self endon("3d0a827cbf03ae74");
  self endon(#"disconnect");
  level endoncallback(&function_1a109202, #"hash_7646638df88a3656", #"host_migration_begin");

  while(true) {
    wait randomintrangeinclusive(5, 15);
    var_6eabfd9d = getstatuseffect("blind_zm_catalyst");
    n_duration = randomintrangeinclusive(5000, 7500);
    self status_effect::status_effect_apply(var_6eabfd9d, undefined, self, 0, n_duration);
    wait float(n_duration) / 1000;
    var_3caa2c0f = getstatuseffect("deaf_electricity_catalyst");
    self status_effect::status_effect_apply(var_3caa2c0f, undefined, self, 0, n_duration);
    wait float(n_duration) / 1000;

    if(self status_effect::function_4617032e(var_6eabfd9d.setype)) {
      self status_effect::function_408158ef(var_6eabfd9d.setype, var_6eabfd9d.var_18d16a6b);
    }

    if(self status_effect::function_4617032e(var_3caa2c0f.setype)) {
      self status_effect::function_408158ef(var_3caa2c0f.setype, var_3caa2c0f.var_18d16a6b);
    }
  }
}

function_1a109202(str_notify) {
  if(str_notify === "host_migration_begin") {
    var_6eabfd9d = getstatuseffect("blind_zm_catalyst");
    var_3caa2c0f = getstatuseffect("deaf_electricity_catalyst");

    foreach(player in getplayers()) {
      if(player status_effect::function_4617032e(var_6eabfd9d.setype)) {
        player status_effect::function_408158ef(var_6eabfd9d.setype, var_6eabfd9d.var_18d16a6b);
      }

      if(player status_effect::function_4617032e(var_3caa2c0f.setype)) {
        player status_effect::function_408158ef(var_3caa2c0f.setype, var_3caa2c0f.var_18d16a6b);
      }
    }
  }
}

private function_604ff1eb() {
  level endon(#"hash_7646638df88a3656", #"end_game");
  wait 5;

  foreach(player in getplayers()) {
    player thread function_ad641569();
  }
}