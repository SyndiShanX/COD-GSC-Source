/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_electricswitch.gsc
***********************************************/

main() {
  script_model_anims();
}

setup_switch(_id_BD16F0D97883FD8D, _id_77A22B500C7649B6) {
  _id_986B8009317A967A = getEnt(_id_BD16F0D97883FD8D.target, "targetname");
  _id_986B8009317A967A scripts\cp\utility::sethintobject("j_handle", "HINT_BUTTON", "icon_electrical_box", &"CP_STRIKE/TURN_ON_ALARM", 25, "duration_short", "hide", 128, 120, 70, 45);
  _id_57C725B08C65A433 = spawnStruct();
  _id_986B8009317A967A.scenenode = _id_BD16F0D97883FD8D;
  _id_986B8009317A967A scripts\engine\utility::ent_flag_init("switch_on");

  if(isDefined(_id_986B8009317A967A))
    _id_986B8009317A967A thread switch_think(_id_77A22B500C7649B6);

  return _id_986B8009317A967A;
}

switch_think(_id_77A22B500C7649B6) {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    self makeunusable();

    if(istrue(self.disabled)) {
      wait 0.25;
      self makeusable();
      continue;
    }

    if(!istrue(_id_77A22B500C7649B6))
      actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "player_rig", 1);
    else
      actorplayer = undefined;

    _id_3A5CD5B61D43290C = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "fusebox_prop");
    self makeusable();

    if(!scripts\engine\utility::ent_flag("switch_on")) {
      _id_3A5CD5B61D43290C scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "interact_on", 1);

      if(istrue(_id_77A22B500C7649B6))
        result = self.scenenode scripts\cp_mp\anim_scene::anim_scene([_id_3A5CD5B61D43290C], "interact_on");
      else
        result = self.scenenode scripts\cp_mp\anim_scene::anim_scene([_id_3A5CD5B61D43290C, actorplayer], "interact_on");

      if(result) {
        scripts\engine\utility::ent_flag_set("switch_on");
        self setHintString(&"CP_STRIKE/TURN_OFF_ALARM");
      }
    } else {
      _id_3A5CD5B61D43290C scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "interact", 1);

      if(istrue(_id_77A22B500C7649B6))
        result = self.scenenode scripts\cp_mp\anim_scene::anim_scene([_id_3A5CD5B61D43290C], "interact");
      else
        result = self.scenenode scripts\cp_mp\anim_scene::anim_scene([_id_3A5CD5B61D43290C, actorplayer], "interact");

      if(result) {
        scripts\engine\utility::ent_flag_clear("switch_on");
        self setHintString(&"CP_STRIKE/TURN_ON_ALARM");
      }
    }

    self notify("interact", player);
    actorplayer = undefined;
    _id_3A5CD5B61D43290C = undefined;
  }
}

#using_animtree("script_model");

script_model_anims() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["interact"] = % wm_eq_fusebox_plr;
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