/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_mapselect.gsc
***********************************************/

function init() {
  level._effect["map_target_mark"] = loadfx("vfx/iw8_cp/vfx_marker_map_target.vfx");
}

function tablet_enabled_check_dvar() {
  if(getdvarint("scr_tablet_disabled", 0) == 0) {
    return false;
  }

  return false;
}

function getselectmappoint(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 0;

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  thread watchownertimeoutdeath();
  var_3 = undefined;
  var_3 = gathermappointinfo(var_1, var_2);
  return var_3;
}

function gathermappointinfo(var_0, var_1) {
  var_2 = 1;

  if(var_0 <= 1) {
    self setclientomnvar("ui_map_select_uses", -1);
    var_2 = 0;
  }

  self.mapselectpickcounter = 0;
  self.previousmapselectioninfo = undefined;
  var_3 = [];
  thread watchmapselectweapon();
  jumpiffalse(istrue(var_2)) LOC_0000004d;
  self setclientomnvar("ui_map_select_uses", var_0);
  self setclientomnvar("ui_map_select_count", var_0);

  while(self.mapselectpickcounter < var_0) {
    var_4 = waittill_confirm_or_cancel("confirm_location", "cancel_location");

    if(!isDefined(var_4) || var_4.string == "cancel_location") {
      var_3 = undefined;
      break;
    }

    var_3 = var_4;
    self.mapselectpickcounter++;

    if(istrue(var_2)) {
      self setclientomnvar("ui_map_select_uses", var_0 - self.mapselectpickcounter);
    }
  }

  self setclientomnvar("ui_map_select_count", -1);
  self notify("map_select_exit");
  level notify("vision_set_change_request", "", self, 0);

  if(isDefined(var_3)) {
    self.pers["startedMapSelect"] = 0;
  }

  return var_3;
}

function watchmapselectweapon() {
  self endon("map_select_exit");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(var_0.basename != "ks_remote_map_cp") {
      self notify("cancel_location");
      break;
    }

    waitframe();
  }
}

function watchmapselectexit() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("map_select_exit");
  stopmapselectsequence();
}

function watchownertimeoutdeath() {
  self endon("disconnect");
  self endon("map_select_exit");
  level endon("game_ended");
  self setclientomnvar("ui_location_selection_countdown", gettime() + 30000);
  scripts\engine\utility::ref_143b9(30, "death");
  self notify("cancel_location");
}

function startmapselectsequence(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self beginlocationselection(var_0, var_1, var_2, 1, var_3);
}

function stopmapselectsequence() {
  self endlocationselection();
  self.mapselectpickcounter = undefined;
  self.previousmapselectioninfo = undefined;

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self notify("killstreak_finished_with_deploy_weapon");
    return;
  }
}

function waittill_confirm_or_cancel(var_0, var_1, var_2) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death")) {
    self endon("death");
  }

  var_3 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_3);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_3);
  }

  jumpiffalse(isDefined(var_2)) LOC_00000058;
  GscBinSkip4(0x35, var_2, var_3);

  var_3 waittill("returned", var_4, var_5, var_6);
  var_3 notify("die");
  var_7 = spawnStruct();
  var_7.location = var_4;
  var_7.angles = var_5;
  var_7.string = var_6;
  return var_7;
}

function waittill_return(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("die");
  self waittill(var_0, var_2, var_3);
  var_1 notify("returned", var_2, var_3, var_0);
}

function setmaplocationselection() {}

function set_uav_radarstrength(var_0) {
  var_1 = getuavstrengthmax();
  var_0.radarstrength = var_1;
}