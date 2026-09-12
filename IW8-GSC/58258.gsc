/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58258.gsc
***********************************************/

function init() {
  level.delete_pipe_ents = spawnStruct();
  level.delete_pipe_ents.scriptables = [];
  level.maxportablekiosksperteam = getdvarint("scr_br_maxPortableKiosksPerTeam", 2);
  level.maxportablekiosksglobal = getdvarint("scr_br_maxPortableKiosksGlobal", 20);
  level._effect["vfx_br3_pbs_dmg"] = loadfx("vfx/iw8_br/island/gameplay/vfx_br3_pbs_dmg.vfx");
}

function wait_between_combat_action(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 endon("grenade_OOB");
  var_0 endon("explode_end");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  thread vfx_htown_hadirj_blink(var_1);
  thread wait_between_stations(var_1);
  var_0 waittill("explode", var_2);
  var_1 notify("kiosk_drop_finished");
  thread wait_at_station(var_2);

  if(scripts\mp\outofbounds::ispointinoutofbounds(var_2)) {
    if(isDefined(var_0)) {
      var_0 delete();
    }

    if(isDefined(var_1.super)) {
      var_1 scripts\mp\supers::superusefinished(1);
    }

    return;
  }

  ref_1366A(var_1, var_2);

  if(isDefined(var_1.super)) {
    var_1 scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
    return;
  }
}

function ref_1366A(var_0) {
  cleanupallbutxkiosksforteam(self.team);
  manageglobalkioskcount();
  var_1 = 4096;

  if(istrue(self.umbra)) {
    var_1 = 10000;
  }

  var_2 = spawn("script_model", var_0 + (0, 0, var_1));
  var_2 setModel("lm_buy_station_crate_wood_01_ww2");
  var_2 physicslaunchserver();
  var_2 setscriptablepartstate("br_plunder_box", "visible", 0);
  scripts\mp\gametypes\br_pickups::ref_12B3A(var_2);
  var_2.visible = 1;
  var_2.isportablekiosk = 1;
  var_2.managerespawnfade = 1;
  var_2.team = self.team;
  level.delete_pipe_ents.scriptables[level.delete_pipe_ents.scriptables.size] = var_2;
  thread ref_11CFE();
  thread ref_11D0B();
  thread ref_11D17();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", self);
    return;
  }
}

function cleanupallbutxkiosksforteam(var_0) {
  var_1 = [];

  foreach(var_3 in level.delete_pipe_ents.scriptables) {
    if(!isDefined(var_3) || !isDefined(var_3.team) || var_3.team != var_0) {
      continue;
    }

    var_1 = var_3;
  }

  var_5 = var_1.size - level.maxportablekiosksperteam - 1;

  if(var_5 <= 0) {
    return;
  }

  for(var_6 = var_5 - 1; var_6 >= 0; var_6--) {
    var_7 = var_1[var_6];
    destroyportablekiosk(var_7);
  }
}

function manageglobalkioskcount() {
  if(level.delete_pipe_ents.scriptables.size >= level.maxportablekiosksglobal) {
    destroyportablekiosk(level.delete_pipe_ents.scriptables[0]);
    return;
  }
}

function dangercircletick(var_0, var_1) {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("kiosk") || getdvarint("scr_br_kiosk_ignore_circle", 0) == 1) {
    return;
  }

  var_2 = var_1 * var_1;

  foreach(var_4 in level.delete_pipe_ents.scriptables) {
    if(isDefined(var_4.visible) && isDefined(var_4.origin) && distance2dsquared(var_4.origin, var_0) > var_2) {
      destroyportablekiosk(var_4);
    }
  }
}

function destroyportablekiosk(var_0) {
  var_0 setscriptablepartstate("br_plunder_box", "disabled");
  var_0.visible = undefined;
  var_0.disabled = 1;
  var_0 notify("portableKiosk_disabled");

  if(var_0 scripts\mp\gametypes\br_quest_util::gethelispawns()) {
    var_0 scripts\mp\gametypes\br_quest_util::lastdropedtime();
  }

  playFX(scripts\engine\utility::getfx("vfx_br3_pbs_dmg"), var_0.origin);
  playsoundatpos(var_0.origin, "mp_equip_destroyed");
  level.delete_pipe_ents.scriptables = scripts\engine\utility::array_remove(level.delete_pipe_ents.scriptables, var_0);
  var_0 delete();
}

function ref_11D17() {
  ref_11D18();
  self endon("death");
  self endon("monitorPlayerImpactEnd");
  var_0 = self;

  if(isDefined(self.mountmantlemodel)) {
    var_0 = self.mountmantlemodel;
  }

  var_1 = undefined;
  jumpiffalse(isDefined(self.owner)) LOC_00000038;
  var_1 = self.owner;

  while(isDefined(var_0)) {
    var_0 waittill("player_pushed", var_2, var_3);

    if(isDefined(var_2) && (isPlayer(var_2) || isagent(var_2)) && var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_4 = var_3[2] <= -8;
      var_5 = 0;
      var_6 = undefined;

      if(var_2 tagexists("j_mainroot")) {
        var_6 = var_2 gettagorigin("j_mainroot");
        var_7 = self.origin + anglestoup(self.angles) * 27.5;
        var_5 = var_6[2] <= var_7[2];
      }

      if(var_4 && var_5) {
        var_8 = var_1;

        if(!isDefined(var_8)) {
          var_8 = var_2;
        }
      }
    }
  }
}

function ref_11D18() {
  self notify("monitorPlayerImpactEnd");
}

function ref_1273B(var_0, var_1, var_2, var_3) {
  playFX(scripts\engine\utility::getfx("airdrop_crate_impact"), var_0, var_1);

  if(var_2 < 150) {
    self playsurfacesound("mp_care_package_low_impact", var_3);
  } else if(var_2 < 300) {
    self playsurfacesound("mp_care_package_med_impact", var_3);
  } else {
    self playsurfacesound("mp_care_package_high_impact", var_3);
  }

  self stoploopsound("mp_care_package_drop_lp");
}

function ref_11CFE() {
  self endon("death");
  self notify("monitorAverageVelocityAndUpdate");
  self endon("monitorAverageVelocityAndUpdate");
  var_0 = 0.1;
  thread scripts\cp_mp\killstreaks\airdrop::ref_11CFD(var_0, 8);
  var_1 = 0;
  var_2 = 0;
  var_3 = undefined;
  var_4 = undefined;
  jumpiffalse(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated")) LOC_00000055;
  var_4 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated");

  for(;;) {
    var_5 = scripts\cp_mp\killstreaks\airdrop::registeronplayerjointeamnospectatorcallback();
    var_6 = scripts\cp_mp\killstreaks\airdrop::registeronplayerdisconnect();

    if(isDefined(var_5) && isDefined(var_6)) {
      if(var_5 <= 5 && var_6 <= 1) {
        var_1++;
        var_2 = 0;

        if(var_1 == 6) {
          self.ref_12332 = 1;
          var_3 = self.origin;

          if(isDefined(var_4) && [[var_4]]()) {
            ref_11D0C();

            if(isDefined(self.killcament)) {
              self.killcament delete();
            }
          }

          var_0 = 0.1;
          thread scripts\cp_mp\killstreaks\airdrop::ref_11CFD(var_0, 3, 3);
        }
      } else {
        if(isDefined(var_3)) {
          if(distancesquared(self.origin, var_3) <= 2500) {
            wait var_0;
            continue;
          }
        }

        var_2++;
        var_1 = 0;

        if(var_2 == 1) {
          self.ref_12332 = undefined;
          var_0 = 0.1;
          thread scripts\cp_mp\killstreaks\airdrop::ref_11CFD(var_0, 8);
        }
      }

      wait var_0;
      continue;
    }

    waitframe();
  }
}

function ref_11D0B(var_0) {
  ref_11D0C();
  self endon("monitorImpactEnd");
  self.ref_11D0E = 1;
  self playLoopSound("mp_care_package_drop_lp");
  self physics_registerforcollisioncallback();
  ref_11D0D(var_0);

  if(isDefined(self)) {
    thread ref_11D0C();
    return;
  }
}

function ref_11D0D(var_0) {
  self endon("death");

  if(isDefined(var_0)) {
    wait var_0;
  }

  var_1 = 0;

  for(;;) {
    self waittill("collision", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && scripts\cp_mp\killstreaks\airdrop::start_chants_on_movement(var_9)) {
      if(var_9 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks()) {
        var_9 thread scripts\cp_mp\killstreaks\helper_drone::helperdronedestroyed();
      }
    }

    if(gettime() - var_1 >= 2) {
      var_1 = gettime();
      var_10 = physics_getsurfacetypefromflags(var_5);
      var_11 = getsubstr(var_10["name"], 9);

      if(var_11 == "user_terrain1") {
        var_11 = "user_terrain_1";
      }

      if(var_11 == "user_terrain5") {
        var_11 = "user_terrain_5";
      }

      ref_1273B(var_6, var_7, var_8, var_11);
    }
  }
}

function ref_11D0C() {
  if(!istrue(self.ref_11D0E)) {
    return;
  }

  self notify("monitorImpactEnd");
  self.ref_11D0E = undefined;
  self stoploopsound("mp_care_package_drop_lp");
  self physics_unregisterforcollisioncallback();
}

function vfx_htown_hadirj_blink(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_0 endon("explode");
  var_0 endon("explode_end");
  wait 10;

  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_1 notify("grenade_OOB");
}

function wait_between_stations(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 endon("kiosk_drop_finished");
  var_0 waittill("death");
  waitframe();

  if(isDefined(var_1.super)) {
    var_1 scripts\mp\supers::superusefinished(1);
    return;
  }
}

function wait_at_station(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playLoopSound("smoke_carepackage_smoke_lp");
  wait 21;
  var_1 playSound("smoke_canister_tail_dissipate");
  var_1 stoploopsound("smoke_carepackage_smoke_lp");
  wait 5;
  var_1 delete();
}