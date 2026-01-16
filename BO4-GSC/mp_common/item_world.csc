/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\item_world.csc
***********************************************/

#include script_68c78107b4aa059c;
#include scripts\core_common\activecamo_shared;
#include scripts\core_common\activecamo_shared_util;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\mp_common\item_inventory;
#include scripts\mp_common\item_inventory_util;
#include scripts\mp_common\item_spawn_groups;
#include scripts\mp_common\item_world_util;

#namespace item_world;

autoexec __init__system__() {
  system::register(#"item_world", &__init__, undefined, undefined);
}

private __init__() {
  if(getgametypesetting(#"useitemspawns") == 0) {
    return;
  }

  level.showpickuphintmodel = [];
  level.var_89f832ca = [];
  level.var_62c91473 = [];
  level.var_ce95aace = [];
  level.var_7e2f5883 = [];
  level.var_19cf0be9 = [];
  level.var_418d51ad = array(#"ammo_type_556_item", #"ammo_type_762_item", #"ammo_type_12ga_item", #"ammo_type_9mm_item", #"ammo_type_45_item", #"ammo_type_338_item", #"ammo_type_50cal_item", #"ammo_type_rocket_item");
  level.var_69ee9282 = array(#"armor_item_large", #"armor_item_medium", #"armor_item_small");
  level.var_6cb314b1 = array(#"sniperscope_wz_item", #"acog_plus_wz_item", #"reddot_wz_item", #"acog_wz_item", #"dualoptic_wz_item", #"holo_wz_item", #"reflex_wz_item", #"tritium_wz_item", #"suppressor_wz_item", #"extbarrel_wz_item", #"advmag_wz_item", #"extmag_wz_item", #"fastmag_wz_item", #"foregrip_wz_item", #"laser_sight_wz_item", #"pistol_grip_wz_item", #"stock_wz_item");
  level.var_3fd5d8f0 = array(#"frag_grenade_wz_item", #"cluster_semtex_wz_item", #"acid_bomb_wz_item", #"molotov_wz_item", #"wraithfire_wz_item", #"hatchet_wz_item", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item", #"swat_grenade_wz_item", #"concussion_wz_item", #"smoke_grenade_wz_item", #"smoke_grenade_wz_item_spring_holiday", #"emp_grenade_wz_item", #"spectre_grenade_wz_item", #"grapple_wz_item", #"unlimited_grapple_wz_item", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"flare_gun_veh_wz_item", #"wz_snowball", #"wz_waterballoon");
  level.var_9bc8c1bc = array(#"health_item_small", #"health_item_medium", #"health_item_large", #"health_item_squad");
  level.var_683c7e30 = array(#"perk_item_stimulant", #"perk_item_awareness", #"perk_item_deadsilence", #"perk_item_lightweight", #"perk_item_drifter", #"perk_item_engineer", #"perk_item_medic", #"perk_item_reinforced", #"perk_item_looter", #"perk_item_outlander", #"perk_item_paranoia", #"perk_item_ironlungs", #"perk_item_squadlink", #"perk_item_consumer", #"perk_item_brawler");
  level.var_e93e16b = array(#"annihilator_wz_item", #"warmachine_wz_item", #"flamethrower_wz_item", #"sniper_fastrechamber_t8_gold_item", #"sniper_powerbolt_t8_gold_item", #"sniper_powersemi_t8_gold_item", #"sniper_quickscope_t8_gold_item", #"tr_longburst_t8_gold_item", #"tr_midburst_t8_gold_item", #"tr_powersemi_t8_gold_item", #"ar_accurate_t8_gold_item", #"ar_damage_t8_gold_item", #"ar_fastfire_t8_gold_item", #"ar_modular_t8_gold_item", #"ar_stealth_t8_gold_item", #"lmg_heavy_t8_gold_item", #"lmg_spray_t8_gold_item", #"lmg_standard_t8_gold_item", #"smg_accurate_t8_gold_item", #"smg_capacity_t8_gold_item", #"smg_fastfire_t8_gold_item", #"smg_handling_t8_gold_item", #"smg_standard_t8_gold_item", #"shotgun_semiauto_t8_gold_item", #"shotgun_pump_t8_gold_item", #"pistol_burst_t8_gold_item", #"pistol_revolver_t8_gold_item", #"pistol_standard_t8_gold_item");
  level.var_b9917a92 = array(#"annihilator_wz_item", #"warmachine_wz_item", #"flamethrower_wz_item", #"ray_gun_t8_item", #"launcher_standard_t8_item", #"sniper_fastrechamber_t8_item", #"sniper_powerbolt_t8_item", #"sniper_powersemi_t8_item", #"sniper_quickscope_t8_item", #"tr_leveraction_t8_item", #"tr_longburst_t8_item", #"tr_midburst_t8_item", #"tr_powersemi_t8_item", #"ar_accurate_t8_item", #"ar_damage_t8_item", #"ar_fastfire_t8_item", #"ar_galil_t8_item", #"ar_mg1909_t8_item", #"ar_modular_t8_item", #"ar_stealth_t8_item", #"lmg_double_t8_item", #"lmg_heavy_t8_item", #"lmg_spray_t8_item", #"lmg_standard_t8_item", #"smg_accurate_t8_item", #"smg_capacity_t8_item", #"smg_drum_pistol_t8_item", #"smg_fastfire_t8_item", #"smg_handling_t8_item", #"smg_mp40_t8_item", #"smg_standard_t8_item", #"smg_thompson_t8_item", #"pistol_burst_t8_item", #"pistol_revolver_t8_item", #"pistol_standard_t8_item", #"pistol_topbreak_t8_item", #"shotgun_pump_t8_item", #"shotgun_semiauto_t8_item", #"shotgun_trenchgun_t8_item", #"melee_bowie_t8_item");
  level.weaponbasemeleeheld = getweapon(#"bare_hands");
  level.var_c49f422c = 125;
  level.var_927fd418 = 75;
  level.var_c102677c = 64;

  if(issplitscreen()) {
    level.var_c49f422c = int(level.var_c49f422c * 0.7);
    level.var_927fd418 = int(level.var_927fd418 * 0.7);
    level.var_c102677c = int(level.var_c102677c * 0.7);
  }

  callback::on_localclient_connect(&_on_localclient_connect);
  callback::on_localplayer_spawned(&_on_localplayer_spawned);
  callback::function_930e5d42(&function_192b39cd);
  clientfield::register("world", "item_world_seed", 1, 31, "int", &function_4e9220ab, 1, 0);
  clientfield::register("world", "item_world_disable", 1, 1, "int", &function_60386766, 0, 0);
  clientfield::register("clientuimodel", "hudItems.pickupHintGold", 1, 1, "int", undefined, 0, 0);
  clientfield::register("scriptmover", "item_world_attachments", 10000, 1, "int", undefined, 0, 0);
  clientfield::register("toplayer", "disableItemPickup", 18000, 1, "int", undefined, 0, 0);
  level.var_45ca79e5 = &function_9160538;
  level.var_a6c75fcb = &function_9e4552fe;
  level.var_d342a3fd = [];

  if(!isDefined(level.item_spawn_stashes)) {
    level.item_spawn_stashes = [];
  }

  if(!isDefined(level.item_spawn_drops)) {
    level.item_spawn_drops = [];
  }

  if(!isDefined(level.var_624588d5)) {
    level.var_624588d5 = [];
  }

  level thread namespace_65181344::init_spawn_system();
}

private function_3d7c12a6(localclientnum, poolsize) {
  modellist = [];

  for(i = 1; i <= poolsize; i++) {
    model = spawn(localclientnum, (0, 0, -10000), "script_model");
    model function_e082e650(localclientnum, undefined, #"tag_origin", 1);
    model hide();
    model notsolid();
    modellist[i * -1] = model;
  }

  return modellist;
}

private function_37175e73(var_fee74908) {
  level endon(#"game_ended");

  if(var_fee74908.size <= 0) {
    return;
  }

  level flagsys::wait_till_clear(#"hash_2d3b2a4d082ba5ee");

  if(var_fee74908[var_fee74908.size - 1] == 1) {
    level flagsys::wait_till(#"item_world_reset");
  }

  level flagsys::wait_till(#"item_world_initialized");

  for(wordindex = 0; wordindex < var_fee74908.size - 1; wordindex++) {
    for(bitindex = 0; bitindex < 32; bitindex++) {
      if(var_fee74908[wordindex]&1 << bitindex) {
        itemindex = wordindex * 32 + bitindex;
        hide_item(-1, itemindex);
      }
    }
  }
}

private function_952d97dc(localclientnum) {
  data = spawnStruct();
  data.modellist = function_3d7c12a6(localclientnum, level.var_c49f422c);
  data.var_d58b471d = 0;
  data.var_79b15dd1 = 0;
  data.var_ffc1c0e1 = [];
  data.var_baf65690 = [];
  level.var_d342a3fd[localclientnum] = data;
  item_inventory::inventory_init(localclientnum);
  level.var_d9beffb9 = util::getnextobjid(localclientnum);
  objective_add(localclientnum, level.var_d9beffb9, "invisible", #"weapon_pickup");
  level.var_383edf80 = util::getnextobjid(localclientnum);
  objective_add(localclientnum, level.var_383edf80, "invisible", #"multi_item_pickup");
  level.showpickuphintmodel[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.showPickupHint");
  level.var_89f832ca[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.pickupHintText");
  level.var_62c91473[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.pickupHintTextOverride");
  level.var_ce95aace[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.weapon3dHintState");
  level.var_7e2f5883[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.weapon3dForcedHintItem");
  level.var_19cf0be9[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.pickupHintImage");
}

private function_cdd9b388() {
  self notify("<dev string:x38>");
  self endon("<dev string:x38>");
  self endon(#"shutdown");

  while(true) {
    waitframe(1);

    if(getdvarint(#"hash_3fdd3b60f349d462", 0)) {
      if(isDefined(self)) {
        origin = self.origin;
        var_f4b807cb = function_2e3efdda(origin, undefined, 128, 2000);

        foreach(item in var_f4b807cb) {
          print3d(item.origin, "<dev string:x4b>" + item.networkid + "<dev string:x50>" + item.itementry.name, (0, 0, 1), 1, 0.4);
        }
      }
    }
  }
}

  function private function_3ee12d25(localclientnum, model) {
    if(!isDefined(model)) {
      return;
    }

    if(isDefined(model.var_2584a90d)) {
      model function_f6e99a8d(model.var_2584a90d);
    }

    model.var_2584a90d = undefined;
    function_2990e5f(localclientnum, model);
  }

function_2990e5f(localclientnum, model) {
  if(!isDefined(model)) {
    return;
  }

  if(isDefined(model.modelfx)) {
    stopfx(localclientnum, model.modelfx);
    model.modelfx = undefined;
  }
}

private function_48b8fc19(localclientnum) {
  var_7d8899cd = function_d634ed59();

  for(index = 0; index < var_7d8899cd; index++) {
    point = function_b1702735(index);

    if(!isDefined(point) || !isDefined(point.itementry)) {
      break;
    }

    xmodel = function_78a9fd5f(point);

    if(isDefined(xmodel)) {
      forcestreamxmodel(xmodel, 1, 1);
    }

    if((index + 1) % 50 == 0) {
      waitframe(1);
    }
  }

  for(player = function_5c10bd79(localclientnum); !isDefined(player) || !isplayer(player) || !isDefined(player.type) || player.type != #"player" || player ishidden() || player isinfreefall() || player function_9a0edd92(); player = function_5c10bd79(localclientnum)) {
    waitframe(1);
  }

  wait 15;

  for(index = 0; index < var_7d8899cd; index++) {
    point = function_b1702735(index);

    if(!isDefined(point) || !isDefined(point.itementry)) {
      break;
    }

    xmodel = function_78a9fd5f(point);

    if(isDefined(xmodel)) {
      stopforcestreamingxmodel(xmodel);
    }

    if((index + 1) % 50 == 0) {
      waitframe(1);
    }
  }
}

private function_c17fe536(localclientnum, clientdata, networkid) {
  model = function_839d4c20(localclientnum, clientdata, networkid);

  if(!isDefined(model) && isDefined(networkid) && item_world_util::function_2c7fc531(networkid)) {
    model = function_b1702735(networkid);

    if(model.hidetime !== -1) {
      model = undefined;
    }
  }

  if(!isDefined(model)) {
    return;
  }

  var_1ba7b9c8 = arraysortclosest(level.item_spawn_stashes, model.origin, 1, 0, 12);

  if(var_1ba7b9c8.size > 0) {
    return var_1ba7b9c8[0];
  }

  var_6594679a = arraysortclosest(level.var_624588d5, model.origin, 1, 0, 12);

  if(var_6594679a.size > 0) {
    return var_6594679a[0];
  }
}

private function_839d4c20(localclientnum, clientdata, networkid) {
  if(!isDefined(networkid)) {
    return;
  }

  if(isDefined(clientdata.modellist[networkid])) {
    model = clientdata.modellist[networkid];
  } else if(isDefined(level.item_spawn_drops[networkid])) {
    model = level.item_spawn_drops[networkid];
  }

  return model;
}

private function_61f5d33a(localclientnum, clientdata, networkid) {
  model = function_839d4c20(localclientnum, clientdata, networkid);

  if(!isDefined(model) && item_world_util::function_2c7fc531(networkid)) {
    model = function_b1702735(networkid);

    if(model.hidetime !== -1) {
      model = undefined;
    }
  }

  return model;
}

private function_237888bb(localclientnum) {

  if(getdvarint(#"scr_looter", 0)) {
    return true;
  }

    if(self hasperk(localclientnum, #"specialty_looter")) {
      return true;
    }

  return false;
}

private function_78bf134c(localclientnum, clientdata, networkid, model, itementry) {
  if(!isDefined(model)) {
    return;
  }

  player = function_5c10bd79(localclientnum);
  renderbundle = #"hash_29dbf9ddda64fc5a";

  if(isDefined(itementry)) {
    switch (itementry.rarity) {
      case #"none":
        if(isDefined(itementry.unlockableitemref) && itementry.itemtype != #"weapon") {
          renderbundle = #"hash_6f1ab68ac78ac2ea";
          break;
        }
      case #"common":
        renderbundle = #"hash_29dbf9ddda64fc5a";
        break;
      case #"rare":
        renderbundle = #"hash_6e89d52c60dd7fc3";
        break;
      case #"epic":
        renderbundle = #"hash_4cf701d23a7301d2";
        break;
      case #"legendary":
        renderbundle = #"hash_4368c406e6a21060";
        break;
    }

    if(itementry.itemtype == #"resource") {
      renderbundle = #"hash_2f523d47697a9ce3";
    } else if(itementry.itemtype == #"cash") {
      renderbundle = #"hash_5fbd33a25f74ddf0";
    }

    if(isDefined(itementry.wallbuyitem) && itementry.wallbuyitem) {
      renderbundle = #"hash_52f7937d76fafca0";
    }
  } else {
    if(model.targetname === #"wz_stash_blackjack") {
      renderbundle = #"hash_71bb09e5b3013952";
    }

    if(isDefined(model.var_bad13452)) {
      if(model.var_bad13452 == 2) {
        function_3ee12d25(localclientnum, model);
        return;
      }
    } else if(!isDefined(model.type)) {
      state = function_ffdbe8c2(model);

      if(state == 2) {
        function_3ee12d25(localclientnum, model);
        return;
      }
    }
  }

  if(isDefined(player) && isDefined(renderbundle) && player function_237888bb(localclientnum)) {
    renderbundle += "_looter";
  }

  if(isDefined(networkid) && isDefined(clientdata) && isDefined(clientdata.var_ffc1c0e1)) {
    if(isDefined(clientdata.var_ffc1c0e1[networkid]) && clientdata.var_ffc1c0e1[networkid].servertime > getservertime(localclientnum, 1)) {
      renderbundle = #"hash_3d6eb4b9bbc74fbd";

      if(isDefined(itementry)) {
        if(itementry.rarity == #"epic") {
          renderbundle = #"hash_269ac932c6e6b81f";
        } else if(isDefined(itementry.unlockableitemref)) {
          renderbundle = #"hash_12076df5fcd3d751";
        }
      }
    }
  }

  if(player clientfield::get_to_player("disableItemPickup")) {
    renderbundle = undefined;
  }

  if(isDefined(model.var_2584a90d) && model.var_2584a90d !== renderbundle) {
    model function_f6e99a8d(model.var_2584a90d);
  }

  if(isDefined(renderbundle)) {
    if(!model function_d2503806(renderbundle)) {
      model playrenderoverridebundle(renderbundle);
    }
  }

  model.var_2584a90d = renderbundle;

  if(isDefined(itementry) && isDefined(itementry.worldfx) && !isDefined(model.modelfx) && !model ishidden()) {
    originoffset = (isDefined(itementry.var_5dc4470b) ? itementry.var_5dc4470b : 0, isDefined(itementry.var_54a3b4ca) ? itementry.var_54a3b4ca : 0, isDefined(itementry.var_3e688854) ? itementry.var_3e688854 : 0);
    originoffset = rotatepoint(originoffset * -1, model.angles);
    originoffset += rotatepoint((isDefined(itementry.var_22d128f2) ? itementry.var_22d128f2 : 0, isDefined(itementry.var_48907470) ? itementry.var_48907470 : 0, isDefined(itementry.var_702943a1) ? itementry.var_702943a1 : 0), model.angles);
    angles = combineangles(model.angles, (isDefined(itementry.var_15b88fde) ? itementry.var_15b88fde : 0, isDefined(itementry.var_8c9a7dc8) ? itementry.var_8c9a7dc8 : 0, isDefined(itementry.var_7a51d937) ? itementry.var_7a51d937 : 0));
    forward = anglesToForward(angles);
    up = anglestoup(angles);
    model.modelfx = playFX(localclientnum, itementry.worldfx, model.origin + originoffset, forward, up);
  }
}

private function_3bd99d2f(localclientnum, clientdata, vehicle, clear = 0) {
  if(!isDefined(vehicle)) {
    return;
  }

  if(clear) {
    function_3ee12d25(localclientnum, vehicle);
    return;
  }

  renderbundle = #"hash_3d6eb4b9bbc74fbd";

  if(!vehicle function_d2503806(renderbundle)) {
    vehicle playrenderoverridebundle(renderbundle);
  }

  vehicle.var_2584a90d = renderbundle;
}

private _draw(localclientnum, draworigin) {
  self endon(#"shutdown");
  clientdata = function_a7e98a1a(localclientnum);

  if(!isDefined(clientdata)) {
    return;
  }

  var_5f6ea063 = isDefined(self.var_5f6ea063) && self.var_5f6ea063;
  self.var_5f6ea063 = undefined;
  self.var_506495f9 = undefined;
  servertime = getservertime(localclientnum, 0);
  clientdata.var_79b15dd1 = servertime;
  clientdata.drawing = 1;
  var_6369afab = function_963d3f6e();

  if(self isinfreefall() || self function_9a0edd92()) {
    var_6369afab = 4050;
  }

  maxdist = getdvarfloat(#"hash_2cd1a08f81049564", var_6369afab);
  var_f4b807cb = function_abaeb170(draworigin, undefined, level.var_c49f422c, maxdist, -1, 1, servertime);
  var_6665e24 = arraysortclosest(level.item_spawn_drops, draworigin, level.var_c49f422c, 0, maxdist);
  var_13e4be37 = [];

  foreach(dynamicitem in var_6665e24) {
    if(isDefined(dynamicitem) && dynamicitem.hidetime !== -1) {
      var_13e4be37[var_13e4be37.size] = dynamicitem;
    }
  }

  if(var_13e4be37.size > 0) {
    var_f4b807cb = arraycombine(var_f4b807cb, var_13e4be37, 1, 0);
    var_f4b807cb = arraysortclosest(var_f4b807cb, draworigin, level.var_c49f422c, 0, maxdist);
  }

  waitframe(1);
  clientdata.var_89e328b4 = clientdata.modellist;
  clientdata.modellist = [];
  var_c29769e0 = [];
  index = 0;
  assert(clientdata.var_89e328b4.size == level.var_c49f422c);

  for(index = 0; index < var_f4b807cb.size; index++) {
    item = var_f4b807cb[index];

    if(!isDefined(item)) {
      continue;
    }

    id = item.networkid;

    if(isDefined(clientdata.var_89e328b4[id])) {
      model = clientdata.var_89e328b4[id];
      clientdata.modellist[id] = model;
      clientdata.var_89e328b4[id] = undefined;
    } else {
      var_c29769e0[var_c29769e0.size] = item;
    }

    if((index + 1) % 50 == 0) {
      waitframe(1);
    }
  }

  waitframe(1);
  arrayremovevalue(clientdata.var_89e328b4, undefined, 0);
  waitframe(1);
  assert(clientdata.var_89e328b4.size + clientdata.modellist.size == level.var_c49f422c);
  assert(clientdata.var_89e328b4.size >= var_c29769e0.size);

  for(index = 0; index < var_c29769e0.size && index < clientdata.var_89e328b4.size; index++) {
    item = var_c29769e0[index];
    model = clientdata.var_89e328b4[index];
    model unlink();

    if(!isDefined(item)) {
      model hide();
      function_2990e5f(localclientnum, model);
      function_3ee12d25(localclientnum, model);
      clientdata.modellist[index * -1 - 1] = model;
    } else {
      model.origin = item.origin;
      model.angles = item.angles;
      model function_e082e650(localclientnum, item, function_78a9fd5f(item), item.itementry.modelscale);
      shouldshow = item_world_util::function_da09de95(item.networkid) && item_world_util::can_pick_up(item, servertime);
      shouldshow |= item.networkid < function_8322cf16() && item_world_util::can_pick_up(function_b1702735(item.networkid), servertime);
      shouldshow &= !(isDefined(item.type) && item.type === #"missile");

      if(shouldshow) {
        model show();
      } else {
        model hide();
        function_2990e5f(localclientnum, model);
      }

      originoffset = (isDefined(item.itementry.var_5dc4470b) ? item.itementry.var_5dc4470b : 0, isDefined(item.itementry.var_54a3b4ca) ? item.itementry.var_54a3b4ca : 0, isDefined(item.itementry.var_3e688854) ? item.itementry.var_3e688854 : 0);
      model.origin += rotatepoint(originoffset, model.angles);

      if(item_world_util::function_da09de95(item.networkid)) {
        model linkto(item);
      }

      clientdata.modellist[item.networkid] = model;
    }

    if((index + 1) % 50 == 0) {
      waitframe(1);
    }
  }

  waitframe(1);
  assert(clientdata.var_89e328b4.size - index + clientdata.modellist.size == level.var_c49f422c);

  while(index < clientdata.var_89e328b4.size) {
    model = clientdata.var_89e328b4[index];
    model hide();
    function_2990e5f(localclientnum, model);
    function_3ee12d25(localclientnum, model);
    clientdata.modellist[index * -1 - 1] = model;

    if((index + 1) % 50 == 0) {
      waitframe(1);
    }

    index++;
  }

  clientdata.var_89e328b4 = undefined;
  waitframe(1);
  assert(clientdata.modellist.size == level.var_c49f422c);

  if(getdvarint(#"hash_220f360a2cc8359a", 1)) {
    var_b8db3f93 = arraysortclosest(level.item_spawn_drops, draworigin, undefined, maxdist);

    foreach(item in var_b8db3f93) {
      function_3ee12d25(localclientnum, item);
    }

    waitframe(1);
    var_f945c1d4 = arraysortclosest(level.item_spawn_stashes, draworigin, undefined, maxdist);

    foreach(supplystash in var_f945c1d4) {
      function_3ee12d25(localclientnum, supplystash);
    }

    waitframe(1);
    var_8f6dbb2 = arraysortclosest(level.var_624588d5, draworigin, undefined, maxdist);

    foreach(deathstash in var_8f6dbb2) {
      function_3ee12d25(localclientnum, deathstash);
    }

    waitframe(1);
    var_6665e24 = arraysortclosest(level.item_spawn_drops, draworigin, level.var_927fd418, 0, maxdist);
    waitframe(1);
    var_ac2b6007 = arraysortclosest(level.item_spawn_stashes, draworigin, level.var_927fd418, 0, maxdist);
    waitframe(1);
    var_c36bd68a = arraysortclosest(level.var_624588d5, draworigin, level.var_927fd418, 0, maxdist);
    waitframe(1);
    var_f4b807cb = arraycombine(var_f4b807cb, var_6665e24, 1, 0);
    waitframe(1);
    var_f4b807cb = arraycombine(var_f4b807cb, var_ac2b6007, 1, 0);
    waitframe(1);
    var_f4b807cb = arraycombine(var_f4b807cb, var_c36bd68a, 1, 0);
    waitframe(1);
    var_f4b807cb = arraysortclosest(var_f4b807cb, draworigin, level.var_c49f422c + var_6665e24.size, 0, maxdist);
    waitframe(1);

    if(isDefined(self) && var_5f6ea063) {
      for(index = 0; index < var_f4b807cb.size; index++) {
        item = var_f4b807cb[index];

        if(!isDefined(item)) {
          continue;
        }

        model = isDefined(item.networkid) ? clientdata.modellist[item.networkid] : item;
        function_3ee12d25(localclientnum, model);

        if((index + 1) % 50 == 0) {
          waitframe(1);
        }
      }
    }

    waitframe(1);

    for(index = int(min(level.var_927fd418, var_f4b807cb.size)); index < level.var_c49f422c && index < var_f4b807cb.size; index++) {
      item = var_f4b807cb[index];

      if(!isDefined(item)) {
        continue;
      }

      model = isDefined(item.networkid) ? clientdata.modellist[item.networkid] : item;
      function_3ee12d25(localclientnum, model);

      if((index + 1) % 50 == 0) {
        waitframe(1);
      }
    }

    waitframe(1);

    for(index = 0; index < level.var_927fd418 && index < var_f4b807cb.size; index++) {
      item = var_f4b807cb[index];

      if(!isDefined(item)) {
        continue;
      }

      model = isDefined(item.networkid) ? clientdata.modellist[item.networkid] : item;

      if(isDefined(item.type) && item.type === #"missile") {
        model = item;
      }

      function_78bf134c(localclientnum, clientdata, item.networkid, model, item.itementry);

      if((index + 1) % 50 == 0) {
        waitframe(1);
      }
    }
  }

  clientdata.var_844c8166 = draworigin;
  clientdata.var_f4b807cb = var_f4b807cb;
  clientdata.var_d58b471d = var_f4b807cb.size;
  clientdata.drawing = undefined;
}

private function_78a9fd5f(point) {
  if(!isDefined(level.var_8c615e33)) {
    level.var_8c615e33 = [];
  }

  if(!isstruct(point) && isDefined(point.type == #"scriptmover") && isDefined(point.itementry.dropmodel) && point getentitynumber() < 1024) {
    if(isDefined(point.itementry.weapon) && point.itementry.weapon.name == #"waterballoon") {
      var_af7d7388 = array(#"hash_7306b72d120049f8", #"hash_27ae7cb403d5365b", #"hash_6add258ae958d31c", #"hash_6eb8f7ceb4627d9f", #"hash_228bf15c70137b61", #"hash_10c0ee53a36783e9");
      return var_af7d7388[randomintrange(0, var_af7d7388.size)];
    }

    return point.itementry.dropmodel;
  }

  if(!isDefined(level.var_8c615e33[point.itementry.name])) {
    if(isDefined(point.itementry.model) && point.itementry.model != "") {
      level.var_8c615e33[point.itementry.name] = point.itementry.model;
    } else if(isDefined(point.itementry.weapon) && point.itementry.weapon !== level.weaponnone) {
      level.var_8c615e33[point.itementry.name] = point.itementry.weapon.worldmodel;
    } else {
      level.var_8c615e33[point.itementry.name] = "tag_origin";
    }
  }

  return level.var_8c615e33[point.itementry.name];
}

private function_8cf40a8c(localclientnum) {
  return getcamposbylocalclientnum(localclientnum);
}

private function_9e4552fe(var_fee74908) {
  level thread function_37175e73(var_fee74908);
}

private function_9160538(localclientnum, eventtype, eventdata, var_c5a66313, var_567004a8) {
  waitframe(1);
  reset = isDefined(level flagsys::get(#"item_world_reset")) && level flagsys::get(#"item_world_reset");

  if(reset && eventtype == 1) {
    return;
  }

  if(issplitscreen() && eventtype == 1) {
    if(!level flagsys::get(#"item_world_initialized")) {
      return;
    }
  }

  if(issplitscreen() && !issplitscreenhost(localclientnum) && eventtype == 2) {
    if(!level flagsys::get(#"item_world_initialized")) {
      return;
    }
  }

  level flagsys::wait_till(#"item_world_initialized");

  if(reset != (isDefined(level flagsys::get(#"item_world_reset")) && level flagsys::get(#"item_world_reset"))) {
    return;
  }

  if(!isDefined(level.var_d342a3fd[localclientnum])) {
    return;
  }

  player = function_27673a7(localclientnum);
  isalive = isalive(player);

  switch (eventtype) {
    case 1:
      if(level flagsys::get(#"item_world_reset")) {
        return;
      }

      networkid = eventdata;
      hide_item(localclientnum, networkid);
      function_b78a9820(localclientnum);
      item = function_b1702735(networkid);
      item_inventory::function_31868137(localclientnum, item);
      play_pickup_fx(localclientnum, item);
      break;
    case 2:
      function_4de3ca98();
      networkid = eventdata;
      hide_item(localclientnum, networkid);
      function_b78a9820(localclientnum);
      item = function_b1702735(networkid);
      item_inventory::function_31868137(localclientnum, item);
      play_pickup_fx(localclientnum, item);
      break;
    case 3:
      networkid = eventdata;
      resetitem = isDefined(var_c5a66313) && var_c5a66313;
      showitem = isDefined(var_567004a8) && var_567004a8;

      if(resetitem) {
        function_4de3ca98();
        waittillframeend();
      } else if(level flagsys::get(#"item_world_reset")) {
        return;
      }

      show_item(localclientnum, networkid, showitem);
      function_b78a9820(localclientnum);
      clientdata = function_a7e98a1a(localclientnum);
      model = function_61f5d33a(localclientnum, clientdata, networkid);

      if(isDefined(model)) {
        function_a4886b1e(localclientnum, networkid, model);
      }

      play_spawn_fx(localclientnum, networkid);
      break;
    case 4:
      itemid = eventdata;
      count = var_c5a66313;
      slotid = var_567004a8 ? var_567004a8 - 1 : undefined;

      if(!isalive) {
        return;
      }

      item_inventory::function_9c4460e0(localclientnum, itemid, count, slotid);
      function_b78a9820(localclientnum);
      break;
    case 11:
      networkid = eventdata;

      if(!isalive) {
        return;
      }

      item_inventory::consume_item(localclientnum, networkid);
      break;
    case 15:
      networkid = eventdata;

      if(!isalive) {
        return;
      }

      item_inventory::function_52e537be(localclientnum, networkid);
      break;
    case 5:
      networkid = eventdata;

      if(!isalive) {
        return;
      }

      item_inventory::function_c6ff0aa2(localclientnum, networkid);
      function_b78a9820(localclientnum);
      break;
    case 6:
      networkid = eventdata;

      if(!isalive) {
        return;
      }

      item_inventory::function_3bd1836f(localclientnum, networkid);
      function_b78a9820(localclientnum);
      break;
    case 12:
      var_c9293a27 = eventdata;
      var_8f194e5a = var_c5a66313;

      if(!isalive) {
        return;
      }

      item_inventory::function_26c87da8(localclientnum, var_c9293a27, var_8f194e5a);
      break;
    case 7:
      networkid = eventdata;

      if(!isalive) {
        return;
      }

      item_inventory::function_fa372100(localclientnum, networkid);
      break;
    case 8:
      networkid = eventdata;
      function_b78a9820(localclientnum);
      break;
    case 9:
      networkid = eventdata;
      count = var_c5a66313;

      if(!isalive) {
        return;
      }

      item_inventory::update_inventory_item(localclientnum, networkid, count);
      function_b78a9820(localclientnum);
      break;
    case 10:
      item_inventory::inventory_init(localclientnum);
      break;
    case 13:
      networkid = eventdata;
      var_2ccf7a1c = var_c5a66313;
      function_347698a5(localclientnum, networkid, var_2ccf7a1c);
      break;
    case 14:
      vehicleentnum = eventdata;
      var_2ccf7a1c = var_c5a66313;
      function_d2f95c1a(localclientnum, vehicleentnum, var_2ccf7a1c);
      break;
    default:
      assertmsg("<dev string:x54>" + eventtype);
      break;
  }
}

private function_60386766(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level flagsys::wait_till(#"item_world_initialized");

  foreach(supply_stash in level.item_spawn_stashes) {
    setdynentenabled(supply_stash, !newval);
  }
}

private function_4e9220ab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    waitframe(1);

    if(isdemoplaying()) {
      function_8722e0f2(1);
    }

    if(!issplitscreenhost(localclientnum)) {
      function_1b11e73c();
    }

    level flagsys::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
    level flagsys::set(#"hash_2d3b2a4d082ba5ee");

    if(level flagsys::get(#"item_world_reset")) {
      return;
    }

    seed = newval >> 1;
    reset = newval&1;
    level.item_spawn_seed = seed;

    if(isdemoplaying() && !reset) {
      level flagsys::clear(#"hash_2d3b2a4d082ba5ee");
      level flagsys::clear(#"item_world_initialized");
      return;
    }

    if(reset) {
      level flagsys::set(#"item_world_reset");
    }

    setdvar(#"hash_21e070fbb56cf0f", 0);
    level flagsys::clear(#"item_world_initialized");
    level item_inventory::inventory_init(localclientnum);
    clientdata = function_a7e98a1a(localclientnum);

    if(isDefined(clientdata) && isDefined(clientdata.modellist)) {
      models = [];

      foreach(model in clientdata.modellist) {
        model notsolid();
        model hide();
        function_2990e5f(localclientnum, model);
        function_3ee12d25(localclientnum, model);
        models[models.size * -1 - 1] = model;
      }

      clientdata.modellist = models;
    }

    foreach(networkid, serverinfo in clientdata.var_ffc1c0e1) {
      clientdata.var_ffc1c0e1[networkid].servertime = 0;
    }

    foreach(vehicleentnum, serverinfo in clientdata.var_baf65690) {
      clientdata.var_baf65690[vehicleentnum].servertime = 0;
    }

    if(issplitscreenhost(localclientnum)) {
      level item_spawn_group::setup(localclientnum, seed, reset);
    }

    if(reset) {
      level thread function_48b8fc19(localclientnum);
    }

    player = function_5c10bd79(localclientnum);
    player.var_5f6ea063 = 1;
    level flagsys::set(#"item_world_initialized");
    level flagsys::clear(#"hash_2d3b2a4d082ba5ee");

    if(isdemoplaying()) {
      function_8722e0f2(0);
    }
  }
}

private function_e2e7ee77(localclientnum) {
  self function_198ac8a(localclientnum);
  self function_e1f6ddbf(localclientnum);
}

private function_198ac8a(localclientnum) {
  setting = function_ab88dbd2(localclientnum, #"warzoneinstantpickups");

  if(isDefined(setting)) {
    function_97fedb0d(localclientnum, 1, setting);
  }
}

private function_e1f6ddbf(localclientnum) {
  setting = function_ab88dbd2(localclientnum, #"warzoneprioritypickups");

  if(isDefined(setting)) {
    function_97fedb0d(localclientnum, 2, setting);
  }
}

private _on_localclient_connect(localclientnum) {
  function_952d97dc(localclientnum);
  self function_e2e7ee77(localclientnum);
}

private _on_localplayer_spawned(localclientnum) {

  self thread function_cdd9b388();

    if(self function_21c0fa55()) {
      self function_e2e7ee77(localclientnum);
      self thread _update_loop(localclientnum);
      level callback::function_6231c19(&item_inventory::function_6231c19);
    }
}

private function_192b39cd(localclientnum) {
  if(self function_da43934d()) {
    var_db6db8ba = self hasperk(localclientnum, #"specialty_looter");
    var_de744098 = self.var_db6db8ba !== var_db6db8ba;

    if(var_de744098) {
      self.var_5f6ea063 = 1;
    }

    self.var_db6db8ba = var_db6db8ba;
  }
}

private _set_weapon(localclientnum, item) {
  if(isDefined(item) && isDefined(item.itementry.weapon) && !isDefined(item.itementry.model) && isDefined(item.itementry.weapon.worldmodel)) {
    weapon = item_inventory_util::function_2b83d3ff(item);
    camoweapon = undefined;
    weaponoptions = undefined;

    if(isDefined(getgametypesetting(#"hash_54fe37a58b87c7a0")) ? getgametypesetting(#"hash_54fe37a58b87c7a0") : 0) {
      if(isDefined(item.weapon)) {
        weapon = item.weapon;
      }

      camoweapon = activecamo::function_385ef18d(weapon);
      weaponoptions = self getbuildkitweaponoptions(localclientnum, camoweapon);
    }

    if(isDefined(weaponoptions)) {
      self useweaponmodel(level.weaponnone, "tag_origin");
      self useweaponmodel(weapon, undefined, weaponoptions);
    } else {
      self useweaponmodel(weapon);
    }

    self useweaponhidetags(weapon);

    if(isDefined(weaponoptions)) {
      self activecamo::function_6efb762c(localclientnum, camoweapon, weaponoptions);
    }

    return 1;
  }

  self detachall();
  self useweaponmodel(level.weaponnone, "tag_origin");
  return 0;
}

private function_e082e650(localclientnum, item, newmodel, scale) {
  if(newmodel === self.model) {
    if(!isDefined(item) && self.weapon == level.weaponnone) {
      return;
    }
  }

  function_2990e5f(localclientnum, item);
  function_3ee12d25(localclientnum, self);

  if(isDefined(newmodel)) {
    if(!self _set_weapon(localclientnum, item) || isDefined(item.itementry.model)) {
      self setModel(newmodel);
    }

    self setscale(scale);
  }
}

private function_96fa1c6d(localclientnum) {
  clientdata = function_a7e98a1a(localclientnum);

  if(isDefined(clientdata.drawing) && clientdata.drawing) {
    return false;
  }

  if(!isDefined(clientdata.var_844c8166)) {
    return true;
  }

  if(function_1cbf351b(localclientnum)) {
    return true;
  }

  servertime = getservertime(localclientnum);

  if(servertime < clientdata.var_79b15dd1) {
    return true;
  }

  var_605384fe = function_8cf40a8c(localclientnum);
  var_48f611aa = distancesquared(clientdata.var_844c8166, var_605384fe);

  if(var_48f611aa >= 72 * 72) {
    return true;
  }

  if(isDefined(self.var_5f6ea063) && self.var_5f6ea063 || isDefined(self.var_506495f9) && self.var_506495f9) {
    return true;
  }

  return false;
}

private function_c7e5c26(localclientnum) {
  clientdata = function_a7e98a1a(localclientnum);

  if(isDefined(clientdata.var_a4ad122e) && clientdata.var_a4ad122e) {
    return false;
  }

  return true;
}

private function_34418003(localclientnum, eyepos, angles) {
  clientdata = function_a7e98a1a(localclientnum);

  if(isDefined(clientdata.var_ff9e7e43) && clientdata.var_ff9e7e43) {
    clientdata.var_ff9e7e43 = 0;
    return true;
  }

  return false;
}

private function_5cbe24ea(&dest, &source, &order) {
  items = [];

  foreach(item in source) {
    if(!isDefined(item)) {
      continue;
    }

    itemname = item.itementry.name;

    if(!isDefined(items[itemname])) {
      items[itemname] = [];
    }

    size = items[itemname].size;
    items[itemname][size] = item;
  }

  foreach(itemname in order) {
    if(isDefined(items[itemname])) {
      foreach(item in items[itemname]) {
        dest[dest.size] = item;
      }
    }

    items[itemname] = undefined;
  }

  foreach(itemarray in items) {
    if(!isDefined(itemarray)) {
      continue;
    }

    foreach(item in itemarray) {
      if(!isDefined(item)) {
        continue;
      }

      dest[dest.size] = item;
    }
  }
}

private function_43d3ebe1(&items) {
  assert(isplayer(self));

  if(items.size <= 1) {
    return items;
  }

  arrayremovevalue(items, undefined, 0);
  sorted = [];
  itemtypes = [];
  stash = item_world_util::function_31f5aa51(items[0]);
  var_e30063d2 = isDefined(stash) && isDefined(stash.lootlocker) && stash.lootlocker;

  if(var_e30063d2) {
    lootweapons = self item_inventory_util::get_loot_weapons();

    if(lootweapons.size > 0) {
      var_41f13734 = lootweapons[0];

      for(index = 0; index < items.size; index++) {
        item = items[index];

        if(!isDefined(items[index].itementry) || !isDefined(items[index].itementry.weapon)) {
          continue;
        }

        if(items[index].itementry.weapon.name == var_41f13734) {
          var_dd3170c7 = sorted.size;
          sorted[var_dd3170c7] = items[index];
          sorted[var_dd3170c7].var_41f13734 = 1;
          arrayremoveindex(items, index, 0);
          break;
        }
      }
    }
  }

  for(index = 0; index < items.size; index++) {
    if(!isDefined(items[index])) {
      continue;
    }

    itementry = items[index].itementry;

    if(!isDefined(itemtypes[itementry.itemtype])) {
      itemtypes[itementry.itemtype] = [];
    }

    size = itemtypes[itementry.itemtype].size;
    itemtypes[itementry.itemtype][size] = items[index];
  }

  waitframe(1);

  if(isDefined(itemtypes[#"quest"])) {
    foreach(entry in itemtypes[#"quest"]) {
      sorted[sorted.size] = entry;
    }
  }

  if(isDefined(itemtypes[#"cash"])) {
    foreach(entry in itemtypes[#"cash"]) {
      sorted[sorted.size] = entry;
    }
  }

  if(isDefined(itemtypes[#"armor"])) {
    function_5cbe24ea(sorted, itemtypes[#"armor"], level.var_69ee9282);
    waitframe(1);
  }

  if(isDefined(itemtypes[#"armor_shard"])) {
    foreach(entry in itemtypes[#"armor_shard"]) {
      sorted[sorted.size] = entry;
    }
  }

  if(isDefined(itemtypes[#"weapon"])) {
    var_610b8743 = [];

    foreach(item in itemtypes[#"weapon"]) {
      if(!isDefined(item)) {
        continue;
      }

      if(item.itementry.rarity == #"epic") {
        var_610b8743[var_610b8743.size] = item;
      }
    }

    if(isDefined(var_610b8743)) {
      function_5cbe24ea(sorted, var_610b8743, level.var_e93e16b);
      waitframe(1);
    }
  }

  if(isDefined(itemtypes[#"weapon"])) {
    weapons = [];

    foreach(item in itemtypes[#"weapon"]) {
      if(!isDefined(item)) {
        continue;
      }

      if(item.itementry.rarity != #"epic") {
        weapons[weapons.size] = item;
      }
    }

    if(isDefined(weapons)) {
      function_5cbe24ea(sorted, weapons, level.var_b9917a92);
      waitframe(1);
    }
  }

  if(isDefined(itemtypes[#"health"])) {
    function_5cbe24ea(sorted, itemtypes[#"health"], level.var_9bc8c1bc);
    waitframe(1);
  }

  if(isDefined(itemtypes[#"backpack"])) {
    foreach(entry in itemtypes[#"backpack"]) {
      sorted[sorted.size] = entry;
    }
  }

  if(isDefined(itemtypes[#"attachment"])) {
    function_5cbe24ea(sorted, itemtypes[#"attachment"], level.var_6cb314b1);
    waitframe(1);
  }

  if(isDefined(itemtypes[#"killstreak"])) {
    foreach(entry in itemtypes[#"killstreak"]) {
      sorted[sorted.size] = entry;
    }
  }

  if(isDefined(itemtypes[#"equipment"])) {
    function_5cbe24ea(sorted, itemtypes[#"equipment"], level.var_3fd5d8f0);
    waitframe(1);
  }

  if(isDefined(itemtypes[#"generic"])) {
    function_5cbe24ea(sorted, itemtypes[#"generic"], level.var_683c7e30);
    waitframe(1);
  }

  if(isDefined(itemtypes[#"ammo"])) {
    function_5cbe24ea(sorted, itemtypes[#"ammo"], level.var_418d51ad);
    waitframe(1);
  }

  if(isDefined(itemtypes[#"resource"])) {
    foreach(entry in itemtypes[#"resource"]) {
      sorted[sorted.size] = entry;
    }
  }

  return sorted;
}

private function_b21002cb(localclientnum, objid, obj, objstate) {
  if(obj.type === "scriptmover" || obj.type === "missile") {
    objective_onentity(localclientnum, objid, obj, 0, 0, 0);
  } else {
    objective_clearentity(localclientnum, objid);
    objective_setposition(localclientnum, objid, obj.origin);
  }

  objective_setgamemodeflags(localclientnum, objid, objstate);
  objective_setstate(localclientnum, objid, "active");
}

private function_c3f5f99b(localclientnum, objid, obj) {
  objective_setstate(localclientnum, objid, "invisible");
  objective_setgamemodeflags(localclientnum, objid, 0);

  if(isDefined(obj)) {
    if(obj.type === "scriptmover" || obj.type === "missile") {
      objective_onentity(localclientnum, objid, obj, 0, 0, 0);
      return;
    }

    objective_clearentity(localclientnum, objid);
    objective_setposition(localclientnum, objid, obj.origin);
  }
}

private function_b0af857f(localclientnum) {
  self endon(#"death");
  clientdata = function_a7e98a1a(localclientnum);
  clientdata.var_a4ad122e = 1;
  var_da43934d = self function_da43934d();

  if(var_da43934d) {
    if(!self inlaststand() && !self clientfield::get_to_player("disableItemPickup")) {
      eyepos = getlocalclienteyepos(localclientnum);
      angles = getlocalclientangles(localclientnum);
      maxdist = undefined;
      var_512ddf16 = self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2;

      if(var_512ddf16) {
        maxdist = 128;
      } else {
        model = getuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.multiItemPickup.currentSelection"));

        if(isDefined(model)) {
          uimodel = createuimodel(model, "id");

          if(isDefined(uimodel)) {
            itemid = getuimodelvalue(uimodel);

            if(isDefined(itemid) && itemid != 32767) {
              setuimodelvalue(createuimodel(model, "id"), 32767);
            }
          }
        }
      }

      self.var_54d9f4a6 = 0;

      if(var_512ddf16) {
        self.var_9b882d22 = undefined;
        self.var_cdaade8c = undefined;
        model = getuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.multiItemPickup.currentSelection"));

        if(isDefined(model)) {
          uimodel = createuimodel(model, "id");

          if(isDefined(uimodel)) {
            itemid = getuimodelvalue(uimodel);

            if(isDefined(itemid) && itemid != 32767) {
              if(item_world_util::function_2c7fc531(itemid)) {
                self.var_9b882d22 = function_b1702735(itemid);
              } else if(item_world_util::function_da09de95(itemid)) {
                if(isDefined(level.item_spawn_drops[itemid])) {
                  self.var_9b882d22 = level.item_spawn_drops[itemid];
                }
              }

              if(isDefined(self.var_9b882d22)) {
                self.var_9b882d22.var_5d97fed1 = self.var_9b882d22.hidetime === -1;
              }
            }
          }
        }

        if(!isDefined(self.var_9b882d22)) {
          self.var_54d9f4a6 = 1;

          foreach(item in clientdata.groupitems) {
            if(self item_world_util::can_pick_up(item)) {
              self.var_9b882d22 = item;
              self.var_9b882d22.var_5d97fed1 = self.var_9b882d22.hidetime === -1;
              break;
            }
          }
        }
      }

      if(!var_512ddf16 || !isDefined(self.var_9b882d22)) {
        self.var_9b882d22 = function_94db1536(localclientnum, eyepos, angles, maxdist);

        if(isDefined(self.var_9b882d22)) {
          self.var_cdaade8c = self.var_9b882d22.origin;
        }
      }
    } else {
      self.var_9b882d22 = undefined;
    }

    function_802915bc(localclientnum);
  }

  if(isDefined(self.disableitempickup) && self.disableitempickup) {
    self.var_9b882d22 = undefined;
  }

  clientdata.var_a4ad122e = 0;
}

private function_802915bc(localclientnum) {
  if(!isDefined(level.var_62c91473) || !isDefined(level.var_62c91473[localclientnum])) {
    return;
  }

  eyepos = getlocalclienteyepos(localclientnum);

  if(isDefined(self.var_9b882d22) && self.var_9b882d22.var_5d97fed1) {
    var_1ba7b9c8 = arraysortclosest(level.var_624588d5, self.var_9b882d22.origin, 1, 0, 12);
    hinttext = #"wz/supply_stash";

    if(var_1ba7b9c8.size > 0) {
      isdeathstash = var_1ba7b9c8[0].stash_type === 2;
      hinttext = isdeathstash ? #"wz/death_stash" : #"wz/supply_drop";
    } else {
      var_1ba7b9c8 = arraysortclosest(level.item_spawn_stashes, self.var_9b882d22.origin, 1, 0, 12);

      if(var_1ba7b9c8.size > 0 && isDefined(var_1ba7b9c8[0].displayname)) {
        hinttext = var_1ba7b9c8[0].displayname;
      }
    }

    setuimodelvalue(level.var_62c91473[localclientnum], hinttext);
    return;
  }

  if(!isDefined(self.var_9b882d22) || distance2dsquared(self.var_9b882d22.origin, eyepos) > 128 * 128) {
    angles = getlocalclientangles(localclientnum);
    vehicle = item_world_util::function_6af455de(localclientnum, eyepos, angles);
    hintstring = item_world_util::function_c62ad9a7(vehicle);
    setuimodelvalue(level.var_62c91473[localclientnum], hintstring);
    return;
  }

  setuimodelvalue(level.var_62c91473[localclientnum], #"");
}

private function_eb396946(localclientnum) {
  if(isDefined(self)) {
    var_f4b807cb = function_2e3efdda(self.origin, undefined, level.var_c102677c, 256, -1, 0);

    if(!isDefined(var_f4b807cb) || !var_f4b807cb.size) {
      return;
    }

    nearbyweapons = [];
    var_d61d8afa = [];

    for(index = 0; index < var_f4b807cb.size; index++) {
      item = var_f4b807cb[index];

      if(!isDefined(item)) {
        continue;
      }

      if(isDefined(item.itementry)) {
        if(item.itementry.itemtype == #"weapon") {
          if(isDefined(item.weapon) && item.weapon != level.weaponnone && item.weapon !== item.itementry.weapon) {
            camoweapon = activecamo::function_385ef18d(item.weapon);
            weaponoptions = self getbuildkitweaponoptions(localclientnum, camoweapon);
            streamweapon = item.weapon;
            forcestreamweaponrenderoptions(localclientnum, streamweapon, weaponoptions);
            nearbyweapons[streamweapon] = weaponoptions;
          } else if(isDefined(item.itementry.weapon) && item.itementry.weapon != level.weaponnone) {
            camoweapon = activecamo::function_385ef18d(item.itementry.weapon);
            weaponoptions = self getbuildkitweaponoptions(localclientnum, camoweapon);
            streamweapon = item_inventory_util::function_2b83d3ff(item);
            forcestreamweaponrenderoptions(localclientnum, streamweapon, weaponoptions);
            nearbyweapons[streamweapon] = weaponoptions;
          }

          continue;
        }

        if(item.itementry.itemtype == #"attachment") {
          if(isDefined(item.itementry.attachments)) {
            foreach(attachment in item.itementry.attachments) {
              if(isDefined(attachment.attachment_type)) {
                var_d61d8afa[attachment.attachment_type] = attachment.attachment_type;
              }
            }
          }
        }
      }
    }

    currentweapon = self function_d2c2b168();

    if(isDefined(currentweapon) && currentweapon != level.weaponnone && currentweapon != level.weaponbasemeleeheld) {
      foreach(attachment in var_d61d8afa) {
        if(!weaponhasattachment(currentweapon, attachment)) {
          weaponoptions = self function_e10e6c37();
          streamweapon = getweapon(currentweapon.rootweapon.name, attachment);

          if(isDefined(streamweapon) && weaponhasattachment(streamweapon, attachment)) {
            forcestreamweaponrenderoptions(localclientnum, streamweapon, weaponoptions);
          }
        }
      }

      if(nearbyweapons.size) {
        var_1bf1ce1 = getweaponattachments(currentweapon);

        if(isDefined(var_1bf1ce1) && var_1bf1ce1.size) {
          foreach(key, weaponoptions in nearbyweapons) {
            nearbyweapon = weapon(key);

            if(nearbyweapon.rootweapon != currentweapon.rootweapon) {
              foreach(attachment in var_1bf1ce1) {
                if(attachment !== "null" && !weaponhasattachment(nearbyweapon, attachment)) {
                  streamweapon = getweapon(nearbyweapon.name, attachment);

                  if(isDefined(streamweapon) && streamweapon != nearbyweapon && weaponhasattachment(streamweapon, attachment)) {
                    forcestreamweaponrenderoptions(localclientnum, streamweapon, weaponoptions);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

private function_48ec057f(localclientnum) {
  clientdata = function_a7e98a1a(localclientnum);

  if(!isDefined(clientdata)) {
    return;
  }

  var_f1530a67 = getservertime(localclientnum, 1);
  var_bea3e246 = [];

  foreach(networkid, serverinfo in clientdata.var_ffc1c0e1) {
    model = function_61f5d33a(localclientnum, clientdata, networkid);

    if(isDefined(model)) {
      function_a4886b1e(localclientnum, networkid, model);
    }

    if(serverinfo.servertime >= var_f1530a67) {
      var_bea3e246[networkid] = serverinfo;
    }
  }

  clientdata.var_ffc1c0e1 = var_bea3e246;
  var_bf2d48f6 = [];

  foreach(vehicleentnum, serverinfo in clientdata.var_baf65690) {
    vehicle = getentbynum(localclientnum, vehicleentnum);

    if(isDefined(vehicle) && serverinfo.servertime >= var_f1530a67 && !isvehicleoccupied(localclientnum, vehicle)) {
      var_bf2d48f6[vehicleentnum] = serverinfo;
      function_3bd99d2f(localclientnum, clientdata, vehicle);
      continue;
    }

    function_3bd99d2f(localclientnum, clientdata, vehicle, 1);
  }

  clientdata.var_baf65690 = var_bf2d48f6;
}

private _update_loop(localclientnum) {
  self endon(#"shutdown");
  self notify("787a164bb0bf6bcf");
  self endon("787a164bb0bf6bcf");
  waitframe(1);
  function_1b11e73c();

  while(isDefined(self) && isplayer(self)) {
    if(function_96fa1c6d(localclientnum)) {
      draworigin = function_8cf40a8c(localclientnum);
      self thread _draw(localclientnum, draworigin);
    }

    function_48ec057f(localclientnum);
    function_eb396946(localclientnum);

    if(isalive(self)) {
      if(function_c7e5c26(localclientnum)) {
        self thread function_b0af857f(localclientnum);
      }

      function_48ca0bbb(localclientnum);
    }

    waitframe(1);
  }
}

private function_48ca0bbb(localclientnum) {
  var_da43934d = self function_da43934d();

  if(var_da43934d) {
    eyepos = getlocalclienteyepos(localclientnum);
    angles = getlocalclientangles(localclientnum);

    if(isDefined(self.var_9b882d22) && isDefined(self.var_9b882d22.itementry) && !isDefined(getplayervehicle(self))) {
      itementry = self.var_9b882d22.itementry;
      var_77055f15 = 0;
      var_fa3df96 = undefined;

      if(itementry.itemtype == #"ammo" && !item_inventory::can_pickup_ammo(localclientnum, self.var_9b882d22)) {
        var_77055f15 = 64;
      } else if(item_inventory::function_a243ddd6(localclientnum, itementry)) {
        var_77055f15 = 1;

        if(itementry.itemtype == #"attachment") {
          var_77055f15 = 1;

          if(item_inventory::function_ad4c6116(localclientnum, itementry)) {
            var_77055f15 |= 32;
          }
        } else if(itementry.itemtype == #"weapon") {
          var_a4250c2b = self item_inventory::function_d768ea30(localclientnum);

          if(item_inventory_util::function_4bd83c04(self.var_9b882d22) && self item_inventory::has_attachments(localclientnum, var_a4250c2b)) {
            var_77055f15 |= 512;
          }
        }
      } else if(itementry.itemtype == #"weapon") {
        var_77055f15 = 2;
        var_a4250c2b = self item_inventory::function_d768ea30(localclientnum);

        if(item_inventory_util::function_4bd83c04(self.var_9b882d22) && self item_inventory::has_attachments(localclientnum, var_a4250c2b)) {
          var_77055f15 |= 512;
        }
      } else {
        var_fa3df96 = self item_inventory::function_78ed4455(localclientnum, itementry);

        if(isDefined(var_fa3df96)) {
          var_77055f15 = 2;

          if(itementry.itemtype == #"attachment") {
            var_fa3df96 = undefined;

            if(item_inventory::function_ad4c6116(localclientnum, itementry)) {
              var_77055f15 |= 32;
            }
          }
        } else if(!item_inventory::function_ad4c6116(localclientnum, itementry)) {
          if(itementry.itemtype == #"resource" && item_world_util::function_41f06d9d(itementry)) {
            var_77055f15 = 128;
          } else {
            var_77055f15 = 4;
          }

          if(itementry.itemtype == #"equipment" || itementry.itemtype == #"health") {
            var_77055f15 |= 1024;
          }
        } else if(itementry.itemtype == #"equipment" || itementry.itemtype == #"health") {
          if(item_inventory::function_ad4c6116(localclientnum, itementry)) {
            var_77055f15 |= 256;
          }
        }
      }

      objstate = 0;

      if(isDefined(self.var_9b882d22.isfar) && self.var_9b882d22.isfar) {
        objstate = 1;
      }

      pickupicon = isDefined(itementry.pickupicon) ? itementry.pickupicon : itementry.icon;

      if(self.var_54d9f4a6) {
        var_77055f15 = 16;
      }

      setuimodelvalue(level.var_7e2f5883[localclientnum], isDefined(var_fa3df96) ? var_fa3df96 : -1);
      setuimodelvalue(level.var_ce95aace[localclientnum], var_77055f15);
      setuimodelvalue(level.var_19cf0be9[localclientnum], isDefined(pickupicon) ? pickupicon : #"blacktransparent");

      if(self.var_9b882d22.var_5d97fed1) {
        function_b21002cb(localclientnum, level.var_383edf80, self.var_9b882d22, objstate);
        function_c3f5f99b(localclientnum, level.var_d9beffb9);
      } else if(self item_world_util::can_pick_up(self.var_9b882d22)) {
        hintstring = self function_2fc74639();
        var_d1fce876 = #"";

        if(isDefined(itementry.weapon)) {
          var_d1fce876 = itementry.weapon.displayname;
        } else {
          var_d1fce876 = isDefined(itementry.hintstring) ? itementry.hintstring : #"";
        }

        if(var_d1fce876 == hintstring) {
          function_b21002cb(localclientnum, level.var_d9beffb9, self.var_9b882d22, objstate);
          function_c3f5f99b(localclientnum, level.var_383edf80);
        } else {
          if(!(isDefined(self.var_9b882d22.isclose) && self.var_9b882d22.isclose)) {
            function_b21002cb(localclientnum, level.var_d9beffb9, self.var_9b882d22, objstate);
          } else {
            function_c3f5f99b(localclientnum, level.var_d9beffb9, self.var_9b882d22);
          }

          function_c3f5f99b(localclientnum, level.var_383edf80, self.var_9b882d22);
        }
      }
    } else {
      setuimodelvalue(level.var_19cf0be9[localclientnum], #"blacktransparent");
      function_c3f5f99b(localclientnum, level.var_d9beffb9);
      function_c3f5f99b(localclientnum, level.var_383edf80);
    }

    if(self function_34418003(localclientnum, eyepos, angles)) {
      self function_7c84312d(localclientnum, eyepos, angles);
    }
  }
}

private function_94db1536(localclientnum, origin, angles, maxdist = undefined) {
  assert(isplayer(self));
  clientdata = function_a7e98a1a(localclientnum);
  forward = vectornormalize(anglesToForward(angles));

  if(!isDefined(maxdist)) {
    maxdist = util::function_16fb0a3b();
  }

  var_f4b807cb = function_2e3efdda(origin, forward, 128, maxdist, 0);
  var_4bd72bfe = function_ab88dbd2(localclientnum, #"warzoneprioritypickups");
  var_9b882d22 = item_world_util::function_6061a15(var_f4b807cb, maxdist, origin, angles, forward, var_4bd72bfe, 1);
  return var_9b882d22;
}

private function_c5b6693a() {
  item = spawnStruct();
  item.amount = 0;
  item.count = 0;
  item.id = 32767;
  item.networkid = 32767;
  item.itementry = undefined;
  item.var_627c698b = undefined;
  return item;
}

private function_7c84312d(localclientnum, origin, angles) {
  assert(isplayer(self));
  clientdata = function_a7e98a1a(localclientnum);

  while(isDefined(clientdata.var_a4ad122e) && clientdata.var_a4ad122e) {
    waitframe(1);
  }

  if(isDefined(self.var_9b882d22)) {
    var_433d429 = 14;
    groupitems = function_2e3efdda(self.var_9b882d22.origin, undefined, 128, var_433d429, undefined, 1);
    groupitems = self function_43d3ebe1(groupitems);

    if(!isDefined(self)) {
      return;
    }

    arrayremovevalue(groupitems, undefined, 0);
    clientdata.groupitems = function_83e328e1(clientdata.groupitems, groupitems);
  } else {
    clientdata.groupitems = [];
  }

  self item_inventory::function_9116bb0e(localclientnum);
}

private function_83e328e1(var_78ddf4e2, newitems) {
  if(!isDefined(var_78ddf4e2)) {
    return newitems;
  }

  items = [];
  emptycount = 0;
  newcount = 0;
  var_21198c86 = [];

  foreach(newitem in newitems) {
    if(!isDefined(newitem)) {
      continue;
    }

    var_f613370d = newitem;

    if(isstruct(var_f613370d) && item_world_util::function_2c7fc531(var_f613370d.networkid)) {
      var_f613370d = function_b1702735(var_f613370d.networkid);
    }

    if(self item_world_util::can_pick_up(var_f613370d)) {
      var_21198c86[var_21198c86.size] = var_f613370d;
    }
  }

  foreach(var_319b917b in var_78ddf4e2) {
    var_f59eabca = var_319b917b;

    if(isstruct(var_f59eabca) && item_world_util::function_2c7fc531(var_f59eabca.networkid)) {
      var_f59eabca = function_b1702735(var_f59eabca.networkid);
    }

    if(!isDefined(var_f59eabca) || !self item_world_util::can_pick_up(var_f59eabca)) {
      emptycount++;
      items[items.size] = function_c5b6693a();
      continue;
    }

    foreach(newitem in var_21198c86) {
      if(newitem.networkid == var_f59eabca.networkid) {
        newcount++;
        items[items.size] = newitem;
      }
    }
  }

  if(var_21198c86.size == newcount && var_78ddf4e2.size == newcount + emptycount) {
    return items;
  }

  return newitems;
}

private function_1b42632a(localclientnum, clientdata, var_2ccf7a1c) {
  var_f0a9e97d = undefined;
  var_e7349b30 = undefined;

  foreach(var_7d6cdf6f, serverinfo in clientdata.var_ffc1c0e1) {
    if(serverinfo.var_2ccf7a1c == var_2ccf7a1c) {
      var_f0a9e97d = var_7d6cdf6f;
      var_e7349b30 = serverinfo;
      break;
    }
  }

  if(isDefined(var_f0a9e97d)) {
    clientdata.var_ffc1c0e1[var_f0a9e97d] = undefined;
    model = function_61f5d33a(localclientnum, clientdata, var_f0a9e97d);

    if(isDefined(model)) {
      function_a4886b1e(localclientnum, var_f0a9e97d, model);
    }
  }

  var_cd3b74d6 = undefined;
  var_e7349b30 = undefined;

  foreach(vehicleentnum, serverinfo in clientdata.var_baf65690) {
    if(serverinfo.var_2ccf7a1c == var_2ccf7a1c) {
      var_cd3b74d6 = vehicleentnum;
      var_e7349b30 = serverinfo;
      break;
    }
  }

  if(isDefined(var_cd3b74d6)) {
    clientdata.var_baf65690[var_cd3b74d6] = undefined;
    vehicle = getentbynum(localclientnum, var_cd3b74d6);

    if(isDefined(vehicle)) {
      function_3bd99d2f(localclientnum, clientdata, vehicle, 1);
    }
  }
}

function_347698a5(localclientnum, networkid, var_2ccf7a1c) {
  clientdata = function_a7e98a1a(localclientnum);
  function_1b42632a(localclientnum, clientdata, var_2ccf7a1c);
  endtime = getservertime(localclientnum, 1) + 60000;
  clientdata.var_ffc1c0e1[networkid] = {
    #servertime: endtime, 
    #var_2ccf7a1c: var_2ccf7a1c
  };
  model = function_61f5d33a(localclientnum, clientdata, networkid);

  if(isDefined(model)) {
    function_a4886b1e(localclientnum, networkid, model);
  }
}

function_d2f95c1a(localclientnum, vehicleentnum, var_2ccf7a1c) {
  clientdata = function_a7e98a1a(localclientnum);
  function_1b42632a(localclientnum, clientdata, var_2ccf7a1c);
  endtime = getservertime(localclientnum, 1) + 60000;
  clientdata.var_baf65690[vehicleentnum] = {
    #servertime: endtime, 
    #var_2ccf7a1c: var_2ccf7a1c
  };
  vehicle = getentbynum(localclientnum, vehicleentnum);
  function_d223645e(localclientnum, vehicle);
}

function_a7e98a1a(localclientnum) {
  return level.var_d342a3fd[localclientnum];
}

function_963d3f6e() {
  var_6e75b345 = 1350;

  if(isDefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle")) {
    var_6e75b345 = 900;
  }

  if(issplitscreen()) {
    var_6e75b345 = int(var_6e75b345 * 0.7);
  }

  return var_6e75b345;
}

function_73436347(itemgroup, networkid) {
  assert(isarray(itemgroup));
  assert(isint(networkid));

  for(index = 0; index < itemgroup.size; index++) {
    item = itemgroup[index];

    if(isDefined(item) && item.networkid === networkid) {
      return index;
    }
  }

  return undefined;
}

function_d223645e(localclientnum, vehicle) {
  assert(isDefined(vehicle));

  if(!isDefined(vehicle) || !isvehicleoccupied(localclientnum, vehicle)) {
    return;
  }

  clientdata = function_a7e98a1a(localclientnum);
  function_3bd99d2f(localclientnum, clientdata, vehicle);
}

function_a4886b1e(localclientnum, networkid, model) {
  assert(isDefined(model));

  if(!isDefined(model)) {
    return;
  }

  draworigin = function_8cf40a8c(localclientnum);
  maxdist = getdvarfloat(#"hash_2cd1a08f81049564", function_963d3f6e());
  clientdata = function_a7e98a1a(localclientnum);

  if(isDefined(model.var_5d97fed1) && model.var_5d97fed1 || model.hidetime === -1) {
    stash = function_c17fe536(localclientnum, clientdata, networkid);
    function_78bf134c(localclientnum, clientdata, networkid, stash);
    return;
  }

  if(distancesquared(draworigin, model.origin) <= maxdist * maxdist) {
    itementry = undefined;

    if(isDefined(networkid)) {
      if(item_world_util::function_2c7fc531(networkid)) {
        itementry = function_b1702735(networkid).itementry;
      } else if(item_world_util::function_da09de95(networkid)) {
        if(isDefined(level.item_spawn_drops[networkid])) {
          itementry = level.item_spawn_drops[networkid].itementry;
        }
      }
    }

    function_78bf134c(localclientnum, clientdata, networkid, model, itementry);
  }
}

play_spawn_fx(localclientnum, networkid) {
  if(!isDefined(networkid)) {
    return;
  }

  item = undefined;

  if(item_world_util::function_2c7fc531(networkid)) {
    item = function_b1702735(networkid);
  } else if(item_world_util::function_da09de95(networkid)) {
    if(isDefined(level.item_spawn_drops[networkid])) {
      item = level.item_spawn_drops[networkid];
    }
  }

  if(!isDefined(item) || !isDefined(item.itementry) || !isDefined(item.itementry.worldspawnfx)) {
    return;
  }

  itementry = item.itementry;
  originoffset = function_7571fda9(item);
  angles = function_118d052e(item);
  forward = anglesToForward(angles);
  up = anglestoup(angles);
  playFX(localclientnum, itementry.worldspawnfx, item.origin + originoffset, forward, up);
}

play_pickup_fx(localclientnum, item) {
  if(!isDefined(item) || !isDefined(item.itementry) || !isDefined(item.itementry.var_37cd55af)) {
    return;
  }

  itementry = item.itementry;
  originoffset = function_7571fda9(item);
  angles = function_118d052e(item);
  forward = anglesToForward(angles);
  up = anglestoup(angles);
  playFX(localclientnum, itementry.var_37cd55af, item.origin + originoffset, forward, up);
}

function_7571fda9(item) {
  if(!isDefined(item) || !isDefined(item.itementry)) {
    return (0, 0, 0);
  }

  itementry = item.itementry;
  originoffset = (isDefined(itementry.var_5dc4470b) ? itementry.var_5dc4470b : 0, isDefined(itementry.var_54a3b4ca) ? itementry.var_54a3b4ca : 0, isDefined(itementry.var_3e688854) ? itementry.var_3e688854 : 0);
  originoffset = rotatepoint(originoffset * -1, item.angles);
  return originoffset;
}

function_118d052e(item) {
  if(!isDefined(item)) {
    return (0, 0, 0);
  }

  itementry = item.itementry;

  if(!isDefined(item.itementry)) {
    return item.angles;
  }

  angles = combineangles(item.angles, (isDefined(itementry.var_15b88fde) ? itementry.var_15b88fde : 0, isDefined(itementry.var_8c9a7dc8) ? itementry.var_8c9a7dc8 : 0, isDefined(itementry.var_7a51d937) ? itementry.var_7a51d937 : 0));
  return angles;
}

function_28b42f1c(localclientnum, networkid) {
  if(item_world_util::function_d9648161(networkid)) {
    if(item_world_util::function_2c7fc531(networkid)) {
      return networkid;
    } else if(item_world_util::function_da09de95(networkid)) {
      if(isDefined(level.item_spawn_drops[networkid])) {
        return level.item_spawn_drops[networkid].id;
      }
    } else {
      return item_inventory::function_c48cd17f(localclientnum, networkid);
    }
  }

  return 32767;
}

get_item_name(item) {
  if(isDefined(item.weapon)) {
    if(item.weapon.displayname != #"") {
      return item.weapon.displayname;
    }
  }

  return isDefined(item.displayname) ? item.displayname : #"";
}

function_2e3efdda(origin, dir, maxitems, maxdistance, dot, var_653b55e5 = 0) {
  var_f4b807cb = function_abaeb170(origin, dir, maxitems, maxdistance, dot, 1, -2147483647);
  var_6665e24 = arraysortclosest(level.item_spawn_drops, origin, maxitems, 0, maxdistance);
  var_f4b807cb = arraycombine(var_f4b807cb, var_6665e24, 1, 0);
  var_f4b807cb = arraysortclosest(var_f4b807cb, origin, maxitems, 0, maxdistance);

  if(var_653b55e5) {
    stashitems = [];

    for(index = 0; index < var_f4b807cb.size; index++) {
      if(var_f4b807cb[index].hidetime === -1) {
        stashitems[stashitems.size] = var_f4b807cb[index];
      }
    }

    var_f4b807cb = stashitems;
  }

  return var_f4b807cb;
}

hide_item(localclientnum, networkid) {
  if(item_world_util::function_2c7fc531(networkid)) {
    if(isDefined(level.var_5b2a8d88) && isDefined(level.var_5b2a8d88[networkid])) {
      level.var_5b2a8d88[networkid] = 0;
    }

    if(function_54ca5536(networkid, getservertime(0, 1)) == 0) {
      return;
    }
  }

  clientdata = function_a7e98a1a(localclientnum);

  if(isDefined(clientdata)) {
    if(isDefined(clientdata.modellist[networkid])) {
      clientdata.modellist[networkid] hide();
      clientdata.modellist[networkid * -1] = clientdata.modellist[networkid];
      arrayremoveindex(clientdata.modellist, networkid, 1);
      function_2990e5f(localclientnum, clientdata.modellist[networkid]);
    }

    if(isDefined(clientdata.var_89e328b4) && isDefined(clientdata.var_89e328b4[networkid])) {
      clientdata.var_89e328b4[networkid] hide();
      clientdata.var_89e328b4[networkid * -1] = clientdata.var_89e328b4[networkid];
      arrayremoveindex(clientdata.var_89e328b4, networkid, 1);
      function_2990e5f(localclientnum, clientdata.var_89e328b4[networkid]);
    }

    if(isarray(clientdata.groupitems)) {
      foreach(item in clientdata.groupitems) {
        if(isDefined(item) && item.networkid === networkid) {
          if(isstruct(item)) {
            item.hidetime = gettime();
          }

          break;
        }
      }
    }
  }
}

show_item(localclientnum, networkid, showitem) {
  item = undefined;

  if(item_world_util::function_2c7fc531(networkid)) {
    if(isDefined(level.var_5b2a8d88) && isDefined(level.var_5b2a8d88[networkid])) {
      level.var_5b2a8d88[networkid] = 1;
    }

    function_54ca5536(networkid, showitem ? 0 : -1);
    player = function_5c10bd79(localclientnum);
    item = function_b1702735(networkid);
    var_6369afab = function_963d3f6e();

    if(isplayer(player) && distance2dsquared(item.origin, player.origin) <= var_6369afab * var_6369afab) {
      player.var_506495f9 = 1;
    }
  } else {
    item = level.item_spawn_drops[networkid];
  }

  clientdata = function_a7e98a1a(localclientnum);

  if(isDefined(clientdata) && isDefined(item)) {
    if(isDefined(clientdata.modellist[networkid])) {
      clientdata.modellist[networkid] show();
      function_78bf134c(localclientnum, clientdata, networkid, clientdata.modellist[networkid], item.itementry);
    }

    if(isDefined(clientdata.var_89e328b4) && isDefined(clientdata.var_89e328b4[networkid])) {
      clientdata.var_89e328b4[networkid] show();
      function_78bf134c(localclientnum, clientdata, networkid, clientdata.var_89e328b4[networkid], item.itementry);
    }
  }
}

function_b78a9820(localclientnum) {
  clientdata = function_a7e98a1a(localclientnum);
  clientdata.var_ff9e7e43 = 1;
}

function_1b11e73c() {
  reset = isDefined(level flagsys::get(#"item_world_reset")) && level flagsys::get(#"item_world_reset");
  level flagsys::wait_till(#"item_world_initialized");

  if(reset != (isDefined(level flagsys::get(#"item_world_reset")) && level flagsys::get(#"item_world_reset"))) {
    return false;
  }

  return true;
}

function_4de3ca98() {
  level flagsys::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
  level flagsys::wait_till(#"item_world_reset");
  level flagsys::wait_till(#"item_world_initialized");
}