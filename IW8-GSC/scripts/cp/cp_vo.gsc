/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_vo.gsc
***********************************************/

function initcpvosystem() {
  level.vo_priority_level = ["highest", "high", "medium", "low"];
  level.vo_alias_data = [];
  level.vo_categories = [];
  level.vo_category_last_played_time = [];
  level.vo_dialogue_prefix = [];
  level.vo_table = "cp/" + getDvar("ui_mapname") + "_vo_table.csv";
  thread parse_vo_table();
  thread nag_vo_handler();
}

function initandstartvosystem() {
  init_vo_system();
  thread start_vo_system();
  thread game_ended_vo_watcher();
}

function init_vo_system() {
  var_0 = spawnStruct();
  var_0.vo_currently_playing = undefined;
  var_0.interrupt_vo = undefined;
  var_0.is_playing = 0;
  var_1 = [];

  if(isDefined(level.vo_priority_level)) {
    foreach(var_3 in level.vo_priority_level) {
      var_1 = [];
    }
  }

  var_0.vo_queue = var_1;
  self.vo_system = var_0;
  scripts\engine\utility::flag_init("vo_system_busy");
}

function parse_vo_table() {
  var_0 = level.vo_table;
  var_1 = 0;
  jumpiftrue(tableexists(var_0)) LOC_00000013;
  return;
}

function register_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = spawnStruct();

  if(isDefined(var_2) && var_2 > 0) {
    var_15.cooldown = var_2;
    var_15.lastplayedtime = 0;
  }

  if(isDefined(var_14)) {
    var_15.missingstub = var_14;
  }

  if(isDefined(var_13) && var_13 > 0) {
    var_15.pause_time = var_13;
  }

  if(istrue(var_10)) {
    var_15.onlylocal = 1;
  } else {
    var_15.onlylocal = 0;
  }

  if(isDefined(var_11) && var_11 > 0) {
    var_15.timeout = var_11;
  }

  if(isDefined(var_12)) {
    var_15.priority = var_12;
  }

  if(isDefined(var_4) && var_4 > 0) {
    var_15.max_plays = var_4;
  }

  if(isDefined(var_3) && var_3 > 0) {
    var_15.chance_to_play = var_3;
  }

  if(isDefined(var_7) && var_7 != "") {
    var_15.waittillnotifyorflag = var_7;
  }

  if(isDefined(var_5) && var_5 != "") {
    if(!isDefined(level.vo_categories[var_5])) {
      level.vo_categories[var_5] = [];
    }

    var_15.category_1 = var_5;
    level.vo_categories[var_5][level.vo_categories[var_5].size] = var_1;

    if(!isDefined(level.vo_category_last_played_time[var_5])) {
      level.vo_category_last_played_time[var_5] = 0;
    }
  }

  if(isDefined(var_6) && var_6 != "") {
    if(!isDefined(level.vo_categories[var_6])) {
      level.vo_categories[var_6] = [];
    }

    var_15.category_2 = var_6;
    level.vo_categories[var_6][level.vo_categories[var_6].size] = var_1;

    if(!isDefined(level.vo_category_last_played_time[var_6])) {
      level.vo_category_last_played_time[var_6] = 0;
    }
  }

  if(isDefined(var_8) && var_8 != "") {
    if(!isDefined(level.vo_dialogue_prefix[var_8])) {
      level.vo_dialogue_prefix[var_8] = [];
    }

    var_15.dialogueprefix = var_8;
    level.vo_dialogue_prefix[var_1] = var_8;
  }

  if(isDefined(var_9) && var_9 != "") {
    var_15.nextdialogue = var_9;
  }

  level.vo_alias_data[var_1] = var_15;
}

function start_vo_system() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(is_vo_system_busy()) {
      if(scripts\engine\utility::flag_exist("vo_system_busy")) {
        scripts\engine\utility::flag_waitopen("vo_system_busy");
      }
    }

    var_0 = get_vo_to_play();

    if(!isDefined(var_0)) {
      set_vo_system_playing(0);
      self waittill("play_VO_system");

      if(is_vo_system_paused()) {
        self waittill("unpause_VO_system");
      }

      continue;
    }

    play_vo_system(var_0);
  }
}

function play_vo_system(var_0) {
  self endon("disconnect");
  set_vo_system_playing(1);
  set_vo_currently_playing(var_0);
  play_vo(var_0);
  pause_between_vo(var_0);
  unset_vo_currently_playing();
}

function get_vo_to_play() {
  var_0 = retrieve_interrupt_vo();

  if(isDefined(var_0)) {
    return var_0;
  }

  if(isDefined(level.vo_priority_level)) {
    foreach(var_2 in level.vo_priority_level) {
      var_0 = retrieve_vo_from_queue(var_2);

      if(isDefined(var_0)) {
        return var_0;
      }
    }
  }

  return undefined;
}

function retrieve_interrupt_vo() {
  var_0 = self.vo_system.interrupt_vo;
  reset_interrupt_vo();
  return var_0;
}

function reset_interrupt_vo() {
  self.vo_system.interrupt_vo = undefined;
}

function retrieve_vo_from_queue(var_0) {
  remove_expired_vo_from_queue(var_0);
  return pop_first_vo_out_of_queue(var_0);
}

function pop_first_vo_out_of_queue(var_0) {
  var_1 = self.vo_system.vo_queue[var_0][0];

  if(!isDefined(var_1)) {
    return var_1;
  }

  var_2 = [];

  for(var_3 = 1; var_3 < self.vo_system.vo_queue[var_0].size; var_3++) {
    if(!isDefined(self.vo_system.vo_queue[var_0][var_3])) {
      break;
    }

    var_2 = self.vo_system.vo_queue[var_0][var_3];
  }

  self.vo_system.vo_queue[var_0] = var_2;
  return var_1;
}

function remove_expired_vo_from_queue(var_0) {
  var_1 = gettime();
  var_2 = [];

  foreach(var_4 in self.vo_system.vo_queue[var_0]) {
    if(!vo_expired(var_4, var_1)) {
      var_2 = self.vo_system.vo_queue[var_0][var_5];
    }
  }

  self.vo_system.vo_queue[var_0] = var_2;
}

function vo_expired(var_0, var_1) {
  return var_1 > var_0.expire_time;
}

function set_vo_system_playing(var_0) {
  if(!isPlayer(self) || !isDefined(self.vo_system)) {
    return;
  }

  self.vo_system.is_playing = var_0;
}

function is_vo_system_paused() {
  return istrue(self.pause_vo_system);
}

function is_vo_system_busy() {
  return scripts\engine\utility::flag("vo_system_busy");
}

function set_vo_system_busy(var_0) {
  level.vo_system_busy = var_0;

  if(!var_0) {
    scripts\engine\utility::flag_clear("vo_system_busy");
    return;
  }

  scripts\engine\utility::flag_set("vo_system_busy");
}

function set_vo_currently_playing(var_0) {
  self.vo_system.vo_currently_playing = var_0;
}

function game_ended_vo_watcher() {
  var_0 = "";
  level waittill("game_ended");

  foreach(var_2 in level.players) {
    foreach(var_4 in level.vo_priority_level) {
      if(isDefined(var_2.vo_system.vo_queue[var_4]) && var_2.vo_system.vo_queue[var_4].size > 0) {
        foreach(var_6 in var_2.vo_system.vo_queue[var_4]) {
          if(isDefined(var_6)) {
            if(soundexists(var_6.alias)) {
              var_2 stoplocalsound(var_6.alias);
            }
          }
        }

        var_2.vo_system.vo_queue[var_4] = [];
      }
    }

    if(isDefined(level.dialogue_arr) && level.dialogue_arr.size > 0) {
      foreach(var_10 in level.dialogue_arr) {
        if(issubstr(var_10, "pg_")) {
          var_2 stoplocalsound(var_10);
        }

        if(soundexists(var_2.vo_prefix + var_10)) {
          var_2 stoplocalsound(var_2.vo_prefix + var_10);
        }

        if(soundexists(var_2.vo_prefix + "plr_" + var_10)) {
          var_2 stoplocalsound(var_2.vo_prefix + "plr_" + var_10);
        }
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

          if(soundexists(var_2.vo_prefix + "plr_" + var_13)) {
            var_2 stoplocalsound(var_2.vo_prefix + "plr_" + var_13);
          }
        }
      }
    }

    if(!isDefined(var_2.vo_prefix)) {
      return;
    }

    switch (var_2.vo_prefix) {
      case "p1_":
        var_0 = "_valley_girl";
        break;
      case "p2_":
        var_0 = "_nerd";
        break;
      case "p3_":
        var_0 = "_rapper";
        break;
      case "p4_":
        var_0 = "_jock";
        break;
      case "p5_":
        var_0 = "_jock";
        break;
    }

    var_15 = "mus_zombies" + var_0;

    if(soundexists(var_15)) {
      var_2 stoplocalsound("mus_zombies" + var_0);
    }

    var_15 = "mus_zombies" + var_0 + "_lsrs";

    if(soundexists(var_15)) {
      var_2 stoplocalsound("mus_zombies" + var_0 + "_lsrs");
    }
  }
}

function play_vo(var_0) {
  self endon("interrupt_current_VO");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(self.sessionstate != "playing") {
    return;
  }

  var_1 = var_0.alias;

  if(!soundexists(var_1)) {
    if(isDefined(level.vo_alias_data[var_1]) && isDefined("level.vo_alias_data[alias].missingStub")) {}

    wait 0.1;
    return;
  }

  self.vo_system_playing_vo = 1;

  if(scripts\cp\utility::is_playing_pain_breathing_sfx(self)) {
    var_2 = scripts\cp\utility::get_pain_breathing_sfx_alias(self);

    if(isDefined(var_2)) {
      self stoplocalsound(var_2);
    }
  }

  if(isDefined(var_0.basealias)) {
    var_3 = var_0.basealias;
  } else {
    var_3 = var_3;
  }

  foreach(var_5 in level.players) {
    if(var_5 issplitscreenplayer() && !var_5 issplitscreenplayerprimary()) {
      continue;
    }

    if(isDefined(var_5.current_vo_queue)) {
      var_5.current_vo_queue = scripts\engine\utility::array_add(var_5.current_vo_queue, var_3);
    }

    if(var_5 == self) {
      if(isDefined(level.get_alias_2d_func)) {
        var_6 = [[level.get_alias_2d_func]](var_5, var_3, var_3);
      } else {
        var_6 = get_alias_2d_version(var_7, var_3, var_4);
      }

      if(isDefined(var_6)) {
        var_7 scripts\cp\utility::playlocalsound_safe(var_6);
      } else {
        var_7 scripts\cp\utility::playlocalsound_safe(var_3);
      }

      continue;
    }

    if(!istrue(var_3.only_local) && soundexists(var_3)) {
      self playsoundtoplayer(var_3, var_7);
    }
  }

  var_5 = undefined;
  var_6 = undefined;

  foreach(var_9 in var_3.categories) {
    level.vo_category_last_played_time[var_9] = gettime();
  }

  if(!isDefined(self.num_of_plays[var_4])) {
    self.num_of_plays[var_4] = 1;
  } else {
    self.num_of_plays[var_4]++;
  }

  wait get_sound_length(var_3);
  self.vo_system_playing_vo = 0;
}

function alias_2d_version_exists(var_0, var_1) {
  var_2 = get_alias_2d_version(var_0, var_1);
  return soundexists(var_2);
}

function get_alias_2d_version(var_0, var_1, var_2) {
  var_3 = strtok(var_1, "_");

  if(var_3[0] == "ww" || var_3[0] == "dj" || var_3[0] == "ks") {
    return var_1;
  }

  if(isDefined(var_0.vo_prefix)) {
    var_4 = var_0.vo_prefix + "plr_" + var_2;
  } else {
    var_4 = "plr_" + var_3;
  }

  if(soundexists(var_4)) {
    return var_4;
  }

  return undefined;
}

function get_alias_3d_version(var_0, var_1) {
  if(issubstr(var_1, "ww_") || issubstr(var_1, "dj_") || issubstr(var_1, "p1_") || issubstr(var_1, "p2_") || issubstr(var_1, "p3_") || issubstr(var_1, "p4_") || issubstr(var_1, "jaroslav_anc")) {
    return var_1;
  }

  var_2 = getsubstr(var_1, var_0.vo_prefix.size);
  return var_0.vo_prefix + var_2;
}

function get_sound_length(var_0) {
  if(!soundexists(var_0)) {
    return 0;
  }

  var_1 = lookupsoundlength(var_0) / 1000 + 0.4;

  if(getdvarint("loc_language") != 0 && getdvarint("loc_language") != 1) {
    var_1 += 1.5;
  }

  var_2 = push_player_clear_of_door_way(var_0);

  if(isDefined(var_2)) {
    var_1 = var_2;
  }

  return var_1;
}

function pause_between_vo(var_0) {
  if(is_vo_system_paused()) {
    self waittill("unpause_VO_system");
  }

  if(var_0.pause_time > 0) {
    wait var_0.pause_time;
    return;
  }
}

function unset_vo_currently_playing() {
  self.vo_system.vo_currently_playing = undefined;
}

function try_to_play_vo_on_team(var_0, var_1, var_2, var_3, var_4) {
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
      foreach(var_7 in var_5) {
        thread play_cp_comment_vo(var_7, var_0, "cp_comment_vo", "highest", 10, 0, 0);
      }
    } else {
      thread scripts\cp\utility::playsoundatpos_safe(self.origin, var_0);
    }

    wait get_sound_length(var_0);
    level.validatealivecount = 0;
    return;
  }

  var_9 = 45;

  if(isDefined(var_4)) {
    var_9 = var_4;
  }

  var_10 = 60;

  if(isDefined(var_3)) {
    var_10 = var_3;
  }

  foreach(var_7 in var_5) {
    thread add_to_nag_vo(var_7, var_0, "cp_comment_vo", var_10, var_9, 6);
  }
}

function try_to_play_vo_for_one_player(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_1)) {
    return;
  }

  if(!istrue(var_2)) {
    thread try_to_play_vo(var_1, var_0, "cp_comment_vo", "highest", 10, 0, 0, 1);
    return;
  }

  var_5 = 45;

  if(isDefined(var_4)) {
    var_5 = var_4;
  }

  var_6 = 60;

  if(isDefined(var_3)) {
    var_6 = var_3;
  }

  thread add_to_nag_vo(var_1, var_0, "cp_comment_vo", var_6, var_5, 6);
}

function try_to_play_vo_on_all_players(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(level.players)) {
    return;
  }

  jumpiftrue(istrue(var_1)) LOC_0000005b;

  foreach(var_3 in level.players) {
    thread try_to_play_vo(var_3, var_0, "zmb_comment_vo", "highest", 10, 0, 0, 1);
  }

  return;
}

function try_to_play_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = isDefined(level.vo_alias_data[var_0]);
  var_9 = scripts\engine\utility::ter_op(var_8, level.vo_alias_data[var_0], undefined);

  if(!isDefined(var_7)) {
    if(var_8) {
      if(isDefined(var_9.chance_to_play)) {
        var_7 = var_9.chance_to_play;
      }
    } else {
      var_7 = 100;
    }
  }

  if(randomint(100) > var_7) {
    return;
  }

  if(should_play_vo(var_0)) {
    if(!isDefined(var_5) && var_8 && isDefined(var_9.pause_time)) {
      var_5 = var_9.pause_time;
    }

    if(!isDefined(var_6) && var_8 && isDefined(var_9.only_local)) {
      var_6 = var_9.onlylocal;
    }

    if(!isDefined(var_3) && var_8 && isDefined(var_9.timeout)) {
      var_3 = var_9.timeout;
    }

    if(!isDefined(var_2) && var_8 && isDefined(var_9.priority)) {
      var_2 = var_9.priority;
    }

    var_10 = get_categories_from_alias(var_0);

    foreach(var_12 in var_10) {
      level.vo_category_last_played_time[var_12] = gettime();
    }

    if(var_8 && isDefined(var_9.lastplayedtime)) {
      var_9.lastplayedtime = gettime();
    }

    thread add_to_vo_queue(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    return;
  }
}

function should_play_vo(var_0) {
  if(!isDefined(level.vo_alias_data[var_0])) {
    return 1;
  }

  var_1 = gettime();

  if(isDefined(level.vo_alias_data[var_0].cooldown) && isDefined(level.vo_alias_data[var_0].lastplayedtime)) {
    if(var_1 < level.vo_alias_data[var_0].lastplayedtime + level.vo_alias_data[var_0].cooldown * 1000) {
      return 0;
    }
  }

  var_2 = get_categories_from_alias(var_0);

  foreach(var_4 in var_2) {
    var_5 = scripts\engine\utility::ter_op(isDefined(level.vo_alias_data[var_0].cooldown), level.vo_alias_data[var_0].cooldown, 30);

    if(var_1 < level.vo_category_last_played_time[var_4] + var_5 * 1000) {
      return 0;
    }
  }

  if(isDefined(level.vo_alias_data[var_0].max_plays)) {
    if(!isDefined(self.num_of_plays)) {
      self.num_of_plays = [];
    }

    if(!isDefined(self.num_of_plays[var_0])) {
      self.num_of_plays[var_0] = 0;
    }

    if(self.num_of_plays[var_0] < level.vo_alias_data[var_0].max_plays) {
      return 1;
    }

    return 0;
  }

  return 1;
}

function get_categories_from_alias(var_0) {
  if(!isDefined(level.vo_categories)) {
    return [];
  }

  var_1 = getarraykeys(level.vo_categories);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(scripts\engine\utility::array_contains(level.vo_categories[var_4], var_0)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function should_append_player_prefix(var_0) {
  if(issubstr(var_0, "ww_") || issubstr(var_0, "dj_") || issubstr(var_0, "jaroslav_anc")) {
    return 0;
  }

  return 1;
}

function should_append_player_suffix(var_0, var_1) {
  if(istrue(var_1)) {
    if(issubstr(var_0, "ww_") && issubstr(var_0, "_p")) {
      return true;
    } else {
      return false;
    }
  }

  return false;
}

function play_cp_comment_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("game_ended");
  level.announcer_vo_playing = 1;
  var_7 = level.players;

  if(isPlayer(self)) {
    var_7 = [self];
  }

  foreach(var_9 in var_7) {
    if(!isDefined(var_9)) {
      continue;
    }

    if(var_9 issplitscreenplayer() && !var_9 issplitscreenplayerprimary()) {
      continue;
    }

    var_10 = create_vo_data(var_0, var_3, var_5, var_6);
    thread play_vo_system(var_9);
  }

  wait get_sound_length(var_0);

  foreach(var_9 in var_7) {
    set_vo_system_playing(var_9, 0);
  }

  level.announcer_vo_playing = 0;
}

function add_to_vo_queue(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_1) && isDefined(level.vo_functions[var_1])) {
    self thread[[level.vo_functions[var_1]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    return;
  }

  if(isDefined(var_1) && var_1 == "cp_comment_vo") {
    play_cp_comment_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    return;
  }

  if(isPlayer(self)) {
    if(isDefined(self.vo_prefix)) {
      var_7 = self.vo_prefix + var_0;
    } else {
      return;
    }

    thread play_vo_on_player(var_7, var_2, var_3, var_4, var_5, var_6, var_0);
    return;
  }

  var_7 = var_1;
  thread play_vo_on_all_players(level, var_7, var_3, var_4, var_5, var_6, var_7);
}

function play_vo_on_all_players(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  foreach(var_8 in level.players) {
    add_to_vo_system(var_8, var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }
}

function play_vo_on_player(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  add_to_vo_system(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

function add_to_vo_system(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(self.current_vo_queue)) {
    self.current_vo_queue = [];
  }

  thread add_to_vo_system_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

function add_to_vo_system_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 = get_validated_priority(var_1);
  var_7 = create_vo_data(var_0, var_2, var_4, var_5, var_6);

  if(should_interrupt_vo_system(var_3)) {
    add_to_interrupt_vo(var_7);

    if(is_vo_system_playing()) {
      interrupt_current_vo();
    }
  } else {
    add_to_queue_at_priority(var_7, var_1);
  }

  if(!is_vo_system_playing()) {
    notify_system_to_grab_next_vo_from_queue();
    return;
  }
}

function get_validated_priority(var_0) {
  if(!isDefined(var_0)) {
    return level.vo_priority_level[level.vo_priority_level.size - 1];
  }

  return var_0;
}

function create_vo_data(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 999;
  var_6 = 1.5;
  var_7 = 3;
  var_8 = spawnStruct();
  var_8.alias = var_0;
  var_8.categories = get_categories_from_alias(var_0);
  var_8.basealias = var_4;

  if(!isDefined(var_1)) {
    var_1 = var_5;
  }

  var_8.expire_time = gettime() + var_1 * 1000;

  if(!isDefined(var_2)) {
    var_2 = randomfloatrange(var_6, var_7);
  }

  var_8.pause_time = var_2;

  if(istrue(var_3)) {
    var_8.only_local = 1;
  } else {
    var_8.only_local = 0;
  }

  return var_8;
}

function should_interrupt_vo_system(var_0) {
  return isDefined(var_0) && var_0;
}

function add_to_interrupt_vo(var_0) {
  self.vo_system.interrupt_vo = var_0;
}

function is_vo_system_playing() {
  return istrue(self.vo_system.is_playing);
}

function interrupt_current_vo() {
  var_0 = get_current_vo_alias();

  if(isDefined(var_0)) {
    self stoplocalsound(var_0);
  }

  self notify("interrupt_current_VO");
}

function get_current_vo_alias() {
  if(isDefined(self.vo_system)) {
    if(isDefined(self.vo_system.vo_currently_playing)) {
      if(isDefined(self.vo_system.vo_currently_playing.alias)) {
        return self.vo_system.vo_currently_playing.alias;
      }
    }
  }

  return undefined;
}

function add_to_queue_at_priority(var_0, var_1) {
  self.vo_system.vo_queue[var_1][self.vo_system.vo_queue[var_1].size] = var_0;
}

function notify_system_to_grab_next_vo_from_queue() {
  self notify("play_VO_system");
}

function remove_vo_data(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in self.vo_system.vo_queue[var_1]) {
    if(!(var_4.alias == self.vo_prefix + var_0 || var_4.alias == self.vo_prefix + "plr_" + var_0)) {
      var_2 = self.vo_system.vo_queue[var_1][var_5];
    }
  }

  self.vo_system.vo_queue[var_1] = var_2;
}

function pause_vo_system(var_0) {
  if(var_0.size == 1) {
    var_0[0].pause_vo_system = 1;
    return;
  }

  foreach(var_2 in var_0) {
    var_2.pause_vo_system = 1;
  }
}

function unpause_vo_system(var_0) {
  foreach(var_2 in var_0) {
    var_2.pause_vo_system = 0;
  }

  foreach(var_2 in var_0) {
    var_2 notify("unpause_VO_system");
  }
}

function nag_vo_handler() {
  level endon("game_ended");

  if(!isDefined(level.nag_vo)) {
    level.nag_vo = [];
    level.nag_vo_never_play_again = [];
    level.pause_nag_vo = 0;
  }

  var_0 = 60;

  for(;;) {
    while(level.pause_nag_vo) {
      wait 0.1;
    }

    var_1 = gettime();

    foreach(var_4, var_3 in level.nag_vo) {
      if(var_1 > var_3.next_play_time) {
        if(isDefined(var_3.scope)) {
          try_to_play_vo(var_3.scope, var_4, var_3.vo_type, "low", 3, 0, 0, var_3.only_local);
        } else {
          try_to_play_vo(level, var_4, var_3.vo_type, "low", 3, 0, 0, var_3.only_local);
        }

        var_3.times_played++;

        if(var_3.max_times != -1 && var_3.max_times <= var_3.times_played) {
          remove_from_nag_vo(var_4);
        }

        var_3.next_play_time = var_1 + var_3.cooldown * min(var_3.times_played, 3) * 1000;
        wait var_0;
      }
    }

    wait 1;
  }
}

function add_to_nag_vo(var_0, var_1, var_2, var_3, var_4, var_5) {
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

  if(!isDefined(var_2)) {
    var_2 = 60;
  }

  if(!isDefined(var_1)) {
    var_1 = "zmb_comment_vo";
  }

  var_6 = undefined;

  if(isPlayer(self)) {
    var_6 = self;
  }

  var_7 = spawnStruct();
  var_7.times_played = 0;
  var_7.cooldown = var_2;
  var_7.vo_type = var_1;

  if(isDefined(var_6)) {
    var_7.scope = var_6;
  }

  if(isDefined(var_5)) {
    var_7.only_local = var_5;
  } else {
    var_7.only_local = 0;
  }

  if(isDefined(var_3)) {
    var_7.next_play_time = gettime() + var_3 * 1000;
  } else {
    var_7.next_play_time = 0;
  }

  if(isDefined(var_4)) {
    var_7.max_times = var_4;
  } else {
    var_7.max_times = -1;
  }

  level.nag_vo[var_0] = var_7;
}

function remove_from_nag_vo(var_0, var_1) {
  level.nag_vo = scripts\engine\utility::array_remove_index(level.nag_vo, var_0, 1);

  if(istrue(var_1)) {
    level.nag_vo_never_play_again[var_0] = 1;
    return;
  }
}

function timeoutvofunction(var_0, var_1) {
  level endon(var_0 + "_about_to_play");
  wait var_1;
  level notify(var_0 + "_timed_out");
}

function push_player_clear_of_door_way(var_0) {
  var_1 = tablelookup("cp/cp_vo_lookup.csv", 0, var_0, 1);

  if(isDefined(var_1)) {
    var_1 = float(var_1);
    return var_1;
  }

  return undefined;
}