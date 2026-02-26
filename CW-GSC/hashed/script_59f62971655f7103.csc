/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_59f62971655f7103.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace battlechatter;

function function_b59a25c5(player) {
  if(!is_true(level.var_e444d44)) {
    return undefined;
  }

  playerbundle = function_58c93260(player);

  if(!isDefined(playerbundle)) {
    return undefined;
  }

  return playerbundle.voiceprefix;
}

function function_cdd81094(weapon) {
  if(!is_true(level.var_e444d44)) {
    return undefined;
  }

  assert(isDefined(weapon));

  if(!isDefined(weapon.var_5c238c21)) {
    return undefined;
  }

  return getscriptbundle(weapon.var_5c238c21);
}

function function_b79dc4e7(player) {
  teammask = getteammask(player.team);

  for(teamindex = 0; teammask > 1; teamindex++) {
    teammask >>= 1;
  }

  if(teamindex % 2) {
    return "blops_taacom";
  }

  return "cdp_taacom";
}

function mpdialog_value(mpdialogkey, defaultvalue) {
  if(!isDefined(mpdialogkey)) {
    return defaultvalue;
  }

  if(!is_true(level.var_e444d44)) {
    return defaultvalue;
  }

  mpdialog = getscriptbundle("mpdialog_default");

  if(!isDefined(mpdialog)) {
    return defaultvalue;
  }

  structvalue = mpdialog.(mpdialogkey);

  if(!isDefined(structvalue)) {
    return defaultvalue;
  }

  return structvalue;
}

function function_d804d2f0(localclientnum, speakingplayer, player, allyradiussq) {
  if(!is_true(level.var_e444d44)) {
    return false;
  }

  if(!isDefined(player)) {
    return false;
  }

  if(!isDefined(player.origin)) {
    return false;
  }

  if(!isalive(player)) {
    return false;
  }

  if(player underwater()) {
    return false;
  }

  if(player isdriving(localclientnum)) {
    return false;
  }

  if(function_e75c64a4(localclientnum)) {
    return false;
  }

  if(!isDefined(speakingplayer)) {
    return false;
  }

  if(!isDefined(speakingplayer.origin)) {
    return false;
  }

  if(player == speakingplayer || player.team != speakingplayer.team) {
    return false;
  }

  if(player hasperk(localclientnum, "specialty_quieter")) {
    return false;
  }

  distsq = distancesquared(speakingplayer.origin, player.origin);

  if(distsq > allyradiussq) {
    return false;
  }

  return true;
}

function function_db89c38f(localclientnum, speakingplayer, allyradiussq) {
  if(!is_true(level.var_e444d44)) {
    return undefined;
  }

  allies = [];

  foreach(player in getplayers(localclientnum)) {
    if(!function_d804d2f0(localclientnum, speakingplayer, player, allyradiussq)) {
      continue;
    }

    allies[allies.size] = player;
  }

  allies = arraysort(allies, speakingplayer.origin);

  if(!isDefined(allies) || allies.size == 0) {
    return undefined;
  }

  return allies[0];
}

function function_5d7ad9a9(hacker, originalowner) {
  if(!is_true(level.var_e444d44)) {
    return false;
  }

  if(!isDefined(originalowner) || !isPlayer(originalowner) || !originalowner function_21c0fa55()) {
    return false;
  }

  if(!isDefined(hacker) || !isPlayer(hacker) || !isalive(hacker)) {
    return false;
  }

  return true;
}

function function_84eb6127(player) {
  if(!is_true(level.var_e444d44)) {
    return undefined;
  }

  return getscriptbundle(function_b79dc4e7(player));
}

function get_player_dialog_alias(dialogkey, meansofdeath = undefined) {
  if(!is_true(level.var_e444d44)) {
    return undefined;
  }

  if(!isDefined(self)) {
    return undefined;
  }

  if(is_true(self.var_f16a71ae)) {
    return undefined;
  }

  bundlename = self getmpdialogname();

  if(isDefined(meansofdeath) && meansofdeath == "MOD_META" && (isDefined(self.pers[#"changed_specialist"]) ? self.pers[#"changed_specialist"] : 0)) {
    bundlename = self.var_89c4a60f;
  }

  if(!isDefined(bundlename)) {
    return undefined;
  }

  playerbundle = getscriptbundle(bundlename);

  if(!isDefined(playerbundle)) {
    return undefined;
  }

  return get_dialog_bundle_alias(playerbundle, dialogkey);
}

function get_dialog_bundle_alias(dialogbundle, dialogkey) {
  if(!is_true(level.var_e444d44)) {
    return undefined;
  }

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

function delete_after(waittime) {
  wait waittime;
  self delete();
}

function function_58c93260(player) {
  if(!is_true(level.var_e444d44)) {
    return undefined;
  }

  if(!isPlayer(player)) {
    return undefined;
  }

  bundlename = player getmpdialogname();

  if(!isDefined(bundlename)) {
    return undefined;
  }

  return getscriptbundle(bundlename);
}