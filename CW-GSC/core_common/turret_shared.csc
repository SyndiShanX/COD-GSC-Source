/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\turret_shared.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace turret;

function private autoexec __init__system__() {
  system::register(#"turret", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int", &field_toggle_lensflare, 0, 0);
}

function field_toggle_lensflare(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  settings = getscriptbundle(self.scriptbundlesettings);

  if(!isDefined(settings)) {
    return;
  }

  if(isDefined(self.turret_lensflare_id)) {
    deletefx(fieldname, self.turret_lensflare_id);
    self.turret_lensflare_id = undefined;
  }

  if(bwastimejump) {
    if(isDefined(settings.lensflare_fx) && isDefined(settings.lensflare_tag)) {
      self.turret_lensflare_id = util::playFXOnTag(fieldname, settings.lensflare_fx, self, settings.lensflare_tag);
    }
  }
}