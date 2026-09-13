/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_ammo_crate.gsc
***********************************************/

ammo_crate_init() {
  _id_86280FEFB94B6B28 = spawnStruct();
  _id_86280FEFB94B6B28.id = "ammo_crate";
  _id_86280FEFB94B6B28.weaponinfo = "iw8_ammo_marker_cp";
  _id_86280FEFB94B6B28.modelbase = "offhand_wm_supportbox_ammunition";
  _id_86280FEFB94B6B28.hintstring = &"COOP_CRAFTING/AMMO_CRATE_TAKE";
  _id_86280FEFB94B6B28.streakname = "ammo_crate";
  _id_86280FEFB94B6B28.splashname = "used_support_box";
  _id_86280FEFB94B6B28.shadername = "compass_objpoint_deploy_friendly";
  _id_86280FEFB94B6B28.headicon = "hud_icon_fieldupgrade_ammo_box";
  _id_86280FEFB94B6B28.headiconoffset = 20;
  _id_86280FEFB94B6B28.lifespan = 90.0;
  _id_86280FEFB94B6B28.usexp = 50;
  _id_86280FEFB94B6B28.onusesfx = "ammo_crate_use";
  _id_86280FEFB94B6B28.deployedsfx = "ammo_crate_use";
  _id_86280FEFB94B6B28.deathvfx = loadfx("vfx/iw8/prop/scriptables/vfx_offhand_wm_supportbox_ammunition_timeout.vfx");
  _id_86280FEFB94B6B28.onusecallback = ::supportbox_onusedeployable;
  _id_86280FEFB94B6B28.canusecallback = ::supportbox_canusedeployable;
  _id_86280FEFB94B6B28.deployfunc = ::give_ammo_to_player_through_crate;
  _id_86280FEFB94B6B28.onusethanksbc = "stat_A4C67E28DD65B35F";
  _id_86280FEFB94B6B28.usetime = 1000;
  _id_86280FEFB94B6B28.maxhealth = 100;
  _id_86280FEFB94B6B28.maxuses = 4;
  _id_86280FEFB94B6B28.canreusebox = 0;
  _id_86280FEFB94B6B28.allowmeleedamage = 1;
  _id_86280FEFB94B6B28.damagefeedback = "";
  _id_86280FEFB94B6B28.grenadeusefunc = ::supportbox_grenadelaunchfunc;
  _id_86280FEFB94B6B28.ondeploycallback = scripts\cp\cp_deployablebox::supportbox_ondeploy;
  _id_86280FEFB94B6B28.deployanimduration = scripts\cp\cp_deployablebox::supportbox_getdeployanimduration();
  level.boxsettings["ammo_crate"] = _id_86280FEFB94B6B28;
  level.deployable_box["ammo_crate"] = [];
}

weaponswitchendedsupportbox(streakinfo, _id_41BF9BF4918115AC) {
  if(istrue(_id_41BF9BF4918115AC))
    thread supportbox_watchplayerweapon(streakinfo);
}

tryusesupportbox(streakinfo, grenade) {
  return 1;
}

supportbox_canusedeployable(_id_FBBAB18B5A41C7CB) {
  return 1;
}

supportbox_grenadelaunchfunc(_id_FBBAB18B5A41C7CB) {
  start = self gettagorigin("tag_accessory_left");
  speed = 400;
  f = anglesToForward(self.angles);
  _id_AC0E454AC96A77AC = anglestoup(self.angles);
  _id_AC0E454AC96A77AC = _id_AC0E454AC96A77AC * 0.6;
  dir = vectorNormalize(f + _id_AC0E454AC96A77AC);
  velocity = dir * speed;
  _id_2249366B1972061F = magicbullet("iw8_ammocrate_marker_zm", start, start + velocity, self);
  self notify("grenade_fire", _id_2249366B1972061F);
}

supportbox_onusedeployable(_id_FBBAB18B5A41C7CB) {
  self endon("disconnect");

  if(cangive_ammo()) {
    give_ammo_to_player_through_crate();
    return 1;
  } else {
    thread scripts\cp\utility::hint_prompt("max_ammo", 1, 3);
    return 0;
  }

  return 1;
}

supportbox_watchplayerweapon(streakinfo) {
  self endon("disconnect");
  self endon("deployable_deployed");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  result = scripts\engine\utility::waittill_any_return_3("grenade_fire", "cancel_deploy", "weapon_switch_started");

  if(!isDefined(result)) {
    return;
  }
  if(result == "cancel_deploy")
    self switchtoweapon(self.lastdroppableweaponobj);

  for(;;) {
    currentweapon = self getcurrentweapon();

    if(currentweapon != streakinfo.objweapon) {
      self notify("killstreak_finished_with_weapon_" + streakinfo.weaponname);
      break;
    }

    waitframe();
  }
}

supportbox_handledamage() {
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];
}

supportbox_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];
  attacker notify("destroyed_equipment");
}

supportbox_modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  _id_702BFC08FABD86CB = damage;
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];
  return _id_702BFC08FABD86CB;
}

supportbox_waittill_removeorweaponchange(_id_BD2F118C743AB788, _id_E12EB6C8616BE7DC) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  ent = spawnStruct();
  thread supportbox_waittill_notify(_id_BD2F118C743AB788, ent);
  thread supportbox_waittill_notify(_id_E12EB6C8616BE7DC, ent);
  ent waittill("returned", msg, param);
  ent notify("die");
  info = spawnStruct();
  info.msg = msg;
  info.param = param;
  return info;
}

supportbox_waittill_notify(msg, ent) {
  self endon("death");
  self endon("disconnect");
  ent endon("die");
  self waittill(msg, param);
  ent notify("returned", msg, param);
}

cangive_ammo() {
  currentweapon = scripts\cp\utility::getvalidtakeweapon();
  _id_E719A0688FE8F78A = istrue(currentweapon.hasalternate);
  _id_F0E3B6926C055710 = istrue(currentweapon.isalternate);

  if(_id_E719A0688FE8F78A || _id_F0E3B6926C055710) {
    if(max_ammo_check(currentweapon)) {
      weapon = get_alt_weapon(currentweapon);

      if(isDefined(weapon)) {
        if(max_ammo_check(weapon))
          return 0;

        return 1;
      }

      return 0;
    }
  } else if(max_ammo_check(currentweapon))
    return 0;

  return 1;
}

get_alt_weapon(weapon) {
  basename = weapon.basename;
  primary_weapons = self getweaponslistprimaries();
  currentweapon = undefined;

  foreach(gun in primary_weapons) {
    if(gun.basename == basename && gun != weapon) {
      currentweapon = gun;
      break;
    }
  }

  if(isDefined(currentweapon))
    return currentweapon;
}

max_ammo_check(weapon) {
  if(weapontype(weapon) == "projectile")
    return 1;

  _id_0DE8A9EAD75A0581 = self getweaponammoclip(weapon);
  _id_C56BBE615F626CC8 = weaponclipsize(weapon);
  _id_0A862B844906A7C8 = weaponmaxammo(weapon);

  if(istrue(weapon.isalternate)) {
    if(isDefined(weapon.underbarrel) && weapon.underbarrel == "ubshtgn")
      _id_0A862B844906A7C8 = 0;
  }

  _id_82068CA6D5B3C991 = self getweaponammostock(weapon);

  if(_id_82068CA6D5B3C991 < _id_0A862B844906A7C8 || _id_0DE8A9EAD75A0581 < _id_C56BBE615F626CC8)
    return 0;

  return 1;
}

give_ammo_to_player_through_crate() {
  primary_weapons = self getweaponslistprimaries();

  foreach(weapon in primary_weapons) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(weapontype(weapon) == "riotshield") {
      continue;
    }
    if(weapontype(weapon) == "projectile") {
      continue;
    }
    if(isDefined(weapon.classname) && weapon.classname == "grenade") {
      continue;
    }
    if(_id_74502A9E0EF1F19C::is_incompatible_weapon(weapon)) {
      continue;
    }
    if(weapon_should_not_get_ammo(weapon)) {
      continue;
    }
    if(weapon.inventorytype == "altmode") {
      if(isDefined(weapon.underbarrel) && weapon.underbarrel == "ubshtgn") {
        self setweaponammoclip(weapon, weaponclipsize(weapon));
        self setweaponammostock(weapon, 0);
      }

      continue;
    }

    scripts\cp\utility::_id_AD3CE5E1679DF13D(weapon);
    _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(weapon);
    self setweaponammoclip(weapon, 999, "left");
    self setweaponammoclip(weapon, 999, "right");
  }

  self playlocalsound("weap_ammo_pickup");
}

weapon_should_not_get_ammo(weapon) {
  weapon_name = weapon.basename;

  switch (weapon_name) {
    case "iw9_minigunksjugg_mp":
    case "iw9_lm_dblmg2_cp":
      return 1;
    default:
      break;
  }

  return 0;
}

adjust_clip_ammo_from_stock(player, sweapon, _id_A9F996CAF54DD68C, _id_A7BE10E54A3A4B99, _id_6747B178B5FC3B95) {
  if(!istrue(_id_6747B178B5FC3B95)) {
    _id_AB0EE360900BCB85 = weaponmaxammo(sweapon);
    _id_DD2DECF8DB7E69B8 = player getweaponammostock(sweapon);
    _id_E074B618E47255FE = _id_AB0EE360900BCB85 - _id_DD2DECF8DB7E69B8;
    _id_DB98701B04A114DB = scripts\engine\utility::ter_op(_id_E074B618E47255FE >= _id_A7BE10E54A3A4B99, _id_DD2DECF8DB7E69B8 + _id_A7BE10E54A3A4B99, _id_AB0EE360900BCB85);
    player setweaponammostock(sweapon, _id_DB98701B04A114DB);
  }

  _id_3DBC3B058135CBFB = player getweaponammoclip(sweapon, _id_A9F996CAF54DD68C);
  _id_2A83DF6C49112D96 = _id_A7BE10E54A3A4B99 - _id_3DBC3B058135CBFB;
  _id_2AA9CAEF99C9AF77 = min(_id_3DBC3B058135CBFB + _id_2A83DF6C49112D96, _id_A7BE10E54A3A4B99);
  player setweaponammoclip(sweapon, int(_id_2AA9CAEF99C9AF77), _id_A9F996CAF54DD68C);
}

test_ammo_crate(player) {
  player thread watch_dpad();
  player notify("new_power", "crafted_autosentry");
  scripts\cp\utility::set_crafted_inventory_item("crafted_autosentry", ::give_crafted_ammo_crate, player);
}

give_crafted_ammo_crate(_id_DF071553D0996FF9, player) {
  player thread watch_dpad();
  player notify("new_power", "crafted_autosentry");
  scripts\cp\utility::set_crafted_inventory_item("crafted_autosentry", ::give_crafted_ammo_crate, player);
}

watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self endon("remove_sentry");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_sentry", "+actionslot 4");

  for(;;) {
    self waittill("pullout_sentry");

    if(istrue(self.iscarrying)) {
      continue;
    }
    if(istrue(self.linked_to_coaster)) {
      continue;
    }
    if(isDefined(self.allow_carry) && self.allow_carry == 0) {
      continue;
    }
    if(scripts\cp\utility::is_valid_player()) {
      break;
    }
  }
}