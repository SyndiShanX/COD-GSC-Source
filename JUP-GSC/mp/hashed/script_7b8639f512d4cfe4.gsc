/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7b8639f512d4cfe4.gsc
*************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\anim_scene;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace namespace_a6891c3d100a6a05;

function main() {
  function_c25a40ae517ef340();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("usable_left", &function_e8e4bb2f83e5055a);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("usable_right", &function_e8e4bb2f83e5055a);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("usable_front", &function_e8e4bb2f83e5055a);
}

function function_a6891c3d100a6a05(samsite, player, dir) {
  level endon("game_ended");
  samsite setscriptablepartstate("usable_left", "unusable");
  samsite setscriptablepartstate("usable_front", "unusable");
  samsite setscriptablepartstate("usable_right", "unusable");
  samsite.scenenode = spawnStruct();
  samsite.scenenode.origin = samsite.origin;
  samsite.scenenode.angles = samsite.angles;

  if(isDefined(level.var_187bff90aa51742f)) {
    if(isDefined(player)) {
      player thread[[level.var_187bff90aa51742f]]();
    }
  }

  actorplayer = anim_scene_create_actor(player, "player_rig_sm", 1);
  c4 = spawn("script_model", actorplayer.entity gettagorigin("tag_accessory_right"));
  c4 hide();
  c4.angles = actorplayer.entity gettagangles("tag_accessory_right");
  c4 dontinterpolate();
  c4 linkTo(actorplayer.entity, "tag_accessory_right");

  if(isDefined(level.var_2179c46fc54fd9ce)) {
    c4 setModel(level.var_2179c46fc54fd9ce);
  } else {
    c4 setModel("offhand_2h_c4_prop_cp");
  }

  thread showc4(c4);
  c4 thread function_e9508a0db7cc3e83();

  if(istrue(level.var_5c9a3961728ac52f)) {
    player.var_385a26c0bfc712b4 = 1;
  }

  if(dir == "right") {
    var_db3b2bd857f61ae6 = samsite.scenenode anim_scene([actorplayer], "samsite_plant_l");
  } else if(dir == "left") {
    var_db3b2bd857f61ae6 = samsite.scenenode anim_scene([actorplayer], "samsite_plant_r");
  } else {
    var_db3b2bd857f61ae6 = samsite.scenenode anim_scene([actorplayer], "samsite_plant_f");
  }

  if(istrue(level.var_5c9a3961728ac52f)) {
    player.var_385a26c0bfc712b4 = 0;
    c4.var_7b0e1793e94cafb4 = var_db3b2bd857f61ae6;
  }

  c4 unlink();
  actorplayer = undefined;
  actorc4 = undefined;

  if(isDefined(level.var_d73f1dd12f69b96e)) {
    if(isDefined(player)) {
      player thread[[level.var_d73f1dd12f69b96e]]();
    }
  }

  if(isDefined(level.var_3f4534fb14cca909)) {
    detonate_success = [[level.var_3f4534fb14cca909]](c4, samsite, player);

    if(!istrue(detonate_success)) {
      c4 hide();
      return;
    }
  } else {
    function_236a1fe93e41c498(c4);
  }

  c4 setscriptablepartstate("effects", "explode");

  if(isDefined(level.var_fa3f2cef70b746cf)) {
    if(isDefined(player)) {
      player thread[[level.var_fa3f2cef70b746cf]]();
    }
  }

  wait 0.5;
  c4 delete();
}

function function_e9508a0db7cc3e83() {
  wait 1;

  if(soundexists("weap_samsite_plant_c4")) {
    self playSound("weap_samsite_plant_c4");
  }
}

function showc4(c4) {
  c4 endon("death");
  wait 1;
  c4 show();
}

function function_e8e4bb2f83e5055a(instance, part, state, player, bautouse, usestring) {
  dir = "left";

  if(part == "usable_right") {
    dir = "right";
  } else if(part == "usable_front") {
    dir = "front";
  }

  function_a6891c3d100a6a05(instance, player, dir);
}

function function_236a1fe93e41c498(c4) {
  currenttime = gettime();
  bombendtime = int(currenttime + 5000);
  var_c301d652d9a73075 = bombendtime - currenttime;

  while(var_c301d652d9a73075 > 0) {
    currenttime = gettime();
    var_c301d652d9a73075 = bombendtime - currenttime;

    if(var_c301d652d9a73075 < 1500) {
      if(var_c301d652d9a73075 <= 250) {
        if(soundexists("breach_warning_beep_05")) {
          c4 playSound("breach_warning_beep_05");
        }
      } else if(var_c301d652d9a73075 < 500) {
        if(soundexists("breach_warning_beep_04")) {
          c4 playSound("breach_warning_beep_04");
        }
      } else if(var_c301d652d9a73075 < 1500) {
        if(soundexists("breach_warning_beep_03")) {
          c4 playSound("breach_warning_beep_03");
        }
      } else if(soundexists("breach_warning_beep_02")) {
        c4 playSound("breach_warning_beep_02");
      }

      wait 0.25;
    } else if(var_c301d652d9a73075 < 3500) {
      if(soundexists("breach_warning_beep_02")) {
        c4 playSound("breach_warning_beep_02");
      }

      wait 0.5;
    } else {
      if(soundexists("breach_warning_beep_01")) {
        c4 playSound("breach_warning_beep_01");
      }

      wait 1;
    }

    if(var_c301d652d9a73075 < 0) {
      break;
    }
  }
}

#using_animtree("script_model");

function function_c25a40ae517ef340() {
  level.scr_animtree["player_rig_sm"] = #animtree;
  level.scr_anim["player_rig_sm"]["samsite_plant_l"] = % iw9_sam_breach_charge_left;
  level.scr_eventanim["player_rig_sm"]["samsite_plant_l"] = % "iw9_sam_breach_charge_left";
  level.scr_anim["player_rig_sm"]["samsite_plant_r"] = % iw9_sam_breach_charge_right;
  level.scr_eventanim["player_rig_sm"]["samsite_plant_r"] = % "iw9_sam_breach_charge_right";
  level.scr_anim["player_rig_sm"]["samsite_plant_f"] = % iw9_cp_sam_breach_charge_front;
  level.scr_eventanim["player_rig_sm"]["samsite_plant_f"] = % "hash_7e94c3dd66a3eca0";
  level.scr_animtree["c4_prop"] = #animtree;
  level.scr_anim["c4_prop"]["samsite_plant_l"] = % iw9_cp_sam_breach_charge_left_c4;
  level.scr_anim["c4_prop"]["samsite_plant_r"] = % iw9_cp_sam_breach_charge_right_c4;
  level.scr_anim["c4_prop"]["samsite_plant_f"] = % iw9_cp_sam_breach_charge_front_c4;
}