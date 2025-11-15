/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\turret_shared.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace turret;

function autoexec __init__sytem__() {
  system::register("turret", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int", & field_toggle_lensflare, 0, 0);
}

function field_toggle_lensflare(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }
  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  if(!isDefined(settings)) {
    return;
  }
  if(isDefined(self.turret_lensflare_id)) {
    deletefx(localclientnum, self.turret_lensflare_id);
    self.turret_lensflare_id = undefined;
  }
  if(newval) {
    if(isDefined(settings.lensflare_fx) && isDefined(settings.lensflare_tag)) {
      self.turret_lensflare_id = playFXOnTag(localclientnum, settings.lensflare_fx, self, settings.lensflare_tag);
    }
  }
}