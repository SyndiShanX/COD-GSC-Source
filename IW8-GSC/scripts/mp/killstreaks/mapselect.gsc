/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\mapselect.gsc
************************************************/

function init() {}

function getmapselectweapon() {
  return "ks_remote_map_mp";
}

function getselectmappoint(var0, var1, var2) {
  if(!isDefined(var0)) {
    return;
  }

  var3 = 0;

  if(scripts\mp\utility\killstreak::isnavmeshkillstreak(var0.streakname)) {
    var3 = 1;
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  scripts\common\utility::allow_offhand_weapons(0);
  thread watchmapselectexit(var0);
  thread ref_144e5();
  thread watchownertimeoutdeath();
  var4 = undefined;
  scripts\cp_mp\utility\killstreak_utility::starttabletscreen(var0.streakname, 0.05);
  var4 = gathermappointinfo(var1, var2);
  scripts\cp_mp\utility\killstreak_utility::stoptabletscreen(0.75);
  return var4;
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

    var5 = var4.location + (0, 0, 10000);
    var6 = var4.location - (0, 0, 10000);
    var7 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstancesforall();
    var8 = level.activekillstreaks;
    var9 = scripts\engine\utility::array_combine(var7, var8);
    var10 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0, 0, 0, 0);
    var11 = scripts\engine\trace::ray_trace(var5, var6, var9, var10, 0, 1);
    var4.location = var11["position"];
    var3 = var4;
    self.mapselectpickcounter++;

    if(istrue(var2)) {
      self setclientomnvar("ui_map_select_uses", var0 - self.mapselectpickcounter);
    }
  }

  self setclientomnvar("ui_map_select_count", -1);
  self notify("map_select_exit");

  if(isDefined(var3)) {
    self.pers["startedMapSelect"] = 0;
  }

  return var3;
}

function watchmapselectweapon() {
  self endon("map_select_exit");

  for(;;) {
    var0 = self getcurrentweapon();

    if(var0.basename != "ks_remote_map_mp") {
      self notify("cancel_location");
      break;
    }

    waitframe();
  }
}

function watchmapselectexit(var0) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("map_select_exit");
  stopmapselectsequence(var0);
}

function ref_144e5() {
  self endon("disconnect");
  self endon("map_select_exit");
  level endon("game_ended");

  for(;;) {
    if(scripts\cp_mp\emp_debuff::is_empd()) {
      self notify("cancel_location");
      break;
    }

    waitframe();
  }
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
  if(!self.pers["startedMapSelect"]) {
    triggeroneoffradarsweep(self);
    self.pers["startedMapSelect"] = 1;
  }

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

function stopmapselectsequence(var0) {
  self.mapselectpickcounter = undefined;
  self.mapselectdircounter = undefined;
  self.previousmapselectioninfo = undefined;

  if(scripts\mp\utility\player::isreallyalive(self)) {
    scripts\common\utility::allow_offhand_weapons(1);
    var0 notify("killstreak_finished_with_deploy_weapon");
  } else {
    self.pers["startedMapSelect"] = 0;
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);

  if(isDefined(self)) {
    self endlocationselection();
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