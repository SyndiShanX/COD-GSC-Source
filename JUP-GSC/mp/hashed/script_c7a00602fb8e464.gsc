/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_c7a00602fb8e464.gsc
************************************************/

#namespace namespace_1e6379efa55bf4c9;

function function_689bd8ae264f0531(var_649f9b194df395cd) {
  if(!isDefined(level.br_armory_kiosk)) {
    return undefined;
  }

  var_3681b432675353b = undefined;

  foreach(item in level.br_armory_kiosk.items) {
    if(item.cost < var_3681b432675353b.cost || !isDefined(var_3681b432675353b)) {
      if(isDefined(var_649f9b194df395cd) && var_649f9b194df395cd && item.cost == 0) {
        continue;
      }

      var_3681b432675353b = item;
    }
  }

  return var_3681b432675353b;
}

function function_380dfd54b395ec1b(entryref) {
  if(!isDefined(self)) {
    return undefined;
  }

  foreach(item in self.items) {
    if(item.entryref == entryref) {
      return item.cost;
    }
  }

  return undefined;
}

function function_cd83759e21f3ff42(callback) {
  self endon("death");
  self endon("disconnect");

  while(true) {
    self waittill("luinotifyserver", channel, class);

    if(channel == "buy_menu_option_selected" || channel == "buy_menu_open") {
      self[[callback]]();
      return;
    }
  }
}

function function_b40f17685dbcc4e6(callback) {
  self endon("death");
  self endon("disconnect");

  while(true) {
    self waittill("luinotifyserver", channel, class);

    if(channel == "br_cancel_purchase") {
      self[[callback]]();
      return;
    }

    if(channel == "br_item_purchase" || channel == "br_loadout_purchase") {
      if(getdvarint(@ "hash_ed6e4ffa933af621", 0) == 0) {
        self[[callback]]();
        return;
      }
    }
  }
}

function function_dadee81d5ce668bd(callback, var_d24af1a0b7bc04d) {
  self endon("death");
  self endon("disconnect");

  while(true) {
    self waittill("luinotifyserver", channel, class);

    if(channel == "br_item_purchase" || channel == "br_loadout_purchase" || channel == "br_team_revive") {
      itemdata = level.br_armory_kiosk.items[class];

      if(isDefined(var_d24af1a0b7bc04d)) {
        if(isDefined(itemdata) && itemdata.ref == var_d24af1a0b7bc04d) {
          self[[callback]]();
          return;
        }

        continue;
      }

      self[[callback]]();
      return;
    }
  }
}

function function_4bfc467c67d38fe0(callback, var_8e87a15650c9e63f) {
  self endon("death");
  self endon("disconnect");
  itemindex = 0;

  if(isDefined(var_8e87a15650c9e63f)) {
    itemindex = level.br_armory_kiosk function_f7826c1d489e51e(var_8e87a15650c9e63f);
  }

  while(true) {
    self waittill("luinotifyserver", channel, id);

    if(channel == "buy_menu_option_selected") {
      if(isDefined(var_8e87a15650c9e63f)) {
        if(itemindex == id) {
          self[[callback]]();
          return;
        }
      } else {
        self[[callback]]();
        return;
      }
    }

    waitframe();
  }
}

function function_759d3ef2d52c3723(callback, var_d24af1a0b7bc04d) {
  self endon("death");
  self endon("disconnect");

  while(true) {
    self waittill("luinotifyserver", channel, class);

    if(channel == "br_team_revive") {
      self[[callback]]();
      return;
    }
  }
}

function function_f7826c1d489e51e(itemref) {
  if(!isDefined(self)) {
    return undefined;
  }

  for(index = 0; index < self.items.size; index++) {
    if(self.items[index].entryref == itemref) {
      return index;
    }
  }

  return undefined;
}