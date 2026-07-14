/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_1c785906537b0e9c.gsc
*****************************************************/

#using scripts\common\progression_utility;
#using scripts\cp_mp\playerachievements;
#using scripts\mp\class;
#namespace player_progression_achievements;

function private function_608d80e79011724f() {
  if(isDefined(level.var_86d6d54de22b6720)) {
    return;
  }

  var_4fa46bb6a2edd482 = level.projectbundle.var_67327f8e51cb3a75;

  if(!isDefined(var_4fa46bb6a2edd482) || var_4fa46bb6a2edd482 == 0) {
    level.var_86d6d54de22b6720 = 48944;
  }

  level.var_86d6d54de22b6720 = var_4fa46bb6a2edd482;
}

function function_7a54e5cc7d9e8e90() {
  function_608d80e79011724f();

  if(!isDefined(level.var_86d6d54de22b6720) || level.var_86d6d54de22b6720 == 0) {
    return;
  }

  validplayers = [];

  foreach(player in level.players) {
    if(isDefined(player.pers["progressionVerified"]) || player iscodcaster() || isai(player)) {
      continue;
    }

    player.pers["verifiedInitialXP"] = 0;
    player.pers["verifiedPrestige"] = 0;
    player.pers["progressionVerified"] = 0;
    validplayers[validplayers.size] = player;
  }

  function_6e150ba45a6aa08(validplayers, level.var_86d6d54de22b6720);
  level.var_686e16e6fe5b5443 = 1;
}

function function_776a3b17ae4523c() {
  assert(isPlayer(self));
  player = self;

  if(!level.var_686e16e6fe5b5443 || !isDefined(level.var_86d6d54de22b6720) || level.var_86d6d54de22b6720 == 0) {
    return;
  }

  if(player iscodcaster() || isai(player) || isDefined(player.pers["progressionVerified"])) {
    return;
  }

  player.pers["verifiedInitialXP"] = 0;
  player.pers["verifiedPrestige"] = 0;
  player.pers["progressionVerified"] = 0;
  self function_fdf029c4be6546a3(level.var_86d6d54de22b6720);
}

function function_f9c086937d2a8eb2(achievementid, progressdata) {
  assert(isPlayer(self));
  player = self;

  if(achievementid == level.var_86d6d54de22b6720) {
    xp_progress_id = int(playerachievements::function_a550b9c75bcbee5e("xp"));
    rank_progress_id = int(playerachievements::function_a550b9c75bcbee5e("rank"));
    prestige_progress_id = int(playerachievements::function_a550b9c75bcbee5e("prestige"));
    bp_bc_loyalty_progress_id = int(playerachievements::function_a550b9c75bcbee5e("bc_loyalty"));
    xp = 0;
    prestige = 0;
    bp_bc_loyalty = 0;

    for(index = 0; index < progressdata.progress_values.size; index++) {
      progress_id = int(progressdata.progress_values[index].progress_id);

      if(progress_id == xp_progress_id) {
        xp = progressdata.progress_values[index].progress;
        continue;
      }

      if(progress_id == prestige_progress_id) {
        prestige = progressdata.progress_values[index].progress;
        continue;
      }

      if(progress_id == bp_bc_loyalty_progress_id) {
        bp_bc_loyalty = progressdata.progress_values[index].progress;
      }
    }

    player_reported_xp = player function_ad429e448c443545();
    player_reported_prestige = player function_89de54a4f43714a4();

    if(xp != player_reported_xp || prestige != player_reported_prestige) {
      event_data = ["player_reported_xp", player_reported_xp, "player_reported_prestige", player_reported_prestige, "server_received_xp", xp, "server_received_prestige", prestige, "player_xp_at_comparison", player.pers["rankxp"], "player_xp_earned_in_match", player.pers["prestige"]];
      dlog_recordevent("dlog_event_sv_progression_validation_failure", event_data);
    }

    player.pers["verifiedInitialXP"] = xp;
    player.pers["verifiedPrestige"] = prestige;
    player.pers["progressionVerified"] = 1;
    player.pers["rankxp"] = xp;
    player.pers["prestige"] = prestige;

    if(!isDefined(player.pers["telemetry"])) {
      player.pers["telemetry"] = spawnStruct();
    }

    player.pers["telemetry"].xp_at_start = xp;
    player.pers["telemetry"].rank_at_start = player progression_utility::getrankforxp(xp);
    player.pers["telemetry"].progression_verified = 1;
    player.pers["telemetry"].prestige_at_start = prestige;
    player.pers["telemetry"].blackcell_loyalty = bp_bc_loyalty;
    println("<dev string:x24>" + player.name + "<dev string:x62>" + xp + "<dev string:x6b>" + prestige);
  }
}

function function_a14a1871d0fbd201() {
  assert(isPlayer(self));
  return self.pers["progressionVerified"];
}

function function_ad429e448c443545() {
  assert(isPlayer(self));

  if(!self hasplayerdata()) {
    return 0;
  }

  if(class::function_4d362babbfd5b4b1()) {
    return int(max(self getplayerdata(level.loadoutsgroup, "playerState", "xp"), 0));
  }

  return int(max(self getplayerdata(level.loadoutsgroup, "squadMembers", "player_xp"), 0));
}

function function_1f72ecc33fd16c37() {
  assert(isPlayer(self));

  if(!self hasplayerdata()) {
    return 0;
  }

  return progression_utility::getrankforxp(function_ad429e448c443545());
}

function function_89de54a4f43714a4() {
  assert(isPlayer(self));

  if(!self hasplayerdata()) {
    return 0;
  }

  if(class::function_4d362babbfd5b4b1()) {
    return int(max(self getplayerdata(level.loadoutsgroup, "playerState", "prestige"), 0));
  }

  return int(max(self getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank"), 0));
}

function function_f1463e2fc3079b2e() {
  assert(isPlayer(self));
  return self.pers["verifiedInitialXP"];
}

function function_7a2ab5e27a9084d0() {
  assert(isPlayer(self));
  return progression_utility::getrankforxp(function_f1463e2fc3079b2e());
}

function function_613f2ac0acef366f() {
  assert(isPlayer(self));
  return self.pers["verifiedPrestige"];
}

function function_fbde1ca37c2aeeb6() {
  assert(isPlayer(self));

  if(function_a14a1871d0fbd201()) {
    return function_f1463e2fc3079b2e();
  }

  return function_ad429e448c443545();
}

function function_1682192f91884908() {
  assert(isPlayer(self));

  if(function_a14a1871d0fbd201()) {
    return function_7a2ab5e27a9084d0();
  }

  return function_1f72ecc33fd16c37();
}

function getprestige() {
  assert(isPlayer(self));

  if(function_a14a1871d0fbd201()) {
    return function_613f2ac0acef366f();
  }

  return function_89de54a4f43714a4();
}