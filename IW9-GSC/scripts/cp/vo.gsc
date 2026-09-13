/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vo.gsc
***********************************************/

_id_83B8144A47850CDD() {
  level.vo_priority_level = ["highest", "high", "medium", "low"];
  level.vo_alias_data = [];
  level.vo_categories = [];
  level.vo_category_last_played_time = [];
  level.vo_dialogue_prefix = [];
  level.vo_table = "cp/" + getDvar("ui_mapname") + "_vo_table.csv";
  level thread parse_vo_table();
  level thread nag_vo_handler();
}

_id_36BCBFD3365DC368() {
  init_vo_system();
  thread start_vo_system();
  level thread game_ended_vo_watcher();
}

init_vo_system() {
  vo_system = spawnStruct();
  vo_system.vo_currently_playing = undefined;
  vo_system.interrupt_vo = undefined;
  vo_system.is_playing = 0;
  vo_queue = [];

  if(isDefined(level.vo_priority_level)) {
    foreach(_id_18C057F630A76C65, _id_23118EE0BF20F77C in level.vo_priority_level)
    vo_queue[_id_23118EE0BF20F77C] = [];
  }

  vo_system.vo_queue = vo_queue;
  self.vo_system = vo_system;
  scripts\engine\utility::flag_init("vo_system_busy");
}

parse_vo_table() {
  table = level.vo_table;
  _id_CB89110314447B2F = 0;

  if(!tableexists(table)) {
    return;
  }
  for(;;) {
    id = tablelookupbyrow(table, _id_CB89110314447B2F, 0);

    if(id == "") {
      break;
    }

    _id_9A6B08F16368F69F = tablelookupbyrow(table, _id_CB89110314447B2F, 1);
    cooldown = int(tablelookupbyrow(table, _id_CB89110314447B2F, 2));
    chance_to_play = int(tablelookupbyrow(table, _id_CB89110314447B2F, 3));
    max_plays = int(tablelookupbyrow(table, _id_CB89110314447B2F, 4));
    category_1 = tablelookupbyrow(table, _id_CB89110314447B2F, 5);
    category_2 = tablelookupbyrow(table, _id_CB89110314447B2F, 6);
    waittillnotifyorflag = tablelookupbyrow(table, _id_CB89110314447B2F, 7);
    dialogueprefix = tablelookupbyrow(table, _id_CB89110314447B2F, 8);
    _id_79ADE81A56CBF98B = tablelookupbyrow(table, _id_CB89110314447B2F, 9);
    onlylocal = int(tablelookupbyrow(table, _id_CB89110314447B2F, 10));
    timeout = int(tablelookupbyrow(table, _id_CB89110314447B2F, 11));
    priority = tablelookupbyrow(table, _id_CB89110314447B2F, 12);
    _id_04C576D2CFBDBE34 = int(tablelookupbyrow(table, _id_CB89110314447B2F, 13));
    missingstub = tablelookupbyrow(table, _id_CB89110314447B2F, 15);
    register_vo(id, _id_9A6B08F16368F69F, cooldown, chance_to_play, max_plays, category_1, category_2, waittillnotifyorflag, dialogueprefix, _id_79ADE81A56CBF98B, onlylocal, timeout, priority, _id_04C576D2CFBDBE34, missingstub);

    if(_id_CB89110314447B2F % 5 == 1)
      wait 0.05;

    _id_CB89110314447B2F++;
  }
}

register_vo(id, _id_9A6B08F16368F69F, cooldown, chance_to_play, max_plays, category_1, category_2, waittillnotifyorflag, dialogueprefix, nextdialogue, onlylocal, timeout, priority, pause_time, missingstub) {
  struct = spawnStruct();

  if(isDefined(cooldown) && cooldown > 0) {
    struct.cooldown = cooldown;
    struct.lastplayedtime = 0;
  }

  if(isDefined(missingstub))
    struct.missingstub = missingstub;

  if(isDefined(pause_time) && pause_time > 0)
    struct.pause_time = pause_time;

  if(istrue(onlylocal))
    struct.onlylocal = 1;
  else
    struct.onlylocal = 0;

  if(isDefined(timeout) && timeout > 0)
    struct.timeout = timeout;

  if(isDefined(priority))
    struct.priority = priority;

  if(isDefined(max_plays) && max_plays > 0)
    struct.max_plays = max_plays;

  if(isDefined(chance_to_play) && chance_to_play > 0)
    struct.chance_to_play = chance_to_play;

  if(isDefined(waittillnotifyorflag) && waittillnotifyorflag != "")
    struct.waittillnotifyorflag = waittillnotifyorflag;

  if(isDefined(category_1) && category_1 != "") {
    if(!isDefined(level.vo_categories[category_1]))
      level.vo_categories[category_1] = [];

    struct.category_1 = category_1;
    level.vo_categories[category_1][level.vo_categories[category_1].size] = _id_9A6B08F16368F69F;

    if(!isDefined(level.vo_category_last_played_time[category_1]))
      level.vo_category_last_played_time[category_1] = 0;
  }

  if(isDefined(category_2) && category_2 != "") {
    if(!isDefined(level.vo_categories[category_2]))
      level.vo_categories[category_2] = [];

    struct.category_2 = category_2;
    level.vo_categories[category_2][level.vo_categories[category_2].size] = _id_9A6B08F16368F69F;

    if(!isDefined(level.vo_category_last_played_time[category_2]))
      level.vo_category_last_played_time[category_2] = 0;
  }

  if(isDefined(dialogueprefix) && dialogueprefix != "") {
    if(!isDefined(level.vo_dialogue_prefix[dialogueprefix]))
      level.vo_dialogue_prefix[dialogueprefix] = [];

    struct.dialogueprefix = dialogueprefix;
    level.vo_dialogue_prefix[_id_9A6B08F16368F69F] = dialogueprefix;
  }

  if(isDefined(nextdialogue) && nextdialogue != "")
    struct.nextdialogue = nextdialogue;

  level.vo_alias_data[_id_9A6B08F16368F69F] = struct;
}

start_vo_system() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(is_vo_system_busy()) {
      if(scripts\engine\utility::flag_exist("vo_system_busy"))
        scripts\engine\utility::flag_waitopen("vo_system_busy");
    }

    _id_2EF8438B8626C369 = get_vo_to_play();

    if(!isDefined(_id_2EF8438B8626C369)) {
      set_vo_system_playing(0);
      self waittill("play_VO_system");

      if(is_vo_system_paused())
        self waittill("unpause_VO_system");

      continue;
    }

    play_vo_system(_id_2EF8438B8626C369);
  }
}

play_vo_system(_id_2EF8438B8626C369) {
  self endon("disconnect");
  set_vo_system_playing(1);
  set_vo_currently_playing(_id_2EF8438B8626C369);
  play_vo(_id_2EF8438B8626C369);
  pause_between_vo(_id_2EF8438B8626C369);
  unset_vo_currently_playing();
}

get_vo_to_play() {
  _id_2EF8438B8626C369 = retrieve_interrupt_vo();

  if(isDefined(_id_2EF8438B8626C369))
    return _id_2EF8438B8626C369;

  if(isDefined(level.vo_priority_level)) {
    foreach(_id_18C057F630A76C65, _id_23118EE0BF20F77C in level.vo_priority_level) {
      _id_2EF8438B8626C369 = retrieve_vo_from_queue(_id_23118EE0BF20F77C);

      if(isDefined(_id_2EF8438B8626C369))
        return _id_2EF8438B8626C369;
    }
  }

  return undefined;
}

retrieve_interrupt_vo() {
  interrupt_vo = self.vo_system.interrupt_vo;
  reset_interrupt_vo();
  return interrupt_vo;
}

reset_interrupt_vo() {
  self.vo_system.interrupt_vo = undefined;
}

retrieve_vo_from_queue(priority) {
  remove_expired_vo_from_queue(priority);
  return pop_first_vo_out_of_queue(priority);
}

pop_first_vo_out_of_queue(priority) {
  _id_BCDB765EA42A9545 = self.vo_system.vo_queue[priority][0];

  if(!isDefined(_id_BCDB765EA42A9545))
    return _id_BCDB765EA42A9545;

  _id_055F75D9F16D814F = [];

  for(_id_18C057F630A76C65 = 1; _id_18C057F630A76C65 < self.vo_system.vo_queue[priority].size; _id_18C057F630A76C65++) {
    if(!isDefined(self.vo_system.vo_queue[priority][_id_18C057F630A76C65])) {
      break;
    }

    _id_055F75D9F16D814F[_id_18C057F630A76C65 - 1] = self.vo_system.vo_queue[priority][_id_18C057F630A76C65];
  }

  self.vo_system.vo_queue[priority] = _id_055F75D9F16D814F;
  return _id_BCDB765EA42A9545;
}

remove_expired_vo_from_queue(priority) {
  current_time = gettime();
  _id_055F75D9F16D814F = [];

  foreach(_id_18C057F630A76C65, _id_5564A66C3EC1C07B in self.vo_system.vo_queue[priority]) {
    if(!vo_expired(_id_5564A66C3EC1C07B, current_time)) {
      _id_055F75D9F16D814F[_id_055F75D9F16D814F.size] = self.vo_system.vo_queue[priority][_id_18C057F630A76C65];
      continue;
    }
  }

  self.vo_system.vo_queue[priority] = _id_055F75D9F16D814F;
}

vo_expired(_id_5564A66C3EC1C07B, current_time) {
  return current_time > _id_5564A66C3EC1C07B.expire_time;
}

set_vo_system_playing(_id_E3108E412AFB3811) {
  if(!isPlayer(self) || !isDefined(self.vo_system)) {
    return;
  }
  self.vo_system.is_playing = _id_E3108E412AFB3811;
}

is_vo_system_paused() {
  return istrue(self.pause_vo_system);
}

is_vo_system_busy() {
  return scripts\engine\utility::flag("vo_system_busy");
}

set_vo_system_busy(_id_E3108E412AFB3811) {
  level.vo_system_busy = _id_E3108E412AFB3811;

  if(!_id_E3108E412AFB3811)
    scripts\engine\utility::flag_clear("vo_system_busy");
  else
    scripts\engine\utility::flag_set("vo_system_busy");
}

set_vo_currently_playing(_id_2EF8438B8626C369) {
  self.vo_system.vo_currently_playing = _id_2EF8438B8626C369;
}

game_ended_vo_watcher() {
  _id_FCDD6DE74EFE1B44 = "";
  level waittill("game_ended");

  foreach(player in level.players) {
    foreach(_id_23118EE0BF20F77C in level.vo_priority_level) {
      if(isDefined(player.vo_system.vo_queue[_id_23118EE0BF20F77C]) && player.vo_system.vo_queue[_id_23118EE0BF20F77C].size > 0) {
        foreach(_id_5564A66C3EC1C07B in player.vo_system.vo_queue[_id_23118EE0BF20F77C]) {
          if(isDefined(_id_5564A66C3EC1C07B)) {
            if(soundexists(_id_5564A66C3EC1C07B.alias))
              player stoplocalsound(_id_5564A66C3EC1C07B.alias);
          }
        }

        player.vo_system.vo_queue[_id_23118EE0BF20F77C] = [];
      }
    }

    if(isDefined(level.dialogue_arr) && level.dialogue_arr.size > 0) {
      foreach(alias in level.dialogue_arr) {
        if(issubstr(alias, "pg_"))
          player stoplocalsound(alias);

        if(soundexists(player.vo_prefix + alias))
          player stoplocalsound(player.vo_prefix + alias);

        if(soundexists(player.vo_prefix + "plr_" + alias))
          player stoplocalsound(player.vo_prefix + "plr_" + alias);
      }
    }

    if(isDefined(player.current_vo_queue) && player.current_vo_queue.size > 0) {
      foreach(_id_F7806D4CF24AACD3 in player.current_vo_queue) {
        if(isDefined(_id_F7806D4CF24AACD3)) {
          if(soundexists(_id_F7806D4CF24AACD3)) {
            player stoplocalsound(_id_F7806D4CF24AACD3);
            continue;
          }

          if(soundexists(player.vo_prefix + _id_F7806D4CF24AACD3)) {
            player stoplocalsound(player.vo_prefix + _id_F7806D4CF24AACD3);
            continue;
          }

          if(soundexists(player.vo_prefix + "plr_" + _id_F7806D4CF24AACD3))
            player stoplocalsound(player.vo_prefix + "plr_" + _id_F7806D4CF24AACD3);
        }
      }
    }

    if(!isDefined(player.vo_prefix)) {
      return;
    }
    switch (player.vo_prefix) {
      case "p1_":
        _id_FCDD6DE74EFE1B44 = "_valley_girl";
        break;
      case "p2_":
        _id_FCDD6DE74EFE1B44 = "_nerd";
        break;
      case "p3_":
        _id_FCDD6DE74EFE1B44 = "_rapper";
        break;
      case "p4_":
        _id_FCDD6DE74EFE1B44 = "_jock";
        break;
      case "p5_":
        _id_FCDD6DE74EFE1B44 = "_jock";
        break;
    }

    _id_ACA2E0282CBD3CFE = "mus_zombies" + _id_FCDD6DE74EFE1B44;

    if(soundexists(_id_ACA2E0282CBD3CFE))
      player stoplocalsound("mus_zombies" + _id_FCDD6DE74EFE1B44);

    _id_ACA2E0282CBD3CFE = "mus_zombies" + _id_FCDD6DE74EFE1B44 + "_lsrs";

    if(soundexists(_id_ACA2E0282CBD3CFE))
      player stoplocalsound("mus_zombies" + _id_FCDD6DE74EFE1B44 + "_lsrs");
  }
}

play_vo(_id_2EF8438B8626C369) {
  self endon("interrupt_current_VO");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(self.sessionstate != "playing") {
    return;
  }
  alias = _id_2EF8438B8626C369.alias;

  if(!soundexists(alias)) {
    if(isDefined(level.vo_alias_data[alias]) && isDefined("level.vo_alias_data[alias].missingStub")) {} else {}

    wait 0.1;
    return;
  }

  self.vo_system_playing_vo = 1;

  if(scripts\cp\utility::is_playing_pain_breathing_sfx(self)) {
    _id_BCCC90D7DF4FE4B7 = scripts\cp\utility::get_pain_breathing_sfx_alias(self);

    if(isDefined(_id_BCCC90D7DF4FE4B7))
      self stoplocalsound(_id_BCCC90D7DF4FE4B7);
  }

  if(isDefined(_id_2EF8438B8626C369.basealias))
    _id_E77296B7F0BA0679 = _id_2EF8438B8626C369.basealias;
  else
    _id_E77296B7F0BA0679 = alias;

  foreach(player in level.players) {
    if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
      continue;
    }
    if(isDefined(player.current_vo_queue))
      player.current_vo_queue = scripts\engine\utility::array_add(player.current_vo_queue, _id_E77296B7F0BA0679);

    if(player == self) {
      if(isDefined(level.get_alias_2d_func))
        _id_C3EC9CD6DA50D1B2 = [[level.get_alias_2d_func]](player, alias, _id_E77296B7F0BA0679);
      else
        _id_C3EC9CD6DA50D1B2 = get_alias_2d_version(player, alias, _id_E77296B7F0BA0679);

      if(isDefined(_id_C3EC9CD6DA50D1B2))
        player scripts\cp\utility::playlocalsound_safe(_id_C3EC9CD6DA50D1B2);
      else
        player scripts\cp\utility::playlocalsound_safe(alias);

      continue;
    }

    if(!istrue(_id_2EF8438B8626C369.only_local) && soundexists(alias))
      self playsoundtoplayer(alias, player);
  }

  foreach(category in _id_2EF8438B8626C369.categories)
  level.vo_category_last_played_time[category] = gettime();

  if(!isDefined(self.num_of_plays[_id_E77296B7F0BA0679]))
    self.num_of_plays[_id_E77296B7F0BA0679] = 1;
  else
    self.num_of_plays[_id_E77296B7F0BA0679]++;

  wait(get_sound_length(alias));
  self.vo_system_playing_vo = 0;
}

alias_2d_version_exists(player, alias) {
  _id_89EBBF7A77D639F9 = get_alias_2d_version(player, alias);
  return soundexists(_id_89EBBF7A77D639F9);
}

get_alias_2d_version(player, alias, _id_81AD18B8E83E126B) {
  _id_F6F217EA2AA761F9 = strtok(alias, "_");

  if(_id_F6F217EA2AA761F9[0] == "ww" || _id_F6F217EA2AA761F9[0] == "dj" || _id_F6F217EA2AA761F9[0] == "ks")
    return alias;
  else {
    if(isDefined(player.vo_prefix))
      _id_635A078D549357E2 = player.vo_prefix + "plr_" + _id_81AD18B8E83E126B;
    else
      _id_635A078D549357E2 = "plr_" + _id_81AD18B8E83E126B;

    if(soundexists(_id_635A078D549357E2))
      return _id_635A078D549357E2;

    return undefined;
  }
}

get_alias_3d_version(player, alias) {
  if(issubstr(alias, "ww_") || issubstr(alias, "dj_") || issubstr(alias, "p1_") || issubstr(alias, "p2_") || issubstr(alias, "p3_") || issubstr(alias, "p4_") || issubstr(alias, "jaroslav_anc"))
    return alias;

  _id_D76B0A8E2967C78D = getsubstr(alias, player.vo_prefix.size);
  return player.vo_prefix + _id_D76B0A8E2967C78D;
}

get_sound_length(alias) {
  if(!soundexists(alias))
    return 0;

  _id_0E9ADC33E7669585 = lookupsoundlength(alias) / 1000 + 0.4;

  if(getdvarint("loc_language") != 0 && getdvarint("loc_language") != 1)
    _id_0E9ADC33E7669585 = _id_0E9ADC33E7669585 + 1.5;

  _id_086141E72C449A0F = get_length_from_table(alias);

  if(isDefined(_id_086141E72C449A0F) && _id_086141E72C449A0F != 0)
    _id_0E9ADC33E7669585 = _id_086141E72C449A0F;

  return _id_0E9ADC33E7669585;
}

pause_between_vo(_id_2EF8438B8626C369) {
  if(is_vo_system_paused())
    self waittill("unpause_VO_system");

  if(_id_2EF8438B8626C369.pause_time > 0)
    wait(_id_2EF8438B8626C369.pause_time);
}

unset_vo_currently_playing() {
  self.vo_system.vo_currently_playing = undefined;
}

try_to_play_vo_on_team(alias, team, _id_EC7E52B2773F5000, _id_4A4111C81451CA93, _id_E2CE4E21E9100CB9) {
  players = scripts\cp\utility::getplayersinteam(team);

  if(!isDefined(alias)) {
    return;
  }
  if(players.size <= 0) {
    return;
  }
  if(!istrue(_id_EC7E52B2773F5000)) {
    level thread _id_AE413FF331FAA146(alias);

    if(isPlayer(self) || self == level || !isent(self)) {
      foreach(player in players)
      player thread play_cp_comment_vo(alias, "cp_comment_vo", "highest", 10, 0, 0, 1);
    } else
      thread scripts\cp\utility::playsoundatpos_safe(self.origin, alias);

    wait(get_sound_length(alias));
  } else {
    _id_EE94080F12348D8A = 45;

    if(isDefined(_id_E2CE4E21E9100CB9))
      _id_EE94080F12348D8A = _id_E2CE4E21E9100CB9;

    _id_5B67F9F4C3A53FB3 = 60;

    if(isDefined(_id_4A4111C81451CA93))
      _id_5B67F9F4C3A53FB3 = _id_4A4111C81451CA93;

    foreach(player in players)
    player thread add_to_nag_vo(alias, "cp_comment_vo", _id_5B67F9F4C3A53FB3, _id_EE94080F12348D8A, 6, 1);
  }
}

_id_AE413FF331FAA146(alias) {
  level endon("game_ended");
  level notify("delayvoplaying");
  level endon("delayvoplaying");
  level.isteamvoplaying = 1;
  wait(get_sound_length(alias));
  level.isteamvoplaying = 0;
}

try_to_play_vo_for_one_player(alias, player, _id_EC7E52B2773F5000, _id_4A4111C81451CA93, _id_E2CE4E21E9100CB9) {
  if(!isDefined(alias)) {
    return;
  }
  if(!isDefined(player)) {
    return;
  }
  if(!istrue(_id_EC7E52B2773F5000))
    player thread try_to_play_vo(alias, "cp_comment_vo", "highest", 10, 0, 0, 1, 100);
  else {
    _id_EE94080F12348D8A = 45;

    if(isDefined(_id_E2CE4E21E9100CB9))
      _id_EE94080F12348D8A = _id_E2CE4E21E9100CB9;

    _id_5B67F9F4C3A53FB3 = 60;

    if(isDefined(_id_4A4111C81451CA93))
      _id_5B67F9F4C3A53FB3 = _id_4A4111C81451CA93;

    player thread add_to_nag_vo(alias, "cp_comment_vo", _id_5B67F9F4C3A53FB3, _id_EE94080F12348D8A, 6, 1);
  }
}

try_to_play_vo_on_all_players(alias, _id_EC7E52B2773F5000) {
  if(!isDefined(alias)) {
    return;
  }
  if(!isDefined(level.players)) {
    return;
  }
  if(!istrue(_id_EC7E52B2773F5000)) {
    foreach(player in level.players)
    player thread try_to_play_vo(alias, "zmb_comment_vo", "highest", 10, 0, 0, 1, 100);
  } else {
    foreach(player in level.players)
    player thread add_to_nag_vo(alias, "zmb_comment_vo", 60, 45, 6, 1);
  }
}

_id_775CD164C569E279(alias, player, priority) {
  level endon("game_ended");
  _id_46F432042B3473D8 = get_sound_length(alias);
  waittime = gettime() + _id_46F432042B3473D8 + 3000;

  while(istrue(level.isteamvoplaying) && gettime() < waittime)
    waitframe();

  level._id_BFE5BB3BA83502E3 = 1;

  if(!isDefined(priority))
    priority = "high";

  level._id_BFE5BB3BA83502E3 = 1;
  wait 0.1;

  if(isDefined(player)) {
    player.bcdisabled = 1;
    player try_to_play_vo(alias, "cp_comment_vo", priority, 10, 0, 0, 1, 100);
    player.bcdisabled = undefined;
  } else {
    foreach(player in level.players)
    player.bcdisabled = 1;

    level try_to_play_vo_on_team(alias, "allies");
    wait 0.1;

    foreach(player in level.players)
    player.bcdisabled = undefined;
  }

  level._id_BFE5BB3BA83502E3 = 0;
}

try_to_play_vo(_id_D35946B8550701A5, vo_type, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local, chance_to_play) {
  _id_C95BEF4257B44781 = isDefined(level.vo_alias_data[_id_D35946B8550701A5]);
  _id_42547671DF42D8DB = scripts\engine\utility::ter_op(_id_C95BEF4257B44781, level.vo_alias_data[_id_D35946B8550701A5], undefined);

  if(!isDefined(chance_to_play)) {
    if(_id_C95BEF4257B44781) {
      if(isDefined(_id_42547671DF42D8DB.chance_to_play))
        chance_to_play = _id_42547671DF42D8DB.chance_to_play;
    } else
      chance_to_play = 100;
  }

  if(randomint(100) > chance_to_play) {
    return;
  }
  if(should_play_vo(_id_D35946B8550701A5)) {
    if(!isDefined(pause_time) && _id_C95BEF4257B44781 && isDefined(_id_42547671DF42D8DB.pause_time))
      pause_time = _id_42547671DF42D8DB.pause_time;

    if(!isDefined(only_local) && _id_C95BEF4257B44781 && isDefined(_id_42547671DF42D8DB.only_local))
      only_local = _id_42547671DF42D8DB.onlylocal;

    if(!isDefined(timeout) && _id_C95BEF4257B44781 && isDefined(_id_42547671DF42D8DB.timeout))
      timeout = _id_42547671DF42D8DB.timeout;

    if(!isDefined(priority) && _id_C95BEF4257B44781 && isDefined(_id_42547671DF42D8DB.priority))
      priority = _id_42547671DF42D8DB.priority;

    categories = get_categories_from_alias(_id_D35946B8550701A5);

    foreach(category in categories)
    level.vo_category_last_played_time[category] = gettime();

    if(_id_C95BEF4257B44781 && isDefined(_id_42547671DF42D8DB.lastplayedtime))
      _id_42547671DF42D8DB.lastplayedtime = gettime();

    thread add_to_vo_queue(_id_D35946B8550701A5, vo_type, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local);
  }
}

should_play_vo(_id_D35946B8550701A5) {
  if(!isDefined(level.vo_alias_data[_id_D35946B8550701A5]))
    return 1;

  time = gettime();

  if(isDefined(level.vo_alias_data[_id_D35946B8550701A5].cooldown) && isDefined(level.vo_alias_data[_id_D35946B8550701A5].lastplayedtime)) {
    if(time < level.vo_alias_data[_id_D35946B8550701A5].lastplayedtime + level.vo_alias_data[_id_D35946B8550701A5].cooldown * 1000)
      return 0;
  }

  categories = get_categories_from_alias(_id_D35946B8550701A5);

  foreach(category in categories) {
    cooldown = scripts\engine\utility::ter_op(isDefined(level.vo_alias_data[_id_D35946B8550701A5].cooldown), level.vo_alias_data[_id_D35946B8550701A5].cooldown, 30);

    if(time < level.vo_category_last_played_time[category] + cooldown * 1000)
      return 0;
  }

  if(isDefined(level.vo_alias_data[_id_D35946B8550701A5].max_plays)) {
    if(!isDefined(self.num_of_plays))
      self.num_of_plays = [];

    if(!isDefined(self.num_of_plays[_id_D35946B8550701A5]))
      self.num_of_plays[_id_D35946B8550701A5] = 0;

    if(self.num_of_plays[_id_D35946B8550701A5] < level.vo_alias_data[_id_D35946B8550701A5].max_plays)
      return 1;
    else
      return 0;
  } else
    return 1;
}

get_categories_from_alias(_id_D35946B8550701A5) {
  if(!isDefined(level.vo_categories))
    return [];

  keys = getarraykeys(level.vo_categories);
  _id_6D906809844C7CB1 = [];

  foreach(key in keys) {
    if(scripts\engine\utility::array_contains(level.vo_categories[key], _id_D35946B8550701A5))
      _id_6D906809844C7CB1[_id_6D906809844C7CB1.size] = key;
  }

  return _id_6D906809844C7CB1;
}

play_cp_comment_vo(_id_D35946B8550701A5, vo_type, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local) {
  level endon("game_ended");
  level.announcer_vo_playing = 1;
  _id_F104A131C0A929A2 = level.players;

  if(isPlayer(self))
    _id_F104A131C0A929A2 = [self];

  foreach(player in _id_F104A131C0A929A2) {
    if(!isDefined(player)) {
      continue;
    }
    if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
      continue;
    }
    _id_2EF8438B8626C369 = create_vo_data(_id_D35946B8550701A5, timeout, pause_time, only_local);
    player thread play_vo_system(_id_2EF8438B8626C369);
  }

  wait(get_sound_length(_id_D35946B8550701A5));

  foreach(player in _id_F104A131C0A929A2)
  player set_vo_system_playing(0);

  level.announcer_vo_playing = 0;
}

add_to_vo_queue(_id_D35946B8550701A5, vo_type, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local) {
  if(isDefined(vo_type) && isDefined(level.vo_functions[vo_type]))
    self thread[[level.vo_functions[vo_type]]](_id_D35946B8550701A5, vo_type, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local);
  else if(isDefined(vo_type) && vo_type == "cp_comment_vo")
    play_cp_comment_vo(_id_D35946B8550701A5, vo_type, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local);
  else if(isPlayer(self)) {
    if(isDefined(self.vo_prefix))
      alias = self.vo_prefix + _id_D35946B8550701A5;
    else
      alias = _id_D35946B8550701A5;

    thread play_vo_on_player(alias, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local, _id_D35946B8550701A5);
  } else {
    alias = _id_D35946B8550701A5;
    level thread play_vo_on_all_players(alias, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local, _id_D35946B8550701A5);
  }
}

play_vo_on_all_players(alias, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local, basealias) {
  foreach(player in level.players)
  player add_to_vo_system(alias, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local, basealias);
}

play_vo_on_player(alias, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local, basealias) {
  add_to_vo_system(alias, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local, basealias);
}

add_to_vo_system(alias, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local, basealias) {
  if(!isDefined(self.current_vo_queue))
    self.current_vo_queue = [];

  thread add_to_vo_system_internal(alias, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local, basealias);
}

add_to_vo_system_internal(alias, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local, basealias) {
  priority = get_validated_priority(priority);
  _id_5564A66C3EC1C07B = create_vo_data(alias, timeout, pause_time, only_local, basealias);

  if(should_interrupt_vo_system(_id_3D84B5D3F727E22C)) {
    add_to_interrupt_vo(_id_5564A66C3EC1C07B);

    if(is_vo_system_playing())
      interrupt_current_vo();
  } else
    add_to_queue_at_priority(_id_5564A66C3EC1C07B, priority);

  if(!is_vo_system_playing())
    notify_system_to_grab_next_vo_from_queue();
}

get_validated_priority(priority) {
  if(!isDefined(priority))
    return level.vo_priority_level[level.vo_priority_level.size - 1];

  return priority;
}

create_vo_data(alias, timeout, pause_time, only_local, basealias) {
  _id_ACF8C89042BD6D7A = 999;
  _id_356385D16D2BFE7A = 1.5;
  _id_2909AC11EC70C778 = 3;
  _id_5564A66C3EC1C07B = spawnStruct();
  _id_5564A66C3EC1C07B.alias = alias;
  _id_5564A66C3EC1C07B.categories = get_categories_from_alias(alias);
  _id_5564A66C3EC1C07B.basealias = basealias;

  if(!isDefined(timeout))
    timeout = _id_ACF8C89042BD6D7A;

  _id_5564A66C3EC1C07B.expire_time = gettime() + timeout * 1000;

  if(!isDefined(pause_time))
    pause_time = randomfloatrange(_id_356385D16D2BFE7A, _id_2909AC11EC70C778);

  _id_5564A66C3EC1C07B.pause_time = pause_time;

  if(istrue(only_local))
    _id_5564A66C3EC1C07B.only_local = 1;
  else
    _id_5564A66C3EC1C07B.only_local = 0;

  return _id_5564A66C3EC1C07B;
}

should_interrupt_vo_system(_id_3D84B5D3F727E22C) {
  return isDefined(_id_3D84B5D3F727E22C) && _id_3D84B5D3F727E22C;
}

add_to_interrupt_vo(_id_5564A66C3EC1C07B) {
  self.vo_system.interrupt_vo = _id_5564A66C3EC1C07B;
}

is_vo_system_playing() {
  return istrue(self.vo_system.is_playing);
}

interrupt_current_vo() {
  _id_1D8A79FC1B6B46CF = get_current_vo_alias();

  if(isDefined(_id_1D8A79FC1B6B46CF))
    self stoplocalsound(_id_1D8A79FC1B6B46CF);

  self notify("interrupt_current_VO");
}

get_current_vo_alias() {
  if(isDefined(self.vo_system)) {
    if(isDefined(self.vo_system.vo_currently_playing)) {
      if(isDefined(self.vo_system.vo_currently_playing.alias))
        return self.vo_system.vo_currently_playing.alias;
    }
  }

  return undefined;
}

add_to_queue_at_priority(_id_5564A66C3EC1C07B, priority) {
  self.vo_system.vo_queue[priority][self.vo_system.vo_queue[priority].size] = _id_5564A66C3EC1C07B;
}

notify_system_to_grab_next_vo_from_queue() {
  self notify("play_VO_system");
}

remove_vo_data(_id_69B068FE56FDAD37, priority) {
  _id_055F75D9F16D814F = [];

  foreach(_id_18C057F630A76C65, _id_5564A66C3EC1C07B in self.vo_system.vo_queue[priority]) {
    if(!(_id_5564A66C3EC1C07B.alias == self.vo_prefix + _id_69B068FE56FDAD37 || _id_5564A66C3EC1C07B.alias == self.vo_prefix + "plr_" + _id_69B068FE56FDAD37))
      _id_055F75D9F16D814F[_id_055F75D9F16D814F.size] = self.vo_system.vo_queue[priority][_id_18C057F630A76C65];
  }

  self.vo_system.vo_queue[priority] = _id_055F75D9F16D814F;
}

pause_vo_system(_id_2A29B237DCC66FE5) {
  if(_id_2A29B237DCC66FE5.size == 1)
    _id_2A29B237DCC66FE5[0].pause_vo_system = 1;
  else {
    foreach(player in _id_2A29B237DCC66FE5)
    player.pause_vo_system = 1;
  }
}

unpause_vo_system(_id_2A29B237DCC66FE5) {
  foreach(player in _id_2A29B237DCC66FE5)
  player.pause_vo_system = 0;

  foreach(player in _id_2A29B237DCC66FE5)
  player notify("unpause_VO_system");
}

nag_vo_handler() {
  level endon("game_ended");

  if(!isDefined(level.nag_vo)) {
    level.nag_vo = [];
    level.nag_vo_never_play_again = [];
    level.pause_nag_vo = 0;
  }

  _id_4A4111C81451CA93 = 60;

  for(;;) {
    while(level.pause_nag_vo)
      wait 0.1;

    time = gettime();

    foreach(alias, _id_380E909D074FF217 in level.nag_vo) {
      if(time > _id_380E909D074FF217.next_play_time) {
        if(isDefined(_id_380E909D074FF217.scope))
          _id_380E909D074FF217.scope try_to_play_vo(alias, _id_380E909D074FF217.vo_type, "low", 3, 0, 0, _id_380E909D074FF217.only_local);
        else
          level try_to_play_vo(alias, _id_380E909D074FF217.vo_type, "low", 3, 0, 0, _id_380E909D074FF217.only_local);

        _id_380E909D074FF217.times_played++;

        if(_id_380E909D074FF217.max_times != -1 && _id_380E909D074FF217.max_times <= _id_380E909D074FF217.times_played)
          remove_from_nag_vo(alias);

        _id_380E909D074FF217.next_play_time = time + _id_380E909D074FF217.cooldown * min(_id_380E909D074FF217.times_played, 3) * 1000;
        wait(_id_4A4111C81451CA93);
      }
    }

    wait 1;
  }
}

add_to_nag_vo(alias, vo_type, _id_6F89268F7DDF91D0, _id_01E486B6DA797B22, max_times, only_local) {
  if(!isDefined(level.nag_vo)) {
    level.nag_vo = [];
    level.nag_vo_never_play_again = [];
    level.pause_nag_vo = 0;
  }

  if(isDefined(level.nag_vo[alias])) {
    return;
  }
  if(isDefined(level.nag_vo_never_play_again[alias])) {
    return;
  }
  if(!isDefined(_id_6F89268F7DDF91D0))
    _id_6F89268F7DDF91D0 = 60;

  if(!isDefined(vo_type))
    vo_type = "zmb_comment_vo";

  _id_824F2B2E30140569 = undefined;

  if(isPlayer(self))
    _id_824F2B2E30140569 = self;

  _id_A68342C9C3067EF7 = spawnStruct();
  _id_A68342C9C3067EF7.times_played = 0;
  _id_A68342C9C3067EF7.cooldown = _id_6F89268F7DDF91D0;
  _id_A68342C9C3067EF7.vo_type = vo_type;

  if(isDefined(_id_824F2B2E30140569))
    _id_A68342C9C3067EF7.scope = _id_824F2B2E30140569;

  if(isDefined(only_local))
    _id_A68342C9C3067EF7.only_local = only_local;
  else
    _id_A68342C9C3067EF7.only_local = 0;

  if(isDefined(_id_01E486B6DA797B22))
    _id_A68342C9C3067EF7.next_play_time = gettime() + _id_01E486B6DA797B22 * 1000;
  else
    _id_A68342C9C3067EF7.next_play_time = 0;

  if(isDefined(max_times))
    _id_A68342C9C3067EF7.max_times = max_times;
  else
    _id_A68342C9C3067EF7.max_times = -1;

  level.nag_vo[alias] = _id_A68342C9C3067EF7;
}

remove_from_nag_vo(alias, _id_8A46C5A3EB5E99BE) {
  level.nag_vo = scripts\engine\utility::array_remove_index(level.nag_vo, alias, 1);

  if(istrue(_id_8A46C5A3EB5E99BE))
    level.nag_vo_never_play_again[alias] = 1;
}

get_length_from_table(alias) {
  _id_46F432042B3473D8 = tablelookup("cp/cp_vo_lookup.csv", 0, alias, 1);

  if(isDefined(_id_46F432042B3473D8)) {
    _id_46F432042B3473D8 = float(_id_46F432042B3473D8);
    return _id_46F432042B3473D8;
  }

  return undefined;
}

_id_929BB46251E5E4F2(_id_394466C2DDB208CB, _id_A1823E6B1CB4B46D, _id_3EF0FDCEE94CADFF, _id_C1074AB6CAC2169F) {
  if(scripts\cp_mp\calloutmarkerping::_id_C648F0FD527E089A(_id_A1823E6B1CB4B46D)) {
    return;
  }
  if(scripts\cp_mp\calloutmarkerping::_id_D3789A9A4BE5DF2E(_id_A1823E6B1CB4B46D)) {
    ent = self calloutmarkerping_getEnt(_id_394466C2DDB208CB);

    if(isDefined(ent)) {
      if(scripts\cp_mp\calloutmarkerping::_calloutmarkerping_isenemy(ent, self)) {
        _id_5F2CBFBAB811D7A4(_id_394466C2DDB208CB, _id_A1823E6B1CB4B46D, _id_3EF0FDCEE94CADFF, _id_C1074AB6CAC2169F, ent);
        return;
      }

      if(!isPlayer(ent)) {
        level notify("player_pinged_object", self, ent, _id_394466C2DDB208CB);
        return;
      }

      return;
      return;
    }
  } else {
    if(scripts\cp_mp\calloutmarkerping::_id_74EC310D8F99B6E2(_id_A1823E6B1CB4B46D)) {
      return;
    }
    switch (_id_A1823E6B1CB4B46D) {
      case 6:
        break;
      case 5:
        break;
      case 2:
        break;
      case 4:
        break;
    }

    return;
    return;
  }
}

_id_5F2CBFBAB811D7A4(_id_394466C2DDB208CB, _id_A1823E6B1CB4B46D, _id_3EF0FDCEE94CADFF, _id_C1074AB6CAC2169F, ent) {
  level notify("player_pinged_enemy", self, ent, _id_394466C2DDB208CB);
}

_id_6DE0BA6C3C3B7E34(alias) {
  if(!scripts\engine\utility::flag_exist("overlord_vo_cleared"))
    scripts\engine\utility::flag_init("overlord_vo_cleared");

  scripts\engine\utility::flag_clear("overlord_vo_cleared");
  _id_4AB28BC6D5AD3D7A = lookupsoundlength(alias) / 1000;
  wait(_id_4AB28BC6D5AD3D7A);
  scripts\engine\utility::flag_set("overlord_vo_cleared");
}

_id_E4F581FD683684A5() {
  wait 0.05;

  if(istrue(level._id_BFE5BB3BA83502E3))
    scripts\engine\utility::flag_wait("overlord_vo_cleared");

  wait 0.05;
}