/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_deck_victory.gsc
*****************************************/

deck_victory_pre_load() {
  common_scripts\utility::flag_init("victory");
  common_scripts\utility::flag_init("victory_music");
  common_scripts\utility::flag_init("victory_music_stop");
  common_scripts\utility::flag_init("rog_hit");
  common_scripts\utility::flag_init("deck_victory_finished");
  common_scripts\utility::flag_init("rog_reaction");
  common_scripts\utility::flag_init("clear_ladder");
  common_scripts\utility::flag_init("victory_player_done");
  precacheshellshock("hijack_engine_explosion");
  level.deck_victory_triggers = getEntArray("deck_victory_triggers", "targetname");
  common_scripts\utility::array_thread(level.deck_victory_triggers, maps\_utility::hide_entity);
}

setup_deck_victory() {
  level.start_point = "deck_victory";
  maps\carrier_code::setup_common(1);
  maps\carrier_code::spawn_allies();
  thread maps\carrier_defend_sparrow::sparrow_handle_ps4_ssao(1);
  level.player notify("remove_sam_control");
  thread maps\carrier_audio::aud_check("victory_deck");
  common_scripts\utility::waitframe();
  var_0 = getent("sparrow_launcher_damage", "targetname");
  var_0 maps\_utility::show_entity();
  var_1 = getent("water_wake_intro", "targetname");
  var_1 delete();
}

catchup_deck_victory() {}

begin_deck_victory() {
  level endon("player_failed_gunship");
  level.player endon("death");
  common_scripts\utility::array_thread(level.deck_victory_triggers, maps\_utility::show_entity);
  thread run_hesh_vo();
  thread victory_player();
  thread run_hesh();
  thread victory_ac130();
  common_scripts\utility::flag_set("victory_music");

  if(isDefined(level.ac_130))
    level.ac_130 notify("victory_start");

  wait 5;
  thread maps\carrier_code::phalanx_gun_offline("crr_phalanx_01");
  thread maps\carrier_code::phalanx_gun_offline("crr_phalanx_02");
  thread maps\carrier_code::phalanx_gun_offline("crr_phalanx_03");
  thread maps\carrier_code::phalanx_gun_offline("crr_phalanx_04");
  thread maps\carrier_code::phalanx_gun_offline("crr_phalanx_05");
  common_scripts\utility::flag_set("victory_music_stop");
  common_scripts\utility::flag_wait("deck_victory_finished");
  thread cleanup_vehicles();
}

victory_player() {
  level.player endon("death");
  level endon("player_failed_gunship");
  var_0 = common_scripts\utility::getstruct("sparrow_run_animnode", "targetname");
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  var_1 hide();
  var_0 maps\_anim::anim_first_frame_solo(var_1, "carrier_deck_victory_player");
  level.player playerlinktoblend(var_1, "tag_player", 0.4, 0.25, 0);
  level.player disableweapons();
  level.player disableweaponpickup();
  level.player takeallweapons();
  level.player allowfire(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  var_0 thread maps\_anim::anim_single_solo(var_1, "carrier_deck_victory_player");
  wait 0.4;
  var_1 show();
  level.player playerlinktodelta(var_1, "tag_player", 0, 10, 10, 10, 5);
  wait 1.75;
  wait 7.25;
  level.player giveweapon("msbs+eotech_sp");
  level.player switchtoweapon("msbs+eotech_sp");
  level.player enableweapons();
  level.player disableweaponswitch();
  var_1 waittillmatch("single anim", "end");
  level.player setstance("stand");
  level.player unlink();
  level.player allowfire(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowjump(1);
  var_1 delete();
  common_scripts\utility::flag_wait("pre_deck_tilt_save");
  thread maps\_utility::autosave_now();
}

run_hesh() {
  level.player endon("death");
  level endon("player_failed_gunship");
  var_0 = getnode("hesh_deck_tilt_start", "targetname");
  level.hesh allowedstances("stand");
  level.hesh setgoalpos(level.hesh.origin);
  level.hesh setgoalnode(var_0);
  level.hesh.a.pose = "stand";
  var_1 = common_scripts\utility::getstruct("sparrow_run_animnode", "targetname");
  var_1 maps\_anim::anim_single_solo(level.hesh, "carrier_deck_victory_hesh");
  common_scripts\utility::flag_set("deck_victory_finished");
}

run_hesh_vo() {
  level.player endon("death");
  level endon("player_failed_gunship");
  maps\_utility::smart_radio_dialogue("carrier_com_transportsareawayand");
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_niceshootingloganthe");
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_commandhaveyougot");
  maps\_utility::smart_radio_dialogue("carrier_com_affirmativestalkerviper6");
}

victory_back_vo() {
  maps\_utility::smart_radio_dialogue("carrier_com_transportsareawayand");
  maps\_utility::smart_radio_dialogue("carrier_com_noradhasmultipleinbound");
}

victory_ac130() {
  level.player endon("death");
  level endon("player_failed_gunship");
  wait 1.5;
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("victory_ac130");
  var_1 = var_0 common_scripts\utility::spawn_tag_origin();
  var_2 = var_0 common_scripts\utility::spawn_tag_origin();

  if(isDefined(level.first_gunship_wing) && level.first_gunship_wing == "left1") {
    var_1.origin = var_0 gettagorigin("tag_fx_engine_le_1");
    var_1.angles = var_0 gettagangles("tag_fx_engine_le_1");
    var_1.angles = var_1.angles;
    var_1 linkto(var_0, "tag_fx_engine_le_1");
    playFXOnTag(common_scripts\utility::getfx("vfx_ac130_engine_fire"), var_1, "tag_origin");
  } else {
    var_1.origin = var_0 gettagorigin("tag_fx_engine_ri_1");
    var_1.angles = var_0 gettagangles("tag_fx_engine_ri_1");
    var_1.angles = var_1.angles;
    var_1 linkto(var_0, "tag_fx_engine_ri_1");
    playFXOnTag(common_scripts\utility::getfx("vfx_ac130_engine_fire"), var_1, "tag_origin");
  }

  if(isDefined(level.second_gunship_wing) && level.second_gunship_wing == "right2") {
    var_2.origin = var_0 gettagorigin("tag_fx_engine_ri_2");
    var_2.angles = var_0 gettagangles("tag_fx_engine_ri_2");
    var_2.angles = var_2.angles;
    var_2 linkto(var_0, "tag_fx_engine_ri_2");
    playFXOnTag(common_scripts\utility::getfx("vfx_ac130_engine_fire"), var_2, "tag_origin");
  } else {
    var_2.origin = var_0 gettagorigin("tag_fx_engine_le_2");
    var_2.angles = var_0 gettagangles("tag_fx_engine_le_2");
    var_2.angles = var_2.angles;
    var_2 linkto(var_0, "tag_fx_engine_le_2");
    playFXOnTag(common_scripts\utility::getfx("vfx_ac130_engine_fire"), var_2, "tag_origin");
  }

  var_0 waittill("reached_dynamic_path_end");
  stopFXOnTag(common_scripts\utility::getfx("vfx_ac130_engine_fire"), var_1, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("vfx_ac130_engine_fire"), var_2, "tag_origin");
  var_0 delete();
  common_scripts\utility::waitframe();
  var_1 delete();
  var_2 delete();
}

destroy_all_enemy_vehicles() {
  var_0 = vehicle_getarray();

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2) && isDefined(var_2.script_team) && var_2.script_team == "axis") {
      if(isDefined(var_2.vehicletype) && var_2 maps\_vehicle::ishelicopter()) {
        var_2 delete();
        continue;
      }

      if(isDefined(var_2.vehicletype) && var_2 maps\_vehicle::isairplane())
        var_2 notify("damage", 5000, level.player, (0, 0, 0), (0, 0, 0), "MOD_PROJECTILE");
    }
  }
}

cleanup_vehicles() {
  var_0 = vehicle_getarray();

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}