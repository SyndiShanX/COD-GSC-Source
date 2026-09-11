/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_pe_bombardment.gsc
*************************************************************************/

function init() {
  level.delay_turn_laser_trap_back_on = &prophaschangesleft;
}

function prophaschangesleft() {
  var_0 = int(game["teamScores"]["allies"]);
  var_1 = int(game["teamScores"]["axis"]);
  var_2 = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle(0.2, 0.8);

  if(var_0 != var_1) {
    var_3 = scripts\engine\utility::ter_op(var_0 > var_1, "allies", "axis");
    var_4 = [];

    foreach(var_6 in level.start_reach_exhaust_waste.maphint_cheese2scriptableused) {
      if(isDefined(var_6.get_current_station_signage_structs) && var_6.get_current_station_signage_structs == var_3) {
        var_4 = var_6;
      }
    }

    if(var_4.size > 0) {
      var_2 = var_4[randomint(var_4.size)].origin;
    }
  }

  return var_2;
}