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
  level.vo_table = "cp/" + getDvar("NSQLTTMRMP") + "_vo_table.csv";
  thread parse_vo_table();
  thread nag_vo_handler();
}

function initandstartvosystem() {
  init_vo_system();
  thread start_vo_system();
  thread game_ended_vo_watcher();
}

function init_vo_system() {
  var0 = spawnStruct();
  var0.vo_currently_playing = undefined;
  var0.interrupt_vo = undefined;
  var0.is_playing = 0;
  var1 = [];

  if(isDefined(level.vo_priority_level)) {
    foreach(var3 in level.vo_priority_level) {
      var1 = [];
    }
  }

  var0.vo_queue = var1;
  self.vo_system = var0;
  scripts\engine\utility::flag_init("vo_system_busy");
}

function parse_vo_table() {
  var0 = level.vo_table;
  var1 = 0;
  jumpiftrue(tableexists(var0)) LOC_00000013;
  return;
}

function register_vo(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14) {
  var15 = spawnStruct();

  if(isDefined(var2) && var2 > 0) {
    var15.cooldown = var2;
    var15.lastplayedtime = 0;
  }

  if(isDefined(var14)) {
    var15.missingstub = var14;
  }

  if(isDefined(var13) && var13 > 0) {
    var15.pause_time = var13;
  }

  if(istrue(var10)) {
    var15.onlylocal = 1;
  } else {
    var15.onlylocal = 0;
  }

  if(isDefined(var11) && var11 > 0) {
    var15.timeout = var11;
  }

  if(isDefined(var12)) {
    var15.priority = var12;
  }

  if(isDefined(var4) && var4 > 0) {
    var15.max_plays = var4;
  }

  if(isDefined(var3) && var3 > 0) {
    var15.chance_to_play = var3;
  }

  if(isDefined(var7) && var7 != "") {
    var15.waittillnotifyorflag = var7;
  }

  if(isDefined(var5) && var5 != "") {
    if(!isDefined(level.vo_categories[var5])) {
      level.vo_categories[var5] = [];
    }

    var15.category_1 = var5;
    level.vo_categories[var5][level.vo_categories[var5].size] = var1;

    if(!isDefined(level.vo_category_last_played_time[var5])) {
      level.vo_category_last_played_time[var5] = 0;
    }
  }

  if(isDefined(var6) && var6 != "") {
    if(!isDefined(level.vo_categories[var6])) {
      level.vo_categories[var6] = [];
    }

    var15.category_2 = var6;
    level.vo_categories[var6][level.vo_categories[var6].size] = var1;

    if(!isDefined(level.vo_category_last_played_time[var6])) {
      level.vo_category_last_played_time[var6] = 0;
    }
  }

  if(isDefined(var8) && var8 != "") {
    if(!isDefined(level.vo_dialogue_prefix[var8])) {
      level.vo_dialogue_prefix[var8] = [];
    }

    var15.dialogueprefix = var8;
    level.vo_dialogue_prefix[var1] = var8;
  }

  if(isDefined(var9) && var9 != "") {
    var15.nextdialogue = var9;
  }

  level.vo_alias_data[var1] = var15;
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

    var0 = get_vo_to_play();

    if(!isDefined(var0)) {
      set_vo_system_playing(0);
      self waittill("play_VO_system");

      if(is_vo_system_paused()) {
        self waittill("unpause_VO_system");
      }

      continue;
    }

    play_vo_system(var0);
  }
}

function play_vo_system(var0) {
  self endon("disconnect");
  set_vo_system_playing(1);
  set_vo_currently_playing(var0);
  play_vo(var0);
  pause_between_vo(var0);
  unset_vo_currently_playing();
}

function get_vo_to_play() {
  var0 = retrieve_interrupt_vo();

  if(isDefined(var0)) {
    return var0;
  }

  if(isDefined(level.vo_priority_level)) {
    foreach(var2 in level.vo_priority_level) {
      var0 = retrieve_vo_from_queue(var2);

      if(isDefined(var0)) {
        return var0;
      }
    }
  }

  return undefined;
}

function retrieve_interrupt_vo() {
  var0 = self.vo_system.interrupt_vo;
  reset_interrupt_vo();
  return var0;
}

function reset_interrupt_vo() {
  self.vo_system.interrupt_vo = undefined;
}

function retrieve_vo_from_queue(var0) {
  remove_expired_vo_from_queue(var0);
  return pop_first_vo_out_of_queue(var0);
}

function pop_first_vo_out_of_queue(var0) {
  var1 = self.vo_system.vo_queue[var0][0];

  if(!isDefined(var1)) {
    return var1;
  }

  var2 = [];

  for(var3 = 1; var3 < self.vo_system.vo_queue[var0].size; var3++) {
    if(!isDefined(self.vo_system.vo_queue[var0][var3])) {
      break;
    }

    var2 = self.vo_system.vo_queue[var0][var3];
  }

  self.vo_system.vo_queue[var0] = var2;
  return var1;
}

function remove_expired_vo_from_queue(var0) {
  var1 = gettime();
  var2 = [];

  foreach(var4 in self.vo_system.vo_queue[var0]) {
    if(!vo_expired(var4, var1)) {
      var2 = self.vo_system.vo_queue[var0][var5];
    }
  }

  self.vo_system.vo_queue[var0] = var2;
}

function vo_expired(var0, var1) {
  return var1 > var0.expire_time;
}

function set_vo_system_playing(var0) {
  if(!isPlayer(self) || !isDefined(self.vo_system)) {
    return;
  }

  self.vo_system.is_playing = var0;
}

function is_vo_system_paused() {
  return istrue(self.pause_vo_system);
}

function is_vo_system_busy() {
  return scripts\engine\utility::flag("vo_system_busy");
}

function set_vo_system_busy(var0) {
  level.vo_system_busy = var0;

  if(!var0) {
    scripts\engine\utility::flag_clear("vo_system_busy");
    return;
  }

  scripts\engine\utility::flag_set("vo_system_busy");
}

function set_vo_currently_playing(var0) {
  self.vo_system.vo_currently_playing = var0;
}

function game_ended_vo_watcher() {
  var0 = "";
  level waittill("game_ended");

  foreach(var2 in level.players) {
    foreach(var4 in level.vo_priority_level) {
      if(isDefined(var2.vo_system.vo_queue[var4]) && var2.vo_system.vo_queue[var4].size > 0) {
        foreach(var6 in var2.vo_system.vo_queue[var4]) {
          if(isDefined(var6)) {
            if(soundexists(var6.alias)) {
              var2 stoplocalsound(var6.alias);
            }
          }
        }

        var2.vo_system.vo_queue[var4] = [];
      }
    }

    if(isDefined(level.dialogue_arr) && level.dialogue_arr.size > 0) {
      foreach(var10 in level.dialogue_arr) {
        if(issubstr(var10, "pg_")) {
          var2 stoplocalsound(var10);
        }

        if(soundexists(var2.vo_prefix + var10)) {
          var2 stoplocalsound(var2.vo_prefix + var10);
        }

        if(soundexists(var2.vo_prefix + "plr_" + var10)) {
          var2 stoplocalsound(var2.vo_prefix + "plr_" + var10);
        }
      }
    }

    if(isDefined(var2.current_vo_queue) && var2.current_vo_queue.size > 0) {
      foreach(var13 in var2.current_vo_queue) {
        if(isDefined(var13)) {
          if(soundexists(var13)) {
            var2 stoplocalsound(var13);
            continue;
          }

          if(soundexists(var2.vo_prefix + var13)) {
            var2 stoplocalsound(var2.vo_prefix + var13);
            continue;
          }

          if(soundexists(var2.vo_prefix + "plr_" + var13)) {
            var2 stoplocalsound(var2.vo_prefix + "plr_" + var13);
          }
        }
      }
    }

    if(!isDefined(var2.vo_prefix)) {
      return;
    }

    switch (var2.vo_prefix) {
      case "p1_":
        var0 = "_valley_girl";
        break;
      case "p2_":
        var0 = "_nerd";
        break;
      case "p3_":
        var0 = "_rapper";
        break;
      case "p4_":
        var0 = "_jock";
        break;
      case "p5_":
        var0 = "_jock";
        break;
    }

    var15 = "mus_zombies" + var0;

    if(soundexists(var15)) {
      var2 stoplocalsound("mus_zombies" + var0);
    }

    var15 = "mus_zombies" + var0 + "_lsrs";

    if(soundexists(var15)) {
      var2 stoplocalsound("mus_zombies" + var0 + "_lsrs");
    }
  }
}

function play_vo(var0) {
  self endon("interrupt_current_VO");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(self.sessionstate != "playing") {
    return;
  }

  var1 = var0.alias;

  if(!soundexists(var1)) {
    if(isDefined(level.vo_alias_data[var1]) && isDefined("level.vo_alias_data[alias].missingStub")) {}

    wait 0.1;
    return;
  }

  self.vo_system_playing_vo = 1;

  if(scripts\cp\utility::is_playing_pain_breathing_sfx(self)) {
    var2 = scripts\cp\utility::get_pain_breathing_sfx_alias(self);

    if(isDefined(var2)) {
      self stoplocalsound(var2);
    }
  }

  if(isDefined(var0.basealias)) {
    var3 = var0.basealias;
  } else {
    var3 = var3;
  }

  foreach(var5 in level.players) {
    if(var5 issplitscreenplayer() && !var5 issplitscreenplayerprimary()) {
      continue;
    }

    if(isDefined(var5.current_vo_queue)) {
      var5.current_vo_queue = scripts\engine\utility::array_add(var5.current_vo_queue, var3);
    }

    if(var5 == self) {
      if(isDefined(level.get_alias_2d_func)) {
        var6 = [[level.get_alias_2d_func]](var5, var3, var3);
      } else {
        var6 = get_alias_2d_version(var7, var3, var4);
      }

      if(isDefined(var6)) {
        var7 scripts\cp\utility::playlocalsound_safe(var6);
      } else {
        var7 scripts\cp\utility::playlocalsound_safe(var3);
      }

      continue;
    }

    if(!istrue(var3.only_local) && soundexists(var3)) {
      self playsoundtoplayer(var3, var7);
    }
  }

  var5 = undefined;
  var6 = undefined;

  foreach(var9 in var3.categories) {
    level.vo_category_last_played_time[var9] = gettime();
  }

  if(!isDefined(self.num_of_plays[var4])) {
    self.num_of_plays[var4] = 1;
  } else {
    self.num_of_plays[var4]++;
  }

  wait get_sound_length(var3);
  self.vo_system_playing_vo = 0;
}

function alias_2d_version_exists(var0, var1) {
  var2 = get_alias_2d_version(var0, var1);
  return soundexists(var2);
}

function get_alias_2d_version(var0, var1, var2) {
  var3 = strtok(var1, "_");

  if(var3[0] == "ww" || var3[0] == "dj" || var3[0] == "ks") {
    return var1;
  }

  if(isDefined(var0.vo_prefix)) {
    var4 = var0.vo_prefix + "plr_" + var2;
  } else {
    var4 = "plr_" + var3;
  }

  if(soundexists(var4)) {
    return var4;
  }

  return undefined;
}

function get_alias_3d_version(var0, var1) {
  if(issubstr(var1, "ww_") || issubstr(var1, "dj_") || issubstr(var1, "p1_") || issubstr(var1, "p2_") || issubstr(var1, "p3_") || issubstr(var1, "p4_") || issubstr(var1, "jaroslav_anc")) {
    return var1;
  }

  var2 = getsubstr(var1, var0.vo_prefix.size);
  return var0.vo_prefix + var2;
}

function get_sound_length(var0) {
  if(!soundexists(var0)) {
    return 0;
  }

  var1 = lookupsoundlength(var0) / 1000 + 0.4;

  if(getdvarint("PMKLQQKSO") != 0 && getdvarint("PMKLQQKSO") != 1) {
    var1 += 1.5;
  }

  var2 = push_player_clear_of_door_way(var0);

  if(isDefined(var2)) {
    var1 = var2;
  }

  return var1;
}

function pause_between_vo(var0) {
  if(is_vo_system_paused()) {
    self waittill("unpause_VO_system");
  }

  if(var0.pause_time > 0) {
    wait var0.pause_time;
    return;
  }
}

function unset_vo_currently_playing() {
  self.vo_system.vo_currently_playing = undefined;
}

function try_to_play_vo_on_team(var0, var1, var2, var3, var4) {
  var5 = scripts\cp\utility::getplayersinteam(var1);

  if(!isDefined(var0)) {
    return;
  }

  if(var5.size <= 0) {
    return;
  }

  if(!istrue(var2)) {
    level.validatealivecount = 1;

    if(isPlayer(self) || self == level || !isent(self)) {
      foreach(var7 in var5) {
        thread play_cp_comment_vo(var7, var0, "cp_comment_vo", "highest", 10, 0, 0);
      }
    } else {
      thread scripts\cp\utility::playsoundatpos_safe(self.origin, var0);
    }

    wait get_sound_length(var0);
    level.validatealivecount = 0;
    return;
  }

  var9 = 45;

  if(isDefined(var4)) {
    var9 = var4;
  }

  var10 = 60;

  if(isDefined(var3)) {
    var10 = var3;
  }

  foreach(var7 in var5) {
    thread add_to_nag_vo(var7, var0, "cp_comment_vo", var10, var9, 6);
  }
}

function try_to_play_vo_for_one_player(var0, var1, var2, var3, var4) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var1)) {
    return;
  }

  if(!istrue(var2)) {
    thread try_to_play_vo(var1, var0, "cp_comment_vo", "highest", 10, 0, 0, 1);
    return;
  }

  var5 = 45;

  if(isDefined(var4)) {
    var5 = var4;
  }

  var6 = 60;

  if(isDefined(var3)) {
    var6 = var3;
  }

  thread add_to_nag_vo(var1, var0, "cp_comment_vo", var6, var5, 6);
}

function try_to_play_vo_on_all_players(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(level.players)) {
    return;
  }

  jumpiftrue(istrue(var1)) LOC_0000005b;

  foreach(var3 in level.players) {
    thread try_to_play_vo(var3, var0, "zmb_comment_vo", "highest", 10, 0, 0, 1);
  }

  return;
}

function try_to_play_vo(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = isDefined(level.vo_alias_data[var0]);
  var9 = scripts\engine\utility::ter_op(var8, level.vo_alias_data[var0], undefined);

  if(!isDefined(var7)) {
    if(var8) {
      if(isDefined(var9.chance_to_play)) {
        var7 = var9.chance_to_play;
      }
    } else {
      var7 = 100;
    }
  }

  if(randomint(100) > var7) {
    return;
  }

  if(should_play_vo(var0)) {
    if(!isDefined(var5) && var8 && isDefined(var9.pause_time)) {
      var5 = var9.pause_time;
    }

    if(!isDefined(var6) && var8 && isDefined(var9.only_local)) {
      var6 = var9.onlylocal;
    }

    if(!isDefined(var3) && var8 && isDefined(var9.timeout)) {
      var3 = var9.timeout;
    }

    if(!isDefined(var2) && var8 && isDefined(var9.priority)) {
      var2 = var9.priority;
    }

    var10 = get_categories_from_alias(var0);

    foreach(var12 in var10) {
      level.vo_category_last_played_time[var12] = gettime();
    }

    if(var8 && isDefined(var9.lastplayedtime)) {
      var9.lastplayedtime = gettime();
    }

    thread add_to_vo_queue(var0, var1, var2, var3, var4, var5, var6);
    return;
  }
}

function should_play_vo(var0) {
  if(!isDefined(level.vo_alias_data[var0])) {
    return 1;
  }

  var1 = gettime();

  if(isDefined(level.vo_alias_data[var0].cooldown) && isDefined(level.vo_alias_data[var0].lastplayedtime)) {
    if(var1 < level.vo_alias_data[var0].lastplayedtime + level.vo_alias_data[var0].cooldown * 1000) {
      return 0;
    }
  }

  var2 = get_categories_from_alias(var0);

  foreach(var4 in var2) {
    var5 = scripts\engine\utility::ter_op(isDefined(level.vo_alias_data[var0].cooldown), level.vo_alias_data[var0].cooldown, 30);

    if(var1 < level.vo_category_last_played_time[var4] + var5 * 1000) {
      return 0;
    }
  }

  if(isDefined(level.vo_alias_data[var0].max_plays)) {
    if(!isDefined(self.num_of_plays)) {
      self.num_of_plays = [];
    }

    if(!isDefined(self.num_of_plays[var0])) {
      self.num_of_plays[var0] = 0;
    }

    if(self.num_of_plays[var0] < level.vo_alias_data[var0].max_plays) {
      return 1;
    }

    return 0;
  }

  return 1;
}

function get_categories_from_alias(var0) {
  if(!isDefined(level.vo_categories)) {
    return [];
  }

  var1 = getarraykeys(level.vo_categories);
  var2 = [];

  foreach(var4 in var1) {
    if(scripts\engine\utility::array_contains(level.vo_categories[var4], var0)) {
      var2 = var4;
    }
  }

  return var2;
}

function should_append_player_prefix(var0) {
  if(issubstr(var0, "ww_") || issubstr(var0, "dj_") || issubstr(var0, "jaroslav_anc")) {
    return 0;
  }

  return 1;
}

function should_append_player_suffix(var0, var1) {
  if(istrue(var1)) {
    if(issubstr(var0, "ww_") && issubstr(var0, "_p")) {
      return true;
    } else {
      return false;
    }
  }

  return false;
}

function play_cp_comment_vo(var0, var1, var2, var3, var4, var5, var6) {
  level endon("game_ended");
  level.announcer_vo_playing = 1;
  var7 = level.players;

  if(isPlayer(self)) {
    var7 = [self];
  }

  foreach(var9 in var7) {
    if(!isDefined(var9)) {
      continue;
    }

    if(var9 issplitscreenplayer() && !var9 issplitscreenplayerprimary()) {
      continue;
    }

    var10 = create_vo_data(var0, var3, var5, var6);
    thread play_vo_system(var9);
  }

  wait get_sound_length(var0);

  foreach(var9 in var7) {
    set_vo_system_playing(var9, 0);
  }

  level.announcer_vo_playing = 0;
}

function add_to_vo_queue(var0, var1, var2, var3, var4, var5, var6) {
  if(isDefined(var1) && isDefined(level.vo_functions[var1])) {
    self thread[[level.vo_functions[var1]]](var0, var1, var2, var3, var4, var5, var6);
    return;
  }

  if(isDefined(var1) && var1 == "cp_comment_vo") {
    play_cp_comment_vo(var0, var1, var2, var3, var4, var5, var6);
    return;
  }

  if(isPlayer(self)) {
    if(isDefined(self.vo_prefix)) {
      var7 = self.vo_prefix + var0;
    } else {
      return;
    }

    thread play_vo_on_player(var7, var2, var3, var4, var5, var6, var0);
    return;
  }

  var7 = var1;
  thread play_vo_on_all_players(level, var7, var3, var4, var5, var6, var7);
}

function play_vo_on_all_players(var0, var1, var2, var3, var4, var5, var6) {
  foreach(var8 in level.players) {
    add_to_vo_system(var8, var0, var1, var2, var3, var4, var5, var6);
  }
}

function play_vo_on_player(var0, var1, var2, var3, var4, var5, var6) {
  add_to_vo_system(var0, var1, var2, var3, var4, var5, var6);
}

function add_to_vo_system(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(self.current_vo_queue)) {
    self.current_vo_queue = [];
  }

  thread add_to_vo_system_internal(var0, var1, var2, var3, var4, var5, var6);
}

function add_to_vo_system_internal(var0, var1, var2, var3, var4, var5, var6) {
  var1 = get_validated_priority(var1);
  var7 = create_vo_data(var0, var2, var4, var5, var6);

  if(should_interrupt_vo_system(var3)) {
    add_to_interrupt_vo(var7);

    if(is_vo_system_playing()) {
      interrupt_current_vo();
    }
  } else {
    add_to_queue_at_priority(var7, var1);
  }

  if(!is_vo_system_playing()) {
    notify_system_to_grab_next_vo_from_queue();
    return;
  }
}

function get_validated_priority(var0) {
  if(!isDefined(var0)) {
    return level.vo_priority_level[level.vo_priority_level.size - 1];
  }

  return var0;
}

function create_vo_data(var0, var1, var2, var3, var4) {
  var5 = 999;
  var6 = 1.5;
  var7 = 3;
  var8 = spawnStruct();
  var8.alias = var0;
  var8.categories = get_categories_from_alias(var0);
  var8.basealias = var4;

  if(!isDefined(var1)) {
    var1 = var5;
  }

  var8.expire_time = gettime() + var1 * 1000;

  if(!isDefined(var2)) {
    var2 = randomfloatrange(var6, var7);
  }

  var8.pause_time = var2;

  if(istrue(var3)) {
    var8.only_local = 1;
  } else {
    var8.only_local = 0;
  }

  return var8;
}

function should_interrupt_vo_system(var0) {
  return isDefined(var0) && var0;
}

function add_to_interrupt_vo(var0) {
  self.vo_system.interrupt_vo = var0;
}

function is_vo_system_playing() {
  return istrue(self.vo_system.is_playing);
}

function interrupt_current_vo() {
  var0 = get_current_vo_alias();

  if(isDefined(var0)) {
    self stoplocalsound(var0);
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

function add_to_queue_at_priority(var0, var1) {
  self.vo_system.vo_queue[var1][self.vo_system.vo_queue[var1].size] = var0;
}

function notify_system_to_grab_next_vo_from_queue() {
  self notify("play_VO_system");
}

function remove_vo_data(var0, var1) {
  var2 = [];

  foreach(var4 in self.vo_system.vo_queue[var1]) {
    if(!(var4.alias == self.vo_prefix + var0 || var4.alias == self.vo_prefix + "plr_" + var0)) {
      var2 = self.vo_system.vo_queue[var1][var5];
    }
  }

  self.vo_system.vo_queue[var1] = var2;
}

function pause_vo_system(var0) {
  if(var0.size == 1) {
    var0[0].pause_vo_system = 1;
    return;
  }

  foreach(var2 in var0) {
    var2.pause_vo_system = 1;
  }
}

function unpause_vo_system(var0) {
  foreach(var2 in var0) {
    var2.pause_vo_system = 0;
  }

  foreach(var2 in var0) {
    var2 notify("unpause_VO_system");
  }
}

function nag_vo_handler() {
  level endon("game_ended");

  if(!isDefined(level.nag_vo)) {
    level.nag_vo = [];
    level.nag_vo_never_play_again = [];
    level.pause_nag_vo = 0;
  }

  var0 = 60;

  for(;;) {
    while(level.pause_nag_vo) {
      wait 0.1;
    }

    var1 = gettime();

    foreach(var4, var3 in level.nag_vo) {
      if(var1 > var3.next_play_time) {
        if(isDefined(var3.scope)) {
          try_to_play_vo(var3.scope, var4, var3.vo_type, "low", 3, 0, 0, var3.only_local);
        } else {
          try_to_play_vo(level, var4, var3.vo_type, "low", 3, 0, 0, var3.only_local);
        }

        var3.times_played++;

        if(var3.max_times != -1 && var3.max_times <= var3.times_played) {
          remove_from_nag_vo(var4);
        }

        var3.next_play_time = var1 + var3.cooldown * min(var3.times_played, 3) * 1000;
        wait var0;
      }
    }

    wait 1;
  }
}

function add_to_nag_vo(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(level.nag_vo)) {
    level.nag_vo = [];
    level.nag_vo_never_play_again = [];
    level.pause_nag_vo = 0;
  }

  if(isDefined(level.nag_vo[var0])) {
    return;
  }

  if(isDefined(level.nag_vo_never_play_again[var0])) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = 60;
  }

  if(!isDefined(var1)) {
    var1 = "zmb_comment_vo";
  }

  var6 = undefined;

  if(isPlayer(self)) {
    var6 = self;
  }

  var7 = spawnStruct();
  var7.times_played = 0;
  var7.cooldown = var2;
  var7.vo_type = var1;

  if(isDefined(var6)) {
    var7.scope = var6;
  }

  if(isDefined(var5)) {
    var7.only_local = var5;
  } else {
    var7.only_local = 0;
  }

  if(isDefined(var3)) {
    var7.next_play_time = gettime() + var3 * 1000;
  } else {
    var7.next_play_time = 0;
  }

  if(isDefined(var4)) {
    var7.max_times = var4;
  } else {
    var7.max_times = -1;
  }

  level.nag_vo[var0] = var7;
}

function remove_from_nag_vo(var0, var1) {
  level.nag_vo = scripts\engine\utility::array_remove_index(level.nag_vo, var0, 1);

  if(istrue(var1)) {
    level.nag_vo_never_play_again[var0] = 1;
    return;
  }
}

function timeoutvofunction(var0, var1) {
  level endon(var0 + "_about_to_play");
  wait var1;
  level notify(var0 + "_timed_out");
}

function push_player_clear_of_door_way(var0) {
  var1 = tablelookup("cp/cp_vo_lookup.csv", 0, var0, 1);

  if(isDefined(var1)) {
    var1 = float(var1);
    return var1;
  }

  return undefined;
}