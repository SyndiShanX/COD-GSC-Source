/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\weapon_drop.gsc
************************************************/

function weapondrop_init() {
  level._effect["weapon_drop_impact"] = loadfx("vfx/iw8_mp/killstreak/vfx_carepkg_landing_dust.vfx");
}

function weapondrop_beginsuper() {
  thread weapondrop_givedropweapon();
  return true;
}

function weapondrop_givedropweapon() {
  level endon("game_ended");
  self endon("disconnect");
  waitframe();
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("weapondrop", self);
  var_0.deployweaponobj = getcompleteweaponname("deploy_weapondrop_mp");
  scripts\common\utility::allow_killstreaks(0);
  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var_0, var_0.deployweaponobj, "grenade_fire");
  scripts\common\utility::allow_killstreaks(1);

  if(istrue(var_1)) {
    var_0 notify("killstreak_finished_with_deploy_weapon");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();
      return;
    }

    return;
  }

  if(scripts\mp\supers::issuperinuse()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
      return;
    }

    return;
  }
}

function weapondrop_used(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 waittill("explode", var_1);
  weapondrop_deploydrone(var_0, self, var_1);
  return true;
}

function weapondrop_deploydrone(var_0, var_1) {
  var_2 = var_0 scripts\cp_mp\killstreaks\helper_drone::deliverydrone_delivertopoint(var_1, &weapondrop_dronedelivery);

  if(isDefined(var_2)) {
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel("military_crate_field_upgrade_01");
    var_3 setotherent(var_0);
    var_3.owner = var_0;
    var_3.team = var_0.team;
    var_3 linkTo(var_2, "tag_origin", (0, 0, -15), (0, 0, 0));
    var_3 enableplayermarks("killstreak");

    if(level.teambased) {
      var_3 filteroutplayermarks(var_0.team);
    } else {
      var_3 filteroutplayermarks(var_0);
    }

    var_2.deliverybox = var_3;
    thread ref_1457f(var_2);
    return;
  }
}

function weapondrop_dronedelivery() {
  weapondrop_createdrop(self.deliverybox);
}

function ref_1457f(var_0) {
  level endon("game_ended");
  level endon("prematch_cleanup");
  var_0 endon("deliveryBox_dropped");
  var_0 endon("death");
  self waittill("death");
  thread weapondrop_createdrop();
}

function weapondrop_createdrop() {
  if(istrue(self.should_give_grenades)) {
    return;
  }

  self.should_give_grenades = 1;
  self notify("deliveryBox_dropped");
  self unlink();
  infinite_chopper();
  var_0 = self.origin - (0, 0, 1000);
  scripts\cp_mp\utility\killstreak_utility::killstreak_createdangerzone(var_0, 100, 1000, 30, self.owner, self.team);
  thread watchcrateimpact();
  thread watchcratesettle();
}

function deletecrate() {
  infilweaponraise();
  self delete();
}

function infinite_chopper() {
  if(istrue(self.ref_12331)) {
    return;
  }

  self.ref_12331 = 1;
  self.unresolved_collision_kill = 1;
  self physicslaunchserver((0, 0, 0), (0, 0, 0), 1200);
  var_0 = self physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var_0, (0, 0, -1));
  self physics_registerforcollisioncallback();
}

function infilweaponraise() {
  if(!istrue(self.ref_12331)) {
    return;
  }

  self notify("crate_physics_off");
  self.ref_12331 = undefined;
  self.unresolved_collision_kill = undefined;
  self physicsstopserver();
  self physics_unregisterforcollisioncallback();
  self stoploopsound("mp_care_package_drop_lp");
  scripts\cp_mp\utility\killstreak_utility::killstreak_destroydangerzone();
}

function watchcratesettle() {
  self endon("crate_physics_off");
  watchcratesettleinternal();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "touchingBadTrigger")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "touchingBadTrigger")]]()) {
      thread deletecrate();
      return;
    }
  }

  self.owner thread scripts\mp\equipment\ammo_box::ammobox_settled(self);
  thread infilweaponraise();
}

function watchcratesettleinternal() {
  wait 1;
  var_0 = gettime() + 10000;

  while(gettime() < var_0) {
    var_1 = self physics_getbodyid(0);
    var_2 = physics_getbodylinvel(var_1);

    if(lengthsquared(var_2) <= 0.5) {
      break;
    }

    waitframe();
  }
}

function watchcrateimpact(var_0) {
  self endon("crate_physics_off");
  self playLoopSound("mp_care_package_drop_lp");

  if(isDefined(var_0)) {
    wait var_0;
  }

  var_1 = 0;

  for(;;) {
    self waittill("collision", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && var_9 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks()) {
      var_9 thread scripts\cp_mp\killstreaks\helper_drone::helperdronedestroyed();
    }

    if(gettime() - var_1 >= 200) {
      var_1 = gettime();
      var_10 = physics_getsurfacetypefromflags(var_5);
      var_11 = getsubstr(var_10["name"], 9);

      if(var_11 == "user_terrain1") {
        var_11 = "user_terrain_1";
      }

      if(var_11 == "user_terrain5") {
        var_11 = "user_terrain_5";
      }

      ref_1245c(var_6, var_7, var_8, var_11);
    }
  }
}

function ref_1245c(var_0, var_1, var_2, var_3) {
  playFX(scripts\engine\utility::getfx("weapon_drop_impact"), var_0, var_1);

  if(var_2 < 150) {
    self playsurfacesound("mp_care_package_low_impact", var_3);
  } else if(var_2 < 300) {
    self playsurfacesound("mp_care_package_med_impact", var_3);
  } else {
    self playsurfacesound("mp_care_package_high_impact", var_3);
  }

  self stoploopsound("mp_care_package_drop_lp");
}