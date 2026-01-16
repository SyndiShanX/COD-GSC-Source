/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zombies\_zm_equipment.csc
*******************************************************/

#include clientscripts\mp\_utility;

init() {
  level._equip_activated_callbacks = [];

  if(!is_true(level._no_equipment_activated_clientfield))
    registerclientfield("scriptmover", "equipment_activated", 12000, 4, "int", ::equipment_activated_clientfield_cb, 1, 0);
}

add_equip_activated_callback_override(model, func) {
  level._equip_activated_callbacks[model] = func;
}

equipment_activated_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.model) && isDefined(level._equip_activated_callbacks[self.model]))
    [[level._equip_activated_callbacks[self.model]]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump);

  if(!newval) {
    if(isDefined(self._equipment_activated_fx)) {
      for(i = 0; i < self._equipment_activated_fx.size; i++) {
        for(j = 0; j < self._equipment_activated_fx[i].size; j++)
          deletefx(i, self._equipment_activated_fx[i][j]);
      }

      self._equipment_activated_fx = undefined;
    }
  }
}

play_fx_for_all_clients(fx, tag, storehandles, forward) {
  if(!isDefined(storehandles))
    storehandles = 0;

  if(!isDefined(forward))
    forward = undefined;

  numlocalplayers = getlocalplayers().size;

  if(!isDefined(self._equipment_activated_fx)) {
    self._equipment_activated_fx = [];

    for(i = 0; i < numlocalplayers; i++)
      self._equipment_activated_fx[i] = [];
  }

  if(isDefined(tag)) {
    for(i = 0; i < numlocalplayers; i++) {
      if(storehandles) {
        self._equipment_activated_fx[i][self._equipment_activated_fx[i].size] = playfxontag(i, fx, self, tag);
        continue;
      }

      self_for_client = getentbynum(i, self getentitynumber());

      if(isDefined(self_for_client))
        playfxontag(i, fx, self_for_client, tag);
    }
  } else {
    for(i = 0; i < numlocalplayers; i++) {
      if(storehandles) {
        if(isDefined(forward))
          self._equipment_activated_fx[i][self._equipment_activated_fx[i].size] = playfx(i, fx, self.origin, forward);
        else
          self._equipment_activated_fx[i][self._equipment_activated_fx[i].size] = playfx(i, fx, self.origin);

        continue;
      }

      if(isDefined(forward)) {
        playfx(i, fx, self.origin, forward);
        continue;
      }

      playfx(i, fx, self.origin);
    }
  }
}

is_equipment_included(equipment_name) {
  if(!isDefined(level._included_equipment))
    return false;

  for(i = 0; i < level._included_equipment.size; i++) {
    if(equipment_name == level._included_equipment[i])
      return true;
  }

  return false;
}

include_equipment(equipment) {
  if(!isDefined(level._included_equipment))
    level._included_equipment = [];

  level._included_equipment[level._included_equipment.size] = equipment;
}