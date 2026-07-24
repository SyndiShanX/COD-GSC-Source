/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_shooting_gallery.gsc
***************************************************************/

_id_13010(var_0, var_1) {
  var_0._id_45C5.in_afterlife_arcade = scripts\engine\utility::is_true(var_1.in_afterlife_arcade);
  var_1 playlocalsound("arcade_insert_coin_01");

  if(!scripts\engine\utility::is_true(var_0._id_45C5.song_playing)) {
    scripts\engine\utility::delaythread(0.2, scripts\engine\utility::play_sound_in_space, "arcade_horserace_gunshot", var_1.origin);
    scripts\cp\utility::playsoundatpos_safe(var_0.origin, "shooting_gall_anc_activate");
    level thread scripts\cp\zombies\arcade_game_utility::update_song_playing(var_0._id_45C5, "shooting_gall_anc_activate");
  }

  level.wave_num_at_start_of_game = level.wave_num;

  if(!scripts\engine\utility::is_true(var_1.in_afterlife_arcade)) {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("shooting_gallery", var_1);
  } else {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("shooting_gallery_afterlife", var_1);
  }

  _id_5581(var_0);

  if(!_id_9CBE(var_0._id_45C5)) {
    _id_E210(var_0._id_45C5);
  }

  _id_1771(var_0._id_45C5, var_1);
  _id_CE0B(var_0, var_1);

  if(!_id_9CBE(var_0._id_45C5)) {
    _id_10D1E(var_0._id_45C5);
  }
}

_id_CE0B(var_0, var_1) {
  if(!scripts\engine\utility::is_true(var_1.in_afterlife_arcade)) {
    var_0 notify("machine_used");
  }

  var_1.pre_arcade_game_weapon = var_1 scripts\cp\zombies\arcade_game_utility::saveplayerpregameweapon(var_1);
  var_2 = var_0.weapon;
  var_1._id_7654 = var_2;
  var_1 giveweapon(var_2);
  var_1 switchtoweapon(var_2);
  var_1 scripts\engine\utility::allow_weapon_switch(0);
  var_1 scripts\engine\utility::allow_usability(0);
  var_1 scripts\cp\powers\coop_powers::power_disablepower();
  var_1 allowmelee(0);
  var_1 _id_FEBF(var_1);
  var_1 _id_1298F(var_0._id_45C5, var_1);
  var_1 _id_553F(var_1);
  var_1 _id_E225(var_1);
  var_1 thread _id_FEB3(var_1);
  var_1 thread _id_FEBC(var_0._id_45C5, var_0, var_1, 30);
  var_1 thread _id_FEBB(var_0, var_1);
}

_id_973E() {
  _id_9741("shooting_gallery");
  _id_9740();
  _id_9690();
  level thread _id_5555(2);
}

_id_94DA() {
  _id_9741("shooting_gallery_afterlife");
}

_id_9741(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");

  foreach(var_4, var_3 in var_1) {
    var_3 thread _id_FA41(var_4);
  }
}

_id_FA41(var_0) {
  self._id_45C5 = scripts\engine\utility::getStructArray(self.target, "targetname")[0];
  self._id_13C27 = self.origin;
  self._id_13BFE = self.angles;
  _id_CC05(self, var_0);
  var_1 = scripts\engine\utility::is_true(self.requires_power) && isDefined(self.power_area);

  for(;;) {
    var_2 = "power_on";

    if(var_1) {
      var_2 = level scripts\engine\utility::waittill_any_return_no_endon_death("power_on", self.power_area + " power_on", "power_off");

      if(var_2 != "power_off") {
        self.powered_on = 1;
        _id_1298B(self._id_45C5);
      } else {
        self.powered_on = 0;
        _id_12967(self._id_45C5);
      }
    }

    if(!var_1) {
      _id_1298B(self._id_45C5);
      break;
    }

    wait 0.25;
  }
}

_id_9690() {
  level._id_FEB7 = scripts\engine\utility::getStructArray("shooting_gallery_moving_target_path", "script_noteworthy");
}

_id_10D1E(var_0) {
  level thread _id_10D1F(var_0);
}

_id_10D1F(var_0) {
  var_0 endon("shooting_gallery_game_over");
  var_0 thread _id_C927(var_0);
  _id_F59C(var_0, 1);
  var_0 thread _id_10D20(var_0);
  _id_96A0(var_0);
  _id_12978(var_0);
  thread scripts\engine\utility::play_sound_in_space("shooting_gallery_sign_up_start", var_0.origin);

  for(;;) {
    var_1 = _id_7CE1(var_0);

    switch (var_1) {
      case "alien_king":
        var_0 thread _id_15EC(var_0, _id_784F(var_0), _id_77F4(), 10, 2, 55);
        break;
      case "alien":
        var_0 thread _id_15EC(var_0, _id_784F(var_0), _id_77F7(), 5, 4, 55);
        break;
      case "hostage":
        var_2 = _id_7A10();
        var_3 = _id_7A11(var_2);
        var_4 = _id_7A12(var_2);
        var_0 thread _id_15EC(var_0, _id_7849(var_0), var_2, var_3, 4, var_4);
        break;
      case "ufo":
        _id_4DCF(var_0);
        _id_D7E9();
        activate_moving_targets(var_0);
        break;
    }

    if(var_1 == "ufo") {
      var_0 waittill("target_sign_deactivated");
      continue;
    }

    if(_id_7B34(var_0) < 3) {
      var_0 scripts\engine\utility::waittill_any_timeout(1.5, "target_sign_deactivated");
      continue;
    }

    var_0 waittill("target_sign_deactivated");
  }
}

_id_15EC(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_12DF7(var_0, 1);
  var_6 = _id_107E9(var_1, var_2);
  _id_BC7A(var_6, var_5);
  var_7 = scripts\cp\utility::waittill_any_ents_return(var_6, "movedone", var_0, "shooting_gallery_game_over", var_0, "shooting_gallery_end_stationary");

  if(var_7 == "movedone") {
    _id_61E9(var_6);
    var_6 thread _id_FEC0(var_0, var_6, var_3);
    scripts\cp\utility::waittill_any_ents_or_timeout_return(var_4, var_6, "shooting_gallery_sign_hit", var_0, "shooting_gallery_game_over", var_0, "shooting_gallery_end_stationary");
    _id_5515(var_6);
  }

  _id_BC79(var_6, var_5);
  var_6 delete();
  _id_12DF7(var_0, -1);
  var_0 notify("target_sign_deactivated");
}

_id_107E9(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2.angles = var_0.angles;
  var_2 setModel(var_1);
  return var_2;
}

_id_BC7A(var_0, var_1) {
  var_0 moveTo(var_0.origin + (0, 0, var_1), 0.2, 0.2, 0.0);
  var_0 playSound("shooting_gallery_sign_up");
}

activate_moving_targets(var_0) {
  var_1 = var_0._id_FEB8[randomint(var_0._id_FEB8.size)];
  var_1 thread _id_BD47(var_0, var_1);
}

_id_BD47(var_0, var_1) {
  _id_12DF7(var_0, 1);
  var_2 = _id_10775(var_1);
  var_2 thread _id_FEB5(var_0, var_2);
  var_2 thread _id_FEB6(var_0, var_2);
}

_id_9F4E(var_0) {
  if(var_0 == "iw7_shootgallery_zm_red" || var_0 == "iw7_shootgallery_zm_blue" || var_0 == "iw7_shootgallery_zm_green" || var_0 == "iw7_shootgallery_zm_yellow") {
    return 1;
  } else {
    return 0;
  }
}

_id_FEB5(var_0, var_1) {
  var_1 endon("death");
  _id_61E9(var_1);

  for(;;) {
    var_1 waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_1 playSound("shooting_gallery_moving_sign_hit");
    var_1.health = 999999;

    if(_id_9F4E(var_11)) {
      _id_5515(var_1);
      _id_56D0(var_3, 25, var_0);
      _id_12D92(var_3, 25);
      var_1 notify("moving_target_hit");
      var_3 notify("moving_target_hit_notify");
      break;
    }
  }
}

_id_FEC0(var_0, var_1, var_2) {
  var_0 endon("shooting_gallery_game_over");

  for(;;) {
    var_1 waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    var_1.health = 999999;

    if(_id_9F4E(var_12)) {
      break;
    }
  }

  var_1 playSound("shooting_gallery_sign_hit");
  _id_56D0(var_4, var_2, var_0);
  _id_12D92(var_4, var_2);
  var_1 notify("shooting_gallery_sign_hit");
}

_id_FEB6(var_0, var_1) {
  var_1 notify("moving_target_move_think");
  var_1 endon("moving_target_move_think");
  var_2 = scripts\engine\utility::get_array_of_closest(var_1.origin, level._id_FEB7);
  var_3 = var_2[0];

  for(;;) {
    var_1 moveTo(var_3.origin, 0.6);
    var_4 = var_1 scripts\cp\utility::waittill_any_ents_return(var_1, "movedone", var_1, "moving_target_hit", var_0, "shooting_gallery_game_over");

    if(var_4 == "movedone") {
      if(var_2[0] != var_3 && isDefined(var_3.script_parameters) && var_3.script_parameters == "shooting_gallery_path_end") {
        break;
      }

      var_3 = scripts\engine\utility::getStructArray(var_3.target, "targetname")[0];
      continue;
    }

    break;
  }

  var_1 moveTo(var_3.origin + (0, 0, 150), 0.6);
  var_1 waittill("movedone");
  var_1 delete();
  _id_12DF7(var_0, -1);
  var_0 notify("target_sign_deactivated");
}

_id_BC79(var_0, var_1) {
  var_0 moveTo(var_0.origin - (0, 0, var_1), 0.2, 0.2, 0.0);
  var_0 waittill("movedone");
}

_id_61E9(var_0) {
  var_0.health = 999999;
  var_0 setCanDamage(1);
}

_id_5515(var_0) {
  var_0 setCanDamage(0);
}

_id_C927(var_0) {
  level endon("game_ended");
  var_0 endon("shooting_gallery_game_over");

  for(;;) {
    var_0 waittill("shooting_gallery_player_left", var_1);
    _id_E027(var_0, var_1);

    if(_id_7B3A(var_0) == 0) {
      _id_10173(var_0);
    }
  }
}

_id_6961(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_2 takeweapon(var_2._id_7654);
    var_2._id_7654 = undefined;
    var_2 scripts\engine\utility::allow_weapon_switch(1);

    if(!var_2 scripts\engine\utility::isusabilityallowed()) {
      var_2 scripts\engine\utility::allow_usability(1);
    }

    var_2 allowmelee(1);
    var_2 scripts\cp\powers\coop_powers::power_enablepower();
    var_2 scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(var_2);
    var_2 _id_1296C(var_0, var_2);
    var_2 _id_6208(var_2);
    var_2 _id_FEBF(var_2);
    var_2 _id_832F(var_0, var_2);
  }

  if(!var_1._id_45C5.in_afterlife_arcade) {
    level notify("gallery_used");
  }

  _id_6237(var_1);
  var_0 notify("shooting_gallery_player_left", var_2);
  var_2 notify("arcade_game_over_for_player");
}

_id_FEB3(var_0) {
  var_0 endon("arcade_game_over_for_player");
  var_0 endon("spawned");
  var_1 = 30;
  var_0 setclientomnvar("zombie_arcade_game_shot_remaining", var_1);

  for(;;) {
    var_0 waittill("grenade_fire");
    var_1--;
    var_0 givemaxammo(var_0._id_7654);
    var_0 setweaponammoclip(var_0._id_7654, weaponclipsize(var_0._id_7654));
    var_0 setclientomnvar("zombie_arcade_game_shot_remaining", var_1);

    if(var_1 <= 0) {
      break;
    }
  }

  var_0 notify("no_shot_left");
}

_id_FEBF(var_0) {
  var_0 setclientomnvar("zombie_arcade_game_time", -1);
  var_0 setclientomnvar("zombie_arcade_game_ticket_earned", 0);
  var_0 setclientomnvar("zombie_arcade_game_shot_remaining", 0);
}

_id_1298F(var_0, var_1) {
  var_1 setclientomnvar(var_0.script_parameters, 1);
}

_id_1296C(var_0, var_1) {
  var_1 setclientomnvar(var_0.script_parameters, 0);
}

_id_12D92(var_0, var_1) {
  var_0._id_FEBA = int(max(0, var_0._id_FEBA + var_1));
  var_0 setclientomnvar("zombie_arcade_game_ticket_earned", var_0._id_FEBA);
}

_id_E225(var_0) {
  var_0._id_FEBA = 0;
}

_id_553F(var_0) {
  var_0 scripts\cp\utility::allow_player_interactions(0);
}

_id_6208(var_0) {
  if(!var_0 scripts\cp\utility::areinteractionsenabled()) {
    var_0 scripts\cp\utility::allow_player_interactions(1);
  }
}

_id_9740() {
  var_0 = scripts\engine\utility::getStructArray("shooting_gallery_controlling_struct", "script_noteworthy");

  foreach(var_2 in var_0) {
    _id_973F(var_2);
  }
}

_id_973F(var_0) {
  _id_F59C(var_0, 0);
  var_0._id_FEC1 = [];
  var_0._id_FEC2 = [];
  var_0._id_FEB2 = [];
  var_0._id_FEB8 = [];
  var_0._id_FEBD = undefined;
  var_0._id_FEB0 = undefined;
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "shooting_gallery_target_row_1":
        var_0._id_FEC1[var_0._id_FEC1.size] = var_3;
        break;
      case "shooting_gallery_target_row_2":
        var_0._id_FEC2[var_0._id_FEC2.size] = var_3;
        break;
      case "shooting_gallery_hostage":
        var_0._id_FEB2[var_0._id_FEB2.size] = var_3;
        break;
      case "shooting_gallery_moving_target":
        var_0._id_FEB8[var_0._id_FEB8.size] = var_3;
        break;
    }
  }

  var_5 = var_0._id_EF20;

  if(isDefined(var_5)) {
    var_5 = strtok(var_5, " ");

    foreach(var_7 in var_5) {
      if(issubstr(var_7, "power_on")) {
        var_0._id_FEBE = var_7;
      }

      if(issubstr(var_7, "activation")) {
        var_0._id_FEB1 = var_7;
      }
    }
  }

  _id_F5E4(var_0);
  _id_F5E3(var_0);
  _id_F5F2(var_0);
}

_id_F5E4(var_0) {
  var_0._id_26A1 = scripts\engine\utility::array_combine(var_0._id_FEC1, var_0._id_FEC2);
  var_0._id_26A1 = scripts\engine\utility::array_randomize(var_0._id_26A1);
}

_id_F5E3(var_0) {
  var_0._id_269E = scripts\engine\utility::array_randomize(var_0._id_FEB2);
}

_id_F5F2(var_0) {
  var_1 = [];
  var_2 = ["alien", "alien", "alien", "alien_king", "hostage"];

  for(var_3 = 0; var_3 < 3; var_3++) {
    var_1 = scripts\engine\utility::array_combine(var_1, scripts\engine\utility::array_randomize(var_2));
  }

  var_1[var_1.size] = "ufo";
  var_0._id_1154F = var_1;
}

_id_784F(var_0) {
  if(var_0._id_26A1.size == 0) {
    _id_F5E4(var_0);
  }

  var_1 = var_0._id_26A1[0];
  var_0._id_26A1 = scripts\engine\utility::array_remove(var_0._id_26A1, var_1);
  return var_1;
}

_id_7849(var_0) {
  if(var_0._id_269E.size == 0) {
    _id_F5E3(var_0);
  }

  var_1 = var_0._id_269E[0];
  var_0._id_269E = scripts\engine\utility::array_remove(var_0._id_269E, var_1);
  return var_1;
}

_id_7CE1(var_0) {
  if(var_0._id_1154F.size == 0) {
    _id_F5F2(var_0);
  }

  var_1 = var_0._id_1154F[0];
  var_0._id_1154F = scripts\cp\utility::array_remove_index(var_0._id_1154F, 0, 0);
  return var_1;
}

_id_F59C(var_0, var_1) {
  var_0._id_FEB4 = var_1;
}

_id_9CBE(var_0) {
  return scripts\engine\utility::is_true(var_0._id_FEB4);
}

_id_FEBC(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_2 endon("arcade_game_over_for_player");
  var_2 thread _id_12E3D(var_2, var_3);
  var_4 = var_2 scripts\engine\utility::waittill_any_timeout(var_3, "disconnect", "last_stand", "shooting_gallery_player_gets_away", "spawned", "no_shot_left");
  _id_6961(var_0, var_1, var_2);
}

_id_12E3D(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("arcade_game_over_for_player");

  for(var_2 = var_1; var_2 >= 0; var_2--) {
    var_0 setclientomnvar("zombie_arcade_game_time", var_2);
    wait 1;
  }
}

_id_FEBB(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("arcade_game_over_for_player");
  var_1 endon("spawned");
  var_2 = 10000;

  for(;;) {
    wait 0.1;

    if(distancesquared(var_1.origin, var_0.origin) > var_2) {
      wait 2;

      if(distancesquared(self.origin, var_0.origin) > var_2) {
        var_1 notify("shooting_gallery_player_gets_away");
      }
    }
  }
}

_id_1771(var_0, var_1) {
  var_0._id_163B = scripts\engine\utility::array_add(var_0._id_163B, var_1);
}

_id_E027(var_0, var_1) {
  var_0._id_163B = scripts\engine\utility::array_remove(var_0._id_163B, var_1);
}

_id_7B3A(var_0) {
  return var_0._id_163B.size;
}

_id_E210(var_0) {
  var_0._id_163B = [];
}

_id_10173(var_0) {
  _id_F59C(var_0, 0);
  var_0 thread _id_1103E(var_0);
  _id_12947(var_0);
  var_0 notify("shooting_gallery_game_over");
}

_id_77F4() {
  return "zmb_target_alien01";
}

_id_77F7() {
  var_0 = ["zmb_target_alien02", "zmb_target_alien03"];
  return var_0[randomint(var_0.size)];
}

_id_7A10() {
  var_0 = ["zmb_target_civilian01", "zmb_target_civilian02", "zmb_target_civilian03", "zmb_civilian_target_01", "zmb_civilian_target_02", "zmb_civilian_target_03", "zmb_civilian_target_04"];
  return var_0[randomint(var_0.size)];
}

_id_7A11(var_0) {
  switch (var_0) {
    case "zmb_target_civilian03":
    case "zmb_target_civilian02":
    case "zmb_target_civilian01":
      return -5;
    case "zmb_civilian_target_04":
    case "zmb_civilian_target_03":
    case "zmb_civilian_target_01":
      return -10;
    case "zmb_civilian_target_02":
      return -15;
  }
}

_id_7A12(var_0) {
  switch (var_0) {
    case "zmb_target_civilian03":
    case "zmb_target_civilian02":
    case "zmb_target_civilian01":
      return 40;
    case "zmb_civilian_target_04":
    case "zmb_civilian_target_03":
    case "zmb_civilian_target_02":
    case "zmb_civilian_target_01":
      return 40;
  }
}

_id_10775(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("zmb_target_ship01");
  return var_1;
}

_id_56D0(var_0, var_1, var_2) {
  if(!isDefined(var_2._id_FEC3)) {
    var_2._id_FEC3 = spawn("script_origin", var_2.origin);
  }

  if(var_1 > 0) {
    var_0 iprintlnbold("^3+" + var_1);
    var_2._id_FEC3 playSound("zmb_shooting_gal_bell");
    scripts\cp\utility::playsoundatpos_safe(var_2.origin, "shooting_gall_anc_hit_target");
  }

  if(var_1 < 0) {
    var_0 iprintlnbold("^6" + var_1);
    var_2._id_FEC3 playSound("zmb_shooting_gal_buzz");
  }
}

_id_10D20(var_0) {
  wait 1;

  if(!isDefined(var_0._id_FEB9)) {
    var_0._id_FEB9 = spawn("script_origin", var_0.origin);
  }
}

_id_1103E(var_0) {
  wait 1;

  if(isDefined(var_0._id_FEB9)) {
    var_0._id_FEB9 stoploopsound("mus_arcade_alienattack");
  }
}

_id_832F(var_0, var_1) {
  if(!scripts\engine\utility::is_true(var_0.song_playing)) {
    if(var_1._id_FEBA <= 0) {
      playsoundatpos(var_0.origin, "shooting_gall_anc_failure");
      level thread scripts\cp\zombies\arcade_game_utility::update_song_playing(var_0, "shooting_gall_anc_failure");
    } else if(soundexists("shooting_gall_anc_success")) {
      playsoundatpos(var_0.origin, "shooting_gall_anc_success");
      level thread scripts\cp\zombies\arcade_game_utility::update_song_playing(var_0, "shooting_gall_anc_success");
    }
  }

  if(var_0.in_afterlife_arcade) {
    if(scripts\engine\utility::is_true(var_1.in_afterlife_arcade)) {
      var_1 scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(var_1, var_1._id_FEBA);
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_1, level.wave_num_at_start_of_game, "shooting_gallery_afterlife", 1, var_1._id_FEBA, var_1.pers["timesPerWave"]._id_11930[level.wave_num_at_start_of_game]["shooting_gallery_afterlife"]);
    }
  } else {
    var_1 scripts\cp\zombies\arcade_game_utility::give_player_tickets(var_1, var_1._id_FEBA);
    scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_1, level.wave_num_at_start_of_game, "shooting_gallery", 0, var_1._id_FEBA, var_1.pers["timesPerWave"]._id_11930[level.wave_num_at_start_of_game]["shooting_gallery"]);
  }
}

_id_5581(var_0) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  _id_E0AB(var_0);
}

_id_6237(var_0) {
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  _id_CC05(var_0);
}

_id_CC05(var_0, var_1) {
  var_0._id_13C2C = spawn("script_model", var_0._id_13C27);
  var_2 = ["weapon_shootinggallery_wm_red", "weapon_shootinggallery_wm_blue", "weapon_shootinggallery_wm_green", "weapon_shootinggallery_wm_yellow"];
  var_3 = ["iw7_shootgallery_zm_red", "iw7_shootgallery_zm_blue", "iw7_shootgallery_zm_green", "iw7_shootgallery_zm_yellow"];

  if(!isDefined(var_0.model)) {
    var_0.model = var_2[var_1];
  }

  if(!isDefined(var_0.weapon)) {
    var_0.weapon = var_3[var_1];
  }

  var_0._id_13C2C setModel(var_0.model);
  var_0._id_13C2C.angles = var_0._id_13BFE;
}

_id_E0AB(var_0) {
  var_0._id_13C2C delete();
}

_id_7B34(var_0) {
  return var_0._id_C1D6;
}

_id_96A0(var_0) {
  var_0._id_C1D6 = 0;
}

_id_12DF7(var_0, var_1) {
  var_0._id_C1D6 = var_0._id_C1D6 + var_1;
}

_id_4DCF(var_0) {
  var_0 notify("shooting_gallery_end_stationary");
}

_id_D7E9() {
  wait 0.6;
}

_id_12978(var_0) {
  if(!isDefined(var_0._id_FEB1)) {
    return;
  }
  _id_F590(var_0._id_FEB1, "shooting_gallery_light", "gallery_light_on");
}

_id_12947(var_0) {
  if(!isDefined(var_0._id_FEB1)) {
    return;
  }
  _id_F590(var_0._id_FEB1, "shooting_gallery_light", "gallery_light_off");
}

_id_1298B(var_0) {
  if(!isDefined(var_0._id_FEBE)) {
    return;
  }
  _id_F590(var_0._id_FEBE, "shooting_gallery_light", "gallery_light_on");
}

_id_12967(var_0) {
  if(!isDefined(var_0._id_FEBE)) {
    return;
  }
  _id_F590(var_0._id_FEBE, "shooting_gallery_light", "gallery_light_off");
}

_id_F590(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, "targetname");

  foreach(var_5 in var_3) {
    var_5 setscriptablepartstate(var_1, var_2);
  }
}

_id_5555(var_0) {
  level._id_210D = 0;

  for(;;) {
    level waittill("gallery_used");
    level._id_210D++;

    if(level._id_210D == var_0) {
      var_1 = scripts\engine\utility::getStructArray("shooting_gallery", "script_noteworthy");

      foreach(var_3 in var_1) {
        var_3.out_of_order = 1;
      }

      level scripts\engine\utility::waittill_any("regular_wave_starting", "event_wave_starting");

      foreach(var_3 in var_1) {
        var_3.out_of_order = 0;
      }

      foreach(var_8 in level.players) {
        foreach(var_3 in var_1) {
          if(isDefined(var_8.last_interaction_point) && var_8.last_interaction_point == var_3) {
            var_8 thread scripts\cp\cp_interaction::refresh_interaction();
          }
        }
      }

      level._id_210D = 0;
    }
  }
}

register_interactions() {
  level.interaction_hintstrings["shooting_gallery_afterlife"] = &"CP_ZOMBIE_AFTERLIFE_ARCADE_PLAY_GAME";
  scripts\cp\cp_interaction::register_interaction("shooting_gallery", "arcade_game", undefined, scripts\cp\zombies\arcade_game_utility::arcade_game_hint_func, ::_id_13010, 0, 1, ::_id_973E);
  scripts\cp\cp_interaction::register_interaction("shooting_gallery_afterlife", "afterlife_game", undefined, undefined, ::_id_13010, 0, 0, ::_id_94DA);
}