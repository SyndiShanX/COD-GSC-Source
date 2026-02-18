/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\satchel_charge.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;
#namespace satchel_charge;

function init_shared(localclientnum) {
  callback::add_weapon_type(#"satchel_charge", &function_34e248b6);
  clientfield::register("missile", "satchelChargeWarning", 1, 1, "int", &function_e402bf2c, 0, 0);
}

function function_34e248b6(localclientnum) {
  self endon(#"death");

  if(self isgrenadedud()) {
    return;
  }

  self util::waittill_dobj(localclientnum);

  if(isDefined(self.weapon.customsettings)) {
    var_966a1350 = getscriptbundle(self.weapon.customsettings);
    self.var_966a1350 = var_966a1350;

    if(isDefined(var_966a1350.var_b941081f) && isDefined(var_966a1350.var_40772cbe)) {
      self.light_fx = util::playFXOnTag(localclientnum, var_966a1350.var_b941081f, self, var_966a1350.var_40772cbe);
    }
  }

  if(self.owner == function_5c10bd79(localclientnum)) {
    self thread function_fab88840(localclientnum);
  }
}

function private function_fab88840(localclientnum) {
  function_c6ab0456(localclientnum, 1, 1);
  self waittill(#"death");
  function_c6ab0456(localclientnum, 1, 0);
}

function function_e402bf2c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("5ec15ced9ad90575");
  self endon("5ec15ced9ad90575");
  self endon(#"death");

  if(bwastimejump == 1) {
    self util::waittill_dobj(fieldname);

    if(isDefined(self.var_966a1350.var_b941081f) && isDefined(self.var_966a1350.var_40772cbe)) {
      while(isDefined(self)) {
        if(isDefined(self.light_fx)) {
          stopfx(fieldname, self.light_fx);
        }

        level waittilltimeout(0.1, #"player_switch");
        self.light_fx = util::playFXOnTag(fieldname, self.var_966a1350.var_b941081f, self, self.var_966a1350.var_40772cbe);
      }
    }
  }
}