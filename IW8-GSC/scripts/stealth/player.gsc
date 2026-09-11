/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\player.gsc
***********************************************/

function main() {
  if(isDefined(self.stealth)) {
    return;
  }

  self endon("death");
  self endon("stealth_disabled");
  self.stealth = spawnStruct();
  scripts\stealth\utility::group_flag_init("stealth_spotted");
  scripts\engine\utility::ent_flag_init("stealth_enabled");
  scripts\engine\utility::ent_flag_set("stealth_enabled");
  scripts\engine\utility::ent_flag_init("stealth_in_shadow");
  scripts\engine\utility::ent_flag_init("stealth_use_real_lighting");
  scripts\engine\utility::ent_flag_set("stealth_use_real_lighting");
  self.stealth.spotted_list = [];
  scripts\stealth\utility::group_add();
  thread maxvisibility_thread();

  if(scripts\common\utility::issp()) {
    thread stealthhints_thread();
    return;
  }
}

function maxvisibility_thread() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    if(maxvisibility_shouldupdate()) {
      self.maxvisibledist = get_detect_range();
    }

    waitframe();
  }
}

function maxvisibility_shouldupdate() {
  if(istrue(self.maxvisibiltyupdate_disabled)) {
    return false;
  }

  if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
    return false;
  }

  if(scripts\engine\utility::ent_flag("stealth_in_shadow")) {
    return true;
  }

  if(isDefined(self.lightmeterdelay) && gettime() < self.lightmeterdelay) {
    return false;
  }

  return true;
}

function get_detect_range() {
  var_0 = self getstance();

  if(scripts\stealth\utility::group_spotted_flag()) {
    var_1 = "spotted";
  } else {
    var_1 = "hidden";
  }

  var_2 = level.stealth.detect.range[var_1][var_1];
  var_3 = 0;

  if(scripts\engine\utility::ent_flag("stealth_in_shadow")) {
    var_2 *= level.stealth.detect.range[var_1]["shadow"];
    var_3 = 1;
  } else if(scripts\engine\utility::ent_flag("stealth_use_real_lighting")) {
    var_2 *= self getplayerlightlevel();
    var_3 = 1;
  }

  if(var_3) {
    var_2 = max(var_2, level.stealth.detect.minrangedarkness[var_1][var_1]);
  }

  return var_2;
}

function combatstate_thread(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!var_0) {
    self notify("stop_player_combat_state_thread");
    self.stealth.combatstate = undefined;
    return;
  } else if(isDefined(self.stealth.combatstate)) {
    return;
  }

  self endon("death");
  self endon("stealth_disabled");
  self endon("stop_player_combat_state_thread");
  self endon("disconnect");
  GscBinSkip4(0x35);
}

function combatstate_updatethread() {
  for(;;) {
    self waittill("player_combat_state_updated", var_0, var_1);

    foreach(var_3 in self.stealth.combatstate.updatefuncs) {
      self thread[[var_3]](var_0, var_1);
    }
  }
}

function combatstate_addupdatefunc(var_0, var_1) {
  self.stealth.combatstate.updatefuncs[var_0] = var_1;
}

function combatstate_removeupdatefunc(var_0) {
  self.stealth.combatstate.updatefuncs = scripts\engine\utility::array_remove_key(self.stealth.combatstate.updatefuncs, var_0);
}

function playerattackedmonitor() {
  for(;;) {
    level scripts\engine\utility::ref_143a5("an_enemy_shot", "enemy_grenade_fire");
    self.lastattackedtime = gettime();
  }
}

function stealthhints_thread() {
  self endon("stealth_disabled");
  self.stealth.hints = spawnStruct();
  self.stealth.hints.causeofdeath = undefined;
  self.stealth.hints.investigators = [];
  self.stealth.hints.deathhints["footstep_sprint"] = 6;
  self.stealth.hints.deathhints["gunshot"] = 8;
  self.stealth.hints.deathhints["proximity_speed"] = 16;
  self.stealth.hints.deathhints["sight_standing"] = 19;
  GscBinSkip4(0x35);
}

function stealthhints_eventmonitor() {
  self endon("death");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("stealth_enabled");
    level waittill("stealth_event", var_0, var_1);

    if(!isalive(var_1)) {
      continue;
    }

    if(!scripts\engine\utility::is_equal(var_0.entity, level.player)) {
      continue;
    }

    if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
      self.stealth.hints.causeofdeath = undefined;
      self.stealth.hints.investigators = [];
      continue;
    }

    if(scripts\stealth\utility::any_groups_in_combat()) {
      if(var_0.type != "combat") {
        continue;
      }

      var_2 = 0;

      foreach(var_4 in getaiarray(var_1.team)) {
        if(var_4 == var_1) {
          continue;
        }

        if(var_4[[var_4.fnisinstealthcombat]]()) {
          var_2 = 1;
          break;
        }
      }

      if(var_2) {
        continue;
      }
    }

    var_6 = var_0.typeorig;

    if(var_6 == "gunshot" && !istrue(level.hassuppressedweapons)) {
      continue;
    }

    if((var_6 == "sight" || var_6 == "proximity") && self issprinting()) {
      var_6 = "footstep_sprint";
    } else if(var_6 == "proximity" && length2dsquared(level.player getvelocity()) > 11025) {
      var_6 = "proximity_speed";
    } else if(var_6 == "sight" && self getstance() == "stand") {
      var_6 = "sight_standing";
    }

    if(!isDefined(self.stealth.hints.deathhints[var_6])) {
      continue;
    }

    if(scripts\engine\utility::array_contains(self.stealth.hints.investigators, var_1)) {
      continue;
    }

    GscBinSkip4(0x35, var_1, var_6);
  }
}

function stealthhints_aimonitor(var_0, var_1) {
  self endon("combat_started");
  self endon("stealth_enabled");
  self.stealth.hints.investigators[self.stealth.hints.investigators.size] = var_0;

  if(var_0[[var_0.fnisinstealthhunt]]()) {
    var_0 scripts\engine\utility::delaythread(10, &scripts\engine\utility::send_notify, "stealthHints_timeout");
    var_0 scripts\engine\utility::ref_143a6("stealth_combat", "death", "stealthHints_timeout");
  } else if(var_0[[var_0.fnisinstealthinvestigate]]()) {
    var_0 scripts\engine\utility::ref_143a6("stealth_idle", "stealth_combat", "death");
  }

  self.stealth.hints.investigators = scripts\engine\utility::array_remove(self.stealth.hints.investigators, var_0);

  if(!isalive(var_0) || !var_0[[var_0.fnisinstealthcombat]]()) {
    return;
  }

  self.stealth.hints.causeofdeath = var_1;
  self.stealth.hints.investigators = [];
  self notify("combat_started");
}

function stealthhints_deathmonitor() {
  self waittill("death");

  if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
    return;
  }

  if(isDefined(level.custom_death_quote)) {
    return;
  }

  if(!isDefined(self.stealth.hints.causeofdeath)) {
    return;
  }

  level.custom_death_quote = self.stealth.hints.deathhints[self.stealth.hints.causeofdeath];
}

function stealthhints_combatmonitor() {
  self endon("death");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("stealth_enabled");

    while(!isDefined(self.stealth.hints.causeofdeath)) {
      waitframe();
    }

    while(scripts\stealth\utility::any_groups_in_combat()) {
      waitframe();
    }

    self.stealth.hints.causeofdeath = undefined;
  }
}