/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\ability_player.gsc
***********************************************/

#include scripts\abilities\ability_power;
#include scripts\abilities\ability_util;
#include scripts\core_common\array_shared;
#include scripts\core_common\bots\bot_action;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\match_record;
#include scripts\core_common\player\player_role;
#include scripts\core_common\scene_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace ability_player;

autoexec __init__system__() {
  system::register(#"ability_player", &__init__, undefined, undefined);
}

__init__() {
  level callback::add_callback(#"on_end_game", &on_end_game);
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  callback::on_disconnect(&on_player_disconnect);

  if(!isDefined(level._gadgets_level)) {
    level._gadgets_level = [];
  }

  level thread abilities_devgui_init();
}

on_player_connect() {
  if(!isDefined(self._gadgets_player)) {
    self._gadgets_player = [];
  }

  if(!isDefined(self.var_aec4af05)) {
    self.var_aec4af05 = [];
  }

  if(!isDefined(self.pers[#"herogadgetnotified"])) {
    self.pers[#"herogadgetnotified"] = [];
  }

  for(slot = 0; slot < 3; slot++) {
    self.pers[#"herogadgetnotified"][slot] = 0;
  }

  self callback::on_death(&function_32e782df);

  if(self getentnum() < 10) {
    self thread abilities_devgui_player_connect();
  }

}

on_player_spawned() {
  var_aa960fc9 = self getweaponslist();

  foreach(weapon in var_aa960fc9) {
    if(isDefined(weapon.gadget_power_reset_on_spawn) ? weapon.gadget_power_reset_on_spawn : 0) {
      slot = self gadgetgetslot(weapon);
      isfirstspawn = isDefined(self.firstspawn) ? self.firstspawn : 1;
      self gadgetpowerreset(slot, isfirstspawn);
    }
  }

  if((isDefined(self.var_36546d49) ? self.var_36546d49 : 1) && game.state == "playing") {
    self.var_36546d49 = 0;

    for(slot = 0; slot < 3; slot++) {
      if(isDefined(self._gadgets_player) && isDefined(self._gadgets_player[slot])) {
        gadgetweapon = self._gadgets_player[slot];

        if(isDefined(gadgetweapon.var_ddaa57f2) ? gadgetweapon.var_ddaa57f2 : 0) {
          self gadgetpowerset(slot, isDefined(gadgetweapon.var_6a864cad) ? gadgetweapon.var_6a864cad : 100);
        }
      }
    }
  } else if(game.state != "playing") {
    self.var_36546d49 = 0;
  }

  if(!(isDefined(self.pers[#"changed_class"]) && self.pers[#"changed_class"])) {
    self.pers[#"held_gadgets_power"] = [];
    self.pers[#"hash_7a954c017d693f69"] = [];
    self.pers[#"hash_68cdf8807cfaabff"] = [];
  }

  self.heroabilityactivatetime = undefined;
  self.heroabilitydectivatetime = undefined;
  self.heroabilityactive = undefined;
}

on_player_disconnect() {
  self thread abilities_devgui_player_disconnect();
}

is_using_any_gadget() {
  if(!isplayer(self)) {
    return false;
  }

  for(i = 0; i < 3; i++) {
    if(self util::gadget_is_in_use(i)) {
      return true;
    }
  }

  return false;
}

gadgets_save_power(game_ended) {
  if(!isDefined(self._gadgets_player)) {
    return;
  }

  for(slot = 0; slot < 3; slot++) {
    if(!isDefined(self._gadgets_player[slot])) {
      continue;
    }

    gadgetweapon = self._gadgets_player[slot];
    powerleft = self gadgetpowerchange(slot, 0);
    var_51ec1787 = self function_adc6203f(slot);
    deployed = self function_36dfc05f(slot);

    if(game_ended && (deployed || util::gadget_is_in_use(slot))) {
      if(gadgetweapon.gadget_power_round_end_active_penalty > 0) {
        powerleft -= gadgetweapon.gadget_power_round_end_active_penalty;
        powerleft = max(0, powerleft);
      }
    }

    self.pers[#"held_gadgets_power"][gadgetweapon] = powerleft;
    self.pers[#"hash_7a954c017d693f69"][gadgetweapon] = var_51ec1787;
    self.pers[#"hash_68cdf8807cfaabff"][gadgetweapon] = deployed;
  }
}

function_c9b950e3() {
  if(!isDefined(self._gadgets_player)) {
    return;
  }

  for(slot = 0; slot < 3; slot++) {
    if(!isDefined(self._gadgets_player[slot])) {
      continue;
    }

    self function_19ed70ca(slot, 0);
  }
}

function_116ec442() {
  if(!isDefined(self._gadgets_player)) {
    return;
  }

  for(slot = 0; slot < 3; slot++) {
    if(!isDefined(self._gadgets_player[slot])) {
      continue;
    }

    if(self._gadgets_player[slot].statname == #"gadget_health_regen") {
      continue;
    }

    self function_19ed70ca(slot, 1);
  }
}

function_c22f319e(weapon, var_4dd90b81 = 0) {
  slot = self gadgetgetslot(weapon);
  self gadgetdeactivate(slot, weapon, var_4dd90b81);
  self function_ac25fc1f(slot, weapon);
}

function_f2250880(weapon, var_4dd90b81 = 0) {
  if(!isDefined(self) || !isDefined(weapon)) {
    return;
  }

  if(isalive(self)) {
    slot = self gadgetgetslot(weapon);
    self function_95218c27(slot, var_4dd90b81);
    return;
  }

  if(!isDefined(self.var_8912d8d9)) {
    self.var_8912d8d9 = [];
    self.var_41ea5be4 = [];
  }

  if(!isDefined(self.var_8912d8d9)) {
    self.var_8912d8d9 = [];
  } else if(!isarray(self.var_8912d8d9)) {
    self.var_8912d8d9 = array(self.var_8912d8d9);
  }

  self.var_8912d8d9[self.var_8912d8d9.size] = weapon;

  if(!isDefined(self.var_41ea5be4)) {
    self.var_41ea5be4 = [];
  } else if(!isarray(self.var_41ea5be4)) {
    self.var_41ea5be4 = array(self.var_41ea5be4);
  }

  self.var_41ea5be4[self.var_41ea5be4.size] = var_4dd90b81;
  callback::function_d8abfc3d(#"on_player_spawned", &function_9c46835d);
}

function_9c46835d(params) {
  if(isDefined(self.var_8912d8d9)) {
    for(i = 0; i < self.var_8912d8d9.size; i++) {
      slot = self gadgetgetslot(self.var_8912d8d9[i]);
      self function_95218c27(slot, self.var_41ea5be4[i]);
    }
  }

  self.var_8912d8d9 = undefined;
  self.var_41ea5be4 = undefined;
  callback::function_52ac9652(#"on_player_spawned", &function_9c46835d);
}

function_95218c27(slot, var_4dd90b81 = 0) {
  if(!isDefined(self._gadgets_player)) {
    return;
  }

  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }

  self.pers[#"hash_68cdf8807cfaabff"][self._gadgets_player[slot]] = 0;
  self function_48e08b4(slot, self._gadgets_player[slot], var_4dd90b81);
}

function_c2d9d3e1() {
  for(slot = 0; slot < 3; slot++) {
    self function_95218c27(slot);
  }
}

function_32e782df(params) {
  if(game.state != "playing") {
    return;
  }

  if(!isDefined(self._gadgets_player)) {
    return;
  }

  self gadgets_save_power(0);
}

on_end_game() {
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

script_set_cclass(cclass, save = 1) {}

register_gadget(type) {
  if(!isDefined(level._gadgets_level)) {
    level._gadgets_level = [];
  }

  if(!isDefined(level._gadgets_level[type])) {
    level._gadgets_level[type] = spawnStruct();
    level._gadgets_level[type].should_notify = 1;
  }
}

register_gadget_should_notify(type, should_notify) {
  register_gadget(type);

  if(isDefined(should_notify)) {
    level._gadgets_level[type].should_notify = should_notify;
  }
}

register_gadget_possession_callbacks(type, on_give, on_take) {
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

register_gadget_activation_callbacks(type, turn_on, turn_off) {
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

function_92292af6(type, deployed_on, deployed_off) {
  register_gadget(type);

  if(!isDefined(level._gadgets_level[type].deployed_on)) {
    level._gadgets_level[type].deployed_on = [];
  }

  if(!isDefined(level._gadgets_level[type].deployed_off)) {
    level._gadgets_level[type].deployed_off = [];
  }

  if(isDefined(deployed_on)) {
    if(!isDefined(level._gadgets_level[type].deployed_on)) {
      level._gadgets_level[type].deployed_on = [];
    } else if(!isarray(level._gadgets_level[type].deployed_on)) {
      level._gadgets_level[type].deployed_on = array(level._gadgets_level[type].deployed_on);
    }

    level._gadgets_level[type].deployed_on[level._gadgets_level[type].deployed_on.size] = deployed_on;
  }

  if(isDefined(deployed_off)) {
    if(!isDefined(level._gadgets_level[type].deployed_off)) {
      level._gadgets_level[type].deployed_off = [];
    } else if(!isarray(level._gadgets_level[type].deployed_off)) {
      level._gadgets_level[type].deployed_off = array(level._gadgets_level[type].deployed_off);
    }

    level._gadgets_level[type].deployed_off[level._gadgets_level[type].deployed_off.size] = deployed_off;
  }
}

register_gadget_flicker_callbacks(type, on_flicker) {
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

register_gadget_ready_callbacks(type, ready_func) {
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

register_gadget_primed_callbacks(type, primed_func) {
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

register_gadget_is_inuse_callbacks(type, inuse_func) {
  register_gadget(type);

  if(isDefined(inuse_func)) {
    level._gadgets_level[type].isinuse = inuse_func;
  }
}

register_gadget_is_flickering_callbacks(type, flickering_func) {
  register_gadget(type);

  if(isDefined(flickering_func)) {
    level._gadgets_level[type].isflickering = flickering_func;
  }
}

register_gadget_failed_activate_callback(type, failed_activate) {
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

gadget_is_flickering(slot) {
  if(!isDefined(self._gadgets_player)) {
    return 0;
  }

  if(!isDefined(self._gadgets_player[slot])) {
    return 0;
  }

  if(!isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].isflickering)) {
    return 0;
  }

  return self[[level._gadgets_level[self._gadgets_player[slot].gadget_type].isflickering]](slot);
}

give_gadget(slot, weapon) {
  if(!isDefined(self._gadgets_player)) {
    return;
  }

  if(isDefined(self._gadgets_player[slot])) {
    if(self._gadgets_player[slot] != weapon) {
      self.pers[#"hash_68cdf8807cfaabff"][self._gadgets_player[slot]] = 0;
    }

    self take_gadget(slot, self._gadgets_player[slot]);
  }

  for(eslot = 0; eslot < 3; eslot++) {
    existinggadget = self._gadgets_player[eslot];

    if(isDefined(existinggadget) && existinggadget == weapon) {
      self take_gadget(eslot, existinggadget);
    }
  }

  self._gadgets_player[slot] = weapon;

  if(!isDefined(self.var_aec4af05[slot])) {
    self.var_aec4af05[slot] = 0;
  }

  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }

  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_give)) {
      foreach(on_give in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_give) {
        self thread[[on_give]](slot, weapon);
      }
    }
  }

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    self.heroabilityname = isDefined(weapon) ? weapon.name : undefined;
  }
}

take_gadget(slot, weapon) {
  if(!isDefined(self._gadgets_player)) {
    return;
  }

  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }

  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_take)) {
      foreach(on_take in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_take) {
        if(isDefined(on_take)) {
          self thread[[on_take]](slot, weapon);
        }
      }
    }
  }

  self._gadgets_player[slot] = undefined;
}

turn_gadget_on(slot, weapon) {
  if(!isDefined(self._gadgets_player)) {
    return;
  }

  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }

  if(weapon != self._gadgets_player[slot]) {
    return;
  }

  self.var_aec4af05[slot] = 0;
  self gadgetsetactivatetime(slot, gettime());
  self.playedgadgetsuccess = 0;

  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_on)) {
      self function_2c464c28(weapon);
      var_ef2d7dfd = self function_880f27a7();
      players = util::get_active_players(self.team);
      clientnum = self getentitynumber();

      foreach(player in players) {
        player luinotifyevent(#"ability_callout", 2, var_ef2d7dfd, clientnum);
      }

      foreach(turn_on in level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_on) {
        self thread[[turn_on]](slot, weapon);
      }
    }
  }

  if(sessionmodeismultiplayergame()) {
    if(weapon.name == #"gadget_health_regen") {
      var_f8e6b703 = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");

      if(isDefined(var_f8e6b703)) {
        self match_record::inc_stat(#"lives", var_f8e6b703, #"hash_2380fc76594e930d", 1);
      }
    } else {
      self function_33644ff2(game.timepassed, weapon.name);
    }
  } else {
    self function_33644ff2(game.timepassed, weapon.name);
  }

  level notify(#"hero_gadget_activated", {
    #player: self, 
    #weapon: weapon
  });
  self notify(#"hero_gadget_activated", {
    #weapon: weapon
  });

  if(isDefined(level.cybercom) && isDefined(level.cybercom._ability_turn_on)) {
    self thread[[level.cybercom._ability_turn_on]](slot, weapon);
  }

  self.pers[#"herogadgetnotified"][slot] = 0;
  xuid = int(self getxuid(1));

  if(sessionmodeismultiplayergame()) {
    mpheropowerevents = {
      #spawnid: getplayerspawnid(self), 
      #gametime: function_f8d53445(), 
      #name: self._gadgets_player[slot].name, 
      #powerstate: "activated", 
      #playername: self.name, 
      #xuid: xuid
    };
    function_92d1707f(#"hash_2d561b2f8bbe1aac", mpheropowerevents);
  }

  if(isDefined(level.playgadgetactivate)) {
    self thread[[level.playgadgetactivate]](weapon);
  }

  if(weapon.gadget_type != 11) {
    if(isDefined(self.isneardeath) && self.isneardeath == 1) {
      if(isDefined(level.heroabilityactivateneardeath)) {
        self thread[[level.heroabilityactivateneardeath]]();
      }
    }

    self.heroabilityactivatetime = gettime();
    self.heroabilityactive = 1;
    self.heroability = weapon;
  }

  self thread ability_power::power_consume_timer_think(slot, weapon);
}

turn_gadget_off(slot, weapon) {
  if(!isDefined(self) || !isDefined(self._gadgets_player) || !isDefined(self._gadgets_player[slot])) {
    return;
  }

  self.var_aec4af05[slot] = 0;

  if(!isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    return;
  }

  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_off)) {
    self function_3e8bb406(0);

    foreach(turn_off in level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_off) {
      self thread[[turn_off]](slot, weapon);
      self globallogic_score::function_61254438(weapon);
    }
  }

  if(isDefined(level.cybercom) && isDefined(level.cybercom._ability_turn_off)) {
    self thread[[level.cybercom._ability_turn_off]](slot, weapon);
  }

  if(weapon.gadget_type != 11) {
    self.heroabilitydectivatetime = gettime();
    self.heroabilityactive = undefined;
    self.heroability = weapon;
  }

  dead = self.health <= 0;

  if(sessionmodeismultiplayergame()) {
    if(weapon.name != #"gadget_health_regen") {
      self function_79cd8cd6(game.timepassed, weapon.name, dead, self.heavyweaponshots, self.heavyweaponhits);
    }
  } else {
    self function_79cd8cd6(game.timepassed, weapon.name, dead, self.heavyweaponshots, self.heavyweaponhits);
  }

  self notify(#"heroability_off", {
    #weapon: weapon
  });
  xuid = int(self getxuid(1));

  if(sessionmodeismultiplayergame()) {
    mpheropowerevents = {
      #spawnid: getplayerspawnid(self), 
      #gametime: function_f8d53445(), 
      #name: self._gadgets_player[slot].name, 
      #powerstate: "expired", 
      #playername: self.name, 
      #xuid: xuid
    };
    function_92d1707f(#"hash_2d561b2f8bbe1aac", mpheropowerevents);
  }

  if(isDefined(level.oldschool) && level.oldschool) {
    self takeweapon(weapon);
  }
}

function_50557027(slot, weapon) {
  if(!isDefined(self._gadgets_player)) {
    return;
  }

  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }

  self.var_aec4af05[slot] = 0;
  self gadgetsetactivatetime(slot, gettime());

  if(!isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    return;
  }

  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].deployed_on)) {
    self function_3e8bb406(0);

    foreach(deployed_on in level._gadgets_level[self._gadgets_player[slot].gadget_type].deployed_on) {
      self thread[[deployed_on]](slot, weapon);
    }
  }
}

function_d5260ebe(slot, weapon) {
  if(!isDefined(self._gadgets_player)) {
    return;
  }

  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }

  self.var_aec4af05[slot] = 0;

  if(!isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    return;
  }

  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].deployed_off)) {
    self function_3e8bb406(0);

    foreach(deployed_off in level._gadgets_level[self._gadgets_player[slot].gadget_type].deployed_off) {
      self thread[[deployed_off]](slot, weapon);
    }
  }
}

gadget_checkheroabilitykill(attacker) {
  heroabilitystat = 0;

  if(isDefined(attacker.heroability)) {
    switch (attacker.heroability.name) {
      case #"gadget_clone":
      case #"gadget_heat_wave":
      case #"gadget_armor":
      case #"gadget_speed_burst":
        if(isDefined(attacker.heroabilityactive) || isDefined(attacker.heroabilitydectivatetime) && attacker.heroabilitydectivatetime > gettime() - 100) {
          heroabilitystat = 1;
        }

        break;
      case #"gadget_resurrect":
      case #"gadget_camo":
        if(isDefined(attacker.heroabilityactive) || isDefined(attacker.heroabilitydectivatetime) && attacker.heroabilitydectivatetime > gettime() - 6000) {
          heroabilitystat = 1;
        }

        break;
      case #"gadget_vision_pulse":
        if(isDefined(attacker.visionpulsespottedenemytime)) {
          timecutoff = gettime();

          if(attacker.visionpulsespottedenemytime + 10000 > timecutoff) {
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
      case #"gadget_combat_efficiency":
        if(isDefined(attacker._gadget_combat_efficiency) && attacker._gadget_combat_efficiency == 1) {
          heroabilitystat = 1;
          break;
        } else if(isDefined(attacker.combatefficiencylastontime) && attacker.combatefficiencylastontime > gettime() - 100) {
          heroabilitystat = 1;
          break;
        }

        break;
    }
  }

  return heroabilitystat;
}

gadget_flicker(slot, weapon) {
  if(!isDefined(self._gadgets_player)) {
    return;
  }

  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }

  if(!isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    return;
  }

  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_flicker)) {
    foreach(on_flicker in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_flicker) {
      self thread[[on_flicker]](slot, weapon);
    }
  }
}

gadget_ready(slot, weapon) {
  if(!isDefined(self._gadgets_player)) {
    return;
  }

  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }

  type = self._gadgets_player[slot].gadget_type;

  if(isDefined(type) && isDefined(level._gadgets_level[type]) && isDefined(level._gadgets_level[type].should_notify) && level._gadgets_level[type].should_notify) {
    gadget_index = getitemindexfromref(self._gadgets_player[slot].name);

    if(gadget_index > 0) {
      iteminfo = getunlockableiteminfofromindex(gadget_index, 1);

      if(iteminfo.itemgroupname === "killstreak") {
        return;
      }

      if(isDefined(iteminfo)) {
        loadoutslotname = iteminfo.loadoutslotname;

        if(isDefined(loadoutslotname) && loadoutslotname == "herogadget") {
          self luinotifyevent(#"hero_weapon_received", 1, gadget_index);
          self function_b552ffa9(#"hero_weapon_received", 1, gadget_index);
        }
      }
    }
  }

  if(!isDefined(level.gameended) || !level.gameended) {
    if(!self.pers[#"herogadgetnotified"][slot]) {
      self.pers[#"herogadgetnotified"][slot] = 1;

      if(isDefined(level.playgadgetready)) {
        self thread[[level.playgadgetready]](weapon);
      }
    }
  }

  if(sessionmodeismultiplayergame()) {
    if(weapon.name == #"gadget_health_regen") {
      var_f8e6b703 = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");

      if(isDefined(var_f8e6b703)) {
        self match_record::inc_stat(#"lives", var_f8e6b703, #"hash_656f3981134db095", 1);
      }
    } else {
      self function_ac24127(game.timepassed, weapon.name);
    }
  } else {
    self function_ac24127(game.timepassed, weapon.name);
  }

  xuid = int(self getxuid(1));

  if(sessionmodeismultiplayergame()) {
    mpheropowerevents = {
      #spawnid: getplayerspawnid(self), 
      #gametime: function_f8d53445(), 
      #name: self._gadgets_player[slot].name, 
      #powerstate: "ready", 
      #playername: self.name, 
      #xuid: xuid
    };
    function_92d1707f(#"hash_2d561b2f8bbe1aac", mpheropowerevents);
  }

  if(isDefined(type) && isDefined(level._gadgets_level[type]) && isDefined(level._gadgets_level[type].on_ready)) {
    foreach(on_ready in level._gadgets_level[type].on_ready) {
      self thread[[on_ready]](slot, weapon);
    }
  }
}

gadget_primed(slot, weapon) {
  if(!isDefined(self._gadgets_player)) {
    return;
  }

  if(!isDefined(self._gadgets_player[slot])) {
    return;
  }

  if(!isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
    return;
  }

  if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_primed)) {
    foreach(on_primed in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_primed) {
      self thread[[on_primed]](slot, weapon);
    }
  }
}

tutorial_timer(weapon, var_8be5aa55, var_de825ec6) {
  assert(isDefined(var_8be5aa55) && isstring(var_8be5aa55));

  if(isDefined(var_de825ec6)) {
    tutorial_init(weapon);
    self.pers[#"ability_tutorial"][weapon].(var_8be5aa55) = gettime() + var_de825ec6 * 1000;
  }

  return isDefined(self.pers[#"ability_tutorial"][weapon].(var_8be5aa55)) && self.pers[#"ability_tutorial"][weapon].(var_8be5aa55) > gettime();
}

tutorial_init(weapon) {
  if(!isDefined(self.pers[#"ability_tutorial"])) {
    self.pers[#"ability_tutorial"] = [];
  }

  if(!isDefined(self.pers[#"ability_tutorial"][weapon])) {
    self.pers[#"ability_tutorial"][weapon] = spawnStruct();
  }
}

tutorial_hints(slot, weapon, var_8430d11b, var_6c65cb8d, var_eadf8864, var_be7c29a3) {
  self notify("equip_tutorial_text_" + weapon.name);
  self endon(#"disconnect", #"death", "equip_tutorial_text_" + weapon.name);
  self tutorial_init(weapon);

  while(true) {
    if(!self hasweapon(weapon)) {
      break;
    }

    currentslot = self gadgetgetslot(weapon);

    if(currentslot != slot) {
      break;
    }

    if(!self gadgetisready(slot)) {
      break;
    }

    if(self gadgetisprimed(slot)) {
      break;
    }

    if(self util::gadget_is_in_use(slot)) {
      break;
    }

    if(self isinvehicle() || self function_8bc54983() || self scene::is_igc_active() || self isplayinganimscripted()) {
      wait 5;
      continue;
    }

    if(self tutorial_timer(weapon, "recentlyUsed")) {
      wait 5;
      continue;
    }

    if(self tutorial_timer(weapon, "recentlyEquip")) {
      wait 5;
      continue;
    }

    if(self tutorial_timer(weapon, "recentlyReady")) {
      wait 5;
      continue;
    }

    if(!self tutorial_timer(weapon, "recentlyEquipText") && isDefined(var_6c65cb8d) && isDefined(var_be7c29a3) && self[[var_be7c29a3]](slot, weapon)) {
      self tutorial_timer(weapon, "recentlyEquipText", 60);
      self thread[[var_6c65cb8d]](var_8430d11b, 0, "hide_gadget_equip_hint", 7);

      self function_374c4352(var_8430d11b);

    }

    if(!self tutorial_timer(weapon, "recentlyReadyVoice") && isDefined(var_eadf8864)) {
      self tutorial_timer(weapon, "recentlyReadyVoice", 60);
      voiceevent(var_eadf8864, self, undefined);

      self function_374c4352(var_eadf8864);

    }

    wait 5;
  }
}

function_fc4dc54(var_6fcde3b6 = 0) {
  if(!isDefined(self._gadgets_player)) {
    return;
  }

  for(slot = 0; slot < 3; slot++) {
    if(!isDefined(self._gadgets_player[slot])) {
      continue;
    }

    gadgetweapon = self._gadgets_player[slot];

    if(ability_util::is_hero_weapon(gadgetweapon)) {
      continue;
    }

    self gadgetdeactivate(slot, gadgetweapon);
  }

  self forceoffhandend();
}

function_374c4352(str) {
  if(ishash(str)) {
    str = function_9e72a96(str);
  }

  toprint = "<dev string:x38>" + str;
  println(toprint);
}

abilities_print(str) {
  toprint = "<dev string:x4f>" + str;
  println(toprint);
}

abilities_devgui_init() {
  setdvar(#"scr_abilities_devgui_cmd", "<dev string:x64>");
  setdvar(#"scr_abilities_devgui_arg", "<dev string:x64>");
  setdvar(#"scr_abilities_devgui_player", 0);

  if(isdedicated()) {
    return;
  }

  level.abilities_devgui_base = "<dev string:x67>";
  level.abilities_devgui_player_connect = &abilities_devgui_player_connect;
  level.abilities_devgui_player_disconnect = &abilities_devgui_player_disconnect;
  level thread abilities_devgui_think();
}

abilities_devgui_player_connect() {
  if(!isDefined(level.abilities_devgui_base)) {
    return;
  }

  wait 2;
  players = getplayers();

  for(i = 0; i < players.size; i++) {
    if(players[i] != self) {
      continue;
    }

    thread abilities_devgui_add_player_commands(level.abilities_devgui_base, players[i].playername, i + 1);
    return;
  }
}

abilities_devgui_add_player_commands(root, pname, index) {
  add_cmd_with_root = "<dev string:x7a>" + root + pname + "<dev string:x88>";
  pid = "<dev string:x64>" + index;
  menu_index = 1;

  if(isDefined(level.abilities_devgui_add_gadgets_custom)) {
    menu_index = self thread[[level.abilities_devgui_add_gadgets_custom]](root, pname, pid, menu_index);
    return;
  }

  util::waittill_can_add_debug_command();
  menu_index = abilities_devgui_add_gadgets(add_cmd_with_root, pid, menu_index);
  util::waittill_can_add_debug_command();
  menu_index = abilities_devgui_add_power(add_cmd_with_root, pid, menu_index);
  util::waittill_can_add_debug_command();
  menu_index = function_2e0162e9(add_cmd_with_root, pid, menu_index);
}

abilities_devgui_add_player_command(root, pid, cmdname, menu_index, cmddvar, argdvar) {
  if(!isDefined(argdvar)) {
    argdvar = "<dev string:x8c>";
  }

  var_eece3d04 = "<dev string:x96>" + "<dev string:xa0>" + "<dev string:xbe>" + pid;
  var_9b1fa683 = "<dev string:xc2>" + "<dev string:xca>" + "<dev string:xbe>" + cmddvar;
  var_dc0fa12c = "<dev string:xc2>" + "<dev string:xe5>" + "<dev string:xbe>" + argdvar + "<dev string:x100>";
  util::add_queued_debug_command(root + cmdname + var_eece3d04 + var_9b1fa683 + var_dc0fa12c);
}

abilities_devgui_add_power(add_cmd_with_root, pid, menu_index) {
  root = add_cmd_with_root + "<dev string:x106>" + menu_index + "<dev string:x88>";
  abilities_devgui_add_player_command(root, pid, "<dev string:x10f>", 1, "<dev string:x11c>", "<dev string:x64>");
  abilities_devgui_add_player_command(root, pid, "<dev string:x126>", 2, "<dev string:x139>", "<dev string:x64>");
  power = 0;

  while(power <= 1) {
    abilities_devgui_add_player_command(root, pid, "<dev string:x146>" + power, 2, "<dev string:x15d>", "<dev string:x64>" + power);
    abilities_devgui_add_player_command(root, pid, "<dev string:x171>" + power, 2, "<dev string:x186>", "<dev string:x64>" + power);
    power += 0.25;
  }

  menu_index++;
  return menu_index;
}

function_2e0162e9(add_cmd_with_root, pid, menu_index) {
  if(sessionmodeiszombiesgame() || sessionmodeiswarzonegame()) {
    return;
  }

  root = add_cmd_with_root + "<dev string:x198>" + menu_index + "<dev string:x88>";
  session_mode = currentsessionmode();
  var_a2865de6 = getplayerroletemplatecount(session_mode);

  for(i = 1; i < var_a2865de6; i++) {
    var_854a6ba2 = getplayerrolecategory(i, session_mode);

    if(!isDefined(var_854a6ba2)) {
      continue;
    }

    var_d59b8ebf = getplayerrolecategoryinfo(var_854a6ba2);
    var_1a27a47a = makelocalizedstring(getcharacterdisplayname(i, session_mode));
    var_1a27a47a = strreplace(var_1a27a47a, "<dev string:x1a0>", "<dev string:x64>");

    if(var_1a27a47a == "<dev string:x1a4>") {
      var_1a27a47a = "<dev string:x1b3>";
    }

    var_eb49090f = function_9e72a96(function_b14806c6(i, session_mode));
    var_4f6b7b98 = var_1a27a47a + "<dev string:x1c2>" + (isDefined(var_eb49090f) ? var_eb49090f : "<dev string:x1c8>") + "<dev string:x1cf>";

    if(!isDefined(var_d59b8ebf.enabled) || var_d59b8ebf.enabled == 0) {
      var_4f6b7b98 += "<dev string:x1d3>";
    }

    abilities_devgui_add_player_command(root, pid, var_4f6b7b98, i, "<dev string:x1e1>", i);
  }

  menu_index++;
  return menu_index;
}

function_2ced294(&a_weapons, &a_array, weaponname) {
  weapon = getweapon(weaponname);

  if(!isDefined(weapon)) {
    return;
  }

  if(!isinarray(a_weapons, weapon)) {
    return;
  }

  if(!isDefined(a_array)) {
    a_array = [];
  } else if(!isarray(a_array)) {
    a_array = array(a_array);
  }

  if(!isinarray(a_array, weapon)) {
    a_array[a_array.size] = weapon;
  }

  arrayremovevalue(a_weapons, weapon);
}

function_60b82b68(&a_weapons, &a_equipment, &var_c5b1a23e, &a_ultimates) {
  if(sessionmodeiszombiesgame()) {
    return;
  }

  session_mode = currentsessionmode();
  var_a2865de6 = getplayerroletemplatecount(session_mode);

  for(i = 1; i < var_a2865de6; i++) {
    fields = function_934db9a0(i, session_mode);

    if(!isDefined(fields)) {
      continue;
    }

    if(isDefined(fields.primaryequipment)) {
      function_2ced294(a_weapons, a_equipment, fields.primaryequipment);
    }

    if(isDefined(fields.var_c21d61e9)) {
      function_2ced294(a_weapons, var_c5b1a23e, fields.var_c21d61e9);
    }

    if(isDefined(fields.ultimateweapon)) {
      function_2ced294(a_weapons, a_ultimates, fields.ultimateweapon);
    }
  }
}

function_1c3e8791(&a_weapons, &var_dd06e779) {
  for(i = 0; i < 1024; i++) {
    iteminfo = getunlockableiteminfofromindex(i, 0);

    if(isDefined(iteminfo)) {
      reference_s = iteminfo.namehash;
      loadoutslotname = iteminfo.loadoutslotname;

      if(loadoutslotname == "<dev string:x1f2>") {
        function_2ced294(a_weapons, var_dd06e779, reference_s);
      }
    }
  }
}

abilities_devgui_add_gadgets(add_cmd_with_root, pid, menu_index) {
  a_weapons = enumerateweapons("<dev string:x203>");
  a_gadgetweapons = [];

  for(i = 0; i < a_weapons.size; i++) {
    if(isDefined(a_weapons[i]) && a_weapons[i].isgadget) {
      if(!isDefined(a_gadgetweapons)) {
        a_gadgetweapons = [];
      } else if(!isarray(a_gadgetweapons)) {
        a_gadgetweapons = array(a_gadgetweapons);
      }

      if(!isinarray(a_gadgetweapons, a_weapons[i])) {
        a_gadgetweapons[a_gadgetweapons.size] = a_weapons[i];
      }
    }
  }

  a_equipment = [];
  var_c5b1a23e = [];
  a_ultimates = [];
  function_60b82b68(a_gadgetweapons, a_equipment, var_c5b1a23e, a_ultimates);
  var_dd06e779 = [];
  function_1c3e8791(a_gadgetweapons, var_dd06e779);
  var_ef060ee3 = [];
  var_cdbfed45 = [];
  var_7e367d09 = [];
  var_4557f227 = [];
  a_heal = [];

  for(i = 0; i < a_gadgetweapons.size; i++) {
    if(a_gadgetweapons[i].gadget_type == 11 && a_gadgetweapons[i].issignatureweapon) {
      if(!isDefined(var_ef060ee3)) {
        var_ef060ee3 = [];
      } else if(!isarray(var_ef060ee3)) {
        var_ef060ee3 = array(var_ef060ee3);
      }

      if(!isinarray(var_ef060ee3, a_gadgetweapons[i])) {
        var_ef060ee3[var_ef060ee3.size] = a_gadgetweapons[i];
      }

      continue;
    }

    if(a_gadgetweapons[i].gadget_type == 11) {
      if(!isDefined(var_cdbfed45)) {
        var_cdbfed45 = [];
      } else if(!isarray(var_cdbfed45)) {
        var_cdbfed45 = array(var_cdbfed45);
      }

      if(!isinarray(var_cdbfed45, a_gadgetweapons[i])) {
        var_cdbfed45[var_cdbfed45.size] = a_gadgetweapons[i];
      }

      continue;
    }

    if(a_gadgetweapons[i].isheavyweapon) {
      if(!isDefined(var_7e367d09)) {
        var_7e367d09 = [];
      } else if(!isarray(var_7e367d09)) {
        var_7e367d09 = array(var_7e367d09);
      }

      if(!isinarray(var_7e367d09, a_gadgetweapons[i])) {
        var_7e367d09[var_7e367d09.size] = a_gadgetweapons[i];
      }

      continue;
    }

    if(a_gadgetweapons[i].gadget_type == 23) {
      if(!isDefined(a_heal)) {
        a_heal = [];
      } else if(!isarray(a_heal)) {
        a_heal = array(a_heal);
      }

      if(!isinarray(a_heal, a_gadgetweapons[i])) {
        a_heal[a_heal.size] = a_gadgetweapons[i];
      }

      continue;
    }

    if(!isDefined(var_4557f227)) {
      var_4557f227 = [];
    } else if(!isarray(var_4557f227)) {
      var_4557f227 = array(var_4557f227);
    }

    if(!isinarray(var_4557f227, a_gadgetweapons[i])) {
      var_4557f227[var_4557f227.size] = a_gadgetweapons[i];
    }
  }

  function_174037fe(add_cmd_with_root, pid, a_equipment, "<dev string:x20c>", menu_index);
  menu_index++;
  function_76032a31(add_cmd_with_root, pid, a_heal, "<dev string:x21d>", menu_index);
  menu_index++;
  function_a40d04ca(add_cmd_with_root, pid, var_c5b1a23e, "<dev string:x236>", menu_index);
  menu_index++;
  function_174037fe(add_cmd_with_root, pid, var_dd06e779, "<dev string:x247>", menu_index);
  menu_index++;
  function_174037fe(add_cmd_with_root, pid, var_4557f227, "<dev string:x25b>", menu_index);
  menu_index++;
  function_a40d04ca(add_cmd_with_root, pid, var_ef060ee3, "<dev string:x275>", menu_index);
  menu_index++;
  return menu_index;
}

function_174037fe(root, pid, a_weapons, weapon_type, menu_index) {
  if(isDefined(a_weapons)) {
    player_devgui_root = root + weapon_type + "<dev string:x88>";

    for(i = 0; i < a_weapons.size; i++) {
      function_b04fbf27(player_devgui_root, pid, getweaponname(a_weapons[i]), i + 1);
    }
  }
}

function_76032a31(root, pid, a_weapons, weapon_type, menu_index) {
  if(isDefined(a_weapons)) {
    player_devgui_root = root + weapon_type + "<dev string:x88>";

    for(i = 0; i < a_weapons.size; i++) {
      function_50543efb(player_devgui_root, pid, getweaponname(a_weapons[i]), i + 1);
    }
  }
}

function_a40d04ca(root, pid, a_weapons, weapon_type, menu_index) {
  if(isDefined(a_weapons)) {
    player_devgui_root = root + weapon_type + "<dev string:x88>";

    for(i = 0; i < a_weapons.size; i++) {
      function_90502d72(player_devgui_root, pid, getweaponname(a_weapons[i]), i + 1);
    }
  }
}

function_b04fbf27(root, pid, weap_name, cmdindex) {
  util::add_queued_debug_command(root + weap_name + "<dev string:x96>" + "<dev string:xa0>" + "<dev string:xbe>" + pid + "<dev string:xc2>" + "<dev string:xca>" + "<dev string:xbe>" + "<dev string:x28f>" + "<dev string:xc2>" + "<dev string:xe5>" + "<dev string:xbe>" + weap_name + "<dev string:x100>");
}

function_50543efb(root, pid, weap_name, cmdindex) {
  util::add_queued_debug_command(root + weap_name + "<dev string:x96>" + "<dev string:xa0>" + "<dev string:xbe>" + pid + "<dev string:xc2>" + "<dev string:xca>" + "<dev string:xbe>" + "<dev string:x2ab>" + "<dev string:xc2>" + "<dev string:xe5>" + "<dev string:xbe>" + weap_name + "<dev string:x100>");
}

function_90502d72(root, pid, weap_name, cmdindex) {
  util::add_queued_debug_command(root + weap_name + "<dev string:x96>" + "<dev string:xa0>" + "<dev string:xbe>" + pid + "<dev string:xc2>" + "<dev string:xca>" + "<dev string:xbe>" + "<dev string:x2c9>" + "<dev string:xc2>" + "<dev string:xe5>" + "<dev string:xbe>" + weap_name + "<dev string:x100>");
}

abilities_devgui_player_disconnect() {
  if(!isDefined(level.abilities_devgui_base)) {
    return;
  }

  remove_cmd_with_root = "<dev string:x2e5>" + level.abilities_devgui_base + self.playername + "<dev string:x100>";
  util::add_queued_debug_command(remove_cmd_with_root);
}

abilities_devgui_think() {
  setdvar(#"hash_67d528f29bfc7c97", "<dev string:x64>");

  for(;;) {
    cmd = "<dev string:x1e1>";
    arg = getdvarstring(#"hash_67d528f29bfc7c97", "<dev string:x64>");

    if(arg == "<dev string:x64>") {
      cmd = getdvarstring(#"scr_abilities_devgui_cmd");
      arg = getdvarstring(#"scr_abilities_devgui_arg");
    }

    if(cmd == "<dev string:x64>") {
      waitframe(1);
      continue;
    }

    switch (cmd) {
      case #"power_f":
        abilities_devgui_handle_player_command(cmd, &abilities_devgui_power_fill);
        break;
      case #"power_t_af":
        abilities_devgui_handle_player_command(cmd, &abilities_devgui_power_toggle_auto_fill);
        break;
      case #"ability_power_f":
        abilities_devgui_handle_player_command(cmd, &function_3db3dc4f, arg);
        break;
      case #"hash_5b8a32e219f9ae64":
        abilities_devgui_handle_player_command(cmd, &function_626f2cd1, arg);
        break;
      case #"hash_2d2f6f2bb98a38b3":
        abilities_devgui_handle_player_command(cmd, &function_9a0f80b1, arg);
        break;
      case #"hash_5ddbad8870b98e93":
        abilities_devgui_handle_player_command(cmd, &function_ce4e80a7, arg);
        break;
      case #"hash_5515835378aa90c8":
        abilities_devgui_handle_player_command(cmd, &function_4f50aea3, arg);
        break;
      case #"hash_67d528f29bfc7c97":
        abilities_devgui_handle_player_command(cmd, &function_b4f43681, arg);
        break;
      case 0:
        break;
      default:
        break;
    }

    setdvar(#"hash_67d528f29bfc7c97", "<dev string:x64>");
    setdvar(#"scr_abilities_devgui_cmd", "<dev string:x64>");
    setdvar(#"scr_abilities_devgui_player", "<dev string:x2f6>");
    wait 0.5;
  }
}

function_c94ba490(weapon) {
  self notify(#"gadget_devgui_give");
  self giveweapon(weapon);
  waitframe(1);
  slot = self gadgetgetslot(weapon);
  self gadgetpowerreset(slot, 1);
  self gadgetpowerset(slot, 100);
  self gadgetcharging(slot, 0);

  if(isbot(self)) {
    self bot_action::function_ee2eaccc(slot);
  }

  self iprintlnbold(getweaponname(weapon));
}

abilities_devgui_give(weapon_name, slot, var_1d6918cf) {
  level.devgui_giving_abilities = 1;

  if(isDefined(self._gadgets_player[slot]) && self hasweapon(self._gadgets_player[slot])) {
    self gadgetpowerreset(slot, 1);
    self takeweapon(self._gadgets_player[slot]);
  }

  weapon = getweapon(weapon_name);
  self thread function_c94ba490(weapon);
  level.devgui_giving_abilities = undefined;
}

function_4f50aea3(weapon_name) {
  if(isDefined(level.var_124446e) && isarray(level.var_124446e) && isDefined(level.var_124446e[weapon_name])) {
    self[[level.var_124446e[weapon_name]]](self, 2);
    return;
  }

  if(isDefined(level.var_124446e)) {
    self[[level.var_124446e]](weapon_name, 2);
    return;
  }

  self abilities_devgui_give(weapon_name, 2);
}

function_ce4e80a7(weapon_name) {
  if(isDefined(level.var_c49b362f) && isDefined(level.var_c49b362f[weapon_name])) {
    self[[level.var_c49b362f[weapon_name]]](self, 1);
    return;
  }

  self abilities_devgui_give(weapon_name, 1);
}

function_9a0f80b1(weapon_name) {
  if(isDefined(level.var_fdfc376e) && isDefined(level.var_fdfc376e[weapon_name])) {
    self[[level.var_fdfc376e[weapon_name]]](self, 0);
    return;
  }

  self abilities_devgui_give(weapon_name, 0);
}

function_f3fa2789(offhandslot, ability_list) {
  if(!isDefined(ability_list)) {
    ability_list = level.var_29d4fb5b;
  }

  if(!isDefined(ability_list)) {
    return;
  }

  weapon = undefined;

  if(isDefined(self._gadgets_player[offhandslot])) {
    weapon = self._gadgets_player[offhandslot];
  }

  weapon_name = undefined;

  if(isDefined(weapon)) {
    var_29bc3853 = 0;

    for(i = 0; i < ability_list.size; i++) {
      ability_name = ability_list[i];

      if(weapon.name == ability_name) {
        var_29bc3853 = i;
        break;
      }
    }

    var_29bc3853 = (var_29bc3853 + 1) % ability_list.size;
    weapon_name = ability_list[var_29bc3853];
  }

  if(2 == offhandslot) {
    self function_4f50aea3(weapon_name);
  }
}

abilities_devgui_handle_player_command(cmd, playercallback, pcb_param) {
  pid = getdvarint(#"scr_abilities_devgui_player", 0);

  if(pid > 0) {
    player = getplayers()[pid - 1];

    if(isDefined(player)) {
      if(isDefined(pcb_param)) {
        player thread[[playercallback]](pcb_param);
      } else {
        player thread[[playercallback]]();
      }
    }

    return;
  }

  array::thread_all(getplayers(), playercallback, pcb_param);
}

abilities_devgui_power_fill() {
  if(!isDefined(self) || !isDefined(self._gadgets_player)) {
    return;
  }

  for(i = 0; i < 3; i++) {
    if(isDefined(self._gadgets_player[i]) && self hasweapon(self._gadgets_player[i])) {
      self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
    }
  }
}

function_626f2cd1(var_44b235) {
  if(!isDefined(self) || !isDefined(self._gadgets_player)) {
    return;
  }

  if(isDefined(self._gadgets_player[0]) && self hasweapon(self._gadgets_player[0])) {
    self gadgetpowerset(0, self._gadgets_player[0].gadget_powermax * float(var_44b235));
  }
}

function_3db3dc4f(var_44b235) {
  if(!isDefined(self) || !isDefined(self._gadgets_player)) {
    return;
  }

  if(isDefined(self._gadgets_player[2]) && self hasweapon(self._gadgets_player[2])) {
    self gadgetpowerset(2, self._gadgets_player[2].gadget_powermax * float(var_44b235));
  }
}

abilities_devgui_power_toggle_auto_fill() {
  if(!isDefined(self) || !isDefined(self._gadgets_player)) {
    return;
  }

  self.abilities_devgui_power_toggle_auto_fill = !(isDefined(self.abilities_devgui_power_toggle_auto_fill) && self.abilities_devgui_power_toggle_auto_fill);
  self thread abilities_devgui_power_toggle_auto_fill_think();
}

abilities_devgui_power_toggle_auto_fill_think() {
  self endon(#"disconnect");
  self notify(#"auto_fill_think");
  self endon(#"auto_fill_think");

  for(;;) {
    if(!isDefined(self) || !isDefined(self._gadgets_player)) {
      return;
    }

    if(!(isDefined(self.abilities_devgui_power_toggle_auto_fill) && self.abilities_devgui_power_toggle_auto_fill)) {
      return;
    }

    for(i = 0; i < 3; i++) {
      if(isDefined(self._gadgets_player[i]) && self hasweapon(self._gadgets_player[i])) {
        n_power = self gadgetpowerget(i);

        if(!self util::gadget_is_in_use(i) && !self function_36dfc05f(i) && n_power < self._gadgets_player[i].gadget_powermax) {
          self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
        }
      }
    }

    wait 1;
  }
}

function_b4f43681(var_a5c8eb94) {
  if(sessionmodeiszombiesgame()) {
    return;
  }

  if(self isinmovemode("<dev string:x2fb>")) {
    adddebugcommand("<dev string:x2fb>");
    wait 0.5;
  }

  if(self isinmovemode("<dev string:x301>")) {
    adddebugcommand("<dev string:x301>");
    wait 0.5;
  }

  if(var_a5c8eb94 == "<dev string:x30a>") {
    startindex = self player_role::get();
    index = startindex;

    do {
      index += 1;

      if(index == startindex) {
        return;
      }

      if(index >= getplayerroletemplatecount(currentsessionmode())) {
        index = 0;
      }
    }
    while(!self player_role::is_valid(index));
  } else if(var_a5c8eb94 == "<dev string:x30e>") {
    startindex = self player_role::get();
    index = startindex;

    do {
      index -= 1;

      if(index == startindex) {
        return;
      }

      if(index == 0) {
        index = getplayerroletemplatecount(currentsessionmode());
      }
    }
    while(!self player_role::is_valid(index));
  } else {
    index = int(var_a5c8eb94);
  }

  self function_c9b950e3();
  self function_c2d9d3e1();
  self player_role::set(index);

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    spawnselect = level.spawnselectenabled;
    level.spawnselectenabled = 0;

    if(level.numlives) {
      self.pers[#"lives"]++;
    }

    self suicide("<dev string:x312>");
    waitframe(1);

    if(isDefined(self)) {
      self luinotifyevent(#"hash_2dddf8559f5b304d", 1, 1);
    }

    level.spawnselectenabled = spawnselect;
    return;
  }

  if(sessionmodeiscampaigngame()) {
    if(isDefined(level.var_86734d48)) {
      self thread[[level.var_86734d48]](self.team, self.curclass);
    }
  }
}

