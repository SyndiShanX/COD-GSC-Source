/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_261e315c49e5e4ef.gsc
*************************************************/

#using script_728ffcee8cbf30ee;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_supply_drops_common;
#using scripts\mp\gametypes\br_vip_quest;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#namespace namespace_e84530fe9afbbd74;

function init() {
  scripts\mp\gametypes\br_supply_drops_common::init();

  if(getdvarint(@ "scr_br_elite_broken_arrow", 0) && !getdvarint(@ "hash_82bde055b11e6698", 0) && isDefined(level.arrow)) {
    dropstruct = scripts\mp\gametypes\br_supply_drops_common::function_69b2e5235bfb7998("br_elite_arrow_bombsite_drop", "military_carepackage_01_cq");
    dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("br_elite_arrow_bombsite_drop", "planeDropRun", &function_4583dcd65450a629);
    dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("br_elite_arrow_bombsite_drop", "spawnDropCrate", &function_849aa3a04cef2d5c);
    dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("br_elite_arrow_bombsite_drop", "supplyDropFall", &function_daaa2ba7597fe13e);
    dropstruct function_90692628e3f5a1c1();
  }

  if(!getdvarint(@ "hash_48cbd77125939b20", 1)) {
    dropstruct = scripts\mp\gametypes\br_supply_drops_common::function_69b2e5235bfb7998("legendary_supply_drop");
    dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("legendary_supply_drop", "planeDropRun", &function_4583dcd65450a629);
    dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("legendary_supply_drop", "spawnDropCrate", &function_54fed18839fe1a00);
    dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("legendary_supply_drop", "supplyDropFall", &function_8e11624a19039380);
    dropstruct function_20d10ab03caa7c74();
  }

  if(!getdvarint(@ "hash_4c8e33496c92cd2e", 0)) {
    dropstruct = scripts\mp\gametypes\br_supply_drops_common::function_69b2e5235bfb7998("br_loadout_drop");
    dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("br_loadout_drop", "spawnDropCrate", &function_70500b035ce9f1c);
    dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("br_loadout_drop", "supplyDropFall", &function_4d10308e44e23ac2);
    dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("br_loadout_drop", "onPlayerEnterGulag", &function_fd96e89abd30cc4f);
    dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("br_loadout_drop", "onPlayerRespawn", &function_de7e06e42793bd7f);
    game["dialog"]["dropbag_incoming"] = "drpb_grav_gmst";
  }

  scripts\common\callbacks::callback("br_supply_drops_init");
}

function function_4583dcd65450a629(dropstruct) {
  thread scripts\mp\gametypes\br_supply_drops_common::function_c28362a9638e7931(dropstruct);
}

function function_849aa3a04cef2d5c(dropend, dropstruct) {
  crate = function_8992a7892fe3a42c(dropend);
  return crate;
}

function function_daaa2ba7597fe13e(dropend, dropstruct) {
  crate = self;
  crate thread function_f19fdce841e05d0d(dropend, dropstruct);
}

function function_20d10ab03caa7c74() {
  dropstruct = self;
  dropstruct.var_2e0d8ba0a46ce1b1 = 1;
  dropstruct.zoffset = level.var_5d2af95280a3cf58 * -0.5;
}

function function_54fed18839fe1a00(dropend, dropstruct) {
  dropstart = dropend + (0, 0, level.var_5d2af95280a3cf58 / 2 - 600);
  angles = (0, 0, 0);
  crate = scripts\cp_mp\killstreaks\airdrop::createcrate(undefined, undefined, "legendary_supply_drop", dropstart, angles, dropend, undefined, 1);

  if(isDefined(crate)) {
    crate.nochute = 1;
    crate.var_4cd5b8f62d173211 = 1;
  }

  return crate;
}

function function_8e11624a19039380(dropend, dropstruct) {
  level endon("game_ended");
  level endon("br_ending_start");
  crate = self;

  if(isDefined(crate)) {}
}

function function_70500b035ce9f1c(dropend, dropstruct) {
  dropstart = dropend + (0, 0, level.var_5d2af95280a3cf58);
  crate = scripts\cp_mp\killstreaks\airdrop::dropbrloadoutcrate("neutral", dropstart, dropend);

  if(isDefined(crate)) {
    crate.nochute = 1;
    crate.var_4cd5b8f62d173211 = 1;
  }

  return crate;
}

function function_4d10308e44e23ac2(dropend, dropstruct) {
  level endon("game_ended");
  level endon("br_ending_start");
  crate = self;

  if(isDefined(crate)) {
    crate function_a37db87a4770b8a();
    crate childthread function_c8a76e7b9d477bcc();
    crate childthread function_643937a5f43eb434();
    crate childthread function_9e398892d48ba3a6();
    level notify("loadout_crate_fall", crate);
  }
}

function function_607167c18661377b(var_70bcbf0ad5028219, droptype, disablesplash) {
  level notify("loadout_plane_stop");
  level endon("loadout_plane_stop");
  level endon("game_ended");
  level endon("br_ending_start");
  var_308d5f146d61745d = getdvarint(@ "hash_4cc81b833e45a79d", 3);

  if(var_308d5f146d61745d == 0) {
    return;
  }

  if(!isDefined(droptype)) {
    droptype = "br_loadout_drop";
  }

  totaldelay = 0;

  for(i = 0; i < var_70bcbf0ad5028219.size; i++) {
    delaytime = var_70bcbf0ad5028219[i];
    waittime = delaytime - totaldelay;

    if(waittime <= 0) {
      continue;
    }

    wait waittime;
    totaldelay = delaytime;
    multicirclecount = 1;

    if(istrue(level.var_2df69b8e552238b6) && !function_29e8194ff7e13e2e() && !function_d8fbacc18e5d8498()) {
      multicirclecount = function_d987886bb9de9137();
    }

    cratecount = getdvarint(@ "hash_711a9f3cf948c5c9", 8);

    if(i > 0) {
      cratecount = getdvarint(@ "hash_b3d8a888eea5f976", 3);
      var_308d5f146d61745d = 1;
    }

    if(multicirclecount > 1) {
      var_2e0d8ba0a46ce1b1 = int(ceil(cratecount / multicirclecount));

      for(multiindex = 0; multiindex < multicirclecount; multiindex++) {
        function_c3d1f879c57a12a6(var_2e0d8ba0a46ce1b1, multiindex, undefined, undefined, droptype);
        waitframe();
      }
    } else if(var_308d5f146d61745d == 2) {
      function_bdc1fb0f306d02fa(cratecount, droptype);
    } else if(var_308d5f146d61745d == 3) {
      function_f12f1b0fd0c95b97(cratecount, droptype);
    } else {
      function_c3d1f879c57a12a6(cratecount, 0, undefined, undefined, droptype);
    }

    if(!isDefined(disablesplash) || !disablesplash) {
      level childthread function_792f056feea2f3c9();
    }
  }
}

function function_bdc1fb0f306d02fa(cratecount, droptype) {
  var_821b13082f214589 = randomfloatrange(0, 360);
  var_2e0d8ba0a46ce1b1 = int(ceil(cratecount / 2));
  function_c3d1f879c57a12a6(var_2e0d8ba0a46ce1b1, 0, var_821b13082f214589, undefined, droptype);
  crosswait = getdvarfloat(@ "hash_f96cf03ab951508e", 2);

  if(crosswait > 0) {
    wait crosswait;
  }

  offsetangle = 90;
  randomoffset = randomfloatrange(-5, 5);
  var_821b13082f214589 = angleclamp(var_821b13082f214589 + offsetangle + randomoffset);
  function_c3d1f879c57a12a6(var_2e0d8ba0a46ce1b1, 0, var_821b13082f214589, undefined, droptype);
}

function function_f12f1b0fd0c95b97(cratecount, droptype) {
  var_821b13082f214589 = randomfloatrange(0, 360);

  if(getdvarint(@ "hash_89202350d7308671", 1)) {
    circlecenter = getsafecircleorigin();
    var_821b13082f214589 = vectortoyaw(circlecenter * -1);
  }

  var_2e0d8ba0a46ce1b1 = int(ceil(cratecount / 3));
  offsetpct = getdvarfloat(@ "hash_407d738b9ba721fd", 0.5);
  function_c3d1f879c57a12a6(var_2e0d8ba0a46ce1b1, 0, var_821b13082f214589, 0, droptype);
  formationwait = getdvarfloat(@ "hash_974235136f18adef", 5);

  if(formationwait > 0) {
    wait formationwait;
  }

  function_c3d1f879c57a12a6(var_2e0d8ba0a46ce1b1, 0, var_821b13082f214589, offsetpct, droptype);
  waitframe();
  function_c3d1f879c57a12a6(var_2e0d8ba0a46ce1b1, 0, var_821b13082f214589, -1 * offsetpct, droptype);
}

function function_c3d1f879c57a12a6(var_2e0d8ba0a46ce1b1, multicircleindex, var_d9aa6a35eb465619, var_eda78f398e8dfbde, droptype) {
  if(!isDefined(droptype)) {
    droptype = "br_loadout_drop";
  }

  dropstruct = level.supplydroptypes[droptype];

  if(!isDefined(dropstruct)) {
    scripts\mp\utility\script::demoforcesre("Supply drop type \"" + droptype + "\" does not exist.");
    return;
  }

  var_e81e88a0ec548b57 = level.br_level.br_circleradii[0];

  if(var_2e0d8ba0a46ce1b1 <= 0 || var_e81e88a0ec548b57 <= 0) {
    return;
  }

  planespeed = scripts\mp\gametypes\br_supply_drops_common::function_1422ffcd34611fd1();
  droppos = getsafecircleorigin();
  circleradius = getsafecircleradius();

  if(istrue(level.var_2df69b8e552238b6)) {
    droppos = function_799fe4ee850f911(multicircleindex);
    circleradius = function_8a985543e6853bbd(multicircleindex);
  } else {
    usenextcircle = getdvarint(@ "hash_daf294d5b4e5a87a", 0);

    if(usenextcircle) {
      droppos = getnextsafecircleorigin();
      circleradius = getnextsafecircleradius();
    }
  }

  if(isDefined(level.var_e486acb8f70c45a2) && flag("chokehold_closed")) {
    droppos = getdangercircleorigin();
    circleradius = getdangercircleradius();
  }

  if(!isDefined(level.br_circle)) {
    circleradius = level.br_level.br_circleradii[0];
  }

  if(isDefined(var_d9aa6a35eb465619) && isDefined(var_eda78f398e8dfbde) && var_eda78f398e8dfbde != 0) {
    perpdir = vectorNormalize(anglestoright((0, var_d9aa6a35eb465619, 0)));
    offsetdist = var_eda78f398e8dfbde * circleradius;
    droppos += perpdir * offsetdist;
    circleradius = sqrt(squared(circleradius) - squared(offsetdist));
  }

  var_e12d1c28ef3db42a = circleradius * 2;
  pathdistance = var_e81e88a0ec548b57 * 2;
  bufferpercent = (var_e81e88a0ec548b57 - circleradius) / pathdistance;
  droptimer = var_e12d1c28ef3db42a / planespeed / (var_2e0d8ba0a46ce1b1 + 1);
  dropstruct.var_2e0d8ba0a46ce1b1 = var_2e0d8ba0a46ce1b1;
  dropstruct.bufferpercent = bufferpercent;
  dropstruct.checktimer = droptimer;
  dropstruct.var_322b7887f80acc62 = 1;
  dropstruct.zoffset = getdvarfloat(@ "hash_8f28d4ead9cec8ea", 1000) * multicircleindex;
  dropstruct.var_821b13082f214589 = var_d9aa6a35eb465619;
  skipinvalid = getdvarint(@ "hash_d62b4f29572ebf87", 1);

  if(skipinvalid) {
    dropstruct.var_5214bb02998ff284 = 1;
  }

  scripts\mp\gametypes\br_supply_drops_common::function_1a01863a6ec2ad05(droppos, droptype);
}

function function_792f056feea2f3c9() {
  level notify("crate_fall_watch");
  level endon("crate_fall_watch");
  level waittill("loadout_crate_fall");
  level childthread function_ad91760f4f41c169(2.5);
  level childthread function_ab8c6a785614ca99(1);
}

function function_ad91760f4f41c169(delaytime) {
  if(isDefined(delaytime) && delaytime > 0) {
    wait delaytime;
  }

  foreach(player in level.players) {
    if(isDefined(player) && isalive(player) && !player scripts\mp\gametypes\br_public::isplayeringulag()) {
      player thread scripts\mp\hud_message::showsplash("br_airdrop_incoming");
    }
  }
}

function function_ab8c6a785614ca99(delaytime) {
  if(isDefined(delaytime) && delaytime > 0) {
    wait delaytime;
  }

  if(!scripts\mp\gametypes\br_public::istutorial()) {
    scripts\mp\gametypes\br_public::brleaderdialog("dropbag_incoming", 1, undefined, 0, 2, undefined, "dx_br_dmzc_");
  }
}

function function_a37db87a4770b8a() {
  crate = self;
  crate.minimapicon = "ui_map_icon_drop_loadout";
  crate scripts\cp_mp\killstreaks\airdrop::createminimapicon();
  objid = crate.minimapid;

  if(isDefined(objid) && objid != -1) {
    crate setscriptablepartstate("objective_map", "custom");
    objective_state(objid, "current");
    objective_setownerteam(objid, "neutral");
    objective_setlabel(objid, &"MP_INGAME_ONLY/DROP_BAG_CAPS");
    objective_setzoffset(objid, 75);
    objective_setpings(objid, 1);
    function_a16750cd44f57931(objid, 1);
    function_865f9c5d005f9a08(objid, 1);
    var_467f4d9b8d9063b = getdvarfloat(@ "hash_e9d0abfe80024d80", 3937);
    var_d9db7be56114e3b9 = getdvarfloat(@ "hash_ec4adb02477bc5b2", 0.97);
    var_a7c6c5d6c3d369aa = var_467f4d9b8d9063b * var_d9db7be56114e3b9;
    function_c047d7ffe7a83501(objid, var_a7c6c5d6c3d369aa, var_467f4d9b8d9063b);

    foreach(player in level.players) {
      if(isalive(player) && !isbot(player) && !player scripts\mp\gametypes\br_public::isplayeringulag()) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, player);
      }
    }

    crate.scriptedobjid = objid;
  }
}

function function_c8a76e7b9d477bcc() {
  crate = self;
  crate notify("crate_impact_watch");
  crate endon("crate_impact_watch");
  crate endon("death");
  wait 1;
  crate waittill("collision");
  wait 1;
  var_49f7615f089f4575 = getdvarint(@ "hash_1263820ad3a08477", 60);

  if(var_49f7615f089f4575 > 0) {
    crate setscriptablepartstate("smoke_signal", "drop_plane_on", 0);
    wait var_49f7615f089f4575;

    if(getdvarint(@ "hash_ad77e9f65a2e05c2", 0)) {
      objid = crate.minimapid;

      if(isDefined(objid) && objid != -1) {
        objective_state(objid, "active");
      }
    }
  }

  crate setscriptablepartstate("smoke_signal", "off", 0);
}

function function_643937a5f43eb434() {
  if(getdvarint(@ "hash_33f880a10e8651ae", 0)) {
    return;
  }

  crate = self;
  crate notify("crate_capture_watch");
  crate endon("crate_capture_watch");
  crate endon("death");

  while(true) {
    crate waittill("brLoadoutPostCapture", player);
    objid = crate.minimapid;

    if(isDefined(player) && isDefined(objid) && objid != -1) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(objid, player);
    }
  }
}

function function_9e398892d48ba3a6() {
  crate = self;
  crate notify("crate_death_watch");
  crate endon("crate_death_watch");
  crate waittill("death");
  objid = crate.minimapid;

  if(isDefined(objid) && objid != -1) {
    scripts\mp\objidpoolmanager::returnobjectiveid(objid);
    crate.minimapid = undefined;
  }
}

function function_fd96e89abd30cc4f() {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  foreach(crate in level.br_pickups.crates) {
    if(isDefined(crate) && istrue(crate.var_4cd5b8f62d173211) && isDefined(crate.minimapid)) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.minimapid, player);
    }
  }
}

function function_de7e06e42793bd7f() {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  foreach(crate in level.br_pickups.crates) {
    if(isDefined(crate) && istrue(crate.var_4cd5b8f62d173211) && isDefined(crate.minimapid)) {
      if(!isDefined(crate.playersused) || !array_contains(crate.playersused, player)) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(crate.minimapid, player);
      }
    }
  }
}

function function_3241afdfec957cb9(player) {
  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("getSupplyDropCrateUsedFunction")) {
    func = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("getSupplyDropCrateUsedFunction", self);

    if(isDefined(func)) {
      return [[func]](player);
    }
  }

  switch (self.source) {
    case #"hash_a00e0121c83189e5":
      scripts\mp\gametypes\br_vip_quest::function_2410e069c697ba3c(player);
      break;
    case #"hash_5057f4744606f16e":
      playerarray = scripts\mp\utility\teams::getteamdata(player.team, "players");

      if(isDefined(level.var_f385b864293e8777) && isDefined(level.var_f385b864293e8777.var_17e70eb167a5dfa6)) {
        [[level.var_f385b864293e8777.var_17e70eb167a5dfa6]](self.item_rewards, self.origin, self.angles, playerarray, 0, self.score_event, self.include_ammo, self.ammo_count, player);
      }

      break;
    case #"hash_2b25ed45dea9b003":
      if(utility::issharedfuncdefined("sidequest_cursed", "supplyDropUsed")) {
        utility::function_f3bb4f4911a1beb2("sidequest_cursed", "supplyDropUsed", player);
      }

      break;
    default:
      assertmsg("<dev string:x1c>");
      break;
  }
}