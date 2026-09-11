/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_electricswitch.gsc
***********************************************/

function main() {
  script_model_anims();
}

function setup_switch(var_0) {
  var_1 = getEnt(var_0.target, "targetname");
  var_1 scripts\cp\utility::sethintobject("j_handle", "HINT_BUTTON", "icon_electrical_box", &"CP_STRIKE/TURN_ON_ALARM", 25, "duration_short", "hide", 128, 120, 70, 45);
  var_2 = spawnStruct();
  var_1.scenenode = var_0;
  var_1 scripts\engine\utility::ent_flag_init("switch_on");

  if(isDefined(var_1)) {
    thread switch_think();
  }

  return var_1;
}

function switch_think() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }

    self makeunusable();
    var_1 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_0, "player_rig", 1);
    var_2 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "fusebox_prop");

    if(!scripts\engine\utility::ent_flag("switch_on")) {
      var_2 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "interact_on", 1);
      var_3 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_2], "interact_on");

      if(var_3) {
        scripts\engine\utility::ent_flag_set("switch_on");
        self setHintString(&"CP_STRIKE/TURN_OFF_ALARM");
      }
    } else {
      var_2 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "interact", 1);
      var_3 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_2], "interact");

      if(var_3) {
        scripts\engine\utility::ent_flag_clear("switch_on");
        self setHintString(&"CP_STRIKE/TURN_ON_ALARM");
      }
    }

    self notify("interact", var_0);
    self makeusable();
    var_1 = undefined;
    var_2 = undefined;
  }
}

#using_animtree("");

function script_model_anims() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["interact"] = $wm_eq_fusebox_plr;
  level.scr_animname["player_rig"]["interact"] = "wm_eq_fusebox_plr";
  level.scr_eventanim["player_rig"]["interact"] = "wm_eq_fusebox_plr";
  level.scr_anim["player_rig"]["interact_on"] = % wm_eq_fusebox_turn_on_plr;
  level.scr_animname["player_rig"]["interact_on"] = "wm_eq_fusebox_turn_on_plr";
  level.scr_eventanim["player_rig"]["interact_on"] = "wm_eq_fusebox_turn_on_plr";
  level.scr_animtree["fusebox_prop"] = #animtree;
  level.scr_anim["fusebox_prop"]["interact"] = % wm_eq_fusebox_prop;
  level.scr_animname["fusebox_prop"]["interact"] = "wm_eq_fusebox_prop";
  level.scr_anim["fusebox_prop"]["interact_on"] = % wm_eq_fusebox_turn_on_prop;
  level.scr_animname["fusebox_prop"]["interact_on"] = "wm_eq_fusebox_turn_on_prop";
}