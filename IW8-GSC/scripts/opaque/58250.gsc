/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58250.gsc
***********************************************/

function activate_minigun() {}

function init() {
  if(getdvarint("scr_chemical_factory_trap_active", 0) == 1) {
    level._effects["vfx_chem_factory_trap"] = loadfx("vfx/iw8_br/equipment/vfx_factory_trap_ground_gas");
    thread table_getaddblueprintattachments();
    return;
  }
}

function table_getaddblueprintattachments() {
  level endon("game_ended");
  waitframe();
  scripts\engine\scriptable::ref_12f5b("chemlab_button", &plunder_repositorysendcountdownmessage);
  var_0 = easepower("scriptable_chemlab_trap_button", (3459.75, 37679, 1193.75), (75, 223.998, 179.999));
  var_0 setscriptablepartstate("chemlab_button", "on");
  level.getteamspawnbots = spawnStruct();
  level.getteamspawnbots.plunderatcapacity = getdvarint("chemlab_event_gastrap_trigger_width", 750);
  level.getteamspawnbots.plunder_updaterepositorywidgetforplayer = getdvarint("chemlab_event_gastrap_trigger_length", 750);
  level.getteamspawnbots.plunder_updateanchoredwidgetforplayers = getdvarint("chemlab_event_gastrap_trigger_height", 240);
  level.getteamspawnbots.plunder_tenpercent_music = getdvarint("chemlab_event_gastrap_trigger_durration", 30);
  level.getteamspawnbots.plunder_thirtypercent_music = getdvarint("chemlab_event_gastrap_damage_per_tick", 8);
  level.getteamspawnbots.plunder_repositoryusecallback = getdvarint("chemlab_event_gastrap_tick_rate", 1);
  level.getteamspawnbots.plunder_items_dropped = getdvarint("chemlab_event_gastrap_fill_amount", 100);
  level.getteamspawnbots.plunder_items_picked_up = getdvarint("chemlab_event_gastrap_fill_rate", 1);
  level.getteamspawnbots.plunder_repositoryusescriptablecallback = getdvarint("chemlab_event_gastrap_cooldown", 10);
  level.getteamspawnbots.plunder_deregisterrepositoryinstance = [];
  level.getteamspawnbots.plundercountroll = plunderusable();
  level.getteamspawnbots.ref_11a70 = plunderusedisabledwhenempty();
}

function plunderusable() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, (2987, 37243, 600));
}

function plunderusedisabledwhenempty() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, (2808, 36760, 672));
}

function activate_laser_from_struct() {}

function plunder_repositorysendcountdownmessage(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 != "off") {
    thread ref_13cf3(level);
    var_0 setscriptablepartstate(var_1, "off");
    plunder_repositoryinstanceisregistered(var_0, var_1);
    return;
  }
}

function plunder_repositoryinstanceisregistered(var_0, var_1) {
  foreach(var_3 in level.getteamspawnbots.plundercountroll) {
    var_4 = getEnt("main_lab_storage_room", "targetname");
    var_5 = plunder_repositoryplayerplundereventcallback(var_4);
    thread plunder_extraction_site_active();
    thread ref_12a3d(var_5, var_0);
  }
}

function ref_12a3d(var_0, var_1) {
  level endon("game_ended");
  self waittill("disperse");
  wait level.getteamspawnbots.plunder_repositoryusescriptablecallback;
  var_0 setscriptablepartstate(var_1, "on");
}

function ref_13cf3(var_0) {
  level endon("game_ended");
  playsoundatpos(var_0, "scr_br_infil_ac130_klaxon");
  wait 1;
  playsoundatpos(var_0, "scr_br_infil_ac130_klaxon");
  wait 1;
  playsoundatpos(var_0, "scr_br_infil_ac130_klaxon");
  wait 1;
}

function plunder_repositoryplayerplundereventcallback(var_0) {
  var_1 = var_0;

  if(!isDefined(var_1)) {
    var_1 = spawn("trigger_radius", level.getteamspawnbots.plundercountroll[0], 0, level.getteamspawnbots.plunderatcapacity, level.getteamspawnbots.plunder_updateanchoredwidgetforplayers);
  }

  var_1.location = "main_lab";
  scripts\mp\utility\trigger::makeenterexittrigger(var_1, &plunder_repositoryatcapacity, &plunder_repositoryclearcountdown, undefined, undefined, &plunder_ninetypercent_music);
  thread plunder_playerrepositoryuseshouldsucceed(var_1);
  level.getteamspawnbots.plundervar[var_1.location] = var_1;
  var_1.intel_loc = 100;
  var_1.active = 0;
  return var_1;
}

function plunder_infils_ready() {
  level endon("game_ended");
  self endon("disperse");
  var_0 = 100;

  for(;;) {
    if(var_0 < self.intel_loc) {
      var_0 += 50;
    }

    wait 0.1;
  }
}

function plunder_playerrepositoryuseshouldsucceed(var_0) {
  level endon("game_ended");

  switch (var_0) {
    case "main_lab":
      thread setup_comms_obj();
      break;
    case "default":
      break;
  }
}

function setup_comms_obj() {
  level endon("game_ended");
  var_0 = [];

  foreach(var_2 in level.getteamspawnbots.ref_11a70) {
    var_3 = easepower("vfx_chem_lab_trap_cloud", var_2, (0, 0, 0));
    var_0 = var_3;
    var_3 setscriptablepartstate("chem_lab_trap_cloud_vfx", "visible");
    var_3 setscriptablepartstate("chem_lab_trap_cloud_sfx", "on");
    waitframe();
  }

  self.active = 1;
  self waittill("disperse");

  foreach(var_6 in self.triggerenterents) {
    var_6 scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_factory_gas");
  }

  foreach(var_9 in var_0) {
    var_9 setscriptablepartstate("chem_lab_trap_cloud_vfx", "hidden");
    thread ref_11a6f();
  }
}

function ref_11a6f() {
  level endon("game_ended");
  wait 5.7;
  self freescriptable();
}

function plunder_repositoryatcapacity(var_0, var_1) {
  thread plunder_repositoryendcountdown(var_0);
}

function plunder_repositoryclearcountdown(var_0, var_1) {
  var_0 notify("out_of_poison_cloud");
  var_0 scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_factory_gas");
}

function plunder_ninetypercent_music(var_0, var_1) {
  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return true;
  }

  return false;
}

function plunder_extraction_site_active() {
  level endon("game_ended");

  for(;;) {
    wait level.getteamspawnbots.plunder_items_picked_up;

    if(self.intel_loc >= level.getteamspawnbots.plunderatcapacity) {
      break;
    }

    self.intel_loc += level.getteamspawnbots.plunder_items_dropped;
  }

  wait level.getteamspawnbots.plunder_tenpercent_music;
  self notify("disperse");
  self.active = 0;
}

function plunder_repositoryendcountdown(var_0) {
  level endon("game_ended");
  self endon("out_of_poison_cloud");
  self endon("death");

  for(;;) {
    wait level.getteamspawnbots.plunder_repositoryusecallback;

    if(istrue(self.start_death_from_above_sequence)) {
      continue;
    }

    if(istrue(var_0.active)) {
      if(scripts\cp_mp\gasmask::hasgasmask(self)) {
        scripts\mp\gametypes\br_pickups::plunderrepositoryref("chem_factory_gas");
        scripts\cp_mp\gasmask::processdamage(level.getteamspawnbots.plunder_thirtypercent_music);
        continue;
      }

      scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_factory_gas");

      if(scripts\mp\gametypes\br_public::hasarmor()) {
        scripts\mp\gametypes\br_public::damagearmor(level.getserverroomspawnpoint.plunder_getleveldataforrepository);
      } else {
        self dodamage(level.getteamspawnbots.plunder_thirtypercent_music, var_0.origin, var_0, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }

      scripts\mp\gametypes\br_circle::ref_13e18();
    }
  }
}