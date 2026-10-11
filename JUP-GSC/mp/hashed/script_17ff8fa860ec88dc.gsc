/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_17ff8fa860ec88dc.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\common\visibility_mode;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\teams;
#namespace namespace_8a7fbc5545f75867;

function function_764239e6a246c46a() {
  funcarray = [];
  funcarray["shouldRun"] = &visibilitymode_shouldrun;
  funcarray["enableForClient"] = &visibilitymode_enable;
  funcarray["disable"] = &visibilitymode_disable;
  funcarray["checkForDataUpdates"] = &function_5d19d3f8062e4bee;
  funcarray["getADSWeaponDist"] = &function_553772f1f998aa41;
  funcarray["getTargetArray"] = &visibilitymode_gettargetarray;
  funcarray["outlineOccluded"] = &function_e392446751b714f6;
  return funcarray;
}

function visibilitymode_shouldrun() {
  level endon("game_ended");

  if(scripts\mp\utility\game::ismlgmatch()) {
    return false;
  }

  canrun = scripts\mp\utility\game::privatematch() || level.systemlink;

  if(!canrun) {
    return false;
  }

  while(!isDefined(level.players) || level.players.size == 0) {
    wait 0.05;
  }

  wait 0.1;
  hostenabled = 0;

  while(!hostenabled) {
    hostenabled = function_2e2a6c022b5ed8db();
    wait 3;
  }

  return canrun && hostenabled;
}

function function_2e2a6c022b5ed8db() {
  hostenabled = 0;

  foreach(player in level.players) {
    if(player ishost()) {
      datavalue = function_7bcb4b0b404dc8a8(player);

      if(isDefined(datavalue) && datavalue > 0) {
        hostenabled = 1;
      }

      break;
    }
  }

  return hostenabled;
}

function visibilitymode_enable(client, assetname, prioritygroup) {
  return scripts\mp\utility\outline::outlineenableforplayer(self, client, assetname, prioritygroup);
}

function visibilitymode_disable(id) {
  scripts\mp\utility\outline::outlinedisable(id, self);
}

function function_553772f1f998aa41() {
  weapon = self getcurrentweapon();

  if(weaponclass(weapon) == "sniper") {
    return 8192;
  }

  return 2048;
}

function visibilitymode_gettargetarray(client) {
  friendlyplayers = scripts\mp\utility\teams::getfriendlyplayers(client.team);
  enemyplayers = scripts\mp\utility\teams::getenemyplayers(client.team);
  aiarray = getaiarray();
  return array_combine(friendlyplayers, enemyplayers, aiarray);
}

function function_e392446751b714f6(startpoint, endpoint) {
  return scripts\mp\utility\outline::outlineoccluded(startpoint, endpoint);
}

function function_5d19d3f8062e4bee() {
  while(true) {
    wait 1;

    if(!isDefined(level.players)) {
      continue;
    }

    foreach(player in level.players) {
      datavalue = function_7bcb4b0b404dc8a8(player);

      if(isDefined(datavalue)) {
        if(isDefined(player.visibilitymodeval)) {
          if(datavalue != player.visibilitymodeval) {
            player scripts\common\visibility_mode::visibilitymode_unpackvalue(datavalue);
          }

          continue;
        }

        player scripts\common\visibility_mode::visibilitymode_unpackvalue(datavalue);
      }
    }
  }
}

function function_7bcb4b0b404dc8a8(player) {
  datavalue = player getplayerdata(level.loadoutsgroup, "squadMembers", "highVisibilityMode");
  return datavalue;
}