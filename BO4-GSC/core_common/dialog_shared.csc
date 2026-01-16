/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\dialog_shared.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;

#namespace dialog_shared;

autoexec __init__system__() {
  system::register(#"dialog_shared", &__init__, undefined, undefined);
}

__init__() {
  level.mpboostresponse = [];
  level.mpboostresponse[#"battery"] = "Battery";
  level.mpboostresponse[#"buffassault"] = "BuffAssault";
  level.mpboostresponse[#"engineer"] = "Engineer";
  level.mpboostresponse[#"firebreak"] = "Firebreak";
  level.mpboostresponse[#"nomad"] = "Nomad";
  level.mpboostresponse[#"prophet"] = "Prophet";
  level.mpboostresponse[#"recon"] = "Recon";
  level.mpboostresponse[#"ruin"] = "Ruin";
  level.mpboostresponse[#"seraph"] = "Seraph";
  level.mpboostresponse[#"swatpolice"] = "SwatPolice";
  level.mpboostresponse[#"spectre"] = "Spectre";
  level.mpboostresponse[#"reaper"] = "Reaper";
  level.mpboostresponse[#"outrider"] = "Outrider";
  level.clientvoicesetup = &client_voice_setup;
  clientfield::register("world", "boost_number", 1, 2, "int", &set_boost_number, 1, 1);
  clientfield::register("allplayers", "play_boost", 1, 2, "int", &play_boost_vox, 1, 0);
}

client_voice_setup(localclientnum) {
  self thread snipervonotify(localclientnum, "playerbreathinsound", "exertSniperHold");
  self thread snipervonotify(localclientnum, "playerbreathoutsound", "exertSniperExhale");
  self thread snipervonotify(localclientnum, "playerbreathgaspsound", "exertSniperGasp");
}

snipervonotify(localclientnum, notifystring, dialogkey) {
  self endon(#"death");

  for(;;) {
    self waittill(notifystring);

    if(isunderwater(localclientnum)) {
      return;
    }

    dialogalias = self get_player_dialog_alias(dialogkey);

    if(isDefined(dialogalias)) {
      self playSound(0, dialogalias);
    }
  }
}

set_boost_number(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.boostnumber = newval;
}

play_boost_vox(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayerteam = function_73f4b33(localclientnum);
  entitynumber = self getentitynumber();

  if(newval == 0 || self.team != localplayerteam || level._sndnextsnapshot != "mpl_prematch" || level.booststartentnum === entitynumber || level.boostresponseentnum === entitynumber) {
    return;
  }

  if(newval == 1) {
    level.booststartentnum = entitynumber;
    self thread play_boost_start_vox(localclientnum);
    return;
  }

  if(newval == 2) {
    level.boostresponseentnum = entitynumber;
    self thread play_boost_start_response_vox(localclientnum);
  }
}

play_boost_start_vox(localclientnum) {
  self endon(#"death");
  wait 2;
  playbackid = self play_dialog("boostStart" + level.boostnumber, localclientnum);

  if(isDefined(playbackid) && playbackid >= 0) {
    while(soundplaying(playbackid)) {
      wait 0.05;
    }
  }

  wait 0.5;
  level.booststartresponse = "boostStartResp" + level.mpboostresponse[self getmpdialogname()] + level.boostnumber;

  if(isDefined(level.boostresponseentnum)) {
    responder = getentbynum(localclientnum, level.boostresponseentnum);

    if(isDefined(responder)) {
      responder thread play_boost_start_response_vox(localclientnum);
    }
  }
}

play_boost_start_response_vox(localclientnum) {
  self endon(#"death");

  if(!isDefined(level.booststartresponse) || !self function_83973173()) {
    return;
  }

  self play_dialog(level.booststartresponse, localclientnum);
}

dialog_chance(chancekey) {
  dialogchance = mpdialog_value(chancekey);

  if(!isDefined(dialogchance) || dialogchance <= 0) {
    return false;
  } else if(dialogchance >= 100) {
    return true;
  }

  return randomint(100) < dialogchance;
}

function_ad01601e(characterindex) {
  characterfields = getcharacterfields(characterindex, currentsessionmode());

  if(isDefined(characterfields) && isDefined(characterfields.mpdialog)) {
    dialogbundle = struct::get_script_bundle("mpdialog_player", characterfields.mpdialog);
    alias = get_dialog_bundle_alias(dialogbundle, "characterSelect");

    if(isDefined(level.var_aefa616f) && level.var_aefa616f && dialog_chance("characterSelectMaldivesChance")) {
      alias = get_dialog_bundle_alias(dialogbundle, "maldivesCharacterSelectOverride");
    }

    if(isDefined(alias)) {
      self playSound(undefined, alias);
    }
  }
}

get_commander_dialog_alias(commandername, dialogkey) {
  if(!isDefined(commandername)) {
    return;
  }

  commanderbundle = struct::get_script_bundle("mpdialog_commander", commandername);
  return get_dialog_bundle_alias(commanderbundle, dialogkey);
}

get_dialog_bundle_alias(dialogbundle, dialogkey) {
  if(!isDefined(dialogbundle) || !isDefined(dialogkey)) {
    return undefined;
  }

  dialogalias = dialogbundle.(dialogkey);

  if(!isDefined(dialogalias)) {
    return;
  }

  voiceprefix = dialogbundle.("voiceprefix");

  if(isDefined(voiceprefix)) {
    dialogalias = voiceprefix + dialogalias;
  }

  return dialogalias;
}

mpdialog_value(mpdialogkey, defaultvalue) {
  if(!isDefined(mpdialogkey)) {
    return defaultvalue;
  }

  mpdialog = struct::get_script_bundle("mpdialog", "mpdialog_default");

  if(!isDefined(mpdialog)) {
    return defaultvalue;
  }

  structvalue = mpdialog.(mpdialogkey);

  if(!isDefined(structvalue)) {
    return defaultvalue;
  }

  return structvalue;
}

get_player_dialog_alias(dialogkey, meansofdeath = undefined) {
  if(!isDefined(self)) {
    return undefined;
  }

  bundlename = self getmpdialogname();

  if(isDefined(meansofdeath) && meansofdeath == "MOD_META" && (isDefined(self.pers[#"changed_specialist"]) ? self.pers[#"changed_specialist"] : 0)) {
    bundlename = self.var_89c4a60f;
  }

  if(!isDefined(bundlename)) {
    return undefined;
  }

  playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);

  if(!isDefined(playerbundle)) {
    return undefined;
  }

  return get_dialog_bundle_alias(playerbundle, dialogkey);
}

play_dialog(dialogkey, localclientnum) {
  if(!isDefined(dialogkey) || !isDefined(localclientnum)) {
    return -1;
  }

  dialogalias = self get_player_dialog_alias(dialogkey);

  if(!isDefined(dialogalias)) {
    return -1;
  }

  soundpos = (self.origin[0], self.origin[1], self.origin[2] + 60);

  if(!function_65b9eb0f(localclientnum)) {
    return self playSound(undefined, dialogalias, soundpos);
  }

  voicebox = spawn(localclientnum, self.origin, "script_model");
  self thread update_voice_origin(voicebox);
  voicebox thread delete_after(10);
  return voicebox playSound(undefined, dialogalias, soundpos);
}

update_voice_origin(voicebox) {
  while(true) {
    wait 0.1;

    if(!isDefined(self) || !isDefined(voicebox)) {
      return;
    }

    voicebox.origin = self.origin;
  }
}

delete_after(waittime) {
  wait waittime;
  self delete();
}