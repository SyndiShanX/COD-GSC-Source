/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_ee.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\beam_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\zm_zod;
#using scripts\zm\zm_zod_quest;
#using_animtree("generic");

class class_b454dc63 {
  var var_3b3701c9;
  var var_dbea7369;
  var var_8d207f9b;
  var var_a9547cdf;

  constructor() {}

  destructor() {}

  function function_66844d0d(localclientnum, b_active) {
    var_3b3701c9 = b_active;
    if(!var_3b3701c9) {
      var_dbea7369 stoploopsound(3);
    } else {
      if(!var_8d207f9b) {
        var_a9547cdf = "p7_fxanim_zm_zod_apothicons_god_loop_anim";
        var_dbea7369 setanim("p7_fxanim_zm_zod_apothicons_god_loop_anim", 1, 0, 1);
        var_dbea7369 playSound(localclientnum, "zmb_zod_apothigod_vox_spawn");
      } else {
        level notify("hash_465ed3ec");
        var_a9547cdf = "p7_fxanim_zm_zod_apothicons_god_body_idle_anim";
        var_dbea7369 setanim(var_a9547cdf, 1, 0, 1);
        var_dbea7369 playLoopSound("zmb_zod_apothigod_vox_lookat_lp", 12);
      }
    }
  }

  function function_839ff35f(localclientnum, mdl_god) {
    if(!isDefined(mdl_god)) {
      return;
    }
    var_dbea7369 util::waittill_dobj(localclientnum);
    mdl_god setanim("p7_fxanim_zm_zod_apothicons_god_mouth_death_anim", 1, 0, 1);
    n_animlength = getanimlength("p7_fxanim_zm_zod_apothicons_god_body_death_anim");
    mdl_god setanim("p7_fxanim_zm_zod_apothicons_god_body_death_anim", 1, 0, 1);
    wait(n_animlength);
  }

  function function_2de612ff(localclientnum, mdl_god) {
    if(!isDefined(mdl_god)) {
      return;
    }
    var_dbea7369 util::waittill_dobj(localclientnum);
    mdl_god setanim(var_a9547cdf, 1, 0, 1);
    n_animlength = getanimlength("p7_fxanim_zm_zod_apothicons_god_mouth_roar_anim");
    mdl_god setanim("p7_fxanim_zm_zod_apothicons_god_mouth_roar_anim", 1, 0, 1);
    wait(n_animlength);
    mdl_god setanim("p7_fxanim_zm_zod_apothicons_god_mouth_idle_anim", 1, 0, 1);
    mdl_god setanim(var_a9547cdf, 1, 0, 1);
  }

  function function_465ed3ec(localclientnum, mdl_god) {
    level notify("hash_465ed3ec");
    level endon("hash_465ed3ec");
    while(true) {
      self thread function_2de612ff(localclientnum, mdl_god);
      var_7397ca31 = randomintrange(15, 60);
      wait(var_7397ca31);
    }
  }

  function function_9e0e6936() {
    return var_8d207f9b;
  }

  function init(localclientnum, mdl_god, var_bae1bdd7) {
    var_dbea7369 = mdl_god;
    var_8d207f9b = var_bae1bdd7;
    var_dbea7369 util::waittill_dobj(localclientnum);
    var_dbea7369 useanimtree($generic);
    var_dbea7369 setanim("p7_fxanim_zm_zod_apothicons_god_mouth_idle_anim", 1, 0, 1);
  }

}

#namespace zm_zod_ee;

function autoexec __init__sytem__() {
  system::register("zm_zod_ee", & __init__, undefined, undefined);
}

function __init__() {
  level._effect["player_cleanse"] = "zombie/fx_ee_player_cleanse_zod_zmb";
  level._effect["ee_quest_keeper_spirit_mist"] = "zombie/fx_ee_altar_mist_zod_zmb";
  level._effect["ee_quest_powerbox"] = "zombie/fx_bmode_dest_pwrbox_zod_zmb";
  level._effect["ee_superworm_death"] = "zombie/fx_ee_gateworm_lg_death_zod_zmb";
  level._effect["zombie/fx_ee_gateworm_lg_teleport_zod_zmb"] = "zombie/fx_ee_gateworm_lg_teleport_zod_zmb";
  level._effect["fx_ee_apothigod_beam_impact_zod_zmb"] = "fx_ee_apothigod_beam_impact_zod_zmb";
  level._effect["ee_totem_to_ghost"] = "zombie/fx_totem_beam_zod_zmb";
  level._effect["ee_ghost_charging"] = "zombie/fx_ee_ghost_charging_zod_zmb";
  level._effect["ee_ghost_charged"] = "zombie/fx_ee_ghost_full_charge_zod_zmb";
  level._effect["ee_quest_book_mist"] = "zombie/fx_ee_book_mist_zod_zmb";
  level._effect["zombie/fx_ee_keeper_beam_shield1_fail_zod_zmb"] = "zombie/fx_ee_keeper_beam_shield1_fail_zod_zmb";
  level._effect["zombie/fx_ee_keeper_beam_shield2_fail_zod_zmb"] = "zombie/fx_ee_keeper_beam_shield2_fail_zod_zmb";
  n_bits = getminbitcountfornum(5);
  clientfield::register("world", "ee_quest_state", 1, n_bits, "int", & function_f2a0dbdc, 0, 0);
  n_bits = getminbitcountfornum(6);
  clientfield::register("world", "ee_totem_state", 1, n_bits, "int", undefined, 0, 0);
  n_bits = getminbitcountfornum(10);
  clientfield::register("world", "ee_keeper_boxer_state", 1, n_bits, "int", & ee_keeper_boxer_state, 0, 0);
  clientfield::register("world", "ee_keeper_detective_state", 1, n_bits, "int", & ee_keeper_detective_state, 0, 0);
  clientfield::register("world", "ee_keeper_femme_state", 1, n_bits, "int", & ee_keeper_femme_state, 0, 0);
  clientfield::register("world", "ee_keeper_magician_state", 1, n_bits, "int", & ee_keeper_magician_state, 0, 0);
  clientfield::register("world", "ee_shadowman_battle_active", 1, 1, "int", & ee_shadowman_battle_active, 0, 0);
  n_bits = getminbitcountfornum(5);
  clientfield::register("world", "ee_superworm_state", 1, n_bits, "int", & ee_superworm_state, 0, 0);
  clientfield::register("scriptmover", "near_apothigod_active", 1, 1, "int", & near_apothigod_active, 0, 0);
  clientfield::register("scriptmover", "far_apothigod_active", 1, 1, "int", & far_apothigod_active, 0, 0);
  clientfield::register("scriptmover", "near_apothigod_roar", 1, 1, "counter", & near_apothigod_active, 0, 0);
  clientfield::register("scriptmover", "far_apothigod_roar", 1, 1, "counter", & far_apothigod_active, 0, 0);
  clientfield::register("scriptmover", "apothigod_death", 1, 1, "counter", & apothigod_death, 0, 0);
  n_bits = getminbitcountfornum(3);
  clientfield::register("world", "ee_keeper_beam_state", 1, n_bits, "int", & ee_keeper_beam_state, 0, 0);
  clientfield::register("world", "ee_final_boss_shields", 1, 1, "int", & ee_final_boss_shields, 0, 0);
  clientfield::register("toplayer", "ee_final_boss_attack_tell", 1, 1, "int", & ee_final_boss_attack_tell, 0, 0);
  clientfield::register("scriptmover", "ee_rail_electricity_state", 1, 1, "int", & ee_rail_electricity_state, 0, 0);
  clientfield::register("world", "sndEndIGC", 1, 1, "int", & sndendigc, 0, 0);
}

function sndendigc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    audio::snd_set_snapshot("zmb_zod_endigc");
  } else {
    audio::snd_set_snapshot("default");
  }
}

function ee_shadowman_battle_active(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    s_loc = struct::get("defend_area_pap", "targetname");
    level.var_65b446c1 = playFX(localclientnum, level._effect["portal_shortcut_closed_base"], s_loc.origin, (0, 0, 0));
  } else if(isDefined(level.var_65b446c1)) {
    stopfx(localclientnum, level.var_65b446c1);
  }
}

function function_f2a0dbdc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval !== 3 && newval !== 2) {
    return;
  }
  if(newval == 4) {
    return;
  }
  function_373d3423(localclientnum);
  mdl_ritual = level.main_quest[localclientnum]["pap"].e_assembly;
  mdl_ritual util::waittill_dobj(localclientnum);
  if(!mdl_ritual hasanimtree()) {
    mdl_ritual useanimtree($generic);
  }
  mdl_victim = level.main_quest[localclientnum]["pap"].e_victim;
  if(!mdl_victim hasanimtree()) {
    mdl_victim useanimtree($generic);
  }
  mdl_ritual show();
  mdl_victim show();
  for(i = 0; i < 4; i++) {
    mdl_ritual.vfx_trails[i] = playFXOnTag(localclientnum, level._effect["ritual_trail"], mdl_ritual, ("key_pcs0" + (i + 1)) + "_jnt");
  }
  level thread zm_zod_quest::sndritual(2, mdl_ritual);
  level thread exploder::exploder("ritual_light_pap");
  playSound(0, "zmb_zod_shadfight_ending", (0, 0, 0));
  zm_zod_quest::toggle_altar_vfx(localclientnum, "pap", 1);
  mdl_victim thread animation::play("ai_zombie_zod_shadowman_captured_intro");
  mdl_ritual animation::play("p7_fxanim_zm_zod_redemption_key_ritual_start_anim");
  mdl_victim clearanim("ai_zombie_zod_shadowman_captured_intro", 0);
  mdl_victim thread animation::play("ai_zombie_zod_shadowman_captured_loop");
  mdl_ritual clearanim("p7_fxanim_zm_zod_redemption_key_ritual_start_anim", 0);
  mdl_ritual thread animation::play("p7_fxanim_zm_zod_redemption_key_ritual_loop_anim");
  wait(1.5);
  mdl_victim playSound(0, "zmb_shadowman_die");
  mdl_victim clearanim("ai_zombie_zod_shadowman_captured_loop", 0);
  mdl_victim thread animation::play("ai_zombie_zod_shadowman_captured_outro");
  mdl_ritual clearanim("p7_fxanim_zm_zod_redemption_key_ritual_loop_anim", 0);
  mdl_ritual thread animation::play("p7_fxanim_zm_zod_redemption_key_ritual_loop_fast_anim");
  wait(1.5);
  mdl_victim = level.main_quest[localclientnum]["pap"].e_victim;
  mdl_victim.vfx_chest = playFXOnTag(localclientnum, level._effect["ritual_glow_chest"], mdl_victim, "j_spineupper");
  mdl_victim.vfx_head = playFXOnTag(localclientnum, level._effect["ritual_glow_head"], mdl_victim, "tag_eye");
  mdl_ritual clearanim("p7_fxanim_zm_zod_redemption_key_ritual_loop_fast_anim", 0);
  if(isDefined(mdl_ritual.vfx_trails)) {
    foreach(var_2d3cc156 in mdl_ritual.vfx_trails) {
      stopfx(localclientnum, var_2d3cc156);
    }
  }
  level thread zm_zod_quest::key_combines_notetrack_watcher(localclientnum, mdl_ritual, undefined, mdl_victim, "pap");
  if(newval == 3) {
    level thread function_cf8ff04b(localclientnum);
  } else if(newval == 2) {
    for(i = 1; i <= 4; i++) {
      var_4fafa709 = function_e1e53e16(localclientnum, i);
      var_4fafa709.model util::waittill_dobj(localclientnum);
      v_fwd = anglesToForward(var_4fafa709.model.angles);
      level thread function_705b696b(localclientnum, level._effect["keeper_spawn"], var_4fafa709.model.origin, v_fwd, 2);
      var_4fafa709.model hide();
    }
  }
  mdl_ritual animation::play("p7_fxanim_zm_zod_redemption_key_ritual_end_anim");
  mdl_ritual hide();
  s_loc = struct::get("defend_area_pap", "targetname");
  if(isDefined(s_loc.var_dda4503d)) {
    stopfx(localclientnum, s_loc.var_dda4503d);
  }
}

function function_705b696b(localclientnum, str_fx, v_origin, v_fwd, n_seconds) {
  fx_id = playFX(localclientnum, str_fx, v_origin, v_fwd);
  wait(n_seconds);
  stopfx(localclientnum, fx_id);
}

function function_cf8ff04b(localclientnum) {
  flag::wait_till("set_ritual_finished_flag");
  ee_superworm_state(localclientnum, undefined, 1);
}

function function_373d3423(localclientnum) {
  s_position = struct::get("defend_area_pap", "targetname");
  level.main_quest[localclientnum]["pap"] = s_position;
  level.main_quest[localclientnum]["pap"].e_assembly = spawn(localclientnum, s_position.origin, "script_model");
  level.main_quest[localclientnum]["pap"].e_assembly.angles = s_position.angles;
  level.main_quest[localclientnum]["pap"].e_assembly setModel("p7_fxanim_zm_zod_redemption_key_ritual_mod");
  level.main_quest[localclientnum]["pap"].e_assembly.vfx_trails = [];
  v_tag_origin = level.main_quest[localclientnum]["pap"].e_assembly gettagorigin("tag_char_jnt");
  v_tag_angles = level.main_quest[localclientnum]["pap"].e_assembly gettagangles("tag_char_jnt");
  level.main_quest[localclientnum]["pap"].e_victim = spawn(localclientnum, v_tag_origin, "script_model");
  level.main_quest[localclientnum]["pap"].e_victim setModel("c_zom_zod_shadowman_tentacles_fb");
  var_dd690641 = struct::get("shadowman_death_loc", "targetname");
  level.main_quest[localclientnum]["pap"].e_victim.origin = var_dd690641.origin;
  level.main_quest[localclientnum]["pap"].e_victim.angles = v_tag_angles;
}

function ee_keeper_boxer_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_a39c9866(localclientnum, newval, oldval, 1);
}

function ee_keeper_detective_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_a39c9866(localclientnum, newval, oldval, 2);
}

function ee_keeper_femme_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_a39c9866(localclientnum, newval, oldval, 3);
}

function ee_keeper_magician_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_a39c9866(localclientnum, newval, oldval, 4);
}

function function_a39c9866(localclientnum, var_fe2fb4b9, var_f471914b, n_character_index) {
  var_4fafa709 = function_e1e53e16(localclientnum, n_character_index);
  mdl_target = function_2c557738(localclientnum, n_character_index);
  function_4d0c8ca8(var_4fafa709, var_fe2fb4b9, n_character_index);
  var_4fafa709.model util::waittill_dobj(localclientnum);
  if(!var_4fafa709.model hasanimtree()) {
    var_4fafa709.model useanimtree($generic);
  }
  if(isDefined(var_4fafa709.model.sndloop)) {
    var_4fafa709.model stoploopsound(var_4fafa709.model.sndloop, 2);
    var_4fafa709.model.sndloop = undefined;
  }
  switch (var_fe2fb4b9) {
    case 0: {
      var_4fafa709.model hide();
      break;
    }
    case 1: {
      var_4fafa709.model show();
      var_4fafa709.model notify("hash_274ba0e6");
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_give_egg_intro", 0);
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_give_egg_loop", 0);
      var_4fafa709.var_c8ca4ded = playFX(localclientnum, level._effect["ee_quest_keeper_spirit_mist"], var_4fafa709.model.origin, var_4fafa709.model.angles);
      var_4fafa709.model.sndloop = var_4fafa709.model playLoopSound("zmb_ee_keeper_ghost_appear_lp", 2);
      var_4fafa709.model playSound(0, "zmb_ee_keeper_ghost_appear");
      var_4fafa709.model animation::play("ai_zombie_zod_keeper_idle", undefined, undefined, 1);
      break;
    }
    case 2: {
      var_4fafa709.model notify("hash_274ba0e6");
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_idle", 0);
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_give_egg_intro", 0);
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_give_egg_loop", 0);
      var_4fafa709.model.sndloop = var_4fafa709.model playLoopSound("zmb_zod_totem_resurrecting_lp", 2);
      var_4fafa709.var_4cf62d2c show();
      var_4fafa709.var_b0ff8d18 = playFXOnTag(localclientnum, level._effect["ee_totem_to_ghost"], var_4fafa709.var_4cf62d2c, "j_head");
      var_4fafa709.var_a0b06f1c = playFXOnTag(localclientnum, level._effect["ee_ghost_charging"], var_4fafa709.model, "tag_origin");
      var_4fafa709.model animation::play("ai_zombie_zod_keeper_give_egg_outro", undefined, undefined, 1);
      break;
    }
    case 3: {
      if(isDefined(var_4fafa709.var_b0ff8d18)) {
        stopfx(localclientnum, var_4fafa709.var_b0ff8d18);
      }
      if(isDefined(var_4fafa709.var_a0b06f1c)) {
        stopfx(localclientnum, var_4fafa709.var_a0b06f1c);
      }
      playFXOnTag(localclientnum, level._effect["ee_ghost_charged"], var_4fafa709.model, "tag_origin");
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_give_egg_outro", 0);
      var_4fafa709.model zm_zod::ghost_actor(localclientnum, 1, 0);
      var_4fafa709.model zm_zod_quest::keeper_fx(localclientnum, 0, 1);
      if(isDefined(var_4fafa709.var_c8ca4ded)) {
        stopfx(localclientnum, var_4fafa709.var_c8ca4ded);
      }
      var_4fafa709.model playSound(0, "zmb_ee_keeper_resurrect");
      wait(3);
      var_4fafa709.var_f87c0436 = playFXOnTag(localclientnum, level._effect["keeper_spawn"], var_4fafa709.model, "tag_origin");
      var_4fafa709.var_6b0fc6a1 = playFXOnTag(localclientnum, level._effect["keeper_spawn"], var_4fafa709.var_4cf62d2c, "tag_origin");
      var_4fafa709.model playSound(0, "evt_keeper_portal_end");
      var_4fafa709.var_4cf62d2c playSound(0, "evt_keeper_portal_end");
      wait(1);
      var_4fafa709.model hide();
      var_4fafa709.var_4cf62d2c hide();
      stopfx(localclientnum, var_4fafa709.var_f87c0436);
      stopfx(localclientnum, var_4fafa709.var_6b0fc6a1);
      str_targetname = "ee_keeper_8_" + (n_character_index - 1);
      s_loc = struct::get(str_targetname, "targetname");
      var_4fafa709.model.origin = s_loc.origin;
      var_4fafa709.model.angles = s_loc.angles + vectorscale((0, 1, 0), 180);
      var_4fafa709.model show();
      var_4fafa709.model animation::play("ai_zombie_zod_keeper_sword_quest_intro_idle", undefined, undefined, 1, 0, 0);
      break;
    }
    case 4: {
      function_6f29ee45(var_4fafa709);
      var_4fafa709.model notify("hash_274ba0e6");
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_intro_idle", 0);
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_injured_idle", 0);
      var_4fafa709.model.sndloop = var_4fafa709.model playLoopSound("zmb_zod_shadfight_keeper_up_lp", 2);
      s_loc = struct::get("defend_area_pap", "targetname");
      if(!isDefined(s_loc.var_dda4503d)) {
        v_fwd = anglesToForward(s_loc.angles);
        s_loc.var_dda4503d = playFX(localclientnum, level._effect["portal_shortcut_closed_base"], s_loc.origin, v_fwd);
      }
      str_targetname = "ee_keeper_8_" + (n_character_index - 1);
      s_loc = struct::get(str_targetname, "targetname");
      if(var_f471914b === 6) {
        var_4fafa709.model playSound(0, "zmb_zod_shadfight_keeper_up");
        var_4fafa709.model.angles = s_loc.angles;
        var_4fafa709.model zm_zod_quest::keeper_fx(localclientnum, 0, 1);
        var_4fafa709.model function_267f859f(localclientnum, level._effect["curse_tell"], 0, 1, "tag_origin");
        var_4fafa709.model animation::play("ai_zombie_zod_keeper_sword_quest_revived", undefined, undefined, 1, 0, 0);
        var_4fafa709.model thread function_274ba0e6("ai_zombie_zod_keeper_sword_quest_ready_idle", 1);
      } else {
        var_4fafa709.model.angles = s_loc.angles + vectorscale((0, 1, 0), 180);
        var_4fafa709.model animation::play("ai_zombie_zod_keeper_sword_quest_take_sword", undefined, undefined, 1, 0, 0);
        var_4fafa709.model thread function_274ba0e6("ai_zombie_zod_keeper_sword_quest_ready_idle", 1);
      }
      break;
    }
    case 5: {
      var_4fafa709.model notify("hash_274ba0e6");
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_revived", 0);
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_take_sword", 0);
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_ready_idle", 0);
      var_4fafa709.model playSound(0, "zmb_zod_shadfight_keeper_attack");
      var_4fafa709.model function_267f859f(localclientnum, level._effect["curse_tell"], 0, 1, "tag_origin");
      var_4fafa709.model animation::play("ai_zombie_zod_keeper_sword_quest_attack_intro", undefined, undefined, 1, 0, 0);
      var_4fafa709.model thread function_274ba0e6("ai_zombie_zod_keeper_sword_quest_attack_idle", 1);
      var_4fafa709 function_a48022e(localclientnum, 1, n_character_index);
      wait(3);
      var_4fafa709 function_a48022e(localclientnum, 0, n_character_index);
      break;
    }
    case 6: {
      var_4fafa709.model notify("hash_274ba0e6");
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_attack_intro", 0);
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_attack_idle", 0);
      var_4fafa709.model.sndloop = var_4fafa709.model playLoopSound("zmb_zod_shadfight_keeper_down_lp", 2);
      var_4fafa709.model playSound(0, "zmb_zod_shadfight_keeper_down");
      var_4fafa709.model zm_zod_quest::keeper_fx(localclientnum, 1, 0);
      var_4fafa709.model function_267f859f(localclientnum, level._effect["curse_tell"], 1, 1, "tag_origin");
      var_4fafa709.model animation::play("ai_zombie_zod_keeper_sword_quest_injured_intro", undefined, undefined, 1, 0, 0);
      var_4fafa709.model thread function_274ba0e6("ai_zombie_zod_keeper_sword_quest_injured_idle", 1);
      break;
    }
    case 7: {
      var_4fafa709.model notify("hash_274ba0e6");
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_attack_intro", 0);
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_attack_idle", 0);
      str_targetname = "ee_apothigod_keeper_" + (n_character_index - 1);
      s_loc = struct::get(str_targetname, "targetname");
      var_4fafa709.model.origin = s_loc.origin;
      var_4fafa709.model.angles = s_loc.angles;
      var_4fafa709.model thread function_274ba0e6("ai_zombie_zod_keeper_sword_quest_ready_idle", 1);
      break;
    }
    case 8: {
      function_6f29ee45(var_4fafa709);
      var_4fafa709.model notify("hash_274ba0e6");
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_attack_intro", 0);
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_attack_idle", 0);
      str_targetname = "ee_apothigod_keeper_" + (n_character_index - 1);
      s_loc = struct::get(str_targetname, "targetname");
      var_4fafa709.model.origin = s_loc.origin;
      var_4fafa709.model.angles = s_loc.angles;
      var_4fafa709.model thread function_274ba0e6("ai_zombie_zod_keeper_sword_quest_ready_idle", 1);
      break;
    }
    case 9: {
      var_4fafa709.model notify("hash_274ba0e6");
      var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_ready_idle", 0);
      var_4fafa709.model animation::play("ai_zombie_zod_keeper_sword_quest_attack_intro", undefined, undefined, 1, 0, 0);
      var_4fafa709.model thread function_274ba0e6("ai_zombie_zod_keeper_sword_quest_attack_idle", 1);
      break;
    }
  }
}

function function_a48022e(localclientnum, b_on = 1, n_character_index) {
  if(n_character_index == 1 || n_character_index == 4) {
    var_53106e7c = level._effect["zombie/fx_ee_keeper_beam_shield1_fail_zod_zmb"];
  } else {
    var_53106e7c = level._effect["zombie/fx_ee_keeper_beam_shield2_fail_zod_zmb"];
  }
  if(b_on) {
    s_loc = struct::get("keeper_vs_shadowman_beam_" + n_character_index);
    v_fwd = anglesToForward(s_loc.angles);
    v_origin = s_loc.origin;
    self.var_f5366edb = playFX(localclientnum, var_53106e7c, v_origin, v_fwd);
  } else {
    stopfx(localclientnum, self.var_f5366edb);
  }
}

function function_6f29ee45(var_4fafa709) {
  if(var_4fafa709.model isattached("wpn_t7_zmb_zod_sword2_world", "tag_weapon_right")) {
    return;
  }
  var_4fafa709.model attach("wpn_t7_zmb_zod_sword2_world", "tag_weapon_right");
}

function function_4d0c8ca8(var_4fafa709, var_fe2fb4b9, n_character_index) {
  if(var_fe2fb4b9 < 4) {
    var_64c74a6d = 0;
  } else {
    if(var_fe2fb4b9 < 8) {
      var_64c74a6d = 1;
    } else {
      var_64c74a6d = 2;
    }
  }
  if(var_4fafa709.var_64c74a6d === var_64c74a6d) {
    return;
  }
  switch (var_64c74a6d) {
    case 0: {
      str_targetname = "keeper_spirit_" + (n_character_index - 1);
      break;
    }
    case 1: {
      str_targetname = "ee_keeper_8_" + (n_character_index - 1);
      break;
    }
    case 2: {
      str_targetname = "ee_apothigod_keeper_" + (n_character_index - 1);
      break;
    }
  }
  s_loc = struct::get(str_targetname, "targetname");
  var_4fafa709.model.origin = s_loc.origin;
  var_4fafa709.model.angles = s_loc.angles;
  var_4fafa709.var_64c74a6d = var_64c74a6d;
}

function function_e1e53e16(localclientnum, n_character_index) {
  function_1461c206(localclientnum, n_character_index);
  s_loc = struct::get("keeper_spirit_" + (n_character_index - 1), "targetname");
  var_4fafa709 = level.var_673f721c[localclientnum][n_character_index];
  if(!isDefined(var_4fafa709.model)) {
    var_4fafa709.model = spawn(localclientnum, s_loc.origin, "script_model");
    var_4fafa709.model.angles = s_loc.angles;
    var_4fafa709.var_64c74a6d = 0;
    var_4fafa709.model setModel("c_zom_zod_keeper_fb");
    var_4fafa709.model zm_zod::ghost_actor(localclientnum, 0, 1);
  }
  if(!isDefined(var_4fafa709.var_4cf62d2c)) {
    var_f4fc4f28 = struct::get("keeper_resurrection_totem_" + (n_character_index - 1), "targetname");
    var_4fafa709.var_4cf62d2c = spawn(localclientnum, var_f4fc4f28.origin, "script_model");
    var_4fafa709.var_4cf62d2c.angles = var_f4fc4f28.angles;
    var_4fafa709.var_4cf62d2c setModel("t7_zm_zod_keepers_totem");
    var_4fafa709.var_4cf62d2c hide();
  }
  return var_4fafa709;
}

function function_2c557738(localclientnum, n_character_index) {
  function_1461c206(localclientnum, n_character_index);
  var_4fafa709 = level.var_673f721c[localclientnum][n_character_index];
  if(isDefined(var_4fafa709.var_f929ecf4)) {
    return var_4fafa709.var_f929ecf4;
  }
  s_target = struct::get("ee_shadowman_beam_" + n_character_index, "targetname");
  var_4fafa709.var_f929ecf4 = spawn(localclientnum, s_target.origin, "script_model");
  var_4fafa709.var_f929ecf4 setModel("tag_origin");
  return var_4fafa709.var_f929ecf4;
}

function function_27e2b2cc(localclientnum) {
  if(!isDefined(level.var_a9f994a9)) {
    level.var_a9f994a9 = spawnStruct();
  }
  if(!isDefined(level.var_a9f994a9.var_8cf34592)) {
    s_loc = struct::get("ee_apothigod_gateworm_reveal", "targetname");
    level.var_a9f994a9.var_8cf34592 = spawn(localclientnum, s_loc.origin, "script_model");
    level.var_a9f994a9.var_8cf34592.angles = s_loc.angles;
    level.var_a9f994a9.var_8cf34592 setModel("p7_zm_zod_gateworm_large");
    level.var_a9f994a9.var_8cf34592 useanimtree($generic);
  }
  if(!isDefined(level.var_a9f994a9.var_dbb35f4d)) {
    s_loc = struct::get("ee_apothigod_gateworm_junction", "targetname");
    level.var_a9f994a9.var_dbb35f4d = spawn(localclientnum, s_loc.origin, "script_model");
    level.var_a9f994a9.var_dbb35f4d.angles = s_loc.angles;
    level.var_a9f994a9.var_dbb35f4d setModel("p7_zm_zod_gateworm_large");
    level.var_a9f994a9.var_8cf34592 useanimtree($generic);
  }
}

function ee_superworm_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 4) {
    return;
  }
  function_27e2b2cc(localclientnum);
  level.var_a9f994a9.var_8cf34592 util::waittill_dobj(localclientnum);
  if(!level.var_a9f994a9.var_8cf34592 hasanimtree()) {
    level.var_a9f994a9.var_8cf34592 useanimtree($generic);
  }
  level.var_a9f994a9.var_dbb35f4d util::waittill_dobj(localclientnum);
  if(!level.var_a9f994a9.var_dbb35f4d hasanimtree()) {
    level.var_a9f994a9.var_dbb35f4d useanimtree($generic);
  }
  switch (newval) {
    case 0: {
      level.var_a9f994a9.var_8cf34592 hide();
      level.var_a9f994a9.var_dbb35f4d hide();
      break;
    }
    case 1: {
      level.var_a9f994a9.var_8cf34592 show();
      level.var_a9f994a9.var_dbb35f4d hide();
      level.var_a9f994a9.var_8cf34592 function_bdd91321(localclientnum, 0, 0);
      level.var_a9f994a9.var_8cf34592 thread animation::play("ai_zombie_zod_gateworm_large_idle_loop_active", undefined, undefined, 1);
      wait(5);
      level.var_a9f994a9.var_8cf34592 hide();
      level.var_a9f994a9.var_8cf34592 function_bdd91321(localclientnum, 0, 0);
      level.var_a9f994a9.var_dbb35f4d show();
      level.var_a9f994a9.var_dbb35f4d function_bdd91321(localclientnum, 1, 0);
      break;
    }
    case 2: {
      level.var_a9f994a9.var_8cf34592 hide();
      level.var_a9f994a9.var_dbb35f4d show();
      level.var_a9f994a9.var_dbb35f4d function_bdd91321(localclientnum, 1, 1);
      level.var_a9f994a9.var_dbb35f4d hide();
      break;
    }
    case 3: {
      level.var_a9f994a9.var_8cf34592 hide();
      level.var_a9f994a9.var_dbb35f4d show();
      level.var_a9f994a9.var_dbb35f4d function_bdd91321(localclientnum, 0, 0);
      level.var_a9f994a9.var_dbb35f4d clearanim("ai_zombie_zod_gateworm_large_idle_loop_active", 0);
      level.var_a9f994a9.var_dbb35f4d thread animation::play("ai_zombie_zod_gateworm_large_idle_loop", undefined, undefined, 1);
      break;
    }
    case 4: {
      level.var_a9f994a9.var_8cf34592 hide();
      level.var_a9f994a9.var_dbb35f4d show();
      level.var_a9f994a9.var_dbb35f4d function_bdd91321(localclientnum, 0, 0);
      level.var_a9f994a9.var_dbb35f4d clearanim("ai_zombie_zod_gateworm_large_idle_loop", 0);
      level.var_a9f994a9.var_dbb35f4d thread animation::play("ai_zombie_zod_gateworm_large_idle_loop_active", undefined, undefined, 1);
      break;
    }
  }
}

function function_bdd91321(localclientnum, b_hide, var_b4c5825f = 0) {
  if(b_hide) {
    if(isDefined(self.sndlooper)) {
      self stoploopsound(self.sndlooper, 1);
      self.sndlooper = undefined;
    }
    if(var_b4c5825f) {
      v_origin_1 = self gettagorigin("j_spine_1_anim");
      v_origin_2 = self gettagorigin("j_spine_4_anim");
      var_38050c98 = self gettagorigin("j_upper_jaw_1_anim");
      playFX(localclientnum, level._effect["ee_superworm_death"], v_origin_1);
      playFX(localclientnum, level._effect["ee_superworm_death"], v_origin_2);
      playFX(localclientnum, level._effect["ee_superworm_death"], var_38050c98);
      self playSound(0, "zmb_zod_superworm_smash");
    } else {
      v_origin = self gettagorigin("j_spine_6_anim");
      v_angles = self gettagangles("j_spine_6_anim");
      playFX(localclientnum, level._effect["zombie/fx_ee_gateworm_lg_teleport_zod_zmb"], v_origin, v_angles);
      self playSound(0, "zmb_zod_superworm_warpout");
    }
  } else {
    v_origin = self gettagorigin("j_spine_6_anim");
    v_angles = self gettagangles("j_spine_6_anim");
    playFX(localclientnum, level._effect["zombie/fx_ee_gateworm_lg_teleport_zod_zmb"], v_origin, v_angles);
    self playSound(0, "zmb_zod_superworm_warpin");
    if(!isDefined(self.sndlooper)) {
      self.sndlooper = self playLoopSound("zmb_zod_superworm_loop", 2);
    }
  }
}

function ee_keeper_beam_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_4c0f7435)) {
    var_7cb357a4 = struct::get("ee_apothigod_beam_unite", "targetname");
    level.var_4c0f7435 = spawn(localclientnum, var_7cb357a4.origin, "script_model");
    level.var_4c0f7435 setModel("tag_origin");
  }
  v_origin = level.var_4c0f7435.origin + vectorscale((0, 0, 1), 1000);
  v_angles = anglesToForward(level.var_4c0f7435.angles);
  switch (newval) {
    case 0: {
      exploder::stop_exploder("fx_exploder_ee_final_battle_fail");
      exploder::stop_exploder("fx_exploder_ee_final_batttle_success");
      break;
    }
    case 1: {
      exploder::exploder("fx_exploder_ee_final_battle_fail");
      level.var_4c0f7435 playSound(0, "zmb_zod_beam_fire_fail");
      break;
    }
    case 2: {
      exploder::exploder("fx_exploder_ee_final_batttle_success");
      playFX(localclientnum, level._effect["fx_ee_apothigod_beam_impact_zod_zmb"], v_origin, v_angles);
      level.var_4c0f7435 playSound(0, "zmb_zod_beam_fire_success");
      break;
    }
  }
}

function ee_final_boss_shields(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_dcd4f61a = struct::get_array("final_boss_safepoint", "targetname");
  foreach(var_495730fe in var_dcd4f61a) {
    var_495730fe function_267f859f(localclientnum, level._effect["player_cleanse"], newval, 0);
    if(newval) {
      audio::playloopat("zmb_zod_player_cleanse_point", var_495730fe.origin);
      continue;
    }
    audio::stoploopat("zmb_zod_player_cleanse_point", var_495730fe.origin);
  }
}

function ee_final_boss_attack_tell(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread postfx::playpostfxbundle("pstfx_ring_loop_purple");
    self playSound(0, "zmb_zod_player_cursed");
    if(!isDefined(self.var_379c83c)) {
      self.var_379c83c = self playLoopSound("zmb_zod_player_cursed_lp", 2);
    }
  } else {
    self postfx::exitpostfxbundle();
    self thread postfx::playpostfxbundle("pstfx_ring_loop_white");
    self playSound(0, "zmb_zod_player_cleansed");
    if(isDefined(self.var_379c83c)) {
      self stoploopsound(self.var_379c83c, 0.5);
      self.var_379c83c = undefined;
    }
    wait(0.25);
    self postfx::exitpostfxbundle();
  }
  self function_267f859f(localclientnum, level._effect["curse_tell"], newval, 1, "tag_origin");
}

function ee_rail_electricity_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_267f859f(localclientnum, level._effect["ee_quest_powerbox"], newval, 1, "tag_origin");
  if(newval == 1) {
    self playSound(0, "zmb_zod_rail_powerup");
  }
}

function function_1461c206(localclientnum, n_character_index) {
  if(!isDefined(level.var_673f721c)) {
    level.var_673f721c = [];
  }
  if(!isDefined(level.var_673f721c[localclientnum])) {
    level.var_673f721c[localclientnum] = [];
  }
  if(!isDefined(level.var_673f721c[localclientnum][n_character_index])) {
    level.var_673f721c[localclientnum][n_character_index] = spawnStruct();
  }
}

function function_274ba0e6(str_animname, var_e3c27047) {
  self notify("hash_274ba0e6");
  self endon("hash_274ba0e6");
  if(!isDefined(var_e3c27047)) {
    var_e3c27047 = 1;
  }
  while(true) {
    self animation::play(str_animname, undefined, undefined, var_e3c27047, 0, 0);
  }
}

function function_267f859f(localclientnum, fx_id = undefined, b_on = 1, var_afcc5d76 = 0, str_tag = "tag_origin") {
  if(b_on) {
    if(isDefined(self.vfx_ref)) {
      stopfx(localclientnum, self.vfx_ref);
    }
    if(var_afcc5d76) {
      self.vfx_ref = playFXOnTag(localclientnum, fx_id, self, str_tag);
    } else {
      if(self.angles === (0, 0, 0)) {
        self.vfx_ref = playFX(localclientnum, fx_id, self.origin);
      } else {
        self.vfx_ref = playFX(localclientnum, fx_id, self.origin, self.angles);
      }
    }
  } else if(isDefined(self.vfx_ref)) {
    stopfx(localclientnum, self.vfx_ref);
    self.vfx_ref = undefined;
  }
}

function near_apothigod_active(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_76ed0403)) {
    level.var_76ed0403 = new class_b454dc63();
    [[level.var_76ed0403]] - > init(localclientnum, self, 1);
  }
  thread[[level.var_76ed0403]] - > function_66844d0d(localclientnum, newval);
}

function far_apothigod_active(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_d566da8c)) {
    level.var_d566da8c = new class_b454dc63();
    [[level.var_d566da8c]] - > init(localclientnum, self, 0);
  }
  thread[[level.var_d566da8c]] - > function_66844d0d(localclientnum, newval);
}

function far_apothigod_roar(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  thread[[level.var_d566da8c]] - > function_2de612ff(localclientnum, self);
}

function near_apothigod_roar(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  thread[[level.var_76ed0403]] - > function_2de612ff(localclientnum, self);
}

function apothigod_death(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  thread[[level.var_76ed0403]] - > function_839ff35f(localclientnum, self);
}