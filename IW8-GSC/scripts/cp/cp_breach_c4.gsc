/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_breach_c4.gsc
***********************************************/

function main() {
  script_model_anims();
}

function setup_c4(var_0) {
  if(isDefined(var_0)) {
    var_1 = spawn("script_model", var_0.origin);
    var_1 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", "hud_icon_c4_plant", &"CP_STRIKE/PLANT_EXPLOSIVE", 25, "duration_medium", "show", 250, 45, 70, 45);
    var_2 = spawnStruct();
    var_2.origin = scripts\engine\utility::getStruct(var_0.target, "targetname").origin;
    var_2.angles = scripts\engine\utility::getStruct(var_0.target, "targetname").angles;

    if(!isDefined(var_2.angles)) {
      var_2.angles = (0, 0, 0);
    }

    var_1.scenenode = var_2;
    var_1 scripts\engine\utility::ent_flag_init("c4_planted");
    var_1 scripts\engine\utility::ent_flag_init("c4_exploded");

    if(isDefined(var_1)) {
      thread c4_breach_think(var_1);
    }

    return var_1;
  }

  return undefined;
}

function c4_breach_think(var_0) {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }

    self makeunusable();
    level notify("used_c4", var_1);

    if(istrue(self.bskipplantsequence)) {
      if(isDefined(level.brmini_createc130pathstruct)) {
        self[[level.brmini_createc130pathstruct]](var_1);
      }

      return;
    }

    thread force_bleedout_all_downed_players(level);
    var_2 = spawn("script_model", self.scenenode.origin);
    var_2.angles = self.scenenode.angles;
    var_2 setModel("offhand_wm_c4_cp");
    var_1.ref_140AE = 1;
    var_3 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_1, "player_rig", 1);
    var_4 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_2, "c4_prop");
    var_4 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "c4_plant", 1);
    var_5 = 0;

    if(istrue(var_1.isjuggernaut)) {
      var_5 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_3, var_4], "c4_plant", undefined, undefined, undefined, undefined, undefined, 1);
    } else {
      var_5 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_3, var_4], "c4_plant");
    }

    if(var_5) {
      scripts\engine\utility::ent_flag_set("c4_planted");
      thread c4_explode(level, self);
      thread force_ai_to_drop_thermites(level);
      var_1.ref_140AE = undefined;
      return;
    } else {
      if(isDefined(var_2)) {
        var_2 delete();
      }

      self makeusable();
    }

    var_1.ref_140AE = undefined;
    var_3 = undefined;
    var_4 = undefined;
  }
}

function force_bleedout_all_downed_players(var_0) {
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_breach_setting");
}

function force_ai_to_drop_thermites(var_0) {
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_breach_set");
}

function c4_explode(var_0, var_1) {
  var_1 setscriptablepartstate("effects", "plant", 0);
  var_2 = gettime();
  var_3 = int(var_2 + 5000);
  var_4 = var_3 - var_2;

  if(istrue(var_0.bskipplantsequence)) {
    var_4 = 0;
  }

  while(var_4 > 0) {
    var_2 = gettime();
    var_4 = var_3 - var_2;

    if(var_4 < 1500) {
      if(var_4 <= 250) {
        if(soundexists("breach_warning_beep_05")) {
          var_1 playSound("breach_warning_beep_05");
        }
      } else if(var_4 < 500) {
        if(soundexists("breach_warning_beep_04")) {
          var_1 playSound("breach_warning_beep_04");
        }
      } else if(var_4 < 1500) {
        if(soundexists("breach_warning_beep_03")) {
          var_1 playSound("breach_warning_beep_03");
        }
      } else if(soundexists("breach_warning_beep_02")) {
        var_1 playSound("breach_warning_beep_02");
      }

      wait 0.25;
    } else if(var_4 < 3500) {
      if(soundexists("breach_warning_beep_02")) {
        var_1 playSound("breach_warning_beep_02");
      }

      wait 0.5;
    } else {
      if(soundexists("breach_warning_beep_01")) {
        var_1 playSound("breach_warning_beep_01");
      }

      wait 1;
    }

    if(var_4 < 0) {
      break;
    }
  }

  if(!istrue(var_0.bskipplantsequence)) {
    physicsexplosionsphere(var_1.origin, 200, 100, 3);
    var_1 setscriptablepartstate("effects", "explodeWall");
  }

  var_0 scripts\engine\utility::ent_flag_set("c4_exploded");
}

#using_animtree("");

function script_model_anims() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["c4_plant"] = $wm_equip_c4_attach;
  level.scr_animname["player_rig"]["c4_plant"] = "wm_equip_c4_attach";
  level.scr_eventanim["player_rig"]["c4_plant"] = "equip_c4_attach";
  level.scr_animtree["c4_prop"] = #animtree;
  level.scr_anim["c4_prop"]["c4_plant"] = % wm_equip_c4_attach_c4;
  level.scr_animname["c4_prop"]["c4_plant"] = "wm_equip_c4_attach_c4";
}