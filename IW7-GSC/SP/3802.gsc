/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3802.gsc
**************************************/

#using_animtree("generic_human");

_id_3739() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["idle"] = % titan_lz_dropship_call_mco_smoke_idle;
  var_0._id_EBEA["angles"] = [105, 135, 165, 195, 225, 255];
  var_0._id_EBEA[105] = % titan_lz_dropship_call_mco_call_r90;
  var_0._id_EBEA[135] = % titan_lz_dropship_call_mco_call_r120;
  var_0._id_EBEA[165] = % titan_lz_dropship_call_mco_call_r150;
  var_0._id_EBEA[195] = % titan_lz_dropship_call_mco_call_l180;
  var_0._id_EBEA[225] = % titan_lz_dropship_call_mco_call_l150;
  var_0._id_EBEA[255] = % titan_lz_dropship_call_mco_call_l120;
  var_0._id_EBEA["lastanim"] = % titan_lz_dropship_call_mco_call_l00;
  var_0._id_EBEA["trigger_radius"] = 4000;
  scripts\sp\interaction::register_interaction("titan_beacon_call_scene", var_0);
}

_id_10372() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["idle"] = % titan_lz_dropship_call_mco_smoke_idle;
  var_0._id_EBEA["angles"] = [105, 135, 165, 195, 225, 255];
  var_0._id_EBEA[45] = % titan_lz_dropship_call_mco_smoke_r30;
  var_0._id_EBEA[75] = % titan_lz_dropship_call_mco_smoke_r60;
  var_0._id_EBEA[105] = % titan_lz_dropship_call_mco_smoke_r90;
  var_0._id_EBEA[135] = % titan_lz_dropship_call_mco_smoke_r120;
  var_0._id_EBEA[165] = % titan_lz_dropship_call_mco_smoke_r150;
  var_0._id_EBEA[195] = % titan_lz_dropship_call_mco_smoke_l180;
  var_0._id_EBEA[225] = % titan_lz_dropship_call_mco_smoke_l150;
  var_0._id_EBEA[290] = % titan_lz_dropship_call_mco_smoke_l90;
  var_0._id_EBEA[320] = % titan_lz_dropship_call_mco_smoke_l60;
  var_0._id_EBEA[345] = % titan_lz_dropship_call_mco_smoke_l30;
  var_0._id_EBEA[255] = % titan_lz_dropship_call_mco_smoke_l120;
  var_0._id_EBEA["lastanim"] = % titan_lz_dropship_call_mco_smoke_l00;
  var_0._id_EBEA["trigger_radius"] = 2000;
  scripts\sp\interaction::register_interaction("titan_beacon_smoke_scene", var_0);
  scripts\sp\anim::_id_17F6("omar", "beacon_attach", ::_id_29DD, "titan_beacon_smoke_scene");
  scripts\sp\anim::_id_17F6("omar", "beacon_attach2", ::_id_29DD, "titan_beacon_smoke_scene");
  scripts\sp\anim::_id_17F6("omar", "beacon_detach", ::_id_2A0F, "titan_beacon_smoke_scene");
  scripts\sp\anim::_id_17F6("omar", "beacon_detach2", ::_id_2A0F, "titan_beacon_smoke_scene");
}

_id_29DD(var_0) {
  var_1 = "j_thumb_ri_2";
  var_0._id_29D7 = spawn("script_model", var_0 gettagorigin(var_1));
  var_0._id_29D7.angles = var_0 gettagangles(var_1);
  var_0._id_29D7 linkTo(var_0, var_1);
  var_0._id_29D7 setModel("emp_grenade_wm");
}

_id_2A0F(var_0) {
  if(isDefined(self._id_117EF))
    var_1 = scripts\engine\utility::getStruct("apc_dropoff_anim_ent2", "targetname").origin;
  else
    var_1 = scripts\engine\utility::getStruct("apc_dropoff_anim_ent", "targetname").origin;

  self._id_117EF = 1;
  var_2 = "j_thumb_ri_2";
  var_3 = spawn("script_model", var_0 gettagorigin(var_2));
  var_3.angles = var_0 gettagangles(var_2);
  var_4 = var_1 + (0, 0, 200);
  var_5 = var_3.origin;
  var_6 = vectorNormalize(var_4 - var_5);
  var_7 = var_6 * 1900;
  var_3 setModel("emp_grenade_wm");
  var_0._id_29D7 delete();
  playFXOnTag(scripts\engine\utility::getfx("vfx_beacon_light"), var_3, "tag_fx");
  var_3 playLoopSound("scn_titan_beacon_lp");
  var_3 physicslaunchserver(var_3.origin, var_7);
  wait 2;
  var_8 = scripts\engine\utility::getStructArray("beacon_holo", "targetname");
  var_9 = scripts\engine\utility::getclosest(var_3.origin, var_8);
  var_9._id_29D7 = var_3;
  wait 17;
  var_3 _meth_8278(0.07, 3.0);
}