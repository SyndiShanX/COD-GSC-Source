/********************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_bank_vehicle_create_script.gsc
********************************************************************************/

function main(var0, var1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_dwn_twn_bank_vehicle_create_script")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_dwn_twn_bank_vehicle_create_script");
  var2 = spawnStruct();
  thread cs_return_and_wait_for_flag(level, var0, var1, var2);

  if(!scripts\cp\so_trigger::cs_is_starttime()) {
    scripts\cp\so_trigger::endcreatescript(var2);
    return;
  }
}

function cs_return_and_wait_for_flag(var0, var1, var2, var3) {
  scripts\cp\so_trigger::wait_for_cs_flag(var3);

  if(!isDefined(var1)) {
    var1 = "stk";
  }

  var2 scripts\cp\so_trigger::strike_setup_arrays(var1, "cp_dwn_twn_bank_vehicle_create_script");
  scripts\cp\so_trigger::cs_init_flags(var2);
  thread createstructs(level, var2, var1);
  thread createtriggers(level, var2, var1);

  if(istrue(var0)) {
    level thread scripts\cp\so_trigger::wait_for_flags(var2, "cp_dwn_twn_bank_vehicle_create_script");
    return;
  }

  scripts\cp\so_trigger::wait_for_flags(var2, "cp_dwn_twn_bank_vehicle_create_script");
}

function createstructs(var0, var1, var2) {
  var3 = &scripts\cp\so_trigger::strike_additem;
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (26400, -13760, -262.74), (0.83, 89.98, -1.27), "bank_tank", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (26368, -17600, -231.25), (360, 90, 2.26), "bank_tank", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (21568, -12736, -216), (0, 0, 0), "bank_tank", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (23040, -16448, -216), (0, 0, 0), "bank_tank", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (25022.7, -19854.6, -224.06), (0.3, 45.01, 1.32), "bank_tank", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (23104, -18992, -65.81), (0, 330, 0), "bank_wheelson", "auto1", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (22304, -20192, 62.19), (0, 45, 0), "bank_wheelson", "auto2", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (23168, -19040, -72.02), undefined, "auto1", "auto19", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (22432, -20064, 56.19), (0, 45, 0), "auto2", "auto23", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (26368, -17600, -231.25), (360, 90, 2.26), "enemy_tank_path", "auto4", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (26432, -17088, -228.38), (2.27, 0.04, 0.91), "auto4", "auto5", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (26432, -16832, -223.73), (1.41, 0.03, 1.28), "auto5", "auto6", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (26336, -16480, -217.37), (0.27, 0, 0.58), "auto6", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (25022.7, -19854.6, -224.06), (0.3, 45.01, 1.32), "enemy_tank_path", "auto7", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (25430, -19537.8, -226.04), (1.6, 315, 0), "auto7", "auto8", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (25611, -19356.8, -226.04), (1.6, 315, 0), "auto8", "auto9", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (25868.5, -19108.5, -223.37), (1.6, 315, -0), "auto9", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (23040, -16448, -216), (0, 0, 0), "enemy_tank_path", "auto10", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (23552, -16464, -200.06), (360, 270, 3.58), "auto10", "auto11", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (23848, -16464, -184.06), (360, 270, 3.58), "auto11", "auto12", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (24312, -16568, -184), (0, 270, 0), "auto12", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (21568, -12736, -216), (0, 0, 0), "enemy_tank_path", "auto13", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (22080, -12704, -216), (0, 270, 0), "auto13", "auto14", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (22336, -12704, -216), (0, 270, 0), "auto14", "auto15", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (22688, -12704, -216), (0, 270, 0), "auto15", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (26400, -13760, -262.74), (0.83, 89.98, -1.27), "enemy_tank_path", "auto16", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (26400, -13248, -264), (0, 0, 0), "auto16", "auto17", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (26400, -12992, -264), (0, 0, 0), "auto17", "auto18", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (26368, -12672, -264), (0, 0, 0), "auto18", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (23488, -19296, -65.81), undefined, "auto19", "auto20", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (23872, -18944, -65.81), undefined, "auto20", "auto21", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (23520, -18576, -65.81), undefined, "auto21", "auto22", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (23072, -18880, -52), undefined, "auto22", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (22688, -19872, 62.19), (0, 45, 0), "auto23", "auto24", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (22365.3, -19485.3, 62.19), (0, 45, 0), "auto24", "auto25", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (22078.9, -19742.9, 62.19), (0, 45, 0), "auto25", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (22592, -20512, 176), (0, 45, 0), "bank_wheelson", "auto26", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (22688, -20448, 190.19), (0, 45, 0), "auto26", "auto27", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (23168, -20000, 190.19), (0, 45, 0), "auto36", "auto28", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (23008, -19840, 190.19), (0, 45, 0), "auto28", "auto38", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (22560, -20320, 190.19), (0, 45, 0), "auto37", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (21824, -19328, 176), (0, 45, 0), "bank_wheelson", "auto34", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (21920, -19264, 190.19), (0, 45, 0), "auto34", "auto31", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (22116.1, -19071.8, 190.19), (0, 135, 0), "auto31", "auto32", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (21920.3, -18926.6, 190.19), (0, 225, 0), "auto32", "auto33", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (21742.3, -19057.1, 190.19), (0, 315, 0), "auto33", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (22928, -20224, 190.19), (0, 45, 0), "auto27", "auto36", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (22776, -20096, 190.19), (0, 225, 0), "auto38", "auto37", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}