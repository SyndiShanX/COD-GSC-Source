/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_41a5f0bf29408720.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\common\visibility_mode;
#using scripts\cp\cp_outline_utility;
#using scripts\engine\utility;
#namespace namespace_8a41a85545b288a9;

function function_764239e6a246c46a() {
  funcarray = [];
  funcarray["shouldRun"] = &function_dcbff0f91b68341d;
  funcarray["init"] = &function_db991b1ec8386695;
  funcarray["enableForClient"] = &function_4999a7fd384d2fb4;
  funcarray["disable"] = &function_11f7a27364a8b75d;
  funcarray["checkForDataUpdates"] = &function_5d19d3f8062e4bee;
  funcarray["getADSWeaponDist"] = &function_553772f1f998aa41;
  funcarray["getTargetArray"] = &function_6be4502bdbd97c85;
  funcarray["outlineOccluded"] = &function_e392446751b714f6;
  return funcarray;
}

function function_dcbff0f91b68341d() {
  return true;
}

function function_db991b1ec8386695() {
  level thread function_72f2b775f465b38d();
}

function function_72f2b775f465b38d() {
  level endon("game_ended");
  wait 5;
  scripts\common\visibility_mode::function_7068f93aacf2ef59("kiosk_objective", "uin_ping_buy_station");
}

function function_4999a7fd384d2fb4(client, assetname, prioritygroup) {
  return scripts\cp\cp_outline_utility::outlineenableforplayer(self, client, assetname, prioritygroup);
}

function function_11f7a27364a8b75d(id) {
  scripts\cp\cp_outline_utility::outlinedisable(id, self);
}

function function_553772f1f998aa41() {
  weapon = self getcurrentweapon();

  if(weaponclass(weapon) == "sniper") {
    return 8192;
  }

  return 2048;
}

function function_6be4502bdbd97c85(client) {
  aiarray = getaiarray();
  players = level.players;
  return array_combine(players, aiarray);
}

function function_e392446751b714f6(startpoint, endpoint) {
  return scripts\cp\cp_outline_utility::outlineoccluded(startpoint, endpoint);
}

function function_5d19d3f8062e4bee() {
  while(true) {
    wait 1;

    if(!isDefined(level.players)) {
      continue;
    }

    foreach(player in level.players) {
      datavalue = player requestgamerprofile("highVisibilityMode");
      outlinevalue = player requestgamerprofile("highVisibilityModeOutline");

      if(isDefined(datavalue)) {
        if(isDefined(player.visibilitymodeval) && isDefined(level.player.var_5615f87228f360c8)) {
          if(datavalue != player.visibilitymodeval || outlinevalue != player.var_5615f87228f360c8) {
            player scripts\common\visibility_mode::function_8c2e8285c9915b12(datavalue, outlinevalue);
          }

          continue;
        }

        player scripts\common\visibility_mode::function_8c2e8285c9915b12(datavalue, outlinevalue);
      }
    }
  }
}

function function_1871237039503ca1() {
  while(level.players.size == 0) {
    wait 1;
  }

  wait 5;

  foreach(player in level.players) {
    player function_971b12ce83d4d457();
  }
}

function function_971b12ce83d4d457() {
  self setblurforplayer(5, 1);
}

function function_68fcff86246cb0e8() {}