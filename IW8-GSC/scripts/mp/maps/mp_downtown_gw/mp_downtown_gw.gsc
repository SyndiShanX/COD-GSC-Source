/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_downtown_gw\mp_downtown_gw.gsc
*************************************************************/

function main() {
  _setplayerteamrank::keypad_check_levelinput();
  _start_spawn_modules::keypad_check_levelinput();
  scripts\mp\maps\mp_downtown_gw\mp_downtown_gw_precache::main();
  scripts\mp\maps\mp_downtown_gw\gen\mp_downtown_gw_art::main();
  scripts\mp\maps\mp_downtown_gw\mp_downtown_gw_fx::main();
  scripts\mp\maps\mp_downtown_gw\mp_downtown_gw_lighting::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      setDvar("scr_localeID", 6);
    }

    scripts\mp\gametypes\arm::arm_initoutofbounds();
    thread ref_12e15();
    thread minarmordropondeath();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  scripts\mp\compass::setupminimap("compass_map_mp_downtown_gw");
  setDvar("PKKMTTRQO", 8);
  setDvar("NSSMQLPRNT", 0.01);
  setDvar("SRQLQNLMK", 1);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "eastern_europe";
  thread player_exfil_struct();
  thread player_exit();
  thread setlowermessageomnvarref();
  thread ref_145f0();
  thread ref_12f8e();
}

function ref_12e15() {
  level.weaponstocycle = [];
  level.setallclientomnvarot[0] = (7298, -26583, -199);
  level.setallclientomnvarot[1] = (31947, 8236, -108);
  level.setallclientomnvarot[2] = (50746, 9531, 200);
  level.setallclientomnvarot[3] = (44321, 50943, 1029);
  level.setallclientomnvarot[4] = (27802, 59766, 4500);
  level.setallclientomnvarot[5] = (17533, 29553, 1600);
  level.setallclientomnvarot[6] = (4457, 227, 84);
  level.setallclientomnvarot[7] = (53887, -33922, 1383);
  wait 15;
  thread ref_12e14();
  thread ref_12e13();
  thread ref_12e12();
}

function ref_12e11() {
  level.weapons_that_can_stun = [];
  level.weapons_that_can_stun[0] = (9222, -19971, -202);
  level.weapons_that_can_stun[1] = (10809, -10631, 306);
  level.weapons_that_can_stun[2] = (40307, -9808, 477);
  level.weapons_that_can_stun[3] = (37474, -23592, -501);
  level.weapons_that_can_stun[4] = (16705, -36174, 398);
  level.weapons_that_can_stun[5] = (23886, 17882, 566);
  level.weapons_that_can_stun[6] = (6650, 7176, 176);

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

function ref_12e14() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, (35313, 5404, -641));
}

function ref_12e12() {
  playFX(scripts\engine\utility::getfx("vfx_gw_ambient_planes"), (-7956, 8572, -308), (10, 316, 0));
  playFX(scripts\engine\utility::getfx("vfx_gw_ambient_planes"), (57277, -44955, 1719), (12, 134, 0));
}

function ref_12e13() {
  foreach(var_1 in level.setallclientomnvarot) {
    playFX(scripts\engine\utility::getfx("vfx_gw_smoke_plume_bg_01"), var_1, (0, 100, 0));
  }
}

function minarmordropondeath() {
  wait 5;
  var_0 = spawn("sound_transient_soundbanks", (0, 0, 0));
  var_0 settransientsoundbank("donetsk_dwn_twn.all", 1);
}

function player_exfil_struct() {
  var_0 = getEnt("care_package_col", "targetname");
  var_1 = spawn("script_model", (18612, -12854, -104));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("care_package_col", "targetname");
  var_3 = spawn("script_model", (18612, -12902, -104));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("care_package_col", "targetname");
  var_5 = spawn("script_model", (18612, -12948, -104));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("care_package_col", "targetname");
  var_7 = spawn("script_model", (18612, -12996, -104));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("clip64x64x64", "targetname");
  var_9 = spawn("script_model", (23564, -13916, -224));
  var_9.angles = (0, 0, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("clip128x128x8", "targetname");
  var_11 = spawn("script_model", (23910, -18278, 456));
  var_11.angles = (270, 311.634, 93.3662);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("clip128x128x8", "targetname");
  var_13 = spawn("script_model", (24000, -18368, 456));
  var_13.angles = (270, 311.634, 93.3662);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("clip128x128x8", "targetname");
  var_15 = spawn("script_model", (24072, -18440, 456));
  var_15.angles = (270, 311.634, 93.3662);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("player32x32x256", "targetname");
  var_17 = spawn("script_model", (17258.5, -17452.6, 752));
  var_17.angles = (0, 135, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getEnt("player32x32x256", "targetname");
  var_19 = spawn("script_model", (17280.5, -17474.6, 752));
  var_19.angles = (0, 135, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_20 = getEnt("clip128x128x8", "targetname");
  var_21 = spawn("script_model", (21960, -10656, 168));
  var_21.angles = (0, 0, 0);
  var_21 clonebrushmodeltoscriptmodel(var_20);
  var_22 = getEnt("clip128x128x8", "targetname");
  var_23 = spawn("script_model", (21960, -10784, 168));
  var_23.angles = (0, 0, 0);
  var_23 clonebrushmodeltoscriptmodel(var_22);
  var_24 = getEnt("clip128x128x8", "targetname");
  var_25 = spawn("script_model", (21960, -10912, 168));
  var_25.angles = (0, 0, 0);
  var_25 clonebrushmodeltoscriptmodel(var_24);
  var_26 = getEnt("clip128x128x8", "targetname");
  var_27 = spawn("script_model", (21960, -11040, 168));
  var_27.angles = (0, 0, 0);
  var_27 clonebrushmodeltoscriptmodel(var_26);
  var_28 = getEnt("clip128x128x8", "targetname");
  var_29 = spawn("script_model", (21960, -11168, 168));
  var_29.angles = (0, 0, 0);
  var_29 clonebrushmodeltoscriptmodel(var_28);
  var_30 = getEnt("clip128x128x8", "targetname");
  var_31 = spawn("script_model", (21960, -11296, 168));
  var_31.angles = (0, 0, 0);
  var_31 clonebrushmodeltoscriptmodel(var_30);
  var_32 = getEnt("clip128x128x8", "targetname");
  var_33 = spawn("script_model", (21960, -11424, 168));
  var_33.angles = (0, 0, 0);
  var_33 clonebrushmodeltoscriptmodel(var_32);
  var_34 = getEnt("clip128x128x8", "targetname");
  var_35 = spawn("script_model", (21952, -11592, 168));
  var_35.angles = (0, 0, 0);
  var_35 clonebrushmodeltoscriptmodel(var_34);
  var_36 = getEnt("clip128x128x8", "targetname");
  var_37 = spawn("script_model", (21952, -11728, 168));
  var_37.angles = (0, 0, 0);
  var_37 clonebrushmodeltoscriptmodel(var_36);
  var_38 = getEnt("clip128x128x8", "targetname");
  var_39 = spawn("script_model", (21952, -11864, 168));
  var_39.angles = (0, 0, 0);
  var_39 clonebrushmodeltoscriptmodel(var_38);
  var_40 = getEnt("clip128x128x128", "targetname");
  var_41 = spawn("script_model", (17800, -79828, 464));
  var_41.angles = (0, 45, 0);
  var_41 clonebrushmodeltoscriptmodel(var_40);
  var_42 = getEnt("clip128x128x128", "targetname");
  var_43 = spawn("script_model", (17800, -19828, 336));
  var_43.angles = (0, 45, 0);
  var_43 clonebrushmodeltoscriptmodel(var_42);
  var_44 = getEnt("clip128x128x128", "targetname");
  var_45 = spawn("script_model", (17800, -19828, 208));
  var_45.angles = (0, 45, 0);
  var_45 clonebrushmodeltoscriptmodel(var_44);
  var_46 = getEnt("clip128x128x128", "targetname");
  var_47 = spawn("script_model", (17800, -19828, 80));
  var_47.angles = (0, 45, 0);
  var_47 clonebrushmodeltoscriptmodel(var_46);
  var_48 = getEnt("clip128x128x128", "targetname");
  var_49 = spawn("script_model", (17870, -19848, 464));
  var_49.angles = (0, 45, 0);
  var_49 clonebrushmodeltoscriptmodel(var_48);
  var_50 = getEnt("clip128x128x128", "targetname");
  var_51 = spawn("script_model", (17870, -19848, 336));
  var_51.angles = (0, 45, 0);
  var_51 clonebrushmodeltoscriptmodel(var_50);
  var_52 = getEnt("clip128x128x128", "targetname");
  var_53 = spawn("script_model", (17870, -19848, 208));
  var_53.angles = (0, 45, 0);
  var_53 clonebrushmodeltoscriptmodel(var_52);
  var_54 = getEnt("clip128x128x128", "targetname");
  var_55 = spawn("script_model", (17870, -19848, 80));
  var_55.angles = (0, 45, 0);
  var_55 clonebrushmodeltoscriptmodel(var_54);
  var_56 = getEnt("clip128x128x128", "targetname");
  var_57 = spawn("script_model", (17936, -19828, 464));
  var_57.angles = (0, 45, 0);
  var_57 clonebrushmodeltoscriptmodel(var_56);
  var_58 = getEnt("clip128x128x128", "targetname");
  var_59 = spawn("script_model", (17936, -19828, 336));
  var_59.angles = (0, 45, 0);
  var_59 clonebrushmodeltoscriptmodel(var_58);
  var_60 = getEnt("clip128x128x128", "targetname");
  var_61 = spawn("script_model", (17936, -19828, 208));
  var_61.angles = (0, 45, 0);
  var_61 clonebrushmodeltoscriptmodel(var_60);
}

function player_exit() {
  var_0 = getEnt("clip128x128x128", "targetname");
  var_1 = spawn("script_model", (17936, -19828, 80));
  var_1.angles = (0, 45, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("clip64x64x64", "targetname");
  var_3 = spawn("script_model", (16512, -15392, 8));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("clip64x64x64", "targetname");
  var_5 = spawn("script_model", (16512, -15392, 72));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("clip64x64x64", "targetname");
  var_7 = spawn("script_model", (16512, -15392, 136));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("clip64x64x64", "targetname");
  var_9 = spawn("script_model", (16512, -15392, 200));
  var_9.angles = (0, 0, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("clip64x64x64", "targetname");
  var_11 = spawn("script_model", (16512, -15392, 296));
  var_11.angles = (0, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("clip64x64x64", "targetname");
  var_13 = spawn("script_model", (16512, -15392, 360));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("clip128x128x8", "targetname");
  var_15 = spawn("script_model", (172876, -17567.8, -31.5));
  var_15.angles = (270, 37.6, -172.62);
  var_15 clonebrushmodeltoscriptmodel(var_14);
}

function setlowermessageomnvarref() {
  var_0 = spawn("trigger_radius", (22824, -13160, -1360), 0, 15848, 715);
  thread ref_12e19();
  var_1 = spawn("trigger_radius", (21969, -10078, -190), 0, 160, 128);
  thread ref_12e19();
}

function ref_12e19() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      var_0 dodamage(10000, var_0.origin, self, self, "MOD_TRIGGER_HURT");
    }
  }
}

function ref_145f0() {
  var_0 = getdvarint("OKSRMNKKOS", 0);
  wait 3;

  switch (var_0) {
    case 0:
      break;
    case 1:
      playFX(scripts\engine\utility::getfx("gas_realfar"), (21593, -13938, -89));
      break;
    case 2:
      playFX(scripts\engine\utility::getfx("gas_far"), (21593, -13938, -89));
      break;
    case 3:
      playFX(scripts\engine\utility::getfx("gas_medium"), (21593, -13938, -89));
      break;
    case 4:
      playFX(scripts\engine\utility::getfx("gas_close"), (21593, -13938, -89));
      break;
  }
}

function ref_12f8e() {
  level.modifiedspawnpoints["19982 -13043"]["mp_tdm_spawn"]["remove"] = 1;
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "siege":
      if(!isDefined(game["roundsPlayed"]) || game["roundsPlayed"] == 0) {
        break;
      } else {
        GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_gw_spawn_allies_start_mod", (20822.7, -2227.94, -507.48), (0, 225, 0)));
      }

      break;
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}