/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\player\offhand_box.gsc
************************************************/

#using script_3a8f9ace195c9da9;
#using scripts\common\utility;
#using scripts\cp\cp_hud_message;
#using scripts\cp\gestures_cp;
#using scripts\cp\pickups;
#using scripts\cp\utility;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace offhand_box;

function offhand_box_setup() {
  flag_wait("level_ready_for_script");
  level.offhand_boxes = getStructArray("offhand_box", "targetname");
  level.var_d4f94560dc218123 = getStructArray("offhand_bag", "targetname");

  if(!istrue(1)) {
    if(isDefined(level.offhand_boxes)) {
      foreach(offhand_box in level.offhand_boxes) {
        offhand_box delete();
      }
    }

    return;
  }

  foreach(offhand_box in level.offhand_boxes) {
    if(isDefined(offhand_box.angles)) {
      offhand_box.scriptable = spawnscriptable("cp_offhand_box", offhand_box.origin, offhand_box.angles);
    } else {
      offhand_box.scriptable = spawnscriptable("cp_offhand_box", offhand_box.origin);
    }

    offhand_box.scriptable.item_type = offhand_box.script_noteworthy;
  }

  foreach(offhand_bag in level.var_d4f94560dc218123) {
    if(isDefined(offhand_bag.angles)) {
      offhand_bag.scriptable = spawnscriptable("cp_offhand_bag", offhand_bag.origin, offhand_bag.angles);
    } else {
      offhand_bag.scriptable = spawnscriptable("cp_offhand_bag", offhand_bag.origin);
    }

    offhand_bag.scriptable.item_type = offhand_bag.script_noteworthy;
  }

  flag_wait("player_spawned_with_loadout");
  array_thread(level.offhand_boxes, &offhand_box_think, level.player);
  array_thread(level.var_d4f94560dc218123, &offhand_box_think, level.player);
  flag_set("cp_offhand_boxes_spawned");
}

function offhand_box_think(player) {
  if(isDefined(self.target)) {
    self.item_pos_array = getStructArray(self.target, "targetname");
  } else {
    self.item_pos_array = [];
  }

  self.item_count = self.item_pos_array.size;

  if(isDefined(self.script_count)) {
    if(self.script_count == -1) {
      self.infinite = 1;
    } else {
      self.item_count = min(self.item_count, self.script_count);
    }
  } else if(isDefined(self.script_count_min) && isDefined(self.script_count_max)) {
    self.item_count = min(self.item_count, randomintrange(self.script_count_min, self.script_count_max));
  }

  if(isfloat(self.item_count)) {
    self.item_count = int(self.item_count);
  }

  self.item_models = [];
  thread update_offhand_box_item_models(player);

  if(!isDefined(self.script_noteworthy)) {
    thread function_863bc5d68813ee8a(player, 360);
    return;
  }

  self.item_type = self.script_noteworthy;
  thread function_250357933f00dc3(player);
}

function private function_250357933f00dc3(player) {
  self endon("death");
  self endon("entitydeleted");
  assert(isDefined(self.item_type));
  self notify("update_models");

  while(true) {
    result = waittill_offhand_box_accessed(player);

    if(isDefined(result)) {
      if(result == "offhand_box_update") {
        foreach(item_model in self.item_models) {
          item_model delete();
        }

        waitframe();
        self notify("update_models");
        continue;
      }

      if(function_a4482d0d3055db9a()) {
        if(self.item_type == "ammo") {
          [gaveammo, var_d6a57b95fc473441] = scripts\cp\pickups::giveammo(player);
          var_6e10774fa3fb048e = scripts\cp\pickups::function_a95732425992ae46(player);

          if((gaveammo || var_6e10774fa3fb048e) && !istrue(self.infinite)) {
            self.item_count = 0;
            self.scriptable setscriptablepartstate("cp_offhand_box", "visible_no_outline");
          } else {
            waitframe();
            player scripts\cp\cp_hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
            continue;
          }
        } else if(isgrenade(self.item_type)) {
          refilled = refillequipment(player, self.item_type);

          if(!refilled) {
            waitframe();
            player scripts\cp\cp_hud_message::showerrormessage("MP/BR_EQUIP_DENY_NO_ROOM");
            continue;
          }
        } else if(self.item_type == "armorplate") {
          refilled = refillequipment(player, self.item_type);

          if(!refilled) {
            player scripts\cp\cp_hud_message::showerrormessage("MP_INGAME_ONLY/ARMOR_RESTOCK_STOCK_FULL");
            continue;
          }
        } else if(issharedfuncdefined("offhandBox", "_onUse", 0)) {
          player[[getsharedfunc("offhandBox", "_onUse")]](self);
        }

        self.interact.cursor_hint_ent delaycall(0.2, &playsound, "loot_pickup_offhand");
      } else {
        waitframe();
      }

      self notify("update_models");
      level notify("offhand_box_used");
      self notify("offhand_box_used");
      player player_gesture_force("iw9_ges_pickup");
      wait 0.3;

      if(self.item_count == 0 && !istrue(self.infinite)) {
        self notify("offhand_box_kill");

        if(isDefined(self.scriptable)) {
          self.scriptable notify("offhand_box_kill");
        }

        waitframe();

        if(isDefined(self.item_models)) {
          foreach(item_model in self.item_models) {
            if(isDefined(item_model)) {
              item_model delete();
            }
          }
        }

        self notify("update_models");
        return;
      }

      wait 1.75;
    } else {
      waitframe();
    }

    self notify("update_models");
  }
}

function private refillequipment(player, equipname) {
  primaryequip = player scripts\cp_mp\equipment::getcurrentequipment("primary");
  secondaryequip = player scripts\cp_mp\equipment::getcurrentequipment("secondary");
  var_41dee29e66a53e05 = player scripts\cp_mp\equipment::getcurrentequipment("health");
  equipname = "equip_" + equipname;
  equiptype = undefined;
  var_25ea1f27ebc304e6 = undefined;
  var_cf0ebcdd1e835602 = 0;

  if(scripts\cp_mp\equipment::isequipmentlethal(equipname)) {
    equiptype = "primary";
    var_25ea1f27ebc304e6 = primaryequip;
  } else if(scripts\cp_mp\equipment::isequipmenttactical(equipname)) {
    equiptype = "secondary";
    var_25ea1f27ebc304e6 = secondaryequip;
  } else if(equipname == "equip_armorplate") {
    equiptype = "health";
    var_25ea1f27ebc304e6 = var_41dee29e66a53e05;
  }

  if(!isDefined(var_25ea1f27ebc304e6) || player scripts\cp_mp\equipment::getequipmentammo(var_25ea1f27ebc304e6) == 0) {
    player scripts\cp_mp\equipment::giveequipment(equipname, equiptype);
    player scripts\cp_mp\equipment::setequipmentammo(equipname, 0);
    var_cf0ebcdd1e835602 = function_a459d0f605bf523f(player, equipname);
    player function_c33f5b700efef63b(equiptype, equipname);
  } else if(var_25ea1f27ebc304e6 == equipname) {
    var_cf0ebcdd1e835602 = function_a459d0f605bf523f(player, equipname);
  } else if(getdvarint(@ "hash_3d3e000ab3fdf69e", 0) == 1) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(var_25ea1f27ebc304e6);
    player scripts\cp\pickups::function_276e0e89c09af369(equiptype, lootid, player scripts\cp_mp\equipment::getequipmentammo(var_25ea1f27ebc304e6));
    player scripts\cp_mp\equipment::giveequipment(equipname, equiptype);
    player scripts\cp_mp\equipment::setequipmentammo(equipname, 0);
    var_cf0ebcdd1e835602 = function_a459d0f605bf523f(player, equipname);
    player function_c33f5b700efef63b(equiptype, equipname);
  }

  if(level.noinventory) {
    return var_cf0ebcdd1e835602;
  }

  remaining = player scripts\cp\pickups::additemtobackpackbyref(equipname, "equipment", self.item_count, 1);

  if(self.item_count == remaining) {
    return var_cf0ebcdd1e835602;
  } else {
    self.item_count = remaining;

    if(self.item_count == 0) {
      self.scriptable setscriptablepartstate("cp_offhand_box", "visible_no_outline");
    }
  }

  return 1;
}

function private function_a459d0f605bf523f(player, equipname) {
  equip_count = player scripts\cp_mp\equipment::getequipmentammo(equipname);
  var_2f3d47425b9a0f5a = player scripts\cp_mp\equipment::getequipmentmaxammo(equipname);

  if(equip_count != var_2f3d47425b9a0f5a) {
    var_5400e215ebf1b67a = 0;

    if(self.item_count + equip_count < var_2f3d47425b9a0f5a) {
      var_5400e215ebf1b67a = self.item_count + equip_count;
      self.item_count = 0;
    } else {
      self.item_count -= var_2f3d47425b9a0f5a - equip_count;
      var_5400e215ebf1b67a = var_2f3d47425b9a0f5a;
    }

    player scripts\cp_mp\equipment::setequipmentammo(equipname, var_5400e215ebf1b67a);

    if(self.item_count == 0) {
      self.scriptable setscriptablepartstate("cp_offhand_box", "visible_no_outline");
    }

    return true;
  }

  return false;
}

function private isgrenade(typename) {
  if(typename == "frag" || typename == "flash" || typename == "semtex" || typename == "c4") {
    return 1;
  }

  return 0;
}

function private function_863bc5d68813ee8a(player, radius) {
  self endon("death");
  self endon("entitydeleted");
  self endon("offhand_box_kill");
  radiussq = squared(radius);

  while(isDefined(self)) {
    wait randomfloatrange(0.5, 1);

    if(!isDefined(self)) {
      return;
    }

    if(distancesquared(player.origin, self.origin) < radiussq) {
      return "trigger";
    }
  }
}

function function_a4482d0d3055db9a() {
  if(self.item_type == "ammo" || isgrenade(self.item_type) || self.item_type == "armorplate") {
    return true;
  }

  return false;
}

function waittill_offhand_box_accessed(player) {
  result = undefined;

  if(function_a4482d0d3055db9a()) {
    do_interact = 1;
  } else {
    do_interact = 0;

    if(issharedfuncdefined("offhandBox", "_allowUse", 0)) {
      do_interact = player[[getsharedfunc("offhandBox", "_allowUse")]](self);
    }
  }

  if(do_interact) {
    visible_dist = 256;

    if(isDefined(self.radius)) {
      visible_dist = int(self.radius);
    }

    pickup_hint = get_offhand_item_pickup_hint(player, self.item_type == "ammo" || isgrenade(self.item_type));
    cursor_offset = (0, 0, 10);

    if(self.item_type == "ammo") {
      cursor_offset = (0, 0, 12);
    }

    if(isDefined(self.model)) {
      if(self.model == "un_military_backpack_open_01") {
        cursor_offset = (10, 7, 10);
      } else if(self.model == "un_military_storage_container_small_open_01") {
        cursor_offset = (12, 7, 17);
      } else if(self.model == "un_military_storage_container_02_open") {
        cursor_offset = (14, 8, 25);
      }
    }

    if(self.item_type == "armorplate") {
      return function_863bc5d68813ee8a(player, 100);
    }

    if(!isDefined(self.interact)) {
      self.interact = spawnStruct();
      self.interact.origin = self.origin;
      self.interact.angles = isDefined(self.angles) ? self.angles : (0, 0, 0);
    }

    if(isDefined(self.interact.cursor_hint_ent)) {
      while(isDefined(self.interact.cursor_hint_ent)) {
        waitframe();
      }
    }

    var_3ddfbf3264817453 = player usinggamepad() && (player getcurrentusereloadconfig() == 0 || player getcurrentusereloadconfig() == 3);
    var_2e3e86610aa87c44 = !player usinggamepad() && istrue(player getuseholdkbmprofile());
    var_ad8472207b13c639 = ter_op(var_3ddfbf3264817453 || var_2e3e86610aa87c44, "duration_short", "duration_none");
    self.interact create_cursor_hint(undefined, cursor_offset, pickup_hint, 360, visible_dist, 90, 0, undefined, undefined, self.icon, var_ad8472207b13c639, undefined, undefined, 45);
    result = player waittill_any_ents_return(self.interact, "trigger", self.interact, "offhand_box_update", player);
  }

  level notify("offhand_box_used", self);
  return result;
}

function update_offhand_box_item_models(player) {
  self endon("death");
  self endon("entitydeleted");
  self endon("offhand_box_kill");

  while(true) {
    self.item_models = array_removeundefined(self.item_models);
    var_dd53030b256aa23b = get_offhand_item_model();

    while(self.item_models.size != self.item_count) {
      if(self.item_count > self.item_models.size && isDefined(var_dd53030b256aa23b)) {
        var_8acc266afda40d29 = get_offhand_box_item_slot_struct();
        scriptable = spawnscriptable(var_dd53030b256aa23b, var_8acc266afda40d29.origin, var_8acc266afda40d29.angles);
        scriptable setscriptablepartstate(var_dd53030b256aa23b, "visible_no_use");
        scriptable disablescriptableplayeruse(player);
        scriptable.undiscoverable = 1;
        var_8acc266afda40d29.item = scriptable;
        self.item_models[self.item_models.size] = scriptable;
      } else if(isDefined(self.item_models[0])) {
        foreach(pos_struct in self.item_pos_array) {
          if(isDefined(pos_struct.item) && pos_struct.item == self.item_models[0]) {
            pos_struct.item = undefined;
          }
        }

        self.item_models[0] freescriptable();
      }

      self.item_models = array_removeundefined(self.item_models);
    }

    self waittill("update_models");
  }
}

function get_offhand_box_item_slot_struct() {
  foreach(pos_struct in self.item_pos_array) {
    if(isDefined(pos_struct) && !isDefined(pos_struct.item)) {
      return pos_struct;
    }
  }

  return undefined;
}

function get_offhand_item_pickup_hint(player, already_has) {
  pickup_hint = &"";

  if(self.item_type == "ammo") {
    pickup_hint = &"EQUIPMENT_HINTS/OFFHAND_AMMO_BOX_USE";
  } else if(self.item_type == "armorplate") {
    pickup_hint = &"EQUIPMENT_HINTS/ARMOR_BOX_USE";
  } else if(isgrenade(self.item_type)) {
    if(self.item_type == "c4") {
      pickup_hint = &"EQUIPMENT_HINTS/REFILL_C4";
    } else if(self.item_type == "flash") {
      pickup_hint = &"EQUIPMENT_HINTS/REFILL_FLASH";
    } else if(self.item_type == "semtex") {
      pickup_hint = &"EQUIPMENT_HINTS/REFILL_SEMTEX";
    } else if(self.item_type == "frag") {
      pickup_hint = &"EQUIPMENT_HINTS/REFILL_FRAG";
    }
  }

  self.icon = undefined;

  if(!isDefined(already_has)) {
    already_has = 0;
  }

  if(!already_has) {
    already_has = player getoffhandprimaryclass() == "none";
  }

  return pickup_hint;
}

function get_offhand_item_model() {
  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "ammo") {
      return "brloot_ammo_box_small";
    } else if(self.script_noteworthy == "frag") {
      return "brloot_offhand_frag";
    } else if(self.script_noteworthy == "flash") {
      return "brloot_offhand_flash";
    } else if(self.script_noteworthy == "semtex") {
      return "brloot_offhand_semtex";
    } else if(self.script_noteworthy == "armorplate") {
      return "brloot_armor_plate";
    } else if(self.script_noteworthy == "c4") {
      return "brloot_offhand_c4";
    }
  }

  return undefined;
}