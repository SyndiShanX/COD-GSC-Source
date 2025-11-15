/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\weapon_customization_icon.csc
*****************************************************/

#include scripts\core_common\multi_extracam;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace weapon_customization_icon;

autoexec __init__system__() {
  system::register(#"weapon_customization_icon", &__init__, undefined, undefined);
}

__init__() {
  level.extra_cam_wc_paintjob_icon = [];
  level.extra_cam_wc_variant_icon = [];
  level.extra_cam_render_wc_paintjobicon_func_callback = &process_wc_paintjobicon_extracam_request;
  level.extra_cam_render_wc_varianticon_func_callback = &process_wc_varianticon_extracam_request;
  level.weaponcustomizationiconsetup = &wc_icon_setup;
}

wc_icon_setup(localclientnum) {
  level.extra_cam_wc_paintjob_icon[localclientnum] = spawnStruct();
  level.extra_cam_wc_variant_icon[localclientnum] = spawnStruct();
  level thread update_wc_icon_extracam(localclientnum);
}

update_wc_icon_extracam(localclientnum) {
  level endon(#"disconnect");

  while(true) {
    waitresult = level waittill("process_wc_icon_extracam_" + localclientnum);
    setup_wc_weapon_model(localclientnum, waitresult.icon);
    setup_wc_extracam_settings(localclientnum, waitresult.icon);
  }
}

wait_for_extracam_close(localclientnum, camera_ent, extracam_data_struct) {
  level waittill("render_complete_" + localclientnum + "_" + extracam_data_struct.extracamindex);
  multi_extracam::extracam_reset_index(localclientnum, extracam_data_struct.extracamindex);

  if(isDefined(extracam_data_struct.weapon_script_model)) {
    extracam_data_struct.weapon_script_model delete();
  }
}

getxcam(weapon_name, camera) {
  xcam = getweaponxcam(weapon_name, camera);

  if(!isDefined(xcam)) {
    xcam = getweaponxcam(getweapon(#"ar_damage"), camera);
  }

  return xcam;
}

setup_wc_extracam_settings(localclientnum, extracam_data_struct) {
  assert(isDefined(extracam_data_struct.jobindex));

  if(!isDefined(level.camera_ents)) {
    level.camera_ents = [];
  }

  initializedextracam = 0;
  camera_ent = isDefined(level.camera_ents[localclientnum]) ? level.camera_ents[localclientnum][extracam_data_struct.extracamindex] : undefined;

  if(!isDefined(camera_ent)) {
    initializedextracam = 1;

    if(isDefined(struct::get("weapon_icon_staging"))) {
      camera_ent = multi_extracam::extracam_init_index(localclientnum, "weapon_icon_staging", extracam_data_struct.extracamindex);
    } else {
      camera_ent = multi_extracam::extracam_init_item(localclientnum, get_safehouse_position_struct(), extracam_data_struct.extracamindex);
    }
  }

  assert(isDefined(camera_ent));

  if(!isDefined(camera_ent)) {
    return;
  }

  extracam_data_struct.subxcam = "cam_icon";

  if(extracam_data_struct.loadoutslot == "default_camo_render") {
    extracam_data_struct.xcam = "ui_cam_icon_camo_export";
  } else {
    extracam_data_struct.xcam = getxcam(extracam_data_struct.current_weapon, "cam_icon_weapon");
  }

  if(!isDefined(extracam_data_struct.xcam)) {
    extracam_data_struct.xcam = "ui_cam_icon_camo_export";
  }

  position = extracam_data_struct.weapon_position;
  camera_ent playextracamxcam(extracam_data_struct.xcam, 0, extracam_data_struct.subxcam, extracam_data_struct.notetrack, position.origin, position.angles, extracam_data_struct.weapon_script_model, position.origin, position.angles);

  while(!extracam_data_struct.weapon_script_model isstreamed()) {
    waitframe(1);
  }

  if(extracam_data_struct.loadoutslot == "default_camo_render") {
    wait 0.5;
  } else {
    level waittilltimeout(5, "paintshop_ready_" + extracam_data_struct.jobindex);
  }

  setextracamrenderready(extracam_data_struct.jobindex);
  extracam_data_struct.jobindex = undefined;

  if(initializedextracam) {
    level thread wait_for_extracam_close(localclientnum, camera_ent, extracam_data_struct);
  }
}

set_wc_icon_weapon_options(weapon_options_param, extracam_data_struct) {
  weapon_options = strtok(weapon_options_param, ", ");

  if(isDefined(weapon_options) && isDefined(extracam_data_struct.weapon_script_model)) {
    var_eb2e3f90 = 0;

    if(isDefined(weapon_options[3])) {
      var_eb2e3f90 = int(weapon_options[3]);
    }

    extracam_data_struct.weapon_script_model setweaponrenderoptions(int(weapon_options[0]), int(weapon_options[1]), var_eb2e3f90, 0, 0, int(weapon_options[2]), extracam_data_struct.paintjobslot, 1, extracam_data_struct.isfilesharepreview);
  }
}

spawn_weapon_model(localclientnum, origin, angles) {
  weapon_model = spawn(localclientnum, origin, "script_model");

  if(isDefined(angles)) {
    weapon_model.angles = angles;
  }

  weapon_model sethighdetail();
  return weapon_model;
}

get_safehouse_position_struct() {
  position = spawnStruct();
  position.angles = (0, 0, 0);

  switch (util::get_map_name()) {
    default:
      position.origin = (191, 113, -2550);
      break;
  }

  return position;
}

setup_wc_weapon_model(localclientnum, extracam_data_struct) {
  base_weapon_slot = extracam_data_struct.loadoutslot;
  weapon_name = extracam_data_struct.weapon;
  weapon_options_param = extracam_data_struct.weaponoptions;

  if(isDefined(weapon_name)) {
    position = struct::get("weapon_icon_staging");

    if(!isDefined(position)) {
      position = get_safehouse_position_struct();
    }

    if(!isDefined(extracam_data_struct.weapon_script_model)) {
      extracam_data_struct.weapon_script_model = spawn_weapon_model(localclientnum, position.origin, position.angles);
    }

    extracam_data_struct.current_weapon = getweapon(weapon_name);
    extracam_data_struct.weapon_script_model useweaponmodel(extracam_data_struct.current_weapon);
    extracam_data_struct.weapon_position = position;

    if(isDefined(weapon_options_param) && weapon_options_param != "none") {
      set_wc_icon_weapon_options(weapon_options_param, extracam_data_struct);
    }
  }
}

process_wc_paintjobicon_extracam_request(localclientnum, extracamindex, jobindex, weaponoptions, weapon, loadoutslot, paintjobslot, isfilesharepreview) {
  level.extra_cam_wc_paintjob_icon[localclientnum].jobindex = jobindex;
  level.extra_cam_wc_paintjob_icon[localclientnum].extracamindex = extracamindex;
  level.extra_cam_wc_paintjob_icon[localclientnum].weaponoptions = weaponoptions;
  level.extra_cam_wc_paintjob_icon[localclientnum].weapon = weapon;
  level.extra_cam_wc_paintjob_icon[localclientnum].loadoutslot = loadoutslot;
  level.extra_cam_wc_paintjob_icon[localclientnum].paintjobslot = paintjobslot;
  level.extra_cam_wc_paintjob_icon[localclientnum].notetrack = "paintjobpreview";
  level.extra_cam_wc_paintjob_icon[localclientnum].isfilesharepreview = isfilesharepreview;
  level notify("process_wc_icon_extracam_" + localclientnum, {
    #icon: level.extra_cam_wc_paintjob_icon[localclientnum]
  });
}

process_wc_varianticon_extracam_request(localclientnum, extracamindex, jobindex, weaponoptions, weapon, loadoutslot, paintjobslot, isfilesharepreview) {
  level.extra_cam_wc_variant_icon[localclientnum].jobindex = jobindex;
  level.extra_cam_wc_variant_icon[localclientnum].extracamindex = extracamindex;
  level.extra_cam_wc_variant_icon[localclientnum].weaponoptions = weaponoptions;
  level.extra_cam_wc_variant_icon[localclientnum].weapon = weapon;
  level.extra_cam_wc_variant_icon[localclientnum].loadoutslot = loadoutslot;
  level.extra_cam_wc_variant_icon[localclientnum].paintjobslot = paintjobslot;
  level.extra_cam_wc_variant_icon[localclientnum].notetrack = "variantpreview";
  level.extra_cam_wc_variant_icon[localclientnum].isfilesharepreview = isfilesharepreview;
  level notify("process_wc_icon_extracam_" + localclientnum, {
    #icon: level.extra_cam_wc_variant_icon[localclientnum]
  });
}