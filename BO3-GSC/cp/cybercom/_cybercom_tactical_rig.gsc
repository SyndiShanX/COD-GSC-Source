/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_tactical_rig.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_dev;
#using scripts\cp\cybercom\_cybercom_tactical_rig_copycat;
#using scripts\cp\cybercom\_cybercom_tactical_rig_emergencyreserve;
#using scripts\cp\cybercom\_cybercom_tactical_rig_multicore;
#using scripts\cp\cybercom\_cybercom_tactical_rig_playermovement;
#using scripts\cp\cybercom\_cybercom_tactical_rig_proximitydeterrent;
#using scripts\cp\cybercom\_cybercom_tactical_rig_repulsorarmor;
#using scripts\cp\cybercom\_cybercom_tactical_rig_sensorybuffer;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace cybercom_tacrig;

function init() {
  cybercom_tacrig_sensorybuffer::init();
  cybercom_tacrig_emergencyreserve::init();
  cybercom_tacrig_proximitydeterrent::init();
  cybercom_tacrig_respulsorarmor::init();
  cybercom_tacrig_playermovement::init();
  cybercom_tacrig_copycat::init();
  cybercom_tacrig_multicore::init();
}

function main() {
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  cybercom_tacrig_sensorybuffer::main();
  cybercom_tacrig_emergencyreserve::main();
  cybercom_tacrig_proximitydeterrent::main();
  cybercom_tacrig_respulsorarmor::main();
  cybercom_tacrig_playermovement::main();
  cybercom_tacrig_copycat::main();
  cybercom_tacrig_multicore::main();
}

function on_player_connect() {}

function on_player_spawned() {}

function register_cybercom_rig_ability(name, type) {
  if(!isDefined(level._cybercom_rig_ability)) {
    level._cybercom_rig_ability = [];
  }
  if(!isDefined(level._cybercom_rig_ability[name])) {
    level._cybercom_rig_ability[name] = spawnStruct();
    level._cybercom_rig_ability[name].name = name;
    level._cybercom_rig_ability[name].type = type;
  }
}

function register_cybercom_rig_possession_callbacks(name, on_give, on_take) {
  assert(isDefined(level._cybercom_rig_ability[name]));
  if(!isDefined(level._cybercom_rig_ability[name].on_give)) {
    level._cybercom_rig_ability[name].on_give = [];
  }
  if(!isDefined(level._cybercom_rig_ability[name].on_take)) {
    level._cybercom_rig_ability[name].on_take = [];
  }
  if(isDefined(on_give)) {
    if(!isDefined(level._cybercom_rig_ability[name].on_give)) {
      level._cybercom_rig_ability[name].on_give = [];
    } else if(!isarray(level._cybercom_rig_ability[name].on_give)) {
      level._cybercom_rig_ability[name].on_give = array(level._cybercom_rig_ability[name].on_give);
    }
    level._cybercom_rig_ability[name].on_give[level._cybercom_rig_ability[name].on_give.size] = on_give;
  }
  if(isDefined(on_take)) {
    if(!isDefined(level._cybercom_rig_ability[name].on_take)) {
      level._cybercom_rig_ability[name].on_take = [];
    } else if(!isarray(level._cybercom_rig_ability[name].on_take)) {
      level._cybercom_rig_ability[name].on_take = array(level._cybercom_rig_ability[name].on_take);
    }
    level._cybercom_rig_ability[name].on_take[level._cybercom_rig_ability[name].on_take.size] = on_take;
  }
}

function register_cybercom_rig_activation_callbacks(name, turn_on, turn_off) {
  assert(isDefined(level._cybercom_rig_ability[name]));
  if(!isDefined(level._cybercom_rig_ability[name].turn_on)) {
    level._cybercom_rig_ability[name].turn_on = [];
  }
  if(!isDefined(level._cybercom_rig_ability[name].turn_off)) {
    level._cybercom_rig_ability[name].turn_off = [];
  }
  if(isDefined(turn_on)) {
    if(!isDefined(level._cybercom_rig_ability[name].turn_on)) {
      level._cybercom_rig_ability[name].turn_on = [];
    } else if(!isarray(level._cybercom_rig_ability[name].turn_on)) {
      level._cybercom_rig_ability[name].turn_on = array(level._cybercom_rig_ability[name].turn_on);
    }
    level._cybercom_rig_ability[name].turn_on[level._cybercom_rig_ability[name].turn_on.size] = turn_on;
  }
  if(isDefined(turn_off)) {
    if(!isDefined(level._cybercom_rig_ability[name].turn_off)) {
      level._cybercom_rig_ability[name].turn_off = [];
    } else if(!isarray(level._cybercom_rig_ability[name].turn_off)) {
      level._cybercom_rig_ability[name].turn_off = array(level._cybercom_rig_ability[name].turn_off);
    }
    level._cybercom_rig_ability[name].turn_off[level._cybercom_rig_ability[name].turn_off.size] = turn_off;
  }
}

function rigabilitygiven(type, upgraded) {
  if(!isDefined(level._cybercom_rig_ability[type])) {
    return;
  }
  if(isDefined(level._cybercom_rig_ability[type].on_give)) {
    foreach(on_give in level._cybercom_rig_ability[type].on_give) {
      self[[on_give]](type);
    }
  }
}

function giverigability(type, upgraded = 0, slot, setflags = 1) {
  if(!isDefined(level._cybercom_rig_ability[type])) {
    return false;
  }
  if(!isDefined(slot)) {
    self setcybercomrig(type, upgraded);
  } else {
    self setcybercomrig(type, upgraded, slot);
  }
  if(setflags) {
    self cybercom::updatecybercomflags();
  }
  self rigabilitygiven(type);
  return true;
}

function function_ccca7010(type) {
  if(!isDefined(level._cybercom_rig_ability[type])) {
    return false;
  }
  self _take_rig_ability(type);
  return true;
}

function private _take_rig_ability(type) {
  if(!isDefined(level._cybercom_rig_ability[type])) {
    return false;
  }
  if(isDefined(level._cybercom_rig_ability[type]) && isDefined(level._cybercom_rig_ability[type].on_take)) {
    foreach(on_take in level._cybercom_rig_ability[type].on_take) {
      self[[on_take]](type);
    }
  }
  self notify("take_ability_" + type);
  self clearcybercomrig(type);
  self cybercom::updatecybercomflags();
  return true;
}

function takeallrigabilities() {
  foreach(ability in level._cybercom_rig_ability) {
    if(self hascybercomrig(ability.name) != 0) {
      _take_rig_ability(ability.name);
    }
  }
  self cybercom::updatecybercomflags();
}

function giveallrigabilities() {
  foreach(ability in level._cybercom_rig_ability) {
    status = self hascybercomrig(ability.name);
    if(status != 0) {
      self giverigability(ability.name, status == 2);
    }
  }
  self cybercom::updatecybercomflags();
}

function turn_rig_ability_on(type) {
  reserveability = self hascybercomrig(type);
  if(reserveability == 0) {
    return;
  }
  if(isDefined(level._cybercom_rig_ability[type]) && isDefined(level._cybercom_rig_ability[type].turn_on)) {
    foreach(turn_on in level._cybercom_rig_ability[type].turn_on) {
      self[[turn_on]](type);
    }
  }
}

function turn_rig_ability_off(type) {
  reserveability = self hascybercomrig(type);
  if(reserveability == 0) {
    return;
  }
  if(isDefined(level._cybercom_rig_ability[type]) && isDefined(level._cybercom_rig_ability[type].turn_off)) {
    foreach(turn_off in level._cybercom_rig_ability[type].turn_off) {
      self[[turn_off]](type);
    }
  }
}