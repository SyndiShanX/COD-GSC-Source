/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\gas_grenade.gsc
************************************************/

function gas_used(var0) {
  self endon("disconnect");
  var0 endon("death");
  scripts\mp\utility\print::printgameaction("gasGrenade spawn", var0.owner);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var0);
  var0 waittill("missile_stuck", var1);
  thread gas_watchexplode(var0);
  var0 detonate();
}

function gas_watchexplode(var0) {
  var0 thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  var0 endon("end_explode");
  var1 = var0.owner;
  var0 waittill("explode", var2);
  thread gas_createtrigger(var2, var1);
}

function gas_onplayerdamaged(var0) {
  if(var0.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  if(var0.attacker == var0.victim) {
    if(distancesquared(var0.point, var0.victim.origin) > 30625) {
      return false;
    }
  } else {
    var0.attacker scripts\mp\damage::combatrecordtacticalstat("equip_gas_grenade");
    var0.attacker scripts\mp\utility\stats::incpersstat("gasHits", 1);

    if(var0.victim scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist")) {
      var0.attacker scripts\mp\damagefeedback::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);
    }
  }

  thread gas_applycough(var0.victim, var0.attacker);
  return true;
}

function gas_clear(var0) {
  gas_clearspeedredux(var0);
  gas_clearblur(var0);
  gas_clearcough(var0);

  if(isDefined(self.gastriggerstouching)) {
    foreach(var2 in self.gastriggerstouching) {
      if(!isDefined(var2)) {
        continue;
      }

      var2.playersintrigger[self getentitynumber()] = undefined;
    }
  }

  self.gastriggerstouching = undefined;
}

function gas_createtrigger(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = 7;
  }

  if(!isDefined(var3)) {
    var3 = 1;
  }

  var4 = spawn("trigger_radius", var0 + (0, 0, int(-57.75 * var3)), 0, int(256 * var3), int(175 * var3));
  var4 scripts\cp_mp\ent_manager::registerspawn(1, &sweepgas);
  var5 = plunder_fiftypercent_music(var0, var3);

  if(isDefined(var5)) {
    thread plunder_allowrepositoryuse(var4, var5);
  }

  var4 endon("death");
  var4.owner = var1;

  if(isDefined(var1)) {
    var4.team = var1.team;
  }

  var4.playersintrigger = [];
  thread gas_watchtriggerenter();
  thread gas_watchtriggerexit();
  wait var2;
  thread gas_destroytrigger();
}

function plunder_fiftypercent_music(var0, var1) {
  if(!scripts\mp\bots\bots_util::bot_bots_enabled_or_added() && !scripts\mp\utility\game::deposit_from_compromised_convoy_delayed_failsafe()) {
    return;
  }

  var2 = createnavbadplacebybounds(var0, (256 * var1, 256 * var1, 175 * var1), (0, 0, 0));
  return var2;
}

function plunder_allowrepositoryuse(var0, var1) {
  scripts\engine\utility::waittill_notify_or_timeout("entitydeleted", var1);
  destroynavobstacle(var0);
}

function sweepgas() {
  thread gas_destroytrigger();
}

function gas_destroytrigger() {
  foreach(var1 in self.playersintrigger) {
    if(!isDefined(var1)) {
      continue;
    }

    self.playersintrigger[var1 getentitynumber()] = undefined;
    thread gas_onexittrigger(var1);
  }

  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

function gas_onentertrigger(var0) {
  if(!isDefined(self.gastriggerstouching)) {
    self.gastriggerstouching = [];
  }

  var1 = var0 getentitynumber();
  self.gastriggerstouching[var1] = var0;
  self.lastgastouchtime = gettime();

  if(istrue(self.start_death_from_above_sequence)) {
    return var1;
  }

  if(self.gastriggerstouching.size >= 1) {
    thread gas_applyspeedredux();
    thread gas_applyblur();
  }

  if(self.gastriggerstouching.size == 1) {
    thread gas_applycough(var0.owner, 0);
    scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio();
  }

  return var1;
}

function gas_onexittrigger(var0) {
  if(!isDefined(self.gastriggerstouching)) {
    return;
  }

  self.gastriggerstouching[var0] = undefined;
  self.lastgastouchtime = gettime();

  if(self.gastriggerstouching.size == 0) {
    thread gas_removespeedredux();
    thread gas_removeblur();
    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();
    self notify("gas_exited");
    return;
  }
}

function gas_watchtriggerenter() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);

    if(!isPlayer(var0)) {
      continue;
    }

    if(istrue(var0.plunderlimit)) {
      continue;
    }

    if(var0 scripts\mp\utility\killstreak::isjuggernaut()) {
      continue;
    }

    if(!var0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isDefined(self.playersintrigger[var0 getentitynumber()])) {
      continue;
    }

    if(level.teambased) {
      if(isDefined(self.owner) && isDefined(self.owner.team) && isDefined(var0.team)) {
        if(var0 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(var0, self.owner)) {
          continue;
        }
      } else if(isDefined(self.team) && scripts\mp\utility\player::isfriendly(self.team, var0)) {
        continue;
      }
    }

    self.playersintrigger[var0 getentitynumber()] = var0;
    thread gas_onentertrigger(var0);
  }
}

function gas_watchtriggerexit() {
  self endon("death");

  for(;;) {
    foreach(var1 in self.playersintrigger) {
      if(!isDefined(var1)) {
        self.playersintrigger[var2] = undefined;
        continue;
      }

      if(!var1 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(var1 istouching(self)) {
        continue;
      }

      self.playersintrigger[var1 getentitynumber()] = undefined;
      thread gas_onexittrigger(var1);
    }

    waitframe();
  }
}

function gas_applycough(var0, var1) {
  var2 = scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist");
  var3 = isDefined(var0) && self == var0;

  if(!var3 && var2) {
    return;
  }

  if(istrue(self.plunderlimit)) {
    return;
  }

  var4 = 0;

  if(istrue(var1)) {
    var4 = 1;

    if(var3) {
      var4 = 0;
    }
  }

  if(!istrue(self.gascoughinprogress) || istrue(var1)) {
    thread gas_queuecough(var4);
    return;
  }
}

function gas_queuecough(var0) {
  self endon("death_or_disconnect");
  self endon("gas_clear_cough");
  self endon("gas_exited");
  self notify("gas_queue_cough");
  self endon("gas_queue_cough");
  var1 = gettime() + 1000;

  while(gas_coughisblocked()) {
    waitframe();
  }

  if(var0 && gettime() > var1) {
    var0 = 0;
  }

  var2 = getdvarint("scr_equipCoughInterruptsADS", 1) == 1;

  if(var2) {
    thread gas_begincoughing(var0);
    return;
  }

  self endon("gas_begin_coughing");
  self.gascoughinprogress = 1;

  if(var0) {
    self playgestureviewmodel("iw8_ges_teargas_cough");
    wait 3.33;
  } else {
    self playgestureviewmodel("iw8_ges_teargas_cough_long");
    wait 1.833;
  }

  self.gascoughinprogress = undefined;
}

function gas_begincoughing(var0) {
  self endon("death_or_disconnect");
  self endon("gas_clear_cough");
  self notify("gas_begin_coughing");
  self endon("gas_begin_coughing");

  if(!nullweapon(self getheldoffhand())) {
    GscBinSkip4(0x35);
  }

  self.gascoughinprogress = 1;

  if(self hasweapon(getcompleteweaponname("gas_cough_light_mp"))) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon("gas_cough_light_mp");
  }

  if(self hasweapon(getcompleteweaponname("gas_cough_heavy_mp"))) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon("gas_cough_heavy_mp");
  }

  var1 = scripts\engine\utility::ter_op(istrue(var0), getcompleteweaponname("gas_cough_heavy_mp"), getcompleteweaponname("gas_cough_light_mp"));
  var2 = scripts\engine\utility::ter_op(istrue(var0), 3.33, 1.833);
  self giveandfireoffhand(var1);
  GscBinSkip4(0x35, var1);
}

function gas_removecough(var0) {
  self notify("gas_queue_cough");
  self notify("gas_begin_coughing");
  self.gascoughinprogress = undefined;

  if(!istrue(var0)) {
    if(isDefined(self.gastakenweaponobj)) {
      gas_restoreheldoffhand();
      return;
    }

    return;
  }
}

function gas_clearcough(var0) {
  self notify("gas_queue_cough");
  self notify("gas_begin_coughing");
  self.gascoughinprogress = undefined;

  if(!istrue(var0)) {
    var1 = getdvarint("scr_equipCoughInterruptsADS", 1) == 1;

    if(var1) {
      if(self hasweapon(getcompleteweaponname("gas_cough_light_mp"))) {
        scripts\cp_mp\utility\inventory_utility::_takeweapon("gas_cough_light_mp");
      }

      if(self hasweapon(getcompleteweaponname("gas_cough_heavy_mp"))) {
        scripts\cp_mp\utility\inventory_utility::_takeweapon("gas_cough_heavy_mp");
      }

      if(isDefined(self.gastakenweaponobj)) {
        gas_restoreheldoffhand();
        return;
      }

      return;
    }

    self stopgestureviewmodel("iw8_ges_teargas_cough");
    self stopgestureviewmodel("iw8_ges_teargas_cough_long");
    return;
  }
}

function gas_monitorcoughweaponfired(var0) {
  self endon("gas_coughWeaponTaken");
  self endon("gas_coughDuration");

  for(;;) {
    self waittill("offhand_fired", var1);

    if(isnullweapon(var1, var0)) {
      break;
    }
  }

  self notify("gas_coughWeaponFired");
}

function gas_monitorcoughweapontaken(var0) {
  self endon("gas_coughWeaponFired");
  self endon("gas_coughDuration");

  while(self hasweapon(var0)) {
    waitframe();
  }

  self notify("gas_coughWeaponTaken");
}

function gas_monitorcoughduration(var0) {
  self endon("gas_coughWeaponTaken");
  self endon("gas_coughWeaponFired");
  wait var0;
  self notify("gas_coughDuration");
}

function gas_takeheldoffhand() {
  if(isDefined(self.gastakenweaponobj)) {
    gas_restoreheldoffhand();
  }

  self endon("gas_restoreHeldOffhand");
  self.gastakenweaponobj = self getheldoffhand();
  var0 = scripts\mp\equipment::getequipmentreffromweapon(self.gastakenweaponobj);

  if(isDefined(var0) && scripts\mp\equipment::hasequipment(var0)) {
    self.gastakenweaponammo = scripts\mp\equipment::getequipmentammo(var0);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
    waitframe();
    thread gas_restoreheldoffhand();
  }

  var1 = scripts\mp\supers::getsuperrefforsuperoffhand(self.gastakenweaponobj);

  if(isDefined(var1)) {
    var2 = scripts\mp\supers::getcurrentsuperref();

    if(isDefined(var2) && var2 == var1) {
      self.gastakenweaponammo = self getammocount(self.gastakenweaponobj);
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
      waitframe();
      thread gas_restoreheldoffhand();
    }
  }

  var3 = scripts\mp\utility\weapon::isgesture(self.gastakenweaponobj);

  if(var3) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
    waitframe();
    thread gas_restoreheldoffhand();
  }

  self.gastakenweaponammo = self getammocount(self.gastakenweaponobj);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
  waitframe();
  thread gas_restoreheldoffhand();
}

function gas_restoreheldoffhand() {
  self notify("gas_restoreHeldOffhand");
  var0 = scripts\mp\equipment::getequipmentreffromweapon(self.gastakenweaponobj);

  if(isDefined(var0) && scripts\mp\equipment::hasequipment(var0)) {
    if(scripts\mp\equipment::hasequipment(var0)) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
      var1 = scripts\mp\equipment::findequipmentslot(var0);

      if(var1 == "primary") {
        self assignweaponoffhandprimary(self.gastakenweaponobj);
      } else if(var1 == "secondary") {
        self assignweaponoffhandsecondary(self.gastakenweaponobj);
      }

      scripts\mp\equipment::setequipmentammo(var0, self.gastakenweaponammo);
      self.gastakenweaponobj = undefined;
      self.gastakenweaponammo = undefined;
    }

    return;
  }

  var2 = scripts\mp\supers::getsuperrefforsuperoffhand(self.gastakenweaponobj);

  if(isDefined(var2)) {
    var3 = scripts\mp\supers::getcurrentsuperref();

    if(isDefined(var3) && var3 == var2) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
      self assignweaponoffhandspecial(self.gastakenweaponobj);
      self setweaponammoclip(self.gastakenweaponobj, self.gastakenweaponammo);
      self.gastakenweaponobj = undefined;
      self.gastakenweaponammo = undefined;
    }

    return;
  }

  var4 = scripts\mp\utility\weapon::isgesture(self.gastakenweaponobj);

  if(var4) {
    if(isDefined(self.gestureweapon) && self.gestureweapon == self.gastakenweaponobj.basename) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
      self.gastakenweaponobj = undefined;
    }

    return;
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
  self setweaponammoclip(self.gastakenweaponobj, self.gastakenweaponammo);
  self.gastakenweaponobj = undefined;
  self.gastakenweaponammo = undefined;
}

function gas_applyspeedredux() {
  self endon("death_or_disconnect");
  self notify("gas_modify_speed");
  self endon("gas_modify_speed");

  if(isDefined(self.gasspeedmod)) {
    if(self.gasspeedmod < -0.15) {
      if(scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist")) {
        self.gasspeedmod = -0.15;
        scripts\mp\weapons::updatemovespeedscale();
        return;
      }

      if(isDefined(self.gastriggerstouching)) {
        foreach(var1 in self.gastriggerstouching) {
          if(isDefined(var1) && isDefined(var1.owner) && var1.owner == self) {
            self.gasspeedmod = -0.15;
            scripts\mp\weapons::updatemovespeedscale();
            return;
          }
        }
      }
    }
  } else {
    self.gasspeedmod = 0;
  }

  var3 = -0.35;

  if(scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist")) {
    var3 = -0.15;
  } else if(isDefined(self.gastriggerstouching)) {
    foreach(var1 in self.gastriggerstouching) {
      if(isDefined(var1) && isDefined(var1.owner) && var1.owner == self) {
        var3 = -0.15;
      }
    }
  }

  gas_modifyspeed(var3);
  self.gasspeedmod = var3;
  scripts\mp\weapons::updatemovespeedscale();
}

function gas_removespeedredux() {
  self endon("death_or_disconnect");
  self notify("gas_modify_speed");
  self endon("gas_modify_speed");

  if(!isDefined(self.gasspeedmod)) {
    return;
  }

  gas_modifyspeed(0);
  self.gasspeedmod = undefined;
  scripts\mp\weapons::updatemovespeedscale();
}

function gas_modifyspeed(var0) {
  var1 = 0;

  while(var1 <= 0.65) {
    var1 += 0.05;
    self.gasspeedmod = scripts\engine\math::lerp(self.gasspeedmod, var0, min(1, var1 / 0.65));
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.05;
  }
}

function gas_clearspeedredux(var0) {
  self notify("gas_modify_speed");
  self.gasspeedmod = undefined;

  if(!istrue(var0)) {
    scripts\mp\weapons::updatemovespeedscale();
    return;
  }
}

function gas_applyblur() {
  self endon("death_or_disconnect");
  self notify("gas_modify_blur");
  self endon("gas_modify_blur");
  var0 = "gas_grenade_heavy_mp";

  if(scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist")) {
    var0 = "gas_grenade_light_mp";
  } else if(isDefined(self.gastriggerstouching)) {
    foreach(var2 in self.gastriggerstouching) {
      if(isDefined(var2) && isDefined(var2.owner) && var2.owner == self) {
        var0 = "gas_grenade_light_mp";
      }
    }
  }

  for(;;) {
    scripts\cp_mp\utility\shellshock_utility::_shellshock(var0, "gas", 0.5, 0);
    wait 0.2;
  }
}

function gas_removeblur() {
  self notify("gas_modify_blur");
}

function gas_clearblur(var0) {
  self notify("gas_modify_blur");

  if(!istrue(var0)) {
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    return;
  }
}

function gas_shouldtakeheldoffhand() {
  switch (self getheldoffhand().basename) {
    case "super_delay_mp":
      return false;
    default:
      return true;
  }

  return false;
}

function gas_coughisblocked() {
  if(!scripts\common\utility::is_cough_gesture_allowed()) {
    return true;
  }

  if(!scripts\common\utility::is_offhand_weapons_allowed()) {
    return true;
  }

  if(!nullweapon(self getheldoffhand()) && !gas_shouldtakeheldoffhand()) {
    return true;
  }

  return false;
}

function gas_isintrigger() {
  if(!isDefined(self.gastriggerstouching)) {
    return false;
  }

  if(self.gastriggerstouching.size == 0) {
    return false;
  }

  return true;
}

function gas_updateplayereffects() {
  if(scripts\mp\utility\killstreak::isjuggernaut()) {
    gas_clear();
    return;
  }

  if(gas_isintrigger()) {
    thread gas_applyspeedredux();
    thread gas_applyblur();
    return;
  }
}

function gas_getblurinterruptdelayms(var0) {
  return 200;
}

function plunder_playerspawnedcallback(var0, var1) {
  if(isDefined(var1.gastriggerstouching) && var1.gastriggerstouching.size > 0) {
    foreach(var3 in var1.gastriggerstouching) {
      if(isDefined(var3.owner) && var3.owner == var0) {
        return true;
      }
    }
  }

  return false;
}