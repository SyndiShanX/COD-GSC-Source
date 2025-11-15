/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_notetracks.gsc
***************************************************/

#include scripts\core_common\ai\archetype_human_cover;
#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\systems\shared;
#include scripts\core_common\ai_shared;

#namespace animationstatenetwork;

autoexec registerdefaultnotetrackhandlerfunctions() {
  registernotetrackhandlerfunction("fire", &notetrackfirebullet);
  registernotetrackhandlerfunction("gib_disable", &notetrackgibdisable);
  registernotetrackhandlerfunction("gib = \"head\"", &gibserverutils::gibhead);
  registernotetrackhandlerfunction("gib = \"arm_left\"", &gibserverutils::gibleftarm);
  registernotetrackhandlerfunction("gib = \"arm_right\"", &gibserverutils::gibrightarm);
  registernotetrackhandlerfunction("gib = \"leg_left\"", &gibserverutils::gibleftleg);
  registernotetrackhandlerfunction("gib = \"leg_right\"", &gibserverutils::gibrightleg);
  registernotetrackhandlerfunction("dropgun", &notetrackdropgun);
  registernotetrackhandlerfunction("gun drop", &notetrackdropgun);
  registernotetrackhandlerfunction("drop_shield", &notetrackdropshield);
  registernotetrackhandlerfunction("hide_weapon", &notetrackhideweapon);
  registernotetrackhandlerfunction("show_weapon", &notetrackshowweapon);
  registernotetrackhandlerfunction("hide_ai", &notetrackhideai);
  registernotetrackhandlerfunction("show_ai", &notetrackshowai);
  registernotetrackhandlerfunction("attach_knife", &notetrackattachknife);
  registernotetrackhandlerfunction("detach_knife", &notetrackdetachknife);
  registernotetrackhandlerfunction("grenade_throw", &notetrackgrenadethrow);
  registernotetrackhandlerfunction("start_ragdoll", &notetrackstartragdoll);
  registernotetrackhandlerfunction("ragdoll_nodeath", &notetrackstartragdollnodeath);
  registernotetrackhandlerfunction("unsync", &notetrackmeleeunsync);
  registernotetrackhandlerfunction("step1", &notetrackstaircasestep1);
  registernotetrackhandlerfunction("step2", &notetrackstaircasestep2);
  registernotetrackhandlerfunction("anim_movement = \"stop\"", &notetrackanimmovementstop);
  registerblackboardnotetrackhandler("anim_pose = \\"
    stand\\"", "_stance", "stand");
  registerblackboardnotetrackhandler("anim_pose = \\"
    crouch\\"", "_stance", "crouch");
  registerblackboardnotetrackhandler("anim_pose = \\"
    prone_front\\"", "_stance", "prone_front");
  registerblackboardnotetrackhandler("anim_pose = \\"
    prone_back\\"", "_stance", "prone_back");
  registerblackboardnotetrackhandler("anim_pose = stand", "_stance", "stand");
  registerblackboardnotetrackhandler("anim_pose = crouch", "_stance", "crouch");
  registerblackboardnotetrackhandler("anim_pose = prone_front", "_stance", "prone_front");
  registerblackboardnotetrackhandler("anim_pose = prone_back", "_stance", "prone_back");
}

private notetrackanimmovementstop(entity) {
  if(entity haspath()) {
    entity pathmode("move delayed", 1, randomfloatrange(2, 4));
  }
}

private notetrackstaircasestep1(entity) {
  numsteps = entity getblackboardattribute("_staircase_num_steps");
  numsteps++;
  entity setblackboardattribute("_staircase_num_steps", numsteps);
}

private notetrackstaircasestep2(entity) {
  numsteps = entity getblackboardattribute("_staircase_num_steps");
  numsteps += 2;
  entity setblackboardattribute("_staircase_num_steps", numsteps);
}

private notetrackdropguninternal(entity) {
  if(!isDefined(entity.weapon) || entity.weapon === level.weaponnone) {
    return;
  }

  if(isDefined(entity.ai) && isDefined(entity.ai.var_7c61677c) && entity.ai.var_7c61677c) {
    if(isalive(entity)) {
      return;
    }
  }

  entity.lastweapon = entity.weapon;
  primaryweapon = entity.primaryweapon;
  secondaryweapon = entity.secondaryweapon;
  entity thread shared::dropaiweapon();
}

private notetrackattachknife(entity) {
  if(!(isDefined(entity._ai_melee_attachedknife) && entity._ai_melee_attachedknife)) {
    entity attach(#"wpn_t7_knife_combat_prop", "TAG_WEAPON_LEFT");
    entity._ai_melee_attachedknife = 1;
  }
}

private notetrackdetachknife(entity) {
  if(isDefined(entity._ai_melee_attachedknife) && entity._ai_melee_attachedknife) {
    entity detach(#"wpn_t7_knife_combat_prop", "TAG_WEAPON_LEFT");
    entity._ai_melee_attachedknife = 0;
  }
}

private notetrackhideweapon(entity) {
  entity ai::gun_remove();
}

private notetrackshowweapon(entity) {
  entity ai::gun_recall();
}

private notetrackhideai(entity) {
  entity hide();
}

private notetrackshowai(entity) {
  entity show();
}

private notetrackstartragdoll(entity) {
  if(isactor(entity) && entity isinscriptedstate()) {
    entity.overrideactordamage = undefined;
    entity.allowdeath = 1;
    entity.skipdeath = 1;
    entity kill();
  }

  notetrackdropguninternal(entity);
  entity startragdoll();
}

_delayedragdoll(entity) {
  wait 0.25;

  if(isDefined(entity) && !entity isragdoll()) {
    entity startragdoll();
  }
}

notetrackstartragdollnodeath(entity) {
  if(isDefined(entity._ai_melee_opponent)) {
    entity._ai_melee_opponent unlink();
  }

  entity thread _delayedragdoll(entity);
}

private notetrackfirebullet(animationentity) {
  if(isactor(animationentity) && animationentity isinscriptedstate()) {
    if(animationentity.weapon != level.weaponnone) {
      animationentity notify(#"about_to_shoot");
      startpos = animationentity gettagorigin("tag_flash");
      endpos = startpos + vectorscale(animationentity getweaponforwarddir(), 100);
      magicbullet(animationentity.weapon, startpos, endpos, animationentity);
      animationentity notify(#"shoot");

      if(!isDefined(animationentity.ai.bulletsinclip)) {
        animationentity.ai.bulletsinclip = 0;
        return;
      }

      animationentity.ai.bulletsinclip--;
    }
  }
}

private notetrackdropgun(animationentity) {
  notetrackdropguninternal(animationentity);
}

private notetrackdropshield(animationentity) {
  aiutility::dropriotshield(animationentity);
}

private notetrackgrenadethrow(animationentity) {
  if(archetype_human_cover::shouldthrowgrenadeatcovercondition(animationentity, 1)) {
    animationentity grenadethrow();
    return;
  }

  if(isDefined(animationentity.grenadethrowposition)) {
    arm_offset = archetype_human_cover::temp_get_arm_offset(animationentity, animationentity.grenadethrowposition);
    throw_vel = animationentity canthrowgrenadepos(arm_offset, animationentity.grenadethrowposition);

    if(isDefined(throw_vel)) {
      animationentity grenadethrow();
    }
  }
}

private notetrackmeleeunsync(animationentity) {
  if(isDefined(animationentity) && isDefined(animationentity.enemy)) {
    if(isDefined(animationentity.enemy._ai_melee_markeddead) && animationentity.enemy._ai_melee_markeddead) {
      animationentity unlink();
    }
  }
}

private notetrackgibdisable(animationentity) {
  if(animationentity ai::has_behavior_attribute("can_gib")) {
    animationentity ai::set_behavior_attribute("can_gib", 0);
  }
}