/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mpdialog.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace mpdialog;

function autoexec __init__sytem__() {
  system::register("mpdialog", & __init__, undefined, undefined);
}

function __init__() {
  level.mpboostresponse = [];
  level.mpboostresponse["assassin"] = "Spectre";
  level.mpboostresponse["grenadier"] = "Grenadier";
  level.mpboostresponse["outrider"] = "Outrider";
  level.mpboostresponse["prophet"] = "Technomancer";
  level.mpboostresponse["pyro"] = "Firebreak";
  level.mpboostresponse["reaper"] = "Reaper";
  level.mpboostresponse["ruin"] = "Mercenary";
  level.mpboostresponse["seraph"] = "Enforcer";
  level.mpboostresponse["trapper"] = "Trapper";
  level.mpboostresponse["blackjack"] = "Blackjack";
  level.clientvoicesetup = & client_voice_setup;
  clientfield::register("world", "boost_number", 1, 2, "int", & set_boost_number, 1, 1);
  clientfield::register("allplayers", "play_boost", 1, 2, "int", & play_boost_vox, 1, 0);
}

function client_voice_setup(localclientnum) {
  self thread snipervonotify(localclientnum, "playerbreathinsound", "exertSniperHold");
  self thread snipervonotify(localclientnum, "playerbreathoutsound", "exertSniperExhale");
  self thread snipervonotify(localclientnum, "playerbreathgaspsound", "exertSniperGasp");
}

function snipervonotify(localclientnum, notifystring, dialogkey) {
  self endon("entityshutdown");
  for (;;) {
    self waittill(notifystring);
    if(isunderwater(localclientnum)) {
      return;
    }
    dialogalias = self get_player_dialog_alias(dialogkey);
    if(isdefined(dialogalias)) {
      self playsound(0, dialogalias);
    }
  }
}

function set_boost_number(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.boostnumber = newval;
}

function play_boost_vox(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayerteam = getlocalplayerteam(localclientnum);
  entitynumber = self getentitynumber();
  if(newval == 0 || self.team != localplayerteam || level._sndnextsnapshot != "mpl_prematch" || level.booststartentnum === entitynumber || level.boostresponseentnum === entitynumber) {
    return;
  }
  if(newval == 1) {
    level.booststartentnum = entitynumber;
    self thread play_boost_start_vox(localclientnum);
  } else if(newval == 2) {
    level.boostresponseentnum = entitynumber;
    self thread play_boost_start_response_vox(localclientnum);
  }
}

function play_boost_start_vox(localclientnum) {
  self endon("entityshutdown");
  self endon("death");
  wait(2);
  playbackid = self play_dialog("boostStart" + level.boostnumber, localclientnum);
  if(isdefined(playbackid) && playbackid >= 0) {
    while (soundplaying(playbackid)) {
      wait(0.05);
    }
  }
  wait(0.5);
  level.booststartresponse = ("boostStartResp" + level.mpboostresponse[self getmpdialogname()]) + level.boostnumber;
  if(isdefined(level.boostresponseentnum)) {
    responder = getentbynum(localclientnum, level.boostresponseentnum);
    if(isdefined(responder)) {
      responder thread play_boost_start_response_vox(localclientnum);
    }
  }
}

function play_boost_start_response_vox(localclientnum) {
  self endon("entityshutdown");
  self endon("death");
  if(!isdefined(level.booststartresponse) || self.team != getlocalplayerteam(localclientnum)) {
    return;
  }
  self play_dialog(level.booststartresponse, localclientnum);
}

function get_commander_dialog_alias(commandername, dialogkey) {
  if(!isdefined(commandername)) {
    return;
  }
  commanderbundle = struct::get_script_bundle("mpdialog_commander", commandername);
  return get_dialog_bundle_alias(commanderbundle, dialogkey);
}

function get_player_dialog_alias(dialogkey) {
  bundlename = self getmpdialogname();
  if(!isdefined(bundlename)) {
    return undefined;
  }
  playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
  return get_dialog_bundle_alias(playerbundle, dialogkey);
}

function get_dialog_bundle_alias(dialogbundle, dialogkey) {
  if(!isdefined(dialogbundle) || !isdefined(dialogkey)) {
    return undefined;
  }
  dialogalias = getstructfield(dialogbundle, dialogkey);
  if(!isdefined(dialogalias)) {
    return;
  }
  voiceprefix = getstructfield(dialogbundle, "voiceprefix");
  if(isdefined(voiceprefix)) {
    dialogalias = voiceprefix + dialogalias;
  }
  return dialogalias;
}

function play_dialog(dialogkey, localclientnum) {
  if(!isdefined(dialogkey) || !isdefined(localclientnum)) {
    return -1;
  }
  dialogalias = self get_player_dialog_alias(dialogkey);
  if(!isdefined(dialogalias)) {
    return -1;
  }
  soundpos = (self.origin[0], self.origin[1], self.origin[2] + 60);
  if(!isspectating(localclientnum)) {
    return self playsound(undefined, dialogalias, soundpos);
  }
  voicebox = spawn(localclientnum, self.origin, "script_model");
  self thread update_voice_origin(voicebox);
  voicebox thread delete_after(10);
  return voicebox playsound(undefined, dialogalias, soundpos);
}

function update_voice_origin(voicebox) {
  while (true) {
    wait(0.1);
    if(!isdefined(self) || !isdefined(voicebox)) {
      return;
    }
    voicebox.origin = self.origin;
  }
}

function delete_after(waittime) {
  wait(waittime);
  self delete();
}