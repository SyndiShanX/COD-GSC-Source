/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_ice_slide.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\gestures;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_audio;

#namespace zm_orange_ice_slide;

init() {
  var_fa0bcfcc = getent("ice_slide", "targetname");
  var_fa0bcfcc callback::on_trigger(&function_a8fc3bf1);
  var_fa0bcfcc.var_80360a02 = 0;
}

function_a8fc3bf1(s_info) {
  e_player = s_info.activator;

  if(isalive(e_player) && !(isDefined(e_player.var_e0348559) && e_player.var_e0348559)) {
    e_player endon(#"death");
    mdl_sound = util::spawn_model(#"tag_origin", e_player gettagorigin("tag_origin"), e_player gettagangles("tag_origin"));

    if(isDefined(mdl_sound)) {
      mdl_sound linkto(e_player, "tag_origin");
      mdl_sound playLoopSound("evt_ice_slide");
    }

    if(self.var_80360a02 === 0 && e_player zm_audio::can_speak()) {
      self.var_80360a02 = 1;
      self.var_4ed9c192 = e_player;
      e_player thread zm_audio::create_and_play_dialog(#"ice", #"slide_start");
    }

    e_player allowstand(0);
    e_player allowjump(0);
    e_player allowprone(0);
    stance = e_player getstance();
    e_player.var_e0348559 = 1;
    e_player thread gestures::function_b6cc48ed("ges_force_slide_loop", undefined, 1);

    while(isalive(e_player) && e_player istouching(self)) {
      waitframe(1);
    }

    if(self.var_4ed9c192 === e_player) {
      self.var_4ed9c192 = e_player;
      e_player thread function_9565c969();
      self.var_4ed9c192 = undefined;
    }

    if(isDefined(e_player)) {
      e_player.var_e0348559 = 0;
      e_player allowstand(1);
      e_player allowjump(1);
      e_player allowprone(1);

      if(isalive(e_player)) {
        e_player stopgestureviewmodel("ges_force_slide_loop", 0.1, 0);

        if(isDefined(stance)) {
          e_player setstance(stance);
        }
      }
    }

    if(isDefined(mdl_sound)) {
      mdl_sound delete();
    }
  }
}

function_9565c969() {
  while(!self zm_audio::can_speak()) {
    waitframe(1);
  }

  self zm_audio::create_and_play_dialog(#"ice", #"slide_end");
}