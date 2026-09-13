/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\targetmarkergroups.gsc
************************************************/

init() {
  level.activetargetmarkergroups = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerOnPlayerSpawnCallback"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerOnPlayerSpawnCallback")]](::targetmarkergroup_clearcacheonspawn);
}

targetmarkergroup_on(_id_21323AEE11762C98, showto, _id_65FC87A9BC280A91, _id_298022B2AFADB4BF, friendlymarker, _id_AEB2840FEDAE5220, _id_262F4B55AA151DE1) {
  if(level.activetargetmarkergroups.size >= 50) {
    return;
  }
  if(targetmarkergroup_getownedgroups(_id_298022B2AFADB4BF) >= 2) {
    return;
  }
  _id_6D7EF76A3761F0F8 = createtargetmarkergroup(_id_21323AEE11762C98);

  if(!isDefined(_id_6D7EF76A3761F0F8))
    return;
  else if(targetmarkergroupexists(_id_6D7EF76A3761F0F8)) {
    return;
  }
  addtargetmarkergroup(_id_6D7EF76A3761F0F8, showto, _id_65FC87A9BC280A91, _id_298022B2AFADB4BF, friendlymarker, _id_AEB2840FEDAE5220, _id_262F4B55AA151DE1);
  return _id_6D7EF76A3761F0F8;
}

targetmarkergroup_off(_id_4226C12910D867D4) {
  if(!targetmarkergroupexists(_id_4226C12910D867D4)) {
    return;
  }
  removetargetmarkergroup(_id_4226C12910D867D4);
  deletetargetmarkergroup(_id_4226C12910D867D4);
}

_id_32FDC90FC744999F(ent) {
  _id_729EE1CFDBE2C06E = 0;

  foreach(_id_C8462289EDFC0ACA in level.activetargetmarkergroups) {
    if(scripts\engine\utility::array_contains(_id_C8462289EDFC0ACA.showntoents, ent))
      _id_729EE1CFDBE2C06E++;
  }

  return _id_729EE1CFDBE2C06E;
}

_id_B76F204EDB67EFC7(_id_4226C12910D867D4, showto) {
  _id_C8462289EDFC0ACA = gettargetmarkergroup(_id_4226C12910D867D4);

  if(isDefined(showto)) {
    if(isPlayer(showto)) {
      if(scripts\engine\utility::array_contains(_id_C8462289EDFC0ACA.showntoents, showto)) {
        return;
      }
      if(_id_32FDC90FC744999F(showto) >= 2) {
        return;
      }
      _id_C8462289EDFC0ACA.showntoents[_id_C8462289EDFC0ACA.showntoents.size] = showto;
      addclienttotargetmarkergroupmask(_id_4226C12910D867D4, showto);
    }
  }
}

_id_09F84E910425D033(_id_4226C12910D867D4, showto) {
  _id_C8462289EDFC0ACA = gettargetmarkergroup(_id_4226C12910D867D4);

  foreach(_id_EBCDED206506E726 in showto) {
    if(isPlayer(_id_EBCDED206506E726)) {
      if(scripts\engine\utility::array_contains(_id_C8462289EDFC0ACA.showntoents, _id_EBCDED206506E726)) {
        continue;
      }
      if(_id_32FDC90FC744999F(_id_EBCDED206506E726) >= 2) {
        continue;
      }
      _id_C8462289EDFC0ACA.showntoents[_id_C8462289EDFC0ACA.showntoents.size] = _id_EBCDED206506E726;
      addclienttotargetmarkergroupmask(_id_4226C12910D867D4, _id_EBCDED206506E726);
    }
  }
}

_id_ADB80C80F10281F9(_id_4226C12910D867D4, showto) {
  _id_C8462289EDFC0ACA = gettargetmarkergroup(_id_4226C12910D867D4);

  if(isDefined(showto)) {
    if(isteam(showto)) {
      if(scripts\engine\utility::array_contains(_id_C8462289EDFC0ACA.showntoteams, showto)) {
        return;
      }
      _id_767CAC7730C2F3C2 = level.teamdata[showto]["players"];

      foreach(player in _id_767CAC7730C2F3C2) {
        if(_id_32FDC90FC744999F(player) >= 2)
          return;
      }

      _id_C8462289EDFC0ACA.showntoteams[_id_C8462289EDFC0ACA.showntoteams.size] = showto;
      addteamtotargetmarkergroupmask(_id_4226C12910D867D4, showto);
    }
  }
}

_id_AAFA0ED4A3D69B91(_id_4226C12910D867D4, showto) {
  _id_C8462289EDFC0ACA = gettargetmarkergroup(_id_4226C12910D867D4);

  foreach(_id_EBCDED206506E726 in showto) {
    if(isteam(_id_EBCDED206506E726)) {
      if(scripts\engine\utility::array_contains(_id_C8462289EDFC0ACA.showntoteams, _id_EBCDED206506E726)) {
        continue;
      }
      _id_767CAC7730C2F3C2 = level.teamdata[_id_EBCDED206506E726]["players"];

      foreach(player in _id_767CAC7730C2F3C2) {
        if(_id_32FDC90FC744999F(player) >= 2) {
          break;
        }
      }

      _id_C8462289EDFC0ACA.showntoteams[_id_C8462289EDFC0ACA.showntoteams.size] = _id_EBCDED206506E726;
      addteamtotargetmarkergroupmask(_id_4226C12910D867D4, _id_EBCDED206506E726);
    }
  }
}

_id_FD770A1099036688(_id_4226C12910D867D4, _id_065F5A4E57B38D87) {
  _id_C8462289EDFC0ACA = gettargetmarkergroup(_id_4226C12910D867D4);

  if(isDefined(_id_065F5A4E57B38D87)) {
    if(isarray(_id_065F5A4E57B38D87)) {
      foreach(_id_91CA07907A589301 in _id_065F5A4E57B38D87) {
        if(isPlayer(_id_065F5A4E57B38D87)) {
          if(scripts\engine\utility::array_contains(_id_C8462289EDFC0ACA.showntoents, _id_91CA07907A589301)) {
            _id_C8462289EDFC0ACA.showntoents = scripts\engine\utility::array_remove(_id_C8462289EDFC0ACA.showntoents, _id_91CA07907A589301);
            removeclientfromtargetmarkergroupmask(_id_4226C12910D867D4, _id_91CA07907A589301);
          }

          continue;
        }

        if(isteam(_id_065F5A4E57B38D87)) {
          if(scripts\engine\utility::array_contains(_id_C8462289EDFC0ACA.showntoteams, _id_91CA07907A589301)) {
            _id_C8462289EDFC0ACA.showntoteams = scripts\engine\utility::array_remove(_id_C8462289EDFC0ACA.showntoteams, _id_91CA07907A589301);
            removeteamfromtargetmarkergroupmask(_id_4226C12910D867D4, _id_91CA07907A589301);
          }
        }
      }
    } else if(isPlayer(_id_065F5A4E57B38D87)) {
      if(scripts\engine\utility::array_contains(_id_C8462289EDFC0ACA.showntoents, _id_065F5A4E57B38D87)) {
        _id_C8462289EDFC0ACA.showntoents = scripts\engine\utility::array_remove(_id_C8462289EDFC0ACA.showntoents, _id_065F5A4E57B38D87);
        removeclientfromtargetmarkergroupmask(_id_4226C12910D867D4, _id_065F5A4E57B38D87);
      }
    } else if(isteam(_id_065F5A4E57B38D87)) {
      if(scripts\engine\utility::array_contains(_id_C8462289EDFC0ACA.showntoteams, _id_065F5A4E57B38D87)) {
        _id_C8462289EDFC0ACA.showntoteams = scripts\engine\utility::array_remove(_id_C8462289EDFC0ACA.showntoteams, _id_065F5A4E57B38D87);
        removeteamfromtargetmarkergroupmask(_id_4226C12910D867D4, _id_065F5A4E57B38D87);
      }
    }
  }
}

addtargetmarkergroup(_id_4226C12910D867D4, showto, _id_65FC87A9BC280A91, _id_298022B2AFADB4BF, friendlymarker, _id_AEB2840FEDAE5220, _id_262F4B55AA151DE1) {
  _id_C8462289EDFC0ACA = spawnStruct();
  _id_C8462289EDFC0ACA.markerid = _id_4226C12910D867D4;
  _id_C8462289EDFC0ACA.markerowner = _id_298022B2AFADB4BF;
  _id_C8462289EDFC0ACA.friendlymarker = friendlymarker;
  _id_C8462289EDFC0ACA.showntoents = [];
  _id_C8462289EDFC0ACA.showntoteams = [];
  _id_C8462289EDFC0ACA.markedents = [];
  _id_C8462289EDFC0ACA.markedentsinqueue = [];
  level.activetargetmarkergroups[level.activetargetmarkergroups.size] = _id_C8462289EDFC0ACA;
  level thread targetmarkergroup_handlemarkingfromqueue(_id_4226C12910D867D4);

  if(isDefined(showto)) {
    if(isarray(showto)) {
      foreach(_id_EBCDED206506E726 in showto) {
        if(_id_32FDC90FC744999F(_id_EBCDED206506E726) >= 2) {
          continue;
        }
        if(isPlayer(_id_EBCDED206506E726)) {
          _id_C8462289EDFC0ACA.showntoents[_id_C8462289EDFC0ACA.showntoents.size] = _id_EBCDED206506E726;
          addclienttotargetmarkergroupmask(_id_4226C12910D867D4, _id_EBCDED206506E726);
          continue;
        }

        if(isteam(_id_EBCDED206506E726)) {
          _id_C8462289EDFC0ACA.showntoteams[_id_C8462289EDFC0ACA.showntoteams.size] = _id_EBCDED206506E726;
          addteamtotargetmarkergroupmask(_id_4226C12910D867D4, _id_EBCDED206506E726);
        }
      }
    } else if(isPlayer(showto)) {
      _id_C8462289EDFC0ACA.showntoents[_id_C8462289EDFC0ACA.showntoents.size] = showto;
      addclienttotargetmarkergroupmask(_id_4226C12910D867D4, showto);
    } else if(isteam(showto)) {
      _id_C8462289EDFC0ACA.showntoteams[_id_C8462289EDFC0ACA.showntoteams.size] = showto;
      addteamtotargetmarkergroupmask(_id_4226C12910D867D4, showto);
    }
  }

  if(isDefined(_id_65FC87A9BC280A91)) {
    if(isarray(_id_65FC87A9BC280A91)) {
      foreach(_id_CAEACF76EE56D62E in _id_65FC87A9BC280A91)
      targetmarkergroup_markentity(_id_CAEACF76EE56D62E, _id_4226C12910D867D4, _id_262F4B55AA151DE1);
    } else
      targetmarkergroup_markentity(_id_65FC87A9BC280A91, _id_4226C12910D867D4, _id_262F4B55AA151DE1);
  }

  if(istrue(_id_AEB2840FEDAE5220))
    level thread targetmarkergroup_watchmarkonspawn(_id_4226C12910D867D4, _id_262F4B55AA151DE1);

  if(istrue(_id_262F4B55AA151DE1)) {
    level thread targetmarkergroup_watchfornoscopeoutlineperkset(_id_4226C12910D867D4);
    level thread targetmarkergroup_watchfornoscopeoutlineperkunset(_id_4226C12910D867D4);
  }
}

_id_69D232B5E8C5D652(_id_4226C12910D867D4, _id_838778220EEDE9FC) {
  _id_E97B73032A8F6B63 = gettargetmarkergroup(_id_4226C12910D867D4);
  _id_E97B73032A8F6B63.markerowner = _id_838778220EEDE9FC;
}

removetargetmarkergroup(_id_4226C12910D867D4) {
  _id_1BB39B6537C2FD51 = undefined;
  _id_1AF30F69EF1607BF = [];

  foreach(_id_C8462289EDFC0ACA in level.activetargetmarkergroups) {
    if(_id_C8462289EDFC0ACA.markerid == _id_4226C12910D867D4) {
      _id_1BB39B6537C2FD51 = _id_C8462289EDFC0ACA;
      continue;
    }

    _id_1AF30F69EF1607BF[_id_1AF30F69EF1607BF.size] = _id_C8462289EDFC0ACA;
  }

  if(isDefined(_id_1BB39B6537C2FD51))
    _id_1BB39B6537C2FD51 = undefined;

  level.activetargetmarkergroups = _id_1AF30F69EF1607BF;
  level notify("removed_targetMarkerGroup_" + _id_4226C12910D867D4);
}

targetmarkergroupexists(_id_4226C12910D867D4) {
  _id_FC88D6EFF33E9D68 = 0;

  if(!isDefined(_id_4226C12910D867D4))
    return _id_FC88D6EFF33E9D68;

  foreach(_id_C8462289EDFC0ACA in level.activetargetmarkergroups) {
    if(_id_C8462289EDFC0ACA.markerid == _id_4226C12910D867D4) {
      _id_FC88D6EFF33E9D68 = 1;
      break;
    }
  }

  return _id_FC88D6EFF33E9D68;
}

gettargetmarkergroup(_id_4226C12910D867D4) {
  targetmarkergroup = undefined;

  if(!isDefined(_id_4226C12910D867D4))
    return targetmarkergroup;

  foreach(_id_C8462289EDFC0ACA in level.activetargetmarkergroups) {
    if(_id_C8462289EDFC0ACA.markerid == _id_4226C12910D867D4) {
      targetmarkergroup = _id_C8462289EDFC0ACA;
      break;
    }
  }

  return targetmarkergroup;
}

targetmarkergroup_watchmarkonspawn(_id_4226C12910D867D4, _id_262F4B55AA151DE1) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + _id_4226C12910D867D4);

  for(;;) {
    level waittill("player_spawned", player);

    if(canbemarkedingroup(_id_4226C12910D867D4, player))
      targetmarkergroup_markentity(player, _id_4226C12910D867D4, _id_262F4B55AA151DE1);
  }
}

targetmarkergroup_watchfornoscopeoutlineperkunset(_id_4226C12910D867D4) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + _id_4226C12910D867D4);

  for(;;) {
    level waittill("unset_noscopeoutline", player);

    if(canbemarkedingroup(_id_4226C12910D867D4, player))
      targetmarkergroup_markentity(player, _id_4226C12910D867D4);
  }
}

targetmarkergroup_watchfornoscopeoutlineperkset(_id_4226C12910D867D4) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + _id_4226C12910D867D4);

  for(;;) {
    level waittill("set_noscopeoutline", player);

    if(canbemarkedingroup(_id_4226C12910D867D4, player))
      targetmarkergroup_unmarkentity(player, _id_4226C12910D867D4);
  }
}

_id_74348E91568973F8() {
  _id_C1A9121CFB94FEB9 = undefined;

  if(isDefined(self) && isent(self)) {
    if(isPlayer(self) && !isbot(self))
      _id_C1A9121CFB94FEB9 = self getxuid();
    else if(isDefined(self.owner) && isPlayer(self.owner))
      _id_C1A9121CFB94FEB9 = self.owner getxuid();
    else
      _id_C1A9121CFB94FEB9 = self getentitynumber();
  }

  return _id_C1A9121CFB94FEB9;
}

targetmarkergroup_markentity(ent, _id_4226C12910D867D4, _id_262F4B55AA151DE1) {
  _id_C8462289EDFC0ACA = gettargetmarkergroup(_id_4226C12910D867D4);

  if(!isDefined(_id_C8462289EDFC0ACA)) {
    return;
  }
  entnum = ent _id_74348E91568973F8();

  if(!isDefined(entnum)) {
    return;
  }
  if(_id_C8462289EDFC0ACA.markedents.size >= 20) {
    ent targetmarkergroup_addtomarkingqueue(_id_C8462289EDFC0ACA);
    return;
  }

  if(isDefined(ent) && isPlayer(ent)) {
    if(istrue(ent._id_C4C8B91E0B16AA5E)) {
      return;
    }
    if(istrue(_id_262F4B55AA151DE1)) {
      markerowner = _id_C8462289EDFC0ACA.markerowner;
      checkteam = isDefined(_id_C8462289EDFC0ACA.friendlymarker);
      _id_5294B0C9DF040308 = istrue(_id_C8462289EDFC0ACA.friendlymarker);

      if(checkteam) {
        if(!_id_5294B0C9DF040308) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
            if(ent[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline"))
              return;
          }
        }
      } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(ent[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline"))
          return;
      }
    }
  }

  if(!scripts\engine\utility::array_contains(_id_C8462289EDFC0ACA.markedents, ent)) {
    _id_C8462289EDFC0ACA.markedents[entnum] = ent;
    targetmarkergroupaddentity(_id_4226C12910D867D4, ent);

    if(isPlayer(ent)) {
      ent thread targetmarkergroup_removefromgroupaction("death", _id_C8462289EDFC0ACA);
      ent thread targetmarkergroup_removefromgroupaction("disconnect", _id_C8462289EDFC0ACA);
      ent thread targetmarkergroup_removefromgroupaction("joined_team", _id_C8462289EDFC0ACA);
      ent thread targetmarkergroup_removefromgroupaction("enter_live_ragdoll", _id_C8462289EDFC0ACA);
    } else
      ent thread targetmarkergroup_removefromgroupaction("death", _id_C8462289EDFC0ACA);
  }
}

targetmarkergroup_removefromgroupaction(action, _id_C8462289EDFC0ACA) {
  entnum = _id_74348E91568973F8();
  _id_C8462289EDFC0ACA endon("ent_removed_" + entnum);
  level endon("removed_targetMarkerGroup_" + _id_C8462289EDFC0ACA.markerid);
  self waittill(action);
  targetmarkergroup_unmarkentity(self, _id_C8462289EDFC0ACA.markerid, entnum);
}

targetmarkergroup_addtomarkingqueue(_id_C8462289EDFC0ACA) {
  if(isDefined(self) && !scripts\engine\utility::array_contains(_id_C8462289EDFC0ACA.markedentsinqueue, self)) {
    _id_C8462289EDFC0ACA.markedentsinqueue[_id_C8462289EDFC0ACA.markedentsinqueue.size] = self;

    if(isPlayer(self))
      thread _id_38A987BAF2B61673("disconnect", _id_C8462289EDFC0ACA);
    else
      thread _id_38A987BAF2B61673("death", _id_C8462289EDFC0ACA);
  }
}

_id_38A987BAF2B61673(_id_BD2F118C743AB788, _id_C8462289EDFC0ACA) {
  level endon("game_ended");
  level endon("removed_targetMarkerGroup_" + _id_C8462289EDFC0ACA.markerid);
  self waittill(_id_BD2F118C743AB788);
  targetmarkergroup_removefrommarkingqueue(_id_C8462289EDFC0ACA);
}

targetmarkergroup_removefrommarkingqueue(_id_C8462289EDFC0ACA) {
  if(!isDefined(_id_C8462289EDFC0ACA)) {
    return;
  }
  _id_E5DAB4F107F3A279 = [];

  if(isDefined(self))
    _id_E5DAB4F107F3A279 = scripts\engine\utility::array_remove(_id_C8462289EDFC0ACA.markedentsinqueue, self);
  else
    _id_E5DAB4F107F3A279 = scripts\engine\utility::array_removeundefined(_id_C8462289EDFC0ACA.markedentsinqueue);

  _id_C8462289EDFC0ACA.markedentsinqueue = _id_E5DAB4F107F3A279;
}

targetmarkergroup_handlemarkingfromqueue(_id_D50B22F7F8CD2BC7) {
  level endon("game_ended");
  level endon("removed_targetMarkerGroup_" + _id_D50B22F7F8CD2BC7);

  while(targetmarkergroupexists(_id_D50B22F7F8CD2BC7)) {
    level waittill("ent_removed_from_marker_group", _id_568640EFC573FCCE);
    _id_C8462289EDFC0ACA = gettargetmarkergroup(_id_D50B22F7F8CD2BC7);

    if(!isDefined(_id_C8462289EDFC0ACA)) {
      break;
    }

    if(_id_568640EFC573FCCE != _id_C8462289EDFC0ACA) {
      continue;
    }
    if(_id_C8462289EDFC0ACA.markedentsinqueue.size == 0) {
      continue;
    }
    _id_C8728064DB9C260E = undefined;

    if(isDefined(_id_C8462289EDFC0ACA.markedentsinqueue[0]))
      _id_C8728064DB9C260E = _id_C8462289EDFC0ACA.markedentsinqueue[0];

    _id_C8728064DB9C260E targetmarkergroup_removefrommarkingqueue(_id_C8462289EDFC0ACA);
    targetmarkergroup_markentity(_id_C8728064DB9C260E, _id_D50B22F7F8CD2BC7);
  }
}

targetmarkergroup_unmarkentity(ent, _id_4226C12910D867D4, _id_1117512B0CAC320E) {
  entnum = ent _id_74348E91568973F8();

  if(isDefined(_id_1117512B0CAC320E))
    entnum = _id_1117512B0CAC320E;

  _id_C8462289EDFC0ACA = gettargetmarkergroup(_id_4226C12910D867D4);

  if(isDefined(_id_C8462289EDFC0ACA) && isDefined(_id_C8462289EDFC0ACA.markedents)) {
    _id_C8462289EDFC0ACA.markedents = _id_6C752E44B5090154(_id_C8462289EDFC0ACA.markedents, ent);

    if(isDefined(ent))
      targetmarkergroupremoveentity(_id_4226C12910D867D4, ent);

    _id_C8462289EDFC0ACA notify("ent_removed_" + entnum);
    level notify("ent_removed_from_marker_group", _id_C8462289EDFC0ACA);
  }
}

_id_6C752E44B5090154(markedents, _id_0A1DCB36AA55A847) {
  _id_BFC65A378A6D8EFE = [];

  foreach(_id_126F2D644585DAB2, ent in markedents) {
    if(!isDefined(ent)) {
      continue;
    }
    if(isDefined(_id_0A1DCB36AA55A847) && _id_0A1DCB36AA55A847 == ent) {
      continue;
    }
    _id_BFC65A378A6D8EFE[_id_126F2D644585DAB2] = ent;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_7C253E3D43E44097(target, _id_4226C12910D867D4) {
  entnum = target _id_74348E91568973F8();
  _id_C8462289EDFC0ACA = gettargetmarkergroup(_id_4226C12910D867D4);
  return isDefined(_id_C8462289EDFC0ACA) && isDefined(_id_C8462289EDFC0ACA.markedents) && isDefined(entnum) && isDefined(_id_C8462289EDFC0ACA.markedents[entnum]);
}

targetmarkergroup_getownedgroups(_id_298022B2AFADB4BF) {
  _id_9CEA65C4CFF49987 = 0;

  foreach(_id_C8462289EDFC0ACA in level.activetargetmarkergroups) {
    if(_id_C8462289EDFC0ACA.markerowner == _id_298022B2AFADB4BF)
      _id_9CEA65C4CFF49987++;
  }

  return _id_9CEA65C4CFF49987;
}

targetmarkergroup_clearcacheonspawn() {
  self setclientomnvar("ui_clear_target_markers", gettime());
}

isteam(showto) {
  if(showto == "spectator")
    return 1;

  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    if(showto == _id_FABF84450735DD93)
      return 1;
  }

  return 0;
}

canbemarkedingroup(_id_4226C12910D867D4, ent) {
  _id_ACA1314EBD3BB434 = 0;
  _id_C8462289EDFC0ACA = gettargetmarkergroup(_id_4226C12910D867D4);
  _id_5104555D72C8C295 = _id_C8462289EDFC0ACA.markerowner;
  checkteam = istrue(level.teambased);
  _id_5294B0C9DF040308 = istrue(_id_C8462289EDFC0ACA.friendlymarker);

  if(!isDefined(_id_5104555D72C8C295))
    return _id_ACA1314EBD3BB434;

  if(checkteam) {
    if(_id_5294B0C9DF040308) {
      if(ent.team == _id_5104555D72C8C295.team)
        _id_ACA1314EBD3BB434 = 1;
    } else if(ent.team != _id_5104555D72C8C295.team)
      _id_ACA1314EBD3BB434 = 1;
  } else if(_id_5294B0C9DF040308) {
    if(ent == _id_5104555D72C8C295)
      _id_ACA1314EBD3BB434 = 1;
  } else if(ent != _id_5104555D72C8C295)
    _id_ACA1314EBD3BB434 = 1;

  return _id_ACA1314EBD3BB434;
}