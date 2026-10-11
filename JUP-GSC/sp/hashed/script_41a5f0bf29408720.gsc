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
  funcarray["shouldRun"] = &visibilitymode_shouldrun;
  funcarray["init"] = &visibilitymode_init;
  funcarray["enableForClient"] = &visibilitymode_enable;
  funcarray["disable"] = &visibilitymode_disable;
  funcarray["checkForDataUpdates"] = &function_5d19d3f8062e4bee;
  funcarray["getADSWeaponDist"] = &function_553772f1f998aa41;
  funcarray["getTargetArray"] = &visibilitymode_gettargetarray;
  funcarray["outlineOccluded"] = &function_e392446751b714f6;
  return funcarray;
}

function visibilitymode_shouldrun() {
  return true;
}

function visibilitymode_init() {
  level thread function_72f2b775f465b38d();
}

function function_72f2b775f465b38d() {
  level endon("game_ended");
  wait 5;
  scripts\common\visibility_mode::function_7068f93aacf2ef59("kiosk_objective", "uin_ping_buy_station");
}

function visibilitymode_enable(client, assetname, prioritygroup) {
  return scripts\cp\cp_outline_utility::outlineenableforplayer(self, client, assetname, prioritygroup);
}

function visibilitymode_disable(id) {
  scripts\cp\cp_outline_utility::outlinedisable(id, self);
}

function function_553772f1f998aa41() {
  weapon = self getcurrentweapon();

  if(weaponclass(weapon) == "sniper") {
    return 8192;
  }

  return 2048;
}

function visibilitymode_gettargetarray(client) {
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
            player scripts\common\visibility_mode::visibilitymode_unpackvalue(datavalue, outlinevalue);
          }

          continue;
        }

        player scripts\common\visibility_mode::visibilitymode_unpackvalue(datavalue, outlinevalue);
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