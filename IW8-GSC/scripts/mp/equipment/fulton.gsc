/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\fulton.gsc
***********************************************/

function init() {
  level.play_intro_getin_anim = getdvarint("online_challenge_filter_shared_advanced", 1) != 0;
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "canSendT9UserEvent", &get_best_heli_struct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("challenges", "onAgentKilled", &ref_11ffc);
}

function v_end_pos(var0) {
  if(!isPlayer(self) || isai(self)) {
    return 0;
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "challenges", "completed", var0);
}

function updateassassinationdataomnvar(var0) {
  var1 = tablelookupbyrow("t9_challenges.csv", var0, 7);
  var2 = getsystemtime();

  if(var1 != "" && var2 <= int(var1)) {
    return false;
  }

  return true;
}

function routers_needed(var0) {
  if(!isDefined(level.ref_139e0)) {
    var1 = "loot/battlepass_season" + level.getallactivequestsforteam + ".csv";
    var2 = tablelookupgetnumrows(var1);
    var3 = [];

    for(var4 = 1; var4 < var2; var4++) {
      var3 = int(tablelookupbyrow(var1, var4, 1));
    }

    level.ref_139e0 = var3;
  }

  for(var5 = 1; var5 < level.ref_139e0.size; var5++) {
    if(level.ref_139e0[var5] >= var0) {
      break;
    }
  }

  if(var5 > level.ref_139e0.size) {
    var5 = level.ref_139e0.size;
  }

  return var5;
}

function get_best_heli_struct(var0) {
  var1 = 0;
  var2 = tablelookuprownum("t9_challenges.csv", 1, var0);

  if(var2 >= 0) {
    if(!level.play_intro_getin_anim) {
      return true;
    }

    var1 = 1;

    if(v_end_pos(var2)) {
      return false;
    }

    if(!updateassassinationdataomnvar(var2)) {
      return false;
    }

    var3 = tablelookupbyrow("t9_challenges.csv", var2, 2);

    if(var3 == "GUNSMITH") {
      var4 = tablelookupbyrow("t9_challenges.csv", var2, 5);

      if(var4 != "") {
        var5 = scripts\mp\rank::safedivide(var4);
        var6 = scripts\mp\weaponrank::rpg_attack_apc(var5);
        var7 = tablelookupbyrow("t9_challenges.csv", var2, 4);

        if(var6 < int(var7)) {
          return false;
        }
      }
    } else if(var3 == "QUEST") {
      var8 = scripts\mp\teams::lookupcurrentoperator(self.team);
      var9 = tablelookupbyrow("t9_challenges.csv", var2, 6);

      if(isDefined(var8) && isDefined(var9) && var8 != "" && var9 != "" && var8 != var9) {
        return false;
      }
    }
  } else {
    var2 = tablelookuprownum("mp/t9_seasonal_challenges.csv", 1, var0);

    if(var2 >= 0) {
      if(!level.play_intro_getin_anim) {
        return true;
      }

      var10 = tablelookupgetnumrows("t9_challenges.csv");

      if(v_end_pos(var10 + var2)) {
        return false;
      }

      if(!updateassassinationdataomnvar(var2)) {
        return false;
      }

      var1 = 1;
      var11 = tablelookupbyrow("mp/t9_seasonal_challenges.csv", var2, 2);
      var12 = function_042b();

      if(var12 < int(var11)) {
        return false;
      }
    }
  }

  if(!var1) {
    return false;
  }

  return true;
}

function ref_11ffc(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = scripts\mp\damage::playerkilled_initdeathdata(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);

  if(scripts\mp\utility\damage::isheadshot(var12.hitloc, var12.meansofdeath, var12.attacker)) {
    var12.meansofdeath = "MOD_HEAD_SHOT";
    var5 = "MOD_HEAD_SHOT";
  }

  if(var1.classname != "worldspawn") {
    var1 thread scripts\mp\events::cargo_truck_mg_initoccupancy(var12.lifeid, self, var6, var5, var0, var12);
    var13 = 0;
    var14 = 0;

    if(isDefined(var1.modifiers)) {
      var13 = var1.modifiers["mask"];
      var14 = var1.modifiers["mask2"];
    }

    var2 thread scripts\cp\vehicles\vehicle_compass_cp::ref_11ffc(var0, var1, var3, var4, var5, var6, var8, var13, var14);
    return;
  }
}