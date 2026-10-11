/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\anim\face.gsc
***********************************************/

#namespace face;

function saygenericdialogue(typestring) {
  if(self.unittype != "soldier" && self.unittype != "civilian" && self.unittype != "juggernaut" && self.unittype != "suicidebomber") {
    return;
  }

  chance = undefined;

  switch (typestring) {
    case #"hash_48992ea0e7c59d03":
    case #"hash_69cda088cc03687b":
      importance = 0.5;
      break;
    case #"hash_a36bc9705096e427":
      importance = 0.7;
      chance = 50;
      break;
    case #"hash_c6e9d384b1d615f5":
      importance = 0.9;
      chance = 98;
      break;
    case #"hash_5b2312cf1df3e0a":
    case #"hash_16385fce47a909fa":
    case #"hash_77066905f9ad0542":
    case #"hash_ba7993736731e211":
    case #"hash_c046c4a28eed6ea2":
    case #"hash_e8bc3da4af287c2d":
    case #"hash_f65dca6d4fbde6c6":
      importance = 1;
      break;
    default:
      println("<dev string:x1c>" + typestring);
      importance = 0.3;
      break;
  }

  if(isDefined(chance) && randomint(100) > chance) {
    return;
  }

  voicenum = undefined;
  prefix = "generic_";
  voicestring = undefined;
  numvoices = undefined;

  if(isDefined(self.battlechatter) && isDefined(self.battlechatter.npcid)) {
    switch (self.battlechatter.npcid) {
      case #"hash_c614d6c10a50c4f":
      case #"hash_21618e6c1b52ee5a":
      case #"hash_289af76c1f0f0908":
      case #"hash_3689ba6c261f7001":
      case #"hash_5562686c3699e6a9":
      case #"hash_9009aa6c552a085a":
      case #"hash_ed5cac6c000817dc":
        voicestring = self.battlechatter.npcid;
        prefix = "hero_";
        numvoices = 1;
        break;
    }
  }

  if(self.unittype == "juggernaut") {
    voicestring = "juggernaut";
    numvoices = 8;
  }

  if(!isDefined(voicestring)) {
    switch (self.voice) {
      case #"sas":
      case #"unitednations":
      case #"unitedstates":
      case #"unitednationshelmet":
      case #"fsa":
        voicestring = "friendly";
        numvoices = anim.numfriendlyvoices;
        break;
      case #"sasfemale":
      case #"fsafemale":
      case #"unitednationsfemale":
      case #"alqatalafemale":
      case #"unitedstatesfemale":
      case #"russianfemale":
        voicestring = "friendly";
        prefix = "woman_";
        numvoices = anim.numfriendlyfemalevoices;
        break;
      case #"c6":
        voicestring = "c6";
        numvoices = 1;
        break;
      default:
        voicestring = "enemy";
        numvoices = anim.numenemyvoices;
        break;
    }
  }

  assert(isDefined(voicestring));
  assert(isDefined(numvoices));
  voicenum = 1 + self getentitynumber() % numvoices;
  assert(isDefined(voicenum));
  voicestring = voicestring + "_" + voicenum;
  soundalias = undefined;

  if(!isDefined(soundalias)) {
    if(isDefined(self.generic_voice_override)) {
      soundalias = self.generic_voice_override + "_" + typestring + "_" + voicestring;
    } else {
      soundalias = prefix + typestring + "_" + voicestring;
    }

    if(!soundexists(soundalias)) {
      soundalias = "generic_" + typestring + "_" + voicestring;
    }
  }

  if(getdvarint(@ "hash_67846a0d7aa3030a", 1)) {
    println("<dev string:x3f>" + soundalias);
  }

  thread playfacethread(soundalias, undefined);
}

function sayspecificdialogue(soundalias, notifystring) {
  thread playfacethread(soundalias, notifystring);
}

function playfacethread(soundalias, notifystring) {
  if(isDefined(notifystring)) {
    if(isDefined(soundalias)) {
      playfacesound(soundalias, "animscript facesound" + notifystring, 1);
      thread waitforfacesound(notifystring);
    }

    return;
  }

  playfacesound(soundalias);
}

function playfacesound(alias, notification, stoppable) {
  if(isai(self)) {
    self[[anim.callbacks["PlaySoundAtViewHeight"]]](alias, notification, stoppable);
    return;
  }

  if(isDefined(notification) && isDefined(stoppable)) {
    self playSound(alias, notification, stoppable);
    return;
  }

  if(isDefined(notification)) {
    self playSound(alias, notification);
    return;
  }

  self playSound(alias);
}

function waitforfacesound(msg) {
  self endon("death");
  self waittill("animscript facesound" + msg);
  self notify(msg);
}

function initlevelface() {
  anim.numenemyvoices = 7;
  anim.numfriendlyvoices = 7;
  anim.numfriendlyfemalevoices = 3;
  initfacialanims();
}

function initfacialanims() {
  anim.facial = [];
}

function animhasfacialoverride(a_anim) {
  return animhasnotetrack(a_anim, "facial_override");
}

#using_animtree("generic_human");

function playfacialanim(a_anim, a_state, a_idx) {
  if(isDefined(self.bdisabledefaultfacialanims) && self.bdisabledefaultfacialanims) {
    self aiclearanim(%head, 0.2);
    return;
  }

  if(isDefined(a_anim) && animhasfacialoverride(a_anim)) {
    self aiclearanim(%head, 0.2);
    return;
  }

  assert(isDefined(anim.facial));

  if(!isDefined(anim.facial[a_state])) {
    return;
  }

  if(isDefined(a_idx) && a_idx >= 0 && a_idx < anim.facial[a_state].size) {
    randidx = a_idx;
  } else {
    randidx = randomint(anim.facial[a_state].size);
  }

  facialanim = anim.facial[a_state][randidx];
  self setanimknob(facialanim);
  return randidx;
}