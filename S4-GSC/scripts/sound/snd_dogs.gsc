/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\sound\snd_dogs.gsc
*************************************************/

init_dog_audio_flags() {
  self endon("death");

  if(scripts\engine\utility::_id_5472("pain_sound_playing") == 0) {
    scripts\engine\utility::_id_5473("pain_sound_playing");
  }

  if(scripts\engine\utility::_id_5472("pursuit_playing_sound") == 0) {
    scripts\engine\utility::_id_5473("pursuit_playing_sound");
  }

  if(scripts\engine\utility::_id_5472("idle_playing_sound") == 0) {
    scripts\engine\utility::_id_5473("idle_playing_sound");
  }

  if(scripts\engine\utility::_id_5472("bark_anim_playing_sound") == 0) {
    scripts\engine\utility::_id_5473("bark_anim_playing_sound");
  }

  if(!isDefined(level.dog_count)) {
    level.dog_count = [];
  }

  level.dog_count[level.dog_count.size] = self;
  thread play_dog_idle_sound();
}

play_dog_pain_sound() {
  self endon("death");
  thread stop_dog_sounds(0.1, 1);

  if(isDefined(self) && isalive(self)) {
    scripts\engine\utility::_id_5474("pain_sound_playing");
    dog_sound_call_wait("anml_dog_hurt", 0.4, 0.5, 1);
    scripts\engine\utility::_id_5470("pursuit_playing_sound");
    thread try_play_dog_pursuit_sound();
    wait 0.1;
    scripts\engine\utility::_id_5470("pain_sound_playing");
  }
}

play_dog_death_sound() {
  thread stop_dog_sounds(0.1, 1);
  var_0 = self.origin;

  if(isDefined(self) && scripts\engine\utility::_id_546E("pain_sound_playing")) {
    wait 0.1;
    self playSound("anml_dog_die");
  } else
    self playSound("anml_dog_die");

  level.dog_count = scripts\engine\utility::array_remove(level.dog_count, self);
}

play_dog_attack_sound() {
  self endon("death");
  self endon("damage");
  scripts\engine\utility::_id_5474("pursuit_playing_sound");
  thread stop_dog_sounds(0.1, 1);
  dog_sound_call_wait("anml_dog_attack", 0.2, 0.21);

  if(isDefined(self) && isalive(self) && isDefined(self._id_0192) && distance(self._id_0192.origin, self.origin) < 600.0) {
    scripts\engine\utility::_id_5470("pursuit_playing_sound");
    thread try_play_dog_pursuit_sound(1);
  }
}

try_play_dog_pursuit_sound(var_0) {
  self endon("stop_dog_loop_sound");
  self endon("death");

  if(!scripts\engine\utility::_id_546E("pursuit_playing_sound")) {
    scripts\engine\utility::_id_5474("pursuit_playing_sound");

    if(isDefined(var_0) && var_0) {
      wait 1.0;
    } else {
      wait(randomfloatrange(0.1, 0.2));
    }

    var_1 = 1;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;

    while(scripts\engine\utility::_id_546E("pursuit_playing_sound") && isalive(self)) {
      if(!isDefined(self._id_0192)) {
        scripts\engine\utility::_id_5470("idle_playing_sound");
        scripts\engine\utility::_id_5470("pursuit_playing_sound");
        play_dog_idle_sound();
      }

      if(!scripts\common\utility::issp()) {
        var_1 = get_wait_time_scaler(var_1, 1);

        if(level.dog_count.size == 3) {
          var_5 = 55;
        } else if(level.dog_count.size == 2) {
          var_5 = 70;
        } else {
          var_5 = 85;
        }
      }

      var_6 = randomintrange(1, 101);

      if((var_6 < 30 || var_3 || var_4) && var_2 < 2) {
        dog_sound_call_wait("anml_dog_pursuit_pant", 0.35 * var_1, 0.45 * var_1);
        var_2++;
      } else if(var_6 >= 30 && var_6 < 70 || !var_3) {
        dog_sound_call_wait("anml_dog_bark_pregrowl", 0.85 * var_1, 0.9 * var_1);
        var_3 = 1;
      } else {
        dog_sound_call_wait("anml_dog_growl", 0.8 * var_1, 0.9 * var_1);
        var_4 = 1;
      }

      if(var_2 >= 2 && var_3 && var_4) {
        var_2 = 0;
        var_3 = 0;
        var_4 = 0;
      }
    }
  }
}

play_dog_idle_sound() {
  self endon("death");
  self endon("stop_dog_loop_sound");
  self endon("pursuit_playing_sound");

  if(!scripts\engine\utility::_id_546E("idle_playing_sound")) {
    scripts\engine\utility::_id_5474("idle_playing_sound");
    wait(randomfloatrange(0.1, 0.2));
    var_0 = 1;
    var_1 = 0;

    while(scripts\engine\utility::_id_546E("idle_playing_sound") && isalive(self)) {
      if(isDefined(self._id_0192)) {
        return;
      }
      if(!scripts\common\utility::issp()) {
        var_0 = get_wait_time_scaler(var_0, 0);
      }

      if(randomintrange(1, 100) >= 80 || var_1 > 5) {
        dog_sound_call_wait("anml_dog_groan", 0.1 * var_0, 0.6 * var_0, 1);
        var_1 = 0;

        if(randomintrange(1, 100) >= 50) {
          dog_sound_call_wait("anml_dog_groan", 0.1 * var_0, 0.6 * var_0, 1);
        } else {
          dog_sound_call_wait("anml_dog_med_pant_walk", 0.3 * var_0, 0.8 * var_0, 1);
          var_1++;
        }

        continue;
      }

      dog_sound_call_wait("anml_dog_med_pant_walk", 0.3 * var_0, 0.8 * var_0, 1);
      var_1++;
    }
  }
}

get_wait_time_scaler(var_0, var_1) {
  if(var_1) {
    if(level.dog_count.size == 3) {
      var_0 = 1.4;
    } else if(level.dog_count.size == 2) {
      var_0 = 1.2;
    } else {
      var_0 = 1;
    }
  } else if(level.dog_count.size == 3)
    var_0 = 2.0;
  else if(level.dog_count.size == 2) {
    var_0 = 1.5;
  } else {
    var_0 = 1;
  }

  return var_0;
}

dog_sound_call_wait(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = thread _id_0847::_id_DF08(var_0, self);

  if(isDefined(var_3) && var_3 == 1 && isalive(self)) {
    _id_0847::_id_DF3C(var_4);
  }

  wait(randomfloatrange(var_1, var_2));
}

try_stop_dog_pursuit_sound() {
  self endon("death");

  if(isDefined(self) && isDefined(self._id_0192) && distance(self._id_0192.origin, self.origin) > 600.0) {
    thread stop_dog_sounds(0.1, 1);
    scripts\engine\utility::_id_5470("pursuit_playing_sound");
  }
}

stop_dog_sounds(var_0, var_1) {
  self endon("death");

  if(var_1 && isalive(self)) {
    self notify("stop_dog_loop_sound");
  }

  var_2 = thread _id_0847::_id_DEE1(self);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(var_2[var_3]._id_E05E)) {
      if(var_2[var_3]._id_E05E == "anml_dog_growl" || var_2[var_3]._id_E05E == "anml_dog_bark_pregrowl" || var_2[var_3]._id_E05E == "anml_dog_pursuit_pant" || var_2[var_3]._id_E05E == "anml_dog_med_pant_walk" || var_2[var_3]._id_E05E == "anml_dog_groan" || var_2[var_3]._id_E05E == "anml_dog_attack") {
        if(isDefined(var_2[var_3])) {
          if(isDefined(var_0)) {
            thread _id_0847::_id_DF21(var_2[var_3], var_0);
            continue;
          }

          thread _id_0847::_id_DF21(var_2[var_3], 0.1);
        }
      }
    }
  }
}

play_dog_bark_sounds() {
  self endon("death");
  self endon("damage");

  if(!scripts\engine\utility::_id_546E("bark_anim_playing_sound")) {
    scripts\engine\utility::_id_5474("bark_anim_playing_sound");
  } else {
    return;
  }

  thread stop_dog_sounds(0.1, 1);

  for(;;) {
    var_0 = self _meth_884F();
    var_1 = 0;

    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      if(var_0[var_2]["name"] == "s4_dog_combat_bark") {
        var_1 = 1;
      }
    }

    if(!var_1) {
      if(isDefined(self) && isalive(self) && isDefined(self._id_0192) && distance(self._id_0192.origin, self.origin) < 1000.0) {
        scripts\engine\utility::_id_5470("bark_anim_playing_sound");
        scripts\engine\utility::_id_5470("pursuit_playing_sound");
        thread try_play_dog_pursuit_sound();
        return;
      }
    }

    waitframe();
  }
}