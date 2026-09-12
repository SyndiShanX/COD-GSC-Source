/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\c4.gsc
***********************************************/

function c4_set(var_0, var_1) {
  level.brmini_cleanupents = getdvarfloat("scr_equip_c4_alt_detonate_delay", 0.75);
  thread c4_watchforaltdetonation();
}

function c4_used(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  scripts\mp\utility\print::printgameaction("c4 spawn", var_0.owner);
  var_0.throwtime = gettime();
  var_0 scripts\cp_mp\ent_manager::registerspawn(1, &sweepc4);
  c4_addtoarray(var_0.owner, var_0);
  thread c4_watchfordetonation();
  thread c4_watchforaltdetonation();

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp")) {
    var_0.hasruggedeqp = 1;
  }

  var_0 thread scripts\mp\weapons::minedamagemonitor();
  thread c4_explodeonnotify();
  thread c4_destroyongameend();
  var_0 thread scripts\mp\equipment_interact::remoteinteractsetup(&c4_detonate, 1, 0);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);
  var_0 waittill("missile_stuck");
  var_0 setotherent(self);
  var_0 setnodeploy(1);
  scripts\mp\weapons::onequipmentplanted(var_0, "equip_c4", &c4_delete);
  thread scripts\mp\weapons::monitordisownedequipment(self, var_0);
  var_0 thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  var_0 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var_0.owner, 1);
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&c4_empapplied);
  var_0 thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  var_0 setscriptablepartstate("effects", "plant", 0);
  thread scripts\mp\weapons::outlineequipmentforowner(var_0);
  var_0 missilethermal();
  var_0 missileoutline();
  var_0.headiconid = var_0 scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0, undefined, undefined, undefined, 0.1, 1);
  c4_updatedangerzone(var_0);
}

function c4_updatedangerzone() {
  if(istrue(level.iscacprimaryweapongroup)) {
    return;
  }

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
  }

  var_0 = (self.origin[0], self.origin[1], self.origin[2] - 50);
  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(var_0, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 100, self.owner.team, undefined, self.owner, 0, self, 1);
}

function c4_detonate(var_0) {
  self endon("death");
  self.owner endon("disconnect");

  if(isDefined(var_0)) {
    var_0 endon("disconnect");
  } else {
    var_0 = self.owner;
  }

  wait 0.1;
  thread c4_explode(var_0);
}

function c4_explode(var_0) {
  scripts\mp\utility\print::printgameaction("c4 triggered", self.owner);
  level notify("explosion_extinguish", self.origin, 256, self.owner, self);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = self.origin;
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 1, 0, 0, 0);
  var_5 = vectordot((0, 0, 1), anglestoup(self.angles));

  if(abs(var_5) <= 0.81915) {
    var_6 = var_3 - anglestoup(self.angles) * 5;
    var_7 = physics_raycast(var_3, var_6, var_4, self, 0, "physicsquery_closest", 1);

    if(isDefined(var_7) && var_7.size > 0) {
      var_1 = 5;
      var_2 = "explodeWall";
    }
  } else if(var_5 <= -0.96592) {
    var_6 = var_3 - anglestoup(self.angles) * 5;
    var_7 = physics_raycast(var_3, var_6, var_4, self, 0, "physicsquery_closest", 1);

    if(isDefined(var_7) && var_7.size > 0) {
      var_1 = 5;
      var_2 = "explodeWall";
    }
  }

  if(!isDefined(var_1)) {
    var_6 = var_3 - (0, 0, 20);
    var_7 = physics_raycast(var_3, var_6, var_4, self, 0, "physicsquery_closest", 1);

    if(!isDefined(var_7) || var_7.size <= 0) {
      var_1 = 5;
      var_2 = "explodeAir";
    }
  }

  if(!isDefined(var_1)) {
    var_1 = 5;
    var_2 = "explode";
  }

  thread c4_delete(var_1);
  self setentityowner(var_0);
  self clearscriptabledamageowner();
  self setscriptablepartstate("effects", var_2, 0);
}

function sweepc4() {
  thread c4_delete();
}

function c4_destroy(var_0) {
  thread c4_delete(5);
  self setscriptablepartstate("effects", "destroy", 0);
  self setscriptablepartstate("hacked", "neutral", 0);
}

function c4_delete(var_0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setscriptablepartstate("hack_usable", "off");
  self setCanDamage(0);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  scripts\cp_mp\ent_manager::deregisterspawn();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
    self.dangerzone = undefined;
  }

  var_1 = self.owner;

  if(isDefined(var_1)) {
    c4_removefromarray(var_1, self, self getentitynumber());
    var_1 scripts\mp\weapons::removeequip(self);
    var_1 notify("c4_update", 0);
  }

  thread c4_resetscriptableonunlink();

  if(isDefined(var_0)) {
    wait var_0;
  }

  self delete();
}

function c4_resetscriptableonunlink() {
  self endon("death");
  wait 0.5;
  var_0 = self getlinkedparent();

  if(isDefined(var_0)) {
    var_0 waittill("death");
    self setscriptablepartstate("effects", "neutral", 0);
    return;
  }
}

function c4_explodeonnotify() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  self waittill("detonateExplosive", var_1);

  if(isDefined(var_1)) {
    thread c4_explode(var_1);
    return;
  }

  thread c4_explode(var_0);
}

function c4_empapplied(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
    var_1 notify("destroyed_equipment");
    var_1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  var_3 = "";

  if(istrue(self.hasruggedeqp)) {
    var_3 = "hitequip";
  }

  if(isPlayer(var_1)) {
    var_1 scripts\mp\damagefeedback::updatedamagefeedback(var_3);
  }

  thread c4_destroy();
}

function c4_destroyongameend() {
  self endon("death");
  level scripts\engine\utility::ref_143A5("game_ended", "bro_shot_start");
  thread c4_destroy();
}

function c4_validdetonationstate() {
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return false;
  }

  if(scripts\mp\utility\player::isusingremote()) {
    return false;
  }

  if(!isDefined(self.c4s) || self.c4s.size <= 0) {
    return false;
  }

  return true;
}

function c4_candetonate() {
  return (gettime() - self.throwtime) / 1000 > 0.3;
}

function c4_watchfordetonation() {
  self endon("death_or_disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForDetonation");
  self endon("watchForDetonation");

  for(;;) {
    self waittill("detonate");

    if(self getheldoffhand().basename == "c4_mp_p" || self getheldoffhand().basename == "c4_empty_mp") {
      thread c4_detonateall();
    }
  }
}

function c4_watchforaltdetonation() {
  self endon("death_or_disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForAltDetonation");
  self endon("watchForAltDetonation");

  while(self useButtonPressed()) {
    waitframe();
  }

  var_0 = gettime();
  var_1 = 0;
  var_2 = level.framedurationseconds;

  for(;;) {
    if(self useButtonPressed()) {
      var_1 = 0;

      while(self useButtonPressed()) {
        var_1 += var_2;
        wait var_2;
      }

      if(var_1 >= 0.5) {
        continue;
      }

      var_1 = 0;

      while(!self useButtonPressed() && var_1 < 0.25) {
        var_1 += var_2;
        wait var_2;
      }

      if(var_1 >= 0.25) {
        continue;
      }

      if(c4_validdetonationstate()) {
        self playsoundtoplayer("breach_warning_beep_01", self);

        while(gettime() - var_0 <= level.brmini_cleanupents * 1000) {
          waitframe();
        }

        thread c4_detonateall();
      }
    }

    waitframe();
  }
}

function c4_animdetonate() {
  var_0 = getcompleteweaponname("c4_empty_mp");
  self giveandfireoffhand(var_0);
  thread c4_animdetonatecleanup();
}

function c4_animdetonatecleanup() {
  self endon("death_or_disconnect");
  self notify("c4_animDetonateCleanup()");
  self endon("c4_animDetonateCleanup()");
  var_0 = getcompleteweaponname("c4_empty_mp");
  wait 1;

  if(self hasweapon(var_0)) {
    self takeweapon(var_0);
    return;
  }
}

function c4_detonateall() {
  if(isDefined(self.c4s)) {
    foreach(var_1 in self.c4s) {
      if(c4_candetonate(var_1)) {
        thread c4_detonate();
      }
    }

    return;
  }
}

function c4_onownerchanged(var_0) {
  if(istrue(self.exploding)) {
    return;
  }

  c4_removefromarray(var_0, self, self getentitynumber());
  thread c4_destroy();
}

function c4_resetaltdetonpickup() {
  if(scripts\mp\equipment::hasequipment("equip_c4")) {
    thread c4_watchforaltdetonation();
    return;
  }
}

function c4_addtoarray(var_0, var_1) {
  if(!isDefined(var_0.c4s)) {
    var_0.c4s = [];
  }

  var_2 = var_1 getentitynumber();
  var_0.c4s[var_2] = var_1;
  thread c4_removefromarrayondeath(var_0, var_1, var_2);
}

function c4_removefromarray(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_1 notify("c4_removeFromArray");
  }

  if(isDefined(var_0) && isDefined(var_0.c4s)) {
    var_0.c4s[var_2] = undefined;
    return;
  }
}

function c4_removefromarrayondeath(var_0, var_1, var_2) {
  var_1 endon("c4_removeFromArray");
  var_0 endon("disconnect");
  var_1 waittill("death");
  thread c4_removefromarray(var_0, var_1, var_2);
}