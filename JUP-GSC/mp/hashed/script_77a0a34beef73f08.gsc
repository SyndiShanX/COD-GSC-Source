/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_77a0a34beef73f08.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_activities_merc_camp_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_activities_merc_camp_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_activities_merc_camp_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_activities_merc_camp_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_activities_merc_camp_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_activities_merc_camp_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_activities_merc_camp_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_MERC_CAMP";
  activityinfostruct.scriptbundle = "jup_activitydefinition_merccamp";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_e_ob_activities_merc_camp_cs";
  }

  switch (instancename) {
    case #"hash_4a4cdd49870ea4fb":
      function_e76c01bbe5cd663c(fe, us, cf);
      break;
    case #"hash_aabdb7c4499da89f":
      function_a5638fe711c64484(fe, us, cf);
      break;
    case #"hash_b26ec014445d7e3e":
      function_45b60536b9f7cb09(fe, us, cf);
      break;
    case #"hash_e2891d52c6eb53de":
      function_51daa97443757383(fe, us, cf);
      break;
  }
}

function function_e76c01bbe5cd663c(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "center_struct";
  fe[[f]](s, us, cf, (20927.9, -12977.3, 3084.18), (0, 0, 0), "MERC_CAMP_E_COMM_OVERLOOK", undefined, "merc_camp_e_comm_overlook", "link_merc_camp_e_comm_overlook", undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  s.name = "drone_start";
  fe[[f]](s, us, cf, (20589, -12583.6, 3656.5), (0, 310.11, 0), "s_merc_camp_drone", "cspf_5_auto8038584816154551323", undefined, undefined, "link_merc_camp_e_comm_overlook", (0, 0, 0), (0, 0, 0), undefined, 25, 1);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (20679, -12653.2, 3656.5), (0, 285, 0), "cspf_5_auto8038584816154551323", "cspf_5_auto8879828834379887784", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 25);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (20932.5, -12908.5, 3656.5), (0, 285, 0), "cspf_5_auto8879828834379887784", "cspf_5_auto190805218385418443", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 25);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "vehicle";
  fe[[f]](s, us, cf, (20554.7, -13406, 3104.43), (3.06, 324.53, 1.32), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp_e_comm_overlook", (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (21922.9, -13314.8, 3076.86), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_comm_overlook", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "guard";
  fe[[f]](s, us, cf, (20904.5, -12969.7, 3078.57), (0, 0, 0), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp_e_comm_overlook", (0, 0, 0), (0, 0, 0), 250);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (21073.7, -13243.3, 3656.5), (0, 285, 0), "cspf_5_auto190805218385418443", "cspf_5_auto10734315144698114882", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 25);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (21396.9, -13777.5, 3656.5), (0, 285, 0), "cspf_5_auto10734315144698114882", "cspf_5_auto10633459718363942111", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 25);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "sentry";
  fe[[f]](s, us, cf, (20873.2, -13364.4, 3084.67), (346.99, 307.95, 0), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp_e_comm_overlook", (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (21636.2, -14013.6, 3130.41), (12.96, 0, -5.77), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_comm_overlook", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (22147, -13776.7, 3057.6), (8.52, 1.88, 2.81), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_comm_overlook", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (20984.1, -12447.9, 3000.15), (349.11, 358.78, -12.99), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_comm_overlook", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (20610.8, -12489.1, 3006.56), (353.34, 358.18, -28.31), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_comm_overlook", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (20463.7, -13722, 3161.62), (351.69, 354.64, -19.71), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_comm_overlook", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (21021.9, -14040.8, 3656.5), (0, 285, 0), "cspf_5_auto10633459718363942111", "cspf_5_auto11429436815275065811", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 25);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (20607.4, -13795.5, 3656.5), (0, 285, 0), "cspf_5_auto11429436815275065811", "cspf_5_auto16368171859333844422", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 25);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (20410.4, -13614.8, 3656.5), (0, 285, 0), "cspf_5_auto16368171859333844422", "cspf_5_auto17406045136804580270", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 25);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (20341.9, -13261.3, 3656.5), (0, 285, 0), "cspf_5_auto17406045136804580270", "cspf_5_auto632082546530757693", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 25);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (20341.9, -12774.8, 3656.5), (0, 285, 0), "cspf_5_auto632082546530757693", "cspf_5_auto8038584816154551323", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 25);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (20368.6, -13252.6, 3096.21), (0, 0, -3.4), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_comm_overlook", (0, 0, 0), (0, 0, 0), 100);
}

function function_a5638fe711c64484(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (15276, -9239.54, 1803.3), (358.96, 0.06, -3.16), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_park_center", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "center_struct";
  fe[[f]](s, us, cf, (14895.1, -8244.07, 1693.53), (0, 0, 0), "MERC_CAMP_E_PARK_CENTER", undefined, "merc_camp_e_park_center", "link_merc_camp_e_park_center", undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  s.name = "drone_start";
  fe[[f]](s, us, cf, (14537.2, -7566.35, 2345.25), (0, 2, 0), "s_merc_camp_drone", "cspf_6_auto8038584816154551323", undefined, undefined, "link_merc_camp_e_park_center", (0, 0, 0), (0, 0, 0), undefined, 15, 1);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (14834.7, -7573.5, 2345.25), (0, 285, 0), "cspf_6_auto8038584816154551323", "cspf_6_auto9475429086340380124", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (15238.2, -7715, 2345.25), (0, 285, 0), "cspf_6_auto9475429086340380124", "cspf_6_auto13048204226979966652", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (14935.8, -9216.52, 1792.55), (0, 0, -3.63), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_park_center", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "guard";
  fe[[f]](s, us, cf, (14895, -8295.89, 1693.39), (0, 0, 0), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp_e_park_center", (0, 0, 0), (0, 0, 0), 250);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (15466.5, -7935.75, 2345.25), (0, 285, 0), "cspf_6_auto13048204226979966652", "cspf_6_auto11160114436560061266", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (15603, -8246.25, 2345.25), (0, 285, 0), "cspf_6_auto11160114436560061266", "cspf_6_auto12114371481164024398", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (14231.3, -8269.05, 1683.54), (0, 0, -1.23), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_park_center", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (13927.7, -8412.37, 1688.87), (356.73, 0.68, -15.11), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_park_center", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (16065.2, -8541.67, 1818.59), (0, 0, -3.63), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_park_center", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (16025.4, -8129.88, 1768.98), (0, 0, -3.63), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_park_center", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (15828.7, -7630.73, 1723.25), (0, 0, -3.63), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_park_center", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (14691.1, -7539.94, 1690.04), (358.61, 0.19, -10.14), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_park_center", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "sentry";
  fe[[f]](s, us, cf, (14480, -8144, 1728), (358.06, 353.62, 1.24), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp_e_park_center", (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (15555.8, -8553.75, 2345.25), (0, 285, 0), "cspf_6_auto12114371481164024398", "cspf_6_auto6417955534279836265", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (15224.8, -8781.25, 2345.25), (0, 285, 0), "cspf_6_auto6417955534279836265", "cspf_6_auto12451900038808105909", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (14787.5, -8924.5, 2345.25), (0, 285, 0), "cspf_6_auto12451900038808105909", "cspf_6_auto5225695519014291068", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (14448, -8824.5, 2345.25), (0, 285, 0), "cspf_6_auto5225695519014291068", "cspf_6_auto7053039130706330682", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (14255.8, -8516.25, 2345.25), (0, 285, 0), "cspf_6_auto7053039130706330682", "cspf_6_auto12051317245141169840", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (14209.5, -8115, 2345.25), (0, 285, 0), "cspf_6_auto12051317245141169840", "cspf_6_auto12610072971783066568", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (14464.2, -7738.5, 2345.25), (0, 285, 0), "cspf_6_auto12610072971783066568", "cspf_6_auto8038584816154551323", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
}

function function_45b60536b9f7cb09(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "sentry";
  fe[[f]](s, us, cf, (-11110.8, 9550.65, 1024.5), (356.62, 72.77, 0.2), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp_e_overpass_bridge", (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-12513.3, 8599.3, 1024.62), (0, 0, -1.05), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_overpass_bridge", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "center_struct";
  fe[[f]](s, us, cf, (-11403.3, 9088.94, 1023.08), (0, 0, 0), "MERC_CAMP_E_OVERPASS_BRIDGE", undefined, "merc_camp_e_overpass_bridge", "link_merc_camp_e_overpass_bridge", undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  s.name = "drone_start";
  fe[[f]](s, us, cf, (-11523.2, 9796.7, 1678), (0, 2, 0), "s_merc_camp_drone", "cspf_7_auto8038584816154551323", undefined, undefined, "link_merc_camp_e_overpass_bridge", (0, 0, 0), (0, 0, 0), undefined, 15, 1);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-11260.2, 9727.75, 1678), (0, 285, 0), "cspf_7_auto8038584816154551323", "cspf_7_auto9475429086340380124", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "vehicle";
  fe[[f]](s, us, cf, (-11084, 9825.8, 1024), (0, 147.21, 0), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp_e_overpass_bridge", (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-12176.8, 8582.55, 1024.87), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_overpass_bridge", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "guard";
  fe[[f]](s, us, cf, (-11390.9, 9169.25, 1023), (0, 0, 0), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp_e_overpass_bridge", (0, 0, 0), (0, 0, 0), 250);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-11016.7, 9491.5, 1770), (0, 285, 0), "cspf_7_auto9475429086340380124", "cspf_7_auto16615169826925767068", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-11205.7, 8924, 1678), (0, 285, 0), "cspf_7_auto16615169826925767068", "cspf_7_auto11352262388400731387", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-11985.5, 8312.19, 1025.23), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_overpass_bridge", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-11171, 9991.08, 1024.49), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_overpass_bridge", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-11022.4, 9664.95, 1025.25), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_overpass_bridge", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-12168.9, 8880.07, 1353.49), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_overpass_bridge", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-11302.5, 8023.27, 1353.5), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_overpass_bridge", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-11440.2, 8660.5, 1678), (0, 285, 0), "cspf_7_auto11352262388400731387", "cspf_7_auto16908104036126118480", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-11805.5, 8600.25, 1678), (0, 285, 0), "cspf_7_auto16908104036126118480", "cspf_7_auto950963076103285245", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-12039.5, 8945.25, 1678), (0, 285, 0), "cspf_7_auto950963076103285245", "cspf_7_auto3377419267527122887", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-11966.8, 9178, 1678), (0, 285, 0), "cspf_7_auto3377419267527122887", "cspf_7_auto4308780288171669143", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-11497.8, 9638.75, 1678), (0, 285, 0), "cspf_7_auto4308780288171669143", "cspf_7_auto8038584816154551323", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
}

function function_51daa97443757383(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "zombie_spawner";
  fe[[f]](s, us, cf, (-6065.53, 12560.2, 1056.59), (0, 0, 0), "s_merc_camp_zombie", undefined, undefined, undefined, "link_merc_camp_e_cargo_checkpoint", (0, 0, 0), (0, 0, 0), 512);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-4439.02, 12209.2, 1057.5), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_cargo_checkpoint", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "zombie_spawner";
  fe[[f]](s, us, cf, (-1487.87, 12849.8, 1034.59), (0, 0, 0), "s_merc_camp_zombie", undefined, undefined, undefined, "link_merc_camp_e_cargo_checkpoint", (0, 0, 0), (0, 0, 0), 512);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "center_struct";
  fe[[f]](s, us, cf, (-3600.18, 11901.8, 1054.99), (0, 0, 0), "MERC_CAMP_E_CARGO_CHECKPOINT", undefined, "merc_camp_e_cargo_checkpoint", "link_merc_camp_e_cargo_checkpoint", undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  s.name = "drone_start";
  fe[[f]](s, us, cf, (-3631.76, 12260.1, 1710.75), (0, 270.6, 0), "s_merc_camp_drone", "cspf_8_auto8038584816154551323", undefined, undefined, "link_merc_camp_e_cargo_checkpoint", (0, 0, 0), (0, 0, 0), undefined, 15, 1);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-3454.75, 11947.3, 1710.75), (0, 285, 0), "cspf_8_auto8038584816154551323", "cspf_8_auto9475429086340380124", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-3293.75, 11529.3, 1710.75), (0, 285, 0), "cspf_8_auto9475429086340380124", "cspf_8_auto1826246117875472324", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "vehicle";
  fe[[f]](s, us, cf, (-4143.19, 12096.6, 1055), (0, 139.96, 0), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp_e_cargo_checkpoint", (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-4613.02, 11895.7, 1057.5), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_cargo_checkpoint", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "zombie_spawner";
  fe[[f]](s, us, cf, (-6035.31, 9681.62, 1055.88), (0, 0, 0), "s_merc_camp_zombie", undefined, undefined, undefined, "link_merc_camp_e_cargo_checkpoint", (0, 0, 0), (0, 0, 0), 512);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "guard";
  fe[[f]](s, us, cf, (-3570.01, 11893.9, 1054.99), (0, 0, 0), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp_e_cargo_checkpoint", (0, 0, 0), (0, 0, 0), 250);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "sentry";
  fe[[f]](s, us, cf, (-3755.35, 12063.2, 1055), (356.7, 246.46, 0), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp_e_cargo_checkpoint", (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-2155.27, 12139, 1057.5), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_cargo_checkpoint", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-2373.52, 12409.3, 1056.25), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_cargo_checkpoint", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-2547.87, 12085.4, 1064.25), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_cargo_checkpoint", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-4538.67, 10494.9, 1057.32), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_cargo_checkpoint", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-4580.17, 10841.7, 1057.07), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_e_cargo_checkpoint", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-3735.75, 11024.3, 1710.75), (0, 285, 0), "cspf_8_auto1826246117875472324", "cspf_8_auto4110548868700826185", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-4138.75, 11051.3, 1710.75), (0, 285, 0), "cspf_8_auto4110548868700826185", "cspf_8_auto10546850591593258092", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-4454.75, 11448.3, 1710.75), (0, 285, 0), "cspf_8_auto10546850591593258092", "cspf_8_auto14840979492895773119", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-4284.75, 12000.3, 1710.75), (0, 285, 0), "cspf_8_auto14840979492895773119", "cspf_8_auto14974257540613659488", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-3807.75, 12210.3, 1710.75), (0, 285, 0), "cspf_8_auto14974257540613659488", "cspf_8_auto8038584816154551323", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 15);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merccamp";
  instancestruct.cf = "mp_jup_st_e_ob_activities_merc_camp_cs";
  instancestruct.scriptstructorigin = (20840, -12988, 3068);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(21182.4, -12986, 3114.26)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(21102.2, -13427.6, 3109.87)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [2200];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(21182.4, -12986, 3114.26)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1700];
  instancestruct.locationorigin = [(21098.6, -13379.2, 3109.72)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1400];
  activityinstances["MERC_CAMP_E_COMM_OVERLOOK"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merccamp";
  instancestruct.cf = "mp_jup_st_e_ob_activities_merc_camp_cs";
  instancestruct.scriptstructorigin = (14819.5, -8282, 1696);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(15040.3, -8327.22, 1712.96)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1800];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(15499.9, -8200.1, 1693.46)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [2300];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(15039.3, -8326.47, 1711.46)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1600];
  instancestruct.locationorigin = [(14865.4, -8218.99, 1692.67)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1400];
  activityinstances["MERC_CAMP_E_PARK_CENTER"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merccamp";
  instancestruct.cf = "mp_jup_st_e_ob_activities_merc_camp_cs";
  instancestruct.scriptstructorigin = (-11378.5, 9076, 1023.69);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-11563.2, 9125.95, 1023)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1700];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-11494.2, 9050.71, 1023)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [2200];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-11562.9, 9127.41, 1023)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1500];
  instancestruct.locationorigin = [(-11539.4, 9026.99, 1023)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1400];
  activityinstances["MERC_CAMP_E_OVERPASS_BRIDGE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merccamp";
  instancestruct.cf = "mp_jup_st_e_ob_activities_merc_camp_cs";
  instancestruct.scriptstructorigin = (-3606.5, 11973.2, 1055);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-3590.24, 11698.9, 1055.81)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1800];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-3636.22, 11655.6, 1055.75)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [2200];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-3591.21, 11698.6, 1054.9)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1500];
  instancestruct.locationorigin = [(-3830.87, 11358.5, 1055.8)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1400];
  activityinstances["MERC_CAMP_E_CARGO_CHECKPOINT"] = instancestruct;
  return activityinstances;
}