/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_riotshield.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zm_equip_shield;

function private autoexec __init__system__() {
  system::register(#"zm_equip_shield", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_spawned(&player_on_spawned);
  clientfield::register("toplayer", "zm_shield_damage_rumble", 1, 1, "counter", &zm_shield_damage_rumble, 0, 0);
  clientfield::register("toplayer", "zm_shield_break_rumble", 1, 1, "counter", &zm_shield_break_rumble, 0, 0);
  clientfield::register_clientuimodel("ZMInventoryPersonal.shield_health", #"hash_1d3ddede734994d8", #"shield_health", 1, 4, "float", undefined, 0, 0);
}

function player_on_spawned(localclientnum) {
  self thread watch_weapon_changes(localclientnum);
}

function watch_weapon_changes(localclientnum) {
  self endon(#"death");

  while(isDefined(self)) {
    waitresult = self waittill(#"weapon_change");
    w_current = waitresult.weapon;
    w_previous = waitresult.last_weapon;

    if(w_current.isriotshield) {
      for(i = 0; i < w_current.var_21329beb.size; i++) {
        util::lock_model(w_current.var_21329beb[i]);
      }

      continue;
    }

    if(w_previous.isriotshield) {
      for(i = 0; i < w_previous.var_21329beb.size; i++) {
        util::unlock_model(w_previous.var_21329beb[i]);
      }
    }
  }
}

function zm_shield_damage_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self playrumbleonentity(fieldname, "zm_shield_damage");
  }
}

function zm_shield_break_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self playrumbleonentity(fieldname, "zm_shield_break");
  }
}