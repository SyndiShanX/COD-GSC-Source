/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_raid_ss_serum_util.gsc
*******************************************************/

serumhadperk(param_00) {
  if(isDefined(self.raidpreserumperkslist[param_00])) {
    return 1;
  }

  return 0;
}

serumcreateoverlay(param_00) {
  var_01 = newclienthudelem(self);
  var_01.var_01D3 = 0;
  var_01.var_01D7 = 0;
  var_01.var_0184 = -5;
  var_01.var_00C6 = "fullscreen";
  var_01.var_01CA = "fullscreen";
  var_01 setshader(param_00, 640, 480);
  var_01.var_00C2 = 1;
  var_01.var_0180 = 0;
  var_01.var_0018 = 1;
  return var_01;
}

serumtimerupdate(param_00) {
  self endon("force_stop_serum");
  self endon("disconnect");
  self endon("death");
  self setclientomnvar("serum_active_percent", 1);
  self setclientomnvar("serum_active_streakIndex", self.lastusedkillstreakslotindex);
  self.currenttimervalue = param_00;
  self waittill("altered_state_start");
  while(self.currenttimervalue > 0) {
    self.currenttimervalue = self.currenttimervalue - 0.15;
    self setclientomnvar("serum_active_percent", max(0, self.currenttimervalue - 0.15 / param_00));
    maps\mp\gametypes\_hostmigration::func_A6F5(0.15);
  }

  self setclientomnvar("serum_active_percent", 0);
  self setclientomnvar("serum_active_streakIndex", -1);
  maps\mp\killstreaks\_killstreaks::func_A170();
  self notify("serum_finished");
}

altered_state_apply(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = self;
  level endon("game_ended");
  var_06 endon("disconnect");
  var_06 endon("death");
  if(common_scripts\utility::func_562E(var_06.in_altered_state)) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 30;
  }

  if(!isDefined(param_02)) {
    param_02 = "blue";
  }

  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  if(!isDefined(param_04)) {
    param_04 = 0.25;
  }

  if(!isDefined(param_05)) {
    param_05 = 1;
  }

  var_06 notify("altered_state_apply");
  var_06 thread altered_state_death_listener();
  var_06 thread altered_state_game_end_listener();
  var_06 thread altered_state_activate(param_03, param_04, param_05, param_02);
  var_06 waittill("altered_state_start");
  if(!common_scripts\utility::func_562E(param_00)) {
    var_06.altered_state_duration = param_01;
    wait(var_06.altered_state_duration - param_03);
    var_06 altered_state_deactivate(param_03, param_04, param_05, param_02);
  }
}

altered_state_start(param_00, param_01, param_02, param_03) {
  var_04 = self;
  var_04 altered_state_start_fx(param_03);
  var_04.in_altered_state = 1;
  var_04.altered_state_start_time = gettime() * 0.001;
  var_04 notify("altered_state_start");
}

altered_state_end() {
  var_00 = self;
  var_00 altered_state_kill_fx();
  var_00.in_altered_state = 0;
  var_00.altered_state_start_time = undefined;
  var_00 notify("altered_state_end");
}

altered_state_death_listener() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00 waittill("death");
  var_00 altered_state_end();
  var_00 altered_state_hide_client_overlay();
}

altered_state_game_end_listener() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00 endon("death");
  var_00 endon("altered_state_end");
  level waittill("game_ended");
  var_00 altered_state_end();
  var_00 altered_state_hide_client_overlay();
}

altered_state_activate(param_00, param_01, param_02, param_03) {
  var_04 = self;
  var_04 endon("death");
  var_04 endon("disconnect");
  level endon("game_ended");
  var_04 altered_state_fade_in(param_00, param_02);
  var_04 altered_state_start(param_00, param_01, param_02, param_03);
  var_04 altered_state_fade_out(param_01, param_02);
  var_04 notify("altered_state_active");
}

altered_state_deactivate(param_00, param_01, param_02, param_03) {
  var_04 = self;
  var_04 endon("death");
  var_04 endon("disconnect");
  level endon("game_ended");
  lib_0378::func_8D74("aud_serum_buff_end");
  var_04 altered_state_fade_in(param_00, param_02);
  var_04 altered_state_end();
  var_04 altered_state_fade_out(param_01, param_02);
  var_04 altered_state_hide_client_overlay();
  var_04 notify("altered_state_inactive");
}

altered_state_fade_in(param_00, param_01) {
  var_02 = self;
  var_02 endon("death");
  var_02 endon("disconnect");
  level endon("game_ended");
  if(!maps\mp\_utility::func_57A0(var_02)) {
    return;
  }

  if(!isDefined(var_02.altered_state_overlay_fade)) {
    var_02.altered_state_overlay_fade = altered_state_create_client_overlay("white", param_01, var_02);
  }

  var_02.altered_state_overlay_fade.var_0018 = 0;
  var_02.altered_state_overlay_fade fadeovertime(param_00);
  var_02.altered_state_overlay_fade.var_0018 = param_01;
  wait(param_00);
}

altered_state_fade_out(param_00, param_01) {
  var_02 = self;
  var_02 endon("death");
  var_02 endon("disconnect");
  level endon("game_ended");
  if(!maps\mp\_utility::func_57A0(var_02)) {
    return;
  }

  if(!isDefined(var_02.altered_state_overlay_fade)) {
    return;
  }

  var_02.altered_state_overlay_fade.var_0018 = param_01;
  var_02.altered_state_overlay_fade fadeovertime(param_00);
  var_02.altered_state_overlay_fade.var_0018 = 0;
  wait(param_00);
}

altered_state_create_client_overlay(param_00, param_01, param_02, param_03) {
  var_04 = 1;
  if(isDefined(param_03)) {
    var_04 = param_03;
  }

  if(isDefined(param_02)) {
    var_05 = newclienthudelem(param_02);
  } else {
    var_05 = newhudelem();
  }

  var_05.var_01D3 = 0;
  var_05.var_01D7 = 0;
  var_05 setshader(param_00, 640, 480);
  var_05.var_0010 = "left";
  var_05.var_0011 = "top";
  var_05.var_0184 = 1;
  var_05.var_00C6 = "fullscreen";
  var_05.var_01CA = "fullscreen";
  var_05.var_0018 = param_01;
  var_05.var_00A0 = var_04;
  return var_05;
}

altered_state_hide_client_overlay() {
  var_00 = self;
  if(isDefined(var_00.altered_state_overlay_fade)) {
    var_00.altered_state_overlay_fade.var_0018 = 0;
  }
}

altered_state_start_fx(param_00) {
  var_01 = self;
  switch (param_00) {
    case "green":
      var_02 = "mp_dlc4_1st_person_serum_green";
      var_03 = "mp_dlc4_3rd_person_serum_green";
      break;

    case "purple":
      var_02 = "mp_dlc4_1st_person_serum_purple";
      var_03 = "mp_dlc4_3rd_person_serum_purple";
      break;

    case "orange":
      var_02 = "mp_dlc4_1st_person_serum_orange";
      var_03 = "mp_dlc4_3rd_person_serum_orange";
      break;

    default:
      var_02 = "mp_dlc4_1st_person_serum_blue";
      var_03 = "mp_dlc4_3rd_person_serum_blue";
      break;
  }

  if(isDefined(var_01) && maps\mp\_utility::func_57A0(var_01)) {
    var_01.altered_state_fx = spawnlinkedfxforclient(common_scripts\utility::func_44F5(var_02), var_01, "tag_origin", var_01);
    function_014E(var_01.altered_state_fx, 1);
    triggerfx(var_01.altered_state_fx);
    var_01 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_01.altered_state_fx);
    if(0) {
      var_01.altered_state_fx_3rd = spawnlinkedfx(common_scripts\utility::func_44F5(var_03), var_01, "tag_origin");
      triggerfx(var_01.altered_state_fx_3rd);
      var_01 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_01.altered_state_fx_3rd);
    }
  }
}

altered_state_kill_fx() {
  var_00 = self;
  if(isDefined(var_00.altered_state_fx)) {
    var_00.altered_state_fx delete();
  }

  if(isDefined(var_00.altered_state_fx_3rd)) {
    var_00.altered_state_fx_3rd delete();
  }
}

pickupisserum(param_00) {
  return param_00 == "raid_ss_serum_a" || param_00 == "raid_ss_serum_b" || param_00 == "raid_ss_serum_c";
}

handleserumpickup(param_00) {
  var_01 = 1;
  if(common_scripts\utility::func_562E(param_00.raidserumactive) && !common_scripts\utility::func_562E(param_00.basictrainingserumactive)) {
    param_00 iclientprintlnbold(&"KILLSTREAKS_DLC4_ONE_SERUM_AT_A_TIME");
    var_01 = 0;
  }

  return var_01;
}

handledisableserumonpickup(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(common_scripts\utility::func_562E(param_01.basictrainingserumactive)) {
    var_02 = param_01 getserumkillstreakslot(param_00);
    param_01 disableserum(var_02);
  }
}

getserumkillstreakslot(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  for(var_05 = 0; var_05 < self.var_012C["killstreaks"].size; var_05++) {
    if(isDefined(self.var_012C["killstreaks"][var_05]) && isDefined(self.var_012C["killstreaks"][var_05].var_944C)) {
      if(self.var_012C["killstreaks"][var_05].var_944C == param_00 || (isDefined(param_01) && self.var_012C["killstreaks"][var_05].var_944C == param_01) || (isDefined(param_02) && self.var_012C["killstreaks"][var_05].var_944C == param_02) || isDefined(param_03) && self.var_012C["killstreaks"][var_05].var_944C == param_03) {
        var_04 = var_05;
        break;
      }
    }
  }

  return var_04;
}

disableserumdeathlistener(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  self.var_012C["killstreaks"][param_00].var_13AF = 1;
  maps\mp\killstreaks\_killstreaks::func_A170();
}

disableserum(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  thread disableserumdeathlistener(param_00);
  self.var_012C["killstreaks"][param_00].var_13AF = 0;
  maps\mp\killstreaks\_killstreaks::func_A170();
  self waittill("serum_finished");
  self.var_012C["killstreaks"][param_00].var_13AF = 1;
  maps\mp\killstreaks\_killstreaks::func_A170();
}