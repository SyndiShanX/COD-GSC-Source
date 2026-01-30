/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_host.gsc
*******************************************/

init() {
  level.agent_funcs["zombie_host"] = level.agent_funcs["zombie"];
  level.agent_funcs["zombie_host"]["think"] = level.agent_funcs["zombie_generic"]["think"];
  level.agent_funcs["zombie_host"]["spawn"] = ::spawn_zombie_host;
  var_0[0] = ["zom_host_fullbody"];
  level._effect["zombie_eye_host"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_host");
  level._effect["zombie_eye_host_exec"] = loadfx("vfx/gameplay/mp/zombie/executive_eyes_host");
  level._effect["zombie_eye_host_janitor"] = loadfx("vfx/gameplay/mp/zombie/janitor_eyes_host_");
  level._effect["zombie_eye_host_it"] = loadfx("vfx/gameplay/mp/zombie/lilith_eyes_host");
  level._effect["zombie_eye_host_security"] = loadfx("vfx/gameplay/mp/zombie/securityguard_eyes_host");
  level._effect["zombie_host_hand"] = loadfx("vfx/gameplay/mp/zombie/zombie_host_hand");
  var_1 = spawnStruct();
  var_1.agent_type = "zombie_host";
  var_1.animclass = "zombie_animclass";
  var_1.model_bodies = var_0;
  var_1.health_scale = 1.0;
  var_1.meleedamage = 250;
  var_1.healthoverridefunc = ::calculatehosthealth;
  maps\mp\zombies\_util::agentclassregister(var_1, "zombie_host");
  level.getspawntypefunc["zombie_host"] = ::gethostroundspawntype;
  level.candroppickupsfunc["zombie_host"] = ::hostroundcandroppickups;
  level.roundstartfunc["zombie_host"] = ::hostroundstart;
  level.roundendfunc["zombie_host"] = ::hostroundend;
  level.numenemiesthisroundfunc["zombie_host"] = ::hostroundnumenemies;
  level.roundspawndelayfunc["zombie_host"] = ::hostroundspawndelay;
  level.nummaxenemiesthisroundfunc["zombie_host"] = ::hostroundmaxnumenemies;
  level.mutatorfunc["zombie_host"] = ::hostmutator;
  level.movemodefunc["zombie_host"] = ::hostcaculatemovemode;
  level.moveratescalefunc["zombie_host"] = ::hostcaculatemoveratescale;
  level.nonmoveratescalefunc["zombie_host"] = ::hostcalculatenonmoveratescale;
  level.traverseratescalefunc["zombie_host"] = ::hostcalculatetraverseratescale;
}

spawn_zombie_host(var_0, var_1, var_2) {
  self[[level.agent_funcs["zombie"]["spawn"]]](var_0, var_1, var_2);
  self.boostfxtag = "no_boost_fx";
  maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_traverse();
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("zombie_host_hand"), self, "j_wrist_ri");
}

calculatehosthealth() {
  var_0 = 400;

  switch (level.specialroundcounter) {
    case 1:
    case 0:
      var_0 = 400;
      break;
    case 2:
      var_0 = 750;
      break;
    case 3:
      var_0 = 1200;
      break;
    default:
      var_0 = 1500;
  }

  return var_0;
}

hostroundstart() {
  thread hostroundalarm();
}

hostcaculatemovemode() {
  return "sprint";
}

hostcaculatemoveratescale() {
  return 0.9 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

hostcalculatenonmoveratescale() {
  return 1.0 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

hostcalculatetraverseratescale() {
  return 1.55 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

hostroundalarm() {
  var_0 = spawn("script_origin", (0, 0, 0));

  for(var_1 = 0; var_1 < 3; var_1++) {
    var_0 playSound("zmb_hst_round_start_alarm");
    wait 1.1;
  }

  var_0 delete();
}

hostroundend() {
  maps\mp\gametypes\zombies::createpickuporgive("ammo", level.lastenemydeathpos, "Host Round End");
}

gethostroundspawntype(var_0, var_1) {
  var_2 = "zombie_host";

  if(!zombiehostcanspawn()) {
    var_2 = "zombie_generic";
  }

  if(var_0 && common_scripts\utility::mod(var_0, 5) == 0) {
    var_2 = "zombie_generic";
  }

  return var_2;
}

hostroundcandroppickups(var_0) {
  return 0;
}

zombiehostcanspawn() {
  if(!maps\mp\zombies\_terminals::getiteminmap("host_cure")) {
    return 0;
  }

  return 1;
}

hostroundnumenemies(var_0) {
  return min(52, var_0);
}

hostroundmaxnumenemies(var_0) {
  return var_0 - 4;
}

hostroundspawndelay(var_0, var_1) {
  var_2 = 1.5;

  switch (level.specialroundcounter) {
    case 1:
    case 0:
      var_2 = 3;
      break;
    case 2:
      var_2 = 2.5;
      break;
    case 3:
      var_2 = 2;
      break;
    default:
      var_2 = 1.5;
  }

  var_2 = var_2 - var_0 / var_1;
  return var_2;
}

hostmutator(var_0) {}