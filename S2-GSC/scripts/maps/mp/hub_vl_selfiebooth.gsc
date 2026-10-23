/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\hub_vl_selfiebooth.gsc
**************************************************/

init_selfiebooth() {
  var_0 = common_scripts\utility::getstruct("selfie_player_pos", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 = common_scripts\utility::getstruct(var_1.target, "targetname");
  level.vehicle_planecrash = spawnStruct();
  level.vehicle_planecrash.player_pos = var_0;
  level.vehicle_planecrash.camera_pos = var_2;
  setdvarifuninitialized("scr_vlobby_selfie_correction_y", 32.0);
  setdvarifuninitialized("scr_vlobby_selfie_collision_z", 10.0);
  level thread run_selfiebooth();
}

run_selfiebooth() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player spawnselfieavatar();
  wait 5;

  for(;;) {
    waitframe();

    if(_issystemlink() || !_isonlinegame() || getdvarint("664")) {
      continue;
    }
    if(!should_take_selfie()) {
      continue;
    }
    take_selfie();
  }
}

spawnselfieavatar() {
  while(!isDefined(level.player.spawned_avatar) || !isDefined(level.player.spawned_avatar.costume)) {
    waitframe();
  }

  var_0 = level.vehicle_planecrash.player_pos.origin;
  var_1 = getdvarfloat("scr_vlobby_selfie_collision_z", 0.0);
  var_2 = getdvarfloat("scr_vlobby_selfie_correction_y", 0.0);
  var_3 = (0, var_2, var_1);
  var_0 = var_0 + var_3;
  var_4 = level.vehicle_planecrash.player_pos.angles;
  var_5 = maps\mp\agents\_agent_utility::getfreeagent("selfie_clone");
  var_5.isactive = 1;
  var_5 spawnagent(var_0, var_4, undefined, undefined, undefined, undefined, 1);
  var_6 = level.player getxuid();
  _setentplayerxuidforemblem(var_5, var_6);
  var_5 enableanimstate(1);
  var_5 setanimclass("vlobby_animclass");
  var_5 setanimstate("lobby_idle", "selfie_01", 1.0);
  var_5 set_grenadeammo(level.player.spawned_avatar.costume);
  var_5 linkTo(level.vehicle_planecrash.player_pos);
  level.vehicle_planecrash.clone = var_5;
  self.vehicle_planethrottlereturncontrol = var_5;
}

should_take_selfie() {
  if(!isDefined(level.player)) {
    return 0;
  }

  if(!isDefined(level.player.spawned_avatar) || !isDefined(level.player.spawned_avatar.costume)) {
    return 0;
  }

  if(level.player selfieaccessselfievalidflaginplayerdef()) {
    return 0;
  }

  return 1;
}

take_selfie() {
  if(!isDefined(level.vehicle_planecrash.clone)) {
    return;
  }
  if(!isDefined(level.player)) {
    return;
  }
  if(!isDefined(level.player.spawned_avatar)) {
    return;
  }
  if(!isDefined(level.player.spawned_avatar.costume)) {
    return;
  }
  var_0 = level.vehicle_planecrash.clone.origin;
  var_1 = level.vehicle_planecrash.clone getEye();
  level.vehicle_planecrash.clone set_grenadeammo(level.player.spawned_avatar.costume);
  waitframe();

  if(!level.player selfierequestupdate(level.vehicle_planecrash.camera_pos.origin, var_0, var_1[2] - var_0[2], 0, 0)) {
    return;
  }
  while(isDefined(level.player) && !level.player selfiescreenshottaken()) {
    waitframe();
  }
}