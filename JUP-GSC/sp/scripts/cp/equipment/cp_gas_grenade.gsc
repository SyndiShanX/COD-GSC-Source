/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\equipment\cp_gas_grenade.gsc
******************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace cp_gas_grenade;

function gas_used(grenade) {
  self endon("disconnect");
  grenade endon("death");
  team = grenade.owner.team;
  thread gas_watchexplode(grenade, team);
  thread function_60397906a6eb5a4f(grenade);
}

function gas_watchexplode(grenade, team) {
  grenade thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  grenade endon("end_explode");
  owner = undefined;

  if(isDefined(grenade.owner)) {
    owner = grenade.owner;
  }

  grenade waittill("explode", position);
  thread gas_createtrigger(position, owner, team);
}

function function_60397906a6eb5a4f(grenade) {
  grenade endon("explode");
  grenade waittill("missile_water_impact", impactdata);
  grenade notify("end_explode");
  thread function_da09131c75ad4b63(grenade);
}

function function_da09131c75ad4b63(grenade) {
  grenade waittill("missile_stuck", stuckdata);
  owner = grenade.owner;
  team = grenade.team;
  position = grenade.origin;
  grenade thread gas_createtrigger(position + (0, 0, 10), owner, team);
}

function gas_onplayerdamaged(data) {
  if(data.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  if(data.attacker == data.victim) {
    if(distancesquared(data.point, data.victim.origin) > 30625) {
      return false;
    }
  }

  if(data.attacker != data.victim) {}

  data.victim thread gas_applycough(data.attacker, 1);
  return true;
}

function gas_clear(fromdeath) {
  gas_clearspeedredux(fromdeath);
  gas_clearblur(fromdeath);
  gas_clearcough(fromdeath);

  if(isDefined(self.gastriggerstouching)) {
    foreach(trigger in self.gastriggerstouching) {
      if(!isDefined(trigger)) {
        continue;
      }

      trigger.playersintrigger[self getentitynumber()] = undefined;
    }
  }

  self.gastriggerstouching = undefined;
}

function gas_createtrigger(position, owner, team, duration, scale, iscrossbow, crossbowlevel) {
  if(scripts\engine\utility::issharedfuncdefined("pmc_missions", "onGasGrenadeExplode")) {
    [[scripts\engine\utility::getsharedfunc("pmc_missions", "onGasGrenadeExplode")]](position, owner, team);
  }

  if(!isDefined(duration)) {
    duration = 7;
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  trigger = spawn("trigger_radius", position + (0, 0, int(-57.75 * scale)), 0, int(256 * scale), int(175 * scale));
  trigger scripts\cp_mp\ent_manager::registerspawn(1, &sweepgas);
  trigger endon("death");
  trigger.owner = owner;
  trigger.team = team;
  trigger.playersintrigger = [];
  trigger thread gas_watchtriggerenter();
  trigger thread gas_watchtriggerexit();
  trigger thread gas_badplace(duration, scale);
  wait duration;
  trigger thread gas_destroytrigger();
}

function sweepgas() {
  thread gas_destroytrigger();
}

function gas_destroytrigger() {
  foreach(player in self.playersintrigger) {
    if(!isDefined(player)) {
      continue;
    }

    self.playersintrigger[player getentitynumber()] = undefined;
    player thread gas_onexittrigger(self getentitynumber());
  }

  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

function gas_onentertrigger(trigger) {
  if(!isDefined(self.gastriggerstouching)) {
    self.gastriggerstouching = [];
  }

  entnum = trigger getentitynumber();
  self.gastriggerstouching[entnum] = trigger;
  self.lastgastouchtime = gettime();

  if(isPlayer(self)) {
    if(self.gastriggerstouching.size >= 1) {
      thread gas_applyspeedredux();
      thread gas_applyblur();
    }

    if(self.gastriggerstouching.size == 1) {
      thread gas_applycough(trigger.owner, 0);
      scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio(trigger.owner);
    }
  } else {
    weap = makeweapon("gas_mp");
    self dodamage(1, self.origin, trigger.owner, trigger, "MOD_GRENADE_SPLASH", weap);
    self notify("flashbang", self.origin, 1, 1, trigger.owner, "axis", 9);
    scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio(trigger.owner);
  }

  return entnum;
}

function gas_onexittrigger(triggerid) {
  assertex(isDefined(triggerid), "gas_onExitTrigger called with an invalid trigger ID.");

  if(!isDefined(self.gastriggerstouching)) {
    return;
  }

  self.gastriggerstouching[triggerid] = undefined;
  self.lastgastouchtime = gettime();

  if(isPlayer(self)) {
    if(self.gastriggerstouching.size == 0) {
      thread gas_removespeedredux();
      thread gas_removeblur();
      scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();
    }
  } else {
    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();
  }

  self notify("gas_exited");
}

function gas_watchtriggerenter() {
  self endon("death");

  while(true) {
    self waittill("trigger", player);

    if(!isPlayer(player) && !isagent(player)) {
      continue;
    }

    if(istrue(player.isjuggernaut)) {
      continue;
    }

    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isDefined(self.playersintrigger[player getentitynumber()])) {
      continue;
    }

    if(isDefined(self.owner) && isalive(self.owner)) {
      if(player != self.owner && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(player, self.owner))) {
        continue;
      }
    } else {
      continue;
    }

    self.playersintrigger[player getentitynumber()] = player;
    player thread gas_onentertrigger(self);
  }
}

function gas_watchtriggerexit() {
  self endon("death");

  while(true) {
    foreach(player in self.playersintrigger) {
      if(!isDefined(player)) {
        self.playersintrigger[id] = undefined;
        continue;
      }

      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(player istouching(self) && !function_da8a31143b88e833(player)) {
        continue;
      }

      self.playersintrigger[player getentitynumber()] = undefined;
      player thread gas_onexittrigger(self getentitynumber());
    }

    waitframe();
  }
}

function function_da8a31143b88e833(player) {
  if(player function_7ee20cf3c0390e21()) {
    return true;
  }

  return false;
}

function gas_badplace(duration, scale) {
  if(!isDefined(self)) {
    return;
  }

  var_e786fa50656bc2ff = 0.66;
  pre_wait = duration * 0.15;
  post_wait = duration * 0.25;
  assertex(pre_wait + post_wait <= duration, "Incorrect pre/post wait values");
  wait pre_wait;
  var_f369d822d2af09e5 = 256 * scale * var_e786fa50656bc2ff;
  var_dbdbad4a509c08e8 = 175 * scale * var_e786fa50656bc2ff;
  zeroangles = (0, 0, 0);
  navobstacle = createnavbadplacebyshape(self.origin, zeroangles, 8, var_f369d822d2af09e5, var_dbdbad4a509c08e8);
  wait max(0.05, duration - pre_wait - post_wait);

  if(isDefined(navobstacle)) {
    destroynavobstacle(navobstacle);
  }
}

function gas_applycough(attacker, fromimpact) {
  var_a15ffac7e41222a2 = scripts\cp\utility::_hasperk("specialty_gas_grenade_resist");
  var_8907f741f3a7b3f7 = isDefined(attacker) && self == attacker;

  if(!var_8907f741f3a7b3f7 && var_a15ffac7e41222a2) {
    return;
  }

  isheavy = 0;

  if(istrue(fromimpact)) {
    isheavy = 1;

    if(var_8907f741f3a7b3f7) {
      isheavy = 0;

      if(getdvarint(@ "hash_6c7fd12a611ca1e8", 0) == 1) {
        isheavy = 1;
      }
    }
  }

  if(!istrue(self.gascoughinprogress) || istrue(fromimpact)) {
    thread gas_queuecough(isheavy);
  }
}

function gas_queuecough(isheavy) {
  self endon("death_or_disconnect");
  self endon("gas_clear_cough");
  self endon("gas_exited");
  self notify("gas_queue_cough");
  self endon("gas_queue_cough");
  var_fff525b27a42fc40 = gettime() + 1000;

  while(gas_coughisblocked()) {
    waitframe();
  }

  if(isheavy && gettime() > var_fff525b27a42fc40) {
    isheavy = 0;
  }

  var_81b4070b5858078d = getdvarint(@ "hash_827901421ad0679", 1) == 1;

  if(var_81b4070b5858078d) {
    thread gas_begincoughing(isheavy);
    return;
  }

  self endon("gas_begin_coughing");
  self.gascoughinprogress = 1;

  if(isheavy) {
    self playgestureviewmodel("iw9_ges_gas_cough_long");
    wait 3.33;
  } else {
    self playgestureviewmodel("iw9_ges_gas_cough");
    wait 1.833;
  }

  self.gascoughinprogress = undefined;
}

function gas_begincoughing(isheavy) {
  self endon("death_or_disconnect");
  self endon("gas_clear_cough");
  self notify("gas_begin_coughing");
  self endon("gas_begin_coughing");

  if(!isnullweapon(self getheldoffhand())) {
    childthread gas_takeheldoffhand();
  }

  self.gascoughinprogress = 1;

  if(self hasweapon(makeweapon("gas_cough_light_mp"))) {
    _takeweapon("gas_cough_light_mp");
  }

  if(self hasweapon(makeweapon("gas_cough_heavy_mp"))) {
    _takeweapon("gas_cough_heavy_mp");
  }

  weaponobj = ter_op(istrue(isheavy), makeweapon("gas_cough_heavy_mp"), makeweapon("gas_cough_light_mp"));
  duration = ter_op(istrue(isheavy), 3.33, 1.833);
  self giveandfireoffhand(weaponobj);
  childthread gas_monitorcoughweaponfired(weaponobj);
  childthread gas_monitorcoughweapontaken(weaponobj);
  childthread gas_monitorcoughduration(duration);
  waittill_any_3("gas_coughWeaponFired", "gas_coughWeaponTaken", "gas_coughDuration");

  if(self hasweapon(weaponobj)) {
    _takeweapon(weaponobj);
  }

  self.gascoughinprogress = undefined;
}

function gas_removecough(fromdeath) {
  self notify("gas_queue_cough");
  self notify("gas_begin_coughing");
  self.gascoughinprogress = undefined;

  if(!istrue(fromdeath)) {
    if(isDefined(self.gastakenweaponobj)) {
      gas_restoreheldoffhand();
    }
  }
}

function gas_clearcough(fromdeath) {
  self notify("gas_queue_cough");
  self notify("gas_begin_coughing");
  self.gascoughinprogress = undefined;

  if(!istrue(fromdeath)) {
    var_81b4070b5858078d = getdvarint(@ "hash_827901421ad0679", 1) == 1;

    if(var_81b4070b5858078d) {
      if(self hasweapon(makeweapon("gas_cough_light_mp"))) {
        _takeweapon("gas_cough_light_mp");
      }

      if(self hasweapon(makeweapon("gas_cough_heavy_mp"))) {
        _takeweapon("gas_cough_heavy_mp");
      }

      if(isDefined(self.gastakenweaponobj)) {
        gas_restoreheldoffhand();
      }

      return;
    }

    self stopgestureviewmodel("iw9_ges_gas_cough");
    self stopgestureviewmodel("iw9_ges_gas_cough_long");
  }
}

function gas_monitorcoughweaponfired(var_33f644489e4f15ae) {
  self endon("gas_coughWeaponTaken");
  self endon("gas_coughDuration");

  while(true) {
    self waittill("offhand_fired", weaponobj);

    if(issameweapon(weaponobj, var_33f644489e4f15ae)) {
      break;
    }
  }

  self notify("gas_coughWeaponFired");
}

function gas_monitorcoughweapontaken(var_33f644489e4f15ae) {
  self endon("gas_coughWeaponFired");
  self endon("gas_coughDuration");

  while(self hasweapon(var_33f644489e4f15ae)) {
    waitframe();
  }

  self notify("gas_coughWeaponTaken");
}

function gas_monitorcoughduration(coughduration) {
  self endon("gas_coughWeaponTaken");
  self endon("gas_coughWeaponFired");
  wait coughduration;
  self notify("gas_coughDuration");
}

function gas_takeheldoffhand() {
  if(isDefined(self.gastakenweaponobj)) {
    gas_restoreheldoffhand();
  }

  self endon("gas_restoreHeldOffhand");
  self.gastakenweaponobj = self getheldoffhand();
  equipmentref = scripts\cp_mp\equipment::getequipmentreffromweapon(self.gastakenweaponobj);

  if(isDefined(equipmentref) && scripts\cp_mp\equipment::hasequipment(equipmentref)) {
    self.gastakenweaponammo = scripts\cp_mp\equipment::getequipmentammo(equipmentref);
    _takeweapon(self.gastakenweaponobj);
    waitframe();
    thread gas_restoreheldoffhand();
  }

  isgesture = scripts\cp\utility::isgesture(self.gastakenweaponobj);

  if(isgesture) {
    _takeweapon(self.gastakenweaponobj);
    waitframe();
    thread gas_restoreheldoffhand();
  }

  self.gastakenweaponammo = self getammocount(self.gastakenweaponobj);
  _takeweapon(self.gastakenweaponobj);
  waitframe();
  thread gas_restoreheldoffhand();
}

function gas_restoreheldoffhand() {
  self notify("gas_restoreHeldOffhand");
  equipmentref = scripts\cp_mp\equipment::getequipmentreffromweapon(self.gastakenweaponobj);

  if(isDefined(equipmentref) && scripts\cp_mp\equipment::hasequipment(equipmentref)) {
    _giveweapon(self.gastakenweaponobj);
    slot = scripts\cp_mp\equipment::findequipmentslot(equipmentref);
    assertex(isDefined(slot) && (slot == "primary" || slot == "secondary"), "gas_restoreHeldOffhand is trying to " + equipmentref + ", but its slot is invalid.");

    if(slot == "primary") {
      self assignweaponoffhandprimary(self.gastakenweaponobj);
    } else if(slot == "secondary") {
      self assignweaponoffhandsecondary(self.gastakenweaponobj);
    }

    scripts\cp_mp\equipment::setequipmentammo(equipmentref, self.gastakenweaponammo);
    self.gastakenweaponobj = undefined;
    self.gastakenweaponammo = undefined;
    return;
  }

  isgesture = scripts\cp\utility::isgesture(self.gastakenweaponobj);

  if(isgesture) {
    if(isDefined(self.gestureweapon) && self.gestureweapon == self.gastakenweaponobj.basename) {
      _giveweapon(self.gastakenweaponobj);
      self.gastakenweaponobj = undefined;
    }

    return;
  }

  _giveweapon(self.gastakenweaponobj);
  self setweaponammoclip(self.gastakenweaponobj, self.gastakenweaponammo);
  self.gastakenweaponobj = undefined;
  self.gastakenweaponammo = undefined;
}

function get_power_ref_from_weapon(objweapon) {
  ref = objweapon.basename;

  foreach(struct in level.powers) {
    if(isDefined(struct.weaponuse)) {
      if(ref == struct.weaponuse) {
        return key;
      }
    }
  }

  return undefined;
}

function gas_applyspeedredux() {
  self endon("death_or_disconnect");
  self notify("gas_modify_speed");
  self endon("gas_modify_speed");

  if(isDefined(self.gasspeedmod)) {
    if(self.gasspeedmod < -0.15) {
      if(scripts\cp\utility::_hasperk("specialty_gas_grenade_resist")) {
        self.gasspeedmod = -0.15;
        self[[level.move_speed_scale]]();
        return;
      }

      if(isDefined(self.gastriggerstouching)) {
        foreach(trigger in self.gastriggerstouching) {
          if(isDefined(trigger) && isDefined(trigger.owner) && trigger.owner == self) {
            if(getdvarint(@ "hash_6c7fd12a611ca1e8", 0) == 1) {
              self.gasspeedmod = 0;
              break;
            }

            self.gasspeedmod = -0.15;
            self[[level.move_speed_scale]]();
            return;
          }
        }
      }
    }
  } else {
    self.gasspeedmod = 0;
  }

  var_d255a8b6d0ef299d = -0.35;

  if(scripts\cp\utility::_hasperk("specialty_gas_grenade_resist")) {
    var_d255a8b6d0ef299d = -0.15;
  } else if(isDefined(self.gastriggerstouching)) {
    foreach(trigger in self.gastriggerstouching) {
      if(isDefined(trigger) && isDefined(trigger.owner) && trigger.owner == self) {
        if(getdvarint(@ "hash_6c7fd12a611ca1e8", 0) == 1) {
          break;
        }

        var_d255a8b6d0ef299d = -0.15;
      }
    }
  }

  gas_modifyspeed(var_d255a8b6d0ef299d);
  self.gasspeedmod = var_d255a8b6d0ef299d;
  self[[level.move_speed_scale]]();
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
  self[[level.move_speed_scale]]();
}

function gas_modifyspeed(var_d255a8b6d0ef299d) {
  timeelapsed = 0;

  while(timeelapsed <= 0.65) {
    timeelapsed += 0.05;
    self.gasspeedmod = math::lerp(self.gasspeedmod, var_d255a8b6d0ef299d, min(1, timeelapsed / 0.65));
    self[[level.move_speed_scale]]();
    wait 0.05;
  }
}

function gas_clearspeedredux(fromdeath) {
  self notify("gas_modify_speed");
  self.gasspeedmod = undefined;

  if(!istrue(fromdeath)) {
    self[[level.move_speed_scale]]();
  }
}

function gas_applyblur() {
  self endon("death_or_disconnect");
  self notify("gas_modify_blur");
  self endon("gas_modify_blur");
  shockfile = "gas_grenade_heavy_mp";

  if(scripts\cp\utility::_hasperk("specialty_gas_grenade_resist")) {
    shockfile = "gas_grenade_light_mp";
  } else if(isDefined(self.gastriggerstouching)) {
    foreach(trigger in self.gastriggerstouching) {
      if(isDefined(trigger) && isDefined(trigger.owner) && trigger.owner == self) {
        if(getdvarint(@ "hash_6c7fd12a611ca1e8", 0) == 1) {
          break;
        }

        shockfile = "gas_grenade_light_mp";
      }
    }
  }

  while(true) {
    _shellshock(shockfile, "gas", 0.5, 0);
    wait 0.2;
  }
}

function gas_removeblur() {
  self notify("gas_modify_blur");
}

function gas_clearblur(fromdeath) {
  self notify("gas_modify_blur");

  if(!istrue(fromdeath)) {
    _stopshellshock();
  }
}

function gas_shouldtakeheldoffhand() {
  switch (self getheldoffhand().basename) {
    case #"hash_3102ab88c5c102fc":
      return false;
    default:
      return true;
  }

  return false;
}

function gas_coughisblocked() {
  if(!val::get("cough_gesture")) {
    return true;
  }

  if(!val::get("offhand_weapons")) {
    return true;
  }

  if(!isnullweapon(self getheldoffhand()) && !gas_shouldtakeheldoffhand()) {
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
  if(istrue(self.isjuggernaut)) {
    gas_clear();
    return;
  }

  if(gas_isintrigger()) {
    thread gas_applyspeedredux();
    thread gas_applyblur();
  }
}

function gas_getblurinterruptdelayms(duration) {
  return 200;
}