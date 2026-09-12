/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_quarry2\mp_quarry2.gsc
*****************************************************/

function main() {
  scripts\mp\maps\mp_quarry2\mp_quarry2_precache::main();
  scripts\mp\maps\mp_quarry2\gen\mp_quarry2_art::main();
  scripts\mp\maps\mp_quarry2\mp_quarry2_fx::main();
  scripts\mp\maps\mp_quarry2\mp_quarry2_lighting::main();
  scripts\mp\load::main();
  setDvar("r_st_lodDistanceScale", 1);
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "br") {
    brinit();
  }

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(level.localeid)) {
      setDvar("scr_localeID", 5);
    }

    if(!scripts\mp\utility\game::unset_relic_landlocked()) {
      brinit();
    }

    scripts\mp\gametypes\arm::arm_initoutofbounds();
    thread ref_12E15();
    thread ref_12960();
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_quarry2");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("r_umbraMinObjectContribution", 8);
  level thread scripts\engine\scriptable_door::system_init();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.mapsafecorners = [];
  level.mapsafecorners[0] = (5000, 6000, 0);
  level.mapsafecorners[1] = (-8000, -200, 0);
  level.mapboundrycorners = [];
  level.mapboundrycorners[0] = (5500, 6500, 0);
  level.mapboundrycorners[1] = (-8500, -500, 0);
  thread player_fired_gun_monitor();
  thread runmisteffects();
  thread ref_12F8E();
}

function player_fired_gun_monitor() {
  var_0 = getEnt("clip32x32x256", "targetname");
  var_1 = spawn("script_model", (40282, 45823, 1027));
  var_1.angles = (0, 15, -90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("clip32x32x32", "targetname");
  var_3 = spawn("script_model", (35248, 45128, 1312));
  var_3.angles = (0, 315, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("clip256x256x8", "targetname");
  var_5 = spawn("script_model", (35997, 46300, 809));
  var_5.angles = (90, 315, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("clip64x64x64", "targetname");
  var_7 = spawn("script_model", (29748, 43260, 776));
  var_7.angles = (0, 285, -30);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = scripts\engine\utility::getStructArray("lighttank_drop", "targetname");

  foreach(var_10 in var_8) {
    if(var_10.origin == (27241.5, 30626.5, 667)) {
      var_10.origin = (27369.5, 31074.5, 667);
    }
  }
}

function brinit() {
  level.br_level = spawnStruct();
  level.br_level.br_corners = [];
  level.br_level.br_corners[0] = (5000, 6000, 0);
  level.br_level.br_corners[1] = (-8000, -200, 0);
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (5500, 6500, 0);
  level.br_level.br_mapbounds[1] = (-8500, -500, 0);
  level.br_level.c130_speedoverride = 1000;
  scripts\mp\gametypes\br_c130::setc130heightoverrides(6000, 0);
  level.br_level.br_guncount = 50;
  level.br_level.br_equipcount = 50;
  level.br_level.firstclosetime = 60;
  level.br_level.firstdelaytime = 45;
  level.br_level.firstradius = 10500;
  level.br_level.firstminimapradius = 4000;
  level.br_level.br_circleclosetimes = [40, 25, 20, 15];
  level.br_level.br_circledelaytimes = [10, 10, 20, 20];
  level.br_level.br_circleradii = [7000, 4500, 2500, 1000, 0];
  level.br_level.br_circlestaticvfx = ["vfx_br_zone_7000_static_s", "vfx_br_zone_4500_static_s", "vfx_br_zone_2500_static_s", "vfx_br_zone_1000_static_s"];
  level.br_level.br_circledynamicvfx = ["vfx_br_zone_10500_7000_s", "vfx_br_zone_7000_4500_s", "vfx_br_zone_4500_2500_s", "vfx_br_zone_2500_1000_s", "vfx_br_zone_1000_0_s"];
}

function runmisteffects() {
  if(getdvarint("scr_disable_mist", 0) != 0) {
    return;
  }

  var_0 = [];
  GscBinSkip0(0x2e, 0, (48357, 15493, 5));
}

function ref_12E15() {
  level.weaponstocycle = [];
  level.setallclientomnvarot[0] = (9932, 40850, 2000);
  level.setallclientomnvarot[1] = (11813, 24170, 1400);
  level.setallclientomnvarot[2] = (44793, 18312, -300);
  level.setallclientomnvarot[3] = (44321, 50943, 1029);
  level.setallclientomnvarot[4] = (27802, 59766, 4500);
  level.setallclientomnvarot[5] = (17533, 29553, 1600);
  level.setallclientomnvarot[6] = (5654, -1600, 456);
  wait 8;
  thread ref_12E14();
  thread ref_12E13();
  thread ref_12E12();
}

function ref_12E11() {
  level.weapons_that_can_stun = [];
  level.weapons_that_can_stun[0] = (19730, 30320, 1541);
  level.weapons_that_can_stun[1] = (17414, 38445, 1100);
  level.weapons_that_can_stun[2] = (46709, 16278, -300);
  level.weapons_that_can_stun[3] = (37746, 26820, 280);
  level.weapons_that_can_stun[4] = (29320, 50046, 2798);
  level.weapons_that_can_stun[5] = (14700, 60220, 2727);
  level.weapons_that_can_stun[6] = (24479, 23645, 1450);
  level.weapons_that_can_stun[7] = (67607, 39784, 6300);
  level.weapons_that_can_stun[8] = (57384, 71389, 9348);

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
    wait randomfloatrange(0.5, 1);
  }
}

function ref_12E14() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, (5430, 25860, 100));
}

function ref_12E10() {
  playFX(scripts\engine\utility::getfx("vfx_gw_flak_explosions"), (16019, 27466, 1000));
}

function ref_12E12() {
  playFX(scripts\engine\utility::getfx("vfx_gw_ambient_planes"), (-6683, 31192, 2772), (2, 10, 0));
  playFX(scripts\engine\utility::getfx("vfx_gw_ambient_planes"), (37881, 63083, 3712), (7, 251, 0));
}

function ref_12E13() {
  foreach(var_1 in level.setallclientomnvarot) {
    playFX(scripts\engine\utility::getfx("vfx_gw_smoke_plume_bg_01"), var_1, (0, 100, 0));
  }
}

function ref_12960() {
  wait 5;
  var_0 = spawn("sound_transient_soundbanks", (0, 0, 0));
  var_0 settransientsoundbank("donetsk_quarry2.all", 1);
}

function ref_12F8E() {
  level.modifiedspawnpoints["23354 30711"]["mp_tdm_spawn"]["remove"] = 1;
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "siege":
      if(!isDefined(game["roundsPlayed"]) || game["roundsPlayed"] == 0) {
        break;
      } else {
        GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_gw_spawn_axis_start_mod", (25726.2, 29493.4, 659.5), (0, 45, 0)));
      }

      break;
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}