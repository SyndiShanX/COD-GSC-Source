/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_mapselect.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\utility;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_mapselect;

function init() {
  level._effect["map_target_mark"] = loadfx("vfx/iw8_cp/vfx_marker_map_target.vfx");
  function_8bb8ac075d5a87dc();
}

function function_8bb8ac075d5a87dc() {
  val::group_register("map_select", ["usability", "killstreaks", "supers", "gesture", "fire", "weapon_switch", "allow_movement", "offhand_weapons", "crouch", "prone", "allow_jump", "mantle"]);
}

function tablet_enabled_check_dvar() {
  if(getdvarint(@ "hash_91ceae054e93350c", 0) == 0) {
    return false;
  }

  return false;
}

function getselectmappoint(info, selectnum, directionalselection) {
  if(!isDefined(info)) {
    assertmsg("No Streak / Super info defined when using map select");
    return;
  }

  issuper = isDefined(self.super) && self.super == info;
  val::group_set("map_select", 0);
  self setsoundsubmix("mp_killstreak_overlay");
  navmesh = 0;

  if(!isDefined(selectnum)) {
    selectnum = 1;
  }

  if(!isDefined(directionalselection)) {
    directionalselection = 0;
  }

  thread watchmapselectexit(info, issuper);
  thread watchownertimeoutdeath();
  mappointinfo = undefined;
  streakref = info.streakname;

  if(istrue(issuper)) {
    streakref = info.staticdata.ref;
  }

  scripts\cp_mp\utility\killstreak_utility::starttabletscreen(streakref, 0.05);
  mappointinfo = gathermappointinfo(selectnum, directionalselection);

  if(isDefined(self)) {
    time = 0.75;

    if(istrue(self.var_4a2f2f50a9020e2e)) {
      time = 0;
    }

    scripts\cp_mp\utility\killstreak_utility::stoptabletscreen(streakref, time);

    if(scripts\cp_mp\utility\player_utility::isreallyalive(self)) {
      val::group_reset("map_select");
    }

    self clearsoundsubmix("mp_killstreak_overlay");
  }

  return mappointinfo;
}

function gathermappointinfo(selectnum, directionalselection) {
  self endon("disconnect");
  usehints = 1;

  if(selectnum <= 1) {
    self setclientomnvar("ui_map_select_uses", -1);
    usehints = 0;
  }

  self.mapselectpickcounter = 0;
  self.previousmapselectioninfo = undefined;
  locationinfo = [];
  thread watchmapselectweapon();
  thread function_6da0c1b847186872();

  if(istrue(usehints)) {
    self setclientomnvar("ui_map_select_uses", selectnum);
    self setclientomnvar("ui_map_select_count", selectnum);
  }

  returninfo = undefined;

  while(self.mapselectpickcounter < selectnum) {
    returninfo = waittill_confirm_or_cancel("confirm_location", "cancel_location", "death");

    if(!isDefined(returninfo) || returninfo.string == "death") {
      self.var_4a2f2f50a9020e2e = 1;
      locationinfo = undefined;
      break;
    } else if(returninfo.string == "cancel_location") {
      locationinfo = undefined;
      break;
    }

    var_4d08a3ddec28e17b = returninfo.location + (0, 0, 10000);
    var_3cb14aea5687b8f6 = returninfo.location - (0, 0, 10000);
    drivablevehicles = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstancesforall();
    killstreakmodels = level.activekillstreaks;
    var_b9d5783a4f34efbc = array_combine(drivablevehicles, killstreakmodels);
    contentoverride = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0, 0, 0, 0);
    locationtrace = scripts\engine\trace::ray_trace(var_4d08a3ddec28e17b, var_3cb14aea5687b8f6, var_b9d5783a4f34efbc, contentoverride, 0, 1);
    returninfo.location = locationtrace["position"];
    locationinfo[locationinfo.size] = returninfo;
    self.mapselectpickcounter++;

    if(istrue(usehints)) {
      self setclientomnvar("ui_map_select_uses", selectnum - self.mapselectpickcounter);
    }
  }

  level notify("vision_set_change_request", "", self, 0);
  self notify("map_select_exit", returninfo);
  return locationinfo;
}

function watchmapselectweapon() {
  self endon("map_select_exit");

  while(true) {
    currentweapon = self getcurrentweapon();

    if(currentweapon.basename != "ks_remote_map_cp") {
      self notify("cancel_location");
      break;
    }

    waitframe();
  }
}

function function_6da0c1b847186872() {
  self endon("map_select_exit");
  self waittill("last_stand_start");
  self notify("cancel_location");
}

function watchmapselectexit(info, issuper) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("map_select_exit", exitinfo);
  stopmapselectsequence(info, issuper, exitinfo);
}

function watchownertimeoutdeath() {
  self endon("disconnect");
  self endon("map_select_exit");
  level endon("game_ended");
  self setclientomnvar("ui_location_selection_countdown", gettime() + 30000);
  waittill_any_timeout_1(30, "death");
  self notify("cancel_location");
}

function startmapselectsequence(navmesh, directionalselection, directionaltype, selectortype, info) {
  if(!isDefined(self.pers["startedMapSelect"])) {
    self.pers["startedMapSelect"] = [];
    thread function_b5fc9b44b6730955();
  }

  if(isDefined(info)) {
    if(function_5834a9b56f5426c(info)) {
      triggeroneoffradarsweep(self);
      var_d8a763b4fba17240 = function_13b26fcc6dde1c17(info);
      self.pers["startedMapSelect"][var_d8a763b4fba17240] = info;
    }
  }

  if(!isDefined(navmesh)) {
    navmesh = 0;
  }

  if(!isDefined(directionalselection)) {
    directionalselection = 0;
  }

  if(!isDefined(directionaltype)) {
    directionaltype = "circle_marker";
  }

  if(!isDefined(selectortype)) {
    selectortype = 0;
  }

  self beginlocationselection(navmesh, directionalselection, directionaltype, 1, selectortype);
}

function stopmapselectsequence(info, issuper, exitinfo) {
  self.mapselectpickcounter = undefined;
  self.mapselectdircounter = undefined;
  self.previousmapselectioninfo = undefined;

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    if(istrue(issuper)) {
      self notify("super_finished_with_deploy_weapon");
    } else {
      info notify("killstreak_finished_with_deploy_weapon");
    }
  }

  if(exitinfo.string == "confirm_location" || exitinfo.string == "death") {
    var_d8a763b4fba17240 = function_13b26fcc6dde1c17(info);
    self.pers["startedMapSelect"] = array_remove_index(self.pers["startedMapSelect"], var_d8a763b4fba17240, 1);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);

  if(isDefined(self)) {
    self endlocationselection();
    self setclientomnvar("ui_map_select_count", -1);
  }
}

function private function_5834a9b56f5426c(info) {
  var_e4a2bc835644693 = self.pers["startedMapSelect"];

  if(isDefined(var_e4a2bc835644693)) {
    foreach(instance in var_e4a2bc835644693) {
      if(!function_a8d72277fd0a66cc(instance, info)) {
        return false;
      }

      if(!function_e687e3855c8f00ff(instance, info)) {
        return false;
      }
    }
  }

  return true;
}

function private function_a8d72277fd0a66cc(var_755a09c275461972, newinfo) {
  if(isDefined(var_755a09c275461972.staticdata) && isDefined(newinfo.staticdata)) {
    if(var_755a09c275461972.staticdata.ref == newinfo.staticdata.ref && var_755a09c275461972.lifeid == newinfo.lifeid) {
      return false;
    }
  }

  return true;
}

function private function_e687e3855c8f00ff(var_755a09c275461972, newinfo) {
  if(isDefined(var_755a09c275461972.streakname) && isDefined(newinfo.streakname)) {
    if(var_755a09c275461972.streakname == newinfo.streakname && var_755a09c275461972.lifeid == newinfo.lifeid) {
      return false;
    }
  }

  return true;
}

function private function_b5fc9b44b6730955() {
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("death");
    self.pers["startedMapSelect"] = [];
  }
}

function private function_13b26fcc6dde1c17(info) {
  var_d8a763b4fba17240 = undefined;

  if(isDefined(info.staticdata)) {
    var_d8a763b4fba17240 = info.staticdata.ref;
  } else if(isDefined(info.streakname)) {
    var_d8a763b4fba17240 = info.streakname;
  }

  if(!isDefined(var_d8a763b4fba17240)) {
    iprintln("<dev string:x1c>");
  }

  return var_d8a763b4fba17240;
}

function waittill_confirm_or_cancel(confirmstring, cancelstring, endstring) {
  if((!isDefined(confirmstring) || confirmstring != "death") && (!isDefined(cancelstring) || cancelstring != "death") && (!isDefined(endstring) || endstring != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(confirmstring)) {
    childthread waittill_return(confirmstring, ent);
  }

  if(isDefined(cancelstring)) {
    childthread waittill_return(cancelstring, ent);
  }

  if(isDefined(endstring)) {
    childthread waittill_return(endstring, ent);
  }

  ent waittill("returned", location, angle, string);
  ent notify("die");
  returninfo = spawnStruct();
  returninfo.location = location;
  returninfo.angles = angle;
  returninfo.string = string;
  return returninfo;
}

function waittill_return(confirmstring, ent) {
  if(confirmstring != "death") {
    self endon("death");
  }

  ent endon("die");
  self waittill(confirmstring, location, angle);
  ent notify("returned", location, angle, confirmstring);
}

function setmaplocationselection() {}

function set_uav_radarstrength(player) {
  uavstrengthmax = getuavstrengthmax();
  player.radarstrength = uavstrengthmax;
}