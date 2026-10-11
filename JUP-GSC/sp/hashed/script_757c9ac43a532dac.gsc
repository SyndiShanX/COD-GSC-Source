/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_757c9ac43a532dac.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_5cb623572b271c34;
#using scripts\common\utility;
#using scripts\cp\armory_kiosk;
#using scripts\cp\challenges_cp;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_hud_message;
#using scripts\cp\loot_system;
#using scripts\cp\munitions;
#using scripts\cp\pickups;
#using scripts\cp\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\vehicles\vehicle_airdrop;
#using scripts\engine\utility;
#namespace namespace_d39aa0b38a4b57b0;

function kiosk_init() {
  setDvar(@ "hash_ed6e4ffa933af621", 1);
  level.var_5771fc79979ccc58 = &function_5771fc79979ccc58;
  level.var_8a3d726e5cf04cc0 = &function_8a3d726e5cf04cc0;
  level.var_2ad8917b23c8c1d2 = &function_2ad8917b23c8c1d2;
}

function function_5771fc79979ccc58(itemdata, var_6dc0e605ecd21eee, var_7c3865dee4abed6, var_fbd5fada61ae8341) {
  player = self;
  success = undefined;

  if(itemdata.type == "killstreak") {
    if(!istrue(var_6dc0e605ecd21eee)) {
      if(player haskillstreaksharedfunc(itemdata.ref)) {
        player scripts\cp\armory_kiosk::_closepurchasemenuwithresponse(4);
        return 0;
      }
    }

    switch (itemdata.entryref) {
      case #"hash_2477dacf82d08d5b":
      case #"hash_c0f24a8eab399e9d":
        success = player scripts\cp\munitions::function_50be8abfe68ddbfc();

        if(!success) {
          player scripts\cp\armory_kiosk::_closepurchasemenuwithresponse(7);
        }

        break;
      case #"hash_4d35eb58f9d545f0":
      case #"hash_4e5a4dfe922e32af":
        success = player scripts\cp\munitions::function_50be8abfe68ddbfc();

        if(!success) {
          player scripts\cp\armory_kiosk::_closepurchasemenuwithresponse(7);
        }

        break;
    }
  } else if(itemdata.type == "fieldupgrade" || itemdata.type == "super") {
    if(player issuperinusesharedfunc()) {
      player scripts\cp\armory_kiosk::_closepurchasemenuwithresponse(6);
      return 0;
    }

    if(!istrue(var_6dc0e605ecd21eee)) {
      currentsuperref = player getcurrentsuperrefsharedfunc();

      if(isDefined(currentsuperref) && itemdata.ref == currentsuperref) {
        player scripts\cp\armory_kiosk::_closepurchasemenuwithresponse(5);
        return 0;
      }
    }

    switch (itemdata.ref) {
      case #"hash_29972969a98220a1":
      case #"hash_6bc36a1e4f485a79":
        success = player scripts\cp\munitions::function_50be8abfe68ddbfc();

        if(!success) {
          player scripts\cp\armory_kiosk::_closepurchasemenuwithresponse(7);
        }

        break;
    }
  } else if(itemdata.type == "perk") {
    if(player hasperksharedfunc(itemdata.ref)) {
      player scripts\cp\armory_kiosk::_closepurchasemenuwithresponse(5);
      return 0;
    }
  } else if(itemdata.type == "special") {
    switch (itemdata.ref) {
      case #"hash_25789111b74943b4":
      case #"hash_2dcde97962801ba9":
        success = player function_dbf72a7c50f79f16(itemdata);

        if(!success) {
          player scripts\cp\armory_kiosk::_closepurchasemenuwithresponse(2);
        }

        break;
      case #"hash_505af9c28f43defb":
      case #"hash_f9680a9951f0d1d1":
      case #"hash_fd8da3bdddb8e1c2":
        success = player function_118948fbeae841b3(itemdata);

        if(!success) {
          player scripts\cp\armory_kiosk::_closepurchasemenuwithresponse(2);
        }

        break;
      case #"hash_dad2e39dcf5e31c":
      case #"hash_c31089e2e50b5079":
        success = player scripts\cp\munitions::function_50be8abfe68ddbfc();

        if(!success) {
          player scripts\cp\armory_kiosk::_closepurchasemenuwithresponse(7);
        }

        break;
      case #"hash_1c3e21ffbc842487":
        if(istrue(self.hasselfrevivetoken)) {
          success = 0;
          player scripts\cp\armory_kiosk::_closepurchasemenuwithresponse(10);
        }

        break;
      case #"hash_29972969a98220a1":
      case #"hash_6bc36a1e4f485a79":
        success = player scripts\cp\munitions::function_50be8abfe68ddbfc();

        if(!success) {
          player scripts\cp\armory_kiosk::_closepurchasemenuwithresponse(7);
        }

        break;
      case #"hash_60c202bd7b37412c":
        success = player function_cba4b211895aa155(itemdata);
        break;
      case #"hash_c662d84c73daa0a8":
        if(isDefined(level.var_473cdd03b063c62a) && level.var_473cdd03b063c62a.num_vehicles == 3) {
          success = 0;
          player scripts\cp\armory_kiosk::_closepurchasemenuwithresponse(22);
        }

        break;
    }
  }

  if(isDefined(success)) {
    if(istrue(success)) {
      thread scripts\cp\cp_analytics::function_54204f27964fddcf(player, itemdata.ref, var_fbd5fada61ae8341);
    }

    return success;
  }

  thread scripts\cp\cp_analytics::function_54204f27964fddcf(player, itemdata.ref, var_fbd5fada61ae8341);
  return 1;
}

function function_8a3d726e5cf04cc0(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6) {
  player = self;
  kiosk = player.br_kiosk;
  level.var_f091400016c92e56 = 1;
  purchasesuccess = 1;
  var_b517df938986556f = 1;
  var_a51e1e429c38ee87 = undefined;

  if(itemdata.type == "killstreak") {
    switch (itemdata.entryref) {
      case #"hash_55832126f31a79e5":
      case #"hash_ee05b23221d81da3":
        purchasesuccess = scripts\cp\loot_system::give_munition("brloot_munition_precision_airstrike", player);
        var_a51e1e429c38ee87 = 1;
        break;
      case #"hash_d18f8ef4807b550":
      case #"hash_3cbf803351d370c2":
        purchasesuccess = scripts\cp\loot_system::give_munition("brloot_killstreak_auto_drone", player);
        var_a51e1e429c38ee87 = 1;
        break;
      case #"hash_3977906a434adf6d":
      case #"hash_4e5a4dfe922e32af":
        purchasesuccess = scripts\cp\loot_system::give_munition("brloot_munition_cluster_spike", player);
        var_a51e1e429c38ee87 = 1;
        break;
      case #"hash_2477dacf82d08d5b":
      case #"hash_c0f24a8eab399e9d":
        purchasesuccess = scripts\cp\loot_system::give_munition("brloot_munition_cruise_missile", player);
        var_a51e1e429c38ee87 = 1;
        break;
      case #"hash_8c83b96c2dbb1384":
      case #"hash_ddc19327025e99aa":
        purchasesuccess = scripts\cp\loot_system::give_munition("brloot_munition_juggernaut", player);
        level notify("defender_kiosk_juggernaut_purchased", player);
        var_a51e1e429c38ee87 = 1;
        break;
    }
  } else {
    switch (itemdata.ref) {
      case #"hash_35b54fddb56cbd88":
      case #"hash_fd8da3bdddb8e1c2":
        player function_a9d99fe0169fdb0a();
        break;
      case #"hash_6e3bfd36d5aec4a":
      case #"hash_25789111b74943b4":
        purchasesuccess = function_e2db59d7677bfceb(player, "brloot_armor_plate", 1, undefined, 1, var_452130d9d126e506);

        if(!purchasesuccess) {
          dropinfo = getitemdroporiginandanglessharedfunc(0, kiosk.origin, kiosk.angles, player);
          pickupent = spawnpickupsharedfunc("brloot_armor_plate", dropinfo, 1, 1, undefined, 0);
          purchasesuccess = 1;
        }

        break;
      case #"hash_2dcde97962801ba9":
      case #"hash_dacf5834c56886f7":
        var_2b83f7cf5dd2cf23 = player scripts\cp\armory_kiosk::_findgivearmoramountanddropleftovers(1);

        if(var_2b83f7cf5dd2cf23 <= 0) {
          purchasesuccess = 1;
        } else {
          purchasesuccess = function_e2db59d7677bfceb(player, "brloot_armor_plate", 1, var_2b83f7cf5dd2cf23, 1, var_452130d9d126e506);
        }

        assert(purchasesuccess);
        break;
      case #"hash_dad2e39dcf5e31c":
      case #"hash_c31089e2e50b5079":
        purchasesuccess = scripts\cp\loot_system::give_munition("brloot_munition_sentry", player);
        var_a51e1e429c38ee87 = 1;
        break;
      case #"hash_1c3e21ffbc842487":
      case #"hash_1f45b794418562e9":
        player thread scripts\cp\pickups::addselfrevivetoken();
        break;
      case #"hash_29972969a98220a1":
      case #"hash_6b880460408706e7":
      case #"hash_6bc36a1e4f485a79":
        purchasesuccess = scripts\cp\loot_system::give_munition("brloot_munition_munitions_crate", player);
        var_a51e1e429c38ee87 = 1;
        break;
      case #"hash_505eaa8e90cc16ca":
      case #"hash_60c202bd7b37412c":
        break;
      case #"hash_c662d84c73daa0a8":
        function_3a06ec88cb67667b();

        if(level.var_473cdd03b063c62a.num_vehicles == 3) {
          purchasesuccess = 0;
          break;
        }

        jltv = thread function_498d00efdf8e6af3();
        break;
    }
  }

  if(purchasesuccess) {
    var_fbd5fada61ae8341 = scripts\cp\armory_kiosk::_getactualcost(player, itemdata);
    itemname = function_68ed62c896913c57(itemdata.ref);
    scripts\cp\challenges_cp::function_d8b00758a4ecbda7(itemname);
    scripts\cp\challenges_cp::function_ce271d4118a0475d(var_fbd5fada61ae8341);
    player scripts\cp\armory_kiosk::_makekioskpurchase(itemdata);

    if(var_b517df938986556f) {
      player thread showsplashsharedfunc("br_item_purchased");
    }

    if(istrue(var_a51e1e429c38ee87)) {
      player thread function_27ced223b0b31d99();
    }

    scripts\engine\utility::callsharedfunc("defender_vo", "item_purchased", itemname);
    scripts\cp_mp\challenges::onkioskpurchaseitem("special", itemdata.ref, undefined, 1, itemdata.cost);
    namespace_53fc9ddbb516e6e1::function_98bd9179435d1557(self, itemdata.cost, "special", itemdata.ref);
  }
}

function function_27ced223b0b31d99() {
  self endon("death_or_disconnect");
  self endon("last_stand_start");
  wait 3;
  scripts\cp\utility::hint_prompt("tutorial_munitions", 1, 8, 1);
}

function function_68ed62c896913c57(ref) {
  switch (ref) {
    case #"hash_f9680a9951f0d1d1":
    case #"hash_fd8da3bdddb8e1c2":
      return "delta_soldiers";
  }

  return ref;
}

function function_2ad8917b23c8c1d2(cost, itemdata) {
  multiplier = scripts\cp\pickups::function_6c95beb0447ff560();
  finalcost = int(cost * multiplier);
  return finalcost;
}

function function_498d00efdf8e6af3() {
  debug_drop = getdvarint(@ "hash_b0ff99704a332f6f") > 0;
  drop_location = function_9d9ac764c359a4a4();
  level.var_473cdd03b063c62a.var_64a7d687bfe1b47d++;

  if(level.var_473cdd03b063c62a.var_64a7d687bfe1b47d == 3) {
    level.var_473cdd03b063c62a.var_64a7d687bfe1b47d = 0;
  }

  level.var_473cdd03b063c62a.num_vehicles++;

  if(debug_drop) {
    thread drawsphere(drop_location.origin, 20, 10, (1, 0, 0));
  }

  spawndata = spawnStruct();
  spawndata.origin = drop_location.origin;
  spawndata.angles = drop_location.angles;
  var_17160569dab45fd6 = scripts\cp_mp\vehicles\vehicle_airdrop::vehicle_airdrop("veh9_jltv_mg", spawndata);
  var_17160569dab45fd6 thread function_74ac9140ddcce4dd();
  var_17160569dab45fd6 thread function_1b38e55682dfcb61(drop_location);

  if(debug_drop) {
    var_17160569dab45fd6 thread function_38830a31e89c2e73(drop_location);
  }

  if(!isDefined(var_17160569dab45fd6)) {
    level.var_473cdd03b063c62a.num_vehicles--;
    return undefined;
  }

  level.var_473cdd03b063c62a.var_104c9f34a293c2ff = array_add(level.var_473cdd03b063c62a.var_104c9f34a293c2ff, var_17160569dab45fd6);
  return var_17160569dab45fd6;
}

function function_1b38e55682dfcb61(drop_location) {
  kill_trigger = getEnt(drop_location.target, "targetname");
  var_e1284ca18beb2ec4 = squared(20);

  while(true) {
    drop_dist = lengthsquared(drop_location.origin - self.origin);

    if(drop_dist < var_e1284ca18beb2ec4) {
      axis_team = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
      ally_team = scripts\cp\cp_agent_utils::getaliveagentsofteam("allies");
      var_da44429a60525ce8 = array_combine(level.players, ally_team, axis_team);
      touching_ents = kill_trigger getistouchingentities(var_da44429a60525ce8);

      foreach(ent in touching_ents) {
        if(isPlayer(ent)) {
          ent thread function_ba7469b0e511af83();
        } else {
          ent kill(drop_location.origin, self, self, "MOD_PROJECTILE");
        }

        ent playSound("prty_elevator_shaft_player_crush");
      }

      break;
    }

    if(drop_dist < squared(12)) {
      break;
    }

    waitframe();
  }
}

function function_ba7469b0e511af83() {
  self.shouldskipdeathsshield = 1;
  self.shouldskiplaststand = 1;
  self dodamage(self.maxhealth + 100000, self.origin, self, undefined, "MOD_TRIGGER_HURT");
  self dodamage(self.maxhealth + 100000, self.origin, self, undefined, "MOD_TRIGGER_HURT");
  wait 5;
  self.shouldskipdeathsshield = 0;
  self.shouldskiplaststand = 0;
}

function function_74ac9140ddcce4dd() {
  self waittill("death");
  level.var_473cdd03b063c62a.var_104c9f34a293c2ff = array_remove(level.var_473cdd03b063c62a.var_104c9f34a293c2ff, self);
  level.var_473cdd03b063c62a.num_vehicles--;
}

function function_38830a31e89c2e73(drop_location) {
  self endon("death");
  kill_trigger = getEnt(drop_location.target, "targetname");

  while(true) {
    drop_dist = length(drop_location.origin - self.origin);

    if(drop_dist < 11) {
      break;
    }

    thread draw_line_for_time(self.origin, drop_location.origin, 0, 0, 1, 0.05);

    print3d(drop_location.origin, "<dev string:x1c>" + drop_dist, (1, 1, 1), 1, 1, 1);

    drawentitybounds(kill_trigger, (1, 1, 1), 1, 1);

    waitframe();
  }
}

function function_3a06ec88cb67667b() {
  if(isDefined(level.var_473cdd03b063c62a)) {
    return;
  }

  setdvarifuninitialized(@ "hash_b0ff99704a332f6f", 0);
  level.var_473cdd03b063c62a = spawnStruct();
  level.var_473cdd03b063c62a.num_vehicles = 0;
  level.var_473cdd03b063c62a.var_64a7d687bfe1b47d = 0;
  level.var_473cdd03b063c62a.var_104c9f34a293c2ff = [];
}

function function_9d9ac764c359a4a4() {
  var_30272807396105f4 = getStructArray("vehicle_airdrop_location", "script_noteworthy");
  return var_30272807396105f4[level.var_473cdd03b063c62a.var_64a7d687bfe1b47d];
}

function function_dbf72a7c50f79f16(itemdata) {
  player = self;
  var_6a8b46e184e181cc = spawnStruct();
  var_6a8b46e184e181cc.scriptablename = "brloot_armor_plate";

  if(itemdata.ref == "armor_bundle") {
    var_6a8b46e184e181cc.count = 5;
  } else {
    var_6a8b46e184e181cc.count = 1;
  }

  canpickupresult = cantakepickupsharedfunc(var_6a8b46e184e181cc);

  if(canpickupresult != 1 && canpickupresult != 20) {
    if(canpickupresult == 4) {
      return true;
    } else {
      player scripts\cp\armory_kiosk::_closepurchasemenuwithresponse(7);
      return false;
    }
  }

  return true;
}

function function_118948fbeae841b3(itemdata) {
  total_soldiers = namespace_8784b0174836bc50::total_allies();

  if(isDefined(level.var_410dcb9cda2b067) && level.var_410dcb9cda2b067.size >= 3) {
    thread scripts\cp\cp_hud_message::tutorialprint(level.var_9c3aa643b7642fb1);
    return 0;
  }

  if(total_soldiers >= namespace_8784b0174836bc50::function_87ac668a043af5dd()) {
    thread scripts\cp\cp_hud_message::tutorialprint(level.var_9c3aa643b7642fb1);
    return 0;
  }

  if(!isDefined(level.soldier_allies)) {
    thread scripts\cp\cp_hud_message::tutorialprint(level.var_9c3aa643b7642fb1, 2);
    return 0;
  }

  if(istrue(level.var_f42acfb1d6b18fd7)) {
    thread scripts\cp\cp_hud_message::tutorialprint(level.var_9c3aa643b7642fb1);
    return 0;
  }

  return 1;
}

function function_cba4b211895aa155(itemdata) {
  if(isDefined(level.var_e9922f45db5ae222)) {
    return 1;
  }

  return 0;
}

function function_18e5b806c7693d20() {
  if(isDefined(level.var_9c3aa643b7642fb1)) {
    return;
  }

  if(isDefined(level.var_54f48a7236a6dd69)) {
    [[level.var_54f48a7236a6dd69]]();
    return;
  }

  level.var_9c3aa643b7642fb1 = &"CP_WEAPON_BUY/DELTA_SQUAD_ALIVE";
  level.var_87dbb8d8d744c95f = &"CP_WEAPON_BUY/DELTA_SQUAD_SPAWN";
  level.var_988bc8650b85a175 = &"CP_WEAPON_BUY/DELTA_SQUAD_PAUSED";
}

function function_a9d99fe0169fdb0a() {
  playsoundtoplayer_safe("buystation_deltasquad_buy", self);
  level notify("deploy_delta_squad", self);
  return true;
}