/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\fulton.gsc
***********************************************/

function init() {
  level.play_intro_getin_anim = getdvarint("online_challenge_filter_shared_advanced", 1) != 0;
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "canSendT9UserEvent", &get_best_heli_struct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onAgentKilled", &ref_11FFC);
}

function v_end_pos(var_0) {
  if(!isPlayer(self) || isai(self)) {
    return 0;
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "challenges", "completed", var_0);
}

function updateassassinationdataomnvar(var_0) {
  var_1 = tablelookupbyrow("t9_challenges.csv", var_0, 7);
  var_2 = getsystemtime();

  if(var_1 != "" && var_2 <= int(var_1)) {
    return false;
  }

  return true;
}

function routers_needed(var_0) {
  if(!isDefined(level.ref_139E0)) {
    var_1 = "loot/battlepass_season" + level.getallactivequestsforteam + ".csv";
    var_2 = tablelookupgetnumrows(var_1);
    var_3 = [];

    for(var_4 = 1; var_4 < var_2; var_4++) {
      var_3 = int(tablelookupbyrow(var_1, var_4, 1));
    }

    level.ref_139E0 = var_3;
  }

  for(var_5 = 1; var_5 < level.ref_139E0.size; var_5++) {
    if(level.ref_139E0[var_5] >= var_0) {
      break;
    }
  }

  if(var_5 > level.ref_139E0.size) {
    var_5 = level.ref_139E0.size;
  }

  return var_5;
}

function get_best_heli_struct(var_0) {
  var_1 = 0;
  var_2 = tablelookuprownum("t9_challenges.csv", 1, var_0);

  if(var_2 >= 0) {
    if(!level.play_intro_getin_anim) {
      return true;
    }

    var_1 = 1;

    if(v_end_pos(var_2)) {
      return false;
    }

    if(!updateassassinationdataomnvar(var_2)) {
      return false;
    }

    var_3 = tablelookupbyrow("t9_challenges.csv", var_2, 2);

    if(var_3 == "GUNSMITH") {
      var_4 = tablelookupbyrow("t9_challenges.csv", var_2, 5);

      if(var_4 != "") {
        var_5 = scripts\mp\rank::safedivide(var_4);
        var_6 = scripts\mp\weaponrank::rpg_attack_apc(var_5);
        var_7 = tablelookupbyrow("t9_challenges.csv", var_2, 4);

        if(var_6 < int(var_7)) {
          return false;
        }
      }
    } else if(var_3 == "QUEST") {
      var_8 = scripts\mp\teams::lookupcurrentoperator(self.team);
      var_9 = tablelookupbyrow("t9_challenges.csv", var_2, 6);

      if(isDefined(var_8) && isDefined(var_9) && var_8 != "" && var_9 != "" && var_8 != var_9) {
        return false;
      }
    }
  } else {
    var_2 = tablelookuprownum("mp/t9_seasonal_challenges.csv", 1, var_0);

    if(var_2 >= 0) {
      if(!level.play_intro_getin_anim) {
        return true;
      }

      var_10 = tablelookupgetnumrows("t9_challenges.csv");

      if(v_end_pos(var_10 + var_2)) {
        return false;
      }

      if(!updateassassinationdataomnvar(var_2)) {
        return false;
      }

      var_1 = 1;
      var_11 = tablelookupbyrow("mp/t9_seasonal_challenges.csv", var_2, 2);
      var_12 = function_042b();

      if(var_12 < int(var_11)) {
        return false;
      }
    }
  }

  if(!var_1) {
    return false;
  }

  return true;
}

function ref_11FFC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = scripts\mp\damage::playerkilled_initdeathdata(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

  if(scripts\mp\utility\damage::isheadshot(var_12.hitloc, var_12.meansofdeath, var_12.attacker)) {
    var_12.meansofdeath = "MOD_HEAD_SHOT";
    var_5 = "MOD_HEAD_SHOT";
  }

  if(var_1.classname != "worldspawn") {
    var_1 thread scripts\mp\events::cargo_truck_mg_initoccupancy(var_12.lifeid, self, var_6, var_5, var_0, var_12);
    var_13 = 0;
    var_14 = 0;

    if(isDefined(var_1.modifiers)) {
      var_13 = var_1.modifiers["mask"];
      var_14 = var_1.modifiers["mask2"];
    }

    var_2 thread scripts\cp\vehicles\vehicle_compass_cp::ref_11FFC(var_0, var_1, var_3, var_4, var_5, var_6, var_8, var_13, var_14);
    return;
  }
}