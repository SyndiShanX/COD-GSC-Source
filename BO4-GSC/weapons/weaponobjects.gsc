/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\weaponobjects.gsc
***********************************************/

#include script_6b221588ece2c4aa;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\damage;
#include scripts\core_common\damagefeedback_shared;
#include scripts\core_common\dev_shared;
#include scripts\core_common\entityheadicons_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\placeables;
#include scripts\core_common\player\player_loadout;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\weapons_shared;
#include scripts\weapons\trophy_system;

#namespace weaponobjects;

init_shared() {
  callback::on_start_gametype(&start_gametype);
  clientfield::register("toplayer", "proximity_alarm", 1, 3, "int");
  clientfield::register("clientuimodel", "hudItems.proximityAlarm", 1, 3, "int");
  clientfield::register("missile", "retrievable", 1, 1, "int");
  clientfield::register("scriptmover", "retrievable", 1, 1, "int");
  clientfield::register("missile", "enemyequip", 1, 2, "int");
  clientfield::register("scriptmover", "enemyequip", 1, 2, "int");
  clientfield::register("missile", "teamequip", 1, 1, "int");
  clientfield::register("missile", "friendlyequip", 1, 1, "int");
  clientfield::register("scriptmover", "friendlyequip", 1, 1, "int");
  level.weaponobjectdebug = getdvarint(#"scr_weaponobject_debug", 0);
  level.supplementalwatcherobjects = [];

  level thread updatedvars();

}

updatedvars() {
  while(true) {
    level.weaponobjectdebug = getdvarint(#"scr_weaponobject_debug", 0);
    wait 1;
  }
}

start_gametype() {
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  callback::on_disconnect(&function_ac7c2bf9);
  callback::on_joined_team(&function_ac7c2bf9);
  callback::on_joined_spectate(&function_ac7c2bf9);

  if(!isDefined(level.retrievableweapons)) {
    level.retrievableweapons = [];
  }

  retrievables = getretrievableweapons();

  foreach(weapon in retrievables) {
    weaponstruct = spawnStruct();
    level.retrievableweapons[weapon.name] = weaponstruct;
  }

  level.weaponobjectexplodethisframe = 0;

  if(getdvarstring(#"scr_deleteexplosivesonspawn") == "") {
    setdvar(#"scr_deleteexplosivesonspawn", 1);
  }

  level.deleteexplosivesonspawn = getdvarint(#"scr_deleteexplosivesonspawn", 0);
  level._equipment_spark_fx = #"explosions/fx8_exp_equipment_lg";
  level._equipment_fizzleout_fx = #"explosions/fx8_exp_equipment_lg";
  level._equipment_emp_destroy_fx = #"killstreaks/fx_emp_explosion_equip";
  level._equipment_explode_fx = #"_t6/explosions/fx_exp_equipment";
  level._equipment_explode_fx_lg = #"explosions/fx8_exp_equipment_lg";
  level.weaponobjects_hacker_trigger_width = 32;
  level.weaponobjects_hacker_trigger_height = 32;
  function_db765b94();
  function_b455d5d8();
}

on_player_connect() {
  if(isDefined(level._weaponobjects_on_player_connect_override)) {
    level thread[[level._weaponobjects_on_player_connect_override]]();
    return;
  }

  self.usedweapons = 0;
  self.hits = 0;
  self.headshothits = 0;
}

on_player_spawned() {
  self endon(#"disconnect");
  pixbeginevent(#"onplayerspawned");

  if(!isDefined(self.weaponobjectwatcherarray)) {
    self.weaponobjectwatcherarray = [];
  }

  self thread watchweaponobjectspawn();
  self callback::on_detonate(&on_detonate);
  self callback::on_double_tap_detonate(&on_double_tap_detonate);
  self trophy_system::ammo_reset();
  pixendevent();
}

function_e6400478(name, func, var_8411d55d) {
  if(!isDefined(level.watcherregisters)) {
    level.watcherregisters = [];
  }

  if(isDefined(name)) {
    struct = level.watcherregisters[name];

    if(isDefined(struct)) {
      if(isDefined(var_8411d55d) && var_8411d55d != 2) {
        struct.func = func;
        struct.var_8411d55d = var_8411d55d;
        level.watcherregisters[name] = struct;
      }

      return;
    }

    struct = spawnStruct();
    struct.func = func;
    struct.type = var_8411d55d;
    level.watcherregisters[name] = struct;
  }
}

function_dcc8b5d5(name, var_80e51919, var_7bd83b52) {
  struct = level.watcherregisters[name];

  if(!isDefined(struct)) {
    return;
  }

  struct.var_80e51919 = var_80e51919;
  struct.var_7bd83b52 = var_7bd83b52;
}

event_handler[player_loadoutchanged] loadout_changed(eventstruct) {
  switch (eventstruct.event) {
    case #"give_weapon":
    case #"give_weapon_dual":
      weapon = eventstruct.weapon;
      self snipinterfaceattributes(weapon);
      break;
  }
}

private snipinterfaceattributes(weapon) {
  if(isDefined(level.watcherregisters)) {
    struct = level.watcherregisters[weapon.name];

    if(isDefined(struct)) {
      self createwatcher(weapon.name, struct.func, struct.type);

      if(isDefined(struct.var_80e51919) && isDefined(struct.var_7bd83b52)) {
        if(weaponhasattachment(weapon, struct.var_80e51919)) {
          other_weapon = getweapon(struct.var_7bd83b52);

          if(isDefined(other_weapon) && other_weapon != level.weaponnone) {
            self snipinterfaceattributes(other_weapon);
          }
        }
      }
    }

    if(weapon.ischargeshot && weapon.nextchargelevelweapon != level.weaponnone) {
      self snipinterfaceattributes(weapon.nextchargelevelweapon);
    }
  }
}

createwatcher(weaponname, createfunc, var_7b2908f = 2) {
  watcher = undefined;

  switch (var_7b2908f) {
    case 0:
      watcher = self createproximityweaponobjectwatcher(weaponname, self.team);
      break;
    case 1:
      watcher = self createuseweaponobjectwatcher(weaponname, self.team);
      break;
    default:
      watcher = self createweaponobjectwatcher(weaponname, self.team);
      break;
  }

  if(isDefined(createfunc)) {
    self[[createfunc]](watcher);
  }

  retrievable = level.retrievableweapons[weaponname];

  if(isDefined(retrievable)) {
    setupretrievablewatcher(watcher);
  }

  return watcher;
}

private function_db765b94() {
  watcherweapons = getwatcherweapons();

  foreach(weapon in watcherweapons) {
    function_e6400478(weapon.name);
  }

  foreach(name, struct in level.retrievableweapons) {
    function_e6400478(name);
  }
}

private setupretrievablewatcher(watcher) {
  if(!isDefined(watcher.onspawnretrievetriggers)) {
    watcher.onspawnretrievetriggers = &function_23b0aea9;
  }

  if(!isDefined(watcher.ondestroyed)) {
    watcher.ondestroyed = &ondestroyed;
  }

  if(!isDefined(watcher.pickup)) {
    watcher.pickup = &function_db70257;
  }
}

function_db70257(player, heldweapon) {
  if(heldweapon.var_7d4c12af == "Automatic") {
    return function_d9219ce2(player, heldweapon);
  }

  return function_a6616b9c(player, heldweapon);
}

voidonspawn(unused0, unused1) {}

voidondamage(unused0) {}

voidonspawnretrievetriggers(unused0, unused1) {}

voidpickup(unused0, unused1) {}

deleteent(attacker, emp, target) {
  self delete();
}

clearfxondeath(fx) {
  fx endon(#"death");
  self waittill(#"death", #"hacked");
  fx delete();
}

deleteweaponobjectinstance() {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.minemover)) {
    if(isDefined(self.minemover.killcament)) {
      self.minemover.killcament delete();
    }

    self.minemover delete();
  }

  self delete();
}

deleteweaponobjectarray() {
  if(isDefined(self.objectarray)) {
    foreach(weaponobject in self.objectarray) {
      weaponobject deleteweaponobjectinstance();
    }
  }

  self.objectarray = [];
}

weapondetonate(attacker, weapon) {
  if(isDefined(weapon) && weapon.isemp) {
    self delete();
    return;
  }

  if(isDefined(attacker)) {
    if(isDefined(self.owner) && attacker != self.owner) {
      self.playdialog = 1;
    }

    if(isplayer(attacker)) {
      self detonate(attacker);
    } else {
      self detonate();
    }
  } else if(isDefined(self.owner) && isplayer(self.owner)) {
    self.playdialog = 0;
    self detonate(self.owner);
  } else {
    self detonate();
  }

  if(isDefined(self.owner) && isplayer(self.owner)) {
    self setstate(4);
  }
}

detonatewhenstationary(object, delay, attacker, weapon) {
  level endon(#"game_ended");
  object endon(#"death", #"hacked", #"detonating");

  if(object isonground() == 0) {
    object waittill(#"stationary");
  }

  self thread waitanddetonate(object, delay, attacker, weapon);
}

waitanddetonate(object, delay, attacker, weapon) {
  object endon(#"death", #"hacked");

  if(!isDefined(attacker) && !isDefined(weapon) && object.weapon.proximityalarmactivationdelay > 0) {
    if(isDefined(object.armed_detonation_wait) && object.armed_detonation_wait) {
      return;
    }

    object.armed_detonation_wait = 1;

    while(!(isDefined(object.proximity_deployed) && object.proximity_deployed)) {
      waitframe(1);
    }
  }

  if(isDefined(object.detonated) && object.detonated) {
    return;
  }

  object.detonated = 1;
  object notify(#"detonating");
  isempdetonated = isDefined(weapon) && weapon.isemp;

  if(isempdetonated && object.weapon.doempdestroyfx) {
    object.stun_fx = 1;
    randangle = randomfloat(360);
    playFX(level._equipment_emp_destroy_fx, object.origin + (0, 0, 5), (cos(randangle), sin(randangle), 0), anglestoup(object.angles));
    empfxdelay = 1.1;
  }

  if(isDefined(object.var_cea6a2fb)) {
    object.var_cea6a2fb placeables::forceshutdown();
  }

  if(!isDefined(self.ondetonatecallback)) {
    return;
  }

  if(!isempdetonated && !isDefined(weapon)) {
    if(isDefined(self.detonationdelay) && self.detonationdelay > 0) {
      if(isDefined(self.detonationsound)) {
        object playSound(self.detonationsound);
      }

      delay = self.detonationdelay;
    }
  } else if(isDefined(empfxdelay)) {
    delay = empfxdelay;
  }

  if(delay > 0) {
    wait delay;
  }

  if(isDefined(attacker) && isplayer(attacker) && isDefined(attacker.pers[#"team"]) && isDefined(object.owner) && isDefined(object.owner.pers) && isDefined(object.owner.pers[#"team"])) {
    if(level.teambased) {
      if(util::function_fbce7263(attacker.pers[#"team"], object.owner.pers[#"team"])) {
        attacker notify(#"destroyed_explosive");
      }
    } else if(attacker != object.owner) {
      attacker notify(#"destroyed_explosive");
    }
  }

  object[[self.ondetonatecallback]](attacker, weapon, undefined);
}

waitandfizzleout(object, delay) {
  object endon(#"death", #"hacked");

  if(isDefined(object.detonated) && object.detonated == 1) {
    return;
  }

  object.detonated = 1;
  object notify(#"fizzleout");

  if(delay > 0) {
    wait delay;
  }

  if(isDefined(object.var_cea6a2fb)) {
    object.var_cea6a2fb placeables::forceshutdown();
  }

  if(!isDefined(self.onfizzleout)) {
    object deleteent();
    return;
  }

  object[[self.onfizzleout]]();
}

detonateweaponobjectarray(forcedetonation, weapon) {
  undetonated = [];

  if(isDefined(self.objectarray)) {
    for(i = 0; i < self.objectarray.size; i++) {
      if(isDefined(self.objectarray[i])) {
        if(self.objectarray[i] isstunned() && forcedetonation == 0) {
          undetonated[undetonated.size] = self.objectarray[i];
          continue;
        }

        if(isDefined(weapon)) {
          if(weapon util::ishacked() && weapon.name != self.objectarray[i].weapon.name) {
            undetonated[undetonated.size] = self.objectarray[i];
            continue;
          } else if(self.objectarray[i] util::ishacked() && weapon.name != self.objectarray[i].weapon.name) {
            undetonated[undetonated.size] = self.objectarray[i];
            continue;
          }
        }

        if(isDefined(self.detonatestationary) && self.detonatestationary && forcedetonation == 0) {
          self thread detonatewhenstationary(self.objectarray[i], 0, undefined, weapon);
          continue;
        }

        self thread waitanddetonate(self.objectarray[i], 0, undefined, weapon);
      }
    }
  }

  self.objectarray = undetonated;
}

addweaponobjecttowatcher(watchername, weapon_instance) {
  watcher = getweaponobjectwatcher(watchername);
  assert(isDefined(watcher), "<dev string:x38>" + watchername + "<dev string:x51>");
  self addweaponobject(watcher, weapon_instance);
}

addweaponobject(watcher, weapon_instance, weapon, endonnotify) {
  if(!isDefined(weapon_instance)) {
    return;
  }

  if(!isDefined(watcher.storedifferentobject)) {
    watcher.objectarray[watcher.objectarray.size] = weapon_instance;
  }

  if(!isDefined(weapon)) {
    weapon = watcher.weapon;
  }

  weapon_instance.owner = self;
  weapon_instance.detonated = 0;
  weapon_instance.weapon = weapon;

  if(isDefined(watcher.ondamage)) {
    weapon_instance thread[[watcher.ondamage]](watcher);
  } else {
    weapon_instance thread weaponobjectdamage(watcher);
  }

  weapon_instance.ownergetsassist = watcher.ownergetsassist;
  weapon_instance.destroyedbyemp = watcher.destroyedbyemp;

  if(isDefined(watcher.onspawn)) {
    weapon_instance thread[[watcher.onspawn]](watcher, self);
  }

  if(isDefined(watcher.onspawnfx)) {
    weapon_instance thread[[watcher.onspawnfx]]();
  }

  weapon_instance thread setupreconeffect();

  if(isDefined(watcher.onspawnretrievetriggers)) {
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
    if(isDefined(level.deleteonkillbrushoverride)) {
      weapon_instance thread[[level.deleteonkillbrushoverride]](self, watcher);
    } else {
      weapon_instance thread deleteonkillbrush(self);
    }
  }

  if(weapon_instance useteamequipmentclientfield(watcher)) {
    weapon_instance clientfield::set("teamequip", 1);
  }

  if(watcher.timeout) {
    weapon_instance thread weapon_object_timeout(watcher, undefined);
  }

  if(isDefined(watcher.var_994b472b)) {
    weapon_instance thread function_6d8aa6a0(self, watcher);
  }

  weapon_instance thread delete_on_notify(self, endonnotify);
  weapon_instance thread cleanupwatcherondeath(watcher);
  weapon_instance thread function_b9ade2b();
}

function_6d8aa6a0(player, watcher) {
  self endon(#"death", #"hacked");
  player waittill(#"joined_team", #"joined_spectators", #"disconnect", #"changed_specialist", #"changed_specialist_death");
  self[[watcher.var_994b472b]](player);
}

function_b9ade2b() {
  weapon_instance = self;
  weapon_instance endon(#"death");
  weapon_instance waittill(#"picked_up");
  weapon_instance.playdialog = 0;
  weapon_instance destroyent();
}

cleanupwatcherondeath(watcher) {
  weapon_instance = self;
  weapon_instance waittill(#"death");

  if(isDefined(watcher) && isDefined(watcher.objectarray)) {
    removeweaponobject(watcher, weapon_instance);
  }

  if(isDefined(weapon_instance) && weapon_instance.delete_on_death === 1) {
    weapon_instance deleteweaponobjectinstance();
  }
}

weapon_object_timeout(watcher, timeoutoverride) {
  weapon_instance = self;
  weapon_instance endon(#"death", #"cancel_timeout");
  timeoutval = isDefined(timeoutoverride) ? timeoutoverride : watcher.timeout;
  wait timeoutval;

  if(isDefined(watcher) && isDefined(watcher.ontimeout)) {
    weapon_instance thread[[watcher.ontimeout]]();
    return;
  }

  weapon_instance deleteent();
}

delete_on_notify(e_player, endonnotify = undefined) {
  weapon_instance = self;

  if(isDefined(endonnotify)) {
    e_player endon(endonnotify);
  }

  e_player endon(#"disconnect");

  if(isai(e_player)) {
    e_player endon(#"death");
  }

  weapon_instance endon(#"death");
  e_player waittill(#"delete_weapon_objects");
  weapon_instance delete();
}

removeweaponobject(watcher, weapon_instance) {
  watcher.objectarray = array::remove_undefined(watcher.objectarray);
  arrayremovevalue(watcher.objectarray, weapon_instance);
}

cleanweaponobjectarray(watcher) {
  watcher.objectarray = array::remove_undefined(watcher.objectarray);
}

weapon_object_do_damagefeedback(weapon, attacker) {
  if(isDefined(weapon) && isDefined(attacker)) {
    if(damage::friendlyfirecheck(self.owner, attacker)) {
      if(damagefeedback::dodamagefeedback(weapon, attacker)) {
        attacker damagefeedback::update();
      }
    }
  }
}

weaponobjectdamage(watcher) {
  self endon(#"death", #"hacked", #"detonating");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self.damagetaken = 0;
  attacker = undefined;

  while(true) {
    waitresult = self waittill(#"damage");
    attacker = waitresult.attacker;
    weapon = waitresult.weapon;
    damage = waitresult.amount;
    type = waitresult.mod;
    idflags = waitresult.flags;
    damage = weapons::function_74bbb3fa(damage, weapon, self.weapon);
    self.damagetaken += damage;

    if(!isplayer(attacker) && isDefined(attacker.owner)) {
      attacker = attacker.owner;
    }

    if(isDefined(weapon)) {
      self weapon_object_do_damagefeedback(weapon, attacker);

      if(watcher.stuntime > 0 && weapon.dostun) {
        self thread stunstart(watcher, watcher.stuntime);
        continue;
      }
    }

    if(!level.weaponobjectdebug && level.teambased && isplayer(attacker) && isDefined(self.owner)) {
      if(!level.hardcoremode && !util::function_fbce7263(self.owner.team, attacker.pers[#"team"]) && self.owner != attacker) {
        continue;
      }
    }

    if(isDefined(watcher.isfataldamage) && !self[[watcher.isfataldamage]](watcher, attacker, weapon, damage)) {
      continue;
    }

    if(!isvehicle(self) && !damage::friendlyfirecheck(self.owner, attacker)) {
      continue;
    }

    break;
  }

  if(level.weaponobjectexplodethisframe) {
    wait 0.1 + randomfloat(0.4);
  } else {
    waitframe(1);
  }

  if(!isDefined(self)) {
    return;
  }

  level.weaponobjectexplodethisframe = 1;
  thread resetweaponobjectexplodethisframe();
  self entityheadicons::setentityheadicon("none");

  if(isDefined(type) && (issubstr(type, "MOD_GRENADE_SPLASH") || issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(idflags) && idflags&8) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  self.wasdamaged = 1;
  watcher thread waitanddetonate(self, 0, attacker, weapon);
}

playdialogondeath(owner) {
  owner endon(#"death");
  self endon(#"hacked");
  self waittill(#"death");

  if(isDefined(self.playdialog) && self.playdialog) {
    if(isDefined(owner) && isDefined(level.playequipmentdestroyedonplayer)) {
      owner[[level.playequipmentdestroyedonplayer]]();
    }
  }
}

watchobjectdamage(owner) {
  owner endon(#"death");
  self endon(#"hacked", #"death");

  while(true) {
    waitresult = self waittill(#"damage");

    if(isDefined(waitresult.attacker) && isplayer(waitresult.attacker) && waitresult.attacker != owner) {
      self.playdialog = 1;
      continue;
    }

    self.playdialog = 0;
  }
}

stunstart(watcher, time) {
  self endon(#"death");

  if(self isstunned()) {
    return;
  }

  if(isDefined(self.camerahead)) {}

  if(isDefined(watcher.onstun)) {
    self thread[[watcher.onstun]]();
  }

  if(watcher.name == "rcbomb") {
    self.owner val::set(#"weaponobjects", "freezecontrols", 1);
  }

  if(isDefined(time)) {
    wait time;
  } else {
    return;
  }

  if(watcher.name == "rcbomb") {
    self.owner val::reset(#"weaponobjects", "freezecontrols");
  }

  self stunstop();
}

stunstop() {
  self notify(#"not_stunned");

  if(isDefined(self.camerahead)) {}
}

weaponstun() {
  self endon(#"death", #"not_stunned");
  origin = self gettagorigin("tag_fx");

  if(!isDefined(origin)) {
    origin = self.origin + (0, 0, 10);
  }

  self.stun_fx = spawn("script_model", origin);
  self.stun_fx setModel(#"tag_origin");
  self thread stunfxthink(self.stun_fx);
  wait 0.1;
  playFXOnTag(level._equipment_spark_fx, self.stun_fx, "tag_origin");
}

stunfxthink(fx) {
  fx endon(#"death");
  self waittill(#"death", #"not_stunned");
  fx delete();
}

isstunned() {
  return isDefined(self.stun_fx);
}

weaponobjectfizzleout() {
  self endon(#"death");
  playFX(level._equipment_fizzleout_fx, self.origin);
  deleteent();
}

function_f245df1e() {
  self endon(#"death");
  randangle = randomfloat(360);
  playFX(level._equipment_emp_destroy_fx, self.origin + (0, 0, 5), (cos(randangle), sin(randangle), 0), anglestoup(self.angles));
  wait 1.1;
  deleteent();
}

function_127fb8f3(var_983dc34, attackingplayer) {
  if(isDefined(var_983dc34) && isDefined(var_983dc34.var_2d045452)) {
    var_983dc34.var_2d045452 thread waitanddetonate(var_983dc34, 0.05, attackingplayer, getweapon(#"eq_emp_grenade"));
    return;
  }

  var_983dc34 function_f245df1e();
}

resetweaponobjectexplodethisframe() {
  waitframe(1);
  level.weaponobjectexplodethisframe = 0;
}

getweaponobjectwatcher(name) {
  if(!isDefined(self.weaponobjectwatcherarray) || !isDefined(name)) {
    return undefined;
  }

  for(watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
    if(self.weaponobjectwatcherarray[watcher].name == name || isDefined(self.weaponobjectwatcherarray[watcher].altname) && self.weaponobjectwatcherarray[watcher].altname == name) {
      return self.weaponobjectwatcherarray[watcher];
    }
  }

  return undefined;
}

getweaponobjectwatcherbyweapon(weapon) {
  if(!isDefined(self.weaponobjectwatcherarray)) {
    return undefined;
  }

  for(watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
    if(isDefined(self.weaponobjectwatcherarray[watcher].weapon)) {
      if(self.weaponobjectwatcherarray[watcher].weapon == weapon || self.weaponobjectwatcherarray[watcher].weapon == weapon.rootweapon) {
        return self.weaponobjectwatcherarray[watcher];
      }

      if(isDefined(self.weaponobjectwatcherarray[watcher].altweapon) && self.weaponobjectwatcherarray[watcher].altweapon == weapon) {
        return self.weaponobjectwatcherarray[watcher];
      }
    }
  }

  return undefined;
}

resetweaponobjectwatcher(watcher, ownerteam) {
  if(watcher.deleteonplayerspawn == 1 || isDefined(watcher.ownerteam) && watcher.ownerteam != ownerteam) {
    self notify(#"weapon_object_destroyed");
    watcher deleteweaponobjectarray();
  }

  watcher.ownerteam = ownerteam;
}

private createweaponobjectwatcher(weaponname, ownerteam) {
  if(!isDefined(self.weaponobjectwatcherarray)) {
    self.weaponobjectwatcherarray = [];
  }

  weaponobjectwatcher = getweaponobjectwatcher(weaponname);

  if(!isDefined(weaponobjectwatcher)) {
    weaponobjectwatcher = spawnStruct();
    self.weaponobjectwatcherarray[self.weaponobjectwatcherarray.size] = weaponobjectwatcher;
    weaponobjectwatcher.name = weaponname;
    weaponobjectwatcher.type = "use";
    weaponobjectwatcher.weapon = getweapon(weaponname);
    weaponobjectwatcher.watchforfire = 0;
    weaponobjectwatcher.hackable = 0;
    weaponobjectwatcher.altdetonate = 0;
    weaponobjectwatcher.detectable = 1;
    weaponobjectwatcher.stuntime = 0;
    weaponobjectwatcher.timeout = getweapon(weaponname).lifetime;
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
    weaponobjectwatcher.onfizzleout = &weaponobjectfizzleout;
    weaponobjectwatcher.isfataldamage = undefined;
    weaponobjectwatcher.onsupplementaldetonatecallback = undefined;
    weaponobjectwatcher.ontimeout = undefined;
    weaponobjectwatcher.var_994b472b = undefined;

    if(!isDefined(weaponobjectwatcher.objectarray)) {
      weaponobjectwatcher.objectarray = [];
    }
  }

  resetweaponobjectwatcher(weaponobjectwatcher, ownerteam);
  return weaponobjectwatcher;
}

private createuseweaponobjectwatcher(weaponname, ownerteam) {
  weaponobjectwatcher = createweaponobjectwatcher(weaponname, ownerteam);
  weaponobjectwatcher.type = "use";
  weaponobjectwatcher.onspawn = &onspawnuseweaponobject;
  return weaponobjectwatcher;
}

private createproximityweaponobjectwatcher(weaponname, ownerteam) {
  weaponobjectwatcher = createweaponobjectwatcher(weaponname, ownerteam);
  weaponobjectwatcher.type = "proximity";
  weaponobjectwatcher.onspawn = &onspawnproximityweaponobject;
  detectionconeangle = getdvarint(#"scr_weaponobject_coneangle", 70);
  weaponobjectwatcher.detectiondot = cos(detectionconeangle);
  weaponobjectwatcher.detectionmindist = getdvarint(#"scr_weaponobject_mindist", 20);
  weaponobjectwatcher.detectiongraceperiod = getdvarfloat(#"scr_weaponobject_graceperiod", 0.6);
  weaponobjectwatcher.detonateradius = getdvarint(#"scr_weaponobject_radius", 180);
  return weaponobjectwatcher;
}

wasproximityalarmactivatedbyself() {
  return isDefined(self.owner.var_4cd6885) && self.owner.var_4cd6885 == self;
}

proximityalarmactivate(active, watcher, var_af12fba0 = undefined) {
  if(!isplayer(self.owner)) {
    return;
  }

  var_9292c6b5 = watcher.var_82aa8ec4 === 1;

  if(active && !isDefined(self.owner.var_4cd6885)) {
    self.owner.var_4cd6885 = self;
    state = var_9292c6b5 ? 3 : 2;
    self setstate(state);
    return;
  }

  if(!isDefined(self) || self wasproximityalarmactivatedbyself() || !var_9292c6b5 && self.owner clientfield::get_to_player("proximity_alarm") == 1) {
    self.owner.var_4cd6885 = undefined;
    state = 0;

    if(var_9292c6b5) {
      curstate = self.owner clientfield::get_to_player("proximity_alarm");

      switch (curstate) {
        case 4:
        case 5:
          state = curstate;
          break;
        default:
          state = 2;
          break;
      }
    }

    self setstate(state);
  }
}

setstate(newstate) {
  player = self.owner;

  if(!isplayer(player)) {
    return;
  }

  curstate = player clientfield::get_to_player("proximity_alarm");

  if(curstate != newstate) {
    player clientfield::set_to_player("proximity_alarm", newstate);
    player clientfield::set_player_uimodel("hudItems.proximityAlarm", newstate);
    watcher = player getweaponobjectwatcherbyweapon(self.weapon);

    if(isDefined(watcher) && isDefined(watcher.var_cfc18899)) {
      self[[watcher.var_cfc18899]](curstate, newstate, player.var_4cd6885);
    }
  }
}

proximityalarmloop(watcher, owner) {
  level endon(#"game_ended");
  self endon(#"death", #"hacked", #"detonating");

  if(self.weapon.proximityalarminnerradius <= 0) {
    return;
  }

  self util::waittillnotmoving();
  var_9292c6b5 = watcher.var_82aa8ec4 === 1;

  if(var_9292c6b5 && !(isDefined(self.owner._disable_proximity_alarms) && self.owner._disable_proximity_alarms)) {
    curstate = self.owner clientfield::get_to_player("proximity_alarm");

    if(curstate != 5) {
      self setstate(1);
    }
  }

  delaytimesec = float(self.weapon.proximityalarmactivationdelay) / 1000;

  if(delaytimesec > 0) {
    wait delaytimesec;

    if(!isDefined(self)) {
      return;
    }
  }

  if(!(isDefined(self.owner._disable_proximity_alarms) && self.owner._disable_proximity_alarms)) {
    state = var_9292c6b5 ? 2 : 1;
    self setstate(state);
  }

  self.proximity_deployed = 1;
  alarmstatusold = "notify";
  alarmstatus = "off";
  var_af12fba0 = undefined;

  while(true) {
    wait 0.05;

    if(!isDefined(self.owner) || !isplayer(self.owner)) {
      return;
    }

    if(isalive(self.owner) == 0 && self.owner util::isusingremote() == 0) {
      self proximityalarmactivate(0, watcher);
      return;
    }

    if(isDefined(self.owner._disable_proximity_alarms) && self.owner._disable_proximity_alarms) {
      self proximityalarmactivate(0, watcher);
    } else if(alarmstatus != alarmstatusold || alarmstatus == "on" && !isDefined(self.owner.var_4cd6885)) {
      if(alarmstatus == "on") {
        self proximityalarmactivate(1, watcher, var_af12fba0);
      } else {
        self proximityalarmactivate(0, watcher);
      }

      alarmstatusold = alarmstatus;
    }

    alarmstatus = "off";
    var_af12fba0 = undefined;
    actors = getactorarray();
    players = getplayers();
    detectentities = arraycombine(players, actors, 0, 0);

    foreach(entity in detectentities) {
      wait 0.05;

      if(!isDefined(entity)) {
        continue;
      }

      owner = entity;

      if(isactor(entity) && (!isDefined(entity.isaiclone) || !entity.isaiclone)) {
        continue;
      } else if(isactor(entity)) {
        owner = entity.owner;
      }

      if(entity.team == #"spectator") {
        continue;
      }

      if(level.weaponobjectdebug != 1) {
        if(owner hasperk(#"specialty_detectexplosive")) {
          continue;
        }

        if(isDefined(self.owner) && owner == self.owner) {
          continue;
        }

        if(!damage::friendlyfirecheck(self.owner, owner, 0)) {
          continue;
        }
      }

      if(self isstunned()) {
        continue;
      }

      if(!isalive(entity)) {
        continue;
      }

      if(isDefined(watcher.immunespecialty) && owner hasperk(watcher.immunespecialty)) {
        continue;
      }

      radius = self.weapon.proximityalarmouterradius;
      distancesqr = distancesquared(self.origin, entity.origin);

      if(radius * radius < distancesqr) {
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

      if(radius * radius < distancesqr) {
        continue;
      }

      alarmstatus = "on";
      var_af12fba0 = entity;
      break;
    }
  }
}

commononspawnuseweaponobjectproximityalarm(watcher, owner) {

  if(level.weaponobjectdebug == 1) {
    self thread proximityalarmweaponobjectdebug(watcher);
  }

    if(isDefined(watcher.var_82aa8ec4) && watcher.var_82aa8ec4) {
      curstate = self.owner clientfield::get_to_player("proximity_alarm");

      if(curstate != 5) {
        self setstate(0);
      }
    }

  self proximityalarmloop(watcher, owner);
  self proximityalarmactivate(0, watcher);

  if(isDefined(watcher.var_82aa8ec4) && watcher.var_82aa8ec4) {
    owner = self.owner;
    curstate = owner clientfield::get_to_player("proximity_alarm");

    if(curstate != 4 && curstate != 5) {
      owner clientfield::set_to_player("proximity_alarm", 0);
      owner clientfield::set_player_uimodel("hudItems.proximityAlarm", 0);
    }
  }
}

onspawnuseweaponobject(watcher, owner) {
  self thread commononspawnuseweaponobjectproximityalarm(watcher, owner);
}

onspawnproximityweaponobject(watcher, owner) {
  self.protected_entities = [];

  if(isDefined(level._proximityweaponobjectdetonation_override)) {
    self thread[[level._proximityweaponobjectdetonation_override]](watcher);
  } else if(isDefined(self._proximityweaponobjectdetonation_override)) {
    self thread[[self._proximityweaponobjectdetonation_override]](watcher);
  } else {
    self thread proximityweaponobjectdetonation(watcher);
  }

  if(level.weaponobjectdebug == 1) {
    self thread proximityweaponobjectdebug(watcher);
  }

}

watchweaponobjectusage() {}

watchweaponobjectspawn(notify_type, endonnotify = undefined) {
  if(isDefined(endonnotify)) {
    self endon(endonnotify);
  }

  self endon(#"death");
  self notify(#"watchweaponobjectspawn");
  self endon(#"watchweaponobjectspawn", #"disconnect");

  while(true) {
    if(isDefined(notify_type)) {
      waitresult = self waittill(notify_type);
    } else {
      waitresult = self waittill(#"grenade_fire", #"grenade_launcher_fire", #"missile_fire", #"placeables_plant");
    }

    weapon_instance = waitresult.projectile;
    weapon = waitresult.weapon;

    if(isDefined(level.projectiles_should_ignore_world_pause) && level.projectiles_should_ignore_world_pause && isDefined(weapon_instance)) {
      weapon_instance setignorepauseworld(1);
    }

    if(isplayer(self) && weapon.setusedstat && !self util::ishacked()) {
      self stats::function_e24eec31(weapon, #"used", 1);
    }

    watcher = getweaponobjectwatcherbyweapon(weapon);

    if(isDefined(watcher)) {
      cleanweaponobjectarray(watcher);

      if(weapon.maxinstancesallowed) {
        if(watcher.objectarray.size > weapon.maxinstancesallowed - 1) {
          watcher thread waitandfizzleout(watcher.objectarray[0], 0.1);

          if(isDefined(watcher.var_82aa8ec4) && watcher.var_82aa8ec4) {
            watcher.objectarray[0] setstate(5);
          }

          watcher.objectarray[0] = undefined;
          cleanweaponobjectarray(watcher);
        }
      }

      self addweaponobject(watcher, weapon_instance, weapon, endonnotify);
    }
  }
}

anyobjectsinworld(weapon) {
  objectsinworld = 0;

  for(i = 0; i < self.weaponobjectwatcherarray.size; i++) {
    if(self.weaponobjectwatcherarray[i].weapon != weapon) {
      continue;
    }

    if(isDefined(self.weaponobjectwatcherarray[i].ondetonatecallback) && self.weaponobjectwatcherarray[i].objectarray.size > 0) {
      objectsinworld = 1;
      break;
    }
  }

  return objectsinworld;
}

proximitysphere(origin, innerradius, incolor, outerradius, outcolor) {
  self endon(#"death");

  while(true) {
    if(isDefined(innerradius)) {
      dev::debug_sphere(origin, innerradius, incolor, 0.25, 1);
    }

    if(isDefined(outerradius)) {
      dev::debug_sphere(origin, outerradius, outcolor, 0.25, 1);
    }

    waitframe(1);
  }
}

proximityalarmweaponobjectdebug(watcher) {
  self endon(#"death");
  self util::waittillnotmoving();

  if(!isDefined(self)) {
    return;
  }

  self thread proximitysphere(self.origin, self.weapon.proximityalarminnerradius, (0, 0.75, 0), self.weapon.proximityalarmouterradius, (0, 0.75, 0));
}

proximityweaponobjectdebug(watcher) {
  self endon(#"death");
  self util::waittillnotmoving();

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(watcher.ignoredirection)) {
    self thread proximitysphere(self.origin, watcher.detonateradius, (1, 0.85, 0), self.weapon.explosionradius, (1, 0, 0));
    return;
  }

  self thread showcone(acos(watcher.detectiondot), watcher.detonateradius, (1, 0.85, 0));
  self thread showcone(60, 256, (1, 0, 0));
}

showcone(angle, range, color) {
  self endon(#"death");
  start = self.origin;
  forward = anglesToForward(self.angles);
  right = vectorcross(forward, (0, 0, 1));
  up = vectorcross(forward, right);
  fullforward = forward * range * cos(angle);
  sideamnt = range * sin(angle);

  while(true) {
    prevpoint = (0, 0, 0);

    for(i = 0; i <= 20; i++) {
      coneangle = i / 20 * 360;
      point = start + fullforward + sideamnt * (right * cos(coneangle) + up * sin(coneangle));

      if(i > 0) {
        line(start, point, color);
        line(prevpoint, point, color);
      }

      prevpoint = point;
    }

    waitframe(1);
  }
}

  function weaponobjectdetectionmovable(ownerteam) {
    self endon(#"end_detection", #"death", #"hacked");
    level endon(#"game_ended");

    if(!level.teambased) {
      return;
    }

    self.detectid = "rcBomb" + gettime() + randomint(1000000);
  }

seticonpos(item, icon, heightincrease) {
  icon.x = item.origin[0];
  icon.y = item.origin[1];
  icon.z = item.origin[2] + heightincrease;
}

weaponobjectdetectiontrigger_wait(ownerteam) {
  self endon(#"death", #"hacked", #"detonating");
  util::waittillnotmoving();
  self thread weaponobjectdetectiontrigger(ownerteam);
}

weaponobjectdetectiontrigger(ownerteam) {
  trigger = spawn("trigger_radius", self.origin - (0, 0, 128), 0, 512, 256);
  trigger.detectid = "trigger" + gettime() + randomint(1000000);
  trigger sethintlowpriority(1);
  self waittill(#"death", #"hacked", #"detonating");
  trigger notify(#"end_detection");

  if(isDefined(trigger.bombsquadicon)) {
    trigger.bombsquadicon destroy();
  }

    trigger delete();
}

hackertriggersetvisibility(owner) {
  self endon(#"death");
  assert(isplayer(owner));
  ownerteam = owner.pers[#"team"];

  for(;;) {
    if(level.teambased) {
      self setvisibletoallexceptteam(ownerteam);
      self setexcludeteamfortrigger(ownerteam);
    } else {
      self setvisibletoall();
      self setteamfortrigger(#"none");
    }

    if(isDefined(owner)) {
      self setinvisibletoplayer(owner);
    }

    level waittill(#"player_spawned", #"joined_team");
  }
}

hackernotmoving() {
  self endon(#"death");
  self util::waittillnotmoving();
  self notify(#"landed");
}

private set_hint_string(hint_string, default_string) {
  if(isDefined(hint_string) && hint_string != "") {
    self sethintstring(hint_string);
    return;
  }

  self sethintstring(default_string);
}

hackerinit(watcher) {
  self thread hackernotmoving();
  event = self waittill(#"death", #"landed");

  if(event._notify == "death") {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  triggerorigin = self.origin;

  if(isDefined(self.weapon.hackertriggerorigintag) && "" != self.weapon.hackertriggerorigintag) {
    triggerorigin = self gettagorigin(self.weapon.hackertriggerorigintag);
  }

  self.hackertrigger = function_c7cdf243(triggerorigin, level.weaponobjects_hacker_trigger_width, level.weaponobjects_hacker_trigger_height);
  self.hackertrigger set_hint_string(self.weapon.var_2f3ca476, #"mp/generic_hacking");
  self.hackertrigger setignoreentfortrigger(self);
  self.hackertrigger setperkfortrigger(#"specialty_disarmexplosive");
  self.hackertrigger thread hackertriggersetvisibility(self.owner);

    self thread hackerthink(self.hackertrigger, watcher);
}

hackerthink(trigger, watcher) {
  self endon(#"death");
  trigger endon(#"death");

  for(;;) {
    waitresult = trigger waittill(#"trigger");

    if(!isDefined(waitresult.is_instant) && !trigger hackerresult(waitresult.activator, self.owner)) {
      continue;
    }

    self itemhacked(watcher, waitresult.activator);
    return;
  }
}

itemhacked(watcher, player) {
  self proximityalarmactivate(0, watcher);
  self.owner hackerremoveweapon(self);

  if(isDefined(level.playequipmenthackedonplayer)) {
    self.owner[[level.playequipmenthackedonplayer]]();
  }

  if(self.weapon.ammocountequipment > 0 && isDefined(self.ammo)) {
    ammoleftequipment = self.ammo;

    if(self.weapon.rootweapon == getweapon(#"trophy_system")) {
      player trophy_system::ammo_weapon_hacked(ammoleftequipment);
    }
  }

  self.hacked = 1;
  self setmissileowner(player);
  self setteam(player.pers[#"team"]);
  self.owner = player;
  self clientfield::set("retrievable", 0);

  if(self.weapon.dohackedstats) {
    scoreevents::processscoreevent(#"hacked", player, undefined, undefined);
    player stats::function_e24eec31(getweapon(#"pda_hack"), #"combatrecordstat", 1);
    player challenges::hackedordestroyedequipment();
  }

  if(self.weapon.rootweapon == level.weaponsatchelcharge && isDefined(player.lowermessage)) {
    player.lowermessage settext(#"hash_5723526a77b686b2");
    player.lowermessage.alpha = 1;
    player.lowermessage fadeovertime(2);
    player.lowermessage.alpha = 0;
  }

    self notify(#"hacked", {
      #player: player
    });
  level notify(#"hacked", {
    #target: self, 
    #player: player
  });

  if(isDefined(self.camerahead)) {
    self.camerahead notify(#"hacked", {
      #player: player
    });
  }

    waitframe(1);

  if(isDefined(player) && player.sessionstate == "playing") {
    player notify(#"grenade_fire", {
      #projectile: self, 
      #weapon: self.weapon, 
      #respawn_from_hack: 1
    });
    return;
  }

  watcher thread waitanddetonate(self, 0, undefined, self.weapon);
}

hackerunfreezeplayer(player) {
  self endon(#"hack_done");
  self waittill(#"death");

  if(isDefined(player)) {
    player val::reset(#"gameobjects", "freezecontrols");
    player val::reset(#"gameobjects", "disable_weapons");
  }
}

hackerresult(player, owner) {
  success = 1;
  time = gettime();
  hacktime = getdvarfloat(#"perk_disarmexplosivetime", 0);

  if(!canhack(player, owner, 1)) {
    return 0;
  }

  self thread hackerunfreezeplayer(player);

  while(time + int(hacktime * 1000) > gettime()) {
    if(!canhack(player, owner, 0)) {
      success = 0;
      break;
    }

    if(!player usebuttonpressed()) {
      success = 0;
      break;
    }

    if(!isDefined(self)) {
      success = 0;
      break;
    }

    player val::set(#"gameobjects", "freezecontrols");
    player val::set(#"gameobjects", "disable_weapons");

    if(!isDefined(self.progressbar)) {
      self.progressbar = player hud::function_5037fb7f();
      self.progressbar.lastuserate = -1;
      self.progressbar hud::showelem();
      self.progressbar hud::updatebar(0.01, 1 / hacktime);
      self.progresstext = player hud::function_48badcf4();
      self.progresstext settext(#"mp/hacking");
      self.progresstext hud::showelem();
      player playlocalsound(#"evt_hacker_hacking");
    }

      waitframe(1);
  }

  if(isDefined(player)) {
    player val::reset(#"gameobjects", "freezecontrols");
    player val::reset(#"gameobjects", "disable_weapons");
  }

  if(isDefined(self.progressbar)) {
    self.progressbar hud::destroyelem();
    self.progresstext hud::destroyelem();
  }

    if(isDefined(self)) {
      self notify(#"hack_done");
    }

  return success;
}

canhack(player, owner, weapon_check) {
  if(!isDefined(player)) {
    return false;
  }

  if(!isplayer(player)) {
    return false;
  }

  if(!isalive(player)) {
    return false;
  }

  if(!isDefined(owner)) {
    return false;
  }

  if(owner == player) {
    return false;
  }

  if(level.teambased && !util::function_fbce7263(player.team, owner.team)) {
    return false;
  }

  if(isDefined(player.isdefusing) && player.isdefusing) {
    return false;
  }

  if(isDefined(player.isplanting) && player.isplanting) {
    return false;
  }

  if(isDefined(player.proxbar) && !player.proxbar.hidden) {
    return false;
  }

  if(isDefined(player.revivingteammate) && player.revivingteammate == 1) {
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

  if(!player hasperk(#"specialty_disarmexplosive")) {
    return false;
  }

  if(player isempjammed()) {
    return false;
  }

  if(isDefined(player.laststand) && player.laststand) {
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

    if(!isDefined(weapon)) {
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

hackerremoveweapon(weapon_instance) {
  if(isDefined(self) && isDefined(self.weaponobjectwatcherarray)) {
    for(i = 0; i < self.weaponobjectwatcherarray.size; i++) {
      if(self.weaponobjectwatcherarray[i].weapon != weapon_instance.weapon.rootweapon) {
        continue;
      }

      removeweaponobject(self.weaponobjectwatcherarray[i], weapon_instance);
      return;
    }
  }
}

proximityweaponobject_createdamagearea(watcher) {
  damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - watcher.detonateradius), 4096 | 16384 | level.aitriggerspawnflags | level.vehicletriggerspawnflags, watcher.detonateradius, watcher.detonateradius * 2);
  damagearea enablelinkto();
  damagearea linkto(self);
  self thread deleteondeath(damagearea);
  return damagearea;
}

proximityweaponobject_validtriggerentity(watcher, ent) {
  if(level.weaponobjectdebug != 1) {
    if(isDefined(self.owner) && ent == self.owner) {
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

    if(!damage::friendlyfirecheck(self.owner, ent, 0)) {
      return false;
    }

    if(watcher.ignorevehicles && isai(ent) && !(isDefined(ent.isaiclone) && ent.isaiclone)) {
      return false;
    }
  }

  if(lengthsquared(ent getvelocity()) < 10 && !isDefined(watcher.immediatedetonation)) {
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

    if(isDefined(watcher.immunespecialty) && ent hasperk(watcher.immunespecialty)) {
      return false;
    }
  }

  return true;
}

proximityweaponobject_removespawnprotectondeath(ent) {
  self endon(#"death");
  ent waittill(#"death", #"disconnect");
  arrayremovevalue(self.protected_entities, ent);
}

proximityweaponobject_spawnprotect(watcher, ent) {
  self endon(#"death");
  ent endon(#"death");
  self.protected_entities[self.protected_entities.size] = ent;
  self thread proximityweaponobject_removespawnprotectondeath(ent);
  radius_sqr = watcher.detonateradius * watcher.detonateradius;

  while(true) {
    if(distancesquared(ent.origin, self.origin) > radius_sqr) {
      arrayremovevalue(self.protected_entities, ent);
      return;
    }

    wait 0.5;
  }
}

proximityweaponobject_isspawnprotected(watcher, ent) {
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

proximityweaponobject_dodetonation(watcher, ent, traceorigin) {
  self endon(#"death", #"hacked");
  self notify(#"kill_target_detection");

  if(isDefined(watcher.activatesound)) {
    self playSound(watcher.activatesound);
  }

  wait watcher.detectiongraceperiod;

  if(isplayer(ent) && ent hasperk(#"specialty_delayexplosive")) {
    wait getdvarfloat(#"perk_delayexplosivetime", 0);
  }

  self entityheadicons::setentityheadicon("none");
  self.origin = traceorigin;

  if(isDefined(self.var_cea6a2fb)) {
    self.var_cea6a2fb placeables::forceshutdown();
  }

  if(isDefined(self.owner) && isplayer(self.owner)) {
    self[[watcher.ondetonatecallback]](self.owner, undefined, ent);
    return;
  }

  self[[watcher.ondetonatecallback]](undefined, undefined, ent);
}

proximityweaponobject_activationdelay(watcher) {
  self util::waittillnotmoving();

  if(watcher.activationdelay) {
    wait watcher.activationdelay;
  }
}

proximityweaponobject_waittillframeendanddodetonation(watcher, ent, traceorigin) {
  self endon(#"death");
  dist = distance(ent.origin, self.origin);

  if(isDefined(self.activated_entity_distance)) {
    if(dist < self.activated_entity_distance) {
      self notify(#"better_target");
    } else {
      return;
    }
  }

  self endon(#"better_target");
  self.activated_entity_distance = dist;
  waitframe(1);
  proximityweaponobject_dodetonation(watcher, ent, traceorigin);
}

proximityweaponobjectdetonation(s_watcher) {
  self endon(#"death", #"hacked", #"kill_target_detection");
  proximityweaponobject_activationdelay(s_watcher);
  var_6e4025f7 = proximityweaponobject_createdamagearea(s_watcher);

  while(true) {
    waitresult = var_6e4025f7 waittill(#"trigger");
    ent = waitresult.activator;

    if(!proximityweaponobject_validtriggerentity(s_watcher, ent)) {
      continue;
    }

    if(proximityweaponobject_isspawnprotected(s_watcher, ent)) {
      continue;
    }

    v_up = anglestoup(self.angles);
    var_f1e2d68b = self.origin + v_up;

    if(ent damageconetrace(var_f1e2d68b, self) > 0) {
      thread proximityweaponobject_waittillframeendanddodetonation(s_watcher, ent, var_f1e2d68b);
    }
  }
}

shouldaffectweaponobject(object, watcher) {
  radius = object.weapon.explosionradius;
  distancesqr = distancesquared(self.origin, object.origin);

  if(radius != 0 && radius * radius < distancesqr) {
    return false;
  }

  pos = self.origin + (0, 0, 32);

  if(isDefined(watcher.ignoredirection)) {
    return true;
  }

  dirtopos = pos - object.origin;
  objectforward = anglesToForward(object.angles);
  dist = vectordot(dirtopos, objectforward);

  if(dist < watcher.detectionmindist) {
    return false;
  }

  dirtopos = vectornormalize(dirtopos);
  dot = vectordot(dirtopos, objectforward);
  return dot > watcher.detectiondot;
}

deleteondeath(ent) {
  self waittill(#"death", #"hacked");
  waitframe(1);

  if(isDefined(ent)) {
    ent delete();
  }
}

testkillbrushonstationary(a_killbrushes, player) {
  player endon(#"disconnect");
  self endon(#"death");
  self waittill(#"stationary");

  foreach(trig in a_killbrushes) {
    if(isDefined(trig) && self istouching(trig)) {
      if(!trig istriggerenabled()) {
        continue;
      }

      if(!(isDefined(self.spawnflags) && (self.spawnflags&8) == 8) && !(isDefined(self.spawnflags) && (self.spawnflags&512) == 512) && !(isDefined(self.spawnflags) && (self.spawnflags&32768) == 32768)) {
        continue;
      }

      if(self.origin[2] > player.origin[2]) {
        break;
      }

      if(isDefined(self)) {
        self delete();
      }

      return;
    }
  }
}

deleteonkillbrush(player) {
  player endon(#"disconnect");
  self endon(#"death", #"stationary");
  a_killbrushes = getEntArray("trigger_hurt_new", "classname");
  self thread testkillbrushonstationary(a_killbrushes, player);

  while(true) {
    a_killbrushes = getEntArray("trigger_hurt_new", "classname");

    for(i = 0; i < a_killbrushes.size; i++) {
      if(self istouching(a_killbrushes[i])) {
        if(!a_killbrushes[i] istriggerenabled()) {
          continue;
        }

        if(!(isDefined(self.spawnflags) && (self.spawnflags&8) == 8) && !(isDefined(self.spawnflags) && (self.spawnflags&512) == 512) && !(isDefined(self.spawnflags) && (self.spawnflags&32768) == 32768)) {
          continue;
        }

        if(self.origin[2] > player.origin[2]) {
          break;
        }

        if(isDefined(self)) {
          self delete();
        }

        return;
      }
    }

    wait 0.1;
  }
}

on_double_tap_detonate() {
  buttontime = 0;

  if(!isalive(self) && !self util::isusingremote()) {
    return;
  }

  for(watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
    if(self.weaponobjectwatcherarray[watcher].altdetonate) {
      self.weaponobjectwatcherarray[watcher] detonateweaponobjectarray(0);
    }
  }
}

on_detonate() {
  if(self isusingoffhand()) {
    weap = self getcurrentoffhand();
  } else {
    weap = self getcurrentweapon();
  }

  watcher = getweaponobjectwatcherbyweapon(weap);

  if(isDefined(watcher)) {
    if(isDefined(watcher.ondetonationhandle)) {
      self thread[[watcher.ondetonationhandle]](watcher);
    }

    watcher detonateweaponobjectarray(0);
  }
}

function_ac7c2bf9(params = undefined) {
  if(!isDefined(self.weaponobjectwatcherarray)) {
    return;
  }

  watchers = [];

  for(watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
    weaponobjectwatcher = spawnStruct();
    watchers[watchers.size] = weaponobjectwatcher;
    weaponobjectwatcher.objectarray = [];

    if(isDefined(self.weaponobjectwatcherarray[watcher].objectarray)) {
      weaponobjectwatcher.objectarray = self.weaponobjectwatcherarray[watcher].objectarray;
    }
  }

  waitframe(1);

  for(watcher = 0; watcher < watchers.size; watcher++) {
    watchers[watcher] deleteweaponobjectarray();
  }
}

saydamaged(orig, amount) {
  for(i = 0; i < 60; i++) {
    print3d(orig, "<dev string:x63>" + amount);
    waitframe(1);
  }
}

  function private function_c9fc5521(player, weapon) {
    maxammo = 0;
    loadout = player loadout::find_loadout_slot(weapon);

    if(isDefined(loadout)) {
      if(loadout.count > 0) {
        maxammo = loadout.count;
      } else {
        maxammo = weapon.maxammo + weapon.clipsize;
      }
    } else if(isDefined(player.grenadetypeprimary) && weapon == player.grenadetypeprimary && isDefined(player.grenadetypeprimarycount) && player.grenadetypeprimarycount > 0) {
      maxammo = player.grenadetypeprimarycount;
    } else if(isDefined(player.grenadetypesecondary) && weapon == player.grenadetypesecondary && isDefined(player.grenadetypesecondarycount) && player.grenadetypesecondarycount > 0) {
      maxammo = player.grenadetypesecondarycount;
    } else {
      maxammo = weapon.maxammo + weapon.clipsize;
    }

    return maxammo;
  }

private get_ammo(player, weapon) {
  ammo = player getweaponammoclip(weapon);

  if(!weapon.iscliponly) {
    ammo += player getweaponammostock(weapon);
  }

  return ammo;
}

private function_e0093db1(player, weapon) {
  maxammo = function_c9fc5521(player, weapon);

  if(maxammo == 0) {
    return false;
  }

  ammo = get_ammo(player, weapon);

  if(ammo >= maxammo) {
    return false;
  }

  return true;
}

function_d831baf0(trigger, callback, playersoundonuse, npcsoundonuse) {
  self endon(#"death", #"explode", #"hacked");
  trigger endon(#"death");

  while(true) {
    waitresult = trigger waittill(#"trigger");
    player = waitresult.activator;

    if(!isalive(player)) {
      continue;
    }

    if(!player isonground() && !player isplayerswimming()) {
      continue;
    }

    if(isDefined(trigger.claimedby) && player != trigger.claimedby) {
      continue;
    }

    heldweapon = player function_672ba881(self.weapon);

    if(!isDefined(heldweapon)) {
      continue;
    }

    if(!function_e0093db1(player, heldweapon)) {
      continue;
    }

    if(isDefined(playersoundonuse)) {
      player playlocalsound(playersoundonuse);
    }

    if(isDefined(npcsoundonuse)) {
      player playSound(npcsoundonuse);
    }

    self[[callback]](player, heldweapon);
    return;
  }
}

function_e3030545(pweapons, weapon) {
  foreach(pweapon in pweapons) {
    if(pweapon == weapon) {
      return pweapon;
    }
  }

  return undefined;
}

function_7f47d8b8(pweapons, weapon) {
  foreach(pweapon in pweapons) {
    if(pweapon.rootweapon == weapon.rootweapon) {
      return pweapon;
    }
  }

  return undefined;
}

get_held_weapon_match_or_root_match(weapon) {
  pweapons = self getweaponslist(1);
  match = function_e3030545(pweapons, weapon);

  if(isDefined(match)) {
    return match;
  }

  return function_7f47d8b8(pweapons, weapon);
}

function_42e13419(pweapons, weapon) {
  foreach(pweapon in pweapons) {
    if(pweapon.ammoindex == weapon.ammoindex) {
      return pweapon;
    }
  }

  return undefined;
}

function_3eca329f(pweapons, weapon) {
  foreach(pweapon in pweapons) {
    if(pweapon.clipindex == weapon.clipindex) {
      return pweapon;
    }
  }

  return undefined;
}

function_672ba881(weapon) {
  pweapons = self getweaponslist(1);
  match = function_3eca329f(pweapons, weapon);

  if(isDefined(match)) {
    return match;
  }

  return function_42e13419(pweapons, weapon);
}

private spawn_interact_trigger(type, origin, width, height, var_c16194e2) {
  if(isDefined(width) && isDefined(height)) {
    trigger = spawn(type, origin, 0, width, height);
  } else {
    trigger = spawn(type, origin);
  }

  if(var_c16194e2 !== 1) {
    trigger sethintlowpriority(1);
    trigger setcursorhint("HINT_NOICON", self);
  }

  trigger enablelinkto();
  trigger linkto(self);
  return trigger;
}

private function_c7cdf243(origin, width, height) {
  return spawn_interact_trigger("trigger_radius_use", origin, width, height);
}

private function_d5e8c3d0(origin, width, height) {
  return spawn_interact_trigger("trigger_radius", origin, width, height, 1);
}

function_23b0aea9(watcher, player) {
  self endon(#"death");
  self setowner(player);
  self setteam(player.pers[#"team"]);
  self.owner = player;
  self.oldangles = self.angles;
  self util::waittillnotmoving();
  waittillframeend();

  if(!isDefined(player) || !isDefined(player.pers)) {
    return;
  }

  if(player.pers[#"team"] == #"spectator") {
    return;
  }

  triggerorigin = self.origin;
  triggerparentent = undefined;

  if(isDefined(self.stucktoplayer)) {
    if(isalive(self.stucktoplayer) || !isDefined(self.stucktoplayer.body)) {
      if(isalive(self.stucktoplayer)) {
        triggerparentent = self;
        self unlink();
        self.angles = self.oldangles;
        self launch((5, 5, 5));
        self util::waittillnotmoving();
        waittillframeend();
      } else {
        triggerparentent = self.stucktoplayer;
      }
    } else {
      triggerparentent = self.stucktoplayer.body;
    }
  }

  if(!isDefined(self) || !isDefined(player)) {
    return;
  }

  if(isDefined(triggerparentent)) {
    triggerorigin = triggerparentent.origin + (0, 0, 10);
  } else {
    up = anglestoup(self.angles);
    triggerorigin = self.origin + up;
  }

  weapon = watcher.weapon;

  if(!self util::ishacked() && "None" != weapon.var_7d4c12af) {
    if(self.weapon.shownretrievable) {
      self clientfield::set("retrievable", 1);
    }

    if(weapon.var_7d4c12af == "Automatic") {
      function_57152a5(watcher, player, triggerorigin);
    } else {
      function_ac27aef5(watcher, player, triggerorigin);
    }

    if(isDefined(triggerparentent)) {
      self.pickuptrigger linkto(triggerparentent);
    }
  }

  if("None" != weapon.var_38eb7f9e) {
    function_9dbd349e(watcher, player, triggerorigin);
  }

  thread switch_team(self, watcher, player);

    self thread watchshutdown(player);
}

function_ac27aef5(watcher, player, origin) {
  self.pickuptrigger = function_c7cdf243(origin);
  self.pickuptrigger setinvisibletoall();
  self.pickuptrigger setvisibletoplayer(player);
  self.pickuptrigger setteamfortrigger(player.pers[#"team"]);
  self.pickuptrigger set_hint_string(self.weapon.var_8a03df2b, #"mp/generic_pickup");
  self thread watchusetrigger(self.pickuptrigger, watcher.pickup, watcher.pickupsoundplayer, watcher.pickupsound, watcher.weapon);

  if(isDefined(watcher.pickup_trigger_listener)) {
    self thread[[watcher.pickup_trigger_listener]](self.pickuptrigger, player);
  }
}

function_57152a5(watcher, player, origin) {
  height = 50;

  if(isDefined(watcher.weapon) && isDefined(watcher.weapon.var_ac36c1db) && watcher.weapon.var_ac36c1db > 0) {
    height = watcher.weapon.var_ac36c1db;
    origin -= (0, 0, height * 0.5);
  }

  self.pickuptrigger = function_d5e8c3d0(origin, 50, 50);
  self.pickuptrigger.claimedby = player;
  self thread function_d831baf0(self.pickuptrigger, watcher.pickup, watcher.pickupsoundplayer, watcher.pickupsound);
}

function_386fa470(player) {
  if(!isDefined(self.enemytrigger)) {
    return;
  }

  self.enemytrigger setinvisibletoplayer(player);

  if(level.teambased) {
    self.enemytrigger setexcludeteamfortrigger(player.team);
    self.enemytrigger.triggerteamignore = self.team;
  }
}

function_9dbd349e(watcher, player, origin) {
  self.enemytrigger = function_c7cdf243(origin);
  self.enemytrigger setinvisibletoplayer(player);

  if(level.teambased) {
    self.enemytrigger setexcludeteamfortrigger(player.team);
    self.enemytrigger.triggerteamignore = self.team;
  }

  self.enemytrigger set_hint_string(self.weapon.var_5c29f743, #"mp_generic_destroy");
  self thread watchusetrigger(self.enemytrigger, watcher.ondestroyed);
}

destroyent() {
  self delete();
}

private add_ammo(player, weapon) {
  if(weapon.iscliponly || weapon.var_d98594b2 == "Clip Then Ammo") {
    ammo = player getweaponammoclip(weapon);
    ammo++;
    clip_size = weapon.clipsize;

    if(ammo <= clip_size) {
      player setweaponammoclip(weapon, ammo);
      return;
    }
  }

  if(!weapon.iscliponly) {
    stock_ammo = player getweaponammostock(weapon);
    stock_ammo++;
    player setweaponammostock(weapon, stock_ammo);
  }
}

function_a6616b9c(player, heldweapon) {
  if(!self.weapon.anyplayercanretrieve && isDefined(self.owner) && self.owner != player) {
    return;
  }

  pickedweapon = self.weapon;

  if(self.weapon.ammocountequipment > 0 && isDefined(self.ammo)) {
    ammoleftequipment = self.ammo;
  }

  self notify(#"picked_up");
  heldweapon = player function_672ba881(self.weapon);

  if(!isDefined(heldweapon)) {
    return;
  }

  if(isDefined(ammoleftequipment)) {
    if(pickedweapon.rootweapon == getweapon(#"trophy_system")) {
      player trophy_system::ammo_weapon_pickup(ammoleftequipment);
    }
  }

  if("ammo" != heldweapon.gadget_powerusetype) {
    slot = player gadgetgetslot(heldweapon);
    player gadgetpowerchange(slot, heldweapon.gadget_powergainonretrieve);
    return;
  }

  if(!function_e0093db1(player, heldweapon)) {
    return;
  }

  add_ammo(player, heldweapon);
}

function_d9219ce2(player, weapon) {
  self notify(#"picked_up");

  if(weapon.gadget_powergainonretrieve > 0) {
    slot = player gadgetgetslot(weapon);

    if(slot >= 0) {
      clipsize = player getclipsize(weapon);

      if(clipsize && weapon.var_ce34bb7e) {
        powergain = weapon.gadget_powergainonretrieve / clipsize;
      } else {
        powergain = weapon.gadget_powergainonretrieve;
      }

      player gadgetpowerchange(slot, powergain);
      return;
    }
  }

  add_ammo(player, weapon);
}

ondestroyed(attacker, data) {
  playFX(level._effect[#"tacticalinsertionfizzle"], self.origin);
  self playSound(#"dst_tac_insert_break");

  if(isDefined(self.owner) && isDefined(level.playequipmentdestroyedonplayer)) {
    self.owner[[level.playequipmentdestroyedonplayer]]();
  }

  self delete();
}

watchshutdown(player) {
  self waittill(#"death", #"hacked", #"detonating");
  pickuptrigger = self.pickuptrigger;
  hackertrigger = self.hackertrigger;
  enemytrigger = self.enemytrigger;

  if(isDefined(pickuptrigger)) {
    pickuptrigger delete();
  }

  if(isDefined(hackertrigger)) {

    if(isDefined(hackertrigger.progressbar)) {
      hackertrigger.progressbar hud::destroyelem();
      hackertrigger.progresstext hud::destroyelem();
    }

      hackertrigger delete();
  }

  if(isDefined(enemytrigger)) {
    enemytrigger delete();
  }
}

watchusetrigger(trigger, callback, playersoundonuse, npcsoundonuse, callback_data) {
  self endon(#"death", #"delete");
  trigger endon(#"death");

  while(true) {
    waitresult = trigger waittill(#"trigger");
    player = waitresult.activator;

    if(isDefined(self.detonated) && self.detonated == 1) {
      if(isDefined(trigger)) {
        trigger delete();
      }

      return;
    }

    if(!isalive(player)) {
      continue;
    }

    if(isDefined(trigger.triggerteam) && player.pers[#"team"] != trigger.triggerteam) {
      continue;
    }

    if(isDefined(trigger.triggerteamignore) && player.team == trigger.triggerteamignore) {
      continue;
    }

    if(isDefined(trigger.claimedby) && player != trigger.claimedby) {
      continue;
    }

    grenade = player.throwinggrenade;
    weapon = player getcurrentweapon();

    if(weapon.isequipment) {
      grenade = 0;
    }

    if(player usebuttonpressed() && !(isDefined(grenade) && grenade) && !player meleebuttonpressed()) {
      if(isDefined(playersoundonuse)) {
        player playlocalsound(playersoundonuse);
      }

      if(isDefined(npcsoundonuse)) {
        player playSound(npcsoundonuse);
      }

      self thread[[callback]](player, callback_data);
    }
  }
}

setupreconeffect() {
  if(!isDefined(self)) {
    return;
  }

  if(self.weapon.shownenemyexplo || self.weapon.shownenemyequip) {
    if(isDefined(self.hacked) && self.hacked) {
      self clientfield::set("enemyequip", 2);
      return;
    }

    self clientfield::set("enemyequip", 1);
  }
}

useteamequipmentclientfield(watcher) {
  if(isDefined(watcher)) {
    if(!isDefined(watcher.notequipment)) {
      if(isDefined(self)) {
        return true;
      }
    }
  }

  return false;
}

getwatcherforweapon(weapon) {
  if(!isDefined(self)) {
    return undefined;
  }

  if(!isplayer(self)) {
    return undefined;
  }

  for(i = 0; i < self.weaponobjectwatcherarray.size; i++) {
    if(self.weaponobjectwatcherarray[i].weapon != weapon) {
      continue;
    }

    return self.weaponobjectwatcherarray[i];
  }

  return undefined;
}

destroy_other_teams_supplemental_watcher_objects(attacker, weapon, radius) {
  if(level.teambased) {
    foreach(team, _ in level.teams) {
      if(!attacker util::isenemyteam(team)) {
        continue;
      }

      destroy_supplemental_watcher_objects(attacker, team, weapon, radius);
    }
  }

  destroy_supplemental_watcher_objects(attacker, "free", weapon, radius);
}

destroy_supplemental_watcher_objects(attacker, team, weapon, radius) {
  radiussq = radius * radius;

  foreach(item in level.supplementalwatcherobjects) {
    if(!isDefined(item.weapon)) {
      continue;
    }

    if(distancesquared(item.origin, attacker.origin) > radiussq) {
      continue;
    }

    if(!isDefined(item.owner)) {
      continue;
    }

    if(isDefined(team) && util::function_fbce7263(item.owner.team, team)) {
      continue;
    } else if(item.owner == attacker) {
      continue;
    }

    watcher = item.owner getwatcherforweapon(item.weapon);

    if(!isDefined(watcher) || !isDefined(watcher.onsupplementaldetonatecallback)) {
      continue;
    }

    item thread[[watcher.onsupplementaldetonatecallback]]();
  }
}

add_supplemental_object(object) {
  level.supplementalwatcherobjects[level.supplementalwatcherobjects.size] = object;
  object thread watch_supplemental_object_death();
}

watch_supplemental_object_death() {
  self waittill(#"death");
  arrayremovevalue(level.supplementalwatcherobjects, self);
}

function_d9c08e94(var_2f190eaf, var_46f3f2d3) {
  self endon(#"cancel_timeout");

  if(!isDefined(var_2f190eaf) || var_2f190eaf <= 0) {
    return;
  }

  self endon(#"death");
  wait float(var_2f190eaf) / 1000;

  if(isDefined(var_46f3f2d3)) {
    self[[var_46f3f2d3]]();
  }
}

switch_team(entity, watcher, owner) {
  self notify(#"stop_disarmthink");
  self endon(#"stop_disarmthink", #"death");
  setdvar(#"scr_switch_team", "<dev string:x6f>");

  while(true) {
    wait 0.5;
    devgui_int = getdvarint(#"scr_switch_team", 0);

    if(devgui_int != 0) {
      team = "<dev string:x72>";

      if(isDefined(level.getenemyteam) && isDefined(owner) && isDefined(owner.team)) {
        team = [
          [level.getenemyteam]
        ](owner.team);
      }

      if(isDefined(level.devongetormakebot)) {
        player = [
          [level.devongetormakebot]
        ](team);
      }

      if(!isDefined(player)) {
        println("<dev string:x7f>");
        wait 1;
        continue;
      }

      entity itemhacked(watcher, player);
      setdvar(#"scr_switch_team", 0);
    }
  }
}

