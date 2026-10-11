/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5a4a5d9ba343ff8f.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace status_effects;

function init_status_effects() {
  level thread function_a29b12dda2453832();
}

function function_8ce7894f1a52fb77(effect_type) {
  return isDefined(self.status_effects) && isDefined(self.status_effects[effect_type]) && self.status_effects[effect_type].size > 0;
}

function function_3b7a43c0f32fc107() {
  if(!isDefined(self.status_effects)) {
    return false;
  }

  return self.status_effects.size > 0;
}

function function_108973a907c11ca7(effect_type, durations, unique_id, start_func, end_func) {
  base_effect = spawnStruct();
  base_effect.effect_type = effect_type;
  base_effect.unique_id = unique_id;
  base_effect.durations = durations;
  base_effect.start_func = start_func;
  base_effect.end_func = end_func;
  base_effect.end_time = gettime() + function_a5b14435e3229bed(base_effect.durations);
  return base_effect;
}

function start_effect(effect) {
  self.status_effects = default_to(self.status_effects, []);
  self.status_effects[effect.effect_type] = default_to(self.status_effects[effect.effect_type], []);

  if(isDefined(effect.unique_id)) {
    foreach(active_effect in self.status_effects[effect.effect_type]) {
      if(isDefined(active_effect.unique_id) && effect.unique_id == active_effect.unique_id) {
        active_effect.end_time = -1;
      }
    }
  }

  self.status_effects[effect.effect_type] = array_add(self.status_effects[effect.effect_type], effect);

  if(isDefined(effect.start_func)) {
    self[[effect.start_func]](effect);
  }

  thread effects_monitor();
  return true;
}

function private effects_monitor() {
  self notify("start_status_effects_monitor");
  self endon("start_status_effects_monitor");
  self endon("death");

  if(!isDefined(self.status_effects)) {
    println("<dev string:x1c>");
    return;
  }

  num_effects = self.status_effects.size;

  while(num_effects > 0) {
    now = gettime();
    expired_effects = [];

    foreach(effect_type, effects in self.status_effects) {
      active_effects = [];

      foreach(effect in effects) {
        if(now < effect.end_time) {
          active_effects = array_add(active_effects, effect);
          continue;
        }

        expired_effects = array_add(expired_effects, effect);
      }

      self.status_effects[effect_type] = active_effects;
    }

    foreach(effect in expired_effects) {
      end_effect(effect);
    }

    num_effects = self.status_effects.size;
    waitframe();
  }
}

function private end_effect(effect) {
  if(isDefined(effect.end_func)) {
    self[[effect.end_func]](effect);
  }
}

function private function_a29b12dda2453832() {
  level endon("<dev string:x4d>");

  while(true) {
    entity_num = getdvarint(@ "hash_f429fe6098c1896a", -1);
    entity = getentbynum(entity_num);

    if(isDefined(entity)) {
      now = gettime();
      print_x = 400;
      print_y = 300;
      printtoscreen2d(print_x, print_y, "<dev string:x5b>");

      if(isDefined(entity.status_effects)) {
        foreach(effect_type, effects in entity.status_effects) {
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
              unique_ids = function_6d6af8144a5131f1(unique_ids, effect.unique_id);
            }
          }

          print_y += 20;
          var_72d6d5843877426 = effect_type + "<dev string:x6d>" + effects.size + "<dev string:x73>" + function_c89ed1840c8d0f0f(remainingms) + "<dev string:x79>";
          printtoscreen2d(print_x, print_y, var_72d6d5843877426);

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