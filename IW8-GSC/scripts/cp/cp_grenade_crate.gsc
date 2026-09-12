/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_grenade_crate.gsc
***********************************************/

function grenade_crate_init() {
  var_0 = spawnStruct();
  var_0.id = "grenade_crate";
  var_0.weaponinfo = "iw8_health_marker_cp";
  var_0.modelbase = "offhand_wm_supportbox_explosives";
  var_0.hintstring = &"COOP_CRAFTING/GRENADE_TAKE";
  var_0.streakname = "grenade_crate";
  var_0.splashname = "used_support_box";
  var_0.shadername = "compass_objpoint_deploy_friendly";
  var_0.headicon = "cp_crate_icon_lethalrefill";
  var_0.headiconoffset = 20;
  var_0.lifespan = 90;
  var_0.usexp = 50;
  var_0.onusesfx = "ammo_crate_use";
  var_0.deployedsfx = "ammo_crate_use";
  var_0.deathvfx = loadfx("vfx/iw8/prop/scriptables/vfx_offhand_wm_supportbox_explosives_timeout.vfx");
  var_0.onusecallback = &healthbox_onusedeployable;
  var_0.canusecallback = &healthbox_canusedeployable;
  var_0.deployfunc = &healthbox_onusedeployable;
  var_0.ref_120AA = "ping_response_thanks";
  var_0.usetime = 1000;
  var_0.maxhealth = 100;
  var_0.maxuses = 4;
  var_0.canreusebox = 0;
  var_0.allowmeleedamage = 1;
  var_0.damagefeedback = "";
  var_0.grenadeusefunc = &healthbox_grenadelaunchfunc;
  var_0.ondeploycallback = &scripts\cp\cp_deployablebox::supportbox_ondeploy;
  var_0.deployanimduration = scripts\cp\cp_deployablebox::supportbox_getdeployanimduration();
  level.boxsettings["grenade_crate"] = var_0;
  level.deployable_box["grenade_crate"] = [];
}

function weaponswitchendedsupportbox(var_0, var_1) {
  if(istrue(var_1)) {
    thread supportbox_watchplayerweapon(var_0);
    return;
  }
}

function tryusesupportbox(var_0, var_1) {
  return true;
}

function healthbox_canusedeployable(var_0) {
  return true;
}

function healthbox_grenadelaunchfunc(var_0) {
  var_1 = self gettagorigin("tag_accessory_left");
  var_2 = 400;
  var_3 = anglesToForward(self.angles);
  var_4 = anglestoup(self.angles);
  var_4 *= 0.6;
  var_5 = vectorNormalize(var_3 + var_4);
  var_6 = var_5 * var_2;
  var_7 = magicbullet("iw8_ammocrate_marker_zm", var_1, var_1 + var_6, self);
  self notify("grenade_fire", var_7);
}

function healthbox_onusedeployable(var_0) {
  self endon("disconnect");
  var_1 = 1;
  var_2 = 1;
  var_3 = self getweaponslistprimaries();

  foreach(var_5 in var_3) {
    if(weapontype(var_5) == "projectile") {
      if(var_5.basename == "iw8_la_mike32_mp") {
        if(self.gl_proj_override == "thermite") {
          continue;
        }
      }

      if(!ref_11B4A(var_5)) {
        var_2 = 0;
        self setweaponammoclip(var_5, weaponclipsize(var_5));
        self givemaxammo(var_5);
      }
    }

    if(var_5.inventorytype == "altmode" && isDefined(var_5.underbarrel) && var_5.underbarrel == "ubshtgn") {
      if(!ref_11B4A(var_5)) {
        var_2 = 0;
        self setweaponammoclip(var_5, weaponclipsize(var_5));
        self setweaponammostock(var_5, 0);
      }
    }
  }

  foreach(var_8 in self.powers) {
    if(var_8.charges < var_8.maxcharges) {
      var_1 = 0;
    }
  }

  if(var_1 && var_2) {
    scripts\cp\utility::hint_prompt("max_grenades", 1, 3);
    return false;
  }

  thread refill_grenades(self);
  return true;
}

function ref_11B4A(var_0) {
  var_1 = self getweaponammoclip(var_0);
  var_2 = self getweaponammostock(var_0);
  var_3 = weaponclipsize(var_0);
  var_4 = weaponmaxammo(var_0);

  if(var_2 < var_4 || var_1 < var_3) {
    return false;
  }

  return true;
}

function refill_grenades(var_0) {
  var_0 notify("stop_restock_recharge");

  foreach(var_2 in var_0.powers) {
    var_0 notify("scavenged_ammo", var_2.weaponuse);
    var_0 playlocalsound("weap_ammo_pickup");
    waitframe();
  }
}

function supportbox_watchplayerweapon(var_0) {
  self endon("disconnect");
  self endon("deployable_deployed");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  var_1 = scripts\engine\utility::ref_143AE("grenade_fire", "cancel_deploy", "weapon_switch_started");

  if(!isDefined(var_1)) {
    return;
  }

  jumpiffalse(var_1 == "cancel_deploy") LOC_0000007d;
  self switchtoweapon(self.lastdroppableweaponobj);

  for(;;) {
    var_2 = self getcurrentweapon();

    if(var_2 != var_0.objweapon) {
      self notify("killstreak_finished_with_weapon_" + var_0.weaponname);
      break;
    }

    waitframe();
  }
}

function supportbox_handledamage() {
  var_0 = level.boxsettings[self.boxtype];
}

function supportbox_handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = level.boxsettings[self.boxtype];
  var_1 notify("destroyed_equipment");
}

function supportbox_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_7 = level.boxsettings[self.boxtype];
  return var_6;
}

function supportbox_waittill_removeorweaponchange(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_2 = spawnStruct();
  thread supportbox_waittill_notify(var_0, var_2);
  thread supportbox_waittill_notify(var_1, var_2);
  var_2 waittill("returned", var_3, var_4);
  var_2 notify("die");
  var_5 = spawnStruct();
  var_5.msg = var_3;
  var_5.param = var_4;
  return var_5;
}

function supportbox_waittill_notify(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_1 endon("die");
  self waittill(var_0, var_2);
  var_1 notify("returned", var_0, var_2);
}

function watch_dpad() {
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