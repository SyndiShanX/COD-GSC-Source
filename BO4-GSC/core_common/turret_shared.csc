/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\turret_shared.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace turret;

autoexec __init__system__() {
  system::register(#"turret", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int", &field_toggle_lensflare, 0, 0);
}

field_toggle_lensflare(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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
      self.turret_lensflare_id = util::playFXOnTag(localclientnum, settings.lensflare_fx, self, settings.lensflare_tag);
    }
  }
}