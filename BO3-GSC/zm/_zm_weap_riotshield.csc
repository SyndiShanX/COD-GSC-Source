/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_riotshield.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weapons;
#namespace zm_equip_shield;

function autoexec __init__sytem__() {
  system::register("zm_equip_shield", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_spawned( & player_on_spawned);
  clientfield::register("clientuimodel", "zmInventory.shield_health", 11000, 4, "float", undefined, 0, 0);
}

function player_on_spawned(localclientnum) {
  self thread watch_weapon_changes(localclientnum);
}

function watch_weapon_changes(localclientnum) {
  self endon("disconnect");
  self endon("entityshutdown");
  while (isdefined(self)) {
    self waittill("weapon_change", weapon);
    if(weapon.isriotshield) {
      self thread lock_weapon_models(localclientnum, weapon);
    }
  }
}

function lock_weapon_model(model) {
  if(isdefined(model)) {
    if(!isdefined(level.model_locks)) {
      level.model_locks = [];
    }
    if(!isdefined(level.model_locks[model])) {
      level.model_locks[model] = 0;
    }
    if(level.model_locks[model] < 1) {
      forcestreamxmodel(model);
    }
    level.model_locks[model]++;
  }
}

function unlock_weapon_model(model) {
  if(isdefined(model)) {
    if(!isdefined(level.model_locks)) {
      level.model_locks = [];
    }
    if(!isdefined(level.model_locks[model])) {
      level.model_locks[model] = 0;
    }
    level.model_locks[model]--;
    if(level.model_locks[model] < 1) {
      stopforcestreamingxmodel(model);
    }
  }
}

function lock_weapon_models(localclientnum, weapon) {
  lock_weapon_model(weapon.worlddamagedmodel1);
  lock_weapon_model(weapon.worlddamagedmodel2);
  lock_weapon_model(weapon.worlddamagedmodel3);
  self util::waittill_any("weapon_change", "disconnect", "entityshutdown");
  unlock_weapon_model(weapon.worlddamagedmodel1);
  unlock_weapon_model(weapon.worlddamagedmodel2);
  unlock_weapon_model(weapon.worlddamagedmodel3);
}