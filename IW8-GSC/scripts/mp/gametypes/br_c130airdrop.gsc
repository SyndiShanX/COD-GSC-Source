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
  var_0 = 1;
  level waittill("br_prematchEnded");

  for(;;) {
    var_1 = getdvarint("scr_dmz_airdrop_active", 1);

    if(!var_1) {
      waitframe();
      continue;
    }

    var_2 = getdvarint("scr_dmz_airdrop_max_c130_spawns", 3);
    var_3 = getdvarint("scr_dmz_airdrop_max_crates", 12);
    var_4 = getdvarint("scr_dmz_airdrop_spawn_cooldown_min", 240);
    var_5 = getdvarint("scr_dmz_airdrop_spawn_cooldown_max", 360);
    var_6 = randomintrange(var_4, var_5);

    if(istrue(level.ref_14086) && istrue(var_0)) {
      scripts\mp\flags::gameflagwait("activate_cash_drops");
    } else {
      wait var_6;
    }

    if(isDefined(level.br_level)) {
      level.br_level.c130_speedoverride = 3044;
    }

    var_7 = level.focus_fire_attacker_timeout.size;

    if(var_7 < var_3) {
      var_8 = getdvarint("scr_dmz_airdrop_num_crates_per", 3);
      var_9 = var_3 - var_7;

      if(!istrue(var_0)) {
        var_2 = 1;
      }

      var_10 = min(var_2, ceil(var_9 / var_8));
      var_11 = var_9;

      for(var_12 = 0; var_12 < var_10; var_12++) {
        var_13 = min(var_8, var_11);
        var_11 -= var_13;
        var_14 = fn_spec_op_post_customization(var_12);
        var_15 = distance(var_14.startpt, var_14.endpt);
        var_16 = scripts\mp\gametypes\br_c130::getc130speed();
        var_17 = var_15 / var_16;
        var_18 = fntrapdeactivation(var_14, var_15, var_16, var_17);

        if(var_12 == 0) {
          scripts\mp\gametypes\br_gametype_dmz::ref_13371("br_c130airdrop_incoming");
        }

        fob(var_18, var_13);

        if(istrue(level.ref_14086)) {
          wait randomintrange(4, 8);
        }
      }

      if(istrue(var_0)) {
        var_0 = 0;
      }
    }
  }
}

function fn_spec_op_post_customization(var_0, var_1, var_2) {
  if(isDefined(level.br_level.br_mapcenter) && isDefined(level.br_level.br_mapsize)) {
    var_3 = fnanimatedprop_setanim(var_0, var_1, var_2);
  } else {
    var_3 = scripts\mp\gametypes\br_c130::spawnc130pathstruct(var_2);
  }

  return var_3;
}

function fnanimatedprop_setanim(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = level.br_level.br_mapcenter;

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  var_5 = scripts\mp\gametypes\br_c130::respawns_on_failed_unload();
  var_6 = (0, randomfloat(360), 0);

  if(!isDefined(var_0) || var_0 == 0) {
    if(!istrue(var_2)) {
      var_7 = fngetplayerdrone();
      var_8 = fndropweapon(var_7);
      var_6 = vectortoangles(var_4 - var_8 * (1, 1, 0));
      level.fob_think = var_6;
    }

    var_4 += (0, 0, scripts\cp_mp\parachute::release_player_on_damage());
  } else {
    jumpiffalse(isDefined(level.fob_think)) LOC_000000dc;
    var_6 = level.fob_think;
    var_9 = 1;

    if(var_0 == 2) {
      var_9 = -1;
    }

    var_10 = anglestoright(var_6) * var_5 * var_9;
    var_11 = randomint(2);
    var_12 = randomfloat(360);
    var_6 = (0, var_12, 0);
    var_6 = scripts\engine\utility::ter_op(var_11, var_6, var_6 + (0, 180, 0));
    goto LOC_000000fc;
  }

  var_5 = scripts\mp\gametypes\br_c130::ref_1361A(var_6, var_12);
  return var_5;
}

function fngetplayerdrone() {
  var_0 = undefined;
  var_1 = scripts\mp\gamescore::run_common_functions_stealth();
  var_2 = [];

  foreach(var_4 in level.teamnamelist) {
    var_5 = scripts\mp\utility\teams::getteamdata(var_4, "players");

    if(var_5.size > 0) {
      var_6 = 0;

      foreach(var_8 in var_5) {
        if(!isDefined(var_8)) {
          continue;
        }

        if(scripts\mp\utility\player::isreallyalive(var_8)) {
          var_6 = 1;
          break;
        }
      }

      if(!istrue(var_6)) {
        continue;
      }

      var_10 = var_1[var_4];

      if(!isDefined(var_0) || var_10 >= var_0) {
        var_0 = var_10;
        var_11 = var_2.size;
        var_2 = spawnStruct();
        var_2[var_11].team = var_4;
        var_2[var_11].players = var_5;
      }
    }
  }

  if(var_2.size > 0) {
    var_11 = 0;

    if(var_2.size > 1) {
      var_11 = randomint(var_2.size);
    }

    return var_2[var_11];
  }
}

function fndropweapon(var_0) {
  if(!isDefined(var_0.players)) {
    return (randomfloatrange(-1000, 1000), 0, 0);
  }

  var_1 = (0, 0, 0);
  var_2 = 3000;
  var_3 = 1;

  foreach(var_5 in var_0.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_5)) {
      continue;
    }

    var_1 = var_5.origin;

    foreach(var_7 in var_0.players) {
      if(var_7 == var_5) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var_7)) {
        continue;
      }

      if(distance2dsquared(var_5.origin, var_7.origin) <= var_2 * var_2) {
        var_3++;
        var_1 += var_7.origin;
        break;
      }
    }

    if(var_3 >= 2) {
      break;
    }
  }

  var_10 = var_1 / var_3;
  return var_10;
}

function fntrapdeactivation(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0.startpt);
  var_4 setModel("veh8_mil_air_acharlie130_magma_animated");
  var_4 setCanDamage(0);
  var_4.maxhealth = 100000;
  var_4.health = var_4.maxhealth;
  var_4.startpt = var_0.startpt;
  var_4.endpt = var_0.endpt;
  var_4.centerpt = var_0.centerpt;
  var_4.dir = vectorNormalize(var_4.endpt - var_4.startpt);
  var_4.angles = vectortoangles(var_4.dir);
  var_4.ref_121FE = var_1;
  var_4.speed = var_2;
  var_4.lifetime = var_3;
  var_4.getcircleclosetime = spawn("script_model", var_4.startpt);
  var_4.getcircleclosetime setModel("veh8_mil_air_acharlie130_magma_rigid");
  var_4.getcircleclosetime linkTo(var_4, "", (0, 0, 0), (0, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_5 = var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", undefined, undefined, 1, 1);
    var_4.minimapid = var_5;
  }

  level.fob_bombs[level.fob_bombs.size] = var_4;
  return var_4;
}

function fob(var_0, var_1, var_2, var_3) {
  self setscriptablepartstate("audio_lp_dmz", "on", 0);
  self moveTo(self.endpt, self.lifetime);
  thread fnanimatedprop_setup();
  thread fnanimatedprop_startanim(var_0, var_1, var_2, var_3);
}

function fnanimatedprop_setup() {
  self endon("death");
  level endon("game_ended");
  wait max(self.lifetime - 1, 1);
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("veh8_mil_air_acharlie130_magma_scriptable");
  var_0 setscriptablepartstate("audio_exit_dmz", "on", 0);
  var_0 thread scripts\mp\utility\script::delayentdelete(10);
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

function fnanimatedprop_startanim(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(isDefined(self.mode_can_play_ending)) {
    self[[self.mode_can_play_ending]](var_0, var_1, var_2, var_3);
    return;
  }

  var_4 = self.lifetime;
  var_5 = var_4 * 0.4;
  var_6 = var_4 - var_5;
  var_7 = var_5 / 2;
  var_8 = var_6 / max(1, var_0 - 1);
  var_9 = 1;
  var_10 = 0;
  var_11 = var_7;
  var_12 = 0;

  while(var_12 < var_0) {
    if(!istrue(var_9)) {
      var_11 = var_8;
    }

    if(istrue(var_10)) {
      var_11 = var_8 / 3;
      var_10 = 0;
    }

    wait var_11;

    if(istrue(var_9)) {
      var_9 = 0;
    }

    var_13 = fnchildscorefunc(self.origin + anglesToForward(self.angles) * 500);

    if(!isDefined(var_13)) {
      var_10 = 1;
      continue;
    }

    var_14 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var_13 + (0, 0, level.fnhidefoundintel - 100), var_13, self.angles, var_1, var_2);

    if(!isDefined(var_14)) {
      var_10 = 1;
      continue;
    }

    var_12++;
    var_15 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_14);
    var_15.ref_140A0 = 5;
    level.focus_fire_attacker_timeout[level.focus_fire_attacker_timeout.size] = var_14;
  }
}

function fnchildscorefunc(var_0, var_1) {
  var_2 = undefined;
  var_3 = var_0 - (0, 0, 20000);
  var_4 = [self, self.getcircleclosetime];
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 1);
  var_6 = scripts\engine\trace::ray_trace(var_0, var_3, var_4, var_5);

  if(isDefined(var_6) && var_6["hittype"] != "hittype_none") {
    var_2 = var_6["position"];
  }

  if(isDefined(var_2) && !istrue(var_1)) {
    if(istrue(level.ref_14089) && isscriptabledefined()) {
      var_2 = getclosestpointonnavmesh(var_2);
    }

    var_7 = scripts\mp\gametypes\br_c130::ispointinbounds(var_2, 1, 0) && !fnlookforvehicles(var_2);

    if(!istrue(var_7)) {
      var_2 = undefined;
    }
  }

  return var_2;
}

function fnlookforvehicles(var_0) {
  var_1 = 0;
  var_2 = level.focus_fire_attacker_timeout;
  var_3 = getdvarint("scr_dmz_airdrop_min_dist", 10000);
  var_4 = var_3 * var_3;

  foreach(var_6 in var_2) {
    if(distance2dsquared(var_0, var_6.origin) < var_4) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

function fntrapactivation(var_0) {
  var_1 = "mp/loot_set_airdrop_contents_dmz.csv";
  self.itemsdropped = 0;
  var_2 = [];

  if(!scripts\mp\gametypes\br_public::uniquelootitemid() && getDvar("scr_br_gametype", "") != "rat_race") {
    var_3 = scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "killstreak", var_1);
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  var_3 = scripts\mp\gametypes\br_lootcache::chooseandspawnitems(4, 1, "weapon", var_1);
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  var_3 = scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 2, "health", var_1);
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  var_3 = scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 2, "ammo", var_1);
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);

  if(!scripts\mp\gametypes\br_public::uniquelootitemid() && getdvarint("scr_dmz_airdrop_drop_tablet", 0) == 1) {
    var_3 = scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "tablet", var_1);
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  var_4 = randomint(3);

  if(var_4 == 2) {
    var_3 = scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "revive", var_1);
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  var_5 = 750;

  if(isDefined(level.br_checkforlaststandwipe)) {
    var_5 = level.br_checkforlaststandwipe;
  }

  if(istrue(level.convoy_handle_stuck_compromise)) {
    var_5 = int(var_5 * level.ref_12192);
  }

  var_6 = undefined;

  if(isDefined(level.br_circle_init_func)) {
    var_6 = level.br_circle_init_func;
  }

  var_7 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_7.ml_p3_to_safehouse_transition = self.itemsdropped;
  var_3 = scripts\mp\gametypes\br_plunder::dropplunderbyrarity(var_5, var_7, var_6);
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);

  foreach(var_9 in var_2) {
    var_9.ref_11A40 = "c130_box";
  }

  if(!isDefined(var_0.ref_11A01)) {
    var_0.ref_11A01 = 1;
  } else {
    var_0.ref_11A01++;
  }

  var_0 scripts\mp\utility\stats::setextrascore1(var_0.ref_11A01);
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("br_c130_box_open");
}