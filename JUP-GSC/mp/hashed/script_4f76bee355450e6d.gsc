/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4f76bee355450e6d.gsc
*************************************************/

#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#namespace namespace_62dd9dc92ab04572;

function createevent(lootradius, lootnum, boxradius, boxnum, contractradius, contractnum, var_936a53f85271d3f2, var_e690066f4b78c7a2) {
  event = function_c74368899713e7e6();
  event.lootradius = lootradius;
  event.var_6f78dda98ef53f62 = lootradius * lootradius;
  event.lootnum = lootnum;
  event.boxradius = boxradius;
  event.var_f6355cddb69c209d = boxradius * boxradius;
  event.boxnum = boxnum;
  event.contractradius = contractradius;
  event.var_e74daab0a4853d7e = contractradius * contractradius;
  event.contractnum = contractnum;
  event.var_7663c677a90cd6a6 = var_936a53f85271d3f2 * var_936a53f85271d3f2;
  event.var_e690066f4b78c7a2 = var_e690066f4b78c7a2;
  event.result = [];
  eventstream = self.mind.eventstream;
  eventstream.var_a8d1793197306629 = event;
  eventstream.events[eventstream.events.size] = event;

  if(!isDefined(level.mind.events.loots)) {
    var_eb018172d4fec728 = [];
    var_6cad4dc90cf3c50 = [];

    foreach(itemname, itemtype in level.br_pickups.br_itemtype) {
      if(itemtype == #"tablet") {
        var_eb018172d4fec728[var_eb018172d4fec728.size] = itemname;
        continue;
      }

      if(itemtype == #"cache") {
        var_6cad4dc90cf3c50[var_6cad4dc90cf3c50.size] = itemname;
      }
    }

    level.mind.events.loots = spawnStruct();
    level.mind.events.loots.var_eb018172d4fec728 = var_eb018172d4fec728;
    level.mind.events.loots.var_6cad4dc90cf3c50 = var_6cad4dc90cf3c50;
  }
}

function getevent() {
  event = self.mind.eventstream.var_a8d1793197306629;

  if(!event.evaluated) {
    if(event.result.size > 0) {
      if(distancesquared(event.var_7f41225ff57aa85e, self.origin) < event.var_7663c677a90cd6a6 && gettime() - event.lastupdatetime < event.var_e690066f4b78c7a2) {
        return event.result;
      }

      event.result = [];
    }

    getloot(event, self.origin, event.lootradius, event.lootnum, undefined, &function_dc0241948a20b580);
    getloot(event, self.origin, event.boxradius, event.boxnum, level.mind.events.loots.var_6cad4dc90cf3c50);
    getloot(event, self.origin, event.contractradius, event.contractnum, level.mind.events.loots.var_eb018172d4fec728);
    event.evaluated = 1;
  }

  event.var_7f41225ff57aa85e = self.origin;
  event.lastupdatetime = gettime();
  return event.result;
}

function getloot(event, centre, radius, num, itemnames, checkfunc) {
  loots = getlootscriptablearrayinradius(itemnames, undefined, centre, radius, undefined, num);

  foreach(loot in loots) {
    if(!isDefined(loot.model) || isDefined(loot.itemsdropped) || istrue(loot.var_2a6f82a735950253)) {
      continue;
    }

    if(isDefined(checkfunc) && ![[checkfunc]](loot)) {
      continue;
    }

    loottype = level.br_pickups.br_itemtype[loot.type];
    idx = event.result.size;
    event.result[idx] = spawnStruct();
    event.result[idx].entity = loot;
    event.result[idx].type = loottype;
  }
}

function function_dc0241948a20b580(loot) {
  loottype = level.br_pickups.br_itemtype[loot.type];

  if(!isDefined(loottype)) {
    return false;
  }

  if(loottype == #"cache" || loottype == #"tablet") {
    return false;
  }

  return true;
}