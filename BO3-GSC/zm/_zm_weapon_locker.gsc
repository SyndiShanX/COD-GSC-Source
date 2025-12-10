/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weapon_locker.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace _zm_weapon_locker;

function main() {
  if(!isDefined(level.weapon_locker_map)) {
    level.weapon_locker_map = level.script;
  }
  level.weapon_locker_online = sessionmodeisonlinegame();
  weapon_lockers = struct::get_array("weapons_locker", "targetname");
  array::thread_all(weapon_lockers, &triggerweaponslockerwatch);
}

function wl_has_stored_weapondata() {
  if(level.weapon_locker_online) {} else {
    return isDefined(self.stored_weapon_data);
  }
}

function wl_get_stored_weapondata() {
  if(level.weapon_locker_online) {} else {
    return self.stored_weapon_data;
  }
}

function wl_clear_stored_weapondata() {
  if(level.weapon_locker_online) {} else {
    self.stored_weapon_data = undefined;
  }
}

function wl_set_stored_weapondata(weapondata) {
  if(level.weapon_locker_online) {} else {
    self.stored_weapon_data = weapondata;
  }
}

function triggerweaponslockerwatch() {
  unitrigger_stub = spawnStruct();
  unitrigger_stub.origin = self.origin;
  if(isDefined(self.script_angles)) {
    unitrigger_stub.angles = self.script_angles;
  } else {
    unitrigger_stub.angles = self.angles;
  }
  unitrigger_stub.script_angles = unitrigger_stub.angles;
  if(isDefined(self.script_length)) {
    unitrigger_stub.script_length = self.script_length;
  } else {
    unitrigger_stub.script_length = 16;
  }
  if(isDefined(self.script_width)) {
    unitrigger_stub.script_width = self.script_width;
  } else {
    unitrigger_stub.script_width = 32;
  }
  if(isDefined(self.script_height)) {
    unitrigger_stub.script_height = self.script_height;
  } else {
    unitrigger_stub.script_height = 64;
  }
  unitrigger_stub.origin = unitrigger_stub.origin - (anglestoright(unitrigger_stub.angles) * (unitrigger_stub.script_length / 2));
  unitrigger_stub.targetname = "weapon_locker";
  unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
  unitrigger_stub.clientfieldname = "weapon_locker";
  zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
  unitrigger_stub.prompt_and_visibility_func = &triggerweaponslockerthinkupdateprompt;
  zm_unitrigger::register_static_unitrigger(unitrigger_stub, &triggerweaponslockerthink);
}

function triggerweaponslockerisvalidweapon(weapon) {
  weapon = zm_weapons::get_base_weapon(weapon);
  if(!zm_weapons::is_weapon_included(weapon)) {
    return false;
  }
  if(zm_utility::is_offhand_weapon(weapon) || zm_utility::is_limited_weapon(weapon)) {
    return false;
  }
  return true;
}

function triggerweaponslockerisvalidweaponpromptupdate(player, weapon) {
  retrievingweapon = player wl_has_stored_weapondata();
  if(!retrievingweapon) {
    weapon = player zm_weapons::get_nonalternate_weapon(weapon);
    if(weapon == level.weaponnone) {
      self setcursorhint("HINT_NOICON");
      if(!triggerweaponslockerisvalidweapon(weapon)) {
        self sethintstring(&"ZOMBIE_WEAPON_LOCKER_DENY");
      } else {
        self sethintstring(&"ZOMBIE_WEAPON_LOCKER_STORE");
      }
    } else {
      self setcursorhint("HINT_WEAPON", weapon);
      if(!triggerweaponslockerisvalidweapon(weapon)) {
        self sethintstring(&"ZOMBIE_WEAPON_LOCKER_DENY_FILL");
      } else {
        self sethintstring(&"ZOMBIE_WEAPON_LOCKER_STORE_FILL");
      }
    }
  } else {
    weapondata = player wl_get_stored_weapondata();
    if(isDefined(level.remap_weapon_locker_weapons)) {
      weapondata = remap_weapon(weapondata, level.remap_weapon_locker_weapons);
    }
    weapontogive = weapondata["weapon"];
    primaries = player getweaponslistprimaries();
    maxweapons = zm_utility::get_player_weapon_limit(player);
    weapon = player zm_weapons::get_nonalternate_weapon(weapon);
    if(isDefined(primaries) && primaries.size >= maxweapons || weapontogive == weapon) {
      if(!triggerweaponslockerisvalidweapon(weapon)) {
        if(weapon == level.weaponnone) {
          self setcursorhint("HINT_NOICON", weapon);
          self sethintstring(&"ZOMBIE_WEAPON_LOCKER_DENY");
        } else {
          self setcursorhint("HINT_WEAPON", weapon);
          self sethintstring(&"ZOMBIE_WEAPON_LOCKER_DENY_FILL");
        }
        return;
      }
    }
    self setcursorhint("HINT_WEAPON", weapontogive);
    self sethintstring(&"ZOMBIE_WEAPON_LOCKER_GRAB_FILL");
  }
}

function triggerweaponslockerthinkupdateprompt(player) {
  self triggerweaponslockerisvalidweaponpromptupdate(player, player getcurrentweapon());
  return true;
}

function triggerweaponslockerthink() {
  self.parent_player thread triggerweaponslockerweaponchangethink(self);
  while(true) {
    self waittill("trigger", player);
    retrievingweapon = player wl_has_stored_weapondata();
    if(!retrievingweapon) {
      curweapon = player getcurrentweapon();
      curweapon = player zm_weapons::switch_from_alt_weapon(curweapon);
      if(!triggerweaponslockerisvalidweapon(curweapon)) {
        continue;
      }
      weapondata = player zm_weapons::get_player_weapondata(player);
      player wl_set_stored_weapondata(weapondata);
      assert(curweapon == weapondata[""], "");
      player takeweapon(curweapon);
      primaries = player getweaponslistprimaries();
      if(isDefined(primaries[0])) {
        player switchtoweapon(primaries[0]);
      } else {
        player zm_weapons::give_fallback_weapon();
      }
      self triggerweaponslockerisvalidweaponpromptupdate(player, player getcurrentweapon());
      player playsoundtoplayer("evt_fridge_locker_close", player);
      player thread zm_audio::create_and_play_dialog("general", "weapon_storage");
    } else {
      curweapon = player getcurrentweapon();
      primaries = player getweaponslistprimaries();
      weapondata = player wl_get_stored_weapondata();
      if(isDefined(level.remap_weapon_locker_weapons)) {
        weapondata = remap_weapon(weapondata, level.remap_weapon_locker_weapons);
      }
      weapontogive = weapondata["weapon"];
      if(!triggerweaponslockerisvalidweapon(weapontogive)) {
        player playlocalsound(level.zmb_laugh_alias);
        player wl_clear_stored_weapondata();
        self triggerweaponslockerisvalidweaponpromptupdate(player, player getcurrentweapon());
        continue;
      }
      curweap_base = zm_weapons::get_base_weapon(curweapon);
      weap_base = zm_weapons::get_base_weapon(weapontogive);
      if(player zm_weapons::has_weapon_or_upgrade(weap_base) && weap_base != curweap_base) {
        self sethintstring(&"ZOMBIE_WEAPON_LOCKER_DENY");
        wait(3);
        self triggerweaponslockerisvalidweaponpromptupdate(player, player getcurrentweapon());
        continue;
      }
      maxweapons = zm_utility::get_player_weapon_limit(player);
      if(isDefined(primaries) && primaries.size >= maxweapons || weapontogive == curweapon) {
        curweapon = player zm_weapons::switch_from_alt_weapon(curweapon);
        if(!triggerweaponslockerisvalidweapon(curweapon)) {
          self sethintstring(&"ZOMBIE_WEAPON_LOCKER_DENY");
          wait(3);
          self triggerweaponslockerisvalidweaponpromptupdate(player, player getcurrentweapon());
          continue;
        }
        curweapondata = player zm_weapons::get_player_weapondata(player);
        player takeweapon(curweapondata["weapon"]);
        player zm_weapons::weapondata_give(weapondata);
        player wl_clear_stored_weapondata();
        player wl_set_stored_weapondata(curweapondata);
        player switchtoweapon(weapondata["weapon"]);
        self triggerweaponslockerisvalidweaponpromptupdate(player, player getcurrentweapon());
      } else {
        player thread zm_audio::create_and_play_dialog("general", "wall_withdrawl");
        player wl_clear_stored_weapondata();
        player zm_weapons::weapondata_give(weapondata);
        player switchtoweapon(weapondata["weapon"]);
        self triggerweaponslockerisvalidweaponpromptupdate(player, player getcurrentweapon());
      }
      level notify("weapon_locker_grab");
      player playsoundtoplayer("evt_fridge_locker_open", player);
    }
    wait(0.5);
  }
}

function triggerweaponslockerweaponchangethink(trigger) {
  self endon("disconnect");
  self endon("death");
  trigger endon("kill_trigger");
  while(true) {
    self waittill("weapon_change", newweapon);
    trigger triggerweaponslockerisvalidweaponpromptupdate(self, newweapon);
  }
}

function add_weapon_locker_mapping(fromweapon, toweapon) {
  if(!isDefined(level.remap_weapon_locker_weapons)) {
    level.remap_weapon_locker_weapons = [];
  }
  level.remap_weapon_locker_weapons[fromweapon] = toweapon;
}

function remap_weapon(weapondata, maptable) {
  weapon = weapondata["weapon"].rootweapon;
  att = undefined;
  if(weapondata["weapon"].attachments.size) {
    att = weapondata["weapon"].attachments[0];
  }
  if(!isDefined(maptable[weapon])) {
    return weapondata;
  }
  weapondata["weapon"] = maptable[weapon];
  weapon = weapondata["weapon"];
  if(zm_weapons::is_weapon_upgraded(weapon)) {
    if(isDefined(att) && zm_weapons::weapon_supports_attachments(weapon)) {
      base = zm_weapons::get_base_weapon(weapon);
      if(!zm_weapons::weapon_supports_this_attachment(base, att)) {
        att = zm_weapons::random_attachment(base);
      }
      weapondata["weapon"] = getweapon(weapondata["weapon"], att);
    } else if(zm_weapons::weapon_supports_default_attachment(weapon)) {
      att = zm_weapons::default_attachment(weapon);
      weapondata["weapon"] = getweapon(weapondata["weapon"], att);
    }
  }
  weapon = weapondata["weapon"];
  if(weapon != level.weaponnone) {
    weapondata["clip"] = int(min(weapondata["clip"], weapon.clipsize));
    weapondata["stock"] = int(min(weapondata["stock"], weapon.maxammo));
    weapondata["fuel"] = int(min(weapondata["fuel"], weapon.fuellife));
  }
  dw_weapon = weapon.dualwieldweapon;
  if(dw_weapon != level.weaponnone) {
    weapondata["lh_clip"] = int(min(weapondata["lh_clip"], dw_weapon.clipsize));
  }
  alt_weapon = weapon.altweapon;
  if(alt_weapon != level.weaponnone) {
    weapondata["alt_clip"] = int(min(weapondata["alt_clip"], alt_weapon.clipsize));
    weapondata["alt_stock"] = int(min(weapondata["alt_stock"], alt_weapon.maxammo));
  }
  return weapondata;
}