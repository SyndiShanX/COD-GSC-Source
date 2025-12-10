/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\gib.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\destructible_character;
#using scripts\shared\ai\systems\shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\throttle_shared;
#namespace gib;

function private fields_equal(field_a, field_b) {
  if(!isDefined(field_a) && !isDefined(field_b)) {
    return true;
  }
  if(isDefined(field_a) && isDefined(field_b) && field_a == field_b) {
    return true;
  }
  return false;
}

function private _isdefaultplayergib(gibpieceflag, gibstruct) {
  if(!fields_equal(level.playergibbundle.gibs[gibpieceflag].gibdynentfx, gibstruct.gibdynentfx)) {
    return false;
  }
  if(!fields_equal(level.playergibbundle.gibs[gibpieceflag].gibfxtag, gibstruct.gibfxtag)) {
    return false;
  }
  if(!fields_equal(level.playergibbundle.gibs[gibpieceflag].gibfx, gibstruct.gibfx)) {
    return false;
  }
  if(!fields_equal(level.playergibbundle.gibs[gibpieceflag].gibtag, gibstruct.gibtag)) {
    return false;
  }
  return true;
}

function autoexec main() {
  clientfield::register("actor", "gib_state", 1, 9, "int");
  clientfield::register("playercorpse", "gib_state", 1, 15, "int");
  gibdefinitions = struct::get_script_bundles("gibcharacterdef");
  gibpiecelookup = [];
  gibpiecelookup[2] = "annihilate";
  gibpiecelookup[8] = "head";
  gibpiecelookup[16] = "rightarm";
  gibpiecelookup[32] = "leftarm";
  gibpiecelookup[128] = "rightleg";
  gibpiecelookup[256] = "leftleg";
  processedbundles = [];
  if(sessionmodeismultiplayergame()) {
    level.playergibbundle = spawnStruct();
    level.playergibbundle.gibs = [];
    level.playergibbundle.name = "default_player";
    level.playergibbundle.gibs[2] = spawnStruct();
    level.playergibbundle.gibs[8] = spawnStruct();
    level.playergibbundle.gibs[32] = spawnStruct();
    level.playergibbundle.gibs[256] = spawnStruct();
    level.playergibbundle.gibs[16] = spawnStruct();
    level.playergibbundle.gibs[128] = spawnStruct();
    level.playergibbundle.gibs[2].gibfxtag = "j_spinelower";
    level.playergibbundle.gibs[2].gibfx = "blood/fx_blood_impact_exp_body_lg";
    level.playergibbundle.gibs[32].gibmodel = "c_t7_mp_battery_mpc_body1_s_larm";
    level.playergibbundle.gibs[32].gibdynentfx = "blood/fx_blood_gib_limb_trail_emitter";
    level.playergibbundle.gibs[32].gibfxtag = "j_elbow_le";
    level.playergibbundle.gibs[32].gibfx = "blood/fx_blood_gib_arm_sever_burst";
    level.playergibbundle.gibs[32].gibtag = "j_elbow_le";
    level.playergibbundle.gibs[256].gibmodel = "c_t7_mp_battery_mpc_body1_s_lleg";
    level.playergibbundle.gibs[256].gibdynentfx = "blood/fx_blood_gib_limb_trail_emitter";
    level.playergibbundle.gibs[256].gibfxtag = "j_knee_le";
    level.playergibbundle.gibs[256].gibfx = "blood/fx_blood_gib_leg_sever_burst";
    level.playergibbundle.gibs[256].gibtag = "j_knee_le";
    level.playergibbundle.gibs[16].gibmodel = "c_t7_mp_battery_mpc_body1_s_rarm";
    level.playergibbundle.gibs[16].gibdynentfx = "blood/fx_blood_gib_limb_trail_emitter";
    level.playergibbundle.gibs[16].gibfxtag = "j_elbow_ri";
    level.playergibbundle.gibs[16].gibfx = "blood/fx_blood_gib_arm_sever_burst_rt";
    level.playergibbundle.gibs[16].gibtag = "j_elbow_ri";
    level.playergibbundle.gibs[128].gibmodel = "c_t7_mp_battery_mpc_body1_s_rleg";
    level.playergibbundle.gibs[128].gibdynentfx = "blood/fx_blood_gib_limb_trail_emitter";
    level.playergibbundle.gibs[128].gibfxtag = "j_knee_ri";
    level.playergibbundle.gibs[128].gibfx = "blood/fx_blood_gib_leg_sever_burst_rt";
    level.playergibbundle.gibs[128].gibtag = "j_knee_ri";
  }
  foreach(definitionname, definition in gibdefinitions) {
    gibbundle = spawnStruct();
    gibbundle.gibs = [];
    gibbundle.name = definitionname;
    default_player = 0;
    foreach(gibpieceflag, gibpiecename in gibpiecelookup) {
      gibstruct = spawnStruct();
      gibstruct.gibmodel = getstructfield(definition, gibpiecelookup[gibpieceflag] + "_gibmodel");
      gibstruct.gibtag = getstructfield(definition, gibpiecelookup[gibpieceflag] + "_gibtag");
      gibstruct.gibfx = getstructfield(definition, gibpiecelookup[gibpieceflag] + "_gibfx");
      gibstruct.gibfxtag = getstructfield(definition, gibpiecelookup[gibpieceflag] + "_gibeffecttag");
      gibstruct.gibdynentfx = getstructfield(definition, gibpiecelookup[gibpieceflag] + "_gibdynentfx");
      gibstruct.gibsound = getstructfield(definition, gibpiecelookup[gibpieceflag] + "_gibsound");
      gibstruct.gibhidetag = getstructfield(definition, gibpiecelookup[gibpieceflag] + "_gibhidetag");
      if(sessionmodeismultiplayergame() && _isdefaultplayergib(gibpieceflag, gibstruct)) {
        default_player = 1;
      }
      gibbundle.gibs[gibpieceflag] = gibstruct;
    }
    if(sessionmodeismultiplayergame() && default_player) {
      processedbundles[definitionname] = level.playergibbundle;
      continue;
    }
    processedbundles[definitionname] = gibbundle;
  }
  level.scriptbundles["gibcharacterdef"] = processedbundles;
  if(!isDefined(level.gib_throttle)) {
    level.gib_throttle = new throttle();
    [[level.gib_throttle]] - > initialize(2, 0.2);
  }
}

#namespace gibserverutils;

function private _annihilate(entity) {
  if(isDefined(entity)) {
    entity notsolid();
  }
}

function private _getgibextramodel(entity, gibflag) {
  if(gibflag == 4) {
    return (isDefined(entity.gib_data) ? entity.gib_data.hatmodel : entity.hatmodel);
  }
  if(gibflag == 8) {
    return (isDefined(entity.gib_data) ? entity.gib_data.head : entity.head);
  }
  assertmsg("");
}

function private _gibextra(entity, gibflag) {
  if(isgibbed(entity, gibflag)) {
    return false;
  }
  if(!_hasgibdef(entity)) {
    return false;
  }
  entity thread _gibextrainternal(entity, gibflag);
  return true;
}

function private _gibextrainternal(entity, gibflag) {
  if(entity.gib_time !== gettime()) {
    [[level.gib_throttle]] - > waitinqueue(entity);
  }
  if(!isDefined(entity)) {
    return;
  }
  entity.gib_time = gettime();
  if(isgibbed(entity, gibflag)) {
    return false;
  }
  if(gibflag == 8) {
    if(isDefined((isDefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5))) {
      entity attach((isDefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5), "", 1);
    }
  }
  _setgibbed(entity, gibflag, undefined);
  destructserverutils::showdestructedpieces(entity);
  showhiddengibpieces(entity);
  gibmodel = _getgibextramodel(entity, gibflag);
  if(isDefined(gibmodel)) {
    entity detach(gibmodel, "");
  }
  destructserverutils::reapplydestructedpieces(entity);
  reapplyhiddengibpieces(entity);
}

function private _gibentity(entity, gibflag) {
  if(isgibbed(entity, gibflag) || !_hasgibpieces(entity, gibflag)) {
    return false;
  }
  if(!_hasgibdef(entity)) {
    return false;
  }
  entity thread _gibentityinternal(entity, gibflag);
  return true;
}

function private _gibentityinternal(entity, gibflag) {
  if(entity.gib_time !== gettime()) {
    [[level.gib_throttle]] - > waitinqueue(entity);
  }
  if(!isDefined(entity)) {
    return;
  }
  entity.gib_time = gettime();
  if(isgibbed(entity, gibflag)) {
    return;
  }
  destructserverutils::showdestructedpieces(entity);
  showhiddengibpieces(entity);
  if(!_getgibbedstate(entity) < 16) {
    legmodel = _getgibbedlegmodel(entity);
    entity detach(legmodel);
  }
  _setgibbed(entity, gibflag, undefined);
  entity setModel(_getgibbedtorsomodel(entity));
  entity attach(_getgibbedlegmodel(entity));
  destructserverutils::reapplydestructedpieces(entity);
  reapplyhiddengibpieces(entity);
}

function private _getgibbedlegmodel(entity) {
  gibstate = _getgibbedstate(entity);
  rightleggibbed = gibstate & 128;
  leftleggibbed = gibstate & 256;
  if(rightleggibbed && leftleggibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.legdmg4 : entity.legdmg4);
  }
  if(rightleggibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.legdmg2 : entity.legdmg2);
  }
  if(leftleggibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.legdmg3 : entity.legdmg3);
  }
  return (isDefined(entity.gib_data) ? entity.gib_data.legdmg1 : entity.legdmg1);
}

function private _getgibbedstate(entity) {
  if(isDefined(entity.gib_state)) {
    return entity.gib_state;
  }
  return 0;
}

function private _getgibbedtorsomodel(entity) {
  gibstate = _getgibbedstate(entity);
  rightarmgibbed = gibstate & 16;
  leftarmgibbed = gibstate & 32;
  if(rightarmgibbed && leftarmgibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.torsodmg2 : entity.torsodmg2);
  }
  if(rightarmgibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.torsodmg2 : entity.torsodmg2);
  }
  if(leftarmgibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.torsodmg3 : entity.torsodmg3);
  }
  return (isDefined(entity.gib_data) ? entity.gib_data.torsodmg1 : entity.torsodmg1);
}

function private _hasgibdef(entity) {
  return isDefined(entity.gibdef);
}

function private _hasgibpieces(entity, gibflag) {
  hasgibpieces = 0;
  gibstate = _getgibbedstate(entity);
  entity.gib_state = gibstate | (gibflag &(512 - 1));
  if(isDefined(_getgibbedtorsomodel(entity)) && isDefined(_getgibbedlegmodel(entity))) {
    hasgibpieces = 1;
  }
  entity.gib_state = gibstate;
  return hasgibpieces;
}

function private _setgibbed(entity, gibflag, gibdir) {
  if(isDefined(gibdir)) {
    angles = vectortoangles(gibdir);
    yaw = angles[1];
    yaw_bits = getbitsforangle(yaw, 3);
    entity.gib_state = (_getgibbedstate(entity) | (gibflag &(512 - 1))) + (yaw_bits << 9);
  } else {
    entity.gib_state = _getgibbedstate(entity) | (gibflag &(512 - 1));
  }
  entity.gibbed = 1;
  entity clientfield::set("gib_state", entity.gib_state);
}

function annihilate(entity) {
  if(!_hasgibdef(entity)) {
    return false;
  }
  gibbundle = struct::get_script_bundle("gibcharacterdef", entity.gibdef);
  if(!isDefined(gibbundle) || !isDefined(gibbundle.gibs)) {
    return false;
  }
  gibpiecestruct = gibbundle.gibs[2];
  if(isDefined(gibpiecestruct)) {
    if(isDefined(gibpiecestruct.gibfx)) {
      _setgibbed(entity, 2, undefined);
      entity thread _annihilate(entity);
      return true;
    }
  }
  return false;
}

function copygibstate(originalentity, newentity) {
  newentity.gib_state = _getgibbedstate(originalentity);
  togglespawngibs(newentity, 0);
  reapplyhiddengibpieces(newentity);
}

function isgibbed(entity, gibflag) {
  return _getgibbedstate(entity) &gibflag;
}

function gibhat(entity) {
  return _gibextra(entity, 4);
}

function gibhead(entity) {
  gibhat(entity);
  return _gibextra(entity, 8);
}

function gibleftarm(entity) {
  if(isgibbed(entity, 16)) {
    return false;
  }
  if(_gibentity(entity, 32)) {
    destructserverutils::destructleftarmpieces(entity);
    return true;
  }
  return false;
}

function gibrightarm(entity) {
  if(isgibbed(entity, 32)) {
    return false;
  }
  if(_gibentity(entity, 16)) {
    destructserverutils::destructrightarmpieces(entity);
    entity thread shared::dropaiweapon();
    return true;
  }
  return false;
}

function gibleftleg(entity) {
  if(_gibentity(entity, 256)) {
    destructserverutils::destructleftlegpieces(entity);
    return true;
  }
  return false;
}

function gibrightleg(entity) {
  if(_gibentity(entity, 128)) {
    destructserverutils::destructrightlegpieces(entity);
    return true;
  }
  return false;
}

function giblegs(entity) {
  if(_gibentity(entity, 384)) {
    destructserverutils::destructrightlegpieces(entity);
    destructserverutils::destructleftlegpieces(entity);
    return true;
  }
  return false;
}

function playergibleftarm(entity) {
  if(isDefined(entity.body)) {
    dir = (1, 0, 0);
    _setgibbed(entity.body, 32, dir);
  }
}

function playergibrightarm(entity) {
  if(isDefined(entity.body)) {
    dir = (1, 0, 0);
    _setgibbed(entity.body, 16, dir);
  }
}

function playergibleftleg(entity) {
  if(isDefined(entity.body)) {
    dir = (1, 0, 0);
    _setgibbed(entity.body, 256, dir);
  }
}

function playergibrightleg(entity) {
  if(isDefined(entity.body)) {
    dir = (1, 0, 0);
    _setgibbed(entity.body, 128, dir);
  }
}

function playergiblegs(entity) {
  if(isDefined(entity.body)) {
    dir = (1, 0, 0);
    _setgibbed(entity.body, 128, dir);
    _setgibbed(entity.body, 256, dir);
  }
}

function playergibleftarmvel(entity, dir) {
  if(isDefined(entity.body)) {
    _setgibbed(entity.body, 32, dir);
  }
}

function playergibrightarmvel(entity, dir) {
  if(isDefined(entity.body)) {
    _setgibbed(entity.body, 16, dir);
  }
}

function playergibleftlegvel(entity, dir) {
  if(isDefined(entity.body)) {
    _setgibbed(entity.body, 256, dir);
  }
}

function playergibrightlegvel(entity, dir) {
  if(isDefined(entity.body)) {
    _setgibbed(entity.body, 128, dir);
  }
}

function playergiblegsvel(entity, dir) {
  if(isDefined(entity.body)) {
    _setgibbed(entity.body, 128, dir);
    _setgibbed(entity.body, 256, dir);
  }
}

function reapplyhiddengibpieces(entity) {
  if(!_hasgibdef(entity)) {
    return;
  }
  gibbundle = struct::get_script_bundle("gibcharacterdef", entity.gibdef);
  foreach(gibflag, gib in gibbundle.gibs) {
    if(!isgibbed(entity, gibflag)) {
      continue;
    }
    if(isDefined(gib.gibhidetag) && isalive(entity) && entity haspart(gib.gibhidetag)) {
      if(!(isDefined(entity.skipdeath) && entity.skipdeath)) {
        entity hidepart(gib.gibhidetag, "", 1);
      }
    }
  }
}

function showhiddengibpieces(entity) {
  if(!_hasgibdef(entity)) {
    return;
  }
  gibbundle = struct::get_script_bundle("gibcharacterdef", entity.gibdef);
  foreach(gib in gibbundle.gibs) {
    if(isDefined(gib.gibhidetag) && entity haspart(gib.gibhidetag)) {
      entity showpart(gib.gibhidetag, "", 1);
    }
  }
}

function togglespawngibs(entity, shouldspawngibs) {
  if(!shouldspawngibs) {
    entity.gib_state = _getgibbedstate(entity) | 1;
  } else {
    entity.gib_state = _getgibbedstate(entity) &-2;
  }
  entity clientfield::set("gib_state", entity.gib_state);
}