/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7b8639f512d4cfe4.gsc
***********************************************/

main() {
  _id_C25A40AE517EF340();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("usable_left", ::_id_E8E4BB2F83E5055A);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("usable_right", ::_id_E8E4BB2F83E5055A);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("usable_front", ::_id_E8E4BB2F83E5055A);
}

_id_A6891C3D100A6A05(_id_C327ADFAD89EFC23, player, dir) {
  level endon("game_ended");
  _id_C327ADFAD89EFC23 setscriptablepartstate("usable_left", "unusable");
  _id_C327ADFAD89EFC23 setscriptablepartstate("usable_front", "unusable");
  _id_C327ADFAD89EFC23 setscriptablepartstate("usable_right", "unusable");
  _id_C327ADFAD89EFC23.scenenode = spawnStruct();
  _id_C327ADFAD89EFC23.scenenode.origin = _id_C327ADFAD89EFC23.origin;
  _id_C327ADFAD89EFC23.scenenode.angles = _id_C327ADFAD89EFC23.angles;

  if(isDefined(level._id_187BFF90AA51742F)) {
    if(isDefined(player))
      player thread[[level._id_187BFF90AA51742F]]();
  }

  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "player_rig", 1);
  c4 = spawn("script_model", actorplayer.entity gettagorigin("tag_accessory_right"));
  c4 hide();
  c4.angles = actorplayer.entity gettagangles("tag_accessory_right");
  c4 dontinterpolate();
  c4 linkTo(actorplayer.entity, "tag_accessory_right");
  c4 setModel("offhand_2h_c4_prop_cp");
  thread _id_DABFDF04F879BC4F(c4);
  c4 thread _id_E9508A0DB7CC3E83();

  if(dir == "right")
    _id_C327ADFAD89EFC23.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer], "samsite_plant_l");
  else if(dir == "left")
    _id_C327ADFAD89EFC23.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer], "samsite_plant_r");
  else
    _id_C327ADFAD89EFC23.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer], "samsite_plant_f");

  c4 unlink();
  actorplayer = undefined;
  _id_2CE69F8431572669 = undefined;

  if(isDefined(level._id_D73F1DD12F69B96E)) {
    if(isDefined(player))
      player thread[[level._id_D73F1DD12F69B96E]]();
  }

  _id_236A1FE93E41C498(c4);
  c4 setscriptablepartstate("effects", "explode");

  if(isDefined(level._id_FA3F2CEF70B746CF)) {
    if(isDefined(player))
      player thread[[level._id_FA3F2CEF70B746CF]]();
  }

  wait 0.5;
  c4 delete();
}

_id_E9508A0DB7CC3E83() {
  wait 1;

  if(soundexists("weap_samsite_plant_c4"))
    self playSound("weap_samsite_plant_c4");
}

_id_DABFDF04F879BC4F(c4) {
  c4 endon("death");
  wait 1;
  c4 show();
}

_id_E8E4BB2F83E5055A(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  dir = "left";

  if(part == "usable_right")
    dir = "right";
  else if(part == "usable_front")
    dir = "front";

  _id_A6891C3D100A6A05(instance, player, dir);
}

_id_236A1FE93E41C498(c4) {
  currenttime = gettime();
  _id_F28399727742EB23 = int(currenttime + 5000);
  _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

  while(_id_C301D652D9A73075 > 0) {
    currenttime = gettime();
    _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

    if(_id_C301D652D9A73075 < 1500) {
      if(_id_C301D652D9A73075 <= 250) {
        if(soundexists("breach_warning_beep_05"))
          c4 playSound("breach_warning_beep_05");
      } else if(_id_C301D652D9A73075 < 500) {
        if(soundexists("breach_warning_beep_04"))
          c4 playSound("breach_warning_beep_04");
      } else if(_id_C301D652D9A73075 < 1500) {
        if(soundexists("breach_warning_beep_03"))
          c4 playSound("breach_warning_beep_03");
      } else if(soundexists("breach_warning_beep_02"))
        c4 playSound("breach_warning_beep_02");

      wait 0.25;
    } else if(_id_C301D652D9A73075 < 3500) {
      if(soundexists("breach_warning_beep_02"))
        c4 playSound("breach_warning_beep_02");

      wait 0.5;
    } else {
      if(soundexists("breach_warning_beep_01"))
        c4 playSound("breach_warning_beep_01");

      wait 1.0;
    }

    if(_id_C301D652D9A73075 < 0) {
      break;
    }
  }
}

#using_animtree("script_model");

_id_C25A40AE517EF340() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["samsite_plant_l"] = % iw9_sam_breach_charge_left;
  level.scr_animname["player_rig"]["samsite_plant_l"] = "iw9_sam_breach_charge_left";
  level.scr_eventanim["player_rig"]["samsite_plant_l"] = "iw9_sam_breach_charge_left";
  level.scr_anim["player_rig"]["samsite_plant_r"] = % iw9_sam_breach_charge_right;
  level.scr_animname["player_rig"]["samsite_plant_r"] = "iw9_sam_breach_charge_right";
  level.scr_eventanim["player_rig"]["samsite_plant_r"] = "iw9_sam_breach_charge_right";
  level.scr_anim["player_rig"]["samsite_plant_f"] = % iw9_cp_sam_breach_charge_front;
  level.scr_animname["player_rig"]["samsite_plant_f"] = "iw9_cp_sam_breach_charge_front";
  level.scr_eventanim["player_rig"]["samsite_plant_f"] = "iw9_sam_breach_charge_front";
  level.scr_animtree["c4_prop"] = #animtree;
  level.scr_anim["c4_prop"]["samsite_plant_l"] = % iw9_cp_sam_breach_charge_left_c4;
  level.scr_animname["c4_prop"]["samsite_plant_l"] = "iw9_cp_sam_breach_charge_left_c4";
  level.scr_anim["c4_prop"]["samsite_plant_r"] = % iw9_cp_sam_breach_charge_right_c4;
  level.scr_animname["c4_prop"]["samsite_plant_r"] = "iw9_cp_sam_breach_charge_right_c4";
  level.scr_anim["c4_prop"]["samsite_plant_f"] = % iw9_cp_sam_breach_charge_front_c4;
  level.scr_animname["c4_prop"]["samsite_plant_f"] = "iw9_cp_sam_breach_charge_front_c4";
}