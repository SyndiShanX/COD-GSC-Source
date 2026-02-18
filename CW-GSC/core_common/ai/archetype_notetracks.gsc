/***************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_notetracks.gsc
***************************************************/

#using scripts\core_common\ai\archetype_human_cover;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\util_shared;
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
  registernotetrackhandlerfunction("helmet_pop", &notetrackhelmetpop);
  registernotetrackhandlerfunction("drop clip", &function_727744ff);
  registernotetrackhandlerfunction("extract clip left", &function_cd88e2dc);
  registernotetrackhandlerfunction("extract clip right", &function_8982cca0);
  registernotetrackhandlerfunction("attach clip left", &function_3f4b4219);
  registernotetrackhandlerfunction("attach clip right", &function_15b71a09);
  registernotetrackhandlerfunction("detach clip left", &function_9d41000);
  registernotetrackhandlerfunction("detach clip right", &function_9d41000);
  registernotetrackhandlerfunction("step1", &notetrackstaircasestep1);
  registernotetrackhandlerfunction("step2", &notetrackstaircasestep2);
  registernotetrackhandlerfunction("anim_movement = \"stop\"", &notetrackanimmovementstop);
  registernotetrackhandlerfunction("gun_2_back", &notetrackguntoback);
  registernotetrackhandlerfunction("gun_2_right", &function_776caa25);
  registernotetrackhandlerfunction("pistol_pickup", &function_f7e95a07);
  registernotetrackhandlerfunction("pistol_putaway", &function_c49db6d);
  registerblackboardnotetrackhandler("anim_pose = \\"stand\\"", "_stance", "stand");
  registerblackboardnotetrackhandler("anim_pose = \\"crouch\\"", "_stance", "crouch");
  registerblackboardnotetrackhandler("anim_pose = \\"prone\\"", "_stance", "prone");
  registerblackboardnotetrackhandler("anim_pose = stand", "_stance", "stand");
  registerblackboardnotetrackhandler("anim_pose = crouch", "_stance", "crouch");
  registerblackboardnotetrackhandler("anim_pose = prone", "_stance", "prone");
}

function private notetrackguntoback(entity) {
  if(!is_true(entity.var_8f33d87a)) {
    ai::gun_remove();
    entity attach(entity.primaryweapon.worldmodel, "tag_stowed_back", 0);
    entity.var_8f33d87a = 1;
  }
}

function private function_776caa25(entity) {
  if(is_true(entity.var_8f33d87a)) {
    entity.var_8f33d87a = 0;
    entity detach(entity.primaryweapon.worldmodel, "tag_stowed_back");
  }

  ai::gun_recall();
  entity.bulletsinclip = entity.primaryweapon.clipsize;
}

function private function_f7e95a07(entity) {
  ai::gun_switchto(entity.sidearm, "right");
  entity.bulletsinclip = entity.sidearm.clipsize;
}

function private function_c49db6d(entity) {
  ai::gun_switchto(entity.sidearm, "none");
}

function private notetrackanimmovementstop(entity) {
  if(entity haspath()) {
    entity pathmode("move delayed", 1, randomfloatrange(2, 4));
  }
}

function private notetrackstaircasestep1(entity) {
  numsteps = entity getblackboardattribute("_staircase_num_steps");
  numsteps++;
  entity setblackboardattribute("_staircase_num_steps", numsteps);
}

function private notetrackstaircasestep2(entity) {
  numsteps = entity getblackboardattribute("_staircase_num_steps");
  numsteps += 2;
  entity setblackboardattribute("_staircase_num_steps", numsteps);
}

function private notetrackdropguninternal(entity) {
  if(!isDefined(entity.weapon) || entity.weapon === level.weaponnone) {
    return;
  }

  if(isDefined(entity.ai) && is_true(entity.ai.var_7c61677c)) {
    if(isalive(entity)) {
      return;
    }
  }

  entity.lastweapon = entity.weapon;
  primaryweapon = entity.primaryweapon;
  secondaryweapon = entity.secondaryweapon;
  entity thread shared::dropaiweapon();
}

function private notetrackattachknife(entity) {
  if(!is_true(entity._ai_melee_attachedknife)) {
    entity attach(#"wpn_t7_knife_combat_prop", "TAG_WEAPON_LEFT");
    entity._ai_melee_attachedknife = 1;
  }
}

function private notetrackdetachknife(entity) {
  if(is_true(entity._ai_melee_attachedknife)) {
    entity detach(#"wpn_t7_knife_combat_prop", "TAG_WEAPON_LEFT");
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
    entity kill(entity.origin, undefined, undefined, undefined, undefined, 1);
  }

  notetrackdropguninternal(entity);
  entity startragdoll(isDefined(entity.var_cc6f2563));

  if(isDefined(entity.var_cc6f2563)) {
    entity launchragdoll(entity.var_cc6f2563);
  }

  var_89953da0 = entity asmgetcurrentdeltaanimation();
  text = "<dev string:x38>";

  if(isDefined(var_89953da0) && var_89953da0 != "<dev string:x51>") {
    text += "<dev string:x55>" + function_9e72a96(var_89953da0);
    notetracks = getnotetracktimes(var_89953da0, "<dev string:x5c>");

    if(notetracks.size == 1) {
      time = entity getanimtime(var_89953da0);
      text += "<dev string:x6d>" + notetracks[0] + "<dev string:x84>" + time;
    } else {
      text += "<dev string:x99>" + notetracks.size;
    }
  }

  record3dtext(text, entity.origin + (0, 0, 4), (1, 0, 0), "<dev string:xac>", undefined, 0.4);
}

function _delayedragdoll(entity) {
  wait 0.25;

  if(isDefined(entity) && !entity isragdoll()) {
    entity startragdoll();

    record3dtext("<dev string:xb9>", entity.origin + (0, 0, 4), (1, 0, 0), "<dev string:xac>", undefined, 0.4);
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
      animationentity notify(#"about_to_shoot");
      startpos = animationentity gettagorigin("tag_flash");
      angles = animationentity gettagangles("tag_flash");
      forward = anglesToForward(angles);
      endpos = startpos + vectorscale(forward, 100);
      magicbullet(animationentity.weapon, startpos, endpos, animationentity);
      animationentity notify(#"shoot");
      animationentity.bulletsinclip--;
    }
  }
}

function private notetrackhelmetpop(animationentity) {
  destructserverutils::function_8475c53a(animationentity, "helmet");
}

function private notetrackdropgun(animationentity) {
  if(isDefined(animationentity.var_bd5efde2) && isDefined(animationentity.var_6622f75b)) {
    clip = function_ed287fd1(animationentity);

    if(isDefined(clip.model)) {
      function_a5af97c9(animationentity, clip, animationentity.var_bd5efde2);
      function_c83ca932(animationentity);
    }
  }

  notetrackdropguninternal(animationentity);
}

function private notetrackdropshield(animationentity) {
  aiutility::dropriotshield(animationentity);
}

function private notetrackgrenadethrow(animationentity) {
  if(archetype_human_cover::function_9d8b22d8(animationentity, 1, 0)) {
    archetype_human_cover::function_ce446f2e(animationentity);
    return;
  }

  if(isDefined(animationentity.grenadethrowposition)) {
    arm_offset = undefined;

    if(isDefined(self.var_ce7a311e)) {
      arm_offset = [[self.var_ce7a311e]](animationentity, animationentity.grenadethrowposition);
    } else {
      arm_offset = archetype_human_cover::temp_get_arm_offset(animationentity, animationentity.grenadethrowposition);
    }

    throw_vel = animationentity canthrowgrenadepos(arm_offset, animationentity.grenadethrowposition);

    if(isDefined(throw_vel)) {
      archetype_human_cover::function_ce446f2e(animationentity);
    } else {
      archetype_human_cover::function_83c0b7e1(animationentity);
    }

    return;
  }

  archetype_human_cover::function_83c0b7e1(animationentity);
}

function private notetrackmeleeunsync(animationentity) {
  if(isDefined(animationentity) && isDefined(animationentity.enemy)) {
    if(is_true(animationentity.enemy._ai_melee_markeddead)) {
      animationentity unlink();
    }
  }
}

function private notetrackgibdisable(animationentity) {
  if(animationentity ai::has_behavior_attribute("can_gib")) {
    animationentity ai::set_behavior_attribute("can_gib", 0);
  }
}

function private function_ed287fd1(animationentity) {
  result = {};
  result.model = animationentity.weapon.clipmodel;
  result.weapon_tag = "tag_clip";
  result.var_c63463cb = "tag_clip_empty";
  result.var_696fb09f = "tag_accessory_left";
  result.var_86c2ede3 = "tag_accessory_right";
  return result;
}

function private function_dab83a5a(animationentity, clip, visible) {
  if(isDefined(clip.var_c63463cb) && animationentity haspart(clip.var_c63463cb)) {
    if(!is_true(visible)) {
      animationentity hidepart(clip.var_c63463cb);
      animationentity.var_91d2328b = clip.var_c63463cb;
    } else {
      animationentity showpart(clip.var_c63463cb);
      animationentity.var_91d2328b = undefined;
    }
  }

  if(isDefined(clip.weapon_tag) && animationentity haspart(clip.weapon_tag)) {
    if(!is_true(visible)) {
      animationentity hidepart(clip.weapon_tag);
      animationentity.var_af41987d = clip.weapon_tag;
      return;
    }

    animationentity showpart(clip.weapon_tag);
    animationentity.var_af41987d = undefined;
  }
}

function private function_73e97c7d(animationentity, clip, attachtag) {
  if(isDefined(clip.model) && isDefined(attachtag) && animationentity haspart(attachtag) && !isDefined(animationentity.var_6622f75b)) {
    animationentity attach(clip.model, attachtag);
    animationentity.var_6622f75b = clip.model;
    animationentity.var_bd5efde2 = attachtag;
  }
}

function private function_c83ca932(animationentity) {
  if(isDefined(animationentity.var_bd5efde2) && isDefined(animationentity.var_6622f75b)) {
    animationentity detach(animationentity.var_6622f75b, animationentity.var_bd5efde2);
    animationentity.var_6622f75b = undefined;
    animationentity.var_bd5efde2 = undefined;
  }
}

function private function_a5af97c9(animationentity, clip, tag) {
  origin = animationentity gettagorigin(tag);
  angles = animationentity gettagangles(tag);

  if(!isDefined(clip.model)) {
    weaponname = "<dev string:xcc>";

    if(isDefined(animationentity.weapon.name)) {
      weaponname = function_9e72a96(animationentity.weapon.name);
    }

    assertmsg("<dev string:xd9>" + weaponname + "<dev string:x122>" + animationentity.aitype);
  }

  var_fffb32e9 = util::spawn_model(clip.model, origin, angles);

  if(isDefined(var_fffb32e9)) {
    var_fffb32e9 notsolid();
    var_fffb32e9 physicslaunch(var_fffb32e9.origin - (0, 0, 3), (randomfloatrange(-0.5, 0.5), randomfloatrange(-0.5, 0.5), 0));
    var_fffb32e9 util::delay(10, undefined, &function_6bde1bde);
  }
}

function private function_727744ff(animationentity) {
  clip = function_ed287fd1(animationentity);

  if(isDefined(animationentity.var_6622f75b) && isDefined(animationentity.var_bd5efde2) && isDefined(clip.model)) {
    function_a5af97c9(animationentity, clip, animationentity.var_bd5efde2);
    function_c83ca932(animationentity);
    function_dab83a5a(animationentity, clip, 0);
    return;
  }

  if(isDefined(clip.model) && isDefined(clip.weapon_tag) && animationentity haspart(clip.weapon_tag)) {
    function_a5af97c9(animationentity, clip, clip.weapon_tag);
    function_dab83a5a(animationentity, clip, 0);
  }
}

function private function_cd88e2dc(animationentity) {
  clip = function_ed287fd1(animationentity);
  function_dab83a5a(animationentity, clip, 0);
  function_73e97c7d(animationentity, clip, clip.var_696fb09f);
}

function private function_8982cca0(animationentity) {
  clip = function_ed287fd1(animationentity);
  function_dab83a5a(animationentity, clip, 0);
  function_73e97c7d(animationentity, clip, clip.var_86c2ede3);
}

function private function_3f4b4219(animationentity) {
  clip = function_ed287fd1(animationentity);
  function_73e97c7d(animationentity, clip, clip.var_696fb09f);
  function_dab83a5a(animationentity, clip, 0);
}

function private function_15b71a09(animationentity) {
  clip = function_ed287fd1(animationentity);
  function_73e97c7d(animationentity, clip, clip.var_86c2ede3);
  function_dab83a5a(animationentity, clip, 0);
}

function function_9d41000(animationentity) {
  clip = function_ed287fd1(animationentity);
  function_c83ca932(animationentity);
  function_dab83a5a(animationentity, clip, 1);
}

function private function_6bde1bde() {
  self endon(#"death");
  self.origin += (0, 0, -1);
  waitframe(1);
  self delete();
}