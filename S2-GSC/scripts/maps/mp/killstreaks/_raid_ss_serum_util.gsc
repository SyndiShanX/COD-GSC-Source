/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_raid_ss_serum_util.gsc
***************************************************************/

serumhadperk(var_0) {
  if(isDefined(self.raidpreserumperkslist[var_0])) {
    return 1;
  }

  return 0;
}

serumcreateoverlay(var_0) {
  var_1 = _newclienthudelem(self);
  var_1.x = 0;
  var_1.y = 0;
  var_1.sort = -5;
  var_1._id_00C6 = "fullscreen";
  var_1._id_01CA = "fullscreen";
  var_1 setshader(var_0, 640, 480);
  var_1.hidewheninmenu = 1;
  var_1._id_0180 = 0;
  var_1.alpha = 1;
  return var_1;
}

serumtimerupdate(var_0) {
  self endon("force_stop_serum");
  self endon("disconnect");
  self endon("death");
  self setclientomnvar("serum_active_percent", 1);
  self setclientomnvar("serum_active_streakIndex", self.lastusedkillstreakslotindex);
  self.currenttimervalue = var_0;
  self waittill("altered_state_start");

  while(self.currenttimervalue > 0) {
    self.currenttimervalue = self.currenttimervalue - 0.15;
    self setclientomnvar("serum_active_percent", max(0, (self.currenttimervalue - 0.15) / var_0));
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.15);
  }

  self setclientomnvar("serum_active_percent", 0);
  self setclientomnvar("serum_active_streakIndex", -1);
  _id_051E::_id_A170();
  self notify("serum_finished");
}

altered_state_apply(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;
  level endon("game_ended");
  var_6 endon("disconnect");
  var_6 endon("death");

  if(common_scripts\utility::_id_562E(var_6.in_altered_state)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 30.0;
  }

  if(!isDefined(var_2)) {
    var_2 = "blue";
  }

  if(!isDefined(var_3)) {
    var_3 = 1.0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.25;
  }

  if(!isDefined(var_5)) {
    var_5 = 1.0;
  }

  var_6 notify("altered_state_apply");
  var_6 thread altered_state_death_listener();
  var_6 thread altered_state_game_end_listener();
  var_6 thread altered_state_activate(var_3, var_4, var_5, var_2);
  var_6 waittill("altered_state_start");

  if(!common_scripts\utility::_id_562E(var_0)) {
    var_6.altered_state_duration = var_1;
    wait(var_6.altered_state_duration - var_3);
    var_6 altered_state_deactivate(var_3, var_4, var_5, var_2);
  }
}

altered_state_start(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_4 altered_state_start_fx(var_3);
  var_4.in_altered_state = 1;
  var_4.altered_state_start_time = gettime() * 0.001;
  var_4 notify("altered_state_start");
}

altered_state_end() {
  var_0 = self;
  var_0 altered_state_kill_fx();
  var_0.in_altered_state = 0;
  var_0.altered_state_start_time = undefined;
  var_0 notify("altered_state_end");
}

altered_state_death_listener() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 waittill("death");
  var_0 altered_state_end();
  var_0 altered_state_hide_client_overlay();
}

altered_state_game_end_listener() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 endon("death");
  var_0 endon("altered_state_end");
  level waittill("game_ended");
  var_0 altered_state_end();
  var_0 altered_state_hide_client_overlay();
}

altered_state_activate(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_4 endon("death");
  var_4 endon("disconnect");
  level endon("game_ended");
  var_4 altered_state_fade_in(var_0, var_2);
  var_4 altered_state_start(var_0, var_1, var_2, var_3);
  var_4 altered_state_fade_out(var_1, var_2);
  var_4 notify("altered_state_active");
}

altered_state_deactivate(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_4 endon("death");
  var_4 endon("disconnect");
  level endon("game_ended");
  _id_0378::_id_8D74("aud_serum_buff_end");
  var_4 altered_state_fade_in(var_0, var_2);
  var_4 altered_state_end();
  var_4 altered_state_fade_out(var_1, var_2);
  var_4 altered_state_hide_client_overlay();
  var_4 notify("altered_state_inactive");
}

altered_state_fade_in(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_2 endon("disconnect");
  level endon("game_ended");

  if(!maps\mp\_utility::isreallyalive(var_2)) {
    return;
  }
  if(!isDefined(var_2.altered_state_overlay_fade)) {
    var_2.altered_state_overlay_fade = altered_state_create_client_overlay("white", var_1, var_2);
  }

  var_2.altered_state_overlay_fade.alpha = 0;
  var_2.altered_state_overlay_fade fadeovertime(var_0);
  var_2.altered_state_overlay_fade.alpha = var_1;
  wait(var_0);
}

altered_state_fade_out(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_2 endon("disconnect");
  level endon("game_ended");

  if(!maps\mp\_utility::isreallyalive(var_2)) {
    return;
  }
  if(!isDefined(var_2.altered_state_overlay_fade)) {
    return;
  }
  var_2.altered_state_overlay_fade.alpha = var_1;
  var_2.altered_state_overlay_fade fadeovertime(var_0);
  var_2.altered_state_overlay_fade.alpha = 0;
  wait(var_0);
}

altered_state_create_client_overlay(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  if(isDefined(var_2)) {
    var_5 = _newclienthudelem(var_2);
  } else {
    var_5 = newhudelem();
  }

  var_5.x = 0;
  var_5.y = 0;
  var_5 setshader(var_0, 640, 480);
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.sort = 1;
  var_5._id_00C6 = "fullscreen";
  var_5._id_01CA = "fullscreen";
  var_5.alpha = var_1;
  var_5.foreground = var_4;
  return var_5;
}

altered_state_hide_client_overlay() {
  var_0 = self;

  if(isDefined(var_0.altered_state_overlay_fade)) {
    var_0.altered_state_overlay_fade.alpha = 0.0;
  }
}

altered_state_start_fx(var_0) {
  var_1 = self;

  switch (var_0) {
    case "green":
      var_2 = "mp_dlc4_1st_person_serum_green";
      var_3 = "mp_dlc4_3rd_person_serum_green";
      break;
    case "purple":
      var_2 = "mp_dlc4_1st_person_serum_purple";
      var_3 = "mp_dlc4_3rd_person_serum_purple";
      break;
    case "orange":
      var_2 = "mp_dlc4_1st_person_serum_orange";
      var_3 = "mp_dlc4_3rd_person_serum_orange";
      break;
    default:
      var_2 = "mp_dlc4_1st_person_serum_blue";
      var_3 = "mp_dlc4_3rd_person_serum_blue";
      break;
  }

  if(isDefined(var_1) && maps\mp\_utility::isreallyalive(var_1)) {
    var_1.altered_state_fx = _spawnlinkedfxforclient(common_scripts\utility::_id_44F5(var_2), var_1, "tag_origin", var_1);
    setfxkillondelete(var_1.altered_state_fx, 1);
    _triggerfx(var_1.altered_state_fx);
    var_1 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_1.altered_state_fx);

    if(0) {
      var_1.altered_state_fx_3rd = _spawnlinkedfx(common_scripts\utility::_id_44F5(var_3), var_1, "tag_origin");
      _triggerfx(var_1.altered_state_fx_3rd);
      var_1 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_1.altered_state_fx_3rd);
    }
  }
}

altered_state_kill_fx() {
  var_0 = self;

  if(isDefined(var_0.altered_state_fx)) {
    var_0.altered_state_fx delete();
  }

  if(isDefined(var_0.altered_state_fx_3rd)) {
    var_0.altered_state_fx_3rd delete();
  }
}

pickupisserum(var_0) {
  return var_0 == "raid_ss_serum_a" || var_0 == "raid_ss_serum_b" || var_0 == "raid_ss_serum_c";
}

handleserumpickup(var_0) {
  var_1 = 1;

  if(common_scripts\utility::_id_562E(var_0.raidserumactive) && !common_scripts\utility::_id_562E(var_0.basictrainingserumactive)) {
    var_0 iprintlnbold(&"KILLSTREAKS_DLC4_ONE_SERUM_AT_A_TIME");
    var_1 = 0;
  }

  return var_1;
}

handledisableserumonpickup(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(common_scripts\utility::_id_562E(var_1.basictrainingserumactive)) {
    var_2 = var_1 getserumkillstreakslot(var_0);
    var_1 disableserum(var_2);
  }
}

getserumkillstreakslot(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  for(var_5 = 0; var_5 < self.pers["killstreaks"].size; var_5++) {
    if(isDefined(self.pers["killstreaks"][var_5]) && isDefined(self.pers["killstreaks"][var_5]._id_944C)) {
      if(self.pers["killstreaks"][var_5]._id_944C == var_0 || isDefined(var_1) && self.pers["killstreaks"][var_5]._id_944C == var_1 || isDefined(var_2) && self.pers["killstreaks"][var_5]._id_944C == var_2 || isDefined(var_3) && self.pers["killstreaks"][var_5]._id_944C == var_3) {
        var_4 = var_5;
        break;
      }
    }
  }

  return var_4;
}

disableserumdeathlistener(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  self.pers["killstreaks"][var_0]._id_13AF = 1;
  _id_051E::_id_A170();
}

disableserum(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  thread disableserumdeathlistener(var_0);
  self.pers["killstreaks"][var_0]._id_13AF = 0;
  _id_051E::_id_A170();
  self waittill("serum_finished");
  self.pers["killstreaks"][var_0]._id_13AF = 1;
  _id_051E::_id_A170();
}