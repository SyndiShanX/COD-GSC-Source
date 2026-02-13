/*********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_objective_kill_caps.gsc
*********************************************************/

get_objective_kill_cap(var_0) {
  if(!scripts\engine\utility::is_equal(getdvarint("#x3a414ed246faed8cd", 0), 1)) {
    return -1;
  }

  if(!isDefined(level._id_11049) || level.players.size == 0) {
    return -1;
  }

  if(scripts\engine\utility::is_equal(var_0, "holdout")) {
    return -1;
  }

  var_1 = 0;

  switch (var_0) {
    case "soul_capture":
      var_1 = 0;
      break;
    case "orb_follow":
      var_1 = 4;
      break;
  }

  var_1 = var_1 + (level.players.size - 1);

  if(level._id_11049 >= 32) {
    var_2 = int(tablelookupbyrow("cp/zm_objective_kill_caps.csv", 32, var_1));
  } else {
    var_2 = int(tablelookupbyrow("cp/zm_objective_kill_caps.csv", level._id_11049 - 1 + 2, var_1));
  }

  if(isDefined(var_2) && isint(var_2)) {
    return var_2;
  } else {
    return -1;
  }
}