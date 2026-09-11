/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_c130airdrop.gsc
***************************************************/

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_c130Airdrop", "c130Airdrop_onCrateUse", &fntrapactivation);
  level.fob_bombs = [];
  level.focus_fire_attacker_timeout = [];
  level.fnhidefoundintel = getdvarint("scr_bmo_airdropCrateHeightOverride", 12000);
}

function fnoffhandfire() {
  level endon("game_ended");
  var0 = 1;
  level waittill("br_prematchEnded");

  for(;;) {
    var1 = getdvarint("scr_dmz_airdrop_active", 1);

    if(!var1) {
      waitframe();
      continue;
    }

    var2 = getdvarint("scr_dmz_airdrop_max_c130_spawns", 3);
    var3 = getdvarint("scr_dmz_airdrop_max_crates", 12);
    var4 = getdvarint("scr_dmz_airdrop_spawn_cooldown_min", 240);
    var5 = getdvarint("scr_dmz_airdrop_spawn_cooldown_max", 360);
    var6 = randomintrange(var4, var5);

    if(istrue(level.ref_14086) && istrue(var0)) {
      scripts\mp\flags::gameflagwait("activate_cash_drops");
    } else {
      wait var6;
    }

    if(isDefined(level.br_level)) {
      level.br_level.c130_speedoverride = 3044;
    }

    var7 = level.focus_fire_attacker_timeout.size;

    if(var7 < var3) {
      var8 = getdvarint("scr_dmz_airdrop_num_crates_per", 3);
      var9 = var3 - var7;

      if(!istrue(var0)) {
        var2 = 1;
      }

      var10 = min(var2, ceil(var9 / var8));
      var11 = var9;

      for(var12 = 0; var12 < var10; var12++) {
        var13 = min(var8, var11);
        var11 -= var13;
        var14 = fn_spec_op_post_customization(var12);
        var15 = distance(var14.startpt, var14.endpt);
        var16 = scripts\mp\gametypes\br_c130::getc130speed();
        var17 = var15 / var16;
        var18 = fntrapdeactivation(var14, var15, var16, var17);

        if(var12 == 0) {
          scripts\mp\gametypes\br_gametype_dmz::ref_13371("br_c130airdrop_incoming");
        }

        fob(var18, var13);

        if(istrue(level.ref_14086)) {
          wait randomintrange(4, 8);
        }
      }

      if(istrue(var0)) {
        var0 = 0;
      }
    }
  }
}

function fn_spec_op_post_customization(var0, var1, var2) {
  if(isDefined(level.br_level.br_mapcenter) && isDefined(level.br_level.br_mapsize)) {
    var3 = fnanimatedprop_setanim(var0, var1, var2);
  } else {
    var3 = scripts\mp\gametypes\br_c130::spawnc130pathstruct(var2);
  }

  return var3;
}

function fnanimatedprop_setanim(var0, var1, var2) {
  var3 = undefined;
  var4 = level.br_level.br_mapcenter;

  if(isDefined(var1)) {
    var4 = var1;
  }

  var5 = scripts\mp\gametypes\br_c130::respawns_on_failed_unload();
  var6 = (0, randomfloat(360), 0);

  if(!isDefined(var0) || var0 == 0) {
    if(!istrue(var2)) {
      var7 = fngetplayerdrone();
      var8 = fndropweapon(var7);
      var6 = vectortoangles(var4 - var8 * (1, 1, 0));
      level.fob_think = var6;
    }

    var4 += (0, 0, scripts\cp_mp\parachute::release_player_on_damage());
  } else {
    jumpiffalse(isDefined(level.fob_think)) LOC_000000dc;
    var6 = level.fob_think;
    var9 = 1;

    if(var0 == 2) {
      var9 = -1;
    }

    var10 = anglestoright(var6) * var5 * var9;
    var11 = randomint(2);
    var12 = randomfloat(360);
    var6 = (0, var12, 0);
    var6 = scripts\engine\utility::ter_op(var11, var6, var6 + (0, 180, 0));
    goto LOC_000000fc;
  }

  var5 = scripts\mp\gametypes\br_c130::ref_1361a(var6, var12);
  return var5;
}

function fngetplayerdrone() {
  var0 = undefined;
  var1 = scripts\mp\gamescore::run_common_functions_stealth();
  var2 = [];

  foreach(var4 in level.teamnamelist) {
    var5 = scripts\mp\utility\teams::getteamdata(var4, "players");

    if(var5.size > 0) {
      var6 = 0;

      foreach(var8 in var5) {
        if(!isDefined(var8)) {
          continue;
        }

        if(scripts\mp\utility\player::isreallyalive(var8)) {
          var6 = 1;
          break;
        }
      }

      if(!istrue(var6)) {
        continue;
      }

      var10 = var1[var4];

      if(!isDefined(var0) || var10 >= var0) {
        var0 = var10;
        var11 = var2.size;
        var2 = spawnStruct();
        var2[var11].team = var4;
        var2[var11].players = var5;
      }
    }
  }

  if(var2.size > 0) {
    var11 = 0;

    if(var2.size > 1) {
      var11 = randomint(var2.size);
    }

    return var2[var11];
  }
}

function fndropweapon(var0) {
  if(!isDefined(var0.players)) {
    return (randomfloatrange(-1000, 1000), 0, 0);
  }

  var1 = (0, 0, 0);
  var2 = 3000;
  var3 = 1;

  foreach(var5 in var0.players) {
    if(!scripts\mp\utility\player::isreallyalive(var5)) {
      continue;
    }

    var1 = var5.origin;

    foreach(var7 in var0.players) {
      if(var7 == var5) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var7)) {
        continue;
      }

      if(distance2dsquared(var5.origin, var7.origin) <= var2 * var2) {
        var3++;
        var1 += var7.origin;
        break;
      }
    }

    if(var3 >= 2) {
      break;
    }
  }

  var10 = var1 / var3;
  return var10;
}

function fntrapdeactivation(var0, var1, var2, var3) {
  var4 = spawn("script_model", var0.startpt);
  var4 setModel("veh8_mil_air_acharlie130_magma_animated");
  var4 setCanDamage(0);
  var4.maxhealth = 100000;
  var4.health = var4.maxhealth;
  var4.startpt = var0.startpt;
  var4.endpt = var0.endpt;
  var4.centerpt = var0.centerpt;
  var4.dir = vectorNormalize(var4.endpt - var4.startpt);
  var4.angles = vectortoangles(var4.dir);
  var4.ref_121fe = var1;
  var4.speed = var2;
  var4.lifetime = var3;
  var4.getcircleclosetime = spawn("script_model", var4.startpt);
  var4.getcircleclosetime setModel("veh8_mil_air_acharlie130_magma_rigid");
  var4.getcircleclosetime linkTo(var4, "", (0, 0, 0), (0, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var5 = var4[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", undefined, undefined, 1, 1);
    var4.minimapid = var5;
  }

  level.fob_bombs[level.fob_bombs.size] = var4;
  return var4;
}

function fob(var0, var1, var2, var3) {
  self setscriptablepartstate("audio_lp_dmz", "on", 0);
  self moveTo(self.endpt, self.lifetime);
  thread fnanimatedprop_setup();
  thread fnanimatedprop_startanim(var0, var1, var2, var3);
}

function fnanimatedprop_setup() {
  self endon("death");
  level endon("game_ended");
  wait max(self.lifetime - 1, 1);
  var0 = spawn("script_model", self.origin);
  var0 setModel("veh8_mil_air_acharlie130_magma_scriptable");
  var0 setscriptablepartstate("audio_exit_dmz", "on", 0);
  var0 thread scripts\mp\utility\script::delayentdelete(10);
  wait 1;
  level.fob_bombs = scripts\engine\utility::array_remove(level.fob_bombs, self);
  self setscriptablepartstate("audio_lp_dmz", "off", 0);

  if(isDefined(self.minimapid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.minimapid);
  }

  if(isDefined(self.getcircleclosetime)) {
    self.getcircleclosetime delete();
  }

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function fnanimatedprop_startanim(var0, var1, var2, var3) {
  self endon("death");

  if(isDefined(self.mode_can_play_ending)) {
    self[[self.mode_can_play_ending]](var0, var1, var2, var3);
    return;
  }

  var4 = self.lifetime;
  var5 = var4 * 0.4;
  var6 = var4 - var5;
  var7 = var5 / 2;
  var8 = var6 / max(1, var0 - 1);
  var9 = 1;
  var10 = 0;
  var11 = var7;
  var12 = 0;

  while(var12 < var0) {
    if(!istrue(var9)) {
      var11 = var8;
    }

    if(istrue(var10)) {
      var11 = var8 / 3;
      var10 = 0;
    }

    wait var11;

    if(istrue(var9)) {
      var9 = 0;
    }

    var13 = fnchildscorefunc(self.origin + anglesToForward(self.angles) * 500);

    if(!isDefined(var13)) {
      var10 = 1;
      continue;
    }

    var14 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var13 + (0, 0, level.fnhidefoundintel - 100), var13, self.angles, var1, var2);

    if(!isDefined(var14)) {
      var10 = 1;
      continue;
    }

    var12++;
    var15 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var14);
    var15.ref_140a0 = 5;
    level.focus_fire_attacker_timeout[level.focus_fire_attacker_timeout.size] = var14;
  }
}

function fnchildscorefunc(var0, var1) {
  var2 = undefined;
  var3 = var0 - (0, 0, 20000);
  var4 = [self, self.getcircleclosetime];
  var5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 1);
  var6 = scripts\engine\trace::ray_trace(var0, var3, var4, var5);

  if(isDefined(var6) && var6["hittype"] != "hittype_none") {
    var2 = var6["position"];
  }

  if(isDefined(var2) && !istrue(var1)) {
    if(istrue(level.ref_14089) && isscriptabledefined()) {
      var2 = getclosestpointonnavmesh(var2);
    }

    var7 = scripts\mp\gametypes\br_c130::ispointinbounds(var2, 1, 0) && !fnlookforvehicles(var2);

    if(!istrue(var7)) {
      var2 = undefined;
    }
  }

  return var2;
}

function fnlookforvehicles(var0) {
  var1 = 0;
  var2 = level.focus_fire_attacker_timeout;
  var3 = getdvarint("scr_dmz_airdrop_min_dist", 10000);
  var4 = var3 * var3;

  foreach(var6 in var2) {
    if(distance2dsquared(var0, var6.origin) < var4) {
      var1 = 1;
      break;
    }
  }

  return var1;
}

function fntrapactivation(var0) {
  var1 = "mp/loot_set_airdrop_contents_dmz.csv";
  self.itemsdropped = 0;
  var2 = [];

  if(!scripts\mp\gametypes\br_public::uniquelootitemid() && getDvar("scr_br_gametype", "") != "rat_race") {
    var3 = scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "killstreak", var1);
    var2 = scripts\engine\utility::array_combine(var2, var3);
  }

  var3 = scripts\mp\gametypes\br_lootcache::chooseandspawnitems(4, 1, "weapon", var1);
  var2 = scripts\engine\utility::array_combine(var2, var3);
  var3 = scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 2, "health", var1);
  var2 = scripts\engine\utility::array_combine(var2, var3);
  var3 = scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 2, "ammo", var1);
  var2 = scripts\engine\utility::array_combine(var2, var3);

  if(!scripts\mp\gametypes\br_public::uniquelootitemid() && getdvarint("scr_dmz_airdrop_drop_tablet", 0) == 1) {
    var3 = scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "tablet", var1);
    var2 = scripts\engine\utility::array_combine(var2, var3);
  }

  var4 = randomint(3);

  if(var4 == 2) {
    var3 = scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "revive", var1);
    var2 = scripts\engine\utility::array_combine(var2, var3);
  }

  var5 = 750;

  if(isDefined(level.br_checkforlaststandwipe)) {
    var5 = level.br_checkforlaststandwipe;
  }

  if(istrue(level.convoy_handle_stuck_compromise)) {
    var5 = int(var5 * level.ref_12192);
  }

  var6 = undefined;

  if(isDefined(level.br_circle_init_func)) {
    var6 = level.br_circle_init_func;
  }

  var7 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var7.ml_p3_to_safehouse_transition = self.itemsdropped;
  var3 = scripts\mp\gametypes\br_plunder::dropplunderbyrarity(var5, var7, var6);
  var2 = scripts\engine\utility::array_combine(var2, var3);

  foreach(var9 in var2) {
    var9.ref_11a40 = "c130_box";
  }

  if(!isDefined(var0.ref_11a01)) {
    var0.ref_11a01 = 1;
  } else {
    var0.ref_11a01++;
  }

  var0 scripts\mp\utility\stats::setextrascore1(var0.ref_11a01);
  var0 thread scripts\mp\utility\points::giveunifiedpoints("br_c130_box_open");
}