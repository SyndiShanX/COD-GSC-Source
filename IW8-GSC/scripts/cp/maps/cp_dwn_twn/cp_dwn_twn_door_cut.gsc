/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_door_cut.gsc
**************************************************************/

function door_cut_precache() {
  level._effect["saw_sparks"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_cp_saw_sparks.vfx");
}

function main(var_0) {
  cutout_door_main();
  wait_for_door_cut();
  thread break_door();
}

function cutout_door_main() {
  init_cutout_anims();
  level.door_cut_interactions = [];
  level.vault_door_broken = 0;
  var_0 = scripts\engine\utility::getStructArray("vault_door_cut_interaction", "targetname");

  foreach(var_2 in var_0) {
    var_3 = create_cut_interactions(var_2);

    if(isDefined(var_3)) {
      level.door_cut_interactions[level.door_cut_interactions.size] = var_3;
    }
  }

  foreach(var_6 in level.door_cut_interactions) {
    if(isDefined(var_6)) {
      var_6 makeusable();
    }
  }

  var_8 = getEnt("vault_gate_door_clip", "targetname");
  var_8 disconnectPaths();
}

function break_door() {
  var_0 = getEnt("vault_gate_door_clip", "targetname");
  var_1 = getEnt("vault_gate_door", "targetname");
  var_1 rotateby((90, 0, 0), 0.45);
  wait 0.4;
  var_1 playSound("cp_bank_gate_fall");
  var_0 connectpaths();
  var_0 notsolid();
  thread bank_alarm_sfx();
  level.vault_door_broken = 1;
}

function bank_alarm_sfx() {
  var_0 = spawn("script_origin", (5040, 854, 41));
  var_1 = spawn("script_origin", (3940, 1853, 180));
  var_2 = spawn("script_origin", (5404, 809, 42));
  var_3 = spawn("script_origin", (3742, 870, 184));
  var_4 = spawn("script_origin", (5452, 213, 435));
  wait 0.05;
  var_0 playLoopSound("emt_alarm_bank_bell_lp");
  var_1 playLoopSound("emt_alarm_bank_bell_lp");
  var_2 playLoopSound("emt_alarm_bank_bell_lp");
  var_3 playLoopSound("emt_alarm_bank_bell_lp");
  var_4 playLoopSound("emt_alarm_bank_bell_lp");
  scripts\engine\utility::flag_wait("init_roof_combat");

  if(isDefined(var_0)) {
    var_0 stoploopsound("emt_alarm_bank_bell_lp");
    var_0 delete();
  }

  if(isDefined(var_1)) {
    var_1 stoploopsound("emt_alarm_bank_bell_lp");
    var_1 delete();
  }

  if(isDefined(var_2)) {
    var_2 stoploopsound("emt_alarm_bank_bell_lp");
    var_2 delete();
  }

  if(isDefined(var_3)) {
    var_3 stoploopsound("emt_alarm_bank_bell_lp");
    var_3 delete();
  }

  if(isDefined(var_4)) {
    var_4 stoploopsound("emt_alarm_bank_bell_lp");
    var_4 delete();
    return;
  }
}

function wait_for_door_cut(var_0) {
  level endon("end_door_cut_wait");
  level.waiting_for_door_cut = 1;
  level.ref_140f6 = 0;

  for(;;) {
    level waittill("gate_cut");
    level.ref_140f6++;

    if(level.ref_140f6 >= level.door_cut_interactions.size) {
      level notify("saws_have_been_used");
      scripts\engine\utility::flag_set("saws_have_been_used");

      foreach(var_2 in level.players) {
        var_2 notify("drop_saw");
      }

      break;
    }
  }
}

#using_animtree("");

function init_cutout_anims() {
  level.scr_animtree["cutter_player"] = #animtree;
  level.scr_anim["cutter_player"]["pullout"] = $sdr_cp_hostage_cutout_blima_dst_pullout_player;
  level.scr_animname["cutter_player"]["pullout"] = "sdr_cp_hostage_cutout_blima_dst_pullout_player";
  level.scr_eventanim["cutter_player"]["pullout"] = "pullout_saw";
  level.scr_anim["cutter_player"]["putaway"] = % sdr_cp_hostage_cutout_blima_dst_putaway_player;
  level.scr_animname["cutter_player"]["putaway"] = "sdr_cp_hostage_cutout_blima_dst_putaway_player";
  level.scr_eventanim["cutter_player"]["putaway"] = "putaway_saw";
  level.scr_anim["cutter_player"]["cut_1"] = % sdr_cp_hostage_cutout_blima_dst_1_player;
  level.scr_animname["cutter_player"]["cut_1"] = "sdr_cp_hostage_cutout_blima_dst_1_player";
  level.scr_eventanim["cutter_player"]["cut_1"] = "player_cut_1";
  level.scr_anim["cutter_player"]["cut_2"] = % sdr_cp_hostage_cutout_blima_dst_2_player;
  level.scr_animname["cutter_player"]["cut_2"] = "sdr_cp_hostage_cutout_blima_dst_2_player";
  level.scr_eventanim["cutter_player"]["cut_2"] = "player_cut_2";
  level.scr_anim["cutter_player"]["cut_3"] = % sdr_cp_hostage_cutout_blima_dst_3_player;
  level.scr_animname["cutter_player"]["cut_3"] = "sdr_cp_hostage_cutout_blima_dst_3_player";
  level.scr_eventanim["cutter_player"]["cut_3"] = "player_cut_3";
  level.scr_anim["cutter_player"]["cut_4"] = % sdr_cp_hostage_cutout_blima_dst_4_player;
  level.scr_animname["cutter_player"]["cut_4"] = "sdr_cp_hostage_cutout_blima_dst_4_player";
  level.scr_eventanim["cutter_player"]["cut_4"] = "player_cut_4";
  level.scr_anim["cutter_player"]["hvt_cockpit_pickup"] = % sdr_cp_hostage_pickup_blimadestroyed_player;
  level.scr_animname["cutter_player"]["hvt_cockpit_pickup"] = "sdr_cp_hostage_pickup_blimadestroyed_player";
  level.scr_eventanim["cutter_player"]["hvt_cockpit_pickup"] = "hvt_cockpit_pickup";
  level.scr_viewmodelanim["cutter_player"]["hvt_cockpit_pickup"] = "vm_hostage_pickup_blimadestroyed_player";
  level.scr_animtree["saw"] = #animtree;
  level.scr_anim["saw"]["pullout"] = % sdr_cp_hostage_cutout_blima_dst_pullout_saw;
  level.scr_animname["saw"]["pullout"] = "sdr_cp_hostage_cutout_blima_dst_pullout_saw";
  level.scr_anim["saw"]["putaway"] = % sdr_cp_hostage_cutout_blima_dst_putaway_saw;
  level.scr_animname["saw"]["putaway"] = "sdr_cp_hostage_cutout_blima_dst_putaway_saw";
  level.scr_anim["saw"]["cut_1"] = % sdr_cp_hostage_cutout_blima_dst_1_saw;
  level.scr_animname["saw"]["cut_1"] = "sdr_cp_hostage_cutout_blima_dst_1_saw";
  level.scr_anim["saw"]["cut_2"] = % sdr_cp_hostage_cutout_blima_dst_2_saw;
  level.scr_animname["saw"]["cut_2"] = "sdr_cp_hostage_cutout_blima_dst_2_saw";
  level.scr_anim["saw"]["cut_3"] = % sdr_cp_hostage_cutout_blima_dst_3_saw;
  level.scr_animname["saw"]["cut_3"] = "sdr_cp_hostage_cutout_blima_dst_3_saw";
  level.scr_anim["saw"]["cut_4"] = % sdr_cp_hostage_cutout_blima_dst_4_saw;
  level.scr_animname["saw"]["cut_4"] = "sdr_cp_hostage_cutout_blima_dst_4_saw";
}

function cut_vault_gate(var_0, var_1) {
  var_0.ref_140ae = 1;
  var_2 = getcompleteweaponname("iw8_gunless_infil");
  var_0 scripts\cp\utility::_giveweapon(var_2, undefined, undefined, 1);
  var_3 = var_0 scripts\cp\cp_weapons::switchtoweaponreliable(var_2, 0);
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0 scripts\common\utility::allow_weapon_pickup(0);
  objective_pinforclient(level.cut_progress_objective, var_0);
  var_4 = getstartorigin(self.origin, self.angles, level.scr_anim["cutter_player"][var_1]);
  var_5 = getstartangles(self.origin, self.angles, level.scr_anim["cutter_player"][var_1]);
  var_0 setOrigin(var_4, 1);
  var_0 setplayerangles(var_5);
  var_0 setstance("stand");
  var_0 cameraset("camera_custom_orbit_2_cp");
  var_6 = spawn("script_model", self.origin);
  var_6 setModel("tool_portable_gas_cutter_01_cp");
  var_6.angles = self.angles;
  var_6.animname = "saw";
  var_6 hide();
  var_0 forceusehinton(&"CP_BR_SYRK_OBJECTIVES/CUT_HINT");
  var_6 useanimtree(level.scr_animtree["saw"]);
  var_0 thread scripts\cp\cp_destruction::create_player_rig(var_0, "cutter_player");
  var_3 = wait_for_section_cut(var_0, var_6, var_1);
  var_0 cameradefault();
  var_0 forceusehintoff();
  objective_unpinforclient(level.cut_progress_objective, var_0);
  wait 1;
  var_6 delete();
  scripts\cp\cp_destruction::remove_player_rig(var_0);
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0 scripts\common\utility::allow_weapon_pickup(1);
  var_0 scripts\cp\cp_weapons::_takeweapon(var_2);
  var_0 scripts\cp\cp_weapons::forcevalidweapon();
  var_0 setstance("stand");
  var_0.ref_140ae = undefined;

  if(istrue(var_3)) {
    return true;
  }

  return false;
}

function wait_for_section_cut(var_0, var_1, var_2) {
  while(var_0 useButtonPressed()) {
    var_3 = getanimlength(level.scr_anim["cutter_player"]["pullout"]);
    var_4 = getanimlength(level.scr_anim["cutter_player"][var_2]);
    var_5 = getanimlength(level.scr_anim["cutter_player"]["putaway"]);

    if(getdvarfloat("scr_cut_length") > 0) {
      var_4 = getdvarfloat("scr_cut_length");
    }

    thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "pullout");
    thread scripts\common\anim::anim_single_solo(var_1, "pullout");
    wait 0.25;
    var_0.x1circletime hide();
    var_1 show();
    wait 0.25;
    var_1 playLoopSound("saw_spinup");
    wait var_3 - 0.6;
    var_6 = var_4 - 0.25;
    thread do_cut_anims(var_0, var_1, var_2);
    var_0 forceusehintoff();
    var_7 = cut_objective_progress(var_0, var_6);
    var_1 stoploopsound();
    playsoundatpos(var_1.origin, "saw_spinup_stop");

    if(!isDefined(var_7) || !var_7) {
      var_0 notify("cut_failed");
    }

    if(!scripts\cp\cp_laststand::player_in_laststand(var_0)) {
      thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "putaway");
      thread scripts\common\anim::anim_single_solo(var_1, "putaway");
      wait 1;
    }

    var_1 hide();
    var_0.x1circletime show();
    return var_7;
  }
}

function cut_objective_progress(var_0, var_1) {
  var_0 endon("last_stand");
  var_0 endon("disconnect");

  if(!isDefined(self.cut_progress)) {
    self.cut_progress = 0;
  }

  if(!isDefined(level.total_cut_progress)) {
    level.total_cut_progress = 0;
  }

  while(self.cut_progress <= var_1 && var_0 useButtonPressed()) {
    objective_setprogress(level.cut_progress_objective, level.total_cut_progress / var_1 * 2);
    wait 0.05;
    self.cut_progress += 0.05;
    level.total_cut_progress += 0.05;
  }

  return self.cut_progress >= var_1;
}

function do_cut_anims(var_0, var_1, var_2) {
  var_0 endon("cut_failed");
  var_3 = getanimlength(level.scr_anim["cutter_player"]["pullout"]);
  var_4 = getanimlength(level.scr_anim["cutter_player"][var_2]);

  if(getdvarfloat("scr_cut_length") > 0) {
    var_4 = getdvarfloat("scr_cut_length");
  }

  var_5 = getanimlength(level.scr_anim["cutter_player"]["putaway"]);
  thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, var_2);
  thread scripts\common\anim::anim_single_solo(var_1, var_2);
  wait 0.5;
  var_1 setscriptablepartstate("sparks", "on");
  wait var_4 - 0.6;
}

function magic_grenade_chance() {
  self endon("disconnect");

  if(!randomint(100) > 80) {
    return;
  }

  wait randomintrange(3, 8);
  magicgrenademanual("frag_grenade_mp", self.origin + (0, 0, 90), (0, 0, -50), 5);
}

function create_cut_interactions(var_0) {
  var_1 = anglesToForward((0, var_0.angles[1], 0));
  var_2 = anglestoleft((0, var_0.angles[1], 0));
  var_3 = var_0.origin;
  var_4 = var_3 + (0, 0, 40) + var_2 * 10 + var_1 * -5;

  foreach(var_6 in level.door_cut_interactions) {
    if(var_6.origin == var_4) {
      return undefined;
    }
  }

  var_8 = scripts\engine\utility::getStructArray("vault_cut_offset", "targetname");
  var_9 = var_8[0];

  if(isDefined(var_0.target)) {
    var_8 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
    var_9 = var_8[0];
  }

  var_10 = create_cut_interaction(var_4, &"CP_BR_SYRK_OBJECTIVES/CUT_PILOT_OBJ", "cut_2", var_9);
  return var_10;
}

function create_cut_interaction(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0);
  var_4 setModel("tag_origin");
  waitframe();
  var_4 setHintString(var_1);
  var_4 setCursorHint("HINT_BUTTON");
  var_4 sethintdisplayrange(200);
  var_4 sethintdisplayfov(65);
  var_4 setuserange(72);
  var_4 setusefov(65);
  var_4 sethintonobstruction("show");
  var_4 setuseholdduration("duration_none");
  thread use_think(var_4, var_2);
  return var_4;
}

function use_think(var_0, var_1) {
  self endon("death");
  scripts\engine\utility::flag_wait("activate_door_cut");

  for(;;) {
    self makeusable();
    self waittill("trigger", var_2);

    if(isDefined(var_2)) {
      if(!var_2 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(!istrue(var_2.shoot_vehicle)) {
        var_2 scripts\cp\utility::setlowermessage("havesaw", &"CP_DWN_TWN_OBJECTIVES/NEED_SAW", 5);
        continue;
      }

      level notify("start_cut_spawn_modules");
      self makeunusable();

      if(!cut_vault_gate(var_1, var_2, var_0)) {
        wait 1;
        continue;
      }
    }

    level notify("gate_cut");

    if(isDefined(level.door_cut_interactions)) {
      foreach(var_4 in level.door_cut_interactions) {
        if(isDefined(var_4)) {
          var_4 makeusable();
        }
      }
    }

    self delete();
  }
}