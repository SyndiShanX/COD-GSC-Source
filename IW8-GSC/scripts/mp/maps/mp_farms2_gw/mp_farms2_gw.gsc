/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_farms2_gw\mp_farms2_gw.gsc
*********************************************************/

function main() {
  scripts\mp\maps\mp_farms2_gw\mp_farms2_gw_precache::main();
  scripts\mp\maps\mp_farms2_gw\gen\mp_farms2_gw_art::main();
  scripts\mp\maps\mp_farms2_gw\mp_farms2_gw_fx::main();
  scripts\mp\maps\mp_farms2_gw\mp_farms2_gw_lighting::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(level.localeid)) {
      setDvar("scr_localeID", 9);
    }

    scripts\mp\gametypes\arm::arm_initoutofbounds();
    thread ref_12e15();
    thread perkpackage_giveoverridefieldupgrades();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  scripts\mp\compass::setupminimap("compass_map_mp_farms2_gw");
  level thread scripts\engine\scriptable_door::system_init();
  setDvar("PKKMTTRQO", 8);
  setDvar("NSSMQLPRNT", 0.01);
  setDvar("SRQLQNLMK", 1);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "eastern_europe";
  thread runmisteffects();
  thread ref_136a5();
  thread player_fired_gun_monitor();
  thread ref_145f0();
  thread ref_12f8e();
}

function player_fired_gun_monitor() {
  var_0 = getEnt("clip64x64x8", "targetname");
  var_1 = spawn("script_model", (51682, -15944, -202));
  var_1.angles = (0, 0, -90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("clip64x64x8", "targetname");
  var_3 = spawn("script_model", (51532, -15944, -202));
  var_3.angles = (0, 0, -90);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("clip64x64x8", "targetname");
  var_5 = spawn("script_model", (51404, -15944, -202));
  var_5.angles = (0, 0, -90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("clip64x64x8", "targetname");
  var_7 = spawn("script_model", (51854, -15944, -202));
  var_7.angles = (0, 0, -90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
}

function ref_136a5() {
  var_0 = spawn("script_model", (46894.9, -8506.3, 343.159));
  var_0 setModel("ee_electronics_television_wall_mounted_large");
  var_0.angles = (0, 5, 0);
}

function runmisteffects() {
  if(getdvarint("scr_disable_mist", 0) != 0) {
    return;
  }

  var_0 = [];
  GscBinSkip0(0x2e, 0, (51013, 3186, 0));
}

function ref_12e15() {
  level.weaponstocycle = [];
  level.setallclientomnvarot[0] = (27210, -19254, 274);
  level.setallclientomnvarot[1] = (21201, -12856, -151);
  level.setallclientomnvarot[2] = (50746, 9531, 200);
  level.setallclientomnvarot[3] = (44321, 50943, 1029);
  level.setallclientomnvarot[4] = (27802, 59766, 4500);
  level.setallclientomnvarot[5] = (17533, 29553, 1600);
  level.setallclientomnvarot[6] = (6003, -1300, 1139);
  level.setallclientomnvarot[7] = (53845, -36604, 400);
  wait 15;
  thread ref_12e14();
  thread ref_12e13();
  thread ref_12e12();
}

function ref_12e11() {
  level.weapons_that_can_stun = [];
  level.weapons_that_can_stun[0] = (50804, 6322, 317);
  level.weapons_that_can_stun[1] = (50861, -32721, 1312);
  level.weapons_that_can_stun[2] = (30572, -14651, -285);
  level.weapons_that_can_stun[3] = (20039, -2025, -400);
  level.weapons_that_can_stun[4] = (38519, 9487, 194);
  level.weapons_that_can_stun[5] = (62592, -15849, 633);
  level.weapons_that_can_stun[6] = (21343, -11066, 1400);

  for(;;) {
    var_0 = randomintrange(0, level.weapons_that_can_stun.size);
    var_1 = level.weapons_that_can_stun[var_0];
    playFX(scripts\engine\utility::getfx("vfx_gw_lrg_explosion"), var_1 + (randomfloatrange(-1500, 1500), randomfloatrange(-1500, 1500), 0));
    wait 0.5;
    playFX(scripts\engine\utility::getfx("vfx_gw_lrg_explosion"), var_1 + (randomfloatrange(-2500, 2500), randomfloatrange(-2500, 2500), 0));
    wait randomfloatrange(1, 2);
    playFX(scripts\engine\utility::getfx("vfx_gw_lrg_explosion"), var_1 + (randomfloatrange(-1500, 1500), randomfloatrange(-1500, 1500), 0));
    wait 0.25;
    playFX(scripts\engine\utility::getfx("vfx_gw_lrg_explosion"), var_1 + (randomfloatrange(-2500, 2500), randomfloatrange(-2500, 2500), 0));
    wait randomfloatrange(0.5, 2);
  }
}

function ref_12e14() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, (53038, -38220, 15150));
}

function ref_12e12() {
  playFX(scripts\engine\utility::getfx("vfx_gw_ambient_planes"), (9697, -10409, -170), (9, 0, 0));
  playFX(scripts\engine\utility::getfx("vfx_gw_ambient_planes"), (65867, -30562, 1622), (14, 142, 0));
}

function ref_12e13() {
  foreach(var_1 in level.setallclientomnvarot) {
    playFX(scripts\engine\utility::getfx("vfx_gw_smoke_plume_bg_01"), var_1, (0, 100, 0));
  }
}

function perkpackage_giveoverridefieldupgrades() {
  wait 5;
  var_0 = spawn("sound_transient_soundbanks", (0, 0, 0));
  var_0 settransientsoundbank("donetsk_farms2.all", 1);
}

function ref_145f0() {
  var_0 = getdvarint("OKSRMNKKOS", 0);
  wait 3;

  switch (var_0) {
    case 0:
      break;
    case 1:
      playFX(scripts\engine\utility::getfx("gas_realfar"), (46720, -11343, 700));
      break;
    case 2:
      playFX(scripts\engine\utility::getfx("gas_far"), (46720, -11343, 700));
      break;
    case 3:
      playFX(scripts\engine\utility::getfx("gas_medium"), (46720, -11343, 700));
      break;
    case 4:
      playFX(scripts\engine\utility::getfx("gas_close"), (46720, -11343, 700));
      break;
  }
}

function ref_12f8e() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "siege":
      if(!isDefined(game["roundsPlayed"]) || game["roundsPlayed"] == 0) {
        break;
      } else {
        GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_gw_spawn_axis_start_mod", (48642.2, -23600.2, -396.069), (0, 90, 0)));
      }

      break;
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}