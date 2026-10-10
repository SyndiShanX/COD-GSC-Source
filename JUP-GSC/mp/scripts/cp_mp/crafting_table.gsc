/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\crafting_table.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\content_manager;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\laststand;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\purchasemenu;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\lui_game_event_aggregator;
#namespace crafting_table;

function function_207ef3b2b9684645() {
  level thread function_92e996e62ae888cc();
  level.var_38f3f357808bd969 = &function_c302c35a4fb18338;
}

function private function_92e996e62ae888cc() {
  content_manager::register_script("crafting_table", &function_699b88a1e45c0279);
  waittillframeend();
  wait 1;
  mapdestinations = utility::getStructArray("content_destination", "variantname");

  if(isDefined(mapdestinations) && mapdestinations.size > 0) {
    level thread spawn_destination(mapdestinations[0]);
  }

  level thread function_3575e808663ab031();
}

function function_7e01e70947d29a55() {
  s_menu = purchasemenu::function_cfd0e1fb13d7e080(#"crafting_table");

  if(isDefined(s_menu) && isDefined(s_menu.items)) {
    foreach(item in s_menu.items) {
      if(isDefined(item.category)) {
        switch (item.category) {
          case #"hash_25789111b74943b4":
            item.craftfunc = &function_a98f099f96cf1fe;
            break;
          case #"hash_339227cb650975db":
            item.slot = "primary";
            item.craftfunc = &craft_equipment;
            break;
          case #"hash_850999d7864fa3b4":
            item.slot = "secondary";
            item.craftfunc = &craft_equipment;
            break;
          case #"hash_605929bc0f7f95c8":
            item.craftfunc = &craft_support;
            break;
          default:
            utility::error("crafting_table item: " + item.itemref + " does not have a category set.");
            break;
        }
      }
    }
  }

  lui_game_event_aggregator::registeronluieventcallback(&function_fcdcc8a41c178a71);
}

function spawn_destination(destination) {
  foreach(location in destination.locations) {
    location_instance = location.instances["crafting_table"];

    if(isDefined(location_instance)) {
      foreach(instance in location_instance.versions) {
        content_manager::spawn_instance(instance);
      }
    }
  }
}

function function_3575e808663ab031() {}

function function_699b88a1e45c0279(instance) {
  var_fbde2cbac7586151 = utility::getStructArray("crafting_table_trigger", "targetname");

  foreach(struct in var_fbde2cbac7586151) {
    struct function_56432a6c9dc16f88();
  }

  function_7e01e70947d29a55();
}

function private function_56432a6c9dc16f88() {
  model_struct = utility::getStruct(self.target2, "targetname");
  self.model_table = content_manager::spawn_script_model(model_struct, "t10_zm_machine_crafting_fxanim", 1, 1);
  self.model_table thread function_bf5ef5411b8ab9fe("static");
  self.model_table.interact = interaction::register_interact(self.model_table, self.radius, &function_fd14e351e1c3868e);
  self.model_table.interact interaction::function_e6c63f16f2258b80(&function_6a4771c206414984);
  self.model_table.interact sethinttag("tag_hint");
  self.model_table.interact.struct = self;
}

function function_fd14e351e1c3868e(player) {
  if(istrue(player.interactions_disabled)) {
    return;
  }

  function_2cf60e1dd7c2f302(player);
}

function private function_6a4771c206414984(usable, player) {
  if(isDefined(player) && isDefined(usable)) {
    if(istrue(player.interactions_disabled)) {
      return {
        #string: &"", #type: "HINT_NOICON"};
    }

    return {
      #string: &"SHARED_HINTSTRINGS/CRAFTING_TABLE_START_HINT", #type: "HINT_BUTTON"};
  }

  return {
    #string: &"", #type: "HINT_NOICON"};
}

function function_2cf60e1dd7c2f302(player) {
  s_menu = purchasemenu::function_cfd0e1fb13d7e080(#"crafting_table");

  if(!isDefined(s_menu)) {
    return;
  }

  player.var_8db644cf41dc3e3 = utility::default_to(player.var_8db644cf41dc3e3, 0);
  var_bf1eb50af72af = utility::default_to(s_menu.id, -1);
  player setclientomnvar("ui_self_revive_bought_count", player.var_8db644cf41dc3e3);
  player setclientomnvar("ui_purchasemenu_id", var_bf1eb50af72af);
  player setclientomnvar(s_menu.var_c7ffb2549ca8ab4b, gettime());
  player.var_8e01cb22f32302fa = player.origin;
  player.var_c68b28fc5b112297 = self;
  player thread function_dddb14a98ae3b238();
}

function function_dddb14a98ae3b238() {
  self endon("death");
  level endon("game_ended");
  self.var_b31a1fb061f9e07b = undefined;

  while(true) {
    if(!isDefined(self.var_8e01cb22f32302fa)) {
      break;
    }

    if(distance(self.var_8e01cb22f32302fa, self.origin) > 100) {
      break;
    }

    if(istrue(self.var_b31a1fb061f9e07b)) {
      break;
    }

    wait 0.25;
  }

  if(isDefined(self)) {
    function_baa9f4ba6ddc9e64();
  }
}

function function_baa9f4ba6ddc9e64() {
  s_menu = purchasemenu::function_cfd0e1fb13d7e080(#"crafting_table");

  if(!isDefined(s_menu)) {
    return;
  }

  self setclientomnvar(s_menu.var_8b8931f97eef184, 2);
  self setclientomnvar(s_menu.var_fd0ea8a834fa0398, gettime());
  self.var_8e01cb22f32302fa = undefined;
  self.var_c68b28fc5b112297 = undefined;
  self.var_b31a1fb061f9e07b = undefined;
}

function function_bf5ef5411b8ab9fe(state) {
  if(!self isscriptable()) {
    return;
  }

  if(istrue(self.var_49af41ee9139ef53)) {
    return;
  }

  self.var_49af41ee9139ef53 = 0;

  switch (state) {
    case #"hash_b196217e12b52a9b":
      self setscriptablepartstate("base", "static");
      break;
    case #"hash_b389e7ddef378fd0":
      self setscriptablepartstate("base", "activate");
      self.var_49af41ee9139ef53 = 1;
      wait 6.7;
      self setscriptablepartstate("base", "static");
      self.var_49af41ee9139ef53 = 0;
      break;
  }
}

function function_fcdcc8a41c178a71(channel, purchaseindex) {
  if(isDefined(purchaseindex)) {
    if(channel == "craft_purchase") {
      craftableitemindex = purchaseindex - 1;
      craft_item(craftableitemindex);
      return;
    }

    if(purchasemenu::function_5c9b6f1c3c67dd97(#"crafting_table", channel)) {
      self.var_b31a1fb061f9e07b = 1;
    }
  }
}

function craft_item(craftableitemindex) {
  s_menu = purchasemenu::function_cfd0e1fb13d7e080(#"crafting_table");

  if(!isDefined(s_menu)) {
    return;
  }

  item = purchasemenu::function_904f24ea774b8f6f(#"crafting_table", craftableitemindex);

  if(isDefined(item)) {
    response = self[[s_menu.items[craftableitemindex].craftfunc]](item);

    if(response == 1) {
      self playsoundtoplayer("ui_zm_core_purchase_success", self);
      self.var_c68b28fc5b112297.struct.model_table thread function_bf5ef5411b8ab9fe("activate");
    } else if(response == 3) {
      self playsoundtoplayer("ui_zm_core_purchase_deny", self);
    }

    self setclientomnvar(s_menu.var_8b8931f97eef184, response);
    self setclientomnvar(s_menu.var_fd0ea8a834fa0398, gettime());
  }
}

function function_c302c35a4fb18338(equipref, slot) {
  currentequipment = equipment::getcurrentequipment(slot);
  currentammo = 0;
  currentmaxammo = undefined;

  if(isDefined(currentequipment)) {
    currentammo = equipment::getequipmentammo(currentequipment);
    currentmaxammo = equipment::getequipmentmaxammo(currentequipment);
  }

  if(isDefined(currentequipment) && isDefined(currentammo) && currentequipment != equipref && currentammo > 0) {
    drop_item(currentequipment, currentammo);
    currentammo = 0;
    currentmaxammo = equipment::getequipmentmaxammo(equipref);
  }

  if(isDefined(currentmaxammo) && currentammo >= currentmaxammo) {
    return 5;
  } else {
    currentammo++;
  }

  equipment::giveequipment(equipref, slot);
  equipment::setequipmentammo(equipref, currentammo);
  return undefined;
}

function craft_equipment(item) {
  item_struct = purchasemenu::function_fcb72b7f642e750e(#"crafting_table", item.index);

  if(currency::function_15975e20bbd2c824(item.currency) < item.cost) {
    return 3;
  }

  give_error = function_c302c35a4fb18338(item.itemref, item_struct.slot);

  if(isDefined(give_error)) {
    return give_error;
  }

  currency::function_a06aa3b8c98e131e(item.currency, item.cost);
  return 1;
}

function craft_support(item) {
  cost = item.cost;

  if(item.itemref == "equip_self_revive" && isDefined(item.scalecost)) {
    cost += self.var_8db644cf41dc3e3 * item.scalecost;
  }

  if(!currency::function_bcc79745d547a99c(item.currency, cost)) {
    return 3;
  }

  switch (item.itemref) {
    case #"hash_66b1dce46fb55c22":
      if(laststand::function_85bcfa7d00b8bb6b()) {
        laststand::function_7eba90a4d2ef6d6f();
        self.var_8db644cf41dc3e3++;
        self setclientomnvar("ui_self_revive_bought_count", self.var_8db644cf41dc3e3);
        currency::function_a06aa3b8c98e131e(item.currency, cost);
        return 1;
      } else {
        return 5;
      }

      break;
    default:
      var_e9710ff35394078c = 1;
      killstreak_name = item.itemref;

      if(isDefined(level.killstreaksetups[killstreak_name])) {
        slot_item = killstreaks::getkillstreakinslot(var_e9710ff35394078c);

        if(isDefined(slot_item) && slot_item.available >= item.maxstack) {
          if(killstreak_name == slot_item.streakname) {
            return 5;
          } else {
            drop_item(slot_item.streakname, 1);
            killstreaks::removekillstreak(var_e9710ff35394078c);
            killstreaks::updatekillstreakuislot(var_e9710ff35394078c);
          }
        }

        var_cf2008b9e0e08999 = killstreaks::createstreakitemstruct(killstreak_name);
        killstreaks::awardkillstreakfromstruct(var_cf2008b9e0e08999, "other", undefined, undefined, undefined, var_e9710ff35394078c);
        currency::function_a06aa3b8c98e131e(item.currency, cost);
        return 1;
      }

      break;
  }

  return 2;
}

function drop_item(str_ref, n_count) {
  dist = 64;
  player_forward = anglesToForward(self.angles);
  player_forward = vectorNormalize(player_forward);
  player_forward *= -1;
  drop_pos = self.origin + player_forward * 64;
  dropstruct = function_59a2e61d79065dca();
  dropstruct.var_d8cf705570b19696 = drop_pos;
  common_item::function_105c431a9b8cac6b(str_ref, n_count, dropstruct);
}

function function_a98f099f96cf1fe(item) {
  if(currency::function_15975e20bbd2c824(item.currency) < item.cost) {
    return 3;
  }

  is_repair = item.itemref == "armor_repair";

  if(is_repair) {
    if(!armor::function_e47b13babb51a365()) {
      armor::repair_armor(self.maxarmorhealth);
    } else {
      return 4;
    }
  } else if(self.platecarrierlevel == item.tier - 1) {
    give_armor(item.tier);
  } else {
    return 4;
  }

  currency::function_a06aa3b8c98e131e(item.currency, item.cost);
  return 1;
}

function give_armor(platecarrierlevel) {
  var_5c6e0121240cb514 = 100;
  var_5c6e0421240cbbad = 200;
  var_5c6e0321240cb97a = 300;

  switch (platecarrierlevel) {
    case 1:
      self.platecarrierlevel = 1;
      self.maxarmorhealth = var_5c6e0121240cb514;
      armor::setarmorhealth(var_5c6e0121240cb514);
      break;
    case 2:
      self.platecarrierlevel = 2;
      self.maxarmorhealth = var_5c6e0421240cbbad;
      armor::setarmorhealth(var_5c6e0421240cbbad);
      break;
    case 3:
      self.platecarrierlevel = 3;
      self.maxarmorhealth = var_5c6e0321240cb97a;
      armor::setarmorhealth(var_5c6e0321240cb97a);
      break;
  }

  self setclientomnvar("ui_armor_current_level", platecarrierlevel);
}