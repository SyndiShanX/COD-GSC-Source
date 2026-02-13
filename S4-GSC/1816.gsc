/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1816.gsc
*************************************************/

_id_7F43() {
  level.crafting_table = spawnStruct();
  level._id_3E54 = ::_id_C24C;
  level._id_3E55 = 1;
  init_crafting_items();
}

init_crafting_items() {
  level.craftingtable = [];

  if(getdvarint("#x3dee089cb49164e4e", 0)) {
    var_0 = _func_0393("craftableitemlist:cp_crafting_table_rbz");
  } else {
    var_0 = _func_0393("craftableitemlist:cp_crafting_table");
  }

  foreach(var_4, var_2 in var_0.craftableitems) {
    var_2 = _func_0393("craftableitem:" + var_2.craftableitem);
    var_3 = spawnStruct();
    var_3._id_3D91 = var_2._id_3D91;
    var_3._id_CF0C = var_2._id_CF22;

    if(isDefined(var_2._id_332F)) {
      var_3.itemref = var_2.itemref;

      switch (var_2._id_332F) {
        case "armor":
          var_3.tier = var_2.tier;
          var_3.craftfunc = ::craft_armor_tier;
          break;
        case "tactical":
        case "lethal":
          var_3.craftfunc = ::craft_equipment;
          break;
        case "support":
          var_3.craftfunc = ::craft_killstreak;
          break;
        default:
          scripts\engine\utility::_id_5598("cp_crafting_table item: " + var_2.itemref + " does not have a category set.");
          break;
      }
    }

    level.craftingtable[var_4] = var_3;
  }

  _id_095C::_id_C287(::craft_purchase_response);
}

_id_C24C() {
  _id_0737::_id_C266("crafting_table", ::_id_3E53, ::_id_FDCC, ::crafting_table_init, undefined, undefined, undefined, undefined, 1, "v_ui_icons_zombies_minimap_craftingtable");
  _id_0737::addinteractionhinttypecallback("crafting_table", ::crafting_table_hint_type);
}

crafting_table_hint_type(var_0, var_1) {
  if(istrue(level._id_0C35) || istrue(var_1._id_2031)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

_id_3E53(var_0, var_1) {
  if(istrue(level._id_0C35) || istrue(var_1._id_2031)) {
    return &"CP_ZMB_INTERACTIONS/DISABLED_BY_FAST_TRAVEL";
  }

  return &"CP_SURIVAL/CRAFTING_START";
}

crafting_table_init(var_0) {
  foreach(var_2 in var_0) {
    thread _id_0720::init_approach_dialogue(var_2.origin, "zm_cmcp_obhb_krft_hcft", 0, 10000);
  }
}

_id_FB4C(var_0) {}

_id_AC01(var_0) {
  if(istrue(level._id_0C35) || istrue(var_0._id_2031)) {
    return;
  }
  var_0 setclientomnvar("ui_zm_open_crafting_menu", 1);
  var_0._id_3E57 = var_0.origin;
  var_0 thread _id_34FA();
}

_id_34FA() {
  thread _id_34EE();
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "crafting_invalidated");

  if(isDefined(self)) {
    force_close_crafting_menu();
  }
}

_id_34EE() {
  self endon("death_or_disconnect");

  for(;;) {
    if(!isDefined(self._id_3E57)) {
      break;
    }

    if(_id_073B::_id_B4EF(self)) {
      break;
    }

    if(distance(self._id_3E57, self.origin) > 100) {
      break;
    }

    wait 0.25;
  }

  self notify("crafting_invalidated");
}

craft_purchase_response(var_0, var_1) {
  if(var_0 == "craft_purchase") {
    var_2 = var_1 - 1;
    craft_item(var_2);
  }
}

_id_573D() {
  var_0 = _id_39BB();

  if(var_0) {
    self._id_3E57 = undefined;
  }
}

_id_39BB() {
  self setclientomnvar("ui_zm_open_crafting_menu", 0);
  return 1;
}

force_close_crafting_menu() {
  self setclientomnvar("ui_crafting_purchase_response", 2);
  _id_573D();
}

_id_FDCC(var_0, var_1) {
  if(!istrue(level._id_3E55)) {
    return;
  }
  while(var_1 scripts\cp\utility::_id_1A57()) {
    waitframe();
  }

  _id_AC01(var_1);
}

_id_3E40() {
  var_0 = level._id_3E56[0];

  if(thread _id_075A::_id_6C5D() >= var_0) {
    thread _id_075A::_id_EDD0(var_0);
    var_1 = spawnStruct();
    var_1._id_5556 = "equip_frag";
    _id_0728::giveequipment(var_1);
  }

  _id_FB4C(self);
}

_id_3E3F() {
  if(self._id_1B3D > 0) {
    return;
  }
  var_0 = level._id_3E56[2];

  if(_id_075A::_id_6C5D() >= var_0) {
    thread _id_075A::_id_EDD0(var_0);
    _id_0707::_id_6ECA(self, 1);
  }

  _id_FB4C(self);
}

craft_item(var_0) {
  var_1 = level.craftingtable[var_0];

  if(isDefined(var_1)) {
    var_2 = self[[var_1.craftfunc]](var_1);

    if(var_2 == 1) {
      self playsoundtoplayer("zmb_ui_purchase_accept", self);
      thread _id_0720::_id_BEC0("item_crafted", 1);
    }

    if(var_2 == 3) {
      self playsoundtoplayer("zmb_ui_purchase_deny", self);
      thread _id_0720::_id_BEC0("insufficient_funds", 1);
    }

    self setclientomnvar("ui_crafting_purchase_response", var_2);
  }
}

craft_armor_tier(var_0) {
  if(_id_075A::_id_6C5D() < var_0._id_3D91) {
    return 3;
  }

  var_1 = var_0.itemref == "armor_repair";

  if(var_1) {
    if(isDefined(self._id_1B3D) && self._id_1B3D > 0 && self._id_1B26 < self._id_9C09) {
      _id_0707::_id_D161(self, self._id_9C09);
      _id_0707::_id_2BF4(self, self._id_9C09);
    } else
      return 4;
  } else if(self._id_1B3D == var_0.tier - 1) {
    _id_0707::_id_6ECA(self, var_0.tier);
    _id_0707::_id_2BF4(self, self._id_9C09);
  } else
    return 4;

  _id_075A::_id_EDD0(var_0._id_3D91);
  _id_070F::createcraftarmorevent(self, self._id_1B3D, var_1);
  return 1;
}

craft_equipment(var_0) {
  if(thread _id_075A::_id_6C5D() < var_0._id_3D91) {
    return 3;
  }

  var_1 = _id_0728::_id_6A0F(var_0.itemref);
  var_2 = _id_0728::_id_6A12(var_0.itemref);

  if(var_1 >= var_2) {
    return 5;
  }

  var_3 = spawnStruct();
  var_3._id_5556 = var_0.itemref;
  var_3._id_C559 = var_0._id_CF0C;
  var_3._id_C558 = self.origin;
  _id_0728::giveequipment(var_3);
  _id_075A::_id_EDD0(var_0._id_3D91);
  _id_070F::createcraftequipmentevent(self, var_0.itemref);
  return 1;
}

craft_killstreak(var_0) {
  if(thread _id_075A::_id_6C5D() < var_0._id_3D91) {
    return 3;
  }

  switch (var_0.itemref) {
    case "equip_self_revive":
      if(!scripts\cp\utility::_id_8580("self_revive")) {
        _id_0981::_id_6ED6("self_revive", 0);
        _id_075A::_id_EDD0(var_0._id_3D91);
      } else
        return 5;

      break;
    default:
      if(scripts\cp\cp_killstreaks::is_killstreak_name(var_0.itemref)) {
        var_1 = randomintrange(0, 26);
        [var_3, var_4, var_5] = _id_073D::_id_6531(var_1, self.origin, self.angles);
        var_6 = spawnStruct();
        var_6._id_5BD9 = 1;
        scripts\cp\cp_killstreaks::grant_killstreak(var_0.itemref, var_3, var_4, var_5, var_6);
        scripts\cp\cp_playerstats::incrementcategorystat(self, "supportScorestreakStats", var_0.itemref, "uses", 1);
        _id_075A::_id_EDD0(var_0._id_3D91);
      }

      break;
  }

  return 2;
}