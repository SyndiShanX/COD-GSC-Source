/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_weaponobjects.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\dev_shared;
#using scripts\shared\entityheadicons_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\player_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\weapons\_hive_gun;
#using scripts\shared\weapons\_satchel_charge;
#using scripts\shared\weapons\_trophy_system;
#using scripts\shared\weapons\_weaponobjects;
#using scripts\shared\weapons_shared;
#namespace weaponobjects;

function init_shared() {
  callback::on_start_gametype( & start_gametype);
  clientfield::register("toplayer", "proximity_alarm", 1, 2, "int");
  clientfield::register("clientuimodel", "hudItems.proximityAlarm", 1, 2, "int");
  clientfield::register("missile", "retrievable", 1, 1, "int");
  clientfield::register("scriptmover", "retrievable", 1, 1, "int");
  clientfield::register("missile", "enemyequip", 1, 2, "int");
  clientfield::register("scriptmover", "enemyequip", 1, 2, "int");
  clientfield::register("missile", "teamequip", 1, 1, "int");
  level.weaponobjectdebug = getdvarint("scr_weaponobject_debug", 0);
  level.supplementalwatcherobjects = [];
  level thread updatedvars();
}

function updatedvars() {
  while (true) {
    level.weaponobjectdebug = getdvarint("scr_weaponobject_debug", 0);
    wait(1);
  }
}

function start_gametype() {
  coneangle = getdvarint("scr_weaponobject_coneangle", 70);
  mindist = getdvarint("scr_weaponobject_mindist", 20);
  graceperiod = getdvarfloat("scr_weaponobject_graceperiod", 0.6);
  radius = getdvarint("scr_weaponobject_radius", 192);
  callback::on_connect( & on_player_connect);
  callback::on_spawned( & on_player_spawned);
  level.watcherweapons = [];
  level.watcherweapons = getwatcherweapons();
  level.retrievableweapons = [];
  level.retrievableweapons = getretrievableweapons();
  level.weaponobjectexplodethisframe = 0;
  if(getdvarstring("scr_deleteexplosivesonspawn") == "") {
    setdvar("scr_deleteexplosivesonspawn", 1);
  }
  level.deleteexplosivesonspawn = getdvarint("scr_deleteexplosivesonspawn");
  level.claymorefxid = "_t6/weapon/claymore/fx_claymore_laser";
  level._equipment_spark_fx = "explosions/fx_exp_equipment_lg";
  level._equipment_fizzleout_fx = "explosions/fx_exp_equipment_lg";
  level._equipment_emp_destroy_fx = "killstreaks/fx_emp_explosion_equip";
  level._equipment_explode_fx = "_t6/explosions/fx_exp_equipment";
  level._equipment_explode_fx_lg = "explosions/fx_exp_equipment_lg";
  level._effect["powerLight"] = "weapon/fx_equip_light_os";
  setupretrievablehintstrings();
  level.weaponobjects_hacker_trigger_width = 32;
  level.weaponobjects_hacker_trigger_height = 32;
}

function setupretrievablehintstrings() {
  createretrievablehint("hatchet", & "MP_HATCHET_PICKUP");
  createretrievablehint("claymore", & "MP_CLAYMORE_PICKUP");
  createretrievablehint("bouncingbetty", & "MP_BOUNCINGBETTY_PICKUP");
  createretrievablehint("trophy_system", & "MP_TROPHY_SYSTEM_PICKUP");
  createretrievablehint("acoustic_sensor", & "MP_ACOUSTIC_SENSOR_PICKUP");
  createretrievablehint("camera_spike", & "MP_CAMERA_SPIKE_PICKUP");
  createretrievablehint("satchel_charge", & "MP_SATCHEL_CHARGE_PICKUP");
  createretrievablehint("scrambler", & "MP_SCRAMBLER_PICKUP");
  createretrievablehint("proximity_grenade", & "MP_SHOCK_CHARGE_PICKUP");
  createdestroyhint("trophy_system", & "MP_TROPHY_SYSTEM_DESTROY");
  createdestroyhint("sensor_grenade", & "MP_SENSOR_GRENADE_DESTROY");
  createhackerhint("claymore", & "MP_CLAYMORE_HACKING");
  createhackerhint("bouncingbetty", & "MP_BOUNCINGBETTY_HACKING");
  createhackerhint("trophy_system", & "MP_TROPHY_SYSTEM_HACKING");
  createhackerhint("acoustic_sensor", & "MP_ACOUSTIC_SENSOR_HACKING");
  createhackerhint("camera_spike", & "MP_CAMERA_SPIKE_HACKING");
  createhackerhint("satchel_charge", & "MP_SATCHEL_CHARGE_HACKING");
  createhackerhint("scrambler", & "MP_SCRAMBLER_HACKING");
}

function on_player_connect() {
  if(isdefined(level._weaponobjects_on_player_connect_override)) {
    level thread[[level._weaponobjects_on_player_connect_override]]();
    return;
  }
  self.usedweapons = 0;
  self.hits = 0;
}

function on_player_spawned() {
  self endon("disconnect");
  pixbeginevent("onPlayerSpawned");
  if(!isdefined(self.watchersinitialized)) {
    self createbasewatchers();
    self callback::callback_weapon_watcher();
    self createclaymorewatcher();
    self creatercbombwatcher();
    self createqrdronewatcher();
    self createplayerhelicopterwatcher();
    self createhatchetwatcher();
    self createspecialcrossbowwatcher();
    self createtactinsertwatcher();
    self hive_gun::createfireflypodwatcher();
    self setupretrievablewatcher();
    self thread watchweaponobjectusage();
    self.watchersinitialized = 1;
  }
  self resetwatchers();
  self trophy_system::ammo_reset();
  pixendevent();
}

function resetwatchers() {
  if(!isdefined(self.weaponobjectwatcherarray)) {
    return undefined;
  }
  team = self.team;
  foreach(watcher in self.weaponobjectwatcherarray) {
    resetweaponobjectwatcher(watcher, team);
  }
}

function createbasewatchers() {
  foreach(weapon in level.watcherweapons) {
    self createweaponobjectwatcher(weapon.name, self.team);
  }
  foreach(weapon in level.retrievableweapons) {
    self createweaponobjectwatcher(weapon.name, self.team);
  }
}

function setupretrievablewatcher() {
  for (i = 0; i < level.retrievableweapons.size; i++) {
    watcher = getweaponobjectwatcherbyweapon(level.retrievableweapons[i]);
    if(isdefined(watcher)) {
      if(!isdefined(watcher.onspawnretrievetriggers)) {
        watcher.onspawnretrievetriggers = & onspawnretrievableweaponobject;
      }
      if(!isdefined(watcher.ondestroyed)) {
        watcher.ondestroyed = & ondestroyed;
      }
      if(!isdefined(watcher.pickup)) {
        watcher.pickup = & pickup;
      }
    }
  }
}

function createspecialcrossbowwatchertypes(weaponname) {
  watcher = self createuseweaponobjectwatcher(weaponname, self.team);
  watcher.ondetonatecallback = & deleteent;
  watcher.ondamage = & voidondamage;
  if(isdefined(level.b_crossbow_bolt_destroy_on_impact) && level.b_crossbow_bolt_destroy_on_impact) {
    watcher.onspawn = & onspawncrossbowboltimpact;
    watcher.onspawnretrievetriggers = & voidonspawnretrievetriggers;
    watcher.pickup = & voidpickup;
  } else {
    watcher.onspawn = & onspawncrossbowbolt;
    watcher.onspawnretrievetriggers = & onspawnspecialcrossbowtrigger;
    watcher.pickup = & pickupcrossbowbolt;
  }
}

function createspecialcrossbowwatcher() {
  createspecialcrossbowwatchertypes("special_crossbow");
  createspecialcrossbowwatchertypes("special_crossbowlh");
  createspecialcrossbowwatchertypes("special_crossbow_dw");
  if(isdefined(level.b_create_upgraded_crossbow_watchers) && level.b_create_upgraded_crossbow_watchers) {
    createspecialcrossbowwatchertypes("special_crossbowlh_upgraded");
    createspecialcrossbowwatchertypes("special_crossbow_dw_upgraded");
  }
}

function createhatchetwatcher() {
  watcher = self createuseweaponobjectwatcher("hatchet", self.team);
  watcher.ondetonatecallback = & deleteent;
  watcher.onspawn = & onspawnhatchet;
  watcher.ondamage = & voidondamage;
  watcher.onspawnretrievetriggers = & onspawnhatchettrigger;
}

function createtactinsertwatcher() {
  watcher = self createuseweaponobjectwatcher("tactical_insertion", self.team);
  watcher.playdestroyeddialog = 0;
}

function creatercbombwatcher() {
  watcher = self createuseweaponobjectwatcher("rcbomb", self.team);
  watcher.altdetonate = 0;
  watcher.headicon = 0;
  watcher.ismovable = 1;
  watcher.ownergetsassist = 1;
  watcher.playdestroyeddialog = 0;
  watcher.deleteonkillbrush = 0;
  watcher.ondetonatecallback = level.rcbombonblowup;
  watcher.stuntime = 1;
  watcher.notequipment = 1;
}

function createqrdronewatcher() {
  watcher = self createuseweaponobjectwatcher("qrdrone", self.team);
  watcher.altdetonate = 0;
  watcher.headicon = 0;
  watcher.ismovable = 1;
  watcher.ownergetsassist = 1;
  watcher.playdestroyeddialog = 0;
  watcher.deleteonkillbrush = 0;
  watcher.ondetonatecallback = level.qrdroneonblowup;
  watcher.ondamage = level.qrdroneondamage;
  watcher.stuntime = 5;
  watcher.notequipment = 1;
}

function getspikelauncheractivespikecount(watcher) {
  currentitemcount = 0;
  foreach(obj in watcher.objectarray) {
    if(isdefined(obj) && obj.item !== watcher.weapon) {
      currentitemcount++;
    }
  }
  return currentitemcount;
}

function watchspikelauncheritemcountchanged(watcher) {
  self endon("death");
  lastitemcount = undefined;
  while (true) {
    self waittill("weapon_change", weapon);
    while (weapon.name == "spike_launcher") {
      currentitemcount = getspikelauncheractivespikecount(watcher);
      if(currentitemcount !== lastitemcount) {
        self setcontrolleruimodelvalue("spikeLauncherCounter.spikesReady", currentitemcount);
        lastitemcount = currentitemcount;
      }
      wait(0.1);
      weapon = self getcurrentweapon();
    }
  }
}

function spikesdetonating(watcher) {
  spikecount = getspikelauncheractivespikecount(watcher);
  if(spikecount > 0) {
    self setcontrolleruimodelvalue("spikeLauncherCounter.blasting", 1);
    wait(2);
    self setcontrolleruimodelvalue("spikeLauncherCounter.blasting", 0);
  }
}

function createspikelauncherwatcher(weapon) {
  watcher = self createuseweaponobjectwatcher(weapon, self.team);
  watcher.altname = "spike_charge";
  watcher.altweapon = getweapon("spike_charge");
  watcher.altdetonate = 0;
  watcher.watchforfire = 1;
  watcher.hackable = 1;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.headicon = 0;
  watcher.ondetonatecallback = & spikedetonate;
  watcher.onstun = & weaponstun;
  watcher.stuntime = 1;
  watcher.ownergetsassist = 1;
  watcher.detonatestationary = 0;
  watcher.detonationdelay = 0;
  watcher.detonationsound = "wpn_claymore_alert";
  watcher.ondetonationhandle = & spikesdetonating;
  self thread watchspikelauncheritemcountchanged(watcher);
}

function createplayerhelicopterwatcher() {
  watcher = self createuseweaponobjectwatcher("helicopter_player", self.team);
  watcher.altdetonate = 1;
  watcher.headicon = 0;
  watcher.notequipment = 1;
}

function createclaymorewatcher() {
  watcher = self createproximityweaponobjectwatcher("claymore", self.team);
  watcher.watchforfire = 1;
  watcher.ondetonatecallback = & claymoredetonate;
  watcher.activatesound = "wpn_claymore_alert";
  watcher.hackable = 1;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.ownergetsassist = 1;
  detectionconeangle = getdvarint("scr_weaponobject_coneangle");
  watcher.detectiondot = cos(detectionconeangle);
  watcher.detectionmindist = getdvarint("scr_weaponobject_mindist");
  watcher.detectiongraceperiod = getdvarfloat("scr_weaponobject_graceperiod");
  watcher.detonateradius = getdvarint("scr_weaponobject_radius");
  watcher.onstun = & weaponstun;
  watcher.stuntime = 1;
}

function voidonspawn(unused0, unused1) {}

function voidondamage(unused0) {}

function voidonspawnretrievetriggers(unused0, unused1) {}

function voidpickup(unused0, unused1) {}

function deleteent(attacker, emp, target) {
  self delete();
}

function clearfxondeath(fx) {
  fx endon("death");
  self util::waittill_any("death", "hacked");
  fx delete();
}

function deleteweaponobjectinstance() {
  if(!isdefined(self)) {
    return;
  }
  if(isdefined(self.minemover)) {
    if(isdefined(self.minemover.killcament)) {
      self.minemover.killcament delete();
    }
    self.minemover delete();
  }
  self delete();
}

function deleteweaponobjectarray() {
  if(isdefined(self.objectarray)) {
    foreach(weaponobject in self.objectarray) {
      weaponobject deleteweaponobjectinstance();
    }
  }
  self.objectarray = [];
}

function delayedspikedetonation(attacker, weapon) {
  if(!isdefined(self.owner.spikedelay)) {
    self.owner.spikedelay = 0;
  }
  delaytime = self.owner.spikedelay;
  owner = self.owner;
  self.owner.spikedelay = self.owner.spikedelay + 0.3;
  waittillframeend();
  wait(delaytime);
  owner.spikedelay = owner.spikedelay - 0.3;
  if(isdefined(self)) {
    self weapondetonate(attacker, weapon);
  }
}

function spikedetonate(attacker, weapon, target) {
  if(isdefined(weapon) && weapon.isvalid) {
    if(isdefined(attacker)) {}
  }
  thread delayedspikedetonation(attacker, weapon);
}

function claymoredetonate(attacker, weapon, target) {
  if(isdefined(attacker) && self.owner util::isenemyplayer(attacker)) {
    attacker challenges::destroyedexplosive(weapon);
    scoreevents::processscoreevent("destroyed_claymore", attacker, self.owner, weapon);
  }
  weapondetonate(attacker, weapon);
}

function weapondetonate(attacker, weapon) {
  if(isdefined(weapon) && weapon.isemp) {
    self delete();
    return;
  }
  if(isdefined(attacker)) {
    if(isdefined(self.owner) && attacker != self.owner) {
      self.playdialog = 1;
    }
    if(isplayer(attacker)) {
      self detonate(attacker);
    } else {
      self detonate();
    }
  } else {
    if(isdefined(self.owner) && isplayer(self.owner)) {
      self.playdialog = 0;
      self detonate(self.owner);
    } else {
      self detonate();
    }
  }
}

function detonatewhenstationary(object, delay, attacker, weapon) {
  level endon("game_ended");
  object endon("death");
  object endon("hacked");
  object endon("detonating");
  if(object isonground() == 0) {
    object waittill("stationary");
  }
  self thread waitanddetonate(object, delay, attacker, weapon);
}

function waitanddetonate(object, delay, attacker, weapon) {
  object endon("death");
  object endon("hacked");
  if(!isdefined(attacker) && !isdefined(weapon) && object.weapon.proximityalarmactivationdelay > 0) {
    if(isdefined(object.armed_detonation_wait) && object.armed_detonation_wait) {
      return;
    }
    object.armed_detonation_wait = 1;
    while (!(isdefined(object.proximity_deployed) && object.proximity_deployed)) {
      wait(0.05);
    }
  }
  if(isdefined(object.detonated) && object.detonated) {
    return;
  }
  object.detonated = 1;
  object notify("detonating");
  isempdetonated = isdefined(weapon) && weapon.isemp;
  if(isempdetonated && object.weapon.doempdestroyfx) {
    object.stun_fx = 1;
    playfx(level._equipment_emp_destroy_fx, object.origin + vectorscale((0, 0, 1), 5), (0, randomfloat(360), 0));
    empfxdelay = 1.1;
  }
  if(!isdefined(self.ondetonatecallback)) {
    return;
  }
  if(!isempdetonated && !isdefined(weapon)) {
    if(isdefined(self.detonationdelay) && self.detonationdelay > 0) {
      if(isdefined(self.detonationsound)) {
        object playsound(self.detonationsound);
      }
      delay = self.detonationdelay;
    }
  } else if(isdefined(empfxdelay)) {
    delay = empfxdelay;
  }
  if(delay > 0) {
    wait(delay);
  }
  if(isdefined(attacker) && isplayer(attacker) && isdefined(attacker.pers["team"]) && isdefined(object.owner) && isdefined(object.owner.pers["team"])) {
    if(level.teambased) {
      if(attacker.pers["team"] != object.owner.pers["team"]) {
        attacker notify("destroyed_explosive");
      }
    } else if(attacker != object.owner) {
      attacker notify("destroyed_explosive");
    }
  }
  object[[self.ondetonatecallback]](attacker, weapon, undefined);
}

function waitandfizzleout(object, delay) {
  object endon("death");
  object endon("hacked");
  if(isdefined(object.detonated) && object.detonated == 1) {
    return;
  }
  object.detonated = 1;
  object notify("fizzleout");
  if(delay > 0) {
    wait(delay);
  }
  if(!isdefined(self.onfizzleout)) {
    self deleteent();
    return;
  }
  object[[self.onfizzleout]]();
}

function detonateweaponobjectarray(forcedetonation, weapon) {
  undetonated = [];
  if(isdefined(self.objectarray)) {
    for (i = 0; i < self.objectarray.size; i++) {
      if(isdefined(self.objectarray[i])) {
        if(self.objectarray[i] isstunned() && forcedetonation == 0) {
          undetonated[undetonated.size] = self.objectarray[i];
          continue;
        }
        if(isdefined(weapon)) {
          if(weapon util::ishacked() && weapon.name != self.objectarray[i].weapon.name) {
            undetonated[undetonated.size] = self.objectarray[i];
            continue;
          } else if(self.objectarray[i] util::ishacked() && weapon.name != self.objectarray[i].weapon.name) {
            undetonated[undetonated.size] = self.objectarray[i];
            continue;
          }
        }
        if(isdefined(self.detonatestationary) && self.detonatestationary && forcedetonation == 0) {
          self thread detonatewhenstationary(self.objectarray[i], 0, undefined, weapon);
          continue;
        }
        self thread waitanddetonate(self.objectarray[i], 0, undefined, weapon);
      }
    }
  }
  self.objectarray = undetonated;
}

function addweaponobjecttowatcher(watchername, weapon_instance) {
  watcher = getweaponobjectwatcher(watchername);
  assert(isdefined(watcher), ("" + watchername) + "");
  self addweaponobject(watcher, weapon_instance);
}

function addweaponobject(watcher, weapon_instance, weapon) {
  if(!isdefined(watcher.storedifferentobject)) {
    watcher.objectarray[watcher.objectarray.size] = weapon_instance;
  }
  if(!isdefined(weapon)) {
    weapon = watcher.weapon;
  }
  weapon_instance.owner = self;
  weapon_instance.detonated = 0;
  weapon_instance.weapon = weapon;
  if(isdefined(watcher.ondamage)) {
    weapon_instance thread[[watcher.ondamage]](watcher);
  } else {
    weapon_instance thread weaponobjectdamage(watcher);
  }
  weapon_instance.ownergetsassist = watcher.ownergetsassist;
  weapon_instance.destroyedbyemp = watcher.destroyedbyemp;
  if(isdefined(watcher.onspawn)) {
    weapon_instance thread[[watcher.onspawn]](watcher, self);
  }
  if(isdefined(watcher.onspawnfx)) {
    weapon_instance thread[[watcher.onspawnfx]]();
  }
  weapon_instance thread setupreconeffect();
  if(isdefined(watcher.onspawnretrievetriggers)) {
    weapon_instance thread[[watcher.onspawnretrievetriggers]](watcher, self);
  }
  if(watcher.hackable) {
    weapon_instance thread hackerinit(watcher);
  }
  if(watcher.playdestroyeddialog) {
    weapon_instance thread playdialogondeath(self);
    weapon_instance thread watchobjectdamage(self);
  }
  if(watcher.deleteonkillbrush) {
    if(isdefined(level.deleteonkillbrushoverride)) {
      weapon_instance thread[[level.deleteonkillbrushoverride]](self, watcher);
    } else {
      weapon_instance thread deleteonkillbrush(self);
    }
  }
  if(weapon_instance useteamequipmentclientfield(watcher)) {
    weapon_instance clientfield::set("teamequip", 1);
  }
  if(watcher.timeout) {
    weapon_instance thread weapon_object_timeout(watcher);
  }
  weapon_instance thread delete_on_notify(self);
  weapon_instance thread cleanupwatcherondeath(watcher);
}

function cleanupwatcherondeath(watcher) {
  self waittill("death");
  if(isdefined(watcher) && isdefined(watcher.objectarray)) {
    removeweaponobject(watcher, self);
  }
  if(isdefined(self) && self.delete_on_death === 1) {
    self deleteweaponobjectinstance();
  }
}

function weapon_object_timeout(watcher) {
  self endon("death");
  wait(watcher.timeout);
  self deleteent();
}

function delete_on_notify(e_player) {
  e_player endon("disconnect");
  self endon("death");
  e_player waittill("delete_weapon_objects");
  self delete();
}

function deleteweaponobjecthelper(weapon_ent) {
  watcher = self getweaponobjectwatcherbyweapon(weapon_ent.weapon);
  if(!isdefined(watcher)) {
    return;
  }
  removeweaponobject(watcher, weapon_ent);
}

function removeweaponobject(watcher, weapon_ent) {
  watcher.objectarray = array::remove_undefined(watcher.objectarray);
  arrayremovevalue(watcher.objectarray, weapon_ent);
}

function cleanweaponobjectarray(watcher) {
  watcher.objectarray = array::remove_undefined(watcher.objectarray);
}

function weapon_object_do_damagefeedback(weapon, attacker) {
  if(isdefined(weapon) && isdefined(attacker)) {
    if(weapon.dodamagefeedback) {
      if(level.teambased && self.owner.team != attacker.team) {
        if(damagefeedback::dodamagefeedback(weapon, attacker)) {
          attacker damagefeedback::update();
        }
      } else if(!level.teambased && self.owner != attacker) {
        if(damagefeedback::dodamagefeedback(weapon, attacker)) {
          attacker damagefeedback::update();
        }
      }
    }
  }
}

function weaponobjectdamage(watcher) {
  self endon("death");
  self endon("hacked");
  self endon("detonating");
  self setcandamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self.damagetaken = 0;
  attacker = undefined;
  while (true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags);
    self.damagetaken = self.damagetaken + damage;
    if(!isplayer(attacker) && isdefined(attacker.owner)) {
      attacker = attacker.owner;
    }
    if(isdefined(weapon)) {
      self weapon_object_do_damagefeedback(weapon, attacker);
      if(watcher.stuntime > 0 && weapon.dostun) {
        self thread stunstart(watcher, watcher.stuntime);
        continue;
      }
    }
    if(level.teambased && isplayer(attacker) && isdefined(self.owner)) {
      if(!level.hardcoremode && self.owner.team == attacker.pers["team"] && self.owner != attacker) {
        continue;
      }
    }
    if(isdefined(watcher.shoulddamage) && !self[[watcher.shoulddamage]](watcher, attacker, weapon, damage)) {
      continue;
    }
    if(!isvehicle(self) && !friendlyfirecheck(self.owner, attacker)) {
      continue;
    }
    break;
  }
  if(level.weaponobjectexplodethisframe) {
    wait(0.1 + randomfloat(0.4));
  } else {
    wait(0.05);
  }
  if(!isdefined(self)) {
    return;
  }
  level.weaponobjectexplodethisframe = 1;
  thread resetweaponobjectexplodethisframe();
  self entityheadicons::setentityheadicon("none");
  if(isdefined(type) && (issubstr(type, "MOD_GRENADE_SPLASH") || issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }
  if(isdefined(idflags) && idflags & 8) {
    self.wasdamagedfrombulletpenetration = 1;
  }
  self.wasdamaged = 1;
  watcher thread waitanddetonate(self, 0, attacker, weapon);
}

function playdialogondeath(owner) {
  owner endon("death");
  owner endon("disconnect");
  self endon("hacked");
  self waittill("death");
  if(isdefined(self.playdialog) && self.playdialog) {
    if(isdefined(level.playequipmentdestroyedonplayer)) {
      owner[[level.playequipmentdestroyedonplayer]]();
    }
  }
}

function watchobjectdamage(owner) {
  owner endon("death");
  owner endon("disconnect");
  self endon("hacked");
  self endon("death");
  while (true) {
    self waittill("damage", damage, attacker);
    if(isdefined(attacker) && isplayer(attacker) && attacker != owner) {
      self.playdialog = 1;
    } else {
      self.playdialog = 0;
    }
  }
}

function stunstart(watcher, time) {
  self endon("death");
  if(self isstunned()) {
    return;
  }
  if(isdefined(watcher.onstun)) {
    self thread[[watcher.onstun]]();
  }
  if(watcher.name == "rcbomb") {
    self.owner util::freeze_player_controls(1);
  }
  if(isdefined(time)) {
    wait(time);
  } else {
    return;
  }
  if(watcher.name == "rcbomb") {
    self.owner util::freeze_player_controls(0);
  }
  self stunstop();
}

function stunstop() {
  self notify("not_stunned");
}

function weaponstun() {
  self endon("death");
  self endon("not_stunned");
  origin = self gettagorigin("tag_fx");
  if(!isdefined(origin)) {
    origin = self.origin + vectorscale((0, 0, 1), 10);
  }
  self.stun_fx = spawn("script_model", origin);
  self.stun_fx setmodel("tag_origin");
  self thread stunfxthink(self.stun_fx);
  wait(0.1);
  playfxontag(level._equipment_spark_fx, self.stun_fx, "tag_origin");
}

function stunfxthink(fx) {
  fx endon("death");
  self util::waittill_any("death", "not_stunned");
  fx delete();
}

function isstunned() {
  return isdefined(self.stun_fx);
}

function weaponobjectfizzleout() {
  self endon("death");
  playfx(level._equipment_fizzleout_fx, self.origin);
  deleteent();
}

function resetweaponobjectexplodethisframe() {
  wait(0.05);
  level.weaponobjectexplodethisframe = 0;
}

function getweaponobjectwatcher(name) {
  if(!isdefined(self.weaponobjectwatcherarray)) {
    return undefined;
  }
  for (watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
    if(self.weaponobjectwatcherarray[watcher].name == name || (isdefined(self.weaponobjectwatcherarray[watcher].altname) && self.weaponobjectwatcherarray[watcher].altname == name)) {
      return self.weaponobjectwatcherarray[watcher];
    }
  }
  return undefined;
}

function getweaponobjectwatcherbyweapon(weapon) {
  if(!isdefined(self.weaponobjectwatcherarray)) {
    return undefined;
  }
  if(!isdefined(weapon)) {
    return undefined;
  }
  for (watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
    if(isdefined(self.weaponobjectwatcherarray[watcher].weapon) && (self.weaponobjectwatcherarray[watcher].weapon == weapon || self.weaponobjectwatcherarray[watcher].weapon == weapon.rootweapon)) {
      return self.weaponobjectwatcherarray[watcher];
    }
    if(isdefined(self.weaponobjectwatcherarray[watcher].weapon) && isdefined(self.weaponobjectwatcherarray[watcher].altweapon) && self.weaponobjectwatcherarray[watcher].altweapon == weapon) {
      return self.weaponobjectwatcherarray[watcher];
    }
  }
  return undefined;
}

function resetweaponobjectwatcher(watcher, ownerteam) {
  if(watcher.deleteonplayerspawn == 1 || (isdefined(watcher.ownerteam) && watcher.ownerteam != ownerteam)) {
    self notify("weapon_object_destroyed");
    watcher deleteweaponobjectarray();
  }
  watcher.ownerteam = ownerteam;
}

function createweaponobjectwatcher(weaponname, ownerteam) {
  if(!isdefined(self.weaponobjectwatcherarray)) {
    self.weaponobjectwatcherarray = [];
  }
  weaponobjectwatcher = getweaponobjectwatcher(weaponname);
  if(!isdefined(weaponobjectwatcher)) {
    weaponobjectwatcher = spawnstruct();
    self.weaponobjectwatcherarray[self.weaponobjectwatcherarray.size] = weaponobjectwatcher;
    weaponobjectwatcher.name = weaponname;
    weaponobjectwatcher.type = "use";
    weaponobjectwatcher.weapon = getweapon(weaponname);
    weaponobjectwatcher.watchforfire = 0;
    weaponobjectwatcher.hackable = 0;
    weaponobjectwatcher.altdetonate = 0;
    weaponobjectwatcher.detectable = 1;
    weaponobjectwatcher.headicon = 0;
    weaponobjectwatcher.stuntime = 0;
    weaponobjectwatcher.timeout = 0;
    weaponobjectwatcher.destroyedbyemp = 1;
    weaponobjectwatcher.activatesound = undefined;
    weaponobjectwatcher.ignoredirection = undefined;
    weaponobjectwatcher.immediatedetonation = undefined;
    weaponobjectwatcher.deploysound = weaponobjectwatcher.weapon.firesound;
    weaponobjectwatcher.deploysoundplayer = weaponobjectwatcher.weapon.firesoundplayer;
    weaponobjectwatcher.pickupsound = weaponobjectwatcher.weapon.pickupsound;
    weaponobjectwatcher.pickupsoundplayer = weaponobjectwatcher.weapon.pickupsoundplayer;
    weaponobjectwatcher.altweapon = weaponobjectwatcher.weapon.altweapon;
    weaponobjectwatcher.ownergetsassist = 0;
    weaponobjectwatcher.playdestroyeddialog = 1;
    weaponobjectwatcher.deleteonkillbrush = 1;
    weaponobjectwatcher.deleteondifferentobjectspawn = 1;
    weaponobjectwatcher.enemydestroy = 0;
    weaponobjectwatcher.deleteonplayerspawn = level.deleteexplosivesonspawn;
    weaponobjectwatcher.ignorevehicles = 0;
    weaponobjectwatcher.ignoreai = 0;
    weaponobjectwatcher.activationdelay = 0;
    weaponobjectwatcher.onspawn = undefined;
    weaponobjectwatcher.onspawnfx = undefined;
    weaponobjectwatcher.onspawnretrievetriggers = undefined;
    weaponobjectwatcher.ondetonatecallback = undefined;
    weaponobjectwatcher.onstun = undefined;
    weaponobjectwatcher.onstunfinished = undefined;
    weaponobjectwatcher.ondestroyed = undefined;
    weaponobjectwatcher.onfizzleout = & weaponobjectfizzleout;
    weaponobjectwatcher.shoulddamage = undefined;
    weaponobjectwatcher.onsupplementaldetonatecallback = undefined;
    if(!isdefined(weaponobjectwatcher.objectarray)) {
      weaponobjectwatcher.objectarray = [];
    }
  }
  resetweaponobjectwatcher(weaponobjectwatcher, ownerteam);
  return weaponobjectwatcher;
}

function createuseweaponobjectwatcher(weaponname, ownerteam) {
  weaponobjectwatcher = createweaponobjectwatcher(weaponname, ownerteam);
  weaponobjectwatcher.type = "use";
  weaponobjectwatcher.onspawn = & onspawnuseweaponobject;
  return weaponobjectwatcher;
}

function createproximityweaponobjectwatcher(weaponname, ownerteam) {
  weaponobjectwatcher = createweaponobjectwatcher(weaponname, ownerteam);
  weaponobjectwatcher.type = "proximity";
  weaponobjectwatcher.onspawn = & onspawnproximityweaponobject;
  detectionconeangle = getdvarint("scr_weaponobject_coneangle");
  weaponobjectwatcher.detectiondot = cos(detectionconeangle);
  weaponobjectwatcher.detectionmindist = getdvarint("scr_weaponobject_mindist");
  weaponobjectwatcher.detectiongraceperiod = getdvarfloat("scr_weaponobject_graceperiod");
  weaponobjectwatcher.detonateradius = getdvarint("scr_weaponobject_radius");
  return weaponobjectwatcher;
}

function commononspawnuseweaponobject(watcher, owner) {
  level endon("game_ended");
  self endon("death");
  self endon("hacked");
  if(watcher.detectable) {
    if(watcher.headicon && level.teambased) {
      self util::waittillnotmoving();
      if(isdefined(self)) {
        offset = self.weapon.weaponheadobjectiveheight;
        v_up = anglestoup(self.angles);
        x_offset = abs(v_up[0]);
        y_offset = abs(v_up[1]);
        z_offset = abs(v_up[2]);
        if(x_offset > y_offset && x_offset > z_offset) {} else {
          if(y_offset > x_offset && y_offset > z_offset) {} else if(z_offset > x_offset && z_offset > y_offset) {
            v_up = v_up * (0, 0, 1);
          }
        }
        up_offset_modified = v_up * offset;
        up_offset = anglestoup(self.angles) * offset;
        objective = getequipmentheadobjective(self.weapon);
        self entityheadicons::setentityheadicon(owner.pers["team"], owner, up_offset, objective);
      }
    }
  }
}

function wasproximityalarmactivatedbyself() {
  return isdefined(self.owner.proximityamlarment) && self.owner.proximityamlarment == self;
}

function proximityalarmactivate(active, watcher) {
  if(!isdefined(self.owner) || !isplayer(self.owner)) {
    return;
  }
  if(active && !isdefined(self.owner.proximityamlarment)) {
    self.owner.proximityamlarment = self;
    self.owner clientfield::set_to_player("proximity_alarm", 2);
    self.owner clientfield::set_player_uimodel("hudItems.proximityAlarm", 2);
  } else if(!isdefined(self) || self wasproximityalarmactivatedbyself() || self.owner clientfield::get_to_player("proximity_alarm") == 1) {
    self.owner.proximityamlarment = undefined;
    self.owner clientfield::set_to_player("proximity_alarm", 0);
    self.owner clientfield::set_player_uimodel("hudItems.proximityAlarm", 0);
  }
}

function proximityalarmloop(watcher, owner) {
  level endon("game_ended");
  self endon("death");
  self endon("hacked");
  self endon("detonating");
  if(self.weapon.proximityalarminnerradius <= 0) {
    return;
  }
  self util::waittillnotmoving();
  delaytimesec = self.weapon.proximityalarmactivationdelay / 1000;
  if(delaytimesec > 0) {
    wait(delaytimesec);
    if(!isdefined(self)) {
      return;
    }
  }
  if(!(isdefined(self.owner._disable_proximity_alarms) && self.owner._disable_proximity_alarms)) {
    self.owner clientfield::set_to_player("proximity_alarm", 1);
    self.owner clientfield::set_player_uimodel("hudItems.proximityAlarm", 1);
  }
  self.proximity_deployed = 1;
  alarmstatusold = "notify";
  alarmstatus = "off";
  while (true) {
    wait(0.05);
    if(!isdefined(self.owner) || !isplayer(self.owner)) {
      return;
    }
    if(isalive(self.owner) == 0 && self.owner util::isusingremote() == 0) {
      self proximityalarmactivate(0, watcher);
      return;
    }
    if(isdefined(self.owner._disable_proximity_alarms) && self.owner._disable_proximity_alarms) {
      self proximityalarmactivate(0, watcher);
    } else if(alarmstatus != alarmstatusold || (alarmstatus == "on" && !isdefined(self.owner.proximityamlarment))) {
      if(alarmstatus == "on") {
        if(alarmstatusold == "off" && isdefined(watcher) && isdefined(watcher.proximityalarmactivatesound)) {
          playsoundatposition(watcher.proximityalarmactivatesound, self.origin + vectorscale((0, 0, 1), 32));
        }
        self proximityalarmactivate(1, watcher);
      } else {
        self proximityalarmactivate(0, watcher);
      }
      alarmstatusold = alarmstatus;
    }
    alarmstatus = "off";
    actors = getactorarray();
    players = getplayers();
    detectentities = arraycombine(players, actors, 0, 0);
    foreach(entity in detectentities) {
      wait(0.05);
      if(!isdefined(entity)) {
        continue;
      }
      owner = entity;
      if(isactor(entity) && (!isdefined(entity.isaiclone) || !entity.isaiclone)) {
        continue;
      } else if(isactor(entity)) {
        owner = entity.owner;
      }
      if(entity.team == "spectator") {
        continue;
      }
      if(level.weaponobjectdebug != 1) {
        if(owner hasperk("specialty_detectexplosive")) {
          continue;
        }
        if(isdefined(self.owner) && owner == self.owner) {
          continue;
        }
        if(!friendlyfirecheck(self.owner, owner, 0)) {
          continue;
        }
      }
      if(self isstunned()) {
        continue;
      }
      if(!isalive(entity)) {
        continue;
      }
      if(isdefined(watcher.immunespecialty) && owner hasperk(watcher.immunespecialty)) {
        continue;
      }
      radius = self.weapon.proximityalarmouterradius;
      distancesqr = distancesquared(self.origin, entity.origin);
      if((radius * radius) < distancesqr) {
        continue;
      }
      if(entity damageconetrace(self.origin, self) == 0) {
        continue;
      }
      if(alarmstatusold == "on") {
        alarmstatus = "on";
        break;
      }
      radius = self.weapon.proximityalarminnerradius;
      if((radius * radius) < distancesqr) {
        continue;
      }
      alarmstatus = "on";
      break;
    }
  }
}

function commononspawnuseweaponobjectproximityalarm(watcher, owner) {
  if(level.weaponobjectdebug == 1) {
    self thread proximityalarmweaponobjectdebug(watcher);
  }
  self proximityalarmloop(watcher, owner);
  self proximityalarmactivate(0, watcher);
}

function onspawnuseweaponobject(watcher, owner) {
  self thread commononspawnuseweaponobject(watcher, owner);
  self thread commononspawnuseweaponobjectproximityalarm(watcher, owner);
}

function onspawnproximityweaponobject(watcher, owner) {
  self.protected_entities = [];
  self thread commononspawnuseweaponobject(watcher, owner);
  if(isdefined(level._proximityweaponobjectdetonation_override)) {
    self thread[[level._proximityweaponobjectdetonation_override]](watcher);
  } else {
    self thread proximityweaponobjectdetonation(watcher);
  }
  if(level.weaponobjectdebug == 1) {
    self thread proximityweaponobjectdebug(watcher);
  }
}

function watchweaponobjectusage() {
  self endon("disconnect");
  if(!isdefined(self.weaponobjectwatcherarray)) {
    self.weaponobjectwatcherarray = [];
  }
  self thread watchweaponobjectspawn("grenade_fire");
  self thread watchweaponobjectspawn("grenade_launcher_fire");
  self thread watchweaponobjectspawn("missile_fire");
  self thread watchweaponobjectdetonation();
  self thread watchweaponobjectaltdetonation();
  self thread watchweaponobjectaltdetonate();
  self thread deleteweaponobjectson();
}

function watchweaponobjectspawn(notify_type) {
  self notify("watchWeaponObjectSpawn_" + notify_type);
  self endon("watchWeaponObjectSpawn_" + notify_type);
  self endon("disconnect");
  while (true) {
    self waittill(notify_type, weapon_instance, weapon);
    if(sessionmodeiscampaignzombiesgame() || (isdefined(level.projectiles_should_ignore_world_pause) && level.projectiles_should_ignore_world_pause) && isdefined(weapon_instance)) {
      weapon_instance setignorepauseworld(1);
    }
    if(weapon.setusedstat && !self util::ishacked()) {
      self addweaponstat(weapon, "used", 1);
    }
    watcher = getweaponobjectwatcherbyweapon(weapon);
    if(isdefined(watcher)) {
      cleanweaponobjectarray(watcher);
      if(weapon.maxinstancesallowed) {
        if(watcher.objectarray.size > (weapon.maxinstancesallowed - 1)) {
          watcher thread waitandfizzleout(watcher.objectarray[0], 0.1);
          watcher.objectarray[0] = undefined;
          cleanweaponobjectarray(watcher);
        }
      }
      self addweaponobject(watcher, weapon_instance);
    }
  }
}

function anyobjectsinworld(weapon) {
  objectsinworld = 0;
  for (i = 0; i < self.weaponobjectwatcherarray.size; i++) {
    if(self.weaponobjectwatcherarray[i].weapon != weapon) {
      continue;
    }
    if(isdefined(self.weaponobjectwatcherarray[i].ondetonatecallback) && self.weaponobjectwatcherarray[i].objectarray.size > 0) {
      objectsinworld = 1;
      break;
    }
  }
  return objectsinworld;
}

function proximitysphere(origin, innerradius, incolor, outerradius, outcolor) {
  self endon("death");
  while (true) {
    if(isdefined(innerradius)) {
      dev::debug_sphere(origin, innerradius, incolor, 0.25, 1);
    }
    if(isdefined(outerradius)) {
      dev::debug_sphere(origin, outerradius, outcolor, 0.25, 1);
    }
    wait(0.05);
  }
}

function proximityalarmweaponobjectdebug(watcher) {
  self endon("death");
  self util::waittillnotmoving();
  if(!isdefined(self)) {
    return;
  }
  self thread proximitysphere(self.origin, self.weapon.proximityalarminnerradius, vectorscale((0, 1, 0), 0.75), self.weapon.proximityalarmouterradius, vectorscale((0, 1, 0), 0.75));
}

function proximityweaponobjectdebug(watcher) {
  self endon("death");
  self util::waittillnotmoving();
  if(!isdefined(self)) {
    return;
  }
  if(isdefined(watcher.ignoredirection)) {
    self thread proximitysphere(self.origin, watcher.detonateradius, (1, 0.85, 0), self.weapon.explosionradius, (1, 0, 0));
  } else {
    self thread showcone(acos(watcher.detectiondot), watcher.detonateradius, (1, 0.85, 0));
    self thread showcone(60, 256, (1, 0, 0));
  }
}

function showcone(angle, range, color) {
  self endon("death");
  start = self.origin;
  forward = anglestoforward(self.angles);
  right = vectorcross(forward, (0, 0, 1));
  up = vectorcross(forward, right);
  fullforward = (forward * range) * cos(angle);
  sideamnt = range * sin(angle);
  while (true) {
    prevpoint = (0, 0, 0);
    for (i = 0; i <= 20; i++) {
      coneangle = (i / 20) * 360;
      point = (start + fullforward) + (sideamnt * (right * cos(coneangle)) + (up * sin(coneangle)));
      if(i > 0) {
        line(start, point, color);
        line(prevpoint, point, color);
      }
      prevpoint = point;
    }
    wait(0.05);
  }
}

function weaponobjectdetectionmovable(ownerteam) {
  self endon("end_detection");
  level endon("game_ended");
  self endon("death");
  self endon("hacked");
  if(!level.teambased) {
    return;
  }
  self.detectid = ("rcBomb" + gettime()) + randomint(1000000);
}

function seticonpos(item, icon, heightincrease) {
  icon.x = item.origin[0];
  icon.y = item.origin[1];
  icon.z = item.origin[2] + heightincrease;
}

function weaponobjectdetectiontrigger_wait(ownerteam) {
  self endon("death");
  self endon("hacked");
  self endon("detonating");
  util::waittillnotmoving();
  self thread weaponobjectdetectiontrigger(ownerteam);
}

function weaponobjectdetectiontrigger(ownerteam) {
  trigger = spawn("trigger_radius", self.origin - vectorscale((0, 0, 1), 128), 0, 512, 256);
  trigger.detectid = ("trigger" + gettime()) + randomint(1000000);
  trigger sethintlowpriority(1);
  self util::waittill_any("death", "hacked", "detonating");
  trigger notify("end_detection");
  if(isdefined(trigger.bombsquadicon)) {
    trigger.bombsquadicon destroy();
  }
  trigger delete();
}

function hackertriggersetvisibility(owner) {
  self endon("death");
  assert(isplayer(owner));
  ownerteam = owner.pers["team"];
  for (;;) {
    if(level.teambased && isdefined(ownerteam)) {
      self setvisibletoallexceptteam(ownerteam);
      self setexcludeteamfortrigger(ownerteam);
    } else {
      self setvisibletoall();
      self setteamfortrigger("none");
    }
    if(isdefined(owner)) {
      self setinvisibletoplayer(owner);
    }
    level util::waittill_any("player_spawned", "joined_team");
  }
}

function hackernotmoving() {
  self endon("death");
  self util::waittillnotmoving();
  self notify("landed");
}

function hackerinit(watcher) {
  self thread hackernotmoving();
  event = self util::waittill_any_return("death", "landed");
  if(event == "death") {
    return;
  }
  triggerorigin = self.origin;
  if("" != self.weapon.hackertriggerorigintag) {
    triggerorigin = self gettagorigin(self.weapon.hackertriggerorigintag);
  }
  self.hackertrigger = spawn("trigger_radius_use", triggerorigin, level.weaponobjects_hacker_trigger_width, level.weaponobjects_hacker_trigger_height);
  self.hackertrigger sethintlowpriority(1);
  self.hackertrigger setcursorhint("HINT_NOICON", self);
  self.hackertrigger setignoreentfortrigger(self);
  self.hackertrigger enablelinkto();
  self.hackertrigger linkto(self);
  if(isdefined(level.hackerhints[self.weapon.name])) {
    self.hackertrigger sethintstring(level.hackerhints[self.weapon.name].hint);
  } else {
    self.hackertrigger sethintstring(&"MP_GENERIC_HACKING");
  }
  self.hackertrigger setperkfortrigger("specialty_disarmexplosive");
  self.hackertrigger thread hackertriggersetvisibility(self.owner);
  self thread hackerthink(self.hackertrigger, watcher);
}

function hackerthink(trigger, watcher) {
  self endon("death");
  for (;;) {
    trigger waittill("trigger", player, instant);
    if(!isdefined(instant) && !trigger hackerresult(player, self.owner)) {
      continue;
    }
    self itemhacked(watcher, player);
    return;
  }
}

function itemhacked(watcher, player) {
  self proximityalarmactivate(0, watcher);
  self.owner hackerremoveweapon(self);
  if(isdefined(level.playequipmenthackedonplayer)) {
    self.owner[[level.playequipmenthackedonplayer]]();
  }
  if(self.weapon.ammocountequipment > 0 && isdefined(self.ammo)) {
    ammoleftequipment = self.ammo;
    if(self.weapon.rootweapon == getweapon("trophy_system")) {
      player trophy_system::ammo_weapon_hacked(ammoleftequipment);
    }
  }
  self.hacked = 1;
  self setmissileowner(player);
  self setteam(player.pers["team"]);
  self.owner = player;
  self clientfield::set("retrievable", 0);
  if(self.weapon.dohackedstats) {
    scoreevents::processscoreevent("hacked", player);
    player addweaponstat(getweapon("pda_hack"), "CombatRecordStat", 1);
    player challenges::hackedordestroyedequipment();
  }
  if(self.weapon.rootweapon == level.weaponsatchelcharge && isdefined(player.lowermessage)) {
    player.lowermessage settext(&"PLATFORM_SATCHEL_CHARGE_DOUBLE_TAP");
    player.lowermessage.alpha = 1;
    player.lowermessage fadeovertime(2);
    player.lowermessage.alpha = 0;
  }
  self notify("hacked", player);
  level notify("hacked", self, player);
  if(isdefined(self.camerahead)) {
    self.camerahead notify("hacked", player);
  }
  wait(0.05);
  if(isdefined(player) && player.sessionstate == "playing") {
    player notify("grenade_fire", self, self.weapon, 1);
  } else {
    watcher thread waitanddetonate(self, 0, undefined, self.weapon);
  }
}

function hackerunfreezeplayer(player) {
  self endon("hack_done");
  self waittill("death");
  if(isdefined(player)) {
    player util::freeze_player_controls(0);
    player enableweapons();
  }
}

function hackerresult(player, owner) {
  success = 1;
  time = gettime();
  hacktime = getdvarfloat("perk_disarmExplosiveTime");
  if(!canhack(player, owner, 1)) {
    return 0;
  }
  self thread hackerunfreezeplayer(player);
  while ((time + (hacktime * 1000)) > gettime()) {
    if(!canhack(player, owner, 0)) {
      success = 0;
      break;
    }
    if(!player usebuttonpressed()) {
      success = 0;
      break;
    }
    if(!isdefined(self)) {
      success = 0;
      break;
    }
    player util::freeze_player_controls(1);
    player disableweapons();
    if(!isdefined(self.progressbar)) {
      self.progressbar = player hud::createprimaryprogressbar();
      self.progressbar.lastuserate = -1;
      self.progressbar hud::showelem();
      self.progressbar hud::updatebar(0.01, 1 / hacktime);
      self.progresstext = player hud::createprimaryprogressbartext();
      self.progresstext settext(&"MP_HACKING");
      self.progresstext hud::showelem();
      player playlocalsound("evt_hacker_hacking");
    }
    wait(0.05);
  }
  if(isdefined(player)) {
    player util::freeze_player_controls(0);
    player enableweapons();
  }
  if(isdefined(self.progressbar)) {
    self.progressbar hud::destroyelem();
    self.progresstext hud::destroyelem();
  }
  if(isdefined(self)) {
    self notify("hack_done");
  }
  return success;
}

function canhack(player, owner, weapon_check) {
  if(!isdefined(player)) {
    return false;
  }
  if(!isplayer(player)) {
    return false;
  }
  if(!isalive(player)) {
    return false;
  }
  if(!isdefined(owner)) {
    return false;
  }
  if(owner == player) {
    return false;
  }
  if(level.teambased && player.team == owner.team) {
    return false;
  }
  if(isdefined(player.isdefusing) && player.isdefusing) {
    return false;
  }
  if(isdefined(player.isplanting) && player.isplanting) {
    return false;
  }
  if(isdefined(player.proxbar) && !player.proxbar.hidden) {
    return false;
  }
  if(isdefined(player.revivingteammate) && player.revivingteammate == 1) {
    return false;
  }
  if(!player isonground()) {
    return false;
  }
  if(player isinvehicle()) {
    return false;
  }
  if(player isweaponviewonlylinked()) {
    return false;
  }
  if(!player hasperk("specialty_disarmexplosive")) {
    return false;
  }
  if(player isempjammed()) {
    return false;
  }
  if(isdefined(player.laststand) && player.laststand) {
    return false;
  }
  if(weapon_check) {
    if(player isthrowinggrenade()) {
      return false;
    }
    if(player isswitchingweapons()) {
      return false;
    }
    if(player ismeleeing()) {
      return false;
    }
    weapon = player getcurrentweapon();
    if(!isdefined(weapon)) {
      return false;
    }
    if(weapon == level.weaponnone) {
      return false;
    }
    if(weapon.isequipment && player isfiring()) {
      return false;
    }
    if(weapon.isspecificuse) {
      return false;
    }
  }
  return true;
}

function hackerremoveweapon(weapon_instance) {
  for (i = 0; i < self.weaponobjectwatcherarray.size; i++) {
    if(self.weaponobjectwatcherarray[i].weapon != weapon_instance.weapon.rootweapon) {
      continue;
    }
    removeweaponobject(self.weaponobjectwatcherarray[i], weapon_instance);
    return;
  }
}

function proximityweaponobject_createdamagearea(watcher) {
  damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - watcher.detonateradius), level.aitriggerspawnflags | level.vehicletriggerspawnflags, watcher.detonateradius, watcher.detonateradius * 2);
  damagearea enablelinkto();
  damagearea linkto(self);
  self thread deleteondeath(damagearea);
  return damagearea;
}

function proximityweaponobject_validtriggerentity(watcher, ent) {
  if(level.weaponobjectdebug != 1) {
    if(isdefined(self.owner) && ent == self.owner) {
      return false;
    }
    if(isvehicle(ent)) {
      if(watcher.ignorevehicles) {
        return false;
      }
      if(self.owner === ent.owner) {
        return false;
      }
    }
    if(!friendlyfirecheck(self.owner, ent, 0)) {
      return false;
    }
    if(watcher.ignorevehicles && isai(ent) && (!(isdefined(ent.isaiclone) && ent.isaiclone))) {
      return false;
    }
  }
  if(lengthsquared(ent getvelocity()) < 10 && !isdefined(watcher.immediatedetonation)) {
    return false;
  }
  if(!ent shouldaffectweaponobject(self, watcher)) {
    return false;
  }
  if(self isstunned()) {
    return false;
  }
  if(isplayer(ent)) {
    if(!isalive(ent)) {
      return false;
    }
    if(isdefined(watcher.immunespecialty) && ent hasperk(watcher.immunespecialty)) {
      return false;
    }
  }
  return true;
}

function proximityweaponobject_removespawnprotectondeath(ent) {
  self endon("death");
  ent util::waittill_any("death", "disconnected");
  arrayremovevalue(self.protected_entities, ent);
}

function proximityweaponobject_spawnprotect(watcher, ent) {
  self endon("death");
  ent endon("death");
  ent endon("disconnect");
  self.protected_entities[self.protected_entities.size] = ent;
  self thread proximityweaponobject_removespawnprotectondeath(ent);
  radius_sqr = watcher.detonateradius * watcher.detonateradius;
  while (true) {
    if(distancesquared(ent.origin, self.origin) > radius_sqr) {
      arrayremovevalue(self.protected_entities, ent);
      return;
    }
    wait(0.5);
  }
}

function proximityweaponobject_isspawnprotected(watcher, ent) {
  if(!isplayer(ent)) {
    return false;
  }
  foreach(protected_ent in self.protected_entities) {
    if(protected_ent == ent) {
      return true;
    }
  }
  linked_to = self getlinkedent();
  if(linked_to === ent) {
    return false;
  }
  if(ent player::is_spawn_protected()) {
    self thread proximityweaponobject_spawnprotect(watcher, ent);
    return true;
  }
  return false;
}

function proximityweaponobject_dodetonation(watcher, ent, traceorigin) {
  self endon("death");
  self endon("hacked");
  self notify("kill_target_detection");
  if(isdefined(watcher.activatesound)) {
    self playsound(watcher.activatesound);
  }
  wait(watcher.detectiongraceperiod);
  if(isplayer(ent) && ent hasperk("specialty_delayexplosive")) {
    wait(getdvarfloat("perk_delayExplosiveTime"));
  }
  self entityheadicons::setentityheadicon("none");
  self.origin = traceorigin;
  if(isdefined(self.owner) && isplayer(self.owner)) {
    self[[watcher.ondetonatecallback]](self.owner, undefined, ent);
  } else {
    self[[watcher.ondetonatecallback]](undefined, undefined, ent);
  }
}

function proximityweaponobject_activationdelay(watcher) {
  self util::waittillnotmoving();
  if(watcher.activationdelay) {
    wait(watcher.activationdelay);
  }
}

function proximityweaponobject_waittillframeendanddodetonation(watcher, ent, traceorigin) {
  self endon("death");
  dist = distance(ent.origin, self.origin);
  if(isdefined(self.activated_entity_distance)) {
    if(dist < self.activated_entity_distance) {
      self notify("better_target");
    } else {
      return;
    }
  }
  self endon("better_target");
  self.activated_entity_distance = dist;
  wait(0.05);
  proximityweaponobject_dodetonation(watcher, ent, traceorigin);
}

function proximityweaponobjectdetonation(watcher) {
  self endon("death");
  self endon("hacked");
  self endon("kill_target_detection");
  proximityweaponobject_activationdelay(watcher);
  damagearea = proximityweaponobject_createdamagearea(watcher);
  up = anglestoup(self.angles);
  traceorigin = self.origin + up;
  while (true) {
    damagearea waittill("trigger", ent);
    if(!proximityweaponobject_validtriggerentity(watcher, ent)) {
      continue;
    }
    if(proximityweaponobject_isspawnprotected(watcher, ent)) {
      continue;
    }
    if(ent damageconetrace(traceorigin, self) > 0) {
      thread proximityweaponobject_waittillframeendanddodetonation(watcher, ent, traceorigin);
    }
  }
}

function shouldaffectweaponobject(object, watcher) {
  radius = object.weapon.explosionradius;
  distancesqr = distancesquared(self.origin, object.origin);
  if((radius * radius) < distancesqr) {
    return 0;
  }
  pos = self.origin + vectorscale((0, 0, 1), 32);
  if(isdefined(watcher.ignoredirection)) {
    return 1;
  }
  dirtopos = pos - object.origin;
  objectforward = anglestoforward(object.angles);
  dist = vectordot(dirtopos, objectforward);
  if(dist < watcher.detectionmindist) {
    return 0;
  }
  dirtopos = vectornormalize(dirtopos);
  dot = vectordot(dirtopos, objectforward);
  return dot > watcher.detectiondot;
}

function deleteondeath(ent) {
  self util::waittill_any("death", "hacked");
  wait(0.05);
  if(isdefined(ent)) {
    ent delete();
  }
}

function testkillbrushonstationary(a_killbrushes, player) {
  player endon("disconnect");
  self endon("death");
  self waittill("stationary");
  foreach(trig in a_killbrushes) {
    if(isdefined(trig) && self istouching(trig)) {
      if(!trig istriggerenabled()) {
        continue;
      }
      if(isdefined(self.spawnflags) && (self.spawnflags & 2) == 2) {
        continue;
      }
      if(self.origin[2] > player.origin[2]) {
        break;
      }
      if(isdefined(self)) {
        self delete();
      }
      return;
    }
  }
}

function deleteonkillbrush(player) {
  player endon("disconnect");
  self endon("death");
  self endon("stationary");
  a_killbrushes = getentarray("trigger_hurt", "classname");
  self thread testkillbrushonstationary(a_killbrushes, player);
  while (true) {
    a_killbrushes = getentarray("trigger_hurt", "classname");
    for (i = 0; i < a_killbrushes.size; i++) {
      if(self istouching(a_killbrushes[i])) {
        if(!a_killbrushes[i] istriggerenabled()) {
          continue;
        }
        if(isdefined(self.spawnflags) && (self.spawnflags & 2) == 2) {
          continue;
        }
        if(self.origin[2] > player.origin[2]) {
          break;
        }
        if(isdefined(self)) {
          self delete();
        }
        return;
      }
    }
    wait(0.1);
  }
}

function watchweaponobjectaltdetonation() {
  self endon("disconnect");
  while (true) {
    self waittill("alt_detonate");
    if(!isalive(self) || self util::isusingremote()) {
      continue;
    }
    for (watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
      if(self.weaponobjectwatcherarray[watcher].altdetonate) {
        self.weaponobjectwatcherarray[watcher] detonateweaponobjectarray(0);
      }
    }
  }
}

function watchweaponobjectaltdetonate() {
  self endon("disconnect");
  level endon("game_ended");
  buttontime = 0;
  for (;;) {
    self waittill("doubletap_detonate");
    if(!isalive(self) && !self util::isusingremote()) {
      continue;
    }
    self notify("alt_detonate");
    wait(0.05);
  }
}

function watchweaponobjectdetonation() {
  self endon("disconnect");
  while (true) {
    self waittill("detonate");
    if(self isusingoffhand()) {
      weap = self getcurrentoffhand();
    } else {
      weap = self getcurrentweapon();
    }
    watcher = getweaponobjectwatcherbyweapon(weap);
    if(isdefined(watcher)) {
      if(isdefined(watcher.ondetonationhandle)) {
        self thread[[watcher.ondetonationhandle]](watcher);
      }
      watcher detonateweaponobjectarray(0);
    }
  }
}

function cleanupwatchers() {
  if(!isdefined(self.weaponobjectwatcherarray)) {
    assert("");
    return;
  }
  watchers = [];
  for (watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
    weaponobjectwatcher = spawnstruct();
    watchers[watchers.size] = weaponobjectwatcher;
    weaponobjectwatcher.objectarray = [];
    if(isdefined(self.weaponobjectwatcherarray[watcher].objectarray)) {
      weaponobjectwatcher.objectarray = self.weaponobjectwatcherarray[watcher].objectarray;
    }
  }
  wait(0.05);
  for (watcher = 0; watcher < watchers.size; watcher++) {
    watchers[watcher] deleteweaponobjectarray();
  }
}

function watchfordisconnectcleanup() {
  self waittill("disconnect");
  cleanupwatchers();
}

function deleteweaponobjectson() {
  self thread watchfordisconnectcleanup();
  self endon("disconnect");
  if(!isplayer(self)) {
    return;
  }
  while (true) {
    msg = self util::waittill_any_return("joined_team", "joined_spectators", "death", "disconnect");
    if(msg == "death") {
      continue;
    }
    cleanupwatchers();
  }
}

function saydamaged(orig, amount) {
  for (i = 0; i < 60; i++) {
    print3d(orig, "" + amount);
    wait(0.05);
  }
}

function showheadicon(trigger) {
  triggerdetectid = trigger.detectid;
  useid = -1;
  for (index = 0; index < 4; index++) {
    detectid = self.bombsquadicons[index].detectid;
    if(detectid == triggerdetectid) {
      return;
    }
    if(detectid == "") {
      useid = index;
    }
  }
  if(useid < 0) {
    return;
  }
  self.bombsquadids[triggerdetectid] = 1;
  self.bombsquadicons[useid].x = trigger.origin[0];
  self.bombsquadicons[useid].y = trigger.origin[1];
  self.bombsquadicons[useid].z = (trigger.origin[2] + 24) + 128;
  self.bombsquadicons[useid] fadeovertime(0.25);
  self.bombsquadicons[useid].alpha = 1;
  self.bombsquadicons[useid].detectid = trigger.detectid;
  while (isalive(self) && isdefined(trigger) && self istouching(trigger)) {
    wait(0.05);
  }
  if(!isdefined(self)) {
    return;
  }
  self.bombsquadicons[useid].detectid = "";
  self.bombsquadicons[useid] fadeovertime(0.25);
  self.bombsquadicons[useid].alpha = 0;
  self.bombsquadids[triggerdetectid] = undefined;
}

function friendlyfirecheck(owner, attacker, forcedfriendlyfirerule) {
  if(!isdefined(owner)) {
    return true;
  }
  if(!level.teambased) {
    return true;
  }
  friendlyfirerule = [[level.figure_out_friendly_fire]](undefined);
  if(isdefined(forcedfriendlyfirerule)) {
    friendlyfirerule = forcedfriendlyfirerule;
  }
  if(friendlyfirerule != 0) {
    return true;
  }
  if(attacker == owner) {
    return true;
  }
  if(isplayer(attacker)) {
    if(!isdefined(attacker.pers["team"])) {
      return true;
    }
    if(attacker.pers["team"] != owner.pers["team"]) {
      return true;
    }
  } else {
    if(isactor(attacker)) {
      if(attacker.team != owner.pers["team"]) {
        return true;
      }
    } else if(isvehicle(attacker)) {
      if(isdefined(attacker.owner) && isplayer(attacker.owner)) {
        if(attacker.owner.pers["team"] != owner.pers["team"]) {
          return true;
        }
      } else {
        occupant_team = attacker vehicle::vehicle_get_occupant_team();
        if(occupant_team != owner.pers["team"] && occupant_team != "spectator") {
          return true;
        }
      }
    }
  }
  return false;
}

function onspawnhatchet(watcher, player) {
  if(isdefined(level.playthrowhatchet)) {
    player[[level.playthrowhatchet]]();
  }
}

function onspawncrossbowbolt(watcher, player) {
  self.delete_on_death = 1;
  self thread onspawncrossbowbolt_internal(watcher, player);
}

function onspawncrossbowbolt_internal(watcher, player) {
  player endon("disconnect");
  self endon("death");
  wait(0.25);
  linkedent = self getlinkedent();
  if(!isdefined(linkedent) || !isvehicle(linkedent)) {
    self.takedamage = 0;
  } else {
    self.takedamage = 1;
    if(isvehicle(linkedent)) {
      self thread dieonentitydeath(linkedent, player);
    }
  }
}

function dieonentitydeath(entity, player) {
  player endon("disconnect");
  self endon("death");
  alreadydead = entity.dead === 1 || (isdefined(entity.health) && entity.health < 0);
  if(!alreadydead) {
    entity waittill("death");
  }
  self notify("death");
}

function onspawncrossbowboltimpact(s_watcher, e_player) {
  self.delete_on_death = 1;
  self thread onspawncrossbowboltimpact_internal(s_watcher, e_player);
}

function onspawncrossbowboltimpact_internal(s_watcher, e_player) {
  self endon("death");
  e_player endon("disconnect");
  self waittill("stationary");
  s_watcher thread waitandfizzleout(self, 0);
  foreach(n_index, e_object in s_watcher.objectarray) {
    if(self == e_object) {
      s_watcher.objectarray[n_index] = undefined;
    }
  }
  cleanweaponobjectarray(s_watcher);
}

function onspawnspecialcrossbowtrigger(watcher, player) {
  self endon("death");
  self setowner(player);
  self setteam(player.pers["team"]);
  self.owner = player;
  self.oldangles = self.angles;
  self util::waittillnotmoving();
  waittillframeend();
  if(player.pers["team"] == "spectator") {
    return;
  }
  triggerorigin = self.origin;
  triggerparentent = undefined;
  if(isdefined(self.stucktoplayer)) {
    if(isalive(self.stucktoplayer) || !isdefined(self.stucktoplayer.body)) {
      if(isalive(self.stucktoplayer)) {
        triggerparentent = self;
        self unlink();
        self.angles = self.oldangles;
        self launch(vectorscale((1, 1, 1), 5));
        self util::waittillnotmoving();
        waittillframeend();
      } else {
        triggerparentent = self.stucktoplayer;
      }
    } else {
      triggerparentent = self.stucktoplayer.body;
    }
  }
  if(isdefined(triggerparentent)) {
    triggerorigin = triggerparentent.origin + vectorscale((0, 0, 1), 10);
  }
  if(self.weapon.shownretrievable) {
    self clientfield::set("retrievable", 1);
  }
  self.hatchetpickuptrigger = spawn("trigger_radius", triggerorigin, 0, 50, 50);
  self.hatchetpickuptrigger enablelinkto();
  self.hatchetpickuptrigger linkto(self);
  if(isdefined(triggerparentent)) {
    self.hatchetpickuptrigger linkto(triggerparentent);
  }
  self thread watchspecialcrossbowtrigger(self.hatchetpickuptrigger, watcher.pickup, watcher.pickupsoundplayer, watcher.pickupsound);
  thread switch_team(self, watcher, player);
  self thread watchshutdown(player);
}

function watchspecialcrossbowtrigger(trigger, callback, playersoundonuse, npcsoundonuse) {
  self endon("delete");
  self endon("hacked");
  while (true) {
    trigger waittill("trigger", player);
    if(!isalive(player)) {
      continue;
    }
    if(isdefined(trigger.claimedby) && player != trigger.claimedby) {
      continue;
    }
    crossbow_weapon = player get_player_crossbow_weapon();
    if(!isdefined(crossbow_weapon)) {
      continue;
    }
    stock_ammo = player getweaponammostock(crossbow_weapon);
    if(stock_ammo >= crossbow_weapon.maxammo) {
      continue;
    }
    if(isdefined(playersoundonuse)) {
      player playlocalsound(playersoundonuse);
    }
    if(isdefined(npcsoundonuse)) {
      player playsound(npcsoundonuse);
    }
    self thread[[callback]](player, crossbow_weapon);
  }
}

function onspawnhatchettrigger(watcher, player) {
  self endon("death");
  self setowner(player);
  self setteam(player.pers["team"]);
  self.owner = player;
  self.oldangles = self.angles;
  self util::waittillnotmoving();
  waittillframeend();
  if(player.pers["team"] == "spectator") {
    return;
  }
  triggerorigin = self.origin;
  triggerparentent = undefined;
  if(isdefined(self.stucktoplayer)) {
    if(isalive(self.stucktoplayer) || !isdefined(self.stucktoplayer.body)) {
      if(isalive(self.stucktoplayer)) {
        triggerparentent = self;
        self unlink();
        self.angles = self.oldangles;
        self launch(vectorscale((1, 1, 1), 5));
        self util::waittillnotmoving();
        waittillframeend();
      } else {
        triggerparentent = self.stucktoplayer;
      }
    } else {
      triggerparentent = self.stucktoplayer.body;
    }
  }
  if(isdefined(triggerparentent)) {
    triggerorigin = triggerparentent.origin + vectorscale((0, 0, 1), 10);
  }
  if(self.weapon.shownretrievable) {
    self clientfield::set("retrievable", 1);
  }
  self.hatchetpickuptrigger = spawn("trigger_radius", triggerorigin, 0, 50, 50);
  self.hatchetpickuptrigger enablelinkto();
  self.hatchetpickuptrigger linkto(self);
  if(isdefined(triggerparentent)) {
    self.hatchetpickuptrigger linkto(triggerparentent);
  }
  self thread watchhatchettrigger(self.hatchetpickuptrigger, watcher.pickup, watcher.pickupsoundplayer, watcher.pickupsound);
  thread switch_team(self, watcher, player);
  self thread watchshutdown(player);
}

function watchhatchettrigger(trigger, callback, playersoundonuse, npcsoundonuse) {
  self endon("delete");
  self endon("hacked");
  while (true) {
    trigger waittill("trigger", player);
    if(!isalive(player)) {
      continue;
    }
    if(!player isonground() && !player isplayerswimming()) {
      continue;
    }
    if(isdefined(trigger.claimedby) && player != trigger.claimedby) {
      continue;
    }
    heldweapon = player get_held_weapon_match_or_root_match(self.weapon);
    if(!isdefined(heldweapon)) {
      continue;
    }
    maxammo = 0;
    if(heldweapon == player.grenadetypeprimary && isdefined(player.grenadetypeprimarycount) && player.grenadetypeprimarycount > 0) {
      maxammo = player.grenadetypeprimarycount;
    } else if(heldweapon == player.grenadetypesecondary && isdefined(player.grenadetypesecondarycount) && player.grenadetypesecondarycount > 0) {
      maxammo = player.grenadetypesecondarycount;
    }
    if(maxammo == 0) {
      continue;
    }
    clip_ammo = player getweaponammoclip(heldweapon);
    if(clip_ammo >= maxammo) {
      continue;
    }
    if(isdefined(playersoundonuse)) {
      player playlocalsound(playersoundonuse);
    }
    if(isdefined(npcsoundonuse)) {
      player playsound(npcsoundonuse);
    }
    self thread[[callback]](player);
  }
}

function get_held_weapon_match_or_root_match(weapon) {
  pweapons = self getweaponslist(1);
  foreach(pweapon in pweapons) {
    if(pweapon == weapon) {
      return pweapon;
    }
  }
  foreach(pweapon in pweapons) {
    if(pweapon.rootweapon == weapon.rootweapon) {
      return pweapon;
    }
  }
  return undefined;
}

function get_player_crossbow_weapon() {
  pweapons = self getweaponslist(1);
  crossbow = getweapon("special_crossbow");
  crossbow_dw = getweapon("special_crossbow_dw");
  foreach(pweapon in pweapons) {
    if(pweapon.rootweapon == crossbow || pweapon.rootweapon == crossbow_dw) {
      return pweapon;
    }
  }
  return undefined;
}

function onspawnretrievableweaponobject(watcher, player) {
  self endon("death");
  self endon("hacked");
  self setowner(player);
  self setteam(player.pers["team"]);
  self.owner = player;
  self.oldangles = self.angles;
  self util::waittillnotmoving();
  if(watcher.activationdelay) {
    wait(watcher.activationdelay);
  }
  waittillframeend();
  if(player.pers["team"] == "spectator") {
    return;
  }
  triggerorigin = self.origin;
  triggerparentent = undefined;
  if(isdefined(self.stucktoplayer)) {
    if(isalive(self.stucktoplayer) || !isdefined(self.stucktoplayer.body)) {
      triggerparentent = self.stucktoplayer;
    } else {
      triggerparentent = self.stucktoplayer.body;
    }
  }
  if(isdefined(triggerparentent)) {
    triggerorigin = triggerparentent.origin + vectorscale((0, 0, 1), 10);
  } else {
    up = anglestoup(self.angles);
    triggerorigin = self.origin + up;
  }
  if(!self util::ishacked()) {
    if(self.weapon.shownretrievable) {
      self clientfield::set("retrievable", 1);
    }
    self.pickuptrigger = spawn("trigger_radius_use", triggerorigin);
    self.pickuptrigger sethintlowpriority(1);
    self.pickuptrigger setcursorhint("HINT_NOICON", self);
    self.pickuptrigger enablelinkto();
    self.pickuptrigger linkto(self);
    self.pickuptrigger setinvisibletoall();
    self.pickuptrigger setvisibletoplayer(player);
    if(isdefined(level.retrievehints[watcher.name])) {
      self.pickuptrigger sethintstring(level.retrievehints[watcher.name].hint);
    } else {
      self.pickuptrigger sethintstring(&"MP_GENERIC_PICKUP");
    }
    self.pickuptrigger setteamfortrigger(player.pers["team"]);
    if(isdefined(triggerparentent)) {
      self.pickuptrigger linkto(triggerparentent);
    }
    self thread watchusetrigger(self.pickuptrigger, watcher.pickup, watcher.pickupsoundplayer, watcher.pickupsound);
    if(isdefined(watcher.pickup_trigger_listener)) {
      self thread[[watcher.pickup_trigger_listener]](self.pickuptrigger, player);
    }
  }
  if(watcher.enemydestroy) {
    self.enemytrigger = spawn("trigger_radius_use", triggerorigin);
    self.enemytrigger setcursorhint("HINT_NOICON", self);
    self.enemytrigger enablelinkto();
    self.enemytrigger linkto(self);
    self.enemytrigger setinvisibletoplayer(player);
    if(level.teambased) {
      self.enemytrigger setexcludeteamfortrigger(player.team);
      self.enemytrigger.triggerteamignore = self.team;
    }
    if(isdefined(level.destroyhints[watcher.name])) {
      self.enemytrigger sethintstring(level.destroyhints[watcher.name].hint);
    } else {
      self.enemytrigger sethintstring(&"MP_GENERIC_DESTROY");
    }
    self thread watchusetrigger(self.enemytrigger, watcher.ondestroyed);
  }
  thread switch_team(self, watcher, player);
  self thread watchshutdown(player);
}

function destroyent() {
  self delete();
}

function pickup(player) {
  if(!self.weapon.anyplayercanretrieve && isdefined(self.owner) && self.owner != player) {
    return;
  }
  pikedweapon = self.weapon;
  if(self.weapon.ammocountequipment > 0 && isdefined(self.ammo)) {
    ammoleftequipment = self.ammo;
  }
  self notify("picked_up");
  self.playdialog = 0;
  self destroyent();
  heldweapon = player get_held_weapon_match_or_root_match(self.weapon);
  if(!isdefined(heldweapon)) {
    return;
  }
  maxammo = 0;
  if(heldweapon == player.grenadetypeprimary && isdefined(player.grenadetypeprimarycount) && player.grenadetypeprimarycount > 0) {
    maxammo = player.grenadetypeprimarycount;
  } else if(heldweapon == player.grenadetypesecondary && isdefined(player.grenadetypesecondarycount) && player.grenadetypesecondarycount > 0) {
    maxammo = player.grenadetypesecondarycount;
  }
  if(maxammo == 0) {
    return;
  }
  clip_ammo = player getweaponammoclip(heldweapon);
  if(clip_ammo < maxammo) {
    clip_ammo++;
  }
  if(isdefined(ammoleftequipment)) {
    if(pikedweapon.rootweapon == getweapon("trophy_system")) {
      player trophy_system::ammo_weapon_pickup(ammoleftequipment);
    }
  }
  player setweaponammoclip(heldweapon, clip_ammo);
}

function pickupcrossbowbolt(player, heldweapon) {
  self notify("picked_up");
  self.playdialog = 0;
  self destroyent();
  stock_ammo = player getweaponammostock(heldweapon);
  stock_ammo++;
  player setweaponammostock(heldweapon, stock_ammo);
}

function ondestroyed(attacker) {
  playfx(level._effect["tacticalInsertionFizzle"], self.origin);
  self playsound("dst_tac_insert_break");
  if(isdefined(level.playequipmentdestroyedonplayer)) {
    self.owner[[level.playequipmentdestroyedonplayer]]();
  }
  self delete();
}

function watchshutdown(player) {
  self util::waittill_any("death", "hacked", "detonating");
  pickuptrigger = self.pickuptrigger;
  hackertrigger = self.hackertrigger;
  hatchetpickuptrigger = self.hatchetpickuptrigger;
  enemytrigger = self.enemytrigger;
  if(isdefined(pickuptrigger)) {
    pickuptrigger delete();
  }
  if(isdefined(hackertrigger)) {
    if(isdefined(hackertrigger.progressbar)) {
      hackertrigger.progressbar hud::destroyelem();
      hackertrigger.progresstext hud::destroyelem();
    }
    hackertrigger delete();
  }
  if(isdefined(hatchetpickuptrigger)) {
    hatchetpickuptrigger delete();
  }
  if(isdefined(enemytrigger)) {
    enemytrigger delete();
  }
}

function watchusetrigger(trigger, callback, playersoundonuse, npcsoundonuse) {
  self endon("delete");
  self endon("hacked");
  while (true) {
    trigger waittill("trigger", player);
    if(isdefined(self.detonated) && self.detonated == 1) {
      if(isdefined(trigger)) {
        trigger delete();
      }
      return;
    }
    if(!isalive(player)) {
      continue;
    }
    if(isdefined(trigger.triggerteam) && player.pers["team"] != trigger.triggerteam) {
      continue;
    }
    if(isdefined(trigger.triggerteamignore) && player.team == trigger.triggerteamignore) {
      continue;
    }
    if(isdefined(trigger.claimedby) && player != trigger.claimedby) {
      continue;
    }
    grenade = player.throwinggrenade;
    weapon = player getcurrentweapon();
    if(weapon.isequipment) {
      grenade = 0;
    }
    if(player usebuttonpressed() && !grenade && !player meleebuttonpressed()) {
      if(isdefined(playersoundonuse)) {
        player playlocalsound(playersoundonuse);
      }
      if(isdefined(npcsoundonuse)) {
        player playsound(npcsoundonuse);
      }
      self thread[[callback]](player);
    }
  }
}

function createretrievablehint(name, hint) {
  retrievehint = spawnstruct();
  retrievehint.name = name;
  retrievehint.hint = hint;
  level.retrievehints[name] = retrievehint;
}

function createhackerhint(name, hint) {
  hackerhint = spawnstruct();
  hackerhint.name = name;
  hackerhint.hint = hint;
  level.hackerhints[name] = hackerhint;
}

function createdestroyhint(name, hint) {
  destroyhint = spawnstruct();
  destroyhint.name = name;
  destroyhint.hint = hint;
  level.destroyhints[name] = destroyhint;
}

function setupreconeffect() {
  if(!isdefined(self)) {
    return;
  }
  if(self.weapon.shownenemyexplo || self.weapon.shownenemyequip) {
    if(isdefined(self.hacked) && self.hacked) {
      self clientfield::set("enemyequip", 2);
    } else {
      self clientfield::set("enemyequip", 1);
    }
  }
}

function useteamequipmentclientfield(watcher) {
  if(isdefined(watcher)) {
    if(!isdefined(watcher.notequipment)) {
      if(isdefined(self)) {
        return true;
      }
    }
  }
  return false;
}

function getwatcherforweapon(weapon) {
  if(!isdefined(self)) {
    return undefined;
  }
  if(!isplayer(self)) {
    return undefined;
  }
  for (i = 0; i < self.weaponobjectwatcherarray.size; i++) {
    if(self.weaponobjectwatcherarray[i].weapon != weapon) {
      continue;
    }
    return self.weaponobjectwatcherarray[i];
  }
  return undefined;
}

function destroy_other_teams_supplemental_watcher_objects(attacker, weapon) {
  if(level.teambased) {
    foreach(team in level.teams) {
      if(team == attacker.team) {
        continue;
      }
      destroy_supplemental_watcher_objects(attacker, team, weapon);
    }
  }
  destroy_supplemental_watcher_objects(attacker, "free", weapon);
}

function destroy_supplemental_watcher_objects(attacker, team, weapon) {
  foreach(item in level.supplementalwatcherobjects) {
    if(!isdefined(item.weapon)) {
      continue;
    }
    if(!isdefined(item.owner)) {
      continue;
    }
    if(isdefined(team) && item.owner.team != team) {
      continue;
    } else if(item.owner == attacker) {
      continue;
    }
    watcher = item.owner getwatcherforweapon(item.weapon);
    if(!isdefined(watcher) || !isdefined(watcher.onsupplementaldetonatecallback)) {
      continue;
    }
    item thread[[watcher.onsupplementaldetonatecallback]]();
  }
}

function add_supplemental_object(object) {
  level.supplementalwatcherobjects[level.supplementalwatcherobjects.size] = object;
  object thread watch_supplemental_object_death();
}

function watch_supplemental_object_death() {
  self waittill("death");
  arrayremovevalue(level.supplementalwatcherobjects, self);
}

function switch_team(entity, watcher, owner) {
  self notify("stop_disarmthink");
  self endon("stop_disarmthink");
  self endon("death");
  setdvar("", "");
  while (true) {
    wait(0.5);
    devgui_int = getdvarint("");
    if(devgui_int != 0) {
      team = "";
      if(isdefined(level.getenemyteam) && isdefined(owner) && isdefined(owner.team)) {
        team = [
          [level.getenemyteam]
        ](owner.team);
      }
      if(isdefined(level.devongetormakebot)) {
        player = [
          [level.devongetormakebot]
        ](team);
      }
      if(!isdefined(player)) {
        println("");
        wait(1);
        continue;
      }
      entity itemhacked(watcher, player);
      setdvar("", "");
    }
  }
}