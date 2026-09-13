/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_c4.gsc
***********************************************/

c4_used(grenade) {
  self endon("disconnect");
  grenade endon("death");
  grenade thread c4_deleteonownerdisconnect(self);
  grenade.throwtime = gettime();
  grenade.deletefunc = ::c4_delete;
  c4_addtoarray(grenade);
  thread c4_watchfordetonation();
  thread c4_watchforaltdetonation();
  grenade thread c4_explodeonnotify();
  grenade waittill("missile_stuck", stuckto, _id_1D9FB21B4F3023F3, surfacetype, velocity, position, normal);
  _id_74502A9E0EF1F19C::onlethalequipmentplanted(grenade, "power_c4");
  thread _id_74502A9E0EF1F19C::monitordisownedequipment(self, grenade);

  if(isDefined(grenade.owner) && !istrue(grenade.owner._id_95F9DA0E6A58183B))
    grenade thread scripts\cp\cp_equipment::makeexplosiveusabletag("tag_use", 1);

  grenade setscriptablepartstate("effects", "plant", 0);
  grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0, undefined, undefined, undefined, 0.1, 1);
}

c4_detonate() {
  self endon("death");
  self.owner endon("disconnect");
  wait 0.1;
  thread c4_explode(self.owner);
}

c4_explode(attacker) {
  thread c4_delete(5);
  name = "noname";

  if(isDefined(attacker.name))
    name = attacker.name;

  level notify("grenade_exploded_during_stealth", self, "c4_mp", name);
  self setentityowner(attacker);
  self setscriptablepartstate("effects", "explode", 0);
}

c4_destroy(attacker) {
  thread c4_delete(2);
  self setscriptablepartstate("effects", "destroy", 0);
}

c4_delete(_id_CBF7BE4F62A0DDB2) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  _id_74502A9E0EF1F19C::makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;
  owner = self.owner;

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    owner.plantedlethalequip = scripts\engine\utility::array_remove(owner.plantedlethalequip, self);
    owner notify("c4_update", 0);
  }

  if(isDefined(_id_CBF7BE4F62A0DDB2))
    wait(_id_CBF7BE4F62A0DDB2);

  self delete();
}

c4_explodeonnotify() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  owner = self.owner;
  self waittill("detonateExplosive", attacker);

  if(isDefined(attacker))
    thread c4_explode(attacker);
  else
    thread c4_explode(owner);
}

c4_destroyonemp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_damage", attacker, duration);

  if(isDefined(self.owner) && attacker != self.owner)
    attacker notify("destroyed_equipment");

  thread c4_destroy();
}

c4_candetonate(grenade) {
  return (gettime() - self.throwtime) / 1000 > 0.3 && !isDefined(self.detonationtime);
}

c4_watchfordetonation() {
  self endon("death_or_disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForDetonation");
  self endon("watchForDetonation");

  for(;;) {
    self waittill("detonate");
    _id_F24845EEAEEDC946 = self getheldoffhand();
    _id_49E6EF3EDADD524E = _func_F581838CE4328F7A(_id_F24845EEAEEDC946);

    if(_id_F24845EEAEEDC946.basename == "c4_mp" || _id_F24845EEAEEDC946.basename == "c4_empty_mp" || _id_F24845EEAEEDC946.basename == "none" && isDefined(self.isusingcamera) && self.isusingcamera || _id_49E6EF3EDADD524E == "c4")
      thread c4_detonateall();
  }
}

c4_watchforaltdetonation() {
  self endon("death");
  self endon("disconnect");
  self endon("c4_unset");
  level endon("game_ended");

  if(!getdvarint("scr_altdetonationenabled", 0)) {
    return;
  }
  self notify("watchForAltDetonation");
  self endon("watchForAltDetonation");
  _id_8B07FA3892A3A8A4 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      _id_8B07FA3892A3A8A4 = 0;

      while(self useButtonPressed()) {
        _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + 0.05;
        wait 0.05;
      }

      if(_id_8B07FA3892A3A8A4 >= 0.5) {
        continue;
      }
      _id_8B07FA3892A3A8A4 = 0;

      while(!self useButtonPressed() && _id_8B07FA3892A3A8A4 < 0.5) {
        _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + 0.05;
        wait 0.05;
      }

      if(_id_8B07FA3892A3A8A4 >= 0.5) {
        continue;
      }
      thread c4_animdetonate();
    }

    wait 0.05;
  }
}

c4_animdetonate() {
  objweapon = makeweapon("c4_empty_mp");
  self giveandfireoffhand(objweapon);
  thread c4_animdetonatecleanup();
}

c4_animdetonatecleanup() {
  self endon("death_or_disconnect");
  self notify("c4_animDetonateCleanup()");
  self endon("c4_animDetonateCleanup()");
  objweapon = makeweapon("c4_empty_mp");
  wait 1;

  if(self hasweapon(objweapon))
    self takeweapon(objweapon);
}

c4_detonateall() {
  if(isDefined(self.c4s)) {
    foreach(c4 in self.c4s) {
      if(c4 c4_candetonate())
        c4 thread c4_detonate();
    }
  }
}

c4_addtoarray(grenade) {
  if(!isDefined(self.c4s))
    self.c4s = [];

  self.c4s[grenade getentitynumber()] = grenade;
  self _meth_BCC86382F02470E6(1);
  thread c4_removefromarrayondeath(grenade);
}

c4_removefromarray(entnum) {
  if(!isDefined(self.c4s)) {
    return;
  }
  self.c4s[entnum] = undefined;
  owner = self.owner;

  if(isDefined(owner) && isDefined(owner.c4s)) {
    foreach(c4 in owner.c4s) {
      if(isDefined(c4))
        return;
    }

    owner _meth_BCC86382F02470E6(0);
  }
}

c4_removefromarrayondeath(grenade) {
  self endon("disconnect");
  entnum = grenade getentitynumber();
  grenade waittill("death");
  c4_removefromarray(entnum);
}

c4_deleteonownerdisconnect(owner) {
  self endon("death");
  self endon("missile_stuck");
  owner waittill("disconnect");
  self delete();
}