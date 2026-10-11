/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\calloutmarkerping_cp.gsc
**************************************************/

#using scripts\cp\utility;
#using scripts\cp\utility\disconnect_event_aggregator;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\engine\utility;
#namespace calloutmarkerping_cp;

function calloutmarkerping_init() {
  calloutmarkerping_initcommon();
  calloutmarkerping_cp_setupcptimeouts();
  scripts\cp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&calloutmarkerping_onplayerdisconnect);

  if(!isDefined(level.brloottablename)) {
    if(scripts\cp\utility::function_240f7f4e57340e8f()) {
      level.brloottablename = "cp/loot/dungeons/loot_item_defs.csv";
    } else {
      level.brloottablename = "cp/loot/default/loot_item_defs.csv";
    }
  }

  scripts\engine\utility::registersharedfunc("ping", "ping_cp_getCPVehicleCallout", &calloutmarkerping_cp_getcpvehiclevocallout);

  if(scripts\cp\utility::function_240f7f4e57340e8f()) {
    setDvar(@ "hash_dcab804f9c532b7f", 180);
    setDvar(@ "hash_c022bd4a1215cd2c", 0);
  }
}

function calloutmarkerping_cp_setupcptimeouts() {
  setDvar(@ "hash_7c74d4814e0665d5", 40);
  setDvar(@ "hash_abe00a149eb51fc0", 20);
  setDvar(@ "hash_f1ed16d72234a0cc", 20);
  setDvar(@ "hash_f2b483d963525879", 40);
  setDvar(@ "hash_d25a3e0be5e90c21", 20);
  setDvar(@ "hash_4710528047b1660d", 20);
  setDvar(@ "hash_817bed798637d38e", 40);
  setDvar(@ "hash_4da39a287b93388c", 20);
  setDvar(@ "hash_dcab804f9c532b7f", 7);
}

function calloutmarkerping_cp_getcpvehiclevocallout(var_f5013bae6266622f) {
  result = spawnStruct();
  result.vocalloutstring = "";
  result.bshouldreturnvalue = 0;

  if(isDefined(var_f5013bae6266622f.cpvehiclename)) {
    switch (var_f5013bae6266622f.cpvehiclename) {
      case #"hash_139f3265d782181a":
      case #"hash_8c6e07279cb098da":
      case #"hash_c3bd2de56be0fd07":
      case #"hash_dae644a4a82b47ea":
      case #"hash_ed0943d77ef90562":
      case #"hash_fff537710d349e0e":
        result.vocalloutstring = "ping_enemy_vehicle_light";
        result.bshouldreturnvalue = 1;
        return result;
      case #"hash_11fa43c9906b272a":
      case #"hash_42763fc348c56864":
      case #"hash_8550353996030176":
      case #"hash_9374c93af39410d1":
      case #"hash_a6f99763569bc4fb":
      case #"hash_c662d84c73daa0a8":
      case #"hash_d880a40ebb4a2928":
        result.vocalloutstring = "ping_enemy_vehicle_heavy";
        result.bshouldreturnvalue = 1;
        return result;
      case #"hash_6fbd504f237f8a9e":
      case #"hash_d8b2a1b97c44aff8":
        result.vocalloutstring = "ping_killstreaks_helo";
        result.bshouldreturnvalue = 1;
        return result;
      default:
        assertmsg("CalloutMarkerPing: " + "Vehicle Callout needs to setup an enemy entry for this name: " + var_f5013bae6266622f.vehiclename);
        break;
    }

    return;
  }

  if(isDefined(var_f5013bae6266622f.infil_name)) {
    switch (var_f5013bae6266622f.infil_name) {
      case #"hash_139f3265d782181a":
      case #"hash_7dd645b37a229430":
      case #"hash_72ea1a585c1d153c":
      case #"hash_36a654665ed22fb8":
      case #"hash_74a4c28ebce1f6c8":
      case #"hash_8a0f7da45709115a":
      case #"hash_8c6e07279cb098da":
      case #"hash_c3bd2de56be0fd07":
      case #"hash_dae644a4a82b47ea":
      case #"hash_ed0943d77ef90562":
      case #"hash_ee97790ae7ce7886":
      case #"hash_f60027ccb20dde63":
      case #"hash_f80baf80c1494495":
      case #"hash_fff537710d349e0e":
        result.vocalloutstring = "ping_enemy_vehicle_light";
        result.bshouldreturnvalue = 1;
        return result;
      case #"hash_8550353996030176":
      case #"hash_7299aacaef4b852":
      case #"hash_11fa43c9906b272a":
      case #"hash_40deeda27b02a040":
      case #"hash_42763fc348c56864":
      case #"hash_9374c93af39410d1":
      case #"hash_a6f99763569bc4fb":
      case #"hash_b6250afb09d7d634":
      case #"hash_bd2b14a6c78f31a8":
      case #"hash_c662d84c73daa0a8":
      case #"hash_d880a40ebb4a2928":
      case #"hash_f9e1e150d707a807":
        result.vocalloutstring = "ping_enemy_vehicle_heavy";
        result.bshouldreturnvalue = 1;
        return result;
      case #"hash_6293ed64b1ab6691":
      case #"hash_68cb10ac5667e070":
      case #"hash_6fbd504f237f8a9e":
      case #"hash_79dd32c8d8093d05":
      case #"hash_cae150ba135d92f1":
      case #"hash_7c7c9aedacdc1121":
      case #"hash_82d4b6913ed024ee":
      case #"hash_eaf573924ca949e2":
      case #"hash_105b2c29673792e":
      case #"hash_28e1a218834af75d":
      case #"hash_33b067b4549b0b36":
      case #"hash_3ac34cdad8041c36":
      case #"hash_9f4aa88a6f623b0f":
      case #"hash_4f1ed711fc7ee2e7":
        result.vocalloutstring = "ping_killstreaks_helo";
        result.bshouldreturnvalue = 1;
        return result;
      default:
        assertmsg("CalloutMarkerPing: " + "Vehicle Callout needs to setup an enemy entry for this name: " + var_f5013bae6266622f.vehiclename);
        break;
    }
  }
}

function setplayersquadindex(squadindex) {
  player = self;
  player.br_squadindex = squadindex;
  newextrainfo = player.game_extrainfo & 65528;
  newextrainfo |= squadindex;
  player.game_extrainfo = newextrainfo;
}

function setuppingspecificvars(player) {
  if(isDefined(player.br_squadindex)) {
    return;
  }

  if(level.teambased) {
    var_a900ebd15fe91f5 = [];

    for(i = 1; i < level.maxteamsize + 1; i++) {
      var_a900ebd15fe91f5[var_a900ebd15fe91f5.size] = i;
    }

    teamplayers = level.players;

    foreach(entry in teamplayers) {
      if(isDefined(entry.br_squadindex)) {
        var_a900ebd15fe91f5 = scripts\engine\utility::array_remove(var_a900ebd15fe91f5, entry.br_squadindex);
      }
    }

    if(var_a900ebd15fe91f5.size == 0) {
      assertmsg("No br_squadIndex available, things are broken!");
      return;
    }

    myindex = var_a900ebd15fe91f5[0];
    player setplayersquadindex(myindex);
  }
}