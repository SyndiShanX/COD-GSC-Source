/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2f1eb9e550fc34a8.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_fort_ob_interactions_turret_trap_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_fort_ob_interactions_turret_trap_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_fort_ob_interactions_turret_trap_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_fort_ob_interactions_turret_trap_cs");

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

  s cs_setup_arrays(us, "mp_jup_fort_ob_interactions_turret_trap_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_fort_ob_interactions_turret_trap_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_TURRET_TRAP";
  activityinfostruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_fort_ob_interactions_turret_trap_cs";
  }

  switch (instancename) {
    case #"hash_e24388b315d99499":
      function_f88c6f5fbe851ac4(fe, us, cf);
      break;
    case #"hash_aba6b945b4fb1884":
      function_1a9b3470d746ffc1(fe, us, cf);
      break;
    case #"hash_ad1a92b4a88d6a2d":
      function_6b789baf710347a(fe, us, cf);
      break;
    case #"hash_1831b65e9e90e157":
      function_331506fcf9b66040(fe, us, cf);
      break;
    case #"hash_533b64c918519f84":
      function_f1fcff6d2129dd0b(fe, us, cf);
      break;
    case #"hash_7b426c04ed249c43":
      function_8635dce6619d01be(fe, us, cf);
      break;
  }
}

function function_f88c6f5fbe851ac4(fe, us, cf) {
  f = &strike_additem;
  s = s();
  fe[[f]](s, us, cf, (17320, -52196, 961), (0, 225, 0), "turret_trap_spawn", "s_turret_trap_fort_front", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (17320, -52196, 1049), (0, 135, 0), "s_turret_trap_fort_front", undefined, "activity_turret_trap_fort_front", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (17297, -52207, 1009), (0, 135, 0), "turret_trap_panel", "s_turret_trap_fort_front", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_1a9b3470d746ffc1(fe, us, cf) {
  f = &strike_additem;
  s = s();
  fe[[f]](s, us, cf, (19728, -49192, 510), (0, 270, 0), "turret_trap_spawn", "s_turret_trap_fort_gas_station", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (19728, -49192, 598), (0, 180, 0), "s_turret_trap_fort_gas_station", undefined, "activity_turret_trap_fort_gas_station", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (19720, -49216, 558), (0, 180, 0), "turret_trap_panel", "s_turret_trap_fort_gas_station", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6b789baf710347a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  fe[[f]](s, us, cf, (12488, -53438, 712), (0, 0, 0), "turret_trap_spawn", "s_turret_trap_fort_west", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (12488, -53438, 800), (0, 270, 0), "s_turret_trap_fort_west", undefined, "activity_turret_trap_fort_west", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (12512, -53446.5, 760), (0, 270, 0), "turret_trap_panel", "s_turret_trap_fort_west", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_331506fcf9b66040(fe, us, cf) {
  f = &strike_additem;
  s = s();
  fe[[f]](s, us, cf, (21821, -54337, 839), (0, 90, 0), "turret_trap_spawn", "s_turret_trap_fort_east", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (21821, -54337, 927), (0, 0, 0), "s_turret_trap_fort_east", undefined, "activity_turret_trap_fort_east", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (21830, -54313, 887), (0, 0, 0), "turret_trap_panel", "s_turret_trap_fort_east", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_f1fcff6d2129dd0b(fe, us, cf) {
  f = &strike_additem;
  s = s();
  fe[[f]](s, us, cf, (16860, -54105, 1472), (0, 0, 0), "turret_trap_spawn", "s_turret_trap_fort_roof", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (16860, -54105, 1560), (0, 270, 0), "s_turret_trap_fort_roof", undefined, "activity_turret_trap_fort_roof", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (16884, -54114, 1520), (0, 270, 0), "turret_trap_panel", "s_turret_trap_fort_roof", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_8635dce6619d01be(fe, us, cf) {
  f = &strike_additem;
  s = s();
  fe[[f]](s, us, cf, (18581, -57526, 524), (0, 45, 0), "turret_trap_spawn", "s_turret_trap_fort_south", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (18581, -57526, 612), (0, 315, 0), "s_turret_trap_fort_south", undefined, "activity_turret_trap_fort_south", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (18604, -57515, 572), (0, 315, 0), "turret_trap_panel", "s_turret_trap_fort_south", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_fort_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (17320, -52196, 1065);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["TURRET_TRAP_FORT_FRONT"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_fort_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (19728, -49192, 614);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["TURRET_TRAP_FORT_GAS_STATION"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_fort_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (12488, -53438, 816);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["TURRET_TRAP_FORT_WEST"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_fort_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (21821, -54337, 943);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["TURRET_TRAP_FORT_EAST"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_fort_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (16860, -54105, 1576);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["TURRET_TRAP_FORT_ROOF"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_fort_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (18581, -57526, 628);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["TURRET_TRAP_FORT_SOUTH"] = instancestruct;
  return activityinstances;
}