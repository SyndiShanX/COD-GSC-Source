/*****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_harmonic_kinetic_accelerator.gsc
*****************************************************************************/

init() {
  common_scripts\utility::flag_init("zmb_double_points_available");
  common_scripts\utility::_id_092C("dlc_zmb_dig02_sword_looping", "vfx/map/mp_zombie_dig02/dlc_zmb_dig02_sword_looping");
  common_scripts\utility::_id_092C("side_ee_reward_green", "vfx/zombie/prototype_fx/dlc4/side_ee_reward_green");
  common_scripts\utility::_id_092C("side_ee_reward_cyan", "vfx/zombie/prototype_fx/dlc4/side_ee_reward_cyan");
  common_scripts\utility::_id_092C("side_ee_reward_magenta", "vfx/zombie/prototype_fx/dlc4/side_ee_reward_magenta");
  level.zmb_side_ee_colors = ["side_ee_reward_green", "side_ee_reward_cyan", "side_ee_reward_magenta"];
  level thread run_troubled_double_points();
  level thread maps\mp\_utility::_id_6F74(::rungenerator_jump);
}

rungenerator_jump() {
  var_0 = self;
  var_0 endon("disconnect");
  var_1 = common_scripts\utility::_id_46B7("generator_path_ends", "targetname");
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("quest_deathraven", "quest_deathraven_survive_rush"));

  for(;;) {
    waitframe();

    if(!var_0 _meth_82E5()) {
      continue;
    }
    foreach(var_3 in var_1) {
      if(distance(var_0.origin, var_3.origin) < 65) {
        var_4 = level.oribital_rotator_2;

        if(issubstr(var_3._id_0165, "b")) {
          var_4 = level.oribital_rotator_1;
        }

        var_5 = level.oribital_rotator_1 common_scripts\utility::_id_8FFC();
        var_0 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_5);
        var_5 show();

        if(var_4 == level.oribital_rotator_2) {
          var_5 rotateYaw(-310, 1.7, 0, 0.8);
        } else {
          var_5 rotateYaw(310, 1.7, 0, 0.8);
        }

        var_0 setstance("crouch");
        var_0 setplayerangles(var_3.angles);
        var_0 playerlinktoabsolute(var_5);
        var_6 = common_scripts\utility::_id_0F93(var_1, var_3);
        var_0 disableweapons();
        var_0 childthread renable_weaps();
        wait 1.7;
        var_0 unlink();
        var_0 setstance("stand");
        var_5 delete();
        break;
      }
    }

    wait 1;
  }
}

renable_weaps() {
  var_0 = self;
  wait 1.2;
  var_0 enableweapons();
}

run_troubled_double_points(var_0) {
  common_scripts\utility::flag_init("troubled_double_points_0");
  common_scripts\utility::flag_init("troubled_double_points_1");
  common_scripts\utility::flag_init("troubled_double_points_2");
  var_1 = common_scripts\utility::_id_46B5("side_raven_ee", "targetname");
  var_2 = getEntArray(var_1.target, "targetname");
  common_scripts\utility::_id_0FB2(var_2, ::set_flag_on_damage);

  for(;;) {
    var_3 = 1;

    foreach(var_5 in var_2) {
      if(!common_scripts\utility::_id_562E(var_5._id_08A9)) {
        var_3 = 0;
        break;
      }
    }

    if(var_3) {
      break;
    }

    waitframe();
  }

  var_7 = common_scripts\utility::_id_46B5("troubled_double_points", "targetname");
  var_8 = common_scripts\utility::_id_46B7(var_7.target, "targetname");
  var_9 = var_7 common_scripts\utility::_id_8FFC();
  var_9.angles = (0, 30, 0);
  var_9 show();
  var_10 = ["troubled_double_points_spawn", "troubled_double_points_spawn_2", "troubled_double_points_spawn_3"];

  foreach(var_13, var_12 in var_10) {
    if(!common_scripts\utility::_id_3C77("troubled_double_points_" + var_13)) {
      var_9 childthread wait_for_grab("troubled_double_points_" + var_13);
      var_9 childthread move_around(common_scripts\utility::_id_46B7(var_12, "targetname"));
      common_scripts\utility::_id_3C9F("troubled_double_points_" + var_13);
    }

    if(isDefined(var_9.fx)) {
      var_9.fx delete();
    }

    var_9.origin = (0, 0, 0);
  }

  level thread maps\mp\gametypes\zombies::_id_08AA();
  var_14 = common_scripts\utility::_id_46B5("zmb_dlc4_size_ee_final", "targetname");
  var_15 = 0;

  while(!common_scripts\utility::_id_562E(var_15)) {
    var_15 = run_mini_game(var_14);

    if(common_scripts\utility::_id_562E(var_15)) {
      break;
    }
  }

  if(isDefined(var_9.fx)) {
    var_9.fx delete();
  }

  if(isDefined(var_9)) {
    var_9 delete();
  }
}

run_mini_game(var_0) {
  var_1 = common_scripts\utility::_id_46B7(var_0.target, "targetname");
  var_2 = var_1[0] common_scripts\utility::_id_8FFC();
  var_2 show();
  var_2._id_21F6 = [];
  var_2 thread rotate_target();
  var_2 set_orbiters(20);
  var_3 = var_2 run_game_sequence(var_1, var_0);
  var_4 = common_scripts\utility::_id_46B5("dlc4_ee_weap_reward", "targetname");
  var_5 = common_scripts\utility::_id_46B5(var_4.target, "targetname");

  foreach(var_7 in var_2._id_21F6) {
    var_7 show();
  }

  var_2 set_orbiters(10);
  var_2.origin = var_5.origin + (0, 0, -10);
  var_2.angles = (90, 0, 0);
  var_9 = spawn_a_floating_weapon_award(_id_0548::_id_454B(var_3, "blunderbuss_pap_zm"), var_4.origin, var_3);
  var_9.linkent.origin = var_4.origin;
  var_10 = undefined;
  var_9.linkent moveTo(var_5.origin, 4, 0, 1);
  wait 3.5;

  while(!isDefined(var_10) || var_10 != var_3) {
    var_10 = get_new_player(var_9);
    waitframe();
  }

  _id_0548::_id_A7D6(var_10, _id_0548::_id_454B(var_3, "blunderbuss_pap_zm"));
  var_9 delete();
  var_9.linkent delete();
  var_2 movez(-512, 8, 3);
  wait 2;

  foreach(var_12 in var_2._id_21F6) {
    var_12 delete();
  }

  var_2 delete();
  return 1;
}

spawn_a_floating_weapon_award(var_0, var_1, var_2) {
  var_3 = prespawn_a_floating_award(var_0, var_1, var_2);
  var_4 = 10000;
  var_5 = gettime() + var_4;

  while(gettime() < var_5) {
    if(isDefined(var_2)) {
      var_6 = [var_2];
    } else {
      var_6 = level.players;
    }

    var_7 = 1;

    foreach(var_9 in var_6) {
      if(!var_9 worldweaponsloaded(var_0)) {
        var_7 = 0;
      }
    }

    if(var_7) {
      break;
    }

    waitframe();
  }

  var_3 show_prespawned_floating_award(var_2);
  return var_3;
}

show_prespawned_floating_award(var_0) {
  set_shown_only_to_player(var_0);

  if(isDefined(self.fx)) {
    self.fx set_shown_only_to_player(var_0);
    _triggerfx(self.fx);
  }
}

prespawn_a_floating_award(var_0, var_1, var_2) {
  var_3 = spawn("weapon_" + var_0, _func_2E1(var_1) + (0, 0, 8));
  var_3.angles = (var_3.angles[0] - 30, randomint(360), var_3.angles[2]);
  var_3 makeunusable();
  var_3 set_hidden_but_sent_to_player(var_2);
  var_4 = var_3 common_scripts\utility::_id_8FFC();
  var_4.origin = var_4.origin + (0, 0, 8);
  var_4 set_hidden_but_sent_to_player(var_2);
  var_3.origin = var_4.origin;
  var_3 linktosynchronizedparent(var_4, "tag_origin");
  var_3.linkent = var_4;
  var_4 rotateYaw(36000, 850);
  var_5 = spawnStruct();
  var_5.origin = var_3.origin;
  return var_3;
}

set_hidden_but_sent_to_player(var_0) {
  set_shown_only_to_player(var_0);
  self ghost();
}

set_shown_only_to_player(var_0) {
  if(isDefined(var_0)) {
    self hide();
    self showtoplayer(var_0);
  } else
    self show();
}

run_game_sequence(var_0, var_1) {
  var_2 = self;
  var_3 = 0;
  var_4 = undefined;

  while(!var_3) {
    var_1.fx = _id_0547::_id_8FBA(var_1, "zmf_descent_vision_blood_ready");
    _triggerfx(var_1.fx);

    foreach(var_6 in var_2._id_21F6) {
      var_6 hide();
    }

    var_4 = get_new_player(var_1);
    var_4.is_in_side_ee_mini_game = 1;
    var_1.fx delete();
    var_4 childthread maintain_grenades();
    var_8 = level._id_A980;
    var_3 = 0;

    foreach(var_10 in var_0) {
      foreach(var_6 in var_2._id_21F6) {
        var_6 hide();
      }

      var_2.origin = var_10.origin;
      var_2.angles = vectortoangles(var_2.origin - var_1.origin);
      wait 1;

      foreach(var_6 in var_2._id_21F6) {
        var_6 show();
      }

      var_3 = var_2 wait_for_success_or_timeout();

      if(var_3) {
        foreach(var_6 in var_2._id_21F6) {
          playFX(common_scripts\utility::_id_44F5("proj_trail_green_os"), var_6.origin);
        }

        continue;
      }

      foreach(var_6 in var_2._id_21F6) {
        var_6 hide();
      }

      break;
    }

    var_4.is_in_side_ee_mini_game = 0;

    if(!var_3) {
      while(level._id_A980 < var_8 + 5) {
        waitframe();
      }
    } else
      break;

    waitframe();
  }

  return var_4;
}

set_orbiters(var_0) {
  var_1 = self;
  var_2 = [];
  var_2[0] = (0, var_0, 0);
  var_2[1] = (0, -1 * var_0, 0);
  var_2[2] = (0, 0, var_0);
  var_2[3] = (0, 0, -1 * var_0);

  if(!isDefined(var_1._id_21F6)) {
    var_1._id_21F6 = [];
  }

  foreach(var_4 in var_1._id_21F6) {
    _stopFXOnTag(common_scripts\utility::_id_44F5("proj_trail_white"), var_4, "tag_origin");
  }

  if(!isDefined(var_1._id_21F6) || var_1._id_21F6.size == 0) {
    for(var_6 = 0; var_6 < 4; var_6++) {
      var_7 = var_1 common_scripts\utility::_id_8FFC();
      var_7 show();
      var_7 linktosynchronizedparent(var_1, "tag_origin", var_2[var_6], (0, 0, 0));
      var_1._id_21F6[var_1._id_21F6.size] = var_7;
    }
  } else {
    for(var_6 = 0; var_6 < 4; var_6++) {
      var_7 = var_1._id_21F6[var_6];
      var_7 unlink();
      var_7 linktosynchronizedparent(var_1, "tag_origin", var_2[var_6], (0, 0, 0));
    }
  }

  var_1 thread reset_fx();
}

reset_fx() {
  var_0 = self;
  waitframe();

  foreach(var_2 in var_0._id_21F6) {
    _playFXOnTag(common_scripts\utility::_id_44F5("proj_trail_white"), var_2, "tag_origin");
  }
}

wait_for_success_or_timeout() {
  var_0 = gettime();

  while(gettime() - var_0 < 5000) {
    foreach(var_2 in maps\mp\zombies\_zombies_orbital_gravity_entangler::get_all_magical_grenades()) {
      if(distance(var_2.origin, self.origin) < 40) {
        return 1;
      }
    }

    waitframe();
  }

  return 0;
}

rotate_target() {
  self endon("entitydeleted");

  for(;;) {
    self rotatevelocity((0, 0, 36), 0.05);
    waitframe();
  }
}

maintain_grenades() {
  var_0 = self;

  while(common_scripts\utility::_id_562E(var_0.is_in_side_ee_mini_game)) {
    var_0.grenadecolorsheld = ["proj_trail_white", "proj_trail_white", "proj_trail_white", "proj_trail_white"];
    _id_0586::_id_478A(var_0);
    waitframe();
  }
}

get_new_player(var_0) {
  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2.zmb_dlc4_size_ee_final_hold_time)) {
        var_2.zmb_dlc4_size_ee_final_hold_time = 0;
      }

      if(distance(var_0.origin, var_2.origin) > 60) {
        var_2.zmb_dlc4_size_ee_final_hold_time = 0;
        continue;
      }

      if(!var_2 useButtonPressed()) {
        var_2.zmb_dlc4_size_ee_final_hold_time = 0;
        continue;
      }

      var_2.zmb_dlc4_size_ee_final_hold_time = var_2.zmb_dlc4_size_ee_final_hold_time + 0.1;

      if(var_2.zmb_dlc4_size_ee_final_hold_time >= 0.5) {
        return var_2;
      }
    }

    wait 0.1;
  }
}

set_flag_on_damage() {
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(_id_0547::_id_5565(var_4, "MOD_EXPLOSIVE")) {
      continue;
    }
    break;
  }

  self._id_08A9 = 1;

  if(self.classname == "script_model") {
    var_10 = (0, 0, 13);
  } else {
    var_10 = (0, 0, 5);
  }

  var_11 = self.angles;

  if(!isDefined(var_11)) {
    var_11 = (0, 0, 0);
  }

  playFX(common_scripts\utility::_id_44F5("ee_lamp_fx"), self.origin + var_10, anglesToForward(var_11), anglestoup(var_11));
  _id_0378::_id_8D74("aud_raven_fly_away");
}

move_around(var_0) {
  self endon("double_points_grabbed");
  self endon("entitydeleted");
  self.fx = undefined;

  if(isDefined(self.fx)) {
    self.fx delete();
  }

  var_1 = common_scripts\utility::random(var_0);
  self.origin = var_1.origin;
  var_2 = common_scripts\utility::random(level.zmb_side_ee_colors);
  self.ee_color = maps\mp\zombies\_zombies_orbital_gravity_entangler::get_color_for_grenade(var_2);

  for(;;) {
    self.angles = (randomint(360), randomint(360), randomint(360));
    self.fx = _id_0547::_id_8FBA(self, var_2);
    _triggerfx(self.fx);
    wait 7;

    if(_isremovedentity(self)) {
      return;
    }
    var_1 = common_scripts\utility::random(var_0);
    playFX(level._effect["zmb_dnk_geistkraftexplode"], self.origin);
    _id_0378::_id_8D74("aud_dlc4_magic_poof", self.origin);

    if(isDefined(self.fx)) {
      self.fx delete();
    }

    wait 0.7;

    if(_isremovedentity(self)) {
      return;
    }
    self.origin = var_1.origin;
    playFX(level._effect["zmb_dnk_geistkraftexplode"], var_1.origin);
    _id_0378::_id_8D74("dlc3_magic_poof", self.origin);
  }
}

wait_for_grab(var_0) {
  self endon("double_points_grabbed");

  while(!isDefined(level.players)) {
    waitframe();
  }

  var_1 = 0;
  var_2 = undefined;

  while(!var_1) {
    var_3 = maps\mp\zombies\_zombies_orbital_gravity_entangler::get_all_magical_grenades();

    foreach(var_5 in var_3) {
      if(distance(var_5.origin, self.origin) > 90 || !_id_0547::_id_5565(var_5.ee_color, self.ee_color)) {
        continue;
      } else {
        var_1 = 1;
        break;
      }
    }

    waitframe();
  }

  common_scripts\utility::flag_set(var_0);
  self notify("double_points_grabbed");
}

run_harmonic_kinectic_acceleration() {
  initialize_plate();
  waitframe();

  if(self.weaponlocktargettooclose == "a") {
    common_scripts\utility::_id_3C9F("flag_archives_to_bridge_1");
    common_scripts\utility::_id_3C9F("flag_gallery_to_bridge_1");
    common_scripts\utility::flag_set("zmb_double_points_available");
  }

  level thread maps\mp\_utility::_id_6F74(::launchplayers, self);
}

launchplayers(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = -800;
  var_3 = 10;

  if(!isDefined(var_1.launchpadfx)) {
    var_1.launchpadfx = [];
  }

  for(;;) {
    if(isDefined(var_1.launchpadfx[var_0.weaponlocktargettooclose])) {
      var_1.launchpadfx[var_0.weaponlocktargettooclose] delete();
    }

    var_1.launchpadfx[var_0.weaponlocktargettooclose] = _id_0547::_id_8FBA(var_0.plate_model, "dlc_zmb_dig02_sword_looping", var_1);
    _triggerfx(var_1.launchpadfx[var_0.weaponlocktargettooclose]);

    while(!var_1 jumpbuttonPressed() || distance(var_1.origin, var_0.origin) > 132) {
      waitframe();
    }

    if(isDefined(var_1.launchpadfx[var_0.weaponlocktargettooclose])) {
      var_1.launchpadfx[var_0.weaponlocktargettooclose] delete();
    }

    var_4 = distance(var_1.origin, var_0.dest_path.landing.origin) < 512;
    _id_0378::_id_8D74("tesla_hc_energy_lamp_destruct", var_1.origin);

    if(!var_4) {
      var_5 = var_1 common_scripts\utility::_id_8FFC();
      var_5 show();
      var_6 = var_1 common_scripts\utility::_id_8FFC();
      var_6 show();
      var_1 playerlinkTo(var_5, "tag_player");
      var_7 = get_required_velocity(var_0.dest_path.origin, var_1.origin);
      var_8 = var_0.dest_path.landing.origin[2] - var_1.origin[2];
      var_3 = _id_8F12(var_2 / 2, var_7[2], -1 * var_8);
      var_5 movegravity(var_7, var_3);
      var_9 = 0;
      var_10 = var_5 track_velocity();
      var_1 unlink();
      var_6.origin = var_5.origin;
      var_1 playerlinkTo(var_6, "tag_player");
      var_6 moveTo(var_10, 0.3);
      wait 0.3;
      var_1 unlink();
      var_5 delete();
      var_6 delete();
    } else {
      var_11 = var_1 _meth_8566();
      var_11 = common_scripts\utility::_id_3D5C(var_11);
      var_12 = vectorNormalize(anglesToForward(var_11));
      var_7 = get_required_velocity((var_1.origin[0] + 128 * var_12[0], var_1.origin[1] + 128 * var_12[1], var_0.dest_path.origin[2]), var_1.origin);
      var_1 setvelocity(var_7);
    }

    level common_scripts\utility::_id_A70D(8, level, "round complete");
  }
}

magnitude(var_0) {
  return _sqrt(_squared(var_0[0]) + _squared(var_0[1]) + _squared(var_0[2]));
}

track_velocity() {
  self endon("entitydeleted");
  self.my_velocity = (0, 0, 0);
  var_0 = 1;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = undefined;

  for(;;) {
    var_1 = _id_4231(self.origin[0], var_4, var_7);
    var_2 = _id_4231(self.origin[1], var_5, var_7);
    var_3 = _id_4231(self.origin[2], var_6, var_7);
    self.my_velocity = (var_1, var_2, var_3);
    var_4 = self.origin[0];
    var_5 = self.origin[1];
    var_6 = self.origin[2];
    var_7 = gettime();

    if(self.my_velocity[2] < 0) {
      var_9 = vectorNormalize(self.my_velocity);
      var_10 = self.origin;
      var_11 = var_10 + 1000 * var_9;
      var_8 = bulletTrace(var_10, var_11, 0);

      if(distance(self.origin, var_8["position"]) < 150) {
        return var_8["position"] + (0, 0, 1);
      }
    }

    waitframe();
  }
}

_id_4231(var_0, var_1, var_2) {
  return (var_0 - var_1) / ((gettime() - var_2) / 1000);
}

_id_8F12(var_0, var_1, var_2) {
  var_3 = var_1 * var_1 - 4 * var_0 * var_2;
  var_4 = 0;
  var_5 = 0;

  if(var_3 > 0) {
    var_4 = (-1 * var_1 + _sqrt(var_3)) / (2 * var_0);
    var_5 = (-1 * var_1 - _sqrt(var_3)) / (2 * var_0);
  }

  return var_5;
}

get_required_velocity(var_0, var_1) {
  var_2 = -800;
  var_3 = var_0[2] - var_1[2];
  var_4 = 2 * (var_0[1] - var_1[1]);
  var_5 = 2 * (var_0[0] - var_1[0]);
  var_6 = _sqrt(-2 * var_2 * var_3);
  var_7 = -2 * (var_6 / var_2);
  var_8 = var_5 / var_7;
  var_9 = var_4 / var_7;
  return (var_8, var_9, var_6);
}

initialize_plate() {
  var_0 = self;
  var_1 = common_scripts\utility::_id_44BE(var_0.target, "targetname");
  var_0.dest_path = common_scripts\utility::_id_46B5("launch_path_" + var_0.weaponlocktargettooclose, "script_noteworthy");
  var_0.dest_path.landing = common_scripts\utility::_id_46B5(var_0.dest_path.target, "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3._id_0165;

    if(!isDefined(var_4)) {
      continue;
    }
    switch (var_4) {
      case "plate_model_lower":
        var_0.plate_model_lower = var_3;
        break;
      case "plate_model_upper":
        var_0.plate_model_upper = var_3;
        break;
      case "plate_model":
        var_0.plate_model = var_3;
        var_0.model_start_origin = var_3.origin;
        break;
      case "plate_trig":
        var_0.plate_trig = var_3;
        var_0.plate_trig.associated_struct = var_0;
        break;
      case "plate_damage_trig":
        var_0.plate_damage_trig = var_3;
        break;
      case "plate_center_trig":
        var_0.plate_center_trig = var_3;
        break;
    }
  }
}