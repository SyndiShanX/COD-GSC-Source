/************************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_shooting_gallery.gsc
************************************************************************/

init() {
  init_shooting_gallery_data();

  if(!getdvarint("#x3a165e78de6483fc8", 0)) {
    return;
  }
  if(!getdvarint("#x32fd162d27e49cb6", 0)) {
    return;
  }
  level._effect["flash_fx"] = loadfx("vfx/s4/zombie_ai/vfx_zai_portal_spawn_ground.vfx");
  level._effect["zombie_head_despawn"] = loadfx("vfx/s4/zombie/vfx_shooting_gallery_despawn.vfx");
  level._effect["zombie_head_trail"] = loadfx("vfx/s4/zombie/vfx_shooting_gallery_trail.vfx");
  level._effect["zombie_head_spawn"] = loadfx("vfx/s4/zombie/vfx_shooting_gallery_spawn.vfx");
  _id_06CB::_id_AA49(::on_zombie_damage);
  _id_06CB::_id_AA4A(::_id_AA6D);
  scripts\engine\utility::_id_5C24("introscreen_over");
  level thread start_peeking_zombie_listener();
}

start_peeking_zombie_listener() {
  level endon("game_ended");
  var_0 = level._id_11049 + randomintrange(5, 7);
  level.a_s_peeking_zombies = scripts\engine\utility::array_randomize(level.a_s_peeking_zombies);

  for(;;) {
    level waittill("round_complete");
    var_1 = 1;

    foreach(var_3 in level.a_s_peeking_zombies) {
      if(!istrue(var_3.b_finished)) {
        var_1 = 0;
        break;
      }
    }

    if(var_1) {
      break;
    }

    if(level._id_11049 >= var_0) {
      level thread init_peeking_zombie();
      level waittill("complete_shooting_gallery", var_5);

      if(scripts\engine\utility::_id_5C0C("shooting_gallery_begin")) {
        level scripts\engine\utility::_id_5C04("shooting_gallery_begin");
      }

      if(!isDefined(var_5)) {
        var_0 = level._id_11049 + 1;
      } else {
        var_0 = level._id_11049 + randomintrange(5, 7);
      }
    }
  }
}

init_shooting_gallery_data() {
  level.a_s_peeking_zombies = scripts\engine\utility::getstructarray("s_peeking_zombie", "targetname");

  if(_func_0107(level.a_s_peeking_zombies)) {
    foreach(var_1 in level.a_s_peeking_zombies) {
      var_2 = scripts\engine\utility::getstructarray(var_1.target, "targetname");

      if(_func_0107(var_2)) {
        foreach(var_4 in var_2) {
          if(isDefined(var_4._id_039B)) {
            if(var_4._id_039B == "zombie_head") {
              var_1.s_zombie_head = var_4;
            }

            if(var_4._id_039B == "blocker") {
              var_1.s_blocker = var_4;
            }

            if(var_4._id_039B == "teleport_pos") {
              var_1.s_teleport_pos = var_4;
            }

            if(var_4._id_039B == "chest_pos") {
              var_1.s_chest_pos = var_4;
            }
          }
        }
      }
    }
  }
}

init_peeking_zombie(var_0) {
  level endon("game_ended");
  level endon("complete_shooting_gallery");
  var_1 = undefined;

  foreach(var_3 in level.a_s_peeking_zombies) {
    if(isDefined(var_0)) {
      if(isDefined(var_3._id_039B) && var_3._id_039B == var_0) {
        var_1 = var_3;
        break;
      }
    } else if(isDefined(var_3._id_039B) && !istrue(var_3.b_finished)) {
      var_1 = var_3;
      break;
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  playFX(level._effect["flash_fx"], var_1.origin);
  var_1._id_122C = _id_09A4::_id_110AD("enemy_base_zombie_cp", var_1.origin, var_1.angles - (0, 90, 0), var_1);

  if(isDefined(var_1._id_122C)) {
    var_1._id_122C[[var_1._id_122C.try_do_scripted_anim]]("animscripted", "peek", 1);
    var_1._id_122C._id_0229 = 1;
    var_1._id_122C._id_CF4A = 1;
    var_1._id_122C._id_0043 = 0;
    var_1._id_122C.b_peeking_zombie = 1;
    var_1._id_122C.ignore_enemy_count = 1;
    var_1._id_122C.b_ignore_cleanup = 1;
    var_1._id_122C.lightning_chain_immune = 1;
    var_1._id_122C.disable_ui_target = 1;
    var_1._id_122C._id_7D0A = 1;
    var_1._id_122C.b_not_kill = 1;
  }

  var_1 thread players_get_close_listener();
  level waittill("hit_peeking_zombie", var_5, var_6);

  if(!isweapon(var_6) || !isDefined(var_5)) {
    if(isDefined(var_1._id_122C)) {
      var_1._id_122C _meth_81FA();
    }

    return;
  }

  var_1 kill_peeking_zombie();
  var_7 = 0;

  switch (var_1._id_039B) {
    case "flash_shooting_gallery":
      if(var_6.classname == "spread") {
        var_7 = 1;
        var_1.need_weapon_type = "spread";
      }

      break;
    case "split_shooting_gallery":
      if(var_6.classname == "smg") {
        var_7 = 1;
        var_1.need_weapon_type = "smg";
      }

      break;
    case "flying_shooting_gallery":
      if(var_6.classname == "rifle") {
        var_7 = 1;
        var_1.need_weapon_type = "rifle";
      }

      break;
  }

  if(!var_7) {
    foreach(var_5 in level.players) {
      if(isPlayer(var_5)) {
        level thread scripts\cp\utility::_id_B8F4("zmb_shooting_gallery_fail", var_5);
      }
    }

    level notify("complete_shooting_gallery");
    return;
  }

  if(isPlayer(var_5)) {
    scripts\cp\utility::_id_B8F4("ui_hitmarker_kill_headshot_metal", var_5);
  }

  level notify("shooting_gallery_start");
  level.disable_portal = 1;
  var_1.joined_players = [];
  var_1.joined_players = scripts\engine\utility::array_add(var_1.joined_players, var_5);
  var_1 thread spawn_barricades();

  if(!isDefined(var_1._id_039B)) {
    return;
  }
  var_10 = scripts\engine\utility::getstructarray(var_1.s_teleport_pos.target, "targetname");
  teleport_player_join(var_10, var_5);

  if(scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    var_1 cleanup_barricades();
    return;
  }

  switch (var_1._id_039B) {
    case "flash_shooting_gallery":
      var_1 start_flash_shooting_gallery();
      break;
    case "split_shooting_gallery":
      var_1 start_split_shooting_gallery();
      break;
    case "flying_shooting_gallery":
      var_1 start_flying_shooting_gallery();
      break;
    default:
      var_1 start_split_shooting_gallery();
      break;
  }

  var_1 thread complete_shooting_gallery();
  var_1 thread exit_shooting_gallery_monitor();
}

players_get_close_listener() {
  level endon("game_ended");
  level endon("shooting_gallery_start");

  switch (self._id_039B) {
    case "flash_shooting_gallery":
      var_0 = 700;
      break;
    case "split_shooting_gallery":
      var_0 = 700;
      break;
    case "flying_shooting_gallery":
      var_0 = 1300;
      break;
    default:
      var_0 = 700;
      break;
  }

  for(;;) {
    foreach(var_2 in level.players) {
      var_3 = distancesquared(self.origin, var_2.origin);

      if(var_3 <= _func_0219(var_0)) {
        level notify("complete_shooting_gallery");
        kill_peeking_zombie();
        return;
      }
    }

    wait 1;
  }
}

exit_shooting_gallery_monitor() {
  level endon("game_ended");
  level endon("complete_shooting_gallery");
  wait 2;

  for(;;) {
    if(scripts\engine\utility::_id_5C00("start_rbz_exfil") || scripts\engine\utility::_id_5C00("disallow_rbz_exfil")) {
      if(isDefined(self)) {
        thread cleanup_timer_hud();
      }

      level notify("complete_shooting_gallery", 0);
    }

    wait 1;
  }
}

kill_peeking_zombie() {
  playFX(level._effect["flash_fx"], self.origin);

  if(isDefined(self._id_122C)) {
    self._id_122C setorigin((0, 0, 0));
    self._id_122C _meth_81FA();
  }
}

spawn_barricades() {
  level endon("game_ended");
  self.s_blocker.mdl_block = scripts\cp\utility::_id_E190("s4_zm_rune_decal_inviktor_barrier", self.s_blocker.origin, self.s_blocker.angles);
  scripts\cp\utility::_id_B8ED(self.s_blocker.origin, "zmb_wicker_fence_flames");
  self.s_blocker.mdl_block playLoopSound("zmb_kortifex_wall_lp");
  var_0 = scripts\engine\utility::getstructarray(self.s_blocker.target, "targetname");

  foreach(var_2 in var_0) {
    var_2.mdl = spawn("script_model", var_2.origin);
    var_2.mdl.angles = var_2.angles;
    var_2.mdl setModel("vfx_zm_obj_holdout_barrier_mod_bottom_center_56x48");
  }
}

cleanup_barricades() {
  scripts\cp\utility::_id_B8ED(self.s_blocker.origin, "zmb_wicker_dissolve");

  if(isDefined(self.s_blocker.mdl_block)) {
    self.s_blocker.mdl_block delete();
  }

  var_0 = scripts\engine\utility::getstructarray(self.s_blocker.target, "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.mdl)) {
      var_2.mdl delete();
    }
  }
}

on_zombie_damage(var_0) {
  if(!istrue(self.b_peeking_zombie)) {
    return;
  }
  if(!isDefined(var_0._id_04F6) || !isDefined(var_0._id_50FF)) {
    return;
  }
  if(isDefined(var_0._id_50FF)) {
    if(istrue(var_0._id_50FF.is_in_teleport)) {
      return;
    }
  }

  level notify("hit_peeking_zombie", var_0._id_50FF, var_0._id_04F6);
  level scripts\engine\utility::_id_5C1B("shooting_gallery_begin");
}

_id_AA6D(var_0) {
  if(!istrue(self.b_peeking_zombie)) {
    return;
  }
  if(!scripts\engine\utility::_id_5C00("shooting_gallery_begin")) {
    if(isDefined(self)) {
      thread cleanup_timer_hud();
    }

    wait 2;
    level notify("complete_shooting_gallery");
  }
}

start_split_shooting_gallery() {
  level endon("game_ended");
  self._id_9C21 = 100;
  self.base_health = self._id_9C21;
  self.health = self._id_9C21;
  self.red_orb_rate = 0;
  self.limit_time = 50;
  self.orb_piece_health = 10;
  self.n_max_spawn_count = 3;
  self.orb_pieces = [];
  self.orb_pieces_order_array = [];
  self.red_orb_count = 0;
  self.spawn_orb_rate = 15;
  self.b_can_join = 1;
  self.orb_pieces_order_array = generate_random_orb_array(self._id_9C21, self);

  if(!isDefined(self.orb_pieces_order_array)) {
    return;
  }
  playFX(level._effect["zombie_head_spawn"], self.s_zombie_head.origin, anglesToForward(self.s_zombie_head.angles), anglestoup(self.s_zombie_head.angles));
  wait 2.5;
  thread game_over_timer();
  thread health_listener();
  thread can_join_timer();
  self.zombie_head = _func_03C5("s4_zm_oasis_zombie_head", self.s_zombie_head.origin, self.s_zombie_head.angles);
  self.zombie_head setscriptablepartstate("zombie_head_fx", "off");
  self.zombie_head.parent = self;
  self.moving_proxy = scripts\cp\utility::_id_E190("tag_origin", self.s_zombie_head.origin, self.s_zombie_head.angles);
  scripts\cp\utility::_id_B8ED(self.moving_proxy.origin, "zmb_orb_spawn");
  self.mdl_head = scripts\cp\utility::_id_E190("s4_zm_oasis_orb_follow_01", self.s_zombie_head.origin, self.s_zombie_head.angles);
  self.mdl_head _meth_82CB("s4_zm_orb_follow_anim");
  self.mdl_head setCanDamage(1);
  self.mdl_head thread head_damage_listener();
  self.mdl_head linkto(self.moving_proxy);
  playFXOnTag(level._effect["zombie_head_trail"], self.moving_proxy, "tag_origin");
  self.zombie_head _meth_8746(self.moving_proxy);
  thread look_at_players();
  wait 1;

  if(isDefined(self)) {
    self.moving_proxy playLoopSound("zmb_orb_sg_lp");
  }
}

split_orb_piece_think(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level endon("complete_shooting_gallery");
  self endon("death");
  self.orb_array = [];
  var_2 = scripts\cp\utility::_id_459B(var_2, 0);
  var_3 = scripts\cp\utility::_id_459B(var_3, 0);

  if(var_2) {
    wait 5;
  }

  for(;;) {
    if(var_3) {
      var_4 = randomintrange(1, var_1);
    } else {
      var_4 = var_1;
    }

    self.orb_array = generate_random_orb_array(var_4, self.parent);

    if(!isDefined(self.orb_array)) {
      return;
    }
    self.parent.orb_pieces_order_array = scripts\engine\utility::array_combine(self.parent.orb_pieces_order_array, self.orb_array);

    for(var_5 = 0; var_5 < var_4; var_5++) {
      thread spawn_orb_piece(self.orb_array[var_5]);
      var_6 = randomfloatrange(0.5, 1.5);
      wait(var_6);
    }

    var_7 = randomintrange(3, 5);
    wait(var_7);
  }
}

generate_random_orb_array(var_0, var_1) {
  level endon("game_ended");

  if(var_1._id_039B == "flying_shooting_gallery") {
    var_2 = [];

    for(var_3 = 0; var_3 < var_0; var_3++) {
      var_4 = randomintrange(0, 100);

      if(var_4 < var_1.red_orb_rate) {
        var_5 = 1;
        var_1.red_orb_count++;
      } else
        var_5 = 2;

      var_2[var_3] = var_5;
    }

    var_2 = scripts\engine\utility::array_randomize(var_2);
    return var_2;
  } else if(var_1._id_039B == "split_shooting_gallery") {
    var_2 = [];

    for(var_3 = 0; var_3 < var_0; var_3++) {
      var_6 = randomintrange(0, 100);

      if(var_6 < var_1.spawn_orb_rate) {
        var_4 = randomintrange(0, 100);

        if(var_4 < var_1.red_orb_rate) {
          var_5 = 1;
          var_1.red_orb_count++;
        } else
          var_5 = 2;
      } else
        var_5 = 0;

      var_2[var_3] = var_5;
    }

    while(var_1.red_orb_count < 2) {
      if(var_1.red_orb_rate == 0) {
        break;
      }

      foreach(var_8 in var_2) {
        if(var_8 == 2) {
          var_8 = 1;
          var_1.red_orb_count++;
        }
      }
    }

    var_2 = scripts\engine\utility::array_randomize(var_2);
    return var_2;
  } else
    return undefined;
}

spawn_orb_piece(var_0) {
  level endon("game_ended");
  level endon("complete_shooting_gallery");

  if(var_0 == 0) {
    return;
  }
  var_1 = scripts\engine\utility::_id_C019(1);
  var_2 = self.origin + var_1 * 30;
  var_3 = self.origin + var_1 * 200;
  var_4 = scripts\cp\utility::_id_E190("tag_origin", var_2);
  scripts\cp\utility::_id_B8ED(var_2, "zmb_head_orb_pop_out");
  wait 0.5;
  var_4.orb_piece = _func_03C5("s4_zm_oasis_orb_piece", var_2);
  var_4.orb_piece _meth_8746(var_4);
  var_4.orb_piece.parent = var_4;
  var_4.orb_piece.zombie_head = self;
  var_4.damage_proxy = scripts\cp\utility::_id_E190("s4_zm_orb_ball_big", var_2);
  var_4.damage_proxy setCanDamage(1);
  var_4.damage_proxy linkto(var_4);
  var_4.damage_proxy.parent = var_4;
  var_4.damage_proxy thread orb_damage_listener(self);

  if(isDefined(var_4.orb_piece)) {
    self.parent.orb_pieces = scripts\engine\utility::array_add(self.parent.orb_pieces, var_4);
    var_4 playLoopSound("zmb_orb_sg_lp");
    var_5 = randomintrange(0, 100);

    if(var_0 == 1 && !check_has_player_travelling(self.parent)) {
      var_4.orb_piece setscriptablepartstate("orb_fx", "red");
      var_4.b_red = 1;
    } else if(var_0 == 2) {
      var_4.orb_piece setscriptablepartstate("orb_fx", "blue");
      var_4.b_red = 0;
    }

    var_4 thread _id_0402(var_3);
    var_4 thread get_hit_listener(self);
  }
}

orb_damage_listener(var_0) {
  level endon("game_enden");
  level endon("complete_shooting_gallery");

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isPlayer(var_2) && isDefined(var_0) && isDefined(var_0.parent) && isDefined(var_0.parent.need_weapon_type)) {
      if(var_0.parent.need_weapon_type == var_10.classname) {
        if(_func_0107(var_0.parent.joined_players)) {
          if(scripts\cp\utility::_id_88B7(var_0.parent.joined_players, var_2)) {
            level thread _id_072E::display_damage_number_internal(var_2, 0, var_1, self.origin);
            self.parent notify("hit_orb_piece");
          } else
            level thread _id_072E::display_damage_number_internal(var_2, 0, 0, self.origin);
        }

        continue;
      }

      level thread _id_072E::display_damage_number_internal(var_2, 0, 0, self.origin);
    }
  }
}

_id_0402(var_0) {
  level endon("game_enden");
  level endon("complete_shooting_gallery");
  self endon("death");
  self moveto(var_0, 10);
  thread flash_listener();
  self waittill("movedone");
  wait 3;

  if(istrue(self.b_red)) {
    self.orb_piece _meth_86BE();
    self.damage_proxy delete();
    self delete();
    return;
  }

  scripts\cp\utility::_id_B8ED(self.origin, "zmb_orb_finale");
  var_1 = 0;
  level notify("complete_shooting_gallery", var_1);
}

flash_listener() {
  level endon("game_enden");
  level endon("complete_shooting_gallery");
  self endon("death");
  wait 8;

  for(;;) {
    self.orb_piece setscriptablepartstate("orb_fx", "off");
    wait 0.1;

    if(istrue(self.b_red)) {
      self.orb_piece setscriptablepartstate("orb_fx", "red");
    } else {
      self.orb_piece setscriptablepartstate("orb_fx", "blue");
    }

    wait 0.5;
  }
}

get_hit_listener(var_0) {
  level endon("game_enden");
  level endon("complete_shooting_gallery");
  self endon("death");
  self waittill("hit_orb_piece");
  scripts\cp\utility::_id_B8ED(self.origin, "zmb_orb_finale");

  if(istrue(self.b_red)) {
    var_1 = 0;
    level notify("complete_shooting_gallery", var_1);
  }

  scripts\cp\utility::_id_10839(5);
  self.damage_proxy delete();
  self.orb_piece _meth_86BE();
  self delete();
}

health_listener() {
  level endon("game_ended");
  level endon("complete_shooting_gallery");

  if(_func_0107(self.joined_players) && isPlayer(self.joined_players[0])) {
    self.joined_players[0].health_bar = self.joined_players[0] scripts\cp\utility::_id_3F99((1, 1, 1), 100, 10);
    self.joined_players[0].health_bar scripts\cp\utility::setpoint("LEFT", undefined, 30, -30);
    self.joined_players[0].health_bar scripts\cp\utility::_id_FC11(self.health / self._id_9C21);
  }

  for(;;) {
    level waittill("hit_zombie_head", var_0, var_1, var_2, var_3, var_4);

    if(!scripts\cp\utility::_id_88B7(self.joined_players, var_1) && !istrue(self.b_can_join)) {
      level thread _id_072E::display_damage_number_internal(var_1, 0, 0, var_3 + (0, 0, 10));
      continue;
    }

    if(isDefined(self.need_weapon_type) && self.need_weapon_type == var_4.classname) {
      if(!isDefined(var_1.health_bar)) {
        var_1.health_bar = var_1 scripts\cp\utility::_id_3F99((1, 1, 1), 100, 10);
        var_1.health_bar scripts\cp\utility::setpoint("LEFT", undefined, 30, -30);
        var_1.health_bar scripts\cp\utility::_id_FC11(self.health / self._id_9C21);
      }

      if(self._id_039B == "flash_shooting_gallery") {
        if(istrue(var_2)) {
          var_5 = 0;
          level notify("complete_shooting_gallery", var_5);

          if(isDefined(self.red_sound_proxy)) {
            self.red_sound_proxy stoploopsound("zmb_orb_sg_red_head_lp");
          }

          break;
        }
      }

      if(!scripts\cp\utility::_id_88B7(self.joined_players, var_1) && istrue(self.b_can_join)) {
        self.joined_players = scripts\engine\utility::array_add(self.joined_players, var_1);
        var_6 = scripts\engine\utility::getstructarray(self.s_teleport_pos.target, "targetname");
        level thread teleport_player_join(var_6, var_1);
        self.limit_time = self.limit_time + 30;
        self notify("kill_timer");
        cleanup_timer_hud();
        thread game_over_timer();

        foreach(var_8 in self.joined_players) {
          if(isPlayer(var_8)) {
            if(!isDefined(var_8.health_bar)) {
              var_8.health_bar = var_8 scripts\cp\utility::_id_3F99((1, 1, 1), 100, 10);
              var_8.health_bar scripts\cp\utility::setpoint("LEFT", undefined, 30, -30);
              var_8.health_bar scripts\cp\utility::_id_FC11(self.health / self._id_9C21);
            }
          }
        }

        thread adjust_shooting_gallery_difficulty();
      }

      if(self.health > 0) {
        self.health = self.health - 1;
        level thread _id_072E::display_damage_number_internal(var_1, 0, var_0, var_3 + (0, 0, 10));

        if(self._id_039B == "split_shooting_gallery") {
          var_10 = int(self._id_9C21 - self.health);
          self.zombie_head thread spawn_orb_piece(self.orb_pieces_order_array[var_10 - 1]);
        }

        foreach(var_1 in self.joined_players) {
          if(isPlayer(var_1) && isDefined(var_1.health_bar)) {
            var_1.health_bar scripts\cp\utility::_id_FC11(self.health / self._id_9C21);
          }
        }
      } else {
        var_5 = 1;
        level notify("complete_shooting_gallery", var_5);
        break;
      }

      continue;
    }

    level thread _id_072E::display_damage_number_internal(var_1, 0, 0, var_3 + (0, 0, 10));
  }
}

teleport_player_join(var_0, var_1) {
  level endon("game_ended");
  var_1.in_sg_teleport = 1;
  _id_098A::warp_sepcific_player(var_0, var_1);
  var_1.in_sg_teleport = 0;
  var_1 scripts\cp\utility::_id_1566(1);
}

adjust_shooting_gallery_difficulty() {
  if(!isint(self.joined_players.size)) {
    return;
  }
  var_0 = 1;

  switch (self.joined_players.size) {
    case 2:
      var_0 = 1.3;

      if(isDefined(self._id_039B) && self._id_039B == "split_shooting_gallery") {
        self.red_orb_rate = 15;
        self.spawn_orb_rate = 20;
      }

      if(isDefined(self._id_039B) && self._id_039B == "flash_shooting_gallery") {
        self.turn_red_rate = 20;
        self.flash_interval = 3.5;
      }

      if(isDefined(self._id_039B) && self._id_039B == "flying_shooting_gallery") {
        self.red_orb_rate = 20;
        self.n_max_spawn_count = 5;
        self.fly_speed = 30;
      }

      break;
    case 3:
      var_0 = 1.7;

      if(isDefined(self._id_039B) && self._id_039B == "split_shooting_gallery") {
        self.red_orb_rate = 20;
        self.spawn_orb_rate = 20;
      }

      if(isDefined(self._id_039B) && self._id_039B == "flash_shooting_gallery") {
        self.turn_red_rate = 25;
        self.flash_interval = 2.8;
      }

      if(isDefined(self._id_039B) && self._id_039B == "flying_shooting_gallery") {
        self.red_orb_rate = 25;
        self.n_max_spawn_count = 5;
        self.fly_speed = 30;
      }

      break;
    case 4:
      var_0 = 2.2;

      if(isDefined(self._id_039B) && self._id_039B == "split_shooting_gallery") {
        self.red_orb_rate = 30;
        self.spawn_orb_rate = 25;
      }

      if(isDefined(self._id_039B) && self._id_039B == "flash_shooting_gallery") {
        self.turn_red_rate = 35;
        self.flash_interval = 2.0;
      }

      if(isDefined(self._id_039B) && self._id_039B == "flying_shooting_gallery") {
        self.red_orb_rate = 35;
        self.n_max_spawn_count = 7;
        self.fly_speed = 40;
      }

      break;
    default:
      var_0 = 1;
      break;
  }

  var_1 = clamp(self.health / self._id_9C21, 0, 1);
  self._id_9C21 = self.base_health * var_0;
  self.health = int(self._id_9C21 * var_1);

  if(isDefined(self._id_039B) && self._id_039B == "split_shooting_gallery") {
    self.orb_pieces_order_array = generate_random_orb_array(self._id_9C21, self);

    if(!isDefined(self.orb_pieces_order_array)) {
      return;
    }
  }
}

game_over_timer(var_0) {
  level endon("game_enden");
  self endon("kill_timer");
  level endon("complete_shooting_gallery");
  _id_3F28(self.limit_time);

  while(self.limit_time > 0) {
    wait 1;
    self.limit_time = self.limit_time - 1;

    if(self._id_039B == "flash_shooting_gallery" && self.limit_time <= 15) {
      level notify("kill_red_cool_down_timer");
      self.b_red_in_cool_down = 1;
    }
  }

  cleanup_timer_hud();
  var_1 = 0;
  level notify("complete_shooting_gallery", var_1);
}

can_join_timer() {
  level endon("game_ended");
  level endon("complete_shooting_gallery");
  wait 30;
  self.b_can_join = 0;
}

_id_F487(var_0) {
  self fadeovertime(var_0);

  if(isDefined(self._id_9C52)) {
    self.alpha = self._id_9C52;
  } else {
    self.alpha = 1;
  }
}

_id_3F28(var_0) {
  foreach(var_2 in self.joined_players) {
    if(isPlayer(var_2) && !isDefined(var_2.shooting_gallery_timer)) {
      var_2.shooting_gallery_timer = var_2 createtimer1("default", 2);
      var_2.shooting_gallery_timer scripts\cp\utility::setpoint("LEFT", undefined, 30, -50);
      var_2.shooting_gallery_timer.color = (1, 1, 1);
      var_2.shooting_gallery_timer.archived = 0;
      var_2.shooting_gallery_timer._id_01D6 = 1;
      var_2.shooting_gallery_timer_hint = var_2 scripts\cp\utility::createfontstring("default", 1.5);
      var_2.shooting_gallery_timer_hint scripts\cp\utility::setpoint("LEFT", undefined, 30, -70);
      var_2.shooting_gallery_timer_hint.color = (1, 1, 1);
      var_2.shooting_gallery_timer_hint settext(&"CP_ZM_OASIS/SHOOTING_GALLERY");
      var_2.shooting_gallery_timer_hint.alpha = 1;
      var_2.shooting_gallery_timer _id_F487(1);
      var_2.shooting_gallery_timer _meth_8391(var_0);
    }
  }
}

createtimer1(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "timer";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2._id_22B8 = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 scripts\cp\utility::setparent(level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

cleanup_timer_hud() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.shooting_gallery_timer_hint)) {
      var_1.shooting_gallery_timer_hint destroy();
    }

    if(isDefined(var_1.shooting_gallery_timer)) {
      var_1.shooting_gallery_timer destroy();
    }

    if(isDefined(var_1.health_bar)) {
      var_1.health_bar scripts\cp\utility::destroyelem();
    }
  }
}

complete_shooting_gallery() {
  level endon("game_ended");
  level waittill("complete_shooting_gallery", var_0);
  level.disable_portal = undefined;

  if(!isDefined(var_0)) {
    return;
  }
  cleanup_timer_hud();
  self.b_finished = 1;
  thread cleanup_barricades();

  if(_func_0107(self.joined_players)) {
    foreach(var_2 in self.joined_players) {
      if(isPlayer(var_2)) {
        var_2 thread reset_ignore_after_complete();
      }
    }
  }

  if(_func_0107(self.orb_pieces)) {
    foreach(var_5 in self.orb_pieces) {
      if(isDefined(var_5.orb_piece)) {
        var_5.orb_piece _meth_86BE();
      }

      if(isDefined(var_5.damage_proxy)) {
        var_5.damage_proxy delete();
      }

      if(isDefined(var_5)) {
        var_5 delete();
      }
    }
  }

  wait 1;

  if(istrue(var_0)) {
    self.moving_proxy rotateto(vectortoangles(self.s_chest_pos.origin - self.moving_proxy.origin), 1);
    self.mdl_head notsolid();
    self.moving_proxy moveto(self.s_chest_pos.origin, 5);

    foreach(var_2 in level.players) {
      if(isPlayer(var_2)) {
        level thread scripts\cp\utility::_id_B8F4("zmb_shooting_gallery_success", var_2);
      }
    }

    self.moving_proxy waittill("movedone");
    playFX(level._effect["zombie_head_despawn"], self.moving_proxy.origin, anglesToForward(self.moving_proxy.angles), anglestoup(self.moving_proxy.angles));
    scripts\cp\utility::_id_B8ED(self.moving_proxy.origin, "zmb_orb_finale");
    level thread spawn_golden_chest(self.s_chest_pos.origin, self.s_chest_pos.angles);

    if(isDefined(self.mdl_head)) {
      self.mdl_head unlink();
      self.mdl_head delete();
    }

    if(isDefined(self.zombie_head)) {
      self.zombie_head _meth_86BE();
    }

    if(isDefined(self.moving_proxy)) {
      self.moving_proxy delete();
    }
  } else {
    playFX(level._effect["zombie_head_despawn"], self.moving_proxy.origin, anglesToForward(self.moving_proxy.angles), anglestoup(self.moving_proxy.angles));

    foreach(var_2 in level.players) {
      if(isPlayer(var_2)) {
        level thread scripts\cp\utility::_id_B8F4("zmb_shooting_gallery_fail", var_2);
      }
    }

    if(isDefined(self.mdl_head)) {
      self.mdl_head unlink();
      self.mdl_head delete();
    }

    if(isDefined(self.zombie_head)) {
      self.zombie_head _meth_86BE();
    }

    if(isDefined(self.moving_proxy)) {
      self.moving_proxy delete();
    }
  }

  if(istrue(var_0)) {
    for(var_11 = 0; var_11 <= 5; var_11++) {
      var_12 = self.s_chest_pos.origin + (var_11 * 25, 0, 0);

      if(var_11 == 5) {
        _id_0990::_id_E3DD("full_ammo", var_12);
        continue;
      }

      _id_0990::_id_E3DD("bonus_points_team", var_12);
    }
  } else {
    var_12 = _func_02A9(self.s_chest_pos.origin, 50);
    _id_0990::_id_E3DD("full_ammo", var_12);
  }

  level scripts\engine\utility::_id_5C04("shooting_gallery_begin");
}

reset_ignore_after_complete() {
  level endon("game_ended");

  for(;;) {
    if(!istrue(self.in_sg_teleport)) {
      scripts\cp\utility::_id_1566(0);
      break;
    }

    wait 1;
  }
}

start_flash_shooting_gallery() {
  level endon("game_ended");
  self._id_9C21 = 30;
  self.base_health = self._id_9C21;
  self.health = self._id_9C21;
  self.limit_time = 50;
  self.flash_interval = 4;
  self.red_flash_interval = 2;
  self.turn_red_rate = 15;
  self.b_can_join = 1;
  self.b_red_in_cool_down = 0;
  playFX(level._effect["zombie_head_spawn"], self.s_zombie_head.origin, anglesToForward(self.s_zombie_head.angles), anglestoup(self.s_zombie_head.angles));
  wait 2.5;
  thread game_over_timer();
  thread health_listener();
  thread can_join_timer();
  self.zombie_head = _func_03C5("s4_zm_oasis_zombie_head", self.s_zombie_head.origin, self.s_zombie_head.angles);
  self.zombie_head setscriptablepartstate("zombie_head_fx", "off");
  self.zombie_head.parent = self;
  self.moving_proxy = scripts\cp\utility::_id_E190("tag_origin", self.s_zombie_head.origin, self.s_zombie_head.angles);
  self.red_sound_proxy = scripts\cp\utility::_id_E190("tag_origin", self.s_zombie_head.origin, self.s_zombie_head.angles);
  self.mdl_head = scripts\cp\utility::_id_E190("s4_zm_oasis_orb_follow_01", self.s_zombie_head.origin, self.s_zombie_head.angles);
  self.mdl_head _meth_82CB("s4_zm_orb_follow_anim");
  self.mdl_head setCanDamage(1);
  self.mdl_head thread head_damage_listener();
  self.mdl_head linkto(self.moving_proxy);
  self.zombie_head _meth_8746(self.moving_proxy);
  thread look_at_players();
  scripts\cp\utility::_id_B8ED(self.origin, "zmb_orb_spawn");
  wait 0.5;
  self.moving_proxy playLoopSound("zmb_orb_sg_lp");
  wait 2.5;
  thread flash_zombie_head();
}

look_at_players() {
  level endon("game_ended");
  level endon("complete_shooting_gallery");
  var_0 = undefined;

  for(;;) {
    if(!isDefined(var_0)) {
      foreach(var_2 in self.joined_players) {
        if(isalive(var_2)) {
          var_0 = var_2;
          break;
        }
      }
    }

    if(!isalive(var_0)) {
      foreach(var_2 in self.joined_players) {
        if(isalive(var_2)) {
          var_0 = var_2;
          break;
        }
      }
    }

    var_6 = var_0.origin - self.moving_proxy.origin;
    self.moving_proxy.angles = vectortoangles(var_6);
    waitframe();
  }
}

flash_zombie_head() {
  level endon("game_ended");
  level endon("complete_shooting_gallery");
  var_0 = scripts\engine\utility::getstructarray(self.s_zombie_head.target, "targetname");

  for(;;) {
    var_0 = scripts\engine\utility::array_randomize(var_0);

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = check_has_player_travelling(self);

      if(isDefined(self.moving_proxy)) {
        playFXOnTag(level._effect["flash_fx"], self.moving_proxy, "tag_origin");
        scripts\cp\utility::_id_B8ED(self.moving_proxy.origin, "zmb_head_warp_flash");
        self.zombie_head setscriptablepartstate("zombie_head_fx", "off_fx");
        self.mdl_head hide();
        wait 1;
        self.moving_proxy.origin = var_0[var_1].origin;
        wait 1;
        self.mdl_head show();
        playFXOnTag(level._effect["flash_fx"], self.moving_proxy, "tag_origin");
        scripts\cp\utility::_id_B8ED(self.moving_proxy.origin, "zmb_head_warp_flash");
      }

      var_3 = randomintrange(0, 100);

      if(var_3 <= self.turn_red_rate && !var_2 && !istrue(self.b_red_in_cool_down)) {
        self.b_red_in_cool_down = 1;
        self.zombie_head setscriptablepartstate("zombie_head_fx", "red");
        self.red_sound_proxy playLoopSound("zmb_orb_sg_red_head_lp");
        self.mdl_head.b_red = 1;
        thread be_red_cool_down_timer();
      } else {
        self.zombie_head setscriptablepartstate("zombie_head_fx", "off");
        self.red_sound_proxy stoploopsound("zmb_orb_sg_red_head_lp");
        self.mdl_head.b_red = 0;
      }

      if(istrue(self.mdl_head.b_red)) {
        wait(self.red_flash_interval);
        continue;
      }

      wait(self.flash_interval);
    }
  }
}

be_red_cool_down_timer() {
  level endon("game_ended");
  self endon("death");
  level endon("kill_red_cool_down_timer");
  wait 10;
  self.b_red_in_cool_down = 0;
}

start_flying_shooting_gallery() {
  level endon("game_ended");
  self._id_9C21 = 90;
  self.base_health = self._id_9C21;
  self.health = self._id_9C21;
  self.red_orb_rate = 15;
  self.limit_time = 50;
  self.n_max_spawn_count = 3;
  self.orb_pieces = [];
  self.orb_pieces_order_array = [];
  self.red_orb_count = 0;
  self.fly_speed = 20;
  self.b_can_join = 1;
  playFX(level._effect["zombie_head_spawn"], self.s_zombie_head.origin, anglesToForward(self.s_zombie_head.angles), anglestoup(self.s_zombie_head.angles));
  wait 2.5;
  thread game_over_timer();
  thread health_listener();
  thread can_join_timer();
  self.zombie_head = _func_03C5("s4_zm_oasis_zombie_head", self.s_zombie_head.origin, self.s_zombie_head.angles);
  self.zombie_head setscriptablepartstate("zombie_head_fx", "off");
  self.zombie_head.parent = self;
  self.moving_proxy = scripts\cp\utility::_id_E190("tag_origin", self.s_zombie_head.origin, self.s_zombie_head.angles);
  scripts\cp\utility::_id_B8ED(self.moving_proxy.origin, "zmb_orb_spawn");
  self.mdl_head = scripts\cp\utility::_id_E190("s4_zm_oasis_orb_follow_01", self.s_zombie_head.origin, self.s_zombie_head.angles);
  self.mdl_head _meth_82CB("s4_zm_orb_follow_anim");
  self.mdl_head setCanDamage(1);
  self.mdl_head thread head_damage_listener();
  self.mdl_head linkto(self.moving_proxy);
  self.zombie_head _meth_8746(self.moving_proxy);
  thread start_fly();
  self.zombie_head thread split_orb_piece_think(self.red_orb_rate, self.n_max_spawn_count, 1, 1);
}

head_damage_listener() {
  level endon("game_ended");
  level endon("complete_shooting_gallery");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isPlayer(var_1)) {
      continue;
    }
    var_10 = 0;

    if(isDefined(self)) {
      if(isDefined(self.b_red)) {
        if(istrue(self.b_red)) {
          var_10 = 1;
        }
      }
    }

    level notify("hit_zombie_head", var_0, var_1, var_10, var_3, var_9);
    scripts\cp\utility::_id_B8ED(self.origin, "zmb_wpn_melee_flesh_sweet_npc");
  }
}

start_fly() {
  level endon("game_ended");
  level endon("complete_shooting_gallery");
  scripts\cp\utility::_id_B8ED(self.origin, "zmb_orb_sg_moving_start");
  wait 0.5;
  self.moving_proxy playLoopSound("zmb_orb_sg_moving_lp");
  var_0 = scripts\engine\utility::getstructarray(self.s_zombie_head.target, "targetname");

  for(;;) {
    var_0 = scripts\engine\utility::array_randomize(var_0);

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = distance(self.moving_proxy.origin, var_0[var_1].origin);
      var_3 = var_2 / self.fly_speed;

      if(var_3 <= 1) {
        var_3 = 1;
      }

      self.moving_proxy moveto(var_0[var_1].origin, var_3, 0.5, 0.5);
      var_4 = var_0[var_1].origin - self.moving_proxy.origin;
      self.moving_proxy rotateto(vectortoangles(var_4), 1);
      self.moving_proxy waittill("movedone");
      scripts\cp\utility::_id_B8ED(self.moving_proxy.origin, "zmb_orb_sg_moving_stop");
      self.moving_proxy rotateto(vectortoangles(self.s_chest_pos.origin - self.moving_proxy.origin), 1);
    }
  }
}

spawn_golden_chest(var_0, var_1) {
  var_2 = _func_03C5("s4_zm_loot_chest", var_0, var_1);
  var_2 setscriptablepartstate("zm_loot_chest", "closed");
  var_2 setscriptablepartstate("fx", "closed");
  var_2.objectiveiconlocation = spawn("script_model", var_2.origin);
  var_2.objectiveiconparams = spawnStruct();
  var_2.objectiveiconparams._id_E747 = "active";
  var_2.objectiveiconparams._id_96CF = var_2.objectiveiconlocation;
  var_2.objectiveiconparams._id_7C3B = "v_ui_icons_zombies_minimap_chest";
  var_2.objectiveiconparams.minimapiconsize = "icon_regular";
  var_2.objectiveiconparams.hideonminimapwhenclipped = 1;
  var_2.objectiveiconparams.setbackground = 1;
  var_2.override_round_reward = 8;
  var_2.markerlabel = "chest_poi";
  var_2.instanceindex = _id_0987::add_instanced_objective_marker(var_2.markerlabel, var_2.objectiveiconparams);
  var_2 thread chest_life_watcher();
}

chest_life_watcher() {
  level endon("end_game");
  level endon("game_ended");
  self endon("death");
  wait 30;
  _id_0987::remove_instanced_objective_marker(self.markerlabel, self.instanceindex);
  self _meth_86BE();
}

check_has_player_travelling(var_0) {
  foreach(var_2 in var_0.joined_players) {
    if(istrue(var_2._id_2031)) {
      return 1;
    }
  }

  return 0;
}