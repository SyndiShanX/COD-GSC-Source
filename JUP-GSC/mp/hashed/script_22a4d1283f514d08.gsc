/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_22a4d1283f514d08.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_activities_merc_camp_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_activities_merc_camp_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_activities_merc_camp_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_activities_merc_camp_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_activities_merc_camp_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_activities_merc_camp_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_activities_merc_camp_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_MERC_CAMP";
  var_d13c18af4084bdfd.scriptbundle = "jup_activitydefinition_merccamp";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_a_ob_activities_merc_camp_cs";
  }

  switch (instancename) {
    case #"hash_b6cb53ea7073b9ab":
      function_8c22efecfa80ccb6(fe, us, cf);
      break;
    case #"hash_ed5ba2789de8a09f":
      function_4539ac97e75ef270(fe, us, cf);
      break;
    case #"hash_cf146edc4506d4d2":
      function_af21d86c3d119c83(fe, us, cf);
      break;
    case #"hash_16da7a1bd31f442e":
      function_9a326c85fa4c5b9(fe, us, cf);
      break;
    case #"hash_55cb0ad613d92668":
      function_9668b3e1992d4711(fe, us, cf);
      break;
  }
}

function function_8c22efecfa80ccb6(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-21676.5, 24025.6, 1721.8), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_gassouth", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-21420.5, 24579.3, 1723.55), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_gassouth", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-21268.2, 25107.3, 1722.05), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_gassouth", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "center_struct";
  fe[[f]](s, us, cf, (-22398.7, 25102.7, 1734.5), (0, 0, 0), "MERC_CAMP_A_GASSOUTH", undefined, "merc_camp_a_gassouth", "link_merc_camp_a_gassouth", undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  s.name = "drone_start";
  fe[[f]](s, us, cf, (-21341.6, 25375.9, 2358.5), (0, 155.74, 0), "s_merc_camp_drone", "cspf_6_auto8038584816154551323", undefined, undefined, "link_merc_camp_a_gassouth", (0, 0, 0), (0, 0, 0), undefined, 8, 1);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-21493.2, 25483, 2422.5), (0, 285, 0), "cspf_6_auto8038584816154551323", "cspf_6_auto9475429086340380124", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "vehicle";
  fe[[f]](s, us, cf, (-22463, 23696.4, 1702.97), (0, 12.85, 0), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp_a_gassouth", (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-21960, 23778.8, 1704.3), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_gassouth", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "sentry";
  fe[[f]](s, us, cf, (-22064.9, 24342.5, 1703.55), (0, 335, 0), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp_a_gassouth", (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "guard";
  fe[[f]](s, us, cf, (-22397.6, 25107.5, 1734.5), (0, 0, 0), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp_a_gassouth", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-22991, 24858.3, 1703.8), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_gassouth", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-21650.5, 25702.8, 2422.5), (0, 285, 0), "cspf_6_auto9475429086340380124", "cspf_6_auto8377294492951988080", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-22019.1, 25810.4, 2422.5), (0, 285, 0), "cspf_6_auto8377294492951988080", "cspf_6_auto9528920401691410425", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-22337.2, 25774.4, 2422.5), (0, 285, 0), "cspf_6_auto9528920401691410425", "cspf_6_auto7282521507673601907", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-22608.4, 25428.4, 2422.5), (0, 285, 0), "cspf_6_auto7282521507673601907", "cspf_6_auto9679868683369559650", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-22804.9, 24837.2, 2422.5), (0, 285, 0), "cspf_6_auto9679868683369559650", "cspf_6_auto8170217587222941650", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-23012.7, 24238.9, 2422.5), (0, 285, 0), "cspf_6_auto8170217587222941650", "cspf_6_auto9514722669131623905", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-22627.4, 23977.9, 2422.5), (0, 285, 0), "cspf_6_auto9514722669131623905", "cspf_6_auto4301057866440424847", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-22183.2, 23952.2, 2422.5), (0, 285, 0), "cspf_6_auto4301057866440424847", "cspf_6_auto13372315413982572857", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-21798.7, 24355.4, 2422.5), (0, 285, 0), "cspf_6_auto13372315413982572857", "cspf_6_auto12359525419286778896", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-21607.4, 24678.2, 2422.5), (0, 285, 0), "cspf_6_auto12359525419286778896", "cspf_6_auto7554377605422356850", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-21455.9, 25210.2, 2422.5), (0, 285, 0), "cspf_6_auto7554377605422356850", "cspf_6_auto8038584816154551323", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
}

function function_4539ac97e75ef270(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "center_struct";
  fe[[f]](s, us, cf, (-35610.2, 25382.4, 1073.5), (0, 0, 0), "MERC_CAMP_A_OCEAN_LOOKOUT", undefined, "merc_camp_a_ocean_lookout", "link_merc_camp_a_ocean_lookout", undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  s.name = "drone_start";
  fe[[f]](s, us, cf, (-36556.4, 26457.4, 1791), (0, 294.02, 0), "s_merc_camp_drone", "cspf_7_auto8038584816154551323", undefined, undefined, "link_merc_camp_a_ocean_lookout", (0, 0, 0), (0, 0, 0), undefined, 8, 1);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-34374.9, 26277.2, 1143.01), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_ocean_lookout", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "guard";
  fe[[f]](s, us, cf, (-35595.2, 25387.8, 1087.5), (0, 0, 0), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp_a_ocean_lookout", (0, 0, 0), (0, 0, 0), 250);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-36523.9, 25667.2, 1791), (0, 326, 0), "cspf_7_auto8038584816154551323", "cspf_7_auto666769489343115847", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-34573.4, 26400.4, 1129.51), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_ocean_lookout", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-34566.6, 26145.7, 1139.76), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_ocean_lookout", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-36416.9, 25133.2, 1791), (0, 326, 0), "cspf_7_auto666769489343115847", "cspf_7_auto12161067954791879467", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-34435.1, 25361.2, 1232.25), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_ocean_lookout", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-34626.1, 25543.9, 1141.51), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_ocean_lookout", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-34202.4, 24876.7, 1137.41), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_ocean_lookout", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-36083.4, 24680.4, 1791), (0, 326, 0), "cspf_7_auto12161067954791879467", "cspf_7_auto14042299805061550150", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-34400.4, 25049.4, 1141.51), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_ocean_lookout", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-34448.1, 24808.7, 1137.81), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_ocean_lookout", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-35801.9, 24490.4, 1791), (0, 326, 0), "cspf_7_auto14042299805061550150", "cspf_7_auto7867222239405832843", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-35306.1, 24557.9, 1791), (0, 326, 0), "cspf_7_auto7867222239405832843", "cspf_7_auto16163866110156696719", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-34821.1, 24958.7, 1791), (0, 326, 0), "cspf_7_auto16163866110156696719", "cspf_7_auto131438832295910597", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-34777.9, 25420.7, 1791), (0, 326, 0), "cspf_7_auto131438832295910597", "cspf_7_auto13574458814651521578", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-34887.9, 25825.7, 1791), (0, 326, 0), "cspf_7_auto13574458814651521578", "cspf_7_auto4934701445651326749", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-35190.6, 26115.2, 1791), (0, 326, 0), "cspf_7_auto4934701445651326749", "cspf_7_auto3855268217923924030", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-35573.1, 26211.9, 1791), (0, 326, 0), "cspf_7_auto3855268217923924030", "cspf_7_auto4110622552760969138", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-35914.6, 26179.2, 1791), (0, 326, 0), "cspf_7_auto4110622552760969138", "cspf_7_auto5994633411399260234", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-36295.9, 25893.2, 1791), (0, 326, 0), "cspf_7_auto5994633411399260234", "cspf_7_auto8038584816154551323", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
}

function function_af21d86c3d119c83(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-15247.8, 38440.4, 2477.68), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_apartments", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-15032.8, 38456.9, 2477.68), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_apartments", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "center_struct";
  fe[[f]](s, us, cf, (-15323.7, 37079.8, 2476.18), (0, 0, 0), "MERC_CAMP_A_APARTMENTS", undefined, "merc_camp_a_apartments", "link_merc_camp_a_apartments", undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  s.name = "drone_start";
  fe[[f]](s, us, cf, (-16106.5, 37449.9, 3131), (0, 2, 0), "s_merc_camp_drone", "cspf_8_auto8038584816154551323", undefined, undefined, "link_merc_camp_a_apartments", (0, 0, 0), (0, 0, 0), undefined, 8, 1);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-15908.5, 37478.5, 3131), (0, 285, 0), "cspf_8_auto8038584816154551323", "cspf_8_auto9475429086340380124", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-16034, 37204, 3131), (0, 285, 0), "cspf_8_auto9475429086340380124", "cspf_8_auto4914770817189242309", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "vehicle";
  fe[[f]](s, us, cf, (-15051.9, 36197.3, 2476.18), (0, 201.52, 0), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp_a_apartments", (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "guard";
  fe[[f]](s, us, cf, (-15325.1, 37083.7, 2476.18), (0, 0, 0), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp_a_apartments", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-15827.5, 36443, 3131), (0, 285, 0), "cspf_8_auto9062113168128581570", "cspf_8_auto11836481408256377258", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-15485.5, 36196.5, 3131), (0, 285, 0), "cspf_8_auto11836481408256377258", "cspf_8_auto15058387212358214884", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-14253.8, 37535.9, 2477.68), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_apartments", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-14293.3, 37186.4, 2477.68), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_apartments", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-15911.3, 36415.9, 2477.68), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_apartments", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-15708.8, 35779.4, 2480.18), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_apartments", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-15422.3, 35881.9, 2480.18), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_apartments", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-15093.3, 35832.9, 2480.18), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_apartments", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-14998, 36326.5, 3131), (0, 285, 0), "cspf_8_auto15058387212358214884", "cspf_8_auto9442379878929469324", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-14850.5, 36737, 3131), (0, 285, 0), "cspf_8_auto9442379878929469324", "cspf_8_auto3749701151787752642", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-14703, 37355.5, 3131), (0, 285, 0), "cspf_8_auto3749701151787752642", "cspf_8_auto2222220294326182460", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-14659, 37755, 3131), (0, 285, 0), "cspf_8_auto2222220294326182460", "cspf_8_auto11344231677614250248", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-14935, 37983.5, 3131), (0, 285, 0), "cspf_8_auto11344231677614250248", "cspf_8_auto6689687661984857551", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-15324, 37934, 3131), (0, 285, 0), "cspf_8_auto6689687661984857551", "cspf_8_auto4914745558846597308", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-15645, 37666.5, 3131), (0, 285, 0), "cspf_8_auto4914745558846597308", "cspf_8_auto8038584816154551323", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-15909, 36748, 3131), (0, 285, 0), "cspf_8_auto4914770817189242309", "cspf_8_auto9062113168128581570", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), undefined, 8);
}

function function_9a326c85fa4c5b9(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-25948.6, 33646.2, 2325.53), (0, 326, 0), "cspf_9_auto2116526253118389671", "cspf_9_auto15340820744053964302", undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-25504.2, 33249, 2305.12), (0, 326, 0), "cspf_9_auto15340820744053964302", "cspf_9_auto16383881479003705896", undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-24564.6, 33124.4, 2310.9), (0, 326, 0), "cspf_9_auto16383881479003705896", "cspf_9_auto15498146178689158808", undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-24160, 33874.9, 2266.17), (0, 326, 0), "cspf_9_auto15498146178689158808", "cspf_9_auto11056222142413142150", undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-25490, 34428.4, 1396), (0, 304.2, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "center";
  fe[[f]](s, us, cf, (-24914.6, 33824.6, 1440), (0, 0, 0), "MERC_CAMP_A_TOWER", undefined, "merc_camp_a_tower", "link_merc_camp_a_tower", undefined, (0, 0, 0), (0, 0, 0), 900);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  s.name = "drone";
  fe[[f]](s, us, cf, (-26195, 34722, 2306.42), (0, 292.41, 0), "s_merc_camp_drone", "cspf_9_auto16481357265335481505", undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), undefined, 8, 1);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-24267.2, 34502.7, 2227.78), (0, 326, 0), "cspf_9_auto11056222142413142150", "cspf_9_auto5773292267216070308", undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-24853.4, 34791.6, 2269.5), (0, 326, 0), "cspf_9_auto5773292267216070308", "cspf_9_auto12603057146419357385", undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-24423.2, 33810.3, 1353.56), (0, 304.2, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "guard";
  fe[[f]](s, us, cf, (-24922.6, 33893.7, 1440), (0, 0, 0), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), 250);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-24723.7, 33408.3, 1368.6), (0, 315.1, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-25160, 34152.1, 1396), (0, 333.3, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-25680.2, 34838.7, 2295.55), (0, 326, 0), "cspf_9_auto12603057146419357385", "cspf_9_auto16481357265335481505", undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "vehicle";
  fe[[f]](s, us, cf, (-26241.3, 34642.7, 1384.28), (0, 115.3, 0), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-26051.1, 34300.6, 2305.44), (0, 326, 0), "cspf_9_auto16481357265335481505", "cspf_9_auto2116526253118389671", undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-25226, 33664.8, 1396), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-24663.2, 34281.4, 1396), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_tower", (0, 0, 0), (0, 0, 0), 100);
}

function function_9668b3e1992d4711(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-32118.3, 43756.4, 1485.21), (0, 304.2, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "center";
  fe[[f]](s, us, cf, (-32052, 43692.7, 1485.21), (0, 0, 0), "MERC_CAMP_A_BACK_ALLEY", undefined, "merc_camp_a_back_alley", "link_merc_camp_a_back_alley", undefined, (0, 0, 0), (0, 0, 0), 900);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  s.name = "drone";
  fe[[f]](s, us, cf, (-31872.4, 44169.7, 2084.61), (0, 353.9, 0), "s_merc_camp_drone", "cspf_10_auto13160022056408203595", undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), undefined, 8, 1);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-32682, 43613.2, 2081.89), (0, 326, 0), "cspf_10_auto12994952005160048184", "cspf_10_auto12097004171405887058", undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-32699.3, 44115.9, 2081.89), (0, 326, 0), "cspf_10_auto12097004171405887058", "cspf_10_auto7518355132071458345", undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-31536.6, 43638.8, 1485.2), (0, 304.2, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "guard";
  fe[[f]](s, us, cf, (-32058.1, 43755.5, 1485.21), (0, 0, 0), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-32077.4, 43402.4, 1488), (0, 315.1, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-32461.5, 43203.2, 1485.2), (0, 333.3, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-31464.3, 44126.3, 2081.89), (0, 326, 0), "cspf_10_auto13160022056408203595", "cspf_10_auto5131940271413713926", undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-31365.3, 43941, 2081.89), (0, 326, 0), "cspf_10_auto5131940271413713926", "cspf_10_auto115682622115936516", undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-31408.7, 43726.6, 2081.89), (0, 326, 0), "cspf_10_auto115682622115936516", "cspf_10_auto8559783518106566948", undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-31531.9, 43432.6, 2081.89), (0, 326, 0), "cspf_10_auto8559783518106566948", "cspf_10_auto2061288173138125237", undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-31727.2, 43302.1, 2081.89), (0, 326, 0), "cspf_10_auto2061288173138125237", "cspf_10_auto4000599057216834915", undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-32055.6, 43321.1, 2081.89), (0, 326, 0), "cspf_10_auto4000599057216834915", "cspf_10_auto7935899852119283978", undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-32428.1, 43240.1, 2081.89), (0, 326, 0), "cspf_10_auto7935899852119283978", "cspf_10_auto12994952005160048184", undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.ishelistruct = 1;
  fe[[f]](s, us, cf, (-32096.5, 44155.1, 2081.89), (0, 326, 0), "cspf_10_auto7518355132071458345", "cspf_10_auto13160022056408203595", undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), undefined, 8);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-31303.5, 44084.7, 1483.05), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_camp_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-32546.2, 43946.1, 1485.21), (0, 0, 0), "s_merc_camp_mine", undefined, undefined, undefined, "link_merc_camp_a_back_alley", (0, 0, 0), (0, 0, 0), 100);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merccamp";
  instancestruct.cf = "mp_jup_st_a_ob_activities_merc_camp_cs";
  instancestruct.scriptstructorigin = (-22422.1, 25111.7, 1734.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-21910, 24724.2, 1703.5)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [2600];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-22208.9, 24814.8, 1703.5)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-21910, 24857.5, 1703.5)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1400];
  instancestruct.locationorigin = [(-21910, 24642.2, 1703.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1900];
  activityinstances["MERC_CAMP_A_GASSOUTH"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merccamp";
  instancestruct.cf = "mp_jup_st_a_ob_activities_merc_camp_cs";
  instancestruct.scriptstructorigin = (-35595.6, 25407.3, 1073.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-35505.2, 25398.8, 1136)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [2500];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-35505.2, 25376, 1131)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [2500];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-35505.2, 25369.5, 1136)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1500];
  instancestruct.locationorigin = [(-35505.2, 25401.1, 1136)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2500];
  activityinstances["MERC_CAMP_A_OCEAN_LOOKOUT"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merccamp";
  instancestruct.cf = "mp_jup_st_a_ob_activities_merc_camp_cs";
  instancestruct.scriptstructorigin = (-15356.4, 37078.7, 2476.18);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-15277.5, 37279.5, 2476)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [2400];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-15368.5, 37163, 2513)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [2500];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-15277.5, 37177, 2476)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1700];
  instancestruct.locationorigin = [(-15346, 37070.5, 2476)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2300];
  activityinstances["MERC_CAMP_A_APARTMENTS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merccamp";
  instancestruct.cf = "mp_jup_st_a_ob_activities_merc_camp_cs";
  instancestruct.scriptstructorigin = (-24927.6, 33841.7, 1440);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-25168.1, 34105.1, 1392)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [3500];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-25168.1, 34105.1, 1392)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [2500];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-25168.1, 34105.1, 1392)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1800];
  instancestruct.locationorigin = [(-25168.1, 34105.1, 1392)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2300];
  activityinstances["MERC_CAMP_A_TOWER"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merccamp";
  instancestruct.cf = "mp_jup_st_a_ob_activities_merc_camp_cs";
  instancestruct.scriptstructorigin = (-32086.9, 43710.3, 1485.21);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-32052, 43692.7, 1775.61)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1600];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-32052, 43692.7, 1485.21)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [1900];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-32052, 43692.7, 1485.21)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1000];
  instancestruct.locationorigin = [(-32052, 43692.7, 1485.21)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1500];
  activityinstances["MERC_CAMP_A_BACK_ALLEY"] = instancestruct;
  return activityinstances;
}