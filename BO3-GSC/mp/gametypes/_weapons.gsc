/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_weapons.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_challenges;
#using scripts\mp\_scoreevents;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\mp\gametypes\_loadout;
#using scripts\mp\gametypes\_shellshock;
#using scripts\mp\gametypes\_weapon_utils;
#using scripts\mp\gametypes\_weaponobjects;
#using scripts\mp\killstreaks\_dogs;
#using scripts\mp\killstreaks\_killstreak_weapons;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_supplydrop;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weapons;
#using scripts\shared\weapons_shared;
#namespace weapons;

function autoexec __init__sytem__() {
  system::register("weapons", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
}

function bestweapon_kill(weapon) {}

function bestweapon_spawn(weapon, options, acvi) {}

function bestweapon_init(weapon, options, acvi) {
  weapon_data = [];
  weapon_data["weapon"] = weapon;
  weapon_data["options"] = options;
  weapon_data["acvi"] = acvi;
  weapon_data["kill_count"] = 0;
  weapon_data["spawned_with"] = 0;
  key = self.pers["bestWeapon"][weapon.name].size;
  self.pers["bestWeapon"][weapon.name][key] = weapon_data;
  return key;
}

function bestweapon_find(weapon, options, acvi) {
  if(!isDefined(self.pers["bestWeapon"])) {
    self.pers["bestWeapon"] = [];
  }
  if(!isDefined(self.pers["bestWeapon"][weapon.name])) {
    self.pers["bestWeapon"][weapon.name] = [];
  }
  name = weapon.name;
  size = self.pers["bestWeapon"][name].size;
  for(index = 0; index < size; index++) {
    if(self.pers["bestWeapon"][name][index]["weapon"] == weapon && self.pers["bestWeapon"][name][index]["options"] == options && self.pers["bestWeapon"][name][index]["acvi"] == acvi) {
      return index;
    }
  }
  return undefined;
}

function bestweapon_get() {
  most_kills = 0;
  most_spawns = 0;
  if(!isDefined(self.pers["bestWeapon"])) {
    return;
  }
  best_key = 0;
  best_index = 0;
  weapon_keys = getarraykeys(self.pers["bestWeapon"]);
  for(key_index = 0; key_index < weapon_keys.size; key_index++) {
    key = weapon_keys[key_index];
    size = self.pers["bestWeapon"][key].size;
    for(index = 0; index < size; index++) {
      kill_count = self.pers["bestWeapon"][key][index]["kill_count"];
      spawned_with = self.pers["bestWeapon"][key][index]["spawned_with"];
      if(kill_count > most_kills) {
        best_index = index;
        best_key = key;
        most_kills = kill_count;
        most_spawns = spawned_with;
        continue;
      }
      if(kill_count == most_kills && spawned_with > most_spawns) {
        best_index = index;
        best_key = key;
        most_kills = kill_count;
        most_spawns = spawned_with;
      }
    }
  }
  return self.pers["bestWeapon"][best_key][best_index];
}

function showcaseweapon_get() {
  showcaseweapondata = self getplayershowcaseweapon();
  if(!isDefined(showcaseweapondata)) {
    return undefined;
  }
  showcase_weapon = [];
  showcase_weapon["weapon"] = showcaseweapondata.weapon;
  attachmentnames = [];
  attachmentindices = [];
  tokenizedattachmentinfo = strtok(showcaseweapondata.attachmentinfo, ",");
  index = 0;
  while((index + 1) < tokenizedattachmentinfo.size) {
    attachmentnames[attachmentnames.size] = tokenizedattachmentinfo[index];
    attachmentindices[attachmentindices.size] = int(tokenizedattachmentinfo[index + 1]);
    index = index + 2;
  }
  index = tokenizedattachmentinfo.size;
  while((index + 1) < 16) {
    attachmentnames[attachmentnames.size] = "none";
    attachmentindices[attachmentindices.size] = 0;
    index = index + 2;
  }
  showcase_weapon["acvi"] = getattachmentcosmeticvariantindexes(showcaseweapondata.weapon, attachmentnames[0], attachmentindices[0], attachmentnames[1], attachmentindices[1], attachmentnames[2], attachmentindices[2], attachmentnames[3], attachmentindices[3], attachmentnames[4], attachmentindices[4], attachmentnames[5], attachmentindices[5], attachmentnames[6], attachmentindices[6], attachmentnames[7], attachmentindices[7]);
  camoindex = 0;
  paintjobslot = 15;
  paintjobindex = 15;
  showpaintshop = 0;
  tokenizedweaponrenderoptions = strtok(showcaseweapondata.weaponrenderoptions, ",");
  if(tokenizedweaponrenderoptions.size > 2) {
    camoindex = int(tokenizedweaponrenderoptions[0]);
    paintjobslot = int(tokenizedweaponrenderoptions[1]);
    paintjobindex = int(tokenizedweaponrenderoptions[2]);
    showpaintshop = paintjobslot != 15 && paintjobindex != 15;
  }
  showcase_weapon["options"] = self calcweaponoptions(camoindex, 0, 0, 0, 0, showpaintshop, 1);
  return showcase_weapon;
}