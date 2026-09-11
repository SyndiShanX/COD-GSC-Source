/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\c4.gsc
***********************************************/

function c4_set(var0, var1) {
  level.brmini_cleanupents = getdvarfloat("scr_equip_c4_alt_detonate_delay", 0.75);
  thread c4_watchforaltdetonation();
}

function c4_used(var0) {
  self endon("disconnect");
  var0 endon("death");
  scripts\mp\utility\print::printgameaction("c4 spawn", var0.owner);
  var0.throwtime = gettime();
  var0 scripts\cp_mp\ent_manager::registerspawn(1, &sweepc4);
  c4_addtoarray(var0.owner, var0);
  thread c4_watchfordetonation();
  thread c4_watchforaltdetonation();

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp")) {
    var0.hasruggedeqp = 1;
  }

  var0 thread scripts\mp\weapons::minedamagemonitor();
  thread c4_explodeonnotify();
  thread c4_destroyongameend();
  var0 thread scripts\mp\equipment_interact::remoteinteractsetup(&c4_detonate, 1, 0);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var0);
  var0 waittill("missile_stuck");
  var0 setotherent(self);
  var0 setnodeploy(1);
  scripts\mp\weapons::onequipmentplanted(var0, "equip_c4", &c4_delete);
  thread scripts\mp\weapons::monitordisownedequipment(self, var0);
  var0 thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  var0 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var0.owner, 1);
  var0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&c4_empapplied);
  var0 thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  var0 setscriptablepartstate("effects", "plant", 0);
  thread scripts\mp\weapons::outlineequipmentforowner(var0);
  var0 missilethermal();
  var0 missileoutline();
  var0.headiconid = var0 scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0, undefined, undefined, undefined, 0.1, 1);
  c4_updatedangerzone(var0);
}

function c4_updatedangerzone() {
  if(istrue(level.iscacprimaryweapongroup)) {
    return;
  }

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
  }

  var0 = (self.origin[0], self.origin[1], self.origin[2] - 50);
  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(var0, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 100, self.owner.team, undefined, self.owner, 0, self, 1);
}

function c4_detonate(var0) {
  self endon("death");
  self.owner endon("disconnect");

  if(isDefined(var0)) {
    var0 endon("disconnect");
  } else {
    var0 = self.owner;
  }

  wait 0.1;
  thread c4_explode(var0);
}

function c4_explode(var0) {
  scripts\mp\utility\print::printgameaction("c4 triggered", self.owner);
  level notify("explosion_extinguish", self.origin, 256, self.owner, self);
  var1 = undefined;
  var2 = undefined;
  var3 = self.origin;
  var4 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 1, 0, 0, 0);
  var5 = vectordot((0, 0, 1), anglestoup(self.angles));

  if(abs(var5) <= 0.81915) {
    var6 = var3 - anglestoup(self.angles) * 5;
    var7 = physics_raycast(var3, var6, var4, self, 0, "physicsquery_closest", 1);

    if(isDefined(var7) && var7.size > 0) {
      var1 = 5;
      var2 = "explodeWall";
    }
  } else if(var5 <= -0.96592) {
    var6 = var3 - anglestoup(self.angles) * 5;
    var7 = physics_raycast(var3, var6, var4, self, 0, "physicsquery_closest", 1);

    if(isDefined(var7) && var7.size > 0) {
      var1 = 5;
      var2 = "explodeWall";
    }
  }

  if(!isDefined(var1)) {
    var6 = var3 - (0, 0, 20);
    var7 = physics_raycast(var3, var6, var4, self, 0, "physicsquery_closest", 1);

    if(!isDefined(var7) || var7.size <= 0) {
      var1 = 5;
      var2 = "explodeAir";
    }
  }

  if(!isDefined(var1)) {
    var1 = 5;
    var2 = "explode";
  }

  thread c4_delete(var1);
  self setentityowner(var0);
  self clearscriptabledamageowner();
  self setscriptablepartstate("effects", var2, 0);
}

function sweepc4() {
  thread c4_delete();
}

function c4_destroy(var0) {
  thread c4_delete(5);
  self setscriptablepartstate("effects", "destroy", 0);
  self setscriptablepartstate("hacked", "neutral", 0);
}

function c4_delete(var0) {
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

  var1 = self.owner;

  if(isDefined(var1)) {
    c4_removefromarray(var1, self, self getentitynumber());
    var1 scripts\mp\weapons::removeequip(self);
    var1 notify("c4_update", 0);
  }

  thread c4_resetscriptableonunlink();

  if(isDefined(var0)) {
    wait var0;
  }

  self delete();
}

function c4_resetscriptableonunlink() {
  self endon("death");
  wait 0.5;
  var0 = self getlinkedparent();

  if(isDefined(var0)) {
    var0 waittill("death");
    self setscriptablepartstate("effects", "neutral", 0);
    return;
  }
}

function c4_explodeonnotify() {
  self endon("death");
  level endon("game_ended");
  var0 = self.owner;
  self waittill("detonateExplosive", var1);

  if(isDefined(var1)) {
    thread c4_explode(var1);
    return;
  }

  thread c4_explode(var0);
}

function c4_empapplied(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var1))) {
    var1 notify("destroyed_equipment");
    var1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  var3 = "";

  if(istrue(self.hasruggedeqp)) {
    var3 = "hitequip";
  }

  if(isPlayer(var1)) {
    var1 scripts\mp\damagefeedback::updatedamagefeedback(var3);
  }

  thread c4_destroy();
}

function c4_destroyongameend() {
  self endon("death");
  level scripts\engine\utility::ref_143a5("game_ended", "bro_shot_start");
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

  var0 = gettime();
  var1 = 0;
  var2 = level.framedurationseconds;

  for(;;) {
    if(self useButtonPressed()) {
      var1 = 0;

      while(self useButtonPressed()) {
        var1 += var2;
        wait var2;
      }

      if(var1 >= 0.5) {
        continue;
      }

      var1 = 0;

      while(!self useButtonPressed() && var1 < 0.25) {
        var1 += var2;
        wait var2;
      }

      if(var1 >= 0.25) {
        continue;
      }

      if(c4_validdetonationstate()) {
        self playsoundtoplayer("breach_warning_beep_01", self);

        while(gettime() - var0 <= level.brmini_cleanupents * 1000) {
          waitframe();
        }

        thread c4_detonateall();
      }
    }

    waitframe();
  }
}

function c4_animdetonate() {
  var0 = getcompleteweaponname("c4_empty_mp");
  self giveandfireoffhand(var0);
  thread c4_animdetonatecleanup();
}

function c4_animdetonatecleanup() {
  self endon("death_or_disconnect");
  self notify("c4_animDetonateCleanup()");
  self endon("c4_animDetonateCleanup()");
  var0 = getcompleteweaponname("c4_empty_mp");
  wait 1;

  if(self hasweapon(var0)) {
    self takeweapon(var0);
    return;
  }
}

function c4_detonateall() {
  if(isDefined(self.c4s)) {
    foreach(var1 in self.c4s) {
      if(c4_candetonate(var1)) {
        thread c4_detonate();
      }
    }

    return;
  }
}

function c4_onownerchanged(var0) {
  if(istrue(self.exploding)) {
    return;
  }

  c4_removefromarray(var0, self, self getentitynumber());
  thread c4_destroy();
}

function c4_resetaltdetonpickup() {
  if(scripts\mp\equipment::hasequipment("equip_c4")) {
    thread c4_watchforaltdetonation();
    return;
  }
}

function c4_addtoarray(var0, var1) {
  if(!isDefined(var0.c4s)) {
    var0.c4s = [];
  }

  var2 = var1 getentitynumber();
  var0.c4s[var2] = var1;
  thread c4_removefromarrayondeath(var0, var1, var2);
}

function c4_removefromarray(var0, var1, var2) {
  if(isDefined(var1)) {
    var1 notify("c4_removeFromArray");
  }

  if(isDefined(var0) && isDefined(var0.c4s)) {
    var0.c4s[var2] = undefined;
    return;
  }
}

function c4_removefromarrayondeath(var0, var1, var2) {
  var1 endon("c4_removeFromArray");
  var0 endon("disconnect");
  var1 waittill("death");
  thread c4_removefromarray(var0, var1, var2);
}