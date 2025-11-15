/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_score.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

init() {}
player_add_points(event, mod, hit_location, is_dog) {
  if(level.intermission) {
    return;
  }
  if(!is_player_valid(self)) {
    return;
  }
  points = 0;
  switch (event) {
    case "death":
      points = level.zombie_vars["zombie_score_kill"];
      points += player_add_points_kill_bonus(mod, hit_location);
      if(isDefined(self.kill_tracker)) {
        self.kill_tracker++;
      } else {
        self.kill_tracker = 1;
      }
      self.stats["kills"] = self.kill_tracker;
      if(isDefined(is_dog)) {
        if(isDefined(self.dog_kills)) {
          self.dog_kills += 1;
        }
      }
      if(level.zombie_vars["zombie_powerup_insta_kill_on"] == 1 && mod == "MOD_UNKNOWN") {
        points = points * 2;
      }
      break;
    case "damage":
      points = level.zombie_vars["zombie_score_damage"];
      break;
    case "damage_ads":
      points = Int(level.zombie_vars["zombie_score_damage"] * 1.25);
      break;
    default:
      assertex(0, "Unknown point event");
      break;
  }
  points = round_up_to_ten(points) * level.zombie_vars["zombie_point_scalar"];
  self.score += points;
  self.score_total += points;
  self.stats["score"] = self.score_total;
  self set_player_score_hud();
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
      percent = level.zombie_vars["penalty_no_revive_percent"];
      points = self.score * percent;
      break;
    case "died":
      percent = level.zombie_vars["penalty_died_percent"];
      points = self.score * percent;
      break;
    case "downed":
      percent = level.zombie_vars["penalty_downed_percent"];;
      self notify("I_am_down");
      points = self.score * percent;
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

add_to_player_score(cost) {
  if(level.intermission) {
    return;
  }
  self.score += cost;
  self set_player_score_hud();
}

minus_to_player_score(cost) {
  if(level.intermission) {
    return;
  }
  self.score -= cost;
  self set_player_score_hud();
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
  self thread score_highlight(self.score, score_diff);
  if(isDefined(init)) {
    return;
  }
  self.old_score = self.score;
}

create_highlight_hud(x, y, value) {
  font_size = 8;
  if(IsSplitScreen()) {
    hud = NewClientHudElem(self);
  } else {
    hud = NewHudElem();
  }
  level.hudelem_count++;
  hud.foreground = true;
  hud.sort = 0;
  hud.x = x;
  hud.y = y;
  hud.fontScale = font_size;
  hud.alignX = "right";
  hud.alignY = "middle";
  hud.horzAlign = "right";
  hud.vertAlign = "bottom";
  if(value < 1) {
    hud.color = (0.423, 0.004, 0);
  } else {
    hud.color = (0.9, 0.9, 0.0);
    hud.label = & "SCRIPT_PLUS";
  }
  hud.hidewheninmenu = false;
  hud SetValue(value);
  return hud;
}

score_highlight(score, value) {
  self endon("disconnect");
  score_x = -103;
  score_y = -71;
  x = score_x;
  if(IsSplitScreen()) {
    y = score_y;
  } else {
    players = get_players();
    num = (players.size - self GetEntityNumber()) - 1;
    y = (num * -18) + score_y;
  }
  time = 0.5;
  half_time = time * 0.5;
  hud = create_highlight_hud(x, y, value);
  hud MoveOverTime(time);
  hud.x -= 20 + RandomInt(40);
  hud.y -= (-15 + RandomInt(30));
  wait(half_time);
  hud FadeOverTime(half_time);
  hud.alpha = 0;
  wait(half_time);
  hud Destroy();
  level.hudelem_count--;
}