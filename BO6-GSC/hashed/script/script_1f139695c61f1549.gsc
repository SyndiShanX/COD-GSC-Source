/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_1f139695c61f1549.gsc
*****************************************************/

#namespace namespace_17a8c82d9ef726fc;

function function_63cc93d3c1bc09c0(var_db1265cc74b954c4) {
  if(isDefined(var_db1265cc74b954c4)) {
    if(isDefined(var_db1265cc74b954c4.variant_object)) {
      return var_db1265cc74b954c4.variant_object.activityrewardcaches;
    } else {
      return var_db1265cc74b954c4.activityrewardcaches;
    }
  }

  return undefined;
}

function function_28baba795643eace(var_db1265cc74b954c4) {
  if(!isDefined(var_db1265cc74b954c4)) {
    return undefined;
  }

  sharingsettings = var_db1265cc74b954c4.sharingsettings;

  if(!isDefined(sharingsettings)) {
    return undefined;
  }

  if(!isDefined(sharingsettings.var_4a39ab8e6be683c9)) {
    return undefined;
  }

  var_4a39ab8e6be683c9 = sharingsettings.var_4a39ab8e6be683c9.variant_object;
  return var_4a39ab8e6be683c9;
}

function function_1f0b92b970e0bc2a(var_db1265cc74b954c4) {
  parent = function_28baba795643eace(var_db1265cc74b954c4);

  if(isDefined(parent)) {
    return parent.activitycategory;
  }

  return undefined;
}

function function_7c8eec7a6f89aa68(var_db1265cc74b954c4) {
  parent = function_28baba795643eace(var_db1265cc74b954c4);

  if(isDefined(parent)) {
    return parent.sharingtype;
  }

  return undefined;
}

#namespace namespace_2c51db6714cb3bea;

function function_a5bcbdda929e1faf(var_2c51db6714cb3bea) {
  parent = function_e9b140a4e669eb3d(var_2c51db6714cb3bea);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.rewardcacheassetname;
    } else {
      return parent.rewardcacheassetname;
    }
  }

  return undefined;
}

function function_cdd4ed29a8cadd5(var_2c51db6714cb3bea) {
  parent = function_e9b140a4e669eb3d(var_2c51db6714cb3bea);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.var_d7c9cbc5cfad0958;
    } else {
      return parent.var_d7c9cbc5cfad0958;
    }
  }

  return undefined;
}

function function_4f9246af08cef149(var_2c51db6714cb3bea) {
  parent = function_75fe829e65a45db5(var_2c51db6714cb3bea);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.perplayerloot;
    } else {
      return parent.perplayerloot;
    }
  }

  return undefined;
}

function function_1693943f39824463(var_2c51db6714cb3bea) {
  parent = function_854ae0eb55452de5(var_2c51db6714cb3bea);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.rewardgrouptype;
    } else {
      return parent.rewardgrouptype;
    }
  }

  return undefined;
}

function function_8c80f69167046124(var_2c51db6714cb3bea) {
  parent = function_cb7c072f08879b4(var_2c51db6714cb3bea);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.rewardspawnlocationtype;
    } else {
      return parent.rewardspawnlocationtype;
    }
  }

  return undefined;
}

function function_6ec422928b339542(var_2c51db6714cb3bea) {
  parent = function_e2b8da99b64a18db(var_2c51db6714cb3bea);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.activationname;
    } else {
      return parent.activationname;
    }
  }

  return undefined;
}

function function_8cc696a7ebfd1f54(var_2c51db6714cb3bea) {
  parent = function_e2b8da99b64a18db(var_2c51db6714cb3bea);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.activitymoment;
    } else {
      return parent.activitymoment;
    }
  }

  return undefined;
}

function private function_e9b140a4e669eb3d(var_2c51db6714cb3bea) {
  return var_2c51db6714cb3bea;
}

function private function_75fe829e65a45db5(var_2c51db6714cb3bea) {
  parent = function_e9b140a4e669eb3d(var_2c51db6714cb3bea);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.rewardgroupoptions;
    } else {
      return parent.rewardgroupoptions;
    }
  }

  return undefined;
}

function private function_854ae0eb55452de5(var_2c51db6714cb3bea) {
  parent = function_75fe829e65a45db5(var_2c51db6714cb3bea);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.rewardgroupselection;
    } else {
      return parent.rewardgroupselection;
    }
  }

  return undefined;
}

function private function_2a2844f1374312db(var_2c51db6714cb3bea) {
  parent = function_e9b140a4e669eb3d(var_2c51db6714cb3bea);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.spawnlocationoptions;
    } else {
      return parent.spawnlocationoptions;
    }
  }

  return undefined;
}

function private function_cb7c072f08879b4(var_2c51db6714cb3bea) {
  parent = function_2a2844f1374312db(var_2c51db6714cb3bea);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.rewardspawnlocation;
    } else {
      return parent.rewardspawnlocation;
    }
  }

  return undefined;
}

function private function_3bb7e8f3a7b6db52(var_2c51db6714cb3bea) {
  parent = function_e9b140a4e669eb3d(var_2c51db6714cb3bea);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.spawnoptions;
    } else {
      return parent.spawnoptions;
    }
  }

  return undefined;
}

function private function_e2b8da99b64a18db(var_2c51db6714cb3bea) {
  parent = function_3bb7e8f3a7b6db52(var_2c51db6714cb3bea);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.spawnactivitymoment;
    } else {
      return parent.spawnactivitymoment;
    }
  }

  return undefined;
}