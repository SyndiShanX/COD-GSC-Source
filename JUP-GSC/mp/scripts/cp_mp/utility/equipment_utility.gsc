/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\utility\equipment_utility.gsc
**********************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\equipment;
#using scripts\engine\utility;
#namespace equipment_utility;

function function_cb722e58dd976a9a(weapon_ref, var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val) {
  function_ece21ff26dac708c(weapon_ref, var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val, #"int");
}

function function_e3093afa85e28051(weapon_ref, var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val) {
  function_ece21ff26dac708c(weapon_ref, var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val, #"float");
}

function function_d4497d44e79a8764(weapon_ref, var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val) {
  function_ece21ff26dac708c(weapon_ref, var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val, #"string");
}

function function_ece21ff26dac708c(weapon_ref, var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val, value_type) {
  if(!isDefined(weapon_ref) || weapon_ref == "") {
    return;
  }

  level.var_d66cb1858b2ba530[weapon_ref][var_fd773ed7f8ab59de] = function_97ed04e0f992484(dvar_str, bundle_val, default_val);

  if(isDefined(value_type)) {
    level.var_d66cb1858b2ba530[weapon_ref][var_fd773ed7f8ab59de].type = value_type;
  }
}

function function_97ed04e0f992484(dvar_str, bundle_val, default_val) {
  var_cc2712a8519a8fd1 = spawnStruct();

  if(isDefined(dvar_str)) {
    var_cc2712a8519a8fd1.dvarstr = dvar_str;
  }

  if(isDefined(bundle_val)) {
    var_cc2712a8519a8fd1.bundle_val = bundle_val;
  }

  if(isDefined(default_val)) {
    var_cc2712a8519a8fd1.default_val = default_val;
  } else {
    var_cc2712a8519a8fd1.default_val = 0;
  }

  return var_cc2712a8519a8fd1;
}

function function_74a4a69afb4bc82b(weapon_ref, var_fd773ed7f8ab59de) {
  if(!isDefined(level.var_d66cb1858b2ba530[weapon_ref])) {
    return 0;
  }

  var_cc2712a8519a8fd1 = level.var_d66cb1858b2ba530[weapon_ref][var_fd773ed7f8ab59de];

  if(!isDefined(var_cc2712a8519a8fd1)) {
    return 0;
  }

  if(isDefined(var_cc2712a8519a8fd1.bundle_val)) {
    return var_cc2712a8519a8fd1.bundle_val;
  }

  if(!isDefined(var_cc2712a8519a8fd1.dvarstr) || !isDefined(var_cc2712a8519a8fd1.type)) {
    return var_cc2712a8519a8fd1.default_val;
  }

  if(var_cc2712a8519a8fd1.type == #"float") {
    return getdvarfloat(var_cc2712a8519a8fd1.dvarstr, var_cc2712a8519a8fd1.default_val);
  } else if(var_cc2712a8519a8fd1.type == #"int") {
    return getdvarint(var_cc2712a8519a8fd1.dvarstr, var_cc2712a8519a8fd1.default_val);
  } else if(var_cc2712a8519a8fd1.type == #"string") {
    return getDvar(var_cc2712a8519a8fd1.dvarstr, var_cc2712a8519a8fd1.default_val);
  }

  return var_cc2712a8519a8fd1.default_val;
}

function function_faec1a1cb92464a4(weapon_ref) {
  bundle = undefined;
  ref = scripts\cp_mp\equipment::function_7f245729fcb6414d(weapon_ref);

  if(isDefined(ref)) {
    tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo(ref);

    if(isDefined(tableinfo)) {
      bundle = tableinfo.bundle;
    }
  }

  if(!isDefined(bundle)) {
    bundle = spawnStruct();
  }

  return bundle;
}