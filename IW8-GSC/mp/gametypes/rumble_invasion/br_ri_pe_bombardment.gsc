/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\rumble_invasion\br_ri_pe_bombardment.gsc
*****************************************************************/

init() {
  level.delay_turn_laser_trap_back_on = ::prophaschangesleft;
}

prophaschangesleft() {
  var_0 = int(game["_encstr_96040B1D59B0AD35B1F64E599B"]["_encstr_9A8507BA4040188D08"]);
  var_1 = int(game["_encstr_96040B1D59B0AD35B1F64E599B"]["_encstr_8E8405EA382B2A"]);
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincurrentcircle(0.2, 0.8);

  if(var_0 != var_1) {
    var_3 = scripts\engine\utility::ter_op(var_0 > var_1, "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");
    var_4 = [];

    foreach(var_6 in level.start_reach_exhaust_waste.maphint_cheese2scriptableused) {
      if(isDefined(var_6.get_current_station_signage_structs) && var_6.get_current_station_signage_structs == var_3)
        var_4[var_4.size] = var_6;
    }

    if(var_4.size > 0)
      var_2 = var_4[randomint(var_4.size)].origin;
  }

  return var_2;
}