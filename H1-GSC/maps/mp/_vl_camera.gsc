/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_vl_camera.gsc
********************************/

init_camera() {
  level.dof_tuner = spawnstruct();
  level.dof_tuner.fstopperunit = 0.25;
  level.dof_tuner.scaler = -0.3;
  level.dof_tuner.fstopbase = 3;
}

setup_camparams() {
  var_0 = spawnstruct();
  var_0.dof_time = 12;
  var_0.gamelobbygroup_camera_normalz = 507;
  var_0.gamelobbygroup_camera_normaldistance = 96.8;
  var_0.pushmode = [];
  var_1 = getdvarint("virtualLobbyMode", 0);

  if(var_1 == 0)
    setdvar("virtualLobbyReady", "0");

  level.camparams = var_0;
}

spawncamera(var_0) {
  var_1 = (-70.7675, -691.293, 507.472);
  var_2 = (0, 87, 0);
  var_3 = common_scripts\utility::getstruct("camera", "targetname");

  if(isdefined(var_3)) {
    var_1 = var_3.origin;
    var_2 = var_3.angles;
  }

  var_4 = spawn("script_model", var_1);
  var_4 setmodel("tag_player");
  var_4.angles = var_2;
  var_4.startorigin = var_1;
  var_4.startangles = var_2;
  var_4.cut = 1;
  var_4.finished = 1;
  var_0.camera = var_4;
  return var_4;
}

cameralink(var_0, var_1) {
  var_1 setorigin(var_0.origin);
  var_1 playerlinkto(var_0, "tag_player");
  var_1 cameralinkto(var_0, "tag_player");
}

playerupdatecamera() {
  self notify("stopCamera");
  var_0 = self;
  var_1 = level.camparams;
  var_2 = level.camparams.camera;

  if(level.in_firingrange) {
    return;
  }
  fixlocalfocus();

  if(var_1.newmode != var_1.mode) {
    if(var_1.newmode == "cac") {
      if(var_1.mode == "cac_weap")
        var_2.cut = 1;
    } else if(var_1.newmode == "game_lobby") {
      var_3 = 0;

      foreach(var_6, var_5 in level.vlavatars) {
        var_3 = var_6;
        break;
      }

      if(var_1.mode == "cao" || var_1.mode == "cac")
        var_2.finished = 1;

      if(isdefined(level.vlavatars) && isdefined(level.vl_focus) && isdefined(level.vlavatars[level.vl_focus]))
        var_0 maps\mp\_vl_base::prep_for_controls(level.vlavatars[level.vl_focus], level.vlavatars[level.vl_focus].angles);

      var_2.cut = 1;
      level.vl_focus = var_3;
      var_7 = level.vlavatars[var_3];
      var_2.avatar_spawnpoint = var_7.avatar_spawnpoint;
    }

    var_1.mode = var_1.newmode;
  }

  if(var_1.mode == "cac") {
    var_7 = level.vlavatars[level.vl_focus];
    maps\mp\_vl_avatar::showavataronly(var_7, 0);
    updatecameracac(var_2, var_1, var_7, 10);
    thread set_avatar_dof_delayed();
  } else if(var_1.mode == "cao") {
    var_7 = level.vlavatars[level.vl_focus];
    maps\mp\_vl_avatar::showavataronly(var_7, 0);
    updatecameracao(var_2, var_1, var_7, 0);
  } else if(var_1.mode == "collections") {
    var_7 = level.vlavatars[level.vl_focus];
    updatecameracollections(var_2, var_1, var_7, 0);
  } else if(var_1.mode == "armory") {
    var_7 = level.vlavatars[level.vl_focus];
    maps\mp\_vl_avatar::showavataronly(var_7, 0);
    updatecameraarmory(var_2, var_1, var_7, 0);
  } else if(var_1.mode == "cac_weap")
    updatecameracacweap(var_2, var_1);
  else if(var_1.mode == "equip") {
    var_7 = level.vlavatars[level.vl_focus];
    maps\mp\_vl_avatar::showavataronly(var_7, 0);
    updatecameraequip(var_2, var_1, var_7, 10);
    thread set_avatar_dof_delayed();
  } else if(var_1.mode == "depot")
    updatecameradepot(var_2, var_1);
  else {
    var_7 = level.vlavatars[level.vl_focus];
    maps\mp\_vl_avatar::showavataronly(var_7, 1);
    maps\mp\_vl_avatar::playerteleportavatartoweaponroom(var_7, var_2, 1);
    updatecameralobby(var_2, var_1, var_7);
    thread setavatarweaponroomdofdelayed(var_7);
  }
}

vl_lighting_setup() {
  var_0 = self;
  var_0 enablephysicaldepthoffieldscripting();
}

setavatarweaponroomdofdelayed(var_0) {
  self endon("playerVlSetPhysicalDepthOfField");
  level.weapon_room_dof = undefined;
  var_1 = weaponclass(var_0.primaryweapon);
  waitframe();
  var_2 = 1;
  var_3 = 120;

  switch (var_1) {
    case "sniper":
      var_2 = 2.7;
      var_3 = 99;
      break;
    case "rifle":
      var_2 = 4;
      var_3 = 96;
      break;
    case "smg":
      var_2 = 2.5;
      var_3 = 111;
      break;
    case "spread":
      var_2 = 2.8;
      var_3 = 114;
      break;
    case "mg":
      var_2 = 3;
      var_3 = 118;
      break;
    default:
      break;
  }

  playervlsetphysicaldepthoffield(var_2, var_3);
}

set_avatar_dof_delayed() {
  self endon("playerVlSetPhysicalDepthOfField");
  waitframe();
  set_avatar_dof();
}

set_avatar_dof(var_0) {
  var_1 = 4;
  var_2 = 100;
  playervlsetphysicaldepthoffield(var_1, var_2);
}

fstop_clamp(var_0) {
  if(var_0 < 0.125)
    var_0 = 0.125;
  else if(var_0 > 128)
    var_0 = 128;

  return var_0;
}

vl_dof_based_on_focus_weap_cac(var_0) {
  var_1 = 0;

  if(maps\mp\_vl_cao::iscollectionsmenuactive())
    var_1 = -0.0740886 * var_0 + 9.45422;
  else
    var_1 = -0.200097 * var_0 + 19.836;

  var_1 = fstop_clamp(var_1);
  playervlsetphysicaldepthoffield(var_1, var_0);
}

playervlsetphysicaldepthoffield(var_0, var_1) {
  var_2 = level.camparams.dof_time;
  self setphysicaldepthoffield(var_0, var_1, var_2, var_2 * 2);
  self notify("playerVlSetPhysicalDepthOfField");
}

fixlocalfocus() {
  if(!isdefined(level.vlavatars[level.vl_focus])) {
    foreach(var_2, var_1 in level.vlavatars) {
      level.vl_focus = var_2;
      break;
    }
  }
}

cammove(var_0, var_1, var_2, var_3) {
  self unlink();

  if(isdefined(self.cut))
    self.origin = var_0;
  else
    self moveto(var_0, var_1, var_2, var_3);
}

camrotate(var_0, var_1, var_2, var_3) {
  if(isdefined(self.cut))
    self.angles = var_0;
  else
    self rotateto(var_0, var_1, var_2, var_3);
}

checkcamposition(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 2;

  var_3 = distance(var_1, var_0.origin);

  if(var_3 >= var_2)
    return 1;
  else
    return 0;
}

updatecamerafinish(var_0) {
  if(isdefined(var_0.cut)) {
    var_0 dontinterpolate();
    var_0.cut = undefined;
  }

  if(getdvarint("virtualLobbyReady", 0) == 0) {
    wait 1.0;
    setdvar("virtualLobbyReady", "1");
    thread maps\mp\_vl_base::setvirtuallobbypresentable();
  }
}

updatecameracacweap(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct("cameraWeapon", "targetname");
  var_0.cut = 1;
  var_0 cammove(var_2.origin);
  var_0 camrotate(var_2.angles);
  updatecamerafinish(var_0);
}

updatecameracac(var_0, var_1, var_2, var_3) {
  var_4 = var_2.avatar_spawnpoint.origin + anglestoforward(var_2.avatar_spawnpoint.angles) * var_1.gamelobbygroup_camera_normaldistance;
  var_5 = (var_4[0], var_4[1], var_1.gamelobbygroup_camera_normalz);
  var_6 = (0, var_2.avatar_spawnpoint.angles[1] + 180 + var_3, 0);
  var_0.cut = 1;
  var_0 cammove(var_5);
  var_0 camrotate(var_6);
  var_0.location = "cac";
  updatecamerafinish(var_0);
}

updatecameracao(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::getstruct("cameraWeapon", "targetname");
  var_0.cut = 1;
  var_0 cammove(var_4.origin);
  var_0 camrotate(var_4.angles);
  var_0.location = "cao";
  updatecamerafinish(var_0);
}

updatecameracollections(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::getstruct("cameraWeapon", "targetname");
  var_0.cut = 1;
  var_0 cammove(var_4.origin);
  var_0 camrotate(var_4.angles);
  var_0.location = "collections";
  updatecamerafinish(var_0);
}

updatecameraarmory(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::getstruct("cameraWeapon", "targetname");
  var_0.cut = 1;
  var_0 cammove(var_4.origin);
  var_0 camrotate(var_4.angles);
  var_0.location = "armory";
  updatecamerafinish(var_0);
}

updatecameraequip(var_0, var_1, var_2, var_3) {
  var_4 = var_2.avatar_spawnpoint.origin + anglestoforward(var_2.avatar_spawnpoint.angles) * var_1.gamelobbygroup_camera_normaldistance;
  var_5 = (var_4[0], var_4[1], var_1.gamelobbygroup_camera_normalz);
  var_6 = (0, var_2.avatar_spawnpoint.angles[1] + 180 + var_3, 0);
  var_0.cut = 1;
  var_0 cammove(var_5);
  var_0 camrotate(var_6);
  var_0.location = "equip";
  updatecamerafinish(var_0);
}

updatecameralobby(var_0, var_1, var_2) {
  var_3 = maps\mp\_vl_base::getweaponroomstring(var_2.primaryweapon);
  var_4 = "camera" + var_3;
  var_5 = common_scripts\utility::getstruct(var_4, "targetname");

  if(!isdefined(var_5.angles)) {
    var_6 = common_scripts\utility::getstruct(var_5.target, "targetname");
    var_7 = var_6.origin - var_5.origin;
    var_5.angles = vectortoangles(var_7);
  }

  var_0.cut = 1;
  maps\mp\_vl_avatar::cameralinktoscenenode(var_0, var_0.scenenode, "j_prop_2");
  var_0.location = "lobby";
  updatecamerafinish(var_0);
}

updatecameradepot(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct("characterBM", "targetname");
  var_0.cut = 1;
  maps\mp\_vl_avatar::cameralinktoscenenode(var_0, var_0.depotsceneent, "tag_origin_animated");
  var_0.location = "depot";
  updatecamerafinish(var_0);
}