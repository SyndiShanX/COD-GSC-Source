/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\face.gsc
***********************************************/

saygenericdialogue(_id_830A1FCFBE58BAF4) {
  if(self.unittype != "soldier" && self.unittype != "civilian" && self.unittype != "juggernaut" && self.unittype != "suicidebomber") {
    return;
  }
  _id_302E82DA1A1989AD = undefined;

  switch (_id_830A1FCFBE58BAF4) {
    case "meleeattack":
    case "meleecharge":
      _id_D9A4D73B82707003 = 0.5;
      break;
    case "flashbang":
      _id_D9A4D73B82707003 = 0.7;
      _id_302E82DA1A1989AD = 50;
      break;
    case "pain":
      _id_D9A4D73B82707003 = 0.9;
      _id_302E82DA1A1989AD = 98;
      break;
    case "seekerattack":
    case "death_quiet":
    case "flamedeath":
    case "falldeath":
    case "explodeath":
    case "incendeath":
    case "death":
      _id_D9A4D73B82707003 = 1.0;
      break;
    default:
      _id_D9A4D73B82707003 = 0.3;
      break;
  }

  if(isDefined(_id_302E82DA1A1989AD) && randomint(100) > _id_302E82DA1A1989AD) {
    return;
  }
  _id_F85C71AC24B34A53 = undefined;
  _id_DEC9BCCE93873125 = "generic_";
  _id_B4B6F604F09EDB18 = undefined;
  _id_46119EE4018A3E10 = undefined;

  if(isDefined(self.battlechatter) && isDefined(self.battlechatter.npcid)) {
    switch (self.battlechatter.npcid) {
      case "adm":
      case "slt":
      case "ksh":
      case "omr":
      case "mac":
      case "brk":
      case "eth":
        _id_B4B6F604F09EDB18 = self.battlechatter.npcid;
        _id_DEC9BCCE93873125 = "hero_";
        _id_46119EE4018A3E10 = 1;
        break;
    }
  }

  if(!isDefined(_id_B4B6F604F09EDB18)) {
    switch (self.voice) {
      case "unitednations":
      case "unitednationshelmet":
      case "fsa":
      case "unitedstates":
      case "sas":
        _id_B4B6F604F09EDB18 = "friendly";
        _id_46119EE4018A3E10 = anim.numfriendlyvoices;
        break;
      case "alqatalafemale":
      case "unitedstatesfemale":
      case "fsafemale":
      case "russianfemale":
      case "sasfemale":
      case "unitednationsfemale":
        _id_B4B6F604F09EDB18 = "friendly";
        _id_DEC9BCCE93873125 = "woman_";
        _id_46119EE4018A3E10 = anim.numfriendlyfemalevoices;
        break;
      case "c6":
        _id_B4B6F604F09EDB18 = "mummy";
        _id_46119EE4018A3E10 = 1;
        break;
      case "c8":
        _id_B4B6F604F09EDB18 = "butch";
        _id_46119EE4018A3E10 = 1;
        break;
      case "c12":
        _id_B4B6F604F09EDB18 = "swmpmon";
        _id_46119EE4018A3E10 = 1;
        break;
      default:
        _id_B4B6F604F09EDB18 = "enemy";
        _id_46119EE4018A3E10 = anim.numenemyvoices;
    }
  }

  _id_F85C71AC24B34A53 = 1 + self getentitynumber() % _id_46119EE4018A3E10;
  _id_B4B6F604F09EDB18 = _id_B4B6F604F09EDB18 + "_" + _id_F85C71AC24B34A53;
  soundalias = undefined;

  if(!isDefined(soundalias)) {
    if(isDefined(self.generic_voice_override))
      soundalias = self.generic_voice_override + "_" + _id_830A1FCFBE58BAF4 + "_" + _id_B4B6F604F09EDB18;
    else
      soundalias = _id_DEC9BCCE93873125 + _id_830A1FCFBE58BAF4 + "_" + _id_B4B6F604F09EDB18;

    if(!soundexists(soundalias))
      soundalias = "generic_" + _id_830A1FCFBE58BAF4 + "_" + _id_B4B6F604F09EDB18;
  }

  if(getdvarint("dvar_67846A0D7AA3030A", 1)) {}

  thread playfacethread(soundalias, undefined);
}

sayspecificdialogue(soundalias, notifystring) {
  thread playfacethread(soundalias, notifystring);
}

playfacethread(soundalias, notifystring) {
  if(isDefined(notifystring)) {
    if(isDefined(soundalias)) {
      playfacesound(soundalias, "animscript facesound" + notifystring, 1);
      thread waitforfacesound(notifystring);
    }
  } else
    playfacesound(soundalias);
}

playfacesound(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  if(isai(self))
    self[[anim.callbacks["PlaySoundAtViewHeight"]]](alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F);
  else if(isDefined(_id_EA3E3B2121E6713A) && isDefined(_id_9A0AFE8FF3D2508F))
    self playSound(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F);
  else if(isDefined(_id_EA3E3B2121E6713A))
    self playSound(alias, _id_EA3E3B2121E6713A);
  else
    self playSound(alias);
}

waitforfacesound(msg) {
  self endon("death");
  self waittill("animscript facesound" + msg);
  self notify(msg);
}

initlevelface() {
  anim.numenemyvoices = 7;
  anim.numfriendlyvoices = 7;
  anim.numfriendlyfemalevoices = 3;
  initfacialanims();
}

initfacialanims() {
  anim.facial = [];
}

animhasfacialoverride(_id_63DB3C9E26531938) {
  return animhasnotetrack(_id_63DB3C9E26531938, "facial_override");
}

#using_animtree("generic_human");

playfacialanim(_id_63DB3C9E26531938, _id_3A06FF8DE29AE6DE, _id_7603481BB08AE5D0) {
  if(isDefined(self.bdisabledefaultfacialanims) && self.bdisabledefaultfacialanims)
    self aiclearanim(%head, 0.2);
  else {
    if(isDefined(_id_63DB3C9E26531938) && animhasfacialoverride(_id_63DB3C9E26531938)) {
      self aiclearanim(%head, 0.2);
      return;
    }

    if(!isDefined(anim.facial[_id_3A06FF8DE29AE6DE])) {
      return;
    }
    if(isDefined(_id_7603481BB08AE5D0) && _id_7603481BB08AE5D0 >= 0 && _id_7603481BB08AE5D0 < anim.facial[_id_3A06FF8DE29AE6DE].size)
      _id_F49EE9D2911C5AB5 = _id_7603481BB08AE5D0;
    else
      _id_F49EE9D2911C5AB5 = randomint(anim.facial[_id_3A06FF8DE29AE6DE].size);

    _id_FC40661B94DE2C5C = anim.facial[_id_3A06FF8DE29AE6DE][_id_F49EE9D2911C5AB5];
    self setanimknob(_id_FC40661B94DE2C5C);
  }
}