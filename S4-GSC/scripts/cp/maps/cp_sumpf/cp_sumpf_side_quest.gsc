/************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sumpf\cp_sumpf_side_quest.gsc
************************************************************/

init() {
  level thread init_oil_lamps();

  if(!getdvarint("#x33ad41eaa5a9a3eec", 0)) {
    return;
  }
  level scripts\engine\utility::_id_5C24("introscreen_over");
  level.n_find_buny_part_count = 0;
  level thread init_bunny_torso();
  level thread init_bunny_head();
  level thread init_bunny_leg();
}

spawn_bunny_quest_reward(var_0) {
  level endon("game_ended");
  var_1 = undefined;

  while(!isvector(var_1)) {
    if(isPlayer(var_0)) {
      var_1 = _func_02A9(var_0.origin, 50);
    } else {
      var_0 = scripts\engine\utility::array_random(level.players);

      if(isPlayer(var_0)) {
        var_1 = _func_02A9(var_0.origin, 50);
      }
    }

    wait 0.1;
  }

  foreach(var_3 in level.players) {
    if(isPlayer(var_3)) {
      scripts\cp\utility::_id_B8F4("zmb_bunny_success", var_3);
    }
  }

  var_5 = _id_0990::_id_E3DD("fire_sale", var_1);
  var_5.n_override_lifetime = 50;

  for(var_6 = 0; var_6 <= 9; var_6++) {
    var_1 = _func_02A9(var_1, 70);
    level thread _id_0990::_id_E3DD("bonus_points_team", var_1);
  }
}

spawn_loot_fountain(var_0) {
  level endon("game_ended");
  var_1 = spawnStruct();

  while(!isvector(var_1.origin)) {
    if(isPlayer(var_0)) {
      var_1.origin = _func_02A9(var_0.origin, 50);
    } else {
      var_0 = scripts\engine\utility::array_random(level.players);

      if(isPlayer(var_0)) {
        var_1.origin = _func_02A9(var_0.origin, 50);
      }
    }

    wait 0.1;
  }

  wait 2;
  drop_final_loot(var_1);
}

drop_final_loot(var_0) {
  var_1 = scripts\cp\utility::_id_E190("tag_origin", var_0.origin);
  var_2 = level.cache_drop_table_names["zm_loot_chest"];

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = _id_073D::get_highest_round_loot_table(var_2, 9);

  if(isDefined(var_1)) {
    playFX(level._effect["mq_final_loot_fx"], var_1.origin);
    var_1 playSound("zmb_exfil_portal_open");
    _id_073D::select_and_spawn_items_from_table(var_3, var_1.origin + (0, 0, 48), var_1.angles, undefined, "zm_loot_chest", 20, undefined, 0.2, "zmb_spawn_portal", var_1);
  }
}

init_bunny_torso() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstruct("bunny_head", "targetname");
  var_0.mdl_bunny = scripts\cp\utility::_id_E190("s4_zm_bunny_body", var_0.origin, var_0.angles);
  var_0.mdl_bunny._id_039B = "bunny_interact";
  var_0.mdl_bunny.b_torso = 1;

  if(isDefined(level.zipline)) {
    var_0.mdl_bunny linkto(level.zipline);
  }

  var_0.mdl_bunny thread play_laugh_sound();
  var_0.mdl_bunny thread visible_for_player_listener();
  _id_C266("bunny_interact", ::bunny_interact_hint_func, ::on_bunny_interact, undefined, undefined, undefined, undefined, undefined, 32);
  _id_0737::addinteractionhinttypecallback("bunny_interact", ::bunny_interact_type);
  level waittill("pick_up_bunny_torso");

  foreach(var_2 in level.players) {
    if(isPlayer(var_2) && check_visible(var_2)) {
      _func_019D(level._effect["evil_doll_explode"], var_0.mdl_bunny, "tag_origin", var_2);
    }
  }

  var_0.mdl_bunny _meth_83F8();
  var_0.mdl_bunny.ent_sound_proxy _meth_83F8();
  scripts\cp\utility::_id_10839(5);
  var_0.mdl_bunny.ent_sound_proxy delete();
  var_0.mdl_bunny delete();
}

init_bunny_leg() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstruct("bunny_leg", "targetname");
  var_0.mdl_bunny = scripts\cp\utility::_id_E190("s4_zm_bunny_legs", var_0.origin + (0, 0, 5), var_0.angles);
  var_0.mdl_bunny._id_039B = "bunny_interact";
  var_0.mdl_bunny.b_leg = 1;
  var_0.mdl_bunny thread play_laugh_sound();
  var_0.mdl_bunny thread visible_for_player_listener();
  _id_C266("bunny_interact", ::bunny_interact_hint_func, ::on_bunny_interact, undefined, undefined, undefined, undefined, undefined, 100);
  _id_0737::addinteractionhinttypecallback("bunny_interact", ::bunny_interact_type);
  level waittill("pick_up_bunny_leg");

  foreach(var_2 in level.players) {
    if(isPlayer(var_2) && check_visible(var_2)) {
      _func_019D(level._effect["evil_doll_explode"], var_0.mdl_bunny, "tag_origin", var_2);
    }
  }

  var_0.mdl_bunny _meth_83F8();
  var_0.mdl_bunny.ent_sound_proxy _meth_83F8();
  scripts\cp\utility::_id_10839(5);
  var_0.mdl_bunny.ent_sound_proxy delete();
  var_0.mdl_bunny delete();
}

init_bunny_head() {
  level endon("game_ended");
  level thread bunny_head_spawn_listener();
  level waittill("pick_up_bunny_head", var_0);

  if(isDefined(var_0)) {
    foreach(var_2 in level.players) {
      if(isPlayer(var_2) && check_visible(var_2)) {
        _func_019D(level._effect["evil_doll_explode"], var_0, "tag_origin", var_2);
      }
    }

    var_0 _meth_83F8();
    scripts\cp\utility::_id_10839(5);
    var_0 delete();
  }
}

bunny_head_spawn_listener() {
  level endon("game_ended");
  level endon("pick_up_bunny_head");

  for(;;) {
    level waittill("magic_box_leaving", var_0);
    var_1 = var_0._id_6076;
    wait 1;
    var_2 = scripts\cp\utility::_id_E190("s4_zm_bunny_head", var_1.origin + (0, 0, -25), var_1.angles + (0, 90, 0));
    var_2._id_039B = "bunny_interact";
    var_2.b_head = 1;
    _id_C266("bunny_interact", ::bunny_interact_hint_func, ::on_bunny_interact, undefined, undefined, undefined, undefined, undefined, 100);
    _id_0737::addinteractionhinttypecallback("bunny_interact", ::bunny_interact_type);
    var_2 thread visible_for_player_listener(1);
    var_2 thread time_out_listener(6);
  }
}

time_out_listener(var_0) {
  level endon("game_ended");
  self endon("death");
  wait(var_0);

  foreach(var_2 in level.players) {
    if(isPlayer(var_2)) {
      if(check_visible(var_2)) {
        _func_019D(level._effect["evil_doll_explode"], self, "tag_origin", var_2);
      }
    }
  }

  if(isDefined(self.ent_sound_proxy)) {
    self.ent_sound_proxy _meth_83F8();
    self.ent_sound_proxy delete();
  }

  self delete();
}

bunny_interact_hint_func(var_0, var_1) {
  if(check_visible(var_1) && !isDefined(var_1 _meth_815A())) {
    if(istrue(var_0.b_torso)) {
      if(level scripts\engine\utility::_id_5C00("zipline_moving")) {
        return &"CP_SUMPF/PICK_UP_BUNNY";
      } else {
        return &"";
      }
    } else
      return &"CP_SUMPF/PICK_UP_BUNNY";
  } else
    return &"";
}

bunny_interact_type(var_0, var_1) {
  return "HINT_NOICON";
}

on_bunny_interact(var_0, var_1) {
  if(!check_visible(var_1) || isDefined(var_1 _meth_815A())) {
    return;
  }
  if(istrue(var_0.b_torso)) {
    if(!level scripts\engine\utility::_id_5C00("zipline_moving")) {
      return;
    }
  }

  scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_bunny_part_pickup");

  if(istrue(var_0.b_torso)) {
    level notify("pick_up_bunny_torso");
  }

  if(istrue(var_0.b_head)) {
    level notify("pick_up_bunny_head", var_0);
  }

  if(istrue(var_0.b_leg)) {
    level notify("pick_up_bunny_leg");
  }

  level.n_find_buny_part_count++;

  if(level.n_find_buny_part_count == 3) {
    level thread spawn_bunny_quest_reward(var_1);
    level thread spawn_loot_fountain(var_1);
  }

  _id_0737::_id_C3C5(var_0);
}

play_laugh_sound() {
  level endon("game_ended");
  self endon("death");
  self.ent_sound_proxy = scripts\cp\utility::_id_E190("tag_origin", self.origin, self.angles);
  self.ent_sound_proxy thread move_with_parent(self);
  self.ent_sound_proxy playLoopSound("zmb_bunny_amb_lp");
}

play_laugh_to_player_has_zombie_blood(var_0) {
  level endon("game_ended");
  self endon("death");
  self playsoundtoplayer("zmb_bunny_laugh", var_0);
}

move_with_parent(var_0) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self.origin = var_0.origin;
    wait 0.1;
  }
}

visible_for_player_listener(var_0) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    foreach(var_2 in level.players) {
      if(isPlayer(var_2)) {
        if(check_visible(var_2)) {
          self showtoplayer(var_2);
          scripts\cp\utility::_id_10839(5);

          if(!isPlayer(var_2)) {
            waitframe();
            continue;
          }

          if(!istrue(self.b_play_fx)) {
            if(istrue(var_0)) {
              thread play_laugh_to_player_has_zombie_blood(var_2);
            }

            _func_019D(level._effect["evil_doll_explode"], self, "tag_origin", var_2);
            _func_019D(level._effect["mq_mirror_part_ambient_fx"], self, "tag_origin", var_2);
            self playsoundtoplayer("zmb_bunny_spawn", var_2);
            self.b_play_fx = 1;
          }

          continue;
        }

        if(istrue(self.b_play_fx)) {
          _func_019D(level._effect["evil_doll_explode"], self, "tag_origin", var_2);
          _func_02D1(level._effect["mq_mirror_part_ambient_fx"], self, "tag_origin", var_2);
          self playsoundtoplayer("zmb_bunny_die", var_2);
          self.b_play_fx = 0;
        }

        self hidefromplayer(var_2);
      }
    }

    wait 0.1;
  }
}

check_visible(var_0) {
  return istrue(var_0.b_in_zombie_blood);
}

_id_C266(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  scripts\cp\utility::_id_459B(var_5, "duration_short");
  var_13 = spawnStruct();
  var_13._id_039B = var_0;
  var_13._id_7965 = var_1;
  var_13._id_E3FF = var_9;
  var_13._id_F8A0 = var_10;
  var_13._id_0F07 = var_2;
  var_13._id_523F = 1;
  var_13._id_4A9D = 1;
  var_13._id_3D91 = 0;
  var_13._id_C588 = var_11;
  var_13._id_7F8B = var_3;
  var_13._id_3108 = undefined;
  var_13._id_A53D = var_4;
  var_13._id_FE5D = var_5;
  var_13._id_8656 = var_6;
  var_13._id_796E = var_7;
  var_13.hinttype = undefined;
  var_13.hint_type_func = undefined;
  level._id_8393[var_0] = var_13;
  var_14 = getEntArray(var_0, "script_noteworthy");

  if(isDefined(var_8)) {
    level thread set_custom_search_distance_on_structs(var_14, var_8);
  }

  _id_0FE3(var_14);
}

_id_0FE3(var_0) {
  level._id_417B = scripts\engine\utility::array_combine(level._id_417B, var_0);
  level._id_417B = scripts\engine\utility::_id_1BC1(level._id_417B);
}

set_custom_search_distance_on_structs(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2]._id_425E = var_1;
  }
}

init_oil_lamps() {
  var_0 = scripts\engine\utility::getstructarray("s_lamp", "targetname");
  level.n_hit_index = 0;

  foreach(var_2 in var_0) {
    var_2.mdl = scripts\cp\utility::_id_E190("s4_zm_oil_lamp_01b_off", var_2.origin, var_2.angles);
  }

  if(!getdvarint("#x33ad41eaa5a9a3eec", 0)) {
    return;
  }
  foreach(var_2 in var_0) {
    var_2.mdl.parent = var_2;
    var_2.mdl setCanDamage(1);
    var_2.mdl thread take_damage_listener();
    var_2.n_index = int(var_2._id_039B);
  }

  level thread shot_oil_lamps_check(var_0);
}

take_damage_listener() {
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(scripts\engine\utility::_id_5C00("oil_lamps_in_cool_down")) {
      waitframe();
      continue;
    }

    var_10 = 0;

    if(var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_MELEE" || var_4 == "MOD_PROJECTILE") {
      scripts\cp\utility::_id_B8ED(self.origin, "zmb_lantern_break");

      if(isDefined(self.parent.n_index) && level.n_hit_index == self.parent.n_index) {
        playFX(level._effect["vfx_lantern_flash"], self.origin);
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

      level notify("hit_oil_lamp", var_10);
    }
  }
}

shot_oil_lamps_check(var_0) {
  level endon("game_ended");
  var_1 = 0;

  for(;;) {
    level waittill("hit_oil_lamp", var_2);

    if(istrue(var_2)) {
      if(!istrue(var_1)) {
        level thread shot_oil_lamps_time_out();
        var_1 = 1;
      }

      level.n_hit_index++;
    } else {
      level notify("kill_rampage_quest_timer");
      var_1 = 0;
      level.n_hit_index = 0;
      level scripts\engine\utility::_id_5C1B("oil_lamps_in_cool_down");
      wait 30;
      level scripts\engine\utility::_id_5C04("oil_lamps_in_cool_down");
    }

    if(level.n_hit_index == var_0.size) {
      level notify("kill_rampage_quest_timer");
      level thread scripts\cp\zombies\zm_round_accelerant::init_round_accelerant();

      foreach(var_4 in level.players) {
        if(isPlayer(var_4)) {
          level thread scripts\cp\utility::_id_B8F4("zmb_sam_success", var_4);
        }
      }

      break;
    }

    wait 0.5;
  }
}

shot_oil_lamps_time_out() {
  level endon("game_ended");
  level endon("kill_rampage_quest_timer");
  wait 15;
  level.n_hit_index = 0;
}