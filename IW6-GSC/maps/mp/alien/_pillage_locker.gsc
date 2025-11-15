/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_pillage_locker.gsc
*********************************************/

locker_pillage_functions_init() {
  setdvar("scr_alien_locker_pillage", 1);
  level.locker_build_pillageitem_array_func = ::build_locker_pillageitem_arrays;
  level.get_hintstring_for_item_pickup_func = ::get_hintstring_for_locker_item_pickup;
  level.get_hintstring_for_pillaged_item_func = ::get_locker_hintstring_for_pillaged_item;
  level.locker_drop_item_on_ground_func = ::drop_locker_pillage_item_on_ground;

  if(!isDefined(level.custom_lockerpillageinitfunc))
    level.custom_lockerpillageinitfunc = ::locker_pillage_init;

  if(!isDefined(level.level_specific_pillage_show_func))
    level.level_specific_pillage_show_func = ::default_level_specific_pillage_show_func;

  level.locker_key_check_func = ::locker_key_check;
}

locker_pillage_init() {
  level.pillageinfo.locker_key_model = "vehicle_pickup_keys";
  level.pillageinfo.locker_attachment = 0;
  level.pillageinfo.locker_explosive = 0;
  level.pillageinfo.locker_leash = 0;
  level.pillageinfo.locker_maxammo = 0;
  level.pillageinfo.locker_specialammo = 0;
  level.pillageinfo.locker_money = 0;
  level.pillageinfo.locker_soflam = 0;
  level.pillageinfo.locker_trophy = 0;
  level.pillageinfo.locker_locker_weapon = 100;
  var_0 = common_scripts\utility::getstructarray("pillage_area", "targetname");

  foreach(var_8, var_2 in var_0) {
    if(!isDefined(level.pillage_areas[var_8]))
      level.pillage_areas[var_8] = [];

    level.pillage_areas[var_8]["locker"] = [];
    var_3 = common_scripts\utility::getstructarray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      if(isDefined(var_5.script_noteworthy)) {
        var_6 = strtok(var_5.script_noteworthy, ",");
        var_5.pillage_type = var_6[0];

        if(isDefined(var_6[1]))
          var_5.script_model = var_6[1];

        switch (var_5.pillage_type) {
          case "locker":
            level.pillage_areas[var_8]["locker"][level.pillage_areas[var_8]["locker"].size] = var_5;
            var_5.is_locker = 1;
            var_5.drop_override_func = ::drop_locker_pillage_item_on_ground;
            break;
        }
      }
    }
  }

  foreach(var_8, var_2 in level.pillage_areas) {
    level maps\mp\alien\_pillage::create_pillage_spots(level.pillage_areas[var_8]["locker"]);
    level set_locker_hint_strings(level.pillage_areas[var_8]["locker"]);
  }

  maps\mp\alien\_pillage::build_pillageitem_arrays("locker");
  create_gun_with_max_attachments_list();
}

debug_locker_weapons() {
  wait 10;

  foreach(var_1 in level.max_weapon_list) {}

  foreach(var_1 in level.max_weapon_list_xmags) {}
}

set_locker_hint_strings(var_0) {
  foreach(var_3, var_2 in var_0)
  var_2.pillage_trigger sethintstring(&"ALIEN_PILLAGE_LOCKER_OPEN_LOCKER");
}

default_level_specific_pillage_show_func(var_0, var_1, var_2) {
  switch (var_1) {
    case "searched":
      if(isDefined(var_2)) {
        switch (var_2.type) {
          case "locker_key":
            var_3 = maps\mp\alien\_pillage::get_hintstring_for_pillaged_item(var_2.type);
            var_0 thread maps\mp\alien\_pillage::show_pillage_text(var_3);
            self.pillage_trigger setModel(level.pillageinfo.locker_key_model);
            var_3 = maps\mp\alien\_pillage::get_hintstring_for_item_pickup(var_2.type);
            self.pillage_trigger sethintstring(var_3);
            self.pillage_trigger makeusable();
            self.pillageinfo.type = "locker_key";
            self.pillageinfo.ammo = 1;
            level thread maps\mp\alien\_music_and_dialog::playvoforpillage(var_0);
            break;
          case "locker_weapon":
            var_3 = maps\mp\alien\_pillage::get_hintstring_for_pillaged_item(var_2.type);
            var_0 thread maps\mp\alien\_pillage::show_pillage_text(var_3);

            if(var_0 maps\mp\alien\_persistence::is_upgrade_enabled("master_scavenger_upgrade"))
              var_4 = common_scripts\utility::array_combine(level.max_weapon_list, level.max_weapon_list_xmags);
            else
              var_4 = level.max_weapon_list;

            var_5 = common_scripts\utility::random(var_4);
            var_6 = 0;

            while(isDefined(var_0.last_locker_weapon) && var_0.last_locker_weapon == var_5.model) {
              var_5 = common_scripts\utility::random(var_4);
              var_6++;

              if(var_6 % 10 == 0) {
                break;
              }
            }

            var_0.last_locker_weapon = var_5.model;
            self.pillage_trigger setModel(var_5.model);
            var_3 = maps\mp\alien\_pillage::get_hintstring_for_item_pickup(var_5.model);
            self.pillage_trigger sethintstring(var_3);
            self.pillage_trigger makeusable();
            self.pillageinfo.type = "locker_weapon";
            self.pillageinfo.ammo = 1;
            self.pillageinfo.weapon_item = var_5;
            self.pillageinfo.weapon_string = var_5.weapon_string;
            maps\mp\_utility::delaythread(1.0, maps\mp\alien\_music_and_dialog::playvoforpillage, var_0);
            break;
        }
      }

      break;
    case "pick_up":
      if(isDefined(self.pillageinfo)) {
        switch (self.pillageinfo.type) {
          case "locker_key":
            var_0 try_to_give_player_the_locker_key(self.pillage_trigger);
            break;
          case "locker_weapon":
            var_7 = var_0 try_to_give_player_locker_weapon(self);

            if(var_7)
              maps\mp\alien\_pillage::delete_pillage_trigger();

            break;
        }
      }

      break;
  }
}

try_to_give_player_locker_weapon(var_0) {
  var_1 = var_0.pillageinfo.weapon_string;
  var_2 = spawnStruct();
  var_2.data["cost"] = 0;
  var_2.item_ref = "weapon_" + var_1;

  if(maps\mp\alien\_collectibles::cangive_weapon(var_2)) {
    var_3 = 0;
    var_4 = 0;
    var_5 = 0;

    if(maps\mp\alien\_collectibles::has_weapon_variation(var_1)) {
      var_6 = maps\mp\alien\_collectibles::get_weapon_ref(var_1);

      if(isDefined(var_6)) {
        if(isDefined(level.locker_ark_check_func))
          var_2.item_ref = [
            [level.locker_ark_check_func]
          ](var_6, var_1);

        var_4 = self getweaponammoclip(var_6);
        var_5 = self getweaponammostock(var_6);
        self takeweapon(var_6);
        var_7 = maps\mp\alien\_utility::getrawbaseweaponname(var_6);

        if(maps\mp\alien\_utility::player_has_specialized_ammo(var_7)) {
          if(isDefined(self.stored_ammo[var_7]))
            var_3 = 1;
        }
      }
    }

    self.locker_weapon = undefined;
    maps\mp\alien\_collectibles::give_weapon(var_2, 1);
    thread give_player_max_ammo(var_3, var_4, var_5);
    return 1;
  }

  return 0;
}

give_player_max_ammo(var_0, var_1, var_2) {
  self waittill("weapon_change");
  var_3 = self.locker_weapon;
  var_4 = weaponclipsize(var_3);
  var_5 = maps\mp\alien\_utility::return_nerf_scaled_ammo(var_3);

  if(isDefined(var_3) && var_0) {
    var_6 = maps\mp\alien\_utility::getrawbaseweaponname(var_3);
    self.stored_ammo[var_6].ammostock = var_5;
    self.stored_ammo[var_6].clipammo = var_4;
    self setweaponammoclip(var_3, var_1);
    self setweaponammostock(var_3, var_2);
  } else {
    self setweaponammoclip(var_3, var_4);
    self setweaponammostock(var_3, var_5);
  }
}

try_to_give_player_the_locker_key(var_0) {
  if(isDefined(self.locker_key))
    maps\mp\_utility::setlowermessage("max_leash", & "ALIEN_PILLAGE_LOCKER_LOCKER_KEY_MAX", 3);
  else {
    self.locker_key = 1;
    self playlocalsound("plr_keys_pckup");
    self setclientomnvar("ui_alien_locker_key", 1);

    if(maps\mp\alien\_utility::alien_mode_has("outline"))
      maps\mp\alien\_outline_proto::remove_from_outline_pillage_watch_list(var_0);

    var_0 delete();
  }
}

build_locker_pillageitem_arrays(var_0) {
  if(!isDefined(level.pillageitems))
    level.pillageitems = [];

  if(!isDefined(level.pillageitems[var_0]))
    level.pillageitems[var_0] = [];

  switch (var_0) {
    case "easy":
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "locker_key", level.pillageinfo.easy_locker_key);
      break;
    case "medium":
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "locker_key", level.pillageinfo.medium_locker_key);
      break;
    case "hard":
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "locker_key", level.pillageinfo.hard_locker_key);
      break;
    case "locker":
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "crafting", level.pillageinfo.crafting_hard);
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "attachment", level.pillageinfo.locker_attachment);
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "soflam", level.pillageinfo.locker_soflam);
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "explosive", level.pillageinfo.locker_explosive);
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "maxammo", level.pillageinfo.locker_maxammo);
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "money", level.pillageinfo.locker_money);
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "pet_leash", level.pillageinfo.locker_leash);
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "trophy", level.pillageinfo.locker_trophy);
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "specialammo", level.pillageinfo.locker_specialammo);
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "locker_weapon", level.pillageinfo.locker_locker_weapon);
      break;
  }
}

locker_key_check(var_0) {
  if(isDefined(self.is_locker) && self.is_locker && (!isDefined(var_0.locker_key) || !var_0.locker_key)) {
    var_0 maps\mp\_utility::setlowermessage("need_key", & "ALIEN_PILLAGE_LOCKER_NEED_LOCKER_KEY", 3);
    return 1;
  }

  return 0;
}

get_locker_hintstring_for_pillaged_item(var_0) {
  var_0 = "" + var_0;

  switch (var_0) {
    case "locker_key":
      return & "ALIEN_PILLAGE_LOCKER_FOUND_LOCKER_KEY";
    case "locker_weapon":
      return & "ALIEN_PILLAGE_LOCKER_FOUND_LOCKER_WEAPON";
  }
}

get_hintstring_for_locker_item_pickup(var_0) {
  var_0 = "" + var_0;

  switch (var_0) {
    case "locker_key":
      return & "ALIEN_PILLAGE_LOCKER_PICKUP_LOCKER_KEY";
    case "locker_weapon":
      return & "ALIEN_PILLAGE_LOCKER_PICKUP_LOCKER_WEAPON";
  }

  if(isDefined(level.level_locker_weapon_pickup_string_func))
    return [[level.level_locker_weapon_pickup_string_func]](var_0);
}

drop_locker_pillage_item_on_ground(var_0) {
  if(!isDefined(self.open_locker_model)) {
    var_1 = spawn("script_model", self.origin);
    var_1.angles = self.angles;

    if(level.script == "mp_alien_dlc3") {
      var_1 setModel("com_plasticcase_bomb_open");
      var_0 playlocalsound("ammo_crate_use");
    } else if(level.script == "mp_alien_last") {
      var_1 setModel("dct_crate_locker_open");
      var_0 playlocalsound("ammo_crate_use");
    } else {
      var_1 setModel("armory_weapon_chest_open");
      var_0 playlocalsound("plr_locker_open");
    }

    self.open_locker_model = var_1;
    self.locker_origin = self.pillage_trigger.origin;
    self.locker_angles = self.pillage_trigger.angles;
  }

  if(self.pillage_trigger.model != "tag_origin") {
    if(isDefined(level.pillage_locker_offset_override_func))
      self[[level.pillage_locker_offset_override_func]]();
    else
      offset_locker_trigger_model();
  }

  var_0.locker_key = undefined;
  self.pillage_trigger.is_locker = undefined;
  var_0 setclientomnvar("ui_alien_locker_key", 0);
}

offset_locker_trigger_model() {
  if(isDefined(self.locker_origin))
    self.pillage_trigger.origin = self.locker_origin;

  if(isDefined(self.locker_angles))
    self.pillage_trigger.angles = self.locker_angles;

  var_0 = (0, 0, 20);
  var_1 = (0, 0, 6);
  var_2 = (0, 0, 0);
  var_3 = (0, 0, 6);
  var_4 = (0, 0, 0);
  var_5 = getgroundposition(self.pillage_trigger.origin + var_0, 2);

  switch (self.pillage_trigger.model) {
    case "weapon_baseweapon_clip":
      var_3 = (0, 0, 4);
      break;
    case "mp_trophy_system_folded_iw6":
      var_3 = (3, -21, 38);
      var_4 = (277.5, 180, -144);
      break;
    case "weapon_scavenger_grenadebag":
      var_3 = (0, 0, 6);
      break;
    case "weapon_soflam":
      var_3 = (8, -6, 8);
      break;
    case "mil_ammo_case_1_open":
      var_3 = (0, -16, 0);
      break;
    case "weapon_rm_22":
      self.pillage_trigger hidepart("tag_barrel_sniper", "weapon_rm_22");
    case "weapon_pp19_bizon_iw6":
    case "weapon_fabarm_fp6":
    case "weapon_world_axe":
    case "weapon_imbel_ia2":
    case "weapon_cz_805_bren":
    case "weapon_m27":
    case "weapon_l115a3":
    case "weapon_usr":
    case "weapon_vks":
    case "weapon_mts_255":
    case "weapon_vepr":
    case "weapon_kriss_v":
    case "weapon_ak12":
    case "weapon_g28":
    case "weapon_dragunov_svu":
    case "weapon_tar21":
    case "weapon_kac_chainsaw":
      var_3 = (-5, 0, 24);
      var_4 = (277.5, 180, -144);
      break;
    case "weapon_maul":
      var_3 = (-5, 0, 25);
      var_4 = (277.5, 180, -144);
      break;
    case "weapon_honeybadger":
      var_3 = (-5, 0, 21);
      var_4 = (277.5, 180, -144);
      break;
    case "weapon_evopro":
    case "weapon_cbj_ms_iw6":
    case "weapon_lsat_iw6":
    case "weapon_arx_160":
      var_3 = (-5, 0, 22);
      var_4 = (277.5, 180, -144);
      break;
    case "weapon_knife_iw6":
    case "weapon_canister_bomb":
    case "mil_emergency_flare_mp":
      var_3 = var_1;
      var_4 = var_2;
      break;
  }

  var_6 = self.pillage_trigger.origin;
  var_7 = self.pillage_trigger.angles;
  var_8 = self.pillage_trigger.origin;
  var_9 = (0, 0, 0);
  var_10 = self.pillage_trigger.origin + var_3;
  var_11 = var_4;
  var_12 = transformmove(var_6, var_7, var_8, var_9, var_10, var_11);
  var_13 = var_12["origin"] - var_5;
  var_4 = var_12["angles"];
  self.pillage_trigger.origin = var_5 + var_13;
  self.pillage_trigger.angles = var_4;
}

create_gun_with_max_attachments_list() {
  level.max_weapon_list = [];
  level.max_weapon_list_xmags = [];
  var_0 = [];
  var_1 = level.collectibles;

  foreach(var_4, var_3 in var_1) {
    if(var_3.isweapon)
      var_0[var_4] = var_3;
  }

  var_5 = [];

  foreach(var_3 in var_0) {
    var_7 = var_3.ref;

    if(issubstr(var_3.ref, "honey")) {
      continue;
    }
    if(level.script == "mp_alien_beacon") {
      if(issubstr(var_3.ref, "g28") || issubstr(var_3.ref, "svu"))
        continue;
    }

    var_7 = getsubstr(var_7, 7);

    if(is_dlc_weapon(var_3.ref))
      var_8 = var_7;
    else
      var_8 = getweaponbasename(var_7);

    var_9 = maps\mp\_utility::getweaponclass(var_8);
    var_10 = [];
    var_11 = [];
    var_12 = [];
    var_13 = [];
    var_14 = maps\mp\alien\_pillage::get_possible_attachments_by_weaponclass(var_9, var_8);

    if(!isDefined(var_14) || var_14.size < 3) {
      continue;
    }
    if(issubstr(var_3.ref, "aliendlc23")) {
      if(level.script == "mp_alien_dlc3" || level.script == "mp_alien_last")
        var_8 = "iw6_arkaliendlc23_mp";
      else
        var_8 = "iw6_aliendlc23_mp";

      var_14 = common_scripts\utility::add_to_array(var_14, "dlcweap02scope");
    }

    foreach(var_16 in var_14) {
      switch (var_16) {
        case "reflex":
        case "eotech":
        case "acog":
        case "dlcweap02scope":
          var_10[var_10.size] = var_16;
          break;
        case "grip":
          var_11[var_11.size] = var_16;
          break;
        case "barrelrange":
          var_12[var_12.size] = var_16;
          break;
        case "xmags":
        case "rof":
          var_13[var_13.size] = var_16;
          break;
        default:
          break;
      }
    }

    var_18 = [];

    if(var_10.size > 0)
      var_18[0] = var_10;
    else
      var_18[var_18.size] = ["none"];

    if(var_11.size > 0)
      var_18[1] = var_11;
    else
      var_18[var_18.size] = ["none"];

    if(var_12.size > 0)
      var_18[2] = var_12;
    else
      var_18[var_18.size] = ["none"];

    if(var_13.size > 0)
      var_18[3] = var_13;
    else
      var_18[var_18.size] = ["none"];

    var_3 get_rest_of_attachments_brute_force(var_8, var_18);
  }
}

make_weapon_string_and_add_to_array(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_6 = maps\mp\_utility::strip_suffix(var_0, "_mp");
  var_7 = maps\mp\alien\_utility::buildalienweaponname(var_6, var_1, var_2, var_3, var_4);

  if(isDefined(var_7)) {
    var_8 = spawnStruct();
    var_8.weapon_string = var_7;
    var_8.model = var_5.model;

    if(!isDefined(var_4) || var_4 != "xmags")
      level.max_weapon_list[level.max_weapon_list.size] = var_8;
    else
      level.max_weapon_list_xmags[level.max_weapon_list_xmags.size] = var_8;
  }
}

get_rest_of_attachments_brute_force(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1[0]) {
    var_2[0] = var_4;

    foreach(var_4 in var_1[1]) {
      var_2[1] = var_4;

      foreach(var_4 in var_1[2]) {
        var_2[2] = var_4;

        foreach(var_4 in var_1[3]) {
          var_2[3] = var_4;
          make_weapon_string_and_add_to_array(var_0, var_2[0], var_2[1], var_2[2], var_2[3]);
        }
      }
    }
  }
}

get_locker_weapon_from_list() {
  var_0 = common_scripts\utility::random(level.max_weapon_list);
  return var_0;
}

is_dlc_weapon(var_0) {
  if(issubstr(var_0, "aliendlc"))
    return 1;

  if(issubstr(var_0, "alienDLC"))
    return 1;

  return 0;
}

is_axe(var_0) {
  switch (var_0) {
    case "iw6_alienDLC13_mp":
    case "weapon_iw6_alienDLC13_mp":
    case "iw6_aliendlc13_mp":
    case "weapon_iw6_aliendlc13_mp":
    case "alienaxe_mp":
    case "weapon_alienaxe_mp":
    case "iw6_alienDLC12_mp":
    case "weapon_iw6_alienDLC12_mp":
    case "iw6_aliendlc12_mp":
    case "weapon_iw6_aliendlc12_mp":
      return 1;
    default:
      break;
  }

  return 0;
}