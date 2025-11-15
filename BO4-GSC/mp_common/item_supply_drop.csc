/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\item_supply_drop.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace item_supply_drop;

autoexec __init__system__() {
  system::register(#"item_supply_drop", &__init__, undefined, #"item_world");
}

private __init__() {
  if(!isDefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0) {
    return;
  }

  clientfield::register("scriptmover", "supply_drop_fx", 1, 1, "int", &supply_drop_fx, 0, 0);
  clientfield::register("scriptmover", "supply_drop_parachute_rob", 1, 1, "int", &supply_drop_parachute, 0, 0);
}

supply_drop_parachute(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self playrenderoverridebundle(#"hash_336cece53ae2342f");
    return;
  }

  self stoprenderoverridebundle(#"hash_336cece53ae2342f");
}

supply_drop_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    fxent = spawn(localclientnum, self.origin, "script_model");
    fxent setModel("tag_origin");
    fxent linkto(self);
    var_96514d8b = isDefined(getgametypesetting(#"hash_2e25d475b271a700")) ? getgametypesetting(#"hash_2e25d475b271a700") : 0;

    if(var_96514d8b) {
      fxent.supplydropfx = function_239993de(localclientnum, "smoke/fx8_column_md_green", fxent, "tag_origin");
    } else {
      fxent.supplydropfx = function_239993de(localclientnum, "smoke/fx8_column_md_red", fxent, "tag_origin");
    }

    self.fxent = fxent;
    playFX(localclientnum, "killstreaks/fx8_agr_drop_box_wz", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    playSound(localclientnum, #"hash_49b7275f4ddde9b8", self.origin);
    self.var_3a55f5cf = 1;
    return;
  }

  if(isDefined(self.fxent)) {
    if(isDefined(self.fxent.supplydropfx)) {
      stopfx(localclientnum, self.fxent.supplydropfx);
    }

    self.fxent delete();
  }
}