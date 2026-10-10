/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\mp_dialogue.gsc
***********************************************/

#using scripts\anim\dialogue;
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\player;
#namespace mp_dialogue;

function main() {
  level.dialogue_playing = 0;
  level.current_dialogue = "";
  level.var_9a62261b5b534b06 = &function_7bdde7f2158ec720;
  level.var_c3d9ceba74248998 = &function_e174f6ae044c693e;
  level.var_1da0697a602f5a04 = &function_46d1642a9a982a8a;
}

function function_e174f6ae044c693e(origin, radius, desiredteam, excludeents) {
  if(isDefined(excludeents) && !isarray(excludeents)) {
    excludeents = [excludeents];
  }

  if(function_a794fcf9545f2062()) {
    return function_b1eef70090b5b7b5(origin, radius, function_869ccb4e3451b8c6(["etype_player"]), excludeents, desiredteam);
  }

  return scripts\mp\utility\player::getplayersinradius(origin, radius, desiredteam, excludeents);
}

function function_46d1642a9a982a8a(origin, radius, desiredteam, excludeents) {
  if(isDefined(excludeents) && !isarray(excludeents)) {
    excludeents = [excludeents];
  }

  if(function_a794fcf9545f2062()) {
    return function_b1eef70090b5b7b5(origin, radius, function_869ccb4e3451b8c6(["etype_ai"]), excludeents, desiredteam);
  }

  if(isDefined(excludeents) && excludeents.size) {
    return array_remove_array(getaiarrayinradius(origin, radius, desiredteam), excludeents);
  }

  if(isDefined(desiredteam)) {
    return getaiarrayinradius(origin, radius, desiredteam);
  }

  return getaiarrayinradius(origin, radius);
}

function function_7bdde7f2158ec720(alias, audience) {
  speaker = self;

  if(isstruct(self) && isDefined(self.vo_parent)) {
    speaker = self.vo_parent;
  }

  self notify("stop_dialogue");
  context = ter_op(istrue(self.isradioemitter), "dx_radio_3d");
  speaker thread function_63a29fee1a93c0a8(alias, context, audience);

  if(!istrue(self.skip_face) && (isai(self) || istrue(self.fakeactor_face_anim))) {
    face_anim = scripts\anim\dialogue::function_6d4c7d2bd5969057(alias);

    if(isDefined(face_anim)) {
      thread anim_facialanim(self, alias, face_anim);
    } else {
      intensity = get_intensity(alias);
      thread anim_facialfiller("stop_facialFiller", undefined, 0, undefined, intensity);
    }
  }

  function_ea5c0accfc20ea48(alias);
  self notify("stop_facialFiller");
  return true;
}

function function_ea5c0accfc20ea48(alias) {
  self endon("death");
  self endon("stop_dialogue");
  duration = lookupsoundlength(alias) / 1000;
  wait duration;
}

function get_intensity(alias) {
  if(isDefined(self.var_9af882a4ef5986c0)) {
    return self.var_9af882a4ef5986c0;
  }

  var_c59c1d18b26c886e = ["sm", "sm", "md", "lg"];
  intensity = default_to(function_d159656d2b07f8a5(alias), 0);
  return var_c59c1d18b26c886e[intensity];
}

function function_63a29fee1a93c0a8(alias, context, audience) {
  self stopsounds(1);
  self stopsoundchannel("voice_bchatter_1_3d", 1);
  waitframe();

  if(!isDefined(self)) {
    return;
  }

  if(isPlayer(audience)) {
    self playsoundtoplayer(alias, audience, self);
    return;
  }

  if(isstring(audience)) {
    if(isPlayer(self)) {
      self playsoundtoteam(alias, audience, self, self);
    } else {
      self playsoundtoteam(alias, audience, undefined, self);
    }

    return;
  }

  if(isarray(audience)) {
    foreach(player_or_team in audience) {
      thread function_63a29fee1a93c0a8(alias, player_or_team);
    }

    return;
  }

  if(isDefined(context)) {
    self playcontextsound(alias, "dx_type", context);
    return;
  }

  self playSound(alias, undefined, self);
}

function anim_facialfiller(msg, looktarget, force, msg_ent, intensity) {
  intensity = default_to(intensity, "sm");
  self endon("death");
  self notify("newFacialAnim");

  if(!isDefined(msg_ent)) {
    msg_ent = self;
  }

  if(isai(self) && !isalive(self)) {
    return;
  }

  if(!isai(self)) {
    if(!isDefined(self.fakeactor_face_anim)) {
      return;
    } else if(!self.fakeactor_face_anim || !isalive(self)) {
      return;
    }
  }

  if(istrue(self.nofacialfiller)) {
    return;
  }

  if(!istrue(force) && !scripts\asm\shared\utility::isfacialstateallowed("filler")) {
    return;
  }

  if(isDefined(self.unittype) && (self.unittype == "c6" || self.unittype == "c8" || self.unittype == "c12")) {
    return;
  }

  changetime = 0.05;
  self notify("newLookTarget");
  self endon("newLookTarget");
  waittillframeend();

  if(!isDefined(looktarget) && isDefined(self.bc_looktarget)) {
    looktarget = self.bc_looktarget;
  }

  archetype = scripts\asm\shared\utility::function_2285421dfc79c4d5();
  var_6b7315aedc52f8e2 = self.defaulttalk;
  headknob = self.scriptedtalkingknob;
  assert(isalive(self));
  scripts\asm\shared\utility::setfacialstate("filler");

  if(archetype != "") {
    if(isai(self)) {
      self setfacialindex("talk_" + intensity);
    } else if(istrue(self.var_5247d15da29e8539)) {
      scripts\asm\shared\utility::function_ee3e5d584e317d35("talk_" + intensity);
    } else {
      scripts\asm\shared\utility::setfacialindexfornonai("talk_" + intensity);
    }
  } else {
    self setanimknoblimitedrestart(var_6b7315aedc52f8e2, 1, 0, 1);
    self setanim(headknob, 5, 0.267);
  }

  msg_ent waittill(msg);

  if(archetype != "" && isai(self)) {
    self setfacialindex("none");
  } else if(istrue(self.var_5247d15da29e8539) && isDefined(self.var_7a140ee03cfc699e)) {
    scripts\asm\shared\utility::function_ee3e5d584e317d35("none");
  }

  scripts\asm\shared\utility::clearfacialstate("filler");
}

function anim_facialanim(guy, anime, faceanim) {
  guy endon("death");
  self endon(anime);
  changetime = 0.05;
  guy notify("newLookTarget");
  guy notify("newFacialAnim");
  scripts\asm\shared\utility::disabledefaultfacialanims();
  waittillframeend();

  if(!isDefined(self.scriptedtalkingknob)) {
    self.scriptedtalkingknob = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "scripted_talking"));
  }

  animflag = "scripted_face_" + anime;
  guy setanim(self.scriptedtalkingknob, 1, 0.2);
  guy setflaggedanimknobrestart(animflag, faceanim, 1, 0, 1);
  thread clearfaceanimonanimdone(guy, animflag, anime);
}

function clearfaceanimonanimdone(guy, animflag, anime) {
  guy endon("death");
  guy endon("newFacialAnim");
  guy waittillmatch(animflag, "end");
  guy notify("scripted_face_done");
  changetime = 0.3;
  guy clearanim(self.scriptedtalkingknob, 0.2);
  scripts\asm\shared\utility::disabledefaultfacialanims(0);
}