/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1f3c407ae09e7a0.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_activity_oldtown_bigbounty_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_activity_oldtown_bigbounty_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_activity_oldtown_bigbounty_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (8726, -8275.5, 1955.5), (0, 149.17, 0), "bigbounty_spawn", "OLDTOWN1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (4948, -6819, 2396.5), (0, 133.47, 0), "bigbounty_spawn", "OLDTOWN1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (15842.5, 6495.5, 2111.5), (1.96, 209.3, -3.48), "bigbounty_spawn", "OLDTOWN2", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (4946, -6817, 2396.5), (0, 133.47, 0), "bigbounty_spawn", "OLDTOWN1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (5205.5, -7583.5, 2393.5), (0, 118.06, 0), "bigbounty_spawn", "OLDTOWN1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (2454, -6550, 2016.5), (0, 140.73, 0), "bigbounty_spawn", "OLDTOWN1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (1813, -6586, 2012.5), (0, 304.86, 0), "bigbounty_spawn", "OLDTOWN1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (2423, -7023.5, 2009.5), (0, 97.5, 0), "bigbounty_spawn", "OLDTOWN1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (2681, -7106, 2009), (0, 138.6, 0), "bigbounty_spawn", "OLDTOWN1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (2279, -4395, 2035.5), (0, 120.08, 0), "bigbounty_spawn", "OLDTOWN1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (2279, -4395, 2032.5), (0, 120.78, 0), "bigbounty_spawn", "OLDTOWN1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (883.5, -3228, 1748.5), (0, 218.01, 0), "bigbounty_spawn", "OLDTOWN1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (3333.5, -3862.5, 2201.5), (0, 316.32, 0), "bigbounty_spawn", "OLDTOWN1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (6939.5, -585.5, 2010.5), (0, 310.21, 0), "bigbounty_spawn", "OLDTOWN1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (6994, -529, 2009.5), (0, 310.23, 0), "bigbounty_spawn", "OLDTOWN1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (8084, -3015, 2397.5), (0, 305.63, 0), "bigbounty_spawn", "OLDTOWN1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (6916.5, -1023, 2013.5), (0, 46.22, 0), "bigbounty_spawn", "OLDTOWN1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (8905.5, 4429, 1594.5), (0, 178.76, 0), "bigbounty_spawn", "OLDTOWN1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (7349, 2284.5, 1631), (0, 113.69, 0), "bigbounty_spawn", "OLDTOWN1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (7349, 2284.5, 1631), (0, 199.72, 0), "bigbounty_spawn", "OLDTOWN1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (9271.5, 5633, 1444), (0, 184.4, 0), "bigbounty_spawn", "OLDTOWN1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (6517.5, 5939, 1446.5), (0, 135.2, 0), "bigbounty_spawn", "OLDTOWN1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (4843, 4631, 1449.5), (0, 313.89, 0), "bigbounty_spawn", "OLDTOWN1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (4843, 4631, 1446.5), (0, 318.81, 0), "bigbounty_spawn", "OLDTOWN1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (6647.5, 2779, 1737.5), (0, 36.31, 0), "bigbounty_spawn", "OLDTOWN1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (8204, -268, 2013), (0, 142, 0), "bigbounty_spawn", "OLDTOWN1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (9214.5, -1492.5, 2211.5), (0, 99.75, 0), "bigbounty_spawn", "OLDTOWN1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (9198.5, -1362.5, 2211.5), (0, 90.5, 0), "bigbounty_spawn", "OLDTOWN1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (10222.5, 95.5, 2158), (0, 75.77, 0), "bigbounty_spawn", "OLDTOWN1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (12523, 415.5, 1768), (0, 71.28, 0), "bigbounty_spawn", "OLDTOWN1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (12521.5, 412, 1768), (0, 71.26, 0), "bigbounty_spawn", "OLDTOWN1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (12990.5, 329.5, 1805.5), (0, 82.16, 0), "bigbounty_spawn", "OLDTOWN1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (7342, -6392.5, 2398), (0, 41.91, 0), "bigbounty_spawn", "OLDTOWN1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (5616, -3986.5, 2398), (0, 41.89, 0), "bigbounty_spawn", "OLDTOWN1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (5598, -3979.5, 2398), (0, 41.86, 0), "bigbounty_spawn", "OLDTOWN1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (6809, -2986, 2392.5), (0, 359.5, 0), "bigbounty_spawn", "OLDTOWN1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (2049.5, 5808, 1625), (0, 173.68, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (2031.5, 5810, 1625), (0, 173.69, 0), "bigbounty_spawn", "OLDTOWN2", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (2011.5, 5812, 1625), (0, 173.69, 0), "bigbounty_spawn", "OLDTOWN2", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (768.5, 6287.5, 1624), (1, 345.55, 3.87), "bigbounty_spawn", "OLDTOWN2", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (1490, 2033, 2007), (0, 152.02, 0), "bigbounty_spawn", "OLDTOWN2", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (1490, 2033.5, 2007.5), (0, 152.02, 0), "bigbounty_spawn", "OLDTOWN2", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-654, 768, 2149.5), (357.3, 42.48, 2.95), "bigbounty_spawn", "OLDTOWN2", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-688, 1846.5, 2008), (0, 179.27, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-186.5, -166.5, 2020.5), (0, 314.08, 0), "bigbounty_spawn", "OLDTOWN2", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-166.5, -187.5, 2020.5), (0, 314.12, 0), "bigbounty_spawn", "OLDTOWN2", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-1535.5, -1233, 1828.5), (3.11, 308.93, 2.51), "bigbounty_spawn", "OLDTOWN2", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-2861, 3595, 2017.5), (0, 314.08, 0), "bigbounty_spawn", "OLDTOWN2", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-2864, 3643, 2017.5), (0, 314.08, 0), "bigbounty_spawn", "OLDTOWN2", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-2934, 3725, 2012), (0, 44.66, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-3887.5, 1375.5, 2010.5), (356.6, 58.14, 2.11), "bigbounty_spawn", "OLDTOWN2", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-4920, 942.5, 2009.5), (0, 350.95, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-5820.5, 989.5, 2019), (0, 336.9, 0), "bigbounty_spawn", "OLDTOWN2", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-5820.5, 989.5, 2019), (0, 328.6, 0), "bigbounty_spawn", "OLDTOWN2", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-101, -4113.5, 1681), (356.27, 68.92, 1.43), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-5801.5, -362.5, 2016.5), (359.54, 6.59, 3.97), "bigbounty_spawn", "OLDTOWN2", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-3182.5, -3638, 1660), (0, 199.67, 0), "bigbounty_spawn", "OLDTOWN2", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-3182.5, -3638, 1660), (0, 199.67, 0), "bigbounty_spawn", "OLDTOWN2", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-3260, -2462.5, 1686), (0, 344.23, 0), "bigbounty_spawn", "OLDTOWN2", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-5819.5, -2054, 1494.5), (0, 13.44, 0), "bigbounty_spawn", "OLDTOWN2", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-5819.5, -2054, 1493.5), (359.77, 13.43, 0.97), "bigbounty_spawn", "OLDTOWN2", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-2369.5, -6567.5, 1685.5), (0, 69.99, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (2877.5, -1485, 1797), (0, 50.19, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-6428.5, -2208.5, 1459.5), (0.16, 357.63, 3.99), "bigbounty_spawn", "OLDTOWN2", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (2993.5, 10126.5, 1454.5), (0, 225, 0), "bigbounty_spawn", "OLDTOWN2", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (2993.5, 10121.5, 1456.5), (0.71, 225, -0.71), "bigbounty_spawn", "OLDTOWN2", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (4882.5, 3104, 1447.5), (0, 230.01, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (28.5, 7154.5, 1624), (357.84, 32.68, 3.36), "bigbounty_spawn", "OLDTOWN2", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-1602.5, 5237.5, 2012.5), (0, 270.85, 0), "bigbounty_spawn", "OLDTOWN2", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-1602.5, 5237.5, 2010.5), (1, 270.85, 0.01), "bigbounty_spawn", "OLDTOWN2", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-1212.5, 6042, 2008), (1.87, 332.12, 3.53), "bigbounty_spawn", "OLDTOWN2", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (5160.5, 7770, 1455), (0, 224.25, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (9629, 4295, 1616), (0, 346.73, 0), "bigbounty_spawn", "OLDTOWN1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (14990.5, -616.5, 1520), (1, 270.85, 0.01), "bigbounty_spawn", "OLDTOWN2", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (14965, -597, 1520), (0, 335.9, 0), "bigbounty_spawn", "OLDTOWN2", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (15965, -623.5, 1648.5), (0, 230.43, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (11342, -1722.5, 1749), (0, 251.31, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (12609.5, 1718.5, 1638), (0, 216.5, 0), "bigbounty_spawn", "OLDTOWN2", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (12609.5, 1718.5, 1638), (0.73, 226.13, -0.68), "bigbounty_spawn", "OLDTOWN2", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (13017.5, 5651.5, 2342.5), (0, 179.11, 0), "bigbounty_spawn", "OLDTOWN2", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (12608, -2378.5, 1640.5), (0, 128.38, 0), "bigbounty_spawn", "OLDTOWN2", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (12143, 9565.5, 2651), (0, 214.9, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (8869, 10857, 1830), (0, 230.43, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (5161, 7769.5, 1455), (0, 224.25, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (11323.5, 7236, 2161), (0, 217.31, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (15918, 3026.5, 2115), (0, 243.58, 0), "bigbounty_spawn", "OLDTOWN2", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (14901.5, 5447.5, 2094), (0, 233.97, 0), "bigbounty_spawn", "OLDTOWN2", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (14901.5, 5447.5, 2094), (0.82, 233.85, -0.58), "bigbounty_spawn", "OLDTOWN2", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (16524.5, 4653, 1926), (0, 227.51, 0), "bigbounty_spawn", "OLDTOWN2", "megabomb");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_activity_oldtown_bigbounty_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_BIGBOUNTY";
  var_d13c18af4084bdfd.scriptbundle = "jup_activitydefinition_bigbounty";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  }

  switch (instancename) {
    case #"hash_ec427a32df9e115b":
      function_d7780a1a666f28a(fe, us, cf);
      break;
    case #"hash_73ce0785ade3044d":
      function_fd30c938b13ae188(fe, us, cf);
      break;
    case #"hash_9ed7fa0e042b8383":
      function_70b44e6c30ff4f2a(fe, us, cf);
      break;
    case #"hash_f149a843d2344ea0":
      function_17e263f1316f7c8d(fe, us, cf);
      break;
    case #"hash_7a9dcaa601e83927":
      function_584c67bf6cb238ca(fe, us, cf);
      break;
    case #"hash_97762bede71e845a":
      function_97cb899e12530a17(fe, us, cf);
      break;
  }
}

function function_d7780a1a666f28a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_OLDTOWN_DUMPSTER", "OLDTOWN1", undefined, undefined, (7838.5, -801.5, 2060.5), (0, 52.04, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_OLDTOWN_DUMPSTER", "BIGBOUNTY_OLDTOWN_DUMPSTER", undefined, undefined, (7838.5, -801.5, 2060.5), (0, 52.04, 0));
}

function function_fd30c938b13ae188(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_OLDTOWN_MARKET", "OLDTOWN2", undefined, undefined, (2217.5, 2354.5, 2179), (0, 194.41, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_OLDTOWN_MARKET", "BIGBOUNTY_OLDTOWN_MARKET", undefined, undefined, (2217.5, 2354.5, 2179), (0, 194.41, 0));
}

function function_70b44e6c30ff4f2a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_OLDTOWN_CORRIDOR", "OLDTOWN2", undefined, undefined, (-2435, -668, 1867.5), (0, 310.21, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_OLDTOWN_CORRIDOR", "BIGBOUNTY_OLDTOWN_CORRIDOR", undefined, undefined, (-2435, -668, 1867.5), (0, 310.21, 0));
}

function function_17e263f1316f7c8d(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_OLDTOWN_EAST", "OLDTOWN1", undefined, undefined, (15461.5, 6540.25, 2147), (0, 242.88, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_OLDTOWN_EAST", "BIGBOUNTY_OLDTOWN_EAST", undefined, undefined, (15461.5, 6540.25, 2147), (0, 242.88, 0));
}

function function_584c67bf6cb238ca(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 3.32, 0), "bigbounty_region", "BIGBOUNTY_OLDTOWN_AWNING", "OLDTOWN1", undefined, undefined, (4740, -5302, 2436), (0, 226.11, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_OLDTOWN_AWNING", "BIGBOUNTY_OLDTOWN_AWNING", undefined, undefined, (4740, -5302, 2436), (0, 226.11, 0));
}

function function_97cb899e12530a17(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", undefined, "OLDTOWN1", undefined, undefined, (-6718.25, -4672.75, 1634), (0, 44.72, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_OLDTOWN_WEST", "BIGBOUNTY_OLDTOWN_WEST", undefined, undefined, (-6718.25, -4672.75, 1634), (0, 44.72, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (7838.5, -801.5, 2060.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_OLDTOWN_DUMPSTER"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (2217.5, 2354.5, 2179);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_OLDTOWN_MARKET"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-2435, -668, 1867.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_OLDTOWN_CORRIDOR"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (15461.5, 6540.25, 2147);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_OLDTOWN_EAST"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (4740, -5302, 2436);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_OLDTOWN_AWNING"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_e_ob_activity_oldtown_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-6718.25, -4672.75, 1634);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_OLDTOWN_WEST"] = instancestruct;
  return activityinstances;
}