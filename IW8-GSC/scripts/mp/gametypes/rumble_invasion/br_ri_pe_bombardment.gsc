/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_pe_bombardment.gsc
*************************************************************************/

function init() {
  level.delay_turn_laser_trap_back_on = &prophaschangesleft;
}

function prophaschangesleft() {
  var0 = int(game["teamScores"]["allies"]);
  var1 = int(game["teamScores"]["axis"]);
  var2 = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle(0.2, 0.8);

  if(var0 != var1) {
    var3 = scripts\engine\utility::ter_op(var0 > var1, "allies", "axis");
    var4 = [];

    foreach(var6 in level.start_reach_exhaust_waste.maphint_cheese2scriptableused) {
      if(isDefined(var6.get_current_station_signage_structs) && var6.get_current_station_signage_structs == var3) {
        var4 = var6;
      }
    }

    if(var4.size > 0) {
      var2 = var4[randomint(var4.size)].origin;
    }
  }

  return var2;
}