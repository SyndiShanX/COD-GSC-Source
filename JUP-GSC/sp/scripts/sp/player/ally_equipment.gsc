/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\player\ally_equipment.gsc
***************************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\hud_util;
#using scripts\sp\loot;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace ally_equipment;

function ally_equipment_init() {
  precachemodel("un_military_backpack_01");
}

function ally_equipment_backpack(ally, eq_type, amount, has_model) {
  ally ally_equipment_remove();
  level.player endon("death");
  ally endon("death");
  ally endon("remove_ally_equipment");
  flag_msg = undefined;
  rpg = 0;
  string_msg = &"SHARED_HINTSTRINGS/AMMO_PICKUP";
  icon = undefined;
  flag_msg = undefined;
  eq_type = default_to(eq_type, "flash_full");
  is_offhand = 1;
  ally.support_equipment_disabled = default_to(ally.support_equipment_disabled, 0);

  if(!isDefined(ally.has_model)) {
    ally.has_model = default_to(has_model, 1);
  }

  if(istrue(ally.has_model)) {
    ally.attached_model = default_to(ally.attached_model, "un_military_backpack_01");
    ally.var_1ae907b1366dd253 = default_to(ally.var_1ae907b1366dd253, (10, 7, 8));
    ally.var_eac248c2afa119 = default_to(ally.var_eac248c2afa119, (-7, 5, -6));
    ally.var_66d195592de5a634 = default_to(ally.var_66d195592de5a634, (0, 90, 90));
    ally.model_tag = default_to(ally.model_tag, "j_spine4");
    ally.var_8690ca1f0d153417 = default_to(ally.var_8690ca1f0d153417, 1);
  }

  switch (eq_type) {
    case #"hash_a68c414683465b09":
      icon = "hud_icon_equipment_flash";
      flag_msg = "flash_full";
      string_msg = &"EQUIPMENT/FLASH_BR";
      break;
    case #"hash_d8f795eb14c75e6":
      icon = "hud_icon_equipment_smoke";
      flag_msg = "smoke_full";
      string_msg = &"EQUIPMENT/SMOKE";
      break;
    case #"hash_d675a16354a5298":
      icon = "hud_icon_equipment_smoke";
      flag_msg = "smoke_full";
      string_msg = &"EQUIPMENT/SMOKE";
      break;
    case #"hash_a8e4a914fb03a4d5":
      icon = "hud_icon_equipment_frag";
      flag_msg = "frag_full";
      string_msg = &"EQUIPMENT/FRAG_BR";
      break;
    case #"hash_c9a436974fe60919":
      icon = "hud_icon_equipment_molotov";
      flag_msg = "molotov_full";
      string_msg = &"EQUIPMENT/MOLOTOV_BR";
      break;
    case #"hash_fa1e80f6bd5b8e72":
      eq_type = "c4_sp";
    case #"hash_56a97e9cc12c06d4":
      icon = "hud_icon_equipment_c4";
      flag_msg = "c4_full";
      string_msg = &"EQUIPMENT/C4";
      break;
    case #"hash_515260130b210bff":
    case #"hash_9d57562863499a06":
    case #"hash_bfabb834c595ff16":
    case #"hash_ed185ef2530ec2b1":
      eq_type = "at_mine_sp";
    case #"hash_ab4a2e8160d2c3d":
    case #"hash_5e638d3145315dd8":
      icon = "hud_icon_equipment_at_mine";
      flag_msg = "mine_full";
      string_msg = &"EQUIPMENT/AT_MINE";
      break;
    case #"hash_ee5a421e18a58c0f":
      flag_msg = "ammo_full";
    case #"hash_6470111e4b773e43":
      flag_msg = "ammo_all";
    case #"hash_b780a36f890d44b5":
      flag_msg = "ammo_current";
      icon = "hud_icon_ammo";
      is_offhand = 0;
      break;
    case #"hash_6bbd731e4f43eb76":
      flag_msg = "ammo_current";
      icon = "hud_icon_ammo";
      is_offhand = 0;
      break;
    case #"hash_6470091e4b7731ab":
      flag_msg = "ammo_alt";
      icon = "hud_icon_loot_ammo_40mmgrenade";
      string_msg = &"WEAPON/GL_M203";
      is_offhand = 0;
      break;
    case #"hash_16f8a4115fdfa32a":
    case #"hash_390ba811ad3f09bc":
    case #"hash_cf1462f7b03a4799":
      icon = "hud_icon_ammo_rocket";
      flag_msg = "rpg_full";
      rpg = 1;
      string_msg = &"WEAPON/AMMO_POOL_LAUNCHER";
      is_offhand = 0;
      break;
    default:
      return;
  }

  if(is_offhand) {
    assert(scripts\sp\equipment\offhands::offhandisprecached(eq_type));
    ally.support_equipment = default_to(amount, 4);
  } else {
    ally.support_equipment = default_to(amount, 1);
  }

  if(isDefined(ally.attached_model)) {
    ally.eq_model = ally spawn_tag_origin(ally gettagorigin(ally.model_tag), (0, 0, 0));
    ally.eq_model dontinterpolate();
    ally.eq_model linkTo(ally, ally.model_tag, ally.var_eac248c2afa119, ally.var_66d195592de5a634);
    ally.eq_model setModel(ally.attached_model);
    ally.eq_model show();
  }

  childthread ally_equipment_backpack_interact(ally, eq_type, icon, flag_msg, string_msg);
}

function function_a51aea67738798e1(ally) {
  if(!isDefined(ally.var_5b1cbdbeba360fef)) {
    ally.var_5b1cbdbeba360fef = spawn_tag_origin((0, 0, 0), (0, 0, 0));
    ally.var_5b1cbdbeba360fef dontinterpolate();

    if(isDefined(ally.eq_model)) {
      ally.var_5b1cbdbeba360fef linkTo(ally.eq_model, "tag_origin", default_to(ally.var_1ae907b1366dd253, (0, 12, 0)), (0, 45, 0));
      return;
    }

    ally.var_5b1cbdbeba360fef linkTo(ally, "j_spine4", default_to(ally.var_1ae907b1366dd253, (0, 12, 0)), ally gettagangles("j_spine4") + (90, 90, 90));
  }
}

function ally_equipment_backpack_interact(ally, eq_type, icon, flag_msg, string_msg) {
  function_a51aea67738798e1(ally);

  for(;;) {
    while(istrue(ally.support_equipment_disabled) || function_7dbb09ffa524d01c() || cooldown_active(ally)) {
      waitframe();
    }

    use_dist = default_to(ally.use_dist, 75);
    display_dist = default_to(ally.display_dist, 200);
    ally.var_5b1cbdbeba360fef create_cursor_hint("tag_origin", (0, 0, 0), string_msg, 40, display_dist, use_dist, ally.var_8690ca1f0d153417, undefined, undefined, icon, "duration_none", undefined, undefined, 30, 120);
    result = level.player waittill_any_ents_return(ally.var_5b1cbdbeba360fef, "trigger", ally.var_5b1cbdbeba360fef, "support_equipment_disabled", level, "support_equipment_disabled");

    if(result == "support_equipment_disabled" || istrue(ally.support_equipment_disabled)) {
      ally.var_5b1cbdbeba360fef remove_cursor_hint();
    } else {
      if(getDvar(@ "package_type") == "autobuild") {
        dlog_recordevent("sp_ally_equipment", ["type", flag_msg, "levelname", level.script, "x", level.player.origin[0], "y", level.player.origin[1], "z", level.player.origin[2], "checkpoint", level.start_point, "ally", ally.script_friendname]);
      }

      ally.var_d7d251c81168fe2b = gettime();
      ally ally_equipment_think(flag_msg, eq_type);

      if(ally.support_equipment == 0) {
        ally ally_equipment_remove();
        break;
      }
    }

    waitframe();
  }
}

function cooldown_active(ally) {
  if(istrue(ally.var_8c9f79c94446e918)) {
    return false;
  }

  if(isDefined(ally.var_d7d251c81168fe2b) && gettime() - ally.var_d7d251c81168fe2b < 20000) {
    return true;
  }

  return false;
}

function ally_equipment_think(flag_msg, eq_type) {
  if(issubstr(eq_type, "ammo")) {
    function_d6ced30303d5f7a5(1);
    gave_ammo = 0;

    if(eq_type == "ammo_alt") {
      weapons = level.player getweaponslistprimaries();
      gave_ammo = function_f9983dfe5cdfd0d2(weapons, gave_ammo);
    } else if(eq_type == "ammo_all" || eq_type == "ammo_bag") {
      weapons = level.player getweaponslistall();
      gave_ammo = ally_giveammo(weapons, gave_ammo);
    } else if(eq_type == "ammo_current") {
      currentweapon = level.player getcurrentweapon();
      gave_ammo = ally_giveammo([currentweapon], gave_ammo);
    } else {
      weapons = level.player.primaryweapons;
      gave_ammo = ally_giveammo(weapons, gave_ammo);
    }

    if(!gave_ammo) {
      return;
    }

    function_33ee1aeb13f82406();
  } else {
    current_ammo = level.player getammocount(eq_type);
    maxammo = weaponmaxammo(eq_type);
    diff = maxammo - current_ammo;

    if(current_ammo == maxammo) {
      function_d6ced30303d5f7a5(0);
      return;
    }

    function_d6ced30303d5f7a5(1);

    if(flag_msg == "rpg_full") {
      level.player givemaxammo(eq_type);
      level.player switchtoweapon(eq_type);
      level.player setweaponammoclip(eq_type, weaponclipsize(eq_type));
      function_33ee1aeb13f82406();
    } else {
      var_e56a188d1825c45b = level.player function_2d5903b6e5981438(eq_type);
      var_1fa6fa16414dbc09 = undefined;

      if(isDefined(var_e56a188d1825c45b)) {
        var_1fa6fa16414dbc09 = level.player getammocount(var_e56a188d1825c45b);
      }

      if(self.support_equipment < 0) {
        var_29b65713c058661f = 4;
      } else if(diff <= self.support_equipment) {
        var_29b65713c058661f = diff + current_ammo;
      } else {
        var_29b65713c058661f = self.support_equipment + current_ammo;
      }

      if(self.support_equipment > 0) {
        self.support_equipment -= diff;
      }

      level.player give_offhand(eq_type, var_29b65713c058661f);
      level.player notify("equipment_given");
      thread scripts\sp\loot::createnotification(eq_type);

      if(isDefined(var_e56a188d1825c45b)) {
        thread ally_equipment_backpack(self, var_e56a188d1825c45b.basename, var_1fa6fa16414dbc09);
      }
    }
  }

  wait 1;
}

function function_33ee1aeb13f82406() {
  if(self.support_equipment > 0) {
    self.support_equipment -= 1;
  }
}

function function_2d5903b6e5981438(eq_type) {
  should_keep = 1;
  weapon = undefined;

  foreach(weapon in self.offhandinventory) {
    if(weapon.basename == eq_type) {
      should_keep = 0;
    }
  }

  if(istrue(should_keep)) {
    if(scripts\sp\equipment\offhands::getweaponoffhandtype(weapon) == "primaryoffhand") {
      var_6c85c3860ab378b3 = "secondaryoffhand";
    } else {
      var_6c85c3860ab378b3 = "primaryoffhand";
    }

    var_e56a188d1825c45b = self getcurrentoffhand(var_6c85c3860ab378b3);
    return var_e56a188d1825c45b;
  }
}

function ally_giveammo(weapons, gave_ammo) {
  foreach(weapon in weapons) {
    current_ammo = level.player getammocount(weapon) - weapon.clipsize;
    max_ammo = weaponmaxammo(weapon);

    if(current_ammo > weapon.maxammo + weapon.clipsize) {
      over_ammo = 0 - weapon.clipsize;

      foreach(weapon in level.player.primaryweapons) {
        over_ammo += weaponmaxammo(weapon);
      }

      if(current_ammo >= over_ammo) {
        continue;
      }
    } else if(current_ammo >= max_ammo) {
      continue;
    }

    gave_ammo = 1;
    level.player givemaxammo(weapon);
  }

  return gave_ammo;
}

function function_f9983dfe5cdfd0d2(weapons, gave_ammo) {
  foreach(weaponobj in weapons) {
    if(weaponobj.hasalternate) {
      weaponaltobj = weaponobj getaltweapon();
      current_ammo = level.player getammocount(weaponaltobj);
      max_ammo = weaponmaxammo(weaponaltobj);

      if(current_ammo >= max_ammo) {
        continue;
      }

      level.player givemaxammo(weaponaltobj);
      gave_ammo = 1;
    }
  }

  return gave_ammo;
}

function function_7dbb09ffa524d01c() {
  if(isDefined(level.var_6356b636336eac83)) {
    return [[level.var_6356b636336eac83]]();
  }

  foreach(weapon in level.player.offhandinventory) {
    if(!isDefined(weapon.maxammo)) {
      continue;
    }

    current_ammo = level.player getammocount(weapon);

    if(current_ammo < weapon.maxammo) {
      return 0;
    }
  }

  foreach(weapon in level.player.primaryweapons) {
    if(isDefined(weapon.hasalternate)) {
      weaponaltobj = weapon getaltweapon();
      grenadelauncherattachment = weaponaltweaponname(weapon);

      if(weaponaltobj.maxammo > 0 && !issubstr(grenadelauncherattachment, "select")) {
        current_ammo = level.player getammocount(weaponaltobj);

        if(current_ammo < weaponaltobj.maxammo) {
          return 0;
        }
      }
    }

    current_ammo = level.player getammocount(weapon);

    if(current_ammo < weapon.maxammo) {
      return 0;
    }

    if(current_ammo > weapon.maxammo + weapon.clipsize) {
      over_ammo = 0 - weapon.clipsize;

      foreach(weapon in level.player.primaryweapons) {
        over_ammo += weaponmaxammo(weapon);
      }

      if(current_ammo < over_ammo) {
        return 0;
      }
    }
  }

  return 1;
}

function function_d6ced30303d5f7a5(should_give) {
  if(should_give) {
    level.player player_gesture_force("iw9_ges_pickup");
    wait 0.3;
    level.player playSound("loot_pickup_offhand");
    level.player playRumbleOnEntity("damage_heavy");
    return;
  }

  level.player forceplaygestureviewmodel("iw9_ges_pickup");
  wait 0.75;
  level.player stopgestureviewmodel("iw9_ges_pickup", 0.5);
  wait 3;
}

function ally_increase_equipment(ally, ammount) {
  ammount = default_to(ammount, 1);
  ally.support_equipment = ammount;
}

function ally_equipment_remove() {
  if(isDefined(self.var_5b1cbdbeba360fef)) {
    self.var_5b1cbdbeba360fef notify("trigger");
    self.var_5b1cbdbeba360fef thread remove_cursor_hint();
  }

  if(isDefined(self.support_equipment)) {
    self.support_equipment = 0;
  }

  if(isDefined(self.eq_model)) {
    self.eq_model delete();
  }

  self notify("remove_ally_equipment");
}