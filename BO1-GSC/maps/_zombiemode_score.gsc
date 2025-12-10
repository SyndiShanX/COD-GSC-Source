/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_score.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

init() {
  team_score_init();
}

player_add_points(event, mod, hit_location, is_dog) {
  if(level.intermission) {
    return;
  }
  if(!is_player_valid(self)) {
    return;
  }
  player_points = 0;
  team_points = 0;
  multiplier = get_points_multiplier();
  switch (event) {
    case "death":
      player_points = get_zombie_death_player_points();
      team_points = get_zombie_death_team_points();
      points = player_add_points_kill_bonus(mod, hit_location);
      if(level.zombie_vars["zombie_powerup_insta_kill_on"] == 1 && mod == "MOD_UNKNOWN") {
        points = points * 2;
      }
      player_points = player_points + points;
      if(team_points > 0) {
        team_points = team_points + points;
      }
      if(isDefined(self.kill_tracker)) {
        self.kill_tracker++;
      } else {
        self.kill_tracker = 1;
      }
      self.stats["kills"] = self.kill_tracker;
      break;
    case "ballistic_knife_death":
      player_points = get_zombie_death_player_points() + level.zombie_vars["zombie_score_bonus_melee"];
      if(isDefined(self.kill_tracker)) {
        self.kill_tracker++;
      } else {
        self.kill_tracker = 1;
      }
      self.stats["kills"] = self.kill_tracker;
      break;
    case "damage_light":
      player_points = level.zombie_vars["zombie_score_damage_light"];
      break;
    case "damage":
      player_points = level.zombie_vars["zombie_score_damage_normal"];
      break;
    case "damage_ads":
      player_points = Int(level.zombie_vars["zombie_score_damage_normal"] * 1.25);
      break;
    case "rebuild_board":
    case "carpenter_powerup":
      player_points = mod;
      break;
    case "nuke_powerup":
      player_points = mod;
      team_points = mod;
      break;
    case "thundergun_fling":
      player_points = mod;
      break;
    case "reviver":
      player_points = mod;
      break;
    default:
      assertex(0, "Unknown point event");
      break;
  }
  player_points = multiplier * round_up_score(player_points, 5);
  team_points = multiplier * round_up_score(team_points, 5);
  self add_to_player_score(player_points);
  players = get_players();
  if(players.size > 1) {
    self add_to_team_score(team_points);
  }
  self.stats["score"] = self.score_total;
}

get_points_multiplier() {
  multiplier = level.zombie_vars["zombie_point_scalar"];
  if(level.mutators["mutator_doubleMoney"]) {
    multiplier *= 2;
  }
  return multiplier;
}

get_zombie_death_player_points() {
  players = get_players();
  if(players.size == 1) {
    points = level.zombie_vars["zombie_score_kill_1player"];
  } else if(players.size == 2) {
    points = level.zombie_vars["zombie_score_kill_2player"];
  } else if(players.size == 3) {
    points = level.zombie_vars["zombie_score_kill_3player"];
  } else {
    points = level.zombie_vars["zombie_score_kill_4player"];
  }
  return (points);
}

get_zombie_death_team_points() {
  players = get_players();
  if(players.size == 1) {
    points = level.zombie_vars["zombie_score_kill_1p_team"];
  } else if(players.size == 2) {
    points = level.zombie_vars["zombie_score_kill_2p_team"];
  } else if(players.size == 3) {
    points = level.zombie_vars["zombie_score_kill_3p_team"];
  } else {
    points = level.zombie_vars["zombie_score_kill_4p_team"];
  }
  return (points);
}

player_add_points_kill_bonus(mod, hit_location) {
  if(mod == "MOD_MELEE") {
    return level.zombie_vars["zombie_score_bonus_melee"];
  }
  if(mod == "MOD_BURNED") {
    return level.zombie_vars["zombie_score_bonus_burn"];
  }
  score = 0;
  switch (hit_location) {
    case "head":
    case "helmet":
      score = level.zombie_vars["zombie_score_bonus_head"];
      break;
    case "neck":
      score = level.zombie_vars["zombie_score_bonus_neck"];
      break;
    case "torso_upper":
    case "torso_lower":
      score = level.zombie_vars["zombie_score_bonus_torso"];
      break;
  }
  return score;
}

player_reduce_points(event, mod, hit_location) {
  if(level.intermission) {
    return;
  }
  points = 0;
  switch (event) {
    case "no_revive_penalty":
      percent = level.zombie_vars["penalty_no_revive"];
      points = self.score * percent;
      break;
    case "died":
      percent = level.zombie_vars["penalty_died"];
      points = self.score * percent;
      break;
    case "downed":
      percent = level.zombie_vars["penalty_downed"];;
      self notify("I_am_down");
      points = self.score * percent;
      self.score_lost_when_downed = round_up_to_ten(int(points));
      break;
    default:
      assertex(0, "Unknown point event");
      break;
  }
  points = self.score - round_up_to_ten(int(points));
  if(points < 0) {
    points = 0;
  }
  self.score = points;
  self set_player_score_hud();
}

add_to_player_score(points, add_to_total) {
  if(!isDefined(add_to_total)) {
    add_to_total = true;
  }
  if(!isDefined(points) || level.intermission) {
    return;
  }
  self.score += points;
  if(add_to_total) {
    self.score_total += points;
  }
  self set_player_score_hud();
}

minus_to_player_score(points) {
  if(!isDefined(points) || level.intermission) {
    return;
  }
  self.score -= points;
  self set_player_score_hud();
}

add_to_team_score(points) {}
minus_to_team_score(points) {
  if(!isDefined(points) || level.intermission) {
    return;
  }
  team_pool = level.team_pool[0];
  if(isDefined(self.team_num) && self.team_num != 0) {
    team_pool = level.team_pool[self.team_num];
  }
  team_pool.score -= points;
  team_pool set_team_score_hud();
}

player_died_penalty() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(players[i] != self && !players[i].is_zombie) {
      players[i] player_reduce_points("no_revive_penalty");
    }
  }
}

player_downed_penalty() {
  self player_reduce_points("downed");
}

set_player_score_hud(init) {
  num = self.entity_num;
  score_diff = self.score - self.old_score;
  if(IsPlayer(self)) {
    if(!level.onlineGame && !level.systemLink && IsSplitScreen()) {
      self thread score_highlight(self, self.score, score_diff);
    } else {
      players = get_players();
      for(i = 0; i < players.size; i++) {
        players[i] thread score_highlight(self, self.score, score_diff);
      }
    }
  }
  if(isDefined(init) && init) {
    return;
  }
  self.old_score = self.score;
}

set_team_score_hud(init) {
  self.score = 0;
  self.score_total = 0;
}

create_highlight_hud(x, y, value) {
  font_size = 8;
  if(self IsSplitscreen()) {
    font_size *= 2;
  }
  hud = create_simple_hud(self);
  level.hudelem_count++;
  hud.foreground = true;
  hud.sort = 0;
  hud.x = x;
  hud.y = y;
  hud.fontScale = font_size;
  hud.alignX = "right";
  hud.alignY = "middle";
  hud.horzAlign = "user_right";
  hud.vertAlign = "user_bottom";
  if(value < 1) {
    hud.color = (0.21, 0, 0);
  } else {
    hud.color = (0.9, 0.9, 0.0);
    hud.label = &"SCRIPT_PLUS";
  }
  hud.hidewheninmenu = false;
  hud SetValue(value);
  return hud;
}

score_highlight(scoring_player, score, value) {
  self endon("disconnect");
  score_x = -103;
  score_y = -100;
  if(self IsSplitscreen()) {
    score_y = -95;
  }
  x = score_x;
  if(!level.onlineGame && !level.systemLink && IsSplitScreen()) {
    y = score_y;
  } else {
    players = get_players();
    num = 0;
    for(i = 0; i < players.size; i++) {
      if(scoring_player == players[i]) {
        num = players.size - i - 1;
      }
    }
    y = (num * -20) + score_y;
  }
  if(self IsSplitscreen()) {
    y *= 2;
  }
  time = 0.5;
  half_time = time * 0.5;
  hud = self create_highlight_hud(x, y, value);
  hud MoveOverTime(time);
  hud.x -= 20 + randomInt(40);
  hud.y -= (-15 + randomInt(30));
  wait(half_time);
  hud FadeOverTime(half_time);
  hud.alpha = 0;
  wait(half_time);
  hud Destroy();
  level.hudelem_count--;
}

team_score_init() {
  flag_wait("all_players_connected");
  level.team_pool = [];
  players = get_players();
  if(players.size == 1) {
    level.team_pool[0] = spawnStruct();
    pool = level.team_pool[0];
    pool.team_num = 0;
    pool.score = 0;
    pool.old_score = pool.score;
    pool.score_total = pool.score;
    return;
  }
  if(isDefined(level.zombiemode_versus) && level.zombiemode_versus) {
    num_pools = 2;
  } else {
    num_pools = 1;
  }
  for(i = 0; i < num_pools; i++) {
    level.team_pool[i] = spawnStruct();
    pool = level.team_pool[i];
    pool.team_num = i;
    pool.score = 0;
    pool.old_score = pool.score;
    pool.score_total = pool.score;
    pool.hud_x = -103 + 5;
    pool.hud_y = -71 - 36;
    if(!IsSplitScreen()) {
      players = get_players();
      num = players.size - 1;
      pool.hud_y += (num + (num_pools - 1 - i)) * -18;
    }
  }
}

create_team_hud(value, team_pool) {
  AssertEx(isDefined(team_pool), "create_team_hud:You must specify a team_pool when calling this function");
  font_size = 8.0;
  hud = create_simple_hud();
  hud.foreground = true;
  hud.sort = 10;
  hud.x = team_pool.hud_x;
  hud.y = team_pool.hud_y;
  hud.fontScale = font_size;
  hud.alignX = "left";
  hud.alignY = "middle";
  hud.horzAlign = "user_right";
  hud.vertAlign = "user_bottom";
  hud.color = (0.9, 0.9, 0.0);
  hud.hidewheninmenu = false;
  hud SetValue(value);
  bg_hud = create_simple_hud();
  bg_hud.alignX = "right";
  bg_hud.alignY = "middle";
  bg_hud.horzAlign = "user_right";
  bg_hud.vertAlign = "user_bottom";
  bg_hud.color = (1, 1, 1);
  bg_hud.sort = 8;
  bg_hud.x = team_pool.hud_x - 8;
  bg_hud.y = team_pool.hud_y;
  bg_hud.alpha = 1;
  bg_hud SetShader("zom_icon_community_pot", 32, 32);
  bg_hud = create_simple_hud();
  bg_hud.alignX = "left";
  bg_hud.alignY = "middle";
  bg_hud.horzAlign = "user_right";
  bg_hud.vertAlign = "user_bottom";
  bg_hud.color = (0.0, 0.0, 0);
  bg_hud.sort = 8;
  bg_hud.x = team_pool.hud_x - 24;
  bg_hud.y = team_pool.hud_y;
  bg_hud.alpha = 1;
  bg_hud SetShader("zom_icon_community_pot_strip", 128, 16);
  return hud;
}