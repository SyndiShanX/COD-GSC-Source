/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\weapon_drop.gsc
************************************************/

weapondrop_init() {
  level._effect["weapon_drop_impact"] = loadfx("vfx/iw9/killstreaks/smk_signal/vfx_carepkg_landing_dust.vfx");
}

weapondrop_beginsuper() {
  thread weapondrop_givedropweapon();
  return 1;
}

weapondrop_givedropweapon() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  waitframe();
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("weapondrop", self);
  streakinfo.deployweaponobj = makeweapon("deploy_weapondrop_mp");
  _id_3B64EB40368C1450::set("giveDropWeapon", "killstreaks", 0);
  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(streakinfo, streakinfo.deployweaponobj, "grenade_fire");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("giveDropWeapon");

  if(istrue(_id_9B1DEB5E9D32BBE3)) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
}

weapondrop_used(grenade) {
  level endon("game_ended");
  self endon("disconnect");
  grenade waittill("explode", pos);
  grenade weapondrop_deploydrone(self, pos);
  return 1;
}

weapondrop_deploydrone(owner, pos) {
  drone = owner scripts\cp_mp\killstreaks\helper_drone::deliverydrone_delivertopoint(pos, ::weapondrop_dronedelivery);

  if(isDefined(drone)) {
    deliverybox = spawn("script_model", drone.origin);
    deliverybox setModel("military_crate_field_upgrade_01");
    deliverybox setotherent(owner);
    deliverybox.owner = owner;
    deliverybox.team = owner.team;
    deliverybox linkTo(drone, "tag_origin", (0, 0, -15), (0, 0, 0));
    deliverybox enableplayermarks("killstreak");

    if(level.teambased)
      deliverybox filteroutplayermarks(owner.team);
    else
      deliverybox filteroutplayermarks(owner);

    drone.deliverybox = deliverybox;
    drone thread weapondrop_createdropondeath(deliverybox);
  }
}

weapondrop_dronedelivery() {
  self.deliverybox weapondrop_createdrop();
}

weapondrop_createdropondeath(deliverybox) {
  level endon("game_ended");
  level endon("prematch_cleanup");
  deliverybox endon("deliveryBox_dropped");
  deliverybox endon("death");
  self waittill("death");
  deliverybox thread weapondrop_createdrop();
}

weapondrop_createdrop() {
  if(istrue(self.hasdropped)) {
    return;
  }
  self.hasdropped = 1;
  self notify("deliveryBox_dropped");
  self unlink();
  cratephysicson();
  _id_7B59B41B01684053 = self.origin - (0, 0, 1000);
  scripts\cp_mp\utility\killstreak_utility::killstreak_createdangerzone(_id_7B59B41B01684053, 100, 1000, 30.0, self.owner, self.team);
  thread watchcrateimpact();
  thread watchcratesettle();
}

deletecrate() {
  cratephysicsoff();
  self delete();
}

cratephysicson() {
  if(istrue(self.physicson)) {
    return;
  }
  self.physicson = 1;
  self.unresolved_collision_kill = 1;
  self physicslaunchserver((0, 0, 0), (0, 0, 0), 1200);
  _id_212A44A5393C3B34 = self physics_getbodyid(0);
  physics_setbodycenterofmassnormal(_id_212A44A5393C3B34, (0, 0, -0.75));
  self physics_registerforcollisioncallback();
}

cratephysicsoff() {
  if(!istrue(self.physicson)) {
    return;
  }
  self notify("crate_physics_off");
  self.physicson = undefined;
  self.unresolved_collision_kill = undefined;
  self physicsstopserver();
  self physics_unregisterforcollisioncallback();
  self stoploopsound("mp_care_package_drop_lp");
  scripts\cp_mp\utility\killstreak_utility::killstreak_destroydangerzone();
}

watchcratesettle() {
  self endon("crate_physics_off");
  watchcratesettleinternal();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "touchingBadTrigger")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "touchingBadTrigger")]]()) {
      thread deletecrate();
      return;
    }
  }

  self.owner thread scripts\mp\equipment\ammo_box::ammobox_settled(self);
  thread cratephysicsoff();
}

watchcratesettleinternal() {
  wait 1;
  endtime = gettime() + 10000;

  while(gettime() < endtime) {
    _id_212A44A5393C3B34 = self physics_getbodyid(0);
    velocity = physics_getbodylinvel(_id_212A44A5393C3B34);

    if(lengthsquared(velocity) <= 0.5) {
      break;
    }

    waitframe();
  }
}

watchcrateimpact(delay) {
  self endon("crate_physics_off");
  self playLoopSound("mp_care_package_drop_lp");

  if(isDefined(delay))
    wait(delay);

  _id_260EF1536027D0E1 = 0;

  for(;;) {
    self waittill("collision", body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, ent);

    if(isDefined(ent) && ent scripts\cp_mp\killstreaks\helper_drone::ishelperdrone())
      ent thread scripts\cp_mp\killstreaks\helper_drone::_id_BA1C5496F8FC5F67();

    if(gettime() - _id_260EF1536027D0E1 >= 200) {
      _id_260EF1536027D0E1 = gettime();
      _id_895F3C282BC9FC68 = physics_getsurfacetypefromflags(flag1);
      surfacetype = getsubstr(_id_895F3C282BC9FC68["name"], 9);

      if(surfacetype == "user_terrain1")
        surfacetype = "user_terrain_1";

      if(surfacetype == "user_terrain5")
        surfacetype = "user_terrain_5";

      playcrateimpactfx(position, normal, _id_D71630B8BAF84FA8, surfacetype);
    }
  }
}

playcrateimpactfx(position, normal, _id_D71630B8BAF84FA8, surfacetype) {
  playFX(scripts\engine\utility::getfx("weapon_drop_impact"), position, normal);

  if(_id_D71630B8BAF84FA8 < 150)
    self playsurfacesound("mp_care_package_low_impact", surfacetype);
  else if(_id_D71630B8BAF84FA8 < 300)
    self playsurfacesound("mp_care_package_med_impact", surfacetype);
  else
    self playsurfacesound("mp_care_package_high_impact", surfacetype);

  self stoploopsound("mp_care_package_drop_lp");
}