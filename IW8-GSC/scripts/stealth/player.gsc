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
  var0 = self getstance();

  if(scripts\stealth\utility::group_spotted_flag()) {
    var1 = "spotted";
  } else {
    var1 = "hidden";
  }

  var2 = level.stealth.detect.range[var1][var1];
  var3 = 0;

  if(scripts\engine\utility::ent_flag("stealth_in_shadow")) {
    var2 *= level.stealth.detect.range[var1]["shadow"];
    var3 = 1;
  } else if(scripts\engine\utility::ent_flag("stealth_use_real_lighting")) {
    var2 *= self getplayerlightlevel();
    var3 = 1;
  }

  if(var3) {
    var2 = max(var2, level.stealth.detect.minrangedarkness[var1][var1]);
  }

  return var2;
}

function combatstate_thread(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(!var0) {
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
    self waittill("player_combat_state_updated", var0, var1);

    foreach(var3 in self.stealth.combatstate.updatefuncs) {
      self thread[[var3]](var0, var1);
    }
  }
}

function combatstate_addupdatefunc(var0, var1) {
  self.stealth.combatstate.updatefuncs[var0] = var1;
}

function combatstate_removeupdatefunc(var0) {
  self.stealth.combatstate.updatefuncs = scripts\engine\utility::array_remove_key(self.stealth.combatstate.updatefuncs, var0);
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
    level waittill("stealth_event", var0, var1);

    if(!isalive(var1)) {
      continue;
    }

    if(!scripts\engine\utility::is_equal(var0.entity, level.player)) {
      continue;
    }

    if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
      self.stealth.hints.causeofdeath = undefined;
      self.stealth.hints.investigators = [];
      continue;
    }

    if(scripts\stealth\utility::any_groups_in_combat()) {
      if(var0.type != "combat") {
        continue;
      }

      var2 = 0;

      foreach(var4 in getaiarray(var1.team)) {
        if(var4 == var1) {
          continue;
        }

        if(var4[[var4.fnisinstealthcombat]]()) {
          var2 = 1;
          break;
        }
      }

      if(var2) {
        continue;
      }
    }

    var6 = var0.typeorig;

    if(var6 == "gunshot" && !istrue(level.hassuppressedweapons)) {
      continue;
    }

    if((var6 == "sight" || var6 == "proximity") && self issprinting()) {
      var6 = "footstep_sprint";
    } else if(var6 == "proximity" && length2dsquared(level.player getvelocity()) > 11025) {
      var6 = "proximity_speed";
    } else if(var6 == "sight" && self getstance() == "stand") {
      var6 = "sight_standing";
    }

    if(!isDefined(self.stealth.hints.deathhints[var6])) {
      continue;
    }

    if(scripts\engine\utility::array_contains(self.stealth.hints.investigators, var1)) {
      continue;
    }

    GscBinSkip4(0x35, var1, var6);
  }
}

function stealthhints_aimonitor(var0, var1) {
  self endon("combat_started");
  self endon("stealth_enabled");
  self.stealth.hints.investigators[self.stealth.hints.investigators.size] = var0;

  if(var0[[var0.fnisinstealthhunt]]()) {
    var0 scripts\engine\utility::delaythread(10, &scripts\engine\utility::send_notify, "stealthHints_timeout");
    var0 scripts\engine\utility::ref_143a6("stealth_combat", "death", "stealthHints_timeout");
  } else if(var0[[var0.fnisinstealthinvestigate]]()) {
    var0 scripts\engine\utility::ref_143a6("stealth_idle", "stealth_combat", "death");
  }

  self.stealth.hints.investigators = scripts\engine\utility::array_remove(self.stealth.hints.investigators, var0);

  if(!isalive(var0) || !var0[[var0.fnisinstealthcombat]]()) {
    return;
  }

  self.stealth.hints.causeofdeath = var1;
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