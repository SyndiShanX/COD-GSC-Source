/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_tank_battlechatter.gsc
****************************************/

init() {
  if(isDefined(anim.tank_bc)) {
    return;
  }
  level.tank_chatter_enabled = 1;
  anim.tank_bc = spawnStruct();
  anim.tank_bc.bc_isspeaking = 0;
  anim.tank_bc.numtankvoices = 1;
  anim.tank_bc.currentassignedvoice = 0;
  anim.tank_bc.lastalias = [];
  anim.tank_bc.bc_eventtypelastusedtime = [];
  anim.tank_bc.bc_eventtypelastusedtimeplr = [];
  anim.tank_bc.eventtypeminwait = [];
  anim.tank_bc.eventtypeminwait["same_alias"] = 15;
  anim.tank_bc.eventtypeminwait["callout_clock"] = 10;
  anim.tank_bc.eventtypeminwait["killfirm"] = 3;
  anim.tank_bc.eventtypeminwait["inform_firing"] = 10;
  anim.tank_bc.eventtypeminwait["inform_taking_fire"] = 30;
  anim.tank_bc.eventtypeminwait["inform_reloading"] = 5;
  anim.tank_bc.eventtypeminwait["inform_loaded"] = 0.5;
  anim.tank_bc.eventtypeminwait["inform_enemy_hit"] = 5;
  anim.tank_bc.eventtypeminwait["inform_enemy_retreat"] = 5;
  anim.tank_bc.bcprintfailprefix = "^3***** BCS FAILURE: ";
}

init_chatter() {
  if(isplayer(self)) {
    self.voiceid = "plr";
    self.bc_isspeaking = 0;
    thread enemy_callout_tracking_plr();
  } else
    return;

  self.bc_enabled = 1;
  thread tank_shoot_tracking();
  thread take_fire_tracking();
}

tank_shoot_tracking() {
  self endon("death");

  for(;;) {
    self.tank waittill("firing");
    var_0 = createevent("inform_firing", "inform_firing");
    thread play_chatter(var_0);
    self.tank waittill("reloading");
    var_0 = createevent("inform_reloading", "inform_reloading");
    thread play_chatter(var_0);
    self.tank waittill("reloaded");
    var_0 = createevent("inform_loaded", "inform_loaded");
    thread play_chatter(var_0);
  }
}

enemy_death_tracking(var_0) {
  var_0 waittill("death", var_1);
  wait 0.5;

  if(isDefined(var_1)) {
    if(var_1.classname == "misc_turret")
      var_1 = var_1 getturretowner();

    if(isDefined(var_1) && isDefined(var_1.bc_enabled)) {
      var_2 = createevent("killfirm", "killfirm");
      var_1 play_chatter(var_2);
    }
  }
}

enemy_damage_tracking(var_0) {
  var_0 endon("death");

  while(isalive(var_0)) {
    var_0 waittill("damage", var_1, var_2);

    if(isDefined(var_2)) {
      if(var_2.classname == "misc_turret")
        var_2 = var_2 getturretowner();

      if(isDefined(var_2) && isDefined(var_2.bc_enabled)) {
        var_3 = createevent("inform_enemy_hit", "inform_hit");
        var_2 play_chatter(var_3);
      }
    }
  }
}

enemy_callout_tracking_plr() {
  self endon("death");

  for(;;) {
    var_0 = undefined;
    var_1 = [];
    var_2 = maps\_utility::getvehiclearray();

    foreach(var_4 in var_2) {
      if(var_4.script_team != "allies")
        var_1 = common_scripts\utility::array_add(var_1, var_4);
    }

    var_1 = sortbydistance(var_1, self.origin);

    foreach(var_7 in var_1) {
      if(isDefined(var_7.lastplayercallouttime) && gettime() - var_7.lastplayercallouttime < 9000) {
        continue;
      }
      if(distance2d(self.origin, var_7.origin) > 2000) {
        break;
      }

      var_0 = var_7;
      break;
    }

    if(!isDefined(var_0)) {
      var_1 = getaiarray("axis");
      var_1 = common_scripts\utility::array_combine(getaiarray("team3"), var_1);
      var_1 = sortbydistance(var_1, self.origin);

      foreach(var_7 in var_1) {
        if(isDefined(var_7.lastplayercallouttime) && gettime() - var_7.lastplayercallouttime < 9000) {
          continue;
        }
        if(distance2d(self.origin, var_7.origin) > 2000) {
          break;
        }

        var_0 = var_7;
        break;
      }
    }

    if(isDefined(var_0)) {
      var_11 = createevent("callout_clock", getthreatalias(var_0));

      if(play_chatter(var_11)) {
        if(isDefined(var_0))
          var_0.lastplayercallouttime = gettime();
      }
    }

    wait 1;
  }
}

take_fire_tracking() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);
    self.request_move = 1;

    if(isDefined(var_1)) {
      if(!isplayer(var_1)) {
        var_2 = createevent("inform_taking_fire", "inform_taking_fire");
        play_chatter(var_2);
      }
    }
  }
}

createevent(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.eventtype = var_0;
  var_2.alias = var_1;
  return var_2;
}

getthreatalias(var_0) {
  if(isplayer(self))
    var_1 = animscripts\battlechatter::getdirectionfacingclock(self getplayerangles(), self.origin, var_0.origin);
  else
    var_1 = animscripts\battlechatter::getdirectionfacingclock(self.angles, self.origin, var_0.origin);

  var_2 = "callout_targetclock_" + var_1;

  if(common_scripts\utility::cointoss()) {
    if(isai(var_0))
      var_2 = var_2 + "_troops";

    if(var_0 maps\_vehicle::isvehicle()) {
      if(var_0 maps\_vehicle::ishelicopter())
        var_2 = var_2 + "_bird";

      if(var_0 istank())
        var_2 = var_2 + "_tank";
    }
  }

  return var_2;
}

istank() {
  if(issubstr(self.classname, "t90"))
    return 1;

  if(issubstr(self.classname, "t72"))
    return 1;

  return 0;
}

play_chatter(var_0, var_1) {
  self endon("death");

  if(!can_say_event_type(var_0.eventtype))
    return 0;

  var_2 = get_team_prefix() + self.voiceid + "_" + var_0.alias;

  if(!isDefined(var_2))
    return 0;

  if(!soundexists(var_2))
    return 0;

  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1 && !can_say_soundalias(var_2))
    return 0;

  if(isplayer(self))
    self.bc_isspeaking = 1;
  else
    anim.tank_bc.bc_isspeaking = 1;

  iprintln("tank bcs: " + var_2);
  self playSound(var_2, "bc_done", 1);
  self waittill("bc_done");

  if(isplayer(self))
    self.bc_isspeaking = 0;
  else
    anim.tank_bc.bc_isspeaking = 0;

  update_event_type(var_0.eventtype, var_0.alias);
  return 1;
}

can_say_event_type(var_0) {
  if(!isDefined(level.tank_chatter_enabled) || !level.tank_chatter_enabled)
    return 0;

  if(!self.bc_enabled)
    return 0;

  if(!isplayer(self) && anim.tank_bc.bc_isspeaking)
    return 0;
  else if(isplayer(self) && self.bc_isspeaking)
    return 0;

  if(isplayer(self) && !isDefined(anim.tank_bc.bc_eventtypelastusedtimeplr[var_0]))
    return 1;
  else if(!isplayer(self) && !isDefined(anim.tank_bc.bc_eventtypelastusedtime[var_0]))
    return 1;

  if(isplayer(self))
    var_1 = anim.tank_bc.bc_eventtypelastusedtimeplr[var_0];
  else
    var_1 = anim.tank_bc.bc_eventtypelastusedtime[var_0];

  var_2 = anim.tank_bc.eventtypeminwait[var_0] * 1000;

  if(gettime() - var_1 >= var_2)
    return 1;

  return 0;
}

can_say_soundalias(var_0) {
  if(isDefined(anim.tank_bc.lastalias["alias"]) && anim.tank_bc.lastalias["alias"] == var_0) {
    var_1 = anim.tank_bc.lastalias["time"];
    var_2 = anim.tank_bc.eventtypeminwait["same_alias"] * 1000;

    if(gettime() - var_1 < var_2)
      return 0;
  }

  return 1;
}

update_event_type(var_0, var_1) {
  if(isplayer(self))
    anim.tank_bc.bc_eventtypelastusedtimeplr[var_0] = gettime();
  else
    anim.tank_bc.bc_eventtypelastusedtime[var_0] = gettime();

  anim.tank_bc.lastalias["time"] = gettime();
  anim.tank_bc.lastalias["alias"] = var_1;
}

check_overrides(var_0, var_1) {
  return var_1;
}

get_team_prefix() {
  return "tank_";
}