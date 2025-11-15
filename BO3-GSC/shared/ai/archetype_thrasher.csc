/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_thrasher.csc
*************************************************/

#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#using_animtree("generic");
#namespace archetype_thrasher;

function autoexec __init__sytem__() {
  system::register("thrasher", & __init__, undefined, undefined);
}

function __init__() {
  visionset_mgr::register_visionset_info("zm_isl_thrasher_stomach_visionset", 9000, 16, undefined, "zm_isl_thrasher_stomach");
  if(ai::shouldregisterclientfieldforarchetype("thrasher")) {
    clientfield::register("actor", "thrasher_spore_state", 5000, 3, "int", & thrasherclientutils::thrashersporeexplode, 0, 0);
    clientfield::register("actor", "thrasher_berserk_state", 5000, 1, "int", & thrasherclientutils::thrasherberserkmode, 0, 1);
    clientfield::register("actor", "thrasher_player_hide", 8000, 4, "int", & thrasherclientutils::thrasherhidefromplayer, 0, 0);
    clientfield::register("toplayer", "sndPlayerConsumed", 10000, 1, "int", & thrasherclientutils::sndplayerconsumed, 0, 1);
    foreach(spore in array(1, 2, 4)) {
      clientfield::register("actor", "thrasher_spore_impact" + spore, 8000, 1, "counter", & thrasherclientutils::thrashersporeimpact, 0, 0);
    }
  }
  ai::add_archetype_spawn_function("thrasher", & thrasherclientutils::thrasherspawn);
  level.thrasherpustules = [];
  level thread thrasherclientutils::thrasherfxcleanup();
}

function autoexec precache() {
  level._effect["fx_mech_foot_step"] = "dlc1/castle/fx_mech_foot_step";
  level._effect["fx_thrash_pustule_burst"] = "dlc2/island/fx_thrash_pustule_burst";
  level._effect["fx_thrash_pustule_spore_exp"] = "dlc2/island/fx_thrash_pustule_spore_exp";
  level._effect["fx_thrash_pustule_impact"] = "dlc2/island/fx_thrash_pustule_impact";
  level._effect["fx_thrash_eye_glow"] = "dlc2/island/fx_thrash_eye_glow";
  level._effect["fx_thrash_eye_glow_rage"] = "dlc2/island/fx_thrash_eye_glow_rage";
  level._effect["fx_thrash_rage_gas_torso"] = "dlc2/island/fx_thrash_rage_gas_torso";
  level._effect["fx_thrash_rage_gas_leg_lft"] = "dlc2/island/fx_thrash_rage_gas_leg_lft";
  level._effect["fx_thrash_rage_gas_leg_rgt"] = "dlc2/island/fx_thrash_rage_gas_leg_rgt";
  level._effect["fx_thrash_pustule_reinflate"] = "dlc2/island/fx_thrash_pustule_reinflate";
  level._effect["fx_spores_cloud_ambient_sm"] = "dlc2/island/fx_spores_cloud_ambient_sm";
  level._effect["fx_spores_cloud_ambient_md"] = "dlc2/island/fx_spores_cloud_ambient_md";
  level._effect["fx_spores_cloud_ambient_lrg"] = "dlc2/island/fx_thrash_pustule_reinflate";
  level._effect["fx_thrash_chest_mouth_drool"] = "dlc2/island/fx_thrash_chest_mouth_drool_1p";
}

#namespace thrasherclientutils;

function private thrasherspawn(localclientnum) {
  entity = self;
  entity.ignoreragdoll = 1;
  level._footstepcbfuncs[entity.archetype] = & thrasherprocessfootstep;
  gibclientutils::addgibcallback(localclientnum, entity, 4, & thrasherdisableeyeglow);
}

function private thrasherfxcleanup() {
  while(true) {
    pustules = level.thrasherpustules;
    level.thrasherpustules = [];
    time = gettime();
    foreach(pustule in pustules) {
      if(pustule.endtime <= time) {
        if(isDefined(pustule.fx)) {
          stopfx(pustule.localclientnum, pustule.fx);
        }
        continue;
      }
      level.thrasherpustules[level.thrasherpustules.size] = pustule;
    }
    wait(0.5);
  }
}

function thrasherprocessfootstep(localclientnum, pos, surface, notetrack, bone) {
  e_player = getlocalplayer(localclientnum);
  n_dist = distancesquared(pos, e_player.origin);
  n_thrasher_dist = 1000000;
  if(n_thrasher_dist <= 0) {
    return;
  }
  n_scale = (n_thrasher_dist - n_dist) / n_thrasher_dist;
  if(n_scale > 1 || n_scale < 0 || n_scale <= 0.01) {
    return;
  }
  fx = playFXOnTag(localclientnum, level._effect["fx_mech_foot_step"], self, bone);
  if(isDefined(e_player.thrasherlastfootstep) && (e_player.thrasherlastfootstep + 400) > gettime()) {
    return;
  }
  earthquake_scale = n_scale * 0.1;
  if(earthquake_scale > 0.01) {
    e_player earthquake(earthquake_scale, 0.1, pos, n_dist);
  }
  if(n_scale <= 1 && n_scale > 0.8) {
    e_player playrumbleonentity(localclientnum, "damage_heavy");
  } else if(n_scale <= 0.8 && n_scale > 0.4) {
    e_player playrumbleonentity(localclientnum, "reload_small");
  }
  e_player.thrasherlastfootstep = gettime();
}

function private _stopfx(localclientnum, effect) {
  if(isDefined(effect)) {
    stopfx(localclientnum, effect);
  }
}

function private thrasherhidefromplayer(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  if(!isDefined(entity) || entity.archetype !== "thrasher" || !entity hasdobj(localclientnum)) {
    return;
  }
  localplayer = getlocalplayer(localclientnum);
  localplayernum = localplayer getentitynumber();
  localplayerbit = 1 << localplayernum;
  if(localplayerbit & newvalue) {
    entity hide();
  } else {
    entity show();
  }
}

function private thrasherberserkmode(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  if(!isDefined(entity) || entity.archetype !== "thrasher" || !entity hasdobj(localclientnum)) {
    return;
  }
  _stopfx(localclientnum, entity.thrashereyeglow);
  entity.thrashereyeglow = undefined;
  _stopfx(localclientnum, entity.thrasherambientfx1);
  entity.thrasherambientfx1 = undefined;
  _stopfx(localclientnum, entity.thrasherambientfx2);
  entity.thrasherambientfx2 = undefined;
  _stopfx(localclientnum, entity.thrasherambientfx3);
  entity.thrasherambientfx3 = undefined;
  hashead = !gibclientutils::isgibbed(localclientnum, entity, 4);
  switch (newvalue) {
    case 0: {
      if(hashead) {
        entity.thrashereyeglow = playFXOnTag(localclientnum, level._effect["fx_thrash_eye_glow"], entity, "j_eyeball_le");
      }
      break;
    }
    case 1: {
      if(hashead) {
        entity.thrashereyeglow = playFXOnTag(localclientnum, level._effect["fx_thrash_eye_glow_rage"], entity, "j_eyeball_le");
      }
      entity.thrasherambientfx1 = playFXOnTag(localclientnum, level._effect["fx_thrash_rage_gas_torso"], entity, "j_spinelower");
      entity.thrasherambientfx2 = playFXOnTag(localclientnum, level._effect["fx_thrash_rage_gas_leg_lft"], entity, "j_hip_le");
      entity.thrasherambientfx3 = playFXOnTag(localclientnum, level._effect["fx_thrash_rage_gas_leg_rgt"], entity, "j_hip_ri");
      break;
    }
  }
}

function private thrashersporeexplode(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  sporeclientfields = array(1, 2, 4);
  sporetags = array("tag_spore_chest", "tag_spore_back", "tag_spore_leg");
  newsporesexploded = (oldvalue ^ newvalue) & (~oldvalue);
  oldsporesinflated = (oldvalue ^ newvalue) & (~newvalue);
  currentspore = sporeclientfields[0];
  for(index = 0; index < array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size; index++) {
    sporetag = sporetags[index];
    pustuleinfo = undefined;
    if(newsporesexploded & currentspore) {
      playFXOnTag(localclientnum, level._effect["fx_thrash_pustule_burst"], entity, sporetag);
      playFXOnTag(localclientnum, level._effect["fx_thrash_pustule_spore_exp"], entity, sporetag);
      pustuleinfo = spawnStruct();
      pustuleinfo.length = 5000;
      if(!(isDefined(level.b_thrasher_custom_spore_fx) && level.b_thrasher_custom_spore_fx)) {
        pustuleinfo.fx = playFX(localclientnum, level._effect["fx_spores_cloud_ambient_md"], entity gettagorigin(sporetag));
      }
    } else if(oldsporesinflated & currentspore) {
      pustuleinfo = spawnStruct();
      pustuleinfo.length = 2000;
      pustuleinfo.fx = playFXOnTag(localclientnum, level._effect["fx_thrash_pustule_reinflate"], entity, sporetag);
    }
    if(isDefined(pustuleinfo)) {
      pustuleinfo.localclientnum = localclientnum;
      pustuleinfo.starttime = gettime();
      pustuleinfo.endtime = pustuleinfo.starttime + pustuleinfo.length;
      level.thrasherpustules[level.thrasherpustules.size] = pustuleinfo;
    }
    currentspore = currentspore << 1;
  }
}

function private thrashersporeimpact(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  sporetag = undefined;
  sporeclientfields = array(1, 2, 4);
  assert(sporeclientfields.size == array("", "", "").size);
  for(index = 0; index < sporeclientfields.size; index++) {
    if(fieldname == ("thrasher_spore_impact" + sporeclientfields[index])) {
      sporetag = array("tag_spore_chest", "tag_spore_back", "tag_spore_leg")[index];
      break;
    }
  }
  if(isDefined(sporetag)) {
    playFXOnTag(localclientnum, level._effect["fx_thrash_pustule_impact"], entity, sporetag);
  }
}

function private thrasherdisableeyeglow(localclientnum, entity, gibflag) {
  if(!isDefined(entity) || entity.archetype !== "thrasher" || !entity hasdobj(localclientnum)) {
    return;
  }
  _stopfx(localclientnum, entity.thrashereyeglow);
  entity.thrashereyeglow = undefined;
}

function private sndplayerconsumed(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    if(!isDefined(self.sndplayerconsumedid)) {
      self.sndplayerconsumedid = self playLoopSound("zmb_thrasher_consumed_lp", 5);
    }
    if(!isDefined(self.n_fx_id_player_consumed)) {
      self.n_fx_id_player_consumed = playfxoncamera(localclientnum, level._effect["fx_thrash_chest_mouth_drool"]);
    }
    self thread postfx::playpostfxbundle("pstfx_thrasher_stomach");
    enablespeedblur(localclientnum, 0.07, 0.55, 0.9, 0, 100, 100);
  } else {
    if(isDefined(self.sndplayerconsumedid)) {
      self stoploopsound(self.sndplayerconsumedid, 0.5);
      self.sndplayerconsumedid = undefined;
    }
    if(isDefined(self.n_fx_id_player_consumed)) {
      stopfx(localclientnum, self.n_fx_id_player_consumed);
      self.n_fx_id_player_consumed = undefined;
    }
    self stopallloopsounds(1);
    if(isDefined(self.playingpostfxbundle)) {
      self thread postfx::stopplayingpostfxbundle();
    }
    disablespeedblur(localclientnum);
  }
}