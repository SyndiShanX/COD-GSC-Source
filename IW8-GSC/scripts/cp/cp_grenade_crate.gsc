/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_grenade_crate.gsc
***********************************************/

function grenade_crate_init() {
  var0 = spawnStruct();
  var0.id = "grenade_crate";
  var0.weaponinfo = "iw8_health_marker_cp";
  var0.modelbase = "offhand_wm_supportbox_explosives";
  var0.hintstring = &"COOP_CRAFTING/GRENADE_TAKE";
  var0.streakname = "grenade_crate";
  var0.splashname = "used_support_box";
  var0.shadername = "compass_objpoint_deploy_friendly";
  var0.headicon = "cp_crate_icon_lethalrefill";
  var0.headiconoffset = 20;
  var0.lifespan = 90;
  var0.usexp = 50;
  var0.onusesfx = "ammo_crate_use";
  var0.deployedsfx = "ammo_crate_use";
  var0.deathvfx = loadfx("vfx/iw8/prop/scriptables/vfx_offhand_wm_supportbox_explosives_timeout.vfx");
  var0.onusecallback = &healthbox_onusedeployable;
  var0.canusecallback = &healthbox_canusedeployable;
  var0.deployfunc = &healthbox_onusedeployable;
  var0.ref_120aa = "ping_response_thanks";
  var0.usetime = 1000;
  var0.maxhealth = 100;
  var0.maxuses = 4;
  var0.canreusebox = 0;
  var0.allowmeleedamage = 1;
  var0.damagefeedback = "";
  var0.grenadeusefunc = &healthbox_grenadelaunchfunc;
  var0.ondeploycallback = &scripts\cp\cp_deployablebox::supportbox_ondeploy;
  var0.deployanimduration = scripts\cp\cp_deployablebox::supportbox_getdeployanimduration();
  level.boxsettings["grenade_crate"] = var0;
  level.deployable_box["grenade_crate"] = [];
}

function weaponswitchendedsupportbox(var0, var1) {
  if(istrue(var1)) {
    thread supportbox_watchplayerweapon(var0);
    return;
  }
}

function tryusesupportbox(var0, var1) {
  return true;
}

function healthbox_canusedeployable(var0) {
  return true;
}

function healthbox_grenadelaunchfunc(var0) {
  var1 = self gettagorigin("tag_accessory_left");
  var2 = 400;
  var3 = anglesToForward(self.angles);
  var4 = anglestoup(self.angles);
  var4 *= 0.6;
  var5 = vectorNormalize(var3 + var4);
  var6 = var5 * var2;
  var7 = magicbullet("iw8_ammocrate_marker_zm", var1, var1 + var6, self);
  self notify("grenade_fire", var7);
}

function healthbox_onusedeployable(var0) {
  self endon("disconnect");
  var1 = 1;
  var2 = 1;
  var3 = self getweaponslistprimaries();

  foreach(var5 in var3) {
    if(weapontype(var5) == "projectile") {
      if(var5.basename == "iw8_la_mike32_mp") {
        if(self.gl_proj_override == "thermite") {
          continue;
        }
      }

      if(!ref_11b4a(var5)) {
        var2 = 0;
        self setweaponammoclip(var5, weaponclipsize(var5));
        self givemaxammo(var5);
      }
    }

    if(var5.inventorytype == "altmode" && isDefined(var5.underbarrel) && var5.underbarrel == "ubshtgn") {
      if(!ref_11b4a(var5)) {
        var2 = 0;
        self setweaponammoclip(var5, weaponclipsize(var5));
        self setweaponammostock(var5, 0);
      }
    }
  }

  foreach(var8 in self.powers) {
    if(var8.charges < var8.maxcharges) {
      var1 = 0;
    }
  }

  if(var1 && var2) {
    scripts\cp\utility::hint_prompt("max_grenades", 1, 3);
    return false;
  }

  thread refill_grenades(self);
  return true;
}

function ref_11b4a(var0) {
  var1 = self getweaponammoclip(var0);
  var2 = self getweaponammostock(var0);
  var3 = weaponclipsize(var0);
  var4 = weaponmaxammo(var0);

  if(var2 < var4 || var1 < var3) {
    return false;
  }

  return true;
}

function refill_grenades(var0) {
  var0 notify("stop_restock_recharge");

  foreach(var2 in var0.powers) {
    var0 notify("scavenged_ammo", var2.weaponuse);
    var0 playlocalsound("weap_ammo_pickup");
    waitframe();
  }
}

function supportbox_watchplayerweapon(var0) {
  self endon("disconnect");
  self endon("deployable_deployed");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  var1 = scripts\engine\utility::ref_143ae("grenade_fire", "cancel_deploy", "weapon_switch_started");

  if(!isDefined(var1)) {
    return;
  }

  jumpiffalse(var1 == "cancel_deploy") LOC_0000007d;
  self switchtoweapon(self.lastdroppableweaponobj);

  for(;;) {
    var2 = self getcurrentweapon();

    if(var2 != var0.objweapon) {
      self notify("killstreak_finished_with_weapon_" + var0.weaponname);
      break;
    }

    waitframe();
  }
}

function supportbox_handledamage() {
  var0 = level.boxsettings[self.boxtype];
}

function supportbox_handledeathdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = level.boxsettings[self.boxtype];
  var1 notify("destroyed_equipment");
}

function supportbox_modifydamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = var4;
  var7 = level.boxsettings[self.boxtype];
  return var6;
}

function supportbox_waittill_removeorweaponchange(var0, var1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var2 = spawnStruct();
  thread supportbox_waittill_notify(var0, var2);
  thread supportbox_waittill_notify(var1, var2);
  var2 waittill("returned", var3, var4);
  var2 notify("die");
  var5 = spawnStruct();
  var5.msg = var3;
  var5.param = var4;
  return var5;
}

function supportbox_waittill_notify(var0, var1) {
  self endon("death");
  self endon("disconnect");
  var1 endon("die");
  self waittill(var0, var2);
  var1 notify("returned", var0, var2);
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