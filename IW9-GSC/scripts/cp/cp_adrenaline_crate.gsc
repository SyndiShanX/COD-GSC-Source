/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_adrenaline_crate.gsc
***********************************************/

adrenaline_crate_init() {
  _id_86280FEFB94B6B28 = spawnStruct();
  _id_86280FEFB94B6B28.id = "adrenaline";
  _id_86280FEFB94B6B28.modelbase = "offhand_wm_supportbox";
  _id_86280FEFB94B6B28.hintstring = &"COOP_CRAFTING/ADRENALINE_TAKE";
  _id_86280FEFB94B6B28.streakname = "adrenaline";
  _id_86280FEFB94B6B28.splashname = "used_support_box";
  _id_86280FEFB94B6B28.shadername = "compass_objpoint_deploy_friendly";
  _id_86280FEFB94B6B28.headiconoffset = 20;
  _id_86280FEFB94B6B28.lifespan = 90.0;
  _id_86280FEFB94B6B28.usexp = 50;
  _id_86280FEFB94B6B28.onusesfx = "ammo_crate_use";
  _id_86280FEFB94B6B28.deployedsfx = "ammo_crate_use";
  _id_86280FEFB94B6B28.deathvfx = loadfx("vfx/iw7/core/mp/killstreaks/vfx_dp_pickup_dust.vfx");
  _id_86280FEFB94B6B28.onusecallback = ::adrenalinebox_onusedeployable;
  _id_86280FEFB94B6B28.canusecallback = ::adrenalinebox_canusedeployable;
  _id_86280FEFB94B6B28.deployfunc = ::adrenalinebox_onusedeployable;
  _id_86280FEFB94B6B28.usetime = 1000;
  _id_86280FEFB94B6B28.maxhealth = 100;
  _id_86280FEFB94B6B28.maxuses = 4;
  _id_86280FEFB94B6B28.canreusebox = 0;
  _id_86280FEFB94B6B28.allowmeleedamage = 1;
  _id_86280FEFB94B6B28.damagefeedback = "";
  _id_86280FEFB94B6B28.grenadeusefunc = ::supportbox_grenadelaunchfunc;
  _id_86280FEFB94B6B28.ondeploycallback = scripts\cp\cp_deployablebox::supportbox_ondeploy;
  _id_86280FEFB94B6B28.deployanimduration = scripts\cp\cp_deployablebox::supportbox_getdeployanimduration();
  level.boxsettings["adrenaline"] = _id_86280FEFB94B6B28;
  level.deployable_box["adrenaline"] = [];
}

weaponswitchendedsupportbox(streakinfo, _id_41BF9BF4918115AC) {
  if(istrue(_id_41BF9BF4918115AC))
    thread supportbox_watchplayerweapon(streakinfo);
}

tryusesupportbox(streakinfo, grenade) {
  return 1;
}

adrenalinebox_canusedeployable(_id_FBBAB18B5A41C7CB) {
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

adrenalinebox_onusedeployable(_id_FBBAB18B5A41C7CB) {
  self endon("disconnect");
  thread give_auto_revive();
  self setclientomnvar("ui_self_revive", 1);
}

give_adrenaline_for_time(timer) {
  _id_2099048A1823BA6B = self.perk_data["regen_time_scalar"];
  self.perk_data["regen_time_scalar"] = 5;
  scripts\cp\utility::giveperk("specialty_quickdraw");
  scripts\cp\utility::giveperk("specialty_quickswap");
  scripts\cp\utility::giveperk("specialty_lightweight");
  scripts\cp\utility::giveperk("specialty_fastreload");
  scripts\cp\utility::giveperk("specialty_stalker");
  scripts\cp\utility::giveperk("specialty_fastoffhand");
  scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
  scripts\cp\cp_visionsets::add_visionset_to_stack(self, "alien_feral", 2);
  self lerpfovbypreset("80_instant");
  wait(timer);
  self.perk_data["regen_time_scalar"] = _id_2099048A1823BA6B;
  scripts\cp\utility::_unsetperk("specialty_quickswap");
  scripts\cp\utility::_unsetperk("specialty_quickdraw");
  scripts\cp\utility::_unsetperk("specialty_lightweight");
  scripts\cp\utility::_unsetperk("specialty_fastreload");
  scripts\cp\utility::_unsetperk("specialty_stalker");
  scripts\cp\utility::_unsetperk("specialty_fastoffhand");
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
  self lerpfovbypreset("default_2seconds");
  scripts\cp\cp_visionsets::remove_visionset_specific_from_stack(self, "alien_feral", 2);
}

give_auto_revive() {
  self endon("disconnect");
  self.has_auto_revive = 1;
  self waittill("last_stand");
  wait 0.1;

  if(_id_0AFB7E332AEE4BF2::player_in_laststand(self)) {
    _id_0AFB7E332AEE4BF2::instant_revive(self);

    if(isDefined(self.dogtag))
      self.dogtag delete();
  }

  self.has_auto_revive = 0;
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