/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\_weapon_customization_icon.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\core\_multi_extracam;
#using scripts\shared\animation_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace weapon_customization_icon;

function autoexec __init__sytem__() {
  system::register("weapon_customization_icon", & __init__, undefined, undefined);
}

function __init__() {
  level.extra_cam_wc_paintjob_icon = [];
  level.extra_cam_wc_variant_icon = [];
  level.extra_cam_render_wc_paintjobicon_func_callback = & process_wc_paintjobicon_extracam_request;
  level.extra_cam_render_wc_varianticon_func_callback = & process_wc_varianticon_extracam_request;
  level.weaponcustomizationiconsetup = & wc_icon_setup;
}

function wc_icon_setup(localclientnum) {
  level.extra_cam_wc_paintjob_icon[localclientnum] = spawnStruct();
  level.extra_cam_wc_variant_icon[localclientnum] = spawnStruct();
  level thread update_wc_icon_extracam(localclientnum);
}

function update_wc_icon_extracam(localclientnum) {
  level endon("disconnect");
  while(true) {
    level waittill("process_wc_icon_extracam_" + localclientnum, extracam_data_struct);
    setup_wc_weapon_model(localclientnum, extracam_data_struct);
    setup_wc_extracam_settings(localclientnum, extracam_data_struct);
  }
}

function wait_for_extracam_close(localclientnum, camera_ent, extracam_data_struct) {
  level waittill((("render_complete_" + localclientnum) + "_") + extracam_data_struct.extracamindex);
  multi_extracam::extracam_reset_index(localclientnum, extracam_data_struct.extracamindex);
  if(isDefined(extracam_data_struct.weapon_script_model)) {
    extracam_data_struct.weapon_script_model delete();
  }
}

function getxcam(weapon_name, camera) {
  xcam = getweaponxcam(weapon_name, camera);
  if(!isDefined(xcam)) {
    xcam = getweaponxcam(getweapon("ar_damage"), camera);
  }
  return xcam;
}

function setup_wc_extracam_settings(localclientnum, extracam_data_struct) {
  assert(isDefined(extracam_data_struct.jobindex));
  if(!isDefined(level.camera_ents)) {
    level.camera_ents = [];
  }
  initializedextracam = 0;
  camera_ent = (isDefined(level.camera_ents[localclientnum]) ? level.camera_ents[localclientnum][extracam_data_struct.extracamindex] : undefined);
  if(!isDefined(camera_ent)) {
    initializedextracam = 1;
    if(isDefined(struct::get("weapon_icon_staging_camera"))) {
      camera_ent = multi_extracam::extracam_init_index(localclientnum, "weapon_icon_staging_camera", extracam_data_struct.extracamindex);
    } else {
      camera_ent = multi_extracam::extracam_init_item(localclientnum, get_safehouse_position_struct(), extracam_data_struct.extracamindex);
    }
  }
  assert(isDefined(camera_ent));
  if(extracam_data_struct.loadoutslot == "default_camo_render") {
    extracam_data_struct.xcam = "ui_cam_icon_camo_export";
    extracam_data_struct.subxcam = "cam_icon";
  } else {
    extracam_data_struct.xcam = getxcam(extracam_data_struct.current_weapon, "cam_icon_weapon");
    extracam_data_struct.subxcam = "cam_icon";
  }
  position = extracam_data_struct.weapon_position;
  camera_ent playextracamxcam(extracam_data_struct.xcam, 0, extracam_data_struct.subxcam, extracam_data_struct.notetrack, position.origin, position.angles, extracam_data_struct.weapon_script_model, position.origin, position.angles);
  while(!extracam_data_struct.weapon_script_model isstreamed()) {
    wait(0.016);
  }
  if(extracam_data_struct.loadoutslot == "default_camo_render") {
    wait(0.5);
  } else {
    level util::waittill_notify_or_timeout("paintshop_ready_" + extracam_data_struct.jobindex, 5);
  }
  setextracamrenderready(extracam_data_struct.jobindex);
  extracam_data_struct.jobindex = undefined;
  if(initializedextracam) {
    level thread wait_for_extracam_close(localclientnum, camera_ent, extracam_data_struct);
  }
}

function set_wc_icon_weapon_options(weapon_options_param, extracam_data_struct) {
  weapon_options = strtok(weapon_options_param, ",");
  if(isDefined(weapon_options) && isDefined(extracam_data_struct.weapon_script_model)) {
    extracam_data_struct.weapon_script_model setweaponrenderoptions(int(weapon_options[0]), int(weapon_options[1]), 0, 0, int(weapon_options[2]), extracam_data_struct.paintjobslot, extracam_data_struct.paintjobindex, 1, extracam_data_struct.isfilesharepreview);
  }
}

function spawn_weapon_model(localclientnum, origin, angles) {
  weapon_model = spawn(localclientnum, origin, "script_model");
  if(isDefined(angles)) {
    weapon_model.angles = angles;
  }
  weapon_model sethighdetail();
  return weapon_model;
}

function set_wc_icon_cosmetic_variants(acv_param, weapon_full_name, extracam_data_struct) {
  acv_indexes = strtok(acv_param, ",");
  i = 0;
  while((i + 1) < acv_indexes.size) {
    extracam_data_struct.weapon_script_model setattachmentcosmeticvariantindex(weapon_full_name, acv_indexes[i], int(acv_indexes[i + 1]));
    i = i + 2;
  }
}

function get_safehouse_position_struct() {
  position = spawnStruct();
  position.angles = (0, 0, 0);
  switch (tolower(getdvarstring("mapname"))) {
    case "cp_sh_cairo": {
      position.origin = (-527, 1569, -25);
      break;
    }
    case "cp_sh_singapore": {
      position.origin = (-1215, 2464, 190);
      break;
    }
    default: {
      position.origin = (191, 113, -2550);
      break;
    }
  }
  return position;
}

function setup_wc_weapon_model(localclientnum, extracam_data_struct) {
  base_weapon_slot = extracam_data_struct.loadoutslot;
  weapon_full_name = extracam_data_struct.weaponplusattachments;
  weapon_options_param = extracam_data_struct.weaponoptions;
  acv_param = extracam_data_struct.attachmentvariantstring;
  if(isDefined(weapon_full_name)) {
    position = struct::get("weapon_icon_staging");
    if(!isDefined(position)) {
      position = get_safehouse_position_struct();
    }
    if(!isDefined(extracam_data_struct.weapon_script_model)) {
      extracam_data_struct.weapon_script_model = spawn_weapon_model(localclientnum, position.origin, position.angles);
    }
    extracam_data_struct.current_weapon = getweaponwithattachments(weapon_full_name);
    if(isDefined(extracam_data_struct.current_weapon.frontendmodel)) {
      extracam_data_struct.weapon_script_model useweaponmodel(extracam_data_struct.current_weapon, extracam_data_struct.current_weapon.frontendmodel);
    } else {
      extracam_data_struct.weapon_script_model useweaponmodel(extracam_data_struct.current_weapon);
    }
    extracam_data_struct.weapon_position = position;
    if(isDefined(acv_param) && acv_param != "none") {
      set_wc_icon_cosmetic_variants(acv_param, weapon_full_name, extracam_data_struct);
    }
    if(isDefined(weapon_options_param) && weapon_options_param != "none") {
      set_wc_icon_weapon_options(weapon_options_param, extracam_data_struct);
    }
  }
}

function process_wc_paintjobicon_extracam_request(localclientnum, extracamindex, jobindex, attachmentvariantstring, weaponoptions, weaponplusattachments, loadoutslot, paintjobindex, paintjobslot, isfilesharepreview) {
  level.extra_cam_wc_paintjob_icon[localclientnum].jobindex = jobindex;
  level.extra_cam_wc_paintjob_icon[localclientnum].extracamindex = extracamindex;
  level.extra_cam_wc_paintjob_icon[localclientnum].attachmentvariantstring = attachmentvariantstring;
  level.extra_cam_wc_paintjob_icon[localclientnum].weaponoptions = weaponoptions;
  level.extra_cam_wc_paintjob_icon[localclientnum].weaponplusattachments = weaponplusattachments;
  level.extra_cam_wc_paintjob_icon[localclientnum].loadoutslot = loadoutslot;
  level.extra_cam_wc_paintjob_icon[localclientnum].paintjobindex = paintjobindex;
  level.extra_cam_wc_paintjob_icon[localclientnum].paintjobslot = paintjobslot;
  level.extra_cam_wc_paintjob_icon[localclientnum].notetrack = "paintjobpreview";
  level.extra_cam_wc_paintjob_icon[localclientnum].isfilesharepreview = isfilesharepreview;
  level notify("process_wc_icon_extracam_" + localclientnum, level.extra_cam_wc_paintjob_icon[localclientnum]);
}

function process_wc_varianticon_extracam_request(localclientnum, extracamindex, jobindex, attachmentvariantstring, weaponoptions, weaponplusattachments, loadoutslot, paintjobindex, paintjobslot, isfilesharepreview) {
  level.extra_cam_wc_variant_icon[localclientnum].jobindex = jobindex;
  level.extra_cam_wc_variant_icon[localclientnum].extracamindex = extracamindex;
  level.extra_cam_wc_variant_icon[localclientnum].attachmentvariantstring = attachmentvariantstring;
  level.extra_cam_wc_variant_icon[localclientnum].weaponoptions = weaponoptions;
  level.extra_cam_wc_variant_icon[localclientnum].weaponplusattachments = weaponplusattachments;
  level.extra_cam_wc_variant_icon[localclientnum].loadoutslot = loadoutslot;
  level.extra_cam_wc_variant_icon[localclientnum].paintjobindex = paintjobindex;
  level.extra_cam_wc_variant_icon[localclientnum].paintjobslot = paintjobslot;
  level.extra_cam_wc_variant_icon[localclientnum].notetrack = "variantpreview";
  level.extra_cam_wc_variant_icon[localclientnum].isfilesharepreview = isfilesharepreview;
  level notify("process_wc_icon_extracam_" + localclientnum, level.extra_cam_wc_variant_icon[localclientnum]);
}