/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerups.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\util_shared;
#namespace zm_powerups;

function init() {
  add_zombie_powerup("insta_kill_ug", "powerup_instant_kill_ug", 1);
  level thread set_clientfield_code_callbacks();
  level._effect["powerup_on"] = "zombie/fx_powerup_on_green_zmb";
  if(isDefined(level.using_zombie_powerups) && level.using_zombie_powerups) {
    level._effect["powerup_on_red"] = "zombie/fx_powerup_on_red_zmb";
  }
  level._effect["powerup_on_solo"] = "zombie/fx_powerup_on_solo_zmb";
  level._effect["powerup_on_caution"] = "zombie/fx_powerup_on_caution_zmb";
  clientfield::register("scriptmover", "powerup_fx", 1, 3, "int", &powerup_fx_callback, 0, 0);
}

function add_zombie_powerup(powerup_name, client_field_name, clientfield_version = 1) {
  if(isDefined(level.zombie_include_powerups) && !isDefined(level.zombie_include_powerups[powerup_name])) {
    return;
  }
  struct = spawnStruct();
  if(!isDefined(level.zombie_powerups)) {
    level.zombie_powerups = [];
  }
  struct.powerup_name = powerup_name;
  level.zombie_powerups[powerup_name] = struct;
  if(isDefined(client_field_name)) {
    clientfield::register("toplayer", client_field_name, clientfield_version, 2, "int", &powerup_state_callback, 0, 1);
    struct.client_field_name = client_field_name;
  }
}

function set_clientfield_code_callbacks() {
  wait(0.1);
  powerup_keys = getarraykeys(level.zombie_powerups);
  powerup_clientfield_name = undefined;
  for(powerup_key_index = 0; powerup_key_index < powerup_keys.size; powerup_key_index++) {
    powerup_clientfield_name = level.zombie_powerups[powerup_keys[powerup_key_index]].client_field_name;
    if(isDefined(powerup_clientfield_name)) {
      setupclientfieldcodecallbacks("toplayer", 1, powerup_clientfield_name);
    }
  }
}

function include_zombie_powerup(powerup_name) {
  if(!isDefined(level.zombie_include_powerups)) {
    level.zombie_include_powerups = [];
  }
  level.zombie_include_powerups[powerup_name] = 1;
}

function powerup_state_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("powerup", fieldname, newval);
}

function powerup_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 1: {
      fx = level._effect["powerup_on"];
      break;
    }
    case 2: {
      fx = level._effect["powerup_on_solo"];
      break;
    }
    case 3: {
      fx = level._effect["powerup_on_red"];
      break;
    }
    case 4: {
      fx = level._effect["powerup_on_caution"];
      break;
    }
    default: {
      return;
    }
  }
  if(!isDefined(fx)) {
    return;
  }
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.fx)) {
    stopfx(localclientnum, self.fx);
  }
  self.fx = playFXOnTag(localclientnum, fx, self, "tag_origin");
}