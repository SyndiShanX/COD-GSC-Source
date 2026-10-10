/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_39d6e855d3a455a8.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs");

  if(!cs_is_starttime()) {
    endcreatescript(s);
  }
}

function cs_return_and_wait_for_flag(us, s, cf) {
  level endon("game_ended");
  wait_for_cs_flag(cf);

  if(!isDefined(us)) {
    us = "pfx";
  }

  s cs_setup_arrays(us, "mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_ESCORT_ZOMBIES";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs";
  }

  switch (instancename) {
    case #"hash_3657d39239c45827":
      function_8887d7e962667822(fe, us, cf);
      break;
  }
}

function function_8887d7e962667822(fe, us, cf) {
  f = &strike_additem;
  s = s();
  fe[[f]](s, us, cf, (5363, -8641, 2001), (0, 198, 0), "s_escort_zombies_oldtown", undefined, "escort_oldtown", undefined, undefined, (0, 0, 0));
  s = s();
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (5363, -8641, 1963), (0, 198, 0), "atv_spawn", undefined, "escort_oldtown", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (5378, -8636, 1975), (0, 288, 0), "escort_package", undefined, "escort_oldtown", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (5411, -8625, 1963), (0, 17, 0), "interact_escort", undefined, "escort_oldtown", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (-1674, -8508, 2833.72), (0, 225, 0), "s_escort_zombies_oldtown_reward", undefined, undefined, undefined, undefined, (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.cf = "mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs";
  instancestruct.locationorigin = [(5293, -8660, 1955.29)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1500];
  activityinstances["ESCORT_ZOMBIES_OLDTOWN"] = instancestruct;
  return activityinstances;
}