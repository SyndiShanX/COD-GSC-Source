/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_grenade_crate.gsc
***********************************************/

grenade_crate_init() {
  _id_86280FEFB94B6B28 = spawnStruct();
  _id_86280FEFB94B6B28.id = "grenade_crate";
  _id_86280FEFB94B6B28.weaponinfo = "iw8_health_marker_cp";
  _id_86280FEFB94B6B28.modelbase = "offhand_wm_supportbox_explosives";
  _id_86280FEFB94B6B28.hintstring = &"COOP_CRAFTING/GRENADE_TAKE";
  _id_86280FEFB94B6B28.streakname = "grenade_crate";
  _id_86280FEFB94B6B28.splashname = "used_support_box";
  _id_86280FEFB94B6B28.shadername = "compass_objpoint_deploy_friendly";
  _id_86280FEFB94B6B28.headicon = "cp_crate_icon_lethalrefill";
  _id_86280FEFB94B6B28.headiconoffset = 20;
  _id_86280FEFB94B6B28.lifespan = 90.0;
  _id_86280FEFB94B6B28.usexp = 50;
  _id_86280FEFB94B6B28.onusesfx = "ammo_crate_use";
  _id_86280FEFB94B6B28.deployedsfx = "ammo_crate_use";
  _id_86280FEFB94B6B28.deathvfx = loadfx("vfx/iw8/prop/scriptables/vfx_offhand_wm_supportbox_explosives_timeout.vfx");
  _id_86280FEFB94B6B28.onusecallback = ::healthbox_onusedeployable;
  _id_86280FEFB94B6B28.canusecallback = ::healthbox_canusedeployable;
  _id_86280FEFB94B6B28.deployfunc = ::healthbox_onusedeployable;
  _id_86280FEFB94B6B28.onusethanksbc = "stat_A4C67E28DD65B35F";
  _id_86280FEFB94B6B28.usetime = 1000;
  _id_86280FEFB94B6B28.maxhealth = 100;
  _id_86280FEFB94B6B28.maxuses = 4;
  _id_86280FEFB94B6B28.canreusebox = 0;
  _id_86280FEFB94B6B28.allowmeleedamage = 1;
  _id_86280FEFB94B6B28.damagefeedback = "";
  _id_86280FEFB94B6B28.grenadeusefunc = ::healthbox_grenadelaunchfunc;
  _id_86280FEFB94B6B28.ondeploycallback = scripts\cp\cp_deployablebox::supportbox_ondeploy;
  _id_86280FEFB94B6B28.deployanimduration = scripts\cp\cp_deployablebox::supportbox_getdeployanimduration();
  level.boxsettings["grenade_crate"] = _id_86280FEFB94B6B28;
  level.deployable_box["grenade_crate"] = [];
}

weaponswitchendedsupportbox(streakinfo, _id_41BF9BF4918115AC) {
  if(istrue(_id_41BF9BF4918115AC))
    thread supportbox_watchplayerweapon(streakinfo);
}

tryusesupportbox(streakinfo, grenade) {
  return 1;
}

healthbox_canusedeployable(_id_FBBAB18B5A41C7CB) {
  return 1;
}

healthbox_grenadelaunchfunc(_id_FBBAB18B5A41C7CB) {
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

healthbox_onusedeployable(_id_FBBAB18B5A41C7CB) {
  self endon("disconnect");
  _id_3BDA1622A11CF39B = 1;
  _id_C351B07CFBE3C36E = 1;
  primary_weapons = self getweaponslistprimaries();

  foreach(weapon in primary_weapons) {
    if(weapontype(weapon) == "projectile") {
      if(weapon.basename == "iw8_la_mike32_mp") {
        if(self.gl_proj_override == "thermite")
          continue;
      }

      if(!max_projectile_check(weapon)) {
        _id_C351B07CFBE3C36E = 0;
        self setweaponammoclip(weapon, weaponclipsize(weapon));
        self givemaxammo(weapon);
      }
    }

    if(weapon.inventorytype == "altmode" && isDefined(weapon.underbarrel) && weapon.underbarrel == "ubshtgn") {
      if(!max_projectile_check(weapon)) {
        _id_C351B07CFBE3C36E = 0;
        self setweaponammoclip(weapon, weaponclipsize(weapon));
        self setweaponammostock(weapon, 0);
      }
    }
  }

  if(_id_1DB8D0E02A99C5E2::_id_A6C819E1C09A2472()) {
    thread scripts\cp\utility::hint_prompt("max_grenades", 1, 3);
    return 0;
  }

  thread refill_grenades(self);
  return 1;
}

max_projectile_check(weapon) {
  _id_BC09CBB9B158BFE5 = self getweaponammoclip(weapon);
  _id_F07E8473F97DA13F = self getweaponammostock(weapon);
  _id_C56BBE615F626CC8 = weaponclipsize(weapon);
  _id_0A862B844906A7C8 = weaponmaxammo(weapon);

  if(_id_F07E8473F97DA13F < _id_0A862B844906A7C8 || _id_BC09CBB9B158BFE5 < _id_C56BBE615F626CC8)
    return 0;

  return 1;
}

refill_grenades(player) {
  player notify("stop_restock_recharge");
  _id_BC002676438672C9 = player _id_7EF95BBA57DC4B82::getcurrentequipment("primary");
  _id_2AEE5A9B1A165F09 = player _id_7EF95BBA57DC4B82::getcurrentequipment("secondary");
  player thread _id_7EF95BBA57DC4B82::setequipmentammo(_id_BC002676438672C9, 4);
  player thread _id_7EF95BBA57DC4B82::setequipmentammo(_id_2AEE5A9B1A165F09, 4);
  player playlocalsound("weap_ammo_pickup");
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