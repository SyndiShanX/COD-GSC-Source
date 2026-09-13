/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_killstreaks.gsc
************************************************/

bot_killstreak_setup() {
  if(!isDefined(level.killstreak_botfunc)) {
    if(!isDefined(level.killstreak_botfunc))
      level.killstreak_botfunc = [];

    if(!isDefined(level.killstreak_botcanuse))
      level.killstreak_botcanuse = [];

    if(!isDefined(level.killstreak_botparm))
      level.killstreak_botparm = [];

    if(!isDefined(level.bot_supported_killstreaks))
      level.bot_supported_killstreaks = [];

    if(istrue(game["isLaunchChunk"])) {
      return;
    }
    bot_register_killstreak_func("uav", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("directional_uav", ::bot_killstreak_simple_use);

    if(isDefined(level.mapcustombotkillstreakfunc))
      [[level.mapcustombotkillstreakfunc]]();
  }
}

bot_register_killstreak_func(name, func, can_use, _id_D153265565DF63DA) {
  if(!isDefined(level._id_0B23156D776B1D85._id_038F2A11237246AC[name])) {
    return;
  }
  level.killstreak_botfunc[name] = func;
  level.killstreak_botcanuse[name] = can_use;
  level.killstreak_botparm[name] = _id_D153265565DF63DA;
  level.bot_supported_killstreaks[level.bot_supported_killstreaks.size] = name;
}

bot_killstreak_valid_for_specific_streaktype(streakname, streaktype, _id_CD3FCF4785236CDA) {
  if(bot_killstreak_is_valid_internal(streakname, "bots", undefined, streaktype))
    return 1;
  else if(_id_CD3FCF4785236CDA) {}

  return 0;
}

bot_killstreak_is_valid_internal(streakname, _id_CA854A77F264BED6, _id_44B62635A6FB50C7, _id_1C9CA7DBE4790741) {
  _id_C61CD683F3A90CC2 = undefined;

  if(streakname == "specialist")
    return 1;

  if(!bot_killstreak_is_valid_single(streakname, _id_CA854A77F264BED6))
    return 0;

  if(isDefined(_id_1C9CA7DBE4790741)) {
    _id_C61CD683F3A90CC2 = getsubstr(_id_1C9CA7DBE4790741, 11);

    switch (_id_C61CD683F3A90CC2) {
      case "assault":
        if(!scripts\mp\utility\killstreak::isassaultkillstreak(streakname))
          return 0;

        break;
      case "support":
        if(!scripts\mp\utility\killstreak::issupportkillstreak(streakname))
          return 0;

        break;
      case "specialist":
        if(!scripts\mp\utility\killstreak::isspecialistkillstreak(streakname))
          return 0;

        break;
    }
  }

  return 1;
}

bot_killstreak_is_valid_single(streakname, _id_CA854A77F264BED6) {
  if(_id_CA854A77F264BED6 == "humans")
    return isDefined(level.killstreaksetups[streakname]) && scripts\cp_mp\utility\killstreak_utility::getkillstreakindex(streakname) != -1;
  else if(_id_CA854A77F264BED6 == "bots")
    return isDefined(level.killstreak_botfunc[streakname]);
}

bot_watch_for_killstreak_use() {
  self notify("bot_watch_for_killstreak_use");
  self endon("bot_watch_for_killstreak_use");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("killstreak_use_finished");
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon("none");
  }
}

bot_is_killstreak_supported(name) {
  if(!isDefined(name))
    return 0;

  if(!isDefined(level.killstreak_botfunc[name]))
    return 0;

  return 1;
}

bot_can_use_killstreak(name) {
  _id_F40F83E224A240F1 = level.killstreak_botcanuse[name];

  if(!isDefined(_id_F40F83E224A240F1))
    return 0;

  if(isDefined(_id_F40F83E224A240F1) && !self[[_id_F40F83E224A240F1]]())
    return 0;

  return 1;
}

bot_think_killstreak() {}

bot_can_use_aa_launcher() {
  return 0;
}

bot_start_aa_launcher_tracking() {}

bot_killstreak_never_use() {}

bot_can_use_air_superiority() {
  return 0;
}

aerial_vehicle_allowed() {
  if(scripts\mp\utility\game::isairdenied())
    return 0;

  if(vehicle_would_exceed_limit())
    return 0;

  return 1;
}

vehicle_would_exceed_limit() {
  return scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= scripts\mp\utility\killstreak::maxvehiclesallowed();
}

bot_can_use_emp() {
  if(isDefined(level.empplayer))
    return 0;

  _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(self.owner.team);

  foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
    if(isDefined(level.teamemped) && !istrue(level.teamemped[_id_F90358454413407F]))
      return 1;
  }

  return 0;
}

bot_can_use_ball_drone() {
  return 0;
}

bot_killstreak_simple_use(killstreak_info, killstreaks_array, _id_86AF96FE008C96EE, _id_1EF9E61D95CBF8F7) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait(randomintrange(3, 5));

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks())
    return 1;

  if(isDefined(_id_86AF96FE008C96EE) && !self[[_id_86AF96FE008C96EE]]())
    return 0;

  bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, killstreak_info.weapon);
  return 1;
}

bot_killstreak_drop_anywhere(killstreak_info, killstreaks_array, _id_86AF96FE008C96EE, _id_1EF9E61D95CBF8F7) {
  bot_killstreak_drop(killstreak_info, killstreaks_array, _id_86AF96FE008C96EE, _id_1EF9E61D95CBF8F7, "anywhere");
}

bot_killstreak_drop_outside(killstreak_info, killstreaks_array, _id_86AF96FE008C96EE, _id_1EF9E61D95CBF8F7) {
  bot_killstreak_drop(killstreak_info, killstreaks_array, _id_86AF96FE008C96EE, _id_1EF9E61D95CBF8F7, "outside");
}

bot_killstreak_drop_hidden(killstreak_info, killstreaks_array, _id_86AF96FE008C96EE, _id_1EF9E61D95CBF8F7) {
  bot_killstreak_drop(killstreak_info, killstreaks_array, _id_86AF96FE008C96EE, _id_1EF9E61D95CBF8F7, "hidden");
}

bot_killstreak_drop(killstreak_info, killstreaks_array, _id_86AF96FE008C96EE, _id_1EF9E61D95CBF8F7, _id_F9CA2FDDC6A91AD8) {
  wait(randomintrange(2, 4));

  if(!isDefined(_id_F9CA2FDDC6A91AD8))
    _id_F9CA2FDDC6A91AD8 = "anywhere";

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks())
    return 1;

  if(isDefined(_id_86AF96FE008C96EE) && !self[[_id_86AF96FE008C96EE]]())
    return 0;

  ammo = self getweaponammoclip(killstreak_info.weapon) + self getweaponammostock(killstreak_info.weapon);

  if(ammo == 0) {
    foreach(_id_153FDEE861E0F06F in killstreaks_array) {
      if(isDefined(_id_153FDEE861E0F06F.streakname) && _id_153FDEE861E0F06F.streakname == killstreak_info.streakname)
        _id_153FDEE861E0F06F.available = 0;
    }

    return 1;
  }

  _id_A10B280FBAD02413 = undefined;

  if(_id_F9CA2FDDC6A91AD8 == "outside") {
    _id_B6D5157FD8707722 = [];
    _id_6F3D9EC6437C14F2 = scripts\mp\bots\bots_util::bot_get_nodes_in_cone(0, 750, 0.6, 1);

    foreach(node in _id_6F3D9EC6437C14F2) {
      if(nodeexposedtosky(node))
        _id_B6D5157FD8707722 = scripts\engine\utility::array_add(_id_B6D5157FD8707722, node);
    }

    if(_id_6F3D9EC6437C14F2.size > 5 && _id_B6D5157FD8707722.size > _id_6F3D9EC6437C14F2.size * 0.6) {
      _id_3465221989E8DFCE = scripts\engine\utility::get_array_of_closest(self.origin, _id_B6D5157FD8707722, undefined, undefined, undefined, 150);

      if(_id_3465221989E8DFCE.size > 0)
        _id_A10B280FBAD02413 = scripts\engine\utility::random(_id_3465221989E8DFCE);
      else
        _id_A10B280FBAD02413 = scripts\engine\utility::random(_id_B6D5157FD8707722);
    }
  } else if(_id_F9CA2FDDC6A91AD8 == "hidden") {
    _id_3778710DC16CFEEB = getnodesinradius(self.origin, 256, 0, 40);
    _id_170E87A3A1E8AF42 = self getnearestnode();

    if(isDefined(_id_170E87A3A1E8AF42)) {
      _id_DFF426CFCDDB03B2 = [];

      foreach(node in _id_3778710DC16CFEEB) {
        if(nodesvisible(_id_170E87A3A1E8AF42, node, 1))
          _id_DFF426CFCDDB03B2 = scripts\engine\utility::array_add(_id_DFF426CFCDDB03B2, node);
      }

      _id_A10B280FBAD02413 = self botnodepick(_id_DFF426CFCDDB03B2, 1, "node_hide");
    }
  }

  if(isDefined(_id_A10B280FBAD02413) || _id_F9CA2FDDC6A91AD8 == "anywhere") {
    self botsetflag("disable_movement", 1);

    if(isDefined(_id_A10B280FBAD02413))
      self botlookatpoint(_id_A10B280FBAD02413.origin, 2.45, "script_forced");

    bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, killstreak_info.weapon);
    wait 2.0;
    self botpressbutton("attack");
    wait 1.5;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon("none");
    self botsetflag("disable_movement", 0);
  }

  return 1;
}

bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, weapon_name) {
  bot_notify_streak_used(killstreak_info, killstreaks_array);
}

bot_notify_streak_used(killstreak_info, killstreaks_array) {
  if(isDefined(killstreak_info.isgimme) && killstreak_info.isgimme) {
    self notify("ks_action_6");
    return;
  }

  for(index = 1; index < 4; index++) {
    if(isDefined(killstreaks_array[index])) {
      if(isDefined(killstreaks_array[index].streakname)) {
        if(killstreaks_array[index].streakname == killstreak_info.streakname) {
          _id_7CDAAD0CCDB62848 = index + 2;
          self notify("ks_action_" + _id_7CDAAD0CCDB62848);
          return;
        }
      }
    }
  }
}

bot_killstreak_choose_loc_enemies(killstreak_info, killstreaks_array, _id_86AF96FE008C96EE, _id_1EF9E61D95CBF8F7) {
  wait(randomintrange(3, 5));

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    return;
  }
  _id_CF12256F80FF2408 = getzonenearest(self.origin);

  if(!isDefined(_id_CF12256F80FF2408)) {
    return;
  }
  self botsetflag("disable_movement", 1);
  bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, killstreak_info.weapon);
  wait 2;
  _id_B72A1D61D71C7FB3 = level.zonecount;
  _id_2099FADBFF6F1E22 = -1;
  _id_406B87B58C6D47FE = 0;
  _id_402C0A04744B46AD = [];
  _id_A04286DB27FDD0D4 = randomfloat(100) > 50;

  for(z = 0; z < _id_B72A1D61D71C7FB3; z++) {
    if(_id_A04286DB27FDD0D4)
      zone = _id_B72A1D61D71C7FB3 - 1 - z;
    else
      zone = z;

    if(zone != _id_CF12256F80FF2408 && botzonegetindoorpercent(zone) < 0.25) {
      _id_58EEA57628B0811E = botzonegetcount(zone, self.team, "enemy_predict");

      if(_id_58EEA57628B0811E > _id_406B87B58C6D47FE) {
        _id_2099FADBFF6F1E22 = zone;
        _id_406B87B58C6D47FE = _id_58EEA57628B0811E;
      }

      _id_402C0A04744B46AD = scripts\engine\utility::array_add(_id_402C0A04744B46AD, zone);
    }
  }

  if(_id_2099FADBFF6F1E22 >= 0)
    _id_891C8352F22D5DAE = getzoneorigin(_id_2099FADBFF6F1E22);
  else if(_id_402C0A04744B46AD.size > 0)
    _id_891C8352F22D5DAE = getzoneorigin(scripts\engine\utility::random(_id_402C0A04744B46AD));
  else
    _id_891C8352F22D5DAE = getzoneorigin(randomint(level.zonecount));

  _id_F7B5065A48A75B79 = (randomfloatrange(-500, 500), randomfloatrange(-500, 500), 0);
  self notify("confirm_location", _id_891C8352F22D5DAE + _id_F7B5065A48A75B79, randomintrange(0, 360));
  wait 1.0;
  self botsetflag("disable_movement", 0);
}

bot_think_watch_aerial_killstreak() {
  self notify("bot_think_watch_aerial_killstreak");
  self endon("bot_think_watch_aerial_killstreak");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(level.last_global_badplace_time))
    level.last_global_badplace_time = -10000;

  level.killstreak_global_bp_exists_for["allies"] = [];
  level.killstreak_global_bp_exists_for["axis"] = [];
  _id_D68763B6DC30A681 = 0;
  _id_6DE804C7FC796DA8 = randomfloatrange(0.05, 4.0);

  for(;;) {
    wait(_id_6DE804C7FC796DA8);
    _id_6DE804C7FC796DA8 = randomfloatrange(0.05, 4.0);

    if(scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      continue;
    }
    if(self botgetdifficultysetting("strategyLevel") == 0) {
      continue;
    }
    _id_FE0228CD32EE3063 = 0;

    if(isDefined(level.chopper) && level.chopper.team != self.team)
      _id_FE0228CD32EE3063 = 1;

    if(isDefined(level.lbsniper) && level.lbsniper.team != self.team)
      _id_FE0228CD32EE3063 = 1;

    if(!scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() || level.mapname != "mp_don3_mobile") {
      if(enemy_mortar_strike_exists(self.team)) {
        _id_FE0228CD32EE3063 = 1;
        try_place_global_badplace("mortar_strike", ::enemy_mortar_strike_exists);
      }

      if(enemy_switchblade_exists(self.team)) {
        _id_FE0228CD32EE3063 = 1;
        try_place_global_badplace("switchblade", ::enemy_switchblade_exists);
      }

      if(enemy_odin_assault_exists(self.team)) {
        _id_FE0228CD32EE3063 = 1;
        try_place_global_badplace("odin_assault", ::enemy_odin_assault_exists);
      }
    }

    _id_DB7E44B4F0554FEE = get_enemy_vanguard();

    if(isDefined(_id_DB7E44B4F0554FEE)) {
      _id_81FE00336FDC7313 = self getEye();

      if(scripts\engine\utility::within_fov(_id_81FE00336FDC7313, self getplayerangles(), _id_DB7E44B4F0554FEE.attackarrow.origin, self botgetfovdot())) {
        if(sighttracepassed(_id_81FE00336FDC7313, _id_DB7E44B4F0554FEE.attackarrow.origin, 0, self, _id_DB7E44B4F0554FEE.attackarrow))
          badplace_cylinder("vanguard_" + _id_DB7E44B4F0554FEE getentitynumber(), _id_6DE804C7FC796DA8 + 0.5, _id_DB7E44B4F0554FEE.attackarrow.origin, 200, 100, self.team);
      }
    }

    if(!_id_D68763B6DC30A681 && _id_FE0228CD32EE3063) {
      _id_D68763B6DC30A681 = 1;
      self botsetflag("hide_indoors", 1);
    }

    if(_id_D68763B6DC30A681 && !_id_FE0228CD32EE3063) {
      _id_D68763B6DC30A681 = 0;
      self botsetflag("hide_indoors", 0);
    }
  }
}

try_place_global_badplace(_id_205D69EB70594BB7, _id_C5A29305ADBE9B8B) {
  if(!isDefined(level.killstreak_global_bp_exists_for[self.team][_id_205D69EB70594BB7]))
    level.killstreak_global_bp_exists_for[self.team][_id_205D69EB70594BB7] = 0;

  if(!level.killstreak_global_bp_exists_for[self.team][_id_205D69EB70594BB7]) {
    level.killstreak_global_bp_exists_for[self.team][_id_205D69EB70594BB7] = 1;
    level thread monitor_enemy_dangerous_killstreak(self.team, _id_205D69EB70594BB7, _id_C5A29305ADBE9B8B);
  }
}

monitor_enemy_dangerous_killstreak(_id_2B4384D19A199121, _id_205D69EB70594BB7, _id_C5A29305ADBE9B8B) {
  wait_time = 0.5;

  while([[_id_C5A29305ADBE9B8B]](_id_2B4384D19A199121)) {
    if(gettime() > level.last_global_badplace_time + 4000) {
      badplace_global("", 5.0, _id_2B4384D19A199121, "only_sky");
      level.last_global_badplace_time = gettime();
    }

    wait(wait_time);
  }

  level.killstreak_global_bp_exists_for[_id_2B4384D19A199121][_id_205D69EB70594BB7] = 0;
}

enemy_mortar_strike_exists(_id_2B4384D19A199121) {
  if(isDefined(level.air_raid_active) && level.air_raid_active) {
    if(_id_2B4384D19A199121 != level.air_raid_team_called)
      return 1;
  }

  return 0;
}

enemy_switchblade_exists(_id_2B4384D19A199121) {
  if(isDefined(level.remotemissileinprogress)) {
    foreach(rocket in level.rockets) {
      if(isDefined(rocket.type) && rocket.type == "remote" && rocket.team != _id_2B4384D19A199121)
        return 1;
    }
  }

  return 0;
}

enemy_odin_assault_exists(_id_2B4384D19A199121) {
  foreach(player in level.players) {
    if(!level.teambased || isDefined(player.team) && _id_2B4384D19A199121 != player.team) {
      if(isDefined(player.odin) && player.odin.odintype == "odin_assault" && gettime() - player.odin.birthtime > 3000)
        return 1;
    }
  }

  return 0;
}

get_enemy_vanguard() {
  foreach(player in level.players) {
    if(!level.teambased || isDefined(player.team) && self.team != player.team) {
      if(isDefined(player.remoteuav) && player.remoteuav.helitype == "remote_uav")
        return player.remoteuav;
    }
  }

  return undefined;
}