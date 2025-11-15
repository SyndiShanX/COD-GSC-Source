/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_challenges_tomb.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#namespace zm_challenges_tomb;

function autoexec __init__sytem__() {
  system::register("zm_challenges_tomb", & __init__, & __main__, undefined);
}

function __init__() {
  level._challenges = spawnStruct();
  level.a_m_challenge_boards = [];
  level.a_uts_challenge_boxes = [];
  callback::on_connect( & onplayerconnect);
  callback::on_spawned( & onplayerspawned);
  n_bits = getminbitcountfornum(14);
  clientfield::register("toplayer", "challenges.challenge_complete_1", 21000, 2, "int");
  clientfield::register("toplayer", "challenges.challenge_complete_2", 21000, 2, "int");
  clientfield::register("toplayer", "challenges.challenge_complete_3", 21000, 2, "int");
  clientfield::register("toplayer", "challenges.challenge_complete_4", 21000, 2, "int");
  level thread challenges_devgui();
}

function __main__() {
  stats_init();
  a_m_challenge_boxes = getEntArray("challenge_box", "targetname");
  array::thread_all(a_m_challenge_boxes, & box_init);
}

function onplayerconnect() {
  player_stats_init(self.characterindex);
  foreach(s_stat in level._challenges.a_players[self.characterindex].a_stats) {
    s_stat.b_display_tag = 1;
    foreach(m_board in level.a_m_challenge_boards) {
      m_board showpart(s_stat.str_medal_tag);
      m_board hidepart(s_stat.str_glow_tag);
    }
  }
}

function onplayerspawned() {
  self endon("disconnect");
  for(;;) {
    foreach(s_stat in level._challenges.a_players[self.characterindex].a_stats) {
      if(!s_stat.b_medal_awarded) {
        continue;
      }
      var_c4dd09e9 = 1;
      if(s_stat.b_reward_claimed) {
        var_c4dd09e9 = 2;
      }
      self clientfield::set_to_player(s_stat.s_parent.cf_complete, var_c4dd09e9);
    }
    foreach(s_stat in level._challenges.s_team.a_stats) {
      if(!s_stat.b_medal_awarded) {
        continue;
      }
      var_c4dd09e9 = 1;
      if(s_stat.a_b_player_rewarded[self.characterindex]) {
        var_c4dd09e9 = 2;
      }
      self clientfield::set_to_player(s_stat.s_parent.cf_complete, var_c4dd09e9);
    }
    wait(0.05);
  }
}

function stats_init() {
  level._challenges.a_stats = [];
  if(isDefined(level.challenges_add_stats)) {
    [[level.challenges_add_stats]]();
  }
  foreach(stat in level._challenges.a_stats) {
    if(isDefined(stat.fp_init_stat)) {
      level thread[[stat.fp_init_stat]]();
    }
  }
  level._challenges.a_players = [];
  for(i = 0; i < 4; i++) {
    player_stats_init(i);
  }
  team_stats_init();
}

function add_stat(str_name, b_team = 0, str_hint = & "", n_goal = 1, str_reward_model, fp_give_reward, fp_init_stat) {
  stat = spawnStruct();
  stat.str_name = str_name;
  stat.b_team = b_team;
  stat.str_hint = str_hint;
  stat.n_goal = n_goal;
  stat.str_reward_model = str_reward_model;
  stat.fp_give_reward = fp_give_reward;
  stat.n_index = level._challenges.a_stats.size;
  if(isDefined(fp_init_stat)) {
    stat.fp_init_stat = fp_init_stat;
  }
  level._challenges.a_stats[str_name] = stat;
  stat.cf_complete = "challenges.challenge_complete_" + level._challenges.a_stats.size;
}

function player_stats_init(n_index) {
  a_characters = array("d", "n", "r", "t");
  str_character = a_characters[n_index];
  if(!isDefined(level._challenges.a_players[n_index])) {
    level._challenges.a_players[n_index] = spawnStruct();
    level._challenges.a_players[n_index].a_stats = [];
  }
  s_player_set = level._challenges.a_players[n_index];
  n_challenge_index = 1;
  foreach(s_challenge in level._challenges.a_stats) {
    if(!s_challenge.b_team) {
      if(!isDefined(s_player_set.a_stats[s_challenge.str_name])) {
        s_player_set.a_stats[s_challenge.str_name] = spawnStruct();
      }
      s_stat = s_player_set.a_stats[s_challenge.str_name];
      s_stat.s_parent = s_challenge;
      s_stat.n_value = 0;
      s_stat.b_medal_awarded = 0;
      s_stat.b_reward_claimed = 0;
      n_index = level._challenges.a_stats.size + 1;
      s_stat.str_medal_tag = (("j_" + str_character) + "_medal_0") + n_challenge_index;
      s_stat.str_glow_tag = (("j_" + str_character) + "_glow_0") + n_challenge_index;
      s_stat.b_display_tag = 0;
      n_challenge_index++;
    }
  }
  s_player_set.n_completed = 0;
  s_player_set.n_medals_held = 0;
}

function team_stats_init(n_index) {
  if(!isDefined(level._challenges.s_team)) {
    level._challenges.s_team = spawnStruct();
    level._challenges.s_team.a_stats = [];
  }
  s_team_set = level._challenges.s_team;
  foreach(s_challenge in level._challenges.a_stats) {
    if(s_challenge.b_team) {
      if(!isDefined(s_team_set.a_stats[s_challenge.str_name])) {
        s_team_set.a_stats[s_challenge.str_name] = spawnStruct();
      }
      s_stat = s_team_set.a_stats[s_challenge.str_name];
      s_stat.s_parent = s_challenge;
      s_stat.n_value = 0;
      s_stat.b_medal_awarded = 0;
      s_stat.b_reward_claimed = 0;
      s_stat.a_b_player_rewarded = array(0, 0, 0, 0);
      s_stat.str_medal_tag = "j_g_medal";
      s_stat.str_glow_tag = "j_g_glow";
      s_stat.b_display_tag = 1;
    }
  }
  s_team_set.n_completed = 0;
  s_team_set.n_medals_held = 0;
}

function challenge_exists(str_name) {
  if(isDefined(level._challenges.a_stats[str_name])) {
    return true;
  }
  return false;
}

function get_stat(str_stat, player) {
  s_parent_stat = level._challenges.a_stats[str_stat];
  assert(isDefined(s_parent_stat), ("" + str_stat) + "");
  assert(s_parent_stat.b_team || isDefined(player), ("" + str_stat) + "");
  if(s_parent_stat.b_team) {
    s_stat = level._challenges.s_team.a_stats[str_stat];
  } else {
    s_stat = level._challenges.a_players[player.characterindex].a_stats[str_stat];
  }
  return s_stat;
}

function increment_stat(str_stat, n_increment = 1) {
  s_stat = get_stat(str_stat, self);
  if(!s_stat.b_medal_awarded) {
    s_stat.n_value = s_stat.n_value + n_increment;
    check_stat_complete(s_stat);
  }
}

function set_stat(str_stat, n_set) {
  s_stat = get_stat(str_stat, self);
  if(!s_stat.b_medal_awarded) {
    s_stat.n_value = n_set;
    check_stat_complete(s_stat);
  }
}

function function_fbbc8608(str_hint, var_7ca2c2ae) {
  self luinotifyevent(&"trial_complete", 3, & "ZM_TOMB_CHALLENGE_COMPLETED", str_hint, var_7ca2c2ae);
}

function check_stat_complete(s_stat) {
  if(s_stat.b_medal_awarded) {
    return true;
  }
  if(s_stat.n_value >= s_stat.s_parent.n_goal) {
    s_stat.b_medal_awarded = 1;
    if(s_stat.s_parent.b_team) {
      s_team_stats = level._challenges.s_team;
      s_team_stats.n_completed++;
      s_team_stats.n_medals_held++;
      a_players = getplayers();
      foreach(player in a_players) {
        player clientfield::set_to_player(s_stat.s_parent.cf_complete, 1);
        player function_fbbc8608(s_stat.s_parent.str_hint, s_stat.s_parent.n_index);
        player playSound("evt_medal_acquired");
        util::wait_network_frame();
      }
    } else {
      s_player_stats = level._challenges.a_players[self.characterindex];
      s_player_stats.n_completed++;
      s_player_stats.n_medals_held++;
      self playSound("evt_medal_acquired");
      self clientfield::set_to_player(s_stat.s_parent.cf_complete, 1);
      self function_fbbc8608(s_stat.s_parent.str_hint, s_stat.s_parent.n_index);
    }
    foreach(m_board in level.a_m_challenge_boards) {
      m_board showpart(s_stat.str_glow_tag);
    }
    if(isplayer(self)) {
      if((level._challenges.a_players[self.characterindex].n_completed + level._challenges.s_team.n_completed) == level._challenges.a_stats.size) {
        self notify("all_challenges_complete");
      }
    } else {
      foreach(player in getplayers()) {
        if(isDefined(player.characterindex)) {
          if((level._challenges.a_players[player.characterindex].n_completed + level._challenges.s_team.n_completed) == level._challenges.a_stats.size) {
            player notify("all_challenges_complete");
          }
        }
      }
    }
    util::wait_network_frame();
  }
}

function stat_reward_available(stat, player) {
  if(isstring(stat)) {
    s_stat = get_stat(stat, player);
  } else {
    s_stat = stat;
  }
  if(!s_stat.b_medal_awarded) {
    return false;
  }
  if(s_stat.b_reward_claimed) {
    return false;
  }
  if(s_stat.s_parent.b_team && s_stat.a_b_player_rewarded[player.characterindex]) {
    return false;
  }
  return true;
}

function player_has_unclaimed_team_reward() {
  foreach(s_stat in level._challenges.s_team.a_stats) {
    if(s_stat.b_medal_awarded && !s_stat.a_b_player_rewarded[self.characterindex]) {
      return true;
    }
  }
  return false;
}

function board_init(m_board) {
  self.m_board = m_board;
  a_challenges = getarraykeys(level._challenges.a_stats);
  a_characters = array("d", "n", "r", "t");
  m_board.a_s_medal_tags = [];
  b_team_hint_added = 0;
  foreach(n_char_index, s_set in level._challenges.a_players) {
    str_character = a_characters[n_char_index];
    n_challenge_index = 1;
    foreach(s_stat in s_set.a_stats) {
      str_medal_tag = (("j_" + str_character) + "_medal_0") + n_challenge_index;
      str_glow_tag = (("j_" + str_character) + "_glow_0") + n_challenge_index;
      s_tag = spawnStruct();
      s_tag.v_origin = m_board gettagorigin(str_medal_tag);
      s_tag.s_stat = s_stat;
      s_tag.n_character_index = n_char_index;
      s_tag.str_medal_tag = str_medal_tag;
      if(!isDefined(m_board.a_s_medal_tags)) {
        m_board.a_s_medal_tags = [];
      } else if(!isarray(m_board.a_s_medal_tags)) {
        m_board.a_s_medal_tags = array(m_board.a_s_medal_tags);
      }
      m_board.a_s_medal_tags[m_board.a_s_medal_tags.size] = s_tag;
      m_board hidepart(str_medal_tag);
      m_board hidepart(str_glow_tag);
      n_challenge_index++;
    }
  }
  foreach(s_stat in level._challenges.s_team.a_stats) {
    str_medal_tag = "j_g_medal";
    str_glow_tag = "j_g_glow";
    s_tag = spawnStruct();
    s_tag.v_origin = m_board gettagorigin(str_medal_tag);
    s_tag.s_stat = s_stat;
    s_tag.n_character_index = 4;
    s_tag.str_medal_tag = str_medal_tag;
    if(!isDefined(m_board.a_s_medal_tags)) {
      m_board.a_s_medal_tags = [];
    } else if(!isarray(m_board.a_s_medal_tags)) {
      m_board.a_s_medal_tags = array(m_board.a_s_medal_tags);
    }
    m_board.a_s_medal_tags[m_board.a_s_medal_tags.size] = s_tag;
    m_board hidepart(str_glow_tag);
    b_team_hint_added = 1;
  }
  if(!isDefined(level.a_m_challenge_boards)) {
    level.a_m_challenge_boards = [];
  } else if(!isarray(level.a_m_challenge_boards)) {
    level.a_m_challenge_boards = array(level.a_m_challenge_boards);
  }
  level.a_m_challenge_boards[level.a_m_challenge_boards.size] = m_board;
}

function box_init() {
  s_unitrigger_stub = spawnStruct();
  s_unitrigger_stub.origin = self.origin + (0, 0, 0);
  s_unitrigger_stub.angles = self.angles;
  s_unitrigger_stub.radius = 64;
  s_unitrigger_stub.script_length = 64;
  s_unitrigger_stub.script_width = 64;
  s_unitrigger_stub.script_height = 64;
  s_unitrigger_stub.cursor_hint = "HINT_NOICON";
  s_unitrigger_stub.hint_string = & "";
  s_unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
  s_unitrigger_stub.prompt_and_visibility_func = & box_prompt_and_visiblity;
  s_unitrigger_stub flag::init("waiting_for_grab");
  s_unitrigger_stub flag::init("reward_timeout");
  s_unitrigger_stub.b_busy = 0;
  s_unitrigger_stub.m_box = self;
  s_unitrigger_stub.b_disable_trigger = 0;
  if(isDefined(self.script_string)) {
    s_unitrigger_stub.str_location = self.script_string;
  }
  if(isDefined(s_unitrigger_stub.m_box.target)) {
    s_unitrigger_stub.m_board = getent(s_unitrigger_stub.m_box.target, "targetname");
    s_unitrigger_stub board_init(s_unitrigger_stub.m_board);
  }
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger_stub, 1);
  if(!isDefined(level.a_uts_challenge_boxes)) {
    level.a_uts_challenge_boxes = [];
  } else if(!isarray(level.a_uts_challenge_boxes)) {
    level.a_uts_challenge_boxes = array(level.a_uts_challenge_boxes);
  }
  level.a_uts_challenge_boxes[level.a_uts_challenge_boxes.size] = s_unitrigger_stub;
  zm_unitrigger::register_static_unitrigger(s_unitrigger_stub, & box_think);
}

function box_prompt_and_visiblity(player) {
  if(self.stub.b_disable_trigger) {
    return false;
  }
  self update_box_prompt(player);
  return true;
}

function update_box_prompt(player) {
  str_hint = & "";
  str_old_hint = & "";
  m_board = self.stub.m_board;
  self sethintstring(str_hint);
  s_hint_tag = undefined;
  b_showing_stat = 0;
  self.b_can_open = 0;
  if(self.stub.b_busy) {
    if(self.stub flag::get("waiting_for_grab") && (!isDefined(self.stub.player_using) || self.stub.player_using == player)) {
      str_hint = & "ZM_TOMB_CH_G";
    } else {
      str_hint = & "";
    }
  } else {
    str_hint = & "";
    player.s_lookat_stat = undefined;
    n_closest_dot = 0.996;
    v_eye_origin = player getplayercamerapos();
    v_eye_direction = anglesToForward(player getplayerangles());
    foreach(s_tag in m_board.a_s_medal_tags) {
      if(!s_tag.s_stat.b_display_tag) {
        continue;
      }
      v_tag_origin = s_tag.v_origin;
      v_eye_to_tag = vectornormalize(v_tag_origin - v_eye_origin);
      n_dot = vectordot(v_eye_to_tag, v_eye_direction);
      if(n_dot > n_closest_dot) {
        n_closest_dot = n_dot;
        str_hint = s_tag.s_stat.s_parent.str_hint;
        s_hint_tag = s_tag;
        b_showing_stat = 1;
        self.b_can_open = 0;
        if(s_tag.n_character_index == player.characterindex || s_tag.n_character_index == 4) {
          player.s_lookat_stat = s_tag.s_stat;
          if(stat_reward_available(s_tag.s_stat, player)) {
            str_hint = & "ZM_TOMB_CH_S";
            b_showing_stat = 0;
            self.b_can_open = 1;
          }
        }
      }
    }
    if(str_hint == (&"")) {
      s_player = level._challenges.a_players[player.characterindex];
      s_team = level._challenges.s_team;
      if(s_player.n_medals_held > 0 || player player_has_unclaimed_team_reward()) {
        str_hint = & "ZM_TOMB_CH_O";
        self.b_can_open = 1;
      } else {
        str_hint = & "ZM_TOMB_CH_V";
      }
    }
  }
  if(str_old_hint != str_hint) {
    str_old_hint = str_hint;
    self.stub.hint_string = str_hint;
    if(isDefined(s_hint_tag)) {
      str_name = s_hint_tag.s_stat.s_parent.str_name;
      n_character_index = s_hint_tag.n_character_index;
      if(n_character_index != 4) {
        s_player_stat = level._challenges.a_players[n_character_index].a_stats[str_name];
      }
    }
    self sethintstring(self.stub.hint_string);
  }
}

function box_think() {
  self endon("kill_trigger");
  s_team = level._challenges.s_team;
  while(true) {
    self waittill("trigger", player);
    if(!zombie_utility::is_player_valid(player)) {
      continue;
    }
    if(self.stub.b_busy) {
      current_weapon = player getcurrentweapon();
      if(isDefined(player.intermission) && player.intermission || zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment_that_blocks_purchase(current_weapon) || current_weapon == level.weaponnone || player laststand::player_is_in_laststand() || player isthrowinggrenade() || player zm_utility::in_revive_trigger() || player isswitchingweapons() || player.is_drinking > 0) {
        wait(0.1);
        continue;
      }
      if(self.stub flag::get("waiting_for_grab")) {
        if(!isDefined(self.stub.player_using)) {
          self.stub.player_using = player;
        }
        if(player == self.stub.player_using) {
          self.stub flag::clear("waiting_for_grab");
        }
      }
      wait(0.05);
      continue;
    }
    if(self.b_can_open) {
      self.stub.hint_string = & "";
      self sethintstring(self.stub.hint_string);
      level thread open_box(player, self.stub);
    }
  }
}

function get_reward_category(player, s_select_stat) {
  if(isDefined(s_select_stat) && s_select_stat.s_parent.b_team || level._challenges.s_team.n_medals_held > 0) {
    return level._challenges.s_team;
  }
  if(level._challenges.a_players[player.characterindex].n_medals_held > 0) {
    return level._challenges.a_players[player.characterindex];
  }
  return undefined;
}

function get_reward_stat(s_category) {
  foreach(s_stat in s_category.a_stats) {
    if(s_stat.b_medal_awarded && !s_stat.b_reward_claimed) {
      if(s_stat.s_parent.b_team && s_stat.a_b_player_rewarded[self.characterindex]) {
        continue;
      }
      return s_stat;
    }
  }
  return undefined;
}

function open_box(player, ut_stub, fp_reward_override, param1) {
  m_box = ut_stub.m_box;
  while(ut_stub.b_busy) {
    wait(1);
  }
  ut_stub.b_busy = 1;
  ut_stub.player_using = player;
  if(isDefined(player) && isDefined(player.s_lookat_stat)) {
    s_select_stat = player.s_lookat_stat;
  }
  m_box thread scene::play("p7_fxanim_zm_ori_challenge_box_open_bundle", m_box);
  m_box util::delay(0.75, undefined, & clientfield::set, "foot_print_box_glow", 1);
  wait(0.5);
  if(isDefined(fp_reward_override)) {
    ut_stub[[fp_reward_override]](player, param1);
  } else {
    ut_stub spawn_reward(player, s_select_stat);
  }
  wait(1);
  m_box thread scene::play("p7_fxanim_zm_ori_challenge_box_close_bundle", m_box);
  m_box util::delay(0.75, undefined, & clientfield::set, "foot_print_box_glow", 0);
  wait(2);
  ut_stub.b_busy = 0;
  ut_stub.player_using = undefined;
}

function spawn_reward(player, s_select_stat) {
  if(isDefined(player)) {
    player endon("death_or_disconnect");
    if(isDefined(s_select_stat)) {
      s_category = get_reward_category(player, s_select_stat);
      if(stat_reward_available(s_select_stat, player)) {
        s_stat = s_select_stat;
      }
    }
    if(!isDefined(s_stat)) {
      s_category = get_reward_category(player);
      s_stat = player get_reward_stat(s_category);
    }
    if(self[[s_stat.s_parent.fp_give_reward]](player, s_stat)) {
      if(isDefined(s_stat.s_parent.cf_complete)) {
        player clientfield::set_to_player(s_stat.s_parent.cf_complete, 2);
      }
      if(s_stat.s_parent.b_team) {
        s_stat.a_b_player_rewarded[player.characterindex] = 1;
        a_players = getplayers();
        foreach(player in a_players) {
          if(!s_stat.a_b_player_rewarded[player.characterindex]) {
            return;
          }
        }
      }
      s_stat.b_reward_claimed = 1;
      s_category.n_medals_held--;
    }
  }
}

function reward_grab_wait(n_timeout = 10) {
  self flag::clear("reward_timeout");
  self flag::set("waiting_for_grab");
  self endon("waiting_for_grab");
  if(n_timeout > 0) {
    wait(n_timeout);
    self flag::set("reward_timeout");
    self flag::clear("waiting_for_grab");
  } else {
    self flag::wait_till_clear("waiting_for_grab");
  }
}

function reward_sink(n_delay, n_z, n_time) {
  if(isDefined(n_delay)) {
    wait(n_delay);
    if(isDefined(self)) {
      self movez(n_z * -1, n_time);
    }
  }
}

function reward_rise_and_grab(m_reward, n_z, n_rise_time, n_delay, n_timeout) {
  m_reward movez(n_z, n_rise_time);
  wait(n_rise_time);
  if(n_timeout > 0) {
    m_reward thread reward_sink(n_delay, n_z, n_timeout + 1);
  }
  self reward_grab_wait(n_timeout);
  if(self flag::get("reward_timeout")) {
    return false;
  }
  return true;
}

function reward_points(player, s_stat) {
  player zm_score::add_to_player_score(2500);
}

function challenges_devgui() {
  setdvar("", "");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  thread watch_devgui_award_challenges();
}

function watch_devgui_award_challenges() {
  while(true) {
    n_award_challenge = getdvarint("");
    if(n_award_challenge != 0) {
      devgui_award_challenge(n_award_challenge);
      setdvar("", 0);
    }
    wait(0.5);
  }
}

function devgui_award_challenge(n_index) {
  if(n_index == 4) {
    s_team_stats = level._challenges.s_team;
    s_team_stats.n_completed = 1;
    s_team_stats.n_medals_held = 1;
    a_keys = getarraykeys(level._challenges.s_team.a_stats);
    s_stat = level._challenges.s_team.a_stats[a_keys[0]];
    s_stat.b_medal_awarded = 1;
    s_stat.b_reward_claimed = 0;
    a_players = getplayers();
    foreach(player in a_players) {
      s_stat.a_b_player_rewarded[player.characterindex] = 0;
      player clientfield::set_to_player(s_stat.s_parent.cf_complete, 1);
      player function_fbbc8608(s_stat.s_parent.str_hint, s_stat.s_parent.n_index);
    }
    foreach(m_board in level.a_m_challenge_boards) {
      m_board showpart(s_stat.str_glow_tag);
    }
  } else {
    a_keys = getarraykeys(level._challenges.a_players[0].a_stats);
    a_players = getplayers();
    foreach(player in a_players) {
      s_player_data = level._challenges.a_players[player.characterindex];
      s_player_data.n_completed++;
      s_player_data.n_medals_held++;
      s_stat = s_player_data.a_stats[a_keys[n_index - 1]];
      s_stat.b_medal_awarded = 1;
      s_stat.b_reward_claimed = 0;
      player clientfield::set_to_player(s_stat.s_parent.cf_complete, 1);
      player function_fbbc8608(s_stat.s_parent.str_hint, s_stat.s_parent.n_index);
      foreach(m_board in level.a_m_challenge_boards) {
        m_board showpart(s_stat.str_glow_tag);
      }
    }
  }
}