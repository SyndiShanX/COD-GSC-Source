/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_3c5fdcb080338059.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace namespace_ea9baedf;

autoexec __init__system__() {
  system::register(#"hash_c25f006b5e1726d", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_7735a2dc4298e55c", &on_begin, &on_end);
}

private on_begin(kill_count) {
  self.kill_count = zm_trial::function_5769f26a(kill_count);

  foreach(player in getplayers()) {
    player.var_c957540c = 0;
  }

  zm_spawner::register_zombie_death_event_callback(&function_138aec8e);
  zm_trial_util::function_c2cd0cba(self.kill_count);

  foreach(player in getplayers()) {
    player thread function_7f62f098(self);
  }

  level thread function_69c5df45(self);
}

private on_end(round_reset) {
  foreach(player in getplayers()) {
    player zm_trial_util::function_f3aacffb();
  }

  if(!round_reset) {
    var_57807cdc = [];

    foreach(player in getplayers()) {
      if(player.var_c957540c < self.kill_count) {
        array::add(var_57807cdc, player, 0);
      }
    }

    if(var_57807cdc.size == 1) {
      zm_trial::fail(#"hash_788ffc8d7448f05", var_57807cdc);
    } else if(var_57807cdc.size > 1) {
      zm_trial::fail(#"hash_2bf9eb58ed3ac518", var_57807cdc);
    }
  }

  foreach(player in getplayers()) {
    player.var_c957540c = undefined;
  }

  zm_spawner::deregister_zombie_death_event_callback(&function_138aec8e);
}

private function_7f62f098(challenge) {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");

  while(true) {
    var_96936cca = self.var_c957540c;

    if(var_96936cca < 0) {
      var_96936cca = 0;
    } else if(var_96936cca > challenge.kill_count) {
      var_96936cca = challenge.kill_count;
    }

    self zm_trial_util::function_2190356a(var_96936cca);
    waitframe(1);
  }
}

private function_69c5df45(challenge) {
  level endon(#"hash_7646638df88a3656");

  while(true) {
    assert(isDefined(challenge));
    end_round = 1;

    foreach(player in getplayers()) {
      if(player.var_c957540c < challenge.kill_count) {
        end_round = 0;
      }
    }

    if(end_round) {
      enemies = getaiteamarray(level.zombie_team);

      if(isDefined(enemies)) {
        for(i = 0; i < enemies.size; i++) {
          enemies[i] dodamage(enemies[i].health + 666, enemies[i].origin);
        }
      }

      level.zombie_total = 0;
      return;
    }

    waitframe(1);
  }
}

private function_138aec8e(attacker) {
  if(isDefined(self.nuked) && self.nuked) {
    foreach(player in getplayers()) {
      player.var_c957540c++;
    }

    return;
  }

  if(isplayer(attacker)) {
    attacker.var_c957540c++;
  }
}