/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_anim.gsc
***********************************************/

init() {
  scripts\common\anim::initanim();

  if(!isDefined(level.scr_viewmodelanim))
    level.scr_viewmodelanim = [];

  if(!isDefined(level.scr_eventanim))
    level.scr_eventanim = [];

  anim.callbacks["_encstr_B2A216D049519FA2AFC0821A59A1AB9789AC409D533963B3"] = ::play_sound_at_viewheight;
  anim.callbacks["_encstr_A3AD0C3C9D5812D9C256E391C205"] = ::teleport_entity;
  anim.callbacks["_encstr_A6480D47345F98017A5397D3E3F2D9"] = ::should_do_anim;
  anim.callbacks["_encstr_B63D0C4DB578B5480DDFF04BFF56"] = ::do_animation;
  anim.callbacks["_encstr_8B620D11F6230BC6D258B1A0E6D2B5"] = ::do_facial_anim;
  anim.callbacks["_encstr_A73F14974D3B5AC088B06F75C9293F0385C1D38F3F52"] = ::mp_anim_handle_notetrack;
  anim.callbacks["_encstr_822916FDC51B8BDB296B4848A344B18DF2EB55ED5AA267E0"] = ::mp_entity_handle_notetrack;
  anim.callbacks["_encstr_BAF911824A14E696B5234B9C37E819C90BB5B2"] = undefined;
}

play_sound_at_viewheight(var_0, var_1, var_2) {
  self playSound(var_0, var_1, var_2);
}

should_do_anim() {
  return 1;
}

teleport_entity(var_0, var_1) {
  if(self.code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
    self vehicle_teleport(var_0, var_1);
    self dontinterpolate();
  } else if(isPlayer(self)) {
    self setOrigin(var_0);
    self setplayerangles(var_1);
  } else {
    self.origin = var_0;
    self.angles = var_1;
    self dontinterpolate();
  }
}

do_facial_anim(var_0, var_1, var_2, var_3, var_4, var_5) {
  return 0;
}

do_animation(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(isDefined(var_5))
    var_6 = level.scr_anim[var_2][var_3][var_5];
  else
    var_6 = level.scr_anim[var_2][var_3];

  var_7 = scripts\common\anim::anim_get_goal_time(var_2, var_3);
  scripts\common\anim::last_anim_time_check();

  if(!isDefined(var_5))
    self._lastanime = var_3;

  if(self.code_classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E" && !isDefined(var_5))
    self setflaggedanim(var_4, var_6, 1, var_7);
  else {
    if(self.code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56")
      self vehicleplayanim(var_6);

    var_8 = undefined;

    if(isDefined(self.anim_getrootfunc))
      var_8 = [[self.anim_getrootfunc]]();

    var_9 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, (0, 0, 0));
    self animScripted(var_4, var_0, var_9, var_6, undefined, var_8, var_7);
  }

  thread scripts\common\notetrack::start_notetrack_wait(self, var_4, var_3, var_2, var_6);
  return getanimlength(var_6);
}

mp_anim_handle_notetrack(var_0, var_1, var_2, var_3) {
  scripts\common\notetrack::anim_handle_notetrack(var_0, var_1, var_2, var_3);

  if(isDefined(var_0["_encstr_8F7905C4EDE23F"]))
    scripts\mp\flags::gameflagset(var_0["_encstr_8F7905C4EDE23F"]);

  if(isDefined(var_0["_encstr_B26E0B1F0888E789C6A9FFE7BD"]))
    scripts\mp\flags::gameflagclear(var_0["_encstr_B26E0B1F0888E789C6A9FFE7BD"]);

  if(isDefined(var_0["_encstr_8260069BDBBACD46"])) {
    var_4 = undefined;

    if(!isDefined(var_0["_encstr_9673124FF82BE6CA2F2E83FE135F31B471E02BAB"]))
      var_4 = 1;

    var_5 = undefined;

    if(isDefined(var_0["_encstr_84A60DE355E5E0A5691F750F6BD27C"]))
      var_5 = var_0["_encstr_84A60DE355E5E0A5691F750F6BD27C"];

    var_1 thread play_snd_on_tag(var_0["_encstr_8260069BDBBACD46"], var_5);
  }
}

mp_entity_handle_notetrack(var_0, var_1) {
  if(var_0 mp_notetrack_prefix_handler(var_1))
    return;
}

mp_notetrack_prefix_handler(var_0) {
  var_1 = getsubstr(var_0, 0, 3);

  if(var_1 == "_encstr_B61904B09BAF") {
    var_2 = getsubstr(var_0, 3);

    if(isDefined(self.anim_playsound_func))
      self thread[[self.anim_playsound_func]](var_2);

    return 1;
  }

  if(var_1 == "_encstr_B41904B3B5FA") {
    var_3 = getsubstr(var_0, 3);

    if(isDefined(self.anim_playvm_func))
      self thread[[self.anim_playvm_func]](var_3);

    return 1;
  }

  if(var_1 == "_encstr_88190477B9AF") {
    var_4 = getsubstr(var_0, 3);

    if(isDefined(self.weapon_state_func))
      self thread[[self.weapon_state_func]](var_4);

    return 1;
  }

  if(var_1 == "_encstr_851904A383A0") {
    var_5 = getsubstr(var_0, 3);

    if(isDefined(self.cinematic_motion_override))
      self thread[[self.cinematic_motion_override]](var_5);

    return 1;
  }

  if(var_1 == "_encstr_831804F1A3F7") {
    var_6 = getsubstr(var_0, 3);

    if(isDefined(self.dof_func))
      self thread[[self.dof_func]](var_6);

    return 1;
  }

  return 0;
}

anim_player_solo(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("_encstr_AD75063D571AE108");
  var_6[0] = var_0;
  var_7[0] = var_1;

  if(!isDefined(var_4))
    var_4 = 0;

  anim_player(var_6, var_7, var_2, var_3, var_4, var_5);
}

anim_player(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4))
    var_4 = 0;

  anim_player_internal(var_0, var_1, var_2, var_3, var_4, var_5);
}

anim_player_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;

  foreach(var_8 in var_0) {
    var_9 = undefined;

    if(isDefined(var_5))
      var_9 = var_5;
    else
      var_9 = var_8.animname;

    if(isDefined(level.scr_eventanim[var_9]) && isDefined(level.scr_eventanim[var_9][var_2]))
      var_6 = var_8 playanimscriptsceneevent("_encstr_B8850F13491E8F3290F32417B7403FCBCD", level.scr_eventanim[var_9][var_2]);

    if(isDefined(level.scr_viewmodelanim[var_9]) && isDefined(level.scr_viewmodelanim[var_9][var_2]) && !istrue(var_8.blockviewmodelanim))
      var_8 playviewmodelanim(level.scr_viewmodelanim[var_9][var_2]);
  }

  if(isDefined(var_1))
    scripts\common\anim::anim_single(var_1, var_2, var_3, var_4, var_5);
}

play_snd_on_tag(var_0, var_1) {
  if(isDefined(var_1))
    playsoundatpos(self gettagorigin(var_1), var_0);
  else
    playsoundatpos(self.origin, var_0);
}