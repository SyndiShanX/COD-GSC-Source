/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\vehicle_spawn_cp.gsc
***********************************************/

vehicle_spawn_cp_init() {
  var_0 = getdvarint("_encstr_A301114F278BAFD8D9A02E038F88A046C287C7", 128);
  var_1 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();
  var_1.maxinstancecount = var_0;
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_960110D858376A07B077CD952B0D2DB1C6B2", ::vehicle_spawn_cp_canspawnvehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_8E1318E912B74D912D942347ADD240B763DBE3373A977F38C366", ::vehicle_spawn_cp_gamemodesupportsrespawn);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_97842141BA1F15C945FC5B2FF56AE8E89B035B0D3287D8F81DDE53493C1458A5478B33", ::_id_14213);
}

vehicle_spawn_cp_canspawnVehicle(var_0, var_1, var_2) {
  if(getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 1)
    return 0;

  if(istrue(level.disable_global_vehicle_spawn))
    return 0;

  return 1;
}

vehicle_spawn_cp_gamemodesupportsrespawn() {
  if(level.gametype != "_encstr_839E0CBFD1801B5DB0D34C932998" || level.gametype != "_encstr_8A0106E32BDF33B7")
    return 0;

  return 1;
}

_id_14213() {
  if(level.gametype != "_encstr_839E0CBFD1801B5DB0D34C932998" || level.gametype != "_encstr_8A0106E32BDF33B7")
    return 0;

  return 1;
}