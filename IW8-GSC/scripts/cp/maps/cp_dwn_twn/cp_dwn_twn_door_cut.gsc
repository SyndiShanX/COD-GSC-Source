/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_door_cut.gsc
**************************************************************/

function door_cut_precache() {
  level._effect["saw_sparks"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_cp_saw_sparks.vfx");
}

function main(var0) {
  cutout_door_main();
  wait_for_door_cut();
  thread break_door();
}

function cutout_door_main() {
  init_cutout_anims();
  level.door_cut_interactions = [];
  level.vault_door_broken = 0;
  var0 = scripts\engine\utility::getStructArray("vault_door_cut_interaction", "targetname");

  foreach(var2 in var0) {
    var3 = create_cut_interactions(var2);

    if(isDefined(var3)) {
      level.door_cut_interactions[level.door_cut_interactions.size] = var3;
    }
  }

  foreach(var6 in level.door_cut_interactions) {
    if(isDefined(var6)) {
      var6 makeusable();
    }
  }

  var8 = getEnt("vault_gate_door_clip", "targetname");
  var8 disconnectPaths();
}

function break_door() {
  var0 = getEnt("vault_gate_door_clip", "targetname");
  var1 = getEnt("vault_gate_door", "targetname");
  var1 rotateby((90, 0, 0), 0.45);
  wait 0.4;
  var1 playSound("cp_bank_gate_fall");
  var0 connectpaths();
  var0 notsolid();
  thread bank_alarm_sfx();
  level.vault_door_broken = 1;
}

function bank_alarm_sfx() {
  var0 = spawn("script_origin", (5040, 854, 41));
  var1 = spawn("script_origin", (3940, 1853, 180));
  var2 = spawn("script_origin", (5404, 809, 42));
  var3 = spawn("script_origin", (3742, 870, 184));
  var4 = spawn("script_origin", (5452, 213, 435));
  wait 0.05;
  var0 playLoopSound("emt_alarm_bank_bell_lp");
  var1 playLoopSound("emt_alarm_bank_bell_lp");
  var2 playLoopSound("emt_alarm_bank_bell_lp");
  var3 playLoopSound("emt_alarm_bank_bell_lp");
  var4 playLoopSound("emt_alarm_bank_bell_lp");
  scripts\engine\utility::flag_wait("init_roof_combat");

  if(isDefined(var0)) {
    var0 stoploopsound("emt_alarm_bank_bell_lp");
    var0 delete();
  }

  if(isDefined(var1)) {
    var1 stoploopsound("emt_alarm_bank_bell_lp");
    var1 delete();
  }

  if(isDefined(var2)) {
    var2 stoploopsound("emt_alarm_bank_bell_lp");
    var2 delete();
  }

  if(isDefined(var3)) {
    var3 stoploopsound("emt_alarm_bank_bell_lp");
    var3 delete();
  }

  if(isDefined(var4)) {
    var4 stoploopsound("emt_alarm_bank_bell_lp");
    var4 delete();
    return;
  }
}

function wait_for_door_cut(var0) {
  level endon("end_door_cut_wait");
  level.waiting_for_door_cut = 1;
  level.ref_140f6 = 0;

  for(;;) {
    level waittill("gate_cut");
    level.ref_140f6++;

    if(level.ref_140f6 >= level.door_cut_interactions.size) {
      level notify("saws_have_been_used");
      scripts\engine\utility::flag_set("saws_have_been_used");

      foreach(var2 in level.players) {
        var2 notify("drop_saw");
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

function cut_vault_gate(var0, var1) {
  var0.ref_140ae = 1;
  var2 = getcompleteweaponname("iw8_gunless_infil");
  var0 scripts\cp\utility::_giveweapon(var2, undefined, undefined, 1);
  var3 = var0 scripts\cp\cp_weapons::switchtoweaponreliable(var2, 0);
  var0 scripts\common\utility::allow_weapon_switch(0);
  var0 scripts\common\utility::allow_weapon_pickup(0);
  objective_pinforclient(level.cut_progress_objective, var0);
  var4 = getstartorigin(self.origin, self.angles, level.scr_anim["cutter_player"][var1]);
  var5 = getstartangles(self.origin, self.angles, level.scr_anim["cutter_player"][var1]);
  var0 setOrigin(var4, 1);
  var0 setplayerangles(var5);
  var0 setstance("stand");
  var0 cameraset("camera_custom_orbit_2_cp");
  var6 = spawn("script_model", self.origin);
  var6 setModel("tool_portable_gas_cutter_01_cp");
  var6.angles = self.angles;
  var6.animname = "saw";
  var6 hide();
  var0 forceusehinton(&"CP_BR_SYRK_OBJECTIVES/CUT_HINT");
  var6 useanimtree(level.scr_animtree["saw"]);
  var0 thread scripts\cp\cp_destruction::create_player_rig(var0, "cutter_player");
  var3 = wait_for_section_cut(var0, var6, var1);
  var0 cameradefault();
  var0 forceusehintoff();
  objective_unpinforclient(level.cut_progress_objective, var0);
  wait 1;
  var6 delete();
  scripts\cp\cp_destruction::remove_player_rig(var0);
  var0 scripts\common\utility::allow_weapon_switch(1);
  var0 scripts\common\utility::allow_weapon_pickup(1);
  var0 scripts\cp\cp_weapons::_takeweapon(var2);
  var0 scripts\cp\cp_weapons::forcevalidweapon();
  var0 setstance("stand");
  var0.ref_140ae = undefined;

  if(istrue(var3)) {
    return true;
  }

  return false;
}

function wait_for_section_cut(var0, var1, var2) {
  while(var0 useButtonPressed()) {
    var3 = getanimlength(level.scr_anim["cutter_player"]["pullout"]);
    var4 = getanimlength(level.scr_anim["cutter_player"][var2]);
    var5 = getanimlength(level.scr_anim["cutter_player"]["putaway"]);

    if(getdvarfloat("scr_cut_length") > 0) {
      var4 = getdvarfloat("scr_cut_length");
    }

    thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, "pullout");
    thread scripts\common\anim::anim_single_solo(var1, "pullout");
    wait 0.25;
    var0.x1circletime hide();
    var1 show();
    wait 0.25;
    var1 playLoopSound("saw_spinup");
    wait var3 - 0.6;
    var6 = var4 - 0.25;
    thread do_cut_anims(var0, var1, var2);
    var0 forceusehintoff();
    var7 = cut_objective_progress(var0, var6);
    var1 stoploopsound();
    playsoundatpos(var1.origin, "saw_spinup_stop");

    if(!isDefined(var7) || !var7) {
      var0 notify("cut_failed");
    }

    if(!scripts\cp\cp_laststand::player_in_laststand(var0)) {
      thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, "putaway");
      thread scripts\common\anim::anim_single_solo(var1, "putaway");
      wait 1;
    }

    var1 hide();
    var0.x1circletime show();
    return var7;
  }
}

function cut_objective_progress(var0, var1) {
  var0 endon("last_stand");
  var0 endon("disconnect");

  if(!isDefined(self.cut_progress)) {
    self.cut_progress = 0;
  }

  if(!isDefined(level.total_cut_progress)) {
    level.total_cut_progress = 0;
  }

  while(self.cut_progress <= var1 && var0 useButtonPressed()) {
    objective_setprogress(level.cut_progress_objective, level.total_cut_progress / var1 * 2);
    wait 0.05;
    self.cut_progress += 0.05;
    level.total_cut_progress += 0.05;
  }

  return self.cut_progress >= var1;
}

function do_cut_anims(var0, var1, var2) {
  var0 endon("cut_failed");
  var3 = getanimlength(level.scr_anim["cutter_player"]["pullout"]);
  var4 = getanimlength(level.scr_anim["cutter_player"][var2]);

  if(getdvarfloat("scr_cut_length") > 0) {
    var4 = getdvarfloat("scr_cut_length");
  }

  var5 = getanimlength(level.scr_anim["cutter_player"]["putaway"]);
  thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, var2);
  thread scripts\common\anim::anim_single_solo(var1, var2);
  wait 0.5;
  var1 setscriptablepartstate("sparks", "on");
  wait var4 - 0.6;
}

function magic_grenade_chance() {
  self endon("disconnect");

  if(!randomint(100) > 80) {
    return;
  }

  wait randomintrange(3, 8);
  magicgrenademanual("frag_grenade_mp", self.origin + (0, 0, 90), (0, 0, -50), 5);
}

function create_cut_interactions(var0) {
  var1 = anglesToForward((0, var0.angles[1], 0));
  var2 = anglestoleft((0, var0.angles[1], 0));
  var3 = var0.origin;
  var4 = var3 + (0, 0, 40) + var2 * 10 + var1 * -5;

  foreach(var6 in level.door_cut_interactions) {
    if(var6.origin == var4) {
      return undefined;
    }
  }

  var8 = scripts\engine\utility::getStructArray("vault_cut_offset", "targetname");
  var9 = var8[0];

  if(isDefined(var0.target)) {
    var8 = scripts\engine\utility::getStructArray(var0.target, "targetname");
    var9 = var8[0];
  }

  var10 = create_cut_interaction(var4, &"CP_BR_SYRK_OBJECTIVES/CUT_PILOT_OBJ", "cut_2", var9);
  return var10;
}

function create_cut_interaction(var0, var1, var2, var3) {
  var4 = spawn("script_model", var0);
  var4 setModel("tag_origin");
  waitframe();
  var4 setHintString(var1);
  var4 setCursorHint("HINT_BUTTON");
  var4 sethintdisplayrange(200);
  var4 sethintdisplayfov(65);
  var4 setuserange(72);
  var4 setusefov(65);
  var4 sethintonobstruction("show");
  var4 setuseholdduration("duration_none");
  thread use_think(var4, var2);
  return var4;
}

function use_think(var0, var1) {
  self endon("death");
  scripts\engine\utility::flag_wait("activate_door_cut");

  for(;;) {
    self makeusable();
    self waittill("trigger", var2);

    if(isDefined(var2)) {
      if(!var2 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(!istrue(var2.shoot_vehicle)) {
        var2 scripts\cp\utility::setlowermessage("havesaw", &"CP_DWN_TWN_OBJECTIVES/NEED_SAW", 5);
        continue;
      }

      level notify("start_cut_spawn_modules");
      self makeunusable();

      if(!cut_vault_gate(var1, var2, var0)) {
        wait 1;
        continue;
      }
    }

    level notify("gate_cut");

    if(isDefined(level.door_cut_interactions)) {
      foreach(var4 in level.door_cut_interactions) {
        if(isDefined(var4)) {
          var4 makeusable();
        }
      }
    }

    self delete();
  }
}