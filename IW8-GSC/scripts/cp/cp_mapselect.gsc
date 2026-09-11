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

function getselectmappoint(var0, var1, var2) {
  var3 = [];
  var4 = 0;

  if(!isDefined(var1)) {
    var1 = 1;
  }

  thread watchownertimeoutdeath();
  var3 = undefined;
  var3 = gathermappointinfo(var1, var2);
  return var3;
}

function gathermappointinfo(var0, var1) {
  var2 = 1;

  if(var0 <= 1) {
    self setclientomnvar("ui_map_select_uses", -1);
    var2 = 0;
  }

  self.mapselectpickcounter = 0;
  self.previousmapselectioninfo = undefined;
  var3 = [];
  thread watchmapselectweapon();
  jumpiffalse(istrue(var2)) LOC_0000004d;
  self setclientomnvar("ui_map_select_uses", var0);
  self setclientomnvar("ui_map_select_count", var0);

  while(self.mapselectpickcounter < var0) {
    var4 = waittill_confirm_or_cancel("confirm_location", "cancel_location");

    if(!isDefined(var4) || var4.string == "cancel_location") {
      var3 = undefined;
      break;
    }

    var3 = var4;
    self.mapselectpickcounter++;

    if(istrue(var2)) {
      self setclientomnvar("ui_map_select_uses", var0 - self.mapselectpickcounter);
    }
  }

  self setclientomnvar("ui_map_select_count", -1);
  self notify("map_select_exit");
  level notify("vision_set_change_request", "", self, 0);

  if(isDefined(var3)) {
    self.pers["startedMapSelect"] = 0;
  }

  return var3;
}

function watchmapselectweapon() {
  self endon("map_select_exit");

  for(;;) {
    var0 = self getcurrentweapon();

    if(var0.basename != "ks_remote_map_cp") {
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

function startmapselectsequence(var0, var1, var2, var3) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  self beginlocationselection(var0, var1, var2, 1, var3);
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

function waittill_confirm_or_cancel(var0, var1, var2) {
  if((!isDefined(var0) || var0 != "death") && (!isDefined(var1) || var1 != "death")) {
    self endon("death");
  }

  var3 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var3);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var3);
  }

  jumpiffalse(isDefined(var2)) LOC_00000058;
  GscBinSkip4(0x35, var2, var3);

  var3 waittill("returned", var4, var5, var6);
  var3 notify("die");
  var7 = spawnStruct();
  var7.location = var4;
  var7.angles = var5;
  var7.string = var6;
  return var7;
}

function waittill_return(var0, var1) {
  if(var0 != "death") {
    self endon("death");
  }

  var1 endon("die");
  self waittill(var0, var2, var3);
  var1 notify("returned", var2, var3, var0);
}

function setmaplocationselection() {}

function set_uav_radarstrength(var0) {
  var1 = getuavstrengthmax();
  var0.radarstrength = var1;
}