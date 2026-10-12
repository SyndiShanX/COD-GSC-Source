/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\teargas.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#namespace teargas;

function precache(offhand) {
  registeroffhandfirefunc(offhand, &teargasfiremain);
}

function teargasfiremain(grenade, weapon) {
  if(!isDefined(grenade)) {
    return;
  }

  grenade endon("end_explode");
  grenade waittill("explode", position);
  thread gas_createtrigger(position);
}

function gas_createtrigger(position, owner, team, duration, scale) {
  if(!isDefined(duration)) {
    duration = 7;
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  trigger = spawn("trigger_radius", position + (0, 0, int(-57.75 * scale)), 7, int(256 * scale), int(175 * scale));
  trigger thread gas_badplace(duration, scale);
  trigger endon("death");
  trigger.owner = owner;
  trigger.team = team;
  trigger.entsintrigger = [];
  trigger thread gas_watchtriggerenter();
  trigger thread gas_watchtriggerexit();
  wait duration;
  trigger thread gas_destroytrigger();
}

function gas_badplace(duration, scale) {
  if(!isDefined(self)) {
    return;
  }

  navobstaclescaler = 0.66;
  pre_wait = duration * 0.15;
  post_wait = duration * 0.25;
  assertex(pre_wait + post_wait <= duration, "Incorrect pre/post wait values");
  wait pre_wait;
  navobstacleradius = 256 * scale * navobstaclescaler;
  navobstacleheight = 175 * scale * navobstaclescaler;
  zeroangles = (0, 0, 0);
  navobstacle = createnavbadplacebyshape(self.origin, zeroangles, 8, navobstacleradius, navobstacleheight);
  wait max(0.05, duration - pre_wait - post_wait);

  if(isDefined(navobstacle)) {
    destroynavobstacle(navobstacle);
  }
}

function gas_destroytrigger() {
  foreach(player in self.entsintrigger) {
    if(!isDefined(player)) {
      continue;
    }

    self.entsintrigger[player getentitynumber()] = undefined;
    player thread gas_onexittrigger(self getentitynumber());
  }

  self delete();
}

function gas_onexittrigger(triggerid) {
  assertex(isDefined(triggerid), "gas_onExitTrigger called with an invalid trigger ID.");

  if(!isDefined(self.gastriggerstouching)) {
    return;
  }

  self.gastriggerstouching[triggerid] = undefined;
  self.lastgastouchtime = gettime();

  if(self.gastriggerstouching.size == 0) {
    thread gas_removespeedredux();
    thread gas_removeblur();
    disableloopingcoughaudio();
    self notify("gas_exited");
  }
}

function gas_watchtriggerenter() {
  self endon("death");

  while(true) {
    self waittill("trigger", who);

    if(!isalive(who)) {
      continue;
    }

    if(ignoretriggerconditions(who)) {
      continue;
    }

    entnum = who getentitynumber();

    if(isDefined(self.entsintrigger[entnum])) {
      continue;
    }

    self.entsintrigger[entnum] = who;
    who thread gas_onentertrigger(self);
  }
}

function ignoretriggerconditions(player) {
  if(isPlayer(player) && player function_7ee20cf3c0390e21()) {
    return true;
  }

  return false;
}

function gas_onentertrigger(trigger) {
  if(!isDefined(self.gastriggerstouching)) {
    self.gastriggerstouching = [];
  }

  entnum = trigger getentitynumber();
  self.gastriggerstouching[entnum] = trigger;
  self.lastgastouchtime = gettime();

  if(self.gastriggerstouching.size >= 1) {
    if(isPlayer(self)) {
      thread gas_applyspeedredux();
      thread gas_applyblur();
    }
  }

  if(self.gastriggerstouching.size == 1) {
    if(isPlayer(self)) {
      thread gas_applycough(trigger.owner, 0);
    }

    if(!istrue(self.var_71bac99803ea4156)) {
      enableloopingcoughaudio();
    }
  }

  return entnum;
}

function gas_watchtriggerexit() {
  self endon("death");

  while(true) {
    foreach(player in self.entsintrigger) {
      if(!isDefined(player)) {
        self.entsintrigger[id] = undefined;
        continue;
      }

      if(!isalive(player)) {
        continue;
      }

      if(player istouching(self) && !ignoretriggerconditions(player)) {
        continue;
      }

      self.entsintrigger[player getentitynumber()] = undefined;
      player thread gas_onexittrigger(self getentitynumber());
    }

    waitframe();
  }
}

function gas_applyblur() {
  self endon("death_or_disconnect");
  self notify("gas_modify_blur");
  self endon("gas_modify_blur");
  shockfile = "gas_grenade_heavy_mp";

  if(isDefined(self.gastriggerstouching)) {
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
    self shellshock(shockfile, 0.5, 1, 0);
    wait 0.2;
  }
}

function gas_removeblur() {
  self notify("gas_modify_blur");
}

function gas_clearblur(fromdeath) {
  self notify("gas_modify_blur");

  if(!istrue(fromdeath)) {
    self stopshellshock();
  }
}

function gas_applycough(attacker, fromimpact) {
  var_8907f741f3a7b3f7 = isDefined(attacker) && self == attacker;

  if(!var_8907f741f3a7b3f7) {
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
    self takeweapon("gas_cough_light_mp");
  }

  if(self hasweapon(makeweapon("gas_cough_heavy_mp"))) {
    self takeweapon("gas_cough_heavy_mp");
  }

  weaponobj = ter_op(istrue(isheavy), makeweapon("gas_cough_heavy_mp"), makeweapon("gas_cough_light_mp"));
  duration = ter_op(istrue(isheavy), 3.33, 1.833);
  self giveandfireoffhand(weaponobj);
  childthread gas_monitorcoughweaponfired(weaponobj);
  childthread gas_monitorcoughweapontaken(weaponobj);
  childthread gas_monitorcoughduration(duration);
  waittill_any_3("gas_coughWeaponFired", "gas_coughWeaponTaken", "gas_coughDuration");

  if(self hasweapon(weaponobj)) {
    self takeweapon(weaponobj);
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
        self takeweapon("gas_cough_light_mp");
      }

      if(self hasweapon(makeweapon("gas_cough_heavy_mp"))) {
        self takeweapon("gas_cough_heavy_mp");
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

function gas_monitorcoughweaponfired(coughweaponobj) {
  self endon("gas_coughWeaponTaken");
  self endon("gas_coughDuration");

  while(true) {
    self waittill("offhand_fired", weaponobj);

    if(issameweapon(weaponobj, coughweaponobj)) {
      break;
    }
  }

  self notify("gas_coughWeaponFired");
}

function gas_monitorcoughweapontaken(coughweaponobj) {
  self endon("gas_coughWeaponFired");
  self endon("gas_coughDuration");

  while(self hasweapon(coughweaponobj)) {
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

function enableloopingcoughaudio() {
  if(!isDefined(self.loopingcoughaudio)) {
    self.loopingcoughaudio = 0;
  }

  self.loopingcoughaudio++;

  if(self.loopingcoughaudio == 1) {
    thread startloopingcoughaudio();
  }
}

function disableloopingcoughaudio() {
  if(!isDefined(self.loopingcoughaudio)) {
    return;
  }

  self.loopingcoughaudio--;
  assertex(self.loopingcoughaudio >= 0, "disableLoopingCoughAudio called more times than enableLoopingCoughAudio.");

  if(self.loopingcoughaudio == 0) {
    thread stoploopingcoughaudio();
    self.loopingcoughaudio = undefined;
  }
}

function startloopingcoughaudio() {
  self endon("death_or_disconnect");
  self endon("clearLoopingCoughAudio");

  while(true) {
    if(!loopingcoughaudioissupressed()) {
      if(isPlayer(self)) {
        self playSound("gas_player_cough");
      } else {
        self playSound("generic_cough_fit_enemy_8");
      }
    }

    wait randomfloatrange(5, 7);
  }
}

function stoploopingcoughaudio() {
  self notify("clearLoopingCoughAudio");
}

function enableloopingcoughaudiosupression() {
  if(!isDefined(self.loopingcoughaudiosupression)) {
    self.loopingcoughaudiosupression = 0;
  }

  self.loopingcoughaudiosupression++;
}

function disableloopingcoughaudiosupression() {
  if(!isDefined(self.loopingcoughaudiosupression)) {
    return;
  }

  self.loopingcoughaudiosupression--;
  assertex(self.loopingcoughaudiosupression >= 0, "disableLoopingCoughAudioSupression called more times than enableLoopingCoughAudioSupression.");
}

function loopingcoughaudioissupressed() {
  return isDefined(self.loopingcoughaudiosupression) && self.loopingcoughaudiosupression > 0;
}

function clearloopingcoughaudio() {
  self notify("clearLoopingCoughAudio");
  self.loopingcoughaudio = undefined;
  self.loopingcoughaudiosupression = undefined;
}

function gas_takeheldoffhand() {
  if(isDefined(self.gastakenweaponobj)) {
    gas_restoreheldoffhand();
  }

  self endon("gas_restoreHeldOffhand");
  self.gastakenweaponobj = self getheldoffhand();
  self.gastakenweaponammo = self getammocount(self.gastakenweaponobj);
  self takeweapon(self.gastakenweaponobj);
  waitframe();
  thread gas_restoreheldoffhand();
}

function gas_restoreheldoffhand() {
  self notify("gas_restoreHeldOffhand");
  self giveweapon(self.gastakenweaponobj);
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
      if(isDefined(self.gastriggerstouching)) {
        foreach(trigger in self.gastriggerstouching) {
          if(isDefined(trigger) && isDefined(trigger.owner) && trigger.owner == self) {
            if(getdvarint(@ "hash_6c7fd12a611ca1e8", 0) == 1) {
              self.gasspeedmod = 0;
              break;
            }

            self.gasspeedmod = -0.15;
            updatemovespeedscale();
            return;
          }
        }
      }
    }
  } else {
    self.gasspeedmod = 0;
  }

  targetspeedmod = -0.35;

  if(isDefined(self.gastriggerstouching)) {
    foreach(trigger in self.gastriggerstouching) {
      if(isDefined(trigger) && isDefined(trigger.owner) && trigger.owner == self) {
        if(getdvarint(@ "hash_6c7fd12a611ca1e8", 0) == 1) {
          break;
        }

        targetspeedmod = -0.15;
      }
    }
  }

  gas_modifyspeed(targetspeedmod);
  self.gasspeedmod = targetspeedmod;
  updatemovespeedscale();
}

function gas_removespeedredux() {
  self endon("death_or_disconnect");
  self notify("gas_modify_speed");
  self endon("gas_modify_speed");

  if(!isDefined(self.gasspeedmod)) {
    return;
  }

  gas_modifyspeed(0);
}

function gas_modifyspeed(targetspeedmod) {
  timeelapsed = 0;

  while(timeelapsed <= 0.65) {
    timeelapsed += 0.05;
    self.gasspeedmod = math::lerp(self.gasspeedmod, targetspeedmod, min(1, timeelapsed / 0.65));
    updatemovespeedscale();
    wait 0.05;
  }

  self.gasspeedmod = undefined;
  updatemovespeedscale();
}

function gas_clearspeedredux(fromdeath) {
  self notify("gas_modify_speed");
  self.gasspeedmod = undefined;

  if(!istrue(fromdeath)) {
    updatemovespeedscale();
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
  if(gas_isintrigger()) {
    thread gas_applyspeedredux();
    thread gas_applyblur();
  }
}

function gas_getblurinterruptdelayms(duration) {
  return 200;
}

function updatemovespeedscale() {
  speedperc = 1;

  if(isDefined(self.gasspeedmod)) {
    speedperc += self.gasspeedmod;
  }

  speedperc = clamp(speedperc, 0.1, 1.08);
  self setmovespeedscale(speedperc);
}