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
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("weapondrop", self);
  var0.deployweaponobj = getcompleteweaponname("deploy_weapondrop_mp");
  scripts\common\utility::allow_killstreaks(0);
  var1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var0, var0.deployweaponobj, "grenade_fire");
  scripts\common\utility::allow_killstreaks(1);

  if(istrue(var1)) {
    var0 notify("killstreak_finished_with_deploy_weapon");

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

function weapondrop_used(var0) {
  level endon("game_ended");
  self endon("disconnect");
  var0 waittill("explode", var1);
  weapondrop_deploydrone(var0, self, var1);
  return true;
}

function weapondrop_deploydrone(var0, var1) {
  var2 = var0 scripts\cp_mp\killstreaks\helper_drone::deliverydrone_delivertopoint(var1, &weapondrop_dronedelivery);

  if(isDefined(var2)) {
    var3 = spawn("script_model", var2.origin);
    var3 setModel("military_crate_field_upgrade_01");
    var3 setotherent(var0);
    var3.owner = var0;
    var3.team = var0.team;
    var3 linkTo(var2, "tag_origin", (0, 0, -15), (0, 0, 0));
    var3 enableplayermarks("killstreak");

    if(level.teambased) {
      var3 filteroutplayermarks(var0.team);
    } else {
      var3 filteroutplayermarks(var0);
    }

    var2.deliverybox = var3;
    thread ref_1457f(var2);
    return;
  }
}

function weapondrop_dronedelivery() {
  weapondrop_createdrop(self.deliverybox);
}

function ref_1457f(var0) {
  level endon("game_ended");
  level endon("prematch_cleanup");
  var0 endon("deliveryBox_dropped");
  var0 endon("death");
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
  var0 = self.origin - (0, 0, 1000);
  scripts\cp_mp\utility\killstreak_utility::killstreak_createdangerzone(var0, 100, 1000, 30, self.owner, self.team);
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
  var0 = self physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var0, (0, 0, -1));
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
  var0 = gettime() + 10000;

  while(gettime() < var0) {
    var1 = self physics_getbodyid(0);
    var2 = physics_getbodylinvel(var1);

    if(lengthsquared(var2) <= 0.5) {
      break;
    }

    waitframe();
  }
}

function watchcrateimpact(var0) {
  self endon("crate_physics_off");
  self playLoopSound("mp_care_package_drop_lp");

  if(isDefined(var0)) {
    wait var0;
  }

  var1 = 0;

  for(;;) {
    self waittill("collision", var2, var3, var4, var5, var6, var7, var8, var9);

    if(isDefined(var9) && var9 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks()) {
      var9 thread scripts\cp_mp\killstreaks\helper_drone::helperdronedestroyed();
    }

    if(gettime() - var1 >= 200) {
      var1 = gettime();
      var10 = physics_getsurfacetypefromflags(var5);
      var11 = getsubstr(var10["name"], 9);

      if(var11 == "user_terrain1") {
        var11 = "user_terrain_1";
      }

      if(var11 == "user_terrain5") {
        var11 = "user_terrain_5";
      }

      ref_1245c(var6, var7, var8, var11);
    }
  }
}

function ref_1245c(var0, var1, var2, var3) {
  playFX(scripts\engine\utility::getfx("weapon_drop_impact"), var0, var1);

  if(var2 < 150) {
    self playsurfacesound("mp_care_package_low_impact", var3);
  } else if(var2 < 300) {
    self playsurfacesound("mp_care_package_med_impact", var3);
  } else {
    self playsurfacesound("mp_care_package_high_impact", var3);
  }

  self stoploopsound("mp_care_package_drop_lp");
}