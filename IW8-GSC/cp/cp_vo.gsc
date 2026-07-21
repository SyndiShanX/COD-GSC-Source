/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_vo.gsc
***********************************************/

initcpvosystem() {
  level.vo_priority_level = ["_encstr_B23608E248D4CB37E891", "_encstr_9ACC05B41B7F32", "_encstr_AB5E07609A5B7368E5", "_encstr_BE19041BDEDD"];
  level.vo_alias_data = [];
  level.vo_categories = [];
  level.vo_category_last_played_time = [];
  level.vo_dialogue_prefix = [];
  level.vo_table = "_encstr_911904535326" + getDvar("_encstr_9A050BF1B1D21107C3D5B601E0") + "_encstr_8BC50E3F8D18B1BBDF39BAD248266F33";
  level thread parse_vo_table();
  level thread nag_vo_handler();
}

initandstartvosystem() {
  init_vo_system();
  thread start_vo_system();
  level thread game_ended_vo_watcher();
}

init_vo_system() {
  var_0 = spawnStruct();
  var_0.vo_currently_playing = undefined;
  var_0.interrupt_vo = undefined;
  var_0.is_playing = 0;
  var_1 = [];

  if(isDefined(level.vo_priority_level)) {
    foreach(var_4, var_3 in level.vo_priority_level)
    var_1[var_3] = [];
  }

  var_0.vo_queue = var_1;
  self.vo_system = var_0;
  scripts\engine\utility::flag_init("_encstr_8F1B0FDE104E6FC07F30DA5281B53B9762");
}

parse_vo_table() {
  var_0 = level.vo_table;
  var_1 = 0;

  if(!tableexists(var_0)) {
    return;
  }
  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "_encstr_B40101") {
      break;
    }

    var_3 = tablelookupbyrow(var_0, var_1, 1);
    var_4 = int(tablelookupbyrow(var_0, var_1, 2));
    var_5 = int(tablelookupbyrow(var_0, var_1, 3));
    var_6 = int(tablelookupbyrow(var_0, var_1, 4));
    var_7 = tablelookupbyrow(var_0, var_1, 5);
    var_8 = tablelookupbyrow(var_0, var_1, 6);
    var_9 = tablelookupbyrow(var_0, var_1, 7);
    var_10 = tablelookupbyrow(var_0, var_1, 8);
    var_11 = tablelookupbyrow(var_0, var_1, 9);
    var_12 = int(tablelookupbyrow(var_0, var_1, 10));
    var_13 = int(tablelookupbyrow(var_0, var_1, 11));
    var_14 = tablelookupbyrow(var_0, var_1, 12);
    var_15 = int(tablelookupbyrow(var_0, var_1, 13));
    var_16 = tablelookupbyrow(var_0, var_1, 15);
    register_vo(var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);

    if(var_1 % 5 == 1)
      wait 0.05;

    var_1++;
  }
}

register_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = spawnStruct();

  if(isDefined(var_2) && var_2 > 0) {
    var_15.cooldown = var_2;
    var_15.lastplayedtime = 0;
  }

  if(isDefined(var_14))
    var_15.missingstub = var_14;

  if(isDefined(var_13) && var_13 > 0)
    var_15.pause_time = var_13;

  if(istrue(var_10))
    var_15.onlylocal = 1;
  else
    var_15.onlylocal = 0;

  if(isDefined(var_11) && var_11 > 0)
    var_15.timeout = var_11;

  if(isDefined(var_12))
    var_15.priority = var_12;

  if(isDefined(var_4) && var_4 > 0)
    var_15.max_plays = var_4;

  if(isDefined(var_3) && var_3 > 0)
    var_15.chance_to_play = var_3;

  if(isDefined(var_7) && var_7 != "_encstr_B40101")
    var_15.waittillnotifyorflag = var_7;

  if(isDefined(var_5) && var_5 != "_encstr_B40101") {
    if(!isDefined(level.vo_categories[var_5]))
      level.vo_categories[var_5] = [];

    var_15.category_1 = var_5;
    level.vo_categories[var_5][level.vo_categories[var_5].size] = var_1;

    if(!isDefined(level.vo_category_last_played_time[var_5]))
      level.vo_category_last_played_time[var_5] = 0;
  }

  if(isDefined(var_6) && var_6 != "_encstr_B40101") {
    if(!isDefined(level.vo_categories[var_6]))
      level.vo_categories[var_6] = [];

    var_15.category_2 = var_6;
    level.vo_categories[var_6][level.vo_categories[var_6].size] = var_1;

    if(!isDefined(level.vo_category_last_played_time[var_6]))
      level.vo_category_last_played_time[var_6] = 0;
  }

  if(isDefined(var_8) && var_8 != "_encstr_B40101") {
    if(!isDefined(level.vo_dialogue_prefix[var_8]))
      level.vo_dialogue_prefix[var_8] = [];

    var_15.dialogueprefix = var_8;
    level.vo_dialogue_prefix[var_1] = var_8;
  }

  if(isDefined(var_9) && var_9 != "_encstr_B40101")
    var_15.nextdialogue = var_9;

  level.vo_alias_data[var_1] = var_15;
}

start_vo_system() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(is_vo_system_busy()) {
      if(scripts\engine\utility::flag_exist("_encstr_8F1B0FDE104E6FC07F30DA5281B53B9762"))
        scripts\engine\utility::flag_waitopen("_encstr_8F1B0FDE104E6FC07F30DA5281B53B9762");
    }

    var_0 = get_vo_to_play();

    if(!isDefined(var_0)) {
      set_vo_system_playing(0);
      self waittill("_encstr_87FF0F2062FE5B46EBF7107EA9176B3BA5");

      if(is_vo_system_paused())
        self waittill("_encstr_97A912E7350FFBEBBBE7D939E01F1FCB13C3CF59");

      continue;
    }

    play_vo_system(var_0);
  }
}

play_vo_system(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  set_vo_system_playing(1);
  set_vo_currently_playing(var_0);
  play_vo(var_0);
  pause_between_vo(var_0);
  unset_vo_currently_playing();
}

get_vo_to_play() {
  var_0 = retrieve_interrupt_vo();

  if(isDefined(var_0))
    return var_0;

  if(isDefined(level.vo_priority_level)) {
    foreach(var_3, var_2 in level.vo_priority_level) {
      var_0 = retrieve_vo_from_queue(var_2);

      if(isDefined(var_0))
        return var_0;
    }
  }

  return undefined;
}

retrieve_interrupt_vo() {
  var_0 = self.vo_system.interrupt_vo;
  reset_interrupt_vo();
  return var_0;
}

reset_interrupt_vo() {
  self.vo_system.interrupt_vo = undefined;
}

retrieve_vo_from_queue(var_0) {
  remove_expired_vo_from_queue(var_0);
  return pop_first_vo_out_of_queue(var_0);
}

pop_first_vo_out_of_queue(var_0) {
  var_1 = self.vo_system.vo_queue[var_0][0];

  if(!isDefined(var_1))
    return var_1;

  var_2 = [];

  for(var_3 = 1; var_3 < self.vo_system.vo_queue[var_0].size; var_3++) {
    if(!isDefined(self.vo_system.vo_queue[var_0][var_3])) {
      break;
    }

    var_2[var_3 - 1] = self.vo_system.vo_queue[var_0][var_3];
  }

  self.vo_system.vo_queue[var_0] = var_2;
  return var_1;
}

remove_expired_vo_from_queue(var_0) {
  var_1 = gettime();
  var_2 = [];

  foreach(var_5, var_4 in self.vo_system.vo_queue[var_0]) {
    if(!vo_expired(var_4, var_1)) {
      var_2[var_2.size] = self.vo_system.vo_queue[var_0][var_5];
      continue;
    }
  }

  self.vo_system.vo_queue[var_0] = var_2;
}

vo_expired(var_0, var_1) {
  return var_1 > var_0.expire_time;
}

set_vo_system_playing(var_0) {
  if(!isPlayer(self) || !isDefined(self.vo_system)) {
    return;
  }
  self.vo_system.is_playing = var_0;
}

is_vo_system_paused() {
  return istrue(self.pause_vo_system);
}

is_vo_system_busy() {
  return scripts\engine\utility::flag("_encstr_8F1B0FDE104E6FC07F30DA5281B53B9762");
}

set_vo_system_busy(var_0) {
  level.vo_system_busy = var_0;

  if(!var_0)
    scripts\engine\utility::flag_clear("_encstr_8F1B0FDE104E6FC07F30DA5281B53B9762");
  else
    scripts\engine\utility::flag_set("_encstr_8F1B0FDE104E6FC07F30DA5281B53B9762");
}

set_vo_currently_playing(var_0) {
  self.vo_system.vo_currently_playing = var_0;
}

game_ended_vo_watcher() {
  var_0 = "_encstr_B40101";
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_2 in level.players) {
    foreach(var_4 in level.vo_priority_level) {
      if(isDefined(var_2.vo_system.vo_queue[var_4]) && var_2.vo_system.vo_queue[var_4].size > 0) {
        foreach(var_6 in var_2.vo_system.vo_queue[var_4]) {
          if(isDefined(var_6)) {
            if(soundexists(var_6.alias))
              var_2 stoplocalsound(var_6.alias);
          }
        }

        var_2.vo_system.vo_queue[var_4] = [];
      }
    }

    if(isDefined(level.dialogue_arr) && level.dialogue_arr.size > 0) {
      foreach(var_10 in level.dialogue_arr) {
        if(issubstr(var_10, "_encstr_B61904383BAF"))
          var_2 stoplocalsound(var_10);

        if(soundexists(var_2.vo_prefix + var_10))
          var_2 stoplocalsound(var_2.vo_prefix + var_10);

        if(soundexists(var_2.vo_prefix + "_encstr_8E0D051F3D039F" + var_10))
          var_2 stoplocalsound(var_2.vo_prefix + "_encstr_8E0D051F3D039F" + var_10);
      }
    }

    if(isDefined(var_2.current_vo_queue) && var_2.current_vo_queue.size > 0) {
      foreach(var_13 in var_2.current_vo_queue) {
        if(isDefined(var_13)) {
          if(soundexists(var_13)) {
            var_2 stoplocalsound(var_13);
            continue;
          }

          if(soundexists(var_2.vo_prefix + var_13)) {
            var_2 stoplocalsound(var_2.vo_prefix + var_13);
            continue;
          }

          if(soundexists(var_2.vo_prefix + "_encstr_8E0D051F3D039F" + var_13))
            var_2 stoplocalsound(var_2.vo_prefix + "_encstr_8E0D051F3D039F" + var_13);
        }
      }
    }

    if(!isDefined(var_2.vo_prefix)) {
      return;
    }
    switch (var_2.vo_prefix) {
      case "_encstr_B119045043D9":
        var_0 = "_encstr_8D920DAF672CB11BAC5EF5CED293B1";
        break;
      case "_encstr_831904D9F2F7":
        var_0 = "_encstr_8273068788517242";
        break;
      case "_encstr_B4190483CCFA":
        var_0 = "_encstr_AF37084F3BE2CF78659A";
        break;
      case "_encstr_86190483D0AF":
        var_0 = "_encstr_8297067F1CC83ED8";
        break;
      case "_encstr_A6190490B3C6":
        var_0 = "_encstr_8297067F1CC83ED8";
        break;
    }

    var_15 = "_encstr_B45B0C0D8BF8B183D8D85A12212E" + var_0;

    if(soundexists(var_15))
      var_2 stoplocalsound("_encstr_B45B0C0D8BF8B183D8D85A12212E" + var_0);

    var_15 = "_encstr_B45B0C0D8BF8B183D8D85A12212E" + var_0 + "_encstr_B68506EBB19BC96E";

    if(soundexists(var_15))
      var_2 stoplocalsound("_encstr_B45B0C0D8BF8B183D8D85A12212E" + var_0 + "_encstr_B68506EBB19BC96E");
  }
}

play_vo(var_0) {
  self endon("_encstr_957515B872433D181AF599993786F87EF37AD08309B370");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(self.sessionstate != "_encstr_877508C1D8C22F2DDC3B") {
    return;
  }
  var_1 = var_0.alias;

  if(!soundexists(var_1)) {
    if(isDefined(level.vo_alias_data[var_1]) && isDefined("_encstr_AD112749F513A0B13A1B988672EBFB48EA77D1CB8CBE090F1B02510B998AA1B002B3735D07EAB84D5B")) {} else {}

    wait 0.1;
    return;
  }

  self.vo_system_playing_vo = 1;

  if(scripts\cp\utility::is_playing_pain_breathing_sfx(self)) {
    var_2 = scripts\cp\utility::get_pain_breathing_sfx_alias(self);

    if(isDefined(var_2))
      self stoplocalsound(var_2);
  }

  if(isDefined(var_0.basealias))
    var_3 = var_0.basealias;
  else
    var_3 = var_1;

  foreach(var_5 in level.players) {
    if(var_5 issplitscreenplayer() && !var_5 issplitscreenplayerprimary()) {
      continue;
    }
    if(isDefined(var_5.current_vo_queue))
      var_5.current_vo_queue = scripts\engine\utility::array_add(var_5.current_vo_queue, var_3);

    if(var_5 == self) {
      if(isDefined(level.get_alias_2d_func))
        var_6 = [[level.get_alias_2d_func]](var_5, var_1, var_3);
      else
        var_6 = get_alias_2d_version(var_5, var_1, var_3);

      if(isDefined(var_6))
        var_5 scripts\cp\utility::playlocalsound_safe(var_6);
      else
        var_5 scripts\cp\utility::playlocalsound_safe(var_1);

      continue;
    }

    if(!istrue(var_0.only_local) && soundexists(var_1))
      self playsoundtoplayer(var_1, var_5);
  }

  foreach(var_9 in var_0.categories)
  level.vo_category_last_played_time[var_9] = gettime();

  if(!isDefined(self.num_of_plays[var_3]))
    self.num_of_plays[var_3] = 1;
  else
    self.num_of_plays[var_3]++;

  wait(get_sound_length(var_1));
  self.vo_system_playing_vo = 0;
}

alias_2d_version_exists(var_0, var_1) {
  var_2 = get_alias_2d_version(var_0, var_1);
  return soundexists(var_2);
}

get_alias_2d_version(var_0, var_1, var_2) {
  var_3 = strtok(var_1, "_encstr_BA4C02DF");

  if(var_3[0] == "_encstr_BA07035363" || var_3[0] == "_encstr_B20703E44A" || var_3[0] == "_encstr_880703DAB2")
    return var_1;
  else {
    if(isDefined(var_0.vo_prefix))
      var_4 = var_0.vo_prefix + "_encstr_8E0D051F3D039F" + var_2;
    else
      var_4 = "_encstr_8E0D051F3D039F" + var_2;

    if(soundexists(var_4))
      return var_4;

    return undefined;
  }
}

get_alias_3d_version(var_0, var_1) {
  if(issubstr(var_1, "_encstr_BD1904CF5741") || issubstr(var_1, "_encstr_AB18048C3D11") || issubstr(var_1, "_encstr_B119045043D9") || issubstr(var_1, "_encstr_831904D9F2F7") || issubstr(var_1, "_encstr_B4190483CCFA") || issubstr(var_1, "_encstr_86190483D0AF") || issubstr(var_1, "_encstr_A9390DDAF782187BDA01D3EFAF0390"))
    return var_1;

  var_2 = getsubstr(var_1, var_0.vo_prefix.size);
  return var_0.vo_prefix + var_2;
}

get_sound_length(var_0) {
  if(!soundexists(var_0))
    return 0;

  var_1 = lookupsoundlength(var_0) / 1000 + 0.4;

  if(getdvarint("_encstr_BDA10A73413891FBD1FBD9F4") != 0 && getdvarint("_encstr_BDA10A73413891FBD1FBD9F4") != 1)
    var_1 = var_1 + 1.5;

  var_2 = push_player_clear_of_door_way(var_0);

  if(isDefined(var_2))
    var_1 = var_2;

  return var_1;
}

pause_between_vo(var_0) {
  if(is_vo_system_paused())
    self waittill("_encstr_97A912E7350FFBEBBBE7D939E01F1FCB13C3CF59");

  if(var_0.pause_time > 0)
    wait(var_0.pause_time);
}

unset_vo_currently_playing() {
  self.vo_system.vo_currently_playing = undefined;
}

try_to_play_vo_on_team(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\cp\utility::getplayersinteam(var_1);

  if(!isDefined(var_0)) {
    return;
  }
  if(var_5.size <= 0) {
    return;
  }
  if(!istrue(var_2)) {
    level.validatealivecount = 1;

    if(isPlayer(self) || self == level || !isent(self)) {
      foreach(var_7 in var_5)
      var_7 thread play_cp_comment_vo(var_0, "_encstr_99140ED629C9C62FA399EFB01B5F748F", "_encstr_B23608E248D4CB37E891", 10, 0, 0, 1);
    } else
      thread scripts\cp\utility::playsoundatpos_safe(self.origin, var_0);

    wait(get_sound_length(var_0));
    level.validatealivecount = 0;
  } else {
    var_9 = 45;

    if(isDefined(var_4))
      var_9 = var_4;

    var_10 = 60;

    if(isDefined(var_3))
      var_10 = var_3;

    foreach(var_7 in var_5)
    var_7 thread add_to_nag_vo(var_0, "_encstr_99140ED629C9C62FA399EFB01B5F748F", var_10, var_9, 6, 1);
  }
}

try_to_play_vo_for_one_player(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!istrue(var_2))
    var_1 thread try_to_play_vo(var_0, "_encstr_99140ED629C9C62FA399EFB01B5F748F", "_encstr_B23608E248D4CB37E891", 10, 0, 0, 1, 100);
  else {
    var_5 = 45;

    if(isDefined(var_4))
      var_5 = var_4;

    var_6 = 60;

    if(isDefined(var_3))
      var_6 = var_3;

    var_1 thread add_to_nag_vo(var_0, "_encstr_99140ED629C9C62FA399EFB01B5F748F", var_6, var_5, 6, 1);
  }
}

try_to_play_vo_on_all_players(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level.players)) {
    return;
  }
  if(!istrue(var_1)) {
    foreach(var_3 in level.players)
    var_3 thread try_to_play_vo(var_0, "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", "_encstr_B23608E248D4CB37E891", 10, 0, 0, 1, 100);
  } else {
    foreach(var_3 in level.players)
    var_3 thread add_to_nag_vo(var_0, "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", 60, 45, 6, 1);
  }
}

try_to_play_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = isDefined(level.vo_alias_data[var_0]);
  var_9 = scripts\engine\utility::ter_op(var_8, level.vo_alias_data[var_0], undefined);

  if(!isDefined(var_7)) {
    if(var_8) {
      if(isDefined(var_9.chance_to_play))
        var_7 = var_9.chance_to_play;
    } else
      var_7 = 100;
  }

  if(randomint(100) > var_7) {
    return;
  }
  if(should_play_vo(var_0)) {
    if(!isDefined(var_5) && var_8 && isDefined(var_9.pause_time))
      var_5 = var_9.pause_time;

    if(!isDefined(var_6) && var_8 && isDefined(var_9.only_local))
      var_6 = var_9.onlylocal;

    if(!isDefined(var_3) && var_8 && isDefined(var_9.timeout))
      var_3 = var_9.timeout;

    if(!isDefined(var_2) && var_8 && isDefined(var_9.priority))
      var_2 = var_9.priority;

    var_10 = get_categories_from_alias(var_0);

    foreach(var_12 in var_10)
    level.vo_category_last_played_time[var_12] = gettime();

    if(var_8 && isDefined(var_9.lastplayedtime))
      var_9.lastplayedtime = gettime();

    thread add_to_vo_queue(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }
}

should_play_vo(var_0) {
  if(!isDefined(level.vo_alias_data[var_0]))
    return 1;

  var_1 = gettime();

  if(isDefined(level.vo_alias_data[var_0].cooldown) && isDefined(level.vo_alias_data[var_0].lastplayedtime)) {
    if(var_1 < level.vo_alias_data[var_0].lastplayedtime + level.vo_alias_data[var_0].cooldown * 1000)
      return 0;
  }

  var_2 = get_categories_from_alias(var_0);

  foreach(var_4 in var_2) {
    var_5 = scripts\engine\utility::ter_op(isDefined(level.vo_alias_data[var_0].cooldown), level.vo_alias_data[var_0].cooldown, 30);

    if(var_1 < level.vo_category_last_played_time[var_4] + var_5 * 1000)
      return 0;
  }

  if(isDefined(level.vo_alias_data[var_0].max_plays)) {
    if(!isDefined(self.num_of_plays))
      self.num_of_plays = [];

    if(!isDefined(self.num_of_plays[var_0]))
      self.num_of_plays[var_0] = 0;

    if(self.num_of_plays[var_0] < level.vo_alias_data[var_0].max_plays)
      return 1;
    else
      return 0;
  } else
    return 1;
}

get_categories_from_alias(var_0) {
  if(!isDefined(level.vo_categories))
    return [];

  var_1 = getarraykeys(level.vo_categories);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(scripts\engine\utility::array_contains(level.vo_categories[var_4], var_0))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

should_append_player_prefix(var_0) {
  if(issubstr(var_0, "_encstr_BD1904CF5741") || issubstr(var_0, "_encstr_AB18048C3D11") || issubstr(var_0, "_encstr_A9390DDAF782187BDA01D3EFAF0390"))
    return 0;
  else
    return 1;
}

should_append_player_suffix(var_0, var_1) {
  if(istrue(var_1)) {
    if(issubstr(var_0, "_encstr_BD1904CF5741") && issubstr(var_0, "_encstr_8E07039848"))
      return 1;
    else
      return 0;
  }

  return 0;
}

play_cp_comment_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.announcer_vo_playing = 1;
  var_7 = level.players;

  if(isPlayer(self))
    var_7 = [self];

  foreach(var_9 in var_7) {
    if(!isDefined(var_9)) {
      continue;
    }
    if(var_9 issplitscreenplayer() && !var_9 issplitscreenplayerprimary()) {
      continue;
    }
    var_10 = create_vo_data(var_0, var_3, var_5, var_6);
    var_9 thread play_vo_system(var_10);
  }

  wait(get_sound_length(var_0));

  foreach(var_9 in var_7)
  var_9 set_vo_system_playing(0);

  level.announcer_vo_playing = 0;
}

add_to_vo_queue(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_1) && isDefined(level.vo_functions[var_1]))
    self thread[[level.vo_functions[var_1]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  else if(isDefined(var_1) && var_1 == "_encstr_99140ED629C9C62FA399EFB01B5F748F")
    play_cp_comment_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  else if(isPlayer(self)) {
    if(isDefined(self.vo_prefix))
      var_7 = self.vo_prefix + var_0;
    else
      return;

    thread play_vo_on_player(var_7, var_2, var_3, var_4, var_5, var_6, var_0);
  } else {
    var_7 = var_0;
    level thread play_vo_on_all_players(var_7, var_2, var_3, var_4, var_5, var_6, var_0);
  }
}

play_vo_on_all_players(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  foreach(var_8 in level.players)
  var_8 add_to_vo_system(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

play_vo_on_player(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  add_to_vo_system(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

add_to_vo_system(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(self.current_vo_queue))
    self.current_vo_queue = [];

  thread add_to_vo_system_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

add_to_vo_system_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 = get_validated_priority(var_1);
  var_7 = create_vo_data(var_0, var_2, var_4, var_5, var_6);

  if(should_interrupt_vo_system(var_3)) {
    add_to_interrupt_vo(var_7);

    if(is_vo_system_playing())
      interrupt_current_vo();
  } else
    add_to_queue_at_priority(var_7, var_1);

  if(!is_vo_system_playing())
    notify_system_to_grab_next_vo_from_queue();
}

get_validated_priority(var_0) {
  if(!isDefined(var_0))
    return level.vo_priority_level[level.vo_priority_level.size - 1];

  return var_0;
}

create_vo_data(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 999;
  var_6 = 1.5;
  var_7 = 3;
  var_8 = spawnStruct();
  var_8.alias = var_0;
  var_8.categories = get_categories_from_alias(var_0);
  var_8.basealias = var_4;

  if(!isDefined(var_1))
    var_1 = var_5;

  var_8.expire_time = gettime() + var_1 * 1000;

  if(!isDefined(var_2))
    var_2 = randomfloatrange(var_6, var_7);

  var_8.pause_time = var_2;

  if(istrue(var_3))
    var_8.only_local = 1;
  else
    var_8.only_local = 0;

  return var_8;
}

should_interrupt_vo_system(var_0) {
  return isDefined(var_0) && var_0;
}

add_to_interrupt_vo(var_0) {
  self.vo_system.interrupt_vo = var_0;
}

is_vo_system_playing() {
  return istrue(self.vo_system.is_playing);
}

interrupt_current_vo() {
  var_0 = get_current_vo_alias();

  if(isDefined(var_0))
    self stoplocalsound(var_0);

  self notify("_encstr_957515B872433D181AF599993786F87EF37AD08309B370");
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

add_to_queue_at_priority(var_0, var_1) {
  self.vo_system.vo_queue[var_1][self.vo_system.vo_queue[var_1].size] = var_0;
}

notify_system_to_grab_next_vo_from_queue() {
  self notify("_encstr_87FF0F2062FE5B46EBF7107EA9176B3BA5");
}

remove_vo_data(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in self.vo_system.vo_queue[var_1]) {
    if(!(var_4.alias == self.vo_prefix + var_0 || var_4.alias == self.vo_prefix + "_encstr_8E0D051F3D039F" + var_0))
      var_2[var_2.size] = self.vo_system.vo_queue[var_1][var_5];
  }

  self.vo_system.vo_queue[var_1] = var_2;
}

pause_vo_system(var_0) {
  if(var_0.size == 1)
    var_0[0].pause_vo_system = 1;
  else {
    foreach(var_2 in var_0)
    var_2.pause_vo_system = 1;
  }
}

unpause_vo_system(var_0) {
  foreach(var_2 in var_0)
  var_2.pause_vo_system = 0;

  foreach(var_2 in var_0)
  var_2 notify("_encstr_97A912E7350FFBEBBBE7D939E01F1FCB13C3CF59");
}

nag_vo_handler() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level.nag_vo)) {
    level.nag_vo = [];
    level.nag_vo_never_play_again = [];
    level.pause_nag_vo = 0;
  }

  var_0 = 60;

  for(;;) {
    while(level.pause_nag_vo)
      wait 0.1;

    var_1 = gettime();

    foreach(var_4, var_3 in level.nag_vo) {
      if(var_1 > var_3.next_play_time) {
        if(isDefined(var_3.scope))
          var_3.scope try_to_play_vo(var_4, var_3.vo_type, "_encstr_BE19041BDEDD", 3, 0, 0, var_3.only_local);
        else
          level try_to_play_vo(var_4, var_3.vo_type, "_encstr_BE19041BDEDD", 3, 0, 0, var_3.only_local);

        var_3.times_played++;

        if(var_3.max_times != -1 && var_3.max_times <= var_3.times_played)
          remove_from_nag_vo(var_4);

        var_3.next_play_time = var_1 + var_3.cooldown * min(var_3.times_played, 3) * 1000;
        wait(var_0);
      }
    }

    wait 1;
  }
}

add_to_nag_vo(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.nag_vo)) {
    level.nag_vo = [];
    level.nag_vo_never_play_again = [];
    level.pause_nag_vo = 0;
  }

  if(isDefined(level.nag_vo[var_0])) {
    return;
  }
  if(isDefined(level.nag_vo_never_play_again[var_0])) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 60;

  if(!isDefined(var_1))
    var_1 = "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18";

  var_6 = undefined;

  if(isPlayer(self))
    var_6 = self;

  var_7 = spawnStruct();
  var_7.times_played = 0;
  var_7.cooldown = var_2;
  var_7.vo_type = var_1;

  if(isDefined(var_6))
    var_7.scope = var_6;

  if(isDefined(var_5))
    var_7.only_local = var_5;
  else
    var_7.only_local = 0;

  if(isDefined(var_3))
    var_7.next_play_time = gettime() + var_3 * 1000;
  else
    var_7.next_play_time = 0;

  if(isDefined(var_4))
    var_7.max_times = var_4;
  else
    var_7.max_times = -1;

  level.nag_vo[var_0] = var_7;
}

remove_from_nag_vo(var_0, var_1) {
  level.nag_vo = scripts\engine\utility::array_remove_index(level.nag_vo, var_0, 1);

  if(istrue(var_1))
    level.nag_vo_never_play_again[var_0] = 1;
}

timeoutvofunction(var_0, var_1) {
  level endon(var_0 + "_encstr_AD1E0FEB854C7BEA3A7D8EDEAF07C6165E");
  wait(var_1);
  level notify(var_0 + "_encstr_82610BFA1DB4AD5619EBDEEA8E");
}

push_player_clear_of_door_way(var_0) {
  var_1 = tablelookup("_encstr_A6B0140618CE86AF91ADF7F934876802439AA5B39BE6", 0, var_0, 1);

  if(isDefined(var_1)) {
    var_1 = float(var_1);
    return var_1;
  }

  return undefined;
}