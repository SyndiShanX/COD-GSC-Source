/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_publicevent_areadenial.gsc
*****************************************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_killstreaks;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\player;
#namespace br_publicevent_areadenial;

function autoexec main() {
  scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82(%"areadenial", &init);
}

function init(eventinfo) {
  eventinfo.validatefunc = &validatefunc;
  eventinfo.activatefunc = &activatefunc;
  eventinfo.waitfunc = &waitfunc;
  eventinfo.postinitfunc = &postinitfunc;
  eventinfo.deactivatefunc = &function_ce2238c881cf779f;
}

function postinitfunc() {
  game["dialog"]["pe_areadenial_name"] = "brds_grav_aaa1";
  game["dialog"]["pe_areadenial_event_begin"] = "brds_grav_aaa2";
  game["dialog"]["pe_areadenial_enter_detection_radius"] = "brds_grav_aaa3";
  game["dialog"]["pe_areadenial_enter_drone_path"] = "brds_grav_aaa4";
  game["dialog"]["pe_areadenial_new_sweep"] = "brds_grav_aaa5";
  level.pe_areadenial = spawnStruct();
  level.pe_areadenial.minstarttime = getdvarfloat(@ "hash_f738aad5ca938723", 60);
  level.pe_areadenial.maxstarttime = getdvarfloat(@ "hash_f75ba0d5cab9b8dd", 565);
  level.pe_areadenial.var_38c3775981fbc7ef = getdvarfloat(@ "hash_a38f2ce7676edb19", 1800);
  level.pe_areadenial.var_88f734bb6033570 = getdvarfloat(@ "hash_eeeb1f6afe3519ee", 0.05);
  level.pe_areadenial.var_ad4754cdffb212ee = getdvarfloat(@ "hash_c80aab9d623eec4f", 525);
  level.pe_areadenial.var_49a91f803883d065 = getdvarfloat(@ "hash_d6eab54faa5aafc7", 38);
  level.pe_areadenial.var_a7ff560156dd7340 = getdvarfloat(@ "scr_br_pe_areadenial_area_recon_fleet_size", 3);
  level.pe_areadenial.var_5900c5a18edd28b8 = getdvarfloat(@ "hash_43fe04b82f4f4", 4650);
  level.pe_areadenial.var_c25236f9a676187e = getdvarint(@ "hash_2ea7541ddf02bd32", 2);
  level.pe_areadenial.var_444c60db3001d089 = getdvarfloat(@ "hash_158f4b7e0b27abcf", 2);
  level.pe_areadenial.var_29d617346106c7ce = getdvarfloat(@ "hash_78ddb2523cba6d0b", 1000);
  level.pe_areadenial.var_4ac907eaeb7ae36c = getdvarfloat(@ "hash_592c14fd41fee008", 10);
  level.pe_areadenial.var_2a1281ec65f0ea7c = getdvarfloat(@ "hash_88d54cc694aa46ab", 20);
  level.pe_areadenial.var_182601446ee9cb5f = getscriptbundle(hashcat(%"hash_684724f6313c6a6", "jup_publicevent_areadenial_data"));
  level.pe_areadenial.var_182601446ee9cb5f.var_1d427aef6070dab3 = function_70fec4c2d7c0974f(level.pe_areadenial.var_182601446ee9cb5f.var_1d427aef6070dab3, level.pe_areadenial.var_a7ff560156dd7340);
  level.pe_areadenial.var_4bfb10f83d4628af = [];
  var_877e12a935a24f12 = getDvar(@ "hash_417dbdcaaac6190e", "");

  if(var_877e12a935a24f12 != "") {
    var_7a3e24e5f2e6c89b = strtok(var_877e12a935a24f12, " ");

    if(var_7a3e24e5f2e6c89b.size > 0) {
      foreach(delayoverride in var_7a3e24e5f2e6c89b) {
        level.pe_areadenial.var_4bfb10f83d4628af[level.pe_areadenial.var_4bfb10f83d4628af.size] = float(delayoverride);
      }
    }
  }

  cylinderheight = scripts\cp_mp\parachute::getc130height();
  level.pe_areadenial.var_18d9a7d50c32c876 = getdvarint(@ "hash_1c6acd7a92de6c21", cylinderheight);
  level.pe_areadenial.var_85324d63191386df = [];
  level.pe_areadenial.var_f376e6fd9d704520 = [];

  level thread debug_init();
}

function validatefunc() {
  return true;
}

function activatefunc() {
  scripts\mp\gametypes\br_publicevents::showsplashtoall("br_pe_areadenial_start", "splash_list_br_pe_areadenial");
  level thread scripts\mp\gametypes\br_public::brleaderdialog("pe_areadenial_name", 1, undefined, 0, 0, undefined, "dx_br_brad_");
  function_b7e920cec1a740f0();
  thread function_9d7adb0c85ad032c();
}

function function_9d7adb0c85ad032c() {
  level endon("game_ended");
  level endon("cancel_public_event");
  level endon("area_denial_cancel");
  thread function_1b86e63b88f95880();
  thread function_710abf9f376821bd();
  radius = level.pe_areadenial.var_38c3775981fbc7ef;
  height = level.pe_areadenial.var_18d9a7d50c32c876;
  var_41c592e0fde2cc32 = [];
  var_9b6910a128f07c81 = [];
  var_5432f286e9fd81eb = 0;
  var_db18d54fe0bfc2aa = level.pe_areadenial.var_c25236f9a676187e;

  for(i = 0; i < var_db18d54fe0bfc2aa; i++) {
    var_4c77bdbee25f55d9 = function_b26cda0ae84a23c9();
    var_77044f83c48cfc86 = function_b1b8c12b0e570254(var_4c77bdbee25f55d9);
    var_9b6910a128f07c81[i] = var_77044f83c48cfc86;
    var_41c592e0fde2cc32[i] = var_4c77bdbee25f55d9;
    var_5432f286e9fd81eb += var_77044f83c48cfc86;
  }

  var_927c9ccd0c6657f2 = var_db18d54fe0bfc2aa * level.pe_areadenial.var_4ac907eaeb7ae36c + var_db18d54fe0bfc2aa * level.pe_areadenial.var_49a91f803883d065 + var_5432f286e9fd81eb;
  thread starttimer(var_927c9ccd0c6657f2);
  sweepdirection = undefined;

  for(i = 0; i < level.pe_areadenial.var_c25236f9a676187e; i++) {
    function_b5df83a2947e7f8(i);
    var_761bbb068c79f3f2 = function_e5c53607a2a43f2c();
    var_761bbb068c79f3f2 -= (0, 0, var_761bbb068c79f3f2[2]);
    sweepdirection = function_e99b445ad2890c72(var_761bbb068c79f3f2, sweepdirection);
    var_761bbb068c79f3f2 = function_885a34198bc9d718(var_761bbb068c79f3f2, sweepdirection);
    var_5034a2690f4a2717 = var_41c592e0fde2cc32[i];
    maxdelay = var_9b6910a128f07c81[i];
    var_c8248c2a5a713736 = level.pe_areadenial.var_49a91f803883d065 + maxdelay + level.pe_areadenial.var_4ac907eaeb7ae36c;
    thread function_c2d3b64efe3c0908(i, var_761bbb068c79f3f2, radius, sweepdirection, height, var_5034a2690f4a2717);
    wait var_c8248c2a5a713736;
    function_e8b32e400a713124();
  }

  level notify("areadenial_sweep_end");
  level.pe_areadenial.var_f376e6fd9d704520 = [];
  function_f1155cc70db3c061();

  foreach(player in level.players) {
    player.var_2510aab8a2a819d8 = undefined;
    player.var_4b78d25c7909947 = undefined;
  }
}

function function_c2d3b64efe3c0908(var_2ec15a7b9d6c1831, var_761bbb068c79f3f2, radius, sweepdirection, height, var_5034a2690f4a2717) {
  level endon("game_ended");
  level endon("cancel_public_event");
  level endon("area_denial_cancel");

  if(!isDefined(var_761bbb068c79f3f2) || !isDefined(radius) || !isDefined(sweepdirection) || !isDefined(height)) {
    return undefined;
  }

  if(!isDefined(var_5034a2690f4a2717)) {
    var_5034a2690f4a2717 = [];
  }

  var_72c40a2a16128375 = (sweepdirection[1], sweepdirection[0] * -1, 0);

  for(i = 0; i < level.pe_areadenial.var_a7ff560156dd7340; i++) {
    offsetmult = (i & 1) == 0 ? i / 2 : (i + 1) * -1 / 2;
    offsetmult *= level.pe_areadenial.var_5900c5a18edd28b8;
    offsetvector = var_72c40a2a16128375 * offsetmult;
    thread function_cb80ba26086187c4(var_2ec15a7b9d6c1831, var_761bbb068c79f3f2, radius, sweepdirection, height, var_5034a2690f4a2717[i], offsetvector);
  }
}

function function_cb80ba26086187c4(var_2ec15a7b9d6c1831, var_761bbb068c79f3f2, radius, direction, height, startdelay, originoffset) {
  level endon("game_ended");
  level endon("cancel_public_event");
  level endon("area_denial_cancel");

  if(!isDefined(var_761bbb068c79f3f2) || !isDefined(radius) || !isDefined(direction)) {
    return undefined;
  }

  var_a5cb914a9154c613 = spawnStruct();
  speed = level.pe_areadenial.var_ad4754cdffb212ee;
  sweepduration = level.pe_areadenial.var_49a91f803883d065;
  var_dc1ebadf636daf52 = (level.pe_areadenial.var_4ac907eaeb7ae36c + sweepduration * 0.5) * speed;
  var_23cfad28045c532f = function_b4a05caf7d582d27(var_761bbb068c79f3f2, direction, var_dc1ebadf636daf52);
  var_9fe375b8f6f5a2bf = var_761bbb068c79f3f2;

  if(isDefined(originoffset)) {
    var_23cfad28045c532f += originoffset;
    var_9fe375b8f6f5a2bf += originoffset;
  }

  var_9249aa69a161712d = level.pe_areadenial.var_18d9a7d50c32c876 + level.pe_areadenial.var_29d617346106c7ce;
  var_26b1d07fbbc57a37 = var_23cfad28045c532f + (0, 0, var_9249aa69a161712d);
  directionangles = vectortoangles(direction);
  var_a5cb914a9154c613.origin = var_23cfad28045c532f;
  var_a5cb914a9154c613.radius = radius;
  var_a5cb914a9154c613.direction = direction;
  var_a5cb914a9154c613.height = height;
  var_a5cb914a9154c613.var_761bbb068c79f3f2 = var_9fe375b8f6f5a2bf;
  var_a5cb914a9154c613.sweepduration = sweepduration;
  var_a5cb914a9154c613.sweepspeed = speed;
  var_a5cb914a9154c613.var_2ec15a7b9d6c1831 = var_2ec15a7b9d6c1831;
  var_a5cb914a9154c613.warningradius = radius * 5.5;
  var_a5cb914a9154c613.var_1a4a3e72a8e64c38 = var_23cfad28045c532f + level.pe_areadenial.var_4ac907eaeb7ae36c * speed * direction;
  var_a5cb914a9154c613.var_fcbe88ac116375c7 = var_23cfad28045c532f + (level.pe_areadenial.var_4ac907eaeb7ae36c + level.pe_areadenial.var_49a91f803883d065) * speed * direction;
  var_a5cb914a9154c613.var_85324d63191386df = [];

  if(!isDefined(level.pe_areadenial.var_f376e6fd9d704520)) {
    level.pe_areadenial.var_f376e6fd9d704520 = [];
  }

  level.pe_areadenial.var_f376e6fd9d704520 = array_add(level.pe_areadenial.var_f376e6fd9d704520, var_a5cb914a9154c613);

  if(isDefined(startdelay) && startdelay > 0) {
    wait startdelay;
  }

  var_f7699d2cc0f55dac = spawn("script_model", var_26b1d07fbbc57a37);
  var_f7699d2cc0f55dac setModel("veh9_mil_air_advanced_uav_mp");
  var_f7699d2cc0f55dac.angles = directionangles;
  var_f7699d2cc0f55dac setscriptablepartstate("lights", "on", 0);
  var_f7699d2cc0f55dac setscriptablepartstate("SFX", "on", 0);
  var_a5cb914a9154c613.scriptable = var_f7699d2cc0f55dac;
  var_a5cb914a9154c613.scriptable function_5b8bc97b741c879c("ui_map_texture_areadenial_uav");
  var_a5cb914a9154c613.scriptable function_be29729b31039b7e(1, 1);
  var_a5cb914a9154c613.var_e948744c51c8db44 = spawnStruct();
  var_a5cb914a9154c613.var_e948744c51c8db44 scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522("AreaDenial_Path", var_a5cb914a9154c613.origin, var_a5cb914a9154c613.radius);
  sizemultiplier = 11;
  var_a5cb914a9154c613.var_e948744c51c8db44.mapcircle addyaw(vectortoyaw(var_a5cb914a9154c613.direction) * -1);
  var_a5cb914a9154c613.var_e948744c51c8db44.mapcircle addpitch(sizemultiplier);
  var_a5cb914a9154c613.var_b1c1e3682e78c27a = spawnStruct();
  var_a5cb914a9154c613.var_b1c1e3682e78c27a scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522("AreaDenial", var_a5cb914a9154c613.origin, var_a5cb914a9154c613.radius);
  var_3241fb10d1a5e334 = direction * speed * sweepduration * 0.5;
  pathstartpos = var_a5cb914a9154c613.var_761bbb068c79f3f2 - var_3241fb10d1a5e334;
  var_a5cb914a9154c613.var_56548f1ffd2f1a08 = spawnStruct();
  var_a5cb914a9154c613.var_56548f1ffd2f1a08 scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522("AreaDenial_Path_Start", pathstartpos, var_a5cb914a9154c613.radius);
  sizemultiplier = 8;
  var_a5cb914a9154c613.var_56548f1ffd2f1a08.mapcircle addyaw(vectortoyaw(var_a5cb914a9154c613.direction) * -1);
  var_a5cb914a9154c613.var_56548f1ffd2f1a08.mapcircle addpitch(sizemultiplier);
  var_a5cb914a9154c613.var_56548f1ffd2f1a08 scripts\cp_mp\utility\game_utility::function_6988310081de7b45();
  pathendpos = var_a5cb914a9154c613.var_761bbb068c79f3f2 + var_3241fb10d1a5e334;
  var_a5cb914a9154c613.var_ad00f5fd6b531b99 = spawnStruct();
  var_a5cb914a9154c613.var_ad00f5fd6b531b99 scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522("AreaDenial_Path_End", pathendpos, var_a5cb914a9154c613.radius);
  sizemultiplier = 8;
  var_a5cb914a9154c613.var_ad00f5fd6b531b99.mapcircle addyaw(vectortoyaw(var_a5cb914a9154c613.direction) * -1);
  var_a5cb914a9154c613.var_ad00f5fd6b531b99.mapcircle addpitch(sizemultiplier);
  var_a5cb914a9154c613 thread function_4d19d4aa5e8c6865();
  return var_a5cb914a9154c613;
}

function function_d61de56f5c16dd6a(var_a5cb914a9154c613) {
  if(!isDefined(var_a5cb914a9154c613) || !isPlayer(self)) {
    return 0;
  }

  if(!isDefined(var_a5cb914a9154c613.origin) || !isDefined(var_a5cb914a9154c613.direction) || !isDefined(var_a5cb914a9154c613.radius)) {
    return 0;
  }

  playerorigin = self.origin;
  var_23cfad28045c532f = var_a5cb914a9154c613.origin;
  var_47bba427700c8cf9 = playerorigin - var_23cfad28045c532f;
  var_47bba427700c8cf9 -= (0, 0, var_47bba427700c8cf9[2]);
  var_b85567e87872d7c = vectordot2(var_a5cb914a9154c613.direction, var_47bba427700c8cf9, 0);
  var_b00ca1e06d6e1465 = var_a5cb914a9154c613.direction * var_b85567e87872d7c;
  perpendicularvector = var_b00ca1e06d6e1465 - var_47bba427700c8cf9;
  var_9bdcbef9aab24c7e = perpendicularvector[0] * perpendicularvector[0] + perpendicularvector[1] * perpendicularvector[1];
  var_b0ab5d5fc3d5ce26 = var_a5cb914a9154c613.radius;
  var_3eeb84ddfd348235 = var_b0ab5d5fc3d5ce26 * 5.5;
  var_ba91641a5189ec2a = var_9bdcbef9aab24c7e <= var_b0ab5d5fc3d5ce26 * var_b0ab5d5fc3d5ce26;
  var_c412a62b7a81d039 = var_b85567e87872d7c <= var_3eeb84ddfd348235;
  var_c15546301de735e7 = var_ba91641a5189ec2a && var_c412a62b7a81d039 && var_b85567e87872d7c > 0;
  return var_c15546301de735e7;
}

function function_8da121b7be71313(var_a5cb914a9154c613) {
  if(!isDefined(var_a5cb914a9154c613) || !isPlayer(self)) {
    return 0;
  }

  if(!isDefined(var_a5cb914a9154c613.var_1a4a3e72a8e64c38) || !isDefined(var_a5cb914a9154c613.var_fcbe88ac116375c7) || !isDefined(var_a5cb914a9154c613.direction) || !isDefined(var_a5cb914a9154c613.radius)) {
    return 0;
  }

  playerorigin = self.origin;
  var_dd43b45113a0fdbe = var_a5cb914a9154c613.var_1a4a3e72a8e64c38;
  var_1727fad03c5feb2b = var_a5cb914a9154c613.var_fcbe88ac116375c7;
  var_7bd4ed005c6818e3 = var_a5cb914a9154c613.radius * var_a5cb914a9154c613.radius;
  var_25ab02a3ab23266c = distance2dsquared(playerorigin, var_dd43b45113a0fdbe);
  var_89bc51a7bcdaa4e3 = distance2dsquared(playerorigin, var_1727fad03c5feb2b);
  var_ee2b6e4da66696b8 = var_25ab02a3ab23266c <= var_7bd4ed005c6818e3;
  var_a56758cf67bf709 = var_89bc51a7bcdaa4e3 <= var_7bd4ed005c6818e3;

  if(var_ee2b6e4da66696b8 || var_a56758cf67bf709) {
    return 1;
  }

  var_cc738e2f161124f8 = playerorigin - var_dd43b45113a0fdbe;
  var_cc738e2f161124f8 -= (0, 0, var_cc738e2f161124f8[2]);
  var_b85567e87872d7c = vectordot2(var_a5cb914a9154c613.direction, var_cc738e2f161124f8, 0);
  var_b00ca1e06d6e1465 = var_a5cb914a9154c613.direction * var_b85567e87872d7c;
  perpendicularvector = var_b00ca1e06d6e1465 - var_cc738e2f161124f8;
  var_9bdcbef9aab24c7e = perpendicularvector[0] * perpendicularvector[0] + perpendicularvector[1] * perpendicularvector[1];
  var_ba91641a5189ec2a = var_9bdcbef9aab24c7e <= var_7bd4ed005c6818e3;
  var_b6cf085e65dd39ea = var_b85567e87872d7c >= 0;
  var_717d6040ebc7387d = playerorigin + perpendicularvector;
  var_e3a6876f96968f34 = var_717d6040ebc7387d - var_1727fad03c5feb2b;
  var_e3a6876f96968f34 -= (0, 0, var_e3a6876f96968f34[2]);
  var_4f45128fff795f08 = vectordot2(var_a5cb914a9154c613.direction, var_e3a6876f96968f34, 0);
  var_6aeaf5ec46b004ae = var_4f45128fff795f08 <= 0;
  var_f647b2ce3e59f612 = var_ba91641a5189ec2a && var_b6cf085e65dd39ea && var_6aeaf5ec46b004ae;
  return var_f647b2ce3e59f612;
}

function function_de42c0e4d1be699b(var_a5cb914a9154c613) {
  if(!isPlayer(self)) {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  if(br_public::isplayeringulag()) {
    return false;
  }

  if(isDefined(self.var_4b78d25c7909947) && self.var_4b78d25c7909947 >= var_a5cb914a9154c613.var_2ec15a7b9d6c1831) {
    return false;
  }

  if(!function_d61de56f5c16dd6a(var_a5cb914a9154c613)) {
    return false;
  }

  if(!function_8da121b7be71313(var_a5cb914a9154c613)) {
    return false;
  }

  return true;
}

function function_1b86e63b88f95880() {
  level endon("game_ended");
  level endon("cancel_public_event");
  level endon("area_denial_cancel");
  level endon("areadenial_sweep_end");

  while(true) {
    foreach(drone in level.pe_areadenial.var_f376e6fd9d704520) {
      if(istrue(drone.var_ce9d73218733c4ec)) {
        continue;
      }

      nearbyplayers = utility::playersincylinder(drone.origin, drone.warningradius, undefined, drone.height);

      foreach(player in nearbyplayers) {
        if(!player function_de42c0e4d1be699b(drone)) {
          continue;
        }

        scripts\mp\gametypes\br_killstreaks::dangernotifyplayer(player, "areadenial", 3);
        level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("pe_areadenial_enter_drone_path", player, 1, 0, 0, undefined, "dx_br_brad_");
        player.var_4b78d25c7909947 = drone.var_2ec15a7b9d6c1831;
      }
    }

    waitframe();
  }
}

function function_710abf9f376821bd() {
  level endon("game_ended");
  level endon("cancel_public_event");
  level endon("area_denial_cancel");
  level endon("areadenial_sweep_end");
  var_fde0c44e8647919 = [];

  foreach(player in level.players) {
    if(!player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(player)) {
      level.pe_areadenial.var_da5faf6c293501f7 = function_6d6af8144a5131f1(level.pe_areadenial.var_da5faf6c293501f7, player);
      continue;
    }

    var_fde0c44e8647919 = array_add(var_fde0c44e8647919, player);
  }

  while(var_fde0c44e8647919.size > 0) {
    var_3e92d00ad809611c = [];

    foreach(player in var_fde0c44e8647919) {
      if(!player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(player)) {
        level.pe_areadenial.var_da5faf6c293501f7 = function_6d6af8144a5131f1(level.pe_areadenial.var_da5faf6c293501f7, player);
        var_3e92d00ad809611c = array_add(var_3e92d00ad809611c, player);
      }
    }

    var_fde0c44e8647919 = array_remove_array(var_fde0c44e8647919, var_3e92d00ad809611c);
    waitframe();
  }
}

function function_8ba6729fe64a5b69() {
  self endon("areadenial_fly_over_end");
  level endon("game_ended");
  level endon("cancel_public_event");
  level endon("area_denial_cancel");

  while(true) {
    nearbyplayers = utility::playersincylinder(self.origin, self.radius, undefined, self.height);

    foreach(nearbyplayer in nearbyplayers) {
      if(arraycontains(self.var_85324d63191386df, nearbyplayer)) {
        continue;
      }

      thread function_d3ce533932f11610(nearbyplayer);
    }

    foreach(var_96e999fd72a174d6 in self.var_85324d63191386df) {
      if(arraycontains(nearbyplayers, var_96e999fd72a174d6)) {
        continue;
      }

      thread function_d788489e8b30bb51(var_96e999fd72a174d6);
    }

    if(getdvarint(@ "hash_e3e9f13280e0fa2f", 0)) {
      var_c307a935c29c472c = self.origin - (0, 0, self.height);
      draw_capsule(var_c307a935c29c472c, self.radius, 2 * self.height);
    }

    wait level.pe_areadenial.var_88f734bb6033570;
  }
}

function function_aec9c54c8967fe89(durationseconds) {
  step = level.pe_areadenial.var_ad4754cdffb212ee * level.framedurationseconds;
  time = 0;

  while(time < durationseconds) {
    stepvector = self.direction * step;
    self.origin += stepvector;
    self.scriptable.origin += stepvector;
    time += level.framedurationseconds;
    waitframe();
  }
}

function function_d4a1bf18d5ba7df1(durationseconds) {
  level endon("game_ended");
  level endon("cancel_public_event");
  level endon("area_denial_cancel");
  self endon("areadenial_fly_over_end");
  var_b0ab5d5fc3d5ce26 = self.radius;
  var_3eeb84ddfd348235 = var_b0ab5d5fc3d5ce26 * 5.5;
  var_d21d785309e14f7f = var_3eeb84ddfd348235 * 0.55 / self.sweepspeed;
  time = 0;
  var_f4dfe72a13730575 = self.var_e948744c51c8db44;
  var_12fc049ec8a169db = 0;

  while(time < durationseconds) {
    if(!var_12fc049ec8a169db && durationseconds - time < var_d21d785309e14f7f) {
      var_f4dfe72a13730575 scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
      var_f4dfe72a13730575 = self.var_b1c1e3682e78c27a;
      var_f4dfe72a13730575 scripts\cp_mp\utility\game_utility::function_6e148c8da2e4db13(self.origin);
      var_f4dfe72a13730575 scripts\cp_mp\utility\game_utility::function_6988310081de7b45();
      var_12fc049ec8a169db = 1;
    } else {
      var_f4dfe72a13730575 scripts\cp_mp\utility\game_utility::function_6e148c8da2e4db13(self.origin);
    }

    time += level.framedurationseconds;
    waitframe();
  }
}

function function_4a6a9d022db5af8c() {
  function_aec9c54c8967fe89(level.pe_areadenial.var_4ac907eaeb7ae36c);
}

function function_84db74c613606304() {
  thread function_d4a1bf18d5ba7df1(self.sweepduration);
  function_aec9c54c8967fe89(self.sweepduration);
}

function function_b8f94321062a981b() {
  function_aec9c54c8967fe89(level.pe_areadenial.var_2a1281ec65f0ea7c);
}

function function_4d19d4aa5e8c6865() {
  level endon("game_ended");
  level endon("cancel_public_event");
  level endon("area_denial_cancel");

  if(!isDefined(self.sweepduration) || !isDefined(self.radius) || !isDefined(self.origin) || !isDefined(self.scriptable) || !isDefined(self.direction)) {
    return;
  }

  if(!isDefined(self.var_e948744c51c8db44) || !isDefined(self.var_56548f1ffd2f1a08) || !isDefined(self.var_ad00f5fd6b531b99) || !isDefined(self.var_b1c1e3682e78c27a)) {
    return;
  }

  function_4a6a9d022db5af8c();
  self.var_56548f1ffd2f1a08 scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
  self.var_e948744c51c8db44 scripts\cp_mp\utility\game_utility::function_6988310081de7b45();
  self.var_ad00f5fd6b531b99 scripts\cp_mp\utility\game_utility::function_6988310081de7b45();
  thread function_8ba6729fe64a5b69();
  scripts\mp\objidpoolmanager::function_846c2acd91309cd8(self.scriptable.scriptedobjid, 141, 42, 42);
  function_84db74c613606304();
  self notify("areadenial_fly_over_end");
  self.var_ce9d73218733c4ec = 1;
  self.var_b1c1e3682e78c27a scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
  self.var_ad00f5fd6b531b99 scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();

  foreach(player in self.var_85324d63191386df) {
    thread function_d788489e8b30bb51(player);
  }

  scripts\mp\objidpoolmanager::function_846c2acd91309cd8(self.scriptable.scriptedobjid, 255, 255, 255);
  level.pe_areadenial.var_f376e6fd9d704520 = array_remove(level.pe_areadenial.var_f376e6fd9d704520, self);
  function_b8f94321062a981b();
  self.scriptable function_770fc7b53ba3b55b();
  self.scriptable delete();
}

function function_d3ce533932f11610(player) {
  level endon("game_ended");
  level endon("cancel_public_event");
  level endon("area_denial_cancel");

  if(!isPlayer(player)) {
    return;
  }

  player notify("area_denial_start_detection");

  if(!isDefined(self.var_85324d63191386df)) {
    self.var_85324d63191386df = [];
  }

  self.var_85324d63191386df = function_6d6af8144a5131f1(self.var_85324d63191386df, player);
  level.pe_areadenial.var_1314799d6fcadf1 = function_6d6af8144a5131f1(level.pe_areadenial.var_1314799d6fcadf1, player);
  level.pe_areadenial.var_85324d63191386df = function_6d6af8144a5131f1(level.pe_areadenial.var_85324d63191386df, player);
  player function_2890f072f1e72351(1);
  player function_3992fc36e90bcde9(3);
  player function_53e36f636092bfb(1);
  level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("pe_areadenial_enter_detection_radius", player, 1, 0, 0, undefined, "dx_br_brad_");
}

function function_d788489e8b30bb51(player) {
  level endon("game_ended");
  level endon("cancel_public_event");
  level endon("area_denial_cancel");

  if(!isPlayer(player)) {
    return;
  }

  player endon("area_denial_start_detection");
  player endon("disconnect");

  if(!isDefined(self.var_85324d63191386df) || self.var_85324d63191386df.size <= 0) {
    return;
  }

  self.var_85324d63191386df = array_remove(self.var_85324d63191386df, player);
  level.pe_areadenial.var_85324d63191386df = array_remove(level.pe_areadenial.var_85324d63191386df, player);
  player waittill_any_timeout_1(level.pe_areadenial.var_444c60db3001d089, "death");
  player function_2890f072f1e72351(0);
  player function_3ac2d6250a4c3f42(3);
  player function_53e36f636092bfb(0);
}

function function_e99b445ad2890c72(var_761bbb068c79f3f2, var_a87e0ef0a96c75ad) {
  if(!isDefined(var_761bbb068c79f3f2)) {
    return;
  }

  sweepdirection = undefined;

  if(isDefined(var_a87e0ef0a96c75ad) && isvector(var_a87e0ef0a96c75ad)) {
    sweepdirection = rotatevector(var_a87e0ef0a96c75ad, (0, 90, 0));
  } else {
    var_978fa2d885631e3b = function_eb7b779e8b1dec9f(var_761bbb068c79f3f2, level.pe_areadenial.var_5900c5a18edd28b8);

    if(isDefined(var_978fa2d885631e3b)) {
      var_d98c691997036c6 = var_761bbb068c79f3f2 - var_978fa2d885631e3b;
      var_903ecc55ae500012 = length(var_d98c691997036c6);
      var_88b83b0d7a43ea72 = acos(level.pe_areadenial.var_5900c5a18edd28b8 / var_903ecc55ae500012);
      var_88b83b0d7a43ea72 = 90 - var_88b83b0d7a43ea72;
      sweepdirection = rotatevectorinverted(var_d98c691997036c6, (0, var_88b83b0d7a43ea72, 0));
      sweepdirection = vectornormalize2(sweepdirection);
    } else {
      circlecenter = scripts\mp\gametypes\br_circle::getdangercircleorigin();
      sweepdirection = var_761bbb068c79f3f2 - circlecenter;
      sweepdirection = vectornormalize2(sweepdirection);
    }
  }

  return sweepdirection;
}

function function_885a34198bc9d718(var_761bbb068c79f3f2, sweepdirection) {
  if(!isDefined(var_761bbb068c79f3f2) || !isDefined(sweepdirection)) {
    return var_761bbb068c79f3f2;
  }

  dangercircleorigin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  dangercircleradius = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var_6740c0173953f46a = level.pe_areadenial.var_ad4754cdffb212ee * level.pe_areadenial.var_49a91f803883d065 * 0.5;
  var_355fbda19e1fb517 = var_6740c0173953f46a * sweepdirection;
  var_cc4ac4ff5ee20fa6 = var_761bbb068c79f3f2 - var_355fbda19e1fb517;
  var_e22ae89a1cfb5aad = var_761bbb068c79f3f2 + var_355fbda19e1fb517;
  var_52d8b8e0cc5d1871 = dangercircleradius * dangercircleradius;
  var_3e3904eab2e0b226 = distance2dsquared(dangercircleorigin, var_cc4ac4ff5ee20fa6) > var_52d8b8e0cc5d1871;
  var_639d5d63419217ff = distance2dsquared(dangercircleorigin, var_e22ae89a1cfb5aad) > var_52d8b8e0cc5d1871;

  if(!var_3e3904eab2e0b226 && !var_639d5d63419217ff) {
    return var_761bbb068c79f3f2;
  }

  var_bea75a5f70137d1c = dangercircleorigin - var_761bbb068c79f3f2;
  var_b85567e87872d7c = vectordot2(sweepdirection, var_bea75a5f70137d1c, 0);
  var_b00ca1e06d6e1465 = sweepdirection * var_b85567e87872d7c;
  perpendicularvector = var_b00ca1e06d6e1465 - var_bea75a5f70137d1c;
  var_9bdcbef9aab24c7e = perpendicularvector[0] * perpendicularvector[0] + perpendicularvector[1] * perpendicularvector[1];

  if(var_b85567e87872d7c * var_b85567e87872d7c <= var_6740c0173953f46a * var_6740c0173953f46a) {
    var_3721d5c43a72d33e = var_761bbb068c79f3f2 + var_b00ca1e06d6e1465;
  } else {
    multiplier = var_b85567e87872d7c < 0 ? -1 : 1;
    var_3721d5c43a72d33e = var_761bbb068c79f3f2 + sweepdirection * multiplier * var_6740c0173953f46a;
  }

  return var_3721d5c43a72d33e;
}

function function_eb7b779e8b1dec9f(var_761bbb068c79f3f2, mindistance) {
  closestpos = undefined;

  if(!isDefined(var_761bbb068c79f3f2) || !isDefined(mindistance) || !isvector(var_761bbb068c79f3f2)) {
    return closestpos;
  }

  bestdistsqr = 2147483647;
  mindistsqr = mindistance * mindistance;

  foreach(player in level.players) {
    distsqr = distance2dsquared(player.origin, var_761bbb068c79f3f2);

    if(distsqr > mindistsqr && distsqr < bestdistsqr) {
      closestpos = player.origin;
      bestdistsqr = distsqr;
    }
  }

  return closestpos;
}

function function_b26cda0ae84a23c9() {
  if(isDefined(level.pe_areadenial.var_4bfb10f83d4628af) && level.pe_areadenial.var_4bfb10f83d4628af.size > 0) {
    return level.pe_areadenial.var_4bfb10f83d4628af;
  }

  delays = [];

  if(!isDefined(level.pe_areadenial.var_182601446ee9cb5f) || !isDefined(level.pe_areadenial.var_182601446ee9cb5f.var_1d427aef6070dab3) || !isarray(level.pe_areadenial.var_182601446ee9cb5f.var_1d427aef6070dab3) || level.pe_areadenial.var_182601446ee9cb5f.var_1d427aef6070dab3.size <= 0) {
    return delays;
  }

  var_f9d74d26efa4b997 = function_a656c6dfb7dcb33a(level.pe_areadenial.var_182601446ee9cb5f.var_1d427aef6070dab3);

  if(!isDefined(var_f9d74d26efa4b997.dronedelays) || !isarray(var_f9d74d26efa4b997.dronedelays)) {
    return delays;
  }

  foreach(var_71e726dc809f7198 in var_f9d74d26efa4b997.dronedelays) {
    delays = array_add(delays, var_71e726dc809f7198.delay);
  }

  return delays;
}

function function_70fec4c2d7c0974f(var_9e41af9fd3481ddc, var_d684ad9d6be46e5a) {
  var_4d2ee79a39de95c2 = [];

  if(!isDefined(var_9e41af9fd3481ddc) || !isarray(var_9e41af9fd3481ddc) || var_9e41af9fd3481ddc.size <= 0) {
    return var_4d2ee79a39de95c2;
  }

  if(!isDefined(var_d684ad9d6be46e5a)) {
    return var_4d2ee79a39de95c2;
  }

  foreach(formation in var_9e41af9fd3481ddc) {
    if(!isDefined(formation.dronedelays) || !isarray(formation.dronedelays)) {
      continue;
    }

    if(formation.dronedelays.size == var_d684ad9d6be46e5a) {
      var_4d2ee79a39de95c2 = array_add(var_4d2ee79a39de95c2, formation);
    }
  }

  return var_4d2ee79a39de95c2;
}

function function_b1b8c12b0e570254(var_5034a2690f4a2717) {
  if(!isDefined(var_5034a2690f4a2717) || !isarray(var_5034a2690f4a2717) || var_5034a2690f4a2717.size == 0) {
    return 0;
  }

  maxdelay = var_5034a2690f4a2717[0];

  foreach(var_71e726dc809f7198 in var_5034a2690f4a2717) {
    if(var_71e726dc809f7198 >= maxdelay) {
      maxdelay = var_71e726dc809f7198;
    }
  }

  return maxdelay;
}

function function_ac2852cc4522a585() {
  var_2288bb8dde8a88c5 = (0, 0, 0);
  numplayers = 0;

  foreach(player in level.players) {
    if(!player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(player)) {
      var_2288bb8dde8a88c5 += player.origin;
      numplayers++;
    }
  }

  var_2288bb8dde8a88c5 /= numplayers;
  return var_2288bb8dde8a88c5;
}

function function_e5c53607a2a43f2c() {
  return function_ac2852cc4522a585();
}

function function_b4a05caf7d582d27(var_761bbb068c79f3f2, sweepdirection, var_ef1b7c45e403c3fc) {
  if(!isDefined(var_761bbb068c79f3f2) || !isDefined(sweepdirection) || !isDefined(var_ef1b7c45e403c3fc)) {
    return;
  }

  offsetvector = sweepdirection * var_ef1b7c45e403c3fc;
  var_cf75d11f51aaaaf1 = var_761bbb068c79f3f2 - offsetvector;
  return var_cf75d11f51aaaaf1;
}

function waitfunc() {
  eventstarttime = calculateeventstarttime();
  wait eventstarttime;
}

function function_ce2238c881cf779f() {
  function_cd5d0ed82eacf32d();
}

function function_cd5d0ed82eacf32d() {
  level notify("area_denial_cancel");
  setomnvar("ui_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);

  foreach(drone in level.pe_areadenial.var_f376e6fd9d704520) {
    if(isDefined(drone.var_85324d63191386df) && isarray(drone.var_85324d63191386df) && drone.var_85324d63191386df.size > 0) {
      foreach(player in drone.var_85324d63191386df) {
        drone thread function_d788489e8b30bb51(player);
      }
    }

    drone.var_56548f1ffd2f1a08 scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
    drone.var_ad00f5fd6b531b99 scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
    drone.var_e948744c51c8db44 scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
    drone.var_b1c1e3682e78c27a scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
    drone.scriptable function_770fc7b53ba3b55b();
    drone.scriptable delete();
  }

  level.pe_areadenial.var_f376e6fd9d704520 = [];
}

function starttimer(var_1cffeaf190a5b40f) {
  level endon("game_ended");
  level endon("cancel_public_event");
  level endon("area_denial_cancel");
  eventduration = var_1cffeaf190a5b40f;
  eventendtime = gettime() + eventduration * 1000;
  setomnvar("ui_publicevent_timer_type", 16);
  setomnvar("ui_publicevent_timer", eventendtime);
  setomnvar("ui_minimap_pulse", 1);
  wait var_1cffeaf190a5b40f;
  setomnvar("ui_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
}

function calculateeventstarttime() {
  if(level.pe_areadenial.maxstarttime > level.pe_areadenial.minstarttime) {
    return randomfloatrange(level.pe_areadenial.minstarttime, level.pe_areadenial.maxstarttime);
  }

  return level.pe_areadenial.minstarttime;
}

function function_b5df83a2947e7f8(var_7dea120eca8e0fca) {
  if(!isDefined(var_7dea120eca8e0fca) || var_7dea120eca8e0fca < 0) {
    return;
  }

  if(var_7dea120eca8e0fca == 0) {
    level thread scripts\mp\gametypes\br_public::brleaderdialog("pe_areadenial_event_begin", 1, undefined, 0, 0, undefined, "dx_br_brad_");
    return;
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("pe_areadenial_new_sweep", 1, undefined, 0, 0, undefined, "dx_br_brad_");
}

function function_53e36f636092bfb(value) {
  self setclientomnvar("ui_br_area_denial", value);
}

function function_b7e920cec1a740f0() {
  level.pe_areadenial.dlogdata = [];
  level.pe_areadenial.dlogdata["circle_index"] = ter_op(isDefined(level.br_circle), level.br_circle.circleindex + 1, -1);
  level.pe_areadenial.dlogdata["affected_player_count_per_sweep"] = [];
  level.pe_areadenial.var_da5faf6c293501f7 = [];
  level.pe_areadenial.dlogdata["detected_player_count_per_sweep"] = [];
  level.pe_areadenial.var_1314799d6fcadf1 = [];
  level.pe_areadenial.dlogdata["killed_detected_player_count_per_sweep"] = [];
  level.pe_areadenial.var_4a1efd0a5ea942ae = [];
  level scripts\common\callbacks::add("br_player_killed", &function_ed53542e4f0e5f9d);
}

function function_e8b32e400a713124() {
  level.pe_areadenial.dlogdata["affected_player_count_per_sweep"] = array_add(level.pe_areadenial.dlogdata["affected_player_count_per_sweep"], level.pe_areadenial.var_da5faf6c293501f7.size);
  level.pe_areadenial.var_da5faf6c293501f7 = [];
  level.pe_areadenial.dlogdata["detected_player_count_per_sweep"] = array_add(level.pe_areadenial.dlogdata["detected_player_count_per_sweep"], level.pe_areadenial.var_1314799d6fcadf1.size);
  level.pe_areadenial.var_1314799d6fcadf1 = [];
  level.pe_areadenial.dlogdata["killed_detected_player_count_per_sweep"] = array_add(level.pe_areadenial.dlogdata["killed_detected_player_count_per_sweep"], level.pe_areadenial.var_4a1efd0a5ea942ae.size);
  level.pe_areadenial.var_4a1efd0a5ea942ae = [];
}

function function_f1155cc70db3c061() {
  dlog_recordevent("dlog_event_areadenial_match_event", ["circle_index", level.pe_areadenial.dlogdata["circle_index"], "affected_player_count_per_sweep", level.pe_areadenial.dlogdata["affected_player_count_per_sweep"], "detected_player_count_per_sweep", level.pe_areadenial.dlogdata["detected_player_count_per_sweep"], "killed_detected_player_count_per_sweep", level.pe_areadenial.dlogdata["killed_detected_player_count_per_sweep"]]);
  level scripts\common\callbacks::remove("br_player_killed", &function_ed53542e4f0e5f9d, 1);
}

function function_ed53542e4f0e5f9d(deathdata) {
  if(array_contains(level.pe_areadenial.var_1314799d6fcadf1, deathdata.victim)) {
    level.pe_areadenial.var_4a1efd0a5ea942ae = function_6d6af8144a5131f1(level.pe_areadenial.var_da5faf6c293501f7, deathdata.victim);
  }
}

function function_5b8bc97b741c879c(allicon) {
  gameent = self;
  gameent.iconinfo = spawnStruct();
  gameent.iconinfo.owner = gameent;
  gameent.iconinfo.allicon = allicon;
}

function function_c1c078ad060622ed() {
  gameent = self;

  if(!isDefined(gameent.iconinfo)) {
    return;
  }

  gameent function_770fc7b53ba3b55b();
  gameent.iconinfo = undefined;
}

function function_be29729b31039b7e(playintro, showdistance) {
  gameent = self;

  if(!isDefined(gameent.iconinfo)) {
    return;
  }

  iconorigin = gameent function_2c54b00f5b9dbfcf();

  if(!isDefined(iconorigin)) {
    return;
  }

  if(isDefined(gameent.iconinfo.allicon)) {
    gameent.iconinfo.all = function_1ebb6fa0116af5bb(gameent.iconinfo.allicon, iconorigin, playintro, showdistance);
    scripts\mp\objidpoolmanager::update_objective_onentitywithrotation(gameent.iconinfo.all, gameent);
  }
}

function function_770fc7b53ba3b55b(var_4cf3f1d180aa34e7) {
  gameent = self;
  gameent notify("icon_hide");

  if(!isDefined(gameent.iconinfo)) {
    return;
  }

  if(isDefined(gameent.iconinfo.all)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(gameent.iconinfo.all);
    gameent.iconinfo.all = undefined;
  }
}

function function_1ebb6fa0116af5bb(uiicon, iconorigin, playintro, showdistance) {
  gameent = self;
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(objid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objid, "active", iconorigin, uiicon);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(objid, playintro);
    scripts\mp\objidpoolmanager::function_41f90376ab869b9f(objid, 1);
    function_ebd13ec754e9f503(objid, &"MP/BR_AREA_DENIAL_LABEL");
    objective_setlabel(objid, &"MP/BR_AREA_DENIAL_LABEL");
    function_ea42609ed3485ff2(objid, 1);
    objective_removeallfrommask(objid);

    foreach(player in level.players) {
      if(player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
        continue;
      }

      objective_addclienttomask(objid, player);
    }

    objective_showtoplayersinmask(objid);
    gameent.scriptedobjid = objid;
  } else {
    println("<dev string:x1c>");
  }

  return objid;
}

function function_2c54b00f5b9dbfcf() {
  gameent = self;
  return isDefined(gameent.origin) ? gameent.origin : undefined;
}

function __debug() {}

function debug_init() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x4b>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x63>", "<dev string:x72>", &function_db70bae7732f5204);
  scripts\common\devgui::function_fe953f000498048f();
}

function function_db70bae7732f5204() {
  level thread scripts\mp\gametypes\br_publicevents::function_e37ee072d95a7c98(%"areadenial");
}

# /