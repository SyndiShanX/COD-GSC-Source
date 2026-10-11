/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_18ad5dc252ab2514.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_interactions_aethertear_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_interactions_aethertear_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_interactions_aethertear_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_interactions_aethertear_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_interactions_aethertear_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_interactions_aethertear_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_interactions_aethertear_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_AETHERTEAR";
  activityinfostruct.scriptbundle = "jup_activitydefinition_aethertear";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_d_ob_interactions_aethertear_cs";
  }

  switch (instancename) {
    case #"hash_b99def8fbbdc4ac1":
      function_54e41026e7074030(fe, us, cf);
      break;
    case #"hash_69cea87fc4a3f244":
      function_fcc21535e0b05557(fe, us, cf);
      break;
    case #"hash_1812d879c679bfd3":
      function_3eb9194adbbf32c4(fe, us, cf);
      break;
  }
}

function function_54e41026e7074030(fe, us, cf) {
  f = &strike_additem;
}

function function_fcc21535e0b05557(fe, us, cf) {
  f = &strike_additem;
}

function function_3eb9194adbbf32c4(fe, us, cf) {
  f = &strike_additem;
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
  instancestruct.cf = "mp_jup_st_d_ob_interactions_aethertear_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-31644.5, 16827.5, 966.25);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["AETHERTEAR_D_SHORE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
  instancestruct.cf = "mp_jup_st_d_ob_interactions_aethertear_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-31734, -3900, 936);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["AETHERTEAR_D_PIER"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
  instancestruct.cf = "mp_jup_st_d_ob_interactions_aethertear_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-30507, -16417.5, 1321);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["AETHERTEAR_D_WEST"] = instancestruct;
  return activityinstances;
}