/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\calloutmarkerping_mp.gsc
***********************************************/

#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\loot;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\teams;
#namespace calloutmarkerping_mp;

function calloutmarkerping_init() {
  calloutmarkerping_initcommon();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&calloutmarkerping_onplayerdisconnect);
  scripts\engine\utility::registersharedfunc("ping", "calloutMarkerPing_squadLeaderBeaconKillForPlayer", &calloutmarkerping_squadleaderbeaconkillforplayer);
  scripts\engine\utility::registersharedfunc("ping", "calloutMarkerPing_watchItemTakenFromContainer", &calloutmarkerping_watchitemtakenfromcontainer);
  scripts\engine\utility::registersharedfunc("container", "isContainerEmpty", &scripts\mp\loot::iscontainerempty);
  scripts\engine\utility::registersharedfunc("container", "getIndexForLootIDInContainer", &scripts\mp\loot::getindexforlootidincontainer);
  scripts\engine\utility::registersharedfunc("container", "getLoadoutDoubleBackpackLootID", &scripts\mp\loot::getloadoutdoublebackpacklootid);
  scripts\engine\utility::registersharedfunc("container", "getLootIDAtContainerIndex", &scripts\mp\loot::getlootidatcontainerindex);
  scripts\engine\utility::registersharedfunc("loot", "lootGetScriptableName", &scripts\mp\gametypes\br_pickups::lootgetscriptablename);
}

function calloutmarkerping_squadleaderbeaconcreate(pingtraceorigin) {}

function calloutmarkerping_squadleaderbeaconplayerfirstlanded() {
  player = self;

  if(!getdvarint(@ "hash_317946383876293f", 0)) {
    return;
  }

  if(!istrue(player.squadleaderbeacon_isactive)) {
    assertex(!isDefined(player.squadleaderbeacon_fxent), "<dev string:x1c>");
    assertex(!isDefined(player.squadleaderbeacon_circleorigin), "<dev string:x1c>");
    assertex(!isDefined(player.squadleaderbeacon_circleradius), "<dev string:x1c>");
    return;
  }

  if(ispointinsidecircle(player.origin, player.squadleaderbeacon_circleorigin, player.squadleaderbeacon_circleradius)) {
    if(issharedfuncdefined("rank", "scoreEventPopup")) {
      player thread[[getsharedfunc("rank", "scoreEventPopup")]]("br_beacon_bonus");
    }

    player iprintlnbold("<dev string:x67>");
  }

  player.squadleaderbeacon_fxent delete();
  player.squadleaderbeacon_circleorigin = undefined;
  player.squadleaderbeacon_circleradius = undefined;
  player.squadleaderbeacon_isactive = undefined;
}

function calloutmarkerping_squadleaderbeaconkillforplayer(player) {
  assert(isPlayer(player));

  if(!getdvarint(@ "hash_317946383876293f", 0)) {
    return;
  }

  if(isDefined(player.squadleaderbeacon_fxent)) {
    player.squadleaderbeacon_fxent delete();
    player.squadleaderbeacon_circleorigin = undefined;
    player.squadleaderbeacon_circleradius = undefined;
    player.squadleaderbeacon_isactive = undefined;
  }

  assert(!isDefined(player.squadleaderbeacon_circleorigin));
  assert(!isDefined(player.squadleaderbeacon_circleradius));
  assert(!isDefined(player.squadleaderbeacon_isactive));
}

function calloutmarkerping_watchitemtakenfromcontainer(player, container, lootid) {
  if(!isDefined(player) || !isDefined(container) || !isDefined(lootid)) {
    return;
  }

  player endon("death_or_disconnect");
  container endon("death");
  containerindex = undefined;
  loadoutcontents = undefined;

  while(true) {
    if(!isDefined(container) || !isDefined(container.contents)) {
      return;
    }

    if(issharedfuncdefined("container", "isContainerEmpty") && [[getsharedfunc("container", "isContainerEmpty")]](container)) {
      return;
    }

    if(!isDefined(container.opener)) {
      waitframe();
      continue;
    }

    if(!isDefined(containerindex) && issharedfuncdefined("container", "getIndexForLootIDInContainer")) {
      [containerindex, loadoutcontents] = [[getsharedfunc("container", "getIndexForLootIDInContainer")]](container, lootid);
    }

    if(!isDefined(containerindex) || !isDefined(loadoutcontents)) {
      return;
    }

    newlootid = undefined;

    if(istrue(loadoutcontents)) {
      if(containerindex == 100) {
        newlootid = container.var_a06e7128c001851d;
      } else if(issharedfuncdefined("container", "getLoadoutDoubleBackpackLootID")) {
        newlootid = [[getsharedfunc("container", "getLoadoutDoubleBackpackLootID")]](container, containerindex, 0);
      }

      if(!istrue(newlootid) || newlootid != lootid) {
        return;
      }
    } else {
      if(containerindex == 100) {
        newlootid = container.weaponslotcontents;
      } else if(issharedfuncdefined("container", "getLootIDAtContainerIndex")) {
        newlootid = [[getsharedfunc("container", "getLootIDAtContainerIndex")]](container.opener, containerindex, container, 0);
      }

      if(!istrue(newlootid) || newlootid != lootid) {
        return;
      }
    }

    waitframe();
  }
}

function function_c28d94289c4a6ecd(scriptable, var_1d4bc315e3007530) {
  assert(isPlayer(self));
  player = self;

  if(!isDefined(scriptable)) {
    return false;
  }

  friendlyplayers = scripts\mp\utility\teams::getfriendlyplayers(player.team, 1);

  foreach(friendlyplayer in friendlyplayers) {
    if(friendlyplayer != player) {
      if(friendlyplayer function_bee315a15cf61820(scriptable.index)) {
        if(isDefined(var_1d4bc315e3007530)) {
          container = scriptable;
          pingindex = friendlyplayer function_76ecf74c7d722b52(5);

          if(isDefined(pingindex)) {
            var_41a4a181b6606b16 = friendlyplayer function_a7e757d42b550a6(pingindex);

            if(var_41a4a181b6606b16 == 25) {
              var_c876b325333c55a3 = friendlyplayer calloutmarkerping_getEnt(pingindex);

              if(isDefined(var_c876b325333c55a3) && var_c876b325333c55a3.index == container.index) {
                var_75bc450af3921c3b = friendlyplayer function_c4e0716fbd549e2d(pingindex);

                if(isDefined(var_75bc450af3921c3b) && var_75bc450af3921c3b == var_1d4bc315e3007530) {
                  return true;
                }
              }
            }
          }

          continue;
        }

        return true;
      }
    }
  }

  return false;
}

function function_fc3ea40c99062d82(enemy) {
  assert(isPlayer(self));
  player = self;

  if(!isDefined(enemy)) {
    return false;
  }

  friendlyplayers = scripts\mp\utility\teams::getfriendlyplayers(player.team, 1);

  foreach(friendlyplayer in friendlyplayers) {
    if(!isDefined(friendlyplayer)) {
      continue;
    }

    if(friendlyplayer == player) {
      continue;
    }

    enemyentnum = enemy getentitynumber();

    if(!isDefined(friendlyplayer.var_aa9c8b816ec406f2) || !isDefined(friendlyplayer.var_aa9c8b816ec406f2[enemyentnum])) {
      continue;
    }

    var_fe6195ac94e8104d = friendlyplayer.var_aa9c8b816ec406f2[enemyentnum];
    var_586fc981f878f2cc = getdvarint(@ "hash_d85d63311ba6c0c0", 5) * 1000;
    var_9e2bdb90cba6134e = gettime() - var_fe6195ac94e8104d;
    var_1ce42df57cf1d36c = var_9e2bdb90cba6134e <= var_586fc981f878f2cc;

    if(var_1ce42df57cf1d36c) {
      return true;
    }
  }

  return false;
}

function function_4864c58ab9b1f07e(scriptable, var_f0456519eaae430) {
  assert(isPlayer(self));
  player = self;

  if(!isDefined(scriptable)) {
    return 0;
  }

  scriptablename = scriptable.type;

  if(isDefined(var_f0456519eaae430) && var_f0456519eaae430) {
    if(!isDefined(scriptable.var_1eef5048f92c4951)) {
      return 0;
    }

    var_1eef5048f92c4951 = scriptable.var_1eef5048f92c4951;

    if(player == var_1eef5048f92c4951 || player.team != var_1eef5048f92c4951.team) {
      return 0;
    }
  }

  var_da07265f8351bd9e = player function_368af07f7897fd79(5);

  if(!var_da07265f8351bd9e) {
    return 0;
  }

  pingindex = player function_76ecf74c7d722b52(5);

  if(!isDefined(pingindex)) {
    return 0;
  }

  var_41a4a181b6606b16 = player function_a7e757d42b550a6(pingindex);

  if(var_41a4a181b6606b16 != 22 && var_41a4a181b6606b16 != 23 && var_41a4a181b6606b16 != 28) {
    return 0;
  }

  requestedlootid = player function_c4e0716fbd549e2d(pingindex);

  if(!isDefined(requestedlootid)) {
    return 0;
  }

  var_1b715fd06c46c7c2 = 0;

  switch (requestedlootid) {
    case 16257:
      var_1b715fd06c46c7c2 = scripts\mp\gametypes\br_pickups::function_b989edd9af4f42c7(scriptablename);
      break;
    case 16264:
      var_1b715fd06c46c7c2 = scripts\mp\gametypes\br_pickups::function_d7c5786a0c42ef6c(scriptablename);
      break;
    case 16265:
    case 16269:
      var_1b715fd06c46c7c2 = scripts\mp\gametypes\br_pickups::isweaponpickup(scriptablename);
      break;
    case 16266:
      var_1b715fd06c46c7c2 = scripts\mp\gametypes\br_public::isarmorplate(scriptablename);
      break;
    case 16267:
      var_1b715fd06c46c7c2 = scripts\mp\gametypes\br_pickups::isdogtag(scriptablename);
      break;
    case 16268:
      var_1b715fd06c46c7c2 = scripts\mp\gametypes\br_pickups::isplunder(scriptablename);
      break;
    case 16270:
      var_1b715fd06c46c7c2 = scripts\mp\gametypes\br_pickups::iskey(scriptablename);
      break;
    case 16271:
      var_1b715fd06c46c7c2 = scripts\mp\gametypes\br_pickups::issuperpickup(scriptablename);
      break;
    case 16272:
      var_1b715fd06c46c7c2 = scripts\mp\gametypes\br_pickups::iskillstreak(scriptablename);
      break;
    case 16273:
      var_1b715fd06c46c7c2 = scripts\mp\gametypes\br_pickups::isrevivepickup(scriptablename);
      break;
    case 16274:
      var_1b715fd06c46c7c2 = scripts\mp\gametypes\br_pickups::isgasmask(scriptablename);
      break;
    default:
      if(scripts\mp\gametypes\br_public::isammo(scriptablename)) {
        ammolootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(scriptablename);

        if(isDefined(ammolootid) && ammolootid == requestedlootid) {
          var_1b715fd06c46c7c2 = 1;
        }
      } else if(scripts\mp\gametypes\br_pickups::isweaponpickup(scriptablename)) {
        weapon = scripts\mp\gametypes\br_pickups::getfullweaponobjforscriptablepartname(scriptablename);

        if(isDefined(weapon)) {
          ammotype = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(weapon);

          if(isDefined(ammotype)) {
            ammolootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(ammotype);

            if(isDefined(ammolootid) && ammolootid == requestedlootid) {
              var_1b715fd06c46c7c2 = 1;
            }
          }
        }
      }

      break;
  }

  if(var_1b715fd06c46c7c2) {
    player calloutmarkerping_removecallout(pingindex);
  }

  return var_1b715fd06c46c7c2;
}