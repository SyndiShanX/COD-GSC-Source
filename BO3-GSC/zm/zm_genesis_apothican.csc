/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_apothican.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\exploder_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using_animtree("generic");
#namespace zm_genesis_apothican;

function autoexec __init__sytem__() {
  system::register("zm_genesis_apothican", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("allplayers", "apothicon_player_keyline", 15000, 1, "int", & apothicon_player_keyline, 0, 0);
  clientfield::register("toplayer", "apothicon_entry_postfx", 15000, 1, "int", & apothicon_entry_postfx, 0, 0);
  clientfield::register("world", "gas_fog_bank_switch", 15000, 1, "int", & gas_fog_bank_switch, 0, 0);
  clientfield::register("scriptmover", "egg_spawn_fx", 15000, 1, "int", & egg_spawn_fx, 0, 0);
  clientfield::register("scriptmover", "gateworm_mtl", 15000, 1, "int", & gateworm_mtl, 0, 0);
  clientfield::register("toplayer", "player_apothicon_egg", 15000, 1, "int", & zm_utility::setinventoryuimodels, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.widget_apothicon_egg", 15000, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.player_apothicon_egg_bg", 15000, 1, "int", undefined, 0, 0);
  clientfield::register("toplayer", "player_gate_worm", 15000, 1, "int", & zm_utility::setinventoryuimodels, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.widget_gate_worm", 15000, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.player_gate_worm_bg", 15000, 1, "int", undefined, 0, 0);
  level.var_e8af7a2f = 0;
}

function function_b77a78c9(localclientnum, str_fx, v_origin, n_duration, v_angles) {
  if(isDefined(v_angles)) {
    fx = playFX(localclientnum, str_fx, v_origin, v_angles);
  } else {
    fx = playFX(localclientnum, str_fx, v_origin);
  }
  wait(n_duration);
  stopfx(localclientnum, fx);
}

function scene_play(scene, var_165d49f6) {
  self notify("scene_play");
  self endon("scene_play");
  self scene::stop();
  self function_6221b6b9(scene, var_165d49f6);
  self scene::stop();
}

function function_6221b6b9(scene, var_165d49f6) {
  level endon("demo_jump");
  self scene::play(scene, var_165d49f6);
}

function apothicon_player_keyline(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isspectating(localclientnum) && self islocalplayer() && localclientnum == self getlocalclientnumber()) {
    return;
  }
  if(newval == 1) {
    self duplicate_render::set_dr_flag("keyline_active", 0);
    self duplicate_render::update_dr_filters(localclientnum);
  } else {
    self duplicate_render::set_dr_flag("keyline_active", 1);
    self duplicate_render::update_dr_filters(localclientnum);
  }
}

function apothicon_entry_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("apothicon_entry_postfx");
  self endon("apothicon_entry_postfx");
  if(newval == 1) {
    if(isdemoplaying() && demoisanyfreemovecamera()) {
      return;
    }
    self thread function_e7a8756e(localclientnum);
    self thread postfx::playpostfxbundle("pstfx_gen_apothicon_swallow");
    playSound(0, "zmb_apothigod_mouth_start", (0, 0, 0));
  } else {
    playSound(0, "zmb_apothigod_mouth_eject", (0, 0, 0));
    self notify("apothicon_entry_complete");
  }
}

function function_e7a8756e(localclientnum) {
  self util::waittill_any("apothicon_entry_postfx", "apothicon_entry_complete");
  self postfx::exitpostfxbundle();
}

function gas_fog_bank_switch(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    level.var_e8af7a2f = 1;
    for(localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
      if(level.var_b7572a82) {
        setworldfogactivebank(localclientnum, 8);
        continue;
      }
      setworldfogactivebank(localclientnum, 4);
    }
  } else {
    for(localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
      if(level.var_b7572a82) {
        setworldfogactivebank(localclientnum, 2);
        continue;
      }
      setworldfogactivebank(localclientnum, 1);
    }
    level.var_e8af7a2f = 0;
  }
}

function egg_spawn_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_70a0d336 = playFXOnTag(localclientnum, level._effect["egg_spawn_fx"], self, "tag_origin");
  } else if(isDefined(self) && isDefined(self.var_70a0d336)) {
    stopfx(localclientnum, self.var_70a0d336);
    self.var_70a0d336 = undefined;
  }
}

function gateworm_mtl(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0);
}