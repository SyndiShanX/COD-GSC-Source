/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\battlechatter.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\dialog_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;

#namespace battlechatter;

autoexec __init__system__() {
  system::register(#"battlechatter", &__init__, undefined, undefined);
}

__init__() {
  level.var_2829c23d = &function_50e36ba7;
  level.var_44e74ef4 = &function_f1d27638;
  level.allowbattlechatter[#"bc"] = isDefined(getgametypesetting(#"allowbattlechatter")) && getgametypesetting(#"allowbattlechatter");
  level.allowspecialistdialog = dialog_shared::mpdialog_value("enableHeroDialog", 0) && isDefined(level.allowbattlechatter[#"bc"]) && level.allowbattlechatter[#"bc"];
  level thread function_4bc12499();
}

function_b79dc4e7(player) {
  teammask = getteammask(player.team);

  for(teamindex = 0; teammask > 1; teamindex++) {
    teammask >>= 1;
  }

  if(teamindex % 2) {
    return "blops_taacom";
  }

  return "cdp_taacom";
}

function_4bc12499() {
  level endon(#"death");

  while(true) {
    wait_result = level waittill(#"play_death_vox");
    players = getlocalplayers();
    player = players[0];

    if(isDefined(player)) {
      dialogkey = player get_death_vox(wait_result.mod, wait_result.roleindex);

      if(isDefined(dialogkey) && isDefined(wait_result.body)) {
        wait_result.body playSound(0, dialogkey);
      }
    }
  }
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

function_f1d27638(var_f7f4481f) {
  if(!isDefined(var_f7f4481f) || !isDefined(var_f7f4481f.eventid)) {
    return;
  }

  switch (var_f7f4481f.eventid) {
    case 0:
      thread function_50e36ba7(var_f7f4481f.var_40209f44, var_f7f4481f.weapon, var_f7f4481f.var_3d136cd9, var_f7f4481f.var_7e98b410);
      break;
    case 2:
      thread function_ee8935da(var_f7f4481f.var_3d136cd9);
      break;
    case 3:
    case 4:
    case 5:
      thread function_bf569dab(var_f7f4481f.var_40209f44, var_f7f4481f.var_3d136cd9, var_f7f4481f.eventid, var_f7f4481f.weapon);
      break;
  }
}

get_death_vox(meansofdeath, roleindex) {
  bundlename = function_361aa16d(roleindex);

  if(!isDefined(bundlename)) {
    return;
  }

  if(isDefined(meansofdeath) && meansofdeath == "MOD_META" && (isDefined(self.pers[#"changed_specialist"]) ? self.pers[#"changed_specialist"] : 0)) {
    bundlename = self.var_89c4a60f;
  }

  playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);

  if(!isDefined(playerbundle)) {
    return;
  }

  if(isDefined(meansofdeath)) {
    switch (meansofdeath) {
      case #"mod_unknown":
        return playerbundle.exertdeath;
      case #"mod_burned":
        if(function_fc261b83()) {
          return "";
        } else {
          return playerbundle.exertdeathburned;
        }
      case #"mod_melee_weapon_butt":
        return playerbundle.exertdeathstabbed;
      case #"mod_head_shot":
        return playerbundle.var_207908de;
      case #"mod_falling":
        return playerbundle.var_1dfcabbd;
      case #"mod_drown":
        return playerbundle.exertdeathdrowned;
      case #"mod_explosive":
        return playerbundle.var_44d86dec;
      case #"mod_dot_self":
        return playerbundle.var_48305ed9;
      case #"mod_dot":
        return playerbundle.var_f8b4bcc1;
      case #"mod_melee_assassinate":
        return playerbundle.exertdeathstabbed;
      case #"mod_electrocuted":
        return playerbundle.exertdeathelectrocuted;
    }
  }

  return playerbundle.exertdeath;
}

function_d804d2f0(localclientnum, speakingplayer, player, allyradiussq) {
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

  if(player function_715f2ffc(speakingplayer)) {
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

function_db89c38f(localclientnum, speakingplayer, allyradiussq) {
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

function_d2f35e13(localclientnum, successplayer, weapon, var_6ac148bc, var_5d738b56, seed) {
  while(isDefined(var_6ac148bc) && soundplaying(var_6ac148bc)) {
    waitframe(1);
  }

  wait 0.4;

  if(!isDefined(successplayer)) {
    return;
  }

  successreactionradius = mpdialog_value("SuccessReactionRadius", 500);

  if(function_506f762f(weapon) && isDefined(var_5d738b56) && isplayer(var_5d738b56)) {
    if(function_d804d2f0(localclientnum, successplayer, var_5d738b56, successreactionradius * successreactionradius)) {
      var_8a6b001a = var_5d738b56;
    }
  } else {
    var_8a6b001a = function_db89c38f(localclientnum, successplayer, successreactionradius * successreactionradius);
  }

  if(!isDefined(var_8a6b001a)) {
    return;
  }

  bundlename = var_8a6b001a getmpdialogname();

  if(!isDefined(bundlename)) {
    return;
  }

  playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);

  if(!isDefined(playerbundle)) {
    return;
  }

  var_81485093 = function_6bb302ba(weapon, playerbundle);

  if(!isDefined(var_81485093)) {
    return;
  }

  var_8a6b001a function_4b126e4c(localclientnum, var_81485093, seed);
}

function_20edb636(weapon, playerbundle) {
  returnstruct = spawnStruct();

  switch (weapon.name) {
    case #"hero_annihilator":
      returnstruct.var_17a094cf = playerbundle.annihilatorweaponsuccess;
      break;
    case #"sig_buckler_dw":
    case #"sig_buckler_turret":
      returnstruct.var_17a094cf = playerbundle.var_b8e59ed0;
      returnstruct.startdelay = mpdialog_value("battleshieldSuccessDialogBuffer", 0);
      break;
    case #"claymore":
      returnstruct.var_17a094cf = playerbundle.var_b4d5ca8f;
      break;
    case #"dog_ai_defaultmelee":
      returnstruct.var_17a094cf = playerbundle.var_67888352;
      returnstruct.startdelay = playerbundle.var_aaf0d901;
      break;
    case #"hero_flamethrower":
      returnstruct.var_17a094cf = playerbundle.purifierweaponsuccess;
      returnstruct.startdelay = playerbundle.var_f88f40a;
      break;
    case #"eq_gravityslam":
      returnstruct.var_17a094cf = playerbundle.var_d1c8dc4;
      break;
    case #"gun_mini_turret":
      returnstruct.var_17a094cf = playerbundle.var_3755ba19;
      break;
    case #"sig_bow_quickshot":
      returnstruct.var_17a094cf = playerbundle.sparrowweaponsuccess;
      break;
    case #"hash_5a4932f4b8d8b37a":
      returnstruct.var_17a094cf = playerbundle.var_dc2e66f;
      break;
    case #"shock_rifle":
      returnstruct.var_17a094cf = playerbundle.tempestweaponsuccess;
      break;
    case #"eq_tripwire":
      returnstruct.var_17a094cf = playerbundle.var_eb8b9d7a;
      break;
    case #"hero_pineapplegun":
      returnstruct.var_17a094cf = playerbundle.warmachineweaponsuccess;
      returnstruct.startdelay = mpdialog_value("pineappleGunSuccessDialogBuffer", 0);
      break;
    case #"gadget_health_boost":
    case #"gadget_cleanse":
      returnstruct.var_17a094cf = playerbundle.var_febcf0b;
      break;
    case #"eq_concertina_wire":
      returnstruct.var_17a094cf = playerbundle.var_d5983ddb;
      break;
    case #"eq_swat_grenade":
    case #"hash_3f62a872201cd1ce":
    case #"hash_5825488ac68418af":
      returnstruct.var_17a094cf = playerbundle.var_bd81e586;
      returnstruct.startdelay = mpdialog_value("nineBangSuccessDialogBuffer", 0);
      break;
    case #"eq_grapple":
      returnstruct.var_17a094cf = playerbundle.var_390929f1;
      break;
    case #"molotov_fire":
    case #"eq_molotov":
      returnstruct.var_17a094cf = playerbundle.var_e64f9f9a;
      returnstruct.startdelay = mpdialog_value("playerDialogBuffer", 0);
      break;
    case #"gadget_radiation_field":
      returnstruct.var_17a094cf = playerbundle.var_ad1379f5;
      returnstruct.startdelay = mpdialog_value("radiationFieldPodSuccessDialogBuffer", 0);
      break;
    case #"eq_sensor":
      returnstruct.var_17a094cf = playerbundle.var_ef10cbc3;
      break;
    case #"gadget_supplypod":
      returnstruct.var_17a094cf = playerbundle.var_383d5df3;
      returnstruct.startdelay = mpdialog_value("supplyPodSuccessDialogBuffer", 0);
      break;
    case #"gadget_vision_pulse":
      returnstruct.var_17a094cf = playerbundle.visionpulseabilitysuccess;
      break;
    case #"eq_localheal":
      returnstruct.var_17a094cf = playerbundle.var_74dd2839;
      break;
    case #"gadget_icepick":
      returnstruct.var_17a094cf = playerbundle.var_e870e40c;
      break;
    case #"eq_hawk":
      returnstruct.var_17a094cf = playerbundle.var_bcaf7574;
      returnstruct.startdelay = 1;
      break;
    case #"sig_blade":
      returnstruct.var_17a094cf = playerbundle.var_eb02a29a;
      break;
    case #"eq_smoke":
      returnstruct.var_17a094cf = playerbundle.var_c6ad4957;
      break;
    case #"sig_lmg_alt":
    case #"sig_lmg":
      returnstruct.var_17a094cf = playerbundle.scytheweaponsuccess;
      break;
    case #"eq_shroud":
      returnstruct.var_17a094cf = playerbundle.var_be9a9d3f;
      break;
    default:
      break;
  }

  if(!isDefined(returnstruct.startdelay)) {
    returnstruct.startdelay = mpdialog_value("defaultSuccessResponseBuffer", 0);
  }

  return returnstruct;
}

function_6bb302ba(weapon, playerbundle) {
  switch (weapon.name) {
    case #"hero_annihilator":
      var_cf38843b = playerbundle.var_fc5812eb;
      break;
    case #"sig_buckler_dw":
    case #"sig_buckler_turret":
      var_cf38843b = playerbundle.var_4fa3c4aa;
      break;
    case #"dog_ai_defaultmelee":
      var_cf38843b = playerbundle.var_4ea15dd3;
      break;
    case #"hero_flamethrower":
      var_cf38843b = playerbundle.var_772dbd73;
      break;
    case #"eq_gravityslam":
      var_cf38843b = playerbundle.var_3e1a4fb8;
      break;
    case #"gun_mini_turret":
      var_cf38843b = playerbundle.var_dbd1897a;
      break;
    case #"sig_bow_quickshot4":
      var_cf38843b = playerbundle.var_3841aa5a;
      break;
    case #"hash_5a4932f4b8d8b37a":
      var_cf38843b = playerbundle.var_c518a57;
      break;
    case #"shock_rifle":
    case #"hero_lightninggun":
      var_cf38843b = playerbundle.var_c7859303;
      break;
    case #"eq_tripwire":
      var_cf38843b = playerbundle.var_23b68936;
      break;
    case #"hero_pineapplegun":
      var_cf38843b = playerbundle.var_bbf7c71f;
      break;
    case #"gadget_health_boost":
    case #"gadget_cleanse":
      var_cf38843b = playerbundle.var_26d4d8b3;
      break;
    case #"eq_concertina_wire":
      var_cf38843b = playerbundle.var_54475e1e;
      break;
    case #"gadget_radiation_field":
      var_cf38843b = playerbundle.var_f613c4d1;
      break;
    case #"eq_sensor":
      var_cf38843b = playerbundle.var_f3b38bf6;
      break;
    case #"gadget_supplypod":
      var_cf38843b = playerbundle.var_54c097dc;
      break;
    case #"gadget_vision_pulse":
      var_cf38843b = playerbundle.var_cf906c68;
      break;
    case #"eq_localheal":
      var_cf38843b = playerbundle.var_d32aca42;
      break;
    case #"molotov_fire":
    case #"eq_molotov":
      var_cf38843b = playerbundle.var_140be686;
      break;
    case #"gadget_icepick":
      var_cf38843b = playerbundle.var_c62c0c00;
      break;
    case #"sig_blade":
      var_cf38843b = playerbundle.var_c5a434fd;
      break;
    case #"eq_smoke":
      var_cf38843b = playerbundle.var_568ad856;
      break;
    default:
      break;
  }

  return var_cf38843b;
}

function_506f762f(weapon) {
  switch (weapon.name) {
    case #"gadget_supplypod":
    case #"eq_localheal":
    case #"gadget_health_boost":
    case #"gadget_cleanse":
      return true;
  }

  return false;
}

function_50e36ba7(attacker, weapon, var_5d738b56, seed) {
  if(!isDefined(attacker) || !isplayer(attacker)) {
    return;
  }

  bundlename = attacker getmpdialogname();

  if(!isDefined(bundlename)) {
    return;
  }

  playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);

  if(!isDefined(playerbundle)) {
    return;
  }

  var_39344278 = function_20edb636(weapon, playerbundle);

  if(!isDefined(var_39344278)) {
    return;
  }

  wait var_39344278.startdelay;

  if(!isDefined(var_39344278) || !isDefined(var_39344278.var_17a094cf) || !isDefined(attacker) || !isplayer(attacker)) {
    return;
  }

  var_a874c58 = attacker function_4b126e4c(0, var_39344278.var_17a094cf, seed);

  if(!isDefined(var_a874c58)) {
    return;
  }

  thread function_d2f35e13(0, attacker, weapon, var_a874c58, var_5d738b56, seed);
}

function_5d7ad9a9(hacker, originalowner) {
  if(!isDefined(originalowner) || !isplayer(originalowner) || !originalowner function_21c0fa55()) {
    return false;
  }

  if(!isDefined(hacker) || !isplayer(hacker) || !isalive(hacker)) {
    return false;
  }

  return true;
}

function_c8663dbc(weapon, player) {
  taacombundle = function_84eb6127(player);

  if(!isDefined(taacombundle)) {
    return undefined;
  }

  switch (weapon.name) {
    case #"eq_emp_grenade":
      taacomdialog = "jammerWeaponHacked";
      break;
    case #"eq_tripwire":
      taacomdialog = "meshMineWeaponHacked";
      var_b3fe42a9 = 1;
      break;
    case #"eq_seeker_mine":
      taacomdialog = "seekerMineWeaponHacked";
      var_b3fe42a9 = 1;
      break;
    case #"eq_sensor":
      taacomdialog = "sensorDartHacked";
      var_b3fe42a9 = 1;
      break;
    case #"ability_smart_cover":
    case #"gadget_smart_cover":
      taacomdialog = "smartCoverHacked";
      var_b3fe42a9 = 1;
      break;
    case #"gadget_spawnbeacon":
      taacomdialog = "spawnBeaconHacked";
      break;
    case #"gadget_supplypod":
      taacomdialog = "supplyPodHacked";
      var_b3fe42a9 = 1;
      break;
    case #"trophy_system":
      taacomdialog = "trophyWeaponHacked";
      var_b3fe42a9 = 1;
      break;
    case #"ac130":
    case #"inventory_ac130":
      taacomdialog = "ac130Hacked";
      break;
    case #"ai_tank_marker":
    case #"tank_robot":
    case #"inventory_tank_robot":
      taacomdialog = "aiTankHacked";
      var_b3fe42a9 = 1;
      break;
    case #"helicopter_comlink":
    case #"inventory_helicopter_comlink":
    case #"cobra_20mm_comlink":
      taacomdialog = "attackChopperHacked";
      break;
    case #"counteruav":
      taacomdialog = "cuavHacked";
      var_b3fe42a9 = 1;
      break;
    case #"dart":
    case #"inventory_dart":
      taacomdialog = "dartHacked";
      break;
    case #"inventory_drone_squadron":
    case #"drone_squadron":
      taacomdialog = "droneSquadHacked";
      var_b3fe42a9 = 1;
      break;
    case #"recon_car":
    case #"inventory_recon_car":
      taacomdialog = "reconCarHacked";
      break;
    case #"inventory_remote_missile":
    case #"remote_missile":
      taacomdialog = "hellstormHacked";
      break;
    case #"inventory_planemortar":
    case #"planemortar":
      taacomdialog = "lightningStrikeHacked";
      break;
    case #"overwatch_helicopter":
    case #"inventory_overwatch_helicopter":
      taacomdialog = "overwatchHelicopterHacked";
      break;
    case #"straferun":
    case #"inventory_straferun":
      taacomdialog = "strafeRunHacked";
      break;
    case #"supplydrop":
      taacomdialog = "supplyDropHacked";
      var_b3fe42a9 = 1;
      break;
    case #"uav":
      taacomdialog = "uavHacked";
      var_b3fe42a9 = 1;
      break;
    case #"ultimate_turret":
    case #"inventory_ultimate_turret":
      taacomdialog = "sentryHacked";
      var_b3fe42a9 = 1;
      break;
  }

  if(!isDefined(taacomdialog)) {
    return undefined;
  }

  dialogalias = taacombundle.(taacomdialog);
  return dialogalias;
}

function_84eb6127(player) {
  return struct::get_script_bundle("mpdialog_taacom", function_b79dc4e7(player));
}

function_bf569dab(hacker, originalowner, eventid, weapon) {
  if(!function_5d7ad9a9(hacker, originalowner)) {
    return;
  }

  var_a8aa2745 = function_c8663dbc(weapon, originalowner);

  if(!isDefined(var_a8aa2745)) {
    return;
  }

  var_6ae4c5af = playSound(0, var_a8aa2745);

  if(!isDefined(var_6ae4c5af)) {
    return;
  }

  while(isDefined(var_6ae4c5af) && soundplaying(var_6ae4c5af)) {
    waitframe(1);
  }

  wait 0.1;

  if(!function_5d7ad9a9(hacker, originalowner)) {
    return;
  }

  bundlename = hacker getmpdialogname();

  if(!isDefined(bundlename)) {
    return;
  }

  playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);

  if(!isDefined(playerbundle)) {
    return;
  }

  if(eventid === 3) {
    var_2131493 = playerbundle.var_489ef66b;
  } else if(eventid === 4) {
    var_2131493 = playerbundle.var_5545b3a1;
  } else if(eventid === 5) {
    var_2131493 = playerbundle.var_1037850d;
  }

  if(!isDefined(var_2131493)) {
    return;
  }

  originalowner playSound(0, var_2131493);
}

function_ee8935da(player) {
  if(function_fc261b83()) {
    return;
  }

  commander = "blops_commander";

  if(player.team === #"axis") {
    commander = "cdp_commander";
  }

  commanderbundle = struct::get_script_bundle("mpdialog_commander", commander);

  if(!isDefined(commanderbundle) || !isDefined("gamePlayerKicked")) {
    return;
  }

  dialogalias = commanderbundle.("gamePlayerKicked");

  if(!isDefined(dialogalias)) {
    return;
  }

  voiceprefix = commanderbundle.("voiceprefix");

  if(isDefined(voiceprefix)) {
    dialogalias = voiceprefix + dialogalias;
  }

  if(isDefined(dialogalias)) {
    player playSound(0, dialogalias);
  }
}