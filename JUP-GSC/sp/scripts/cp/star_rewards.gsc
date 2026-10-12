/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\star_rewards.gsc
***********************************************/



#using scripts\cp\challenges_cp;
#using scripts\cp\cp_achievement;
#using scripts\cp\cp_gameskill;
#using scripts\cp\progression;
#using scripts\cp\rewards_cp;
#using scripts\cp\utility;
#namespace star_rewards;

function init() {
  level.var_2e42f69f0c1e31c3 = spawnStruct();
  level.var_2e42f69f0c1e31c3.start_time = gettime() / 1000;
  level.var_2e42f69f0c1e31c3.times = [];
  level.var_2e42f69f0c1e31c3.extra_score = 0;
  level.var_2e42f69f0c1e31c3.var_e0be7d747d6a32be = [];
  function_a133c2ff48b59dd7("time");
  function_6ccb377e839d87c4(2100, 1500, 900);
}

function function_a133c2ff48b59dd7(type) {
  level.var_2e42f69f0c1e31c3.var_f90445e7c6431f6b = type;

  if(type == "scripted") {
    level notify("stars_reduceDifficultyAtOneStar");
    level.var_2e42f69f0c1e31c3.star_count = 3;
    return;
  }

  if(type == "score") {
    level notify("stars_reduceDifficultyAtOneStar");
    level.var_2e42f69f0c1e31c3.star_score = 0;
  }
}

function function_4204d481f7d65d23(extra_score, type) {
  level.var_2e42f69f0c1e31c3.extra_score += extra_score;

  if(isDefined(type)) {
    if(!isDefined(level.var_2e42f69f0c1e31c3.var_e0be7d747d6a32be[type])) {
      level.var_2e42f69f0c1e31c3.var_e0be7d747d6a32be[type] = extra_score;
      return;
    }

    level.var_2e42f69f0c1e31c3.var_e0be7d747d6a32be[type] += extra_score;
  }
}

function function_f601f9facf5f2c1() {
  [game_length, stars_earned, next_star] = function_c6a366dd2ff66e19();
  setomnvar("zm_time_survived", int(game_length));
  setomnvar("ui_so_stars_given", stars_earned);

  if(stars_earned == 3) {
    level thread scripts\cp\cp_achievement::function_57b06ac64f28dc4a();
  }

  if(stars_earned >= 1) {
    level thread scripts\cp\cp_achievement::function_42ae9dfc72534d75();
    scripts\cp\challenges_cp::function_ff3ffccac94c5578(level.script, stars_earned);
    scripts\cp\progression::function_1d9eeda30f722f43(stars_earned, game_length);

    if(scripts\cp\utility::is_raid_gamemode()) {
      scripts\cp\rewards_cp::function_2ca23024661e30ae();
      scripts\cp\rewards_cp::function_4ec90e865bd62bf5();
      scripts\cp\rewards_cp::function_31124f4dd33ad7f2();

      if(scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
        scripts\cp\rewards_cp::function_e0e2f13dec46e52e();
      } else {
        foreach(player in level.players) {
          player setplayerdata("cp", "lastRaidVeteranReward", "None");
        }
      }
    }
  }

  foreach(player in level.players) {
    if(!scripts\cp\utility::is_raid_gamemode()) {
      player setplayerdata("cp", "lastRaidReward", "None");
    }
  }

  if(isDefined(next_star) && next_star <= 3) {
    setomnvar("ui_so_next_score", next_star);
  }
}

function private function_c6a366dd2ff66e19() {
  game_length = undefined;
  star_earned = undefined;
  next_star = undefined;

  if(level.var_2e42f69f0c1e31c3.var_f90445e7c6431f6b == "time") {
    [game_length, star_earned, next_star] = function_9856daafe612467();
  } else if(level.var_2e42f69f0c1e31c3.var_f90445e7c6431f6b == "scripted") {
    [game_length, session_length] = function_51c95119be8bd65b();
    star_earned = function_5b09d746bd349182();

    if(star_earned + 1 <= 3) {
      next_star = star_earned + 1;
    }
  }

  return [game_length, star_earned, next_star];
}

function private function_eeb437cba958d31e() {
  session_time = 0;

  if(isDefined(game["star_rewards_times"])) {
    session_time = game["star_rewards_times"];
  }

  return [session_time, level.var_2e42f69f0c1e31c3.extra_score];
}

function private function_9856daafe612467(game_length, star_earned, next_star) {
  [var_5841214b3c91c15b, session_length] = function_51c95119be8bd65b();
  times = function_f0b5555693bb9dea();
  star_earned = 1;
  keys = getarraykeys(times);

  for(i = 0; i < keys.size; i++) {
    key = keys[i];

    if(var_5841214b3c91c15b <= level.var_2e42f69f0c1e31c3.times[key]) {
      star_earned = i + 1;
      next_star = star_earned + 1;
    }
  }

  return [var_5841214b3c91c15b, star_earned, next_star];
}

function private function_51c95119be8bd65b() {
  [session_length, add_time] = function_eeb437cba958d31e();
  var_5841214b3c91c15b = session_length + add_time;
  return [var_5841214b3c91c15b, session_length];
}

function private function_f0b5555693bb9dea() {
  return level.var_2e42f69f0c1e31c3.times;
}

function function_6ccb377e839d87c4(star_1_time, star_2_time, star_3_time) {
  level.var_2e42f69f0c1e31c3.times["star_1_time"] = star_1_time;
  level.var_2e42f69f0c1e31c3.times["star_2_time"] = star_2_time;
  level.var_2e42f69f0c1e31c3.times["star_3_time"] = star_3_time;
  level thread stars_reducedifficultyatonestar(star_2_time);
}

function stars_reducedifficultyatonestar(star_2_time) {
  level notify("stars_reduceDifficultyAtOneStar");
  level endon("stars_reduceDifficultyAtOneStar");
  level endon("game_ended");

  if(getdvarint(@ "hash_c7c02892f746a20c", 0)) {
    waittime = star_2_time;
    session_time = undefined;

    if(isDefined(game["star_rewards_times"])) {
      session_time = game["star_rewards_times"] / 1000;
    }

    if(isDefined(session_time)) {
      waittime = star_2_time - session_time;
    }

    if(waittime >= 0.05) {
      wait waittime;
      function_8c503b084fc2bf04();
    }
  }
}

function function_8c503b084fc2bf04() {
  if(scripts\cp\utility::is_raid_gamemode()) {
    scripts\cp\cp_gameskill::function_2b72a5cf9e5597f9(1);

    if(scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
      scripts\cp\cp_gameskill::function_2b72a5cf9e5597f9(2);
    }
  } else {
    scripts\cp\cp_gameskill::function_2b72a5cf9e5597f9(0);
  }

  scripts\cp\cp_gameskill::updategameskill();
  setomnvar("cp_difficulty_level", level.gameskill);
  scripts\cp\cp_gameskill::function_1fc33d9e5389101f();
}

function function_9d2f4b3314c3bdb8(remove_star) {
  old_count = function_5b09d746bd349182();

  if(istrue(remove_star)) {
    new_count = old_count - 1;
    function_26dc2f0b0bd90e86(new_count);
    return;
  }

  new_count = old_count + 1;
  function_26dc2f0b0bd90e86(new_count);
}

function function_26dc2f0b0bd90e86(count) {
  if(count > 3 || count < 1) {
    level.var_2e42f69f0c1e31c3.star_count = 1;
  } else {
    level.var_2e42f69f0c1e31c3.star_count = count;
  }

  if(level.var_2e42f69f0c1e31c3.star_count <= 1) {
    function_8c503b084fc2bf04();
  }
}

function private function_5b09d746bd349182() {
  return level.var_2e42f69f0c1e31c3.star_count;
}

function function_578c2b4d51d13b9a() {
  game_length = getomnvar("zm_time_survived");

  foreach(player in level.players) {
    player setplayerdata("cp", "CPSession", "timeSurvivedLastMatch", game_length);
    var_c6ccc4b27adebe5b = player getclientomnvar("ui_aar_is_personal_best");
    player setplayerdata("cp", "CPSession", "isPersonalBestLastMatch", var_c6ccc4b27adebe5b);
    player setclientomnvar("ui_aar_is_personal_best", 0);
  }

  setomnvar("zm_time_survived", 0);
  setomnvar("ui_so_stars_given", -1);
  setomnvar("ui_so_next_score", 0);
  setomnvar("ui_so_iwbest", 0);
}