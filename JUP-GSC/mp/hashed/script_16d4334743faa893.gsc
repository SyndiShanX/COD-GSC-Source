/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_16d4334743faa893.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_zip_door_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_zip_door_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_zip_door_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_zip_door_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_zip_door_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_zip_door_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (-15623.7, -22221.9, 5025.49), (0, 343.3, 0), "zip_door_destination", "cspf_0_auto4780828477474504615", "653");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.objectid = "zip_door";
  fe[[f]](s, us, cf, (3, 0, 0), (90, 0, 0), "zip_door_entry", "cspf_1_auto10583907438871018898", undefined, undefined, undefined, (-17374.7, -21308.3, 4424.91), (0, 44.5, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 46), (-90, 0, 0), "cspf_1_auto3737599740395406375", "cspf_1_auto11170290169130929106", undefined, undefined, undefined, (-17374.7, -21308.3, 4424.91), (0, 44.5, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, -13, 106), (-90, 0, 0), "cspf_1_auto11059709549162147396", "cspf_1_auto625250580259730343", undefined, undefined, undefined, (-17374.7, -21308.3, 4424.91), (0, 44.5, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 17, 106), (-90, 0, 0), "cspf_1_auto625250580259730343", "cspf_1_auto4486163629117164502", undefined, undefined, undefined, (-17374.7, -21308.3, 4424.91), (0, 44.5, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 78), (-90, 0, 0), "cspf_1_auto4486163629117164502", "cspf_1_auto14858222856449094156", undefined, undefined, undefined, (-17374.7, -21308.3, 4424.91), (0, 44.5, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 46), (-90, 0, 0), "cspf_1_auto14858222856449094156", "cspf_1_auto13980094656917523402", undefined, undefined, undefined, (-17374.7, -21308.3, 4424.91), (0, 44.5, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 14), (-90, 0, 0), "cspf_1_auto13980094656917523402", undefined, undefined, undefined, undefined, (-17374.7, -21308.3, 4424.91), (0, 44.5, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 14.5), (-90, 0, 0), "cspf_1_auto10583907438871018898", "cspf_1_auto3737599740395406375", undefined, undefined, undefined, (-17374.7, -21308.3, 4424.91), (0, 44.5, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 78), (-90, 0, 0), "cspf_1_auto11170290169130929106", "cspf_1_auto11059709549162147396", undefined, undefined, undefined, (-17374.7, -21308.3, 4424.91), (0, 44.5, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-15318.8, -22291.9, 4992.49), (0, 162.9, 0), "cspf_0_auto4780828477474504615", "cspf_0_auto6632474592269012091");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-15325.8, -22314.8, 4992.49), (0, 162.9, 0), "cspf_0_auto6632474592269012091", "cspf_0_auto8547027372271769495");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-15332.9, -22337.7, 4992.49), (0, 162.9, 0), "cspf_0_auto8547027372271769495");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (-21212.9, -38786.7, 2766.75), (0, 70.7, 0), "zip_door_destination", "cspf_0_auto16898891981077371830", "740");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-21171.5, -38601.3, 2792.75), (0, 250.3, 0), "cspf_0_auto16898891981077371830", "cspf_0_auto1802660907285860100");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-21148.9, -38609.3, 2792.75), (0, 250.3, 0), "cspf_0_auto1802660907285860100", "cspf_0_auto12688579439382049568");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-21126.4, -38617.4, 2792.75), (0, 250.3, 0), "cspf_0_auto12688579439382049568");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (-37959.3, -30192.6, 1059.88), (0, 343.3, 0), "zip_door_destination", "cspf_0_auto6211260431906260374", "431");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-37782.8, -30235.9, 1063.88), (345.64, 146.94, 2.04), "cspf_0_auto6211260431906260374", "cspf_0_auto6351664126492423840");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-37792.9, -30254.6, 1063.88), (347.9, 156.43, -0.28), "cspf_0_auto6351664126492423840", "cspf_0_auto8332244436969320318");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-37798, -30273.4, 1063.88), (346.92, 158.49, -0.77), "cspf_0_auto8332244436969320318");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (-22646.8, -7981, 1963), (0, 89.9, 0), "zip_door_destination", "cspf_0_auto18027967801389518581", "327");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-22669, -7852.32, 1970.76), (0, 270.39, 0), "cspf_0_auto18027967801389518581", "cspf_0_auto10063957341270035784");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-22648, -7852.72, 1970.76), (0, 270.39, 0), "cspf_0_auto10063957341270035784", "cspf_0_auto16149781674213963856");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-22628.5, -7852.44, 1970.76), (0, 270.39, 0), "cspf_0_auto16149781674213963856");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_zip_door_cs");
}