/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1c2de7c18b07b05c.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_sira_ob_interactions_turret_trap_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_sira_ob_interactions_turret_trap_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_sira_ob_interactions_turret_trap_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_sira_ob_interactions_turret_trap_cs");

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

  s cs_setup_arrays(us, "mp_jup_sira_ob_interactions_turret_trap_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_sira_ob_interactions_turret_trap_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_sira_ob_interactions_turret_trap_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_TURRET_TRAP";
  var_d13c18af4084bdfd.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_sira_ob_interactions_turret_trap_cs";
  }

  switch (instancename) {
    case #"hash_ebaa1d064b14e3fd":
      function_b350362cc13bdb98(fe, us, cf);
      break;
    case #"hash_c1013c93b439ff58":
      function_20c261d81a594e05(fe, us, cf);
      break;
    case #"hash_5e7fda24c5bdbd41":
      function_5426ff795abd268e(fe, us, cf);
      break;
    case #"hash_4ac35cedaa7b403":
      function_b35a81d47111379c(fe, us, cf);
      break;
    case #"hash_c0105c042e453028":
      function_801df5eea1d6a3ef(fe, us, cf);
      break;
    case #"hash_73376518a00c231f":
      function_76cf5cc67ad6a25a(fe, us, cf);
      break;
  }
}

function function_b350362cc13bdb98(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-34959.3, -24122, 535.5), (0, 62.58, 0), "turret_trap_spawn", "s_turret_trap_sira_front", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-34959.3, -24122, 623.5), (0, 332.58, 0), "s_turret_trap_sira_front", undefined, "activity_turret_trap_sira_front", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-34940.7, -24104.6, 583.5), (0, 332.58, 0), "turret_trap_panel", "s_turret_trap_sira_front", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_20c261d81a594e05(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-35522, -26849.8, 513), (0, 255.72, 0), "turret_trap_spawn", "s_turret_trap_sira_gas_station", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-35522, -26849.8, 601), (0, 165.72, 0), "s_turret_trap_sira_gas_station", undefined, "activity_turret_trap_sira_gas_station", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-35535.7, -26871, 561), (0, 165.72, 0), "turret_trap_panel", "s_turret_trap_sira_gas_station", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_5426ff795abd268e(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-44419.9, -20037.6, 255.78), (0, 156.91, 0), "turret_trap_spawn", "s_turret_trap_sira_west", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-44419.9, -20037.6, 343.78), (0, 66.91, 0), "s_turret_trap_sira_west", undefined, "activity_turret_trap_sira_west", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-44438.6, -20020.3, 303.78), (0, 66.91, 0), "turret_trap_panel", "s_turret_trap_sira_west", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_b35a81d47111379c(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-29748.6, -16538.2, 614.75), (0, 242.46, 0), "turret_trap_spawn", "s_turret_trap_sira_east", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-29748.6, -16538.2, 702.75), (0, 152.46, 0), "s_turret_trap_sira_east", undefined, "activity_turret_trap_sira_east", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-29767.7, -16555.4, 662.75), (0, 152.46, 0), "turret_trap_panel", "s_turret_trap_sira_east", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_801df5eea1d6a3ef(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-30865.3, -25719, 439.25), (0, 242.24, 0), "turret_trap_spawn", "s_turret_trap_sira_roof", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-30865.3, -25719, 527.25), (0, 152.24, 0), "s_turret_trap_sira_roof", undefined, "activity_turret_trap_sira_roof", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-30884.5, -25736.1, 487.25), (0, 152.24, 0), "turret_trap_panel", "s_turret_trap_sira_roof", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_76cf5cc67ad6a25a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-25437.8, -20994.4, 567.5), (0, 269.78, 0), "turret_trap_spawn", "s_turret_trap_sira_south", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-25437.8, -20994.4, 655.5), (0, 179.78, 0), "s_turret_trap_sira_south", undefined, "activity_turret_trap_sira_south", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-25446.4, -21018.4, 615.5), (0, 179.78, 0), "turret_trap_panel", "s_turret_trap_sira_south", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_sira_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-34959.3, -24122, 639.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["TURRET_TRAP_SIRA_FRONT"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_sira_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-35522, -26849.8, 617);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["TURRET_TRAP_SIRA_GAS_STATION"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_sira_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-44419.9, -20037.6, 359.78);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["TURRET_TRAP_SIRA_WEST"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_sira_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-29748.6, -16538.2, 718.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["TURRET_TRAP_SIRA_EAST"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_sira_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-30865.3, -25719, 543.25);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["TURRET_TRAP_SIRA_ROOF"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_sira_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-25437.8, -20994.4, 671.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["TURRET_TRAP_SIRA_SOUTH"] = instancestruct;
  return activityinstances;
}