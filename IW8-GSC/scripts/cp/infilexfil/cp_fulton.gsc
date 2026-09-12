/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\infilexfil\cp_fulton.gsc
***********************************************/

function fulton_group_exfil_at_pos(var_0, var_1, var_2, var_3) {
  thread fulton_group_exfil_at_pos_internal(level, var_0, var_1, var_2);
}

function fulton_group_exfil_at_pos_internal(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4.angles = var_1;
  var_4.buildweaponfromrandomcategory = var_3;
  var_5 = 120;

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

  thread anim_init_exfil_fulton();
  thread launch_evac_box(level, var_5);
  thread ref_1353A(level, var_0, var_1);
}

function ref_1353A(var_0, var_1, var_2) {
  var_3 = var_0 - (0, 0, 192);
  var_2.modsforclass = spawn("script_model", var_3);
  var_2.modsforclass setModel("military_fulton_assembly_ks");
}

function launch_evac_box(var_0, var_1) {
  thread temp_move_exfil_box(level);
  var_2 = 3;

  if(var_0 > 3) {
    var_2 = var_0;
  }

  wait var_2;
  level notify("drop_evac_box");
}

function init_crate_type() {
  if(isDefined(level.cratedata.configs["cp_fulton_exfil"])) {
    return;
  }

  level.cratedata.configs["cp_fulton_exfil"] = scripts\cp_mp\killstreaks\airdrop::getemptyleveldata();
  level.cratedata.configs["cp_fulton_exfil"].friendlymodel = "military_fulton_assembly_ks";
}

function play_airdrop_crate(var_0) {
  init_crate_type(level);
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = (0, 0, 0);

  if(isDefined(var_0.buildweaponfromrandomcategory)) {
    var_3 = var_0.buildweaponfromrandomcategory;
  }

  var_4 = 1024000000;
  var_5 = scripts\cp\utility::give_closest_player_nearby(var_1, var_4, "allies");
  var_6 = var_5 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("", var_5);
  var_6.numcrates = 1;
  var_6.cratetype = "cp_fulton_exfil";
  var_6.scenenodeoffset = var_3;
  var_6.usephysics = 1;
  var_7 = &scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates;
  var_8 = level thread[[var_7]](var_5, var_5.team, var_1, var_2, var_1, var_6);
  waitframe();
  var_9 = undefined;

  foreach(var_11 in var_8.crates) {
    var_9 = var_11;
    break;
  }

  return var_9;
}

function temp_move_exfil_box(var_0) {
  var_1 = spawn_fulton_crate_model(var_0);
  var_1 hide();
  level waittill("drop_evac_box");
  var_2 = play_airdrop_crate(level, var_0);
  var_2 hide();
  var_2.isdummyarmcrate = 1;
  var_2 scripts\cp_mp\killstreaks\airdrop::deactivatecrate();
  var_2 scripts\engine\utility::delaythread(2, &scripts\cp_mp\killstreaks\airdrop::deactivatecrate);
  var_2 dontinterpolate();
  var_2.heli_assault3_death_watcher = spawn("script_model", var_2.origin);
  var_3 = getdvarint("scr_fultonextract_scriptablebroken", 0);

  if(var_3 > 0) {
    var_2.heli_assault3_death_watcher setModel("military_fulton_assembly_ks");
    var_2.heli_assault3_death_watcher.angles = var_2.angles;
    var_2.heli_assault3_death_watcher setscriptablepartstate("anims", "idle");
  } else {
    var_2.heli_assault3_death_watcher setModel("military_fulton_assembly");
    var_2.heli_assault3_death_watcher.angles = var_2.friendlymodel.angles;
    var_2.heli_assault3_death_watcher linkTo(var_2.friendlymodel, "tag_origin");
    thread playerstreamwaittillcomplete();
    var_2.friendlymodel hide();
  }

  var_2 waittill("anim_finished");
  var_4 = var_2.origin;
  var_2.angles = var_0.angles;
  var_2.physicsactivated = 0;
  var_2.friendlymodel hide();
  waitframe();
  var_2.heli_assault3_death_watcher.angles = var_0.angles;
  var_5 = var_4[2];
  var_6 = var_5 - var_0.origin[2] + 100;
  var_7 = var_5 - var_0.origin[2];

  if(var_6 > 0) {
    var_8 = (var_2.angles[0], var_2.angles[1] + 180, var_2.angles[2]);
    var_2 dontinterpolate();
    var_2.origin = var_4;
    var_2.angles = var_8;
    var_2.heli_assault3_death_watcher dontinterpolate();
    var_2.heli_assault3_death_watcher.origin = var_4;
    var_2.heli_assault3_death_watcher.angles = var_8;
    var_9 = var_7 / 400;
    var_10 = max(var_9 * 0.33 - 0.05, 0.05);
    var_2 moveTo(var_0.origin + (0, 0, 8), var_9, var_10, 0.05);
    var_2.heli_assault3_death_watcher moveTo(var_0.origin + (0, 0, 8), var_9, var_10, 0.05);
    var_2.heli_assault3_death_watcher rotateTo(var_0.angles, var_9, 0.05, 0.05);
    wait var_9;
  }

  var_2 playRumbleOnEntity("grenade_rumble");
  earthquake(0.2, 0.75, var_2.origin, 600);
  var_2 playSound("scn_cp_group_fulton_crate_impact");
  waitframe();
  var_2 scripts\cp_mp\killstreaks\airdrop::deactivatecrate(1);
  thread delayed_enable_fulton_extract(level, var_1, var_2);
}

function spawn_fulton_crate_model(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = spawn("script_model", var_1);
  var_3 setModel("military_fulton_assembly");
  var_3.angles = var_2;
  var_3.targetname = "fulton_carepackage_model";
  return var_3;
}

function playerstreamwaittillcomplete() {
  self hide();
  wait 6;
  self show();
  self dontinterpolate();
  self scriptmodelplayanim("cp_fulton_group_device_closed_idle");
  self hidepart("j_fulton_bind_01");
  self hidepart("j_baloon_lwr_tip_dwn");
  self hidepart("j_baloon_mid_tip_dwn");
  self hidepart("j_baloon_upr_tip_dwn");
}

function delayed_enable_fulton_extract(var_0, var_1, var_2) {
  thread infil_name(level, var_0, var_1);
  thread play_crate_vfx(level);
  thread create_fulton_group_interactions(level, var_0);
  thread track_fulton_uses();
  level.obj_allow_fulton = 1;
}

function infil_name(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_2.origin;
  var_3.angles = var_2.angles;
  thread ref_14402(var_0);
  thread ref_14401();
  var_4 = thread ref_13559(var_3);
  var_5 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_4, "fulton_ac130");
  var_5 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  thread ref_123BF(level, var_3, 0.2, var_5);
  var_6 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_0, "device");
  var_6 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  baloon_deposit_death_check(var_5, "ac130");
  baloon_deposit_death_check(var_6, "crate");
  var_0 dontinterpolate();
  var_4 dontinterpolate();
  var_3 scripts\cp_mp\anim_scene::anim_scene([var_6], "device_setup", 1, 0);
  var_3 scripts\cp_mp\anim_scene::anim_scene_stop();
  level waittill("play_fulton_evac_together");

  foreach(var_8 in level.playerstoptimerdelete) {
    var_8.entity playsoundonmovingent("scn_cp_group_fulton_exfil_wind");
    thread ref_12498();
    thread ref_123EB(var_8);
  }

  var_3 thread scripts\cp_mp\anim_scene::anim_scene([var_5, var_6], "fulton_evac", 0, 0);
}

function ref_12498() {
  self endon("death_or_disconnect");
  wait 2.2;
  self playRumbleOnEntity("damage_heavy");
  scripts\cp_mp\utility\shellshock_utility::_shellshock("frag_grenade_mp", "explosion", 1.5, 0);
  wait randomfloatrange(0.2, 1.1);
  scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "flavor_surprise");
  wait randomfloatrange(2.8, 3.4);
  scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "flavor_awesome");
}

function ref_123EB(var_0) {
  var_1 = self;
  var_2 = var_1.auto_respawn_timer;
  var_3 = var_1.audio_stop_obj_room_fires;
  var_4 = undefined;

  switch (var_3) {
    case 1:
      var_4 = "crate_hook_fk_BK_ctrl";
      break;
    case 2:
      var_4 = "crate_hook_fk_RI_ctrl";
      break;
    case 3:
      var_4 = "crate_hook_fk_LE_ctrl";
      break;
    case 4:
      var_4 = "crate_hook_fk_FR_ctrl";
      break;
  }

  var_5 = var_0.entity scripts\engine\utility::spawn_tag_origin();
  var_5 linkTo(var_0.entity, var_4, (0, 0, 0), (0, 0, 0));
  var_2.entity linkTo(var_5, "tag_origin");
  var_1.player_rig linkTo(var_5, "tag_origin");
  var_6 = spawn("script_model", var_1.entity.origin);
  var_6 setModel(var_1.entity.model);
  var_6.angles = var_1.entity.angles;
  var_6 linkTo(var_5, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_7 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_6, "player_" + var_3);
  var_7 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  thread ref_11AA5(var_1, var_6);
  var_5 thread scripts\cp_mp\anim_scene::anim_scene([var_1, var_2, var_7], "fulton_evac", 0, 0);
}

function ref_11AA5(var_0, var_1) {
  var_1 hide();
  wait 2;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(var_0.entity != level.players[var_2]) {
      var_1 showtoplayer(level.players[var_2]);
    }
  }

  var_0.entity playerhide();
}

function baloon_deposit_death_check(var_0) {
  if(!isDefined(level.playerstarttimetracking)) {
    level.playerstarttimetracking = [];
  }

  self.type = var_0;
  level.playerstarttimetracking[level.playerstarttimetracking.size] = self;
}

function ballowexecutions(var_0, var_1) {
  if(!isDefined(level.playerstoptimerdelete)) {
    level.playerstoptimerdelete = [];
  }

  self.auto_respawn_timer = var_0;
  self.audio_stop_obj_room_fires = var_1;
  level.playerstoptimerdelete[level.playerstoptimerdelete.size] = self;
}

function ref_14402(var_0) {
  wait 1;
  self show();
  var_0.heli_assault3_death_watcher delete();
  var_0 scripts\cp_mp\killstreaks\airdrop::destroycrate(1);
}

function ref_14401() {
  wait 2;
  self playRumbleOnEntity("damage_light");
  earthquake(0.1, 0.45, self.origin, 600);
}

function play_crate_vfx(var_0) {
  playFX(scripts\engine\utility::getfx("vfx_carepkg_landing_dust"), var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
}

function create_fulton_group_interactions(var_0, var_1) {
  level.playertakeextractionplunder = var_0;
  var_2 = 16;
  wait 2.5;
  var_3 = var_0.origin + rotatevector((0, 35, var_2), var_1.angles);
  var_4 = thread spawn_fulton_group_use_interaction(var_3, var_0.angles, 4, var_0, var_1);
  var_5 = var_0.origin + rotatevector((-35, 0, var_2), var_1.angles);
  var_6 = thread spawn_fulton_group_use_interaction(var_5, var_0.angles, 3, var_0, var_1);
  var_7 = var_0.origin + rotatevector((35, 0, var_2), var_1.angles);
  var_8 = thread spawn_fulton_group_use_interaction(var_7, var_0.angles, 2, var_0, var_1);
  var_9 = var_0.origin + rotatevector((0, -35, var_2), var_1.angles);
  var_10 = thread spawn_fulton_group_use_interaction(var_9, var_0.angles, 1, var_0, var_1);
  level.fulton_interactions = [];
  level.fulton_interactions[level.fulton_interactions.size] = var_4;
  level.fulton_interactions[level.fulton_interactions.size] = var_6;
  level.fulton_interactions[level.fulton_interactions.size] = var_8;
  level.fulton_interactions[level.fulton_interactions.size] = var_10;
}

function spawn_fulton_group_use_interaction(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::spawn_tag_origin(var_0, var_1);
  var_5 show();
  var_5 setHintString(&"CP_QUARRY2_OBJECTIVES/CONVOY4_FULTON_USER");
  var_5 setCursorHint("HINT_BUTTON");
  var_5 sethinticon("cp_tac_waypoint_fulton");
  var_5 sethintdisplayrange(500);
  var_5 sethintdisplayfov(110);
  var_5 setuserange(128);
  var_5 setusefov(110);
  var_5 sethintonobstruction("hide");
  var_5 setuseholdduration("duration_short");
  var_5 makeusable();
  thread fulton_group_use_think(var_5, 120, var_2, var_3);
  return var_5;
}

function fulton_group_use_think(var_0, var_1, var_2, var_3) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_4);

    if(isDefined(var_4)) {
      if(!var_4 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      activate_group_fulton_interact(var_4, var_1, var_2, var_3);
      remove_group_fulton_interact(var_0);
    }
  }
}

function activate_group_fulton_interact(var_0, var_1, var_2, var_3) {
  var_0.used_fulton_interact = 1;
  var_0.ability_invulnerable = 1;
  level.fulton_interactions = scripts\engine\utility::array_remove(level.fulton_interactions, self);
  var_0 disableusability();
  thread anim_fulton_exfil_player_scene(level, undefined, var_0, var_1, var_2);
  level notify("player_used_extract", var_0);
  scripts\cp\cp_outofbounds::enableoobimmunity(var_0);
}

function remove_group_fulton_interact(var_0) {
  self makeunusable();
  wait var_0;
  self delete();
}

function listen_for_emp_drone_ent(var_0) {
  if(isDefined(var_0)) {
    wait var_0;
  }

  level.playertouching = 1;

  foreach(var_2 in level.fulton_interactions) {
    var_2 makeunusable();
  }
}

#using_animtree("");

function anim_init_exfil_fulton() {
  if(isDefined(level.scr_anim["player"]) && isDefined(level.scr_anim["player"]["fulton_hookup_1"])) {
    return;
  }

  level.scr_animtree["player_1"] = #animtree;
  level.scr_anim["player_1"]["fulton_hookup"] = $cp_fulton_group_player_1_hookup;
  level.scr_animname["player_1"]["fulton_hookup"] = "cp_fulton_group_player_1_hookup";
  level.scr_eventanim["player_1"]["fulton_hookup"] = "cp_fulton_group_player_1_hookup";
  level.scr_animtree["player_1"] = #animtree;
  level.scr_anim["player_1"]["fulton_idle"][0] = % cp_fulton_group_player_1_idle;
  level.scr_animname["player_1"]["fulton_idle"][0] = "cp_fulton_group_player_1_idle";
  level.scr_eventanim["player_1"]["fulton_idle"][0] = "cp_fulton_group_player_1_idle";
  level.scr_animtree["player_1"] = #animtree;
  level.scr_anim["player_1"]["fulton_evac"] = % cp_fulton_group_player_1_evac;
  level.scr_animname["player_1"]["fulton_evac"] = "cp_fulton_group_player_1_evac";
  level.scr_eventanim["player_1"]["fulton_evac"] = "cp_fulton_group_player_1_evac";
  level.scr_animtree["player_2"] = #animtree;
  level.scr_anim["player_2"]["fulton_hookup"] = % cp_fulton_group_player_2_hookup;
  level.scr_animname["player_2"]["fulton_hookup"] = "cp_fulton_group_player_2_hookup";
  level.scr_eventanim["player_2"]["fulton_hookup"] = "cp_fulton_group_player_2_hookup";
  level.scr_animtree["player_2"] = #animtree;
  level.scr_anim["player_2"]["fulton_idle"][0] = % cp_fulton_group_player_2_idle;
  level.scr_animname["player_2"]["fulton_idle"][0] = "cp_fulton_group_player_2_idle";
  level.scr_eventanim["player_2"]["fulton_idle"][0] = "cp_fulton_group_player_2_idle";
  level.scr_animtree["player_2"] = #animtree;
  level.scr_anim["player_2"]["fulton_evac"] = % cp_fulton_group_player_2_evac;
  level.scr_animname["player_2"]["fulton_evac"] = "cp_fulton_group_player_2_evac";
  level.scr_eventanim["player_2"]["fulton_evac"] = "cp_fulton_group_player_2_evac";
  level.scr_animtree["player_3"] = #animtree;
  level.scr_anim["player_3"]["fulton_hookup"] = % cp_fulton_group_player_3_hookup;
  level.scr_animname["player_3"]["fulton_hookup"] = "cp_fulton_group_player_3_hookup";
  level.scr_eventanim["player_3"]["fulton_hookup"] = "cp_fulton_group_player_3_hookup";
  level.scr_animtree["player_3"] = #animtree;
  level.scr_anim["player_3"]["fulton_idle"][0] = % cp_fulton_group_player_3_idle;
  level.scr_animname["player_3"]["fulton_idle"][0] = "cp_fulton_group_player_3_idle";
  level.scr_eventanim["player_3"]["fulton_idle"][0] = "cp_fulton_group_player_3_idle";
  level.scr_animtree["player_3"] = #animtree;
  level.scr_anim["player_3"]["fulton_evac"] = % cp_fulton_group_player_3_evac;
  level.scr_animname["player_3"]["fulton_evac"] = "cp_fulton_group_player_3_evac";
  level.scr_eventanim["player_3"]["fulton_evac"] = "cp_fulton_group_player_3_evac";
  level.scr_animtree["player_4"] = #animtree;
  level.scr_anim["player_4"]["fulton_hookup"] = % cp_fulton_group_player_4_hookup;
  level.scr_animname["player_4"]["fulton_hookup"] = "cp_fulton_group_player_4_hookup";
  level.scr_eventanim["player_4"]["fulton_hookup"] = "cp_fulton_group_player_4_hookup";
  level.scr_animtree["player_4"] = #animtree;
  level.scr_anim["player_4"]["fulton_idle"][0] = % cp_fulton_group_player_4_idle;
  level.scr_animname["player_4"]["fulton_idle"][0] = "cp_fulton_group_player_4_idle";
  level.scr_eventanim["player_4"]["fulton_idle"][0] = "cp_fulton_group_player_4_idle";
  level.scr_animtree["player_4"] = #animtree;
  level.scr_anim["player_4"]["fulton_evac"] = % cp_fulton_group_player_4_evac;
  level.scr_animname["player_4"]["fulton_evac"] = "cp_fulton_group_player_4_evac";
  level.scr_eventanim["player_4"]["fulton_evac"] = "cp_fulton_group_player_4_evac";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["device_setup"] = % cp_fulton_group_device_setup;
  level.scr_animname["device"]["device_setup"] = "cp_fulton_group_device_setup";
  level.scr_eventanim["device"]["device_setup"] = "cp_fulton_group_device_setup";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["device_idle"] = % cp_fulton_group_device_idle;
  level.scr_animname["device"]["device_idle"] = "cp_fulton_group_device_idle";
  level.scr_eventanim["device"]["device_idle"] = "cp_fulton_group_device_idle";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["device_closed"] = % cp_fulton_group_device_closed_idle;
  level.scr_animname["device"]["device_closed"] = "cp_fulton_group_device_closed_idle";
  level.scr_eventanim["device"]["device_closed"] = "cp_fulton_group_device_closed_idle";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["fulton_evac"] = % cp_fulton_group_device_evac;
  level.scr_animname["device"]["fulton_evac"] = "cp_fulton_group_device_evac";
  level.scr_eventanim["device"]["fulton_evac"] = "cp_fulton_group_device_evac";
  level.scr_animtree["ropes_1"] = #animtree;
  level.scr_anim["ropes_1"]["fulton_hookup"] = % cp_fulton_group_hook_1_hookup;
  level.scr_animname["ropes_1"]["fulton_hookup"] = "cp_fulton_group_hook_1_hookup";
  level.scr_eventanim["ropes_1"]["fulton_hookup"] = "cp_fulton_group_hook_1_hookup";
  level.scr_animtree["ropes_1"] = #animtree;
  level.scr_anim["ropes_1"]["fulton_idle"][0] = % cp_fulton_group_hook_1_idle;
  level.scr_animname["ropes_1"]["fulton_idle"][0] = "cp_fulton_group_hook_1_idle";
  level.scr_eventanim["ropes_1"]["fulton_idle"][0] = "cp_fulton_group_hook_1_idle";
  level.scr_animtree["ropes_1"] = #animtree;
  level.scr_anim["ropes_1"]["fulton_evac"] = % cp_fulton_group_hook_1_evac;
  level.scr_animname["ropes_1"]["fulton_evac"] = "cp_fulton_group_hook_1_evac";
  level.scr_eventanim["ropes_1"]["fulton_evac"] = "cp_fulton_group_hook_1_evac";
  level.scr_animtree["ropes_2"] = #animtree;
  level.scr_anim["ropes_2"]["fulton_hookup"] = % cp_fulton_group_hook_2_hookup;
  level.scr_animname["ropes_2"]["fulton_hookup"] = "cp_fulton_group_hook_2_hookup";
  level.scr_eventanim["ropes_2"]["fulton_hookup"] = "cp_fulton_group_hook_2_hookup";
  level.scr_animtree["ropes_2"] = #animtree;
  level.scr_anim["ropes_2"]["fulton_idle"][0] = % cp_fulton_group_hook_2_idle;
  level.scr_animname["ropes_2"]["fulton_idle"][0] = "cp_fulton_group_hook_2_idle";
  level.scr_eventanim["ropes_2"]["fulton_idle"][0] = "cp_fulton_group_hook_2_idle";
  level.scr_animtree["ropes_2"] = #animtree;
  level.scr_anim["ropes_2"]["fulton_evac"] = % cp_fulton_group_hook_2_evac;
  level.scr_animname["ropes_2"]["fulton_evac"] = "cp_fulton_group_hook_2_evac";
  level.scr_eventanim["ropes_2"]["fulton_evac"] = "cp_fulton_group_hook_2_evac";
  level.scr_animtree["rope_3"] = #animtree;
  level.scr_anim["ropes_3"]["fulton_hookup"] = % cp_fulton_group_hook_3_hookup;
  level.scr_animname["ropes_3"]["fulton_hookup"] = "cp_fulton_group_hook_3_hookup";
  level.scr_eventanim["ropes_3"]["fulton_hookup"] = "cp_fulton_group_hook_3_hookup";
  level.scr_animtree["ropes_3"] = #animtree;
  level.scr_anim["ropes_3"]["fulton_idle"][0] = % cp_fulton_group_hook_3_idle;
  level.scr_animname["ropes_3"]["fulton_idle"][0] = "cp_fulton_group_hook_3_idle";
  level.scr_eventanim["ropes_3"]["fulton_idle"][0] = "cp_fulton_group_hook_3_idle";
  level.scr_animtree["ropes_3"] = #animtree;
  level.scr_anim["ropes_3"]["fulton_evac"] = % cp_fulton_group_hook_3_evac;
  level.scr_animname["ropes_3"]["fulton_evac"] = "cp_fulton_group_hook_3_evac";
  level.scr_eventanim["ropes_3"]["fulton_evac"] = "cp_fulton_group_hook_3_evac";
  level.scr_animtree["ropes_4"] = #animtree;
  level.scr_anim["ropes_4"]["fulton_hookup"] = % cp_fulton_group_hook_4_hookup;
  level.scr_animname["ropes_4"]["fulton_hookup"] = "cp_fulton_group_hook_4_hookup";
  level.scr_eventanim["ropes_4"]["fulton_hookup"] = "cp_fulton_group_hook_4_hookup";
  level.scr_animtree["ropes_4"] = #animtree;
  level.scr_anim["ropes_4"]["fulton_idle"][0] = % cp_fulton_group_hook_4_idle;
  level.scr_animname["ropes_4"]["fulton_idle"][0] = "cp_fulton_group_hook_4_idle";
  level.scr_eventanim["ropes_4"]["fulton_idle"][0] = "cp_fulton_group_hook_4_idle";
  level.scr_animtree["ropes_4"] = #animtree;
  level.scr_anim["ropes_4"]["fulton_evac"] = % cp_fulton_group_hook_4_evac;
  level.scr_animname["ropes_4"]["fulton_evac"] = "cp_fulton_group_hook_4_evac";
  level.scr_eventanim["ropes_4"]["fulton_evac"] = "cp_fulton_group_hook_4_evac";
  level.scr_animtree["fulton_ac130"] = #animtree;
  level.scr_anim["fulton_ac130"]["ac130_approach"] = % cp_fulton_group_plane_approach;
  level.scr_animname["fulton_ac130"]["ac130_approach"] = "cp_fulton_group_plane_approach";
  level.scr_animtree["fulton_ac130"] = #animtree;
  level.scr_anim["fulton_ac130"]["fulton_evac"] = % cp_fulton_group_plane_evac;
  level.scr_animname["fulton_ac130"]["fulton_evac"] = "cp_fulton_group_plane_evac";
  scripts\engine\utility::flag_init("fulton_ac130_approached");
}

function anim_fulton_exfil_player_scene(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.origin = var_4.origin;
    var_0.angles = var_4.angles;
  }

  var_5 = 0.2;
  var_6 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_1, "player_" + var_2, 1, 1, 1);
  var_7 = ref_1355A(var_0, var_1, "player_" + var_2);
  var_8 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_7, "ropes_" + var_2);
  var_8 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  thread autoapplyquest(var_8, var_0, var_8, var_2);
  baloon_deposit_death_check(var_8, "hook_" + var_2);
  ballowexecutions(var_6, var_8, var_2);
  baloon_deposit_death_check(var_6, "player_" + var_2);
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_6], "fulton_hookup", 1, 0, undefined, var_5);

  if(!scripts\engine\utility::flag("fulton_ac130_approached")) {
    var_0 thread scripts\cp_mp\anim_scene::anim_scene_loop([var_6, var_8], "fulton_idle", 0, 0, undefined, var_5);
    player_cam_enable(var_1);
    level waittill("continue_fulton_extraction");
  }

  var_0 scripts\cp_mp\anim_scene::anim_scene_stop();
  waitframe();
  scripts\engine\utility::flag_wait("fulton_ac130_approached");
  ref_12472(var_1);
  var_0 scripts\cp_mp\anim_scene::anim_scene_stop();
  level notify("play_fulton_evac_together");
}

function player_cam_enable(var_0) {
  if(!scripts\engine\utility::flag("fulton_ac130_approached")) {
    var_0 cameraset("camera_custom_orbit_0_noremote");
    var_0.gasmask_resist = 1;
    return;
  }
}

function ref_12472(var_0) {
  if(istrue(var_0.gasmask_resist)) {
    var_0 cameradefault();
    return;
  }
}

function ref_13559(var_0, var_1) {
  if(isDefined(level.playerstartrecondronewait)) {
    return;
  }

  level.playerstartrecondronewait = spawn("script_model", var_0.origin - (0, 0, 2000));
  level.playerstartrecondronewait setModel("veh8_mil_air_acharlie130_small");
  level.playerstartrecondronewait.angles = var_0.angles;
  level.playerstartrecondronewait.animname = "fulton_ac130";
  level.playerstartrecondronewait useanimtree(level.scr_animtree["fulton_ac130"]);
  level.playerstartrecondronewait hide();
  level.playerstartrecondronewait playLoopSound("iw8_bradley_drop_c130");
  return level.playerstartrecondronewait;
}

function ref_123BE(var_0) {
  thread listen_for_emp_drone_ent(level);
  var_1 = 7;
  wait var_0 - var_1;
  level notify("continue_fulton_ac130");
}

function ref_123BF(var_0, var_1, var_2, var_3) {
  level waittill("continue_fulton_ac130");

  if(istrue(level.ref_12461)) {
    return;
  }

  level.ref_12461 = 1;
  var_3 dontinterpolate();
  var_3 show();
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_2], "ac130_approach", undefined, undefined, undefined, 0, 0);
  scripts\engine\utility::flag_set("fulton_ac130_approached");
  level notify("continue_fulton_extraction");
}

function ref_1355A(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0.origin);
  var_3 setModel("military_fulton_rope");
  var_3.angles = var_0.angles;
  var_3.animname = "ropes";
  var_3 useanimtree(level.scr_animtree[var_2]);
  waitframe();
  return var_3;
}

function autoapplyquest(var_0, var_1, var_2, var_3) {
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_1], "fulton_hookup", 1, 0);
}

function track_fulton_uses() {
  level endon("continue_fulton_extraction");

  for(;;) {
    level waittill("player_used_extract", var_0);
    level.fulton_last_usetime = gettime();
  }
}

function player_used_fulton_recently() {
  if(isDefined(level.fulton_last_usetime)) {
    if(gettime() > level.fulton_last_usetime + 4000) {
      return false;
    } else {
      return true;
    }
  }

  return false;
}