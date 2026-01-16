/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_skill.gsc
********************************/

init() {
  level.skill_rdur_min_sec = getdvarint("skill_rdur_min", 60);
  level.skill_recent_sosc = float(getdvarint("skill_recent_sosc", 1000)) / 1000.0;
  level.skill_sos_max_weight = getdvarint("skill_sos_max_weight", 5);
  level.skill_sos_tanh_scale = float(getdvarint("skill_sos_tanh_scale", 1000)) / 1000.0;
  level.skill_sos_default_rating = float(getdvarint("skill_sos_default_rating", 500)) / 1000.0;
  level thread onplayerspawned();
}

initsosproxy(var_0) {
  if(!var_0 isskillenabled()) {
    return;
  }
  if(isdefined(var_0.sos_id)) {
    return;
  }
  var_0.sos_id = level.sos_id;
  level.sos_id++;
  var_1 = spawnstruct();
  var_1.begin_time = maps\mp\_utility::getgametimepassedseconds();
  var_1.begin_sos_rating = var_0 getplayerdata("rankedMatchData", "sosRating");
  var_1.begin_sos_weight = var_0 getplayerdata("rankedMatchData", "sosWeight");

  if(var_1.begin_sos_weight <= 0.5)
    var_1.begin_sos_rating = level.skill_sos_default_rating;

  var_1.begin_gdf_rating = var_0 getplayerdata("rankedMatchData", "gdfRating");
  var_1.begin_gdf_variance = var_0 getplayerdata("rankedMatchData", "gdfVariance");
  var_1.latest_time = var_1.begin_time;
  var_1.score_per_second = undefined;
  level.sos_players[var_0.sos_id] = var_1;
}

process() {
  foreach(var_1 in level.players)
  var_1 _updateskill();
}

processplayer() {
  _updateskill();
}

onplayerspawned() {
  level.sos_players = [];
  level.sos_id = 0;

  for (;;) {
    level waittill("player_spawned", var_0);
    initsosproxy(var_0);
  }
}

isskillenabled() {
  if(!isdefined(self))
    return 0;

  if(isbot(self))
    return 0;

  if(!maps\mp\_utility::rankingenabled())
    return 0;

  return 1;
}

_ipow(var_0, var_1) {
  for (var_2 = 1; var_1; var_0 = var_0 * var_0) {
    if(var_1 & 1)
      var_2 = var_2 * var_0;

    var_1 = var_1 >> 1;
  }

  return var_2;
}

_cube_root(var_0) {
  var_1 = common_scripts\utility::sign(var_0);
  var_2 = _func_0E5(log(abs(var_0)) / 3);
  var_2 = var_2 * var_1;
  return var_2;
}

_rational_tanh(var_0) {
  if(var_0 <= -3)
    return -1;

  if(var_0 >= 3)
    return 1;

  var_1 = var_0 * var_0;
  var_2 = var_0 * (27 + var_1) / (27 + 9 * var_1);
  return var_2;
}

_inv_rational_tanh(var_0) {
  if(var_0 <= -1)
    return -3;

  if(var_0 >= 1)
    return 3;

  var_1 = var_0 * var_0;
  var_2 = var_1 * var_0;
  var_3 = 27 * (var_2 + (var_1 - 1) - var_0);
  var_4 = _cube_root(var_3);
  var_5 = 3 * var_0;
  var_6 = 9 * (1 - var_1);
  var_7 = var_4;
  var_8 = -1 * var_6 / var_7;
  var_9 = var_4 + var_5 + var_8;
  return var_9;
}

_inverse_skill_transform(var_0) {
  var_1 = var_0;
  var_1 = var_1 * 2.0;
  var_1 = var_1 - 1.0;
  var_1 = _inv_rational_tanh(var_1) / level.skill_sos_tanh_scale;
  return var_1;
}

_forward_skill_transform(var_0) {
  var_0 = clamp(var_0, -3.14159, 3.14159);
  var_1 = var_0;
  var_1 = _rational_tanh(var_1 * level.skill_sos_tanh_scale);
  var_1 = var_1 + 1.0;
  var_1 = var_1 * 0.5;
  return var_1;
}

_adjust_rating(var_0, var_1) {
  var_2 = _inverse_skill_transform(var_0);
  var_2 = var_2 + var_1;
  var_3 = _forward_skill_transform(var_2);
  return var_3;
}

_convert_rating_to_skill(var_0) {
  var_1 = var_0 * 2000;
  return int(var_1);
}

_convert_skill_to_rating(var_0) {
  var_1 = float(var_0) / 2000.0;
  var_1 = clamp(var_1, 0.0, 1.0);
  return var_1;
}

_calc_rating(var_0, var_1, var_2, var_3) {
  var_4 = var_0 + var_2 * 0.5 + var_3;
  var_5 = var_0 + var_2 + var_1 + 2.0 * var_3;

  if(var_5 == 0)
    return 0.5;

  var_6 = var_4 / var_5;
  return var_6;
}

_calc_sos_adjusted_rating(var_0, var_1) {
  var_2 = var_0 - 0.5;
  var_2 = var_2 * 1.0;
  var_3 = _adjust_rating(var_1, var_2);
  return var_3;
}

_normalize_assoc(var_0) {
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in var_0)
  var_1 = var_1 + abs(var_4);

  if(var_1 != 0)
    var_2 = 1.0 / var_1;

  foreach(var_7, var_4 in var_0)
  var_0[var_7] = var_0[var_7] * var_2;

  return var_0;
}

_dot_assoc(var_0, var_1) {
  var_2 = 0;

  foreach(var_5, var_4 in var_0) {
    if(isdefined(var_1[var_5]))
      var_2 = var_2 + var_4 * var_1[var_5];
  }

  return var_2;
}

_rating_error(var_0) {
  if(var_0 < -10)
    return 0 - var_0;

  return _norm_pdf(var_0) / _norm_cdf(var_0);
}

_variance_error(var_0, var_1) {
  return var_0 * (var_0 + var_1);
}

_norm_pdf(var_0) {
  return 0.398942 * _func_0E5(var_0 * var_0 * 0.5 * -1.0);
}

_norm_cdf(var_0) {
  var_1 = abs(0.707107 * var_0);
  var_2 = 1.0 / (1.0 + 0.5 * var_1);
  var_3 = var_2 * _func_0E5(var_1 * var_1 * -1 - 1.26551 + var_2 * (1.00002 + var_2 * (0.374092 + var_2 * (0.0967842 + var_2 * (-0.186288 + var_2 * (0.278868 + var_2 * (-1.1352 + var_2 * (1.48852 + var_2 * (-0.822152 + var_2 * 0.170873)))))))));

  if(var_0 >= 0)
    var_3 = 2.0 - var_3;

  return 0.5 * var_3;
}

_updatesosproxy(var_0) {
  if(isbot(var_0)) {
    return;
  }
  if(!isdefined(var_0.sos_id)) {
    return;
  }
  level.sos_players[var_0.sos_id].latest_time = maps\mp\_utility::getgametimepassedseconds();
  var_1 = level.sos_players[var_0.sos_id].latest_time - level.sos_players[var_0.sos_id].begin_time;

  if(var_1 > level.skill_rdur_min_sec && isdefined(var_0.pers) && isdefined(var_0.pers["score"]))
    level.sos_players[var_0.sos_id].score_per_second = var_0.pers["score"] / var_1;
  else
    level.sos_players[var_0.sos_id].score_per_second = undefined;
}

_updateskill() {
  if(!isskillenabled()) {
    return;
  }
  if(isdefined(self.skillcalculated) || !isdefined(self.sos_id)) {
    return;
  }
  self.skillcalculated = 1;

  if(!isdefined(level.sos_players[self.sos_id])) {
    return;
  }
  foreach(var_1 in level.players)
  _updatesosproxy(var_1);

  var_3 = level.sos_players[self.sos_id];

  if(!isdefined(var_3.score_per_second)) {
    return;
  }
  var_4 = var_3.latest_time - var_3.begin_time;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = var_3.begin_sos_rating * var_4;
  var_9 = var_4;
  var_10 = var_3.begin_gdf_variance;
  var_11 = var_3.begin_gdf_rating;
  var_12 = 0;
  var_13 = 0;

  if(var_10 == 0.0)
    var_10 = min(1.0, max(0.8596 + abs(var_3.begin_gdf_rating) * -0.18397, 0.05));

  foreach(var_22, var_15 in level.sos_players) {
    if(var_22 == self.sos_id) {
      continue;
    }
    if(!isdefined(var_15.score_per_second)) {
      continue;
    }
    var_16 = var_15.latest_time - max(var_3.begin_time, var_15.begin_time);

    if(var_16 <= 0) {
      continue;
    }
    var_17 = 7.0 + var_10;

    if(var_15.begin_gdf_variance)
      var_17 = var_17 + var_15.begin_gdf_variance;
    else
      var_17 = var_17 + min(max(abs(var_15.begin_gdf_rating) * -0.18397 + 0.8596, 0.05), 1.0);

    var_18 = sqrt(var_17);
    var_19 = (var_11 - var_15.begin_gdf_rating) / var_18;
    var_20 = 0;

    if(var_3.score_per_second > var_15.score_per_second) {
      var_5 = var_5 + 1.0;
      var_20 = 1.0;
    } else if(var_3.score_per_second < var_15.score_per_second) {
      var_6 = var_6 + 1.0;
      var_20 = 0.0;
    } else {
      var_7 = var_7 + 1.0;
      var_20 = 0.5;
    }

    var_21 = 1.0 / (1.0 + _func_0E5(var_19 * -1.0));
    var_12 = var_12 + (var_20 - var_21) / var_18;
    var_13 = var_13 + sqrt(var_10) / var_18 * var_21 * (1.0 - var_21) / var_17;
    var_8 = var_8 + var_15.begin_sos_rating * var_16;
    var_9 = var_9 + var_16;
  }

  var_10 = var_10 + 0.0001;
  var_11 = var_11 + var_10 * var_12;
  var_10 = max(0.05, var_10 * (1.0 - var_10 * var_13));
  self setplayerdata("rankedMatchData", "gdfRating", var_11);
  self setplayerdata("rankedMatchData", "gdfVariance", var_10);
  var_23 = var_8 / var_9;
  var_24 = 1.0;
  var_25 = _calc_rating(var_5, var_6, var_7, level.skill_recent_sosc);
  var_26 = _calc_sos_adjusted_rating(var_25, var_23);
  var_27 = var_26;
  var_28 = min(var_3.begin_sos_weight, level.skill_sos_max_weight);
  var_29 = var_28 + var_24;

  if(var_29 > 0) {
    var_27 = (var_3.begin_sos_rating * var_28 + var_27 * var_24) / var_29;
    self setplayerdata("rankedMatchData", "sosRating", var_27);
    self setplayerdata("rankedMatchData", "sosWeight", var_3.begin_sos_weight + var_24);
  }
}