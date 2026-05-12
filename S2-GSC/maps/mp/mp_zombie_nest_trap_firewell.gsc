/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_trap_firewell.gsc
****************************************************/

func_9CAA(param_00) {
  level notify("firewell_machinery_reset");
  wait(1.5);
  maps\mp\mp_zombie_nest_ee_fire_well::func_9CAB(param_00);
}