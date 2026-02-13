/******************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_side_quest.gsc
******************************************************************/

init() {
  level._effect["cow_skull_fire_fx"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_activating_cow_skull_fire");
  level thread init_cow_skulls();

  if(!getdvarint("#x3a165e78de6483fc8", 0)) {
    return;
  }
  level scripts\engine\utility::_id_5C24("introscreen_over");
  level.pluck_times = 0;
  level.music_ee_istriggered = 0;
  level thread init_ee_vanishing_shore();
}

init_ee_vanishing_shore() {
  var_0 = scripts\engine\utility::getstruct("s_instrument", "targetname");
  var_0 thread play_string_sound();
  _id_0737::_id_C266("music_ee_interact", ::music_ee_interact_hint_func, ::on_music_ee_interact, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 64);
  _id_0737::addinteractionhinttypecallback("music_ee_interact", ::music_ee_interact_type);
}

play_string_sound() {
  level endon("game_ended");
  self endon("death");
  var_0 = randomintrange(50, 71);

  while(!level.music_ee_istriggered) {
    scripts\cp\utility::_id_B8ED(self.origin, "zmb_mee_creepy_strings");
    wait(var_0);
  }
}

music_ee_interact_hint_func(var_0, var_1) {
  return "";
}

music_ee_interact_type(var_0, var_1) {
  return "HINT_NOBUTTON";
}

on_music_ee_interact(var_0, var_1) {
  level endon("game_ended");

  if(!istrue(var_0.is_activated)) {
    var_2 = "";

    switch (level.pluck_times) {
      case 0:
        var_2 = "zmb_mee_pluck_0";
        level.music_ee_istriggered = 1;
        break;
      case 1:
        var_2 = "zmb_mee_pluck_1";
        break;
      case 2:
        var_2 = "zmb_mee_pluck_2";
        break;
      default:
        break;
    }

    if(var_2 == "") {
      return;
    }
    scripts\cp\utility::_id_B8ED(var_0.origin, var_2);
    level.pluck_times++;
    var_0.is_activated = 1;
    wait 3;
    var_0.is_activated = 0;

    if(level.pluck_times >= 3) {
      wait 2;
      _func_01E3("ee_song");
      _id_0737::_id_C3C5(var_0);
    }
  }
}

init_cow_skulls() {
  var_0 = scripts\engine\utility::getstructarray("s_skull", "targetname");
  level.n_hit_index = 0;

  foreach(var_2 in var_0) {
    var_2.mdl = scripts\cp\utility::_id_E190("s4_zm_statue_twig_05", var_2.origin, var_2.angles);
  }

  if(!getdvarint("#x3a165e78de6483fc8", 0)) {
    return;
  }
  foreach(var_2 in var_0) {
    var_2.mdl.parent = var_2;
    var_2.mdl setCanDamage(1);
    var_2.mdl thread take_damage_listener();
    var_2.n_index = int(var_2._id_039B);
  }

  level thread shot_cow_skulls_check(var_0);
}

take_damage_listener() {
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(scripts\engine\utility::_id_5C00("cow_skulls_in_cool_down")) {
      waitframe();
      continue;
    }

    var_10 = 0;

    if(var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_MELEE" || var_4 == "MOD_PROJECTILE") {
      if(isDefined(self.parent.n_index) && level.n_hit_index == self.parent.n_index) {
        playFXOnTag(level._effect["cow_skull_fire_fx"], self, "tag_origin");
        var_10 = 1;

        foreach(var_12 in level.players) {
          if(var_12 scripts\cp\utility::_id_8708()) {
            var_13 = distance2dsquared(self.origin, var_12.origin);

            if(var_13 <= _func_0219(250)) {
              var_12 earthquakeforplayer(0.5, 1, var_12.origin, 100);
              var_12 _meth_827A("cp_zm_s2_mq_shield_rumble", var_12.origin);
            }
          }
        }
      }

      level notify("hit_cow_skull", var_10, self.origin);
    }
  }
}

shot_cow_skulls_check(var_0) {
  level endon("game_ended");
  var_1 = 0;

  for(;;) {
    level waittill("hit_cow_skull", var_2, var_3);

    if(istrue(var_2)) {
      if(!istrue(var_1)) {
        level thread shot_cow_skulls_time_out();
        var_1 = 1;
      }

      level.n_hit_index++;

      if(isDefined(var_3)) {
        scripts\cp\utility::_id_B8ED(var_3, "zmb_cow_skull");
      }
    } else {
      level notify("kill_rampage_quest_timer");

      if(isDefined(var_3)) {
        scripts\cp\utility::_id_B8ED(var_3, "zmb_shooting_gallery_fail");
      }

      var_1 = 0;
      level.n_hit_index = 0;
      level scripts\engine\utility::_id_5C1B("cow_skulls_in_cool_down");
      wait 30;
      level scripts\engine\utility::_id_5C04("cow_skulls_in_cool_down");
    }

    if(level.n_hit_index == var_0.size) {
      level notify("kill_rampage_quest_timer");
      level thread scripts\cp\zombies\zm_round_accelerant::init_round_accelerant();

      foreach(var_5 in level.players) {
        if(isPlayer(var_5)) {
          level thread scripts\cp\utility::_id_B8F4("zmb_sam_success", var_5);
        }
      }

      break;
    }

    wait 0.5;
  }
}

shot_cow_skulls_time_out() {
  level endon("game_ended");
  level endon("kill_rampage_quest_timer");
  wait 15;
  level.n_hit_index = 0;
}