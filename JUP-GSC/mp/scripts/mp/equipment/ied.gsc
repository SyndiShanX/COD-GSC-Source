/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\ied.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\perks\perk_equipmentping;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\weapons;
#namespace ied;

function ied_used(grenade) {
  self endon("disconnect");
  grenade endon("death");

  if(issharedfuncdefined(#"hash_d8976e21a6adafba", #"hash_ca0042e3cac99672")) {
    grenade[[getsharedfunc(#"hash_d8976e21a6adafba", #"hash_ca0042e3cac99672")]](grenade);
  }

  grenade.bundle = scripts\mp\equipment::function_2113b6f7cb462692(grenade.weapon_name);
  printgameaction("IED thrown", grenade.owner);
  grenade scripts\cp_mp\ent_manager::registerspawn(1, &function_5481370bf1e83031);

  if(_hasperk("specialty_rugged_eqp")) {
    grenade.hasruggedeqp = 1;
  }

  grenade thread minedamagemonitor();
  grenade thread function_ebd3dd21ad253364();
  grenade thread function_43018577e4dd0c6e();
  grenade thread scripts\mp\equipment_interact::remoteinteractsetup(&ied_detonate, 1, 1);
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);
  grenade waittill("missile_stuck");
  grenade.stucktime = gettime();
  grenade thread function_58606993710db8de();
  grenade setotherent(self);
  grenade setnodeploy(1);
  onequipmentplanted(grenade, "equip_ied", &ied_delete);
  thread monitordisownedequipment(self, grenade);
  grenade scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", grenade.owner, 1);
  grenade function_641996b5e113c5c6(grenade, &function_4260b88126e41b5d);
  grenade thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  grenade setscriptablepartstate("effects", "plant", 0);
  thread scripts\mp\weapons::outlineequipmentforowner(grenade);
  grenade missilethermal();
  grenade missileoutline();
  grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0, undefined, undefined, undefined, 0.1, 1);
  grenade function_1a0e37df908265ce();
}

function function_1a0e37df908265ce() {
  if(istrue(level.dangerzoneskipequipment)) {
    return;
  }

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
  }

  var_d8695b9748c307be = (self.origin[0], self.origin[1], self.origin[2] - 50);
  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(var_d8695b9748c307be, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 100, self.owner.team, undefined, self.owner, 0, self, 1);
}

function function_58606993710db8de() {
  self endon("death");

  while(true) {
    self waittill("trigger_grenade", ents);
    assert(isDefined(ents));

    if(!function_87eebc132ad2bbb0()) {
      continue;
    }

    foreach(ent in ents) {
      if(isagent(ent) || isPlayer(ent)) {
        if(!isreallyalive(ent)) {
          continue;
        }

        thread ied_detonate();
        return;
      }
    }
  }
}

function function_43018577e4dd0c6e() {
  self endon("death");
  self waittill("mine_destroyed");
  thread ied_destroy();
}

function ied_detonate(attacker) {
  self endon("death");
  self.owner endon("disconnect");

  if(isDefined(attacker)) {
    attacker endon("disconnect");
  } else {
    attacker = self.owner;
  }

  self setscriptablepartstate("effects", "trigger", 0);
  detonationdelay = default_to(self.bundle.ied_detonationdelay, 0.5);
  wait detonationdelay;
  thread ied_explode(attacker);
}

function ied_explode(attacker) {
  printgameaction("IED triggered", self.owner);
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

  thread ied_delete(deletiondelay);
  self setentityowner(attacker);
  self clearscriptabledamageowner();
  self setscriptablepartstate("effects", statename, 0);
}

function function_5481370bf1e83031() {
  thread ied_delete();
}

function ied_destroy(attacker) {
  thread ied_delete(5);
  self setscriptablepartstate("effects", "destroy", 0);
  self setscriptablepartstate("hacked", "neutral", 0);
}

function ied_delete(deletiondelay) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setscriptablepartstate("hack_usable", "off");
  self setCanDamage(0);
  scripts\cp_mp\ent_manager::deregisterspawn();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
    self.dangerzone = undefined;
  }

  owner = self.owner;

  if(isDefined(owner)) {
    owner removeequip(self);
  }

  thread function_921422f5877505e8();

  if(issharedfuncdefined(#"hash_d8976e21a6adafba", #"hash_c33ceb91d0ca7a9d")) {
    self[[getsharedfunc(#"hash_d8976e21a6adafba", #"hash_c33ceb91d0ca7a9d")]](self);
  }

  if(isDefined(deletiondelay)) {
    wait deletiondelay;
  }

  if(isDefined(self)) {
    self delete();
  }
}

function function_921422f5877505e8() {
  self endon("death");
  wait 0.5;
  parent = self getlinkedparent();

  if(isDefined(parent)) {
    parent waittill("death");
    self setscriptablepartstate("effects", "neutral", 0);
  }
}

function function_4260b88126e41b5d(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  self notify("enemy_destroyed_equipment", attacker);

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

  thread ied_destroy(attacker);
}

function function_7f534465d312ec86(data) {
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

  ied_explode(attacker);
}

function ied_disable(attacker) {
  self endon("death");
  attacker thread scripts\mp\utility\points::doscoreevent(#"disabled_c4");
  self.isdisabled = 1;
  self setscriptablepartstate("emp", "on", 0);
  wait 6;
  self setscriptablepartstate("emp", "off", 0);
  self.isdisabled = 0;
}

function function_ebd3dd21ad253364() {
  self endon("death");
  level waittill_any_2("game_ended", "bro_shot_start");
  thread ied_destroy();
}

function function_87eebc132ad2bbb0() {
  if(istrue(self.isdisabled) || istrue(self.isjammed)) {
    return false;
  }

  activationdelay = default_to(self.bundle.ied_activationdelay, 0.5);
  return isDefined(self.stucktime) && (gettime() - self.stucktime) / 1000 > activationdelay;
}

function function_f85453705ce0972a(oldowner) {
  if(istrue(self.exploding)) {
    return;
  }

  thread ied_destroy();
}