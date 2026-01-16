/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\item_inventory_util.gsc
***********************************************/

#include scripts\mp_common\item_world_util;

#namespace item_inventory_util;

private function_c92543a0(attachmentitem, attachmentname) {
  attachment = spawnStruct();
  attachment.id = attachmentitem.id;
  attachment.networkid = attachmentitem.networkid;
  attachment.itementry = attachmentitem.itementry;
  attachment.var_4c342187 = attachmentname;
  return attachment;
}

function_9e9c82a6(item, attachmentitem, var_41a74919 = 1, allowdupe = 0) {
  assert(isstruct(item));
  assert(isstruct(attachmentitem));

  if(!isDefined(item) || !isDefined(item.itementry) || item.itementry.itemtype != #"weapon") {
    return false;
  }

  if(!isDefined(attachmentitem) || !isDefined(attachmentitem.itementry) || !isDefined(attachmentitem.networkid) || attachmentitem.itementry.itemtype != #"attachment") {
    return false;
  }

  if(isDefined(item.attachments)) {
    foreach(attachment in item.attachments) {
      if(isDefined(attachment) && attachment.networkid == attachmentitem.networkid) {
        return false;
      }
    }
  }

  attachmentname = function_2ced1d34(item, attachmentitem.itementry, allowdupe);

  if(!isDefined(attachmentname)) {
    return false;
  }

  attachmentitem.var_4c342187 = attachmentname;

  if(!isDefined(item.attachments)) {
    item.attachments = [];
  } else if(!isarray(item.attachments)) {
    item.attachments = array(item.attachments);
  }

  item.attachments[item.attachments.size] = attachmentitem;

  if(var_41a74919) {
    function_6e9e7169(item);
  }

  return true;
}

function_2ced1d34(item, var_fe35755b, allowdupes = 0) {
  assert(isDefined(item));
  assert(isDefined(var_fe35755b));

  if(!isDefined(item) || !isDefined(item.itementry)) {
    return;
  }

  if(!isDefined(var_fe35755b)) {
    return;
  }

  if(item.itementry.itemtype != #"weapon") {
    assert(0, "<dev string:x38>");
    return;
  }

  if(var_fe35755b.itemtype != #"attachment") {
    assert(0, "<dev string:x67>");
    return;
  }

  if(!isDefined(var_fe35755b.attachments) || var_fe35755b.attachments.size <= 0) {
    return;
  }

  weapon = item_world_util::function_35e06774(item.itementry);

  if(isDefined(weapon) && isDefined(weapon.statname) && weapon.statname != #"") {
    weapon = getweapon(weapon.statname);
  }

  if(!isDefined(weapon) || !isDefined(weapon.supportedattachments) || weapon.supportedattachments.size <= 0) {
    return;
  }

  supportedattachments = weapon.supportedattachments;
  var_a2fe3d54 = undefined;

  foreach(attachment in var_fe35755b.attachments) {
    if(!isDefined(attachment)) {
      continue;
    }

    attachmenttype = attachment.attachment_type;

    if(!isDefined(attachmenttype) || attachmenttype == "") {
      continue;
    }

    foreach(var_987851f5 in weapon.supportedattachments) {
      if(attachmenttype == var_987851f5) {
        var_a2fe3d54 = attachmenttype;
        break;
      }
    }

    if(isDefined(var_a2fe3d54)) {
      break;
    }
  }

  if(!isDefined(var_a2fe3d54)) {
    return;
  }

  if(isDefined(item.attachments) && !allowdupes) {
    foreach(attachment in item.attachments) {
      if(!isDefined(attachment)) {
        continue;
      }

      if(attachment.var_4c342187 === var_a2fe3d54) {
        return;
      }
    }
  }

  foreach(slot in array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock")) {
    if(!isDefined(var_fe35755b.(slot))) {
      continue;
    }

    if(var_fe35755b.(slot) && !(isDefined(item.itementry.(slot)) && item.itementry.(slot))) {
      return;
    }
  }

  return var_a2fe3d54;
}

function_dfaca25e(weaponid, attachmentoffset) {
  return weaponid + attachmentoffset;
}

function_837f4a57(var_fe35755b) {
  if(!isDefined(var_fe35755b) || var_fe35755b.itemtype != #"attachment") {
    return;
  }

  slots = array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock");
  offsets = array(1, 2, 3, 4, 5, 6);
  assert(slots.size == offsets.size);

  for(index = 0; index < offsets.size; index++) {
    slot = slots[index];

    if(!isDefined(var_fe35755b.(slot))) {
      continue;
    }

    return offsets[index];
  }
}

function_d8cebda3(itementry) {
  assert(isstruct(itementry));
  mutators = 0;

  if(isDefined(itementry)) {
    var_b80d223d = array("doubleinventory", "double9mm", "double45cal", "double556mm", "double762mm", "double338cal", "double50cal", "double12gauge", "doublerocket", "doublesmallhealth", "doublemediumhealth", "doublelargehealth", "doublesquadhealth", "doublelethalgrenades", "doubletacticalgrenades", "doubleequipment", "doubleperk");

    for(index = 0; index < var_b80d223d.size; index++) {
      if(isDefined(itementry.(var_b80d223d[index])) && itementry.(var_b80d223d[index])) {
        mutators |= 1 << index;
      }
    }
  }

  return mutators;
}

function_2879cbe0(mutators, ammoweapon) {
  assert(isint(mutators));
  assert(isweapon(ammoweapon));

  if(!isDefined(level.var_e2df03ad)) {
    level.var_98c8f260 = [];
    var_13339abf = array(#"ammo_type_9mm_item", #"ammo_type_45_item", #"ammo_type_556_item", #"ammo_type_762_item", #"ammo_type_338_item", #"ammo_type_50cal_item", #"ammo_type_12ga_item", #"ammo_type_rocket_item");
    var_c2043143 = array(2, 4, 8, 16, 32, 64, 128, 256);

    for(index = 0; index < var_13339abf.size; index++) {
      ammoitem = var_13339abf[index];
      var_f415ce36 = getscriptbundle(ammoitem);
      weapon = var_f415ce36.weapon;
      assert(isDefined(weapon));

      if(!isDefined(weapon)) {
        continue;
      }

      var_3160a910 = weapon.ammoindex;
      level.var_98c8f260[var_3160a910] = var_c2043143[index];
    }
  }

  maxammo = ammoweapon.maxammo;
  var_6f2df38a = level.var_98c8f260[ammoweapon.ammoindex];

  if(isDefined(var_6f2df38a) && mutators&var_6f2df38a) {
    maxammo *= 2;
  }

  return maxammo;
}

function_cfa794ca(mutators, itementry) {
  assert(isDefined(itementry));
  weapon = item_world_util::function_35e06774(itementry);

  if(isDefined(weapon)) {
    if(weapon.name == #"eq_tripwire") {
      if(mutators&32768) {
        return 8;
      }

      return 4;
    }

    if(itementry.itemtype == #"health") {
      var_9b624be0 = array(#"health_item_small", #"health_item_medium", #"health_item_large", #"health_item_squad");
      var_448bc079 = array(512, 1024, 2048, 4096);

      for(index = 0; index < var_9b624be0.size; index++) {
        if(itementry.name != var_9b624be0[index]) {
          continue;
        }

        if(mutators&var_448bc079[index]) {
          return ((isDefined(itementry.stackcount) ? itementry.stackcount : 1) * 2);
        }
      }
    } else if(itementry.itemtype == #"equipment") {
      var_3e9ef0a1 = array(array(#"frag_grenade_wz_item", #"cluster_semtex_wz_item", #"acid_bomb_wz_item", #"molotov_wz_item", #"wraithfire_wz_item", #"hatchet_wz_item", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item"), array(#"swat_grenade_wz_item", #"concussion_wz_item", #"smoke_grenade_wz_item", #"smoke_grenade_wz_item_spring_holiday", #"emp_grenade_wz_item", #"spectre_grenade_wz_item"), array(#"grapple_wz_item", #"unlimited_grapple_wz_item", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"flare_gun_veh_wz_item", #"wz_snowball", #"wz_waterballoon"));
      var_24e18bcb = array(8192, 16384, 32768);

      for(equipmenttype = 0; equipmenttype < var_3e9ef0a1.size; equipmenttype++) {
        if(!(mutators&var_24e18bcb[equipmenttype])) {
          continue;
        }

        var_3e45b393 = var_3e9ef0a1[equipmenttype];

        for(index = 0; index < var_3e45b393.size; index++) {
          if(itementry.name != var_3e45b393[index]) {
            continue;
          }

          return ((isDefined(itementry.stackcount) ? itementry.stackcount : 1) * 2);
        }
      }
    }

    return (isDefined(itementry.stackcount) ? itementry.stackcount : 1);
  }

  return isDefined(itementry.stackcount) ? itementry.stackcount : 1;
}

function_4bd83c04(item) {
  assert(isDefined(item));

  if(!isDefined(item) || !isDefined(item.itementry)) {
    return false;
  }

  foreach(slot in array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock")) {
    if(isDefined(item.itementry.(slot)) && item.itementry.(slot)) {
      return true;
    }
  }

  return false;
}

get_loot_weapons() {
  assert(isplayer(self));

  if(!(isDefined(getgametypesetting(#"wzlootlockers")) ? getgametypesetting(#"wzlootlockers") : 0)) {
    return array();
  }

  if(!isplayer(self)) {
    return array();
  }

  lootweapons = self function_cf9658ca();
  var_a448692e = [];
  var_bc8a634e = associativearray(#"ar_galil_t8", 1);

  foreach(weaponname in lootweapons) {
    if(isDefined(var_bc8a634e[weaponname])) {
      continue;
    }

    var_a448692e[var_a448692e.size] = weaponname;
  }

  return var_a448692e;
}

function_70b12595(item) {
  assert(isDefined(item));
  assert(isDefined(item.itementry));

  if(!isDefined(item) || !isDefined(item.itementry)) {
    return false;
  }

  if(!isDefined(item.attachments) || !isDefined(item.itementry.attachments)) {
    return true;
  }

  if(item.attachments.size < item.itementry.attachments.size) {
    var_8697fbe7 = 0;

    foreach(attachment in item.itementry.attachments) {
      var_fe35755b = getscriptbundle(attachment.attachment_type);

      if(!isDefined(var_fe35755b) || var_fe35755b.type != #"itemspawnentry" || !isarray(var_fe35755b.attachments)) {
        continue;
      }

      var_8697fbe7++;
    }

    return (item.attachments.size >= var_8697fbe7);
  }

  return true;
}

function_ee669356(item) {
  assert(isDefined(item));
  assert(isDefined(item.itementry));

  if(!isDefined(item) || !isDefined(item.itementry)) {
    return false;
  }

  if(!isDefined(item.attachments) || !isDefined(item.itementry.attachments)) {
    return true;
  }

  foreach(attachment in item.itementry.attachments) {
    if(!item_world_util::function_7363384a(attachment.attachment_type)) {
      continue;
    }

    attachmentitem = function_4ba8fde(attachment.attachment_type);

    if(!isDefined(attachmentitem) || !isDefined(attachmentitem.itementry)) {
      return false;
    }

    if(!isDefined(item.attachments) || item.attachments.size <= 0) {
      return false;
    }

    hasattachment = 0;

    foreach(itemattachment in item.attachments) {
      if(function_73593286(itemattachment.itementry, attachmentitem.itementry)) {
        hasattachment = 1;
        break;
      }
    }

    if(!hasattachment) {
      return false;
    }
  }

  return true;
}

function_b6a27222(slotid) {
  assert(isDefined(slotid));

  foreach(weaponslot in array(16 + 1, 16 + 1 + 6 + 1)) {
    foreach(attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
      if(slotid == weaponslot + attachmentoffset) {
        return true;
      }
    }
  }

  return false;
}

function_73593286(var_2ff7916e, var_21b4f4e9) {
  if(!isDefined(var_2ff7916e) || !isDefined(var_21b4f4e9)) {
    return false;
  }

  var_f9adb977 = isDefined(var_2ff7916e.parentname) ? var_2ff7916e.parentname : var_2ff7916e.name;
  var_a3508cbe = isDefined(var_21b4f4e9.parentname) ? var_21b4f4e9.parentname : var_21b4f4e9.name;
  return var_f9adb977 == var_a3508cbe;
}

function_398b9770(weaponslotid, var_f9f8c0b5) {
  assert(isDefined(weaponslotid));
  assert(isDefined(var_f9f8c0b5));

  foreach(attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
    if(var_f9f8c0b5 == weaponslotid + attachmentoffset) {
      return true;
    }
  }

  return false;
}

function_31a0b1ef(item, attachmentitem, var_41a74919 = 1) {
  assert(isstruct(item));
  assert(isstruct(attachmentitem));

  if(!isDefined(item) || !isDefined(item.attachments) || item.attachments.size <= 0 || !isDefined(item.itementry) || item.itementry.itemtype != #"weapon") {
    return 0;
  }

  if(!isDefined(attachmentitem) || !isDefined(attachmentitem.itementry) || attachmentitem.itementry.itemtype != #"attachment") {
    return 0;
  }

  var_2496b555 = 0;

  for(index = 0; index < item.attachments.size; index++) {
    attachment = item.attachments[index];

    if(isDefined(attachment) && attachment.networkid === attachmentitem.networkid) {
      var_2496b555 = 1;
      arrayremoveindex(item.attachments, index, 0);
      break;
    }
  }

  if(var_2496b555 && var_41a74919) {
    function_6e9e7169(item);
  }

  return var_2496b555;
}

function_6e9e7169(item) {
  assert(isDefined(item));
  weapon = item_world_util::function_35e06774(item.itementry);

  if(!isDefined(weapon)) {
    return;
  }

  attachments = weapon.attachments;

  if(isDefined(item.attachments)) {
    foreach(attachment in item.attachments) {
      if(isDefined(attachment)) {
        attachments[attachments.size] = attachment.var_4c342187;
      }
    }
  }

  if(isDefined(item.var_42caf41a) && item.var_42caf41a) {
    attachments[attachments.size] = "null";
  } else {
    attachments[attachments.size] = "custom2";
  }

  weapon = getweapon(weapon.name, attachments);
  weapon = function_1242e467(weapon);
  item.var_627c698b = weapon;
}

function_2b83d3ff(item) {
  assert(isDefined(item));

  if(!isDefined(item)) {
    return undefined;
  }

  if(isDefined(item.var_627c698b)) {
    return item.var_627c698b;
  }

  var_48cfb6ca = 0;

  if(!isDefined(item.attachments) && isDefined(item.itementry) && isDefined(item.itementry.attachments)) {
    var_48cfb6ca = 1;
  }

  return item_world_util::function_35e06774(item.itementry, var_48cfb6ca);
}