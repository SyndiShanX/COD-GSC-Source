/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_5a4a5d9ba343ff8f.gsc
*****************************************************/

#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace status_effects;

function init_status_effects() {
  level thread function_aa5e83a2d77857d3();
}

function function_49f84c53a7f39086(effect_type) {
  return isDefined(self.status_effects) && isDefined(self.status_effects[effect_type]) && self.status_effects[effect_type].size > 0;
}

function function_3849b7f022c62f32(effect_type, element_type) {
  if(isDefined(self.status_effects[effect_type])) {
    foreach(status in self.status_effects[effect_type]) {
      if(status.element_type === element_type) {
        return true;
      }
    }
  }

  return false;
}

function function_94a7f44187606b85(effect_type, effect_id) {
  assert(isstring(effect_id), "<dev string:x24>");

  if(!function_49f84c53a7f39086(effect_type)) {
    return false;
  }

  foreach(active_effect in self.status_effects[effect_type]) {
    if(effect_id === active_effect.unique_id) {
      return true;
    }
  }

  return false;
}

function function_1c3c4f0aa9a6109a(effect_type, durations, unique_id, start_func, end_func, element_type) {
  base_effect = spawnStruct();
  base_effect.effect_type = effect_type;
  base_effect.unique_id = unique_id;
  base_effect.durations = durations;
  base_effect.start_func = start_func;
  base_effect.end_func = end_func;
  base_effect.end_time = gettime() + utility::function_fe771e2bf31fa2fc(base_effect.durations);
  base_effect.element_type = element_type;
  return base_effect;
}

function start_effect(effect) {
  if(!isDefined(self.status_effects)) {
    self.status_effects = [];
  }

  if(!isDefined(self.status_effects[effect.effect_type])) {
    self.status_effects[effect.effect_type] = [];
  }

  if(isDefined(effect.unique_id)) {
    foreach(active_effect in self.status_effects[effect.effect_type]) {
      if(isDefined(active_effect.unique_id) && effect.unique_id == active_effect.unique_id) {
        active_effect.end_time = -1;
      }
    }
  }

  self.status_effects[effect.effect_type][self.status_effects[effect.effect_type].size] = effect;

  if(isDefined(effect.start_func)) {
    self[[effect.start_func]](effect);
  }

  thread effects_monitor();
  return true;
}

function private effects_monitor() {
  self notify("\x10\xf4\xefF\xc6\xd7\x13fz\xa9B\xaf3{c\xb0");
  self endon("\x10\xf4\xefF\xc6\xd7\x13fz\xa9B\xaf3{c\xb0");

  if(!isDefined(self.status_effects)) {
    println("<dev string:x44>");
    return;
  }

  if(!callback::exists(#"on_ai_killed", &function_7a13717b5407de0f)) {
    callback::add(#"on_ai_killed", &function_7a13717b5407de0f);
  }

  num_effects = self.status_effects.size;

  while(num_effects > 0 && isalive(self)) {
    now = gettime();
    expired_effects = [];

    if(isDefined(self.status_effects)) {
      foreach(effects in self.status_effects) {
        active_effects = [];

        foreach(effect in effects) {
          if(now < effect.end_time) {
            active_effects[active_effects.size] = effect;
            continue;
          }

          expired_effects[expired_effects.size] = effect;
        }

        self.status_effects[effect_type] = active_effects;
      }
    }

    foreach(effect in expired_effects) {
      end_effect(effect);
    }

    if(isDefined(self.status_effects) && isDefined(self.status_effects.size)) {
      num_effects = self.status_effects.size;
    } else {
      num_effects = 0;
    }

    waitframe();
  }

  callback::remove(#"on_ai_killed", &function_7a13717b5407de0f);
}

function private end_effect(effect) {
  if(isDefined(effect.end_func)) {
    self[[effect.end_func]](effect);
  }
}

function private function_7a13717b5407de0f(params) {
  foreach(effects in self.status_effects) {
    foreach(effect in effects) {
      end_effect(effect);
    }
  }
}

function private function_aa5e83a2d77857d3() {
  level endon("<dev string:x75>");

  while(true) {
    entity_num = getdvarint(@ "hash_f429fe6098c1896a", -1);
    entity = getentbynum(entity_num);

    if(isDefined(entity)) {
      now = gettime();
      print_x = 400;
      print_y = 300;
      printtoscreen2d(print_x, print_y, "<dev string:x83>");

      if(isDefined(entity.status_effects)) {
        foreach(effects in entity.status_effects) {
          if(effects.size == 0) {
            continue;
          }

          unique_ids = [];
          remainingms = 0;

          foreach(effect in effects) {
            effect_remainingms = effect.end_time - now;

            if(effect_remainingms > remainingms) {
              remainingms = effect_remainingms;
            }

            if(isDefined(effect.unique_id)) {
              unique_ids = utility::function_e86d2ca144f6bde8(unique_ids, effect.unique_id);
            }
          }

          print_y += 20;
          var_6d2ed5d281e8292f = effect_type + "<dev string:x95>" + effects.size + "<dev string:x9b>" + utility::function_7db7b41478a3232a(remainingms) + "<dev string:xa1>";
          printtoscreen2d(print_x, print_y, var_6d2ed5d281e8292f);

          foreach(id in unique_ids) {
            print_y += 20;
            printtoscreen2d(print_x + 10, print_y, id);
          }
        }
      }
    }

    waitframe();
  }
}

# /