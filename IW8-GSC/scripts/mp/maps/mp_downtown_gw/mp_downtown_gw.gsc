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
    var0 = randomintrange(0, level.weapons_that_can_stun.size);
    var1 = level.weapons_that_can_stun[var0];
    playFX(scripts\engine\utility::getfx("vfx_gw_lrg_explosion"), var1 + (randomfloatrange(-1500, 1500), randomfloatrange(-1500, 1500), 0));
    wait 0.5;
    playFX(scripts\engine\utility::getfx("vfx_gw_lrg_explosion"), var1 + (randomfloatrange(-2500, 2500), randomfloatrange(-2500, 2500), 0));
    wait randomfloatrange(1, 2);
    playFX(scripts\engine\utility::getfx("vfx_gw_lrg_explosion"), var1 + (randomfloatrange(-1500, 1500), randomfloatrange(-1500, 1500), 0));
    wait 0.25;
    playFX(scripts\engine\utility::getfx("vfx_gw_lrg_explosion"), var1 + (randomfloatrange(-2500, 2500), randomfloatrange(-2500, 2500), 0));
    wait randomfloatrange(0.5, 1);
  }
}

function ref_12e14() {
  var0 = [];
  GscBinSkip0(0x2e, 0, (35313, 5404, -641));
}

function ref_12e12() {
  playFX(scripts\engine\utility::getfx("vfx_gw_ambient_planes"), (-7956, 8572, -308), (10, 316, 0));
  playFX(scripts\engine\utility::getfx("vfx_gw_ambient_planes"), (57277, -44955, 1719), (12, 134, 0));
}

function ref_12e13() {
  foreach(var1 in level.setallclientomnvarot) {
    playFX(scripts\engine\utility::getfx("vfx_gw_smoke_plume_bg_01"), var1, (0, 100, 0));
  }
}

function minarmordropondeath() {
  wait 5;
  var0 = spawn("sound_transient_soundbanks", (0, 0, 0));
  var0 settransientsoundbank("donetsk_dwn_twn.all", 1);
}

function player_exfil_struct() {
  var0 = getEnt("care_package_col", "targetname");
  var1 = spawn("script_model", (18612, -12854, -104));
  var1.angles = (0, 0, 0);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("care_package_col", "targetname");
  var3 = spawn("script_model", (18612, -12902, -104));
  var3.angles = (0, 0, 0);
  var3 clonebrushmodeltoscriptmodel(var2);
  var4 = getEnt("care_package_col", "targetname");
  var5 = spawn("script_model", (18612, -12948, -104));
  var5.angles = (0, 0, 0);
  var5 clonebrushmodeltoscriptmodel(var4);
  var6 = getEnt("care_package_col", "targetname");
  var7 = spawn("script_model", (18612, -12996, -104));
  var7.angles = (0, 0, 0);
  var7 clonebrushmodeltoscriptmodel(var6);
  var8 = getEnt("clip64x64x64", "targetname");
  var9 = spawn("script_model", (23564, -13916, -224));
  var9.angles = (0, 0, 0);
  var9 clonebrushmodeltoscriptmodel(var8);
  var10 = getEnt("clip128x128x8", "targetname");
  var11 = spawn("script_model", (23910, -18278, 456));
  var11.angles = (270, 311.634, 93.3662);
  var11 clonebrushmodeltoscriptmodel(var10);
  var12 = getEnt("clip128x128x8", "targetname");
  var13 = spawn("script_model", (24000, -18368, 456));
  var13.angles = (270, 311.634, 93.3662);
  var13 clonebrushmodeltoscriptmodel(var12);
  var14 = getEnt("clip128x128x8", "targetname");
  var15 = spawn("script_model", (24072, -18440, 456));
  var15.angles = (270, 311.634, 93.3662);
  var15 clonebrushmodeltoscriptmodel(var14);
  var16 = getEnt("player32x32x256", "targetname");
  var17 = spawn("script_model", (17258.5, -17452.6, 752));
  var17.angles = (0, 135, 0);
  var17 clonebrushmodeltoscriptmodel(var16);
  var18 = getEnt("player32x32x256", "targetname");
  var19 = spawn("script_model", (17280.5, -17474.6, 752));
  var19.angles = (0, 135, 0);
  var19 clonebrushmodeltoscriptmodel(var18);
  var20 = getEnt("clip128x128x8", "targetname");
  var21 = spawn("script_model", (21960, -10656, 168));
  var21.angles = (0, 0, 0);
  var21 clonebrushmodeltoscriptmodel(var20);
  var22 = getEnt("clip128x128x8", "targetname");
  var23 = spawn("script_model", (21960, -10784, 168));
  var23.angles = (0, 0, 0);
  var23 clonebrushmodeltoscriptmodel(var22);
  var24 = getEnt("clip128x128x8", "targetname");
  var25 = spawn("script_model", (21960, -10912, 168));
  var25.angles = (0, 0, 0);
  var25 clonebrushmodeltoscriptmodel(var24);
  var26 = getEnt("clip128x128x8", "targetname");
  var27 = spawn("script_model", (21960, -11040, 168));
  var27.angles = (0, 0, 0);
  var27 clonebrushmodeltoscriptmodel(var26);
  var28 = getEnt("clip128x128x8", "targetname");
  var29 = spawn("script_model", (21960, -11168, 168));
  var29.angles = (0, 0, 0);
  var29 clonebrushmodeltoscriptmodel(var28);
  var30 = getEnt("clip128x128x8", "targetname");
  var31 = spawn("script_model", (21960, -11296, 168));
  var31.angles = (0, 0, 0);
  var31 clonebrushmodeltoscriptmodel(var30);
  var32 = getEnt("clip128x128x8", "targetname");
  var33 = spawn("script_model", (21960, -11424, 168));
  var33.angles = (0, 0, 0);
  var33 clonebrushmodeltoscriptmodel(var32);
  var34 = getEnt("clip128x128x8", "targetname");
  var35 = spawn("script_model", (21952, -11592, 168));
  var35.angles = (0, 0, 0);
  var35 clonebrushmodeltoscriptmodel(var34);
  var36 = getEnt("clip128x128x8", "targetname");
  var37 = spawn("script_model", (21952, -11728, 168));
  var37.angles = (0, 0, 0);
  var37 clonebrushmodeltoscriptmodel(var36);
  var38 = getEnt("clip128x128x8", "targetname");
  var39 = spawn("script_model", (21952, -11864, 168));
  var39.angles = (0, 0, 0);
  var39 clonebrushmodeltoscriptmodel(var38);
  var40 = getEnt("clip128x128x128", "targetname");
  var41 = spawn("script_model", (17800, -79828, 464));
  var41.angles = (0, 45, 0);
  var41 clonebrushmodeltoscriptmodel(var40);
  var42 = getEnt("clip128x128x128", "targetname");
  var43 = spawn("script_model", (17800, -19828, 336));
  var43.angles = (0, 45, 0);
  var43 clonebrushmodeltoscriptmodel(var42);
  var44 = getEnt("clip128x128x128", "targetname");
  var45 = spawn("script_model", (17800, -19828, 208));
  var45.angles = (0, 45, 0);
  var45 clonebrushmodeltoscriptmodel(var44);
  var46 = getEnt("clip128x128x128", "targetname");
  var47 = spawn("script_model", (17800, -19828, 80));
  var47.angles = (0, 45, 0);
  var47 clonebrushmodeltoscriptmodel(var46);
  var48 = getEnt("clip128x128x128", "targetname");
  var49 = spawn("script_model", (17870, -19848, 464));
  var49.angles = (0, 45, 0);
  var49 clonebrushmodeltoscriptmodel(var48);
  var50 = getEnt("clip128x128x128", "targetname");
  var51 = spawn("script_model", (17870, -19848, 336));
  var51.angles = (0, 45, 0);
  var51 clonebrushmodeltoscriptmodel(var50);
  var52 = getEnt("clip128x128x128", "targetname");
  var53 = spawn("script_model", (17870, -19848, 208));
  var53.angles = (0, 45, 0);
  var53 clonebrushmodeltoscriptmodel(var52);
  var54 = getEnt("clip128x128x128", "targetname");
  var55 = spawn("script_model", (17870, -19848, 80));
  var55.angles = (0, 45, 0);
  var55 clonebrushmodeltoscriptmodel(var54);
  var56 = getEnt("clip128x128x128", "targetname");
  var57 = spawn("script_model", (17936, -19828, 464));
  var57.angles = (0, 45, 0);
  var57 clonebrushmodeltoscriptmodel(var56);
  var58 = getEnt("clip128x128x128", "targetname");
  var59 = spawn("script_model", (17936, -19828, 336));
  var59.angles = (0, 45, 0);
  var59 clonebrushmodeltoscriptmodel(var58);
  var60 = getEnt("clip128x128x128", "targetname");
  var61 = spawn("script_model", (17936, -19828, 208));
  var61.angles = (0, 45, 0);
  var61 clonebrushmodeltoscriptmodel(var60);
}

function player_exit() {
  var0 = getEnt("clip128x128x128", "targetname");
  var1 = spawn("script_model", (17936, -19828, 80));
  var1.angles = (0, 45, 0);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("clip64x64x64", "targetname");
  var3 = spawn("script_model", (16512, -15392, 8));
  var3.angles = (0, 0, 0);
  var3 clonebrushmodeltoscriptmodel(var2);
  var4 = getEnt("clip64x64x64", "targetname");
  var5 = spawn("script_model", (16512, -15392, 72));
  var5.angles = (0, 0, 0);
  var5 clonebrushmodeltoscriptmodel(var4);
  var6 = getEnt("clip64x64x64", "targetname");
  var7 = spawn("script_model", (16512, -15392, 136));
  var7.angles = (0, 0, 0);
  var7 clonebrushmodeltoscriptmodel(var6);
  var8 = getEnt("clip64x64x64", "targetname");
  var9 = spawn("script_model", (16512, -15392, 200));
  var9.angles = (0, 0, 0);
  var9 clonebrushmodeltoscriptmodel(var8);
  var10 = getEnt("clip64x64x64", "targetname");
  var11 = spawn("script_model", (16512, -15392, 296));
  var11.angles = (0, 0, 0);
  var11 clonebrushmodeltoscriptmodel(var10);
  var12 = getEnt("clip64x64x64", "targetname");
  var13 = spawn("script_model", (16512, -15392, 360));
  var13.angles = (0, 0, 0);
  var13 clonebrushmodeltoscriptmodel(var12);
  var14 = getEnt("clip128x128x8", "targetname");
  var15 = spawn("script_model", (172876, -17567.8, -31.5));
  var15.angles = (270, 37.6, -172.62);
  var15 clonebrushmodeltoscriptmodel(var14);
}

function setlowermessageomnvarref() {
  var0 = spawn("trigger_radius", (22824, -13160, -1360), 0, 15848, 715);
  thread ref_12e19();
  var1 = spawn("trigger_radius", (21969, -10078, -190), 0, 160, 128);
  thread ref_12e19();
}

function ref_12e19() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var0);

    if(isPlayer(var0)) {
      var0 dodamage(10000, var0.origin, self, self, "MOD_TRIGGER_HURT");
    }
  }
}

function ref_145f0() {
  var0 = getdvarint("OKSRMNKKOS", 0);
  wait 3;

  switch (var0) {
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
  var0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "siege":
      if(!isDefined(game["roundsPlayed"]) || game["roundsPlayed"] == 0) {
        break;
      } else {
        GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_gw_spawn_allies_start_mod", (20822.7, -2227.94, -507.48), (0, 225, 0)));
      }

      break;
  }

  if(var0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var0);
    return;
  }
}