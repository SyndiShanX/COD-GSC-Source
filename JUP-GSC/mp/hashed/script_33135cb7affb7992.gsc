/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_33135cb7affb7992.gsc
*************************************************/

#using script_17dc47fb18ded931;
#using script_5f71ed065b9cea1e;
#using script_6b684505b9959a08;
#using scripts\engine\utility;
#namespace namespace_55960efed51f8481;

function function_18a04da230bdecbb(var_7ff959e229d749c3) {
  struct = function_dcbffa8a1a0be491(function_35f874585c5fcfe6(var_7ff959e229d749c3), function_1864c93384760910(var_7ff959e229d749c3), function_a4db25b7af304698(var_7ff959e229d749c3), function_f63abb63847ab316(var_7ff959e229d749c3), function_2dff7e1a10633ee1(var_7ff959e229d749c3), function_5b87e83d21054cb(var_7ff959e229d749c3), function_f29715a4f86830ed(var_7ff959e229d749c3));
  return struct;
}

function function_dcbffa8a1a0be491(var_de1f9176204264cf, var_c92e69a2dca65df1, perplayerloot, rewardgrouptype, var_2b5aa40272b0bbce, var_d701a569f30e890f, var_3c90b4a5ec990a09) {
  struct = spawnStruct();
  struct.var_fec7733a738249d6 = 1;
  struct.var_de1f9176204264cf = var_de1f9176204264cf;
  struct.var_c92e69a2dca65df1 = var_c92e69a2dca65df1;
  struct.perplayerloot = perplayerloot;
  struct.rewardgrouptype = rewardgrouptype;
  struct.var_2b5aa40272b0bbce = var_2b5aa40272b0bbce;
  struct.var_d701a569f30e890f = var_d701a569f30e890f;
  struct.var_3c90b4a5ec990a09 = var_3c90b4a5ec990a09;
  return struct;
}

function function_155ac29988933331(var_40bdc956443135c6) {
  if(isDefined(var_40bdc956443135c6)) {
    return var_40bdc956443135c6.var_de1f9176204264cf;
  }

  return undefined;
}

function function_57339c17a16d5b(var_40bdc956443135c6) {
  if(isDefined(var_40bdc956443135c6)) {
    return var_40bdc956443135c6.var_c92e69a2dca65df1;
  }

  return undefined;
}

function function_d2ce6c5a4f9d52e5(var_40bdc956443135c6) {
  if(isDefined(var_40bdc956443135c6)) {
    return var_40bdc956443135c6.perplayerloot;
  }

  return undefined;
}

function function_45864bd1ba317b7f(var_40bdc956443135c6) {
  if(isDefined(var_40bdc956443135c6)) {
    return var_40bdc956443135c6.rewardgrouptype;
  }

  return undefined;
}

function function_fe7983e3293f0584(var_40bdc956443135c6) {
  if(isDefined(var_40bdc956443135c6)) {
    return var_40bdc956443135c6.var_2b5aa40272b0bbce;
  }

  return undefined;
}

function function_bc4d3f90dc517d3d(var_40bdc956443135c6) {
  if(isDefined(var_40bdc956443135c6)) {
    return var_40bdc956443135c6.var_d701a569f30e890f;
  }

  return undefined;
}

function function_9f3743cde2de21b(var_40bdc956443135c6) {
  if(isDefined(var_40bdc956443135c6)) {
    return var_40bdc956443135c6.var_3c90b4a5ec990a09;
  }

  return undefined;
}

function function_e7c2ecccbf00007e(var_40bdc956443135c6) {
  var_9710a742dddb8c07 = function_155ac29988933331(var_40bdc956443135c6);

  if(!isDefined(var_9710a742dddb8c07)) {
    return undefined;
  }

  return reward_cache_settings::function_ec54b8019f59c0ef(var_9710a742dddb8c07);
}

function function_9e1216d6f33a3c78(var_40bdc956443135c6) {
  var_2adb829fe068100d = function_57339c17a16d5b(var_40bdc956443135c6);

  if(!isDefined(var_2adb829fe068100d)) {
    return undefined;
  }

  return namespace_81b7e1672a7e54da::function_4d6ae01e1e47320c(var_2adb829fe068100d);
}