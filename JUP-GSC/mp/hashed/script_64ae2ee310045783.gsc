/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_64ae2ee310045783.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_seismic_refractor_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_seismic_refractor_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_seismic_refractor_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_seismic_refractor_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_seismic_refractor_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_seismic_refractor_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_SEISMIC_REFRACTOR";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_e_ob_seismic_refractor_cs";
  }

  switch (instancename) {
    case #"hash_8ad03b65bbe40304":
      function_b6a0fe0d9d944ab(fe, us, cf);
      break;
    case #"hash_b081a12274000cb9":
      function_7b49d85e4bda2c44(fe, us, cf);
      break;
    case #"hash_79a31bd15a5be30c":
      function_829cec4eebeb6af9(fe, us, cf);
      break;
    case #"hash_503df1308cd100d8":
      function_6b0f4f6f283926bd(fe, us, cf);
      break;
    case #"hash_5f108540989d4c83":
      function_3975bffbed220912(fe, us, cf);
      break;
    case #"hash_596abb4a6858f904":
      function_6412a9e5ecf5ba41(fe, us, cf);
      break;
    case #"hash_4ab766a30a714eee":
      function_a79653f329fcabdd(fe, us, cf);
      break;
    case #"hash_9d365094e6a61798":
      function_cc05a92fc572b91(fe, us, cf);
      break;
  }
}

function function_b6a0fe0d9d944ab(fe, us, cf) {
  f = &strike_additem;
  s = s();
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "SEISMIC_REFRACTOR_LOWTOWN", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_7b49d85e4bda2c44(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.script_linkto = "1";
  fe[[f]](s, us, cf, (4875, 4092, 1303), (0, 0, 0), "SEISMIC_REFRACTOR_OLDTOWN_ROADSIDE", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_829cec4eebeb6af9(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.script_linkto = "1";
  fe[[f]](s, us, cf, (20063, -9625, 2249), (0, 0, 0), "SEISMIC_REFRACTOR_LOWTOWN_ROADSIDE", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6b0f4f6f283926bd(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.script_linkto = "1";
  fe[[f]](s, us, cf, (1172, -2048, 1662), (0, 0, 0), "SEISMIC_REFRACTOR_OLDTOWN_CITYSIDE", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_3975bffbed220912(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.script_linkto = "1";
  fe[[f]](s, us, cf, (9840, -6975, 1845.5), (0, 0, 0), "SEISMIC_REFRACTOR_OLDTOWN_FOOTHILL", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6412a9e5ecf5ba41(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.script_linkto = "1";
  fe[[f]](s, us, cf, (3177, 2850, 1449), (0, 0, 0), "SEISMIC_REFRACTOR_OLDTOWN_STAIRWAY", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_a79653f329fcabdd(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.script_linkto = "1";
  fe[[f]](s, us, cf, (19055, -611, 1846), (0, 0, 0), "SEISMIC_REFRACTOR_LOWTOWN_RIVERSIDE", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_cc05a92fc572b91(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.script_linkto = "1";
  fe[[f]](s, us, cf, (16939, -7746, 1862), (0, 0, 0), "SEISMIC_REFRACTOR_LOWTOWN_SUBURB", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_seismicrefractor_wb";
  instancestruct.cf = "mp_jup_st_e_ob_seismic_refractor_cs";
  instancestruct.scriptstructorigin = (23645, 1252.5, 2501.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.participationradius = spawnStruct();
  instancestruct.participationradius.locationorigin = [(23650.5, 1251, 2501)];
  instancestruct.participationradius.locationradius = [2000];
  instancestruct.joinradius = spawnStruct();
  instancestruct.joinradius.locationorigin = [(23646.5, 1251.5, 2501.5)];
  instancestruct.joinradius.locationradius = [1000];
  instancestruct.locationorigin = [(23650, 1251.5, 2501)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [800];
  activityinstances["SEISMIC_REFRACTOR_LOWTOWN"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_seismicrefractor_wb";
  instancestruct.cf = "mp_jup_st_e_ob_seismic_refractor_cs";
  instancestruct.scriptstructorigin = (4875, 4092, 1303);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.participationradius = spawnStruct();
  instancestruct.participationradius.locationorigin = [(4875, 4092, 1303)];
  instancestruct.participationradius.locationradius = [2000];
  instancestruct.joinradius = spawnStruct();
  instancestruct.joinradius.locationorigin = [(4875, 4092, 1303)];
  instancestruct.joinradius.locationradius = [1000];
  instancestruct.locationorigin = [(4875, 4092, 1303)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["SEISMIC_REFRACTOR_OLDTOWN_ROADSIDE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_seismicrefractor_wb";
  instancestruct.cf = "mp_jup_st_e_ob_seismic_refractor_cs";
  instancestruct.scriptstructorigin = (20063, -9625, 2249);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.participationradius = spawnStruct();
  instancestruct.participationradius.locationorigin = [(20063, -9625, 2249)];
  instancestruct.participationradius.locationradius = [2000];
  instancestruct.joinradius = spawnStruct();
  instancestruct.joinradius.locationorigin = [(20063, -9625, 2249)];
  instancestruct.joinradius.locationradius = [1000];
  instancestruct.locationorigin = [(20063, -9625, 2249)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["SEISMIC_REFRACTOR_LOWTOWN_ROADSIDE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_seismicrefractor_wb";
  instancestruct.cf = "mp_jup_st_e_ob_seismic_refractor_cs";
  instancestruct.scriptstructorigin = (1172, -2048, 1662);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.participationradius = spawnStruct();
  instancestruct.participationradius.locationorigin = [(1172, -2048, 1662)];
  instancestruct.participationradius.locationradius = [2000];
  instancestruct.joinradius = spawnStruct();
  instancestruct.joinradius.locationorigin = [(1172, -2048, 1662)];
  instancestruct.joinradius.locationradius = [1000];
  instancestruct.locationorigin = [(1172, -2048, 1662)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["SEISMIC_REFRACTOR_OLDTOWN_CITYSIDE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_seismicrefractor_wb";
  instancestruct.cf = "mp_jup_st_e_ob_seismic_refractor_cs";
  instancestruct.scriptstructorigin = (9840, -6975, 1845.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.participationradius = spawnStruct();
  instancestruct.participationradius.locationorigin = [(9840, -6975, 1845.5)];
  instancestruct.participationradius.locationradius = [2000];
  instancestruct.joinradius = spawnStruct();
  instancestruct.joinradius.locationorigin = [(9840, -6975, 1845.5)];
  instancestruct.joinradius.locationradius = [1000];
  instancestruct.locationorigin = [(9840, -6975, 1845.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["SEISMIC_REFRACTOR_OLDTOWN_FOOTHILL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_seismicrefractor_wb";
  instancestruct.cf = "mp_jup_st_e_ob_seismic_refractor_cs";
  instancestruct.scriptstructorigin = (3177, 2850, 1449);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.participationradius = spawnStruct();
  instancestruct.participationradius.locationorigin = [(3177, 2850, 1449)];
  instancestruct.participationradius.locationradius = [2000];
  instancestruct.joinradius = spawnStruct();
  instancestruct.joinradius.locationorigin = [(3177, 2850, 1449)];
  instancestruct.joinradius.locationradius = [1000];
  instancestruct.locationorigin = [(3177, 2850, 1449)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["SEISMIC_REFRACTOR_OLDTOWN_STAIRWAY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_seismicrefractor_wb";
  instancestruct.cf = "mp_jup_st_e_ob_seismic_refractor_cs";
  instancestruct.scriptstructorigin = (19055, -611, 1846);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.participationradius = spawnStruct();
  instancestruct.participationradius.locationorigin = [(19055, -611, 1846)];
  instancestruct.participationradius.locationradius = [2000];
  instancestruct.joinradius = spawnStruct();
  instancestruct.joinradius.locationorigin = [(19055, -611, 1873.5)];
  instancestruct.joinradius.locationradius = [1000];
  instancestruct.locationorigin = [(19055, -611, 1846)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["SEISMIC_REFRACTOR_LOWTOWN_RIVERSIDE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_seismicrefractor_wb";
  instancestruct.cf = "mp_jup_st_e_ob_seismic_refractor_cs";
  instancestruct.scriptstructorigin = (16939, -7746, 1862);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.participationradius = spawnStruct();
  instancestruct.participationradius.locationorigin = [(16939, -7746, 1862)];
  instancestruct.participationradius.locationradius = [2000];
  instancestruct.joinradius = spawnStruct();
  instancestruct.joinradius.locationorigin = [(16939, -7746, 1862)];
  instancestruct.joinradius.locationradius = [1000];
  instancestruct.locationorigin = [(16939, -7746, 1862)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["SEISMIC_REFRACTOR_LOWTOWN_SUBURB"] = instancestruct;
  return activityinstances;
}