/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\player\offhand_box.gsc
***********************************************/

offhand_box_setup() {
  precachemodel("ammo_box_plastic_sm_01");
  wait 1;
  level.offhand_boxes = getEntArray("offhand_box", "targetname");

  if(!istrue(1)) {
    if(isDefined(level.offhand_boxes)) {
      foreach(var_1 in level.offhand_boxes)
      var_1 delete();
    }

    return;
  }

  scripts\engine\utility::array_thread(level.offhand_boxes, ::offhand_box_think);
}

offhand_box_think() {
  self endon("death");
  self endon("entitydeleted");
  self.item_type = "molotov";

  if(isDefined(self.script_noteworthy))
    self.item_type = self.script_noteworthy;

  self.item_pos_array = scripts\engine\utility::getStructArray(self.target, "targetname");
  self.item_count = self.item_pos_array.size;
  self.item_models = [];
  thread update_offhand_box_item_models();

  for(;;) {
    var_0 = waittill_offhand_box_accessed();

    if(isDefined(var_0)) {
      if(var_0 == "offhand_box_update") {
        if(isDefined(self.interact)) {
          self.interact scripts\sp\player\cursor_hint::remove_cursor_hint();
          self.interact delete();
        }

        foreach(var_2 in self.item_models)
        var_2 delete();

        waitframe();
        continue;
      }

      if(self.item_type == "ammo" || scripts\sp\equipment\offhands::offhandisprecached(self.item_type)) {
        if(self.item_type == "ammo") {
          var_4 = level.player getweaponslistprimaries();

          foreach(var_6 in var_4)
          level.player givemaxammo(var_6);

          self.item_count = 0;
        } else if(level.player hasweapon(self.item_type)) {
          var_8 = level.player getweaponammoclip(self.item_type);
          var_9 = weaponmaxammo(self.item_type);
          var_10 = var_9 - var_8;

          if(var_10 > self.item_count)
            var_10 = self.item_count;

          level.player setweaponammoclip(self.item_type, var_8 + var_10);
          self.item_count = self.item_count - var_10;
        } else {
          if(is_tactical(self.item_type))
            var_11 = level.player getoffhandsecondaryclass();
          else
            var_11 = level.player getoffhandprimaryclass();

          var_8 = level.player getweaponammoclip(var_11);

          if(var_11 != "none")
            level.player take_player_offhand_by_name(var_11);

          var_10 = weaponmaxammo(self.item_type);

          if(var_10 > self.item_count)
            var_10 = self.item_count;

          level.player scripts\engine\sp\utility::give_offhand(self.item_type, var_10);

          if(var_11 != "none") {
            self.item_count = var_8;
            self.item_type = var_11;
            thread update_global_offhand_boxes();
          } else
            self.item_count = self.item_count - var_10;
        }

        scripts\engine\utility::delaycall(0.2, ::playsound, "loot_pickup_offhand");
      } else
        waitframe();

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
          foreach(var_2 in self.item_models) {
            if(isDefined(var_2))
              var_2 delete();
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

waittill_offhand_box_accessed() {
  var_0 = undefined;

  if(self.item_type == "ammo") {
    var_1 = 0;
    var_2 = level.player getweaponslistprimaries();

    foreach(var_4 in var_2) {
      var_5 = level.player getweaponammostock(var_4);
      var_6 = weaponmaxammo(var_4);

      if(var_5 < var_6) {
        var_1 = 1;
        break;
      }
    }
  } else
    var_1 = !level.player hasweapon(self.item_type) || level.player hasweapon(self.item_type) && level.player get_player_offhand_ammo(self.item_type) < level.player get_player_offhand_max_ammo(self.item_type);

  if(var_1) {
    var_8 = 256;

    if(isDefined(self.radius))
      var_8 = int(self.radius);

    var_9 = get_offhand_item_pickup_hint(self.item_type == "ammo" || level.player hasweapon(self.item_type));

    if(level.script == "proxywar") {
      var_10 = (10, 0, 10);
      var_11 = 60;
    } else {
      var_10 = (0, 0, 10);
      var_11 = 35;

      if(self.item_type == "ammo")
        var_10 = (0, 0, 12);
    }

    self.interact = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_origin"));
    self.interact linkTo(self, "tag_origin");
    self.interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", var_10, var_9, var_11, var_8, 90, 0, undefined, undefined, self.icon, "duration_none", undefined, undefined, 30);
    self.interact notsolid();
    var_0 = self.interact scripts\engine\utility::waittill_any_return("trigger", "offhand_box_update");
  }

  return var_0;
}

update_offhand_box_item_models() {
  self endon("death");
  self endon("entitydeleted");
  self endon("offhand_box_kill");

  for(;;) {
    self.item_models = scripts\engine\utility::array_removeundefined(self.item_models);

    for(var_0 = get_offhand_item_model(); self.item_models.size != self.item_count; self.item_models = scripts\engine\utility::array_removeundefined(self.item_models)) {
      if(self.item_count > self.item_models.size) {
        var_1 = get_offhand_box_item_slot_struct();
        var_2 = spawn("script_model", var_1.origin);
        var_2.angles = var_1.angles;
        var_1.item = var_2;
        var_2 setModel(var_0);
        self.item_models[self.item_models.size] = var_2;
        continue;
      }

      if(isDefined(self.item_models[0])) {
        foreach(var_4 in self.item_pos_array) {
          if(isDefined(var_4.item) && var_4.item == self.item_models[0])
            var_4.item = undefined;
        }

        self.item_models[0] delete();
      }
    }

    foreach(var_7 in self.item_models) {
      if(var_7.model != var_0)
        var_7 setModel(var_0);
    }

    waitframe();
  }
}

get_offhand_box_item_slot_struct() {
  foreach(var_1 in self.item_pos_array) {
    if(isDefined(var_1) && !isDefined(var_1.item))
      return var_1;
  }

  return undefined;
}

get_offhand_item_pickup_hint(var_0) {
  var_1 = "Pickup";
  self.icon = undefined;

  if(!isDefined(var_0))
    var_0 = 0;

  if(self.item_type == "ammo") {
    var_1 = &"GAME/TAKE_AMMO";
    self.icon = "hud_icon_ammo";
  } else if(self.item_type == "flash") {
    var_1 = &"GAME/TAKE_FLASH";
    self.icon = "hud_icon_equipment_flash";
  } else {
    if(!var_0)
      var_0 = level.player getoffhandprimaryclass() == "none";

    if(self.item_type == "molotov") {
      if(var_0)
        var_1 = &"GAME/TAKE_MOLOTOV";
      else
        var_1 = &"GAME/SWAP_MOLOTOV";

      self.icon = "hud_icon_equipment_molotov";
    } else if(self.item_type == "semtex") {
      if(var_0)
        var_1 = &"GAME/TAKE_SEMTEX";
      else
        var_1 = &"GAME/SWAP_SEMTEX";

      self.icon = "hud_icon_equipment_semtex";
    } else if(self.item_type == "frag") {
      if(var_0)
        var_1 = &"GAME/TAKE_FRAG";
      else
        var_1 = &"GAME/SWAP_FRAG";

      self.icon = "hud_icon_equipment_frag";
    }
  }

  return var_1;
}

get_offhand_item_model() {
  var_0 = "script_origin";

  if(self.item_type == "molotov")
    var_0 = "loot_molotov";
  else if(self.item_type == "semtex")
    var_0 = "loot_semtex";
  else if(self.item_type == "frag")
    var_0 = "loot_frag";
  else if(self.item_type == "flash")
    var_0 = "loot_flash";
  else if(self.item_type == "ammo")
    var_0 = "ammo_box_plastic_sm_01";

  return var_0;
}

update_global_offhand_boxes() {
  foreach(var_1 in level.offhand_boxes) {
    if(isDefined(var_1.interact))
      var_1.interact notify("offhand_box_update");

    if(isDefined(var_1.pickup_trig))
      var_1.pickup_trig notify("offhand_box_update");
  }
}

get_player_offhand_max_ammo(var_0) {
  var_1 = get_player_offhand_weapon(var_0);
  return weaponmaxammo(var_1);
}

get_player_offhand_ammo(var_0) {
  var_1 = 0;

  foreach(var_3 in level.player.offhandinventory) {
    if(tolower(var_3.basename) == var_0) {
      var_1 = level.player getammocount(var_3);
      break;
    }
  }

  return var_1;
}

offhand_swap_return_new_ammo_count(var_0, var_1, var_2) {
  var_3 = get_player_offhand_ammo(var_0);
  take_player_offhand_by_name(var_0);
  level.player scripts\engine\sp\utility::give_offhand(var_1, var_2);
  return int(var_3);
}

take_player_offhand_by_name(var_0) {
  var_1 = get_player_offhand_weapon(var_0);
  level.player scripts\engine\sp\utility::take_offhand(var_1);
}

get_player_offhand_weapon(var_0) {
  foreach(var_2 in level.player.offhandinventory) {
    if(tolower(var_2.basename) == var_0)
      return var_2;
  }

  return undefined;
}

is_tactical(var_0) {
  return var_0 == "flash" || var_0 == "smoke";
}