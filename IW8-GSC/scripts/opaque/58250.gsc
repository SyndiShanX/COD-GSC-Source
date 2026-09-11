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
  var0 = easepower("scriptable_chemlab_trap_button", (3459.75, 37679, 1193.75), (75, 223.998, 179.999));
  var0 setscriptablepartstate("chemlab_button", "on");
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
  var0 = [];
  GscBinSkip0(0x2e, var0.size, (2987, 37243, 600));
}

function plunderusedisabledwhenempty() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, (2808, 36760, 672));
}

function activate_laser_from_struct() {}

function plunder_repositorysendcountdownmessage(var0, var1, var2, var3, var4) {
  if(var2 != "off") {
    thread ref_13cf3(level);
    var0 setscriptablepartstate(var1, "off");
    plunder_repositoryinstanceisregistered(var0, var1);
    return;
  }
}

function plunder_repositoryinstanceisregistered(var0, var1) {
  foreach(var3 in level.getteamspawnbots.plundercountroll) {
    var4 = getEnt("main_lab_storage_room", "targetname");
    var5 = plunder_repositoryplayerplundereventcallback(var4);
    thread plunder_extraction_site_active();
    thread ref_12a3d(var5, var0);
  }
}

function ref_12a3d(var0, var1) {
  level endon("game_ended");
  self waittill("disperse");
  wait level.getteamspawnbots.plunder_repositoryusescriptablecallback;
  var0 setscriptablepartstate(var1, "on");
}

function ref_13cf3(var0) {
  level endon("game_ended");
  playsoundatpos(var0, "scr_br_infil_ac130_klaxon");
  wait 1;
  playsoundatpos(var0, "scr_br_infil_ac130_klaxon");
  wait 1;
  playsoundatpos(var0, "scr_br_infil_ac130_klaxon");
  wait 1;
}

function plunder_repositoryplayerplundereventcallback(var0) {
  var1 = var0;

  if(!isDefined(var1)) {
    var1 = spawn("trigger_radius", level.getteamspawnbots.plundercountroll[0], 0, level.getteamspawnbots.plunderatcapacity, level.getteamspawnbots.plunder_updateanchoredwidgetforplayers);
  }

  var1.location = "main_lab";
  scripts\mp\utility\trigger::makeenterexittrigger(var1, &plunder_repositoryatcapacity, &plunder_repositoryclearcountdown, undefined, undefined, &plunder_ninetypercent_music);
  thread plunder_playerrepositoryuseshouldsucceed(var1);
  level.getteamspawnbots.plundervar[var1.location] = var1;
  var1.intel_loc = 100;
  var1.active = 0;
  return var1;
}

function plunder_infils_ready() {
  level endon("game_ended");
  self endon("disperse");
  var0 = 100;

  for(;;) {
    if(var0 < self.intel_loc) {
      var0 += 50;
    }

    wait 0.1;
  }
}

function plunder_playerrepositoryuseshouldsucceed(var0) {
  level endon("game_ended");

  switch (var0) {
    case "main_lab":
      thread setup_comms_obj();
      break;
    case "default":
      break;
  }
}

function setup_comms_obj() {
  level endon("game_ended");
  var0 = [];

  foreach(var2 in level.getteamspawnbots.ref_11a70) {
    var3 = easepower("vfx_chem_lab_trap_cloud", var2, (0, 0, 0));
    var0 = var3;
    var3 setscriptablepartstate("chem_lab_trap_cloud_vfx", "visible");
    var3 setscriptablepartstate("chem_lab_trap_cloud_sfx", "on");
    waitframe();
  }

  self.active = 1;
  self waittill("disperse");

  foreach(var6 in self.triggerenterents) {
    var6 scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_factory_gas");
  }

  foreach(var9 in var0) {
    var9 setscriptablepartstate("chem_lab_trap_cloud_vfx", "hidden");
    thread ref_11a6f();
  }
}

function ref_11a6f() {
  level endon("game_ended");
  wait 5.7;
  self freescriptable();
}

function plunder_repositoryatcapacity(var0, var1) {
  thread plunder_repositoryendcountdown(var0);
}

function plunder_repositoryclearcountdown(var0, var1) {
  var0 notify("out_of_poison_cloud");
  var0 scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_factory_gas");
}

function plunder_ninetypercent_music(var0, var1) {
  if(!isDefined(var0) || !isPlayer(var0)) {
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

function plunder_repositoryendcountdown(var0) {
  level endon("game_ended");
  self endon("out_of_poison_cloud");
  self endon("death");

  for(;;) {
    wait level.getteamspawnbots.plunder_repositoryusecallback;

    if(istrue(self.start_death_from_above_sequence)) {
      continue;
    }

    if(istrue(var0.active)) {
      if(scripts\cp_mp\gasmask::hasgasmask(self)) {
        scripts\mp\gametypes\br_pickups::plunderrepositoryref("chem_factory_gas");
        scripts\cp_mp\gasmask::processdamage(level.getteamspawnbots.plunder_thirtypercent_music);
        continue;
      }

      scripts\mp\gametypes\br_pickups::plunderrankupdate("chem_factory_gas");

      if(scripts\mp\gametypes\br_public::hasarmor()) {
        scripts\mp\gametypes\br_public::damagearmor(level.getserverroomspawnpoint.plunder_getleveldataforrepository);
      } else {
        self dodamage(level.getteamspawnbots.plunder_thirtypercent_music, var0.origin, var0, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }

      scripts\mp\gametypes\br_circle::ref_13e18();
    }
  }
}