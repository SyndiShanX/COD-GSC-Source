/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_gameskill.gsc
**************************************/

#include maps\_utility;
#include animscripts\utility;
#include common_scripts\utility;
#include animscripts\combat_utility;
#include animscripts\weaponlist;
#include maps\_gameskill;
#include maps\_damagefeedback;

setskill(reset, skill_override) {
  if(!isDefined(level.script))
    level.script = tolower(getdvar(#"mapname"));

  if(!isDefined(reset) || reset == 0) {
    if(isDefined(level.gameskill)) {
      return;
    }
    level.global_damage_func_ads = ::empty_kill_func;
    level.global_damage_func = ::empty_kill_func;
    level.global_kill_func = ::empty_kill_func;
    set_console_status();
    flag_init("player_has_red_flashing_overlay");
    flag_init("player_is_invulnerable");
    level thread update_skill_on_change();
    thread playerhealthdebug();
  }

  if(!isDefined(level.invultime_onshield_multiplier))
    level.invultime_onshield_multiplier = 1;

  if(!isDefined(level.player_attacker_accuracy_multiplier))
    level.player_attacker_accuracy_multiplier = 1;

  level.gameskill = getlocalprofileint("g_gameskill");

  if(isDefined(skill_override))
    level.gameskill = skill_override;

  replay_single_mission = getdvarint(#"_id_0F241E06");

  if(replay_single_mission == 1) {
    single_mission_difficulty = getdvarint(#"_id_1DFA0958");

    if(single_mission_difficulty >= 0)
      level.gameskill = single_mission_difficulty;
  }

  setdvar("saved_gameskill", level.gameskill);

  switch (level.gameskill) {
    case 0:
      setdvar("currentDifficulty", "easy");
      level.currentdifficulty = "easy";
      break;
    case 1:
      setdvar("currentDifficulty", "normal");
      level.currentdifficulty = "normal";
      break;
    case 2:
      setdvar("currentDifficulty", "hardened");
      level.currentdifficulty = "hardened";
      break;
    case 3:
      setdvar("currentDifficulty", "veteran");
      level.currentdifficulty = "veteran";
      break;
  }

  anim.run_accuracy = 0.5;
  logstring("difficulty: " + level.gameskill);
  level.auto_adjust_threatbias = 1;
  level.difficultysettings["playerGrenadeBaseTime"]["easy"] = 40000;
  level.difficultysettings["playerGrenadeBaseTime"]["normal"] = 25000;
  level.difficultysettings["playerGrenadeBaseTime"]["hardened"] = 10000;
  level.difficultysettings["playerGrenadeBaseTime"]["veteran"] = 0;
  level.difficultysettings["playerGrenadeRangeTime"]["easy"] = 20000;
  level.difficultysettings["playerGrenadeRangeTime"]["normal"] = 15000;
  level.difficultysettings["playerGrenadeRangeTime"]["hardened"] = 5000;
  level.difficultysettings["playerGrenadeRangeTime"]["veteran"] = 1;
  level.difficultysettings["playerDoubleGrenadeTime"]["easy"] = 3600000;
  level.difficultysettings["playerDoubleGrenadeTime"]["normal"] = 120000;
  level.difficultysettings["playerDoubleGrenadeTime"]["hardened"] = 15000;
  level.difficultysettings["playerDoubleGrenadeTime"]["veteran"] = 0;
  level.difficultysettings["double_grenades_allowed"]["easy"] = 0;
  level.difficultysettings["double_grenades_allowed"]["normal"] = 1;
  level.difficultysettings["double_grenades_allowed"]["hardened"] = 1;
  level.difficultysettings["double_grenades_allowed"]["veteran"] = 1;
  level.difficultysettings["player_deathInvulnerableTime"]["easy"] = 4000;
  level.difficultysettings["player_deathInvulnerableTime"]["normal"] = 1700.0;
  level.difficultysettings["player_deathInvulnerableTime"]["hardened"] = 600.0;
  level.difficultysettings["player_deathInvulnerableTime"]["veteran"] = 300.0;
  level.difficultysettings["threatbias"]["easy"] = 100;
  level.difficultysettings["threatbias"]["normal"] = 150;
  level.difficultysettings["threatbias"]["hardened"] = 200;
  level.difficultysettings["threatbias"]["veteran"] = 400;
  level.difficultysettings["longRegenTime"]["easy"] = 5000;
  level.difficultysettings["longRegenTime"]["normal"] = 5000;
  level.difficultysettings["longRegenTime"]["hardened"] = 5000;
  level.difficultysettings["longRegenTime"]["veteran"] = 5000;
  level.difficultysettings["healthOverlayCutoff"]["easy"] = 0.01;
  level.difficultysettings["healthOverlayCutoff"]["normal"] = 0.2;
  level.difficultysettings["healthOverlayCutoff"]["hardened"] = 0.3;
  level.difficultysettings["healthOverlayCutoff"]["veteran"] = 0.5;
  level.difficultysettings["base_enemy_accuracy"]["easy"] = 1;
  level.difficultysettings["base_enemy_accuracy"]["normal"] = 1;
  level.difficultysettings["base_enemy_accuracy"]["hardened"] = 1.3;
  level.difficultysettings["base_enemy_accuracy"]["veteran"] = 1.3;
  level.difficultysettings["accuracyDistScale"]["easy"] = 1.0;
  level.difficultysettings["accuracyDistScale"]["normal"] = 1.0;
  level.difficultysettings["accuracyDistScale"]["hardened"] = 1.0;
  level.difficultysettings["accuracyDistScale"]["veteran"] = 0.5;
  level.difficultysettings["playerDifficultyHealth"]["easy"] = 475;
  level.difficultysettings["playerDifficultyHealth"]["normal"] = 310;
  level.difficultysettings["playerDifficultyHealth"]["hardened"] = 165;
  level.difficultysettings["playerDifficultyHealth"]["veteran"] = 115;
  level.difficultysettings["min_sniper_burst_delay_time"]["easy"] = 3.0;
  level.difficultysettings["min_sniper_burst_delay_time"]["normal"] = 2.0;
  level.difficultysettings["min_sniper_burst_delay_time"]["hardened"] = 1.5;
  level.difficultysettings["min_sniper_burst_delay_time"]["veteran"] = 1.1;
  level.difficultysettings["max_sniper_burst_delay_time"]["easy"] = 4.0;
  level.difficultysettings["max_sniper_burst_delay_time"]["normal"] = 3.0;
  level.difficultysettings["max_sniper_burst_delay_time"]["hardened"] = 2.0;
  level.difficultysettings["max_sniper_burst_delay_time"]["veteran"] = 1.5;
  level.difficultysettings["dog_health"]["easy"] = 0.25;
  level.difficultysettings["dog_health"]["normal"] = 0.75;
  level.difficultysettings["dog_health"]["hardened"] = 1.0;
  level.difficultysettings["dog_health"]["veteran"] = 1.0;
  level.difficultysettings["dog_presstime"]["easy"] = 415;
  level.difficultysettings["dog_presstime"]["normal"] = 375;
  level.difficultysettings["dog_presstime"]["hardened"] = 250;
  level.difficultysettings["dog_presstime"]["veteran"] = 225;
  level.difficultysettings["dog_hits_before_kill"]["easy"] = 2;
  level.difficultysettings["dog_hits_before_kill"]["normal"] = 1;
  level.difficultysettings["dog_hits_before_kill"]["hardened"] = 0;
  level.difficultysettings["dog_hits_before_kill"]["veteran"] = 0;
  level.difficultysettings["pain_test"]["easy"] = ::always_pain;
  level.difficultysettings["pain_test"]["normal"] = ::always_pain;
  level.difficultysettings["pain_test"]["hardened"] = ::pain_protection;
  level.difficultysettings["pain_test"]["veteran"] = ::pain_protection;
  anim.pain_test = level.difficultysettings["pain_test"][level.currentdifficulty];
  level.difficultysettings["missTimeConstant"]["easy"] = 1.0;
  level.difficultysettings["missTimeConstant"]["normal"] = 0.05;
  level.difficultysettings["missTimeConstant"]["hardened"] = 0;
  level.difficultysettings["missTimeConstant"]["veteran"] = 0;
  level.difficultysettings["missTimeDistanceFactor"]["easy"] = 0.0008;
  level.difficultysettings["missTimeDistanceFactor"]["normal"] = 0.0001;
  level.difficultysettings["missTimeDistanceFactor"]["hardened"] = 0.00005;
  level.difficultysettings["missTimeDistanceFactor"]["veteran"] = 0;
  level.difficultysettings["flashbangedInvulFactor"]["easy"] = 0.25;
  level.difficultysettings["flashbangedInvulFactor"]["normal"] = 0;
  level.difficultysettings["flashbangedInvulFactor"]["hardened"] = 0;
  level.difficultysettings["flashbangedInvulFactor"]["veteran"] = 0;
  level.difficultysettings["invulTime_preShield"]["easy"] = 0.6;
  level.difficultysettings["invulTime_preShield"]["normal"] = 0.35;
  level.difficultysettings["invulTime_preShield"]["hardened"] = 0.1;
  level.difficultysettings["invulTime_preShield"]["veteran"] = 0.0;
  level.difficultysettings["invulTime_onShield"]["easy"] = 0.8;
  level.difficultysettings["invulTime_onShield"]["normal"] = 0.5;
  level.difficultysettings["invulTime_onShield"]["hardened"] = 0.1;
  level.difficultysettings["invulTime_onShield"]["veteran"] = 0.05;
  level.difficultysettings["invulTime_postShield"]["easy"] = 0.5;
  level.difficultysettings["invulTime_postShield"]["normal"] = 0.3;
  level.difficultysettings["invulTime_postShield"]["hardened"] = 0.1;
  level.difficultysettings["invulTime_postShield"]["veteran"] = 0.0;
  level.difficultysettings["playerHealth_RegularRegenDelay"]["easy"] = 3000;
  level.difficultysettings["playerHealth_RegularRegenDelay"]["normal"] = 2400.0;
  level.difficultysettings["playerHealth_RegularRegenDelay"]["hardened"] = 1200.0;
  level.difficultysettings["playerHealth_RegularRegenDelay"]["veteran"] = 1200.0;
  level.difficultysettings["worthyDamageRatio"]["easy"] = 0.0;
  level.difficultysettings["worthyDamageRatio"]["normal"] = 0.1;
  level.difficultysettings["worthyDamageRatio"]["hardened"] = 0.1;
  level.difficultysettings["worthyDamageRatio"]["veteran"] = 0.1;
  level.difficultysettings["explosivePlantTime"]["easy"] = 10;
  level.difficultysettings["explosivePlantTime"]["normal"] = 10;
  level.difficultysettings["explosivePlantTime"]["hardened"] = 5;
  level.difficultysettings["explosivePlantTime"]["veteran"] = 5;
  level.explosiveplanttime = level.difficultysettings["explosivePlantTime"][level.currentdifficulty];
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["easy"][0] = 1.0;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["easy"][1] = 0.9;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["easy"][2] = 0.8;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["easy"][3] = 0.7;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["normal"][0] = 1.0;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["normal"][1] = 0.9;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["normal"][2] = 0.8;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["normal"][3] = 0.7;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["hardened"][0] = 1.0;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["hardened"][1] = 0.9;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["hardened"][2] = 0.8;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["hardened"][3] = 0.7;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["veteran"][0] = 1.0;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["veteran"][1] = 0.9;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["veteran"][2] = 0.8;
  level.difficultysettings["coopPlayer_deathInvulnerableTime"]["veteran"][3] = 0.7;
  level.difficultysettings["coopPlayerDifficultyHealth"]["easy"][0] = 1.0;
  level.difficultysettings["coopPlayerDifficultyHealth"]["easy"][1] = 0.95;
  level.difficultysettings["coopPlayerDifficultyHealth"]["easy"][2] = 0.8;
  level.difficultysettings["coopPlayerDifficultyHealth"]["easy"][3] = 0.75;
  level.difficultysettings["coopPlayerDifficultyHealth"]["normal"][0] = 1.0;
  level.difficultysettings["coopPlayerDifficultyHealth"]["normal"][1] = 0.9;
  level.difficultysettings["coopPlayerDifficultyHealth"]["normal"][2] = 0.8;
  level.difficultysettings["coopPlayerDifficultyHealth"]["normal"][3] = 0.7;
  level.difficultysettings["coopPlayerDifficultyHealth"]["hardened"][0] = 1.0;
  level.difficultysettings["coopPlayerDifficultyHealth"]["hardened"][1] = 0.85;
  level.difficultysettings["coopPlayerDifficultyHealth"]["hardened"][2] = 0.7;
  level.difficultysettings["coopPlayerDifficultyHealth"]["hardened"][3] = 0.65;
  level.difficultysettings["coopPlayerDifficultyHealth"]["veteran"][0] = 1.0;
  level.difficultysettings["coopPlayerDifficultyHealth"]["veteran"][1] = 0.8;
  level.difficultysettings["coopPlayerDifficultyHealth"]["veteran"][2] = 0.6;
  level.difficultysettings["coopPlayerDifficultyHealth"]["veteran"][3] = 0.5;
  level.difficultysettings["coopEnemyAccuracyScalar"]["easy"][0] = 1;
  level.difficultysettings["coopEnemyAccuracyScalar"]["easy"][1] = 1.1;
  level.difficultysettings["coopEnemyAccuracyScalar"]["easy"][2] = 1.2;
  level.difficultysettings["coopEnemyAccuracyScalar"]["easy"][3] = 1.3;
  level.difficultysettings["coopEnemyAccuracyScalar"]["normal"][0] = 1;
  level.difficultysettings["coopEnemyAccuracyScalar"]["normal"][1] = 1.1;
  level.difficultysettings["coopEnemyAccuracyScalar"]["normal"][2] = 1.3;
  level.difficultysettings["coopEnemyAccuracyScalar"]["normal"][3] = 1.5;
  level.difficultysettings["coopEnemyAccuracyScalar"]["hardened"][0] = 1.0;
  level.difficultysettings["coopEnemyAccuracyScalar"]["hardened"][1] = 1.2;
  level.difficultysettings["coopEnemyAccuracyScalar"]["hardened"][2] = 1.4;
  level.difficultysettings["coopEnemyAccuracyScalar"]["hardened"][3] = 1.6;
  level.difficultysettings["coopEnemyAccuracyScalar"]["veteran"][0] = 1;
  level.difficultysettings["coopEnemyAccuracyScalar"]["veteran"][1] = 1.3;
  level.difficultysettings["coopEnemyAccuracyScalar"]["veteran"][2] = 1.6;
  level.difficultysettings["coopEnemyAccuracyScalar"]["veteran"][3] = 2;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["easy"][0] = 1;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["easy"][1] = 0.9;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["easy"][2] = 0.8;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["easy"][3] = 0.7;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["normal"][0] = 1;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["normal"][1] = 0.8;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["normal"][2] = 0.7;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["normal"][3] = 0.6;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["hardened"][0] = 1;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["hardened"][1] = 0.7;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["hardened"][2] = 0.5;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["hardened"][3] = 0.5;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["veteran"][0] = 1;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["veteran"][1] = 0.7;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["veteran"][2] = 0.5;
  level.difficultysettings["coopFriendlyAccuracyScalar"]["veteran"][3] = 0.4;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["easy"][0] = 1;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["easy"][1] = 1.1;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["easy"][2] = 1.2;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["easy"][3] = 1.3;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["normal"][0] = 1;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["normal"][1] = 2;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["normal"][2] = 3;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["normal"][3] = 4;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["hardened"][0] = 1.0;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["hardened"][1] = 3;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["hardened"][2] = 6;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["hardened"][3] = 9;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["veteran"][0] = 1;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["veteran"][1] = 10;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["veteran"][2] = 20;
  level.difficultysettings["coopFriendlyThreatBiasScalar"]["veteran"][3] = 30;
  level.difficultysettings["lateralAccuracyModifier"]["easy"] = 300;
  level.difficultysettings["lateralAccuracyModifier"]["normal"] = 700;
  level.difficultysettings["lateralAccuracyModifier"]["hardened"] = 1000;
  level.difficultysettings["lateralAccuracyModifier"]["veteran"] = 2500;
  set_difficulty_from_locked_settings();

  if(coopgame()) {
    thread coop_player_threat_bias_adjuster();
    thread coop_enemy_accuracy_scalar_watcher();
    thread coop_friendly_accuracy_scalar_watcher();
  }
}

apply_difficulty_var_with_func(difficulty_func) {
  level.invultime_preshield = [[difficulty_func]]("invulTime_preShield");
  level.invultime_onshield = [[difficulty_func]]("invulTime_onShield") * level.invultime_onshield_multiplier;
  level.invultime_postshield = [[difficulty_func]]("invulTime_postShield");
  level.playerhealth_regularregendelay = [[difficulty_func]]("playerHealth_RegularRegenDelay");
  level.worthydamageratio = [[difficulty_func]]("worthyDamageRatio");

  if(level.auto_adjust_threatbias)
    thread apply_threat_bias_to_all_players(difficulty_func);

  level.longregentime = [[difficulty_func]]("longRegenTime");
  level.healthoverlaycutoff = [[difficulty_func]]("healthOverlayCutoff");
  anim.player_attacker_accuracy = [[difficulty_func]]("base_enemy_accuracy") * level.player_attacker_accuracy_multiplier;
  anim.misstimeconstant = [[difficulty_func]]("missTimeConstant");
  anim.misstimedistancefactor = [[difficulty_func]]("missTimeDistanceFactor");
  anim.dog_hits_before_kill = [[difficulty_func]]("dog_hits_before_kill");
  anim.double_grenades_allowed = [[difficulty_func]]("double_grenades_allowed");
  anim.playergrenadebasetime = int([[difficulty_func]]("playerGrenadeBaseTime"));
  anim.playergrenaderangetime = int([[difficulty_func]]("playerGrenadeRangeTime"));
  anim.playerdoublegrenadetime = int([[difficulty_func]]("playerDoubleGrenadeTime"));
  anim.min_sniper_burst_delay_time = [[difficulty_func]]("min_sniper_burst_delay_time");
  anim.max_sniper_burst_delay_time = [[difficulty_func]]("max_sniper_burst_delay_time");
  anim.dog_health = [[difficulty_func]]("dog_health");
  anim.dog_presstime = [[difficulty_func]]("dog_presstime");
  setsaveddvar("ai_accuracyDistScale", [[difficulty_func]]("accuracyDistScale"));
  thread coop_damage_and_accuracy_scaling(difficulty_func);
}

apply_threat_bias_to_all_players(difficulty_func) {
  while(!isDefined(level.flag) || !isDefined(level.flag["all_players_connected"])) {
    wait 0.05;
    continue;
  }

  flag_wait("all_players_connected");
  players = get_players();

  for(i = 0; i < players.size; i++)
    players[i].threatbias = int([
      [difficulty_func]
    ]("threatbias"));
}

coop_damage_and_accuracy_scaling(difficulty_func) {
  while(!isDefined(level.flag))
    wait 0.05;

  while(!isDefined(level.flag["all_players_spawned"]))
    wait 0.05;

  flag_wait("all_players_spawned");
  players = get_players();
  coop_healthscalar = getcoopvalue("coopPlayerDifficultyHealth", players.size);
  setsaveddvar("player_meleeDamageMultiplier", 0.4);
  setsaveddvar("player_damageMultiplier", 100 / ([[difficulty_func]]("playerDifficultyHealth") * coop_healthscalar));
  coop_invuln_remover = getcoopvalue("coopPlayer_deathInvulnerableTime", players.size);
  setsaveddvar("player_deathInvulnerableTime", int([[difficulty_func]]("player_deathInvulnerableTime") * coop_invuln_remover));
}

set_difficulty_from_locked_settings() {
  apply_difficulty_var_with_func(::get_locked_difficulty_val);
}

getcurrentdifficultysetting(msg) {
  return level.difficultysettings[msg][level.currentdifficulty];
}

getcoopvalue(msg, numplayers) {
  if(numplayers <= 0)
    numplayers = 1;

  return level.difficultysettings[msg][getdvar(#"_id_DA8CD87B")][numplayers - 1];
}

get_locked_difficulty_val(msg, ignored) {
  return level.difficultysettings[msg][level.currentdifficulty];
}

always_pain() {
  return false;
}

pain_protection() {
  if(!pain_protection_check())
    return false;

  return randomint(100) > 25;
}

pain_protection_check() {
  if(!isalive(self.enemy))
    return false;

  if(!isplayer(self.enemy))
    return false;

  if(!isalive(level.painai) || level.painai.a.script != "pain")
    level.painai = self;

  if(self == level.painai)
    return false;

  if(self.damageweapon != "none" && weaponisboltaction(self.damageweapon))
    return false;

  return true;
}

playerhealthdebug() {
  setdvar("scr_health_debug", "1");
  waittillframeend;

  while(true) {
    while(true) {
      if(getdvar(#"scr_health_debug") != "0") {
        break;
      }

      wait 0.5;
    }

    thread printhealthdebug();

    while(true) {
      if(getdvar(#"scr_health_debug") == "0") {
        break;
      }

      wait 0.5;
    }

    level notify("stop_printing_grenade_timers");
    destroyhealthdebug();
  }

}

printhealthdebug() {
  level notify("stop_printing_health_bars");
  level endon("stop_printing_health_bars");
  y = 40;
  level.healthbarhudelems = [];
  level.healthbarkeys[0] = "Health";
  level.healthbarkeys[1] = "No Hit Time";
  level.healthbarkeys[2] = "No Die Time";

  if(!isDefined(level.playerinvultimeend))
    level.playerinvultimeend = 0;

  if(!isDefined(level.player_deathinvulnerabletimeout))
    level.player_deathinvulnerabletimeout = 0;

  for(i = 0; i < level.healthbarkeys.size; i++) {
    key = level.healthbarkeys[i];
    textelem = newhudelem();
    textelem.x = 40;
    textelem.y = y;
    textelem.alignx = "left";
    textelem.aligny = "top";
    textelem.horzalign = "fullscreen";
    textelem.vertalign = "fullscreen";
    textelem settext(key);
    bgbar = newhudelem();
    bgbar.x = 40 + 79;
    bgbar.y = y + 1;
    bgbar.z = 1;
    bgbar.alignx = "left";
    bgbar.aligny = "top";
    bgbar.horzalign = "fullscreen";
    bgbar.vertalign = "fullscreen";
    bgbar.maxwidth = 3;
    bgbar setshader("white", bgbar.maxwidth, 10);
    bgbar.color = vectorscale((1, 1, 1), 0.5);
    bar = newhudelem();
    bar.x = 40 + 80;
    bar.y = y + 2;
    bar.alignx = "left";
    bar.aligny = "top";
    bar.horzalign = "fullscreen";
    bar.vertalign = "fullscreen";
    bar setshader("black", 1, 8);
    textelem.bar = bar;
    textelem.bgbar = bgbar;
    textelem.key = key;
    y = y + 10;
    level.healthbarhudelems[key] = textelem;
  }

  flag_wait("all_players_spawned");

  while(true) {
    wait 0.05;
    players = get_players();

    for(i = 0; i < level.healthbarkeys.size && players.size > 0; i++) {
      key = level.healthbarkeys[i];
      player = players[0];
      width = 0;

      if(i == 0)
        width = player.health / player.maxhealth * 300;
      else if(i == 1)
        width = (level.playerinvultimeend - gettime()) / 1000 * 40;
      else if(i == 2)
        width = (level.player_deathinvulnerabletimeout - gettime()) / 1000 * 40;

      width = int(max(width, 1));
      width = int(min(width, 300));
      bar = level.healthbarhudelems[key].bar;
      bar setshader("black", width, 8);
      bgbar = level.healthbarhudelems[key].bgbar;

      if(width + 2 > bgbar.maxwidth) {
        bgbar.maxwidth = width + 2;
        bgbar setshader("white", bgbar.maxwidth, 10);
        bgbar.color = vectorscale((1, 1, 1), 0.5);
      }
    }
  }
}

destroyhealthdebug() {
  level notify("stop_printing_health_bars");

  if(!isDefined(level.healthbarhudelems)) {
    return;
  }
  for(i = 0; i < level.healthbarkeys.size; i++) {
    level.healthbarhudelems[level.healthbarkeys[i]].bgbar destroy();
    level.healthbarhudelems[level.healthbarkeys[i]].bar destroy();
    level.healthbarhudelems[level.healthbarkeys[i]] destroy();
  }
}

axisaccuracycontrol() {
  self endon("long_death");
  self endon("death");
  self coop_axis_accuracy_scaler();
}

alliesaccuracycontrol() {
  self endon("long_death");
  self endon("death");
  self coop_allies_accuracy_scaler();
}

set_accuracy_based_on_situation() {
  if(self animscripts\combat_utility::issniper() && isalive(self.enemy)) {
    self setsniperaccuracy();
    return;
  }

  if(isplayer(self.enemy)) {
    resetmissdebouncetime();

    if(self.a.misstime > gettime()) {
      self.accuracy = 0;
      return;
    }

    if(self.a.script == "move") {
      self.accuracy = anim.run_accuracy * self.baseaccuracy;
      return;
    }
  } else if(self.a.script == "move") {
    self.accuracy = anim.run_accuracy * self.baseaccuracy;
    return;
  }

  self.accuracy = self.baseaccuracy;
}

setsniperaccuracy() {
  if(!isDefined(self.snipershotcount)) {
    self.snipershotcount = 0;
    self.sniperhitcount = 0;
  }

  self.snipershotcount++;

  if((!isDefined(self.lastmissedenemy) || self.enemy != self.lastmissedenemy) && distancesquared(self.origin, self.enemy.origin) > 250000) {
    self.accuracy = 0;

    if(level.gameskill > 0 || self.snipershotcount > 1)
      self.lastmissedenemy = self.enemy;

    return;
  }

  self.accuracy = (1 + 1 * self.sniperhitcount) * self.baseaccuracy;
  self.sniperhitcount++;

  if(level.gameskill < 1 && self.sniperhitcount == 1)
    self.lastmissedenemy = undefined;
}

didsomethingotherthanshooting() {
  self.a.misstimedebounce = 0;
}

resetmisstime() {
  if(self.team != "axis") {
    return;
  }
  if(self.weapon == "none") {
    return;
  }
  if(!self animscripts\weaponlist::usingautomaticweapon() && !self animscripts\weaponlist::usingsemiautoweapon()) {
    self.misstime = 0;
    return;
  }

  self.a.nonstopfire = 0;

  if(!isalive(self.enemy)) {
    return;
  }
  if(!isplayer(self.enemy)) {
    self.accuracy = self.baseaccuracy;
    return;
  }

  dist = distance(self.enemy.origin, self.origin);
  self setmisstime(anim.misstimeconstant + dist * anim.misstimedistancefactor);
}

resetmissdebouncetime() {
  self.a.misstimedebounce = gettime() + 3000;
}

setmisstime(howlong) {
  assert(self.team == "axis", "Non axis tried to set misstime");

  if(self.a.misstimedebounce > gettime()) {
    return;
  }
  if(howlong > 0)
    self.accuracy = 0;

  howlong = howlong * 1000;
  self.a.misstime = gettime() + howlong;
  self.a.accuracygrowthmultiplier = 1;
}

playerhurtcheck() {
  self.hurtagain = 0;

  for(;;) {
    self waittill("damage", amount, attacker, dir, point, mod);

    if(isDefined(attacker) && isplayer(attacker) && attacker.team == self.team) {
      continue;
    }
    self.hurtagain = 1;
    self.damagepoint = point;
    self.damageattacker = attacker;

    if(isDefined(mod) && mod == "MOD_BURNED") {
      self setburn(0.5);
      self playsound("chr_burn");
    }
  }
}

playerhealthregen() {
  self endon("death");
  self endon("disconnect");

  if(!isDefined(self.flag)) {
    self.flag = [];
    self.flags_lock = [];
  }

  if(!isDefined(self.flag["player_has_red_flashing_overlay"])) {
    self player_flag_init("player_has_red_flashing_overlay");
    self player_flag_init("player_is_invulnerable");
  }

  self player_flag_clear("player_has_red_flashing_overlay");
  self player_flag_clear("player_is_invulnerable");
  self thread increment_take_cover_warnings_on_death();
  self settakecoverwarnings();
  self thread healthoverlay();
  oldratio = 1;
  health_add = 0;
  veryhurt = 0;
  playerjustgotredflashing = 0;
  invultime = 0;
  hurttime = 0;
  newhealth = 0;
  lastinvulratio = 1;
  self thread playerhurtcheck();

  if(!isDefined(self.veryhurt))
    self.veryhurt = 0;

  self.bolthit = 0;

  for(;;) {
    wait 0.05;
    waittillframeend;

    if(self.health == self.maxhealth) {
      if(self player_flag("player_has_red_flashing_overlay"))
        player_flag_clear("player_has_red_flashing_overlay");

      lastinvulratio = 1;
      playerjustgotredflashing = 0;
      veryhurt = 0;
      continue;
    }

    if(self.health <= 0) {
      return;
    }
    wasveryhurt = veryhurt;
    health_ratio = self.health / self.maxhealth;

    if(health_ratio <= level.healthoverlaycutoff) {
      veryhurt = 1;
      self thread cover_warning_check();

      if(!wasveryhurt) {
        hurttime = gettime();

        if(!isDefined(level.disable_damage_blur))
          self startfadingblur(3.6, 2);

        self player_flag_set("player_has_red_flashing_overlay");
        playerjustgotredflashing = 1;
      }
    }

    if(self.hurtagain) {
      hurttime = gettime();
      self.hurtagain = 0;
    }

    if(health_ratio >= oldratio) {
      if(gettime() - hurttime < level.playerhealth_regularregendelay) {
        continue;
      }
      if(veryhurt) {
        self.veryhurt = 1;
        newhealth = health_ratio;

        if(gettime() > hurttime + level.longregentime)
          newhealth = newhealth + 0.1;

        if(newhealth >= 1)
          reducetakecoverwarnings();
      } else {
        newhealth = 1;
        self.veryhurt = 0;
      }

      if(newhealth > 1.0)
        newhealth = 1.0;

      if(newhealth <= 0) {
        return;
      }
      self setnormalhealth(newhealth);
      oldratio = self.health / self.maxhealth;
      continue;
    }

    invulworthyhealthdrop = lastinvulratio - health_ratio > level.worthydamageratio;

    if(self.health <= 1) {
      self setnormalhealth(2 / self.maxhealth);
      invulworthyhealthdrop = 1;

      if(!isDefined(level.player_deathinvulnerabletimeout))
        level.player_deathinvulnerabletimeout = 0;

      if(level.player_deathinvulnerabletimeout < gettime())
        level.player_deathinvulnerabletimeout = gettime() + getdvarint(#"_id_4E44E32D");
    }

    oldratio = self.health / self.maxhealth;
    level notify("hit_again");
    health_add = 0;
    hurttime = gettime();

    if(!isDefined(level.disable_damage_blur))
      self startfadingblur(3, 0.8);

    if(!invulworthyhealthdrop) {
      continue;
    }
    if(self player_flag("player_is_invulnerable")) {
      continue;
    }
    self player_flag_set("player_is_invulnerable");
    level notify("player_becoming_invulnerable");

    if(playerjustgotredflashing) {
      invultime = level.invultime_onshield;
      playerjustgotredflashing = 0;
    } else if(veryhurt)
      invultime = level.invultime_postshield;
    else
      invultime = level.invultime_preshield;

    lastinvulratio = self.health / self.maxhealth;
    self thread playerinvul(invultime);
  }
}

reducetakecoverwarnings() {
  players = get_players();

  if(isDefined(players[0]) && isalive(players[0])) {
    takecoverwarnings = getlocalprofileint("takeCoverWarnings");

    if(takecoverwarnings > 0) {
      takecoverwarnings--;
      setlocalprofilevar("takeCoverWarnings", takecoverwarnings);

      debugtakecoverwarnings();

    }
  }
}

debugtakecoverwarnings() {
  if(getdvar(#"_id_57298A77") == "")
    setdvar("scr_debugtakecover", "0");

  if(getdebugdvar("scr_debugtakecover") == "1")
    iprintln("Warnings remaining: ", getlocalprofileint("takeCoverWarnings") - 3);
}

playerinvul(timer) {
  self endon("death");
  self endon("disconnect");

  if(isDefined(self.flashendtime) && self.flashendtime > gettime())
    timer = timer * getcurrentdifficultysetting("flashbangedInvulFactor");

  if(timer > 0) {
    self.attackeraccuracy = 0;
    self.ignorerandombulletdamage = 1;
    level.playerinvultimeend = gettime() + timer * 1000;
    wait(timer);
  }

  self.attackeraccuracy = anim.player_attacker_accuracy;
  self.ignorerandombulletdamage = 0;
  self player_flag_clear("player_is_invulnerable");
}

grenadeawareness() {
  if(self.team == "allies") {
    self.grenadeawareness = 0.9;
    return;
  }

  if(self.team == "axis") {
    if(level.gameskill >= 2) {
      if(randomint(100) < 33)
        self.grenadeawareness = 0.2;
      else
        self.grenadeawareness = 0.5;
    } else if(randomint(100) < 33)
      self.grenadeawareness = 0;
    else
      self.grenadeawareness = 0.2;
  }
}

playerheartbeatloop(healthcap) {
  self endon("disconnect");
  self endon("killed_player");
  wait 2;
  player = self;
  ent = undefined;

  for(;;) {
    wait 0.2;

    if(player.health >= healthcap) {
      if(isDefined(ent)) {
        ent stoploopsound(1.5);
        level thread delayed_delete(ent, 1.5);
      }

      continue;
    }

    ent = spawn("script_origin", self.origin);
    ent playloopsound("", 0.5);
  }
}

delayed_delete(ent, time) {
  wait(time);
  ent delete();
  ent = undefined;
}

healthfadeoffwatcher(overlay, timetofadeout) {
  self notify("new_style_health_overlay_done");
  self endon("new_style_health_overlay_done");

  while(!is_true(level.disable_damage_overlay) && timetofadeout > 0) {
    wait 0.05;
    timetofadeout = timetofadeout - 0.05;
  }

  if(is_true(level.disable_damage_overlay)) {
    overlay.alpha = 0;
    overlay fadeovertime(0.05);
  }
}

new_style_health_overlay() {
  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;

  if(issplitscreen()) {
    overlay setshader("overlay_low_health_splat", 640, 960);

    if(self == level.players[0])
      overlay.y = overlay.y - 120;
  } else
    overlay setshader("overlay_low_health_splat", 640, 480);

  overlay.splatter = 1;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.foreground = 0;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 0;
  thread healthoverlay_remove(overlay);

  while(true) {
    wait 0.05;

    if(is_true(level.disable_damage_overlay)) {
      targetdamagealpha = 0;
      overlay.alpha = 0;
    } else
      targetdamagealpha = 1.0 - self.health / self.maxhealth;

    if(overlay.alpha < targetdamagealpha)
      overlay.alpha = targetdamagealpha;
    else if(overlay.alpha != 0) {
      level thread healthfadeoffwatcher(overlay, 0.75);
      overlay fadeovertime(0.75);
      overlay.alpha = 0;
    }
  }
}

healthoverlay() {
  self endon("disconnect");
  self endon("noHealthOverlay");
  new_style_health_overlay();
}

add_hudelm_position_internal(aligny) {
  if(level.console)
    self.fontscale = 2;
  else
    self.fontscale = 1.6;

  self.x = 0;
  self.y = -36;
  self.alignx = "center";
  self.aligny = "bottom";
  self.horzalign = "center";
  self.vertalign = "middle";

  if(!isDefined(self.background)) {
    return;
  }
  self.background.x = 0;
  self.background.y = -40;
  self.background.alignx = "center";
  self.background.aligny = "middle";
  self.background.horzalign = "center";
  self.background.vertalign = "middle";

  if(level.console)
    self.background setshader("popmenu_bg", 650, 52);
  else
    self.background setshader("popmenu_bg", 650, 42);

  self.background.alpha = 0.5;
}

create_warning_elem(player) {
  level notify("hud_elem_interupt");
  hudelem = newhudelem();
  hudelem maps\_gameskill::add_hudelm_position_internal();
  hudelem thread maps\_gameskill::destroy_warning_elem_when_mission_failed(player);
  hudelem settext(&"GAME_GET_TO_COVER");
  hudelem.fontscale = 1.85;
  hudelem.alpha = 1;
  hudelem.color = (1, 0.6, 0);
  return hudelem;
}

play_hurt_vox() {
  if(isDefined(self.veryhurt)) {
    if(self.veryhurt == 0) {
      if(randomintrange(0, 1) == 1)
        playsoundatposition("chr_breathing_hurt_start", self.origin);
    }
  }
}

waittillplayerishitagain() {
  level endon("hit_again");
  self waittill("damage");
}

destroy_warning_elem_when_mission_failed(player) {
  self endon("being_destroyed");
  self endon("death");
  flag_wait("missionfailed");
  self thread destroy_warning_elem(1);
}

destroy_warning_elem(fadeout) {
  self notify("being_destroyed");
  self.beingdestroyed = 1;

  if(fadeout) {
    self fadeovertime(0.5);
    self.alpha = 0;
    wait 0.5;
  }

  self death_notify_wrapper();
  self destroy();
}

maychangecoverwarningalpha(coverwarning) {
  if(!isDefined(coverwarning))
    return false;

  if(isDefined(coverwarning.beingdestroyed))
    return false;

  return true;
}

fontscaler(scale, timer) {
  self endon("death");
  scale = scale * 2;
  dif = scale - self.fontscale;
  self changefontscaleovertime(timer);
  self.fontscale = self.fontscale + dif;
}

cover_warning_check() {
  level endon("missionfailed");

  if(self shouldshowcoverwarning()) {
    coverwarning = create_warning_elem(self);
    level.cover_warning_hud = coverwarning;
    coverwarning endon("death");
    stopflashingbadlytime = gettime() + level.longregentime;
    yellow_fac = 0.7;

    while(gettime() < stopflashingbadlytime && isalive(self)) {
      for(i = 0; i < 7; i++) {
        yellow_fac = yellow_fac + 0.03;
        coverwarning.color = (1, yellow_fac, 0);
        wait 0.05;
      }

      for(i = 0; i < 7; i++) {
        yellow_fac = yellow_fac - 0.03;
        coverwarning.color = (1, yellow_fac, 0);
        wait 0.05;
      }
    }

    if(maps\_gameskill::maychangecoverwarningalpha(coverwarning)) {
      coverwarning fadeovertime(0.5);
      coverwarning.alpha = 0;
    }

    wait 0.5;
    wait 5;
    coverwarning destroy();
  }
}

shouldshowcoverwarning() {
  return 0;

  if(isDefined(level.enable_cover_warning))
    return level.enable_cover_warning;

  if(!isalive(self))
    return 0;

  if(level.gameskill > 1)
    return 0;

  if(level.missionfailed)
    return 0;

  if(issplitscreen() || coopgame())
    return 0;

  takecoverwarnings = getlocalprofileint("takeCoverWarnings");

  if(takecoverwarnings <= 3)
    return 0;

  if(isDefined(level.cover_warning_hud))
    return 0;

  return 1;
}

redflashingoverlay(overlay) {
  self endon("hit_again");
  self endon("damage");
  self endon("death");
  self endon("disconnect");
  coverwarning = undefined;

  if(self shouldshowcoverwarning())
    coverwarning = create_warning_elem(self);

  stopflashingbadlytime = gettime() + level.longregentime;
  fadefunc(overlay, coverwarning, 1, 1, 0);

  while(gettime() < stopflashingbadlytime && isalive(self))
    fadefunc(overlay, coverwarning, 0.9, 1, 0);

  if(isalive(self))
    fadefunc(overlay, coverwarning, 0.65, 0.8, 0);

  if(maychangecoverwarningalpha(coverwarning)) {
    coverwarning fadeovertime(1.0);
    coverwarning.alpha = 0;
  }

  fadefunc(overlay, coverwarning, 0, 0.6, 1);
  overlay fadeovertime(0.5);
  overlay.alpha = 0;
  self player_flag_clear("player_has_red_flashing_overlay");
  wait 0.5;
  self notify("hit_again");
}

fadefunc(overlay, coverwarning, severity, mult, hud_scaleonly) {
  fadeintime = 0.8 * 0.1;
  stayfulltime = 0.8 * (0.1 + severity * 0.2);
  fadeouthalftime = 0.8 * (0.1 + severity * 0.1);
  fadeoutfulltime = 0.8 * 0.3;
  remainingtime = 0.8 - fadeintime - stayfulltime - fadeouthalftime - fadeoutfulltime;
  assert(remainingtime >= -0.001);

  if(remainingtime < 0)
    remainingtime = 0;

  halfalpha = 0.8 + severity * 0.1;
  leastalpha = 0.5 + severity * 0.3;
  overlay fadeovertime(fadeintime);
  overlay.alpha = mult * 1.0;

  if(maychangecoverwarningalpha(coverwarning)) {
    if(!hud_scaleonly) {
      coverwarning fadeovertime(fadeintime);
      coverwarning.alpha = mult * 1.0;
    }
  }

  if(isDefined(coverwarning))
    coverwarning thread fontscaler(1.0, fadeintime);

  wait(fadeintime + stayfulltime);
  overlay fadeovertime(fadeouthalftime);
  overlay.alpha = mult * halfalpha;

  if(maychangecoverwarningalpha(coverwarning)) {
    if(!hud_scaleonly) {
      coverwarning fadeovertime(fadeouthalftime);
      coverwarning.alpha = mult * halfalpha;
    }
  }

  wait(fadeouthalftime);
  overlay fadeovertime(fadeoutfulltime);
  overlay.alpha = mult * leastalpha;

  if(maychangecoverwarningalpha(coverwarning)) {
    if(!hud_scaleonly) {
      coverwarning fadeovertime(fadeoutfulltime);
      coverwarning.alpha = mult * leastalpha;
    }
  }

  if(isDefined(coverwarning))
    coverwarning thread fontscaler(0.9, fadeoutfulltime);

  wait(fadeoutfulltime);
  wait(remainingtime);
}

healthoverlay_remove(overlay) {
  self endon("disconnect");
  self waittill_any("noHealthOverlay", "death");
  overlay fadeovertime(3.5);
  overlay.alpha = 0;
}

settakecoverwarnings() {
  ispregameplaylevel = level.script == "training" || level.script == "cargoship" || level.script == "coup";

  if(getlocalprofileint("takeCoverWarnings") == -1 || ispregameplaylevel)
    setlocalprofilevar("takeCoverWarnings", 9);

  debugtakecoverwarnings();
}

increment_take_cover_warnings_on_death() {
  if(!isplayer(self)) {
    return;
  }
  level notify("new_cover_on_death_thread");
  level endon("new_cover_on_death_thread");
  self waittill("death");

  if(!self player_flag("player_has_red_flashing_overlay")) {
    return;
  }
  if(level.gameskill > 1) {
    return;
  }
  warnings = getlocalprofileint("takeCoverWarnings");

  if(warnings < 10)
    setlocalprofilevar("takeCoverWarnings", warnings + 1);

  debugtakecoverwarnings();
}

empty_kill_func(type, loc, point, attacker, amount) {
}

update_skill_on_change() {
  level endon("stop_update_skill_on_change");
  waittillframeend;

  for(;;) {
    level waittill("difficulty_change");
    level notify("new_difficulty_request");
    level thread difficulty_pump_thread();
  }
}

difficulty_pump_thread() {
  level endon("new_difficulty_request");

  for(i = 0; i < 3; i++) {
    lowest_current_skill = getdvarint(#"saved_gameskill");
    gameskill = getlocalprofileint("g_gameskill");

    if(gameskill < lowest_current_skill)
      lowest_current_skill = gameskill;

    setskill(1, lowest_current_skill);
    wait_network_frame();
  }
}

coop_enemy_accuracy_scalar_watcher() {
  level waittill("load main complete");
  flag_wait("all_players_connected");

  while(get_players().size > 1) {
    players = get_players("allies");
    level.coop_enemy_accuracy_scalar = getcoopvalue("coopEnemyAccuracyScalar", players.size);
    wait 0.5;
  }
}

coop_friendly_accuracy_scalar_watcher() {
  level waittill("load main complete");
  flag_wait("all_players_connected");

  while(get_players().size > 1) {
    players = get_players("allies");
    level.coop_friendly_accuracy_scalar = getcoopvalue("coopFriendlyAccuracyScalar", players.size);
    wait 0.5;
  }
}

coop_axis_accuracy_scaler() {
  self endon("death");
  initialvalue = self.baseaccuracy;

  while(get_players().size > 1) {
    if(!isDefined(level.coop_enemy_accuracy_scalar)) {
      wait 0.5;
      continue;
    }

    self.baseaccuracy = initialvalue * level.coop_enemy_accuracy_scalar;
    wait(randomfloatrange(3, 5));
  }
}

coop_allies_accuracy_scaler() {
  self endon("death");
  initialvalue = self.baseaccuracy;

  while(get_players().size > 1) {
    if(!isDefined(level.coop_friendly_accuracy_scalar)) {
      wait 0.5;
      continue;
    }

    self.baseaccuracy = initialvalue * level.coop_friendly_accuracy_scalar;
    wait(randomfloatrange(3, 5));
  }
}

coop_player_threat_bias_adjuster() {
  while(true) {
    wait 5;

    if(level.auto_adjust_threatbias) {
      players = get_players("allies");

      for(i = 0; i < players.size; i++)
        enable_auto_adjust_threatbias(players[i]);
    }
  }
}

toggle_health_overlay(b_indicator_active) {
  if(!isDefined(b_indicator_active))
    b_indicator_active = 1;

  if(b_indicator_active) {
    setdvar("scr_damagefeedback", "1");
    level.disable_damage_overlay = undefined;
  } else {
    setdvar("scr_damagefeedback", "0");
    self maps\_damagefeedback::updatedamagefeedback();
    level.disable_damage_overlay = 1;
  }
}