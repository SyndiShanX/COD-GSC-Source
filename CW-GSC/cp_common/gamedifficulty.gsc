/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gamedifficulty.gsc
***********************************************/

#using scripts\core_common\ai\systems\weaponlist;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\ui\warning_message;
#namespace gamedifficulty;

function autoexec init() {
  level.gameskill = 1;
  level.var_3426461d = &get_player_xp_difficulty_multiplier;
}

function setskill(reset, skill_override) {
  if(!isDefined(level.script)) {
    level.script = util::get_map_name();
  }

  if(!is_true(reset)) {
    if(is_true(level.b_gameskillset)) {
      return;
    }

    thread playerhealthdebug();

    level.b_gameskillset = 1;
  }

  level thread update_skill_level(skill_override);
  level.auto_adjust_threatbias = 1;
  set_difficulty_from_locked_settings();
  level function_4ba867b();
}

function apply_difficulty_var_with_func(difficulty_func) {
  level.playerhealth_regularregendelay = get_player_health_regular_regen_delay();

  if(level.auto_adjust_threatbias) {
    thread apply_threat_bias_to_all_players(difficulty_func);
  }

  level.longregentime = get_long_regen_time();
  level.animation.misstimeconstant = get_miss_time_constant();
  level.animation.misstimedistancefactor = get_miss_time_distance_factor();
}

function apply_threat_bias_to_all_players(difficulty_func) {
  level flag::wait_till("all_players_connected");
  players = level.players;

  for(i = 0; i < players.size; i++) {
    players[i].threatbias = int(get_player_threat_bias());
  }
}

function set_difficulty_from_locked_settings() {
  apply_difficulty_var_with_func(&get_locked_difficulty_val);
}

function get_locked_difficulty_val(msg, ignored) {
  return level.difficultysettings[ignored][level.currentdifficulty];
}

function playerhealthdebug() {
  waittillframeend();

  while(true) {
    while(true) {
      if(getdvarint(#"scr_health_debug", 0)) {
        break;
      }

      wait 0.5;
    }

    thread printhealthdebug();

    while(true) {
      if(!getdvarint(#"scr_health_debug", 0)) {
        break;
      }

      wait 0.5;
    }

    level notify(#"stop_printing_grenade_timers");
    destroyhealthdebug();
  }
}

function printhealthdebug() {
  level notify(#"stop_printing_health_bars");
  level endon(#"stop_printing_health_bars");
  y = 40;
  level.healthbarhudelems = [];
  level.healthbarkeys[0] = "<dev string:x38>";
  level.healthbarkeys[1] = "<dev string:x42>";
  level.healthbarkeys[2] = "<dev string:x51>";

  if(!isDefined(level.playerinvultimeend)) {
    level.playerinvultimeend = 0;
  }

  if(!isDefined(level.var_30235742)) {
    level.var_30235742 = 0;
  }

  for(i = 0; i < level.healthbarkeys.size; i++) {
    key = level.healthbarkeys[i];
    textelem = newdebughudelem();
    textelem.x = 150;
    textelem.y = y;
    textelem.alignx = "<dev string:x60>";
    textelem.aligny = "<dev string:x68>";
    textelem.horzalign = "<dev string:x6f>";
    textelem.vertalign = "<dev string:x6f>";
    textelem settext(key);
    bgbar = newdebughudelem();
    bgbar.x = 150 + 79;
    bgbar.y = y + 1;
    bgbar.z = 1;
    bgbar.alignx = "<dev string:x60>";
    bgbar.aligny = "<dev string:x68>";
    bgbar.horzalign = "<dev string:x6f>";
    bgbar.vertalign = "<dev string:x6f>";
    bgbar.maxwidth = 3;
    bgbar setshader(#"white", bgbar.maxwidth, 10);
    bgbar.color = (0.5, 0.5, 0.5);
    bar = newdebughudelem();
    bar.x = 150 + 80;
    bar.y = y + 2;
    bar.alignx = "<dev string:x60>";
    bar.aligny = "<dev string:x68>";
    bar.horzalign = "<dev string:x6f>";
    bar.vertalign = "<dev string:x6f>";
    bar setshader(#"black", 1, 8);
    bar.sort = 1;
    textelem.bar = bar;
    textelem.bgbar = bgbar;
    textelem.key = key;
    y += 10;
    level.healthbarhudelems[key] = textelem;
  }

  level flag::wait_till("<dev string:x7d>");

  while(true) {
    waitframe(1);
    players = level.players;

    for(i = 0; i < level.healthbarkeys.size && players.size > 0; i++) {
      key = level.healthbarkeys[i];
      player = players[0];
      width = 0;

      if(i == 0) {
        width = player.health / player.maxhealth * 300;
        level.healthbarhudelems[key] settext(level.healthbarkeys[0] + "<dev string:x94>" + player.health);
      } else if(i == 1) {
        width = (level.playerinvultimeend - gettime()) / 1000 * 40;
      } else if(i == 2) {
        width = (level.var_30235742 - gettime()) / 1000 * 40;
      }

      width = int(max(width, 1));
      width = int(min(width, 300));
      bar = level.healthbarhudelems[key].bar;
      bar setshader(#"black", width, 8);
      bgbar = level.healthbarhudelems[key].bgbar;

      if(width + 2 > bgbar.maxwidth) {
        bgbar.maxwidth = width + 2;
        bgbar setshader(#"white", bgbar.maxwidth, 10);
        bgbar.color = (0.5, 0.5, 0.5);
      }
    }
  }
}

function destroyhealthdebug() {
  level notify(#"stop_printing_health_bars");

  if(!isDefined(level.healthbarhudelems)) {
    return;
  }

  for(i = 0; i < level.healthbarkeys.size; i++) {
    level.healthbarhudelems[level.healthbarkeys[i]].bgbar destroy();
    level.healthbarhudelems[level.healthbarkeys[i]].bar destroy();
    level.healthbarhudelems[level.healthbarkeys[i]] destroy();
  }
}

function playerhurtcheck() {
  self notify("54802cc95ae5ac77");
  self endon("54802cc95ae5ac77");
  self endon(#"death");

  for(;;) {
    waitresult = self waittill(#"damage");

    if(isDefined(waitresult.attacker) && isPlayer(waitresult.attacker) && !is_true(isbot(waitresult.attacker))) {
      continue;
    }

    self.damagepoint = waitresult.position;
    self.damageattacker = waitresult.attacker;

    if(isDefined(waitresult.mod) && waitresult.mod == "MOD_BURNED") {
      self setburn(0.5);
      self playSound(#"chr_burn");
    }

    level notify(#"hit_again");
  }
}

function function_2339ca92() {
  player_death_invulnerability_time = get_player_death_invulnerable_time();

  if(player_death_invulnerability_time > 0) {
    self thread playerinvul(player_death_invulnerability_time);
  }

  level.playerinvultimeend = gettime() + player_death_invulnerability_time * 1000;
}

function private playerinvul(timer) {
  self endon(#"death", #"disconnect");

  if(self flag::get("player_is_invulnerable")) {
    return;
  }

  self flag::set("player_is_invulnerable");
  level notify(#"player_becoming_invulnerable");
  var_ae0703af = self getnoncheckpointdata("DeathsDoorWarnings");
  var_5273c86b = self getnoncheckpointdata("DeathsDoorWarningTime");

  if((isDefined(var_ae0703af) ? var_ae0703af : 0) > 0 && getrealtime() >= (isDefined(var_5273c86b) ? var_5273c86b : 0) && !self flag::get("no_deaths_door_warning") && !isgodmode(self)) {
    self setnoncheckpointdata("DeathsDoorWarnings", var_ae0703af - 1);
    self setnoncheckpointdata("DeathsDoorWarningTime", getrealtime() + 60000);
    self thread warning_message::create(#"hash_1b8a733f0d461a2c", [#"hash_2b62b2990144ebf6", #"healing", "no_deaths_door_warning"], 1, ["death", "in_igc"]);
  }

  self thread monitor_player_death_invulnerability_eligibility();

  if(timer > 0) {
    function_fef4c10f(timer, 1);
  }

  self flag::clear("player_is_invulnerable");
}

function function_fef4c10f(timer, var_19c9196 = 0) {
  if(var_19c9196) {
    self notify(#"hash_61ab322c075ab540");
  } else if(self flag::get("player_zero_attacker_accuracy")) {
    return;
  }

  self endon(#"hash_61ab322c075ab540", #"death");

  if(!isDefined(self.oldattackeraccuracy)) {
    self.oldattackeraccuracy = self.attackeraccuracy;
  } else {
    assert(self.attackeraccuracy == 0, "<dev string:x99>");
  }

  self function_f5c273fc();
  wait timer;
  self function_b9d6a17c();
}

function private function_f5c273fc() {
  self flag::set("player_zero_attacker_accuracy");
  self.attackeraccuracy = 0;
}

function private function_b9d6a17c() {
  self flag::clear("player_zero_attacker_accuracy");
  assert(isDefined(self.oldattackeraccuracy), "<dev string:xe0>");
  assert(self.oldattackeraccuracy != 0, "<dev string:x127>");
  self.attackeraccuracy = self.oldattackeraccuracy;
  self.oldattackeraccuracy = undefined;
}

function private monitor_player_death_invulnerability_eligibility() {
  self endon(#"death");
  self.eligible_for_death_invulnerability = 0;
  assert(self flag::get("<dev string:x173>"));
  self flag::wait_till_clear("player_is_invulnerable");
  cooldowntime = function_81e40993();

  level.var_30235742 = gettime() + cooldowntime * 1000;

  wait cooldowntime;
  self.eligible_for_death_invulnerability = 1;
}

function update_skill_level(skill_override) {
  level notify(#"update_skill_from_profile");
  level endon(#"update_skill_from_profile");
  transient = savegame::get_mission_data(#"transient");

  if(!isDefined(transient.gameskilllowest)) {
    transient.gameskilllowest = 9999;
  }

  if(!isDefined(transient.gameskillhighest)) {
    transient.gameskillhighest = 0;
  }

  n_last_gameskill = -1;

  while(!isDefined(skill_override)) {
    level.gameskill = getlocalprofileint("g_gameskill");

    var_89694459 = getdvarstring(#"overridedifficulty", "<dev string:x18d>");

    switch (tolower(var_89694459)) {
      case #"recruit":
        level.gameskill = 0;
        break;
      case #"regular":
        level.gameskill = 1;
        break;
      case #"hardened":
        level.gameskill = 2;
        break;
      case #"veteran":
        level.gameskill = 3;
        break;
      case #"realistic":
        level.gameskill = 4;
        break;
    }

    if(level.gameskill != n_last_gameskill) {
      if(!isDefined(level.gameskill)) {
        level.gameskill = 1;
      }

      switch (level.gameskill) {
        case 0:
          setDvar(#"currentdifficulty", "recruit");
          level.currentdifficulty = "recruit";
          break;
        case 1:
          setDvar(#"currentdifficulty", "regular");
          level.currentdifficulty = "regular";
          break;
        case 2:
          setDvar(#"currentdifficulty", "hardened");
          level.currentdifficulty = "hardened";
          break;
        case 3:
          setDvar(#"currentdifficulty", "veteran");
          level.currentdifficulty = "veteran";
          break;
        case 4:
          setDvar(#"currentdifficulty", "realistic");
          level.currentdifficulty = "realistic";
          break;
      }

      println("<dev string:x191>" + level.gameskill);
      setDvar(#"saved_gameskill", level.gameskill);
      setlocalprofilevar("g_gameskill", level.gameskill);

      if(level.gameskill < transient.gameskilllowest) {
        transient.gameskilllowest = level.gameskill;
      }

      if(level.gameskill > transient.gameskillhighest) {
        transient.gameskillhighest = level.gameskill;
      }

      level flag::wait_till("all_players_connected");

      foreach(player in getPlayers()) {
        player clientfield::set_player_uimodel("hudItems.serverDifficulty", level.gameskill);
        player stats::set_stat(#"currentdifficulty", level.gameskill);
        uploadstats(player);
        var_ae0703af = player getnoncheckpointdata("DeathsDoorWarnings");

        if(!isDefined(var_ae0703af) || n_last_gameskill == -1) {
          player setnoncheckpointdata("DeathsDoorWarnings", 4 - level.gameskill);
          continue;
        }

        player setnoncheckpointdata("DeathsDoorWarnings", int(max(0, 4 - level.gameskill - 4 - n_last_gameskill - var_ae0703af)));
      }

      n_last_gameskill = level.gameskill;
    }

    wait 1;
  }
}

function setdiffstructarrays() {
  if(!isDefined(level.s_game_difficulty)) {
    level.s_game_difficulty = [];
    level.s_game_difficulty[0] = getscriptbundle(#"gamedifficulty_recruit");
    level.s_game_difficulty[1] = getscriptbundle(#"gamedifficulty_regular");
    level.s_game_difficulty[2] = getscriptbundle(#"gamedifficulty_hardened");
    level.s_game_difficulty[3] = getscriptbundle(#"gamedifficulty_veteran");
    level.s_game_difficulty[4] = getscriptbundle(#"gamedifficulty_realistic");
  }
}

function get_player_threat_bias() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].threatbias;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 0;
}

function get_player_xp_difficulty_multiplier(event) {
  setdiffstructarrays();
  diff_xp_mult = level.s_game_difficulty[level.gameskill].difficulty_xp_multiplier;

  if(isDefined(diff_xp_mult)) {
    return diff_xp_mult;
  }

  return 1;
}

function get_health_overlay_cutoff() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].healthoverlaycutoff;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 0;
}

function get_enemy_pain_chance() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].enemypainchance;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 0;
}

function get_player_death_invulnerable_time() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].player_deathinvulnerabletime;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 0;
}

function function_81e40993() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].var_40865ff8;
  return isDefined(diff_struct_value) ? diff_struct_value : 0;
}

function get_base_enemy_accuracy() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].base_enemy_accuracy;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 0;
}

function get_player_difficulty_health() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].playerdifficultyhealth;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 100;
}

function get_miss_time_constant() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].misstimeconstant;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 0;
}

function get_miss_time_reset_delay() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].misstimeresetdelay;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 0;
}

function get_miss_time_distance_factor() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].misstimedistancefactor;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 0;
}

function get_dog_health() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].dog_health;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 0;
}

function get_dog_press_time() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].dog_presstime;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 0;
}

function get_dog_hits_before_kill() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].dog_hits_before_kill;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 0;
}

function get_long_regen_time() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].longregentime;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 0;
}

function get_player_health_regular_regen_delay() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].playerhealth_regularregendelay;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 0;
}

function get_worthy_damage_ratio() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].worthydamageratio;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 0;
}

function function_b5b7d60e() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].var_b768020b;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 2;
}

function function_5151f9d0() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].var_5657206f;

  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }

  return 4.5;
}

function function_52f56aea(var_d020b056) {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].var_bb4e24d2;

  if(isDefined(diff_struct_value)) {
    misstime = diff_struct_value;
  } else {
    misstime = 0.3;
  }

  scalar = 1;

  if(var_d020b056 === "fullauto") {
    scalar = 0.5;
  } else if(var_d020b056 === "singleshot") {
    scalar = 1.5;
  }

  return misstime * scalar;
}

function get_general_difficulty_level() {
  value = level.gameskill + level.players.size - 1;

  if(value < 0) {
    value = 0;
  }

  return value;
}

function player_eligible_for_death_invulnerability() {
  player = self;

  if(get_player_death_invulnerable_time() == 0) {
    return 0;
  }

  return is_true(self.eligible_for_death_invulnerability);
}

function adjust_melee_damage(player, eattacker, einflictor, idamage, weapon, shitloc, smeansofdamage) {
  if((smeansofdamage == "MOD_MELEE" || smeansofdamage == "MOD_MELEE_WEAPON_BUTT") && isentity(weapon) && !isPlayer(weapon)) {
    if(isactor(weapon)) {
      var_c86b4d97 = int(get_player_difficulty_health() * 0.8);
      return var_c86b4d97;
    }
  }

  return shitloc;
}

function function_23dcd1f6(player, eattacker, einflictor, idamage, weapon, shitloc, smeansofdamage) {
  var_68bc2059 = float(get_player_difficulty_health());
  assert(var_68bc2059 > 0);
  var_86342214 = float(100) / var_68bc2059;
  return max(smeansofdamage * var_86342214, min(1, smeansofdamage));
}

function function_4ba867b() {
  setdiffstructarrays();
  var_938ce325 = level.s_game_difficulty[level.gameskill].player_laststandbleedouttime;
  var_4cfdf1fc = level.s_game_difficulty[level.gameskill].var_949c9924;
  var_22e7a516 = level.s_game_difficulty[level.gameskill].player_laststandsuicidedelay;
  var_33682ca0 = level.s_game_difficulty[level.gameskill].var_58500288;
  var_fd9d63a8 = level.s_game_difficulty[level.gameskill].player_respawndelay;
  var_dd639ef7 = level.s_game_difficulty[level.gameskill].var_1bc10f3a;
  var_8c4f976a = level.s_game_difficulty[level.gameskill].var_c5c20d41;
  var_88dcf868 = level.s_game_difficulty[level.gameskill].var_4ca741c2;
  var_8f59489c = level.s_game_difficulty[level.gameskill].var_e3e8d3a1;
  var_880dfe56 = level.s_game_difficulty[level.gameskill].var_7b55ea2b;
  setDvar(#"player_laststandbleedouttime", var_938ce325);
  setDvar(#"player_laststandrevivehealth", var_4cfdf1fc);
  setDvar(#"player_laststandsuicidedelay", var_22e7a516);
  setDvar(#"hash_6e3f1e26256fe0b5", var_33682ca0);
  setDvar(#"player_respawndelay", var_fd9d63a8);
  level.var_a4107aed = var_fd9d63a8;
  level.var_cf393bff = var_dd639ef7;
  level.var_a164210a = var_8c4f976a;
  level.var_a6a26da0 = var_88dcf868;
  level.var_1cac200a = var_8f59489c;
  level.var_22895486 = var_880dfe56;
}