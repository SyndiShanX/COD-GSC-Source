/**********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sumpf\cp_sumpf_ee_music.gsc
**********************************************************/

init() {
  if(!getdvarint("#x33ad41eaa5a9a3eec", 0) == 1) {
    return;
  }
  level._effect["evil_doll_disappear"] = loadfx("vfx/s4/zombie/vfx_samantha_interact.vfx");
  level._effect["evil_doll_explode"] = loadfx("vfx/s4/zombie/vfx_samantha_explode.vfx");
  level._effect["evil_doll_dust"] = loadfx("vfx/s4/zombie/vfx_samantha_dust.vfx");
  init_ee_music_quest();
}

init_ee_music_quest() {
  _id_099C::_id_C211("samantha", 1, ::init_samantha_step_one, ::do_samantha_step_one, ::cleanup_samantha_step_one, ::debug_samantha_step_one);
  _id_099C::_id_C211("samantha", 2, ::init_samantha_step_two, ::do_samantha_step_two, ::cleanup_samantha_step_two, ::debug_samantha_step_two);
  _id_099C::_id_C211("samantha", 3, ::init_samantha_step_three, ::do_samantha_step_three, ::cleanup_samantha_step_three, ::debug_samantha_step_three);
  _id_099C::_id_C211("the_one", 1, ::init_the_one_step_one, ::do_the_one_step_one, ::cleanup_the_one_step_one, ::debug_the_one_step_one);
  _id_099C::_id_C211("creepy_sounds", 1, ::init_creepy_sounds_step_one, ::do_creepy_sounds_step_one, ::cleanup_creepy_sounds_step_one, ::debug_creepy_sounds_step_one);
}

init_samantha_step_one() {
  level scripts\engine\utility::_id_5C24("introscreen_over");
  var_0 = scripts\engine\utility::getstructarray("metal_dish_pos", "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\cp\utility::_id_E190("s4_zm_metal_plate", var_2.origin, var_2.angles);
    var_3 setCanDamage(1);
    var_3 thread take_damage_listener();
  }
}

take_damage_listener() {
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_MELEE" || var_4 == "MOD_PROJECTILE") {
      if(!istrue(self.b_hit)) {
        level notify("hit_metal_dish");
        self.b_hit = 1;
      }

      scripts\cp\utility::_id_B8ED(self.origin, "zmb_pan_hit");
    }
  }
}

do_samantha_step_one() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstructarray("metal_dish_pos", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    level waittill("hit_metal_dish");
  }

  wait 1;

  foreach(var_3 in level.players) {
    if(isPlayer(var_3)) {
      level thread scripts\cp\utility::_id_B8F4("zmb_sam_success", var_3);
    }
  }

  var_5 = scripts\engine\utility::getstruct("evil_doll_pos1", "targetname");
  var_5.mdl_doll = scripts\cp\utility::_id_E190("s4_zm_samantha_toy", var_5.origin, var_5.angles);
  playFX(level._effect["evil_doll_disappear"], var_5.mdl_doll.origin);
  _id_0737::_id_C266("evil_doll_pos1", ::hint_interact_doll, ::on_interact_doll, undefined, undefined, undefined, undefined, undefined, 0, undefined, 80);
  level waittill("interact_doll");
  playFX(level._effect["evil_doll_disappear"], var_5.mdl_doll.origin);
  scripts\cp\utility::_id_B8ED(var_5.origin, "zmb_sam_disappear");
  var_5.mdl_doll delete();
}

hint_interact_doll(var_0, var_1) {
  return "";
}

on_interact_doll(var_0, var_1) {
  level notify("interact_doll");
  var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
  _id_0737::_id_C3C5(var_0);
}

look_at_check(var_0, var_1) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(!istrue(self.b_looked_at)) {
      foreach(var_3 in level.players) {
        if(!isPlayer(var_3)) {
          continue;
        }
        var_4 = 0;
        var_5 = vectortoangles(self.origin - var_3 getEye());
        var_5 = anglesToForward(var_5);

        if(isDefined(var_5)) {
          var_6 = var_3 getplayerangles();
          var_6 = anglesToForward(var_6);
          var_4 = length(var_6 - var_5);
        }

        var_7 = distancesquared(self.origin, var_3.origin);

        if(var_4 <= var_0 && var_7 <= _func_0219(var_1)) {
          self.b_looked_at = 1;
          self.lookat_player = var_3;
          break;
        } else
          self.b_looked_at = 0;
      }
    } else if(isPlayer(self.lookat_player)) {
      var_4 = 0;
      var_5 = vectortoangles(self.origin - self.lookat_player getEye());
      var_5 = anglesToForward(var_5);

      if(isDefined(var_5)) {
        var_6 = self.lookat_player getplayerangles();
        var_6 = anglesToForward(var_6);
        var_4 = length(var_6 - var_5);
      }

      var_7 = distancesquared(self.origin, self.lookat_player.origin);

      if(var_4 <= var_0 && var_7 <= _func_0219(var_1)) {
        self.b_looked_at = 1;
      } else {
        self.b_looked_at = 0;
      }
    } else
      self.b_looked_at = 0;

    wait 0.1;
  }
}

cleanup_samantha_step_one() {}

debug_samantha_step_one() {}

init_samantha_step_two() {}

do_samantha_step_two() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstructarray("doll_target_pos", "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);

  while(scripts\engine\utility::_id_5C00("ee_music_is_busy")) {
    wait 1;
  }

  level scripts\engine\utility::_id_5C1B("ee_music_is_busy");

  foreach(var_2 in var_0) {
    playFX(level._effect["evil_doll_explode"], var_2.origin);
    var_2.mdl_doll = scripts\cp\utility::_id_E190("s4_zm_samantha_toy", var_2.origin, var_2.angles);
    var_2.mdl_doll setCanDamage(1);
    var_2.mdl_doll thread rotate_by_time();
    var_2.mdl_doll playLoopSound("mus_zm_musicbox_lp");
    scripts\cp\utility::_id_B8ED(var_2.origin, "zmb_sam_appear");

    for(;;) {
      var_2.mdl_doll waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

      if(var_7 == "MOD_PISTOL_BULLET" || var_7 == "MOD_RIFLE_BULLET" || var_7 == "MOD_MELEE" || var_7 == "MOD_PROJECTILE") {
        playFX(level._effect["evil_doll_explode"], var_2.mdl_doll.origin);
        scripts\cp\utility::_id_B8ED(var_2.origin, "zmb_sam_disappear");
        var_2.mdl_doll stoploopsound("mus_zm_musicbox_lp");
        var_2.mdl_doll delete();
        break;
      }
    }

    wait 1;
  }

  foreach(var_15 in level.players) {
    if(isPlayer(var_15)) {
      level thread scripts\cp\utility::_id_B8F4("zmb_sam_success", var_15);
    }
  }
}

rotate_by_time() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_rotate");

  for(;;) {
    self.angles = self.angles + (0, 10, 0);
    wait 0.1;
  }
}

cleanup_samantha_step_two() {}

debug_samantha_step_two() {}

init_samantha_step_three() {}

do_samantha_step_three() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstruct("evil_doll_pos", "targetname");
  var_0.mdl_doll = scripts\cp\utility::_id_E190("s4_zm_samantha_toy", var_0.origin, var_0.angles);
  var_0.mdl_doll playLoopSound("mus_zm_musicbox_lp");
  var_0.mdl_doll thread rotate_by_time();
  _id_0737::_id_C266("evil_doll_pos", ::hint_interact_doll, ::on_interact_doll, undefined, undefined, undefined, undefined, undefined, 0, undefined, 80);
  level waittill("interact_doll");
  var_0.mdl_doll notify("stop_rotate");
  var_1 = scripts\engine\utility::getstruct("evil_hand_pos", "targetname");
  var_1.mdl = scripts\cp\utility::_id_E190("s4_zm_skeleton_hand", var_1.origin, var_1.angles);
  var_1.mdl linkto(var_0.mdl_doll);
  playFX(level._effect["evil_doll_dust"], var_0.mdl_doll.origin, anglesToForward(var_0.mdl_doll.angles), anglestoup(var_0.mdl_doll.angles));
  var_0.mdl_doll stoploopsound("mus_zm_musicbox_lp");
  var_0.mdl_doll moveto(var_0.mdl_doll.origin + (0, 0, 15), 1);
  scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_skel_arm_up");
  var_0.mdl_doll waittill("movedone");
  var_0.mdl_doll moveto(var_0.mdl_doll.origin + (0, 0, -50), 1);
  var_0.mdl_doll playLoopSound("zmb_skel_arm_lp");
  var_0.mdl_doll waittill("movedone");
  var_0.mdl_doll stoploopsound("zmb_skel_arm_lp");
  var_1.mdl unlink();
  var_1.mdl delete();
  var_0.mdl_doll delete();
  var_2 = _func_02A9(var_0.origin, 50);
  var_3 = _id_0990::_id_E3DD("full_ammo", var_2);
  wait 1;

  foreach(var_5 in level.players) {
    if(isPlayer(var_5)) {
      level thread scripts\cp\utility::_id_B8F4("mus_zm_sam_sorrows", var_5);
    }
  }

  var_7 = _id_0720::get_dialogue_length("mus_zm_sam_sorrows");
  wait(var_7);
  level scripts\engine\utility::_id_5C04("ee_music_is_busy");
}

cleanup_samantha_step_three() {}

debug_samantha_step_three() {}

init_the_one_step_one() {
  level scripts\engine\utility::_id_5C24("introscreen_over");
}

do_the_one_step_one() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstruct("the_one_song_pos", "targetname");
  var_0.mdl = scripts\cp\utility::_id_E190("s4_zm_par_rotary_phone", var_0.origin, var_0.angles);
  var_0._id_039B = "the_one_song";
  _id_0737::_id_C266("the_one_song", ::hint_interact_telephone, ::on_interact_telephone, undefined, undefined, undefined, undefined, undefined, 0, undefined, 50);
  level waittill("interact_telephone");
  level scripts\engine\utility::_id_5C1B("ee_music_is_busy");
  scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_telephone");
  var_1 = _id_0720::get_dialogue_length("zmb_telephone");
  wait(var_1);
  wait 1;

  foreach(var_3 in level.players) {
    if(isPlayer(var_3)) {
      level thread scripts\cp\utility::_id_B8F4("mus_zm_the_one_ee", var_3);
    }
  }

  var_1 = _id_0720::get_dialogue_length("mus_zm_the_one_ee");
  wait(var_1);
  level scripts\engine\utility::_id_5C04("ee_music_is_busy");
}

hint_interact_telephone(var_0, var_1) {
  return "";
}

on_interact_telephone(var_0, var_1) {
  level notify("interact_telephone");
  var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
  _id_0737::_id_C3C5(var_0);
}

cleanup_the_one_step_one() {}

debug_the_one_step_one() {}

init_creepy_sounds_step_one() {
  level scripts\engine\utility::_id_5C24("introscreen_over");
}

do_creepy_sounds_step_one() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstruct("the_creepy_sounds_pos", "targetname");
  var_0._id_039B = "creepy_sound_interaction";
  var_0.b_cool_down = 1;
  _id_0737::_id_C266("creepy_sound_interaction", ::hint_interact_creepy_machine, ::on_interact_creepy_machine, undefined, undefined, undefined, undefined, undefined, 0, undefined, 50);
}

hint_interact_creepy_machine(var_0, var_1) {
  if(istrue(var_0.b_cool_down)) {
    return "";
  } else {
    return "";
  }
}

on_interact_creepy_machine(var_0, var_1) {
  level endon("game_ended");

  if(!istrue(var_0.b_cool_down)) {
    return;
  }
  var_0.b_cool_down = 0;
  var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
  scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_creepy_radio");
  var_2 = _id_0720::get_dialogue_length("zmb_creepy_radio");
  wait(var_2 + 3);
  var_0.b_cool_down = 1;
}

cleanup_creepy_sounds_step_one() {}

debug_creepy_sounds_step_one() {}