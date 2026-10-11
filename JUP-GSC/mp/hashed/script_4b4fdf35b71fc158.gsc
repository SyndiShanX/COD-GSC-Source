/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4b4fdf35b71fc158.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#namespace namespace_c8f50c27f5dd5ed8;

function function_b60c68caa2f279ab() {
  common_item::function_900f562c61c6a5d6("currency", &use_currency, &function_794ffcdb7828ea7a, &function_794ffcdb7828ea7a, &get_currency, &remove_currency, &drop_currency);
  level.var_d9f04e5f1fe187c8 = getdvarint(@ "hash_d6c1c3a63fffaa05", 4000);
  level.var_fc4c0fbec2dbd28c = getdvarint(@ "hash_92f1f3fc3fa4338f", 499);

  if(getdvarint(@ "hash_ee227f9b528f4b62", 1)) {
    level.commonitem.var_48c807bcc0ab526 = [];
    level.commonitem.var_e4c2d4cb4855b6fe = [];
    common_item::function_5958815b72ad58a0("currency", #"hash_79cd484b40e882b", &function_32e0e65cc21dd2fe);
    callback::add("player_vehicle_enter", &function_3bc86b6f6e18eea7);
    callback::add("player_vehicle_exit", &function_aba001929fc2df47);
  }
}

function function_32e0e65cc21dd2fe(itembundlename) {
  itembundle = getscriptbundlefieldvalues(hashcat(%"itemspawnentry:", itembundlename), [#"subtype", #"scriptable"]);

  if(isDefined(itembundle.subtype) && itembundle.subtype == "essence" && isDefined(itembundle.scriptable) && !arraycontains(level.commonitem.var_48c807bcc0ab526, itembundle.scriptable)) {
    level.commonitem.var_48c807bcc0ab526[level.commonitem.var_48c807bcc0ab526.size] = itembundle.scriptable;
  }
}

function function_794ffcdb7828ea7a(itembundle, item, auto_use, var_18fc734ec7194ede) {
  return true;
}

function use_currency(itembundle, item, auto_use) {
  currencytype = itembundle.subtype;
  currencyamount = item.count;

  if(!isDefined(currencytype) || currencytype == "" || currencytype != "essence") {
    itembundlename = common_item::function_2cdc55ba39d97d70(item.type);
    assertmsg("<dev string:x1c>" + itembundlename + "<dev string:x55>");
    return [currencyamount, 0];
  }

  if(isDefined(self.zombie_point_scalar) && !istrue(item.var_8f6468c1705602c2)) {
    currencyamount *= self.zombie_point_scalar;
  }

  reason = #"itemuse";

  if(isDefined(self.var_2fa5b49969def47)) {
    reason = #"cache";
  }

  currency::function_3036cef61495210f(currencytype, currencyamount, reason);
  return [0, currencyamount];
}

function get_currency() {
  itembundle = undefined;
  quantity = 0;
  itembundlename = common_item::function_61d960957fcf3ca0("jup_currency_essence");

  if(isDefined(itembundlename)) {
    itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
    quantity = currency::function_15975e20bbd2c824("essence");
  }

  return [itembundle, quantity];
}

function remove_currency(quantity) {
  currentquantity = currency::function_15975e20bbd2c824("essence");
  quantity = int(min(quantity, currentquantity));
  quantity = int(min(quantity, level.var_d9f04e5f1fe187c8));
  quantity = int(min(quantity, 4095));
  currency::function_a06aa3b8c98e131e("essence", quantity);
  return currentquantity - currency::function_15975e20bbd2c824("essence");
}

function drop_currency(itembundle, count, droporigin, dropangles, overridelifetime) {
  count = int(min(count, level.var_d9f04e5f1fe187c8));
  count = int(min(count, 4095));
  var_c6cf9438b9779eb3 = count > level.var_fc4c0fbec2dbd28c ? "essence_container_large" : "essence_container";
  itembundlename = common_item::function_61d960957fcf3ca0(var_c6cf9438b9779eb3);

  if(!isDefined(itembundlename)) {
    assertmsg("<dev string:xb2>" + var_c6cf9438b9779eb3 + "<dev string:xfc>");
    return;
  }

  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

  if(!isDefined(itembundle)) {
    assertmsg("<dev string:x102>" + itembundlename + "<dev string:x143>");
    return;
  }

  payload = [#"teamselect", self getentitynumber()];
  item = common_item::function_d59d110ccf0f5b8b(itembundle, count, droporigin, dropangles, 0, 0, payload, undefined, overridelifetime);
  item.var_8f6468c1705602c2 = 1;
  common_item::function_a703a4241f091edc(item, 300);
  params = spawnStruct();
  params.item = item;
  params.itembundlename = itembundlename;
  params.payload = payload;
  callback::callback("player_item_drop", params);
  return item;
}

function function_3bc86b6f6e18eea7(params) {
  if(!isPlayer(params.player)) {
    return;
  }

  var_8c7c6282b017568f = params.vehicle getentitynumber();

  if(!isDefined(level.commonitem.var_e4c2d4cb4855b6fe[var_8c7c6282b017568f])) {
    level.commonitem.var_e4c2d4cb4855b6fe[var_8c7c6282b017568f] = [];
    level thread watch_vehicle_overlap_essence(params.vehicle);
  }

  level.commonitem.var_e4c2d4cb4855b6fe[var_8c7c6282b017568f][params.player getentitynumber()] = gettime();
}

function function_aba001929fc2df47(params) {
  if(!isPlayer(params.player)) {
    return;
  }

  if(isDefined(params.newseatid)) {
    return;
  }

  var_8c7c6282b017568f = params.vehicle getentitynumber();

  if(isDefined(level.commonitem.var_e4c2d4cb4855b6fe[var_8c7c6282b017568f])) {
    level.commonitem.var_e4c2d4cb4855b6fe[var_8c7c6282b017568f][params.player getentitynumber()] = undefined;

    if(level.commonitem.var_e4c2d4cb4855b6fe[var_8c7c6282b017568f].size == 0) {
      level.commonitem.var_e4c2d4cb4855b6fe[var_8c7c6282b017568f] = undefined;
      params.vehicle notify("ob_end_watch_vehicle_overlap_essence");
    }
  }
}

function watch_vehicle_overlap_essence(vehicle) {
  vehicle endon("death");
  vehicle endon("ob_end_watch_vehicle_overlap_essence");
  var_15877ef521e5cb07 = function_abf76cc289cf03a3(vehicle.model);
  var_15877ef521e5cb07 += (15, 15, 25);

  while(true) {
    wait 0.25;
    driver = vehicle_occupancy::vehicle_occupancy_getdriver(vehicle);

    if(!isPlayer(driver)) {
      continue;
    }

    vehicle_aabb = vehicle physics_getentityaabb();
    vehicle_midpoint = vectorlerp(vehicle_aabb["min"], vehicle_aabb["max"], 0.5);
    var_8b0579be668e5c32 = length((vehicle_aabb["max"] - vehicle_aabb["min"]) * 0.5);
    var_a328c553ecb440e7 = anglestoaxis(vehicle.angles);
    var_8c26ad19a0970e6d = [var_a328c553ecb440e7["forward"], var_a328c553ecb440e7["right"], var_a328c553ecb440e7["up"]];
    scriptables = getlootscriptablearrayinradius(undefined, undefined, vehicle_midpoint, var_8b0579be668e5c32);

    foreach(scriptable in scriptables) {
      if(!scriptable getscriptableisusableonanypart() || !arraycontains(level.commonitem.var_48c807bcc0ab526, getxhashasset(scriptable.type))) {
        continue;
      }

      collision = 1;
      var_abef6236abf0cefb = scriptable.origin - vehicle_midpoint;

      for(i = 0; i <= 2; i++) {
        var_9ca188f217947e12 = abs(vectordot(var_8c26ad19a0970e6d[i], var_abef6236abf0cefb));

        if(var_9ca188f217947e12 > var_15877ef521e5cb07[i]) {
          collision = 0;
          break;
        }
      }

      if(!collision) {
        continue;
      }

      common_item::function_ccb2889218715cb1(scriptable, undefined, undefined, driver, 1);
    }
  }
}