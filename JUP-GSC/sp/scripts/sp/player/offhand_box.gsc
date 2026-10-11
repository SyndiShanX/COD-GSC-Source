/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\player\offhand_box.gsc
************************************************/

#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\equipment\offhands;
#using scripts\sp\hud_util;
#using scripts\sp\loot;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace offhand_box;

function offhand_box_setup() {
  flag_wait("load_finished");
  level.offhand_boxes = getEntArray("offhand_box", "targetname");

  if(!istrue(1)) {
    if(isDefined(level.offhand_boxes)) {
      foreach(offhand_box in level.offhand_boxes) {
        offhand_box delete();
      }
    }

    return;
  }

  array_thread(level.offhand_boxes, &offhand_box_think);
}

function offhand_box_think() {
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
  thread update_offhand_box_item_models();

  if(!isDefined(self.script_noteworthy)) {
    thread function_863bc5d68813ee8a(360);
    return;
  }

  self.item_type = self.script_noteworthy;
  thread function_250357933f00dc3();
}

function private function_250357933f00dc3() {
  self endon("death");
  self endon("entitydeleted");
  assert(isDefined(self.item_type));
  offhand_type = undefined;

  if(self.item_type != "ammo" && self.item_type != "armor_plates") {
    offhandweaponname = scripts\sp\loot::getoffhandweaponname(self.item_type);
    assert(scripts\sp\equipment\offhands::offhandisprecached(offhandweaponname));
    offhand_type = getweaponoffhandtype(offhandweaponname);
  }

  self notify("update_models");

  while(true) {
    result = waittill_offhand_box_accessed();

    if(isDefined(result)) {
      if(result == "offhand_loot_change") {
        if(isDefined(self.interact)) {
          self.interact remove_cursor_hint();
        }

        waitframe();
        continue;
      }

      if(result == "offhand_box_update") {
        if(isDefined(self.interact)) {
          self.interact remove_cursor_hint();
        }

        foreach(item_model in self.item_models) {
          item_model delete();
        }

        waitframe();
        self notify("update_models");
        continue;
      }

      if(function_a4482d0d3055db9a()) {
        scripts\sp\analytics::analytics_event_upload("offhand_box", self.item_type);

        if(self.item_type == "ammo") {
          weapons = level.player getweaponslistprimaries();
          refilled = 0;

          foreach(weapon in weapons) {
            oldammocount = level.player getammocount(weapon);
            level.player givemaxammo(weapon);
            newammocount = level.player getammocount(weapon);

            if(oldammocount != newammocount) {
              refilled = 1;
            }
          }

          if(refilled && !istrue(self.infinite)) {
            self.item_count = 0;
          } else {
            waitframe();
            continue;
          }
        } else if(self.item_type == "armor_plates") {
          currplayerplates = level.player scripts\sp\player::function_85e373bb15921966();
          var_b292f33e2fd2bdbd = level.player scripts\sp\player::function_c241aeec324282f0();
          var_75e244e5f45c894d = var_b292f33e2fd2bdbd - currplayerplates;
          var_b46066922139e5c2 = self.item_count;
          var_75e244e5f45c894d = int(min(var_b46066922139e5c2, var_75e244e5f45c894d));
          refillamount = currplayerplates + var_75e244e5f45c894d;
          level.player scripts\sp\player::function_e9e42cffedaa98d5(refillamount);
          self.item_count = var_b46066922139e5c2 - var_75e244e5f45c894d;
        } else if(issharedfuncdefined("offhandBox", "_onUse", 0)) {
          level.player[[getsharedfunc("offhandBox", "_onUse")]](self);
        } else {
          offhandweaponname = scripts\sp\loot::getoffhandweaponname(self.item_type);

          if(level.player scripts\sp\loot::has_weapon(offhandweaponname)) {
            lootname = self.item_type;
            current_ammo = scripts\sp\loot::getoffhandcurrentammo(lootname);
            max_ammo = scripts\sp\loot::function_57888d406854dc7f(lootname);
            ammo_needed = max_ammo - current_ammo;

            if(ammo_needed > self.item_count) {
              ammo_needed = self.item_count;
            }

            playersoffhand = undefined;

            foreach(offhand in level.player.offhandinventory) {
              if(offhand.basename == offhandweaponname) {
                playersoffhand = offhand;
                break;
              }
            }

            assert(isDefined(playersoffhand));
            level.player setweaponammoclip(playersoffhand, current_ammo + ammo_needed);
            self.item_count -= ammo_needed;
            thread scripts\sp\loot::createnotification(lootname);
          } else {
            current_offhand = function_105e215e72df8f98(offhand_type);
            current_ammo = 0;
            current_lootname = undefined;

            if(current_offhand != "none") {
              current_lootname = scripts\sp\loot::function_3fd5749f637651b7(current_offhand);

              if(!isDefined(current_lootname)) {
                current_ammo = 0;
              } else {
                current_ammo = scripts\sp\loot::getoffhandcurrentammo(current_lootname);
              }

              level.player take_player_offhand_by_name(current_offhand);
            }

            lootname = self.item_type;
            max_ammo = scripts\sp\loot::function_57888d406854dc7f(lootname);

            if(isDefined(current_lootname) && current_lootname != lootname) {
              ammo_needed = self.item_count;
            } else {
              ammo_needed = max_ammo - current_ammo;
            }

            if(ammo_needed > self.item_count) {
              ammo_needed = self.item_count;
            }

            level.player give_offhand(offhandweaponname, ammo_needed);

            if(current_offhand != "none") {
              self.item_count = current_ammo;
              self.item_type = current_lootname;
              thread update_global_offhand_boxes();
            } else {
              self.item_count -= ammo_needed;
            }

            thread scripts\sp\loot::createnotification(lootname);
          }
        }

        delaycall(0.2, &playsound, "loot_pickup_offhand");
      } else {
        waitframe();
      }

      self notify("update_models");
      level.player notify("update_models");

      if(isDefined(self.interact)) {
        self.interact remove_cursor_hint();
      }

      level notify("offhand_box_used");
      self notify("offhand_box_used");
      level.player player_gesture_force("iw9_ges_pickup");
      wait 0.3;

      if(self.item_count == 0 && !istrue(self.infinite)) {
        self notify("offhand_box_kill");
        hudoutline_disable();
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

function private function_863bc5d68813ee8a(radius) {
  self endon("death");
  self endon("entitydeleted");
  radiussq = squared(radius);

  while(isDefined(self)) {
    wait randomfloatrange(0.5, 1);

    if(!isDefined(self)) {
      return;
    }

    foreach(player in level.players) {
      if(distancesquared(player.origin, self.origin) < radiussq) {
        spawnpool = scripts\sp\loot::getspawnpool("Offhand", "frag");

        if(spawnpool.size > 0) {
          self.item_type = spawnpool[randomintrange(0, spawnpool.size)];
          thread function_250357933f00dc3();
        }

        return;
      }
    }
  }
}

function function_a4482d0d3055db9a() {
  if(self.item_type == "ammo") {
    return true;
  }

  if(self.item_type == "armor_plates" && utility::playerarmorenabled()) {
    return true;
  }

  weaponname = scripts\sp\loot::getoffhandweaponname(self.item_type);

  if(isDefined(weaponname) && scripts\sp\equipment\offhands::offhandisprecached(weaponname)) {
    return true;
  }

  return false;
}

function private function_d5eecb716a502c5f(lootitem) {
  player = level.player;
  offhandweaponname = scripts\sp\loot::getoffhandweaponname(lootitem.item_type);

  if(isDefined(offhandweaponname)) {
    return player scripts\sp\loot::has_weapon(offhandweaponname);
  }

  return 0;
}

function waittill_offhand_box_accessed() {
  result = undefined;

  if(self.item_type == "ammo") {
    do_interact = 1;
  } else if(self.item_type == "armor_plates") {
    do_interact = utility::playerarmorenabled() && level.player scripts\sp\player::function_c241aeec324282f0() != level.player scripts\sp\player::function_85e373bb15921966();
  } else {
    do_interact = 0;

    if(issharedfuncdefined("offhandBox", "_allowUse", 0)) {
      do_interact = level.player[[getsharedfunc("offhandBox", "_allowUse")]](self);
    } else {
      do_interact = !function_d5eecb716a502c5f(self) || scripts\sp\loot::getoffhandcurrentammo(self.item_type) < scripts\sp\loot::function_57888d406854dc7f(self.item_type);
    }
  }

  if(do_interact) {
    visible_dist = 256;

    if(isDefined(self.radius)) {
      visible_dist = int(self.radius);
    }

    pickup_hint = get_offhand_item_pickup_hint(self.item_type == "ammo" || function_d5eecb716a502c5f(self));
    cursor_offset = (0, 0, 10);
    fov_override = 35;

    if(self.item_type == "ammo") {
      cursor_offset = (0, 0, 12);
    }

    if(self.model == "un_military_backpack_open_01") {
      cursor_offset = (10, 7, 10);
    } else if(self.model == "un_military_storage_container_small_open_01") {
      cursor_offset = (12, 7, 17);
    } else if(self.model == "un_military_storage_container_02_open") {
      cursor_offset = (14, 8, 25);
    }

    self.interact = spawn_tag_origin(self gettagorigin("tag_origin"));
    self.interact linkTo(self, "tag_origin");
    self.interact create_cursor_hint("tag_origin", cursor_offset, pickup_hint, fov_override, visible_dist, 90, 0, undefined, undefined, self.icon, "duration_none", undefined, undefined, 30);
    self.interact notsolid();
    result = level.player waittill_any_ents_return(self.interact, "trigger", self.interact, "offhand_box_update", level.player, "offhand_loot_change");
  }

  return result;
}

function function_dce9c4c9d68ad200() {
  if(istrue(self.var_2a055f031d3ee403)) {
    return;
  }

  foreach(model in self.item_models) {
    if(model != "lm_loot_wm_armor_plate_iw9_carbon_fiber" && model != "empty_model") {
      return;
    }

    if(model == "lm_loot_wm_armor_plate_iw9_carbon_fiber") {
      model.angles += (0, 90, 0);
    }
  }

  self.var_2a055f031d3ee403 = 1;
}

function update_offhand_box_item_models() {
  self endon("death");
  self endon("entitydeleted");
  self endon("offhand_box_kill");

  while(true) {
    self.item_models = array_removeundefined(self.item_models);
    var_dd53030b256aa23b = get_offhand_item_model();
    function_dce9c4c9d68ad200();

    while(self.item_models.size != self.item_count) {
      if(self.item_count > self.item_models.size) {
        var_8acc266afda40d29 = get_offhand_box_item_slot_struct();
        model = spawn("script_model", var_8acc266afda40d29.origin);

        if(!istrue(self.var_2a055f031d3ee403)) {
          model.angles = var_8acc266afda40d29.angles;
        }

        var_8acc266afda40d29.item = model;
        model setModel(var_dd53030b256aa23b);
        self.item_models[self.item_models.size] = model;
      } else if(isDefined(self.item_models[0])) {
        foreach(pos_struct in self.item_pos_array) {
          if(isDefined(pos_struct.item) && pos_struct.item == self.item_models[0]) {
            pos_struct.item = undefined;
          }
        }

        self.item_models[0] delete();
      }

      self.item_models = array_removeundefined(self.item_models);
    }

    foreach(item_model in self.item_models) {
      if(item_model.model != var_dd53030b256aa23b) {
        item_model setModel(var_dd53030b256aa23b);
      }
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

function get_offhand_item_pickup_hint(already_has) {
  pickup_hint = "Pickup";
  pickup_hint = &"EQUIPMENT/IMPROVISED_MINE_PICKUP";
  self.icon = undefined;

  if(!isDefined(already_has)) {
    already_has = 0;
  }

  if(!already_has) {
    already_has = level.player getoffhandprimaryclass() == "none";
  }

  if(isDefined(level.loot.types[self.item_type])) {
    loot = level.loot.types[self.item_type];

    if(isDefined(loot.hinttake)) {
      pickup_hint = loot.hinttake;
    }

    self.icon = loot.shader;

    if(isDefined(loot.weapongrenade) && !already_has && isDefined(loot.hintswap)) {
      pickup_hint = loot.hintswap;
    }
  }

  return pickup_hint;
}

function get_offhand_item_model() {
  item_model = "empty_model";

  if(isDefined(self.item_type) && isDefined(level.loot.types[self.item_type])) {
    loot = level.loot.types[self.item_type];

    if(isDefined(loot.model)) {
      item_model = loot.model;
    }
  }

  return item_model;
}

function update_global_offhand_boxes() {
  foreach(offhand_box in level.offhand_boxes) {
    if(isDefined(offhand_box.interact)) {
      offhand_box.interact notify("offhand_box_update");
    }

    if(isDefined(offhand_box.pickup_trig)) {
      offhand_box.pickup_trig notify("offhand_box_update");
    }
  }
}

function function_105e215e72df8f98(offhand_type) {
  foreach(offhand in level.player.offhandinventory) {
    if(level.player getoffhandslot(offhand) == offhand_type) {
      return offhand.basename;
    }
  }

  return "none";
}

function take_player_offhand_by_name(weapon_name) {
  cur_offhand = get_player_offhand_weapon(weapon_name);
  level.player take_offhand(cur_offhand);
}

function get_player_offhand_weapon(weapon_name) {
  foreach(offhand in level.player.offhandinventory) {
    if(tolower(offhand.basename) == weapon_name) {
      return offhand;
    }
  }

  return undefined;
}