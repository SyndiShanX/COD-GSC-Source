/********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\gametypes\fireteam_elimination.csc
********************************************************/

#using script_4a04e1760d0523d3;
#using script_67278d99b737542d;
#using script_6a72d858ff1942eb;
#using script_78825cbb1ab9f493;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_world_util;
#namespace fireteam_elimination;

function event_handler[gametype_init] main(eventstruct) {
  namespace_17baa64d::init();
  namespace_b77e8eb1::init();
  namespace_fc40d35f::function_dd83b835();
  level.var_b637a0c0 = &function_e99f251a;
  level.var_75f7e612 = &function_218c0417;
  level.var_977ee0c2 = &function_a2807fc5;
  clientfield::function_5b7d846d("hud_items_fireteam.exfil_state", #"hud_items_fireteam", #"exfil_state", 20000, 2, "int", undefined, 0, 0);
  clientfield::register("scriptmover", "isExfilSite", 20000, 1, "int", &function_d299e99d, 0, 0);
  clientfield::register_clientuimodel("hud_items_fireteam_percontroller.teamRedeployableCount", #"hud_items_fireteam_percontroller", #"teamredeployablecount", 7000, 3, "int", undefined, 0, 0);
  callback::on_localclient_connect(&on_localclient_connect);
}

function on_localclient_connect(localclientnum) {
  level thread function_bb2f717e(localclientnum);
}

function private function_bb2f717e(localclientnum) {
  self endon(#"shutdown");
  var_61efd7d9 = [];

  for(index = 0; index < 5; index++) {
    model = spawn(localclientnum, (0, 0, 0), "script_model");
    model setModel(#"tag_origin");
    model hide();
    model notsolid();
    var_61efd7d9[var_61efd7d9.size] = model;
  }

  while(true) {
    if(!isDefined(level.item_spawn_stashes)) {
      wait 1;
      continue;
    }

    draworigin = getcamposbylocalclientnum(localclientnum);
    containers = arraysortclosest(level.item_spawn_stashes, draworigin, 5, 0, 1500);
    var_7dcc7dd4 = [];

    for(index = 0; index < containers.size; index++) {
      if(!function_8a8a409b(containers[index])) {
        continue;
      }

      if(function_ffdbe8c2(containers[index]) != 2) {
        var_7dcc7dd4[var_7dcc7dd4.size] = containers[index];
      }
    }

    containers = var_7dcc7dd4;

    for(index = 0; index < containers.size; index++) {
      var_61efd7d9[index].origin = containers[index].origin;

      if(isDefined(var_61efd7d9[index].var_95f008e)) {
        continue;
      }

      var_61efd7d9[index].var_95f008e = var_61efd7d9[index] playLoopSound("amb_dirtybomb_container_amb", undefined, (0, 0, 25));
      var_61efd7d9[index] show();
    }

    for(index = containers.size; index < 5; index++) {
      if(!isDefined(var_61efd7d9[index].var_95f008e)) {
        continue;
      }

      var_61efd7d9[index] stoploopsound(var_61efd7d9[index].var_95f008e);
      var_61efd7d9[index].var_95f008e = undefined;
      var_61efd7d9[index] hide();
    }

    wait 1;
  }
}

function private function_e99f251a(localclientnum, itementry) {
  if(itementry.itemtype == # "generic") {
    switch (itementry.name) {
      case # "armor_pouch_item_t9":
        return (self clientfield::get_player_uimodel("hudItems.armorPlateMaxCarry") != 10);
      case # "hash_b8b2580ac5556e1":
        return (self clientfield::get_player_uimodel("hud_items.selfReviveAvailable") == 0);
      case # "hash_2ec97717fa7f8ee":
      case # "hash_6ebec4f42d4b01c":
        return false;
    }
  } else if(itementry.itemtype == # "armor_shard") {
    return false;
  }

  return true;
}

function private function_218c0417(localclientnum, itementry) {
  if(itementry.itemtype == # "generic") {
    switch (itementry.name) {
      case # "hash_2ec97717fa7f8ee":
      case # "hash_6ebec4f42d4b01c":
        return true;
    }

    return false;
  } else if(itementry.itemtype == # "armor_shard") {
    currentcount = self clientfield::get_player_uimodel("hudItems.armorPlateCount");
    return (currentcount < 5);
  }

  return true;
}

function private function_a2807fc5(localclientnum, itementry) {
  if(itementry.itemtype == # "scorestreak") {
    weapons = self getweaponslist();

    foreach(weapon in weapons) {
      var_16f12c31 = item_world_util::function_3531b9ba(weapon.name);

      if(!isDefined(var_16f12c31)) {
        continue;
      }

      hasammo = self getweaponammostock(localclientnum, weapon) > 0;

      if(hasammo) {
        return true;
      }
    }

    return false;
  }

  return false;
}

function private function_d299e99d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    namespace_b77e8eb1::function_270bde4c(fieldname, self);
  }
}