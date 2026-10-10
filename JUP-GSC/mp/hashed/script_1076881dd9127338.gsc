/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1076881dd9127338.gsc
*************************************************/

#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#namespace namespace_3606b64785f08163;

function createevent(radius) {
  event = function_c74368899713e7e6();
  event.radiussquared = radius * radius;
  event.result = [];
  eventstream = self.mind.eventstream;
  eventstream.var_9b7e812b9d289bbf = event;
  eventstream.events[eventstream.events.size] = event;

  if(!isDefined(level.mind.events.var_39dae4a0e7ee4d47)) {
    level.mind.events.var_39dae4a0e7ee4d47 = [];
  }
}

function getevent() {
  event = self.mind.eventstream.var_9b7e812b9d289bbf;

  if(!event.evaluated) {
    if(event.result.size > 0) {
      event.result = [];
    }

    groups = getStructArray("bot_camp_group", "script_noteworthy");

    foreach(group in groups) {
      if(distancesquared(group.origin, self.origin) > event.radiussquared) {
        continue;
      }

      if(function_5a45d11a570a19c5(group)) {
        continue;
      }

      event.result[event.result.size] = group;
    }

    event.evaluated = 1;
  }

  return event.result;
}

function function_5a45d11a570a19c5(campgroup) {
  ownerteams = level.mind.events.var_39dae4a0e7ee4d47[campgroup.target];

  if(!isDefined(ownerteams)) {
    return false;
  }

  var_4a681d08b83b6920 = ownerteams[self.team];

  if(!isDefined(var_4a681d08b83b6920)) {
    return false;
  }

  return var_4a681d08b83b6920 != self.entity_number;
}

function function_7dbe596500a2e27c(campgroup) {
  if(!isDefined(level.mind.events.var_39dae4a0e7ee4d47[campgroup.target])) {
    level.mind.events.var_39dae4a0e7ee4d47[campgroup.target] = [];
  }

  level.mind.events.var_39dae4a0e7ee4d47[campgroup.target][self.team] = self.entity_number;
}

function function_5f6e68b080316fcf(campgroup) {
  ownerteams = level.mind.events.var_39dae4a0e7ee4d47[campgroup.target];

  if(!isDefined(ownerteams)) {
    return;
  }

  var_4a681d08b83b6920 = ownerteams[self.team];

  if(isDefined(var_4a681d08b83b6920) && var_4a681d08b83b6920 == self.entity_number) {
    level.mind.events.var_39dae4a0e7ee4d47[campgroup.target][self.team] = undefined;
  }
}