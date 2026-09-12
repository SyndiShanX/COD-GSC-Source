/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_comms_tower.gsc
***************************************************/

function init() {
  level endon("game_ended");
  level._effect["vfx_esc4_tower_button"] = loadfx("vfx/iw8_br/mp_escape4/vfx_esc4_tower_button.vfx");
  level._effect["vfx_esc4_tower_red_blink_light"] = loadfx("vfx/iw8_br/mp_escape4/vfx_esc4_infil_container_smk.vfx");
  game["dialog"]["comm_tower_activated_nearby"] = "public_events_comm_tower_brdcst";
  game["dialog"]["comm_tower_activated_team"] = "public_events_comm_tower_sweep";
  waitframe();
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  thread initcommstowers();
}

function initcommstowers() {
  if(getdvarint("scr_br_comms_tower_enabled", 1) == 0) {
    return;
  }

  scripts\mp\gametypes\br_plunder::registerpostplundercallback(&towerpostplunder);
  level.commstowersinfo = spawnStruct();
  level.commstowersinfo.commstowers = [];
  level.commstowersinfo.ref_13671 = gettowersspawnlocation();
  level.commstowersinfo.commstowersprice = getdvarint("scr_br_comms_tower_price", 1500);
  level.commstowersinfo.usecooldown = getdvarint("scr_br_comms_tower_cd", 45);
  level.commstowersinfo.scanradius = getdvarint("scr_br_comms_tower_radius", 2500);
  level.commstowersinfo.scansweeptime = getdvarint("scr_br_comms_tower_sweeptime", 3000);
  spawntowers();
  thread watchfiresaleevent();
  thread disabletowersingas();
}

function playdialog(var_0) {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("comm_tower_activated_team", var_0.team, 1);
  var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 1);
  var_2 = scripts\mp\utility\player::getplayersinradius(var_0.origin, 2500, undefined, var_1);

  if(var_2.size > 0) {
    level thread scripts\mp\gametypes\br_public::brleaderdialog("comm_tower_activated_nearby", 1, var_2);
    return;
  }
}

function gettowersspawnlocation() {
  var_0 = [];

  switch (getDvar("mapname")) {
    case "mp_wz_island":
      break;
    case "mp_sm_island_1":
      GscBinSkip0(0x2e, var_0.size, [(3280, -4426.5, 1258), (3271, -4392, 1251), (0, 285, 0)]);

    case "mp_br_mechanics":
      GscBinSkip0(0x2e, var_0.size, [(2048, -2649, 50.25), (2048, -2688, 0), (0, 0, 0)]);

    case "mp_escape4_s5":
    case "mp_escape4":
      GscBinSkip0(0x2e, var_0.size, [(-2924.25, -10759, 584.75), (-2952.25, -10732, 533.75), (0, 45, 0)]);
  }

  return var_0;
}

function spawntowers() {
  var_0 = 0;

  foreach(var_2 in level.commstowersinfo.ref_13671) {
    var_3 = spawn("script_model", var_2[0]);
    var_3 setModel("tag_origin");
    var_4 = easepower("comms_tower_ee", var_2[0]);
    var_5 = spawn("script_model", var_2[1]);
    var_5.angles = var_2[2];
    var_5 setModel("comms_tower_indicator");
    var_3.useprompt = scripts\mp\gameobjects::createhintobject(var_3.origin, "HINT_BUTTON", undefined, &"WZ_MP_ESCAPE_TU_WZ325/PURCHASE_COMMS_TOWER_ENABLED", undefined, undefined, undefined, 0, 0, 65, 90);
    var_3.useprompt.inuse = scripts\mp\gameobjects::createhintobject(var_3.origin, "HINT_BUTTON", undefined, &"WZ_MP_ESCAPE_TU_WZ325/PURCHASE_COMMS_TOWER_DISABLED", undefined, undefined, undefined, 0, 0, 65, 90);
    var_3.useprompt.inuse = 0;
    level.commstowersinfo.commstowers[level.commstowersinfo.commstowers.size] = var_3.useprompt;
    var_3.id = var_0;
    var_0++;
    var_3.useprompt sethintstringparams(level.commstowersinfo.commstowersprice);
    var_3.useprompt.inuse sethintstringparams(level.commstowersinfo.commstowersprice);
    thread managetowerpromptinteraction(var_3, var_3.useprompt, var_4);
    thread manageredpromptinteraction(var_3);
  }

  foreach(var_8 in level.players) {
    thread ref_126E0();
  }
}

function managetowerpromptinteraction(var_0, var_1, var_2) {
  level endon("game_ended");
  waitframe();
  var_1 setscriptablepartstate("light", "button_on");
  var_2 setscriptablepartstate("light", "indicator_off");
  var_3 = 15;

  for(;;) {
    var_0 waittill("trigger", var_4);

    if(ref_1392A(var_0, var_4)) {
      thread doscan(var_4);
      thread playdialog(level);
      commstowersanalytics(var_4, self.id);
      var_4 thread scripts\mp\utility\points::giveunifiedpoints("br_comm_tower_activated");
      var_0.inuse = 1;
      disabletowerpromptuse(var_0);

      if(!scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think(2)) {
        var_5 = int(level.commstowersinfo.commstowersprice / 100);
        var_4 scripts\mp\gametypes\br_plunder::playersetplundercount(var_4.plundercount - var_5);
      }

      var_1 setscriptablepartstate("light", "button_off");
      var_2 setscriptablepartstate("light", "indicator_on");
      wait var_3;
      var_2 setscriptablepartstate("light", "indicator_off");
      wait level.commstowersinfo.usecooldown;
      var_1 setscriptablepartstate("light", "button_on");
      var_0.inuse = 0;
      enabletowerpromptuse(var_0);
    }
  }
}

function manageredpromptinteraction(var_0) {
  level endon("game_ended");

  for(;;) {
    var_0 waittill("trigger", var_1);
    self playsoundtoplayer("ui_screen_edge_deny", var_1);
  }
}

function doscan(var_0) {
  for(var_1 = 0; var_1 < 5; var_1++) {
    triggerportableradarpingteam(self.origin, var_0.team, level.commstowersinfo.scanradius, level.commstowersinfo.scansweeptime);
    wait 3;
  }
}

function towerpostplunder(var_0) {
  if(!scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think(2)) {
    if(playerplunderupdate(var_0)) {
      thread ref_126E0();
      return;
    }

    return;
  }
}

function playerplunderupdate(var_0) {
  var_1 = int(level.commstowersinfo.commstowersprice / 100);

  if(!isDefined(var_0) || !isDefined(var_0.player)) {
    return 1;
  }

  if(var_0.player.plundercount >= var_1 && var_0.player.plundercount - var_0.ref_127B4 >= var_1) {
    return 0;
  }

  if(var_0.player.plundercount < var_1 && var_0.player.plundercount - var_0.ref_127B4 < var_1) {
    return 0;
  }

  return 1;
}

function ref_126E0() {
  foreach(var_1 in level.commstowersinfo.commstowers) {
    ref_126DF(var_1);
  }
}

function playersupdatestructures() {
  foreach(var_1 in level.players) {
    thread ref_126E0();
  }
}

function disabletowerpromptuse(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_0 disableplayeruse(var_2);
      var_0.inuse disableplayeruse(var_2);
    }
  }
}

function enabletowerpromptuse(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      ref_126DF(var_2, var_0);
    }
  }
}

function ref_126DF(var_0) {
  if(var_0.inuse) {
    return;
  }

  if(istrue(self.iszombie)) {
    var_0 disableplayeruse(self);
    var_0.inuse disableplayeruse(self);
    return;
  }

  var_1 = int(level.commstowersinfo.commstowersprice / 100);

  if(isDefined(self.plundercount) && self.plundercount >= var_1 || scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think(2)) {
    var_0 enableplayeruse(self);
    var_0.inuse disableplayeruse(self);
    return;
  }

  if(!isDefined(self.plundercount) || self.plundercount < var_1) {
    var_0 disableplayeruse(self);
    var_0.inuse enableplayeruse(self);
    return;
  }
}

function ref_1392A(var_0) {
  if(scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think(2)) {
    return true;
  }

  var_1 = int(level.commstowersinfo.commstowersprice / 100);

  if(var_0.plundercount < var_1) {
    return false;
  }

  return true;
}

function watchfiresaleevent() {
  for(;;) {
    level waittill("public_event_firesale_start");

    foreach(var_1 in level.commstowersinfo.commstowers) {
      var_1 sethintstringparams(0);
    }

    thread playersupdatestructures();
    level waittill("public_event_firesale_end");

    foreach(var_1 in level.commstowersinfo.commstowers) {
      var_1 sethintstringparams(level.commstowersinfo.commstowersprice);
    }

    thread playersupdatestructures();
  }
}

function disabletowersingas() {
  for(;;) {
    level waittill("br_circle_set", var_0);

    foreach(var_2 in level.commstowersinfo.commstowers) {
      if(!scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_2.origin)) {
        var_2 istacmapactive();
        var_2.inuse istacmapactive();
        level.commstowersinfo.commstowers = scripts\engine\utility::array_remove(level.commstowersinfo.commstowers, var_2);
      }
    }
  }
}

function commstowersanalytics(var_0) {
  var_1 = self;

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = [];
  var_3 = var_0;
  var_2 = "comms_towers_id";
  var_2 = var_3;

  if(isDefined(level.br_circle)) {
    var_4 = scripts\mp\gametypes\br_quest_util::relic_mythic_modifyplayerdamage();
    var_2 = "comms_towers_circle_index";
    var_2 = var_4;
  }

  var_5 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_2 = "time_msfrommatchstart";
  var_2 = var_5;
  var_1 dlog_recordplayerevent("dlog_event_comms_towers", var_2);
}