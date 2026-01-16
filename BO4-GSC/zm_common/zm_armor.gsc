/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_armor.gsc
***********************************************/

#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\callbacks;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_net;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_utility;

#namespace zm_armor;

autoexec __init__system__() {
  system::register(#"zm_armor", &__init__, undefined, undefined);
}

__init__() {
  callback::on_connect(&on_connect);
}

on_connect() {
  self thread function_49f4b6ee();
}

register(var_7c8fcded, is_permanent = 1) {
  if(!isDefined(level.var_9555ebfb)) {
    level.var_9555ebfb = [];
  } else if(!isarray(level.var_9555ebfb)) {
    level.var_9555ebfb = array(level.var_9555ebfb);
  }

  level.var_9555ebfb[var_7c8fcded] = is_permanent;
}

function_49f4b6ee() {
  self.var_9555ebfb = [];
  a_keys = getarraykeys(level.var_9555ebfb);

  foreach(key in a_keys) {
    if(level.var_9555ebfb[key]) {
      self.var_9555ebfb[key] = 0;
    }
  }

  foreach(key in a_keys) {
    if(!level.var_9555ebfb[key]) {
      self.var_9555ebfb[key] = 0;
    }
  }
}

add(var_7c8fcded, var_3ed63752, var_28066539, var_df7ee5d1 = #"hash_2082da6662372184") {
  var_4812bba2 = 0;

  if(isDefined(var_28066539)) {
    var_d7de78d3 = var_28066539 - self get(var_7c8fcded);

    if(var_3ed63752 <= var_d7de78d3) {
      self.armor += var_3ed63752;
      var_4812bba2 = var_3ed63752;
    } else {
      self.armor += var_d7de78d3;
      var_4812bba2 = var_d7de78d3;
    }
  } else {
    self.armor += var_3ed63752;
    var_4812bba2 = var_3ed63752;
  }

  if(var_4812bba2 > 0) {
    self playSound(var_df7ee5d1);
  }

  var_4812bba2 += self get(var_7c8fcded);
  self.var_9555ebfb[var_7c8fcded] = var_4812bba2;
}

remove(var_7c8fcded, var_2cd89ceb = 0) {
  if(isDefined(self.var_9555ebfb[var_7c8fcded]) && self.var_9555ebfb[var_7c8fcded] > 0) {
    if(var_2cd89ceb) {
      self.armor -= self.var_9555ebfb[var_7c8fcded];
      a_keys = getarraykeys(level.var_9555ebfb);
      var_d42adc5 = 0;

      foreach(key in a_keys) {
        if(key !== var_7c8fcded && (level.var_9555ebfb[key] || isDefined(self.var_bacee63b) && self.var_bacee63b && key == #"hero_weapon_armor")) {
          var_d42adc5 += get(key);
        }
      }

      var_d42adc5 = min(var_d42adc5, 100);
      self.armor = int(max(var_d42adc5, self.armor));
    }

    self.var_9555ebfb[var_7c8fcded] = 0;
  }
}

get(var_7c8fcded) {
  if(isDefined(self.var_9555ebfb[var_7c8fcded])) {
    return self.var_9555ebfb[var_7c8fcded];
  }

  return 0;
}

damage(n_damage, mod_type, e_attacker) {
  if(self.armor <= 0) {
    return n_damage;
  }

  var_ee47fd1b = int(self.armor * 2);
  a_keys = getarraykeys(self.var_9555ebfb);

  if(n_damage > var_ee47fd1b) {
    foreach(key in a_keys) {
      self remove(key, 1);
    }

    self.armor = 0;
    self playSound(#"hash_2817ca3f96127e62");
    return (n_damage - var_ee47fd1b);
  }

  if(n_damage > 0) {
    var_ee47fd1b = int(max(1, n_damage / 2));
  } else {
    var_ee47fd1b = 0;
  }

  self.armor -= var_ee47fd1b;
  var_c5aebd9f = 0;

  for(n_index = 0; var_c5aebd9f < var_ee47fd1b && n_index < a_keys.size; n_index++) {
    str_armor = a_keys[n_index];
    var_2a0d4230 = self get(str_armor);

    if(var_2a0d4230 > var_ee47fd1b) {
      var_34ada56f = var_2a0d4230 - var_ee47fd1b - var_c5aebd9f;
      self.var_9555ebfb[str_armor] = var_34ada56f;
      var_c5aebd9f += var_ee47fd1b;
      n_index++;
      continue;
    }

    if(var_2a0d4230 > 0) {
      var_c5aebd9f += var_2a0d4230;
      self remove(str_armor);

      if(self.armor <= 0) {
        self playSound(#"hash_2817ca3f96127e62");
      }

      n_index++;
      continue;
    }
  }

  self notify(#"damage_armor", {
    #mod: mod_type, 
    #attacker: e_attacker
  });
  return 0;
}