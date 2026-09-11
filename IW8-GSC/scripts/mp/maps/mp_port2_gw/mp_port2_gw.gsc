/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_port2_gw\mp_port2_gw.gsc
*******************************************************/

function main() {
  _start_spawn_modules::keypad_check_levelinput();
  scripts\mp\maps\mp_port2_gw\mp_port2_gw_precache::main();
  scripts\mp\maps\mp_port2_gw\gen\mp_port2_gw_art::main();
  scripts\mp\maps\mp_port2_gw\mp_port2_gw_fx::main();
  scripts\mp\maps\mp_port2_gw\mp_port2_gw_lighting::main();
  scripts\mp\load::main();
  level thread scripts\engine\scriptable_door::system_init();
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      setDvar("scr_localeID", 3);
    }

    thread ref_12e15();
    scripts\mp\gametypes\arm::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_port2_gw");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("PKKMTTRQO", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "eastern_europe";
  thread runmisteffects();
  thread ref_145f0();
  thread player_fired_gun_monitor();
  thread setlowermessageomnvarref((38149, -15989, -710), 256, 32);
  thread setlowermessageomnvarref((33872, -30160, -1200), 7700, 480);
  thread setlowermessageomnvarref((36736, -17544, -1200), 7480, 480);
  thread ref_12f8e();
}

function runmisteffects() {
  if(getdvarint("scr_disable_mist", 0) != 0) {
    return;
  }

  var0 = [];
  GscBinSkip0(0x2e, 0, (33447, 18127, 340));
}

function ref_12e15() {
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
    var0 = randomintrange(0, level.weapons_that_can_stun.size);
    var1 = level.weapons_that_can_stun[var0];
    playFX(scripts\engine\utility::getfx("vfx_gw_lrg_explosion"), var1 + (randomfloatrange(-1500, 1500), randomfloatrange(-1500, 1500), 0));
    wait 0.5;
    playFX(scripts\engine\utility::getfx("vfx_gw_lrg_explosion"), var1 + (randomfloatrange(-2500, 2500), randomfloatrange(-2500, 2500), 0));
    wait randomfloatrange(1, 2);
    playFX(scripts\engine\utility::getfx("vfx_gw_lrg_explosion"), var1 + (randomfloatrange(-1500, 1500), randomfloatrange(-1500, 1500), 0));
    wait 0.25;
    playFX(scripts\engine\utility::getfx("vfx_gw_lrg_explosion"), var1 + (randomfloatrange(-2500, 2500), randomfloatrange(-2500, 2500), 0));
    wait randomfloatrange(0.5, 2);
  }
}

function ref_12e14() {
  var0 = [];
  GscBinSkip0(0x2e, 0, (15522, -28390, 19));
}

function ref_12e12() {
  playFX(scripts\engine\utility::getfx("vfx_gw_ambient_planes"), (26974, 8140, 40), (9, 286, 0));
}

function ref_12e13() {
  level.weaponstocycle = [];
  level.setallclientomnvarot[0] = (53880, -13100, -300);
  level.setallclientomnvarot[1] = (23702, -1605, -300);

  foreach(var1 in level.setallclientomnvarot) {
    playFX(scripts\engine\utility::getfx("vfx_gw_smoke_plume_bg_01"), var1, (0, 100, 0));
  }
}

function player_fired_gun_monitor() {
  var0 = spawn("script_model", (33380, -27608, -460));
  var0 setModel("hardware_plywood_bare_01");
  var0.angles = (90, 40, -6);
  var0 = spawn("script_model", (35470, -28140.5, -509));
  var0 setModel("uk_wall_wood_stud_frame_01_2x120");
  var0.angles = (270, 358, -132);
}

function ref_145f0() {
  var0 = getdvarint("OKSRMNKKOS", 0);
  wait 3;

  switch (var0) {
    case 0:
      break;
    case 1:
      playFX(scripts\engine\utility::getfx("gas_realfar"), (35851, -24450, -471));
      break;
    case 2:
      playFX(scripts\engine\utility::getfx("gas_far"), (35851, -24450, -471));
      break;
    case 3:
      playFX(scripts\engine\utility::getfx("gas_medium"), (35851, -24450, -471));
      break;
    case 4:
      playFX(scripts\engine\utility::getfx("gas_close"), (35851, -24450, -471));
      break;
  }
}

function setlowermessageomnvarref(var0, var1, var2) {
  var3 = spawn("trigger_radius", var0, 0, var1, var2);

  for(;;) {
    var3 waittill("trigger", var4);

    if(isPlayer(var4)) {
      var4 dodamage(10000, var4.origin, var3, var3, "MOD_TRIGGER_HURT");
    }
  }
}

function ref_12f8e() {
  var0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "siege":
      if(!isDefined(game["roundsPlayed"]) || game["roundsPlayed"] == 0) {
        break;
      } else {
        GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_gw_spawn_allies_start_mod", (30936, -35872, 566), (0, 90, 0)));
      }

      break;
  }

  if(var0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var0);
    return;
  }
}