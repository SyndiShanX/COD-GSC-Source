/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_cbdac3b4a48bb8f.gsc
************************************************/

#using scripts\cp_mp\equipment;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#namespace namespace_f808ba0ae0debcf5;

function function_1a53aa54f5e85b78() {
  if(isDefined(level.var_a06c1e2e5bb30bbd)) {
    [[level.var_a06c1e2e5bb30bbd]]();
    return;
  }

  function_900f562c61c6a5d6("lethal", &use_equipment, &function_122b813904873d2b, undefined, &function_39b9fdb77f6046ba, &function_1d00e4c0929ece86);
  function_900f562c61c6a5d6("tactical", &use_equipment, &function_122b813904873d2b, undefined, &function_bed0a54fd4a86617, &function_a57dfcd418fa8691);
  function_5958815b72ad58a0("lethal", #"bundlenamefromlootid", &function_62fa129f91896347);
  function_5958815b72ad58a0("tactical", #"bundlenamefromlootid", &function_62fa129f91896347);
  utility::registersharedfunc("game", "dropItem_equipment_lethal", &function_6aaed72439e0a22a);
}

function function_122b813904873d2b(itembundle, item, autouse, allowswap) {
  equipmentslot = function_f6c92134390e67b5(itembundle.type);
  currentequipment = scripts\mp\equipment::getcurrentequipment(equipmentslot);

  if(isDefined(currentequipment)) {
    if(autouse && currentequipment != itembundle.ref) {
      return false;
    }

    if(currentequipment == itembundle.ref) {
      ammo = scripts\mp\equipment::getequipmentammo(currentequipment);
      maxammo = scripts\mp\equipment::getequipmentmaxammo(currentequipment);
      return (ammo < maxammo);
    }
  }

  return false;
}

function use_equipment(itembundle, item, autouse) {
  var_5486524e0058f303 = function_f6c92134390e67b5(itembundle.type);
  var_f938d1f69f014a80 = itembundle.ref;
  var_3531700e2b091b5 = scripts\cp_mp\loot\common_item::function_b8bfea9514c89a77(item.count);
  var_fcaee046e7015d1d = scripts\mp\equipment::getequipmentmaxammo(var_f938d1f69f014a80);
  var_9a4bfefba093608 = 0;
  var_d13692417de5892b = scripts\mp\equipment::getcurrentequipment(var_5486524e0058f303);

  if(isDefined(var_d13692417de5892b) && var_d13692417de5892b == var_f938d1f69f014a80) {
    var_712f30cf602bc5e4 = scripts\mp\equipment::getequipmentammo(var_d13692417de5892b);
    var_3531700e2b091b5 += var_712f30cf602bc5e4;
  }

  if(var_3531700e2b091b5 > var_fcaee046e7015d1d) {
    var_9a4bfefba093608 = var_3531700e2b091b5 - var_fcaee046e7015d1d;
    var_3531700e2b091b5 = var_fcaee046e7015d1d;
  }

  variantid = undefined;

  if(isDefined(self.var_a6dd5c7e74106ce3)) {
    variantid = self.var_a6dd5c7e74106ce3[var_f938d1f69f014a80];
  }

  if(!isDefined(var_d13692417de5892b) || var_d13692417de5892b != var_f938d1f69f014a80) {
    scripts\mp\equipment::giveequipment(var_f938d1f69f014a80, var_5486524e0058f303, undefined, variantid);
  }

  scripts\mp\equipment::setequipmentammo(var_f938d1f69f014a80, var_3531700e2b091b5);
  return var_9a4bfefba093608;
}

function function_f6c92134390e67b5(itemtype) {
  switch (itemtype) {
    case #"hash_339227cb650975db":
      return "primary";
    case #"hash_850999d7864fa3b4":
      return "secondary";
  }

  return undefined;
}

function function_6bf5d4e670f4f0ff(slot) {
  itembundle = undefined;
  quantity = 0;
  var_52860556dee4b1a7 = scripts\mp\equipment::getcurrentequipment(slot);

  if(!isDefined(var_52860556dee4b1a7)) {
    return [itembundle, quantity];
  }

  itembundlename = function_61d960957fcf3ca0(var_52860556dee4b1a7);

  if(isDefined(itembundlename)) {
    itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
    quantity = scripts\mp\equipment::getequipmentammo(var_52860556dee4b1a7);
  }

  return [itembundle, quantity];
}

function function_39b9fdb77f6046ba() {
  return function_6bf5d4e670f4f0ff("primary");
}

function function_bed0a54fd4a86617() {
  return function_6bf5d4e670f4f0ff("secondary");
}

function function_1d00e4c0929ece86(quantity) {
  return remove_current("primary", quantity);
}

function function_a57dfcd418fa8691(quantity) {
  return remove_current("secondary", quantity);
}

function remove_current(equipmenttype, quantity) {
  if(!isDefined(equipmenttype)) {
    return 0;
  }

  equipmentref = getcurrentequipment(equipmenttype);

  if(!isDefined(equipmentref)) {
    return 0;
  }

  currentquantity = getequipmentammo(equipmentref);
  newquantity = 0;

  if(isDefined(quantity) && quantity >= 0 && quantity <= currentquantity) {
    newquantity = currentquantity - quantity;
  }

  if(newquantity == 0) {
    scripts\mp\equipment::takeequipment(equipmenttype);
  } else {
    scripts\mp\equipment::setequipmentammo(equipmentref, newquantity);
  }

  return currentquantity - newquantity;
}

function function_6aaed72439e0a22a(quantity) {
  [var_2814cca693e6ef2d, currentquantity] = function_39b9fdb77f6046ba();
  dropquantity = currentquantity;

  if(isDefined(quantity) && quantity < currentquantity) {
    dropquantity = quantity;
  }

  if(!isDefined(var_2814cca693e6ef2d)) {
    return;
  }

  if(dropquantity <= 0) {
    return;
  }

  items_dropitem(var_2814cca693e6ef2d, dropquantity);
}

function function_62fa129f91896347(lootid) {
  blueprintindex = function_64ccc54bdbae5cf6(lootid);

  if(isDefined(blueprintindex) && blueprintindex != 0) {
    variantref = loot::function_793e8a72cedb8ef3(lootid);
    baseref = equipment::function_f4f687e4e1edb923(variantref);

    if(isDefined(baseref) && baseref == "equip_stun" && !isDefined(level.commonitem.var_970a8dd2fe7c510b[baseref])) {
      return level.commonitem.var_970a8dd2fe7c510b["equip_concussion"];
    }

    return level.commonitem.var_970a8dd2fe7c510b[baseref];
  }

  return level.commonitem.var_b09fc2aeb718c263[lootid];
}