/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_ca34b05781dbece.gsc
************************************************/

#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#namespace namespace_f0be73a95f76c7ed;

function createevent(radius) {
  event = function_c74368899713e7e6();
  event.result = [];
  event.radiussq = radius * radius;
  eventstream = self.mind.eventstream;
  eventstream.var_ec10c084410e83fc = event;
  eventstream.events[eventstream.events.size] = event;
}

function getevent() {
  event = self.mind.eventstream.var_ec10c084410e83fc;

  if(!event.evaluated) {
    if(event.result.size > 0) {
      event.result = [];
    }

    entarray = getEntArray("script_model", "classname");

    foreach(ent in entarray) {
      if(isDefined(ent.cratetype) && ent.cratetype == "battle_royale_loadout" && ent.team == self.team && istrue(ent.isusable) && !istrue(ent.var_2a6f82a735950253) && distancesquared(self.origin, ent.origin) < event.radiussq) {
        entry = spawnStruct();
        entry.type = "airdrop_loadout";
        entry.entity = ent;
        entry.entity.index = ent getentitynumber();
        event.result[event.result.size] = entry;
      }
    }

    event.evaluated = 1;
  }

  return event.result;
}