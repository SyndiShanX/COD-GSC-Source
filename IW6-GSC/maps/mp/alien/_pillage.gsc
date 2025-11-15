/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_pillage.gsc
**************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\alien\_utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\alien\_persistence;

UI_SEARCHING = 1;

build_pillageitem_arrays(category) {
  if(!isDefined(level.pillageitems))
    level.pillageitems = [];

  if(!isDefined(level.pillageitems[category]))
    level.pillageitems[category] = [];

  switch (category) {
    case "easy":
      build_pillageitem_array(category, "attachment", level.pillageInfo.easy_attachment);
      build_pillageitem_array(category, "soflam", level.pillageInfo.easy_soflam);
      build_pillageitem_array(category, "explosive", level.pillageInfo.easy_explosive);
      build_pillageitem_array(category, "clip", level.pillageInfo.easy_clip);
      build_pillageitem_array(category, "money", level.pillageInfo.easy_money);
      build_pillageitem_array(category, "pet_leash", level.pillageInfo.easy_leash);
      build_pillageitem_array(category, "specialammo", level.pillageInfo.easy_specialammo);
      break;

    case "medium":
      build_pillageitem_array(category, "attachment", level.pillageInfo.medium_attachment);
      build_pillageitem_array(category, "explosive", level.pillageInfo.medium_explosive);
      build_pillageitem_array(category, "soflam", level.pillageInfo.medium_soflam);
      build_pillageitem_array(category, "clip", level.pillageInfo.medium_clip);
      build_pillageitem_array(category, "money", level.pillageInfo.medium_money);
      build_pillageitem_array(category, "pet_leash", level.pillageInfo.medium_leash);
      build_pillageitem_array(category, "trophy", level.pillageInfo.medium_trophy);
      build_pillageitem_array(category, "specialammo", level.pillageInfo.medium_specialammo);
      break;

    case "hard":
      build_pillageitem_array(category, "attachment", level.pillageInfo.hard_attachment);
      build_pillageitem_array(category, "soflam", level.pillageInfo.hard_soflam);
      build_pillageitem_array(category, "explosive", level.pillageInfo.hard_explosive);
      build_pillageitem_array(category, "maxammo", level.pillageInfo.hard_maxammo);
      build_pillageitem_array(category, "money", level.pillageInfo.hard_money);
      build_pillageitem_array(category, "pet_leash", level.pillageInfo.hard_leash);
      build_pillageitem_array(category, "trophy", level.pillageInfo.hard_trophy);
      build_pillageitem_array(category, "specialammo", level.pillageInfo.hard_specialammo);
      break;
  }

  if(isDefined(level.custom_build_pillageitem_array_func)) {
    [[level.custom_build_pillageitem_array_func]](category);
  }

  if(isDefined(level.locker_build_pillageitem_array_func)) {
    [[level.locker_build_pillageitem_array_func]](category);
  }
}

build_pillageitem_array(category, item_ref, item_chance) {
  if(!isDefined(item_chance))
    return;
  item_info = spawnStruct();
  item_info.ref = item_ref;
  item_info.chance = item_chance;
  level.pillageitems[category][level.pillageitems[category].size] = item_info;
}

pillage_init() {
  level.pillage_areas = [];

  level.pillageable_explosives = ["alienclaymore_mp", "alienbetty_mp", "alienmortar_shell_mp"];
  level.pillageable_attachments = ["reflex", "eotech", "rof", "grip", "barrelrange", "acog", "firetypeburst", "xmags", "alienmuzzlebrake"];
  level.pillageable_attachments_dmr = ["eotech", "reflex", "firetypeburst", "barrelrange", "acog", "xmags", "alienmuzzlebrake"];
  level.pillageable_attachments_sg = ["reflex", "grip", "eotech", "barrelrange", "xmags", "alienmuzzlebrake"];
  level.pillageable_attachments_sg_fp6 = ["reflex", "grip", "eotech", "barrelrange", "alienmuzzlebrake"];
  level.pillageable_attachments_ar = ["reflex", "eotech", "grip", "rof", "barrelrange", "acog", "firetypeburst", "xmags", "alienmuzzlebrake"];
  level.pillageable_attachments_ar_sc2010 = ["reflex", "eotech", "grip", "firetypeburst", "acog", "xmags", "alienmuzzlebrake"];
  level.pillageable_attachments_ar_honeybadger = ["reflex", "eotech", "grip", "rof", "acog", "firetypeburst", "xmags"];
  level.pillageable_attachments_smg_k7 = ["reflex", "eotech", "rof", "grip", "acog", "barrelrange", "xmags", "alienmuzzlebrake"];
  level.pillageable_attachments_smg = ["reflex", "eotech", "rof", "grip", "barrelrange", "acog", "xmags", "alienmuzzlebrake"];
  level.pillageable_attachments_aliendlc23 = ["rof", "grip", "barrelrange", "xmags", "alienmuzzlebrake"];
  level.pillageable_attachments_sr = ["xmags", "alienmuzzlebrake"];
  level.pillageable_attachments_lmg = ["rof", "grip", "reflex", "eotech", "acog", "barrelrange", "xmags", "alienmuzzlebrake"];
  level.pillageable_attachments_lmg_kac = ["rof", "barrelrange", "xmags", "alienmuzzlebrake"];
  level.offhand_explosives = ["alienclaymore_mp", "alienbetty_mp", "alienmortar_shell_mp", "aliensemtex_mp"];
  level.offhand_secondaries = ["alienflare_mp", "alienthrowingknife_mp", "alientrophy_mp"];

  if(isDefined(level.custom_pillageInitFunc)) {
    [[level.custom_pillageInitFunc]]();
  }

  if(isDefined(level.custom_LockerPillageInitFunc)) {
    [[level.custom_LockerPillageInitFunc]]();
  }

  level.alien_crafting_items = undefined;
  if(isDefined(level.crafting_item_table))
    level.alien_crafting_items = level.crafting_item_table;

  pillage_areas = getstructarray("pillage_area", "targetname");
  foreach(index, area in pillage_areas) {
    if(!isDefined(level.pillage_areas[index]))
      level.pillage_areas[index] = [];
    level.pillage_areas[index]["easy"] = [];
    level.pillage_areas[index]["medium"] = [];
    level.pillage_areas[index]["hard"] = [];

    pillage_spots = getstructarray(area.target, "targetname");
    foreach(spot in pillage_spots) {
      if(isDefined(spot.script_noteworthy)) {
        tokens = StrTok(spot.script_noteworthy, ",");
        spot.pillage_type = tokens[0];
        if(isDefined(tokens[1])) {
          spot.script_model = tokens[1];
        }
        if(isDefined(tokens[2])) {
          spot.default_item_type = tokens[2];
        }
        switch (spot.pillage_type) {
          case "easy":
            level.pillage_areas[index]["easy"][level.pillage_areas[index]["easy"].size] = spot;
            break;

          case "medium":
            level.pillage_areas[index]["medium"][level.pillage_areas[index]["medium"].size] = spot;
            break;

          case "hard":
            level.pillage_areas[index]["hard"][level.pillage_areas[index]["hard"].size] = spot;
            break;
        }
      }

    }
  }

  foreach(index, area in level.pillage_areas) {
    if(GetDvar("scr_debug_pillage") != "1") {
      level.pillage_areas[index]["easy"] = remove_random_pillage_spots(level.pillage_areas[index]["easy"]);
      level.pillage_areas[index]["medium"] = remove_random_pillage_spots(level.pillage_areas[index]["medium"]);
      level.pillage_areas[index]["hard"] = remove_random_pillage_spots(level.pillage_areas[index]["hard"]);
    }
    level thread create_pillage_spots(level.pillage_areas[index]["easy"]);
    level thread create_pillage_spots(level.pillage_areas[index]["medium"]);
    level thread create_pillage_spots(level.pillage_areas[index]["hard"]);

  }

  build_pillageitem_arrays("easy");
  build_pillageitem_arrays("medium");
  build_pillageitem_arrays("hard");

  level.use_alternate_specialammo_pillage_amounts = false;

  level thread debug_pillage_spots();
}

get_hintstring_for_pillaged_item(string) {
  string = "" + string;
  switch (string) {
    case "50":
      return (&"ALIEN_COLLECTIBLES_FOUND_50");
    case "100":
      return (&"ALIEN_COLLECTIBLES_FOUND_100");
    case "200":
      return (&"ALIEN_COLLECTIBLES_FOUND_200");
    case "250":
      return (&"ALIEN_COLLECTIBLES_FOUND_250");
    case "500":
      return (&"ALIEN_COLLECTIBLES_FOUND_500");
    case "alienclaymore_mp":
      return (&"ALIEN_COLLECTIBLES_FOUND_CLAYMORE");
    case "alienbetty_mp":
      return (&"ALIEN_COLLECTIBLES_FOUND_BETTY");
    case "alienmortar_shell_mp":
      return (&"ALIEN_COLLECTIBLES_FOUND_MORTARSHELL");
    case "flare":
      return (&"ALIEN_COLLECTIBLES_FOUND_FLARE");
    case "maxammo":
      return (&"ALIEN_COLLECTIBLES_FOUND_AMMO");
    case "grenade":
      return (&"ALIEN_COLLECTIBLES_FOUND_GRENADE");
    case "attachment":
    case "attachment_noGL":
      return (&"ALIEN_COLLECTIBLES_FOUND_ATTACHMENT");
    case "clip":
      return (&"ALIEN_COLLECTIBLES_FOUND_CLIP");
    case "soflam":
      return (&"ALIEN_COLLECTIBLES_FOUND_SOFLAM");
    case "pet_leash":
      return (&"ALIEN_COLLECTIBLES_FOUND_PET_LEASH");
    case "trophy":
      return (&"ALIEN_COLLECTIBLES_FOUND_TROPHY");
    case "specialammo":
    case "ap_ammo":
    case "incendiary_ammo":
    case "explosive_ammo":
    case "combined_ammo":
    case "stun_ammo":
      return (&"ALIEN_COLLECTIBLES_FOUND_SPECIALAMMO");
  }

  if(isDefined(level.get_hintstring_for_pillaged_item_func)) {
    return [[level.get_hintstring_for_pillaged_item_func]](string);
  }

}

get_hintstring_for_item_pickup(string) {
  string = "" + string;
  switch (string) {
    case "alienclaymore_mp":
      return (&"ALIEN_COLLECTIBLES_PICKUP_CLAYMORE");
    case "alienbetty_mp":
      return (&"ALIEN_COLLECTIBLES_PICKUP_BOUNCING_BETTY");
    case "alienmortar_shell_mp":
      return (&"ALIEN_COLLECTIBLES_PICKUP_MORTARSHELL");
    case "aliensemtex_mp":
      return (&"ALIEN_COLLECTIBLES_PICKUP_GRENADE");
    case "viewmodel_flare":
    case "alienflare_mp":
    case "flare":
      return (&"ALIEN_COLLECTIBLES_PICKUP_FLARE");
    case "maxammo":
      return (&"ALIEN_COLLECTIBLES_PICKUP_AMMO");
    case "money":
      return (&"ALIEN_COLLECTIBLES_PICKUP_MONEY");
    case "reflex":
      return (&"ALIEN_COLLECTIBLES_FOUND_REFLEX");
    case "reflexsmg":
      return (&"ALIEN_COLLECTIBLES_FOUND_REFLEX");
    case "eotech":
      return (&"ALIEN_COLLECTIBLES_FOUND_EOTECH");
    case "thermal":
      return (&"ALIEN_COLLECTIBLES_FOUND_THERMAL");
    case "firetypeburst":
      return (&"ALIEN_COLLECTIBLES_FOUND_FIRETYPEBURST");
    case "firetypeburstdmr":
      return (&"ALIEN_COLLECTIBLES_FOUND_FIRETYPEBURST");
    case "barrelrange":
      return (&"ALIEN_COLLECTIBLES_FOUND_BARRELRANGE");
    case "barrelrange03":
      return (&"ALIEN_COLLECTIBLES_FOUND_BARRELRANGE");
    case "rof":
      return (&"ALIEN_COLLECTIBLES_FOUND_ROF");
    case "acog":
      return (&"ALIEN_COLLECTIBLES_FOUND_ACOG");
    case "clip":
      return (&"ALIEN_COLLECTIBLES_PICKUP_CLIP");
    case "soflam":
      return (&"ALIEN_COLLECTIBLES_PICKUP_SOFLAM");
    case "grip":
      return (&"ALIEN_COLLECTIBLES_FOUND_GRIP");
    case "griphide":
      return (&"ALIEN_COLLECTIBLES_FOUND_GRIP");
    case "alienmuzzlebrakesg":
    case "alienmuzzlebrakesn":
    case "alienmuzzlebrake":
      return (&"ALIENS_PATCH_FOUND_ARK");
    case "alienthrowingknife_mp":
    case "pet_leash":
      return (&"ALIEN_COLLECTIBLES_PICKUP_PET_LEASH");
    case "trophy":
    case "alientrophy_mp":
      return (&"ALIEN_COLLECTIBLES_PICKUP_TROPHY");
    case "ap_ammo":
      return (&"ALIEN_COLLECTIBLES_PICKUP_AP_AMMO");
    case "incendiary_ammo":
      return (&"ALIEN_COLLECTIBLES_PICKUP_IN_AMMO");
    case "explosive_ammo":
      return (&"ALIEN_COLLECTIBLES_PICKUP_EXP_AMMO");
    case "stun_ammo":
      return (&"ALIEN_COLLECTIBLES_PICKUP_STUN_AMMO");
    case "combined_ammo":
      return (&"ALIENS_PATCH_PICKUP_COMBINED_AMMO");
    case "xmags":
      return (&"ALIENS_PATCH_FOUND_XMAGS");
  }

  if(isDefined(level.get_hintstring_for_item_pickup_func)) {
    return [[level.get_hintstring_for_item_pickup_func]](string);
  }

}

remove_random_pillage_spots(pillage_spot_array) {
  num_spots_to_remove = int(pillage_spot_array.size * .5);
  pillage_spot_array = array_randomize(pillage_spot_array);
  newarray = [];
  for(i = 0; i < pillage_spot_array.size; i++) {
    if((i < num_spots_to_remove)) {
      pillage_spot_array[i].not_used = true;
      continue;
    }

    newarray[newarray.size] = pillage_spot_array[i];
  }
  return newarray;
}

create_pillage_spots(pillage_spot_array) {
  near_distance_check = 150 * 150;
  far_distance_check = 300 * 300;
  cosine = cos(75);
  foreach(index, spot in pillage_spot_array) {
    if(!isDefined(spot.is_locker)) {
      player_near = false;
      any_player_near = false;
      foreach(player in level.players) {
        if(Distance2DSquared(player.origin, spot.origin) < near_distance_check) {
          player_near = true;
        }
        if(!player_near && Distance2DSquared(player.origin, spot.origin) < far_distance_check) {
          player_near = within_fov(player getEye(), player.angles, spot.origin + (0, 0, 5), cosine);
        }
      }
      if(player_near) {
        any_player_near = true;
        continue;
      }
    }
    spot.pillage_trigger = spawn("script_model", spot.origin);
    if(isDefined(spot.script_model)) {
      spot.pillage_trigger setModel(spot.script_model);
      spot.pillage_trigger.angles = spot.angles;
    } else {
      spot.pillage_trigger setModel("tag_origin");
    }
    spot.pillage_trigger SetCursorHint("HINT_NOICON");
    spot.pillage_trigger MakeUsable();
    spot.pillage_trigger SetHintString(&"ALIEN_COLLECTIBLES_OPEN");

    if(isDefined(spot.is_locker) && spot.is_locker) {
      spot.pillage_trigger.angles = spot.angles;
      spot.pillage_trigger.is_locker = true;
    }

    if(alien_mode_has("outline")) {
      maps\mp\alien\_outline_proto::add_to_outline_pillage_watch_list(spot.pillage_trigger, 0);
    }

    spot thread pillage_spot_think();
    spot.enabled = true;

    if(index % 2 == 0)
      wait(.05);
  }

}

pillage_spot_think() {
  self notify("stop_pillage_spot_think");
  self endon("stop_pillage_spot_think");
  while(1) {
    self.pillage_trigger waittill("trigger", user);

    if(!isplayer(user)) {
      continue;
    }
    if(user is_holding_deployable() || user has_special_weapon()) {
      user setLowerMessage("cant_buy", & "ALIEN_COLLECTIBLES_PLAYER_HOLDING", 3);
      continue;
    }

    if(user maps\mp\alien\_prestige::prestige_getNoDeployables() == 1.0) {
      user setLowerMessage("cant_buy", & "ALIENS_PRESTIGE_NO_DEPLOYABLES_PICKUP", 3);
      continue;
    }

    if(!isDefined(user.current_crafting_recipe) && isDefined(self.default_item_type) && self.default_item_type == "crafting") {
      user setLowerMessage("cant_buy", & "ALIEN_CRAFTING_NO_RECIPE", 3);
      continue;
    }

    if(!isDefined(self.searched)) {
      if(isDefined(level.locker_key_check_func)) {
        if([
            [level.locker_key_check_func]
          ](user))
          continue;
      }

      self.pillage_trigger makeUnusable();
      self.enabled = false;

      if(self.pillage_trigger useHoldThink(user, level.pillageinfo.default_use_time)) {
        self.searched = true;
        pillaged_item = get_pillaged_item(self, user);
        self.pillage_trigger setModel("tag_origin");

        self.pillageinfo = spawnStruct();

        user maps\mp\alien\_achievement::update_scavenge_achievement();

        switch (pillaged_item.type) {
          case "money":
            if(user get_player_currency() < user.maxcurrency) {
              user give_player_currency(pillaged_item.count, undefined, undefined, true);
              self delete_pillage_trigger();

            } else {
              self.pillage_trigger setModel(level.pillageInfo.money_stack);
              string = get_hintstring_for_item_pickup(pillaged_item.type);
              self.pillage_trigger SetHintString(string);
              self.pillage_trigger makeUsable();
              self.pillageinfo.type = "money";
              self.pillageinfo.amount = pillaged_item.count;
            }
            string = get_hintstring_for_pillaged_item(pillaged_item.count);
            user thread show_pillage_text(string);
            if(pillaged_item.count == 500)
              level thread maps\mp\alien\_music_and_dialog::playVOForPillage(user);

            break;

          case "pet_leash":
            string = get_hintstring_for_pillaged_item(pillaged_item.type);
            user thread show_pillage_text(string);
            self.pillage_trigger setModel(level.pillageInfo.leash_model);
            string = get_hintstring_for_item_pickup(pillaged_item.type);
            self.pillage_trigger SetHintString(string);
            self.pillage_trigger makeUsable();
            self.pillageinfo.type = "pet_leash";
            self.pillageinfo.item = "alienthrowingknife_mp";
            self.pillageinfo.ammo = 1;
            level thread maps\mp\alien\_music_and_dialog::playVOForPillage(user);
            break;

          case "explosive":
            string = get_hintstring_for_pillaged_item(pillaged_item.explosive_type);
            user thread show_pillage_text(string);
            self.pillage_trigger setModel(GetWeaponModel(pillaged_item.explosive_type));
            string = get_hintstring_for_item_pickup(pillaged_item.explosive_type);
            self.pillage_trigger SetHintString(string);
            self.pillage_trigger makeUsable();
            self.pillageinfo.type = "explosive";
            self.pillageinfo.item = pillaged_item.explosive_type;
            self.pillageinfo.ammo = 2;
            break;

          case "grenade":
            string = get_hintstring_for_pillaged_item(pillaged_item.type);
            user thread show_pillage_text(string);
            self.pillage_trigger setModel(GetWeaponModel("aliensemtex_mp"));
            string = get_hintstring_for_item_pickup("aliensemtex_mp");
            self.pillage_trigger SetHintString(string);
            self.pillage_trigger makeUsable();
            self.pillageinfo.type = "explosive";
            self.pillageinfo.item = "aliensemtex_mp";
            self.pillageinfo.ammo = 2;
            break;

          case "flare":
            string = get_hintstring_for_pillaged_item(pillaged_item.type);
            user thread show_pillage_text(string);
            self.pillage_trigger setModel(level.pillageInfo.flare_model);
            string = get_hintstring_for_item_pickup(pillaged_item.type);
            self.pillage_trigger SetHintString(string);
            self.pillage_trigger makeUsable();
            self.pillageinfo.type = "flare";
            self.pillageinfo.item = "alienflare_mp";
            self.pillageinfo.ammo = 1;
            level thread maps\mp\alien\_music_and_dialog::playVOForPillage(user);
            break;

          case "attachment_noGL":
          case "attachment":
            string = get_hintstring_for_pillaged_item(pillaged_item.type);
            user thread show_pillage_text(string);

            attach_found = user get_attachment_for_weapon();

            if(getdvar("scr_force_pillageitem") != "") {
              attach_found = pillaged_item.forced_attachment;
              SetDevDvar("scr_force_pillageitem", "");
            }

            if(attach_found == "alienmuzzlebrake")
              self.pillage_trigger setModel(level.pillageInfo.alienattachment_model);
            else
              self.pillage_trigger setModel(level.pillageInfo.attachment_model);

            string = get_hintstring_for_item_pickup(attach_found);
            self.pillage_trigger SetHintString(string);
            self.pillage_trigger makeUsable();
            self.pillageinfo.type = "attachment";
            self.pillageinfo.attachment = attach_found;
            break;

          case "maxammo":
            string = get_hintstring_for_pillaged_item(pillaged_item.type);
            user thread show_pillage_text(string);
            self.pillage_trigger setModel(level.pillageInfo.maxammo_model);
            string = get_hintstring_for_item_pickup("maxammo");
            self.pillage_trigger SetHintString(string);
            self.pillage_trigger makeUsable();
            self.pillageinfo.type = "maxammo";
            level thread maps\mp\alien\_music_and_dialog::playVOForPillage(user);
            break;

          case "clip":
            string = get_hintstring_for_pillaged_item(pillaged_item.type);
            user thread show_pillage_text(string);
            self.pillage_trigger setModel(level.pillageInfo.clip_model);
            string = get_hintstring_for_item_pickup(pillaged_item.type);
            self.pillage_trigger SetHintString(string);
            self.pillage_trigger makeUsable();
            self.pillageinfo.type = "clip";
            break;

          case "specialammo":
            string = get_hintstring_for_pillaged_item(pillaged_item.type);
            user thread show_pillage_text(string);
            self.pillage_trigger setModel(level.pillageInfo.clip_model);
            self.pillage_trigger makeUsable();

            if(user has_stun_ammo() && user has_incendiary_ammo() && user has_explosive_ammo() && user has_ap_ammo()) {
              self.pillageinfo.type = "combined_ammo";
            } else if(user has_stun_ammo()) {
              self.pillageinfo.type = "stun_ammo";
            } else if(user has_incendiary_ammo()) {
              self.pillageinfo.type = "incendiary_ammo";
            } else if(user has_explosive_ammo()) {
              self.pillageinfo.type = "explosive_ammo";
            } else if(user has_ap_ammo()) {
              self.pillageinfo.type = "ap_ammo";
            } else {
              self.pillageinfo.type = random(["ap_ammo", "explosive_ammo", "incendiary_ammo", "stun_ammo"]);
            }
            string = get_hintstring_for_item_pickup(self.pillageinfo.type);
            self.pillage_trigger SetHintString(string);
            break;

          case "soflam":
            string = get_hintstring_for_pillaged_item(pillaged_item.type);
            user thread show_pillage_text(string);
            self.pillage_trigger setModel(level.pillageInfo.soflam_model);
            string = get_hintstring_for_item_pickup(pillaged_item.type);
            self.pillage_trigger SetHintString(string);
            self.pillage_trigger makeUsable();
            self.pillageinfo.type = "soflam";
            level thread maps\mp\alien\_music_and_dialog::playVOForPillage(user);
            break;

          case "trophy":
            string = get_hintstring_for_pillaged_item(pillaged_item.type);
            user thread show_pillage_text(string);
            self.pillage_trigger setModel(level.pillageInfo.trophy_model);
            string = get_hintstring_for_item_pickup(pillaged_item.type);
            self.pillage_trigger SetHintString(string);
            self.pillage_trigger makeUsable();
            self.pillageinfo.type = "trophy";
            self.pillageinfo.item = "alientrophy_mp";
            self.pillageinfo.ammo = 1;
            break;

          case "crafting":
            string = get_hintstring_for_pillaged_item(pillaged_item.type);
            user thread show_pillage_text(string);

            crafting_item = user get_crafting_ingredient();
            self.pillage_trigger setModel(get_crafting_model(crafting_item));

            string = get_hintstring_for_item_pickup(crafting_item);
            self.pillage_trigger SetHintString(string);
            self.pillage_trigger makeUsable();
            self.pillageinfo.type = "crafting";
            self.pillageinfo.craftingitem = crafting_item;
            break;

          case "intel":
            if(isDefined(level.intel_pillage_show_func))
              self[[level.intel_pillage_show_func]]();
            break;

          default:
            if(isDefined(level.level_specific_pillage_show_func))
              self[[level.level_specific_pillage_show_func]](user, "searched", pillaged_item);
            break;
        }
        if(isDefined(self.drop_override_func)) {
          self[[self.drop_override_func]](user);
        } else {
          if(isDefined(self.pillage_trigger))
            self.pillage_trigger drop_pillage_item_on_ground();
        }

      } else {
        self.pillage_trigger makeUsable();
        self.enabled = true;

      }
    } else {
      if(isDefined(self.pillageinfo)) {
        switch (self.pillageinfo.type) {
          case "explosive":
            user try_to_give_player_explosives(self);
            break;

          case "maxammo":
            if(user cangive_maxammo()) {
              user give_maxammo();
              self delete_pillage_trigger();
            } else {
              self.pillage_trigger makeUsable();
              user setLowerMessage("max_ammo", & "ALIEN_COLLECTIBLES_AMMO_MAX", 3);
            }
            break;

          case "money":

            if(user get_player_currency() < user.maxcurrency) {
              user give_player_currency(self.pillageinfo.amount, undefined, undefined, true);
              string = get_hintstring_for_pillaged_item(self.pillageinfo.amount);
              user thread show_pillage_text(string);
              self delete_pillage_trigger();
            } else {
              user setLowerMessage("max_money", & "ALIEN_COLLECTIBLES_MONEY_MAX", 3);
            }
            break;

          case "attachment":
            if(user add_attachment_to_weapon(self.pillageinfo.attachment, self)) {
              self delete_pillage_trigger();
            }
            break;

          case "flare":
            user try_to_give_player_flares(self);
            break;

          case "clip":
            if(user cangive_ammo_clip()) {
              user give_ammo_clip();
              self delete_pillage_trigger();
            } else {
              self.pillage_trigger makeUsable();
              user setLowerMessage("max_ammo", & "ALIEN_COLLECTIBLES_AMMO_MAX", 3);
            }
            break;

          case "soflam":

            if(user cangive_soflam()) {
              user give_soflam();
              self delete_pillage_trigger();
            } else {
              self.pillage_trigger makeUsable();
              if(user hasweapon("aliensoflam_mp")) {
                user setLowerMessage("have_soflam", & "ALIEN_COLLECTIBLES_SOFLAM_HAD", 3);
              } else {
                user setLowerMessage("too_many", & "ALIEN_COLLECTIBLES_SOFLAM_HAD", 3);
              }

            }
            break;

          case "pet_leash":
            user try_to_give_player_the_leash(self);
            break;

          case "trophy":
            user try_to_give_player_trophy(self);
            break;

          case "stun_ammo":
            user maps\mp\alien\_deployablebox_functions::default_specialammo_onUseDeployable(undefined, false, true, "deployable_specialammo");
            self delete_pillage_trigger();
            break;

          case "incendiary_ammo":
            user maps\mp\alien\_deployablebox_functions::default_specialammo_onUseDeployable(undefined, false, true, "deployable_specialammo_in");
            self delete_pillage_trigger();
            break;
          case "ap_ammo":
            user maps\mp\alien\_deployablebox_functions::default_specialammo_onUseDeployable(undefined, false, true, "deployable_specialammo_ap");

            self delete_pillage_trigger();
            break;

          case "explosive_ammo":
            user maps\mp\alien\_deployablebox_functions::default_specialammo_onUseDeployable(undefined, false, true, "deployable_specialammo_explo");
            self delete_pillage_trigger();
            break;

          case "combined_ammo":
            user maps\mp\alien\_deployablebox_functions::default_specialammo_onUseDeployable(undefined, false, true, "deployable_specialammo_comb");
            self delete_pillage_trigger();
            break;

          case "crafting":
            if(user cangive_crafting_item(self.pillageinfo.craftingitem)) {
              user give_crafting_item(self.pillageinfo.craftingitem);
              user PlayLocalSound("extinction_item_pickup");
              self delete_pillage_trigger();
            } else {
              self.pillage_trigger makeUsable();
            }
            break;

          default:
            if(isDefined(level.level_specific_pillage_show_func))
              self[[level.level_specific_pillage_show_func]](user, "pick_up");
            break;
        }
      }
    }
  }
}

drop_pillage_item_on_ground() {
  if(self.model != "tag_origin") {
    DROP_POS = (0, 0, 20);
    DEFAULT_OFFSET = (0, 0, 2);
    OFFSET = (0, 0, 0);
    groundpos = GetGroundPosition(self.origin + DROP_POS, 2);
    switch (self.model) {
      case "weapon_baseweapon_clip":
        offset = (0, 0, 4);
        break;
      case "mp_trophy_system_folded_iw6":
        offset = (0, 0, 12);
        break;
      case "weapon_scavenger_grenadebag":
        offset = (0, 0, 6);
        break;
      case "weapon_soflam":
        offset = (0, 0, 6);
        break;
      case "vehicle_pickup_keys":
        offset = (0, 0, 6);
        self.angles = (0, 0, 83);
        break;
      case "weapon_alien_muzzlebreak":
        offset = (0, 0, 4);
        break;
      case "weapon_alien_cortex_container":
        offset = (0, 0, 7);
        break;
      case "weapon_concussion_grenade":
      case "weapon_canister_bomb":
      case "weapon_knife_iw6":
      case "mil_emergency_flare_mp":
        offset = DEFAULT_OFFSET;
        break;
    }
    self.origin = groundpos + OFFSET;
  }
}

delete_pillage_trigger() {
  if(alien_mode_has("outline")) {
    maps\mp\alien\_outline_proto::remove_from_outline_pillage_watch_list(self.pillage_trigger);
  }
  self.pillage_trigger delete();
  self.pillageinfo.type = undefined;
}

get_pillaged_item(pillage_spot, player) {
  /# if( getdvar ( "scr_force_pillageitem" ) != "") {
  item = getdvar("scr_force_pillageitem");
  pillaged_item = spawnStruct();
  pillaged_item.type = "attachment";
  pillaged_item.forced_attachment = item;
  return pillaged_item;
}

if(getdvar("scr_force_pillageitem_type") != "") {
  item = getdvar("scr_force_pillageitem_type");

  pillaged_item = spawnStruct();

  switch (item) {
    case "soflam":
    case "pet_leash":
    case "maxammo":
    case "clip":
    case "specialammo":
    case "flare":
    case "trophy":
    case "grenade":
    case "locker_key":
    case "locker_weapon":
    case "intel":
      pillaged_item.type = item;
      pillaged_item.count = 1;
      break;

    case "alienclaymore_mp":
    case "alienbetty_mp":
    case "alienmortar_shell_mp":
      pillaged_item.type = "explosive";
      pillaged_item.explosive_type = item;
      pillaged_item.count = 1;
      break;

    case "money":
      money_to_give = 500;
      pillaged_item.type = "money";
      pillaged_item.count = money_to_give;

    case "crafting":
      pillaged_item.type = "crafting";
  }

  SetDevDvar("scr_force_pillageitem_type", "");
  return pillaged_item;
}

exclusion_list = [];

if(check_for_existing_pet_bombs() > 1)
  exclusion_list[exclusion_list.size] = "pet_leash";

if(!(player can_use_attachment()))
  exclusion_list[exclusion_list.size] = "attachment";

if(isDefined(level.intel_pillage_allowed_func) && !(player[[level.intel_pillage_allowed_func]]()))
  exclusion_list[exclusion_list.size] = "intel";

if(!player should_find_crafting_items()) {
  exclusion_list[exclusion_list.size] = "crafting";
}

item = get_random_pillage_item(level.pillageitems[pillage_spot.pillage_type], exclusion_list);
repeat_count = 0;
while(isDefined(player.last_item) && player.last_item == item) {
  item = get_random_pillage_item(level.pillageitems[pillage_spot.pillage_type], exclusion_list);
  repeat_count++;

  if(repeat_count % 10 == 0) {
    break;
  }
}
player.last_item = item;

if(isDefined(pillage_spot.default_item_type)) {
  item = pillage_spot.default_item_type;
}

pillaged_item = spawnStruct();

switch (item) {
  case "attachment":
    pillaged_item.type = "attachment";
    break;

  case "soflam":
    pillaged_item.type = "soflam";
    break;

  case "explosive":

    switch (randomint(3)) {
      case 0:
        pillaged_item.type = "grenade";
        pillaged_item.count = 2;
        break;

      case 1:
        if(pillage_spot.pillage_type != "easy") {
          pillaged_item.explosive_type = choose_random_explosive_type();
          pillaged_item.type = "explosive";
          pillaged_item.count = 2;
        } else {
          pillaged_item.type = "flare";
          pillaged_item.count = 1;
        }
        break;

      case 2:
        pillaged_item.type = "flare";
        pillaged_item.count = 1;
        break;
    }
    break;

  case "clip":
    pillaged_item.type = "clip";
    pillaged_item.count = 1;
    break;

  case "maxammo":
    pillaged_item.type = "maxammo";
    pillaged_item.count = 1;
    break;

  case "money":
    money_to_give = 50 + (randomint(2) * 50);

    if(pillage_spot.pillage_type == "medium")
      money_to_give = 200 + (randomint(2) * 50);

    if(pillage_spot.pillage_type == "hard")
      money_to_give = 500;

    pillaged_item.type = "money";
    pillaged_item.count = money_to_give;
    break;

  case "pet_leash":
    pillaged_item.type = "pet_leash";
    pillaged_item.count = 1;
    break;

  case "trophy":
    pillaged_item.type = "trophy";
    pillaged_item.count = 1;
    break;

  case "specialammo":
    pillaged_item.type = "specialammo";
    break;

  case "crafting":
    pillaged_item.type = "crafting";
    break;

  case "locker_weapon":
    pillaged_item.type = "locker_weapon";
    pillaged_item.count = 1;
    break;

  case "locker_key":
    pillaged_item.type = "locker_key";
    pillaged_item.count = 1;
    break;

  case "intel":
    pillaged_item.type = "intel";
    pillaged_item.count = 1;
    break;
}

player PlayLocalSound("extinction_item_pickup");

return (pillaged_item);
}

get_random_pillage_item(item_list, exclusion_list) {
  temp_item_list = [];
  total_chance = 0;

  foreach(item_info in item_list) {
    if(array_contains(exclusion_list, item_info.ref)) {
      continue;
    }
    if(item_info.chance == 0) {
      continue;
    }
    temp_item_list[temp_item_list.size] = item_info;
    total_chance += item_info.chance;
  }

  random_index = randomIntRange(0, (total_chance + 1));
  running_total = 0;

  foreach(item_info in temp_item_list) {
    running_total += item_info.chance;

    if(random_index <= running_total)
      return item_info.ref;
  }
}

show_pillage_text(string) {
  self endon("death");
  self endon("disconnect");

  if(isDefined(self.useBarText)) {
    return;
  }
  fontsize = level.primaryProgressBarFontSize;
  font = "objective";
  if(level.splitscreen) {
    fontsize = 1.3;
  }

  self.useBarText = self createPrimaryProgressBarText(0, 25, fontsize, font);
  self.useBarText SetText(string);
  self.useBarText SetPulseFX(50, 2000, 800);

  wait(3);

  self.useBarText destroyElem();
  self.useBarText = undefined;
}

choose_random_explosive_type() {
  return random(level.pillageable_explosives);
}

try_to_give_player_explosives(pillage_spot) {
  explosive_type = pillage_spot.pillageinfo.item;
  ammo_count = pillage_spot.pillageinfo.ammo;

  if(isDefined(level.try_to_give_player_explosive_override)) {
    if(![
        [level.try_to_give_player_explosive_override]
      ]())
      return;
  }

  if(self hasweapon(explosive_type) && self GetAmmoCount(explosive_type) > 0) {
    maxammofrac = selfGetFractionMaxAmmo(explosive_type);
    if(maxammofrac < 1) {
      clip_ammo = self GetWeaponAmmoClip(explosive_type);

      self SetWeaponAmmoClip(explosive_type, (clip_ammo + ammo_count));
      self PlayLocalSound("grenade_pickup");
      pillage_spot delete_pillage_trigger();
    } else
      self setLowerMessage("max_explosvies", & "ALIEN_COLLECTIBLES_EXPLO_MAX", 3);
  } else {
    weapon_to_swap = self should_swap_weapon(level.offhand_explosives);
    self setOffhandPrimaryClass("other");
    if(!isDefined(weapon_to_swap)) {
      self giveweapon(explosive_type);
      self SetWeaponAmmoClip(explosive_type, ammo_count);
      self PlayLocalSound("grenade_pickup");
      pillage_spot delete_pillage_trigger();
    } else {
      self TakeWeapon(weapon_to_swap);
      self giveweapon(explosive_type);
      self SetWeaponAmmoClip(explosive_type, ammo_count);
      self PlayLocalSound("grenade_pickup");

      pillage_spot.pillage_trigger setModel(GetWeaponModel(weapon_to_swap));
      string = get_hintstring_for_item_pickup(weapon_to_swap);
      pillage_spot.pillage_trigger SetHintString(string);
      pillage_spot.pillage_trigger makeUsable();
      pillage_spot.pillageinfo = spawnStruct();
      pillage_spot.pillageinfo.type = "explosive";
      pillage_spot.pillageinfo.item = weapon_to_swap;
      pillage_spot.pillageinfo.ammo = self.swapped_weapon_ammocount;
      pillage_spot.pillage_trigger drop_pillage_item_on_ground();

    }
  }
}

try_to_give_player_flares(pillage_spot) {
  self endon("disconnect");

  wait 1;

  flare = pillage_spot.pillageinfo.item;
  ammo_count = pillage_spot.pillageinfo.ammo;

  if(isDefined(level.try_to_give_player_flare_override)) {
    if(![
        [level.try_to_give_player_flare_override]
      ]())
      return;
  }

  if(self hasweapon(flare) && self GetAmmoCount(flare) > 0) {
    maxammofrac = selfGetFractionMaxAmmo(flare);
    if(maxammofrac < 1) {
      clip_ammo = self GetWeaponAmmoClip(flare);
      stock_ammo = self GetWeaponAmmoStock(flare);
      self SetWeaponAmmoClip(flare, (clip_ammo + stock_ammo + 1));
      pillage_spot delete_pillage_trigger();
    } else
      self setLowerMessage("max_flares", & "ALIEN_COLLECTIBLES_FLARE_MAX", 3);
  } else {
    weapon_to_swap = self should_swap_weapon(level.offhand_secondaries);
    if(!isDefined(weapon_to_swap)) {
      self setOffhandSecondaryClass("flash");
      self giveweapon(flare);
      self SetWeaponAmmoClip(flare, ammo_count);
      pillage_spot delete_pillage_trigger();
    } else {
      self setOffhandSecondaryClass("flash");

      self TakeWeapon(weapon_to_swap);
      self giveweapon(flare);
      self SetWeaponAmmoClip(flare, ammo_count);

      string = get_hintstring_for_item_pickup(weapon_to_swap);
      pillage_spot.pillage_trigger SetHintString(string);
      pillage_spot.pillage_trigger makeUsable();
      pillage_spot.pillageinfo = spawnStruct();

      if(weapon_to_swap == "alienflare_mp" || weapon_to_swap == "iw6_aliendlc21_mp") {
        pillage_spot.pillage_trigger setModel(level.pillageInfo.flare_model);
        pillage_spot.pillageinfo.type = "flare";
      } else if(weapon_to_swap == "alienthrowingknife_mp") {
        pillage_spot.pillage_trigger setModel(level.pillageInfo.leash_model);
        pillage_spot.pillageinfo.type = "pet_leash";
      } else if(weapon_to_swap == "alientrophy_mp") {
        pillage_spot.pillage_trigger setModel(level.pillageInfo.trophy_model);
        pillage_spot.pillageinfo.type = "trophy";
      }

      pillage_spot.pillageinfo.item = weapon_to_swap;
      pillage_spot.pillageinfo.ammo = self.swapped_weapon_ammocount;

      if(isDefined(pillage_spot.is_locker) && isDefined(level.locker_drop_item_on_ground_func)) {
        pillage_spot[[level.locker_drop_item_on_ground_func]](self);
      } else {
        pillage_spot.pillage_trigger drop_pillage_item_on_ground();
      }
    }

  }
}

try_to_give_player_trophy(pillage_spot) {
  trophy = pillage_spot.pillageinfo.item;
  ammo_count = pillage_spot.pillageinfo.ammo;

  if(isDefined(level.try_to_give_player_trophy_override)) {
    if(![
        [level.try_to_give_player_trophy_override]
      ]())
      return;
  }

  if(self hasweapon(trophy) && self GetAmmoCount(trophy) > 0) {
    self setLowerMessage("max_flares", & "ALIEN_COLLECTIBLES_TROPHY_MAX", 3);
  } else {
    weapon_to_swap = self should_swap_weapon(level.offhand_secondaries);
    if(!isDefined(weapon_to_swap)) {
      self setOffhandSecondaryClass("flash");
      self giveweapon(trophy);
      self SetWeaponAmmoClip(trophy, 1);
      pillage_spot delete_pillage_trigger();
    } else {
      self setOffhandSecondaryClass("flash");

      self TakeWeapon(weapon_to_swap);
      self giveweapon(trophy);
      self SetWeaponAmmoClip(trophy, 1);

      string = get_hintstring_for_item_pickup(weapon_to_swap);
      pillage_spot.pillage_trigger SetHintString(string);
      pillage_spot.pillage_trigger makeUsable();
      pillage_spot.pillageinfo = spawnStruct();

      if(weapon_to_swap == "alienflare_mp" || weapon_to_swap == "iw6_aliendlc21_mp") {
        pillage_spot.pillage_trigger setModel(level.pillageInfo.flare_model);
        pillage_spot.pillageinfo.type = "flare";
      } else if(weapon_to_swap == "alienthrowingknife_mp") {
        pillage_spot.pillage_trigger setModel(level.pillageInfo.leash_model);
        pillage_spot.pillageinfo.type = "pet_leash";
      } else if(weapon_to_swap == "alientrophy_mp") {
        pillage_spot.pillage_trigger setModel(level.pillageInfo.trophy_model);
      }

      pillage_spot.pillageinfo.item = weapon_to_swap;
      pillage_spot.pillageinfo.ammo = self.swapped_weapon_ammocount;

      if(isDefined(pillage_spot.is_locker) && isDefined(level.locker_drop_item_on_ground_func)) {
        pillage_spot[[level.locker_drop_item_on_ground_func]](self);
      } else {
        pillage_spot.pillage_trigger drop_pillage_item_on_ground();
      }
    }

  }
}

try_to_give_player_the_leash(pillage_spot) {
  leash = pillage_spot.pillageinfo.item;
  ammo_count = pillage_spot.pillageinfo.ammo;

  if(isDefined(level.try_to_give_player_leash_override)) {
    if(![
        [level.try_to_give_player_leash_override]
      ]())
      return;
  }

  if(self hasweapon(leash) && self GetAmmoCount(leash) > 0) {
    maxammofrac = selfGetFractionMaxAmmo(leash);
    if(maxammofrac < 1) {
      clip_ammo = self GetWeaponAmmoClip(leash);
      stock_ammo = self GetWeaponAmmoStock(leash);
      self SetWeaponAmmoClip(leash, (clip_ammo + stock_ammo + 1));
      pillage_spot delete_pillage_trigger();
    } else
      self setLowerMessage("max_leash", & "ALIENS_PATCH_LEASH_MAX", 3);
  } else {
    weapon_to_swap = self should_swap_weapon(level.offhand_secondaries);
    if(!isDefined(weapon_to_swap)) {
      self setOffhandSecondaryClass("throwingknife");
      self giveweapon(leash);
      self SetWeaponAmmoClip(leash, ammo_count);
      pillage_spot delete_pillage_trigger();
    } else {
      self setOffhandSecondaryClass("throwingknife");

      self TakeWeapon(weapon_to_swap);
      self giveweapon(leash);
      self SetWeaponAmmoClip(leash, ammo_count);

      string = get_hintstring_for_item_pickup(weapon_to_swap);
      pillage_spot.pillage_trigger SetHintString(string);
      pillage_spot.pillage_trigger makeUsable();
      pillage_spot.pillageinfo = spawnStruct();

      if(weapon_to_swap == "alienflare_mp" || weapon_to_swap == "iw6_aliendlc21_mp") {
        pillage_spot.pillage_trigger setModel(level.pillageInfo.flare_model);
        pillage_spot.pillageinfo.type = "flare";
      } else if(weapon_to_swap == "alienthrowingknife_mp") {
        pillage_spot.pillage_trigger setModel(level.pillageInfo.leash_model);
      } else if(weapon_to_swap == "alientrophy_mp") {
        pillage_spot.pillageinfo.type = "trophy";
        pillage_spot.pillage_trigger setModel(level.pillageInfo.trophy_model);
      }

      pillage_spot.pillageinfo.item = weapon_to_swap;
      pillage_spot.pillageinfo.ammo = self.swapped_weapon_ammocount;

      if(isDefined(pillage_spot.is_locker) && isDefined(level.locker_drop_item_on_ground_func)) {
        pillage_spot[[level.locker_drop_item_on_ground_func]](self);
      } else {
        pillage_spot.pillage_trigger drop_pillage_item_on_ground();
      }
    }
  }
}

should_swap_weapon(weapons_array) {
  should_swap = false;
  weapon_to_swap = undefined;
  swapped_weapon_ammocount = 0;
  offhandweapons = self GetWeaponsListOffhands();
  foreach(offhandweapon in offhandweapons) {
    foreach(offhand_type in weapons_array) {
      if(offhandweapon != offhand_type) {
        continue;
      }
      if(isDefined(offhandweapon) && offhandweapon != "none" && self GetAmmoCount(offhandweapon) > 0) {
        weapon_to_swap = offhandweapon;
        swapped_weapon_ammocount = self GetWeaponAmmoClip(offhandweapon);
        should_swap = true;
        break;
      }
      if(should_swap) {
        break;
      }
    }
  }
  if(isDefined(weapon_to_swap))
    self.swapped_weapon_ammocount = swapped_weapon_ammocount;

  return weapon_to_swap;
}

is_frag_grenade(weapon) {
  return (weapon == "aliensemtex_mp" || weapon == "alienmortar_shell_mp");
}

get_attachment_for_weapon() {
  curweapon = self GetCurrentWeapon();
  baseweapon = GetWeaponBaseName(curweapon);
  weaponclass = getWeaponClass(curweapon);
  attach_found = random(level.pillageable_attachments);
  switch (weaponclass) {
    case "weapon_sniper":
      attach_found = self check_upgrade_return_attchment(level.pillageable_attachments, baseweapon);
      break;
    case "weapon_assault":
      if(IsSubStr(baseweapon, "sc2010")) {
        attach_found = self check_upgrade_return_attchment(level.pillageable_attachments_ar_sc2010, baseweapon);
      } else
      if(IsSubStr(baseweapon, "honeybadger")) {
        attach_found = self check_upgrade_return_attchment(level.pillageable_attachments_ar_honeybadger, baseweapon);
      } else
        attach_found = self check_upgrade_return_attchment(level.pillageable_attachments_ar, baseweapon);
      break;
    case "weapon_lmg":
      if(IsSubStr(baseweapon, "kac")) {
        attach_found = self check_upgrade_return_attchment(level.pillageable_attachments_lmg_kac, baseweapon);
      } else
        attach_found = self check_upgrade_return_attchment(level.pillageable_attachments_lmg, baseweapon);
      break;
    case "weapon_shotgun":
      if(IsSubStr(baseweapon, "fp6")) {
        attach_found = self check_upgrade_return_attchment(level.pillageable_attachments_sg_fp6, baseweapon);
      } else
        attach_found = self check_upgrade_return_attchment(level.pillageable_attachments_sg, baseweapon);
      break;
    case "weapon_dmr":
      attach_found = self check_upgrade_return_attchment(level.pillageable_attachments_dmr, baseweapon);
      break;
    case "weapon_smg":
      if(IsSubStr(baseweapon, "aliendlc23")) {
        attach_found = self check_upgrade_return_attchment(level.pillageable_attachments_aliendlc23, baseweapon);
      } else
      if(IsSubStr(baseweapon, "arkalienk7")) {
        attach_found = self check_upgrade_return_attchment(level.pillageable_attachments_smg_k7, baseweapon);
      } else
        attach_found = self check_upgrade_return_attchment(level.pillageable_attachments_smg, baseweapon);
      break;
    default:
      attach_found = self check_upgrade_return_attchment(level.pillageable_attachments, baseweapon);
      break;
  }

  return attach_found;
}

check_upgrade_return_attchment(attachment_array, baseweapon) {
  map_name = GetDvar("ui_mapname");
  attach_found = random(attachment_array);
  while(attach_found == "alienmuzzlebrake" || attach_found == "xmags") {
    if(attach_found == "alienmuzzlebrake") {
      if(self maps\mp\alien\_persistence::is_upgrade_enabled("master_scavenger_upgrade")) {
        return attach_found;
      } else
        attach_found = random(attachment_array);
    } else if(attach_found == "xmags") {
      if(self maps\mp\alien\_persistence::is_upgrade_enabled("master_scavenger_upgrade")) {
        return attach_found;
      } else
        attach_found = random(attachment_array);
    }

    wait 0.05;
  }
  return attach_found;
}

add_attachment_to_weapon(new_attachment, pillage_spot) {
  fullweaponname = self GetCurrentWeapon();
  baseweapon = GetWeaponBaseName(fullweaponname);
  newbaseweapon = GetWeaponBaseName(fullweaponname);
  swap = false;
  attachment1 = "none";
  attachment2 = "none";
  attachment3 = "none";
  attachment4 = "none";
  player_has_xmags = false;
  camo = 0;
  reticle = 0;
  weaponclass = getWeaponClass(baseweapon);

  if(weaponHasAttachment(fullweaponname, "xmags"))
    player_has_xmags = true;

  attachments = get_possible_attachments_by_weaponclass(weaponclass, baseweapon);
  can_use = false;
  foreach(piece in attachments) {
    if(new_attachment == piece)
      can_use = true;
  }

  if(!can_use) {
    self setLowerMessage("cant_attach", & "ALIEN_COLLECTIBLES_CANT_USE", 3);
    return false;
  }

  current_attachments = GetWeaponAttachments(fullweaponname);

  if(current_attachments.size > 0 && current_attachments.size < 5) {
    for(i = 0; i < current_attachments.size; i++) {
      if(i == 0)
        attachment1 = current_attachments[i];
      if(i == 1)
        attachment2 = current_attachments[i];
      if(i == 2)
        attachment3 = current_attachments[i];
      if(i == 3)
        attachment4 = current_attachments[i];
    }

    if(attachment1 != "none" && getAttachmentType(attachment1) == getAttachmentType(new_attachment)) {
      self swap_attachment(attachment1, pillage_spot);
      attachment1 = new_attachment;
      swap = true;
    }

    if(attachment2 != "none" && getAttachmentType(attachment2) == getAttachmentType(new_attachment)) {
      self swap_attachment(attachment2, pillage_spot);
      attachment2 = new_attachment;
      swap = true;
    }

    if(attachment3 != "none" && getAttachmentType(attachment3) == getAttachmentType(new_attachment)) {
      self swap_attachment(attachment3, pillage_spot);
      attachment3 = new_attachment;
      swap = true;
    }

    if(attachment4 != "none" && getAttachmentType(attachment4) == getAttachmentType(new_attachment)) {
      self swap_attachment(attachment4, pillage_spot);
      attachment4 = new_attachment;
      swap = true;
    }
    if(swap == false) {
      if(attachment1 == "none")
        attachment1 = new_attachment;
      else if(attachment2 == "none" && new_attachment != attachment1)
        attachment2 = new_attachment;
      else if(attachment3 == "none" && new_attachment != attachment1 && new_attachment != attachment2)
        attachment3 = new_attachment;
      else if(attachment4 == "none" && new_attachment != attachment1 && new_attachment != attachment2 && new_attachment != attachment3)
        attachment4 = new_attachment;
      else {
        self setLowerMessage("cant_attach", & "ALIEN_COLLECTIBLES_CANT_USE", 3);
        return false;
      }
    }
  } else
    attachment1 = new_attachment;

  weaponname = strip_suffix(newbaseweapon, "_mp");

  camo = get_weapon_camo(baseweapon);

  reticle = RandomIntRange(1, 7);

  if(IsSubStr(baseweapon, "aliendlc23"))
    reticle = 0;

  if(attachment1 != "thermal" &&
    attachment1 != "thermalsmg" &&
    attachment2 != "thermal" &&
    attachment2 != "thermalsmg" &&
    attachment3 != "thermal" &&
    attachment3 != "thermalsmg" &&
    attachment4 != "thermal" &&
    attachment4 != "thermalsmg")
    newweapon = buildAlienWeaponName(weaponname, attachment1, attachment2, attachment3, attachment4, camo, reticle);
  else
    newweapon = buildAlienWeaponName(weaponname, attachment1, attachment2, attachment3, attachment4, camo);

  clipammo = self GetWeaponAmmoClip(fullweaponname);
  stockammo = self GetWeaponAmmoStock(fullweaponname);

  self TakeWeapon(fullweaponname);
  self GiveWeapon(newweapon);

  if(weaponHasAttachment(newweapon, "xmags") && !player_has_xmags)
    clipammo = WeaponClipSize(newweapon);

  self SetWeaponAmmoClip(newweapon, clipammo);
  self SetWeaponAmmoStock(newweapon, stockammo);

  self PlayLocalSound("weap_raise_large_plr");
  self SwitchToWeapon(newweapon);

  if(swap == false)
    return true;
  else
    return false;
}

get_weapon_camo(baseweapon) {
  if(IsSubStr(baseweapon, "alienfp6") ||
    IsSubStr(baseweapon, "alienmts255") ||
    IsSubStr(baseweapon, "aliendlc12") ||
    IsSubStr(baseweapon, "aliendlc13") ||
    IsSubStr(baseweapon, "aliendlc14") ||
    IsSubStr(baseweapon, "aliendlc15") ||
    IsSubStr(baseweapon, "alienameli") ||
    IsSubStr(baseweapon, "alienk7") ||
    IsSubStr(baseweapon, "alienmk14") ||
    IsSubStr(baseweapon, "alienr5rgp") ||
    IsSubStr(baseweapon, "alienusr") ||
    IsSubStr(baseweapon, "alienuts15") ||
    IsSubStr(baseweapon, "arkalienameli") ||
    IsSubStr(baseweapon, "arkaliendlc15") ||
    IsSubStr(baseweapon, "arkaliendlc23") ||
    IsSubStr(baseweapon, "arkalienimbel") ||
    IsSubStr(baseweapon, "arkalienk7") ||
    IsSubStr(baseweapon, "arkalienkac") ||
    IsSubStr(baseweapon, "arkalienmaul") ||
    IsSubStr(baseweapon, "arkalienmk14") ||
    IsSubStr(baseweapon, "arkalienr5rgp") ||
    IsSubStr(baseweapon, "arkalienusr") ||
    IsSubStr(baseweapon, "arkalienuts15") ||
    IsSubStr(baseweapon, "arkalienvks") ||
    IsSubStr(baseweapon, "aliendlc23"))
    return 0;
  else
    return RandomIntRange(1, 10);
}

swap_attachment(attachment, pillage_spot) {
  location = pillage_spot.origin;
  pillage_spot.pillageinfo.type = "attachment";
  pillage_spot.pillageinfo.attachment = attachment;

  switch (attachment) {
    case "griphide":
      attachment = "grip";
      break;
    case "barrelrange03":
      attachment = "barrelrange";
      break;
    case "alienfiretypeburstdmr":
      attachment = "firetypeburst";
      break;
    case "alienfiretypeburstg28":
      attachment = "firetypeburst";
      break;
    case "alienfiretypeburstlight":
      attachment = "firetypeburst";
      break;
    case "alienfiretypeburst":
      attachment = "firetypeburst";
      break;
    case "reflexsmg":
      attachment = "reflex";
      break;
    case "reflexlmg":
      attachment = "reflex";
      break;
    case "reflexshotgun":
      attachment = "reflex";
      break;
    case "eotechsmg":
      attachment = "eotech";
      break;
    case "eotechlmg":
      attachment = "eotech";
      break;
    case "eotechshotgun":
      attachment = "eotech";
      break;
    case "acogsmg":
      attachment = "acog";
      break;
    case "thermalsmg":
      attachment = "thermal";
      break;
    case "alienmuzzlebrake":
    case "alienmuzzlebrakesn":
    case "alienmuzzlebrakesg":
      attachment = "alienmuzzlebrake";
      break;
    default:
      break;
  }

  pillage_spot.pillage_trigger.origin = location;
  info_string = get_hintstring_for_pillaged_item("attachment");
  hint_string = get_hintstring_for_item_pickup(attachment);
  pillage_spot.pillage_trigger SetHintString(hint_string);
  pillage_spot.pillage_trigger makeUsable();
  self thread show_pillage_text(info_string);

  attach_model = level.pillageInfo.attachment_model;
  if(attachment == "alienmuzzlebrake")
    attach_model = level.pillageInfo.alienattachment_model;

  pillage_spot.pillage_trigger setModel(attach_model);
  pillage_spot.pillageinfo.type = "attachment";
  pillage_spot.pillageinfo.attachment = attachment;
  pillage_spot.pillage_trigger drop_pillage_item_on_ground();
}

PILLAGE_USE_DISTANCE = 40000;
useHoldThink(player, useTime) {
  player endon("disconnect");

  player.pillage_spot = spawnStruct();
  player.pillage_spot.curProgress = 0;
  player.pillage_spot.inUse = true;
  player.pillage_spot.useRate = 1;

  if(isDefined(useTime)) {
    player.pillage_spot.useTime = useTime;
  } else {
    player.pillage_spot.useTime = level.pillageinfo.default_use_time;
  }

  if(IsPlayer(player))
    player thread personalUseBar(self);

  player.hasprogressbar = true;
  result = useHoldThinkLoop(player, self, PILLAGE_USE_DISTANCE);
  assert(isDefined(result));

  player.hasprogressbar = false;

  if(!isDefined(self))
    return false;

  player.pillage_spot.inUse = false;
  player.pillage_spot.curProgress = 0;

  return (result);
}

personalUseBar(object) {
  self endon("disconnect");

  self SetClientOmnvar("ui_securing", UI_SEARCHING);
  lastRate = -1;
  while(isReallyAlive(self) && isDefined(object) && self.pillage_spot.inUse && !level.gameEnded) {
    lastRate = self.pillage_spot.useRate;
    self SetClientOmnvar("ui_securing_progress", self.pillage_spot.curProgress / self.pillage_spot.useTime);
    wait(0.05);
  }

  self SetClientOmnvar("ui_securing", 0);
  self SetClientOmnvar("ui_securing_progress", 0);
}

useHoldThinkLoop(player, ent, dist_check) {
  while(!level.gameEnded && isDefined(self) && isReallyAlive(player) && player useButtonPressed() && player.pillage_spot.curProgress < player.pillage_spot.useTime) {
    if(isDefined(ent) && isDefined(dist_check)) {
      if(distancesquared(player.origin, ent.origin) > dist_check) {
        return false;
      }
    }

    player.pillage_spot.curProgress += (50 * player.pillage_spot.useRate);

    player.pillage_spot.useRate = 1;

    if(player.pillage_spot.curProgress >= player.pillage_spot.useTime)
      return (isReallyAlive(player));

    wait 0.05;
  }

  return false;
}

debug_pillage_spots() {
  wait 5;
  while(1) {
    if(GetDvar("scr_debug_pillage") != "1") {
      wait 1;
      continue;
    }
    foreach(area in level.pillage_areas) {
      foreach(spot in area["easy"]) {
        if(isDefined(spot.default_item_type) && spot.default_item_type == "crafting") {
          text = "crafting - easy";
          color = (1, 0, 0);
        } else {
          text = "easy";
          color = (1, 1, 1);
        }
        if(Distance(level.players[0].origin, spot.origin) < 1500)

          Print3d(spot.origin + (0, 0, 20), text, color, 1, 1, 20);
      }

      foreach(spot in area["medium"]) {
        if(isDefined(spot.default_item_type) && spot.default_item_type == "crafting") {
          text = "crafting - med";
          color = (1, 0, 0);
        } else {
          text = "medium";
          color = (1, 1, 1);
        }

        if(Distance(level.players[0].origin, spot.origin) < 1500)
          Print3d(spot.origin + (0, 0, 20), text, color, 1, 1, 20);
      }

      foreach(spot in area["hard"]) {
        if(isDefined(spot.default_item_type) && spot.default_item_type == "crafting") {
          text = "crafting - hard";
          color = (1, 0, 0);
        } else {
          text = "hard";
          color = (1, 1, 1);
        }

        if(Distance(level.players[0].origin, spot.origin) < 1500)
          Print3d(spot.origin + (0, 0, 20), text, color, 1, 1, 20);
      }

    }

    waitframe();
  }
}

get_possible_attachments_by_weaponclass(weaponClass, baseweapon) {
  switch (weaponClass) {
    case "weapon_smg":
      if(IsSubStr(baseweapon, "aliendlc23")) {
        attachments = level.pillageable_attachments_aliendlc23;
        return attachments;
      }
      if(IsSubStr(baseweapon, "arkalienk7")) {
        attachments = level.pillageable_attachments_smg_k7;
        return attachments;
      }
      attachments = level.pillageable_attachments_smg;
      return attachments;

    case "weapon_assault":
      if(IsSubStr(baseweapon, "sc2010")) {
        attachments = level.pillageable_attachments_ar_sc2010;
        return attachments;
      }
      if(IsSubStr(baseweapon, "honeybadger")) {
        attachments = level.pillageable_attachments_ar_honeybadger;
        return attachments;
      }
      attachments = level.pillageable_attachments_ar;
      return attachments;

    case "weapon_lmg":
      if(IsSubStr(baseweapon, "kac")) {
        attachments = level.pillageable_attachments_lmg_kac;
        return attachments;
      }
      attachments = level.pillageable_attachments_lmg;
      return attachments;

    case "weapon_shotgun":
      if(IsSubStr(baseweapon, "fp6")) {
        attachments = level.pillageable_attachments_sg_fp6;
        return attachments;
      }
      attachments = level.pillageable_attachments_sg;
      return attachments;

    case "weapon_pistol":
      attachments = [];
      return attachments;

    case "weapon_dmr":
      attachments = level.pillageable_attachments_dmr;
      return attachments;

    case "weapon_sniper":
      attachments = level.pillageable_attachments_sr;
      return attachments;

    default:
      attachments = [];
      return attachments;
  }

}

cangive_ammo_clip() {
  weap = self GetCurrentWeapon();
  weap_max_ammo = WeaponMaxAmmo(weap);
  max_clip_size = WeaponClipSize(weap);

  base_weapon = getRawBaseWeaponName(weap);

  if(self player_has_specialized_ammo(base_weapon)) {
    if(isDefined(self.stored_ammo[base_weapon])) {
      if(self.stored_ammo[base_weapon].ammoStock < WeaponMaxAmmo(weap)) {
        return true;
      }
    }
  } else if(self GetWeaponAmmoStock(weap) < weap_max_ammo) {
    return true;
  }
  if(weap == "aliensoflam_mp" || WeaponType(weap) == "riotshield" || is_incompatible_weapon(weap)) {
    primaries = self GetWeaponsListPrimaries();
    foreach(primaryweapon in primaries) {
      if(primaryweapon == weap) {
        continue;
      }
      weap_max_ammo = WeaponMaxAmmo(primaryweapon);
      max_clip_size = WeaponClipSize(primaryweapon);

      base_weapon = getRawBaseWeaponName(primaryweapon);
      if(self player_has_specialized_ammo(base_weapon)) {
        if(isDefined(self.stored_ammo[base_weapon])) {
          if(self.stored_ammo[base_weapon].ammoStock < WeaponMaxAmmo(primaryweapon)) {
            return true;
          }
        }
      } else if(self GetWeaponAmmoStock(primaryweapon) < weap_max_ammo) {
        return true;
      }
    }
  }
  return false;
}

give_ammo_clip() {
  weapon = self GetCurrentWeapon();
  base_weapon = getRawBaseWeaponName(weapon);
  max_clip_size = WeaponClipSize(weapon);

  if(self player_has_specialized_ammo(base_weapon)) {
    if(isDefined(self.stored_ammo[base_weapon])) {
      if(self.stored_ammo[base_weapon].ammoStock < WeaponMaxAmmo(weapon)) {
        self.stored_ammo[base_weapon].ammoStock += max_clip_size;
      }
    }
  } else if(weapon == "aliensoflam_mp" || WeaponType(weapon) == "riotshield" || is_incompatible_weapon(weapon)) {
    primaries = self GetWeaponsListPrimaries();
    foreach(primaryweapon in primaries) {
      if(primaryweapon == weapon) {
        continue;
      }
      if(!maps\mp\gametypes\_weapons::isBulletWeapon(weapon)) {
        continue;
      }
      max_clip_size = WeaponClipSize(primaryweapon);
      base_weapon = getRawBaseWeaponName(primaryweapon);

      if(self player_has_specialized_ammo(base_weapon)) {
        if(isDefined(self.stored_ammo[base_weapon])) {
          if(self.stored_ammo[base_weapon].ammoStock < WeaponMaxAmmo(primaryweapon)) {
            self.stored_ammo[base_weapon].ammoStock += max_clip_size;
          }
        }
      } else if(self GetWeaponAmmoStock(primaryweapon) < WeaponMaxAmmo(primaryweapon)) {
        current_stock_ammo = self GetWeaponAmmoStock(primaryweapon);
        self setweaponammostock(primaryweapon, max_clip_size + current_stock_ammo);
      }

      return;

    }
  } else {
    current_stock_ammo = self GetWeaponAmmoStock(weapon);
    self setweaponammostock(weapon, max_clip_size + current_stock_ammo);
  }
  self PlayLocalSound("weap_ammo_pickup");
}

give_maxammo() {
  primary_weapons = self GetWeaponsListPrimaries();

  foreach(weapon in primary_weapons) {
    if(weapon == "aliensoflam_mp" || WeaponType(weapon) == "riotshield") {
      continue;
    }
    if(is_incompatible_weapon(weapon)) {
      continue;
    }
    base_weapon = getRawBaseWeaponName(weapon);
    if(self player_has_specialized_ammo(base_weapon)) {
      if(isDefined(self.stored_ammo[base_weapon])) {
        if(self.stored_ammo[base_weapon].ammoStock < WeaponMaxAmmo(weapon)) {
          self.stored_ammo[base_weapon].ammoStock = return_nerf_scaled_ammo(weapon);
        }
      }

    } else {
      max_stock = WeaponMaxAmmo(weapon);
      scaled_stock = int(max_stock * self maps\mp\alien\_prestige::prestige_getMinAmmo());
      self SetWeaponAmmoStock(weapon, scaled_stock);
    }
  }
  self PlayLocalSound("weap_ammo_pickup");
}

cangive_maxammo() {
  primary_weapons = self GetWeaponsListPrimaries();
  foreach(weapon in primary_weapons) {
    if(weapon == "aliensoflam_mp" || WeaponType(weapon) == "riotshield") {
      continue;
    }
    if(is_incompatible_weapon(weapon)) {
      continue;
    }
    base_weapon = getRawBaseWeaponName(weapon);
    if(self player_has_specialized_ammo(base_weapon)) {
      if(isDefined(self.stored_ammo[base_weapon])) {
        amount = WeaponMaxAmmo(weapon);
        if(self maps\mp\alien\_prestige::prestige_getMinAmmo() != 1)
          amount = maps\mp\alien\_prestige::prestige_getMinAmmo() * WeaponMaxAmmo(weapon);

        if(self.stored_ammo[base_weapon].ammoStock < amount) {
          return true;
        }
      }

    } else {
      amount = WeaponMaxAmmo(weapon);
      if(self maps\mp\alien\_prestige::prestige_getMinAmmo() != 1)
        amount = maps\mp\alien\_prestige::prestige_getMinAmmo() * WeaponMaxAmmo(weapon);

      max_stock = amount;
      player_stock = self getweaponammostock(weapon);

      if(player_stock < max_stock) {
        return true;
      }
    }
  }
  return false;
}

cangive_soflam() {
  weapon_ref = "aliensoflam_mp";

  currentweapon = self GetCurrentWeapon();
  cur_weapons = self GetWeaponsListPrimaries();

  if(self.hasRiotShieldEquipped && cur_weapons.size > 2) {
    return false;
  }

  if(self is_holding_deployable() || self HasWeapon(weapon_ref)) {
    return false;
  }

  return true;
}

give_soflam() {
  self giveweapon("aliensoflam_mp");
  self SwitchToWeapon("aliensoflam_mp");
}

cangive_crafting_item(crafting_item) {
  if(!isDefined(self.current_crafting_recipe)) {
    self setLowerMessage("cant_pickup", & "ALIEN_CRAFTING_NO_RECIPE", 3);
    self playlocalsound("ui_craft_deny");
    return false;
  }

  if(self.craftingItems.size == level.max_crafting_items) {
    self setLowerMessage("cant_pickup", & "ALIEN_CRAFTING_MAX_CRAFTING_ITEMS", 3);
    return false;
  }

  foreach(craftingItem in self.craftingItems) {
    if(craftingItem == crafting_item) {
      self setLowerMessage("cant_pickup", & "ALIEN_CRAFTING_ALREADY_HAVE", 3);
      return false;
    }
  }

  if(array_contains(self.swappable_crafting_ingredient_list, crafting_item)) {
    return true;
  } else if(array_contains(self.crafting_ingredient_list, crafting_item)) {
    return true;
  }

  self setLowerMessage("cant_pickup", & "ALIEN_CRAFTING_NO_RECIPE", 3);
  return false;
}

re_distribute_pillage_spots() {
  level endon("game_ended");
  while(1) {
    level waittill("drill_detonated");

    pillage_areas = getstructarray("pillage_area", "targetname");
    foreach(index, area in pillage_areas) {
      level.pillage_areas[index] = [];
      level.pillage_areas[index]["easy"] = [];
      level.pillage_areas[index]["medium"] = [];
      level.pillage_areas[index]["hard"] = [];

      pillage_spots = getstructarray(area.target, "targetname");
      foreach(spot in pillage_spots) {
        if(isDefined(spot.script_noteworthy)) {
          tokens = StrTok(spot.script_noteworthy, ",");
          spot.pillage_type = tokens[0];
          if(isDefined(tokens[1])) {
            spot.script_model = tokens[1];
          }
          switch (spot.pillage_type) {
            case "easy":
              level.pillage_areas[index]["easy"][level.pillage_areas[index]["easy"].size] = spot;
              break;

            case "medium":
              level.pillage_areas[index]["medium"][level.pillage_areas[index]["medium"].size] = spot;
              break;

            case "hard":
              level.pillage_areas[index]["hard"][level.pillage_areas[index]["hard"].size] = spot;
              break;
          }
        }

      }
    }

    foreach(index, area in level.pillage_areas) {
      level.pillage_areas[index]["easy"] = remove_used_pillage_spots(level.pillage_areas[index]["easy"]);
      level.pillage_areas[index]["medium"] = remove_used_pillage_spots(level.pillage_areas[index]["medium"]);
      level.pillage_areas[index]["hard"] = remove_used_pillage_spots(level.pillage_areas[index]["hard"]);

      level thread create_pillage_spots(level.pillage_areas[index]["easy"]);
      level thread create_pillage_spots(level.pillage_areas[index]["medium"]);
      level thread create_pillage_spots(level.pillage_areas[index]["hard"]);

    }
  }
}

remove_used_pillage_spots(pillage_spot_array) {
  newarray = [];
  near_distance_check = 150 * 150;
  far_distance_check = 300 * 300;
  cosine = cos(75);
  for(i = 0; i < pillage_spot_array.size; i++) {
    player_near = false;

    if(isDefined(pillage_spot_array[i].not_used)) {
      newarray[newarray.size] = pillage_spot_array[i];
      pillage_spot_array[i].not_used = undefined;
      pillage_spot_array[i].searched = undefined;
    } else {
      if(isDefined(pillage_spot_array[i].searched)) {
        if(!isDefined(pillage_spot_array[i].pillage_trigger)) {
          pillage_spot_array[i].searched = undefined;
          newarray[newarray.size] = pillage_spot_array[i];
          continue;
        } else {
          continue;
        }
      } else if(isDefined(pillage_spot_array[i].pillage_trigger)) {
        any_player_near = false;

        foreach(player in level.players) {
          player_near = false;
          if(!IsAlive(player))
            continue;
          if(Distance2DSquared(player.origin, pillage_spot_array[i].origin) < near_distance_check) {
            player_near = true;
          }
          if(!player_near && Distance2DSquared(player.origin, pillage_spot_array[i].origin) < far_distance_check) {
            player_near = within_fov(player getEye(), player.angles, pillage_spot_array[i].origin + (0, 0, 5), cosine);
          }

          if(player_near)
            any_player_near = true;
        }
        if(any_player_near) {
          continue;
        }
        maps\mp\alien\_outline_proto::remove_from_outline_pillage_watch_list(pillage_spot_array[i].pillage_trigger);
        pillage_spot_array[i].pillage_trigger delete();
        pillage_spot_array[i].not_used = true;
        pillage_spot_array[i].searched = undefined;
        pillage_spot_array[i].enabled = undefined;
      }

    }

    if(i % 2 == 0)
      wait(.05);
  }

  return newarray;
}

can_use_attachment() {
  weaponlist = self GetWeaponsListPrimaries();

  foreach(weapon in weaponlist) {
    gunclass = getWeaponClass(weapon);

    if(gunclass == "weapon_pistol") {
      continue;
    }
    if(maps\mp\gametypes\_weapons::isBulletWeapon(weapon))
      return true;
  }
  return false;
}

check_for_existing_pet_bombs() {
  petbomb_count = 0;

  foreach(player in level.players) {
    items = player GetWeaponsListAll();
    foreach(item in items) {
      if(item == "alienthrowingknife_mp" && (player GetWeaponAmmoClip("alienthrowingknife_mp") > 0 || player GetWeaponAmmoStock("alienthrowingknife_mp") > 0))
        petbomb_count++;
    }
  }

  foreach(index, area in level.pillage_areas) {
    foreach(pillage_area in level.pillage_areas[index]["easy"]) {
      if(pillage_area_has_petbomb(pillage_area))
        petbomb_count++;
    }
    foreach(pillage_area in level.pillage_areas[index]["medium"]) {
      if(pillage_area_has_petbomb(pillage_area))
        petbomb_count++;
    }
    foreach(pillage_area in level.pillage_areas[index]["hard"]) {
      if(pillage_area_has_petbomb(pillage_area))
        petbomb_count++;
    }
  }

  aliens = getActiveAgentsOfType("alien");
  foreach(alien in aliens) {
    if(isDefined(alien.pet) && alien.pet)
      petbomb_count++;
  }

  if(isDefined(level.custom_pet_bomb_check)) {
    petbomb_count += [[level.custom_pet_bomb_check]]();
  }

  return petbomb_count;
}

pillage_area_has_petbomb(pillage_area) {
  returnisDefined(pillage_area.pillageinfo) && isDefined(pillage_area.pillageinfo.type) && pillage_area.pillageinfo.type == "pet_leash";
}

get_crafting_ingredient() {
  ingredient_list = [];
  if(self.craftingItems.size < 1 || self.crafting_ingredient_list.size > 0) {
    return (random(self.crafting_ingredient_list));
  } else {
    if(self.craftingItems.size < 3)
      return (random(self.swappable_crafting_ingredient_list));
    else {
      foreach(player in level.players) {
        if(!isDefined(player.current_crafting_recipe)) {
          continue;
        }
        if(player.craftingItems.size == 3) {
          continue;
        }
        if(player.craftingItems.size < 1 || player.crafting_ingredient_list.size > 0) {
          ingredient_list = array_combine(player.crafting_ingredient_list, ingredient_list);
        } else {
          ingredient_list = array_combine(player.swappable_crafting_ingredient_list, ingredient_list);
        }

      }
    }
  }

  if(ingredient_list.size > 0)
    return random(ingredient_list);
  else
  if(isDefined(level.random_crafting_list))
    return random(level.random_crafting_list);
  else
    return random(["venomx", "nucleicbattery", "bluebiolum", "biolum", "orangebiolum", "amethystbiolum", "fuse", "tnt", "pipe", "resin", "biolum", "cellbattery"]);
}

get_crafting_model(crafting_ingredient) {
  COL_WORLD_MODEL = 2;
  COL_ITEM_REF = 1;

  craftingModel = TableLookup(level.alien_crafting_items, COL_ITEM_REF, crafting_ingredient, COL_WORLD_MODEL);

  if(isDefined(craftingModel))
    return craftingModel;
  else
    return level.crafting_model;
}

give_crafting_item(crafting_item) {
  if(isDefined(self.current_crafting_recipe))
    self notify("dlc_vo_notify", self.current_crafting_recipe, self);

  slot_num = get_crafting_item_slot(crafting_item);

  self.crafting_ingredient_list = array_remove(self.crafting_ingredient_list, crafting_item);

  switch (slot_num) {
    case 1:
      self SetClientOmnvar("ui_alien_craft_slot_1", 1);
      break;
    case 2:
      self SetClientOmnvar("ui_alien_craft_slot_2", 1);
      break;
    case 3:
      self SetClientOmnvar("ui_alien_craft_slot_3", 1);
      break;
  }

  if(array_contains(self.swappable_crafting_ingredient_list, crafting_item)) {
    item_to_remove = undefined;

    foreach(helditem in self.craftingItems) {
      if(array_contains(self.swappable_crafting_ingredient_list, helditem))
        item_to_remove = heldItem;
    }

    if(isDefined(item_to_remove))
      self.craftingItems = array_remove(self.craftingItems, item_to_remove);
  } else
    self.crafting_ingredient_list = array_remove(self.crafting_ingredient_list, crafting_item);

  self.craftingItems[self.craftingItems.size] = crafting_item;
  if(self.craftingItems.size == 3) {
    index = get_crafting_item_table_index();

    self SetClientOmnvar("ui_alien_hudcraftinginfo", index);
    if(isAlive(self) && !self is_in_laststand())
      self IPrintLnBold(&"ALIEN_CRAFTING_OPEN_MENU");
  }

}

get_crafting_item_slot(crafting_item) {
  RECIPE_TYPE = 4;
  SLOTNUM = 5;
  ALT_RECIPE_TYPE = 6;
  ALT_SLOTNUM = 7;
  ALT_ALT_RECIPE_TYPE = 8;
  ALT_ALT_SLOTNUM = 9;
  slot = undefined;

  index = int(TableLookup(level.crafting_item_table, 1, crafting_item, 0));

  recipename = TableLookupByRow(level.crafting_item_table, index, RECIPE_TYPE);
  if(self.current_crafting_recipe == recipename) {
    slot = int(TableLookupByRow(level.crafting_item_table, index, SLOTNUM));
  } else {
    recipename = TableLookupByRow(level.crafting_item_table, index, ALT_RECIPE_TYPE);

    if(self.current_crafting_recipe != recipename) {
      recipename = TableLookupByRow(level.crafting_item_table, index, ALT_ALT_RECIPE_TYPE);
      slot = int(TableLookupByRow(level.crafting_item_table, index, ALT_ALT_SLOTNUM));

      if(self.current_crafting_recipe != recipename)
        AssertEx(self.current_crafting_recipe == recipename, "Could not find the material slot");
    } else
      slot = int(TableLookupByRow(level.crafting_item_table, index, ALT_SLOTNUM));
  }

  return slot;
}

get_crafting_item_table_index() {
  required_for_match = self.craftingItems.size;
  possible_recipes = [];

  recipe_list = GetArrayKeys(level.crafting_ingredient_lists);

  foreach(recipe in recipe_list) {
    recipe_name = recipe;
    matching_items = 0;

    foreach(item in self.craftingItems) {
      if(array_contains(level.crafting_ingredient_lists[recipe_name], item))
        matching_items++;
    }

    if(matching_items == required_for_match) {
      index = int(TableLookup(level.alien_crafting_table, 1, recipe_name, 0));
      return index;
    }
  }
}

should_find_crafting_items() {
  if(isDefined(self.craftingItems) && isDefined(level.max_crafting_items) && self.craftingItems.size >= level.max_crafting_items)
    return false;
  else if(!isDefined(self.current_crafting_recipe))
    return false;

  return true;
}