/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_55c245eeebbdf85c.gsc
*************************************************/

#using script_57bdd8aff28a4717;
#using script_71f05b1d487869d3;
#using script_7c2886c7a12179f;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\teams;
#namespace namespace_8cc7824223500536;

function init() {
  var_c18b410395ac261f = 0;

  foreach(player in level.players) {
    player.var_fad5c3453452323f = 0;

    if(namespace_362cfff5d79f8b9b::function_95ec56461198f3f9(player)) {
      var_c18b410395ac261f = 1;
    }
  }

  if(istrue(var_c18b410395ac261f)) {
    namespace_af97b0039fe151ef::main();
    waitframe();
    level.var_5511b213868eba12 = [];
    level._effect["footstep_left"] = loadfx("vfx/jup/equipment/vfx_blacklight_print_left.vfx");
    level._effect["footstep_right"] = loadfx("vfx/jup/equipment/vfx_blacklight_print_right.vfx");
    scripts\engine\utility::registersharedfunc("unlock_relics_s3", "death_perception_check", &function_b8fe7f5ed600420d);
    function_107f5908606cc82();
    function_5eb3707c330f26a8();
    return;
  }

  logstring("S3 Crayon Relic: No players in match can receive Crayon Relic, fully skipping initialization");
}

function private function_b8fe7f5ed600420d() {
  if(isDefined(self) && isPlayer(self) && namespace_362cfff5d79f8b9b::function_95ec56461198f3f9(self) && !istrue(self.var_fad5c3453452323f)) {
    level.var_5511b213868eba12 = function_6d6af8144a5131f1(level.var_5511b213868eba12, self);
  }
}

function private function_107f5908606cc82() {
  var_5a99f3b0edabea7 = getStructArray("relic_crayon_footstep_left", "targetname");
  var_85010eb80cfe5ea0 = getStructArray("relic_crayon_footstep_right", "targetname");

  foreach(step in var_5a99f3b0edabea7) {
    level thread function_db697c35c5f45d87(step.origin, step.angles, 1);
  }

  foreach(var_62a529761893c693 in var_85010eb80cfe5ea0) {
    level thread function_db697c35c5f45d87(var_62a529761893c693.origin, var_62a529761893c693.angles);
  }
}

function private function_db697c35c5f45d87(pos, angles, var_1ec37f1e7a9e2ec9) {
  level endon("game_ended");

  if(!isDefined(pos)) {
    return;
  }

  forwardvec = anglesToForward(angles);
  upvec = anglestoup(angles);
  assert(isDefined(forwardvec) && isDefined(upvec), "<dev string:x1c>");
  waitduration = getdvarfloat(@ "hash_91498974181abee6", 4);
  effectid = istrue(var_1ec37f1e7a9e2ec9) ? level._effect["footstep_left"] : level._effect["footstep_right"];

  while(true) {
    if(level.var_5511b213868eba12.size > 0) {
      var_cd72aa21f648238e = 0;

      foreach(player in level.var_5511b213868eba12) {
        if(!isDefined(player)) {
          var_cd72aa21f648238e = 1;
          continue;
        }

        playFX(effectid, pos, forwardvec, upvec, player);
        wait waitduration;
      }

      if(var_cd72aa21f648238e) {
        level.var_5511b213868eba12 = array_removeundefined(level.var_5511b213868eba12);
      }

      continue;
    }

    wait 5;
  }
}

function private function_5eb3707c330f26a8() {
  array = [];
  level.var_e16818aeb4b10beb = function_f159c10d5cf8f0b4("relic_crayon_footstep_bed_trigger", "targetname");
  interactionstruct = getStruct("relic_journal_bed_interact", "targetname");
  var_179343b5981c3088 = getStruct("relic_journal_bed_reward", "targetname");

  foreach(volume in level.var_e16818aeb4b10beb) {
    thread function_967c8a57bedde2ee(volume, interactionstruct, var_179343b5981c3088);
  }
}

function function_967c8a57bedde2ee(volume, interactionstruct, var_179343b5981c3088) {
  assert(isDefined(volume));
  level endon("game_ended");
  volume endon("death");
  volume.interact = scripts\cp_mp\interaction::register_interact(interactionstruct.origin, interactionstruct.radius, &function_7f0f61d056244f1e);
  volume.interact scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_71b156e80b222071);
  volume.interact.var_cd1123b87e8747d4 = [];
  volume.interact.var_179343b5981c3088 = var_179343b5981c3088;

  while(true) {
    volume waittill("trigger", enteringentity);

    if(isDefined(enteringentity) && isPlayer(enteringentity) && namespace_362cfff5d79f8b9b::function_95ec56461198f3f9(enteringentity) && !istrue(enteringentity.var_fad5c3453452323f)) {
      volume.interact.var_cd1123b87e8747d4 = function_6d6af8144a5131f1(volume.interact.var_cd1123b87e8747d4, enteringentity);
    }
  }
}

function private function_7f0f61d056244f1e(player) {
  if(!isDefined(player) || istrue(player.var_fad5c3453452323f)) {
    return;
  }

  var_8232fe13bffb624 = isDefined(self.var_179343b5981c3088) ? self.var_179343b5981c3088.origin : self.origin;
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

  if(isDefined(a_squad)) {
    self.var_cd1123b87e8747d4 = array_remove_array(a_squad, self.var_cd1123b87e8747d4);

    foreach(squadmember in a_squad) {
      squadmember.var_fad5c3453452323f = 1;
      thread scripts\cp_mp\overlord::playevent("RFT_S3_5_RGUQ_Whispers_Drawing", [squadmember]);
    }
  }

  wait 10;
  namespace_fc89f9b99b72df11::function_65e52fad2bce952c(player, "ob_jup_hydro_obelisk_reward_crayon_s3", var_8232fe13bffb624);
}

function function_71b156e80b222071(interact, player) {
  if(isDefined(interact.var_cd1123b87e8747d4) && interact.var_cd1123b87e8747d4.size > 0 && array_contains(interact.var_cd1123b87e8747d4, player) && istrue(array_contains(level.var_5511b213868eba12, player))) {
    var_7855fd9575dfd1bf = player getstance() == "prone";

    if(var_7855fd9575dfd1bf) {
      var_e5242855a04339bf = &"JUP_OB_S3/UNLOCK_QUEST_RELIC_CRAYON_INVESTIGATE";
      return {
        #string: var_e5242855a04339bf, #type: "HINT_BUTTON"};
    }
  }

  return {
    #string: &"", #type: "HINT_NOBUTTON"
  };
}