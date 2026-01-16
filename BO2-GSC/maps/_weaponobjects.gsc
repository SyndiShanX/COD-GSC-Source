/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_weaponobjects.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_ballistic_knife;

init() {
  level thread onplayerconnect();
  level.claymorefxid = loadfx("weapon/claymore/fx_claymore_laser");
  level.watcherweaponnames = [];
  level.watcherweaponnames = getwatcherweapons();
  level.retrievableweapons = [];
  level.retrievableweapons = getretrievableweapons();
  setup_retrievable_hint_strings();
  level.weaponobjectexplodethisframe = 0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connecting", player);
    player.usedweapons = 0;
    player.hits = 0;
    player thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    self create_base_watchers();
    self create_satchel_watcher();
    self create_ied_watcher();
    self create_ballistic_knife_watcher();
    self setup_retrievable_watcher();
    self thread watch_weapon_object_usage();
  }
}

setup_retrievable_hint_strings() {
  create_retrievable_hint("hatchet", & "WEAPON_HATCHET_PICKUP");
  create_retrievable_hint("satchel_charge", & "WEAPON_SATCHEL_CHARGE_PICKUP");
  create_retrievable_hint("claymore", & "WEAPON_CLAYMORE_PICKUP");
  create_retrievable_hint("proximity_grenade", & "WEAPON_TASER_SPIKE_PICKUP");
}

create_retrievable_hint(name, hint) {
  retrievehint = spawnstruct();
  retrievehint.name = name;
  retrievehint.hint = hint;
  level.retrievehints[name] = retrievehint;
}

create_base_watchers() {
  for(i = 0; i < level.watcherweaponnames.size; i++) {
    watchername = getsubstr(level.watcherweaponnames[i], 0, level.watcherweaponnames[i].size - 3);
    self create_weapon_object_watcher(watchername, level.watcherweaponnames[i], self.team);
  }

  for(i = 0; i < level.retrievableweapons.size; i++) {
    watchername = getsubstr(level.retrievableweapons[i], 0, level.retrievableweapons[i].size - 3);
    self create_weapon_object_watcher(watchername, level.retrievableweapons[i], self.team);
  }
}

create_claymore_watcher() {
  watcher = self create_use_weapon_object_watcher("claymore", "claymore_sp", self.team);
  watcher.watchforfire = 1;
  watcher.detonate = ::weapon_detonate;
  watcher.onspawnfx = ::on_spawn_claymore_fx;
  watcher.activatesound = "wpn_claymore_alert";
  detectionconeangle = weapons_get_dvar_int("scr_weaponobject_coneangle");
  watcher.detectiondot = cos(detectionconeangle);
  watcher.detectionmindist = weapons_get_dvar_int("scr_weaponobject_mindist");
  watcher.detectiongraceperiod = weapons_get_dvar("scr_weaponobject_graceperiod");
  watcher.detonateradius = weapons_get_dvar_int("scr_weaponobject_radius");
  watcher = self create_use_weapon_object_watcher("claymore_80s", "claymore_80s_sp", self.team);
  watcher.watchforfire = 1;
  watcher.detonate = ::weapon_detonate;
  watcher.onspawnfx = ::on_spawn_claymore_fx;
  watcher.activatesound = "wpn_claymore_alert";
  detectionconeangle = weapons_get_dvar_int("scr_weaponobject_coneangle");
  watcher.detectiondot = cos(detectionconeangle);
  watcher.detectionmindist = weapons_get_dvar_int("scr_weaponobject_mindist");
  watcher.detectiongraceperiod = weapons_get_dvar("scr_weaponobject_graceperiod");
  watcher.detonateradius = weapons_get_dvar_int("scr_weaponobject_radius");
}

create_claymore_watcher_zm() {
  watcher = self create_use_weapon_object_watcher("claymore", "claymore_zm", self.team);
  watcher.pickup = level.pickup_claymores;
  watcher.pickup_trigger_listener = level.pickup_claymores_trigger_listener;
  watcher.skip_weapon_object_damage = 1;
}

on_spawn_claymore_fx() {
  self endon("death");

  while(true) {
    self waittill_not_moving();
    org = self gettagorigin("tag_fx");
    ang = self gettagangles("tag_fx");
    fx = spawnfx(level.claymorefxid, org, anglestoforward(ang), anglestoup(ang));
    triggerfx(fx);
    self thread clear_fx_on_death(fx);
    originalorigin = self.origin;

    while(true) {
      wait 0.25;

      if(self.origin != originalorigin) {
        break;
      }
    }

    fx delete();
  }
}

clear_fx_on_death(fx) {
  fx endon("death");
  self waittill("death");
  fx delete();
}

create_satchel_watcher() {
  watcher = self create_use_weapon_object_watcher("satchel_charge", "satchel_charge_sp", self.team);
  watcher.altdetonate = 1;
  watcher.watchforfire = 1;
  watcher.disarmable = 1;
  watcher.headicon = 0;
  watcher.detonate = ::weapon_detonate;
  watcher.altweapon = "satchel_charge_detonator_sp";
  watcher = self create_use_weapon_object_watcher("satchel_charge_80s", "satchel_charge_80s_sp", self.team);
  watcher.altdetonate = 1;
  watcher.watchforfire = 1;
  watcher.disarmable = 1;
  watcher.headicon = 0;
  watcher.detonate = ::weapon_detonate;
  watcher.altweapon = "satchel_charge_detonator_sp";
}

create_ied_watcher() {
  watcher = self create_use_weapon_object_watcher("ied", "ied_sp", self.team);
  watcher.altdetonate = 1;
  watcher.watchforfire = 1;
  watcher.disarmable = 0;
  watcher.headicon = 0;
  watcher.detonate = ::weapon_detonate;
  watcher.altweapon = "satchel_charge_detonator_sp";
}

create_ballistic_knife_watcher() {
  watcher = self create_use_weapon_object_watcher("knife_ballistic", "knife_ballistic_sp", self.team);
  watcher.onspawn = maps\_ballistic_knife::on_spawn;
  watcher.onspawnretrievetriggers = maps\_ballistic_knife::on_spawn_retrieve_trigger;
  watcher.storedifferentobject = 1;
  watcher = self create_use_weapon_object_watcher("knife_ballistic_80s", "knife_ballistic_80s_sp", self.team);
  watcher.onspawn = maps\_ballistic_knife::on_spawn;
  watcher.onspawnretrievetriggers = maps\_ballistic_knife::on_spawn_retrieve_trigger;
  watcher.storedifferentobject = 1;
}

create_ballistic_knife_watcher_zm(name, weapon) {
  watcher = self create_use_weapon_object_watcher(name, weapon, self.team);
  watcher.onspawn = maps\_ballistic_knife::on_spawn;
  watcher.onspawnretrievetriggers = maps\_ballistic_knife::on_spawn_retrieve_trigger;
  watcher.storedifferentobject = 1;
  self notify("zmb_lost_knife");
}

create_use_weapon_object_watcher(name, weapon, ownerteam) {
  weaponobjectwatcher = create_weapon_object_watcher(name, weapon, ownerteam);
  return weaponobjectwatcher;
}

weapon_detonate(attacker) {
  if(isDefined(attacker))
    self detonate(attacker);
  else
    self detonate();
}

create_weapon_object_watcher(name, weapon, ownerteam) {
  if(!isDefined(self.weaponobjectwatcherarray))
    self.weaponobjectwatcherarray = [];

  weaponobjectwatcher = get_weapon_object_watcher(name);

  if(!isDefined(weaponobjectwatcher)) {
    weaponobjectwatcher = spawnstruct();
    self.weaponobjectwatcherarray[self.weaponobjectwatcherarray.size] = weaponobjectwatcher;
  }

  if(getdvar(#"scr_deleteexplosivesonspawn") == "")
    setdvar("scr_deleteexplosivesonspawn", "1");

  if(getdvarint(#"scr_deleteexplosivesonspawn") == 1)
    weaponobjectwatcher delete_weapon_object_array();

  if(!isDefined(weaponobjectwatcher.objectarray))
    weaponobjectwatcher.objectarray = [];

  weaponobjectwatcher.name = name;
  weaponobjectwatcher.ownerteam = ownerteam;
  weaponobjectwatcher.type = "use";
  weaponobjectwatcher.weapon = weapon;
  weaponobjectwatcher.watchforfire = 0;
  weaponobjectwatcher.disarmable = 0;
  weaponobjectwatcher.altdetonate = 0;
  weaponobjectwatcher.detectable = 1;
  weaponobjectwatcher.headicon = 1;
  weaponobjectwatcher.activatesound = undefined;
  weaponobjectwatcher.altweapon = undefined;
  weaponobjectwatcher.onspawn = undefined;
  weaponobjectwatcher.onspawnfx = undefined;
  weaponobjectwatcher.onspawnretrievetriggers = undefined;
  weaponobjectwatcher.ondetonated = undefined;
  weaponobjectwatcher.detonate = undefined;
  return weaponobjectwatcher;
}

setup_retrievable_watcher() {
  for(i = 0; i < level.retrievableweapons.size; i++) {
    watcher = get_weapon_object_watcher_by_weapon(level.retrievableweapons[i]);

    if(!isDefined(watcher.onspawnretrievetriggers))
      watcher.onspawnretrievetriggers = ::on_spawn_retrievable_weapon_object;

    if(!isDefined(watcher.pickup))
      watcher.pickup = ::pick_up;
  }
}

watch_weapon_object_usage() {
  self endon("death");
  self endon("disconnect");

  if(!isDefined(self.weaponobjectwatcherarray))
    self.weaponobjectwatcherarray = [];

  self thread watch_weapon_object_spawn();
  self thread watch_weapon_projectile_object_spawn();
  self thread watch_weapon_object_detonation();
  self thread watch_weapon_object_alt_detonation();
  self thread watch_weapon_object_alt_detonate();
  self thread delete_weapon_objects_on_disconnect();
}

watch_weapon_object_spawn() {
  self endon("disconnect");
  self endon("death");

  while(true) {
    self waittill("grenade_fire", weapon, weapname);
    watcher = get_weapon_object_watcher_by_weapon(weapname);

    if(isDefined(watcher))
      self add_weapon_object(watcher, weapon);
  }
}

watch_weapon_projectile_object_spawn() {
  self endon("disconnect");
  self endon("death");

  while(true) {
    self waittill("missile_fire", weapon, weapname);
    watcher = get_weapon_object_watcher_by_weapon(weapname);

    if(isDefined(watcher))
      self add_weapon_object(watcher, weapon);
  }
}

watch_weapon_object_detonation() {
  self endon("death");
  self endon("disconnect");

  while(true) {
    self waittill("detonate");
    weap = self getcurrentweapon();
    watcher = get_weapon_object_watcher_by_weapon(weap);

    if(isDefined(watcher))
      watcher detonate_weapon_object_array();
  }
}

watch_weapon_object_alt_detonation() {
  self endon("death");
  self endon("disconnect");
  self endon("no_alt_detonate");

  while(true) {
    self waittill("alt_detonate");

    for(watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
      if(self.weaponobjectwatcherarray[watcher].altdetonate)
        self.weaponobjectwatcherarray[watcher] detonate_weapon_object_array();
    }
  }
}

watch_weapon_object_alt_detonate() {
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  self endon("no_alt_detonate");

  for(;;) {
    self waittill("action_notify_use_doubletap");
    self notify("alt_detonate");
  }
}

delete_weapon_objects_on_disconnect() {
  self endon("death");
  self waittill("disconnect");

  if(!isDefined(self.weaponobjectwatcherarray)) {
    return;
  }
  watchers = [];

  for(watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
    weaponobjectwatcher = spawnstruct();
    watchers[watchers.size] = weaponobjectwatcher;
    weaponobjectwatcher.objectarray = [];

    if(isDefined(self.weaponobjectwatcherarray[watcher].objectarray))
      weaponobjectwatcher.objectarray = self.weaponobjectwatcherarray[watcher].objectarray;
  }

  wait 0.05;

  for(watcher = 0; watcher < watchers.size; watcher++)
    watchers[watcher] delete_weapon_object_array();
}

on_spawn_retrievable_weapon_object(watcher, player) {
  self endon("death");
  self setowner(player);
  self.owner = player;
  self waittill_not_moving();
  triggerorigin = self.origin;
  triggerparentent = undefined;

  if(isDefined(self.stucktoplayer)) {
    if(isalive(self.stucktoplayer) || !isDefined(self.stucktoplayer.body))
      triggerparentent = self.stucktoplayer;
    else
      triggerparentent = self.stucktoplayer.body;
  }

  if(isDefined(triggerparentent))
    triggerorigin = triggerparentent.origin + vectorscale((0, 0, 1), 10.0);
  else {
    up = anglestoup(self.angles);
    triggerorigin = self.origin + up;
  }

  self.pickuptrigger = spawn("trigger_radius_use", triggerorigin);
  self.pickuptrigger setcursorhint("HINT_NOICON");

  if(isDefined(level.retrievehints[watcher.name]))
    self.pickuptrigger sethintstring(level.retrievehints[watcher.name].hint);
  else
    self.pickuptrigger sethintstring(&"WEAPON_GENERIC_PICKUP");

  player clientclaimtrigger(self.pickuptrigger);
  self.pickuptrigger enablelinkto();
  self.pickuptrigger linkto(self);
  thread watch_use_trigger(self.pickuptrigger, watcher.pickup);

  if(isDefined(watcher.pickup_trigger_listener))
    self thread[[watcher.pickup_trigger_listener]](self.pickuptrigger, player);

  self thread watch_shutdown(player);
}

weapons_get_dvar_int(dvar, def) {
  return int(weapons_get_dvar(dvar, def));
}

weapons_get_dvar(dvar, def) {
  if(getdvar(dvar) != "")
    return getdvarfloat(dvar);
  else {
    setdvar(dvar, def);
    return def;
  }
}

get_weapon_object_watcher(name) {
  if(!isDefined(self.weaponobjectwatcherarray))
    return undefined;

  for(watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
    if(self.weaponobjectwatcherarray[watcher].name == name)
      return self.weaponobjectwatcherarray[watcher];
  }

  return undefined;
}

get_weapon_object_watcher_by_weapon(weapon) {
  if(!isDefined(self.weaponobjectwatcherarray))
    return undefined;

  for(watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
    if(isDefined(self.weaponobjectwatcherarray[watcher].weapon) && self.weaponobjectwatcherarray[watcher].weapon == weapon)
      return self.weaponobjectwatcherarray[watcher];

    if(isDefined(self.weaponobjectwatcherarray[watcher].weapon) && isDefined(self.weaponobjectwatcherarray[watcher].altweapon) && self.weaponobjectwatcherarray[watcher].altweapon == weapon)
      return self.weaponobjectwatcherarray[watcher];
  }

  return undefined;
}

pick_up() {
  player = self.owner;
  self destroy_ent();
  clip_ammo = player getweaponammoclip(self.name);
  clip_max_ammo = weaponclipsize(self.name);

  if(clip_ammo < clip_max_ammo)
    clip_ammo++;

  player setweaponammoclip(self.name, clip_ammo);
}

destroy_ent() {
  self delete();
}

add_weapon_object(watcher, weapon) {
  watcher.objectarray[watcher.objectarray.size] = weapon;
  weapon.owner = self;
  weapon.detonated = 0;
  weapon.name = watcher.weapon;

  if(!is_true(watcher.skip_weapon_object_damage))
    weapon thread weapon_object_damage(watcher);

  weapon.owner notify("weapon_object_placed", weapon);

  if(isDefined(watcher.onspawn))
    weapon thread[[watcher.onspawn]](watcher, self);

  if(isDefined(watcher.onspawnfx))
    weapon thread[[watcher.onspawnfx]]();

  if(isDefined(watcher.onspawnretrievetriggers))
    weapon thread[[watcher.onspawnretrievetriggers]](watcher, self);

  refreshhudammocounter();
}

detonate_weapon_object_array() {
  if(isDefined(self.disabledetonation) && self.disabledetonation) {
    return;
  }
  if(isDefined(self.objectarray)) {
    for(i = 0; i < self.objectarray.size; i++) {
      if(isDefined(self.objectarray[i]))
        self thread wait_and_detonate(self.objectarray[i], 0.1);
    }
  }

  self.objectarray = [];
}

delete_weapon_object_array() {
  if(isDefined(self.objectarray)) {
    for(i = 0; i < self.objectarray.size; i++) {
      if(isDefined(self.objectarray[i]))
        self.objectarray[i] delete();
    }
  }

  self.objectarray = [];
}

watch_use_trigger(trigger, callback) {
  self endon("delete");
  self endon("death");

  while(true) {
    trigger waittill("trigger", player);

    if(!isalive(player)) {
      continue;
    }
    if(!player isonground()) {
      continue;
    }
    if(isDefined(trigger.triggerteam) && player.pers["team"] != trigger.triggerteam) {
      continue;
    }
    if(isDefined(trigger.claimedby) && player != trigger.claimedby) {
      continue;
    }
    if(player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed())
      self thread[[callback]]();
  }
}

watch_shutdown(player) {
  player endon("disconnect");
  pickuptrigger = self.pickuptrigger;
  self waittill("death");
  pickuptrigger delete();
}

weapon_object_damage(watcher) {
  self endon("death");
  self setcandamage(1);
  self.health = 100000;
  attacker = undefined;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, weaponname, idflags);

    if(!isDefined(self.allowaitoattack)) {
      if(!isplayer(attacker))
        continue;
    }

    if(damage < 5) {
      if(isDefined(watcher.specialgrenadedisabledtime))
        self thread disabled_by_special_grenade(watcher.specialgrenadedisabledtime);

      continue;
    }

    break;
  }

  if(level.weaponobjectexplodethisframe)
    wait(0.1 + randomfloat(0.4));
  else
    wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  level.weaponobjectexplodethisframe = 1;
  thread reset_weapon_object_explode_this_frame();

  if(isDefined(type) && (issubstr(type, "MOD_GRENADE_SPLASH") || issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE")))
    self.waschained = 1;

  if(isDefined(idflags) && idflags & level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  self.wasdamaged = 1;
  watcher thread wait_and_detonate(self, 0.0, attacker);
}

wait_and_detonate(object, delay, attacker) {
  object endon("death");

  if(delay)
    wait(delay);

  if(object.detonated) {
    return;
  }
  if(!isDefined(self.detonate)) {
    return;
  }
  object.detonated = 1;
  object notify("detonated");
  object[[self.detonate]](attacker);
}

disabled_by_special_grenade(disabletime) {
  self notify("damagedBySpecial");
  self endon("damagedBySpecial");
  self endon("death");
  self.disabledbyspecial = 1;
  wait(disabletime);
  self.disabledbyspecial = 0;
}

reset_weapon_object_explode_this_frame() {
  wait 0.05;
  level.weaponobjectexplodethisframe = 0;
}

stunstart(watcher, time) {
  self endon("death");

  if(self isstunned()) {
    return;
  }
  if(isDefined(self.camerahead))
    self.camerahead setclientflag(level.const_flag_stunned);

  self setclientflag(level.const_flag_stunned);

  if(isDefined(watcher.stun))
    self thread[[watcher.stun]]();

  if(isDefined(time))
    wait(time);
  else
    return;

  self stunstop();
}

stunstop() {
  self notify("not_stunned");

  if(isDefined(self.camerahead))
    self.camerahead clearclientflag(level.const_flag_stunned);

  self clearclientflag(level.const_flag_stunned);
}

weaponstun() {
  self endon("death");
  self endon("not_stunned");
  origin = self gettagorigin("tag_fx");

  if(!isDefined(origin))
    origin = self.origin + vectorscale((0, 0, 1), 10.0);

  self.stun_fx = spawn("script_model", origin);
  self.stun_fx setmodel("tag_origin");
  self thread stunfxthink(self.stun_fx);
  wait 0.1;
  playfxontag(level._equipment_spark_fx, self.stun_fx, "tag_origin");
  self.stun_fx playsound("dst_disable_spark");
}

stunfxthink(fx) {
  fx endon("death");
  self waittill_any("death", "not_stunned");
  fx delete();
}

isstunned() {
  return isDefined(self.stun_fx);
}