/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\dynamic_loadout.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace dynamic_loadout;

autoexec __init__system__() {
  system::register(#"dynamic_loadout", &__init__, undefined, #"weapons");
}

private __init__() {
  registerclientfields();
}

private registerclientfields() {
  packagelist = getscriptbundlelist("bounty_hunter_package_list");

  if(isDefined(packagelist)) {
    var_2b5b08bd = int(ceil(log2(packagelist.size + 1)));
    var_ff35ecd8 = getgametypesetting(#"bountybagomoneymoney");
    level.var_16fd9420 = getgametypesetting(#"hash_63f8d60d122e755b");

    if(level.var_16fd9420 > 0) {
      var_bfbe32b4 = int(ceil(log2(var_ff35ecd8 / level.var_16fd9420)));
      clientfield::register("toplayer", "bountyBagMoney", 1, var_bfbe32b4, "int", &function_c25afb06, 0, 0);
    } else {
      clientfield::register("toplayer", "bountyBagMoney", 1, 1, "int", &function_c25afb06, 0, 0);
    }

    clientfield::register("toplayer", "bountyMoney", 1, 14, "int", &function_a6d394a9, 0, 0);
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.primary", 1, var_2b5b08bd, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.secondary", 1, var_2b5b08bd, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.armor", 1, var_2b5b08bd, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.mobilityTrack.tierPurchased", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.reconTrack.tierPurchased", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.assaultTrack.tierPurchased", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.supportTrack.tierPurchased", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.scorestreak", 1, var_2b5b08bd, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.equipment", 1, var_2b5b08bd, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "BountyHunterLoadout.timeRemaining", 1, 5, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.BountyCarryingBag", 1, 1, "int", undefined, 0, 0);
  }
}

private function_a6d394a9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  parent = getuimodelforcontroller(localclientnum);
  var_b58165cc = getuimodel(parent, "luielement.BountyHunterLoadout.money");

  if(!isDefined(var_b58165cc)) {
    var_b58165cc = createuimodel(parent, "luielement.BountyHunterLoadout.money");
  }

  setuimodelvalue(var_b58165cc, newval);
}

private function_c25afb06(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  parent = getuimodelforcontroller(localclientnum);
  var_d4d4591d = getuimodel(parent, "hudItems.bountyBagMoney");

  if(!isDefined(var_d4d4591d)) {
    var_d4d4591d = createuimodel(parent, "hudItems.bountyBagMoney");
  }

  if(level.var_16fd9420) {
    var_c9939aa4 = newval * level.var_16fd9420;
  } else {
    var_c9939aa4 = getgametypesetting(#"bountybagomoneymoney");
  }

  setuimodelvalue(var_d4d4591d, var_c9939aa4);
}