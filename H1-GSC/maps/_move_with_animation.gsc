/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_move_with_animation.gsc
*****************************************/

carrystart(var_0, var_1, var_2) {
  setsaveddvar("cl_NoWeaponBobAmplitudeVertical", 2.5);
  setsaveddvar("cl_NoWeaponBobAmplitudeHorizontal", 2.5);
  level.eplayerview dontcastshadows();
  level.eplayerview.origin = level.player.origin;
  level.eplayerview.angles = level.player getplayerangles();

  if(isdefined(var_2) && var_2) {
    level.player maps\_anim::anim_first_frame_solo(level.eplayerview, "carry_idle");
    level.player maps\_anim::anim_first_frame_solo(var_0, "carry_idle");
    wait 0.1;
  }

  level.m_player_rig = level.eplayerview;
  level.m_carried = var_0;
  level.m_carried setcontents(0);
  level.m_carried dontcastshadows();
  level.m_player_spot = level.m_player_rig common_scripts\utility::spawn_tag_origin();
  level.m_player_spot.angles = (0, level.m_player_rig.angles[1], 0);
  level.m_player_spot thread maps\_anim::anim_loop_solo(level.m_player_rig, "carry_idle");
  level.m_player_rig thread maps\_anim::anim_loop_solo(level.m_carried, "carry_idle");
  level.m_carried linktoplayerviewignoreparentrot(level.player, "tag_origin", (0, 0, -60), (0, 0, 0), 1, 0, 1, 0);
  level.m_player_rig linktoplayerviewignoreparentrot(level.player, "tag_origin", (0, 0, -60), (0, 0, 0), 1, 0, 1, 0);
  wait 0.05;
  thread carrymoveloop(var_1);
}

carrymoveloop(var_0) {
  level.player endon("death");
  level.m_player_spot endon("death");
  var_1 = 0.05;
  level.m_player_carry_moving = 0;
  level.m_player_carry_ladder = 0;
  var_2 = 0;
  var_3 = 0;

  while ([
      [var_0]
    ]()) {
    var_2 = level.player isonladder();
    var_4 = level.player getnormalizedmovement();
    var_5 = length(var_4);
    var_3 = var_5 > 0;
    carryupdateanimation(var_2, var_3, var_5);
    wait(var_1);
  }
}

carryupdateanimation(var_0, var_1, var_2) {
  var_3 = level.m_player_carry_ladder;
  var_4 = level.m_player_carry_moving;

  if(var_0) {
    if(!var_3) {
      level.m_player_spot notify("stop_loop");
      level.m_player_rig notify("stop_loop");
      level.m_carried setanimtime(level.m_carried maps\_utility::getanim("ladder_on"), 0);
      level.m_player_spot thread maps\_anim::anim_single_solo(level.m_player_rig, "ladder_on");
      level.m_player_rig thread maps\_anim::anim_single_solo(level.m_carried, "ladder_on");
    }
  } else if(var_3) {
    level.m_player_spot thread maps\_anim::anim_single_solo(level.m_player_rig, "ladder_off");
    level.m_player_rig thread maps\_anim::anim_single_solo(level.m_carried, "ladder_off");
  } else if(!var_1 && var_4) {
    level.m_player_spot notify("stop_loop");
    level.m_player_rig notify("stop_loop");
    level.m_player_spot thread maps\_anim::anim_loop_solo(level.m_player_rig, "carry_idle");
    level.m_player_rig thread maps\_anim::anim_loop_solo(level.m_carried, "carry_idle");
  } else if(var_1 && !var_4) {
    level.m_player_spot notify("stop_loop");
    level.m_player_rig notify("stop_loop");
    level.m_player_spot thread maps\_anim::anim_loop_solo(level.m_player_rig, "carry_run");
    level.m_player_rig thread maps\_anim::anim_loop_solo(level.m_carried, "carry_run");
  }

  var_5 = 0;

  if(var_1 && !var_0 && !var_3) {
    var_6 = level.m_player_rig getanimtime(level.scr_anim[level.m_player_rig.animname]["carry_run"][0]);
    level.m_carried setanimtime(level.scr_anim[level.m_carried.animname]["carry_run"][0], var_6);
    level.m_player_rig setflaggedanim("looping anim", level.scr_anim[level.m_player_rig.animname]["carry_run"][0], 1, 0, var_2);
    level.m_carried setflaggedanim("looping anim", level.scr_anim[level.m_carried.animname]["carry_run"][0], 1, 0, var_2);
    var_5 = 1;
  }

  level.m_player_carry_ladder = var_0;
  level.m_player_carry_moving = var_5;
}

carrystop() {
  setsaveddvar("cl_NoWeaponBobAmplitudeVertical", 0.0);
  setsaveddvar("cl_NoWeaponBobAmplitudeHorizontal", 0.0);
  level.player _meth_8573();
  level.player unlink();
  level.m_carried unlink();
  level.m_carried = undefined;
  level.m_player_rig = undefined;
  level.m_player_spot delete();
  level.m_player_spot = undefined;
  level.player enablemousesteer(0);
}