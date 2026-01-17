/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombietron_score.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombietron_utility;

player_add_points(points) {
  self add_to_player_score(points);
  self.stats["score"] = self.score;
}

add_to_player_score(points) {
  lowMask = 15;
  curScore = self getscoremultiplier();
  actual_multiplier = (curScore &lowMask) + 1;
  points *= actual_multiplier;
  self.score += points;
  if(self.score >= self.next_extra_life) {
    self.next_extra_life += level.zombie_vars["extra_life_at_every"];
    maps\_zombietron_pickups::directed_pickup_award_to(self, "extra_life_directed", level.extra_life_model);
  }
  self set_player_score_hud();
}

update_hud() {
  self.revives = self.lives;
  self.assists = self.bombs;
  self.downs = self.boosters;
}

update_multiplier_bar(increment) {
  lowMask = 15;
  curScore = self getscoremultiplier();
  actual_multiplier = (curScore &lowMask) + 1;
  actual_increment = curScore >> 4;
  increment = int(increment);
  if(increment == 0) {
    if(isDefined(self.fate_fortune)) {
      actual_multiplier--;
    }
    if(actual_multiplier > 1) {
      level thread maps\_zombietron_pickups::spawn_uber_prizes(RandomFloatRange(0.3, 0.5) * (actual_multiplier * level.zombie_vars["max_prize_inc_range"]), self.origin, true);
    }
    actual_increment = 0;
    actual_multiplier = 1;
    self.pointBarInc = level.zombie_vars["prize_increment"];
    if(isDefined(self.fate_fortune)) {
      self maps\_zombietron_score::update_multiplier_bar(level.zombie_vars["max_prize_inc_range"] + 1);
      actual_multiplier = 2;
    }
  } else {
    actual_increment += increment;
    if(actual_increment > level.zombie_vars["max_prize_inc_range"]) {
      self.pointBarInc = int((self.pointBarInc * 0.65) + 0.69);
      if(self.pointBarInc < 1) {
        self.pointBarInc = 1;
      }
      actual_increment -= level.zombie_vars["max_prize_inc_range"];
      actual_multiplier++;
      if(actual_multiplier > level.zombie_vars["max_multiplier"]) {
        actual_multiplier = level.zombie_vars["max_multiplier"];
        actual_increment = level.zombie_vars["max_prize_inc_range"];
      }
    }
  }
  curScore = (actual_increment << 4) + (actual_multiplier - 1);
  self setScoreMultiplier(curScore);
}

set_player_score_hud(init) {
  num = self.entity_num;
  score_diff = self.score - self.old_score;
  if(isDefined(init) && init) {
    return;
  }
  self.old_score = self.score;
}