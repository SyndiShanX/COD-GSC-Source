/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\c4.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\hud_message;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\perks\perk_equipmentping;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\weapons;
#namespace c4;

function c4_set(equipmentref, slot, variantid) {
  bundle = level.equipment.table[equipmentref].bundle;

  if(isDefined(self.c4s) && self.c4s.size > 0) {
    thread c4_watchfordetonation(bundle);
  }

  thread c4_watchforaltdetonation(bundle);
}

function c4_used(grenade) {
  self endon("disconnect");
  grenade endon("death");
  printgameaction("c4 spawn", grenade.owner);

  if(issharedfuncdefined(#"hash_d8976e21a6adafba", #"hash_ca0042e3cac99672")) {
    grenade[[getsharedfunc(#"hash_d8976e21a6adafba", #"hash_ca0042e3cac99672")]](grenade);
  }

  grenade.bundle = scripts\mp\equipment::getequipmentbundlefromweaponname(grenade.weapon_name);
  grenade.var_e73a396a2a6b1d56 = istrue(grenade.bundle.var_f9f61f3d350beae0);
  grenade.throwtime = gettime();
  grenade scripts\cp_mp\ent_manager::registerspawn(1, &sweepc4);
  c4_addtoarray(grenade.owner, grenade);
  thread c4_watchfordetonation(grenade.bundle);
  thread c4_watchforaltdetonation(grenade.bundle);

  if(_hasperk("specialty_rugged_eqp")) {
    grenade.hasruggedeqp = 1;
  }

  grenade thread minedamagemonitor();
  grenade thread c4_explodeonnotify();
  grenade thread c4_destroyongameend();
  grenade thread scripts\mp\equipment_interact::remoteinteractsetup(&c4_detonate, 1, 0);
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);
  grenade waittill("missile_stuck");

  if(isDefined(level.var_ca4e08767cbdae12)) {
    canplant = grenade[[level.var_ca4e08767cbdae12]]();

    if(!canplant) {
      scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
      scripts\mp\equipment::incrementequipmentslotammo("primary");
      grenade delete();
      return;
    }
  }

  grenade setotherent(self);
  grenade setnodeploy(1);
  onequipmentplanted(grenade, "equip_c4", &c4_delete);
  thread monitordisownedequipment(self, grenade);
  grenade thread makeexplosiveusabletag("tag_use", 1);
  grenade scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", grenade.owner, 1);
  grenade.stucktime = gettime();
  grenade.owner setclientomnvar("ui_mgl_c4_state", 1);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    grenade[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&c4_empapplied);
  }

  if(issharedfuncdefined("emp", "setEMP_Cleared_Callback")) {
    grenade[[getsharedfunc("emp", "setEMP_Cleared_Callback")]](&function_f8ffbf95c0890c91);
  }

  grenade function_641996b5e113c5c6(grenade, &c4_empapplied);
  grenade scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_3f54618ac84aa89f);
  grenade function_49197cd063a740ea(&c4_destroy);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators) {
      elevators thread scripts\common\elevators::isentitytouchingdoortrigger(grenade);
    }
  }

  grenade thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  grenade setscriptablepartstate("effects", "plant", 0);
  thread scripts\mp\weapons::outlineequipmentforowner(grenade);
  grenade missilethermal();
  grenade missileoutline();
  grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0, undefined, undefined, undefined, 0.1, 1);
  grenade c4_updatedangerzone();
}

function c4_updatedangerzone() {
  if(istrue(level.dangerzoneskipequipment)) {
    return;
  }

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
  }

  var_d8695b9748c307be = (self.origin[0], self.origin[1], self.origin[2] - 50);
  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(var_d8695b9748c307be, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 100, self.owner.team, undefined, self.owner, 0, self, 1);
}

function c4_detonate(attacker) {
  self endon("death");
  self.owner endon("disconnect");

  if(isDefined(attacker)) {
    attacker endon("disconnect");
  } else {
    attacker = self.owner;
  }

  if(istrue(self.bundle.var_1a27e2391b89641e)) {
    self setscriptablepartstate("effects", "warningTrigger", 0);
  }

  detonation_delay = default_to(self.bundle.c4_detonationdelay, 0.1);
  wait detonation_delay;
  thread c4_explode(attacker);
}

function c4_explode(attacker) {
  printgameaction("c4 triggered", self.owner);
  level notify("explosion_extinguish", self.origin, 256, self.owner, self);
  deletiondelay = undefined;
  statename = undefined;
  caststart = self.origin;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 1, 0, 0, 0);
  updot = vectordot((0, 0, 1), anglestoup(self.angles));

  if(abs(updot) <= 0.81915) {
    castend = caststart - anglestoup(self.angles) * 5;
    castresults = physics_raycast(caststart, castend, contents, self, 0, "physicsquery_closest", 1);

    if(isDefined(castresults) && castresults.size > 0) {
      deletiondelay = 5;
      statename = "explode";
    }
  } else if(updot <= -0.96592) {
    castend = caststart - anglestoup(self.angles) * 5;
    castresults = physics_raycast(caststart, castend, contents, self, 0, "physicsquery_closest", 1);

    if(isDefined(castresults) && castresults.size > 0) {
      deletiondelay = 5;
      statename = "explode";
    }
  }

  if(!isDefined(deletiondelay)) {
    castend = caststart - (0, 0, 1) * 20;
    castresults = physics_raycast(caststart, castend, contents, self, 0, "physicsquery_closest", 1);

    if(!isDefined(castresults) || castresults.size <= 0) {
      deletiondelay = 5;
      statename = "explodeAir";
    }
  }

  if(!isDefined(deletiondelay)) {
    deletiondelay = 5;
    statename = "explode";
  }

  if(getdvarint(@ "mgl", 0)) {
    thread scripts\common\ai::mgladdactivesmoke(self.origin, 2);
  }

  self setentityowner(attacker);
  self clearscriptabledamageowner();
  self setscriptablepartstate("effects", statename, 0);

  if(istrue(self.var_e73a396a2a6b1d56)) {
    radius = self.bundle.c4_radius;
    innerdamage = self.bundle.var_6ace4783c4cf0969;
    outerdamage = self.bundle.var_c28313493ecca6a;
    self radiusdamage(self.origin, radius, innerdamage, outerdamage, attacker, "MOD_EXPLOSIVE", self.weapon_object);
  }

  thread c4_delete(deletiondelay);
}

function sweepc4() {
  thread c4_delete();
}

function c4_destroy(attacker) {
  thread c4_delete(5);
  self setscriptablepartstate("effects", "destroy", 0);
  self setscriptablepartstate("hacked", "neutral", 0);
}

function c4_delete(deletiondelay) {
  if(!isDefined(self) || isDefined(self) && istrue(self.isdestroyed)) {
    return;
  }

  self.isdestroyed = 1;
  self.exploding = 1;
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setscriptablepartstate("hack_usable", "off");
  self setCanDamage(0);
  makeexplosiveunusuabletag();
  scripts\cp_mp\ent_manager::deregisterspawn();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
    self.dangerzone = undefined;
  }

  owner = self.owner;

  if(isDefined(owner)) {
    c4_removefromarray(owner, self, self getentitynumber());
    owner setclientomnvar("ui_mgl_c4_state", 0);
    owner removeequip(self);
    owner notify("c4_update", 0);
  }

  thread c4_resetscriptableonunlink();

  if(issharedfuncdefined(#"hash_d8976e21a6adafba", #"hash_c33ceb91d0ca7a9d")) {
    self[[getsharedfunc(#"hash_d8976e21a6adafba", #"hash_c33ceb91d0ca7a9d")]](self);
  }

  function_83cebe0ae5318a7f(self);

  if(isDefined(deletiondelay)) {
    wait deletiondelay;
  }

  if(isDefined(self)) {
    self delete();
  }
}

function c4_resetscriptableonunlink() {
  self endon("death");
  wait 0.5;

  if(!isDefined(self)) {
    return;
  }

  parent = self getlinkedparent();

  if(isDefined(parent)) {
    parent waittill("death");

    if(isDefined(self)) {
      self setscriptablepartstate("effects", "neutral", 0);
    }
  }
}

function c4_explodeonnotify() {
  self endon("death");
  level endon("game_ended");
  owner = self.owner;
  self waittill("detonateExplosive", attacker);

  if(isDefined(attacker)) {
    thread c4_explode(attacker);
    return;
  }

  thread c4_explode(owner);
}

function c4_empapplied(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  self notify("enemy_destroyed_equipment", attacker);

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, undefined, 1);
  }

  damagefeedback = "";

  if(istrue(self.hasruggedeqp)) {
    damagefeedback = "hitequip";
  }

  if(isPlayer(attacker)) {
    attacker updatedamagefeedback(damagefeedback);
  }

  if(isDefined(data.ksemp)) {
    thread c4_disable(attacker);
    return;
  }

  thread c4_disable(attacker);
}

function function_3f54618ac84aa89f(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  damagefeedback = "";

  if(istrue(self.hasruggedeqp)) {
    damagefeedback = "hitequip";
  }

  if(isPlayer(attacker)) {
    attacker updatedamagefeedback(damagefeedback);
  }

  c4_explode(attacker);
}

function c4_disable(attacker) {
  self endon("death");
  attacker thread scripts\mp\utility\points::doscoreevent(#"disabled_c4");
  self.isdisabled = 1;
  self setscriptablepartstate("emp", "on", 0);

  if(!istrue(self.owner.ksempd)) {
    wait 6;
    self setscriptablepartstate("emp", "off", 0);
    self.isdisabled = 0;
  }
}

function function_f8ffbf95c0890c91(data) {
  self setscriptablepartstate("emp", "off", 0);
  self.isdisabled = 0;
}

function c4_destroyongameend() {
  self endon("death");
  level waittill_any_2("game_ended", "bro_shot_start");
  thread c4_destroy();
}

function c4_validdetonationstate() {
  if(!isreallyalive(self)) {
    return false;
  }

  if(isusingremote()) {
    return false;
  }

  if(!isDefined(self.c4s) || self.c4s.size <= 0) {
    return false;
  }

  return true;
}

function c4_candetonate() {
  if(istrue(self.isdisabled) || istrue(self.isjammed)) {
    return false;
  }

  armtime = default_to(self.bundle.var_c121301f94125f32, 0) * 1000;

  if(isDefined(self.stucktime) && self.stucktime + armtime > gettime()) {
    self.owner scripts\mp\hud_message::showerrormessage("EQUIPMENT/C4_ARMING");
    return false;
  }

  return (gettime() - self.throwtime) / 1000 > 0.3;
}

function c4_watchfordetonation(bundle) {
  self endon("death_or_disconnect");
  var_8077ba6843ecc331 = 0;

  if(issharedfuncdefined("game", "isCommonItemEnabled")) {
    var_8077ba6843ecc331 = [[getsharedfunc("game", "isCommonItemEnabled")]]();
  }

  if(!var_8077ba6843ecc331) {
    self endon("equipment_taken_" + "equip_c4");
  }

  level endon("game_ended");
  self notify("watchForDetonation");
  self endon("watchForDetonation");
  weaponname = default_to(bundle.c4_weapon, "c4_mp");
  var_6969d6c5a2117c33 = default_to(bundle.var_58fe77f04882df7a, "c4_empty_mp");

  while(true) {
    self waittill("detonate");
    weaponrootname = getweaponrootstring(self getheldoffhand());

    if(self getheldoffhand().basename == weaponname || self getheldoffhand().basename == var_6969d6c5a2117c33 || self getheldoffhand().basename == "none" && isDefined(self.isusingcamera) && self.isusingcamera || weaponrootname == "c4") {
      thread c4_detonateall();
    }
  }
}

function c4_watchforaltdetonation(bundle) {
  self endon("death_or_disconnect");
  var_8077ba6843ecc331 = 0;

  if(issharedfuncdefined("game", "isCommonItemEnabled")) {
    var_8077ba6843ecc331 = [[getsharedfunc("game", "isCommonItemEnabled")]]();
  }

  if(isDefined(level.itemsisenabled)) {
    var_8077ba6843ecc331 = [[level.itemsisenabled]]();
  }

  if(!var_8077ba6843ecc331) {
    self endon("equipment_taken_" + "equip_c4");
  }

  level endon("game_ended");

  if(!getdvarint(@ "scr_altdetonationenabled", 0)) {
    return;
  }

  self notify("watchForAltDetonation");
  self endon("watchForAltDetonation");

  while(self useButtonPressed()) {
    waitframe();
  }

  starttime = gettime();
  buttontime = 0;
  updaterate = level.framedurationseconds;

  while(true) {
    if(self useButtonPressed()) {
      buttontime = 0;

      while(self useButtonPressed()) {
        buttontime += updaterate;
        wait updaterate;
      }

      if(buttontime >= 0.5) {
        continue;
      }

      buttontime = 0;

      while(!self useButtonPressed() && buttontime < 0.25) {
        buttontime += updaterate;
        wait updaterate;
      }

      if(buttontime >= 0.25) {
        continue;
      }

      if(c4_validdetonationstate()) {
        thread c4_animdetonate(bundle);
      }
    }

    waitframe();
  }
}

function c4_animdetonate(bundle) {
  var_6969d6c5a2117c33 = default_to(bundle.var_58fe77f04882df7a, "c4_empty_mp");
  objweapon = makeweapon(var_6969d6c5a2117c33);
  self giveandfireoffhand(objweapon);
  thread c4_animdetonatecleanup(bundle);
}

function c4_animdetonatecleanup(bundle) {
  self endon("death_or_disconnect");
  self notify("c4_animDetonateCleanup()");
  self endon("c4_animDetonateCleanup()");
  var_6969d6c5a2117c33 = default_to(bundle.var_58fe77f04882df7a, "c4_empty_mp");
  objweapon = makeweapon(var_6969d6c5a2117c33);
  wait 1;

  if(self hasweapon(objweapon)) {
    self takeweapon(objweapon);
  }
}

function c4_detonateall() {
  if(isDefined(self.c4s)) {
    foreach(c4 in self.c4s) {
      if(c4 c4_candetonate()) {
        c4 thread c4_detonate();
      }
    }
  }
}

function c4_onownerchanged(oldowner) {
  if(istrue(self.exploding)) {
    return;
  }

  c4_removefromarray(oldowner, self, self getentitynumber());
  sentientpool = self.sentientpool;
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  scripts\mp\sentientpoolmanager::registersentient(sentientpool, self.owner, 1);
  thread c4_destroy();
}

function c4_resetaltdetonpickup(bundle) {
  if(scripts\mp\equipment::hasequipment("equip_c4")) {
    thread c4_watchforaltdetonation(bundle);
  }
}

function function_49197cd063a740ea(callbackfunction) {
  self.elevatordoorsclosecallback = callbackfunction;
}

function c4_addtoarray(owner, grenade) {
  if(!isDefined(owner.c4s)) {
    owner.c4s = [];
  }

  entnum = grenade getentitynumber();
  owner.c4s[entnum] = grenade;
  owner function_bcc86382f02470e6(1);
  thread c4_removefromarrayondeath(owner, grenade, entnum);
}

function c4_removefromarray(owner, grenade, entnum) {
  if(isDefined(grenade)) {
    grenade notify("c4_removeFromArray");
  }

  if(isDefined(owner) && isDefined(owner.c4s)) {
    owner.c4s[entnum] = undefined;

    foreach(c4 in owner.c4s) {
      if(isDefined(c4)) {
        return;
      }
    }

    owner function_bcc86382f02470e6(0);
  }
}

function c4_removefromarrayondeath(owner, grenade, entnum) {
  grenade endon("c4_removeFromArray");
  owner endon("disconnect");
  grenade waittill("death");
  thread c4_removefromarray(owner, grenade, entnum);
}