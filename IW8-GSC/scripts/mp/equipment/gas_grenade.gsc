/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\gas_grenade.gsc
************************************************/

function gas_used(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  scripts\mp\utility\print::printgameaction("gasGrenade spawn", var_0.owner);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);
  var_0 waittill("missile_stuck", var_1);
  thread gas_watchexplode(var_0);
  var_0 detonate();
}

function gas_watchexplode(var_0) {
  var_0 thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  var_0 endon("end_explode");
  var_1 = var_0.owner;
  var_0 waittill("explode", var_2);
  thread gas_createtrigger(var_2, var_1);
}

function gas_onplayerdamaged(var_0) {
  if(var_0.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  if(var_0.attacker == var_0.victim) {
    if(distancesquared(var_0.point, var_0.victim.origin) > 30625) {
      return false;
    }
  } else {
    var_0.attacker scripts\mp\damage::combatrecordtacticalstat("equip_gas_grenade");
    var_0.attacker scripts\mp\utility\stats::incpersstat("gasHits", 1);

    if(var_0.victim scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist")) {
      var_0.attacker scripts\mp\damagefeedback::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);
    }
  }

  thread gas_applycough(var_0.victim, var_0.attacker);
  return true;
}

function gas_clear(var_0) {
  gas_clearspeedredux(var_0);
  gas_clearblur(var_0);
  gas_clearcough(var_0);

  if(isDefined(self.gastriggerstouching)) {
    foreach(var_2 in self.gastriggerstouching) {
      if(!isDefined(var_2)) {
        continue;
      }

      var_2.playersintrigger[self getentitynumber()] = undefined;
    }
  }

  self.gastriggerstouching = undefined;
}

function gas_createtrigger(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 7;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = spawn("trigger_radius", var_0 + (0, 0, int(-57.75 * var_3)), 0, int(256 * var_3), int(175 * var_3));
  var_4 scripts\cp_mp\ent_manager::registerspawn(1, &sweepgas);
  var_5 = plunder_fiftypercent_music(var_0, var_3);

  if(isDefined(var_5)) {
    thread plunder_allowrepositoryuse(var_4, var_5);
  }

  var_4 endon("death");
  var_4.owner = var_1;

  if(isDefined(var_1)) {
    var_4.team = var_1.team;
  }

  var_4.playersintrigger = [];
  thread gas_watchtriggerenter();
  thread gas_watchtriggerexit();
  wait var_2;
  thread gas_destroytrigger();
}

function plunder_fiftypercent_music(var_0, var_1) {
  if(!scripts\mp\bots\bots_util::bot_bots_enabled_or_added() && !scripts\mp\utility\game::deposit_from_compromised_convoy_delayed_failsafe()) {
    return;
  }

  var_2 = createnavbadplacebybounds(var_0, (256 * var_1, 256 * var_1, 175 * var_1), (0, 0, 0));
  return var_2;
}

function plunder_allowrepositoryuse(var_0, var_1) {
  scripts\engine\utility::waittill_notify_or_timeout("entitydeleted", var_1);
  destroynavobstacle(var_0);
}

function sweepgas() {
  thread gas_destroytrigger();
}

function gas_destroytrigger() {
  foreach(var_1 in self.playersintrigger) {
    if(!isDefined(var_1)) {
      continue;
    }

    self.playersintrigger[var_1 getentitynumber()] = undefined;
    thread gas_onexittrigger(var_1);
  }

  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

function gas_onentertrigger(var_0) {
  if(!isDefined(self.gastriggerstouching)) {
    self.gastriggerstouching = [];
  }

  var_1 = var_0 getentitynumber();
  self.gastriggerstouching[var_1] = var_0;
  self.lastgastouchtime = gettime();

  if(istrue(self.start_death_from_above_sequence)) {
    return var_1;
  }

  if(self.gastriggerstouching.size >= 1) {
    thread gas_applyspeedredux();
    thread gas_applyblur();
  }

  if(self.gastriggerstouching.size == 1) {
    thread gas_applycough(var_0.owner, 0);
    scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio();
  }

  return var_1;
}

function gas_onexittrigger(var_0) {
  if(!isDefined(self.gastriggerstouching)) {
    return;
  }

  self.gastriggerstouching[var_0] = undefined;
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
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }

    if(istrue(var_0.plunderlimit)) {
      continue;
    }

    if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
      continue;
    }

    if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isDefined(self.playersintrigger[var_0 getentitynumber()])) {
      continue;
    }

    if(level.teambased) {
      if(isDefined(self.owner) && isDefined(self.owner.team) && isDefined(var_0.team)) {
        if(var_0 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(var_0, self.owner)) {
          continue;
        }
      } else if(isDefined(self.team) && scripts\mp\utility\player::isfriendly(self.team, var_0)) {
        continue;
      }
    }

    self.playersintrigger[var_0 getentitynumber()] = var_0;
    thread gas_onentertrigger(var_0);
  }
}

function gas_watchtriggerexit() {
  self endon("death");

  for(;;) {
    foreach(var_1 in self.playersintrigger) {
      if(!isDefined(var_1)) {
        self.playersintrigger[var_2] = undefined;
        continue;
      }

      if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(var_1 istouching(self)) {
        continue;
      }

      self.playersintrigger[var_1 getentitynumber()] = undefined;
      thread gas_onexittrigger(var_1);
    }

    waitframe();
  }
}

function gas_applycough(var_0, var_1) {
  var_2 = scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist");
  var_3 = isDefined(var_0) && self == var_0;

  if(!var_3 && var_2) {
    return;
  }

  if(istrue(self.plunderlimit)) {
    return;
  }

  var_4 = 0;

  if(istrue(var_1)) {
    var_4 = 1;

    if(var_3) {
      var_4 = 0;
    }
  }

  if(!istrue(self.gascoughinprogress) || istrue(var_1)) {
    thread gas_queuecough(var_4);
    return;
  }
}

function gas_queuecough(var_0) {
  self endon("death_or_disconnect");
  self endon("gas_clear_cough");
  self endon("gas_exited");
  self notify("gas_queue_cough");
  self endon("gas_queue_cough");
  var_1 = gettime() + 1000;

  while(gas_coughisblocked()) {
    waitframe();
  }

  if(var_0 && gettime() > var_1) {
    var_0 = 0;
  }

  var_2 = getdvarint("scr_equipCoughInterruptsADS", 1) == 1;

  if(var_2) {
    thread gas_begincoughing(var_0);
    return;
  }

  self endon("gas_begin_coughing");
  self.gascoughinprogress = 1;

  if(var_0) {
    self playgestureviewmodel("iw8_ges_teargas_cough");
    wait 3.33;
  } else {
    self playgestureviewmodel("iw8_ges_teargas_cough_long");
    wait 1.833;
  }

  self.gascoughinprogress = undefined;
}

function gas_begincoughing(var_0) {
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

  var_1 = scripts\engine\utility::ter_op(istrue(var_0), getcompleteweaponname("gas_cough_heavy_mp"), getcompleteweaponname("gas_cough_light_mp"));
  var_2 = scripts\engine\utility::ter_op(istrue(var_0), 3.33, 1.833);
  self giveandfireoffhand(var_1);
  GscBinSkip4(0x35, var_1);
}

function gas_removecough(var_0) {
  self notify("gas_queue_cough");
  self notify("gas_begin_coughing");
  self.gascoughinprogress = undefined;

  if(!istrue(var_0)) {
    if(isDefined(self.gastakenweaponobj)) {
      gas_restoreheldoffhand();
      return;
    }

    return;
  }
}

function gas_clearcough(var_0) {
  self notify("gas_queue_cough");
  self notify("gas_begin_coughing");
  self.gascoughinprogress = undefined;

  if(!istrue(var_0)) {
    var_1 = getdvarint("scr_equipCoughInterruptsADS", 1) == 1;

    if(var_1) {
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

function gas_monitorcoughweaponfired(var_0) {
  self endon("gas_coughWeaponTaken");
  self endon("gas_coughDuration");

  for(;;) {
    self waittill("offhand_fired", var_1);

    if(isnullweapon(var_1, var_0)) {
      break;
    }
  }

  self notify("gas_coughWeaponFired");
}

function gas_monitorcoughweapontaken(var_0) {
  self endon("gas_coughWeaponFired");
  self endon("gas_coughDuration");

  while(self hasweapon(var_0)) {
    waitframe();
  }

  self notify("gas_coughWeaponTaken");
}

function gas_monitorcoughduration(var_0) {
  self endon("gas_coughWeaponTaken");
  self endon("gas_coughWeaponFired");
  wait var_0;
  self notify("gas_coughDuration");
}

function gas_takeheldoffhand() {
  if(isDefined(self.gastakenweaponobj)) {
    gas_restoreheldoffhand();
  }

  self endon("gas_restoreHeldOffhand");
  self.gastakenweaponobj = self getheldoffhand();
  var_0 = scripts\mp\equipment::getequipmentreffromweapon(self.gastakenweaponobj);

  if(isDefined(var_0) && scripts\mp\equipment::hasequipment(var_0)) {
    self.gastakenweaponammo = scripts\mp\equipment::getequipmentammo(var_0);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
    waitframe();
    thread gas_restoreheldoffhand();
  }

  var_1 = scripts\mp\supers::getsuperrefforsuperoffhand(self.gastakenweaponobj);

  if(isDefined(var_1)) {
    var_2 = scripts\mp\supers::getcurrentsuperref();

    if(isDefined(var_2) && var_2 == var_1) {
      self.gastakenweaponammo = self getammocount(self.gastakenweaponobj);
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
      waitframe();
      thread gas_restoreheldoffhand();
    }
  }

  var_3 = scripts\mp\utility\weapon::isgesture(self.gastakenweaponobj);

  if(var_3) {
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
  var_0 = scripts\mp\equipment::getequipmentreffromweapon(self.gastakenweaponobj);

  if(isDefined(var_0) && scripts\mp\equipment::hasequipment(var_0)) {
    if(scripts\mp\equipment::hasequipment(var_0)) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
      var_1 = scripts\mp\equipment::findequipmentslot(var_0);

      if(var_1 == "primary") {
        self assignweaponoffhandprimary(self.gastakenweaponobj);
      } else if(var_1 == "secondary") {
        self assignweaponoffhandsecondary(self.gastakenweaponobj);
      }

      scripts\mp\equipment::setequipmentammo(var_0, self.gastakenweaponammo);
      self.gastakenweaponobj = undefined;
      self.gastakenweaponammo = undefined;
    }

    return;
  }

  var_2 = scripts\mp\supers::getsuperrefforsuperoffhand(self.gastakenweaponobj);

  if(isDefined(var_2)) {
    var_3 = scripts\mp\supers::getcurrentsuperref();

    if(isDefined(var_3) && var_3 == var_2) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
      self assignweaponoffhandspecial(self.gastakenweaponobj);
      self setweaponammoclip(self.gastakenweaponobj, self.gastakenweaponammo);
      self.gastakenweaponobj = undefined;
      self.gastakenweaponammo = undefined;
    }

    return;
  }

  var_4 = scripts\mp\utility\weapon::isgesture(self.gastakenweaponobj);

  if(var_4) {
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
        foreach(var_1 in self.gastriggerstouching) {
          if(isDefined(var_1) && isDefined(var_1.owner) && var_1.owner == self) {
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

  var_3 = -0.35;

  if(scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist")) {
    var_3 = -0.15;
  } else if(isDefined(self.gastriggerstouching)) {
    foreach(var_1 in self.gastriggerstouching) {
      if(isDefined(var_1) && isDefined(var_1.owner) && var_1.owner == self) {
        var_3 = -0.15;
      }
    }
  }

  gas_modifyspeed(var_3);
  self.gasspeedmod = var_3;
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

function gas_modifyspeed(var_0) {
  var_1 = 0;

  while(var_1 <= 0.65) {
    var_1 += 0.05;
    self.gasspeedmod = scripts\engine\math::lerp(self.gasspeedmod, var_0, min(1, var_1 / 0.65));
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.05;
  }
}

function gas_clearspeedredux(var_0) {
  self notify("gas_modify_speed");
  self.gasspeedmod = undefined;

  if(!istrue(var_0)) {
    scripts\mp\weapons::updatemovespeedscale();
    return;
  }
}

function gas_applyblur() {
  self endon("death_or_disconnect");
  self notify("gas_modify_blur");
  self endon("gas_modify_blur");
  var_0 = "gas_grenade_heavy_mp";

  if(scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist")) {
    var_0 = "gas_grenade_light_mp";
  } else if(isDefined(self.gastriggerstouching)) {
    foreach(var_2 in self.gastriggerstouching) {
      if(isDefined(var_2) && isDefined(var_2.owner) && var_2.owner == self) {
        var_0 = "gas_grenade_light_mp";
      }
    }
  }

  for(;;) {
    scripts\cp_mp\utility\shellshock_utility::_shellshock(var_0, "gas", 0.5, 0);
    wait 0.2;
  }
}

function gas_removeblur() {
  self notify("gas_modify_blur");
}

function gas_clearblur(var_0) {
  self notify("gas_modify_blur");

  if(!istrue(var_0)) {
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

function gas_getblurinterruptdelayms(var_0) {
  return 200;
}

function plunder_playerspawnedcallback(var_0, var_1) {
  if(isDefined(var_1.gastriggerstouching) && var_1.gastriggerstouching.size > 0) {
    foreach(var_3 in var_1.gastriggerstouching) {
      if(isDefined(var_3.owner) && var_3.owner == var_0) {
        return true;
      }
    }
  }

  return false;
}