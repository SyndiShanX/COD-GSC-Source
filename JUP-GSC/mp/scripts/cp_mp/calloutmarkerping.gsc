/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\calloutmarkerping.gsc
**************************************************/

#using script_4a6760982b403bad;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\utility\script;
#namespace calloutmarkerping;

function calloutmarkerping_initcommon() {
  if(!isDefined(level.brloottablename)) {
    level.brloottablename = getDvar(@ "loot_table_name", "mp/loot/br/default/loot_item_defs.csv");

    if(level.brloottablename == "") {
      level.brloottablename = "mp/loot/br/default/loot_item_defs.csv";
    }
  }

  level thread calloutmarkerpingvo_debouncegarbagecollector();
  setdvarifuninitialized(@ "hash_28ffde533f721522", 0);

  level thread function_c35cbd50adbcd4fd();
}

function calloutmarkerping_enemytodangerdecaycreate(pingindex, targetingenemy) {
  player = self;
  player calloutmarkerping_removecallout(pingindex);
  dangerzoffset = getdvarint(@ "hash_299d210181a853a", 82);

  if(!isDefined(targetingenemy.origin)) {
    return;
  }

  dangerpos = targetingenemy.origin + (0, 0, dangerzoffset);
  newpingindex = player calloutmarkerping_createcallout(6, dangerpos, 0);
  player thread _calloutmarkerping_predicted_timeout(newpingindex);
  _calloutmarkerping_predicted_log("Decay to Danger | oldPingIndex: " + pingindex + " | newPingIndex: " + newpingindex);
}

function _calloutmarkerping_predicted_log(message) {
  if(getdvarint(@ "hash_f49a77d2fc3d27e9", 0)) {
    logstring("<dev string:x1c>" + message + "<dev string:x3b>" + gettime());
  }
}

function function_c648f0fd527e089a(pingtype) {
  return pingtype >= 19 && pingtype <= 28;
}

function function_810652bcec49286c(pingtype) {
  return pingtype == 1;
}

function function_5dacc89a40a58737(pingtype) {
  return pingtype == 9;
}

function function_476d89b12dfe07a1(pingtype) {
  return pingtype == 13 || pingtype == 14;
}

function function_caef0e7e004e5475(pingtype) {
  return pingtype == 15;
}

function function_d3789a9a4be5df2e(pingtype) {
  return pingtype >= 6 && pingtype <= 18;
}

function function_74ec310d8f99b6e2(pingtype) {
  return pingtype == 3;
}

function function_2a301a38103bd61e(pingtype) {
  return pingtype == 36;
}

function function_666d78f715b8321f(pingtype) {
  return pingtype == 29 || pingtype == 30;
}

function function_87df78670540e9b2(pingtype) {
  return pingtype >= 29 && pingtype <= 36;
}

function function_d0006d07465a279c(pingindex, pingtype, scriptable) {
  player = self;
  var_4e4c314136883c22 = getdvarint(@ "hash_e6f7c3f8a50a6fd7", 1);

  if(var_4e4c314136883c22) {
    assetid = player function_a7e757d42b550a6(pingindex);
    waittime = function_e7ff763fd8f43bc4(assetid);
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return function_ce5c3314571d6a29(pingindex, pingtype, scriptable);
  }

  if(!isDefined(waittime) || istrue(getdvarint(@ "hash_8fa862672ae1781b", 0))) {
    if(pingtype == 21) {
      waittimedvar = @ "hash_817bed798637d38e";
      waittimedefault = 120;
    } else if(function_c648f0fd527e089a(pingtype)) {
      if(pingtype == 23) {
        waittimedvar = @ "hash_8bd5e52ad7441f43";
        waittimedefault = 120;
      } else {
        waittimedvar = @ "hash_4710528047b1660d";
        waittimedefault = 30;
      }

      if(isDefined(scriptable) && isDefined(scriptable.type) && scriptable.type == "br_plunder_box" || scriptable.type == "dmz_supply_drop" || scriptable.type == "dmz_supply_drop_boss" || scriptable.type == "dmz_supply_drop_samsite" || scriptable.type == "dmz_supply_drop_supply") {
        waittimedvar = @ "hash_cce27a6c00a3b750";
        waittimedefault = 120;
      }
    } else if(function_5dacc89a40a58737(pingtype)) {
      waittimedefault = 3;
    } else if(function_d3789a9a4be5df2e(pingtype)) {
      waittimedvar = @ "hash_f1ed16d72234a0cc";
      waittimedefault = 60;
    } else if(function_87df78670540e9b2(pingtype)) {
      waittimedvar = @ "hash_c368219ba5712e18";
      waittimedefault = 120;
    } else {
      switch (pingtype) {
        case 3:
          waittimedvar = @ "hash_abe00a149eb51fc0";
          waittimedefault = 15;
          break;
        case 2:
        case 17:
          waittimedvar = @ "hash_7c74d4814e0665d5";
          waittimedefault = 120;
          break;
        case 4:
          timeoutdvar = @ "hash_f2b483d963525879";
          waittimedefault = 120;
          break;
        case 6:
          waittimedvar = @ "hash_d25a3e0be5e90c21";
          waittimedefault = 60;
          break;
        case 5:
          waittimedvar = @ "hash_4da39a287b93388c";
          waittimedefault = 30;
          break;
        case 12:
          waittimedvar = @ "hash_dcab804f9c532b7f";
          waittimedefault = 9;
          break;
        default:
          assertmsg("<dev string:x48>" + "<dev string:x5f>" + pingtype);
          waittimedefault = 2;
          break;
      }
    }

    if(isDefined(waittimedvar) && isDefined(waittime)) {
      waittime = getdvarfloat(waittimedvar, waittime);
    } else if(isDefined(waittimedvar)) {
      waittime = getdvarfloat(waittimedvar, waittimedefault);
    } else {
      waittime = waittimedefault;
    }
  }

  return waittime;
}

function function_76ecf74c7d722b52(pingtype) {
  player = self;

  if(isDefined(player)) {
    for(pingindex = 0; pingindex < 10; pingindex++) {
      isowner = player function_1e008bf9d31b2b01(pingindex);

      if(isowner && pingtype == player calloutmarkerping_gettype(pingindex)) {
        return pingindex;
      }
    }
  }
}

function function_4e740f30357c2c3a(pingcategory) {
  player = self;

  if(isDefined(player)) {
    for(pingindex = 0; pingindex < 10; pingindex++) {
      isowner = player function_1e008bf9d31b2b01(pingindex);

      if(isowner && pingcategory == player function_dbea4c5599dd67de(pingindex)) {
        return pingindex;
      }
    }
  }
}

function _calloutmarkerping_predicted_timeout(pingindex) {
  player = self;
  assert(player function_1e008bf9d31b2b01(pingindex));
  player notify("predictiveCalloutResetTimeout_" + pingindex);
  pingtype = player calloutmarkerping_gettype(pingindex);
  level endon("game_ended");
  player endon("disconnect");
  player endon("predictiveCalloutResetTimeout_" + pingindex);
  player endon("predictiveCalloutClear_" + pingindex);
  waittime = 2;
  targetingenemy = undefined;
  var_19cc31e0fdf2a990 = 0;

  if(function_d3789a9a4be5df2e(pingtype)) {
    ent = player calloutmarkerping_getEnt(pingindex);

    if(isDefined(ent)) {
      var_19cc31e0fdf2a990 = getdvarint(@ "hash_c022bd4a1215cd2c", 1);

      if(var_19cc31e0fdf2a990 && _calloutmarkerping_isenemy(ent, player)) {
        if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
          waittime = getdvarfloat(@ "hash_dafd6b4196557939", 0);
        } else if(isDefined(level.lootleaders) && scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "kingslayer" && array_contains(level.lootleaders, ent)) {
          waittime = getdvarfloat(@ "hash_736f9d37695743d5", 0);
        } else {
          waittime = getdvarfloat(@ "scr_calloutmarkerping_track_player_time", 3);
        }

        targetingenemy = ent;
      }

      if(_calloutmarkerping_isenemy(ent, player) && isagent(ent)) {
        waittime = getdvarfloat(@ "hash_dcab804f9c532b7f", 9);
        targetingenemy = ent;
      }

      if(pingtype == 6) {
        player thread calloutmarkerping_removevehiclecalloutonspecialconditions(pingindex, ent);
      }

      player thread function_632cc7f8cbf11ae1(pingindex, ent);
    }
  } else if(function_c648f0fd527e089a(pingtype)) {
    calloutentity = player calloutmarkerping_getEnt(pingindex);
    player thread calloutmarkerping_watchscriptabledeath(pingindex, calloutentity);

    if(pingtype == 20) {
      if(!player isspectatingplayer()) {
        player thread function_1efe712c746d3ca1(pingindex);
      }
    }
  } else if(pingtype == 2) {
    if(getdvarint(@ "hash_a20128c96ee00a7", 0)) {
      player thread calloutmarkerping_navigationcancelproximity(pingindex);
    }
  } else if(pingtype == 4) {
    gscobjectiveid = self calloutmarkerping_getgscobjectiveindex(pingindex);
    assert(isint(gscobjectiveid));

    if(gscobjectiveid == -1) {
      assertmsg("<dev string:x48>" + "<dev string:x95>");
      calloutmarkerping_removecallout(pingindex);
    } else {
      player thread calloutmarkerping_watchwhenobjectivestartsprogress(pingindex, gscobjectiveid);
      player thread calloutmarkerping_watchwhenobjectivedeleted(pingindex, gscobjectiveid);
    }
  } else if(pingtype == 5) {
    player thread calloutmarkerping_watchplayerdeathordisconnect(pingindex);
    pingcategory = player function_dbea4c5599dd67de(pingindex);

    if(pingcategory == 5) {
      calloutentity = player calloutmarkerping_getEnt(pingindex);
      player thread calloutmarkerping_watchscriptabledeath(pingindex, calloutentity);
    }
  }

  if(!isDefined(targetingenemy)) {
    calloutentity = player calloutmarkerping_getEnt(pingindex);
    waittime = player function_d0006d07465a279c(pingindex, pingtype, calloutentity);

    if(getdvarint(@ "hash_94055f5243eb5fa0", 1)) {
      if(isDefined(calloutentity) && isDefined(calloutentity.type)) {
        if(issubstr(calloutentity.type, "ob_loot_cache")) {
          waittime = 60;
        } else if(isDefined(calloutentity.var_a2738a1d42906829) || isDefined(calloutentity.activity_instance) && isDefined(calloutentity.activity_instance.var_b189a678c1c3489a)) {
          waittime = 0;
        } else {
          switch (calloutentity.type) {
            case #"hash_c4e1cdfcbfebe45e":
              waittime = 120;
              break;
            case #"hash_4cfd32bbd2544dc2":
            case #"hash_69b00973eec22e7e":
            case #"hash_8dc697e88cc411b2":
            case #"hash_a862ca2b6614f16e":
            case #"hash_f1b7e128d54c7c3e":
              waittime = 60;
              break;
            case #"hash_9345a268cf04e0e4":
            case #"hash_a5a46576f54f77c8":
            case #"hash_c7ea6790348315ee":
            case #"hash_c9a0fc3f2f68ed28":
            case #"hash_d6b5e1486d1ce81d":
            case #"hash_d7d80055b86bb6e0":
            case #"hash_debe4d6797ce42ca":
              waittime = 0;
              break;
          }
        }
      } else if(isDefined(calloutentity) && istrue(calloutentity.var_4a4265af0a6f92e9)) {
        waittime = 120;
      }
    }

    if(waittime == 0 || isDefined(calloutentity) && istrue(calloutentity.var_e601ad111c029b9e)) {
      return;
    }
  }

  _calloutmarkerping_predicted_log("Setup Timeout | wait: " + waittime + " | pingIndex: " + pingindex + " | Type: " + pingtype);
  wait waittime;

  if(isDefined(targetingenemy) && isDefined(player) && isalive(targetingenemy) && pingtype == 9 && var_19cc31e0fdf2a990) {
    player thread calloutmarkerping_enemytodangerdecaycreate(pingindex, targetingenemy);
    return;
  }

  _calloutmarkerping_predicted_log("Ping Timeout | pingIndex: " + pingindex + " | Type: " + pingtype);
  calloutentity = player calloutmarkerping_getEnt(pingindex);

  if(isDefined(calloutentity) && isDefined(calloutentity.var_139629996ea22b5) && isDefined(calloutentity.var_139629996ea22b5[player getentitynumber()])) {
    calloutentity.var_139629996ea22b5[player getentitynumber()] = undefined;
  }

  player calloutmarkerping_removecallout(pingindex);
}

function _calloutmarkerping_predicted_isanypingactive() {
  player = self;

  for(pingindex = 0; pingindex < 10; pingindex++) {
    isowner = player function_1e008bf9d31b2b01(pingindex);

    if(isowner && player calloutmarkerping_getactive(pingindex)) {
      return true;
    }
  }

  return false;
}

function private function_5a0bc132b2dd3f65() {
  pingowner = self;
  level endon("game_ended");
  pingowner endon("disconnect");

  while(true) {
    pingowner waittill("luinotifyserver", notification, pingindex, optionalarg);

    if(!isDefined(notification) || !isDefined(pingindex)) {
      continue;
    }

    pingowner function_a1d53ca27932b96d(notification, pingindex, optionalarg);
  }
}

function function_a1d53ca27932b96d(notification, pingindex, optionalarg) {
  assert(isDefined(notification));
  pingowner = self;
  logmessage = "Notification ( " + notification + " )";

  if(isDefined(pingindex)) {
    logmessage += " | pingIndex: " + pingindex;
  }

  if(isDefined(optionalarg)) {
    logmessage += " | optionalArg: " + optionalarg;
  }

  _calloutmarkerping_predicted_log(logmessage);

  switch (notification) {
    case #"hash_bf30d88fa3f51a24":
      pingowner function_2a664ee5c40e868c(pingindex);
      break;
    case #"hash_8848543b86c481ce":
      pingowner function_49dc8767adf81886(pingindex, optionalarg, 0);
      break;
    case #"hash_48958d4f7bdc5cca":
      pingowner function_49dc8767adf81886(pingindex, optionalarg, 1);
      break;
    case #"hash_58db4293949d3d7e":
      var_e5a656eb53015664 = getentbynum(optionalarg);
      assert(isPlayer(var_e5a656eb53015664));
      pingowner function_45be7f9c916948b6(pingindex, var_e5a656eb53015664);
      break;
    case #"hash_40d28501f6704035":
      var_e5a656eb53015664 = getentbynum(optionalarg);
      assert(isPlayer(var_e5a656eb53015664));
      pingowner function_85bd27e859eec16c(pingindex, var_e5a656eb53015664);
      break;
    case #"hash_11ea00e1a93830a7":
      pingowner function_5d665c2bc1e250fa(pingindex);
      break;
    case #"hash_5c8ca9abdd242c53":
      pingowner function_99811a65af9a351();
      break;
    case #"hash_3bb96ecec88eb830":
      pingowner function_99811a65af9a351();
      pingowner function_8a6d3325d2046682();
      break;
    case #"hash_f17ec76eaa0b19da":
      pingowner function_5418b333a8e1cf76(pingindex);
      break;
    case #"hash_7235872539b9e722":
      function_f9a23942c0cd9461(pingowner, pingindex);
      break;
    case #"hash_3fe3f4975cc1fe19":
      if([[getsharedfunc("teamAssim", "isWaitingForAssimResponse")]](pingowner)) {
        [[getsharedfunc("teamAssim", "resolveAssimRequest")]](pingowner, pingindex);
      }

      break;
    default:
      break;
  }

  pingowner notify("calloutmarkerping_notifyhandled", notification, pingindex, optionalarg);
}

function calloutmarkerping_initplayer() {
  player = self;

  if(!isDefined(player.calloutmarkerpingvohandlerpool)) {
    player.calloutmarkerpingvohandlerpool = [];
  }

  if(!isDefined(player.var_3a9aaf3e5a5c0b5)) {
    player.var_3a9aaf3e5a5c0b5 = [];
  }

  player thread function_5a0bc132b2dd3f65();
}

function _calloutmarkerping_scriptableisusable(scriptableinstance) {
  if(!isDefined(scriptableinstance)) {
    return 0;
  }

  return scriptableinstance function_6954a8d7ba8cd9fb();
}

function function_cb9269a1545ad6e4(ent) {
  if(isDefined(ent.bossinstance)) {
    ent = ent.bossinstance;
  }

  if(!isDefined(ent)) {
    return false;
  }

  if(!isDefined(ent.bossname)) {
    return false;
  }

  if(ent.bossname == "") {
    return false;
  }

  return true;
}

function _calloutmarkerping_isenemy(ent, player) {
  if(!isDefined(ent)) {
    return false;
  }

  if(!isPlayer(ent) && !isagent(ent)) {
    return false;
  }

  if(!isDefined(ent.team)) {
    return false;
  }

  if(ent.team == "neutral" || ent.team == "civilian") {
    return false;
  }

  return ent.team != player.team;
}

function function_c48b4d371d6f08eb(ent, player) {
  if(!isDefined(ent) || !isDefined(player)) {
    return false;
  }

  if(!isDefined(player.var_aa9c8b816ec406f2)) {
    return true;
  }

  if(isDefined(player.var_aa9c8b816ec406f2[ent getentitynumber()])) {
    return false;
  }

  return true;
}

function function_46c27491e08fed4e(ent, player) {
  if(!isDefined(ent) || !isDefined(player)) {
    return;
  }

  if(!isDefined(player.var_aa9c8b816ec406f2)) {
    player.var_aa9c8b816ec406f2 = [];
  }

  player.var_aa9c8b816ec406f2[ent getentitynumber()] = gettime();
}

function _calloutmarkerping_isplunderextract(ent) {
  if(!isDefined(ent)) {
    return false;
  }

  if(!isent(ent)) {
    return (issubstr(ent.type, "brloot_plunder_extraction") || issubstr(ent.type, "equip_fulton_mp"));
  }

  if(!isDefined(ent.model)) {
    return false;
  }

  return ent.model == "military_skyhook_far";
}

function _calloutmarkerping_isdropcrate(ent) {
  if(!isDefined(ent)) {
    return false;
  }

  if(!isent(ent)) {
    return false;
  }

  if(!isDefined(ent.cratetype)) {
    return false;
  }

  if(istrue(ent.isdropcrate)) {
    return true;
  }

  return ent.cratetype == "battle_royale_loadout" || ent.cratetype == "battle_royale_chopper_loot" || ent.cratetype == "battle_royale_c130_loot" || ent.cratetype == "killstreak" || ent.cratetype == "battle_royale_juggernaut" || ent.cratetype == "juggernaut" || ent.cratetype == "manual_turret";
}

function calloutmarkerping_ismunitionsbox(ent) {
  return isDefined(ent.equipmentref) && (ent.equipmentref == "equip_munitionsbox" || ent.equipmentref == "super_ammo_drop");
}

function function_3c11e6303c59cb37(ent) {
  return isDefined(ent.equipmentref) && ent.equipmentref == "equip_utilitybox";
}

function function_ab2631f444db868(ent) {
  return isDefined(ent.equipmentref) && ent.equipmentref == "equip_trophy";
}

function function_23c0a0bd88667b79(ent) {
  return isDefined(ent.equipmentref) && ent.equipmentref == "sound_veil_mp";
}

function function_faba04054d6e029a(ent) {
  return isDefined(ent.equipmentref) && ent.equipmentref == "sonar_pulse_mp";
}

function function_3f392603242529ba(ent) {
  return isDefined(ent.equipmentref) && ent.equipmentref == "equip_deployed_decoy";
}

function function_565809e0860e599b(ent) {
  if(!isDefined(ent.equipmentref)) {
    return 0;
  }

  switch (ent.equipmentref) {
    case #"hash_1602aabae23dc4b7":
    case #"hash_33dc79aea3c12e98":
    case #"hash_5398f15f2c7e99a6":
    case #"hash_c613333b4f1bbb78":
      return 1;
    default:
      return 0;
  }
}

function function_2cb339fa2e8b1cfe(ent) {
  return isDefined(ent.equipmentref) && ent.equipmentref == "equip_redeploy_drone_beacon";
}

function function_32bfb4f432f417f(ent) {
  return isDefined(ent.streakinfo) && isDefined(ent.streakinfo.airdroptype);
}

function function_a1b34a5b82e7a92e(ent) {
  return isDefined(ent.classname) && string_starts_with(ent.classname, "weapon");
}

function _calloutmarkerping_iskiosk(ent) {
  if(!isDefined(ent)) {
    return false;
  }

  if(!ent getscriptableisloot()) {
    return false;
  }

  if(ent.type != "br_plunder_box") {
    return false;
  }

  return true;
}

function function_abff9f14e6d75a76(ent) {
  if(isagent(ent)) {
    return false;
  }

  if(!isDefined(ent)) {
    return false;
  }

  if(!isent(ent)) {
    return false;
  }

  return issubstr(ent.classname, "grenade") || issubstr(ent.classname, "c4_") || issubstr(ent.classname, "proximity_explosive_") || issubstr(ent.classname, "claymore_");
}

function calloutmarkerping_canplayerping(player, var_f1c1336c7bbe5fe0) {
  if(player iscodcaster() || player isspectatingplayer()) {
    return false;
  }

  if(!isalive(player)) {
    return false;
  }

  if(istrue(player.mapmarkermodeenabled) && !isDefined(var_f1c1336c7bbe5fe0)) {
    return false;
  }

  if(player isusingremote()) {
    return false;
  }

  return true;
}

function function_3087d1219984f7f1(lootid) {
  if(isDefined(level.var_6bb18d8a44b66427)) {
    return [[level.var_6bb18d8a44b66427]](lootid);
  }

  var_39f686831584c7e6 = getscriptbundle(%"hash_4074433960d5a78c");
  assert(isDefined(var_39f686831584c7e6));
  lootinfo = getlootiteminfofromid(lootid);
  itemsb = "calloutmarkerpingitem:" + lootinfo.itemref;
  calloutmarkerpingitem = getscriptbundle(itemsb);

  if(isDefined(calloutmarkerpingitem) && isDefined(calloutmarkerpingitem.var_c4e1d2ee105cfd3b)) {
    return calloutmarkerpingitem.var_c4e1d2ee105cfd3b;
  }

  logprint("CalloutMarkerPing: " + "Could not get request VO for loot ID " + lootid);
  return undefined;
}

function function_442948452e540d3e(lootid) {
  lootidtype = function_3bc031ab2f635f8c(lootid);

  if(lootidtype == "calloutmarkerpingitem") {
    return function_3087d1219984f7f1(lootid);
  }

  if(istrue(level.var_a9350d89a2e4d752)) {
    var_30e078555972e3b8 = level.br_pickups.var_832ad168567520f7[lootid];

    if(isDefined(var_30e078555972e3b8) && var_30e078555972e3b8 != "") {
      return getxhash(var_30e078555972e3b8);
    } else if(lootidtype == #"weapon") {
      weaponname = level.br_pickups.var_b13dc7e63676bbe7[lootid];
      return function_8d17e607a79fd65f(weaponname);
    }
  } else if(isDefined(level.brloottablename)) {
    var_44044f276471d2bb = tablelookuprownum(level.brloottablename, 5, lootid);

    if(var_44044f276471d2bb >= 0) {
      var_30e078555972e3b8 = tablelookupbyrow(level.brloottablename, var_44044f276471d2bb, 29);

      if(isDefined(var_30e078555972e3b8) && var_30e078555972e3b8 != "") {
        return var_30e078555972e3b8;
      } else if(lootidtype == "weapon") {
        weaponname = tablelookupbyrow(level.brloottablename, var_44044f276471d2bb, 1);
        return function_8d17e607a79fd65f(weaponname);
      }
    } else if(utility::issharedfuncdefined("game", "getBundleNameFromLootID")) {
      itembundlename = [[utility::getsharedfunc("game", "getBundleNameFromLootID")]](lootid);

      if(isDefined(itembundlename)) {
        itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

        if(isDefined(itembundle) && isDefined(itembundle.pingvo)) {
          return itembundle.pingvo;
        }
      }
    }
  }

  return #"ping_loot_generic";
}

function function_d1c8c0f877165808(lootid) {
  baseweaponname = "";

  if(utility::issharedfuncdefined("game", "getBundleNameFromLootID")) {
    baseweaponname = "";
    itembundlename = [[utility::getsharedfunc("game", "getBundleNameFromLootID")]](lootid);

    if(isDefined(itembundlename)) {
      itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

      if(isDefined(itembundle) && isDefined(itembundle.baseweapon)) {
        baseweaponname = itembundle.baseweapon;
      }
    }
  } else if(istrue(level.var_a9350d89a2e4d752)) {
    if(isDefined(level.br_pickups.var_b13dc7e63676bbe7[lootid])) {
      itemname = level.br_pickups.var_b13dc7e63676bbe7[lootid];

      if(isDefined(itemname) && isDefined(level.br_lootiteminfo[itemname]) && isDefined(level.br_lootiteminfo[itemname].baseweapon)) {
        baseweaponname = level.br_lootiteminfo[itemname].baseweapon;
      }
    }
  } else {
    assert(isDefined(level.brloottablename));
    baseweaponname = tablelookup(level.brloottablename, 5, lootid, 8);
  }

  weaponclasstoken = scripts\cp_mp\weapon::getweaponclasstoken(baseweaponname);

  if(isDefined(weaponclasstoken)) {
    switch (weaponclasstoken) {
      case #"hash_fa18d2f6bd57925a":
        return #"ping_inv_have_weapon_assaultrifle";
      case #"hash_fa50b9f6bd82f79d":
        return #"ping_inv_have_weapon_smg";
      case #"hash_fa27b9f6bd62a3f2":
        return #"ping_inv_have_weapon_lmg";
      case #"hash_fa50b4f6bd82efbe":
        return #"ping_inv_have_weapon_shotgun";
      case #"hash_fa50b6f6bd82f2e4":
        return #"ping_inv_have_weapon_sniper";
      case #"hash_fa0ed9f6bd4f4e9a":
        return #"ping_inv_have_weapon_dmr";
      case #"hash_fa4dbdf6bd80bf52":
        return #"ping_inv_have_weapon_pistol";
      case #"hash_fa27bdf6bd62aa3e":
        return #"ping_inv_have_weapon_launcher";
      case #"hash_fa24ddf6bd609e07":
        if(issubstr(baseweaponname, "riotshield")) {
          return #"ping_inv_have_weapon_riotshield";
        } else {
          return #"ping_inv_have_weapon_melee";
        }
      default:
        logprint("CalloutMarkerPing: " + "Could not get request VO for loot ID " + lootid);
        return undefined;
    }

    return;
  }

  logprint("CalloutMarkerPing: " + "Could not get request VO for loot ID " + lootid);
  return undefined;
}

function function_40a8426c1f049004(lootid) {
  lootidtype = function_3bc031ab2f635f8c(lootid);

  if(lootidtype == "calloutmarkerpingitem") {
    return function_3087d1219984f7f1(lootid);
  }

  itemdeftype = "";

  if(utility::issharedfuncdefined("game", "getBundleNameFromLootID")) {
    itembundlename = [[utility::getsharedfunc("game", "getBundleNameFromLootID")]](lootid);

    if(isDefined(itembundlename)) {
      itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

      if(isDefined(itembundle) && isDefined(itembundle.type)) {
        itemdeftype = getxhash(itembundle.type);
      }
    }
  } else if(istrue(level.var_a9350d89a2e4d752)) {
    if(isDefined(level.br_pickups.var_b13dc7e63676bbe7[lootid])) {
      itemname = level.br_pickups.var_b13dc7e63676bbe7[lootid];

      if(isDefined(itemname) && isDefined(level.br_pickups.br_itemtype[itemname])) {
        itemdeftype = level.br_pickups.br_itemtype[itemname];
      }
    }
  } else {
    assert(isDefined(level.brloottablename));
    itemdeftype = tablelookup(level.brloottablename, 5, lootid, 2);
  }

  switch (itemdeftype) {
    case #"hash_59b8e9d05b31ff9":
    case #"plunder":
      return #"ping_inv_need_cash";
    default:
      scriptablename = default_to(scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid), "");

      switch (scriptablename) {
        case #"hash_1cd9ffa488237604":
          return #"ping_inv_need_smallcal";
        case #"hash_672892a4af1e94cc":
          return #"ping_inv_need_midcal";
        case #"hash_f1734c15f85881ca":
          return #"ping_inv_need_highcal";
        case #"hash_57e5eda4a702c559":
          return #"ping_inv_need_shells";
        case #"hash_755a9bafcd63b343":
          return #"ping_inv_need_launcher";
        default:
          break;
      }

      break;
  }
}

function function_f4293e5a97e51d76(lootid) {
  lootidtype = function_3bc031ab2f635f8c(lootid);

  if(lootidtype == "calloutmarkerpingitem") {
    return function_3087d1219984f7f1(lootid);
  }

  itemdeftype = "";

  if(utility::issharedfuncdefined("game", "getBundleNameFromLootID")) {
    itembundlename = [[utility::getsharedfunc("game", "getBundleNameFromLootID")]](lootid);

    if(isDefined(itembundlename)) {
      itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

      if(isDefined(itembundle) && isDefined(itembundle.type)) {
        itemdeftype = getxhash(itembundle.type);
      }
    }
  } else if(istrue(level.var_a9350d89a2e4d752)) {
    if(isDefined(level.br_pickups.var_b13dc7e63676bbe7[lootid])) {
      itemname = level.br_pickups.var_b13dc7e63676bbe7[lootid];

      if(isDefined(itemname) && isDefined(level.br_pickups.br_itemtype[itemname])) {
        itemdeftype = level.br_pickups.br_itemtype[itemname];
      }
    }
  } else {
    assert(isDefined(level.brloottablename));
    itemdeftype = getxhash(tablelookup(level.brloottablename, 5, lootid, 2));
  }

  switch (itemdeftype) {
    case #"weapon":
      return function_d1c8c0f877165808(lootid);
    case #"lethal":
      return #"ping_inv_have_equipment_lethal_generic";
    case #"tactical":
      return #"ping_inv_have_equipment_tactical_generic";
    case #"revive":
      return #"ping_inv_have_medical";
    case #"plunder":
    case #"currency":
      return #"ping_inv_have_cash";
    case #"killstreak":
      return #"ping_inv_have_killstreak_generic";
    case #"super":
      return #"ping_inv_have_fieldupgrade_generic";
    case #"key":
      return #"ping_inv_have_key";
    case #"keycard":
      return #"ping_inv_have_keycard";
    case #"dogtag":
      return #"ping_inv_have_player_dogtag";
    case #"valuable":
      return #"ping_inv_have_valuable";
    case #"armor":
      return #"ping_inv_have_armor";
    case #"gasmask":
      return #"ping_loot_gasmask";
    default:
      scriptablename = default_to(scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid), "");

      switch (scriptablename) {
        case #"hash_55798564991651ac":
          return #"ping_inv_have_armor";
        case #"hash_1cd9ffa488237604":
          return #"ping_inv_have_ammo_smallcal";
        case #"hash_672892a4af1e94cc":
          return #"ping_inv_have_ammo_midcaliber";
        case #"hash_f1734c15f85881ca":
          return #"ping_inv_have_ammo_highcal";
        case #"hash_57e5eda4a702c559":
          return #"ping_inv_have_ammo_shotgun";
        case #"hash_755a9bafcd63b343":
          return #"ping_inv_have_ammo_launcher";
        case #"hash_1b71e2c3430cd301":
        case #"hash_2d1a1b811aed6b26":
        case #"hash_d01e387e6d238502":
          return #"ping_loot_gasmask";
        default:
          logprint("CalloutMarkerPing: " + "Could not get request VO for loot ID " + lootid);
          return undefined;
      }

      break;
  }
}

function function_2f7ac61ee301ea30(assetid, lootid) {
  switch (assetid) {
    case 22:
      return function_40a8426c1f049004(lootid);
    case 28:
      return function_f4293e5a97e51d76(lootid);
    case 17:
    case 23:
    case 24:
    case 25:
      return function_442948452e540d3e(lootid);
    default:
      assertmsg("<dev string:xfc>");
      return undefined;
  }
}

function function_1e8231aee9e6076b(var_41a4a181b6606b16) {
  player = self;
  assert(isPlayer(player));
  var_70b1f16774d513d5 = undefined;

  switch (var_41a4a181b6606b16) {
    case 22:
    case 23:
    case 28:
      var_70b1f16774d513d5 = spawnStruct();
      var_70b1f16774d513d5.object = player;
      var_70b1f16774d513d5.index = player getentitynumber();
      var_70b1f16774d513d5.origin = (0, 0, 0);
      break;
    case 17:
      assert(isDefined(player.br_kiosk) || isDefined(player.common_kiosk));
      kiosk = default_to(player.br_kiosk, player.common_kiosk);
      var_70b1f16774d513d5 = spawnStruct();
      var_70b1f16774d513d5.object = kiosk;
      var_70b1f16774d513d5.index = kiosk.index;
      var_70b1f16774d513d5.origin = kiosk.origin;
      break;
    case 24:
    case 25:
      if(!isDefined(player.var_2fa5b49969def47)) {
        break;
      }

      var_70b1f16774d513d5 = spawnStruct();
      var_70b1f16774d513d5.object = player.var_2fa5b49969def47;
      var_70b1f16774d513d5.index = player.var_2fa5b49969def47.index;
      var_70b1f16774d513d5.origin = player.var_2fa5b49969def47.origin;
      break;
    case 0:
    case 2:
      break;
    default:
      assertmsg("<dev string:x133>");
      break;
  }

  return var_70b1f16774d513d5;
}

function private function_b2c7cf2679976cc2(var_41a4a181b6606b16, object) {
  player = self;
  assert(isPlayer(player));

  switch (var_41a4a181b6606b16) {
    case 17:
    case 24:
    case 25:
      object function_6bc4f6b579285f79(player, 1, 1);
      waitframe();
      break;
    case 0:
    case 2:
    case 22:
    case 23:
    case 28:
      break;
    default:
      assertmsg("<dev string:x184>");
      break;
  }
}

function function_22a98596c2f7f9ef(object, player, lootid) {
  var_da07265f8351bd9e = player function_368af07f7897fd79(5);

  if(var_da07265f8351bd9e) {
    pingindex = player function_76ecf74c7d722b52(5);
    pingobject = player calloutmarkerping_getEnt(pingindex);

    if(object == pingobject) {
      if(isDefined(lootid)) {
        pinglootid = player function_c4e0716fbd549e2d(pingindex);

        if(lootid == pinglootid) {
          return pingindex;
        }

        return;
      }

      return pingindex;
    }
  }
}

function function_6a4a22b07cd4a96f(object, team, lootid) {
  assert(isDefined(level.teamdata[team]));
  assert(isDefined(level.teamdata[team]["<dev string:x1cf>"]));
  teammembers = level.teamdata[team]["players"];

  foreach(member in teammembers) {
    pingindex = function_22a98596c2f7f9ef(object, member, lootid);

    if(isDefined(pingindex)) {
      return pingindex;
    }
  }
}

function function_faa3cbec7243fe72() {
  player = self;
  openkiosk = player.br_kiosk;
  var_76345a9e73e6de87 = player.common_kiosk;
  opencontainer = player.var_2fa5b49969def47;

  if(isDefined(openkiosk) && isDefined(function_6a4a22b07cd4a96f(openkiosk, player.team))) {
    player setclientomnvar("ui_show_lootid_item_pings", 1);
    return;
  }

  if(isDefined(var_76345a9e73e6de87) && isDefined(function_6a4a22b07cd4a96f(var_76345a9e73e6de87, player.team))) {
    player setclientomnvar("ui_show_lootid_item_pings", 1);
    return;
  }

  if(isDefined(opencontainer) && isDefined(function_6a4a22b07cd4a96f(opencontainer, player.team)) && isDefined(opencontainer.var_139629996ea22b5)) {
    player setclientomnvar("ui_show_lootid_item_pings", 1);
    return;
  }

  player setclientomnvar("ui_show_lootid_item_pings", 0);
}

function function_6c9b8f9429b7fdca(team) {
  assert(isDefined(level.teamdata[team]));
  assert(isDefined(level.teamdata[team]["<dev string:x1cf>"]));
  teammembers = level.teamdata[team]["players"];

  foreach(member in teammembers) {
    member function_faa3cbec7243fe72();
  }
}

function function_a3cb3fa19d3d1d11(pingobject, var_41a4a181b6606b16, pinglootid) {
  player = self;
  var_da07265f8351bd9e = player function_368af07f7897fd79(5);

  if(var_da07265f8351bd9e) {
    var_4d0dd5009aed72de = player function_76ecf74c7d722b52(5);
    assert(isDefined(var_4d0dd5009aed72de));
    oldobject = player calloutmarkerping_getEnt(var_4d0dd5009aed72de);
    var_bbb883cee81e54cb = player function_a7e757d42b550a6(var_4d0dd5009aed72de);
    oldlootid = player function_c4e0716fbd549e2d(var_4d0dd5009aed72de);
    isinventoryrequest = var_41a4a181b6606b16 == 22 || var_41a4a181b6606b16 == 23 || var_41a4a181b6606b16 == 28;
    var_64de9aff64436066 = getdvarint(@ "hash_a6d8c43504ab97df", 0);

    if(!isinventoryrequest || var_64de9aff64436066) {
      player calloutmarkerping_removecallout(var_4d0dd5009aed72de);
    }

    var_f19d25ce7fcf3460 = pingobject == oldobject && var_41a4a181b6606b16 == var_bbb883cee81e54cb && pinglootid == oldlootid;
    var_3bc390b8f1b2f96b = getdvarint(@ "hash_a6d8c43504ab97df", 0);

    if(var_f19d25ce7fcf3460 && (!isinventoryrequest || var_3bc390b8f1b2f96b)) {
      player calloutmarkerping_playteamsoundfx("uin_ping_cancel", var_4d0dd5009aed72de);
      return true;
    }
  }

  return false;
}

function function_1ced737a22161a49(var_41a4a181b6606b16, lootid) {
  player = self;

  if(!calloutmarkerping_canplayerping(player)) {
    return;
  }

  var_6b10a57d86c5874a = player function_1e8231aee9e6076b(var_41a4a181b6606b16);

  if(isDefined(var_6b10a57d86c5874a)) {
    if(function_a3cb3fa19d3d1d11(var_6b10a57d86c5874a.object, var_41a4a181b6606b16, lootid)) {
      function_6c9b8f9429b7fdca(player.team);
      return;
    }

    function_b2c7cf2679976cc2(var_41a4a181b6606b16, var_6b10a57d86c5874a.object);
    pingindex = player calloutmarkerping_createcallout(var_41a4a181b6606b16, var_6b10a57d86c5874a.origin, var_6b10a57d86c5874a.index, lootid);

    if(isDefined(var_6b10a57d86c5874a.object) && isDefined(var_6b10a57d86c5874a.object.containertype)) {
      if(!isDefined(var_6b10a57d86c5874a.object.var_139629996ea22b5)) {
        var_6b10a57d86c5874a.object.var_139629996ea22b5 = [];
      }

      entnum = player getentitynumber();

      if(!isDefined(var_6b10a57d86c5874a.object.var_139629996ea22b5[entnum])) {
        var_6b10a57d86c5874a.object.var_139629996ea22b5[entnum] = spawnStruct();
      }

      var_6b10a57d86c5874a.object.var_139629996ea22b5[entnum].pingowner = player;
      var_6b10a57d86c5874a.object.var_139629996ea22b5[entnum].pingindex = pingindex;
      var_6b10a57d86c5874a.object.var_139629996ea22b5[entnum].lootid = lootid;
    }

    player thread _calloutmarkerping_predicted_timeout(pingindex);
    player thread function_6b813a30256c8bc7(var_41a4a181b6606b16, lootid);
    function_6c9b8f9429b7fdca(player.team);
    player calloutmarkerping_playteamsoundfx("uin_ping_item", pingindex);
    return pingindex;
  }
}

function function_6b813a30256c8bc7(var_41a4a181b6606b16, lootid) {
  player = self;
  wait getdvarfloat(@ "hash_355f123c0bff2170", 0.5);
  voalias = function_2f7ac61ee301ea30(var_41a4a181b6606b16, lootid);

  if(isDefined(voalias) && isDefined(player)) {
    pingindex = player function_368af07f7897fd79(5);

    if(isDefined(pingindex)) {
      player calloutmarkerpingvo_play(voalias, 5);
    }
  }
}

function _calloutmarkerping_checkforbuybackrequest(pingindex) {
  player = self;

  if(isalive(player)) {
    return;
  }

  pingtype = player calloutmarkerping_gettype(pingindex);

  if(!function_c648f0fd527e089a(pingtype)) {
    return;
  }

  instance = player calloutmarkerping_getEnt(pingindex);

  if(!_calloutmarkerping_iskiosk(instance)) {
    return;
  }

  player notify("buybackRequested");
}

function function_2ecdd6eb53bbd808(pingtype, pingindex) {
  player = self;

  if(function_87df78670540e9b2(pingtype)) {
    assetindex = player function_a7e757d42b550a6(pingindex);
    return player function_31f315111c6a03c2(assetindex);
  }

  assertmsg("<dev string:x48>" + "<dev string:x1da>");
  return undefined;
}

function calloutmarkerpingvo_createcalloutbattlechatter(pingindex) {
  if(!isDefined(pingindex)) {
    assertmsg("<dev string:x48>" + "<dev string:x228>");
    return;
  }

  player = self;
  var_c1074ab6cac2169f = player calloutmarkerping_getEnt(pingindex);
  var_3ef0fdcee94cadff = undefined;
  pingtype = player calloutmarkerping_gettype(pingindex);

  if(function_810652bcec49286c(pingtype)) {
    println("<dev string:x48>" + "<dev string:x251>");
    return;
  }

  if(isDefined(level.var_5f9eb8185e287adc)) {
    var_3ef0fdcee94cadff = player[[level.var_5f9eb8185e287adc]](var_c1074ab6cac2169f, pingtype, pingindex);
  }

  if(!isDefined(var_3ef0fdcee94cadff)) {
    if(function_c648f0fd527e089a(pingtype)) {
      var_3ef0fdcee94cadff = player function_f9aa0f44521459d7(pingindex, var_c1074ab6cac2169f);

      if(!isDefined(var_3ef0fdcee94cadff)) {
        return;
      }
    } else if(pingtype == 23) {
      var_3ef0fdcee94cadff = player calloutmarkerpingvo_getcalloutaliasstringworld(pingindex);
    } else if(function_d3789a9a4be5df2e(pingtype) && (pingtype != 6 || function_cb9269a1545ad6e4(var_c1074ab6cac2169f)) && pingtype != 18 && pingtype != 17) {
      assert(isent(var_c1074ab6cac2169f));
      var_3ef0fdcee94cadff = player calloutmarkerpingvo_getcalloutaliasstringentity(var_c1074ab6cac2169f);
    } else if(function_74ec310d8f99b6e2(pingtype)) {
      var_3ef0fdcee94cadff = #"ping_enemy_general";
    } else if(function_87df78670540e9b2(pingtype)) {
      var_3ef0fdcee94cadff = function_2ecdd6eb53bbd808(pingtype, pingindex);
    } else {
      switch (pingtype) {
        case 2:
        case 17:
        case 18:
          if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && isDefined(player.br_infil_type)) {
            var_3ef0fdcee94cadff = #"ping_location_landing";
          } else {
            var_3ef0fdcee94cadff = #"ping_location_go";
          }

          break;
        case 6:
          var_3ef0fdcee94cadff = player calloutmarkerpingvo_getcalloutaliasstringvehicle(var_c1074ab6cac2169f);
          break;
        case 4:
          var_3ef0fdcee94cadff = player calloutmarkerpingvo_getcalloutaliasstringworld(pingindex);
          break;
        default:
          assertmsg("<dev string:x48>" + "<dev string:x1da>");
          break;
      }
    }
  }

  player calloutmarkerpingvo_play(var_3ef0fdcee94cadff, pingtype, var_c1074ab6cac2169f);

  if(issharedfuncdefined("vo", "onPing")) {
    player[[getsharedfunc("vo", "onPing")]](pingindex, pingtype, var_3ef0fdcee94cadff, var_c1074ab6cac2169f);
  }
}

function _calloutmarkerping_onpingchallenge(pingindex) {
  player = self;
  pingtype = player calloutmarkerping_gettype(pingindex);
  player callsharedfunc("pmc_missions", "onPing", pingindex, pingtype);

  if(!issharedfuncdefined("challenges", "onPing")) {
    return;
  }

  if(function_c648f0fd527e089a(pingtype)) {
    self[[getsharedfunc("challenges", "onPing")]]("object");
    return;
  }

  if(function_d3789a9a4be5df2e(pingtype)) {
    ent = self calloutmarkerping_getEnt(pingindex);

    if(isDefined(ent)) {
      if(_calloutmarkerping_isenemy(ent, self)) {
        if(function_c48b4d371d6f08eb(ent, self)) {
          self[[getsharedfunc("challenges", "onPing")]]("enemy");
        }

        function_46c27491e08fed4e(ent, self);
      } else if(!isPlayer(ent)) {
        self[[getsharedfunc("challenges", "onPing")]]("object");
      }
    }

    return;
  }

  if(function_74ec310d8f99b6e2(pingtype)) {
    self[[getsharedfunc("challenges", "onPing")]]("danger");
    return;
  }

  switch (pingtype) {
    case 5:
    case 6:
      self[[getsharedfunc("challenges", "onPing")]]("object");
      break;
    case 2:
    case 4:
      break;
  }
}

function calloutmarkerpingvo_getcalloutaliasstringentity(var_7a5b847ea66815f) {
  var_27e49251bb3376ea = self;

  if(isDefined(var_7a5b847ea66815f) && isent(var_7a5b847ea66815f)) {
    ent = var_7a5b847ea66815f;
  } else {
    assertmsg("<dev string:x48>" + "<dev string:x2b5>");
    return "";
  }

  isfriendly = is_equal(ent.team, var_27e49251bb3376ea.team);

  if(isPlayer(ent) && isfriendly) {
    return #"ping_request_revive";
  } else if(isDefined(ent.juggcontext) || istrue(ent.isjuggernaut)) {
    if(!function_6641a5b759148e1b()) {
      if(isfriendly) {
        return #"ping_killstreak_juggernaut";
      } else {
        return #"ping_killstreak_juggernaut_hostile";
      }
    } else if(isDefined(ent.bosstype)) {
      return #"ping_boss_generic";
    } else {
      return #"ping_enemy_infantry";
    }
  } else if(isDefined(ent.streakname)) {
    killstreakvo = function_e57c4849c7935da(ent, var_27e49251bb3376ea);

    if(isDefined(killstreakvo)) {
      return killstreakvo;
    }
  } else if(calloutmarkerping_ismunitionsbox(ent)) {
    if(isfriendly) {
      return #"ping_fieldupgrade_ammobox";
    } else {
      return #"ping_fieldupgrade_ammobox_hostile";
    }
  } else if(function_3c11e6303c59cb37(ent)) {
    if(isfriendly) {
      return #"ping_fieldupgrade_ammobox";
    } else {
      return #"ping_fieldupgrade_ammobox_hostile";
    }
  } else if(function_ab2631f444db868(ent)) {
    if(isfriendly) {
      return #"ping_fieldupgrade_trophy";
    } else {
      return #"ping_fieldupgrade_trophy_hostile";
    }
  } else if(function_23c0a0bd88667b79(ent)) {
    if(isfriendly) {
      return #"ping_fieldupgrade_soundveil";
    } else {
      return #"ping_fieldupgrade_soundveil_hostile";
    }
  } else if(function_faba04054d6e029a(ent)) {
    if(isfriendly) {
      return #"ping_fieldupgrade_sonarpulse";
    } else {
      return #"ping_fieldupgrade_sonarpulse_hostile";
    }
  } else if(function_3f392603242529ba(ent)) {
    if(isfriendly) {
      return #"ping_fieldupgrade_inflatabledecoy";
    } else {
      return #"ping_fieldupgrade_inflatabledecoy_hostile";
    }
  } else if(function_2cb339fa2e8b1cfe(ent)) {
    if(isfriendly) {
      return #"ping_fieldupgrade_redeploydronebeacon";
    } else {
      return #"ping_fieldupgrade_redeploydronebeacon_hostile";
    }
  } else if(function_565809e0860e599b(ent)) {
    if(isfriendly) {
      return #"ping_fieldupgrade_generic";
    } else {
      return #"ping_fieldupgrade_generic_hostile";
    }
  } else if(function_32bfb4f432f417f(ent)) {
    airdroptype = ent.streakinfo.airdroptype;

    switch (airdroptype) {
      case #"hash_2289ec11d77bce8f":
      case #"hash_56979e0566996b2e":
        airdroptype = "carepackage";
        break;
      case #"hash_4ad475e6e15635bd":
        airdroptype = "juggernaut_box";
        break;
      case #"hash_b597e9a707180461":
        airdroptype = "loadoutdrop";
        break;
    }

    pingtype = "killstreak";

    if(airdroptype == "loadoutdrop") {
      pingtype = "fieldupgrade";
    }

    var_9d38ff79b3a86204 = undefined;

    if(level.teambased) {
      if(isDefined(ent.team) && self.team != ent.team) {
        var_9d38ff79b3a86204 = "hostile";
      }
    } else if(isDefined(ent.owner) && self != ent.owner) {
      var_9d38ff79b3a86204 = "hostile";
    }

    calloutalias = "ping_" + pingtype + "_" + airdroptype;

    if(isDefined(var_9d38ff79b3a86204)) {
      calloutalias = calloutalias + "_" + var_9d38ff79b3a86204;
    }

    return getxhash(calloutalias);
  } else if(function_a1b34a5b82e7a92e(ent)) {
    if(istrue(ent.iscustomweapon)) {
      return #"ping_loot_weapon_custom";
    }

    weaponname = strtok(ent.classname, "+")[0];
    return function_8d17e607a79fd65f(weaponname);
  } else if(isDefined(ent.equipmentref) && ent.equipmentref == "equip_armorbox") {
    if(isfriendly) {
      return #"ping_fieldupgrade_armorbox";
    } else {
      return #"ping_fieldupgrade_armorbox_hostile";
    }
  } else if(isDefined(ent.cratetype) && ent.cratetype == "loadout_drop_cp") {
    return #"ping_fieldupgrade_loadoutdrop";
  } else if(function_abff9f14e6d75a76(ent)) {
    if(istrue(ent.var_c5ed7e1af63fb508)) {
      return #"ping_fieldupgrade_trophy_hostile";
    }

    prefix = #"ping_equipment_";
    weaponrootname = "";

    if(isDefined(ent.weapon_object)) {
      weaponrootname = getweaponrootstring(ent.weapon_object);
    } else if(isDefined(ent.sourcegrenade) && isDefined(ent.sourcegrenade.weapon_object)) {
      weaponrootname = getweaponrootstring(ent.sourcegrenade.weapon_object);
    }

    var_c7faed30fb7d597c = "";

    if(scripts\cp_mp\equipment::isequipmentlethal(weaponrootname)) {
      var_c7faed30fb7d597c = "lethal_generic";
    } else if(scripts\cp_mp\equipment::isequipmenttactical(weaponrootname)) {
      var_c7faed30fb7d597c = "tactical_generic";
    }

    switch (weaponrootname) {
      case #"hash_d9108a0595d7d0b9":
        var_c7faed30fb7d597c = "buster";
        break;
      case #"hash_fa1e80f6bd5b8e72":
        var_c7faed30fb7d597c = "c4";
        break;
      case #"hash_36b7174a04de8799":
        var_c7faed30fb7d597c = "claymore";
        break;
      case #"hash_333525cef39d0c66":
        var_c7faed30fb7d597c = "decoy";
        break;
      case #"hash_8059d93d3568c07":
        var_c7faed30fb7d597c = "gas";
        break;
      case #"hash_9d57562863499a06":
        var_c7faed30fb7d597c = "proxmine";
        break;
      case #"hash_11a03a12f93f62b2":
        var_c7faed30fb7d597c = "shockstick";
        break;
      case #"hash_a0319e349a692b8f":
        var_c7faed30fb7d597c = "thermite";
        break;
      case #"hash_e1f6f84e4cd950eb":
        var_c7faed30fb7d597c = "smoke";
        break;
      case #"hash_17c70dc48424ba92":
        var_c7faed30fb7d597c = "breacher_drone";
        break;
      case #"hash_5f29cda9550e6a3a":
        var_c7faed30fb7d597c = "butterfly_mine";
        break;
      case #"hash_a68928468343f517":
        if(isfriendly) {
          return #"ping_fieldupgrade_tacinsert";
        } else {
          return #"ping_fieldupgrade_tacinsert_hostile";
        }

        break;
    }

    if(isfriendly) {
      return hashcat(prefix, var_c7faed30fb7d597c);
    } else {
      return hashcat(prefix, var_c7faed30fb7d597c, "_hostile");
    }
  } else if(_calloutmarkerping_isplunderextract(ent)) {
    return #"ping_fulton";
  } else if(ent.model == "military_ammo_restock_location" || ent.model == "military_ammo_restock_location_solid") {
    return #"ping_ammo_depot";
  } else if(ent.model == "military_armor_station_01_open_full") {
    return #"ping_fieldupgrade_armorbox";
  } else if(issubstr(ent.model, "offhand_wm_container_gas_tank")) {
    return #"ping_equipment_lethal_generic";
  } else if(issubstr(ent.model, "train_")) {
    return #"ping_location_go";
  } else if(issubstr(ent.model, "cuniform")) {
    return #"ping_killstreak_counteruav";
  } else if(function_6641a5b759148e1b() && isDefined(ent.subcategory) && ent.subcategory == "elimTarget") {
    return #"ping_elimtarget";
  } else if(function_6641a5b759148e1b() && istrue(ent.ishostage)) {
    return #"ping_hostage";
  } else if(function_6641a5b759148e1b() && function_cb9269a1545ad6e4(ent)) {
    if(isDefined(ent.bossinstance)) {
      ent = ent.bossinstance;
    }

    if(ent.bossname == "chemist") {
      return #"ping_boss_chemist";
    } else if(ent.bossname == "pyro") {
      return #"ping_boss_pyro";
    } else if(ent.bossname == "trapper") {
      return #"ping_boss_trap";
    }

    return #"ping_boss_generic";
  } else if(_calloutmarkerping_isenemy(ent, self)) {
    enemyweapon = ent getcurrentweapon();

    if(isPlayer(ent)) {
      if(istrue(ent.inlaststand)) {
        return #"ping_enemy_downed";
      } else if(!isreallyalive(ent)) {
        return #"ping_enemy_killed";
      }
    }

    if(scripts\cp_mp\utility\weapon_utility::isriotshield(enemyweapon)) {
      return #"ping_enemy_riotshield";
    } else if(isweapon(enemyweapon) && !isnullweapon(enemyweapon) && weaponclass(enemyweapon) == "sniper") {
      return #"ping_enemy_sniper";
    } else if(isDefined(ent.basearchetype) && ent.basearchetype == "rusher") {
      return #"ping_rusher";
    }

    if(function_6641a5b759148e1b() && isDefined(level.var_d7b3bd9ad64c74b) && isDefined(level.var_d7b3bd9ad64c74b[ent getentitynumber()]) && isDefined(level.var_d7b3bd9ad64c74b[ent getentitynumber()]["tier"])) {
      tier = level.var_d7b3bd9ad64c74b[ent getentitynumber()]["tier"];
      elitestatus = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(ent, "elite");

      switch (tier) {
        case 1:
          return ter_op(istrue(elitestatus), #"ping_enemy_tier1e", #"ping_enemy_tier1");
        case 2:
          return ter_op(istrue(elitestatus), #"ping_enemy_tier2e", #"ping_enemy_tier2");
        case 3:
          return ter_op(istrue(elitestatus), #"ping_enemy_tier3e", #"ping_enemy_tier3");
        default:
          return #"ping_enemy_infantry";
      }
    }
  } else if(issubstr(ent.model, "mortar")) {
    return #"ping_enemy_mortar";
  } else if(issubstr(ent.model, "oxygen")) {
    return #"ping_loot_oxygentank";
  } else if(issubstr(ent.model, "turret")) {
    return #"ping_enemy_mountedturret";
  } else if(issubstr(ent.model, "gas_cutter")) {
    return #"ping_loot_buzzsaw";
  }

  return #"ping_enemy_infantry";
}

function function_f9aa0f44521459d7(pingindex, var_c1074ab6cac2169f) {
  player = self;
  var_3ef0fdcee94cadff = "";
  scriptableinstance = undefined;
  isdoor = 0;
  var_8b819c2af4c98ead = 0;
  islootcache = 0;
  isusable = 0;

  if(isDefined(var_c1074ab6cac2169f)) {
    scriptableinstance = var_c1074ab6cac2169f;
  } else {
    assertmsg("<dev string:x48>" + "<dev string:x2e0>" + player calloutmarkerping_gettype(pingindex));
    return undefined;
  }

  if(isDefined(scriptableinstance)) {
    isdoor = scriptableinstance scriptableisdoor();

    if(isdoor) {
      var_8b819c2af4c98ead = scriptableinstance scriptabledoorisclosed();
    } else {
      islootcache = scriptableinstance scriptableislootcache();
    }
  }

  if(islootcache) {
    if(scriptableinstance getscriptablehaspart("body") && scriptableinstance getscriptablepartstate("body") != "fully_opening_unusable") {
      var_3ef0fdcee94cadff = player calloutmarkerpingvo_getcalloutaliasstringloot(pingindex, scriptableinstance);
    } else if(isDefined(scriptableinstance.containertype) && (scriptableinstance.containertype == 15 || scriptableinstance.containertype == 13) || isDefined(scriptableinstance.type) && issubstr(scriptableinstance.type, "dmz_supply_drop")) {
      var_3ef0fdcee94cadff = player calloutmarkerpingvo_getcalloutaliasstringloot(pingindex, scriptableinstance);
    }
  } else if(isdoor && !var_8b819c2af4c98ead) {
    var_3ef0fdcee94cadff = #"ping_location_looted";
  } else if(isdoor) {
    return undefined;
  } else if(isDefined(scriptableinstance.customweaponname) && scriptableinstance.customweaponname != "") {
    var_3ef0fdcee94cadff = #"ping_loot_weapon_custom";
  } else if(isDefined(scriptableinstance) && isDefined(scriptableinstance.entity)) {
    if(_calloutmarkerping_isdropcrate(scriptableinstance.entity)) {
      if(scriptableinstance.entity.cratetype == "battle_royale_cash_crate") {
        var_3ef0fdcee94cadff = #"ping_loot_cash";
      } else if(scriptableinstance.entity.cratetype == "battle_royale_elite_chopper") {
        var_3ef0fdcee94cadff = #"ping_objective_capture_package";
      } else if(!isDefined(scriptableinstance.entity.team) || scriptableinstance.entity.team == player.team) {
        var_3ef0fdcee94cadff = #"ping_fieldupgrade_loadoutdrop";
      } else {
        var_3ef0fdcee94cadff = #"ping_fieldupgrade_loadoutdrop_hostile";
      }
    } else if(istrue(scriptableinstance.entity.isjuggernaut)) {
      if(!isDefined(scriptableinstance.entity.team) || scriptableinstance.entity.team == player.team) {
        var_3ef0fdcee94cadff = #"ping_killstreak_juggernaut_box";
      } else {
        var_3ef0fdcee94cadff = #"ping_killstreak_juggernaut_box_hostile";
      }
    } else if(_calloutmarkerping_isplunderextract(var_c1074ab6cac2169f) || isDefined(var_c1074ab6cac2169f.type) && var_c1074ab6cac2169f.type == "dmz_exfil_site") {
      var_3ef0fdcee94cadff = #"ping_exfil_lz";
    } else if(isDefined(scriptableinstance.entity.model) && (scriptableinstance.entity.model == "military_ammo_restock_location" || scriptableinstance.entity.model == "military_ammo_restock_location_solid" || scriptableinstance.entity.model == "military_ammo_restock_location_solid_mp")) {
      var_3ef0fdcee94cadff = #"ping_ammo_depot";
    } else if(isDefined(scriptableinstance.model) && (scriptableinstance.model == "veh9_mil_air_drone_redeploy_relocate" || scriptableinstance.model == "veh9_mil_air_drone_redeploy_relocate_hack")) {
      var_3ef0fdcee94cadff = #"ping_redeploy_drone";
    } else if(isDefined(scriptableinstance.entity.vehiclename) && scriptableinstance.entity.vehiclename == "cargo_train") {
      var_3ef0fdcee94cadff = #"ping_vehicle_generic_neutral";
    } else if(isDefined(scriptableinstance.entity.vehiclename) && scriptableinstance.entity.vehiclename == "veh_jup_nuclear_locomotive") {
      var_3ef0fdcee94cadff = #"ping_vehicle_generic_neutral";
    } else if(isDefined(scriptableinstance.entity.cameratype) && scriptableinstance.entity.cameratype == "tacCam") {
      if(scriptableinstance.entity.team == player.team) {
        var_3ef0fdcee94cadff = #"ping_fieldupgrade_taccamera";
      } else {
        var_3ef0fdcee94cadff = #"ping_fieldupgrade_taccamera_hostile";
      }
    } else if(isDefined(scriptableinstance.type) && (scriptableinstance.type == "veh9_mil_air_cargo_plane_airdrop_dmz" || scriptableinstance.type == "veh9_mil_air_cargo_plane_airdrop")) {
      var_3ef0fdcee94cadff = #"ping_vehicle_generic_neutral";
    } else if(istrue(scriptableinstance.entity.var_54dc11292e53791b)) {
      return;
    } else {
      var_3ef0fdcee94cadff = #"ping_location_go";
    }
  } else if(isDefined(var_c1074ab6cac2169f.type) && (var_c1074ab6cac2169f.type == "dmz_gas_station" || var_c1074ab6cac2169f.type == "dmz_gas_station_marine")) {
    return undefined;
  } else if(issharedfuncdefined("pickups", "isDogTag") && isDefined(scriptableinstance.type) && [[getsharedfunc("pickups", "isDogTag")]](scriptableinstance.type)) {
    if(issharedfuncdefined("dogtag", "getDogTagVictimAndKiller")) {
      var_e9a68e6d68d81012 = [[getsharedfunc("dogtag", "getDogTagVictimAndKiller")]](scriptableinstance.count)[0];

      if(isDefined(level.dogtaginfo) && isDefined(level.dogtaginfo[var_e9a68e6d68d81012]) && isDefined(level.dogtaginfo[var_e9a68e6d68d81012].team) && self.team == level.dogtaginfo[var_e9a68e6d68d81012].team) {
        var_3ef0fdcee94cadff = #"ping_rh_dogtags";
      } else {
        var_3ef0fdcee94cadff = player calloutmarkerpingvo_getcalloutaliasstringloot(pingindex, var_c1074ab6cac2169f);
      }
    } else {
      var_3ef0fdcee94cadff = player calloutmarkerpingvo_getcalloutaliasstringloot(pingindex, var_c1074ab6cac2169f);
    }
  } else if(isDefined(scriptableinstance) && isDefined(scriptableinstance.type) && scriptableinstance.type == "map2map_tacmap_location_scriptable") {
    var_3ef0fdcee94cadff = #"ping_location_go";
  } else if(isDefined(scriptableinstance) && isDefined(scriptableinstance.type) && scriptableinstance.type == "ob_aethernest_cyst_scriptable") {
    var_3ef0fdcee94cadff = #"ping_objective_destroy_generic";
  } else {
    var_3ef0fdcee94cadff = player calloutmarkerpingvo_getcalloutaliasstringloot(pingindex, var_c1074ab6cac2169f);
  }

  return var_3ef0fdcee94cadff;
}

function calloutmarkerpingvo_getcalloutaliasstringvehicle(var_7a5b847ea66815f) {
  player = self;

  if(isDefined(var_7a5b847ea66815f) && isent(var_7a5b847ea66815f)) {
    var_f5013bae6266622f = var_7a5b847ea66815f;
  } else {
    assertmsg("<dev string:x48>" + "<dev string:x2b5>");
    return "";
  }

  if(isDefined(var_7a5b847ea66815f.var_51427fea41863faa)) {
    return [[var_7a5b847ea66815f.var_51427fea41863faa]]();
  }

  if(istrue(var_7a5b847ea66815f.var_4a4265af0a6f92e9)) {
    return #"ping_exfil_heli";
  } else if(istrue(var_7a5b847ea66815f ent_flag_exist("armored_convoy_spawned"))) {
    return #"ping_convoy";
  } else if(istrue(var_7a5b847ea66815f.var_177d31bd38d64887)) {
    return #"ping_cargo_heli";
  } else if(isDefined(var_f5013bae6266622f.streakname)) {
    killstreakvo = function_e57c4849c7935da(var_f5013bae6266622f, player);

    if(isDefined(killstreakvo)) {
      return killstreakvo;
    }
  }

  if(issharedfuncdefined("ping", "ping_cp_getCPVehicleCallout")) {
    result = [[getsharedfunc("ping", "ping_cp_getCPVehicleCallout")]](var_f5013bae6266622f);

    if(isDefined(result) && istrue(result.bshouldreturnvalue)) {
      return result.vocalloutstring;
    }
  }

  if(isDefined(var_f5013bae6266622f.infil) && isDefined(level.var_c96464f39952b78a)) {
    vehiclename = [[level.var_c96464f39952b78a]](var_f5013bae6266622f);
    return hashcat(#"hash_f2ffb8c48b7ba213", vehiclename, "_neutral");
  }

  if(!isDefined(var_f5013bae6266622f.vehiclename)) {
    assertmsg("<dev string:x48>" + "<dev string:x344>");
    return #"hash_dbe73992c2a084d2";
  }

  vehicleref = var_f5013bae6266622f function_d93ec4635290febd();
  bctypename = undefined;
  var_5011b777abe6b90e = undefined;

  if(isDefined(vehicleref)) {
    var_5011b777abe6b90e = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(vehicleref);
  }

  if(isDefined(var_5011b777abe6b90e)) {
    bctypename = var_5011b777abe6b90e.bctypename;
  }

  if(!isDefined(bctypename) || bctypename == "") {
    bctypename = "generic";
  }

  if(var_f5013bae6266622f scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown()) {
    return hashcat(#"hash_9216f9fdf0e7ccd", bctypename);
  }

  if(istrue(var_f5013bae6266622f scripts\cp_mp\vehicles\vehicle::isvehiclehusk())) {
    return hashcat(#"hash_3cdaf22ea7689e07", bctypename);
  }

  if(function_6641a5b759148e1b() && isDefined(vehicleref)) {
    if(vehicleref == "veh9_palfa") {
      return #"ping_exfil_heli";
    } else if(vehicleref == "veh9_blima") {
      return #"ping_cargo_heli";
    }
  }

  isvehicleenemy = _calloutmarkerping_isvehicleoccupiedbyenemy(var_f5013bae6266622f, player.team) || isDefined(vehicleref) && vehicleref == "dmz_boss_chopper";

  if(istrue(isvehicleenemy)) {
    return hashcat(#"hash_f2ffb8c48b7ba213", bctypename, "_hostile");
  }

  return hashcat(#"hash_f2ffb8c48b7ba213", bctypename, "_neutral");
}

function function_e57c4849c7935da(ent, player) {
  if(!isDefined(ent) || !isDefined(ent.streakname)) {
    return undefined;
  }

  switch (ent.streakname) {
    case #"hash_413c38e72fe8b5bf":
      if(ent.team == player.team) {
        return #"ping_killstreak_gunship";
      } else {
        return #"ping_killstreak_gunship_hostile";
      }
    case #"hash_349713b5ad494dda":
      if(ent.team == player.team) {
        return #"ping_killstreak_choppergunner";
      } else {
        return #"ping_killstreak_choppergunner_hostile";
      }
    case #"hash_28d0236400e33fd0":
      if(ent.team == player.team) {
        return #"ping_killstreak_cruisemissile";
      } else {
        return #"ping_killstreak_cruisemissile_hostile";
      }
    case #"hash_b161e185f1b8e117":
      if(ent.team == player.team) {
        return #"ping_killstreak_autodrone";
      } else {
        return #"ping_killstreak_autodrone_hostile";
      }
    case #"hash_887ad77192b9c4fb":
    case #"hash_691f39dddd9116b8":
      if(ent.team == player.team) {
        return #"ping_killstreak_airsupport_generic";
      } else {
        return #"ping_killstreak_airsupport_generic_hostile";
      }
    case #"hash_cf0ef5bef19a311b":
      if(ent.team == player.team) {
        return #"ping_killstreak_mobilesentry";
      } else {
        return #"ping_killstreak_mobilesentry_hostile";
      }
    case #"hash_2289ec11d77bce8f":
      if(ent.team == player.team) {
        return #"ping_killstreak_emergencyairdrop";
      } else {
        return #"ping_killstreak_emergencyairdrop_hostile";
      }
    case #"hash_4ad475e6e15635bd":
    case #"hash_56979e0566996b2e":
    case #"hash_cd0a0403551fc411":
    case #"hash_e477c24ee18bb2f6":
      if(ent.team == player.team) {
        return #"ping_killstreak_airdrop_generic";
      } else {
        return #"ping_killstreak_airdrop_generic_hostile";
      }
    case #"hash_fa4536bde6f7ad9":
    case #"hash_4d5aa76e8707f47b":
      if(ent.team == player.team) {
        return #"ping_killstreak_sentrygun";
      } else {
        return #"ping_killstreak_sentrygun_hostile";
      }
    case #"hash_bf2f9adbd2b41d5":
      if(ent.team == player.team) {
        return #"ping_killstreak_vtol";
      } else {
        return #"ping_killstreak_vtol_hostile";
      }
    case #"hash_4220be38a5f150b8":
    case #"hash_42fd64e842a4c3d7":
    case #"hash_8c766d6477287bb6":
    case #"hash_b4ac3581c343a029":
    case #"hash_e6bea339d3cbd3e8":
      if(ent.team == player.team) {
        return #"ping_killstreak_airstrike_generic";
      } else {
        return #"ping_killstreak_airstrike_generic_hostile";
      }
    case #"hash_e171e5b86ef0a4cc":
      if(ent.team == player.team) {
        return #"ping_killstreak_advuav";
      } else {
        return #"ping_killstreak_advuav_hostile";
      }
    case #"hash_634b246c3da5c56f":
    case #"hash_e51f2e3d5cdd8ed8":
      if(ent.team == player.team) {
        return #"ping_killstreak_uav";
      } else {
        return #"ping_killstreak_uav_hostile";
      }
    case #"hash_10e585c25e7e9f60":
    case #"hash_27002778019fb447":
    case #"hash_566a2018a7c11f4a":
      if(ent.team == player.team) {
        return #"ping_killstreak_counteruav";
      } else {
        return #"ping_killstreak_counteruav_hostile";
      }
    case #"hash_4d35eb58f9d545f0":
      if(ent.team == player.team) {
        return #"ping_killstreak_clustermine";
      } else {
        return #"ping_killstreak_clustermine_hostile";
      }
    case #"hash_9e36e3bd3a9dd00d":
      if(ent.team == player.team) {
        return #"ping_killstreak_bombdrone";
      } else {
        return #"ping_killstreak_bombdrone_hostile";
      }
    case #"hash_e40585107590f016":
      if(ent.team == player.team) {
        return #"ping_fieldupgrade_recondrone";
      } else {
        return #"ping_fieldupgrade_recondrone_hostile";
      }
    case #"hash_6362d6aae3e5a62e":
      if(ent.team == player.team) {
        return #"ping_killstreak_drone_swarm";
      } else {
        return #"ping_killstreak_drone_swarm_hostile";
      }
    case #"hash_19dd9a3a4147e09e":
      if(ent.team == player.team) {
        return #"ping_killstreak_lrad";
      } else {
        return #"ping_killstreak_lrad_hostile";
      }
    case #"hash_b571a6187bf67f9e":
      if(ent.team == player.team) {
        return #"ping_killstreak_missile_turret";
      } else {
        return #"ping_killstreak_missile_turret_hostile";
      }
    case #"hash_ab5712e297cd430e":
      if(ent.team == player.team) {
        return #"ping_killstreak_remoteturret";
      } else {
        return #"ping_killstreak_remoteturret_hostile";
      }
    case #"hash_7a687f6a4d685110":
      if(ent.team == player.team) {
        return #"ping_killstreak_switchblade_drone";
      } else {
        return #"ping_killstreak_switchblade_drone_hostile";
      }
    case #"hash_472d8b6c2f51a9c8":
      if(ent.team == player.team) {
        return #"ping_killstreak_ims";
      } else {
        return #"ping_killstreak_ims_hostile";
      }
    default:
      assertmsg("<dev string:x48>" + "<dev string:x381>" + ent.streakname);
      break;
  }

  return undefined;
}

function calloutmarkerpingvo_getcalloutaliasstringworld(pingindex) {
  player = self;

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && scripts\cp_mp\utility\game_utility::getgametype() != "ob") {
    return #"ping_location_go";
  }

  playerobjectiveindex = player calloutmarkerping_getgscobjectiveindex(pingindex);
  assert(isint(playerobjectiveindex));

  if(isDefined(level.questinfo) && isDefined(level.questinfo.quests) && isDefined(level.questinfo.quests["vip"]) && isDefined(level.questinfo.quests["vip"].instances)) {
    foreach(teamstruct in level.questinfo.quests["vip"].instances) {
      var_c00e9479f3c48b03 = teamstruct.objectiveiconid;

      if(!isDefined(var_c00e9479f3c48b03)) {
        continue;
      }

      if(var_c00e9479f3c48b03 == playerobjectiveindex) {
        return #"ping_enemy_infantry";
      }
    }
  }

  if(isDefined(level.pleaforhelp) && isDefined(level.pleaforhelp.var_807ffb67240349f5)) {
    foreach(request in level.pleaforhelp.var_807ffb67240349f5) {
      if(!isDefined(request.objid) || request.objid != playerobjectiveindex) {
        continue;
      }

      return #"ping_request_revive_confirm";
    }
  }

  var_759cea0c926c3b8a = objective_geticon(playerobjectiveindex);

  if(isDefined(var_759cea0c926c3b8a)) {
    switch (var_759cea0c926c3b8a) {
      case #"hash_1075324f0436e1a1":
        return #"ping_loadout";
      case #"hash_4cbfef445e35dd14":
        return #"ping_loot_cash";
      case #"hash_4abd0ee7bbd5963a":
        return #"ping_buystation";
      case #"hash_12d67c7796befcfc":
        return #"ping_cache";
      case #"hash_90ee989288818d54":
        return #"ping_objective_destroy_generic";
      case #"hash_f128412207d3dff":
      case #"hash_ef52726f863e918c":
        return #"ping_objective_defend_generic";
      case #"hash_e72b710c86eed3e4":
        return #"ping_objective_spotted_device";
      case #"hash_c810e4c79ffe58":
        return #"ping_boss_generic";
      case #"hash_512b4048208f0ea9":
        return #"ping_stash";
      case #"hash_52e64b07a8b95f29":
        return #"ping_cargo_lz";
      case #"hash_fa801fd3fbd9ee68":
      case #"hash_fa8021d3fbd9f18e":
      case #"hash_fa8022d3fbd9f321":
      case #"hash_fa8024d3fbd9f647":
        return #"ping_loot_generic";
      case #"hash_a6aad43a264df73e":
        return #"ping_area_denial";
      default:
        break;
    }
  }

  var_2d618a34e27d5476 = undefined;

  if(player function_929ee540ad474f2f("ui_br_objective_index")) {
    var_2d618a34e27d5476 = player getclientomnvar("ui_br_objective_index");
  }

  if(isDefined(var_2d618a34e27d5476) && var_2d618a34e27d5476 != 0) {
    questref = tablelookup("mp/brmissions.csv", 0, var_2d618a34e27d5476, 1);
    queststring = tablelookup("mp/brmissions.csv", 0, var_2d618a34e27d5476, 18);
    var_962b7ef0a10e1038 = #"ping_contract_initial_generic";

    if(isDefined(queststring) && queststring != "") {
      assert(isstring(queststring));

      switch (queststring) {
        case #"hash_96e641d7fe5b1cf1":
        case #"hash_d43a3732d39e4a11":
        case #"hash_de61e484b9734ea1":
          return #"ping_contract_initial_bounty";
        case #"hash_96815ed47cc355cf":
          return #"hash_e28085aadfae5d1c";
        case #"hash_cc7c1c701864c7bf":
        case #"hash_d0eb8b9de6742b83":
          return #"hash_e28085aadfae5d1c";
        case #"hash_5c57b61aa79410db":
          return #"ping_cache";
        case #"hash_d0eb63c46c25ef55":
          return #"ping_contract_initial_secureintel";
        case #"hash_7b0c576c4a7e4890":
          return #"ping_contract_initial_mostwanted";
        case #"hash_bf5597954aaed3d7":
          return #"ping_contract_initial_recon";
        case #"hash_d22bc78737d8a069":
          if(isDefined(questref) && questref == "elite_safecracker") {
            return #"ping_objective_capture_generic";
          }

          return var_962b7ef0a10e1038;
        case #"hash_f4a9126c03d3385b":
          if(isDefined(questref) && questref == "dmz_domination") {
            return #"ping_uploadstation";
          }

          return #"ping_target_area";
        case #"hash_75b6db03edb1e84e":
          return #"ping_contract_initial_elimination";
        case #"hash_194f31f722d1fa09":
        case #"hash_82ea0e6e4f123b62":
          return #"ping_contract_initial_trap";
        case #"hash_e0b82e0f064c17d6":
          if(var_2d618a34e27d5476 == 46) {
            return #"ping_hostage";
          }

          return #"ping_hostage_lz";
        case #"hash_e91729d4ef79ca26":
          return #"ping_contract_initial_geigersearch";
        case #"hash_37bb23543c319104":
          return #"ping_elimtarget";
        case #"hash_1e754eb11fa62651":
        case #"hash_9db32d30f2603c35":
          return #"ping_contract_initial_cargo";
        case #"hash_cf3abe09f0094696":
          return #"ping_location_go";
        case #"hash_4f0e37558d043245":
          if(isDefined(questref) && questref == "zombienest_eliminate") {
            return #"ping_enemy_infantry";
          }

          break;
        default:
          break;
      }
    }
  }

  return #"ping_location_go";
}

function function_d7fb39f0e6e8f752(scriptablename) {
  if(!istrue(level.var_a9350d89a2e4d752)) {
    if(!isDefined(level.br_pickups) || !isDefined(level.br_pickups.var_11feb85e78e7cee8)) {
      return undefined;
    }

    row = tablelookuprownum_reversefromrow(level.brloottablename, 1, scriptablename, level.br_pickups.var_11feb85e78e7cee8 - 1);
    return row;
  }

  return undefined;
}

function calloutmarkerpingvo_getcalloutaliasstringloot(pingindex, var_394382528911801d) {
  player = self;

  if(isDefined(var_394382528911801d) && isDefined(var_394382528911801d.type)) {
    var_869d699197f920a2 = var_394382528911801d.type;

    if(issharedfuncdefined("loot", "lootGetScriptableName")) {
      var_869d699197f920a2 = [[getsharedfunc("loot", "lootGetScriptableName")]](var_394382528911801d);
    }

    if(!isDefined(var_869d699197f920a2)) {
      return #"";
    }
  } else {
    assertmsg("<dev string:x48>" + "<dev string:x3b8>" + player calloutmarkerping_gettype(pingindex));
    return #"";
  }

  if(issubstr(var_869d699197f920a2, "activity_starter")) {
    if(issharedfuncdefined("pmc_missions", "onPingContractPhone")) {
      [[getsharedfunc("pmc_missions", "onPingContractPhone")]](player);
    }
  }

  if(!istrue(level.var_a9350d89a2e4d752)) {
    row = function_d7fb39f0e6e8f752(var_869d699197f920a2);

    if(!isDefined(row) || row < 0) {
      return function_abc85f8465a92be8(var_869d699197f920a2, var_394382528911801d, player);
    }
  }

  if(istrue(level.var_a9350d89a2e4d752)) {
    type = level.br_pickups.br_itemtype[var_869d699197f920a2];

    if(!isDefined(type)) {
      type = #"";
    }
  } else {
    type = getxhash(tablelookupbyrow(level.brloottablename, row, 2));
  }

  if(type == #"weapon") {
    return function_8d17e607a79fd65f(var_869d699197f920a2);
  }

  if(type == #"questsafe" && isDefined(var_394382528911801d.safestruct) && isDefined(var_394382528911801d.task) && var_394382528911801d.task.teams[0] != player.team) {
    return #"ping_location_go";
  }

  if(istrue(level.var_a9350d89a2e4d752)) {
    var_832ad168567520f7 = level.br_pickups.var_59e01317f76cf924[var_869d699197f920a2];

    if(!isDefined(var_832ad168567520f7)) {
      var_832ad168567520f7 = "";
    }

    if(var_832ad168567520f7 == "" || var_832ad168567520f7 == "ping_loot_generic") {
      return function_abc85f8465a92be8(var_869d699197f920a2, var_394382528911801d, player);
    }
  } else {
    var_832ad168567520f7 = tablelookupbyrow(level.brloottablename, row, 29);
  }

  if(!isDefined(var_832ad168567520f7) || var_832ad168567520f7 == "") {
    assertmsg("<dev string:x48>" + "<dev string:x3ff>" + var_869d699197f920a2 + "<dev string:x439>");
    return #"ping_loot_generic";
  }

  if(!isxhash(var_832ad168567520f7)) {
    if(var_832ad168567520f7 == "ping_loot_ammo_midcaliber" && scripts\engine\utility::issharedfuncdefined("player", "lookupCurrentOperator")) {
      if(player[[scripts\engine\utility::getsharedfunc("player", "lookupCurrentOperator")]](player.team) == "luna_western") {
        return #"ping_inv_have_ammo_midcaliber";
      }
    }

    return getxhash(var_832ad168567520f7);
  }

  return var_832ad168567520f7;
}

function function_abc85f8465a92be8(var_869d699197f920a2, var_394382528911801d, player) {
  if(var_869d699197f920a2 == "brloot_plunder_extraction_site_01" || var_869d699197f920a2 == "brloot_plunder_extraction_site_02" || var_869d699197f920a2 == "equip_fulton_mp") {
    return #"ping_fulton";
  } else if(var_869d699197f920a2 == "ks_airdrop_crate_br") {
    return #"ping_cache";
  } else if(var_869d699197f920a2 == "br_carriable_propane" || var_869d699197f920a2 == "br_carriable_neurotoxin") {
    return #"ping_loot_equipment_lethal_generic";
  } else if(var_869d699197f920a2 == "fortress_tacmap_location" || var_869d699197f920a2 == "fortress_tacmap_location_scriptable") {
    return #"ping_stronghold";
  } else if(var_869d699197f920a2 == "br_plunder_box" || var_869d699197f920a2 == "br_plunder_box_nocollision") {
    return #"ping_buystation";
  } else if(var_869d699197f920a2 == "dmz_activity_icon") {
    return #"ping_contract_initial_generic";
  } else if(var_869d699197f920a2 == "military_ammo_restock_noent") {
    return #"ping_ammo_depot";
  } else if(var_869d699197f920a2 == "dmz_samsite_icon") {
    if(isDefined(var_394382528911801d.team) && isDefined(player) && isDefined(player.team)) {
      if(player.team == var_394382528911801d.team) {
        return #"ping_samsite_friendly";
      } else {
        return #"ping_samsite_hostile";
      }
    }

    return #"ping_samsite_neutral";
  } else if(issubstr(var_869d699197f920a2, "uav_tower")) {
    if(isDefined(var_394382528911801d.activeteam) && isDefined(player) && isDefined(player.team)) {
      if(player.team == var_394382528911801d.activeteam) {
        return #"ping_uavtower_friendly";
      } else {
        return #"ping_uavtower_hostile";
      }
    }

    return #"ping_uavtower_neutral";
  } else if(isDefined(var_394382528911801d) && istrue(var_394382528911801d.var_47d27267be4655fb)) {
    return #"ping_redeploy_drone";
  } else if(var_869d699197f920a2 == "sealion_chance_machine") {
    return #"ping_prize_machine";
  } else if(var_869d699197f920a2 == "ob_jup_aethertear") {
    return #"ping_invalid";
  } else if(var_869d699197f920a2 == "br_nuke_safe") {
    return #"ping_objective_capture_generic";
  } else if(var_869d699197f920a2 == "jup_biometric_scanner") {
    return #"ping_biometric_scanner";
  } else if(var_869d699197f920a2 == "scriptable_redeploy_drone_extended") {
    return #"ping_redeploy_drone";
  }

  return #"ping_loot_generic";
}

function function_8d17e607a79fd65f(weaponname) {
  if(isDefined(level.br_pickups) && isDefined(level.br_pickups.var_59e01317f76cf924)) {
    if(isDefined(level.br_pickups.var_59e01317f76cf924[weaponname])) {
      return level.br_pickups.var_59e01317f76cf924[weaponname];
    }
  }

  if(isDefined(level.br_lootiteminfo) && isDefined(level.br_lootiteminfo[weaponname]) && isDefined(level.br_lootiteminfo[weaponname].fullweaponobj)) {
    weaponname = level.br_lootiteminfo[weaponname].fullweaponobj.basename;
  }

  if(isDefined(weaponname) && (issubstr(weaponname, "iw9_dm_la700") || issubstr(weaponname, "iw9_dm_xmike2010"))) {
    weaponname = ter_op(weaponname == "iw9_dm_la700", "iw9_sn_la700", "iw9_sn_xmike2010");
  }

  if(issubstr(weaponname, "_me_riotshield")) {
    return #"ping_loot_weapon_riotshield";
  }

  if(issubstr(weaponname, "_me_") || isendstr(weaponname, "_me")) {
    return #"ping_loot_weapon_melee";
  }

  if(issubstr(weaponname, "_pi_") || isendstr(weaponname, "_pi")) {
    return #"ping_loot_weapon_pistol";
  }

  if(issubstr(weaponname, "_sh_") || isendstr(weaponname, "_sh")) {
    return #"ping_loot_weapon_shotgun";
  }

  if(issubstr(weaponname, "_sm_") || isendstr(weaponname, "_sm")) {
    return #"ping_loot_weapon_smg";
  }

  if(issubstr(weaponname, "_ar_") || isendstr(weaponname, "_ar")) {
    return #"ping_loot_weapon_assaultrifle";
  }

  if(issubstr(weaponname, "_lm_") || isendstr(weaponname, "_lm")) {
    return #"ping_loot_weapon_lmg";
  }

  if(!issubstr(weaponname, "crossbow") && (issubstr(weaponname, "_dm_") || isendstr(weaponname, "_dm"))) {
    return #"ping_loot_weapon_dmr";
  }

  if(!issubstr(weaponname, "crossbow") && (issubstr(weaponname, "_sn_") || isendstr(weaponname, "_sn"))) {
    return #"ping_loot_weapon_sniper";
  }

  if(issubstr(weaponname, "_la_") || isendstr(weaponname, "_la")) {
    return #"ping_loot_weapon_launcher";
  }

  if(issubstr(weaponname, "_br_") || isendstr(weaponname, "_br")) {
    return #"ping_loot_equipment_battlerifle";
  }

  return #"ping_loot_generic";
}

function function_9bb1120b45cfa775(pingindex) {
  player = self;
  var_c1074ab6cac2169f = player calloutmarkerping_getEnt(pingindex);

  if(!isDefined(var_c1074ab6cac2169f)) {
    return #"ping_vehicle_confirm";
  }

  if(!isent(var_c1074ab6cac2169f)) {
    return #"ping_vehicle_confirm";
  }

  vehicleref = var_c1074ab6cac2169f function_d93ec4635290febd();

  if(!isDefined(vehicleref)) {
    return #"ping_vehicle_confirm";
  }

  if(function_6641a5b759148e1b()) {
    if(vehicleref == "veh9_palfa") {
      return #"ping_exfil_heli_confirm";
    }
  }

  return #"ping_vehicle_confirm";
}

function function_befa2cbd9d478179(pingindex) {
  player = self;
  var_2d618a34e27d5476 = undefined;

  if(player function_929ee540ad474f2f("ui_br_objective_index")) {
    var_2d618a34e27d5476 = player getclientomnvar("ui_br_objective_index");
  }

  if(isDefined(var_2d618a34e27d5476) && var_2d618a34e27d5476 != 0) {
    queststring = tablelookup("mp/brmissions.csv", 0, var_2d618a34e27d5476, 18);
    var_962b7ef0a10e1038 = #"ping_contract_initial_generic";

    if(isDefined(queststring) && queststring != "") {
      assert(isstring(queststring));

      switch (queststring) {
        case #"hash_f4a9126c03d3385b":
          return #"ping_uploadstation_confirm";
        case #"hash_e0b82e0f064c17d6":
          return #"ping_hostage";
        default:
          return #"ping_response_copy";
      }
    }
  }

  playerobjectiveindex = player calloutmarkerping_getgscobjectiveindex(pingindex);
  var_759cea0c926c3b8a = objective_geticon(playerobjectiveindex);

  if(isDefined(var_759cea0c926c3b8a)) {
    switch (var_759cea0c926c3b8a) {
      case #"hash_1075324f0436e1a1":
        return #"ping_loadout_confirm";
      default:
        break;
    }
  }

  return #"ping_response_copy";
}

function calloutmarkerpingvo_getaffirmaliasstringloot(pingindex, var_394382528911801d, var_dfb9f3c233e2b8f3) {
  player = self;

  if(isDefined(var_394382528911801d) && isDefined(var_394382528911801d.type)) {
    var_869d699197f920a2 = var_394382528911801d.type;
  } else {
    pingtype = player calloutmarkerping_gettype(pingindex);
    assertmsg("<dev string:x48>" + "<dev string:x43e>" + pingtype);
    return "";
  }

  if(utility::issharedfuncdefined("game", "getBundleNameFromScriptable")) {
    itembundlename = [[utility::getsharedfunc("game", "getBundleNameFromScriptable")]](var_869d699197f920a2);

    if(isDefined(itembundlename)) {
      itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

      if(isDefined(itembundle) && isDefined(itembundle.var_359e971d09addafc)) {
        return itembundle.var_359e971d09addafc;
      }
    }
  }

  row = function_d7fb39f0e6e8f752(var_869d699197f920a2);

  if(!isDefined(row) || row < 0) {
    if(isDefined(var_394382528911801d) && isDefined(var_394382528911801d.entity)) {
      if(_calloutmarkerping_isdropcrate(var_394382528911801d.entity)) {
        return #"ping_loadout_confirm";
      }
    }

    if(var_869d699197f920a2 == "brloot_plunder_extraction_site_01" || var_869d699197f920a2 == "brloot_plunder_extraction_site_02" || var_869d699197f920a2 == "equip_fulton_mp") {
      return #"ping_fulton_confirm";
    } else if(var_869d699197f920a2 == "br_plunder_box" || var_869d699197f920a2 == "br_plunder_box_nocollision") {
      return #"ping_buystation_confirm";
    } else if(var_869d699197f920a2 == "dmz_samsite_icon") {
      return #"ping_samsite_confirm";
    } else if(var_869d699197f920a2 == "dmz_uav_tower" || var_869d699197f920a2 == "dmz_uav_tower_short") {
      return #"ping_uavtower_confirm";
    } else if(var_869d699197f920a2 == "fortress_tacmap_location" || var_869d699197f920a2 == "fortress_tacmap_location_scriptable" || var_869d699197f920a2 == "merc_stronghold_center_objective_marker") {
      return #"ping_stronghold_confirm";
    } else if(var_869d699197f920a2 == "dmz_exfil_site") {
      return #"ping_response_affirm";
    } else if(isDefined(var_394382528911801d.entity) && isDefined(var_394382528911801d.entity.vehiclename) && var_394382528911801d.entity.vehiclename == "cargo_train") {
      return #"ping_vehicle_confirm";
    } else if(var_869d699197f920a2 == "jup_zm_pap_fxanim" || var_869d699197f920a2 == "jup_zm_mystery_box_all_fxanim" || var_869d699197f920a2 == "military_ammo_restock_noent" || var_869d699197f920a2 == "dmz_gas_station" || var_869d699197f920a2 == "dmz_gas_station_marine" || var_869d699197f920a2 == "jup_zm_machine_wunderfizz" || istrue(var_394382528911801d.var_47d27267be4655fb) || isDefined(var_394382528911801d.var_a2738a1d42906829) || issubstr(var_869d699197f920a2, "wallbuy_")) {
      return #"ping_response_affirm";
    }

    if(!istrue(level.var_a9350d89a2e4d752)) {
      return #"ping_loot_confirm_generic";
    }
  }

  if(istrue(level.var_a9350d89a2e4d752)) {
    type = level.br_pickups.br_itemtype[var_869d699197f920a2];

    if(!isDefined(type)) {
      type = #"";
    }
  } else {
    type = getxhash(tablelookupbyrow(level.brloottablename, row, 2));
  }

  if(type == #"weapon") {
    return #"ping_loot_confirm_weapon";
  }

  if(istrue(level.var_a9350d89a2e4d752)) {
    var_832ad168567520f7 = level.br_pickups.var_caf82339100de589[var_869d699197f920a2];
  } else {
    var_832ad168567520f7 = tablelookupbyrow(level.brloottablename, row, 30);
  }

  if(!isDefined(var_832ad168567520f7) || var_832ad168567520f7 == "") {
    if(!istrue(level.var_a9350d89a2e4d752)) {
      assertmsg("<dev string:x48>" + "<dev string:x3ff>" + var_869d699197f920a2 + "<dev string:x439>");
    }

    return #"ping_loot_confirm_generic";
  }

  return var_832ad168567520f7;
}

function calloutmarkerping_createcallout(pingtype, pingorigin, objectid, lootid) {
  player = self;
  var_60693f12aa0f707d = undefined;

  if(isDefined(lootid)) {
    assert(isDefined(objectid));
    var_60693f12aa0f707d = player function_c013e9dddee96e76(pingtype, pingorigin, objectid, lootid);
  } else if(isDefined(objectid)) {
    var_60693f12aa0f707d = player function_c013e9dddee96e76(pingtype, pingorigin, objectid);
  } else {
    var_60693f12aa0f707d = player function_c013e9dddee96e76(pingtype, pingorigin);
  }

  if(isDefined(var_60693f12aa0f707d)) {
    oldowner = getentbynum(var_60693f12aa0f707d.var_51b8d478055e5509);

    if(isPlayer(oldowner)) {
      _calloutmarkerping_predicted_log("Remove Callout ID Notify ( reallocated ) | pingIndex: " + var_60693f12aa0f707d.pingindex);
      oldowner notify("predictiveCalloutClear_" + var_60693f12aa0f707d.pingindex);
    }

    return var_60693f12aa0f707d.pingindex;
  }
}

function calloutmarkerping_removecallout(pingindex) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  if(!player function_1e008bf9d31b2b01(pingindex)) {
    _calloutmarkerping_predicted_log("Remove Callout ( failed due to owner mismatch ) | pingIndex: " + pingindex);
  } else {
    _calloutmarkerping_predicted_log("Remove Callout | pingIndex: " + pingindex);
    pingtype = player calloutmarkerping_gettype(pingindex);

    if(isDefined(pingtype) && pingtype >= 2 && pingtype < 37) {
      if(pingtype == 2) {
        if(issharedfuncdefined("ping", "calloutMarkerPing_squadLeaderBeaconKillForPlayer")) {
          [[getsharedfunc("ping", "calloutMarkerPing_squadLeaderBeaconKillForPlayer")]](player);
        }
      }

      player function_4a7d51f2dfc2fa5d(pingindex);

      if(pingtype == 5) {
        player function_6c9b8f9429b7fdca(player.team);
      }
    }
  }

  _calloutmarkerping_predicted_log("Remove Callout ID Notify ( removed ) | pingIndex: " + pingindex);
  player notify("predictiveCalloutClear_" + pingindex);
}

function function_9a7200f5142066ba(player, pingindex, endonnotifies, waittillnotifies, waittilltimeout) {
  entity = self;

  if(!isPlayer(player)) {
    return;
  }

  player endon("predictiveCalloutClear_" + pingindex);

  if(isDefined(endonnotifies)) {
    foreach(endonnotify in endonnotifies) {
      entity endon(endonnotify);
    }
  }

  if(isDefined(waittilltimeout) && isDefined(waittillnotifies)) {
    entity waittill_any_in_array_or_timeout(waittillnotifies, waittilltimeout);
  } else if(isDefined(waittilltimeout)) {
    wait waittilltimeout;
  } else if(isDefined(waittillnotifies)) {
    entity waittill_any_in_array(waittillnotifies);
  }

  player calloutmarkerping_removecallout(pingindex);
}

function function_6bc4f6b579285f79(player, var_8c7d921795d81e3, var_2229564b4895f551) {
  scriptable = self;

  if(isDefined(player)) {
    var_ba5325edfebd6a58 = self function_1a0b76d2ca8a1547(player, default_to(var_8c7d921795d81e3, 0), default_to(var_2229564b4895f551, 0));
  } else {
    var_ba5325edfebd6a58 = self function_1a0b76d2ca8a1547();
  }

  if(isDefined(var_ba5325edfebd6a58)) {
    foreach(var_697ef06ff2ab334b in var_ba5325edfebd6a58) {
      player = getentbynum(var_697ef06ff2ab334b.pingowner);

      if(isPlayer(player)) {
        player notify("predictiveCalloutClear_" + var_697ef06ff2ab334b.pingindex);
      }
    }
  }
}

function function_cd96f73dbca496b8(objid) {
  var_ba5325edfebd6a58 = function_5a64d34a848aeda6(objid);

  if(isDefined(var_ba5325edfebd6a58)) {
    foreach(var_697ef06ff2ab334b in var_ba5325edfebd6a58) {
      player = getentbynum(var_697ef06ff2ab334b.pingowner);

      if(isPlayer(player)) {
        player notify("predictiveCalloutClear_" + var_697ef06ff2ab334b.pingindex);
      }
    }
  }
}

function calloutmarkerping_watchwhenobjectivestartsprogress(pingindex, gscobjectiveid) {
  assertex(isPlayer(self), "<dev string:x48>" + "<dev string:x482>");
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + pingindex);

  while(true) {
    level waittill("Objective_SetShowProgress", var_8a2e167f6894d193);

    if(function_53ebc25dcfe48d00(self, var_8a2e167f6894d193) && isDefined(var_8a2e167f6894d193) && var_8a2e167f6894d193 == gscobjectiveid) {
      _calloutmarkerping_predicted_log("Objective started progress | pingIndex: " + pingindex + " | gscObjID: " + gscobjectiveid);
      break;
    }
  }

  calloutmarkerping_removecallout(pingindex);
}

function calloutmarkerping_watchwhenobjectivedeleted(pingindex, gscobjectiveid) {
  assertex(isPlayer(self), "<dev string:x48>" + "<dev string:x4c0>");
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + pingindex);

  while(true) {
    level waittill("Objective_Delete", deletedobjectiveid);

    if(isDefined(deletedobjectiveid) && deletedobjectiveid == gscobjectiveid) {
      _calloutmarkerping_predicted_log("Objective deleted | pingIndex: " + pingindex + " | gscObjID: " + gscobjectiveid);
      break;
    }
  }

  calloutmarkerping_removecallout(pingindex);
}

function function_632cc7f8cbf11ae1(pingindex, ent) {
  assertex(isPlayer(self), "<dev string:x48>" + "<dev string:x510>");
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + pingindex);
  _calloutmarkerping_predicted_log("Watch Entity Death or Enemy Disconnect | pingIndex: " + pingindex);

  if(!isDefined(ent)) {
    assertmsg("<dev string:x48>" + "<dev string:x55b>");
  }

  if(!isent(ent)) {
    ent waittill_any_3("death", "pickup", "explode");
    return;
  }

  if(isPlayer(ent)) {
    val = ent waittill_any_return_3("death", "faux_dead", "disconnect");

    if(isDefined(level.gamemodebundle) && !istrue(level.gamemodebundle.var_dd7fbece86363b3f) || val == "disconnect") {
      calloutmarkerping_removecallout(pingindex);
    } else {
      thread calloutmarkerping_enemytodangerdecaycreate(pingindex, ent);
    }

    return;
  }

  if(isagent(ent)) {
    ent waittill("death");

    if(isDefined(level.gamemodebundle) && !istrue(level.gamemodebundle.var_dd7fbece86363b3f)) {
      calloutmarkerping_removecallout(pingindex);
    } else {
      thread calloutmarkerping_enemytodangerdecaycreate(pingindex, ent);
    }

    return;
  }

  if(!istrue(ent.isdestroyed)) {
    ent waittill_any_3("death", "pickup", "explode");
  }

  calloutmarkerping_removecallout(pingindex);
}

function calloutmarkerping_watchplayerdeathordisconnect(pingindex) {
  player = self;
  assertex(isPlayer(self), "<dev string:x48>" + "<dev string:x5be>");
  self endon("predictiveCalloutClear_" + pingindex);
  _calloutmarkerping_predicted_log("Watch Player Death or Disconnect | pingIndex: " + pingindex);
  var_41a4a181b6606b16 = player function_a7e757d42b550a6(pingindex);

  switch (var_41a4a181b6606b16) {
    case 22:
    case 23:
    case 28:
      lootid = player function_c4e0716fbd549e2d(pingindex);
      var_c08eeee95b85512a = isDefined(lootid) && function_3bc031ab2f635f8c(lootid) != "calloutmarkerpingitem";

      if(var_c08eeee95b85512a) {
        scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

        if(isxhashasset(scriptablename)) {
          utility::function_ee012c2dd711a8ce("self_pickedupitem", scriptablename, "death_or_disconnect");
        } else if(isDefined(scriptablename)) {
          assert(isstring(scriptablename) && scriptablename != "<dev string:x5ff>");
          waittill_any_2("death_or_disconnect", "self_pickedupitem_" + scriptablename);
        }
      } else {
        self waittill("death_or_disconnect");
      }

      break;
    case 24:
    case 25:
      if(getdvarint(@ "hash_6f618729986d661", 1) && utility::ismp() && issharedfuncdefined("ping", "calloutMarkerPing_watchItemTakenFromContainer")) {
        lootid = player function_c4e0716fbd549e2d(pingindex);
        [[getsharedfunc("ping", "calloutMarkerPing_watchItemTakenFromContainer")]](player, player.var_2fa5b49969def47, lootid);
      } else {
        self waittill("death_or_disconnect");
      }

      break;
    default:
      self waittill("death_or_disconnect");
      break;
  }

  calloutmarkerping_removecallout(pingindex);
}

function function_1efe712c746d3ca1(pingindex) {
  player = self;
  assertex(isPlayer(self), "<dev string:x48>" + "<dev string:x603>");
  self endon("predictiveCalloutClear_" + pingindex);
  _calloutmarkerping_predicted_log("Watch Player Enter Spectate | pingIndex: " + pingindex);
  player waittill("br_spectatorInitialized");
  calloutmarkerping_removecallout(pingindex);
}

function calloutmarkerping_watchscriptabledeath(pingindex, scriptableinstance) {
  assertex(isPlayer(self), "<dev string:x48>" + "<dev string:x640>");
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + pingindex);
  _calloutmarkerping_predicted_log("Watch Scriptable Death | pingIndex: " + pingindex);

  if(!isDefined(scriptableinstance)) {
    assertmsg("<dev string:x48>" + "<dev string:x679>");
  } else if(scriptableinstance.type == "equip_fulton_mp") {
    ent = scriptableinstance.entity;

    if(!isDefined(ent)) {
      assertmsg("<dev string:x48>" + "<dev string:x6df>");
      return;
    }

    ent waittill_any_2("death", "fulton_takeoff");
  } else {
    var_122cecc87707e886 = function_ce51e08dcc037220(scriptableinstance.origin, "undefined", "CalloutMarkerPing: " + ": scriptableInstance.entity.script_noteworthy is undefined");

    if(isDefined(scriptableinstance.entity) && isDefined(scriptableinstance.entity.script_noteworthy)) {
      var_f060782b4775f90e = scriptableinstance.entity.script_noteworthy;
    } else {
      var_f060782b4775f90e = var_122cecc87707e886;
    }

    var_825eb5c6acf63494 = function_ce51e08dcc037220(scriptableinstance.type, 1, "CalloutMarkerPing: " + ": scriptableInstance.type is invalid");
    level waittill_any_8("pickedupweapon_kill_callout_" + var_825eb5c6acf63494 + var_122cecc87707e886, "lootcache_opened_kill_callout" + var_122cecc87707e886, "dropbag_kill_callout_" + var_122cecc87707e886, "tablethide_kill_callout_" + var_122cecc87707e886, "carriable_kill_callout_" + var_122cecc87707e886, "buystation_kill_callout_" + var_122cecc87707e886, "redeploy_drone_kill_callout_" + var_122cecc87707e886, "forced_kill_callout_" + var_f060782b4775f90e);
  }

  _calloutmarkerping_predicted_log("Watch scriptable death ( removed ) | pingIndex: " + pingindex);
  calloutmarkerping_removecallout(pingindex);
}

function calloutmarkerping_onplayerdisconnect(player) {
  if(!isDefined(player)) {
    return;
  }

  player calloutmarkerping_removeallcalloutsforplayer();
}

function calloutmarkerping_removeallcalloutsforplayer() {
  player = self;

  if(isDefined(player)) {
    for(pingindex = 0; pingindex < 10; pingindex++) {
      isowner = player function_1e008bf9d31b2b01(pingindex);

      if(isowner) {
        player calloutmarkerping_removecallout(pingindex);
      }
    }
  }
}

function function_2824a97eea0ae1f2() {
  player = self;

  if(isDefined(player)) {
    assert(issharedfuncdefined("<dev string:x71c>", "<dev string:x724>"));
    playersquad = [[getsharedfunc("game", "getSquadmates")]](player.team, player.sessionsquadid, 1);
    player function_47990577bda08bb4(player, playersquad);
  }
}

function calloutmarkerping_removeallcalloutsforallplayers(var_884a98392ce1109b) {
  var_c502004b162c0807 = 0;

  foreach(player in level.players) {
    player calloutmarkerping_removeallcalloutsforplayer();

    if(istrue(var_884a98392ce1109b)) {
      var_c502004b162c0807++;

      if(var_c502004b162c0807 % 10 == 0) {
        waitframe();
      }
    }
  }
}

function calloutmarkerpingvo_calculatesounddebouncelength(pingtype, var_e64b7437e7151a62) {
  if(function_c648f0fd527e089a(pingtype)) {
    return (var_e64b7437e7151a62 + 500);
  }

  if(function_d3789a9a4be5df2e(pingtype)) {
    return (var_e64b7437e7151a62 + 500);
  }

  if(function_74ec310d8f99b6e2(pingtype)) {
    return (var_e64b7437e7151a62 + 500);
  }

  if(function_87df78670540e9b2(pingtype)) {
    return (var_e64b7437e7151a62 + 500);
  }

  switch (pingtype) {
    case 2:
      return (var_e64b7437e7151a62 + 500);
    case 6:
      return (var_e64b7437e7151a62 + 500);
    case 4:
      return (var_e64b7437e7151a62 + 500);
    case 5:
      return (var_e64b7437e7151a62 + 500);
    default:
      println("<dev string:x48>" + "<dev string:x735>");
      return (var_e64b7437e7151a62 + 500);
  }
}

function function_bb7fe8982d035c10(var_9090af2a5c319a58) {
  player = self;
  assert(isDefined(player.calloutmarkerpingvohandlerpool));
  assert(isstring(var_9090af2a5c319a58));

  if(!isDefined(player.calloutmarkerpingvohandlerpool[var_9090af2a5c319a58])) {
    return false;
  }

  return true;
}

function calloutmarkerpingvo_handleraddnewelement(pingtype, currtime, var_9090af2a5c319a58, var_e64b7437e7151a62) {
  player = self;
  assert(isDefined(player.calloutmarkerpingvohandlerpool));
  assert(isDefined(pingtype));
  assert(isDefined(currtime));
  assert(isstring(var_9090af2a5c319a58));
  assert(isDefined(var_e64b7437e7151a62));
  var_37f40cb76aeadd2a = player.calloutmarkerpingvohandlerpool.size;

  if(var_37f40cb76aeadd2a > 10) {
    return false;
  }

  sounddebouncelength = calloutmarkerpingvo_calculatesounddebouncelength(pingtype, var_e64b7437e7151a62);
  assert(isDefined(sounddebouncelength));
  var_a4e4c581c371283d = sounddebouncelength + currtime;
  assert(var_a4e4c581c371283d >= currtime);
  var_c8895c40ca12d15 = spawnStruct();
  var_c8895c40ca12d15.sounddebouncetimestamp = var_a4e4c581c371283d;
  var_c8895c40ca12d15.cancelled = 0;
  player.calloutmarkerpingvohandlerpool[var_9090af2a5c319a58] = var_c8895c40ca12d15;
  return true;
}

function calloutmarkerpingvo_canplaywithspamavoidance(pingtype, voalias, var_e64b7437e7151a62) {
  player = self;

  if(!isDefined(player) || !isPlayer(player)) {
    return 0;
  }

  if(istrue(level.var_5d4c8322d01b9c50)) {
    return 0;
  }

  if(istrue(player.var_5d4c8322d01b9c50) || getdvarint(@ "hash_28ffde533f721522", 0)) {
    return 0;
  }

  currtime = gettime();
  var_9090af2a5c319a58 = "pingType" + pingtype;
  assert(isstring(var_9090af2a5c319a58));
  var_c7704a4bc6945a9f = player function_bb7fe8982d035c10(var_9090af2a5c319a58);

  if(var_c7704a4bc6945a9f) {
    sounddebouncetimestamp = player.calloutmarkerpingvohandlerpool[var_9090af2a5c319a58].sounddebouncetimestamp;
    assert(isDefined(sounddebouncetimestamp));

    if(currtime >= sounddebouncetimestamp) {
      var_964d2b3a97d9acda = player calloutmarkerpingvo_handleraddnewelement(pingtype, currtime, var_9090af2a5c319a58, var_e64b7437e7151a62);
      return istrue(var_964d2b3a97d9acda);
    }

    if(voalias == #"ping_response_cancel" && player.calloutmarkerpingvohandlerpool[var_9090af2a5c319a58].cancelled == 0) {
      player.calloutmarkerpingvohandlerpool[var_9090af2a5c319a58].cancelled = 1;
      return 1;
    }

    return 0;
  }

  if(voalias == #"ping_response_cancel") {
    return 0;
  }

  var_964d2b3a97d9acda = player calloutmarkerpingvo_handleraddnewelement(pingtype, currtime, var_9090af2a5c319a58, var_e64b7437e7151a62);
  return istrue(var_964d2b3a97d9acda);
}

function calloutmarkerpingvo_debouncegarbagecollector() {
  level endon("game_ended");
  assert(-1);

  while(true) {
    wait 10;
    currenttime = gettime();

    for(currentplayerindex = 0; currentplayerindex < level.players.size; currentplayerindex++) {
      player = level.players[currentplayerindex];

      if(!isDefined(player) || !isDefined(player.calloutmarkerpingvohandlerpool)) {
        continue;
      }

      foreach(key, valuestruct in player.calloutmarkerpingvohandlerpool) {
        assert(isstring(key));
        assert(isDefined(valuestruct));
        assert(isDefined(valuestruct.sounddebouncetimestamp));

        if(currenttime > valuestruct.sounddebouncetimestamp) {
          player.calloutmarkerpingvohandlerpool[key] = undefined;
        }
      }
    }
  }
}

function calloutmarkerpingvo_getmaxsoundaliaslength(var_c197335aad9f5e31, alias2d, var_c1934d5aad9ba188, alias3d) {
  var_196ffc81c8206c2a = 0;

  if(var_c197335aad9f5e31) {
    soundlen = lookupsoundlength(alias2d, 1);

    if(soundlen > var_196ffc81c8206c2a) {
      var_196ffc81c8206c2a = soundlen;
    }
  }

  if(var_c1934d5aad9ba188) {
    soundlen = lookupsoundlength(alias3d, 1);

    if(soundlen > var_196ffc81c8206c2a) {
      var_196ffc81c8206c2a = soundlen;
    }
  }

  return var_196ffc81c8206c2a;
}

function calloutmarkerping_playteamsoundfx(alias, pingindex) {
  player = self;

  if(!isDefined(player) || !isPlayer(player) || !isDefined(alias)) {
    return;
  }

  if(!soundexists(alias)) {
    assertmsg("<dev string:x48>" + "<dev string:x761>" + alias);
  }

  pingent = undefined;
  pingorigin = undefined;

  if(isDefined(pingindex)) {
    pingent = player calloutmarkerping_getEnt(pingindex);
    pingorigin = player calloutmarkerping_getorigin(pingindex);
  }

  assert(issharedfuncdefined("<dev string:x71c>", "<dev string:x724>"));
  playersquad = [[getsharedfunc("game", "getSquadmates")]](player.team, player.sessionsquadid, 1);

  foreach(teammate in playersquad) {
    if(player != teammate) {
      if(istrue(player.gulagarena) && !istrue(teammate.gulagarena) || !istrue(player.gulagarena) && istrue(teammate.gulagarena)) {
        continue;
      }

      var_5c0879e9dea157af = teammate function_4076aa2e6c3de4c8();

      if(var_5c0879e9dea157af) {
        continue;
      }
    }

    if(player isspectatingplayer()) {
      var_dd7368df13bc1a31 = teammate;
    } else if(isDefined(pingent)) {
      var_dd7368df13bc1a31 = spawn("script_origin", pingent.origin);
      var_dd7368df13bc1a31.istempsfxent = 1;
    } else if(isDefined(pingorigin)) {
      var_dd7368df13bc1a31 = spawn("script_origin", pingorigin);
      var_dd7368df13bc1a31.istempsfxent = 1;
    } else {
      var_dd7368df13bc1a31 = player;
    }

    var_dd7368df13bc1a31 playsoundtoplayer(alias, teammate);

    if(isDefined(var_dd7368df13bc1a31.istempsfxent)) {
      var_dd7368df13bc1a31 delete();
    }
  }
}

function calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias2d(var_5bb586139a747c1c) {
  player = self;

  if(!isDefined(player.operatorcustomization) || !isDefined(player.operatorcustomization.voice)) {
    assertmsg("<dev string:x48>" + "<dev string:x789>");
    return;
  }

  alias2d = "dx_mpp_" + player.operatorcustomization.voice + "_" + var_5bb586139a747c1c;
  return alias2d;
}

function calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_5bb586139a747c1c) {
  player = self;

  if(!isDefined(player.operatorcustomization) || !isDefined(player.operatorcustomization.voice)) {
    assertmsg("<dev string:x48>" + "<dev string:x789>");
    return;
  }

  alias3d = "dx_mpb_" + player.operatorcustomization.voice + "_" + var_5bb586139a747c1c;
  return alias3d;
}

function calloutmarkerpingvo_play(voalias, pingtype, targetent) {
  voowner = self;

  if(!isDefined(voowner) || !isPlayer(voowner)) {
    return;
  }

  if(!isDefined(pingtype)) {
    return;
  }

  if(!isDefined(voalias) || voalias == "" || voalias == #"") {
    assertmsg("<dev string:x48>" + "<dev string:x7b6>" + pingtype);
    return;
  }

  var_4f632c1568af9fc0 = level.bcinfo["asset"][getxhash(voalias)];
  var_196ffc81c8206c2a = 2000;
  canplayvo = voowner calloutmarkerpingvo_canplaywithspamavoidance(pingtype, voalias, var_196ffc81c8206c2a);

  if(istrue(canplayvo)) {
    logprint("calloutmarkerping::calloutMarkerPingVO_play - PlaySoundEvent()");
    logprint("self = " + voowner.name);
    logprint("sessionstate = " + voowner.sessionstate);
    logprint("targetEnt= " + isDefined(targetent));

    if(isDefined(targetent)) {
      logprint("tEntclassname = " + targetent.classname);
      logprint("tEntOrigin= " + targetent.origin);

      if(isent(targetent) && isPlayer(targetent)) {
        logprint("tEntSessionstate = " + targetent.sessionstate);
      }
    }

    if(isDefined(var_4f632c1568af9fc0)) {
      if(isDefined(targetent) && isent(targetent)) {
        voowner playsoundevent(var_4f632c1568af9fc0, targetent);
      } else {
        voowner playsoundevent(var_4f632c1568af9fc0);
      }
    }

    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_operator_vo", {
      #target: targetent, #speaker: voowner, #sound_event: var_4f632c1568af9fc0, #sound_type: voalias, #script_func_name: "calloutMarkerPingVO_play"});
  }
}

function calloutmarkerping_navigationcancelproximity(pingindex) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + pingindex);
  self notify("calloutMarkerPing_navigationCancelProximity");
  self endon("calloutMarkerPing_navigationCancelProximity");
  var_220a4dc6346cbce8 = getdvarfloat(@ "hash_7c74d4814e0665d5", 120);
  var_c1c5f124f3099349 = getdvarint(@ "hash_37dfb2340c8f1ded", 10);
  assertex(var_220a4dc6346cbce8 > var_c1c5f124f3099349, "<dev string:x48>" + "<dev string:x7ee>");
  wait var_c1c5f124f3099349;

  if(!self calloutmarkerping_getactive(pingindex)) {
    assertmsg("<dev string:x48>" + "<dev string:x84d>");
    return;
  }

  var_a0c7efbc36968a9d = self calloutmarkerping_getorigin(pingindex);
  var_24e75a7f4ff07f6a = getdvarint(@ "hash_aa5168815ed6f2f9", 47089);
  canceltype = getdvarint(@ "hash_93e80752445801c0", 1);
  var_8d61d476bcb70d31 = getdvarint(@ "hash_f53af4867ef2f684", 1);

  while(true) {
    assert(isDefined(self) && isDefined(self.origin) && isDefined(var_a0c7efbc36968a9d));

    if(canceltype == 1) {
      distancesq = distancesquared(self.origin, var_a0c7efbc36968a9d);
    } else {
      distancesq = var_24e75a7f4ff07f6a;
      playersquad = [[getsharedfunc("game", "getFriendlyPlayers")]](self.team, 1);

      foreach(teammate in playersquad) {
        teammatedistancesq = distancesquared(teammate.origin, var_a0c7efbc36968a9d);

        if(teammatedistancesq < distancesq) {
          distancesq = teammatedistancesq;
        }
      }
    }

    if(distancesq < var_24e75a7f4ff07f6a) {
      calloutmarkerping_playteamsoundfx("uin_ping_cancel", pingindex);
      calloutmarkerping_removecallout(pingindex);
      return;
    }

    wait var_8d61d476bcb70d31;
  }
}

function calloutmarkerpingvo_playpredictivepingcleared(pingindex, pingtype, var_dfb9f3c233e2b8f3) {
  player = self;
  player notify("calloutMarkerPingVO_playPredictivePingCleared");
  player endon("calloutMarkerPingVO_playPredictivePingCleared");
  player calloutmarkerping_playteamsoundfx("uin_ping_cancel", pingindex);
  wait getdvarfloat(@ "hash_7206cb95b7dfb4f0", 0.5);

  if(isDefined(player)) {
    if(isPlayer(var_dfb9f3c233e2b8f3)) {
      var_dfb9f3c233e2b8f3 calloutmarkerpingvo_play(#"ping_response_cancel", pingtype);
      return;
    }

    player calloutmarkerpingvo_play(#"ping_response_cancel", pingtype);
  }
}

function calloutmarkerpingvo_playpredictivepingacknowledgedcancel(pingindex, var_dfb9f3c233e2b8f3) {
  pingowner = self;
  pingtype = pingowner calloutmarkerping_gettype(pingindex);
  pingowner calloutmarkerpingvo_playpredictivepingcleared(pingindex, pingtype, var_dfb9f3c233e2b8f3);
}

function calloutmarkerpingvo_playpredictivepingacknowledged(pingindex, var_dfb9f3c233e2b8f3) {
  pingowner = self;
  pingowner notify("calloutMarkerPingVO_playPredictivePingAcknowledged");
  pingowner endon("calloutMarkerPingVO_playPredictivePingAcknowledged");
  pingtype = pingowner calloutmarkerping_gettype(pingindex);

  if(function_c648f0fd527e089a(pingtype)) {
    var_c1074ab6cac2169f = pingowner calloutmarkerping_getEnt(pingindex);
    voalias = pingowner calloutmarkerpingvo_getaffirmaliasstringloot(pingindex, var_c1074ab6cac2169f, var_dfb9f3c233e2b8f3);
  } else if(function_d3789a9a4be5df2e(pingtype)) {
    ent = pingowner calloutmarkerping_getEnt(pingindex);

    if(isDefined(ent) && isent(ent)) {
      if(isDefined(ent.subcategory) && ent.subcategory == "elimTarget") {
        voalias = #"ping_elimtarget_confirm";
      } else if(_calloutmarkerping_isenemy(ent, pingowner)) {
        voalias = #"ping_enemy_confirm";
      } else if(issubstr(ent.model, "oxygen")) {
        voalias = #"ping_loot_confirm_oxygentank";
      } else if(issubstr(ent.model, "gas_cutter")) {
        voalias = #"ping_loot_confirm_buzzsaw";
      } else if(istrue(ent.var_4a4265af0a6f92e9)) {
        voalias = #"ping_exfil_heli_confirm";
      } else if(pingtype == 6) {
        voalias = pingowner function_9bb1120b45cfa775(pingindex);
      }
    }

    if(!isDefined(voalias)) {
      voalias = #"ping_response_affirm";
    }
  } else if(function_74ec310d8f99b6e2(pingtype)) {
    voalias = #"ping_response_copy";
  } else if(function_87df78670540e9b2(pingtype)) {
    voalias = #"ping_response_affirm";
  } else {
    switch (pingtype) {
      case 2:
        if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && isDefined(pingowner.br_infil_type)) {
          voalias = #"ping_location_landing_confirm";
        } else {
          voalias = #"ping_response_affirm";
        }

        break;
      case 4:
        voalias = pingowner function_befa2cbd9d478179(pingindex);
        break;
      case 6:
        voalias = pingowner function_9bb1120b45cfa775(pingindex);
        break;
      case 5:
        voalias = #"ping_loot_confirm_generic";
        break;
      default:
        voalias = #"ping_response_affirm";
        assertmsg("<dev string:x48>" + "<dev string:x89c>");
        break;
    }
  }

  wait getdvarfloat(@ "hash_1d83539430a13314", 0.5);

  if(isPlayer(var_dfb9f3c233e2b8f3)) {
    var_dfb9f3c233e2b8f3 calloutmarkerpingvo_play(voalias, pingtype);
    return;
  }

  if(isDefined(pingowner)) {
    pingowner calloutmarkerpingvo_play(voalias, pingtype);
  }
}

function calloutmarkerpingvo_playpredictivepingadded(pingindex) {
  player = self;
  player notify("calloutMarkerPingVO_playPredictivePingAdded");
  player endon("calloutMarkerPingVO_playPredictivePingAdded");
  player endon("calloutMarkerPingVO_playPredictivePingCleared");
  player endon("predictiveCalloutClear_" + pingindex);
  wait getdvarfloat(@ "hash_490c0274864a18be", 0);

  if(isDefined(player)) {
    player calloutmarkerpingvo_createcalloutbattlechatter(pingindex);
  }
}

function calloutmarkerping_removevehiclecalloutonspecialconditions(pingindex, calloutvehicleentity) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + pingindex);
  assert(isPlayer(self));
  assert(self calloutmarkerping_gettype(pingindex) == 6);
  assert(isent(calloutvehicleentity));
  assert(issharedfuncdefined("<dev string:x71c>", "<dev string:x8ba>"));
  var_7daf7f78e6ef64b7 = calloutvehicleentity getentitynumber();
  var_ff305cfc399bb107 = "forced_kill_callout_" + var_7daf7f78e6ef64b7;
  tick = 0.25;
  var_4ced3a2a73d90ee6 = 0;
  pingownerteam = self.team;
  var_87ba069d66691559 = _calloutmarkerping_isvehicleoccupiedbyenemy(calloutvehicleentity, pingownerteam);

  while(true) {
    var_50dfdbdc6da80233 = _calloutmarkerping_shouldremovecalloutifwholesquadinvehicle(pingindex, calloutvehicleentity, pingownerteam);

    if(var_50dfdbdc6da80233) {
      calloutmarkerping_removecallout(pingindex);
      return;
    }

    isvehicleoccupiedbyenemy = _calloutmarkerping_isvehicleoccupiedbyenemy(calloutvehicleentity, pingownerteam);

    if(isvehicleoccupiedbyenemy) {
      if(!var_87ba069d66691559) {
        calloutmarkerping_removecallout(pingindex);
      }

      var_4ced3a2a73d90ee6 += tick;

      if(var_4ced3a2a73d90ee6 >= 3) {
        vehicleowner = calloutvehicleentity getvehicleowner();

        if(isDefined(vehicleowner)) {
          thread calloutmarkerping_enemytodangerdecaycreate(pingindex, vehicleowner);
          return;
        }

        calloutmarkerping_removecallout(pingindex);
        return;
      }
    }

    message = function_3462378d38b69cc8(tick, var_ff305cfc399bb107);

    if(message == var_ff305cfc399bb107) {
      calloutmarkerping_removecallout(pingindex);
      return;
    }
  }
}

function function_3462378d38b69cc8(timeout, string1) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function _calloutmarkerping_shouldremovecalloutifwholesquadinvehicle(pingindex, calloutvehicleentity, pingownerteam) {
  pingowner = self;
  var_d6eedd657b73ecf1 = 0;
  playersquad = [[getsharedfunc("game", "getSquadmates")]](pingownerteam, pingowner.sessionsquadid, 1);

  foreach(player in playersquad) {
    if(player scripts\cp_mp\utility\player_utility::isinvehicle() && player.vehicle == calloutvehicleentity) {
      pingowner calloutmarkerping_hide(pingindex, player);
      var_d6eedd657b73ecf1++;
    }
  }

  if(var_d6eedd657b73ecf1 == playersquad.size) {
    return true;
  }

  return false;
}

function _calloutmarkerping_isvehicleoccupiedbyenemy(calloutvehicleentity, pingownerteam) {
  var_37d16028d16d8807 = isDefined(calloutvehicleentity.ownerteam) && calloutvehicleentity.ownerteam != pingownerteam || isDefined(calloutvehicleentity.vehicleteam) && calloutvehicleentity.vehicleteam != pingownerteam;
  isvehicleoccupied = isDefined(calloutvehicleentity.isempty) && calloutvehicleentity.isempty == 0 || isDefined(calloutvehicleentity.vehicleteam);

  if(isvehicleoccupied && var_37d16028d16d8807) {
    return true;
  }

  return false;
}

function function_6a9d273f570c2d97(pingindex, var_3fbb10d80249baac, cancelreason, var_f713679ecb32c725) {
  pingowner = self;

  if(!isDefined(pingowner.var_7ab947f079adf78a)) {
    return;
  }

  var_8c75532deab80ef2 = pingowner.var_7ab947f079adf78a[pingindex];

  if(!isDefined(var_8c75532deab80ef2) || !isDefined(var_8c75532deab80ef2.pingtype)) {
    return;
  }

  pingtype = var_8c75532deab80ef2.pingtype;

  if(!isDefined(pingowner.var_e42370a2eda517e9) || !isDefined(pingowner.var_e42370a2eda517e9[pingtype])) {
    return;
  }

  var_e42370a2eda517e9 = pingowner.var_e42370a2eda517e9[pingtype];

  if(var_f713679ecb32c725) {
    var_8c75532deab80ef2.var_f20158543e075304++;
  }

  eventparams = [];
  eventparams[eventparams.size] = "ping_id";
  eventparams[eventparams.size] = var_e42370a2eda517e9;
  eventparams[eventparams.size] = "ping_type";
  eventparams[eventparams.size] = pingtype;
  eventparams[eventparams.size] = "tac_map_active";
  eventparams[eventparams.size] = istrue(pingowner istacmapactive());
  eventparams[eventparams.size] = "canceled";
  eventparams[eventparams.size] = var_3fbb10d80249baac;
  eventparams[eventparams.size] = "cancel_reason";
  eventparams[eventparams.size] = cancelreason;
  eventparams[eventparams.size] = "player_x";
  eventparams[eventparams.size] = pingowner.origin[0];
  eventparams[eventparams.size] = "player_y";
  eventparams[eventparams.size] = pingowner.origin[1];
  eventparams[eventparams.size] = "player_z";
  eventparams[eventparams.size] = pingowner.origin[2];
  pingorigin = var_8c75532deab80ef2.pingorigin;

  if(isDefined(pingorigin)) {
    eventparams[eventparams.size] = "ping_x";
    eventparams[eventparams.size] = pingorigin[0];
    eventparams[eventparams.size] = "ping_y";
    eventparams[eventparams.size] = pingorigin[1];
    eventparams[eventparams.size] = "ping_z";
    eventparams[eventparams.size] = pingorigin[2];
  } else {
    eventparams[eventparams.size] = "ping_x";
    eventparams[eventparams.size] = 0;
    eventparams[eventparams.size] = "ping_y";
    eventparams[eventparams.size] = 0;
    eventparams[eventparams.size] = "ping_z";
    eventparams[eventparams.size] = 0;
  }

  eventparams[eventparams.size] = "acknowledged";
  eventparams[eventparams.size] = var_f713679ecb32c725;
  eventparams[eventparams.size] = "acknowledged_count";
  eventparams[eventparams.size] = var_8c75532deab80ef2.var_f20158543e075304;
  pingowner dlog_recordplayerevent("dlog_event_br_ping_usage", eventparams);
}

function function_a74e2d6a089bd337(pingindex) {
  pingowner = self;

  if(!isDefined(pingowner.var_7ab947f079adf78a)) {
    pingowner.var_7ab947f079adf78a = [];
  }

  var_8c75532deab80ef2 = pingowner.var_7ab947f079adf78a[pingindex];

  if(!isDefined(var_8c75532deab80ef2)) {
    pingowner.var_7ab947f079adf78a[pingindex] = spawnStruct();
    var_8c75532deab80ef2 = pingowner.var_7ab947f079adf78a[pingindex];
    var_8c75532deab80ef2.var_f20158543e075304 = 0;
    var_8c75532deab80ef2.pingtype = pingowner calloutmarkerping_gettype(pingindex);
    var_8c75532deab80ef2.pingorigin = pingowner calloutmarkerping_getorigin(pingindex);
  }

  if(!isDefined(pingowner.var_e42370a2eda517e9)) {
    pingowner.var_e42370a2eda517e9 = [];
  }

  pingtype = var_8c75532deab80ef2.pingtype;

  if(!isDefined(pingowner.var_e42370a2eda517e9[pingtype])) {
    pingowner.var_e42370a2eda517e9[pingtype] = 1;
  } else {
    pingowner.var_e42370a2eda517e9[pingtype]++;
  }

  pingowner function_6a9d273f570c2d97(pingindex, 0, "", 0);
}

function function_a366e9660606bff8() {
  pingowner = self;

  if(isDefined(pingowner)) {
    for(pingindex = 0; pingindex < 10; pingindex++) {
      isowner = pingowner function_1e008bf9d31b2b01(pingindex);

      if(isowner && pingowner calloutmarkerping_getactive(pingindex)) {
        pingowner function_6a9d273f570c2d97(pingindex, 1, "clear_all", 0);
      }
    }
  }
}

function function_84d886d05e080f81() {
  player = self;

  if(isDefined(player)) {
    assert(issharedfuncdefined("<dev string:x71c>", "<dev string:x724>"));
    playersquad = [[getsharedfunc("game", "getSquadmates")]](player.team, player.sessionsquadid, 1);

    foreach(pingowner in playersquad) {
      if(pingowner != player) {
        for(pingindex = 0; pingindex < 10; pingindex++) {
          isowner = pingowner function_1e008bf9d31b2b01(pingindex);

          if(isowner && pingowner calloutmarkerping_getactive(pingindex)) {
            player function_6a9d273f570c2d97(pingindex, 1, "clear_squadmates", 0);
          }
        }
      }
    }
  }
}

function function_317d089ea4ed0a21(pingtype, reason) {
  pingowner = self;
  eventparams = [];
  eventparams[eventparams.size] = "ping_id";
  eventparams[eventparams.size] = pingowner.var_3a9aaf3e5a5c0b5[pingtype];
  eventparams[eventparams.size] = "ping_type";
  eventparams[eventparams.size] = pingtype;
  eventparams[eventparams.size] = "tac_map_active";
  eventparams[eventparams.size] = istrue(pingowner istacmapactive());
  eventparams[eventparams.size] = "canceled";
  eventparams[eventparams.size] = 1;
  eventparams[eventparams.size] = "cancel_reason";
  eventparams[eventparams.size] = reason;
  eventparams[eventparams.size] = "player_x";
  eventparams[eventparams.size] = pingowner.origin[0];
  eventparams[eventparams.size] = "player_y";
  eventparams[eventparams.size] = pingowner.origin[1];
  eventparams[eventparams.size] = "player_z";
  eventparams[eventparams.size] = pingowner.origin[2];
  eventparams[eventparams.size] = "ping_x";
  eventparams[eventparams.size] = 0;
  eventparams[eventparams.size] = "ping_y";
  eventparams[eventparams.size] = 0;
  eventparams[eventparams.size] = "ping_z";
  eventparams[eventparams.size] = 0;
  pingowner dlog_recordplayerevent("dlog_event_br_ping_usage", eventparams);
}

function function_1e008bf9d31b2b01(pingindex) {
  player = self;
  clientnum = player getentitynumber();
  owner = player function_705c264a572c0c59(pingindex);

  if(clientnum == owner) {
    return true;
  }

  return false;
}

function private function_49dc8767adf81886(pingindex, pingtype, issilent) {
  assert(pingindex < 10);
  assert(isDefined(pingtype));
  pingowner = self;
  pingowner function_6a9d273f570c2d97(pingindex, 1, "clear_single", 0);
  function_ec3fedcb7195cfd7(pingowner, pingindex);
  pingowner notify("predictiveCalloutClear_" + pingindex);

  if(!issilent) {
    pingowner thread calloutmarkerpingvo_playpredictivepingcleared(undefined, pingtype);
  }
}

function private function_45be7f9c916948b6(pingindex, var_60fdfb1cfd734d00) {
  assert(pingindex < 10);
  pingowner = self;
  assert(pingowner function_1e008bf9d31b2b01(pingindex));
  assert(isPlayer(var_60fdfb1cfd734d00));
  pingowner function_6a9d273f570c2d97(pingindex, 0, "", 1);
  _calloutmarkerping_predicted_log("Refreshing ping timeout. Ping: " + pingindex + " Client: " + pingowner getentitynumber());
  pingowner thread _calloutmarkerping_predicted_timeout(pingindex);
  pingowner thread calloutmarkerpingvo_playpredictivepingacknowledged(pingindex, var_60fdfb1cfd734d00);
  target = pingowner calloutmarkerping_getEnt(pingindex);

  if(isDefined(target)) {
    targetstruct = spawnStruct();
    targetstruct.target = target;
    pingowner callback::callback("on_tacmap_ping_scriptable_or_ent", targetstruct);
  }
}

function private function_85bd27e859eec16c(pingindex, var_60fdfb1cfd734d00) {
  assert(pingindex < 10);
  pingowner = self;
  assert(pingowner function_1e008bf9d31b2b01(pingindex));
  assert(isPlayer(var_60fdfb1cfd734d00));
  pingowner thread calloutmarkerpingvo_playpredictivepingacknowledgedcancel(pingindex, var_60fdfb1cfd734d00);
}

function private function_86767e1fccad74f1() {
  if(!isDefined(level.var_15fafd55bbed3780)) {
    level.var_15fafd55bbed3780 = getdvarint(@ "hash_a06ce354e4b4f9d6", 0);
  }

  return level.var_15fafd55bbed3780;
}

function private function_2a664ee5c40e868c(pingindex) {
  assert(pingindex < 10);
  pingowner = self;
  assert(pingowner function_1e008bf9d31b2b01(pingindex));

  if(issharedfuncdefined("ping", "calloutMarkerPing_markerAdded")) {
    [[getsharedfunc("ping", "calloutMarkerPing_markerAdded")]](pingowner, pingindex);
  }

  if(function_f956b46f8e151d30(pingowner, pingindex)) {
    return;
  }

  pingowner function_a74e2d6a089bd337(pingindex);
  function_caadd21a226bf96(pingowner, pingindex);
  pingowner thread _calloutmarkerping_predicted_timeout(pingindex);
  pingowner _calloutmarkerping_checkforbuybackrequest(pingindex);
  pingowner thread calloutmarkerpingvo_playpredictivepingadded(pingindex);
  pingowner _calloutmarkerping_onpingchallenge(pingindex);

  if(function_86767e1fccad74f1()) {
    iprintlnbold("Ping of type " + pingowner calloutmarkerping_gettype(pingindex) + " has been added.");
  }

  if(pingindex == 4) {
    objindex = self calloutmarkerping_getgscobjectiveindex(pingindex);

    if(objindex != -1) {
      objective_setplayintro(objindex, 0);
    }
  }
}

function function_5991bc039b1244ec(player) {
  player calloutmarkerping_removeallcalloutsforplayer();
}

function private function_f9a23942c0cd9461(pingowner, pingtype) {
  if(!issharedfuncdefined("teamAssim", "isEnabled") || !issharedfuncdefined("teamAssim", "resolveAssimRequest") || !issharedfuncdefined("teamAssim", "requestNearbyTeamChange") || !issharedfuncdefined("teamAssim", "isWaitingForAssimResponse")) {
    return;
  }

  if(![[getsharedfunc("teamAssim", "isEnabled")]]()) {
    return;
  }

  if(function_476d89b12dfe07a1(pingtype)) {
    [[getsharedfunc("teamAssim", "requestNearbyTeamChange")]](pingowner, pingtype == 13);
  }

  if(function_caef0e7e004e5475(pingtype)) {
    [[getsharedfunc("teamAssim", "requestLeaveTeam")]](pingowner);
  }
}

function private function_5d665c2bc1e250fa(pingindex) {
  assert(pingindex < 10);
  pingowner = self;
  assert(pingowner function_1e008bf9d31b2b01(pingindex));
  _calloutmarkerping_predicted_log("Refreshing Timeout | pingIndex: " + pingindex + " | owner: " + pingowner getentitynumber());
  pingowner thread _calloutmarkerping_predicted_timeout(pingindex);
  pingowner calloutmarkerping_playteamsoundfx("uin_ping_enemy", pingindex);
}

function private function_99811a65af9a351() {
  pingowner = self;
  isanypingactive = _calloutmarkerping_predicted_isanypingactive();

  if(isanypingactive) {
    pingowner function_a366e9660606bff8();
    pingowner calloutmarkerping_playteamsoundfx("uin_ping_cancel");
    function_8c4b1d9591dc12ab(pingowner);
  }

  pingowner calloutmarkerping_removeallcalloutsforplayer();
}

function private function_8a6d3325d2046682() {
  pingowner = self;
  pingowner function_84d886d05e080f81();
  pingowner function_2824a97eea0ae1f2();
}

function function_7a87e3b6a7645c79(var_9b55b6a174c841ef) {
  bitsused = 32;

  if(bitsused > 32) {
    return undefined;
  }

  pingdata = spawnStruct();
  lootidmask = 67108864 - 1;
  pingdata.lootid = var_9b55b6a174c841ef &lootidmask;
  var_9b55b6a174c841ef >>= 26;
  var_80d584b74f2c0886 = 64 - 1;
  pingdata.var_41a4a181b6606b16 = var_9b55b6a174c841ef &var_80d584b74f2c0886;
  return pingdata;
}

function private function_5418b333a8e1cf76(var_9b55b6a174c841ef) {
  if(getdvarint(@ "hash_43a226ede0c4e131", 0)) {
    return;
  }

  player = self;
  pingdata = function_7a87e3b6a7645c79(var_9b55b6a174c841ef);
  assert(isDefined(pingdata));
  var_6b10a57d86c5874a = player function_1e8231aee9e6076b(pingdata.var_41a4a181b6606b16);

  if(isDefined(var_6b10a57d86c5874a)) {
    var_6c1b950caed8e9a3 = function_6a4a22b07cd4a96f(var_6b10a57d86c5874a.object, player.team, pingdata.lootid);
  }

  if(isDefined(var_6c1b950caed8e9a3)) {
    playernum = player getentitynumber();
    var_e2ec7af41ccc1c1c = player function_705c264a572c0c59(var_6c1b950caed8e9a3);
    var_fd1c5decdf4eed9a = playernum != var_e2ec7af41ccc1c1c;
  }

  if(isDefined(var_6c1b950caed8e9a3) && var_fd1c5decdf4eed9a) {
    var_90bb4d49be1ad85c = getentbynum(var_e2ec7af41ccc1c1c);

    if(var_90bb4d49be1ad85c function_9482e9c50b5fe82(player, var_6c1b950caed8e9a3)) {
      var_90bb4d49be1ad85c function_69aa7fcdcfff4e0a(player, var_6c1b950caed8e9a3, 0);
      var_90bb4d49be1ad85c function_85bd27e859eec16c(var_6c1b950caed8e9a3, player);
    } else {
      var_90bb4d49be1ad85c function_69aa7fcdcfff4e0a(player, var_6c1b950caed8e9a3, 1);
      var_90bb4d49be1ad85c function_45be7f9c916948b6(var_6c1b950caed8e9a3, player);
    }

    return;
  }

  pingindex = player thread scripts\cp_mp\calloutmarkerping::function_1ced737a22161a49(pingdata.var_41a4a181b6606b16, pingdata.lootid);

  if(isDefined(pingindex)) {
    player function_a74e2d6a089bd337(pingindex);
  }
}

function function_6b9641d0060c3a2c(target) {
  target.var_a49938597b3587f0 = [];
  target.var_8c7acce8a4d9c2c = [];
}

function function_ffd6eed18c767472(oldtarget, newtarget, var_7b11fc99302d2789, var_7b24d2e62b387965, var_c313310ef3c37a7e) {
  assert(isDefined(oldtarget) && isDefined(newtarget) && isDefined(var_7b11fc99302d2789));

  if(!isDefined(var_c313310ef3c37a7e)) {
    var_c313310ef3c37a7e = (0, 0, 0);
  }

  index = undefined;

  if(function_c648f0fd527e089a(var_7b11fc99302d2789)) {
    index = newtarget.index;
  } else if(function_d3789a9a4be5df2e(var_7b11fc99302d2789)) {
    index = newtarget getentitynumber();
  } else if(var_7b11fc99302d2789 == 4) {
    index = newtarget;
  }

  assert(isDefined(index));
  oldtarget.var_ad4f035f68ad85ad = var_c313310ef3c37a7e;
  oldtarget.var_b71b168e8ed463ce = index;
  oldtarget.var_a7aa780bf65803d2 = var_7b24d2e62b387965;

  if(isDefined(oldtarget.var_8c7acce8a4d9c2c)) {
    foreach(entnumber, pingindex in oldtarget.var_8c7acce8a4d9c2c) {
      pingowner = undefined;

      if(isDefined(oldtarget.var_a49938597b3587f0)) {
        pingowner = oldtarget.var_a49938597b3587f0[entnumber];
      }

      if(!isDefined(pingowner) || pingowner calloutmarkerping_gettype(pingindex) == 1) {
        continue;
      }

      function_49cdea45f60452c8(pingowner, pingindex, oldtarget);
    }
  }
}

function function_c068efdf0abd5258(target) {
  target.var_ad4f035f68ad85ad = undefined;
  target.var_b71b168e8ed463ce = undefined;
  target.var_a7aa780bf65803d2 = undefined;
}

function function_1062f2af5c7d843e(scriptablename, weaponobj) {
  player = self;
  scriptablename = tolower(scriptablename);
  var_3ef0fdcee94cadff = "";

  if(isDefined(weaponobj)) {
    if(issubstr(scriptablename, "_me_riotshield")) {
      var_3ef0fdcee94cadff = #"ping_inv_drop_weapon_riotshield";
    } else if(issubstr(scriptablename, "weapon_me") || issubstr(scriptablename, "_me_")) {
      var_3ef0fdcee94cadff = #"ping_inv_drop_weapon_melee";
    } else if(issubstr(scriptablename, "weapon_dm") || issubstr(scriptablename, "_dm_")) {
      var_3ef0fdcee94cadff = #"ping_inv_drop_weapon_dmr";
    } else {
      switch (weaponclass(weaponobj.basename)) {
        case #"hash_8cdaf2e4ecfe5b51":
          var_3ef0fdcee94cadff = #"ping_inv_drop_weapon_assaultrifle";
          break;
        case #"hash_900cb96c552c5e8e":
          var_3ef0fdcee94cadff = #"ping_inv_drop_weapon_smg";
          break;
        case #"hash_690c0d6a821b42e":
          var_3ef0fdcee94cadff = #"ping_inv_drop_weapon_shotgun";
          break;
        case #"hash_fa24dff6bd60a12d":
          var_3ef0fdcee94cadff = #"ping_inv_drop_weapon_lmg";
          break;
        case #"hash_6191aaef9f922f96":
          var_3ef0fdcee94cadff = #"ping_inv_drop_weapon_sniper";
          break;
        case #"hash_61e969dacaaf9881":
          var_3ef0fdcee94cadff = #"ping_inv_drop_weapon_launcher";
          break;
        case #"hash_719417cb1de832b6":
          var_3ef0fdcee94cadff = #"ping_inv_drop_weapon_pistol";
          break;
      }
    }
  }

  if(var_3ef0fdcee94cadff == "") {
    switch (scriptablename) {
      case #"hash_e7803d9decd089c2":
        var_3ef0fdcee94cadff = #"ping_inv_drop_ammo_smallcal";
        break;
      case #"hash_672892a4af1e94cc":
        var_3ef0fdcee94cadff = #"ping_inv_drop_ammo_midcaliber";
        break;
      case #"hash_f1734c15f85881ca":
        var_3ef0fdcee94cadff = #"ping_inv_drop_ammo_highcal";
        break;
      case #"hash_acd2c79dce3b9907":
        var_3ef0fdcee94cadff = #"ping_inv_drop_ammo_shotgun";
        break;
      case #"hash_d5db533de9b14785":
        var_3ef0fdcee94cadff = #"ping_inv_drop_ammo_launcher";
        break;
      case #"hash_249e26ddc4c6db40":
        var_3ef0fdcee94cadff = #"ping_inv_drop_iodinepills";
        break;
      case #"hash_4acc5cb6e8055bbd":
      case #"hash_1ca613bc31b3e214":
      case #"hash_51fb8cf9a443524f":
      case #"hash_e5931853d3884ea6":
        var_3ef0fdcee94cadff = #"ping_inv_drop_player_dogtag";
        break;
      case #"hash_12214dbd291d3d03":
      case #"hash_1892477817b6077b":
      case #"hash_736e4b57f09fd01f":
      case #"hash_64cb76a790aa0ddf":
      case #"hash_9ad472e96ffa7649":
      case #"hash_b9494439da2d7ca5":
      case #"hash_c305b5221d5d1429":
      case #"hash_c740a7ba6ff37781":
      case #"hash_cb5f2338e9122fd6":
      case #"hash_d4b690624f898e02":
      case #"hash_e6613df7bf5f6ebe":
      case #"hash_e8e7b62030261269":
        var_3ef0fdcee94cadff = #"ping_inv_drop_equipment_lethal_generic";
        break;
      case #"hash_46fa1fc325bffb72":
      case #"hash_541953bbb2a0b9b6":
      case #"hash_7a4600eb72241347":
      case #"hash_925b7857be808b57":
      case #"hash_e47d766c40ac831b":
      case #"hash_4b5ae4745b98e56":
      case #"hash_2838637cb090a498":
      case #"hash_b3aa5201c2e89945":
      case #"hash_36b47d09e6eca09d":
      case #"hash_4326cb8d4b104ef9":
      case #"hash_fcf0917a32b55c2a":
        var_3ef0fdcee94cadff = #"ping_inv_drop_equipment_tactical_generic";
        break;
    }
  }

  if(var_3ef0fdcee94cadff == "") {
    if(issubstr(scriptablename, "plunder_cash")) {
      var_3ef0fdcee94cadff = #"ping_inv_drop_cash";
    } else if(issubstr(scriptablename, "taccover") || issubstr(scriptablename, "trophy") || issubstr(scriptablename, "recondrone") || issubstr(scriptablename, "super") || issubstr(scriptablename, "balloon") || issubstr(scriptablename, "deployed_decoy")) {
      var_3ef0fdcee94cadff = #"ping_inv_drop_fieldupgrade_generic";
    } else if(issubstr(scriptablename, "access_card")) {
      var_3ef0fdcee94cadff = #"ping_inv_drop_keycard";
    } else if(issubstr(scriptablename, "loot_key") || issubstr(scriptablename, "loot_multi_key")) {
      var_3ef0fdcee94cadff = #"ping_inv_drop_key";
    } else if(issubstr(scriptablename, "killstreak")) {
      var_3ef0fdcee94cadff = #"ping_inv_drop_killstreak_generic";
    } else if(issubstr(scriptablename, "valuable")) {
      var_3ef0fdcee94cadff = #"ping_inv_drop_valuable";
    } else if(issubstr(scriptablename, "_me_riotshield")) {
      var_3ef0fdcee94cadff = #"ping_inv_drop_weapon_riotshield";
    } else if(issubstr(scriptablename, "weapon_me")) {
      var_3ef0fdcee94cadff = #"ping_inv_drop_weapon_melee";
    } else if(issubstr(scriptablename, "weapon_dm")) {
      var_3ef0fdcee94cadff = #"ping_inv_drop_weapon_dmr";
    }
  }

  if(var_3ef0fdcee94cadff != "") {
    if(issharedfuncdefined("sound", "trySayLocalSound")) {
      level thread[[getsharedfunc("sound", "trySayLocalSound")]](player, var_3ef0fdcee94cadff);
    }
  }
}

function function_47990577bda08bb4(player, var_24cf8955fecf23ac) {
  if(!isDefined(player) || !isDefined(var_24cf8955fecf23ac)) {
    return;
  }

  foreach(pingowner in var_24cf8955fecf23ac) {
    if(pingowner != player) {
      for(pingindex = 0; pingindex < 10; pingindex++) {
        isowner = pingowner function_1e008bf9d31b2b01(pingindex);

        if(isowner && pingowner calloutmarkerping_getactive(pingindex)) {
          pingowner calloutmarkerping_hide(pingindex, player);
        }
      }
    }
  }
}

function function_3d92221d673d555c(player, var_7a36c6d035ca56e5) {
  if(!isDefined(player) || !isDefined(var_7a36c6d035ca56e5)) {
    return;
  }

  foreach(pingowner in var_7a36c6d035ca56e5) {
    if(pingowner != player) {
      for(pingindex = 0; pingindex < 10; pingindex++) {
        isowner = pingowner function_1e008bf9d31b2b01(pingindex);

        if(isowner && pingowner calloutmarkerping_getactive(pingindex)) {
          pingowner calloutmarkerping_show(pingindex, player);
        }
      }
    }
  }
}

function private function_f956b46f8e151d30(pingowner, pingindex) {
  target = function_b6cb97b6f81f0fd2(pingowner, pingindex);

  if(isDefined(target) && function_49cdea45f60452c8(pingowner, pingindex, target)) {
    return true;
  }

  return false;
}

function private function_49cdea45f60452c8(pingowner, pingindex, oldtarget) {
  if(isDefined(oldtarget) && isDefined(oldtarget.var_ad4f035f68ad85ad) && isDefined(oldtarget.var_b71b168e8ed463ce) && isDefined(oldtarget.var_a7aa780bf65803d2)) {
    pingowner calloutmarkerping_removecallout(pingindex);
    pingowner calloutmarkerping_createcallout(oldtarget.var_a7aa780bf65803d2, oldtarget.var_ad4f035f68ad85ad, oldtarget.var_b71b168e8ed463ce);
    return true;
  }

  return false;
}

function private function_caadd21a226bf96(pingowner, pingindex) {
  target = function_b6cb97b6f81f0fd2(pingowner, pingindex);

  if(isDefined(target) && isDefined(target.var_a49938597b3587f0) && isDefined(target.var_8c7acce8a4d9c2c)) {
    if(!isDefined(pingowner.var_74c9b4d7a9d4ec62)) {
      pingowner.var_74c9b4d7a9d4ec62 = [];
    }

    pingowner.var_74c9b4d7a9d4ec62[pingindex] = target;
    target.var_a49938597b3587f0[pingowner getentitynumber()] = pingowner;
    target.var_8c7acce8a4d9c2c[pingowner getentitynumber()] = pingindex;
  }
}

function private function_8c4b1d9591dc12ab(pingowner) {
  for(pingindex = 0; pingindex < 10; pingindex++) {
    isowner = pingowner function_1e008bf9d31b2b01(pingindex);

    if(isowner && pingowner calloutmarkerping_getactive(pingindex)) {
      function_ec3fedcb7195cfd7(pingowner, pingindex);
    }
  }
}

function private function_ec3fedcb7195cfd7(pingowner, pingindex) {
  target = undefined;

  if(isDefined(pingowner.var_74c9b4d7a9d4ec62)) {
    target = pingowner.var_74c9b4d7a9d4ec62[pingindex];
    pingowner.var_74c9b4d7a9d4ec62[pingindex] = undefined;
  }

  if(isDefined(target) && isDefined(target.var_a49938597b3587f0) && isDefined(target.var_8c7acce8a4d9c2c)) {
    target.var_a49938597b3587f0[pingowner getentitynumber()] = undefined;
    target.var_8c7acce8a4d9c2c[pingowner getentitynumber()] = undefined;
  }
}

function private function_b6cb97b6f81f0fd2(pingowner, pingindex) {
  pingtype = pingowner calloutmarkerping_gettype(pingindex);
  target = undefined;

  if(function_c648f0fd527e089a(pingtype) || function_d3789a9a4be5df2e(pingtype)) {
    target = pingowner calloutmarkerping_getEnt(pingindex);
  }

  if(isDefined(target) && isDefined(target.entity)) {
    target = target.entity;
  }

  targetstruct = spawnStruct();
  targetstruct.target = target;
  pingowner callback::callback("on_tacmap_ping_scriptable_or_ent", targetstruct);
  return target;
}

function private function_53ebc25dcfe48d00(player, objid) {
  if(!function_a23877559a8e22e8()) {
    return true;
  }

  if(!isDefined(level.objectives)) {
    return true;
  }

  currentobjective = undefined;

  foreach(objective in level.objectives) {
    if(isDefined(objective.objidnum) && objective.objidnum == objid) {
      currentobjective = objective;
      break;
    }
  }

  if(!isDefined(currentobjective)) {
    return true;
  }

  return isDefined(currentobjective.touchlist) && isDefined(currentobjective.touchlist[player.team]) && currentobjective.touchlist[player.team].size > 0;
}

function private function_a23877559a8e22e8() {
  if(!isDefined(level.gametype)) {
    return false;
  }

  gametype = level.gametype;
  return gametype == "dom" || gametype == "koth" || gametype == "hc_koth" || gametype == "lp_koth" || gametype == "cdl_koth" || gametype == "koth_horde" || gametype == "koth_jugg" || gametype == "grnd" || gametype == "gwai" || gametype == "hq";
}

function private function_6641a5b759148e1b() {
  return scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "dmz";
}

function function_ce5c3314571d6a29(pingindex, pingtype, scriptable) {
  player = self;

  if(pingtype == 21) {
    waittime = getdvarfloat(@ "hash_95248e22b4b46e33", 120);
  } else if(function_c648f0fd527e089a(pingtype)) {
    if(pingtype == 23) {
      waittime = getdvarfloat(@ "hash_cce27a6c00a3b750", 120);
    } else {
      waittime = getdvarfloat(@ "hash_e6261a609ec4112a", 30);
    }

    if(isDefined(scriptable) && isDefined(scriptable.type) && scriptable.type == "br_plunder_box" || scriptable.type == "dmz_supply_drop" || scriptable.type == "dmz_supply_drop_boss" || scriptable.type == "dmz_supply_drop_samsite" || scriptable.type == "dmz_supply_drop_supply") {
      waittime = getdvarfloat(@ "hash_cce27a6c00a3b750", 120);
    }
  } else if(function_5dacc89a40a58737(pingtype)) {
    waittime = 3;
  } else if(function_d3789a9a4be5df2e(pingtype)) {
    waittime = getdvarfloat(@ "hash_be114e61e75d4839", 60);
  } else if(function_87df78670540e9b2(pingtype)) {
    waittime = getdvarfloat(@ "hash_9cdd2e8a0a819ed2", 120);
  } else {
    switch (pingtype) {
      case 3:
        waittime = getdvarfloat(@ "hash_5f52828b2ccf6cbd", 15);
        break;
      case 2:
      case 17:
        waittime = getdvarfloat(@ "hash_9cdd2e8a0a819ed2", 120);
        break;
      case 4:
        waittime = getdvarfloat(@ "hash_ccd1bcd6036c7446", 120);
        break;
      case 6:
        waittime = getdvarfloat(@ "hash_1b586a47dbf318ae", 60);
        break;
      case 5:
        waittime = getdvarfloat(@ "hash_5bcef0d3e309d5f9", 30);
        break;
      case 12:
        waittime = getdvarfloat(@ "hash_cbf3b191a8e466fc", 9);
        break;
      default:
        assertmsg("<dev string:x48>" + "<dev string:x5f>" + pingtype);
        waittime = 2;
        break;
    }
  }

  return waittime;
}

function function_3bc031ab2f635f8c(lootid) {
  loottype = "";

  if(isDefined(lootid)) {
    loottype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootid);

    if(!isDefined(loottype)) {
      scripts\mp\utility\script::demoforcesre("No loot type defined for " + lootid);
      loottype = "";
    }
  }

  return loottype;
}

function function_c35cbd50adbcd4fd() {
  thread function_36b4f023a49e3ff3();
  waitframe();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x8d0>");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x8eb>", @ "hash_abc406da71abacd3");
  scripts\common\devgui::function_fe953f000498048f();
}

function private function_36b4f023a49e3ff3() {
  level endon("<dev string:x901>");

  while(true) {
    if(getdvarint(@ "hash_abc406da71abacd3", 0)) {
      setDvar(@ "hash_abc406da71abacd3", 0);

      foreach(bot in level.players) {
        if(isbot(bot)) {
          bot calloutmarkerping_createcallout(16, bot.origin);
        }
      }
    }

    waitframe();
  }
}

# /