/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\stealth\player.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\stealth\debug;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\util_shared;
#namespace player;

function scalevolume(ent, vol) {}

#namespace stealth_player;

function main() {
  if(isDefined(self.stealth)) {
    return;
  }

  self endon(#"death");
  self endon(#"stealth_disabled");
  self.stealth = spawnStruct();
  self.stealth.var_103386e8 = self namespace_979752dc::group_flag_init("stealth_spotted");
  self flag::init("stealth_enabled");
  self flag::set("stealth_enabled");
  self flag::init("stealth_use_real_lighting");
  self flag::set("stealth_use_real_lighting");
  self.stealth.spotted_list = [];
  self namespace_979752dc::group_add();
  self thread maxvisibility_thread();

  if(sessionmodeiscampaigngame()) {
    self thread stealthhints_thread();
  }

  self childthread stealth_debug::debug_player();
}

function maxvisibility_thread() {
  self endon(#"death");
  self endon(#"disconnect");

  while(true) {
    if(self maxvisibility_shouldupdate()) {
      self.maxvisibledist = self get_detect_range();
    }

    waitframe(1);
  }
}

function maxvisibility_shouldupdate() {
  if(is_true(self.maxvisibiltyupdate_disabled)) {
    return false;
  }

  if(!self flag::get("stealth_enabled")) {
    return false;
  }

  if(self flag::get("stealth_in_shadow")) {
    return true;
  }

  if(isDefined(self.lightmeterdelay) && gettime() < self.lightmeterdelay) {
    return false;
  }

  return true;
}

function get_detect_range() {
  stance = self getstance();

  if(self namespace_979752dc::group_spotted_flag()) {
    detection = "spotted";
  } else {
    detection = "hidden";
  }

  range = level.stealth.detect.range[detection][stance];

  if(self flag::get("stealth_in_shadow")) {
    range *= level.stealth.detect.range[detection][# "shadow"];
    range = max(range, level.stealth.detect.minrangedarkness[detection][stance]);
  }

  if(isDefined(self.stealth.var_f6c2537d) && self.stealth.var_f6c2537d.size > 0) {
    range = max(range, isDefined(self.var_1c936867) ? self.var_1c936867 : 850);
  }

  return range;
}

function combatstate_thread(enabled = 1) {
  if(!enabled) {
    self notify(#"hash_4330b0368e7f1373");
    self.stealth.combatstate = undefined;
    return;
  } else if(isDefined(self.stealth.combatstate)) {
    return;
  }

  self endon(#"death");
  self endon(#"stealth_disabled");
  self endon(#"hash_4330b0368e7f1373");
  self endon(#"disconnect");
  self childthread playerattackedmonitor();
  self childthread combatstate_updatethread();
  self.stealth.combatstate = spawnStruct();
  self.stealth.combatstate.name = "stealth";
  self.stealth.combatstate.type = "idle";
  self.stealth.combatstate.updatefuncs = [];
  var_e8c14f37 = [];
  var_41b7c5cb = [];

  while(true) {
    self flag::wait_till("stealth_enabled");
    arrayremovevalue(var_e8c14f37, undefined);
    function_1eaaceab(var_e8c14f37);
    arrayremovevalue(var_41b7c5cb, undefined);
    function_1eaaceab(var_41b7c5cb);
    combatenemies = [];
    huntenemies = [];
    var_a01740d6 = 0;

    if(isDefined(self.lastattackedtime) && !util::time_has_passed(self.lastattackedtime, 10)) {
      var_a01740d6 = 1;
    }

    foreach(enemy in getactorteamarray("axis")) {
      if(!isalive(enemy)) {
        continue;
      }

      if(!array::contains(var_e8c14f37, enemy)) {
        if(!isalive(enemy)) {
          continue;
        }

        if(enemy.script === "pain") {
          continue;
        }
      }

      if(!isDefined(enemy.fnisinstealthcombat) || enemy[[enemy.fnisinstealthcombat]]()) {
        if(isDefined(self.stealth.combatstate.maxcombatdist)) {
          dist = self.stealth.combatstate.maxcombatdist;

          if(distancesquared(self.origin, enemy.origin) > sqr(dist)) {
            huntenemies[huntenemies.size] = enemy;
            continue;
          }
        }

        combatenemies[combatenemies.size] = enemy;

        if(var_a01740d6) {
          continue;
        }

        if(enemy.enemy !== self) {
          continue;
        }

        if(enemy cansee(self)) {
          var_a01740d6 = 1;
        }

        continue;
      }

      if(enemy[[enemy.fnisinstealthhunt]]()) {
        huntenemies[huntenemies.size] = enemy;
      }
    }

    lastname = self.stealth.combatstate.name;
    lasttype = self.stealth.combatstate.type;
    name = lastname;
    type = undefined;

    if(lastname == "combat") {
      if(combatenemies.size == 0) {
        name = "stealth";

        if(arrayintersect(var_e8c14f37, huntenemies).size > 0) {
          type = "hunt";
        } else if(huntenemies.size == 0) {
          type = "all_clear";
        } else {
          type = "combat_clear";
        }
      } else if(lasttype === "unaware" && var_a01740d6) {
        type = "aware";
      }
    } else if(combatenemies.size > 0) {
      name = "combat";

      if(var_a01740d6) {
        type = "aware";
      } else {
        type = "unaware";
      }
    } else if(lasttype === "hunt" && huntenemies.size == 0) {
      type = "all_clear";
    }

    if(name != lastname || isDefined(type) && type !== lasttype) {
      self.stealth.combatstate.name = name;
      self.stealth.combatstate.type = type;
      self notify(#"hash_ec8c1a398bebc57", {
        #name: name, #type: type
      });
    }

    var_e8c14f37 = combatenemies;
    var_41b7c5cb = huntenemies;
    waitframe(1);
  }
}

function combatstate_updatethread() {
  while(true) {
    result = self waittill(#"hash_ec8c1a398bebc57");

    foreach(func in self.stealth.combatstate.updatefuncs) {
      self thread[[func]](result.name, result.type);
    }
  }
}

function combatstate_addupdatefunc(key, func) {
  assert(isPlayer(self));
  assert(isDefined(self.stealth));
  assert(isDefined(self.stealth.combatstate));
  assert(isDefined(key), "<dev string:x38>");
  assert(!isDefined(self.stealth.combatstate.updatefuncs[key]), "<dev string:x65>" + key + "<dev string:x89>");
  self.stealth.combatstate.updatefuncs[key] = func;
}

function combatstate_removeupdatefunc(key) {
  assert(isPlayer(self));
  assert(isDefined(self.stealth));
  assert(isDefined(self.stealth.combatstate));
  assert(isDefined(key), "<dev string:x38>");
  assert(isDefined(self.stealth.combatstate.updatefuncs[key]), "<dev string:x65>" + key + "<dev string:x9d>");
  self.stealth.combatstate.updatefuncs[key] = undefined;
}

function playerattackedmonitor() {
  while(true) {
    level waittill(#"hash_58d740afedebc182", #"hash_58419cfa256da59b");
    self.lastattackedtime = gettime();
  }
}

function stealthhints_thread() {
  self endon(#"stealth_disabled");
  self.stealth.hints = spawnStruct();
  self.stealth.hints.causeofdeath = undefined;
  self.stealth.hints.investigators = [];
  self.stealth.hints.deathhints[# "footstep_sprint"] = 6;
  self.stealth.hints.deathhints[# "gunshot"] = 8;
  self.stealth.hints.deathhints[# "proximity_speed"] = 16;
  self.stealth.hints.deathhints[# "sight_standing"] = 19;
  self childthread stealthhints_eventmonitor();
  self childthread stealthhints_deathmonitor();
  self childthread stealthhints_combatmonitor();
}

function stealthhints_eventmonitor() {
  self endon(#"death");

  while(true) {
    self flag::wait_till("stealth_enabled");
    wait_result = level waittill(#"stealth_event");
    event = wait_result.event;
    receiver = wait_result.receiver;

    if(!isalive(receiver)) {
      continue;
    }

    if(event.entity !== getplayers()[0]) {
      continue;
    }

    if(!self flag::get("stealth_enabled")) {
      self.stealth.hints.causeofdeath = undefined;
      self.stealth.hints.investigators = [];
      continue;
    }

    if(namespace_979752dc::any_groups_in_combat()) {
      if(event.type != "combat") {
        continue;
      }

      var_f2013641 = 0;

      foreach(guy in getactorteamarray(receiver.team)) {
        if(guy == receiver) {
          continue;
        }

        if(!isDefined(guy.fnisinstealthcombat) || guy[[guy.fnisinstealthcombat]]()) {
          var_f2013641 = 1;
          break;
        }
      }

      if(var_f2013641) {
        continue;
      }
    }

    eventtype = event.typeorig;

    if(eventtype == "gunshot" && !is_true(level.hassuppressedweapons)) {
      continue;
    }

    if((eventtype == "sight" || eventtype == "proximity") && self issprinting()) {
      eventtype = "footstep_sprint";
    } else if(eventtype == "proximity" && lengthsquared((getplayers()[0] getvelocity()[0], getplayers()[0] getvelocity()[1], 0)) > 11025) {
      eventtype = "proximity_speed";
    } else if(eventtype == "sight" && self getstance() == "stand") {
      eventtype = "sight_standing";
    }

    if(!isDefined(self.stealth.hints.deathhints[eventtype])) {
      continue;
    }

    if(array::contains(self.stealth.hints.investigators, receiver)) {
      continue;
    }

    self childthread stealthhints_aimonitor(receiver, eventtype);
  }
}

function stealthhints_aimonitor(ai, eventtype) {
  self endon(#"combat_started");
  self endon(#"stealth_enabled");
  self.stealth.hints.investigators[self.stealth.hints.investigators.size] = ai;

  if(ai[[ai.fnisinstealthhunt]]()) {
    ai util::delay(10, array("combat_started", "stealth_enabled"), &util::send_notify, "stealthHints_timeout");
    ai waittill(#"stealth_combat", #"death", #"stealthhints_timeout");
  } else if(ai[[ai.fnisinstealthinvestigate]]()) {
    ai waittill(#"stealth_idle", #"stealth_combat", #"death");
  }

  arrayremovevalue(self.stealth.hints.investigators, ai);

  if(!isalive(ai) || isDefined(ai.fnisinstealthcombat) && !ai[[ai.fnisinstealthcombat]]()) {
    return;
  }

  self.stealth.hints.causeofdeath = eventtype;
  self.stealth.hints.investigators = [];
  self notify(#"combat_started");
}

function stealthhints_deathmonitor() {
  self waittill(#"death");

  if(!self flag::get("stealth_enabled")) {
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
  self endon(#"death");

  while(true) {
    self flag::wait_till("stealth_enabled");

    while(!isDefined(self.stealth.hints.causeofdeath)) {
      waitframe(1);
    }

    while(namespace_979752dc::any_groups_in_combat()) {
      waitframe(1);
    }

    self.stealth.hints.causeofdeath = undefined;
  }
}