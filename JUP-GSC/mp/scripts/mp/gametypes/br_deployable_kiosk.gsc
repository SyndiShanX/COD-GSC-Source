/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_deployable_kiosk.gsc
***********************************************************/

#using script_610f57bddd265be2;
#using scripts\common\ae_utility;
#using scripts\common\debug;
#using scripts\common\system;
#using scripts\common\vehicle;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\supers;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#using scripts\mp\weapons;
#namespace br_deployable_kiosk;

function private autoexec __init__system__() {
  system::register(#"br_deployable_kiosk", undefined, undefined, &post_main);
}

function post_main() {
  if(!getdvarint(@ "scr_br_deployable_kiosk_enabled", 1)) {
    return;
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  function_ce60e2da53459a87();
  function_41b95bcf009214f();
}

function function_ce60e2da53459a87() {
  namespace_2c2703f78fc59600::initvariables();
  scripts\engine\scriptable::scriptable_addusedcallback(&function_208501a7029ab500);
  level.deployablekiosks = spawnStruct();
  level.deployablekiosks.drones = [];
  level.deployablekiosks.dronehealth = getdvarint(@ "hash_6af9ea32f9fbbaa6", 200);
  level.deployablekiosks.var_406bfeebff3aa082 = getdvarint(@ "hash_7d6d2cb2d139a844", 5);
  level.deployablekiosks.drawdebug = 0;
  level.deployablekiosks.var_11f0849a2c7b79ca = getdvarint(@ "hash_dc10f0e5e78347b4", 0) == 1;
  level.deployablekiosks.buystations = [];
  level.deployablekiosks.var_ffe6c41436efb0b2 = getdvarint(@ "hash_37c837989177c57c", 7);
  level.deployablekiosks.var_a03d33b617b44f0a = getdvarint(@ "hash_83b158696cbcbcfd", 0) == 1;
  level.deployablekiosks.var_1e8af39fa33c422e = getdvarint(@ "hash_cdfd65a23b480aa1", 1) == 1;
  level.deployablekiosks.findoptimaldirection = getdvarint(@ "hash_b9d0bfe07133a6b8", 1) == 1;
  level.deployablekiosks.var_f298ad183edd53ef = getdvarint(@ "hash_e0b32ad490e21930", 1) == 1;
  level.deployablekiosks.var_5944536d424aa063 = getdvarint(@ "hash_b2198e7c0b5206a8", 1) == 1;
  level.deployablekiosks.var_338b4f24fc6601c = getdvarint(@ "hash_4c8e6f955528e47e", 85);
  level.deployablekiosks.distancespawn = getdvarint(@ "hash_afa742b5487ef5a3", -9000);
  level.deployablekiosks.var_1a01d5e71d5a4ce = getdvarint(@ "hash_3ca0eef1458f68a4", 1300);
  level.deployablekiosks.var_aad8a9e2592cf1a5 = getdvarint(@ "hash_5881e1a607c924db", 6700);
  level.deployablekiosks.var_8c3590379c7ab36f = getdvarint(@ "hash_3e56c6bbb230d4cd", 4000);
  level.deployablekiosks.var_90aa3a29f5c33db3 = getdvarint(@ "hash_af27e42ca35d8854", 200);
  level.deployablekiosks.explosionradius = getdvarint(@ "hash_422387a5d7b1948e", 512);
  level.deployablekiosks.explosiondamage = getdvarint(@ "hash_3b47b4edafa8e459", 40);
  level.deployablekiosks.var_3d4073df2f497525 = getdvarfloat(@ "hash_2ec1c01324ea0e78", 9);
  level.deployablekiosks.var_e90f0fe1f275a8b6 = getdvarfloat(@ "scr_br_deployable_kiosk_distance_threshold_gas", 1574);
  level.deployablekiosks.var_aeeb98b4d36b65a6 = getdvarfloat(@ "scr_br_deployable_kiosk_distance_threshold_gas_multi_circle", 1574);
  level.deployablekiosks.var_1a19bd75a8860186 = getdvarint(@ "hash_56748969528a88e7", 0) == 1;
  level.deployablekiosks.var_e134bc850cb28724 = getdvarint(@ "hash_29fd03280bc10d14", 1) == 1;
  level.deployablekiosks.var_d455ff81de6949d = getdvarfloat(@ "hash_792338b4d870020d", 80);
  level.deployablekiosks.var_8bf814f9559f53 = getdvarint(@ "hash_20375e1dd455ac75", 0);
  level.deployablekiosks.var_aaa31c1e28a5663c = getdvarint(@ "hash_2b642e46a41d6d73", 0);
  level.var_4358d3a0ee13b0f9 = &function_590979ef771686a8;
  level.var_ae0244c4c517ba75 = &function_aa19007a48fca6c0;
  level.var_ff4bbeb786042d78 = &function_ff4bbeb786042d78;
  scripts\mp\gametypes\br_circle::registercirclecallbacks(15, &function_1e28980b8235671e, &function_b77546749eb0c127, &function_313d9044d8e6f53c, &function_ad1b6f540c35705d);
  level._effect["deployable_kiosk_explosion"] = loadfx("vfx/iw9/prop/scriptables/vfx_military_deployable_buystation.vfx");
}

function function_41b95bcf009214f() {
  assert(isDefined(game["<dev string:x1c>"]));
  game["dialog"]["deploy_ready"] = "dplb_grav_redy";
  game["dialog"]["enemy_active"] = "dplb_grav_nmy1";
  game["dialog"]["friendly_active"] = "dplb_grav_frnd";
}

function function_208501a7029ab500(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  if(!scripts\mp\gametypes\br_public::isdeployablekiosk(instance.type)) {
    return;
  }

  if(!istrue(instance.entity.var_98aabca05601aa67) && istrue(instance.entity.isemped)) {
    player playlocalsound("br_plunder_atm_cancel");
    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/EMPED_DEPLOYABLE_KIOSK");
    return;
  }

  if(!istrue(instance.entity.var_98aabca05601aa67)) {
    player playlocalsound("br_plunder_atm_cancel");
    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/UNUSABLE_DEPLOYABLE_KIOSK");
    return;
  }

  if(isDefined(player) && isDefined(player.var_e5520effcbe8bd30)) {
    player playlocalsound("br_plunder_atm_cancel");
    return;
  }

  if(isDefined(player) && istrue(player.iszombie)) {
    player playlocalsound("br_plunder_atm_cancel");
    return;
  }

  if(!isDefined(instance.playersusing)) {
    instance.playersusing = [];
  }

  instance.playersusing[instance.playersusing.size] = player;

  if(scripts\engine\utility::issharedfuncdefined(#"biometricscan", #"reportkeycardcount")) {
    [[scripts\engine\utility::getsharedfunc(#"biometricscan", #"reportkeycardcount")]](player);
  }

  instance.isdeployablekiosk = 1;
  player thread scripts\mp\gametypes\br_armory_kiosk::_runpurchasemenu(instance);
  player thread scripts\mp\gametypes\br_armory_kiosk::function_3b647c2b49a4e63e();
}

function function_590979ef771686a8(player, location, fromevent) {
  owner = undefined;
  ownerteam = undefined;

  if(isDefined(player)) {
    owner = player;
    ownerteam = player.team;
  }

  traceheight = scripts\cp_mp\parachute::getc130height();
  locationto = scripts\mp\gametypes\br_public::droptogroundmultitrace((location[0], location[1], traceheight));

  if(istrue(level.deployablekiosks.var_1a19bd75a8860186)) {
    var_4e4df9cada88ab11 = "[deployableKioskSpawned]" + ": " + default_to(player.name, "-") + ", " + default_to(player getxuid(), "-") + ", " + default_to(player.team, "-") + ", " + default_to(player.origin[0], string(0)) + ", " + default_to(player.origin[1], string(0)) + ", " + default_to(player.origin[2], string(0)) + ", " + default_to(location[0], string(0)) + ", " + default_to(location[1], string(0)) + ", " + default_to(location[2], string(0)) + ", " + default_to(locationto[0], string(0)) + ", " + default_to(locationto[1], string(0)) + ", " + default_to(locationto[2], string(0));
    logstring(var_4e4df9cada88ab11);
  }

  optimaldirection = undefined;

  if(level.deployablekiosks.findoptimaldirection) {
    optimaldirection = function_b8214cb8c9e75675(player, locationto);
  }

  goto = spawnStruct();
  goto.origin = locationto + (0, 0, level.deployablekiosks.var_1a01d5e71d5a4ce);

  if(isDefined(optimaldirection)) {
    goto.dir = optimaldirection;
  } else {
    goto.dir = vectornormalize2(getclosestpointonnavmesh(locationto) - goto.origin);
  }

  goto.angles = generateaxisanglesfromforwardvector(goto.dir, (0, 0, 1));
  startingloc = goto.dir * level.deployablekiosks.distancespawn + (0, 0, level.deployablekiosks.var_aad8a9e2592cf1a5);
  goto.exit = (startingloc[0] + goto.origin[0], startingloc[1] + goto.origin[1], startingloc[2]);
  drone = spawn("script_model", goto.exit);
  drone.goto = goto;
  drone setModel("veh9_mil_air_drone_supply_sweep");
  drone.angles = (0, randomint(360), 0);
  drone.speed = 0;
  drone.health = level.deployablekiosks.dronehealth;
  drone.maxhealth = drone.health;
  drone.owner = owner;
  drone.team = ownerteam;
  drone.type = "portable_buy_drone";

  if(level.deployablekiosks.var_8bf814f9559f53) {
    drone scripts\cp_mp\emp_debuff::set_apply_emp_callback(&drone_emp);
    drone.var_3545410459b16762 = &drone_emp;
  }

  if(isDefined(player) || level.deployablekiosks.var_8bf814f9559f53) {
    drone setCanDamage(1);
  } else {
    drone setCanDamage(0);
  }

  drone forcenetfieldhighlod(1);

  if(isDefined(player) || level.deployablekiosks.var_8bf814f9559f53) {
    scripts\mp\weapons::function_e00b77a9cb4d8322(drone);
    drone thread function_78966bc6b28da9b4();
  }

  drone thread function_88ad5bddafd52f6e(fromevent);
  drone.fromevent = istrue(fromevent);
  level.deployablekiosks.drones[level.deployablekiosks.drones.size] = drone;

  if(isDefined(player)) {
    teammates = level.teamdata[player.team]["alivePlayers"];

    if(teammates.size > 0) {
      foreach(p in teammates) {
        if(!isDefined(p)) {
          continue;
        }

        p thread scripts\mp\hud_message::showsplash("br_deployable_kiosk_incoming", undefined, drone.owner);
      }
    }
  }

  drone.spawnorigin = drone.origin;
  drone.goalorigin = goto.origin;
  drone.requestx = location[0];
  drone.requesty = location[1];
  drone.requestz = location[2];
  totalplunder = 0;

  if(isDefined(player)) {
    var_bbb0b7af9811acef = scripts\mp\utility\teams::getteamdata(player.team, "alivePlayers");

    foreach(ent in var_bbb0b7af9811acef) {
      totalplunder += ent.plundercount;
    }
  }

  drone.var_6c90750b2bde4f94 = totalplunder;
}

function function_b8214cb8c9e75675(player, location) {
  spawnangles = (0, 0, 0);

  if(!isDefined(player)) {
    spawnangles = (0, randomfloatrange(0, 360), 0);
  } else {
    spawnangles = player.angles;
  }

  var_d77253c873d2b420 = anglesToForward(spawnangles);
  contents = scripts\engine\trace::create_default_contents(1);
  trace = scripts\engine\trace::ray_trace(location - var_d77253c873d2b420 * 30, location + var_d77253c873d2b420 * 1000, undefined, contents);
  coord = trace["position"] + trace["normal"] * 20;
  targetpos = location;
  targetheightoffset = scripts\cp_mp\parachute::getc130height();
  ownerforward = anglesToForward(spawnangles);
  ownerright = anglestoright(spawnangles);
  var_f74f18c717b149e2 = [targetpos + (-1 * ownerforward - ownerright) * 100, targetpos + (ownerright - ownerforward) * 100, targetpos - ownerforward * 100, targetpos + ownerforward * 100, targetpos + ownerright * 100, targetpos - ownerright * 100, targetpos + (ownerforward + ownerright) * 100, targetpos + (ownerforward - ownerright) * 100];
  bestdirection = vectorNormalize(var_f74f18c717b149e2[2] - targetpos);
  var_e3b1338d5bd4399f = 0;
  bestfraction = 0;
  var_a9df94497d7dbdaf = 0;

  foreach(dirpos in var_f74f18c717b149e2) {
    var_7a7426e42e674e40 = vectorNormalize(dirpos - targetpos);
    var_c45bbeb56df09b5d = targetpos * (1, 1, 0) + (0, 0, targetheightoffset);
    var_32a961dac02545b0 = var_c45bbeb56df09b5d - var_7a7426e42e674e40 * 24000;
    var_19189fd85d8a2c19 = var_c45bbeb56df09b5d + var_7a7426e42e674e40 * 24000;
    traceresult = scripts\engine\trace::ray_trace_passed(var_32a961dac02545b0, var_19189fd85d8a2c19, undefined, contents);

    if(!istrue(traceresult)) {
      continue;
    }

    if(istrue(var_a9df94497d7dbdaf)) {
      level thread scripts\cp_mp\utility\debug_utility::drawline(var_32a961dac02545b0, var_19189fd85d8a2c19, 30, (1, 1, 0));
    }

    var_48384e792726b96a = var_c45bbeb56df09b5d - var_7a7426e42e674e40 * int(8000);
    var_e313995ecad6abbc = [targetpos, targetpos - var_7a7426e42e674e40 * 512, targetpos - var_7a7426e42e674e40 * 256, targetpos + var_7a7426e42e674e40 * 256, targetpos + var_7a7426e42e674e40 * 512];
    successfulhits = 0;

    foreach(endtracepos in var_e313995ecad6abbc) {
      results = scripts\engine\trace::ray_trace(var_48384e792726b96a, endtracepos, undefined, contents);
      traceresult = results["fraction"] == 1;

      if(!istrue(traceresult)) {
        if(istrue(var_a9df94497d7dbdaf)) {
          line(var_48384e792726b96a, results["<dev string:x26>"], (1, 1, 0), 1, 0, 500);
          line(results["<dev string:x26>"], endtracepos, (1, 0, 0), 1, 0, 500);
        }

        continue;
      }

      successfulhits++;

      if(istrue(var_a9df94497d7dbdaf)) {
        line(var_48384e792726b96a, endtracepos, (0, 1, 0), 1, 0, 500);
      }
    }

    if(successfulhits > var_e3b1338d5bd4399f) {
      bestdirection = var_7a7426e42e674e40;
      var_e3b1338d5bd4399f = successfulhits;

      if(successfulhits >= 3) {
        break;
      }
    }
  }

  return bestdirection;
}

function drone_emp(data) {
  function_aa19007a48fca6c0(data.attacker);
}

function function_55eb87459df66db5(data) {
  function_98913cb90ff3af87();
  thread scripts\mp\gametypes\br_armory_kiosk::function_ed7c6787b596188e(data);
}

function function_88ad5bddafd52f6e(fromevent) {
  drone = self;
  level endon("game_ended");
  drone endon("entitydeleted");
  drone.var_1d3bf3b408da503f = 0;

  if(level.deployablekiosks.drawdebug) {
    if(getdvarint(@ "hash_d7987b5db214b981", 0)) {
      debug::debug_sphere(drone, 25, (1, 0, 0), undefined, "<dev string:x32>", "<dev string:x5d>");
      debug::draw_angles(drone, undefined, 150, undefined, "<dev string:x32>", "<dev string:x5d>");
    }
  }

  goto = spawnStruct();
  goto.origin = drone.goto.origin;
  goto.angles = drone.goto.angles;
  team = undefined;

  if(isDefined(drone.owner) && isDefined(drone.owner.team)) {
    team = drone.owner.team;
  }

  drone.buystation = spawn("script_model", drone.origin);
  drone.buystation setModel("military_deployable_buystation");
  drone.buystation linkTo(drone, "tag_origin", (0, 0, -75), (0, 0, 0));
  drone.buystation setCanDamage(1);
  drone.buystation.maxhealth = 999999999;
  drone.buystation.health = 999999999;
  drone.buystation function_4e70ba4ebdc8dbe9(drone.owner, "ui_map_icon_buystation_drone", "ui_map_icon_buystation_drone_enemy");
  drone.buystation thread function_90fa8c1f0ea25d78();
  drone.buystation.team = team;
  drone.buystation.owner = drone.owner;
  drone.buystation.var_98aabca05601aa67 = 1;
  drone.buystation.var_c23ca3472233553d = 1;
  drone.buystation.type = "deployable_buystation";
  drone.buystation.reactivatefunc = &function_313d9044d8e6f53c;

  if(level.deployablekiosks.var_aaa31c1e28a5663c) {
    drone.buystation scripts\cp_mp\emp_debuff::set_apply_emp_callback(&function_55eb87459df66db5);
    drone.buystation.var_3545410459b16762 = &function_55eb87459df66db5;
  }

  if(isDefined(drone.owner)) {
    drone playsoundtoplayer("kiosk_drone_eng_swt", drone.owner, drone);
  }

  drone.buystation.dronedeployablekiosk = drone;
  level.deployablekiosks.buystations[level.deployablekiosks.buystations.size] = drone.buystation;

  if(!istrue(fromevent)) {
    drone.buystation function_9e8c5e7b9d1572b7();
  }

  if(isDefined(drone.team)) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("friendly_active", drone.team, 1, 2, undefined);
    droneteam = scripts\mp\utility\teams::getteamdata(drone.team, "players");
    midwaypoint = ((goto.origin[0] + drone.origin[0]) / 2, (goto.origin[1] + drone.origin[1]) / 2, (goto.origin[2] + drone.origin[2]) / 2);
    var_ec0171e2f69933c1 = scripts\mp\gametypes\br_public::droptogroundmultitrace(midwaypoint);
    var_826839f2397f1e47 = scripts\mp\gametypes\br_public::droptogroundmultitrace(goto.origin);
    var_1f0e57a3271d5faf = scripts\mp\utility\player::getplayersinradius(var_ec0171e2f69933c1, level.deployablekiosks.var_8c3590379c7ab36f, undefined, droneteam);
    var_20dab4933911dadf = scripts\mp\utility\player::getplayersinradius(var_826839f2397f1e47, level.deployablekiosks.var_8c3590379c7ab36f, undefined, droneteam);
    var_b6cd0d44c9bc37e5 = array_combine(var_1f0e57a3271d5faf, var_20dab4933911dadf);

    if(isDefined(var_b6cd0d44c9bc37e5) || var_b6cd0d44c9bc37e5.length > 0) {
      foreach(player in var_b6cd0d44c9bc37e5) {
        level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("enemy_active", player, 1, undefined, 2, undefined);
      }
    }
  }

  if(istrue(level.deployablekiosks.var_1a19bd75a8860186)) {
    var_4e4df9cada88ab11 = "[deployableKioskMovingSequence]" + ": " + default_to(goto.origin[0], string(0)) + ", " + default_to(goto.origin[1], string(0)) + ", " + default_to(goto.origin[2], string(0));
    logstring(var_4e4df9cada88ab11);
  }

  function_dcf070d2485a90a4(goto, 0);
  drone thread function_4132402c7ec5947c();
  wait 3;
  goto.origin = drone.goto.exit;
  function_dcf070d2485a90a4(goto, 1);
  level.deployablekiosks.drones = array_remove(level.deployablekiosks.drones, drone);
  level.deployablekiosks.drones = array_removeundefined(level.deployablekiosks.drones);
  drone delete();
}

function function_4132402c7ec5947c(eattacker) {
  drone = self;
  drone.buystation unlink();
  drone.buystation.physicsactivated = 1;
  drone.buystation physicslaunchserver((0, 0, 0), (0, 0, 0));
  bodyid = drone.buystation physics_getbodyid(0);
  physics_setbodycenterofmassnormal(bodyid, (0, 0, 1));
  drone.buystation.angles = (0, drone.buystation.angles[1], 0);
  drone.var_1d3bf3b408da503f = 1;
  drone.buystation function_42349f0ab9120240();
  drone.buystation thread function_c9064aca910696fa();
  drone.buystation playSound("br_deployable_kiosk_detach");
  drone thread function_3313d37dfd52a977();
  drone function_f0b074bef81e8c7b(eattacker);

  if(istrue(level.deployablekiosks.var_1a19bd75a8860186)) {
    var_4e4df9cada88ab11 = "[deployableKioskDrop]" + ": " + default_to(drone.origin[0], string(0)) + ", " + default_to(drone.origin[1], string(0)) + ", " + default_to(drone.origin[2], string(0));
    logstring(var_4e4df9cada88ab11);
  }
}

function function_dcf070d2485a90a4(goto, var_ceb89b7c7c66002a) {
  drone = self;
  drone.var_3b4fee20d214bd9b = undefined;
  drone.var_f44262daab1a384a = undefined;
  drone.speed = 0;
  drone thread function_6d9358d777958a1b(goto, var_ceb89b7c7c66002a);
  drone thread namespace_2c2703f78fc59600::function_53a07930f4fc0e08(goto);
  drone thread function_19375ce96b24aff();
  drone waittill("redeploy_drone_arrive");

  while(!isDefined(drone.var_3b4fee20d214bd9b) || !isDefined(drone.var_f44262daab1a384a)) {
    wait 1;
  }

  drone.var_3b4fee20d214bd9b = undefined;
  drone.var_f44262daab1a384a = undefined;
}

function function_6d9358d777958a1b(var_daad7d20d7a17c02, var_ceb89b7c7c66002a) {
  level endon("game_ended");
  self endon("entitydeleted");
  self.v_destination = var_daad7d20d7a17c02.origin;
  var_f69a5288e749a523 = level.deployablekiosks.var_338b4f24fc6601c;
  var_f3da9daf22907093 = 15000;

  utility::function_2bf8ec790b5a10f8(@ "hash_d7987b5db214b981", [ &debug::debug_line, self, var_daad7d20d7a17c02.origin, (1, 0, 0), undefined, "<dev string:x32>", "<dev string:x8d>"]);

  intervaltime = 0.05;

  if(var_ceb89b7c7c66002a) {
    self.speed = 0;

    while(self.speed < var_f69a5288e749a523) {
      self.speed += 1;

      if(self.speed > var_f69a5288e749a523) {
        self.speed = var_f69a5288e749a523;
      }

      self moveTo(self.origin + self.speed * vectorNormalize(self.v_destination - self.origin), intervaltime, 0, 0);
      wait intervaltime;
    }
  } else {
    self.speed = 180;

    while(self.speed > var_f69a5288e749a523) {
      self.speed -= 0.8;

      if(self.speed < var_f69a5288e749a523) {
        self.speed = var_f69a5288e749a523;
      }

      self moveTo(self.origin + self.speed * vectorNormalize(self.v_destination - self.origin), intervaltime, 0, 0);
      wait intervaltime;
    }
  }

  intervaltime = 0.05;

  if(self.speed > level.var_fc4bb27a820f54dd.var_73e374ce21fb4fb5) {
    while(distancesquared(self.origin, self.v_destination) > squared(self.speed * 20 * 0.5)) {
      self moveTo(self.origin + self.speed * vectorNormalize(self.v_destination - self.origin), 0.052, 0, 0);
      wait 0.05;
    }

    self notify("redeploy_drone_arrive");

    while(distancesquared(self.origin, self.v_destination) > var_f3da9daf22907093) {
      self moveTo(self.origin + (self.v_destination - self.origin) * 0.05 / 0.52, 0.05, 0, 0);
      self.speed *= 0.95;
      wait 0.05;
    }
  } else {
    while(distancesquared(self.origin, self.v_destination) > 500) {
      self moveTo(self.origin + self.speed * vectorNormalize(self.v_destination - self.origin), 0.05, 0, 0);
      wait 0.05;
    }

    self notify("redeploy_drone_arrive");

    while(distancesquared(self.origin, self.v_destination) > 0.01) {
      self moveTo(self.origin + (self.v_destination - self.origin) * 0.1, 0.05, 0, 0);
      self.speed *= 0.9;
      wait 0.05;
    }
  }

  self.speed = 0;
  self.v_destination = undefined;
  self.var_3b4fee20d214bd9b = 1;
}

function function_3313d37dfd52a977() {
  drone = self;
  teamdialog = drone.team;
  kiosk = drone.buystation;
  kiosk endon("death");
  level endon("game_ended");
  kiosk.var_325bf59fe5f05db3 = 0;

  if(level.deployablekiosks.var_1e8af39fa33c422e) {
    kiosk thread function_443c7f998e6d02eb();
  }

  waitingtime = level.deployablekiosks.var_3d4073df2f497525;
  waitinginterval = 0.5;

  while(!kiosk.var_325bf59fe5f05db3 && waitingtime > 0) {
    contents = scripts\engine\trace::create_default_contents(1);
    ignoreents = [kiosk];
    trace = scripts\engine\trace::ray_trace(kiosk.origin, kiosk.origin - (0, 0, 100), ignoreents, contents);

    if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none") {
      kiosk.var_325bf59fe5f05db3 = 1;
    }

    waitingtime -= waitinginterval;
    wait waitinginterval;
  }

  kiosk.var_325bf59fe5f05db3 = 1;

  if(isDefined(kiosk) && isDefined(teamdialog)) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("deploy_ready", teamdialog, 1, 2, undefined);
  }

  if(level.deployablekiosks.var_e134bc850cb28724) {
    kiosk monitoraveragevelocityandupdate();
    lootarray = getlootscriptablearrayinradius(undefined, undefined, kiosk.origin, level.deployablekiosks.var_d455ff81de6949d);

    if(isDefined(lootarray)) {
      foreach(loot in lootarray) {
        if(!scripts\mp\gametypes\br_pickups::function_2ae5e94bd6518ab5(loot, 0)) {
          continue;
        }

        if(loot getscriptableisreserved() && !isDefined(loot.brpickupscriptableid)) {
          continue;
        }

        scripts\mp\gametypes\br_pickups::loothide(loot);
      }
    }
  }
}

function monitoraveragevelocityandupdate() {
  kiosk = self;
  kiosk endon("death");
  level endon("game_ended");
  kiosk notify("monitorAverageVelocityAndUpdate");
  kiosk endon("monitorAverageVelocityAndUpdate");
  var_e8893003a2073456 = 0.1;
  var_d315a7ea0605287e = 8;
  kiosk thread scripts\cp_mp\killstreaks\airdrop::monitoraveragevelocities(var_e8893003a2073456, var_d315a7ea0605287e);
  settlecount = 0;
  var_4080d353839c6230 = 0;
  var_1684a0b0fb3502c6 = undefined;

  while(!istrue(self.physicssettled)) {
    var_7e41acfab43987ed = scripts\cp_mp\killstreaks\airdrop::getaveragelinearvelocity();
    var_4f4e6a033ea9ada4 = scripts\cp_mp\killstreaks\airdrop::getaverageangularvelocity();

    if(isDefined(var_7e41acfab43987ed) && isDefined(var_4f4e6a033ea9ada4)) {
      if(var_7e41acfab43987ed <= scripts\cp_mp\killstreaks\airdrop::function_3c4492046080faa9() && var_4f4e6a033ea9ada4 <= scripts\cp_mp\killstreaks\airdrop::function_f7e3f128296ac3b6()) {
        settlecount++;
        var_4080d353839c6230 = 0;

        if(settlecount == scripts\cp_mp\killstreaks\airdrop::function_d4833b6c916db9c6()) {
          self.physicssettled = 1;
          var_1684a0b0fb3502c6 = self.origin;
        }
      } else {
        if(isDefined(var_1684a0b0fb3502c6)) {
          if(distancesquared(self.origin, var_1684a0b0fb3502c6) <= 2500) {
            wait var_e8893003a2073456;
            continue;
          }
        }

        var_4080d353839c6230++;
        settlecount = 0;

        if(var_4080d353839c6230 == 1) {
          self.physicssettled = undefined;
        }
      }

      wait var_e8893003a2073456;
      continue;
    }

    waitframe();
  }
}

function function_19375ce96b24aff() {
  drone = self;
  level endon("game_ended");
  drone endon("entitydeleted");
  wait 1;
  drone setscriptablepartstate("redeploy_drone_relocation_sfx", "kiosk_drone_move_sfx");
  drone waittill("redeploy_drone_arrive");
  drone setscriptablepartstate("redeploy_drone_relocation_sfx", "kiosk_drone_idle_sfx");
}

function function_443c7f998e6d02eb() {
  kiosk = self;
  kiosk endon("death");
  level endon("game_ended");
  kiosk endon("monitorPlayerImpactEnd");
  kiosk physics_registerforcollisioncallback();
  var_e6de3e488795da29 = 0;
  var_7b497a1523996243 = [];
  var_dbbb663991d31286 = 0;

  while(true) {
    kiosk waittill("collision", body0, body1, flag0, flag1, position, normal, impulse, ent);

    if(level.deployablekiosks.var_f298ad183edd53ef) {
      kiosk checklinktotrain(ent);
    }

    if(level.deployablekiosks.var_5944536d424aa063 && ent isvehicle() && !array_contains(var_7b497a1523996243, ent) && !istrue(kiosk.var_325bf59fe5f05db3)) {
      ent dodamage(max(0, ent.health - 30), kiosk.origin, undefined, undefined, "MOD_EXPLOSIVE");
      var_7b497a1523996243[var_7b497a1523996243.size] = ent;
    }

    if(gettime() - var_e6de3e488795da29 >= level.deployablekiosks.var_90aa3a29f5c33db3) {
      var_e6de3e488795da29 = gettime();
      surface = physics_getsurfacetypefromflags(flag1);
      surfacetype = getsubstr(surface["name"], 9);

      if(surfacetype == "user_terrain1") {
        surfacetype = "user_terrain_1";
      }

      if(surfacetype == "user_terrain5") {
        surfacetype = "user_terrain_5";
      }

      kiosk function_a23aa2d6571bd5e4(position, normal, impulse, surfacetype);
    }
  }
}

function checklinktotrain(ent) {
  kiosk = self;

  if(isDefined(ent) && isDefined(ent.script_noteworthy) && isstartstr(ent.script_noteworthy, "train_") && !isDefined(kiosk getlinkedparent())) {
    if(isDefined(kiosk.trainent)) {
      if(kiosk.trainent == ent) {
        return;
      } else {
        kiosk cancelchecklinktotrain();
      }
    }

    kiosk.trainent = ent;
    kiosk.traincylestolink = 4;
    kiosk thread checklinktotraininternal(ent);
  }
}

function cancelchecklinktotrain() {
  kiosk = self;
  kiosk notify("cancel_link_to_train");
  kiosk.trainent = undefined;
  kiosk.traintracerelpos = undefined;
  kiosk.traintracefails = undefined;
  kiosk.traintracesuccesses = undefined;
}

function checklinktotraininternal(ent) {
  kiosk = self;
  kiosk endon("death");
  kiosk endon("cancel_link_to_train");
  ent endon("death");
  var_98296bb53c7acf6e = 4;
  halfheight = 30;
  raycastdist = 200;
  var_1375dd9df5ebf6cd = 100;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
  ignorelist = [self];

  foreach(linkedent in self getlinkedchildren(1)) {
    ignorelist[ignorelist.size] = linkedent;
  }

  self.traintracefails = 0;
  self.traintracesuccesses = 0;

  while(self.traintracefails < 20) {
    caststart = self.origin + anglestoup(self.angles) * halfheight;
    castend = caststart + (0, 0, -1 * raycastdist);
    traceresult = scripts\engine\trace::ray_trace(caststart, castend, ignorelist, contents);

    if(traceresult.size > 0 && isDefined(traceresult["entity"]) && scripts\cp_mp\utility\train_utility::is_train_ent(traceresult["entity"])) {
      traintracerelpos = combineangles(invertangles(ent.angles), ent.origin - traceresult["position"]);

      if(!isDefined(self.traintracerelpos)) {} else if(distancesquared(traintracerelpos, self.traintracerelpos) > var_1375dd9df5ebf6cd) {
        self.traintracefails++;
        self.traintracesuccesses = 0;
      } else {
        self.traintracesuccesses++;

        if(self.traintracesuccesses >= var_98296bb53c7acf6e) {
          self linkTo(ent);
          thread function_d49b71f319f0c952();
          break;
        }
      }

      self.traintracerelpos = traintracerelpos;
    } else {
      break;
    }

    wait 0.1;
  }

  thread cancelchecklinktotrain();
}

function function_d49b71f319f0c952() {
  kiosk = self;

  if(!istrue(kiosk.physicsactivated)) {
    return;
  }

  kiosk.physicsactivated = undefined;
  kiosk.physicssettled = undefined;
  kiosk physicsstopserver();
  kiosk scripts\cp_mp\killstreaks\airdrop::monitorplayerimpactend();
  kiosk cancelchecklinktotrain();
}

function function_a23aa2d6571bd5e4(position, normal, impulse, surfacetype) {
  kiosk = self;

  if(surfacetype != "glass_pane") {
    if(impulse > 350) {
      self playsoundonmovingent("br_deployable_kiosk_impact_high");
      return;
    }

    if(350 > impulse && impulse > 100) {
      self playsoundonmovingent("br_deployable_kiosk_impact_medium");
      return;
    }

    if(100 > impulse && impulse > 30) {
      self playsoundonmovingent("br_deployable_kiosk_impact_low");
    }
  }
}

function function_78966bc6b28da9b4() {
  drone = self;
  level endon("game_ended");
  drone endon("entitydeleted");
  drone endon("deployable_kiosk_drone_shot_down");

  while(true) {
    drone waittill("damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon);
    drone function_614262699fa8e2f2(idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon);
  }
}

function function_90fa8c1f0ea25d78() {
  kiosk = self;
  level endon("game_ended");
  kiosk endon("entitydeleted");
  kiosk endon("death");

  while(true) {
    kiosk waittill("damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon);

    if(isDefined(kiosk.dronedeployablekiosk) && !istrue(kiosk.dronedeployablekiosk.var_1d3bf3b408da503f)) {
      kiosk.dronedeployablekiosk function_614262699fa8e2f2(idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon);
    }
  }
}

function function_614262699fa8e2f2(idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon) {
  drone = self;

  if(isPlayer(eattacker)) {
    eattacker scripts\cp_mp\damagefeedback::updatehitmarker("standard", drone.health == 0, 0, 1, "hitequip");
  } else if(isDefined(eattacker.owner) && isPlayer(eattacker.owner)) {
    eattacker.owner scripts\cp_mp\damagefeedback::updatehitmarker("standard", drone.health == 0, 0, 1, "hitequip");
  }

  if(isDefined(eattacker.model) && eattacker.model == "veh8_mil_air_lbravo_mp_flyable" || eattacker.model == "veh8_mil_air_lbravo_mp_flyable_mg") {
    level thread namespace_2c2703f78fc59600::function_cf65fbc1c077fadb(eattacker, drone.origin);
  }

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE") {
    idamage = int(idamage * level.var_fc4bb27a820f54dd.var_4b2cdacf483dccc4);
  }

  if(isDefined(modelname) && modelname == "ks_airstrike_target_br_ch3") {
    idamage = level.var_fc4bb27a820f54dd.var_71ba1ddbe86cab15;
  }

  drone.health -= idamage;

  if(!isDefined(drone.var_dfdcc313086c8290)) {
    drone.var_dfdcc313086c8290 = 0;
  }

  drone.var_dfdcc313086c8290 += 1;

  if(isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "toma_proj_mp") {
    drone.health = 0;
  }

  if(drone.health <= 0) {
    drone thread function_aa19007a48fca6c0(eattacker);
    drone notify("deployable_kiosk_drone_shot_down");
    return;
  }

  if(level.deployablekiosks.var_11f0849a2c7b79ca && isDefined(self.var_1d3bf3b408da503f) && !self.var_1d3bf3b408da503f) {
    drone thread function_495982203bfc8d29(eattacker);
  }
}

function function_495982203bfc8d29(eattacker) {
  drone = self;
  var_54a8b2d622f1a1e0 = drone.maxhealth / 2;

  if(!isDefined(drone.var_3e9b7fbc105df68b)) {
    drone.var_3e9b7fbc105df68b = 3;
  }

  for(i = 2; i > 0; i--) {
    if(drone.health < var_54a8b2d622f1a1e0 * i) {
      if(drone.var_3e9b7fbc105df68b > i) {
        drone.var_3e9b7fbc105df68b = i;
        eattacker scripts\mp\utility\points::doscoreevent(#"hash_6141024a6fca1305");
        itemlist = ["brloot_plunder_cash_common_1", "brloot_armor_plate"];
        randomnumber = randomint(100);
        dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
        dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, drone.var_43ffd30a35b0da72.origin - (0, 0, 200), drone.var_43ffd30a35b0da72.angles, drone, undefined, undefined, undefined, undefined, undefined, 12000);

        if(randomnumber < 70) {
          item = scripts\mp\gametypes\br_pickups::spawnpickup(itemlist[0], dropinfo, undefined, 1, undefined, 0);
        } else {
          item = scripts\mp\gametypes\br_pickups::spawnpickup(itemlist[1], dropinfo, undefined, 1, undefined, 0);
        }

        break;
      }
    }
  }
}

function function_9e8c5e7b9d1572b7() {
  buystation = self;

  if(level.deployablekiosks.var_a03d33b617b44f0a) {
    foreach(deployablekiosk in level.deployablekiosks.buystations) {
      if(deployablekiosk == buystation) {
        continue;
      }

      if(!isDefined(buystation.team) || !isDefined(deployablekiosk.team)) {
        continue;
      }

      if(buystation.team == deployablekiosk.team) {
        deployablekiosk thread function_f5a81afeb40e65cd();
      }
    }
  }

  var_9b5871d1f2cb57e9 = 0;

  foreach(var_7551d41cb4f1b721 in level.deployablekiosks.buystations) {
    if(!isDefined(var_7551d41cb4f1b721)) {
      continue;
    }

    var_9b5871d1f2cb57e9++;
  }

  if(var_9b5871d1f2cb57e9 > level.deployablekiosks.var_ffe6c41436efb0b2) {
    var_f079a3ac63ff9964 = level.deployablekiosks.buystations[0];
    var_f079a3ac63ff9964 thread function_f5a81afeb40e65cd();
  }
}

function function_1e28980b8235671e(dangercircleorigin, dangercircleradius, thresholdradius) {
  if(getdvarint(@ "hash_271d21fb3081ae5f", 0) == 1) {
    return;
  }

  if(!isDefined(level.deployablekiosks.buystations)) {
    return;
  }

  var_52d59c928eb97c81 = dangercircleradius + level.deployablekiosks.var_e90f0fe1f275a8b6;
  var_c434624ff361bba2 = var_52d59c928eb97c81 * var_52d59c928eb97c81;

  foreach(deployablekiosk in level.deployablekiosks.buystations) {
    var_e4e4ae4481958d2e = distance2dsquared(deployablekiosk.origin, dangercircleorigin) + level.deployablekiosks.var_e90f0fe1f275a8b6 > var_c434624ff361bba2;

    if(istrue(deployablekiosk.var_98aabca05601aa67)) {
      if(var_e4e4ae4481958d2e) {
        deployablekiosk function_98913cb90ff3af87();
      }

      continue;
    }

    if(!var_e4e4ae4481958d2e && !istrue(deployablekiosk.isemped)) {
      function_313d9044d8e6f53c(deployablekiosk);
    }
  }
}

function function_b77546749eb0c127(dangercircleorigin, dangercircleradius, thresholdradius) {
  if(getdvarint(@ "hash_271d21fb3081ae5f", 0) == 1) {
    return;
  }

  if(!isDefined(level.deployablekiosks.buystations)) {
    return;
  }

  hiddenkiosks = [];

  foreach(deployablekiosk in level.deployablekiosks.buystations) {
    var_e4e4ae4481958d2e = !scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(deployablekiosk.origin, level.deployablekiosks.var_aeeb98b4d36b65a6);

    if(istrue(deployablekiosk.var_98aabca05601aa67)) {
      if(var_e4e4ae4481958d2e) {
        hiddenkiosks[hiddenkiosks.size] = deployablekiosk;
        deployablekiosk function_98913cb90ff3af87();
      }

      continue;
    }

    if(!var_e4e4ae4481958d2e && !istrue(deployablekiosk.isemped)) {
      hiddenkiosks = array_remove(hiddenkiosks, deployablekiosk);
      function_313d9044d8e6f53c(deployablekiosk);
    }
  }

  return hiddenkiosks;
}

function function_7b0648952e816403(deployablekiosk) {
  deployablekiosk.var_98aabca05601aa67 = 1;
  deployablekiosk setscriptablepartstate("screen", "activated");
}

function function_ad1b6f540c35705d() {
  if(!isDefined(level.deployablekiosks.buystations)) {
    return;
  }

  foreach(deployablekiosk in level.deployablekiosks.buystations) {
    if(isDefined(deployablekiosk.var_98aabca05601aa67)) {
      deployablekiosk function_98913cb90ff3af87();
    }
  }
}

function function_313d9044d8e6f53c(deployablekiosk) {
  deployablekiosk.var_98aabca05601aa67 = 1;
  deployablekiosk setscriptablepartstate("screen", "activated");
  deployablekiosk setscriptablepartstate("drone_deployable_kiosk", "useable");
}

function function_98913cb90ff3af87() {
  deployablekiosk = self;
  deployablekiosk.var_98aabca05601aa67 = 0;
  deployablekiosk setscriptablepartstate("screen", "deactivated");
  deployablekiosk setscriptablepartstate("drone_deployable_kiosk", "unusable");

  foreach(p in level.players) {
    if(isDefined(p.br_kiosk) && isDefined(p.br_kiosk.entity) && p.br_kiosk.entity == deployablekiosk) {
      p scripts\mp\gametypes\br_armory_kiosk::_closepurchasemenuwithresponse(2);
    }
  }
}

function function_7440e01cdf6ad541() {
  player = self;
  var_961550ea13ebbf78 = 0;

  foreach(drone in level.deployablekiosks.drones) {
    if(!isDefined(drone)) {
      continue;
    }

    if(istrue(drone.fromevent)) {
      continue;
    }

    var_961550ea13ebbf78++;
  }

  if(var_961550ea13ebbf78 >= level.deployablekiosks.var_406bfeebff3aa082) {
    player playlocalsound("br_plunder_atm_cancel");
    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/AIRSPACE_CROWDED_DEPLOYABLE_KIOSK");
    return true;
  }

  return false;
}

function function_f5a81afeb40e65cd() {
  buystation = self;
  level endon("game_ended");

  if(isDefined(buystation.dronedeployablekiosk)) {
    if(!istrue(buystation.dronedeployablekiosk.var_1d3bf3b408da503f)) {
      buystation.dronedeployablekiosk thread function_aa19007a48fca6c0();
    }
  }

  playFX(getfx("deployable_kiosk_explosion"), buystation.origin, anglesToForward(buystation.angles), anglestoup(buystation.angles));
  self playSound("br_deployable_kiosk_explode");
  wait 1.4;
  buystation function_42349f0ab9120240();
  level.deployablekiosks.buystations = array_remove(level.deployablekiosks.buystations, buystation);
  buystation delete();
  level.deployablekiosks.buystations = array_removeundefined(level.deployablekiosks.buystations);
}

function function_aa19007a48fca6c0(eattacker) {
  drone = self;
  level endon("game_ended");
  level.deployablekiosks.drones = array_remove(level.deployablekiosks.drones, drone);
  level.deployablekiosks.drones = array_removeundefined(level.deployablekiosks.drones);

  if(!istrue(drone.var_1d3bf3b408da503f) && isDefined(drone.buystation)) {
    drone thread function_4132402c7ec5947c(eattacker);
  }

  if(isDefined(eattacker) && isDefined(drone.buystation) && isDefined(drone.buystation.owner)) {
    if(eattacker.team != drone.buystation.owner.team) {
      eattacker scripts\mp\utility\points::doscoreevent(#"hash_e87586ea44aa31d9");
    }
  }

  drone stopsounds();
  drone setscriptablepartstate("redeploy_drone_relocation_smoke_vfx", "enabled");
  drone physics_registerforcollisioncallback();
  drone thread namespace_2c2703f78fc59600::function_26aacbd66ab5c92();
  drone waittill("collision");
  drone function_1519cc09e0dbad0c();
  scripts\mp\weapons::function_1a33bd42949ccbda(drone);

  if(isDefined(drone)) {
    drone delete();
  }
}

function function_1519cc09e0dbad0c() {
  drone = self;
  nearbyplayers = scripts\mp\utility\player::getplayersinradius(drone.origin, level.deployablekiosks.explosionradius);

  foreach(player in nearbyplayers) {
    player dodamage(level.deployablekiosks.explosiondamage, drone.origin, player, player, "MOD_CRUSH");
  }

  vfx = spawnscriptable("scriptable_redeploy_drone_explosion", drone.origin);
  waitframe();
  vfx freescriptable();
}

function function_f0b074bef81e8c7b(eattacker) {
  drone = self;

  if(!isDefined(drone.owner)) {
    return;
  }

  eventparams = [];
  eventparams[eventparams.size] = "shots_taken";
  var_dfdcc313086c8290 = ter_op(isDefined(drone.var_dfdcc313086c8290), drone.var_dfdcc313086c8290, 0);
  eventparams[eventparams.size] = var_dfdcc313086c8290;
  eventparams[eventparams.size] = "shot_down";
  var_40b256cd5e9c4485 = ter_op(isDefined(eattacker), 1, 0);
  eventparams[eventparams.size] = var_40b256cd5e9c4485;
  eventparams[eventparams.size] = "shot_down_by_enemy";
  var_47d00efcfd046ccb = isDefined(eattacker);
  var_1e8ce7bafb66028c = ter_op(var_47d00efcfd046ccb && drone.owner.team != eattacker.team, 1, 0);
  eventparams[eventparams.size] = var_1e8ce7bafb66028c;
  eventparams[eventparams.size] = "percentage_distance_travelled";
  var_6303f40d469148e7 = distance2dsquared(drone.spawnorigin, drone.goalorigin);
  var_af992377583332fe = distance2dsquared(drone.spawnorigin, drone.origin);

  if(var_6303f40d469148e7 <= 0) {
    percentagedistancetravelled = 100;
  } else {
    percentagedistancetravelled = var_af992377583332fe / var_6303f40d469148e7 * 100;
  }

  eventparams[eventparams.size] = int(percentagedistancetravelled);
  eventparams[eventparams.size] = "weapon_shot_down";
  var_3565c47f3b387a0a = isDefined(eattacker) && isDefined(eattacker.currentweapon) && isDefined(eattacker.currentweapon.basename);
  weaponshotdown = "";

  if(var_3565c47f3b387a0a) {
    weaponshotdown = eattacker.currentweapon.basename;
  }

  eventparams[eventparams.size] = weaponshotdown;
  eventparams[eventparams.size] = "request_x";
  var_7db719e63a1f19e = ter_op(isDefined(drone.requestx), drone.requestx, -1);
  eventparams[eventparams.size] = var_7db719e63a1f19e;
  eventparams[eventparams.size] = "request_y";
  var_7db729e63a1f3d1 = ter_op(isDefined(drone.requesty), drone.requesty, -1);
  eventparams[eventparams.size] = var_7db729e63a1f3d1;
  eventparams[eventparams.size] = "request_z";
  var_7db6f9e63a1ed38 = ter_op(isDefined(drone.requestz), drone.requestz, -1);
  eventparams[eventparams.size] = var_7db6f9e63a1ed38;
  eventparams[eventparams.size] = "total_squad_cash";
  eventparams[eventparams.size] = drone.var_6c90750b2bde4f94;
  eventparams[eventparams.size] = "circle_index";
  circleindex = -1;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
    circleindex = level.br_circle.circleindex;
  }

  eventparams[eventparams.size] = circleindex;
  drone.owner dlog_recordplayerevent("dlog_event_br_deployable_kiosk", eventparams);
}

function function_4e70ba4ebdc8dbe9(owner, friendlyicon, enemyicon) {
  buystation = self;
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_state(objid, "active");
  objective_position(objid, buystation.origin);
  objective_sethideelevation(objid, 1);
  objective_setplayintro(objid, 0);
  objective_onentity(objid, buystation);
  objective_setzoffset(objid, 50);
  objective_setshowdistance(objid, 0);
  objective_setshowoncompass(objid, 0);
  function_865f9c5d005f9a08(objid, 0);
  function_4eb76f8d303679f4(objid, 1);
  scripts\mp\objidpoolmanager::update_objective_icon(objid, friendlyicon);
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 5);
  scripts\mp\objidpoolmanager::function_2946e9eb07acb3f1(objid, &"EQUIPMENT/DEPLOYABLE_KIOSK_MARKER");

  if(isDefined(owner)) {
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(objid, owner.team);
  } else {
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
  }

  function_865f9c5d005f9a08(objid, 0);
  objective_sethideelevation(objid, 1);
  buystation.allyobjid = objid;

  if(isDefined(owner)) {
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
    objective_state(objid, "active");
    objective_position(objid, buystation.origin);
    objective_sethideelevation(objid, 1);
    objective_setplayintro(objid, 0);
    objective_onentity(objid, buystation);
    objective_setzoffset(objid, 50);
    objective_setshowdistance(objid, 0);
    objective_setshowoncompass(objid, 0);
    function_865f9c5d005f9a08(objid, 0);
    scripts\mp\objidpoolmanager::update_objective_icon(objid, enemyicon);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 5);
    scripts\mp\objidpoolmanager::function_2946e9eb07acb3f1(objid, &"EQUIPMENT/DEPLOYABLE_KIOSK_MARKER");
    scripts\mp\objidpoolmanager::function_a28e8535e00d34f3(objid);
    scripts\mp\objidpoolmanager::objective_teammask_removefrommask(objid, owner.team);
    function_865f9c5d005f9a08(objid, 0);
    objective_sethideelevation(objid, 1);
    buystation.enemyobjid = objid;
  }
}

function function_42349f0ab9120240() {
  buystation = self;

  if(!isDefined(buystation)) {
    return;
  }

  if(isDefined(buystation.objid)) {
    objective_hidefromplayersinmask(buystation.objid);
    scripts\mp\objidpoolmanager::returnobjectiveid(buystation.objid);
    buystation.objid = undefined;
  }

  if(isDefined(buystation.allyobjid)) {
    objective_hidefromplayersinmask(buystation.allyobjid);
    scripts\mp\objidpoolmanager::returnobjectiveid(buystation.allyobjid);
    buystation.allyobjid = undefined;
  }

  if(isDefined(buystation.enemyobjid)) {
    objective_hidefromplayersinmask(buystation.enemyobjid);
    scripts\mp\objidpoolmanager::returnobjectiveid(buystation.enemyobjid);
    buystation.enemyobjid = undefined;
  }
}

function private function_4b8f0a33e19c0310() {
  buystation = self;

  if(!isDefined(buystation)) {
    return;
  }

  if(!isDefined(buystation.objid)) {
    return;
  }

  if(scripts\mp\gametypes\br_publicevents::ispubliceventoftypeactive(%"firesale")) {
    scripts\mp\objidpoolmanager::update_objective_setbackground(buystation.objid, 11);
    return;
  }

  scripts\mp\objidpoolmanager::update_objective_setbackground(buystation.objid, 5);
}

function private function_c9064aca910696fa() {
  buystation = self;
  level endon("game_ended");
  buystation endon("death");

  while(true) {
    level waittill_any_2("public_event_firesale_start", "public_event_firesale_end");
    buystation function_4b8f0a33e19c0310();
  }
}

function function_ff4bbeb786042d78(grenade) {
  player = self;
  player endon("disconnect");
  grenade endon("explode_end");
  grenade thread notifyafterframeend("death", "explode_end");
  player thread function_58d05fe18dd1c713(grenade);
  grenade waittill("explode", position);
  player notify("deployable_kiosk_drop_finished");
  thread function_1e270e9c7a27bb49(position);

  if(scripts\mp\outofbounds::ispointinoutofbounds(position) || player function_7440e01cdf6ad541()) {
    if(isDefined(grenade)) {
      grenade delete();
    }

    if(isDefined(player.super)) {
      player scripts\mp\supers::superusefinished(1);
    }

    return;
  }

  scripts\cp_mp\challenges::function_d997435895422ecc("equip_deployable_kiosk_drop_jup", scripts\common\ae_utility::function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  function_590979ef771686a8(player, position);

  if(isDefined(player.super)) {
    player scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
  }
}

function function_58d05fe18dd1c713(grenade) {
  player = self;
  player endon("disconnect");
  player endon("deployable_kiosk_drop_finished");
  grenade waittill("death");
  waitframe();

  if(isDefined(player.super)) {
    player scripts\mp\supers::superusefinished(1);
  }
}

function function_1e270e9c7a27bb49(position) {
  smoke_sfx = spawn("script_origin", position);
  smoke_sfx playLoopSound("smoke_carepackage_smoke_lp");
  wait 21;
  smoke_sfx playSound("smoke_canister_tail_dissipate");
  smoke_sfx stoploopsound("smoke_carepackage_smoke_lp");
  wait 5;
  smoke_sfx delete();
}