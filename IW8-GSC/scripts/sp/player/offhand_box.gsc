/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player\offhand_box.gsc
***********************************************/

function offhand_box_setup() {
  precachemodel("ammo_box_plastic_sm_01");
  wait 1;
  level.offhand_boxes = getEntArray("offhand_box", "targetname");

  if(!istrue(1)) {
    if(isDefined(level.offhand_boxes)) {
      foreach(var1 in level.offhand_boxes) {
        var1 delete();
      }
    }

    return;
  }

  scripts\engine\utility::array_thread(level.offhand_boxes, &offhand_box_think);
}

function offhand_box_think() {
  self endon("death");
  self endon("entitydeleted");
  self.item_type = "molotov";

  if(isDefined(self.script_noteworthy)) {
    self.item_type = self.script_noteworthy;
  }

  self.item_pos_array = scripts\engine\utility::getStructArray(self.target, "targetname");
  self.item_count = self.item_pos_array.size;
  self.item_models = [];
  thread update_offhand_box_item_models();

  for(;;) {
    var0 = waittill_offhand_box_accessed();

    if(isDefined(var0)) {
      if(var0 == "offhand_box_update") {
        if(isDefined(self.interact)) {
          self.interact scripts\sp\player\cursor_hint::remove_cursor_hint();
          self.interact delete();
        }

        foreach(var2 in self.item_models) {
          var2 delete();
        }

        waitframe();
        continue;
      }

      if(self.item_type == "ammo" || scripts\sp\equipment\offhands::offhandisprecached(self.item_type)) {
        if(self.item_type == "ammo") {
          var4 = level.player getweaponslistprimaries();

          foreach(var6 in var4) {
            level.player givemaxammo(var6);
          }

          self.item_count = 0;
        } else if(level.player hasweapon(self.item_type)) {
          var8 = level.player getweaponammoclip(self.item_type);
          var9 = weaponmaxammo(self.item_type);
          var10 = var9 - var8;

          if(var10 > self.item_count) {
            var10 = self.item_count;
          }

          level.player setweaponammoclip(self.item_type, var8 + var10);
          self.item_count -= var10;
        } else {
          jumpiffalse(is_tactical(self.item_type)) LOC_000001af;
          var11 = level.player getoffhandsecondaryclass();
          goto LOC_000001bd;
        }

        scripts\engine\utility::delaycall(0.2, &playsound, "loot_pickup_offhand");
      } else {
        waitframe();
      }

      if(isDefined(self.interact)) {
        self.interact scripts\sp\player\cursor_hint::remove_cursor_hint();
        self.interact delete();
      }

      level notify("offhand_box_used");
      self notify("offhand_box_used");
      level.player scripts\engine\sp\utility::player_gesture_force("ges_swipe");
      wait 0.3;

      if(self.item_count == 0) {
        self notify("offhand_box_kill");
        waitframe();

        if(isDefined(self.item_models)) {
          foreach(var10 in self.item_models) {
            if(isDefined(var10)) {
              var10 delete();
            }
          }
        }

        return;
      }

      wait 1.75;
      continue;
    }

    waitframe();
  }
}

function waittill_offhand_box_accessed() {
  var0 = undefined;

  if(self.item_type == "ammo") {
    var1 = 0;
    var2 = level.player getweaponslistprimaries();

    foreach(var4 in var2) {
      var5 = level.player getweaponammostock(var4);
      var6 = weaponmaxammo(var4);

      if(var5 < var6) {
        var1 = 1;
        break;
      }
    }
  } else {
    var1 = !level.player hasweapon(self.item_type) || level.player hasweapon(self.item_type) && get_player_offhand_ammo(level.player, self.item_type) < get_player_offhand_max_ammo(level.player, self.item_type);
  }

  if(var1) {
    var8 = 256;

    if(isDefined(self.radius)) {
      var8 = int(self.radius);
    }

    var9 = get_offhand_item_pickup_hint(self.item_type == "ammo" || level.player hasweapon(self.item_type));

    if(level.script == "proxywar") {
      var10 = (10, 0, 10);
      var11 = 60;
    } else {
      var10 = (0, 0, 10);
      var11 = 35;

      if(self.item_type == "ammo") {
        var10 = (0, 0, 12);
      }
    }

    self.interact = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_origin"));
    self.interact linkTo(self, "tag_origin");
    self.interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", var10, var11, var11, var10, 90, 0, undefined, undefined, self.icon, "duration_none", undefined, undefined, 30);
    self.interact notsolid();
    var8 = self.interact scripts\engine\utility::waittill_any_return("trigger", "offhand_box_update");
  }

  return var8;
}

function update_offhand_box_item_models() {
  self endon("death");
  self endon("entitydeleted");
  self endon("offhand_box_kill");

  for(;;) {
    self.item_models = scripts\engine\utility::array_removeundefined(self.item_models);
    var0 = get_offhand_item_model();

    while(self.item_models.size != self.item_count) {
      if(self.item_count > self.item_models.size) {
        var1 = get_offhand_box_item_slot_struct();
        var2 = spawn("script_model", var1.origin);
        var2.angles = var1.angles;
        var1.item = var2;
        var2 setModel(var0);
        self.item_models[self.item_models.size] = var2;
      } else if(isDefined(self.item_models[0])) {
        foreach(var4 in self.item_pos_array) {
          if(isDefined(var4.item) && var4.item == self.item_models[0]) {
            var4.item = undefined;
          }
        }

        self.item_models[0] delete();
      }

      self.item_models = scripts\engine\utility::array_removeundefined(self.item_models);
    }

    foreach(var7 in self.item_models) {
      if(var7.model != var0) {
        var7 setModel(var0);
      }
    }

    waitframe();
  }
}

function get_offhand_box_item_slot_struct() {
  foreach(var1 in self.item_pos_array) {
    if(isDefined(var1) && !isDefined(var1.item)) {
      return var1;
    }
  }

  return undefined;
}

function get_offhand_item_pickup_hint(var0) {
  var1 = "Pickup";
  self.icon = undefined;

  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(self.item_type == "ammo") {
    var1 = &"GAME/TAKE_AMMO";
    self.icon = "hud_icon_ammo";
  } else if(self.item_type == "flash") {
    var1 = &"GAME/TAKE_FLASH";
    self.icon = "hud_icon_equipment_flash";
  } else {
    if(!var0) {
      var0 = level.player getoffhandprimaryclass() == "none";
    }

    if(self.item_type == "molotov") {
      if(var0) {
        var1 = &"GAME/TAKE_MOLOTOV";
      } else {
        var1 = &"GAME/SWAP_MOLOTOV";
      }

      self.icon = "hud_icon_equipment_molotov";
    } else if(self.item_type == "semtex") {
      if(var0) {
        var1 = &"GAME/TAKE_SEMTEX";
      } else {
        var1 = &"GAME/SWAP_SEMTEX";
      }

      self.icon = "hud_icon_equipment_semtex";
    } else if(self.item_type == "frag") {
      if(var0) {
        var1 = &"GAME/TAKE_FRAG";
      } else {
        var1 = &"GAME/SWAP_FRAG";
      }

      self.icon = "hud_icon_equipment_frag";
    }
  }

  return var1;
}

function get_offhand_item_model() {
  var0 = "script_origin";

  if(self.item_type == "molotov") {
    var0 = "loot_molotov";
  } else if(self.item_type == "semtex") {
    var0 = "loot_semtex";
  } else if(self.item_type == "frag") {
    var0 = "loot_frag";
  } else if(self.item_type == "flash") {
    var0 = "loot_flash";
  } else if(self.item_type == "ammo") {
    var0 = "ammo_box_plastic_sm_01";
  }

  return var0;
}

function update_global_offhand_boxes() {
  foreach(var1 in level.offhand_boxes) {
    if(isDefined(var1.interact)) {
      var1.interact notify("offhand_box_update");
    }

    if(isDefined(var1.pickup_trig)) {
      var1.pickup_trig notify("offhand_box_update");
    }
  }
}

function get_player_offhand_max_ammo(var0) {
  var1 = get_player_offhand_weapon(var0);
  return weaponmaxammo(var1);
}

function get_player_offhand_ammo(var0) {
  var1 = 0;

  foreach(var3 in level.player.offhandinventory) {
    if(tolower(var3.basename) == var0) {
      var1 = level.player getammocount(var3);
      break;
    }
  }

  return var1;
}

function offhand_swap_return_new_ammo_count(var0, var1, var2) {
  var3 = get_player_offhand_ammo(var0);
  take_player_offhand_by_name(var0);
  level.player scripts\engine\sp\utility::give_offhand(var1, var2);
  return int(var3);
}

function take_player_offhand_by_name(var0) {
  var1 = get_player_offhand_weapon(var0);
  level.player scripts\engine\sp\utility::take_offhand(var1);
}

function get_player_offhand_weapon(var0) {
  foreach(var2 in level.player.offhandinventory) {
    if(tolower(var2.basename) == var0) {
      return var2;
    }
  }

  return undefined;
}

function is_tactical(var0) {
  return var0 == "flash" || var0 == "smoke";
}