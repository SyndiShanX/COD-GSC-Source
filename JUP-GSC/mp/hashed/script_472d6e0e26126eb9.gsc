/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_472d6e0e26126eb9.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_i_ob_activities_merc_stronghold_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_i_ob_activities_merc_stronghold_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_i_ob_activities_merc_stronghold_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_i_ob_activities_merc_stronghold_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_i_ob_activities_merc_stronghold_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_i_ob_activities_merc_stronghold_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_i_ob_activities_merc_stronghold_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_MERC_STRONGHOLD";
  activityinfostruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  }

  switch (instancename) {
    case #"hash_495e6e22197a9406":
      function_443d945fdbd1c431(fe, us, cf);
      break;
    case #"hash_888b09e1275c0e45":
      function_b1f354d5735444b8(fe, us, cf);
      break;
    case #"hash_ca1dcb97ffe43a54":
      function_8de15336df806941(fe, us, cf);
      break;
    case #"hash_f9a53c53f8259049":
      function_517b7dc053f738e6(fe, us, cf);
      break;
  }
}

function function_443d945fdbd1c431(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (39457.5, -27892.2, 3290.17), (0, 0, 0), "MERC_STRONGHOLD_I_HOUSE_LG_01_main", "MERC_STRONGHOLD_HOUSE_LG_01", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2";
  fe[[f]](s, us, cf, (39480.9, -27750.8, 3126), (0, 108.39, 0), undefined, "MERC_STRONGHOLD_HOUSE_LG_01", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_i_house_lg_01_reinforcements";
  fe[[f]](s, us, cf, (38986.4, -28183.2, 2988.16), (0, 0, 0), undefined, "MERC_STRONGHOLD_HOUSE_LG_01", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_b1f354d5735444b8(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_i_manor_gym_01_reinforcements";
  fe[[f]](s, us, cf, (23462.5, -34096.8, 3442.94), (0, 334.5, 0), undefined, "MERC_STRONGHOLD_MANOR_GYM_01", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (23582, -32883.2, 4108.75), (0, 0, 0), "MERC_STRONGHOLD_I_MANOR_GYM_01_main", "MERC_STRONGHOLD_MANOR_GYM_01", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_a";
  fe[[f]](s, us, cf, (23939.8, -32904.7, 3644), (0, 157.49, 0), undefined, "MERC_STRONGHOLD_MANOR_GYM_01", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_8de15336df806941(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (29561, -26238.7, 3460), (0, 0, 0), "MERC_STRONGHOLD_I_MANOR_GUEST_HOUSE_02_main", "MERC_STRONGHOLD_MANOR_GUEST_HOUSE_02", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_b";
  fe[[f]](s, us, cf, (29301.7, -26532.3, 3268), (0, 58, 0), undefined, "MERC_STRONGHOLD_MANOR_GUEST_HOUSE_02", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_i_manor_guest_house_02_reinforcements";
  fe[[f]](s, us, cf, (28741.5, -25719.5, 3116), (0, 240, 0), undefined, "MERC_STRONGHOLD_MANOR_GUEST_HOUSE_02", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_517b7dc053f738e6(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (-276, -1373, 490), (0, 0, 0), "MERC_STRONGHOLD_I_MANOR_RANCH_HOUSE_LG_01_main", "MERC_STRONGHOLD_MANOR_RANCH_HOUSE_LG_01", undefined, undefined, undefined, (42128, -24921, 3242), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_a";
  fe[[f]](s, us, cf, (-186, -2065.5, 220), (0, 90, 0), undefined, "MERC_STRONGHOLD_MANOR_RANCH_HOUSE_LG_01", "s_safe_spawn", undefined, undefined, (42128, -24921, 3242), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_i_manor_ranch_01_reinforcements";
  fe[[f]](s, us, cf, (-1174.25, -1167, -3.46), (0, 0, 0), undefined, "MERC_STRONGHOLD_MANOR_RANCH_HOUSE_LG_01", "s_safe_reinforce", undefined, undefined, (42128, -24921, 3242), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (39512.5, -27826.2, 3406);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(39463.8, -27901.3, 3126)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1700];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(39509.3, -27833.1, 3126)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [450];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(39552.8, -27854.3, 3050)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [520];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(39463.8, -27901.3, 3126)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(39463.8, -27901.3, 3126)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.locationorigin = [(40068.8, -27672.8, 3205.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2500];
  activityinstances["MERC_STRONGHOLD_I_HOUSE_LG_01"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (23700, -32769.7, 4016);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(23707, -32865.2, 3452)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1400];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(23681, -32852.2, 3457)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [800];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(23633, -32756.2, 3457)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(23665, -32724.2, 3457)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(23671.2, -32722.4, 3457)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [825];
  instancestruct.locationorigin = [(23739, -32863.2, 3436.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_I_MANOR_GYM_01"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (29696.5, -26262.8, 3560);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(29716.3, -26323.3, 3132)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1700];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(29776.8, -26174.3, 3098)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [900];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(29735.8, -26381.3, 3260)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(29760.6, -26198.8, 3181.25)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [900];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(29716.3, -26323.3, 3132)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1300];
  instancestruct.locationorigin = [(29755.3, -26270.3, 3132)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_I_MANOR_GUEST_HOUSE_02"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_i_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (-194.5, -1305.75, 500);
  instancestruct.scriptstructoriginoffset = (42128, -24921, 3242);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-265, -1355, 2.87)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1700];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-343, -1355, 2.87)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-252.5, -1365.75, 2.87)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [900];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(-303, -1284.2, 50.88)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [850];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(-255, -1348.2, 3.4)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.locationorigin = [(-979, -1968, 9)];
  instancestruct.locationoriginoffset = [(42128, -24921, 3242)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [3000];
  activityinstances["MERC_STRONGHOLD_I_MANOR_RANCH_HOUSE_LG_01"] = instancestruct;
  return activityinstances;
}