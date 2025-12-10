/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_notetracks.gsc
*************************************************/

#using scripts\shared\ai\archetype_human_cover;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\ai_blackboard;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\systems\shared;
#using scripts\shared\ai_shared;
#namespace animationstatenetwork;

function autoexec registerdefaultnotetrackhandlerfunctions() {
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
  registerblackboardnotetrackhandler("anim_pose = \"stand\"", "_stance", "stand");
  registerblackboardnotetrackhandler("anim_pose = \"crouch\"", "_stance", "crouch");
  registerblackboardnotetrackhandler("anim_pose = \"prone_front\"", "_stance", "prone_front");
  registerblackboardnotetrackhandler("anim_pose = \"prone_back\"", "_stance", "prone_back");
}

function private notetrackanimmovementstop(entity) {
  if(entity haspath()) {
    entity pathmode("move delayed", 1, randomfloatrange(2, 4));
  }
}

function private notetrackstaircasestep1(entity) {
  numsteps = blackboard::getblackboardattribute(entity, "_staircase_num_steps");
  numsteps++;
  blackboard::setblackboardattribute(entity, "_staircase_num_steps", numsteps);
}

function private notetrackstaircasestep2(entity) {
  numsteps = blackboard::getblackboardattribute(entity, "_staircase_num_steps");
  numsteps = numsteps + 2;
  blackboard::setblackboardattribute(entity, "_staircase_num_steps", numsteps);
}

function private notetrackdropguninternal(entity) {
  if(entity.weapon == level.weaponnone) {
    return;
  }
  entity.lastweapon = entity.weapon;
  primaryweapon = entity.primaryweapon;
  secondaryweapon = entity.secondaryweapon;
  entity thread shared::dropaiweapon();
}

function private notetrackattachknife(entity) {
  if(!(isDefined(entity._ai_melee_attachedknife) && entity._ai_melee_attachedknife)) {
    entity attach("t6_wpn_knife_melee", "TAG_WEAPON_LEFT");
    entity._ai_melee_attachedknife = 1;
  }
}

function private notetrackdetachknife(entity) {
  if(isDefined(entity._ai_melee_attachedknife) && entity._ai_melee_attachedknife) {
    entity detach("t6_wpn_knife_melee", "TAG_WEAPON_LEFT");
    entity._ai_melee_attachedknife = 0;
  }
}

function private notetrackhideweapon(entity) {
  entity ai::gun_remove();
}

function private notetrackshowweapon(entity) {
  entity ai::gun_recall();
}

function private notetrackhideai(entity) {
  entity hide();
}

function private notetrackshowai(entity) {
  entity show();
}

function private notetrackstartragdoll(entity) {
  if(isactor(entity) && entity isinscriptedstate()) {
    entity.overrideactordamage = undefined;
    entity.allowdeath = 1;
    entity.skipdeath = 1;
    entity kill();
  }
  notetrackdropguninternal(entity);
  entity startragdoll();
}

function _delayedragdoll(entity) {
  wait(0.25);
  if(isDefined(entity) && !entity isragdoll()) {
    entity startragdoll();
  }
}

function notetrackstartragdollnodeath(entity) {
  if(isDefined(entity._ai_melee_opponent)) {
    entity._ai_melee_opponent unlink();
  }
  entity thread _delayedragdoll(entity);
}

function private notetrackfirebullet(animationentity) {
  if(isactor(animationentity) && animationentity isinscriptedstate()) {
    if(animationentity.weapon != level.weaponnone) {
      animationentity notify("about_to_shoot");
      startpos = animationentity gettagorigin("tag_flash");
      endpos = startpos + vectorscale(animationentity getweaponforwarddir(), 100);
      magicbullet(animationentity.weapon, startpos, endpos, animationentity);
      animationentity notify("shoot");
      animationentity.bulletsinclip--;
    }
  }
}

function private notetrackdropgun(animationentity) {
  notetrackdropguninternal(animationentity);
}

function private notetrackdropshield(animationentity) {
  aiutility::dropriotshield(animationentity);
}

function private notetrackgrenadethrow(animationentity) {
  if(archetype_human_cover::shouldthrowgrenadeatcovercondition(animationentity, 1)) {
    animationentity grenadethrow();
  } else if(isDefined(animationentity.grenadethrowposition)) {
    arm_offset = archetype_human_cover::temp_get_arm_offset(animationentity, animationentity.grenadethrowposition);
    throw_vel = animationentity canthrowgrenadepos(arm_offset, animationentity.grenadethrowposition);
    if(isDefined(throw_vel)) {
      animationentity grenadethrow();
    }
  }
}

function private notetrackmeleeunsync(animationentity) {
  if(isDefined(animationentity) && isDefined(animationentity.enemy)) {
    if(isDefined(animationentity.enemy._ai_melee_markeddead) && animationentity.enemy._ai_melee_markeddead) {
      animationentity unlink();
    }
  }
}

function private notetrackgibdisable(animationentity) {
  if(animationentity ai::has_behavior_attribute("can_gib")) {
    animationentity ai::set_behavior_attribute("can_gib", 0);
  }
}