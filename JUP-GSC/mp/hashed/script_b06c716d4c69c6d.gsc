/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_b06c716d4c69c6d.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_exfil_industrial_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_exfil_industrial_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_exfil_industrial_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_exfil_industrial_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_exfil_industrial_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_exfil_industrial_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.target2 = "exfil_destination_1_exit_start";
  fe[[f]](s, us, cf, (-4091.3, 33340.3, 1425), (0, 261.37, 0), "exfil_destination_1", "exfil_destination_1_enter_start");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  fe[[f]](s, us, cf, (-4088.6, 40862.2, 2045.78), (350.04, 251.29, 0.88), "exfil_destination_1");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.name = "exfil_content_destination_industrial";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (-3584, 42358, 1861), (0, 0, 0), "ob_st_b_industrial_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.content_key = "exfil_interact";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (2606.5, 28426.9, 1006), (0, 352.1, 0), "exfil_content_struct_industrial_east", "exfil_content_instance_industrial_east");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  fe[[f]](s, us, cf, (105, 34960.1, 1256), (0, 199.98, 0), "exfil_destination_1");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  fe[[f]](s, us, cf, (-65.7, 40283.8, 2406), (355, 241.37, -0), "exfil_destination_1");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.content_key = "exfil_interact";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-9289, 37575, 1368), (0.6, 184.29, -3.76), "exfil_content_struct_industrial_west", "exfil_content_instance_industrial_west");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  fe[[f]](s, us, cf, (5196, 54707, 1944), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  fe[[f]](s, us, cf, (1344.1, 38761.3, 3482), (0, 3.9, 0), "exfil_1_auto2", "exfil_1_auto3");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_accel = float(75);
  s.script_speed = int(250);
  fe[[f]](s, us, cf, (2724.8, 38203.5, 3406), (0, 273.9, 0), "exfil_1_auto3", "exfil_1_auto4");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  fe[[f]](s, us, cf, (8195.8, 27840.4, 3718), (0, 273.9, 0), "exfil_1_auto4", "exfil_1_auto5");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  fe[[f]](s, us, cf, (8358.2, 23599.9, 3438), (0, 273.9, 0), "exfil_1_auto5", "exfil_1_auto6");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  fe[[f]](s, us, cf, (16145.6, 21349.1, 1276.86), (0, 333.9, 0), "exfil_1_auto6");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  fe[[f]](s, us, cf, (2289.7, 57190.3, 4250), (0, 273.9, 0), "exfil_destination_1_enter_start", "exfil_1_auto7");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  fe[[f]](s, us, cf, (13075.7, 60481.9, 4250), (0, 273.9, 0), "exfil_1_auto7", "exfil_1_auto8");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  fe[[f]](s, us, cf, (14872.9, 52455.5, 4250), (0, 243.9, 0), "exfil_1_auto8", "exfil_1_auto9");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  fe[[f]](s, us, cf, (8542.6, 43811.2, 4610), (0, 258.9, 0), "exfil_1_auto9");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (-9313.5, 37105.1, 2579), (0, 0, 0), "exfil_content_instance_industrial_west", "core_features_industrial_location");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (-3602, 41963, 1715), (0, 0, 0), "core_features_industrial_location", "ob_st_b_industrial_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (2588, 27856.6, 1544), (0, 314.57, 0), "exfil_content_instance_industrial_east", "core_features_industrial_location");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-41414, 36338, 4458), (0, 324.9, 0), undefined, "cspf_0_auto12084200315981243333", "exfil_content_struct_industrial_west");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-40989, 36035, 5985), (0, 324.9, 0), "cspf_0_auto12084200315981243333", "cspf_0_auto9439421660916165491");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-35606, 31458, 5934), (0, 324.9, 0), "cspf_0_auto9439421660916165491", "cspf_0_auto1162171163973581414");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-28421, 27768, 5274), (0, 358.9, 0), "cspf_0_auto1162171163973581414", "cspf_0_auto17792082497698880895");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-20670, 26180, 5095), (0, 359.4, 0), "cspf_0_auto17792082497698880895", "cspf_0_auto3044103984309199137");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-12801, 28360, 4813), (0, 105.4, 0), "cspf_0_auto3044103984309199137", "cspf_0_auto13792619656935203045");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-8825, 32338, 4414), (0, 161.4, 0), "cspf_0_auto13792619656935203045", "cspf_0_auto1241395187686590015");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-9018, 36995, 3949), (0, 177.12, 0), "cspf_0_auto1241395187686590015");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-28081.1, 43303.1, 2277), (0, 0.9, 0), undefined, "cspf_0_auto14310868345412780421", "exfil_content_struct_industrial_east");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-26747, 43335, 5066), (0, 0.9, 0), "cspf_0_auto14310868345412780421", "cspf_0_auto14841453219060481416");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-15353, 42139, 5015), (0, 0.9, 0), "cspf_0_auto14841453219060481416", "cspf_0_auto4995411593187183647");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-6581, 41014, 4964), (0, 0.9, 0), "cspf_0_auto4995411593187183647", "cspf_0_auto16056656821391295778");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-1812, 35635, 3606), (0, 0.9, 0), "cspf_0_auto16056656821391295778", "cspf_0_auto10797188140911198959");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_industrial_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-94, 31686, 2395), (0, 0.9, 0), "cspf_0_auto10797188140911198959");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_b_ob_exfil_industrial_cs");
}