/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\mapselect.gsc
***************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#namespace mapselect;

function init() {
  function_8bb8ac075d5a87dc();
}

function function_8bb8ac075d5a87dc() {
  val::group_register("map_select", ["usability", "killstreaks", "supers", "gesture", "fire", "weapon_switch", "allow_movement", "offhand_weapons", "allow_jump", "mantle"]);
}

function function_5d9830f341fbd83a() {
  return "ks_remote_map_mp";
}

function function_a5839924b6723eac(info, selectnum, directionalselection) {
  if(!isDefined(info)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  issuper = isDefined(self.super) && self.super == info;
  val::group_set("map_select", 0);
  self setsoundsubmix("mp_killstreak_overlay");
  navmesh = 0;

  if(isDefined(info.streakname)) {
    if(isnavmeshkillstreak(info.streakname)) {
      navmesh = 1;
    }
  }

  if(!isDefined(selectnum)) {
    selectnum = 1;
  }

  if(!isDefined(directionalselection)) {
    directionalselection = 0;
  }

  thread function_b34ec2892ae5b88d(info, issuper);
  thread function_f2e8c1603fc727ea();
  thread function_69db129634b2bcb();
  mappointinfo = undefined;
  streakref = info.streakname;

  if(istrue(issuper)) {
    streakref = info.staticdata.ref;
  }

  scripts\cp_mp\utility\killstreak_utility::starttabletscreen(streakref, 0.05);
  mappointinfo = function_7023c245afe8cd79(selectnum, directionalselection);

  if(isDefined(self)) {
    time = 0.75;

    if(istrue(self.var_4a2f2f50a9020e2e)) {
      time = 0;
    }

    scripts\cp_mp\utility\killstreak_utility::stoptabletscreen(streakref, time);

    if(isreallyalive(self)) {
      val::group_reset("map_select");
    }

    self clearsoundsubmix("mp_killstreak_overlay");
  }

  return mappointinfo;
}

function function_7023c245afe8cd79(selectnum, directionalselection) {
  self endon("disconnect");
  usehints = 1;

  if(selectnum <= 1) {
    self setclientomnvar("ui_map_select_uses", -1);
    usehints = 0;
  }

  self.mapselectpickcounter = 0;
  self.previousmapselectioninfo = undefined;
  locationinfo = [];
  thread function_12a0597458af2369();

  if(istrue(usehints)) {
    self setclientomnvar("ui_map_select_uses", selectnum);
    self setclientomnvar("ui_map_select_count", selectnum);
  }

  returninfo = undefined;
  self dlog_recordplayerevent("dlog_event_killstreak_tablet", ["file_line_info", "Before ui_map_select_uses"]);

  while(self.mapselectpickcounter < selectnum) {
    returninfo = waittill_confirm_or_cancel("confirm_location", "cancel_location", "death");

    if(!isDefined(returninfo) || returninfo.string == "death") {
      self.var_4a2f2f50a9020e2e = 1;
      locationinfo = undefined;
      break;
    } else if(returninfo.string == "cancel_location") {
      locationinfo = undefined;
      self playlocalsound("iw9_ks_tablet_ui_select_final_plr");
      break;
    }

    if(level.mapname == "mp_jup_vertigo") {
      returninfo.location += (0, 0, 11000);
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
    self playlocalsound("iw9_ks_tablet_ui_select_plr");

    if(istrue(usehints)) {
      self setclientomnvar("ui_map_select_uses", selectnum - self.mapselectpickcounter);
    }
  }

  self dlog_recordplayerevent("dlog_event_killstreak_tablet", ["file_line_info", "After ui_map_select_uses"]);
  self notify("map_select_exit", returninfo);
  return locationinfo;
}

function function_12a0597458af2369() {
  self endon("map_select_exit");

  while(true) {
    currentweapon = self getcurrentweapon();

    if(currentweapon.basename != "ks_remote_map_mp") {
      self notify("cancel_location");
      break;
    }

    waitframe();
  }
}

function function_b34ec2892ae5b88d(info, issuper) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("map_select_exit", exitinfo);
  function_4f783849d35ee7(info, issuper, exitinfo);
}

function function_f2e8c1603fc727ea() {
  self endon("disconnect");
  self endon("map_select_exit");
  level endon("game_ended");

  while(true) {
    if(scripts\cp_mp\emp_debuff::is_empd()) {
      self notify("cancel_location");
      break;
    }

    waitframe();
  }
}

function function_69db129634b2bcb() {
  self endon("disconnect");
  self endon("map_select_exit");
  level endon("game_ended");
  self setclientomnvar("ui_location_selection_countdown", gettime() + 30000);
  waittill_any_timeout_1(30, "death");
  self notify("cancel_location");
}

function function_90f093ca8576232f(navmesh, directionalselection, directionaltype, selectortype, info, selectorradius) {
  if(!isDefined(self.pers["startedMapSelect"])) {
    self.pers["startedMapSelect"] = [];
    thread function_b5fc9b44b6730955();
  }

  if(isDefined(info)) {
    if(function_5834a9b56f5426c(info)) {
      if(isDefined(info.streakname)) {
        streakbundle = level.streakglobals.streakbundles[info.streakname];

        if(!isDefined(streakbundle) || !istrue(streakbundle.var_78ca6251f086bb17)) {
          triggeroneoffradarsweep(self);
        }
      }

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

  if(!isDefined(selectorradius)) {
    selectorradius = 1000;
  }

  self dlog_recordplayerevent("dlog_event_killstreak_tablet", ["file_line_info", "Before BeginLocationSelection"]);
  self beginlocationselection(navmesh, directionalselection, directionaltype, 1, selectortype, selectorradius);
  self dlog_recordplayerevent("dlog_event_killstreak_tablet", ["file_line_info", "After BeginLocationSelection"]);
}

function function_4f783849d35ee7(info, issuper, exitinfo) {
  self.mapselectpickcounter = undefined;
  self.mapselectdircounter = undefined;
  self.previousmapselectioninfo = undefined;

  if(isreallyalive(self)) {
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
    iprintln("<dev string:x54>");
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

function private waittill_return(confirmstring, ent) {
  if(confirmstring != "death") {
    self endon("death");
  }

  ent endon("die");
  self waittill(confirmstring, location, angle);
  ent notify("returned", location, angle, confirmstring);
}