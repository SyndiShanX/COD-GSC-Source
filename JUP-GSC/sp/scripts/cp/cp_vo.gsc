/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_vo.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\cp\cp_vo;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace cp_vo;

function function_83b8144a47850cdd() {
  level.vo_priority_level = ["highest", "high", "medium", "low"];
  level.vo_alias_data = [];
  level.vo_categories = [];
  level.vo_category_last_played_time = [];
  level.vo_dialogue_prefix = [];
  level.vo_table = "cp/" + getDvar(@ "ui_mapname") + "_vo_table.csv";
  level thread parse_vo_table();
  level thread nag_vo_handler();
}

function function_36bcbfd3365dc368() {
  init_vo_system();
  thread start_vo_system();
  level thread game_ended_vo_watcher();
}

function init_vo_system() {
  vo_system = spawnStruct();
  vo_system.vo_currently_playing = undefined;
  vo_system.interrupt_vo = undefined;
  vo_system.is_playing = 0;
  vo_queue = [];

  if(isDefined(level.vo_priority_level)) {
    foreach(priority_level in level.vo_priority_level) {
      vo_queue[priority_level] = [];
    }
  }

  vo_system.vo_queue = vo_queue;
  self.vo_system = vo_system;
  flag_init("vo_system_busy");
}

function parse_vo_table() {
  table = level.vo_table;
  row = 0;

  if(!tableexists(table)) {
    return;
  }

  while(true) {
    id = tablelookupbyrow(table, row, 0);

    if(id == "") {
      break;
    }

    alias_name = tablelookupbyrow(table, row, 1);
    cooldown = int(tablelookupbyrow(table, row, 2));
    chance_to_play = int(tablelookupbyrow(table, row, 3));
    max_plays = int(tablelookupbyrow(table, row, 4));
    category_1 = tablelookupbyrow(table, row, 5);
    category_2 = tablelookupbyrow(table, row, 6);
    waittillnotifyorflag = tablelookupbyrow(table, row, 7);
    dialogueprefix = tablelookupbyrow(table, row, 8);
    var_79ade81a56cbf98b = tablelookupbyrow(table, row, 9);
    onlylocal = int(tablelookupbyrow(table, row, 10));
    timeout = int(tablelookupbyrow(table, row, 11));
    priority = tablelookupbyrow(table, row, 12);
    var_4c576d2cfbdbe34 = int(tablelookupbyrow(table, row, 13));
    missingstub = tablelookupbyrow(table, row, 15);
    register_vo(id, alias_name, cooldown, chance_to_play, max_plays, category_1, category_2, waittillnotifyorflag, dialogueprefix, var_79ade81a56cbf98b, onlylocal, timeout, priority, var_4c576d2cfbdbe34, missingstub);

    if(row % 5 == 1) {
      wait 0.05;
    }

    row++;
  }
}

function register_vo(id, alias_name, cooldown, chance_to_play, max_plays, category_1, category_2, waittillnotifyorflag, dialogueprefix, nextdialogue, onlylocal, timeout, priority, pause_time, missingstub) {
  struct = spawnStruct();

  if(isDefined(cooldown) && cooldown > 0) {
    struct.cooldown = cooldown;
    struct.lastplayedtime = 0;
  }

  if(isDefined(missingstub)) {
    struct.missingstub = missingstub;
  }

  if(isDefined(pause_time) && pause_time > 0) {
    struct.pause_time = pause_time;
  }

  if(istrue(onlylocal)) {
    struct.onlylocal = 1;
  } else {
    struct.onlylocal = 0;
  }

  if(isDefined(timeout) && timeout > 0) {
    struct.timeout = timeout;
  }

  if(isDefined(priority)) {
    struct.priority = priority;
  }

  if(isDefined(max_plays) && max_plays > 0) {
    struct.max_plays = max_plays;
  }

  if(isDefined(chance_to_play) && chance_to_play > 0) {
    struct.chance_to_play = chance_to_play;
  }

  if(isDefined(waittillnotifyorflag) && waittillnotifyorflag != "") {
    struct.waittillnotifyorflag = waittillnotifyorflag;
  }

  if(isDefined(category_1) && category_1 != "") {
    if(!isDefined(level.vo_categories[category_1])) {
      level.vo_categories[category_1] = [];
    }

    struct.category_1 = category_1;
    level.vo_categories[category_1][level.vo_categories[category_1].size] = alias_name;

    if(!isDefined(level.vo_category_last_played_time[category_1])) {
      level.vo_category_last_played_time[category_1] = 0;
    }
  }

  if(isDefined(category_2) && category_2 != "") {
    if(!isDefined(level.vo_categories[category_2])) {
      level.vo_categories[category_2] = [];
    }

    struct.category_2 = category_2;
    level.vo_categories[category_2][level.vo_categories[category_2].size] = alias_name;

    if(!isDefined(level.vo_category_last_played_time[category_2])) {
      level.vo_category_last_played_time[category_2] = 0;
    }
  }

  if(isDefined(dialogueprefix) && dialogueprefix != "") {
    if(!isDefined(level.vo_dialogue_prefix[dialogueprefix])) {
      level.vo_dialogue_prefix[dialogueprefix] = [];
    }

    struct.dialogueprefix = dialogueprefix;
    level.vo_dialogue_prefix[alias_name] = dialogueprefix;
  }

  if(isDefined(nextdialogue) && nextdialogue != "") {
    struct.nextdialogue = nextdialogue;
  }

  level.vo_alias_data[alias_name] = struct;
}

function start_vo_system() {
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    if(is_vo_system_busy()) {
      if(flag_exist("vo_system_busy")) {
        flag_waitopen("vo_system_busy");
      }
    }

    vo_to_play = get_vo_to_play();

    if(!isDefined(vo_to_play)) {
      set_vo_system_playing(0);
      self waittill("play_VO_system");

      if(is_vo_system_paused()) {
        self waittill("unpause_VO_system");
      }

      continue;
    }

    play_vo_system(vo_to_play);
  }
}

function play_vo_system(vo_to_play) {
  self endon("disconnect");
  set_vo_system_playing(1);
  set_vo_currently_playing(vo_to_play);
  play_vo(vo_to_play);
  pause_between_vo(vo_to_play);
  unset_vo_currently_playing();
}

function get_vo_to_play() {
  vo_to_play = retrieve_interrupt_vo();

  if(isDefined(vo_to_play)) {
    return vo_to_play;
  }

  if(isDefined(level.vo_priority_level)) {
    foreach(priority_level in level.vo_priority_level) {
      vo_to_play = retrieve_vo_from_queue(priority_level);

      if(isDefined(vo_to_play)) {
        return vo_to_play;
      }
    }
  }

  return undefined;
}

function retrieve_interrupt_vo() {
  interrupt_vo = self.vo_system.interrupt_vo;
  reset_interrupt_vo();
  return interrupt_vo;
}

function reset_interrupt_vo() {
  self.vo_system.interrupt_vo = undefined;
}

function retrieve_vo_from_queue(priority) {
  remove_expired_vo_from_queue(priority);
  return pop_first_vo_out_of_queue(priority);
}

function pop_first_vo_out_of_queue(priority) {
  first_vo = self.vo_system.vo_queue[priority][0];

  if(!isDefined(first_vo)) {
    return first_vo;
  }

  new_array = [];

  for(array_index = 1; array_index < self.vo_system.vo_queue[priority].size; array_index++) {
    if(!isDefined(self.vo_system.vo_queue[priority][array_index])) {
      break;
    }

    new_array[array_index - 1] = self.vo_system.vo_queue[priority][array_index];
  }

  self.vo_system.vo_queue[priority] = new_array;
  return first_vo;
}

function remove_expired_vo_from_queue(priority) {
  current_time = gettime();
  new_array = [];

  foreach(vo_data in self.vo_system.vo_queue[priority]) {
    if(!vo_expired(vo_data, current_time)) {
      new_array[new_array.size] = self.vo_system.vo_queue[priority][array_index];
      continue;
    }

    println("<dev string:x1c>" + vo_data.alias + "<dev string:x36>");
  }

  self.vo_system.vo_queue[priority] = new_array;
}

function vo_expired(vo_data, current_time) {
  return current_time > vo_data.expire_time;
}

function set_vo_system_playing(bool) {
  if(!isPlayer(self) || !isDefined(self.vo_system)) {
    return;
  }

  self.vo_system.is_playing = bool;
}

function is_vo_system_paused() {
  return istrue(self.pause_vo_system);
}

function is_vo_system_busy() {
  return flag("vo_system_busy");
}

function set_vo_system_busy(bool) {
  level.vo_system_busy = bool;

  if(!bool) {
    flag_clear("vo_system_busy");
    return;
  }

  flag_set("vo_system_busy");
}

function set_vo_currently_playing(vo_to_play) {
  self.vo_system.vo_currently_playing = vo_to_play;
}

function game_ended_vo_watcher() {
  alias_append = "";
  level waittill("game_ended");

  foreach(player in level.players) {
    foreach(priority_level in level.vo_priority_level) {
      if(isDefined(player.vo_system.vo_queue[priority_level]) && player.vo_system.vo_queue[priority_level].size > 0) {
        foreach(vo_data in player.vo_system.vo_queue[priority_level]) {
          if(isDefined(vo_data)) {
            if(soundexists(vo_data.alias)) {
              player stoplocalsound(vo_data.alias);
            }
          }
        }

        player.vo_system.vo_queue[priority_level] = [];
      }
    }

    if(isDefined(level.dialogue_arr) && level.dialogue_arr.size > 0) {
      foreach(alias in level.dialogue_arr) {
        if(issubstr(alias, "pg_")) {
          player stoplocalsound(alias);
        }

        if(soundexists(player.vo_prefix + alias)) {
          player stoplocalsound(player.vo_prefix + alias);
        }

        if(soundexists(player.vo_prefix + "plr_" + alias)) {
          player stoplocalsound(player.vo_prefix + "plr_" + alias);
        }
      }
    }

    if(isDefined(player.current_vo_queue) && player.current_vo_queue.size > 0) {
      foreach(element in player.current_vo_queue) {
        if(isDefined(element)) {
          if(soundexists(element)) {
            player stoplocalsound(element);
            continue;
          }

          if(soundexists(player.vo_prefix + element)) {
            player stoplocalsound(player.vo_prefix + element);
            continue;
          }

          if(soundexists(player.vo_prefix + "plr_" + element)) {
            player stoplocalsound(player.vo_prefix + "plr_" + element);
          }
        }
      }
    }

    if(!isDefined(player.vo_prefix)) {
      return;
    }

    switch (player.vo_prefix) {
      case #"hash_8a36186c5286bc5f":
        alias_append = "_valley_girl";
        break;
      case #"hash_8a33186c52847dc8":
        alias_append = "_nerd";
        break;
      case #"hash_8a30586c5282a3f1":
        alias_append = "_rapper";
        break;
      case #"hash_8a2d586c5280655a":
        alias_append = "_jock";
        break;
      case #"hash_8a2a186c527dc203":
        alias_append = "_jock";
        break;
    }

    var_aca2e0282cbd3cfe = "mus_zombies" + alias_append;

    if(soundexists(var_aca2e0282cbd3cfe)) {
      player stoplocalsound("mus_zombies" + alias_append);
    }

    var_aca2e0282cbd3cfe = "mus_zombies" + alias_append + "_lsrs";

    if(soundexists(var_aca2e0282cbd3cfe)) {
      player stoplocalsound("mus_zombies" + alias_append + "_lsrs");
    }
  }
}

function play_vo(vo_to_play) {
  self endon("interrupt_current_VO");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(self.sessionstate != "playing") {
    return;
  }

  alias = vo_to_play.alias;

  if(!soundexists(alias)) {
    if(isDefined(level.vo_alias_data[alias]) && isDefined("level.vo_alias_data[alias].missingStub")) {
      iprintln(level.vo_alias_data[alias].missingstub);
    } else {
      iprintln("<dev string:x4b>" + alias);
    }

    wait 0.1;
    return;
  }

  self.vo_system_playing_vo = 1;

  if(is_playing_pain_breathing_sfx(self)) {
    pain_breathing_sfx_alias = get_pain_breathing_sfx_alias(self);

    if(isDefined(pain_breathing_sfx_alias)) {
      self stoplocalsound(pain_breathing_sfx_alias);
    }
  }

  println("<dev string:x57>" + alias);

  if(isDefined(vo_to_play.basealias)) {
    var_e77296b7f0ba0679 = vo_to_play.basealias;
  } else {
    var_e77296b7f0ba0679 = alias;
  }

  foreach(player in level.players) {
    if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
      continue;
    }

    if(isDefined(player.current_vo_queue)) {
      player.current_vo_queue = array_add(player.current_vo_queue, var_e77296b7f0ba0679);
    }

    if(player == self) {
      if(isDefined(level.get_alias_2d_func)) {
        alias_2d = [[level.get_alias_2d_func]](player, alias, var_e77296b7f0ba0679);
      } else {
        alias_2d = get_alias_2d_version(player, alias, var_e77296b7f0ba0679);
      }

      if(isDefined(alias_2d)) {
        player playlocalsound_safe(alias_2d);
      } else {
        player playlocalsound_safe(alias);
      }

      continue;
    }

    if(!istrue(vo_to_play.only_local) && soundexists(alias)) {
      self playsoundtoplayer(alias, player);
    }
  }

  foreach(category in vo_to_play.categories) {
    level.vo_category_last_played_time[category] = gettime();
  }

  if(!isDefined(self.num_of_plays[var_e77296b7f0ba0679])) {
    self.num_of_plays[var_e77296b7f0ba0679] = 1;
  } else {
    self.num_of_plays[var_e77296b7f0ba0679]++;
  }

  wait scripts\cp\cp_vo::get_sound_length(alias);
  self.vo_system_playing_vo = 0;
}

function alias_2d_version_exists(player, alias) {
  alias_2d_version = get_alias_2d_version(player, alias);
  return soundexists(alias_2d_version);
}

function get_alias_2d_version(player, alias, base_alias) {
  alias_array = strtok(alias, "_");

  if(alias_array[0] == "ww" || alias_array[0] == "dj" || alias_array[0] == "ks") {
    return alias;
  }

  if(isDefined(player.vo_prefix)) {
    new_alias = player.vo_prefix + "plr_" + base_alias;
  } else {
    new_alias = "plr_" + base_alias;
  }

  if(soundexists(new_alias)) {
    return new_alias;
  }

  return undefined;
}

function get_alias_3d_version(player, alias) {
  if(issubstr(alias, "ww_") || issubstr(alias, "dj_") || issubstr(alias, "p1_") || issubstr(alias, "p2_") || issubstr(alias, "p3_") || issubstr(alias, "p4_") || issubstr(alias, "jaroslav_anc")) {
    return alias;
  }

  var_d76b0a8e2967c78d = getsubstr(alias, player.vo_prefix.size);
  return player.vo_prefix + var_d76b0a8e2967c78d;
}

function get_sound_length(alias) {
  if(!soundexists(alias)) {
    return 0;
  }

  var_e9adc33e7669585 = lookupsoundlength(alias) / 1000 + 0.4;

  if(getdvarint(@ "loc_language") != 0 && getdvarint(@ "loc_language") != 1) {
    var_e9adc33e7669585 += 1.5;
  }

  lookup_len = get_length_from_table(alias);

  if(isDefined(lookup_len)) {
    var_e9adc33e7669585 = lookup_len;
  }

  return var_e9adc33e7669585;
}

function pause_between_vo(vo_to_play) {
  if(is_vo_system_paused()) {
    self waittill("unpause_VO_system");
  }

  if(vo_to_play.pause_time > 0) {
    wait vo_to_play.pause_time;
  }
}

function unset_vo_currently_playing() {
  self.vo_system.vo_currently_playing = undefined;
}

function try_to_play_vo_on_team(alias, team, is_nag, nag_cooldown, var_e2ce4e21e9100cb9) {
  players = getplayersinteam(team);

  if(!isDefined(alias)) {
    return;
  }

  if(players.size <= 0) {
    return;
  }

  if(!istrue(is_nag)) {
    level.isteamvoplaying = 1;

    if(isPlayer(self) || self == level || !isent(self)) {
      foreach(player in players) {
        player thread play_cp_comment_vo(alias, "cp_comment_vo", "highest", 10, 0, 0, 1);
      }
    } else {
      thread scripts\cp\utility::playsoundatpos_safe(self.origin, alias);
    }

    wait scripts\cp\cp_vo::get_sound_length(alias);
    level.isteamvoplaying = 0;
    return;
  }

  delay_before = 45;

  if(isDefined(var_e2ce4e21e9100cb9)) {
    delay_before = var_e2ce4e21e9100cb9;
  }

  delay_between = 60;

  if(isDefined(nag_cooldown)) {
    delay_between = nag_cooldown;
  }

  foreach(player in players) {
    player thread scripts\cp\cp_vo::add_to_nag_vo(alias, "cp_comment_vo", delay_between, delay_before, 6, 1);
  }
}

function try_to_play_vo_for_one_player(alias, player, is_nag, nag_cooldown, var_e2ce4e21e9100cb9) {
  if(!isDefined(alias)) {
    return;
  }

  if(!isDefined(player)) {
    return;
  }

  if(!istrue(is_nag)) {
    player thread try_to_play_vo(alias, "cp_comment_vo", "highest", 10, 0, 0, 1, 100);
    return;
  }

  delay_before = 45;

  if(isDefined(var_e2ce4e21e9100cb9)) {
    delay_before = var_e2ce4e21e9100cb9;
  }

  delay_between = 60;

  if(isDefined(nag_cooldown)) {
    delay_between = nag_cooldown;
  }

  player thread scripts\cp\cp_vo::add_to_nag_vo(alias, "cp_comment_vo", delay_between, delay_before, 6, 1);
}

function try_to_play_vo_on_all_players(alias, is_nag) {
  if(!isDefined(alias)) {
    return;
  }

  if(!isDefined(level.players)) {
    return;
  }

  if(!istrue(is_nag)) {
    foreach(player in level.players) {
      player thread try_to_play_vo(alias, "zmb_comment_vo", "highest", 10, 0, 0, 1, 100);
    }

    return;
  }

  foreach(player in level.players) {
    player thread scripts\cp\cp_vo::add_to_nag_vo(alias, "zmb_comment_vo", 60, 45, 6, 1);
  }
}

function try_to_play_vo(alias_string, vo_type, priority, timeout, interrupt, pause_time, only_local, chance_to_play) {
  var_c95bef4257b44781 = isDefined(level.vo_alias_data[alias_string]);
  aliasdata = ter_op(var_c95bef4257b44781, level.vo_alias_data[alias_string], undefined);

  if(!isDefined(chance_to_play)) {
    if(var_c95bef4257b44781) {
      if(isDefined(aliasdata.chance_to_play)) {
        chance_to_play = aliasdata.chance_to_play;
      }
    } else {
      chance_to_play = 100;
    }
  }

  if(getdvarint(@ "hash_2074ff36773f5d85", 0) != 0) {
    chance_to_play = 100;
  }

  if(randomint(100) > chance_to_play) {
    return;
  }

  if(should_play_vo(alias_string)) {
    if(getdvarint(@ "hash_1ff01a5d033f1ce0", 0) != 0 && istrue(interrupt)) {
      iprintln("<dev string:x80>" + alias_string);
    }

    if(!isDefined(pause_time) && var_c95bef4257b44781 && isDefined(aliasdata.pause_time)) {
      pause_time = aliasdata.pause_time;
    }

    if(!isDefined(only_local) && var_c95bef4257b44781 && isDefined(aliasdata.only_local)) {
      only_local = aliasdata.onlylocal;
    }

    if(!isDefined(timeout) && var_c95bef4257b44781 && isDefined(aliasdata.timeout)) {
      timeout = aliasdata.timeout;
    }

    if(!isDefined(priority) && var_c95bef4257b44781 && isDefined(aliasdata.priority)) {
      priority = aliasdata.priority;
    }

    categories = get_categories_from_alias(alias_string);

    foreach(category in categories) {
      level.vo_category_last_played_time[category] = gettime();
    }

    if(var_c95bef4257b44781 && isDefined(aliasdata.lastplayedtime)) {
      aliasdata.lastplayedtime = gettime();
    }

    thread add_to_vo_queue(alias_string, vo_type, priority, timeout, interrupt, pause_time, only_local);
  }
}

function should_play_vo(alias_string) {
  if(getdvarint(@ "hash_2074ff36773f5d85", 0) != 0) {
    return 1;
  }

  if(!isDefined(level.vo_alias_data[alias_string])) {
    return 1;
  }

  time = gettime();

  if(isDefined(level.vo_alias_data[alias_string].cooldown) && isDefined(level.vo_alias_data[alias_string].lastplayedtime)) {
    if(time < level.vo_alias_data[alias_string].lastplayedtime + level.vo_alias_data[alias_string].cooldown * 1000) {
      println("<dev string:x9a>" + alias_string + "<dev string:xaa>");
      return 0;
    }
  }

  categories = get_categories_from_alias(alias_string);

  foreach(category in categories) {
    cooldown = ter_op(isDefined(level.vo_alias_data[alias_string].cooldown), level.vo_alias_data[alias_string].cooldown, 30);

    if(time < level.vo_category_last_played_time[category] + cooldown * 1000) {
      println("<dev string:xbc>" + category + "<dev string:xcf>" + alias_string + "<dev string:xe0>");
      return 0;
    }
  }

  if(isDefined(level.vo_alias_data[alias_string].max_plays)) {
    if(!isDefined(self.num_of_plays)) {
      self.num_of_plays = [];
    }

    if(!isDefined(self.num_of_plays[alias_string])) {
      self.num_of_plays[alias_string] = 0;
    }

    if(self.num_of_plays[alias_string] < level.vo_alias_data[alias_string].max_plays) {
      return 1;
    } else {
      println("<dev string:xf3>" + alias_string + "<dev string:xfa>" + self.num_of_plays[alias_string] + "<dev string:x12d>");
      return 0;
    }

    return;
  }

  return 1;
}

function get_categories_from_alias(alias_string) {
  if(!isDefined(level.vo_categories)) {
    return [];
  }

  keys = getarraykeys(level.vo_categories);
  temp_array = [];

  foreach(key in keys) {
    if(array_contains(level.vo_categories[key], alias_string)) {
      temp_array[temp_array.size] = key;
    }
  }

  return temp_array;
}

function play_cp_comment_vo(alias_string, vo_type, priority, timeout, interrupt, pause_time, only_local) {
  level endon("game_ended");
  level.announcer_vo_playing = 1;
  player_array = level.players;

  if(isPlayer(self)) {
    player_array = [self];
  }

  foreach(player in player_array) {
    if(!isDefined(player)) {
      continue;
    }

    if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
      continue;
    }

    println("<dev string:x132>" + alias_string + "<dev string:x155>");

    if(getdvarint(@ "hash_1ff01a5d033f1ce0") == 1) {
      iprintlnbold("<dev string:x159>" + alias_string);
    }

    vo_to_play = scripts\cp\cp_vo::create_vo_data(alias_string, timeout, pause_time, only_local);
    player thread scripts\cp\cp_vo::play_vo_system(vo_to_play);
  }

  wait scripts\cp\cp_vo::get_sound_length(alias_string);

  foreach(player in player_array) {
    player set_vo_system_playing(0);
  }

  level.announcer_vo_playing = 0;
}

function add_to_vo_queue(alias_string, vo_type, priority, timeout, interrupt, pause_time, only_local) {
  if(isDefined(vo_type) && isDefined(level.vo_functions[vo_type])) {
    self thread[[level.vo_functions[vo_type]]](alias_string, vo_type, priority, timeout, interrupt, pause_time, only_local);
    return;
  }

  if(isDefined(vo_type) && vo_type == "cp_comment_vo") {
    play_cp_comment_vo(alias_string, vo_type, priority, timeout, interrupt, pause_time, only_local);
    return;
  }

  if(isPlayer(self)) {
    if(isDefined(self.vo_prefix)) {
      alias = self.vo_prefix + alias_string;
    } else {
      return;
    }

    thread play_vo_on_player(alias, priority, timeout, interrupt, pause_time, only_local, alias_string);
    return;
  }

  alias = alias_string;
  level thread play_vo_on_all_players(alias, priority, timeout, interrupt, pause_time, only_local, alias_string);
}

function play_vo_on_all_players(alias, priority, timeout, interrupt, pause_time, only_local, basealias) {
  if(getdvarint(@ "hash_1ff01a5d033f1ce0") == 1) {
    iprintlnbold("<dev string:x159>" + alias);
  }

  foreach(player in level.players) {
    player add_to_vo_system(alias, priority, timeout, interrupt, pause_time, only_local, basealias);
  }
}

function play_vo_on_player(alias, priority, timeout, interrupt, pause_time, only_local, basealias) {
  if(getdvarint(@ "hash_1ff01a5d033f1ce0") == 1) {
    iprintlnbold("<dev string:x159>" + alias);
  }

  add_to_vo_system(alias, priority, timeout, interrupt, pause_time, only_local, basealias);
}

function add_to_vo_system(alias, priority, timeout, interrupt, pause_time, only_local, basealias) {
  if(!isDefined(self.current_vo_queue)) {
    self.current_vo_queue = [];
  }

  thread add_to_vo_system_internal(alias, priority, timeout, interrupt, pause_time, only_local, basealias);
}

function add_to_vo_system_internal(alias, priority, timeout, interrupt, pause_time, only_local, basealias) {
  priority = get_validated_priority(priority);
  println("<dev string:x174>" + alias + "<dev string:x195>");
  vo_data = create_vo_data(alias, timeout, pause_time, only_local, basealias);

  if(should_interrupt_vo_system(interrupt)) {
    add_to_interrupt_vo(vo_data);

    if(is_vo_system_playing()) {
      interrupt_current_vo();
    }
  } else {
    add_to_queue_at_priority(vo_data, priority);
  }

  if(!is_vo_system_playing()) {
    notify_system_to_grab_next_vo_from_queue();
  }
}

function get_validated_priority(priority) {
  if(!isDefined(priority)) {
    return level.vo_priority_level[level.vo_priority_level.size - 1];
  }

  assertex(scripts\engine\utility::array_contains(level.vo_priority_level, priority), "'" + priority + "' is not a valid priority level.");
  return priority;
}

function create_vo_data(alias, timeout, pause_time, only_local, basealias) {
  default_timeout = 999;
  var_356385d16d2bfe7a = 1.5;
  var_2909ac11ec70c778 = 3;
  vo_data = spawnStruct();
  vo_data.alias = alias;
  vo_data.categories = get_categories_from_alias(alias);
  vo_data.basealias = basealias;

  if(!isDefined(timeout)) {
    timeout = default_timeout;
  }

  vo_data.expire_time = gettime() + timeout * 1000;

  if(!isDefined(pause_time)) {
    pause_time = randomfloatrange(var_356385d16d2bfe7a, var_2909ac11ec70c778);
  }

  vo_data.pause_time = pause_time;

  if(istrue(only_local)) {
    vo_data.only_local = 1;
  } else {
    vo_data.only_local = 0;
  }

  return vo_data;
}

function should_interrupt_vo_system(interrupt) {
  return isDefined(interrupt) && interrupt;
}

function add_to_interrupt_vo(vo_data) {
  self.vo_system.interrupt_vo = vo_data;
}

function is_vo_system_playing() {
  return istrue(self.vo_system.is_playing);
}

function interrupt_current_vo() {
  current_vo_alias = get_current_vo_alias();

  if(isDefined(current_vo_alias)) {
    self stoplocalsound(current_vo_alias);
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

function add_to_queue_at_priority(vo_data, priority) {
  self.vo_system.vo_queue[priority][self.vo_system.vo_queue[priority].size] = vo_data;
}

function notify_system_to_grab_next_vo_from_queue() {
  self notify("play_VO_system");
}

function remove_vo_data(alias_substring, priority) {
  new_array = [];

  foreach(vo_data in self.vo_system.vo_queue[priority]) {
    if(!(vo_data.alias == self.vo_prefix + alias_substring || vo_data.alias == self.vo_prefix + "plr_" + alias_substring)) {
      new_array[new_array.size] = self.vo_system.vo_queue[priority][array_index];
    }
  }

  self.vo_system.vo_queue[priority] = new_array;
}

function pause_vo_system(player_list) {
  if(player_list.size == 1) {
    player_list[0].pause_vo_system = 1;
    return;
  }

  foreach(player in player_list) {
    player.pause_vo_system = 1;
  }
}

function unpause_vo_system(player_list) {
  foreach(player in player_list) {
    player.pause_vo_system = 0;
  }

  foreach(player in player_list) {
    player notify("unpause_VO_system");
  }
}

function nag_vo_handler() {
  level endon("game_ended");

  if(!isDefined(level.nag_vo)) {
    level.nag_vo = [];
    level.nag_vo_never_play_again = [];
    level.pause_nag_vo = 0;
  }

  nag_cooldown = 60;

  while(true) {
    while(level.pause_nag_vo) {
      wait 0.1;
    }

    time = gettime();

    foreach(alias, nag_struct in level.nag_vo) {
      if(time > nag_struct.next_play_time) {
        if(isDefined(nag_struct.scope)) {
          nag_struct.scope try_to_play_vo(alias, nag_struct.vo_type, "low", 3, 0, 0, nag_struct.only_local);
        } else {
          level try_to_play_vo(alias, nag_struct.vo_type, "low", 3, 0, 0, nag_struct.only_local);
        }

        nag_struct.times_played++;

        if(nag_struct.max_times != -1 && nag_struct.max_times <= nag_struct.times_played) {
          remove_from_nag_vo(alias);
        }

        nag_struct.next_play_time = time + nag_struct.cooldown * min(nag_struct.times_played, 3) * 1000;
        wait nag_cooldown;
      }
    }

    wait 1;
  }
}

function add_to_nag_vo(alias, vo_type, cooldown_time, var_1e486b6da797b22, max_times, only_local) {
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

  if(!isDefined(cooldown_time)) {
    cooldown_time = 60;
  }

  if(!isDefined(vo_type)) {
    vo_type = "zmb_comment_vo";
  }

  vo_scope = undefined;

  if(isPlayer(self)) {
    vo_scope = self;
  }

  var_a68342c9c3067ef7 = spawnStruct();
  var_a68342c9c3067ef7.times_played = 0;
  var_a68342c9c3067ef7.cooldown = cooldown_time;
  var_a68342c9c3067ef7.vo_type = vo_type;

  if(isDefined(vo_scope)) {
    var_a68342c9c3067ef7.scope = vo_scope;
  }

  if(isDefined(only_local)) {
    var_a68342c9c3067ef7.only_local = only_local;
  } else {
    var_a68342c9c3067ef7.only_local = 0;
  }

  if(isDefined(var_1e486b6da797b22)) {
    var_a68342c9c3067ef7.next_play_time = gettime() + var_1e486b6da797b22 * 1000;
  } else {
    var_a68342c9c3067ef7.next_play_time = 0;
  }

  if(isDefined(max_times)) {
    var_a68342c9c3067ef7.max_times = max_times;
  } else {
    var_a68342c9c3067ef7.max_times = -1;
  }

  level.nag_vo[alias] = var_a68342c9c3067ef7;
}

function remove_from_nag_vo(alias, never_again) {
  level.nag_vo = array_remove_index(level.nag_vo, alias, 1);

  if(istrue(never_again)) {
    level.nag_vo_never_play_again[alias] = 1;
  }
}

function get_length_from_table(alias) {
  len = tablelookup("cp/cp_vo_lookup.csv", 0, alias, 1);

  if(isDefined(len)) {
    len = float(len);
    return len;
  }

  return undefined;
}