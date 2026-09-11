/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\infilexfil\cp_fulton.gsc
***********************************************/

function fulton_group_exfil_at_pos(var0, var1, var2, var3) {
  thread fulton_group_exfil_at_pos_internal(level, var0, var1, var2);
}

function fulton_group_exfil_at_pos_internal(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.origin = var0;
  var4.angles = var1;
  var4.buildweaponfromrandomcategory = var3;
  var5 = 120;

  if(isDefined(var2)) {
    var5 = var2;
  }

  thread anim_init_exfil_fulton();
  thread launch_evac_box(level, var5);
  thread ref_1353a(level, var0, var1);
}

function ref_1353a(var0, var1, var2) {
  var3 = var0 - (0, 0, 192);
  var2.modsforclass = spawn("script_model", var3);
  var2.modsforclass setModel("military_fulton_assembly_ks");
}

function launch_evac_box(var0, var1) {
  thread temp_move_exfil_box(level);
  var2 = 3;

  if(var0 > 3) {
    var2 = var0;
  }

  wait var2;
  level notify("drop_evac_box");
}

function init_crate_type() {
  if(isDefined(level.cratedata.configs["cp_fulton_exfil"])) {
    return;
  }

  level.cratedata.configs["cp_fulton_exfil"] = scripts\cp_mp\killstreaks\airdrop::getemptyleveldata();
  level.cratedata.configs["cp_fulton_exfil"].friendlymodel = "military_fulton_assembly_ks";
}

function play_airdrop_crate(var0) {
  init_crate_type(level);
  var1 = var0.origin;
  var2 = var0.angles;
  var3 = (0, 0, 0);

  if(isDefined(var0.buildweaponfromrandomcategory)) {
    var3 = var0.buildweaponfromrandomcategory;
  }

  var4 = 1024000000;
  var5 = scripts\cp\utility::give_closest_player_nearby(var1, var4, "allies");
  var6 = var5 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("", var5);
  var6.numcrates = 1;
  var6.cratetype = "cp_fulton_exfil";
  var6.scenenodeoffset = var3;
  var6.usephysics = 1;
  var7 = &scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates;
  var8 = level thread[[var7]](var5, var5.team, var1, var2, var1, var6);
  waitframe();
  var9 = undefined;

  foreach(var11 in var8.crates) {
    var9 = var11;
    break;
  }

  return var9;
}

function temp_move_exfil_box(var0) {
  var1 = spawn_fulton_crate_model(var0);
  var1 hide();
  level waittill("drop_evac_box");
  var2 = play_airdrop_crate(level, var0);
  var2 hide();
  var2.isdummyarmcrate = 1;
  var2 scripts\cp_mp\killstreaks\airdrop::deactivatecrate();
  var2 scripts\engine\utility::delaythread(2, &scripts\cp_mp\killstreaks\airdrop::deactivatecrate);
  var2 dontinterpolate();
  var2.heli_assault3_death_watcher = spawn("script_model", var2.origin);
  var3 = getdvarint("scr_fultonextract_scriptablebroken", 0);

  if(var3 > 0) {
    var2.heli_assault3_death_watcher setModel("military_fulton_assembly_ks");
    var2.heli_assault3_death_watcher.angles = var2.angles;
    var2.heli_assault3_death_watcher setscriptablepartstate("anims", "idle");
  } else {
    var2.heli_assault3_death_watcher setModel("military_fulton_assembly");
    var2.heli_assault3_death_watcher.angles = var2.friendlymodel.angles;
    var2.heli_assault3_death_watcher linkTo(var2.friendlymodel, "tag_origin");
    thread playerstreamwaittillcomplete();
    var2.friendlymodel hide();
  }

  var2 waittill("anim_finished");
  var4 = var2.origin;
  var2.angles = var0.angles;
  var2.physicsactivated = 0;
  var2.friendlymodel hide();
  waitframe();
  var2.heli_assault3_death_watcher.angles = var0.angles;
  var5 = var4[2];
  var6 = var5 - var0.origin[2] + 100;
  var7 = var5 - var0.origin[2];

  if(var6 > 0) {
    var8 = (var2.angles[0], var2.angles[1] + 180, var2.angles[2]);
    var2 dontinterpolate();
    var2.origin = var4;
    var2.angles = var8;
    var2.heli_assault3_death_watcher dontinterpolate();
    var2.heli_assault3_death_watcher.origin = var4;
    var2.heli_assault3_death_watcher.angles = var8;
    var9 = var7 / 400;
    var10 = max(var9 * 0.33 - 0.05, 0.05);
    var2 moveTo(var0.origin + (0, 0, 8), var9, var10, 0.05);
    var2.heli_assault3_death_watcher moveTo(var0.origin + (0, 0, 8), var9, var10, 0.05);
    var2.heli_assault3_death_watcher rotateTo(var0.angles, var9, 0.05, 0.05);
    wait var9;
  }

  var2 playRumbleOnEntity("grenade_rumble");
  earthquake(0.2, 0.75, var2.origin, 600);
  var2 playSound("scn_cp_group_fulton_crate_impact");
  waitframe();
  var2 scripts\cp_mp\killstreaks\airdrop::deactivatecrate(1);
  thread delayed_enable_fulton_extract(level, var1, var2);
}

function spawn_fulton_crate_model(var0) {
  var1 = var0.origin;
  var2 = var0.angles;
  var3 = spawn("script_model", var1);
  var3 setModel("military_fulton_assembly");
  var3.angles = var2;
  var3.targetname = "fulton_carepackage_model";
  return var3;
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

function delayed_enable_fulton_extract(var0, var1, var2) {
  thread infil_name(level, var0, var1);
  thread play_crate_vfx(level);
  thread create_fulton_group_interactions(level, var0);
  thread track_fulton_uses();
  level.obj_allow_fulton = 1;
}

function infil_name(var0, var1, var2) {
  var3 = spawnStruct();
  var3.origin = var2.origin;
  var3.angles = var2.angles;
  thread ref_14402(var0);
  thread ref_14401();
  var4 = thread ref_13559(var3);
  var5 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var4, "fulton_ac130");
  var5 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  thread ref_123bf(level, var3, 0.2, var5);
  var6 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var0, "device");
  var6 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  baloon_deposit_death_check(var5, "ac130");
  baloon_deposit_death_check(var6, "crate");
  var0 dontinterpolate();
  var4 dontinterpolate();
  var3 scripts\cp_mp\anim_scene::anim_scene([var6], "device_setup", 1, 0);
  var3 scripts\cp_mp\anim_scene::anim_scene_stop();
  level waittill("play_fulton_evac_together");

  foreach(var8 in level.playerstoptimerdelete) {
    var8.entity playsoundonmovingent("scn_cp_group_fulton_exfil_wind");
    thread ref_12498();
    thread ref_123eb(var8);
  }

  var3 thread scripts\cp_mp\anim_scene::anim_scene([var5, var6], "fulton_evac", 0, 0);
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

function ref_123eb(var0) {
  var1 = self;
  var2 = var1.auto_respawn_timer;
  var3 = var1.audio_stop_obj_room_fires;
  var4 = undefined;

  switch (var3) {
    case 1:
      var4 = "crate_hook_fk_BK_ctrl";
      break;
    case 2:
      var4 = "crate_hook_fk_RI_ctrl";
      break;
    case 3:
      var4 = "crate_hook_fk_LE_ctrl";
      break;
    case 4:
      var4 = "crate_hook_fk_FR_ctrl";
      break;
  }

  var5 = var0.entity scripts\engine\utility::spawn_tag_origin();
  var5 linkTo(var0.entity, var4, (0, 0, 0), (0, 0, 0));
  var2.entity linkTo(var5, "tag_origin");
  var1.player_rig linkTo(var5, "tag_origin");
  var6 = spawn("script_model", var1.entity.origin);
  var6 setModel(var1.entity.model);
  var6.angles = var1.entity.angles;
  var6 linkTo(var5, "tag_origin", (0, 0, 0), (0, 0, 0));
  var7 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var6, "player_" + var3);
  var7 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  thread ref_11aa5(var1, var6);
  var5 thread scripts\cp_mp\anim_scene::anim_scene([var1, var2, var7], "fulton_evac", 0, 0);
}

function ref_11aa5(var0, var1) {
  var1 hide();
  wait 2;

  for(var2 = 0; var2 < level.players.size; var2++) {
    if(var0.entity != level.players[var2]) {
      var1 showtoplayer(level.players[var2]);
    }
  }

  var0.entity playerhide();
}

function baloon_deposit_death_check(var0) {
  if(!isDefined(level.playerstarttimetracking)) {
    level.playerstarttimetracking = [];
  }

  self.type = var0;
  level.playerstarttimetracking[level.playerstarttimetracking.size] = self;
}

function ballowexecutions(var0, var1) {
  if(!isDefined(level.playerstoptimerdelete)) {
    level.playerstoptimerdelete = [];
  }

  self.auto_respawn_timer = var0;
  self.audio_stop_obj_room_fires = var1;
  level.playerstoptimerdelete[level.playerstoptimerdelete.size] = self;
}

function ref_14402(var0) {
  wait 1;
  self show();
  var0.heli_assault3_death_watcher delete();
  var0 scripts\cp_mp\killstreaks\airdrop::destroycrate(1);
}

function ref_14401() {
  wait 2;
  self playRumbleOnEntity("damage_light");
  earthquake(0.1, 0.45, self.origin, 600);
}

function play_crate_vfx(var0) {
  playFX(scripts\engine\utility::getfx("vfx_carepkg_landing_dust"), var0.origin, anglesToForward(var0.angles), anglestoup(var0.angles));
}

function create_fulton_group_interactions(var0, var1) {
  level.playertakeextractionplunder = var0;
  var2 = 16;
  wait 2.5;
  var3 = var0.origin + rotatevector((0, 35, var2), var1.angles);
  var4 = thread spawn_fulton_group_use_interaction(var3, var0.angles, 4, var0, var1);
  var5 = var0.origin + rotatevector((-35, 0, var2), var1.angles);
  var6 = thread spawn_fulton_group_use_interaction(var5, var0.angles, 3, var0, var1);
  var7 = var0.origin + rotatevector((35, 0, var2), var1.angles);
  var8 = thread spawn_fulton_group_use_interaction(var7, var0.angles, 2, var0, var1);
  var9 = var0.origin + rotatevector((0, -35, var2), var1.angles);
  var10 = thread spawn_fulton_group_use_interaction(var9, var0.angles, 1, var0, var1);
  level.fulton_interactions = [];
  level.fulton_interactions[level.fulton_interactions.size] = var4;
  level.fulton_interactions[level.fulton_interactions.size] = var6;
  level.fulton_interactions[level.fulton_interactions.size] = var8;
  level.fulton_interactions[level.fulton_interactions.size] = var10;
}

function spawn_fulton_group_use_interaction(var0, var1, var2, var3, var4) {
  var5 = scripts\engine\utility::spawn_tag_origin(var0, var1);
  var5 show();
  var5 setHintString(&"CP_QUARRY2_OBJECTIVES/CONVOY4_FULTON_USER");
  var5 setCursorHint("HINT_BUTTON");
  var5 sethinticon("cp_tac_waypoint_fulton");
  var5 sethintdisplayrange(500);
  var5 sethintdisplayfov(110);
  var5 setuserange(128);
  var5 setusefov(110);
  var5 sethintonobstruction("hide");
  var5 setuseholdduration("duration_short");
  var5 makeusable();
  thread fulton_group_use_think(var5, 120, var2, var3);
  return var5;
}

function fulton_group_use_think(var0, var1, var2, var3) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var4);

    if(isDefined(var4)) {
      if(!var4 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      activate_group_fulton_interact(var4, var1, var2, var3);
      remove_group_fulton_interact(var0);
    }
  }
}

function activate_group_fulton_interact(var0, var1, var2, var3) {
  var0.used_fulton_interact = 1;
  var0.ability_invulnerable = 1;
  level.fulton_interactions = scripts\engine\utility::array_remove(level.fulton_interactions, self);
  var0 disableusability();
  thread anim_fulton_exfil_player_scene(level, undefined, var0, var1, var2);
  level notify("player_used_extract", var0);
  scripts\cp\cp_outofbounds::enableoobimmunity(var0);
}

function remove_group_fulton_interact(var0) {
  self makeunusable();
  wait var0;
  self delete();
}

function listen_for_emp_drone_ent(var0) {
  if(isDefined(var0)) {
    wait var0;
  }

  level.playertouching = 1;

  foreach(var2 in level.fulton_interactions) {
    var2 makeunusable();
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

function anim_fulton_exfil_player_scene(var0, var1, var2, var3, var4) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.origin = var4.origin;
    var0.angles = var4.angles;
  }

  var5 = 0.2;
  var6 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var1, "player_" + var2, 1, 1, 1);
  var7 = ref_1355a(var0, var1, "player_" + var2);
  var8 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var7, "ropes_" + var2);
  var8 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  thread autoapplyquest(var8, var0, var8, var2);
  baloon_deposit_death_check(var8, "hook_" + var2);
  ballowexecutions(var6, var8, var2);
  baloon_deposit_death_check(var6, "player_" + var2);
  var0 scripts\cp_mp\anim_scene::anim_scene([var6], "fulton_hookup", 1, 0, undefined, var5);

  if(!scripts\engine\utility::flag("fulton_ac130_approached")) {
    var0 thread scripts\cp_mp\anim_scene::anim_scene_loop([var6, var8], "fulton_idle", 0, 0, undefined, var5);
    player_cam_enable(var1);
    level waittill("continue_fulton_extraction");
  }

  var0 scripts\cp_mp\anim_scene::anim_scene_stop();
  waitframe();
  scripts\engine\utility::flag_wait("fulton_ac130_approached");
  ref_12472(var1);
  var0 scripts\cp_mp\anim_scene::anim_scene_stop();
  level notify("play_fulton_evac_together");
}

function player_cam_enable(var0) {
  if(!scripts\engine\utility::flag("fulton_ac130_approached")) {
    var0 cameraset("camera_custom_orbit_0_noremote");
    var0.gasmask_resist = 1;
    return;
  }
}

function ref_12472(var0) {
  if(istrue(var0.gasmask_resist)) {
    var0 cameradefault();
    return;
  }
}

function ref_13559(var0, var1) {
  if(isDefined(level.playerstartrecondronewait)) {
    return;
  }

  level.playerstartrecondronewait = spawn("script_model", var0.origin - (0, 0, 2000));
  level.playerstartrecondronewait setModel("veh8_mil_air_acharlie130_small");
  level.playerstartrecondronewait.angles = var0.angles;
  level.playerstartrecondronewait.animname = "fulton_ac130";
  level.playerstartrecondronewait useanimtree(level.scr_animtree["fulton_ac130"]);
  level.playerstartrecondronewait hide();
  level.playerstartrecondronewait playLoopSound("iw8_bradley_drop_c130");
  return level.playerstartrecondronewait;
}

function ref_123be(var0) {
  thread listen_for_emp_drone_ent(level);
  var1 = 7;
  wait var0 - var1;
  level notify("continue_fulton_ac130");
}

function ref_123bf(var0, var1, var2, var3) {
  level waittill("continue_fulton_ac130");

  if(istrue(level.ref_12461)) {
    return;
  }

  level.ref_12461 = 1;
  var3 dontinterpolate();
  var3 show();
  var0 scripts\cp_mp\anim_scene::anim_scene([var2], "ac130_approach", undefined, undefined, undefined, 0, 0);
  scripts\engine\utility::flag_set("fulton_ac130_approached");
  level notify("continue_fulton_extraction");
}

function ref_1355a(var0, var1, var2) {
  var3 = spawn("script_model", var0.origin);
  var3 setModel("military_fulton_rope");
  var3.angles = var0.angles;
  var3.animname = "ropes";
  var3 useanimtree(level.scr_animtree[var2]);
  waitframe();
  return var3;
}

function autoapplyquest(var0, var1, var2, var3) {
  var0 scripts\cp_mp\anim_scene::anim_scene([var1], "fulton_hookup", 1, 0);
}

function track_fulton_uses() {
  level endon("continue_fulton_extraction");

  for(;;) {
    level waittill("player_used_extract", var0);
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