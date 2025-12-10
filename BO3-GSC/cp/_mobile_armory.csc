/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_mobile_armory.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace _mobile_armory;

function autoexec __init__sytem__() {
  system::register("cp_mobile_armory", &__init__, &__main__, undefined);
}

function __init__() {
  clientfield::register("toplayer", "mobile_armory_cac", 1, 4, "int", &function_dd709a6d, 0, 0);
}

function __main__() {}

function function_dd709a6d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isspectating(localclientnum, 0)) {
    return;
  }
  if(!isDefined(self.var_c8b2875a)) {
    self.var_c8b2875a = createluimenu(localclientnum, "ChooseClass_InGame");
  }
  if(isDefined(self.var_c8b2875a)) {
    if(newval) {
      setluimenudata(localclientnum, self.var_c8b2875a, "isInMobileArmory", 1);
      var_5ebe0017 = newval >> 1;
      if(var_5ebe0017) {
        var_91475d5f = newval >> 2;
        var_91475d5f = var_91475d5f + 6;
        setluimenudata(localclientnum, self.var_c8b2875a, "fieldOpsKitClassNum", var_91475d5f);
      }
      openluimenu(localclientnum, self.var_c8b2875a);
    } else {
      setluimenudata(localclientnum, self.var_c8b2875a, "close_current_menu", 1);
      closeluimenu(localclientnum, self.var_c8b2875a);
      self.var_c8b2875a = undefined;
    }
  }
}