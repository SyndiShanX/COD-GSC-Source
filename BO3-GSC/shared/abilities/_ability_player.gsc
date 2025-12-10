/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\_ability_player.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_gadgets;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\abilities\gadgets\_gadget_active_camo;
#using scripts\shared\abilities\gadgets\_gadget_armor;
#using scripts\shared\abilities\gadgets\_gadget_cacophany;
#using scripts\shared\abilities\gadgets\_gadget_camo;
#using scripts\shared\abilities\gadgets\_gadget_cleanse;
#using scripts\shared\abilities\gadgets\_gadget_clone;
#using scripts\shared\abilities\gadgets\_gadget_combat_efficiency;
#using scripts\shared\abilities\gadgets\_gadget_concussive_wave;
#using scripts\shared\abilities\gadgets\_gadget_es_strike;
#using scripts\shared\abilities\gadgets\_gadget_exo_breakdown;
#using scripts\shared\abilities\gadgets\_gadget_firefly_swarm;
#using scripts\shared\abilities\gadgets\_gadget_flashback;
#using scripts\shared\abilities\gadgets\_gadget_forced_malfunction;
#using scripts\shared\abilities\gadgets\_gadget_heat_wave;
#using scripts\shared\abilities\gadgets\_gadget_hero_weapon;
#using scripts\shared\abilities\gadgets\_gadget_iff_override;
#using scripts\shared\abilities\gadgets\_gadget_immolation;
#using scripts\shared\abilities\gadgets\_gadget_misdirection;
#using scripts\shared\abilities\gadgets\_gadget_mrpukey;
#using scripts\shared\abilities\gadgets\_gadget_other;
#using scripts\shared\abilities\gadgets\_gadget_overdrive;
#using scripts\shared\abilities\gadgets\_gadget_rapid_strike;
#using scripts\shared\abilities\gadgets\_gadget_ravage_core;
#using scripts\shared\abilities\gadgets\_gadget_resurrect;
#using scripts\shared\abilities\gadgets\_gadget_roulette;
#using scripts\shared\abilities\gadgets\_gadget_security_breach;
#using scripts\shared\abilities\gadgets\_gadget_sensory_overload;
#using scripts\shared\abilities\gadgets\_gadget_servo_shortout;
#using scripts\shared\abilities\gadgets\_gadget_shock_field;
#using scripts\shared\abilities\gadgets\_gadget_smokescreen;
#using scripts\shared\abilities\gadgets\_gadget_speed_burst;
#using scripts\shared\abilities\gadgets\_gadget_surge;
#using scripts\shared\abilities\gadgets\_gadget_system_overload;
#using scripts\shared\abilities\gadgets\_gadget_thief;
#using scripts\shared\abilities\gadgets\_gadget_unstoppable_force;
#using scripts\shared\abilities\gadgets\_gadget_vision_pulse;
#using scripts\shared\array_shared;
#using scripts\shared\bots\_bot;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\weapons\replay_gun;
#namespace ability_player;

function autoexec __init__sytem__() {
  system::register("ability_player", &__init__, undefined, undefined);
}

function __init__() {
  init_abilities();
  setup_clientfields();
  level thread gadgets_wait_for_game_end();
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  callback::on_disconnect(&on_player_disconnect);
  if(!isDefined(level._gadgets_level)) {
    level._gadgets_level = [];
  }
  level thread abilities_devgui_init();
}

function init_abilities() {}

function setup_clientfields() {}

function on_player_connect() {
  if(!isDefined(self._gadgets_player)) {
    self._gadgets_player = [];
  }
  self thread abilities_devgui_player_connect();
}

function on_player_spawned() {
  self thread gadgets_wait_for_death();
  self.heroabilityactivatetime = undefined;
  self.heroabilitydectivatetime = undefined;
  self.heroabilityactive = undefined;
}

function on_player_disconnect() {
  self thread abilities_devgui_player_disconnect();
}

function is_using_any_gadget() {
  if(!isplayer(self)) {
    return false;
  }
  for(i = 0; i < 3; i++) {
    if(self gadget_is_in_use(i)) {
      return true;
    }
  }
  return false;
}

function gadgets_save_power(game_ended) {
  for(slot = 0; slot < 3; slot++) {
    if(!isDefined(self._gadgets_player[slot])) {
      continue;
    }
    gadgetweapon = self._gadgets_player[slot];
    powerleft = self gadgetpowerchange(slot, 0);
    if(game_ended && gadget_is_in_use(slot)) {
      self gadgetdeactivate(slot, gadgetweapon);
      if(gadgetweapon.gadget_power_round_end_active_penalty > 0) {
        powerleft = powerleft - gadgetweapon.gadget_power_round_end_active_penalty;
        powerleft = max(0, powerleft);
      }
    }
    self.pers["held_gadgets_power"][gadgetweapon] = powerleft;
  }
}

function gadgets_wait_for_death() {
  self endon("disconnect");
  self.pers["held_gadgets_power"] = [];
  self waittill("death");
  if(!isDefined(self._gadgets_player)) {
    return;
  }
  self gadgets_save_power(0);
}

function gadgets_wait_for_game_end() {
  level waittill("game_ended");
  players = getplayers();
  foreach(player in players) {
    if(!isalive(player)) {
      continue;
    }
    if(!isDefined(player._gadgets_player)) {
      continue;
    }
    player gadgets_save_power(1);
  }
}

function script_set_cclass(cclass, save = 1) {}

function update_gadget(weapon) {}

function register_gadget(type) {
  if(!isDefined(level._gadgets_level)) {
    level._gadgets_level = [];
  }
  if(!isDefined(level._gadgets_level[type])) {
    level._gadgets_level[type] = spawnStruct();
    level._gadgets_level[type].should_notify = 1;
  }
}

function register_gadget_should_notify(type, should_notify) {
  register_gadget(type);
  if(isDefined(should_notify)) {
    level._gadgets_level[type].should_notify = should_notify;
  }
}

function register_gadget_possession_callbacks(type, on_give, on_take) {
  register_gadget(type);
  if(!isDefined(level._gadgets_level[type].on_give)) {
    level._gadgets_level[type].on_give = [];
  }
  if(!isDefined(level._gadgets_level[type].on_take)) {
    level._gadgets_level[type].on_take = [];
  }
  if(isDefined(on_give)) {
    if(!isDefined(level._gadgets_level[type].on_give)) {
      level._gadgets_level[type].on_give = [];
    } else if(!isarray(level._gadgets_level[type].on_give)) {
      level._gadgets_level[type].on_give = array(level._gadgets_level[type].on_give);
    }
    level._gadgets_level[type].on_give[level._gadgets_level[type].on_give.size] = on_give;
  }
  if(isDefined(on_take)) {
    if(!isDefined(level._gadgets_level[type].on_take)) {
      level._gadgets_level[type].on_take = [];
    } else if(!isarray(level._gadgets_level[type].on_take)) {
      level._gadgets_level[type].on_take = array(level._gadgets_level[type].on_take);
    }
    level._gadgets_level[type].on_take[level._gadgets_level[type].on_take.size] = on_take;
  }
}

function register_gadget_activation_callbacks(type, turn_on, turn_off) {
  register_gadget(type);
  if(!isDefined(level._gadgets_level[type].turn_on)) {
    level._gadgets_level[type].turn_on = [];
  }
  if(!isDefined(level._gadgets_level[type].turn_off)) {
    level._gadgets_level[type].turn_off = [];
  }
  if(isDefined(turn_on)) {
    if(!isDefined(level._gadgets_level[type].turn_on)) {
      level._gadgets_level[type].turn_on = [];
    } else if(!isarray(level._gadgets_level[type].turn_on)) {
      level._gadgets_level[type].turn_on = array(level._gadgets_level[type].turn_on);
    }
    level._gadgets_level[type].turn_on[level._gadgets_level[type].turn_on.size] = turn_on;
  }
  if(isDefined(turn_off)) {
    if(!isDefined(level._gadgets_level[type].turn_off)) {
      level._gadgets_level[type].turn_off = [];
    } else if(!isarray(level._gadgets_level[type].turn_off)) {
      level._gadgets_level[type].turn_off = array(level._gadgets_level[type].turn_off);
    }
    level._gadgets_level[type].turn_off[level._gadgets_level[type].turn_off.size] = turn_off;
  }
}

function register_gadget_flicker_callbacks(type, on_flicker) {
  register_gadget(type);
  if(!isDefined(level._gadgets_level[type].on_flicker)) {
    level._gadgets_level[type].on_flicker = [];
  }
  if(isDefined(on_flicker)) {
    if(!isDefined(level._gadgets_level[type].on_flicker)) {
      level._gadgets_level[type].on_flicker = [];
    } else if(!isarray(level._gadgets_level[type].on_flicker)) {
      level._gadgets_level[type].on_flicker = array(level._gadgets_level[type].on_flicker);
    }
    level._gadgets_level[type].on_flicker[level._gadgets_level[type].on_flicker.size] = on_flicker;
  }
}

function register_gadget_ready_callbacks(type, ready_func) {
  register_gadget(type);
  if(!isDefined(level._gadgets_level[type].on_ready)) {
    level._gadgets_level[type].on_ready = [];
  }
  if(isDefined(ready_func)) {
    if(!isDefined(level._gadgets_level[type].on_ready)) {
      level._gadgets_level[type].on_ready = [];
    } else if(!isarray(level._gadgets_level[type].on_ready)) {
      level._gadgets_level[type].on_ready = array(level._gadgets_level[type].on_ready);
    }
    level._gadgets_level[type].on_ready[level._gadgets_level[type].on_ready.size] = ready_func;
  }
}

function register_gadget_primed_callbacks(type, primed_func) {
  register_gadget(type);
  if(!isDefined(level._gadgets_level[type].on_primed)) {
    level._gadgets_level[type].on_primed = [];
  }
  if(isDefined(primed_func)) {
    if(!isDefined(level._gadgets_level[type].on_primed)) {
      level._gadgets_level[type].on_primed = [];
    } else if(!isarray(level._gadgets_level[type].on_primed)) {
      level._gadgets_level[type].on_primed = array(level._gadgets_level[type].on_primed);
    }
    level._gadgets_level[type].on_primed[level._gadgets_level[type].on_primed.size] = primed_func;
  }
}

function register_gadget_is_inuse_callbacks(type, inuse_func) {
  register_gadget(type);
  if(isDefined(inuse_func)) {
    level._gadgets_level[type].isinuse = inuse_func;
  }
}

function register_gadget_is_flickering_callbacks(type, flickering_func) {
  register_gadget(type);
  if(isDefined(flickering_func)) {
    level._gadgets_level[type].isflickering = flickering_func;
  }
}

function register_gadget_failed_activate_callback(type, failed_activate) {
  register_gadget(type);
  if(!isDefined(level._gadgets_level[type].failed_activate)) {
    level._gadgets_level[type].failed_activate = [];
  }
  if(isDefined(failed_activate)) {
    if(!isDefined(level._gadgets_level[type].failed_activate)) {
      level._gadgets_level[type].failed_activate = [];
    } else if(!isarray(level._gadgets_level[type].failed_activate)) {
      level._gadgets_level[type].failed_activate = array(level._gadgets_level[type].failed_activate);
    }
    level._gadgets_level[type].failed_activate[level._gadgets_level[type].failed_activate.size] = failed_activate;
  }
}

function gadget_is_in_use(slot) {
  if(isDefined(self._gadgets_player[slot])) {
    if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
      if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].isinuse)) {
        return self[[level._gadgets_level[self._gadgets_player[slot].gadget_type].isinuse]](slot);
      }
    }
  }
  return self gadgetisactive(slot);
}

function gadget_is_flickering(slot) {
  if(!isDefined(self._gadgets_player[slot])) {
    return 0;
  }
  if(!isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].isflickering)) {
    return 0;
  }
  return self[[level._gadgets_level[self._gadgets_player[slot].gadget_type].isflickering]](slot);
}

function give_gadget(slot, weapon) {
  if(isDefined(self._gadgets_player[slot])) {
    self take_gadget(slot, self._gadgets_player[slot]);
  }
  for(eslot = 0; eslot < 3; eslot++) {
    existinggadget = self._gadgets_player[eslot];
    if(isDefined(existinggadget) && existinggadget == weapon) {
      self take_gadget(eslot, existinggadget);
    }
  }
  self._gadgets_player[slot] = weapon;
  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }
  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_give)) {
      foreach(on_give in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_give) {
        self[[on_give]](slot, weapon);
      }
    }
  }
  if(sessionmodeismultiplayergame()) {
    self.heroabilityname = (isDefined(weapon) ? weapon.name : undefined);
  }
}

function take_gadget(slot, weapon) {
  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }
  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_take)) {
      foreach(on_take in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_take) {
        self[[on_take]](slot, weapon);
      }
    }
  }
  self._gadgets_player[slot] = undefined;
}

function turn_gadget_on(slot, weapon) {
  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }
  self.playedgadgetsuccess = 0;
  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_on)) {
      foreach(turn_on in level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_on) {
        self[[turn_on]](slot, weapon);
        self trackheropoweractivated(game["timepassed"]);
        level notify("hero_gadget_activated", self, weapon);
        self notify("hero_gadget_activated", weapon);
      }
    }
  }
  if(isDefined(level.cybercom) && isDefined(level.cybercom._ability_turn_on)) {
    self[[level.cybercom._ability_turn_on]](slot, weapon);
  }
  self.pers["heroGadgetNotified"] = 0;
  xuid = self getxuid();
  bbprint("mpheropowerevents", "spawnid %d gametime %d name %s powerstate %s playername %s xuid %s", getplayerspawnid(self), gettime(), self._gadgets_player[slot].name, "activated", self.name, xuid);
  if(isDefined(level.playgadgetactivate)) {
    self[[level.playgadgetactivate]](weapon);
  }
  if(weapon.gadget_type != 14) {
    if(isDefined(self.isneardeath) && self.isneardeath == 1) {
      if(isDefined(level.heroabilityactivateneardeath)) {
        [
          [level.heroabilityactivateneardeath]
        ]();
      }
    }
    self.heroabilityactivatetime = gettime();
    self.heroabilityactive = 1;
    self.heroability = weapon;
  }
  self thread ability_power::power_consume_timer_think(slot, weapon);
}

function turn_gadget_off(slot, weapon) {
  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }
  if(!isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    return;
  }
  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_off)) {
    foreach(turn_off in level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_off) {
      self[[turn_off]](slot, weapon);
      dead = self.health <= 0;
      self trackheropowerexpired(game["timepassed"], dead, self.heroweaponshots, self.heroweaponhits);
    }
  }
  if(isDefined(level.cybercom) && isDefined(level.cybercom._ability_turn_off)) {
    self[[level.cybercom._ability_turn_off]](slot, weapon);
  }
  if(weapon.gadget_type != 14) {
    if(self isempjammed() == 1) {
      self gadgettargetresult(0);
      if(isDefined(level.callbackendherospecialistemp)) {
        if(isDefined(weapon.gadget_turnoff_onempjammed) && weapon.gadget_turnoff_onempjammed == 1) {
          self thread[[level.callbackendherospecialistemp]]();
        }
      }
    }
    self.heroabilitydectivatetime = gettime();
    self.heroabilityactive = undefined;
    self.heroability = weapon;
  }
  self notify("heroability_off", weapon);
  xuid = self getxuid();
  bbprint("mpheropowerevents", "spawnid %d gametime %d name %s powerstate %s playername %s xuid %s", getplayerspawnid(self), gettime(), self._gadgets_player[slot].name, "expired", self.name, xuid);
  if(isDefined(level.oldschool) && level.oldschool) {
    self takeweapon(weapon);
  }
}

function gadget_checkheroabilitykill(attacker) {
  heroabilitystat = 0;
  if(isDefined(attacker.heroability)) {
    switch (attacker.heroability.name) {
      case "gadget_armor":
      case "gadget_clone":
      case "gadget_heat_wave":
      case "gadget_speed_burst": {
        if(isDefined(attacker.heroabilityactive) || (isDefined(attacker.heroabilitydectivatetime) && attacker.heroabilitydectivatetime > (gettime() - 100))) {
          heroabilitystat = 1;
        }
        break;
      }
      case "gadget_camo":
      case "gadget_flashback":
      case "gadget_resurrect": {
        if(isDefined(attacker.heroabilityactive) || (isDefined(attacker.heroabilitydectivatetime) && attacker.heroabilitydectivatetime > (gettime() - 6000))) {
          heroabilitystat = 1;
        }
        break;
      }
      case "gadget_vision_pulse": {
        if(isDefined(attacker.visionpulsespottedenemytime)) {
          timecutoff = gettime();
          if((attacker.visionpulsespottedenemytime + 10000) > timecutoff) {
            for(i = 0; i < attacker.visionpulsespottedenemy.size; i++) {
              spottedenemy = attacker.visionpulsespottedenemy[i];
              if(spottedenemy == self) {
                if(self.lastspawntime < attacker.visionpulsespottedenemytime) {
                  heroabilitystat = 1;
                  break;
                }
              }
            }
          }
        }
      }
      case "gadget_combat_efficiency": {
        if(isDefined(attacker._gadget_combat_efficiency) && attacker._gadget_combat_efficiency == 1) {
          heroabilitystat = 1;
          break;
        } else if(isDefined(attacker.combatefficiencylastontime) && attacker.combatefficiencylastontime > (gettime() - 100)) {
          heroabilitystat = 1;
          break;
        }
      }
    }
  }
  return heroabilitystat;
}

function gadget_flicker(slot, weapon) {
  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }
  if(!isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    return;
  }
  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_flicker)) {
    foreach(on_flicker in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_flicker) {
      self[[on_flicker]](slot, weapon);
    }
  }
}

function gadget_ready(slot, weapon) {
  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }
  if(!isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    return;
  }
  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].should_notify) && level._gadgets_level[self._gadgets_player[slot].gadget_type].should_notify) {
    if(isDefined(level.statstableid)) {
      itemrow = tablelookuprownum(level.statstableid, 4, self._gadgets_player[slot].name);
      if(itemrow > -1) {
        index = int(tablelookupcolumnforrow(level.statstableid, itemrow, 0));
        if(index != 0) {
          self luinotifyevent(&"hero_weapon_received", 1, index);
          self luinotifyeventtospectators(&"hero_weapon_received", 1, index);
        }
      }
    }
    if(!isDefined(level.gameended) || !level.gameended) {
      if(!isDefined(self.pers["heroGadgetNotified"]) || !self.pers["heroGadgetNotified"]) {
        self.pers["heroGadgetNotified"] = 1;
        if(isDefined(level.playgadgetready)) {
          self[[level.playgadgetready]](weapon);
        }
        self trackheropoweravailable(game["timepassed"]);
      }
    }
  }
  xuid = self getxuid();
  bbprint("mpheropowerevents", "spawnid %d gametime %d name %s powerstate %s playername %s xuid %s", getplayerspawnid(self), gettime(), self._gadgets_player[slot].name, "ready", self.name, xuid);
  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_ready)) {
    foreach(on_ready in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_ready) {
      self[[on_ready]](slot, weapon);
    }
  }
}

function gadget_primed(slot, weapon) {
  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }
  if(!isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    return;
  }
  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_primed)) {
    foreach(on_primed in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_primed) {
      self[[on_primed]](slot, weapon);
    }
  }
}

function abilities_print(str) {
  toprint = "" + str;
  println(toprint);
}

function abilities_devgui_init() {
  setdvar("", "");
  setdvar("", "");
  setdvar("", 0);
  if(isdedicated()) {
    return;
  }
  level.abilities_devgui_base = "";
  level thread abilities_devgui_think();
}

function abilities_devgui_player_connect() {
  if(!isDefined(level.abilities_devgui_base)) {
    return;
  }
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(players[i] != self) {
      continue;
    }
    abilities_devgui_add_player_commands(level.abilities_devgui_base, players[i].playername, i + 1);
    return;
  }
}

function abilities_devgui_add_player_commands(root, pname, index) {
  add_cmd_with_root = (("" + root) + pname) + "";
  pid = "" + index;
  menu_index = 1;
  menu_index = abilities_devgui_add_gadgets(add_cmd_with_root, pid, menu_index);
  menu_index = abilities_devgui_add_power(add_cmd_with_root, pid, menu_index);
}

function abilities_devgui_add_player_command(root, pid, cmdname, menu_index, cmddvar, argdvar) {
  if(!isDefined(argdvar)) {
    argdvar = "";
  }
  adddebugcommand((((((((((((((root + cmdname) + "") + "") + "") + pid) + "") + "") + "") + cmddvar) + "") + "") + "") + argdvar) + "");
}

function abilities_devgui_add_power(add_cmd_with_root, pid, menu_index) {
  root = ((add_cmd_with_root + "") + menu_index) + "";
  abilities_devgui_add_player_command(root, pid, "", 1, "", "");
  abilities_devgui_add_player_command(root, pid, "", 2, "", "");
  menu_index++;
  return menu_index;
}

function abilities_devgui_add_gadgets(add_cmd_with_root, pid, menu_index) {
  a_weapons = enumerateweapons("");
  a_hero = [];
  a_abilities = [];
  for(i = 0; i < a_weapons.size; i++) {
    if(a_weapons[i].isgadget) {
      if(a_weapons[i].inventorytype == "") {
        arrayinsert(a_hero, a_weapons[i], 0);
        continue;
      }
      arrayinsert(a_abilities, a_weapons[i], 0);
    }
  }
  abilities_devgui_add_player_weapons(add_cmd_with_root, pid, a_abilities, "", menu_index);
  menu_index++;
  abilities_devgui_add_player_weapons(add_cmd_with_root, pid, a_hero, "", menu_index);
  menu_index++;
  return menu_index;
}

function abilities_devgui_add_player_weapons(root, pid, a_weapons, weapon_type, menu_index) {
  if(isDefined(a_weapons)) {
    player_devgui_root = (root + weapon_type) + "";
    for(i = 0; i < a_weapons.size; i++) {
      abilities_devgui_add_player_weap_command(player_devgui_root, pid, a_weapons[i].name, i + 1);
      wait(0.05);
    }
  }
}

function abilities_devgui_add_player_weap_command(root, pid, weap_name, cmdindex) {
  adddebugcommand((((((((((((((root + weap_name) + "") + "") + "") + pid) + "") + "") + "") + "") + "") + "") + "") + weap_name) + "");
}

function abilities_devgui_player_disconnect() {
  if(!isDefined(level.abilities_devgui_base)) {
    return;
  }
  remove_cmd_with_root = (("" + level.abilities_devgui_base) + self.playername) + "";
  util::add_queued_debug_command(remove_cmd_with_root);
}

function abilities_devgui_think() {
  for(;;) {
    cmd = getdvarstring("");
    if(cmd == "") {
      wait(0.05);
      continue;
    }
    arg = getdvarstring("");
    switch (cmd) {
      case "": {
        abilities_devgui_handle_player_command(cmd, &abilities_devgui_power_fill);
        break;
      }
      case "": {
        abilities_devgui_handle_player_command(cmd, &abilities_devgui_power_toggle_auto_fill);
        break;
      }
      case "": {
        abilities_devgui_handle_player_command(cmd, &abilities_devgui_give, arg);
      }
      case "": {
        break;
      }
      default: {
        break;
      }
    }
    setdvar("", "");
    wait(0.5);
  }
}

function abilities_devgui_give(weapon_name) {
  level.devgui_giving_abilities = 1;
  for(i = 0; i < 3; i++) {
    if(isDefined(self._gadgets_player[i])) {
      self takeweapon(self._gadgets_player[i]);
    }
  }
  self notify("gadget_devgui_give");
  weapon = getweapon(weapon_name);
  self giveweapon(weapon);
  if(self util::is_bot()) {
    slot = self gadgetgetslot(weapon);
    self gadgetpowerset(slot, 100);
    self bot::activate_hero_gadget(weapon);
  }
  level.devgui_giving_abilities = undefined;
}

function abilities_devgui_handle_player_command(cmd, playercallback, pcb_param) {
  pid = getdvarint("");
  if(pid > 0) {
    player = getplayers()[pid - 1];
    if(isDefined(player)) {
      if(isDefined(pcb_param)) {
        player thread[[playercallback]](pcb_param);
      } else {
        player thread[[playercallback]]();
      }
    }
  } else {
    array::thread_all(getplayers(), playercallback, pcb_param);
  }
  setdvar("", "");
}

function abilities_devgui_power_fill() {
  if(!isDefined(self) || !isDefined(self._gadgets_player)) {
    return;
  }
  for(i = 0; i < 3; i++) {
    if(isDefined(self._gadgets_player[i])) {
      self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
    }
  }
}

function abilities_devgui_power_toggle_auto_fill() {
  if(!isDefined(self) || !isDefined(self._gadgets_player)) {
    return;
  }
  self.abilities_devgui_power_toggle_auto_fill = !(isDefined(self.abilities_devgui_power_toggle_auto_fill) && self.abilities_devgui_power_toggle_auto_fill);
  self thread abilities_devgui_power_toggle_auto_fill_think();
}

function abilities_devgui_power_toggle_auto_fill_think() {
  self endon("disconnect");
  self notify("auto_fill_think");
  self endon("auto_fill_think");
  for(;;) {
    if(!isDefined(self) || !isDefined(self._gadgets_player)) {
      return;
    }
    if(!(isDefined(self.abilities_devgui_power_toggle_auto_fill) && self.abilities_devgui_power_toggle_auto_fill)) {
      return;
    }
    for(i = 0; i < 3; i++) {
      if(isDefined(self._gadgets_player[i])) {
        if(!self gadget_is_in_use(i) && self gadgetcharging(i)) {
          self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
        }
      }
    }
    wait(1);
  }
}