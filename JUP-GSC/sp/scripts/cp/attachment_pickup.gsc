/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\attachment_pickup.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\pickups;
#using scripts\cp\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace attachment_pickup;

function function_8b7dae212f7ff902() {
  level.var_5ff8e03eb9e6b4 = "reflex,therm, acog, hybrid,holo ,magazine,gl,ubsh,brake,comp,grip,cash";
  level.var_5ff8e03eb9e6b4 = function_8cecd5dd91836bba(level.var_5ff8e03eb9e6b4);
  function_845600fab0a4a95b();
  pickups = getEntArray("attachment_pickup", "targetname");

  foreach(pickup in pickups) {
    pickup thread function_aba2da3a3ea77c90();
  }
}

function function_8cecd5dd91836bba(var_3bc79acda463a258) {
  var_a6a1f6fe2990c155 = strtok(var_3bc79acda463a258, " ");
  new_string = undefined;

  if(var_a6a1f6fe2990c155.size > 1) {
    new_string = var_a6a1f6fe2990c155[0];

    for(i = 1; i < var_a6a1f6fe2990c155.size; i++) {
      new_string += var_a6a1f6fe2990c155[i];
    }

    return new_string;
  }

  return var_3bc79acda463a258;
}

function function_aba2da3a3ea77c90() {
  var_77460031ae8e47a4 = level.var_5ff8e03eb9e6b4;

  if(isDefined(self.script_noteworthy)) {
    var_77460031ae8e47a4 = self.script_noteworthy;
    var_77460031ae8e47a4 = function_8cecd5dd91836bba(var_77460031ae8e47a4);
  }

  type_array = strtok(var_77460031ae8e47a4, ",");

  if(type_array.size == 1) {
    attachment_type = type_array[0];
  } else {
    attachment_type = function_17c409fd49d47c84(type_array);
  }

  if(attachment_type == "cash") {
    function_8d01902b9d93b4c6();
    self delete();
    return;
  }

  new_model = function_d8e20b4db8aa13df(attachment_type);

  if(isDefined(new_model)) {
    self setModel(new_model);
  }

  self.base_type = function_de6f178182ba85a(attachment_type);
  self.attachment_type = attachment_type;
  hint_string = function_4b8d9fcb8af000f9(attachment_type);
  self makeusable();
  self setHintString(hint_string);
  self sethintdisplayrange(512);
  self setCursorHint("HINT_BUTTON");
  self setuserange(75);

  while(true) {
    self waittill("trigger", player);
    var_674582f0e7ce1160 = function_9e4552c702a237c5(player, attachment_type);

    if(!isDefined(var_674582f0e7ce1160.attachment)) {
      break;
    } else if(var_674582f0e7ce1160.attachment == "failed") {} else if(issubstr(var_674582f0e7ce1160.attachment, "iron")) {
      break;
    } else {
      attachment_type = var_674582f0e7ce1160.attachment;
      new_model = function_d8e20b4db8aa13df(attachment_type);

      if(isDefined(new_model)) {
        self setModel(new_model);
      }

      type_array = function_5fbcc7fc1266b377(self.base_type);

      foreach(attachment in type_array) {
        if(issubstr(attachment_type, attachment)) {
          attachment_type = attachment;
          break;
        }
      }

      hint_string = function_4b8d9fcb8af000f9(attachment_type);
      self setHintString(hint_string);
      self.attachment_type = attachment_type;

      if(isDefined(var_674582f0e7ce1160.var_42006c656a8f39fb)) {
        self.ammo_clip = var_674582f0e7ce1160.var_42006c656a8f39fb;
        self.ammo_stock = var_674582f0e7ce1160.var_f24c44ff50730d8b;
      }
    }

    wait 0.25;
  }

  self delete();
}

function function_17c409fd49d47c84(list) {
  array = [];
  total_weight = 0;

  foreach(element in list) {
    weight = function_306995537187bee2(element);

    if(weight > 0) {
      total_weight += weight;
      array[total_weight] = element;
    }
  }

  rand_num = randomint(total_weight);
  cur_smallest = total_weight;

  foreach(key, value in array) {
    if(key > rand_num) {
      if(key < cur_smallest) {
        cur_smallest = key;
      }
    }
  }

  return array[cur_smallest];
}

function function_845600fab0a4a95b() {
  level.var_b03faa157debd02a = [];
  level.var_b03faa157debd02a["reflex"] = 20;
  level.var_b03faa157debd02a["therm"] = 10;
  level.var_b03faa157debd02a["acog"] = 10;
  level.var_b03faa157debd02a["hybrid"] = 10;
  level.var_b03faa157debd02a["holo"] = 10;
  level.var_b03faa157debd02a["scope"] = 10;
  level.var_b03faa157debd02a["silencer"] = 10;
  level.var_b03faa157debd02a["brake"] = 20;
  level.var_b03faa157debd02a["comp"] = 20;
  level.var_b03faa157debd02a["flash"] = 10;
  level.var_b03faa157debd02a["melee"] = 10;
  level.var_b03faa157debd02a["choke"] = 10;
  level.var_b03faa157debd02a["grip"] = 20;
  level.var_b03faa157debd02a["gl"] = 20;
  level.var_b03faa157debd02a["ubsh"] = 20;
  level.var_b03faa157debd02a["magazine"] = 30;
  level.var_b03faa157debd02a["mags"] = 30;
  level.var_b03faa157debd02a["drum"] = 20;
  level.var_b03faa157debd02a["cal"] = 20;
  level.var_b03faa157debd02a["trig"] = 10;
  level.var_b03faa157debd02a["pistol"] = 10;
  level.var_b03faa157debd02a["cash"] = 10;
}

function function_306995537187bee2(type_string) {
  if(isDefined(level.var_b03faa157debd02a[type_string])) {
    return level.var_b03faa157debd02a[type_string];
  }

  return 10;
}

function function_8d01902b9d93b4c6() {
  drop_type = "brloot_plunder_cash_common_1";
  amount = 100;
  dropinfo = spawnStruct();
  dropinfo.origin = self.origin;
  dropinfo.angles = self.angles;
  dropinfo.payload = 13827;
  dropinfo.payload = 0;
  item = scripts\cp\pickups::spawnpickup(drop_type, dropinfo, amount, 1, undefined, 1);
}

function function_d8e20b4db8aa13df(var_8c3c8ce6accb8243) {
  return "container_ammo_box_01_nophysics";
}

function function_9e4552c702a237c5(player, attachment_type) {
  var_674582f0e7ce1160 = spawnStruct();
  base_type = function_de6f178182ba85a(attachment_type);

  if(!isDefined(base_type)) {
    iprintlnbold("Cannot use this " + attachment_type + " attachment");
    var_674582f0e7ce1160.attachment = "failed";
    return var_674582f0e7ce1160;
  }

  var_8c3c8ce6accb8243 = undefined;

  if(!function_bd75d13c13984bd0(attachment_type)) {
    var_8c3c8ce6accb8243 = [attachment_type];
  }

  curweapon = player getcurrentweapon();
  player.gunsmithattachments = player function_fb5497098da5db2a(curweapon, base_type);

  if(!isDefined(player.gunsmithattachments) || player.gunsmithattachments.size == 0) {
    iprintlnbold("Cannot use this " + attachment_type + " attachment");
    var_674582f0e7ce1160.attachment = "failed";
    return var_674582f0e7ce1160;
  }

  var_effb4ae1788a8b10 = player function_bea1ef4192c7c497(curweapon, player.gunsmithattachments, var_8c3c8ce6accb8243);

  if(isDefined(var_effb4ae1788a8b10)) {
    displaystring = tablelookupistring("mp/attachmenttable.csv", 4, var_effb4ae1788a8b10, 3);
    iprintlnbold(var_effb4ae1788a8b10 + " / " + var_effb4ae1788a8b10);
    iprintln(displaystring);
    ammo_clip = undefined;
    ammo_stock = undefined;

    if(isDefined(self.ammo_clip)) {
      ammo_clip = self.ammo_clip;
      ammo_stock = self.ammo_stock;
    }

    var_674582f0e7ce1160 = player function_60fdadc426db6334(curweapon, var_effb4ae1788a8b10, ammo_clip, ammo_stock);
    return var_674582f0e7ce1160;
  }

  iprintlnbold("Cannot use this " + attachment_type + " attachment");
  var_674582f0e7ce1160.attachment = "failed";
  return var_674582f0e7ce1160;
}

function function_bd75d13c13984bd0(attachment_type) {
  switch (attachment_type) {
    case #"hash_c9e63a9bddd371e":
    case #"hash_2630d03d6f5fc192":
    case #"hash_3c53eb274322e803":
    case #"hash_412112410dc298ec":
    case #"hash_6fc1c97a058fdcc9":
    case #"hash_754f51acf0f54d82":
    case #"hash_a836d5af28105786":
    case #"hash_c693ed0e3896fe7b":
    case #"hash_e32d2a49d1ac024c":
    case #"hash_ee66a2867a3477e3":
      return true;
  }

  return false;
}

function function_de6f178182ba85a(attachment_type) {
  switch (attachment_type) {
    case #"hash_c9e63a9bddd371e":
    case #"hash_2c52850905eba1cb":
    case #"hash_562af81e4f0e0363":
    case #"hash_64b510104b17ffc3":
    case #"hash_a3ace681aebdd3a5":
    case #"hash_bd4d2e05f809e09f":
    case #"hash_dd93145493d0c039":
      return "optic";
    case #"hash_1cf09102712cef10":
    case #"hash_6605477145cc573a":
    case #"hash_b083bda1f739c2b7":
    case #"hash_e32d2a49d1ac024c":
    case #"hash_ea093129bbd4504a":
      return "muzzle";
    case #"hash_754f51acf0f54d82":
    case #"hash_dd65960f4365976d":
    case #"hash_fa11b8f6bd51593e":
    case #"hash_fc10e6650f85ea75":
      return "undermount";
    case #"hash_1a86006c17e03b1f":
    case #"hash_306c23099bffb04d":
    case #"hash_3c53eb274322e803":
    case #"hash_fb08f234e4b4da65":
      return "magazine";
    case #"hash_47826d3ddc469627":
    case #"hash_8303296e4f25ed9b":
    case #"hash_ee66a2867a3477e3":
      return "trigger";
    case #"hash_719417cb1de832b6":
    case #"hash_c693ed0e3896fe7b":
      return "reargrip";
    case #"hash_a836d5af28105786":
      return "unique";
    default:
      return "optic";
  }

  return undefined;
}

function function_5fbcc7fc1266b377(base_type) {
  switch (base_type) {
    case #"hash_c9e63a9bddd371e":
      return ["reflex", "therm", "acog", "hybrid", "holo", "scope"];
    case #"hash_e32d2a49d1ac024c":
      return ["silencer", "brake", "comp", "choke"];
    case #"hash_754f51acf0f54d82":
      return ["grip", "gl", "ubsh"];
    case #"hash_3c53eb274322e803":
      return ["mags", "drum", "cal"];
    case #"hash_ee66a2867a3477e3":
      return ["trig", "hammer"];
    case #"hash_c693ed0e3896fe7b":
      return ["pistol"];
    case #"hash_a836d5af28105786":
      return ["unique"];
  }

  return undefined;
}

function function_4b8d9fcb8af000f9(attachment_type) {
  switch (attachment_type) {
    case #"hash_c9e63a9bddd371e":
      return &"CP_WEAPON_BUY/ATTACHMENT_OPTIC";
    case #"hash_bd4d2e05f809e09f":
      return &"CP_WEAPON_BUY/ATTACHMENT_REFLEX";
    case #"hash_a3ace681aebdd3a5":
      return &"CP_WEAPON_BUY/ATTACHMENT_THERMAL";
    case #"hash_562af81e4f0e0363":
      return &"CP_WEAPON_BUY/ATTACHMENT_ACOG";
    case #"hash_64b510104b17ffc3":
      return &"CP_WEAPON_BUY/ATTACHMENT_HYBRID";
    case #"hash_dd93145493d0c039":
      return &"CP_WEAPON_BUY/ATTACHMENT_HOLO";
    case #"hash_2c52850905eba1cb":
      return &"CP_WEAPON_BUY/ATTACHMENT_SNIPERSCOPE";
    case #"hash_e32d2a49d1ac024c":
    case #"hash_b083bda1f739c2b7":
    case #"hash_a68c414683465b09":
    case #"hash_40a94c5d9e4e265b":
    case #"hash_6605477145cc573a":
      return &"CP_WEAPON_BUY/ATTACHMENT_MUZZLE";
    case #"hash_1cf09102712cef10":
      return &"CP_WEAPON_BUY/ATTACHMENT_BRAKE";
    case #"hash_ea093129bbd4504a":
      return &"CP_WEAPON_BUY/ATTACHMENT_COMP";
    case #"hash_3b4588bd30f76bd7":
    case #"hash_754f51acf0f54d82":
      return &"CP_WEAPON_BUY/ATTACHMENT_UNDERMOUNT";
    case #"hash_fa11b8f6bd51593e":
      return &"CP_WEAPON_BUY/ATTACHMENT_UBGL";
    case #"hash_fc10e6650f85ea75":
      return &"CP_WEAPON_BUY/ATTACHMENT_UBSH";
    case #"hash_dd65960f4365976d":
      return &"CP_WEAPON_BUY/ATTACHMENT_GRIP";
    case #"hash_3c53eb274322e803":
    case #"hash_306c23099bffb04d":
    case #"hash_1a86006c17e03b1f":
    case #"hash_fb08f234e4b4da65":
      return &"CP_WEAPON_BUY/ATTACHMENT_MAGAZINE";
    case #"hash_412112410dc298ec":
    case #"hash_125f83890bcd3175":
      return &"CP_WEAPON_BUY/ATTACHMENT_BACK";
    case #"hash_2630d03d6f5fc192":
    case #"hash_2125856c1b2381fa":
      return &"CP_WEAPON_BUY/ATTACHMENT_FRONT";
    case #"hash_8303296e4f25ed9b":
    case #"hash_ee66a2867a3477e3":
    case #"hash_47826d3ddc469627":
      return &"CP_WEAPON_BUY/ATTACHMENT_TRIGGER";
    case #"hash_c693ed0e3896fe7b":
    case #"hash_719417cb1de832b6":
      return &"CP_WEAPON_BUY/ATTACHMENT_GRIP";
    case #"hash_a836d5af28105786":
      return &"CP_WEAPON_BUY/ATTACHMENT_UNIQUE";
  }

  return &"CP_WEAPON_BUY/ATTACHMENT_DEFAULT";
}

function function_fb5497098da5db2a(weapon, category) {
  weapon = getweaponrootname(weapon);

  if(!isDefined(category) || category == "1") {
    category = attachmentmap_tocategory(level.weaponattachments[weapon][0]);
  }

  var_28e5fd1571faec86 = [];

  if(!isDefined(level.weaponattachments[weapon])) {
    return undefined;
  }

  foreach(attachment in level.weaponattachments[weapon]) {
    if(string_starts_with(attachment, "pistolgrip")) {
      if(category == "reargrip") {
        var_28e5fd1571faec86[var_28e5fd1571faec86.size] = attachment;
      }

      continue;
    }

    if(attachmentmap_tocategory(attachment) == category) {
      var_28e5fd1571faec86[var_28e5fd1571faec86.size] = attachment;
    }
  }

  return var_28e5fd1571faec86;
}

function function_bea1ef4192c7c497(weapon, attachments, var_8c3c8ce6accb8243) {
  if(isDefined(var_8c3c8ce6accb8243)) {
    new_array = [];

    foreach(attachment_string in var_8c3c8ce6accb8243) {
      foreach(attachment in attachments) {
        if(issubstr(attachment, attachment_string)) {
          new_array[new_array.size] = attachment;
        }
      }
    }

    if(new_array.size == 0) {
      return undefined;
    } else {
      attachments = new_array;
    }
  }

  attachments = array_randomize(attachments);
  self.var_d1786583fce8a543 = attachments[0];
  return self.var_d1786583fce8a543;
}

function function_60fdadc426db6334(weapon, attachment, ammo_clip, ammo_stock) {
  attachments = getweaponattachments(weapon);
  old_attachments = attachments;
  var_3cec9a92a775752e = 0;

  if(array_contains(attachments, attachment)) {
    var_3cec9a92a775752e = 1;
  }

  attachments = array_add(attachments, attachment);
  attachments = array_remove_duplicates(attachments);
  new_attachment = attachment;
  root_name = getweaponrootname(weapon);
  var_74fff52b1e2c1bfb = 0;

  if(weapon.inventorytype == "altmode") {
    var_74fff52b1e2c1bfb = 1;
  }

  clip_ammo = self getweaponammoclip(weapon);
  stock_ammo = self getweaponammostock(weapon);
  alt_clip_ammo = undefined;
  alt_stock_ammo = undefined;
  var_7589f78d5d7ba855 = undefined;
  primary_weapons = self getweaponslistprimaries();

  foreach(cur_weapon in primary_weapons) {
    if(cur_weapon.basename == weapon.basename) {
      if(cur_weapon.inventorytype == "altmode") {
        alt_clip_ammo = self getweaponammoclip(cur_weapon);
        alt_stock_ammo = self getweaponammostock(cur_weapon);
        continue;
      }

      clip_ammo = self getweaponammoclip(cur_weapon);
      stock_ammo = self getweaponammostock(cur_weapon);
    }
  }

  newweapon = scripts\cp_mp\weapon::buildweapon(getweaponrootname(weapon), attachments);
  var_9009bfbc354a4c09 = getweaponattachments(newweapon);
  replaced_attachment = undefined;

  foreach(attachment in old_attachments) {
    found = 0;

    foreach(obj in var_9009bfbc354a4c09) {
      if(attachment == obj) {
        found = 1;
      }
    }

    if(!found) {
      replaced_attachment = attachment;
    }
  }

  new_basename = newweapon.basename;
  var_42006c656a8f39fb = undefined;
  var_f24c44ff50730d8b = undefined;

  if(isDefined(replaced_attachment)) {
    if(issubstr(replaced_attachment, "gl") || issubstr(replaced_attachment, "ubsh")) {
      var_42006c656a8f39fb = alt_clip_ammo;
      var_f24c44ff50730d8b = alt_stock_ammo;
    } else {
      var_7589f78d5d7ba855 = 1;
    }
  } else if(issubstr(new_attachment, "gl") || issubstr(new_attachment, "ubsh")) {
    if(var_3cec9a92a775752e) {
      var_42006c656a8f39fb = alt_clip_ammo;
      var_f24c44ff50730d8b = alt_stock_ammo;
    }
  } else {
    var_7589f78d5d7ba855 = 1;
  }

  self takeweapon(weapon);
  self giveweapon(newweapon);
  self switchtoweapon(newweapon);
  primary_weapons = self getweaponslistprimaries();

  foreach(weapon in primary_weapons) {
    if(weapon.basename == new_basename) {
      if(weapon.inventorytype == "altmode") {
        if(isDefined(weapon.underbarrel)) {
          if(istrue(var_7589f78d5d7ba855)) {
            self setweaponammoclip(weapon, alt_clip_ammo);
            self setweaponammostock(weapon, alt_stock_ammo);
          } else {
            if(isDefined(ammo_clip)) {
              self setweaponammoclip(weapon, ammo_clip);
            } else {
              self setweaponammoclip(weapon, weaponclipsize(weapon));
            }

            if(weapon.underbarrel == "ubshtgn") {
              self setweaponammostock(weapon, 0);
            } else if(isDefined(ammo_stock)) {
              self setweaponammostock(weapon, ammo_stock);
            } else {
              self setweaponammostock(weapon, scripts\cp\utility::function_ed18a118c6fa5c4f(weapon));
            }
          }
        } else {
          self setweaponammoclip(weapon, clip_ammo);
          self setweaponammostock(weapon, stock_ammo);
        }

        continue;
      }

      self setweaponammoclip(weapon, clip_ammo);
      self setweaponammostock(weapon, stock_ammo);
    }
  }

  var_674582f0e7ce1160 = spawnStruct();
  var_674582f0e7ce1160.attachment = replaced_attachment;

  if(isDefined(var_42006c656a8f39fb)) {
    var_674582f0e7ce1160.var_42006c656a8f39fb = int(float(var_42006c656a8f39fb));
    var_674582f0e7ce1160.var_f24c44ff50730d8b = int(float(var_f24c44ff50730d8b));
  }

  return var_674582f0e7ce1160;
}

function function_f0474c520f02df01() {}