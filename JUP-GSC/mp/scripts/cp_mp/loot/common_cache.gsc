/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\loot\common_cache.gsc
**************************************************/

#using script_16ea1b94f0f381b3;
#using script_443d99fe707f1d9f;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace common_cache;

function init_cache() {
  var_1d7913d6165ec9e5 = getdvarint(@ "hash_340f31675ef2e702", 50);
  var_26f109b5a85a74cf = getdvarint(@ "hash_adc3757de4a4f0b9", 10);
  level.var_1d7913d6165ec9e5 = var_1d7913d6165ec9e5 * var_1d7913d6165ec9e5;
  level.var_26f109b5a85a74cf = var_26f109b5a85a74cf * var_26f109b5a85a74cf;
  level.var_c028bd4d695c8c45 = getdvarint(@ "hash_22ef27debe529bf8", 20);
  level.var_2edc664b9fb97443 = getdvarint(@ "hash_819b6e8500e6044c", 4);
  scripts\engine\scriptable::scriptable_addusedcallback(&function_ba99ee1ab267e97f);
  scripts\engine\scriptable::scriptable_addautousecallback(&function_ba99ee1ab267e97f);
  namespace_53fc9ddbb516e6e1::registeronluieventcallbacksharedfunc(&function_f87690347a82844d);
  utility::registersharedfunc("container", "isContainerEmpty", &iscontainerempty);
  utility::registersharedfunc("container", "getIndexForLootIDInContainer", &function_d1703475e83c17fb);
  utility::registersharedfunc("container", "getLoadoutDoubleBackpackLootID", undefined);
  utility::registersharedfunc("container", "getLootIDAtContainerIndex", &getlootidatcontainerindex);

  thread setup_devgui();
}

function function_ba99ee1ab267e97f(instance, part, state, player, bautouse, usestring) {
  if(!function_1414925deba056bc(instance.type, "cache")) {
    return;
  }

  if(isDefined(instance.var_55bb3585d29af1be)) {
    [[instance.var_55bb3585d29af1be]](instance, player);
    return;
  }

  assert(part == "<dev string:x1c>");

  if((state == "closed_usable" || state == "closed_usable_no_collision") && !isDefined(instance.entity)) {
    if(instance getscriptableparthasstate(part, "fully_opening_unusable")) {
      instance setscriptablepartstate(part, "fully_opening_unusable");
    }

    if(isDefined(instance.var_534e0cf170a981b7)) {
      [[instance.var_534e0cf170a981b7]](instance, player);
    }

    if(!isDefined(instance.contents)) {
      itemnames = getscriptablelootcachecontents(instance);

      if(!isDefined(itemnames)) {
        assertmsg("<dev string:x24>");
        return;
      }

      function_bcb843e937613416(instance, itemnames);
    }

    if(!isDefined(instance.containertype)) {
      instance.containertype = 3;
    }
  } else if(isDefined(instance.contents) && state == "partially_open_usable") {
    if(instance getscriptableparthasstate(part, "fully_opening_unusable")) {
      instance setscriptablepartstate(part, "fully_opening_unusable");
    }
  }

  openlootablecontainer(instance, player);
}

function openlootablecontainer(container, opener) {
  if(isDefined(container.containertype) && container.containertype == 13) {
    container.contents = opener.ballooncontents.contents;
  }

  if(!isDefined(container.contents)) {
    assertmsg("<dev string:x67>");
    return;
  }

  function_87ad4454c9d2b995(opener, container);
  function_6830225d0b087bec(opener, container);
  items = container.contents;
  opener.var_2fa5b49969def47 = container;
  opener.var_f2aa9ae949179907 = opener.origin;

  if(container.type == "activity_reward_cache_lootcache") {
    foreach(item in items) {
      item.fromriftreward = 1;
    }
  }

  params = spawnStruct();
  params.cacheinstance = container;
  params.items = items;
  opener callback::callback("lootcache_looted", params);
  container.openedbefore = 1;

  if(isDefined(container.containertype) && container.containertype == 13) {
    opener.ballooncontents.contents = items;
  }

  if(isDefined(container.linkedparent)) {
    opener.var_f2aa9ae949179907 = rotatevectorinverted(opener.origin - container.linkedparent.origin, container.linkedparent.angles);
  }

  if(items.size > 10) {
    println("<dev string:xa2>" + items.size + "<dev string:xd9>" + 10 + "<dev string:xf5>");
  }

  for(itemindex = 0; itemindex < 10; itemindex++) {
    if(function_a5aedf9af5af1c7f(opener, container, itemindex)) {
      function_446c7ad7bcc70992(opener, itemindex, items[itemindex].lootid, function_b8bfea9514c89a77(items[itemindex].quantity), items[itemindex].weapondata);
      continue;
    }

    function_c7294f5b9b5006d5(opener, itemindex);
  }

  if(isDefined(container.weaponslotcontents)) {
    opener setclientomnvar("loot_container_weapon", container.weaponslotcontents);
  } else {
    opener setclientomnvar("loot_container_weapon", 0);
  }

  opener setclientomnvar("loot_container_min_slots", isDefined(container.minimumslots) ? container.minimumslots : level.var_2edc664b9fb97443);

  if(!isDefined(container.containertype)) {
    container.containertype = 1;
  }

  opener setclientomnvar("loot_container_open", container.containertype);

  if(istrue(level.var_a101059dea76957c) && !istrue(container.previouslyopened) && container.containertype != 13) {
    container.previouslyopened = 1;
  }

  container thread function_7f6dc80424e55d7b(opener);
  container thread function_71a59f067d5fe986(opener);
  container thread function_47b931d76ffd028f(opener);
  opener scripts\cp_mp\calloutmarkerping::function_faa3cbec7243fe72();
}

function function_87ad4454c9d2b995(opener, container) {
  nextweaponindex = 0;

  for(itemindex = 0; itemindex < container.contents.size; itemindex++) {
    if(function_a5aedf9af5af1c7f(opener, container, itemindex)) {
      itembundlename = function_fc925a153c7fd55c(container.contents[itemindex].lootid);

      if(!isDefined(itembundlename)) {
        assertmsg("<dev string:xfa>" + container.contents[itemindex].lootid + "<dev string:x130>");
        continue;
      }

      itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

      if(isDefined(itembundle.type) && itembundle.type == "weapon") {
        if(itemindex != nextweaponindex) {
          replaceditem = undefined;

          if(function_a5aedf9af5af1c7f(opener, container, nextweaponindex)) {
            replaceditem = container.contents[nextweaponindex];
          }

          container.contents[nextweaponindex] = container.contents[itemindex];
          container.contents[itemindex] = replaceditem;
        }

        nextweaponindex++;
      }
    }
  }
}

function function_6830225d0b087bec(opener, container) {
  for(itemindex = 0; itemindex < container.contents.size; itemindex++) {
    if(!function_a5aedf9af5af1c7f(opener, container, itemindex)) {
      continue;
    }

    item = container.contents[itemindex];
    itembundlename = function_fc925a153c7fd55c(item.lootid);

    if(!isDefined(itembundlename)) {
      assertmsg("<dev string:xfa>" + item.lootid + "<dev string:x130>");
      continue;
    }

    itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

    if(isDefined(itembundle) && isDefined(itembundle.type) && itembundle.type == "weapon") {
      if(itembundle.type == "weapon") {
        clipammo = 0;
        stockammo = 0;

        if(isDefined(item.var_4f74f0aef2b2a8bf)) {
          weaponobj = function_7d4684238ed31570(itembundle, item);

          if(isDefined(weaponobj)) {
            clipammo = weaponclipsize(weaponobj);
            stockammo = weaponmaxammo(weaponobj);
          }
        }

        if(clipammo <= 0 && isDefined(itembundle.baseweapon)) {
          clipammo = weaponclipsize(itembundle.baseweapon);
          stockammo = weaponmaxammo(itembundle.baseweapon);
        }

        item.quantity = function_7209c8cd4b2e3afd(clipammo + stockammo);
      }
    }
  }
}

function closelootablecontainer(container, opener) {
  if(!isDefined(container) || !isDefined(opener)) {
    assertmsg("<dev string:x18f>");
    return;
  }

  if(isDefined(level.var_61e6e1b83a8f3486) && isDefined(level.var_61e6e1b83a8f3486.var_9549d82a3fba4746) && container == level.var_61e6e1b83a8f3486.var_9549d82a3fba4746) {
    opener setclientomnvar("<dev string:x1c3>", 0);
    opener.var_2fa5b49969def47 = undefined;
    container notify("<dev string:x1da>");
    return;
  }

  opener setclientomnvar("loot_container_open", 0);
  function_d53393379858d253(opener);

  if(!istrue(container.var_978407de904a5fd1)) {
    partname = container function_ec5f4851431f3382();

    if(opener iscontainerempty(container)) {
      if(container getscriptableparthasstate(partname, "fully_opening_unusable")) {
        container setscriptablepartstate(partname, "fully_opening_unusable");
      }
    } else if((!isDefined(container.containertype) || container.containertype != 4 || container.containertype == 4 && istrue(container.var_6a4915c949e9e77e)) && container getscriptableparthasstate(partname, "partially_open_usable")) {
      state = container getscriptablepartstate(partname);

      if(state == "fully_open_unusable") {
        container setscriptablepartstate(partname, "partially_open_usable");
      } else if(state == "fully_opening_unusable") {
        container thread function_d3e618521013c7eb();
      } else {
        assert(0, "<dev string:x1e4>");
      }
    }
  }

  if(istrue(opener.var_7f15935a89ea5b13)) {
    opener.var_7f15935a89ea5b13 = undefined;
  }

  opener.var_2fa5b49969def47 = undefined;
  params = spawnStruct();
  params.opener = opener;
  container callback::callback("on_cache_closed", params);
  container notify("closed");
}

function function_71a59f067d5fe986(opener) {
  self endon("death");
  self endon("closed");
  level endon("game_ended");
  opener endon("disconnect");
  var_ec64eecddf1178af = anglesToForward(opener getplayerangles());
  framesstill = 0;

  while(opener scripts\cp_mp\utility\player_utility::_isalive() && !istrue(opener.isdisconnecting) && isDefined(opener.origin) && !function_139b3fe10930a6a5(self, opener, framesstill) && !function_35a189c66e8d51f0(opener, var_ec64eecddf1178af) && opener playerads() < 0.5) {
    if(getdvarint(@ "hash_419fd2f09b23942a", 1)) {
      if(lengthsquared(opener getvelocity()) == 0) {
        if(framesstill == 0) {
          if(isDefined(self.linkedparent)) {
            opener.var_f2aa9ae949179907 = rotatevectorinverted(opener.origin - self.linkedparent.origin, self.linkedparent.angles);
          } else {
            opener.var_f2aa9ae949179907 = opener.origin;
          }
        }

        framesstill++;
        framesstill = int(min(framesstill, getdvarint(@ "hash_aea0716d0a0f790a", 6)));
      } else {
        framesstill--;
        framesstill = int(max(framesstill, 0));
      }
    }

    waitframe();
  }

  closelootablecontainer(self, opener);
}

function function_47b931d76ffd028f(opener) {
  self endon("death");
  level endon("game_ended");
  self endon("closed");
  opener scripts\engine\utility::waittill_any_4("close_container", "flashbang", "concussed", "weapon_fired");
  closelootablecontainer(self, opener);
}

function function_7f6dc80424e55d7b(opener) {
  self endon("death");
  level endon("game_ended");
  self endon("closed");
  wait 0.5;

  if(!isDefined(self.contents)) {
    assertmsg("<dev string:x253>");
    return;
  }

  contents = self.contents;

  for(i = 0; i < contents.size; i++) {
    if(!isDefined(contents[i])) {
      continue;
    }

    lootid = contents[i].lootid;
    quantity = contents[i].quantity;
    itembundlename = function_fc925a153c7fd55c(lootid);

    if(!isDefined(itembundlename)) {
      if(quantity > 0) {
        assertmsg("<dev string:x2ab>" + lootid + "<dev string:x2ec>");
      }

      continue;
    }

    itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

    if(!istrue(itembundle.var_13fc3679e0d849db)) {
      continue;
    }

    fakeitem = spawnStruct();
    fakeitem.type = itembundle.scriptable;
    fakeitem.count = quantity;
    var_4cf8737a4d987265 = opener common_item::function_576728d3d4486bd6(fakeitem, 1);

    if(var_4cf8737a4d987265) {
      function_eff2aed88a59ccfd(opener, i, 0, 0);
      function_56b776a926446950(opener, lootid);

      if(isDefined(self.var_139629996ea22b5)) {
        foreach(pingdata in self.var_139629996ea22b5) {
          if(isDefined(pingdata.lootid) && pingdata.lootid == lootid) {
            deleteping = 1;

            for(index = 0; index < contents.size; index++) {
              if(index != i && isDefined(contents[index]) && isDefined(contents[index].lootid) && contents[index].lootid == lootid) {
                deleteping = 0;
                break;
              }
            }

            if(deleteping) {
              pingdata.pingowner scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(pingdata.pingindex);
            }

            waitframe();
          }
        }
      }

      wait 0.5;
    }
  }

  if(opener iscontainerempty(self) && self.containertype != 15 && self.containertype != 18 && self.containertype != 19) {
    container = self;
    closelootablecontainer(self, opener);

    if(isDefined(container.var_1498604de9cf5016) && !istrue(container.var_1498604de9cf5016)) {
      container notify("death");
      container freescriptable();
    }
  }
}

function function_d3e618521013c7eb() {
  self endon("death");
  level endon("game_ended");
  partname = self function_ec5f4851431f3382();
  waitframe();

  while(self getscriptablepartstate(partname) == "fully_opening_unusable") {
    waitframe();
  }

  self setscriptablepartstate(partname, "partially_open_usable");
}

function function_446c7ad7bcc70992(player, index, lootid, quantity, weapondata) {
  assert(isDefined(lootid) && isDefined(quantity));

  if(!isDefined(lootid) || lootid == 0 || !isDefined(quantity) || quantity == 0) {
    function_c7294f5b9b5006d5(player, index);
    return;
  }

  typename = loot::function_282cf83c9eeda744(lootid);

  if(!isDefined(typename)) {
    assertmsg("<dev string:x329>" + lootid + "<dev string:x35f>");
    return;
  }

  typedata = level.lootmaster[typename];

  if(!isDefined(typedata)) {
    assertmsg("<dev string:x365>" + typename + "<dev string:x35f>");
    return;
  }

  typeindex = typedata.typevalue;

  if(typename == "weapon" && isDefined(weapondata)) {
    itembundle = common_item::function_f4a303d532b044a7(lootid);

    if(isDefined(itembundle) && isDefined(itembundle.baseweapon)) {
      weaponobj = undefined;
      weaponrootname = weapon::getweaponrootname(itembundle.baseweapon);

      if(isDefined(weapondata.variantid) && weapondata.variantid != 0) {
        blueprintcamo = function_c7771194200d360e(lootid);
        weaponobj = weapon::buildweapon_blueprint(weaponrootname, blueprintcamo, undefined, weapondata.variantid);
      } else {
        weaponobj = weapon::buildweapon(weaponrootname, weapondata.attachments);
      }

      var_8eb93a779d9df6f7 = function_3c67455f0dcec331(player, weaponobj);
      lootid = function_5b832267ff976432(lootid, var_8eb93a779d9df6f7);
    }

    typeindex = isDefined(weapondata.rarity) ? weapondata.rarity : 0;
  }

  player setclientomnvar("loot_container_item_" + index, lootid);
  player setclientomnvar("loot_container_quantity_" + index, quantity);
  player setclientomnvar("loot_container_type_" + index, typeindex);
}

function function_c7294f5b9b5006d5(player, index) {
  player setclientomnvar("loot_container_item_" + index, 0);
  player setclientomnvar("loot_container_quantity_" + index, 0);
  player setclientomnvar("loot_container_type_" + index, 0);
}

function function_35a189c66e8d51f0(opener, var_ec64eecddf1178af) {
  if(!isDefined(opener) || !isDefined(opener getplayerangles())) {
    return true;
  }

  var_87782b21920f1be6 = anglesToForward(opener getplayerangles());
  return math::anglebetweenvectors(var_ec64eecddf1178af, var_87782b21920f1be6) > level.var_c028bd4d695c8c45;
}

function iscontainerempty(container) {
  if(!isDefined(container.contents)) {
    return true;
  }

  foreach(content in container.contents) {
    if(!isDefined(content.lootid) || !isDefined(content.quantity)) {
      continue;
    }

    if(content.lootid > 0 && function_b8bfea9514c89a77(content.quantity) > 0) {
      return false;
    }
  }

  if(isDefined(container.weaponslotcontents)) {
    containerweapon = self getclientomnvar("loot_container_weapon");

    if(istrue(containerweapon)) {
      return false;
    }
  }

  return true;
}

function function_139b3fe10930a6a5(container, opener, framesstill) {
  if(!isDefined(opener.var_f2aa9ae949179907)) {
    return true;
  }

  movedistancesquared = level.var_1d7913d6165ec9e5;

  if(framesstill > 2 && getdvarint(@ "hash_419fd2f09b23942a", 1)) {
    movedistancesquared = level.var_26f109b5a85a74cf;
  }

  if(isDefined(container.linkedparent)) {
    newoffset = rotatevectorinverted(opener.origin - container.linkedparent.origin, container.linkedparent.angles);

    if(distancesquared(opener.var_f2aa9ae949179907, newoffset) > movedistancesquared) {
      return true;
    }
  } else if(distancesquared(opener.var_f2aa9ae949179907, opener.origin) > movedistancesquared) {
    return true;
  }

  return false;
}

function function_a5aedf9af5af1c7f(opener, container, itemindex) {
  if(!isDefined(container.contents[itemindex])) {
    return false;
  }

  item = container.contents[itemindex];
  lootid = item.lootid;
  quantity = function_b8bfea9514c89a77(item.quantity);

  if(isDefined(quantity) && quantity > 0 && isDefined(lootid) && lootid > 0) {
    return true;
  }

  return false;
}

function function_f87690347a82844d(notification, slotindex) {
  result = 0;

  if(isDefined(notification)) {
    cache = self.var_2fa5b49969def47;

    if(!isDefined(cache)) {
      return;
    }

    if(!function_d6041f45fee8083d()) {
      return;
    }

    switch (notification) {
      case #"hash_31a47c100531f34f":
        result = function_f4fda26d9ae6dbe0(self, slotindex, "lootcache_obtaintype_stow", 1, cache);
        break;
      case #"hash_b7e2e7e659da3043":
        result = function_f4fda26d9ae6dbe0(self, slotindex, "lootcache_obtaintype_stow", undefined, cache);
        break;
      case #"hash_453445f0e586a78e":
        if(!istrue(cache.var_978407de904a5fd1)) {
          result = function_f4fda26d9ae6dbe0(self, slotindex, "lootcache_obtaintype_equip", undefined, cache);
        } else {
          if(cache.var_9c44eb334c225d45 == 1 && !scripts\cp_mp\loot\common_cache::iscontainerempty(cache)) {
            lootid = cache.contents[0].lootid;
            quantity = cache.contents[0].quantity;
            function_b9d2aee928c46b5f(lootid, quantity, undefined, undefined, 1);
            function_eff2aed88a59ccfd(self, 0, 0, 0);
          }

          function_cc518f9c6e1d9543(cache);
        }

        break;
      case #"hash_fb84b605789df05e":
        closelootablecontainer(cache, self);
        return;
      case #"hash_10217053947e341b":
        cacheindex = slotindex >> 8;
        backpackindex = slotindex & 255;
        lootid = cache.contents[cacheindex].lootid;
        quantity = cache.contents[cacheindex].quantity;
        function_2d05d3354917445b(backpackindex, lootid, quantity);
        itembundlename = function_fc925a153c7fd55c(lootid);

        if(isDefined(itembundlename)) {
          itembundle = getscriptbundlefieldvalues("itemspawnentry:" + itembundlename, [#"pickupsfx", #"raritydef", #"type", #"ref", #"subtype"]);
          params = spawnStruct();
          params.item = cache;
          params.itembundlename = itembundlename;
          params.itembundle = itembundle;
          params.tobackpack = 1;
          callback::callback("player_item_pickup", params);
        }

        function_eff2aed88a59ccfd(self, cacheindex, 0, 0);
        function_56b776a926446950(self, lootid);

        if(istrue(cache.var_978407de904a5fd1)) {
          function_cc518f9c6e1d9543(cache);
        } else if(iscontainerempty(cache)) {
          closelootablecontainer(cache, self);
        }

        break;
      default:
        return;
    }
  }

  if(isDefined(self.var_2fa5b49969def47) && isDefined(self.var_2fa5b49969def47.onitemtaken)) {
    [[self.var_2fa5b49969def47.onitemtaken]](self.var_2fa5b49969def47, self);
  }

  if(istrue(result) && isDefined(self.var_2fa5b49969def47) && iscontainerempty(self.var_2fa5b49969def47) && self.var_2fa5b49969def47.containertype != 15 && self.var_2fa5b49969def47.containertype != 18 && self.var_2fa5b49969def47.containertype != 19) {
    container = self.var_2fa5b49969def47;
    closelootablecontainer(self.var_2fa5b49969def47, self);

    if(isDefined(container.var_1498604de9cf5016) && !istrue(container.var_1498604de9cf5016)) {
      container notify("death");
      container freescriptable();
    }
  }
}

function function_d6041f45fee8083d() {
  return self getclientomnvar("loot_container_open") > 0;
}

function function_f4fda26d9ae6dbe0(player, index, obtaintype, var_a1803fc19dffd729, cache) {
  if(!isDefined(cache) || !isDefined(cache.contents) || !isDefined(cache.contents[index])) {
    assertmsg("<dev string:x3a3>" + index + "<dev string:x35f>");
    return 0;
  }

  fromriftreward = isDefined(cache.contents[index].fromriftreward) ? cache.contents[index].fromriftreward : 0;
  lootid = cache.contents[index].lootid;
  cachequantity = cache.contents[index].quantity;
  weapondata = cache.contents[index].weapondata;

  if(!isDefined(lootid) || lootid == 0 || !isDefined(cachequantity) || cachequantity == 0) {
    assertmsg("<dev string:x3da>" + index + "<dev string:x35f>");
    return 0;
  }

  if(!isDefined(var_a1803fc19dffd729)) {
    var_a1803fc19dffd729 = cachequantity;
  }

  if(var_a1803fc19dffd729 > cachequantity) {
    var_a1803fc19dffd729 = cachequantity;
    assertmsg("<dev string:x431>");
  }

  itembundlename = undefined;
  itembundle = undefined;

  if(isDefined(weapondata) && isDefined(weapondata.baseweapon)) {
    itembundlename = namespace_736197e4d378b91b::function_46423e80a0fa8f2(weapondata.baseweapon, 0, weapondata.variantid);
    itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
    assert(isDefined(itembundle), "<dev string:x482>" + itembundlename + "<dev string:x4c3>");
  } else {
    itembundlename = function_fc925a153c7fd55c(lootid);
    itembundle = function_f4a303d532b044a7(lootid);
  }

  if(!isDefined(itembundle)) {
    return 0;
  }

  if(function_633f07e180b6ec8f("itemspawnentry:" + itembundlename)) {
    return 0;
  }

  item = spawnStruct();
  item.type = itembundle.scriptable;
  item.count = function_7209c8cd4b2e3afd(var_a1803fc19dffd729);
  item.fromcache = 1;
  item.fromriftreward = fromriftreward;

  if(isDefined(weapondata) && isDefined(itembundle.baseweapon)) {
    item.var_4f74f0aef2b2a8bf = spawnStruct();
    item.var_4f74f0aef2b2a8bf.itembundlename = itembundlename;
    item.var_4f74f0aef2b2a8bf.baseweapon = itembundle.baseweapon;
    item.var_4f74f0aef2b2a8bf.attachments = weapondata.attachments;
    item.var_4f74f0aef2b2a8bf.rarity = weapondata.rarity;
    item.var_4f74f0aef2b2a8bf.variantid = weapondata.variantid;
    item.var_4f74f0aef2b2a8bf.camo = weapondata.camo;
  }

  if(isDefined(cache.var_139629996ea22b5)) {
    foreach(pingdata in cache.var_139629996ea22b5) {
      if(isDefined(pingdata.lootid) && pingdata.lootid == lootid) {
        deleteping = 1;

        for(i = 0; i < cache.contents.size; i++) {
          if(i != index && isDefined(cache.contents[i]) && isDefined(cache.contents[i].lootid) && cache.contents[i].lootid == lootid) {
            deleteping = 0;
            break;
          }
        }

        if(deleteping) {
          pingdata.pingowner scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(pingdata.pingindex);
        }

        waitframe();
      }
    }
  }

  switch (obtaintype) {
    case #"hash_e6ef587f08f8234e":
      function_de489fa2ffdb7f2d(item, 0);
      break;
    case #"hash_93aad3e0afb4b617":
      function_10e55eeb4c15dd5a(item);
      break;
    default:
      return;
  }

  newquantity = 0;

  if(isDefined(item)) {
    newquantity = function_b8bfea9514c89a77(item.count);
  }

  function_eff2aed88a59ccfd(player, index, lootid, newquantity, weapondata);

  if(newquantity < var_a1803fc19dffd729) {
    function_56b776a926446950(player, lootid);
  }

  return newquantity == 0;
}

function function_d1703475e83c17fb(container, lootid, player) {
  if(!isDefined(container) || !isDefined(container.contents) || !isDefined(lootid) || !isint(lootid)) {
    if(!isDefined(container) || !isDefined(container.contents)) {
      assertmsg("<dev string:x4c8>");
    } else if(!isDefined(lootid) || !isint(lootid)) {
      assertmsg("<dev string:x51c>");
    }

    return [undefined, undefined];
  }

  containerindex = 0;

  while(containerindex < container.contents.size) {
    if(isDefined(container.contents[containerindex]) && isDefined(container.contents[containerindex].lootid) && lootid == container.contents[containerindex].lootid) {
      return [containerindex, 0];
    }

    containerindex += 1;
  }

  return [undefined, undefined];
}

function getlootidatcontainerindex(player, index) {
  packedslotid = player getclientomnvar("loot_container_item_" + index);
  slotiddata = function_217ab517f98c6fab(packedslotid);
  return slotiddata.lootid;
}

function function_8e5978971b5dcd16(player, index) {
  return player getclientomnvar("loot_container_quantity_" + index);
}

function function_eff2aed88a59ccfd(player, index, newlootid, newquantity, newweapondata) {
  if(isDefined(player.var_2fa5b49969def47)) {
    player.var_2fa5b49969def47.contents[index].quantity = function_7209c8cd4b2e3afd(newquantity);

    if(newquantity <= 0) {
      newlootid = 0;
      player.var_2fa5b49969def47.contents[index].lootid = newlootid;
    }

    player.var_2fa5b49969def47.contents[index].weapondata = newweapondata;
  }

  function_446c7ad7bcc70992(player, index, newlootid, newquantity, newweapondata);
}

function function_56b776a926446950(player, lootid) {
  if(isDefined(player) && isDefined(player.var_2fa5b49969def47)) {
    player.var_2fa5b49969def47 notify("cache_item_looted", lootid, player);
  }
}

function function_bcb843e937613416(instance, itemnames) {
  if(!isDefined(instance) || !isDefined(itemnames) || itemnames.size <= 0) {
    return;
  }

  instance.contents = [];

  foreach(itemname in itemnames) {
    itembundlename = function_2cdc55ba39d97d70(itemname);

    if(!isDefined(itembundlename)) {
      itembundlename = itemname;
    }

    if(!isDefined(itembundlename)) {
      continue;
    }

    function_ff5a53c1d3232e2f(instance, 1, itembundlename);
  }
}

function function_6eee0ede493b44e8(instance, quantity, lootid) {
  if(!isDefined(instance.contents)) {
    instance.contents = [];
  }

  if(!isDefined(lootid) || lootid == 0 || !isDefined(quantity) || quantity == 0) {
    instance.contents[instance.contents.size] = {
      #quantity: 0, #lootid: 0
    };
    return;
  }

  itembundlename = function_fc925a153c7fd55c(lootid);

  if(!isDefined(itembundlename)) {
    assertmsg("<dev string:x571>" + lootid + "<dev string:x5b8>");
    return;
  }

  function_ff5a53c1d3232e2f(instance, quantity, itembundlename);
}

function function_ff5a53c1d3232e2f(instance, quantity, itembundlename) {
  if(!isDefined(itembundlename)) {
    assertmsg("<dev string:x5c9>");
    return;
  }

  if(!isDefined(instance.contents)) {
    instance.contents = [];
  }

  if(!isDefined(quantity) || quantity == 0) {
    instance.contents[instance.contents.size] = {
      #quantity: 0, #lootid: 0
    };
    return;
  }

  var_b91e11f33e2a122d = getscriptbundlefieldvalues("itemspawnentry:" + itembundlename, [#"spawncount", #"rarity", #"type", #"ref", #"scriptable"]);

  if(!isDefined(var_b91e11f33e2a122d)) {
    assertmsg("<dev string:x482>" + itembundlename + "<dev string:x4c3>");
    return;
  }

  item = spawnStruct();
  item.lootid = function_6d15e119c2779a93(var_b91e11f33e2a122d);

  if(!isDefined(item.lootid)) {
    assertmsg("<dev string:x60d>" + itembundlename + "<dev string:x63d>");
    return;
  }

  item.quantity = quantity;

  if(isDefined(var_b91e11f33e2a122d.spawncount)) {
    item.quantity = var_b91e11f33e2a122d.spawncount;
  }

  if(isDefined(var_b91e11f33e2a122d.type) && var_b91e11f33e2a122d.type == "weapon") {
    itemweapondata = spawnStruct();
    itemweapondata.rarity = var_b91e11f33e2a122d.rarity;
    itemweapondata.variantid = namespace_736197e4d378b91b::function_ce5e32676f572482(var_b91e11f33e2a122d);

    if(itemweapondata.variantid == 0) {
      attachments = function_c9fa4fbe86fb1c75(itembundlename);

      if(isDefined(attachments) && attachments.size > 0) {
        itemweapondata.attachments = attachments;
      }
    } else {
      itemweapondata.camo = function_c7771194200d360e(item.lootid);
    }

    if(isDefined(itemweapondata.rarity) || isDefined(itemweapondata.attachments) || itemweapondata.variantid != 0) {
      item.weapondata = itemweapondata;
    }
  }

  instance.contents[instance.contents.size] = item;
}

function fillcontentsfromlist(instance, listbundlename, count) {
  itemnames = common_item::function_bc2f4857c90f5344(listbundlename, count);
  function_bcb843e937613416(instance, itemnames);
}

function cache_spawncache(scriptkey, origin, angles, forcedstate) {
  var_e62511cd09a9b71f = function_1a5ef09ec005ebf(origin, [#"hash_2de21e1dd759eb92"]);

  if(!isDefined(var_e62511cd09a9b71f)) {
    assertmsg("<dev string:x665>" + getxhashsourcename(scriptkey) + "<dev string:x6a6>" + origin + "<dev string:x6b7>");
    return;
  }

  foreach(cacheentry in var_e62511cd09a9b71f.var_9e5e8749b0f570be) {
    if(cacheentry.scriptkey == scriptkey) {
      cachebundlename = cacheentry.var_afbb6e9b90b03af;
      var_42b0b62a5ff326bc = getscriptbundlefieldvalues("itemspawnentry:" + cachebundlename, [#"scriptable"]);

      if(!isDefined(var_42b0b62a5ff326bc)) {
        assertmsg("<dev string:x665>" + getxhashsourcename(scriptkey) + "<dev string:x6a6>" + origin + "<dev string:x6e7>" + cachebundlename + "<dev string:x4c3>");
        return;
      }

      cache = spawnscriptable(var_42b0b62a5ff326bc.scriptable, origin, angles);
      state = "closed_usable";

      if(isDefined(forcedstate)) {
        state = forcedstate;
      }

      cache setscriptablepartstate("body", state);
      fillcontentsfromlist(cache, cacheentry.cacheitemspawnlist, cacheentry.var_b312af7d766b0713);
      return cache;
    }
  }
}

function function_fd95ef820bb2b980(items, cache) {
  foreach(item in items) {
    if(!isDefined(item)) {
      continue;
    }

    function_ff5a53c1d3232e2f(cache, 1, item);
  }
}

function private function_3c67455f0dcec331(player, weaponobj) {
  if(isweapon(weaponobj)) {
    var_8eb93a779d9df6f7 = function_51f396445baa7fa6(%"obloot_custom_weapon", weaponobj);

    if(isDefined(var_8eb93a779d9df6f7) && var_8eb93a779d9df6f7 != 0) {
      if(isDefined(player.var_d6b4193c04f80551)) {
        player.var_d6b4193c04f80551[player.var_d6b4193c04f80551.size] = var_8eb93a779d9df6f7;
      } else {
        player.var_d6b4193c04f80551 = [var_8eb93a779d9df6f7];
      }

      return var_8eb93a779d9df6f7;
    }
  }

  return 0;
}

function private function_d53393379858d253(player) {
  if(!isDefined(player.var_d6b4193c04f80551)) {
    return;
  }

  foreach(var_8eb93a779d9df6f7 in player.var_d6b4193c04f80551) {
    function_a1054a8c2bc6c36d(var_8eb93a779d9df6f7);
  }

  player.var_d6b4193c04f80551 = [];
}

function private function_5b832267ff976432(lootid, extrapayload) {
  bitsused = 31;

  if(bitsused > 31) {
    assertmsg("<dev string:x725>");
    return 0;
  }

  if(!isDefined(lootid)) {
    lootid = 0;
  }

  assert(lootid >= 0 && lootid < 1048576);

  if(!isDefined(extrapayload)) {
    extrapayload = 0;
  }

  assert(extrapayload >= 0 && extrapayload < 2048);
  var_8db5472153ea4811 = extrapayload;
  var_8db5472153ea4811 <<= 20;
  var_8db5472153ea4811 |= lootid;
  return var_8db5472153ea4811;
}

function private function_217ab517f98c6fab(var_8db5472153ea4811) {
  bitsused = 31;

  if(bitsused > 31) {
    assertmsg("<dev string:x725>");
    return undefined;
  }

  var_25cdf28fdb105d24 = spawnStruct();
  lootidmask = 1048576 - 1;
  var_25cdf28fdb105d24.lootid = lootidmask &var_8db5472153ea4811;
  var_8db5472153ea4811 >>= 20;
  var_b1a98c6b10f6e8c1 = 2048 - 1;
  var_25cdf28fdb105d24.extrapayload = var_b1a98c6b10f6e8c1 &var_8db5472153ea4811;
  var_8db5472153ea4811 >>= 11;
  assert(var_8db5472153ea4811 == 0);
  return var_25cdf28fdb105d24;
}

function private setup_devgui() {
  if(!isDefined(level.gametypebundle.var_328f56c2f24c4831) || getdvarint(@ "hash_10f0811105fc2f93", 0) == 0) {
    return;
  }

  zonelist = getscriptbundle("<dev string:x77e>" + level.gametypebundle.var_328f56c2f24c4831);

  if(!isDefined(zonelist)) {
    return;
  }

  var_2db9da2642048a13 = [];

  foreach(var_8bfddc20fd955e32 in zonelist.zonedefs) {
    if(isDefined(var_8bfddc20fd955e32.zonedef) && !isDefined(var_2db9da2642048a13[var_8bfddc20fd955e32.zonedef])) {
      var_2db9da2642048a13[var_8bfddc20fd955e32.zonedef] = getscriptbundle("<dev string:x794>" + var_8bfddc20fd955e32.zonedef);
    }
  }

  devgui::function_6e7290c8ee4f558b("<dev string:x7a9>");
  devgui::function_b23a59dfb4ca49a1("<dev string:x7cb>", "<dev string:x7d0>", &function_fda80ec40b57c4cf);
  devgui::function_b23a59dfb4ca49a1("<dev string:x7e9>", "<dev string:x7ee>", &function_fda80ec40b57c4cf);
  devgui::function_b23a59dfb4ca49a1("<dev string:x807>", "<dev string:x80c>", &function_fda80ec40b57c4cf);
  devgui::function_b23a59dfb4ca49a1("<dev string:x825>", "<dev string:x82a>", &function_fda80ec40b57c4cf);
  devgui::function_b23a59dfb4ca49a1("<dev string:x843>", "<dev string:x848>", &function_fda80ec40b57c4cf);
  devgui::function_b23a59dfb4ca49a1("<dev string:x861>", "<dev string:x866>", &function_fda80ec40b57c4cf);
  devgui::function_b23a59dfb4ca49a1("<dev string:x87f>", "<dev string:x884>", &function_fda80ec40b57c4cf);
  devgui::function_b23a59dfb4ca49a1("<dev string:x89d>", "<dev string:x8a2>", &function_fda80ec40b57c4cf);
  devgui::function_b23a59dfb4ca49a1("<dev string:x8bb>", "<dev string:x8c0>", &function_fda80ec40b57c4cf);
  devgui::function_b23a59dfb4ca49a1("<dev string:x8d9>", "<dev string:x8df>", &function_fda80ec40b57c4cf);
  devgui::function_b23a59dfb4ca49a1("<dev string:x8f9>", "<dev string:x8ff>", &function_fda80ec40b57c4cf);
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:x919>");

  foreach(var_e20693215273eb59, var_a91353c4805838d2 in var_2db9da2642048a13) {
    foreach(entry in var_a91353c4805838d2.var_280b92209c904804) {
      if(isDefined(entry.var_b312af7d766b0713) && isDefined(entry.cacheitemspawnlist) && isDefined(entry.var_afbb6e9b90b03af)) {
        devgui::function_b23a59dfb4ca49a1(var_e20693215273eb59 + "<dev string:x93c>" + entry.var_afbb6e9b90b03af, "<dev string:x949>" + entry.var_afbb6e9b90b03af + "<dev string:x95d>" + entry.cacheitemspawnlist + "<dev string:x95d>" + entry.var_b312af7d766b0713, &function_35b40f5e98dc4ee4, 0);
      }
    }

    foreach(entry in var_a91353c4805838d2.var_d13f1f3566674f10) {
      if(isDefined(entry.var_b312af7d766b0713) && isDefined(entry.cacheitemspawnlist) && isDefined(entry.var_afbb6e9b90b03af)) {
        devgui::function_b23a59dfb4ca49a1(var_e20693215273eb59 + "<dev string:x962>" + entry.var_afbb6e9b90b03af, "<dev string:x949>" + entry.var_afbb6e9b90b03af + "<dev string:x95d>" + entry.cacheitemspawnlist + "<dev string:x95d>" + entry.var_b312af7d766b0713, &function_35b40f5e98dc4ee4, 0);
      }
    }

    foreach(entry in var_a91353c4805838d2.var_9e5e8749b0f570be) {
      if(isDefined(entry.scriptkey) && isDefined(entry.var_b312af7d766b0713) && isDefined(entry.cacheitemspawnlist) && isDefined(entry.var_afbb6e9b90b03af)) {
        devgui::function_b23a59dfb4ca49a1(var_e20693215273eb59 + "<dev string:x96d>" + getxhashsourcename(entry.scriptkey), "<dev string:x949>" + entry.var_afbb6e9b90b03af + "<dev string:x95d>" + entry.cacheitemspawnlist + "<dev string:x95d>" + entry.var_b312af7d766b0713, &function_35b40f5e98dc4ee4, 0);
      }
    }
  }

  devgui::function_fe953f000498048f();
}

function function_fda80ec40b57c4cf(params) {
  level.var_2edc664b9fb97443 = int(params[0]);
}

function function_7029bab8ebd74e1d(contents) {
  if(!isDefined(level.var_61e6e1b83a8f3486)) {
    level.var_61e6e1b83a8f3486 = spawnStruct();
  }

  if(!isDefined(level.var_61e6e1b83a8f3486.var_9549d82a3fba4746)) {
    level.var_61e6e1b83a8f3486.var_9549d82a3fba4746 = spawnStruct();
    level.var_61e6e1b83a8f3486.var_9549d82a3fba4746.type = "<dev string:x979>";
    level.var_61e6e1b83a8f3486.var_9549d82a3fba4746.var_1498604de9cf5016 = 1;
  }

  level.var_61e6e1b83a8f3486.var_9549d82a3fba4746.contents = contents;
}

function function_803e6cfa13174264() {
  foreach(player in level.players) {
    if(isDefined(player function_d6041f45fee8083d())) {
      closelootablecontainer(level.var_61e6e1b83a8f3486.var_9549d82a3fba4746, player);
    }

    level.var_61e6e1b83a8f3486.var_9549d82a3fba4746.origin = player getEye() + 32 * vectorNormalize(anglesToForward(player getplayerangles()));
    utility::delaythread(0.1, &openlootablecontainer, level.var_61e6e1b83a8f3486.var_9549d82a3fba4746, player);
  }
}

function function_35b40f5e98dc4ee4(params) {
  cachebundlename = params[0];
  listbundlename = params[1];
  quantity = int(params[2]);
  function_7029bab8ebd74e1d(undefined);
  fillcontentsfromlist(level.var_61e6e1b83a8f3486.var_9549d82a3fba4746, listbundlename, quantity);
  function_803e6cfa13174264();
}

# /