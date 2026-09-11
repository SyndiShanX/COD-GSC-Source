/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_breach_c4.gsc
***********************************************/

function main() {
  script_model_anims();
}

function setup_c4(var0) {
  if(isDefined(var0)) {
    var1 = spawn("script_model", var0.origin);
    var1 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", "hud_icon_c4_plant", &"CP_STRIKE/PLANT_EXPLOSIVE", 25, "duration_medium", "show", 250, 45, 70, 45);
    var2 = spawnStruct();
    var2.origin = scripts\engine\utility::getStruct(var0.target, "targetname").origin;
    var2.angles = scripts\engine\utility::getStruct(var0.target, "targetname").angles;

    if(!isDefined(var2.angles)) {
      var2.angles = (0, 0, 0);
    }

    var1.scenenode = var2;
    var1 scripts\engine\utility::ent_flag_init("c4_planted");
    var1 scripts\engine\utility::ent_flag_init("c4_exploded");

    if(isDefined(var1)) {
      thread c4_breach_think(var1);
    }

    return var1;
  }

  return undefined;
}

function c4_breach_think(var0) {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var1);

    if(!isPlayer(var1)) {
      continue;
    }

    self makeunusable();
    level notify("used_c4", var1);

    if(istrue(self.bskipplantsequence)) {
      if(isDefined(level.brmini_createc130pathstruct)) {
        self[[level.brmini_createc130pathstruct]](var1);
      }

      return;
    }

    thread force_bleedout_all_downed_players(level);
    var2 = spawn("script_model", self.scenenode.origin);
    var2.angles = self.scenenode.angles;
    var2 setModel("offhand_wm_c4_cp");
    var1.ref_140ae = 1;
    var3 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var1, "player_rig", 1);
    var4 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var2, "c4_prop");
    var4 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "c4_plant", 1);
    var5 = 0;

    if(istrue(var1.isjuggernaut)) {
      var5 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var3, var4], "c4_plant", undefined, undefined, undefined, undefined, undefined, 1);
    } else {
      var5 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var3, var4], "c4_plant");
    }

    if(var5) {
      scripts\engine\utility::ent_flag_set("c4_planted");
      thread c4_explode(level, self);
      thread force_ai_to_drop_thermites(level);
      var1.ref_140ae = undefined;
      return;
    } else {
      if(isDefined(var2)) {
        var2 delete();
      }

      self makeusable();
    }

    var1.ref_140ae = undefined;
    var3 = undefined;
    var4 = undefined;
  }
}

function force_bleedout_all_downed_players(var0) {
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_breach_setting");
}

function force_ai_to_drop_thermites(var0) {
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_breach_set");
}

function c4_explode(var0, var1) {
  var1 setscriptablepartstate("effects", "plant", 0);
  var2 = gettime();
  var3 = int(var2 + 5000);
  var4 = var3 - var2;

  if(istrue(var0.bskipplantsequence)) {
    var4 = 0;
  }

  while(var4 > 0) {
    var2 = gettime();
    var4 = var3 - var2;

    if(var4 < 1500) {
      if(var4 <= 250) {
        if(soundexists("breach_warning_beep_05")) {
          var1 playSound("breach_warning_beep_05");
        }
      } else if(var4 < 500) {
        if(soundexists("breach_warning_beep_04")) {
          var1 playSound("breach_warning_beep_04");
        }
      } else if(var4 < 1500) {
        if(soundexists("breach_warning_beep_03")) {
          var1 playSound("breach_warning_beep_03");
        }
      } else if(soundexists("breach_warning_beep_02")) {
        var1 playSound("breach_warning_beep_02");
      }

      wait 0.25;
    } else if(var4 < 3500) {
      if(soundexists("breach_warning_beep_02")) {
        var1 playSound("breach_warning_beep_02");
      }

      wait 0.5;
    } else {
      if(soundexists("breach_warning_beep_01")) {
        var1 playSound("breach_warning_beep_01");
      }

      wait 1;
    }

    if(var4 < 0) {
      break;
    }
  }

  if(!istrue(var0.bskipplantsequence)) {
    physicsexplosionsphere(var1.origin, 200, 100, 3);
    var1 setscriptablepartstate("effects", "explodeWall");
  }

  var0 scripts\engine\utility::ent_flag_set("c4_exploded");
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